# R2 Register Trace Plan - Debugger Verification

## Status: Static Analysis INCONCLUSIVE - Debugger Needed

Date: 2026-01-20

---

## Static Analysis Results

### Search Results:
- ❌ R2 NOT initialized in Slave entry code ($020650-$0206A0)
- ❌ R2 NOT loaded from R14 structure
- ❌ R2 NOT set before work loop ($020662-$020688)
- ❌ Master does NOT write R2 to Slave's memory
- ✅ Found 638 R2 loads total in SH2 code (but none in Slave path)

### Key Findings:
1. **Slave work loop** at `$020688` calls `JSR @R2` without ever setting R2
2. **R14 structure** at RAM `0x22000400` does NOT contain R2 value
3. **Master SH2** loads `R2 = 0xFFFFFF80` (for its own use, not Slave)
4. **R2 value is unknown** - must come from boot/BIOS or persist from elsewhere

---

## Hypothesis: R2 Points to VDP Wait Function

### Most Likely Scenario:

**R2 = 0x0602050C** (VDP wait function in uncached ROM)
- OR -
**R2 = 0x2002050C** (VDP wait function in cached ROM)

### Evidence:
1. **VDP wait is at ROM $02050C** - perfect candidate for idle function
2. **VDP wait does minimal work** - just synchronization
3. **JSR @R2 in loop** would call VDP wait repeatedly
4. **This matches observed behavior** - Slave appears idle but synchronizes

### VDP Wait Function (ROM $02050C):
```assembly
$02050C: E000      MOV #0,R0
$02050E: 2106      MOV.W R0,@R1
$020510: 2106      MOV.W R0,@R1
$020512: 2106      MOV.W R0,@R1
$020514: 2106      MOV.W R0,@R1
$020516: 4710      DT R1
$020518: 8BF9      BF -7 (loop)
$02051A: 000B      RTS
$02051C: 0009      NOP
```

**If R2 points here**:
- Slave calls VDP wait ~100x per frame
- CPU busy but doing minimal work (memory writes + loop)
- **Effectively idle** - no rendering, just synchronization

---

## Debugger Verification Plan

### Emulator Setup

**Tool**: PicoDrive with embedded debugger (custom build)

**NOT**: Blastem, external GDB, or Gens KMod

### Breakpoint Plan

#### Breakpoint 1: Slave Entry
- **Location**: ROM `$020650` (SH2 address `0x06020650`)
- **Purpose**: Catch when Slave starts
- **Check**: R2 value at entry
- **Expected**: R2 should already be set (prove it's not initialized by Slave)

#### Breakpoint 2: Before JSR @R2
- **Location**: ROM `$020688` (SH2 address `0x06020688`)
- **Purpose**: Check R2 value right before first function call
- **Check**: R2 register value
- **Expected**: R2 = 0x0602050C or 0x2002050C (VDP wait)

#### Breakpoint 3: Inside JSR Target
- **Location**: ROM `$02050C` (SH2 address `0x0602050C`)
- **Purpose**: Verify JSR @R2 actually calls VDP wait
- **Check**: PC reaches this address
- **Expected**: Should hit repeatedly if R2 points here

---

## PicoDrive Embedded Debugger Commands

**Note**: Syntax depends on your specific PicoDrive debugger implementation. Adapt as needed.

### Typical Procedure:

1. **Launch with debugger enabled**:
   ```bash
   picodrive --debug build/vr_rebuild.32x
   ```

2. **Set breakpoints** (in debugger console/UI):
   ```
   # Breakpoint 1: Slave entry
   break sh2s 0x06020650

   # Breakpoint 2: Before JSR @R2
   break sh2s 0x06020688

   # Breakpoint 3: VDP wait function
   break sh2s 0x0602050C
   ```

3. **Examine registers when hitting breakpoint**:
   ```
   info registers        # Show all SH2 registers
   print r2              # Show R2 specifically
   x/4i r2               # Disassemble at R2 address
   ```

4. **Continue execution**:
   ```
   continue              # Resume until next breakpoint
   ```

---

## Memory Watch (If Breakpoints Not Available)

### PicoDrive Memory Watch Mode:

**Watch these values**:
1. **R2 register** (SH2 Slave CPU registers)
   - Monitor value during gameplay
   - Should be constant (function pointer)

2. **ROM $02050C** (execution tracking)
   - Count how many times this address executes
   - High count → R2 likely points here

3. **COMM registers** ($A15120-$A1512E from 68K, $20004020-$2000402E from SH2)
   - Monitor for Slave CPU writes
   - Verify communication pattern

---

## Expected Results by Scenario

### Scenario A: R2 → Real Work Function
**R2 value**: 0x06xxxxxx (ROM function, NOT VDP wait)
**Behavior**: Complex instructions, polygon processing
**Conclusion**: Slave is ACTIVE, optimization = load balancing

### Scenario B: R2 → Empty Stub (RTS only)
**R2 value**: 0x06xxxxxx (points to: `000B 0009` = RTS, NOP)
**Behavior**: Immediate return, no work
**Conclusion**: Slave is IDLE, optimization = add real work

### Scenario C: R2 → VDP Wait ($02050C)
**R2 value**: 0x0602050C or 0x2002050C
**Behavior**: Memory writes in loop, minimal work
**Conclusion**: Slave does SYNC work only, optimization = add parallel work

---

## Quick R2 Check (Minimal Steps)

**If your PicoDrive debugger has simple command mode**:

```bash
# Launch ROM with debugger
picodrive --debug build/vr_rebuild.32x

# In debugger console:
break sh2s 0x06020688    # Break before JSR @R2
run                      # Start game
# When breakpoint hits:
reg r2                   # Show R2 value
disasm r2 4              # Show 4 instructions at R2 address
continue                 # Resume
```

**Expected R2 value**: 0x0602050C or 0x2002050C (VDP wait hypothesis)

---

## Post-Debugger Analysis

### If R2 = 0x0602050C (VDP wait):
**Action**: Modify Slave loop to check COMM register before calling VDP wait
**Code change**:
```assembly
; Replace at $020688:
; OLD: JSR @R2 (calls VDP wait unconditionally)
; NEW: Check COMM4 for work flag first
;      If COMM4 == 0: call VDP wait (idle)
;      If COMM4 != 0: call real work function from COMM5/COMM6
```

### If R2 = Unknown Function:
**Action**: Disassemble that function to understand what Slave does
**Then**: Determine if it can be parallelized or needs replacement

### If R2 = NULL/Invalid:
**Action**: This would crash - unlikely scenario
**Check**: Boot sequence, verify ROM integrity

---

## Documentation After Trace

Create file: `R2_DEBUGGER_RESULTS.md`
- Record exact R2 value found
- Disassembly of target function
- Number of times called per frame
- CPU time spent in function
- Final determination: Active/Idle/Minimal

---

**Status**: Ready for debugger verification
**Tool**: PicoDrive with embedded debugger (custom build)
**Time estimate**: 30-60 minutes for full trace
**Single critical value**: R2 register at address 0x06020688
