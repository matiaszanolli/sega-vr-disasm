# R2 Register - Debugger Results

Date: 2026-01-20
Status: ✅ **MEASURED**

---

## Executive Summary

**R2 Value**: `0x220003E4` (points to SDRAM, not ROM)
**Slave PC**: Stuck at `0x0600060A-0x0600060E` (ROM offsets 0x060A-0x060E)
**Critical Discovery**: The Slave SH2 **NEVER reaches** the code we analyzed at ROM 0x020688

---

## Measurement Method

1. Modified PicoDrive's SH2 interpreter logging to display R2 register
2. Added tracking for work loop region (0x06020650-0x060206A0)
3. Ran emulator and captured first 100 Slave instruction executions

**Code modified**: `third_party/picodrive/cpu/sh2/mame/sh2pico.c`

---

## Raw Debugger Output

```
[SSH2 #1] PC=00000204 R0=00000000 R2=00000000
[SSH2 #2] PC=0000020A R0=00000000 R2=220003E4
[SSH2 #3] PC=00000218 R0=535F4F4B R2=220003E4
[SSH2 #4] PC=0600058A R0=535F4F4B R2=220003E4
[SSH2 #5] PC=0600060A R0=00000000 R2=220003E4
[SSH2 #6] PC=0600060C R0=00000000 R2=220003E4
[SSH2 #7] PC=0600060E R0=00000000 R2=220003E4
[SSH2 #8] PC=0600060A R0=00000000 R2=220003E4
... (loops forever at 0x0600060A-0x0600060E)
```

---

## Analysis

### R2 Value: 0x220003E4

**Memory region**: SDRAM (0x22000000-0x2203FFFF)
**Offset in SDRAM**: 0x3E4
**Type**: RAM address, not ROM function pointer

This is **NOT** a ROM function pointer as hypothesized. R2 points to writable RAM.

### Slave Execution Path

1. **PC=0x00000204**: Early boot (ROM offset 0x204)
2. **PC=0x0000020A**: R2 gets set to 0x220003E4
3. **PC=0x00000218**: R0 = 0x535F4F4B ("S_OK" handshake)
4. **PC=0x0600058A**: Jump to ROM text area ("ROM Version 1.0")
5. **PC=0x0600060A-0x0600060E**: **INFINITE LOOP** (never exits)

### Code at ROM 0x060A (Where Slave Gets Stuck)

```
ROM 0x060A: fffc 3340 fffc 3340 fffc 3340 fffc 51cf
```

This appears to be 68K code or data being executed as SH2 instructions (likely invalid/garbage).

### Code We Analyzed (ROM 0x020688) - NEVER EXECUTED

```assembly
$020688: JSR @R2              ; This code is NEVER reached!
$02068A: MOV #0,R8
$02068C: CMP/GT R11,R10
$02068E: BT +6
$020690: ADD #1,R10
$020692: ADD #1,R8
$020694: BRA -12
```

**Verification**: Ran emulator for 20 seconds with work loop tracking - **ZERO hits** at PC=0x06020650-0x060206A0.

---

## Implications

### What This Means

1. **Static analysis was INCORRECT** - The code we analyzed is dead/unused code
2. **Slave runs different path** - Executes from ROM 0x060A loop, not 0x020688 work loop
3. **R2 is RAM pointer** - Not a ROM function pointer as we thought
4. **Slave is stuck** - Infinite loop at invalid code region suggests error state

### Why Static Analysis Failed

- Analyzed disassembly without runtime verification
- Assumed Slave entry at 0x020650 based on code patterns
- Did not account for alternative execution paths or boot mechanisms
- ROM contains multiple code paths; Slave uses unexpected one

---

## Next Steps

### Immediate Investigation Required

1. **Analyze actual Slave boot sequence** (ROM 0x204 → 0x20A → 0x218 → 0x58A → 0x60A)
2. **Determine why Slave gets stuck** at ROM 0x60A-0x60E
3. **Investigate SDRAM address 0x220003E4** - what data/code is there?
4. **Find why ROM 0x020688 code exists but isn't used** - leftover? Debug code?

### Questions to Answer

1. Is the ROM 0x060A loop intentional or is the Slave in an error state?
2. What is supposed to happen at SDRAM 0x220003E4?
3. Is there a different Slave entry mechanism we missed?
4. Does Master SH2 ever call the ROM 0x020688 code we analyzed?

---

## Corrected Understanding

**Previous hypothesis**:
- Slave executes work loop at ROM 0x020688
- R2 = function pointer to VDP wait or similar
- JSR @R2 dispatches work

**Actual reality**:
- Slave executes boot sequence ending at ROM 0x060A
- R2 = RAM address 0x220003E4
- Slave stuck in infinite loop (possibly error state)
- ROM 0x020688 code path is UNUSED

---

## Files Modified for Debugging

1. `third_party/picodrive/Makefile` - Added PDB ?= 1
2. `third_party/picodrive/cpu/debug.c` - Fixed field names, added break command
3. `third_party/picodrive/cpu/sh2/compiler.c` - Set DRC_DEBUG = 8
4. `third_party/picodrive/cpu/sh2/mame/sh2pico.c` - Added R2 logging

---

**Status**: R2 value confirmed ✅
**Hypothesis**: REJECTED ❌
**Slave state**: Appears stuck/error (requires further investigation)
**Next action**: Analyze actual Slave boot path and SDRAM contents
