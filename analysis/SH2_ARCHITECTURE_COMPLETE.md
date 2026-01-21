# SH2 Architecture - Complete Reference

**Virtua Racing Deluxe - Dual SH2 3D Engine**
**Analysis Status: COMPLETE**
**Last Updated**: January 2026

---

## Executive Summary

The Sega 32X features two Hitachi SH2 processors running at 23 MHz, responsible for all 3D rendering in Virtua Racing Deluxe. This document provides a complete reference for the SH2 code architecture, the rendering pipeline, and the Master/Slave work distribution.

### Key Statistics

| Metric | Value |
|--------|-------|
| Total SH2 Functions | 109 |
| Named Functions | 107 |
| Leaf Functions | 78 |
| Coordinator Functions | 31 |
| Hotspot Functions | 3 (func_016, func_065, func_020) |
| 3D Engine Size | ~8 KB |
| Frame Budget | 383,000 cycles (23 MHz @ 60 FPS) |

### Current State

| Component | Status |
|-----------|--------|
| Master SH2 | **ACTIVE** - Full 3D rendering pipeline |
| Slave SH2 | **STUB** - Basic work loop, no actual rendering |
| Parallelization | **NOT IMPLEMENTED** - All work done by Master |

---

## 1. Rendering Pipeline Overview

```
┌──────────────────────────────────────────────────────────────────────┐
│                    VR DELUXE 3D RENDERING PIPELINE                    │
└──────────────────────────────────────────────────────────────────────┘

 Stage 1: INITIALIZATION
   ├─ Hardware Setup (0x02224084)
   ├─ VDP Configuration
   └─ Frame Buffer Initialization

 Stage 2: MODEL DATA LOADING
   ├─ Decompress/Unpack Data (0x02224000)
   └─ Load to SDRAM Buffers

 Stage 3: VERTEX TRANSFORMATION
   ├─ Matrix Operations (MAC.L sequences)
   ├─ World → Camera Space
   └─ Camera → Screen Space

 Stage 4: POLYGON PROCESSING (0x02224060)
   ├─ Polygon Loop (20-byte structures)
   ├─ Backface Culling
   ├─ Clipping
   └─ Sorting

 Stage 5: RASTERIZATION
   ├─ Scan Conversion
   ├─ Texture Mapping
   └─ Frame Buffer Writes

 Stage 6: DISPLAY
   └─ VDP Frame Swap
```

### Cycle Distribution (per frame)

| Stage | Estimated Cycles | % of Frame |
|-------|-----------------|------------|
| Hardware Init | ~500 | 0.1% |
| Data Unpacking | ~10,000 | 2.6% |
| Vertex Transform | ~50,000 | 13% |
| Polygon Processing | ~80,000 | 21% |
| **Rasterization** | **~200,000** | **52%** |
| Overhead/Sync | ~42,500 | 11% |

**Bottleneck**: Rasterization dominates at 52% of frame time.

---

## 2. Key Entry Points

### Master SH2 Entry

| Purpose | Address | ROM Offset | Notes |
|---------|---------|------------|-------|
| Boot Vector | $06000288 | 0x288 | Read from ROM 0x3E4 |
| Main Sync | $020203D8 | 0x0203D8 | Coordination entry |
| 3D Engine | $0222301C | 0x22301C | Display list processor |

### Slave SH2 Entry

**⚠️ PicoDrive Emulator Boot Failure (2026-01-20)**

The following describes the Slave SH2 code structure based on static analysis. However, debugger measurements reveal this code is **NEVER executed in PicoDrive**.

**Why**: PicoDrive's `sh2_reset()` reads reset vectors from ROM 0x0 (68K vectors) instead of 32X header (ROM 0x3C0+), causing Slave to execute 68K garbage code at ROM 0x060A instead.

**Status**:
- ✅ Code exists and appears correct
- ❌ Never executed in PicoDrive emulator
- ❓ Unknown if real 32X hardware boots correctly

**See**: [SLAVE_BOOT_FAILURE_ROOT_CAUSE.md](../SLAVE_BOOT_FAILURE_ROOT_CAUSE.md)

| Purpose | Address | Notes |
|---------|---------|-------|
| Main Loop | $22000400 | SDRAM - waits for work (📋 static analysis) |
| Process Polygons | $22001000 | SDRAM - stub only (📋 static analysis) |

---

## 3. Function Catalog

### 3.1 Top 10 Most Important Functions

| Rank | Function | Address | Size | Purpose | Calls |
|------|----------|---------|------|---------|-------|
| 1 | **func_016** | 0x0222335A | 44 B | Coord transform | 4 |
| 2 | **func_065** | 0x02223F2C | 150 B | Rasterization | 4 |
| 3 | func_020 | 0x02223468 | 86 B | Recursive polygon | 3 |
| 4 | func_006 | 0x02223114 | 98 B | MAC.L matrix mul | 1 |
| 5 | func_008 | 0x022231A2 | 66 B | MAC.L variant | 2 |
| 6 | func_001 | 0x0222301C | 74 B | Main coordinator | - |
| 7 | func_005 | 0x022230E6 | 46 B | Transform setup | 1 |
| 8 | func_018 | 0x022233A2 | 106 B | Polygon batch | - |
| 9 | func_023 | 0x02223500 | ~80 B | Frustum cull | 2 |
| 10 | func_009 | 0x022231E4 | 30 B | Result packing | 2 |

### 3.2 Function Categories

```
Total: 109 Functions
├── Entry Points: 74 (called externally)
├── Coordinators: 31 (call other functions)
├── Leaf Functions: 78 (no outgoing calls)
│   ├── MAC.L Functions: 8 (matrix math)
│   └── Hardware Functions: 12 (VDP/register)
└── Hotspots: 3 (called 3+ times)
```

### 3.3 Critical Call Paths

**Path 1: Vertex Transformation (HOT)**
```
func_001 (Main Coordinator)
  ├─> func_005 → func_006 (MAC.L) ⭐
  │             └─> JSR @R14 (callback)
  └─> func_007 → func_008 (MAC.L) ⭐
                └─> JSR @R14 (callback)
```
Frequency: ~30,000 calls/sec (500 vertices × 60 FPS)

**Path 2: Polygon Processing (HOT)**
```
func_018 (Polygon Coordinator)
  ├─> func_016 ⭐⭐⭐ (4× calls)
  └─> func_020 → func_023
              └─> func_020 (recursive)
```
Frequency: ~48,000 calls/sec (800 polygons × 60 FPS)

**Path 3: Rasterization (HOT)**
```
func_060 ─┐
func_061 ─┼─> func_065 ⭐⭐⭐ (4× calls each)
func_062 ─┤
func_063 ─┘
```
Frequency: Per pixel batch - CRITICAL BOTTLENECK

---

## 4. Master/Slave Division of Labor

### Current State (Original ROM)

```
┌───────────────────────────────────────────────────────────────────┐
│  CURRENT: MASTER DOES EVERYTHING                                   │
└───────────────────────────────────────────────────────────────────┘

  MASTER SH2 (23 MHz)                    SLAVE SH2 (23 MHz)
  ┌─────────────────────┐               ┌─────────────────────┐
  │ ✓ Vertex Transform  │               │                     │
  │ ✓ Matrix Operations │               │   ❌ IDLE LOOP      │
  │ ✓ Polygon Culling   │               │   (Waiting for      │
  │ ✓ Clipping          │               │    work that never  │
  │ ✓ Rasterization     │               │    arrives)         │
  │ ✓ Frame Buffer      │               │                     │
  │ ✓ VDP Control       │               │                     │
  └─────────────────────┘               └─────────────────────┘
          │                                      │
          ▼                                      ▼
     100% work                               0% work
```

**Consequence**: Second SH2 is completely wasted. This is a major contributor to the ~20 FPS limit.

### Planned Parallelization Strategy

```
┌───────────────────────────────────────────────────────────────────┐
│  PLANNED: POLYGON-BASED PARTITIONING                               │
└───────────────────────────────────────────────────────────────────┘

  MASTER SH2                             SLAVE SH2
  ┌─────────────────────┐               ┌─────────────────────┐
  │ ✓ All setup/init    │               │                     │
  │ ✓ Parse display list│               │                     │
  │ ✓ Build bounds index│  ──sync──>    │ ✓ Read bounds index │
  │                     │               │                     │
  │ ✓ Render polygons   │    PARALLEL   │ ✓ Render polygons   │
  │   X-max < 160       │ ◄─────────────│   X-max >= 160      │
  │   (LEFT HALF)       │               │   (RIGHT HALF)      │
  │                     │               │                     │
  │ ✓ Wait for Slave    │  <──sync──    │ ✓ Signal done       │
  │ ✓ Frame complete    │               │                     │
  └─────────────────────┘               └─────────────────────┘
          │                                      │
          ▼                                      ▼
       ~50% work                             ~50% work
```

**Expected Gain**: +20-30% performance improvement

### Synchronization Protocol

```
SDRAM Sync Buffer @ 0x22000400:
┌──────────────────────────────────────────────────────────────┐
│ Offset │ Field              │ Size  │ Purpose                │
├────────┼────────────────────┼───────┼────────────────────────┤
│ 0x00   │ MASTER_READY       │ 4 B   │ Work available flag    │
│ 0x04   │ SLAVE_READY        │ 4 B   │ Slave acknowledged     │
│ 0x08   │ MASTER_DONE        │ 4 B   │ Master finished        │
│ 0x0C   │ SLAVE_DONE         │ 4 B   │ Slave finished         │
│ 0x10   │ POLYGON_COUNT      │ 4 B   │ Total polygons         │
│ 0x14   │ SLAVE_START        │ 4 B   │ First polygon for Slave│
│ 0x18   │ SLAVE_END          │ 4 B   │ Last polygon for Slave │
│ 0x20   │ CONTEXT_PTR        │ 4 B   │ Rendering context      │
│ 0x24   │ DISPLAY_LIST       │ 4 B   │ Display list pointer   │
│ 0x28   │ FRAME_BUFFER       │ 4 B   │ Target frame buffer    │
│ 0x40   │ FRAME_COUNTER      │ 4 B   │ Debug frame count      │
└──────────────────────────────────────────────────────────────┘

Magic Values:
- READY_MAGIC = 0x52454459 ("REDY")
- WORK_MAGIC  = 0x574F524B ("WORK")
- DONE_MAGIC  = 0x444F4E45 ("DONE")
```

---

## 5. Memory Layout

### SH2 Address Space

```
┌─────────────────────────────────────────────────────────────────────┐
│ SH2 Address Space (both Master and Slave)                           │
├──────────────┬──────────────────────────────────────────────────────┤
│ $00000000    │ Boot ROM (internal, 4KB)                             │
├──────────────┼──────────────────────────────────────────────────────┤
│ $06000000    │ ROM (uncached) - Code execution                      │
│   $06000288  │   Master entry point                                 │
│   $0622301C  │   3D engine (display_list_processor)                 │
├──────────────┼──────────────────────────────────────────────────────┤
│ $20000000    │ ROM (cached) - Faster data access                    │
│   $20004020  │   COMM0 register (68K communication)                 │
│   $200040xx  │   VDP & system registers                             │
├──────────────┼──────────────────────────────────────────────────────┤
│ $22000000    │ SDRAM (256KB) - Working memory                       │
│   $22000400  │   Sync buffer (64 bytes)                             │
│   $22001000  │   Polygon bounds index (3.2KB)                       │
│   $22020000  │   Trace buffer (2KB, debug)                          │
│   $22030000  │   Transform matrices, vertex buffers                 │
├──────────────┼──────────────────────────────────────────────────────┤
│ $24000000    │ Frame Buffer 0 (128KB)                               │
│ $24020000    │ Frame Buffer 1 (128KB)                               │
└──────────────┴──────────────────────────────────────────────────────┘
```

### SDRAM Usage Map

```
$22000000 +────────────────────+
          │ Reserved           │  1KB
$22000400 +────────────────────+
          │ Sync Buffer        │  64 bytes
$22000440 +────────────────────+
          │ Reserved           │  ~3KB
$22001000 +────────────────────+
          │ Polygon Bounds     │  3.2KB (800 × 4 bytes)
          │ Index              │
$22001C80 +────────────────────+
          │ Reserved           │  ~114KB
$22020000 +────────────────────+
          │ Trace Buffer       │  2KB (debug)
$22020800 +────────────────────+
          │ Transform Matrices │  ~32KB
          │ Vertex Buffers     │  ~64KB
          │ Polygon Buffer     │  ~32KB
          │ Work Space         │  ~8KB
$2203FFFF +────────────────────+
          Total: 256KB SDRAM
```

---

## 6. Key Data Structures

### 6.1 Polygon Descriptor (20 bytes)

```c
struct PolygonDescriptor {
    uint8_t  active_flag;       // +0x00: 0=skip, 1=render
    uint8_t  poly_type;         // +0x01: Triangle/quad/etc
    uint8_t  flags;             // +0x02: Rendering flags
    uint8_t  reserved;          // +0x03
    uint16_t vertex_idx[4];     // +0x04-0x0B: Vertex indices
    uint32_t color;             // +0x0C: RGB color/palette
    uint32_t texture;           // +0x10: Texture ID or UV
};  // Total: 20 bytes (0x14)
```

### 6.2 Rendering Context (56 bytes)

```c
// Base: R14 register points here
struct RenderingContext {
    uint32_t callback_ptr;      // +0x00: Subroutine address
    uint32_t display_list_ptr;  // +0x04: Current display list
    uint32_t vertex_buffer_ptr; // +0x08: Output vertices
    uint32_t work_buffer_ptr;   // +0x0C: Temporary space
    uint32_t frame_buffer_ptr;  // +0x10: Target FB
    uint32_t depth_buffer_ptr;  // +0x14: Z-buffer
    uint32_t matrix_ptr;        // +0x18: Current transform
    uint32_t light_vector_ptr;  // +0x1C: Lighting direction
    uint32_t polygon_count;     // +0x20: Number of polygons
    uint32_t vertex_count;      // +0x24: Number of vertices
    uint32_t render_flags;      // +0x28: Mode flags
    uint32_t clip_planes;       // +0x2C: Near/far clip
    uint32_t screen_width;      // +0x30: Viewport width
    uint32_t screen_height;     // +0x34: Viewport height
};  // Total: 56 bytes
```

### 6.3 Transformation Matrix (64 bytes)

4×4 matrix in 16.16 fixed-point format:
```
        | M00  M01  M02  M03 |
Matrix =| M10  M11  M12  M13 |
        | M20  M21  M22  M23 |
        | M30  M31  M32  M33 |
```

---

## 7. Communication with 68K

### COMM Register Mapping

```
68K View          SH2 View        Direction       Purpose
────────────────────────────────────────────────────────────
$A15120 COMM0     $20004020       68K → Master    Command word
$A15122 COMM1     $20004022       68K → Master    Parameter 1
$A15124 COMM2     $20004024       68K → Slave     Command word
$A15126 COMM3     $20004026       68K → Slave     Parameter 1
$A15128 COMM4     $20004028       Master → 68K    Response
$A1512A COMM5     $2000402A       Master → 68K    Response data
$A1512C COMM6     $2000402C       Slave → 68K     Response
$A1512E COMM7     $2000402E       Slave → 68K     Response data
```

### Command Flow

```
68K                          Master SH2                    Slave SH2
 │                               │                             │
 │── COMM0 = $0001 ──────────>  │                             │
 │── COMM1 = display_list ────> │                             │
 │                               │── Parse display list        │
 │                               │── Distribute polygons ────> │
 │                               │                             │── Render
 │                               │<─ COMM6 = done ─────────────│
 │<─ COMM4 = done ──────────────│                             │
 │                               │                             │
```

---

## 8. Optimization Opportunities

### 8.1 Hotspot Functions (Immediate Targets)

| Function | Opportunity | Expected Gain |
|----------|-------------|---------------|
| func_016 | Inline at 4 call sites | 5% |
| func_065 | Loop unrolling, FIFO usage | 10% |
| func_020 | Replace recursion with iteration | 3% |

### 8.2 Structural Optimizations

| Optimization | Description | Expected Gain |
|--------------|-------------|---------------|
| **Slave Activation** | Actually use the second SH2 | 20-30% |
| Pipeline overlap | Start next frame while finishing current | 10% |
| FIFO utilization | Use DMA for bulk transfers | 5% |

### 8.3 Parallelization Phase Plan

1. **Phase 1**: Slave activation (2-3 days)
2. **Phase 2**: Sync protocol (3-4 days)
3. **Phase 3**: Polygon-based partitioning (10-12 days)
4. **Phase 4**: Pipeline overlap (4-5 days)

---

## 9. Slave Engine (Current State)

### sh2_slave_engine.asm

```assembly
slave_main_loop:
    mov.l sync_base_addr, r14
    mov.l ready_magic, r0
    mov.l r0, @(SLAVE_READY_OFFSET, r14)

.wait_for_work:
    mov.l @(MASTER_READY_OFFSET, r14), r0
    mov.l work_magic, r1
    cmp/eq r1, r0
    bt .work_available
    bra .wait_for_work       ; ← SPINS HERE FOREVER (no work dispatched)
    nop

.work_available:
    ; Load work parameters
    mov.l @(SLAVE_START_OFFSET, r14), r10
    mov.l @(SLAVE_END_OFFSET, r14), r11

    bsr slave_process_polygons
    nop

    mov.l done_magic, r0
    mov.l r0, @(SLAVE_DONE_OFFSET, r14)

    bra slave_main_loop
    nop

slave_process_polygons:
    ; STUB: Just counts polygons, doesn't render
    mov #0, r8
.polygon_loop:
    cmp/gt r11, r10
    bt .polygons_done
    add #1, r10
    add #1, r8
    bra .polygon_loop
    nop
.polygons_done:
    rts
    nop
```

**Status**: Loop infrastructure exists, but:
- Master never dispatches work (WORK_MAGIC never written)
- slave_process_polygons is a counting stub, not a renderer
- All rendering functions (slave_func_023, etc.) are stubs returning immediately

---

## 10. References

### Internal Documentation

| Document | Contents |
|----------|----------|
| [SH2_3D_PIPELINE_ARCHITECTURE.md](sh2-analysis/SH2_3D_PIPELINE_ARCHITECTURE.md) | Pipeline stages |
| [SH2_3D_CALL_GRAPH.md](sh2-analysis/SH2_3D_CALL_GRAPH.md) | Function relationships |
| [SH2_3D_FUNCTION_REFERENCE.md](sh2-analysis/SH2_3D_FUNCTION_REFERENCE.md) | All 109 functions |
| [SH2_PARALLELIZATION_STRATEGY.md](sh2-analysis/SH2_PARALLELIZATION_STRATEGY.md) | Implementation plan |
| [SH2_SYMBOL_MAP.md](../disasm/SH2_SYMBOL_MAP.md) | 107 named symbols |

### Disassembly Files

| File | Contents |
|------|----------|
| [sh2_3d_engine_annotated.asm](../disasm/sh2_3d_engine_annotated.asm) | Full 3D engine (~250KB) |
| [sh2_slave_engine.asm](../disasm/sh2_slave_engine.asm) | Slave stub code |
| [sh2_master_sync.asm](../disasm/sh2_master_sync.asm) | Master sync routines |

### Hardware Documentation

| Document | Contents |
|----------|----------|
| [32x-hardware-manual.md](../docs/32x-hardware-manual.md) | Memory map, VDP |
| [development-guide.md](../docs/development-guide.md) | CPU coordination |

---

## Summary

The SH2 3D engine in Virtua Racing Deluxe is a well-structured rendering pipeline with 109 functions across 8KB of code. The architecture is professional-grade for its era, using MAC.L multiply-accumulate for efficient matrix operations and proper calling conventions throughout.

**The major untapped opportunity is the idle Slave SH2**. The second processor sits in an infinite wait loop while the Master does 100% of the rendering work. Activating the Slave with polygon-based work distribution could yield 20-30% performance improvement.

**Next Steps**:
1. Implement work dispatch in Master's rendering loop
2. Replace Slave stubs with actual rendering functions
3. Test and validate on emulator and hardware
4. Measure performance gains

---

*Generated: January 2026*
*Status: Complete reference for SH2 deep dive*
