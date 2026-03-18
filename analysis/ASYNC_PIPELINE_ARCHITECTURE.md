# Async Producer-Consumer Pipeline Architecture

**Created:** 2026-03-18
**Purpose:** Complete architectural analysis for converting the synchronous 68K↔SH2 frame pipeline to an async producer-consumer model. Based on 7 independent research investigations (R1-R7) with full codebase evidence.

---

## 1. Executive Summary

The original game uses a **synchronous pipeline**: the 68K blocks on every SH2 command, waiting for completion before proceeding. This costs 10.29% of frame time in `sh2_send_cmd` waits. The async architecture eliminates these waits by making the last COMM0 command of each frame fire-and-forget, with the existing V-INT $54 handler providing natural frame synchronization.

**Key finding from research:** The V-INT $54 handler (`vdp_dma_frame_swap_037`) already implements the exact synchronization primitive we need — it stalls the state machine at state 8 until COMM1_LO bit 0 is set. This gate protects against COMM0 collisions, mode transition races, and dropped frames. We don't need to build new synchronization; we just need to trust the existing one.

---

## 2. Hardware Constraints (Verified)

### 2.1 Frame Buffer (R1)

Two DRAMs (128KB each), selected by FS bit at `$A1518B`:
- **FS=0:** Displays DRAM0, draw to DRAM1
- **FS=1:** Displays DRAM1, draw to DRAM0
- **FS writes during active display are DEFERRED to next VBlank** (hardware guarantee)

**68K ONLY controls FS** — 8 toggle locations, all using the same pattern:
```asm
bchg    #0,($FFFFC80C).w    ; toggle software flag
bne.s   .set_1
bset    #0,$A1518B           ; FS=1
bra.s   .done
.set_1: bclr #0,$A1518B      ; FS=0
```

SH2 never writes FS. Block copies and rendering write to the DRAW buffer (whichever buffer FS is NOT currently displaying).

**Evidence:** `vdp_dma_frame_swap_037.asm:59-64`, `vdp_dma_palette_xfer_036.asm:60-65`, `vdp_dma_cram_xfer.asm:60-62`, `code_2200.asm:159-160`, `camera_interpolation_60fps.asm:48-49,118-119`

### 2.2 COMM1 Register (R2)

COMM1 carries **four signal types** that must not be corrupted:

| Byte | Bits | Purpose | Writers | Readers |
|------|------|---------|---------|---------|
| COMM1_HI ($A15122) | All | Mode flags (track index, 2P flag) | 68K (scene init only) | None confirmed (one-shot) |
| COMM1_LO ($A15123) | Bit 0 | "Command done" — Master SH2 signals completion | Every Master handler | All frame swap handlers, scene init, V-INT |
| COMM1_LO ($A15123) | Bit 1 | DMA ACK — DREQ transfer acknowledged | Slave SH2 | `mars_dma_xfer_vdp_fill`, palette handlers |

**Critical pattern:** SH2 handlers clear COMM1 as a WORD (`mov.w r0,@(2,r8)` = both HI+LO = $0000), then set bit 0. This wipes mode flags — safe because they're one-shot during scene init.

**Evidence:** 40+ COMM1_LO poll sites documented across all game modes. `cmd22_single_shot.asm:124,210`, `cmd3f_vr60_gameframe.asm:85-88`, `hw_init_short.asm:29-31`

### 2.3 Memory Regions (R6)

**No cross-CPU memory overlap during racing:**

| CPU | Reads | Writes | Timing |
|-----|-------|--------|--------|
| Slave SH2 | SDRAM (entity data) | SDRAM ($06038000 geometry, $0603B600 sprites) | State 0 (TV frame 1) |
| Master SH2 | SDRAM ($06038000, $0603B600) | Framebuffer ($04012010, $0401B010) | State 4 (TV frame 2) |

Time separation (state 0 vs state 4) prevents read-during-write conflicts. The frame buffer is partitioned: geometry at offset $12010 (48 rows), sprites at offset $1B010 (24 rows). Row stride = $0200 (512 bytes).

---

## 3. State Machine Analysis (R3, R7)

### 3.1 The 0→4→8 Pipeline

```
State 0 (TV Frame 1):
  camera_snapshot_wrapper → mars_dma_xfer_vdp_fill
  DREQ DMA: $FF6000 block (2560B) → SH2 SDRAM
  Triggers Slave rendering of camera N
  V-INT state: $0014 (VDP sync)

State 4 (TV Frame 2):
  mars_dma_xfer_vdp_fill (same as state 0 — scene data refresh)
  sh2_send_cmd ×2: SDRAM → framebuffer (BLOCKS ~13,437 cycles total)
  Inline frame swap (fire-and-forget: checks COMM1_LO, swaps if ready)
  camera_avg_and_redma: averages prev/curr camera, re-DMAs
  vr60_comm_trigger: cmd $3F relay
  V-INT state: $001C (sprite cfg)

State 8 (TV Frame 3):
  Full game logic: physics, AI, collision, entity updates, HUD
  V-INT state: $0054 → vdp_dma_frame_swap_037
```

### 3.2 Dependencies (STRICT, cannot reorder)

| Dependency | Why | Evidence |
|-----------|-----|----------|
| State 0 → State 4 | DREQ DMA must reach SH2 before copies can read rendered data | `sh2_send_cmd` waits for COMM0_HI=0 (proves prior DMA done) |
| State 4 → State 8 | Block copies must complete before V-INT swaps frame buffer | V-INT $54 polls COMM1_LO bit 0 |
| State 8 → State 0 | V-INT $54 must reset $C87E before next frame begins | $C87E reset is conditional on COMM1_LO bit 0 |

### 3.3 Dropped Frame Recovery (R7)

**The game already handles this gracefully:**
1. V-INT $54 fires during state 8's TV frame
2. Checks COMM1_LO bit 0 — is SH2 done?
3. If NOT set: skips swap, does NOT reset $C87E → state machine STALLS at state 8
4. Next TV frame: V-INT fires again, retries the check
5. When SH2 finally finishes: swap happens, $C87E resets to 0, state 0 runs

**State 4 always advances** (line 167: `addq.w #4,$C87E`). State 8 is the synchronization gate.

**No timeouts exist anywhere.** All COMM polling is infinite. SH2 crash = permanent 68K hang. DREQ FIFO writes have hardware flow control (bus stall if FIFO full).

---

## 4. Cross-Mode Analysis (R4, R5)

### 4.1 sh2_send_cmd Usage (R4)

**45+ call sites across ALL game modes:**

| Mode | Call Sites | Calls/Frame | Parameters |
|------|-----------|-------------|------------|
| Racing (state4_epilogue) | 2 | 2 | Geometry $06038000→$04012010, Sprites $0603B600→$0401B010 |
| Camera interpolation | 4-5 | 4-5 | Same geometry+sprites, from state0 and state4 hooks |
| Menu rendering | 3-7 per screen | varies | Various SDRAM→framebuffer regions |
| Name entry | 10-15 | 10-15 | Small tiles, scroll areas, score displays |
| HUD digits | per-character | 8-20 | 12×16 tile copies |
| Camera selection | 2-4 | 2-4 | 3D view + overlays |

**Implication:** Async fire-and-forget only applies to the LAST sh2_send_cmd call before the state advance. Earlier calls in the same state must still be synchronous (each depends on the previous completing).

### 4.2 Mode Transition Hazards (R5)

**4 hazards identified:**

| # | Hazard | Location | Risk | Mitigation |
|---|--------|----------|------|-----------|
| H-1 | `mars_dma_xfer_vdp_fill` writes COMM0 without checking COMM0_HI | mars_dma_xfer_vdp_fill.asm:21-22 | Clobbers in-flight command | **V-INT $54 gate prevents this**: state 0's DMA can't fire while cmd $3F is running because $C87E stalls at state 8 until COMM1_LO bit 0 is set |
| H-2 | C8A8 cleared without COMM idle check | state_reset_multi.asm:34, full_state_reset_b.asm:41 | If DMA fires with C8A8=$0000, SH2 never dispatches → hang | Only during mode transitions (menu reset). cmd $3F only runs during racing. |
| H-3 | Handler replacement without idle check | sh2_handler_dispatch_scene_init entry 1 | New handler's state 0 could fire during in-flight command | **V-INT $54 gate protects**: handler replacement changes $FF0002 for NEXT frame, but current frame's state 8 V-INT gate ensures cmd $3F completes before $C87E resets |
| H-4 | Attract/replay skip full SH2 init | scene_setup_game_mode_transition | SDRAM buffers may contain stale data | Pre-existing issue, unrelated to async changes |

**Key insight:** The V-INT $54 gate (R7 finding) naturally protects against ALL of these hazards during racing. The async change only affects the TIMING of when copies happen (state 4 vs state 4-8 overlap), not the synchronization MODEL (which remains: COMM1_LO bit 0 gates frame swap and $C87E reset).

---

## 5. Camera Interpolation Status (R3)

**Critical finding:** The camera_avg_and_redma function (state 4) sends interpolated camera data to SH2 via DREQ re-DMA, but **produces zero visible change** (FRAME_RATE_ARCHITECTURE.md §9.4). The SH2 receives the data but doesn't re-render with it — no new frame is produced from the interpolated camera.

**Implication:** The "40 FPS" display rate comes from the **inline frame swap in state 4** showing the camera N render one TV frame earlier (reduced latency), not from actually rendering two unique frames per game tick. Each game tick still produces one unique rendered frame.

**For the async architecture:** camera_avg_and_redma has no data dependency on the block copies (it reads WRAM camera snapshots, not framebuffer data). It can safely execute before or after the copies.

---

## 6. The Proposed Architecture

### 6.1 What Changes

**REMOVE from state4_epilogue:**
- 2× `sh2_send_cmd` calls (geometry + sprite block copies)
- Inline frame swap check (COMM1_LO poll + FS toggle)

**REORDER in state4_epilogue:**
- `camera_avg_and_redma` BEFORE cmd $3F trigger (COMM0 sequencing)

**ADD to cmd $3F handler (SH2 expansion):**
- Geometry block copy: $2200[3]8000 → $04012010, 288×48
- Sprite block copy: $2200[3]B600 → $0401B010, 288×24
- Set COMM1_LO bit 0 after all copies complete (existing "done" signal)

**UNCHANGED:**
- V-INT $54 handler (already polls COMM1_LO and gates frame swap)
- State advance ($C87E += 4)
- State 8 game logic
- All other modes (menus, attract, name entry — still synchronous)

### 6.2 New Frame Timeline

```
State 0 (TV Frame 1):
  mars_dma_xfer_vdp_fill → DREQ DMA to SH2
  Slave renders camera N from SDRAM data
  V-INT state: $0014

State 4 (TV Frame 2):
  mars_dma_xfer_vdp_fill → DREQ DMA refresh
  camera_avg_and_redma → interpolate + re-DMA (no visible effect)
  vr60_comm_trigger → cmd $3F (FIRE-AND-FORGET, NO WAIT)
    ↳ Master SH2 starts block copies in background
  addq.w #4,$C87E → advance to state 8
  V-INT state: $001C

  [Meanwhile, Master SH2 runs cmd $3F:]
  Read COMM3-5 (frame fence, game state, toggle)
  Clear COMM0_LO (params consumed)
  Copy geometry: $06038000 → $04012010 (288×48, ~7K SH2 cycles)
  Copy sprites: $0603B600 → $0401B010 (288×24, ~3.5K SH2 cycles)
  Copy entity data: $0600C800 → $0600F20C (Phase 1A validation)
  Write canary
  Clear COMM1, set COMM1_LO bit 0 ("frame done")
  Clear COMM0_HI (idle)
  ← Total: ~41K SH2 cycles ≈ 0.9 ms

State 8 (TV Frame 3):
  Game logic: physics, AI, collision, entity updates, HUD
  ~11,000 68K cycles ≈ 1.4 ms
  V-INT state: $0054 → vdp_dma_frame_swap_037:
    COMM1_LO bit 0 is SET (cmd $3F finished ~0.5 ms ago)
    → Frame swap + $C87E reset → next frame

State 0 (next frame):
  COMM0_HI = $00 (cmd $3F cleared it)
  mars_dma_xfer_vdp_fill → safe to write COMM0
```

### 6.3 Why It's Safe

| Concern | Resolution | Evidence |
|---------|-----------|----------|
| COMM0 collision (cmd $3F vs next DMA) | V-INT $54 stalls $C87E until cmd $3F clears COMM0_HI | vdp_dma_frame_swap_037.asm:50-53 |
| Frame swap before copies complete | V-INT $54 only swaps when COMM1_LO bit 0 is set | Same handler, same mechanism as today |
| Mode transition during in-flight cmd $3F | Handler replacement takes effect next frame; current frame's V-INT gate ensures completion | R5 analysis: $FF0002 change is deferred |
| Dropped frame (cmd $3F too slow) | V-INT $54 skips swap, state stalls at 8, retries next TV frame | Existing graceful degradation, unchanged |
| COMM1 corruption | cmd $3F follows same clear-word-then-set-bit-0 pattern as cmd $22 | cmd3f_vr60_gameframe.asm:85-88 |
| Memory overlap (copies vs rendering) | Slave renders to SDRAM during state 0; Master copies from SDRAM during state 4. Time-separated. | R6 analysis |
| Camera re-DMA dependency on copies | camera_avg_and_redma reads WRAM ($FF6080/$FF6090), not framebuffer. No dependency. | code_2200.asm:116-126 |

---

## 7. Expected Performance Impact

**Savings: 10.29% of 68K frame time (13,437 cycles)**

The two `sh2_send_cmd` calls in state4_epilogue block the 68K for ~13,437 cycles waiting for Master SH2 copy completion. By making cmd $3F fire-and-forget, these cycles overlap with state 8 game logic instead of stalling the 68K.

| Metric | Before | After | Delta |
|--------|--------|-------|-------|
| 68K active time | 100.1% | ~89.8% | -10.3% |
| State 4 duration | ~15,000 cyc | ~1,500 cyc | -90% |
| Master SH2 utilization | 0-36% | 0-36% + copies | +~5% |
| Frame rate | 20 FPS | Still 20 FPS (but closer to 30 FPS budget) | +10% headroom |

Note: This alone doesn't reach 30 FPS. It frees 10% of the 68K budget, bringing total useful work down. Combined with other optimizations (state 8 game logic reduction), 30 FPS becomes achievable.

---

## 8. Scope & Limitations

### What This Changes
- Racing mode state4_epilogue ONLY
- cmd $3F SH2 handler (expansion ROM)
- One code path in one state of one mode

### What This Does NOT Change
- Menu, attract, name entry, results — all stay synchronous
- Camera interpolation mechanism — unchanged (re-DMA still runs)
- Slave SH2 rendering — unchanged
- V-INT handlers — unchanged
- Sound driver — unchanged
- All other COMM0 commands — unchanged

### Open Questions (Resolved)

| # | Question | Resolution |
|---|----------|-----------|
| U-006 | Does removing inline frame swap break first race frame? | **No** — V-INT $54 handles ALL frame swaps. The inline swap was an optimization (show render 1 TV frame earlier), not a requirement. Removing it means first render displays 1 TV frame later — imperceptible. |
| U-007 | Does camera_avg_and_redma depend on block copies? | **No** — it reads WRAM camera snapshots ($FF6080/$FF6090), not framebuffer data. Safe to run before copies. |
| U-008 | Data dependencies in reordered state4_epilogue? | **None** — camera avg reads WRAM, copies read SDRAM. Independent data sources. COMM0 is sequenced (camera re-DMA completes before cmd $3F triggers). |

---

## 9. File Reference

| File | Role |
|------|------|
| `disasm/sections/code_2200.asm:142-169` | state4_epilogue — code to modify |
| `disasm/sh2/expansion/cmd3f_vr60_gameframe.asm` | cmd $3F handler — add block copy loops |
| `disasm/sh2/expansion/cmd22_single_shot.asm` | cmd $22 block copy — algorithm to replicate in cmd $3F |
| `disasm/modules/68k/game/render/vdp_dma_frame_swap_037.asm:50-67` | V-INT $54 — the synchronization gate |
| `disasm/modules/68k/optimization/camera_interpolation_60fps.asm` | Camera interpolation — reorder candidate |
| `disasm/modules/68k/sh2/vr60_comm_trigger.asm` | cmd $3F trigger — already fire-and-forget |
| `disasm/modules/68k/game/render/mars_dma_xfer_vdp_fill.asm` | DREQ DMA — no idle check (protected by V-INT gate) |
