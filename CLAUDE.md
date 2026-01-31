# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Current Development Status

**Phase:** Real vertex transform offload operational - TRUE PARALLEL PROCESSING
**Approach:** Full ROM rebuild from disassembly (NOT code injection)
**Build:** `make all` produces complete 4MB ROM

### What's Working
- 4MB ROM builds successfully with 1MB expansion space ($300000-$3FFFFF)
- **Master SH2 hooked**: Dispatch at $02046A redirects to `master_dispatch_hook` at $300050
- **Slave SH2 activated**: Runs `slave_work_wrapper` at $300200 (work dispatch)
- **Real parameter capture**: func_021 trampoline captures R14/R7/R8/R5 to shared memory
- **TRUE PARALLEL PROCESSING**: Master returns immediately, Slave executes vertex transform
- **Architecture**:
  ```
  Game calls func_021 → Trampoline captures R14/R7/R8/R5 → COMM7=0x16
                      → Master returns immediately (no work done)
                      → Slave picks up work, executes func_021_optimized
                      → Both CPUs running in parallel!
  ```

### Expansion ROM Layout
| Address | Size | Function |
|---------|------|----------|
| $300028 | 22B | `handler_frame_sync` |
| $300050 | 44B | `master_dispatch_hook` (skips COMM7 for cmd 0x16) |
| $300100 | 96B | `func_021_optimized` (func_016 inlined) |
| $300200 | 76B | `slave_work_wrapper` (command dispatch) |
| $300280 | 44B | `slave_test_func` (reads params, calls func_021_optimized) |

### Key Memory Locations
| Address | Purpose |
|---------|---------|
| $0234C8 | func_021 trampoline (captures params, signals Slave) |
| $2203E000 | Parameter block (R14, R7, R8, R5 - 16 bytes) |
| $2000402E | COMM7 (Master→Slave signal) |
| $2000402A | COMM5 (vertex transform counter, +101 per call) |

### Next Steps
1. ~~Parameter passing infrastructure~~ ✅ Done
2. ~~Real parameter capture~~ ✅ Done
3. **Performance Testing**: Measure FPS improvement
4. **Synchronization**: Ensure Slave completes before next frame
5. **Load Balancing**: Split polygon workload between CPUs

### Abandoned Approaches
- **Code injection via `phase11_rom_patcher.py`**: Reached space/alignment limits
- **68K V-INT hook**: BSR.W exceeded ±32KB range (actual distance: 85KB)

**Current workflow:** Modify disassembly sources in `disasm/sections/`, rebuild with `make all`.

---

## Ground Rules for Code Modifications - STRICTLY ENFORCED

### 1. Do Not Guess
- **Use the official documentation** at `docs/` (hardware manuals, development guides)
- **Use the comprehensive analysis** at `analysis/` (game architecture, function references, data structures)
- If information isn't available, research it first - don't assume

### 2. Understand Before Modifying
- **Never patch `dc.w` values without understanding what they do**
- If you encounter uncommented functions or raw `dc.w` code, do the work to understand it first
- When possible, translate `dc.w` sequences into proper assembly mnemonics with comments
- Disassemble and document code before making any modifications

### 3. Use Available Tools
- **Profiler**: Use `tools/libretro-profiling/` for performance analysis
- **Disassemblers**: Use `tools/m68k_disasm.py` and `tools/sh2_disasm.py`
- Don't make performance assumptions - measure with the profiler

### 4. Proper Assembly, Not Binary Injection
- **Always modify proper assembly code** - don't trust raw binary/hex patches
- Convert `dc.w` sequences to mnemonics before modifying
- Binary injection is error-prone and hard to maintain

### 5. Clean Commits Only
- **Never leave stale "PATCHED" comments** with old values - either fully revert or fully commit
- After fixes, verify the ROM matches original where expected (no unintended byte changes)
- If a modification doesn't work, revert it completely - don't leave partial changes

### 6. Verify Changes
- Always rebuild and test after modifications
- Compare key ROM regions with original using `xxd` or `cmp`
- A working ROM that boots is the minimum bar - test actual gameplay

---

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
| [ROM_EXPANSION_4MB_IMPLEMENTATION.md](analysis/architecture/ROM_EXPANSION_4MB_IMPLEMENTATION.md) | **4MB expansion** - 1MB SH2 working space implementation |
| [68K_FUNCTION_REFERENCE.md](analysis/68K_FUNCTION_REFERENCE.md) | 503+ named 68K functions by category |
| [68K_SH2_COMMUNICATION.md](analysis/68K_SH2_COMMUNICATION.md) | Communication protocol between processors |
| [DATA_STRUCTURES.md](analysis/architecture/DATA_STRUCTURES.md) | Memory maps, object tables, structures |
| [STATE_MACHINES.md](analysis/architecture/STATE_MACHINES.md) | V-INT handler and game state machines |
| [SH2_3D_PIPELINE_ARCHITECTURE.md](analysis/sh2-analysis/SH2_3D_PIPELINE_ARCHITECTURE.md) | SH2 3D rendering engine |

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

### 4MB Expansion ROM Architecture

The project builds a **4MB cartridge** (official VRD size) with 1MB SH2 expansion space:

```
ROM Layout:
$000000-$2FFFFF  3.0 MB    Original Game Code (68K + SH2)
$300000-$3FFFFF  1.0 MB    SH2 Expansion Space (NEW)
```

**CRITICAL CONSTRAINT - Expansion Section ($300000-$3FFFFF):**
- This section is executed by **SH2 processors ONLY**, not the 68000
- Can ONLY contain:
  - SH2 code in `dc.w` format (raw 16-bit opcodes)
  - Data literals
  - Padding (0xFF)
- **NEVER** use 68K assembly mnemonics (move.w, rts, etc.) in this section
- 68K machine code produces invalid SH2 instructions → boot failure

**Why:** Expansion ROM maps to SH2 address space ($02300000-$023FFFFF), not 68K space.

**Implementation:** See [disasm/sections/expansion_300000.asm](disasm/sections/expansion_300000.asm)

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

### Profiling Tools (`tools/libretro-profiling/`)

**Location:** `tools/libretro-profiling/`

Cycle-accurate profiling using a custom PicoDrive libretro core with instrumentation.

| Tool | Purpose |
|------|---------|
| `profiling_frontend` | Headless libretro frontend for automated profiling |
| `picodrive_libretro.so` | Custom PicoDrive core with profiling instrumentation |
| `analyze_profile.py` | Frame-level analysis (68K/MSH2/SSH2 cycles per frame) |
| `analyze_pc_profile.py` | PC-level hotspot analysis (which addresses consume cycles) |

**Quick Start:**
```bash
cd tools/libretro-profiling

# Basic profiling (1800 frames = 30 seconds at 60 V-INT)
./profiling_frontend ../../build/vr_rebuild.32x 1800 --autoplay

# PC-level hotspot profiling
VRD_PROFILE_PC=1 VRD_PROFILE_PC_LOG=profile.csv \
./profiling_frontend ../../build/vr_rebuild.32x 2400 --autoplay
python3 analyze_pc_profile.py profile.csv
```

**Key metrics:**
- **68K**: ~127,987 cycles/frame @ 7.67 MHz (100% utilization = bottleneck)
- **Master SH2**: ~139,568 cycles/frame @ 23 MHz (36% utilization)
- **Slave SH2**: ~299,958 cycles/frame @ 23 MHz (78% utilization)

**Documentation:** See [README_68K_PC_PROFILING.md](tools/libretro-profiling/README_68K_PC_PROFILING.md)

## Emulator Compatibility

| Emulator | 32X Support | Notes |
|----------|-------------|-------|
| **PicoDrive (system)** | ✅ Yes | Accurate 32X emulation, use for testing |
| **PicoDrive (custom build)** | ✅ Yes | Only working 32X debugger available |
| **BlastEm** | ❌ No | Genesis/Mega Drive only, NO 32X support |

**Important:**
- BlastEm does NOT support 32X. Do not suggest using BlastEm for 32X ROM testing.
- Default/system PicoDrive install provides accurate 32X emulation for testing ROMs
- Custom PicoDrive build is the only working debugger for 32X debugging/profiling

## Additional Resources

- Original PDF manual: `32XUSHardwareManual.pdf`
- YM-2612 (FM chip): Reference external YM-2612 Application Manual
- SH2 CPU: Reference SH7095 (Hitachi) documentation
