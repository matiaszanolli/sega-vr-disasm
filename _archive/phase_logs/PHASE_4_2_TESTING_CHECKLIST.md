# Phase 4.2 Testing Checklist - Quick Reference

## Test ROMs Created

| ROM File | Split Point | Slave Polygons | Master Polygons | Purpose |
|----------|-------------|-----------------|-----------------|---------|
| vrd_phase4_split_200.32x | 200 | 200-799 (600) | 0-199 (200) | Extreme Slave load |
| vrd_phase4_split_250.32x | 250 | 250-799 (550) | 0-249 (250) | Heavy Slave work |
| vrd_phase4_split_300.32x | 300 | 300-799 (500) | 0-299 (300) | Balanced work |
| vrd_phase4_split_350.32x | 350 | 350-799 (450) | 0-349 (350) | Light Slave work |
| vrd_phase4_split_450.32x | 450 | 450-799 (350) | 0-449 (450) | Control (less Slave) |

**Baseline for comparison**: `vrd_phase4_linked.32x` (split at 400)

---

## Quick Testing Steps

### For Each ROM:

1. **Load ROM**: `blastem build/vrd_phase4_split_XXX.32x`

2. **Drive to pit stop** (consistent test point)

3. **Record observations**:
   - **Crew movement smoothness**: 1-10 scale (1=very jerky, 10=smooth)
   - **Particle effects quality**: 1-10 scale (1=barely visible, 10=detailed)
   - **Overall responsiveness**: Subjective feel
   - **Visual artifacts**: None / glitches / corruption

4. **Estimate FPS**:
   - Count frames visually (hardest way but works)
   - Or note subjective speed vs baseline
   - Rough estimate: 24 FPS baseline, higher = better

---

## Testing Order (Suggested)

### Phase 1: Quick Screen Tests (5 minutes)
1. Test **split_450.32x** (should be similar to baseline 400)
2. Test **split_350.32x** (should be noticeable improvement)
3. Test **split_300.32x** (should be even better)

### Phase 2: Detailed Comparison (10 minutes)
4. Test **split_250.32x** (potential sweet spot?)
5. Test **split_200.32x** (extreme test - may be too much)

### Phase 3: Find Optimal (5 minutes)
6. Re-test the best 2 candidates to confirm winner

---

## Results Recording Template

```
TEST RESULTS - PHASE 4.2 LOAD BALANCING
========================================

Test Date: ___________
Platform: BlastEm / Other: _________

SPLIT 450 (Control - similar to baseline):
  Crew movement smoothness:      ___/10
  Particle effects quality:       ___/10
  Overall feel:                   Baseline / Better / Worse
  Artifacts:                      None / [describe]
  Notes: ___________________________________________________

SPLIT 350 (Light Slave work):
  Crew movement smoothness:      ___/10
  Particle effects quality:       ___/10
  Overall feel:                   vs 450: Better / Same / Worse
  Artifacts:                      None / [describe]
  Notes: ___________________________________________________

SPLIT 300 (Balanced work):
  Crew movement smoothness:      ___/10
  Particle effects quality:       ___/10
  Overall feel:                   Best so far? Yes / No
  Artifacts:                      None / [describe]
  Notes: ___________________________________________________

SPLIT 250 (Heavy Slave work):
  Crew movement smoothness:      ___/10
  Particle effects quality:       ___/10
  Overall feel:                   Peak? / Declining?
  Artifacts:                      None / [describe]
  Notes: ___________________________________________________

SPLIT 200 (Extreme Slave load):
  Crew movement smoothness:      ___/10
  Particle effects quality:       ___/10
  Overall feel:                   Stuttering? / Still good?
  Artifacts:                      None / [describe]
  Notes: ___________________________________________________

CONCLUSION:
===========
Optimal split point: _____ (split at _____ for _____ polygons to Slave)
Performance gain vs baseline: ___% estimated FPS improvement
Recommended for production: Yes / No
```

---

## Quick Comparison Matrix

While testing, fill in this to track comparative performance:

```
Split  | Crew Move | Particles | Overall | Artifacts | Winner?
-------|-----------|-----------|---------|-----------|--------
450    |     /10   |     /10   | Comment | None/[?]  |   ✓✓
350    |     /10   |     /10   | Comment | None/[?]  |
300    |     /10   |     /10   | Comment | None/[?]  |
250    |     /10   |     /10   | Comment | None/[?]  |
200    |     /10   |     /10   | Comment | None/[?]  |
```

---

## Expected Results

Based on Phase 4.1 results showing Slave at 30-40% utilization:

**Conservative prediction**:
- Splits 350-450: Similar performance (all balanced)
- Split 300: Slight improvement (+3-5% FPS)
- Split 250: Moderate improvement (+8-12% FPS)
- Split 200: Possible bottleneck or similar to 250

**Optimistic prediction**:
- Split 300: Sweet spot found
- Split 250: Peak performance
- Split 200: Diminishing returns

**Likely outcome**:
- **Optimal split: 275-325 range**
- **Performance gain: +20-25% total** (vs Phase 3.2 baseline of 24 FPS)

---

## What to Look For

### Good Signs
✅ Crew movement gets smoother as you test lower splits (more Slave work)
✅ Particle effects get more detailed
✅ FPS improves measurably
✅ No crashes or hangs

### Warning Signs
⚠️ Performance suddenly drops at a split point (possible bottleneck)
⚠️ Visual glitches appear (sync buffer issues?)
⚠️ ROM becomes unstable (address issues?)

### Red Flags
❌ All splits perform identically (sync overhead dominates, not CPU work)
❌ Performance degrades with lower splits (Master starved of work)
❌ Crashes on specific splits (linker bug?)

---

## If You Find Issues

### ROM won't boot / crashes:
1. Make sure Phase 3.2 baseline ROM still works
2. Try split_450.32x (closest to baseline)
3. If 450 fails but baseline works, report it - indicates variant issue

### All ROMs identical performance:
1. May indicate sync overhead is the bottleneck
2. Can skip to Phase 4.3 (cycle profiling)

### Split 200 is best but seems unstable:
1. Try split 210-220 to find stable limit
2. May indicate Slave being over-utilized
3. CPU contention or cache thrashing possible

---

## Next Steps After Testing

### If Clear Winner Found (e.g., Split 300):
1. Update `disasm/sh2_slave_consolidated.asm` with optimal split
2. Rebuild final Phase 4.2 ROM
3. Proceed to Phase 4.3 (profiling)

### If Results Unclear:
1. Try intermediate split points (e.g., 275, 325 if 300 vs 350 unclear)
2. Use GDB to measure actual CPU cycles if possible
3. May need deeper analysis

### If Performance Flat:
1. Skip load balancing, proceed to Phase 4.3 profiling
2. Deeper optimization needed (frame buffer access, cache patterns)

---

## Estimated Time
- **Quick test (2-3 ROMs)**: 10 minutes
- **Full test (5 ROMs)**: 20 minutes
- **Optimal point confirmation**: 25 minutes total

---

Ready to test! Start with **vrd_phase4_split_350.32x** and compare it to the baseline **vrd_phase4_linked.32x** 🚀
