# SH2 3D Rendering Pipeline Architecture

**Virtua Racing Deluxe - SH2 3D Engine**
**ROM Region**: 0x23000-0x24000+ (several KB of highly optimized code)
**Analysis Date**: January 6, 2026
**Last Updated**: February 28, 2026 (all 92 function IDs integrated into build system)

---

## Executive Summary

The Virtua Racing Deluxe 3D engine consists of **109 functions** spanning 8KB of highly optimized SH2 assembly code. The engine implements a classic 3D rendering pipeline with vertex transformation, polygon processing, and hardware rasterization.

**Key Metrics:**
- Total Functions: 109
- **Fully Integrated**: All 92 function IDs (74 .inc groups + 12 expansion + 2 numbering gaps + 4 subsumed)
- Direct Calls (BSR): 98
- Indirect Calls (JSR): 20
- Leaf Functions: 78
- Memory Accesses Analyzed: 379

**Translation Status**: Complete assembly translations with ROM verification are available in `disasm/sh2/3d_engine/`. All translations use `.short` (16-bit raw opcodes) to guarantee byte-accurate builds.

---

## High-Level Pipeline Overview

```
┌─────────────────────────────────────────────────────────────┐
│                    3D RENDERING PIPELINE                     │
└─────────────────────────────────────────────────────────────┘

 1. INITIALIZATION
    ├─ Hardware Setup (0x02224084)
    ├─ VDP Configuration
    └─ Frame Buffer Initialization

 2. MODEL DATA LOADING
    ├─ Decompress/Unpack Data (0x02224000)
    └─ Load to SDRAM Buffers

 3. VERTEX TRANSFORMATION
    ├─ Matrix Operations (MAC.L sequences)
    ├─ World → Camera Space
    └─ Camera → Screen Space

 4. POLYGON PROCESSING (0x02224060)
    ├─ Polygon Loop (20-byte structures)
    ├─ Backface Culling
    ├─ Clipping
    └─ Sorting

 5. RASTERIZATION
    ├─ Scan Conversion
    ├─ Texture Mapping
    └─ Frame Buffer Writes

 6. DISPLAY
    └─ VDP Frame Swap
```

---

## Verified Function Mappings (from Translation Work)

The following function mappings have been **verified through complete disassembly translation** with byte-accurate ROM matching:

### Coordinate Transformation Pipeline

| Function | ROM Address | Size | Purpose |
|----------|-------------|------|---------|
| data_copy | 0x2300A-0x23023 | 26 B | Matrix/constant data copy (12 longwords to 0xC0000740) |
| main_coordinator_short | 0x23024-0x2306E | 74 B | Main coordinator / switch dispatcher with dual entry points |
| transform_loop | 0x230E8-0x2311F | 56 B | Matrix transform loop with indirect dispatch |
| matrix_multiply | 0x23120-0x23178 | 88 B | Core MAC.L matrix × vector multiplication (~45 cycles/vertex) |
| coord_transform | 0x23368-0x2338A | 34 B | Coordinate packing (HOTSPOT: 17% frame budget) |
| vertex_transform | 0x234C8-0x234ED | 38 B | Vertex transform loop (now offloaded to Slave SH2) |

### Visibility & Culling Pipeline

| Function | ROM Address | Size | Purpose |
|----------|-------------|------|---------|
| frustum_cull_short | 0x23508-0x235F5 | 238 B | **LARGEST** - Frustum culling / visibility dispatcher |
| screen_coords_short | 0x235F6-0x23633 | 62 B | Screen coordinate calculator (3D to 2D) |
| bounds_compare_short | (referenced) | - | Bounds comparison for visibility culling |

### Rendering & Rasterization Pipeline

| Function | ROM Address | Size | Purpose |
|----------|-------------|------|---------|
| render_quad_short | 0x236FA-0x2375B | 98 B | Quad rendering / edge walking |
| span_filler_short | 0x2375C-0x237D5 | 122 B | Span filler / edge interpolation (reciprocal table at 0x060048D0) |
| display_list_short | 0x2385E-0x238D7 | 122 B | Display list buffer setup (12-entry jump table) |

### VDP & Hardware Interface

| Function | ROM Address | Size | Purpose |
|----------|-------------|------|---------|
| func_014 | 0x23330-0x23341 | 18 B | VDP 6-byte copy utility |
| func_015 | 0x23342-0x23367 | 38 B | VDP 402-byte frame buffer transfer |

### Key Hardware Addresses (Verified)

| Address | Purpose |
|---------|---------|
| 0xC0000700 | SDRAM context base |
| 0xC0000740 | Edge buffer / matrix destination |
| 0xC0000780 | Secondary context pointer |
| 0xC00007C0 | VDP display list buffer A |
| 0xC00007E0 | VDP display list buffer B |
| 0x060048D0 | Reciprocal lookup table (for fast division) |

---

## Pipeline Stages in Detail

### Stage 1: Hardware Initialization

**Entry Point**: Function at 0x02224084
**Called By**: Function at 0x02224060

**Purpose**: Configure 32X VDP and frame buffer hardware for rendering.

**Operations**:
- Write to cache-through hardware registers (0x2000 4xxx range)
- Set up VDP modes and timing
- Initialize frame buffer pointers
- Configure DMA and FIFO settings

**Key Instructions**:
```assembly
02224084  DD1E     MOV.L   @($02224100,PC),R13  ; Load hardware base addr
02224086  D11F     MOV.L   @($02224104,PC),R1   ; Load second addr
02224088  84E2     MOV.B   R0,@($2,R4)          ; Write to register
0222408A  4008     SHLL2   R0                   ; Shift for offset calc
...
```

**Registers Modified**: R0, R1, R13
**Memory Regions Accessed**: VDP registers, SDRAM buffers

---

### Stage 2: Model Data Loading

**Entry Point**: Function at 0x02224000
**Data Format**: Compressed/packed vertex and polygon data

**Purpose**: Unpack compressed model data into SDRAM working buffers.

**Key Loop**:
```assembly
02224040  6086     MOV.L   @R8+,R0       ; Read source data
02224042  1100     MOV.L   R0,@($0,R1)   ; Write to buffer
02224044  6086     MOV.L   @R8+,R0       ; Read next
02224046  1101     MOV.L   R0,@($4,R1)   ; Write offset +4
02224048  4210     DT      R2             ; Decrement counter
0222404A  8FF9     BF/S    $02224040      ; Loop if not zero
0222404C  7108     ADD     #$08,R1        ; Advance destination (delay slot)
```

**Performance**:
- 8 bytes per iteration
- Uses auto-increment (@R8+) for efficient reads
- Nested loop for multiple blocks

---

### Stage 3: Vertex Transformation

**Functions**: matrix_multiply (0x02223120-0x02223178) and alt_matrix_multiply (0x022231A2-0x022231E2)

**Purpose**: Transform 3D vertices from model space to screen coordinates using matrix multiplication.

**Verified from Translation** (`disasm/sh2/3d_engine/matrix_multiply.asm`):

```assembly
; matrix_multiply: Core 3D transform using SH2 MAC (Multiply-Accumulate)
; Formula: V_out = M × V_in + T (with 16.16 fixed-point format)
; Performance: ~45 cycles per vertex

; 3x3 Matrix × Vector multiplication
02223120  054F     MAC.L   @R4+,@R5+      ; M[0][0] * V[0]
02223122  054F     MAC.L   @R4+,@R5+      ; M[0][1] * V[1]
02223124  054F     MAC.L   @R4+,@R5+      ; M[0][2] * V[2]
02223126  75F4     ADD     #$F4,R5        ; Reset R5 pointer (-12)
02223128  6846     MOV.L   @R4+,R8        ; Load translation offset
0222312A  74D0     ADD     #$D0,R4        ; Adjust R4 pointer
0222312C  000A     STS     MACH,R0        ; Get high 32 bits of result
0222312E  031A     STS     MACL,R3        ; Get low 32 bits into R3
02223130  230D     XTRCT   R0,R3          ; Extract middle 32 bits (16.16 fixed-point)
02223132  338C     ADD     R8,R3          ; Add translation
02223134  1630     MOV.L   R3,@($0,R6)    ; Store result X
```
**Repeat 3 times** for X, Y, Z components. alt_matrix_multiply uses similar MAC.L pattern.

**Key Features**:
- Uses SH2 MAC (Multiply-Accumulate) for efficiency
- Fixed-point arithmetic (no FPU on SH2) - **16.16 format confirmed**
- XTRCT extracts middle 32 bits from 64-bit MAC result
- R4 = matrix pointer, R5 = vector pointer
- 9 MAC.L operations total (3 per XYZ component)
- Uses DMULS.L (32×32→64) for screen coordinate scaling

**Transformation Sequence**:
1. Model coordinates → World coordinates (object transform matrix)
2. World coordinates → Camera coordinates (view matrix)
3. Camera coordinates → Clip coordinates (projection matrix)
4. Clip coordinates → Screen coordinates (viewport transform)

---

### Stage 4: Polygon Processing

**Entry Point**: Function at 0x02224060
**Loop Structure**: Processes array of 20-byte polygon descriptors

**Polygon Descriptor Structure** (0x14 = 20 bytes):
```c
struct PolygonDescriptor {
    uint8_t  active_flag;       // +0x00 - 0=skip, 1=render
    uint8_t  poly_type;         // +0x01 - Triangle/quad/etc
    uint8_t  flags;             // +0x02
    uint8_t  reserved;          // +0x03
    uint16_t vertex_idx[4];     // +0x04-0x0B - Vertex indices
    uint32_t color;             // +0x0C - RGB color/palette
    uint32_t texture;           // +0x10 - Texture ID or UV data
};  // Total: 20 bytes
```

**Processing Loop**:
```assembly
02224060  4F22     STS.L   PR,@-R15      ; Save return address
02224062  85E0     MOV.B   R0,@($0,R5)   ; Check polygon flag
02224064  8800     CMP/EQ  #$00,R0       ; Is it active?
02224066  8907     BT      $02224078     ; Skip if inactive
02224068  2FE6     MOV.L   R14,@-R15     ; Push R14 (context)
0222406A  2F76     MOV.L   R7,@-R15      ; Push R7 (counter)
0222406C  B00A     BSR     $02224084     ; Call hardware init
0222406E  0009     NOP                   ; Delay slot
02224070  B098     BSR     $022241A4     ; Call processing function
02224072  0009     NOP                   ; Delay slot
02224074  67F6     MOV.L   @R15+,R7      ; Pop R7
02224076  6EF6     MOV.L   @R15+,R14     ; Pop R14
02224078  4710     DT      R7             ; Decrement polygon count
0222407A  8FF2     BF/S    $02224062      ; Loop if more polygons
0222407C  7E14     ADD     #$14,R14       ; Advance to next (20 bytes)
0222407E  4F26     LDS.L   @R15+,PR      ; Restore return address
02224080  000B     RTS                   ; Return
```

**Operations Per Polygon**:
1. Check active flag
2. Call initialization function
3. Call transformation/rendering function
4. Advance to next 20-byte descriptor
5. Repeat for all polygons

**Performance**: ~50-60 cycles per polygon (overhead only)

---

### Stage 5: Rasterization

**Implementation**: Distributed across multiple leaf functions
**Hotspot Functions**: coord_transform (0x0222335A), unrolled_data_copy (0x02223F2C)

**Purpose**: Convert transformed polygons into pixels in frame buffer.

**Techniques**:
- Scan line rasterization
- Fixed-point interpolation for texture coordinates
- Z-buffer or painter's algorithm for depth sorting

---

## CPU Work Distribution

*Corrected March 2026 — Primary dispatch at $020460 is Master SH2, not Slave.*

### Master SH2 Responsibilities (0-36% utilization)
- COMM dispatch loop (primary at $020460, polls COMM0_HI → reads COMM0_LO → JSR handler)
- Block copy commands (cmd_22 longword copy, cmd_27 pixel ops)
- 3D pipeline coordination
- Frame synchronization via COMM0_HI busy flag

### Slave SH2 Responsibilities (78.3% utilization — THE BOTTLENECK)
- 3D rendering pipeline (Huffman renderer at $06004AD0, data at $0600C800)
- Polygon transformation and vertex processing
- Palette operations, scene commands (secondary dispatch at $020592 via COMM2)
- cmd_27 pixel operations (delegated from Master)

**Synchronization Points**:
- COMM registers ($20004020-$2000402E) — 16 bytes shared
- SDRAM (`$06000000-$0603FFFF`, cache-through `$26000000-$2603FFFF`) — shared between SH2s
- COMM0_HI = global busy flag, COMM0_LO = dispatch index
- COMM7 = Slave doorbell (must NOT receive game command bytes)

---

## Memory Map

### Cartridge ROM
- `0x02000000` - cached
- `0x22000000` - cache-through

### SDRAM (`0x06000000-$0603FFFF` cached / `0x26000000-$2603FFFF` cache-through)
```
0x26000000 +----------------+
           | Stack          |  ~8KB
           +----------------+
           | Transform      |  ~32KB
           | Matrices       |
           +----------------+
           | Vertex Buffer  |  ~64KB
           | (Transformed)  |
           +----------------+
           | Polygon Buffer |  ~32KB
           +----------------+
           | Work Space     |  Remainder
           +----------------+
0x2603FFFF
```

### Frame Buffer (Dual-Buffer, 128KB per buffer)
- Frame Buffer 0: 0x24000000 (primary rendering target)
- Frame Buffer 1: 0x24020000 (overwrite image, double-buffering)
- Each buffer: 128KB (Packed Pixel Mode with Line Table)

### Hardware Registers (Cache-Through, 0x20004000+)
- VDP registers: 0x20004100-0x2000410A
- System control: 0x20004000-0x2000403E
- PWM audio: 0x20004030-0x20004038

---

## Function Entry Points

**Primary Entry Points** (called from external/68K):
- data_copy (0x0222300A) - Possible initialization
- main_coordinator_short (0x0222301C) - Main loop entry?
- quad_batch_short (0x022233A2) - Rendering coordinator?

**Secondary Entry Points** (internal):
- 0x02224000 - Data unpacker
- 0x02224060 - Polygon processor
- 0x02224084 - Hardware initializer

---

## Critical Call Paths

### Hot Path 1: Polygon Processing Chain
```
quad_batch_short (0x022233A2)
  └─> coord_transform (0x0222335A) [called 4×]
      └─> vertex_helper_short (0x02223468)
          └─> frustum_cull_short (0x02223500)
```

### Hot Path 2: Transformation Chain
```
transform_loop (0x022230E6)
  └─> matrix_multiply (0x02223114) [MAC.L sequence]
      └─> JSR @R14 [indirect to per-polygon handler]
```

### Hot Path 3: Matrix Operations
```
display_entry (0x02223268)
  └─> alt_matrix_multiply (0x022231A2) [MAC.L heavy]
      └─> display_list_4elem (0x022231E4) [result processing]
```

---

## Performance Characteristics

### Cycle Estimates (per frame at 60 FPS = 16.67ms)

**Available Cycles**: 23 MHz × 16.67ms = ~383,000 cycles per frame

**Estimated Distribution**:
- Hardware Init: ~500 cycles (1×/frame)
- Data Unpacking: ~10,000 cycles
- Vertex Transform: ~50,000 cycles (500 vertices × 100 cycles)
- Polygon Processing: ~80,000 cycles (800 polygons × 100 cycles)
- Rasterization: ~200,000 cycles (majority of time)
- Overhead/Sync: ~42,500 cycles

**Bottleneck**: Rasterization (52% of frame time)

---

## Summary

The Virtua Racing Deluxe 3D engine represents professional-grade early-90s 3D programming:

**Strengths**:
- Efficient MAC.L usage for transforms
- Proper calling conventions and stack management
- Clever use of delay slots
- Fixed-point arithmetic throughout

**Optimization Opportunities**:
- Loop unrolling in hot paths
- Better register allocation (reduce spills)
- Parallel Master/Slave work distribution
- Frame buffer FIFO utilization

**Next Steps**:
- Complete rasterization analysis
- Map Master/Slave work division
- Identify cache thrashing patterns
- Profile actual cycle counts on hardware

---

## References

- [SH2_3D_ENGINE_DATA_STRUCTURES.md](SH2_3D_ENGINE_DATA_STRUCTURES.md) - Structure definitions (Polygon descriptor, matrices, buffers)
- [SH2_3D_FUNCTION_REFERENCE.md](SH2_3D_FUNCTION_REFERENCE.md) - Complete function list with addresses (matrix_multiply, alt_matrix_multiply MAC.L sequences)
- [SH2_3D_CALL_GRAPH.md](SH2_3D_CALL_GRAPH.md) - Function relationships and call chains
- [32X_FRAME_BUFFER_FORMAT.md](32X_FRAME_BUFFER_FORMAT.md) - Frame buffer architecture and VDP modes
- [OPTIMIZATION_OPPORTUNITIES.md](OPTIMIZATION_OPPORTUNITIES.md) - Performance improvements

### Translated Assembly Sources

Complete annotated translations with ROM verification are in `disasm/sh2/3d_engine/`:

| Category | Key Files |
|----------|-----------|
| **Transform** | `matrix_multiply.asm`, `coord_transform.asm`, `vertex_transform_orig.asm` |
| **Culling** | `frustum_cull_short_frustum_cull.asm`, `screen_coords_short_screen_coords.asm` |
| **Rendering** | `render_quad_short_render_quad.asm`, `span_filler_short_span_filler.asm`, `render_dispatch_short_render_dispatch.asm` |
| **Display** | `display_list_short.asm`, `display_list_short_059_display_engine.asm` |
| **VDP** | `vdp_copy_short.asm`, `rle_entry_alt1_short_plus_vdp_hw.asm` |
| **Coordination** | `main_coordinator_short_main_coordinator.asm`, `master_command_loop.asm`, `slave_command_dispatcher.asm` |
