# BlastEm GDB Debugger Architecture Analysis

**Source**: https://github.com/libretro/blastem
**Last Updated**: 2026-01-10

## Executive Summary

BlastEm implements a **two-layer debugging system**:
1. **GDB Remote Protocol** (gdb_remote.c) - External debugging via GDB
2. **Integrated Debugger** (debug.c) - Built-in terminal-based debugger

Both share a common breakpoint infrastructure with intelligent temporary breakpoint handling for single-stepping and branch prediction.

---

## 1. DEBUG HOOK LOCATION

### 1.1 Code Injection Point (During JIT Translation)

**File**: `/tmp/blastem/m68k_core.c` (lines 952-965)
**Location**: `translate_m68k()` function - called during every instruction translation

```c
static void translate_m68k(m68k_context *context, m68kinst * inst)
{
    m68k_options * opts = context->options;
    if (inst->address & 1) {
        translate_m68k_odd(opts, inst);
        return;
    }
    code_ptr start = opts->gen.code.cur;
    check_cycles_int(&opts->gen, inst->address);

    m68k_debug_handler bp;
    if ((bp = find_breakpoint(context, inst->address))) {
        m68k_breakpoint_patch(context, inst->address, bp, start);  // <-- INJECTED HERE
    }
```

**Key Design Pattern**: Breakpoint check happens **at translation time** (JIT compilation), not execution time. This is efficient because:
- Breakpoint addresses checked against a fixed list
- If hit, the native code at that instruction is patched to call a stub
- Non-breakpoint instructions execute at full native speed with no overhead

### 1.2 Runtime Dispatch Point

**File**: `/tmp/blastem/m68k_core_x86.c` (lines 3192-3230)
**Function**: Breakpoint stub initialization during m68k_options setup

The compiled breakpoint stub:
```asm
// Generated code at opts->bp_stub:
call    save_context        // Save CPU state to m68k_context
push    scratch1            // Push address as argument
call    m68k_bp_dispatcher  // Call the handler dispatcher
mov     rax, context_reg    // Restore context pointer
call    load_context        // Restore CPU state
pop     scratch1            // Pop address
cmp     cycles, limit       // Check cycle limit
jcc     continue_prologue   // Handle cycle interrupt if needed
pop     scratch1            // Return address
add     scratch1, (check_int_size - patch_size)  // Skip prologue
jmp     scratch1            // Jump to actual instruction body
```

**Dispatcher**: `m68k_bp_dispatcher()` (lines 823-835 in m68k_core.c)
```c
m68k_context *m68k_bp_dispatcher(m68k_context *context, uint32_t address)
{
    m68k_debug_handler handler = find_breakpoint(context, address);
    if (handler) {
        handler(context, address);  // Call the registered handler function
    } else {
        warning("Spurious breakpoing at %X\n", address);
        remove_breakpoint(context, address);
    }
    return context;
}
```

---

## 2. BREAKPOINT DATA STRUCTURE

### 2.1 Core Breakpoint Definition

**File**: `/tmp/blastem/m68k_core.h` (lines 29-101)

```c
typedef void (*m68k_debug_handler)(m68k_context *context, uint32_t pc);

typedef struct {
    m68k_debug_handler handler;    // Function pointer to call on breakpoint hit
    uint32_t           address;    // CPU address where breakpoint is set
} m68k_breakpoint;

struct m68k_context {
    // ... other fields ...
    m68k_breakpoint *breakpoints;   // Dynamic array of breakpoints
    uint32_t        num_breakpoints; // Current count
    uint32_t        bp_storage;     // Allocated capacity (for doubling strategy)
    // ... other fields ...
}
```

### 2.2 GDB-Specific Wrapper Structure

**File**: `/tmp/blastem/debug.h` (lines 19-24)

```c
typedef struct bp_def {
    struct bp_def *next;          // Linked list for GDB/debugger tracking
    char          *commands;      // Associated debugger commands (future use)
    uint32_t      address;        // CPU address
    uint32_t      index;          // User-visible breakpoint ID (0, 1, 2, ...)
} bp_def;
```

### 2.3 Lookup Strategy

**File**: `/tmp/blastem/m68k_core.c` (lines 794-803)
**Lookup Cost**: O(n) linear scan

```c
static m68k_debug_handler find_breakpoint(m68k_context *context, uint32_t address)
{
    for (uint32_t i = 0; i < context->num_breakpoints; i++)
    {
        if (context->breakpoints[i].address == address) {
            return context->breakpoints[i].handler;
        }
    }
    return NULL;
}
```

**Design Note**: Linear search is acceptable because:
- Breakpoint count is typically very small (< 100)
- Lookup only happens during code translation, not per-instruction execution
- Could be optimized with hash table if needed

**Alternative GDB Lookup**: `/tmp/blastem/debug.c` (lines 25-34)
```c
bp_def ** find_breakpoint(bp_def ** cur, uint32_t address)
{
    while (*cur) {
        if ((*cur)->address == address) {
            break;
        }
        cur = &((*cur)->next);
    }
    return cur;  // Returns pointer-to-pointer for easy removal
}
```

---

## 3. EXECUTION CONTROL MECHANISMS

### 3.1 Continue/Run (GDB Command 'c')

**File**: `/tmp/blastem/gdb_remote.c` (lines 177-184)

```c
case 'c':
    if (*(command+1) != 0) {
        //TODO: implement resuming at an arbitrary address
        goto not_impl;
    }
    cont = 1;                      // Signal to exit debug loop
    expect_break_response = 1;     // Expect a response when next breakpoint hits
    break;
```

**Control Flow**:
1. Sets `cont = 1` flag
2. This exits the `while(!cont)` loop in `gdb_debug_enter()`
3. Execution resumes from current PC in the emulated CPU
4. Next breakpoint (or breakpoint dispatcher call) re-enters `gdb_debug_enter()`

### 3.2 Single-Step (GDB Command 's' / 'vCont;s')

**File**: `/tmp/blastem/gdb_remote.c` (lines 185-221)

```c
case 's': {
    if (*(command+1) != 0) {
        goto not_impl;  // TODO: resume at arbitrary address
    }
    m68kinst inst;
    genesis_context *gen = context->system;
    uint16_t * pc_ptr = get_native_pointer(pc, (void **)context->mem_pointers,
                                           &context->options->gen);
    if (!pc_ptr) {
        fatal_error("Entered gdb remote debugger stub at address %X\n", pc);
    }

    // Decode current instruction
    uint16_t * after_pc = m68k_decode(pc_ptr, &inst, pc & 0xFFFFFF);
    uint32_t after = pc + (after_pc-pc_ptr)*2;

    // Handle subroutine returns - fetch actual return address
    if (inst.op == M68K_RTS) {
        after = (read_dma_value(context->aregs[7]/2) << 16) |
                read_dma_value(context->aregs[7]/2 + 1);
    } else if (inst.op == M68K_RTE || inst.op == M68K_RTR) {
        after = (read_dma_value((context->aregs[7]+2)/2) << 16) |
                read_dma_value((context->aregs[7]+2)/2 + 1);
    }
    // Handle conditional branches - set breakpoints on BOTH paths
    else if(m68k_is_branch(&inst)) {
        if (inst.op == M68K_BCC && inst.extra.cond != COND_TRUE) {
            branch_f = after;  // Branch not taken path
            branch_t = m68k_branch_target(&inst, context->dregs, context->aregs)
                       & 0xFFFFFF;  // Branch taken path
            insert_breakpoint(context, branch_t, gdb_debug_enter);
        } else if(inst.op == M68K_DBCC && inst.extra.cond != COND_FALSE) {
            branch_t = after;
            branch_f = m68k_branch_target(&inst, context->dregs, context->aregs)
                       & 0xFFFFFF;
            insert_breakpoint(context, branch_f, gdb_debug_enter);
        } else {
            after = m68k_branch_target(&inst, context->dregs, context->aregs)
                    & 0xFFFFFF;
        }
    }

    // Insert breakpoint at calculated destination
    insert_breakpoint(context, after, gdb_debug_enter);

    cont = 1;
    expect_break_response = 1;
    break;
}
```

**Key Insight - Intelligent Temporary Breakpoints**:
- Decodes instruction at decode-time (not JIT overhead)
- Inserts temporary breakpoint(s) at next logical instruction
- For **conditional branches**: sets breakpoints on BOTH possible paths
- For **unconditional branches/calls**: knows exact target
- For **RTS**: reads stack to find actual return address
- Uses `branch_t` and `branch_f` static variables to track which path was taken

### 3.3 Step Into/Over (Integrated Debugger)

**File**: `/tmp/blastem/debug.c` (lines 741-803)

**'n' Command (Step Over)**:
```c
case 'n':
    if (inst.op == M68K_RTS) {
        after = m68k_read_long(context->aregs[7], context);
    } else if (inst.op == M68K_RTE || inst.op == M68K_RTR) {
        after = m68k_read_long(context->aregs[7] + 2, context);
    } else if(m68k_is_noncall_branch(&inst)) {
        // Handle branches like GDB does
        if (inst.op == M68K_BCC && inst.extra.cond != COND_TRUE) {
            branch_f = after;
            branch_t = m68k_branch_target(&inst, context->dregs, context->aregs);
            insert_breakpoint(context, branch_t, debugger);
        } else if(inst.op == M68K_DBCC) {
            if ( inst.extra.cond == COND_FALSE) {
                if (context->dregs[inst.dst.params.regs.pri] & 0xFFFF) {
                    after = m68k_branch_target(&inst, context->dregs, context->aregs);
                }
            } else {
                branch_t = after;
                branch_f = m68k_branch_target(&inst, context->dregs, context->aregs);
                insert_breakpoint(context, branch_f, debugger);
            }
        } else {
            after = m68k_branch_target(&inst, context->dregs, context->aregs);
        }
    }
    insert_breakpoint(context, after, debugger);
    return 0;  // Exit debugger, resume execution
```

**'o' Command (Step Out - advance until after forward branch)**:
- Steps over forward branches (like loops)
- Runs until instruction after backward branches

---

## 4. TRACE INFRASTRUCTURE

### 4.1 Trace State in Context

**File**: `/tmp/blastem/m68k_core.h` (line 98)

```c
struct m68k_context {
    // ... other fields ...
    uint8_t         trace_pending;  // M68K_STATUS_TRACE flag handler
    // ... other fields ...
}
```

### 4.2 Trace Flag Serialization

**File**: `/tmp/blastem/m68k_core.c` (lines 1255, 1282)

```c
// In m68k_serialize():
save_int8(buf, context->trace_pending);

// In m68k_deserialize():
context->trace_pending = load_int8(buf);
```

### 4.3 Instruction Logging (Optional)

**File**: `/tmp/blastem/m68k_core.c` (lines 960-967)

```c
code_ptr start = opts->gen.code.cur;
check_cycles_int(&opts->gen, inst->address);

m68k_debug_handler bp;
if ((bp = find_breakpoint(context, inst->address))) {
    m68k_breakpoint_patch(context, inst->address, bp, start);
}

//log_address(&opts->gen, inst->address, "M68K: %X @ %d\n");  // <-- DISABLED
```

**Current Status**: Instruction logging is compiled out but infrastructure exists via:
- `opts->address_log` (FILE pointer in m68k_options)
- Could log every translated instruction if enabled

### 4.4 Memory Tracing

**Findings**: No built-in memory trace logging found. Watchpoint support is explicitly noted as **not currently implemented**:

**File**: `/tmp/blastem/gdb_remote.c` (lines 241-263)

```c
case 'Z': {
    uint8_t type = command[1];
    if (type < '2') {  // type 0 = instruction breakpoint, 1 = data breakpoint
        // ... handle software breakpoint ...
    } else {
        //watchpoints are not currently supported
        gdb_send_command("");  // Send empty response (not implemented)
    }
    break;
}
```

---

## 5. MULTI-CPU COORDINATION

### 5.1 Current Support Level

**Status**: Single-CPU only for GDB debugging

**File**: `/tmp/blastem/gdb_remote.c` (lines 384-395)

```c
else if (command[1] == 'C') {
    //we only support a single thread currently, so send 1
    gdb_send_command("QC1");
} else if (!strcmp("fThreadInfo", command + 1)) {
    //we only support a single thread currently, so send 1
    gdb_send_command("m1");
} else if (!strcmp("sThreadInfo", command + 1)) {
    gdb_send_command("l");
}
```

### 5.2 Genesis System Context

The architecture includes pointer to parent system:

**File**: `/tmp/blastem/m68k_core.h` (lines 77-101)

```c
struct m68k_context {
    // ... core registers ...
    void            *system;        // Pointer to genesis_context
    m68k_breakpoint *breakpoints;
    uint32_t        num_breakpoints;
    // ... other fields ...
}
```

**Design Pattern for Future Multi-CPU**:
- `system` pointer allows callbacks to sibling CPU contexts
- `genesis_context` contains pointers to both 68K and Z80 contexts
- Z80 debugging already implemented separately (z80_context, zdebugger function)
- Could extend with SH2 context pointers

### 5.3 Z80 Debug Support (Parallel Example)

The integrated debugger has **separate** Z80 support, showing the pattern:

**File**: `/tmp/blastem/debug.c` (lines 370-395)

```c
z80_context * zdebugger(z80_context * context, uint16_t address)
{
    // ... Z80-specific debugging ...
    bp_def ** this_bp = find_breakpoint(&zbreakpoints, address);
    if (*this_bp) {
        printf("Z80 Breakpoint %d hit\n", (*this_bp)->index);
    } else {
        zremove_breakpoint(context, address);
    }
    // ... same breakpoint/step logic as M68K ...
}
```

---

## 6. GDB PROTOCOL IMPLEMENTATION

### 6.1 Message Format

**File**: `/tmp/blastem/gdb_remote.c` (lines 103-112)

```c
void gdb_send_command(char * command)
{
    char end[3];
    write_or_die(GDB_OUT_FD, "$", 1);           // Start marker
    write_or_die(GDB_OUT_FD, command, strlen(command));
    end[0] = '#';
    gdb_calc_checksum(command, end+1);          // Append checksum
    write_or_die(GDB_OUT_FD, end, 3);
    // Format: $<command>#<2-digit-hex-checksum>
}
```

### 6.2 Message Reception & Parsing

**File**: `/tmp/blastem/gdb_remote.c` (lines 497-550)

```c
void gdb_debug_enter(m68k_context * context, uint32_t pc)
{
    // ... breakpoint cleanup ...

    cont = 0;
    uint8_t partial = 0;
    while(!cont)  // <-- MAIN DEBUG LOOP
    {
        if (!curbuf) {
            int numread = GDB_READ(GDB_IN_FD, buf, bufsize);
            curbuf = buf;
            end = buf + numread;
        } else if (partial) {
            // Handle partial message reads
            memmove(curbuf, buf, end-curbuf);
            end -= curbuf - buf;
            int numread = GDB_READ(GDB_IN_FD, end, bufsize - (end-buf));
            end += numread;
            curbuf = buf;
        }

        for (; curbuf < end; curbuf++)
        {
            if (*curbuf == '$')  // Start of message
            {
                curbuf++;
                char * start = curbuf;
                while (curbuf < end && *curbuf != '#') {
                    curbuf++;  // Find end marker
                }
                if (*curbuf == '#') {
                    if (end-curbuf >= 2) {  // Have both checksum bytes
                        *curbuf = 0;  // Null terminate
                        GDB_WRITE(GDB_OUT_FD, "+", 1);  // Send ACK
                        gdb_run_command(context, pc, start);  // Dispatch
                        curbuf += 2;  // Skip checksum bytes
                    }
                } else {
                    curbuf--;
                    partial = 1;
                    break;  // Wait for more data
                }
            }
        }
    }
}
```

**Supported Commands**:
- `c` - Continue
- `s` / `vCont;s` - Single step
- `vCont;c` - Continue variant
- `Z0,<addr>,<len>` - Set software breakpoint
- `z0,<addr>,<len>` - Remove software breakpoint
- `Z1,Z2+` - Data/hardware breakpoint (not implemented)
- `g` - Read all registers
- `p<n>` - Read register n
- `P<n>=<val>` - Write register n
- `m<addr>,<len>` - Read memory
- `M<addr>,<len>:<data>` - Write memory
- `q<query>` - Query various info (Supported, Attached, Offsets, Symbol, TStatus, ThreadInfo, etc.)
- `?` - Query last signal
- `H<c|g><id>` - Set thread (no-op, single threaded)

### 6.3 Register Access

**File**: `/tmp/blastem/gdb_remote.c` (lines 266-344)

```c
case 'g': {  // Read all registers
    char * cur = send_buf;
    for (int i = 0; i < 8; i++)  // D0-D7
        hex_32(context->dregs[i], cur);
        cur += 8;
    }
    for (int i = 0; i < 8; i++)  // A0-A7
        hex_32(context->aregs[i], cur);
        cur += 8;
    }
    hex_32(calc_status(context), cur);  // SR (constructed from status + flags)
    cur += 8;
    hex_32(pc, cur);                     // PC
    cur += 8;
    *cur = 0;
    gdb_send_command(send_buf);
    break;
}
```

**Status Register Construction**:
```c
uint32_t calc_status(m68k_context * context)
{
    uint32_t status = context->status << 3;  // Supervisor/trace bits
    for (int i = 0; i < 5; i++)
    {
        status <<= 1;
        status |= context->flags[i];  // XNZVC flags
    }
    return status;
}
```

---

## CLEVER DESIGN PATTERNS TO EMULATE

### 1. **Handler Pointer in Breakpoint Structure**
- Breakpoint doesn't just store address - stores a **function pointer**
- Allows different debug entry points (GDB vs. integrated debugger)
- Same data structure works for both contexts
- Makes code reusable: `insert_breakpoint(context, addr, gdb_debug_enter)` or `insert_breakpoint(context, addr, debugger)`

### 2. **JIT-Time Breakpoint Injection**
- Breakpoints checked during code translation, not execution
- Native code patched once, then runs at full speed
- Eliminates per-instruction overhead
- Alternative to table lookup in execution loop

### 3. **Intelligent Temporary Breakpoints for Stepping**
- Decode instruction without executing
- Predict all possible next addresses
- Set breakpoints on **multiple branches** if necessary
- Track which path was taken via `branch_t`/`branch_f` comparison
- Auto-clean temporary breakpoints on hit if not user-set

### 4. **Branch Path Tracking in GDB Debug Enter**
```c
if ((pc & 0xFFFFFF) == branch_t) {
    bp_def ** f_bp = find_breakpoint(&breakpoints, branch_f);
    if (!*f_bp) {  // If false path wasn't a user breakpoint
        remove_breakpoint(context, branch_f);  // Remove temporary
    }
}
```
- Cheap way to handle branch without storing full instruction metadata
- Reuses register decoding from step command

### 5. **Streaming Message Parser**
- Handles partial GDB packets gracefully
- Accumulates data with `curbuf` pointer
- Handles network packet boundaries without corruption
- Could easily extend to socket timeout logic

### 6. **Address Log Infrastructure (Disabled)**
- System for instruction-by-instruction logging already in place
- Just commented out, easy to re-enable
- FILE* pointer in options structure
- Shows forethought for post-mortem analysis

### 7. **Pointer-to-Pointer for List Removal**
```c
bp_def ** found = find_breakpoint(&breakpoints, address);
if (*found) {
    bp_def * to_remove = *found;
    *found = to_remove->next;  // Unlink from list
    free(to_remove);
}
```
- Classic C idiom that avoids special case for first element
- Used in both GDB and integrated debugger breakpoint removal

---

## RECOMMENDATIONS FOR VIRTUA RACING 32X SH2 DEBUGGING

### 1. **Adapt the Breakpoint Structure**
```c
// Keep the handler pattern
typedef void (*sh2_debug_handler)(sh2_context *context, uint32_t pc);
typedef struct {
    sh2_debug_handler handler;
    uint32_t address;
} sh2_breakpoint;
```

### 2. **Implement SH2 JIT Breakpoint Patching**
- Like m68k_breakpoint_patch() but for SH2 native code
- Inject calls to `sh2_bp_dispatcher()` at instruction boundaries
- No per-instruction overhead when no breakpoints

### 3. **Master/Slave Synchronization Points**
- Extend to handle dual-SH2 stepping
- Option 1: Step both CPUs in lock-step (slower but synchronized)
- Option 2: Breakpoint when SH2s hit specific synchronization points
- Track Master/Slave IPC via shared memory addresses

### 4. **Reuse GDB Protocol Layer**
- Can reuse most of gdb_remote.c with SH2-specific register handling
- Change register decoding (SH2 has different register set: R0-R15, PC, PR, SR, GBR, etc.)
- Register 0-15 are general purpose, need to handle special registers

### 5. **Add SH2-Specific Step Logic**
- SH2 instructions can be shorter (16-bit vs 68K 16/32-bit)
- After decoding at SH2 address, may need to handle:
  - Delay slot instructions
  - Bank register changes (important for 32X VDP)
  - Interrupt disable state changes

### 6. **Memory Tracing for VDP Analysis**
- Implement the "commented out" address_log feature for SH2
- Log every write to VDP registers (0xA15100+)
- Enable post-mortem analysis of rendering pipeline

### 7. **Conditional Breakpoint Scripting**
- `commands` field in breakpoint struct is currently unused
- Could store debugger commands to auto-execute on hit
- E.g., "break at VDP register write, dump frame counter"

---

## SUMMARY TABLE

| Aspect | Implementation | Notes |
|--------|---|---|
| Hook Location | JIT translation time (m68k_core.c:963) | Efficient, zero overhead when no breakpoints |
| Data Structure | Fixed array + dynamic reallocation | O(n) lookup, acceptable for small breakpoint counts |
| Continue | `cont = 1` flag + exit debug loop | Simple state machine |
| Single Step | Decode instruction, set temp breakpoints on next addresses | Intelligent path prediction |
| Trace | Serialization support exists | No instruction-by-instruction logging currently |
| Memory Trace | Infrastructure exists but disabled | Watchpoints not implemented |
| Multi-CPU | Single thread only in GDB | Z80 debugger separate, extensible design |
| GDB Protocol | Streaming message parser | Handles partial packets, minimal overhead |

---

## SOURCE FILES REFERENCE

| File | Key Content |
|------|---|
| `/tmp/blastem/gdb_remote.c` | GDB protocol parser and command handler (588 lines) |
| `/tmp/blastem/gdb_remote.h` | GDB interface header (debug_enter function) |
| `/tmp/blastem/debug.c` | Integrated terminal debugger (~1000 lines) |
| `/tmp/blastem/debug.h` | Breakpoint and display structure definitions |
| `/tmp/blastem/m68k_core.c` | 68K execution, breakpoint insertion/removal (1283 lines) |
| `/tmp/blastem/m68k_core.h` | 68K context and breakpoint type definitions |
| `/tmp/blastem/m68k_core_x86.c` | JIT compilation, bp_stub generation (x86-64 backend) |

