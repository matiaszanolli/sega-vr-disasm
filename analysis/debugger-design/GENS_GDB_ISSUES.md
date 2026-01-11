# GDB Profiling with Gens - Known Issues

**Date:** 2026-01-06
**Status:** ⚠️ **BLOCKED** - Gens GDB stub has fundamental bugs

---

## Summary

Attempted runtime profiling using Gens KMod v0.7.3's GDB stub. After extensive troubleshooting, discovered the GDB implementation has critical bugs that prevent reliable profiling.

## Critical Issues

### 1. Invalid PC Values ❌ **BLOCKER**
**Observed:** PC reports addresses like `0xfa410006`, `0xd00200c0` (invalid memory ranges)
**Expected:** `0x02xxxxxx` (ROM cached) or `0x06xxxxxx`, `0x22xxxxxx`
**Impact:** Cannot determine actual execution location

### 2. Memory Reads Return Zero ❌ **BLOCKER**
**Symptom:** `x/10i $pc` shows only `.word 0x0000` (garbage)
**Expected:** Valid SH2 instructions
**Impact:** Cannot inspect code or verify execution

### 3. Breakpoints Never Hit ❌ **BLOCKER**
**Tested:** func_065 at `0x02223F2E`, VDP loops at `0x0243E2`-`0x024482`
**Result:** Zero hits during active gameplay
**Impact:** No profiling data collected

## Test Conditions

- **Emulator:** Gens KMod v0.7.3 (Wine)
- **ROM:** Virtua Racing Deluxe (USA).32x
- **GDB:** gdb-multiarch 16.3
- **Game States:** Title, menu, demo race, active race
- **Result:** Same issues in all states

## What We Built ✅

Despite the blocker, significant infrastructure created:

### Tools
- 6 GDB profiling modes (VDP, Slave CPU, hot functions, etc.)
- Automated profiling workflow
- Static call graph analyzer

### Documentation
- OPTIMIZATION_PLAN.md (4-week strategic roadmap)
- PROFILING_GUIDE.md (comprehensive guide)
- GDB_PORT_REFERENCE.md
- WEEK_1_STATUS.md

## Recommendations

### Immediate
1. Commit all work (tools/docs still valuable)
2. Try alternative emulators (BlastEm, Ares)
3. Consider code instrumentation or emulator logging

### Long Term
- Find emulator with working SH2 GDB stub
- Build custom profiling if needed
- Hardware debugging (JTAG) if budget allows

---

**Conclusion:** Gens GDB stub unsuitable for profiling. Need alternative approach.
