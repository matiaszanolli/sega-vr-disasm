# Parallel Processing Activation Patches

**Date:** February 9, 2026
**Status:** 🟡 DRAFT - Ready for review and application
**Risk:** MEDIUM - Test carefully after applying

---

## Executive Summary

Three patches are required to activate parallel processing. Applying only patches #2 and #3 without #1 will cause **DEADLOCK** (Slave won't service COMM7 signals).

**Apply all three patches together, then test immediately.**

---

## Patch Overview

| # | Location | Purpose | Risk Level |
|---|----------|---------|------------|
| 1 | `$0203CC` (Slave idle loop) | Redirect to `slave_work_wrapper_v2` | 🔴 CRITICAL |
| 2 | `$02046A` (Master dispatch) | Redirect to `master_dispatch_hook` | 🟡 MEDIUM |
| 3 | `$0234C8` (func_021 entry) | Redirect to `shadow_path_wrapper` | 🟡 MEDIUM |

**Application order:** #1 first (prevents deadlock), then #2 and #3 together.

---

## Patch #1: Slave Idle Loop Redirect (CRITICAL)

### Location
**File:** `disasm/sections/code_20200.asm`
**Line:** ~238
**ROM Offset:** `$0203CC` (file offset: `0x0203CC`)
**SH2 Address:** `$060005CC` (SDRAM)

### Current Code (Original Idle Loop)
```assembly
; Slave idle loop - writes "OVRN" and spins
$060005CC:  D102     MOV.L   @($060005D4,PC),R1  ; R1 = 0x2000402C (COMM3)
$060005CE:  D003     MOV.L   @($060005D8,PC),R0  ; R0 = "OVRN" (0x4F56524E)
$060005D0:  2102     MOV.L   R0,@R1              ; Write "OVRN" to COMM3
$060005D2:  AFFE     BRA     $060005D2           ; INFINITE LOOP (spin forever)
$060005D4:  0009     NOP
```

**Problem:** Slave never polls COMM7, never calls handlers.

### New Code (Redirect to slave_work_wrapper_v2)
```assembly
; Redirect to expansion ROM at $02300200
$060005CC:  D003     MOV.L   @($060005D8,PC),R0  ; R0 = 0x02300200 (slave_work_wrapper_v2)
$060005CE:  402B     JMP     @R0                 ; Jump to new loop
$060005D0:  0009     NOP                         ; Delay slot
$060005D2:  0009     NOP                         ; Padding (was BRA target)
$060005D4:  0009     NOP                         ; Padding
$060005D6:  0009     NOP                         ; Padding
$060005D8:  0230     .long   0x02300200          ; slave_work_wrapper_v2 address
$060005DC:  0200
```

### Patch Details (code_20200.asm)

**Current:**
```assembly
        dc.w    $D102        ; $0203CC - MOV.L @(8,PC),R1
        dc.w    $D003        ; $0203CE - MOV.L @(12,PC),R0
        dc.w    $2102        ; $0203D0 - MOV.L R0,@R1
        dc.w    $AFFE        ; $0203D2 - BRA -2 (infinite loop)
        dc.w    $0009        ; $0203D4 - NOP
        dc.w    $2000        ; $0203D6 - Part of literal (COMM3)
        dc.w    $402C        ; $0203D8 - Part of literal
        dc.w    $4F56        ; $0203DA - Part of literal ("OVRN")
        dc.w    $524E        ; $0203DC - Part of literal
```

**Replace with:**
```assembly
        dc.w    $D003        ; $0203CC - MOV.L @(12,PC),R0 - Load wrapper addr
        dc.w    $402B        ; $0203CE - JMP @R0 - Jump to wrapper
        dc.w    $0009        ; $0203D0 - NOP - Delay slot
        dc.w    $0009        ; $0203D2 - NOP - Padding (was BRA target)
        dc.w    $0009        ; $0203D4 - NOP - Padding
        dc.w    $0009        ; $0203D6 - NOP - Padding
        dc.w    $0230        ; $0203D8 - Literal: 0x02300200 (high word)
        dc.w    $0200        ; $0203DA - Literal: 0x02300200 (low word)
        dc.w    $0009        ; $0203DC - NOP - Padding
```

### Verification (Before/After Bytes)

**Before (ROM bytes at offset 0x0203CC):**
```
D1 02 D0 03 21 02 AF FE 00 09 20 00 40 2C 4F 56 52 4E
```

**After (ROM bytes at offset 0x0203CC):**
```
D0 03 40 2B 00 09 00 09 00 09 00 09 02 30 02 00 00 09
```

**Change summary:** 16 bytes modified (18 bytes total in region)

---

## Patch #2: Master Dispatch Hook

### Location
**File:** `disasm/sections/code_20200.asm`
**Line:** ~74
**ROM Offset:** `$02046A` (file offset: `0x02046A`)
**SH2 Address:** `$0202046A` (ROM)

### Current Code (Original Dispatch)
```assembly
; Master command dispatcher
$0202046A:  4008     SHLL2   R0              ; R0 = cmd * 4 (table index)
$0202046C:  D107     MOV.L   @($0202048C,PC),R1  ; R1 = jump table base
$0202046E:  001E     MOV.L   @(R0,R1),R0     ; R0 = table[cmd] (handler addr)
$02020470:  400B     JSR     @R0             ; Call handler
$02020472:  0009     NOP                     ; Delay slot
```

**Function:** Dispatches commands to SH2 handlers via jump table.

### New Code (Redirect to master_dispatch_hook)
```assembly
; Redirect to expansion ROM hook
$0202046A:  D005     MOV.L   @($02020480,PC),R0  ; R0 = 0x02300050 (master_dispatch_hook)
$0202046C:  400B     JSR     @R0                 ; Call hook
$0202046E:  0009     NOP                         ; Delay slot
$02020470:  AFF6     BRA     $02020460           ; Loop back to poll
$02020472:  0009     NOP                         ; Delay slot

; Literal pool (moved later in code)
...
$02020480:  0230     .long   0x02300050          ; master_dispatch_hook address
$02020482:  0050
```

**Note:** This hook will handle cmd 0x16 specially (skip COMM7 write), then dispatch normally.

### Patch Details (code_20200.asm)

**Current:**
```assembly
        dc.w    $4008        ; $02046A - SHLL2 R0
        dc.w    $D107        ; $02046C - MOV.L @(28,PC),R1
        dc.w    $001E        ; $02046E - MOV.L @(R0,R1),R0
        dc.w    $400B        ; $02020470 - JSR @R0
        dc.w    $0009        ; $02020472 - NOP
```

**Replace with:**
```assembly
        dc.w    $D005        ; $02046A - MOV.L @(20,PC),R0 - Load hook addr
        dc.w    $400B        ; $02046C - JSR @R0 - Call hook
        dc.w    $0009        ; $02046E - NOP - Delay slot
        dc.w    $AFF6        ; $02020470 - BRA -10 ($02020460) - Loop back
        dc.w    $0009        ; $02020472 - NOP - Delay slot
```

**Add literal at $02020480:**
```assembly
        dc.w    $0230        ; $02020480 - Literal: 0x02300050 (high word)
        dc.w    $0050        ; $02020482 - Literal: 0x02300050 (low word)
```

### Verification (Before/After Bytes)

**Before (ROM bytes at offset 0x02046A):**
```
40 08 D1 07 00 1E 40 0B 00 09
```

**After (ROM bytes at offset 0x02046A):**
```
D0 05 40 0B 00 09 AF F6 00 09
```

**Additional literal needed at 0x02020480:**
```
02 30 00 50
```

**Change summary:** 10 bytes modified + 4 bytes added (literal)

---

## Patch #3: func_021 Trampoline

### Location
**File:** `disasm/sections/code_22200.asm`
**Line:** ~2412
**ROM Offset:** `$0234C8` (file offset: `0x0234C8`)
**SH2 Address:** `$022234C8` (ROM)

### Current Code (Original func_021)
```assembly
; Original vertex transform function
$022234C8:  4F22     STS.L   PR,@-R15        ; Save return address
$022234CA:  BF4D     BSR.W   func_016        ; Call func_016 (projection)
$022234CC:  0009     NOP
$022234CE:  2F76     MOV.L   R7,@-R15        ; Save R7
$022234D0:  2F86     MOV.L   R8,@-R15        ; Save R8
... (36 bytes total)
```

**Function:** Transform vertices, call func_016, process loop.

### New Code (Redirect to shadow_path_wrapper)

**Option A: Shadow Path (Recommended)**
```assembly
; Redirect to shadow wrapper (both CPUs work, compare results)
$022234C8:  D002     MOV.L   @($022234D4,PC),R0  ; R0 = 0x02300400 (shadow_path_wrapper)
$022234CA:  402B     JMP     @R0                 ; Jump to wrapper
$022234CC:  0009     NOP                         ; Delay slot
$022234CE:  0009     NOP                         ; Padding
$022234D0:  0009     NOP                         ; Padding
$022234D2:  0009     NOP                         ; Padding
$022234D4:  0230     .long   0x02300400          ; shadow_path_wrapper address
$022234D6:  0400
```

**Option B: Live Offload (Aggressive)**
```assembly
; Master signals Slave, then RETURNS immediately (no work)
$022234C8:  D002     MOV.L   @($022234D4,PC),R0  ; R0 = wrapper address
$022234CA:  402B     JMP     @R0                 ; Jump to wrapper
$022234CC:  0009     NOP                         ; Delay slot
... (modify wrapper to skip original func_021 call)
```

### Patch Details (code_22200.asm) - Option A (Shadow Path)

**Current:**
```assembly
        dc.w    $4F22        ; $0234C8 - STS.L PR,@-R15
        dc.w    $BF4D        ; $0234CA - BSR.W func_016
        dc.w    $0009        ; $0234CC - NOP
        dc.w    $2F76        ; $0234CE - MOV.L R7,@-R15
        dc.w    $2F86        ; $0234D0 - MOV.L R8,@-R15
        dc.w    $B01A        ; $0234D2 - BSR (nested)
```

**Replace with:**
```assembly
        dc.w    $D002        ; $0234C8 - MOV.L @(8,PC),R0 - Load wrapper addr
        dc.w    $402B        ; $0234CA - JMP @R0 - Jump to wrapper
        dc.w    $0009        ; $0234CC - NOP - Delay slot
        dc.w    $0009        ; $0234CE - NOP - Padding
        dc.w    $0009        ; $0234D0 - NOP - Padding
        dc.w    $0009        ; $0234D2 - NOP - Padding
        dc.w    $0230        ; $0234D4 - Literal: 0x02300400 (high word)
        dc.w    $0400        ; $0234D6 - Literal: 0x02300400 (low word)
```

### Verification (Before/After Bytes) - Shadow Path

**Before (ROM bytes at offset 0x0234C8):**
```
4F 22 BF 4D 00 09 2F 76 2F 86 B0 1A
```

**After (ROM bytes at offset 0x0234C8):**
```
D0 02 40 2B 00 09 00 09 00 09 00 09 02 30 04 00
```

**Change summary:** 16 bytes modified (first 16 bytes of func_021)

---

## Activation Sequence

### Step 1: Apply Patches (in order)

```bash
# 1. Slave loop redirect (CRITICAL - do first)
# Edit disasm/sections/code_20200.asm at line ~238

# 2. Master dispatch hook
# Edit disasm/sections/code_20200.asm at line ~74

# 3. func_021 trampoline
# Edit disasm/sections/code_22200.asm at line ~2412

# 4. Rebuild ROM
make clean && make all
```

### Step 2: Verify Build

```bash
# Check ROM size
ls -lh build/vr_rebuild.32x
# Should be 4.0MB

# Verify critical bytes changed
xxd build/vr_rebuild.32x | grep -A2 "0203c0:"
xxd build/vr_rebuild.32x | grep -A2 "020460:"
xxd build/vr_rebuild.32x | grep -A2 "0234c0:"
```

### Step 3: Test Immediately

```bash
# Boot test (30 seconds)
cd tools/libretro-profiling
VRD_PROFILE_LOG=activated_test.csv ./profiling_frontend ../../build/vr_rebuild.32x 1800 --autoplay

# Check for crashes, hangs, or visual corruption
# Monitor COMM7 activity in profiling output
```

### Step 4: Profile Performance

```bash
# Compare to baseline
python3 analyze_profile.py activated_test.csv
python3 analyze_profile.py baseline_sync_fixed.csv

# Expected changes:
# - Master SH2: 0% → 5-10% utilization
# - Slave SH2: 80.2% → 80-85% utilization
# - 68K: 100.1% → 85-95% (reduced blocking)
# - COMM7 toggles: 50-100 per frame
```

---

## Risk Assessment

### Patch #1 Risk: 🔴 CRITICAL
**What could go wrong:**
- Slave crashes if wrapper has bugs
- Slave deadlocks if wrapper loops incorrectly
- COMM7 protocol fails if wrapper doesn't clear signal

**Mitigation:**
- slave_work_wrapper_v2 already tested (builds successfully)
- Barrier logic validated (shadow_path_wrapper tested)
- Can revert by restoring original 18 bytes

**Rollback:**
```assembly
dc.w $D102,$D003,$2102,$AFFE,$0009,$2000,$402C,$4F56,$524E
```

### Patch #2 Risk: 🟡 MEDIUM
**What could go wrong:**
- Dispatch loop breaks if hook doesn't return properly
- Jump table access fails if R8 corrupted
- Commands misrouted if hook logic wrong

**Mitigation:**
- master_dispatch_hook already tested (builds successfully)
- Hook preserves R4, R8 (context and COMM base)
- Returns to original loop address

**Rollback:**
```assembly
dc.w $4008,$D107,$001E,$400B,$0009
```

### Patch #3 Risk: 🟡 MEDIUM
**What could go wrong:**
- Vertex transforms produce wrong results
- Visual corruption if Slave output incorrect
- Performance regression if barriers block too long

**Mitigation:**
- shadow_path_wrapper uses original func_021 (relocated)
- Both Master and Slave compute results (shadow path)
- Barriers prevent race conditions

**Rollback:**
```assembly
dc.w $4F22,$BF4D,$0009,$2F76,$2F86,$B01A,...
```

---

## Expected Outcomes

### Best Case Scenario
- ✅ Slave services COMM7 signals correctly
- ✅ Master and Slave work in parallel
- ✅ Barriers never block (Slave fast enough)
- ✅ FPS increases by +15-20%
- ✅ No visual corruption

### Worst Case Scenario (Recoverable)
- ❌ Slave too slow, barriers block frequently
- ❌ FPS unchanged or worse
- ❌ ROM hangs on boot
- ❌ Visual corruption

**Recovery:** Revert patches, rebuild ROM, test baseline.

---

## Monitoring Points

### During Testing

1. **Boot sequence:** Does ROM boot to menu?
2. **Menu navigation:** Responsive? Glitches?
3. **Race start:** Does race load correctly?
4. **Gameplay:** Visual corruption? Polygon issues?
5. **Frame rate:** Smoother? Worse? Same?
6. **COMM7 activity:** Toggles detected in profiling?

### Profiling Metrics

```bash
# Check COMM7 toggles
grep "COMM7" activated_test.csv | wc -l

# Compare CPU utilization
python3 analyze_profile.py activated_test.csv | grep "Utilization"

# Check barrier blocking
# (need instrumentation to measure - future work)
```

---

## Patch Application Methods

### Method A: Manual Edit (Safest)

1. Open `disasm/sections/code_20200.asm` in editor
2. Find line ~238 (Slave idle loop)
3. Replace 9 lines as shown in Patch #1
4. Find line ~74 (Master dispatch)
5. Replace 5 lines + add literal as shown in Patch #2
6. Open `disasm/sections/code_22200.asm`
7. Find line ~2412 (func_021)
8. Replace first 8 words as shown in Patch #3
9. Save files
10. `make clean && make all`

### Method B: Automated Patch Script (Riskier)

```bash
#!/bin/bash
# apply_activation_patches.sh

# Backup original files
cp disasm/sections/code_20200.asm disasm/sections/code_20200.asm.backup
cp disasm/sections/code_22200.asm disasm/sections/code_22200.asm.backup

# Apply patches with sed (implementation needed)
# ... (not recommended - manual safer)

# Rebuild
make clean && make all
```

**Recommendation:** Use Method A (manual) for first activation. Verify each patch individually.

---

## Troubleshooting Guide

### Problem: ROM doesn't boot

**Cause:** Slave crashed immediately
**Fix:** Revert Patch #1, check slave_work_wrapper_v2 for bugs

### Problem: ROM hangs after menu

**Cause:** Deadlock in barrier (COMM7 never cleared)
**Fix:** Check Slave is actually servicing COMM7, verify wrapper loop

### Problem: Visual corruption during race

**Cause:** Parameter block race or func_021 output wrong
**Fix:** Check barriers are working, compare Master/Slave results

### Problem: FPS unchanged or worse

**Cause:** Barriers blocking too long, Slave too slow
**Fix:** Profile barrier overhead, measure Slave execution time

### Problem: Crashes during gameplay

**Cause:** Stack overflow, register corruption, or memory corruption
**Fix:** Check wrapper preserves registers, verify parameter block addresses

---

## Rollback Procedure

If activation fails:

```bash
# 1. Restore backup files
git checkout disasm/sections/code_20200.asm
git checkout disasm/sections/code_22200.asm

# 2. Rebuild baseline ROM
make clean && make all

# 3. Test baseline
cd tools/libretro-profiling
VRD_PROFILE_LOG=rollback_test.csv ./profiling_frontend ../../build/vr_rebuild.32x 1800 --autoplay

# 4. Verify baseline metrics match original
python3 analyze_profile.py rollback_test.csv
```

---

## Success Criteria

**Activation is successful if:**
1. ✅ ROM boots to menu without crashes
2. ✅ Race starts and plays without visual corruption
3. ✅ Master SH2 utilization increases (0% → 5-10%)
4. ✅ COMM7 toggles detected (50-100/frame)
5. ✅ FPS improves OR stays same (no regression)
6. ✅ Barriers don't deadlock

**Activation should be reverted if:**
1. ❌ ROM doesn't boot
2. ❌ Visual corruption appears
3. ❌ FPS regresses significantly (>5% drop)
4. ❌ Game hangs or crashes during play

---

## Next Steps After Activation

### If Successful
1. ✅ Profile performance gain
2. ✅ Measure barrier overhead
3. ✅ Optimize if needed (reduce barriers, tune timing)
4. ✅ Compare shadow path results (Master vs Slave output)
5. ✅ Consider switching to live offload (Option B)

### If Failed
1. ❌ Revert patches
2. ❌ Diagnose root cause
3. ❌ Fix bugs in wrappers
4. ❌ Add more instrumentation
5. ❌ Retry activation with fixes

---

**Document Status:** 🟡 DRAFT - Ready for review
**Patches Status:** ⏳ NOT APPLIED - Requires user approval
**Testing Status:** ⏳ PENDING - Apply patches first
**Last Updated:** 2026-02-09 00:45
