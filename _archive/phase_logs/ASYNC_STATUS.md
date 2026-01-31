# Async Command Submission - Current Status & Decision Point

**Date:** 2026-01-28
**Phase:** 1A - Single call site proof-of-concept
**Status:** ⚠️ **BLOCKED** - Section overflow prevents stable implementation

---

## What's Working ✅

1. **COMM Protocol Implementation** - Complete and correct
   - Proper COMM0/COMM1 handshake writes
   - COMM4 parameter passing
   - COMM6 trigger signal
   - Matches original blocking code protocol exactly

2. **Queue Logic** - Functionally correct
   - PENDING_CMD_VALID flag management
   - Immediate submission when SH2 ready
   - Queueing when SH2 busy
   - V-INT dispatch of queued commands

3. **Integration Points** - Identified and patched
   - First call site @ $00FF60 successfully redirected
   - V-INT handler calls `sh2_wait_frame_complete`
   - Trampoline mechanism working

---

## Current Problem ❌

### **Section $00E200-$010200 is at absolute capacity**

```
Current end: $010200 (hard limit)
Available: 0 bytes
Needed for stable async: ~20 bytes (init code)
```

### **Consequence: Freeze at Boot**

**Root cause**: Work RAM not cleared at boot
- `$00FFD000` (PENDING_CMD_VALID) contains garbage
- Without init guard, garbage values cause:
  - Invalid dispatch attempts
  - Infinite wait loops
  - Boot freezes

**Evidence**: Removing init code → immediate freeze

---

## Three Paths Forward

### **Path A: Manual Clear + Profile (Quick Test)** ⏱️ 30 min

**Approach**: Accept limitation, test with manual intervention

**Steps**:
1. Build async ROM (without init)
2. Before each test: Manually write zeros to `$00FFD000-$00FFD020` via GDB
3. Run 60-second FPS test
4. Compare blocking vs async

**Pros**:
- ✅ Quick validation of async concept
- ✅ No code changes needed
- ✅ Can get FPS numbers today

**Cons**:
- ❌ Not production-ready (requires manual clearing)
- ❌ Fragile (one mistake = freeze)
- ❌ Can't test in real gameplay (only controlled scenarios)

**Decision criteria**: If FPS improvement < 5%, async isn't worth pursuing

---

### **Path B: Migrate to SH2 Interrupt Queue** 🔧 12-16 hours

**Approach**: Redesign queue as SH2-side interrupt handler

**Architecture**:
```
68K: Minimal trampoline (10 bytes)
      ↓ Write COMM2, trigger CMD interrupt
SH2: Interrupt handler in expansion @ $300434+
      ↓ Queue management, work dispatch
```

**Pros**:
- ✅ Solves space problem permanently (1MB expansion available)
- ✅ Better performance (interrupt vs polling)
- ✅ Enables profiling counters (plenty of space)
- ✅ Proper architecture (SH2 coordinates its own work)
- ✅ Scalable to complex queues

**Cons**:
- ❌ Significant implementation time (12-16 hours)
- ❌ SH2 assembly complexity
- ❌ Debugging difficulty
- ❌ Integration risk with Phase 11

**Decision criteria**: Only pursue if Path A shows ≥5% FPS improvement

**See**: `analysis/optimization/SH2_ASYNC_QUEUE_ANALYSIS.md` for full analysis

---

### **Path C: Abandon Async, Pursue Other Optimizations** 🚀

**Approach**: Focus on known-good optimizations

**Alternatives** (from existing profiling):
1. **VDP polling reduction** - 47% of V-INT time wasted
2. **68K delay loop elimination** - Direct FPS gains documented
3. **Slave workload balancing** - Slave is bottleneck (78% util)

**Pros**:
- ✅ Known ROI from profiling data
- ✅ Less risky than async experiments
- ✅ Doesn't require section space

**Cons**:
- ❌ Misses potential async benefits
- ❌ Parallel processing opportunity lost

---

## Recommended Decision Tree

```
┌─────────────────────────────────┐
│ Can we stabilize 68K async?     │
│ (Find 20 bytes to free up)      │
└───────────┬─────────────────────┘
            │
      ┌─────┴─────┐
      │           │
     YES         NO
      │           │
      ▼           ▼
   Profile    Path A: Manual
      │        Clear Test
      │           │
      ▼           ▼
  FPS gain?    FPS gain?
      │           │
  ┌───┴───┐   ┌───┴───┐
  │       │   │       │
 <5%     ≥5%  <5%    ≥5%
  │       │   │       │
  ▼       ▼   ▼       ▼
Path C  Path B Path C Path B
```

---

## Immediate Next Step (Your Call)

**I recommend**: Attempt to find 20 bytes to free up in code_e200.asm

**Options to explore**:
1. Remove queue overflow counter (saves 6 bytes) - already done
2. Simplify error paths (inline instead of JMP)
3. Find dead code or redundant checks
4. Optimize instruction sequences (use smaller addressing modes)

**If we can free 20 bytes**: Add minimal init, test stability, then profile

**If we can't free 20 bytes**: Choose Path A (manual clear) or Path B (SH2 migration)

---

## Files Reference

| File | Status | Notes |
|------|--------|-------|
| `disasm/sections/code_e200.asm` | At capacity | Async infrastructure here |
| `disasm/sections/code_200.asm` | Working | V-INT handler with JSR hook |
| `test_async_fps.sh` | Ready | Manual profiling script |
| `SH2_ASYNC_QUEUE_ANALYSIS.md` | Complete | Full SH2 migration analysis |

---

## Your Question: "What should we do?"

Given your guidance to **stabilize first, profile second**, I recommend:

1. **Spend 30 min**: Try to optimize code_e200.asm to free 20 bytes
2. **If successful**: Add minimal init, verify no freezes, then profile
3. **If unsuccessful**: Execute Path A (manual clear test) to validate concept
4. **Then decide**: Based on FPS data, choose Path B (SH2) or Path C (other opts)

**Sound reasonable?** Or would you prefer to skip straight to Path A and get FPS numbers with manual clearing?
