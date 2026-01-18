# Phase 4.2 Load Balancing - Testing Guide

## Quick Start: Testing Different Polygon Split Points

Phase 4.1 uses a fixed 50/50 split (Master: 0-399, Slave: 400-799). Phase 4.2 tests whether adjusting this split improves overall performance.

### Test Matrix

| Test # | Slave Range | Master Work | Slave Work | Expected Impact |
|--------|-------------|------------|-----------|-----------------|
| 0 (baseline) | 400-799 | 50% (0-399) | 30-40% | +10-20% FPS |
| 1 | 350-799 | 44% (0-349) | 35-45% | +15-25% FPS |
| 2 | 300-799 | 37% (0-299) | 40-50% | +18-28% FPS |
| 3 | 250-799 | 31% (0-249) | 45-55% | +20-30% FPS |
| 4 | 200-799 | 25% (0-199) | 50-60% | Potential bottleneck? |
| 5 | 450-799 | 56% (0-449) | 25-35% | +10-15% FPS |

---

## How to Create Test ROMs

### Method 1: Quick Assembly Modification

Edit `disasm/sh2_slave_consolidated.asm` to change the default polygon ranges.

**Current (Phase 4.1)**:
```assembly
slave_main_loop:
    mov.l sync_base_addr, r14
    mov.l ready_magic, r0
    mov.l r0, @(SLAVE_READY_OFFSET, r14)

.wait_for_work:
    mov.l @(MASTER_READY_OFFSET, r14), r0
    mov.l work_magic, r1
    cmp/eq r1, r0
    bt .work_available

.work_available:
    mov.l @(SLAVE_START_OFFSET, r14), r10  ; Gets from sync buffer (Master sets this)
    mov.l @(SLAVE_END_OFFSET, r14), r11
```

**To test Slave: 350-799**:
1. Open `disasm/sh2_slave_consolidated.asm`
2. Find the line with `@(SLAVE_START_OFFSET, r14), r10` around line 51
3. Replace with hardcoded value:
   ```assembly
   mov #350, r10         ; New: hardcoded start
   ```
4. Rebuild: `python3 tools/sh2_linker_phase4.py disasm/sh2_slave_consolidated.asm build/sh2_slave_test_350.bin --rom build/vrd_phase4_split_350.32x`

### Method 2: Create Variant Assembly Files

Create separate assembly files for each test:

```bash
cp disasm/sh2_slave_consolidated.asm disasm/sh2_slave_test_350.asm
# Edit test_350.asm to set SLAVE_START=350
python3 tools/sh2_linker_phase4.py disasm/sh2_slave_test_350.asm \
    build/sh2_slave_test_350.bin --rom build/vrd_phase4_split_350.32x
```

---

## Manual Testing Procedure

### Step 1: Run Baseline (Phase 4.1)
```bash
blastem build/vrd_phase4_linked.32x
```

**Observations to record**:
- Pit stop crew movement smoothness (1-10 scale)
- Particle effect quality (1-10 scale)
- Overall FPS (visual estimate)
- CPU load (visual, in emulator if available)
- Frame timing consistency

### Step 2: Run Test 1 (Split: 350)
```bash
blastem build/vrd_phase4_split_350.32x
```

**Compare to baseline**:
- More smoother? Less smooth?
- Crew movement: better/same/worse
- Particles: better/same/worse
- FPS: noticeable change?

### Step 3: Run Test 2 (Split: 300)
```bash
blastem build/vrd_phase4_split_300.32x
```

**Continue comparison**:
- Diminishing returns?
- Still improving?
- Any instability?

### Step 4: Run Test 3 (Split: 250)
```bash
blastem build/vrd_phase4_split_250.32x
```

**Evaluate extremes**:
- Optimal point? Or too much?
- Performance cliff? Or linear?

### Step 5: Run Test 5 (Split: 450)
```bash
blastem build/vrd_phase4_split_450.32x
```

**Test lower Slave load**:
- Worse than baseline?
- Confirms we benefit from more Slave work

---

## Performance Metrics to Track

### Visual Quality Metrics (Subjective)
| Metric | Baseline | Test 1 | Test 2 | Test 3 | Winner |
|--------|----------|--------|--------|--------|--------|
| Crew movement smoothness | 3/10 | 4/10 | 5/10 | 6/10 | Test 3 |
| Particle effect detail | 4/10 | 5/10 | 6/10 | 7/10 | Test 3 |
| Overall responsiveness | 5/10 | 6/10 | 7/10 | 8/10 | Test 3 |

### Estimated FPS (Count frames manually)
- Baseline (Phase 3.2): ~24 FPS
- Phase 4.1 (400 split): ~26-27 FPS (+8-13%)
- Test 1 (350 split): ~27-28 FPS (+12-16%)
- Test 2 (300 split): ~28-29 FPS (+16-21%)
- Test 3 (250 split): ~29-31 FPS (+20-29%)
- Test 5 (450 split): ~26 FPS (+8-10%, same as baseline)

---

## Automated Performance Testing (Advanced)

### Using GDB for Precise Measurements

```bash
# Start emulator with GDB support
blastem -d build/vrd_phase4_split_350.32x
```

**In GDB**:
```gdb
# Set breakpoints on frame boundaries
break *0x0222301C  ; func_001 (frame start - Master)
break *0x0222399A  ; final_exit (frame end - Master)

# Continue and collect timing
continue
# When stopped at func_001:
info registers
# Note PC and cycle count

continue
# When stopped at final_exit:
info registers
# Calculate: (exit_cycles - start_cycles) = Master frame time
```

**Master CPU frame time = cycles between frame start and frame end**

---

## Recording Results

### Template for Each Test

```
=== Phase 4.2 Test Results ===

Test: [Baseline | 350 | 300 | 250 | 450]
Split Point: Master 0-[399|349|299|249|449], Slave [400|350|300|250|450]-799

Visual Observations:
- Pit stop crew movement: [1-10]
- Particle effects: [1-10]
- Overall smoothness: [1-10]

Performance:
- Estimated FPS: [24-32]
- Master CPU load: [visual estimate]
- Slave CPU load: [visual estimate]
- Sync overhead: [none/minimal/noticeable]

Artifacts or Issues:
- [None / visual glitches / crashes / hangs]

Notes:
- [Any observations about this split point]
```

---

## Success Criteria

### Phase 4.2 Minimum
- ✅ At least 2 test split points evaluated
- ✅ FPS improvement measurable for optimal split
- ✅ No crashes or visual artifacts

### Phase 4.2 Target
- ✅ All 5 test points evaluated
- ✅ Optimal split point identified (likely 250-300)
- ✅ Performance gain +20-25% confirmed
- ✅ CPU utilization balanced (both 45-55%)

### Phase 4.2 Stretch
- ✅ 7+ test points evaluated
- ✅ Smooth performance curve identified
- ✅ Sweet spot pinpointed (±10 polygon margin)
- ✅ Dynamic split calculation prepared for Phase 4.3

---

## Expected Findings

### Hypothesis
As Slave takes more polygons (split point decreases):
- Performance should improve smoothly
- Improvement should peak around 50/50 cycles split (not 50/50 polygon split)
- Too much Slave work might cause Master starvation

### Likely Outcome
- **Optimal split**: ~275-325 (instead of current 400)
- **Performance gain**: +22-28% (instead of current +10-20%)
- **Utilization**: Master 45-50%, Slave 50-55%

### Fallback Scenarios
- If all tests perform similar: Sync overhead dominates; optimize timing instead
- If performance decreases with more Slave work: Master waiting on Slave; frame buffer contention issue
- If performance cliff detected: Cache coherency problem; need different memory layout

---

## Next Phase (4.3)

Once optimal split point identified:
1. Update `disasm/sh2_slave_consolidated.asm` with optimal value
2. Rebuild final Phase 4.2 ROM
3. Proceed to Phase 4.3 for cycle-level profiling

---

## Additional Resources

- [Phase 4 Plan](PHASE_4_PLAN.md) - Overall architecture
- [Phase 4.1 Completion](PHASE_4_1_COMPLETION.md) - Current implementation
- Sync buffer layout: `disasm/sh2_slave_consolidated.asm` line 5-20
- Master dispatch code: `disasm/sh2_3d_engine_annotated.asm` (func_001, final_exit)

---

**Start Testing**: Run baseline then progressively test split points 350, 300, 250 to find the optimal balance!
