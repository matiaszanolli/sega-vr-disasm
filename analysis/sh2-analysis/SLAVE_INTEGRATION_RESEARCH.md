# Slave Integration Research

**Objective:** Understand how to hook Slave vertex transforms into the actual game pipeline
**Date:** 2026-01-22
**Status:** Research Complete - Critical Constraints Identified

---

## 1. Current Transform Pipeline Analysis

### 1.1 Call Flow (from 68K_SH2_CROSS_REFERENCE.md)

```
68K                              Master SH2
 |                                   |
 |-- COMM0 = $0001 (RENDER_FRAME) -->|
 |-- COMM1 = display_list_addr ----->|
 |                                   |
 |                        display_list_processor (0x0222301C)
 |                                   |
 |                        func_001 (main coordinator)
 |                            |
 |                        func_005 (transform setup)
 |                            ├─> func_006 (MAC.L multiply) ← TARGET
 |                            └─> JSR @R14 (per-vertex callback)
 |                                   |
 |<-- COMM4 = done -----------------|
```

### 1.2 Transform Functions (from SH2_3D_FUNCTION_REFERENCE.md)

| Function | Address | Size | Purpose |
|----------|---------|------|---------|
| func_001 | 0x0222301C | 74 B | Main coordinator |
| func_005 | 0x022230E6 | 46 B | Transform loop (calls func_006) |
| func_006 | 0x02223114 | 98 B | **MAC.L matrix multiply** |
| func_007 | 0x02223176 | 44 B | Alt transform loop (calls func_008) |
| func_008 | 0x022231A2 | 66 B | **MAC.L matrix multiply variant** |

### 1.3 func_005 Loop Structure

```assembly
; From SH2_3D_FUNCTION_REFERENCE.md analysis

022230F0  5CE4     MOV.L   @($10,R14),R12     ; Load matrix pointer
022230FA  D407     MOV.L   @(PC),R4           ; R4 = 0xC0000760 (matrix)
022230FC  D507     MOV.L   @(PC),R5           ; R5 = 0xC0000770 (vector)
022230FE  5EE7     MOV.L   @($1C,R14),R14     ; Load callback
.loop:
02223100  4E0B     JSR     @R14               ; Per-vertex callback
02223102  60D5     MOV.W   @R13+,R0           ; Load parameter (delay slot)
02223104  B00B     BSR     func_006           ; Matrix multiply
02223106  0028     CLRMAC                     ; Clear MAC (delay slot)
02223108  4B10     DT      R11                ; Decrement counter (R11 = vertex count)
0222310A  8FF9     BF/S    .loop              ; Loop if not zero
0222310C  7A10     ADD     #$10,R10           ; Advance output +16 bytes
```

**Key registers:**
- R4 = 0xC0000760 (matrix buffer)
- R5 = 0xC0000770 (vector buffer)
- R10 = Output pointer (advances +16 per vertex)
- R11 = Vertex count (decremented each iteration)
- R14 = Per-vertex callback

---

## 2. CRITICAL FINDING: Memory Address Mapping

### 2.1 The 0xC0000XXX Mystery

The transform code uses addresses like:
- 0xC0000740 - Matrix storage
- 0xC0000760 - Vector buffer
- 0xC0000770 - Another buffer

**Question:** What hardware region is 0xC0000000?

### 2.2 Analysis from Codebase

From `SH2_3D_ENGINE_DATA_STRUCTURES.md`:
```
- 0xC0000000 - Likely SDRAM base (maps to 0x22000000?)
- Note: 0xC0000000 is in the cache region
```

From SH2 address space analysis:
```
Cache Address     Cache-Through     Contents
0x02000000        0x22000000       SDRAM
0x04000000        0x24000000       Frame Buffer
```

**CONCLUSION:** 0xC0000000 is **NOT a standard 32X mapping**. It appears the game uses a non-standard or undocumented address mirror. Most likely:
- 0xC0000XXX = 0x04000XXX (SDRAM via cache) with upper bits decoded differently
- OR the 32X hardware aliases certain address ranges

### 2.3 Cache Coherency Problem

**Each SH2 has its own 4KB cache.** If both CPUs access 0xC0000760:
- Master writes to 0xC0000760 → goes to Master's cache
- Slave reads from 0xC0000760 → reads from Slave's cache (STALE DATA!)

**This is why our Phase 15 tests use 0x22000XXX addresses** - they are cache-through and bypass this problem.

---

## 3. Integration Strategies

### 3.1 Strategy A: Cache-Through Data Staging (RECOMMENDED)

```
Master Side:
1. Copy vertex data from 0xC0000XXX to 0x22000XXX (cache-through staging area)
2. Signal Slave via COMM6

Slave Side:
1. Read vertex data from 0x22000XXX
2. Transform vertices
3. Write results to 0x22000XXX+offset
4. Increment COMM4

Master Side:
5. Copy results from 0x22000XXX back to 0xC0000XXX
6. Continue with polygon processing
```

**Pros:**
- Works with existing cache behavior
- No cache flush needed
- Proven approach (our Phase 15 tests use this)

**Cons:**
- Extra copy overhead (~100 cycles per 64 bytes)
- Need to find safe staging area in SDRAM

### 3.2 Strategy B: Cache Flush Before Signal

```
Master Side:
1. Transform N/2 vertices normally
2. Flush cache (MOVCA.L or direct cache array access)
3. Signal Slave via COMM6

Slave Side:
1. Read data from 0xC0000XXX (now consistent)
2. Transform remaining N/2 vertices
3. Increment COMM4

Master Side:
4. Invalidate cache before reading Slave results
5. Continue
```

**Pros:**
- No data copy overhead
- Works with existing data layout

**Cons:**
- SH2 cache operations are complex (4KB, 4-way associative)
- Cache flush timing may exceed savings
- Risk of subtle cache coherency bugs

### 3.3 Strategy C: Modified Transform Function

Replace func_006 with a version that:
1. Uses cache-through addresses (0x22000760 instead of 0xC0000760)
2. OR writes through cache on every store

**Pros:**
- Clean integration
- No staging overhead

**Cons:**
- Requires modifying core transform code (HIGH RISK)
- May impact performance due to cache-through slowdown
- Could break other code that depends on cached addresses

### 3.4 Strategy D: Vertex Range Splitting (SIMPLEST)

Instead of true parallelization, have Slave pre-compute transforms BEFORE Master needs them:

```
Frame N:
  Master: Render frame N using pre-computed transforms
  Slave: Transform vertices for frame N+1

Frame N+1:
  Master: Render frame N+1 using Slave's transforms
  Slave: Transform vertices for frame N+2
```

**Pros:**
- No cache coherency issues (temporal separation)
- Master and Slave never access same data simultaneously
- Simple synchronization

**Cons:**
- One frame latency for transforms
- May affect physics/animation accuracy
- Requires separate vertex buffers per frame

---

## 4. Data Size Analysis

### 4.1 Per-Vertex Data

**Input Vertex (from DATA_STRUCTURES.md):**
```c
struct InputVertex {
    int32_t x, y, z, w;     // 16 bytes (16.16 fixed-point)
    uint32_t extra[4];      // 16 bytes (flags, indices)
};  // Total: 32 bytes
```

**Output Vertex:**
```c
struct TransformedVertex {
    int32_t screen_x, screen_y;  // 8 bytes
    int32_t depth;               // 4 bytes
    int32_t w;                   // 4 bytes
    // ... more fields
};  // ~32-52 bytes
```

### 4.2 Typical Frame Data

| Parameter | Typical Value | Data Size |
|-----------|---------------|-----------|
| Vertices per frame | ~500 | 16-32 KB input |
| Matrix (4x4) | 1 per model | 64 bytes |
| Models per frame | ~20 | 1.3 KB matrices |

### 4.3 Staging Buffer Requirements

For Strategy A, staging area needs:
- ~8 KB for vertex input (half of vertices)
- ~8 KB for vertex output
- Total: ~16 KB in cache-through SDRAM

**Available SDRAM at 0x22000000:** 256 KB
**Our test area 0x22000100-0x22000300:** 512 bytes (plenty of room to expand)

---

## 5. Hook Point Analysis

### 5.1 Option 1: Hook at func_001 Entry

**Location:** 0x0222301C (main coordinator)

**Approach:**
- Intercept before vertex loop starts
- Master signals Slave with vertex count and data pointers
- Slave processes second half while Master processes first half
- Synchronize at loop end

**Difficulty:** HIGH - func_001 is a complex coordinator with many state dependencies

### 5.2 Option 2: Hook at func_005 Loop

**Location:** 0x022230E6 (transform loop)

**Approach:**
- After matrix setup, split vertex range
- Master: vertices 0 to N/2-1
- Slave: vertices N/2 to N-1

**Difficulty:** MEDIUM - need to understand R11 (count) and R10 (output) relationship

### 5.3 Option 3: Hook at VBlank (Current Approach)

**Location:** 0x243E0 (VBlank poll function)

**Approach:**
- Current Phase 15 tests use this
- Signal Slave at frame boundary
- Slave does pre-computation for next frame

**Difficulty:** LOW - already proven working

**Limitation:** Timing - VBlank is after rendering, not during transform phase

### 5.4 Option 4: New Entry Point at 68K→SH2 Command

**Location:** COMM0 handler in Master

**Approach:**
- When 68K sends RENDER_FRAME command
- Master parses display list header
- Signals Slave with vertex subset
- Both process in parallel

**Difficulty:** MEDIUM - requires understanding display list format

---

## 6. Recommended Path Forward

### Phase 16: Cache-Through Staging Proof

1. Expand Phase 15 test to transform 4 vertices instead of 1
2. Master copies 4 vertices to 0x22000200 (staging)
3. Signal Slave
4. Slave transforms using our proven matrix code
5. Slave writes results to 0x22000280
6. Master reads results and compares with expected

**Success Criteria:**
- Results match expected transforms
- No crashes or data corruption
- COMM4 increments correctly

### Phase 17: Integration with Real Vertex Data

1. Find actual vertex data addresses in game
2. At VBlank, copy subset of vertices to staging
3. Slave transforms during next frame
4. Verify results match game's transforms

### Phase 18: Full Pipeline Integration

1. Hook at display list processing
2. Split vertex processing between Master/Slave
3. Measure actual performance impact

---

## 7. Open Questions

1. **What exactly is 0xC0000000?**
   - Need hardware test to confirm mapping
   - Could dump memory at both addresses and compare

2. **How does the game determine vertex count?**
   - R11 is loaded from context, need to trace source

3. **What is the per-vertex callback (JSR @R14)?**
   - May do LOD selection or culling
   - Could affect which vertices to transform

4. **Is there vertex data dependency between frames?**
   - If physics uses previous frame's transforms, Strategy D breaks

---

## 8. References

- [68K_SH2_CROSS_REFERENCE.md](68K_SH2_CROSS_REFERENCE.md) - Communication protocol
- [SH2_3D_FUNCTION_REFERENCE.md](sh2-analysis/SH2_3D_FUNCTION_REFERENCE.md) - Function details
- [SH2_3D_ENGINE_DATA_STRUCTURES.md](sh2-analysis/SH2_3D_ENGINE_DATA_STRUCTURES.md) - Memory layouts
- [32x-hardware-manual.md](../docs/32x-hardware-manual.md) - Hardware specs
- [POLYGON_TRANSFORMATION_ANALYSIS.md](POLYGON_TRANSFORMATION_ANALYSIS.md) - Pipeline overview

---

**Document Status:** Research complete. Recommended to proceed with Phase 16 (staging proof).
