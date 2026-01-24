# BlastEm Debugger - Critical Code Snippets

Quick reference for key functions to adapt for SH2 debugging.

## 1. Breakpoint Data Structures (m68k_core.h)

```c
// Handler function type - called when breakpoint is hit
typedef void (*m68k_debug_handler)(m68k_context *context, uint32_t pc);

// Single breakpoint entry
typedef struct {
    m68k_debug_handler handler;    // Which function to call
    uint32_t           address;    // Breakpoint address
} m68k_breakpoint;

// In m68k_context structure:
struct m68k_context {
    m68k_breakpoint *breakpoints;     // Dynamic array
    uint32_t        num_breakpoints;  // Count
    uint32_t        bp_storage;       // Capacity (for doubling)
    // ...
}
```

## 2. Breakpoint Lookup (m68k_core.c:794-803)

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

## 3. Breakpoint Insertion (m68k_core.c:805-821)

```c
void insert_breakpoint(m68k_context * context, uint32_t address,
                       m68k_debug_handler bp_handler)
{
    if (!find_breakpoint(context, address)) {
        // Double array if full
        if (context->bp_storage == context->num_breakpoints) {
            context->bp_storage *= 2;
            if (context->bp_storage < 4) {
                context->bp_storage = 4;
            }
            context->breakpoints = realloc(context->breakpoints,
                                         context->bp_storage * sizeof(m68k_breakpoint));
        }

        // Add new breakpoint
        context->breakpoints[context->num_breakpoints++] = (m68k_breakpoint){
            .handler = bp_handler,
            .address = address
        };

        // Patch native code to call handler
        m68k_breakpoint_patch(context, address, bp_handler, NULL);
    }
}
```

## 4. Breakpoint Removal (m68k_core.c:1148-1169)

```c
void remove_breakpoint(m68k_context * context, uint32_t address)
{
    for (uint32_t i = 0; i < context->num_breakpoints; i++)
    {
        if (context->breakpoints[i].address == address) {
            // Swap with last element for O(1) removal
            if (i != (context->num_breakpoints-1)) {
                context->breakpoints[i] = context->breakpoints[context->num_breakpoints-1];
            }
            context->num_breakpoints--;
            break;
        }
    }

    // Restore original instruction code
    code_ptr native = get_native_address(context->options, address);
    if (!native) {
        return;
    }

    code_info tmp = context->options->gen.code;
    context->options->gen.code.cur = native;
    context->options->gen.code.last = native + MAX_NATIVE_SIZE;
    check_cycles_int(&context->options->gen, address);
    context->options->gen.code = tmp;
}
```

## 5. Breakpoint Dispatcher (m68k_core.c:823-835)

```c
m68k_context *m68k_bp_dispatcher(m68k_context *context, uint32_t address)
{
    m68k_debug_handler handler = find_breakpoint(context, address);
    if (handler) {
        handler(context, address);  // Call appropriate handler
    } else {
        // Spurious breakpoint - clean it up
        warning("Spurious breakpoing at %X\n", address);
        remove_breakpoint(context, address);
    }
    return context;
}
```

## 6. JIT-Time Breakpoint Injection (m68k_core.c:952-965)

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

    // THIS IS WHERE BREAKPOINTS ARE INJECTED
    m68k_debug_handler bp;
    if ((bp = find_breakpoint(context, inst->address))) {
        m68k_breakpoint_patch(context, inst->address, bp, start);
    }

    // ... rest of instruction translation ...
}
```

## 7. Breakpoint Native Code Patching (m68k_core_x86.c:2542-2562)

```c
void m68k_breakpoint_patch(m68k_context *context, uint32_t address,
                           m68k_debug_handler bp_handler, code_ptr native_addr)
{
    m68k_options * opts = context->options;
    code_info native;
    native.cur = native_addr ? native_addr : get_native_address(context->options, address);

    if (!native.cur) {
        return;
    }

    if (*native.cur != opts->prologue_start) {
        // Already patched for retranslation
        return;
    }

    native.last = native.cur + 128;
    native.stack_off = 0;
    code_ptr start_native = native.cur;

    // Emit native code:
    // mov address, scratch1  (pass address as argument)
    // call bp_stub           (dispatcher handles the rest)
    mov_ir(&native, address, opts->gen.scratch1, SZ_D);
    call(&native, opts->bp_stub);
}
```

## 8. Breakpoint Stub (Generated Code - m68k_core_x86.c:3192-3230)

Pseudo-code showing what bp_stub does:

```nasm
bp_stub:
    call    save_context              ; Save m68k_context to memory
    push    scratch1                  ; Address parameter
    call    m68k_bp_dispatcher        ; Call dispatcher with (context, address)
    mov     rax, context_register     ; Get returned context
    call    load_context              ; Restore m68k_context
    pop     scratch1                  ; Pop return/address
    cmp     cycles, cycle_limit       ; Check if we hit cycle limit
    jcc     skip_interrupt_handler    ; If not taken, skip
    call    handle_cycle_limit_int    ; Handle interrupt
skip_interrupt_handler:
    pop     scratch1                  ; Restore return address
    add     scratch1, prologue_size   ; Skip prologue, point to instruction body
    jmp     scratch1                  ; Jump to actual instruction code
```

## 9. GDB Single-Step Logic (gdb_remote.c:185-221)

```c
case 's': {  // Step command
    m68kinst inst;
    genesis_context *gen = context->system;
    uint16_t * pc_ptr = get_native_pointer(pc, (void **)context->mem_pointers,
                                           &context->options->gen);

    // Decode current instruction
    uint16_t * after_pc = m68k_decode(pc_ptr, &inst, pc & 0xFFFFFF);
    uint32_t after = pc + (after_pc-pc_ptr)*2;

    // Handle subroutine returns
    if (inst.op == M68K_RTS) {
        after = (read_dma_value(context->aregs[7]/2) << 16) |
                read_dma_value(context->aregs[7]/2 + 1);
    }
    else if (inst.op == M68K_RTE || inst.op == M68K_RTR) {
        after = (read_dma_value((context->aregs[7]+2)/2) << 16) |
                read_dma_value((context->aregs[7]+2)/2 + 1);
    }
    // Handle conditional branches - TWO possible paths
    else if(m68k_is_branch(&inst)) {
        if (inst.op == M68K_BCC && inst.extra.cond != COND_TRUE) {
            branch_f = after;  // Not taken
            branch_t = m68k_branch_target(&inst, context->dregs, context->aregs)
                       & 0xFFFFFF;  // Taken
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

    insert_breakpoint(context, after, gdb_debug_enter);
    cont = 1;
    expect_break_response = 1;
    break;
}
```

## 10. GDB Debug Entry Point (gdb_remote.c:469-551)

```c
void gdb_debug_enter(m68k_context * context, uint32_t pc)
{
    // Clean up temporary breakpoints from previous step
    if ((pc & 0xFFFFFF) == branch_t) {
        bp_def ** f_bp = find_breakpoint(&breakpoints, branch_f);
        if (!*f_bp) {  // Only if not user-set
            remove_breakpoint(context, branch_f);
        }
        branch_t = branch_f = 0;
    } else if((pc & 0xFFFFFF) == branch_f) {
        bp_def ** t_bp = find_breakpoint(&breakpoints, branch_t);
        if (!*t_bp) {  // Only if not user-set
            remove_breakpoint(context, branch_t);
        }
        branch_t = branch_f = 0;
    }

    // Check if this is a user-set breakpoint
    bp_def ** this_bp = find_breakpoint(&breakpoints, pc & 0xFFFFFF);
    if (!*this_bp) {
        remove_breakpoint(context, pc & 0xFFFFFF);
    }

    resume_pc = pc;
    cont = 0;  // Enter debug loop

    // Main GDB message loop
    while(!cont)
    {
        // Read from GDB socket/stdin
        if (!curbuf) {
            int numread = GDB_READ(GDB_IN_FD, buf, bufsize);
            curbuf = buf;
            end = buf + numread;
        }

        // Parse messages
        for (; curbuf < end; curbuf++)
        {
            if (*curbuf == '$')  // Start of GDB packet
            {
                curbuf++;
                char * start = curbuf;
                while (curbuf < end && *curbuf != '#') {
                    curbuf++;
                }
                if (*curbuf == '#') {
                    if (end-curbuf >= 2) {
                        *curbuf = 0;  // Null terminate
                        GDB_WRITE(GDB_OUT_FD, "+", 1);  // ACK
                        gdb_run_command(context, pc, start);  // Dispatch
                        curbuf += 2;  // Skip checksum
                    }
                }
            }
        }
    }
}
```

## 11. GDB Command Dispatcher (gdb_remote.c:170-184)

```c
void gdb_run_command(m68k_context * context, uint32_t pc, char * command)
{
    char send_buf[512];

    switch(*command)
    {
    case 'c':  // Continue
        cont = 1;
        expect_break_response = 1;
        break;

    case 'Z':  // Set breakpoint
    {
        uint8_t type = command[1];  // Type: 0=software, 1=data, 2+=hw
        if (type < '2') {
            uint32_t address = strtoul(command+3, NULL, 16);
            insert_breakpoint(context, address, gdb_debug_enter);

            // Add to GDB wrapper list for ID management
            bp_def *new_bp = malloc(sizeof(bp_def));
            new_bp->next = breakpoints;
            new_bp->address = address;
            new_bp->index = bp_index++;
            breakpoints = new_bp;

            gdb_send_command("OK");
        } else {
            // Watchpoints not implemented
            gdb_send_command("");
        }
        break;
    }

    case 'z':  // Remove breakpoint
    {
        uint8_t type = command[1];
        if (type < '2') {
            uint32_t address = strtoul(command+3, NULL, 16);
            remove_breakpoint(context, address);

            // Remove from GDB wrapper list
            bp_def **found = find_breakpoint(&breakpoints, address);
            if (*found) {
                bp_def * to_remove = *found;
                *found = to_remove->next;
                free(to_remove);
            }

            gdb_send_command("OK");
        } else {
            gdb_send_command("");
        }
        break;
    }

    case 'g':  // Read all registers
        // Format: DDDDDDDD (D0) ... DDDDDDDD (A7) DDDDDDDD (SR) DDDDDDDD (PC)
        // Each register is 8 hex digits
        gdb_send_command(send_buf);
        break;

    case '?':  // Query last signal
        gdb_send_command("S05");  // Signal 5 = SIGTRAP
        break;
    }
}
```

## 12. GDB Protocol Message Sending (gdb_remote.c:86-112)

```c
// Calculate checksum of command
void gdb_calc_checksum(char * command, char *out)
{
    uint8_t checksum = 0;
    while (*command)
    {
        checksum += *(command++);
    }
    hex_8(checksum, out);  // Convert to hex
}

// Send formatted message to GDB
void gdb_send_command(char * command)
{
    char end[3];
    write_or_die(GDB_OUT_FD, "$", 1);           // $ = start
    write_or_die(GDB_OUT_FD, command, strlen(command));
    end[0] = '#';
    gdb_calc_checksum(command, end+1);          // Calculate checksum
    write_or_die(GDB_OUT_FD, end, 3);           // #HH = checksum

    // Format: $<payload>#<checksum>
    // Example: $S05#ab
}
```

---

## Usage Pattern for SH2 Implementation

```c
// 1. Allocate breakpoints in context init
sh2_context->breakpoints = malloc(4 * sizeof(sh2_breakpoint));
sh2_context->num_breakpoints = 0;
sh2_context->bp_storage = 4;

// 2. When setting a breakpoint from GDB
insert_breakpoint(sh2_context, 0x02000100, sh2_gdb_debug_enter);

// 3. During SH2 JIT translation
static void translate_sh2(sh2_context *context, sh2inst *inst)
{
    sh2_debug_handler bp;
    if ((bp = find_breakpoint(context, inst->address))) {
        sh2_breakpoint_patch(context, inst->address, bp, current_native_code);
    }
    // ... rest of translation ...
}

// 4. When user continues execution
case 'c':
    cont = 1;
    break;

// 5. Execution resumes, hits breakpoint, calls handler
void sh2_gdb_debug_enter(sh2_context *context, uint32_t pc)
{
    gdb_send_command("S05");  // Signal SIGTRAP
    while(!cont) {
        // Read and process GDB commands
        gdb_read_and_dispatch();
    }
}
```

