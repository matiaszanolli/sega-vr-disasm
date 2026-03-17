**(NEW)** *Check my just completed dissassembly of **Aerobiz Supersonic** at* [https://github.com/matiaszanolli/aerobiz-disasm](https://github.com/matiaszanolli/aerobiz-disasm)

# Virtua Racing Deluxe (32X) — Full Disassembly & 60 FPS Optimization

**Status: 40 FPS achieved, 60 FPS one blocker away**

A complete, buildable disassembly of Virtua Racing Deluxe for the Sega 32X with deep architectural understanding of the game's internals — now actively optimized to push the hardware to its limits. The original game runs at ~20 FPS; this project has doubled that to 40 FPS via camera interpolation and is one hardware constraint away from 60 FPS.

> **Looking for the unmodified disassembly?** The byte-identical original code is preserved in the [`v5.0-freeze`](../../tree/v5.0-freeze) branch.

## Current State (March 2026)

```
Display FPS:  ~40  (camera interpolation, stable frame pacing)
Game logic:    20 FPS (unchanged — physics, AI, collision at original speed)
Next target:   60 FPS (1 hardware blocker remaining)

CPU Utilization (40 FPS, profiled):
  68000:       █████████░░░░░░░░░░░  48%   ← Idle 52% (STOP #$2300)
  Master SH2:  ██████░░░░░░░░░░░░░░  0-36% ← Command router + block copies
  Slave SH2:   ██████████████░░░░░░  73%   ← ALL 3D rendering (bottleneck)
```

### What's Working

- **40 FPS display** via camera interpolation — game logic at 20 FPS, display at 40 FPS by rendering 2 interpolated camera frames per game tick. Zero physics changes.
- **Complete architectural understanding** — 68K scene handlers, V-INT dispatch, dual SH2 dispatch, COMM protocol, rendering pipeline, all documented
- **SH2 coord_transform inlined** (S-6) — ~5% Slave reduction, 4 call sites relocated to expansion ROM
- **Command protocol optimized** (B-003/B-004/B-005) — 64% overhead reduction
- **823 68K modules** fully organized, 736 translated to mnemonics
- **All 92 SH2 functions** integrated and documented

### What's Next: 60 FPS

**One blocker remains:** Frame buffer swap (FS bit) writes outside VBlank are deferred by hardware. A swap-only V-INT handler (~30 bytes) is needed to perform FS toggles during VBlank for the interpolated frames. The V-INT dispatch table has 4 unused slots available. Design is ready in [VINT_HANDLER_ARCHITECTURE.md](analysis/VINT_HANDLER_ARCHITECTURE.md) §6.

## How It Works

### 68K Game Architecture

The game uses a **two-level dispatch** system:

1. **Scene handler** (`$FF0002`) — Self-modifying main loop calls a handler pointer each frame. Changing it switches game modes (loading, display init, racing, menus). Over 20 distinct handlers manage the full lifecycle from boot through racing to results.

2. **State dispatcher** (`$C87E`) — Within each scene handler, a sub-dispatcher indexes a jump table by game state. States advance by 4 each frame; state 8 runs the full game frame. The V-INT frame swap handler resets `$C87E` to 0 when the SH2 signals "render done" via COMM1.

3. **V-INT dispatch** (`$C87A`) — Each state handler writes a V-INT state that controls which VBlank handler runs. 16+ entries handle everything from minimal VDP reads to full frame buffer swaps with palette DMA.

### Dual SH2 Architecture

Master and Slave SH2 have **completely independent dispatch loops** polling different COMM registers:

| CPU | Polls | Role | Utilization |
|-----|-------|------|-------------|
| **Master** | COMM0_HI | Game commands: block copies, scene init, DMA | 0-36% |
| **Slave** | COMM2_HI | **ALL 3D rendering** via dual pipeline | ~73% |

No direct cross-trigger. The 68K submits to each independently. COMM7 is an async doorbell for pixel work.

**Slave rendering pipeline** (the bottleneck):
- **Pipeline 1:** On-chip SRAM ($C0000000, 1748 bytes). Self-contained, zero wait states, 36 entities/frame. Untouchable.
- **Pipeline 2:** SDRAM cache. coord_transform (12%), frustum_cull (12%), span_filler (8%). This is the optimization target.

### Camera Interpolation (A-1)

```
State 0 (TV1): Snapshot camera → DMA to SH2 → SH2 renders frame A
State 4 (TV2): Block-copy A → swap → interpolate camera → re-DMA → SH2 renders frame B
State 8 (TV3): Existing swap displays frame B
Result: 2 swaps / 3 TV frames = 40 FPS display, 20 FPS game logic
```

## Quick Start

```bash
# Build the ROM
make all

# Test in emulator (PicoDrive only — BlastEm has no 32X support)
picodrive build/vr_rebuild.32x

# Profile (30 seconds, headless)
cd tools/libretro-profiling
./profiling_frontend ../../build/vr_rebuild.32x 1800 --autoplay
```

## Project Structure

```
32x-playground/
├── disasm/
│   ├── vrd.asm                    # Main build file
│   ├── sections/                  # Buildable section sources (12 code + data + SH2 + expansion)
│   ├── modules/
│   │   ├── 68k/                   # 823 modularized 68K modules (17 categories + 15 game subcats)
│   │   └── shared/definitions.asm # Master symbol table (all HW register equates)
│   ├── sh2/                       # SH2 functions + expansion code
│   │   ├── 3d_engine/             # 92 SH2 functions (descriptive names)
│   │   ├── generated/             # 89 SH2 function includes
│   │   └── expansion/             # SH2 expansion ROM code ($300000+)
│   └── sh2_symbols.inc            # 107 SH2 function symbols
│
├── analysis/                      # Reverse engineering & architecture docs
│   ├── SCENE_HANDLER_ARCHITECTURE.md     # 68K scene dispatch, $C8A8, handler chain
│   ├── VINT_HANDLER_ARCHITECTURE.md      # V-INT dispatch table, frame swap, R-002 design
│   ├── SLAVE_SH2_DISPATCH_ARCHITECTURE.md # Dual SH2 dispatch, pipelines
│   ├── GAME_MODE_TRANSITIONS.md          # Boot→menu→racing→results flow
│   ├── MASTER_FUNCTION_REFERENCE.md      # 799+ named functions (auto-generated)
│   ├── sh2-analysis/                     # SH2 command handlers, 3D engine, rendering
│   ├── architecture/                     # Memory maps, registers, state machines
│   └── optimization/                     # Optimization research & designs
│
├── docs/                          # Hardware manuals & guides (markdown transcriptions)
│
├── tools/
│   ├── libretro-profiling/        # Custom PicoDrive profiler (cycle-accurate)
│   ├── translate_68k_modules.py   # Batch dc.w→mnemonic translator
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
$300000-$3FFFFF  1.0 MB    SH2 Expansion Space (~2.5KB used, 99.8% free)
──────────────────────────────────────────
Total            4.0 MB    Full Cartridge
```

The expansion space contains optimized SH2 handlers: inlined coord_transform (S-6), single-shot command protocols (B-004/B-005), and async infrastructure.

## Key Architectural Findings

| Finding | Evidence | Impact |
|---------|----------|--------|
| Slave SH2 is the true bottleneck | 73% utilization, ~300K cycles/frame | All optimization must target Slave |
| 68K has 52% idle time | STOP #$2300, 48% active work | 68K is NOT the bottleneck anymore |
| Camera interpolation works | 40 FPS achieved (A-1, commit b6bd487) | Display FPS decoupled from game logic |
| $C8A8 = $0102 always (cmd $02) | Verified fall-through analysis | Per-frame DMA is always scene orchestrator |
| Entity descriptors unused during racing | 4 independent profiling tests (S-1d) | LOD culling at $0600C344 is a dead end |
| On-chip SRAM pipeline is untouchable | 1748B, zero external calls | Only Pipeline 2 (SDRAM) is optimizable |
| V-INT table has 4 unused slots | $0040, $0048, $004C, $0050 | Swap-only handler can use any of these |
| Master SH2 is underutilized | 0-36%, mostly idle | Available for vertex transform offload (S-8) |

## Documentation

### Architecture (start here)
| Document | What It Covers |
|----------|---------------|
| [SCENE_HANDLER_ARCHITECTURE.md](analysis/SCENE_HANDLER_ARCHITECTURE.md) | 68K scene dispatch, handler chain, $C8A8 lifecycle, Phase B crash analysis |
| [VINT_HANDLER_ARCHITECTURE.md](analysis/VINT_HANDLER_ARCHITECTURE.md) | V-INT dispatch table (16+ entries), frame swap mechanism, R-002 60 FPS design |
| [SLAVE_SH2_DISPATCH_ARCHITECTURE.md](analysis/SLAVE_SH2_DISPATCH_ARCHITECTURE.md) | Dual SH2 dispatch, Slave command routing, pipeline sequencing |
| [GAME_MODE_TRANSITIONS.md](analysis/GAME_MODE_TRANSITIONS.md) | Boot→menu→racing flow, $C8A8 correction, safe intervention points |
| [SH2_COMMAND_HANDLER_REFERENCE.md](analysis/sh2-analysis/SH2_COMMAND_HANDLER_REFERENCE.md) | All 7 Master SH2 command handlers decoded |
| [SYSTEM_EXECUTION_FLOW.md](analysis/SYSTEM_EXECUTION_FLOW.md) | Per-frame execution with cycle budgets |
| [RENDERING_PIPELINE.md](analysis/RENDERING_PIPELINE.md) | End-to-end rendering flow |

### Engine Internals
| Document | What It Covers |
|----------|---------------|
| [SH2_3D_ENGINE_DEEP_DIVE.md](analysis/sh2-analysis/SH2_3D_ENGINE_DEEP_DIVE.md) | 3D algorithms: frustum cull, span filler, coord transform |
| [SH2_RENDERING_ARCHITECTURE.md](analysis/sh2-analysis/SH2_RENDERING_ARCHITECTURE.md) | Dual pipeline (SRAM + SDRAM), entity batching |
| [MASTER_FUNCTION_REFERENCE.md](analysis/MASTER_FUNCTION_REFERENCE.md) | 799+ named functions (auto-generated) |
| [68K_SH2_COMMUNICATION.md](analysis/68K_SH2_COMMUNICATION.md) | COMM protocol, B-003/B-004/B-005 designs |
| [COMM_REGISTERS_HARDWARE_ANALYSIS.md](analysis/COMM_REGISTERS_HARDWARE_ANALYSIS.md) | Hardware hazards, handshake patterns |

### Project Management
| Document | What It Covers |
|----------|---------------|
| [BACKLOG.md](BACKLOG.md) | Prioritized task queue |
| [KNOWN_ISSUES.md](KNOWN_ISSUES.md) | Pitfalls, hardware hazards, abandoned approaches |
| [OPTIMIZATION_PLAN.md](OPTIMIZATION_PLAN.md) | Strategic roadmap (Phases 1-3) |
| [CLAUDE.md](CLAUDE.md) | Agent briefing, ground rules, build instructions |

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
| 68000 CPU | 7.67 MHz — game logic, scene management, SH2 coordination |
| Master SH2 | 23.01 MHz — command dispatch, block copies (0-36% util) |
| Slave SH2 | 23.01 MHz — ALL 3D rendering, dual pipeline (73% util, bottleneck) |
| Z80 CPU | Sound processing |
| ROM Size | 4 MB with 1 MB expansion space |
| Original FPS | ~20 (blocking sync, conservative design) |
| Current FPS | **~40** (camera interpolation, A-1) |
| Next Target | **60 FPS** (swap-only V-INT handler, R-002) |

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
