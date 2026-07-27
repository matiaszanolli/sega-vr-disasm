# VR60 Current Status

**Canonical as of:** 2026-07-27

**Branch:** `60fps_project`

**Goal:** Make Virtua Racing Deluxe run at a true 60 Hz game-logic and display cadence by moving suitable work from the 68000 to the Master SH2 without breaking the original Slave-SH2 renderer.

This file is the short, current answer to “what works now?” Older roadmap entries and analysis reports preserve the investigation history, including hypotheses that were later disproved. When they disagree with this page, this page and the newest dated correction in `VR60_ROADMAP.md` take precedence.

## Current truth

| Area | Present in the ROM | Active in normal 1-player racing | Validated |
|---|---|---|---|
| Original 68000 physics, AI, collision, and render preparation | Yes | **Yes; authoritative** | Original behavior remains the safety path |
| 1P hook at `game_frame_orch_013` / `state_disp_004cb8` state 8 | Yes | Yes, about 20 Hz | Hook point confirmed with exact `VRD_CALLER_TRACE` |
| cmd `$3E` player-entity transfer (mode 0) | Yes | **Enabled; promoted ordinary default** | **Q-020 mode-0 sub-gate passed over all 3 trustworthy lifecycles** |
| cmd `$3E` globals transfer (mode 1) | Validation pair only | **Disabled/unreachable in the promoted default** | **Blocked:** current validation ACK violates the COMM read-during-write rule; no runtime/reset captures exist |
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

## Current milestone: trustworthy baseline established

**Q-020 mode 0 passed on 2026-07-25.** The exact source-built ACTIVE/STAGE-CONTROL pair ran all
three immutable VR60-011 lifecycles twice per arm. All 12 fresh runs retained exact accepted
gameplay, state-write, caller, timeout, display, and results chronology; same-arm repetitions
were byte-identical for frames, watches, callers, writes, and checkpoints. The frame-11 payload
gate proved exact 320-byte `$FF6A00 -> $0600F20C` transport on PicoDrive, with a fresh ACTIVE
sentinel and zero CONTROL sentinel. Raw state PC `$00884D6A` now matches accepted chronology
without alias normalization.

The paired framebuffer CRCs were exact through the inclusive terminal except Big Forest H+3
(frame 3) and Acropolis H+3 (frame 5); Bay Bridge had no mismatch. Both exceptions sampled state
8 and equality resumed at H+4. This is a **one-frame sampled framebuffer divergence consistent
with render/display scheduling**. HBLK/FEN is inference not causal proof.

The ordinary default is now the complete validated ACTIVE ROM, SHA-256
`6f2768f2…2523900`; a clean build reproduces it byte-for-byte. Mode 1 and the relay are
unreachable. The historical VR60-011 live/control builds remain source-reproducible through the
legacy target at `14632a…b93183` / `6a4c89…17672`. Evidence is archived at
[analysis/evidence/vr60-q020-mode0-gate](analysis/evidence/vr60-q020-mode0-gate/README.md).
Claims are limited to PicoDrive exact 320B mode0 transport + exact gameplay/state/terminal
chronology in fresh eligible lifecycles; this is not a real-hardware, authority-transfer,
cadence, FPS, or CPU-budget result.

**Q-020 mode 1 remains blocked as of 2026-07-27.** The isolated source-built validation pair
rebuilds cleanly and passes its 40 focused static/tooling tests. Its active/control hashes are
`f0cdb1a7…e4c3c` / `2a958af7…da10`; the ordinary default remains byte-identical at
`6f2768f2…2523900`. A fresh safety audit rejected the current ACK sequence: the 68000 polls
`COMM1_LO` while the Master SH2 performs a read-modify-write of that same byte. Sega's hardware
manual says a read concurrent with the other CPU's write makes the register undefined. The
SH2 same-address dummy read flushes its buffered write but does not create an ownership window,
and the read-modify-write cannot atomically preserve system bit 0 against V-INT access.

No runtime acceptance claim exists. `mode1_rom_pair.json` remains
`runtime_evidence: "MISSING"` / non-promotable, and `mode1_reset_fixtures.json` contains no
normal-entry or name-entry-reentry captures. The reset manifest also currently uses
`STATIC_METADATA_PINNED_AWAITING_CAPTURES`, which is absent from its schema's status enum.
The manuals establish `68S=1` CPU-write operation, four-word FIFO capacity, and mandatory
`FULL` checks every four words, but the checked sources do not explicitly establish that FIFO
writes made before SH2 DMAC channel 0 is armed are retained. Do not remove the ACK on that
assumption; resolve the ownership/ordering question first, then capture both reset routes twice
per arm before any promotion decision.

**VR60-011 passed on 2026-07-25.** The reviewed hook-bypass control completed three distinct,
predeclared timed-race lifecycles under normal SH2 DRC execution. After the fixed 360-frame warmup,
Big Forest, Bay Bridge, and Acropolis contributed 10,906, 9,263, and 10,968 active frames:
31,137 aggregate frames, with a 10,968-frame longest span. Every exact state-write, caller,
Master/Slave cycle, framebuffer, COMM2/COMM7, timeout, display-chain, and results-scene check
passed independently. Two fresh replays per fixture produced byte-identical frame, watch, caller,
and write traces. The passing raw evidence is archived at
[analysis/evidence/vr60-011-lifecycle-suite](analysis/evidence/vr60-011-lifecycle-suite/README.md).
The unchanged continuous VR60-010 route remains available as a stronger optional shape, but it is
no longer the baseline blocker.

**VR60-002 is complete:** the canonical libretro/PicoDrive frontend now has a real-ROM debugger
whose CPU/game-memory inspection remains read-only. It advances frames, reads Master/Slave SH2
registers, reads 68K or SH2 memory, and saves/loads matching libretro states. Its tracked smoke
script reached non-zero live SH2 state after 120 frames; the old `_archive/pdcore` stub remains
retired because its ROM loader is still `Not implemented`.

**VR60-003 is complete:** debugger mode now has explicit `joypad` control and exact per-frame
input recording. A tracked real-core integration test recorded six varying non-zero masks across
frames `0..599`, replayed the CSV through `VRD_INPUT_SCRIPT`, and captured the same bytes. Replay
exhaustion fails before advancing, and partial/error recordings cannot masquerade as complete
fixtures.

**VR60-004 is complete:** `make control-rom` preserves the historical pre-promotion live build
through a source-built legacy target and assembles a second ROM from the same source with the
original two-JSR hook bypass. The validator records zero differences outside `$4D62-$4D69`.
Historical live SHA-256 is `14632a…b93183`; control SHA-256 is `6a4c89…17672`; the full
evidence is tracked in
`tools/libretro-profiling/control_rom_pair.json`. No ROM was raw-patched.

**VR60-005 is complete:** the fresh state
`/home/matias/.picodrive/mds/vr60_control_bypass.mds` has SHA-256
`16a007b460f8f568615e7f6c13a3d22f06d82a5acbfa8011e23929f8861eb1cb`, is not the blocked
fixture, and loads at `$FF0002 = $00884CBC`. A zero-warmup diagnostic exposed one initial
199-frame COMM0_HI non-zero interval. Keeping every reviewed threshold fixed but excluding a
fixed 360-frame fixture warmup, the next 1,800 frames met every liveness criterion: state stall 1;
450 exact hook hits with maximum gap 4; 1,039 framebuffer hashes with maximum stall 1; COMM0,
COMM2, and COMM7 maximum non-zero runs 3, 2, and 0; and useful work on both SH2s. The run failed
only because short diagnostics can never qualify as a control. This operationally qualifies the
fixture for bounded diagnostics; VR60-009 later proved that it expires into results too early for
the full control. It does not establish the root cause or generic semantics of the initial cmd
`$02`/COMM0 interval.

**VR60-006 is complete:**
`tools/libretro-profiling/fixtures/vr60_006_control_replay.csv` was recorded through the real
frontend from the VR60-005 state with the same held-A (`0x0100`) recipe. It is 227,581 bytes and
has SHA-256 `07e71d174468de98f3327efdfd70116ae92500add08911b376aaa40b12994ab5`.
Its exact header is `frame,mask`; its 18,360 data rows are contiguous and ordered `0..18359`.
The validator parser accepted it, and a complete `VRD_INPUT_SCRIPT` replay re-recorded the same
18,360 rows byte-for-byte with the same hash. This proves deterministic capture/replay, not
five-minute gameplay liveness.

**VR60-007 is complete:** the exact first 2,160 rows of VR60-006, SHA-256
`d71ac7f484b7ed15978425b3f7ab18256a2a2860918dd5060f623cb8d244a87a`, drove a fixed
360-frame warmup plus 1,800-frame preflight. All ten 180-frame windows stayed in the full 1P scene
and visited states `$0000/$0004/$0008/$000C` in order. The validation window recorded 450 exact
hook hits (maximum gap 4), 1,039 unique framebuffer hashes (maximum stall 1), COMM0/COMM2/COMM7
maximum non-zero runs 3/2/0, and useful work from both SH2s in every window. The trace completed 2,160
frames with 539 hits and zero drops. Exit status was the required 1, with `short_control_window`
as the only finding; this is a successful bounded preflight, not a control PASS.

**VR60-008's continuous route remains blocked by VR60-010:** the unchanged control ROM, live reference, VR60-005
state, and complete VR60-006 replay ran with the fixed 360-frame warmup and all 18,000 validation
frames, without a diagnostic, analysis, threshold, policy, or input override. The frontend and
both traces completed, but the validator exited 1 with 300 findings. VR60-009 reclassified the
apparent frame-4536 state skip as two legitimate writes within one sampled frame and the
frame-5128 scene change as the
intentional timeout/results transition. Later COMM, hook, framebuffer, and Slave-SH2 stalls are
out-of-scene observations, not normal-1P defects. The validator correctly rejects the fixture
because it does not remain in `$00884CBC` for the required window. The complete original output is
in the tracked [VR60-008 evidence archive](analysis/evidence/vr60-008-full-control/README.md), whose
deterministic `artifacts.tar.gz` SHA-256 is
`8bd15a1836686d9fcd9e027e2991bcc14ee794a1337fc6ff3f375ba5c9ef00b3`. Within it, `run.json`
SHA-256 is
`361104d02e876e2dff7c69aeb980f06e196d0c63b6e9097dc22e8c82e5794cca` and `result.json`
SHA-256 is `bcdaf92a44749a3ade515d7c4ae052ecbb89a96226ecbeaaa3e89563ef02d991`.

**VR60-009 is complete:** a nullable FAME instruction-start hook now gives the diagnostic write
tracer the exact pre-fetch 68K PC without changing normal execution batches. Its focused
byte/word/long tests pass, and a 5,160-frame active-trace replay byte-matches the trace-disabled
control. At frame 4536, PC `$884CF2` writes `$C87E` `$0000 -> $0004` and PC `$884D0C` writes
`$0004 -> $0008`; no state handler is skipped. The timed-race counter has expired and the display
controller advances through `$C07C = $14/$18/$1C/$20/$24/$28/$2C/$30`. At frame 5128, state 12
at PC `$8843D0` intentionally writes `$FF0002` `$00884CBC -> $0088FB98`. The complete trace and
finish classification are preserved in
[the VR60-009 evidence archive](analysis/evidence/vr60-009-write-trace/README.md).

The optional continuous-control alternative remains **VR60-010**: replace the bounded timed-race fixture.
Capture a new
normal-1P savestate and deterministic input with enough remaining race time, or an equivalent
repeatable driving recipe, to remain in `$FF0002 = $00884CBC` for all 360 warmup plus 18,000
validation frames. Then run the unchanged full validator. Do not loosen scene invariance, accept
post-race output, or change policy/thresholds. End-of-frame state samples must not be described as
exact write chronology. Any sampling-safe validator-policy change, if needed, belongs in a
separate later reviewed issue, not VR60-010, and must preserve fail-closed acceptance.

**VR60-010 is paused as an optional stronger control shape:** visual input capture has a reviewed bridge into the canonical
headless frontend. `retroarch_replay_to_csv.py` accepts only the exact RetroArch 1.22.2 v2 event
shape used by this capture path, rejects checkpoints/keyboard or ambiguous controller events,
requires the requested frame count and exact EOF, verifies the replay's content CRC32 against the
exact control ROM, and binds the replay, raw state, ROM, and CSV hashes in a new-file-only
manifest. A real 899-frame replay (SHA-256 `665d710f…f1724`)
converted to 899 ordered rows (SHA-256 `6c51ad27…cf08`); replaying those rows from the same raw
state through `profiling_frontend` re-recorded byte-identical CSV. This proves the capture bridge,
not gameplay durability.

The first replacement state attempt is ineligible: it was saved 32 seconds into Big Forest with
`$C050 = $0035`. Its 4,680-frame visual-input preflight left `$00884CBC` at frame 3984 and failed
the unchanged validator, as expected. A second setup attempt produced no state.

A new 3,526-frame RetroArch v2 capture (replay SHA-256 `32246bf7…a91bc0`) from slot 0 converted
to canonical CSV (SHA-256 `393b6f85…f23481`) against the exact control-ROM CRC32. RetroArch's
`RASTATE` wrapper was not passed to the core; its exact `MEM ` payload (SHA-256
`c74277f2…a06993`) was preserved as the raw source state. Its tested 3,526-frame replay remained
in `$00884CBC`, but the initial COMM0_HI interval lasted through frame 896. Replaying the same
input under the validator's PC/interpreter configuration, advancing through post-frame sample
897, and saving after exactly 898 frames produced raw state SHA-256 `c6640c78…fd5216`. The next
2,160 resolved masks were reindexed to frame 0 (SHA-256 `d0d2d482…1856ad`) and re-recorded
byte-for-byte from that state.

The unchanged 360-warmup + 1,800-frame validator then failed only with the mandatory
`short_control_window` finding. Its functional metrics were: state stall 1; ten complete state
windows; 450 exact hook hits with maximum gap 4; 456 framebuffer hashes with maximum stall 1;
and COMM0/COMM2/COMM7 maximum non-zero runs 3/2/0. This qualifies the derived state/input for
bounded diagnostics only. A DRC-derived state at the same nominal frame was rejected because it
did not reproduce the validator's interpreter trajectory; fixture derivation must preserve the
acceptance execution mode.

No replacement artifact has been promoted or tracked. If the optional VR60-010 route resumes, its
next step is a full 18,360-frame visual input capture from the exact interpreter-derived state,
followed by conversion, byte-replay, and the unchanged full validator. The input must keep the
timed race in normal 1P for all 100 validation windows. Any `RASTATE` wrapper used to load the
derived state in RetroArch must extract to a `MEM ` payload byte-identical to
`c6640c78…fd5216`.

**VR60-011 provides the accepted lifecycle-aware control policy; it does not change
VR60-010.** `validate_1p_lifecycle_suite.py` captures fresh, complete timeout/results
lifecycles and aggregate only immutable raw artifacts described by
`vr60_lifecycle_suite.schema.json`. A qualifying suite needs at least three distinct lifecycles,
at least 1,800 active frames in each, at least one 3,960-frame contiguous active span, and at
least 18,000 aggregate active frames after the fixed 360-frame warmup. Every aligned 180-frame
window, an overlapping final 180-frame window, and any substantial final partial tail are checked
individually; a bad lifecycle contributes zero aggregate coverage.

The counted active epoch ends at the predeclared first exact tracer PC `$006C38` write of
`$C07C = $0014`, not at the later results-scene write. Complete lifecycle classification then
requires predeclared terminal/results frames, `$C050 = $FFFF -> $0000`, zero lap-completion flags,
and exact word-write tuples `$0000->$0014` at `$006C38`, then the `$14/$18/$1C/$20/$24/$28/$2C/$30`
chain at `$88427A/$8842CE/$884322/$884336/$884384/$884398/$8843CA`. The initial zero is
confirmed by the archived VR60-009 watch samples at frames 4533/4534; `$C30E`, not `$C07C`,
is the field that changes `$10->$11`. `$006C38` is the source/file offset and runtime PC through
the low cartridge-ROM alias; its high 68K mapping is `$00886C38`. PC `$8843D0` must then install
`$FF0002 = $0088FB98`. ROM, profiler tools, state, input, source capture, the exact
`control_fixtures.json` identity/matched entry, run metadata, and every raw artifact are
hash-pinned. Blacklisted states, duplicate identities, malformed/incomplete/extended traces,
unknown writers, broken old/new chains, diagnostic mode, or self-asserted summaries fail closed.
All 43 focused lifecycle-policy tests pass; the 60-test combined validator/tracer set is green.
The canonical core attests DRC enabled, PC profiling absent, normal 68K batching, one composed
instruction hook, and uncapped caller capture. It validates exact `$C87E` write cycles instead of
sampled state aliases. Slave executed cycles must be non-zero on every active frame. Master
executed cycles must be non-zero in every reviewed window/tail; an isolated Master-zero frame is
accepted only while the exact ordered cycle continues, because a completed Master can
legitimately idle in PicoDrive's COMM poll state. Sampled COMM0 longest runs remain informational
because `$000C->$0000` is the fresh Master completion witness.

The current active work item is **cmd `$3E` mode-1 validation**. Q-020's mode-0 sub-gate is
closed; keep its accepted default unchanged while mode 1 is isolated behind a separate
ACTIVE/STAGE-CONTROL pair. Before enabling it, define scene reset/re-entry for the one-shot
`$FF7B40` flag, resolve COMM ownership and required SH2 same-address dummy-read synchronization,
and instrument FIFO FULL behavior at its four-word transfer granularity. Do not combine mode 1,
AI mode 2, or cmd `$3F` in one acceptance step.

The archived VR60-011 suite satisfies this prerequisite with the VR60 hook bypassed:

1. It enters the intended 1P scene (`$FF0002 = $00884CBC`).
2. `$C87E` continues cycling through the expected state sequence for the entire measurement window, including multiple laps or an equivalently long stress run.
3. `VRD_CALLER_TRACE` confirms the intended state-8 hook continues to execute.
4. Framebuffer hashes continue changing where gameplay should change; they are corroborating evidence, not the sole liveness test.
5. COMM watches use SH2 cache-through addresses (`$20004020` and related offsets), because the profiler routes watched addresses at or above `$400000` through the SH2 memory bus.

After that baseline exists, integrate one independently observable stage at a time:

1. Validate cmd `$3E` mode 1 independently while preserving the accepted mode-0 default.
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
- `analysis/evidence/vr60-009-write-trace/README.md` — exact state/scene writers, timed-finish classification, and fixture remedy
- `tools/libretro-profiling/retroarch_replay_to_csv.py` — fail-closed visual replay to canonical input bridge
- `tools/libretro-profiling/VRD_PROFILING.md` — measurement procedure and validity gates
