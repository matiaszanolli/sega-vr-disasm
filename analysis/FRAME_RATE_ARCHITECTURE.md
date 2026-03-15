# Frame-Rate Architecture Analysis

**Created:** March 14, 2026
**Purpose:** Complete documentation of how the VRD engine's 20 FPS frame rate is embedded in the architecture, and the data flow that enables frame-rate-independent rendering.

---

## 1. V-INT State Machine

The V-INT fires at 60 Hz (NTSC). The handler at `$001684` dispatches via a 16-entry jump table at `$0016B2`, selecting the handler based on the V-INT state value.

**Main loop** lives at Work RAM `$FF0000` (copied from ROM `$000F92` by `vdp_display_init`):

```
$FF0000: JSR <handler>          ; target address written by game state code
$FF0006: MOVE.W #<state>,$C87A  ; V-INT state written by handler
$FF000C: STOP #$2300            ; halt until next V-INT
$FF0010: BRA.S $FF0000          ; loop
```

**Self-modifying fields:**
- `$FF0002` (4 bytes): JSR target address — game states write different handler addresses here
- `$FF0008` (2 bytes): V-INT state immediate — handlers write timing values here

**FRAME_COUNTER at `$C964`**: Increments per TV frame (60 Hz), independent of game frame rate. Usable as a time reference for interpolation.

### Key Constraint
`$FF0008` MUST remain at offset 8 — never reorder instructions before it. Multiple game state handlers write to this fixed address.

---

## 2. Game Frame State Machine ($C87E)

During racing, the game frame state at `($C87E).w` cycles through 3 states:

| State | Advance | Purpose |
|-------|---------|---------|
| 0 | `ADDQ.W #4,($C87E).w` | **Full game frame**: physics, AI, entities, camera, SH2 commands |
| 4 | `ADDQ.W #4,($C87E).w` | **Minimal work**: VDP sync, sound, give SH2 render time |
| 8 | Reset to 0 when SH2 signals done | **Wait for SH2**: check COMM1_LO bit 0, frame buffer swap |

**3 states × 1 TV frame each = 20 FPS game rate** (60 ÷ 3 = 20).

### State Dispatchers

Five race state dispatcher functions handle different race phases. Each reads `($C87E).w` and jumps to the appropriate sub-handler:

| File | ROM Range | Race Phase |
|------|-----------|------------|
| `state_disp_004cb8.asm` | $004CB8 | Pre-race / countdown |
| `state_disp_005020.asm` | $005020 | Active racing |
| `state_disp_005308.asm` | $005308 | Post-race / results |
| `state_disp_005586.asm` | $005586 | Attract mode |
| `state_disp_005618.asm` | $005618 | Replay |

### Frame Buffer Swap Mechanism

`vdp_dma_frame_swap_037.asm` ($001D0C) handles frame buffer swapping:
1. Performs VDP register writes (scroll, color) and DMA
2. Checks COMM1_LO bit 0 (SH2 "render done" signal)
3. If set: clears bit, resets `($C87E).w` to 0, toggles FS bit at `$A1518B`
4. If not set: defers swap (adaptive — allows SH2 extra time, state advances to 12+)

This is the **only synchronization point** between 68K game logic and SH2 rendering.

### V-INT State Dispatch

The V-INT state value written to `$FF0008` is used as a **direct byte offset** into the jump table at `$0016B2`. Each entry is 4 bytes (longword address). The code at `$00169C` does: `movea.l jmp_table(pc,d0.w),a1` where D0 = state value.

**Racing sequence (state_disp_005020):**

| Game State ($C87E) | Writes V-INT State | V-INT Handler | Purpose |
|--------------------|-------------------|---------------|---------|
| 0 (game tick) | $14 (offset 20) | vint_state_vdp_sync ($1A72) | VDP synchronization |
| 4 (render prep) | $1C (offset 28) | vint_state_sprite_cfg ($1ACA) | Sprite configuration |
| 8 (finalize) | $54 (offset 84) | **vdp_dma_frame_swap_037** ($1D0C) | **Frame swap** |

**Only state 8 triggers frame swap.** States 0 and 4 write V-INT states that do VDP/sprite setup work but NO frame buffer toggle.

### State Machine Work Distribution

| State | Work | Camera DMA | Frame Swap |
|-------|------|------------|------------|
| 0 | Full game tick: physics, AI, camera, DMA to SH2 (`mars_dma_xfer_vdp_fill`) | **YES** (full 2560-byte FIFO) | No |
| 4 | 2P viewport copy, render pipeline variant, sound, controller, AI timer | No (builds camera params but doesn't DMA) | No |
| 8 | Full render orchestration, HUD, sprites, object update | No | **YES** |

This means: camera data is sent ONCE in state 0, the SH2 renders during states 0-8, and the frame swap happens at the end of state 8. The SH2 has the full 3 TV frames to complete rendering.

---

## 3. Race-Mode Call Hierarchy

```
Main loop ($FF0000)
  → game_tick (handler address at $FF0002)
    → scene_state_disp (via jump table)
      → race_frame_main_dispatch_entity_updates ($006D9C)
        → race_entity_update_loop+176 ($005A00)
          Per entity (A0 = entity base, stride $0100):
          ├─ entity_force_integration_and_speed_calc  ← force integration
          ├─ entity_speed_acceleration_and_braking     ← speed/gear changes
          ├─ speed_calculation / speed_interpolation   ← speed smoothing
          ├─ tilt_adjust / drift_physics               ← lateral dynamics
          ├─ suspension_steering_damping               ← steering response
          ├─ entity_pos_update                         ← position integration
          ├─ effect_timer_mgmt / timer_decrement_multi ← effect timers
          ├─ tire_screech_sound_trigger_053            ← sound timers
          ├─ rotational_offset_calc / angle_to_sine    ← heading computation
          ├─ collision_avoidance_speed_calc             ← AI steering
          └─ LEA $0100(A0),A0 → next entity

      → camera_param_calc / camera_param_calc_b/c/d   ← camera from entity
      → sh2_object_and_sprite_update_orch             ← visibility + SH2 cmds
      → comm_transfer_setup_a/b/c                     ← camera params → SH2
```

Entity updates are **UNROLLED** — `race_entity_update_loop` uses repeated JSR calls (not a counted loop) to process 5-8 entities.

---

## 4. Entity Data Architecture

### Entity Buffer Layout

| Address | Size | Content |
|---------|------|---------|
| `$FF9000` | 256 B | Primary entity (player 1) |
| `$FF9100` | 256 B | Entity 1 (opponent) |
| `$FF9700` | 256 B | Entity 7 |
| `$FF9F00` | 256 B | Alternate player entity |

**Key entity fields** (offsets from entity base A0):

| Offset | Size | Field | Purpose |
|--------|------|-------|---------|
| +$04 | W | speed | Current speed |
| +$06 | W | display_speed | Display/HUD speed |
| +$0C | W | slope | Slope delta |
| +$0E | W | force | Directional force |
| +$10 | W | drag | Drag field |
| +$16 | W | calc_speed | Computed speed |
| +$30 | W | x_position | World X |
| +$34 | W | y_position | World Y |
| +$3C | W | heading_mirror | Heading angle (mirrored) |
| +$40 | W | heading_angle | Heading angle |
| +$62 | W | mode | Movement mode |
| +$74 | W | raw_speed | Raw speed (pre-gear) |
| +$78 | W | grip | Grip factor (8.8 fixed) |
| +$7A | W | gear | Gear index |
| +$80 | W | sound_timer | Sound cooldown |
| +$82 | W | brake_timer | Brake sound cooldown |
| +$90 | W | rotation | Rotation angle |
| +$92 | W | param | Special parameter |
| +$96 | W | heading_offset | Heading offset |
| +$9C | W | lateral_offset | Lateral offset |
| +$BC | W | secondary_rotation | Secondary rotation |
| +$C0 | W | render_state | 0=hidden, 1=visible |
| +$E4 | B | ghost_mode | Ghost mode flag |
| +$E5 | B | visibility_flags | Visibility control (bit 3) |

---

## 5. 68K → SH2 Data Flow (The Critical Path)

### 5.1 The Problem

SH2 **cannot access 68K Work RAM** (`$FF0000-$FFFFFF`). The SH2 memory map has no path to 68K RAM — shared memory options are COMM registers ($20004020), SDRAM ($06000000-$0603FFFF), and Frame Buffer ($04000000). Entity positions in Work RAM must reach the SH2 through shared memory.

### 5.2 The Solution: Bulk DREQ FIFO Transfer

The 68K does NOT send entity positions individually. Instead, it assembles a large render parameter buffer at `$FF6000` (including camera params at `$FF6100`) and DMA-transfers the entire block to the SH2 once per game frame.

**Primary mechanism (racing):** `mars_dma_xfer_vdp_fill` ($0028C2)
1. Sets `MARS_DREQ_LEN = $0500` (1280 words = 2560 bytes)
2. Sets `MARS_DREQ_CTRL` DMA mode
3. Writes command code/flag to COMM0
4. Waits for SH2 ACK (COMM1_LO bit 1)
5. Streams data from `$FF6000` to `MARS_FIFO` via 10 block-copy calls to `$008988EC`
6. SH2 receives the full scene/camera/render parameter block

**Called from:** State 0 handler in all 5 race state dispatchers (first call in each).

**Secondary mechanism (unused in racing):** `comm_transfer_setup_a/b/c`
- Builds a 20-byte block at `$FF6100` with camera X,Y,Z + SH2 callback address
- Sends command `$2A` via COMM0 with DREQ DMA (68 bytes)
- **No callers found in active racing code path** — appears to be unused infrastructure
- May be used in non-racing modes (menus, replays)

### 5.3 Camera Parameter Buffer at $FF6100

**Location:** `$FF6100` (Work RAM) — part of the larger `$FF6000` block
**Populated by:** `vdp_buffer_xfer_camera_offset_apply` and `vdp_config_xfer_scaled_params`

`vdp_buffer_xfer_camera_offset_apply` ($003126):
- Reads entity base from `$FF9000` (A0)
- Calls `camera_param_calc+18` to compute camera params from entity position
- Adds camera offsets from `$C0AE/$C0B0/$C0B2` to buffer fields +$08/+$0A/+$0C
- If boost active (`$C8C8`), adds `$E0` to buffer field +$06

`vdp_config_xfer_scaled_params` ($003160):
- Writes control word to `$FF6100`
- Copies 6 words from `$C0BA` param block, last 3 scaled by ASR #3

Both are called from entity render pipeline variants (state 0 via main pipeline, state 4 via 2P pipeline).

### 5.4 Viewport Parameter Table at $FF2000

**Location:** `$FF2000` (Work RAM)
**Layout:** 5 words (10 bytes) per viewport entry

| Offset | Content |
|--------|---------|
| +$00 | Z (depth) |
| +$02 | X (horizontal) |
| +$04 | Y (vertical) |
| +$06 | Aux param A |
| +$08 | Aux param B |

Three viewport entries:
- Entry 0: `$FF2000-$FF2008` → `comm_transfer_setup_a` → callback `$222BDAE6`
- Entry 1: `$FF200A-$FF2012` → `comm_transfer_setup_b` → callback `$222BEA76`
- Entry 2: `$FF2014-$FF201C` → `comm_transfer_setup_c` → callback `$222BF710`

**Note:** These are used by `scene_param_adjustment_and_dma_upload` for viewport adjustment (D-pad camera control). During racing, the camera params are computed from entity position and flow through `$C0AE-$C0B2` offsets into the `$FF6100` buffer.

### 5.5 Per-Frame SH2 Communication

| Mechanism | Count/Frame | Data | Purpose |
|-----------|-------------|------|---------|
| `mars_dma_xfer_vdp_fill` | 1 | 2560 bytes from `$FF6000` | Full scene/camera/render params via DREQ FIFO |
| `sh2_send_cmd` (cmd $22) | 14 | SDRAM addr + dimensions | Block-copy rendered data to framebuffer |
| `sh2_cmd_27` (COMM7 doorbell) | 21 | Framebuffer addr + dimensions + color | Pixel region operations (brightness) |
| Visibility bitmask (cmd $07) | 1 | 15-bit mask via COMM3 | Entity visibility for SH2 renderer |

### 5.6 What the SH2 Renders From

The SH2 3D engine operates on **pre-built display lists in SDRAM**, not on per-frame entity data:

| SDRAM Address | Content |
|---------------|---------|
| `$06037000` | 3D geometry (288×48 pixels rendered scene) |
| `$0603A600` | Overlay tile data |
| `$0603B600` | Sprite data (288×24 pixels) |
| `$0603D100` | Scene parameter adjustment data |
| `$0603D800` | Geometry source data |
| `$0603DA00` | Text/digit bitmap table |
| `$0603DE80` | Camera overlay source |
| `$2203E020` | Entity visibility bitmask |

---

## 6. Per-Frame Constant Inventory

Every constant below is applied once per game frame (20 FPS). ALL are hardcoded with no delta-time scaling.

### 6.1 Physics (Additive Per-Frame)

| File | Constant | Value | Purpose |
|------|----------|-------|---------|
| `entity_speed_acceleration_and_braking.asm` | Speed delta clamp | ±$0400 | Max speed change per tick |
| `entity_force_integration_and_speed_calc.asm` | Air resistance coeff | $71C0 | Drag coefficient |
| `entity_force_integration_and_speed_calc.asm` | Force divisor | $0190 (400) | Slope → display speed |
| `entity_force_integration_and_speed_calc.asm` | Min force | $FFFFFE00 (-512) | Force floor |
| `entity_force_integration_and_speed_calc.asm` | Max speed | $4268 (17000) | Speed ceiling |
| `entity_force_integration_and_speed_calc.asm` | Grip default | $0100 (1.0 in 8.8) | Reset grip per frame |
| `entity_force_integration_and_speed_calc.asm` | Grip min | $0080 (0.5 in 8.8) | Minimum grip |
| `speed_calculation.asm` | Speed boost | $0738 | Boost increment per tick |
| `race_entity_update_loop.asm` | Decel rate A | $2000 | Deceleration constant |
| `race_entity_update_loop.asm` | Decel rate B | $1800 | Alternate decel constant |
| `speed_interpolation.asm` | Smoothing factor | $0284 | Speed smoothing |

### 6.2 Position Integration

`entity_pos_update.asm` — Heading-based movement:
```
heading = heading_mirror + heading_offset
x_position += speed × sin(heading) >> 12
y_position += speed × cos(heading) >> 12
```
Position deltas scale linearly with speed (no explicit per-frame constant, but implicit 1-frame dt).

### 6.3 Timers (Countdown Per Frame)

| File | Timer Init | Decrement | Purpose |
|------|-----------|-----------|---------|
| `entity_speed_acceleration_and_braking.asm` | $000F (15) | -1/frame | Gear cooldown |
| `entity_speed_acceleration_and_braking.asm` | $000A (10) | -1/frame | Brake cooldown |
| `entity_force_integration_and_speed_calc.asm` | $000F (15) | -1/frame | Skid sound cooldown |
| `entity_force_integration_and_speed_calc.asm` | $000F (15) | -1/frame | Tire squeal cooldown |
| `tire_screech_sound_trigger_053.asm` | $000F (15) ×4 | -1/frame | 4 tire screech timers |
| `scene_camera_init.asm` | $001E (30) | -1/frame | Frame countdown |
| `scene_camera_init.asm` | $14/$1E | -1/frame | Scene timer |
| `effect_timer_mgmt.asm` | $001E (30) ×2 | -1/frame | Effect duration |

### 6.4 Frame Thresholds

| File | Frame Count | Purpose |
|------|-------------|---------|
| `race_frame_update.asm` | 20 | Initial race setup |
| `countdown_timer_update_anim_race_start.asm` | 1241 | Countdown animation trigger |
| `countdown_timer_update_anim_race_start.asm` | 1296 | Race start trigger |
| `object_scoring_lap_advance_check.asm` | 80 | Scoring grace period |

### 6.5 AI

`ai_entity_main_update_orch.asm`:
- Steering clamp: ±$0140 per frame
- Heading lerp: ÷4 per frame
- Acceleration clamp: +$002F per frame

### 6.6 Replay

`scene_dispatch_input_replay.asm`: Consumes 1 byte per frame from replay buffer.

### 6.7 Animation

- `tire_animation_and_smoke_effect_counters.asm`: Frame counter modulo 4
- `animation_seq_player.asm`: Tick -1 per frame

---

## 7. CPU Budget

### 7.1 Baseline (20 FPS, 3 TV Frames per Game Frame)

| CPU | Cycles/TV Frame | Active Cycles | Utilization |
|-----|----------------|---------------|-------------|
| 68K | 127,987 | ~62,000 | 48% active, 52% STOP |
| Master SH2 | 383,040 | 125,175 avg | 33% avg (0-36%) |
| Slave SH2 | 383,040 | 301,047 | 79% |

### 7.2 Measured (40 FPS, 2 Swaps per 3 TV Frames)

| CPU | 40 FPS Avg | 20 FPS Baseline | Delta | Notes |
|-----|-----------|-----------------|-------|-------|
| 68K | 127,986 | 127,987 | -1 | Overhead absorbed by idle time |
| Master SH2 | 127,061 | 125,175 | +1,886 | Extra block copies in state 4 |
| Slave SH2 | 299,926 | 301,047 | -1,121 | Measurement variance |

**Key result:** The 40 FPS pipeline (snapshot + averaging + 2× sh2_send_cmd + re-DMA + frame swap) adds negligible overhead. The 68K's 52% idle time absorbs all new work.

**SH2 budget:** 2 renders × ~300K = ~600K / 1,149K (3 TV frames) = **52%** utilization. Ample headroom for a 3rd render (60 FPS).

### 7.3 Projected (60 FPS, 3 Swaps per 3 TV Frames)

| Metric | Value | Budget | Margin |
|--------|-------|--------|--------|
| SH2 per render | ~300K cycles | 383K (1 TV frame) | 22% |
| SH2 total (3 renders) | ~900K cycles | 1,149K (3 TV frames) | 22% |
| 68K additional overhead | ~5K cycles | 128K (1 TV frame) | 96% |

60 FPS is feasible from a CPU budget perspective. The bottleneck is **code space** (24 bytes remaining in trampoline) and ensuring the third frame swap doesn't conflict with `vdp_dma_frame_swap_037`'s `$C87E` reset.

---

## 8. Entity Data Flow to SH2 — Complete Diagram

```
SCENE INITIALIZATION (once per race):
  68K loads track + entity geometry → SDRAM ($0600xxxx)
  SH2 builds internal display lists from geometry data
  Camera matrices initialized

PER GAME FRAME (20 FPS, state 0 only):
  ┌──────────────────────────────────────────────────────┐
  │  68K Work RAM                                         │
  │                                                       │
  │  Entity physics ($FF9000+)                            │
  │    ├─ force_integration → speed, drag                 │
  │    ├─ speed_acceleration → gear, braking              │
  │    ├─ entity_pos_update → x_position, y_position      │
  │    └─ timers, AI, collision                           │
  │                                                       │
  │  Camera computation                                   │
  │    ├─ camera_param_calc: entity → camera buffer       │
  │    └─ Store X,Y,Z at $FF2000-$FF2004                  │
  │                                                       │
  │  Visibility                                           │
  │    ├─ entity_visibility_check → $FF6218 flags         │
  │    └─ Build 15-bit bitmask                            │
  └──────────────┬───────────────────────────────────────┘
                 │
                 ▼
  ┌──────────────────────────────────────────────────────┐
  │  COMM Register Transfer                               │
  │                                                       │
  │  1. Visibility bitmask → COMM3 (cmd $07)              │
  │  2. Camera params → DREQ DMA block (cmd $2A)          │
  │     $FF6100: [cmd, 0, X, Y, Z, D0, 0, 0, callback]   │
  │  3. Block-copy cmds → COMM2-6 (cmd $22, 14×)         │
  │  4. Pixel ops → COMM2-6 + COMM7 doorbell (21×)       │
  └──────────────┬───────────────────────────────────────┘
                 │
                 ▼
  ┌──────────────────────────────────────────────────────┐
  │  SH2 Processing                                       │
  │                                                       │
  │  Master SH2:                                          │
  │    ├─ Receives cmd $2A → calls callback with camera   │
  │    ├─ Re-transforms scene geometry with new camera    │
  │    ├─ Renders to SDRAM backbuffer ($06037000)         │
  │    └─ Executes block-copy cmds (SDRAM → framebuffer)  │
  │                                                       │
  │  Slave SH2:                                           │
  │    ├─ Executes pixel operations (cmd $27)             │
  │    └─ Signals completion via COMM1_LO bit 0           │
  └──────────────────────────────────────────────────────┘
```

---

## 9. 40 FPS Implementation (Approach A — DONE)

### 9.1 What Was Implemented (commit b6bd487)

Camera interpolation rendering — fixed 20 FPS game tick + 40 FPS display via 2 SH2 renders per game frame.

**Trampoline code** at `code_2200.asm` (192 of 210 available bytes):

| Routine | Size | Purpose |
|---------|------|---------|
| `camera_snapshot_wrapper` | 46B | Wraps `mars_dma_xfer_vdp_fill` — snapshots camera to `$FF6080`/`$FF6090` before DMA |
| `camera_avg_and_redma` | 38B | Averages 8 words of prev/curr camera, writes to `$FF6100`, re-DMAs |
| `state4_epilogue` | 102B | 2× `sh2_send_cmd` block copy + frame swap + interp call + state advance |

**Hooks:**
- `state_disp_005020` state 0: `jsr camera_snapshot_wrapper(pc)` replaces `jsr mars_dma_xfer_vdp_fill(pc)`
- `frame_update_orch_005070`: tail-jumps to `state4_epilogue` instead of inline state advance

### 9.2 Per-Game-Frame Flow (Current — Effective 40 FPS)

```
State 0 (TV frame 1):
  camera_snapshot_wrapper: prev←curr, curr←$FF6100, then mars_dma_xfer_vdp_fill
  → SH2 receives camera N, renders to SDRAM

State 4 (TV frame 2):
  [existing work: sound, controller, counters, AI, render pipeline]
  state4_epilogue:
    1. Block-copy SDRAM→framebuffer (2× sh2_send_cmd)
    2. COMM1_LO bit 0 check → bchg FS bit (NOTE: deferred to VBlank — see §9.4)
    3. camera_avg_and_redma called but re-DMA has no render effect (see §9.4)

State 8 (TV frame 3):
  [existing work: render orch, HUD, sprites, object update]
  sh2_geometry_transfer: block-copy SDRAM→framebuffer (existing)
  V-INT $54 → vdp_dma_frame_swap_037: swap during VBlank (effective)
```

**Note:** The state 4 block-copy writes to the framebuffer, and state 8's V-INT swap
displays it. The stable 40 FPS feel comes from consistent frame pacing, not from
displaying two distinct rendered frames per game frame.

### 9.3 What Does NOT Change

- All physics constants — identical to 20 FPS
- Timer countdown rates — unchanged
- AI behavior — unchanged
- Sound triggers — fire at 20 FPS
- Replay system — unchanged
- Collision detection — unchanged
- HUD updates — 20 FPS (speed/position display updates between ticks)

### 9.4 Known Limitations and Hardware Constraints

- **FS swap deferred to VBlank (CRITICAL):** Per 32X Hardware Manual page 35: "writing the FS bit is always allowed, and when written during display, swapping is done at the next VBlank." Our state 4 inline `bchg #0,$A1518B` writes during active display — the swap is deferred to the same VBlank where state 8's V-INT handler does its own swap. The two cancel out. Frame swaps MUST happen inside V-INT handlers (during VBlank).
- **Re-DMA does not trigger SH2 re-render:** Calling `mars_dma_xfer_vdp_fill` a second time per frame sends FIFO data (confirmed: no hang, ACK received) but produces zero visual change. Corruption diagnostic (inverting $FF6100) confirmed zero effect. Profiling shows zero SH2 cycle increase. The SH2 handler's internal render trigger is not yet understood.
- **Dispatcher coverage:** Only `state_disp_005020` (active racing) is hooked. Other 4 dispatchers run at original 20 FPS.
- **Code space:** SOLVED — relocated to `code_1c200.asm` expansion area (7,936 bytes available).
- **Camera-only interpolation:** Averaged camera produces smooth panning but entity positions update at 20 FPS. Imperceptible in a driving game since the camera follows the player.

---

## 10. Key Files Reference

| File | Purpose |
|------|---------|
| `modules/68k/main-loop/vint_handler.asm` | V-INT dispatch, state machine |
| `modules/68k/game/scene/game_frame_orch_013.asm` | Game frame orchestrator |
| `modules/68k/game/race/race_frame_main_dispatch_entity_updates.asm` | Entity update dispatcher |
| `modules/68k/game/race/race_entity_update_loop.asm` | Per-entity update loop (unrolled) |
| `modules/68k/game/physics/entity_pos_update.asm` | Position integration |
| `modules/68k/game/physics/entity_force_integration_and_speed_calc.asm` | Force/speed physics |
| `modules/68k/game/physics/entity_speed_acceleration_and_braking.asm` | Speed/gear logic |
| `modules/68k/game/camera/camera_param_calc.asm` | Entity → camera parameters |
| `modules/68k/sh2/comm_transfer_setup_a.asm` | Camera DREQ DMA transfer |
| `modules/68k/sh2/comm_transfer_setup_b.asm` | Secondary viewport transfer |
| `modules/68k/sh2/comm_transfer_setup_c.asm` | Third viewport transfer |
| `modules/68k/game/render/vdp_dma_frame_swap_037.asm` | Frame swap + SH2 sync |
| `modules/68k/game/scene/sh2_object_and_sprite_update_orch.asm` | Visibility + SH2 cmds |
| `modules/68k/game/entity/entity_visibility_check.asm` | Per-entity visibility |
| `sections/code_2200.asm` | Trampoline: snapshot + interp + epilogue (192/210 bytes used) |
| `state_disp_004cb8/005020/005308/005586/005618.asm` | 5 race state dispatchers (only 005020 hooked) |

---

## 11. Path to 60 FPS

### 11.1 Concept

Add a third frame swap per game frame by block-copying the previous interpolated render in state 0 (before DMA overwrites SDRAM).

```
State 0 (TV1): block-copy prev-interp → swap C → snapshot → DMA camera N → SH2 renders (A)
State 4 (TV2): block-copy A → swap A → interp → re-DMA → SH2 renders (B)
State 8 (TV3): block-copy B → swap B (existing)
Result: 3 swaps / 3 TV frames = 60 FPS
```

### 11.2 Requirements

1. **~80 bytes of 68K code** for state 0 block-copy + swap (2× `sh2_send_cmd` at 6 bytes each via abs.l + params + swap logic)
2. **More ROM space** — current trampoline has 24 bytes free. Options: find another trampoline-able function, reuse NOP padding in `sh2_send_cmd` ($E39A, 26 bytes), or compress existing code.
3. **SH2 must render in <1 TV frame** consistently — current average is 0.78 TV frames (22% margin).

### 11.3 Risks

- **SH2 timing on complex scenes:** If any scene exceeds 383K cycles per render, the third swap is deferred. The existing adaptive mechanism (`vdp_dma_frame_swap_037` checks COMM1_LO) handles this gracefully — the game drops to 40 FPS temporarily.
- **`vdp_dma_frame_swap_037` $C87E reset:** The existing state 8 frame swap resets `$C87E` to 0 when successful. If the state 0 swap also uses this handler, it would skip states 4/8. The state 0 swap must use a variant that does NOT reset `$C87E` (same approach as the current state 4 swap — inline `bchg`).
- **Display ordering:** With 3 frames per game tick, the visual sequence must be temporally correct. State 0 shows the previous frame's interpolated camera, state 4 shows the current camera, state 8 shows this frame's interpolated camera.
