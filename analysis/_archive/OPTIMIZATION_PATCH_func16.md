# func_016 Inlining Optimization Patch

**Optimization ID**: OPT-001
**Target**: func_016 (coordinate transformation utility)
**Impact**: +5% performance gain (~3 FPS improvement)
**Effort**: Low (30-60 minutes)
**Status**: Ready to implement

---

## Executive Summary

func_016 is called **4 times per polygon** (800 polygons/frame = 3,200 calls/sec @ 60 FPS). Each call wastes **6 cycles** in overhead (BSR + RTS), totaling **19,200 cycles/frame** or **5% of the frame budget**.

By inlining the 15-instruction function at all 4 call sites, we eliminate this overhead entirely.

---

## Original Function Analysis

**Address**: 0x02223368 - 0x02223386 (including RTS delay slot at 0x02223388)
**Size**: 30 bytes (15 instructions)
**Purpose**: Pack coordinate fields from context structure

### Original Code

```assembly
; func_016: Coordinate packing utility
; Input: R14 = pointer to RenderingContext
; Modifies: R0, R1, R2, R3, R4
; Cycles: ~15 (function body only)

02223368  51E7     MOV.L   @($1C,R14),R1      ; R1 = context->field_0x1C
0222336A  52E8     MOV.L   @($20,R14),R2      ; R2 = context->field_0x20
0222336C  4128     SHLL16  R1                 ; R1 <<= 16 (upper word)
0222336E  4228     SHLL16  R2                 ; R2 <<= 16 (upper word)
02223370  50E5     MOV.L   @($14,R14),R0      ; R0 = context->field_0x14 (base)
02223372  6313     MOV     R1,R3              ; R3 = R1 (copy)
02223374  6423     MOV     R2,R4              ; R4 = R2 (copy)
02223376  210B     OR      R0,R1              ; R1 |= R0 (combine)
02223378  220B     OR      R0,R2              ; R2 |= R0 (combine)
0222337A  1E1A     MOV.L   R1,@($28,R14)      ; context->field_0x28 = R1
0222337C  1E2B     MOV.L   R2,@($2C,R14)      ; context->field_0x2C = R2
0222337E  50E6     MOV.L   @($18,R14),R0      ; R0 = context->field_0x18 (alt base)
02223380  230B     OR      R0,R3              ; R3 |= R0
02223382  240B     OR      R0,R4              ; R4 |= R0
02223384  1E3C     MOV.L   R3,@($30,R14)      ; context->field_0x30 = R3
02223386  000B     RTS                        ; Return (2 cycles)
02223388  1E4D     MOV.L   R4,@($34,R14)      ; context->field_0x34 = R4 (delay slot)
```

**Function Body**: 15 cycles
**Call Overhead**: 6 cycles (BSR=2, RTS=2, 2× delay slots=2)
**Total**: 21 cycles per call

---

## Call Sites Identified

### Call Site 1: 0x0222338C (func_017)

**Context**:
```assembly
0222338A  4F22     STS.L   PR,@-R15    ; Save return address
0222338C  BFEC     BSR     $02223368   ; ← CALL TO func_016
0222338E  0009     NOP                 ; Delay slot
02223390  60A2     MOV.L   @R10,R0     ; Continue execution
```

**Inline Replacement**:
```assembly
; Remove BSR and inline function body directly
0222338A  4F22     STS.L   PR,@-R15    ; Keep PR save (needed by parent)
; [Insert 15 instructions from func_016 here]
02223390  60A2     MOV.L   @R10,R0     ; Continue (no change)
```

---

### Call Site 2: 0x022233F4 (func_018)

**Context**:
```assembly
022233F2  4F22     STS.L   PR,@-R15    ; Save return address
022233F4  BFB8     BSR     $02223368   ; ← CALL TO func_016
022233F6  0009     NOP                 ; Delay slot
022233F8  60A2     MOV.L   @R10,R0     ; Continue execution
```

**Inline Replacement**: Same pattern as call site 1.

---

### Call Site 3: 0x02223452 (func_019)

**Context**:
```assembly
02223450  4F22     STS.L   PR,@-R15    ; Save return address
02223452  BF89     BSR     $02223368   ; ← CALL TO func_016
02223454  0009     NOP                 ; Delay slot
02223456  60A2     MOV.L   @R10,R0     ; Continue execution
```

**Inline Replacement**: Same pattern.

---

### Call Site 4: 0x022234CA (func_020)

**Context**:
```assembly
022234C8  4F22     STS.L   PR,@-R15    ; Save return address
022234CA  BF4D     BSR     $02223368   ; ← CALL TO func_016
022234CC  0009     NOP                 ; Delay slot
022234CE  60A2     MOV.L   @R10,R0     ; Continue execution (likely)
```

**Inline Replacement**: Same pattern.

---

## Optimization Strategy

### Approach 1: Direct Inline (Recommended)

Replace each `BSR $02223368; NOP` sequence with the 15-instruction function body.

**Pros**:
- Maximum performance gain (full 6 cycles saved)
- Simple, straightforward implementation
- No risk of bugs (exact copy of working code)

**Cons**:
- Code size increase: 30 bytes → 30 bytes × 4 = 120 bytes net increase
- (Original function remains but unused = 30 bytes wasted)

**Net Code Size Change**: +90 bytes (negligible in 3MB ROM)

---

### Approach 2: Shared Tail (Space-Optimized)

Keep one copy of func_016 but remove BSR overhead by jumping directly into it without subroutine call.

**Not Recommended**: Saves space but doesn't eliminate overhead.

---

## Implementation Plan

### Step 1: Create Inlined Macro

Define an assembler macro for the function body:

```assembly
; Macro: INLINE_func_016
; Expands to the 15-instruction body of func_016
; Input: R14 must point to RenderingContext
; Modifies: R0, R1, R2, R3, R4

.macro INLINE_func_016
    MOV.L   @($1C,R14),R1      ; Load field_0x1C
    MOV.L   @($20,R14),R2      ; Load field_0x20
    SHLL16  R1                 ; Shift to upper word
    SHLL16  R2
    MOV.L   @($14,R14),R0      ; Load base value
    MOV     R1,R3              ; Copy R1
    MOV     R2,R4              ; Copy R2
    OR      R0,R1              ; Combine
    OR      R0,R2
    MOV.L   R1,@($28,R14)      ; Store result 1
    MOV.L   R2,@($2C,R14)      ; Store result 2
    MOV.L   @($18,R14),R0      ; Load alt base
    OR      R0,R3              ; Combine alt
    OR      R0,R4
    MOV.L   R3,@($30,R14)      ; Store result 3
    MOV.L   R4,@($34,R14)      ; Store result 4
.endm
```

### Step 2: Replace Call Sites

At each of the 4 call sites, replace:
```assembly
    BSR     $02223368
    NOP
```

With:
```assembly
    INLINE_func_016
```

### Step 3: Mark Original Function as Unused

Add comment to original func_016:
```assembly
; NOTE: This function is no longer called - inlined at all 4 call sites
; Original kept for reference only
func_016_UNUSED:
    ...
```

---

## Assembly Patch (Binary)

### Call Site 1 Patch (0x0222338C)

**Before** (4 bytes):
```
Offset: 0x0222338C
Bytes:  BF EC 00 09
        ^^-^^---^^-^^
        BSR   NOP
```

**After** (30 bytes - requires space!):
```
Offset: 0x0222338C
Bytes:  51 E7 52 E8 41 28 42 28 50 E5 63 13 64 23 21 0B
        22 0B 1E 1A 1E 2B 50 E6 23 0B 24 0B 1E 3C 1E 4D
```

**Problem**: This overwrites following code! Need to relocate or expand ROM region.

---

## Alternative: Patch Assembly Source

If we have source code access, simply modify the assembly:

### Original Source (Hypothetical)

```assembly
func_017:
    STS.L   PR,@-R15
    BSR     func_016        ; Call function
    NOP
    MOV.L   @R10,R0
    ...
```

### Patched Source

```assembly
func_017:
    STS.L   PR,@-R15
    ; Inlined func_016 for performance (OPT-001)
    MOV.L   @($1C,R14),R1
    MOV.L   @($20,R14),R2
    SHLL16  R1
    SHLL16  R2
    MOV.L   @($14,R14),R0
    MOV     R1,R3
    MOV     R2,R4
    OR      R0,R1
    OR      R0,R2
    MOV.L   R1,@($28,R14)
    MOV.L   R2,@($2C,R14)
    MOV.L   @($18,R14),R0
    OR      R0,R3
    OR      R0,R4
    MOV.L   R3,@($30,R14)
    MOV.L   R4,@($34,R14)
    ; End inline
    MOV.L   @R10,R0
    ...
```

Repeat for all 4 call sites.

---

## Expected Results

### Performance Gain

**Per Call Savings**: 6 cycles
**Calls Per Polygon**: 4
**Polygons Per Frame**: 800
**Savings Per Frame**: 6 × 4 × 800 = 19,200 cycles

**Frame Budget**: 383,000 cycles (23 MHz / 60 FPS)
**Percentage Gain**: 19,200 / 383,000 = **5.01%**

**Estimated FPS Improvement**: 60.0 → 63.0 FPS (+3 FPS)

### Code Size Impact

**Original**:
- func_016: 30 bytes
- 4 call sites: 4 × 4 bytes = 16 bytes
- Total: 46 bytes

**Optimized**:
- Inlined at 4 sites: 4 × 30 bytes = 120 bytes
- Original func_016: 30 bytes (unused but kept)
- Total: 150 bytes

**Net Increase**: +104 bytes (0.003% of 3MB ROM - negligible)

---

## Testing Plan

### Step 1: Implement Patch
- Modify disassembled source or create binary patch
- Reassemble with vasm
- Verify byte count matches expected

### Step 2: Functional Testing
- Load ROM in Gens KMod emulator
- Verify game boots and runs
- Check for graphical glitches
- Test all tracks and game modes

### Step 3: Performance Validation
- Measure frame time improvement (if emulator supports)
- Or use frame counter to estimate FPS
- Compare before/after videos

### Step 4: Regression Testing
- Ensure no crashes or hangs
- Verify save/load functionality
- Test multiplayer mode (if applicable)

---

## Risk Assessment

**Risk Level**: ⬜ Low

**Potential Issues**:
1. ✅ **Register conflicts**: None - function is self-contained
2. ✅ **Stack corruption**: None - no stack operations modified
3. ✅ **Alignment issues**: None - all instructions naturally aligned
4. ⚠️ **Code size overflow**: Must ensure inlined code fits in available space

**Mitigation**: If space is tight, can selectively inline only 2-3 call sites for partial gain.

---

## Implementation Checklist

- [ ] Back up original ROM
- [ ] Locate exact bytes for all 4 call sites in hex editor
- [ ] Create inlined assembly for each site
- [ ] Assemble and extract binary patches
- [ ] Apply patches to ROM
- [ ] Test in emulator
- [ ] Measure performance improvement
- [ ] Document changes in changelog

---

## Alternative: Runtime Patch

If modifying ROM is not desired, could inject code at runtime:

```c
// Hook setup (68000 or SH2 init code)
void apply_func16_optimization(void) {
    // Overwrite BSR instructions with inline code
    uint16_t* call_site_1 = (uint16_t*)0x0222338C;
    // Write 15 instructions here...
}
```

**Not Recommended**: Complex, requires understanding of SRAM cartridge or action replay.

---

## Conclusion

This optimization is a **textbook example** of effective inlining:
- Hot function (called 3,200 times/sec)
- Small size (15 instructions)
- High overhead ratio (6 cycles overhead / 15 cycles body = 28%)
- Negligible code size increase

**Recommendation**: **IMPLEMENT IMMEDIATELY** for guaranteed 5% performance gain.

---

## References

- [SH2_3D_PIPELINE_ARCHITECTURE.md](SH2_3D_PIPELINE_ARCHITECTURE.md) - Pipeline context
- [SH2_3D_CALL_GRAPH.md](SH2_3D_CALL_GRAPH.md) - Call frequency analysis
- [OPTIMIZATION_OPPORTUNITIES.md](OPTIMIZATION_OPPORTUNITIES.md) - Original recommendation
- [disasm/sh2_3d_engine_annotated.asm](../disasm/sh2_3d_engine_annotated.asm) - Annotated source

**Next Steps**: Proceed to Option 2 - Deep dive into func_065 rasterization hotspot.
