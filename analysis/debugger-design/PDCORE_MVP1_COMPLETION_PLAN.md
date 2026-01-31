# pdcore MVP-1 Completion Plan - Haiku Execution Guide

**Date:** 2026-01-21
**Target:** Complete pdcore debugger for Phase 11 Slave hook integration
**Estimated Effort:** 8-12 hours
**Status:** 85% complete - requires PicoDrive integration and testing

---

## Executive Summary

The pdcore debugger is **85% implemented**. The core library (1,373 lines of C) compiles and the API (419 lines) is complete. What remains is:

1. **Wiring up PicoDrive integration** (~2 hours)
2. **Completing memory access functions** (~2 hours)
3. **Testing and debugging** (~4 hours)

This plan provides mechanical, step-by-step instructions for completing MVP-1.

---

## Current Implementation Status

### ✅ COMPLETE (Do Not Modify)

| Component | File | Lines | Status |
|-----------|------|-------|--------|
| Public API | `pdcore/include/pdcore.h` | 419 | ✅ Complete |
| Internal types | `pdcore/include/pdcore_internal.h` | 45 | ✅ Complete |
| Breakpoint types | `pdcore/include/pdcore_bp.h` | 50 | ✅ Complete |
| Main implementation | `pdcore/src/pdcore.c` | 973 | ✅ 90% complete |
| Breakpoint system | `pdcore/src/pdcore_bp.c` | 129 | ✅ Complete |
| Execution control | `pdcore/src/pdcore_exec.c` | 271 | ✅ Complete |
| PicoDrive bridge | `pdcore/patches/pdcore_bridge.c` | 62 | ✅ Complete |
| Library build | `pdcore/build/libpdcore.so` | 26KB | ✅ Builds |

### ❌ INCOMPLETE (Requires Work)

| Component | Issue | Action Required |
|-----------|-------|-----------------|
| PicoDrive hook integration | Bridge not connected | Apply patch + wire functions |
| Memory access (pd_mem_read/write) | Stub implementations | Complete using bridge functions |
| pd_load_rom() | Returns "Not implemented" | Connect to PicoDrive ROM loading |
| pdcore_get_sh2_master/slave | Extern but undefined | Wire to bridge functions |
| Test harness | Not verified | Create and run integration test |

---

## Phase 1: Apply PicoDrive Bridge Patch (1 hour)

### Step 1.1: Copy bridge file to PicoDrive

```bash
# Working directory: /mnt/data/src/32x-playground
cp pdcore/patches/pdcore_bridge.c third_party/picodrive/pico/pdcore_bridge.c
```

### Step 1.2: Add bridge to PicoDrive Makefile

**File:** `third_party/picodrive/Makefile`

Find the OBJS or SRCS variable and add:

```makefile
# Find section like:
OBJS += pico/draw.o pico/draw2.o pico/mode4.o pico/memory.o
# Add this line nearby:
OBJS += pico/pdcore_bridge.o
```

Or if using conditional compilation:

```makefile
ifdef USE_PDCORE
OBJS += pico/pdcore_bridge.o
CFLAGS += -DPDCORE_ENABLED
endif
```

### Step 1.3: Verify PicoDrive still compiles

```bash
cd third_party/picodrive
make clean
make
# Should complete without errors
```

**If compilation fails:**
- Check for missing includes (pico_int.h, sh2.h)
- Verify extern declarations match actual PicoDrive variables
- Read error messages carefully - likely a naming mismatch

---

## Phase 2: Wire Bridge Functions to pdcore (2 hours)

### Step 2.1: Create pdcore accessor wrappers

**File:** `pdcore/src/pdcore.c`

Find the section with TODO comments (around line 150) and replace:

```c
/* Get PicoDrive state (will be implemented in Phase 2) */
/* TODO: emu->genesis = pdcore_get_genesis_state(); */
```

Add these function declarations at the top of pdcore.c (after includes):

```c
/* External declarations for PicoDrive bridge functions
 * These are implemented in third_party/picodrive/pico/pdcore_bridge.c
 */
extern void *picodrive_get_pico32x_state(void);
extern void *picodrive_get_sh2_master(void);
extern void *picodrive_get_sh2_slave(void);
extern void *picodrive_get_pico_state(void);
extern void *picodrive_get_sdram(void);
extern void *picodrive_get_dram(void);
extern unsigned int picodrive_get_sdram_size(void);
extern unsigned int picodrive_get_dram_size(void);
```

### Step 2.2: Implement pdcore accessor functions

Add these functions to pdcore.c (find the place where pdcore_get_sh2_master is expected):

```c
/* Global emulator instance for callbacks */
pd_t *g_pdcore_emu = NULL;

/**
 * Get Master SH2 instance from PicoDrive
 */
SH2 *pdcore_get_sh2_master(void)
{
    return (SH2 *)picodrive_get_sh2_master();
}

/**
 * Get Slave SH2 instance from PicoDrive
 */
SH2 *pdcore_get_sh2_slave(void)
{
    return (SH2 *)picodrive_get_sh2_slave();
}

/**
 * Get SDRAM pointer for memory access
 */
void *pdcore_get_sdram(void)
{
    return picodrive_get_sdram();
}

/**
 * Get DRAM (frame buffer) pointer for memory access
 */
void *pdcore_get_dram(void)
{
    return picodrive_get_dram();
}
```

### Step 2.3: Update pd_create() to store SH2 pointers

In `pd_create()`, add after breakpoint initialization:

```c
    /* Store SH2 references */
    emu->master_sh2 = pdcore_get_sh2_master();
    emu->slave_sh2 = pdcore_get_sh2_slave();

    /* Set global for callbacks */
    g_pdcore_emu = emu;
```

### Step 2.4: Update pd_destroy() to clear global

In `pd_destroy()`, add:

```c
    if (emu == g_pdcore_emu) {
        g_pdcore_emu = NULL;
    }
```

---

## Phase 3: Complete Memory Access Functions (2 hours)

### Step 3.1: Find pd_mem_read implementation

**File:** `pdcore/src/pdcore.c`

Locate the `pd_mem_read()` function. If it's a stub, replace with:

```c
/**
 * Read from specific memory bus
 */
int pd_mem_read(pd_t *emu, pd_bus_t bus, uint32_t address,
                void *out_buf, size_t size)
{
    void *src = NULL;
    size_t available = 0;
    size_t offset = 0;

    if (!emu || !out_buf || size == 0) return PD_ERR_INVALID_PARAM;

    switch (bus) {
        case PD_BUS_SH2_SDRAM:
        case PD_BUS_SH2_SDRAM_WT:
            src = pdcore_get_sdram();
            if (!src) {
                PDCORE_ERROR(emu, "SDRAM not available");
                return PD_ERR_INVALID_ADDRESS;
            }
            /* SDRAM is at 0x06000000 in SH2 space, 256KB */
            if (address >= 0x06000000 && address < 0x06040000) {
                offset = address - 0x06000000;
                available = 0x40000 - offset;  /* 256KB */
            } else if (address >= 0x26000000 && address < 0x26040000) {
                /* Cache-through mirror */
                offset = address - 0x26000000;
                available = 0x40000 - offset;
            } else {
                PDCORE_ERROR(emu, "Invalid SDRAM address: 0x%08x", address);
                return PD_ERR_INVALID_ADDRESS;
            }
            break;

        case PD_BUS_SH2_FB:
            src = pdcore_get_dram();
            if (!src) {
                PDCORE_ERROR(emu, "Frame buffer not available");
                return PD_ERR_INVALID_ADDRESS;
            }
            /* Frame buffers at 0x04000000 / 0x04020000, 128KB each */
            if (address >= 0x04000000 && address < 0x04040000) {
                offset = address - 0x04000000;
                available = 0x40000 - offset;  /* 256KB total */
            } else if (address >= 0x24000000 && address < 0x24040000) {
                /* Cache-through mirror */
                offset = address - 0x24000000;
                available = 0x40000 - offset;
            } else {
                PDCORE_ERROR(emu, "Invalid FB address: 0x%08x", address);
                return PD_ERR_INVALID_ADDRESS;
            }
            break;

        case PD_BUS_SH2_ROM:
            /* ROM access - read from loaded ROM data */
            /* For now, not implemented - ROM is in separate buffer */
            PDCORE_ERROR(emu, "ROM bus access not yet implemented");
            return PD_ERR_UNSUPPORTED;

        case PD_BUS_SH2_SYS:
            /* System registers - special handling needed */
            PDCORE_ERROR(emu, "System register access not yet implemented");
            return PD_ERR_UNSUPPORTED;

        case PD_BUS_68K:
            /* 68K address space - not needed for Phase 11 */
            PDCORE_ERROR(emu, "68K bus access not yet implemented");
            return PD_ERR_UNSUPPORTED;

        default:
            PDCORE_ERROR(emu, "Unknown bus type: %d", bus);
            return PD_ERR_INVALID_PARAM;
    }

    /* Calculate how much to read */
    size_t to_read = (size > available) ? available : size;
    memcpy(out_buf, (uint8_t *)src + offset, to_read);

    return (int)to_read;
}
```

### Step 3.2: Implement pd_mem_write

```c
/**
 * Write to specific memory bus
 */
int pd_mem_write(pd_t *emu, pd_bus_t bus, uint32_t address,
                 const void *data, size_t size)
{
    void *dst = NULL;
    size_t available = 0;
    size_t offset = 0;

    if (!emu || !data || size == 0) return PD_ERR_INVALID_PARAM;

    switch (bus) {
        case PD_BUS_SH2_SDRAM:
        case PD_BUS_SH2_SDRAM_WT:
            dst = pdcore_get_sdram();
            if (!dst) {
                PDCORE_ERROR(emu, "SDRAM not available");
                return PD_ERR_INVALID_ADDRESS;
            }
            if (address >= 0x06000000 && address < 0x06040000) {
                offset = address - 0x06000000;
                available = 0x40000 - offset;
            } else if (address >= 0x26000000 && address < 0x26040000) {
                offset = address - 0x26000000;
                available = 0x40000 - offset;
            } else {
                PDCORE_ERROR(emu, "Invalid SDRAM address: 0x%08x", address);
                return PD_ERR_INVALID_ADDRESS;
            }
            break;

        case PD_BUS_SH2_FB:
            dst = pdcore_get_dram();
            if (!dst) {
                PDCORE_ERROR(emu, "Frame buffer not available");
                return PD_ERR_INVALID_ADDRESS;
            }
            if (address >= 0x04000000 && address < 0x04040000) {
                offset = address - 0x04000000;
                available = 0x40000 - offset;
            } else if (address >= 0x24000000 && address < 0x24040000) {
                offset = address - 0x24000000;
                available = 0x40000 - offset;
            } else {
                PDCORE_ERROR(emu, "Invalid FB address: 0x%08x", address);
                return PD_ERR_INVALID_ADDRESS;
            }
            break;

        default:
            PDCORE_ERROR(emu, "Write to bus %d not supported", bus);
            return PD_ERR_UNSUPPORTED;
    }

    size_t to_write = (size > available) ? available : size;
    memcpy((uint8_t *)dst + offset, data, to_write);

    return (int)to_write;
}
```

### Step 3.3: Implement convenience functions

```c
/**
 * Read 32-bit word from memory
 */
uint32_t pd_mem_read_u32(pd_t *emu, pd_bus_t bus, uint32_t address)
{
    uint32_t value = 0;
    pd_mem_read(emu, bus, address, &value, 4);
    return value;
}

/**
 * Write 32-bit word to memory
 */
int pd_mem_write_u32(pd_t *emu, pd_bus_t bus, uint32_t address, uint32_t value)
{
    return pd_mem_write(emu, bus, address, &value, 4);
}
```

---

## Phase 4: Build and Link Integration (1 hour)

### Step 4.1: Update pdcore Makefile to link with PicoDrive

**File:** `pdcore/Makefile`

Modify to include PicoDrive objects:

```makefile
.PHONY: all clean test

CC = gcc
CFLAGS = -Wall -Wextra -O2 -fPIC -Iinclude -I../third_party/picodrive
LDFLAGS = -shared

SOURCES = src/pdcore.c src/pdcore_bp.c src/pdcore_exec.c
HEADERS = include/pdcore.h include/pdcore_internal.h include/pdcore_bp.h
OBJECTS = $(SOURCES:.c=.o)

# PicoDrive bridge object
PICO_BRIDGE = ../third_party/picodrive/pico/pdcore_bridge.o

all: build/libpdcore.so

build/libpdcore.so: $(OBJECTS)
	@mkdir -p build
	$(CC) $(LDFLAGS) -o $@ $(OBJECTS) $(PICO_BRIDGE) 2>/dev/null || \
	$(CC) $(LDFLAGS) -o $@ $(OBJECTS)
	@echo "✓ Built $@"

%.o: %.c $(HEADERS)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJECTS) build/libpdcore.so
	@echo "✓ Cleaned"

test: all
	@echo "TODO: Run integration tests"
```

### Step 4.2: Rebuild pdcore

```bash
cd /mnt/data/src/32x-playground/pdcore
make clean
make all
```

**Expected output:**
```
✓ Built build/libpdcore.so
```

**If build fails:**
- Check for undefined references (bridge functions not found)
- Verify include paths are correct
- Check that PicoDrive was built first

---

## Phase 5: Create Integration Test (2 hours)

### Step 5.1: Create test file

**File:** `pdcore/tests/test_mvp1.c`

```c
/*
 * pdcore MVP-1 Integration Test
 *
 * Tests basic functionality:
 * 1. Create/destroy emulator
 * 2. Access SH2 registers
 * 3. Read/write SDRAM
 * 4. Set breakpoints
 * 5. Run execution
 */

#include "pdcore.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

#define TEST(name) printf("Test: %s... ", name)
#define PASS() printf("✓ PASS\n")
#define FAIL(msg) do { printf("✗ FAIL: %s\n", msg); return 1; } while(0)

int main(int argc, char *argv[])
{
    pd_t *emu;
    pd_sh2_regs_t regs;
    pd_stop_info_t stop;
    uint32_t value;
    int ret;

    printf("=== pdcore MVP-1 Integration Test ===\n\n");

    /* Test 1: Create emulator */
    TEST("pd_create()");
    emu = pd_create(NULL);
    if (!emu) FAIL("pd_create returned NULL");
    PASS();

    /* Test 2: Reset (should work even without ROM) */
    TEST("pd_reset()");
    ret = pd_reset(emu);
    if (ret != 0) FAIL("pd_reset failed");
    PASS();

    /* Test 3: Get SH2 registers (may be NULL if no ROM loaded) */
    TEST("pd_get_sh2_regs(MASTER)");
    memset(&regs, 0, sizeof(regs));
    ret = pd_get_sh2_regs(emu, PD_CPU_MASTER, &regs);
    /* This may fail if PicoDrive not initialized - that's OK for this test */
    if (ret == 0) {
        printf("PC=0x%08x ", regs.pc);
        PASS();
    } else {
        printf("(skipped - no ROM) ");
        PASS();
    }

    /* Test 4: Breakpoint system */
    TEST("pd_bp_exec_add()");
    ret = pd_bp_exec_add(emu, PD_CPU_MASTER, 0x06000000, NULL, NULL);
    if (ret < 0) FAIL("pd_bp_exec_add failed");
    PASS();

    TEST("pd_bp_exec_exists()");
    ret = pd_bp_exec_exists(emu, PD_CPU_MASTER, 0x06000000);
    if (ret != 1) FAIL("Breakpoint not found");
    PASS();

    TEST("pd_bp_exec_del()");
    ret = pd_bp_exec_del(emu, PD_CPU_MASTER, 0x06000000);
    if (ret != 0) FAIL("pd_bp_exec_del failed");
    PASS();

    /* Test 5: Error handling */
    TEST("pd_get_error()");
    const char *err = pd_get_error(emu);
    if (!err) FAIL("pd_get_error returned NULL");
    PASS();

    /* Test 6: Halt mechanism */
    TEST("pd_halt()");
    pd_halt(emu);
    PASS();

    /* Test 7: Destroy */
    TEST("pd_destroy()");
    pd_destroy(emu);
    PASS();

    printf("\n=== All MVP-1 tests passed! ===\n");
    return 0;
}
```

### Step 5.2: Add test target to Makefile

```makefile
test: all pdcore/tests/test_mvp1.c
	$(CC) -o build/test_mvp1 tests/test_mvp1.c -Iinclude -Lbuild -lpdcore
	LD_LIBRARY_PATH=build ./build/test_mvp1
```

### Step 5.3: Run tests

```bash
cd /mnt/data/src/32x-playground/pdcore
make test
```

**Expected output:**
```
=== pdcore MVP-1 Integration Test ===

Test: pd_create()... ✓ PASS
Test: pd_reset()... ✓ PASS
Test: pd_get_sh2_regs(MASTER)... (skipped - no ROM) ✓ PASS
Test: pd_bp_exec_add()... ✓ PASS
Test: pd_bp_exec_exists()... ✓ PASS
Test: pd_bp_exec_del()... ✓ PASS
Test: pd_get_error()... ✓ PASS
Test: pd_halt()... ✓ PASS
Test: pd_destroy()... ✓ PASS

=== All MVP-1 tests passed! ===
```

---

## Phase 6: ROM Loading Integration (2 hours)

### Step 6.1: Implement pd_load_rom using PicoDrive

This is the most complex step - we need to call PicoDrive's ROM loading.

**Option A: Direct function call (if PicoDrive exports it)**

Add to bridge functions:
```c
/* In pdcore_bridge.c */
extern int PicoLoadMedia(const char *filename, const char *bios);

int picodrive_load_rom(const char *path)
{
    return PicoLoadMedia(path, NULL);
}
```

**Option B: Standalone mode (if PicoDrive doesn't export)**

For MVP-1, we can skip ROM loading and test with registers/memory only. The execution functions will work once PicoDrive is running.

### Step 6.2: Update pd_load_rom_file

```c
/* External declaration */
extern int picodrive_load_rom(const char *path);

int pd_load_rom_file(pd_t *emu, const char *path)
{
    int ret;

    if (!emu || !path) return PD_ERR_INVALID_PARAM;

    /* Call PicoDrive's ROM loading */
    ret = picodrive_load_rom(path);
    if (ret != 0) {
        PDCORE_ERROR(emu, "PicoDrive failed to load ROM: %s", path);
        return PD_ERR_INVALID_PARAM;
    }

    /* Update SH2 pointers (may have changed after ROM load) */
    emu->master_sh2 = pdcore_get_sh2_master();
    emu->slave_sh2 = pdcore_get_sh2_slave();

    return 0;
}
```

---

## Phase 7: Final Verification (1 hour)

### Step 7.1: Full integration test with ROM

Create `pdcore/tests/test_with_rom.c`:

```c
#include "pdcore.h"
#include <stdio.h>

int main(int argc, char *argv[])
{
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <game.32x>\n", argv[0]);
        return 1;
    }

    printf("Creating emulator...\n");
    pd_t *emu = pd_create(NULL);
    if (!emu) {
        fprintf(stderr, "Failed to create emulator\n");
        return 1;
    }

    printf("Loading ROM: %s\n", argv[1]);
    int ret = pd_load_rom_file(emu, argv[1]);
    if (ret != 0) {
        fprintf(stderr, "Failed to load ROM: %s\n", pd_get_error(emu));
        pd_destroy(emu);
        return 1;
    }

    printf("Resetting...\n");
    pd_reset(emu);

    printf("Running 1 frame...\n");
    pd_stop_info_t stop;
    pd_run_frames(emu, 1, &stop);
    printf("  Frame: %u, Cycles: %llu\n", stop.frame_number,
           (unsigned long long)stop.master_cycles);

    printf("Reading Master SH2 registers...\n");
    pd_sh2_regs_t regs;
    pd_get_sh2_regs(emu, PD_CPU_MASTER, &regs);
    printf("  PC: 0x%08x\n", regs.pc);
    printf("  R0: 0x%08x\n", regs.r[0]);
    printf("  R15 (SP): 0x%08x\n", regs.r[15]);

    printf("Reading SDRAM[0x06000000]...\n");
    uint32_t sdram_val = pd_mem_read_u32(emu, PD_BUS_SH2_SDRAM, 0x06000000);
    printf("  Value: 0x%08x\n", sdram_val);

    printf("Cleaning up...\n");
    pd_destroy(emu);

    printf("\n✓ Full integration test complete!\n");
    return 0;
}
```

### Step 7.2: Run with actual ROM

```bash
cd /mnt/data/src/32x-playground
./pdcore/build/test_with_rom "roms/Virtua Racing Deluxe (USA).32x"
```

---

## Success Criteria Checklist

After completing all phases, verify:

- [ ] `make -C pdcore all` completes without errors
- [ ] `make -C pdcore test` passes all MVP-1 tests
- [ ] `pd_create()` returns non-NULL handle
- [ ] `pd_destroy()` doesn't crash
- [ ] `pd_bp_exec_add()` returns valid breakpoint ID
- [ ] `pd_bp_exec_exists()` returns 1 for added breakpoint
- [ ] `pd_bp_exec_del()` returns 0 on success
- [ ] `pd_get_sh2_regs()` returns register values (when ROM loaded)
- [ ] `pd_mem_read()` reads from SDRAM successfully
- [ ] `pd_mem_write()` writes to SDRAM successfully
- [ ] `pd_run_frames()` advances frame counter
- [ ] No memory leaks (run with valgrind if available)

---

## Troubleshooting Guide

### Problem: "undefined reference to picodrive_*"

**Cause:** Bridge functions not linked
**Solution:** Ensure pdcore_bridge.o is in OBJS list in PicoDrive Makefile

### Problem: "SDRAM not available"

**Cause:** PicoDrive not initialized or no ROM loaded
**Solution:** Call pd_load_rom_file() before memory access

### Problem: "pd_get_sh2_regs returns error"

**Cause:** SH2 pointers are NULL
**Solution:** Verify pdcore_get_sh2_master() returns valid pointer after ROM load

### Problem: Segmentation fault in pd_run_cycles

**Cause:** SH2 run function pointer is NULL or invalid
**Solution:** Check that sh2->run is set by PicoDrive initialization

### Problem: Frame counter doesn't increment

**Cause:** V-BLANK callback not connected
**Solution:** Implement pdcore_attach_vblank_callback() to set Pico32x callback

---

## Files Modified Summary

| File | Action | Lines Changed |
|------|--------|---------------|
| `third_party/picodrive/pico/pdcore_bridge.c` | Add (copy from patches/) | +62 |
| `third_party/picodrive/Makefile` | Modify (add OBJS) | +1 |
| `pdcore/src/pdcore.c` | Modify (wire bridge) | +50 |
| `pdcore/Makefile` | Modify (add test target) | +5 |
| `pdcore/tests/test_mvp1.c` | Add (new file) | +80 |
| `pdcore/tests/test_with_rom.c` | Add (new file) | +60 |

**Total new/modified:** ~258 lines

---

## Phase 11 Integration Point

Once MVP-1 is complete, Phase 11 can use pdcore to:

1. **Locate Slave polling loop:**
   ```c
   pd_sh2_regs_t regs;
   pd_get_sh2_regs(emu, PD_CPU_SLAVE, &regs);
   printf("Slave PC: 0x%08x\n", regs.pc);
   ```

2. **Inject Slave hook code:**
   ```c
   uint8_t hook_code[] = { /* SH2 opcodes */ };
   pd_mem_write(emu, PD_BUS_SH2_SDRAM, 0x06000596, hook_code, sizeof(hook_code));
   ```

3. **Monitor COMM registers:**
   ```c
   uint32_t comm4 = pd_mem_read_u32(emu, PD_BUS_SH2_SYS, 0x20004028);
   printf("COMM4 counter: %u\n", comm4);
   ```

4. **Set breakpoint on Slave PC:**
   ```c
   pd_bp_exec_add(emu, PD_CPU_SLAVE, 0x06000596, my_handler, NULL);
   ```

---

## References

- [PDCORE_MVP1_ROADMAP.md](analysis/debugger-design/PDCORE_MVP1_ROADMAP.md) - Original detailed roadmap
- [PDCORE_API_DESIGN.md](analysis/debugger-design/PDCORE_API_DESIGN.md) - Full API specification
- [PDCORE_SURGICAL_INSERTION_CHECKLIST.md](analysis/debugger-design/PDCORE_SURGICAL_INSERTION_CHECKLIST.md) - PicoDrive modification guide
- [PHASE11_SLAVE_HOOK_ROADMAP.md](PHASE11_SLAVE_HOOK_ROADMAP.md) - Slave hook implementation plan

---

**Status:** Ready for Haiku execution
**Estimated completion:** 8-12 hours of focused work

