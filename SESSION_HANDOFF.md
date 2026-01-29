# Session Handoff - Clean Baseline Restoration

**Date:** 2026-01-29
**Status:** About to execute Option C cleanup
**ROM State:** ✅ Working baseline (async disabled, builds successfully)

---

## Current Situation

We attempted to implement **Phase 1A: 68K Async Command Submission** but hit a critical blocker:

- **Section $00E200-$010200 is at absolute capacity** (0 bytes free)
- Async infrastructure requires **20 bytes for initialization code** (to clear Work RAM queue at boot)
- Without init code, Work RAM contains garbage → ROM freezes at startup
- Multiple attempts to find space failed:
  - Removing profiling counters: Not enough space saved
  - Absolute short addressing optimization: Caused freezes (may be vasm bug)
  - Queue overflow check removal: Still insufficient

**Conclusion:** 68K async cannot be stabilized in current section budget.

---

## Agreed Action: Option C - Remove Async Code Entirely

### Rationale
1. **68K async is unstable** without init code (20 bytes unavailable)
2. **Section capacity crisis** makes every future change risky with half-active async code present
3. **SH2 migration** (Path B) is a better long-term approach but requires 12-16 hours
4. **Clean baseline** needed before attempting any SH2-based async work

### What to Remove

**File:** [disasm/sections/code_e200.asm](disasm/sections/code_e200.asm)

1. **Lines 1220-1256:** `async_trampoline` and `sh2_send_cmd_async` function
2. **Lines 1344-1373:** `sh2_wait_frame_complete` function (created for async, not in original)
3. **All PENDING_CMD references** at Work RAM $00FFD000-$00FFD00C

**File:** [disasm/sections/code_200.asm](disasm/sections/code_200.asm)

- Line 2651 already disabled (comment only - no JSR to sh2_wait_frame_complete)

**File:** code_e200.asm call site
- Line 3759: Already set to `dc.w $E3B6` (blocking path, async disabled)

### What to Keep

✅ **All async research documentation** (valuable for future SH2 work):
- [ASYNC_STATUS.md](ASYNC_STATUS.md) - Decision tree and blocker analysis
- [analysis/optimization/SH2_ASYNC_QUEUE_ANALYSIS.md](analysis/optimization/SH2_ASYNC_QUEUE_ANALYSIS.md) - 12-16 hours of research on SH2 interrupt architecture
- [analysis/profiling/ASYNC_PROFILING_PLAN.md](analysis/profiling/ASYNC_PROFILING_PLAN.md) - Manual profiling methodology
- [test_async_fps.sh](test_async_fps.sh) - FPS profiling script

---

## Commit Plan

**Message:**
```
refactor: Remove Phase 1A 68K async infrastructure - section capacity blocker

- Remove sh2_send_cmd_async and async queue logic from code_e200.asm
- Remove sh2_wait_frame_complete function (async-specific, not in original)
- Remove V-INT dispatch hook (no space for init guard)
- Section $00E200-$010200 at absolute capacity (0 bytes free)
- 68K async requires 20 bytes for stable init (unachievable)
- Keep async research docs for potential SH2-based implementation

Reasoning: 68K section cannot accommodate stable async without init code.
Future async work should pursue SH2 interrupt queue (Path B) from clean base.

Refs: ASYNC_STATUS.md, SH2_ASYNC_QUEUE_ANALYSIS.md
```

---

## Next Steps After Commit

### Option A: Abandon Async Entirely
- Focus on other optimization paths from [OPTIMIZATION_PLAN.md](OPTIMIZATION_PLAN.md)
- Blocking sync model may be "good enough" for target FPS

### Option B: SH2 Interrupt Queue (12-16 hours)
**Pros:**
- 64% Master SH2 idle time available
- CMD interrupt fully unused
- Saves 80+ bytes in cramped 68K section
- Better architectural separation

**Cons:**
- 12-16 hour implementation effort
- Requires SH2 vector table setup
- More complex debugging

**Decision criteria:** Only pursue if profiling shows current bottleneck is CPU sync overhead.

---

## Technical Context

### ROM Build Status
```bash
make clean && make all  # ✅ Builds successfully (4MB ROM)
```

### Test Status
- ✅ ROM boots to gameplay (baseline working)
- ✅ No freezes with async fully disabled
- ❌ Async freezes without init code (garbage in Work RAM $00FFD000)

### Key Memory Locations
- **$00E200-$010200:** 68K code section (0 bytes free)
- **$00FFD000-$00FFD00C:** Work RAM async queue (to be removed)
- **$001684:** V-INT handler (assembly mnemonics, working)
- **$00FF60:** Call site (currently blocking path `$E3B6`)

### Git Status
```
M disasm/sections/code_200.asm  (V-INT JSR disabled - line 2651)
M disasm/sections/code_e200.asm (call site disabled - line 3759)
```

---

## Files Modified This Session

1. [disasm/sections/code_e200.asm](disasm/sections/code_e200.asm) - Async functions (to be removed)
2. [disasm/sections/code_200.asm](disasm/sections/code_200.asm) - V-INT handler (JSR disabled)
3. [ASYNC_STATUS.md](ASYNC_STATUS.md) - Decision tree (keep)
4. [analysis/optimization/SH2_ASYNC_QUEUE_ANALYSIS.md](analysis/optimization/SH2_ASYNC_QUEUE_ANALYSIS.md) - SH2 research (keep)
5. [analysis/profiling/ASYNC_PROFILING_PLAN.md](analysis/profiling/ASYNC_PROFILING_PLAN.md) - Profiling plan (keep)
6. [test_async_fps.sh](test_async_fps.sh) - Profiling script (keep)

---

## Questions for Next Session

1. **Should we profile current blocking implementation first?**
   To establish baseline FPS before considering SH2 async

2. **Are there other optimization paths worth exploring?**
   See [OPTIMIZATION_PLAN.md](OPTIMIZATION_PLAN.md) for alternatives

3. **Is 68K→SH2 sync overhead actually a bottleneck?**
   May need profiling to confirm before investing 12-16 hours in SH2 async

---

**Summary:** Clean, working baseline restored. Async code removal in progress. Ready to commit and reassess optimization strategy from stable foundation.
