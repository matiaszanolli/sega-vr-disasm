# Virtua Racing 32X — Optimization Strategy

**Version:** v8.0 (major reassessment — SH2 bottleneck discovery)
**Last Updated:** March 11, 2026
**Baseline:** ~20 FPS (3 TV frames per game frame, measured)
**Primary Target:** 30 FPS (2 TV frames per game frame)
**Stretch Goal:** 60 FPS (requires pipeline overlap — see Track C)
**Approach:** Data-driven, SH2-workload-first

---

## Ground Truth (March 2026)

### The Slave SH2 Is THE Bottleneck (Proven)

After March 2026 optimizations (STOP instruction, insertion sort, longword copy), the 68K is **no longer the bottleneck**. It sits idle 51.89% of the time. The Slave SH2 at 78.3% utilization over 3 TV frames (~2.35 TV frames of work) determines the frame rate.

**Evidence:**
1. 68K STOP time is **51.89%** — massive spare capacity
2. Previous experiment: 66.6% Slave SH2 reduction → 0% FPS change (delay loop removed idle loop, not real work)
3. Frame rate is controlled by SH2 completion signal (COMM1_LO bit 0) — see V-INT State Machine section
4. Reducing 68K COMM overhead by ~8,150 cycles (B-003/B-004/B-005) produced 0% FPS change — saved cycles became STOP time

**Historical note:** The 68K WAS the bottleneck before March 2026. Three optimizations changed this:
- STOP instruction replaced V-blank spin-wait → freed ~73.6M cycles across 2400 frames
- Insertion sort replaced selection sort in `scroll_pos_decrement` → 85% reduction
- Longword copy in cmd_22 handler → ~2M cycle reduction in COMM wait

### CPU Utilization (March 2026, Post-Optimization)

| CPU | Status | Utilization | Notes |
|-----|--------|-------------|-------|
| **68K** | Idle | **~48%** (51.89% STOP) | No longer the bottleneck |
| Master SH2 | Underutilized | 0–36% | COMM dispatch + block copies |
| **Slave SH2** | **BOTTLENECK** | **78.3%** over 3 TV frames | 3D rendering (~2.35 TV frames of work) |

### 68K Time Breakdown (PC Profiling, March 2026 — Optimized Build)

```
 51.89%  WRAM V-blank sync (STOP #$2300)
         └─ Idle time — 68K waiting for V-INT

 10.52%  sh2_send_cmd COMM0_HI wait (cmd_22 block copies)
         └─ 14 calls/frame × ~940 cycles/call
         └─ 68K waits for Master SH2 to complete each block copy

  2.37%  Menu tile copy (menu-only, not race-relevant)
  2.31%  Angle normalization/visibility checks
  1.91%  Physics integration
  1.34%  collision_avoidance_speed_calc
  0.99%  sine_cosine_quadrant_lookup
  0.97%  rotational_offset_calc
 ~27.7%  Everything else

Total: 248.1M cycles across 2400 frames (~103,375 cycles/frame)
Active work per TV frame: ~49,725 cycles (of ~128,000 budget)
```

### V-INT State Machine (Race Mode)

The main loop at $FF0000 iterates once per TV frame:
```
JSR [$FF0002]          ; call frame handler (self-modifying)
MOVE.W #state,$C87A    ; set V-INT dispatch state (self-modifying at $FF0008)
STOP #$2300            ; halt until V-INT
BRA.S loop
```

Race mode dispatchers use an **adaptive** jump table on `$C87E`:

| $C87E | Work Done | V-INT State | Purpose |
|-------|-----------|-------------|---------|
| 0 | VDP sync, sound, counter | $0010 (minimal) | Give SH2 render time |
| 4 | Sound, counter, COMM check | $0010 (minimal) | Give SH2 render time |
| **8** | **FULL game frame** (entities, physics, AI, rendering) | **$0054** (race render) | All game logic + send render commands |
| 12 | Minimal fallback | $0054 | Graceful degradation |
| 16 | Secondary dispatcher | $0020 | Extreme fallback |

**The adaptive mechanism:** V-INT state $0054 (`vdp_dma_frame_swap_037` at $001D0C) checks COMM1_LO bit 0:
- **COMM1 set** (SH2 done rendering) → reset $C87E to 0 + flip frame buffer → new game frame
- **COMM1 not set** (SH2 still rendering) → $C87E keeps incrementing → fallback handlers

This means: **frame rate = max(3, ceil(SH2_render_time / TV_frame_duration))**. States 0 and 4 provide SH2 with 2 extra TV frames to render. The number of TV frames per game frame is determined entirely by when SH2 finishes.

**Key files:**
- `disasm/modules/68k/game/state/state_disp_004cb8.asm` — 1P race dispatcher (5-entry table)
- `disasm/modules/68k/game/render/vdp_dma_frame_swap_037.asm` — V-INT handler with COMM1 check
- `disasm/modules/68k/main-loop/vint_handler.asm` — V-INT dispatch (21+ entry table at $0016B2)
- `disasm/modules/68k/game/scene/game_frame_orch_013.asm` — full game frame orchestrator

### FPS Threshold Model (Revised)

The game takes N TV frames per game frame, determined by SH2 render time:

```
Current:     Slave SH2 uses ~2.35 TV frames → needs 3 TV frames → ~20 FPS
30 FPS:      Slave SH2 must finish in ≤2 TV frames → need ~15% reduction
60 FPS:      Slave SH2 must finish in ≤1 TV frame → need ~60% reduction + Track C
```

**Key insight:** 68K cycle optimizations do NOT improve FPS — they just increase STOP time. FPS improves ONLY by reducing SH2 workload (fewer polygons, load balancing) or restructuring the frame pipeline.

---

## Completed Work

| Task | What | Cycles Saved | FPS Impact |
|------|------|-------------|------------|
| B-003 | Async cmd_27 via Slave COMM7 doorbell | ~4,000/frame | 0% |
| B-004 | Single-shot cmd_22 (expansion ROM handler) | ~1,792/frame | 0% |
| B-005 | Single-shot cmd_25 (scene init only) | Minimal | 0% |
| B-008 | RV bit profiling — never set, expansion ROM safe | N/A | 0% |
| B-009 | FIFO burst analysis — not feasible | N/A | 0% |
| M-001 | STOP instruction (V-blank sync) | ~73.6M/2400 frames | 0% (freed 68K capacity) |
| M-002 | Insertion sort (depth_sort) | 85% reduction in scroll_pos_decrement | 0% (freed 68K capacity) |
| M-003 | Longword copy (cmd_22 handler) | ~2M/2400 frames | 0% (freed 68K capacity) |
| **Total** | | **~84M/2400 frames** | **0% — 68K freed, SH2 unchanged** |

**Why 0% FPS gain:** All savings freed 68K capacity (from 100.1% → ~48%). The Slave SH2 was always the true bottleneck — the 68K was just masked by spin-wait loops that made it appear saturated.

### Key Lessons from Completed Work

1. **COMM offload cost model:** Synchronous offload of small, frequently-called functions via COMM registers is **anti-productive**. `angle_normalize` (8×/frame, ~1,500 cyc native) added 23% 68K overhead from COMM0_HI polling. Rule: `computation_cycles >> handshake_overhead × call_count`.

2. **Fire-and-forget is blocked:** COMM0_HI is the game's frame synchronization barrier. Removing it desynchronizes the 68K/SH2 frame pipeline → display corruption.

3. **68K optimization alone cannot improve FPS:** M-001/M-002/M-003 freed massive 68K capacity (100% → 48%) but changed 0% FPS. The bottleneck is Slave SH2 render time.

4. **Profiling reveals the truth:** The January 2026 "68K at 100.1%" was accurate but misleading — the 68K was wasting 49.4% on spin-wait. After replacing with STOP, the true utilization (~48%) exposed the real bottleneck.

---

## Active Tracks

### Track S: SH2 Workload Reduction — HIGHEST PRIORITY

The only path to 30 FPS. Reduce what gets sent to SH2 for rendering.

#### S-1: LOD-Based Render Culling (HIGHEST IMPACT)

**Goal:** Don't send distant entities' 3D geometry to SH2 for rendering.

The 68K side controls what gets sent via `sh2_send_cmd` (cmd_22). The entity render pipeline determines which entities get rendered. By skipping render commands for distant entities, Slave SH2 has fewer polygons to transform and rasterize.

**Implementation:** In `race_entity_update_loop`, use the sort key from `race_pos_sorting_and_rank_assignment` as a distance proxy. Entities ranked >8 positions behind the player: skip their render commands but keep minimal position tracking.

**Files:**
- `disasm/modules/68k/game/race/race_entity_update_loop.asm`
- `disasm/modules/68k/game/render/entity_render_pipeline_with_2_player_dispatch.asm`

**Expected impact:** 8 of 15 AI entities culled → ~47% fewer 3D objects → Slave SH2 drops from ~2.35 to ~1.5 TV frames → **30 FPS achievable**

**Risk:** Medium — distant cars invisible. Mitigate with 68K VDP placeholder sprites.

#### S-2: Reduce sh2_send_cmd Call Count

Currently 14 `sh2_send_cmd` calls per frame. Some may be combinable (adjacent memory regions → single larger copy).

**Expected impact:** Fewer calls → less Master SH2 work → freed capacity for load balancing.

**Risk:** Low.

#### S-3: Master-to-Slave SH2 Load Balancing

Master SH2 is 0-36% utilized while Slave is at 78.3%. If rendering work can be moved from Slave to Master, total render time decreases.

**Research needed:** Understand Slave SH2 rendering pipeline. See `analysis/sh2-analysis/SH2_3D_PIPELINE_ARCHITECTURE.md`.

**Risk:** High — SH2 code is in dc.w format.

#### S-4: Merge $C87E States 0+4

If SH2 finishes rendering in 2 TV frames (via S-1), the game still takes 3 TV frames because states 0 and 4 each consume a TV frame. Merging them into a single state that does both sets of work in 1 TV frame saves 1 TV frame.

**Implementation:** Combine the state 0 and state 4 handlers in each race dispatcher. Advance $C87E by 8 instead of 4. The state 8 V-INT ($0054) checks COMM1 as before.

**Files:** All race state dispatchers (`state_disp_004cb8.asm`, `state_disp_005020.asm`, `state_disp_005308.asm`, `state_disp_005618.asm`)

**Risk:** Low — states 0 and 4 do minimal work.

**Prerequisite:** S-1 must reduce SH2 render time to ≤2 TV frames first, or this saves nothing (game falls through to state 12 fallback).

---

### Track QW: 68K Quality-of-Life Optimizations — LOW PRIORITY

These don't improve FPS (68K has spare capacity) but are low-risk improvements.

#### QW-5: DIVS #103 → multiply+shift in speed_interpolation

**File:** `disasm/modules/68k/game/physics/speed_interpolation.asm`
Replace `divs.w #$0067,d1` (~130 cycles) with `muls.w #$00A1,d1` + ASR.L (~70 cycles).
Savings: ~960 cycles/frame. Risk: Low.

#### QW-6: Combined sine/cosine in rotational_offset_calc

**File:** `disasm/modules/68k/game/collision/rotational_offset_calc.asm`
Inline combined sin/cos for same angle, saving duplicate JSR + angle normalization.
Savings: ~1,216 cycles/frame. Risk: Low.

#### QW-7: Combined sine/cosine in physics_integration

**File:** `disasm/modules/68k/game/physics/physics_integration.asm`
Same pattern as QW-6 for angle `$40(A0)`.
Savings: ~1,216 cycles/frame. Risk: Low.

#### QW-8: Factor distance computation in collision_avoidance_speed_calc

**File:** `disasm/modules/68k/game/ai/collision_avoidance_speed_calc.asm`
Factor duplicate Manhattan distance into BSR subroutine.
Savings: ~640 cycles/frame. Risk: Low.

---

### Track A: cmd_22 Queue Decoupling — REVISED PRIORITY (was Highest, now Medium)

**Revised assessment:** With the SH2 bottleneck discovery, this optimization's importance dropped significantly. The 10.52% COMM0_HI wait becomes STOP time if eliminated — no FPS change. However, it could enable Master SH2 load balancing (S-3) by freeing Master SH2 from block copy duties.

**Stale data corrected:** The previous claim that "cmd_27 COMM7 waits: 21.7% of useful work" was wrong. cmd_27 is already fire-and-forget (B-003) and doesn't appear in the top 200 PCs. The real COMM bottleneck is cmd_22 (sh2_send_cmd) at 10.52%.

**Design:** Modify cmd22_single_shot to separate "param intake" from "block copy":
1. Master SH2 reads COMM2-6 params → copies to SDRAM queue → clears COMM0_HI immediately
2. Processes queue entries asynchronously (actual block copies)
3. 68K waits only for param intake (~10-30 cycles vs ~940)

**Files:**
- `disasm/sections/code_e200.asm` — sh2_send_cmd 68K side
- `disasm/sh2/expansion/cmd22_single_shot.asm` — queue management rewrite
- `disasm/sections/expansion_300000.asm` — handler placement

**Savings:** 13 calls × ~930 cycles = ~12,090 cycles/frame → becomes STOP time (no FPS impact directly)
**Risk:** Medium-High. Queue overflow if >16 calls/frame. COMM0_HI early-clear timing critical.

---

### Track B: Batched Work Offload — DEPRIORITIZED

**Status:** Deprioritized. 68K has 51.89% idle time — offloading 68K work to Master SH2 doesn't improve FPS. Only relevant if future changes increase 68K utilization beyond 100%.

Retained for reference. See v7.0 of this document for full Track B design.

---

### Track C: Pipeline Overlap — STRETCH GOAL

**Goal:** Allow 68K to prepare frame N+1 while SH2 renders frame N.
**Status:** Research only. Requires Track S first.

Note: The current pipeline already has 1-frame overlap (68K sends commands at state 8, SH2 renders during next game frame). Track C would deepen this overlap to achieve 60 FPS.

---

## Retired Tracks

| Former Track | Status | Reason |
|-------------|--------|--------|
| Track 1 (68K Blocking Relief) | Subsumed by Track A | Original CMDINT queue design was over-engineered |
| Track 2 (Command Protocol) | DONE | Command overhead optimized by B-003/B-004/B-005 |
| Track 5 (VDP Polling) | Irrelevant | 68K no longer the bottleneck |
| Track 6 (SH2 Micro-Opts) | Subsumed by Track S | Direct SH2 workload reduction is the correct approach |
| B-006 (Parallel Hooks) | REVERTED | COMM7 namespace collision, literal pool corruption, R0 clobber |
| Track B (Batched Offload) | Deprioritized | 68K has 51.89% idle time — offloading doesn't help FPS |

---

## FPS Target Analysis (Revised March 2026)

### 30 FPS — Primary Target

The bottleneck is Slave SH2 render time (~2.35 TV frames). To achieve 30 FPS:

| Lever | What It Does | Impact |
|-------|-------------|--------|
| **S-1: LOD culling** | Fewer polygons sent to SH2 | **~15-47% SH2 reduction** |
| S-4: Merge states 0+4 | Saves 1 TV frame of 68K idle time | Enables 2-frame operation |
| S-2: Batch copies | Frees Master SH2 capacity | Indirect |
| S-3: Load balancing | Moves Slave work to Master | Direct SH2 reduction |

**Critical path:** S-1 (reduce Slave SH2 from 2.35 to ≤2.0 TV frames) + S-4 (merge states so game uses 2 TV frames instead of 3).

### 60 FPS — Stretch Goal

Requires SH2 rendering in ≤1 TV frame (~60% reduction) plus Track C (pipeline overlap). Not achievable through Tracks S alone.

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
| Synchronous COMM offload (angle_normalize) | Handshake overhead 25× > computation saved | Batch required for COMM offload |
| Fire-and-forget cmd_22 | COMM0_HI is frame sync barrier → display corruption | .wait_ready is implicit load-balancing |
| Blanket async general commands | Buffer aliasing — 68K overwrites before SH2 replays | Async requires per-call-site dependency analysis |
| B-006 parallel hooks (3 patches) | COMM7 namespace collision, literal pool corruption | Never conflate game and expansion namespaces |
| Work RAM ring buffer for SH2 | SH2 cannot access 68K Work RAM ($FFxxxx) | Always check hardware manual memory map |
| 68K in-section async queue | 0 bytes free in $E200 section | Use in-place replacement or expansion ROM |
| SH2-only optimization for FPS | 66.6% Slave reduction → 0% FPS (removed idle loop, not real work) | The delay loop experiment removed IDLE time, not rendering work |
| 68K cycle reduction for FPS | M-001/M-002/M-003 freed 68K from 100% → 48% → 0% FPS change | SH2 is the bottleneck, not 68K |
| FIFO burst optimization (B-009) | func_065 writes SDRAM not framebuffer | Static analysis before implementation |

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
| **Post-optimization** | **248.1M/2400f** (51.89% STOP) | 0–36% | 78.3% | **2026-03-11** |

---

## Key Documents

| Document | Purpose |
|----------|---------|
| [BACKLOG.md](BACKLOG.md) | Task queue with priorities and status |
| [KNOWN_ISSUES.md](KNOWN_ISSUES.md) | Pitfalls, hardware hazards, abandoned approaches |
| [COMM_REGISTERS_HARDWARE_ANALYSIS.md](analysis/COMM_REGISTERS_HARDWARE_ANALYSIS.md) | COMM hardware deep dive |
| [MASTER_SH2_DISPATCH_ANALYSIS.md](analysis/architecture/MASTER_SH2_DISPATCH_ANALYSIS.md) | Dispatch mechanism + B-006 crash analysis |
| [SH2_3D_ENGINE_DEEP_DIVE.md](analysis/sh2-analysis/SH2_3D_ENGINE_DEEP_DIVE.md) | 3D engine algorithms |
| [SH2_3D_PIPELINE_ARCHITECTURE.md](analysis/sh2-analysis/SH2_3D_PIPELINE_ARCHITECTURE.md) | 3D pipeline for load balancing research |
| [SYSTEM_EXECUTION_FLOW.md](analysis/SYSTEM_EXECUTION_FLOW.md) | Per-frame execution order |
| [RENDERING_PIPELINE.md](analysis/RENDERING_PIPELINE.md) | End-to-end rendering flow |
| [68K_PC_PROFILING.md](tools/libretro-profiling/README_68K_PC_PROFILING.md) | Profiling methodology |

---

**This plan is grounded in PC profiling data from March 2026 and deep V-INT state machine investigation. The 68K has 51.89% idle time (STOP) and is NOT the bottleneck. The Slave SH2 at 78.3% utilization (~2.35 TV frames of 3D rendering work) determines the frame rate. The path to 30 FPS is reducing SH2 workload via LOD-based render culling (Track S-1, ~15-47% SH2 reduction) and merging $C87E states to enable 2-TV-frame operation (S-4). 60 FPS requires pipeline overlap (Track C) — research only until 30 FPS is achieved.**
