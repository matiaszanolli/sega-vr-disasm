# Virtua Racing 32X — Optimization Strategy

**Version:** v7.0 (reassessed)
**Last Updated:** March 10, 2026
**Baseline:** ~20-24 FPS (measured, scene-dependent)
**Primary Target:** 30 FPS (+50%)
**Stretch Goal:** 60 FPS (requires pipeline overlap — see analysis below)
**Approach:** Data-driven, 68K-bottleneck-first

---

## Ground Truth

### The 68K Is THE Bottleneck (Proven)

Profiling (January–March 2026) conclusively proved that the 68000 CPU is the sole performance constraint. No amount of SH2 optimization can improve FPS.

**Evidence:**
1. 68K runs at **100.1% utilization** (127,987 cycles/frame @ 7.67 MHz) — completely saturated
2. Eliminating **66.6% of Slave SH2 work** produced **0% FPS improvement** (delay loop experiment)
3. Reducing command overhead from ~22% to ~10.8% (B-003/B-004/B-005) produced **0% FPS improvement**

### CPU Utilization

| CPU | Cycles/Frame | Utilization | Role |
|-----|-------------|-------------|------|
| **68000** | **127,987** | **100.1%** | **BOTTLENECK — orchestrates entire pipeline** |
| Master SH2 | 0–157,286 | 0–41% | Mostly idle (0% with hooks off, 41% with PC profiling) |
| Slave SH2 | 296,112–306,989 | 77–80% | 3D rendering (33.5% useful, 66.5% idle loop) |

### 68K Time Breakdown (PC Profiling, March 2026)

```
 49.4%  V-blank sync polling (TST.W VINT_STATE.w at $FF0010/$FF0014)
        ├─ BIOS adapter main loop waiting for V-blank between frame iterations
        └─ NOT eliminable — hardware frame synchronization barrier

 10.8%  SH2 command overhead (COMM polling)
        ├─ sh2_cmd_27 COMM7 waits: 21.7% of useful work (see Track A)
        ├─ sh2_send_cmd overhead: ~2,380 cyc/frame
        └─ Reduced from ~22% by B-003/B-004/B-005

 39.8%  Useful game logic
        ├─ Angle normalization: 4.5%
        ├─ depth_sort: 4.2%
        ├─ Physics integration: 3.8%
        ├─ AI opponent selection: 2.6%
        ├─ Sine/cosine lookup: 2.0%
        ├─ Rotational calc: 2.0%
        └─ Everything else: 20.7%
```

### FPS Threshold Model

The game takes N TV frames per game frame. Reducing useful 68K work per game frame crosses thresholds:

```
Current state:   3 TV frames/game frame → ~20 FPS
                 Useful work: ~152,900 cycles/game frame

30 FPS target:   2 TV frames/game frame
                 Need: ~33% reduction in useful work (~50,500 cycles saved)

60 FPS target:   1 TV frame/game frame
                 Need: ~67% reduction in useful work (~102,400 cycles saved)
```

**Key insight:** FPS improvements are discrete — we need to cross a threshold from 3 to 2 TV frames, not achieve continuous improvement. Small savings that don't cross the threshold produce 0% FPS gain (as proven by B-003/B-004/B-005).

---

## Completed Work

| Task | What | Cycles Saved | FPS Impact |
|------|------|-------------|------------|
| B-003 | Async cmd_27 via Slave COMM7 doorbell | ~4,000/frame (from Master SH2 dispatch) | 0% |
| B-004 | Single-shot cmd_22 (expansion ROM handler) | ~1,792/frame | 0% |
| B-005 | Single-shot cmd_25 (scene init only) | Minimal | 0% |
| B-008 | RV bit profiling — never set, expansion ROM safe | N/A (blocker removed) | 0% |
| B-009 | FIFO burst analysis — not feasible | N/A (approach disproved) | 0% |
| **Total** | Command overhead: ~12,000 → ~3,850 cyc/frame | **~8,150/frame** | **0%** |

**Why 0% FPS gain:** The 68K saved ~8,150 cycles of COMM overhead but is still 100% utilized. The saved time was absorbed into V-blank polling (the 68K finishes slightly earlier in each TV frame, then polls V-blank slightly longer). To gain FPS, total game-frame time must cross the 3→2 TV frame threshold.

### Key Lessons from Completed Work

1. **COMM offload cost model:** Synchronous offload of small, frequently-called functions via COMM registers is **anti-productive**. `angle_normalize` (8×/frame, ~1,500 cyc native) added 23% 68K overhead from COMM0_HI polling. Rule: `computation_cycles >> handshake_overhead × call_count`. Batch or async required.

2. **Fire-and-forget is blocked:** COMM0_HI is the game's frame synchronization barrier. Removing it desynchronizes the 68K/SH2 frame pipeline → display corruption. The .wait_ready poll in sh2_send_cmd is implicit load-balancing.

3. **SH2-only optimization cannot improve FPS:** 66.6% Slave reduction → 0% FPS change. Definitively proven by delay loop experiment.

4. **In-place replacement works:** B-003/B-004 proved that function bodies can be replaced within their existing footprint (82B/90B respectively). No additional 68K section space needed.

---

## Active Tracks

### Track A: cmd_27 Queue Decoupling — HIGHEST PRIORITY

**Goal:** Eliminate 21.7% of useful 68K work (sh2_cmd_27 COMM7 waits)
**Expected savings:** ~33,000 cycles/game frame
**Risk:** Medium

#### The Problem

Even after B-003's direct-to-Slave conversion, sh2_cmd_27 still accounts for **21.7% of useful 68K work**. The 68K polls COMM7 waiting for the Slave to finish each pixel fill before sending the next entry. With 21 calls/frame and ~1,580 68K cycles per wait, this is the single largest optimization lever remaining.

The root cause: COMM2-6 registers are shared between entries. The 68K cannot overwrite them until the Slave has read the current entry's parameters.

#### The Solution: Master SH2 as Fast DMA Proxy

Use the idle Master SH2 (0% utilization) as a fast intermediary between the 68K and an SDRAM ring buffer. The Slave processes entries from SDRAM independently.

```
Current (B-003):                          Proposed (Track A):
68K                    Slave              68K          Master SH2       Slave
 |                      |                 |              |               |
 |-- COMM2-6 params -->|                  |-- COMM2-6 ->|               |
 |-- COMM7=$0027 ----->|                  |-- trigger ->|               |
 |   WAIT COMM7==0 ... |-- process        |  (return)   |-- copy to     |
 |   (1,580 cycles!)   |-- pixels         |             |   SDRAM queue  |
 |<- COMM7=$0000 ------|                  |             |-- signal ----->|
 |                      |                 |             |               |-- drain from
 |-- next entry...      |                 |-- next...   |               |   SDRAM queue
                                          | (~30 cyc!)  |               |
```

**Per-entry cost comparison:**
- Current: ~1,580 68K cycles (wait for Slave pixel processing)
- Proposed: ~10-30 68K cycles (COMM write + wait for Master SH2 copy)
- Master SH2 copy time: ~20-30 SH2 cycles (5 loads + 5 stores to SDRAM)

#### Architecture

```
SDRAM Ring Buffer ($0203F000, 32 entries × 12 bytes = 384 bytes):
  Entry: data_ptr[4] + width[2] + height[2] + add_value[2] + padding[2]
  Write pointer: SDRAM variable (Master SH2 updates)
  Read pointer: SDRAM variable (Slave updates)

68K (sh2_cmd_27 replacement):
  1. Write params to COMM2-6 (same as B-003)
  2. Trigger Master SH2 (COMM0 or CMDINT)
  3. Wait for Master to read COMM registers (~10-30 68K cycles)
  4. Return immediately

Master SH2 (new handler in expansion ROM):
  1. Read COMM2-6
  2. Store entry to SDRAM ring buffer at write_ptr
  3. Increment write_ptr
  4. Signal "params read" to 68K
  5. Signal Slave if queue was empty (COMM7 or direct)

Slave SH2 (modified inline_slave_drain):
  1. Check SDRAM queue (read_ptr != write_ptr)
  2. Read entry from SDRAM at read_ptr
  3. Process pixels (same as current)
  4. Increment read_ptr
  5. Loop until queue empty

Frame sync (before buffer flip):
  68K polls: SDRAM read_ptr == write_ptr (all entries processed)
```

#### Key Constraints

- 68K cannot write directly to SDRAM — all data flows through COMM registers
- Master SH2 must read COMM registers before 68K overwrites them for next entry
- Slave processes from SDRAM, not COMM registers — completely decoupled from 68K
- Frame-end sync required before buffer flip (queue must be drained)

#### Critical Files

| File | Changes |
|------|---------|
| `disasm/sections/code_e200.asm` | sh2_cmd_27 body replacement (68K→Master trigger) |
| `disasm/sections/code_20200.asm` | Master dispatch jump table entry for new handler |
| `disasm/sections/expansion_300000.asm` | New Master SH2 queue handler |
| `disasm/sh2/expansion/inline_slave_drain.asm` | Modify to read from SDRAM queue |

---

### Track B: Batched Work Offload to Master SH2 — HIGH PRIORITY

**Goal:** Offload ~12% of useful 68K work via batched COMM commands
**Expected savings:** ~18,000 cycles/game frame
**Risk:** Medium-High

#### The Problem

The Master SH2 is completely idle (0% utilization). Meanwhile, the 68K is saturated with pure-math computation (angle normalization, physics, trigonometry) that could run on the SH2.

**Synchronous offload has been proven anti-productive** (23% overhead for angle_normalize). The solution: accumulate inputs during the frame, send them as a single batch, wait once for all results.

#### Offload Candidates

**Tier 1 — Pure math, no data marshaling:**

| Function | Address | Useful Share | Calls/Frame | Input | Output |
|----------|---------|-------------|-------------|-------|--------|
| `angle_normalize` | $00748C | 4.5% | 8 | D1,D2,A1 (ROM BSP) | D0 |
| `sine_cosine_quadrant_lookup` | $008F4E | 2.0% | ~20 | D0 (angle) | D0 |

Combined: 6.5% of useful work. Register I/O, ROM-only data access. Directly reimplementable in SH2 expansion ROM.

**Tier 2 — Requires entity data marshaling:**

| Function | Address | Useful Share | Data Dependency |
|----------|---------|-------------|----------------|
| `physics_integration` | $00A666 | 3.8% | Entity struct @ Work RAM (+$06/+$30/+$34/+$40/+$54) |
| `rotational_offset_calc` | $00764E | 2.0% | Entity struct @ Work RAM (+$1E/+$20/+$22/+$30/+$34/+$72/+$E2) |

Combined: 5.8% of useful work. Both read/write entity fields in 68K Work RAM ($FFxxxx), which SH2 cannot access. Offloading requires 68K to copy relevant fields to SDRAM scratchpad, signal SH2, then read results back.

#### Batching Protocol

```
68K (during frame):
  1. Accumulate inputs in Work RAM array (e.g., 8 × angle_normalize params)
  2. At batch sync point: send count + inputs via COMM registers
     - Multiple COMM exchanges needed (10 bytes per exchange)
     - BUT: 1 handshake per batch, not N handshakes per N inputs
  3. Wait for Master SH2 to complete all computations
  4. Read results from COMM registers or SDRAM scratchpad

Master SH2 (expansion ROM handler):
  1. Read batch from COMM registers (or SDRAM if 68K wrote there)
  2. Compute all N results
  3. Write results to SDRAM scratchpad
  4. Signal completion to 68K
```

**Key constraint:** The COMM handshake must be amortized. For angle_normalize (8 calls):
- Synchronous: 8 handshakes × ~500 cyc = 4,000 cycles overhead → **WORSE** (proven)
- Batched: 1 handshake + 8 × ~50 cyc COMM transfer = ~900 cycles → **viable**

#### Implementation Order

1. **angle_normalize** — pure math, no marshaling, highest confidence
2. **sine/cosine** — table lookup, ROM accessible from SH2
3. **physics_integration** — requires SDRAM scratchpad design for entity fields
4. **rotational_offset_calc** — same marshaling infrastructure as physics

---

### Track C: Pipeline Overlap — STRETCH GOAL

**Goal:** Allow 68K to prepare frame N+1 while SH2 renders frame N
**Expected savings:** Theoretical +50-100% (halves effective frame time)
**Risk:** Very High
**Prerequisites:** Tracks A+B working, 30 FPS achieved

#### Concept

```
Current (serialized):
Frame N:     68K prepares ──→ SH2 renders ──→ complete
Frame N+1:                                    68K prepares ──→ SH2 renders

With overlap:
Frame N:     68K prepares ──→ SH2 renders ────────────────→ complete
Frame N+1:                    68K prepares ──→ SH2 renders → complete
                              ↑ overlap ↑
```

#### Requirements

- Double-buffered command data in SDRAM (two sets of all COMM parameters)
- Deep analysis of frame data dependencies (which data changes between frames?)
- All shared state between 68K and SH2 must be versioned or double-buffered
- Accept +1 frame input latency (acceptable trade-off for 2× FPS)

#### Status

Research only. No implementation planned until 30 FPS is achieved via Tracks A+B.

---

## Retired Tracks

| Former Track | Status | Reason |
|-------------|--------|--------|
| Track 1 (68K Blocking Relief) | Subsumed by Track A | Original CMDINT queue design was over-engineered; B-003/B-004/B-005 captured protocol savings |
| Track 2 (Command Protocol) | DONE | Command overhead at 3.1%. No further reduction viable. |
| Track 5 (VDP Polling) | Deferred | Only relevant if SH2 becomes bottleneck after Tracks A+B |
| Track 6 (SH2 Micro-Opts) | Low priority | 0% FPS impact. SH2 is not the constraint. |
| B-006 (Parallel Hooks) | REVERTED | Fundamental flaws: COMM7 namespace collision, literal pool corruption, R0 clobber. Dual-SH2 rendering needs completely new approach. |

---

## FPS Target Analysis

### 30 FPS — Primary Target (Achievable)

| Lever | Useful Work Reduction | Cycles Saved/Game Frame |
|-------|----------------------|------------------------|
| Track A: cmd_27 queue decoupling | 21.7% | ~33,000 |
| Track B: batched offload (angle + trig) | 6.5% | ~9,900 |
| Track B: batched offload (physics + rotational) | 5.8% | ~8,900 |
| **Total** | **34.0%** | **~51,800** |

**Threshold for 30 FPS:** ~33% reduction (~50,500 cycles). Total of 34.0% **just crosses the threshold**.

Track A alone provides 21.7% — significant but not sufficient. Both tracks are required.

### 60 FPS — Stretch Goal (Requires Track C)

| Source | Useful Work Reduction |
|--------|-----------------------|
| Tracks A+B | 34.0% |
| depth_sort offload (maybe) | 4.2% |
| AI offload (difficult) | 2.6% |
| **Subtotal** | **~40.8%** |
| **Gap to 67%** | **~26.2%** |

The 26.2% gap can only be closed by:
- **Pipeline overlap (Track C):** Halves effective frame time — the only realistic path
- **Game loop restructuring:** Reduce V-blank sync points — extremely invasive

**Verdict:** 60 FPS is not achievable through offloading alone. Requires Track C (pipeline overlap) which is high-risk and needs deep frame dependency analysis.

---

## Expansion ROM Status

```
$300000-$3FFFFF  1MB expansion space (SH2-executable only)

Active handlers (~1.8 KB used):
  $300500  cmd25_single_shot (64B) — B-005
  $300600  cmd27_queue_drain (128B) — B-003 (dormant, superseded by inline drain)
  $300700  slave_comm7_idle_check (48B) — B-003
  $3010F0  cmd22_single_shot (108B) — B-004

Dormant infrastructure:
  $300028  handler_frame_sync (22B)
  $300050  master_dispatch_hook (44B) — B-006 (reverted, dead code)
  $300100  vertex_transform_optimized (96B)
  $300200  slave_work_wrapper (76B) — B-006 (reverted, dead code)
  $300800  cmdint_handler (64B) — reserved
  $300C00  queue_processor (128B) — reserved
  $301000  general_queue_drain (240B) — dormant
  $301178  angle_normalize SH2 handler (dormant, cmd $30)

Free: ~1,046 KB (99.9%)
```

---

## Abandoned Approaches

| Approach | Why It Failed | Lesson |
|----------|--------------|--------|
| Synchronous COMM offload (angle_normalize) | Handshake overhead 25× > computation saved. COMM0_HI is global busy flag. | Only offload when `computation >> handshake × call_count`. Batch required. |
| Fire-and-forget cmd_22 | COMM0_HI is frame sync barrier. Removing it → display corruption. | The .wait_ready poll is implicit load-balancing, not just overhead. |
| Blanket async general commands | Buffer aliasing — 68K overwrites shared buffers before SH2 replays COMM. | Async requires per-call-site data dependency analysis. |
| B-006 parallel hooks (3 patches) | COMM7 namespace collision (game cmd 0x27 = expansion signal), literal pool corruption at $020480, R0 clobber. | Never conflate game and expansion namespaces. Test patches in isolation. |
| Work RAM ring buffer for SH2 | SH2 cannot access 68K Work RAM ($FFxxxx) at any address. 3 failed attempts. | Always check hardware manual memory map first. |
| 68K in-section async queue | 0 bytes free in $E200 section. | Use in-place replacement or expansion ROM instead. |
| SH2-only optimization for FPS | 66.6% Slave reduction → 0% FPS change. 68K is the bottleneck. | Measure before optimizing. Profile-driven only. |
| FIFO burst optimization (B-009) | func_065 writes SDRAM not framebuffer; edge_scan has scattered writes. | Static analysis before implementation. |
| Code injection via ROM patcher | Space/alignment limits in packed ROM. | Use full assembly build approach. |

---

## Profiling

### Tools

| Tool | Purpose | Status |
|------|---------|--------|
| `profiling_frontend` | Headless libretro frontend (frame-level profiling) | Working |
| `picodrive_libretro.so` | Custom PicoDrive core with instrumentation | Working |
| `analyze_profile.py` | Frame-level analysis (68K/MSH2/SSH2 cycles) | Working |
| `analyze_pc_profile.py` | PC-level hotspot analysis + function name resolution | Working |

### Quick Start

```bash
cd tools/libretro-profiling

# Frame-level profiling (1800 frames = 30 seconds)
./profiling_frontend ../../build/vr_rebuild.32x 1800 --autoplay

# PC-level hotspot profiling
VRD_PROFILE_PC=1 VRD_PROFILE_PC_LOG=profile.csv \
./profiling_frontend ../../build/vr_rebuild.32x 2400 --autoplay
python3 analyze_pc_profile.py profile.csv
```

### Reference Measurements

| Configuration | 68K | Master SH2 | Slave SH2 | Date |
|--------------|-----|-----------|-----------|------|
| Baseline (hooks off) | 127,987 (100.1%) | 60 (0.0%) | 306,989 (80.1%) | 2026-01-29 |
| With hooks enabled | 127,987 (100.1%) | 139,568 (36.4%) | 299,958 (78.3%) | 2026-01-28 |
| Delay loop eliminated | 127,987 (100.1%) | 139,567 (36.4%) | 100,157 (26.1%) | 2026-01-28 |
| PC profiling (race avg) | 127,987 (100.1%) | 157,286 | 296,112 | 2026-03-08 |

---

## Risk Analysis

### Track A Risks

| Risk | Severity | Mitigation |
|------|----------|------------|
| Master SH2 doesn't read COMM fast enough (68K overwrites) | High | Handshake on COMM0 or separate register; verify with profiling |
| SDRAM ring buffer contention (Master writes while Slave reads) | Medium | Use cache-through addressing; separate cache lines for pointers |
| Frame-end sync adds new wait time | Medium | Sync only once per frame (vs 21 waits currently) — net positive |
| Master SH2 handler bugs (literal pool, alignment) | Medium | Follow SH2 patching discipline from KNOWN_ISSUES.md |

### Track B Risks

| Risk | Severity | Mitigation |
|------|----------|------------|
| Batching overhead exceeds savings for small batches | High | Profile angle_normalize batch (8 inputs) before scaling to other functions |
| Entity field marshaling to SDRAM is too expensive | Medium | Only marshal changed fields; profile marshaling cost vs computation cost |
| Caller restructuring introduces bugs | Medium | One function at a time; full emulator test after each |
| Results not ready when 68K needs them | Medium | Explicit sync point; schedule batch early in frame |

### General Risks

| Risk | Severity | Mitigation |
|------|----------|------------|
| FM bit preemption corrupts VDP state | Medium | Only switch FM during V-Blank |
| SH2 interrupt hardware bug | Medium | FRT TOCR toggle workaround (documented in supplement-2) |

---

## Key Documents

| Document | Purpose |
|----------|---------|
| [BACKLOG.md](BACKLOG.md) | Task queue with priorities and status |
| [KNOWN_ISSUES.md](KNOWN_ISSUES.md) | Pitfalls, hardware hazards, abandoned approaches |
| [ARCHITECTURAL_BOTTLENECK_ANALYSIS.md](analysis/ARCHITECTURAL_BOTTLENECK_ANALYSIS.md) | Root cause analysis |
| [COMM_REGISTERS_HARDWARE_ANALYSIS.md](analysis/COMM_REGISTERS_HARDWARE_ANALYSIS.md) | COMM hardware deep dive |
| [MASTER_SH2_DISPATCH_ANALYSIS.md](analysis/architecture/MASTER_SH2_DISPATCH_ANALYSIS.md) | Dispatch mechanism + B-006 crash analysis |
| [SH2_3D_ENGINE_DEEP_DIVE.md](analysis/sh2-analysis/SH2_3D_ENGINE_DEEP_DIVE.md) | 3D engine algorithms |
| [SYSTEM_EXECUTION_FLOW.md](analysis/SYSTEM_EXECUTION_FLOW.md) | Per-frame execution order |
| [RENDERING_PIPELINE.md](analysis/RENDERING_PIPELINE.md) | End-to-end rendering flow |
| [68K_PC_PROFILING.md](tools/libretro-profiling/README_68K_PC_PROFILING.md) | Profiling methodology |

---

**This plan is grounded in PC profiling data from March 2026. The 68K is the sole bottleneck at 100.1% utilization. 49.4% is V-blank sync (unavoidable), 10.8% is command overhead (optimized by B-003/B-004/B-005), 39.8% is useful work. The path to 30 FPS requires eliminating ~33% of useful work via cmd_27 queue decoupling (Track A, 21.7%) and batched SH2 offload (Track B, 12.3%). 60 FPS requires pipeline overlap (Track C) — research only until 30 FPS is achieved.**
