# Phase 4.2: Load Balancing & CPU Utilization Optimization

**Status**: Planning
**Date**: January 10, 2026
**Baseline**: Phase 4.1 ROM with 50/50 polygon split
**Goal**: Optimize CPU utilization for +20-30% total performance gain

---

## Executive Summary

Phase 4.1 validation shows the Slave is working at ~30-40% utilization with visible performance improvements (pit stop crew movement, particle effects). Phase 4.2 optimizes the **polygon distribution** between Master and Slave CPUs to achieve balanced utilization.

### Key Finding
Current split (400-399 / 400-799) may not be optimal:
- **If Master > 50%**: Slave can take more polygons
- **If Slave > 50%**: Master needs more polygons
- **Goal**: Both CPUs at ~50-55% utilization for balanced pipeline

---

## Strategy: Dynamic Polygon Split

### Current Architecture (Phase 4.1)
```
Master: Polygons 0-399
Slave:  Polygons 400-799
Split:  Fixed at 400
```

### Proposed Architecture (Phase 4.2)
```
Master: Polygons 0 to N
Slave:  Polygons N+1 to 799
Split:  N = dynamic based on frame profiling
```

### Key Insight
Polygon complexity varies by type:
- Simple triangles: 50-100 cycles
- Complex quads: 200-400 cycles
- Textured polygons: 500+ cycles

A 50/50 **count split** may not be 50/50 **work split**. We need to balance **cycles**, not just polygon count.

---

## Implementation Steps

### Step 1: Measure Current Performance

**Tool**: GDB with breakpoints on frame completion

**Metrics to capture** (per frame):
1. Master CPU cycles from `func_001` entry to `final_exit`
2. Slave CPU cycles from work dispatch to `slave_done` signal
3. Sync overhead (dispatch + wait time)
4. Frame buffer write latency

**Formula**:
```
Master utilization = (master_cycles / frame_time) * 100
Slave utilization = (slave_cycles / frame_time) * 100
Frame_time = 20,000-25,000 cycles (23 MHz clock at 60 FPS)
```

**Expected values** (Phase 4.1):
- Master: 60-70% (reduced from 91% at baseline)
- Slave: 30-40% (up from 0.03%)
- Sync overhead: <5%

### Step 2: Analyze Polygon Complexity

**Approach**: Extract polygon distribution from display list

**Data needed** (per frame):
- Polygon count per type (triangles, quads, textured)
- Cycles per polygon type (from profiling)
- Cumulative work distribution

**Pseudo-code**:
```assembly
; In Master or Slave main loop
mov.l   @(POLYGON_COUNT, r14), r0    ; Total polygons
mov.l   @(POLYGON_TYPE_ADDR, r14), r1 ; Polygon type array

; Calculate work distribution
mov #0, r2                             ; r2 = cumulative_cycles
mov #0, r3                             ; r3 = split_point

.analyze_loop:
    mov.b   @r1+, r4                  ; r4 = polygon type
    cmp/eq  r3, r0                    ; At end?
    bt      .analysis_done

    ; Add cycles for this polygon based on type
    cmp/eq  #TRIANGLE, r4
    bt      .add_triangle

    cmp/eq  #QUAD, r4
    bt      .add_quad

    bra     .next_poly

.add_triangle:
    add     #80, r2                   ; ~80 cycles per triangle
    bra     .next_poly

.add_quad:
    add     #200, r2                  ; ~200 cycles per quad

.next_poly:
    cmp/ge  #HALF_FRAME, r2           ; Half of total frame time?
    bf      .analyze_loop

    mov.l   r3, @(OPTIMAL_SPLIT, r14) ; Store split point

.analysis_done:
    nop
```

### Step 3: Dynamic Split Calculation

**Input**: Current frame's polygon distribution
**Output**: Optimal split point for next frame

**Algorithm**:
```python
def calculate_optimal_split(polygons, target_utilization=0.5):
    """
    Find polygon count where cumulative work crosses target utilization

    Args:
        polygons: List of (type, complexity_cycles) tuples
        target_utilization: Target split (0.5 = 50/50)

    Returns:
        optimal_split_point (0-799)
    """
    total_cycles = sum(cycles for _, cycles in polygons)
    target_cycles = total_cycles * target_utilization

    cumulative = 0
    for i, (_, cycles) in enumerate(polygons):
        cumulative += cycles
        if cumulative >= target_cycles:
            return i

    return len(polygons) - 1  # Fallback
```

### Step 4: Update Slave Dispatch

**Current** (Phase 4.1):
```assembly
slave_main_loop:
    mov.l   @(SLAVE_START_OFFSET, r14), r10  ; Always 400
    mov.l   @(SLAVE_END_OFFSET, r14), r11    ; Always 799
```

**New** (Phase 4.2):
```assembly
slave_main_loop:
    ; Fetch potentially different start/end
    mov.l   @(SLAVE_START_OFFSET, r14), r10  ; Master provides
    mov.l   @(SLAVE_END_OFFSET, r14), r11    ; Master provides
    ; Rest of loop unchanged - already uses r10/r11
```

**Sync buffer** (no changes needed):
```
+0x14: SLAVE_START (previously fixed 400, now dynamic)
+0x18: SLAVE_END   (previously fixed 799, now dynamic)
```

### Step 5: Implement in Master

**File**: `disasm/sh2_3d_engine_annotated.asm`
**Location**: `func_001` entry (frame initialization)

**Code to add**:
```assembly
; After displaying previous frame, calculate next frame's polygon split
calc_next_frame_split:
    sts.l   pr, @-r15

    ; TODO: Implement optimal split calculation here
    ; For now: hardcoded test splits
    mov     #350, r0    ; Try splitting at 350 instead of 400
    mov.l   r0, @(SLAVE_START_OFFSET, r14)
    mov     #799, r1
    mov.l   r1, @(SLAVE_END_OFFSET, r14)

    lds.l   @r15+, pr
    rts
    nop
```

---

## Testing Strategy

### Test 1: Fixed Split Points
Test several fixed splits to find optimal balance:

| Split Point | Master Work | Slave Work | Expected Gain |
|-------------|------------|-----------|---------------|
| 400 (current) | ~50% | ~30-40% | +20-25% |
| 350 | ~45% | ~35-45% | +25-30% |
| 300 | ~40% | ~40-50% | +28-32% |
| 250 | ~35% | ~45-55% | +25-28% |

### Test 2: Dynamic Split (Polygon Type Aware)
Implement cycle-based split:
- Scan display list once
- Calculate polygon complexities
- Adjust split dynamically per frame

### Test 3: Performance Comparison
Measure FPS improvement for each approach:

```
Phase 3.2 baseline:     24 FPS (Master 91%, Slave 0%)
Phase 4.1 (400/400):    ~26-27 FPS (estimated +10-15%)
Phase 4.2 (opt split):  ~29-32 FPS (target +20-30%)
```

---

## Sync Buffer Extensions

### Current Layout (Phase 4.1)
```
+0x00: MASTER_READY
+0x04: SLAVE_READY
+0x08: MASTER_DONE
+0x0C: SLAVE_DONE
+0x10: POLYGON_COUNT
+0x14: SLAVE_START    (currently hardcoded 400)
+0x18: SLAVE_END      (currently hardcoded 799)
+0x20: CONTEXT_PTR
+0x24: DISPLAY_LIST
+0x28: FRAME_BUFFER
+0x40: SLAVE_FRAME_COUNTER
```

### Proposed Extensions (for future phases)
```
+0x44: OPTIMAL_SPLIT      ; Calculated split for next frame
+0x48: POLYGON_CYCLES     ; Cycles per polygon (array pointer)
+0x4C: FRAME_CYCLES_MASTER
+0x50: FRAME_CYCLES_SLAVE
+0x54: LAST_UTILIZATION_M  ; For adaptive balancing
+0x58: LAST_UTILIZATION_S
```

---

## Risk Mitigation

### Risk 1: Unstable Split Point
**Problem**: Rapid split changes cause performance jitter
**Mitigation**:
- Use moving average of last 3 frames
- Only change if improvement >2%

### Risk 2: Overhead of Calculation
**Problem**: Calculating optimal split takes cycles
**Mitigation**:
- Simple linear scan, not complex algorithm
- ~100-200 cycles acceptable (<1% overhead)

### Risk 3: Incorrect Cycle Estimates
**Problem**: Polygon complexity varies based on coordinates
**Mitigation**:
- Start with fixed splits (test 1)
- Refine estimates based on actual measurements

---

## Success Criteria

### Minimum (Phase 4.2 Complete)
- [x] Phase 4.1 ROM creates valid Phase 4.2 ROM
- [ ] At least one optimized split point tested
- [ ] Performance improvement measurable (>5% FPS gain)
- [ ] No crashes or visual artifacts

### Target (Phase 4.2 Successful)
- [ ] Multiple split points tested
- [ ] Optimal split point identified
- [ ] Performance gain +20-25% total
- [ ] Load more balanced (both CPUs 45-55%)

### Stretch (Phase 4.2 Optimized)
- [ ] Dynamic split calculation implemented
- [ ] Adaptive balancing working
- [ ] Performance gain +30%+
- [ ] Perfect utilization balance

---

## Timeline

| Task | Duration | Status |
|------|----------|--------|
| Measure Phase 4.1 performance | 1 day | Pending |
| Test fixed split points (350, 300, 250) | 1 day | Pending |
| Analyze polygon complexity | 1 day | Pending |
| Implement dynamic split | 1-2 days | Pending |
| Validate and optimize | 1 day | Pending |
| **Total Phase 4.2** | **5-6 days** | - |

---

## Next Actions

### Immediate (Today)
1. Create series of test ROMs with different split points:
   - `vrd_phase4_split_350.32x` (Slave: 350-799)
   - `vrd_phase4_split_300.32x` (Slave: 300-799)
   - `vrd_phase4_split_250.32x` (Slave: 250-799)

2. Test each ROM and record FPS improvements

3. Identify optimal split point for fixed implementation

### Follow-Up
Once optimal fixed split identified:
1. Update `slave_main_loop` dispatch logic
2. Test dynamic split calculation
3. Measure final performance

---

## References

- Phase 4.1 ROM: `build/vrd_phase4_linked.32x` ✅ Working
- Phase 3.2 ROM: `build/vrd_phase3_final.32x` (baseline for comparison)
- Sync buffer: SDRAM 0x22000400
- Master engine: `disasm/sh2_3d_engine_annotated.asm` (func_001)
- Slave engine: `disasm/sh2_slave_consolidated.asm` (slave_main_loop)

---

## Conclusion

Phase 4.2 focuses on **utilization optimization** to squeeze the remaining 10-15% performance out of the Slave parallelization. By adjusting the polygon split point based on actual workload, we can achieve near-optimal CPU balance and maximum FPS improvement.

Current Phase 4.1 already delivers impressive gains (+10-20%); Phase 4.2 will push to the theoretical limit (+25-30%).
