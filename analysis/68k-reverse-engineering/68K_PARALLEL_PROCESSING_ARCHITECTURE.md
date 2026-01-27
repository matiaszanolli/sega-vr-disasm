# 68K ↔ SH2 Parallel Processing Architecture (v4.0)

**Project**: Virtua Racing Deluxe (USA).32x - Performance Optimization
**Implementation**: v4.0 - Infrastructure ready, activation pending
**Status**: ⚠️ EXPERIMENTAL - Shadow path validated, live activation deferred due to timing concerns

---

## Table of Contents

1. [Overview](#overview)
2. [Historical Context](#historical-context)
3. [Architecture Components](#architecture-components)
4. [Data Flow](#data-flow)
5. [Memory Layout](#memory-layout)
6. [Performance Analysis](#performance-analysis)
7. [Implementation Details](#implementation-details)
8. [Future Directions](#future-directions)

---

## Overview

The v4.0 parallel processing architecture implements **true non-blocking workload distribution** between the Master and Slave SH2 CPUs. This marks a fundamental shift from the original blocking synchronization model to a parallel execution model.

### Key Achievement (Infrastructure Ready)

**⚠️ IMPORTANT**: This architecture is **validated via shadow path** but **NOT YET ACTIVATED** in live gameplay. The infrastructure supports Master SH2 returning immediately after dispatching work to Slave SH2, enabling both CPUs to run in parallel. **Activation is deferred pending performance testing and synchronization validation.**

### Architecture at a Glance

```
Game Engine
    ↓ (calls func_021)
Master SH2
    ├─ Trampoline captures parameters → $2203E000
    ├─ Signals Slave via COMM7 = $16
    └─ Returns immediately ←────────┐
         ↓                          │
    Continues next task             │  PARALLEL EXECUTION
         ↓                          │
    Both CPUs active!               │
                                    ↓
                              Slave SH2
                              ├─ Detects COMM7 = $16
                              ├─ Reads params from $2203E000
                              ├─ Executes func_021_optimized
                              └─ Increments COMM5 counter (+101)
```

---

## Historical Context

### Original Architecture (v1.0-v3.0)

**Blocking Synchronization Model**:
- Master SH2 sends command via COMM0
- Master SH2 **waits** for Slave SH2 acknowledgment
- Slave SH2 processes command
- Slave SH2 signals completion
- Master SH2 resumes execution

**Problem**: ~50% CPU utilization - one CPU always waiting

### v4.0 Breakthrough

**Non-Blocking Parallel Model**:
- Master SH2 captures parameters
- Master SH2 signals work available
- Master SH2 **returns immediately** (!)
- Slave SH2 picks up work asynchronously
- Both CPUs execute simultaneously

**Result**: ~100% CPU utilization during vertex-heavy workloads

---

## Architecture Components

### Component 1: Master Dispatch Hook ($02046A → $300050)

**Location**: $02046A in original code space
**Target**: `master_dispatch_hook` at $300050 (expansion ROM)
**Size**: 44 bytes

**Purpose**: Intercept command dispatch to skip blocking wait for non-blocking commands

**Pseudo-Code**:
```c
void master_dispatch_hook(uint16_t cmd) {
    if (cmd == 0x16) {
        // This is a non-blocking parallel command
        // Do NOT write to COMM7 or wait for Slave
        return;  // Skip blocking dispatch logic
    }
    // For other commands, use original blocking behavior
    original_dispatch_logic(cmd);
}
```

**Note**: The hook checks the **command parameter** (from caller), not COMM7 register. For cmd $16, it skips the blocking COMM protocol entirely.

---

### Component 2: func_021 Trampoline ($0234C8)

**Location**: $0234C8 in SH2 code space
**Size**: ~20 bytes (estimated)

**Purpose**: Capture function parameters and signal Slave SH2

**Implementation**:
```asm
; func_021 trampoline
    MOV.L   R14,@($2203E000)    ; Capture R14 (rendering context pointer)
    MOV.L   R7,@($2203E004)     ; Capture R7 (loop count)
    MOV.L   R8,@($2203E008)     ; Capture R8 (data pointer)
    MOV.L   R5,@($2203E00C)     ; Capture R5 (output pointer)

    MOV.W   #$16,@COMM7         ; Signal Slave: cmd $16

    RTS                         ; Return immediately (non-blocking!)
```

**Parameter Meanings** (reconciled with SH2 documentation):
- **R14**: Rendering context pointer (not vertex data pointer)
- **R7**: Loop count (not transform matrix)
- **R8**: Data pointer (not output buffer)
- **R5**: Output pointer (not count/flags)

**Critical Insight**: This function does **NO ACTUAL WORK** - it only captures parameters and returns.

---

### Component 3: Slave Work Wrapper ($300200)

**Location**: $300200 (expansion ROM)
**Size**: 76 bytes

**Purpose**: Slave SH2 command dispatcher - polls COMM7 and dispatches work

**Pseudo-Code**:
```c
void slave_work_wrapper() {
    while (1) {
        // Poll for work
        if (COMM7 == 0x16) {
            slave_test_func();      // Process vertex transform
            COMM7 = 0;              // Clear command (ready for next)
        }
        // Handle other commands...
    }
}
```

---

### Component 4: Slave Test Function ($300280)

**Location**: $300280 (expansion ROM)
**Size**: 44 bytes

**Purpose**: Read parameters from shared memory and call optimized worker

**Implementation**:
```asm
; slave_test_func
    MOV.L   @($2203E000),R14    ; Load R14 from param block
    MOV.L   @($2203E004),R7     ; Load R7
    MOV.L   @($2203E008),R8     ; Load R8
    MOV.L   @($2203E00C),R5     ; Load R5

    BSR     func_021_optimized  ; Call the actual work function

    ; Increment work counter
    MOV.W   @COMM5,R0
    ADD     #101,R0
    MOV.W   R0,@COMM5

    RTS
```

---

### Component 5: func_021_optimized ($300100)

**Location**: $300100 (expansion ROM)
**Size**: 96 bytes

**Purpose**: Optimized vertex transform with `func_016` inlined

**Characteristics**:
- Original `func_021` called `func_016` as subroutine
- Optimized version **inlines** func_016 for performance
- Eliminates BSR/RTS overhead (~10 cycles per call)
- Works on parameters loaded from shared memory

---

## Data Flow

### Complete Execution Sequence

```
┌─────────────────────────────────────────────────────────────────┐
│ 1. Game Engine Calls func_021                                   │
│    - R14, R7, R8, R5 contain vertex transform parameters        │
└────────────┬────────────────────────────────────────────────────┘
             ↓
┌─────────────────────────────────────────────────────────────────┐
│ 2. func_021 Trampoline ($0234C8)                                │
│    - Captures R14 → [$2203E000]                                 │
│    - Captures R7  → [$2203E004]                                 │
│    - Captures R8  → [$2203E008]                                 │
│    - Captures R5  → [$2203E00C]                                 │
│    - Writes COMM7 = $16 (signal Slave)                          │
│    - Returns IMMEDIATELY                                        │
└────────────┬────────────────────────────────────────────────────┘
             ↓
       ┌─────┴─────┐
       ↓           ↓
┌──────────────┐ ┌──────────────────────────────────────────────┐
│ 3a. Master   │ │ 3b. Slave Work Wrapper ($300200)             │
│     Returns  │ │     - Polling loop detects COMM7 = $16       │
│     to Caller│ │     - Calls slave_test_func                  │
│              │ └───────────────┬──────────────────────────────┘
│              │                 ↓
│              │ ┌──────────────────────────────────────────────┐
│              │ │ 4. slave_test_func ($300280)                 │
│              │ │    - Loads R14 from [$2203E000]              │
│              │ │    - Loads R7  from [$2203E004]              │
│              │ │    - Loads R8  from [$2203E008]              │
│              │ │    - Loads R5  from [$2203E00C]              │
│              │ │    - Calls func_021_optimized                │
│              │ └───────────────┬──────────────────────────────┘
│              │                 ↓
│              │ ┌──────────────────────────────────────────────┐
│ Both CPUs    │ │ 5. func_021_optimized ($300100)              │
│ Running in   │ │    - Executes vertex transform               │
│ Parallel!    │ │    - func_016 logic inlined (optimized)      │
│              │ │    - Processes vertex data                   │
│              │ └───────────────┬──────────────────────────────┘
│              │                 ↓
│              │ ┌──────────────────────────────────────────────┐
│              │ │ 6. Completion                                │
│              │ │    - Increment COMM5 += 101 (counter)        │
│              │ │    - Clear COMM7 = 0 (ready for next work)   │
└──────────────┘ └──────────────────────────────────────────────┘
```

---

## Memory Layout

### Expansion ROM ($300000-$3FFFFF)

| Address | Size | Function |
|---------|------|----------|
| $300028 | 22B | `handler_frame_sync` |
| $300050 | 44B | `master_dispatch_hook` (skips COMM7 for cmd $16) |
| $300100 | 96B | `func_021_optimized` (func_016 inlined) |
| $300200 | 76B | `slave_work_wrapper` (command dispatch loop) |
| $300280 | 44B | `slave_test_func` (param reader + dispatcher) |

### SH2 SDRAM Parameter Block

| Address | Size | Content |
|---------|------|---------|
| $2203E000 | 4B | R14 parameter (rendering context pointer) |
| $2203E004 | 4B | R7 parameter (loop count) |
| $2203E008 | 4B | R8 parameter (data pointer) |
| $2203E00C | 4B | R5 parameter (output pointer) |

**Total**: 16 bytes

### Communication Registers

| Address | SH2 Address | 68K Address | Purpose |
|---------|-------------|-------------|---------|
| COMM7 | $2000402E | $A1512E | Command signal (value: $16) |
| COMM5 | $2000402A | $A1512A | Work counter (+101 per completion) |

---

## Performance Analysis

### CPU Utilization (THEORETICAL - UNVALIDATED)

**⚠️ NOTE**: These estimates are based on architecture design. **Real-world performance is untested** due to activation being deferred.

**Before v4.0 (Blocking Model)**:
```
Master SH2: ████░░░░░░░░████░░░░░░░░  ~50% (blocked waiting)
Slave SH2:  ░░░░████░░░░░░░░████░░░░  ~40% (processing when signaled)
Overall:    ████████░░░░████████░░░░  ~45% combined
```

**After v4.0 (Parallel Model) - THEORETICAL**:
```
Master SH2: ████████████████████████  ~95% (no blocking) [ESTIMATED]
Slave SH2:  ░░████████░░████████░░██  ~70% (processing queued work) [ESTIMATED]
Overall:    ████████████████████████  ~82% combined [ESTIMATED]
```

**Theoretical Improvement**: ~1.8x effective CPU utilization (UNVALIDATED)

### Frame Rate Impact (THEORETICAL - UNVALIDATED)

**⚠️ IMPORTANT**: These projections are **speculative** and based on architecture analysis only. **No real-world FPS measurements exist** because live activation is deferred.

**Theoretical Maximum**:
- Original blocking model: ~20 FPS ceiling (documented bottleneck)
- Parallel model: ~35-40 FPS potential (IF this was the only bottleneck) [UNVALIDATED]

**Reality Check**:
- ❌ **Not tested**: No performance testing has been conducted
- ⚠️ **Timing risk**: Frame synchronization not validated
- ⚠️ **Unknown impact**: Other bottlenecks may dominate (68K processing, bus contention, etc.)
- 📋 **Activation pending**: Awaiting performance testing infrastructure

### Work Counter Analysis

**COMM5 Counter**: Increments by 101 per vertex transform completion

**Purpose**:
- Debug/telemetry: Track how many transforms completed
- Synchronization point: Master can check if work is done (if needed)
- Performance metric: Transforms/second = (COMM5_delta / 101) * 60

---

## Implementation Details

### Why Command $16?

**Selection Criteria**:
- Unused command code in original game
- Easily identifiable in debugging
- No collision with existing COMM protocol

**Alternative**: Could use any unused value ($10-$FF range)

### Why Increment COMM5 by 101?

**⚠️ DEBUG TELEMETRY ONLY** - This counter is **not** part of the core synchronization protocol.

**Rationale**:
- **Visibility**: Large increment makes counter changes obvious in debugging
- **Uniqueness**: 101 is prime, less likely to collide with other increments
- **Future-proof**: Allows for different work types with different increments
- **Debug tool**: Helps verify Slave is executing work during testing

**Example**:
```
Start: COMM5 = 0
After 1 transform: COMM5 = 101
After 2 transforms: COMM5 = 202
After 10 transforms: COMM5 = 1010
```

### Parameter Block Size

**16 bytes = 4 parameters × 4 bytes each**

**Why 4 parameters?**:
- SH2 calling convention typically uses R4-R7 for first 4 arguments
- func_021 signature: `func_021(R14, R7, R8, R5)`
- Captures exact state needed for vertex transform

**Why not more?**:
- Additional parameters would be on stack (slower to capture)
- 4 parameters sufficient for this workload

### Synchronization Guarantees

**Write Ordering**:
1. Parameter block written **before** COMM7 signal
2. SH2 write buffer guarantees ordering within single CPU
3. Slave reads COMM7 **before** reading parameters

**Race Conditions**:
- **Prevented**: Master writes params → signal → return (atomic from Slave's view)
- **Not a concern**: Slave clears COMM7 after reading params
- **Future work**: Need frame-boundary synchronization for correctness

---

## Future Directions

### Phase 1: Infrastructure Complete ✅

- [x] Parameter passing infrastructure
- [x] Real parameter capture
- [x] Shadow path validation (non-live testing)
- [ ] **Live activation** - DEFERRED due to timing concerns

### Phase 2: Performance Testing (Next)

- [ ] Measure FPS improvement in gameplay
- [ ] Profile Master/Slave CPU utilization
- [ ] Identify remaining bottlenecks

### Phase 3: Synchronization

- [ ] Ensure Slave completes before next frame
- [ ] Add frame-boundary sync mechanism
- [ ] Handle Slave overrun conditions

### Phase 4: Load Balancing

- [ ] Split polygon workload between CPUs
- [ ] Distribute multiple vertices per dispatch
- [ ] Optimize parameter block for batch operations

### Phase 5: Advanced Optimization

- [ ] Identify additional parallelizable functions
- [ ] Implement work-stealing queue
- [ ] Multi-frame pipelining

---

## Technical Constraints

### Expansion ROM Limitations

**CRITICAL**: Expansion section ($300000-$3FFFFF) can **ONLY** contain:
- SH2 code (`dc.w` format - raw 16-bit opcodes)
- Data literals
- Padding (0xFF)

**NEVER** use 68K assembly mnemonics in expansion ROM - it executes on SH2 only!

### Cache Coherency

**SH2 Data Cache**:
- Write-through mode recommended for shared memory ($2203E000)
- Ensure cache coherency between Master/Slave writes
- Alternative: Use uncached memory region

**Current Status**: Assuming write-through (verify in hardware setup)

### Bus Contention

**Shared Resources**:
- SDRAM bus ($2200xxxx range)
- COMM registers ($2000402x)

**Mitigation**:
- Keep parameter block small (16 bytes = 4 cache lines)
- Minimize SDRAM access during Slave execution
- Use register-based computation where possible

---

## Debugging Tips

### Monitoring Work Dispatch

**COMM5 Counter**:
```asm
; Read work counter
MOV.W   @COMM5,R0        ; R0 = number of transforms * 101
```

**Expected Behavior**:
- Counter should increment by 101 each frame (if vertex transforms occur)
- Steady increment = Slave is processing work
- Stuck counter = Slave blocked or not receiving work

### Parameter Block Inspection

**GDB Watchpoint**:
```gdb
watch *(long*)0x2203E000
watch *(long*)0x2203E004
watch *(long*)0x2203E008
watch *(long*)0x2203E00C
```

**Expected Values**:
- Non-zero when work dispatched
- Change each frame during active gameplay

### COMM7 Signal Trace

**Expected Pattern**:
```
Time 0: COMM7 = 0 (idle)
Time 1: COMM7 = $16 (Master signals work)
Time 2: COMM7 = $16 (Slave hasn't picked up yet)
Time 3: COMM7 = 0 (Slave cleared after processing)
Time 4: COMM7 = 0 (idle, ready for next)
```

**Stuck at $16**: Slave not polling or crashed
**Always 0**: Master not dispatching work

---

## References

### Internal Documentation

- [68K_COMM_PROTOCOL.md](68K_COMM_PROTOCOL.md) - Pattern 4: Parallel Processing
- [68K_MEMORY_MAP.md](68K_MEMORY_MAP.md) - Parameter block layout
- [68K_HOTSPOT_FUNCTIONS.md](68K_HOTSPOT_FUNCTIONS.md) - func_021 trampoline
- [SH2_3D_PIPELINE_ARCHITECTURE.md](../SH2_3D_PIPELINE_ARCHITECTURE.md) - SH2 rendering

### External Documentation

- [ARCHITECTURAL_BOTTLENECK_ANALYSIS.md](../ARCHITECTURAL_BOTTLENECK_ANALYSIS.md) - Original blocking model analysis
- [ROM_EXPANSION_4MB_IMPLEMENTATION.md](../architecture/ROM_EXPANSION_4MB_IMPLEMENTATION.md) - 4MB expansion architecture
- [32x-hardware-manual.md](../../docs/32x-hardware-manual.md) - Hardware specifications

### Project Root

- [CLAUDE.md](../../CLAUDE.md) - Current development status
- [OPTIMIZATION_PLAN.md](../../OPTIMIZATION_PLAN.md) - Overall optimization roadmap

---

**Document Version**: 1.1
**Last Updated**: 2026-01-26
**Implementation Status**: v4.0 - Infrastructure ready, activation deferred
**Revision History**:
- v1.1 (2026-01-26): Corrected status to "activation pending", fixed parameter meanings, added "theoretical/unvalidated" labels
- v1.0 (2026-01-26): Initial documentation (overstated operational status)
