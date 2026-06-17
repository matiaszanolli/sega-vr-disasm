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
| `VRD_SCENE=hex` | Count only frames whose scene-handler word (`$FF0004`) matches — e.g. `0x4CBC` = interactive racing. **Essential**: mixing car-select/attract/menu skews the budget. |
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

## Canonical baseline — INTERACTIVE RACING only (`VRD_SCENE=0x4CBC`, 1131 frames)

> Always scene-isolate. The mixed 3D-gated average is skewed by car-select/attract/
> name-entry (which call `sh2_send_cmd` heavily and look nothing like racing).

| CPU (racing) | useful/frame | of CPU budget | notes |
|--------------|-------------|---------------|-------|
| 68K | 45,481 (36.6%) | — | **63% V-blank idle**; `sh2_send_cmd` wait negligible in racing |
| Master SH2 | 158,977 (99.7%) | ~41% | cmd $3F physics/AI/copies; ~59% free |
| Slave SH2 | 231,056 (75.3%) | ~60% | ~80% util — busiest CPU; renders every TV frame |

**Key conclusions (racing-isolated):**
- Racing is **neither compute-bound nor sync-bound**. The 68K is **63% idle** every
  frame; the `sh2_send_cmd` barrier (13% in mixed data) is a car-select/attract
  artifact, not racing → **pipeline-overlap of `sh2_send_cmd` is not the lever.**
- The cap is the **state machine: one state per V-INT, 0→4→8 = 3 TV-frames per
  game-tick.** The Slave already renders every TV frame (states 0/8 produce changing
  images; state 4 is a constant framebuffer); only the *game logic* runs at 20 Hz.
- Path to 60 FPS = **run the game logic every TV frame (Phase 7)**. Budget check:
  a full game-tick's 68K compute (~3×45,481 ≈ 136k cyc) is ~7–10% over one TV-frame
  (127,833) → needs ~10% 68K relief (finish offloading the AI-entity physics/
  collision remnants — `Physics Integration $A68C`, `AI Steering $A7B8` — to the
  ~59%-idle Master). The Slave renders every frame already, so its load is ~flat.
  The hard part is per-frame physics-constant scaling (the prior Phase 7 revert
  reason), now more tractable with physics/AI in one SH2 codebase.
