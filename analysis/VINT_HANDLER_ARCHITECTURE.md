# V-INT Handler Architecture

> **Current-scope correction (2026-07-21):** A swap-only V-INT mechanism is not the sole
> remaining step to true 60 FPS. Older “active racing” references to
> `state_disp_005020` are 2P-specific; normal 1P uses `state_disp_004cb8`. Current work is
> blocked first on a durable baseline and staged SH2/data-ownership integration. See
> `../VR60_STATUS.md`.

**Created:** 2026-03-16
**Purpose:** Complete reference for the Vertical Interrupt dispatch system — state table, frame swap mechanism, and R-002 design notes for 60 FPS.

---

## 1. V-INT Entry Point

**Vector:** `$000078` → `$001684` (`vint_handler`)
**Frequency:** Every VBlank (~60 Hz NTSC, ~16.7ms)

**Dispatch flow** (`vint_handler.asm:87-98`):
1. `TST.W $C87A` — if zero (no work), RTE immediately
2. `MOVE #$2700,SR` — disable interrupts
3. Save all registers (D0-D7/A0-A6)
4. `MOVE.W $C87A,D0` — read state value
5. `MOVE.W #0,$C87A` — clear state (acknowledge)
6. `MOVEA.L jmp_table(pc,d0.w),A1` — index jump table by D0
7. `JSR (A1)` — call state handler
8. `ADDQ.L #1,$C964` — increment frame counter
9. Restore registers, `MOVE #$2300,SR`, RTE

**Key detail:** `$C87A` is cleared BEFORE dispatching. The main loop writes `$C87A` from `$FF0008` (self-modifying code), then STOPs. V-INT fires, reads `$C87A`, clears it, dispatches. The main loop's `TST.W $C87A / BNE.S` loop catches spurious wakes (H-INT).

---

## 2. Jump Table ($0016B2)

State values are **direct byte offsets** into the table (not sequential indices). Each entry is 4 bytes (longword address). Active states are multiples of 4.

| State | Table Offset | Handler Address | ROM Offset | Name | Purpose |
|-------|-------------|-----------------|-----------|------|---------|
| $0000 | $0016B2 | $008819FE | $0019FE | vint_state_common | VDP sync + work RAM |
| $0004 | $0016B6 | $008819FE | $0019FE | (same) | |
| $0008 | $0016BA | $008819FE | $0019FE | (same) | |
| $000C | $0016BE | $00018200 | — | **INVALID** (odd addr) | Unused gap |
| $0010 | $0016C2 | $00881A6E | $001A6E | vint_state_minimal | Quick VDP status read only |
| $0014 | $0016C6 | $00881A72 | $001A72 | vint_state_vdp_sync | VDP sync + Z-Bus |
| $0018 | $0016CA | $00881C66 | $001C66 | vint_state_fb_toggle | Frame buffer toggle (palette xfer) |
| $001C | $0016CE | $00881ACA | $001ACA | vint_state_sprite_cfg | Sprite configuration |
| $0020 | $0016D2 | $008819FE | $0019FE | vint_state_common | (same as $0000) |
| $0024 | $0016D6 | $00881E42 | $001E42 | vint_state_fb_setup | Frame buffer setup |
| $0028 | $0016DA | $00881B14 | $001B14 | vint_state_vdp_config | VDP configuration |
| $002C | $0016DE | $00881A64 | $001A64 | vint_state_transition | State transition handler |
| $0030 | $0016E2 | $00881BA8 | $001BA8 | vint_state_complex | Complex VDP ops |
| $0034 | $0016E6 | $00881E94 | $001E94 | vint_state_fb_palette | FB + palette update |
| $0038 | $0016EA | $00881F4A | $001F4A | vint_state_fb_dma | Scroll + frame swap DMA |
| $003C | $0016EE | $00882010 | $002010 | vint_state_cleanup | SH2 flag cleanup |
| $0040 | $0016F2 | $00000001 | — | **PAD** | Gap |
| $0044 | $0016F6 | $00881DBE | $001DBE | vint_state_ctrl_poll | Controller poll + sprites |
| $0048 | $0016FA | $00000001 | — | **PAD** | Gap |
| $004C | $0016FE | $00000001 | — | **PAD** | Gap |
| $0050 | $001702 | $00000001 | — | **PAD** | Gap |
| $0054 | $001706 | $00881D0C | $001D0C | **vdp_dma_frame_swap_037** | **Race mode: DMA + COMM1 check + frame swap** |

---

## 3. V-INT States Used by Game Modes

From `$FF0008` writes across all modules:

| V-INT State | Written By | Game Phase | Handler |
|------------|-----------|------------|---------|
| $0010 | state_disp_004cb8, 005308, 005586, 005618 (state 0) | Normal 1P, results, Free Run/TT, replay | Minimal VDP read |
| $0014 | state_disp_005020 (state 0) | **2P split-screen** | VDP sync + Z-Bus |
| $0018 | Multiple menu handlers | Menu/name entry | FB toggle (palette xfer) |
| $001C | camera_interpolation_60fps (WIP) | Camera interp state 4 | Sprite config |
| $0020 | state_disp_00573c (sub-state 0), sh2_handler_dispatch, palette handlers | Scene transitions, init | Common VDP sync |
| $002C | time_trial_records_display_init, name_entry_screen_init | Post-race displays | State transition |
| $0034 | scene_phase_timer_setup | Scene phase | FB + palette |
| $0038 | scene_orch | Scene orchestration | FB DMA |
| $003C | scene_phase_timer_reset | Scene reset | SH2 cleanup |
| $0044 | state_disp_ctrl_poll_sprite_update | Pause, loading phases | Controller poll |
| $0054 | game_frame_orch_013 (state 8 of racing) | **Full game frame** | **DMA + frame swap** |

---

## 4. Frame Swap Mechanism (State $0054)

**Handler:** `vdp_dma_frame_swap_037` at ROM $001D0C (178 bytes)

**Sequence** (`vdp_dma_frame_swap_037.asm:23-68`):

```
1. VDP scroll/color writes
   - Write scroll_h ($8000) and scroll_v ($8002) to VDP
   - Write color_a ($C880) and color_b ($C882) to VDP

2. Z80 bus request + VDP DMA
   - Request Z80 bus, wait grant
   - DMA 64 words from ROM to CRAM $0000 (palette)
   - Release Z80 bus

3. Check SH2 "render done" signal
   - BTST #0,COMM1_LO
   - If NOT set → .exit (no swap this frame)

4. If set (SH2 done rendering):
   a. BCLR #0,COMM1_LO           ; acknowledge handshake
   b. MOVE.W #$0000,$C87E         ; reset game state to 0
   c. BCLR #7,MARS_SYS_INTCTL     ; clear CMD INT
   d. Poll $A1518A bit 7 until clear (CMD INT acknowledged)
   e. BCHG #0,$C80C              ; toggle frame_toggle flag
   f. If $C80C now 0: BSET #0,$A1518B  (FS=1 → display buffer 0)
      If $C80C now 1: BCLR #0,$A1518B  (FS=0 → display buffer 1)
   g. BSET #7,MARS_SYS_INTCTL    ; re-enable CMD INT

5. RTS
```

**Key behaviors:**
- **COMM1_LO bit 0** is a "render done" signal set by SH2 completion handlers (`$060043FC`)
- **$C87E reset to 0** is what causes the race state machine to cycle back to state 0
- **CMD INT management** prevents SH2 from issuing new commands during the swap
- **FS bit** at `$A1518B` bit 0 controls which DRAM frame buffer the adapter displays
- **$C80C** is a RAM toggle flag that tracks which buffer is "front" (alternates each frame)

### Other Handlers with Frame Swap

| Handler | ROM | State | Frame swap? | Extra work |
|---------|-----|-------|------------|------------|
| vdp_dma_frame_swap_037 | $001D0C | $0054 | ✅ COMM1 + FS toggle | Scroll, palette DMA |
| vdp_dma_palette_xfer_036 | $001C66 | $0018 | ✅ COMM1 + FS toggle | Palette transfer |
| vdp_dma_scroll_frame_swap | $001F4A | $0038 | ✅ COMM1 + FS toggle | Scroll + palette DMA |
| vdp_dma_cram_xfer | $001E94 | $0034 | ✅ COMM1 + FS toggle | CRAM transfer |

All follow the same pattern: check COMM1_LO bit 0 → reset $C87E → toggle $C80C → set/clear FS.

---

## 5. V-INT State vs Game State ($C87E)

These are **two separate state machines**:

| Variable | Location | Written by | Cleared by | Purpose |
|----------|----------|-----------|------------|---------|
| V-INT state | $C87A (via $FF0008) | Main loop self-mod | V-INT handler (immediately) | Selects which V-INT handler runs |
| Game state | $C87E | State dispatchers (ADDQ #4) | V-INT frame swap (reset to 0) | Selects which game logic runs per frame |

**Historical 2P `state_disp_005020` cycle:**
```
State 0 ($C87E=0):  DMA + sound → V-INT $0014 (minimal)  → $C87E = 4
State 4 ($C87E=4):  Game logic  → V-INT $0014 (minimal)  → $C87E = 8
State 8 ($C87E=8):  Full frame  → V-INT $0054 (frame swap) → if COMM1: $C87E = 0
                                                            → if !COMM1: $C87E = 12+
```

Normal 1P uses `state_disp_004cb8` and was observed cycling V-INT values
`$0010/$0010/$0054`; see `VR60_DISPATCHER_ROUTING.md` for its exact state handlers.

---

## 6. Historical R-002 Design Notes (Swap-Only V-INT Handler)

> This mechanism may remain useful, but it is not the current blocker or a complete 60 FPS
> plan. It was designed around the historical 2P interpolation path. Complete the validation,
> SH2 integration, render bridge, ownership, and cadence prerequisites in `../VR60_STATUS.md`
> before revisiting it.

**Goal:** Toggle FS every TV frame to display 3 unique rendered frames per game frame = 60 FPS.

**Current constraint:** FS writes outside VBlank are deferred to next VBlank (hardware manual page 35). The existing frame swap code runs inside V-INT (during VBlank), so FS takes effect immediately.

**What a swap-only handler needs:**
1. Toggle `$C80C` flag
2. Set/clear `$A1518B` bit 0 based on `$C80C`
3. **Do NOT** check COMM1_LO (no SH2 dependency for intermediate swaps)
4. **Do NOT** reset `$C87E` (game state must continue advancing)
5. **Do NOT** do VDP DMA, scroll, palette, Z80 bus work
6. **Do** manage CMD INT (bclr/bset bit 7 of MARS_SYS_INTCTL)

**Estimated size:** ~30-40 bytes

**Available table slots:** States $0040, $0048, $004C, $0050 all point to `$00000001` (pad). Any of these could be repurposed for the swap-only handler by:
1. Writing the handler code to an available ROM location
2. Patching the jump table entry to point to it

**Integration with camera interpolation:**
- State 0: `camera_snapshot_wrapper` → V-INT $0010 (minimal, let SH2 render)
- State 4: `state4_epilogue` → V-INT **$0040** (swap-only, display render A)
- State 8: `game_frame_orch` → V-INT $0054 (full swap + $C87E reset + render B displayed)

This gives 3 FS swaps per game frame (state 0 → state 4 → state 8), displaying 3 unique frames = 60 FPS.

---

## 7. Key Files

| File | Purpose |
|------|---------|
| `disasm/modules/68k/main-loop/vint_handler.asm` | V-INT entry + jump table |
| `disasm/modules/68k/game/render/vdp_dma_frame_swap_037.asm` | State $0054 (race frame swap) |
| `disasm/modules/68k/game/render/vdp_dma_palette_xfer_036.asm` | State $0018 (palette + swap) |
| `disasm/modules/68k/game/render/vdp_dma_scroll_frame_swap.asm` | State $0038 (scroll + swap) |
| `disasm/modules/68k/vint/vint_handlers.asm` | State $003C (cleanup) |
| `disasm/modules/68k/game/scene/game_frame_orch_013.asm` | Writes $0054 to $FF0008 |
| `disasm/modules/68k/game/state/state_disp_005020.asm` | Writes $0014 to $FF0008 |
