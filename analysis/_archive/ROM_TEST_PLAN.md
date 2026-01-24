# ROM Testing Plan - Diagnosing func_065 Modification Issues

## Problem Summary

All attempts to modify func_065 have resulted in crashes:
- ❌ Relocation with trampoline (multiple attempts)
- ❌ In-place FIFO optimization (FIFO-MINIMAL.32x)

**Key Finding:** No ROM checksums or integrity checking on 32X - crashes are code logic bugs, not protection.

## Critical Bug Found in FIFO-MINIMAL

**FIFO-MINIMAL.32x has a fatal flaw:**
- Added spurious `RTS + NOP` epilogue
- Original func_065 has NO epilogue (exactly 148 bytes: prologue + 14 iterations)
- Early return corrupts stack/execution flow

```
Original func_065:
  Prologue (8 bytes) + 14 iterations (140 bytes) = 148 bytes
  Falls through to next function at 0x23FC2

FIFO-MINIMAL (BUGGY):
  Prologue + FIFO pairs + iterations + RTS/NOP = 148 bytes
  Returns early with RTS → CRASH!
```

## Test ROM Hierarchy (Priority Order)

### 1. FIFO-SINGLE.32x ⭐ **TEST THIS FIRST**

**What it tests:** Minimal FIFO batching with correct structure

**Changes:**
- First 2 iterations → FIFO pattern (4 consecutive writes)
- Remaining 12 iterations → unchanged
- Uses original `ADD R13,R1` stride logic (no assumptions!)
- Exact 148 bytes, no epilogue

**Structure:**
```
Prologue:     8 bytes  (unchanged)
FIFO pair:   20 bytes  (iterations 1-2 with 4 consecutive writes)
Normal:     120 bytes  (iterations 3-14, original pattern)
Total:      148 bytes  (perfect fit, no epilogue)
```

**Expected results:**
- ✅ **If works:** FIFO batching is safe! Can scale up optimization
- ⚠️ **If minor glitch:** Address calculation issue, but mechanism works
- ❌ **If crashes:** FIFO writes themselves are problematic

**Why this is safest:**
- Only 1 of 7 potential FIFO pairs implemented (minimal risk)
- Uses exact original stride logic
- Preserves function structure
- No assumptions about R13 value

---

### 2. MINIMAL-NOP.32x 🔬 **TEST IF FIFO-SINGLE CRASHES**

**What it tests:** Whether func_065 can be modified at all

**Changes:**
- Single instruction changed: `ADD R13,R1` → `NOP`
- Location: 0x23F3E (end of first iteration)
- Total: 2 bytes modified

**Expected results:**
- ✅ **If boots with glitches:** Modifications are tolerated, FIFO logic is the problem
- ❌ **If crashes:** func_065 cannot be modified (timing-critical or init code)

**Why test this:**
- Absolute minimal change (2 bytes)
- Functionally incorrect (will corrupt graphics)
- But should NOT crash if modification itself is allowed
- Distinguishes "code is wrong" from "code cannot be touched"

---

### 3. NULL.32x ✅ **BASELINE (Already Tested - Works)**

**What it tests:** Patching infrastructure

**Changes:** None (exact copy of original bytes)

**Status:** Known to work perfectly

**Why mention:** Confirms patching mechanism is sound

---

## Diagnostic Decision Tree

```
Start
  │
  ├─ Test: FIFO-SINGLE.32x
  │
  ├─ Works? ────────────────────────────────────► ✅ FIFO batching viable!
  │                                                    Scale up to more pairs
  │                                                    Expected: +3-8% FPS gain
  │
  ├─ Minor glitch? ─────────────────────────────► ⚠️ Check R13 value
  │                                                    Profile actual stride
  │                                                    Adjust FIFO pattern
  │
  └─ Crashes? ──► Test: MINIMAL-NOP.32x
                   │
                   ├─ Works? ─────────────────────► ❌ FIFO writes problematic
                   │                                   Try different optimization:
                   │                                   - Register optimization
                   │                                   - Loop unrolling
                   │                                   - Cache optimization
                   │
                   └─ Crashes? ───────────────────► ❌ func_065 untouchable
                                                       Reasons:
                                                       - Called during init
                                                       - Timing-critical
                                                       - Hardware dependency

                                                       Next steps:
                                                       - Optimize different function
                                                       - Focus on Slave CPU
                                                       - VDP polling elimination
```

## Why Relocation Failed (All Attempts)

Separate issue from in-place modifications:
- Trampoline adds latency (JMP instruction)
- Stack might not be valid during early calls
- Timing-sensitive code breaks with added jump
- Cache coherency between trampoline and relocated code

**Conclusion:** Even if FIFO batching works, it must be in-place (no relocation).

## Files Generated

| ROM File | Purpose | Status |
|----------|---------|--------|
| `Virtua Racing - NULL.32x` | Baseline test | ✅ Works |
| `Virtua Racing - FIFO-SINGLE.32x` | Minimal FIFO (correct) | ⏳ Test first |
| `Virtua Racing - MINIMAL-NOP.32x` | 2-byte modification test | ⏳ Test if FIFO-SINGLE fails |
| `Virtua Racing - FIFO-MINIMAL.32x` | ❌ BUGGY (spurious epilogue) | ❌ Don't use |
| `Virtua Racing - RELOCATED-NULL.32x` | Relocation test | ❌ Failed |
| `Virtua Racing - FIFO.32x` | Full FIFO + relocation | ❌ Failed |

## Next Steps Based on Results

### If FIFO-SINGLE works:
1. Scale up to 2-3 FIFO pairs
2. Measure actual FPS gain
3. Profile R13 to optimize further
4. Document working FIFO pattern

### If FIFO-SINGLE fails but MINIMAL-NOP works:
1. Abandon FIFO optimization
2. Try different optimization:
   - Inline small functions
   - Register allocation optimization
   - Cache-friendly data layout
3. Focus on VDP polling elimination (bigger gain anyway)

### If both fail:
1. func_065 is off-limits
2. Optimize different hotspots:
   - func_016 (3D transformation)
   - VDP polling loops (47% waste!)
   - 68000 synchronization
3. Activate Slave CPU (99.97% idle!)
4. Interrupt-driven architecture

## Key Lessons

1. ✅ No ROM checksums on 32X (modifications allowed)
2. ❌ Relocation doesn't work (timing/latency issues)
3. ⚠️ Original function structure must be preserved (no spurious epilogues!)
4. 🔍 Need empirical testing - static analysis isn't enough

## Recommendation

**Test FIFO-SINGLE.32x immediately.** This is our best shot at:
- Correct structure (148 bytes, no epilogue)
- Minimal risk (1 FIFO pair)
- No assumptions (uses original ADD R13,R1)
- Easiest to debug if it fails

Results will tell us if FIFO batching is viable at all.
