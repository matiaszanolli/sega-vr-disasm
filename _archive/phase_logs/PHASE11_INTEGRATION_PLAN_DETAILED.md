# Phase 11: PicoDrive Integration Plan (Option 1 with Risk Guards)

**Date:** 2026-01-22
**Approach:** Full PicoDrive integration with strict guards and fallback validation
**Risk Level:** MEDIUM (mitigated by guards and validation checkpoints)

---

## Executive Summary

Integrate pdcore with PicoDrive following a **"inert by default"** strategy:
- pdcore enabled only via compile flag (not in default build)
- Default PicoDrive binary remains **identical** to current behavior
- Bridge functions isolated and guarded
- ROM patching tool (Option 2) serves as validation fallback
- Clear rollback path documented

**Timeline:** 2-3 hours integration + validation

---

## Phase 1: Pre-Integration Checkpoint (30 minutes)

### 1.1 Create Integration Branch
```bash
git checkout -b feature/phase11-pdcore-integration
```

### 1.2 Document Current State
Create baseline snapshot:
```bash
# Record baseline binary size and behavior
ls -lh picodrive/picodrive
md5sum picodrive/picodrive > /tmp/baseline_picodrive.md5

# Record baseline test results
./tools/phase11_test_harness > /tmp/baseline_test_harness.log 2>&1

# Build without any pdcore changes
make clean && make all
ls -lh build/vr_rebuild.32x > /tmp/baseline_rom.log
```

### 1.3 Identify Integration Points

**Key files to modify:**
1. `picodrive/Makefile` - Add pdcore target and conditional build
2. `picodrive/pico/pdcore_bridge.c` - Create/modify bridge functions (new file if needed)
3. `pdcore/include/pdcore.h` - Already complete, no changes needed
4. Build configuration - Add `ENABLE_PDCORE` flag

**Files that should NOT change:**
- `picodrive/pico/pico.c` - Main emulator loop
- `picodrive/pico/32x/32x.c` - 32X state management
- Any core emulation logic

---

## Phase 2: Bridge Layer Implementation (1 hour)

### 2.1 Create Guarded pdcore_bridge.c

```c
/* picodrive/pico/pdcore_bridge.c */

#ifdef ENABLE_PDCORE

#include "../pdcore.h"
#include "pico_internal.h"

/* Guard: These functions only compiled if ENABLE_PDCORE */

void *picodrive_get_pico32x_state(void)
{
    extern struct Pico32x *Pico32x;
    return (void *)Pico32x;
}

void *picodrive_get_sh2_master(void)
{
    extern SH2 *sh2_master;
    return (void *)sh2_master;
}

void *picodrive_get_sh2_slave(void)
{
    extern SH2 *sh2_slave;
    return (void *)sh2_slave;
}

void *picodrive_get_pico_state(void)
{
    extern struct Pico *Pico;
    return (void *)Pico;
}

void *picodrive_get_sdram(void)
{
    extern uint8_t *Pico32xMem;
    if (!Pico32xMem) return NULL;
    return (void *)Pico32xMem;  /* SDRAM offset 0 */
}

void *picodrive_get_dram(void)
{
    extern uint8_t *Pico32xMem;
    if (!Pico32xMem) return NULL;
    return (void *)(Pico32xMem + 0x40000);  /* DRAM offset */
}

unsigned int picodrive_get_sdram_size(void)
{
    return 0x40000;  /* 256 KB */
}

unsigned int picodrive_get_dram_size(void)
{
    return 0x40000;  /* 256 KB */
}

#else  /* !ENABLE_PDCORE */

/* Stub implementations when pdcore disabled */
void *picodrive_get_pico32x_state(void) { return NULL; }
void *picodrive_get_sh2_master(void) { return NULL; }
void *picodrive_get_sh2_slave(void) { return NULL; }
void *picodrive_get_pico_state(void) { return NULL; }
void *picodrive_get_sdram(void) { return NULL; }
void *picodrive_get_dram(void) { return NULL; }
unsigned int picodrive_get_sdram_size(void) { return 0; }
unsigned int picodrive_get_dram_size(void) { return 0; }

#endif  /* ENABLE_PDCORE */
```

**Key Points:**
- Entire bridge guarded by `#ifdef ENABLE_PDCORE`
- No changes to PicoDrive core logic
- Symbols are weak/soft - only resolved if pdcore linked
- Stubs prevent linking errors when pdcore disabled

### 2.2 Verify Symbol Visibility

Check that exported symbols match pdcore expectations:
```bash
# After implementing bridge:
nm picodrive/pico/pdcore_bridge.o | grep picodrive_get

# Should show:
# U picodrive_get_pico32x_state  (undefined, resolved at link time)
# etc.
```

---

## Phase 3: Makefile Integration (30 minutes)

### 3.1 Add pdcore Build Target

```makefile
# Makefile (excerpt)

# Flag to enable/disable pdcore (default: disabled)
ENABLE_PDCORE ?= 0

ifeq ($(ENABLE_PDCORE),1)
  CFLAGS += -DENABLE_PDCORE
  PDCORE_LIBS = pdcore/build/libpdcore.so
  PDCORE_OBJECTS = picodrive/pico/pdcore_bridge.o
else
  PDCORE_LIBS =
  PDCORE_OBJECTS =
endif

# pdcore library target
pdcore/build/libpdcore.so:
	$(MAKE) -C pdcore build

# pdcore bridge object
picodrive/pico/pdcore_bridge.o: picodrive/pico/pdcore_bridge.c
	gcc $(CFLAGS) -I pdcore/include -c $< -o $@

# Default build (no pdcore)
.DEFAULT_GOAL := all

all: pdcore_build_check picodrive

pdcore_build_check:
ifeq ($(ENABLE_PDCORE),1)
	@echo "Building with pdcore integration..."
	$(MAKE) pdcore/build/libpdcore.so
else
	@echo "Building without pdcore (standard build)"
endif

picodrive: $(PDCORE_OBJECTS)
	gcc ... $(PDCORE_OBJECTS) $(PDCORE_LIBS) -o picodrive

# With pdcore flag
pdcore-build:
	$(MAKE) ENABLE_PDCORE=1 all

# Without pdcore (default)
clean:
	rm -f $(PDCORE_OBJECTS)
	$(MAKE) -C pdcore clean
```

**Key Points:**
- `ENABLE_PDCORE=0` by default (no change to current build)
- `ENABLE_PDCORE=1` only when explicitly requested
- `pdcore-build` target provides easy opt-in
- Standard `make all` unchanged

### 3.2 Document Build Modes

Create `BUILD_MODES.md`:
```markdown
## Build Modes

### Standard Build (Default)
\`\`\`bash
make all
\`\`\`
- PicoDrive built WITHOUT pdcore
- No pdcore overhead or coupling
- Identical binary to before integration
- All existing tests pass

### With pdcore Integration
\`\`\`bash
make pdcore-build
\`\`\`
- PicoDrive built WITH pdcore library
- Enables pdcore CLI debugging tools
- Used for Phase 11 hook injection testing
- May have minor timing differences (profiling required)

### Rollback (if needed)
\`\`\`bash
git checkout picodrive/pico/pdcore_bridge.c
make clean && make all
\`\`\`
```

---

## Phase 4: Validation Checkpoints (1 hour)

### 4.1 Checkpoint 1: Default Build Unchanged

```bash
# Build standard (no pdcore)
make clean && make all

# Compare with baseline
ls -lh build/vr_rebuild.32x
md5sum build/vr_rebuild.32x
diff <(xxd build/vr_rebuild.32x | head -100) \
     <(xxd /tmp/baseline_rom.bin | head -100)

# Run standard tests
./tools/phase11_test_harness < /dev/null
# Should show: Tests Passed: 5/5 (same as baseline)
```

**Acceptance Criteria:**
- ✅ ROM binary identical or negligible size difference (<0.1%)
- ✅ All test harness tests pass (5/5)
- ✅ No new warnings/errors in build

### 4.2 Checkpoint 2: pdcore Build Works

```bash
# Build with pdcore
make pdcore-build 2>&1 | tee /tmp/pdcore_build.log

# Check for errors
if grep -i "error" /tmp/pdcore_build.log; then
  echo "FAIL: Compilation errors"
  exit 1
fi

# Verify pdcore library present
ls -lh pdcore/build/libpdcore.so

# Verify pdcore_cli built
ls -lh tools/pdcore_cli
```

**Acceptance Criteria:**
- ✅ pdcore library compiles without errors
- ✅ pdcore_cli tool compiles and runs
- ✅ No undefined symbol references at link time

### 4.3 Checkpoint 3: ROM Patching Validation

If pdcore integration causes issues, validate fallback:

```bash
# Use ROM patcher as validation
python3 tools/phase11_rom_patcher.py build/vr_rebuild.32x \
  build/vr_rebuild_patched.32x

# Boot patched ROM in standard PicoDrive (no pdcore needed)
picodrive build/vr_rebuild_patched.32x

# Observe:
# - Game boots normally
# - Graphics render correctly
# - No immediate crashes
```

**Acceptance Criteria:**
- ✅ Patched ROM boots successfully
- ✅ Hook injection verified via ROM patcher
- ✅ Demonstrates hook mechanism works (fallback validation)

### 4.4 Checkpoint 4: Profiling for Regressions

Check for hidden timing side effects:

```bash
# Baseline (no pdcore)
make clean && make all
time picodrive build/vr_rebuild.32x < /tmp/test_inputs &
sleep 5 && pkill picodrive

# With pdcore
make pdcore-build
time picodrive build/vr_rebuild.32x < /tmp/test_inputs &
sleep 5 && pkill picodrive

# Compare performance metrics
# Expected: <5% frame rate difference (acceptable)
```

**Acceptance Criteria:**
- ✅ No significant FPS drop (<5%)
- ✅ No audio skips or glitches
- ✅ No determinism loss (frame count stable)

---

## Phase 5: Runtime Hook Injection (30 minutes)

### 5.1 Boot ROM with pdcore

```bash
# With pdcore integration in place:
./tools/pdcore_cli build/vr_rebuild.32x boot 50

# Expected:
# [1/6] Creating emulator...
#       ✓ Emulator created
# [2/6] Loading ROM...
#       ✓ ROM loaded (4194310 bytes)
# [3/6] Resetting emulation...
#       ✓ Reset complete
# ...
# ✓ Boot complete (50 frames)
```

### 5.2 Locate Slave Polling Loop

```bash
# Read Slave registers after boot
./tools/pdcore_cli build/vr_rebuild.32x regs slave

# Expected output:
# PC  = 0x06000596 (or nearby)
# R0  = 0x20004000
# R15 = 0x06030000 (SP)
# SR  = 0x00000000
```

### 5.3 Inject Hook at Runtime

```bash
# Write hook bytecode to SDRAM
./tools/pdcore_cli build/vr_rebuild.32x write 0x06000596 \
  d00200002000402c60 04e21232108f060d00 \
  200000023000274000 0009d00200002000 \
  402ce2102103000b0009

# Verify bytecode
./tools/pdcore_cli build/vr_rebuild.32x read 0x06000596 44

# Expected:
# Address: 0x06000596
#   06000596: D0 02 00 00 20 00 40 2C  60 04 E2 12 32 10 8F 06
#   060005A6: D0 02 00 00 02 30 00 27  40 00 00 09 D0 02 00 00
#   ...
```

---

## Phase 6: Regression Detection (Plan B)

### 6.1 Red Flags to Watch

If any of these occur, revert and use Option 2 (ROM patching):

| Red Flag | Severity | Action |
|----------|----------|--------|
| ROM size changes >1% | High | Revert & investigate linker |
| Undefined symbols at link | Critical | Fix bridge guards |
| FPS drops >10% | High | Profile and identify overhead |
| Audio glitches | High | Check memory access timing |
| Determinism loss | Critical | Check for uninitialized state |
| Test harness fails | Critical | pdcore linkage issue |

### 6.2 Rollback Procedure (Automated)

```bash
#!/bin/bash
# rollback.sh - Emergency rollback to pre-integration state

set -e

echo "🚨 Rolling back Phase 11 pdcore integration..."

# Abort any ongoing builds
make distclean || true

# Revert integration changes
git checkout picodrive/pico/pdcore_bridge.c
git checkout Makefile

# Remove pdcore from build
rm -f picodrive/pico/pdcore_bridge.o pdcore/build/libpdcore.so

# Rebuild standard
make clean && make all

# Verify
if ./tools/phase11_test_harness | grep -q "5/5"; then
  echo "✅ Rollback successful - tests pass"
  echo "Use Option 2 (ROM patching) as fallback"
  exit 0
else
  echo "❌ Rollback verification failed"
  exit 1
fi
```

---

## Phase 7: Final Validation (30 minutes)

### 7.1 Smoke Test with Hook Injected

```bash
# Boot, inject, verify
./tools/pdcore_cli build/vr_rebuild.32x boot 50 && \
./tools/pdcore_cli build/vr_rebuild.32x write 0x06000596 d00200002000402c... && \
./tools/pdcore_cli build/vr_rebuild.32x read 0x06000596 44

# Visual smoke test (manual)
# Boot patched ROM in PicoDrive
# - Game title screen renders
# - Graphics look normal
# - No visual corruption
# - Audio plays
# - Input responsive
```

### 7.2 Extended Validation

```bash
# Run 120-frame test with hook
# Monitor counter at 0x22000100 (COMM4)
# Expected: increments every frame (120 total over 120 frames)

./tools/pdcore_cli build/vr_rebuild.32x boot 50 && \
./tools/pdcore_cli build/vr_rebuild.32x write 0x06000596 <bytecode>

# Let it run 120 frames and verify counter
```

### 7.3 Commit Safe Integration

```bash
git add picodrive/pico/pdcore_bridge.c Makefile BUILD_MODES.md
git commit -m "feat: Phase 11 - Optional pdcore integration (gated by ENABLE_PDCORE)

## Summary
Integrated pdcore with PicoDrive using strict guard:
- pdcore disabled by default (zero overhead)
- Enabled only via ENABLE_PDCORE=1 compile flag
- Bridge functions isolated and guarded
- Default build unchanged, regression tests pass

## Integration Points
- picodrive/pico/pdcore_bridge.c - Bridge functions (new)
- Makefile - Conditional compilation (modified)
- BUILD_MODES.md - Documentation (new)

## Validation
- ✅ Standard build (no pdcore) unchanged
- ✅ pdcore-build compiles successfully
- ✅ All test harness tests pass (5/5)
- ✅ Hook injection verified (44 bytes, checksummed)
- ✅ ROM patching fallback validates hook mechanism

## Rollback
Emergency rollback available via rollback.sh script
If regressions detected: git checkout feature/phase11-pdcore-integration

Co-Authored-By: Claude Haiku 4.5 <noreply@anthropic.com>"
```

---

## Risk Mitigation Checklist

### Before Starting Integration
- [ ] Create integration branch: `feature/phase11-pdcore-integration`
- [ ] Document baseline ROM/binary
- [ ] Document baseline test results
- [ ] Identify all integration points
- [ ] Review pdcore bridge requirements

### During Integration
- [ ] Implement bridge with `#ifdef ENABLE_PDCORE` guards
- [ ] Update Makefile with conditional compilation
- [ ] Verify default build unchanged
- [ ] Checkpoint 1: Default build works (5/5 tests)
- [ ] Checkpoint 2: pdcore-build works
- [ ] Checkpoint 3: ROM patcher validates fallback
- [ ] Checkpoint 4: Profile for timing regressions

### After Integration
- [ ] pdcore_cli boots ROM successfully
- [ ] Hook injection works (bytecode verified)
- [ ] 120-frame smoke test passes
- [ ] Commit with clear rollback path
- [ ] Tag commit for easy reference

### Continuous Safety
- [ ] Keep `rollback.sh` script ready
- [ ] Monitor for undocumented pdcore dependencies
- [ ] Check for ABI drift between builds
- [ ] Validate determinism on each run

---

## Success Criteria

Integration is **COMPLETE** when ALL of these pass:

- ✅ Standard `make all` produces identical binary (or <0.1% size diff)
- ✅ All 5/5 test harness tests pass
- ✅ pdcore-build flag works and compiles
- ✅ pdcore_cli tool boots ROM successfully
- ✅ Hook injection at 0x06000596 succeeds
- ✅ Bytecode verified (44 bytes, checksummed)
- ✅ ROM patcher fallback validates hook mechanism
- ✅ <5% FPS difference with pdcore enabled
- ✅ Determinism maintained (frame count stable)
- ✅ No undefined symbols at link time
- ✅ Rollback procedure tested and working

---

## Timeline

| Phase | Task | Effort | Checkpoint |
|-------|------|--------|------------|
| 1 | Pre-integration setup | 30 min | Branch created, baseline documented |
| 2 | Bridge implementation | 1 hour | Bridge compiles, no errors |
| 3 | Makefile integration | 30 min | Conditional flags work |
| 4 | Validation checkpoints | 1 hour | 4 checkpoints pass |
| 5 | Runtime injection | 30 min | Hook injected successfully |
| 6 | Regression detection | — | (monitoring only) |
| 7 | Final validation | 30 min | All smoke tests pass |
| **Total** | | **3.5-4 hours** | Ready to document Phase 11 results |

---

## References

- [PHASE11_STATUS_CHECKPOINT.md](PHASE11_STATUS_CHECKPOINT.md) - Current status
- [PHASE11_HOOK_BYTECODE.md](PHASE11_HOOK_BYTECODE.md) - Hook bytecode reference
- [pdcore/include/pdcore.h](pdcore/include/pdcore.h) - pdcore API
- [tools/phase11_rom_patcher.py](tools/phase11_rom_patcher.py) - Fallback validation tool

