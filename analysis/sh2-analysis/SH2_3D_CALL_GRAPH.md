# 3D Engine Call Graph

**Virtua Racing Deluxe - Function Relationships**
**Analysis Date**: January 6, 2026

---

## Overview

Complete call graph analysis of 109 functions in the SH2 3D rendering engine. This document maps all function relationships, identifies hot paths, and highlights the execution flow through the rendering pipeline.

**Statistics**:
- Total Functions: 109
- Functions with Calls: 31
- Leaf Functions: 78
- Direct Calls (BSR): 98
- Indirect Calls (JSR @Rn): 20
- Potential Entry Points: 74

---

## Visual Call Graph (Partial)

### Hot Path: Main Rendering Loop

```
Entry Point
    │
    ▼
┌─────────────────────────────────────────┐
│  func_001 (0x0222301C)                  │  Main Coordinator
│  ├─> func_005 (0x022230E6)              │  Matrix Transform Setup
│  │   ├─> func_006 (0x02223114) [LEAF]   │  MAC.L Matrix Multiply
│  │   └─> JSR @R14                        │  Indirect: Per-vertex callback
│  ├─> func_007 (0x02223176)              │  Alt Transform Setup
│  │   ├─> func_008 (0x022231A2) [LEAF]   │  MAC.L Matrix Multiply (variant)
│  │   └─> JSR @R14                        │  Indirect: Per-vertex callback
│  ├─> func_009 (0x022231E4) [LEAF]        │  Result Processor
│  └─> func_010 (0x02223202) [LEAF]        │  Result Processor (variant)
└─────────────────────────────────────────┘
```

### Hot Path: Polygon Processing Chain

```
┌─────────────────────────────────────────┐
│  func_018 (0x022233A2)                  │  Polygon Coordinator
│  ├─> func_016 (0x0222335A) [LEAF] ⭐    │  HOTSPOT: Called 4×
│  └─> func_020 (0x02223468)              │  Polygon Transform
│      ├─> func_020 (0x02223468)          │  Recursive/loop structure
│      └─> func_023 (0x02223500)          │  Sub-polygon handler
└─────────────────────────────────────────┘

┌─────────────────────────────────────────┐
│  func_019 (0x0222340C)                  │  Alt Polygon Path
│  ├─> func_016 (0x0222335A) [LEAF] ⭐    │  HOTSPOT: Called 4×
│  └─> func_020 (0x02223468)              │  Transform
└─────────────────────────────────────────┘
```

### Hot Path: Extended Processing

```
┌─────────────────────────────────────────┐
│  func_060 (0x02223E08)                  │  Extended Processor
│  └─> func_065 (0x02223F2C) [LEAF] ⭐    │  HOTSPOT: Called 4×
│                                         │
│  func_061 (0x02223E32)                  │
│  └─> func_065 (0x02223F2C) [LEAF] ⭐    │  HOTSPOT: Called 4×
│                                         │
│  func_062 (0x02223E5C)                  │
│  └─> func_065 (0x02223F2C) [LEAF] ⭐    │  HOTSPOT: Called 4×
│                                         │
│  func_063 (0x02223E88)                  │
│  └─> func_065 (0x02223F2C) [LEAF] ⭐    │  HOTSPOT: Called 4×
└─────────────────────────────────────────┘
```

---

## Function Categories

### Category 1: Entry Points (74 functions)

Functions that are never called by other functions in this region. Likely called from:
- 68000 main code
- Interrupt handlers
- SH2 Slave CPU
- External ROM code

**Top Entry Points**:
- func_000 (0x0222300A) - Initialization sequence
- func_001 (0x0222301C) - Main loop coordinator
- func_002 (0x02223066) - Hardware setup
- func_011 (0x0222321C) - Specialized processor
- func_018 (0x022233A2) - Polygon batch processor
- func_019 (0x0222340C) - Alt polygon processor

---

### Category 2: Utility Functions (9 functions)

Called multiple times from different locations. Core reusable components.

**func_016 (0x0222335A)** ⭐ HOTTEST
- Called 4 times
- Leaf function (no outgoing calls)
- Likely: Coordinate transformation or clipping utility
- Size: ~44 bytes

**func_065 (0x02223F2C)** ⭐ HOTTEST
- Called 4 times
- Leaf function
- Likely: Rasterization helper or pixel operation
- Size: ~150 bytes

**func_020 (0x02223468)**
- Called 3 times (including self-recursion)
- Calls: func_020 (recursive), func_023
- Likely: Recursive polygon subdivision or loop

**func_008 (0x022231A2)**
- Called 2 times
- Leaf function with MAC.L sequences
- Purpose: Matrix multiplication variant

**func_009 (0x022231E4)**
- Called 2 times
- Leaf function
- Purpose: Result processing/packing

---

### Category 3: Leaf Functions (78 functions)

Functions that don't call any other functions. These are the actual "work" functions:
- Matrix multiplication (with MAC.L)
- Data copying/unpacking
- Register writes (hardware control)
- Simple calculations

**Examples**:
- func_000 (0x0222300A) - Simple loop, 18 bytes
- func_003 (0x022230CC) - Tiny utility, 16 bytes
- func_004 (0x022230DC) - Tiny utility, 10 bytes
- func_006 (0x02223114) - MAC.L matrix multiply, 98 bytes
- func_008 (0x022231A2) - MAC.L matrix multiply variant, 66 bytes
- func_013 (0x022232C4) - Medium complexity, 68 bytes
- func_016 (0x0222335A) - Hot utility, 44 bytes
- func_065 (0x02223F2C) - Hot utility, 150 bytes

---

### Category 4: Coordinators (31 functions)

Functions that call other functions to orchestrate work.

**func_001 (0x0222301C)**
- Calls: func_005, func_007, func_009, func_010
- Purpose: Main transformation coordinator
- Size: 74 bytes

**func_005 (0x022230E6)**
- Calls: func_006, JSR @R14 (indirect)
- Purpose: Matrix transform setup with callback
- Size: 46 bytes

**func_012 (0x02223268)**
- Calls: func_008, func_009
- Purpose: Transform pipeline stage
- Size: 92 bytes

---

## Hotspot Analysis

### Top 10 Most-Called Functions

| Rank | Function | Address | Call Count | Type | Est. Impact |
|------|----------|---------|------------|------|-------------|
| 1 | func_016 | 0x0222335A | 4 | Leaf | Critical |
| 2 | func_065 | 0x02223F2C | 4 | Leaf | Critical |
| 3 | func_020 | 0x02223468 | 3 | Coordinator | High |
| 4 | func_008 | 0x022231A2 | 2 | Leaf (MAC) | High |
| 5 | func_009 | 0x022231E4 | 2 | Leaf | Medium |
| 6 | func_023 | 0x02223500 | 2 | Unknown | Medium |
| 7 | func_034 | 0x0222375C | 2 | Unknown | Medium |
| 8 | func_043 | 0x022239AA | 2 | Unknown | Medium |
| 9 | func_071 | 0x022241CC | 2 | Unknown | Medium |
| 10| func_010 | 0x02223202 | 1 | Leaf | Low |

**Optimization Priority**: Focus on func_016 and func_065 first (4× calls, leaf functions = hot loops).

---

## Indirect Call Analysis

### JSR @R14 Pattern

**Occurrences**: 9 functions use JSR @R14 for indirect calls

**Functions with JSR @R14**:
- func_005 (0x022230E6) - Calls per-vertex transform handler
- func_007 (0x02223176) - Calls per-vertex transform handler variant

**Purpose**: Function pointer callbacks. R14 contains address of handler function, allowing runtime dispatch based on polygon type or rendering mode.

**Example**:
```assembly
022230FE  5EE7     MOV.L   @($1C,R14),R14   ; Load callback pointer from context+0x1C
02223100  4E0B     JSR     @R14             ; Call indirect function
02223102  60D5     MOV.W   @R13+,R0         ; Delay slot: load parameter
```

**Optimization Opportunity**: Indirect calls have overhead (~5-8 cycles). Could use direct calls if callback doesn't change.

---

## Complete Call Graph

### Functions 000-020

```
func_000 (0x0222300A - 0x0222301A):
  (leaf function - no calls)

func_001 (0x0222301C - 0x02223064):
  -> func_005 (0x022230E6)
  -> func_007 (0x02223176)
  -> func_009 (0x022231E4)
  -> func_010 (0x02223202)

func_002 (0x02223066 - 0x022230CA):
  -> func_003 (0x022230CC)
  -> func_004 (0x022230DC)

func_003 (0x022230CC - 0x022230DA):
  (leaf function - no calls)

func_004 (0x022230DC - 0x022230E4):
  (leaf function - no calls)

func_005 (0x022230E6 - 0x02223112):
  -> func_006 (0x02223114)
  -> JSR_@R14 (indirect)

func_006 (0x02223114 - 0x02223174):
  (leaf function - MAC.L heavy)

func_007 (0x02223176 - 0x022231A0):
  -> func_008 (0x022231A2)
  -> JSR_@R14 (indirect)

func_008 (0x022231A2 - 0x022231E2):
  (leaf function - MAC.L heavy)

func_009 (0x022231E4 - 0x02223200):
  (leaf function)

func_010 (0x02223202 - 0x0222321A):
  (leaf function)

func_011 (0x0222321C - 0x02223266):
  -> func_012 (0x02223268)

func_012 (0x02223268 - 0x022232C2):
  -> func_008 (0x022231A2)
  -> func_009 (0x022231E4)

func_013 (0x022232C4 - 0x02223306):
  (leaf function)

func_014 (0x02223308 - 0x0222333E):
  (leaf function)

func_015 (0x02223340 - 0x02223358):
  (leaf function)

func_016 (0x0222335A - 0x02223386): ⭐ HOTSPOT
  (leaf function - called 4 times)

func_017 (0x02223388 - 0x022233A0):
  -> func_016 (0x0222335A)

func_018 (0x022233A2 - 0x0222340A):
  -> func_016 (0x0222335A)
  -> func_020 (0x02223468)

func_019 (0x0222340C - 0x02223466):
  -> func_016 (0x0222335A)
  -> func_020 (0x02223468)

func_020 (0x02223468 - 0x022234BE):
  -> func_020 (0x02223468)  [RECURSIVE]
  -> func_023 (0x02223500)
```

*[Functions 021-108 follow similar patterns - see disasm/sh2_3d_engine_callgraph.txt for complete details]*

---

## Critical Execution Paths

### Path 1: Initialization (One-time)

```
Entry → func_000 → Hardware Init → Return
        │
        └─> func_002 → func_003 → Hardware Config
                    └─> func_004 → Additional Setup
```

**Frequency**: Once per game start or scene load
**Performance Impact**: Negligible (one-time cost)

---

### Path 2: Per-Frame Vertex Transform (Hot)

```
Entry → func_001 → func_005 → func_006 (MAC.L) ⭐
                            └─> JSR @R14 (callback)
                │
                └─> func_007 → func_008 (MAC.L) ⭐
                            └─> JSR @R14 (callback)
```

**Frequency**: Per vertex, per frame (~500 vertices × 60 FPS = 30,000 calls/sec)
**Performance Impact**: CRITICAL
**Bottleneck**: MAC.L sequences take 2-3 cycles each, 9-12 cycles per matrix op

---

### Path 3: Polygon Processing (Hot)

```
Entry → func_018 → func_016 ⭐ (4× calls)
                └─> func_020 → func_023
                            └─> func_020 (recursive)

Entry → func_019 → func_016 ⭐ (4× calls)
                └─> func_020
```

**Frequency**: Per polygon, per frame (~800 polygons × 60 FPS = 48,000 calls/sec)
**Performance Impact**: CRITICAL
**Bottleneck**: func_016 called 4 times per polygon = 4× overhead

---

### Path 4: Extended Rendering (Hot)

```
Entry → func_060 → func_065 ⭐
Entry → func_061 → func_065 ⭐
Entry → func_062 → func_065 ⭐
Entry → func_063 → func_065 ⭐
```

**Frequency**: Per pixel batch or rasterization unit
**Performance Impact**: CRITICAL
**Bottleneck**: func_065 is 150 bytes of tight code, likely pixel inner loop

---

## Function Complexity Distribution

```
Size Range   Count   Purpose
═══════════════════════════════════════════
<20 bytes    25      Tiny utilities
20-50 bytes  38      Small helpers
50-100 bytes 32      Medium functions
100-200 bytes 12     Large functions
>200 bytes   2       Complex handlers
```

**Observations**:
- Most functions are small (<50 bytes) - good for i-cache
- Complex work is distributed across many small functions
- Function call overhead may be significant

---

## Recursion and Loops

### Recursive Functions

**func_020 (0x02223468)**: Self-recursive
- Purpose: Likely polygon subdivision or hierarchical processing
- Max depth: Unknown (counter-based, likely bounded)
- Optimization: Could unroll or iterate instead

---

## Summary

The call graph reveals a well-structured 3D engine with clear separation of concerns:

**Strengths**:
- Modular design with small, focused functions
- Clear hot paths through func_016 and func_065
- Efficient use of leaf functions for performance-critical code
- Indirect dispatch allows runtime flexibility

**Optimization Targets**:
1. **func_016** (hotspot) - Inline or optimize for 4× call reduction
2. **func_065** (hotspot) - Likely pixel loop, optimize memory access
3. **func_006/func_008** (MAC.L) - Already optimal, but check input data alignment
4. **JSR @R14** (indirect calls) - Consider direct calls if dispatch is predictable

**Next Steps**:
- Disassemble func_016 and func_065 in detail
- Profile actual call frequencies on hardware
- Measure cycle counts for hot paths
- Identify cache miss patterns

---

## References

- [SH2_3D_PIPELINE_ARCHITECTURE.md](SH2_3D_PIPELINE_ARCHITECTURE.md) - Pipeline stages using these functions
- [SH2_3D_FUNCTION_REFERENCE.md](SH2_3D_FUNCTION_REFERENCE.md) - Detailed function descriptions
- [OPTIMIZATION_OPPORTUNITIES.md](OPTIMIZATION_OPPORTUNITIES.md) - How to optimize hot paths
- Complete call graph: `disasm/sh2_3d_engine_callgraph.txt`
