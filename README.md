**(NEW)** *Check my just completed dissassembly of **Aerobiz Supersonic** at* [https://github.com/matiaszanolli/aerobiz-disasm](https://github.com/matiaszanolli/aerobiz-disasm) 

# Virtua Racing Deluxe (32X) - Performance Optimization Project

**Status: v8.0.0 — Optimization Roadmap Reassessed (30 FPS target)**

A complete, buildable disassembly of Virtua Racing Deluxe for the Sega 32X, now actively optimized to make full use of the 32X hardware. The original game runs at ~20 FPS due to a conservative blocking synchronization model that leaves significant hardware capacity untapped. This project aims to unlock that potential.

> **Looking for the unmodified disassembly?** The byte-identical original code is preserved in the [`v5.0-freeze`](../../tree/v5.0-freeze) branch.

## The Problem

The original game leaves most of its hardware idle:

```
CPU Utilization (profiled, March 2026):
  68000:       ████████████████████ 100%   ← Saturated (bottleneck)
  Master SH2:  ░░░░░░░░░░░░░░░░░░░░   0%   ← Completely idle
  Slave SH2:   ████████████░░░░░░░░  66%   ← 34% wasted in idle loop

68K time breakdown:
  49.4%  V-blank sync polling (unavoidable frame barrier)
  10.8%  SH2 command overhead (reduced 64% by B-003/B-004/B-005)
  39.8%  Useful game logic — physics, AI, rendering prep
```

The biggest remaining lever: the 68K spends **21.7% of its useful work** polling COMM7 while waiting for the Slave SH2 to process each of 21 pixel fill entries per frame. The Master SH2 (0% utilization) can eliminate these waits entirely.

## The Goal

Offload 68K work to the idle Master SH2 via two strategies:

| Track | Strategy | Expected FPS Gain | Status |
|-------|----------|-------------------|--------|
| **A** | **cmd_27 queue via Master SH2** | **+21.7% useful work freed** | **OPEN (B-015)** |
| **B** | **Batched offload: angle/physics/trig** | **+12.3% useful work freed** | **OPEN (B-016)** |
| C | Pipeline overlap (frame N+1 during N) | Large (stretch goal) | Research only |

**Primary target: 30 FPS** — Tracks A+B together save ~34% of useful work, crossing the 3→2 TV frame threshold.
**Stretch goal: 60 FPS** — Requires Track C (pipeline overlap).

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
│   │   ├── 68k/                   # 823 modularized 68K modules (17 categories + 15 game subcats)
│   │   └── shared/definitions.asm # Master symbol table (all HW register equates)
│   ├── sh2/                       # SH2 functions + expansion code
│   │   ├── 3d_engine/             # 92 SH2 functions (descriptive names)
│   │   ├── generated/             # 89 SH2 function includes
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

### Disassembly & Translation (v7.0.0 — current)
- **823 68K modules** organized across 17 categories + 15 game subcategories
- **736 modules** fully translated to proper assembly mnemonics (5679 dc.w lines converted)
- **92 SH2 functions** with descriptive names (`matrix_multiply`, `frustum_cull`, `span_filler`, etc.)
- **107 SH2 entry points** mapped and symbolized across 89 .inc groups + 12 expansion
- **806 functions** documented in [MASTER_FUNCTION_REFERENCE.md](analysis/MASTER_FUNCTION_REFERENCE.md)
- All translations verified **byte-identical** to original ROM
- 5 translation phases: automated (Phases 1-2), manual branches (Phase 3), JSR/JMP (Phase 4), BCD arithmetic (Phase 5)
- Remaining ~522 dc.w are data values (sprite descriptors, pointer tables, lookups) — translation complete
- 3D engine algorithmically analyzed: flat shading, Bresenham edge interpolation, bounding box visibility

### Symbolic Hardening (v5.1.0 — complete)
- **118+ modules** hardened with symbolic register names across all 17 categories
- Centralized [definitions.asm](disasm/modules/shared/definitions.asm) with MARS/COMM/VDP/Z80/PSG equates
- Raw hex like `$00A15120` replaced with self-documenting `COMM0_HI` throughout

### Profiling (operational)
- Custom PicoDrive libretro core with cycle-accurate instrumentation
- Frame-level and PC-level hotspot analysis
- Automated headless profiling frontend

### Optimization (B-003/B-004/B-005 complete)
- 68K bottleneck identified and quantified (100.1% utilization)
- **B-003:** sh2_cmd_27 → fire-and-forget via COMM7 doorbell (21 calls/frame, ~50 cycles each)
- **B-004:** sh2_send_cmd → single-shot cmd $22 (14 calls/frame, ~170 cycles each)
- **B-005:** sh2_send_cmd_wait → single-shot cmd $25 (8 calls/scene init, ~100 cycles each)
- Per-frame command overhead reduced 64% (~9,450 → ~3,430 cycles)
- Task tracking in [BACKLOG.md](BACKLOG.md), pitfalls in [KNOWN_ISSUES.md](KNOWN_ISSUES.md)

## Key Architectural Findings

| Finding | Evidence |
|---------|----------|
| 68K is the sole bottleneck | 100.1% utilization, 127,987 cycles/frame |
| SH2 optimization alone yields 0% FPS gain | 66.6% Slave reduction → unchanged FPS |
| 49.4% of 68K time is V-blank sync | PC profiling March 2026 — unavoidable frame barrier |
| 21.7% of useful work is cmd_27 COMM7 waits | Biggest remaining lever (Track A target) |
| Command overhead reduced 64% | B-003/B-004/B-005: ~12,000 → ~3,850 cycles/frame |
| Master SH2 is completely idle | 0 cycles/frame with hooks disabled (0.0% utilization) |
| 30 FPS achievable via Tracks A+B | -21.7% (cmd_27 queue) + -12.3% (batched offload) = -34% useful work |

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
| **COMM Protocol** | [68K_SH2_COMMUNICATION.md](analysis/68K_SH2_COMMUNICATION.md) (B-003/B-004/B-005 protocols) |
| **All Functions** | [MASTER_FUNCTION_REFERENCE.md](analysis/MASTER_FUNCTION_REFERENCE.md) (806 entries, auto-generated) |
| **SH2 3D Pipeline** | [SH2_3D_PIPELINE_ARCHITECTURE.md](analysis/sh2-analysis/SH2_3D_PIPELINE_ARCHITECTURE.md) |
| **3D Engine Deep Dive** | [SH2_3D_ENGINE_DEEP_DIVE.md](analysis/sh2-analysis/SH2_3D_ENGINE_DEEP_DIVE.md) (algorithmic analysis) |
| **Rendering Pipeline** | [RENDERING_PIPELINE.md](analysis/RENDERING_PIPELINE.md) (end-to-end V-INT → VDP) |
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
| Primary Target | 30 FPS (Tracks A+B: cmd_27 queue + batched offload) |
| Stretch Goal | 60 FPS (Track C: pipeline overlap) |

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
