# Phase 13: Extended Validation & Stress Testing

**Status:** Planning
**Date:** 2026-01-22
**Objective:** Comprehensive validation of Phase 11+12 Master→Slave synchronization mechanism

---

## Testing Strategy

### Goals

1. **Stability Validation**
   - Run ROM continuously for 60+ seconds
   - Detect any crashes, glitches, or anomalies
   - Verify no memory corruption

2. **Performance Analysis**
   - Measure frame rate consistency
   - Detect FPS drops or stutters
   - Profile handler execution overhead

3. **Protocol Integrity**
   - Monitor COMM4 and COMM6 registers
   - Verify counter increments monotonically
   - Detect missed signals or double-execution

4. **Visual Regression**
   - Confirm graphics render correctly
   - Check for texture corruption
   - Verify audio plays without artifacts

---

## Test Phases

### Phase 13.1: Quick Sanity Check (5 minutes)

**Objective:** Verify no immediate failures
**Method:** Boot ROM, observe for 5 frames, check for crashes
**Success Criteria:** ROM boots, game renders, no visible corruption

### Phase 13.2: Medium-Duration Test (10 minutes)

**Objective:** Test sustained operation
**Method:** Run for 10 minutes (~36,000 frames at 60 FPS)
**Monitoring:**
- COMM4 counter: Should increment monotonically
- COMM6: Should alternate between 0x0012 and 0x0000
- Frame rate: Should maintain ~60 FPS

**Success Criteria:**
- No crashes
- Counter monotonic increase
- Consistent frame rate

### Phase 13.3: Extended Stress Test (60+ seconds)

**Objective:** Long-running stability validation
**Method:** Continuous ROM execution for 60+ seconds (~3600+ frames)
**Monitoring (every 30 frames):**
- COMM4 value (expected: previous + 30)
- COMM6 value (expected: 0x0000)
- Frame count consistency
- No anomalies

**Success Criteria:**
- All 3600+ frames execute without crash
- COMM4 increments by ~1 per frame (some frames may be buffered)
- No register corruption
- Frame rate stable (59-61 FPS acceptable)

### Phase 13.4: Memory Corruption Check

**Objective:** Verify handler doesn't corrupt memory
**Method:**
- Read specific memory locations before/after stress test
- Compare checksums
- Verify SDRAM pattern intact

**Success Criteria:**
- No memory corruption detected
- All checksums match expected values

---

## Monitoring Points

### COMM Registers (0x20004000-0x2000402F)

| Register | Address | Role | Expected |
|----------|---------|------|----------|
| COMM0 | 0x20004000 | Status | Varies |
| COMM2 | 0x20004004 | Debug | Varies |
| COMM4 | 0x20004028 | Slave response | 0x0000 → incrementing |
| COMM6 | 0x2000402C | Master signal | 0x0012 → 0x0000 cycle |

**Monitoring Strategy:**
- Read COMM4 every 30 frames
- Record value and timestamp
- Verify monotonic increase
- Detect any anomalies (jumps, resets, missing increments)

### Frame Timing

| Metric | Expected | Acceptable Range |
|--------|----------|------------------|
| Frame rate | 60 FPS | 59-61 FPS |
| Frame duration | 16.67 ms | 16-17 ms |
| Jitter | 0 ms | <0.5 ms |

---

## Test Execution Plan

### Step 1: Prepare Test Environment

```bash
# Ensure complete ROM exists
ls -lh build/vr_rebuild_complete.32x

# Create test log directory
mkdir -p test_results/phase13_$(date +%Y%m%d_%H%M%S)

# Document system info
uname -a > test_results/system_info.txt
```

### Step 2: Boot and Monitor (Real-Time)

**Using PicoDrive:**
```bash
# Boot the complete ROM
picodrive build/vr_rebuild_complete.32x

# Manually observe:
# - Game title screen renders
# - Graphics are clear and correct
# - No texture glitches
# - Audio plays normally
# - Input is responsive (menu navigation)

# Run for minimum 60 seconds, observe continuously
```

**What to watch for:**
- ✓ Title screen appears (frame 0-60)
- ✓ Game boots to playable state
- ✓ Graphics render smoothly
- ✓ Audio plays without skips
- ✓ No freezes or lag spikes
- ✓ Controllers respond to input

### Step 3: Sampling (Every 30 seconds)

During test run, periodically sample COMM registers:

**At 30-second mark (≈1800 frames):**
```
Expected COMM4: ~1800 (or lower if buffered)
Expected COMM6: 0x0000 (cleared)
Frame status: Running smoothly
Audio: Present, no skips
Graphics: Clear, no corruption
```

**At 60-second mark (≈3600 frames):**
```
Expected COMM4: ~3600
Expected COMM6: 0x0000
Frame status: Stable
Cumulative observations: No anomalies
```

### Step 4: Post-Test Analysis

After 60+ second run:
```bash
# Record observations
# - Total frames executed
# - Any crashes or glitches observed
# - COMM register final values
# - Visual/audio quality assessment
# - Overall stability rating
```

---

## Success Criteria (Phase 13)

Phase 13 is **COMPLETE** when:

- ✅ ROM boots successfully (no crash on startup)
- ✅ Runs continuously for 60+ seconds without hanging
- ✅ Graphics render correctly throughout test
- ✅ Audio plays without artifacts
- ✅ Input remains responsive
- ✅ COMM4 counter increments consistently (~1 per frame)
- ✅ COMM6 clears properly between signals
- ✅ No memory corruption detected
- ✅ Frame rate stable (59-61 FPS)
- ✅ No visible glitches or jitter

---

## Potential Issues to Watch For

### Issue: Frame Skipping
- **Sign:** COMM4 jumps by >1 in a single frame
- **Cause:** Handler not executing fast enough
- **Mitigation:** Check for stack overflow or register conflicts

### Issue: Double-Execution
- **Sign:** COMM4 increments twice in one frame
- **Cause:** Hook called twice or signal not cleared
- **Mitigation:** Verify hook clears COMM6 correctly

### Issue: Graphical Corruption
- **Sign:** Texture glitches, color shifts, screen tears
- **Cause:** Handler corrupting graphics registers
- **Mitigation:** Handler only uses R0/R1, should be safe

### Issue: Audio Skips
- **Sign:** Audio cuts out or stutters
- **Cause:** Handler overhead delaying audio processing
- **Mitigation:** Handler is <10 cycles, should have no impact

### Issue: Memory Leak
- **Sign:** Performance degrades over time
- **Cause:** Handler or hook not cleaning up properly
- **Mitigation:** Monitor memory patterns throughout test

---

## Test Equipment

### Required
- PicoDrive emulator (with pdcore integration)
- Complete ROM (build/vr_rebuild_complete.32x)
- System with audio/video output
- Way to record observations

### Optional
- GDB debugger (inspect registers during test)
- Screen recording software (capture graphical anomalies)
- Audio capture (verify audio quality)
- Performance monitoring tools (measure FPS)

---

## Timeline

| Phase | Task | Duration |
|-------|------|----------|
| 13.1 | Quick sanity check | 5 min |
| 13.2 | Medium test (10 min run) | 15 min |
| 13.3 | Extended stress (60+ sec run) | 65+ min |
| 13.4 | Analysis & documentation | 30 min |
| **Total** | | **~2 hours** |

---

## Documentation

### Test Report Format

**File:** `test_results/PHASE13_TEST_REPORT_<TIMESTAMP>.md`

```markdown
# Phase 13 Extended Validation - Test Report
Date: [DATE]
Test Duration: [MINUTES]
Total Frames: [COUNT]

## Test Results
- Boot test: PASS/FAIL
- 60-second run: PASS/FAIL
- COMM4 integrity: PASS/FAIL
- Graphics quality: PASS/FAIL
- Audio quality: PASS/FAIL
- Performance: PASS/FAIL

## Observations
[Detailed observations from test]

## Anomalies
[Any issues encountered]

## Conclusion
[Overall assessment of stability]
```

---

## Pass/Fail Criteria

### PASS (Stable)
- ✅ ROM boots and runs 60+ seconds without crash
- ✅ COMM registers behave as expected
- ✅ Graphics and audio remain clear throughout
- ✅ No anomalies or degradation observed
- ✅ Frame rate consistent (59-61 FPS)

### FAIL (Unstable)
- ❌ ROM crashes within 60 seconds
- ❌ COMM registers show anomalies (jumps, resets)
- ❌ Graphics corruption or visual glitches
- ❌ Audio skips or stutters
- ❌ Frame rate drops significantly (<55 FPS)
- ❌ Memory corruption detected

---

## Next Steps (If Issues Found)

1. **Identify root cause**
   - Use GDB to inspect handler execution
   - Check register values during fault
   - Profile timing of handler calls

2. **Fix and retest**
   - Modify handler/hook if needed
   - Rebuild ROM
   - Rerun Phase 13 validation

3. **Document findings**
   - Create bug report
   - Note root cause and fix
   - Update Phase 13 results

---

## Expected Outcome

Based on Phase 11+12 validation, Phase 13 should show:
- ✅ Stable operation for 60+ seconds
- ✅ Consistent COMM4 increments
- ✅ No crashes or anomalies
- ✅ Frame-perfect synchronization maintained
- ✅ Ready for Phase 14 (Documentation & Release)

