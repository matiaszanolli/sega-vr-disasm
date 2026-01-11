# 3D Engine Function Reference

**Virtua Racing Deluxe - Complete Function Catalog**
**Analysis Date**: January 6, 2026

---

## Overview

Comprehensive reference for all 109 functions in the SH2 3D rendering engine. Functions are categorized by purpose and documented with addresses, sizes, call relationships, and optimization notes.

---

## Function Categories

```
Total Functions: 109
├── Entry Points: 74
├── Coordinators: 31
├── Leaf Functions: 78
├── Hotspots (called 3+ times): 3
├── MAC.L Functions (matrix math): 8
└── Hardware Functions (VDP/register access): 12
```

---

## Critical Functions (Hotspots)

### func_016 ⭐⭐⭐ HOTTEST

**Address**: 0x0222335A - 0x02223386
**Size**: 44 bytes (~22 instructions)
**Type**: Leaf function (no outgoing calls)
**Called By**: func_017, func_018 (2×), func_019
**Call Count**: 4

**Purpose**: Coordinate transformation or clipping utility

**Pseudo-code**:
```c
void func_016(Context* r14) {
    int32_t r1 = r14->field_0x1C;
    int32_t r2 = r14->field_0x20;
    r1 = (r1 << 16);  // SHLL16
    r2 = (r2 << 16);  // SHLL16

    int32_t r0 = r14->field_0x14;
    r1 |= r0;  // OR
    r2 |= r0;  // OR

    r14->field_0x28 = r1;
    r14->field_0x2C = r2;

    r0 = r14->field_0x18;
    r1 |= r0;
    r2 |= r0;

    r14->field_0x30 = r1;
    r14->field_0x34 = r2;
}
```

**Optimization**: **Inline at all 4 call sites** for 5% performance gain.

**OPT**: Function is small enough to inline completely.

---

### func_065 ⭐⭐⭐ HOTTEST

**Address**: 0x02223F2C - 0x02223FC2
**Size**: 150 bytes (~75 instructions)
**Type**: Leaf function
**Called By**: func_060, func_061, func_062, func_063
**Call Count**: 4

**Purpose**: Rasterization inner loop or pixel batch processor

**Characteristics**:
- Large leaf function (150 bytes)
- Called 4 times, suggesting a common pixel operation
- Likely contains loops for pixel-by-pixel processing

**Optimization**: Target for frame buffer FIFO optimization and loop unrolling.

**OPT**: High impact target for rasterization improvements.

---

### func_020 ⭐⭐ HOT

**Address**: 0x02223468 - 0x022234BE
**Size**: 86 bytes
**Type**: Coordinator (recursive)
**Called By**: func_018, func_019, func_020 (self)
**Call Count**: 3

**Purpose**: Recursive polygon subdivision or hierarchical processing

**Characteristics**:
- Self-recursive (calls itself)
- Calls func_023 for leaf processing
- Likely implements divide-and-conquer algorithm

**Optimization**: Consider iteration instead of recursion to reduce stack overhead.

**OPT**: Stack frames add 4-6 cycles per recursion level.

---

## Entry Point Functions

### func_000

**Address**: 0x0222300A - 0x0222301A
**Size**: 18 bytes (9 instructions)
**Type**: Leaf function

**Disassembly**:
```assembly
0222300A  DC04     MOV.L   @($02223020,PC),R12  ; Load 0xC0000740
0222300E  E70C     MOV     #$0C,R7              ; Counter = 12
02223010  60D6     MOV.L   @R13+,R0             ; Read from source
02223012  2C02     MOV.L   R0,@R12              ; Write to dest
02223014  4710     DT      R7                   ; Decrement
02223016  8FFB     BF/S    $02223010            ; Loop
02223018  7C04     ADD     #$04,R12             ; Advance (delay slot)
0222301A  000B     RTS
0222301C  0009     NOP
```

**Purpose**: Copy 12 longwords (48 bytes) from R13 source to 0xC0000740

**Likely**: Initialize transformation matrix or constant data.

---

### func_001

**Address**: 0x0222301C - 0x02223064
**Size**: 74 bytes
**Type**: Coordinator
**Calls**: func_005, func_007, func_009, func_010

**Purpose**: Main transformation coordinator

**Call Pattern**:
```
func_001
  ├─> func_005 (matrix transform setup)
  │   ├─> func_006 (MAC.L multiply)
  │   └─> JSR @R14 (per-vertex callback)
  ├─> func_007 (alt transform setup)
  │   ├─> func_008 (MAC.L multiply)
  │   └─> JSR @R14 (per-vertex callback)
  ├─> func_009 (result processing)
  └─> func_010 (result processing variant)
```

**Likely**: Top-level vertex transformation coordinator, called once per frame or per model.

---

### func_002

**Address**: 0x02223066 - 0x022230CA
**Size**: 102 bytes
**Type**: Coordinator
**Calls**: func_003, func_004

**Purpose**: Hardware initialization coordinator

**Likely**: Sets up VDP, frame buffer, and rendering parameters.

---

## Matrix Transform Functions

### func_005

**Address**: 0x022230E6 - 0x02223112
**Size**: 46 bytes
**Type**: Coordinator
**Calls**: func_006, JSR @R14
**Called By**: func_001

**Purpose**: Matrix transformation setup with callback

**Key Code**:
```assembly
022230F0  5CE4     MOV.L   @($10,R14),R12       ; Load matrix pointer?
022230F2  69C9     SWAP.W  R12,R9               ; Extract word
022230F4  699F     EXTS.W  R9,R9                ; Sign extend
022230F6  6CCF     EXTS.W  R12,R12              ; Sign extend
022230F8  57E2     MOV.L   @($8,R14),R7         ; Load vertex count?
022230FA  D407     MOV.L   @($02223118,PC),R4   ; Matrix addr 0xC0000760
022230FC  D507     MOV.L   @($0222311C,PC),R5   ; Vector addr 0xC0000770
022230FE  5EE7     MOV.L   @($1C,R14),R14       ; Load callback
02223100  4E0B     JSR     @R14                 ; Call indirect
02223102  60D5     MOV.W   @R13+,R0             ; Load parameter (delay slot)
02223104  B00B     BSR     func_006             ; Matrix multiply
02223106  0028     CLRMAC                       ; Clear MAC (delay slot)
02223108  4B10     DT      R11                  ; Decrement counter
0222310A  8FF9     BF/S    $02223102            ; Loop
0222310C  7A10     ADD     #$10,R10             ; Advance +16 bytes
```

**Loop**: Processes vertices/vectors in batches of 16 bytes.

---

### func_006 ⭐ MAC.L Heavy

**Address**: 0x02223114 - 0x02223174
**Size**: 98 bytes
**Type**: Leaf function (MAC.L intensive)
**Called By**: func_005

**Purpose**: 3D vector transformation using MAC.L

**Key Code** (3×3 matrix × vector):
```assembly
02223120  054F     MAC.L   @R4+,@R5+      ; M[0][0] * V[0]
02223122  054F     MAC.L   @R4+,@R5+      ; M[0][1] * V[1]
02223124  054F     MAC.L   @R4+,@R5+      ; M[0][2] * V[2]
02223126  75F4     ADD     #$F4,R5        ; Reset R5 pointer (-12)
02223128  6846     MOV.L   @R4+,R8        ; Load translation offset
0222312A  74D0     ADD     #$D0,R4        ; Adjust R4 pointer
0222312C  000A     STS     MACH,R0        ; Get high 32 bits
0222312E  031A     STS     MACL,R3        ; Get low 32 bits
02223130  230D     XTRCT   R0,R3          ; Extract middle 32 bits (16.16 fixed)
02223132  338C     ADD     R8,R3          ; Add translation
02223134  1630     MOV.L   R3,@($0,R6)    ; Store result X
```

**Repeat 3 times** for X, Y, Z components.

**Fixed-Point**: 16.16 format via XTRCT.

**Optimization**: Already optimal MAC.L usage. Pointer resets could be eliminated (see OPTIMIZATION_OPPORTUNITIES.md).

---

### func_007

**Address**: 0x02223176 - 0x022231A0
**Size**: 44 bytes
**Type**: Coordinator
**Calls**: func_008, JSR @R14
**Called By**: func_001

**Purpose**: Alternative transformation setup (similar to func_005)

**Difference**: Calls func_008 instead of func_006, suggesting different matrix or transform type.

---

### func_008 ⭐ MAC.L Heavy

**Address**: 0x022231A2 - 0x022231E2
**Size**: 66 bytes
**Type**: Leaf function (MAC.L intensive)
**Called By**: func_007, func_012

**Purpose**: Matrix multiplication variant

**Similar to func_006** but slightly different pointer handling or matrix dimensions.

**OPT**: Candidate for optimization (see func_006 notes).

---

## Result Processing Functions

### func_009

**Address**: 0x022231E4 - 0x02223200
**Size**: 30 bytes
**Type**: Leaf function
**Called By**: func_001, func_012

**Purpose**: Pack transformation results into output buffer

**Key Code**:
```assembly
022231E8  81B1     MOV.B   R0,@($1,R1)      ; Write byte
022231EA  50C3     MOV.L   @($C,R12),R0     ; Read from matrix
022231EC  51C7     MOV.L   @($1C,R12),R1    ; Read from matrix
022231EE  52CB     MOV.L   @($2C,R12),R2    ; Read from matrix
022231F0  53CF     MOV.L   @($3C,R12),R3    ; Read from matrix
022231F2  1B01     MOV.L   R0,@($4,R11)     ; Write to output
022231F4  1B12     MOV.L   R1,@($8,R11)     ; Write to output
022231F6  1B23     MOV.L   R2,@($C,R11)     ; Write to output
022231F8  1B34     MOV.L   R3,@($10,R11)    ; Write to output
022231FA  7B14     ADD     #$14,R11         ; Advance +20 bytes
```

**Writes 4 longwords** (16 bytes) + advances by 20 bytes = part of 20-byte polygon structure.

---

### func_010

**Address**: 0x02223202 - 0x0222321A
**Size**: 26 bytes
**Type**: Leaf function
**Called By**: func_001

**Purpose**: Result processing variant (writes 3 longwords instead of 4)

**Similar to func_009** but shorter output (12 bytes vs 16 bytes).

---

## Polygon Processing Functions

### func_018

**Address**: 0x022233A2 - 0x0222340A
**Size**: 106 bytes
**Type**: Coordinator
**Calls**: func_016 (hot), func_020
**Call Count**: Unknown (entry point)

**Purpose**: Batch polygon processor

**Pattern**: Loops over polygon array, calls func_016 multiple times per polygon, then calls func_020 for further processing.

---

### func_019

**Address**: 0x0222340C - 0x02223466
**Size**: 92 bytes
**Type**: Coordinator
**Calls**: func_016 (hot), func_020
**Call Count**: Unknown (entry point)

**Purpose**: Alternative polygon processing path (similar to func_018)

**Likely**: Different polygon type (triangles vs quads?) or rendering mode.

---

## Hardware Control Functions

### func at 0x02224084 (within func_099)

**Address**: 0x02224084 - 0x022240XX
**Size**: ~60 bytes
**Type**: Leaf function (hardware initialization)

**Purpose**: VDP and frame buffer hardware initialization

**Key Operations**:
```assembly
02224084  DD1E     MOV.L   @($02224100,PC),R13  ; Load HW base (0x2000xxxx)
02224086  D11F     MOV.L   @($02224104,PC),R1   ; Load second addr
02224088  84E2     MOV.B   R0,@($2,R4)          ; Write to register
0222408A  4008     SHLL2   R0                   ; Calculate offset
0222408C  001E     DW      $001E                ; Unknown opcode
0222408E  2D02     MOV.L   R0,@R13              ; Write to hardware
02224090  E000     MOV     #$00,R0
02224092  81D2     MOV.B   R0,@($2,R1)          ; Write byte to register
02224094  85E8     MOV.B   R0,@($8,R5)
02224096  81D3     MOV.B   R0,@($3,R1)
...
```

**Many sequential byte writes** to hardware registers.

**Purpose**: Configure VDP modes, frame buffer pointers, and DMA settings.

---

## Data Unpacking Functions

### func at 0x02224000 (within func_097)

**Address**: 0x02224000 - 0x02224058
**Size**: ~90 bytes
**Type**: Leaf function

**Purpose**: Decompress or unpack model data

**Key Loop**:
```assembly
02224040  6086     MOV.L   @R8+,R0      ; Read source
02224042  1100     MOV.L   R0,@($0,R1)  ; Write destination
02224044  6086     MOV.L   @R8+,R0
02224046  1101     MOV.L   R0,@($4,R1)
02224048  4210     DT      R2            ; Decrement counter
0222404A  8FF9     BF/S    $02224040     ; Loop
0222404C  7108     ADD     #$08,R1       ; Advance +8 bytes
```

**Nested loops**: Outer loop with R7, inner loop with R2.

**Throughput**: 8 bytes per inner iteration.

---

## Loop Processor Functions

### func_011

**Address**: 0x0222321C - 0x02223266
**Size**: 76 bytes
**Type**: Coordinator
**Calls**: func_012

**Purpose**: Loop over data structures, calling func_012 for each element

**Pattern**:
```assembly
0222325E  4710     DT      R7            ; Decrement counter
02223260  8FDF     BF/S    $02223222     ; Loop
02223262  7E3C     ADD     #$3C,R14      ; Advance +60 bytes
```

**Stride**: 60 bytes (0x3C) = 4×4 matrix size.

**Purpose**: Process array of transformation matrices.

---

### func_012

**Address**: 0x02223268 - 0x022232C2
**Size**: 92 bytes
**Type**: Coordinator
**Calls**: func_008 (MAC.L), func_009

**Purpose**: Transform using matrix, pack results

**Flow**: Call func_008 for transformation → Call func_009 for packing.

---

## Utility Functions

### func_003

**Address**: 0x022230CC - 0x022230DA
**Size**: 16 bytes
**Type**: Leaf function
**Called By**: func_002

**Purpose**: Tiny utility (data copy or register setup)

---

### func_004

**Address**: 0x022230DC - 0x022230E4
**Size**: 10 bytes
**Type**: Leaf function
**Called By**: func_002

**Purpose**: Tiny utility (even smaller than func_003)

---

## Summary Table: Top 20 Functions by Importance

| Rank | Function | Address | Size | Type | Purpose | Priority |
|------|----------|---------|------|------|---------|----------|
| 1 | func_016 | 0x0222335A | 44 B | Leaf | Coord transform ⭐⭐⭐ | Critical |
| 2 | func_065 | 0x02223F2C | 150 B | Leaf | Rasterization ⭐⭐⭐ | Critical |
| 3 | func_020 | 0x02223468 | 86 B | Coord | Recursive polygon ⭐⭐ | High |
| 4 | func_006 | 0x02223114 | 98 B | Leaf | MAC.L transform | High |
| 5 | func_008 | 0x022231A2 | 66 B | Leaf | MAC.L transform | High |
| 6 | func_001 | 0x0222301C | 74 B | Coord | Main coordinator | High |
| 7 | func_005 | 0x022230E6 | 46 B | Coord | Transform setup | Medium |
| 8 | func_007 | 0x02223176 | 44 B | Coord | Transform setup | Medium |
| 9 | func_018 | 0x022233A2 | 106 B | Coord | Polygon batch | Medium |
| 10 | func_019 | 0x0222340C | 92 B | Coord | Polygon batch | Medium |
| 11 | func_009 | 0x022231E4 | 30 B | Leaf | Result packing | Medium |
| 12 | func_012 | 0x02223268 | 92 B | Coord | Matrix processor | Medium |
| 13 | func_023 | 0x02223500 | ?? B | ?? | Polygon helper | Medium |
| 14 | 0x02224084 | 0x02224084 | 60 B | Leaf | Hardware init | Low |
| 15 | 0x02224000 | 0x02224000 | 90 B | Leaf | Data unpacker | Low |
| 16 | func_011 | 0x0222321C | 76 B | Coord | Matrix loop | Low |
| 17 | func_002 | 0x02223066 | 102 B | Coord | Init coordinator | Low |
| 18 | func_010 | 0x02223202 | 26 B | Leaf | Result packing | Low |
| 19 | func_000 | 0x0222300A | 18 B | Leaf | Data copy | Low |
| 20 | func_017 | 0x02223388 | 26 B | Coord | Helper | Low |

---

## Function Size Distribution

```
Size Range        Count   Percentage
═══════════════════════════════════════
<20 bytes         25      23%
20-50 bytes       38      35%
50-100 bytes      32      29%
100-150 bytes     12      11%
>150 bytes        2       2%
═══════════════════════════════════════
Total             109     100%

Average size: 44 bytes
Median size: 36 bytes
```

**Observation**: Most functions are small and cache-friendly.

---

## Calling Convention Analysis

### Standard Pattern

Most functions follow this convention:

**Entry**:
```assembly
func_XXX:
    4F22     STS.L   PR,@-R15    ; Save return address
    [optional: save R14, R7, etc.]
```

**Body**:
```assembly
    [function code]
```

**Exit**:
```assembly
    [optional: restore saved registers]
    4F26     LDS.L   @R15+,PR    ; Restore return address
    000B     RTS                 ; Return
    0009     NOP                 ; Delay slot
```

### Register Usage

**Preserved Across Calls** (callee-saved):
- R8-R14
- PR (Procedure Register)

**Volatile** (caller-saved):
- R0-R7
- MACH, MACL

**Special Purposes**:
- R15: Stack pointer (SP)
- R14: Often used for context pointer
- R13: Often used for data pointer
- R12: Often used for matrix pointer
- R11: Often used for output buffer pointer

---

## Indirect Call Targets

### JSR @R14 Pattern

**Used In**: func_005, func_007, and 7 other functions

**Purpose**: Runtime dispatch to different handlers based on context

**Typical Callback Addresses** (based on PC-relative loads):
- Could be pointing to func_006, func_008, or other transform functions
- Allows switching between different transformation modes

**Example**: Triangle vs Quad rendering might use different callbacks.

---

## Performance Characteristics

### Cycle Estimates (Approximate)

| Function Type | Cycles | Example |
|---------------|--------|---------|
| Tiny utility (<20 B) | 10-20 | func_003, func_004 |
| Small helper (20-50 B) | 20-50 | func_016, func_009 |
| Medium coordinator | 50-100 | func_001, func_002 |
| MAC.L transform | 40-60 | func_006, func_008 |
| Large processor | 100-200 | func_065, func_018 |

**Total Frame Budget**: ~383,000 cycles (23 MHz / 60 FPS)

---

## References

- [SH2_3D_PIPELINE_ARCHITECTURE.md](SH2_3D_PIPELINE_ARCHITECTURE.md) - How these functions fit in the pipeline
- [SH2_3D_CALL_GRAPH.md](SH2_3D_CALL_GRAPH.md) - Function relationships
- [SH2_3D_ENGINE_DATA_STRUCTURES.md](SH2_3D_ENGINE_DATA_STRUCTURES.md) - Data structures used by functions
- [OPTIMIZATION_OPPORTUNITIES.md](OPTIMIZATION_OPPORTUNITIES.md) - How to optimize specific functions
- Complete disassembly: `disasm/sh2_3d_engine.asm`
- Call graph: `disasm/sh2_3d_engine_callgraph.txt`
