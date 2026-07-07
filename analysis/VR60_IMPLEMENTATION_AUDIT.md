# VR60 Implementation Audit — the SH2 pipeline is inert during racing

**Date:** 2026-06-18
**Trigger:** three render-bridge probes (5F-1b) produced ZERO visible change. Matias
suspected "the legacy renderer is still wired up." This audit confirms it, empirically.

## Verdict

**During the interactive racing scene the game actually runs (scene `$4CBC`), cmd `$3F`
never executes. The entire VR60 SH2 pipeline — Phase 3 physics, Phase 4 AI, Phase 5
collision, and the 5F render-bridge probe — is INERT. The game renders and simulates
entirely on the legacy 68K path.**

Root cause: the VR60 integration (the cmd `$3F` trigger in `state4_epilogue`, and every
Phase 3–8 modification) lives in **`state_disp_005020`**, but interactive racing dispatches
through a **different** dispatcher, **`state_disp_004cb8`** (`$004CB8`), which has no cmd
`$3F` trigger. `state_disp_005020` is never invoked during racing. The roadmap's **Q-008
("cmd $3F only fires from state4_epilogue in state_disp_005020 (active racing)") is FALSE.**

## Evidence (all empirical, headless VRD profiler, racing autoplay, cache-alias-immune)

| # | Observation | Watch | Racing value | Implication |
|---|-------------|-------|-------------|-------------|
| 1 | cmd $3F dispatch register | `$A15120` COMM0 (HI:LO) | `0x0000` all 1599 frames (never `$013F`) | 68K never triggers cmd $3F |
| 2 | cmd $3F param relays | `$A15126/$A15128` COMM3/COMM4 | `0` (these *persist* if written) | `vr60_comm_trigger` never runs |
| 3 | SH2 physics output | `$0600F20C` **and** cache-through `$2600F20C` | frozen `0x10000` | SH2 physics never mutates the entity |
| 4 | Execution sentinel | probe writes `$DEADBEEF` → cache-through `$2600FC00` | `0` | `bridge_probe`/end-of-cmd-$3F never reached |
| 5 | state4_epilogue first-frame gate | `$FFC8D2` (set to `$01` by its staging) | `0` all frames | `state4_epilogue` never runs |
| 6 | Active scene handler | `$FF0002` | **`$884CBC`** (= file `$004CB8` + prefix) during racing | dispatcher = `state_disp_004cb8`, not `state_disp_005020` (`$885020` never appears) |

Corroborating static facts:
- `state_disp_004cb8` (`$004CB8`, the active racing dispatcher) is a 5-entry jump-table
  dispatcher whose state-0 handler calls the **legacy** `mars_dma_xfer_vdp_fill`
  (`$0028C2`, the `$FF6218`→SDRAM DREQ render feed) and writes V-INT state `$0010`. It
  contains **no** `state4_epilogue` / `vr60_comm_trigger` / cmd `$3F`. Its jump table
  (`$4CDA/$4D00/$4D1A/$4D7A/$573C`) never targets `state_disp_005020` (`$5020`).
  (`disasm/modules/68k/game/state/state_disp_004cb8.asm`)
- `state_disp_005020` (`$005020`, VR60-modified) is a structurally different *linear
  all-states* dispatcher that calls `state4_epilogue` (→ `vr60_comm_trigger` → cmd `$3F`)
  at `code_2200.asm:185`. It is built into the ROM but never dispatched.
  (`disasm/modules/68k/game/state/state_disp_005020.asm:45`, `code_2200.asm:185`)
- The V-INT state observed during racing cycles `$10/$10/$54` — matches `state_disp_004cb8`
  writing `$0010`, NOT `state_disp_005020`'s Phase-8 `$0054`-only scheme.
- The `lea state_disp_005020(pc),a1` at `race_scene_init_004d98.asm:126` is a **red herring**:
  the next instruction (`$004F9A MOVE.B $00(A1,D0.W),...`) uses A1 as a *data-table base*
  reading the dispatcher's 2-word data prefix (`$A5A3/$A400`) as sound-buffer addresses. It
  does NOT install the dispatcher.

## Why this was never caught earlier

The Phase 2B "canary verified" check wrote `$DEADBEEF` to **`$2200FC00`**. On the SH2 map
`$22xxxxxx` is cache-through **cartridge ROM** (`$0200xxxx`), not SDRAM (`$06/$26xxxxxx`).
The write is a silent no-op, so the canary was **never observable** — cmd `$3F` execution
was never actually validated end to end. (`cmd3f_vr60_gameframe.asm:348` `.canary_addr =
0x2200FC00`; should be `0x2600FC00` to reach SDRAM.) Every downstream phase inherited the
unproven assumption that cmd `$3F` runs during racing.

## What is and isn't affected

- The SH2 ports themselves (physics/AI/collision, 5A–5E) are byte-correct and
  reference-verified — this is an **integration/wiring** failure, not a code-correctness
  failure. The code is inert, not wrong.
- Menus/other scenes are unaffected (they never used cmd `$3F` either).

## Open questions for the path forward (to resolve before re-wiring)

1. **Why does interactive racing dispatch to `state_disp_004cb8` and not `state_disp_005020`?**
   Are they two different race configurations (e.g. attract/demo vs interactive, or track/
   player-count variants), or was `state_disp_005020` simply the wrong target from the start?
   Trace which scene-init installs each, and what selects between them. (`state_disp_005020`
   IS referenced by other machinery — determine if it's ever reached in ANY mode.)
2. **Is `state_disp_004cb8` the sole racing dispatcher, or one of several** (countdown/active/
   results/attract/replay)? Map $FF0002 across a full race (the run showed 9 handlers cycling:
   `$8943C6, $884CBC, $885586, $88E90C, $892A40, $88D864, $8853B0, $884A3E, $88D48A`).
3. **Re-target vs re-route:** either (a) port the VR60 trigger + staging into the REAL active
   dispatcher(s) (`state_disp_004cb8` …), or (b) figure out how to make racing route through
   the already-modified `state_disp_005020`. (a) is likely correct but must handle ALL active
   race sub-dispatchers, not just one.
4. **Re-validate with a WORKING observable first.** Fix the canary to `$2600FC00` (real SDRAM
   cache-through) and confirm cmd `$3F` executes BEFORE building anything else on top.

## Correction (2026-07-06): `state_disp_005020` is the 2-player dispatcher, not dead code

A follow-up read-only trace (`analysis/VR60_DISPATCHER_ROUTING.md`) corrects this audit's
framing. `state_disp_005020` **is** reachable — it is installed by `race_scene_init_004d98`
("Race Scene Initialization (**2-Player**)") at `$00885024` (past the 4-byte data prefix,
which is why the original static search for `$885020` came up empty). It is **live in
2-player split-screen mode, dead in 1P/default racing** — the mode this audit's autoplay and
all prior manual play/profiling actually used.

**Root cause, precisely stated:** the entire VR60 integration (cmd `$3F` trigger + Phases
3–8) was wired into the **2-player** dispatcher under the mistaken belief that it was "the
active racing dispatcher" generically. This is **mis-targeted from the start**, not a
regression — `git blame` shows the trigger and the "VR60 Phase 8" rewrite landed together in
one commit (`b5bd8a3`, 2026-06-17), and the roadmap already contained the contradiction:
Q-009/R-008 correctly flag `gfx_2_player_entity_frame_orch` as 2P-only and defer it, while
Q-008 wired the trigger into the exact dispatcher that calls that function
(`state_disp_005020.asm:51`). The real interactive 1-player dispatcher is
**`state_disp_004cb8`** (installed by `race_scene_init_004a32`, "1-Player"), whose heavy-frame
work (`game_frame_orch_013`) has no cmd `$3F` trigger. See `VR60_DISPATCHER_ROUTING.md` for
the full routing map, the 9-handler mode table, and per-dispatcher insertion points (no single
choke point exists — 1P, Free Run, and GP/split each need their own hook; 2P is already hooked).

## Safety check: is player physics currently broken in 1P racing?

Since the SH2 physics-bypass trampoline (`vr60_physics_bypass_trampoline.asm`) and the cmd-$3F
staging gate share the **same** flag (`$FFC8D2`), and that flag empirically stays `0` for all
1599 frames of measured 1P racing (audit table, row 5) — the natural worry is that the
trampoline could take its "SH2 already computed this" branch on stale/coincidental data and
silently skip 68K physics with no replacement ever running.

**Checked and refuted.** `entity_render_pipeline.asm:20-27`: the trampoline replaces the
function's first 6 bytes (`JSR camera_state_selector+12` + `MOVEQ #0,D0`) with a `JMP` to
itself; the trampoline re-executes those exact two instructions, then branches on `$C8D2`.
When `$C8D2==0` (confirmed: always, in 1P) it jumps to `entity_render_pipeline+6` — the very
next original instruction — so the **full original 68K physics chain runs unchanged**, just
relocated through one extra jump/return. **Player and AI physics are not degraded; the
trampoline is a functional no-op in 1P.** (`$FFC8D2` is also a pre-existing *original-game*
variable — track init writes a "work param C" / lateral-threshold value there
(`race_param_block_load_table_pointer_setup.asm:37`, `collision_flag_check_054.asm:15,42`) —
VR60 repurposed this address as its control flag. It happened to read `0` throughout the
tested race; this is a **namespace-collision fragility worth removing** (pick a VR60-private
flag byte) even though it did not manifest as a bug in the tested condition.)

## Open question this raises: were the Phase 3/4/5 profiling deltas ever real in 1P?

Phase 3's committed profiling note (§7.0, "68K STOP spin 51.9%→63.1%, physics integration
hotspot 1.91%→0.76%") was presumably captured via the same autoplay/profiling harness used
throughout this project. If that harness always plays 1P (as this audit's does), and cmd `$3F`
+ the trampoline are no-ops in 1P as just shown, **those deltas need an explanation that isn't
"SH2 physics replaced 68K physics."** Not yet investigated — flagged for follow-up, not
resolved here. (Possible innocent explanations exist — e.g. incidental 68K-side changes,
a different profiling configuration — but this should be checked before trusting any
Phase 3–5 "measured improvement" figure at face value.)

## Immediate housekeeping

- `bridge_probe` (with the diagnostic sentinel) is still wired into cmd `$3F` in the working
  tree (uncommitted). It is doubly inert (cmd `$3F` never runs). Revert to the no-op patcher
  (`cmd3f_vr60_gameframe.asm:258` `.bridge_addr`→`.patcher_addr`) or keep for the re-validation
  step. Not committed either way.
