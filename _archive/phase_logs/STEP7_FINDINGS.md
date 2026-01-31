# Step 7: V-INT Hook Analysis

**Date:** 2026-01-21
**Status:** Architectural decision needed

---

## Discovery: Reserved NOP Space

Found a 68-byte block of NOPs at **$00037A-$0003BE** in code_200.asm:

```
$00037A: 4E71 (NOP)
$00037C: 4E71 (NOP)
... [64 more bytes of NOPs]
$0003BE: 4E71 (NOP)
$0003C0: Start of "MARS CHECK MODE" string
```

This appears to be intentional reserved space - perfect for code injection!

**Location:** `disasm/sections/code_200.asm` lines 197-231

---

## Architectural Problem

**Issue:** Expansion code is **SH2-only**, but V-INT handler is **68K**.

### Current Structure
- V-INT handler at $0832 (68K code)
- Expansion ROM at $300000 ($02300000 in SH2 address space)
- 68K cannot directly execute SH2 code

### Solutions

#### Option A: 68K → Signal → Slave Response ✅ (Simpler, testable now)
1. Hook from 68K V-INT to write COMM register
2. Slave SH2 reads COMM and calls expansion_comm_test
3. Slave writes response to COMM6
4. 68K/debugger observes COMM6 change

**Pros:** Simple, doesn't require understanding Slave boot
**Cons:** Requires Slave to actively check COMM registers

#### Option B: Slave SH2 Entry Point Hook ✅✅ (Better, more complex)
1. Find Slave SH2 initialization/entry point
2. Hook Slave to call expansion_comm_test directly
3. Slave writes to COMM6
4. 68K/debugger observes change

**Pros:** Direct execution, no polling needed
**Cons:** Requires reverse-engineering Slave boot sequence

---

## Recommendation

**Proceed with Option A:**

1. **Step 7.1:** Replace first 6 bytes of NOPs with 68K code to write 0x12 to COMM6
   - `dc.w $303C, $0012` = MOVE.W #$0012,$A1512C (write 0x12 to COMM6)
   - This is our "hook test" signal
   - Rest of NOPs left untouched as safety margin

2. **Step 7.2:** Boot ROM and check COMM6 in debugger
   - If COMM6 = 0x12, hook location works
   - Proceed to full expansion call

3. **Step 7.3 (Future):** Understand Slave SH2 boot to implement Option B

---

## Technical Details

### NOP Block to Replace ($00037A-$00037E)

Current:
```asm
dc.w $4E71  ; NOP at $00037A
dc.w $4E71  ; NOP at $00037C
dc.w $4E71  ; NOP at $00037E
```

Test Option (write 0x12 to COMM6 = $A1512C):
```asm
dc.w $303C              ; MOVE.W #imm16,$nnnnnn
dc.w $0012              ;   immediate = $0012
dc.w $00A1              ;   address = $00A1512C (high word)
dc.w $512C              ;   address = $00A1512C (low word)
; Then restore NOPs for remaining 62 bytes
```

### COMM6 Address Details
- 68K address: $A1512C (COMM register 6)
- In ROM file offset: $512C (after 68K offset added back)
- SH2 address: $2000402C (per hardware manual, note: $20004030 is PWM Control, not COMM6)

---

## Files to Modify

- `disasm/sections/code_200.asm` lines 197-201
  - Replace 5 NOPs with MOVE.W #$0012,$A1512C instruction

---

## Testing Plan

1. Build with hook code
2. Boot in PicoDrive
3. Use debugger to read COMM6 register
4. Observe if value changes to 0x12
5. If yes → Hook location works, can expand
6. If no → Investigate why hook not executing

---

## Next Action

Decide: Implement Option A (simple test) or Option B (proper hook)?

**Recommendation:** Option A first to validate the NOP location, then pursue Option B if needed.
