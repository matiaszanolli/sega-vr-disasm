# SH2 Code Conversion Plan - dc.w → Assembly Mnemonics

## Problem Statement

**Current burden**: ~524,000 dc.w hex instructions across 128 SH2 section files
- Error-prone (D102 vs D002 register confusion)
- Hard to read and modify
- Not leveraging our sh-elf-as toolchain

## Proposed Strategy: Incremental Conversion

We **cannot** convert 524K instructions at once. Instead:

### Phase 1: Convert Active Code Sections (IMMEDIATE)
Convert only the sections we're actively modifying:

1. **code_20200.asm** (our current work area)
   - Contains Slave idle loop at $02050C
   - 4,096 dc.w → proper assembly
   - Priority: **CRITICAL**

2. **code_200.asm** (Slave startup code)
   - Contains initialization
   - 4,096 dc.w → proper assembly
   - Priority: **HIGH**

### Phase 2: Build Conversion Tooling (NEXT)
Enhance `tools/sh2_disasm.py` to output proper assembly:

```python
# sh2_to_asm.py - Convert dc.w sections to assembly
# Input:  dc.w $D102  ; some comment
# Output: mov.l   @(8,pc),r1  ; some comment
```

Features needed:
- Parse dc.w hex values
- Decode to SH2 mnemonics
- Preserve comments and labels
- Handle data sections (don't disassemble data as code)
- Output vasmm68k-compatible syntax

### Phase 3: Convert On-Demand (ONGOING)
Convert sections as we touch them:
- Modified a function? Convert that section
- Adding new code? Write in proper assembly from start
- Debugging? Convert to understand the code

### Phase 4: Full Conversion (FUTURE)
Once tooling is proven:
- Batch convert all SH2 sections
- Validate ROM still builds byte-for-byte identical
- Git commit the conversion

## Immediate Action Plan

### Step 1: Enhance sh2_disasm.py
Add output mode for proper assembly syntax:

```bash
tools/sh2_disasm.py build/vr_rebuild.32x 0x02050C 100 --format=asm > temp.asm
```

### Step 2: Convert code_20200.asm Section
Focus on the area we're modifying ($020200-$022200):

```bash
# Extract current dc.w section
python tools/sh2_extract_section.py disasm/sections/code_20200.asm

# Convert to proper assembly
python tools/sh2_to_asm.py code_20200_extracted.bin > code_20200_new.asm

# Manual review and label restoration

# Replace section in file
```

### Step 3: Validate
```bash
# Build ROM
make clean && make all

# Compare with baseline
diff build/vr_rebuild.32x build/vr_baseline.32x

# Should be byte-for-byte identical
```

### Step 4: Commit Incrementally
Convert one section at a time, commit after each validated conversion.

## Why Not Convert Everything Now?

1. **Risk**: 524K instructions = high chance of errors
2. **Time**: Would take weeks to convert and validate
3. **ROI**: Most code we're not touching
4. **Validation**: Need to ensure byte-identical output

## Benefits of Incremental Approach

✅ **Immediate**: Fix the code we're working with NOW
✅ **Safe**: Small, validated changes
✅ **Practical**: Focus on high-value conversions
✅ **Testable**: Each conversion can be verified independently
✅ **Reversible**: Can roll back if issues arise

## Long-term Vision

Eventually we want:
```asm
; disasm/sections/sh2/slave_init.asm (proper assembly)
slave_init:
    mov.l   comm_addr,r0      ; Load COMM register address
    mov     #0,r1             ; Clear R1
    mov.w   r1,@r0            ; Initialize COMM2 = 0
    bra     idle_loop         ; Jump to main loop
    nop                       ; Delay slot

.align 4
comm_addr:
    .long   0x20004024        ; COMM2 register
```

Instead of:
```asm
; disasm/sections/code_20200.asm (hex hell)
        dc.w    $D002        ; MOV.L comm2_addr,R0 - load COMM2 address into R0 (disp=2)
        dc.w    $E100        ; MOV #0,R1 - counter
        dc.w    $7101        ; ADD #1,R1 - increment
        ...
```

## Success Metrics

- [ ] sh2_disasm.py enhanced with --format=asm mode
- [ ] code_20200.asm converted to proper assembly
- [ ] ROM builds byte-for-byte identical
- [ ] D102/D002 type bugs impossible (assembler catches them)
- [ ] Development velocity increased

## Tools Needed

1. **sh2_to_asm.py** - Convert dc.w → assembly
2. **sh2_validate.py** - Compare binary output before/after
3. **sh2_label_detector.py** - Find jump/call targets for labeling
4. **Makefile updates** - Support mixed dc.w and assembly builds

## Timeline

- **Week 1**: Build conversion tooling
- **Week 2**: Convert code_20200.asm (our active section)
- **Week 3**: Convert code_200.asm (Slave init)
- **Ongoing**: Convert sections as we touch them
- **Future**: Batch convert remaining sections when tooling is proven

## Next Immediate Steps

1. Create sh2_to_asm.py conversion tool
2. Test on small section (100 bytes)
3. Validate output matches binary
4. Convert code_20200.asm section around $02050C
5. Build and verify ROM still works
6. Commit converted section

---

**Status**: Proposal - awaiting approval to proceed
**Priority**: HIGH - directly impacts development velocity
**Risk**: LOW (incremental approach)
**Effort**: Medium (tooling + manual validation)
