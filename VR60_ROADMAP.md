# VR60 Roadmap — Ground-Up Architectural Redesign

**Created:** 2026-03-17
**Branch:** vr60 (independent, no backwards compatibility constraints)
**Goal:** Redesign the game's core to use all three CPUs optimally with zero bottlenecks
**Pace:** Methodical. Every decision backed by evidence. No rushing.

---

## Table of Contents

1. [Current State Baseline](#1-current-state-baseline)
2. [Target Architecture](#2-target-architecture)
3. [Hard Hardware Constraints](#3-hard-hardware-constraints)
4. [Phase 0: Infrastructure](#4-phase-0-infrastructure)
5. [Phase 1: Entity Table Relocation](#5-phase-1-entity-table-relocation)
6. [Phase 2: Entity Projection Port](#6-phase-2-entity-projection-port)
7. [Phase 3: Physics Port](#7-phase-3-physics-port)
8. [Phase 4: AI Port](#8-phase-4-ai-port)
9. [Phase 5: Collision Port](#9-phase-5-collision-port)
10. [Phase 6: Pipeline Overlap](#10-phase-6-pipeline-overlap)
11. [Phase 7: 60 FPS Game Logic](#11-phase-7-60-fps-game-logic)
12. [Open Questions & Unknowns](#12-open-questions--unknowns)
13. [Decision Log](#13-decision-log)
14. [Risk Registry](#14-risk-registry)
15. [Measurement Protocol](#15-measurement-protocol)
16. [Lessons Learned](#16-lessons-learned)

---

## 1. Current State Baseline

### 1.1 CPU Utilization (Profiled March 2026, 40 FPS Camera Interpolation)

| CPU | Clock | Budget/Frame | Used/Frame | Utilization | Role |
|-----|-------|-------------|-----------|-------------|------|
| 68K | 7.67 MHz | 127,833 | 127,987 | **100.1%** | ALL game logic + I/O + sound |
| Master SH2 | 23.01 MHz | 383,333 | 127,061 | **33%** | Command router + block copies |
| Slave SH2 | 23.01 MHz | 383,333 | 299,926 | **78%** | ALL 3D rendering |

**Evidence:** `analysis/ARCHITECTURAL_BOTTLENECK_ANALYSIS.md`, `analysis/profiling/68K_BOTTLENECK_ANALYSIS.md`

### 1.2 68K Time Breakdown

| Component | Cycles | % | Source |
|-----------|--------|---|--------|
| V-blank STOP spin | 66,243 | 51.89% | Idle wait — unavoidable frame barrier |
| COMM0_HI handshake wait | 13,437 | 10.52% | 14× sh2_send_cmd per frame |
| Physics integration | 2,438 | 1.91% | entity_force_integration |
| Angle normalize + visibility | 2,953 | 2.31% | Trig lookups |
| Collision avoidance | 1,712 | 1.34% | AI speed calc |
| All other game logic | ~41,204 | 32.03% | Entity mgmt, state, rendering prep, sound |

**Key insight:** Only ~48K cycles are actual compute. 62% is wasted waiting.
**Evidence:** `tools/libretro-profiling/` PC-level profiling, March 2026

### 1.3 Slave SH2 Rendering Breakdown

| Function | Cycles | % of Slave | Status |
|----------|--------|-----------|--------|
| Rasterization (total) | 154,000 | 52% | Core bottleneck |
| coord_transform | 35,600 | 12% | S-6 inlined (was 17%) |
| frustum_cull_short | 35,600 | 12% | Optimization target |
| span_filler_short | 24,000 | 8% | Tight inner loop |
| matrix_multiply | 18,000 | 6% | MAC unit |
| Idle delay loop | 478M/719M | 66.5% | Architectural idle |

**Evidence:** `analysis/sh2-analysis/SH2_3D_ENGINE_DEEP_DIVE.md`, PC profiling at $06000608

### 1.4 Communication Bottleneck

| Sync Point | Who Blocks | Duration | Fundamental? |
|-----------|-----------|----------|-------------|
| COMM0_HI (sh2_send_cmd ×14) | 68K on Master | 200-500 cyc/call | **Artificial** — design choice |
| COMM1_LO bit 0 (frame done) | 68K V-INT on Master | 0-1000 cyc | **Fundamental** — frame sync |
| COMM7 (cmd_27 doorbell ×21) | 68K on Slave | 10-30 cyc/call | **Optimized** (B-003) |
| COMM1_LO bit 1 (DMA ack) | 68K on Slave | 100-300 cyc | **Artificial** |

**Evidence:** `analysis/SYSTEM_EXECUTION_FLOW.md`, `analysis/68K_SH2_COMMUNICATION.md`

### 1.5 Current Data Flow

```
68K WRAM $FF9000 (entity tables, 25 entities × 256B)
  → [68K: physics, AI, collision @ 7.67 MHz]
  → 68K WRAM $FF6218 (display objects, 15 × 60B)
  → [68K: object_table_sprite_param_update]
  → 68K WRAM $FF6000 (2560B FIFO source)
  → [68K: mars_dma_xfer_vdp_fill via DREQ FIFO]
  → [14× sh2_send_cmd COMM handshake — 10.52% bottleneck]
  → SH2 SDRAM $0600C000+ (entity descriptors)
  → [Slave: Pipeline 1 (SRAM) + Pipeline 2 (SDRAM)]
  → Frame Buffer $04000000
```

**Every step serialized through the 68K and COMM registers.**
**Evidence:** `analysis/ENTITY_OBJECT_ARCHITECTURE.md` §7, `analysis/RENDERING_PIPELINE.md`

---

## 2. Target Architecture

### 2.1 New CPU Roles

| CPU | New Role | Target Util | Evidence for Feasibility |
|-----|---------|------------|--------------------------|
| **68K** | Thin coordinator: I/O, sound, VDP, scene state | <30% | Sound driver MUST stay on 68K (YM2612/PSG/Z80 are 68K peripherals). VDP is 68K-addressed. Controller ports are 68K-only. Everything else can move. |
| **Master SH2** | Game logic engine: physics, AI, collision, entity management, camera | 40-60% | 256K cycles/frame idle. 48K 68K cycles = ~16K SH2-equivalent (3× clock). All game logic uses integer arithmetic + ROM table lookups — fully portable to SH2. |
| **Slave SH2** | Rendering engine (unchanged role) | 50-78% | Already works. Fed data from SDRAM (same as now, but Master writes directly instead of FIFO). |

### 2.2 Key Design Changes

| Change | Current | Proposed | Why |
|--------|---------|----------|-----|
| Entity table location | 68K WRAM $FF9000 | SDRAM $0600F20C | SH2 can't access WRAM. SDRAM accessible by both SH2s. Original $06008000 BLOCKED by gradient strip B at $060086D4. |
| Data transfer to SH2 | DREQ FIFO + 14× COMM handshake | Master writes SDRAM directly | Eliminates 10.52% COMM bottleneck entirely |
| Game logic CPU | 68K @ 7.67 MHz | Master SH2 @ 23 MHz | 3× clock, plus MAC unit for multiply-heavy physics |
| Master→Slave signaling | Via 68K relay (COMM2) | Master writes SDRAM, then COMM2 trigger | One handshake instead of 14 |
| Frame sync | COMM1_LO bit 0 checked by 68K V-INT | Same (unchanged) | This is fundamental, keep it |

### 2.3 New Data Flow

```
68K: read controllers → write SDRAM mailbox → trigger Master (1 COMM write)
  ↓
Master SH2: read mailbox → physics → AI → collision → entity update
  → write display objects directly to SDRAM
  → trigger Slave render (1 COMM2 write)
  ↓
Slave SH2: read SDRAM → render → frame buffer
  → set COMM1_LO bit 0 ("done")
  ↓
68K V-INT: poll COMM1_LO → frame swap
```

**Zero COMM data transfer.** All bulk data flows through SDRAM.

---

## 3. Hard Hardware Constraints

Every constraint below is verified against hardware documentation. **These cannot be designed around — they are physics of the hardware.**

| # | Constraint | Source | Impact on Design |
|---|-----------|--------|-----------------|
| H-1 | COMM read-during-write = undefined | `analysis/COMM_REGISTERS_HARDWARE_ANALYSIS.md` | All COMM access must use handshakes on separate registers |
| H-2 | SH2 write buffer: COMM writes async | SH7604 manual §7.11.2 | Dummy-read after COMM writes to force visibility |
| H-3 | SDRAM shared bus, Master has priority | HW manual §5 | Slave stalls when Master accesses SDRAM simultaneously |
| H-4 | No cache coherency between SH2s | SH7604 design | Must use cache-through ($20xxxxxx) for shared data |
| H-5 | SH2 cannot access 68K WRAM | HW manual memory map | Entity tables MUST move to SDRAM or COMM |
| H-6 | FS bit writes deferred to VBlank | HW manual §4.2 | Frame swap timing unchanged — 68K V-INT handles it |
| H-7 | FM bit = immediate VDP preemption | HW manual §1.5 | Must not toggle FM during 68K VDP access |
| H-8 | Sound hardware (YM2612/PSG/Z80) 68K-only | Hardware address map | Sound driver cannot move to SH2 |
| H-9 | On-chip SRAM is CPU-private | SH7604 design | Pipeline 1 data written by Slave is invisible to Master |
| H-10 | COMM1_LO bit 0 = system "done" signal | Game architecture | Multiple consumers poll this — cannot repurpose |
| H-11 | COMM7 = Slave doorbell namespace | B-006 crash analysis | Game cmd bytes must never be written to COMM7 |
| H-12 | SDRAM access: 2-6 wait states per read | HW manual Table 5.7 | Entity field access slower than WRAM (0 wait). Budget accordingly. |
| H-13 | SH2 ROM access blocked when RV=1 | HW manual DREQ ctrl | VRD never sets RV=1, but avoid ROM→VRAM DMA |

**Evidence for each:** See cited documents + `KNOWN_ISSUES.md` (68+ pitfalls, 3 failed B-003 attempts proving H-5)

---

## 4. Phase 0: Infrastructure

**Status: COMPLETE** (2026-03-17)

### 4.1 What Was Built

| Component | Location | Size | Purpose |
|-----------|----------|------|---------|
| cmd $3F handler | $301500 (expansion ROM) | 44 bytes | Reads SDRAM mailbox, signals completion |
| Jump table patch | $02087C (SDRAM) | 4 bytes | Entry $3F → $02301500 |
| SDRAM mailbox | $0600BC00 | 16 bytes | Zero-initialized from ROM copy |
| Makefile rules | Makefile lines 559-562, 2211-2225 | — | Full asm→bin→inc pipeline |

### 4.2 Verification

| Check | Method | Result |
|-------|--------|--------|
| Jump table entry | `python3` ROM byte check at $02087C | $02301500 ✓ |
| Handler prologue | ROM byte check at $301500 | $4F22 (STS.L PR,@-R15) ✓ |
| Mailbox zeroed | ROM byte check at $02BC00 | 16× $00 ✓ |
| Full ROM builds | `make clean && make all` | 4MB ROM, clean ✓ |

### 4.3 Design Decisions Made

| Decision | Rationale | Alternative Considered |
|----------|-----------|----------------------|
| Use cmd $3F (not $40) | 16 unused slots ($30-$3F) in existing 64-entry jump table. Zero dispatch loop changes. | Cmd $40 would require dispatch loop modification (range check + trampoline). Higher risk, no benefit. |
| Mailbox at $0600BC00 | Currently zero-filled ROM data region. No SH2 code references it. Part of boot IDL copy (auto-zeroed). | $0600F000 area also free, but farther from entity data. |
| Inline COMM cleanup | Matches cmd22/cmd25 pattern (proven, 2 active handlers use it). | JSR func_084 — adds call overhead, no benefit for new handler. |

### 4.4 What Was NOT Built (Deferred)

- [ ] 68K-side test trigger for cmd $3F (not needed until Phase 1)
- [ ] SDRAM mailbox write from 68K (not needed until Phase 1)
- [ ] Controller input relay to mailbox (not needed until Phase 2)

---

## 5. Phase 1: SDRAM Path Validation

**Status: IN PROGRESS** (2026-03-17)
**Prerequisite: Phase 0 (done)
**Baseline tag:** `vr60-phase0-baseline`

### 5.1 Goal (Revised)

Validate that the Master SH2 can read and write entity data at the new SDRAM location. Split into two sub-phases:
- **Phase 1A:** Master SH2 copies existing cmd $02 entity data to new SDRAM area (validates addressing)
- **Phase 1B:** 68K writes controller input to SDRAM mailbox (validates communication path)

**Key insight (Phase 1 planning):** DREQ FIFO is unnecessary for entity tables. The Master SH2 will own them directly in SDRAM once game logic is ported (Phases 3-5). During migration, Master reads from the existing cmd $02 DMA landing area ($0600C000+).

### 5.2 SDRAM Memory Map (Corrected)

**BLOCKED: $06008000-$0600BFFF** — Gradient strip B at $060086D4-$06008743 (112 bytes) is read by span_filler every polygon. Overwriting = rendering corruption.

**SAFE: $0600F20C-$06017FFF** (36.3 KB free) — between render state flags ($0600F20B) and display list ($06018000). Verified: zero SH2 code references, rendering pipeline never writes here.

| Range | Size | Purpose |
|-------|------|---------|
| $0600F20C-$0600F80B | 1536B | Entity render data mirror (buffer A) |
| $0600F80C-$0600FBFF | 1012B | Reserved (buffer A expansion, Phases 3-5) |
| $0600FC00-$0600FC0F | 16B | Validation canary |
| $06010000-$06017FFF | 32KB | Reserved (buffer B, Phase 6 double-buffer) |

### 5.3 Resolved Unknowns

| Question | Answer | Evidence |
|----------|--------|----------|
| Q-001: Can DREQ FIFO target $06008000? | **Moot** — entity tables don't need FIFO. Master SH2 copies from existing cmd $02 area. FIFO destination is SH2 DMAC-controlled (DAR0 at $FFFFFF84), not 68K-controlled. | HW manual §DREQ, agent research 2026-03-17 |
| SDRAM conflict at $06008000? | **YES** — Gradient strip B at $060086D4. | Agent grep: span_filler reads $060086D4. Zero refs to $0600F20C+. |
| cmd $02 landing addresses? | $0600C000 (Huffman), $0600C800 (entity visibility, 32×16B) | `analysis/sh2-analysis/SH2_COMMAND_HANDLER_REFERENCE.md` |

### 5.4 Phase 1A Steps

| Step | Description | Files | Risk |
|------|-------------|-------|------|
| 1A-1 | Update this roadmap (SDRAM addresses, lessons) | VR60_ROADMAP.md | None |
| 1A-2 | Expand cmd $3F handler: memcpy from $2200C800 → $2200F20C + canary | cmd3f_vr60_gameframe.asm | Low |
| 1A-3 | Rebuild: `make sh2-assembly && make all` | Makefile (update size) | Low |
| 1A-4 | Add 68K test trigger after mars_dma_xfer_vdp_fill | TBD racing module | Medium |
| 1A-5 | Autoplay 3600 frames + canary verify + profile | — | Low |

### 5.5 Phase 1B Steps

| Step | Description | Risk |
|------|-------------|------|
| 1B-1 | Test 68K→SDRAM direct write at $88BC00 | **UNKNOWN** (Q-010) |
| 1B-2 | If works: 68K writes controller input directly. If not: COMM relay. | Low |
| 1B-3 | Verify controller input arrives at $2200BC00 | Low |

### 5.6 Acceptance Criteria

- [ ] Canary $DEADBEEF present at $0600FC00 after autoplay
- [ ] Entity data at $0600F20C matches $0600C800 source
- [ ] Game runs identically (no visual/behavioral changes)
- [ ] 3600-frame autoplay passes without crashes
- [ ] cmd $3F handler overhead <2000 SH2 cycles/frame
- [ ] Controller input visible in SDRAM mailbox (Phase 1B)

---

## 6. Phase 2: Entity Projection Port

**Status: NOT STARTED**
**Prerequisite: Phase 1**

### 6.1 Goal

Move `object_table_sprite_param_update` from 68K to Master SH2. This is the first actual game logic port. Eliminates the 14× sh2_send_cmd bottleneck.

### 6.2 Source Function Analysis

| Property | Value | Source |
|----------|-------|--------|
| 68K function | `object_table_sprite_param_update` | `disasm/modules/68k/game/render/object_table_sprite_param_update.asm` |
| ROM address | $0036DE-$0037B4 | Module header |
| Size | 216 bytes (68K) | Module header |
| Estimated SH2 size | ~300 bytes | 68K→SH2 typically 30-40% larger |
| Side effects | None — pure data transform | No sound, no state mutation, no I/O |
| Inputs | Entity table (+$30, +$32, +$34, +$3A, +$3C, +$3E, +$6E, +$BC, +$C1, +$C4, +$E5) | `analysis/ENTITY_OBJECT_ARCHITECTURE.md` §7 |
| Outputs | Display objects ($FF6218, 60B stride × 15 entries) | `analysis/ENTITY_OBJECT_ARCHITECTURE.md` §7 |
| ROM tables | Sprite definitions at $008958E4 (SH2: $020958E4) | Module source |

### 6.3 What Needs to Happen

| Step | Description |
|------|-------------|
| 2a | Port `object_table_sprite_param_update` to SH2 assembly (expansion ROM) |
| 2b | Master SH2 cmd $3F handler calls the ported function after reading entity data from SDRAM |
| 2c | Master SH2 performs block copies to frame buffer internally (absorbs the 14× sh2_send_cmd work) |
| 2d | 68K stops calling `object_table_sprite_param_update` and `sh2_send_cmd` ×14 |
| 2e | Byte-comparison gate: verify SH2 output matches 68K output for 100 frames |

### 6.4 Unknowns to Resolve

| Unknown | How to Resolve |
|---------|---------------|
| How does the block copy destination (frame buffer) get addressed from Master SH2? | Currently cmd $22 uses $04xxxxxx (cached frame buffer). Master can write to same addresses. Verify FM bit is set (SH2 has VDP access). |
| Can Master SH2 perform all 14 block copies in time? | Current Master budget: 256K cycles idle. Each copy: 3K-8K cycles. 14 copies: 42K-112K. Fits easily. Verify with profiling. |
| What's the stride ($0200) source? | Block copy uses $0200 stride (frame buffer row spacing). This is a constant, not derived from entity data. Hard-code in SH2 handler. |

### 6.5 Acceptance Criteria

- [ ] Display objects at SDRAM $0600B900 are byte-identical to what 68K produced
- [ ] Block copies complete successfully (frame buffer content unchanged)
- [ ] sh2_send_cmd no longer called during racing (verify via COMM0 profiling)
- [ ] 3600-frame autoplay passes
- [ ] 68K utilization drops by ~10% (from 100.1% to ~90%)
- [ ] No visual differences (A/B comparison screenshots)

---

## 7. Phase 3: Physics Port

**Status: NOT STARTED**
**Prerequisite: Phase 2**

### 7.1 Goal

Move the 9-step physics pipeline to Master SH2.

### 7.2 Source Functions (Must Port as Complete Unit)

| Function | ROM Address | Size | Key Operations | SH2 Translation Issues |
|----------|-----------|------|----------------|----------------------|
| `speed_degrade_calc` | $00859A | 42B | SUB, CMP, BCC | None — pure arithmetic |
| `steering_input_processing` | $0094F4 | 298B | Controller bit decode, EMA filter, deadzone | Reads controller input from SDRAM mailbox (not I/O port). Must verify addressing. |
| `entity_force_integration` | $009300 | 344B | MULS, ASR, drag/friction tables | ROM table access via $02xxxxxx. MULS→MUL.L (SH2 MAC). |
| `speed_calc_multiplier_chain` | $009458 | 156B | Table lookup, MULS, shift chains | Track speed factor from $FFC0E6 → must relocate to SDRAM |
| `entity_speed_clamp` | $009B12 | 32B | MULS #$48, LSR #8 | Direct translation |
| `entity_speed_accel_and_braking` | $009182 | 382B | Gear ratios, DIVU, MULS | **DIVU has no SH2 equivalent** — must use reciprocal multiply |
| `tilt_adjust` | $00961E | 106B | CMP, ADD, clamp | Direct translation |
| `lateral_drift_velocity` | $00987E | 300B | Grip calc, force integration, spin-out | Two variants (A/B). Both needed. |
| `entity_pos_update` | $006F98 | 98B | sin/cos lookup, position integration | ROM trig table at $0213AC2C. Falls through to collision (Phase 5 dependency!) |

**Total:** ~1,760 bytes 68K → estimated ~2,500 bytes SH2

### 7.3 Critical Translation Issues

| Issue | Detail | Resolution |
|-------|--------|------------|
| **DIVU instruction** | `entity_speed_accel` uses DIVU for gear ratio. SH2 has no unsigned divide. | Pre-compute reciprocals for 7 gear ratios (known constants). Store in expansion ROM literal pool. `DIVU #ratio` → `MULU.L reciprocal >> shift`. Verify exact match for all 7 ratios. |
| **DIVS #103** | `speed_interpolation` divides by 103. | Reciprocal: $9D8A = floor(2^20 / 103). `MULS result >> 20` = equivalent. Verify rounding matches for full input range (-32768..+32767). |
| **Controller input source** | `steering_input_processing` reads from `$C9A1`/`$C9A3` (68K WRAM). | Must read from SDRAM mailbox instead. 68K writes controller state to mailbox each frame. |
| **Global variables** | Track speed factor ($C0E6), wind flag ($C31B), boost flag ($C826), gear table ptr ($C288) | Relocate to SDRAM. 68K writes these during scene init; Master SH2 reads per-frame. ~20 bytes total. |
| **Sound triggers** | Physics generates $B1/$B2/$B4 sound bytes to $CA94 | Write to SDRAM sound queue. 68K reads queue each frame, plays sounds. |
| **Fall-through to collision** | `entity_pos_update` JMPs to `collision_response_surface_tracking` | Phase 3 cannot include collision (Phase 5). Must add temporary RTS at the JMP boundary. |

### 7.4 RAM Variables to Relocate

| 68K Address | Size | Name | Written By | Read By (Phase 3) |
|-------------|------|------|-----------|-------------------|
| $FFC0E6 | word | track_speed_factor | Scene init | speed_calc_multiplier_chain |
| $FFC0F8/$FFC0FA | 2 words | accel limits | Scene init | speed_interpolation |
| $FFC27C | long | speed_table_ptr | Scene init | speed_calc_multiplier_chain |
| $FFC288 | long | gear_table_ptr | Scene init | entity_force_integration |
| $FFC31B | byte | wind_active | Scene handler | speed_calc_multiplier_chain |
| $FFC826 | byte | has_boost_flag | Scene handler | speed_calc_multiplier_chain |
| $FFC8D8 | word | countersteer_flag | Steering | steering_input_processing |
| $C9A1/$C9A3 | 2 bytes | controller input | V-INT/input scan | steering_input_processing |
| $FFCA94 | word | sound_trigger | Physics output | 68K sound dispatch |

**Strategy:** Create a "global vars block" in SDRAM (e.g., $0600BF00, 64 bytes). 68K writes globals during scene init + per-frame input. Master SH2 reads per-frame.

### 7.5 Acceptance Criteria

- [ ] All 9 physics functions produce byte-identical entity field outputs on SH2 vs 68K
- [ ] Gear shifts work correctly (test all 7 gears, upshift + downshift + natural)
- [ ] Drift/spin-out triggers correctly (verified via sound byte queue)
- [ ] 3600-frame autoplay with physics on SH2 — no crashes, no visual differences
- [ ] DIVU/DIVS reciprocal accuracy verified for full input range
- [ ] 68K utilization drops by ~2% (physics portion removed)

---

## 8. Phase 4: AI Port

**Status: NOT STARTED**
**Prerequisite: Phase 3 (physics_integration must be on SH2)**

### 8.1 Goal

Move the 15-state AI machine to Master SH2.

### 8.2 Key Dependency

`collision_avoidance_speed_calc` ($A470) **falls through to** `physics_integration` ($A666) with no RTS. If physics is already on SH2 (Phase 3), the AI fall-through targets SH2 code — this is the natural integration point. If physics is NOT on SH2, we'd need a trampoline back to 68K, which defeats the purpose.

**This is why Phase 4 depends on Phase 3.**

### 8.3 Functions to Port

| Function | ROM Address | Size | Notes |
|----------|-----------|------|-------|
| `ai_entity_main_update_orch` | $00A972 | 716B | Orchestrator — largest single function |
| `ai_state_dispatch` | $00BE50 | 116B | 15-entry jump table |
| `collision_avoidance_speed_calc` | $00A470 | 502B | Falls through to physics_integration |
| `ai_opponent_select` | $00A434 | 60B | Gated activation |
| `ai_steering_calc` | $00A7A0 | 66B | atan2 approximation (shared with camera) |
| `ai_scene_interpolation` | $00BD2A | 116B | Attract mode keyframes |
| 18 supporting functions | various | ~400B total | State advance, timer, buffer setup |

**Total:** ~1,976 bytes 68K → estimated ~2,700 bytes SH2

### 8.4 State to Relocate

| Variable | 68K Address | Purpose | Strategy |
|----------|------------|---------|----------|
| AI state index | $FFA0EA | State machine position (0-56) | SDRAM globals block |
| AI timer | $FFA0EC | 120-frame advancement timer | SDRAM globals block |
| Race slot table | $FFC03C | 4 slots × word state | SDRAM globals block |
| Entity +$A4/+$A6 | Per-entity | Target indices (opponent tracking) | Already in entity table (relocated in Phase 1) |
| Entity +$AE | Per-entity | Type dispatch index | Already in entity table |

### 8.5 Acceptance Criteria

- [ ] AI opponents behave identically (steering, avoidance, spawn timing)
- [ ] All 15 AI states cycle correctly (verify via diagnostic counter)
- [ ] Opponent selection activates at correct speed/mode thresholds
- [ ] collision_avoidance → physics_integration fall-through works on SH2
- [ ] 3600-frame autoplay — no behavior changes visible

---

## 9. Phase 5: Collision Port

**Status: NOT STARTED**
**Prerequisite: Phase 3 (entity_pos_update must be on SH2)**

### 9.1 Goal

Move collision detection to Master SH2. This is the most complex port — binary search over track tiles with 5-point probing.

### 9.2 Functions to Port

| Function | ROM Address | Size | Complexity |
|----------|-----------|------|-----------|
| `collision_response_surface_tracking` | $007700 | 412B | High — 4-iteration binary search |
| `track_boundary_collision_detection` | $00789C | 420B | High — center + 4 directional probes |
| `track_data_index_calc_table_lookup` | $0073E8 | 68B | Medium — 2-level ROM table lookup |
| `track_data_extract_033` | $0076A2 | 94B | Medium — 4-page geometry extraction |
| `object_collision_detection` | $00AF18 | 170B | Medium — weighted speed avg |
| `directional_collision_probe` | $007AD6 | 214B | Medium — forward + adjacent |
| `proximity_zone_loop` | $00877A | 104B | Low — 15-entity Manhattan |
| `position_separation` | $00AFFE | 44B | Low — push-apart |
| `rotational_offset_calc` | $00764E | 84B | Low — 2D rotation |

**Total:** ~1,610 bytes 68K → estimated ~2,300 bytes SH2

### 9.3 Track Data Access

Collision heavily uses `track_data_index_calc_table_lookup` which reads ROM pointer tables at $00742C/$00745C (SH2: $0200742C/$0200745C) and dereferences to tile data at $0094C000+ (SH2: $02D4C000+? **MUST VERIFY** — ROM addresses above $300000 may map differently on SH2).

**CRITICAL UNKNOWN:** What is the SH2 address for ROM data at 68K $0094C000? If the ROM is 4MB ($000000-$3FFFFF), the SH2 address is $02000000 + $0094C000 = $0294C000. But the ROM is only 4MB — $0094C000 > $3FFFFF, so this might be a banked/mirrored address. **MUST READ** the track data ROM table format before attempting this port.

### 9.4 Sound Triggers from Collision

| Collision Event | Sound Byte | Trigger |
|-----------------|-----------|---------|
| Skid/deceleration | $B1 | Force exceeds threshold |
| Spin-out | $B2 | Lateral velocity exceeds limit |
| Tire squeal / gear shift | $B4 | Grip loss or upshift at high speed |
| Object collision | $B8 | Entity-vs-entity proximity |

All written to SDRAM sound queue. 68K reads and plays.

### 9.5 Acceptance Criteria

- [ ] Track boundary detection produces identical collision flags (+$55-$59)
- [ ] Binary search resolves identical positions (compare +$30/+$34 across 1000 frames)
- [ ] Surface tracking EMA produces identical heights (+$5A/+$5C/+$5E/+$32)
- [ ] Object-to-object collision triggers correctly (sound $B8, speed averaging)
- [ ] All 3 tracks work (Beginner, Medium, Expert — different tile tables)
- [ ] 3600-frame autoplay — no behavior changes

---

## 10. Phase 6: Pipeline Overlap

**Status: NOT STARTED**
**Prerequisite: Phases 2-5 complete (all game logic on Master SH2)**

### 10.1 Goal

Master computes frame N+1 while Slave renders frame N. Double-buffered entity tables.

### 10.2 Double-Buffer Design

| Buffer | Entity Tables | Display Objects | Size |
|--------|--------------|----------------|------|
| **A** | $06008000-$0600B8FF | $0600B900-$0600BBFF | ~15KB |
| **B** | $0600F000-$060167FF | $06016800-$06016AFF | ~15KB |

Swap index stored at $0600BC10 (mailbox). Master writes to buffer[swap_index], Slave reads from buffer[1 - swap_index].

### 10.3 Synchronization Protocol

```
Frame N:
  Master: compute game logic → write buffer A
        → set swap_index = 0
        → write COMM2_HI = render_cmd (trigger Slave)
        → immediately begin frame N+1 (write buffer B)
  Slave:  read buffer A → render → write frame buffer
        → set COMM1_LO bit 0 ("done")
  68K:    V-INT polls COMM1_LO → frame swap

Frame N+1:
  Master: compute game logic → write buffer B
        → set swap_index = 1
        → write COMM2_HI = render_cmd
        → immediately begin frame N+2 (write buffer A)
  Slave:  read buffer B → render
  ...
```

### 10.4 SDRAM Bus Contention Strategy

| Time Slot | Master | Slave | Contention |
|-----------|--------|-------|-----------|
| T1: Slave Pipeline 1 | Writes entity tables (SDRAM) | On-chip SRAM (zero SDRAM) | **None** |
| T2: Slave Pipeline 2 | ROM table lookups (cached) | SDRAM reads | **Minimal** (Master on ROM, not SDRAM) |
| T3: Block copies | SDRAM → Frame Buffer | Idle (render complete) | **None** |

**Key insight:** Pipeline 1 (on-chip SRAM, 40% of Slave time) creates a natural window where Master can write SDRAM without contention.

### 10.5 Risks

| Risk | Severity | Mitigation |
|------|----------|-----------|
| Sound timing desync | High | Sound queue is timestamp-tagged. 68K plays sounds at correct V-INT, regardless of which frame generated them. |
| Scene transitions during double-buffer | High | Scene commands (pause, menu) flush both buffers and reset to single-buffer mode until new scene stabilizes. |
| Slave reads partially-written buffer | Critical | Master writes complete buffer, THEN triggers Slave. Slave never reads during Master write. Swap index is the atomic gate. |
| 68K controller input lag (1 frame) | Low | Already 1-frame lag in current architecture. No change. |

### 10.6 Acceptance Criteria

- [ ] Dual-buffer swap works correctly for 10,000 frames
- [ ] No torn rendering (Slave never reads partial buffer)
- [ ] Sound plays at correct timing (not early/late by 1 frame)
- [ ] Scene transitions (pause, menu, race end) work correctly
- [ ] Profiling shows Master and Slave executing in parallel (overlapping cycle ranges)
- [ ] FPS measurement shows improvement (target: 40→60 FPS display)

---

## 11. Phase 7: 60 FPS Game Logic

**Status: NOT STARTED**
**Prerequisite: Phase 6 (pipeline overlap stable)**

### 11.1 Goal

Run physics/AI/collision at 60 FPS instead of 20 FPS. True 60 FPS gameplay.

### 11.2 What Changes

All physics constants tuned for 20 FPS must be scaled by 1/3:

| Constant | Current (20 FPS) | Target (60 FPS) | Subsystem |
|----------|-----------------|-----------------|-----------|
| Speed deltas | per-frame values | ÷3 | Physics |
| Force integration | drag/friction per frame | ÷3 | Physics |
| Position integration | dx/dy per frame | ÷3 | Physics |
| AI timer | 120 frames | 360 frames | AI |
| Spawn timer | 120 frames | 360 frames | AI |
| Drift accumulator decay | 8/frame | ~3/frame | Physics |
| Boost timer increment | $738/frame | $270/frame | Physics |

### 11.3 Why This Failed Before (S-4)

S-4 attempted 30 FPS by skipping state 4 (scaling ×2). It failed because:
- Constants scattered across 20+ 68K modules — each fix broke something else
- No delta-time system — hard-coded frame assumptions everywhere
- Physics/collision/checkpoints/music all coupled to frame count
- "Fragile equilibrium" — each constant depends on others

**Why it might succeed now:**
- All game logic will be on SH2 in one codebase (not scattered across 20+ 68K files)
- Can implement proper delta-time (scale factor in one register, applied everywhere)
- Only attempted AFTER all logic is ported (Phase 7, not Phase 1)

### 11.4 Acceptance Criteria

- [ ] Physics feel identical at 60 FPS (speed, steering, drift match 20 FPS behavior scaled correctly)
- [ ] All 3 tracks playable with correct collision response
- [ ] AI behavior unchanged (just smoother)
- [ ] Lap times within 1% of 20 FPS lap times (same physics, more samples)
- [ ] No timer overflow or underflow from ×3 multiplication

---

## 12. Open Questions & Unknowns

These must be resolved before their respective phases. Add new questions as they arise.

| # | Question | Affects Phase | Status | Resolution |
|---|----------|--------------|--------|------------|
| Q-001 | Can DREQ FIFO target arbitrary SDRAM addresses ($06008000)? | Phase 1 | **RESOLVED (moot)** | DREQ FIFO destination is SH2 DMAC-controlled (DAR0 at $FFFFFF84). Entity tables don't need FIFO — Master SH2 copies from existing cmd $02 landing area. |
| Q-002 | What is the SH2 address for ROM data above $300000 (e.g., $0094C000 track tiles)? | Phase 5 | **OPEN** | The 4MB ROM maps to SH2 $02000000-$023FFFFF. Addresses like $0094C000 may be 68K-relative (with $00880000 base subtracted). Must verify: is $0094C000 a CPU address or ROM offset? |
| Q-003 | Can Master SH2 write to frame buffer ($04xxxxxx) when FM=1? | Phase 2 | **OPEN** | FM=1 gives SH2 access. Master currently writes FB via cmd $22. But does it contend with Slave FB writes during rendering? |
| Q-004 | Does SDRAM bus contention degrade Slave rendering measurably? | Phase 6 | **OPEN** | Profile Slave utilization before and after Master SDRAM writes. Compare render times. |
| Q-005 | Is the `entity_type_dispatch` RAM table at $C05C written only during scene init? | Phase 4 | **OPEN** | If written per-frame, must be in SDRAM. If init-only, can be snapshot once. |
| Q-006 | How does camera_snapshot_wrapper (A-1 hook) interact with the new architecture? | Phase 2 | **OPEN** | A-1 camera interpolation hooks into state 0 of the scene dispatcher. If game logic moves to Master SH2, the camera snapshot must also move. |
| Q-007 | What happens to the 68K entity render pipeline variants (A/B/C/D, 2P)? | Phase 2 | **OPEN** | 6+ variants call different physics/AI/collision subsets. When logic moves to SH2, what drives variant selection? |
| Q-008 | Can we keep menus on 68K while racing logic is on SH2? | All | **OPEN** | Menu system (115 modules) is non-critical. But mode transitions need clean handoff. |
| Q-009 | What about the 2-player mode? | Phase 2+ | **OPEN** | 2P uses Table 3 ($FF9F00), alternate viewport at $FF6330, different render pipeline variants. Must be considered. |
| Q-010 | Can 68K write to SDRAM at $88BC00 (adapter-mapped)? | Phase 1B | **OPEN** | Agent research suggests $880000-$8FFFFF maps to SDRAM. Must test empirically — may be read-only ROM mapping. |
| Q-011 | Where exactly does cmd $02 write entity visibility data in SDRAM? | Phase 1A | **OPEN** | Believed to be $0600C800 (32×16B). Must verify by reading cmd $02 handler. |
| Q-012 | Can the cmd $3F trigger be inserted after mars_dma_xfer_vdp_fill? | Phase 1A | **OPEN** | Must read the state 4 calling module for available space. |

---

## 13. Decision Log

Record every significant design decision here. Include date, what was decided, why, and what alternatives were rejected.

| Date | Decision | Rationale | Alternatives Rejected |
|------|----------|-----------|----------------------|
| 2026-03-17 | Use cmd $3F (not $40) for VR60 handler | Fits in existing 64-entry jump table. Zero dispatch loop changes. Same approach as B-004/B-005 (proven). | Cmd $40 requires dispatch loop trampoline (6-instruction patch, medium risk). |
| 2026-03-17 | SDRAM mailbox at $0600BC00 | Zero-filled in ROM, no SH2 code references, auto-zeroed by boot IDL copy. | $0600F000 (also free, but farther from entity data). |
| 2026-03-17 | Inline COMM cleanup in cmd $3F handler | Matches cmd22/cmd25 proven pattern. No func_084 call overhead. | JSR func_084 — adds 4 cycles, no safety benefit. |
| 2026-03-17 | Port entity projection BEFORE physics | Pure data transform, no side effects, easiest to verify. Immediate 10.52% benefit. | Port physics first — higher impact per function but harder to verify. |
| 2026-03-17 | Entity tables at $0600F20C (not $06008000) | $06008000 blocked by gradient strip B at $060086D4 (span_filler reads every polygon). $0600F20C-$06017FFF verified free (36.3 KB, zero SH2 code refs). | $06008000 (original plan, conflict with rendering data). |
| 2026-03-17 | Skip DREQ FIFO for entity tables | Master SH2 will own entity tables directly once game logic is ported. During migration, copy from existing cmd $02 landing area. FIFO destination is SH2 DMAC-controlled (not 68K), making redirection complex. | DREQ FIFO with DMAC reconfiguration (complex, unnecessary). |
| 2026-03-17 | Use git tag (not duplicate codebase) for baseline comparison | `vr60-phase0-baseline` tag enables `git diff` at any time. Simpler than maintaining parallel codebase. | Separate codebase clone (maintenance overhead, divergence risk). |

---

## 14. Risk Registry

| ID | Risk | Severity | Phase | Status | Mitigation |
|----|------|----------|-------|--------|-----------|
| R-001 | DREQ FIFO cannot target $06008000 | Blocking | Phase 1 | **RESOLVED** | Moot — entity tables don't use FIFO. Master copies from cmd $02 landing area. |
| R-002 | SDRAM bus contention degrades Slave | High | Phase 6 | **OPEN** | Pipeline writes during Slave Pipeline 1 (on-chip SRAM period). Measure before/after. |
| R-003 | DIVU/DIVS reciprocal rounding mismatch | Medium | Phase 3 | **OPEN** | Exhaustive test: run both 68K and SH2 paths for all possible input values, compare outputs |
| R-004 | Entity field access slower on SDRAM (2-6 wait states vs 0) | Medium | Phase 1 | **OPEN** | SH2 clock is 3× faster, compensating for wait states. Profile to verify net effect. |
| R-005 | Track tile ROM addresses are 68K-relative (not file offsets) | Blocking | Phase 5 | **OPEN** | Decode track data ROM table format completely before porting collision |
| R-006 | Camera interpolation (A-1) conflicts with new architecture | High | Phase 2 | **OPEN** | A-1 hooks into 68K scene state 0. If state machine moves to SH2, camera must move too. May need interim hybrid (camera on 68K, physics on SH2). |
| R-007 | Scene transitions corrupt double-buffer state | High | Phase 6 | **OPEN** | Flush both buffers on mode change. Single-buffer fallback during transitions. |
| R-008 | 2-player mode has different entity/render paths | Medium | All | **OPEN** | Initially implement 1P only. 2P as separate effort after core works. |
| R-009 | Sound timing drift when game logic runs ahead of display | Medium | Phase 6 | **OPEN** | Timestamp sound events in SDRAM queue. 68K plays at correct V-INT timing. |
| R-010 | Gradient strip B ($060086D4) invalidated original SDRAM address plan | Medium | Phase 1 | **RESOLVED** | All addresses moved to $0600F20C+. Always grep before allocating SDRAM. |
| R-011 | cmd $3F trigger in state 4 adds COMM0_HI blocking time | Low | Phase 1A | **OPEN** | Temporary for validation only. In Phase 2+, cmd $3F replaces cmd $02. |
| R-012 | 68K→SDRAM direct write at $88xxxx may be read-only ROM mapping | Medium | Phase 1B | **OPEN** | Fallback: COMM2-6 relay (proven pattern). Must test empirically. |

---

## 15. Measurement Protocol

### 15.1 Baseline Measurements (Before Any Changes)

**Capture before starting Phase 1:**

```bash
# Frame-level profiling (1800 frames, 30 seconds)
cd tools/libretro-profiling
./profiling_frontend ../../build/vr_rebuild.32x 1800 --autoplay

# PC-level hotspot profiling (2400 frames)
VRD_PROFILE_PC=1 VRD_PROFILE_PC_LOG=baseline_vr60.csv \
  ./profiling_frontend ../../build/vr_rebuild.32x 2400 --autoplay
python3 analyze_pc_profile.py baseline_vr60.csv
```

**Record:**
- 68K cycles/frame (total, active, STOP)
- Master SH2 cycles/frame (total, active, idle)
- Slave SH2 cycles/frame (total, active, idle)
- sh2_send_cmd COMM0_HI wait cycles
- Display FPS (frame swap count / elapsed frames)

### 15.2 Per-Phase Measurements

After each phase:
1. Run same 1800-frame + 2400-frame profiles
2. Compare against baseline
3. Record delta for each metric
4. If Slave utilization increased >2%, investigate SDRAM contention
5. If any CPU exceeds 90%, investigate bottleneck before proceeding

### 15.3 Correctness Verification

**Byte-comparison protocol for ported functions:**

1. Run 68K version, dump entity table fields to diagnostic SDRAM block after processing
2. Run SH2 version, dump same fields to adjacent SDRAM block
3. Compare blocks. If any byte differs, stop and investigate.
4. Run for 100 frames minimum before declaring correctness.

**Autoplay regression test:**

```bash
./profiling_frontend ../../build/vr_rebuild.32x 3600 --autoplay
# Must complete without crashes or hangs
# Check: menu navigation + track selection + race start + 30s racing + results
```

---

## 16. Lessons Learned

Record discoveries, gotchas, and insights as the project progresses. These help future phases avoid repeating mistakes.

| Date | Phase | Lesson | Impact |
|------|-------|--------|--------|
| (Pre-VR60) | B-003 | SH2 CANNOT access 68K Work RAM at ANY address. Three failed attempts before reading HW manual. | Entity tables MUST be in SDRAM (H-5). |
| (Pre-VR60) | B-005 | COMM0_HI is the game's frame synchronization barrier. Removing it causes display corruption. | Frame sync via COMM1_LO bit 0 is fundamental. Cannot eliminate without replacement barrier. |
| (Pre-VR60) | B-006 | Game command namespace and COMM7 signal namespace must NEVER overlap. Writing game cmd $27 to COMM7 triggers Slave crash. | COMM7 is reserved for Slave doorbell. New architecture must use COMM0 for Master triggers, COMM2 for Slave triggers. |
| (Pre-VR60) | S-1 | Entity descriptors at $0600C344 are unused during racing. Huffman renderer uses different data at $0600C800. | LOD culling at $0600C344 is a dead end. |
| (Pre-VR60) | S-4 | Physics constant scaling (20→30 FPS) created "fragile equilibrium" across 20+ files. | Only attempt frame-rate scaling AFTER all logic is in one codebase on SH2 (Phase 7, not Phase 1). |
| (Pre-VR60) | B-016 | Small functions called frequently cannot justify COMM overhead. angle_normalize (8×/frame, ~1,500 cycles) became 23% SLOWER under COMM dispatch. | Rule: computation_time >> handshake_overhead × call_count. Never COMM-offload small functions. The new architecture eliminates COMM for data entirely. |
| 2026-03-17 | Phase 0 | 16 unused jump table slots ($30-$3F) available. No dispatch loop modification needed for new commands. | Use existing slots for all new Master SH2 commands. |
| 2026-03-17 | Phase 1 planning | **Always grep SDRAM addresses before allocating.** Gradient strip B at $060086D4 was invisible until scanning all SH2 code. | All future SDRAM allocations must be verified with grep across disasm/. |
| 2026-03-17 | Phase 1 planning | **DREQ FIFO destination is SH2-controlled (DMAC DAR0).** 68K can only write data to the FIFO register — it cannot choose where data lands. | Don't plan around 68K-controlled FIFO destinations. Either reconfigure DMAC or bypass FIFO. |
| 2026-03-17 | Phase 1 planning | **Entity tables don't need FIFO transfer.** Master SH2 will own them directly once game logic is ported. During migration, read from existing cmd $02 DMA area. | Simplifies Phases 1-2: no DREQ reconfiguration, no 68K FIFO streaming code. |

---

*This document is a living roadmap. Update it after every session. Add to Open Questions when uncertainties arise. Add to Decision Log when choices are made. Add to Lessons Learned when things surprise us. Add to Risk Registry when new dangers are identified.*
