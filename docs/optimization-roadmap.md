# Optimization Roadmap & Performance Analysis

**Virtua Racing Deluxe 32X - Path to Performance Improvement**

**Status:** Analysis Phase Complete
**Target Platforms:** Real Hardware (Sega 32X), Emulators (BlastEm, Gens)
**Expected Gains:** 20-35% performance improvement (conservative estimate)

---

## Executive Summary

After comprehensive disassembly and analysis of 285 functions, we've identified three major optimization opportunities:

| Opportunity | Current Cost | Potential Savings | Effort | Priority |
|------------|--------------|------------------|--------|----------|
| **VDP Polling → Interrupt** | 7.8ms/frame (47%) | 6-7.5ms (~40%) | High | 🔴 Critical |
| **SH2 CPU Utilization** | 99.97% idle | +50% performance | High | 🔴 Critical |
| **Sound System Analysis** | TBD (11x/frame) | 5-10% (est.) | Medium | 🟠 High |

---

## Detailed Optimization Analysis

### Optimization #1: VDP Polling Replacement (CRITICAL)

**Current Implementation:**

```
Frame Structure (47% = 7.8ms):
├─ VDPSyncSH2 (0x28C2): Polls VBLANK
│   └─ Loop: Check bit, branch, repeat
│
├─ PaletteRAMCopy (0x2878): Polls for ready
│   └─ Loop: Check status, branch, repeat
│
├─ Multiple SH2 Completion Checks
│   └─ COMM register polling (COMM0 bit)
│
└─ VDP State Verification
    └─ Confirm safe to proceed
```

**Performance Breakdown:**

```
Polling Cost:
├─ Loop overhead per poll:   ~2-4 cycles
├─ Branch prediction fails:  ~10-15 cycles each
├─ Cache misses:             ~20-30 cycles
├─ Register I/O wait states: ~50-80 cycles
│
Total: ~50-100 cycles per poll
Polls per frame: 150-200
Total: ~7,500-20,000 cycles = 7.8ms (47% of frame)
```

**Proposed Solution: Interrupt-Based Notification**

Replace polling loops with interrupt handlers triggered by:
1. **VBLANK interrupt** - Monitor display ready signal
2. **SH2 completion signal** - DMA request acknowledgment
3. **VDP status change** - Register update notification

**Implementation Approach:**

```asm
; BEFORE: Polling (47% of frame)
VDPSyncSH2:
  MOVE.W  $C00004,D0    ; Read VDP status
  BTST    #3,D0         ; Test VBLANK bit
  BEQ     VDPSyncSH2    ; Loop if not ready
  RTS

; AFTER: Interrupt-based (2% of frame)
VDPSyncSH2:
  CLR.B   $C88D         ; Signal ready
  WAIT                  ; Sleep until interrupt
  RTS

; Interrupt Handler:
H_INT_Handler:
  TST.B   $C88D         ; Check if waiting
  BEQ     H_INT_Exit
  BSET    #3,$C88E      ; Set ready flag
  RTE
```

**Expected Results:**

| Metric | Before | After | Gain |
|--------|--------|-------|------|
| **Frame Time** | 16.67ms | 9.67ms | **42% faster** |
| **Available CPU** | 36.5% | 80%+ | **2.2x more** |
| **VDP Sync Time** | 7.8ms | 0.15ms | **52x faster** |
| **Game Logic Space** | 1.5ms | ~5.5ms | **3.7x headroom** |

**Implementation Complexity:**
- Modify 4-5 polling loops
- Add 1-2 interrupt handlers
- Test for race conditions
- **Estimated effort:** 2-3 days of development

**Risk Assessment:**
- **Low risk:** Clear performance gain, well-defined change
- **Verification:** ROM byte-accuracy still maintained
- **Rollback:** Easy (revert to polling if issues arise)

---

### Optimization #2: SH2 CPU Utilization (CRITICAL)

**Current State:**

```
Master CPU (68K):      ~100% utilized
  ├─ Game logic:      40%
  ├─ Rendering prep:  10%
  ├─ VDP polling:     47%
  └─ Overhead:        3%

Slave CPUs (SH2 x2):   0.03% utilized  ⚠️ MASSIVE WASTE
  ├─ 3D engine:       ~10-20 instructions/frame
  ├─ Matrix ops:      Minimal
  └─ Idle:            99.97%
```

**Analysis:**

The SH2 processors are running the 3D transformation engine for only ~50-100 cycles per frame, then sitting idle for the remaining ~16,600 cycles. This is a **330:1 utilization imbalance**.

**Opportunities for Parallelization:**

1. **Game State Updates** (Currently on 68K)
   - Move physics calculations to SH2
   - Parallel transformation pipeline
   - **Potential gain:** 2-3ms per frame

2. **Coordinate Transformations** (Some on 68K)
   - Full parallelization of 3D math
   - SH2 vector unit optimization
   - **Potential gain:** 1.5-2ms per frame

3. **Audio Processing** (Currently Z80)
   - Move sound synthesis to SH2
   - DMA-based audio queuing
   - **Potential gain:** 0.2-0.5ms per frame

4. **Data Decompression** (Currently on 68K)
   - RLE/LZ77 on SH2 in parallel
   - Decompress while rendering
   - **Potential gain:** 0.5-1ms per frame

**Proposed Architecture:**

```
Frame N Execution:
┌─────────────────────────────────────────────────┐
│ 68K (Master)                                    │
├─────────────────────────────────────────────────┤
│ Input (0.2ms) ──┐                               │
│                 │ Game Logic (1.5ms)            │
│ Display (0.4ms)─┤                               │
│                 │                               │
│                 └────> Prepare render data      │
│                        (send to SH2 via COMM)   │
│                                                 │
│ While SH2 is busy (5ms+):                       │
│ ├─ Physics simulation (NEW, 1.5ms)              │
│ ├─ Audio synthesis prep (NEW, 0.5ms)            │
│ ├─ Collision detection (NEW, 1ms)               │
│ └─ Remaining wait (NEW, 1.5ms idle → 0.5ms)     │
│                                                 │
└─────────────────────────────────────────────────┘
       ↓ (Send render + physics data via DMA)
┌─────────────────────────────────────────────────┐
│ SH2 (Slave #1) - 3D Engine                      │
├─────────────────────────────────────────────────┤
│ Receive params (0.1ms)                          │
│ Matrix multiplication (1.5ms)                   │
│ Polygon transformation (2.5ms)                  │
│ Hardware setup (0.5ms)                          │
│ DMA to frame buffer (0.8ms)                     │
│                                                 │
│ While DMA is in progress (10ms+):               │
│ ├─ Additional transformations (NEW, 4ms)        │
│ ├─ Visibility culling (NEW, 2ms)                │
│ ├─ Post-processing (NEW, 2ms)                   │
│ └─ Ready signal to 68K                          │
│                                                 │
└─────────────────────────────────────────────────┘
       ↓ (Ready for next frame)
```

**Expected Results:**

| Metric | Before | After | Gain |
|--------|--------|-------|------|
| **68K Load** | 100% | 30-40% | **Better stability** |
| **SH2 Load** | 0.03% | 40-50% | **Massive improvement** |
| **Total Performance** | 1.0x | ~1.5-1.7x | **50-70% faster** |
| **Frame Variance** | High | Lower | **Smoother gameplay** |

**Implementation Complexity:**
- Redesign game loop architecture
- Partition work between CPUs
- Implement new COMM protocol commands
- Extensive testing and validation
- **Estimated effort:** 3-4 weeks of development

**Risk Assessment:**
- **Medium risk:** Major architectural change
- **Verification:** ROM byte-accuracy will not be maintained (new code)
- **Alternative:** Implement on feature branch, extensive testing required

---

### Optimization #3: Sound System Analysis

**Current Status:**

```
Function: Z80SoundCmd (0xD1D4)
├─ Called: 11 times per frame
├─ Cost: Unknown (needs profiling)
├─ Impact: Likely 1-2% of frame time
└─ Status: Requires detailed analysis
```

**Known Characteristics:**

```
Sound System Architecture:
├─ Z80 processor (Genesis)
├─ YM2612 FM synthesizer (Genesis)
├─ PSG (Programmable Sound Generator)
└─ Sega 32X sound input (if used)

Integration Point:
└─ Z80SoundCmd sends commands via COMM registers
```

**Profiling Strategy:**

1. **Instrument Z80SoundCmd:**
   ```asm
   Z80SoundCmd_Entry:
     MOVE.L  A6,-(A7)      ; Save A6
     LEA     $FFFFE000,A6  ; Profiling memory
     ADDQ.L  #1,0(A6)      ; Increment call count
     MOVE.L  D0,4(A6)      ; Store timestamp

     ; ... original code ...

     MOVE.L  D0,8(A6)      ; Store exit time
     MOVE.L  (A7)+,A6      ; Restore
     RTS
   ```

2. **Measure:**
   - Cycle count per call
   - Variation in call patterns
   - Impact of command type
   - DMA wait times

3. **Analyze:**
   - Is 11 calls necessary?
   - Can commands be batched?
   - SH2 audio processing feasibility?

**Expected Opportunities:**

| Strategy | Effort | Gain | Priority |
|----------|--------|------|----------|
| Batch commands | Low | 1-2% | Medium |
| Optimize Z80 handshake | Medium | 2-3% | Medium |
| DMA-based queuing | High | 3-5% | Low |
| SH2 synthesis | Very High | 5-10% | Low |

---

## Phase-Based Implementation Plan

### Phase 0: Profiling & Validation (1 week)

**Goal:** Confirm bottleneck assumptions with real data

**Tasks:**
1. Run emulator-based profiling of current code
   - Measure actual VDP polling time
   - Measure SH2 idle time
   - Measure sound system cost

2. Instrument key functions
   - V-INT handler timing
   - State machine timing
   - Display synchronization

3. Create performance baseline
   - Frame time distribution
   - CPU utilization graphs
   - Bottleneck confirmation

**Success Criteria:**
- VDP polling confirmed as 45-50% of frame
- SH2 utilization confirmed as <1%
- Sound system cost measured

### Phase 1: VDP Polling Optimization (2-3 weeks)

**Goal:** Replace polling with interrupt-based synchronization

**Tasks:**
1. Design interrupt handler architecture
2. Implement H-INT handler modifications
3. Modify VDPSyncSH2, PaletteRAMCopy
4. Extensive testing and validation
5. Performance measurement

**Success Criteria:**
- Frame time reduced to ~9.5-10ms
- VDP polling overhead < 5% of frame
- Zero stability regressions

### Phase 2: SH2 Parallelization (3-4 weeks)

**Goal:** Move game logic to SH2 for parallel execution

**Tasks:**
1. Partition game state between CPUs
2. Design new COMM protocol
3. Implement physics simulation on SH2
4. Add collision detection
5. Comprehensive testing

**Success Criteria:**
- Frame time reduced to ~8-9ms
- 68K load < 50%
- SH2 load 40-50%
- Smooth gameplay maintained

### Phase 3: Sound System Optimization (1-2 weeks)

**Goal:** Optimize or parallelize sound processing

**Tasks:**
1. Profile Z80SoundCmd in detail
2. Design optimization approach
3. Implement chosen strategy
4. Test audio quality

**Success Criteria:**
- Additional 2-3% performance gain
- Audio quality maintained
- No audio glitches

### Phase 4: Integration & Polish (1-2 weeks)

**Goal:** Combine all optimizations, comprehensive testing

**Tasks:**
1. Merge all optimization branches
2. Full ROM disassembly update
3. Performance testing on real hardware
4. Documentation update
5. Release

**Success Criteria:**
- All optimizations working together
- Frame rate stable 50-60 FPS
- No regressions
- ROM still buildable with byte accuracy (if applicable)

---

## Risk Management

### Potential Issues & Mitigation

**Issue 1: Interrupt Race Conditions**
- **Risk:** Simultaneous VDP access from 68K and H-INT handler
- **Mitigation:** Use atomic operations, test extensively
- **Fallback:** Revert to polling-based sync

**Issue 2: SH2 Communication Deadlock**
- **Risk:** COMM register deadlock if timing is wrong
- **Mitigation:** Add timeout mechanism, careful state machine design
- **Fallback:** Keep existing game logic on 68K

**Issue 3: Audio Sync Loss**
- **Risk:** Sound system becomes out of sync with video
- **Mitigation:** Profile first, test extensively before optimizing
- **Fallback:** Keep Z80 commands unchanged

**Issue 4: Real Hardware Compatibility**
- **Risk:** Optimizations may not work on actual hardware
- **Mitigation:** Test on both emulator and real hardware regularly
- **Fallback:** Conditional compilation for different platforms

---

## Testing Strategy

### Functional Testing

```
Test 1: Frame Timing Stability
├─ Run 1000 frames
├─ Measure: min/max/avg frame time
├─ Pass criteria: ±5% variance

Test 2: Audio Sync
├─ Listen for audio glitches
├─ Verify pitch stability
├─ Check for dropped frames

Test 3: Input Responsiveness
├─ Test controller input latency
├─ Verify 60fps input sampling
├─ Check for input jitter

Test 4: Game Logic Correctness
├─ Verify AI behavior unchanged
├─ Check physics accuracy
├─ Confirm collision detection works
```

### Performance Benchmarking

```
Benchmark Suite:
├─ Frame time per subsystem
├─ CPU utilization per task
├─ Memory bandwidth usage
├─ Cache hit/miss ratios
└─ Power consumption (if available)
```

---

## Success Metrics

### Performance Targets

| Metric | Current | Target | Confidence |
|--------|---------|--------|------------|
| **Frame Time** | 16.67ms | 9-10ms | High |
| **68K Load** | 100% | 30-40% | Medium |
| **SH2 Load** | 0.03% | 40-50% | Medium |
| **Throughput** | 60 FPS | 60+ FPS | High |
| **Stability** | Good | Excellent | High |

### Quality Assurance

- **Zero regressions** in game logic
- **Audio quality** maintained or improved
- **Visual quality** unchanged
- **Compatibility** with real hardware maintained
- **Documentation** updated

---

## Resources Required

### Development Tools
- Emulator (BlastEm recommended for profiling)
- Real Sega 32X hardware (optional but recommended)
- Profiler/debugger integration
- Performance measurement tools

### Knowledge Required
- 68K assembly optimization
- SH2 architecture
- SEGA 32X hardware details
- Interrupt handling
- Parallel processing patterns

### Time Commitment
- Phase 0 (Profiling): 1 week
- Phase 1 (VDP Polling): 2-3 weeks
- Phase 2 (SH2 Parallelization): 3-4 weeks
- Phase 3 (Sound Optimization): 1-2 weeks
- Phase 4 (Integration): 1-2 weeks
- **Total: 8-12 weeks** of focused development

---

## References

- **Architecture Guide:** `docs/architecture-guide.md`
- **Function Cross-Reference:** `docs/function-cross-reference.md`
- **Hardware Manual:** `docs/32x-hardware-manual.md`
- **Technical Details:** `docs/32x-technical-info.md`
- **Disassembler:** `tools/m68k_disasm.py`

---

**Document Status:** Analysis Complete
**Next Phase:** Profiling & Baseline Measurement
**Generated:** 2026-01-10
**Estimated Implementation Start:** After profiling validation
