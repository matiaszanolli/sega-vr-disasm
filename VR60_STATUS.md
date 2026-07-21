# VR60 Current Status

**Canonical as of:** 2026-07-21

**Branch:** `60fps_project`

**Goal:** Make Virtua Racing Deluxe run at a true 60 Hz game-logic and display cadence by moving suitable work from the 68000 to the Master SH2 without breaking the original Slave-SH2 renderer.

This file is the short, current answer to “what works now?” Older roadmap entries and analysis reports preserve the investigation history, including hypotheses that were later disproved. When they disagree with this page, this page and the newest dated correction in `VR60_ROADMAP.md` take precedence.

## Current truth

| Area | Present in the ROM | Active in normal 1-player racing | Validated |
|---|---|---|---|
| Original 68000 physics, AI, collision, and render preparation | Yes | **Yes; authoritative** | Original behavior remains the safety path |
| 1P hook at `game_frame_orch_013` / `state_disp_004cb8` state 8 | Yes | Yes, about 20 Hz | Hook point confirmed with exact `VRD_CALLER_TRACE` |
| cmd `$3E` player-entity transfer (mode 0) | Yes | Enabled by the 1P hook | **Not yet validated over a trustworthy full run** |
| cmd `$3E` globals transfer (mode 1) | Yes | Enabled by the 1P hook | **Not yet validated over a trustworthy full run** |
| cmd `$3E` AI-entity transfer (mode 2) | Yes | **Disabled** | Unverified; neither proven safe nor unsafe |
| cmd `$3F` SH2 game-frame pipeline | Yes | **Disabled in 1P** | Unverified; its legacy `$2200BC00` mailbox literal is a ROM alias and must be corrected before activation |
| SH2 physics and AI ports | Yes | No; reachable only through the disabled cmd `$3F` path | Assembly/reference work exists; gameplay authority not proven |
| SH2 collision ports | Yes | No | Reference-model tested, not dispatched by the live pipeline |
| `render_state_patcher` | Yes | No useful effect | Verified no-op for the renderer's consumed inputs |
| C254 render-bridge probe | Yes | Dormant | Correct descriptor family identified; live effect not tested in 1P |
| 68000 physics bypass | Yes | **Disabled in 1P** | Legacy 68000 path intentionally remains authoritative |

“Built,” “assembled,” or “installed in a jump table” does not mean “executing in 1P,” and “executing” does not mean “behaviorally validated.” Every status table should preserve those distinctions.

## What was corrected

- `state_disp_005020` is the **2-player split-screen dispatcher**, not the generic active-racing dispatcher. The first Phase 3–5 integration was therefore never active in the 1P sessions used to assess it.
- Normal 1P racing uses `state_disp_004cb8`. Its state-8 `game_frame_orch_013` path is real and repeats about once every three TV frames; an earlier “dead code” conclusion came from a truncated PC histogram and was retracted after exact caller tracing.
- The “724 unique framebuffer hashes” result is retracted. `savestate_1p_gp_racing.bin` eventually stops advancing `$C87E` even when the VR60 hook is physically bypassed, so it cannot establish a clean long-run baseline or attribute the freeze to AI transfer or cmd `$3F`.
- `$0600C218` is not the descriptor block read by the per-frame cmd `$02` racing renderer. That renderer consumes the C128/C178/C254 descriptor families. The original 5F-1 bridge specification and its C218 probe conclusion are superseded.
- The historical “40 FPS achieved / 60 FPS one blocker away” summary does not describe this branch's currently proven 1P state. Earlier interpolation and profiling results remain useful history, but they are not a current acceptance result.

## Current milestone: restore a trustworthy baseline

Do not enable another offload stage until a test fixture or deterministic input harness passes all of these checks with the VR60 hook bypassed:

1. It enters the intended 1P scene (`$FF0002 = $00884CBC`).
2. `$C87E` continues cycling through the expected state sequence for the entire measurement window, including multiple laps or an equivalently long stress run.
3. `VRD_CALLER_TRACE` confirms the intended state-8 hook continues to execute.
4. Framebuffer hashes continue changing where gameplay should change; they are corroborating evidence, not the sole liveness test.
5. COMM watches use SH2 cache-through addresses (`$20004020` and related offsets), because the profiler routes watched addresses at or above `$400000` through the SH2 memory bus.

After that baseline exists, integrate one independently observable stage at a time:

1. Re-validate cmd `$3E` modes 0 and 1.
2. Test AI transfer mode 2 by itself.
3. Run cmd `$3F` as shadow computation while the 68000 remains authoritative.
4. Verify a bridge into the descriptor blocks actually consumed by cmd `$02`, beginning with a reversible C254 visibility/position probe.
5. Compare SH2 results against the 68000, then switch authority subsystem by subsystem; collision and the 68000 bypass come last.
6. Only after correctness and ownership are proved, change the game-logic cadence and scale time-dependent constants for 60 Hz.

Before step 3, correct and verify cmd `$3F`'s legacy mailbox literal: `$2200BC00` is the
cache-through cartridge-ROM alias, not SDRAM; the intended shared alias is `$2600BC00`.

## Definition of “60 FPS achieved”

The project is complete only when a reproducible 1P run demonstrates all of the following:

- game logic and controller response advance at 60 Hz, not merely framebuffer swaps or interpolated camera views;
- 60 distinct, correctly ordered displayed frames per second under normal NTSC timing;
- physics, AI, collision, timers, audio cues, and race progression remain equivalent in real time;
- no COMM deadlock, stale descriptor read, cache-alias error, or scene-specific fallback over an extended run;
- the exact ROM, fixture/input sequence, profiler command, watched state, and results are recorded.

## Evidence trail

- `VR60_ROADMAP.md` — active plan, questions, risks, and decision log
- `analysis/VR60_DISPATCHER_ROUTING.md` — 1P/2P dispatcher routing correction
- `analysis/VR60_PHASE1_CMD3E_ACK_HANG.md` §§20–22 — exact hook trace and invalid-savestate retraction
- `analysis/VR60_PHASE5F1B_PROBE_DIAGNOSIS.md` — C128/C178/C254 renderer inputs
- `analysis/VR60_PHASE5F_SCOPING.md` — authority/bridge problem, read with its current correction banner
- `tools/libretro-profiling/VRD_PROFILING.md` — measurement procedure and validity gates
