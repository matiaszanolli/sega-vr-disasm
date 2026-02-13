# CLAUDE.md

Agent briefing for Virtua Racing Deluxe 32X disassembly/reassembly project.

**Last Updated**: February 10, 2026

## Build & Test

```bash
make all          # Build 4MB ROM from disassembly
make clean        # Remove build artifacts
picodrive build/vr_rebuild.32x  # Test in emulator (PicoDrive only — BlastEm has NO 32X support)
```

Build produces `build/vr_rebuild.32x`. Binary compatibility with the original ROM is no longer maintained — the codebase is now actively modified for optimization and correctness.

## Ground Rules — STRICTLY ENFORCED

1. **Do Not Guess** — Use `docs/` (hardware manuals) and `analysis/` (architecture). Research first.
2. **Understand Before Modifying** — Never patch `dc.w` without understanding it. Disassemble and document first.
3. **Use Available Tools** — Profiler at `tools/libretro-profiling/`, disassemblers `tools/m68k_disasm.py` and `tools/sh2_disasm.py`. Measure, don't assume.
4. **Proper Assembly** — Modify assembly source, not raw binary. Convert `dc.w` to mnemonics when possible (see [KNOWN_ISSUES.md](KNOWN_ISSUES.md) for SH2 exceptions).
5. **Clean Commits** — No stale comments, no partial changes. Revert completely if something doesn't work.
6. **Verify Changes** — `make clean && make all` after every modification. Confirm build succeeds.
7. **DRY** — Never create duplicate files. Fix in place. Use git branches for experiments.

## Architecture

**Approach:** Full ROM rebuild from disassembly (NOT code injection).
**Workflow:** Edit sources in `disasm/sections/` or `disasm/modules/` → `make all` → test.

### ROM Layout

```
$000000-$2FFFFF  3.0 MB  Original game (68K + SH2)
$300000-$3FFFFF  1.0 MB  SH2 expansion space (~1KB used, 99.9% free)
```

### Build Pipeline

```
disasm/vrd.asm (entry point)
  → disasm/sections/*.asm (header + vectors + 12 code sections + data + SH2 + expansion)
    → disasm/modules/68k/*/*.asm (693 functions across 17 categories + 15 game subcategories)
    → disasm/sh2/generated/*.inc (78 SH2 function includes)
  → build/vr_rebuild.32x (4MB ROM)
```

### Key Stats

- **693 68K functions** modularized (571 translated to mnemonics, 122 still dc.w)
- **77 SH2 functions** integrated (15 blocked by assembler padding — see [KNOWN_ISSUES.md](KNOWN_ISSUES.md))
- **68K is THE bottleneck** — 100% utilization, ~60% wasted polling COMM registers
- **Master SH2**: 0-36% util. **Slave SH2**: 78% util. **Baseline FPS**: ~20-24

### Critical Constraint: Expansion ROM ($300000+)

- Executed by **SH2 only**, not 68K
- Must use `dc.w` format (raw SH2 opcodes), NEVER 68K mnemonics
- 68K machine code = invalid SH2 instructions = boot failure
- Implementation: [disasm/sections/expansion_300000.asm](disasm/sections/expansion_300000.asm)

### ROM Address Mapping

- **68000**: `cpu_addr = file_offset + 0x00880000`
- **SH2**: `cpu_addr = file_offset + 0x02000000`

## Where to Look

| Question | File |
|----------|------|
| What to work on next | [BACKLOG.md](BACKLOG.md) |
| Known pitfalls and bugs | [KNOWN_ISSUES.md](KNOWN_ISSUES.md) |
| Strategic optimization roadmap | [OPTIMIZATION_PLAN.md](OPTIMIZATION_PLAN.md) |
| Hardware reference (start here) | [docs/development-guide.md](docs/development-guide.md) |
| Complete hardware manual | [docs/32x-hardware-manual.md](docs/32x-hardware-manual.md) |
| SH2 instruction set + opcode map | [docs/sh1-sh2-cpu-core-architecture.md](docs/sh1-sh2-cpu-core-architecture.md) |
| 68K instruction set + opcode map | [docs/motorola-68000-programmers-reference.md](docs/motorola-68000-programmers-reference.md) |
| SH7604 CPU datasheet (600+ pp) | [docs/sh7604-hardware-manual.md](docs/sh7604-hardware-manual.md) |
| All documentation index | [docs/DOCUMENTATION_INDEX.md](docs/DOCUMENTATION_INDEX.md) |
| 68K function catalog (503+) | [analysis/68K_FUNCTION_REFERENCE.md](analysis/68K_FUNCTION_REFERENCE.md) |
| 68K↔SH2 communication | [analysis/68K_SH2_COMMUNICATION.md](analysis/68K_SH2_COMMUNICATION.md) |
| Register reference + hazards | [analysis/architecture/32X_REGISTERS.md](analysis/architecture/32X_REGISTERS.md) |
| Master SH2 dispatch + COMM7 design | [analysis/architecture/MASTER_SH2_DISPATCH_ANALYSIS.md](analysis/architecture/MASTER_SH2_DISPATCH_ANALYSIS.md) |
| Bottleneck root cause | [analysis/ARCHITECTURAL_BOTTLENECK_ANALYSIS.md](analysis/ARCHITECTURAL_BOTTLENECK_ANALYSIS.md) |
| SH2 3D pipeline | [analysis/sh2-analysis/SH2_3D_PIPELINE_ARCHITECTURE.md](analysis/sh2-analysis/SH2_3D_PIPELINE_ARCHITECTURE.md) |
| SH2 translation guide | [analysis/sh2-analysis/SH2_TRANSLATION_INTEGRATION.md](analysis/sh2-analysis/SH2_TRANSLATION_INTEGRATION.md) |
| Profiling how-to | [tools/libretro-profiling/README_68K_PC_PROFILING.md](tools/libretro-profiling/README_68K_PC_PROFILING.md) |

## Module Categories

68K modules live in `disasm/modules/68k/<category>/`:

| Category | Purpose |
|----------|---------|
| boot | Initialization, adapter init |
| display | Display list, screen rendering |
| frame | Frame management |
| game | Game logic (674 functions, all documented and organized into subcategories) |
| graphics | Graphics primitives |
| hardware-regs | Hardware register access |
| input | Controller I/O |
| main-loop | V-INT handler, main loop |
| math | Trigonometry, fixed-point arithmetic |
| memory | Memory management |
| object | Object system |
| optimization | FPS counter, performance hooks |
| sh2 | SH2 communication (command submission) |
| sound | Sound driver interface |
| util | Utility functions |
| vdp | VDP register access |
| vint | V-INT sub-handlers |

### Game Subcategories

Game modules in `disasm/modules/68k/game/<subcategory>/`:

| Subcategory | Count | Purpose |
|-------------|-------|---------|
| ai | 25 | AI behavior, steering, opponent logic |
| camera | 29 | Camera setup, positioning, scrolling |
| collision | 23 | Collision detection, proximity checks |
| data | 16 | Decompression, lookup tables |
| entity | 34 | Entity/object management, spawning |
| hud | 28 | HUD, score display, digit rendering |
| menu | 115 | Menu, name entry, mode selection, UI |
| physics | 50 | Speed, acceleration, braking, tilt |
| race | 50 | Race state, lap tracking, sound triggers |
| render | 80 | Visibility, depth sort, VDP, DMA, sprites |
| scene | 52 | Scene init, SH2 communication, transitions |
| sound | 67 | FM/PSG sound driver functions |
| state | 101 | State dispatchers, counters, flags, timers |
| track | 4 | Track data, segment operations |

## Profiling Quick Start

```bash
cd tools/libretro-profiling
./profiling_frontend ../../build/vr_rebuild.32x 1800 --autoplay   # 30 seconds
VRD_PROFILE_PC=1 VRD_PROFILE_PC_LOG=profile.csv \
  ./profiling_frontend ../../build/vr_rebuild.32x 2400 --autoplay  # PC hotspots
python3 analyze_pc_profile.py profile.csv
```

**Baseline measurements** (January 2026):

| CPU | Cycles/Frame | Utilization |
|-----|-------------|-------------|
| 68K | 127,987 | 100.1% (bottleneck) |
| Master SH2 | 60-139,568 | 0-36% |
| Slave SH2 | 299,958 | 78.3% |
