# Virtua Racing 32X - Optimization Roadmap

**Created:** February 7, 2026
**Baseline:** ~20-24 FPS | **Target:** 60 FPS
**Constraint:** 68K at 100.1% utilization (127,987 cycles/frame)

This roadmap breaks every optimization opportunity into concrete, sequenced tasks. Each phase builds on the previous one. Nothing is estimated — tasks are ordered by dependency, not timeline.

---

## Phase 0: Preparatory Work

Before writing any optimization code, we need to create the conditions for it: verify hardware assumptions, establish profiling baselines, and most critically — **free ROM space for 68K code by relocating SH2 functions to expansion ROM**.

### 0.1 Verify Hardware Assumptions

These checks are cheap and eliminate risk before we commit to an architecture.

| # | Task | Status | Notes |
|---|------|--------|-------|
| 0.1.1 | Verify RV bit is never set during gameplay | **DONE** | Confirmed safe — no writes to DREQ_CTRL ($A15106) outside boot |
| 0.1.2 | Run 68K PC-level hotspot profiling | **DONE** | Frame-level: 68K 127,987c/f (100.1%), MSH2 45c/f (0.0%), SSH2 307,296c/f (80.2%). PC-level limited by FAME end-of-burst sampling bias |
| 0.1.3 | Confirm COMM register write directions | **DONE** | COMM6 is bidirectional (critical race). COMM1/2/7 safe. See findings below |
| 0.1.4 | Profile FM bit switching timing | **DONE** | All 29 FM writes during V-Blank (V-INT handler). No mid-transfer switches. Safe |

**0.1.2 results — Frame + PC profiling:**
Built v3 profiling patch into PicoDrive (4 files modified: `32x.c`, `pico_cmn.c`, `sh2pico.c`, `libretro.c`). Frame-level data confirms the architectural bottleneck:
- **68K: 127,987 cycles/frame (100.1%)** — saturated, the sole bottleneck
- **Master SH2: 45 cycles/frame (0.0%)** — completely idle, available for interrupt queue
- **Slave SH2: 307,296 cycles/frame (80.2%)** — doing all rendering work

PC-level 68K sampling hit a FAME core limitation: end-of-burst sampling always catches the PC at exception vector trampolines ($880200+) rather than actual game code. The 68K hotspot identification relies on static analysis instead (35 blocking COMM polls per frame, ~60% of 68K time).

```bash
# Working profiling command
cd tools/libretro-profiling
VRD_PROFILE_LOG=frame.csv VRD_PROFILE_PC=1 VRD_PROFILE_PC_LOG=pc.csv \
./profiling_frontend ../../build/vr_rebuild.32x 2400 --autoplay
python3 analyze_profile.py frame.csv
python3 analyze_pc_profile.py pc.csv
```

---

### 0.2 SH2 Code Relocation to Expansion ROM

**Status: SKIPPED** — Large $FF-filled gaps found in existing ROM (see 0.3).

The original plan was to free ROM space by relocating SH2 functions to expansion ROM. ROM analysis discovered **55,614 bytes** of unused $FF-filled gaps already present in the first 512KB, eliminating the need for any SH2 relocation.

| # | Task | Status |
|---|------|--------|
| 0.2.1-0.2.10 | SH2 relocation tasks | **SKIPPED** — sufficient space found in existing ROM gaps |

---

### 0.3 68K Space Creation

**Goal:** Create usable 68K code space for async shims, trampolines, and new logic.

**Discovery:** ROM analysis found **55,614 bytes** of $FF-filled gaps in the first 512KB — no SH2 relocation needed!

#### Available ROM Gaps (all verified $FF-filled)

| Region | 68K Address | Size | Location |
|--------|------------|------|----------|
| **Primary** | **$01C208-$01FFFF** | **15,864 bytes** | Between last 68K data and SH2 code |
| Secondary | $07B782-$07FFFF | 18,558 bytes | End of 68K section block |
| Tertiary | $03BFDC-$03EFFF | 12,324 bytes | Mid-ROM gap |
| Reserve | $02DD5C-$02FFFF | 8,868 bytes | Mid-ROM gap |

All gaps are in the first 512KB, accessible via the unbanked ROM window at $880000+. The 68K executes from $880000-based addresses on the 32X (e.g., $01C208 = 68K address $89C208).

**Addressing note:** On the 32X, 68K ROM access is via the bank window at $880000. Code at file offset $01C208 is reachable via `JSR $0089C208` from any 68K code. `BSR.W` from $00E200 to $01C208 = $DA08 = 55,816 bytes — exceeds ±32KB. Use `JSR` (absolute).

| # | Task | Details | Status |
|---|------|---------|--------|
| 0.3.1 | Verify $E200 section padding is NOT usable | The 166 bytes of zeros are palette table entries (indices > 5), not free space | **DONE** |
| 0.3.2 | Verify ROM gaps are truly unused | Confirmed all 4 gaps are 100% $FF-filled | **DONE** |
| 0.3.3 | Create 68K code section at $01C208 | Replace $FF padding in code_1c200.asm with labeled optimization area + `dcb.b` fill | **DONE** |
| 0.3.4 | Verify 68K can execute from $01C208 | Memory mapping confirmed: $89C208 via unbanked ROM window. Callers use `JSR $0089C208` | **DONE** |
| 0.3.5 | Document 68K space map | Record all available 68K code regions with addresses and sizes | **DONE** (this table) |

---

### 0.4 Build System Preparation

| # | Task | Details | Status |
|---|------|---------|--------|
| 0.4.1 | Add `make profile-pc` target | PC-level hotspot profiling | **DONE** |
| 0.4.2 | Add `make profile-frame` target | Frame-level CPU profiling | **DONE** |
| 0.4.3 | Add `make test` target | Boot ROM for 300 frames, verify no crash | **DONE** |
| 0.4.4 | Add expansion ROM section labels | Reserved $300800 (CMDINT handler) + $300C00 (queue processor) in expansion_300000.asm | **DONE** |
| 0.4.5 | Create `disasm/modules/68k/optimization/` directory | New module category for optimization code | **DONE** |

---

## Phase 1: Master SH2 Interrupt Queue

The core infrastructure that enables all subsequent optimization: a CMDINT-driven command queue on the idle Master SH2 that processes 68K→SH2 commands without blocking the 68K.

### 1.1 SDRAM Ring Buffer

| # | Task | Details |
|---|------|---------|
| 1.1.1 | Design ring buffer structure | 64-entry × 8 bytes (command word + 3 parameter words) = 512 bytes. Head/tail pointers in SDRAM |
| 1.1.2 | Choose SDRAM address | $2203F000 (cache-through) — near existing parameter block at $2203E000 |
| 1.1.3 | Define buffer entry format | Match existing COMM protocol: `[cmd_id, param1, param2, param3]` as 4 × 16-bit words |
| 1.1.4 | Define head/tail pointer locations | Two 32-bit words at $2203F200 (head) and $2203F204 (tail) |
| 1.1.5 | Implement buffer initialization | Zero head/tail at boot (add to SH2 init sequence) |

### 1.2 CMDINT Handler (Master SH2, Expansion ROM)

| # | Task | Details |
|---|------|---------|
| 1.2.1 | Study existing Master SH2 interrupt vectors | Read current vector table to understand what's already handled |
| 1.2.2 | Implement CMDINT handler skeleton | At expansion ROM $300700: save registers, read queue, restore, RTE |
| 1.2.3 | Apply SH2 interrupt bug workaround | FRT TOCR toggle, proper interrupt levels, 2+ cycle wait before RTE |
| 1.2.4 | Implement queue read logic | Dequeue one entry: read tail, compare to head, read entry, advance tail |
| 1.2.5 | Implement COMM register write | Write dequeued command to COMM0/COMM4/COMM6, signal Slave |
| 1.2.6 | Implement Slave completion poll | After COMM write, poll COMM6 for Slave acknowledgment before dequeuing next |
| 1.2.7 | Wire CMDINT vector to handler | Update Master SH2 vector table to point to expansion ROM handler |
| 1.2.8 | Test CMDINT fires correctly | Trigger CMDINT from 68K, verify handler executes (use COMM5 counter as evidence) |

### 1.3 68K Async Shim

| # | Task | Details |
|---|------|---------|
| 1.3.1 | Implement `sh2_send_cmd_async` | 68K function: write command to ring buffer head, advance head pointer |
| 1.3.2 | Implement CMDINT trigger | After buffer write: write to CMD interrupt trigger register ($A15106 or appropriate) |
| 1.3.3 | Implement `sh2_wait_queue_empty` | 68K function for frame boundary: poll until head == tail (all commands processed) |
| 1.3.4 | Place shim in available 68K space | Use reclaimed $E200 padding or freed SH2 space from Phase 0 |
| 1.3.5 | Test shim with dummy command | Send one command via async path, verify Slave processes it |

### 1.4 Integration Test

| # | Task | Details |
|---|------|---------|
| 1.4.1 | Send single real command via async path | Replace one `sh2_cmd_27` call site with async, keep all others blocking |
| 1.4.2 | Verify rendering correctness | Boot, play full race, check for visual artifacts |
| 1.4.3 | Profile async overhead | Measure: 68K cycles saved per async call, Master SH2 cycles consumed per dequeue |
| 1.4.4 | Verify no COMM register corruption | Check that async writes don't collide with any remaining blocking calls |

---

## Phase 2: Async sh2_cmd_27 Conversion

Convert the dominant blocking call site (21 calls/frame, ~60% of all submissions).

| # | Task | Details |
|---|------|---------|
| 2.1 | Map all 21 `sh2_cmd_27` call sites | List every 68K address that calls `sh2_cmd_27` ($00E3B4). Record parameter patterns |
| 2.2 | Classify call sites by safety | 15 are known safe for async. 2 have secondary blocking on `$FFFFC80E`. Tag each |
| 2.3 | Convert first safe call site | Replace blocking call with `JSR sh2_send_cmd_async`. Build, test, profile |
| 2.4 | Convert remaining safe call sites (batch) | Apply same pattern to all 15 safe sites. Test after each batch of ~5 |
| 2.5 | Handle 2 unsafe call sites | Analyze `$FFFFC80E` RAM flag dependency. Options: keep blocking, or add flag check to async shim |
| 2.6 | Add frame boundary sync | Insert `sh2_wait_queue_empty` at the frame sync point (after all commands submitted, before buffer flip) |
| 2.7 | Full profiling pass | Measure 68K utilization with all cmd_27 async. Expected: ~40% reduction in blocking cycles |
| 2.8 | Gameplay validation | Full race (3+ laps), all game modes. Check physics, visuals, audio |

**Expected result:** First measurable FPS improvement. 68K blocking reduced by ~40% for cmd_27 path.

---

## Phase 3: Full Async Conversion

Convert the remaining 14 `sh2_graphics_cmd` calls.

| # | Task | Details |
|---|------|---------|
| 3.1 | Map all `sh2_graphics_cmd` call sites | List every 68K address calling `sh2_graphics_cmd` ($00E22C). Record command types |
| 3.2 | Analyze `sh2_send_cmd_wait` dependency chain | Understand: does `sh2_graphics_cmd` depend on synchronous completion for parameter reuse? |
| 3.3 | Convert safe graphics call sites | Replace blocking path with async. Single-slot queue ensures COMM stability |
| 3.4 | Handle command ordering dependencies | Some graphics commands may depend on previous command completion. Add ordering barriers if needed |
| 3.5 | Full-frame async profile | All 35 commands now async. Measure total 68K blocking reduction |
| 3.6 | Stress test | Extended gameplay (10+ minutes), multiple tracks, different car counts |

**Expected result:** All 35 commands/frame non-blocking. 68K blocking reduced by ~60%. First major FPS gain (target: 35-40 FPS).

---

## Phase 4: Command Batching

Reduce the number of individual command submissions from 35 to ~3-5.

### 4.1 Batch Copy Command ($26)

| # | Task | Details |
|---|------|---------|
| 4.1.1 | Finalize batch copy command format | 68K writes 8-command list to SDRAM, sends single $26 command with pointer |
| 4.1.2 | Implement SH2 batch handler | `batch_copy_handler` at $300500 (already in expansion ROM layout). Process command list sequentially |
| 4.1.3 | Implement 68K batch submission | Replace 8 sequential `sh2_send_cmd_wait` in copy routine with single batch write + async submit |
| 4.1.4 | Test and profile | Verify 8 copies complete correctly. Measure overhead reduction (8 round-trips → 1) |

### 4.2 cmd_27 Batching

| # | Task | Details |
|---|------|---------|
| 4.2.1 | Analyze cmd_27 parameter patterns | Can 21 individual cmd_27 calls be grouped into 1-3 batch submissions? |
| 4.2.2 | Design batch cmd_27 format | Command list in SDRAM with all 21 parameter sets. Single submission |
| 4.2.3 | Implement SH2 batch cmd_27 handler | Expansion ROM function that iterates parameter list |
| 4.2.4 | Convert 68K call sites | Replace 21 individual calls with batch list build + single async submit |
| 4.2.5 | Test and profile | Verify rendering correctness. Measure submission overhead reduction |

### 4.3 Graphics Init Batching

| # | Task | Details |
|---|------|---------|
| 4.3.1 | Analyze graphics init command sequence | Map the 6 init commands issued per frame. Check for ordering dependencies |
| 4.3.2 | Design batch init command | Single submission with all 6 commands |
| 4.3.3 | Implement and test | Follow same pattern as 4.1 and 4.2 |

### 4.4 Combined Profiling

| # | Task | Details |
|---|------|---------|
| 4.4.1 | Profile fully batched configuration | All commands async + batched. Measure total 68K cycle savings |
| 4.4.2 | Compare FPS: baseline vs async-only vs async+batched | Quantify the incremental gain from batching on top of async |
| 4.4.3 | Gameplay validation | Extended testing with batched commands |

**Expected result:** 35 submissions/frame → 3-5. Additional +10-20% FPS on top of async gains.

---

## Phase 5: v4.0 Parallel Processing Activation

Enable the already-built Slave CPU vertex transform offload. This is independent of Phases 2-4 (async) and can be activated once Phase 1 queue infrastructure is stable.

| # | Task | Details |
|---|------|---------|
| 5.1 | Review current expansion ROM code | Re-read `master_dispatch_hook`, `slave_work_wrapper`, `func_021_optimized` for correctness |
| 5.2 | Patch dispatch at $02046A | Wire Master dispatch hook to skip COMM7 processing for command $16 |
| 5.3 | Patch trampoline at $0234C8 | Redirect func_021 calls through parameter capture trampoline |
| 5.4 | Test Slave activation in isolation | Verify Slave picks up work, executes func_021_optimized, writes COMM5 counter |
| 5.5 | Measure Slave execution time | Profile func_021_optimized cycle count. Verify it completes within frame budget |
| 5.6 | Implement frame sync guard | Ensure Slave completes current work before 68K issues next frame's commands |
| 5.7 | Profile combined async + parallel | Measure all three CPUs with async commands AND Slave activation |
| 5.8 | Gameplay validation | Full race with parallel processing active |

**Expected result:** Slave SH2 now does useful vertex transform work in parallel with 68K game logic. Combined with async commands, target: 40-50 FPS.

---

## Phase 6: Pipeline Overlap

Allow 68K to build frame N+1 commands while SH2 renders frame N. **Requires Phases 2-3 (async) as prerequisite.**

### 6.1 Design

| # | Task | Details |
|---|------|---------|
| 6.1.1 | Analyze frame data dependencies | Which 68K data structures does SH2 read during rendering? List all shared state |
| 6.1.2 | Identify what must be double-buffered | Command lists, vertex data, object tables — anything 68K writes and SH2 reads |
| 6.1.3 | Calculate SDRAM budget for double buffers | Sum all shared data structures × 2. Verify fits in available SDRAM |
| 6.1.4 | Design buffer swap protocol | When does swap happen? What sync points are needed? |

### 6.2 Implementation

| # | Task | Details |
|---|------|---------|
| 6.2.1 | Allocate double buffers in SDRAM | Two copies of all shared state at known addresses |
| 6.2.2 | Modify 68K to write to "next frame" buffer | 68K writes commands/data to buffer A while SH2 processes buffer B |
| 6.2.3 | Implement buffer swap at frame boundary | Atomic swap of active/pending buffer pointers |
| 6.2.4 | Add pipeline sync fence | 68K must not overwrite buffer SH2 is still reading |
| 6.2.5 | Test and profile | Measure frame overlap. Check for data races |
| 6.2.6 | Handle edge cases | First frame (no previous data), pause/unpause, state transitions |

**Expected result:** 68K and SH2 work overlap. Additional +15-30% FPS. Target: 50-60 FPS.

---

## Phase 7: 68K Work Offload

Move pure computation from the saturated 68K to the idle Master SH2. **Requires Phase 1 (CMDINT infrastructure) as prerequisite.**

### 7.1 Identify Offload Candidates

| # | Task | Details |
|---|------|---------|
| 7.1.1 | Analyze 68K PC-level hotspots (from 0.1.2) | Find non-blocking 68K functions that consume significant cycles |
| 7.1.2 | Identify pure computation functions | Functions with no VDP access, no Z80 bus, no COMM writes — just math |
| 7.1.3 | Prioritize by cycle savings | Rank candidates by cycles/frame. Top candidates likely: trig lookups, physics integration |
| 7.1.4 | Assess data flow for each candidate | Input data location, output data location, cache-through requirements |

### 7.2 Implement Offload

| # | Task | Details |
|---|------|---------|
| 7.2.1 | Implement first offload candidate on Master SH2 | Write SH2 version of highest-priority 68K function in expansion ROM |
| 7.2.2 | Create 68K→SH2 offload protocol | 68K writes inputs to SDRAM → fires CMDINT → Master SH2 computes → writes results → 68K reads |
| 7.2.3 | Replace 68K function call with offload call | 68K now submits work to SH2 instead of computing locally |
| 7.2.4 | Profile and validate | Verify 68K cycle reduction. Check for data coherency issues |
| 7.2.5 | Iterate for additional candidates | Repeat 7.2.1-7.2.4 for next priority function |

**Expected result:** 68K cycles freed for game logic. Additional +5-15% FPS.

---

## Phase 8: VDP Polling Elimination (Conditional)

**Only pursue if SH2 becomes the bottleneck** after Phases 1-7 free enough 68K cycles. Currently the SH2 is NOT the constraint.

### 8.1 Assessment

| # | Task | Details |
|---|------|---------|
| 8.1.1 | Profile post-optimization CPU balance | After Phases 1-7: is 68K or SH2 now the bottleneck? |
| 8.1.2 | If SH2-bound: measure VDP polling waste | Profile the 4 VDP polling loops ($243E2, $2441E, $2443A, $24482) |
| 8.1.3 | If 68K-bound: skip this phase | VDP polling is SH2-side. If 68K is still the constraint, this won't help |

### 8.2 Implementation (if needed)

| # | Task | Details |
|---|------|---------|
| 8.2.1 | Implement SH2 interrupt handler skeleton | Shared dispatcher per hardware manual requirements |
| 8.2.2 | Apply FRT TOCR toggle workaround | Mandatory for all SH2 interrupt handlers (hardware bug in original silicon) |
| 8.2.3 | Implement V-Blank interrupt handler | Replace first polling loop with interrupt wait |
| 8.2.4 | Convert remaining polling loops incrementally | One at a time: H-Blank, FIFO ready, frame buffer swap |
| 8.2.5 | Respect DMA restrictions | No VDP access in H-interrupt during DMA operations |
| 8.2.6 | Test and validate | Check for timing regressions, visual glitches |

---

## Phase 9: SH2 Micro-Optimizations (Capacity)

These yield **0% FPS gain** while the 68K is the bottleneck. They become relevant after Phases 1-7 shift the bottleneck to SH2, or to create SH2 headroom for additional offloaded work.

| # | Task | Details | Status |
|---|------|---------|--------|
| 9.1 | Frame buffer FIFO batching | Restructure rasterizer writes into 4-word bursts (2.4x pixel write speedup) | TODO — needs profiling to check if already batched |
| 9.2 | MAC loop unrolling | Unroll matrix multiply inner loops (~15% multiply speedup) | Designed, not implemented |
| 9.3 | SDRAM 16-byte alignment | Align critical data structures for burst read performance | TODO — needs profiling |
| 9.4 | Delay loop reduction | Reduce Slave idle loop iterations (66.6% Slave cycle savings) | **PROVEN** — 0% FPS gain, confirms 68K bottleneck |
| 9.5 | func_016 inlining | Inline coordinate packing at additional call sites | **DONE** for func_021_optimized in expansion ROM |

---

## Dependency Graph

```
Phase 0 (Prep)
  ├─ 0.1 Verify assumptions (independent)
  ├─ 0.2 SH2 relocation ──→ 0.3 68K space creation
  └─ 0.4 Build system
            │
            ▼
Phase 1 (Queue Infrastructure)
  ├─ 1.1 Ring buffer
  ├─ 1.2 CMDINT handler
  ├─ 1.3 68K async shim
  └─ 1.4 Integration test
            │
      ┌─────┴─────┐
      ▼            ▼
Phase 2          Phase 5
(Async cmd_27)   (v4.0 Activation)
      │            │
      ▼            │
Phase 3            │
(Full async)       │
      │            │
      ├────────────┘
      ▼
Phase 4 (Batching)
      │
      ▼
Phase 6 (Pipeline Overlap)
      │
      ▼
Phase 7 (68K Work Offload)
      │
      ▼
Phase 8 (VDP Polling — conditional)
      │
      ▼
Phase 9 (SH2 Micro-Opts — capacity)
```

**Key parallel opportunity:** Phase 5 (v4.0 activation) can proceed in parallel with Phases 2-3 (async conversion) once Phase 1 queue is working. They're independent — Phase 5 activates the Slave dispatch, while Phases 2-3 convert the 68K command submission path.

---

## Progress Tracking

### Phase Summary

| Phase | Tasks | Focus | Prerequisite | FPS Impact |
|-------|-------|-------|--------------|------------|
| **0** | 19 | Prep: profiling, relocation, space creation | None | 0% (enables everything) |
| **1** | 13 | Master SH2 command queue | Phase 0 | 0% (infrastructure) |
| **2** | 8 | Async sh2_cmd_27 (21 calls/frame) | Phase 1 | +25-40% (first real gain) |
| **3** | 6 | Full async (all 35 commands) | Phase 2 | +46-67% cumulative |
| **4** | 12 | Command batching (35 → 3-5) | Phase 3 | +58-88% cumulative |
| **5** | 8 | Slave CPU parallel activation | Phase 1 | Adds SH2 throughput |
| **6** | 8 | Pipeline overlap (frame N/N+1) | Phase 3 | +88-130% cumulative |
| **7** | 9 | 68K work offload to Master SH2 | Phase 1 | +100-150% cumulative |
| **8** | 6 | VDP polling elimination | Phase 7 (conditional) | Variable |
| **9** | 5 | SH2 micro-optimizations | Any | 0% (capacity) |
| **Total** | **94** | | | **Target: 60 FPS** |

### Milestone Checkpoints

| After Phase | Expected FPS | Validation |
|-------------|-------------|------------|
| 0 | 20-24 (unchanged) | Build works, profiling data collected |
| 1 | 20-24 (unchanged) | Queue functional, single command round-trips |
| 2 | 28-32 | First FPS gain — cmd_27 async working |
| 3 | 35-40 | All commands async — major improvement |
| 4 | 38-45 | Batched commands — smoother frame pacing |
| 5 | 40-50 | Parallel SH2 processing active |
| 6 | 50-60 | Pipeline overlap — approaching target |
| 7 | 55-60+ | 68K work offloaded — at target |

---

## Risk Register

| Risk | Phase | Severity | Mitigation |
|------|-------|----------|------------|
| SH2 relocation breaks cached execution | 0.2 | Medium | Profile cache effects after each relocation. Expansion ROM is still cached ($02300000) |
| No dead code found in $E200 | 0.3 | High | Fallback: use freed SH2 space via JSR (absolute) — longer but works |
| CMDINT doesn't fire reliably | 1.2 | Medium | CMDINT is level-triggered (re-asserts if unmasked). Hardware behavior well-documented |
| COMM register corruption during async | 2.x | High | Single-slot pending queue. Master SH2 serializes all COMM writes |
| Async command ordering breaks rendering | 3.x | Medium | Preserve original submission order in ring buffer. Add explicit barriers if needed |
| Frame N+1 reads stale frame N data | 6.x | High | Double-buffer ALL shared state. Verify with data integrity checks |
| 68K function too complex to offload | 7.x | Low | Skip complex candidates. Focus on pure math (trig, physics) |
| SH2 interrupt hardware bug causes missed interrupts | 1.2, 8.x | Medium | FRT TOCR toggle workaround. Documented in hardware manual supplement |

---

**This roadmap is the implementation companion to [OPTIMIZATION_PLAN.md](OPTIMIZATION_PLAN.md), which covers strategy and rationale.**
