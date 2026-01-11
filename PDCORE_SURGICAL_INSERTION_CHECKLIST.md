# PicoDrive Surgical Insertion Checklist - MVP-1

**Purpose**: Exact, minimal, non-invasive modifications to PicoDrive to enable debugger hooks
**Philosophy**: Add ~5 lightweight hooks; preserve all existing functionality
**Estimated Impact**: <2% performance overhead when no breakpoints active

---

## Pre-Flight Checklist

- [ ] PicoDrive source cloned to `third_party/picodrive/`
- [ ] Build system understanding: uses Make or CMake?
- [ ] Target platform: Linux x86-64 (add macOS/Windows ports later)
- [ ] Understand PicoDrive's memory layout (ROM base, SDRAM range)

---

## PART A: Infrastructure Setup (No Code Changes Yet)

### A.1: Create pdcore/ directory structure

```bash
mkdir -p pdcore/{include,src}
mkdir -p pdrs/src
mkdir -p py/picodrive32x
```

### A.2: Create wrapper header

**File**: `pdcore/include/pdcore_internal.h`

This header bridges PicoDrive and pdcore (NOT in public API):

```c
#ifndef PDCORE_INTERNAL_H
#define PDCORE_INTERNAL_H

#include <stdint.h>

// Forward declare PicoDrive types
typedef struct SH2_ SH2;
typedef struct Genesis_State_ Genesis_State;

// Opaque emulator handle (users see this only)
typedef struct pd_t pd_t;

// Attach PicoDrive context to our debug instance
struct pd_t {
    Genesis_State *genesis;           // PicoDrive main state
    SH2 *master_sh2;                  // Master SH2 CPU
    SH2 *slave_sh2;                   // Slave SH2 CPU

    // Debug state
    void *bp_array_master;            // Breakpoint array for Master
    void *bp_array_slave;             // Breakpoint array for Slave

    uint32_t frame_count;             // V-BLANK counter
    uint64_t master_cycles;           // Total Master SH2 cycles
    uint64_t master_instructions;     // Total Master SH2 instructions

    char error_buf[256];              // Error message buffer
};

#endif
```

---

## PART B: Hook Point #1 - SH2 Execution Loop

### B.1: Add breakpoint check in sh2_execute()

**File**: `third_party/picodrive/pico/sh2/sh2.c`

**Location**: Inside `sh2_execute()` function, BEFORE instruction fetch

**Current code** (approximate, find the actual line):
```c
uint32_t sh2_execute(SH2 *sh2, int cycles)
{
    while (sh2->cycles_left > 0) {
        // ... execution logic ...
    }
}
```

**Modification** (add this at the very start of while loop):

```c
uint32_t sh2_execute(SH2 *sh2, int cycles)
{
    while (sh2->cycles_left > 0) {

        // ============= HOOK POINT #1: BREAKPOINT CHECK =============
        // Check if debugger hook is attached to this SH2 instance
        if (sh2->debug_check_breakpoint) {
            int should_stop = sh2->debug_check_breakpoint(sh2);
            if (should_stop) {
                return 0;  // Stop execution, return to debugger
            }
        }
        // ============================================================

        // ... rest of execution logic (unchanged) ...
        // Instruction fetch, decode, execute...
    }
}
```

**Why this works**:
- One function pointer check per instruction
- Zero overhead when `debug_check_breakpoint == NULL` (compiler optimizes)
- Only executes if debugger is attached

---

### B.2: Extend SH2 context to hold debug pointer

**File**: `third_party/picodrive/pico/sh2/sh2.h`

**Location**: In `SH2` struct definition

**Current code** (find the struct):
```c
typedef struct SH2_ {
    uint32_t r[16];      // Registers
    uint32_t pc;
    // ... more fields ...
} SH2;
```

**Modification** (add at END of struct, before closing brace):

```c
typedef struct SH2_ {
    uint32_t r[16];      // Registers
    uint32_t pc;
    // ... existing fields unchanged ...

    // ========== DEBUG FIELDS (NULL when no debugger) ==========
    int (*debug_check_breakpoint)(struct SH2_ *sh2);  // Callback
    void *debug_context;                              // Debugger state
    // ========================================================
} SH2;
```

**Size impact**: +16 bytes per SH2 instance (negligible)

---

## PART C: Hook Point #2 - V-BLANK Frame Boundary Marker

### C.1: Add frame boundary detection

**File**: `third_party/picodrive/pico/32x/draw.c` (or wherever V-BLANK is set)

**Location**: Where V-BLANK bit is set (typically `line_count == 224`)

**Current code** (find this pattern):
```c
if (line_count == 224) {
    // Set V-BLANK bit in status registers
    vdp_status |= VBLANK_BIT;
}
```

**Modification** (add callback right after V-BLANK is set):

```c
if (line_count == 224) {
    // Set V-BLANK bit in status registers
    vdp_status |= VBLANK_BIT;

    // ========== HOOK POINT #2: FRAME BOUNDARY ==========
    // Notify debugger that frame boundary reached
    if (genesis->debug_on_vblank) {
        genesis->debug_on_vblank(genesis);
    }
    // ====================================================
}
```

**Why this works**:
- Called exactly once per frame (16.67ms at 60 FPS)
- Synchronization point for profiling
- Handler can increment frame counter, reset state, etc.

---

### C.2: Extend Genesis state for frame callback

**File**: `third_party/picodrive/pico/genesis.h` (or wherever Genesis_State is defined)

**Location**: In `Genesis_State` struct definition

**Modification** (add at END of struct):

```c
typedef struct Genesis_State_ {
    // ... existing fields ...

    // ========== DEBUG FIELDS ==========
    void (*debug_on_vblank)(struct Genesis_State_ *gen);
    void *debug_context;
    // ==================================
} Genesis_State;
```

**Size impact**: +16 bytes per Genesis instance

---

## PART D: Hook Point #3 & #4 - Memory Access Hooks (P1, Optional for MVP-1)

**For MVP-1**: Skip this section (optional for P1)

**For P1 watchpoints**, add hooks here:

### D.1: Memory read hook

**File**: `third_party/picodrive/pico/sh2/sh2.c`

**Location**: In `sh2_read_32()` (or equivalent read function)

**Modification** (add after actual read, before return):

```c
uint32_t sh2_read_32(uint32_t addr, SH2 *sh2)
{
    uint32_t value = /* ... actual read logic ... */;

    // ========== HOOK POINT #3: MEMORY READ (P1) ==========
    // if (sh2->debug_on_read) {
    //     sh2->debug_on_read(sh2, addr, value, 4);
    // }
    // ====================================================

    return value;
}
```

### D.2: Memory write hook

**File**: `third_party/picodrive/pico/sh2/sh2.c`

**Location**: In `sh2_write_32()` (or equivalent write function)

**Modification** (add before actual write):

```c
void sh2_write_32(uint32_t addr, uint32_t value, SH2 *sh2)
{
    // ========== HOOK POINT #4: MEMORY WRITE (P1) ==========
    // if (sh2->debug_on_write) {
    //     sh2->debug_on_write(sh2, addr, value, 4);
    // }
    // ====================================================

    /* ... actual write logic ... */
}
```

**Note**: Commented out for MVP-1, enable for P1 watchpoints

---

## PART E: Export PicoDrive Pointers (Connection Layer)

### E.1: Create accessor function

**File**: `third_party/picodrive/pico/pico.c` (or main entry point)

**Location**: Add new public function (no modification to existing code)

```c
// NEW FUNCTION - add this at end of file
// (This allows pdcore to access PicoDrive internals without modifying
//  PicoDrive's public API)

Genesis_State *pico_get_genesis_state(void) {
    // Return global genesis context (PicoDrive already has this)
    extern Genesis_State *genesis;
    return genesis;
}

SH2 *pico_get_sh2_master(void) {
    extern Genesis_State *genesis;
    return genesis->sh2_master;  // Adjust field name as needed
}

SH2 *pico_get_sh2_slave(void) {
    extern Genesis_State *genesis;
    return genesis->sh2_slave;   // Adjust field name as needed
}
```

**Why**: pdcore.c needs to reach into PicoDrive's internals. These functions provide clean access without breaking PicoDrive's encapsulation.

---

## PART F: Build System Integration

### F.1: Modify Makefile (or CMakeLists.txt)

**File**: Root `Makefile`

**Add pdcore compilation** (minimal change):

```makefile
# Existing targets...

# New debug core compilation
PDCORE_SRC = pdcore/src/pdcore.c pdcore/src/pdcore_bp.c pdcore/src/pdcore_exec.c
PDCORE_OBJ = $(PDCORE_SRC:.c=.o)

# Add pdcore objects to main build target
all: $(PDCORE_OBJ) build/vr_rebuild.32x

# Compilation rule for pdcore
pdcore/src/%.o: pdcore/src/%.c pdcore/include/pdcore.h
	$(CC) $(CFLAGS) -Ipdcore/include -c $< -o $@
```

---

## PART G: Summary of Changes

### Files Modified (Total: ~5 changes, ~30 lines)

| File | Change | Lines | Impact |
|------|--------|-------|--------|
| `pico/sh2/sh2.c` | Add breakpoint check | 5 | Minimal |
| `pico/sh2/sh2.h` | Extend SH2 struct | 3 | +16 bytes |
| `pico/32x/draw.c` | Add V-BLANK callback | 5 | Minimal |
| `pico/genesis.h` | Extend Genesis struct | 3 | +16 bytes |
| `pico/pico.c` | Add accessor functions | 12 | New functions only |
| `Makefile` | Add pdcore compilation | 8 | Build config |

### Files Created (NEW)

| File | Purpose | Size |
|------|---------|------|
| `pdcore/include/pdcore.h` | Public API spec | ~200 lines |
| `pdcore/include/pdcore_internal.h` | Internal bridge | ~40 lines |
| `pdcore/src/pdcore.c` | Core implementation | ~300 lines |
| `pdcore/src/pdcore_bp.c` | Breakpoint array | ~150 lines |
| `pdcore/src/pdcore_exec.c` | Execution control | ~200 lines |

**Total changes to PicoDrive**: ~36 lines across 5 files
**Total new code**: ~890 lines (self-contained)

---

## PART H: Verification Checklist

After making changes, verify:

- [ ] PicoDrive builds without pdcore (no dependencies added)
- [ ] pdcore builds against PicoDrive headers
- [ ] No new compiler warnings
- [ ] breakpoint check hook does NOT execute when `debug_check_breakpoint == NULL`
- [ ] V-BLANK callback does NOT execute when `debug_on_vblank == NULL`
- [ ] Emulation speed unchanged (measure FPS before/after)

---

## PART I: Code Review Checklist

Before committing, verify:

- [ ] All hook points use `unlikely()` macro (compiler optimization)
- [ ] All callbacks check for NULL before calling
- [ ] No locks/mutexes added (single-threaded for MVP-1)
- [ ] All new fields initialized to NULL/0
- [ ] Comments explain WHY hooks exist
- [ ] No changes to public PicoDrive API (only internal extensions)

---

## PART J: Minimal Example - Hooking in pdcore.c

Here's how pdcore.c will USE these hooks:

### Example: Attaching debugger to PicoDrive

```c
// In pdcore.c: pd_create()
pd_t *pd_create(const pd_config_t *cfg) {
    pd_t *emu = malloc(sizeof(pd_t));

    // Get PicoDrive's internal state
    emu->genesis = pico_get_genesis_state();
    emu->master_sh2 = pico_get_sh2_master();
    emu->slave_sh2 = pico_get_sh2_slave();

    // Allocate breakpoint arrays
    emu->bp_array_master = calloc(MAX_BP, sizeof(pd_breakpoint_t));
    emu->bp_array_slave = calloc(MAX_BP, sizeof(pd_breakpoint_t));

    // Attach hooks
    emu->master_sh2->debug_check_breakpoint = pdcore_check_breakpoint;
    emu->master_sh2->debug_context = emu;

    emu->genesis->debug_on_vblank = pdcore_on_vblank;
    emu->genesis->debug_context = emu;

    return emu;
}

// Callback from SH2 execution loop
static int pdcore_check_breakpoint(SH2 *sh2) {
    pd_t *emu = (pd_t *)sh2->debug_context;

    uint32_t pc = sh2->pc;
    pd_breakpoint_t *bp = find_breakpoint(emu->bp_array_master, pc);

    if (bp && bp->handler) {
        bp->handler(emu, PD_CPU_MASTER, pc, bp->user_data);
        return 1;  // Stop execution
    }
    return 0;  // Continue
}

// Callback from V-BLANK
static void pdcore_on_vblank(Genesis_State *gen) {
    pd_t *emu = (pd_t *)gen->debug_context;
    emu->frame_count++;
}
```

---

## PART K: Testing the Hooks (Quick Validation)

### Test 1: Ensure NULL checks prevent crashes

```c
// Before any modifications:
Genesis_State *gen = pico_get_genesis_state();
gen->debug_on_vblank = NULL;  // Explicitly NULL

// Run emulation - should NOT crash
pico_reset();
pico_run_frame();  // Should skip callback safely
```

### Test 2: Verify callback fires

```c
static int vblank_count = 0;

void test_vblank_callback(Genesis_State *gen) {
    vblank_count++;
}

// Attach callback
Genesis_State *gen = pico_get_genesis_state();
gen->debug_on_vblank = test_vblank_callback;

// Run 60 frames
for (int i = 0; i < 60; i++) {
    pico_run_frame();
}

// Verify: should have fired 60 times
assert(vblank_count == 60);
```

### Test 3: Verify hook doesn't impact performance

```bash
# Before hooks:
blastem game.32x  # Note FPS

# After hooks (without pdcore attached):
# FPS should be unchanged (hooks cost 0 when NULL)
```

---

## PART L: Troubleshooting

### Problem: Build fails after modifications

**Solution**:
1. Check that new struct fields are at END of structs (doesn't break existing offsets)
2. Verify `pdcore_internal.h` is in include path
3. Try `make clean && make`

### Problem: Callback never fires

**Solution**:
1. Add printf before callback check: "Checking breakpoint at PC=0x%x"
2. Verify callback function pointer is NOT NULL
3. Verify PC actually matches breakpoint address

### Problem: Performance degrades

**Solution**:
1. Verify callbacks are `NULL` when not attached
2. Add `unlikely()` macro to callback checks
3. Profile with gprof to identify bottleneck

---

## SUMMARY

This checklist provides:

✅ **Exact file locations** - Know where to modify
✅ **Minimal changes** - ~36 lines across PicoDrive
✅ **Zero impact baseline** - PicoDrive unmodified when pdcore not attached
✅ **Clean separation** - pdcore is standalone; doesn't pollute PicoDrive
✅ **Verification steps** - Test each hook independently
✅ **Troubleshooting guide** - Quick fixes if something breaks

**Key principle**: Hooks are OPTIONAL. When pdcore is not used, PicoDrive runs at full speed with zero overhead.

---

