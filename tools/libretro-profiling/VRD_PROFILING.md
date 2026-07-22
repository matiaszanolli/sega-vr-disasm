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
Capture a fresh durable fixture or deterministic input sequence before publishing a new baseline.

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

A control ROM is eligible only when it is compared with a preserved live branch build. The
reference must contain the live VR60 jump `4EF90001C8B04E71` at file offset `$4D62`; the
candidate must contain the reviewed original two-JSR bypass `4EBA69764EBA691C`; their sizes and
every byte outside that eight-byte span must match exactly. Produce the bypass from assembly
source in a disposable diagnostic branch/worktree, preserving the live ROM first. This proves
that hook isolation—not merely plausible bytes at one offset—defines the control. Do not
raw-patch the production ROM.

The SHA-256 policy in `control_fixtures.json` permanently marks the existing GP savestate as
`invalid_control`, even if it is renamed. Diagnostic override switches permit reproducing an
invalid state or active-hook ROM, but inject an unconditional failure so that such a run can
never be blessed accidentally.

```bash
# Candidate control (requires a reviewed hook-bypass ROM and a fresh candidate state):
python3 tools/libretro-profiling/validate_1p_control.py /path/to/bypass.32x \
  --reference-rom /path/to/preserved-live-branch.32x \
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
| `VRD_CALLER_TRACE=hex_addr` (+ `VRD_CALLER_TRACE_LOG=path`) | On every exact 68K PC match, read A7 and log `frame,sp,return_addr`. The tracked v4 patch now defaults to an unlimited trace and writes a `COMPLETE` footer with total/logged/dropped counts, so late-window recurrence can be proved. Requires `VRD_PROFILE_PC=1` and `VRD_PROFILE_PC_LOG=path`. |
| `VRD_CALLER_TRACE_MAX=N` | Optional diagnostic cap; `0` (default) is unlimited. The control validator rejects any non-zero cap, missing completion footer, or dropped hit. |

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
```

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
