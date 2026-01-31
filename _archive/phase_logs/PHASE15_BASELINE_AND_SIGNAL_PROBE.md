# Phase 15: Baseline FPS + Master Signal Probe

**Status:** Planning
**Date:** 2026-01-22
**Objective:** Establish performance baseline and verify end-to-end Master→Slave signaling

---

## Overview

Before optimization work can begin, we need:
1. **Baseline FPS measurement** - Hard numbers to compare against
2. **End-to-end signal verification** - Proof that Master can drive Slave in-game

This document outlines a minimal-risk approach to achieve both.

---

## Part 1: Baseline FPS Counter

### Existing Infrastructure

We already have `tools/inject_fps_counter.py` which:
- Hooks VBlank poll function at **ROM offset 0x243E0** (SH2 address 0x022243E0)
- Increments counter at **SDRAM 0x22000100** every VBlank
- Works by replacing the VBlank poll with JMP to new code

### VBlank Poll Function (Original)

```
ROM 0x243E0 - Master SH2 VBlank Wait:
  D102      MOV.L @(8,PC),R1  ; Load VDP base 0x20004100
  8515      MOV.W @(10,R1),R0 ; Read VDP status at 0x2000410A
  C802      TST #2,R0         ; Test VBlank bit
  8BFC      BF poll_loop      ; Loop if not set
  000B      RTS
  0009      NOP
  20004100  .long VDP_BASE
```

**Key insight:** This is called by Master SH2 at every frame boundary.

### What We Get

- Counter at 0x22000100 increments per VBlank (~60 Hz system tick)
- Can calculate actual FPS by monitoring counter over time
- Baseline measurement before any optimization

---

## Part 2: Master Signal Probe

### Injection Point

**Same location as FPS counter: VBlank poll exit**

After the VBlank poll completes (frame boundary), we add:
```asm
; At VBlank completion (frame boundary):
MOV.L   #$2000402C, R0    ; COMM6 address
MOV     #$0012, R1        ; Signal value
MOV.W   R1, @R0           ; Write COMM6 = 0x0012
```

This signals the Slave once per frame, at the exact moment the Master detects VBlank.

### Complete Signal Flow

```
Frame N:
┌─────────────────────────────────────────────────────────────────┐
│ MASTER SH2                    │ SLAVE SH2                       │
│                               │                                 │
│ 1. Render frame               │ (polling loop)                  │
│ 2. Call VBlank poll           │                                 │
│ 3. Wait for VBlank bit        │                                 │
│ 4. VBlank detected ────────────→ 5. Hook detects COMM6=0x0012   │
│    (COMM6 ← 0x0012)           │                                 │
│                               │ 6. Handler increments COMM4     │
│                               │ 7. Hook clears COMM6            │
│ 8. Continue to next frame     │ (resume polling)                │
└─────────────────────────────────────────────────────────────────┘
```

### Verification Method

Monitor COMM4 (0x20004028) in emulator:
- If COMM4 increments once per frame → **Signal probe successful**
- If COMM4 stays 0 → Signal not reaching Slave (investigate)

---

## Part 3: Combined Implementation

### New Tool: `inject_baseline_probe.py`

Combines both FPS counter and Master signal probe into one ROM patch.

### Code to Inject (at 0x243E0 replacement)

```asm
vblank_poll_with_signal:
    ; === Original VBlank poll logic ===
    MOV.L   @(vdp_base,PC), R1  ; Load VDP base 0x20004100
poll_loop:
    MOV.W   @(10,R1), R0        ; Read VDP status at 0x2000410A
    TST     #2, R0              ; Test VBlank bit
    BF      poll_loop           ; Loop if not set

    ; === NEW: FPS counter increment ===
    MOV.L   @(counter_addr,PC), R2
    MOV.L   @R2, R0
    ADD     #1, R0
    MOV.L   R0, @R2

    ; === NEW: Master→Slave signal ===
    MOV.L   @(comm6_addr,PC), R0
    MOV     #$12, R1            ; Signal value 0x0012
    MOV.W   R1, @R0             ; Write to COMM6

    ; === Return ===
    RTS
    NOP

; Literal pool
vdp_base:     .long 0x20004100
counter_addr: .long 0x22000100  ; FPS counter location
comm6_addr:   .long 0x2000402C  ; COMM6 register
```

### Size Estimate

- Original function: 16 bytes
- New code: ~40-48 bytes
- Requires jump to free space (same as existing FPS counter approach)

---

## Part 4: Baseline Metrics to Record

### Before Any Optimization

| Metric | Location | Expected | Notes |
|--------|----------|----------|-------|
| VBlank counter | 0x22000100 | ~60/sec | System tick rate |
| COMM4 counter | 0x20004028 | ~60/sec | Signal confirmation |
| Observed FPS | Visual | ~20 FPS | Gameplay frame rate |
| Frame time | Calculated | ~50ms | 1000ms / 20 FPS |

### How to Measure

1. Run ROM with injected probe for 60 seconds
2. Record initial COMM4 value
3. Record final COMM4 value after 60 sec
4. Calculate: `signals_per_second = (final - initial) / 60`
5. If ~60 signals/sec, round-trip working perfectly

---

## Part 5: Implementation Plan

### Step 1: Create Combined Injection Tool

```bash
# New tool combining FPS + signal probe
tools/inject_baseline_probe.py
```

**Inputs:**
- Input ROM: `build/vr_rebuild.32x`
- Output ROM: `build/vr_baseline_probe.32x`

### Step 2: Build and Test

```bash
# Build probe ROM
python3 tools/inject_baseline_probe.py \
    build/vr_rebuild.32x \
    build/vr_baseline_probe.32x

# Test in PicoDrive
picodrive build/vr_baseline_probe.32x
```

### Step 3: Verify Signal Round-Trip

In emulator memory viewer:
- Watch 0x22000100 (FPS counter) - should increment ~60/sec
- Watch 0x20004028 (COMM4) - should increment ~60/sec (proof of signal)

### Step 4: Record Baseline

Document:
- Counter values over 60 seconds
- Observed gameplay FPS
- Any anomalies or issues

---

## Success Criteria

### Minimum Viable:
- [ ] ROM boots without crash
- [ ] VBlank counter (0x22000100) increments
- [ ] COMM4 (0x20004028) increments (signal verified)

### Full Success:
- [ ] Counter increments at ~60/sec
- [ ] COMM4 increments at ~60/sec (perfect signal)
- [ ] Gameplay remains stable
- [ ] Baseline documented with hard numbers

---

## Risk Assessment

| Risk | Likelihood | Mitigation |
|------|------------|------------|
| ROM crashes | Low | FPS counter tool already proven |
| Signal not detected | Low | Slave hook already validated |
| Counter overflow | Very Low | 32-bit counter lasts 2+ years at 60 Hz |
| Timing issues | Low | Signal at natural frame boundary |

---

## Next Steps After Baseline

Once baseline is established and signal verified:

1. **Review bottleneck analysis** - Identify first optimization target
2. **Expand handler** - Replace counter increment with actual work
3. **Measure impact** - Compare new FPS against baseline
4. **Iterate** - Pick next optimization target

---

## References

- `tools/inject_fps_counter.py` - Existing FPS counter tool
- `PHASE11_RESULTS.md` - Slave hook implementation
- `PHASE12_RESULTS.md` - Handler implementation
- `analysis/ARCHITECTURAL_BOTTLENECK_ANALYSIS.md` - Bottleneck analysis
- `analysis/profiling/FRAME_COUNTER_IMPLEMENTATION.md` - FPS counter design

---

**Status:** Ready for implementation
**Estimated Time:** 1-2 hours
**Risk Level:** Low (builds on proven components)

