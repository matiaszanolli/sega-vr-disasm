# Game Mode Transition Architecture

**Created:** 2026-03-16
**Purpose:** Document how the game switches between modes (boot, logos, menus, attract, racing, results, replay) and what state variables control each transition. Required for safely extending camera interpolation to non-racing modes.

---

## 1. Two-Level Dispatch System

### Level 1: Main Loop ($FF0000)

The main loop at Work RAM `$FF0000` executes once per TV frame (60 Hz):

```
$FF0000: JSR <handler>          ; self-modifying: address at $FF0002
$FF0006: MOVE.W #<state>,$C87A  ; self-modifying: value at $FF0008
$FF000C: STOP #$2300            ; halt until V-INT
$FF0010: TST.W $C87A / BNE.S   ; wait for V-INT to clear $C87A
$FF0016: BRA.S $FF0000
```

**$FF0002** (4 bytes) = the **scene handler pointer**. This is the master control — changing it changes the game mode entirely.

**$FF0008** (2 bytes) = the **V-INT state**. This controls which V-INT handler runs during the next VBlank.

### Level 2: Scene Dispatchers

Within each scene handler, a sub-dispatcher reads `($C87E).w` (game state) and indexes a jump table to select the appropriate state handler. The 5 race sub-dispatchers are:

| Dispatcher | ROM Range | Race Phase | V-INT State (state 0) |
|-----------|-----------|-----------|----------------------|
| `state_disp_004cb8` | $004CB8 | Pre-race countdown | $0010 (minimal) |
| `state_disp_005020` | $005020 | Active racing | $0014 (VDP sync) |
| `state_disp_005308` | $005308 | Post-race results | $0010 (minimal) |
| `state_disp_005586` | $005586 | Attract mode | $0010 (minimal) |
| `state_disp_005618` | $005618 | Replay | $0010 (minimal) |

---

## 2. All Scene Handler Pointers ($FF0002 Values)

Found by searching all `move.l #$xxxx,$00FF0002` in the codebase:

### Boot/Init Phase
| Handler | Set By | Purpose |
|---------|--------|---------|
| `$00894262` | `init_sequence.asm:764` | Boot/adapter init |
| `$0088C30A` | `scene_init_orch.asm:110` | Scene init return |

### Racing Scene Handlers (set by `scene_setup_game_mode_transition`)
| Handler | Mode | Condition |
|---------|------|-----------|
| `$0088E5CE` | 1P default | `$A024 == 0`, no mirror flag |
| `$0088E5E6` | 1P mirrored | `$A024 == 0`, `$FDA8` bit 7 set |
| `$0088E5FE` | 2P (P1 primary) | `$A024 == 1` |
| `$0088F13C` | 2P (P2 primary) | `$A024 == 2` |

### Loading Handlers (set by `scene_setup_game_mode_transition`, non-demo only)
| Handler | Mode | Purpose |
|---------|------|---------|
| `$00884A3E` | 1P loading | Mode 0 init |
| `$00885100` | 2P P1 loading | Mode 1 init (split-screen bits) |
| `$00884D98` | 2P P2 / fallback | Mode 2 init / default |

### Scene Reset/Transition Handlers
| Handler | Set By | Purpose |
|---------|--------|---------|
| `$008926D2` | `sync_wait_reset.asm`, `sh2_scene_reset_set_handler_8926d2.asm`, `sh2_scene_reset_cond_handler_by_player_2_flag.asm` | SH2 scene reset |
| `$0088D4A4` | `sh2_scene_reset_set_handler_88d4a4.asm` | Menu/special scene |
| `$0088D4B8` | `sync_wait_reset.asm`, `sprite_buffer_clear_sh2_scene_reset.asm` | Menu/special scene |
| `$008853B0` | `conditional_sh2_scene_reset.asm` | Conditional scene |
| `$008909AE` | `sh2_handler_dispatch_scene_init.asm` (replacement table) | Replay handler replacement |
| `$0088FB98` | `sh2_handler_dispatch_scene_init.asm`, `game_init_state_dispatch_002.asm` | Active mode handler |
| `$00893864` | `sh2_scene_reset_cond_handler_by_player_2_flag.asm` | 2P default handler |
| `$0088D864` | `z80_commands.asm:333` | Sound scene change A |
| `$0088D888` | `z80_commands.asm:336` | Sound scene change B |
| `$0088E90C` | `sh2_split_screen_display_init.asm:180` | Split-screen dispatch |
| `$00885618` | `set_state_pre_dispatch_init_sh2_scene.asm:21` | Direct replay entry |

---

## 3. Handler Replacement Mechanism

`sh2_handler_dispatch_scene_init` (at $005866) contains a **handler replacement dispatch** that detects the current race dispatcher and swaps it for a different handler:

**Match table** (detects these at `$FF0002`):
| Current Handler | → Replaced With |
|----------------|-----------------|
| `$00885618` (replay code entry) | `$008909AE` |
| `$00885308` (results code entry) | `$0088FB98` |
| `$00885024` (racing code entry) | `$0088FB98` |
| `$00884CBC` (countdown code entry) | `$0088FB98` |

**Called by:** 3 of the 5 race dispatchers call `sh2_handler_dispatch_scene_init+98` from their state 0 handler: `004cb8`, `005586`, `005618`. This means these dispatchers can **self-replace** during state 0 execution.

---

## 4. COMM Command Code ($C8A8) Per Mode

The COMM command code determines which SH2 handler processes the FIFO DMA data.

| When | $C8A8 Value | COMM0 | SH2 Handler | Purpose |
|------|-------------|-------|-------------|---------|
| `scene_init_orch` | `$0102` | HI=$01, LO=$02 | **cmd $02** ($06000CFC) | Scene orchestrator (HEAVY — entity loops, display lists) |
| `race_scene_init_vdp_mode` | `$0103` | HI=$01, LO=$03 | **cmd $03** ($06000CC4) | Racing per-frame (LIGHT — buffer clear + done) |
| `state_reset_multi`, `full_state_reset_b`, `game_logic_init_state_dispatch` | `$0000` | HI=$00, LO=$00 | **None** (COMM0_HI=0 → no dispatch) | Reset/cleared state |

**CRITICAL:** After `scene_init_orch`, $C8A8 = $0102 until `race_scene_init_vdp_mode` changes it to $0103. If a race mode's scene init doesn't call `race_scene_init_vdp_mode`, $C8A8 remains $0102 and **every per-frame DMA triggers the heavy scene orchestrator on the SH2**, not the lightweight racing handler.

---

## 5. Mode Transition Flow

### Power-On → Racing

```
Boot ($00894262)
  → adapter_init, VDP init, Z80 load
  → scene_init_orch ($00C200)
    → Sets $C8A8 = $0102 (scene orchestrator)
    → Waits SH2 ready
    → Sets $FF0002 = $0088C30A

Menu selection
  → scene_setup_game_mode_transition ($00E00C)
    → Clears $C87E = 0
    → Sets $FF0002 = scene handler ($0088E5CE for 1P)
    → If not demo: Sets $FF0002 = loading handler ($00884A3E)

Loading phase (runs once)
  → Loading handler at $FF0002
    → Initializes track, VDP, sound
    → race_scene_init_vdp_mode ($00C120)
      → Sets $C8A8 = $0103 (racing per-frame) ← CRITICAL
      → Writes COMM0 directly (one-time scene setup on SH2)
    → Sets $FF0002 = game handler ($0088FB98)

Racing phase (per-frame loop)
  → Game handler at $FF0002
    → Routes to one of 5 race sub-dispatchers
    → Sub-dispatcher reads $C87E, indexes jump table
    → State 0: mars_dma_xfer_vdp_fill (sends cmd $03 to SH2)
    → State 4: light work
    → State 8: full game frame + swap
```

### Attract Mode

```
scene_setup_game_mode_transition
  → Detects $A018 != 0 (demo flag)
  → Sets $FF0002 = $0088E5CE (same as 1P racing)
  → SKIPS loading handler (no race_scene_init_vdp_mode!)
  → $C8A8 may still be $0102 from scene_init_orch
```

**IMPLICATION:** During attract mode, `mars_dma_xfer_vdp_fill` may send **cmd $02** (scene orchestrator) to the SH2, not cmd $03. The SH2 runs the heavy orchestrator every frame, not the lightweight racing handler.

---

## 6. Why Phase B Camera Interpolation Crashed

### Root Cause Hypothesis

The `state4_interp_only` function calls `mars_dma_xfer_vdp_fill` for re-DMA, which sends whatever COMM command is in $C8A8. During:

1. **Active racing ($C8A8 = $0103):** Sends cmd $03 (lightweight, ~10K cycles). SH2 finishes quickly. Block-copy + re-DMA work fine. **This is why 005020 works.**

2. **Attract mode / pre-race ($C8A8 = $0102 or $0000):** Sends cmd $02 (heavy scene orchestrator, 100K+ cycles) or cmd $00 (no dispatch). The second DMA in state 4 either:
   - Triggers a heavy SH2 re-render that takes 2+ TV frames → state machine desync → crash
   - Sends COMM0_HI=$00 (no dispatch) → SH2 never ACKs → mars_dma_xfer_vdp_fill hangs at `.wait_ack`

### Solution Requirements

Before extending camera interpolation to other dispatchers, we must:

1. **Verify $C8A8 value** for each mode — only hook dispatchers where $C8A8 = $0103
2. **Or guard the re-DMA** — check $C8A8 before calling mars_dma_xfer_vdp_fill in state4_interp_only, skip if not $0103
3. **Or force $C8A8 = $0103** during attract/replay scene init (risky — may break SH2 rendering in those modes)

---

## 7. Safe Intervention Points

| Dispatcher | $C8A8 at Runtime | Safe for Interp? | Notes |
|-----------|-----------------|-------------------|-------|
| `state_disp_005020` | $0103 (confirmed) | **YES** (already working) | Loading handler sets $C8A8 |
| `state_disp_004cb8` | $0103 (likely) | **NEEDS VERIFICATION** | Same loading path as 005020? |
| `state_disp_005308` | $0103 (likely) | **NEEDS VERIFICATION** | Post-race, loading already ran |
| `state_disp_005586` | $0102 or $0000 (RISK) | **NO — needs guard** | Demo mode skips loading handler |
| `state_disp_005618` | $0102 or $0000 (RISK) | **NO — needs guard** | Replay, may skip loading handler |

---

## 8. Key Files

| File | Purpose |
|------|---------|
| `disasm/modules/68k/game/scene/scene_setup_game_mode_transition.asm` | Master mode selector |
| `disasm/modules/68k/game/scene/scene_init_orch.asm` | Scene init (sets $C8A8=$0102) |
| `disasm/modules/68k/game/scene/race_scene_init_vdp_mode.asm` | Race init (sets $C8A8=$0103) |
| `disasm/modules/68k/game/scene/sh2_handler_dispatch_scene_init.asm` | Handler replacement mechanism |
| `disasm/modules/68k/game/state/state_disp_*.asm` | 5 race sub-dispatchers |
| `disasm/modules/68k/game/render/mars_dma_xfer_vdp_fill.asm` | DMA function (reads $C8A8) |
