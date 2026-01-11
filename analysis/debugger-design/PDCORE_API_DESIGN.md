# PicoDrive Debugger Core API Design (`pdcore.h`)

**Date**: 2026-01-10
**Purpose**: Stable C interface for 32X/SH2 deterministic debugging and profiling
**Target**: MVP-1 implementation (1-2 evenings)
**Inspiration**: BlastEm's elegant handler-pointer + JIT-time injection patterns

---

## 0. Design Philosophy

1. **Single Responsibility**: Debug layer is separate from emulation
2. **Handler Pointers** (from BlastEm): Same breakpoint struct works for GDB, console debugger, profiler
3. **Deterministic**: All timing is cycle-based, never wall-clock
4. **Frame-Perfect**: Can pause at V-BLANK or user-set boundaries
5. **Low Overhead**: When no breakpoints/watchpoints, <1% impact
6. **Forward-Compatible**: MVP-1 minimal; P1/P2 features don't break interface

---

## 1. Type System

### 1.1 CPU Identifiers

```c
typedef enum {
    PD_CPU_MASTER = 0,    // Master SH2 (23 MHz)
    PD_CPU_SLAVE = 1,     // Slave SH2 (23 MHz)
    PD_CPU_68K = 2,       // 68000 (Mega Drive main)
} pd_cpu_t;
```

**Rationale**: You care primarily about SH2; 68K is secondary. Start with SH2.

---

### 1.2 Memory Buses

```c
typedef enum {
    PD_BUS_SH2_ROM = 0,        // SH2 ROM space (2000000h-23FFFFFh)
    PD_BUS_SH2_SDRAM = 1,      // SH2 SDRAM (2000000h-23FFFFFh cached)
    PD_BUS_SH2_SDRAM_WT = 2,   // SH2 SDRAM cache-through (22000000h-23FFFFFh)
    PD_BUS_SH2_FB = 3,         // SH2 Frame buffers (2400000h-25FFFFFh)
    PD_BUS_SH2_SYS = 4,        // SH2 System registers (2A000000h+)
    PD_BUS_68K = 5,            // 68000 address space (000000h+)
} pd_bus_t;

typedef struct {
    const char *name;
    uint32_t    start;
    uint32_t    size;
} pd_bus_info_t;
```

**Rationale**: Different buses have different access patterns. Crucial for memory access API.

---

### 1.3 Stop Reasons

```c
typedef enum {
    PD_STOP_NONE = 0,              // Still running
    PD_STOP_CYCLE_LIMIT = 1,       // Ran out of cycles
    PD_STOP_FRAME_BOUNDARY = 2,    // Hit V-BLANK (frame marker)
    PD_STOP_EXEC_BREAKPOINT = 3,   // Hit execution breakpoint
    PD_STOP_WATCHPOINT = 4,        // Hit memory watchpoint (P1)
    PD_STOP_EVENT = 5,             // Hit event (P1)
    PD_STOP_EXCEPTION = 6,         // Unhandled exception (P2)
    PD_STOP_HALT = 7,              // Explicit halt via API
} pd_stop_reason_t;
```

**Rationale**: Distinguishes why execution stopped. Essential for debugger loop.

---

### 1.4 Stop Information

```c
typedef struct {
    pd_stop_reason_t reason;           // Why did we stop?
    pd_cpu_t cpu;                      // Which CPU triggered (if applicable)
    uint32_t address;                  // PC or memory address
    uint64_t master_cycles;            // Master SH2 cycle count
    uint64_t master_instructions;      // Master SH2 instruction count
    uint32_t frame_number;             // Which frame (from V-BLANK count)
} pd_stop_info_t;
```

**Rationale**: Complete context for debugger decision-making.

---

### 1.5 SH2 Registers

```c
typedef struct {
    // General purpose registers R0-R15
    uint32_t r[16];

    // Special registers
    uint32_t pc;        // Program counter
    uint32_t sr;        // Status register (flags, interrupt level)
    uint32_t pr;        // Procedure register (return address)
    uint32_t gbr;       // Global base register
    uint32_t vbr;       // Vector base register
    uint32_t mach;      // Multiply-accumulate high
    uint32_t macl;      // Multiply-accumulate low

    // Debugger state (read-only)
    uint32_t cycle_count;      // Cycles executed (total)
    uint32_t instruction_count; // Instructions executed (total)
    uint8_t in_delay_slot;     // Flag: next instruction is delay slot
    uint8_t in_interrupt;      // Flag: executing interrupt handler
} pd_sh2_regs_t;
```

**Rationale**: Complete SH2 register state for inspection and modification.

---

## 2. Breakpoint System (MVP-1 Critical)

### 2.1 Breakpoint Handler Function Signature

Stolen from BlastEm:

```c
// Handler called when breakpoint is hit
// Allows different behaviors (GDB debug_enter, profiler counter, etc.)
typedef void (*pd_breakpoint_handler_t)(
    struct pd_t *emu,           // Emulator instance
    pd_cpu_t cpu,               // Which CPU hit breakpoint
    uint32_t pc,                // Program counter at breakpoint
    void *user_data             // Handler-specific context
);
```

**Rationale**: Single breakpoint array can serve multiple purposes.

---

### 2.2 Breakpoint Operations

```c
// Add an execution breakpoint
// handler: function called when breakpoint hits
// user_data: passed to handler (can be NULL)
// Returns: breakpoint ID (>0) or negative error
int pd_bp_exec_add(
    pd_t *emu,
    pd_cpu_t cpu,
    uint32_t address,
    pd_breakpoint_handler_t handler,
    void *user_data
);

// Remove execution breakpoint
int pd_bp_exec_del(pd_t *emu, pd_cpu_t cpu, uint32_t address);

// Clear all breakpoints on a CPU
int pd_bp_exec_clear(pd_t *emu, pd_cpu_t cpu);

// Check if breakpoint exists at address
int pd_bp_exec_exists(pd_t *emu, pd_cpu_t cpu, uint32_t address);

// List all active breakpoints (P1 enhancement)
// int pd_bp_exec_list(pd_t *emu, pd_cpu_t cpu, uint32_t *addrs, int max_count);
```

**Rationale**:
- Handler pointer allows profiler, GDB, and console debugger to coexist
- Simple add/del/exists for MVP-1; list() deferred to P1
- Returns breakpoint ID for future reference (extensible)

---

## 3. Execution Control

### 3.1 Deterministic Stepping (Core MVP-1)

```c
// Run for N cycles on Master SH2
// Stops on breakpoint, watchpoint, or cycle limit
// Returns: reason why execution stopped
pd_stop_reason_t pd_run_cycles(
    pd_t *emu,
    uint64_t cycles,
    pd_stop_info_t *out_stop_info
);

// Run for N complete frames (V-BLANK to V-BLANK)
// "Frame" = one V-INT period (16.67ms at 60 FPS)
// Useful for: "step one rendered frame"
pd_stop_reason_t pd_run_frames(
    pd_t *emu,
    uint32_t frame_count,
    pd_stop_info_t *out_stop_info
);

// Run until condition met
// Useful for: "run until breakpoint" or "run for 1 second"
pd_stop_reason_t pd_run_until(
    pd_t *emu,
    uint64_t cycle_limit,  // Stop if cycle count exceeds this
    pd_stop_info_t *out_stop_info
);

// Single instruction step
// Decodes instruction, sets temp breakpoint on next address,
// resumes, returns when next address hit
// For conditional branches: sets breakpoints on both paths
pd_stop_reason_t pd_step_instruction(
    pd_t *emu,
    pd_cpu_t cpu,
    pd_stop_info_t *out_stop_info
);

// Halt execution immediately
// Used when breakpoint handler wants to stop
void pd_halt(pd_t *emu);
```

**Rationale**:
- Cycle-based stepping enables precise profiling
- Frame stepping aligns with rendering boundaries
- `step_instruction()` uses temporary breakpoints (BlastEm pattern)
- All deterministic, no wall-clock timing

---

### 3.2 Run Mode Control

```c
// Enable/disable specific CPUs during execution
// Useful for: debugging Master SH2 while Slave is paused
int pd_cpu_enable(pd_t *emu, pd_cpu_t cpu, int enabled);

// Check if CPU is currently enabled
int pd_cpu_is_enabled(pd_t *emu, pd_cpu_t cpu);

// Get current execution state
typedef struct {
    int running;                // Is emulation running?
    uint64_t total_cycles;      // Total cycles executed since reset
    uint32_t frame_count;       // V-BLANK count (frame number)
    uint32_t line_count;        // Current scanline (0-240)
} pd_state_t;

int pd_get_state(pd_t *emu, pd_state_t *out);
```

**Rationale**: Allows selective CPU execution for profiling specific threads.

---

## 4. Lifecycle API

### 4.1 Initialization & Cleanup

```c
typedef struct {
    int enable_trace;              // Enable instruction tracing (P1)
    size_t trace_buffer_size;      // Size of trace ring buffer
    int deterministic;             // Disable RNG, use fixed seeds
    int enable_watchpoints;        // Enable memory watchpoints (P1)
} pd_config_t;

// Create an emulator instance
// config: can be NULL for defaults
// Returns: opaque handle or NULL on error
pd_t *pd_create(const pd_config_t *config);

// Destroy emulator instance
void pd_destroy(pd_t *emu);

// Load ROM from memory
// Returns: 0 on success, <0 on error
int pd_load_rom(pd_t *emu, const void *data, size_t size);

// Load ROM from file
// Returns: 0 on success, <0 on error
int pd_load_rom_file(pd_t *emu, const char *path);

// Reset emulation (CPU state, registers, memory)
int pd_reset(pd_t *emu);
```

**Rationale**: Minimal setup for quick testing. Config struct allows future options.

---

## 5. CPU State Access

### 5.1 Register Read/Write

```c
// Read all SH2 registers
// Returns: 0 on success
int pd_get_sh2_regs(pd_t *emu, pd_cpu_t cpu, pd_sh2_regs_t *out);

// Write SH2 registers
// Allows debugger to modify state (e.g., set breakpoint return value)
int pd_set_sh2_regs(pd_t *emu, pd_cpu_t cpu, const pd_sh2_regs_t *in);

// Read single register (convenience)
// reg: 0-15 for R0-R15, 16 for PC, 17 for SR, etc.
uint32_t pd_get_sh2_reg(pd_t *emu, pd_cpu_t cpu, int reg);

// Write single register
int pd_set_sh2_reg(pd_t *emu, pd_cpu_t cpu, int reg, uint32_t value);
```

**Rationale**: Full control over CPU state for interactive debugging.

---

## 6. Memory Access (Critical)

### 6.1 Read/Write API

```c
// Read from specific bus
// Returns: bytes read (may be <size if crossing boundary), or <0 on error
int pd_mem_read(
    pd_t *emu,
    pd_bus_t bus,
    uint32_t address,
    void *out_buf,
    size_t size
);

// Write to specific bus
// Returns: bytes written, or <0 on error
int pd_mem_write(
    pd_t *emu,
    pd_bus_t bus,
    uint32_t address,
    const void *data,
    size_t size
);

// Convenience: Read 32-bit word
uint32_t pd_mem_read_u32(pd_t *emu, pd_bus_t bus, uint32_t address);

// Convenience: Write 32-bit word
int pd_mem_write_u32(pd_t *emu, pd_bus_t bus, uint32_t address, uint32_t value);

// Get information about a bus (for address space validation)
// Returns: 0 on success
int pd_get_bus_info(pd_t *emu, pd_bus_t bus, pd_bus_info_t *out);
```

**Rationale**: Bus-aware memory access prevents address confusion. Critical for frame buffer introspection.

---

### 6.2 Memory Snapshot (Useful for Analysis)

```c
// Allocate and return snapshot of memory region
// Caller responsible for free()
void *pd_mem_snapshot(
    pd_t *emu,
    pd_bus_t bus,
    uint32_t address,
    size_t size
);
```

**Rationale**: Easy to diff frame buffer state between frames.

---

## 7. Watchpoints (P1, but define interface now)

```c
// Placeholder for watchpoint API (priority P1)
// Not implemented in MVP-1, but interface defined

typedef enum {
    PD_WATCH_READ = 1,
    PD_WATCH_WRITE = 2,
    PD_WATCH_RW = 3,
} pd_watch_mode_t;

typedef void (*pd_watchpoint_handler_t)(
    pd_t *emu,
    pd_bus_t bus,
    uint32_t address,
    uint32_t value,
    pd_watch_mode_t mode,
    void *user_data
);

// Add memory watchpoint
// int pd_wp_add(
//     pd_t *emu,
//     pd_bus_t bus,
//     uint32_t address,
//     size_t size,
//     pd_watch_mode_t mode,
//     pd_watchpoint_handler_t handler,
//     void *user_data
// );

// Remove watchpoint
// int pd_wp_del(pd_t *emu, pd_bus_t bus, uint32_t address);
```

**Rationale**: Interface defined now, implementation deferred to P1 (after breakpoints proven).

---

## 8. Event System (P1, define now)

```c
typedef enum {
    PD_EVENT_VBLANK = (1 << 0),      // V-BLANK started
    PD_EVENT_HBLANK = (1 << 1),      // H-BLANK started
    PD_EVENT_FRAME_END = (1 << 2),   // Frame complete (after swap)
    PD_EVENT_INTERRUPT = (1 << 3),   // Interrupt accepted by CPU
} pd_event_mask_t;

typedef void (*pd_event_handler_t)(
    pd_t *emu,
    pd_event_mask_t event,
    void *user_data
);

// Set which events trigger stops/callbacks
// int pd_set_event_mask(pd_t *emu, uint32_t mask);

// Register event handler
// int pd_event_register(
//     pd_t *emu,
//     pd_event_mask_t events,
//     pd_event_handler_t handler,
//     void *user_data
// );
```

**Rationale**: Allows stopping at natural synchronization points.

---

## 9. Tracing Infrastructure (P1-P2, interface only)

```c
// Compact trace record (32 bytes)
typedef struct {
    uint64_t cycle;              // Master cycle count
    uint32_t pc;                 // Program counter
    uint32_t next_pc;            // Next PC (after decode)
    uint16_t opcode;             // Instruction opcode
    uint8_t cpu;                 // Which CPU (pd_cpu_t)
    uint8_t _pad;
    // Can extend: register values, memory access, etc.
} pd_trace_record_t;

// Enable tracing
// int pd_trace_enable(pd_t *emu, size_t buffer_size);

// Disable tracing
// int pd_trace_disable(pd_t *emu);

// Pull trace records (non-blocking)
// Returns: number of records returned
// size_t pd_trace_pull(
//     pd_t *emu,
//     pd_trace_record_t *out,
//     size_t max_records
// );
```

**Rationale**: Enables post-mortem analysis without slowing emulation.

---

## 10. Error Handling

```c
// Get last error message
const char *pd_get_error(pd_t *emu);

// Clear error state
void pd_clear_error(pd_t *emu);

// Error codes (return values < 0)
typedef enum {
    PD_OK = 0,
    PD_ERR_INVALID_PARAM = -1,
    PD_ERR_ROM_NOT_LOADED = -2,
    PD_ERR_OUT_OF_MEMORY = -3,
    PD_ERR_INVALID_ADDRESS = -4,
    PD_ERR_UNSUPPORTED = -5,
    PD_ERR_BREAKPOINT_LIMIT = -6,
} pd_error_t;
```

**Rationale**: Simple error propagation for scripting.

---

## 11. API Completeness Summary

### MVP-1 (Implement First - ~8 hours)

| Component | Functions | Status |
|-----------|-----------|--------|
| Lifecycle | `pd_create`, `pd_destroy`, `pd_load_rom`, `pd_reset` | **REQUIRED** |
| Execution | `pd_run_cycles`, `pd_run_frames`, `pd_halt` | **REQUIRED** |
| Step | `pd_step_instruction` | **REQUIRED** |
| Breakpoints | `pd_bp_exec_add`, `pd_bp_exec_del`, `pd_bp_exec_clear` | **REQUIRED** |
| Registers | `pd_get_sh2_regs`, `pd_set_sh2_regs` | **REQUIRED** |
| Memory | `pd_mem_read`, `pd_mem_write`, `pd_mem_read_u32` | **REQUIRED** |
| Frame Markers | V-BLANK detection in `pd_stop_info_t` | **REQUIRED** |
| Error Handling | `pd_get_error` | **REQUIRED** |

**Total**: ~18 functions, ~500 LOC of C

---

### P1 (Implement Second - ~8 hours)

| Component | Functions | Status |
|-----------|-----------|--------|
| Watchpoints | `pd_wp_add`, `pd_wp_del` | Deferred |
| Events | `pd_event_register`, `pd_set_event_mask` | Deferred |
| Trace | `pd_trace_enable`, `pd_trace_pull` | Deferred |
| CPU Control | `pd_cpu_enable` | Deferred |
| Snapshots | `pd_mem_snapshot` | Deferred |

---

## 12. Code Examples (MVP-1 Usage)

### Example 1: Load ROM and run one frame

```c
pd_config_t cfg = {0};
cfg.deterministic = 1;

pd_t *emu = pd_create(&cfg);
pd_load_rom_file(emu, "game.32x");
pd_reset(emu);

pd_stop_info_t stop;
pd_run_frames(emu, 1, &stop);

if (stop.reason == PD_STOP_FRAME_BOUNDARY) {
    printf("Frame %u complete at cycle %llu\n",
           stop.frame_number, stop.master_cycles);
}

pd_destroy(emu);
```

### Example 2: Set breakpoint and catch it

```c
void my_breakpoint_handler(pd_t *emu, pd_cpu_t cpu,
                           uint32_t pc, void *user_data) {
    printf("Breakpoint hit at 0x%08x on %s\n", pc,
           cpu == PD_CPU_MASTER ? "Master" : "Slave");
    pd_halt(emu);  // Stop execution
}

pd_bp_exec_add(emu, PD_CPU_MASTER, 0x0202DD5C,
               my_breakpoint_handler, NULL);

pd_stop_info_t stop;
pd_run_cycles(emu, 1000000, &stop);

if (stop.reason == PD_STOP_EXEC_BREAKPOINT) {
    pd_sh2_regs_t regs;
    pd_get_sh2_regs(emu, PD_CPU_MASTER, &regs);
    printf("Master PC: 0x%08x, R0: 0x%08x\n", regs.pc, regs.r[0]);
}
```

### Example 3: Frame buffer inspection

```c
// After running one frame, dump frame buffer
uint32_t fb_base = 0x2400000;
void *snapshot = pd_mem_snapshot(emu, PD_BUS_SH2_FB, fb_base, 128*1024);

FILE *f = fopen("framebuffer.bin", "wb");
fwrite(snapshot, 128*1024, 1, f);
fclose(f);
free(snapshot);
```

### Example 4: Single-step with inspection

```c
for (int i = 0; i < 100; i++) {
    pd_stop_info_t stop;
    pd_step_instruction(emu, PD_CPU_MASTER, &stop);

    pd_sh2_regs_t regs;
    pd_get_sh2_regs(emu, PD_CPU_MASTER, &regs);

    printf("Step %d: PC=0x%08x, R0=0x%08x\n", i, regs.pc, regs.r[0]);

    if (stop.reason == PD_STOP_EXEC_BREAKPOINT) {
        printf("Unexpected breakpoint!\n");
        break;
    }
}
```

---

## 13. Architecture Diagram

```
┌─────────────────────────────────────────┐
│ Debugger Client (Python via PyO3)       │
│                                         │
│ emu.run_frames(1)                      │
│ emu.bp_exec(0x1234)                    │
│ regs = emu.get_sh2_regs()               │
└────────────────┬────────────────────────┘
                 │
                 │ PyO3 bindings
                 ▼
┌─────────────────────────────────────────┐
│ Rust Wrapper (pdrs/)                    │
│                                         │
│ pub struct Pico32X {                    │
│     raw: *mut pd_t,                     │
│ }                                       │
│                                         │
│ impl Pico32X {                          │
│     pub fn run_frames(&mut self, n) {   │
│         unsafe { pd_run_frames(...) }   │
│     }                                   │
│ }                                       │
└────────────────┬────────────────────────┘
                 │
                 │ FFI (unsafe)
                 ▼
┌─────────────────────────────────────────┐
│ C Debug Core (pdcore/)                  │
│                                         │
│ pdcore.h (180 lines)                    │
│ pdcore.c (500+ lines)                   │
│                                         │
│ • Breakpoint array                      │
│ • Execution loop hooks                  │
│ • Memory access layer                   │
│ • Frame boundary tracking               │
└────────────────┬────────────────────────┘
                 │
                 │ Thin wrapper
                 ▼
┌─────────────────────────────────────────┐
│ PicoDrive Core (pico/sh2/, pico/32x/)   │
│                                         │
│ sh2_execute()  [+ bp check hook]        │
│ sh2_read_32()  [+ wp hook P1]           │
│ sh2_write_32() [+ wp hook P1]           │
│ Frame drawing  [+ boundary marker]      │
│                                         │
│ All existing functionality unchanged     │
└─────────────────────────────────────────┘
```

---

## 14. Implementation Strategy (MVP-1)

### Phase 1: Core Infrastructure (2-3 hours)

```
pdcore/
├── include/pdcore.h       ← This API spec
├── src/
│   ├── pdcore.c          ← Lifecycle, memory, state
│   ├── pdcore_bp.c       ← Breakpoint array + handlers
│   ├── pdcore_exec.c     ← Execution loop + frame tracking
│   └── pdcore_step.c     ← Single-step logic (temp breakpoints)
└── Makefile              ← Build config
```

### Phase 2: PicoDrive Integration (2-3 hours)

```
Minimal changes to PicoDrive:
- Add breakpoint check in sh2_execute() main loop
- Add frame marker at V-BLANK (line 224)
- Add memory access hooks (read/write functions)
- Expose pd_t to SH2 context
```

### Phase 3: Rust/PyO3 Binding (2-3 hours)

```
pdrs/
├── Cargo.toml
├── src/
│   ├── lib.rs            ← PyO3 class Pico32X
│   └── bindings.rs       ← FFI to pdcore.h
└── tests/
    └── integration.rs    ← Basic tests
```

---

## 15. Success Criteria (MVP-1)

- ✅ Create ROM, load, reset
- ✅ Run N frames deterministically
- ✅ Set/hit execution breakpoint
- ✅ Read/write CPU registers
- ✅ Read/write memory (bus-aware)
- ✅ Single-step one instruction
- ✅ Detect frame boundaries (V-BLANK count)
- ✅ Python can call all above via PyO3
- ✅ <2% performance overhead when no breakpoints
- ✅ Deterministic (same ROM + input = same trace)

---

## 16. Next Steps

1. **Review this spec** - any feedback before we write `pdcore.h`?
2. **Create `pdcore.h`** - translate this design into actual header
3. **Create surgical insertion checklist** - show exact lines in PicoDrive to modify
4. **Begin implementation** - start with lifecycle + memory access, then breakpoints

---

## Appendix: Comparison to BlastEm

| Feature | BlastEm | PicoDrive Debug |
|---------|---------|---|
| **Breakpoint storage** | Array + realloc | ✅ Same |
| **Handler pointer** | ✅ Used | ✅ Adopt |
| **JIT injection** | ✅ Used (they have JIT) | ⚠️ Simplified (interpreter) |
| **Temp breakpoints** | ✅ Used for step | ✅ Adopt same pattern |
| **GDB protocol** | ✅ Implemented | 🔄 P2 feature |
| **Multi-CPU sync** | Z80 separate | ✅ Master/Slave both |
| **Frame markers** | Not applicable | ✅ V-BLANK tracking |

---

**Status**: Specification complete and ready for header file creation.
