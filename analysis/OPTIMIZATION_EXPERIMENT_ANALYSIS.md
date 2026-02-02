# Optimization Experiment Analysis - State Assessment

**Date:** 2026-02-01
**Branch:** Experimental
**Purpose:** Rehearsal draft to measure current state and actionable opportunities

---

## Executive Summary

This analysis synthesizes our complete disassembly work, profiling data, and infrastructure development to assess what optimizations are immediately actionable versus what requires further work.

### Current State at a Glance

| Metric | Value | Status |
|--------|-------|--------|
| **68K Disassembly** | 379KB across 16 modules | Complete |
| **SH2 Functions Translated** | 75 of 109 (69%) | Complete |
| **Expansion ROM** | 1MB at $300000-$3FFFFF | Built & Integrated |
| **Parallel Processing Code** | 5 handlers ready | Implemented, NOT ACTIVATED |
| **Current FPS** | 20-24 | Measured baseline |
| **Realistic Target** | 30-40 FPS | With Slave + conditional switch |
| **Stretch Target** | 48-60 FPS | Requires 68K blocking reduction too |

### The Core Problem (Confirmed)

```
┌─────────────────────────────────────────────────────────────────────┐
│  68K CPU @ 100.1% UTILIZATION = PRIMARY BOTTLENECK                  │
│  • 127,987 cycles/frame @ 7.67 MHz = 16.69 ms per frame            │
│  • 58% of time spent BLOCKING on SH2 communication                  │
│  • Even if SH2 work → 0, still bottlenecked at ~35 FPS             │
└─────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────┐
│  SH2 PROCESSORS = MASSIVELY UNDERUTILIZED                          │
│  • Master SH2: 36.4% (139K cycles) - Idle waiting for 68K          │
│  • Slave SH2:  78.3% (300K cycles) - 66.5% in IDLE DELAY LOOP      │
└─────────────────────────────────────────────────────────────────────┘
```

---

## Part 1: What We've Built (Complete Infrastructure)

### 1.1 Expansion ROM Layout ($300000-$3FFFFF)

| Address | Size | Function | Purpose | Status |
|---------|------|----------|---------|--------|
| $300028 | 22B | `handler_frame_sync` | Increment COMM4 counter | Ready |
| $300050 | 44B | `master_dispatch_hook` | Skip COMM7 for cmd 0x16 | Ready |
| $300100 | 96B | `func_021_optimized` | Vertex transform + func_016 inlined | Ready |
| $300200 | 76B | `slave_work_wrapper` | COMM7 polling + dispatch | Ready |
| $300280 | 44B | `slave_test_func` | Load params, call func_021 | Ready |
| $300300 | 36B | `func_021_original_relocated` | Original func_021 bytes | Ready |
| $300400 | 52B | `shadow_path_wrapper` | Instrumentation wrapper | Ready |
| $300500 | 56B | `batch_copy_handler` | Batch command processing | Ready |

**Total implemented:** 426 bytes of SH2 code in expansion ROM

### 1.2 Communication Protocol (Designed)

```
ACTIVATION FLOW (Currently NOT CONNECTED):

68K: sh2_graphics_cmd($16) → COMM0=cmd, COMM4+5=data_ptr
                    ↓
Master SH2: Dispatch loop at $02020460 reads COMM0
                    ↓
            Call func_021 at $022234C8 (36 bytes)
                    ↓
            [TRAMPOLINE POINT - NOT YET PATCHED]
                    ↓
            Should redirect to shadow_path_wrapper @ $02300400
                    ↓
shadow_path_wrapper:
  1. Increment COMM6 (Master call counter)
  2. Copy params (R14,R7,R8,R5) to $2203E000
  3. Signal Slave via COMM7=0x16
  4. Call func_021_original_relocated @ $02300300
  5. Return (Slave works in parallel)
                    ↓
Slave SH2: slave_work_wrapper @ $02300200
  1. Poll COMM7 until != 0
  2. If COMM7=0x16 → call slave_test_func
  3. slave_test_func loads params, calls func_021_optimized
  4. Increment COMM5 by 100 (completion counter)
  5. Clear COMM7, return to polling
```

### 1.3 68K Modules Translated

| Category | Files | Lines | Key Functions |
|----------|-------|-------|---------------|
| **game** | 19 | 21,744 | Object system, physics, AI, collision |
| **sh2** | 3 | 1,664 | COMM protocol, blocking waits |
| **math** | 2 | 479 | Trig lookups (29 calls/frame) |
| **memory** | 6 | 512 | Fast copy waterfall pattern |
| **vint** | 1 | 93 | 16-state V-INT dispatcher |
| **data** | 370 | 347,767 | ROM tables, sprites, graphics |

**Key insight:** The high-frequency functions are fully documented:
- `angle_to_sine` ($0070AA) - 29 calls/frame
- `load_object_params` ($0080CC) - 27 calls/frame
- `object_frame_timer` ($008170) - 22 calls/frame
- `calc_steering` ($006F98) - 19 calls/frame
- Position/velocity updates - 18 calls each

### 1.4 SH2 3D Pipeline Understood

```
Pipeline Stage Distribution (per frame @ 23 MHz):
┌─────────────────────────────────────────────────────────────┐
│ Stage              │ Cycles   │ % Budget │ Key Functions   │
├────────────────────┼──────────┼──────────┼─────────────────│
│ Hardware Init      │ ~500     │ 0.1%     │ VDP setup       │
│ Data Unpacking     │ ~10,000  │ 2.6%     │ Decompress      │
│ Vertex Transform   │ ~50,000  │ 13%      │ func_021 ←TARGET│
│ Polygon Processing │ ~80,000  │ 21%      │ func_023, 020   │
│ Rasterization      │ ~200,000 │ 52%      │ func_065 ←HOT   │
│ Overhead/Sync      │ ~42,500  │ 11%      │ COMM waits      │
└─────────────────────────────────────────────────────────────┘
```

**Critical functions translated:**
- `func_021` (vertex transform) - 38B, READY FOR OFFLOAD
- `func_016` (coord packing) - 34B, INLINED into func_021_optimized
- `func_023` (frustum cull) - 238B, LARGEST function
- `func_065` (rasterization) - 150B, HOTTEST (but fall-through, untouchable)

---

## Part 2: Immediate Optimization Opportunities

### 2.1 TIER 1: Activation Opportunities (Risk-Stratified)

#### A. Shadow Path Activation ✅ SAFE

**What:** Redirect func_021 calls through shadow_path_wrapper

**How:** Patch 6 bytes at $022234C8 to jump to $02300400

```asm
; Current at $022234C8:
dc.w    $4F22    ; STS.L PR,@-R15
dc.w    $BF4D    ; BSR func_016
dc.w    $0009    ; NOP

; Patch to:
dc.w    $D001    ; MOV.L @(4,PC),R0 - load $02300400
dc.w    $402B    ; JMP @R0
dc.w    $0009    ; NOP (delay slot)
dc.l    $02300400 ; literal: shadow_path_wrapper
```

**Risk:** LOW - shadow path still uses original func_021 for rendering
**Gain:** Instrumentation only (COMM5/COMM6 counters) - diagnostic, not performance
**Why safe:** Master continues to use original func_021 results. Slave work is discarded.

#### B. Slave Work Wrapper Activation ⚠️ REQUIRES VALIDATION

**What:** Make Slave SH2 poll COMM7 instead of COMM1

**How:** Patch Slave entry point at SDRAM $06000592 to jump to $02300200

**Current Slave loop (idle 66.5% of time):**
```asm
; At $06000592:
mov.l   comm1_addr,r1       ; R1 = $20004024
mov.b   @r1,r0              ; Read COMM1
cmp/eq  #0,r0               ; Is COMM1 == 0?
bt      delay_loop          ; If zero → 64-cycle idle spin
```

**Patch to:**
```asm
; At $06000592:
mov.l   new_loop_addr,r0    ; Load $02300200
jmp     @r0                 ; Jump to slave_work_wrapper
nop                         ; Delay slot
```

**Risk:** MEDIUM - Combined with shadow path, Slave does work but Master ignores it.
         Still safe because Master uses its own results.
**Gain:** Enables timing measurement (does Slave keep up with Master?)

#### C. Full Activation ❌ NOT SAFE WITHOUT CONDITIONAL PATH

**The Critical Problem:**

```
Master calls func_021 → returns immediately → reads output buffer
                                    ↑
                        If Slave is still writing here = RACE CONDITION
```

Even if Slave is faster on average, any single late completion corrupts rendering.

**Why fire-and-forget fails:**
1. Master expects results in output buffer immediately after func_021 returns
2. If Slave hasn't finished writing, Master reads partial/stale data
3. Result: visual corruption, blank screens, crashes

**Required before full activation:**
1. Measure timing gap from shadow path (COMM6 - COMM5/100)
2. Implement conditional switch: use Slave results ONLY if ready
3. Fallback to Master if Slave is behind

**Expected behavior (shadow path only):**
- Master increments COMM6 on each func_021 call
- Slave increments COMM5 by 100 on each completion
- Gap = COMM6 - COMM5/100 shows how far behind Slave is
- **If gap > 0 at consumption time → Slave results unsafe to use**

### 2.2 TIER 2: Low-Effort 68K Optimizations

#### A. Inline angle_to_sine (29 calls/frame)

**Current:** JSR to $0070AA, ~120 cycles + call overhead
**Opportunity:** Function is only ~40 bytes, could inline at hot call sites

**Savings:** ~20 cycles × 29 calls = 580 cycles/frame (~0.5% of budget)

#### B. Batch Position/Velocity Updates (72 calls/frame combined)

**Current:** Separate calls for X/Y position and X/Y velocity
**Opportunity:** Combined update function processes all 4 in one call

```asm
; Current: 4 separate calls
    jsr     obj_position_x      ; 18 calls
    jsr     obj_position_y      ; 18 calls
    jsr     obj_velocity_x      ; 18 calls
    jsr     obj_velocity_y      ; 18 calls

; Proposed: Single batch call
    jsr     obj_physics_update  ; 18 calls (4x less overhead)
```

**Savings:** ~800-1000 cycles/frame (~0.8% of budget)

#### C. Object Timer Batch Processing

**Current:** `object_frame_timer` called 22 times individually
**Opportunity:** Single loop iterates all active objects

**Savings:** ~400 cycles/frame (~0.3% of budget)

### 2.3 TIER 3: Architectural Changes (Higher Effort)

#### A. Async Command Submission

**Current:** 68K blocks on each SH2 command (58% of frame time)
**Target:** Queue commands, continue 68K work, sync once per frame

**Implementation complexity:** HIGH
**Potential gain:** 10-15% FPS improvement

#### B. VDP Polling Elimination

**Current:** 4 polling loops waste ~450K cycles/frame (47% of SH2 budget)
**Target:** Interrupt-driven VDP access

**Implementation complexity:** MEDIUM-HIGH
**Potential gain:** 30-40% FPS improvement (but requires timing analysis)

---

## Part 3: Risk Assessment

### 3.1 Safe to Activate (Low Risk)

| Change | Risk | Reversibility | Testing Required |
|--------|------|---------------|------------------|
| Shadow path instrumentation | Low | Easy revert | Boot + 5 min gameplay |
| Shadow + Slave timing | Low | Slave results ignored | Visual verification |
| 68K function inlining | Low | Byte-identical fallback | Build comparison |

### 3.2 Requires Conditional Path (Medium Risk)

| Change | Risk | Concern | Mitigation |
|--------|------|---------|------------|
| **Using Slave results** | **Medium** | **Master reads before Slave finishes** | **Conditional: check ready before use** |
| Parallel func_021 | Medium | Race condition on output buffer | Only consume when COMM5 confirms done |
| Combined activation | Medium | Timing variance under load | Keep Master fallback path |

**Critical insight:** The risk isn't Slave execution - it's **consumption timing**. Master may read the output buffer immediately after func_021 returns. Slave must be finished writing before that happens.

### 3.3 Not Recommended Yet (High Risk)

| Change | Risk | Concern | Prerequisites |
|--------|------|---------|---------------|
| Fire-and-forget activation | HIGH | Data race if Slave late | Timing validation + conditional path |
| VDP interrupt conversion | High | Hardware timing | Complete VDP state machine documentation |
| 68K async commands | High | Protocol redesign | Full COMM register usage audit |
| func_065 modification | BLOCKED | Fall-through design | Documented as impossible |

---

## Part 4: Recommended Experiment Sequence (Risk-Aware)

### Phase 1: Shadow Path Only ✅ SAFE

**Goal:** Instrument without behavior change, measure call patterns

1. Apply shadow_path_wrapper patch at $022234C8
2. Boot ROM, verify gameplay unchanged (Master still does all real work)
3. Read COMM6 counter - should increment ~100x/frame (vertex calls)
4. Slave remains idle (COMM7 signaled but Slave not listening yet)

**Success criteria:**
- ROM boots and plays normally
- COMM6 shows expected call pattern
- Zero visual difference (Master uses original func_021 results)

### Phase 2: Shadow Path + Slave Timing Measurement

**Goal:** Slave does parallel work, but Master ignores Slave's results

1. Apply Slave entry patch at $06000592 → $02300200
2. Boot ROM, verify Slave polls COMM7 and executes func_021_optimized
3. COMM5 increments by 100 per Slave completion
4. **Measure gap:** COMM6 - COMM5/100 at various points in frame

**Success criteria:**
- Slave executes without interfering with rendering
- Gap measurement shows Slave timing relative to Master
- Still zero visual difference (Master uses its own results)

**Key data to collect:**
- Maximum gap during gameplay
- Gap variance (consistent or spiky?)
- Slave cycles per func_021 call

### Phase 3: Timing Analysis & Conditional Design

**Goal:** Determine if Slave can keep up, design safe consumption

Based on Phase 2 data:

**If gap ≤ 0 consistently (Slave faster):**
- Slave finishes before Master would consume
- Still need to verify this holds under worst-case load

**If gap > 0 sometimes (Slave occasionally behind):**
- Must implement conditional switch
- Master checks: is Slave result ready?
- If ready → use Slave result, skip own work
- If not ready → Master does work itself (fallback)

**Conditional switch implementation:** See [func_021_conditional.inc](../disasm/sh2/generated/func_021_conditional.inc)

**Two-phase design:**

| Phase | File | Behavior | Risk |
|-------|------|----------|------|
| Phase 1 | `func_021_conditional.inc` | Master ALWAYS does work + signals Slave when idle | Low (timing measurement only) |
| Phase 2 | `func_021_conditional_v2.inc` | Master SKIPS work when Slave ahead (COMM5 >= COMM6) | Medium (requires Slave result validation) |

**Phase 1 logic (48 bytes):**
```asm
func_021_conditional:
    if (COMM7 == 0) {           ; Slave idle
        write_param_block()      ; Capture R14, R7, R8, R5
        COMM7 = 0x16             ; Signal Slave
    }
    COMM6++                      ; Track Master calls
    call func_021_original()     ; Master ALWAYS produces result
    return
```

**Phase 2 logic (88 bytes):**
```asm
func_021_conditional_v2:
    if (COMM5 >= COMM6) {        ; Slave caught up
        write_param_block()
        COMM7 = 0x16
        COMM6++
        return                    ; Skip Master work - use Slave's result!
    } else {                      ; Slave behind
        COMM6++
        if (COMM7 == 0) signal_slave()
        call func_021_original()  ; Master does work
        return
    }
```

**Critical requirement for Phase 2:** Slave must write to the SAME output buffer (R5) that Master would use. Since R5 is passed in the param block, this works - but verify that Slave's `func_021_optimized` respects R5 correctly.

### Phase 4: Conditional Activation

**Goal:** Use Slave results when safe, Master fallback otherwise

1. Implement conditional switch at result consumption point
2. Master skips func_021 ONLY when Slave result confirmed ready
3. Measure: what % of calls use Slave vs Master fallback?

**Success criteria:**
- No visual corruption (conditional path guarantees data-ready)
- Gradual FPS improvement proportional to Slave hit rate
- Graceful degradation if Slave falls behind

### Phase 5: Full Activation (Only After Phase 4 Validated)

**Goal:** Optimize for maximum parallelization

1. If Phase 4 shows >90% Slave hit rate → Slave is reliably faster
2. Consider removing conditional check overhead (measure if worthwhile)
3. Or keep conditional as safety net

**Realistic expectations:**
- FPS improvement depends on how much 68K blocking is removed
- If Master still blocks on other COMM operations, gain is limited
- 10-30% improvement is realistic; 50-100% requires reducing 68K blocking too

---

## Part 5: Tools and Verification

### 5.1 Available Profiling

```bash
# Frame-level profiling (works)
cd tools/libretro-profiling
./profiling_frontend ../../build/vr_rebuild.32x 1800 --autoplay

# PC-level hotspot analysis (works)
VRD_PROFILE_PC=1 VRD_PROFILE_PC_LOG=profile.csv \
./profiling_frontend ../../build/vr_rebuild.32x 2400 --autoplay
python3 analyze_pc_profile.py profile.csv
```

### 5.2 ROM Verification

```bash
# Build and compare
make all
make compare

# Manual byte verification
xxd build/vr_rebuild.32x | head -1000 > rebuilt.hex
xxd original/vr.32x | head -1000 > original.hex
diff rebuilt.hex original.hex
```

### 5.3 COMM Register Monitoring

**Addresses (SH2 perspective):**
- COMM5 @ $2000402A - Slave completion counter
- COMM6 @ $2000402C - Master call counter
- COMM7 @ $2000402E - Work signal

**Expected values during shadow path:**
- COMM6: Increments by 1 per func_021 call (~100/frame)
- COMM5: Increments by 100 per Slave completion
- COMM7: 0x16 briefly during signal, 0x00 after Slave clears

---

## Part 6: Decision Matrix

### What Should We Do First?

| Option | Effort | Risk | Gain | Recommendation |
|--------|--------|------|------|----------------|
| **A. Shadow path only** | 1 hour | Low | Diagnostic | **Start here** |
| B. Shadow + Slave timing | 2 hours | Low | Timing data | After A works |
| C. Conditional switch | 4-8 hours | Medium | Safe parallel | After B measured |
| D. Full activation | 2 hours | Medium | Performance | Only if C shows >90% hit rate |
| E. 68K micro-opts | 8 hours | Low | 1-2% FPS | Independent track |
| F. VDP interrupts | 2 weeks | High | 30-40% FPS | After D + profiling |

### Recommended Path

```
Week 1: A → B (diagnostic + timing measurement)
        Measure: What's the gap? How consistent?

Week 2: C (implement conditional switch)
        Measure: Slave hit rate, fallback frequency

Week 3: D (full activation if C validated)
        Measure: Actual FPS improvement

Week 4+: E → F (additional optimizations based on measured gains)
```

### Realistic FPS Expectations

| Scenario | Expected Gain | Rationale |
|----------|---------------|-----------|
| Slave offload alone | 10-20% | 68K still blocks on other COMM ops |
| + Reduced 68K blocking | 20-40% | Async command submission helps |
| + VDP interrupts | 40-60% | Eliminates 47% cycle waste |
| **Combined best-case** | 50-80% | Requires all tracks optimized |

**Why not 100%?** The 68K is the true bottleneck. Parallelizing SH2 work only helps if it reduces 68K blocking time. Simply making Slave do work doesn't free 68K cycles - the 68K must also stop waiting.

---

## Conclusion

**We have built complete parallel processing infrastructure.** The expansion ROM contains all necessary code for Slave CPU activation. What remains is:

1. **Measuring timing** via shadow path (safe, diagnostic only)
2. **Implementing conditional switch** to safely use Slave results
3. **Validating hit rate** before removing safety checks
4. **Combining with 68K blocking reduction** for maximum gain

The infrastructure is 90% complete. The remaining 10% is **validation and safe activation**, not fire-and-forget. The conditional path ensures we never corrupt rendering, even if Slave falls behind.

**Key insight:** Parallelization alone won't hit 60 FPS. We also need to reduce 68K blocking (Track 3) and VDP polling (Track 1). The combined approach is the path to 60 FPS.

**Immediate next step:** Apply shadow_path_wrapper patch at $022234C8 and verify COMM6 counting works. This is diagnostic-only and carries minimal risk.

---

## Appendix: Key File References

| File | Purpose |
|------|---------|
| [expansion_300000.asm](../disasm/sections/expansion_300000.asm) | Expansion ROM code |
| [object_system.asm](../disasm/modules/68k/game/object_system.asm) | 68K physics functions |
| [HIGH_FREQUENCY_FUNCTIONS.md](../disasm/modules/68k/game/HIGH_FREQUENCY_FUNCTIONS.md) | 68K optimization targets |
| [sh2_communication.asm](../disasm/modules/68k/sh2/sh2_communication.asm) | COMM protocol |
| [ARCHITECTURAL_BOTTLENECK_ANALYSIS.md](ARCHITECTURAL_BOTTLENECK_ANALYSIS.md) | Root cause analysis |
| [68K_FUNCTION_REFERENCE.md](68K_FUNCTION_REFERENCE.md) | 503+ named functions |
| [SH2_3D_PIPELINE_ARCHITECTURE.md](sh2-analysis/SH2_3D_PIPELINE_ARCHITECTURE.md) | SH2 pipeline docs |
