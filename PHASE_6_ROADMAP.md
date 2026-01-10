# Phase 6 Optimization Roadmap

**Date**: 2026-01-07
**Status**: Ready to begin
**Baseline**: ✅ vanilla-baseline branch established
**Analysis**: ✅ Priority 8 complete (4,234 lines)

---

## What We Have

### ✅ Complete Analysis
- **163 functions** analyzed and categorized
- **8 entry type patterns** identified
- **51 callsites** mapped in call graph
- **3 critical findings** documented
- **10-35% optimization potential** confirmed

### ✅ Vanilla Baseline
- **ROM size**: 3,145,728 bytes
- **Status**: Byte-for-byte identical to original
- **Build**: Working and verified
- **Branch**: `vanilla-baseline` (stable reference)

### ✅ Optimization Targets Identified
1. **func_D1D4** - Sound system hotspot (11 JSR calls)
2. **func_CA9A** - Game state dispatcher (likely location)
3. **130 isolated functions** - Safe to refactor
4. **Large functions** (300+ bytes) - Optimization candidates

---

## Phase 6 Strategy

### Three Parallel Work Streams

#### Stream A: Profiling & Validation (1-2 days)

**Goal**: Confirm optimization assumptions with real data

**Tasks**:
1. **Profile func_D1D4**
   - Measure call frequency per frame
   - Calculate total cycle consumption
   - Determine if frame-critical (60 Hz) or event-driven
   - **Decision Point**: If >0.5% CPU budget → optimize

2. **Investigate func_CA9A**
   - Deep disassemble dispatcher candidate
   - Trace all conditional branches
   - Map game state handlers
   - Identify state variable location
   - **Decision Point**: Confirm it's the dispatcher

3. **Frame-Level Performance**
   - Profile overall P8 CPU consumption
   - Compare to P1-P7 and P9
   - Validate 10-15% estimate

**Deliverable**: Profiling report with optimization priority ranking

---

#### Stream B: Planning & Design (1-2 days)

**Goal**: Design optimizations with risk assessment

**Tasks**:
1. **Design func_D1D4 Optimization** (if frame-critical)
   - Consolidate JSR calls
   - Identify inlining candidates
   - Estimate code size change
   - Risk assessment

2. **Design Dispatcher Refactoring** (if confirmed)
   - Analyze current structure
   - Identify optimization opportunities
   - Redesign if needed
   - Implementation strategy

3. **Design Dead Code Removal**
   - Identify unused 130 isolated functions
   - Safety analysis
   - Refactoring approach

4. **Validate Design**
   - Code review with team
   - Risk assessment
   - Implementation plan

**Deliverable**: Detailed implementation design document

---

#### Stream C: Implementation (2-4 days)

**Goal**: Execute optimizations and validate

**Tasks**:
1. **Create feature branches** from vanilla-baseline
   ```bash
   git checkout vanilla-baseline
   git checkout -b optimize/priority-8-d1d4
   ```

2. **Implement first optimization**
   - Edit disasm/ files
   - Rebuild ROM
   - Test functionality
   - Commit with detailed message

3. **Validate optimization**
   - Size comparison
   - Functionality test
   - Performance measurement
   - Risk mitigation

4. **Iterate** on next optimization
   - Based on profiling data
   - Follow same process
   - Track cumulative improvements

**Deliverable**: Optimized ROM with improvements measured

---

## Recommended Execution Order

### Phase 6.1: Profiling (Days 1-2)

```
Priority 1: Profile func_D1D4 frequency
  ├─ Instrument entry/exit
  ├─ Measure call count per frame
  ├─ Calculate CPU impact
  └─ Decision: Worth optimizing?

Priority 2: Investigate dispatcher
  ├─ Deep disassemble func_CA9A
  ├─ Trace conditional branches
  ├─ Confirm identity
  └─ Decision: Refactoring opportunity?

Priority 3: Frame profiling
  ├─ Overall P8 CPU consumption
  ├─ Compare to estimates
  ├─ Validate assumptions
  └─ Ranking of opportunities
```

**Success Criteria**:
- [ ] func_D1D4 frequency determined
- [ ] Dispatcher identity confirmed
- [ ] CPU impact quantified
- [ ] Top 3 optimization opportunities ranked

### Phase 6.2: Design (Days 2-3)

```
If func_D1D4 frame-critical:
  ├─ Design JSR consolidation
  ├─ Identify inlining targets
  ├─ Estimate size/speed tradeoff
  └─ Implementation plan

If dispatcher refactoring viable:
  ├─ Analyze current structure
  ├─ Design improvements
  ├─ Document game state handling
  └─ Implementation plan

Dead code removal:
  ├─ Classify 130 isolated functions
  ├─ Identify unused code
  ├─ Safety analysis
  └─ Removal strategy
```

**Success Criteria**:
- [ ] Optimization design documented
- [ ] Risk assessment complete
- [ ] Team review approval
- [ ] Implementation plan ready

### Phase 6.3: Implementation (Days 3-5)

```
Optimization 1: func_D1D4
  ├─ Branch from vanilla-baseline
  ├─ Edit disasm files
  ├─ Rebuild and test
  ├─ Measure improvement
  └─ Commit if successful

Optimization 2: Dispatcher (if viable)
  ├─ Branch from vanilla-baseline
  ├─ Refactor dispatcher logic
  ├─ Rebuild and test
  ├─ Measure improvement
  └─ Commit if successful

Optimization 3: Dead code removal
  ├─ Identify unused functions
  ├─ Remove from disasm
  ├─ Rebuild and test
  ├─ Measure size reduction
  └─ Commit if successful
```

**Success Criteria**:
- [ ] First optimization implemented
- [ ] ROM still works (audio, graphics, gameplay)
- [ ] Size/performance improvement measured
- [ ] Committed with clear messages

---

## Branch Strategy

### Baseline Branch (Protected)
```
vanilla-baseline (stable)
  └─ Always clean, always builds
  └─ Used as reference for all features
```

### Feature Branches (For Optimization)
```
optimize/priority-8-d1d4
  └─ If profiling shows frame-critical

optimize/dispatcher-refactoring
  └─ If investigation shows opportunity

optimize/dead-code-removal
  └─ After dead code identified

optimization/phase-6-combined
  └─ Final optimized master version
```

### Merge Strategy
```
master (main development)
  ├─ All analysis work (completed)
  └─ Future: Merges from successful optimizations

vanilla-baseline (reference)
  └─ No merges, stay frozen as baseline
```

---

## Risk Management

### Low-Risk Items
- [x] Analysis and documentation (completed)
- [x] Building vanilla baseline (completed)
- [x] Profiling (safe, read-only)
- [x] Design and planning (safe, read-only)

### Medium-Risk Items
- [ ] JSR inlining (affects code size/timing)
- [ ] Entry consolidation (affects control flow)
- [ ] Function parameter analysis needed

### High-Risk Items
- [ ] Dispatcher refactoring (core game logic)
- [ ] Removing isolated functions (may break dependencies)
- [ ] Modifying critical timing code (frame sync, audio)

### Mitigation Strategies
1. **Test before commit** - Always rebuild and verify
2. **Rollback plan** - Keep vanilla-baseline clean
3. **Incremental changes** - Optimize one thing at a time
4. **Emulator testing** - Test graphics and audio
5. **Performance measurement** - Quantify improvements

---

## Success Metrics

### Phase 6 Goals

| Goal | Target | Status |
|------|--------|--------|
| func_D1D4 profiled | Frequency determined | Pending |
| Dispatcher located | func_CA9A confirmed | Pending |
| Design approved | Risk assessed | Pending |
| First optimization | Implemented & tested | Pending |
| ROM stability | Verified working | Pending |
| Size reduction | Measured | Pending |
| Performance gain | 5-10% or documented | Pending |

### Acceptable Outcomes
- ✅ At least one optimization successfully implemented
- ✅ ROM still functions (audio, graphics, gameplay)
- ✅ Measurable improvement (size or speed)
- ✅ Process documented for future optimizations

---

## Timeline Estimate

| Phase | Duration | Parallel | Total |
|-------|----------|----------|-------|
| Profiling | 1-2 days | Yes | 1-2 days |
| Design | 1-2 days | Yes | 1-2 days |
| Implementation | 2-4 days | Sequential | 2-4 days |
| **Total** | — | — | **4-8 days** |

**Critical Path**: Profiling → Design → Implementation

---

## Next Immediate Actions

### This Week

1. **Set up profiling environment**
   - Choose profiling method (breakpoints, counters, sampling)
   - Instrument func_D1D4 entry/exit
   - Plan frame-level performance measurement

2. **Dispatcher investigation**
   - Deep disassemble func_CA9A
   - Trace all BSR targets and conditional branches
   - Identify game state variable location

3. **Validation**
   - Test vanilla ROM works in emulator
   - Confirm audio and graphics functional
   - Note any baseline issues

### Next 2 Weeks

1. **Profiling completion**
   - func_D1D4 call frequency report
   - Dispatcher confirmation
   - CPU impact analysis

2. **Design & planning**
   - Optimization design document
   - Risk assessment matrix
   - Implementation roadmap

3. **First optimization**
   - Feature branch creation
   - Code changes
   - Testing and validation

---

## Resources Needed

### Documentation (Completed)
- [x] Priority 8 Analysis (4,234 lines, 14 files)
- [x] Vanilla baseline established
- [x] Optimization targets identified

### Tools (Available)
- [x] vasm assembler (built)
- [x] ROM build system (working)
- [x] Comparison tools (cmp, diff)
- [ ] Profiler (need to set up)
- [ ] Emulator (need to verify)

### Knowledge (Available)
- [x] 68K assembly understanding
- [x] Sega 32X architecture
- [x] Priority 8 code structure
- [x] Optimization opportunities

---

## Success Criteria for Phase 6

### Minimum (Must Have)
- [ ] func_D1D4 profiled and understood
- [ ] Dispatcher identity confirmed
- [ ] At least one optimization planned

### Target (Should Have)
- [ ] First optimization implemented
- [ ] ROM verified working
- [ ] Performance improvement measured

### Stretch (Nice to Have)
- [ ] Multiple optimizations completed
- [ ] 5-10% improvement achieved
- [ ] Dispatcher refactoring completed

---

## Conclusion

We have completed comprehensive analysis of Priority 8. The vanilla baseline is established and ready. All optimization targets are identified and ranked.

**Status**: Ready to proceed with Phase 6 optimization work.

**Next Step**: Begin profiling to validate optimization assumptions.

---

**Created**: 2026-01-07
**Analysis Complete**: ✅ 4,234 lines, 14 documents
**Baseline Established**: ✅ vanilla-baseline branch
**Ready for Implementation**: ✅ YES

