# Debugging & Profiling Tools — Canonical Reference

**The only supported way to get data from the running game is the libretro/PicoDrive
instrumentation**, driven by `tools/libretro-profiling/profiling_frontend`.

It is the single path that actually runs Virtua Racing on a real emulated 32X
(dual SH2 + 68K + VDP). All profiling, memory inspection, framebuffer capture, and
watchpoint features live in the PicoDrive core at
`third_party/picodrive/platform/libretro/libretro.c` (+ `pico/pico_cmn.c`,
`pico/32x/32x.c`) and are exposed through `VRD_*` environment variables.

## Quick start

```bash
cd third_party/picodrive            # build the instrumented core
make -f Makefile.libretro platform=unix -j$(nproc)
cp picodrive_libretro.so ../../tools/libretro-profiling/

cd ../../ && make all               # build the ROM
cd tools/libretro-profiling
# frame-level + PC profile of the demo/attract 3D benchmark:
VRD_PROFILE_PC=1 VRD_PROFILE_PC_LOG=pc.csv \
  ./profiling_frontend ../../build/vr_rebuild.32x 2400 --autoplay
python3 analyze_pc_profile.py pc.csv
```

See `README_68K_PC_PROFILING.md` and `README_COMM56_PROFILING.md` for details, and
the `VRD_*` env vars documented at the top of `libretro.c`.

## Real-ROM debugger

The same frontend now has a debugger mode, so debugger observations and profiler observations
execute the same PicoDrive core. CPU/game-memory inspection remains read-only:

```bash
cd tools/libretro-profiling
./profiling_frontend ../../build/vr_rebuild.32x --debug

# Reproducible minimum debugger smoke test:
./profiling_frontend ../../build/vr_rebuild.32x \
  --debug-script debugger_smoke.commands

# Exact 600-frame joypad record/replay acceptance test (from the repository root):
cd ../..
python3 -m unittest tools/libretro-profiling/test_frontend_input_recording.py -v
```

Commands include `run`, `joypad`, `record start` / `record stop`, Master/Slave `regs`,
bus-explicit `read`, `save`, `load`, `status`, and `quit`. The recorder writes a complete replay
CSV using the same `frame,mask` format as `VRD_INPUT_SCRIPT`; it refuses existing targets and
discards any file not explicitly stopped. The debugger does not yet provide CPU/game-memory
writes, breakpoints, or disassembly; track those as separate additions rather than reviving the
stub PDCORE library.

## Abandoned tools (do NOT revive — see `_archive/`)

| Tool | Why it's dead |
|------|---------------|
| `_archive/pdcore/` (`pdcore_cli`) | Custom debugger built on **stub emulation** (`bridge_stubs`) — it does **not** run the real game (`Failed to load ROM: Not implemented`). |
| `_archive/gdb_profiler.py`, `_archive/run_profiling_session.sh` | Target the **Gens** emulator's GDB stub. This project uses PicoDrive, not Gens. |

Extend debugger-grade inspection only in the libretro/PicoDrive path—that is where the real
game runs. The archived PDCORE design documents remain useful API research, not implementation
status.
