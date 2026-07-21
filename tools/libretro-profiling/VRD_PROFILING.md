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
| `VRD_CALLER_TRACE=hex_addr` (+ `VRD_CALLER_TRACE_LOG=path`) | On every 68K PC sample that exactly matches `hex_addr`, read the JSR return address off the top of the 68K stack (A7) and log `frame,sp,return_addr` (capped at 50 hits). Reveals a function's *real* caller even when it's reached via a self-modified/dynamic call site static grep can't find. **Important**: this is an exact counter, unlike the PC histogram — use it to confirm/refute "does this code path ever execute," since the histogram is top-200/cycle-sorted and can silently miss real-but-low-cycle-cost addresses (see `analysis/VR60_PHASE1_CMD3E_ACK_HANG.md` §17 for a case where this caused a false "dead code" conclusion). Requires `VRD_PROFILE_PC=1` **and** `VRD_PROFILE_PC_LOG=path` both set — `VRD_PROFILE_PC` alone silently no-ops without a log path. |

Addresses route by bus automatically: `<0x400000` or `$FF0000-$FFFFFF` → 68K;
other addresses at or above `$400000` → SH2. Consequently, do **not** watch 68K-side
COMM addresses such as `$A15120`; they are routed to the SH2 reader. Use cache-through
SH2 COMM aliases instead (`$20004020` = COMM0_HI, then the documented register offsets).

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
