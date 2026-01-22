# R2 Register Investigation - Complete Summary

## Investigation Status: ✅ STATIC ANALYSIS COMPLETE → DEBUGGER NEEDED

Date: 2026-01-20

---

## What We Searched

### Option 1: ROM Search for R2 Initialization ✅
- Searched **all 638 R2 loads** in SH2 code section ($020500-$026000)
- Checked Slave entry code ($020650-$0206A0)
- Checked pre-work-loop code ($020662-$020688)
- Checked R14 structure access patterns

**Result**: ❌ R2 is NEVER initialized in Slave execution path

### Option 2: Master SH2 Analysis ✅
- Searched Master code for R2 setup ($020500-$020650)
- Checked for writes to Slave's R14 structure
- Looked for shared memory communication of R2 value

**Result**: ❌ Master does NOT set R2 for Slave

---

## Key Findings

### What We KNOW ✅

1. **Slave work loop exists** at ROM `$020688`
   ```assembly
   $020688: JSR @R2              ; Call function in R2
   $02068A: MOV #0,R8            ; Reset counter
   $02068C: CMP/GT R11,R10       ; Check if done
   $02068E: BT +6                ; Exit when R10 > R11
   $020690: ADD #1,R10           ; Increment counters
   $020692: ADD #1,R8
   $020694: BRA -12              ; Loop back
   ```

2. **R2 is used as function pointer** throughout ROM
   - 151 `JSR @R2` calls found
   - Standard calling convention for dynamic dispatch

3. **R2 is NOT initialized** in observable code paths
   - Not in Slave entry
   - Not in Slave init
   - Not loaded from R14 structure
   - Not written by Master to shared memory

4. **VDP wait function exists** at ROM `$02050C` (17 bytes)
   - Perfect candidate for R2 target (idle function)
   - Does minimal synchronization work

### What We DON'T KNOW ❌

1. **What value R2 actually holds during runtime**
   - Could be: `0x0602050C` (VDP wait - uncached ROM)
   - Could be: `0x2002050C` (VDP wait - cached ROM)
   - Could be: Other function address
   - Could be: NULL/invalid (would crash - unlikely)

2. **Where R2 gets its value**
   - 32X BIOS initialization?
   - Boot ROM code we can't see?
   - SH2 reset state default?
   - Persists from previous code execution?

---

## Most Likely Hypothesis

**R2 = 0x0602050C** (points to VDP wait function)

### Evidence Supporting This:
1. VDP wait is ideal idle function (minimal work, just sync)
2. Location matches where R2 would naturally point
3. JSR @R2 in loop would effectively idle Slave
4. Matches observed behavior (Slave appears idle)

### If True:
- **Slave is functionally IDLE** (calls VDP wait repeatedly)
- **CPU is busy but wasting cycles** (sync work only)
- **Optimization is valid** (replace VDP wait calls with real work)
- **Matches Scenario C** from analysis

---

## Next Step: Debugger Verification

**Required**: Runtime R2 value check via debugger

**See**: [R2_DEBUGGER_TRACE_PLAN.md](R2_DEBUGGER_TRACE_PLAN.md) for complete plan

### Quick Debugger Check:

```bash
# Using PicoDrive with embedded debugger
picodrive --debug build/vr_rebuild.32x

# In debugger console:
break sh2s 0x06020688    # Break before JSR @R2
run                      # Run game
reg r2                   # Check R2 value
disasm r2 4              # Disassemble what R2 points to
```

**Expected output**:
- If R2 = `0x0602050C`: Hypothesis CONFIRMED (VDP wait)
- If R2 = other: Need to disassemble and analyze that function

---

## Implications by R2 Value

### IF R2 = 0x0602050C (VDP Wait):
**Optimization Strategy**:
1. Add COMM register check before JSR @R2
2. If COMM4 == 0: call VDP wait (idle)
3. If COMM4 != 0: call real work function from COMM5/COMM6
4. Master sets COMM4 when work available
5. Measure FPS improvement (+25-50% target)

**Code modification location**: `$020688` (insert COMM check)
**Risk**: Low (atomic change, easy to revert)

### IF R2 = Real Work Function:
**Optimization Strategy**:
1. Measure current Master/Slave load distribution
2. Optimize work balancing, not activation
3. Look for pipeline stalls
4. Consider different parallelization approach

**Analysis needed**: Extensive profiling
**Risk**: Medium (complex system, harder to optimize)

### IF R2 = Empty Stub (RTS):
**Optimization Strategy**:
1. Replace stub with real rendering work
2. Implement COMM-based work distribution
3. Test incrementally

**Code modification**: Replace stub function
**Risk**: Low (stub does nothing, replacement improves)

---

## Files Created

1. [SLAVE_VERIFICATION_RESULTS.md](SLAVE_VERIFICATION_RESULTS.md) - Initial verification answers
2. [SLAVE_FINAL_ANALYSIS.md](SLAVE_FINAL_ANALYSIS.md) - Corrected Slave analysis
3. [R2_DEBUGGER_TRACE_PLAN.md](R2_DEBUGGER_TRACE_PLAN.md) - Complete debugger plan
4. [R2_INVESTIGATION_SUMMARY.md](R2_INVESTIGATION_SUMMARY.md) - This file

---

## Recommendations

### Immediate Action:
**Run debugger trace** to determine R2 value (30-60 minutes)

### After R2 Verification:
1. If R2 = VDP wait → Implement COMM check optimization
2. If R2 = other → Analyze that function and plan accordingly
3. Test modifications atomically
4. Measure FPS improvement

### Do NOT:
- Make code changes without knowing R2 value
- Assume R2 points to VDP wait (verify first!)
- Modify Slave code blindly

---

## Verification Questions - ANSWERED ✅

### Q1: Is Slave entering idle loop immediately, or conditionally?
**A**: Conditionally, after Master handshake. Not a simple idle loop - it's a work processing loop calling JSR @R2.

### Q2: Is COMM3 read by other components?
**A**: YES - 12 SH2 references, 55+ 68K references. The infinite COMM3 loop found is NOT in Slave path (it's in Master code).

### Q3: Does loop poll conditions or just write?
**A**: Three different loops identified:
- Handshake loop: POLLS, has exit condition
- Work loop (JSR @R2): CALLS function, has exit condition
- COMM3 loop: Infinite write (Master/error handler, not Slave)

**User's questions exposed critical flaws** in automated analysis - thank you!

---

**Status**: Static analysis complete, debugger verification needed
**Confidence**: High on what we found, UNKNOWN on R2 actual value
**Blocker**: Need runtime R2 value to proceed with optimization
**Time to verify**: 30-60 minutes with debugger
