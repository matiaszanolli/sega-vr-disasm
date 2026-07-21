# Game Mode Transition Architecture

> **Routing correction (2026-07-21):** Normal 1P racing uses
> `state_disp_004cb8`; `state_disp_005020` is 2P split-screen. `state_disp_005586`
> is the Free Run/TT route reached by `--autoplay`. Read older phase labels below as
> historical unless reconfirmed in `VR60_DISPATCHER_ROUTING.md`.

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
| `state_disp_004cb8` | $004CB8 | **Normal 1P racing** | $0010 (minimal) |
| `state_disp_005020` | $005020 | **2P split-screen racing** | $0014 (VDP sync) |
| `state_disp_005308` | $005308 | Post-race results | $0010 (minimal) |
| `state_disp_005586` | $005586 | Free Run/TT / autoplay route | $0010 (minimal) |
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
| `$00885024` (2P split-screen code entry) | `$0088FB98` |
| `$00884CBC` (normal 1P code entry) | `$0088FB98` |

**Called by:** 3 of the 5 race dispatchers call `sh2_handler_dispatch_scene_init+98` from their state 0 handler: `004cb8`, `005586`, `005618`. This means these dispatchers can **self-replace** during state 0 execution.

---

## 4. COMM Command Code ($C8A8) Per Mode (CORRECTED 2026-03-16)

The COMM command code determines which SH2 handler processes the FIFO DMA data. `mars_dma_xfer_vdp_fill` reads the high byte as COMM0_HI (trigger) and low byte as COMM0_LO (command ID).

| When | $C8A8 Value | COMM0 | SH2 Handler | Purpose |
|------|-------------|-------|-------------|---------|
| `race_scene_init_vdp_mode:34` | `$0103` | HI=$01, LO=$03 | **cmd $03** ($06000CC4) | **One-time** buffer clear during scene init |
| `scene_init_orch:105` | `$0102` | HI=$01, LO=$02 | **cmd $02** ($06000CFC) | **Per-frame** scene orchestrator (ALL modes) |
| 5 reset functions | `$0000` | HI=$00, LO=$00 | **None** (no dispatch) | Reset/cleared state |

**CORRECTION:** Previous documentation stated that $C8A8 = $0103 persists during racing. This is WRONG. `race_scene_init_vdp_mode` sets $0103 at line 34, but the value is consumed by the immediate COMM0 write at lines 35-36, and then **overwritten to $0102** when execution falls through to `scene_init_orch` (verified: no RTS/JMP/BRA between $00C0F0 and $00C200 — see `SCENE_HANDLER_ARCHITECTURE.md` §5 for proof).

**Result:** C8A8 = $0102 for ALL per-frame DMA in ALL modes. Cmd $02 (scene orchestrator) is the universal per-frame command. Cmd $03 is only sent once during scene initialization.

**HAZARD:** C8A8 = $0000 after state resets. If `mars_dma_xfer_vdp_fill` runs while C8A8 = $0000, COMM0_HI=$00 → SH2 never dispatches → no ACK → infinite hang at `.wait_ack`.

---

## 5. Mode Transition Flow

### Power-On → Racing (CORRECTED 2026-03-16)

```
Boot ($00894262)
  → adapter_init, VDP init, Z80 load
  → scene_init_orch ($00C200)
    → Sets $C8A8 = $0102 (scene orchestrator — per-frame value)
    → Waits SH2 ready
    → Sets $FF0002 = $0088C30A (state_disp_00c30a)

Menu selection
  → scene_setup_game_mode_transition ($00E00C)
    → Clears $C87E = 0
    → Sets $FF0002 = $0088E5CE (display init)
    → If not demo: Overwrites $FF0002 = $00884A3E (loading handler)

Loading phase (runs once, non-demo only)
  → race_scene_init_004a32 ($004A3E) — 1P loading handler
    → Track, VDP, graphics, sound initialization
    → Calls race_scene_init_vdp_mode ($00C0F0)
      → C8A8 = $0103 → COMM0 $01/$03 (one-time SH2 scene init)
      → Falls through to scene_init_orch → C8A8 = $0102 (OVERWRITES $0103)
    → Sets $FF0002 = $00884CBC (normal 1P dispatcher)

Display init (runs once)
  → sh2_split_screen_display_init ($0088E5CE)
    → VDP, palette, tile configuration
    → Sends COMM0 $01/$03 (one-time buffer clear)
    → Sets $FF0002 = $0088E90C (palette_scene_dispatch)

Racing phase (per-frame loop)
  → Sub-dispatcher reads $C87E, indexes jump table
  → State 0: mars_dma_xfer_vdp_fill (sends cmd $02 via C8A8=$0102)
  → State 4: game logic
  → State 8: frame completion + state advance
```

### Attract Mode

```
scene_setup_game_mode_transition
  → Detects $A018 != 0 (demo flag)
  → Sets $FF0002 = $0088E5CE (display init) — NO loading handler
  → C8A8 = $0102 (persists from boot's scene_init_orch)

Frame 1: display init configures VDP, sends COMM $01/$03
  → $FF0002 = $0088E90C (palette_scene_dispatch)
Subsequent frames: palette_scene_dispatch + attract sub-dispatcher
  → mars_dma_xfer_vdp_fill sends cmd $02 (same as racing — C8A8=$0102)
```

**NOTE:** C8A8 = $0102 in ALL modes (corrected — see §4). The per-frame DMA command is always cmd $02 (scene orchestrator). See `SCENE_HANDLER_ARCHITECTURE.md` for full analysis.

---

## 6. Why Phase B Camera Interpolation Crashed (REVISED 2026-03-16)

### Old Hypothesis (DISPROVEN)

Previously thought: C8A8 = $0102 (heavy) vs $0103 (light) caused the crash. **Wrong** — C8A8 = $0102 in ALL modes. The per-frame command is always cmd $02. See §4 correction.

### Revised Root Cause (Three Factors)

**Factor 1 — No SH2-idle check before COMM0 write:**
`mars_dma_xfer_vdp_fill` (lines 21-22) writes COMM0 **without checking COMM0_HI==0 first**. The state 4 re-DMA sends a second cmd $02 while the Master SH2 may still be processing the first, clobbering the pending command.

**Factor 2 — C8A8 = $0000 after state resets:**
Five functions clear C8A8 to $0000. If re-DMA fires after a reset, COMM0_HI=$00 → SH2 never dispatches → no ACK → infinite hang at `.wait_ack`.

**Factor 3 — V-INT state mismatch:**
The historical 2P `state_disp_005020` path writes `$0014` to `$FF0008`; normal 1P
`state_disp_004cb8` and several other modes write `$0010`. V-INT behavior differs, so
camera/re-DMA hooks cannot be copied between them without revalidation.

### Solution Requirements

1. **Guard C8A8:** Before re-DMA in state 4, verify C8A8 != $0000. Skip if zero.
2. **Wait for SH2 idle:** Poll COMM0_HI == 0 before writing COMM0.
3. **Match V-INT state:** Use the target dispatcher's expected V-INT value.
4. **Skip attract/replay initially:** These skip full loading → incomplete SH2 init.

See `SCENE_HANDLER_ARCHITECTURE.md` §8 for full analysis.

---

## 7. Historical Interpolation Candidates — Unvalidated

This table records the old 2P-targeted camera experiment. “Safe” here meant only that a
command value appeared initialized; it did not establish dispatcher coverage, continuing
liveness, a second render, or current 1P suitability. Do not use it as implementation guidance
without the canonical gates in `../VR60_STATUS.md`.

| Dispatcher | $C8A8 at Runtime | Safe for Interp? | Notes |
|-----------|-----------------|-------------------|-------|
| `state_disp_005020` | $0102 (confirmed) | **UNVALIDATED 2P EXPERIMENT** | Built path; no trustworthy 2P acceptance run |
| `state_disp_004cb8` | $0102 (same path) | **NOT ESTABLISHED** | Normal 1P requires its own dependency/liveness proof |
| `state_disp_005308` | $0102 (post-race) | **NOT ESTABLISHED** | Loading state alone is insufficient evidence |
| `state_disp_005586` | $0102 (from boot) | **NEEDS GUARD** | No full loading, SH2 init may be incomplete |
| `state_disp_005618` | $0102 (from boot) | **NEEDS GUARD** | No full loading, SH2 init may be incomplete |

**Key change:** C8A8 is $0102 everywhere, not $0103. The risk for attract/replay is not the command value but incomplete SH2 scene initialization and potential C8A8=$0000 during transitions.

---

## 8. Key Files

| File | Purpose |
|------|---------|
| `analysis/SCENE_HANDLER_ARCHITECTURE.md` | **Complete scene handler reference (Phase A2)** |
| `disasm/modules/68k/game/scene/scene_setup_game_mode_transition.asm` | Master mode selector |
| `disasm/modules/68k/game/scene/scene_init_orch.asm` | Scene init (sets $C8A8=$0102) |
| `disasm/modules/68k/game/scene/race_scene_init_vdp_mode.asm` | Race init (C8A8=$0103, overwritten by fall-through) |
| `disasm/modules/68k/game/scene/sh2_handler_dispatch_scene_init.asm` | Handler replacement mechanism |
| `disasm/modules/68k/game/race/race_scene_init_004a32.asm` | 1P loading handler |
| `disasm/modules/68k/game/state/state_disp_*.asm` | 5 race sub-dispatchers |
| `disasm/modules/68k/game/render/mars_dma_xfer_vdp_fill.asm` | DMA function (reads $C8A8) |
