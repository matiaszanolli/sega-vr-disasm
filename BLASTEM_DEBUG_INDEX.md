# BlastEm Debugger Analysis - Document Index

**Generated**: 2026-01-10
**Source**: https://github.com/libretro/blastem (m68k GDB/debugger implementation)
**Purpose**: Architectural reference for Virtua Racing Deluxe 32X SH2 debugger design

---

## Three Documents Provided

### 1. DEBUGGER_ARCHITECTURE_SUMMARY.md (11 KB) - START HERE
**Best for**: Quick understanding, decision making
- Executive summary of all 5 key questions
- High-level design patterns
- Critical code paths table
- Adaptation strategy for SH2
- One-page answers to all major questions

**Read this first** if you're short on time.

---

### 2. BLASTEM_DEBUGGER_ANALYSIS.md (22 KB) - DETAILED REFERENCE
**Best for**: Deep understanding, implementation planning
- Complete architecture documentation
- 5 detailed sections covering every aspect:
  1. Debug hook location (JIT injection point)
  2. Breakpoint data structures
  3. Execution control (continue/step/run-until)
  4. Trace infrastructure (optional logging)
  5. Multi-CPU coordination
- GDB protocol implementation details
- Clever design patterns analysis
- Source file references with line numbers
- Summary table and recommendations

**Read this for** comprehensive understanding before implementing.

---

### 3. BLASTEM_CODE_SNIPPETS.md (13 KB) - IMPLEMENTATION REFERENCE
**Best for**: Copy-paste adaptation, coding
- 12 most critical functions with complete code
- All function signatures
- Inline comments explaining each section
- Usage patterns and examples
- Directly adaptable to SH2

**Use this while coding** to see exact implementation details.

---

## Quick Reference by Topic

### I want to understand...

#### The Debug Hook Location
**Read**: DEBUGGER_ARCHITECTURE_SUMMARY.md Section 1
**Then**: BLASTEM_DEBUGGER_ANALYSIS.md Section 1
**Code**: BLASTEM_CODE_SNIPPETS.md #6-8

#### Breakpoint Storage/Lookup
**Read**: DEBUGGER_ARCHITECTURE_SUMMARY.md Section 2
**Then**: BLASTEM_DEBUGGER_ANALYSIS.md Section 2
**Code**: BLASTEM_CODE_SNIPPETS.md #1-5

#### Step/Continue/Run-Until Logic
**Read**: DEBUGGER_ARCHITECTURE_SUMMARY.md Section 3
**Then**: BLASTEM_DEBUGGER_ANALYSIS.md Section 3
**Code**: BLASTEM_CODE_SNIPPETS.md #9-10

#### Trace Infrastructure
**Read**: DEBUGGER_ARCHITECTURE_SUMMARY.md Section 4
**Then**: BLASTEM_DEBUGGER_ANALYSIS.md Section 4

#### Multi-CPU Coordination
**Read**: DEBUGGER_ARCHITECTURE_SUMMARY.md Section 5
**Then**: BLASTEM_DEBUGGER_ANALYSIS.md Section 5

#### GDB Protocol Details
**Read**: DEBUGGER_ARCHITECTURE_SUMMARY.md "GDB Protocol Implementation"
**Then**: BLASTEM_DEBUGGER_ANALYSIS.md Section 6
**Code**: BLASTEM_CODE_SNIPPETS.md #11-12

#### Design Patterns to Emulate
**Read**: BLASTEM_DEBUGGER_ANALYSIS.md "Clever Design Patterns to Emulate"
**Then**: DEBUGGER_ARCHITECTURE_SUMMARY.md "Design Patterns Worth Emulating"

---

## Source Code Files Referenced

All files are in BlastEm repository: https://github.com/libretro/blastem

| File | Purpose | Lines | Key Content |
|------|---------|-------|---|
| `gdb_remote.c` | GDB protocol handler | 588 | Protocol parsing, command dispatch, message loop |
| `gdb_remote.h` | GDB interface | 9 | Function declarations |
| `debug.c` | Integrated debugger | ~1000 | Terminal-based debugging, step/continue logic |
| `debug.h` | Debugger types | 36 | bp_def, disp_def structures |
| `m68k_core.c` | 68K execution core | 1283 | Breakpoint insertion/removal, find functions, dispatch |
| `m68k_core.h` | 68K context types | 123 | m68k_context, m68k_breakpoint, m68k_debug_handler |
| `m68k_core_x86.c` | JIT compiler (x86) | 2800+ | m68k_breakpoint_patch(), bp_stub generation |
| `m68k_internal.h` | Internal declarations | - | m68k_breakpoint_patch() signature |

---

## Key Data Structures

### Breakpoint (Core)
```c
typedef struct {
    m68k_debug_handler handler;    // Function to call on hit
    uint32_t           address;    // CPU address
} m68k_breakpoint;
```
**Used in**: m68k_core.h
**See**: BLASTEM_CODE_SNIPPETS.md #1

### Breakpoint Definition (GDB Wrapper)
```c
typedef struct bp_def {
    struct bp_def *next;          // Linked list pointer
    char          *commands;      // Debugger commands
    uint32_t      address;        // CPU address
    uint32_t      index;          // User ID (0, 1, 2, ...)
} bp_def;
```
**Used in**: debug.h
**See**: BLASTEM_CODE_SNIPPETS.md #1

### Debug Handler (Function Type)
```c
typedef void (*m68k_debug_handler)(m68k_context *context, uint32_t pc);
```
**Used in**: m68k_core.h line 70
**Examples**:
- `gdb_debug_enter()` - GDB debugger entry point
- `debugger()` - Integrated debugger entry point

---

## Critical Functions

### Core Breakpoint Management
| Function | File | Lines | Purpose |
|----------|------|-------|---------|
| `find_breakpoint()` | m68k_core.c | 794-803 | Linear search, return handler |
| `insert_breakpoint()` | m68k_core.c | 805-821 | Add to array, patch native code |
| `remove_breakpoint()` | m68k_core.c | 1148-1169 | Remove from array, restore instruction |
| `m68k_bp_dispatcher()` | m68k_core.c | 823-835 | Call appropriate handler |

### JIT Integration
| Function | File | Lines | Purpose |
|----------|------|-------|---------|
| `translate_m68k()` | m68k_core.c | 952-965 | Check/inject breakpoint during translation |
| `m68k_breakpoint_patch()` | m68k_core_x86.c | 2542-2562 | Patch native code with breakpoint call |

### GDB Protocol
| Function | File | Lines | Purpose |
|----------|------|-------|---------|
| `gdb_debug_enter()` | gdb_remote.c | 469-551 | Main debug loop, message reception |
| `gdb_run_command()` | gdb_remote.c | 170-467 | Dispatch GDB commands |
| `gdb_send_command()` | gdb_remote.c | 103-112 | Format and send GDB message |

### Step Logic
| Function | File | Lines | Purpose |
|----------|------|-------|---------|
| GDB 's' handler | gdb_remote.c | 185-221 | Decode, predict next, set breakpoints |
| 'n' (step over) | debug.c | 741-769 | Skip over branches |
| 'o' (step out) | debug.c | 770-803 | Skip forward branches |

---

## Implementation Checklist for SH2

Based on the analysis, here's what you need to implement:

- [ ] **Data Structures**
  - [ ] sh2_breakpoint struct
  - [ ] sh2_debug_handler function type
  - [ ] Breakpoint array in sh2_context
  - [ ] bp_storage and num_breakpoints counters

- [ ] **Core Functions**
  - [ ] sh2_find_breakpoint()
  - [ ] sh2_insert_breakpoint()
  - [ ] sh2_remove_breakpoint()
  - [ ] sh2_bp_dispatcher()

- [ ] **JIT Integration**
  - [ ] Check in SH2 JIT translator
  - [ ] sh2_breakpoint_patch() for native code
  - [ ] Generate SH2 breakpoint stub

- [ ] **GDB Protocol**
  - [ ] sh2_gdb_debug_enter() - message loop
  - [ ] SH2 register encoding/decoding
  - [ ] Memory read/write handlers
  - [ ] PC and register state management

- [ ] **Step Logic**
  - [ ] SH2 instruction decoder
  - [ ] Branch prediction for SH2 ISA
  - [ ] Delay slot handling
  - [ ] Temporary breakpoint cleanup

- [ ] **Testing**
  - [ ] Single breakpoint set/hit
  - [ ] Multiple breakpoints
  - [ ] Single-step with branches
  - [ ] Register read/write via GDB
  - [ ] Memory access via GDB
  - [ ] Master/Slave coordination

---

## Architecture at a Glance

```
GDB Client
    |
    | (TCP socket)
    v
gdb_remote.c: gdb_debug_enter()
    |
    +-- Receives "$g#xx" (read registers)
    +-- Receives "$c#xx"   (continue)
    +-- Receives "$s#xx"   (step)
    |
    v
gdb_run_command()
    |
    +-- Dispatches to handlers
    |
    v
[Continue] -> cont = 1, exit loop
[Step]     -> decode, insert temp breakpoints, continue
[Breakpoint Set] -> insert_breakpoint(addr, gdb_debug_enter)
[Breakpoint Remove] -> remove_breakpoint(addr)

    |
    v
Execution resumes
    |
    v
At translation time: translate_m68k()
    |
    +-- Check: find_breakpoint(addr)?
    |
    +-- Yes -> m68k_breakpoint_patch()
    |              (patch native code to call bp_stub)
    |
    +-- No -> generate normal instruction

    |
    v
At execution: When breakpoint address reached
    |
    v
bp_stub (generated code):
    call save_context
    call m68k_bp_dispatcher
    call load_context
    [check cycle limit]
    jmp to instruction body

    |
    v
m68k_bp_dispatcher()
    |
    +-- find_breakpoint(address)
    +-- handler(context, address)
            |
            v
        gdb_debug_enter()
            |
            +-- Clean temp breakpoints
            +-- Send "$S05#xx" to GDB
            +-- loop: read messages
            +-- Wait for "$c#xx" or "$s#xx"
            +-- cont = 1
            |
            v
        Return to execution loop
```

---

## Key Insights

1. **Breakpoint check happens at JIT time, not execution time**
   - Zero overhead for non-breakpoint code
   - Maximum performance with debugging capability

2. **Single-stepping is intelligent**
   - Decodes instruction to predict all possible next addresses
   - Sets breakpoints on multiple paths if needed
   - Tracks which path was taken, cleans up temporary breakpoints

3. **Same data structure, different handlers**
   - GDB debugging: `insert_breakpoint(addr, gdb_debug_enter)`
   - Integrated debugging: `insert_breakpoint(addr, debugger)`
   - No code duplication, clean separation

4. **Handler function pointers are key**
   - Breakpoint doesn't care WHO debugs it
   - Just calls the handler function pointer
   - Allows multiple simultaneous debug modes if needed

5. **GDB protocol is minimal**
   - Only implements essential commands
   - Message parsing is robust to packet boundaries
   - Could add watchpoints/tracepoints if needed

---

## Getting Started

1. **For Overview**: Read DEBUGGER_ARCHITECTURE_SUMMARY.md (15 min)
2. **For Details**: Read BLASTEM_DEBUGGER_ANALYSIS.md (30 min)
3. **For Implementation**: Reference BLASTEM_CODE_SNIPPETS.md (2-3 hours coding)

All three documents are in the repository root and ready to use.

Source reference: https://github.com/libretro/blastem

