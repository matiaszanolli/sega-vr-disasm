# Scene Handler Architecture

> **Routing correction (2026-07-21):** `state_disp_004cb8` is the normal 1P racing
> dispatcher, not merely countdown; it remains installed while its state-8
> `game_frame_orch_013` path recurs at about 20 Hz. `state_disp_005020` is the 2P
> split-screen dispatcher. Any older “active racing” label or A-1/VR60 conclusion tied to
> 005020 applies to that 2P-targeted path, not normal 1P. See
> `VR60_DISPATCHER_ROUTING.md` and `../VR60_STATUS.md`.

**Created:** 2026-03-16
**Purpose:** Complete reference for the 68K scene handler system — the two-level dispatch, handler lifecycle, $C8A8 command staging, and the transition chain from boot through active racing. Prerequisite for Phase B camera interpolation extension.

---

## 1. Two-Level Dispatch System

### Level 1: Main Loop ($FF0000)

The main loop in Work RAM executes once per TV frame (60 Hz):

```
$FF0000: JSR <handler>          ; self-modifying: address at $FF0002
$FF0006: MOVE.W #<state>,$C87A  ; self-modifying: value at $FF0008
$FF000C: STOP #$2300            ; halt until V-INT
$FF0010: TST.W $C87A / BNE.S   ; wait for V-INT to clear $C87A
$FF0016: BRA.S $FF0000
```

- **$FF0002** (4 bytes) = scene handler pointer. Changing this changes the game mode.
- **$FF0008** (2 bytes) = V-INT state. Controls which V-INT sub-handler runs during VBlank.

### Level 2: State Dispatchers

Within each scene handler, a sub-dispatcher reads `($C87E).w` (game state), indexes a jump table, and executes the appropriate state handler. Each state handler advances `$C87E` by 4 and writes a V-INT state to `$FF0008`, then RTS.

---

## 2. The 4 Racing Scene Handlers

Set by `scene_setup_game_mode_transition` (ROM $00E00C) based on game sub-mode `$A024`:

| CPU Address | ROM Offset | Module | Mode |
|------------|-----------|--------|------|
| $0088E5CE | $00E5CE | `sh2_split_screen_display_init.asm` entry 1 | 1P default |
| $0088E5E6 | $00E5E6 | same file, entry 2 | 1P mirrored (`$FDA8` bit 7) |
| $0088E5FE | $00E5FE | same file, entry 3 | 2P P1 primary (`$A024`=1) |
| $0088F13C | $00F13C | `sh2_three_panel_display_init.asm` +12 bytes | 2P P2 primary (`$A024`=2) |

**These are display initialization functions**, not per-frame handlers. They:
1. Configure VDP hardware (256-color bitmap, 240-line mode)
2. Clear CRAM and framebuffer
3. Load palette + tile graphics via `sh2_send_cmd_wait`
4. Send one-time COMM0 $01/$03 to SH2 (cmd $03 = buffer clear)
5. Set `$FF0002` to a post-init dispatcher:
   - Split-screen entries → `$0088E90C` (`palette_scene_dispatch`)
   - Three-panel entry → `$0088F41C` (separate dispatch)

**Source:** `sh2_split_screen_display_init.asm:180`, `sh2_three_panel_display_init.asm:173`

---

## 3. The 5 Race Sub-Dispatchers

Each uses `$C87E` to index a jump table. All share the same final state [10] = `$0088573C`.

| Dispatcher | ROM | Phase | V-INT (state 0) | State 0 calls | Handler replacement? |
|-----------|-----|-------|-----------------|---------------|---------------------|
| `state_disp_004cb8` | $004CB8 | **Normal 1P racing** | $0010 | `mars_dma_xfer_vdp_fill` + `sh2_handler_dispatch+98`; state 8 reaches `game_frame_orch_013` | Yes (entry 3: track init) |
| `state_disp_005020` | $005020 | **2P split-screen racing** | $0014 | `camera_snapshot_wrapper` (historical A-1/VR60 hook) | No |
| `state_disp_005308` | $005308 | Post-race results | $0010 | `mars_dma_xfer_vdp_fill` | No |
| `state_disp_005586` | $005586 | Free Run/TT / autoplay route | $0010 | `mars_dma_xfer_vdp_fill` + `sh2_handler_dispatch+98` | Yes (entry 3: track init) |
| `state_disp_005618` | $005618 | Replay | $0010 | `mars_dma_xfer_vdp_fill` + `sh2_handler_dispatch+98` | Yes (entry 3: track init) |

**Note:** `sh2_handler_dispatch_scene_init+98` resolves to `$0058C8` (entry 3: track init + control check), NOT entry 1 (handler replacement). The +98 decimal offset points past the handler replacement code and tables.

**Key difference:** Only the 2P `state_disp_005020` path calls
`camera_snapshot_wrapper`. This is the historical Phase A-1 hook, not a normal-1P hook.

---

## 4. Complete Handler Transition Chain

### Non-Demo 1P Mode (Boot → Racing)

```
Boot
  └─ scene_init_orch ($00C200)
       ├─ Initializes SH2, VDP, entity tables
       ├─ C8A8 = $0102 (scene orchestrator command)
       └─ $FF0002 = $0088C30A (state_disp_00c30a)

Menu selection
  └─ scene_setup_game_mode_transition ($00E00C)
       ├─ $FF0002 = $0088E5CE (display init) [line 102]
       └─ Overwrites $FF0002 = $00884A3E (loading handler) [line 138]

Loading phase (runs once, non-demo only)
  └─ race_scene_init_004a32 ($004A3E)
       ├─ Track/VDP/graphics/sound initialization (600 bytes)
       ├─ Calls race_scene_init_vdp_mode ($00C0F0)
       │    ├─ C8A8 = $0103 → COMM0 $01/$03 (one-time SH2 scene init)
       │    └─ Falls through to scene_init_orch → C8A8 = $0102 (overwrites!)
       └─ $FF0002 = $00884CBC (normal 1P dispatcher code entry)

Normal 1P racing (per-frame loop)
  └─ state_disp_004cb8 remains installed and dispatches by $C87E
       └─ State 0: mars_dma_xfer_vdp_fill (sends cmd $02 via C8A8=$0102)
       └─ State 8: game_frame_orch_013 (current 1P staging hook, ~20 Hz)

2P split-screen racing (separate route)
  └─ race_scene_init_004d98 installs state_disp_005020
       └─ Contains the historical camera/VR60 integration

Post-race
  └─ state_disp_005308 (results)
  └─ Handler replacement → $0088FB98 (time_trial_records_display_init)
```

### Demo/Attract Mode (no loading handler)

```
scene_setup_game_mode_transition
  ├─ Detects $A018 != 0 (demo flag) → skips loading handler [line 126]
  └─ $FF0002 = $0088E5CE (display init) — NO loading phase

Frame 1: Display init runs
  ├─ VDP/palette/tile configuration
  ├─ Sends COMM0 $01/$03 (one-time buffer clear on SH2)
  └─ $FF0002 = $0088E90C (palette_scene_dispatch)

Subsequent frames: palette_scene_dispatch
  └─ [0] → sh2_geometry_transfer_and_palette_cycle_handler ($0088E93A)
       ├─ Sends geometry + palette data to SH2
       ├─ D-pad palette cycling
       └─ Advances state, writes $0020 to $FF0008

Eventually → state_disp_005586 (attract) or state_disp_005618 (replay)
  └─ Per-frame: mars_dma_xfer_vdp_fill (sends cmd $02 via C8A8=$0102)
```

### Key Transition Handlers

| Handler | CPU Addr | ROM | Set By | Purpose |
|---------|----------|-----|--------|---------|
| `state_disp_00c30a` | $0088C30A | $00C30A | scene_init_orch:110 | Post-init VDP sync dispatcher |
| `race_scene_init_004a32` | $00884A3E | $004A3E | scene_setup:138 | 1P loading handler |
| `palette_scene_dispatch` | $0088E90C | $00E90C | display init:180 | Post-display palette dispatch |
| `time_trial_records_display_init` | $0088FB98 | $00FB98 | handler replacement, state resets | Post-race scene |
| `name_entry_screen_init` | $008909AE | $0109AE | handler replacement, state resets | Replay/name entry scene |

---

## 5. $C8A8 Command Staging Lifecycle (CORRECTED)

### How mars_dma_xfer_vdp_fill Uses $C8A8

```asm
; mars_dma_xfer_vdp_fill.asm lines 21-22
move.b  ($FFFFC8A9).w,COMM0_LO    ; low byte → command ID
move.b  ($FFFFC8A8).w,COMM0_HI    ; high byte → trigger flag
```

`$C8A8` is a WORD: high byte = COMM0_HI (trigger, $01=dispatch), low byte = COMM0_LO (command ID).

### All Write Sites

| File | Line | Value | Context | Persists? |
|------|------|-------|---------|-----------|
| `race_scene_init_vdp_mode.asm` | 34 | **$0103** | One-time SH2 init — consumed by COMM0 write at lines 35-36 | **NO** — overwritten by fall-through |
| `scene_init_orch.asm` | 105 | **$0102** | After SH2 ready handshake — the per-frame value | **YES** — persists until reset |
| `mars_comm_write.asm` | 17 | $0000 | After COMM handshake completion | Cleared |
| `game_logic_init_state_dispatch.asm` | 44 | $0000 | Game state initialization | Cleared |
| `full_state_reset_b.asm` | 41 | $0000 | Full state reset (also sets $FF0002=$0088FB98) | Cleared |
| `state_reset_multi.asm` | 34 | $0000 | Multi-state reset (also sets $FF0002=$008909AE) | Cleared |
| `vdp_operations.asm` | 99 | $0000 | sh2_comm_sync function | Cleared |

### CRITICAL CORRECTION (vs GAME_MODE_TRANSITIONS.md §4)

**Previous documentation stated:** $C8A8 = $0103 during racing (cmd $03 = lightweight), $0102 during attract (cmd $02 = heavy).

**Actual behavior:** $C8A8 = **$0102 for ALL per-frame DMA**, in ALL modes. The $0103 value is set at `race_scene_init_vdp_mode.asm:34`, consumed by the immediate COMM0 write at lines 35-36, then **overwritten** to $0102 when execution falls through to `scene_init_orch.asm:105`.

**Verification of fall-through:**
- `race_scene_init_vdp_mode` (ROM $00C0F0-$00C1FF): no RTS, JMP, or BRA — last instruction is `JSR $0088A144` at $00C1FA (6 bytes → ends at $00C200)
- `scene_init_orch` starts at ROM $00C200 (first include in `code_c200.asm` with `org $00C200`)
- `code_a200.asm` (includes `race_scene_init_vdp_mode` as last entry) is immediately followed by `code_c200.asm` in `vrd.asm` (lines 15-16)
- Only other caller (`sh2_scene_reset_name_entry_mode_disp`) also sets it as `$FF0002`, causing the same fall-through

### Implication for Phase B

Since C8A8 = $0102 in ALL modes, the Phase B crash was NOT caused by sending the wrong command. The cmd $02 (scene orchestrator) runs identically regardless of whether we're in active racing, countdown, or attract mode. The crash root cause is elsewhere (see §8).

---

## 6. Handler Replacement Mechanism

### Trigger

`state_disp_ctrl_poll_sprite_update` (ROM $005780) dispatches via `$C8C5` (frame sub-counter). At index [10] ($C8C5=$10), it calls `sh2_handler_dispatch_scene_init` entry 1 ($005866).

### Entry 1: Handler Replacement Dispatch ($005866)

Detects the current `$FF0002` value against a 4-entry match table and replaces it:

| Match (current $FF0002) | Replace With | Context |
|--------------------------|-------------|---------|
| $00885618 (replay) | $008909AE (name_entry_screen_init) | Replay → name entry |
| $00885308 (results) | $0088FB98 (time_trial_records_display_init) | Results → time trial records |
| $00885024 (2P split-screen) | $0088FB98 | 2P racing → time trial records |
| $00884CBC (normal 1P) | $0088FB98 | 1P racing → time trial records |

After replacement, writes `$0020` to `$FF0008` and JMPs to `mars_comm_write`.

### Direct Handler Installs

These functions set $FF0002 without using the replacement dispatch:

| Function | Sets $FF0002 | Context |
|----------|-------------|---------|
| `game_init_state_dispatch_002.asm:31` | $0088FB98 | Game init path A |
| `game_logic_init_state_dispatch.asm:46` | $0088FB98 | Game logic init |
| `full_state_reset_b.asm:44` | $0088FB98 | Full state reset |
| `state_reset_multi.asm:42` | $008909AE | Multi-state reset |
| `time_trial_records_display_init.asm:215` | $008909AE | End of time trial display |

---

## 7. SDRAM Render Buffers

### Buffer Addresses

| Address (SH2) | Size | Used By | Purpose |
|---------------|------|---------|---------|
| $06020000-$06033000 | 78KB | Cmd $03 (cleared) | Working render buffers |
| $0600DA00-$0600EE00 | 5KB | Cmd $03 (cleared) | Secondary working buffers |
| $06038000 | varies | `sh2_three_panel_display_init` loads data here | Persistent display data |
| $0603B600 | varies | `sh2_three_panel_display_init` loads data here | Persistent display data |
| $0600C800 | 32×16B | Cmd $04, $05 entity table | Entity descriptors |

### Key Finding

Buffers at `$06038000` and `$0603B600` are **OUTSIDE** the cmd $03 clear range (`$06020000-$06033000`). They are persistent render output data loaded during display initialization, not temporary working buffers.

### Per-Mode Buffer Validity

| Mode | Cmd $03 (buffer clear) | Render cmd | Buffers initialized? |
|------|----------------------|------------|---------------------|
| Normal 1P racing (`004cb8`) | ✅ Ran during loading | Cmd $02 → Master → Slave | ✅ Yes |
| 2P split-screen (`005020`) | ✅ 2P loading path | Cmd $02 | ✅ Yes |
| Results | ✅ Post-race, loading ran | Cmd $02 | ✅ Yes |
| Attract | ⚠️ Display init sends COMM $01/$03 | Cmd $02 | Partial — no full loading |
| Replay | ⚠️ Display init sends COMM $01/$03 | Cmd $02 | Partial — no full loading |

---

## 8. Revised Phase B Crash Analysis

### Background

Phase B attempted to extend camera interpolation (state4_interp_only) from `state_disp_005020` to other dispatchers. The re-DMA in state 4 calls `mars_dma_xfer_vdp_fill` a second time within the same frame.

### Old Hypothesis (DISPROVEN — see §5)

C8A8 was thought to differ between modes ($0103 during racing vs $0102 during attract). Verified wrong: C8A8 = $0102 in ALL modes after scene_init_orch. See §5 for proof.

**Disproven:** C8A8 = $0102 in ALL modes. The cmd $02 handler is the same regardless.

### New Hypothesis: Three Contributing Factors

**Factor 1 — No SH2-idle check before COMM0 write:**

`mars_dma_xfer_vdp_fill` (lines 21-22) writes COMM0_HI and COMM0_LO **without first checking that COMM0_HI is 0** (SH2 idle). If the Master SH2 is still processing a prior cmd $02 when the re-DMA writes COMM0, the command is clobbered mid-execution.

```asm
; mars_dma_xfer_vdp_fill.asm — NO idle check before these writes:
move.b  ($FFFFC8A9).w,COMM0_LO          ; clobbers pending cmd
move.b  ($FFFFC8A8).w,COMM0_HI          ; clobbers trigger flag
.wait_ack:
btst    #1,COMM1_LO                     ; polls for ACK
beq.s   .wait_ack                       ; spins if SH2 doesn't ACK
```

**Factor 2 — C8A8 = $0000 after state resets:**

Five functions clear C8A8 to $0000 during state transitions. If a re-DMA fires after a reset but before C8A8 is restored to $0102, the write sends COMM0_HI=$00 (no trigger), the SH2 never dispatches, and the 68K hangs forever at `.wait_ack`.

**Factor 3 — V-INT state mismatch:**

The historical 2P `state_disp_005020` path writes `$0014` to `$FF0008`, while normal
1P `state_disp_004cb8` and several other modes write `$0010`. The V-INT behavior differs,
so a re-DMA cannot be transplanted between dispatchers without revalidating synchronization.

### Historical Extension Hypothesis — Not Current Guidance

The steps below addressed the old camera re-DMA crash theory. They were not validated as a
working interpolation path and do not supersede the current fixture, staged-command,
equivalence, descriptor-bridge, and authority gates in `../VR60_STATUS.md`.

If this historical hypothesis is revisited:

1. **Guard C8A8:** Before calling `mars_dma_xfer_vdp_fill` in state 4, verify `C8A8 != $0000`. If zero, skip the re-DMA.
2. **Wait for SH2 idle:** Before writing COMM0, poll `COMM0_HI == 0` to ensure the Master SH2 has finished the prior command.
3. **Match V-INT state:** Use the same V-INT state ($0014 or $0010) that the target dispatcher expects, not a hardcoded value.
4. **Skip attract/replay:** These modes don't go through the full loading handler and may have incomplete SH2 initialization. Defer interpolation for these modes until verified safe.

---

## 9. Quick Reference: All $FF0002 Values

| Handler | CPU Address | Set By | Category |
|---------|-----------|--------|----------|
| Boot/adapter init | $00894262 | `init_sequence.asm:764` | Boot |
| Scene init return | $0088C30A | `scene_init_orch.asm:110` | Init |
| 1P default display init | $0088E5CE | `scene_setup:102` | Display Init |
| 1P mirrored display init | $0088E5E6 | `scene_setup:113` | Display Init |
| 2P P1 display init | $0088E5FE | `scene_setup:117` | Display Init |
| 2P P2 display init | $0088F13C | `scene_setup:121` | Display Init |
| 1P loading handler | $00884A3E | `scene_setup:138` | Loading |
| 2P P1 loading handler | $00885100 | `scene_setup:145` | Loading |
| 2P P2 loading handler | $00884D98 | `scene_setup:130,152` | Loading |
| Palette scene dispatch | $0088E90C | `sh2_split_screen_display_init:180` | Transition |
| 3-panel dispatch | $0088F41C | `sh2_three_panel_display_init:173` | Transition |
| Normal 1P racing dispatcher | $00884CBC | `race_scene_init_004a32:141` | Racing |
| 2P split-screen dispatcher | $00885024 | `race_scene_init_004d98:149` | Racing |
| Results dispatcher | $00885308 | Game state machine | Racing |
| Free Run/TT dispatcher | $00885586 | Game state machine / autoplay route | Racing |
| Replay dispatcher | $00885618 | `set_state_pre_dispatch:21` | Racing |
| Time trial records | $0088FB98 | Handler replacement, resets | Post-Race |
| Name entry screen | $008909AE | Handler replacement, resets | Post-Race |
| SH2 scene reset | $008926D2 | Various reset functions | Reset |
| Menu scene A | $0088D4A4 | `sh2_scene_reset_set_handler` | Menu |
| Menu scene B | $0088D4B8 | Various | Menu |
| Split-screen dispatch | $0088E90C | `sh2_split_screen_display_init:180` | Transition |
| Sound scene A | $0088D864 | `z80_commands.asm:333` | Sound |
| Sound scene B | $0088D888 | `z80_commands.asm:336` | Sound |
| VDP mode handler | $0088C0F0 | `sh2_scene_reset_name_entry:44` | Init |
| Conditional scene | $008853B0 | `conditional_sh2_scene_reset` | Reset |
| 2P default handler | $00893864 | `sh2_scene_reset_cond` | Reset |

---

## 11. Terminal State $0088573C (Shared Exit Handler)

All 5 race sub-dispatchers share the same jump table entry [10] ($C87E = $10): `$0088573C`.

**Module:** `state_disp_00573c.asm` (ROM $00573C-$005772, 54 bytes)

**What it does:**
1. Calls `sfx_queue_process` ($0021CA)
2. Increments tick counter at `$A510` (byte, +1)
3. Reads sub-state from `$C8C4` (byte)
4. Dispatches via 4-entry jump table:

| Sub-state ($C8C4) | Handler | Action |
|-------------------|---------|--------|
| [0] | $00885760 | VDPSyncSH2, advance sub-state by 4, write $0020 to $FF0008 |
| [4] | $00885772 | Continuation |
| [8] | $00885780 | → `state_disp_ctrl_poll_sprite_update` |
| [C] | $008857BC | Continuation |

**Key finding:** This is NOT a phase transition handler. It does NOT change `$FF0002`. It's a secondary sub-state machine that cycles through its own states using `$C8C4`, eventually reaching `state_disp_ctrl_poll_sprite_update` at sub-state [8].

**The actual phase transition** happens when `state_disp_ctrl_poll_sprite_update` (ROM $005780) reaches its own sub-state [10] ($C8C5 = $10), which dispatches to `sh2_handler_dispatch_scene_init` entry 1 ($005866) — the handler replacement mechanism that swaps `$FF0002`.

**Complete exit chain:**
```
Race sub-dispatcher state [10] ($C87E=$10)
  → state_disp_00573c (sub-state machine via $C8C4)
    → [8]: state_disp_ctrl_poll_sprite_update (sub-state machine via $C8C5)
      → [10]: sh2_handler_dispatch_scene_init entry 1
        → Detects $FF0002, replaces with $0088FB98 or $008909AE
```

---

## 12. Race Scene Init → Sub-Dispatcher Transition (Complete)

Three race scene init modules directly set `$FF0002` to race sub-dispatcher code entry points:

| Init Module | ROM | Sets $FF0002 | Dispatcher | Mode |
|------------|-----|-------------|-----------|------|
| `race_scene_init_004a32.asm:141` | $004A3E | $00884CBC | state_disp_004cb8 | Normal 1P racing |
| `race_scene_init_004d98.asm:149` | $004D98 | $00885024 | state_disp_005020 | 2P split-screen racing |
| `race_scene_init_005100.asm:118` | $005100 | $00885308 | state_disp_005308 | Grand Prix results |

**This closes the gap from §4:** The transition from palette_scene_dispatch to race sub-dispatchers happens because the race scene init modules set `$FF0002` directly, bypassing palette_scene_dispatch for the racing phase. The loading handler runs BEFORE the display init, so by the time the main loop calls `$FF0002`, it's already pointing at the race sub-dispatcher.

---

## 10. Key Files

| File | Purpose |
|------|---------|
| `disasm/modules/68k/game/scene/scene_setup_game_mode_transition.asm` | Master mode selector ($FF0002) |
| `disasm/modules/68k/game/scene/race_scene_init_vdp_mode.asm` | Race scene init (C8A8=$0103, falls through) |
| `disasm/modules/68k/game/scene/scene_init_orch.asm` | Scene orchestrator (C8A8=$0102, final) |
| `disasm/modules/68k/game/scene/sh2_handler_dispatch_scene_init.asm` | Handler replacement dispatch |
| `disasm/modules/68k/game/race/race_scene_init_004a32.asm` | 1P loading handler |
| `disasm/modules/68k/game/render/sh2_split_screen_display_init.asm` | 3 display init entries |
| `disasm/modules/68k/game/render/sh2_three_panel_display_init.asm` | 2P P2 display init |
| `disasm/modules/68k/game/render/sh2_geometry_transfer_and_palette_cycle_handler.asm` | Palette dispatch state 0 |
| `disasm/modules/68k/game/state/state_disp_*.asm` | 5 race sub-dispatchers |
| `disasm/modules/68k/game/state/palette_scene_dispatch.asm` | Post-display palette dispatch |
| `disasm/modules/68k/game/state/state_disp_ctrl_poll_sprite_update.asm` | Handler replacement trigger |
| `disasm/modules/68k/game/state/state_disp_00c30a.asm` | Post-scene-init dispatcher |
| `disasm/modules/68k/game/render/mars_dma_xfer_vdp_fill.asm` | Per-frame DMA (reads C8A8) |
| `disasm/modules/68k/optimization/camera_interpolation_60fps.asm` | Camera interpolation hooks |
