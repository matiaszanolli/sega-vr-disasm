# PicoDrive Debugger Core (pdcore) - MVP-1 Implementation Roadmap

**Target Duration**: 5-7 evenings (20-25 hours)
**Goal**: Frame-perfect SH2 debugging with Python interface
**Approach**: Incremental - test at each milestone before proceeding

---

## 0. Pre-Implementation Setup

### 0.1 Verify your environment

```bash
# Check you have all needed tools
gcc --version      # Must be GCC 9+ or Clang
python3 --version  # Must be 3.9+
cargo --version    # For Rust/PyO3 (P2)

# Check PicoDrive is cloned
ls third_party/picodrive/pico/sh2/sh2.c
ls third_party/picodrive/pico/32x/draw.c
```

### 0.2 Create directory structure

```bash
mkdir -p pdcore/{include,src}
mkdir -p pdrs/src
mkdir -p py/picodrive32x
mkdir -p tests/integration
```

### 0.3 Review documentation

- ✅ Read `PDCORE_API_DESIGN.md` (understand the API)
- ✅ Read `PDCORE_SURGICAL_INSERTION_CHECKLIST.md` (know where to modify)
- ✅ Review `BLASTEM_DEBUGGER_ANALYSIS.md` (architecture patterns)

---

## PHASE 1: Foundation - Core Types & Infrastructure

**Duration**: 2-3 hours
**Deliverable**: Compiling but non-functional pdcore library

### 1.1 Create pdcore/include/pdcore.h

**File**: `pdcore/include/pdcore.h`

Copy from PDCORE_API_DESIGN.md section 1-10. This is the public API specification.

**Checklist**:
- [ ] All enums (pd_cpu_t, pd_bus_t, pd_stop_reason_t)
- [ ] All structs (pd_stop_info_t, pd_sh2_regs_t, pd_config_t)
- [ ] All function signatures
- [ ] Comments explaining each type
- [ ] Include guards, standard headers

**Expected size**: ~180 lines

**Quick test**: Can it compile?
```bash
gcc -c -Ipdcore/include pdcore/src/dummy.c -o /tmp/test.o
```

---

### 1.2 Create pdcore/include/pdcore_internal.h

**File**: `pdcore/include/pdcore_internal.h`

From SURGICAL_INSERTION_CHECKLIST.md section PART A.2

This bridges PicoDrive's internals with pdcore (internal use only):

```c
#ifndef PDCORE_INTERNAL_H
#define PDCORE_INTERNAL_H

#include <stdint.h>

// Forward declare PicoDrive types
typedef struct SH2_ SH2;
typedef struct Genesis_State_ Genesis_State;

// Main opaque handle
typedef struct pd_t {
    Genesis_State *genesis;
    SH2 *master_sh2;
    SH2 *slave_sh2;

    // Debug state
    void *bp_array_master;
    void *bp_array_slave;
    int num_breakpoints_master;
    int num_breakpoints_slave;

    uint32_t frame_count;
    uint64_t master_cycles;
    uint64_t master_instructions;

    char error_buf[256];
} pd_t;

#endif
```

**Expected size**: ~45 lines

---

### 1.3 Create pdcore/include/pdcore_bp.h (Internal)

**File**: `pdcore/include/pdcore_bp.h`

Breakpoint data structure:

```c
#ifndef PDCORE_BP_H
#define PDCORE_BP_H

#include <stdint.h>

#define MAX_BREAKPOINTS 128

typedef void (*pd_breakpoint_handler_t)(
    struct pd_t *emu,
    int cpu,
    uint32_t pc,
    void *user_data
);

typedef struct {
    uint32_t address;
    pd_breakpoint_handler_t handler;
    void *user_data;
    int active;
} pd_breakpoint_t;

typedef struct {
    pd_breakpoint_t bp[MAX_BREAKPOINTS];
    int count;
} pd_breakpoint_array_t;

// Initialize array
void pdcore_bp_init(pd_breakpoint_array_t *arr);

// Find breakpoint at address
pd_breakpoint_t *pdcore_bp_find(pd_breakpoint_array_t *arr, uint32_t addr);

// Add breakpoint
int pdcore_bp_add(
    pd_breakpoint_array_t *arr,
    uint32_t addr,
    pd_breakpoint_handler_t handler,
    void *user_data
);

// Remove breakpoint
int pdcore_bp_del(pd_breakpoint_array_t *arr, uint32_t addr);

#endif
```

**Expected size**: ~50 lines

---

### 1.4 Create base pdcore.c scaffold

**File**: `pdcore/src/pdcore.c`

Start with stubs:

```c
#include "pdcore.h"
#include "pdcore_internal.h"
#include "pdcore_bp.h"
#include <stdlib.h>
#include <string.h>

pd_t *pd_create(const pd_config_t *config) {
    pd_t *emu = malloc(sizeof(pd_t));
    if (!emu) return NULL;

    memset(emu, 0, sizeof(pd_t));

    // TODO: Attach to PicoDrive
    // emu->genesis = pico_get_genesis_state();

    // Initialize breakpoint arrays
    emu->bp_array_master = malloc(sizeof(pd_breakpoint_array_t));
    emu->bp_array_slave = malloc(sizeof(pd_breakpoint_array_t));

    pdcore_bp_init((pd_breakpoint_array_t *)emu->bp_array_master);
    pdcore_bp_init((pd_breakpoint_array_t *)emu->bp_array_slave);

    return emu;
}

void pd_destroy(pd_t *emu) {
    if (!emu) return;
    free(emu->bp_array_master);
    free(emu->bp_array_slave);
    free(emu);
}

// Stubs for all other functions (return error)
int pd_load_rom_file(pd_t *emu, const char *path) {
    if (!emu) return -1;
    snprintf(emu->error_buf, sizeof(emu->error_buf), "Not implemented");
    return -1;
}

const char *pd_get_error(pd_t *emu) {
    return emu ? emu->error_buf : "NULL emulator";
}

// ... more stubs ...
```

**Expected size**: ~150 lines (mostly stubs)

**Test**: Can you create and destroy an emulator?
```c
pd_config_t cfg = {0};
pd_t *emu = pd_create(&cfg);
assert(emu != NULL);
pd_destroy(emu);
```

---

## PHASE 2: PicoDrive Integration - Hook Points

**Duration**: 1-2 hours
**Deliverable**: Hooks in PicoDrive (without functionality yet)

### 2.1 Modify pico/sh2/sh2.h

Follow SURGICAL_INSERTION_CHECKLIST.md PART B.2:

Add to SH2 struct:
```c
// Debug hooks
int (*debug_check_breakpoint)(struct SH2_ *sh2);
void *debug_context;
```

**Verify**: Does PicoDrive still compile?
```bash
cd third_party/picodrive
make clean && make
```

---

### 2.2 Modify pico/sh2/sh2.c

Follow SURGICAL_INSERTION_CHECKLIST.md PART B.1:

In `sh2_execute()` main loop, add:
```c
if (sh2->debug_check_breakpoint) {
    if (sh2->debug_check_breakpoint(sh2)) {
        return 0;  // Stop
    }
}
```

**Verify**: PicoDrive still builds and runs?
```bash
blastem game.32x  # Should work identically
```

---

### 2.3 Modify pico/32x/draw.c

Follow SURGICAL_INSERTION_CHECKLIST.md PART C.1:

At V-BLANK (line_count == 224), add:
```c
if (genesis->debug_on_vblank) {
    genesis->debug_on_vblank(genesis);
}
```

**Verify**: Emulation still works?

---

### 2.4 Modify pico/genesis.h

Follow SURGICAL_INSERTION_CHECKLIST.md PART C.2:

Add to Genesis_State struct:
```c
void (*debug_on_vblank)(struct Genesis_State_ *gen);
void *debug_context;
```

---

### 2.5 Create accessor functions in pico/pico.c

Follow SURGICAL_INSERTION_CHECKLIST.md PART E.1:

```c
Genesis_State *pico_get_genesis_state(void) {
    extern Genesis_State *genesis;  // Adjust as needed
    return genesis;
}

SH2 *pico_get_sh2_master(void) {
    extern Genesis_State *genesis;
    return genesis->sh2_master;  // Adjust field name
}

SH2 *pico_get_sh2_slave(void) {
    extern Genesis_State *genesis;
    return genesis->sh2_slave;   // Adjust field name
}
```

**Note**: Adjust field names to match actual PicoDrive structure

---

## PHASE 3: Memory Access API

**Duration**: 1-2 hours
**Deliverable**: Read/write memory from frame buffers and SDRAM

### 3.1 Create pdcore/src/pdcore_memory.c

```c
#include "pdcore.h"
#include "pdcore_internal.h"

int pd_mem_read(pd_t *emu, pd_bus_t bus, uint32_t address,
                void *out_buf, size_t size) {
    if (!emu || !out_buf) return -1;

    // Map bus type to actual memory location
    void *src = NULL;
    size_t available = 0;

    switch (bus) {
        case PD_BUS_SH2_SDRAM:
            // Map to SDRAM address in PicoDrive
            // (Need to find SDRAM base address in genesis state)
            // src = (void *)((uintptr_t)emu->genesis->sdram + (address - 0x20000000));
            // available = 2*1024*1024;  // 2MB
            break;

        case PD_BUS_SH2_FB:
            // Map to frame buffer
            // src = (void *)((uintptr_t)emu->genesis->frame_buffer_a + (address - 0x2400000));
            // available = 256*1024;  // 256KB (one FB)
            break;

        default:
            return -5;  // PD_ERR_UNSUPPORTED
    }

    if (!src) return -4;  // Invalid address

    // Clamp read size to available memory
    size_t to_read = (size > available) ? available : size;
    memcpy(out_buf, src, to_read);

    return (int)to_read;
}

int pd_mem_write(pd_t *emu, pd_bus_t bus, uint32_t address,
                 const void *data, size_t size) {
    if (!emu || !data) return -1;

    // Similar to read, but mutable
    void *dst = NULL;
    size_t available = 0;

    switch (bus) {
        case PD_BUS_SH2_SDRAM:
            // dst = (void *)((uintptr_t)emu->genesis->sdram + (address - 0x20000000));
            // available = 2*1024*1024;
            break;

        case PD_BUS_SH2_FB:
            // dst = (void *)((uintptr_t)emu->genesis->frame_buffer_a + (address - 0x2400000));
            // available = 256*1024;
            break;

        default:
            return -5;
    }

    if (!dst) return -4;

    size_t to_write = (size > available) ? available : size;
    memcpy(dst, data, to_write);

    return (int)to_write;
}

uint32_t pd_mem_read_u32(pd_t *emu, pd_bus_t bus, uint32_t address) {
    uint32_t value;
    pd_mem_read(emu, bus, address, &value, 4);
    return value;
}

int pd_mem_write_u32(pd_t *emu, pd_bus_t bus, uint32_t address,
                     uint32_t value) {
    return pd_mem_write(emu, bus, address, &value, 4);
}

int pd_get_bus_info(pd_t *emu, pd_bus_t bus, pd_bus_info_t *out) {
    if (!emu || !out) return -1;

    switch (bus) {
        case PD_BUS_SH2_SDRAM:
            out->name = "SH2 SDRAM";
            out->start = 0x20000000;
            out->size = 2*1024*1024;
            break;
        case PD_BUS_SH2_FB:
            out->name = "SH2 Frame Buffer";
            out->start = 0x2400000;
            out->size = 256*1024;
            break;
        default:
            return -5;
    }

    return 0;
}
```

**Note**: You'll need to find actual SDRAM/FB pointers in genesis state structure. Check PicoDrive's memory layout.

---

### 3.2 Test memory access

```c
// Load ROM first (stub for now)
// Read a 32-bit word from SDRAM
uint32_t val = pd_mem_read_u32(emu, PD_BUS_SH2_SDRAM, 0x20000000);
printf("Value at 0x20000000: 0x%08x\n", val);
```

---

## PHASE 4: Breakpoint System

**Duration**: 2 hours
**Deliverable**: Can set/hit/clear breakpoints

### 4.1 Create pdcore/src/pdcore_bp.c

```c
#include "pdcore_bp.h"
#include <string.h>

void pdcore_bp_init(pd_breakpoint_array_t *arr) {
    memset(arr, 0, sizeof(pd_breakpoint_array_t));
}

// Binary search for breakpoint (assuming sorted array)
pd_breakpoint_t *pdcore_bp_find(pd_breakpoint_array_t *arr, uint32_t addr) {
    for (int i = 0; i < arr->count; i++) {
        if (arr->bp[i].address == addr && arr->bp[i].active) {
            return &arr->bp[i];
        }
    }
    return NULL;
}

int pdcore_bp_add(pd_breakpoint_array_t *arr, uint32_t addr,
                  pd_breakpoint_handler_t handler, void *user_data) {
    if (arr->count >= MAX_BREAKPOINTS) {
        return -6;  // PD_ERR_BREAKPOINT_LIMIT
    }

    // Check if already exists
    if (pdcore_bp_find(arr, addr)) {
        return -1;  // Already exists
    }

    int i = arr->count;
    arr->bp[i].address = addr;
    arr->bp[i].handler = handler;
    arr->bp[i].user_data = user_data;
    arr->bp[i].active = 1;
    arr->count++;

    return i;  // Return breakpoint ID
}

int pdcore_bp_del(pd_breakpoint_array_t *arr, uint32_t addr) {
    for (int i = 0; i < arr->count; i++) {
        if (arr->bp[i].address == addr && arr->bp[i].active) {
            arr->bp[i].active = 0;
            // Compress array (remove inactive entries)
            // or just mark inactive and skip in search
            return 0;
        }
    }
    return -1;  // Not found
}
```

---

### 4.2 Implement public breakpoint API in pdcore.c

```c
int pd_bp_exec_add(pd_t *emu, pd_cpu_t cpu, uint32_t address,
                   pd_breakpoint_handler_t handler, void *user_data) {
    if (!emu) return -1;

    pd_breakpoint_array_t *arr = NULL;
    SH2 *sh2 = NULL;

    if (cpu == PD_CPU_MASTER) {
        arr = (pd_breakpoint_array_t *)emu->bp_array_master;
        sh2 = emu->master_sh2;
    } else if (cpu == PD_CPU_SLAVE) {
        arr = (pd_breakpoint_array_t *)emu->bp_array_slave;
        sh2 = emu->slave_sh2;
    } else {
        return -1;  // Invalid CPU
    }

    int result = pdcore_bp_add(arr, address, handler, user_data);

    // Attach breakpoint check callback if not already attached
    if (sh2 && !sh2->debug_check_breakpoint) {
        sh2->debug_check_breakpoint = pdcore_sh2_check_breakpoint;
        sh2->debug_context = emu;
    }

    return result;
}

int pd_bp_exec_del(pd_t *emu, pd_cpu_t cpu, uint32_t address) {
    if (!emu) return -1;

    pd_breakpoint_array_t *arr = NULL;
    if (cpu == PD_CPU_MASTER) {
        arr = (pd_breakpoint_array_t *)emu->bp_array_master;
    } else if (cpu == PD_CPU_SLAVE) {
        arr = (pd_breakpoint_array_t *)emu->bp_array_slave;
    } else {
        return -1;
    }

    return pdcore_bp_del(arr, address);
}

int pd_bp_exec_clear(pd_t *emu, pd_cpu_t cpu) {
    if (!emu) return -1;

    if (cpu == PD_CPU_MASTER) {
        pdcore_bp_init((pd_breakpoint_array_t *)emu->bp_array_master);
    } else if (cpu == PD_CPU_SLAVE) {
        pdcore_bp_init((pd_breakpoint_array_t *)emu->bp_array_slave);
    }

    return 0;
}

// Callback from SH2 execution loop
static int pdcore_sh2_check_breakpoint(SH2 *sh2) {
    pd_t *emu = (pd_t *)sh2->debug_context;
    if (!emu) return 0;

    // Determine which CPU this is
    pd_cpu_t cpu = (sh2 == emu->master_sh2) ? PD_CPU_MASTER : PD_CPU_SLAVE;
    pd_breakpoint_array_t *arr = (cpu == PD_CPU_MASTER) ?
        (pd_breakpoint_array_t *)emu->bp_array_master :
        (pd_breakpoint_array_t *)emu->bp_array_slave;

    pd_breakpoint_t *bp = pdcore_bp_find(arr, sh2->pc);
    if (bp && bp->handler) {
        bp->handler(emu, cpu, sh2->pc, bp->user_data);
        return 1;  // Stop execution
    }

    return 0;  // Continue
}
```

---

## PHASE 5: Execution Control

**Duration**: 1-2 hours
**Deliverable**: Can step frames and cycles

### 5.1 Implement pd_run_cycles in pdcore.c

```c
pd_stop_reason_t pd_run_cycles(pd_t *emu, uint64_t cycles,
                               pd_stop_info_t *out_stop_info) {
    if (!emu || !out_stop_info) return PD_STOP_NONE;

    // Store initial cycle count
    uint64_t start_cycles = emu->master_cycles;

    // Clear halt flag
    emu->halt_requested = 0;

    // Run PicoDrive for the requested number of cycles
    // This is backend-specific - need to call PicoDrive's
    // execution function with cycle limit

    // Pseudocode:
    // while ((emu->master_cycles - start_cycles) < cycles) {
    //     if (emu->halt_requested) break;
    //
    //     pico_run_one_line();  // Or equivalent
    //
    //     if (emu->breakpoint_hit) {
    //         emu->breakpoint_hit = 0;
    //         out_stop_info->reason = PD_STOP_EXEC_BREAKPOINT;
    //         return PD_STOP_EXEC_BREAKPOINT;
    //     }
    // }

    out_stop_info->reason = PD_STOP_CYCLE_LIMIT;
    out_stop_info->master_cycles = emu->master_cycles;
    out_stop_info->frame_number = emu->frame_count;

    return PD_STOP_CYCLE_LIMIT;
}
```

**Note**: Actual cycle counting requires integrating with PicoDrive's execution model. May need to measure cycles in callbacks.

---

### 5.2 Implement pd_run_frames

```c
pd_stop_reason_t pd_run_frames(pd_t *emu, uint32_t frame_count,
                               pd_stop_info_t *out_stop_info) {
    if (!emu || !out_stop_info) return PD_STOP_NONE;

    uint32_t start_frame = emu->frame_count;

    while ((emu->frame_count - start_frame) < frame_count) {
        // Run until next V-BLANK
        pd_stop_info_t tmp_stop;
        pd_run_cycles(emu, 1000000, &tmp_stop);  // Large cycle limit

        if (tmp_stop.reason == PD_STOP_EXEC_BREAKPOINT) {
            *out_stop_info = tmp_stop;
            return PD_STOP_EXEC_BREAKPOINT;
        }
    }

    out_stop_info->reason = PD_STOP_FRAME_BOUNDARY;
    out_stop_info->frame_number = emu->frame_count;
    out_stop_info->master_cycles = emu->master_cycles;

    return PD_STOP_FRAME_BOUNDARY;
}
```

---

### 5.3 Implement pd_halt

```c
void pd_halt(pd_t *emu) {
    if (emu) {
        emu->halt_requested = 1;
    }
}
```

---

### 5.4 Implement pd_step_instruction

```c
pd_stop_reason_t pd_step_instruction(pd_t *emu, pd_cpu_t cpu,
                                     pd_stop_info_t *out_stop_info) {
    if (!emu || !out_stop_info) return PD_STOP_NONE;

    SH2 *sh2 = (cpu == PD_CPU_MASTER) ? emu->master_sh2 : emu->slave_sh2;
    if (!sh2) return PD_STOP_NONE;

    uint32_t current_pc = sh2->pc;

    // TODO: Decode instruction and predict next addresses
    // For MVP-1, just run one cycle and check if PC changed

    pd_stop_info_t tmp;
    pd_run_cycles(emu, 10, &tmp);  // Small cycle budget

    out_stop_info->reason = PD_STOP_NONE;
    out_stop_info->address = sh2->pc;
    out_stop_info->cpu = cpu;

    return PD_STOP_NONE;
}
```

**Note**: Full single-step logic (decoding, temp breakpoints on both branches) deferred to Phase 6.

---

## PHASE 6: CPU State Access

**Duration**: 1 hour
**Deliverable**: Read/write CPU registers

### 6.1 Implement pd_get_sh2_regs

```c
int pd_get_sh2_regs(pd_t *emu, pd_cpu_t cpu, pd_sh2_regs_t *out) {
    if (!emu || !out) return -1;

    SH2 *sh2 = (cpu == PD_CPU_MASTER) ? emu->master_sh2 : emu->slave_sh2;
    if (!sh2) return -1;

    // Copy registers from SH2 struct to output struct
    // This assumes you know the field names in PicoDrive's SH2
    for (int i = 0; i < 16; i++) {
        out->r[i] = sh2->r[i];
    }

    out->pc = sh2->pc;
    out->sr = sh2->sr;
    out->pr = sh2->pr;
    out->gbr = sh2->gbr;
    out->vbr = sh2->vbr;
    out->mach = sh2->mach;
    out->macl = sh2->macl;

    // Cycle counts (tracked by pdcore)
    out->cycle_count = 0;  // TODO: Calculate from emu->master_cycles
    out->instruction_count = 0;  // TODO: Track in execution loop

    return 0;
}
```

---

### 6.2 Implement pd_set_sh2_regs

```c
int pd_set_sh2_regs(pd_t *emu, pd_cpu_t cpu, const pd_sh2_regs_t *in) {
    if (!emu || !in) return -1;

    SH2 *sh2 = (cpu == PD_CPU_MASTER) ? emu->master_sh2 : emu->slave_sh2;
    if (!sh2) return -1;

    // Copy registers from input to SH2
    for (int i = 0; i < 16; i++) {
        sh2->r[i] = in->r[i];
    }

    sh2->pc = in->pc;
    sh2->sr = in->sr;
    sh2->pr = in->pr;
    sh2->gbr = in->gbr;
    sh2->vbr = in->vbr;
    sh2->mach = in->mach;
    sh2->macl = in->macl;

    return 0;
}
```

---

## PHASE 7: Integration & Testing

**Duration**: 1-2 hours
**Deliverable**: Working end-to-end test

### 7.1 Create tests/integration/test_basic.c

```c
#include "pdcore.h"
#include <stdio.h>
#include <assert.h>

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Usage: test_basic <game.32x>\n");
        return 1;
    }

    printf("Test 1: Create and destroy emulator\n");
    pd_t *emu = pd_create(NULL);
    assert(emu != NULL);
    printf("  ✓ Created\n");

    printf("Test 2: Load ROM\n");
    int ret = pd_load_rom_file(emu, argv[1]);
    assert(ret == 0);
    printf("  ✓ Loaded\n");

    printf("Test 3: Reset\n");
    ret = pd_reset(emu);
    assert(ret == 0);
    printf("  ✓ Reset\n");

    printf("Test 4: Run 1 frame\n");
    pd_stop_info_t stop;
    pd_run_frames(emu, 1, &stop);
    printf("  ✓ Ran 1 frame (frame %u at cycle %llu)\n",
           stop.frame_number, stop.master_cycles);

    printf("Test 5: Read CPU registers\n");
    pd_sh2_regs_t regs;
    ret = pd_get_sh2_regs(emu, PD_CPU_MASTER, &regs);
    assert(ret == 0);
    printf("  ✓ Master PC: 0x%08x, R0: 0x%08x\n", regs.pc, regs.r[0]);

    printf("Test 6: Set breakpoint\n");
    ret = pd_bp_exec_add(emu, PD_CPU_MASTER, regs.pc, NULL, NULL);
    assert(ret >= 0);
    printf("  ✓ Breakpoint added at 0x%08x\n", regs.pc);

    printf("Test 7: Cleanup\n");
    pd_destroy(emu);
    printf("  ✓ Destroyed\n");

    printf("\n✅ All tests passed!\n");
    return 0;
}
```

---

### 7.2 Compile and test

```bash
cd pdcore
make

# Build test
gcc -o /tmp/test_basic tests/integration/test_basic.c \
    -Iinclude -Isrc -Lbuild -lpdcore

# Run test
/tmp/test_basic Virtua\ Racing\ Deluxe\ \(USA\).32x
```

---

## PHASE 8: Build System Integration

**Duration**: 30 minutes
**Deliverable**: Clean build from single Makefile command

### 8.1 Create pdcore/Makefile

```makefile
.PHONY: all clean

CC = gcc
CFLAGS = -Wall -Wextra -O2 -fPIC
LDFLAGS = -shared

SOURCES = src/pdcore.c src/pdcore_bp.c src/pdcore_memory.c
HEADERS = include/pdcore.h include/pdcore_internal.h include/pdcore_bp.h
OBJECTS = $(SOURCES:.c=.o)

all: build/libpdcore.so

build/libpdcore.so: $(OBJECTS)
	@mkdir -p build
	$(CC) $(LDFLAGS) -o $@ $(OBJECTS)
	@echo "✓ Built $@"

%.o: %.c $(HEADERS)
	$(CC) $(CFLAGS) -Iinclude -c $< -o $@

clean:
	rm -f $(OBJECTS) build/libpdcore.so
	@echo "✓ Cleaned"
```

---

## Success Criteria - MVP-1 Complete

✅ **All 18 core functions implemented**
- Lifecycle: create, destroy, load_rom, reset
- Execution: run_cycles, run_frames, halt
- Breakpoints: add, del, clear
- CPU state: get/set registers
- Memory: read, write (all buses)
- Error handling: get_error

✅ **PicoDrive integration**
- Hooks in sh2.c, sh2.h, draw.c, genesis.h
- Accessor functions in pico.c
- <2% performance overhead

✅ **Testing**
- Basic integration test passes
- ROM loads without errors
- Breakpoints fire reliably
- Registers readable/writable
- Memory accessible from frame buffer

✅ **Documentation**
- API spec complete (pdcore.h)
- Code comments explain each function
- README with quick start examples

---

## Timeline Estimate

| Phase | Task | Duration | Cumulative |
|-------|------|----------|-----------|
| 0 | Setup | 30 min | 30 min |
| 1 | Foundation | 2-3 hrs | 3 hrs |
| 2 | Hooks in PicoDrive | 1-2 hrs | 4-5 hrs |
| 3 | Memory access | 1-2 hrs | 5-7 hrs |
| 4 | Breakpoints | 2 hrs | 7-9 hrs |
| 5 | Execution control | 1-2 hrs | 8-11 hrs |
| 6 | CPU state | 1 hr | 9-12 hrs |
| 7 | Integration test | 1-2 hrs | 10-14 hrs |
| 8 | Build system | 30 min | 10.5-14.5 hrs |
| **Total** | | | **10.5-14.5 hrs** |

**Realistic: 15-20 hours across 5-7 evenings**

---

## Risk Mitigation

### Risk: PicoDrive structure different than expected

**Mitigation**:
- Read PicoDrive source first (pico/sh2/sh2.h)
- Document actual field names
- Adjust code accordingly

### Risk: Cycle counting breaks emulation

**Mitigation**:
- Don't instrument cycle counting in MVP-1
- Use frame count (V-BLANK) instead
- Add cycle counting in P1

### Risk: Breakpoint overhead too high

**Mitigation**:
- Use `unlikely()` macro
- Only check when breakpoints exist
- Profile before/after

### Risk: Memory addresses wrong

**Mitigation**:
- Test with known addresses (e.g., frame buffer base)
- Dump memory and verify against emulator debugger
- Add validation functions

---

## Next Steps After MVP-1

Once MVP-1 is complete and working:

1. **Create Rust/PyO3 binding** (pdrs/) → enables Python interface
2. **Write GDB protocol layer** (P2) → remote debugging
3. **Add watchpoints** (P1) → memory breakpoints
4. **Implement trace recording** (P2) → instruction history
5. **Add cycle counting** (P1) → precise profiling

---

## Quick Start Command

Once ready:

```bash
# Phase 1-2: Foundation + hooks
# Phase 3-6: Implementation
# Phase 7-8: Testing + build

make -C pdcore clean && make -C pdcore all && \
  tests/integration/test_basic "Virtua Racing Deluxe (USA).32x"
```

---

**Status**: Roadmap complete. Ready to implement!

