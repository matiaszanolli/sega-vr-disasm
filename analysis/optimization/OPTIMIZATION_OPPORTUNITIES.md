# Optimization Opportunities

**Virtua Racing Deluxe - Performance Improvements**
**Analysis Date**: January 6, 2026

---

## Executive Summary

Analysis of the 3D engine reveals **8 major optimization opportunities** that could significantly improve rendering performance. The primary bottlenecks are in the rasterization hotspots (func_016, func_065), indirect function calls, and suboptimal loop structures.

**Estimated Performance Gains**: 15-30% frame time reduction possible with targeted optimizations.

---

## Optimization Priority Matrix

| ID | Opportunity | Impact | Effort | Priority |
|----|-------------|--------|--------|----------|
| 1  | Inline hotspot func_016 | High | Low | ⭐⭐⭐ Critical |
| 2  | Optimize func_065 pixel loop | High | Medium | ⭐⭐⭐ Critical |
| 3  | Remove indirect JSR @R14 calls | Medium | Medium | ⭐⭐ High |
| 4  | Unroll MAC.L matrix loops | Medium | Low | ⭐⭐ High |
| 5  | Master/Slave load balancing | High | High | ⭐⭐ High |
| 6  | Frame buffer FIFO utilization | Medium | Medium | ⭐ Medium |
| 7  | Cache-aware data layout | Low | Medium | ⭐ Medium |
| 8  | Reduce register spilling | Low | Low | ⭐ Low |

---

## CRITICAL #1: Inline Hotspot Function func_016

### Current Situation

**Location**: 0x0222335A
**Size**: 44 bytes (~22 instructions)
**Called**: 4 times per polygon
**Call Sites**: func_017, func_018 (2×), func_019

**Current Code Pattern**:
```assembly
; Caller (func_018)
func_018:
    ...
    BSR     func_016          ; 2 cycles (branch)
    NOP                       ; 1 cycle (delay slot)
    ; func_016 executes (~20-30 cycles)
    ; Returns here
    ...
```

**Overhead Per Call**:
- BSR instruction: 2 cycles
- RTS instruction: 2 cycles
- Delay slots: 2 cycles
- **Total overhead: 6 cycles per call**

**With 4 calls per polygon**:
- 6 cycles × 4 = 24 cycles overhead per polygon
- 800 polygons/frame = 19,200 cycles/frame wasted
- **5% of frame budget** (19,200 / 383,000)

### Optimization Strategy

**Inline func_016 at all 4 call sites**:

```assembly
; Before
    BSR     func_016          ; 2 cycles + function overhead
    NOP

; After (inline 44 bytes of func_016)
    ; [22 instructions from func_016 body]
    ; No BSR, no RTS = save 6 cycles
```

**Benefits**:
- Save 19,200 cycles/frame
- Eliminate branch misprediction risk
- Better instruction cache locality

**Tradeoffs**:
- Code size increase: 44 bytes × 4 = 176 bytes
- Worth it: 176 bytes for 5% performance gain

**Estimated Gain**: +5% frame rate (3 FPS at 60 FPS)

---

## CRITICAL #2: Optimize func_065 Pixel Loop

### Current Situation

**Location**: 0x02223F2C
**Size**: 150 bytes (~75 instructions)
**Called**: 4 times
**Purpose**: Likely pixel rasterization inner loop

**Problem**: Large function called frequently, suggesting unoptimized pixel operations.

### Hypothesized Current Approach

```assembly
; Pseudo-code of likely current implementation
func_065:
    for each pixel in span:
        read texture
        interpolate color
        z-test
        write pixel
    return
```

**Bottleneck**: Frame buffer writes may not use FIFO efficiently.

### Optimization Strategy 1: Use Frame Buffer FIFO

The 32X VDP has a **4-word (8 byte) write FIFO** for frame buffer:
- First 3 writes: 3 cycles each
- 4th write: 5 cycles (FIFO flush)
- Burst write 8 bytes in 14 cycles = 1.75 cycles/byte

**Current Code Likely**:
```assembly
; Individual pixel writes (worst case)
MOV.L   R0,@R8        ; Write pixel 1 (3 cycles)
MOV.L   R1,@R8        ; Write pixel 2 (3 cycles)
MOV.L   R2,@R8        ; Write pixel 3 (3 cycles)
MOV.L   R3,@R8        ; Write pixel 4 (3 cycles)
; Total: 12 cycles for 4 pixels
```

**Optimized**:
```assembly
; Batch 4-word writes to trigger FIFO
MOV.L   R0,@R8        ; 3 cycles
MOV.L   R1,@R8        ; 3 cycles
MOV.L   R2,@R8        ; 3 cycles
MOV.L   R3,@R8        ; 5 cycles (FIFO flush)
; Total: 14 cycles for 4 pixels = 3.5 cycles/pixel vs 3.0 before
; But sustained throughput is better with FIFO optimization
```

**Better Approach**: Prepare 4 pixels before writing any:
```assembly
; Compute all 4 pixels first
<calculate pixel 0 -> R0>
<calculate pixel 1 -> R1>
<calculate pixel 2 -> R2>
<calculate pixel 3 -> R3>

; Burst write (triggers FIFO optimization)
MOV.L   R0,@R8+       ; Auto-increment
MOV.L   R1,@R8+
MOV.L   R2,@R8+
MOV.L   R3,@R8+
; Hardware optimizes this pattern
```

### Optimization Strategy 2: Loop Unrolling

If func_065 has a loop, unroll it:

**Before**:
```assembly
    MOV     #16,R7        ; 16 iterations
loop:
    <process 1 pixel>     ; 10 cycles
    DT      R7            ; 1 cycle
    BF/S    loop          ; 2 cycles
    ADD     #4,R8         ; 1 cycle (delay slot)
; Total: 16 × 14 = 224 cycles
```

**After (Unroll 4×)**:
```assembly
    MOV     #4,R7         ; 4 iterations (16/4)
loop:
    <process 4 pixels>    ; 40 cycles (unrolled)
    DT      R7            ; 1 cycle
    BF/S    loop          ; 2 cycles
    ADD     #16,R8        ; 1 cycle (delay slot)
; Total: 4 × 44 = 176 cycles
; Savings: 224 - 176 = 48 cycles (21% improvement)
```

**Estimated Gain**: +10-15% in rasterization (3-5% overall frame time)

---

## HIGH #3: Remove Indirect JSR @R14 Calls

### Current Situation

**Occurrences**: 9 functions use `JSR @R14` for runtime dispatch
**Overhead**: 5-8 cycles per indirect call vs 2-4 for direct BSR

**Example**:
```assembly
02230FE  5EE7     MOV.L   @($1C,R14),R14   ; Load callback pointer (2 cycles)
02223100  4E0B     JSR     @R14             ; Indirect jump (5-8 cycles)
02223102  60D5     MOV.W   @R13+,R0         ; Delay slot (1 cycle)
; Total: 8-11 cycles overhead
```

**Direct call equivalent**:
```assembly
022230FE  B0XX     BSR     target_function  ; Direct jump (2 cycles)
02223100  60D5     MOV.W   @R13+,R0         ; Delay slot (1 cycle)
; Total: 3 cycles overhead
```

**Savings**: 5-8 cycles per call

### Analysis

**Question**: Why use indirect calls?

**Likely Reasons**:
1. Runtime dispatch based on polygon type (triangle vs quad)
2. Different rendering modes (textured vs flat)
3. LOD (Level of Detail) selection

**Optimization**: Profile which callbacks are actually used.

**If Only 1-2 Variants Exist**:
```assembly
; Instead of JSR @R14
    MOV.L   @($1C,R14),R0     ; Load callback ID
    CMP/EQ  #1,R0             ; Is it callback 1?
    BT      callback_1
    CMP/EQ  #2,R0
    BT      callback_2
    BRA     callback_default

callback_1:
    BSR     func_callback_1   ; Direct call
    NOP
    BRA     after_call

callback_2:
    BSR     func_callback_2
    NOP
    BRA     after_call

after_call:
    ; Continue
```

**Tradeoff**: Slightly more code, but 50% faster dispatch if only 2-3 variants.

**If Many Variants**: Use jump table instead:
```assembly
    MOV.L   @($1C,R14),R0     ; Load callback ID
    SHLL2   R0                ; × 4 for pointer table
    MOV.L   @(R0,PC),R1       ; Load from jump table
    JSR     @R1               ; Still indirect, but no memory load delay
```

**Estimated Gain**: +2-3% if callbacks are limited

---

## HIGH #4: Unroll MAC.L Matrix Loops

### Current Situation

**Matrix Multiplication (3×3 example)**:
```assembly
02223146  054F     MAC.L   @R4+,@R5+     ; Row 0, Col 0
02223148  054F     MAC.L   @R4+,@R5+     ; Row 0, Col 1
0222314A  054F     MAC.L   @R4+,@R5+     ; Row 0, Col 2
0222314C  75F4     ADD     #$F4,R5       ; Reset R5 (-12 bytes)
0222314E  6846     MOV.L   @R4+,R8       ; Load translation
02223150  000A     STS     MACH,R0       ; Get result high
02223152  011A     STS     MACL,R1       ; Get result low
02223154  210D     XTRCT   R0,R1         ; Extract fixed-point
02223156  318C     ADD     R8,R1         ; Add translation

; Repeat for Y and Z components...
```

**Current Timing**:
- MAC.L: 2-3 cycles each × 3 = 6-9 cycles
- ADD/STS/XTRCT: ~5 cycles
- **Total per component: ~11-14 cycles**
- **Total per vertex (3 components): 33-42 cycles**

### Optimization Strategy

**MAC Operations Are Already Optimal** - Can't improve MAC.L itself.

**But Can Optimize Surrounding Code**:

**Problem**: ADD #$F4,R5 resets pointer - inefficient.

**Better Approach**: Keep two pointers (R5 for matrix, R6 for vector):

```assembly
; Before (resets R5 each time)
    MAC.L   @R4+,@R5+
    MAC.L   @R4+,@R5+
    MAC.L   @R4+,@R5+
    ADD     #$F4,R5       ; -12: Reset pointer (1 cycle overhead)

; After (use separate vector pointer)
    MOV.L   @R6+,R2       ; Load vector[0]
    MAC.L   @R4+,R2       ; Multiply (no increment on vector)
    MOV.L   @R6+,R2       ; Load vector[1]
    MAC.L   @R4+,R2
    MOV.L   @R6+,R2       ; Load vector[2]
    MAC.L   @R4+,R2
    ; No pointer reset needed
```

**Actually**: SH2 MAC.L requires both operands from memory with auto-increment.

**Real Optimization**: Duplicate vector data to avoid pointer resets:

```assembly
; Memory layout: [M00 M01 M02 M10 M11 M12 M20 M21 M22]
; Vector layout: [Vx Vy Vz Vx Vy Vz Vx Vy Vz]  <- Duplicated!

; Now no pointer resets needed:
    MAC.L   @R4+,@R5+     ; M00 * Vx
    MAC.L   @R4+,@R5+     ; M01 * Vy
    MAC.L   @R4+,@R5+     ; M02 * Vz
    ; R5 naturally points to next Vx for next row
    MAC.L   @R4+,@R5+     ; M10 * Vx
    ...
```

**Tradeoff**: Uses 3× more memory for vectors, but saves 3 cycles per matrix op.

**Estimated Gain**: +5-8% for vertex transform (2-3% overall)

---

## HIGH #5: Master/Slave Load Balancing

### Current Situation

**Unknown**: Distribution of work between Master and Slave SH2 CPUs.

**Hypothesis**: Based on code structure, likely:
- **Master**: Main loop, polygon setup, hardware control
- **Slave**: Some vertex transforms? Texture decompression?

**Problem**: If Slave is underutilized, we're wasting 50% of CPU power.

### Optimization Strategy

**Ideal Distribution** (for 50/50 balance):

**Master SH2**:
1. Coordinate both CPUs
2. Transform 50% of vertices
3. Process 50% of polygons
4. Handle hardware (VDP, interrupts)
5. Final frame buffer composite

**Slave SH2**:
1. Transform remaining 50% of vertices
2. Process remaining 50% of polygons
3. Texture decompression
4. Lighting calculations

**Synchronization**:
```c
// Pseudo-code
Master:
    1. Write vertex count to COMM0
    2. Write "GO" signal to COMM4
    3. Process vertices 0-499
    4. Wait for Slave "DONE" at COMM4
    5. Proceed with polygon processing

Slave:
    1. Wait for "GO" signal at COMM4
    2. Read vertex count from COMM0
    3. Process vertices 500-999
    4. Write "DONE" to COMM4
    5. Wait for next frame
```

**Bottleneck**: COMM register access is slow (cache-through).

**Better**: Use shared SDRAM buffers with flags:
```c
// SDRAM 0x22000000
struct SharedWork {
    volatile uint32_t master_done;  // Flag
    volatile uint32_t slave_done;   // Flag
    VertexBuffer vertices_in[1000];
    VertexBuffer vertices_out[1000];
    PolygonBuffer polygons[800];
};

// Faster polling of SDRAM vs COMM registers
```

**Estimated Gain**: +20-40% if Slave is currently underutilized (10-15% overall)

---

## MEDIUM #6: Frame Buffer FIFO Utilization

### Current Situation

**Frame Buffer Writes**: Scattered throughout code.

**FIFO Behavior**:
- Writes 1-3: 3 cycles each = 9 cycles total
- Write 4: 5 cycles (triggers flush)
- **Burst of 4 writes: 14 cycles = 3.5 cycles/write average**

**But Only If 4 Writes Happen Consecutively!**

### Problem

**Current Code Likely**:
```assembly
    MOV.L   R0,@($24000000)   ; Write pixel (3 cycles)
    <10 instructions of other work>
    MOV.L   R1,@($24000004)   ; Write pixel (3 cycles)
    <10 more instructions>
    MOV.L   R2,@($24000008)   ; Write pixel (3 cycles)
```

**FIFO never fills** because writes are spaced too far apart.

**Result**: 3 cycles per write, no benefit from FIFO.

### Optimization Strategy

**Batch Frame Buffer Writes**:

```assembly
; Compute 4 pixels in registers first
    <calculate pixel 0 -> R0>
    <calculate pixel 1 -> R1>
    <calculate pixel 2 -> R2>
    <calculate pixel 3 -> R3>

; Burst write (triggers FIFO)
    MOV.L   R0,@R8       ; FB base
    MOV.L   R1,@(4,R8)   ; +4
    MOV.L   R2,@(8,R8)   ; +8
    MOV.L   R3,@(12,R8)  ; +12 (FIFO flush)
    ADD     #16,R8       ; Advance pointer
```

**Alternative**: Use auto-increment:
```assembly
    MOV.L   R0,@R8+
    MOV.L   R1,@R8+
    MOV.L   R2,@R8+
    MOV.L   R3,@R8+
; Hardware recognizes pattern and uses FIFO
```

**Estimated Gain**: +5-10% in rasterization (2-4% overall)

---

## MEDIUM #7: Cache-Aware Data Layout

### Current Situation

**SH2 Cache**: 4-way set-associative, 4KB total
- 16-byte cache lines
- Best performance when data is accessed sequentially

**Problem**: Structures accessed via R14 have 56-byte size.

56 bytes = 3.5 cache lines. **Inefficient!**

### Optimization Strategy

**Pad Structure to 64 Bytes** (4 cache lines exactly):

```c
struct RenderingContext {
    uint32_t field_0x00;
    ...
    uint32_t field_0x34;
    uint32_t padding[2];  // +0x38, +0x3C = 64 bytes total
};
```

**Why 64?**
- Power of 2 (better alignment)
- Exactly 4 cache lines
- Reduces false sharing between array elements

**If Array of Contexts**:
```c
RenderingContext contexts[16];  // 1KB array
```

**Before**: Context N and N+1 can alias in cache (same set).
**After**: Proper alignment reduces aliasing.

**Estimated Gain**: +1-2% (small but measurable)

---

## LOW #8: Reduce Register Spilling

### Current Situation

**Register Pressure**: SH2 has 16 general-purpose registers (R0-R15).

**Evidence of Spilling**:
```assembly
02224068  2FE6     MOV.L   R14,@-R15     ; Push R14
0222406A  2F76     MOV.L   R7,@-R15      ; Push R7
...
02224074  67F6     MOV.L   @R15+,R7      ; Pop R7
02224076  6EF6     MOV.L   @R15+,R14     ; Pop R14
```

**Cost**: 2 cycles per push, 2 cycles per pop = 4 cycles overhead.

### Optimization Strategy

**Audit Register Usage**:
1. Identify functions with excessive spilling
2. Reorder operations to reduce live ranges
3. Use caller-saved registers when possible

**Example**:

**Before**:
```assembly
func:
    MOV.L   R8,@-R15      ; Save R8
    MOV.L   R9,@-R15      ; Save R9
    <use R8, R9 for 5 instructions>
    MOV.L   @R15+,R9      ; Restore R9
    MOV.L   @R15+,R8      ; Restore R8
    RTS
```

**After** (reorder to use temp registers):
```assembly
func:
    ; Use R0, R1 instead (caller-saved)
    <use R0, R1 for same operations>
    RTS
    ; No stack operations needed
```

**Estimated Gain**: +0.5-1% (many small savings add up)

---

## Summary of Expected Gains

| Optimization | Estimated Gain | Cumulative |
|--------------|----------------|------------|
| Baseline     | 0%             | 60.0 FPS   |
| #1: Inline func_016 | +5% | 63.0 FPS |
| #2: Optimize func_065 | +10% | 69.3 FPS |
| #3: Remove indirect calls | +2% | 70.7 FPS |
| #4: Unroll MAC loops | +2% | 72.1 FPS |
| #5: Master/Slave balance | +10% | 79.3 FPS |
| #6: FIFO utilization | +3% | 81.7 FPS |
| #7: Cache-aware layout | +1% | 82.5 FPS |
| #8: Reduce register spills | +0.5% | 82.9 FPS |
| **TOTAL** | **~38%** | **~83 FPS** |

**Note**: Gains are not fully additive due to Amdahl's Law. Realistic combined gain: **25-35%**.

---

## Implementation Roadmap

### Phase 1: Quick Wins (1-2 days)
- ✅ Inline func_016 at 4 call sites
- ✅ Unroll MAC.L loops where possible
- ✅ Batch frame buffer writes

**Expected**: +10-15% gain

### Phase 2: Medium Effort (1 week)
- Optimize func_065 rasterization
- Replace indirect calls with direct dispatch
- Improve frame buffer FIFO usage

**Expected**: Additional +10-15% gain

### Phase 3: Major Refactor (2-4 weeks)
- Profile and rebalance Master/Slave work distribution
- Reorganize data structures for cache efficiency
- Reduce register pressure in hot functions

**Expected**: Additional +5-10% gain

---

## Profiling Recommendations

Before implementing optimizations, profile on actual hardware to validate assumptions:

1. **Cycle-accurate timing** using SH2 Free Run Timer
2. **Function call frequency** tracking
3. **Cache miss rate** estimation
4. **Master vs Slave utilization** measurement

**Tools Needed**:
- Hardware debugger or emulator with cycle counting
- Custom profiling hooks inserted in code
- Frame time measurement via VDP VBLANK interrupt

---

## References

- [SH2_3D_PIPELINE_ARCHITECTURE.md](SH2_3D_PIPELINE_ARCHITECTURE.md) - Understanding the pipeline stages
- [SH2_3D_CALL_GRAPH.md](SH2_3D_CALL_GRAPH.md) - Function call relationships and hotspots
- [SH2_3D_ENGINE_DATA_STRUCTURES.md](SH2_3D_ENGINE_DATA_STRUCTURES.md) - Memory layouts and access patterns
- [docs/32x-hardware-manual.md](/docs/32x-hardware-manual.md) - Hardware specs for optimization
- [docs/32x-technical-info.md](/docs/32x-technical-info.md) - Hardware bugs and limitations
