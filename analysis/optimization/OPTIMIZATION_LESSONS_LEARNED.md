# Optimization Attempt: Lessons Learned

**Date**: January 6, 2026
**Attempted**: func_016 Inline Optimization
**Result**: ❌ ROM Crash
**Lesson**: Critical insights for future optimization attempts

---

## What Happened

### The Crash

**Test ROM**: `Virtua Racing - Test1.32x`
**Status**: Does not boot
**Cause**: Code expansion overwrote critical loop control logic

### Root Cause Analysis

**Original code at 0x02338C** (4 bytes):
```assembly
BF EC    BSR $02223368    ; Call func_016
00 09    NOP              ; Delay slot
```

**Attempted replacement** (32 bytes):
```assembly
; Inline func_016 body (32 bytes)
51 E7    MOV.L @($1C,R14),R1
52 E8    MOV.L @($20,R14),R2
... (15 instructions total)
1E 4D    MOV.L R4,@($34,R14)
```

**Code we destroyed** (bytes 4-31):
```assembly
60 A2    MOV.L @R10,R0        ; ← DESTROYED: Load value
88 00    CMP/EQ #0,R0         ; ← DESTROYED: Check if zero
8B 06    BF $022233A4         ; ← DESTROYED: Conditional branch
7A FC    ADD #-4,R10          ; ← DESTROYED: Pointer adjustment
47 10    DT R7                ; ← DESTROYED: Loop counter decrement
8F F9    BF/S $02223390       ; ← DESTROYED: Loop branch
7B C0    ADD #-64,R11         ; ← DESTROYED: (delay slot)
4F 26    LDS.L @R15+,PR       ; ← DESTROYED: Restore return address
00 0B    RTS                  ; ← DESTROYED: Return
00 09    NOP                  ; ← DESTROYED: Delay slot
```

**Impact**: We destroyed a **critical polygon processing loop** that:
- Iterates over polygon array
- Checks for zero/null entries
- Updates loop counters
- Returns to caller

**Result**: CPU executes our inlined code correctly, then continues into garbage bytes, causing undefined behavior → crash.

---

## Why This Is Hard

### The Code Expansion Problem

**Challenge**: Inlining replaces 4 bytes with 32 bytes (8× expansion)

**Options**:
1. **Overwrite following code** ❌ - We tried this, it crashes
2. **Use trampolines** ❌ - Unused ROM space is too far away (>4KB)
3. **Relocate overwritten code** ⚠️ - Complex, error-prone
4. **Accept we can't inline here** ✅ - Pragmatic choice

### ROM Structure Constraints

**Problem**: Virtua Racing ROM is tightly packed
- No nearby unused space (checked 0x23000-0x30000 range)
- Closest unused: 0x2F5C70 (2.8 MB away!)
- BRA instruction limit: ±4 KB
- JMP requires register setup → overhead defeats optimization

### Assembly-Level Challenges

**SH2 Branching**:
- **BRA**: 12-bit displacement (±2047 instructions × 2 = ±4094 bytes)
- **BSR**: Same range
- **JMP**: Can reach anywhere, but requires:
  ```assembly
  MOV.L @(PC+offset),R1  ; 2 bytes
  JMP @R1                 ; 2 bytes
  NOP                     ; 2 bytes (delay slot)
  .long target_address    ; 4 bytes
  ; Total: 10 bytes vs original 4 bytes = 6 bytes MORE overhead!
  ```

**Conclusion**: Trampolines are worse than the original BSR for distant targets.

---

## Correct Approaches for func_016

### Option 1: Accept Reality ✅ **RECOMMENDED**

**Conclusion**: func_016 cannot be efficiently inlined in this ROM without major restructuring.

**Why**:
- No nearby unused ROM space
- Trampolines add more overhead than they save
- Manual relocation is error-prone and not worth 5% gain

**Action**: Focus on other optimizations with better ROI

---

### Option 2: Manual Code Relocation ⚠️ ADVANCED

**If you really want the +5% gain**, you'd need to:

1. **Identify safe relocation target**
   - Find unused space within ±4KB of call sites
   - Or use end of ROM (but far from hot code = cache miss risk)

2. **Relocate overwritten code**
   - Copy destroyed bytes (28 bytes) to new location
   - Update branch targets to point to new location
   - Patch callers to use relocated code

3. **Insert inline code**
   - Place func_016 body at original call site
   - Add jump to relocated code at end

4. **Update all references**
   - Scan ROM for any jumps/branches to relocated code
   - Update them to new addresses
   - **Very error-prone!**

**Complexity**: High
**Risk**: High (easy to miss a reference)
**Reward**: 5% gain
**Verdict**: Not worth it for this optimization

---

### Option 3: Accept Partial Inline ❓ THEORETICAL

**Idea**: Inline only the most frequently called path

**How**:
```assembly
; Replace BSR with:
    CMP/EQ R14,R14      ; Always true (no-op but sets T flag)
    BT/S inline_code    ; Always taken, but uses delay slot well
    MOV.L @($1C,R14),R1 ; (delay slot - start of func_016)

inline_code:
    ; Continue with rest of func_016 inline...
    ; But we STILL have the expansion problem!
```

**Verdict**: Doesn't solve the core problem

---

## What We Should Do Instead

### Priority 1: func_065 FIFO Optimization ⭐⭐⭐

**Why Better**:
- func_065 is a **leaf function** (can be modified in isolation)
- **Already fully unrolled** (no code expansion needed)
- Only needs **code modification, not relocation**
- **+10-15% potential gain** (better than func_016's +5%)

**What to do**:
1. Profile R13 (stride) value to confirm destination
2. If destination = 0x24000000 (frame buffer):
   - Modify write pattern to batch 4 longs
   - Trigger VDP FIFO optimization
   - Gain: +10-15% in rasterization

**Risk**: Low (modification in place, no expansion)
**Reward**: High (+10-15%)
**Complexity**: Medium (need to understand data flow)

---

### Priority 2: Master/Slave Load Balancing ⭐⭐⭐

**Why Better**:
- **Potentially +20-40%** if Slave SH2 is underutilized
- Doesn't require code relocation
- Adds work to idle CPU rather than optimizing busy one

**What to do**:
1. Trace COMM register access patterns
2. Identify Master vs Slave work distribution
3. Move vertex transforms to Slave if it's idle
4. Use SDRAM buffers for coordination

**Risk**: Medium (need to understand synchronization)
**Reward**: Very High (+20-40% if Slave is idle)
**Complexity**: High (requires understanding both CPUs)

---

### Priority 3: Remove Indirect JSR Calls ⭐⭐

**Why Better**:
- Small, localized changes
- No code expansion
- **+2-3% gain** from removing 5-8 cycle overhead

**What to do**:
1. Profile which callbacks are actually used
2. If only 1-2 variants, replace JSR @R14 with:
   ```assembly
   MOV.L @($1C,R14),R0
   CMP/EQ #1,R0
   BT callback1
   BSR callback2
   ```

**Risk**: Low
**Reward**: Medium (+2-3%)
**Complexity**: Low

---

## Lessons for Future Optimizations

### 1. **Profile Before Patching**

- Use emulator debugger to trace actual execution
- Confirm assumptions (call frequency, register values)
- Measure before optimizing

### 2. **Check ROM Structure**

- Verify unused space exists nearby
- Calculate branch distances before coding
- Understand ROM layout constraints

### 3. **Start Small**

- Test one modification at a time
- Verify each change works before proceeding
- Create backups at every step

### 4. **Consider Alternatives**

- Inlining isn't always the answer
- Sometimes algorithmic changes are better
- Multi-CPU utilization often has bigger impact

### 5. **Accept Limitations**

- Some optimizations aren't feasible
- ROI analysis: is 5% gain worth weeks of work?
- Focus on high-impact, low-risk optimizations first

---

## Revised Optimization Roadmap

### Phase 1: Low-Hanging Fruit (This Week)

1. **Profile func_065 parameters** ✅ Easy, high value
   - Determine if FIFO optimization applies
   - Potential: +10-15%

2. **Analyze Master/Slave distribution** ✅ Medium effort, very high value
   - Trace COMM register usage
   - Potential: +20-40%

### Phase 2: Safe Optimizations (Next Week)

3. **Remove indirect JSR calls** ✅ Easy, low risk
   - Profile callback targets
   - Replace with direct calls
   - Potential: +2-3%

4. **Remove redundant operations** ✅ Easy, low risk
   - Remove final stride add in func_065
   - Remove unnecessary pointer resets
   - Potential: +1-2%

### Phase 3: Skip

5. **~~func_016 inlining~~** ❌ Not feasible without major restructuring

---

## Conclusion

**What we learned**:
- Virtua Racing ROM is tightly packed (no easy inline opportunities)
- Code expansion requires either relocation or trampolines
- Both approaches have significant complexity/overhead
- **Better optimizations exist** (func_065 FIFO, Master/Slave balance)

**What we gained**:
- Complete understanding of optimization constraints
- Knowledge of ROM structure and limitations
- Identified better targets for optimization
- Tools and analysis that remain valuable

**What's next**:
- Focus on **func_065 FIFO batching** (+10-15%)
- Investigate **Master/Slave balance** (+20-40%)
- Skip func_016 inline (not worth the complexity)

**Overall impact**: Still targeting **+20-30% gain** from safer optimizations

---

## Testing Notes

**Current ROM Status**:
- ❌ Test ROM (Virtua Racing - Test1.32x): Crashes - DO NOT USE
- ✅ Original ROM: Works perfectly
- ⏳ Future optimized ROM: TBD (will use func_065 + Master/Slave approach)

**Next steps**:
1. Delete test ROM (it's broken)
2. Focus on profiling func_065
3. Document Master/Slave work distribution
4. Create new optimization based on findings

---

## Historical Note

This failed optimization attempt is **valuable documentation** for the community:
- Shows why some optimizations aren't feasible
- Explains ROM structure constraints
- Demonstrates proper root cause analysis
- Guides future optimization efforts

**Failure is part of the process** - we learned more from this than we would have from easy success!

---

**Status**: Documented and understood
**Lesson**: Always verify ROM structure before attempting code expansion
**Next**: Focus on proven, lower-risk optimizations
