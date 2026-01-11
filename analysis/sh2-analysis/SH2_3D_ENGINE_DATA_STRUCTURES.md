# 3D Engine Data Structures

**Virtua Racing Deluxe - SH2 Memory Layouts**
**Analysis Date**: January 6, 2026

---

## Overview

Analysis of 379 memory accesses with displacement offsets revealed 14 distinct data structures used throughout the 3D engine. These structures manage rendering context, transformation matrices, vertex data, and polygon descriptors.

---

## Primary Structures

### Structure 1: Rendering Context (R14-based)

**Size**: 56 bytes (0x38)
**Base Register**: R14
**Usage**: Main rendering state and pointers
**Access Count**: 87 (most frequently accessed structure)

**Definition**:
```c
struct RenderingContext {
    uint32_t field_0x00;           // +0x00
    uint32_t field_0x04;           // +0x04 - Used in initialization
    uint32_t field_0x08;           // +0x08 - Counter/state
    uint32_t field_0x0C;           // +0x0C
    uint32_t field_0x10;           // +0x10 - Used in matrix ops
    uint32_t field_0x14;           // +0x14 - Address/pointer
    uint32_t field_0x18;           // +0x18 - Used in transforms
    void*    callback;             // +0x1C - Function pointer (JSR @R14)
    void*    buffer_ptr;           // +0x20 - SDRAM buffer pointer
    void*    output_ptr;           // +0x24 - Output buffer pointer
    void*    work_ptr1;            // +0x28 - Working memory
    void*    work_ptr2;            // +0x2C - Working memory
    uint32_t field_0x30;           // +0x30
    uint32_t field_0x34;           // +0x34
};  // Total: 56 bytes
```

**Sample Accesses**:
```assembly
02223034  5AEB     MOV.L   @($2C,R14),R10   ; Load work_ptr2
02223036  5BE9     MOV.L   @($24,R14),R11   ; Load output_ptr
022230F8  57E2     MOV.L   @($8,R14),R7     ; Load field_0x08
02223100  5EE7     MOV.L   @($1C,R14),R14   ; Load callback pointer
02223102  4E0B     JSR     @R14              ; Call indirect function
```

**Purpose**: Central context structure passed to most major functions. Contains all state needed for rendering operations.

---

### Structure 2: Transformation Matrix (R12-based)

**Size**: 64 bytes (0x40)
**Base Register**: R12
**Usage**: 4×4 transformation matrices
**Access Pattern**: Reads at 0x0C, 0x1C, 0x2C, 0x3C (16-byte stride)

**Definition**:
```c
struct Matrix4x4 {
    // Fixed-point matrix (16.16 format likely)
    int32_t row0[4];    // +0x00 to +0x0F
    int32_t row1[4];    // +0x10 to +0x1F (accessed at 0x1C)
    int32_t row2[4];    // +0x20 to +0x2F (accessed at 0x2C)
    int32_t row3[4];    // +0x30 to +0x3F (accessed at 0x3C)
};  // Total: 64 bytes (4×4 longs)
```

**Sample Accesses**:
```assembly
022231EA  50C3     MOV.L   @($C,R12),R0     ; Read matrix element
022231EC  51C7     MOV.L   @($1C,R12),R1    ; Read from second row
022231EE  52CB     MOV.L   @($2C,R12),R2    ; Read from third row
022231F0  53CF     MOV.L   @($3C,R12),R3    ; Read from fourth row
```

**Purpose**: Stores 4×4 transformation matrices for world/view/projection transforms.

**Notes**:
- Accessed during MAC.L sequences (matrix multiplication)
- Likely stored at 0xC000 0740 (based on PC-relative loads)
- Multiple matrices in memory for different transform stages

---

### Structure 3: Output/Vertex Buffer (R11-based)

**Size**: 52 bytes (0x34)
**Base Register**: R11
**Usage**: Transformed vertex output
**Access Pattern**: Sequential writes at 0x04, 0x08, 0x0C, 0x10

**Definition**:
```c
struct TransformedVertex {
    uint32_t header;        // +0x00
    int32_t  x;             // +0x04 - Screen X coordinate
    int32_t  y;             // +0x08 - Screen Y coordinate
    int32_t  z;             // +0x0C - Depth/Z coordinate
    uint32_t w;             // +0x10 - W component (perspective)
    uint8_t  extra[36];     // +0x14 to +0x33 - Color, UV, flags?
};  // Total: 52 bytes
```

**Sample Accesses**:
```assembly
022231F2  1B01     MOV.L   R0,@($4,R11)     ; Write X coordinate
022231F4  1B12     MOV.L   R1,@($8,R11)     ; Write Y coordinate
022231F6  1B23     MOV.L   R2,@($C,R11)     ; Write Z coordinate
022231F8  1B34     MOV.L   R3,@($10,R11)    ; Write W coordinate
022231FA  7B14     ADD     #$14,R11          ; Advance to next vertex
```

**Purpose**: Output buffer for transformed vertices. Written by matrix multiplication routines, read by polygon processors.

---

### Structure 4: Input Vector Array (R6-based)

**Size**: 32 bytes (0x20)
**Base Register**: R6
**Usage**: Input vertices/vectors for transformation
**Access Pattern**: Reads at 0x00, 0x04, 0x0C, 0x10, 0x14, 0x1C

**Definition**:
```c
struct InputVertex {
    int32_t x;              // +0x00
    int32_t y;              // +0x04
    int32_t z;              // +0x08 (implied)
    int32_t w;              // +0x0C
    uint32_t field_0x10;    // +0x10
    uint32_t field_0x14;    // +0x14
    uint32_t extra[2];      // +0x18 to +0x1F
};  // Total: 32 bytes
```

**Sample Accesses**:
```assembly
022230D8  5463     MOV.L   @($C,R6),R4      ; Read component
02223134  1630     MOV.L   R3,@($0,R6)      ; Write result X
02223136  1674     MOV.L   R7,@($10,R6)     ; Write to +0x10
0222313A  1605     MOV.L   R0,@($14,R6)     ; Write to +0x14
```

---

### Structure 5: Polygon Descriptor (processed at 0x02224060)

**Size**: 20 bytes (0x14)
**Base Register**: R14 (in loop context)
**Usage**: Polygon rendering parameters
**Processing**: Loop advances by 0x14 per iteration

**Definition**:
```c
struct PolygonDescriptor {
    uint8_t  active_flag;   // +0x00 - 0=skip, 1=render
    uint8_t  poly_type;     // +0x01 - Triangle/quad/etc
    uint8_t  flags;         // +0x02
    uint8_t  reserved;      // +0x03
    uint16_t vertex_idx[4]; // +0x04 to +0x0B - Vertex indices
    uint32_t color;         // +0x0C - RGB color/palette
    uint32_t texture;       // +0x10 - Texture ID or UV data
};  // Total: 20 bytes
```

**Processing Loop**:
```assembly
02224062  85E0     MOV.B   R0,@($0,R5)      ; Check active_flag
02224064  8800     CMP/EQ  #$00,R0          ; Is it zero?
02224066  8907     BT      $02224078        ; Skip if inactive
...
02224078  4710     DT      R7                ; Decrement polygon count
0222407A  8FF2     BF/S    $02224062         ; Loop
0222407C  7E14     ADD     #$14,R14          ; Next polygon (+20 bytes)
```

---

## Secondary Structures

### Structure 6: Hardware Register Block (R0/R1-based)

**Size**: 16 bytes
**Usage**: VDP/hardware register access
**Access Pattern**: Byte writes at consecutive offsets

**Definition**:
```c
struct HardwareRegs {
    uint8_t reg_0x00;
    uint8_t reg_0x01;
    uint8_t reg_0x02;
    uint8_t reg_0x03;
    uint8_t reg_0x04;
    uint8_t reg_0x05;
    uint8_t reg_0x06;
    uint8_t reg_0x07;
    uint8_t reg_0x08;
    uint8_t reg_0x09;
    uint8_t reg_0x0A;
    uint8_t reg_0x0B;
    uint8_t reg_0x0C;
    uint8_t reg_0x0D;
    uint8_t reg_0x0E;
    uint8_t reg_0x0F;
};  // Total: 16 bytes
```

---

### Structure 7: Work Buffer (R5-based)

**Size**: 28 bytes (0x1C)
**Base Register**: R5
**Usage**: Temporary work space for calculations

**Access Pattern**: Byte writes at 0x00, 0x01, 0x03, 0x07, 0x08, 0x09

---

### Structure 8: Secondary Matrix (R8-based)

**Size**: 52 bytes (0x34)
**Usage**: Alternative matrix storage or large data block
**Access Pattern**: Longword accesses at 0x00, 0x04, 0x08, 0x0C, 0x30

---

## Memory Layout in SDRAM

### Estimated SDRAM Usage (0x22000000 base)

```
Address Range          Size    Purpose
═══════════════════════════════════════════════════════════
0x22000000-0x22001FFF  8KB     Stack Space
0x22002000-0x22003FFF  8KB     Rendering Context Array
0x22004000-0x2200BFFF  32KB    Transformation Matrices
0x2200C000-0x2201BFFF  64KB    Vertex Buffers
                                  - Input vertices
                                  - Transformed vertices
0x2201C000-0x22023FFF  32KB    Polygon Descriptor Array
0x22024000-0x2202FFFF  48KB    Texture Cache
0x22030000-0x2203FFFF  64KB    Work Buffers & Misc
═══════════════════════════════════════════════════════════
Total: 256KB SDRAM
```

---

## Loop Structures and Array Processing

### Loop Type 1: Small Stride (12 bytes)

**Example**: Loop 5 at 0x022232E2
```assembly
022232DE  6106     MOV.L   @R0+,R1          ; Read element
022232E0  2D12     MOV.L   R1,@R13          ; Write to dest
022232E2  4710     DT      R7                ; Decrement counter
022232E4  8FFB     BF/S    $022232DE        ; Loop if not zero
022232E6  7D0C     ADD     #$0C,R13          ; Advance +12 bytes
```

**Purpose**: Processing 3D vectors (X, Y, Z components = 3 longs = 12 bytes)
**Elements**: Likely 14 vectors (0x0E counter value)

---

### Loop Type 2: Large Stride (64 bytes)

**Example**: Loop 6 at 0x02223300
```assembly
022232F2  811E     MOV.B   R0,@($E,R1)      ; Write to register
022232F4  7140     ADD     #$40,R1           ; Advance +64 bytes
02223300  4710     DT      R7                ; Decrement counter
02223302  8FF6     BF/S    $022232F2        ; Loop
02223304  7140     ADD     #$40,R1           ; Advance (delay slot)
```

**Purpose**: Iterating over 4×4 matrices (64 bytes each)
**Elements**: Multiple matrices in array

---

### Loop Type 3: Polygon Processing (20 bytes)

**Example**: Loop at 0x02224078
```assembly
02224062  85E0     MOV.B   R0,@($0,R5)      ; Access polygon
...
02224078  4710     DT      R7                ; Decrement polygon count
0222407A  8FF2     BF/S    $02224062        ; Loop
0222407C  7E14     ADD     #$14,R14          ; Next polygon +20 bytes
```

**Purpose**: Process polygon descriptor array
**Throughput**: ~50-60 cycles per polygon

---

## Fixed-Point Format

### Standard Fixed-Point: 16.16

Most calculations use **16.16 fixed-point** format:
- Upper 16 bits: Integer part
- Lower 16 bits: Fractional part
- Range: -32768.0 to +32767.9999

**Evidence**: XTRCT instruction extracts middle 32 bits from 64-bit MAC result
```assembly
000A     STS     MACH,R0        ; High 32 bits of 64-bit result
011A     STS     MACL,R1        ; Low 32 bits
210D     XTRCT   R0,R1          ; Extract bits [31:16] from MACH, [47:32] from MACL
                                ; Result: [47:16] = middle 32 bits
```

This gives 16.16 fixed-point output from multiplying two 16.16 values:
- (16.16) × (16.16) = (32.32) in 64 bits
- Extract middle 32 bits = (16.16) result

---

## Structure Sizes Summary

| Structure                | Size   | Register | Purpose                      |
|--------------------------|--------|----------|------------------------------|
| Rendering Context        | 56 B   | R14      | Main state & pointers        |
| Transform Matrix 4×4     | 64 B   | R12      | Transformation matrices      |
| Transformed Vertex       | 52 B   | R11      | Output vertex buffer         |
| Input Vertex             | 32 B   | R6       | Input vertex data            |
| Polygon Descriptor       | 20 B   | R14      | Polygon params               |
| Hardware Registers       | 16 B   | R0/R1    | VDP register block           |
| Work Buffer              | 28 B   | R5       | Temporary calculations       |
| Secondary Matrix         | 52 B   | R8       | Alt matrix/data block        |

---

## Address Constants

### PC-Relative Loads (Frequent)

**SDRAM Base**:
```assembly
D407  MOV.L   @($02223118,PC),R4    ; Load 0xC0000760
D507  MOV.L   @($0222311C,PC),R5    ; Load 0xC0000770
```

**Common Addresses**:
- 0xC0000000 - Likely SDRAM base (maps to 0x22000000?)
- 0xC0000740 - Matrix storage area
- 0xC0000760 - Vector buffer
- 0xC0000770 - Another buffer

**Note**: 0xC0000000 is in the cache region, suggesting these are SDRAM addresses accessed with caching enabled.

---

## Alignment Requirements

All structures are naturally aligned:
- Byte accesses: Any address
- Word accesses (16-bit): Even addresses only
- Longword accesses (32-bit): 4-byte aligned

**Evidence**: No alignment fixup code observed, all accesses use proper alignment.

---

## Summary

The 3D engine uses well-structured data layouts optimized for SH2 architecture:

**Strengths**:
- Consistent structure sizes
- Cache-friendly access patterns
- Efficient fixed-point representation
- Proper alignment throughout

**Optimization Opportunities**:
- Some structures could be packed tighter
- Array-of-structures could become structure-of-arrays for better vectorization
- Prefetching could reduce cache misses

---

## References

- [SH2_3D_PIPELINE_ARCHITECTURE.md](SH2_3D_PIPELINE_ARCHITECTURE.md) - Pipeline overview
- [SH2_3D_FUNCTION_REFERENCE.md](SH2_3D_FUNCTION_REFERENCE.md) - Functions using these structures
- [OPTIMIZATION_OPPORTUNITIES.md](OPTIMIZATION_OPPORTUNITIES.md) - Structure-related optimizations
