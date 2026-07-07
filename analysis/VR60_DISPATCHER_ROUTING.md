# VR60 Dispatcher Routing — why the SH2 pipeline is inert, and where it must go

**Date:** 2026-07-06
**Role:** Worker, read-only research. No asm/source/Makefile modified.
**Follows:** `analysis/VR60_IMPLEMENTATION_AUDIT.md` (2026-06-18). This doc answers its
7 open questions with cited disassembly.

---

## Executive summary

- **`state_disp_005020` is the 2-PLAYER split-screen race dispatcher**, not a rewritten 1P
  path. It is installed by `race_scene_init_004d98` — whose own header reads
  "Race Scene Initialization (2-Player)" — via `MOVE.L #$00885024,$00FF0002`
  (`race_scene_init_004d98.asm:149`, ROM `$005000`). `$885024` = file `$005024` =
  `state_disp_005020`'s code entry (2-word data prefix `$5020` + 4).
- **The audit's static claim "`$885020` never appears in `$FF0002`" used the wrong literal.**
  Dispatchers are installed at their *code entry* (past the 4-byte prefix), so the value to
  search for is **`$885024`**, and it IS written — by the 2P init. The audit also only saw 1P
  racing empirically (the autoplay never entered 2P), so `$885024` legitimately never appeared.
- **`state_disp_005020` is therefore NOT dead code** — it is reachable, but only in
  **2-player split-screen mode**. It is never reached in 1P / default racing, which is what
  autoplay and normal single-player play use.
- **The interactive 1-player racing dispatcher is `state_disp_004cb8`**, installed by
  `race_scene_init_004a32` ("1-Player", `race_scene_init_004a32.asm:141`,
  `MOVE.L #$00884CBC,$00FF0002` at ROM `$004C6A`). Its per-frame physics/entity work lives in
  its **state-8 handler `game_frame_orch_013`** (`$004D1A`), which has no cmd `$3F` trigger.
- **Mis-targeted from the start (not a regression).** `git blame` shows the "VR60 Phase 8"
  header (line 2) and the `state4_epilogue`/cmd `$3F` call (line 45) were BOTH added in the
  same, first-and-only integration commit **`b5bd8a3` (2026-06-17)** — straight into the 2P
  dispatcher. No prior commit ever had the trigger in the 1P path. The roadmap even contains
  the contradiction in writing: **Q-009/R-008** flag `gfx_2_player_entity_frame_orch` as the
  2P-only block copy to *defer* ("Phase 3 = 1P only"), yet **Q-008** put the trigger into the
  dispatcher that *calls that very function* (`state_disp_005020.asm:51`).
- **Recommended target:** port the staging + `vr60_comm_trigger` block into
  **`game_frame_orch_013` (state 8 of `state_disp_004cb8`), immediately after
  `race_entity_update_loop` (`game_frame_orch_013.asm:56`)** — the exact structural analog of
  where `state4_epilogue` sits in `state_disp_005020`. Full coverage of interactive racing also
  requires the same hook in `frame_update_orch_0055d0` (Free Run) and `frame_orch_00535e`
  (GP/split); 2P (`state_disp_005020`) is already hooked. **There is no single universal choke
  point.**
- **Biggest remaining unknown:** whether a first re-wire should fire cmd `$3F` at the legacy
  per-game-tick cadence (state 8 = ~20/s) with the legacy `race_entity_update_loop` still
  running, or whether the legacy 68K physics in `race_entity_update_loop` must be bypassed in
  the same edit (the "VR60 physics bypass" the 005020 header assumes). Routing is proven;
  the physics-handoff sequencing is not yet designed.

---

## Q1 — Who installs `$FF0002` for interactive racing?

The main loop at `$FF0000` calls `JSR [$FF0002]` every frame (CLAUDE.md, Main Loop
Architecture). A **race scene-init** routine runs once, sets up the scene, then overwrites
`$FF0002` with a **state dispatcher** for subsequent frames.

For 1-player racing the chain is:

| Step | Routine | ROM | Action | Cite |
|------|---------|-----|--------|------|
| mode select | `scene_setup_game_mode_transition` | `$00E0D4` | sub-mode `$A024==0` → installs init `$00884A3E` ("mode 0 loading handler") | `scene_setup_game_mode_transition.asm:138` |
| scene init (once) | `race_scene_init_004a32` (entry `$004A3E`) | `$004C6A` | `MOVE.L #$00884CBC,$00FF0002` | `race_scene_init_004a32.asm:141` |
| per-frame | `state_disp_004cb8` (`$004CBC`) | — | reads `$C87E`, 5-entry jump table | `state_disp_004cb8.asm:30` |

So **`race_scene_init_004a32` installs the interactive-racing dispatcher `state_disp_004cb8`**,
and `scene_setup_game_mode_transition` selects that init when game sub-mode `$A024 == 0`
(default / single player). `set_state_pre_dispatch_init_sh2_scene` is NOT the racing installer —
it writes a different handler `$00885618` (`set_state_pre_dispatch_init_sh2_scene.asm:21`); it is
adjacent in the include list but unrelated to the 004cb8 install.

`race_scene_init_004a32` also contains `lea state_disp_004cb8(pc),a1`
(`race_scene_init_004a32.asm:133`) used as a *sound-buffer data-table base* reading the
dispatcher's 2-word prefix (`$A2A0/$A100`) — same idiom the audit flagged in the 2P init. The
real install is the `MOVE.L` at :141.

---

## Q2 — What does `race_scene_init_004d98` install? Is it ever called?

`race_scene_init_004d98` header: **"Race Scene Initialization (2-Player) … Sets main loop
entry at $005024."** (`race_scene_init_004d98.asm:1-7`)

It writes **`MOVE.L #$00885024,$00FF0002`** at ROM `$005000` (`race_scene_init_004d98.asm:149`).
`$885024` = `state_disp_005020` **code entry** (prefix `$5020` + 4). **So it DOES install
`state_disp_005020`.** The audit reported only the *other* reference in this module — the
`lea state_disp_005020(pc),a1` at :126, correctly identified as a data-table read (`$A5A3/$A400`
sound buffers) — but **missed the actual install at :149.**

Note this init reads BOTH dispatchers' prefixes as sound-buffer tables (one per split-screen
viewport): `lea state_disp_004cb8` at :117 and `lea state_disp_005020` at :126, before
installing 005020 at :149. That two-viewport double-read is itself a 2P tell.

**Is `race_scene_init_004d98` ever called?** Yes. It is installed as a scene handler by:

| Installer | ROM | Selector | Cite |
|-----------|-----|----------|------|
| `scene_setup_game_mode_transition` | `$00E108` | sub-mode `$A024==2` ("mode 2 loading handler", split-screen P2 primary) | `scene_setup_game_mode_transition.asm:152` |
| `scene_setup_game_mode_transition` | `$00E0B6` | fallback ("default loading handler") | `scene_setup_game_mode_transition.asm:130` |
| `z80_commands` | — | two sites | `z80_commands.asm:1037,1052` |

So `race_scene_init_004d98` runs in **2-player split-screen mode** (`$A024==2`) and installs
`state_disp_005020`.

---

## Q3 — Is `state_disp_005020` reachable in ANY mode?

**Yes — in 2-player split-screen racing.** Exhaustive search of every `$FF0002` write and every
reference to `885024`/`005024`/`state_disp_005020`:

- Installed at `$FF0002` only by `race_scene_init_004d98.asm:149` (`$00885024`).
- Recognized as a live handler in the handler-swap table `sh2_handler_dispatch_scene_init.asm:43`
  (`dc.l $00885024 ; match 2`) — the routine that hot-swaps `$FF0002` knows this value.
- `frame_update_orch_005070.asm` is documented as **absorbed** into 005020 by Phase 8
  (`:2,:6,:15`); `camera_interpolation_60fps.asm:26` "called from state 0 handler
  (state_disp_005020)" (but that file is untracked / not in build per roadmap:322).

**Verdict:** `state_disp_005020` is **live in 2P mode, dead in 1P/default racing.** The audit's
"never invoked" is true only for the 1P autoplay it measured, and its `$885020` static search
missed because the installed literal is `$885024`.

---

## Q4 — `state_disp_004cb8` vs `state_disp_005020`: twins or different modes?

**Different modes (different player counts), not twins, and not a "rewritten copy of the 1P
path."** They are the same *kind* of object — a per-frame race state dispatcher — one per race
configuration:

| Dispatcher | ROM | Installed by (init) | Init header | Config | Structure | cmd $3F? |
|------------|-----|---------------------|-------------|--------|-----------|----------|
| `state_disp_004cb8` | `$004CBC` | `race_scene_init_004a32` | "1-Player" | 1P (sub-mode 0) | 5-entry jump table | **no** |
| `state_disp_005308` | `$005308` | `race_scene_init_005100` | "Grand Prix" | split-screen P1-primary (sub-mode 1) | 5-entry jump table | **no** |
| `state_disp_005586` | `$005586` | `race_scene_init_0053b0` | "Free Run / Time Attack" | Free Run / TT | 4-entry jump table | **no** |
| `state_disp_005020` | `$005024` | `race_scene_init_004d98` | "2-Player split-screen" | 2P (sub-mode 2) | **linear (VR60 Phase 8 rewrite)** | **yes** |

Original intent, per module headers and installers:
- All four were originally legacy jump-table dispatchers reading `$C87E`. `state_disp_005020`'s
  own header admits it *had* a jump table: "Jump table at `$00502E` is no longer used"
  (`state_disp_005020.asm:16`). The VR60 team rewrote the **2P** one into linear all-states form
  and added the trigger.
- Structural proof of "different modes, not twins": `state_disp_005020` calls
  `gfx_2_player_entity_frame_orch` (`state_disp_005020.asm:51`) and its init copies a second
  32×32 object table for "the second player viewport" (`race_scene_init_004d98.asm:86-92`) and
  sets `COMM1_HI=$04` = 2-player flag (`:33`). `state_disp_004cb8` does none of that.

So `state_disp_005020` is a **VR60-rewritten copy of the 2P dispatcher**, mistaken for "the
active racing dispatcher." The genuine interactive 1P path was always `state_disp_004cb8`.

---

## Q5 — Map the 9 racing-era scene handlers

`$FF0002` cycled through nine values during the racing autoplay. Resolved by
`file = addr − $880000`, then matched to the module whose ROM range contains that offset:

| # | `$FF0002` | file | Module (entry) | Role | Race? |
|---|-----------|------|----------------|------|-------|
| 1 | `$8943C6` | `$0143C6` | `state_disp_ctrl_init` (installed by `game_mode_transition_init.asm:95`) | menu / mode-transition dispatcher | no |
| 2 | `$884CBC` | `$004CBC` | **`state_disp_004cb8`** | **1P interactive active-driving dispatcher** | **YES** |
| 3 | `$885586` | `$005586` | **`state_disp_005586`** | **Free Run / TT active-driving dispatcher** | **YES** |
| 4 | `$88E90C` | `$00E90C` | dispatch table installed by `sh2_split_screen_display_init.asm:180` | split-screen display-setup dispatcher | transition |
| 5 | `$892A40` | `$012A40` | `scene_state_disp_track_data_tables` (installed by `camera_replay_screen_init.asm:192`) | replay/camera scene dispatcher | replay |
| 6 | `$88D864` | `$00D864` | `scene_state_disp_with_palette_data` ("single-screen table", `sh2_display_and_palette_init.asm:224`) | display-mode dispatcher | transition |
| 7 | `$8853B0` | `$0053B0` | **`race_scene_init_0053b0`** (Free Run init; installed by `conditional_sh2_scene_reset.asm:23`) | **Free Run scene init (one-shot)** | **YES (init)** |
| 8 | `$884A3E` | `$004A3E` | **`race_scene_init_004a32`** (1P init entry) | **1P scene init (one-shot)** | **YES (init)** |
| 9 | `$88D48A` | `$00D48A` | `sh2_display_and_palette_init` (`:227` / `code_e200.asm:908`) | name-entry / default display dispatcher | transition |

**Interactive active-driving dispatchers the VR60 physics/render must hook:** `#2
state_disp_004cb8` (1P) and `#3 state_disp_005586` (Free Run). The one-shot inits `#7/#8` set
them up. `state_disp_005308` (GP/split P1) and `state_disp_005020` (2P) did **not** appear in
this autoplay (it never entered GP or 2P) but are the analogous dispatchers for those configs.
`#1,#4,#5,#6,#9` are menu / transition / replay / display-mode handlers, not race sub-states.

Per-dispatcher V-INT/frame layout (all legacy jump-table race dispatchers share the pattern):
state 0 → `mars_dma_xfer_vdp_fill` + write V-INT `$10`; state 8 = the heavy frame (entity +
physics) → write V-INT `$54`. This reproduces the audit's observed `$10/$10/$54` V-INT cycle
exactly (`state_disp_004cb8.asm:47`, `call_subs_advance_game_state.asm:20`,
`game_frame_orch_013.asm:60`).

---

## Q6 — Mis-targeted from the start, or a regression?

**Mis-targeted from the start.** Evidence:

1. **`git blame`**: both the "VR60 Phase 8" header (`state_disp_005020.asm:2`) and the
   `jsr state4_epilogue … cmd $3F trigger` (`:45`) originate in commit **`b5bd8a3`
   (2026-06-17)** — the first and only commit to introduce the trigger. There is no earlier
   commit in which `state_disp_004cb8` (1P) carried the trigger and later lost it.
2. **Full file history** (`git log --all` on `state_disp_005020.asm`): every VR60/60fps
   optimization attempt targeted this same 2P module — `22d152b` (S-4 30 FPS state merge),
   `b6bd487` (40 FPS camera interpolation), `b5bd8a3` (Phase 8 + cmd $3F). A consistent, repeated
   fixation on `state_disp_005020` as "the racing dispatcher."
3. **Roadmap self-contradiction:**
   - **Q-008** (`VR60_ROADMAP.md:1196,1349`): "cmd `$3F` only fires from `state4_epilogue` in
     `state_disp_005020` (active racing)." — the false premise the audit named.
   - **Q-009 / R-008** (`:1197,1248,1350`): `gfx_2_player_entity_frame_orch` is the **2P**
     block copy; "Phase 3 = 1P only … 2P deferred."
   - But `state_disp_005020` **calls `gfx_2_player_entity_frame_orch`** (`state_disp_005020.asm:51`).
     The team therefore put its self-declared "1P-only" pipeline into the self-declared
     "deferred 2P" dispatcher — a contradiction present from the initial integration.

The team never verified which mode `state_disp_005020` served; they assumed the label meant
"active racing" generically. Q-008 is false as written.

---

## Q7 — Where the integration SHOULD go (concrete insertion points)

The trigger must sit **after the per-frame entity/physics update and before the `$0054` V-INT
write**, in the **state-8 "heavy frame" handler of each active-race dispatcher** — the exact
structural slot `state4_epilogue` occupies in `state_disp_005020` (right after
`entity_render_pipeline_with_vdp_dma_2p_copy+462`, `state_disp_005020.asm:44-45`).

| Race config | Dispatcher | State-8 heavy-frame handler | Insert cmd $3F staging+trigger **after** | Cite | Status |
|-------------|------------|-----------------------------|------------------------------------------|------|--------|
| **1P interactive** (primary) | `state_disp_004cb8` | `game_frame_orch_013` (`$004D1A`, Path A) | `race_entity_update_loop` | `game_frame_orch_013.asm:56` (before `object_update`/`$0054` at :58-60) | **UNHOOKED — main target** |
| **Free Run / TT** | `state_disp_005586` | `frame_update_orch_0055d0` (`$0055D0`) | `race_entity_update_loop` | `frame_update_orch_0055d0.asm:29` (before `object_update`/`$0054` at :33-35) | UNHOOKED |
| **GP / split P1** | `state_disp_005308` | `frame_orch_00535e` (`$00535E`, entry 1) | `entity_render_pipeline_with_2_player_dispatch+198` | `frame_orch_00535e.asm` (`$005382`, before `object_update`/`$0054`) | UNHOOKED |
| **2P split-screen** | `state_disp_005020` | linear (state4_epilogue inline) | — | `state_disp_005020.asm:45` | **already hooked** |

**No single universal choke point:**
- `mars_dma_xfer_vdp_fill` (state-0 of every legacy race dispatcher) is the closest shared call,
  but it also runs in **menus/attract** (CLAUDE.md: "`$C8A8=$0102` for ALL per-frame DMA in ALL
  modes") — hooking there fires cmd `$3F` on menu entities. Would need a race-mode gate.
- `race_entity_update_loop` is shared by 1P (`game_frame_orch_013.asm:56`) and Free Run
  (`frame_update_orch_0055d0.asm:29`) heavy frames, **but not GP** (which uses
  `entity_render_pipeline_with_2_player_dispatch+198`), and it also runs during scene init
  (`race_scene_init_004a32.asm:106`, `race_scene_init_0053b0.asm:86`) — so it cannot be
  blanket-hooked either.
- Each config's state-8 handler and entity-render entry differ. **Per-dispatcher hooks are
  required.**

**Not a verbatim `state4_epilogue` call.** The Phase-8 form of `state4_epilogue` deliberately
**removed** the state-advance and V-INT write (`code_2200.asm:186-187`) because 005020 is linear.
The legacy dispatchers still cycle `$C87E` and write their own V-INT state, so the re-wire must
insert only the **staging + trigger body** — the `$C8D2` first-frame gate, `vr60_entity_stage` /
`vr60_globals_stage` / `vr60_*_transfer` / `vr60_ai_entity_stage`, the COMM6/COMM4/COMM5 pickup,
and `vr60_comm_trigger` (`code_2200.asm:158-185`) — leaving each dispatcher's own state
machinery intact.

**Validation prerequisite (from audit #4):** fix the canary to `$2600FC00` (real SDRAM
cache-through) before building on top; `$2200FC00` is cartridge ROM and silently no-ops
(`cmd3f_vr60_gameframe.asm:348`).

---

## Unresolved / to confirm

| # | Item | Why unresolved |
|---|------|----------------|
| U-1 | **Cadence & physics handoff.** State 8 runs once per game-tick (~20/s), and it currently runs the legacy `race_entity_update_loop` 68K physics. A re-wire that fires cmd `$3F` there without bypassing that legacy physics will have BOTH paths compute the entity. The "VR60 physics bypass" the 005020 header assumes is a separate design step. | Routing is proven; handoff sequencing not designed (out of read-only scope). |
| U-2 | **Exact byte offset of the GP insertion** (`frame_orch_00535e` after `entity_render_pipeline_with_2_player_dispatch+198`, ~`$005382`). | Confirmed by structure, not by a byte-for-byte listing check. |
| U-3 | **Mode-name mismatch:** `scene_setup_game_mode_transition` calls sub-mode 1 "split-screen P1 primary" while `race_scene_init_005100`'s header says "Grand Prix". Both agree it is a *distinct* config from 1P/2P; the marketing label is ambiguous. | Header vs mode-transition comment disagree; structural identity (distinct dispatcher `state_disp_005308`) is certain. |
| U-4 | **Whether 2P (`state_disp_005020`) still functions after the Phase-8 rewrite.** It is reachable in 2P, but the linear rewrite + cmd `$3F` there was never validated (autoplay never entered 2P; canary was a no-op). | No 2P run measured. |
| U-5 | **`state_disp_00573c` (shared state-10 sub-dispatcher, `$00573C`)** targeted by both 004cb8 and 005308 jump tables. Whether it ever carries entity/physics work relevant to cmd `$3F`. | Header shows it does VDP sync + `$C8C4` sub-state dispatch writing V-INT `$20`; not obviously physics-bearing, not fully traced. |
