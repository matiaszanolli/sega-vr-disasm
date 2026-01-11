# BlastEm Debugger Architecture - Executive Summary

## Overview

This analysis covers BlastEm's GDB remote debugging and integrated debugger implementation, extracted from the official repository at https://github.com/libretro/blastem

**Key Finding**: BlastEm uses a clever **JIT-time breakpoint injection** pattern that eliminates per-instruction overhead while supporting full debugging capabilities.

---

## Five Key Answers

### 1. WHERE IS THE DEBUG HOOK?
**Answer: In the JIT compiler, not the CPU execution loop**

- **Location**: `/tmp/blastem/m68k_core.c` line 963 in `translate_m68k()` function
- **When**: During JIT code generation for each instruction
- **How**: Checks if address matches any breakpoint, patches native code if found
- **Why**: Zero overhead for non-breakpoint instructions; maximum performance

```c
// Check during translation
m68k_debug_handler bp;
if ((bp = find_breakpoint(context, inst->address))) {
    m68k_breakpoint_patch(context, inst->address, bp, start);
}
```

---

### 2. HOW ARE BREAKPOINTS STORED/LOOKED UP?

**Data Structure**: Simple fixed array with dynamic resizing

```c
typedef struct {
    m68k_debug_handler handler;    // Callback function
    uint32_t           address;    // CPU address
} m68k_breakpoint;

// In context:
m68k_breakpoint *breakpoints;      // Dynamic array
uint32_t        num_breakpoints;   // Count
uint32_t        bp_storage;        // Capacity
```

**Lookup**: Linear scan O(n) - acceptable because:
- Lookup only at JIT time (not per-instruction)
- Breakpoint count typically < 100
- Could be optimized with hash table if needed

**Clever Design**: Handler function pointer allows reuse:
- `insert_breakpoint(ctx, 0x1000, gdb_debug_enter)`
- `insert_breakpoint(ctx, 0x2000, debugger)`

Same data structure, different behavior.

---

### 3. HOW DOES IT IMPLEMENT STEP/CONTINUE/RUN-UNTIL?

#### Continue (GDB 'c' command)
```c
case 'c':
    cont = 1;                    // Set flag
    expect_break_response = 1;   // Expect signal on next breakpoint
    break;                       // Exit debug loop, resume execution
```
**Simplicity**: Just a flag. When set, `gdb_debug_enter()` loop exits.

#### Single-Step (GDB 's' command)
**Intelligent Temporary Breakpoints**:
1. Decode current instruction (without executing)
2. Calculate all possible next addresses
3. Insert breakpoint(s) on next address(es)
4. For **conditional branches**: set breakpoints on BOTH paths
5. For **returns**: read stack to find actual return address
6. Resume execution
7. When breakpoint hits, clean up temporary ones

```c
// Decode instruction
m68k_decode(pc_ptr, &inst, pc);

// Predict next address(es)
if (inst.op == M68K_RTS) {
    after = read_stack(aregs[7]);
} else if (m68k_is_branch(&inst)) {
    if (conditional) {
        branch_t = target_address;
        branch_f = next_address;
        insert_breakpoint(context, branch_t, gdb_debug_enter);
        insert_breakpoint(context, branch_f, gdb_debug_enter);
    } else {
        after = target_address;
    }
}

insert_breakpoint(context, after, gdb_debug_enter);
cont = 1;  // Resume execution
```

**Cleanup Logic** (`gdb_debug_enter` line 476-487):
```c
// When breakpoint hits, check which path was taken
if ((pc & 0xFFFFFF) == branch_t) {
    if (!find_breakpoint(&breakpoints, branch_f)) {
        remove_breakpoint(context, branch_f);  // Remove temporary
    }
} else if ((pc & 0xFFFFFF) == branch_f) {
    if (!find_breakpoint(&breakpoints, branch_t)) {
        remove_breakpoint(context, branch_t);
    }
}
```

---

### 4. TRACE INFRASTRUCTURE

**Current State**: Framework exists but disabled

**Instruction Logging**: Prepared but commented out
- File pointer `opts->address_log` exists in m68k_options
- One line shows pattern: `log_address(&opts->gen, inst->address, "M68K: %X @ %d\n");`
- Would require minimal changes to enable

**Memory Tracing**: Not implemented
```c
case 'Z':
    if (type < '2') {  // Software breakpoint
        // ... handled ...
    } else {
        // Watchpoints are not currently supported
        gdb_send_command("");  // Send empty response
    }
```

**Trace Flag**: Exists in context but unused
```c
struct m68k_context {
    uint8_t trace_pending;  // M68K_STATUS_TRACE flag handler
};
```

---

### 5. MULTI-CPU COORDINATION

**Current**: Single-thread only for GDB

```c
// GDB thread queries answered with "thread 1"
case 'C':
    gdb_send_command("QC1");  // Query current thread
    break;
case 'fThreadInfo':
    gdb_send_command("m1");   // Only thread 1 exists
    break;
```

**Design Pattern for Extension**:
1. Context has `void *system` pointer
2. Could point to parent `genesis_context`
3. Genesis has pointers to 68K, Z80, and (future) SH2 contexts
4. Z80 debugging already implemented separately with identical pattern

**For Sega 32X SH2**:
- Create parallel `sh2_context` structure with same breakpoint array
- Create `sh2_gdb_debug_enter()` handler
- Add SH2-specific instruction decoder for step logic
- Could eventually support Master/Slave breakpoint coordination

---

## GDB Protocol Implementation

### Message Format
```
$<payload>#<checksum>

Example: $S05#ab
         ^^        - Start marker
         S05       - SIGTRAP signal response
         ab        - Checksum (sum of S05 bytes, mod 256, in hex)
```

### Supported Commands
| Command | Implementation | Notes |
|---------|---|---|
| `c` | Continue | Set cont=1, exit loop |
| `s` / `vCont;s` | Single-step | Decode, set temp breakpoints |
| `Z0,addr,len` | Set breakpoint | insert_breakpoint() |
| `z0,addr,len` | Remove breakpoint | remove_breakpoint() |
| `g` | Read all registers | Format: D0-D7, A0-A7, SR, PC (hex) |
| `p<n>` | Read register | Single register |
| `P<n>=<val>` | Write register | Modify CPU state |
| `m<addr>,<len>` | Read memory | Up to 256 bytes/request |
| `M<addr>,<len>:<data>` | Write memory | Patch memory |
| `q...` | Query commands | Supported, Attached, Offsets, ThreadInfo, etc. |

### Message Reception (Streaming Parser)
```c
while(!cont) {
    // Handle partial packet reception
    if (!curbuf) {
        numread = read(GDB_IN_FD, buf, bufsize);
        curbuf = buf;
        end = buf + numread;
    }

    for (; curbuf < end; curbuf++) {
        if (*curbuf == '$') {  // Start of packet
            curbuf++;
            start = curbuf;
            while (curbuf < end && *curbuf != '#') {
                curbuf++;  // Find end
            }
            if (*curbuf == '#' && end-curbuf >= 2) {
                *curbuf = 0;  // Null terminate
                write(GDB_OUT_FD, "+", 1);  // Send ACK
                gdb_run_command(context, pc, start);  // Dispatch
                curbuf += 2;  // Skip checksum bytes
            }
        }
    }
}
```

---

## Critical Code Paths Summary

| Operation | File | Lines | Function |
|---|---|---|---|
| Breakpoint check | m68k_core.c | 794-803 | find_breakpoint() |
| Breakpoint insertion | m68k_core.c | 805-821 | insert_breakpoint() |
| Breakpoint removal | m68k_core.c | 1148-1169 | remove_breakpoint() |
| JIT injection | m68k_core.c | 963 | translate_m68k() |
| Native patch | m68k_core_x86.c | 2542-2562 | m68k_breakpoint_patch() |
| Dispatch stub | m68k_core_x86.c | 3192-3230 | Generated bp_stub |
| Dispatcher | m68k_core.c | 823-835 | m68k_bp_dispatcher() |
| GDB message loop | gdb_remote.c | 497-550 | gdb_debug_enter() |
| Step logic | gdb_remote.c | 185-221 | GDB 's' command handler |
| Command dispatch | gdb_remote.c | 170-467 | gdb_run_command() |

---

## Design Patterns Worth Emulating

### 1. Handler Pointer in Breakpoint
**Benefit**: Single data structure, different behaviors
```c
// Both use same insert_breakpoint()
insert_breakpoint(context, addr1, gdb_debug_enter);     // GDB debugging
insert_breakpoint(context, addr2, debugger);            // Console debugger
```

### 2. JIT-Time Injection
**Benefit**: Zero overhead when no breakpoints
- Check during translation
- Patch native code if needed
- Non-breakpoint instructions run at full speed
- No per-instruction table lookup

### 3. Intelligent Temporary Breakpoints
**Benefit**: Accurate single-stepping without source code
- Decode instruction without executing
- Predict all next addresses
- Handle conditional branches with dual breakpoints
- Auto-cleanup based on actual execution path

### 4. Pointer-to-Pointer for List Removal
**Benefit**: Clean list manipulation without special cases
```c
bp_def ** found = find_breakpoint(&breakpoints, addr);
if (*found) {
    bp_def * to_remove = *found;
    *found = to_remove->next;  // Unlink
    free(to_remove);
}
```

### 5. Streaming Message Parser
**Benefit**: Handles network packet boundaries gracefully
- Accumulates partial packets
- Doesn't corrupt on split boundaries
- Easy to extend with timeouts

---

## Adaptation Strategy for Sega 32X SH2

### Phase 1: Breakpoint Infrastructure
```c
typedef void (*sh2_debug_handler)(sh2_context *context, uint32_t pc);

typedef struct {
    sh2_debug_handler handler;
    uint32_t          address;
} sh2_breakpoint;

// Add to sh2_context
sh2_breakpoint *breakpoints;
uint32_t        num_breakpoints;
uint32_t        bp_storage;
```

### Phase 2: JIT Integration (compiler backend)
- Implement `sh2_breakpoint_patch()` for SH2 native code
- Check in instruction translation loop
- Generate SH2-specific breakpoint stub

### Phase 3: Step Logic
- Implement SH2 instruction decoder
- Handle SH2 delay slot instructions
- Track Master/Slave address coordination

### Phase 4: GDB Protocol (Minimal changes)
- Reuse gdb_remote.c message layer
- Change register encoding (SH2 has R0-R15, PC, PR, SR, GBR, VBR)
- Add SH2 address space constants

---

## Files Provided

1. **BLASTEM_DEBUGGER_ANALYSIS.md** (22 KB)
   - Complete architecture documentation
   - Source file references with line numbers
   - Code snippet explanations
   - Design pattern analysis

2. **BLASTEM_CODE_SNIPPETS.md** (13 KB)
   - 12 most critical functions
   - Complete code listings with inline comments
   - Usage patterns and examples
   - Direct copy-paste reference

3. **DEBUGGER_ARCHITECTURE_SUMMARY.md** (This file)
   - High-level overview
   - Five key questions answered
   - Critical paths summary
   - Adaptation strategy for SH2

---

## Next Steps for Virtua Racing Deluxe 32X

1. **Extract SH2 instruction format** from your analysis
2. **Implement SH2 decoder** similar to m68k_decode()
3. **Create sh2_context** with breakpoint array
4. **Adapt JIT translator** for breakpoint injection
5. **Test GDB protocol layer** with modified register layout
6. **Handle Master/Slave sync** through breakpoint placement at known sync points

The BlastEm architecture is production-quality and directly applicable to your 32X debugging needs.

