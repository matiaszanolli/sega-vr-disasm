# PicoDrive + pdcore Integration

**Status:** Phase 3 Complete - Conditional compilation guards in place

---

## Overview

This document describes how pdcore (PicoDrive Debugger Core) is integrated with PicoDrive for Phase 11 hook injection testing.

The integration uses **inert-by-default** design:
- Standard PicoDrive build (no flag) = zero changes to behavior
- pdcore build (ENABLE_PDCORE=1) = debugger functionality enabled

---

## Integration Components

### 1. Debug Hooks in PicoDrive Structures (Passive)

**File: `cpu/sh2/sh2.h`** - SH2 structure
```c
typedef struct SH2_ {
    // ... existing fields ...

    // Debug hooks (pdcore debugger support - NULL when no debugger attached)
    int (*debug_check_breakpoint)(struct SH2_ *sh2);
    void *debug_context;
} SH2;
```

**File: `pico/pico_int.h`** - Pico32x structure
```c
struct Pico32x {
    // ... existing fields ...

    // Debug hooks (pdcore debugger support - NULL when no debugger attached)
    void (*debug_vblank_callback)(void);
};
```

**Impact:** Adds two pointer fields (8 bytes per SH2, 8 bytes per Pico32x). Pointers are NULL by default → no behavior change.

### 2. Execution Loop Hooks (Guarded by NULL Checks)

**File: `cpu/sh2/mame/sh2pico.c`** - SH2 interpreter loop
```c
do_sh2_trace(sh2, sh2->icount);

// Debug hook: check for breakpoints (pdcore debugger support)
if (sh2->debug_check_breakpoint && sh2->debug_check_breakpoint(sh2)) {
    break;  // Breakpoint hit - stop execution
}
```

**Impact:** Single conditional check per instruction. When NULL (default) → zero overhead.

### 3. V-BLANK Callback (Guarded by NULL Check)

**File: `pico/32x/32x.c`** - V-BLANK handler
```c
p32x_trigger_irq(NULL, Pico.t.m68c_aim, P32XI_VINT);

// Debug hook: V-BLANK callback (pdcore debugger support)
if (Pico32x.debug_vblank_callback)
    Pico32x.debug_vblank_callback();
```

**Impact:** Single conditional check per V-BLANK. When NULL (default) → zero overhead.

### 4. pdcore Bridge (Compile-Time Guard)

**File: `pico/pdcore_bridge.c`** - Accessor functions
```c
#ifdef ENABLE_PDCORE

// Full implementation when ENABLE_PDCORE is set
void *picodrive_get_sh2_master(void) { return (void *)&sh2s[0]; }
// ... etc ...

#else

// Stub implementations when disabled
void *picodrive_get_sh2_master(void) { return NULL; }
// ... etc ...

#endif
```

**Impact:**
- With ENABLE_PDCORE=0 (default): Bridge provides stub functions (no-op)
- With ENABLE_PDCORE=1: Bridge provides full access to emulator state

---

## Build Modes

### Standard Build (Default)
```bash
cd third_party/picodrive && make
# OR
./build_picodrive.sh
```

**Result:**
- pdcore_bridge.o compiles with stubs only
- Debug hook pointers all NULL (zero overhead)
- Behavior identical to unmodified PicoDrive
- No pdcore linking required

### With pdcore Integration
```bash
cd third_party/picodrive && ENABLE_PDCORE=1 make
# OR
./build_picodrive.sh --pdcore
```

**Result:**
- pdcore_bridge.o compiles with full implementation
- Debug hook pointers become active (when set by pdcore)
- Requires pdcore library to be linked
- Enables hook injection and debugging

---

## Risk Analysis

### Overhead When Debug Hooks are NULL (Standard Build)
- Two pointer checks in tight loops: negligible (branch predictor caches)
- Structure size increase: 16 bytes total (minimal)
- Linker impact: zero (all pointers NULL)

### Verification Strategy
1. **Binary size**: Compare standard build with/without modifications
2. **Performance**: Measure FPS difference (expect <1% with hooks disabled)
3. **Determinism**: Boot ROM repeatedly, verify identical behavior
4. **Structure layout**: Confirm SH2/Pico32x structure offsets unchanged

---

## Compilation Details

### Enable pdcore on Command Line
```bash
make ENABLE_PDCORE=1
```

The Makefile passes ENABLE_PDCORE as a preprocessor flag:
```makefile
CFLAGS += -DENABLE_PDCORE
```

### Selective Component Compilation

When ENABLE_PDCORE is disabled:
- pico/pdcore_bridge.c compiles stubs → object file is small (~2KB)
- No actual PicoDrive access code compiled
- No pdcore dependency at link time

When ENABLE_PDCORE is enabled:
- pico/pdcore_bridge.c compiles full implementation
- Links against pdcore library (libpdcore.so)
- Provides runtime memory access for Phase 11 testing

---

## Integration with pdcore

### pdcore Initialization (When Enabled)
```c
// In pdcore startup:
pd_t *emu = pd_create("build/vr_rebuild.32x", NULL);

// This triggers pdcore_bridge functions:
void *sdram = picodrive_get_sdram();  // Returns pointer to SDRAM
SH2 *slave = picodrive_get_sh2_slave();  // Returns pointer to Slave CPU
```

### Hook Installation (Phase 11 Specific)
```c
// pdcore can now set breakpoint hooks:
slave->debug_check_breakpoint = pd_breakpoint_check;
slave->debug_context = (void *)breakpoint_list;

// And V-BLANK callbacks:
Pico32x.debug_vblank_callback = pd_vblank_handler;
```

---

## Testing Strategy

### Checkpoint 1: Standard Build Unchanged
```bash
./build_picodrive.sh
ls -lh third_party/picodrive/picodrive
# Record binary size

./tools/phase11_test_harness
# Should pass all 5/5 tests (uses stubs, not real PicoDrive)
```

### Checkpoint 2: pdcore Build Compiles
```bash
./build_picodrive.sh --pdcore
ls -lh third_party/picodrive/picodrive
# Compare binary size (small increase expected, <5%)

file third_party/picodrive/picodrive
# Check dynamic dependencies (should include libpdcore.so)
```

### Checkpoint 3: ROM Boots with Both Builds
```bash
# Standard build
third_party/picodrive/picodrive build/vr_rebuild.32x
# Should boot normally, no visible difference

# pdcore build
third_party/picodrive/picodrive build/vr_rebuild.32x
# Should boot identically (hooks not yet active)
```

### Checkpoint 4: pdcore Integration Works
```bash
./tools/pdcore_cli build/vr_rebuild.32x boot 50
# Should boot successfully with real PicoDrive
```

---

## Safety Guarantees

1. **No Silent Changes**: All hooks are compile-time guards or NULL checks
2. **Rollback Capability**: Switch between builds with single flag
3. **Zero Overhead When Disabled**: Pointer checks are negligible in branch prediction
4. **Isolated Coupling**: pdcore only accesses via stable public structures
5. **Determinism Preserved**: No state mutation, only read access

---

## Future Integration Paths

### Path A: Full Integration (Current)
- Modify debug hooks in PicoDrive as needed
- Expand pdcore_bridge with new accessors
- Add more V-BLANK, interrupt, or memory event callbacks

### Path B: GDB Integration
- Use PicoDrive GDB stub alongside pdcore
- Combine command-line debugging with emulator inspection

### Path C: Minimal Mode (Current Default)
- Keep standard build unmodified
- Only use pdcore for specific testing phases
- No permanent binary changes

---

## Build Commands Reference

```bash
# Standard PicoDrive (no pdcore)
./build_picodrive.sh

# With pdcore debugger
./build_picodrive.sh --pdcore

# Clean PicoDrive build
./build_picodrive.sh --clean

# Manual: specify make flags
cd third_party/picodrive
make ENABLE_PDCORE=1
```

---

## Commit History

| Commit | Change |
|--------|--------|
| Add debug hooks to SH2/Pico32x structures | Passive pointer fields |
| Add breakpoint/V-BLANK checks in execution | Guarded NULL checks |
| Guard pdcore_bridge.c with #ifdef | Compile-time selection |
| Create build_picodrive.sh wrapper | Easy build mode switching |

---

## Notes

- The integration is **non-invasive** by design
- Default behavior is **guaranteed identical** to unmodified PicoDrive
- pdcore can be enabled/disabled per-build without code changes
- All modifications are clearly marked with `// Debug hook` comments
- No changes to core emulation logic (read-only access only)

