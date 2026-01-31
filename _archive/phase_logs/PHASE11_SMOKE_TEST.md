# Phase 11: Slave Hook Smoke Test Procedures

**Date:** 2026-01-22
**Status:** Ready for Phase 11 Step 5

---

## Overview

Smoke test validates that the Slave hook:
- Executes without crashing the emulator
- Calls expansion_frame_counter correctly
- Increments diagnostic counters each frame
- Maintains game playability

**Duration:** ~10-15 minutes total
**Success Criteria:** All 8 checks pass ✅

---

## Smoke Test Procedure

### Phase 11 Step 5: Initial Verification (10 frames)

**Goal:** Quick validation that hook injection didn't break anything.

#### Setup
```bash
./phase11_hook_injector build/vr_rebuild.32x --test-frames 10 -v
```

#### Expected Output
```
=== Phase 11: Slave Hook Injector ===

[1/6] Creating emulator...
      ✓ Emulator created
[2/6] Loading ROM...
      ✓ ROM loaded
[3/6] Resetting emulation...
      ✓ Reset complete
[4/6] Waiting for boot sequence (50 frames)...
      Frame 0/50...
      Frame 10/50...
      Frame 20/50...
      Frame 30/50...
      Frame 40/50...
      ✓ Boot complete
[5/6] Injecting hook at 0x06000596 (52 bytes)...
      ✓ Hook injected (52 bytes)
[6/6] Verifying hook injection...
      ✓ Hook verified (bytecode matches)

[7/7] Running smoke test (10 frames)...
      Initial SDRAM[0x22000100] = 0x00000000
      Final SDRAM[0x22000100] = 0x0000000A
      Frames executed: 10
      ✓ Smoke test PASSED (counter incremented)
```

#### Check 1: No Immediate Crash
- [ ] Emulator runs without segfault
- [ ] Boot sequence completes
- [ ] Hook injection succeeds
- [ ] Verification passes

#### Check 2: Counter Increments
- [ ] SDRAM[0x22000100] changes from boot to test
- [ ] Counter increases (not constant or random)
- [ ] Final value ≥ 10 (test ran all 10 frames)

---

### Phase 11 Step 5b: Extended Smoke Test (120 frames)

**Goal:** Validate stability over 2+ seconds of execution.

#### Procedure
```bash
./phase11_hook_injector build/vr_rebuild.32x --test-frames 120 -v
```

#### Expected Behavior
```
[7/7] Running smoke test (120 frames)...
      Initial SDRAM[0x22000100] = 0x00000000
      Frame 0: Slave PC = 0x06000596
      Frame 10: Slave PC = 0x06000598
      Frame 20: Slave PC = 0x06000596
      ...
      Frame 110: Slave PC = 0x06000598
      Final SDRAM[0x22000100] = 0x00000078
      Frames executed: 120
      ✓ Smoke test PASSED (counter incremented)
```

#### Check 3: Slave PC Cycles in Loop
- [ ] Slave PC oscillates between $06000596 and nearby addresses
- [ ] PC never jumps to far address (indicates crash)
- [ ] PC range < 100 bytes (tight polling loop)

#### Check 4: Counter Increments Steadily
- [ ] Final SDRAM[0x22000100] = 120 (or very close)
- [ ] Counter incremented once per frame (±1 variation acceptable)
- [ ] No skipped frames (counter always increases)

---

### Phase 11 Step 5c: Memory Register Verification

**Goal:** Verify that protocol registers (COMM6, COMM4) are working.

#### Using pdcore CLI Tool (pseudocode)
```bash
# Start emulator with hook
./phase11_hook_injector build/vr_rebuild.32x --no-boot

# In another terminal, use pdcore to read registers:
pdcore-read-register 0x20004028    # COMM4 value
pdcore-read-register 0x2000402C    # COMM6 value

# Expected output:
# COMM4 = 0x0001 (or higher, incremented each frame)
# COMM6 = 0x0000 or 0x0012 (cycling - should see both)
```

#### Check 5: COMM4 Increments
- [ ] COMM4 ($20004028 in SH2 space) > 0
- [ ] COMM4 incremented from previous read
- [ ] COMM4 value close to frame number

#### Check 6: COMM6 Cycles Correctly
- [ ] COMM6 ($2000402C) alternates between 0x0000 and 0x0012
- [ ] More 0x0000 samples than 0x0012 (hook clears it)
- [ ] Never stays stuck at one value (indicates protocol issue)

---

### Phase 11 Step 5d: Visual Validation (Manual)

**Goal:** Confirm game renders and plays normally with hook.

#### Procedure
1. Boot test ROM in PicoDrive with hook injected
2. Watch game title screen (~5 seconds)
3. Observe graphics, audio, controls

#### Check 7: Game Renders Normally
- [ ] No black screen or visual corruption
- [ ] Colors correct (no palette issues)
- [ ] Game title/text visible
- [ ] No flickering or glitches

#### Check 8: Game Audio/Input Works
- [ ] Audio plays from speakers/headphones
- [ ] No static or distortion
- [ ] Controller input accepted (menu navigation works)
- [ ] Game is responsive (not frozen)

---

## Automated Test Script

Create `test_smoke.sh`:

```bash
#!/bin/bash
# Phase 11 Smoke Test Automation

set -e

echo "=== Phase 11 Smoke Test Suite ==="
echo ""

# Configuration
ROM="build/vr_rebuild.32x"
INJECTOR="./phase11_hook_injector"
FRAMES_QUICK=10
FRAMES_EXTENDED=120

# Check 1: Immediate smoke test
echo "Test 1: Quick smoke test (${FRAMES_QUICK} frames)..."
if $INJECTOR $ROM --test-frames $FRAMES_QUICK --verbose > /tmp/smoke1.log 2>&1; then
    if grep -q "PASSED" /tmp/smoke1.log; then
        echo "  ✓ PASSED"
    else
        echo "  ✗ FAILED (counter didn't increment)"
        exit 1
    fi
else
    echo "  ✗ FAILED (injector error)"
    cat /tmp/smoke1.log
    exit 1
fi

# Check 2: Extended smoke test
echo ""
echo "Test 2: Extended smoke test (${FRAMES_EXTENDED} frames)..."
if $INJECTOR $ROM --test-frames $FRAMES_EXTENDED --verbose > /tmp/smoke2.log 2>&1; then
    # Extract final counter value
    FINAL_COUNT=$(grep "Final SDRAM" /tmp/smoke2.log | awk '{print $NF}')
    # Convert hex to decimal
    FINAL_DEC=$((FINAL_COUNT))

    if [ $FINAL_DEC -ge $((FRAMES_EXTENDED - 5)) ]; then
        echo "  ✓ PASSED (counter = $FINAL_COUNT, expected ≈ $(printf '0x%08X' $FRAMES_EXTENDED))"
    else
        echo "  ✗ FAILED (counter = $FINAL_COUNT, expected ≈ $(printf '0x%08X' $FRAMES_EXTENDED))"
        exit 1
    fi
else
    echo "  ✗ FAILED (injector error)"
    cat /tmp/smoke2.log
    exit 1
fi

# Check 3: Hook bytecode verification
echo ""
echo "Test 3: Hook bytecode verification..."
if grep -q "Hook verified" /tmp/smoke1.log; then
    echo "  ✓ PASSED (bytecode matches expected)"
else
    echo "  ✗ FAILED (bytecode mismatch)"
    exit 1
fi

echo ""
echo "=== ALL SMOKE TESTS PASSED ==="
echo ""
echo "Next: Run 60-second extended validation (Phase 11 Step 6)"
echo "Then: Document results in PHASE11_RESULTS.md"
```

Run with:
```bash
chmod +x test_smoke.sh
./test_smoke.sh
```

---

## Failure Diagnosis

### Symptom: Injector fails immediately
**Probable Causes:**
- ROM file not found
- pdcore library not built
- Invalid hook address

**Action:**
```bash
# Verify ROM exists
ls -lh build/vr_rebuild.32x

# Verify pdcore built
ls -lh pdcore/build/libpdcore.so

# Check hook address is valid
# Should be $06000596 (or within SDRAM $06000000-$0603FFFF)
```

### Symptom: Hook injection succeeds but counter doesn't increment
**Probable Causes:**
- Hook code not executing (wrong address)
- expansion_frame_counter not incrementing COMM4
- SDRAM counter at wrong address

**Action:**
```bash
# Check Slave PC reaches hook
./phase11_hook_injector build/vr_rebuild.32x --test-frames 20 -v
# Look for "Slave PC = 0x06000596" in output

# Verify hook bytecode with debugger
# Read $06000596 in pdcore and compare with expected bytes
```

### Symptom: Game crashes after hook injection
**Probable Causes:**
- Hook corrupts Slave registers
- Hook injection point in middle of instruction
- Hook overwrite something critical

**Action:**
```bash
# Try with --no-boot to skip boot sequence
./phase11_hook_injector build/vr_rebuild.32x --no-boot

# If still crashes: injection point wrong
# Fall back to expected address $06000596
```

---

## Pass/Fail Criteria

### PASS (All 8 checks ✓)
```
✓ Check 1: No Immediate Crash
✓ Check 2: Counter Increments
✓ Check 3: Slave PC Cycles
✓ Check 4: Counter Increments Steadily
✓ Check 5: COMM4 Increments
✓ Check 6: COMM6 Cycles
✓ Check 7: Game Renders
✓ Check 8: Audio/Input Works
```

Result: **PASS** → Proceed to Phase 11 Step 6 (extended validation)

### FAIL (Any check ✗)
```
✗ Check 2: Counter doesn't increment
  → Hook not executing or address wrong

✗ Check 3: Slave PC doesn't cycle
  → Slave crashed or hung

✗ Check 4: Counter inconsistent
  → Race condition or timing issue
```

Result: **FAIL** → Fix issue and retest before proceeding

---

## Metrics to Record

For the Phase 11 Results document:

```markdown
## Smoke Test Results

### Test 1: Quick Validation (10 frames)
- Duration: 0.5 seconds
- Initial SDRAM[0x22000100]: 0x00000000
- Final SDRAM[0x22000100]: 0x0000000A
- Status: ✓ PASS

### Test 2: Extended Validation (120 frames)
- Duration: 2.4 seconds
- Initial SDRAM[0x22000100]: 0x00000000
- Final SDRAM[0x22000100]: 0x00000078
- Counter increment rate: 1.0 per frame
- Status: ✓ PASS

### Test 3: Visual Validation
- Game boots: ✓
- Graphics render: ✓
- Audio plays: ✓
- Input responsive: ✓

### Overall: ✓ SMOKE TEST PASSED
```

---

## References

- [PHASE11_HOOK_BYTECODE.md](PHASE11_HOOK_BYTECODE.md) - Hook bytecode reference
- [PHASE11_SLAVE_HOOK_ROADMAP.md](PHASE11_SLAVE_HOOK_ROADMAP.md) - Full roadmap
- [tools/phase11_hook_injector.c](tools/phase11_hook_injector.c) - Injector source

