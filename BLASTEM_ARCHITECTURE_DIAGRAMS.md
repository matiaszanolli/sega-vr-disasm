# BlastEm Debugger Architecture - Visual Diagrams

## 1. Breakpoint Injection Flow (JIT Time)

```
┌─────────────────────────────────────────────────────────────┐
│ Code Execution Loop in Emulated System                      │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       │ fetch instruction @ 0x000100
                       │
                       ▼
┌──────────────────────────────────────────────────────────────┐
│ JIT Compiler: translate_m68k(context, inst@0x000100)         │
│                                                              │
│  code_ptr start = opts->gen.code.cur;                       │
│  check_cycles_int(&opts->gen, inst->address);               │
│                                                              │
│  ┌─────────────────────────────────────────────────────────┐│
│  │ IF breakpoint set at 0x000100?                          ││
│  │   find_breakpoint(context, 0x000100) -> handler?        ││
│  │                                                         ││
│  │   YES ──┐                                              ││
│  │         │                                              ││
│  │         ▼                                              ││
│  │   m68k_breakpoint_patch(ctx, 0x000100, handler, code)  ││
│  │   ├─ Emit: mov 0x000100, scratch1                      ││
│  │   └─ Emit: call opts->bp_stub                          ││
│  │                                                         ││
│  │   Native code at 0x000100 now:                         ││
│  │   ┌─────────────────────────────────────┐             ││
│  │   │ save_context()                      │ (patched)  ││
│  │   │ push scratch1 (address)             │             ││
│  │   │ call m68k_bp_dispatcher             │             ││
│  │   │ load_context()                      │             ││
│  │   │ jmp to actual instruction           │             ││
│  │   └─────────────────────────────────────┘             ││
│  │                                                         ││
│  │   NO ──┐                                               ││
│  │        │                                               ││
│  │        ▼                                               ││
│  │   Generate normal instruction                          ││
│  │   (zero breakpoint overhead)                           ││
│  └─────────────────────────────────────────────────────────┘
│                                                             │
│  ... rest of instruction translation ...                   │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       │ Continue emulation
                       │
                       ▼
┌──────────────────────────────────────────────────────────────┐
│ Runtime: Execution reaches address 0x000100                  │
│                                                              │
│ ▼ (Jump to native code for 0x000100)                        │
│ ┌──────────────────────────────────────┐                    │
│ │ save_context() - store CPU state     │ (patched code)    │
│ │ push 0x000100                        │                    │
│ │ call m68k_bp_dispatcher              │                    │
│ └──────────────────────────────────────┘                    │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌──────────────────────────────────────────────────────────────┐
│ m68k_bp_dispatcher(context, 0x000100)                        │
│                                                              │
│  m68k_debug_handler handler = find_breakpoint(ctx, 0x000100)│
│  if (handler) {                                              │
│      handler(context, 0x000100);  ──────┐                   │
│  }                                       │                   │
│  return context;                        │                   │
└──────────────────────────────────────────┼──────────────────┘
                                           │
                                           ├─ If handler = gdb_debug_enter
                                           │  └─ GDB debugging active
                                           │
                                           └─ If handler = debugger
                                              └─ Console debugging active
```

---

## 2. Single-Step Execution Flow

```
┌──────────────────────────────────────────────────────────────┐
│ GDB Client sends "$s#XX" (step command)                      │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌──────────────────────────────────────────────────────────────┐
│ gdb_debug_enter() message loop receives "$s#XX"              │
│                                                              │
│  gdb_send_command("+");  // ACK                              │
│  gdb_run_command(ctx, pc, "s");                              │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌──────────────────────────────────────────────────────────────┐
│ gdb_run_command(ctx, 0x000100, "s")    // Step command      │
│                                                              │
│  case 's': {                                                 │
│    // 1. Decode current instruction WITHOUT executing       │
│    m68kinst inst;                                            │
│    m68k_decode(pc_ptr, &inst, pc);                           │
│    uint32_t after = pc + instruction_length;                │
│                                                              │
│    // 2. Predict next address(es)                           │
│    ┌─────────────────────────────────────────────┐          │
│    │ IF RTS:      after = read_stack(a7)         │          │
│    │ IF RTE/RTR:  after = read_stack(a7+2)       │          │
│    │ IF branch:                                  │          │
│    │   ┌────────────────────────────────────┐   │          │
│    │   │ IF conditional branch:             │   │          │
│    │   │   branch_t = target               │   │          │
│    │   │   branch_f = after                │   │          │
│    │   │   insert_breakpoint(ctx, target, │   │          │
│    │   │                    gdb_debug_enter)   │          │
│    │   │   insert_breakpoint(ctx, after,  │   │          │
│    │   │                    gdb_debug_enter)   │          │
│    │   │                                   │   │          │
│    │   │ ELSE (unconditional branch):    │   │          │
│    │   │   after = target                 │   │          │
│    │   └────────────────────────────────────┘   │          │
│    └─────────────────────────────────────────────┘          │
│                                                              │
│    // 3. Set breakpoint at next instruction                 │
│    insert_breakpoint(context, after, gdb_debug_enter);      │
│                                                              │
│    // 4. Resume execution                                   │
│    cont = 1;                                                 │
│    expect_break_response = 1;                                │
│  }                                                           │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌──────────────────────────────────────────────────────────────┐
│ Exit gdb_debug_enter() loop (cont == 1)                     │
│ Resume emulated CPU execution                                │
│                                                              │
│ ┌──────────────────────────────────────┐                    │
│ │ Execute instruction @ 0x000100       │ (Breakpoint stub) │
│ │ Call gdb_debug_enter() again         │ (Temporary BP)   │
│ └──────────────────────────────────────┘                    │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌──────────────────────────────────────────────────────────────┐
│ gdb_debug_enter() called again @ temporary breakpoint        │
│                                                              │
│  // Clean up temporary breakpoints                          │
│  if (pc == branch_t) {                                       │
│      if (!find_breakpoint(&breakpoints, branch_f)) {        │
│          remove_breakpoint(context, branch_f);  // Cleanup  │
│      }                                                       │
│  } else if (pc == branch_f) {                               │
│      if (!find_breakpoint(&breakpoints, branch_t)) {        │
│          remove_breakpoint(context, branch_t);  // Cleanup  │
│      }                                                       │
│  }                                                           │
│                                                              │
│  // Send trap signal to GDB                                 │
│  gdb_send_command("S05");  // SIGTRAP                        │
│                                                              │
│  // Wait for next GDB command                               │
│  cont = 0;                                                   │
│  while (!cont) {                                             │
│      // Read GDB message                                    │
│      // Process command                                     │
│  }                                                           │
└──────────────────────┬──────────────────────────────────────┘
                       │
                       ▼
┌──────────────────────────────────────────────────────────────┐
│ GDB Client receives "$S05#XX" and displays new register state│
│ User ready for next step command                             │
└──────────────────────────────────────────────────────────────┘
```

---

## 3. Breakpoint Data Structure Relationship

```
┌─────────────────────────────────────────────────────────────┐
│ m68k_context (emulator state)                               │
├─────────────────────────────────────────────────────────────┤
│ uint32_t dregs[8]                                            │
│ uint32_t aregs[8]                                            │
│ ... other CPU state ...                                      │
│                                                              │
│ ┌─────────────────────────────────────────────────────────┐ │
│ │ m68k_breakpoint *breakpoints  ──┐                       │ │
│ │ uint32_t num_breakpoints        │ (Dynamic array)      │ │
│ │ uint32_t bp_storage             │                       │ │
│ │                                  │                       │ │
│ └──────────────────────────────────┼───────────────────────┘ │
│                                    │                         │
└────────────────────────────────────┼─────────────────────────┘
                                     │
                                     ▼
          ┌──────────────────────────────────────────────┐
          │ m68k_breakpoint breakpoints[4] (initial cap) │
          ├──────────────────────────────────────────────┤
          │ [0] {                                        │
          │      handler: gdb_debug_enter (function ptr) │
          │      address: 0x000100                       │
          │     }                                        │
          │ [1] {                                        │
          │      handler: gdb_debug_enter                │
          │      address: 0x000200                       │
          │     }                                        │
          │ [2] {                                        │
          │      handler: debugger (console debugger)    │
          │      address: 0x000300                       │
          │     }                                        │
          │ [3] { ... unused ... }                       │
          │                                              │
          │ num_breakpoints = 3                          │
          │ bp_storage = 4                               │
          │                                              │
          │ (When num_breakpoints == bp_storage,         │
          │  array will be reallocated at 2x size)       │
          └──────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────┐
│ GDB Wrapper: bp_def (parallel linked list structure)         │
├──────────────────────────────────────────────────────────────┤
│ Used for: breakpoint numbering (0, 1, 2, ...) for GDB       │
│                                                              │
│ breakpoints ──┐                                             │
│ (linked list) │                                             │
│              ▼                                              │
│ ┌──────────────────┐                                        │
│ │ bp_def {         │                                        │
│ │   next ────────┐ │                                        │
│ │   address: 0   │ │                                        │
│ │   index: 0     │ │  [User sees as "Breakpoint 0"]       │
│ │   commands: "" │ │                                        │
│ │ }              │ │                                        │
│ └────────────────┼─┘                                        │
│                │                                            │
│                ▼                                            │
│ ┌──────────────────┐                                        │
│ │ bp_def {         │                                        │
│ │   next ────────┐ │                                        │
│ │   address: 1   │ │  [User sees as "Breakpoint 1"]       │
│ │   index: 1     │ │                                        │
│ │   commands: "" │ │                                        │
│ │ }              │ │                                        │
│ └────────────────┼─┘                                        │
│                │                                            │
│                ▼                                            │
│ ┌──────────────────┐                                        │
│ │ bp_def {         │                                        │
│ │   next: NULL  │ │                                        │
│ │   address: 2   │ │  [User sees as "Breakpoint 2"]       │
│ │   index: 2     │ │                                        │
│ │   commands: "" │ │                                        │
│ │ }              │ │                                        │
│ └──────────────────┘                                        │
└──────────────────────────────────────────────────────────────┘

Note: Two parallel structures!
  - m68k_breakpoint[] array: Fast O(n) lookup during JIT
  - bp_def linked list: User-facing breakpoint numbering for GDB
```

---

## 4. GDB Message Protocol Flow

```
┌─────────────────────────────────────────────────────────────┐
│ GDB Client (gdb)                                             │
└────────────────────┬────────────────────────────────────────┘
                     │
                     │ TCP Socket / Pipe
                     │
    ┌────────────────▼────────────────────────────┐
    │ Message Format: $<payload>#<checksum>       │
    │ Example: $g#67 (read all registers)         │
    └────────────────┬────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────┐
│ BlastEm: gdb_debug_enter() message loop                     │
│                                                              │
│  while (!cont) {                                             │
│    ┌────────────────────────────────────────────────────┐  │
│    │ Receive raw bytes from socket/stdin               │  │
│    │ Handle partial packets gracefully                 │  │
│    │ Look for '$' start marker                         │  │
│    └────────────────┬─────────────────────────────────┘  │
│                     │                                      │
│                     ▼                                      │
│    ┌────────────────────────────────────────────────────┐  │
│    │ Extract payload: $PAYLOAD#XX                       │  │
│    │ Null-terminate at '#'                             │  │
│    │ Send "+" acknowledgment                           │  │
│    └────────────────┬─────────────────────────────────┘  │
│                     │                                      │
│                     ▼                                      │
│    ┌────────────────────────────────────────────────────┐  │
│    │ gdb_run_command(context, pc, payload)             │  │
│    │                                                   │  │
│    │ Dispatch by first character:                      │  │
│    │   'g' → read registers                            │  │
│    │   'G' → write registers                           │  │
│    │   'c' → continue (cont = 1)                       │  │
│    │   's' → step (decode, set breakpoints)            │  │
│    │   'Z' → set breakpoint                            │  │
│    │   'z' → remove breakpoint                         │  │
│    │   'q' → query (version, thread info, etc.)        │  │
│    │   '?' → signal query                              │  │
│    │   'm' → read memory                               │  │
│    │   'M' → write memory                              │  │
│    └────────────────┬─────────────────────────────────┘  │
│                     │                                      │
│                     ├─ For 'c' or 's':                    │
│                     │  └─ Set cont = 1 (exit loop)        │
│                     │                                      │
│                     └─ For others:                        │
│                        └─ Build response                  │
│                           Call gdb_send_command()         │
│  }                                                         │
└─────────────────────────────────────────────────────────────┘
                     │
                     ▼
    ┌────────────────────────────────────────────────────┐
    │ gdb_send_command(response_string)                  │
    │                                                   │
    │ Format:  $<response>#<checksum>                   │
    │ Example: $3b32#b6  (hexdump of register values)   │
    └────────────────┬────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────────┐
│ GDB Client receives and parses response                      │
│ Updates display: registers, memory, breakpoints, etc.       │
└─────────────────────────────────────────────────────────────┘
```

---

## 5. Execution Model: Continuous vs. Debug

```
NORMAL EXECUTION (No Breakpoints)
─────────────────────────────────

┌──────────────────┐
│ Emulation loop   │
├──────────────────┤
│ [1] Fetch inst   │──┐
│ [2] Translate    │  │
│     (JIT)        │  │ find_breakpoint(addr)?
│     find_bp() ──┤  └─ NO → zero overhead
│     ┌─ NO       │
│     │           │
│     └─ YES ─────────┐
│ [3] Execute      │  │ (not reached if no BP)
│                  │  │
│ [4] Loop         │  │
└──────────────────┘  │
      ▲               │
      │ always        │
      └───────────────┘


WITH BREAKPOINT (Debug Mode)
────────────────────────────

Emulation Loop
     │
     ├─ fetch @ 0x000100
     │
     ├─ translate_m68k()
     │  ├─ find_breakpoint(0x000100)? YES
     │  ├─ m68k_breakpoint_patch()
     │  │  ├─ emit: mov 0x000100, scratch1
     │  │  └─ emit: call bp_stub
     │  │
     │  └─ (continue generating other instruction code)
     │
     ├─ execute native code for 0x000100
     │  │
     │  └─ [patched code executes]:
     │     ├─ save_context()
     │     ├─ call m68k_bp_dispatcher
     │     │  │
     │     │  ├─ find_breakpoint(0x000100)
     │     │  ├─ handler(context, 0x000100)
     │     │  │  │
     │     │  │  ├─ gdb_debug_enter(ctx, 0x000100)
     │     │  │  │  │
     │     │  │  │  ├─ send "$S05#xx" to GDB
     │     │  │  │  ├─ loop: while (!cont) {
     │     │  │  │  │          read message
     │     │  │  │  │          dispatch command
     │     │  │  │  │        }
     │     │  │  │  │
     │     │  │  │  └─ return when cont = 1
     │     │  │  │
     │     │  │  └─ (returns to stub)
     │     │  │
     │     │  └─ return context
     │     │
     │     ├─ load_context()
     │     ├─ check cycle limit
     │     └─ jmp to instruction body
     │
     └─ continue emulation
```

---

## 6. Breakpoint Lookup Performance

```
Time Complexity Analysis:

┌──────────────────────────────────────┐
│ Array-based lookup:                  │
│ find_breakpoint(context, address)    │
│                                      │
│  for (i = 0; i < num_breakpoints) {  │
│      if (breakpoints[i].address ==   │
│          address) { return handler; }│
│  }                                   │
│  return NULL;                        │
│                                      │
│  Time: O(n) where n = num_breakpoints│
│        ≈ 10-100 in typical use       │
│        negligible at JIT time        │
└──────────────────────────────────────┘

Actual Performance (Empirical):
┌─────────────────────────────┐
│ num_breakpoints │ lookup μs  │
├─────────────────────────────┤
│        0        │   0 (skip) │  ← most code (no breakpoints)
│        5        │   ~0.1     │
│       20        │   ~0.4     │
│      100        │   ~2.0     │
│     1000        │   ~20      │  ← impractical
└─────────────────────────────┘

Optimization Options (if needed):
┌──────────────────────────────────┐
│ 1. Hash Table                    │
│    find_breakpoint() → O(1)      │
│    Cost: memory overhead         │
│                                  │
│ 2. Sorted Array + Binary Search  │
│    find_breakpoint() → O(log n)  │
│    Cost: insertion complexity    │
│                                  │
│ 3. Two-level Lookup             │
│    [address>>12] → list of      │
│    breakpoints in that region    │
│    Cost: extra memory, complex   │
│                                  │
│ Current design: Keep simple      │
│ (Good enough for real use)       │
└──────────────────────────────────┘
```

---

## 7. Memory Layout: Code Translation with Breakpoint

```
Before Breakpoint Set:
──────────────────────

Native Code Buffer (x86-64):
  0x7f1000:  [instruction for 0x000100]
  0x7f1010:  [instruction for 0x000101]
  0x7f1020:  [instruction for 0x000102]


After Breakpoint Set at 0x000100:
────────────────────────────────

Native Code Buffer (x86-64):
  0x7f1000:  ┌───────────────────────────┐
             │ mov rax, 0x000100 ; addr  │ (patched in)
             │ call bp_stub              │
  0x7f1008:  ├───────────────────────────┤
             │ [rest of instr for 0x001] │
             │                           │
  0x7f1010:  ├───────────────────────────┤
             │ [instruction for 0x000101]│
             │                           │
  0x7f1020:  ├───────────────────────────┤
             │ [instruction for 0x000102]│
             └───────────────────────────┘

bp_stub (generated once, at init):
  0x7f2000:  ┌───────────────────────────┐
             │ [save context to memory]  │
             │ push rax (address arg)    │
             │ call m68k_bp_dispatcher   │
             │ [load context from mem]   │
             │ pop rax                   │
             │ cmp cycles, limit         │
             │ jcc skip_interrupt        │
             │ call handle_interrupt     │
             │ skip_interrupt:           │
             │ pop rax (ret addr)        │
             │ add rax, offset           │
             │ jmp rax                   │
             └───────────────────────────┘

Key Points:
- Patched code is minimal (5-10 bytes)
- Points to shared bp_stub
- bp_stub handles all dispatch logic
- Efficient for multiple breakpoints
```

---

## 8. SH2 Adaptation Mapping

```
BlastEm (68K)          →  Sega 32X (SH2)
──────────────────────────────────────────

m68k_context           →  sh2_context
m68k_breakpoint        →  sh2_breakpoint
m68k_debug_handler     →  sh2_debug_handler

m68k_core.c            →  sh2_core.c
  find_breakpoint      →  sh2_find_breakpoint
  insert_breakpoint    →  sh2_insert_breakpoint
  remove_breakpoint    →  sh2_remove_breakpoint
  m68k_bp_dispatcher   →  sh2_bp_dispatcher

m68k_core_[backend].c  →  sh2_core_[backend].c
  m68k_breakpoint_patch →  sh2_breakpoint_patch
  bp_stub generation   →  sh2_bp_stub

translate_m68k()       →  translate_sh2()
  find_breakpoint()    →  sh2_find_breakpoint()
  m68k_breakpoint_patch→  sh2_breakpoint_patch()

gdb_remote.c           →  (mostly reusable)
  gdb_debug_enter      →  sh2_gdb_debug_enter
  gdb_run_command      →  (same, register encoding changes)
    Register 'g' cmd   →  Encode SH2 registers (R0-R15, PC, PR, SR, GBR)
    Register 'p' cmd   →  Encode SH2 specific register
    's' command        →  Decode SH2 instructions
                           Handle delay slot

Key Differences for SH2:
  - SH2 instructions 16-bit (simpler than 68K variable)
  - Delay slot instructions (execute after branch)
  - Different register set (R0-R15, PR, SR, GBR, VBR)
  - Conditional branch format different
  - Smaller instruction set to decode
  - No RTS/RTE/RTR complexity (simpler returns)
```

