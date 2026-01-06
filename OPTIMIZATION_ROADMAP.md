# Virtua Racing Optimization Campaign

**Goal**: Increase frame rate from 24 FPS to 60+ FPS through systematic optimization
**Timeline**: 12 weeks (3 months)
**Target**: 70 FPS (+192% improvement)

---

## 📊 Current Status

**Baseline**: 24 FPS
- Master SH2: 36.5% utilized (350K of 958K cycles)
- Slave SH2: 0.03% utilized (99.97% idle)
- Primary bottleneck: VDP status polling (47% of frame time)
- Secondary bottleneck: 68000 synchronization (16.5% of frame time)

---

## 🎯 Optimization Tracks

### Track 1: Quick Wins (Week 1-2) ✅

**Goal**: +15-20% FPS improvement with minimal risk

- [ ] **OPT-1A**: func_065 FIFO Batching
  - Status: Not started
  - Effort: 1-2 days
  - Expected gain: +10-15%
  - Files: Create tools/patch_fifo_batching.py
  - Test ROM: Virtua Racing - FIFO.32x

- [ ] **OPT-1B**: Optimize VDP Polling (Add Backoff)
  - Status: Not started
  - Effort: 1 day
  - Expected gain: +5-10%
  - Modify: Loop @ 0x243E2, add useful work during wait

- [ ] **OPT-1C**: Profile R13 Stride Values
  - Status: Not started
  - Effort: 1 day
  - Purpose: Confirm FIFO batching applicability
  - Method: Emulator trace or static analysis

**Milestone 1**: 24 → 28 FPS (+17%)

---

### Track 2: Slave CPU Activation (Week 2-5) 🔥

**Goal**: Utilize idle Slave SH2 for parallel work

#### Phase 2A: Foundation (Week 2-3)

- [ ] **OPT-2A1**: Replace Slave Idle Loop
  - Status: Not started
  - Location: ROM 0x20650-0x2069A
  - Create: disasm/slave_dispatcher.asm
  - Implementation: Command polling loop with dispatch table

- [ ] **OPT-2A2**: Define COMM Protocol
  - Status: Not started
  - Document: analysis/COMM_PROTOCOL.md
  - Define: Command codes, sync patterns, error handling

- [ ] **OPT-2A3**: Implement Basic Sync Test
  - Status: Not started
  - Test: Simple "echo" command
  - Create: Test ROM with Master→Slave→Master round-trip
  - Verify: COMM register reliability

#### Phase 2B: Vertex Transforms (Week 4-5)

- [ ] **OPT-2B1**: Copy Vertex Transform Code to Slave ROM
  - Status: Not started
  - Functions: func_006, func_008 (matrix multiply)
  - Location: Find unused ROM space near Slave code

- [ ] **OPT-2B2**: Implement Master→Slave Dispatch
  - Status: Not started
  - Master writes: vertex count, buffer addresses to COMM4/COMM5
  - Slave reads: performs transforms, signals done via COMM2

- [ ] **OPT-2B3**: Test Parallel Transforms
  - Status: Not started
  - Verify: Output matches Master-only version
  - Measure: Actual cycle savings
  - Create: Test ROM with Slave transforms enabled

**Milestone 2**: 28 → 42 FPS (+75% cumulative)

---

### Track 3: Interrupt-Driven Architecture (Week 5-10) ⭐

**Goal**: Replace polling loops with interrupt handlers

#### Phase 3A: Investigation (Week 5-6)

- [ ] **OPT-3A1**: Disassemble SH2 Interrupt Vectors
  - Status: Not started
  - Location: ROM 0x0-0x200 (vector table)
  - Check: Which interrupts are implemented?
  - Document: analysis/SH2_INTERRUPT_HANDLERS.md

- [ ] **OPT-3A2**: Analyze VDP Status Bits
  - Status: Not started
  - Reference: docs/32x-hardware-manual.md
  - Identify: What is bit 1 in polling loops?
  - Map: VDP register 0x20004100+ bit definitions

- [ ] **OPT-3A3**: Test VDP Interrupt Behavior
  - Status: Not started
  - Method: Emulator debugging
  - Trace: When do VDP interrupts fire?
  - Verify: Interrupt latency and reliability

#### Phase 3B: Implementation (Week 7-9)

- [ ] **OPT-3B1**: Replace Loop @ 0x243E2 with Interrupt
  - Status: Not started
  - Replace: TST/BF loop with SLEEP instruction
  - Handler: VDP interrupt wakes CPU, sets flag
  - Test: Verify frame timing unchanged

- [ ] **OPT-3B2**: Replace Loop @ 0x24482 with Interrupt
  - Status: Not started
  - Context field polling → interrupt-driven flag
  - May need: Custom interrupt for context updates

- [ ] **OPT-3B3**: Optimize Remaining Wait Loops
  - Status: Not started
  - Audit: All BF/BT loops in 3D engine
  - Convert: High-impact loops to interrupts

#### Phase 3C: Integration (Week 10)

- [ ] **OPT-3C1**: Test Full Interrupt-Driven ROM
  - Status: Not started
  - Verify: Stability, no frame drops
  - Measure: Actual FPS improvement
  - Debug: Any timing-sensitive code

**Milestone 3**: 42 → 60 FPS (+150% cumulative)

---

### Track 4: 68000 Optimization (Week 8-12) 🔬

**Goal**: Reduce or eliminate SH2 waiting for 68000

#### Phase 4A: Analysis (Week 8-9)

- [ ] **OPT-4A1**: Disassemble 68000 Game Logic
  - Status: Not started
  - Tool: Use m68k_disasm.py
  - Focus: Main loop, COMM register writes
  - Document: analysis/68000_GAME_LOGIC.md

- [ ] **OPT-4A2**: Profile 68000 Execution Time
  - Status: Not started
  - Method: Emulator trace or cycle counting
  - Measure: Time between COMM1 writes
  - Identify: Bottlenecks in game logic

- [ ] **OPT-4A3**: Map SH2↔68000 Sync Points
  - Status: Not started
  - Trace: When does 68000 write COMM registers?
  - Document: Frame flow diagram
  - Quantify: Sync overhead cycles

#### Phase 4B: Optimization (Week 10-12)

- [ ] **OPT-4B1**: Pipeline Frame Logic
  - Status: Not started
  - Strategy: 68000 works on frame N+1 while SH2 renders N
  - Implement: Double-buffered game state
  - Test: Input lag acceptable?

- [ ] **OPT-4B2**: Move Hot Paths to SH2
  - Status: Not started
  - Identify: 68000 code that could run on SH2
  - Rewrite: Port to SH2 assembly
  - Benefit: Faster execution + reduced sync

- [ ] **OPT-4B3**: Optimize 68000 Code Directly
  - Status: Not started
  - Profile: Find slow 68000 loops
  - Optimize: Algorithm improvements
  - Goal: Reduce 68000 frame time to <10 ms

**Milestone 4**: 60 → 70 FPS (+192% cumulative)

---

## 🛠 Tools & Infrastructure

### Analysis Tools

- [x] sh2_disasm.py - SH2 disassembler (120+ opcodes)
- [x] analyze_call_graph.py - Function relationship mapper
- [x] analyze_data_structures.py - Memory pattern analyzer
- [ ] m68k_disasm.py - 68000 disassembler (enhance)
- [ ] trace_registers.py - Emulator register tracer
- [ ] cycle_counter.py - Execution profiler

### Patching Tools

- [x] patch_func16_inline.py - Generic inline patcher
- [ ] patch_fifo_batching.py - FIFO optimization patcher
- [ ] patch_slave_dispatcher.py - Slave CPU code injector
- [ ] patch_interrupt_handlers.py - Interrupt conversion tool
- [ ] patch_68000_sync.py - 68000 optimization patcher

### Testing Tools

- [ ] create_test_rom.py - Automated ROM patcher
- [ ] verify_rom.py - Checksum and integrity checker
- [ ] benchmark_fps.py - Frame rate measurement tool
- [ ] compare_roms.py - Before/after binary diff

---

## 📈 Progress Tracking

### Week-by-Week Milestones

| Week | Focus | Deliverables | Expected FPS |
|------|-------|--------------|--------------|
| 1 | Quick wins + profiling | FIFO batching, stride analysis | 28 |
| 2 | Slave foundation | Dispatcher, COMM protocol | 28 |
| 3 | Slave sync testing | Echo test, reliability check | 28 |
| 4 | Slave transforms (part 1) | Code copy, basic dispatch | 35 |
| 5 | Slave transforms (part 2) | Full integration, testing | 42 |
| 6 | VDP interrupt research | Vector analysis, bit mapping | 42 |
| 7 | Interrupt impl (part 1) | Loop @ 0x243E2 converted | 50 |
| 8 | Interrupt impl (part 2) | Loop @ 0x24482 converted | 55 |
| 9 | 68000 analysis | Disassembly, profiling | 55 |
| 10 | Interrupt testing | Full integration | 60 |
| 11 | 68000 optimization | Pipelining or porting | 65 |
| 12 | Polish & testing | Bug fixes, fine-tuning | **70** |

### Success Metrics

**Technical Metrics**:
- ✅ SH2 Master utilization: 50-65% (down from 36.5%)
- ✅ SH2 Slave utilization: 50-65% (up from 0.03%)
- ✅ VDP polling cycles: <50K/frame (down from 450K)
- ✅ 68000 sync cycles: <50K/frame (down from 158K)
- ✅ Frame rate: 70 FPS (up from 24 FPS)

**Quality Metrics**:
- ✅ No visual artifacts or corruption
- ✅ Stable on emulator (Gens KMod)
- ✅ Stable on real hardware (if testable)
- ✅ No audio glitches
- ✅ Controls remain responsive

---

## ⚠️ Risk Management

### High-Risk Areas

**1. Interrupt Timing**
- Risk: Interrupt handlers might conflict with existing code
- Mitigation: Test one loop at a time, verify frame timing
- Contingency: Revert to polling if instability

**2. Slave CPU Synchronization**
- Risk: COMM register race conditions, cache coherency issues
- Mitigation: Use cache-through addresses, atomic operations
- Contingency: Add semaphore-based locking

**3. 68000 Pipelining**
- Risk: Input lag, game state inconsistencies
- Mitigation: Extensive testing, conservative double buffering
- Contingency: Keep sync overhead, optimize 68000 directly

### Rollback Strategy

**Every optimization phase**:
1. Git commit before changes
2. Create backup ROM
3. Test thoroughly before proceeding
4. Document any issues in `KNOWN_ISSUES.md`
5. Revert if stability compromised

---

## 📚 Documentation Strategy

### Documents to Create

- [ ] **COMM_PROTOCOL.md** - Master/Slave communication protocol
- [ ] **SH2_INTERRUPT_HANDLERS.md** - Interrupt vector analysis
- [ ] **68000_GAME_LOGIC.md** - 68000 code analysis
- [ ] **OPTIMIZATION_RESULTS.md** - Before/after measurements
- [ ] **KNOWN_ISSUES.md** - Bugs and workarounds
- [ ] **TESTING_GUIDE.md** - How to test optimized ROMs

### Progress Reports

**Weekly Status Updates** in `STATUS_WEEK_XX.md`:
- What was completed
- Current FPS measurement
- Blockers or issues
- Next week's plan

---

## 🎮 Testing Protocol

### For Each Optimization

1. **Unit Test**: Verify individual change works in isolation
2. **Integration Test**: Combine with previous optimizations
3. **Regression Test**: Ensure no new bugs introduced
4. **Performance Test**: Measure actual FPS improvement
5. **Stress Test**: Play full race, check stability

### Test Scenarios

- [ ] Title screen loads correctly
- [ ] Can start race on all tracks
- [ ] Graphics render properly (no corruption)
- [ ] Sound plays without glitches
- [ ] Controls responsive
- [ ] AI cars behave normally
- [ ] Race completes without crash
- [ ] Can return to menu

---

## 🔄 Continuous Integration

### Automated Checks

Create GitHub Actions workflow:
```yaml
# .github/workflows/test-optimizations.yml
- Build ROM with optimizations
- Run automated tests
- Measure FPS in emulator
- Generate before/after report
- Commit results to repo
```

### Nightly Builds

- Latest optimization build available daily
- Changelog with FPS measurements
- Download link for testing

---

## 🏁 Success Criteria

### Minimum Viable Optimization (MVO)

**Target**: 48 FPS (+100%)
**Timeline**: 8 weeks
**Includes**: FIFO batching + Slave CPU + Basic VDP optimization

### Stretch Goal

**Target**: 70 FPS (+192%)
**Timeline**: 12 weeks
**Includes**: All optimizations + 68000 pipelining

### Dream Scenario

**Target**: 90+ FPS
**Timeline**: TBD (post-campaign polish)
**Includes**: Perfect cache alignment, aggressive pipelining

---

## 📞 Community Engagement

### Share Progress

- [ ] Weekly updates on GitHub
- [ ] Video demonstrations of FPS improvements
- [ ] Blog post series on optimization techniques
- [ ] Final release on romhacking.net

### Open Source

- [ ] All tools released under MIT license
- [ ] Full documentation for community contributions
- [ ] IPS/BPS patch format for easy distribution
- [ ] ROM comparison videos (24 FPS vs 70 FPS)

---

**Status**: Campaign launched
**Start Date**: January 6, 2026
**Expected Completion**: April 2026
**Current Focus**: Track 1 (Quick Wins) + Track 4A (68000 Analysis)

Let's make Virtua Racing run like it was always meant to! 🏎️💨
