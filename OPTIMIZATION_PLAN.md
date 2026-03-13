# Virtua Racing 32X — Optimization Strategy

**Version:** v9.1 (S-4b speed compensation analysis)
**Last Updated:** March 13, 2026
**Baseline:** ~20 FPS (3 TV frames per game frame, measured)
**Primary Target:** 30 FPS (2 TV frames per game frame)
**Stretch Goal:** 60 FPS (requires pipeline overlap — see Phase 3)
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

### CPU Utilization (March 2026, Post-Optimization)

| CPU | Status | Utilization | Notes |
|-----|--------|-------------|-------|
| **68K** | Idle | **~48%** (51.89% STOP) | No longer the bottleneck |
| Master SH2 | Underutilized | 0–36% | COMM dispatch + block copies only |
| **Slave SH2** | **BOTTLENECK** | **78.3%** over 3 TV frames | 3D rendering (~2.35 TV frames of work) |

### Slave SH2 Hotspot Breakdown

| Function | % of Slave Frame | Cycles/Frame (est.) | Role |
|----------|-----------------|---------------------|------|
| Rasterization (total) | **52%** | ~154,000 | Pixel writes, edge walking |
| `coord_transform` (func_016) | **17%** | ~67,200 | Pack X/Y coords, called 4×/quad |
| `frustum_cull_short` (func_023) | **12%** | ~35,600 | Per-polygon visibility dispatch |
| `span_filler_short` (func_034) | **8%** | ~24,000 | Edge interpolation |
| Everything else | ~11% | ~32,600 | Matrix multiply, display list, etc. |

**Key file:** `analysis/sh2-analysis/SH2_3D_ENGINE_DEEP_DIVE.md`

### 68K Time Breakdown (PC Profiling, March 2026)

```
 51.89%  WRAM V-blank sync (STOP #$2300) — idle time
 10.52%  sh2_send_cmd COMM0_HI wait (14 calls/frame × ~940 cycles/call)
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

This means: **frame rate = max(3, ceil(SH2_render_time / TV_frame_duration))**. States 0 and 4 provide SH2 with 2 extra TV frames to render.

**Key files:**
- `disasm/modules/68k/game/state/state_disp_004cb8.asm` — 1P race dispatcher (5-entry table)
- `disasm/modules/68k/game/render/vdp_dma_frame_swap_037.asm` — V-INT handler with COMM1 check
- `disasm/modules/68k/main-loop/vint_handler.asm` — V-INT dispatch (21+ entry table at $0016B2)
- `disasm/modules/68k/game/scene/game_frame_orch_013.asm` — full game frame orchestrator

### FPS Threshold Model

```
Current:     Slave SH2 uses ~2.35 TV frames → needs 3 TV frames → ~20 FPS
30 FPS:      Slave SH2 must finish in ≤2 TV frames → need ~15% reduction
60 FPS:      Slave SH2 must finish in ≤1 TV frame → need ~57% reduction + pipeline overlap
```

**Key insight:** 68K cycle optimizations do NOT improve FPS — they just increase STOP time. FPS improves ONLY by reducing SH2 workload (fewer polygons, load balancing) or restructuring the frame pipeline.

---

## Phase 1 — 30 FPS (Reduce Slave SH2 to ≤2 TV frames + state merge)

The critical path: verify LOD culling reduces SH2 work → tune thresholds → merge state machine states.

### S-1: Entity Visibility Culling — DEAD END

**Status: Investigated and abandoned (March 2026).** Four independent profiling tests confirmed zero impact on any CPU. The entity descriptors at `$0600C344` are unused during racing.

**Status breakdown:**

| Sub-phase | Status | What |
|-----------|--------|------|
| S-1a: 68K LOD distance culling | **DONE** (80c54fc) | Entities >1536 units from player get D5/D6=0 |
| S-1b: Visibility bitmask comms | **DONE** (c5952c1) | 68K builds 15-bit bitmask, sends via COMM3 cmd $07 |
| S-1c: SH2 descriptor patching | **CODE COMPLETE** | Handler at $3011A0 patches 15 flags at $0600C344 (stride $14) |
| S-1d: Profile and verify impact | **DONE — ZERO IMPACT** | 4 tests: baseline, forced-cull, cache fix, entity-loop-skip — all identical cycles |
| S-1e: Threshold tuning | **CANCELLED** | No point tuning what has no effect |

**Why it failed:** The entity loop at `$06002C8C` (which checks descriptor flags at `$0600C344` with `MOV.W @(0,R14),R0 / CMP/EQ #0,R0 / BT .skip`) does **NOT execute during racing**. The entire call chain from Master cmd `$02` → scene orchestrator → entity loop callers is never triggered during autoplay race mode.

Racing uses the **Huffman renderer** at `$06004AD0` (Master cmd `$23`) and a completely different data structure at `$0600C800` (stride `$10`, byte flags, 32 entries) — not the entity descriptors at `$0600C344` (stride `$14`, word flags, 15 entries).

**Profiling evidence (4 tests, 2400-frame autoplay):**

| Test | Slave SH2 | Master SH2 | 68K |
|------|-----------|------------|-----|
| Baseline | 296,356 | 185,508 | 127,987 |
| Forced-cull (bitmask=$0000) | 296,355 | 185,511 | 127,987 |
| Cache fix + forced-cull | 296,355 | 185,511 | 127,987 |
| Entity loop force-skip | 296,355 | 185,511 | 127,987 |

**Architectural corrections discovered:**
- The PRIMARY dispatch loop at `$020460` is the **Master** SH2 (was incorrectly labeled Slave in earlier analysis)
- The Slave has a separate dispatch loop at `$020592` via hardware COMM2 (`$20004024`)
- The Slave is **NOT used for polygon rendering** — it handles palette, scene commands, and cmd_27 pixel ops
- 3D polygon rendering runs on the Master SH2

**Committed code:** S-1a (LOD culling) and S-1b (bitmask communication) remain in the codebase. The vis_bitmask_handler at `$3011A0` is functional but patches unused data. These may become useful if the entity descriptors are used in other game modes (non-racing scenes).

### S-4: Merge $C87E States 0+4 — IMPLEMENTED (2026-03-12)

The game takes 3 TV frames per game frame because states 0 and 4 each consume a full TV frame doing minimal work (VDP sync, sound, counters — well under 10,000 cycles total). Merging them into one state saves 1 TV frame. **S-1's failure does not block S-4** — the SH2 work already fits within 2 TV frames based on the Master SH2 profiling data (185K cycles / 128K per TV frame ≈ 1.45 TV frames).

**Implementation:** In each race dispatcher, `ADDQ.W #8,($FFFFC87E).w` replaces `ADDQ.W #4` — skips state 4 entirely. Achieves 30 FPS. Master SH2 load drops ~29.1%.

**Files:** `state_disp_004cb8.asm`, `state_disp_005020.asm`, `state_disp_005308.asm`, `state_disp_005618.asm`, `state_disp_005586.asm`

**Impact:** Achieves 2-TV-frame operation = **30 FPS**. No crashes.

**Game speed issue:** 30 FPS means 1.5× frame rate → 1.5× game speed because ALL timing uses fixed per-frame deltas with no delta-time system. This is solved by S-4b (speed compensation).

### S-4b: Speed Compensation for 30 FPS — PARTIAL (2026-03-12)

**Problem:** The game has no delta-time system. All physics, timers, and animations use fixed per-frame constants designed for 20 FPS (3 TV frames/game frame). At 30 FPS (2 TV frames), everything runs 1.5× too fast.

**Key discovery:** Timing is NOT scattered across 100+ sites. There are clear choke points — ~10 specific locations in 5 core functions, ~20 lines of assembly total.

**Changes applied (constant-only, zero section size change):**

| File | Change | Method |
|------|--------|--------|
| `race_entity_update_loop.asm` | Scale deceleration constants | `$2000→$1555`, `$1800→$1000` |
| `speed_interpolation.asm` | Scale smoothing multiplier | `$0284→$01AD` |
| `cascaded_frame_counter.asm` | Scale sub-tick reset | `$C4→$A6` (90 ticks at 30 FPS = 3 sec) |
| `ai_timer_inc.asm` | Scale sub-tick reset | `$C4→$A6` |

**Pending — target speed scaling:** Entity cruising speed is still 1.5× too fast. `entity_pos_update` reads speed from entity field A0+$06, multiplies by sin/cos for position delta. At 30 FPS, this runs 1.5× per second → entities move 1.5× too far per second.

Adding inline scaling (MULU #$AAAB + SWAP, 6 bytes) is impossible — both code_6200 and code_A200 are packed to exact section boundaries with hardcoded absolute address jump tables that break when code shifts (see KNOWN_ISSUES.md §Section Packing). Proven crash in attract mode.

**Primary approach — scale speed lookup table DATA by 2/3:**
- Table: 384 word entries at file offset $19DA4 (CPU $00899DA4), in section code_18200
- Referenced only by `speed_interpolation` via `LEA $00899DA4,A1`
- Zero code changes, zero section size impact
- Math: table_value × 2/3 → entity converges to lower speed → at 1.5× frame rate, movement/sec = (2/3 × target) × 30 = target × 20 = original
- The smoothing multiplier ($0284→$01AD) is INDEPENDENT — it controls convergence RATE, not the target value. Both scalings are needed and don't double-apply.
- **Caveat:** Entity speed (A0+$06) is also written by `entity_force_integration_and_speed_calc`, `entity_speed_acceleration_and_braking`, etc. These non-table code paths won't be scaled by this approach. Verify during testing whether non-table speeds cause visible issues.

**Alternative approach — scale D2 in entity_pos_update+70 callers:**
- The inner sub at `entity_pos_update+70` ($006FDE) is called from just 2 sites (entity_pos_update line 28, ai_entity_main_update_orch line 208). Both load D2 from A0+$06 just before calling.
- A wrapper that scales D2 before calling +70 would catch ALL speed sources, not just the table.
- Requires finding free space in a section reachable from both call sites, or restructuring the call to fit.

**Not viable:** Scaling inside entity_pos_update itself (code_6200 packed), scaling inside speed_interpolation (code_A200 packed).

### Phase 1 Critical Path

```
S-4 (state merge → 30 FPS) ✓ DONE
  → S-4b constant scaling ✓ DONE (decel, smoothing, timers)
  → S-4b target speed scaling ← NEXT: scale 384-entry speed table in code_18200
     Option A: Multiply all dc.w values at $19DA4 by 2/3 (data-only, safest)
     Option B: Wrap entity_pos_update+70 with D2 scaling (code, catches all speed sources)
  → Test in PicoDrive: verify 3D engine stability + game speed correctness
```

---

## Phase 2 — Headroom & 40+ FPS Foundation

These items can be worked in parallel once Phase 1 is validated. They deepen SH2 savings and prepare for 60 FPS.

### S-5: Behind-Camera Culling — NEEDS RE-EVALUATION

**Original design** depended on S-1 entity descriptor infrastructure, which targets unused data structures during racing. The concept (cull entities behind the camera) is sound, but the implementation needs to target the **correct data path** — either the Master cmd `$23` Huffman renderer's data at `$0600C800` or a new mechanism.

**Impact:** Unknown until the correct rendering data structure is understood.

**Risk:** Medium-High. Requires understanding how the Huffman renderer at `$06004AD0` selects which entities to render.

**Dependency:** Understanding Master cmd `$02`/`$23` data flow (new research needed).

### S-6: SH2 coord_transform Batching

`coord_transform` is the #1 Slave SH2 hotspot at **17% of frame time** (34 bytes, called 4× per quad by `quad_batch_short` / `quad_batch_alt_short`). Each call loads base X/Y values from the rendering context, but the 4 calls per quad reload the same base values 4 times.

**Implementation:** Replace 4 separate `BSR func_016` calls with a single batched function that processes all 4 vertices in one entry:
1. Load base values (fields at +$14 and +$18) once instead of 4 times
2. Pack all 4 output longwords in sequence
3. Eliminates 3 BSR/RTS pairs (~8 cycles each for pipeline refill)

**Savings estimate:** 3 redundant loads × 2 cycles × 800 quads + 3 BSR/RTS × 8 cycles × 800 quads = ~24,000 cycles/frame → **~6% of total Slave budget**.

**Risk:** Medium. Requires patching `quad_batch_short` and `quad_batch_alt_short` (SH2 dc.w format). Register pressure from handling 4 outputs simultaneously.

**Dependency:** None (independent).

**Files:** `disasm/sh2/3d_engine/coord_transform.asm`, quad_batch callers in `disasm/sh2/3d_engine/`

### S-7: SH2 DMAC for Block Copies

The SH7604 has a 2-channel DMA controller (DMAC) that is **completely unused** by VRD. The current `cmd22_single_shot` does word-by-word CPU copies. Replacing this with DMAC-initiated transfers frees the Master SH2 CPU for other work.

**Implementation:**
1. Master receives cmd $22 params via COMM registers (as now)
2. Instead of CPU word-loop, configure DMAC channel 0: SAR0=source, DAR0=dest, TCR0=word count, CHCR0=auto-request + word-size + increment
3. DMAC transfers data while Master CPU continues to the next command

**Complication:** Framebuffer has $0200 stride between lines (not contiguous). Options:
- One DMAC transfer per line with interrupt-on-completion to advance DAR to next line
- For contiguous SDRAM-to-SDRAM copies, DMAC is ideal (no stride issue)

**Impact:** Frees Master SH2 CPU → enables S-8. May reduce 68K's 10.52% COMM wait (Master completes commands faster).

**Risk:** Medium-High. DMAC and CPU share the external bus (contention). DMAC writes bypass the cache (coherence). Framebuffer DRAM is 16-bit wide, limiting actual throughput.

**DMAC registers:** SAR0=$FFFFFF80, DAR0=$FFFFFF84, TCR0=$FFFFFF88, CHCR0=$FFFFFF8C, DMAOR=$FFFFFFB0.

**Dependency:** None (but enables S-8).

**Files:** `disasm/sh2/expansion/cmd22_single_shot.asm`, SH7604 DMAC docs in `docs/sh7604-hardware-manual.md`

### S-8: Master SH2 as Vertex Transform Coprocessor

With Master freed from block copies (S-7), redirect it to vertex transformation. Currently Master is 0-36% utilized while Slave spends 17% on `coord_transform` + time on `matrix_multiply`.

**Implementation:**
1. Master receives entity geometry pointers via a new command (or extended cmd $22)
2. Master runs `matrix_multiply` + `coord_transform` on vertex data, writes transformed coordinates to SDRAM output buffers
3. Slave reads pre-transformed vertices, skips its own transform stage, proceeds directly to frustum culling and rasterization
4. Pipeline overlap: Master transforms entity N+1's vertices while Slave rasterizes entity N

**Impact:** ~6-8% direct Slave reduction + pipeline overlap benefit. With batching (S-6), the combined vertex transform savings could reach 15-20%.

**Risk:** High. Requires new inter-SH2 synchronization (Master signals when transforms are ready). SDRAM data race hazards on output buffers. Multiple dc.w patches in the Slave rendering pipeline.

**Dependency:** S-7 (DMAC must handle copies so Master is available for compute).

### S-9: Frustum Pre-Culling on 68K — NEEDS RE-EVALUATION

`frustum_cull_short` was attributed to the Slave SH2 at **12% of budget**, but the S-1d investigation revealed the Slave is NOT used for polygon rendering. The 3D pipeline runs on the **Master SH2**. The actual CPU and budget allocation for frustum culling needs re-measurement.

**Original concept** (coarse per-entity frustum test on 68K) remains valid, but the communication mechanism must target the correct data path (Master's Huffman renderer data at `$0600C800`), not the entity descriptors at `$0600C344`.

**Impact:** Unknown — requires re-profiling with Master/Slave distinction.

**Risk:** Medium. Depends on understanding the Huffman renderer's input format.

**Dependency:** Understanding Master cmd `$02`/`$23` data flow (new research needed).

### S-2: Reduce sh2_send_cmd Call Count (unchanged from v8.0)

Currently 14 `sh2_send_cmd` calls per frame. Some may be combinable (adjacent memory regions → single larger copy). Fewer calls → less Master SH2 dispatch overhead → less 68K COMM wait.

**Risk:** Low.

### Phase 2 Dependency Map

```
S-5 (behind-camera cull)     — NEEDS RE-EVALUATION (S-1 data structures unused)
S-6 (coord_transform batch)  — independent
S-7 (DMAC block copies)      → S-8 (Master vertex transform)
S-9 (frustum pre-cull)       — NEEDS RE-EVALUATION (must target correct rendering path)
S-2 (reduce cmd count)       — independent
NEW: Huffman renderer analysis — required to unlock S-5/S-9 alternatives
```

---

## Phase 3 — 60 FPS (Pipeline Overlap + Extreme Optimization)

Requires SH2 rendering in ≤1 TV frame (~57% reduction from 2.35). Needs both workload reduction (Phase 1+2) AND architectural changes.

### C-1: Double-Buffered Command Lists

Currently the 68K and SH2 operate on the same data buffers synchronously. Frame N+1 cannot begin until frame N's SH2 work is complete because the 68K would overwrite the buffers.

**Implementation:** Allocate two copies of the SDRAM entity descriptor area (~15 entities × 20 bytes = 300 bytes × 2 = 600 bytes). 68K writes to buffer A while SH2 renders buffer B. At frame boundary, swap buffer indices. Requires:
1. SH2 rendering context pointers updated per-frame to point at the correct buffer
2. 68K entity data writes must be consistent within each buffer
3. Frame swap includes buffer swap logic

**Impact:** Enables true frame N/N+1 pipeline overlap — 68K and SH2 work on different frames simultaneously.

**Risk:** High. Buffer management complexity, data consistency guarantees.

### C-2: Adaptive Frame Time Control

Replace the rigid $C87E state machine cycling with dynamic SH2-completion-driven frame starts. When V-INT detects COMM1_LO bit 0 (SH2 done), immediately begin the next game frame instead of waiting for the state machine to cycle through states 0/4/8.

**Impact:** Reduces frame time variability. If SH2 finishes in 1.5 TV frames, the game can start the next frame 0.5 TV frames earlier.

**Risk:** Medium. Sound driver timing, animation frame rates, and physics integration all assume a fixed relationship between TV frames and game frames. Variable frame rates may cause physics speed changes (needs delta-time integration).

**Dependency:** Phase 1 and Phase 2 complete.

### C-3: Entity Tick-Rate Reduction

Far entities (LOD-culled, invisible to SH2) still receive full 68K physics/AI/collision updates every game frame. For entities beyond 2× the LOD threshold, update every 2nd frame. Beyond 4×, every 4th frame.

**Implementation:** In `entity_render_pipeline_with_2_player_dispatch`, add per-entity frame counter check. Use entity index modulo + global frame counter to skip updates. Interpolate positions when entities re-enter LOD range.

**Impact:** Reduces 68K compute (~20-30% for far entities) and SDRAM write traffic. No direct FPS impact (far entities already culled visually), but reduces bus contention for SH2.

**Risk:** Low. Distant entity position lag is not noticeable. Interpolation smooths LOD boundary transitions.

### C-4: Reduced-Polygon LOD Models (Stretch Goal)

Instead of binary visible/invisible, introduce 2-3 LOD levels with different polygon counts per entity. Close: full model. Medium distance: half-polygon model. Far: invisible (current S-1 behavior).

**Impact:** Could halve polygon count for medium-distance entities → ~15-20% additional Slave reduction. Combined with S-1, could reach 50%+ total reduction.

**Risk:** Very High. Requires creating alternate model data in ROM (or procedurally generating simplified models). The entity rendering system's model pointer tables would need LOD-aware lookup. Original game has no LOD model infrastructure.

### Phase 3 Dependency Map

```
Phase 1+2 complete ──► C-1 (double-buffered commands) ──► C-2 (adaptive timing)
S-1 complete ──────── C-3 (tick-rate reduction) — independent
                      C-4 (LOD models) — long-term research, independent
```

---

## Impact Estimate Summary

| Item | SH2 Reduction | FPS Effect | Risk | Phase |
|------|---------------|------------|------|-------|
| ~~S-1 (LOD entity culling)~~ | ~~15-40%~~ **0% (DEAD END)** | None | — | ~~1~~ |
| **S-4 (state merge)** | 0% (saves 1 TV frame) | **30 FPS** | Low | 1 |
| S-5 (behind-camera cull) | 5-10% additive | Headroom | Medium | 2 |
| S-6 (coord_transform batch) | ~6% | Headroom | Medium | 2 |
| S-7 (DMAC copies) | 0% direct | Enables S-8 | Med-High | 2 |
| S-8 (Master vertex xform) | 6-8% + overlap | 40+ FPS potential | High | 2 |
| S-9 (frustum pre-cull) | 5-12% | Headroom | Medium | 2 |
| S-2 (reduce cmd count) | Indirect | Reduces COMM wait | Low | 2 |
| C-1 (double-buffer) | 0% direct | Enables 60 FPS | High | 3 |
| C-2 (adaptive timing) | 0% direct | Variable FPS | Medium | 3 |
| C-4 (LOD models) | 15-20% | 60 FPS potential | Very High | 3 |

**Cumulative estimate:** Phase 1 alone targets 30 FPS. Phase 1+2 combined could reach 37-76% Slave SH2 reduction → 40+ FPS. Phase 3 adds pipeline overlap for 60 FPS.

---

## Track QW: 68K Quality-of-Life — LOW PRIORITY

These don't improve FPS (68K has spare capacity) but are low-risk code improvements.

| ID | What | File | Savings | Risk |
|----|------|------|---------|------|
| QW-5 | DIVS #103 → multiply+shift | `game/physics/speed_interpolation.asm` | ~960 cyc/frame | Low |
| QW-6 | Combined sin/cos | `game/collision/rotational_offset_calc.asm` | ~1,216 cyc/frame | Low |
| QW-7 | Combined sin/cos | `game/physics/physics_integration.asm` | ~1,216 cyc/frame | Low |
| QW-8 | Factor distance calc | `game/ai/collision_avoidance_speed_calc.asm` | ~640 cyc/frame | Low |

---

## Completed Work

| Task | What | Cycles Saved | FPS Impact |
|------|------|-------------|------------|
| B-003 | Async cmd_27 via Slave COMM7 doorbell | ~4,000/frame | 0% |
| B-004 | Single-shot cmd_22 (expansion ROM handler) | ~1,792/frame | 0% |
| B-005 | Single-shot cmd_25 (scene init only) | Minimal | 0% |
| B-008 | RV bit profiling — never set, expansion ROM safe | N/A | 0% |
| B-009 | FIFO burst analysis — not feasible | N/A | 0% |
| M-001 | STOP instruction (V-blank sync) | ~73.6M/2400 frames | 0% (freed 68K) |
| M-002 | Insertion sort (depth_sort) | 85% reduction | 0% (freed 68K) |
| M-003 | Longword copy (cmd_22 handler) | ~2M/2400 frames | 0% (freed 68K) |
| S-1a | LOD distance culling (68K side) | 0 (entity descriptors unused during racing) | 0% |
| S-1b | Visibility bitmask communication (COMM3 cmd $07) | 0 (targets unused data structures) | 0% |
| S-1d | Profile and verify LOD impact (4 tests) | N/A | 0% — **proved S-1 is a dead end** |
| **Total (68K)** | | **~84M/2400 frames** | **0% — 68K freed from 100% → 48%** |

**Why 0% FPS gain from 68K work:** All savings freed 68K capacity. The Slave SH2 was always the true bottleneck.

### Key Lessons

1. **COMM offload cost model:** Synchronous offload of small, frequently-called functions via COMM registers is **anti-productive**. Rule: `computation_cycles >> handshake_overhead × call_count`.
2. **Fire-and-forget is blocked:** COMM0_HI is the game's frame synchronization barrier. Removing it → display corruption (B-005).
3. **68K optimization alone cannot improve FPS.** SH2 workload determines frame rate.
4. **Profiling reveals the truth:** The January 2026 "68K at 100.1%" was 49.4% spin-wait. STOP exposed the real bottleneck.

---

## Expansion ROM Status

```
$300000-$3FFFFF  1MB expansion space (SH2-executable only)

Active handlers (~2 KB used):
  $300500  cmd25_single_shot (64B) — B-005
  $300600  cmd27_queue_drain (128B) — B-003 (dormant, superseded by inline drain)
  $300700  slave_comm7_idle_check (64B) — B-003
  $3010F0  cmd22_single_shot (176B) — B-004 (longword copy + inline COMM cleanup)
  $3011A0  vis_bitmask_handler (64B) — S-1c (entity descriptor patcher)

Dormant infrastructure:
  $300028  handler_frame_sync (22B)
  $300050  master_dispatch_hook (44B) — B-006 (reverted, dead code)
  $300100  vertex_transform_optimized (96B)
  $300200  slave_work_wrapper (76B) — B-006 (reverted, dead code)
  $300800  cmdint_handler (64B) — reserved
  $300C00  queue_processor (128B) — reserved
  $301000  general_queue_drain (240B) — dormant
  $301178  angle_normalize SH2 handler (dormant, cmd $30)

Free from $3011E0: ~1,019 KB (99.8%)
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
| 68K cycle reduction for FPS | M-001/M-002/M-003 freed 68K from 100% → 48% → 0% FPS change | SH2 is the bottleneck, not 68K |
| S-1 entity visibility culling | Entity descriptors at $0600C344 are unused during racing. Loop at $06002C8C never executes. Racing uses Huffman renderer ($06004AD0) with different data ($0600C800, stride $10) | Always profile before assuming which data structures are active |
| FIFO burst optimization (B-009) | func_065 writes SDRAM not framebuffer | Static analysis before implementation |

---

## Profiling

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
| PC profiling (race avg) | 127,987 (100.1%) | 157,286 | 296,112 | 2026-03-08 |
| **Post-optimization** | **248.1M/2400f** (51.89% STOP) | 0–36% | 78.3% | **2026-03-11** |

---

## Key Documents

| Document | Purpose |
|----------|---------|
| [BACKLOG.md](BACKLOG.md) | Task queue with priorities and status |
| [KNOWN_ISSUES.md](KNOWN_ISSUES.md) | Pitfalls, hardware hazards, abandoned approaches |
| [COMM_REGISTERS_HARDWARE_ANALYSIS.md](analysis/COMM_REGISTERS_HARDWARE_ANALYSIS.md) | COMM hardware deep dive |
| [SH2_3D_ENGINE_DEEP_DIVE.md](analysis/sh2-analysis/SH2_3D_ENGINE_DEEP_DIVE.md) | 3D engine algorithms |
| [SH2_3D_PIPELINE_ARCHITECTURE.md](analysis/sh2-analysis/SH2_3D_PIPELINE_ARCHITECTURE.md) | 3D pipeline for load balancing research |
| [SYSTEM_EXECUTION_FLOW.md](analysis/SYSTEM_EXECUTION_FLOW.md) | Per-frame execution order |
| [RENDERING_PIPELINE.md](analysis/RENDERING_PIPELINE.md) | End-to-end rendering flow |
| [sh7604-hardware-manual.md](docs/sh7604-hardware-manual.md) | SH7604 CPU + DMAC datasheet |

---

## History (Retired Tracks)

| Former Track | Status | Reason |
|-------------|--------|--------|
| Track 1 (68K Blocking Relief) | Subsumed by Track A → deprioritized | Original CMDINT queue design over-engineered |
| Track 2 (Command Protocol) | DONE | Command overhead optimized by B-003/B-004/B-005 |
| Track 5 (VDP Polling) | Irrelevant | 68K no longer the bottleneck |
| Track 6 (SH2 Micro-Opts) | Subsumed by Track S | Direct SH2 workload reduction is the correct approach |
| Track A (cmd_22 Queue Decoupling) | Subsumed by S-7 (DMAC) | DMAC hardware solution superior to software queue |
| Track B (Batched Offload) | Subsumed by S-8/S-9 | Specific offload targets (vertex transform, frustum cull) replace generic "batch math" |
| B-006 (Parallel Hooks) | REVERTED | COMM7 namespace collision, literal pool corruption, R0 clobber |
