# Virtua Racing Deluxe (32X) - Performance Optimization Project

**Status: v6.3.0 — Full Codebase Translation & Active Optimization**

A complete, buildable disassembly of Virtua Racing Deluxe for the Sega 32X, now actively optimized to make full use of the 32X hardware. The original game runs at ~20 FPS due to a conservative blocking synchronization model that leaves significant hardware capacity untapped. This project aims to unlock that potential.

> **Looking for the unmodified disassembly?** The byte-identical original code is preserved in the [`v5.0-freeze`](../../tree/v5.0-freeze) branch.

## The Problem

The original game leaves most of its hardware idle:

```
CPU Utilization (profiled):
  68000:       ████████████████████ 100%   ← Saturated (bottleneck)
  Master SH2:  ░░░░░░░░░░░░░░░░░░░░   0%   ← Completely idle
  Slave SH2:   ██████░░░░░░░░░░░░░░  33%   ← 67% wasted in idle loop
```

The 68K spends **~60% of its cycles blocked**, polling COMM registers while waiting for SH2 acknowledgment — 35 times per frame. Meanwhile, the Master SH2 does nothing and the Slave SH2 wastes two-thirds of its time in a delay loop.

## The Goal

Restructure the command pipeline to eliminate blocking waits, batch commands, and distribute work across all three CPUs:

| Track | Strategy | Expected Gain |
|-------|----------|---------------|
| 68K Blocking Relief | Async commands via SH2 interrupt queue | +46-67% FPS |
| Command Batching | Reduce 35 submissions/frame to ~3 | +10-20% FPS |
| Pipeline Overlap | Build frame N+1 while SH2 renders frame N | +15-30% FPS |
| 68K Work Offload | Move physics/trig to idle Master SH2 | +5-15% FPS |

**Target: 60 FPS** (from ~20-24 FPS baseline)

See [OPTIMIZATION_PLAN.md](OPTIMIZATION_PLAN.md) for the full strategy and [BACKLOG.md](BACKLOG.md) for the task queue.

## Quick Start

```bash
# Build the ROM
make all

# Test in emulator (PicoDrive only — BlastEm has no 32X support)
picodrive build/vr_rebuild.32x
```

## Project Structure

```
32x-playground/
├── disasm/
│   ├── vrd.asm                    # Main build file
│   ├── sections/                  # Buildable section sources
│   ├── modules/
│   │   ├── 68k/                   # 821 modularized 68K modules (17 categories + 15 game subcats)
│   │   └── shared/definitions.asm # Master symbol table (all HW register equates)
│   ├── sh2/                       # SH2 functions + expansion code
│   │   ├── 3d_engine/             # 92 SH2 3D pipeline functions
│   │   ├── generated/             # 86 SH2 function includes
│   │   └── expansion/             # SH2 expansion ROM code ($300000+)
│   └── sh2_symbols.inc            # 107 SH2 function symbols
│
├── analysis/                      # Reverse engineering & optimization research
│   ├── ARCHITECTURAL_BOTTLENECK_ANALYSIS.md
│   ├── 68K_FUNCTION_REFERENCE.md  # 503+ named functions
│   ├── profiling/                 # CPU profiling results
│   ├── optimization/              # Optimization designs & research
│   └── architecture/              # Memory maps, state machines, registers
│
├── docs/                          # Hardware manuals & guides (markdown)
│
├── tools/
│   ├── libretro-profiling/        # Custom PicoDrive profiler (cycle-accurate)
│   ├── translate_68k_modules.py   # Batch dc.w→mnemonic translator (Phase 1+2)
│   ├── m68k_disasm.py             # 68K disassembler
│   └── sh2_disasm.py              # SH2 disassembler
│
└── build/
    └── vr_rebuild.32x             # Output ROM (4MB)
```

## ROM Layout

```
Address Range    Size      Contents
──────────────────────────────────────────
$000000-$2FFFFF  3.0 MB    Game Code (68K + SH2)
$300000-$3FFFFF  1.0 MB    SH2 Expansion Space (~99% free)
──────────────────────────────────────────
Total            4.0 MB    Full Cartridge
```

The expansion space at $300000+ is executed by SH2 processors only and already contains parallel processing infrastructure (dispatch hooks, optimized vertex transforms, work wrappers) — ready for activation.

## Codebase Status

### Disassembly & Translation (v6.3.0 — current)
- **821 68K modules** organized across 17 categories + 15 game subcategories
- **736 modules** fully translated to proper assembly mnemonics (5679 dc.w lines converted)
- **92 SH2 functions** integrated into build system (77 groups via .inc files)
- **107 SH2 functions** mapped and symbolized
- **503+ 68K functions** named and categorized
- All translations verified **byte-identical** to original ROM
- 5 translation phases: automated (Phases 1-2), manual branches (Phase 3), JSR/JMP (Phase 4), BCD arithmetic (Phase 5)
- Remaining ~522 dc.w are data values (sprite descriptors, pointer tables, lookups) — translation complete

### Symbolic Hardening (v5.1.0 — complete)
- **118+ modules** hardened with symbolic register names across all 17 categories
- Centralized [definitions.asm](disasm/modules/shared/definitions.asm) with MARS/COMM/VDP/Z80/PSG equates
- Raw hex like `$00A15120` replaced with self-documenting `COMM0_HI` throughout

### Profiling (operational)
- Custom PicoDrive libretro core with cycle-accurate instrumentation
- Frame-level and PC-level hotspot analysis
- Automated headless profiling frontend

### Optimization (active development)
- 68K bottleneck identified and quantified (100.1% utilization)
- SH2 interrupt queue designed (Path B — uses idle Master SH2)
- Batch command protocol designed
- v4.0 parallel processing infrastructure built (not yet activated)
- Task tracking in [BACKLOG.md](BACKLOG.md), pitfalls in [KNOWN_ISSUES.md](KNOWN_ISSUES.md)

## Key Architectural Findings

| Finding | Evidence |
|---------|----------|
| 68K is the sole bottleneck | 100.1% utilization, 127,987 cycles/frame |
| SH2 optimization alone yields 0% FPS gain | 66.6% Slave reduction → unchanged FPS |
| ~60% of 68K time is wasted polling | 35 blocking handshakes per frame |
| Master SH2 is completely idle | 60 cycles/frame (0.0% utilization) |
| Slave wastes 66.5% of cycles | Idle delay loop at $0600060A |

## Custom Profiler

A cycle-accurate profiling system built on PicoDrive's libretro core — the **only working 32X profiler** with per-CPU cycle counting and PC-level hotspot analysis.

```bash
cd tools/libretro-profiling

# Frame-level profiling (1800 frames)
./profiling_frontend ../../build/vr_rebuild.32x 1800 --autoplay

# PC-level hotspot profiling
VRD_PROFILE_PC=1 VRD_PROFILE_PC_LOG=profile.csv \
./profiling_frontend ../../build/vr_rebuild.32x 2400 --autoplay
python3 analyze_pc_profile.py profile.csv
```

## Documentation

| Category | Key Documents |
|----------|---------------|
| **Task Queue** | [BACKLOG.md](BACKLOG.md) (prioritized work items) |
| **Known Pitfalls** | [KNOWN_ISSUES.md](KNOWN_ISSUES.md) (hardware hazards, translation issues) |
| **Optimization Plan** | [OPTIMIZATION_PLAN.md](OPTIMIZATION_PLAN.md) (strategy & rationale) |
| **Bottleneck Analysis** | [ARCHITECTURAL_BOTTLENECK_ANALYSIS.md](analysis/ARCHITECTURAL_BOTTLENECK_ANALYSIS.md) |
| **68K Profiling** | [68K_BOTTLENECK_ANALYSIS.md](analysis/profiling/68K_BOTTLENECK_ANALYSIS.md) |
| **Async Design** | [ASYNC_COMMAND_IMPLEMENTATION_PLAN.md](analysis/optimization/ASYNC_COMMAND_IMPLEMENTATION_PLAN.md) |
| **68K Functions** | [68K_FUNCTION_REFERENCE.md](analysis/68K_FUNCTION_REFERENCE.md) (503+ functions) |
| **SH2 3D Pipeline** | [SH2_3D_PIPELINE_ARCHITECTURE.md](analysis/sh2-analysis/SH2_3D_PIPELINE_ARCHITECTURE.md) |
| **Communication** | [68K_SH2_COMMUNICATION.md](analysis/68K_SH2_COMMUNICATION.md) |
| **Hardware Manual** | [32x-hardware-manual.md](docs/32x-hardware-manual.md) |
| **Register Hazards** | [32X_REGISTERS.md](analysis/architecture/32X_REGISTERS.md) |

## Requirements

- Python 3.x
- GCC and Make (for vasm)
- Unix-like environment (Linux, macOS, WSL)

### ROM (NOT INCLUDED)
You must provide your own legal ROM dump:
- File: `Virtua Racing Deluxe (USA).32x` (in `roms/` directory)
- Size: 3,145,728 bytes (original)
- MD5: `72b1ad0f949f68da7d0a6339ecd51a3f`

## Technical Details

| Component | Details |
|-----------|---------|
| Platform | Sega 32X (Mega Drive add-on) |
| 68000 CPU | 7.67 MHz, game logic & coordination |
| SH2 CPUs | 2x 23.01 MHz, 3D rendering |
| Z80 CPU | Sound processing |
| ROM Size | 4 MB (4,194,304 bytes) with 1MB expansion |
| Original Frame Rate | ~20 FPS (blocking sync bottleneck) |
| Target Frame Rate | 60 FPS |

## Support

If you'd like to support this project, consider becoming a patron:

[patreon.com/virtua_racing_60fps](https://patreon.com/virtua_racing_60fps)

## Credits

- **Original Game**: SEGA (1994)
- **Disassembly & Analysis**: Claude Code with human guidance
- **Tools**: vasm by Volker Barthelmann & Frank Wille
- **Profiler**: Custom PicoDrive libretro patches

## License

Reverse engineering project for educational and preservation purposes. Original game © SEGA 1994. No copyrighted content included — you must provide your own legal ROM.
