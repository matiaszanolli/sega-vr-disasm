# VRD Profiling & Inspection — Usage

Instrumentation lives in the libretro/PicoDrive core (the only path that runs the
real game). Changes are kept in `libretro_vrd_profiling_v4.patch` because
`third_party/` is gitignored. To (re)build the core:

```bash
cd third_party/picodrive && make -f Makefile.libretro platform=unix -j$(nproc)
cp picodrive_libretro.so ../../tools/libretro-profiling/
```

Run the game headlessly with `profiling_frontend <rom> <frames> [--autoplay]`.
`--autoplay` navigates menus into a race; **omit it** to let the attract/demo 3D
sequence run (a clean, input-free 3D benchmark).

## Environment variables

| Var | Effect |
|-----|--------|
| `VRD_PROFILE_LOG=path` | Per-frame CSV: `frame,m68k_cycles,msh2_cycles,ssh2_cycles,m68k_useful,msh2_useful,ssh2_useful,active,fb_crc,scene,state,is_32x` |
| `VRD_PROFILE_FRAMES=N` | Number of frames to profile (must match the frontend frame arg; the histogram/BUDGET export fires at frame N-1) |
| `VRD_PROFILE_PC=1` | Per-CPU PC histograms + exact idle/useful `BUDGET` summary. **Forces the SH2 interpreter** (DRC bypasses the sampler), so these runs are slower but capture Master/Slave PCs. |
| `VRD_PROFILE_PC_LOG=path` | Where to write the PC CSV (`cpu,pc,total_cycles,count,avg,share` + `BUDGET` lines) |
| `VRD_GATE_3D=1` | Count only frames where the Slave is rendering 3D (excludes boot/2D) |
| `VRD_GATE_THRESH=N` | Slave cycles/frame to count as 3D-active (default 150000) |
| `VRD_FB_CRC=1` | Compute an FNV hash of the displayed framebuffer each frame (`fb_crc` column) → effective-display-FPS / "did the image change?" |
| `VRD_WATCH=addr:size,...` | Log values at addresses every frame (68K or SH2 bus; size 1/2/4) |
| `VRD_WATCH_LOG=path` | Where to write the watch time-series CSV |
| `VRD_DUMP_FRAME=N`, `VRD_DUMP=addr:len,...`, `VRD_DUMP_FILE=path` | Hex-dump memory regions at frame N |
| `VRD_SCENE_ADDR=hex` | 68K game-state word logged as `state` (default `FFC87E`) |

Addresses route by bus automatically: `<0x400000` or `0xFF0000+` → 68K; `0x04xxxxxx`/`0x06xxxxxx` (+cache-through) → SH2.

## Recipes

```bash
cd tools/libretro-profiling

# Authoritative per-CPU useful-work budget + SH2 hotspots + effective FPS (racing):
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

## Canonical baseline (current `60fps_project` build, racing/3D-active)

| CPU | useful/frame | of executed | of CPU budget |
|-----|-------------|-------------|---------------|
| 68K | 56,073 | 45.0% | ~44% |
| Master SH2 | 103,423 | 83.6% | ~27% (≈68% free) |
| Slave SH2 | 125,476 | 40.9% | ~80% util (41% real render) |

Effective display ≈ 45 FPS (consecutive-change). Racing displays a repeating
3-frame cycle (game state 0→4→8); **state-4 frames are a constant framebuffer**
while states 0/8 change. 60 FPS implies fitting a full game-frame's 68K work
(~3×56k ≈ 168k cyc) into one TV frame (127,833) → **~24–32% more 68K work must
move off the 68K** (Master SH2 has the headroom).
