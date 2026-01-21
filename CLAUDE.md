# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Core Development Principles

### DRY (Don't Repeat Yourself) - STRICTLY ENFORCED

**NEVER create duplicate files, versions, or documentation.** Fix existing files in place.

**WRONG:** `tool.py`, `tool_v2.py`, `tool_v3.py`, `tool_working.py`
**RIGHT:** Fix `tool.py` directly when you find bugs

**If you need to try different approaches:**
1. Use git branches (not duplicate files)
2. Or delete the old approach when replacing it
3. Or clearly comment out old code within the same file

## Build Commands

```bash
make all          # Build the complete 4MB ROM (official cartridge size)
make compare      # Compare with original (shows byte-for-byte match)
make clean        # Remove build artifacts
make tools        # Build vasm assembler from source
make disasm       # Disassemble specific sections (68000 + SH2)
make analyze      # Analyze ROM structure
```

**Note:** VRD is officially 32 Mbit (4MB), not 3MB. See [ROM_SIZE_CLARIFICATION.md](docs/ROM_SIZE_CLARIFICATION.md) for details.

## Testing ROMs

```bash
picodrive build/vr_rebuild.32x  # Linux (recommended)
./Gens_KMod_v0.7.3/gens.exe     # Windows
```

## Repository Purpose

**Sega 32X development playground** - knowledge base and development environment for Virtua Racing Deluxe disassembly/reassembly. The 32X features:

- Two SH2 32-bit RISC CPUs (23 MHz)
- 2 Mbit SDRAM, two 1 Mbit frame buffers
- VDP with Direct Color, Packed Pixel, and Run Length modes

## Documentation

### Reference Material (`/docs`)

**Hardware Manuals:**
| Document | Contents |
|----------|----------|
| [development-guide.md](docs/development-guide.md) | **Start here** - CPU coordination, registers, pitfalls |
| [32x-hardware-manual.md](docs/32x-hardware-manual.md) | Complete hardware reference, memory maps, VDP modes |
| [32x-technical-info.md](docs/32x-technical-info.md) | 22 documented hardware bugs and workarounds |
| [sound-driver-v3.md](docs/sound-driver-v3.md) | Sound Driver V3.00 system calls |

**Development Guides:**
| Document | Contents |
|----------|----------|
| [SETUP.md](docs/SETUP.md) | Project setup from scratch |
| [ANNOTATION_FRAMEWORK.md](docs/ANNOTATION_FRAMEWORK.md) | Code annotation framework |
| [PROFILING_QUICKSTART.md](docs/PROFILING_QUICKSTART.md) | GDB-based profiling setup |
| [DISASSEMBLY_ANNOTATION_GUIDE.md](docs/DISASSEMBLY_ANNOTATION_GUIDE.md) | Disassembly annotation guide |

### Technical Analysis (`/analysis`)

**Key Architecture Documents:**
| Document | Contents |
|----------|----------|
| [ARCHITECTURAL_BOTTLENECK_ANALYSIS.md](analysis/ARCHITECTURAL_BOTTLENECK_ANALYSIS.md) | **Root cause** - Blocking sync model causes ~20 FPS ceiling |
| [68K_FUNCTION_REFERENCE.md](analysis/68K_FUNCTION_REFERENCE.md) | 503+ named 68K functions by category |
| [68K_SH2_CROSS_REFERENCE.md](analysis/68K_SH2_CROSS_REFERENCE.md) | Communication protocol between processors |
| [DATA_STRUCTURES.md](analysis/DATA_STRUCTURES.md) | Memory maps, object tables, structures |
| [STATE_MACHINES.md](analysis/STATE_MACHINES.md) | V-INT handler and game state machines |
| [SH2_3D_PIPELINE_ARCHITECTURE.md](analysis/SH2_3D_PIPELINE_ARCHITECTURE.md) | SH2 3D rendering engine |

**Subdirectories:**
- `analysis/68k-reverse-engineering/` - 68K code analysis
- `analysis/sh2-analysis/` - SH2 code analysis
- `analysis/debugger-design/` - Debugger research
- `analysis/profiling/` - Profiling guides and results
- `analysis/optimization/` - Optimization research

### Strategic Planning (`root level`)

| Document | Contents |
|----------|----------|
| [OPTIMIZATION_PLAN.md](OPTIMIZATION_PLAN.md) | Strategic roadmap to reach 60 FPS |

### Archived (`_archive`)

Historical session logs and phase reports preserved in `_archive/phase_logs/`.

## Quick Reference

### ROM Address Mapping

Convert between file offsets and CPU addresses:
- **68000**: `cpu_addr = file_offset + 0x00880000`
- **SH2**: `cpu_addr = file_offset + 0x02000000`

### Python Tools

| Tool | Purpose |
|------|---------|
| `m68k_disasm.py` | 68000 disassembler (45+ opcodes) |
| `sh2_disasm.py` | SH2 disassembler |
| `analyze_rom.py` | ROM header analyzer |
| `find_code_sections.py` | Code section scanner |
| `find_sh2_entry.py` | Locate SH2 entry points |
| `inject_fps_counter.py` | FPS counter injection for testing |
| `function_inventory.py` | Function discovery and cataloging |
| `generate_call_graph.py` | Call graph generation |
| `analyze_call_graph.py` | Call graph analysis |
| `analyze_vectors.py` | Exception vector analysis |

## Additional Resources

- Original PDF manual: `32XUSHardwareManual.pdf`
- YM-2612 (FM chip): Reference external YM-2612 Application Manual
- SH2 CPU: Reference SH7095 (Hitachi) documentation
