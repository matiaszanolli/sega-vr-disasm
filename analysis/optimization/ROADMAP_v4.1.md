# Roadmap v4.1: Parallel Processing Activation & Validation

**Created:** 2026-01-26
**Status:** Active Development Plan
**Goal:** Activate v4.0 parallel processing infrastructure and validate performance gains

---

## Executive Summary

**Current Reality:**
- ✅ v4.0 infrastructure complete: Parameter passing, trampolines, Slave dispatch code ready
- ✅ 4MB ROM builds and boots successfully
- ✅ 1MB SH2 expansion space ($300000-$3FFFFF) allocated and functional
- ❌ **BLOCKER 1:** PicoDrive latest build broken - no profiling/debugging capability
- ❌ **BLOCKER 2:** Need safe trampolining mechanism to 4th MB ROM (SH2-only space)
- ⚠️ **RISK:** Timing validation not yet performed - frame synchronization concerns

**Strategic Approach:**
1. **Fix profiling capability** (investigate PicoDrive/MAME SH2 core)
2. **Implement safe trampolining** to 4th MB expansion space
3. **Validate timing** with shadow path testing
4. **Activate live parallel processing** with performance measurement
5. **Optimize and iterate** based on empirical results

**Expected Outcome:** Measured FPS improvement from true parallel vertex transform execution (Master + Slave SH2)

---

## Phase 1: Restore Profiling Capability

**Duration:** 1-2 weeks
**Priority:** CRITICAL (blocks all performance validation)
**Risk:** Medium (tooling/infrastructure work)

### Problem Statement

Latest PicoDrive build is broken, preventing:
- GDB-based profiling
- Performance measurement
- Timing validation
- Debugging of v4.0 parallel processing code

**User observation:** "The latest build of Picodrive is still broken. We may need to do some fix on the SH2 core hook (is shared by MAME, we may get good docs there)."

### Tasks

#### 1.1: Investigate PicoDrive SH2 Core Issue

**Goal:** Understand what's broken in latest PicoDrive build

**Steps:**
1. Test system PicoDrive vs latest custom build
   ```bash
   picodrive build/vr_rebuild.32x                    # System version
   ./path/to/latest/picodrive build/vr_rebuild.32x   # Latest build
   ```
2. Document exact failure mode:
   - Boot failure vs runtime crash?
   - Black screen vs incorrect graphics?
   - Error messages in console?
3. Bisect PicoDrive commits to find regression
4. Review changelog for SH2 core changes

**Deliverable:** `analysis/profiling/PICODRIVE_SH2_CORE_INVESTIGATION.md`

#### 1.2: Research MAME SH2 Core Documentation

**Goal:** Understand SH2 core architecture shared between PicoDrive and MAME

**Steps:**
1. Locate MAME SH2 core source code
   - MAME GitHub: https://github.com/mamedev/mame
   - Search for `sh2` or `hitachi` CPU cores
2. Review SH2 emulation implementation:
   - Instruction decoder
   - Memory access hooks
   - Cache behavior
   - Interrupt handling
3. Compare with PicoDrive SH2 implementation
4. Identify potential compatibility issues with v4.0 code

**Resources:**
- MAME SH2 documentation
- Hitachi SH7095 hardware manual
- PicoDrive source code (cpu/sh2/)

**Deliverable:** `analysis/profiling/MAME_SH2_CORE_ANALYSIS.md`

#### 1.3: Evaluate Alternative Profiling Approaches

**Goal:** Establish working profiling capability (fallback if PicoDrive unfixable)

**Options:**

**Option A: Fix PicoDrive SH2 Core**
- Patch latest build with targeted fix
- Submit upstream PR if possible
- **Pros:** Best debugging experience, GDB integration
- **Cons:** Requires C/C++ debugging skills, time-intensive

**Option B: Use System PicoDrive (No Debug)**
- Accept limited profiling via cycle counting in code
- Inject telemetry code (COMM register counters)
- **Pros:** Works today, no external dependencies
- **Cons:** Coarse-grained measurements, invasive code

**Option C: MAME Debugger**
- Use MAME's built-in debugger for SH2
- Learn MAME debugging commands
- **Pros:** Official support, well-documented
- **Cons:** Different workflow, may lack PicoDrive-specific features

**Option D: Cycle-Accurate Logging**
- Add cycle counters to ROM code
- Output telemetry via COMM registers
- Capture in post-processing script
- **Pros:** Platform-independent, precise
- **Cons:** ROM modifications, manual analysis

**Decision Point:** Choose approach based on investigation results

**Deliverable:** `analysis/profiling/PROFILING_STRATEGY_v4.1.md`

#### 1.4: Validate Profiling Setup

**Goal:** Confirm working profiling capability for v4.0 validation

**Success Criteria:**
- Can measure SH2 cycle counts per function
- Can trace Master/Slave execution
- Can verify COMM register timing
- Can measure frame-to-frame timing

**Test Plan:**
1. Profile baseline ROM (v3.0 without parallel processing)
2. Measure known hotspots (func_021, func_016)
3. Verify COMM protocol timing
4. Document profiling workflow

**Deliverable:** Working profiling setup + documentation

### Milestone: Phase 1 Complete

**Success Criteria:**
- ✅ Profiling capability restored (via PicoDrive fix OR alternative)
- ✅ Can measure cycle counts and timing
- ✅ Ready to validate v4.0 parallel processing performance

**Go/No-Go Decision:** Proceed to Phase 2 only if profiling works

---

## Phase 2: Safe Trampolining to 4th MB

**Duration:** 1-2 weeks
**Priority:** HIGH (enables expansion ROM code execution)
**Risk:** Medium (requires SH2 assembly expertise)

### Problem Statement

Need safe mechanism to call SH2 code in expansion ROM ($300000-$3FFFFF) from main ROM ($000000-$2FFFFF).

**Current constraints:**
- Expansion ROM maps to SH2 address $02300000-$023FFFFF
- Must use relative branches (BSR.W has ±32KB limit)
- OR use absolute calls with careful addressing
- Must preserve cache coherency
- Must work on both Master and Slave SH2

**User requirement:** "We still need a safe way to trampoline or safely move to logic in the new 4th MB of the ROM (only for SH2 usage)."

### Tasks

#### 2.1: Design Trampoline Architecture

**Goal:** Safe calling convention for expansion ROM functions

**Approach Options:**

**Option A: Absolute JSR via Register**
```asm
; In main ROM ($02xxxxxx range):
MOV.L   #func_in_expansion,R0    ; Load absolute address
JSR     @R0                        ; Jump to expansion ROM
NOP                                ; Delay slot

; In expansion ROM ($02300000+ range):
func_in_expansion:
    ; ... function body ...
    RTS
    NOP
```

**Option B: Function Pointer Table**
```asm
; In main ROM, create function table:
expansion_funcs:
    dc.l    $02300000    ; func_021_optimized
    dc.l    $02300100    ; slave_work_wrapper
    dc.l    $02300200    ; other_func

; Call via table:
MOV.L   @(expansion_funcs,R0),R1  ; Load func address
JSR     @R1                        ; Call
NOP
```

**Option C: Trampoline Stubs in Main ROM**
```asm
; Small stub in main ROM:
call_expansion_func:
    MOV.L   #$02300000,R0
    JSR     @R0
    NOP
    RTS
    NOP

; Main code just calls stub:
BSR.W   call_expansion_func
```

**Decision Criteria:**
- Code size overhead
- Performance impact (cycles)
- Maintainability
- Cache behavior

**Deliverable:** `analysis/architecture/EXPANSION_ROM_TRAMPOLINE_DESIGN.md`

#### 2.2: Implement Trampoline Infrastructure

**Goal:** Working trampoline code for expansion ROM calls

**Steps:**

1. **Create trampoline utility functions** in main ROM
2. **Update expansion ROM layout** with proper entry points
3. **Test basic call chain**:
   - Main ROM → Trampoline → Expansion ROM → Return
4. **Verify cache coherency** (use cache-through addressing if needed)

**Test Code:**
```asm
; In expansion ROM ($300000 file offset, $02300000 SH2 addr):
test_expansion_func:
    MOV     #42,R0        ; Return value = 42
    RTS
    NOP

; In main ROM:
test_trampoline:
    BSR     call_expansion_func    ; Via trampoline
    CMP/EQ  #42,R0                 ; Verify return value
    BT      test_passed
    ; ... handle failure ...
test_passed:
    RTS
    NOP
```

**Success Criteria:**
- ✅ Can call expansion ROM functions from main ROM
- ✅ Parameters passed correctly
- ✅ Return values received correctly
- ✅ No crashes or hangs
- ✅ Works on both Master and Slave SH2

**Deliverable:** Updated ROM with working trampoline infrastructure

#### 2.3: Migrate v4.0 Code to Expansion ROM

**Goal:** Move parallel processing code to expansion space using trampolines

**Steps:**

1. **Relocate functions** from main ROM to expansion ROM:
   - `func_021_optimized` → $300100
   - `slave_work_wrapper` → $300200
   - `slave_test_func` → $300280
   - Other parallel processing code

2. **Update call sites** to use trampolines:
   - `func_021` trampoline → calls expansion ROM version
   - Slave dispatch → calls expansion ROM work wrapper

3. **Update memory map documentation**:
   ```
   Expansion ROM Layout ($300000-$3FFFFF):
   $300000-$300027   Reserved
   $300028-$30003F   handler_frame_sync (18B)
   $300040-$30004F   Reserved
   $300050-$30007B   master_dispatch_hook (44B)
   $300080-$3000FF   Trampoline infrastructure
   $300100-$30015F   func_021_optimized (96B)
   $300200-$30024B   slave_work_wrapper (76B)
   $300280-$3002AB   slave_test_func (44B)
   $3002AC-$3FFFFF   Available (1MB - 684 bytes)
   ```

4. **Test migration**:
   - ROM boots successfully
   - No regression in v3.0 functionality
   - v4.0 infrastructure still intact

**Deliverable:** ROM with v4.0 code in expansion space

#### 2.4: Document Expansion ROM Usage Guidelines

**Goal:** Clear guidelines for future expansion ROM development

**Contents:**

1. **Address Allocation Policy**
   - How to allocate space in expansion ROM
   - Alignment requirements
   - Reserved vs available regions

2. **Calling Convention**
   - How to call expansion ROM functions
   - Parameter passing (registers vs memory)
   - Return value conventions

3. **Build Integration**
   - How to add new functions to expansion ROM
   - Assembler directives (`org`, `dc.w`, etc.)
   - Build validation steps

4. **Debugging Techniques**
   - How to debug expansion ROM code
   - Profiling considerations
   - Common pitfalls

**Deliverable:** `docs/EXPANSION_ROM_DEVELOPMENT_GUIDE.md`

### Milestone: Phase 2 Complete

**Success Criteria:**
- ✅ Safe trampoline mechanism implemented and tested
- ✅ v4.0 code migrated to expansion ROM
- ✅ ROM builds and boots successfully
- ✅ No regression in existing functionality
- ✅ Ready for timing validation

---

## Phase 3: Timing Validation & Synchronization

**Duration:** 1-2 weeks
**Priority:** HIGH (safety-critical before live activation)
**Risk:** MEDIUM (race conditions, frame sync issues)

### Problem Statement

**Current concern:** v4.0 parallel processing is non-blocking by design (Master returns immediately after signaling Slave). This creates timing risks:

1. **Race condition:** Slave might not finish before next frame
2. **Data corruption:** Master might overwrite parameters before Slave reads them
3. **Synchronization:** How do we know when Slave work completes?

**Goal:** Validate timing assumptions and implement safe synchronization

### Tasks

#### 3.1: Shadow Path Timing Analysis

**Goal:** Measure Slave execution time vs frame budget

**Approach:**

1. **Instrument Slave code** with cycle counters:
   ```asm
   slave_test_func:
       MOV.L   @(SH2_FREE_RUNNING_TIMER),R0  ; Start time
       MOV.L   R0,@(timer_start)

       ; ... actual work (func_021_optimized) ...

       MOV.L   @(SH2_FREE_RUNNING_TIMER),R0  ; End time
       MOV.L   R0,@(timer_end)

       ; Calculate duration, write to COMM5
       ...
   ```

2. **Run profiling test**:
   - Execute 1000 frames
   - Capture Slave execution times
   - Analyze distribution (min, max, average, p99)

3. **Compare to frame budget**:
   - NTSC frame: 958,333 cycles @ 23 MHz
   - PAL frame: 1,150,000 cycles @ 23 MHz
   - Does Slave finish within budget?

**Success Criteria:**
- Slave execution time < 80% of frame budget (safety margin)
- No timing violations across 1000 frames
- Predictable, consistent timing

**Deliverable:** `analysis/profiling/SLAVE_TIMING_VALIDATION.md`

#### 3.2: Design Synchronization Protocol

**Goal:** Safe Master ↔ Slave synchronization

**Options:**

**Option A: Completion Flag (Simple)**
```
1. Master writes params → COMM7 = $16 → returns
2. Slave reads COMM7 = $16 → processes work → COMM7 = $00
3. Master polls COMM7 = $00 before next frame
```
**Pros:** Simple, deterministic
**Cons:** Blocking (removes parallelism benefit if Slave slow)

**Option B: Double Buffering (Complex)**
```
1. Two parameter blocks: A ($2203E000) and B ($2203E020)
2. Master writes to A → COMM7 = $16A → returns
3. Next frame: Master writes to B → COMM7 = $16B → returns
4. Slave alternates reading A/B based on COMM7 flag
```
**Pros:** True parallelism, no blocking
**Cons:** Complex, requires careful state management

**Option C: Work Queue (Advanced)**
```
1. Circular buffer in SDRAM (e.g., 16 slots)
2. Master enqueues work items
3. Slave dequeues and processes
4. Completion tracked via read/write pointers
```
**Pros:** Maximum throughput, handles load spikes
**Cons:** Most complex, cache coherency challenges

**Decision:** Start with Option A (simple), migrate to Option B if timing validates parallelism benefit

**Deliverable:** `analysis/architecture/SYNC_PROTOCOL_DESIGN_v4.1.md`

#### 3.3: Implement Frame Synchronization

**Goal:** Ensure Slave completes before frame boundary

**Implementation:**

1. **Add completion signaling**:
   ```asm
   ; Slave side:
   slave_test_func:
       ; ... do work ...
       MOV.W   #$0000,@COMM7    ; Signal completion
       RTS
       NOP
   ```

2. **Add Master-side check** (in V-INT or frame loop):
   ```asm
   frame_wait_slave:
       MOV.W   @COMM7,R0
       CMP/EQ  #$0000,R0
       BF      frame_wait_slave  ; Loop until Slave done
       ; ... proceed with next frame ...
   ```

3. **Test synchronization**:
   - Run extended gameplay (10+ minutes)
   - Monitor COMM7 state transitions
   - Verify no deadlocks or race conditions

**Success Criteria:**
- ✅ Slave always completes before next frame
- ✅ No visual glitches or corruption
- ✅ Stable over extended play sessions

**Deliverable:** ROM with validated frame synchronization

#### 3.4: Validate Parameter Passing Integrity

**Goal:** Confirm parameters not corrupted during parallel execution

**Test Plan:**

1. **Inject known test values**:
   ```asm
   ; Master writes test pattern:
   MOV.L   #$DEADBEEF,R14
   MOV.L   #$CAFEBABE,R7
   MOV.L   #$12345678,R8
   MOV.L   #$ABCDEF00,R5
   BSR     func_021_trampoline
   ```

2. **Slave validates values**:
   ```asm
   slave_test_func:
       MOV.L   @($2203E000),R14
       CMP/EQ  #$DEADBEEF,R14
       BF      param_error
       ; ... check R7, R8, R5 ...
   ```

3. **Run stress test**:
   - Execute 10,000 iterations
   - Vary parameter values
   - Log any mismatches

**Success Criteria:**
- ✅ 100% parameter integrity across all tests
- ✅ No memory corruption detected

**Deliverable:** Validated parameter passing mechanism

### Milestone: Phase 3 Complete

**Success Criteria:**
- ✅ Timing validated: Slave completes within frame budget
- ✅ Synchronization protocol implemented and tested
- ✅ Parameter integrity confirmed
- ✅ No race conditions detected
- ✅ Ready for live activation

**Go/No-Go Decision:** Proceed to Phase 4 only if all timing validations pass

---

## Phase 4: Live Activation & Performance Measurement

**Duration:** 1-2 weeks
**Priority:** HIGH (culmination of v4.0 development)
**Risk:** LOW (if Phase 3 validates all assumptions)

### Problem Statement

v4.0 infrastructure is complete, timing validated, but parallel processing still inactive. Time to activate and measure actual performance gains.

### Tasks

#### 4.1: Shadow Path → Live Path Migration

**Goal:** Enable parallel processing in actual game execution

**Current State:**
- func_021 trampoline captures params but doesn't redirect
- Master still executes func_021 directly (blocking)
- Slave receives signal but work is redundant

**Target State:**
- func_021 trampoline captures params and returns immediately
- Master does NOT execute func_021 (delegates to Slave)
- Slave executes func_021_optimized in parallel

**Implementation:**

1. **Update func_021 trampoline** (at $0234C8):
   ```asm
   func_021:
       ; Capture parameters
       MOV.L   R14,@($2203E000)
       MOV.L   R7,@($2203E004)
       MOV.L   R8,@($2203E008)
       MOV.L   R5,@($2203E00C)

       ; Signal Slave
       MOV.W   #$16,@COMM7

       ; CRITICAL CHANGE: Return immediately (was: continue to func_021 body)
       RTS
       NOP
   ```

2. **Verify Master dispatch hook** skips work for COMM7=$16:
   - Already implemented in v4.0 at $300050
   - Should verify no regression

3. **Test activation**:
   - Boot ROM
   - Play game for 5 minutes
   - Check COMM5 counter increments (+101 per transform)
   - Verify graphics render correctly

**Success Criteria:**
- ✅ ROM boots and plays correctly
- ✅ COMM5 counter increments (proves Slave executing)
- ✅ Graphics correct (proves results consumed)
- ✅ No crashes or hangs

**Deliverable:** ROM with live parallel processing activated

#### 4.2: Performance Measurement

**Goal:** Measure actual FPS improvement from parallel processing

**Baseline:**
- v3.0 ROM: ~24 FPS (sequential, Master-only)
- v4.0 ROM (shadow path): ~24 FPS (infrastructure overhead only)

**Measurement Approach:**

**Method 1: FPS Counter Injection**
```bash
python3 tools/inject_fps_counter.py build/vr_rebuild.32x
```
- Injects visual FPS display
- Measure average FPS over 5-minute session
- Record min/max/average

**Method 2: Frame Time Logging**
```asm
; In V-INT handler:
v_int_handler:
    MOV.L   @(frame_counter),R0
    ADD     #1,R0
    MOV.L   R0,@(frame_counter)
    ; ... existing code ...
```
- Count frames over fixed real-time period
- Calculate FPS = frames / time

**Method 3: Profiling (if Phase 1 succeeded)**
- Use GDB to measure cycle counts
- Compare Master-only vs Master+Slave
- Calculate theoretical max FPS

**Metrics to Collect:**
- **Average FPS** (1 min, 5 min, 10 min sessions)
- **Frame time distribution** (histogram)
- **CPU utilization** (Master vs Slave)
- **COMM5 counter** (work items processed)
- **Visual quality** (subjective: glitches, tearing, etc.)

**Deliverable:** `analysis/profiling/V4.0_PERFORMANCE_RESULTS.md`

#### 4.3: Regression Testing

**Goal:** Ensure no bugs introduced by activation

**Test Plan:**

1. **Boot Test**
   - ROM boots to title screen
   - No black screen or hang

2. **Gameplay Test**
   - All game modes playable
   - Controls responsive
   - Sound works

3. **Graphics Test**
   - 3D rendering correct
   - No visual artifacts
   - Polygon transforms accurate

4. **Stability Test**
   - Play for 30+ minutes
   - No crashes
   - No memory leaks (COMM counters don't overflow)

5. **Comparison Test**
   - Side-by-side with v3.0 ROM
   - Visual quality equivalent or better
   - Performance improvement visible

**Success Criteria:**
- ✅ All tests pass
- ✅ No regression vs v3.0
- ✅ Measurable performance improvement

**Deliverable:** Test report with pass/fail status

#### 4.4: Documentation Update

**Goal:** Update all documentation to reflect live v4.0 status

**Files to Update:**

1. `analysis/architecture/MASTER_SLAVE_ANALYSIS.md`
   - Status: "INFRASTRUCTURE READY" → "OPERATIONAL"
   - Add performance measurement data
   - Update revision history

2. `analysis/68k-reverse-engineering/68K_PARALLEL_PROCESSING_ARCHITECTURE.md`
   - Remove "THEORETICAL" labels
   - Add empirical performance data
   - Document any discoveries

3. `OPTIMIZATION_PLAN.md`
   - Update Track 2 (Slave CPU Activation) status
   - Add achieved FPS gains
   - Adjust timeline based on results

4. `CLAUDE.md`
   - Update "Current Development Status"
   - Add v4.1 activation milestone
   - Update "What's Working" section

**Deliverable:** Updated documentation suite

### Milestone: Phase 4 Complete

**Success Criteria:**
- ✅ v4.0 parallel processing LIVE and OPERATIONAL
- ✅ Performance improvement measured and documented
- ✅ No regressions detected
- ✅ Documentation updated
- ✅ Ready for optimization iterations

---

## Phase 5: Optimization & Iteration

**Duration:** 2-4 weeks (ongoing)
**Priority:** MEDIUM (incremental gains)
**Risk:** LOW (refinement, not architectural changes)

### Goal

Maximize performance gains from parallel processing through targeted optimizations.

### Tasks

#### 5.1: Profiling-Driven Optimization

**Goal:** Identify and fix performance bottlenecks in v4.0 code

**Steps:**

1. **Profile Master SH2**:
   - Where is time spent now?
   - New hotspots after offloading func_021?
   - Synchronization overhead?

2. **Profile Slave SH2**:
   - Is func_021_optimized optimal?
   - Cache misses?
   - Memory access patterns?

3. **Profile COMM protocol**:
   - Signaling overhead
   - Polling vs interrupt efficiency

4. **Optimize based on data**:
   - Inline hot functions
   - Unroll loops
   - Optimize memory layout
   - Reduce cache misses

**Deliverable:** `analysis/profiling/V4.1_OPTIMIZATION_ANALYSIS.md`

#### 5.2: Load Balancing

**Goal:** Distribute work optimally between Master and Slave

**Current State:**
- func_021 vertex transforms → Slave
- Everything else → Master

**Optimization Opportunities:**

1. **Parallelize more functions**:
   - func_016 (if not already inlined in func_021_optimized)
   - Other 3D pipeline stages
   - Physics calculations
   - Collision detection

2. **Dynamic load balancing**:
   - Monitor CPU utilization
   - Shift work between CPUs based on load
   - Avoid Slave starvation or overload

3. **Pipeline parallelism**:
   - Master processes frame N
   - Slave processes frame N-1 transforms
   - Double buffering (Phase 3, Option B)

**Deliverable:** Optimized work distribution

#### 5.3: Cache Optimization

**Goal:** Minimize cache misses for maximum throughput

**Techniques:**

1. **Data layout optimization**:
   - Align structures to cache lines
   - Group frequently-accessed data
   - Separate read-only from read-write

2. **Code placement**:
   - Hot functions in fast memory
   - Consider cache-through vs cached addressing

3. **Prefetching**:
   - Prefetch next vertex data
   - Overlap memory access with computation

**Deliverable:** Cache-optimized code

#### 5.4: Advanced Synchronization

**Goal:** Migrate to double-buffering or work queue (from Phase 3)

**If Phase 4 shows Slave completes well before frame deadline:**

→ Implement Option B (double buffering) or Option C (work queue)
→ Remove Master blocking on Slave completion
→ Achieve true parallelism

**If Phase 4 shows Slave barely meets frame deadline:**

→ Keep simple synchronization (Option A)
→ Focus on optimizing Slave execution time
→ Re-evaluate after optimization

**Deliverable:** Advanced synchronization if justified by timing data

### Milestone: Phase 5 Outcomes

**Target:**
- v4.1 optimized ROM achieving maximum possible FPS from dual-SH2 parallelism
- Documented optimization techniques
- Knowledge base for future 32X development

---

## Success Metrics & Go/No-Go Criteria

### Phase 1: Profiling Capability

**Go Criteria:**
- ✅ Can measure SH2 cycle counts
- ✅ Can trace Master/Slave execution
- ✅ Can validate COMM timing

**No-Go Fallback:**
- Use cycle-accurate logging in ROM
- Proceed with coarse-grained measurements

### Phase 2: Trampolining

**Go Criteria:**
- ✅ Can call expansion ROM from main ROM
- ✅ Parameters passed correctly
- ✅ No crashes

**No-Go Fallback:**
- Keep v4.0 code in main ROM (limits future expansion)
- Defer expansion ROM usage to later phase

### Phase 3: Timing Validation

**Go Criteria:**
- ✅ Slave completes within frame budget (< 80% frame time)
- ✅ No race conditions
- ✅ Parameter integrity 100%

**No-Go Fallback:**
- DO NOT ACTIVATE live parallel processing
- Re-optimize Slave code
- Revisit synchronization design
- **Worst case:** Defer v4.0 activation, focus on other optimizations (VDP interrupts, 68K sync)

### Phase 4: Live Activation

**Go Criteria:**
- ✅ Measured FPS improvement (any gain is success)
- ✅ No visual regression
- ✅ Stable gameplay

**No-Go Fallback:**
- Deactivate parallel processing
- Analyze failure mode
- Return to Phase 3 or Phase 2

### Phase 5: Optimization

**No hard criteria** - continuous improvement phase

---

## Risk Mitigation

### Technical Risks

**Risk 1: PicoDrive unfixable**
- **Mitigation:** Have 3 fallback profiling options (MAME, cycle logging, system PicoDrive)
- **Impact:** LOW (can proceed with any profiling method)

**Risk 2: Trampolining fails**
- **Mitigation:** Keep v4.0 code in main ROM as backup
- **Impact:** MEDIUM (limits future expansion, but v4.0 still works)

**Risk 3: Slave too slow (misses frame deadline)**
- **Mitigation:** Optimize Slave code (Phase 5), or revert to sequential
- **Impact:** HIGH (blocks v4.0 activation)

**Risk 4: Race conditions / data corruption**
- **Mitigation:** Extensive validation in Phase 3, simple sync protocol
- **Impact:** CRITICAL (data corruption unacceptable)

### Process Risks

**Risk 5: Timeline slippage**
- **Mitigation:** Phases are independent; can re-sequence if needed
- **Impact:** LOW (no external deadlines)

**Risk 6: Scope creep**
- **Mitigation:** Stick to phase goals; defer "nice-to-haves" to Phase 5
- **Impact:** LOW (well-defined phases)

---

## Timeline & Milestones

| Phase | Duration | Start | End | Deliverable |
|-------|----------|-------|-----|-------------|
| Phase 1: Profiling | 1-2 weeks | Week 1 | Week 2 | Working profiling setup |
| Phase 2: Trampolining | 1-2 weeks | Week 3 | Week 4 | v4.0 code in expansion ROM |
| Phase 3: Validation | 1-2 weeks | Week 5 | Week 6 | Timing validated, sync working |
| Phase 4: Activation | 1-2 weeks | Week 7 | Week 8 | Live v4.0, FPS measured |
| Phase 5: Optimization | 2-4 weeks | Week 9 | Week 12 | Optimized v4.1 ROM |

**Total Duration:** 8-12 weeks (2-3 months)

**Key Milestones:**
- **Week 2:** Profiling working (CRITICAL PATH)
- **Week 4:** Expansion ROM callable
- **Week 6:** GO/NO-GO on v4.0 activation
- **Week 8:** v4.0 LIVE (if Phase 3 passed)
- **Week 12:** v4.1 optimized

---

## Open Questions

### Phase 1

1. What exactly is broken in latest PicoDrive build?
   - Boot failure, runtime crash, incorrect emulation?
2. Is the SH2 core issue shared with MAME?
   - Can we leverage MAME fixes?
3. Which profiling approach to use if PicoDrive unfixable?

### Phase 2

1. Which trampoline architecture to use?
   - Absolute JSR, function table, or stubs?
2. Should we relocate ALL v4.0 code or just critical functions?
3. What alignment/padding is needed in expansion ROM?

### Phase 3

1. What is actual Slave execution time for func_021_optimized?
2. Does Slave meet frame budget with margin?
3. Which synchronization protocol: simple flag, double-buffer, or queue?

### Phase 4

1. What is measured FPS improvement?
   - 24 → 30 FPS? 24 → 40 FPS? 24 → 48 FPS?
2. Are there visual artifacts or regressions?
3. What is CPU utilization distribution?

### Phase 5

1. What are new bottlenecks after v4.0 activation?
2. What other functions can be parallelized?
3. What is maximum achievable FPS with dual-SH2?

---

## Next Steps (Immediate)

### This Session

1. ✅ Create ROADMAP_v4.1.md (this document)
2. ⏳ Update OPTIMIZATION_PLAN.md with v4.0 status and roadmap reference
3. ⏳ Commit changes to repository

### Next Session

1. **Start Phase 1, Task 1.1:** Test PicoDrive builds
   ```bash
   # System PicoDrive
   picodrive build/vr_rebuild.32x

   # Latest custom build (if available)
   ./path/to/latest/picodrive build/vr_rebuild.32x
   ```

2. **Document failure mode** if latest build broken

3. **Research MAME SH2 core**:
   ```bash
   git clone https://github.com/mamedev/mame.git
   cd mame
   find . -name "*sh2*" -o -name "*hitachi*"
   ```

4. **Create profiling investigation document**

---

## Approval & Commitment

**This roadmap addresses the user's specific requirements:**

1. ✅ "PicoDrive is still broken" → Phase 1 investigates and provides alternatives
2. ✅ "Need safe way to trampoline to 4th MB" → Phase 2 designs and implements
3. ✅ "Timing validation before activation" → Phase 3 validates all assumptions
4. ✅ "Measure actual performance" → Phase 4 activates and measures FPS

**Strategic approach:**
- **Phase-based** with clear go/no-go criteria
- **Risk-managed** with fallback options
- **Data-driven** (profile, measure, validate)
- **Incremental** (test each phase before proceeding)

**Ready for execution.** ✅

---

**Next:** Update OPTIMIZATION_PLAN.md to reference this roadmap and current v4.0 status.
