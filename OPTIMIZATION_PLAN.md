# Virtua Racing 32X - Optimization Strategy

**Status:** Revised strategic plan (v6.1 update — PC profiling data added)
**Last Updated:** March 8, 2026
**Baseline:** ~20-24 FPS (measured, scene-dependent)
**Target:** 60 FPS (+150%)
**Approach:** Data-driven, 68K-bottleneck-first

---

## Executive Summary

### Ground Truth: The 68K Is THE Bottleneck

Profiling (January 2026) conclusively proved that **the 68000 CPU is the performance constraint**, not SH2 processing time. This finding invalidates the original optimization plan's priorities and fundamentally changes the strategy.

**Evidence:**
1. 68K runs at **100.1% utilization** (127,987 cycles/frame @ 7.67 MHz) — completely saturated
2. Eliminating **66.6% of Slave SH2 work** produced **ZERO FPS improvement** — frame rate unchanged
3. The ~20-24 FPS ceiling is caused by a **blocking command-handshake architecture** that serializes the rendering pipeline through the 68K

**Implication:** Any optimization that doesn't free 68K cycles will NOT improve FPS, regardless of how much SH2 capacity it frees.

### Revised Priority Order

| Priority | Track | Strategy | Expected Gain | Why |
|----------|-------|----------|---------------|-----|
| **1** | **68K Blocking Relief** | Async commands via SH2 interrupt queue | **+46-67% FPS** | Eliminates 68K wait cycles |
| **2** | **Command Batching** | Reduce 35 submissions/frame to ~3 | **+10-20% FPS** | Fewer sync round-trips |
| **3** | **Pipeline Overlap** | 68K builds frame N+1 while SH2 renders N | **+15-30% FPS** | Removes frame serialization |
| **4** | **68K Work Offload** | Move physics/trig to idle Master SH2 | **+5-15% FPS** | Frees 68K compute cycles |
| **5** | **VDP Polling** | Interrupt-driven VDP access (SH2 side) | **Variable** | Only helps if VDP waits are SH2-bound |
| **6** | **SH2 Micro-Opts** | coord_transform inlining, MAC loops, FIFO batch | **0% FPS** | SH2 is NOT the bottleneck |

**Combined potential:** 24 FPS → 48-60+ FPS (via Tracks 1-4)

### Key Lesson: SH2 Optimizations Alone Cannot Improve FPS

The v4.0 Slave CPU activation infrastructure is **complete and valuable** — but it must be understood as **capacity preparation**, not a direct FPS improvement. The idle Master SH2 (0% utilization with hooks disabled, 36% with hooks enabled) is the ideal location for the Track 1 interrupt queue that WILL free 68K cycles.

---

## Current State Analysis

### CPU Utilization (Measured January 29, 2026)

Two profiling configurations have been measured:

**Baseline (expansion hooks DISABLED):**

| CPU | Cycles/Frame | Utilization | Role |
|-----|-------------|-------------|------|
| **68000** | **127,987** | **100.1%** | **BOTTLENECK — orchestrates entire pipeline** |
| Master SH2 | 60 | 0.0% | Completely idle (expansion hooks off) |
| Slave SH2 | 306,989 | 80.1% | All 3D rendering (but 66.5% wasted in idle loop) |

**With expansion hooks ENABLED:**

| CPU | Cycles/Frame | Utilization | Useful Work |
|-----|-------------|-------------|-------------|
| **68000** | **127,987** | **100.1%** | **BOTTLENECK** |
| Master SH2 | 139,568 | 36.4% | Vertex transform offload |
| Slave SH2 | 299,958 | 78.3% | 3D rendering (33.5% useful, 66.5% idle loop) |

**Key insight:** 68K utilization is identical in both configurations. Changing SH2 work distribution has zero effect on frame rate.

### Frame Time Budget

```
68K frame budget:   127,833 cycles @ 7.67 MHz = 16.67 ms
SH2 frame budget:   383,500 cycles @ 23.01 MHz = 16.67 ms

Actual frame time breakdown (measured):
  68K game logic + sync:   16.69 ms (100.1% — saturated)
  68K blocking waits:      ~10 ms   (~60% of 68K time!)
  SH2 rendering:           13.04 ms (78.3% utilization)
  Frame overhead:           ~2 ms

Effective FPS:  ~24 FPS (1000ms / 42ms total)
```

### The Blocking Pipeline (Root Cause)

The 68K submits **~35 blocking commands per frame** to the SH2 subsystem:

| Function | Address | Calls/Frame | Blocking Loops | Impact |
|----------|---------|-------------|----------------|--------|
| `sh2_cmd_27` | $00E3B4 | 21 | 2 inline loops each | **Dominant — 60% of submissions** |
| `sh2_graphics_cmd` | $00E22C | 14 | 1 via `sh2_send_cmd_wait` | Moderately expensive |
| `sh2_send_cmd_wait` | $00E316 | (indirect) | 1 blocking poll | Used by `sh2_graphics_cmd` |
| `sh2_wait_response` | $00E342 | (indirect) | Polls COMM6 | Final sync per command |

Each command follows a strict `submit → wait → continue` pattern:

```
68K                              SH2
 |                                |
 |-- Write COMM0 (command) -----> |
 |-- Write COMM4+5 (params) ----> |
 |                                |
 |   ┌── BLOCKING WAIT ──┐       |-- Process command
 |   │  Poll COMM6        │       |
 |   │  (wastes 68K cycles)│      |
 |   └────────────────────┘       |
 |                                |-- Write COMM6 (done)
 |<-- Read COMM6 (acknowledged) --|
 |                                |
 |-- Next command...              |
```

**~49% of 68K cycles are V-blank sync (not COMM polling as originally assumed).** PC profiling with WRAM caller tracking (March 2026) revealed the $FF0010 hotspot is `TST.W VINT_STATE.w` — the BIOS adapter's main loop waiting for V-blank between frame iterations. The remaining ~51% is useful work, of which SH2 Cmd 27 COMM7 waits account for ~22%. Reducing useful work per game frame means fewer TV frames per game frame = higher FPS.

---

## Completed Work

### v4.0 Parallel Processing Infrastructure (January 2026)

**Status:** COMPLETE but NOT ACTIVATED (B-006 patches reverted due to namespace collision)

| Component | Address | Size | Purpose | Status |
|-----------|---------|------|---------|--------|
| `handler_frame_sync` | $300028 | 22B | Frame synchronization | Dormant |
| `master_dispatch_hook` | $300050 | 44B | Skips COMM7 for cmd $16 | Reverted |
| `vertex_transform_optimized` | $300100 | 96B | Vertex transform (coord_transform inlined) | Dormant |
| `slave_work_wrapper` | $300200 | 76B | COMM7 command dispatch | Dormant |
| `slave_test_func` | $300280 | 44B | Test harness | Dormant |
| `cmd25_single_shot` | $300500 | 64B | Single-shot decompression (cmd $25) | **ACTIVE (B-005)** |
| `cmd27_queue_drain` | $300600 | 128B | Queue drain for cmd $27 | **ACTIVE (B-003)** |
| `slave_comm7_idle_check` | $300700 | 48B | COMM7 doorbell handler | **ACTIVE (B-003)** |
| `cmdint_handler` | $300800 | 64B | Master CMDINT ISR (reserved) | Dormant |
| `queue_processor` | $300C00 | 128B | Ring buffer drain (reserved) | Dormant |
| `general_queue_drain` | $301000 | 240B | General cmd async replay (dormant) | Dormant |
| `cmd22_single_shot` | $3010F0 | 60B | Single-shot 2D block copy (B-004) | **ACTIVE (B-004)** |

**Expansion ROM:** 1MB at $300000-$3FFFFF, ~1.8KB used (~99.82% free)

**Activation requires:** Patching dispatch at $02046A and trampoline at $0234C8 (B-006 reverted, needs redesign).

### v6.0 Full Codebase Translation (February 2026)

- **821 68K modules** organized across 17 categories + 15 game subcategories
- **736 modules** fully translated to mnemonics (5679 dc.w lines converted across 5 phases)
  - Phase 1: Automated non-PC-relative (3851 lines, 139 files)
  - Phase 2: Automated PC-relative + branches (1653 lines, label map + decoders)
  - Phase 3: Manual branch translations (82 lines, 45 files)
  - Phase 4: Manual JSR/JMP translations (70 lines, 29 files)
  - Phase 5: Manual BCD arithmetic (23 lines, 3 files)
- **92 SH2 function IDs** fully accounted for (74 groups + 12 expansion + 3 gaps/merged via 89 .inc files)
- **118+ modules** hardened with symbolic register names (COMM/MARS/VDP/Z80 equates)
- Remaining ~522 dc.w are data (sprite descriptors, pointer tables, lookup values) — not translatable
- All translations verified byte-identical to original ROM (md5: `eba54fc1e2768e26079b7db6ad0f0b69`)

### v8.0 Single-Shot cmd_22 (February 2026) — DONE ✅

**Status:** COMPLETE and TESTED (B-004, 2026-02-20). 189 32X frames in PicoDrive, no crash.

**What changed:** Replaced the 3-phase COMM6 handshake in `sh2_send_cmd` with a single-shot write. The 68K writes all 4 parameters to COMM2-6 at once (COMM1 untouched), triggers the Master SH2 via COMM0=$2222, and the Master dispatches to a new expansion ROM handler that reads everything in one shot.

**Implementation:**
- **68K sender** (code_e200.asm): 90-byte function → 50B single-shot writes + 40B NOP padding
- **SH2 handler** (cmd22_single_shot at $3010F0): 60 bytes, reads COMM2-6, 2D block copy with $200 stride, calls hw_init_short
- **Jump table** (code_20200.asm): Entry $020808 redirected $06005198 → $023010F0 (active)
- **COMM layout (v5, COMM1-safe)**: COMM0=$2222 (trigger=HI, index=LO), COMM2:3=A0, COMM4:5=A1, COMM6_HI=D1, COMM6_LO=D0/2, COMM1+COMM7=untouched
- **Dispatch**: COMM0_HI ($20004020) = trigger flag (polled for non-zero); COMM0_LO ($20004021) = dispatch index (shll2 → jump table at $06000780)

**Key discoveries:**
1. Per-call-site analysis proved ALL 14 sh2_send_cmd callers pass stable pointers — the Feb 14 "buffer aliasing" diagnosis was wrong
2. The real constraint is the 3-phase COMM multiplexing protocol, not pointer stability
3. SH2 gas assembler uses power-of-2 `.align` semantics and byte-offset displacements (not scaled)
4. COMM7 MUST be left untouched — it's the Slave doorbell for sh2_cmd_27 async (B-003)

**Estimated savings:** ~128 cycles × 14 calls/frame = ~1,792 cycles/frame (1.4% of 68K budget)

### v7.0 Async cmd_27 (February 2026) — SUCCEEDED ✅

**Status:** COMPLETE and TESTED (B-003, 2026-02-17)

**What happened:** Replaced sh2_cmd_27's blocking Master SH2 dispatch with direct COMM register parameter passing to the Slave SH2.

**Implementation:**
- **68K sender** (code_e200.asm): 82-byte sh2_cmd_27 body replaced with 50B COMM writes + 32B NOP padding. Waits COMM7==0, writes params to COMM2-6, doorbell COMM7=$0027, waits COMM7==0 (ack).
- **Slave inline drain** (code_20200.asm): 88-byte COMM-reading pixel processor at $020608 (SDRAM). Reads COMM2-6, clears COMM7, converts data_ptr to cache-through ($04xx→$24xx), processes pixels, loops back.
- **No queue, no expansion ROM execution on Slave.** Uses only COMM registers (documented shared memory).

**ROM tested:** Boots and runs in PicoDrive. Menu highlights, records/options panels, race mode all working.

**Key lessons:**
1. **SH2 cannot access 68K Work RAM** — $02FFFB00 and $22FFFB00 are unmapped. Three failed attempts (v1-v3) before reading the hardware manual's SH2 memory map.
2. **COMM registers are the only always-accessible shared memory** between 68K and SH2. SDRAM is also shared but requires address calculation.
3. **In-place replacement** needs NO additional 68K section space. The 82-byte function body was sufficient.
4. **Read the hardware manual first.** Don't guess about memory maps.

### 68K Async Attempt (January 2026) — FAILED (superseded by B-003)

**What happened:** Implemented `sh2_send_cmd_async` and async queue logic in 68K section.

**Why it failed:** Section `$00E200-$010200` has **ZERO bytes free**. Without initialization code, Work RAM contains garbage → ROM freezes on boot.

**Removed in:** Commit `0dd98c4`

**Lesson:** 68K-side async is impossible without space. The solution is in-place replacement (B-003) or SH2-side infrastructure.

### Delay Loop Elimination Experiment (January 2026) — SUCCEEDED (but no FPS gain)

**What happened:** Reduced Slave SH2 idle delay loop from 64 to 1 iteration.

**Result:** Slave cycles dropped 66.6% (299,958 → 100,157), FPS **unchanged**.

**Value:** Proved the 68K bottleneck hypothesis beyond doubt. Also demonstrated profiler accuracy (±4% variance from predictions).

---

## Optimization Tracks

### Track 1: 68K Blocking Relief — Async Commands 🔥🔥🔥 CRITICAL

**Goal:** Eliminate ~60% of 68K time spent polling COMM registers
**Expected gain:** +46-67% FPS (24 → 35-40 FPS)
**Risk:** Medium (requires careful synchronization)

#### The Problem

The 68K spends **~10ms per frame** (60% of its budget) blocked in polling loops waiting for SH2 acknowledgment. Every one of the ~35 graphics commands per frame requires a full round-trip handshake.

#### The Solution: SH2 Interrupt Queue (Path B)

Since the 68K section has no space for async infrastructure, the completely idle **Master SH2** will manage the command queue instead.

**Decision Matrix (from SH2_ASYNC_QUEUE_ANALYSIS.md):**

| Factor | 68K Queue | SH2 Queue | Winner |
|--------|-----------|-----------|--------|
| Implementation space | 0 bytes free | 1MB expansion ROM | **SH2** |
| Queue management CPU | 68K (saturated) | Master SH2 (idle) | **SH2** |
| Command latency | Direct COMM write | CMDINT → Master → Slave | 68K |
| Complexity | Simple | Medium | 68K |
| **Overall Score** | **2.3/5** | **4.0/5** | **SH2** |

#### Architecture

```
68K                    Master SH2              Slave SH2
 |                     (currently idle)         (3D rendering)
 |                         |                       |
 |-- Write cmd to queue -->|                       |
 |   (SDRAM ring buffer)   |                       |
 |                         |                       |
 |-- Fire CMDINT --------->|                       |
 |   (returns immediately) |                       |
 |                         |-- Dequeue command      |
 |-- Continue game logic   |-- Write COMM0/4/6     |
 |   (no blocking!)        |-- Signal Slave ------->|
 |                         |                       |-- Process command
 |                         |<-- COMM6 done --------|
 |                         |-- Dequeue next...      |
```

**Key benefit:** 68K writes command to SDRAM and fires CMDINT — **zero polling, immediate return**. The Master SH2 handles all COMM register choreography.

#### COMM Register Collision Analysis

All 17 command submissions per frame reuse COMM0/COMM4/COMM6. Naive async would corrupt parameters mid-transfer. The solution:

- **Single-slot pending queue:** Only one command in flight at a time
- **Master SH2 serializes:** Ensures COMM registers are stable before next submission
- **15 of 17 call sites are safe** for async conversion
- **2 call sites** ($010B2C, $010BAE) have secondary blocking on RAM flag `$FFFFC80E` — need special handling

#### Implementation Phases

**Phase 1: ~~Master SH2 Queue Infrastructure~~** SKIPPED (simpler design adopted)
1. ~~Ring buffer in SDRAM (64 commands × 8 bytes = 512 bytes at $2203F000)~~
2. ~~CMDINT handler on Master SH2 (dequeue + COMM register write)~~
3. ~~68K-side `sh2_send_cmd_async` shim (write to buffer + trigger CMDINT)~~
4. ~~Frame boundary sync (`sh2_wait_frame_complete`)~~

**Phase 2: Convert sh2_cmd_27** (21 calls/frame — biggest win) — ✅ DONE (B-003, Feb 2026)
1. ✅ Replace sh2_cmd_27 body with COMM register writes (50B code + 32B padding = 82B)
2. ✅ Direct COMM2-6 parameter passing (no queue, no Work RAM)
3. ✅ COMM7 doorbell ($0027) + COMM7==0 ack handshake
4. ✅ Slave inline drain at $020608 (88B SDRAM, reads COMM registers, cache-through writes)
5. ✅ ROM tested — menus, records, race mode all working in PicoDrive
6. **TODO:** Profile to measure actual 68K cycle reduction

**Phase 3: Handshake reduction for sh2_send_cmd** (14 calls/frame) — IN PROGRESS (B-004)
1. ✅ Per-call-site analysis: all 14 callers pass stable SDRAM/ROM/framebuffer pointers
2. ✅ Single-shot COMM protocol: 68K writes D1→COMM1, A0→COMM2:3, A1→COMM4:5, D0→COMM6, triggers COMM0
3. ✅ New SH2 handler: cmd22_single_shot at expansion $3010F0 (60B), reads COMM1-6, copies rows, calls hw_init_short
4. ✅ Jump table redirect: $020808 → $023010F0
5. ✅ ROM builds and binary verified
6. **TODO:** Emulator test (PicoDrive) — menus, race mode, all game states
7. **TODO:** Profile to measure actual 68K cycle reduction (~1,792 cycles/frame estimated)
8. **Note:** Previous fully-async approach (general_queue_drain) FAILED — blanket async violates 3-phase COMM multiplexing protocol. Single-shot approach keeps Master SH2 dispatch intact.

**Phase 4: Pipeline frame sync** — OPEN
1. Move frame completion check to dedicated sync point (or V-INT flush)
2. Ensure Slave finishes before buffer flip
3. Measure total FPS gain

#### Sizing (B-003 Implementation)

**Actual footprint (in-place replacement):**

| Component | Location | Size | Status |
|-----------|----------|------|--------|
| sh2_cmd_27 COMM sender | $E3B4 (in-place) | 50B code + 32B NOP | ✅ Active |
| Slave inline drain | SDRAM $020608 (in-place) | 88B code + 40B NOP | ✅ Active |
| slave_comm7_idle_check | Expansion ROM $300700 | 48B | ✅ Active |
| cmd27_queue_drain | Expansion ROM $300600 | 128B | Dormant (superseded) |

**B-004 footprint (single-shot protocol):**

| Component | Location | Size | Status |
|-----------|----------|------|--------|
| sh2_send_cmd single-shot sender | $E35A (in-place) | 50B code + 40B NOP | Built, pending test |
| cmd22_single_shot handler | Expansion ROM $3010F0 | 60B | Built, pending test |
| Jump table redirect | $020808 (in-place) | 4B | Built, pending test |

**B-001 space blocker:** MOOT — in-place replacement needs no additional 68K space. The existing 82-byte sh2_cmd_27 body was sufficient.

#### References
- [ASYNC_COMMAND_IMPLEMENTATION_PLAN.md](analysis/optimization/ASYNC_COMMAND_IMPLEMENTATION_PLAN.md)
- [SH2_ASYNC_QUEUE_ANALYSIS.md](analysis/optimization/SH2_ASYNC_QUEUE_ANALYSIS.md)
- [COMM_REGISTER_USAGE_ANALYSIS.md](analysis/optimization/COMM_REGISTER_USAGE_ANALYSIS.md)

---

### Track 2: Command Protocol Optimization — DONE (2026-03-03)

**Original goal:** Reduce 35 submissions to ~3-5 batches (+10-20% FPS).
**Revised scope:** Original batch design invalidated (SH2 can't access Work RAM; pre-B-003/B-004 FPS estimates obsolete; 8-call target is scene-init only). Converted remaining 3-phase function to single-shot instead.

#### What Was Done

1. **Re-profiling** (B-003+B-004 active): 68K still 100% utilized (127,987 cyc/frame). Command overhead is ~4,000 cyc (3.1%), down from ~12,000+. Master SH2 is 0% (completely idle).

2. **sh2_send_cmd_wait → single-shot** (B-005): Converted the last 3-phase COMM6 handshake function ($E316) to single-shot protocol. COMM3:4=A0 (source), COMM5:6=A1 (dest), params-consumed handshake. New SH2 handler `cmd25_single_shot` at expansion ROM $300500 (64 bytes) calls the existing decompressor at $06005058. PicoDrive 3600-frame verified.

3. **Batch design obsoleted:** [BATCH_COPY_COMMAND_DESIGN.md](analysis/optimization/BATCH_COPY_COMMAND_DESIGN.md) marked obsolete — Work RAM table at $FFF000 (SH2 $0220F000) is unmapped. The $300500 slot now holds cmd25_single_shot.

#### Current Command Overhead Summary

| Function | Protocol | Calls/Frame | Cycles/Call | Total |
|----------|----------|-------------|-------------|-------|
| sh2_cmd_27 ($E3B4) | B-003 async (fire-and-forget) | 21 | ~70 | ~1,470 |
| sh2_send_cmd ($E35A) | B-004 single-shot | 14 | ~170 | ~2,380 |
| sh2_send_cmd_wait ($E316) | B-005 single-shot (scene init only) | 0 per frame | ~150 | 0 |
| **Total** | — | **35** | — | **~3,850** |

**Next optimization:** Real gains require offloading work from 68K to idle Master SH2 (Track 4), not further command overhead reduction.

---

### Track 3: Pipeline Overlap 🔥🔥 HIGH

**Goal:** Allow 68K to build frame N+1 commands while SH2 renders frame N
**Expected gain:** +15-30% FPS (requires Tracks 1-2 first)
**Risk:** Medium-High (frame coherency concerns)

#### The Problem

Currently, the 68K and SH2 operate in **strict lockstep**: the 68K cannot prepare the next frame's data until the SH2 finishes the current frame. This serializes the entire pipeline.

#### The Solution: Double-Buffered Command Lists

```
Frame N:     68K prepares → SH2 renders → complete
Frame N+1:                  68K prepares → SH2 renders → complete

With pipelining:
Frame N:     68K prepares → SH2 renders ────────────→ complete
Frame N+1:                  68K prepares → SH2 renders → complete
                            ↑ overlap ↑
```

**Implementation:**
1. Two command buffers in SDRAM (A and B)
2. 68K writes to buffer A while SH2 processes buffer B
3. Swap at frame boundary
4. Requires careful synchronization to prevent data races

**Prerequisite:** Track 1 (async commands) must be working first, since the 68K can't overlap if it's still blocking on each command.

---

### Track 4: 68K Work Offload 🔥 MEDIUM

**Goal:** Move non-rendering 68K computation to the idle Master SH2
**Expected gain:** +5-15% FPS
**Risk:** Medium (data coherency between CPUs)

#### The Opportunity

The Master SH2 is either completely idle (0% with hooks off) or lightly loaded (36% with hooks on). Meanwhile the 68K is 100% saturated. Offloading pure computation frees 68K cycles.

**Candidates for offload (ranked by PC profiling, March 2026):**

| Function | 68K Share | Useful Share | PCs | Offloadable? |
|----------|-----------|-------------|-----|-------------|
| Angle Normalization | 2.3% | 4.5% | 24 | **Yes** — pure math, no side effects |
| depth_sort | 2.1% | 4.2% | 11 | Maybe — already optimized (QW-4a), complex data deps |
| Physics Integration | 1.9% | 3.8% | 15 | **Yes** — deterministic computation |
| AI Opponent Select | 1.3% | 2.6% | 17 | Difficult — game state dependencies |
| sine_cosine_quadrant_lookup | 1.0% | 2.0% | 9 | **Yes** — table lookup, easily parallelized |
| rotational_offset_calc | 1.0% | 2.0% | 9 | **Yes** — pure math |

**Combined offload potential:** ~10.3% of useful 68K work (~5,300 useful cycles/frame)

**Note:** "Useful Share" column excludes the 49.4% V-blank sync time. Offloading these functions reduces useful work per game frame → fewer TV frames per game frame → higher FPS.

**68K Time Breakdown (PC profiling, March 2026):**
- **49.4%** — V-blank synchronization polling ($FF0010/$FF0014 `TST.W VINT_STATE.w`). This is the BIOS adapter main loop waiting for V-blank between frame iterations. **Not eliminable** — hardware frame sync barrier.
- **~10.8%** — SH2 command submission (sh2_cmd_27 COMM7 waits + sh2_send_cmd overhead). Reduced from ~22% by B-003/B-004/B-005.
- **~39.8%** — Useful game logic (physics, AI, rendering prep, state management). This is the budget where offloading helps.

**Data flow:** 68K writes inputs to shared SDRAM → signals Master SH2 → Master SH2 computes → writes results back → 68K reads results.

**Constraint:** Cache-through addressing (`0x2203xxxx`) required for all shared data to prevent stale cache reads.

#### Detailed Function Analysis (March 2026)

**Tier 1 — Immediate offload (no data marshaling):**

| Function | Address | Size | Input | Output | Data Access |
|----------|---------|------|-------|--------|-------------|
| `angle_normalize` | $00748C | 316B | D1, D2 (angles), A1 (ROM BSP ptr) | D0 (visibility) | ROM only |
| `sine_cosine_quadrant_lookup` | $008F4E/$8F52 | 58B | D0 (angle) | D0 (sin/cos value) | ROM table at $930000 |

Both are pure functions with register I/O and ROM-only data access. Can be reimplemented directly in SH2 expansion ROM. Combined: 5.5% of useful 68K work.

**Tier 2 — Deferred (require entity data in shared SDRAM):**

| Function | Address | Size | Data Dependency | Calls |
|----------|---------|------|----------------|-------|
| `physics_integration` | $00A666 | 144B | Entity struct @ Work RAM (+$06/+$30/+$34/+$40/+$54) | ai_steering, sin/cos |
| `rotational_offset_calc` | $00764E | 84B | Entity struct @ Work RAM (+$1E/+$20/+$22/+$30/+$34/+$72/+$E2) | sin/cos ×2 |

Both read/write entity data in 68K Work RAM ($FFxxxx), which SH2 cannot access. Offloading requires:
1. 68K copies entity fields to SDRAM scratchpad
2. Signal Master SH2 (CMDINT or COMM doorbell)
3. SH2 computes + writes results to SDRAM
4. 68K reads results back from SDRAM
Combined: 4.8% of useful 68K work.

**Implementation order:** Tier 1 first (angle_normalize → sine_cosine), then Tier 2 if additional gains needed.

---

### Track 5: VDP Polling Elimination ⬇️ MEDIUM-LOW

**Goal:** Replace SH2-side busy-wait VDP polling with interrupt-driven access
**Expected gain:** Variable (only helps if SH2 becomes the bottleneck after Tracks 1-4)
**Risk:** Medium (SH2 interrupt hardware bug requires workaround)

#### Context Shift

The original plan listed this as the #1 priority based on the assumption that SH2 VDP polling (~450K cycles) was the primary bottleneck. **Profiling disproved this.** The VDP polling loops are on the SH2 side, and the SH2 is NOT the constraint — the 68K is.

**However:** Once Tracks 1-4 free enough 68K cycles, the SH2 may become the bottleneck again. At that point, VDP polling elimination becomes relevant.

#### SH2 Interrupt Hardware Bug (Still Applies)

The original SH2 silicon has a documented interrupt bug (see [32x-hardware-manual-supplement-2.md](docs/32x-hardware-manual-supplement-2.md)). Any interrupt-driven approach must implement:

1. **FRT TOCR toggle** in every interrupt handler (corrective action for hardware bug)
2. **Only use interrupt levels** 14, 12, 10, 8, 6 (other levels reserved/restricted)
3. **Shared interrupt dispatcher** — all external interrupts route through one handler
4. **2+ cycle wait** after interrupt clear before RTE
5. **DMA restrictions** — no VDP access in H-interrupt during DMA

See the original plan's Track 1 section for the complete corrective action code template.

#### VDP Polling Locations (SH2 side)

| SH2 Address | Wait Condition | Frequency |
|-------------|---------------|-----------|
| $0243E2 | V-blank | 1/frame |
| $02441E | H-blank | Variable |
| $02443A | FIFO ready | Per polygon |
| $024482 | Frame buffer swap | 1/frame |

#### References
- [OPTIMIZATION_OPPORTUNITIES.md](analysis/optimization/OPTIMIZATION_OPPORTUNITIES.md) — Original VDP timing analysis
- [32x-hardware-manual-supplement-2.md](docs/32x-hardware-manual-supplement-2.md) — SH2 interrupt bug errata

---

### Track 6: SH2 Micro-Optimizations ⬇️ LOW

**Goal:** Optimize individual SH2 functions for fewer cycles
**Expected FPS gain:** 0% (SH2 is not the bottleneck)
**Value:** Capacity improvement — frees SH2 headroom for additional workload

#### Why Track 6 is Low Priority

Profiling proved that SH2 cycle reduction does NOT improve FPS:
- Eliminating 66.6% of Slave work (200K cycles) → 0% FPS change
- The delay loop experiment is definitive proof

**However**, these optimizations create SH2 headroom that enables Tracks 3-4 (more work for SH2 means it must be efficient enough to handle it).

#### Known Opportunities

| Optimization | Target | Cycle Savings | Status |
|-------------|--------|--------------|--------|
| coord_transform inlining | vertex_transform call chain | ~10% of vertex transform | ✅ Done in expansion ROM |
| MAC loop unrolling | Matrix multiply | ~15% of multiply | Designed, not implemented |
| ~~Frame buffer FIFO batching~~ | ~~Rasterizer~~ | ~~2.4x pixel write speed~~ | ❌ NOT feasible (B-009) |
| SDRAM 16-byte alignment | Data structures | Burst read improvement | Needs profiling |
| Delay loop reduction | Slave idle loop | 66.6% Slave reduction | ✅ Proven (no FPS gain) |

#### Frame Buffer FIFO Detail (Hardware) — ❌ NOT FEASIBLE (B-009)

The 32X frame buffer has a 4-word write FIFO:
- Single write: 3 clock cycles/word
- Burst write (4+ consecutive words): 5 cycles total = **1.25 cycles/word**

**Static analysis (March 2026) disproved this optimization:**
- `func_065` (unrolled_data_copy): Writes to **SDRAM**, not framebuffer. FIFO irrelevant.
- `edge_scan` (func_044): Scattered byte/word writes with variable stride. Cannot batch into 4-word bursts.
- `cmd_27` (inline_slave_drain): 512-byte stride between rows — non-sequential by design.
- **Bottom line:** SH2 is 78% utilized while 68K is at 100%. Even if FIFO bursts were possible, they wouldn't improve FPS.

#### References
- [OPTIMIZATION_OPPORTUNITIES.md](analysis/optimization/OPTIMIZATION_OPPORTUNITIES.md) — Hardware timing tables
- [FUNC_016_INLINING_INFEASIBILITY.md](analysis/optimization/FUNC_016_INLINING_INFEASIBILITY.md) — Why inlining at call sites failed
- [OPTIMIZATION_LESSONS_LEARNED.md](analysis/optimization/OPTIMIZATION_LESSONS_LEARNED.md) — What worked and what didn't

---

## Hardware Hazards and Constraints

### RV Bit — SH2 ROM Access Blocking

**Risk:** When RV=1 (ROM-to-VRAM DMA in progress), **ALL SH2 ROM access stalls** until 68000 clears it.

**Impact on expansion ROM:** Functions at $02300000+ would stall during any 68K ROM→VRAM DMA transfer.

**Status:** RESOLVED (B-008, 2026-02-16). VRD never sets RV=1. The game exclusively uses CPU Write mode (manual FIFO feeding via `$A15112`), never ROM-to-VRAM DMA. All 9 DREQ_CTRL writes use `#$04` (68S only, RV=0). Expansion ROM is safe for SH2 execution at all times. No SDRAM copy mitigation needed.

### FM Bit — VDP Access Preemption

**Risk:** Writing FM=1 **immediately preempts** any ongoing 68K VDP access, even mid-transfer. Can cause VRAM/CRAM/VSRAM corruption.

**Mitigation:** Only switch FM during V-Blank when VDP is idle.

### COMM Register Race Conditions

**Risk:** Simultaneous writes from 68K and SH2 to the same COMM register produce undefined values.

**Current usage:**
- COMM7 ($2000402E): Master→Slave signal — unidirectional (safe)
- COMM5 ($2000402A): Vertex transform counter — verify write direction

**Rule for async design:** Master SH2 queue must ensure 68K never writes COMM0/4/6 simultaneously with SH2 reads of those registers.

### CMDINT Behavioral Difference

Unlike VINT/HINT/PWMINT, the CMD interrupt is **negated when masked** and **re-asserted when unmasked** if the condition still exists. This affects the Master SH2 queue design:
- CMDINT can be used as a reliable trigger for queue processing
- No risk of lost interrupts (level-triggered behavior)
- Must still clear via CMD Clear register ($2000401A)

---

## Profiling Capabilities

### Available Tools

| Tool | Purpose | Status |
|------|---------|--------|
| `profiling_frontend` | Headless libretro frontend (frame-level profiling) | ✅ Working |
| `picodrive_libretro.so` | Custom PicoDrive core with instrumentation | ✅ Working |
| `analyze_profile.py` | Frame-level analysis (68K/MSH2/SSH2 cycles) | ✅ Working |
| `analyze_pc_profile.py` | PC-level hotspot analysis + function name resolution | ✅ Working |

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

## Implementation Roadmap

### Phase 1: Unblock Track 1 — Find 68K Space (Immediate)

**Goal:** Reclaim ~20 bytes in `$00E200` section (or find alternative) for async shim

**Tasks:**
1. Analyze all 68K modules in the `$00E200-$010200` section for dead code
2. Identify functions that are never called or have redundant paths
3. Verify with call graph analysis and profiling
4. If impossible: use banked-call trampoline to expansion ROM ($300000+, pending bank_probe test)

**Deliverable:** 20+ free bytes for `sh2_send_cmd_async` shim (or equivalent trampoline)

### Phase 2: Master SH2 Interrupt Queue

**Goal:** Implement CMDINT-driven command queue on Master SH2

**Tasks:**
1. Design ring buffer layout in SDRAM
2. Implement CMDINT handler in expansion ROM
3. Implement queue drain logic
4. Test with single command type (sh2_cmd_27)
5. Profile to verify 68K cycle savings

**Deliverable:** Working async command path for cmd_27

### Phase 3: Full Async Conversion

**Goal:** Convert all 35 command submissions to async

**Tasks:**
1. Convert remaining sh2_graphics_cmd calls
2. Handle 2 unsafe call sites (secondary RAM flag blocking)
3. Implement frame boundary sync
4. Full profiling pass

**Deliverable:** All commands async, 68K blocking reduced by ~60%

### Phase 4: Command Batching

**Goal:** Reduce number of submissions from 35 to ~3-5

**Tasks:**
1. Implement batch copy command ($26) handler
2. Group cmd_27 submissions into batches
3. Group graphics init commands
4. Profile batch overhead vs individual

**Deliverable:** 86-91% reduction in command submissions

### Phase 5: Activate v4.0 Parallel Processing

**Goal:** Enable Slave CPU vertex transform offload

**Tasks:**
1. Patch dispatch at $02046A (Master dispatch hook)
2. Patch trampoline at $0234C8 (vertex_transform redirect)
3. Verify Slave completes within frame budget
4. Profile combined async + parallel configuration

**Deliverable:** Dual-SH2 rendering active alongside async commands

### Phase 6: Measure and Iterate

**Goal:** Reach 60 FPS target

**Tasks:**
1. Full profiling of combined optimizations
2. Identify remaining bottleneck (68K? SH2? VDP?)
3. If SH2-bound: activate Track 5 (VDP polling elimination)
4. If 68K-bound: activate Track 4 (work offload)
5. Fine-tune and optimize

---

## Success Metrics

### Quantitative Goals

| Milestone | Expected FPS | Cumulative Gain | Track | Status |
|-----------|-------------|-----------------|-------|--------|
| Baseline (current) | 20-24 | — | — | ✅ Measured |
| Async cmd_27 (B-003) | ~20-24 | ~0% (68K still saturated) | Track 1 | ✅ Done |
| Single-shot cmd $22/$25 (B-004/B-005) | ~20-24 | ~0% (3.1% overhead only) | Track 1+2 | ✅ Done |
| + Pipeline overlap | TBD | TBD | Track 3 | ⏳ Planned |
| + Work offload to Master SH2 | TBD | TBD (highest potential) | Track 4 | ⏳ Planned |
| **Target** | **60+** | **+150%+** | All | ⏳ Goal |

> **Note (2026-03-03):** B-003/B-004/B-005 reduced command overhead from ~12,000 to ~3,850 cycles/frame, but FPS is unchanged because 68K is 100% utilized on non-command work. Real FPS gains require offloading 68K work to the idle Master SH2 (0% utilization).

### Validation Criteria

- ROM boots and runs correctly
- Full race completion (3+ laps) without glitches
- Graphics render correctly (no corruption)
- Audio synchronized
- Physics behavior unchanged
- FPS improvement measured with profiler (not estimated)

---

## Risk Analysis

### Track 1 Risks (Async Commands)

| Risk | Severity | Mitigation |
|------|----------|------------|
| COMM register corruption from async writes | High | Single-slot queue, Master SH2 serializes |
| 68K section has 0 bytes for async shim | Medium | Dead code reclamation, BSR trampoline, or banked-call to expansion ROM |
| CMDINT timing issues | Medium | CMDINT is level-triggered, reliable |
| Master SH2 queue overhead exceeds savings | Low | Master is 0% utilized, has massive headroom |

### Track 2 Risks (Batching) — RESOLVED

Track 2 risks are moot — batch approach was abandoned. Single-shot protocol (B-005) has no ordering or contention risks.

### Track 3 Risks (Pipeline Overlap)

| Risk | Severity | Mitigation |
|------|----------|------------|
| Frame N+1 reads stale frame N data | High | Double-buffer all shared state |
| Increased memory usage for double buffers | Medium | SDRAM has headroom |
| Input latency increase (+1 frame) | Low | Acceptable trade-off for 2x FPS |

### General Risks

| Risk | Severity | Mitigation |
|------|----------|------------|
| ~~RV bit blocks expansion ROM access~~ | ~~Medium~~ | RESOLVED: VRD never sets RV=1 (B-008) |
| FM bit preemption corrupts VDP state | Medium | Only switch FM during V-Blank |
| SH2 interrupt hardware bug | Medium | FRT TOCR toggle workaround (documented) |

---

## Abandoned Approaches

### 1. SH2-Only Optimization for FPS (Proven Ineffective)

**Evidence:** 66.6% Slave SH2 reduction → 0% FPS change. The 68K is the constraint.

**Implication:** coord_transform inlining, delay loop elimination, MAC loop unrolling — all valuable for headroom but cannot improve FPS alone.

### 2. 68K In-Section Async (Space Impossible)

**Evidence:** Section `$00E200-$010200` has 0 bytes free. Removed in commit `0dd98c4`.

**Alternative:** SH2 interrupt queue (Path B) — uses expansion ROM with 1MB free.

### 3. unrolled_data_copy FIFO Batching (Fall-Through Design)

**Evidence:** Function uses fall-through control flow (no RTS). Cannot be restructured without breaking all callers.

### 4. quad_helper-019 Optimization (Tightly Coupled)

**Evidence:** Shared code paths, cross-function branching, BSR range limits. Cannot be optimized in isolation.

### 5. Code Injection via ROM Patcher (Alignment Limits)

**Evidence:** Reached space/alignment constraints. Replaced by full disassembly/reassembly approach (current v5.0).

---

## Investigation Priorities

Items requiring empirical measurement before implementation:

1. ~~**RV bit during gameplay**~~ — RESOLVED (B-008): VRD never sets RV=1. Expansion ROM safe.
2. **68K dead code in $00E200 section** — Can we reclaim 20+ bytes for the async shim?
3. ~~**Frame buffer FIFO burst patterns**~~ — RESOLVED (B-009, March 2026): NOT feasible. func_065 writes SDRAM not framebuffer; edge_scan uses scattered byte/word writes; SH2 is not the bottleneck.
4. **SDRAM 16-byte alignment impact** — Do aligned data structures measurably improve burst reads?
5. ~~**68K PC-level hotspots**~~ — RESOLVED (March 2026): WRAM 49.4% is **V-blank sync** (not COMM polling). WRAM caller tracking confirmed: callers are state dispatchers/frame orchestrators. Useful work: SH2 Cmd 27 = 21.7%, Angle Norm = 4.5%, depth_sort = 4.2%, Physics = 3.8%. Saving 33% useful work → 30 FPS. See `tools/libretro-profiling/README_68K_PC_PROFILING.md`.

---

## Key Documents

### Architecture
- [ARCHITECTURAL_BOTTLENECK_ANALYSIS.md](analysis/ARCHITECTURAL_BOTTLENECK_ANALYSIS.md) — Root cause analysis
- [68K_SH2_COMMUNICATION.md](analysis/68K_SH2_COMMUNICATION.md) — Communication protocol
- [32X_REGISTERS.md](analysis/architecture/32X_REGISTERS.md) — Register reference with hazards

### Profiling
- [68K_BOTTLENECK_ANALYSIS.md](analysis/profiling/68K_BOTTLENECK_ANALYSIS.md) — **THE critical finding**
- [BASELINE_PROFILING_2026-01-29.md](analysis/profiling/BASELINE_PROFILING_2026-01-29.md) — Latest baseline
- [PERFORMANCE_BREAKTHROUGH_SUMMARY.md](analysis/profiling/PERFORMANCE_BREAKTHROUGH_SUMMARY.md) — Delay loop experiment

### Optimization Research
- [ASYNC_COMMAND_IMPLEMENTATION_PLAN.md](analysis/optimization/ASYNC_COMMAND_IMPLEMENTATION_PLAN.md) — Async design
- [SH2_ASYNC_QUEUE_ANALYSIS.md](analysis/optimization/SH2_ASYNC_QUEUE_ANALYSIS.md) — Path B analysis
- [COMM_REGISTER_USAGE_ANALYSIS.md](analysis/optimization/COMM_REGISTER_USAGE_ANALYSIS.md) — COMM collision analysis
- [BATCH_COPY_COMMAND_DESIGN.md](analysis/optimization/BATCH_COPY_COMMAND_DESIGN.md) — Batch command design
- [OPTIMIZATION_OPPORTUNITIES.md](analysis/optimization/OPTIMIZATION_OPPORTUNITIES.md) — Hardware timing tables
- [OPTIMIZATION_LESSONS_LEARNED.md](analysis/optimization/OPTIMIZATION_LESSONS_LEARNED.md) — What worked and what didn't

### Activation
- [ROADMAP_v4.1.md](analysis/optimization/ROADMAP_v4.1.md) — v4.0 activation plan
- [MASTER_SLAVE_ANALYSIS.md](analysis/architecture/MASTER_SLAVE_ANALYSIS.md) — Parallel processing design

---

**This plan reflects profiling data from January 2026 (frame-level) and March 2026 (PC-level hotspots + static analysis) confirming the 68K as the primary bottleneck. 49.4% of 68K time is V-blank sync (unavoidable), ~10.8% is command overhead (reduced by B-003/B-004/B-005), ~39.8% is useful work. Track 6 FIFO burst optimization disproved (B-009). Next priority: offload ~10.3% of useful work to idle Master SH2 (Track 4).**
