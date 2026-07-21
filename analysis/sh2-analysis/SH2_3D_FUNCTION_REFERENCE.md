# 3D Engine Function Reference

**Virtua Racing Deluxe - Complete Function Catalog**
**Analysis Date**: January 6, 2026
**Last Updated**: February 28, 2026 (all 92 function IDs integrated into build system)

---

## Overview

Comprehensive reference for all 109 functions in the SH2 3D rendering engine. Functions are categorized by purpose and documented with addresses, sizes, call relationships, and optimization notes.

---

## Function Categories

```
Total Functions: 109
├── Fully Integrated: 92 function IDs (74 .inc groups, all byte-verified)
├── Entry Points: 74
├── Coordinators: 31
├── Leaf Functions: 78
├── Hotspots (called 3+ times): 3
├── MAC.L Functions (matrix math): 8
└── Hardware Functions (VDP/register access): 12
```

**Translation Directory**: All 92 function IDs are integrated into the build system via `disasm/sh2/3d_engine/` source files → `disasm/sh2/generated/` .inc files. See [SH2_TRANSLATION_INTEGRATION.md](SH2_TRANSLATION_INTEGRATION.md) for full accounting.

**Coverage by section:**
- `code_22200.asm`: 57 functions (main 3D engine core)
- `code_24200.asm`: 17 functions (utilities, polling, hardware init)
- `expansion_300000.asm`: 1 function (optimized vertex transform)

---

## Critical Functions (Hotspots)

### coord_transform ⭐⭐⭐ HOTTEST

**Address**: 0x0222335A - 0x02223386
**Size**: 44 bytes (~22 instructions)
**Type**: Leaf function (no outgoing calls)
**Called By**: quad_helper, quad_batch_short (2×), quad_batch_alt_short
**Call Count**: 4

**Purpose**: Coordinate transformation or clipping utility

**Pseudo-code**:
```c
void coord_transform(Context* r14) {
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

**v4.0 Status**: 📋 **Code ready** - Inlined in vertex_transform_optimized at $300100 (infrastructure complete, not yet activated)

---

### unrolled_data_copy ⭐⭐⭐ HOTTEST

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

### vertex_helper_short ⭐⭐ HOT

**Address**: 0x02223468 - 0x022234BE
**Size**: 86 bytes
**Type**: Coordinator (recursive)
**Called By**: quad_batch_short, quad_batch_alt_short, vertex_helper_short (self)
**Call Count**: 3
**Translation**: `disasm/modules/sh2/3d-engine/vertex_helper_short_recursive_quad.asm`, `vertex_helper_short.asm`

**Purpose**: Recursive polygon subdivision or hierarchical processing

**Characteristics**:
- Self-recursive (calls itself)
- Calls frustum_cull_short for leaf processing
- Likely implements divide-and-conquer algorithm

**Optimization**: Consider iteration instead of recursion to reduce stack overhead.

**OPT**: Stack frames add 4-6 cycles per recursion level.

---

### frustum_cull_short ⭐⭐⭐ LARGEST STANDALONE FUNCTION

**Address**: 0x02223508 - 0x022235F5
**Size**: 238 bytes (largest single function in 3D engine)
**Type**: Coordinator (visibility hub)
**Called By**: vertex_helper_short, vertex_transform
**Calls**: screen_coords_short, bounds_compare_short, func_029, scanline_setup, render_quad_short, render_dispatch_short
**Translation**: `disasm/modules/sh2/3d-engine/frustum_cull_short_frustum_cull.asm`, `frustum_cull_short.asm`

**Purpose**: Core visibility testing and rendering dispatch hub - the heart of the 3D engine

**Verified Operations**:
- Performs frustum culling on quads
- Multiple visibility test paths with early-out rejection
- Loads 6 context pointers from SDRAM (0xC0000700, 0xC0000740, 0xC0000780, 0xC00007A0, 0xC00007C0, 0xC00007E0)
- Z-depth testing and inequality checks
- Complex branching with 3 separate literal pools

**Key Code Patterns**:
```assembly
; Context pointer loading
MOV.L @(PC,disp),R8  ; Load 0xC0000700
MOV.L @(PC,disp),R9  ; Load 0xC0000740
; ...
; Visibility test and early-out
TST R0,R0
BT .reject_polygon
; Depth comparison
CMP/GT R2,R3
BF .occluded
```

**Optimization**: Large function, but branching is well-optimized with early exits. Cache-friendly at 238 bytes.

---

### vertex_transform ⭐⭐⭐ INFRASTRUCTURE READY FOR SLAVE OFFLOAD (v4.0)

**Address**: 0x022234C8 (original implementation at baseline)
**Size**: Original ~36 bytes (current state), Optimized 96 bytes (ready at $300100)
**Type**: Coordinator → **Infrastructure ready for Slave offload**
**Called By**: Command handler for cmd 0x16
**Calls**: coord_transform (currently uses JSR, inlined in optimized version)

**Purpose**: Vertex coordinate transformation with culling

**v4.0 Status**: **HISTORICAL/INVALID PARAMETER MAP, NOT ACTIVATED**

**Current state** (v4.0-baseline):
- Original vertex_transform implementation active at $0234C8
- Slave SH2 remains in idle loop (does not participate in rendering)
- Master SH2 executes all transform work sequentially

**Infrastructure ready for activation**:
- ✅ `vertex_transform_optimized` at $300100 - Optimized version with coord_transform inlined (96 bytes)
- ⚠ Built parameter literal 0x2203E000 is cartridge ROM, not writable SDRAM
- ✅ `slave_work_wrapper` at $300200 - COMM7 polling loop ready
- ⏳ **Not yet connected** - Requires trampoline at $0234C8 + Slave PC redirect

**Designed trampoline behavior** (when activated):
1. Capture parameters (R14, R7, R8, R5) to shared memory at 0x2203E000
2. Signal Slave SH2 via COMM7 = 0x16
3. Return immediately (Master continues, Slave does work in parallel)

**Historical Parameter Block Design** (`0x2203E000` is an invalid ROM alias; intended
cache-through SDRAM would be `0x2603E000`):

*For SDRAM, cache-through addressing is `0x26XXXXXX`; `0x22XXXXXX` is cartridge ROM.*

| Offset | Register | Purpose |
|--------|----------|---------|
| +0x00 | R14 | RenderingContext pointer |
| +0x04 | R7 | Loop counter (polygon count) |
| +0x08 | R8 | Data pointer |
| +0x0C | R5 | Output pointer |

**Optimized Version** (`vertex_transform_optimized` at $300100 - ready but not active):
- coord_transform fully inlined (eliminates JSR/RTS overhead)
- 96 bytes total
- Designed to run on Slave SH2 in parallel with Master
- Expected 15-20% performance improvement when activated

**Impact**: Infrastructure complete for first parallel processing between SH2 CPUs.

---

## Entry Point Functions

### data_copy

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

### main_coordinator_short

**Address**: 0x0222301C - 0x02223064
**Size**: 74 bytes
**Type**: Coordinator
**Calls**: transform_loop, alt_transform_loop, display_list_4elem, display_list_3elem

**Purpose**: Main transformation coordinator

**Call Pattern**:
```
main_coordinator_short
  ├─> transform_loop (matrix transform setup)
  │   ├─> matrix_multiply (MAC.L multiply)
  │   └─> JSR @R14 (per-vertex callback)
  ├─> alt_transform_loop (alt transform setup)
  │   ├─> alt_matrix_multiply (MAC.L multiply)
  │   └─> JSR @R14 (per-vertex callback)
  ├─> display_list_4elem (result processing)
  └─> display_list_3elem (result processing variant)
```

**Likely**: Top-level vertex transformation coordinator, called once per frame or per model.

---

### case_handlers_short

**Address**: 0x02223066 - 0x022230CA
**Size**: 102 bytes
**Type**: Coordinator
**Calls**: func_003, func_004

**Purpose**: Hardware initialization coordinator

**Likely**: Sets up VDP, frame buffer, and rendering parameters.

---

## Matrix Transform Functions

### transform_loop

**Address**: 0x022230E6 - 0x02223112
**Size**: 46 bytes
**Type**: Coordinator
**Calls**: matrix_multiply, JSR @R14
**Called By**: main_coordinator_short

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
02223104  B00B     BSR     matrix_multiply             ; Matrix multiply
02223106  0028     CLRMAC                       ; Clear MAC (delay slot)
02223108  4B10     DT      R11                  ; Decrement counter
0222310A  8FF9     BF/S    $02223102            ; Loop
0222310C  7A10     ADD     #$10,R10             ; Advance +16 bytes
```

**Loop**: Processes vertices/vectors in batches of 16 bytes.

---

### matrix_multiply ⭐ MAC.L Heavy

**Address**: 0x02223114 - 0x02223174
**Size**: 98 bytes
**Type**: Leaf function (MAC.L intensive)
**Called By**: transform_loop

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

### alt_transform_loop

**Address**: 0x02223176 - 0x022231A0
**Size**: 44 bytes
**Type**: Coordinator
**Calls**: alt_matrix_multiply, JSR @R14
**Called By**: main_coordinator_short

**Purpose**: Alternative transformation setup (similar to transform_loop)

**Difference**: Calls alt_matrix_multiply instead of matrix_multiply, suggesting different matrix or transform type.

---

### alt_matrix_multiply ⭐ MAC.L Heavy

**Address**: 0x022231A2 - 0x022231E2
**Size**: 66 bytes
**Type**: Leaf function (MAC.L intensive)
**Called By**: alt_transform_loop, display_entry

**Purpose**: Matrix multiplication variant

**Similar to matrix_multiply** but slightly different pointer handling or matrix dimensions.

**OPT**: Candidate for optimization (see matrix_multiply notes).

---

## Result Processing Functions

### display_list_4elem

**Address**: 0x022231E4 - 0x02223200
**Size**: 30 bytes
**Type**: Leaf function
**Called By**: main_coordinator_short, display_entry

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

### display_list_3elem

**Address**: 0x02223202 - 0x0222321A
**Size**: 26 bytes
**Type**: Leaf function
**Called By**: main_coordinator_short

**Purpose**: Result processing variant (writes 3 longwords instead of 4)

**Similar to display_list_4elem** but shorter output (12 bytes vs 16 bytes).

---

## Polygon Processing Functions

### quad_batch_short

**Address**: 0x022233A2 - 0x0222340A
**Size**: 106 bytes
**Type**: Coordinator
**Calls**: coord_transform (hot), vertex_helper_short
**Call Count**: Unknown (entry point)

**Purpose**: Batch polygon processor

**Pattern**: Loops over polygon array, calls coord_transform multiple times per polygon, then calls vertex_helper_short for further processing.

---

### quad_batch_alt_short

**Address**: 0x0222340C - 0x02223466
**Size**: 92 bytes
**Type**: Coordinator
**Calls**: coord_transform (hot), vertex_helper_short
**Call Count**: Unknown (entry point)
**Translation**: `disasm/modules/sh2/3d-engine/quad_batch_alt_short_quad_batch_alt.asm`, `quad_batch_alt_short.asm`

**Purpose**: Alternative polygon processing path (similar to quad_batch_short)

**Likely**: Different polygon type (triangles vs quads?) or rendering mode.

---

## Rasterization Functions (Newly Documented)

### render_quad_short ⭐⭐ Quad Rendering

**Address**: 0x022236FA - 0x0222375B
**Size**: 98 bytes
**Type**: Coordinator
**Called By**: frustum_cull_short (visibility hub)
**Calls**: span_filler_short (span filler)
**Translation**: `disasm/modules/sh2/3d-engine/render_quad_short_render_quad.asm`, `render_quad_short.asm`

**Purpose**: Renders quads by walking their edges, generating scanline data

**Verified Operations**:
- Edge buffer at 0xC0000740
- MAC.W for edge interpolation (@R8+ and @R9+)
- Coordinate comparison for left/right edge detection
- Branch paths based on edge order (left-first vs right-first)

**Key Code Pattern**:
```assembly
; Edge walking with MAC.W interpolation
MAC.W @R8+,@R9+    ; Interpolate edge value
STS MACL,R0        ; Get result
; Left/right edge comparison
CMP/GT R2,R3
BT .right_edge_first
```

---

### span_filler_short ⭐⭐ Span Filler

**Address**: 0x0222375C - 0x022237D5
**Size**: 122 bytes
**Type**: Leaf function
**Called By**: render_quad_short
**Translation**: `disasm/modules/sh2/3d-engine/span_filler_short_span_filler.asm`, `span_filler_short.asm`

**Purpose**: Calculates interpolated edge values for scanline rendering

**Verified Operations**:
- Two paths: large delta (reciprocal table), small delta (direct math)
- **Reciprocal table at 0x060048D0** for fast division approximation
- MULS.W for edge value multiplication
- SHLL16/SHLL2 for fixed-point scaling
- Coordinate swapping and sign extension

**Key Finding**: Uses precomputed reciprocal table to avoid expensive division operations - common 90s optimization technique.

---

### display_list_short ⭐ Display List Buffer Setup

**Address**: 0x0222385E - 0x022238D7
**Size**: 122 bytes
**Type**: Leaf function with jump table
**Called By**: Display engine coordinator
**Translation**: `disasm/modules/sh2/3d-engine/display_list_short.asm`

**Purpose**: Initialize display list buffers at VDP addresses

**Verified Operations**:
- VDP buffer pointers: **0xC00007C0** (buf A), **0xC00007E0** (buf B)
- **12-entry jump table** for polygon type dispatch
- Wait loop for status bit 8 (buffer ready)
- Two copy loops transfer data from VDP to working buffers
- Uses 0xFF as terminator for copy loops
- Multiple alternate entry points for different copy modes

**Jump Table Offsets** (from 0x023886):
```
Index  Offset  Purpose
0      0x09    (default path)
1      0x2A    (42 bytes forward)
2      0x42    (66 bytes forward)
...
11     0x58    (88 bytes forward)
```

**Flag Mask**: 0x20000000 used for status register checking

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

### display_list_loop

**Address**: 0x0222321C - 0x02223266
**Size**: 76 bytes
**Type**: Coordinator
**Calls**: display_entry

**Purpose**: Loop over data structures, calling display_entry for each element

**Pattern**:
```assembly
0222325E  4710     DT      R7            ; Decrement counter
02223260  8FDF     BF/S    $02223222     ; Loop
02223262  7E3C     ADD     #$3C,R14      ; Advance +60 bytes
```

**Stride**: 60 bytes (0x3C) = 4×4 matrix size.

**Purpose**: Process array of transformation matrices.

---

### display_entry

**Address**: 0x02223268 - 0x022232C2
**Size**: 92 bytes
**Type**: Coordinator
**Calls**: alt_matrix_multiply (MAC.L), display_list_4elem

**Purpose**: Transform using matrix, pack results

**Flow**: Call alt_matrix_multiply for transformation → Call display_list_4elem for packing.

---

## Utility Functions

### func_003

**Address**: 0x022230CC - 0x022230DA
**Size**: 16 bytes
**Type**: Leaf function
**Called By**: case_handlers_short

**Purpose**: Tiny utility (data copy or register setup)

---

### func_004

**Address**: 0x022230DC - 0x022230E4
**Size**: 10 bytes
**Type**: Leaf function
**Called By**: case_handlers_short

**Purpose**: Tiny utility (even smaller than func_003)

---

## Summary Table: Top 25 Functions by Importance

| Rank | Function | Address | Size | Type | Purpose | Status |
|------|----------|---------|------|------|---------|--------|
| 1 | **vertex_transform** | 0x022234C8 | 38 B | Offload | **Vertex transform ✅ PARALLELIZED** | ✅ Translated |
| 2 | **frustum_cull_short** | 0x02223508 | **238 B** | Coord | **Frustum cull hub (LARGEST)** | ✅ Translated |
| 3 | coord_transform | 0x02223368 | 34 B | Leaf | Coord packing (17% frame budget) | ✅ Translated |
| 4 | unrolled_data_copy | 0x02223F2C | 150 B | Leaf | Rasterization ⭐⭐⭐ | ✅ Translated |
| 5 | display_list_short | 0x0222385E | 122 B | Leaf | Display list (12-entry jump table) | ✅ Translated |
| 6 | render_quad_short | 0x022236FA | 98 B | Coord | Quad edge walking | ✅ Translated |
| 7 | span_filler_short | 0x0222375C | 122 B | Leaf | Span filler (reciprocal table) | ✅ Translated |
| 8 | vertex_helper_short | 0x02223468 | 86 B | Coord | Recursive polygon ⭐⭐ | ✅ Translated |
| 9 | matrix_multiply | 0x02223120 | 88 B | Leaf | MAC.L transform (~45 cyc/vtx) | ✅ Translated |
| 10 | alt_matrix_multiply | 0x022231A2 | 66 B | Leaf | MAC.L transform | ✅ Translated |
| 11 | main_coordinator_short | 0x02223024 | 74 B | Coord | Main coordinator | ✅ Translated |
| 12 | transform_loop | 0x022230E8 | 56 B | Coord | Transform loop | ✅ Translated |
| 13 | screen_coords_short | 0x022235F6 | 62 B | Leaf | Screen coords (3D→2D) | ✅ Translated |
| 14 | quad_batch_short | 0x022233A2 | 106 B | Coord | Polygon batch | ✅ Translated |
| 15 | quad_batch_alt_short | 0x0222340C | 92 B | Coord | Polygon batch alt | ✅ Translated |
| 16 | display_list_4elem | 0x022231E4 | 30 B | Leaf | Result packing | ✅ Translated |
| 17 | display_entry | 0x02223268 | 92 B | Coord | Matrix processor | Medium |
| 18 | func_014 | 0x02223330 | 18 B | Leaf | VDP 6-byte copy | ✅ Translated |
| 19 | func_015 | 0x02223342 | 38 B | Leaf | VDP 402-byte copy | ✅ Translated |
| 20 | data_copy | 0x0222300A | 26 B | Leaf | Matrix data copy | ✅ Translated |
| 21 | display_list_loop | 0x0222321C | 76 B | Coord | Display list loop | ✅ Translated |
| 22 | case_handlers_short | 0x02223066 | 102 B | Coord | Case handlers | ✅ Translated |
| 23 | display_list_3elem | 0x02223202 | 26 B | Leaf | Result packing | Medium |
| 24 | quad_helper | 0x02223388 | 26 B | Coord | Quad helper | ✅ Translated |
| 25 | alt_transform_loop | 0x02223176 | 44 B | Coord | Alt transform setup | ✅ Translated |

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

**Used In**: transform_loop, alt_transform_loop, and 7 other functions

**Purpose**: Runtime dispatch to different handlers based on context

**Typical Callback Addresses** (based on PC-relative loads):
- Could be pointing to matrix_multiply, alt_matrix_multiply, or other transform functions
- Allows switching between different transformation modes

**Example**: Triangle vs Quad rendering might use different callbacks.

---

## Performance Characteristics

### Cycle Estimates (Approximate)

| Function Type | Cycles | Example |
|---------------|--------|---------|
| Tiny utility (<20 B) | 10-20 | func_003, func_004 |
| Small helper (20-50 B) | 20-50 | coord_transform, display_list_4elem |
| Medium coordinator | 50-100 | main_coordinator_short, case_handlers_short |
| MAC.L transform | 40-60 | matrix_multiply, alt_matrix_multiply |
| Large processor | 100-200 | unrolled_data_copy, quad_batch_short |

**Total Frame Budget**: ~383,000 cycles (23 MHz / 60 FPS)

---

## References

- [SH2_3D_PIPELINE_ARCHITECTURE.md](SH2_3D_PIPELINE_ARCHITECTURE.md) - How these functions fit in the pipeline
- [SH2_3D_CALL_GRAPH.md](SH2_3D_CALL_GRAPH.md) - Function relationships
- [SH2_3D_ENGINE_DATA_STRUCTURES.md](SH2_3D_ENGINE_DATA_STRUCTURES.md) - Data structures used by functions
- [OPTIMIZATION_OPPORTUNITIES.md](OPTIMIZATION_OPPORTUNITIES.md) - How to optimize specific functions
- [SLAVE_INJECTION_GUIDE.md](SLAVE_INJECTION_GUIDE.md) - vertex_transform offload infrastructure details (v4.0 baseline)
- Complete disassembly: `disasm/sh2_3d_engine.asm`
- Call graph: `disasm/sh2_3d_engine_callgraph.txt`

### Translated Assembly Sources

All 92 function IDs are covered by source files in `disasm/sh2/3d_engine/` assembled into 74 .inc groups in `disasm/sh2/generated/` (some files cover multiple related functions):

**Key Translation Files by Pipeline Stage:**

| Stage | Files |
|-------|-------|
| **Coordination** | `main_coordinator_short_main_coordinator.asm`, `case_handlers_short_case_handlers.asm`, `master_command_loop.asm`, `slave_command_dispatcher.asm` |
| **Transform** | `transform_loop.asm`, `matrix_multiply.asm`, `coord_transform.asm`, `vertex_transform_original.asm` |
| **Culling** | `frustum_cull_short_frustum_cull.asm`, `screen_coords_short_screen_coords.asm`, `visibility_short.asm` |
| **Rendering** | `render_quad_short_render_quad.asm`, `span_filler_short_span_filler.asm`, `render_dispatch_short_render_dispatch.asm` |
| **Display** | `display_list_short.asm`, `display_list_short_059_display_engine.asm`, `display_list_4elem.asm`, `conditional_bsr_short.asm`, `unrolled_copy_short.asm`, `loop_dispatcher_short.asm` |
| **VDP/HW** | `vdp_copy_short.asm`, `rle_entry_alt1_short_plus_vdp_hw.asm`, `func_vdp_init_with_delay.asm` |
| **Utilities** | `unrolled_data_copy.asm`, `rle_decoder.asm`, `data_copy.asm`, `rle_entry_alt1_short.asm`, `rle_entry_alt2_short.asm`, `block_copy_stride_short.asm` |
