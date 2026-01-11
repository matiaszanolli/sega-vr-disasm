# Analysis Directory - VRD 32X Reverse Engineering & Debugger Design

This directory contains all technical analysis and design documentation for the Virtua Racing Deluxe (VRD) 32X project.

---

## 📁 Directory Structure

### [debugger-design/](debugger-design/) - **NEW: pdcore Debugger & BlastEm Research**
Complete research and design for a 32X dev-grade debugger.

**Key Documents:**
- **PDCORE_API_DESIGN.md** - Complete C API specification (752 lines, 18 functions)
- **PDCORE_MVP1_ROADMAP.md** - 8-phase implementation plan (15-20 hours)
- **PDCORE_SURGICAL_INSERTION_CHECKLIST.md** - Exact PicoDrive modifications (~36 lines)
- **PDCORE_MASTER_PLAN.md** - Executive summary and next steps
- **BLASTEM_DEBUGGER_ANALYSIS.md** - BlastEm architecture reverse-engineering
- **BLASTEM_CODE_SNIPPETS.md** - 12 critical BlastEm functions
- **BLASTEM_ARCHITECTURE_DIAGRAMS.md** - 8 detailed flow diagrams
- **DEBUGGER_ARCHITECTURE_SUMMARY.md** - 5 key design patterns extracted

**Status:** ✅ Research & design complete - ready for implementation (Phase 1)

---

### [68k-reverse-engineering/](68k-reverse-engineering/) - **68000 CPU Analysis**
Complete reverse-engineering of 68K code sections, function analysis, and architectural patterns.

**Key Documents:**
- **68K_MAIN_LOGIC.md** - Complete entry initialization and main loop
- **68K_ENTRY_INIT.md** - Initialization sequence and setup
- **68K_FUNCTION_FAMILIES.md** - Function categorization by purpose
- **68K_CALL_GRAPH_ANALYSIS.md** - Function call relationships
- **68K_LOW_CODE_UTILITIES.md** - Utility functions and helpers
- **68K_PRIORITY_8_PHASE6_PROFILING_REPORT.md** - Priority 8 analysis with profiling
- **68K_PRIORITY_9_DEEP_DIVE_REPORT.md** - Priority 9 investigation
- **68K_INTERRUPT_HANDLERS.md** - V-INT and interrupt handling
- **68K_ARCHITECTURE_PATTERNS.md** - Common code patterns and structures
- **68K_ANNOTATION_TASKS.md** - Detailed annotation work items
- **68K_MEMORY_MAP.md** - Memory layout and address mapping

**Subfolder:** call_graph.dot - Graphviz call graph visualization

**Status:** ✅ Phase 6 complete - comprehensive function inventory and optimization analysis

---

### [sh2-analysis/](sh2-analysis/) - **SH2 CPU & 3D Rendering Analysis**
SH2 CPU code analysis, 3D rendering pipeline, and parallelization strategy.

**Key Documents:**
- **SH2_3D_PIPELINE_ARCHITECTURE.md** - Complete 3D rendering engine architecture
- **SH2_3D_FUNCTION_REFERENCE.md** - 3D rendering function reference
- **SH2_3D_ENGINE_DATA_STRUCTURES.md** - Data structures used by 3D engine
- **SH2_3D_CALL_GRAPH.md** - 3D rendering call graph
- **SH2_PARALLELIZATION_STRATEGY.md** - Master/Slave coordination strategy
- **SH2_MASTER_CODE.md** - Master SH2 code analysis
- **SH2_INTERRUPT_HANDLERS.md** - SH2 interrupt handling
- **SH2_CODE_HUNT.md** - Code discovery methodology
- **SH2_CODE_LOCATION_CONFIRMED.md** - Located code sections

**Status:** ✅ Phase 4 complete - 3D architecture mapped, rendering pipeline understood

---

### [optimization/](optimization/) - **Performance Optimization Analysis**
Optimization strategy, bottleneck identification, and patch design.

**Key Documents:**
- **BOTTLENECK_ANALYSIS.md** - Complete performance bottleneck ranking
- **OPTIMIZATION_OPPORTUNITIES.md** - Identified optimization targets
- **VDP_POLLING_OPTIMIZATION_COMPLETE.md** - VDP polling optimization strategy
- **VDP_POLLING_OPTIMIZATION_PATCH.md** - Proposed polling optimization patch
- **68K_PRIORITY_8_OPTIMIZATION_DESIGN_1.md** - Priority 8 optimization design
- **68K_PRIORITY_9_OPTIMIZATION.md** - Priority 9 optimization analysis
- **OPTIMIZATION_TEST_RESULTS.md** - Test results and validation
- **OPTIMIZATION_LESSONS_LEARNED.md** - Key learnings from optimization work
- **func_065_FINAL_VERDICT.md** - FIFO optimization decision

**Status:** ✅ Multiple optimization paths identified (polling loop 47% overhead)

---

### [profiling/](profiling/) - **Profiling & Performance Analysis**
Frame timing analysis, cycle profiling, and performance measurement methodology.

**Key Documents:**
- **68K_PRIORITY_8_PHASE6_PROFILING_REPORT.md** - Complete profiling analysis
- **DEBUG_FIFO_ROM.md** - FIFO debugging and measurement
- **FPS_MEASUREMENT_GUIDE.md** - Baseline FPS measurement methodology
- **FRAME_COUNTER_IMPLEMENTATION.md** - SH2 frame counter implementation
- **PROFILING_GUIDE.md** - GDB-based profiling methodology

**Status:** ✅ Profiling infrastructure established (frame counter at 0x22000400)

---

### [phase-reports/](phase-reports/) - **Session & Phase Completion Reports**
Cumulative progress reports, phase completions, and session summaries.

**Key Documents:**
- **PHASE_6_COMPLETION_SUMMARY.md** - Phase 6 completion status
- **PROFILING_PHASE_COMPLETE.md** - Profiling phase wrap-up
- **SESSION_SUMMARY.md** - Overall session summary
- **SESSION_COMPLETION_REPORT_2026-01-07.md** - Formal completion report
- **WEEK_1_STATUS.md** - Week 1 progress summary
- **ANNOTATION_STATUS.md** - Annotation work status

**Status:** ✅ Phases 1-6 complete, Phase 4.4a ROM injection validated

---

### [architecture/](architecture/) - **Architectural Documentation & Structure**
High-level system architecture, memory layout, and ROM structure.

**Key Documents:**
- **ROM_STRUCTURE.md** - Complete ROM layout and structure
- **ROM_TEST_PLAN.md** - Testing methodology for rebuilt ROMs
- **README_PRIORITY_8.md** - Priority 8 investigation guide
- **INITIALIZATION_SEQUENCE.md** - Boot sequence and initialization
- **MASTER_SLAVE_ANALYSIS.md** - Master/Slave CPU coordination
- **MEMORY_MAP.md** - Complete memory address mapping
- **CODEBASE_DOCUMENTATION_PLAN.md** - Documentation strategy

**Status:** ✅ Complete memory map, initialization sequence, and structure documented

---

### [graphics-vdp/](graphics-vdp/) - **VDP & Graphics Analysis**
VDP register documentation, frame buffer format, and graphics mode analysis.

**Key Documents:**
- **32X_FRAME_BUFFER_FORMAT.md** - Complete frame buffer architecture (Packed Pixel mode)

**Status:** ✅ Frame buffer format documented for 32X rendering

---

## 📊 Summary Statistics

| Category | Files | Status |
|----------|-------|--------|
| Debugger Design (NEW) | 10 | ✅ Complete |
| 68K Analysis | 28 | ✅ Phase 6 Complete |
| SH2 Analysis | 9 | ✅ Phase 4 Complete |
| Optimization | 9 | ✅ Identified Paths |
| Profiling | 5 | ✅ Methodology Ready |
| Phase Reports | 6 | ✅ Current |
| Architecture | 7 | ✅ Complete |
| Graphics/VDP | 1 | ✅ Complete |
| **Total** | **~80** | **✅ Ready** |

---

## 🎯 Current Status

### ✅ Completed Research
- 68K reverse-engineering (28 documents, comprehensive function inventory)
- SH2 3D rendering pipeline (9 documents, full architecture)
- Performance bottleneck identification (VDP polling = 47% overhead)
- Memory layout and ROM structure
- Frame buffer format documentation
- Master/Slave synchronization patterns

### ✅ Latest Addition: pdcore Debugger Design
- Complete C API specification (18 functions, MVP-1)
- BlastEm architecture analysis (6 documents, 103 KB)
- PicoDrive integration plan (5 hook points, 36 lines changes)
- Implementation roadmap (8 phases, 15-20 hours)

### 📋 Next Steps
1. **Implement Phase 1** of pdcore (create headers and infrastructure)
2. **Add PicoDrive hooks** (Phase 2, minimal modifications)
3. **Build debugger core** (Phases 3-8, iterate with testing)
4. **Integrate Rust/PyO3** wrapper for Python interface

---

## 🔗 Quick Navigation

**For VRD Optimization Work:**
- Start: [optimization/BOTTLENECK_ANALYSIS.md](optimization/BOTTLENECK_ANALYSIS.md)
- Profiling: [profiling/FPS_MEASUREMENT_GUIDE.md](profiling/FPS_MEASUREMENT_GUIDE.md)

**For 68K Code Reverse-Engineering:**
- Start: [68k-reverse-engineering/README_PRIORITY_8.md](68k-reverse-engineering/README_PRIORITY_8.md)
- Function Inventory: [68k-reverse-engineering/68K_FUNCTION_INVENTORY.md](68k-reverse-engineering/68K_FUNCTION_INVENTORY.md)

**For SH2 & 3D Rendering:**
- Start: [sh2-analysis/SH2_3D_PIPELINE_ARCHITECTURE.md](sh2-analysis/SH2_3D_PIPELINE_ARCHITECTURE.md)

**For pdcore Debugger Implementation:**
- Start: [debugger-design/PDCORE_MASTER_PLAN.md](debugger-design/PDCORE_MASTER_PLAN.md)
- Then: [debugger-design/PDCORE_MVP1_ROADMAP.md](debugger-design/PDCORE_MVP1_ROADMAP.md)

---

## 📝 Document Naming Convention

- **Priority X** = Performance bottleneck ranking
- **Phase X** = Development phase completion
- **PDCORE_** = pdcore debugger design
- **BLASTEM_** = BlastEm reverse-engineering research
- **68K_**, **SH2_**, **VDP_** = CPU/Component specific analysis
- **OPTIMIZATION_** = Performance improvement work
- **PROFILING_** = Cycle/timing analysis

---

**Last Updated:** 2026-01-10
**Overall Status:** ✅ Research & Design Complete - Implementation Ready
