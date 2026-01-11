# Top Functions Analysis

## Function 2: 0x0203D8 - Register Save Function ⭐

**Address:** ROM 0x0203D8 | SH2 0x020203D8
**Size:** 32 bytes
**Calls:** 18 times (2nd most called)
**Type:** Calling convention utility

### Code

```asm
0x0203D8:
  MOV.L R0,@-R15    ; Push R0
  MOV.L R1,@-R15    ; Push R1
  MOV.L R2,@-R15    ; Push R2
  MOV.L R3,@-R15    ; Push R3
  MOV.L R4,@-R15    ; Push R4
  MOV.L R5,@-R15    ; Push R5
  MOV.L R6,@-R15    ; Push R6
  MOV.L R7,@-R15    ; Push R7
  MOV.L R8,@-R15    ; Push R8
  MOV.L R9,@-R15    ; Push R9
  MOV.L R10,@-R15   ; Push R10
  MOV.L R11,@-R15   ; Push R11
  MOV.L R12,@-R15   ; Push R12
  MOV.L R13,@-R15   ; Push R13
  MOV.L R14,@-R15   ; Push R14
  RTS               ; Return
```

### Purpose

**This is a register save prologue!**

Called at function entry to preserve all working registers (R0-R14) on the stack.

### Usage Pattern

```asm
some_function:
  BSR 0x0203D8      ; Save all registers
  NOP
  ; ... do work ...
  ; ... (restore registers) ...
  RTS
```

### Analysis

**Stack impact:** 60 bytes (15 registers × 4 bytes)

**Performance:**
- 15 × MOV.L @-R15 = 15 cycles
- RTS = 2 cycles
- **Total: 17 cycles**

**Calling convention:**
- Caller-saved registers: R0-R14 (all!)
- This is a **full context save**
- Suggests expensive operation or interrupt handler

### Companion Function (Hypothesis)

There must be a matching **register restore** function:
```asm
  MOV.L @R15+,R14
  MOV.L @R15+,R13
  ...
  MOV.L @R15+,R0
  RTS
```

**Search for:** Similar pattern with @R15+ (restore)

### Call Sites

Need to analyze the 18 call sites to understand:
- What functions use this?
- Is it for interrupts or just expensive functions?
- Is there always a matching restore?

### Optimization Potential

⚠️ **Medium** - This is called 18 times/frame

**Possible optimizations:**
1. Only save/restore registers actually used (selective save)
2. Use static allocation instead of stack (if safe)
3. Eliminate calls if function doesn't need full save

**Expected gain:** ~1-2% (17 cycles × 18 calls = 306 cycles/frame)

**Risk:** High - messing with calling conventions breaks everything

---

## Function 1: 0x022B58 - Unknown (Complex)

**Address:** ROM 0x022B58 | SH2 0x02022B58
**Size:** 86 bytes
**Calls:** 36 times (**most called function in entire ROM!**)
**Type:** Unknown (needs better disassembly)

### Raw Disassembly

My decoder failed on many opcodes - need to fix decoder first.

**Visible patterns:**
- ADD R12,R1/R2/R3 (advancing pointers?)
- MOV.L @(disp,Rn),R0 (table lookups?)
- SUB operations (calculations?)
- RTS at end (proper subroutine)

### Status

❌ **Incomplete** - Decoder needs improvement

### Next Steps

1. Fix SH2 decoder to handle unknown opcodes
2. Re-disassemble with complete instruction set
3. Identify purpose from context
4. Find call sites to understand usage

---

## Register Conventions (Discovered)

From function 0x0203D8, we can infer:

**Caller-saved:** R0-R14 (when using this function)
**Callee-saved:** Unknown (need to find restore function)
**Stack pointer:** R15 (confirmed)
**Return address:** PR register (standard SH2)

### Still Unknown

- Which registers are truly caller-saved vs callee-saved?
- What is R13 used for? (func_065 uses it as stride)
- What is R14 used for? (frame pointer?)
- Are there global register conventions?

---

## Summary

| Function | Address | Calls | Type | Status |
|----------|---------|-------|------|--------|
| 0x022B58 | ROM | 36× | Unknown | ❌ Incomplete |
| 0x0203D8 | ROM | 18× | Register Save | ✅ Documented |
| 0x023F2E | ROM | 17× | Rasterizer | ✅ Documented |

**Progress:** 2/3 top functions documented (67%)

---

## Action Items

### Immediate

1. **Fix SH2 decoder** - handle missing opcodes
   - Unknown opcodes: 972A, 5412, 5422, 6409, 644F, etc.
   - Need complete SH2 instruction set

2. **Find register restore function**
   - Search for MOV.L @R15+,Rn pattern
   - Should be called same number of times (18×)

3. **Re-analyze 0x022B58** with fixed decoder

### Medium Term

4. Analyze call sites for both functions
5. Document calling conventions
6. Build call graph to see relationships

---

## Optimization Implications

**Function 0x0203D8 (register save):**
- Called 18×/frame
- 17 cycles each = 306 cycles/frame
- Potential savings: ~0.3% (marginal)
- Risk: Very high (calling convention)

**Function 0x022B58 (unknown):**
- Called 36×/frame (most in ROM!)
- Unknown complexity
- **High optimization potential** if we understand it
- Need complete analysis first

**Verdict:** Focus on understanding 0x022B58 - it's called 2× more than anything else!
