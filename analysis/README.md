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

### System Architecture Documentation - **NEW: Core Game Systems**
Detailed architecture documentation for critical game subsystems.

**Key Documents:**
- **VINT_HANDLER_ARCHITECTURE.md** - V-INT handler and 16-state machine ($001684)
  - Frame counter at $C964.L
  - State dispatch via jump table
  - Interrupt priority management
- **VINT_STATE_HANDLERS.md** - Complete analysis of all 16 V-INT state handlers
  - VDP synchronization patterns
  - Frame buffer management (states 6, 9, 13, 14)
  - Palette copy operations
  - 68K ↔ SH2 communication via COMM registers
  - Performance characteristics and cycle estimates
- **CONTROLLER_INPUT_ARCHITECTURE.md** - 3-button controller protocol ($00185E)
  - Z-Bus arbitration
  - TH line timing with NOPs
  - Button remapping and delta detection
- **GAME_LOGIC_INITIALIZATION.md** - Game initialization and mode system ($006200-$008200)
  - 8 initialization states with jump table dispatch
  - State 0: Minimal init (9 calls), State 1: Full init (31 calls)
  - Display modes 4/5 with buffer management and VDP configuration
  - Memory regions: $C800-$C978 game state, $9000/$9F00 object bases
  - 480 JSR calls across 238 functions - highly modular architecture
- **GAME_LOGIC_TIMERS_DISPLAY.md** - Timer management and display formatting ($008200-$008B9C)
  - 8 independent countdown timers (power-ups, effects, animations)
  - Race time display and lap time formatting (MM:SS.MS)
  - Result comparison system (best time table at $FDAA)
  - VDP memory writes to $00FF68F0/$00FF68F8 for on-screen display
  - 97 functions, 21 JSR calls - real-time game state updates
- **GAME_LOGIC_AI_PHYSICS.md** - AI opponent behavior and vehicle physics ($00A200-$00C200)
  - Lookup tables: speed/acceleration, sine/cosine (120 lines of data)
  - AI opponent selection with track position validation
  - Collision avoidance: Manhattan distance, lateral steering, speed throttling
  - Drafting/slipstream mechanics with proximity-based boost
  - Trigonometric position updates (sin/cos for X/Y velocity)
  - 2,609 lines, 229 functions, 48 JSR calls - most complex game logic module
- **GAME_LOGIC_SEQUENCER.md** - Scene sequencer and state manager ($00C200-$00D1D4)
  - Hierarchical state machines: sequence ($C87E), sub-sequence ($C8C4), transition ($C8F4)
  - Timeline-based event system with frame-accurate triggers
  - 32X synchronization: COMM handshake, RV control, adapter setup
  - Data loading: ROM→RAM transfers for scenes, tracks, palettes
  - Countdown system: 5-second camera zoom from frame 995→1296
  - 999 lines, 60 functions, 87 JSR calls - master game orchestrator
- **GAME_LOGIC_GRAPHICS_MENUS.md** - Graphics, menus & UI rendering ($00E200-$010200)
  - Menu system: track selection, options, results, attract mode
  - 4 state machine dispatchers sharing $C87E state variable
  - SH2 communication protocol: 8 command codes ($03, $21, $22, $25, $27, $2A, $2D, $2F)
  - Split-screen/2-player support with dual rendering paths
  - Text/digit rendering for time display (MM:SS.MS format)
  - Input handling for menu navigation (D-pad, buttons, wrapping)
  - 2,267 lines, 190 functions, 115 JSR calls - complete UI system
- **GAME_LOGIC_NAME_ENTRY.md** - Name entry & character selection ($010200-$012200)
  - On-screen character grid keyboard (52 chars: A-Z, a-z + specials)
  - Uppercase/lowercase toggle with index offset ($1A = 26)
  - 3-character name buffer per player with backspace support
  - D-pad grid navigation with cursor movement sound ($A8/$A9)
  - Split-screen simultaneous entry (P1/P2 mirrored buffers)
  - ASCII table at $010974 (27 words packed with character pairs)
  - 2,251 lines, 201 functions, 178 JSR calls - full name entry system
- **GAME_LOGIC_REMAINING_MODULES.md** - Race display, camera & utilities ($012200-$018200)
  - **game_12200.asm**: Race start camera transitions, viewport control, zoom/scroll engine
  - Smooth camera animations via scroll offset ($A026) and animation counter ($A02A)
  - SH2 command $2C for camera/viewport setup
  - Track-specific camera adjustments based on race mode
  - 2,256 lines, 207 functions, 142 JSR calls - camera control system
  - **game_14200.asm**: Utility functions and data processing helpers (2,098 lines, 31 functions)
  - **game_16200.asm**: Pure data section - sprite/graphics data tables (8KB, non-executable)
- **68K_SH2_COMMUNICATION.md** - CPU communication patterns (COMM registers)
- **SH2_3D_PIPELINE_ARCHITECTURE.md** - 3D rendering engine (SH2)

**Status:** ✅ All core game subsystems fully documented: V-INT, state handlers, controller, initialization, timers, AI/physics, sequencer, graphics/menus, name entry, and race camera/display (2026-01-17)

---

### Code Conversion Documentation - **NEW: 68K Mnemonics Implementation**

**Key Documents:**
- **CODE_CONVERSION_SUMMARY.md** - Complete conversion summary
  - 84 code modules converted with proper mnemonics
  - 65 misclassified data sections corrected
  - 50+ instruction types supported
  - Byte-perfect ROM builds maintained
  - Before/after readability comparison

**Status:** ✅ All 68K code converted with proper assembly mnemonics (2026-01-17)

---

## 📊 Summary Statistics

| Category | Files | Status |
|----------|-------|--------|
| Debugger Design | 10 | ✅ Complete |
| 68K Analysis | 28 | ✅ Phase 6 Complete |
| SH2 Analysis | 9 | ✅ Phase 4 Complete |
| System Architecture (NEW) | 12 | ✅ 10 Documented |
| Code Conversion (NEW) | 1 | ✅ Complete |
| Optimization | 9 | ✅ Identified Paths |
| Profiling | 5 | ✅ Methodology Ready |
| Phase Reports | 6 | ✅ Current |
| Architecture | 7 | ✅ Complete |
| Graphics/VDP | 1 | ✅ Complete |
| **Total** | **~88** | **✅ Ready** |

---

## 🎯 Current Status

### ✅ Completed Research
- 68K reverse-engineering (28 documents, comprehensive function inventory)
- **68K code conversion (84 modules, all code with proper mnemonics)**
- SH2 3D rendering pipeline (9 documents, full architecture)
- Performance bottleneck identification (VDP polling = 47% overhead)
- Memory layout and ROM structure
- Frame buffer format documentation
- Master/Slave synchronization patterns
- **V-INT state handler analysis (all 16 states documented)**
- **Controller input architecture (3-button protocol documented)**
- **Game initialization architecture (8 states, 480 JSR calls, 238 functions documented)**
- **Game timer and display system (8 timers, race time display, result comparison)**
- **AI opponent behavior and physics (collision avoidance, drafting, trigonometric motion)**
- **Scene sequencer and state manager (hierarchical FSMs, 32X sync, timeline events)**
- **Graphics, menus & UI rendering (4 state machines, 8 SH2 commands, split-screen support)**
- **Name entry system (52-char grid keyboard, 3-char buffers, uppercase/lowercase toggle)**
- **Race start camera & viewport system (smooth zoom/scroll, track-specific positioning, SH2 sync)**

### ✅ Latest Addition: pdcore Debugger Design
- Complete C API specification (18 functions, MVP-1)
- BlastEm architecture analysis (6 documents, 103 KB)
- PicoDrive integration plan (5 hook points, 36 lines changes)
- Implementation roadmap (8 phases, 15-20 hours)

### ⚠️ Critical Discovery: Slave SH2 Boot Failure (2026-01-20)

**Debugger measurements reveal the Slave SH2 never boots correctly in PicoDrive emulator.**

**Issue**: PicoDrive reads SH2 reset vectors from ROM 0x0 (Genesis/68K vectors) instead of 32X header (ROM 0x3C0+)

**Result**:
- Slave PC set to 0x00880832 (68K code address)
- Slave executes 68K garbage instead of SH2 rendering engine
- Gets stuck at ROM 0x060A infinite loop
- Never reaches ROM 0x020650+ (Slave work loop code)

**Impact**: All Slave parallelization strategies are untestable until emulator fixed

**Status**: Root cause identified in PicoDrive `sh2_reset()` function

**Key Documents**:
- [SLAVE_BOOT_FAILURE_ROOT_CAUSE.md](../SLAVE_BOOT_FAILURE_ROOT_CAUSE.md) - Complete root cause analysis
- [R2_DEBUGGER_RESULTS.md](../R2_DEBUGGER_RESULTS.md) - Runtime debugger measurements
- [ANALYSIS_REVISION_2026-01-20.md](../ANALYSIS_REVISION_2026-01-20.md) - Documentation impact assessment

**Affected Analysis** (now marked with caveats):
- [sh2-analysis/SH2_PARALLELIZATION_STRATEGY.md](sh2-analysis/SH2_PARALLELIZATION_STRATEGY.md) - Strategy sound but untestable
- [architecture/MASTER_SLAVE_ANALYSIS.md](architecture/MASTER_SLAVE_ANALYSIS.md) - Static analysis contradicted by runtime
- [SH2_ARCHITECTURE_COMPLETE.md](SH2_ARCHITECTURE_COMPLETE.md) - Slave sections theoretical only

**Unaffected Analysis** (remains valid):
- ✅ 68K reverse-engineering - No dependencies on Slave boot
- ✅ Master SH2 rendering pipeline - Master boots correctly
- ✅ VDP bottleneck analysis - Independent of Slave
- ✅ Data structures and memory maps - Hardware-accurate

**Next Steps**:
1. Fix PicoDrive's reset vector reading (or test on real 32X hardware)
2. Verify Slave boots to correct entry point
3. Resume parallelization implementation

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

**Last Updated:** 2026-01-20 (Major revision: Slave boot failure discovered)
**Overall Status:** ✅ Research Complete - Implementation Blocked (PicoDrive boot bug)
