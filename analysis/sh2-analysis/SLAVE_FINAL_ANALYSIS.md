# Slave SH2 - CORRECTED Final Analysis

Date: 2026-01-20
Status: ✅ VERIFIED THROUGH USER QUESTIONS

## ✅ UPDATE: v4.0 RESOLUTION (2026-01-25)

**The questions raised in this document have been RESOLVED through implementation:**

- The Slave idle loop at $0203CC was bypassed via full assembly rebuild
- func_021 (vertex transform) has been offloaded to Slave SH2
- **TRUE PARALLEL PROCESSING is now operational**

**What we learned:**
- Scenario B was essentially correct: Slave had work infrastructure but minimal actual work
- The fix: Redirected idle loop to `slave_work_wrapper` at $300200
- Result: Slave now executes `func_021_optimized` with real game parameters

**See:** [SLAVE_INJECTION_GUIDE.md](SLAVE_INJECTION_GUIDE.md) for implementation details.

---

## HISTORICAL ANALYSIS (2026-01-20)

*The analysis below is preserved for historical context. It correctly identified the opportunity, though the implementation approach differed from what was anticipated.*

---

## EXECUTIVE SUMMARY

**Previous claim**: Slave SH2 sits in infinite idle loop writing "OVRN", wasting 99.7% of CPU.
**Reality**: Slave has a **work processing loop** that calls function pointers. Whether it's idle depends on what R2 points to.

---

## Answers to Critical Verification Questions

### 1. Does Slave enter idle loop immediately, or conditionally?

**ANSWER**: **CONDITIONALLY** - after handshake with Master

**Execution sequence**:
1. Slave entry at ROM `$020650`
2. Handshake wait loop `$020656-$020660` - waits for Master signal
3. Stack initialization `$020662-$020688`
4. Work processing loop `$020688-$020696` - calls `JSR @R2` repeatedly
5. Loop exits when `R10 > R11` (work counter exhausted)

**Handshake loop** ($020656-$020660):
```assembly
$020656: MOV.L @(0,R14),R0      ; Read flag from memory
$020658: MOV.L @(19,PC),R1      ; Load expected value
$02065A: CMP/EQ R1,R0           ; Compare
$02065C: BT +2                  ; EXIT if match → proceed to $020662
$02065E: BRA -12                ; Loop if no match
```

**This is NOT an infinite idle loop** - it has an EXIT condition!

---

### 2. Is COMM3 read by other components?

**ANSWER**: **YES - EXTENSIVELY USED**

**SH2 references**: 12 locations write to COMM3 (0x2000402C)
**68K references**: 55+ locations access COMM3 (0xA1512C)

**Infinite COMM3 write loop found**:
- Location: ROM `$0203CC`
- Code:
  ```assembly
  $0203CC: MOV.L @(1,PC),R1    ; R1 = COMM3 address
  $0203CE: MOV.L R0,@R1        ; Write R0 to COMM3
  $0203D0: BRA -4              ; Loop forever
  ```

**CRITICAL**: This loop is at `$0203CC`, which is **644 bytes BEFORE** the Slave entry (`$020650`).

**This means**:
- The COMM3 loop is **NOT** the Slave's main code path
- It's likely **Master SH2 code** or an **error handler**
- Previous analysis confused Master and Slave code sections!

---

### 3. Does the loop poll conditions or just write?

**ANSWER**: **THREE DIFFERENT LOOPS WITH DIFFERENT BEHAVIORS**

#### Loop A: Handshake Wait (Slave $020656) - **POLLS & EXITS**
- **Behavior**: Polls memory flag set by Master
- **Exit condition**: When R0 == R1
- **Purpose**: Synchronization handshake

#### Loop B: Work Processing (Slave $020688) - **CALLS FUNCTIONS & EXITS**
- **Behavior**: Calls work functions via JSR @R2
- **Exit condition**: When R10 > R11 (counter exhausted)
- **Purpose**: Process work items
- **Code**:
  ```assembly
  $020688: JSR @R2              ; Call work function
  $02068A: MOV #0,R8            ; Reset R8
  $02068C: CMP/GT R11,R10       ; R10 > R11?
  $02068E: BT +6                ; EXIT if yes
  $020690: ADD #1,R10           ; R10++
  $020692: ADD #1,R8            ; R8++
  $020694: BRA -12              ; Loop back
  ```

#### Loop C: COMM3 Write (Master? $0203CC) - **INFINITE, NO POLLING**
- **Behavior**: Writes R0 to COMM3 forever
- **Exit condition**: NONE
- **Purpose**: Unknown - error state? Debug marker?
- **Not part of Slave execution path!**

---

## Key Discovery: R2 Function Pointer Architecture

**Found**: **151 JSR @R2 calls** throughout the entire ROM!

This reveals that R2 is a **function pointer register** used extensively by the rendering engine:
- NOT a Slave-specific pattern
- Standard calling convention for dynamic dispatch
- Used by both Master and Slave CPUs

**Implication**: The Slave work loop at `$020688` is part of a larger function pointer architecture. Whether the Slave is "idle" depends entirely on what R2 points to:

| R2 Points To | Slave State | CPU Usage |
|--------------|-------------|-----------|
| Real work function | **ACTIVE** | Doing useful work |
| Empty stub (just RTS) | **IDLE** | Wasting cycles |
| NULL/invalid | **CRASHED** | Game would hang |

---

## REVISED Understanding

### What We GOT WRONG ❌

1. **Location**: Previous analysis confused Master code with Slave code
2. **Infinite loop**: The COMM3 loop is NOT in Slave's execution path
3. **"OVRN" marker**: Not found in ROM - likely misidentified
4. **99.7% waste claim**: Based on wrong code section

### What We GOT RIGHT ✅

1. **Slave entry**: $020650 confirmed
2. **COMM register usage**: Extensive (12 SH2 + 55 68K references)
3. **Handshake protocol**: Exists and works correctly
4. **Work distribution opportunity**: Still valid IF R2 points to stub

---

## What We STILL DON'T KNOW ⚠️

### Critical Unknown: **What does R2 point to during gameplay?**

**Three scenarios**:

1. **Scenario A: R2 → Real rendering function**
   - Slave IS actively rendering
   - NO idle waste
   - Optimization target: Improve load balancing, not activation

2. **Scenario B: R2 → Empty stub (RTS only)**
   - Slave loops but does no work
   - Significant CPU waste
   - Optimization target: Replace stub with real work

3. **Scenario C: R2 → VDP wait or minimal function**
   - Slave does minimal synchronization work
   - Some CPU waste
   - Optimization target: Add parallel work between sync points

**To determine**: Need to trace R2 initialization or use debugger to check R2 value at runtime.

---

## Implications for Optimization

### IF Scenario A (Slave is active):
- Measure actual Master/Slave workload distribution
- Optimize work balancing, not activation
- Look for pipeline stalls or synchronization overhead

### IF Scenario B (Slave calls stub):
- Original plan is valid: replace stub with real work
- Focus on finding where R2 gets set to stub
- Implement work distribution protocol via COMM registers

### IF Scenario C (Slave does minimal work):
- Hybrid approach: keep sync work, add parallel processing
- Careful not to break existing synchronization
- Incremental parallelization strategy

---

## Next Steps (Revised)

### Immediate (BEFORE any modifications):

1. **Trace R2 initialization**
   - Search for where R2 is loaded before work loop
   - Check if Master writes R2 value to Slave's memory
   - Identify what address/function R2 points to

2. **Verify runtime R2 value** (if emulator supports it)
   - Set breakpoint at `$020688` (Slave work loop)
   - Inspect R2 register value
   - Check if R2 points to code or stub

3. **Disassemble R2 target**
   - Once R2 address known, disassemble that function
   - Determine if it's real work (rendering) or stub (RTS)

### Only AFTER R2 verification:

4. Implement appropriate optimization strategy (A, B, or C above)
5. Test modifications atomically
6. Measure FPS improvement

---

## Files Created/Updated

- [SLAVE_VERIFICATION_RESULTS.md](SLAVE_VERIFICATION_RESULTS.md) - Initial findings
- [SLAVE_FINAL_ANALYSIS.md](SLAVE_FINAL_ANALYSIS.md) - This document

---

## Acknowledgment

**User's verification questions exposed critical flaws** in the automated analysis:
- ✅ Prevented incorrect modifications
- ✅ Revealed Master/Slave code confusion
- ✅ Identified need for R2 tracing
- ✅ Saved significant debugging time

**Lesson**: Always verify automated analysis results before implementation!

---

**Status**: Analysis corrected, R2 tracing needed
**Confidence**: High on what we found, Low on Slave idle claim
**Next Action**: Trace R2 initialization to determine actual Slave behavior
