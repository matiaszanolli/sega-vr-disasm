# VRD Profiling & Inspection — Usage

Instrumentation lives in the libretro/PicoDrive core (the only path that runs the
real game). Changes are kept in `libretro_vrd_profiling_v4.patch` because
`third_party/` is gitignored. To (re)build the core:

```bash
cd third_party/picodrive && make -f Makefile.libretro platform=unix -j$(nproc)
cp picodrive_libretro.so ../../tools/libretro-profiling/
```

Run the game headlessly with `profiling_frontend <rom> <frames> [--autoplay]`.
`--autoplay` navigates into Free Run/TT (`$5586`), not normal 1P GP racing
(`$4CBC`); **omit it** to let the attract/demo 3D sequence run.

## Real-ROM debugger mode

`profiling_frontend` is also the supported PicoDrive debugger. This replaces the false
“MVP complete” status of `_archive/pdcore`, whose ROM loader is a stub. Interactive and scripted
modes use the same real libretro core as profiling:

```bash
cd tools/libretro-profiling
./profiling_frontend ../../build/vr_rebuild.32x --debug
./profiling_frontend ../../build/vr_rebuild.32x \
  --debug-script debugger_smoke.commands

# From the repository root: real-core 600-frame input record/replay acceptance
cd ../..
python3 -m unittest tools/libretro-profiling/test_frontend_input_recording.py -v
```

Commands are `run [frames]`, `joypad <mask>`, `record start <path>`, `record stop`,
`regs [master|slave]`, `read <68k|master|slave> <address> [size]`, `save <path>`,
`load <path>`, `status`, `help`, and `quit`. Reads are capped at 4096 bytes per command, and
CPU/game-memory inspection remains read-only; writes, breakpoints, and disassembly remain
independent issues. `save` uses the core's current serialization size; `load` accepts a bounded
file and fails if PicoDrive's `retro_unserialize` rejects it. Older compatible sizes are therefore
preserved—the current known GP fixture is smaller than a newly saved state but remains
load-compatible.

`joypad` selects the complete P1 libretro mask used by subsequent debugger frames and disables
autoplay. A loaded `VRD_INPUT_SCRIPT` takes precedence and cannot be overridden. Input is
resolved exactly once before each `core_run`; debugger advance fails at replay exhaustion rather
than falling through to the hold mask. Recording writes that same resolved mask after every
completed frame, with recording-local indices beginning at zero. `record start` creates a new
file only, so it cannot overwrite an existing fixture; `record stop` is the only successful
finalization path. A script error, EOF, or `quit` while recording removes the partial file.

## Mandatory validity gate for 1P results

Do not call an FPS, CPU-budget, or regression result “current” until its control run proves:

1. the intended scene is active (`scene = 0x4CBC` for normal 1P);
2. `$C87E` continues cycling for the entire measurement window;
3. `VRD_CALLER_TRACE` continues seeing the intended hook when hook execution matters;
4. framebuffer hashes change when expected, as corroboration rather than the sole liveness test;
5. the tested command is observed directly through COMM or an execution sentinel.

`savestate_1p_gp_racing.bin` is suitable for short routing/caller traces, but **not a
long-run control**: it eventually stops advancing `$C87E` even when the VR60 1P hook is
physically bypassed. The former 724-unique-hash result and freeze attribution are retracted.
The newer `vr60_control_bypass.mds` plus VR60-006 replay is also bounded-only: VR60-009 proves
that its timed-race counter expires and it intentionally enters results at frame 5128. A
VR60-010 continuous PASS would still require a state/input that remain in normal 1P for all
18,360 frames, but VR60-011 now supplies the accepted separate complete-lifecycle baseline.

## Normal-1P control validator

`validate_1p_control.py` is the fail-closed gate for this milestone. A PASS requires at least
18,000 validation frames (about five minutes, 100 independent 180-frame windows). It runs the
frontend and checks the full `$FF0002 = $00884CBC` pointer, contiguous frames, the `$C87E`
`0→4→8→C→0` cycle in every fixed window, an unlimited exact trace of
`game_frame_orch_013` at `$884D1A` (expected return address `$FF0006`), framebuffer
changes, non-stuck COMM0/COMM2/COMM7 lanes, and non-idle work on both SH2s. It records
the candidate/reference ROM, tooling, input, and savestate SHA-256 values plus all raw artifacts
in the output directory. Acceptance uses fixed 180-frame windows and fixed reviewed liveness
thresholds; these values, the scene pointer, hook address, hook return, and canonical fixture
blacklist are not replaceable from the command line.

State and scene values in `frames.csv`/`watch.csv` are sampled only after each emulated frame.
They are liveness observations, not exact intra-frame chronology. VR60-009 records two legitimate
`$C87E` writes (`$0000 -> $0004 -> $0008`) within frame 4536 even though adjacent samples look
like one `$0000 -> $0008` transition. Use `VRD_WRITE_TRACE` when diagnosis requires exact writer
order. Do not loosen the current validator's scene rule, thresholds, or state policy on the basis
of that alias; any sampling-safe acceptance change belongs in a separate reviewed issue.

### VR60-011 lifecycle suite (separate policy)

`validate_1p_lifecycle_suite.py` is a separate fail-closed alternative; it does not modify,
wrap, or weaken `validate_1p_control.py`. It has two explicit operations:

```bash
python3 tools/libretro-profiling/validate_1p_lifecycle_suite.py capture \
  build/vr60_control_bypass.32x \
  --reference-rom build/vr_rebuild.32x \
  --savestate /path/to/lifecycle-start.mds \
  --input-script /path/to/full-input.csv \
  --source-capture /path/to/reviewed-source.replay \
  --frames N \
  --expected-terminal-entry-frame E \
  --expected-results-scene-frame R \
  --fixture-id stable-id \
  --output-dir /new/capture/directory

python3 tools/libretro-profiling/validate_1p_lifecycle_suite.py validate \
  /path/to/reviewed-suite.json \
  --result /new/result.json
```

The capture command refuses an existing directory, uses only the canonical hash-pinned frontend
and core, rejects any savestate marked `invalid_control` by the canonical
`control_fixtures.json`, starts a sterile environment, and records exact
frame/watch/caller/write traces. `VRD_PROFILE_PC` is absent: acceptance runs with SH2 DRC
enabled and normal 68K batching.
Both terminal frames must come from a prior diagnostic replay and be supplied before the capture;
the acceptance run cannot discover and retroactively bless an early exit. It writes exact
`run.json` provenance and a convenience `fixture-entry.json`. The latter is not an acceptance
summary: review its raw artifacts and copy the entry into a suite manifest conforming to
`vr60_lifecycle_suite.schema.json`.

The suite validator verifies the manifest and `run.json` exact key sets, on-disk hashes for the
ROM pair, profiler tools, savestate, complete input, source capture, canonical fixture-policy
manifest, matched fixture-policy entry, and all raw artifacts, then recomputes every result.
Capture and offline analysis both reject a manifest-blacklisted savestate. It rejects duplicate
source hashes and duplicate combined state/input/source identities. Diagnostic mode is an
unconditional failure.

Reviewed coverage floors are:

- at least 3 eligible distinct complete lifecycles;
- at least 1,800 active frames in every lifecycle;
- at least one 3,960-frame contiguous active span (22 × 180);
- at least 18,000 aggregate eligible active frames.

The 3,960-frame floor is evidence-based: VR60-009 measured 4,174 countable active frames after
the fixed 360-frame warmup and before the timeout display sequence. Aggregation is reported
separately and must not be described as equivalent to one continuous 18,000-frame run.

Each active epoch is checked with exact state writes, exact hook rows, framebuffer/COMM liveness,
and both SH2s' total executed cycles. Slave execution must be non-zero on every active frame.
Master execution must be non-zero in every reviewed window and substantial tail; an isolated
Master-zero frame is eligible only while the exact ordered state/completion cycle continues.
Aligned 180-frame windows are checked independently; a final partial interval participates in
an overlapping final 180-frame window, and a substantial partial tail receives its own liveness
checks. One failed lifecycle contributes zero coverage, so no average can hide a bad window.

Coverage ends at the first exact tracer PC `$006C38` write of `$C07C = $0014`, after the
360-frame warmup. `$006C38` is the source/file offset and runtime PC through the low
cartridge-ROM alias; the corresponding high 68K mapping is `$00886C38`. The `$14` through `$30`
finish display and results scene contribute zero active frames.
The complete capture is eligible only when all of the following match the predeclared reviewed
timeout route:

- watch data shows `$C050 = $FFFF -> $0000`, while `$FFEF07`, `$FFFEB7`, and `$FFFDA8`
  remain zero;
- the complete version-3 write trace contains exactly `$FFC87E:2`, `$FFC07C:2`, and
  `$FF0002:4`, and the first terminal event is PC `$006C38` writing `$C07C = $0014`;
- exact word-write PC/old/new tuples are `$006C38:$0000->$0014`,
  `$88427A:$0014->$0018`, `$8842CE:$0018->$001C`, `$884322:$001C->$0020`,
  `$884336:$0020->$0024`, `$884384:$0024->$0028`, `$884398:$0028->$002C`, and
  `$8843CA:$002C->$0030`, with corresponding post-frame watches. The initial zero is confirmed
  by the archived VR60-009 frames 4533/4534; `$C30E` is the field that changes `$10->$11`;
- at the separately predeclared results frame, PC `$8843D0` writes
  `$FF0002:4` from `$00884CBC` to `$0088FB98`.

The write trace is parsed as one strict record sequence: one exact init record, ordered unique
target declarations `0/1/2` mapped to `$FFC87E/$FFC07C/$FF0002`, one exact CSV header, data
records only, then one `COMPLETE` record as the final nonblank line. Duplicate, reordered,
malformed, unknown, `INCOMPLETE`, or trailing records are rejected.

Both trace headers and `run.json` must independently attest `sh2_drc=1`, `profile_pc=0`,
`profile_pc_env=0`, `m68k_batching=normal`, one composed instruction-start hook, exact caller
address `$00884D1A`, and unlimited capture. Caller version 2 has the exact closed grammar
`frame,pc,sp,return_addr`, a final `COMPLETE` record, return `$00FF0006`, zero errors, and zero
drops. The exact PC and return address are checked on every row, including pre-warmup rows.

Every active window must contain the exact ordered `$C87E` cycle
`$00884CF2:$0000->$0004`, `$00884D0C:$0004->$0008`,
`$00884D6A:$0008->$000C`, and `$0089C414:$000C->$0000`, with no unknown active writes.
The last transition is a fresh Master-completion witness because V-INT performs it only after
observing and acknowledging COMM1 done. Slave total executed cycles must be non-zero on every
active frame. Master total executed cycles must be non-zero somewhere in every reviewed window
and substantial tail; this permits a completed Master to spend an isolated frame in PicoDrive's
COMM-poll idle state only when the exact state cycle remains live. The sampled longest COMM0_HI
non-zero run is reported only as an informational metric; COMM2/COMM7 retain their reviewed
failure threshold.

Missing/incomplete traces, an unknown writer or target, a broken old/new chain, a boundary
mismatch, an early exit, extra policy fields, artifact mutation, or post-results coverage all
fail closed. The 43-test focused artifact suite is
`test_validate_1p_lifecycle_suite.py`; the combined lifecycle/control/tracer set has 60 passing
tests.

The reviewed v2 suite passed on Big Forest, Bay Bridge, and Acropolis with
10,906/9,263/10,968 active frames, 31,137 aggregate active frames, and a 10,968-frame longest
span. Two fresh runs per fixture produced byte-identical frame/watch/caller/write artifacts.
Raw evidence is archived in
`analysis/evidence/vr60-011-lifecycle-suite/`. VR60-010 remains unchanged as an optional
continuous alternative.

A control ROM is eligible only when it is compared with a preserved live branch build. The
reference must contain the live VR60 jump `4EF90001C8B04E71` at file offset `$4D62`; the
candidate must contain the reviewed original two-JSR bypass `4EBA69764EBA691C`; their sizes and
every byte outside that eight-byte span must match exactly. The tracked source selector and build
target produce this pair without raw patching:

```bash
make clean
make control-rom
python3 -m unittest tools/libretro-profiling/test_verify_control_rom.py -v
```

After Q-020 mode-0 promotion, the target source-builds the historical pre-promotion image as
`build/vr60_legacy_default.32x`, preserves it as `build/vr60_live_reference.32x`, then assembles
`build/vr60_control_bypass.32x` with `VR60_CONTROL_ROM` defined. It imports this validator's fixed
ROM policy and records the result in `control_rom_pair.json`. The reviewed historical hashes are live
`14632a23804b6043921f0e66d3f9ff84cf2ae58c66c04617d933fd7874b93183` and control
`6a4c89cffa7df47a946b340d39492df05f2be316c76343cf7e4e932a8ca17672`.

The SHA-256 policy in `control_fixtures.json` permanently marks the existing GP savestate as
`invalid_control`, even if it is renamed. Diagnostic override switches permit reproducing an
invalid state or active-hook ROM, but inject an unconditional failure so that such a run can
never be blessed accidentally.

```bash
# Candidate control (requires a fresh candidate state and complete replay):
python3 tools/libretro-profiling/validate_1p_control.py build/vr60_control_bypass.32x \
  --reference-rom build/vr60_live_reference.32x \
  --savestate /path/to/candidate.bin --input-script /path/to/replay.csv \
  --frames 18000 --output-dir /tmp/vrd-control

# Reproduce the known invalid combination; non-zero exit is required:
python3 tools/libretro-profiling/validate_1p_control.py build/vr_rebuild.32x \
  --reference-rom build/vr_rebuild.32x \
  --savestate tools/libretro-profiling/savestate_1p_gp_racing.bin \
  --frames 1800 --output-dir /tmp/vrd-known-bad \
  --diagnose-invalid-fixture --diagnose-rom-mismatch --diagnose-short-run

# Focused analyzer tests, from the repository root:
python3 -m unittest tools/libretro-profiling/test_validate_1p_control.py -v
```

An input replay is a complete CSV with header `frame,mask` and exactly one row for every
emulated frame from `0` through `warmup + validation - 1`; masks use the libretro joypad bitset
(`0x100` is A/accelerate). Sparse, duplicate, out-of-order, or short replays are rejected before
emulation. With no replay, the validator uses the fixed `--hold-input` mask, which is useful for
diagnostics but may not be enough to drive a five-minute multi-lap control.

Debugger recordings use this exact format and can be passed directly to `VRD_INPUT_SCRIPT`.
The loader requires one exact `frame,mask` header as well as complete, unique, ordered frame rows.

`--analyze-only` can inspect an existing artifact directory without replacing its `run.json` or
`result.json`; it writes `analysis-result.json` and always injects a diagnostic failure. It also
reports whether the current ROM/tool hashes and run arguments match the recorded provenance.
Offline CSVs therefore cannot be promoted into a control PASS.

The COMM watch is sampled only after each emulated frame. It can prove that a command or
doorbell lane became stuck, but it can miss a valid set/clear handshake that completes within
one frame. It therefore does not require a sampled COMM1 done bit and does not claim direct
per-command observation; later `$3E`/`$3F` stages still need access-event instrumentation or an
execution sentinel.

### Q-020 cmd `$3E` mode-0 gate

`validate_mode0_gate.py` is a separate exact mode-0 policy layered on the immutable VR60-011
fixtures. It does not modify the accepted baseline archive or validate mode 1. The source-built
pair and gate are run with:

```bash
make mode0-roms
python3 tools/libretro-profiling/capture_mode0_gate_suite.py \
  --rom-pair-manifest tools/libretro-profiling/mode0_rom_pair.json \
  --preflight-control build/vr60_control_bypass.32x \
  --accepted-evidence analysis/evidence/vr60-011-lifecycle-suite/artifacts.tar.gz \
  --output /new/mode0-capture
python3 tools/libretro-profiling/validate_mode0_gate.py validate \
  --manifest /new/mode0-capture/manifest.json
```

Before frame 0, the capture loads each accepted state through the historical bypass ROM and uses
the hash-pinned `mode0_preflight.commands` debugger script to read scene `$00884CBC`, flag zero,
COMM3_HI mode zero, and sentinel zero. Both `status` records must say session frame 0. The raw
transcript, tool, ROM, state, and command-script hashes are pinned; a post-`PicoFrame` watch cannot
masquerade as preflight.

Acceptance requires exactly 12 fresh slots (three identities × two arms × two repetitions).
Each run independently composes VR60-011 liveness and terminal rules. It also requires exact
source=stage completion at frames 1/3/3; exact static opcode/literal evidence; ACTIVE
stage=`$0600F20C`; paired stage equality; ACTIVE destination differing from CONTROL; a fresh
ACTIVE sentinel; zero CONTROL sentinel; one exact flag `0 -> 1` write; and a settled frame-11
mode/ACK/DREQ/COMM7 checkpoint. Caller and baseline writes match accepted raw chronology,
including `$00884D6A` and the legitimate terminal `$00006C38`, without alias normalization.

Paired framebuffer CRC may differ at most once per lifecycle: only state-8 H+3 is eligible, Bay
Bridge must have no mismatch, and every other frame through the inclusive terminal must match.
The accepted runs observed Big Forest frame 3, no Bay Bridge mismatch, and Acropolis frame 5.
This is a **one-frame sampled framebuffer divergence consistent with render/display
scheduling**. HBLK/FEN is inference not causal proof. The gate never bit-compares either arm's
CRC against the hook-bypass archive.

COMM3_HI must remain zero through the immutable VR60-011 results frame inclusive. Later global
reuse is allowed only when the complete ACTIVE/CONTROL chronology is identical; the results
boundary cannot move. The ordinary default is the complete validated ACTIVE ROM
`6f2768f2…2523900`, while `make control-rom` retains the historical VR60-011 pair.

The accepted scope is only PicoDrive exact 320B mode0 transport + exact
gameplay/state/terminal chronology in fresh eligible lifecycles. Mode 1 remains unreachable
pending scene reset/re-entry, COMM ownership and same-address dummy-read synchronization, and
FIFO FULL instrumentation at four-word granularity. Full artifacts and hashes are documented in
`analysis/evidence/vr60-q020-mode0-gate/`.

### Q-027 cmd `$3F` bounded convergence gate

`q027_cmd3f_runtime.py` implements the approved v5 acceptance policy for one validation-only
Master-COMM0 transaction through stock table `$3F`. It does not weaken the normal-1P controls or
validate the legacy shared-lane pipeline. The capture combines two fixed observer modes:

- exact-register interpreter, 1,340 frames with the exact `1262/60/18` checkpoint split;
- normal DRC, 1,340 frames in one uninterrupted debugger advance with no Q-027 MMIO/register
  observation.

The interpreter defines `T_I` from the sole Edge-1 INTM write and accepts exactly one displayed
CRC mismatch at `T_I+2`, with pinned values. CRC equality must resume at `T_I+3`; full-profile
equality must resume at `T_I+6`; either must remain uninterrupted through capture end. The DRC
arm defines `T_D` from the exact `$FF7B40 01->02` lifecycle write, permits only the pinned
Master/Slave cycle values at `T_D`, requires complete displayed-CRC equality, and requires full
profile equality from `T_D+1` through capture end. Every mismatch position and both values must
be identical in both repeats.

Both modes record `$FFC80C`, cache-through FBCTL `$2000410A`, the exact
`$C87E/$FF0002/$FF7B40/$FFC80C/$A1518B` write chronology, and the full scene-handler caller
trace. Consecutive profile
and watch rows establish no missing/reordered emulated capture frame, not host presentation or
physical scanout. The archive and exact exclusions are documented in
`analysis/evidence/vr60-q027-cmd3f-transport-gate/README.md`. The candidate remains pending
completed-diff audit, non-promotable, and unusable for render, cadence, CPU-budget, or FPS claims.

## Environment variables

| Var | Effect |
|-----|--------|
| `VRD_PROFILE_LOG=path` | Per-frame CSV: `frame,m68k_cycles,msh2_cycles,ssh2_cycles,m68k_useful,msh2_useful,ssh2_useful,active,fb_crc,scene,state,is_32x` |
| `VRD_PROFILE_FRAMES=N` | Number of frames to profile (must match the frontend frame arg; the histogram/BUDGET export fires at frame N-1) |
| `VRD_PROFILE_PC=1` | Per-CPU PC histograms + exact idle/useful `BUDGET` summary. **Forces the SH2 interpreter** (DRC bypasses the sampler), so these runs are slower but capture Master/Slave PCs. |
| `VRD_PROFILE_PC_LOG=path` | Where to write the PC CSV (`cpu,pc,total_cycles,count,avg,share` + `BUDGET` lines) |
| `VRD_GATE_3D=1` | Count only frames where the Slave is rendering 3D (excludes boot/2D) |
| `VRD_GATE_THRESH=N` | Slave cycles/frame to count as 3D-active (default 150000) |
| `VRD_SCENE=hex` | Count only frames whose scene-handler word (`$FF0004`) matches — e.g. `0x4CBC` = 1P interactive racing, `0x5586` = Free Run/TT. **Essential**: mixing car-select/attract/menu skews the budget. **Note (2026-07-13): `--autoplay` never actually reaches `0x4CBC`** — it reliably parks in `0x5586` (Free Run) instead, so this filter alone won't get you real GP-racing frames under `--autoplay`; use `VRD_LOAD_STATE` with a manually-captured GP savestate. |
| `VRD_FB_CRC=1` | Compute an FNV hash of the displayed framebuffer each frame (`fb_crc` column). This is a liveness/change signal, not proof of gameplay correctness or causality by itself. |
| `VRD_WATCH=addr:size,...` | Log values at addresses every frame (68K or SH2 bus; size 1/2/4) |
| `VRD_WATCH_LOG=path` | Where to write the watch time-series CSV |
| `VRD_DUMP_FRAME=N`, `VRD_DUMP=addr:len,...`, `VRD_DUMP_FILE=path` | Hex-dump memory regions at frame N |
| `VRD_SCENE_ADDR=hex` | 68K game-state word logged as `state` (default `FFC87E`) |
| `VRD_LOAD_STATE=path` | Load a savestate (`retro_unserialize`) before the frame loop starts. Use this for scenes `--autoplay` cannot reach. Format-compatible with standalone PicoDrive savestates; gunzip `.gz` first. Validate the fixture independently—loading successfully does not make it a durable control. The current GP fixture eventually stalls `$C87E`. |
| `VRD_HOLD_INPUT=mask` | Hold a joypad bitmask from frame 0, independent of `--autoplay`'s menu-navigation timing (which assumes frame 0 = boot). E.g. `0x100` = hold A/accelerate. Use when resuming from a savestate that needs sustained input immediately, not 1200 frames in. |
| `VRD_INPUT_SCRIPT=path` | Complete deterministic CSV replay (`frame,mask`) covering every frontend frame. It takes precedence over autoplay/hold input; missing or duplicate frames fail before emulation. |
| `VRD_CALLER_TRACE=hex_addr` (+ `VRD_CALLER_TRACE_LOG=path`) | On every exact 68K PC match, read A7 and log `frame,pc,sp,return_addr`. The tracked v4 patch composes caller and version-3 write capture under one exact instruction-start owner, defaults to an unlimited trace, and writes a `COMPLETE` footer with total/logged/dropped/error counts. It works under the accepted DRC/no-PC mode; `VRD_PROFILE_PC` is not required. |
| `VRD_CALLER_TRACE_MAX=N` | Optional diagnostic cap; `0` (default) is unlimited. The control validator rejects any non-zero cap, missing completion footer, or dropped hit. |
| `VRD_WRITE_TRACE=0xFFC87E:2,0xFF0002:4` | VR60-009 diagnostic-only complete 68K memory-write trace. Both targets are mandatory. A nullable FAME instruction-start hook captures the exact PC before opcode fetch without changing normal execution batching; wrapped byte, word, and long callbacks retain partial overlaps and same-value writes with the full target old/new value. Default execution is unchanged. Do not substitute the rejected single-instruction-batch tracer, which shifted the fixture's scene transition from frame 5128 to frame 4981. |
| `VRD_WRITE_TRACE_LOG=path` | New output path for the write trace. Initialization checks existence through the libretro VFS before opening for write and refuses an existing path; it does not rely on unsupported C `x` mode semantics. The CSV ends in `COMPLETE` only after `VRD_PROFILE_FRAMES`; early core shutdown writes `INCOMPLETE`, and any missing footer or non-zero `errors` is unusable evidence. This trace finalizes independently of `VRD_PROFILE_LOG` and `VRD_PROFILE_PC`. |

Addresses route by bus automatically: `<0x400000` or `$FF0000-$FFFFFF` → 68K;
other addresses at or above `$400000` → SH2. Consequently, do **not** watch 68K-side
COMM addresses such as `$A15120`; they are routed to the SH2 reader. Use cache-through
SH2 COMM aliases instead (`$20004020` = COMM0_HI, then the documented register offsets).
COMM7 is a 16-bit doorbell and must be watched as `$2000402E:2`; watching only byte
`$2000402E:1` sees its usually-zero high byte and can miss a stuck `$0027` value.

## Recipes

```bash
cd tools/libretro-profiling

# Candidate per-CPU budget + SH2 hotspots (Free Run under --autoplay; not 1P GP):
VRD_PROFILE_PC=1 VRD_PROFILE_PC_LOG=pc.csv VRD_PROFILE_LOG=frame.csv \
VRD_PROFILE_FRAMES=2400 VRD_GATE_3D=1 VRD_FB_CRC=1 \
  ./profiling_frontend ../../build/vr_rebuild.32x 2400 --autoplay
python3 vrd_budget.py frame.csv pc.csv          # decision-grade summary
python3 analyze_pc_profile.py pc.csv            # per-CPU hotspot tables w/ names

# Does the displayed image actually change? (fast, DRC on)
VRD_PROFILE_LOG=frame.csv VRD_PROFILE_FRAMES=2400 VRD_FB_CRC=1 \
  ./profiling_frontend ../../build/vr_rebuild.32x 2400 --autoplay
python3 vrd_budget.py frame.csv

# Is SDRAM address $0600CA00 ever written, and to what? (watch over a run)
VRD_PROFILE_LOG=f.csv VRD_PROFILE_FRAMES=2400 \
VRD_WATCH=0x0600CA00:4,0xFFC87E:2 VRD_WATCH_LOG=watch.csv \
  ./profiling_frontend ../../build/vr_rebuild.32x 2400 --autoplay

# Snapshot a memory region at a frame:
VRD_PROFILE_LOG=f.csv VRD_PROFILE_FRAMES=2010 \
VRD_DUMP_FRAME=2000 VRD_DUMP=0x06004240:32,0x0600CA00:64 VRD_DUMP_FILE=dump.txt \
  ./profiling_frontend ../../build/vr_rebuild.32x 2010 --autoplay

# Complete writes to the VR60-009 state/scene targets (the reviewed canonical
# core includes the accepted non-perturbing v3 write tracer):
VRD_WRITE_TRACE=0xFFC87E:2,0xFF0002:4 VRD_WRITE_TRACE_LOG=write.csv \
VRD_PROFILE_FRAMES=5160 VRD_LOAD_STATE=/path/to/vr60_control_bypass.mds \
VRD_INPUT_SCRIPT=/path/to/exact-5160-row-replay-prefix.csv \
  ./profiling_frontend /path/to/vr60_control_bypass.32x 5160

# Focused real-core tracer tests (defaults to the same canonical core used by
# both normal-1P validators; VRD_TEST_CORE is available for pre-review builds):
python3 -m unittest test_write_trace.py -v
```

The accepted VR60-009 command, source-address classification, raw artifact hashes, and normalized
archive are recorded in
[`analysis/evidence/vr60-009-write-trace/README.md`](../../analysis/evidence/vr60-009-write-trace/README.md).

## Notes on accuracy

- **`BUDGET` lines are authoritative**: idle/useful counts every sample, immune to
  the top-200 PC-histogram truncation. The histogram is for hotspot identification.
- **Idle classification** (`vrd_is_idle_pc` in the patch): 68K idle = PC in WRAM
  (`$FF0000+`, the BIOS V-blank poll). SH2 idle = the empirically-measured poll/delay
  loops (Master `$0600424E`; Slave `$0600059x–$0600064x`; boot `$0203CC`). These
  were derived from profiling (dominant low-avg self-looping PCs), **not docs** —
  re-derive from the histogram if SDRAM code layout changes. The same ranges are
  mirrored in `vrd_budget.py` (`IDLE`).
- PC profiling forces the SH2 **interpreter** (DRC off). Frame-level cycle counts
  are valid under DRC too.
- Per-frame watches run after `PicoFrame()`. Multiple writes can occur between adjacent samples;
  use the exact write tracer before claiming a skipped intermediate state or naming a writer.

## Historical racing profile — not a current baseline (`VRD_SCENE=0x4CBC`, 1131 frames)

> Preserve these numbers as historical evidence only. Always scene-isolate, but also satisfy
> the validity gate above. cmd `$3F` was not active in the measured 1P dispatcher, so its
> old attribution in the Master total was invalid.

| CPU (racing) | useful/frame | of CPU budget | notes |
|--------------|-------------|---------------|-------|
| 68K | 45,481 (36.6%) | — | **63% V-blank idle**; `sh2_send_cmd` wait negligible in racing |
| Master SH2 | 158,977 (99.7%) | ~41% | Historical total; not cmd `$3F` physics/AI in this 1P route |
| Slave SH2 | 231,056 (75.3%) | ~60% | ~80% util — busiest CPU; renders every TV frame |

**What remains usable:** the run demonstrated why scene isolation, idle/useful splitting,
and exact counters matter. The state machine still has a roughly 20 Hz state-8 cadence.
Re-measure CPU budgets and displayed-frame cadence only after a durable 1P control and the
staged `$3E`/`$3F` integration checks in `VR60_STATUS.md` pass.
