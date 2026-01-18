# Phase 4.4: VDP Interrupt Investigation - Technical Analysis

**Date**: January 10, 2026
**Status**: Investigation Complete - Architecture Analysis Done
**Finding**: VDP polling is distributed throughout rendering functions, not centralized

---

## Executive Summary

The investigation confirms:
1. **VRD already uses interrupt-driven architecture** (V-INT handler-based)
2. **47% Master time is NOT spent in a single polling loop** - it's distributed across rendering functions
3. **Each rendering function does its own VDP polling** before accessing hardware
4. **Interrupt-driven replacement requires architectural refactoring**, not just handler replacement
5. **Three viable optimization paths identified** with different complexity/ROI tradeoffs

---

## What We Found

### 1. VDP Polling Architecture in VRD

**Distributed Pattern** (NOT centralized):
```
func_001 (Display List Processor)
├─ Reads display list commands
├─ For each command:
│  ├─ Call func_023 (Frustum Culler)
│  │  └─ [Inline VDP polling here]
│  ├─ Call func_046 (Word Stream Processor)
│  │  └─ [Inline VDP polling here] - lines 3705, 3732
│  ├─ Call func_047 (Polling loop function)
│  │  └─ [Dedicated VDP poll] - lines 3832-3838
│  └─ Call func_048 (Scanline fill)
│     └─ [Delay-slot optimized poll] - lines 3889-3894
```

**Key Characteristic**: Every rendering function that needs VDP access polls BEFORE accessing it.

### 2. Polling Pattern Details

**Pattern Across All Functions**:
```asm
read_vdp_status:
    mov.b   @(vdp_addr), r0      ; Read VDP status register
    tst     r0, r0               ; Test if non-zero
    bt      read_vdp_status      ; Loop if zero
```

**Frequency Per Frame**:
- ~150-200 rendering operations per frame
- Each operation does ~1-3 polling checks
- Total: ~250-400 polling operations per frame
- Cost: ~7.8ms per frame (47% of 16.67ms frame budget)

**Why Distributed**:
- Different rendering functions need different VDP access patterns
- Word streams (func_046) poll frequently
- Scanline fills (func_048) poll in delay slots
- Polygon rendering (func_023+) polls per polygon

---

## Three Optimization Paths

### Path A: Cache VDP Readiness State (LOWEST RISK, MODERATE GAIN)

**Approach**:
- Don't poll VDP status continuously
- Cache the last-known readiness state
- Update cache only once per V-INT or H-INT
- Rendering functions check cache instead of polling

**Implementation**:
```asm
; In V-INT handler (or main loop)
read_vdp_once_per_frame:
    mov.b   @(vdp_status_addr), r0
    mov.b   r0, @(cached_vdp_status, gbr)  ; Store in cached location

; In rendering functions (instead of polling)
render_with_cached_status:
    mov.b   @(cached_vdp_status, gbr), r0  ; Read cached value
    cmp     #$FF, r0                        ; Check if ready
    bf      .retry_later                    ; Skip if not ready
```

**Pros**:
- Minimal architectural changes
- Can be applied function-by-function
- Low implementation risk
- Works with existing interrupt system

**Cons**:
- Frames where VDP isn't ready would skip rendering (visual artifacts)
- Or need complex workaround logic
- Gain limited: ~10-20% (still polling, just less frequently)

**Expected Gain**: +5-10% FPS

---

### Path B: VDP Interrupt Signaling (MEDIUM RISK, HIGH GAIN)

**Approach**:
- VDP signals readiness via interrupt or COMM register flag
- Rendering functions don't poll, use ready flag instead
- Master SH2 and/or Slave SH2 reacts to VDP ready signal

**Hardware Support Available**:
- V-INT (every V-blank)
- H-INT (every H-blank, configurable)
- COMM register interrupts (68K → SH2)
- All documented in 32x-hardware-manual.md

**Implementation Strategy**:

**Option B1: H-INT Based Polling**
```asm
; Setup: Configure H-INT for frequent firing (every N lines)
; In H-INT handler:
h_int_handler:
    mov.b   @(vdp_status_addr), r0
    mov.b   r0, @(vdp_ready_flag, gbr)     ; Set flag if ready
    clear_h_int
    rte

; In rendering functions:
render_with_h_int_flag:
    mov.b   @(vdp_ready_flag, gbr), r0
    tst     r0, r0
    bf      .can_render
    bra     .wait_for_next_h_int
```

**Option B2: COMM Register Signaling**
- 68K sets a COMM register bit when VDP is ready
- SH2 polls the COMM register (much faster than VDP polling)
- Reduces polling cost by ~50%

**Pros**:
- Uses existing 32X hardware features
- Cleaner separation: polling responsibility → interrupt handler
- Can reduce polling significantly

**Cons**:
- Requires architectural changes to rendering functions
- Need to coordinate with existing V-INT handlers
- Testing complexity (interrupt timing sensitive)

**Expected Gain**: +15-25% FPS

---

### Path C: Asynchronous Rendering (HIGHEST RISK, HIGHEST GAIN)

**Approach**:
- Slave SH2 doesn't wait for VDP readiness
- Master SH2 manages VDP access scheduling
- Slave generates rendering commands; Master decides when to execute them
- Decouples Slave from VDP polling entirely

**Architecture Change**:
```
Current (Synchronous):
Master: render → poll VDP → write frame buffer
Slave:  render → poll VDP → write frame buffer

Proposed (Asynchronous):
Master: manage VDP state, signal when ready
Slave:  generate render commands → queue to Master
Master: decide execution order, interleave VDP access
```

**Implementation**:
- Slave generates display list of rendering operations
- Master executes list, handling VDP polling centrally
- Slave freed from VDP dependency
- Could achieve near-40% utilization for Slave

**Pros**:
- Highest potential gain (+25-35% FPS)
- Slave no longer blocked by VDP
- Better hardware utilization

**Cons**:
- Massive architectural refactoring
- New data structures (render command queues)
- Coordination complexity
- Testing nightmare
- Risk of introducing new bottlenecks

**Expected Gain**: +25-35% FPS (but very high implementation cost)

---

## Why Phase 4.1 Plateaued

**The Root Cause Chain**:

1. **Phase 4.1 parallelized polygon rendering** ✅
   - Slave now processes 30-40% of polygons
   - Master freed to 60-70% from previous 91%

2. **But Master still spends 47% of remaining time in VDP polling** ❌
   - Each polygon requires VDP polling
   - Slave ALSO polls before writing frame buffer
   - Both CPUs blocked by same VDP availability constraint

3. **Result: Performance plateau**
   - Expected: Slave utilization → +20-30% gain
   - Actual: Polling overhead → +8-13% gain
   - Gap: 12-17% lost to continued polling

4. **Why more parallelization didn't help**:
   - Slave can't eliminate polling (needs VDP access too)
   - Master still blocked by polling
   - Adding Slave work just adds more polling

---

## Risk/Reward Analysis

| Path | Implementation | Risk | Gain | Timeline |
|------|-----------------|------|------|----------|
| **A: Cache** | Minimal | Low | +5-10% | 1 day |
| **B: Interrupt** | Medium | Medium | +15-25% | 3-5 days |
| **C: Async** | Massive | High | +25-35% | 2-3 weeks |

---

## Recommended Approach: Path B (Interrupt Signaling)

**Why**:
- Good balance of gain (+15-25%) vs. risk/effort
- Uses existing 32X hardware (well-documented)
- Doesn't require complete architectural redesign
- Can be implemented incrementally
- Clear testing path

**Implementation Strategy**:

### Phase 4.4.1: H-INT Setup
- Configure H-INT for frequent signaling (e.g., every 8 lines)
- Set up H-INT handler to read VDP status
- Store VDP readiness in fast-access location (R14 + offset or GBR-relative)

### Phase 4.4.2: Modify func_047 (VDP Polling Loop)
- Replace `poll_vdp` busy-wait with `check_vdp_ready_flag`
- Use flag set by H-INT handler instead of polling

### Phase 4.4.3: Optimize func_048 (Scanline Fill)
- Similar change: use flag instead of inline polling

### Phase 4.4.4: Gradual Migration
- Test each function independently
- Measure FPS impact incrementally
- Rollback if any visual artifacts

### Phase 4.4.5: Validate Performance
- Measure frame time with cycle profiler
- Compare to baseline (Phase 4.1)
- Document improvement

---

## Alternative: Quick Win (Path A, 2-3 hours)

If full implementation is too risky:

1. **Identify hot spots** - which functions poll most frequently
2. **Cache VDP status** - read once, use multiple times per frame
3. **Measure impact** - might get +5-10% without architectural changes
4. **Validate** - ensure no visual artifacts
5. **Decide next step** - worth proceeding to Path B?

---

## Critical Implementation Notes

### From Hardware Documentation:

1. **H-INT Configuration**:
   - Address: `0x2000 4004h` (H Count register)
   - Set to line interval (e.g., `#8` for every 8 lines)
   - HEN bit at `0x2000 4000h bit 7` must be set

2. **Interrupt Handling**:
   - H-INT vectors to level 11-12 handler
   - Must clear interrupt before returning (address: `0x2000 4018h`)
   - Can use GBR-relative addressing for fast data access

3. **Synchronization**:
   - Avoid race conditions between interrupt handler and polling functions
   - Use atomic operations or memory barriers as needed
   - Test with both Master and Slave active

4. **Known Pitfalls**:
   - H-INT during V-blank controlled by HEN bit
   - Interrupt setup requires Free Run Timer initialization
   - Cache-through addresses for all I/O register access

---

## Files Affected in Implementation

**Would Modify**:
- `disasm/sh2_3d_engine_annotated.asm`
  - Lines 3832-3838: func_047 (VDP polling loop)
  - Lines 3889-3894: func_048 (scanline fill)
  - Potentially lines 3705, 3732: func_046 (inline polling)
  - V-INT handler setup

- `tools/sh2_linker_phase4.py` (if needed for address management)

**Reference**:
- `docs/32x-hardware-manual.md` (H-INT configuration)
- `docs/development-guide.md` (interrupt handler patterns)
- `docs/32x-technical-info.md` (known issues and workarounds)

---

## Performance Projection: Phase 4.4 Complete

**After Path B Implementation** (Interrupt-Driven VDP):

| Metric | Phase 4.1 | Phase 4.4 Target |
|--------|-----------|------------------|
| Master CPU | 60-70% | 35-45% |
| Slave CPU | 30-40% | 45-55% |
| VDP Polling | 47% → 5-10% | via interrupt |
| FPS | 26-27 | 30-32 (+15-25%) |
| Total vs Baseline | +8-13% | +25-33% |

---

## Next Steps

1. **Immediate (1 hour)**:
   - Review H-INT documentation in detail
   - Plan H-INT handler location in memory
   - Sketch interrupt vector setup

2. **Short-term (1 day)**:
   - Implement func_047 modification as proof-of-concept
   - Test with single polling function change
   - Measure FPS impact
   - Look for visual artifacts

3. **Medium-term (3-5 days)**:
   - Apply to func_048, func_046
   - Systematic testing
   - Performance validation
   - Document final implementation

4. **Optional (longer-term)**:
   - Phase 4.5: Coordination optimization
   - Phase 4.6: Write pattern tuning
   - Consider Phase 4C: Asynchronous rendering (future research)

---

## Conclusion

VDP polling is **NOT a single loop** that can be simply replaced. It's **distributed throughout rendering functions** and tied to the core rendering architecture.

**Good News**:
- Clear solution path exists (interrupt-driven signaling)
- 32X hardware supports all required features
- Potential +15-25% FPS gain is significant

**Challenge**:
- Requires careful coordination between V-INT, H-INT, and rendering functions
- Testing complexity (interrupt timing sensitive)
- Need to validate no visual artifacts during transition

**Recommendation**: Start with Path B (Interrupt Signaling) - good balance of feasibility and gain. If successful, achieve 30-32 FPS (vs. current 26-27 FPS).
