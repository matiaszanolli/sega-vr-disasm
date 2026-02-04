# Virtua Racing 32X - Optimization Strategy

**Status:** Strategic plan approved
**Baseline:** 24 FPS (current measured performance)
**Target:** 60 FPS (+150%)
**Approach:** Data-driven, systematic, high-impact parallelization

## Executive Summary

After comprehensive codebase analysis, we've identified three high-impact optimization tracks:

1. **VDP Polling Elimination** → +30-40% FPS (medium risk)
2. **Slave CPU Activation** → +50-100% FPS (medium risk)
3. **68000 Sync Optimization** → +10-15% FPS (low risk)

**Combined potential:** 24 FPS → 48-72 FPS

**Critical learning:** func_065 FIFO batching is impossible (fall-through design). We've documented this failure and will not pursue it.

### v4.0 Parallel Processing Update (2026-01-26)

**Major Development:** Slave CPU activation infrastructure (v4.0) is **COMPLETE** but **NOT YET ACTIVATED**.

**What's Ready:**
- ✅ Parameter capture trampoline at $0234C8 (func_021)
- ✅ Shared memory parameter block at $2203E000 (SDRAM)
- ✅ Master dispatch hook at $300050 (skips work for COMM7=$16)
- ✅ Slave work dispatcher at $300200 (command routing)
- ✅ func_021_optimized at $300100 (vertex transform with func_016 inlined)
- ✅ 4MB ROM builds successfully with 1MB expansion space ($300000-$3FFFFF)

**Current Blockers:**
1. ❌ PicoDrive latest build broken (no profiling/debugging capability)
2. ❌ Need safe trampolining mechanism to 4th MB expansion ROM (SH2-only)
3. ⚠️ Timing validation required before live activation (frame sync concerns)

**Next Steps:**
→ See [ROADMAP_v4.1.md](analysis/optimization/ROADMAP_v4.1.md) for detailed activation plan

**Impact on Track 2 (Slave CPU Activation):**
- Infrastructure complete (Phases 1-3 of original plan done)
- Activation deferred pending profiling capability and timing validation
- Expected FPS gain remains +50-100% once activated

---

## Current State Analysis

### Baseline Performance

| Metric | Value | Source |
|--------|-------|--------|
| Current FPS | 24 | Measured |
| Frame budget | 958,333 cycles | 23 MHz / 24 FPS |
| Master SH2 usage | 36.5% | Previous analysis |
| Slave SH2 usage | 0.03% | Previous analysis |
| 68000 sync overhead | 16.5% | Estimated |

### Bottleneck Distribution

| Category | Cycles/Frame | % of Budget | Potential Gain |
|----------|--------------|-------------|----------------|
| VDP polling | ~450,000 | 47% | **HIGH** |
| 68000 sync | ~158,000 | 16.5% | Medium |
| func_065 | ~42,000 | 4.4% | ~~Abandoned~~ |
| Slave CPU idle | ~950,000 | 99%+ | **VERY HIGH** |
| Other | Variable | ~32% | Unknown |

### Functions Analyzed

| Function | Address | Calls | Status | Optimization |
|----------|---------|-------|--------|--------------|
| 0x022B58 | ROM | 36× | ⚠️ Partial | TBD (needs decoder) |
| 0x021B2C | ROM | 19× | ❌ Not analyzed | TBD |
| 0x0203D8 | ROM | 18× | ✅ Documented | Low priority (~0.3%) |
| 0x023F2E | ROM | 17× | ✅ Complete | ❌ Untouchable |

**Documentation coverage:** 3/710 functions (0.4%)

---

## Optimization Philosophy

### Core Principles

1. ✅ **Profile before coding** - Use GDB to get empirical data
2. ✅ **Understand before optimizing** - Document function purpose first
3. ✅ **Test incrementally** - One change at a time, verify each step
4. ✅ **Focus on big wins** - 80/20 rule: 20% effort for 80% gain
5. ✅ **Document failures** - Learn from what doesn't work

### Risk Assessment Framework

**Low Risk:**
- Changes to non-timing-critical code
- Well-understood functions
- Easy to revert
- **Example:** 68000 sync optimization

**Medium Risk:**
- Architectural changes (interrupts vs polling)
- Multi-CPU coordination
- Hardware timing changes
- **Example:** VDP interrupt-driven, Slave CPU activation

**High Risk:**
- Modifying fall-through functions
- Cache-sensitive code
- Initialization sequence changes
- **Example:** func_065 (abandoned)

### Success Criteria

**Must have:**
- ROM boots successfully
- Gameplay is playable
- Graphics render correctly
- FPS measured improvement

**Nice to have:**
- Equivalent or better visual quality
- No introduced bugs
- Maintainable code

---

## Optimization Tracks

### Track 1: VDP Polling Elimination 🔥 **HIGH PRIORITY**

**Goal:** Replace busy-wait polling with interrupt-driven VDP access

**Current state:**
- 4 polling loops waste ~450K cycles/frame (47% of budget!)
- Locations: 0x243E2, 0x2441E, 0x2443A, 0x24482
- Waiting for: V-blank, H-blank, FIFO ready, etc.

**Expected gain:** +30-40% FPS (24 → 31-34 FPS)

**Risk:** Medium (hardware timing changes, **requires SH2 interrupt bug workaround**)

#### SH2 Interrupt Hardware Bug (CRITICAL)

**Why VRD uses polling:** The original SH2 silicon has a documented interrupt bug. See [32x-hardware-manual-supplement-2.md](docs/32x-hardware-manual-supplement-2.md).

**Bug symptoms:**
1. External interrupts (V, H, CMD, PWM) can be missed during acknowledge period
2. Wrong interrupt vector may be taken when multiple interrupts arrive simultaneously

**Required corrective action** (if we implement interrupt-driven rendering):
```asm
vint:
    stc.l   gbr, @-r15
    mov.l   #_sysreg, r0
    ldc     r0, gbr
    mov.l   #h'f0, r0           ; Set interrupt mask
    ldc     r0, sr

    ; FRT TOCR toggle (CRITICAL - fixes hardware bug)
    mov.l   #_FRT, r1           ; h'fffffe10
    mov.b   @ (_TOCR, r1), r0   ; Read TOCR (offset h'07)
    xor     #h'02, r0           ; Toggle bit 1
    mov.b   r0, @ (_TOCR, r1)   ; Write back

    mov.w   r0, @ (vintclr, gbr); Clear interrupt

    ; ... (5+ cycles of processing required before RTE) ...

    ldc.l   @r15+, gbr
    rts
    nop
```

**Additional requirements:**
- SR mask level ≥ 1 (never 0)
- Shared odd/even interrupt vectors (levels 14+15 → same handler)
- Synchronization read-back before RTE to ensure write completion

**Note:** Bug was fixed in EVA chip cut 2.5, but retail 32X units have earlier silicon.

**Phases:**

#### Phase 1: Profile (Week 1) ⏱️ 2-3 days

**Tasks:**
1. Use GDB to identify what each polling loop waits for
2. Measure actual wait times per loop
3. Understand VDP state machine
4. Document current polling pattern

**Deliverables:**
- VDP_POLLING_ANALYSIS.md
- Empirical wait time measurements
- Hardware state documentation

**Tools:**
```bash
python3 gdb_profiler.py vdp_polling  # Create this profile
```

#### Phase 2: Design (Week 1-2) ⏱️ 2-3 days

**Tasks:**
1. Design interrupt handler structure
2. Map VDP interrupts (V-blank, H-blank)
3. Create interrupt service routine (ISR)
4. Plan synchronization with existing code

**Deliverables:**
- VDP_INTERRUPT_DESIGN.md
- ISR pseudocode
- Risk analysis

**Success criteria:**
- Clear interrupt architecture
- No polling in critical path
- Maintains frame timing

#### Phase 3: Implement (Week 2) ⏱️ 3-5 days

**Tasks:**
1. Write V-blank interrupt handler
2. Replace first polling loop with interrupt wait
3. Test on emulator
4. Incrementally convert remaining loops

**Deliverables:**
- Patched ROM with interrupt-driven VDP
- Test results
- Performance measurements

**Success criteria:**
- ROM boots and runs
- FPS improvement measured
- No visual glitches

#### Phase 4: Validate (Week 2-3) ⏱️ 1-2 days

**Tasks:**
1. Stress test (long gameplay sessions)
2. Compare visual quality
3. Measure actual FPS gain
4. Document any issues

**Deliverables:**
- VDP_INTERRUPT_RESULTS.md
- FPS comparison data
- Known issues list

---

### Track 2: Slave CPU Activation 🔥 **VERY HIGH PRIORITY** (v4.0 INFRASTRUCTURE COMPLETE)

**Goal:** Activate idle Slave SH2 and distribute work

**Current state (Updated 2026-01-26):**
- ✅ **v4.0 Infrastructure COMPLETE** (parameter passing, trampolines, dispatch code)
- ⏳ **Activation PENDING** (awaiting profiling capability + timing validation)
- ⏳ Slave CPU still ~99.97% idle (infrastructure ready but not activated)
- ⏳ Master CPU still does all work (v4.0 shadow path validated, live path pending)

**Expected gain:** +50-100% FPS (24 → 36-48 FPS) - **UNCHANGED**

**Risk:** Medium (multi-CPU synchronization, frame timing)

**Status Update:**
- Phases 1-3 below are **COMPLETE** (v4.0 implementation)
- Activation phases now documented in [ROADMAP_v4.1.md](ROADMAP_v4.1.md)
- **Current Blockers:**
  1. PicoDrive debugger broken (no profiling)
  2. Need safe trampolining to 4th MB expansion ROM
  3. Timing validation required

**Original Phases (Completed in v4.0):**

#### Phase 1: Investigation (Week 1) ⏱️ 3-4 days ✅ **COMPLETE**

**Tasks:**
1. ✅ Find Slave CPU entry point
2. ✅ Understand current idle loop
3. ✅ Analyze Master↔Slave communication (COMM registers)
4. ✅ Document synchronization primitives

**Deliverables:**
- ✅ [MASTER_SLAVE_ANALYSIS.md](analysis/architecture/MASTER_SLAVE_ANALYSIS.md)
- ✅ [68K_COMM_PROTOCOL.md](analysis/68k-reverse-engineering/68K_COMM_PROTOCOL.md)
- ✅ [68K_PARALLEL_PROCESSING_ARCHITECTURE.md](analysis/68k-reverse-engineering/68K_PARALLEL_PROCESSING_ARCHITECTURE.md)

#### Phase 2: Work Distribution Design (Week 2) ⏱️ 3-5 days ✅ **COMPLETE**

**Tasks:**
1. ✅ Identify parallelizable work (3D transforms, physics, etc.)
2. ✅ Design work queue system (parameter block + COMM signaling)
3. ✅ Define Master/Slave responsibilities
4. ✅ Plan synchronization points

**Deliverables:**
- ✅ v4.0 Architecture: Master signals Slave via COMM7=$16
- ✅ Parameter block at $2203E000 (R14, R7, R8, R5)
- ✅ Slave dispatch system implemented

**Parallelized work (v4.0):**
- ✅ func_021 vertex transformations (delegated to Slave)
- ⏳ Additional functions deferred to v4.1+ optimization phase

#### Phase 3: Implement Work Queue (Week 2-3) ⏱️ 5-7 days ✅ **COMPLETE**

**Tasks:**
1. ✅ Create parameter passing system in SDRAM
2. ✅ Implement Master producer (func_021 trampoline), Slave consumer (slave_work_wrapper)
3. ✅ Test with real vertex transform workload (func_021_optimized)
4. ✅ Shadow path validated (infrastructure proven)

**Deliverables:**
- ✅ func_021 trampoline at $0234C8 (captures R14, R7, R8, R5)
- ✅ Parameter block at $2203E000 (16 bytes in SDRAM)
- ✅ Slave work wrapper at $300200 (dispatches COMM7=$16 to func_021_optimized)
- ✅ func_021_optimized at $300100 (vertex transform with func_016 inlined)
- ✅ ROM builds and boots successfully

**Success criteria:**
- ✅ Slave dispatch code executes (shadow path validated)
- ⏳ Live activation pending timing validation
- ⏳ Performance measurements pending profiling capability

#### Phase 4: Activation & Validation (Now → Week 8) ⏱️ 6-8 weeks ⏳ **IN PROGRESS**

**Status:** Infrastructure complete, activation pending per [ROADMAP_v4.1.md](ROADMAP_v4.1.md)

**Current Blockers:**
1. ❌ PicoDrive debugger broken (investigating SH2 core issue)
2. ❌ Need safe trampolining to 4th MB expansion ROM
3. ⚠️ Timing validation required (Slave must complete within frame budget)

**Activation Plan:** See [ROADMAP_v4.1.md](ROADMAP_v4.1.md) for detailed phases:
- **Phase 1:** Restore profiling capability (1-2 weeks)
- **Phase 2:** Safe trampolining to expansion ROM (1-2 weeks)
- **Phase 3:** Timing validation & synchronization (1-2 weeks)
- **Phase 4:** Live activation & performance measurement (1-2 weeks)
- **Phase 5:** Optimization iterations (2-4 weeks)

**Expected Deliverables:**
- Working profiling setup (PicoDrive fix or alternative)
- Expansion ROM trampoline infrastructure
- Timing validation report (Slave execution time vs frame budget)
- Live v4.0 ROM with parallel processing activated
- Performance measurements (actual FPS improvement)
- Load balancing optimization (v4.1+)

---

### Track 3: 68000 Sync Optimization ⬆️ **MEDIUM PRIORITY**

**Goal:** Reduce 68000 synchronization overhead

**Current state:**
- 16.5% of frame time spent syncing with 68000
- COMM register polling
- Inefficient handshake protocol

**Expected gain:** +10-15% FPS (24 → 26-28 FPS)

**Risk:** Low (incremental improvements)

**Phases:**

#### Phase 1: Profile (Week 1) ⏱️ 1-2 days

**Tasks:**
1. Map all COMM register accesses
2. Measure sync overhead
3. Identify redundant syncs
4. Document handshake protocol

**Deliverables:**
- 68K_SYNC_ANALYSIS.md
- COMM usage patterns
- Optimization opportunities

#### Phase 2: Optimize (Week 2) ⏱️ 2-3 days

**Tasks:**
1. Batch COMM register operations
2. Eliminate redundant syncs
3. Use interrupts instead of polling
4. Optimize handshake timing

**Deliverables:**
- Optimized sync code
- Test ROM
- Performance comparison

---

### Track 4: Top Function Optimization ⬇️ **LOW PRIORITY**

**Goal:** Optimize most-called functions (0x022B58, etc.)

**Current state:**
- 0x022B58 called 36×/frame (most in ROM!)
- Purpose unknown (decoder incomplete)
- Potential for optimization

**Expected gain:** Unknown (~5-10% estimate)

**Risk:** Medium (depends on function purpose)

**Phases:**

#### Phase 1: Complete Analysis (Week 2) ⏱️ 2-3 days

**Tasks:**
1. Fix SH2 decoder for missing opcodes
2. Fully disassemble 0x022B58
3. Understand purpose from context
4. Profile actual runtime behavior

#### Phase 2: Optimize (Week 3+) ⏱️ Variable

**Tasks:**
- TBD based on analysis results
- Might include: inlining, loop unrolling, register optimization

**Note:** Only pursue if other tracks complete and FPS still below target.

---

## Implementation Timeline

**NOTE (2026-01-26):** Timeline updated to reflect v4.0 completion and current blockers. See [ROADMAP_v4.1.md](ROADMAP_v4.1.md) for detailed activation plan.

### Completed Work (v4.0 Development)

**Slave CPU Investigation & Design:**
- ✅ Set up GDB profiling environment
- ✅ Find Slave CPU entry point
- ✅ Document COMM protocol
- ✅ Design Slave CPU work queue (parameter block + COMM signaling)
- ✅ Implement work distribution infrastructure
- ✅ Create func_021 trampoline (parameter capture)
- ✅ Implement Slave dispatch system
- ✅ Shadow path validation (infrastructure proven)

**Milestone:** ✅ v4.0 infrastructure complete, ROM builds and boots successfully

### Current Phase: Activation Preparation (Week 1-8)

**Week 1-2: Restore Profiling Capability** ⏳ **IN PROGRESS**
- ⏳ Investigate PicoDrive SH2 core issue
- ⏳ Research MAME SH2 core documentation
- ⏳ Evaluate alternative profiling approaches
- ⏳ Validate profiling setup

**Week 3-4: Safe Trampolining to 4th MB**
- ⏳ Design trampoline architecture
- ⏳ Implement trampoline infrastructure
- ⏳ Migrate v4.0 code to expansion ROM
- ⏳ Document expansion ROM usage guidelines

**Week 5-6: Timing Validation & Synchronization**
- ⏳ Shadow path timing analysis
- ⏳ Design synchronization protocol
- ⏳ Implement frame synchronization
- ⏳ Validate parameter passing integrity

**Week 7-8: Live Activation & Measurement**
- ⏳ Shadow path → live path migration
- ⏳ Performance measurement (FPS)
- ⏳ Regression testing
- ⏳ Documentation update

**Milestone:** v4.0 live and operational, FPS improvement measured

### Future: Optimization & Additional Tracks (Week 9+)

**VDP Polling Elimination (Track 1):**
- ⏳ Profile VDP polling loops (requires working profiler)
- ⏳ Design VDP interrupt architecture
- ⏳ Implement interrupt-driven VDP
- ⏳ Measure FPS gain

**68000 Sync Optimization (Track 3):**
- ⏳ Profile 68000 sync overhead
- ⏳ Optimize COMM protocol
- ⏳ Batch operations, reduce polling

**Load Balancing & Optimization (v4.1+):**
- ⏳ Profile work distribution
- ⏳ Balance load between CPUs
- ⏳ Optimize cache usage
- ⏳ Parallelize additional functions

**Milestone:** Combined optimizations → 60 FPS target

---

## Success Metrics

### Quantitative Goals (Updated 2026-01-26)

| Milestone | Target FPS | Cumulative Gain | Track | Status |
|-----------|-----------|-----------------|-------|--------|
| Baseline | 24 | - | - | ✅ Measured |
| **v4.0 Slave CPU active** | **36-48** | **+50-100%** | **Track 2** | **⏳ Pending activation** |
| VDP interrupts | 47-67 | +95-180% | Track 1+2 | ⏳ Planned |
| 68K sync optimized | 52-77 | +115-220% | Track 1+2+3 | ⏳ Planned |
| **Target** | **60+** | **+150%+** | All | ⏳ Goal |

**Note:** Track 2 (Slave CPU) infrastructure complete but not yet activated. FPS gains are projected based on expected 50-100% improvement from parallel processing. Actual gains to be measured upon activation (see [ROADMAP_v4.1.md](ROADMAP_v4.1.md)).

### Qualitative Goals

- ✅ ROM boots reliably
- ✅ Gameplay smooth and responsive
- ✅ Graphics render correctly
- ✅ No introduced bugs
- ✅ Code documented and maintainable

### Minimum Viable Product (MVP)

**Must achieve:**
- 48 FPS (+100%) via VDP + Slave CPU
- Stable gameplay
- No visual regression

**Stretch goals:**
- 60 FPS (+150%)
- Consistent frame pacing
- Further optimization potential identified

---

## Risk Mitigation

### Known Risks (Updated 2026-01-26)

**v4.0 Activation (Current Blockers):**
- **Risk 1:** PicoDrive debugger broken, no profiling capability
  - **Mitigation:** Investigate SH2 core issue, evaluate MAME or alternative profiling
  - **Fallback:** Cycle-accurate logging in ROM code
- **Risk 2:** Trampolining to 4th MB expansion ROM
  - **Mitigation:** Design safe calling convention, test thoroughly
  - **Fallback:** Keep code in main ROM (limits future expansion)
- **Risk 3:** Slave execution time exceeds frame budget
  - **Mitigation:** Extensive timing validation before activation
  - **Fallback:** Deactivate parallel processing, optimize Slave code

**VDP Interrupts (Track 1):**
- **Risk:** Timing-sensitive, might break rendering
- **Mitigation:** Incremental conversion, one loop at a time
- **Fallback:** Keep polling as backup code path

**Slave CPU Synchronization (Track 2):**
- **Risk:** Race conditions, data corruption
- **Mitigation:** Simple completion flag protocol, extensive testing
- **Fallback:** Disable Slave work queue, revert to Master-only

**68000 Sync (Track 3):**
- **Risk:** Breaking existing communication protocol
- **Mitigation:** Profile first, change incrementally
- **Fallback:** Restore original COMM usage

### Testing Strategy

**For each change:**
1. Compile and verify ROM builds
2. Boot test (does it start?)
3. Visual test (graphics correct?)
4. Gameplay test (playable for 5+ minutes?)
5. FPS measurement (actual improvement?)
6. Regression test (no new bugs?)

**Test ROMs:**
- Keep working baseline ROM
- Create test ROM per change
- Compare side-by-side

---

## Tools Required

### Existing ✅
- function_inventory.py
- generate_call_graph.py
- gdb_profiler.py
- Gens emulator with GDB

### To Create ⏳
- VDP profiler (gdb_profiler.py vdp_polling)
- Slave CPU profiler (gdb_profiler.py slave_cpu)
- FPS measurement tool
- Automated ROM testing script

### Nice to Have
- Visual diff tool (compare frame buffers)
- Performance dashboard
- Continuous testing pipeline

---

## Documentation Plan

### Per Track

Each optimization track gets:
1. **_ANALYSIS.md** - Profiling data and understanding
2. **_DESIGN.md** - Implementation plan
3. **_RESULTS.md** - Measurements and outcomes

### Weekly Reports

- Progress update
- FPS measurements
- Issues encountered
- Next week plan

### Final Report

- Complete optimization summary
- Before/after comparison
- Lessons learned
- Future opportunities

---

## Lessons Applied

### From func_065 Failure

1. ✅ **Profile before coding** - Don't guess, measure
2. ✅ **Understand fall-through patterns** - Check for RTS!
3. ✅ **Test minimally first** - Start with NULL patches
4. ✅ **Document failures** - Learn from what doesn't work
5. ✅ **Know when to stop** - Don't waste time on impossible tasks

### From Documentation Phase

1. ✅ **Systematic > ad-hoc** - Follow a plan
2. ✅ **Tools enable analysis** - Invest in good tools
3. ✅ **Call graphs reveal structure** - Use visualization
4. ✅ **Empirical > theoretical** - Runtime data beats guessing

---

## Next Actions (Immediate) - Updated 2026-01-26

### Completed (v4.0 Development)
1. ✅ Create optimization plan (this document)
2. ✅ Find Slave CPU entry point
3. ✅ Analyze Master↔Slave communication
4. ✅ Design and implement parallel processing infrastructure
5. ✅ Document v4.0 architecture

### Current Priority: v4.0 Activation (See ROADMAP_v4.1.md)

**Phase 1: Restore Profiling Capability** ⏳ **IN PROGRESS**
1. Test PicoDrive builds (system vs latest custom)
2. Document exact failure mode
3. Research MAME SH2 core documentation
4. Evaluate alternative profiling approaches
5. Choose profiling strategy

**Phase 2: Safe Trampolining to 4th MB**
1. Design trampoline architecture
2. Implement trampoline infrastructure
3. Migrate v4.0 code to expansion ROM
4. Test call chain (main ROM → expansion ROM)

**Phase 3: Timing Validation**
1. Measure Slave execution time (func_021_optimized)
2. Validate frame budget compliance
3. Implement synchronization protocol
4. Test parameter passing integrity

**Phase 4: Live Activation**
1. Enable live parallel processing
2. Measure actual FPS improvement
3. Regression testing
4. Update documentation

**Deferred Until v4.0 Active:**
- VDP polling elimination (Track 1) - requires working profiler
- 68000 sync optimization (Track 3) - lower priority than v4.0
- Additional function parallelization (v4.1+) - depends on v4.0 results

---

## Approval & Commitment (Updated 2026-01-26)

**Original Timeline:** 4 weeks → **REVISED:** 8-12 weeks (v4.0 activation + optimization)

**Phase Breakdown:**
- **Weeks 1-2:** Restore profiling capability
- **Weeks 3-4:** Implement safe trampolining to expansion ROM
- **Weeks 5-6:** Timing validation & synchronization
- **Weeks 7-8:** v4.0 live activation & measurement
- **Weeks 9-12:** Optimization iterations (VDP, 68K sync, load balancing)

**Expected outcome:**
- **v4.0 alone:** 36-48 FPS (+50-100%) - Slave CPU parallel processing
- **Combined:** 60+ FPS (+150%+) - All tracks optimized

**Risk level:** Medium (v4.0 infrastructure complete, activation risks managed)

**Fallback plan:**
- Keep v3.0 baseline ROM at all times
- v4.0 infrastructure can be deactivated if timing validation fails
- Multiple profiling options if PicoDrive unfixable

**Decision points:**
- **Week 2 end:** Profiling capability restored (GO/NO-GO on v4.0 activation)
- **Week 4 end:** Trampolining working (GO/NO-GO on expansion ROM migration)
- **Week 6 end:** Timing validated (GO/NO-GO on live activation)
- **Week 8 end:** v4.0 FPS measured (decide on additional tracks)
- **Week 12 end:** Final optimization assessment

**Current Focus:** v4.0 activation per [ROADMAP_v4.1.md](ROADMAP_v4.1.md)

**This plan reflects v4.0 completion and current activation priorities.** ✅

---

**Next step:** Investigate PicoDrive SH2 core issue and restore profiling capability (ROADMAP Phase 1).
