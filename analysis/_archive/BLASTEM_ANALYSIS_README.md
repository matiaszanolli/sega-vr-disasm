# BlastEm GDB Debugger Architecture - Analysis Complete

**Analysis Date**: 2026-01-10
**Repository**: https://github.com/libretro/blastem
**Purpose**: Educational reverse-engineering for Virtua Racing Deluxe 32X SH2 debugger design

---

## Five Documents Included

### 📋 Start Here: Choose Your Path

#### 🚀 Quick Start (15 minutes)
**Read**: `BLASTEM_DEBUG_INDEX.md`
- Document index and quick reference
- Topic-by-topic navigation guide
- Implementation checklist for SH2
- Architecture summary table

#### 📊 Executive Overview (20 minutes)
**Read**: `DEBUGGER_ARCHITECTURE_SUMMARY.md`
- Executive summary of all findings
- Five key questions with complete answers
- GDB protocol implementation overview
- Design patterns worth emulating
- Adaptation strategy for SH2
- One-page reference for each major topic

#### 🔬 Complete Technical Reference (1 hour)
**Read**: `BLASTEM_DEBUGGER_ANALYSIS.md`
- In-depth analysis of all 5 major topics:
  1. Debug hook location (JIT injection)
  2. Breakpoint data structures
  3. Execution control (step/continue/run-until)
  4. Trace infrastructure
  5. Multi-CPU coordination
- GDB protocol details with code examples
- Source file references with line numbers
- Design pattern analysis
- Recommendations for SH2 implementation

#### 💾 Implementation Reference (2+ hours)
**Read**: `BLASTEM_CODE_SNIPPETS.md`
- 12 critical functions with complete listings
- Every function signature and declaration
- Inline comments explaining each section
- Usage patterns and integration examples
- Directly copyable and adaptable code
- Use while coding as reference material

#### 📐 Architecture Diagrams (30 minutes)
**Read**: `BLASTEM_ARCHITECTURE_DIAGRAMS.md`
- 8 detailed ASCII diagrams showing:
  1. Breakpoint injection flow (JIT time)
  2. Single-step execution flow
  3. Breakpoint data structure relationships
  4. GDB message protocol flow
  5. Continuous vs. debug execution model
  6. Breakpoint lookup performance analysis
  7. Memory layout with code patching
  8. SH2 adaptation mapping
- Visual understanding of all major flows
- Performance characteristics
- Memory layouts

---

## Quick Navigation by Topic

### "Where is the debug hook?"
1. `DEBUGGER_ARCHITECTURE_SUMMARY.md` - Section 1 (2 min)
2. `BLASTEM_DEBUGGER_ANALYSIS.md` - Section 1 (5 min)
3. `BLASTEM_CODE_SNIPPETS.md` - #6, #7, #8 (5 min)
4. `BLASTEM_ARCHITECTURE_DIAGRAMS.md` - Diagram 1 (3 min)

**Answer**: JIT compilation time in `translate_m68k()` at m68k_core.c line 963

### "How are breakpoints stored and looked up?"
1. `DEBUGGER_ARCHITECTURE_SUMMARY.md` - Section 2 (2 min)
2. `BLASTEM_DEBUGGER_ANALYSIS.md` - Section 2 (8 min)
3. `BLASTEM_CODE_SNIPPETS.md` - #1-5 (5 min)
4. `BLASTEM_ARCHITECTURE_DIAGRAMS.md` - Diagram 3, 6 (5 min)

**Answer**: Simple fixed array, O(n) linear search, reusable handler pointer pattern

### "How does it implement step/continue/run-until?"
1. `DEBUGGER_ARCHITECTURE_SUMMARY.md` - Section 3 (5 min)
2. `BLASTEM_DEBUGGER_ANALYSIS.md` - Section 3 (15 min)
3. `BLASTEM_CODE_SNIPPETS.md` - #9, #10 (10 min)
4. `BLASTEM_ARCHITECTURE_DIAGRAMS.md` - Diagram 2, 5 (5 min)

**Answer**: Continue = flag, Step = decode + intelligent temp breakpoints

### "Does it have trace infrastructure?"
1. `DEBUGGER_ARCHITECTURE_SUMMARY.md` - Section 4
2. `BLASTEM_DEBUGGER_ANALYSIS.md` - Section 4

**Answer**: Framework exists but disabled; watchpoints not implemented

### "How does it handle Master/Slave SH2 stepping?"
1. `DEBUGGER_ARCHITECTURE_SUMMARY.md` - Section 5
2. `BLASTEM_DEBUGGER_ANALYSIS.md` - Section 5

**Answer**: Single-thread only currently; extensible design via context pointer

---

## Key Findings Summary

### 1. JIT-Time Breakpoint Injection
- **Where**: During code translation in `translate_m68k()`
- **How**: Check if address in breakpoint array, patch native code if hit
- **Why**: Zero overhead for non-breakpoint instructions
- **Files**: m68k_core.c, m68k_core_x86.c

### 2. Reusable Breakpoint Structure
```c
typedef struct {
    m68k_debug_handler handler;    // Function pointer!
    uint32_t address;
} m68k_breakpoint;
```
- Same structure works for GDB or integrated debugger
- Handler determines behavior (gdb_debug_enter vs. debugger)
- Eliminates code duplication

### 3. Intelligent Single-Stepping
- Decodes instruction to predict next address(es)
- Sets breakpoints on all possible paths
- For conditional branches: breakpoints on both true AND false paths
- Cleans up temporary breakpoints when actual path taken
- Handles RTS/RTE/RTR by reading stack

### 4. Streaming GDB Protocol
- Robust handling of partial packets
- Minimal command set but fully functional
- Message format: `$<payload>#<checksum>`
- Supports: continue, step, breakpoints, registers, memory

### 5. Extensible Architecture
- `system` pointer in context allows multi-CPU coordination
- Z80 debugging already implemented separately
- SH2 support would follow same pattern
- Parallel data structures (array for fast lookup, linked list for UI)

---

## For Virtua Racing 32X SH2 Implementation

### Minimum Implementation Required

```
1. Core Breakpoint Functions
   [ ] sh2_find_breakpoint(context, address)
   [ ] sh2_insert_breakpoint(context, address, handler)
   [ ] sh2_remove_breakpoint(context, address)
   [ ] sh2_bp_dispatcher(context, address)

2. JIT Integration
   [ ] Check in translate_sh2() instruction translation loop
   [ ] sh2_breakpoint_patch() to patch native code
   [ ] Generate SH2-specific breakpoint stub

3. GDB Protocol
   [ ] sh2_gdb_debug_enter() - message loop
   [ ] Register encoding/decoding for SH2 ISA
   [ ] SH2 instruction decoder for step logic

4. Step Logic
   [ ] Decode SH2 instruction (16-bit simpler than 68K)
   [ ] Predict next address
   [ ] Handle delay slot instructions
   [ ] Set temporary breakpoints
```

### Estimated Effort
- **Breakpoint infrastructure**: 2-3 hours (straightforward port)
- **JIT integration**: 2-4 hours (varies by backend)
- **GDB protocol changes**: 1-2 hours (mostly register encoding)
- **Step logic & testing**: 3-5 hours (new instruction decoder needed)
- **Total**: 8-14 hours of focused development

### Code Reusability
- **Full reuse**: GDB protocol message layer (gdb_remote.c core)
- **Partial reuse**: Debug loop structure, breakpoint patterns
- **Needs changes**: Register encoding, instruction decoder, patching details
- **New code**: SH2 instruction decoder, delay slot handling

---

## File Organization

```
/mnt/data/src/32x-playground/
├── BLASTEM_ANALYSIS_README.md (this file - START HERE)
├── BLASTEM_DEBUG_INDEX.md (quick reference & navigation)
├── DEBUGGER_ARCHITECTURE_SUMMARY.md (executive summary)
├── BLASTEM_DEBUGGER_ANALYSIS.md (complete technical reference)
├── BLASTEM_CODE_SNIPPETS.md (implementation reference)
└── BLASTEM_ARCHITECTURE_DIAGRAMS.md (visual diagrams)

Total: 92 KB, 2,369 lines of analysis
```

---

## How to Use These Documents

### Reading Strategy A: "I'm in a Hurry" (45 minutes)
1. Read: `BLASTEM_DEBUG_INDEX.md` (15 min)
2. Read: `DEBUGGER_ARCHITECTURE_SUMMARY.md` (20 min)
3. Skim: `BLASTEM_ARCHITECTURE_DIAGRAMS.md` (10 min)
4. Bookmark: `BLASTEM_CODE_SNIPPETS.md` for later coding

**Outcome**: Understand architecture, know what needs to be done

### Reading Strategy B: "Deep Dive" (2-3 hours)
1. Read: `BLASTEM_DEBUG_INDEX.md` (15 min)
2. Read: `BLASTEM_DEBUGGER_ANALYSIS.md` (45 min)
3. Study: `BLASTEM_ARCHITECTURE_DIAGRAMS.md` (30 min)
4. Reference: `BLASTEM_CODE_SNIPPETS.md` (30 min)

**Outcome**: Complete understanding, ready to implement

### Reading Strategy C: "Implementation Focused" (4+ hours)
1. Skim: `DEBUGGER_ARCHITECTURE_SUMMARY.md` (10 min)
2. Code review: `BLASTEM_CODE_SNIPPETS.md` (1 hour)
3. Reference: `BLASTEM_DEBUGGER_ANALYSIS.md` (1 hour)
4. Code: Your SH2 implementation (2+ hours)
5. Consult: Diagrams as needed (1 hour)

**Outcome**: Working SH2 debugger implementation

---

## About the Source

This analysis was extracted from **BlastEm**, a high-quality open-source Sega Genesis/Megadrive emulator:

- **Repository**: https://github.com/libretro/blastem
- **Author**: Michael Pavone
- **License**: GNU General Public License v3+
- **Quality**: Production-grade, heavily optimized
- **Architecture**: JIT compilation, cycle-accurate timing, GDB debugging

BlastEm's debugger is considered one of the best-designed debugging systems in emulation software. Its patterns are worth studying and adapting for other platforms.

---

## Key Source Files in BlastEm

| File | Purpose | Lines |
|------|---------|-------|
| `gdb_remote.c` | GDB protocol implementation | 588 |
| `gdb_remote.h` | GDB interface definitions | 9 |
| `debug.c` | Integrated terminal debugger | ~1000 |
| `debug.h` | Debugger type definitions | 36 |
| `m68k_core.c` | 68K CPU execution core | 1,283 |
| `m68k_core.h` | 68K context and type definitions | 123 |
| `m68k_core_x86.c` | x86-64 JIT compiler backend | 2,800+ |

All referenced with line numbers in this analysis.

---

## Next Steps

### Step 1: Choose Your Reading Path
Pick one of the reading strategies above based on your time availability.

### Step 2: Understand the Architecture
Focus on these questions:
- Where is the debug hook? (Section 1 of analysis)
- How are breakpoints stored? (Section 2)
- How does stepping work? (Section 3)

### Step 3: Plan Your SH2 Implementation
Use the implementation checklist in `BLASTEM_DEBUG_INDEX.md`.

### Step 4: Start Coding
Reference `BLASTEM_CODE_SNIPPETS.md` while implementing.

### Step 5: Handle SH2-Specific Details
Adapt for:
- SH2 instruction set (16-bit, simpler than 68K)
- Delay slot execution
- Different register set (R0-R15, PC, PR, SR, GBR, VBR)
- Master/Slave address coordination

---

## Questions?

If you need clarification on any topic:

1. **Check the index**: `BLASTEM_DEBUG_INDEX.md` has topic-by-topic navigation
2. **Look at diagrams**: `BLASTEM_ARCHITECTURE_DIAGRAMS.md` shows visually
3. **Review code**: `BLASTEM_CODE_SNIPPETS.md` has working examples
4. **Read deep dive**: `BLASTEM_DEBUGGER_ANALYSIS.md` for comprehensive coverage

---

## License Note

This analysis is provided for **educational purposes only**:
- BlastEm is licensed under GNU GPL v3+
- This analysis references and quotes BlastEm source code
- For commercial use of debugging code, respect GPL v3+ requirements
- The analysis itself is provided as-is for learning

---

## Summary

You now have **five comprehensive documents** totaling **92 KB** and **2,369 lines** of analysis covering:

✅ Where the debug hook is located (JIT translation time)
✅ How breakpoints are stored and looked up (simple array, O(n) search)
✅ How execution control works (continue/step/run-until)
✅ Trace infrastructure capabilities (framework exists, disabled)
✅ Multi-CPU coordination patterns (extensible design)
✅ Complete GDB protocol implementation details
✅ All critical source code functions with explanations
✅ Visual architecture diagrams
✅ Implementation guidance for SH2 adaptation
✅ Copy-paste ready code snippets

**Start with `BLASTEM_DEBUG_INDEX.md` or `DEBUGGER_ARCHITECTURE_SUMMARY.md` for a quick overview.**

