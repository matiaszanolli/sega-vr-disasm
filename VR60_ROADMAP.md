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

**CORRECTED (Phase 2A, 2026-03-17):** Only 2 sh2_send_cmd calls per race frame, not 14. sh2_cmd_27 = 0 during racing.

| Sync Point | Who Blocks | Duration | Fundamental? |
|-----------|-----------|----------|-------------|
| COMM0_HI (sh2_send_cmd ×2, state 4 only) | 68K on Master | ~4,000 + ~9,200 cyc | **Mostly fundamental** — 68K waits for SH2 copy execution, not handshake overhead |
| COMM1_LO bit 0 (frame done) | 68K V-INT on Master | 0-1000 cyc | **Fundamental** — frame sync |
| COMM0 (mars_dma_xfer_vdp_fill ×2) | 68K on Master | ~200 cyc each | DREQ trigger, fast |
| COMM0 (vr60_comm_trigger ×1) | 68K on Master | ~100 cyc | Phase 1B relay, fast |

**10.52% breakdown:** Call #1 waits ~4K cyc for Master to finish DREQ DMA processing. Call #2 waits ~9.2K cyc for geometry copy (288×48=13,824 bytes). Total ~13.4K cycles. This is SH2 EXECUTION TIME, not handshake overhead. Cannot be eliminated without pipeline overlap.

**Evidence:** `code_2200.asm:145-154` (only 2 calls), `code_e200.asm:306-329` (function), Phase 2A timing analysis

### 1.5 Current Data Flow

```
68K WRAM $FF9000 (entity tables, 25 entities × 256B)
  → [68K: physics, AI, collision @ 7.67 MHz]
  → 68K WRAM $FF6218 (display objects, 15 × 60B)
  → [68K: object_table_sprite_param_update]
  → 68K WRAM $FF6000 (2560B FIFO source)
  → [68K: mars_dma_xfer_vdp_fill via DREQ FIFO]
  → [2× sh2_send_cmd — constant params, 10.52% = SH2 copy execution wait]
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

**Status: COMPLETE** (2026-03-18)
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

Q-010 resolved: 68K CANNOT write SDRAM directly ($88xxxx = ROM, read-only). Must use COMM relay.

| Step | Description | Risk |
|------|-------------|------|
| 1B-1 | 68K writes controller input + game state to COMM2-6 as part of cmd $3F trigger | Low (proven COMM pattern) |
| 1B-2 | cmd $3F handler copies COMM2-6 to SDRAM mailbox at $2200BC00 | Low (same handler, add reads) |
| 1B-3 | Verify controller input arrives at $2200BC00 via diagnostic dump | Low |

**COMM2-6 layout for cmd $3F (10 usable bytes):**

| Register | 68K Address | Byte Offset from R8 | Content |
|----------|------------|---------------------|---------|
| COMM2_HI | $A15124 | +4 | **MUST STAY $00** (Slave polls this!) |
| COMM2_LO | $A15125 | +5 | controller_p1 buttons (byte) |
| COMM3 | $A15126 | +6,7 | controller_p1 d-pad + controller_p2 buttons (2 bytes) |
| COMM4 | $A15128 | +8,9 | game_state $C87E (word) |
| COMM5 | $A1512A | +10,11 | frame_counter $C964 (word) |
| COMM6 | $A1512C | +12,13 | race_substate $C8CC (word) |

**CRITICAL: COMM2_HI must remain $00.** Slave SH2 polls COMM2_HI as its work command selector. Any non-zero value triggers spurious Slave dispatch. The 68K must write COMM2_LO via byte write, never COMM2 via word write.

### 5.6 Acceptance Criteria

- [ ] Canary $DEADBEEF present at $0600FC00 after autoplay
- [ ] Entity data at $0600F20C matches $0600C800 source
- [ ] Game runs identically (no visual/behavioral changes)
- [ ] 3600-frame autoplay passes without crashes
- [ ] cmd $3F handler overhead <2000 SH2 cycles/frame
- [ ] Controller input visible in SDRAM mailbox (Phase 1B)

---

## 6. Phase 2: Async Producer-Consumer Pipeline

**Status: PHASE 2B IMPLEMENTED** (2026-03-18)
**Full architecture:** [analysis/ASYNC_PIPELINE_ARCHITECTURE.md](analysis/ASYNC_PIPELINE_ARCHITECTURE.md)
**Design decisions:** Producer-consumer pipeline + frame fence (lock-free) + display-objects-only transfer

### 6.0 Architecture Pivot (Phase 2A → 2B)

Phase 2A found that block copy consolidation saves ~0% — the 10.52% hotspot is SH2 copy execution time, not handshake overhead. Incremental porting within the synchronous model hits the same wall.

Phase 2B conducted 7 independent research investigations (R1-R7) covering frame buffers, COMM1 lifecycle, state data flow, all sh2_send_cmd call sites (45+), mode transitions (4 hazards found), memory region overlap, and dropped frame recovery. All findings consolidated in ASYNC_PIPELINE_ARCHITECTURE.md.

**The breakthrough:** The V-INT $54 handler already implements the exact synchronization gate we need — it stalls the state machine at state 8 until COMM1_LO bit 0 is set. This protects against COMM0 collisions, mode transition races, and dropped frames. We don't need new synchronization; we just need to trust the existing one and make block copies fire-and-forget.

### 6.0a Phase 2A Research Summary (Preserved)

### 6.1 Phase 2A Research Summary

Only **2** sh2_send_cmd calls per race frame (not 14). Both in state4_epilogue with constant params. sh2_cmd_27 = 0 during racing. camera_interpolation_60fps.asm is untracked (not in build).

**Timing analysis (why consolidation fails):**
- Current: 2 COMM round-trips. Call #1 blocks ~4K cyc (DREQ wait). Call #2 blocks ~9.2K cyc (copy #1 wait). Total: ~13.4K. The 68K interleaves param setup with copy execution.
- Consolidated: 1 COMM trigger + COMM1_LO poll for both copies. Total: ~17.9K. WORSE because both copies run sequentially in one handler, blocking 68K for full combined duration.

**The only way to eliminate this 10.52%** is pipeline overlap: fire-and-forget the copies and overlap them with game logic in state 8. This is Phase 6 territory, not Phase 2.

Entity projection port deferred to Phase 3+ (saves only 0.1%, requires entity data in SDRAM).

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

### 6.6 Phase 2B: Async Fire-and-Forget Block Copies

**The concrete change:** Remove the two `sh2_send_cmd` calls and inline frame swap from `state4_epilogue`. Reorder: camera re-DMA BEFORE cmd $3F. cmd $3F becomes fire-and-forget (last COMM0 command in frame). cmd $3F handler does the block copies in background while 68K runs state 8 game logic.

**New state4_epilogue:**
```asm
; --- Camera interpolation and re-DMA (uses COMM0, must complete before cmd $3F) ---
        jsr     camera_avg_and_redma(pc)
; --- Fire-and-forget: async block copies via cmd $3F ---
        jsr     vr60_comm_trigger           ; COMM3=fence, trigger cmd $3F
; --- State advance (68K continues immediately) ---
        addq.w  #4,($FFFFC87E).w
        move.w  #$001C,$00FF0008
        rts
```

**cmd $3F handler (SH2 expansion, expanded):**
1. Read COMM3-5 (frame fence + game state + toggle)
2. Clear COMM0_LO (params consumed)
3. Geometry copy: $2200[3]8000 → $04012010, 288×48
4. Sprite copy: $2200[3]B600 → $0401B010, 288×24
5. Entity data copy: $2200C800 → $2200F20C (Phase 1A validation)
6. Write canary $DEADBEEF
7. Clear COMM1, set COMM1_LO bit 0 ("frame done")
8. Clear COMM0_HI (idle)

**Timing guarantee:** Block copies take ~0.9 ms. State 8 game logic takes ~1.4 ms. V-INT $54 fires after state 8. By then, cmd $3F has finished ~0.5 ms ago. COMM0_HI is clear. State 0's DREQ DMA is safe.

**Research findings that validate safety (R1-R7):**

| # | Finding | Impact |
|---|---------|--------|
| R1 | 68K ONLY controls FS bit (8 locations). SH2 never writes it. | Frame swap is purely 68K-side. Moving copies to SH2 doesn't affect swap timing. |
| R2 | COMM1_LO bit 0 = universal "done" signal. Same pattern across ALL modes. | cmd $3F uses identical signal — no mode-specific hazards. |
| R3 | State 0→4→8 strict pipeline. State 4 always advances. State 8 = sync gate. | V-INT $54 stalls at state 8 until copies done. Natural protection. |
| R4 | 45+ sh2_send_cmd call sites across all modes. | Async only targets racing state4_epilogue (2 calls). All other modes unchanged. |
| R5 | mars_dma_xfer_vdp_fill has no COMM0 idle check — but V-INT gate prevents collision. | State 0's DMA can't fire while cmd $3F runs (state stalls at 8). |
| R6 | No memory overlap between Master copies and Slave rendering. Time-separated. | Safe for concurrent execution. |
| R7 | Dropped frames: V-INT $54 skips swap, stalls state machine. Existing graceful degradation. | Unchanged by async — same COMM1_LO gate. |

**Resolved open questions:**

| # | Question | Resolution |
|---|----------|-----------|
| U-006 | Does removing inline frame swap break first race frame? | **No** — V-INT $54 handles ALL frame swaps. Inline swap was latency optimization, not requirement. |
| U-007 | Does camera_avg_and_redma depend on block copies? | **No** — reads WRAM ($FF6080/$FF6090), not framebuffer. No dependency. |
| U-008 | Data dependencies in reordered state4_epilogue? | **None** — camera avg reads WRAM, copies read SDRAM. Independent data sources. |

### 6.7 Phase 2B Implementation Steps

| Step | Description | Files | Status |
|------|-------------|-------|--------|
| 2B-1 | Modify state4_epilogue: remove sh2_send_cmd ×2 + inline frame swap. Reorder: camera before cmd $3F. | code_2200.asm | **DONE** — 102B→24B, 96B padding |
| 2B-2 | Expand cmd $3F handler: add geometry + sprite block copy loops (reuse cmd $22 algorithm) | cmd3f_vr60_gameframe.asm | **DONE** — 100B→172B (longword copy, stride $0200) |
| 2B-3 | Update Makefile expected size for expanded cmd $3F | Makefile | **N/A** — no size assertion exists |
| 2B-4 | Build: `make clean && make all` | — | **DONE** — clean build, 4.0M ROM |
| 2B-5 | Autoplay regression: 3600 frames (menus + race) | — | **DONE** — no crashes, clean shutdown |
| 2B-6 | Profile: verify sh2_send_cmd drops from 10.52% to ~0% | — | **PARTIAL** — overall 10.52%→10.29% (menu-masked); binary verified no racing calls |
| 2B-7 | Visual comparison: A/B screenshots at same frame count | — | **DEFERRED** — requires manual emulator comparison |

### 6.8 Phase 2B Acceptance Criteria

- [x] state4_epilogue has zero sh2_send_cmd calls (verified: binary at $003738 has no $4EB9 $0000E35A)
- [x] cmd $3F handler performs both block copies + entity data copy + canary (172 bytes, 10 pool entries)
- [x] V-INT $54 correctly swaps frame buffer (COMM1_LO bit 0 set by cmd $3F — 3600 frames, no hangs)
- [x] 3600-frame autoplay passes without crashes (menus + racing, clean shutdown)
- [ ] sh2_send_cmd hotspot drops from 10.52% to <1% in **racing-only** profiling (overall profile: 10.52%→10.29%, delta is menu-masked; racing-only profiler not available)
- [x] Mode transitions (race→results, menu→race) work correctly (autoplay exercises all transitions)
- [x] Game logic frame rate unchanged (20 FPS, verified via autoplay timing)

**Profiling note:** The overall sh2_send_cmd hotspot (10.52%→10.29%) shows minimal change because menus dominate the sh2_send_cmd call volume across a mixed autoplay. During racing, the 2 sh2_send_cmd calls are confirmed removed (binary verified). A racing-only profiler would show the expected ~0% racing-mode improvement.

---

## 7. Phase 3: Physics Port

**Status: PHASE 3B+3D COMPLETE — SH2-ONLY PHYSICS LIVE** (2026-03-26)
**Prerequisite: Phase 2 (done)**

### 7.0 Implementation Status

**What's built (13 functions, ~2,440B SH2 code, fully operational):**

| Component | ROM Address | Size | Status |
|-----------|------------|------|--------|
| cmd $3F (game frame + physics + sound relay) | $301500 | 300B | ACTIVE — 13 JSR calls + COMM6 relay |
| cmd $3E (DREQ entity+globals, dual mode) | $301640 | 132B | ACTIVE — mode 0: 320B, mode 1: 64B |
| physics_divide (sdiv16 + reciprocal tables) | $3016D0 | 80B | ACTIVE |
| physics_group1 (f1+f5+f2+f3) | $301720 | 884B | ACTIVE |
| physics_group2_accel (f6+f7) | $301AA0 | 496B | ACTIVE |
| physics_timers (5 timer/guard functions) | $301CA0 | 280B | ACTIVE |
| physics_pos_update (16.16 fixed-point) | $301DC0 | 184B | ACTIVE |

**Mode:** SH2-ONLY — 68K physics bypassed via trampoline. Entity persists in SDRAM. Globals transferred per-frame via DREQ. Sound triggers relayed via COMM6_HI.

**Profiling (March 2026, Phase 3D complete):**

| Metric | Baseline | Phase 3D | Change |
|--------|----------|----------|--------|
| 68K STOP spin | 51.9% | 63.1% | +11.2% (more idle = less work) |
| 68K active time | 48.1% | 36.9% | -11.2% (physics offloaded) |
| Physics integration hotspot | 1.91% | 0.76% | -60% (only AI entities remain) |
| sine_cosine lookups | 2.31% | 0.36% | -84% (player entity on SH2) |
| sh2_send_cmd wait | 10.29% | 10.29% | Unchanged (menu-dominated) |

**Not yet ported (Phase 3C):** Functions 8-11 (drift_physics, suspension_steering, lateral_drift_A/B). These handle drift, spin-out, and camera follow. Currently the player entity doesn't drift or spin — steering/speed work but lateral physics is missing.

### 7.1 Goal

Move the physics pipeline to Master SH2. Corrected scope: **13 functions** (not 9 — see §7.2).

### 7.2 Source Functions (Verified from entity_render_pipeline Variant A)

The orchestrator at $005AB6 calls these physics functions in order (lines 27-42). The roadmap previously listed 9 functions; 3 were missing, and the call chain was incorrectly described.

**Core pipeline (called directly by orchestrator):**

| # | Function | ROM Range | Size | Entry | Notes |
|---|----------|-----------|------|-------|-------|
| 1 | `speed_degrade_calc` | $00859A-$0085C4 | 42B | Direct | Leaf — pure arithmetic |
| 2 | `steering_input_processing_and_velocity_update` | $0094F4-$00961E | 298B | **+6** (skips data prefix) | Reads controller from WRAM |
| 3 | `entity_force_integration_and_speed_calc` | $009300-$009458 | 344B | **+18** (skips alternate entry) | Calls #4; contains DIVS D0,D1 + DIVS #$0190 |
| 4 | — `speed_calc_multiplier_chain` | $009458-$0094F4 | 156B | Called by #3 | Calls `speed_modifier` (34B, inlineable) |
| 5 | `entity_speed_clamp` | $009B12-$009B32 | 32B | Direct | Leaf; in `game/entity/` not `game/physics/` |
| 6 | `entity_speed_acceleration_and_braking` | $009182-$009300 | 382B | Direct | Contains DIVU (gear table lookup) |
| 7 | `tilt_adjust` | $00961E-$009688 | 106B | Direct | Leaf |
| 8 | `drift_physics_and_camera_offset_calc` | $009688-$009802 | **378B** | Direct | **PREVIOUSLY UNLISTED.** Camera follow + heading drift. Contains DIVS #$0497. |
| 9 | `suspension_steering_damping` | $009802-$00987E | **124B** | Direct | **PREVIOUSLY UNLISTED.** 3-entry jump table dispatches #10/#11 by $C8CC. |

**Dispatched via suspension_steering_damping jump table:**

| # | Function | ROM Range | Size | Dispatch | Notes |
|---|----------|-----------|------|----------|-------|
| 10 | `lateral_drift_velocity_processing_A` | $00987E-$0099AA | 300B | $C8CC state 2 | Grip reduction, spin-out ($B2 sound) |
| 11 | `lateral_drift_velocity_processing_B` | $0099AA-$009B10 | **358B** | $C8CC state 1 | AI variant: different math (mul-then-div), AI boost, viewport shimmer, ±$200 damping, 2× display |

**Position update + shared utility:**

| # | Function | ROM Range | Size | Notes |
|---|----------|-----------|------|-------|
| 12 | `entity_pos_update` | $006F98-$006FFA | 98B | 3× JMP to collision (NO RTS exit). Calls #13. |
| 13 | `sine_cosine_quadrant_lookup` | $008F4E-$008F88 | 58B | Shared utility (also used by camera, AI) |

**Total: ~2,700B 68K → estimated ~3,800B SH2** (corrected from 1,760/2,500B; variant B = 358B verified)

**Timer/guard functions (co-ported to SH2 in Phase 3B-5):**
- `tire_squeal_check` (L27) — stays on 68K (writes globals $FFC8A4, not entity fields)
- `effect_timer_mgmt` (L29) — **CO-PORTED** (writes +$02, +$0E, +$14, +$6A, +$6C, +$6E)
- `object_timer_expire_speed_param_reset` (L30) — **CO-PORTED** (writes +$40, +$62, +$92; simplified for entity 0)
- `field_check_guard` (L31) — **CO-PORTED** (reads +$8C, sets R2 for caller)
- `timer_decrement_multi` (L32) — **CO-PORTED** (decrements 8 timers: +$80-$86, +$98-$9A, +$E6-$E8)
- `object_anim_timer_speed_clear+6` (L40) — **CO-PORTED** (clears +$06; frame counter at entity+$F0)

**Decision: CO-PORT** — All entity-modifying timer/guard functions run on SH2 alongside physics. This solves the entity ownership problem: entity lives permanently in SDRAM after initial frame, no per-frame WRAM→SDRAM staging needed. See §7.8 for details.

### 7.3 Critical Translation Issues (Verified)

| Issue | Detail | Resolution |
|-------|--------|------------|
| **DIVU (gear table)** | `entity_speed_accel` L78: `DIVU $00(A1,D2.W),D1`. Divisor from 6-entry ROM table at $88A1F0: {171, 192, 205, 213, 219, 224}. Input: raw_speed << 8 (max $426800). | **6-entry reciprocal table** in expansion ROM. `MULU.L reciprocal >> 24`. Precision: verified max error ≤1 LSB for all input/gear combinations. |
| **DIVS D0,D1 (runtime)** | `entity_force_integration` L110: `DIVS D0,D1` where D0 = max_speed threshold from RAM $FFBBB2. Divisor is NOT a constant. | **SH2 software signed divide subroutine** (~16 iterations, ~64 cycles). No reciprocal table possible. |
| **DIVS #$0190** | `entity_force_integration` L131: `DIVS #$0190,D1` (÷400, slope increment). | Reciprocal: floor(2^24 / 400) = 41943 ($A3D7). `MULS.L * 41943 >> 24`. |
| **DIVS #$0497** | `drift_physics_and_camera_offset_calc` L27: `DIVS #$0497,D1` (÷1175, speed normalization). | Reciprocal: floor(2^24 / 1175) = 14281 ($37C9). `MULS.L * 14281 >> 24`. |
| **~~DIVS #103~~** | ~~`speed_interpolation` divides by 103.~~ | **REMOVED** — `speed_interpolation` is NOT in the physics pipeline. It's a separate subsystem. |
| **+offset entries** | Orchestrator calls `steering+6` and `force_integration+18`, skipping preambles. | SH2 port uses the main entry points directly. The skipped code (force=-51 default, data prefix) is handled differently in the SH2 version. |
| **entity_pos_update boundary** | ALL 3 exit paths are unconditional JMPs to collision (no RTS). Cannot insert bare RTS. | **Port position calculation only** — replace the 3 JMPs with RTS in the SH2 version. Collision stays on 68K (Phase 5). The 68K orchestrator must call collision separately after SH2 physics returns. |
| **suspension_steering_damping dispatch** | Uses $C8CC (race_substate_b) as jump table index to select lateral_drift variant. | Relocate $C8CC to SDRAM globals block. SH2 reads it to choose variant A or B. |
| **Sound triggers** | 5 writes to $FFCA94: $B1 (2×), $B4 (3×), $B2 (1×). All 15-frame timer gated. Single-byte last-writer-wins. | SDRAM sound byte at globals+$0F. 68K reads each frame, plays via sound driver. |
| **Controller input** | `steering_input` reads $FFC000/$FFC00A/$FFC010/$FFC018 (68K WRAM). | Relocate to SDRAM globals block. 68K writes per-frame from V-INT input scan. |

### 7.4 RAM Variables to Relocate (Verified — 44 bytes)

**SDRAM globals block at $0600BF00 (64 bytes allocated):**

| Offset | 68K Address | Size | Name | Written By | Read By |
|--------|-------------|------|------|-----------|---------|
| +$00 | $FFC0AC | word | track_tilt | Scene init | tilt_adjust |
| +$02 | $FFC0E6 | word | track_speed_factor | Scene init | speed_calc_multiplier_chain |
| +$04 | $FFC0F8 | word | upper_accel_limit | Scene init | (reserved — not in pipeline) |
| +$06 | $FFC0FA | word | lower_accel_limit | Scene init | (reserved — not in pipeline) |
| +$08 | $FFC27C | long | speed_table_ptr | Scene init | speed_calc_multiplier_chain |
| +$0C | $FFC048 | long | gear_table_ptr | Scene init | entity_force_integration, entity_speed_accel |
| +$10 | $FFC0D4 | byte | surface_drivability | Scene init | entity_speed_accel |
| +$11 | $FFC31B | byte | wind_active | Scene handler | speed_calc_multiplier_chain |
| +$12 | $FFC826 | byte | has_boost_flag | Scene handler | speed_calc_multiplier_chain |
| +$13 | $FFC971 | byte | banking_direction | Per-frame | tilt_adjust |
| +$14 | $FFC000 | word | steering_velocity | Per-frame | steering_input_processing |
| +$16 | $FFC00A | word | steering_direction | Per-frame | steering_input_processing |
| +$18 | $FFC010 | byte | input_state | Per-frame | steering_input_processing |
| +$19 | $FFC018 | byte | ai_control_flag | Per-frame | steering_input_processing |
| +$1A | $FFC8C8 | word | mode_flag | Per-frame | speed_calculation |
| +$1C | $FFC8CC | word | race_substate_b | Per-frame | suspension_steering_damping |
| +$1E | $FFBBA0 | word | heading_correction | Track init | lateral_drift |
| +$20 | $FFBBA2 | word | lateral_drag | Track init | lateral_drift |
| +$22 | $FFBBA4 | word | spin_threshold | Track init | lateral_drift |
| +$24 | $FFBBA6 | word | high_vel_threshold | Track init | lateral_drift |
| +$26 | $FFBBA8 | word | drift_divisor | Track init | lateral_drift |
| +$28 | $FFBBB0 | word | min_speed_threshold | Track init | lateral_drift |
| +$2A | $FFBBB2 | word | max_speed_threshold | Track init | entity_force_integration (DIVS runtime divisor) |
| +$2C | $FFCA94 | byte | sound_trigger_out | Physics output | 68K sound dispatch |
| +$2D | $FFBFC0 | byte | ai_control_flag | Scene init | lateral_drift_B (AI boost gate, bit 4) |
| +$2E | $FFBF7B | byte | slide_indicator | lateral_drift_A output | (display feedback) |
| +$2F | — | byte | (padding) | — | — |

**Total used: 48 bytes** (16 bytes free in 64B block)

**Viewport output addresses** (lateral_drift_B writes, 68K reads for display):
- $FF617A (word) — left viewport scale
- $FF618E (word) — right viewport scale
- These are WRAM display registers, NOT relocated to SDRAM. SH2 writes to SDRAM mirror; 68K copies to WRAM per frame.

### 7.5 Entity Field Access Summary (38 Offsets)

Across all 13 physics functions, 38 distinct entity offsets are accessed. Key groups:

| Category | Offsets | Access |
|----------|---------|--------|
| Position | +$30 (X), +$34 (Y), +$3C (heading mirror), +$40 (heading) | RW |
| Speed | +$04, +$06 (display), +$16 (calc), +$74 (raw), +$7E (target) | RW |
| Dynamics | +$0E (force), +$10 (drag), +$78 (grip), +$7A (gear), +$8A (boost mod) | RW |
| Drift | +$4C (slip), +$8E (steer vel), +$90 (drift rate), +$92 (slide), +$94/$96 (lateral), +$AA (accum) | RW |
| Flags | +$02 (status), +$54 (steer mode), +$58/$59 (contact), +$62 (collision), +$6A (lateral), +$8C (lateral flag), +$A8 (speed state), +$AE (table offset) | R mostly |
| Timers | +$14 (boost), +$80 (sound), +$82/$84 (brake), +$98/$9A/+$E6/$E8 (screech) | RW |
| Camera | +$1E (ref angle), +$5A/$5C (trail), +$76 (cam dist) | R/RW |

**Full entity record: 256 bytes per entity, 25 entities = 6,400 bytes.**
Once physics runs on SH2, entity tables must be in SDRAM (already allocated at $0600F20C per Phase 1).

### 7.6 ROM Table References (8 Tables)

| Table | 68K Address | SH2 Address | Size | Used By |
|-------|------------|-------------|------|---------|
| Drag (road surface) | $0093910E | $0213910E | ~128W | entity_force_integration |
| Drag (off-road) | $00938FCE | $02138FCE | ~128W | entity_force_integration |
| Gear ratios | $0088A1F0 | $020A1F0 | 6W (12B) | entity_speed_accel |
| Upshift thresholds | $0088A1E2 | $020A1E2 | 6W (12B) | entity_speed_accel |
| Downshift thresholds | $00939EDE | $02139EDE | 6W (12B) | entity_speed_accel |
| Speed table base | ptr at $FFC27C | ptr relocated to globals | ~384W | speed_calc_multiplier_chain |
| Sine/cosine | $00930000 | $02130000 | 256W (512B) | entity_pos_update, drift_physics |
| Sine table (alt) | $00A2D8 | $0202A2D8 | 64W (128B) | physics_lookup_tables |

**SH2 ROM access:** All tables are in ROM below $300000. SH2 accesses ROM at $02000000 + file_offset. ROM reads from SH2 are cached (1-2 wait states first access, 0 thereafter if in cache). Table locality is good for caching.

### 7.7 Acceptance Criteria (Phase 3B+3D — ALL COMPLETE)

- [x] All 7 physics functions assembled and linked into expansion ROM (884B + 496B)
- [x] 5 timer/guard functions co-ported (280B, interleaved in correct orchestrator order)
- [x] DIVU reciprocal accuracy verified: exact for all 6 gear ratios (zero diff)
- [x] 3600-frame autoplay in dual-path mode — no crashes
- [x] cmd $3F calls physics in correct order with GBR/R13 setup
- [x] Grip clamp bug found and fixed (ratio check before subtraction, not after)
- [x] Frame counter persistence bug found and fixed (entity+$F0, not globals+$30)
- [x] Hardware-level review: GBR range, COMM safety, SDRAM cache, DMAC state — all clear
- [x] SH2-only physics enabled (orchestrator bypass via trampoline in code_1c200)
- [x] Sound triggers reach 68K via COMM6_HI (relay in cmd $3F + pickup in state4_epilogue)
- [x] 68K utilization measured: STOP spin 51.9% → 63.1% (+11.2% idle = physics offloaded)
- [x] 16.16 fixed-point position update (entity+$F2/+$F4 fractional, +$30/+$34 integer, 60 FPS ready)
- [x] Initial-frame-only entity staging ($C8D2 flag, cmd $3E dual mode)
- [x] 3600-frame autoplay with SH2-only physics — no crashes, clean shutdown

### 7.8 Entity Ownership Resolution

**Problem (identified 2026-03-26):** The entity staging function copies 256B from WRAM ($FF9000) to SDRAM ($0600F20C) every frame. When SH2 physics writes results to SDRAM, the next frame's staging OVERWRITES them with stale WRAM data. Physics fields are accumulated (speed, position, grip) — resetting them breaks the simulation.

**Solution: Co-port all entity-modifying functions to SH2.** With physics + timer/guard functions all running on SH2, the SDRAM entity is the sole authoritative copy. Entity staging switches to initial-frame-only mode:

- **First racing frame:** Full 256B WRAM → SDRAM copy (seed initial state)
- **Subsequent frames:** Entity persists in SDRAM, modified only by SH2 physics+timers
- **Per-frame globals:** Still staged every frame via DREQ (controller input, mode flags)

**Timer/guard fields resolved:**

| Function | Offset Written | Conflict With Physics | Resolution |
|----------|---------------|----------------------|------------|
| effect_timer_mgmt | +$02, +$0E, +$14, +$6A, +$6C, +$6E | +$0E read by force_integration | Co-ported, runs before physics |
| timer_expire_reset | +$40, +$62, +$92 | +$40 read by entity_pos_update | Co-ported, runs before steering |
| timer_decrement_multi | +$80-$86, +$98-$9A, +$E6-$E8 | Timers gate sound triggers | Co-ported, runs before force_integration |
| field_check_guard | reads +$8C | Guards lateral physics | Co-ported, runs before timer_decrement |
| anim_timer_speed_clear | +$06 | +$06 read by speed_clamp | Co-ported, runs after tilt_adjust |

**Known simplifications:**
- `timer_expire_reset`: Type check chain (object_id $69-$6F range) skipped. For entity 0 (player), object_id is always $00 < $69, so the check always exits to .set_speed. **Only safe for entity 0.**
- `anim_timer_speed_clear`: JMP to `conditional_return_on_state_match` replaced with RTS. The fallthrough path handles edge-case state transitions that don't occur during normal player racing. **Only safe for entity 0.**
- `anim_timer_speed_clear`: Frame counter stored at entity+$F0 (unused entity field) instead of WRAM $C02A. This avoids the globals staging wipe issue.

### 7.9 SH2 Register Convention (Established Phase 3B)

| Register | Role | Set By | Lifespan |
|----------|------|--------|----------|
| GBR | Entity base ($0600F20C) | cmd $3F via `LDC R0,GBR` | Entire physics pipeline |
| R13 | Globals base ($0600F30C) | cmd $3F via `MOV.L @pool,R13` | Entire physics pipeline |
| R14 | Entity base (for @(R0,R14) indexed access) | cmd $3F (same value as GBR) | Entire physics pipeline |
| R8 | COMM base ($20004020) | Dispatch loop (preserved) | Entire handler |
| R0-R7, R9-R12 | Scratch | Per-function | Function-local |
| R15 | Stack pointer | System | Always |

**Addressing patterns:**
- Entity field ≤ offset 30: `MOV.W @(offset,R14),R0` (displacement, any dest for Rn form)
- Entity field ≤ offset 510: `MOV.W @(offset,GBR),R0` (GBR, **R0 only** for dest/source)
- Entity field > offset 510: not needed (entity is 256B)
- Globals field: `MOV #offset,R0; MOV.W @(R0,R13),Rn` (indexed, R0 must be index)
- ROM table: `MOV.L @pool,Rn; MOV.W @(R0,Rn),Rm` (literal pool + indexed)

### 7.10 Expansion ROM Memory Layout (Phase 3B)

```
$301300-$30148F  coord_transform_batched (388B)       — ACTIVE (S-6 Phase B)
$301500-$301617  cmd $3F (280B)                       — ACTIVE (Phase 3B: copies + 11 physics/timer JSR calls)
$301620-$30167F  cmd $3E (96B)                        — ACTIVE (Phase 3A: DMAC entity+globals transfer)
$301680-$3016DF  physics_divide (80B)                 — ACTIVE (Phase 3B: sh2_sdiv16 + gear reciprocal table)
$3016E0-$301A53  physics_group1 (884B)                — ACTIVE (Phase 3B: speed_degrade + speed_clamp + steering + force_integration)
$301A60-$301C4F  physics_group2_accel (496B)          — ACTIVE (Phase 3B: speed_accel_braking + tilt_adjust)
$301C60-$301D83  physics_timers (284B)                — ACTIVE (Phase 3B: 5 timer/guard co-ports)
$301D84-$3FFFFF  Free (~1013KB)                       — Reserved for Phase 3C-D (drift, position) + Phase 4-5
```

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
| Q-002 | What is the SH2 address for ROM data above $300000 (e.g., $0094C000 track tiles)? | Phase 5 | **RESOLVED: 68K CPU addresses** | All collision ROM refs are 68K CPU addresses ($0088xxxx+). Formula: `SH2_addr = 68K_addr + $01780000` (= 68K - $880000 + $02000000). Example: $0094C000 → file offset $C4000 → SH2 $020C4000. Highest ref: $00970000 → file offset $0EF000 (within 4MB). R-005 mitigated. |
| Q-003 | Can Master SH2 write to frame buffer ($04xxxxxx) when FM=1? | Phase 2 | **RESOLVED: YES, time-separated** | FM=1 gives both SH2s access. BUT current design prevents simultaneous access: Slave writes SDRAM during state 0, Master writes framebuffer during state 4. They never write the same memory at the same time. HW manual §4.2: both SH2s CAN write framebuffer concurrently (same bus), but must not write the same bank simultaneously. |
| Q-004 | Does SDRAM bus contention degrade Slave rendering measurably? | Phase 6 | **OPEN** | Profile Slave utilization before and after Master SDRAM writes. Compare render times. |
| Q-005 | Is the `entity_type_dispatch` RAM table at $C05C written only during scene init? | Phase 4 | **RESOLVED: init-only** | No MOVE/CLR writes to $C05C found in any per-frame code. Used as LEA base in 3 functions (entity_type_dispatch_tables, effect_countdown, hw_reg_init). Table is populated during scene init. Can be snapshot once to SDRAM. |
| Q-006 | How does camera_snapshot_wrapper (A-1 hook) interact with the new architecture? | Phase 2 | **RESOLVED: no conflict** | Camera snapshot runs in state 0 (BEFORE physics in same frame). Reads entity position from WRAM. When physics moves to SH2, camera reads PREVIOUS frame's output — same 1-frame-behind behavior that already exists. No architectural change needed. |
| Q-007 | What happens to the 68K entity render pipeline variants (A/B/C/D, 2P)? | Phase 2 | **RESOLVED: phase 3 = Variant A only** | Variant A (player entity, all 9 physics steps) ports to SH2. Variants B/C/D (AI, replay) continue on 68K — they use reduced physics subsets. Variant selection driven by entity_type_dispatch_tables (indexes jump table at $C05C), stays on 68K. |
| Q-008 | Can we keep menus on 68K while racing logic is on SH2? | All | **RESOLVED: YES** | cmd $3F only fires from `state4_epilogue` in `state_disp_005020` (active racing). Other dispatchers (countdown, results, attract, replay) have different state 4 handlers with no physics trigger. Menu WRAM ($C800-$CFFF) is separate from entity WRAM ($FF9000+). No shared resource conflicts. 115 menu modules stay on 68K entirely. |
| Q-009 | What about the 2-player mode? | Phase 2+ | **RESOLVED: defer to post-Phase 3** | 2P uses Table 3 ($FF9F00) — single 256B entity record (NOT a 15-entry table). Same physics functions as 1P (A0-parameterized). Split-screen viewport at $FF6178. MOVEM block copy in `gfx_2_player_entity_frame_orch` assumes both entities updated on same CPU. Phase 3 = 1P racing only. Porting both players requires either: (A) both on SH2 (2× physics cost) or (B) explicit DMA synchronization barrier. R-008 updated. |
| Q-010 | Can 68K write to SDRAM at $88BC00 (adapter-mapped)? | Phase 1B | **RESOLVED: NO** | $880000-$8FFFFF = cartridge ROM (read-only). SDRAM is SH2-exclusive (HW manual §2, §3.1). Must use COMM relay: 68K writes COMM2-6, cmd $3F copies to SDRAM. |
| Q-011 | Where exactly does cmd $02 write entity visibility data in SDRAM? | Phase 1A | **RESOLVED: $0600C800** | Confirmed: 32 entries × 16 bytes = 512B at $0600C800 ($2200C800 cache-through). Handler $04 reads visibility flag at byte offset +0. Already validated by cmd $3F entity copy ($2200C800 → $2200F20C). |
| Q-012 | Can the cmd $3F trigger be inserted after mars_dma_xfer_vdp_fill? | Phase 1A | **RESOLVED: YES (implemented)** | vr60_comm_trigger inserted in state4_epilogue (code_2200.asm). 78 bytes freed by Phase 2B async conversion. Working in current build. |
| Q-013 | How many gears does the game use? | Phase 3 | **RESOLVED: 6** | Gear ratio ROM table at $88A1F0 has 6 entries: {171, 192, 205, 213, 219, 224}. 7th slot is code, not data. Gear index +$7A ranges 0-5. |
| Q-014 | Does the DIVU use constant or runtime divisors? | Phase 3 | **RESOLVED: table lookup** | DIVU in entity_speed_accel uses 6 known gear ratios from ROM table. Pre-computable reciprocals. DIVS D0,D1 in entity_force_integration IS runtime (max_speed from RAM). |
| Q-015 | What are the 5 interleaved timer/guard functions between physics calls? | Phase 3 | **RESOLVED: 3 safe, 2 conflict** | **Safe** (no physics-input writes): tire_squeal_check (76B), effect_timer_mgmt (106B), timer_decrement_multi (82B). **Conflict** (write physics-input fields): object_timer_expire_speed_param_reset (80B, writes +$40 heading), object_anim_timer_speed_clear+6 (48B, writes +$06 speed). Conflicts are safe because these run BEFORE physics in orchestrator order — keep on 68K. field_check_guard (10B) only reads +$8C, no writes. |
| Q-016 | Is lateral_drift_velocity_B ($0099AA) structurally different from A ($00987E)? | Phase 3 | **RESOLVED: YES, fundamentally different** | B = 358B (not ~300B). Different math: force calc order (mul-then-div vs div-first), AI boost logic (speed > $C8 + AI flag → extra grip loss from +$0E), different grip clamp range ([$40,$FF] vs [$7F,∞]), 2× damping threshold (±$200 vs ±$100), viewport shimmer ($FF617A/$FF618E writes), 2× display scaling. 3 extra entity fields (+$04, +$0E, +$80), 1 extra global ($FFBFC0 AI control flag). Both variants must be ported independently. SH2 estimate: ~420B. |

---

## 13. Decision Log

Record every significant design decision here. Include date, what was decided, why, and what alternatives were rejected.

| Date | Decision | Rationale | Alternatives Rejected |
|------|----------|-----------|----------------------|
| 2026-03-17 | Use cmd $3F (not $40) for VR60 handler | Fits in existing 64-entry jump table. Zero dispatch loop changes. Same approach as B-004/B-005 (proven). | Cmd $40 requires dispatch loop trampoline (6-instruction patch, medium risk). |
| 2026-03-17 | SDRAM mailbox at $0600BC00 | Zero-filled in ROM, no SH2 code references, auto-zeroed by boot IDL copy. | $0600F000 (also free, but farther from entity data). |
| 2026-03-17 | Inline COMM cleanup in cmd $3F handler | Matches cmd22/cmd25 proven pattern. No func_084 call overhead. | JSR func_084 — adds 4 cycles, no safety benefit. |
| 2026-03-17 | Port entity projection BEFORE physics | Pure data transform, no side effects, easiest to verify. Immediate 10.52% benefit. | Port physics first — higher impact per function but harder to verify. |
| 2026-03-18 | Producer-consumer pipeline (not event-driven inversion) | Keep working 68K game logic, decouple from rendering via async. Lower risk than porting all game logic to SH2. | Event-driven inversion (Master SH2 as main loop) — higher reward but requires full game logic rewrite. |
| 2026-03-18 | Frame fence (lock-free, not explicit handshake) | Monotonic counter in COMM3, no blocking on either side. Resilient to timing jitter. | Explicit handshake — re-introduces blocking. Triple-buffer — 12KB WRAM cost for marginal benefit. |
| 2026-03-18 | Display objects only (not entity table transfer) | Entity tables stay in 68K WRAM. Only finished display objects transfer via existing DREQ (900B, already working). Eliminates the need for SDRAM entity table migration. | Full entity table transfer (4KB per frame via extended DREQ) — unnecessary if 68K keeps game logic. |
| 2026-03-18 | Fire-and-forget last COMM0 cmd only | The V-INT $54 gate provides natural synchronization. Making cmd $3F the last COMM0 command ensures state 0's DMA can't fire until cmd $3F completes. | Fire-and-forget all copies — COMM0 collision with re-DMA. |
| 2026-03-17 | Entity tables at $0600F20C (not $06008000) | $06008000 blocked by gradient strip B at $060086D4 (span_filler reads every polygon). $0600F20C-$06017FFF verified free (36.3 KB, zero SH2 code refs). | $06008000 (original plan, conflict with rendering data). |
| 2026-03-17 | Skip DREQ FIFO for entity tables | Master SH2 will own entity tables directly once game logic is ported. During migration, copy from existing cmd $02 landing area. FIFO destination is SH2 DMAC-controlled (not 68K), making redirection complex. | DREQ FIFO with DMAC reconfiguration (complex, unnecessary). |
| 2026-03-17 | Use git tag (not duplicate codebase) for baseline comparison | `vr60-phase0-baseline` tag enables `git diff` at any time. Simpler than maintaining parallel codebase. | Separate codebase clone (maintenance overhead, divergence risk). |
| 2026-03-24 | SDRAM globals block at $0600BF00 (64 bytes) | Between mailbox ($0600BC00) and entity data ($0600C000). 46 bytes used, 18 reserved. Close to existing SDRAM allocations. | $0600F200 (near entity mirror, but crossing into allocated range). |
| 2026-03-24 | SH2 software divide for runtime DIVS | entity_force_integration's DIVS D0,D1 has runtime divisor (max_speed threshold from RAM). No pre-computation possible. ~64 SH2 cycles vs 140 68K cycles for DIVS. | Reciprocal lookup table — would need 65K entries for full 16-bit range. |
| 2026-03-24 | Reciprocal multiply for constant DIVS | DIVS #$0190 and DIVS #$0497 are compile-time constants. Reciprocal at 2^24 precision gives exact results for all signed 16-bit inputs. Zero runtime overhead beyond MULS+shift. | SH2 software divide — correct but unnecessarily slow for known constants. |
| 2026-03-24 | entity_pos_update: replace JMPs with RTS for SH2 port | The 3 JMP exits into collision are the Phase 5 boundary. SH2 version returns after position update; 68K orchestrator calls collision separately. | Keep entity_pos_update on 68K — wastes the opportunity to run position math on SH2. |
| 2026-03-26 | GBR as entity base pointer (not R14-only) | GBR `MOV.W @(disp,GBR),R0` has 8-bit disp × 2 = 0-510 byte range. Entity is 256B — ALL fields reachable. Eliminates the R0+Rn indexed workaround for offsets > 30. Verified against SH2 ISA docs. | R14-only with indexed addressing — requires `MOV #offset,R0; EXTU.B R0,R0; MOV.W @(R0,R14),R0` for every field > offset 30 (3 instructions vs 1). |
| 2026-03-26 | Co-port timer/guard functions to SH2 (not keep on 68K) | Solves entity ownership: entity lives permanently in SDRAM, no per-frame WRAM→SDRAM staging. 5 functions, 284B SH2 code. Interleaved in cmd $3F matching 68K orchestrator order. | Keep on 68K with selective field staging — requires identifying exactly which bytes to copy per frame, complex, error-prone. COMM relay — 16 bytes too small for 20+ bytes of timer-modified fields. |
| 2026-03-26 | Dedicated cmd $3E for entity transfer (not DREQ extension) | Independent DMAC channel 0 configuration. Doesn't modify shared `mars_dma_xfer_vdp_fill`. 68K pushes 320B to FIFO, SH2 DMAC drains to $0600F20C. Clean separation of concerns. | Extend existing DREQ (modify shared function, affects all modes). |
| 2026-03-26 | Frame counter at entity+$F0 (not globals+$30) | globals+$30 is cleared every frame by `vr60_globals_stage`. Entity field +$F0 is unused (last documented field is +$E8) and persists across frames. | Store in globals — broken (wiped each frame). Store in WRAM — SH2 can't access. Separate SDRAM slot — adds complexity. |
| 2026-03-26 | Dual-path verification before SH2-only activation | Both 68K and SH2 run physics simultaneously. Game uses 68K results. SH2 results can be compared for correctness without risk. Only disable 68K physics after SH2 output is verified. | Direct switchover — high risk, no fallback if SH2 output is wrong. |

---

## 14. Risk Registry

| ID | Risk | Severity | Phase | Status | Mitigation |
|----|------|----------|-------|--------|-----------|
| R-001 | DREQ FIFO cannot target $06008000 | Blocking | Phase 1 | **RESOLVED** | Moot — entity tables don't use FIFO. Master copies from cmd $02 landing area. |
| R-002 | SDRAM bus contention degrades Slave | High | Phase 6 | **OPEN** | Pipeline writes during Slave Pipeline 1 (on-chip SRAM period). Measure before/after. |
| R-003 | DIVU/DIVS reciprocal rounding mismatch | Medium | Phase 3 | **RESOLVED** | Gear reciprocal table verified exact for all 6 ratios (zero diff). DIVS #$0190 and #$0497 reciprocals verified at 2^24 precision. Software divide sh2_sdiv16 uses same shift-subtract algorithm as hardware. |
| R-004 | Entity field access slower on SDRAM (2-6 wait states vs 0) | Medium | Phase 1 | **OPEN** | SH2 clock is 3× faster, compensating for wait states. Profile to verify net effect. |
| R-005 | Track tile ROM addresses are 68K-relative (not file offsets) | Blocking | Phase 5 | **RESOLVED** | Confirmed: all collision ROM refs are 68K CPU addresses. SH2 conversion: `addr + $01780000`. Highest ref $00970000 = file offset $EF000 (within 4MB ROM). Pointer tables at $742C/$745C contain mode-indexed segment_map/base_data pairs. |
| R-006 | Camera interpolation (A-1) conflicts with new architecture | High | Phase 2 | **OPEN** | A-1 hooks into 68K scene state 0. If state machine moves to SH2, camera must move too. May need interim hybrid (camera on 68K, physics on SH2). |
| R-007 | Scene transitions corrupt double-buffer state | High | Phase 6 | **OPEN** | Flush both buffers on mode change. Single-buffer fallback during transitions. |
| R-008 | 2-player mode has different entity/render paths | Medium | All | **CHARACTERIZED** | 2P uses same physics (A0-parameterized), Table 3 ($FF9F00, 1 entity), split-screen viewport. MOVEM block copy in `gfx_2_player_entity_frame_orch` assumes same-CPU update. Phase 3 = 1P only. 2P requires either both players on SH2 or explicit sync barrier. Defer to post-Phase 3. |
| R-009 | Sound timing drift when game logic runs ahead of display | Medium | Phase 6 | **OPEN** | Timestamp sound events in SDRAM queue. 68K plays at correct V-INT timing. |
| R-010 | Gradient strip B ($060086D4) invalidated original SDRAM address plan | Medium | Phase 1 | **RESOLVED** | All addresses moved to $0600F20C+. Always grep before allocating SDRAM. |
| R-011 | cmd $3F trigger in state 4 adds COMM0_HI blocking time | Low | Phase 1A | **OPEN** | Temporary for validation only. In Phase 2+, cmd $3F replaces cmd $02. |
| R-012 | 68K→SDRAM direct write at $88xxxx may be read-only ROM mapping | Medium | Phase 1B | **RESOLVED: confirmed ROM (read-only)** | $88xxxx = cartridge ROM per HW manual §3.1. COMM relay is the ONLY option. |
| R-013 | Physics port scope 50% larger than estimated (2,642B vs 1,760B) | Medium | Phase 3 | **IDENTIFIED** | 3 previously unlisted functions: drift_physics_and_camera_offset_calc (378B), suspension_steering_damping (124B), lateral_drift_B (~300B). Budget SH2 expansion space accordingly (~3,700B). |
| R-014 | Runtime DIVS in entity_force_integration — no reciprocal possible | Low | Phase 3 | **MITIGATED** | SH2 software signed divide (~64 cycles). Called once per entity per frame. Total overhead: 25 entities × 64 cycles = 1,600 cycles/frame. Negligible vs 383K cycle budget. |
| R-015 | 2 timer/guard functions write physics-input fields (+$40, +$06) | Low | Phase 3 | **RESOLVED** | Co-ported all 5 timer/guard functions to SH2 (Phase 3B-5). Entity ownership problem solved — entity lives permanently in SDRAM. Timer/guard calls interleaved with physics in cmd $3F, matching 68K orchestrator order. |
| R-016 | entity_pos_update JMP→collision boundary creates split-CPU execution | Medium | Phase 3/5 | **OPEN** | Position update on SH2, collision on 68K. 68K must call collision after reading SH2-updated position from SDRAM. Adds ~1 frame latency to collision response unless pipelined. |
| R-017 | SH2 timer_expire_reset simplified for entity 0 only | Low | Phase 3B | **ACCEPTED** | Object type check chain ($C89C/$C8C8/object_id $69-$6F) skipped. For entity 0, object_id=$00 < $69 always reaches .set_speed. If called for other entities, would produce incorrect behavior. Safe: cmd $3F only processes entity 0. |
| R-018 | SH2 anim_timer_speed_clear lacks conditional_return_on_state_match fallthrough | Low | Phase 3B | **ACCEPTED** | 68K JMPs to a state-check function that either returns or falls through. SH2 always returns (RTS). The fallthrough path handles edge-case state transitions during animation timer expiry — not observed during normal player racing. Monitor during extended testing. |
| R-019 | Entity staging overwrites SH2 physics results | Critical | Phase 3B | **RESOLVED** | Staging copies WRAM→SDRAM every frame, overwriting accumulated SH2 physics. Fix: initial-frame-only staging (first racing frame seeds SDRAM, subsequent frames entity persists in SDRAM). Timer/guard co-port to SH2 completes the solution. |

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
| 2026-03-17 | Phase 1B (Q-010) | **68K CANNOT write SDRAM at any address.** $880000-$8FFFFF = cartridge ROM (read-only, HW manual §2 + §3.1). SDRAM is SH2-exclusive. The only 68K→SH2 shared memory is COMM (16B) + Frame Buffer (FM-controlled). | All 68K→SH2 data must go through COMM registers. For bulk data, the DREQ FIFO is the only mechanism (68K writes FIFO, SH2 DMAC drains to SDRAM). For small params (<10 bytes), COMM relay is simplest. |
| 2026-03-17 | Phase 2A | **Only 2 sh2_send_cmd calls per race frame, NOT 14.** Both in state4_epilogue, both with CONSTANT params. sh2_cmd_27 = 0 calls during racing (21×/frame was menus/attract). camera_interpolation_60fps.asm is untracked and not in the build. | The "14×" was stale. Corrected all roadmap references. |
| 2026-03-17 | Phase 2A | **Block copy consolidation saves ~0%, not ~10%.** The 10.52% sh2_send_cmd hotspot is SH2 COPY EXECUTION TIME (waiting for 288×48+288×24 byte copies to complete), not handshake overhead. Consolidating into cmd $3F is +33% SLOWER because it removes interleaving. | Never assume profiling hotspots are "overhead" — they may be fundamental execution waits. The only fix is pipeline overlap (Phase 6). |
| 2026-03-17 | Phase 2A | **COMM0 contention prevents async copies.** mars_dma_xfer_vdp_fill and cmd $3F both use COMM0. They cannot overlap. This means the 68K must wait for cmd $3F completion before re-DMA. | Any architecture with multiple COMM0 users must serialize them. Future design should minimize COMM0 usage. |
| 2026-03-17 | Phase 2A | **Always re-verify profiling numbers before planning optimizations.** The "14× sh2_send_cmd" and "21× sh2_cmd_27" figures were from old profiling or non-racing modes. Fresh profiling with the current build is essential. | Re-profile after every phase before planning the next one. |
| 2026-03-18 | Phase 2B | **The V-INT $54 handler is the natural async synchronization gate.** It stalls the state machine at state 8 until COMM1_LO bit 0 is set. This means fire-and-forget is safe: the gate prevents state 0's DREQ DMA from firing while cmd $3F is still running. No new synchronization needed. | The existing architecture already has the primitive we need. We just needed 7 research investigations to see it. |
| 2026-03-18 | Phase 2B | **camera_avg_and_redma produces zero visible change** (FRAME_RATE_ARCHITECTURE.md §9.4). The re-DMA sends interpolated camera data to SH2, but the SH2 doesn't re-render with it. The "40 FPS" is reduced latency (inline swap shows render 1 TV frame earlier), not two unique frames per game tick. | Interpolation infrastructure exists but is non-functional. This may be an opportunity for future activation once pipeline overlap (Phase 6) enables true dual rendering. |
| 2026-03-18 | Phase 2B | **45+ sh2_send_cmd call sites exist across ALL game modes.** Not just racing. Menus have 1-7 per frame, HUD has per-digit calls, name entry has 10+. Async only targets racing state4_epilogue (the 2 largest calls). All other modes stay synchronous. | Never assume a "global" change — always map all call sites first. |
| 2026-03-18 | Phase 2B | **4 mode transition hazards found but all protected by V-INT gate.** mars_dma_xfer_vdp_fill has no COMM0 idle check, but can't fire while cmd $3F runs (state stalls at 8). Handler replacement is deferred to next frame. C8A8 reset only happens during menu transitions (not racing). | The synchronous model's implicit barriers protect the async model too. |
| 2026-03-24 | Phase 3 research | **Physics pipeline has 13 functions, not 9.** Three were missing from the roadmap: `drift_physics_and_camera_offset_calc` (378B, contains DIVS #$0497), `suspension_steering_damping` (124B, jump table dispatches lateral_drift variants), and `lateral_drift_velocity_B` (~300B, AI variant). Total: 2,642B 68K → ~3,700B SH2. | Always trace the orchestrator call-by-call before planning ports. The roadmap's function list was assembled from documentation, not from reading the actual orchestrator source. |
| 2026-03-24 | Phase 3 research | **Orchestrator uses +offset entry points** (`steering+6`, `force_integration+18`) to skip initialization preambles. The SH2 port must handle these entry semantics — either by implementing the same skip or by restructuring the SH2 functions. | When porting, read the CALL SITE (orchestrator), not just the function itself. Entry offsets change the effective interface. |
| 2026-03-24 | Phase 3 research | **`drift_physics_and_camera_offset_calc` is NOT `lateral_drift_velocity`.** The orchestrator calls drift_physics first (camera follow + heading drift), then suspension_steering_damping (which dispatches to lateral_drift via jump table). Two separate functions with different purposes. | Function names in the roadmap were assumed from PHYSICS_SYSTEM_ARCHITECTURE.md descriptions, not verified against actual call sites. Always read the orchestrator. |
| 2026-03-24 | Phase 3 research | **Gear ratio table has 6 entries, not 7.** Values: {171, 192, 205, 213, 219, 224} at ROM $88A1F0. The 7th position contains code (MOVE.W instruction), not data. 68K→SH2 ROM offset mapping: subtract $880000 from 68K absolute address to get file offset, then add $02000000 for SH2. | Always read ROM data bytes directly instead of assuming table sizes from documentation or function analysis. |
| 2026-03-24 | Phase 3 research | **DIVS #103 (speed_interpolation) is NOT in the physics pipeline.** It's a separate subsystem. Only 4 divisions exist in the actual pipeline: DIVU gear_table (6 constants), DIVS D0 (runtime), DIVS #$0190, DIVS #$0497. The "DIVS #103" claim was from a stale roadmap entry that listed speed_interpolation as a physics function. | Always verify function membership by reading the orchestrator, not by searching for "physics" in filenames. |
| 2026-03-24 | Phase 3 research | **Timer/guard functions between physics calls: 3 safe, 2 write physics inputs.** object_timer_expire_speed_param_reset writes +$40 (heading), object_anim_timer_speed_clear writes +$06 (speed). Both run BEFORE physics in orchestrator call order. No co-porting needed — keep on 68K, natural ordering ensures correct values reach SH2 physics. | When analyzing function dependencies for CPU migration, check WRITE→READ ordering, not just which fields are accessed. Same-CPU ordering is free synchronization. |
| 2026-03-24 | Phase 3 research | **lateral_drift_velocity_B is structurally different from A — NOT a subset.** Different math (mul-then-div vs div-first), different grip range ([$40,$FF] vs [$7F,∞]), AI boost logic (speed-gated), viewport shimmer writes, 2× damping, 2× display scaling. 358B (not ~300B). Must port independently. | Never assume "variant" means "minor parameter change." Read both implementations fully before estimating scope. |
| 2026-03-24 | Phase 3 research | **$C05C entity_type_dispatch table is init-only.** No per-frame writes found. Can be snapshot once to SDRAM during scene init. Confirms Phase 4 (AI port) can use a static copy. | Verified by grep: no MOVE/CLR writes to $C05C in any per-frame code path. |
| 2026-03-24 | Q-002 | **All collision ROM addresses are 68K CPU addresses, not file offsets.** Conversion: `SH2_addr = 68K_addr + $01780000`. Highest reference: $00970000 → file offset $EF000 (within 4MB). Track pointer tables at $742C/$745C contain mode-indexed segment_map/base_data address pairs. | R-005 resolved. No ROM boundary issues. Phase 5 collision port can proceed with simple address arithmetic. |
| 2026-03-24 | Q-008 | **cmd $3F only fires during active racing (`state_disp_005020`).** The other 4 dispatchers (countdown, results, attract, replay) have entirely different state 4 handlers with no physics trigger. Menu scene handlers are completely separate. | No mode-gate needed for cmd $3F — the scene handler architecture IS the gate. Menus stay on 68K with zero SH2 interaction. |
| 2026-03-24 | Q-009 | **2P uses identical physics functions as 1P (A0-parameterized).** Table 3 ($FF9F00) is a single 256B entity, not a 15-entity table. `gfx_2_player_entity_frame_orch` MOVEM block copy assumes both entities updated on same CPU — splitting P1/P2 across CPUs creates race conditions in display DMA. | Phase 3 = 1P only. 2P deferred. When porting 2P, either both players on SH2 or add explicit sync barrier. |
| 2026-03-26 | Phase 3B | **GBR as entity base: 510-byte displacement covers the entire 256B entity record.** `MOV.W @(disp,GBR),R0` uses 8-bit disp × 2 = 0-510 byte range. Every entity field is reachable in a single instruction. The constraint: only R0 can be source/destination for GBR access. Work around by `MOV R0,Rn` after load or `MOV Rn,R0` before store. | SH2 ISA docs §6 (displacement modes). The Rn-displacement form (`MOV.W @(disp,Rn),R0`) has only 4-bit disp × 2 = 0-30 byte range — grossly insufficient for entity fields. GBR is the correct choice. |
| 2026-03-26 | Phase 3B | **SH2 CMP/PL = strictly > 0, not >= 0.** "Compare PLus" sets T=1 when Rn > 0 (signed). This matches 68K TST+BLE exactly (BLE branches when value ≤ 0, fall-through when > 0). A code review agent flagged this as a bug, but verification against the ISA docs confirmed correctness. | Always verify SH2 instruction semantics against the primary source (sh1-sh2-cpu-core-architecture.md), not agent reasoning. Subtle instruction names like "PL" (plus) can mislead — it means "positive", not "plus-or-zero". |
| 2026-03-26 | Phase 3B | **Entity ownership problem: staging overwrites SH2 physics results.** Full WRAM→SDRAM entity copy every frame destroys accumulated SH2 values (speed, position, grip). Solution: co-port timer/guard functions to SH2 so entity lives permanently in SDRAM. Initial-frame staging seeds the entity; subsequent frames persist it. | The problem was not obvious during Phase 3A design because dual-path mode masks it (68K keeps WRAM correct, so staging sends valid data). Only becomes visible when 68K physics is bypassed. |
| 2026-03-26 | Phase 3B | **Grip clamp logic must cap the RATIO, not the GRIP.** 68K: `DIVS D0,D1; SUB.W D1,grip; CMPI.W #$80,D1; BLE .done; MOVE.W #$80,grip`. The CMPI checks D1 (ratio), not the subtracted grip. SH2 translation initially checked grip after subtraction — produces different results when ratio < 128. | When translating multi-step arithmetic with conditional overrides, trace which REGISTER each instruction operates on. The 68K's register-based flow (D0 vs D1 vs memory) is easy to conflate in SH2 where R0 is heavily reused. |
| 2026-03-26 | Phase 3B | **Persistent data cannot live in the globals staging block.** `vr60_globals_stage` clears +$30 to +$3F every frame. The anim_timer frame counter was stored at globals+$30 and got wiped. Moved to entity+$F0 (unused field, within GBR range). | Before storing persistent data in any SDRAM region, verify what else writes to that region. The globals staging function is a silent data destroyer for any slot it touches. |
| 2026-03-26 | Phase 3B | **SH2 gas assembler GBR word displacement expects BYTE OFFSETS, divides by 2 internally.** Writing `@(53,gbr)` means byte offset 53, which is ODD → "misaligned offset" error. Must use actual entity byte offsets: `@(0x6A,gbr)` for field +$6A (106). Gas computes disp = 106/2 = 53 for the encoding. | The gas manual is unclear on this. Test: `@(4,gbr)` works because 4/2 = 2 (integer). `@(5,gbr)` would fail for word access. Always use hex entity offsets directly. |
| 2026-03-26 | Phase 3B | **SH2 indexed store `MOV.W Rm,@(R0,Rn)` requires R0 as INDEX, not as VALUE.** When storing a value to an indexed address, the value must be in Rm (any register), and the offset MUST be in R0. If R0 holds the value to store, swap: put value in R1, offset in R0, then `MOV.W R1,@(R0,R13)`. | This constraint applies to ALL indexed addressing modes on SH2, both loads and stores. R0 is always the index register in `@(R0,Rn)` forms. Plan register allocation accordingly. |

---

*This document is a living roadmap. Update it after every session. Add to Open Questions when uncertainties arise. Add to Decision Log when choices are made. Add to Lessons Learned when things surprise us. Add to Risk Registry when new dangers are identified.*
