# Analysis Directory - VRD 32X Reverse Engineering

**Project**: Virtua Racing Deluxe (Sega 32X) Disassembly & Optimization
**Status**: Research complete, all 92 SH2 function IDs integrated
**Last Updated**: 2026-02-06

---

## Directory Structure

### Root Analysis Documents

| Document | Purpose |
|----------|---------|
| [68K_FUNCTION_REFERENCE.md](68K_FUNCTION_REFERENCE.md) | 503+ named 68K functions by category |
| [68K_SH2_CROSS_REFERENCE.md](68K_SH2_CROSS_REFERENCE.md) | Communication protocol between processors |
| [ARCHITECTURAL_BOTTLENECK_ANALYSIS.md](ARCHITECTURAL_BOTTLENECK_ANALYSIS.md) | Root cause analysis: blocking sync model |
| [CALL_GRAPH_REPORT.md](CALL_GRAPH_REPORT.md) | Function call relationships |
| [architecture-guide.md](architecture-guide.md) | High-level system architecture overview |

---

### [68k-reverse-engineering/](68k-reverse-engineering/)
Complete 68K code analysis and function documentation.

**Key Documents:**
- `68K_MAIN_LOGIC.md` - Entry initialization and main loop
- `68K_FUNCTION_INVENTORY.md` - Complete function catalog
- `68K_CALL_GRAPH_ANALYSIS.md` - Call relationships
- `68K_INTERRUPT_HANDLERS.md` - V-INT and interrupt handling
- `68K_ARCHITECTURE_PATTERNS.md` - Common code patterns
- `68K_PRIORITY_8_SUMMARY.md` / `68K_PRIORITY_9_CALL_GRAPH.md` - Priority analysis

---

### [sh2-analysis/](sh2-analysis/)
SH2 CPU analysis and 3D rendering pipeline.

**Key Documents:**
- `SH2_ARCHITECTURE_COMPLETE.md` - **Master reference** (525 lines)
- `SH2_3D_PIPELINE_ARCHITECTURE.md` - Rendering pipeline (359 lines)
- `SH2_3D_FUNCTION_REFERENCE.md` - Function catalog (597 lines)
- `SH2_3D_ENGINE_DATA_STRUCTURES.md` - Data structures
- `SH2_PARALLELIZATION_STRATEGY.md` - Master/Slave coordination
- `SH2_MASTER_SLAVE_MAP.md` - CPU work distribution
- `SLAVE_FINAL_ANALYSIS.md` - Slave processor investigation

---

### [architecture/](architecture/)
System architecture and ROM structure.

**Key Documents:**
- `ROM_EXPANSION_4MB_IMPLEMENTATION.md` - **4MB ROM with 1MB SH2 expansion**
- `ROM_STRUCTURE.md` - ROM layout and structure
- `MEMORY_MAP.md` - Complete memory mapping
- `INITIALIZATION_SEQUENCE.md` - Boot sequence
- `STATE_MACHINES.md` - V-INT and game state machines
- `DATA_STRUCTURES.md` - Core data structures
- `VINT_HANDLER_ARCHITECTURE.md` / `VINT_STATE_HANDLERS.md` - V-INT analysis
- `GAME_LOGIC_*.md` - Game subsystem documentation (7 files)

---

### [optimization/](optimization/)
Performance analysis and optimization strategies.

**Key Documents:**
- `BOTTLENECK_ANALYSIS.md` - Performance bottleneck ranking
- `OPTIMIZATION_OPPORTUNITIES.md` - Identified targets
- `OPTIMIZATION_LESSONS_LEARNED.md` - Key learnings
- `68K_PRIORITY_8_OPTIMIZATION.md` / `68K_PRIORITY_9_OPTIMIZATION.md` - Priority optimizations
- `FUNC_016_INLINING_INFEASIBILITY.md` - Why func_016 can't be inlined

---

### [profiling/](profiling/)
Performance measurement methodology.

**Key Documents:**
- `PROFILING_GUIDE.md` - GDB-based profiling methodology
- `FPS_MEASUREMENT_GUIDE.md` - Baseline FPS measurement
- `FRAME_COUNTER_IMPLEMENTATION.md` - SH2 frame counter
- `SH2_FRAME_COUNTER_PROFILING.md` - SH2-specific profiling

---

### [debugger-design/](debugger-design/)
PicoDrive debugger integration design.

**Key Documents:**
- `PDCORE_MASTER_PLAN.md` - Executive summary
- `PDCORE_API_DESIGN.md` - C API specification
- `PDCORE_MVP1_ROADMAP.md` - Implementation plan
- `DEBUGGER_ARCHITECTURE_SUMMARY.md` - Design patterns

---

### [graphics-vdp/](graphics-vdp/)
- `32X_FRAME_BUFFER_FORMAT.md` - Frame buffer architecture

---

### [_archive/](_archive/)
Historical documents from completed investigations. Contains 60 archived files including phase reports, investigation findings, and superseded documentation.

---

## Summary Statistics

| Category | Files | Description |
|----------|-------|-------------|
| Root Reference | 11 | Core cross-reference documents |
| 68K Analysis | 18 | 68000 CPU code analysis |
| SH2 Analysis | 13 | SH2 CPU and 3D engine |
| Architecture | 19 | System and game architecture |
| Optimization | 8 | Performance optimization |
| Profiling | 5 | Performance measurement |
| Debugger Design | 5 | PicoDrive integration |
| Graphics/VDP | 1 | Frame buffer format |
| **Active Total** | **80** | |
| Archived | 60 | Historical/completed work |

---

## Quick Start

**For Optimization Work:**
- [optimization/BOTTLENECK_ANALYSIS.md](optimization/BOTTLENECK_ANALYSIS.md)
- [ARCHITECTURAL_BOTTLENECK_ANALYSIS.md](ARCHITECTURAL_BOTTLENECK_ANALYSIS.md)

**For 68K Analysis:**
- [68K_FUNCTION_REFERENCE.md](68K_FUNCTION_REFERENCE.md)
- [68k-reverse-engineering/68K_FUNCTION_INVENTORY.md](68k-reverse-engineering/68K_FUNCTION_INVENTORY.md)

**For SH2 & 3D Rendering:**
- [sh2-analysis/SH2_ARCHITECTURE_COMPLETE.md](sh2-analysis/SH2_ARCHITECTURE_COMPLETE.md)
- [sh2-analysis/SH2_3D_PIPELINE_ARCHITECTURE.md](sh2-analysis/SH2_3D_PIPELINE_ARCHITECTURE.md)

**For ROM Expansion:**
- [architecture/ROM_EXPANSION_4MB_IMPLEMENTATION.md](architecture/ROM_EXPANSION_4MB_IMPLEMENTATION.md)

---

## Current Status

### Completed
- 68K reverse-engineering (503+ functions documented across 17 module categories)
- SH2 3D rendering pipeline (109 functions mapped)
- **SH2 source translation (all 92 function IDs integrated into build system)**
- Performance bottleneck identification (blocking sync = root cause)
- 4MB ROM expansion implementation (1MB SH2 working space at $300000-$3FFFFF)
- V-INT state machine analysis (all 16 states)
- Game subsystem documentation (init, AI, physics, menus, etc.)
- Documentation audit and accuracy improvements (February 2026)

### In Progress
- Expansion ROM hook activation (infrastructure ready, pending integration)
- Parallel processing optimization (Master/Slave SH2 work distribution)

### Documentation Updates (2026-02-06)
- ✅ Fixed SH2 source directory paths (disasm/modules/sh2/3d-engine/)
- ✅ Corrected module counts (17 68K module categories, 92 SH2 function IDs)
- ✅ Enhanced SDRAM address warnings ($06000000 = emulator-only)
- ✅ Added precise clock speed specifications (23.01 MHz for SH2)
- ✅ Added timestamps to key reference documents

---

**Document Convention:**
- `68K_`, `SH2_`, `VDP_` = CPU/component specific
- `GAME_LOGIC_*` = Game subsystem analysis
- `PDCORE_*` = Debugger design
- Files in `_archive/` = Historical, superseded, or completed investigation docs
