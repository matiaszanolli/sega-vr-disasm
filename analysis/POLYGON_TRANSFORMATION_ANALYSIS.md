# Polygon Transformation Analysis

**Virtua Racing Deluxe - 32X 3D Pipeline Deep Dive**
**Date:** 2026-01-22
**Status:** Foundation Review Complete

---

## Executive Summary

This document synthesizes findings from hardware documentation and code analysis to provide a comprehensive understanding of the polygon transformation pipeline. The goal is to identify parallelizable work that can be offloaded to the Slave SH2, which is currently **99.97% idle**.

**Key Finding:** The 3D engine is well-structured with clear separation between vertex transformation, polygon processing, and rasterization. Multiple opportunities exist for parallel execution.

---

## 1. Hardware Foundation

### 1.1 SH2 CPU Characteristics

| Property | Value | Impact |
|----------|-------|--------|
| Clock Speed | 23 MHz | 383,000 cycles/frame at 60 FPS |
| Registers | 16 GP (R0-R15) | Limited register pressure |
| Cache | 4KB, 4-way associative | 16-byte cache lines |
| MAC Unit | 32×32→64 bit multiply-accumulate | Critical for transforms |
| Pipeline | 5-stage | Branch penalties 2-3 cycles |

### 1.2 Memory Architecture

```
SH2 Address Space (relevant regions):
├── $00004000 / $20004000  System registers (cached / cache-through)
├── $00004100 / $20004100  VDP registers (cached / cache-through)
├── $02000000-$023FFFFF / $22000000-$223FFFFF  Cartridge ROM
├── $04000000 / $24000000  Frame buffer
└── $06000000-$0603FFFF / $26000000-$2603FFFF  SDRAM
```

**Critical Constraint:** system/VDP registers should use the cache-through `$20004000` /
`$20004100` regions. A `$22xxxxxx` address is cartridge ROM, not generic shared memory.

### 1.3 Frame Buffer FIFO

The VDP has a 4-word write FIFO for frame buffer access:
- First 3 writes: 3 cycles each
- 4th write: 5 cycles (triggers flush)
- **Burst of 4 consecutive writes: 14 cycles = 3.5 cycles/word average**

This is only beneficial if 4 writes happen consecutively (no intervening code).

---

## 2. 3D Engine Overview

### 2.1 Pipeline Stages

```
┌──────────────────────────────────────────────────────────────────────────┐
│ 68000 (12.5 MHz)              │ SH2 Master (23 MHz)                      │
├───────────────────────────────┼──────────────────────────────────────────┤
│                               │                                          │
│ 1. Game Logic                 │                                          │
│    ├─ Physics                 │                                          │
│    ├─ Object positions        │                                          │
│    └─ Camera calculation      │                                          │
│                               │                                          │
│ 2. Command Preparation        │                                          │
│    └─ Write to COMM registers ───> 3. Command Receive                    │
│                               │    └─ Parse display list                 │
│                               │                                          │
│ [BLOCKING WAIT] <───────────────── 4. Vertex Transform (main_coordinator_short-012)   │
│                               │    ├─ Matrix setup                       │
│                               │    ├─ MAC.L multiply sequences           │
│                               │    └─ Fixed-point extraction (XTRCT)     │
│                               │                                          │
│                               │ 5. Polygon Processing (coord_transform-023)     │
│                               │    ├─ Backface culling                   │
│                               │    ├─ Clipping                           │
│                               │    └─ Subdivision (vertex_helper_short recursive)   │
│                               │                                          │
│                               │ 6. Rasterization (func_060-065)          │
│                               │    ├─ Span generation                    │
│                               │    ├─ Depth testing                      │
│                               │    └─ Pixel writing (FB FIFO)            │
│                               │                                          │
│ 7. Response received <─────────── Response via COMM4                     │
│                               │                                          │
└───────────────────────────────┴──────────────────────────────────────────┘
```

### 2.2 Code Regions

| ROM Offset | SH2 Address | Size | Purpose |
|------------|-------------|------|---------|
| $020500-$020650 | $02020500 | 336 B | Master init & main loop |
| $020650-$020750 | $02020650 | 256 B | Slave init & **IDLE LOOP** |
| $023000-$024200 | $02223000 | 4.5 KB | 3D engine (109 functions) |
| $024200-$025B76 | $02024200 | 6.3 KB | Additional SH2 rendering |

### 2.3 Function Distribution

```
109 Functions Total:
├── 74 Entry Points (called from outside region)
├── 31 Coordinators (call other functions)
└── 78 Leaf Functions (do actual work)
```

---

## 3. Data Structures

### 3.1 Rendering Context (R14-based, 56 bytes)

```c
struct RenderingContext {
    uint32_t field_0x00;           // +0x00
    uint32_t field_0x04;           // +0x04 - Initialization
    uint32_t field_0x08;           // +0x08 - Counter/state
    uint32_t field_0x0C;           // +0x0C
    uint32_t field_0x10;           // +0x10 - Matrix ops
    uint32_t field_0x14;           // +0x14 - Address/pointer
    uint32_t field_0x18;           // +0x18 - Transforms
    void*    callback;             // +0x1C - Function pointer (JSR @R14)
    void*    buffer_ptr;           // +0x20 - SDRAM buffer
    void*    output_ptr;           // +0x24 - Output buffer
    void*    work_ptr1;            // +0x28 - Working memory
    void*    work_ptr2;            // +0x2C - Working memory
    uint32_t field_0x30;           // +0x30
    uint32_t field_0x34;           // +0x34
};  // Total: 56 bytes - accessed 87 times (most frequent)
```

### 3.2 Transformation Matrix (R12-based, 64 bytes)

```c
struct Matrix4x4 {
    // Fixed-point 16.16 format
    int32_t row0[4];    // +0x00 to +0x0F
    int32_t row1[4];    // +0x10 to +0x1F
    int32_t row2[4];    // +0x20 to +0x2F
    int32_t row3[4];    // +0x30 to +0x3F
};  // Total: 64 bytes (4 cache lines)
```

### 3.3 Vertex Structures

**Input Vertex (R6-based, 32 bytes):**
```c
struct InputVertex {
    int32_t x;              // +0x00
    int32_t y;              // +0x04
    int32_t z;              // +0x08
    int32_t w;              // +0x0C
    uint32_t field_0x10;    // +0x10
    uint32_t field_0x14;    // +0x14
    uint32_t extra[2];      // +0x18 to +0x1F
};
```

**Transformed Vertex (R11-based, 52 bytes):**
```c
struct TransformedVertex {
    uint32_t header;        // +0x00
    int32_t  x;             // +0x04 - Screen X
    int32_t  y;             // +0x08 - Screen Y
    int32_t  z;             // +0x0C - Depth
    uint32_t w;             // +0x10 - W (perspective)
    uint8_t  extra[36];     // +0x14 to +0x33 - Color, UV, flags
};
```

### 3.4 Polygon Descriptor (20 bytes)

```c
struct PolygonDescriptor {
    uint8_t  active_flag;   // +0x00 - 0=skip, 1=render
    uint8_t  poly_type;     // +0x01 - Triangle/quad/etc
    uint8_t  flags;         // +0x02
    uint8_t  reserved;      // +0x03
    uint16_t vertex_idx[4]; // +0x04 to +0x0B - Vertex indices
    uint32_t color;         // +0x0C - RGB color/palette
    uint32_t texture;       // +0x10 - Texture ID or UV
};
```

---

## 4. Vertex Transformation Pipeline

### 4.1 Matrix Multiplication (matrix_multiply, alt_matrix_multiply)

**Location:** 0x02223114 (98 bytes), 0x022231A2 (66 bytes)

These are the core MAC.L-based matrix multiply functions.

**Typical Sequence:**
```asm
; Transform X component
MAC.L   @R4+,@R5+     ; M00 * Vx → accumulate
MAC.L   @R4+,@R5+     ; M01 * Vy → accumulate
MAC.L   @R4+,@R5+     ; M02 * Vz → accumulate
ADD     #$F4,R5       ; Reset vector pointer (-12 bytes)
MOV.L   @R4+,R8       ; Load translation Tx
STS     MACH,R0       ; Get high 32 bits of 64-bit result
STS     MACL,R1       ; Get low 32 bits
XTRCT   R0,R1         ; Extract middle 32 bits = 16.16 result
ADD     R8,R1         ; Add translation: X' = M·V + T
```

**Fixed-Point Math:**
- Input: 16.16 fixed-point (16 integer bits, 16 fractional)
- (16.16) × (16.16) = (32.32) in 64-bit accumulator
- XTRCT extracts bits [47:16] = (16.16) result
- Range: -32768.0 to +32767.9999

**Cycle Count:**
- MAC.L: 2-3 cycles each
- 3 MAC.L per component = 6-9 cycles
- STS + XTRCT + ADD: ~5 cycles
- **Per vertex component: ~11-14 cycles**
- **Per vertex (X,Y,Z): ~33-42 cycles**

### 4.2 Coordinator Functions

**main_coordinator_short (0x0222301C, 74 bytes) - Main Coordinator:**
```
main_coordinator_short
├── transform_loop (matrix setup)
│   ├── matrix_multiply (MAC.L matrix multiply)
│   └── JSR @R14 (indirect callback)
├── alt_transform_loop (alt matrix setup)
│   ├── alt_matrix_multiply (MAC.L matrix multiply variant)
│   └── JSR @R14 (indirect callback)
├── display_list_4elem (result processor)
└── display_list_3elem (result processor variant)
```

**Estimated Calls Per Frame:**
- ~500 vertices × transform = 500 matrix_multiply/008 calls
- At 35 cycles each = 17,500 cycles for vertex transforms
- **4.6% of frame budget**

### 4.3 Indirect Call Pattern (JSR @R14)

Nine functions use `JSR @R14` for runtime dispatch:

```asm
MOV.L   @($1C,R14),R14   ; Load callback from context+0x1C
JSR     @R14             ; Call indirect (5-8 cycles)
MOV.W   @R13+,R0         ; Delay slot: load parameter
```

**Purpose:** Allows different vertex processing based on:
- Polygon type (triangle vs quad)
- Rendering mode (textured vs flat)
- LOD (Level of Detail)

**Overhead:** 5-8 cycles vs 2-4 for direct BSR
**Optimization:** Could use direct calls if callback is predictable

---

## 5. Polygon Processing Pipeline

### 5.1 Hotspot: coord_transform (0x0222335A)

**Size:** 44 bytes (~22 instructions)
**Called:** 4 times per polygon
**Type:** Leaf function (no outgoing calls)

**Call Sites:**
- quad_helper (1×)
- quad_batch_short (2×)
- quad_batch_alt_short (1×)

**Overhead Analysis:**
```
Per call: BSR (2) + RTS (2) + delay slots (2) = 6 cycles
4 calls per polygon × 6 cycles = 24 cycles overhead
800 polygons/frame × 24 cycles = 19,200 cycles/frame
= 5% of frame budget
```

**Likely Purpose:** Coordinate transformation or clipping utility (needs disassembly)

**Optimization Potential:** Inline at all 4 call sites
- Trade 176 bytes for 5% speedup
- Eliminate branch misprediction

### 5.2 Recursive Subdivision: vertex_helper_short (0x02223468)

**Size:** 86 bytes
**Called:** 3 times (including self-recursion)
**Pattern:** `vertex_helper_short → vertex_helper_short → frustum_cull_short`

**Likely Purpose:**
- Polygon subdivision for large polygons
- Binary space partitioning
- LOD-based simplification

**Constraint:** Recursive structure limits optimization

### 5.3 Polygon Processing Loop

From code at 0x02224060:

```asm
.loop:
    MOV.B   @($0,R14),R0     ; Read active_flag
    CMP/EQ  #$00,R0          ; Is polygon active?
    BT      .skip            ; Skip if inactive
    ; ... process polygon ...
.skip:
    DT      R7               ; Decrement polygon count
    BF/S    .loop            ; Loop if not zero
    ADD     #$14,R14         ; Next polygon (+20 bytes)
```

**Throughput:** ~50-60 cycles per polygon iteration

---

## 6. Rasterization Pipeline

### 6.1 Hotspot: unrolled_data_copy (0x02223F2C) - UNTOUCHABLE

**Size:** 150 bytes (75 instructions)
**Called:** 4 times per polygon batch
**Structure:** NO RTS - falls through to next code!

**What It Does:**
```asm
unrolled_data_copy:
    ; Prologue
    SHLL8   R0              ; R0 *= 256
    SHLR    R0              ; R0 /= 2 → R0 *= 128
    ADD     R10,R0          ; R0 = table_base + (index * 128)
    MOV     R9,R1           ; R1 = framebuffer_dest

    ; 14 iterations (unrolled)
    MOV.L   @R0+,R2         ; Read longword 1
    MOV.L   R2,@($0,R1)     ; Write to dest+0
    MOV.L   @R0+,R2         ; Read longword 2
    MOV.L   R2,@($4,R1)     ; Write to dest+4
    ADD     R13,R1          ; Advance by stride
    ; ... repeats 14 times ...

    ; NO EPILOGUE - falls through!
```

**Copies:** 56 bytes per call (28 longwords) from lookup table to frame buffer

**WHY IT'S UNTOUCHABLE:**
1. No RTS = fall-through design
2. Timing-critical (conditionally called based on R0 value)
3. State-dependent (R9, R10, R13 from context)
4. Every instruction matters (no slack)

**All modification attempts crashed:**
- FIFO batching: Changed semantics
- Trampoline: Broke timing
- NOP substitution: Broke R1 advancement

**Verdict:** Abandon unrolled_data_copy optimization. Focus on architectural improvements.

### 6.2 Similar Rasterizer at 0x023ED0

**Size:** Different stride (R0 * 64 vs R0 * 128)
**Iterations:** 8 (vs 14)
**Has RTS:** Yes - proper subroutine
**Purpose:** Smaller element rendering

---

## 7. Identified Parallelization Opportunities

### 7.1 Work That Can Be Offloaded to Slave

| Work Item | Current Location | Cycles/Frame | Parallelizable? |
|-----------|------------------|--------------|-----------------|
| Vertex Transform | Master only | 17,500 | ✅ YES - embarrassingly parallel |
| Backface Culling | Master only | ~5,000 | ✅ YES - per-polygon independent |
| Polygon Clipping | Master only | ~10,000 | ✅ YES - per-polygon independent |
| Subdivision | Master only | ~8,000 | ⚠️ MAYBE - recursive dependencies |
| Rasterization | Master only | ~100,000 | ✅ YES - scanline independent |

### 7.2 Proposed Work Distribution

**Phase 1: Vertex Transform Split**
```
Master SH2:
  1. Set up matrices (once per frame)
  2. Transform vertices 0-249
  3. Wait for Slave completion
  4. Proceed with polygon processing

Slave SH2:
  1. Wait for GO signal (COMM6 = 0x0012)
  2. Read vertex range from shared SDRAM
  3. Transform vertices 250-499
  4. Write DONE signal (COMM4++)
  5. Return to wait loop
```

**Expected Gain:** 50% of vertex transform time = ~8,750 cycles = 2.3%

**Phase 2: Polygon Processing Split**
```
Master SH2:
  1. Cull and clip polygons 0-399
  2. Write visible polygon list to SDRAM
  3. Rasterize back half of screen

Slave SH2:
  1. Cull and clip polygons 400-799
  2. Write visible polygon list to SDRAM
  3. Rasterize front half of screen
```

**Expected Gain:** 50% of polygon/raster time = ~65,000 cycles = 17%

### 7.3 Synchronization Mechanism (Already Implemented!)

**Phase 11-13 delivered:**
- Slave hook at 0x06000596 (44 bytes)
- Handler at 0x02300027 (16 bytes)
- Signal: COMM6 = 0x0012 → Handler → COMM4++
- Verified working via baseline probe

**Signal Protocol:**
```
Frame N:
  Master: Write COMM6 = 0x0012 (at VBlank exit)
  Slave:  Hook detects signal
  Slave:  Calls handler
  Slave:  Handler does work (currently just increments COMM4)
  Slave:  Hook clears COMM6 = 0x0000
  Master: Reads COMM4 (incremented)
  Master: Reads COMM6 (cleared)
  → Protocol cycle complete
```

---

## 8. Constraints and Pitfalls

### 8.1 Hardware Bugs to Avoid

From docs/32x-technical-info.md (22 documented bugs):

| Bug | Description | Mitigation |
|-----|-------------|------------|
| #1 RV bit | VDP register read can corrupt | Always use cache-through |
| #2 Z80 access | Reading Z80 after write corrupts | Add wait cycles |
| #3 PWM restriction | Don't access cycle timer during PWM | Disable PWM first |
| #11 INT_CTRL | Don't write $00 after $80 | Write $FF instead |

### 8.2 Timing Constraints

- **Frame budget:** 16.67ms (60 FPS) or 383,000 SH2 cycles
- **Current usage:** ~20 FPS = ~50ms per frame
- **Bottleneck:** Blocking sync adds ~16ms wait per frame

### 8.3 Cache Coherency

When both CPUs access shared SDRAM:
- Use cache-through addresses ($06000000) for sync flags
- Or explicitly purge cache before sharing data
- COMM registers already cache-through ($20004000)

### 8.4 Code Modification Risks

**unrolled_data_copy taught us:**
- Fall-through functions CANNOT be modified
- Timing-sensitive code may break with any change
- Always check for RTS before assuming function boundaries

---

## 9. Recommended Next Steps

### Immediate (Low Risk)

1. **Measure baseline FPS accurately**
   - FPS counter at 0x22000100 already injected
   - Run for 60 seconds, calculate average

2. **Profile actual function call frequencies**
   - Instrument coord_transform, matrix_multiply, alt_matrix_multiply
   - Confirm theoretical cycle counts

### Short Term (Medium Risk)

3. **Expand Slave handler with real work**
   - Replace counter increment with vertex transform
   - Start with 10% of vertices as proof-of-concept

4. **Inline coord_transform at call sites**
   - 4 call sites, 44 bytes each = 176 bytes
   - Expected gain: 5%

### Medium Term (Higher Risk)

5. **Split polygon processing between CPUs**
   - Requires buffer management
   - Need to verify no state dependencies

6. **Optimize 68K→SH2 sync protocol**
   - Currently 16.5% of frame time in COMM polling
   - Consider interrupt-driven instead of polling

---

## 10. Summary

**What We Know:**
- 3D pipeline is well-structured with clear stages
- Vertex transform uses efficient MAC.L hardware
- Polygon processing has parallelizable work
- unrolled_data_copy is untouchable (fall-through design)
- Slave SH2 is 99.97% idle

**What We Can Do:**
- Offload vertex transforms to Slave (proven mechanism)
- Inline hot utility functions (coord_transform)
- Split polygon processing by index range
- Use frame buffer FIFO efficiently

**What We Should Avoid:**
- Modifying fall-through functions
- Touching timing-sensitive code without profiling
- Ignoring cache coherency for shared data
- Premature optimization without measurement

---

## References

- [32x-hardware-manual.md](../docs/32x-hardware-manual.md) - Hardware specs
- [32x-technical-info.md](../docs/32x-technical-info.md) - 22 hardware bugs
- [development-guide.md](../docs/development-guide.md) - Development guidance
- [ARCHITECTURAL_BOTTLENECK_ANALYSIS.md](ARCHITECTURAL_BOTTLENECK_ANALYSIS.md) - Root cause
- [SH2_3D_PIPELINE_ARCHITECTURE.md](sh2-analysis/SH2_3D_PIPELINE_ARCHITECTURE.md) - Pipeline
- [SH2_3D_CALL_GRAPH.md](sh2-analysis/SH2_3D_CALL_GRAPH.md) - Function relationships
- [SH2_3D_ENGINE_DATA_STRUCTURES.md](sh2-analysis/SH2_3D_ENGINE_DATA_STRUCTURES.md) - Memory layouts
- [OPTIMIZATION_OPPORTUNITIES.md](optimization/OPTIMIZATION_OPPORTUNITIES.md) - Optimization catalog
- [unrolled_data_copy_FINAL_VERDICT.md](optimization/unrolled_data_copy_FINAL_VERDICT.md) - Why unrolled_data_copy is untouchable
- [PHASE13_RESULTS.md](../PHASE13_RESULTS.md) - Slave sync validation

---

**Document Status:** Foundation review complete. Ready for implementation planning.
**Date:** 2026-01-22
