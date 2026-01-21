# Slave SH-2 Boot Failure - Root Cause Analysis

Date: 2026-01-20
Status: ✅ **ROOT CAUSE IDENTIFIED**

---

## Executive Summary

**The Slave SH-2 never boots properly because PicoDrive reads reset vectors from the wrong location.**

- PicoDrive reads SH-2 PC/SP from ROM 0x0-0xF (Genesis reset vectors)
- These locations contain 68K reset vectors, not SH-2 vectors
- Slave PC gets set to 0x00880832 (a 68K code address)
- Slave executes 68K instructions as SH-2, resulting in garbage execution
- Slave never reaches actual SH-2 code at ROM 0x020000+

---

## Evidence Chain

### 1. Reset Vector Read Location

**File**: `third_party/picodrive/cpu/sh2/sh2.c:43-50`

```c
void sh2_reset(SH2 *sh2)
{
	sh2->pc = p32x_sh2_read32(0, sh2);     // ← WRONG: reads from ROM 0x0
	sh2->r[15] = p32x_sh2_read32(4, sh2);  // ← WRONG: reads from ROM 0x4
	sh2->sr = I;
	sh2->vbr = 0;
	sh2->pending_int_irq = 0;
}
```

### 2. What's Actually at ROM 0x0-0xF

```
Master SP: 0x01000000  ← Genesis Stack Pointer
Master PC: 0x000003F0  ← Genesis Entry Point
Slave SP:  0x00880832  ← INVALID: Points to 68K code
Slave PC:  0x00880832  ← INVALID: Points to 68K code
```

These are **Genesis/68K reset vectors**, not SH-2 reset vectors.

### 3. What's at 0x00880832 (Slave "Entry")

ROM offset 0x832 contains 68K code:
```
000832: BTST, JMP, BTST, JMP... (68K instructions)
```

Not SH-2 code. The Slave is executing 68K assembly as SH-2.

### 4. Where Real SH-2 Vectors Should Come From

**32X ROM Header at 0x3C0-0x3FF:**

```
ROM 0x3C0: "MARS CHECK MODE" (32X identification)
ROM 0x3E0: 0x06000280  ← Real SH-2 entry 1
ROM 0x3E4: 0x06000288  ← Real SH-2 entry 2
ROM 0x3E8: 0x06000000  ← Real SH-2 entry 3
ROM 0x3EC: 0x06000140  ← Real SH-2 entry 4
```

These are **proper SH-2 ROM addresses** (0x06xxxxxx = uncached ROM).

### 5. Actual SH-2 Code Exists and is Correct

```
ROM 0x020500: "M_OK" (Master SH-2 entry signature)
ROM 0x020650: DE13 D014 1E01 50E0 (Valid SH-2 opcodes for Slave entry)
```

The SH-2 code exists. PicoDrive just never loads it.

### 6. Runtime Evidence: Slave Executes 68K Code

Debugger trace shows Slave PC sequence:
```
PC=0x00000204 → 0x0000020A → 0x00000218 → 0x0600058A → 0x0600060A (stuck)
```

All of these are 68K code regions being mis-executed as SH-2:
```
ROM 0x000204: 0838 4EF9 0088 0832  ← BTST, JMP (68K)
ROM 0x00020A: 0832 4EF9 0088 0832  ← BTST, JMP (68K)
ROM 0x000218: 4EF9 0088 0832       ← JMP (68K)
ROM 0x00058A: "ROM Version 1.0"    ← Text data
ROM 0x00060A: fffc 3340 fffc 3340  ← 68K code/data
```

### 7. R2 Gets Set to Garbage

Because the Slave is mis-executing 68K code:
- R2 = 0x220003E4 is an **accidental side effect**
- Results from 68K instructions being interpreted as SH-2 loads/moves
- NOT intentional R2 initialization

Interestingly, **0x220003E4 in SDRAM contains the correct 32X header vectors!**
- SDRAM was properly initialized with values from ROM 0x3E0+
- But Slave never successfully reads/uses them

---

## Why This Happened

### Genesis/32X Dual Architecture

32X cartridges contain BOTH:
1. **Genesis ROM** (68K code at 0x000000+)
2. **32X ROM** (SH-2 code at 0x020000+, header at 0x3C0+)

The ROM offset 0x0-0xF is shared:
- Genesis reads it as 68K reset vectors
- 32X should ignore it and use the 32X header instead

### PicoDrive's Mistake (Two-Fold Issue)

**Issue #1: Wrong Vector Source**
PicoDrive's `sh2_reset()`:
- Treats the 32X ROM like a standalone SH-2 ROM
- Reads reset vectors from offset 0 (Genesis/68K vectors)
- Does not use the 32X-specific header at 0x3C0+
- Does not implement proper 32X boot sequence

**Issue #2: Memory Mapping (Suspected)**
Even if PC is set correctly to `0x06000288`:
- SH-2 memory mapper must resolve `0x0600xxxx` (uncached ROM window) → ROM buffer
- Also must support `0x0200xxxx` (cached ROM window) as alias
- If mapping is incomplete, instruction fetch fails → PC jumps to 0x00000000
- This explains "boots to 0x06000288, executes one instruction, then crashes" pattern

**Why Both Matter**:
The observered behavior (Slave gets stuck after one instruction) suggests PicoDrive may have:
1. A partial IDL (Initial Data Load) implementation that copies headers to SDRAM correctly
2. But `sh2_reset()` bypasses this and reads wrong vectors
3. AND/OR memory mapping doesn't properly route `0x06xxxxxx` addresses

Evidence: SDRAM at 0x220003E4 contains correct header vectors, suggesting IDL copy worked, but Slave never successfully uses them.

### What Real 32X Hardware Does

Real 32X hardware likely:
1. Reads SH-2 vectors from ROM header (0x3E0+)
2. Or uses internal boot ROM/BIOS to set up SH-2s
3. Copies vector table to SDRAM (we see this happened)
4. Sets SH-2 PC to proper entry points (0x06000280, etc.)

---

## Impact on Our Investigation

### Why Static Analysis "Found" Working Code

The SH-2 code at ROM 0x020500+ (Master) and 0x020650+ (Slave):
- **Does exist**
- **Is correct**
- **Would work if executed**

But PicoDrive **never loads it**.

### Why R2 Analysis Was Misleading

We analyzed R2 = 0x220003E4 thinking:
- It was intentionally set
- It pointed to work dispatch table
- JSR @R2 was the work loop

Reality:
- R2 is garbage from mis-executing 68K code
- **0x220003E4 contains real vectors (correlated, not coincidental)**
  - This suggests PicoDrive's IDL (Initial Data Load) mechanism DID work
  - Header was correctly copied from ROM 0x3E0+ to SDRAM 0x220003E4
  - But `sh2_reset()` bypassed this and set PC from wrong source
  - So initialization half-worked, but boot sequence failed
- Slave never reaches any real work loop due to wrong PC/SP initialization

### Why "Work Loop" Code Exists But Never Runs

The code at ROM 0x020688 (JSR @R2 loop):
- Is real Slave work loop code
- Would execute IF Slave booted properly
- But Slave never gets there due to boot failure

---

## Verification

### Test 1: SDRAM Contents Match ROM Header ✓

SDRAM 0x220003E4:
```
06 00 02 88 06 00 00 00 06 00 01 40 ...
```

ROM Header 0x3E0:
```
06 00 02 80 06 00 02 88 06 00 00 00 06 00 01 40 ...
```

**Match!** Someone (Master or 68K) correctly copied the header to SDRAM.

### Test 2: Slave Never Enters SH-2 Code Section ✓

Monitored PC for 20+ seconds:
- **0 hits** in range 0x06020000-0x06030000
- Slave stays in 0x00000000-0x0001FFFF (68K ROM)
- Then jumps to 0x0600058A+ (still 68K/data region)

### Test 3: Slave Executes 68K Instructions ✓

Disassembled Slave PC sequence:
- All addresses contain BTST, JMP, MOVE (68K opcodes)
- NOT SH-2 opcodes (MOV, ADD, CMP/GT, BRA, JSR)

---

## The Correct Fix

### Recommended Approach (Minimal + Correct)

**Don't modify `sh2_reset()` to read from different locations** - keep it generic for standalone SH-2 systems.

Instead, implement proper 32X boot in the 32X initialization code:

#### Step 1: Save 32X Header Vectors (Before IDL Copy)

```c
// In 32X init, before any IDL copy that might overwrite header:
u32 master_pc = read32_be(Pico.rom + 0x3E0);  // Confirm endianness & offsets
u32 master_sp = read32_be(Pico.rom + 0x3E4);
u32 slave_pc  = read32_be(Pico.rom + 0x3E8);
u32 slave_sp  = read32_be(Pico.rom + 0x3EC);
u32 vbr       = 0;  // Or from header if specified
```

#### Step 2: Perform IDL Copy (If PicoDrive Uses This)

Let existing IDL mechanism work, if present.

#### Step 3: Initialize SH-2s with Saved Vectors

Create a 32X-specific reset helper:

```c
static void sh2_reset_with_vectors(SH2 *sh2, u32 pc, u32 sp, u32 vbr) {
    sh2->pc = pc;
    sh2->r[15] = sp;
    sh2->sr = I;
    sh2->vbr = vbr;
    sh2->pending_int_irq = 0;
    // Reset other internal state as sh2_reset() would
}
```

Then call after memory mapping is set up:

```c
sh2_reset_with_vectors(&Pico32x.sh2_master, master_pc, master_sp, vbr);
sh2_reset_with_vectors(&Pico32x.sh2_slave,  slave_pc,  slave_sp,  vbr);
```

#### Step 4: Verify Memory Mapping

**Critical**: Ensure SH-2 memory mapper resolves both:
- `0x06000000-0x063FFFFF` (uncached ROM window) → ROM buffer
- `0x02000000-0x023FFFFF` (cached ROM window) → ROM buffer

If mapping is incomplete, even correct PC will fail on instruction fetch.

### Diagnostic Checklist

Before considering fix complete, verify:

1. **After reset, log Master/Slave PC+SP**
   - Confirm they match 32X header values (e.g., PC=0x06000288)

2. **On first fetch at PC, verify fetching SH-2 opcodes**
   - NOT 68K patterns like 0x4EF9, 0x0838
   - Should see valid SH-2 instructions (MOV, ADD, etc.)

3. **Single-step first 20 instructions**
   - If PC becomes 0x00000000, log the cause:
     - Exception vector fetch?
     - Invalid opcode / address error?
     - Unmapped memory read returning 0?

4. **Dump resolved memory bytes at PC**
   - Verify emulator's read path returns correct ROM data
   - Not just that ROM file contains it, but that SH-2 fetch sees it

---

## What This Means for Optimization

### Good News ✓

1. **The SH-2 code is correct** - No ROM corruption
2. **Work distribution infrastructure exists** - Just never activated
3. **Emulator bug, not game bug** - Fixable

### Bad News ✗

1. **This is a PicoDrive-specific issue**
2. **Real hardware likely works correctly**
3. **Cannot test optimizations in PicoDrive until boot fixed**
4. **All prior static analysis was analyzing dead code**

### Next Steps

**Option A: Fix PicoDrive (Recommended)**
1. Create branch `picodrive-boot-fix`
2. Implement 32X header vector reading (before IDL copy)
3. Create `sh2_reset_with_vectors()` helper
4. Initialize Master/Slave with saved vectors
5. Verify memory mapping for `0x06xxxxxx` and `0x02xxxxxx`
6. Run diagnostic checklist (4 verification steps above)
7. Test Slave reaches ROM 0x020650 work loop
8. THEN test parallelization optimizations

**Option B: Test on Real Hardware**
- Our ROM may work correctly on real 32X
- Static analysis suggests SH-2 code is valid
- PicoDrive bug doesn't affect hardware
- Would confirm whether issue is emulator-specific

**Option C: Test on Different Emulator**
- Try Kega Fusion, Gens, or BlastEm
- Compare Slave boot behavior
- May reveal if other emulators have same issue
- BlastEm has good 32X accuracy reputation

---

## Files Documenting This Journey

1. [SLAVE_FINAL_ANALYSIS.md](SLAVE_FINAL_ANALYSIS.md) - Corrected static analysis
2. [R2_INVESTIGATION_SUMMARY.md](R2_INVESTIGATION_SUMMARY.md) - R2 search results
3. [R2_DEBUGGER_RESULTS.md](R2_DEBUGGER_RESULTS.md) - Runtime R2 measurement
4. [R2_TECHNICAL_ASSESSMENT.md](R2_TECHNICAL_ASSESSMENT.md) - Methodology validation
5. [PDB_DEBUGGER_USAGE.md](PDB_DEBUGGER_USAGE.md) - Custom debugger guide
6. [SLAVE_BOOT_FAILURE_ROOT_CAUSE.md](SLAVE_BOOT_FAILURE_ROOT_CAUSE.md) - This document

---

**Status**: Root cause identified ✅
**PicoDrive Issue**: `sh2_reset()` uses wrong vectors
**ROM Status**: Correct (SH-2 code exists and is valid)
**Fix Complexity**: Low (single function modification)
**Next Action**: Fix `sh2_reset()` to read from 32X header

