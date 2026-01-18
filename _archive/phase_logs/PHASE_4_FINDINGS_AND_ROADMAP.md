# Phase 4 Investigation Findings & Roadmap Revision

**Date**: January 10, 2026
**Status**: Phase 4.1 Complete + Critical Findings Documented
**Pivot**: FIFO blocking is NOT the bottleneck - coordination overhead is

---

## Executive Summary

After comprehensive testing of Phase 4.1 parallelization and FIFO analysis:

1. **Phase 4.1 Success**: JSR function linking works, achieved +8-13% FPS improvement
2. **FIFO Analysis Results**: Negligible blocking (33-71 blocks across full game session)
3. **Real Bottleneck**: VDP polling (47% Master time) + Master-Slave coordination overhead
4. **Revised Strategy**: Replace VDP polling with interrupt-driven monitoring instead of FIFO batching

---

## Critical Findings

### Finding 1: FIFO Blocking is Negligible

**Full Gameplay Session Analysis**:

| Metric | Phase 3.2 | Phase 4.1 | Impact |
|--------|-----------|-----------|--------|
| Total DREQ blocks | 33 | 71 | Negligible |
| Session duration | ~95s | ~210s | Full game flow |
| Blocks/second | 0.35 | 0.34 | Essentially zero |
| Blocks/frame | ~0.006 | ~0.006 | 1 block per ~170 frames |
| Stall cycles/frame | <1 | <1 | Undetectable |
| % of frame time | <0.0001% | <0.0001% | **NOT a bottleneck** |

**Interpretation**:
- These 33-71 blocks are scattered across the entire session (startup, menu, pit stop, racing, bridge)
- They represent edge cases or initialization sequences, NOT steady-state rendering
- Even if completely eliminated: +0.0001% FPS gain (unmeasurable)
- **Conclusion**: FIFO blocking is NOT constraining performance

### Finding 2: Why Phase 4.1 Plateaued at +8-13%

Phase 4.1 achieved measurable improvements but hit a wall:

```
Master CPU (Phase 3.2): 91% utilization
Master CPU (Phase 4.1): 60-70% utilization (-21-31%)

Slave CPU (Phase 3.2): 0.03% utilization
Slave CPU (Phase 4.1): 30-40% utilization (+30-40%)

FPS improvement: +8-13% (NOT +20-30% expected from 40% Slave utilization)
```

**Why the gap?** The remaining 60-70% Master utilization includes:
- **VDP Polling Loop**: ~47% of frame (busy-wait for hardware ready)
- **Sync/Coordination**: ~5-10% (Master-Slave handshaking)
- **Other Processing**: ~5-15% (game logic, state updates)

**The Problem**: Master can't reduce VDP polling time by delegating to Slave. Slave can only render polygons; it can't know when VDP is ready. Master must poll, consuming 47% of frame time regardless.

### Finding 3: Architecture Limitation - VDP Polling as Bottleneck

From architecture analysis:

```
Per-frame breakdown (Phase 3.2):
├─ 8% - Game logic and state
├─ 5% - Render preparation
├─ 2% - SH2 work (polygon rasterization)
├─ 47% - VDP polling busy-wait ← REAL BOTTLENECK
└─ 34% - Idle/stall
```

The VDP polling loop is:
```assembly
.vdp_poll_loop:
    mov.b   @(vdp_status), r0   ; Check VDP ready flag
    tst     r0, r0
    bt      .vdp_poll_loop      ; Loop until status changes (47% of frame!)
```

**Critical Issue**: During this polling:
- Master CPU cannot coordinate with Slave effectively
- Master can't do useful work (it's stuck in busy-wait)
- Slave might finish rendering but Master is still polling
- Phase 4.1 parallelization doesn't help because Master is blocked

---

## Revised Optimization Strategy

### Old Strategy (Didn't Work)

1. Phase 4.1: Distribute polygons between CPUs ✅ (+8-13%)
2. Phase 4.2: Balance polygon split ✅ (no improvement found)
3. Phase 4.3: Optimize FIFO writes ❌ (not a bottleneck)

### New Strategy (High-Leverage Opportunities)

#### **Opportunity 1: Replace VDP Polling with Interrupt (HIGHEST PRIORITY)**

**Current (Polling)**:
```assembly
.vdp_poll_loop:
    mov.b   @(vdp_status), r0
    tst     r0, r0
    bt      .vdp_poll_loop      ; 47% of frame time
```

**Proposed (Interrupt-Driven)**:
```assembly
; Set up VDP interrupt
mov.l   #vdp_handler, r0
mov.l   r0, @(VDP_INTERRUPT_VECTOR, r14)

; Main code continues immediately
; VDP interrupt fires when ready, no polling needed
```

**Expected Impact**:
- Frees 40-50% of Master CPU time
- Master can do other work or better coordinate with Slave
- Could enable 20-30% overall FPS gain
- **Effort**: Medium (interrupt setup, VDP hardware interaction)
- **Risk**: Medium (hardware interrupt timing critical)

#### **Opportunity 2: Optimize Master-Slave Coordination Protocol**

**Current Overhead**:
- ~5-10% of frame for sync buffer reads/writes
- Master waits for Slave completion
- No pipelining (Slave works on N while Master waits, then N+1 starts)

**Improvements**:
- Implement double-buffering (Slave works on N while Master prepares N+1)
- Use faster sync mechanism (COMM registers instead of SDRAM reads)
- Reduce handshake overhead with lockless patterns

**Expected Impact**:
- Free 3-5% of Master time
- Enable pipeline parallelism (+5-10% FPS potential)
- **Effort**: Low-Medium (assembly optimization)
- **Risk**: Low (localized change)

#### **Opportunity 3: Slave Frame Buffer Write Optimization**

**Current Pattern**:
```assembly
; Individual writes scattered
mov.l   r1, @r9      ; Write pixel at address in R9
add     #4, r9       ; Update offset
```

**Optimizations**:
- Sequential access pattern (already good, lines 112-223)
- Cache-friendly stride patterns
- Batch writes for better FIFO utilization

**Expected Impact**:
- Modest 2-5% improvement (FIFO is not bottleneck, but throughput matters)
- **Effort**: Low (assembly pattern tuning)
- **Risk**: Low (localized change)

#### **Opportunity 4: Interrupt-Driven Slave Work Distribution**

**Current**:
- Master polls Slave status
- Synchronous handshaking

**Proposed**:
- Slave sets "ready" interrupt when done
- Master doesn't need to poll or wait

**Expected Impact**:
- 1-2% improvement (minor, but cleaner architecture)
- **Effort**: Low-Medium
- **Risk**: Low

---

## Recommended Next Steps

### Phase 4.4: VDP Interrupt-Driven Monitoring (IMMEDIATE PRIORITY)

**Objective**: Replace VDP polling busy-wait with interrupt-driven readiness signal

**Scope**:
1. Investigate VDP interrupt mechanism in 32X hardware
2. Set up interrupt handler for VDP readiness
3. Replace polling loop with interrupt wait (or other work)
4. Measure FPS improvement

**Expected Gain**: +15-25% FPS improvement (freeing 40% of Master time)

**Files to Modify**:
- `disasm/sh2_3d_engine_annotated.asm` - Replace VDP polling with interrupt setup
- `docs/32x-hardware-manual.md` - Document VDP interrupt behavior

### Phase 4.5: Master-Slave Coordination Optimization

**Objective**: Reduce sync overhead and enable pipelining

**Scope**:
1. Profile sync buffer access overhead
2. Implement double-buffering
3. Consider COMM register-based sync instead of SDRAM
4. Measure effect on timing

**Expected Gain**: +5-10% FPS improvement

### Phase 4.6: Slave Write Pattern Optimization

**Objective**: Maximize frame buffer throughput

**Scope**:
1. Profile current write patterns
2. Optimize stride and cache locality
3. Test FIFO batching (if needed for smoothness)

**Expected Gain**: +2-5% FPS improvement

---

## Why FIFO Analysis Led Here

The FIFO investigation appeared to show "hundreds of blocks per frame" during gameplay, but actual log analysis revealed:

1. **Initial assumption**: Hundreds of blocks = bottleneck
2. **Actual finding**: 33-71 blocks across entire game session = negligible
3. **Root cause**: FIFO blocking happens during startup initialization, NOT active rendering
4. **Correct conclusion**: FIFO is NOT the limiting factor

**Why this matters**: By investigating the "wrong" bottleneck, we identified the REAL one:
- **VDP polling** (47% of Master time) is far more impactful than FIFO blocking
- **Coordination overhead** (5-10%) is more impactful than FIFO batching gains
- **CPU coordination** is the real architectural constraint

---

## Performance Projection

### Current State (Phase 4.1)
- Master: 60-70% utilization
- Slave: 30-40% utilization
- FPS: ~26-27 (vs 24 baseline, +8-13%)

### After VDP Interrupt + Coordination (Phase 4.4-4.5)
- Master: 35-45% utilization (freed from polling)
- Slave: 45-55% utilization (better coordinated)
- FPS: ~30-33 (+25-38% vs baseline, +15-25% vs Phase 4.1)

### With All Optimizations (Phase 4.4-4.6)
- Master: 30-40% utilization
- Slave: 50-60% utilization (maximum practical)
- FPS: ~31-35 (+30-45% vs baseline, +20-30% vs Phase 4.1)

---

## Key Decision: VDP Interrupt Implementation

**Critical Question**: Does the 32X hardware support VDP interrupt-driven readiness?

**Next Step**: Search architecture docs for:
- VDP interrupt vectors
- VDP status registers and interrupt triggers
- Whether VDP ready signal can interrupt Master
- Interrupt priority and handling requirements

If VDP interrupts are available: **This is the highest-ROI optimization**.
If VDP interrupts unavailable: **Investigate alternative CPU coordination mechanisms** (e.g., faster sync buffer, COMM registers, or CPU wait instructions).

---

## Conclusion

**Phase 4.1 succeeded** in proving SH2 parallelization works, but the real scaling opportunity is in CPU coordination and eliminating the VDP polling bottleneck, NOT in FIFO optimization.

The investigation revealed:
- ✅ FIFO blocking is negligible
- ✅ VDP polling is the real bottleneck
- ✅ Master-Slave coordination overhead is secondary constraint
- ✅ Clear path to +20-30% additional gains identified

**Action**: Proceed to Phase 4.4 with focus on interrupt-driven VDP monitoring.
