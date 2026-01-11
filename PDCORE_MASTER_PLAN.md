# PicoDrive 32X Debugger (pdcore) - Master Plan

**Status**: ✅ Research & Design Complete
**Next Phase**: Implementation Ready
**Date**: 2026-01-10

---

## 📋 Executive Summary

You now have a **complete, detailed plan** to build a **32X dev-grade, frame-perfect, Python-driven debugger** on top of PicoDrive's 32X emulation.

This is based on:
1. ✅ Reverse-engineering BlastEm's debugger architecture (6 analysis docs created)
2. ✅ Thorough exploration of PicoDrive's SH2 execution model (18 hook points mapped)
3. ✅ Stable C API design inspired by BlastEm's elegant patterns
4. ✅ Surgical insertion checklist for minimal PicoDrive changes
5. ✅ Step-by-step MVP-1 implementation roadmap

---

## 📁 Deliverables Created

### Research Documents (Completed)

| Document | Purpose | Size |
|----------|---------|------|
| `BLASTEM_ANALYSIS_README.md` | BlastEm research entry point | 11 KB |
| `DEBUGGER_ARCHITECTURE_SUMMARY.md` | BlastEm findings synthesized | 11 KB |
| `BLASTEM_DEBUGGER_ANALYSIS.md` | Complete technical reference | 22 KB |
| `BLASTEM_CODE_SNIPPETS.md` | 12 critical BlastEm functions | 13 KB |
| `BLASTEM_ARCHITECTURE_DIAGRAMS.md` | 8 detailed flow diagrams | 36 KB |
| `BLASTEM_DEBUG_INDEX.md` | Quick reference guide | 9.7 KB |

**Total**: 103 KB of BlastEm debugger analysis

### Design Documents (Your New Foundation)

| Document | Purpose | Lines | Status |
|----------|---------|-------|--------|
| `PDCORE_API_DESIGN.md` | Full C API specification | 752 | ✅ Complete |
| `PDCORE_SURGICAL_INSERTION_CHECKLIST.md` | Exact PicoDrive modifications | 450+ | ✅ Complete |
| `PDCORE_MVP1_ROADMAP.md` | Step-by-step implementation plan | 700+ | ✅ Complete |
| `PDCORE_MASTER_PLAN.md` | This document | - | ✅ Complete |

**Total**: ~2,000 lines of comprehensive design documentation

---

## 🎯 The Architecture (At a Glance)

```
Python Debugger Scripts
        │
        ▼
    PyO3 Bindings (Rust wrapper)
        │
        ▼
    pdcore.h (18 stable C functions)
        │
        ├─ Breakpoint system (handler pointers)
        ├─ Execution control (cycles, frames, step)
        ├─ CPU state access (read/write registers)
        ├─ Memory access (bus-aware)
        └─ Frame boundaries (V-BLANK markers)
        │
        ▼
    PicoDrive Core (5 minimal hooks)
        │
        ├─ sh2.c: Breakpoint check in execute loop
        ├─ draw.c: V-BLANK callback
        ├─ sh2.h, genesis.h: Function pointers
        └─ pico.c: Accessor functions
        │
        ▼
    32X Emulation (unchanged)
```

**Key Property**: When pdcore not attached, PicoDrive runs at full speed.

---

## 🔑 Key Design Decisions

### 1. **Handler Pointer Pattern** (from BlastEm)
- Same breakpoint array works for GDB, profilers, console debuggers
- No multiple breakpoint systems
- Extensible without API changes

### 2. **Cycle-Based Determinism**
- All timing = instruction/cycle counts (never wall-clock)
- Repeatable execution for profiling
- Perfect for VRD optimization work

### 3. **Frame-Perfect Boundaries**
- V-BLANK detection as primary synchronization point
- Frame counter in stop reason
- Aligns with your `final_exit` profiling needs

### 4. **Bus-Aware Memory API**
- Explicit buses: ROM, SDRAM, Frame Buffer, SYS regs
- No address confusion
- Extensible for future buses

### 5. **Minimal PicoDrive Changes**
- Only 5 hook points (all optional callbacks)
- ~36 lines modified in PicoDrive
- Zero overhead when no debugger attached

---

## 📊 MVP-1 Scope (15-20 hours)

### Core 18 Functions

**Lifecycle** (4 functions):
```c
pd_create(config)
pd_destroy(emu)
pd_load_rom_file(emu, path)
pd_reset(emu)
```

**Execution** (4 functions):
```c
pd_run_cycles(emu, cycles, &stop_info)
pd_run_frames(emu, count, &stop_info)
pd_step_instruction(emu, cpu, &stop_info)
pd_halt(emu)
```

**Breakpoints** (3 functions):
```c
pd_bp_exec_add(emu, cpu, addr, handler, user_data)
pd_bp_exec_del(emu, cpu, addr)
pd_bp_exec_clear(emu, cpu)
```

**CPU State** (2 functions):
```c
pd_get_sh2_regs(emu, cpu, &regs)
pd_set_sh2_regs(emu, cpu, &regs)
```

**Memory** (3 functions):
```c
pd_mem_read(emu, bus, addr, buf, size)
pd_mem_write(emu, bus, addr, data, size)
pd_mem_read_u32(emu, bus, addr)
```

**Error Handling** (1 function):
```c
pd_get_error(emu)
```

### MVP-1 Capabilities

✅ Load ROM and initialize emulation
✅ Step N cycles or N frames deterministically
✅ Set/hit execution breakpoints
✅ Read/write CPU registers (all SH2 regs)
✅ Read/write memory (frame buffer, SDRAM)
✅ Detect frame boundaries (V-BLANK markers)
✅ Single-step one instruction
✅ Clear error reporting

### MVP-1 Non-Scope (P1/P2)

⏸️ Memory watchpoints (P1 - 2 hours)
⏸️ Trace recording (P2 - 3 hours)
⏸️ GDB remote protocol (P2 - 2 hours)
⏸️ Event system (P1 - 1 hour)
⏸️ SH2 instruction decoder (P2 - 2 hours)

---

## 🛠️ Implementation Phases

### Phase 1: Foundation (2-3 hours)
- Create pdcore/include headers
- Type system and API definitions
- Scaffold pdcore.c with stubs

### Phase 2: PicoDrive Integration (1-2 hours)
- Add 5 hook points to PicoDrive
- Function pointers in SH2/Genesis structs
- Accessor functions in pico.c

### Phase 3: Memory Access (1-2 hours)
- Implement pd_mem_read/write for all buses
- Bus info functions
- Memory snapshot support

### Phase 4: Breakpoints (2 hours)
- Breakpoint array infrastructure
- Linear search (O(n) acceptable for <100 BPs)
- Handler dispatch on breakpoint hit

### Phase 5: Execution Control (1-2 hours)
- pd_run_cycles / pd_run_frames
- Halt mechanism
- Frame boundary tracking

### Phase 6: CPU State (1 hour)
- Register read/write functions
- Struct mapping from SH2 to pdcore

### Phase 7: Integration Testing (1-2 hours)
- End-to-end smoke test
- Verify breakpoints fire
- ROM loading / frame execution

### Phase 8: Build System (30 min)
- Makefile for pdcore
- Compilation verification
- Clean build from scratch

---

## 📈 Effort Breakdown

| Component | Lines of Code | Time | Complexity |
|-----------|---|---|---|
| Headers + types | 300 | 1 hr | Low |
| Lifecycle | 100 | 1 hr | Low |
| Breakpoint array | 150 | 1 hr | Low |
| Memory access | 200 | 1.5 hrs | Medium |
| Execution loop | 250 | 1.5 hrs | Medium |
| CPU state | 100 | 0.5 hr | Low |
| Testing | 200 | 1 hr | Low |
| PicoDrive hooks | 36 | 0.5 hr | Low |
| **Total** | **~1,336** | **~8 hrs** | - |

**Reality**: ~15-20 hours (includes debugging, integration, PicoDrive familiarization)

---

## 🔍 What You Get After MVP-1

### Immediate Capabilities

```python
# Example Python usage (after Rust/PyO3 wrapping)

from picodrive32x import Pico32X

emu = Pico32X("Virtua Racing Deluxe (USA).32x")
emu.reset()

# Set breakpoint at frame completion marker
emu.bp_exec(CPU_MASTER, 0x0202DD5C)

# Run until breakpoint hits
stop = emu.run_until(1_000_000_000)

if stop.reason == STOP_EXEC_BREAKPOINT:
    print(f"Frame {stop.frame_number} complete at cycle {stop.master_cycles}")

    # Inspect state
    regs = emu.get_sh2_regs(CPU_MASTER)
    print(f"Master PC: 0x{regs.pc:08x}")

    # Dump frame buffer
    fb = emu.mem_read(BUS_SH2_FB, 0x2400000, 128*1024)
    with open("framebuffer.bin", "wb") as f:
        f.write(fb)
```

### For VRD Optimization

You can now:

1. **Profile frame rendering**
   - Set BP at frame start + end
   - Measure cycles for each frame
   - Identify frame-to-frame variance

2. **Trace function calls**
   - Set BPs at function entries
   - Record call graph
   - Measure time per function

3. **Dump frame buffers**
   - Snapshot after each frame
   - Compare to reference
   - Detect rendering bugs

4. **Single-step hot code**
   - Step through inner loops
   - Observe register changes
   - Verify optimization validity

---

## 📚 Documentation Provided

### For You (To Understand Design)

1. **PDCORE_API_DESIGN.md** - Read the C API spec
   - All function signatures
   - Type definitions
   - Usage examples
   - MVP-1 vs P1/P2 features

2. **BLASTEM_DEBUGGER_ANALYSIS.md** - Understand the patterns
   - How BlastEm does breakpoints
   - Handler pointer pattern
   - Execution loop hooks
   - GDB protocol overview

### For Implementers (To Code Against)

3. **PDCORE_SURGICAL_INSERTION_CHECKLIST.md** - Know exactly what to modify
   - File locations
   - Code snippets
   - Minimal changes
   - Verification steps

4. **PDCORE_MVP1_ROADMAP.md** - Step-by-step implementation
   - 8 phases with clear milestones
   - Pseudo-code for each component
   - Testing strategy
   - Timeline estimates

---

## ⚠️ Key Assumptions (Verify First)

1. **PicoDrive source accessible** and buildable on your system
2. **PicoDrive has globals** for Genesis_State (not heavily encapsulated)
3. **SH2 registers** accessible via direct struct fields (not opaque)
4. **Frame timing** detectable via line_count == 224 (V-BLANK)
5. **Memory layout** matches documented 32X spec (SDRAM, frame buffers)

**Action**: Verify these before starting Phase 2

---

## ✅ Success Criteria (End of MVP-1)

- [ ] pdcore compiles cleanly (no warnings)
- [ ] PicoDrive still compiles with pdcore modifications
- [ ] ROM loads without errors
- [ ] Can run 1 frame deterministically
- [ ] Breakpoint fires reliably when hit
- [ ] CPU registers readable and writable
- [ ] Frame buffer memory accessible
- [ ] Integration test passes
- [ ] <2% performance overhead (measure!)
- [ ] All 18 functions documented with examples

---

## 🚀 What's Next (After You Implement MVP-1)

### P1 (Priority 1) - 1-2 evenings

- [ ] **Rust/PyO3 wrapper** → Python interface
- [ ] **Memory watchpoints** → data breakpoints
- [ ] **Trace ring buffer** → instruction history
- [ ] **Event system** → VBLANK/HBLANK markers

### P2 (Priority 2) - 2-3 evenings

- [ ] **GDB remote protocol** → IDE integration
- [ ] **SH2 instruction decoder** → disassembly
- [ ] **Cycle counting** → precise profiling
- [ ] **Master/Slave sync tracing** → IPC analysis

### P3 (Priority 3) - 1-2 evenings

- [ ] **Interactive console** → REPL debugging
- [ ] **Scripting engine** → automation
- [ ] **Data visualization** → call graphs, flamegraphs

---

## 🎓 Reference Materials

### BlastEm Analysis (Completed)
- How BlastEm implements breakpoints (JIT-time injection)
- Handler pointer pattern for extensibility
- GDB protocol streaming parser
- Multi-CPU debugging strategy

### PicoDrive Exploration (Completed)
- 18 hook points mapped with line numbers
- Execution loop structure documented
- Memory access patterns identified
- Frame boundary synchronization points

### Your VRD Context (Your Knowledge)
- SH2 instruction set (from previous phases)
- 32X memory layout (from FPS counter work)
- Rendering pipeline (from Phase 3-4 analysis)
- Frame synchronization (from Phase 2 work)

---

## 🎬 When You're Ready to Implement

1. **Read PDCORE_API_DESIGN.md** (30 min) - understand the API
2. **Read PDCORE_SURGICAL_INSERTION_CHECKLIST.md** (20 min) - know what to modify
3. **Review PDCORE_MVP1_ROADMAP.md** (30 min) - understand phases
4. **Start Phase 1** - begin implementation

Then we can:
- [ ] Create pdcore.h header file (copy from API design)
- [ ] Set up build system
- [ ] Implement Phase 1 (foundation)
- [ ] Iterate through Phases 2-8

---

## 💡 Key Insights (Why This Will Work)

1. **Minimal invasiveness**: Only 5 hook points, 36 lines changed in PicoDrive
2. **BlastEm-proven patterns**: Handler pointers, temp breakpoints, execution hooks
3. **Frame-perfect timing**: V-BLANK markers give you deterministic synchronization points
4. **Extensible design**: MVP-1 functions don't break when adding P1/P2 features
5. **Your domain knowledge**: You understand VRD's rendering, FPS markers, frame structure

**This is achievable in 15-20 hours of focused work.**

---

## 📞 Next Steps

This plan is ready. When you're ready to implement:

1. Review the 4 design documents (2-3 hours total reading)
2. Start Phase 1 of the roadmap
3. I'll assist at each phase - code review, debugging, troubleshooting

The research and planning are complete. **Execution is next.**

---

**Status**: ✅ Design Complete - Ready for Implementation

