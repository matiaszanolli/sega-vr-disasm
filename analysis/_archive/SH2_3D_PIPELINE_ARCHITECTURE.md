# SH2 3D Rendering Pipeline Architecture

Deep analysis of the Virtua Racing Deluxe SH2 code section.

## Executive Summary

The SH2 code section ($024200-$0261FF) contains **58 functions** totaling **6498 bytes** of code.
The "largest function" (#30 at 1114 bytes) is actually a **lookup table** with a thin wrapper.
The actual rendering code is distributed across Functions #31-58.

## Key Discoveries

### 1. Function #30: Perspective/Reciprocal Table (NOT Code!)

**Address:** $02024694 - $02024AEC (1114 bytes)

The first ~1050 bytes are **lookup table data**:
- Bytes $024694-$0246CE: Header/index structure
- Bytes $0246D0-$024850: Negative values $FFC0→$F000 (perspective correction)
- Bytes $024852-$024ACE: Positive values $1555→$0040 (reciprocal table for division)

**Purpose:** Fast reciprocal lookup for perspective division in 3D projection.
Instead of computing `1/z` (expensive), the code looks up pre-computed values.

**Code wrapper** (only 30 bytes at end):
```asm
$02024AD0: STS.L   PR,@-R15     ; Save return
$02024AD2: MOV.L   @(PC),R1     ; Load pointers
$02024AD4: MOV.L   @(PC),R2
$02024AD6: MOV.L   @R1,R9       ; R9 = data pointer
$02024AD8: MOV     #$00,R3
$02024ADA: MOV.W   R3,@R2       ; Clear counter
$02024ADC: MOV.L   @(PC),R13
$02024ADE: BSR     $02024B00    ; Call actual renderer
$02024AE0: NOP
$02024AE2: MOV.L   @(PC),R0
$02024AE4: JSR     @R0          ; Call cleanup
$02024AE6: NOP
$02024AE8: LDS.L   @R15+,PR     ; Restore return
$02024AEA: RTS
```

### 2. RGB555 Color Format

The 32X uses 15-bit color (RGB555):
```
Bit:    15  14 13 12 11 10  9  8  7  6  5  4  3  2  1  0
        P   B  B  B  B  B   G  G  G  G  G  R  R  R  R  R
        |   |------------|  |-----------|  |-----------|
        |        Blue          Green          Red
        Priority bit (optional)
```

**Extraction pattern** (seen in Functions #48, #49):
```asm
MOV     #$1F,R0        ; Mask = 0x1F (5 bits)
; Red component (bits 0-4)
AND     R0,Rn          ; Rn = color & 0x1F

; Green component (bits 5-9)
SHLR2   Rm             ; >>2
SHLR2   Rm             ; >>2 (total >>4)
SHLR    Rm             ; >>1 (total >>5)
AND     R0,Rm          ; Rm = (color >> 5) & 0x1F

; Blue component (bits 10-14)
SHLR8   Rk             ; >>8
SHLR2   Rk             ; >>2 (total >>10)
AND     R0,Rk          ; Rk = (color >> 10) & 0x1F
```

**Repacking pattern:**
```asm
AND     R0,R5          ; Clamp R to 0-31
SHLL2   R6             ; G << 2
SHLL2   R6             ; G << 4
SHLL    R6             ; G << 5
SHLL8   R7             ; B << 8
SHLL2   R7             ; B << 10
OR      R6,R5          ; R | (G << 5)
OR      R7,R5          ; R | (G << 5) | (B << 10)
MOV.W   R5,@R3         ; Store packed RGB555
```

### 3. Lighting/Shading Pipeline

**Function #48** ($020253DE - 378 bytes): Color blending with lighting
- Uses **MULS.W** (16-bit signed multiply) for light intensity
- **STS MACL** retrieves multiply result from MAC register
- Processes each R, G, B component separately
- Clamps results with `CMP/GT` + conditional move

**Function #49** ($02025558 - 450 bytes): Gouraud shading interpolation
- Calls subroutine 3 times for R, G, B
- 8x **SHAR** (shift arithmetic right) = divide by 256
- Interpolates between vertex colors

### 4. Function Categories

| Range | Functions | Purpose |
|-------|-----------|---------|
| #01-#09 | Small utilities | Initialization, I/O |
| #10-#29 | Medium helpers | Data processing |
| #30 | Data table | Perspective/reciprocal LUT |
| #31 | Context wrapper | Save/restore all registers |
| #32-#47 | Mixed | Various rendering subroutines |
| #48 | Color blending | Lighting calculation |
| #49 | Gouraud shading | Color interpolation |
| #50-#58 | Rendering core | Final rasterization |

### 5. Register Conventions

Based on analysis:
- **R0**: General purpose, accumulator
- **R9**: Often data source pointer (increments with @Rn+)
- **R10-R14**: Color/coordinate working registers
- **R15**: Stack pointer (SP)
- **PR**: Procedure return (saved/restored with STS.L/LDS.L)
- **MACL/MACH**: Multiply-accumulate result registers

### 6. Loop Patterns

**DT (Decrement and Test) loops:**
```asm
loop:
    ; ... process ...
    DT      Rn           ; Rn--, set T if Rn==0
    BF      loop         ; Branch if False (T=0)
```

**Hardware sync loops:**
```asm
wait:
    MOV.W   @R5,R7       ; Read status register
    CMP/EQ  R6,R7        ; Compare with expected value
    BT      wait         ; Loop until matched
```

### 7. Unknown Opcodes

Several opcodes not recognized by standard SH2 decoder:
- `$C7xx` - Likely **MOVA** (move effective address)
- `$0x3D`, `$0x4D`, `$0x5D` - Possibly **SH-DSP** extensions
- `$04A5` - Unknown

These may be:
1. SH2 DSP (digital signal processor) instructions
2. Custom 32X hardware access instructions
3. Co-processor communication

## Memory Map (SH2 View)

```
$02024200-$02024693  : Actual SH2 code (functions #01-#29)
$02024694-$02024ACF  : Perspective lookup table (1052 bytes)
$02024AD0-$02024AED  : Table wrapper function (#30)
$02024AEE-$0202619F  : Remaining functions (#31-#58)
$020261A0-$020281FF  : Sine/cosine table (section_26200)
```

## Performance Implications

1. **Lookup tables** for expensive operations (division, trig)
2. **Full context save/restore** in wrapper functions (expensive)
3. **Fixed-point arithmetic** (no floating point on SH2)
4. **Unrolled operations** (8x SHAR instead of loop)
5. **RGB component separation** - no SIMD, serial processing

## Next Steps for Optimization

1. Profile actual execution (which functions consume most cycles)
2. Identify hot paths in the nested loops
3. Consider lookup table expansion for common cases
4. Analyze Master-Slave coordination overhead
