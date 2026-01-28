# SH2-Side Async Queue Management - Pros & Cons Analysis

**Date:** 2026-01-28
**Context:** Considering moving async queue from 68K to SH2 via CMD interrupt

---

## PROS ✅

### 1. **Massive Space Savings in 68K Section** 🎯
- **Current**: ~100 bytes of async infrastructure in cramped $00E200 section
- **With SH2**: Only ~10-20 byte trampoline needed in 68K
- **Freed**: 80+ bytes for other optimizations
- **Impact**: Solves section overflow problem permanently

### 2. **Expansion Section Availability**
- **Available**: 1MB free space at $300434-$3FFFFF (SH2-only)
- **Current usage**: Only 1KB used by Phase 11 code
- **Benefit**: Can add profiling counters, complex queue logic, diagnostics
- **Scalability**: Room for multiple queues, priorities, statistics

### 3. **Better CPU Utilization**
- **Master SH2**: Currently 64% idle (36% utilized)
- **Perfect for**: Queue coordination and work dispatch
- **Current waste**: Master polls COMM registers 63.5% of the time (documented)
- **Improvement**: Interrupt-driven = zero polling waste

### 4. **Interrupt-Driven is Faster** ⚡
| Metric | Current (Polling) | With CMD Interrupt |
|--------|------------------|-------------------|
| Latency per check | 1-3 cycles × polls | 1-2 cycles (automatic) |
| Context overhead | Implicit loop | ~60-80 cycles (one-time) |
| Wasted cycles | 63.5% CPU | Near zero |
| Response time | Variable (polling interval) | Immediate (~87ns) |

**Verdict**: Interrupt is faster for frequent work submissions

### 5. **Hardware Already Exists**
- ✅ CMD interrupt fully supported (unused)
- ✅ Vector table infrastructure in place (VBR @ 0x20)
- ✅ Interrupt mask register accessible (0x20004000)
- ✅ Clear register available (0x2000401A)
- **No hardware limitations** - just software integration

### 6. **COMM2 is Available**
- **Status**: Unused by original game or Phase 11
- **Can use for**: Queue signal flag
- **Safe**: No conflicts with existing protocol (COMM0/1/3-7 accounted for)

### 7. **Proven Pattern Exists**
- **Phase 11**: Already uses SH2 polling loop for work dispatch
- **Can upgrade**: Polling → Interrupt = direct improvement
- **Reference code**: `slave_work_wrapper` at expansion_300000.asm:196
- **Learning**: Can copy/adapt existing patterns

### 8. **Enables Proper Profiling**
- **With space**: Can add byte counters (4 bytes each)
- **Metrics**: Queue depth, dispatch latency, overflow events
- **Diagnostics**: Real-time queue state visible via COMM registers
- **Testing**: Easier to debug with counters

---

## CONS ❌

### 1. **Implementation Complexity** ⚠️
- **Effort**: 10-16 hours total (vs ~2 hours for 68K version)
- **SH2 assembly**: Requires SH2 instruction knowledge (different from 68K)
- **Debugging**: Harder to debug SH2 code (fewer tools, less familiar)
- **Testing**: Need to verify interrupt firing, timing, race conditions

**Breakdown**:
```
Phase 1: Interrupt handler skeleton      2 hours
Phase 2: Queue infrastructure            4 hours
Phase 3: Integration with Phase 11       4 hours
Phase 4: Testing & debugging             6 hours
Total:                                  16 hours
```

### 2. **CMD Interrupt Behavior** 🔄
- **Auto-negates**: Unlike V/H/PWM, CMD auto-clears after handling
- **Implication**: 68K must write INTM bit *every* time
- **Risk**: If 68K sends burst of commands, only first triggers interrupt
- **Mitigation**: Queue multiple commands before signaling (batching)

From hardware manual:
> "CMDINT differs from other interrupts: INT is negated. When CMDINT is enabled after CMDINT is not received, CMDINT is again asserted."

### 3. **Context Switch Overhead**
- **Per interrupt**: ~60-80 cycles (~2.6-3.5 μs)
  - Save registers: 30-40 cycles
  - Restore + RTE: 30-40 cycles
- **Break-even**: Only beneficial if work savings > 80 cycles
- **Risk**: For very short commands, overhead > benefit

**Analysis**:
- Current polling wastes 63.5% CPU
- 80 cycles one-time cost << thousands of cycles polling
- **Verdict**: Still a net win for typical workloads

### 4. **Race Conditions** ⚠️
- **Simultaneous COMM writes**: 68K and SH2 writing same register = undefined
- **Queue corruption**: If both CPUs modify queue simultaneously
- **COMM0 handshake**: Must coordinate with existing protocol

**Mitigation**:
- Use single-writer principle (68K queues, SH2 consumes)
- Use COMM0 as lock (already done in Phase 11)
- Atomic operations (test-and-set pattern)

### 5. **Integration with Phase 11** 🔧
- **Conflict**: Phase 11 uses COMM4-7 for frame sync
- **Consideration**: New queue must not interfere with:
  - `handler_frame_sync` (expansion_300000.asm:28)
  - `slave_work_wrapper` (expansion_300000.asm:196)
  - Existing COMM7 = 0x16 (vertex transform command)
- **Risk**: Breaking Phase 11's parallel processing

**Solutions**:
- Use COMM2 exclusively for queue flag
- Coordinate with COMM7 command values (avoid conflicts)
- Test Phase 11 continues working after adding interrupt

### 6. **Expansion Space Conflicts**
- **Current**: 0x300000-0x300434 used by Phase 11 (~1KB)
- **Need**: ~500 bytes for interrupt handler + queue logic
- **Available**: 0x300434+ has 1MB free
- **Issue**: Must carefully place code to avoid collisions

**Memory map**:
```
$300000-$300027  handler_frame_sync (40 bytes)
$300050-$30007B  master_dispatch_hook (44 bytes)
$300100-$30015F  func_021_optimized (96 bytes)
$300200-$30024B  slave_work_wrapper (76 bytes)
$300280-$3002AB  slave_test_func (44 bytes)
$300434-$3FFFFF  FREE (1+ MB)
```

### 7. **Debugging Difficulty** 🐛
- **SH2 debugger**: PicoDrive SH2 debugger is finicky
- **GDB limitations**: Not fully compatible with 32X
- **Fewer tools**: Compared to 68K (better documented, more familiar)
- **Interrupt tracing**: Hard to step through interrupt handlers

**Workarounds**:
- Use COMM registers as debug outputs (write state to COMM2/3)
- Add diagnostic counters in expansion memory
- Test incrementally (echo handler first, then queue)

### 8. **Phase 11 Dependency** 🔗
- **Assumption**: Builds on Phase 11's parallel processing
- **Risk**: If Phase 11 has issues, async queue affected
- **Coupling**: Tightly coupled to existing COMM protocol
- **Testing**: Must test both independently and together

---

## DECISION MATRIX

| Factor | Weight | 68K Queue | SH2 Interrupt Queue |
|--------|--------|-----------|---------------------|
| **Space efficiency** | 5 | ⭐ (100 bytes) | ⭐⭐⭐⭐⭐ (10 bytes) |
| **Implementation time** | 3 | ⭐⭐⭐⭐⭐ (2 hours) | ⭐⭐ (16 hours) |
| **Performance** | 5 | ⭐⭐ (polling) | ⭐⭐⭐⭐⭐ (interrupt) |
| **Scalability** | 4 | ⭐ (no space) | ⭐⭐⭐⭐⭐ (1MB free) |
| **Debugging ease** | 2 | ⭐⭐⭐⭐ | ⭐⭐ |
| **Risk level** | 4 | ⭐⭐⭐⭐ (low) | ⭐⭐⭐ (medium) |

**Weighted Score**:
- **68K Queue**: (5×1 + 3×5 + 5×2 + 4×1 + 2×4 + 4×4) / 23 = **2.3/5**
- **SH2 Interrupt Queue**: (5×5 + 3×2 + 5×5 + 4×5 + 2×2 + 4×3) / 23 = **4.0/5**

**Winner**: SH2 Interrupt Queue (75% better weighted score)

---

## HYBRID APPROACH: Best of Both Worlds 💡

**Idea**: Start with 68K queue, migrate to SH2 queue incrementally

### Phase 1: 68K Queue (Working Now)
- ✅ Already implemented
- ✅ Minimal risk
- ⚠️ Section overflow prevents profiling

### Phase 2: Minimal SH2 Trampoline
- Replace 68K queue logic with COMM2 signal + CMD interrupt
- Keep async semantics identical (transparent to caller)
- Free up 80 bytes in 68K section
- **Effort**: ~6 hours

### Phase 3: Full SH2 Queue
- Implement multi-slot queue in expansion memory
- Add profiling counters
- Optimize interrupt handler
- **Effort**: ~10 hours

**Benefits**:
- ✅ Incremental migration (lower risk)
- ✅ Can stop at Phase 2 if Phase 3 isn't worth it
- ✅ Learn SH2 interrupts progressively
- ✅ Immediate space relief in 68K section

---

## RECOMMENDATION

### Short-term (Next 1-2 hours): **Profile current 68K async**
- Build blocking vs async ROMs
- Manually clear queue memory
- Measure FPS impact with 1 call site
- **Decision**: If <5% improvement, reconsider entire async approach

### Medium-term (If async shows promise): **Migrate to SH2 interrupt queue**
- Implement minimal CMD interrupt handler
- Free up 68K section space
- Add profiling counters in expansion
- **Effort**: 6-10 hours
- **Payoff**: Proper profiling + scalability

### Long-term (If profiling shows major wins): **Extend to all 13 call sites**
- Use SH2 queue infrastructure
- Measure cumulative FPS improvement
- Target: 30-40% FPS increase (based on 68K polling waste)

---

## UNKNOWNS / RISKS TO INVESTIGATE

1. ❓ **CMD interrupt firing reliability**
   - Test: Simple echo handler, verify interrupt triggers every time
   - Risk: If unreliable, entire approach fails

2. ❓ **COMM register contention with Phase 11**
   - Test: Run Phase 11 + CMD interrupt simultaneously
   - Risk: Race conditions causing crashes

3. ❓ **Interrupt latency variance**
   - Measure: Min/max/avg latency over 1000 interrupts
   - Risk: High variance = unpredictable performance

4. ❓ **Queue overflow handling**
   - Design: Circular buffer? Fallback to blocking?
   - Risk: Queue full = deadlock or dropped commands

5. ❓ **Cache coherency issues**
   - Test: Queue in cache-through SDRAM (0x22xxxxxx)
   - Risk: Cached reads = stale data

---

## NEXT STEPS

**Immediate** (if pursuing SH2 approach):
1. Set up simple CMD interrupt echo test (2 hours)
2. Measure interrupt latency vs polling (1 hour)
3. Verify COMM2 doesn't conflict with Phase 11 (1 hour)

**If tests pass**:
4. Implement minimal SH2 queue handler (4 hours)
5. Integrate with 68K trampoline (2 hours)
6. Profile FPS improvement (2 hours)

**Total time to working SH2 async**: ~12 hours

---

## FILES TO REFERENCE

| File | Purpose |
|------|---------|
| `/mnt/data/src/32x-playground/disasm/sections/expansion_300000.asm` | Phase 11 code, available space |
| `/mnt/data/src/32x-playground/analysis/sh2-analysis/SH2_INTERRUPT_HANDLERS.md` | Vector table, interrupt infrastructure |
| `/mnt/data/src/32x-playground/docs/32x-hardware-manual.md` | CMD interrupt hardware specs |
| `/mnt/data/src/32x-playground/docs/development-guide.md` | COMM register usage guidelines |

---

## CONCLUSION

**SH2 interrupt-driven async queue is technically superior but requires significant implementation effort.**

**Recommendation**: Profile current 68K async first. If it shows <5% FPS improvement, the entire async approach may not be worth pursuing. If it shows ≥5% improvement with 1 call site, the SH2 migration becomes highly valuable (extrapolated 30-40% improvement with 13 sites).

**The section overflow problem makes SH2 migration almost mandatory** if we want to continue with async optimization and add proper profiling.
