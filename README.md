**(NEW)** *Check my just completed dissassembly of **Aerobiz Supersonic** at* [https://github.com/matiaszanolli/aerobiz-disasm](https://github.com/matiaszanolli/aerobiz-disasm)

# Virtua Racing Deluxe (32X) — Full Disassembly & 60 FPS Research

**Status (2026-07-21): buildable reconstruction; 60 Hz redesign in integration and validation**

A complete, buildable reconstruction of Virtua Racing Deluxe for the Sega 32X, with the original 68000 and SH2 code translated and organized for continued reverse engineering. The active branch is investigating a true 60 Hz redesign, but it does **not** currently have a validated 60 FPS—or validated 40 FPS—1-player result.

> **Looking for the unmodified disassembly?** The byte-identical original code is preserved in the [`v5.0-freeze`](../../tree/v5.0-freeze) branch.

## Current State (July 2026)

The original 68000 physics, AI, collision, and render-preparation path remains authoritative in normal 1-player racing. A valid 1P state-8 hook is installed and cmd `$3E` player/global staging is enabled, but its previous long-run framebuffer-hash validation was invalidated by a savestate that freezes independently of the VR60 code.

| Component | Current 1P status |
|---|---|
| `state_disp_004cb8` / `game_frame_orch_013` hook | Active; exact trace confirms about 20 Hz |
| cmd `$3E` entity + globals transfer | Enabled; needs a trustworthy full-run revalidation |
| cmd `$3E` AI transfer | Disabled; unverified |
| cmd `$3F` SH2 physics/AI game-frame path | Built but disabled in 1P |
| SH2 collision | Built and reference-tested, not wired |
| SH2-to-render bridge | Not established; old patcher is a verified no-op |
| 68000 physics bypass | Disabled; legacy path remains authoritative |
| Current display/game rate | No accepted branch-wide FPS result yet |

See [VR60_STATUS.md](VR60_STATUS.md) for the canonical status, acceptance definition, and immediate validation gate. The detailed investigation history remains in [VR60_ROADMAP.md](VR60_ROADMAP.md).

### What is solid

- The unmodified `v5.0-freeze` baseline remains byte-identical to the original ROM.
- The buildable disassembly/reconstruction covers the game ROM, SH2 programs, data, and the branch's expansion-ROM work.
- 1P and 2P racing dispatch are now distinguished correctly: `state_disp_004cb8` is the normal 1P route; `state_disp_005020` is the 2P split-screen route.
- The 1P state-8 hook point was confirmed with exact caller tracing, avoiding the earlier truncated-histogram false negative.
- SH2 physics, AI, and collision ports exist, but their presence in the ROM is no longer presented as proof that they execute or control gameplay.
- The per-frame Slave renderer consumes the C128/C178/C254 descriptor families; the older C218 bridge target was wrong.

### Next milestone

Establish a clean, repeatable 1P fixture in which `$C87E` keeps cycling for the entire run with the VR60 hook bypassed. Then re-enable and observe one stage at a time: cmd `$3E` modes 0/1, AI transfer, cmd `$3F` in shadow mode, the real render bridge, and finally subsystem authority changes. Logic-cadence and fixed-step scaling work comes only after that integration is correct.

## How It Works

### 68K Game Architecture

The game uses a **two-level dispatch** system:

1. **Scene handler** (`$FF0002`) — Self-modifying main loop calls a handler pointer each frame. Changing it switches game modes (loading, display init, racing, menus). Over 20 distinct handlers manage the full lifecycle from boot through racing to results.

2. **State dispatcher** (`$C87E`) — Within each scene handler, a sub-dispatcher indexes a jump table by game state. States advance by 4 each frame; state 8 runs the full game frame. The V-INT frame swap handler resets `$C87E` to 0 when the SH2 signals "render done" via COMM1.

3. **V-INT dispatch** (`$C87A`) — Each state handler writes a V-INT state that controls which VBlank handler runs. 16+ entries handle everything from minimal VDP reads to full frame buffer swaps with palette DMA.

### Dual SH2 Architecture

Master and Slave SH2 have **completely independent dispatch loops** polling different COMM registers:

| CPU | Polls | Role | Profiling status |
|-----|-------|------|-------------|
| **Master** | COMM0_HI | Game commands: block copies, scene init, DMA | Re-profile after the validation gate |
| **Slave** | COMM2_HI | **ALL 3D rendering** via dual pipeline | Re-profile after the validation gate |

No direct cross-trigger. The 68K submits to each independently. COMM7 is an async doorbell for pixel work.

**Slave rendering pipeline:**
- **Pipeline 1:** On-chip SRAM ($C0000000, 1748 bytes). Self-contained, zero wait states, 36 entities/frame. Untouchable.
- **Pipeline 2:** SDRAM cache. Historical profiles identified coord transform, frustum cull,
  and span filling as hotspots; current percentages require a fresh baseline.

### Historical Camera-Interpolation Experiment (A-1)

The March 2026 work attempted to decouple display cadence from the 20 Hz game tick using the following sequence. It is retained as design history, not as the current branch's validated 1P status: the hook was placed in `state_disp_005020`, now known to be the 2-player dispatcher.

```
State 0 (TV1): Snapshot camera → DMA to SH2 → SH2 renders frame A
State 4 (TV2): Block-copy A → swap → interpolate camera → re-DMA → SH2 renders frame B
State 8 (TV3): Existing swap displays frame B
Intended result: 2 swaps / 3 TV frames = 40 FPS display, 20 FPS game logic
```

## Quick Start

```bash
# Build the ROM
make all

# Test in emulator (PicoDrive only — BlastEm has no 32X support)
picodrive build/vr_rebuild.32x

# Generic headless smoke only; --autoplay parks in scene $5586 and is NOT 1P GP acceptance
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
│   ├── MASTER_FUNCTION_REFERENCE.md      # complete named-entry catalog (auto-generated)
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
$300000-$3FFFFF  1.0 MB    SH2 Expansion Space (~15KB used by code/data)
──────────────────────────────────────────
Total            4.0 MB    Full Cartridge
```

The expansion space contains optimized SH2 handlers, command-protocol work, VR60
physics/AI/collision ports, and diagnostic infrastructure. Most VR60 modules are built but
dormant in normal 1P.

## Key Architectural Findings

| Finding | Evidence | Impact |
|---------|----------|--------|
| 1P state-8 hook is real | Exact caller trace, approximately once per 3 TV frames | Valid integration point for staged experiments |
| 2P and 1P use different dispatchers | Static routing plus live `$FF0002` watches | Results from `state_disp_005020` cannot be claimed for normal 1P |
| Historical profiling needs re-baselining | cmd `$3F` was not active in the measured 1P route; current savestate later freezes independently | Do not reuse old CPU/FPS attribution as a current baseline |
| $C8A8 = $0102 always (cmd $02) | Verified fall-through analysis | Per-frame DMA is always scene orchestrator |
| Racing descriptor inputs are C128/C178/C254 families | Decoded cmd `$02` handler literal pool and entity loop | C218 bridge specification is superseded |
| On-chip SRAM pipeline is untouchable | 1748B, zero external calls | Only Pipeline 2 (SDRAM) is optimizable |
| Master SH2 offload code is not yet authoritative | cmd `$3F` disabled in 1P; 68000 bypass disabled | Prove data ownership and render consumption before cadence changes |

## Documentation

### Architecture (start here)
| Document | What It Covers |
|----------|---------------|
| [SCENE_HANDLER_ARCHITECTURE.md](analysis/SCENE_HANDLER_ARCHITECTURE.md) | 68K scene dispatch, handler chain, $C8A8 lifecycle, Phase B crash analysis |
| [VINT_HANDLER_ARCHITECTURE.md](analysis/VINT_HANDLER_ARCHITECTURE.md) | V-INT dispatch table (16+ entries), frame swap mechanism, R-002 60 FPS design |
| [SLAVE_SH2_DISPATCH_ARCHITECTURE.md](analysis/SLAVE_SH2_DISPATCH_ARCHITECTURE.md) | Dual SH2 dispatch, Slave command routing, pipeline sequencing |
| [GAME_MODE_TRANSITIONS.md](analysis/GAME_MODE_TRANSITIONS.md) | Boot→menu→racing flow, $C8A8 correction, historical interpolation cautions |
| [SH2_COMMAND_HANDLER_REFERENCE.md](analysis/sh2-analysis/SH2_COMMAND_HANDLER_REFERENCE.md) | All 7 Master SH2 command handlers decoded |
| [SYSTEM_EXECUTION_FLOW.md](analysis/SYSTEM_EXECUTION_FLOW.md) | Per-frame execution with cycle budgets |
| [RENDERING_PIPELINE.md](analysis/RENDERING_PIPELINE.md) | End-to-end rendering flow |

### Engine Internals
| Document | What It Covers |
|----------|---------------|
| [SH2_3D_ENGINE_DEEP_DIVE.md](analysis/sh2-analysis/SH2_3D_ENGINE_DEEP_DIVE.md) | 3D algorithms: frustum cull, span filler, coord transform |
| [SH2_RENDERING_ARCHITECTURE.md](analysis/sh2-analysis/SH2_RENDERING_ARCHITECTURE.md) | Dual pipeline (SRAM + SDRAM), entity batching |
| [MASTER_FUNCTION_REFERENCE.md](analysis/MASTER_FUNCTION_REFERENCE.md) | Complete named-entry catalog (auto-generated; current count in file) |
| [68K_SH2_COMMUNICATION.md](analysis/68K_SH2_COMMUNICATION.md) | COMM protocol, B-003/B-004/B-005 designs |
| [COMM_REGISTERS_HARDWARE_ANALYSIS.md](analysis/COMM_REGISTERS_HARDWARE_ANALYSIS.md) | Hardware hazards, handshake patterns |

### Game Logic
| Document | What It Covers |
|----------|---------------|
| [ENTITY_OBJECT_ARCHITECTURE.md](analysis/ENTITY_OBJECT_ARCHITECTURE.md) | 4 object tables, 256B records, dual-layer 68K↔SH2, 20-sub pipeline |
| [PHYSICS_SYSTEM_ARCHITECTURE.md](analysis/PHYSICS_SYSTEM_ARCHITECTURE.md) | 9-step pipeline, 8.8 grip, 7-gear transmission, speed tables |
| [AI_SYSTEM_ARCHITECTURE.md](analysis/AI_SYSTEM_ARCHITECTURE.md) | 15-state machine, 3-band collision avoidance, Manhattan distance |
| [COLLISION_SYSTEM_ARCHITECTURE.md](analysis/COLLISION_SYSTEM_ARCHITECTURE.md) | Binary search track boundary, 4-probe system, EMA surface tracking |
| [SOUND_DRIVER_ARCHITECTURE.md](analysis/SOUND_DRIVER_ARCHITECTURE.md) | 68K FM/PSG sequencer, Z80 DAC, 18 channels, 3-priority commands |
| [TRACK_DATA_FORMAT.md](analysis/TRACK_DATA_FORMAT.md) | Segmented spline, 4-page geometry, segment index computation |
| [MEMORY_MANAGEMENT_ARCHITECTURE.md](analysis/MEMORY_MANAGEMENT_ARCHITECTURE.md) | Static WRAM layout, JSR-cascade copy primitives, PRNG |

### Project Management
| Document | What It Covers |
|----------|---------------|
| [BACKLOG.md](BACKLOG.md) | Prioritized task queue |
| [VR60_STATUS.md](VR60_STATUS.md) | Canonical current status and validation gate |
| [KNOWN_ISSUES.md](KNOWN_ISSUES.md) | Pitfalls, hardware hazards, abandoned approaches |
| [OPTIMIZATION_PLAN.md](OPTIMIZATION_PLAN.md) | Archived March 2026 strategy and experiment history |
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
| Master SH2 | 23.01 MHz — command dispatch and block copies; current budget pending re-profile |
| Slave SH2 | 23.01 MHz — all 3D rendering through dual pipelines; current budget pending re-profile |
| Z80 CPU | Sound processing |
| ROM Size | 4 MB with 1 MB expansion space |
| Original FPS | ~20 (dispatcher cadence and conservative scheduling) |
| Current FPS | **Not yet accepted for this branch**; original logic cadence is ~20 Hz |
| Next Target | **Validated 1P baseline and staged SH2 integration**, then true 60 Hz logic/display |

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
