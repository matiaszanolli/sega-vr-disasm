# FPS Counter Diagnostic Report - FS Bit Tracking Failure

**Date:** February 8, 2026
**Status:** BLOCKED - Counter stuck at 00 (no FS bit transitions detected)
**Severity:** Critical - Unable to validate measurement methodology

---

## Problem Statement

The FPS counter displays **00** continuously from boot through attract mode. The raw flip counter (`fps_flip_counter`) never increments, indicating **zero FS bit transitions detected**.

This suggests either:
1. The FS bit in FBCTL is not changing (hardware/VRD behavior)
2. We're reading the wrong register or wrong bit
3. Logic error in transition detection
4. Initial state issue preventing first transition detection

---

## Implementation History

### Iteration 1: Epilogue-Only Tracking (FAILED - Work Path Bug)
**Code Location:** `vint_epilogue` (lines 92-102)
**Symptom:** Counter reached 99 during boot, then stuck at 99 in attract mode
**Root Cause:** Epilogue only runs on work path (`$C87A != 0`). During attract mode (no-work frames), epilogue never executed.
**Fix:** Moved FS tracking to wrapper (runs every V-INT).

### Iteration 2: Wrapper Tracking Without Register Save (FAILED - Register Clobbering)
**Code Location:** `fps_vint_wrapper` (lines 66-98)
**Symptom:** Counter stuck at 00 from boot
**Root Cause:** Clobbered D0/D1 without saving, likely breaking original V-INT handler's buffer flip logic.
**Fix:** Added `movem.l d0-d1,-(sp)` / `movem.l (sp)+,d0-d1`.

### Iteration 3: Wrapper Tracking With Register Save (CURRENT - BLOCKED)
**Code Location:** `fps_vint_wrapper` (lines 66-104)
**Symptom:** Counter still stuck at 00
**Status:** Unknown root cause - needs diagnostic investigation.

---

## Current Implementation

**File:** [fps_vint_wrapper.asm:66-104](disasm/modules/68k/optimization/fps_vint_wrapper.asm#L66-L104)

```asm
fps_vint_wrapper:
        ; Save registers used by FPS tracking (D0-D1)
        movem.l d0-d1,-(sp)

        ; === ALWAYS RUN: FS BIT TRANSITION DETECTOR (before work gate) ===
        move.w  FBCTL,d0                ; Read FBCTL ($00A1518A)
        andi.w  #1,d0                   ; Isolate FS bit (bit 0)
        cmp.w   fps_fs_last,d0          ; Compare to last known state
        beq.s   .no_flip                ; Same state = no flip

        ; FS bit changed - buffer flip occurred
        addq.l  #1,fps_flip_counter     ; Increment flip counter
        move.w  d0,fps_fs_last          ; Update last state

.no_flip:
        ; === TEST 1: Display raw flip counter modulo 100 every V-INT ===
        move.w  fps_flip_counter,d1     ; Low 16 bits
        divu    #100,d1                 ; Quotient:low, remainder:high
        swap    d1                      ; Remainder -> low word
        move.w  d1,fps_value            ; Show raw counter % 100

        ; COMM mirrors for debugging
        move.w  fps_flip_counter,$00A15128  ; COMM4 = flip_counter low word
        move.w  fps_value,$00A1512A         ; COMM5 = display value (counter % 100)

        ; Restore registers before continuing to original handler
        movem.l (sp)+,d0-d1

        ; Work gate + render + jump to original handler...
```

**Key Registers:**
- `FBCTL = $00A1518A` (Frame Buffer Control, bit 0 = FS)
- `fps_fs_last = $FFFFE60C` (Last FS bit state, initialized to 0)
- `fps_flip_counter = $FFFFE604` (Total flip count, initialized to 0)

**Execution Path:**
- Runs **every V-INT** (before work gate at `$C87A`)
- Registers saved/restored around FS tracking
- COMM4/COMM5 mirrored for debugger visibility

---

## Diagnostic Data Needed

### Priority 1: FBCTL Register Contents
**Question:** What is the actual value of FBCTL during execution?

**Test:** Add diagnostic to display raw FBCTL value instead of processed counter.

```asm
; Replace Test 1 display with raw FBCTL display:
move.w  FBCTL,d1                ; Read raw FBCTL
move.w  d1,fps_value            ; Display raw register value (0-65535)
move.w  d1,$00A1512A            ; COMM5 = raw FBCTL
```

**Expected Results:**
- If FBCTL changes: FS bit is toggling, logic error in our tracking
- If FBCTL constant: Hardware not flipping buffers OR wrong register

### Priority 2: FS Bit Isolation Verification
**Question:** Is the FS bit actually in bit 0 of FBCTL?

**Hardware Manual Reference:** Section 4.3.1 states bit 0 is FS (Frame Select).

**Test:** Display isolated FS bit directly.

```asm
move.w  FBCTL,d1
andi.w  #1,d1                   ; Isolate bit 0
lsl.w   #4,d1                   ; Shift to tens place (0 or 10)
move.w  d1,fps_value            ; Display as 00 or 10
```

**Expected Results:**
- Alternating 00/10: FS bit toggling correctly
- Constant 00: FS always 0
- Constant 10: FS always 1

### Priority 3: Transition Detection Logic Verification
**Question:** Is the state comparison working correctly?

**Current Logic Issue:** If initial FBCTL reads 0 and `fps_fs_last` is initialized to 0, first comparison is equal → no increment → `fps_fs_last` never updated → stuck in "equal" state forever if FS stays 0.

**Fix:** Always update `fps_fs_last` to current state, even if no transition:

```asm
move.w  FBCTL,d0
andi.w  #1,d0
cmp.w   fps_fs_last,d0
beq.s   .no_flip
addq.l  #1,fps_flip_counter     ; Increment on transition
.no_flip:
move.w  d0,fps_fs_last          ; ALWAYS update last state (CRITICAL FIX)
```

**Why This Matters:** Without unconditional update, if first read matches initialized value, we never track subsequent transitions.

### Priority 4: COMM Register Verification
**Question:** Are COMM4/COMM5 actually being written?

**Test:** Check COMM4/COMM5 in debugger or via memory dump.

**Expected:**
- COMM4 (`$00A15128`) = `fps_flip_counter` low word
- COMM5 (`$00A1512A`) = `fps_value` (00 if counter stuck)

If COMM registers show unexpected values, wrapper may not be executing.

---

## Hypotheses (Ordered by Likelihood)

### Hypothesis A: Logic Error - State Update Bug (HIGH PROBABILITY)
**Theory:** `fps_fs_last` only updated on transitions, not every V-INT. If first read matches initialized value (0), we never update `fps_fs_last`, so all subsequent reads compare against stale 0.

**Evidence:**
- Stuck at 00 from boot (never increments)
- Logic only updates `fps_fs_last` inside "transition detected" branch

**Test:** Move `move.w d0,fps_fs_last` outside the conditional (always execute).

**Fix Confidence:** High (90%)

### Hypothesis B: Wrong Register Address (MEDIUM PROBABILITY)
**Theory:** FBCTL at `$00A1518A` is not the correct register, or FS bit is not in bit 0.

**Evidence:**
- Previous attempt read wrong register (`$00A15100`) and showed 00
- Current attempt also shows 00
- Pattern suggests register/bit location issue

**Test:** Display raw FBCTL value to see if it changes at all.

**Fix Confidence:** Medium (60% - manual says bit 0, but could be doc error)

### Hypothesis C: VRD Doesn't Flip Buffers in Attract Mode (LOW PROBABILITY)
**Theory:** VRD only flips buffers during active gameplay, not attract mode.

**Evidence Against:**
- Attract mode displays animated graphics (requires frame buffer writes)
- Previous iteration showed 19-20 FPS during gameplay (FS was toggling then)

**Test:** Start a race and observe if counter starts incrementing.

**Fix Confidence:** Low (20% - contradicts prior observations)

### Hypothesis D: Hardware Timing Issue (LOW PROBABILITY)
**Theory:** Reading FBCTL during V-INT catches FS mid-transition, always reads same value.

**Evidence Against:**
- Hardware manual doesn't mention timing restrictions on FBCTL reads
- Register read should be atomic

**Test:** Read FBCTL multiple times during V-INT, compare values.

**Fix Confidence:** Very Low (5%)

---

## Recommended Next Steps

### Step 1: Fix State Update Logic (Immediate)
**Action:** Move `move.w d0,fps_fs_last` outside conditional.

**Current Code:**
```asm
cmp.w   fps_fs_last,d0
beq.s   .no_flip
addq.l  #1,fps_flip_counter
move.w  d0,fps_fs_last          ; Only on transition
.no_flip:
```

**Fixed Code:**
```asm
cmp.w   fps_fs_last,d0
beq.s   .no_flip
addq.l  #1,fps_flip_counter
.no_flip:
move.w  d0,fps_fs_last          ; ALWAYS update
```

**Rationale:** This ensures `fps_fs_last` tracks current FS bit state every V-INT, not just when transitions occur. Fixes the "first read matches initialized value" deadlock.

### Step 2: Add Raw FBCTL Diagnostic (If Step 1 Fails)
**Action:** Replace Test 1 counter display with raw FBCTL value.

**Purpose:** Determine if FBCTL register is changing at all.

### Step 3: Test During Gameplay (If Step 1 Fails)
**Action:** Start a race, observe if counter increments during active gameplay.

**Purpose:** Determine if FS bit only toggles during work frames (contradicts current understanding).

### Step 4: Audit Original V-INT Handler (If All Else Fails)
**Action:** Disassemble original V-INT handler at `$00881684` to find where/how VRD flips buffers.

**Purpose:** Understand VRD's frame buffer management to verify our assumptions.

---

## Critical Questions

1. **Is `fps_fs_last` being updated every V-INT?**
   **Current:** No (only on transitions)
   **Should Be:** Yes (always track current state)

2. **Is FBCTL the correct register for FS bit?**
   **Manual Says:** Yes (Section 4.3.1, bit 0)
   **Needs Verification:** Display raw FBCTL to confirm

3. **Does VRD flip buffers during attract mode?**
   **Assumption:** Yes (graphics update)
   **Needs Verification:** Test during gameplay vs attract

4. **Are we reading FS bit at the right time?**
   **Current:** During V-INT wrapper (before original handler)
   **Alternative:** After queue drain in epilogue (when flip would occur)

---

## Files Involved

| File | Lines | Role |
|------|-------|------|
| [fps_vint_wrapper.asm](disasm/modules/68k/optimization/fps_vint_wrapper.asm) | 66-104 | FS bit tracking logic |
| [fps_render.asm](disasm/modules/68k/optimization/fps_render.asm) | 44-83 | Display renderer |
| [ring_buffer_init.asm](disasm/modules/68k/boot/ring_buffer_init.asm) | 43-48 | FPS RAM initialization |

---

## Success Criteria

The FPS counter is working correctly when:
1. ✅ Counter increments during boot (work frames)
2. ✅ Counter continues incrementing in attract mode (no-work frames)
3. ✅ Counter shows ~20 during gameplay (matches profiling data)
4. ✅ COMM4 shows incrementing flip counter
5. ✅ COMM5 matches displayed value

**Current Status:** ❌ All criteria failing (counter stuck at 00)

---

## Request for Review

**Primary Question:** Is there an obvious logic error or hardware misunderstanding that explains why FS bit transitions are not being detected?

**Specific Areas for Review:**
1. State update logic (should `fps_fs_last` update every V-INT?)
2. Register address verification (is FBCTL `$00A1518A` correct?)
3. Bit position verification (is FS actually bit 0?)
4. Timing assumptions (can we read FBCTL during V-INT wrapper?)

**Next Action:** Recommend Priority 1 diagnostic (raw FBCTL display) or immediate logic fix (unconditional state update).

---

**Last Updated:** February 8, 2026 (20:10 UTC)
**For Review By:** Codex (Claude Code session)
**Reported By:** Primary development session
