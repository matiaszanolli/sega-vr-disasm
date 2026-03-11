# Frame Dependency Analysis — Track C Pipeline Overlap

**Purpose:** Map all game state that flows from "game logic" to "render submission" within a single frame, determining what needs double-buffering for pipeline overlap.

---

## 1. The Main Loop (Critical Discovery)

The main game loop is NOT at a fixed ROM address — it's **copied to Work RAM $FF0000** during VDP initialization at ROM `$000F92`:

```asm
; vdp_display_init ($000FC4) copies 24 bytes from $000F92 to $FF0000:
.normal_dispatch_loop:     ; → $FF0000
    JSR  $00894262          ; 6B — call game tick handler (self-modifying target at $FF0002)
    MOVE.W #$0004,$C87A.W   ; 6B — request V-INT state 1 (VDP common sync)
    MOVE #$2300,SR          ; 4B — enable V-INT (level 6 > level 3 in SR)
.wait_frame:               ; → $FF0010
    TST.W $C87A.W           ; 4B — V-INT cleared flag?
    BNE.S .wait_frame       ; 2B — no → spin
    BRA.S .normal_dispatch_loop ; 2B — yes → next game frame
```

**THIS spin at $FF0010—$FF0014 is where ~32% of race-mode CPU time and ~49% of total CPU time goes.**

The M0 STOP optimization only affects `wait_for_vblank` ($004998), which is called during scene init/transitions. The main loop spin at $FF0000 runs every frame during racing and was not modified by M0.

### Self-Modifying JSR Target

The main loop's JSR target at $FF0002 is overwritten by game state handlers:
```asm
; Example from game_logic_init_state_dispatch:
move.l  #$0088FB98,$00FF0002    ; change handler to different game state
```

Each game state (menu, race, results, etc.) installs its own handler address at $FF0002. The main loop repeatedly calls whatever handler is installed, then spins for V-blank.

---

## 2. Frame Timing Budget (Race Mode)

| Component | Cycles | % of Frame |
|-----------|--------|-----------|
| Game handler (logic + render submission) | ~260,000 | ~68% of 384K |
| Main loop V-blank spin | ~124,000 | ~32% of 384K |
| **Total per game frame** | **~384,000** | **3 TV frames = 20 FPS** |

For NTSC 30 FPS: handler ≤ 256,000 cycles (2 TV frames) — need to save ~4K
For PAL 25 FPS: handler ≤ 306,000 cycles (2 TV frames) — **already fits** (46K margin)
For PAL 50 FPS: handler ≤ 153,000 cycles (1 TV frame) — need to save ~107K (41%)
For NTSC 60 FPS: handler ≤ 128,000 cycles (1 TV frame) — need to save ~132K (51%)

---

## 3. V-INT State Machine During Racing

The V-INT handler ($001684) dispatches based on `$C87A`:

| From | Sets $C87A to | V-INT Handler | Purpose |
|------|---------------|---------------|---------|
| Main loop | $0004 (state 1) | `vint_state_common` ($001A64) | VDP sync, Work RAM ops |
| Game handler | $0018 (state 6) | `vint_state_fb_toggle` ($001C66) | **Frame buffer swap** |
| Various | $002C (state 11) | `vint_state_transition` | State transitions |

### Frame Buffer Swap Protocol

`vint_state_fb_toggle` ($001C66) performs:
1. Read VDP status (acknowledge V-INT)
2. Scroll position DMA to VDP
3. Palette DMA to CRAM (256 bytes)
4. Check COMM1_LO bit 0 (SH2 "rendering done" signal)
5. If set: clear COMM1_LO bit 0, toggle `$C80C` flag, flip adapter FS bit at `$A1518B`
6. If not set: skip flip (graceful — SH2 still rendering)

**Safety:** The FB swap only occurs when the SH2 signals completion via COMM1_LO. This prevents swapping while SH2 is still writing to the back buffer.

---

## 4. Data Flow: Game Logic → Render Submission

### Entity State (Work RAM $FF9000+)

All entity data lives in Work RAM. SH2 **cannot** access Work RAM.

| Phase | Operations | Work RAM Fields Modified |
|-------|-----------|------------------------|
| **Physics** | `entity_force_integration_and_speed_calc`, `entity_pos_update`, `position_velocity_update` | +$06 (speed), +$18 (position), +$30/$34 (x/y) |
| **AI/Steering** | `ai_opponent_select`, `steering_input_processing_and_velocity_update` | +$1E (direction), +$3C (steering), +$40 (heading) |
| **Collision** | `directional_collision_probe`, `collision_response_surface_tracking` | +$55 (collision_flag), +$C6/$C8 (surface) |
| **Depth Sort** | `depth_sort` ($009DD6) | sorted entity array in Work RAM |
| **Render Prep** | `sh2_graphics_cmd` ×14, visibility culling | +$44/$46/$4A (display params) |
| **Render Submit** | `sh2_send_cmd` ×14, `sh2_cmd_27` ×21 | Nothing — reads Work RAM, writes to COMM regs |

### What Render Submission Reads

The render submission phase reads entity state from Work RAM and converts it to COMM register parameters:
- `sh2_send_cmd`: A0 = source ptr (SDRAM $06xxxx), A1 = dest ptr (FB $04xxxx), D0 = width, D1 = height
- `sh2_cmd_27`: A0 = data ptr (FB $04xxxx), D0 = width, D1 = height, D2 = add value

**Critical insight:** SH2 receives ALL data via COMM registers — it never reads Work RAM. Once COMM parameters are written and acknowledged, the SH2 operates on SDRAM and framebuffer DRAM independently.

### Camera State

Camera parameters at Work RAM $C000-$C0FF:
- Set once during scene init (`scene_camera_init` $00CC74)
- No per-frame SH2 camera update during racing
- Camera params affect render prep (display offset/scale) but are consumed by the 68K, not the SH2

### Frame Buffer Selection

The adapter control register FS bit ($A1518B bit 0) determines which 128KB bank is "back" (draw target):
- SH2 always writes to $04000000 / $24000000, which maps to the current back buffer
- V-INT toggles FS → swaps displayed/drawable banks
- Game handler doesn't need to know which physical bank is active

---

## 5. Double-Buffering Requirements

### What Does NOT Need Double-Buffering

| State | Why |
|-------|-----|
| Entity positions in Work RAM | SH2 never reads Work RAM — only COMM registers |
| COMM register parameters | Consumed immediately by SH2, overwritten each call |
| Camera state | Read by 68K only, not sent per-frame to SH2 |
| Depth sort output | Produced and consumed by 68K within same frame |
| Frame buffer pixels | Already double-buffered by hardware (FS bit toggle) |

### What Potentially Needs Double-Buffering for Pipeline Overlap

| State | Issue | Mitigation |
|-------|-------|-----------|
| Entity positions during render | Frame N+1 game logic writes positions that render N still references | Render N already consumed all COMM params before returning — no conflict |
| SH2 "done" signal (COMM1_LO) | Must not swap FB while SH2 still rendering | V-INT already checks COMM1_LO — existing safety mechanism |
| Display params (+$44/+$46/+$4A) | Written to 0 at start of render prep, then set | Only read by same frame's render submission — no cross-frame dependency |

**Conclusion: NO explicit double-buffering of Work RAM is needed.** The existing architecture already isolates 68K Work RAM from SH2 access. COMM parameters are consumed synchronously. The hardware FB double-buffer handles pixel data.

---

## 6. Pipeline Overlap Design

### Current Frame Flow
```
[Game Logic N: 218K cycles] [Render Submit N: 42K cycles] [SPIN: ~124K cycles]
|<------------- game handler (~260K) ------------>|<--- wait for V-INT --->|
|<--------------------------- 3 TV frames = 384K cycles (20 FPS) -------->|
```

### Target: Eliminate Main Loop Spin
```
[Game Logic N: 218K] [Render N: 42K] [Game Logic N+1: 218K] [Render N+1: 42K] ...
                                     ^ V-INT fires here,    ^ must wait for FB swap
                                       does FB swap           if not already done
|<--- game frame N: 260K cycles --->|
                                    2.03 TV frames → 30 FPS (NTSC) / 25 FPS (PAL)
```

### Implementation: Modified Main Loop

Replace the main loop code at ROM $000F92 (copied to $FF0000):

**Phase 1 (STOP — immediate, conservative):**
```asm
.normal_dispatch_loop:
    JSR  $00894262          ; call game tick handler
    MOVE.W #$0004,$C87A.W   ; request V-INT state 1
    STOP #$2300             ; halt until V-INT (frees bus for SH2)
    NOP                     ; padding
    NOP                     ; padding
    NOP                     ; padding
    BRA.S .normal_dispatch_loop
```
Same FPS, but STOP frees the bus during idle. 24 bytes, same size as original.

**Phase 2 (Pipeline overlap — requires handler restructuring):**
Separate game logic from render submission so game logic N+1 can overlap with V-blank wait:
```asm
.pipeline_loop:
    JSR  game_logic_handler  ; game logic only (no SH2 commands)
    ; V-INT should have fired during game_logic and done FB swap
    ; If not, wait for it now (minimal spin)
    TST.W  $C87A.W
    BEQ.S  .swap_done
.wait_swap:
    STOP  #$2300
.swap_done:
    JSR  render_submit_handler ; render submission (sh2_send_cmd + sh2_cmd_27)
    MOVE.W #$0018,$C87A.W   ; request FB swap for next V-INT
    MOVE  #$2300,SR          ; enable V-INT
    BRA.S  .pipeline_loop
```

---

## 7. FPS Targets and Path

| Target | Requirement | Changes Needed |
|--------|-------------|----------------|
| 30 FPS NTSC | Handler ≤ 256K cycles | Save 4K cycles + STOP in main loop |
| 25 FPS PAL | Handler ≤ 306K cycles | STOP in main loop only (fits already) |
| 50 FPS PAL | Handler ≤ 153K cycles | Pipeline overlap + 41% SH2 offload |
| 60 FPS NTSC | Handler ≤ 128K cycles | Pipeline overlap + 51% SH2 offload |

### Immediate Path: 30 FPS NTSC
1. Apply STOP to main loop at $000F92 (frees bus, prepares infrastructure)
2. Save 4K cycles from game handler (one small optimization candidate)
3. Result: 2 TV frames per game frame = 30 FPS

### Ambitious Path: 50 FPS PAL
1. All of the above
2. Separate game logic from render submission in handler
3. Pipeline overlap (game logic N+1 during V-blank wait)
4. SH2 offload: angle_normalize batch, trig lookup, physics (~30% of useful work)
5. Result: 1 PAL TV frame per game frame = 50 FPS
