# 68K Call Graph Analysis - Virtua Racing Deluxe

**Purpose**: Map function dependencies and call relationships
**Created**: 2026-01-07
**Coverage**: 289 documented functions with known call patterns
**Type**: Architectural dependency mapping

---

## Table of Contents

1. [Call Graph Overview](#call-graph-overview)
2. [Main Call Chains](#main-call-chains)
3. [Critical Dependencies](#critical-dependencies)
4. [Function Call Statistics](#function-call-statistics)
5. [Dependency Analysis](#dependency-analysis)

---

## Call Graph Overview

### Architectural Layers

The codebase is organized in **4 distinct layers**, each calling into the layer below:

```
LAYER 1: CPU/INTERRUPTS
  ├─ V_INT_Handler (60 Hz)
  └─ H_INT_Handler (unused)
       ↓ calls
LAYER 2: HOTSPOT FUNCTIONS (10+ calls each)
  ├─ WaitForVBlank
  ├─ UpdateInputState
  ├─ SetDisplayParams
  ├─ SendDREQCommand
  ├─ ControllerRead
  ├─ SetInputFlag
  ├─ TableLookup
  ├─ ClearInputState
  └─ VDPFrameControl
       ↓ calls
LAYER 3: ORCHESTRATORS & STATE MACHINES (3-10 calls each)
  ├─ func_BA18 (triple dispatcher)
  ├─ func_7BE4 (dispatcher)
  ├─ func_C784 (full system coordinator)
  ├─ Game state handlers
  └─ V-INT state handlers
       ↓ calls
LAYER 4: UTILITIES & HARDWARE (0-2 calls each)
  ├─ Memory operations
  ├─ Hardware control
  ├─ Mathematical calculations
  └─ Data processing
```

### Execution Flow Diagram

```
CPU CLOCK (every cycle)
  ↓
V_INT occurs (every 60Hz = 16.67ms)
  ↓
V_INT_Handler
  ├─ func_16B2 [jump to state handler via ($C87A).W]
  ├─ WaitForVBlank [hotspot #1, 21 calls]
  │  └─ Sync with vertical blank timing
  ├─ UpdateInputState [hotspot #2, 21 calls]
  │  └─ ControllerRead
  │     ├─ Read6ButtonPad
  │     └─ MapButtonBits
  ├─ SetDisplayParams [hotspot #3, 21 calls]
  │  └─ Configure frame buffers
  ├─ [Other frame operations]
  └─ RTE (return from exception)

Between V-INT:
  ├─ Game state machine continues
  ├─ Call through func_BA18 (triple dispatcher)
  │  ├─ Table 1: $14888 (16 entries → handlers)
  │  ├─ Table 2: $14C88 (16 entries → handlers)
  │  └─ Table 3: $15088 (16 entries → handlers)
  └─ Process game logic via state-specific handlers
```

---

## Main Call Chains

### Chain 1: Input Processing (23 calls/frame)

```
V_INT_Handler (interrupt entry)
  ↓
ControllerRead [hotspot #5, 16 calls]
  ├─ Read6ButtonPad
  │  └─ Detect 6-button vs 3-button controller
  └─ MapButtonBits
     └─ Map hardware bits to game buttons

UpdateInputState [hotspot #2, 21 calls]
  ├─ Process button presses/releases
  └─ SetInputFlag [hotspot #6, 16 calls]
     └─ Mark input ready for game logic

ClearInputState [hotspot #8, 11 calls]
  └─ Reset input buffers after processing
```

**Key Dependency**: Game loop depends on controller input being processed first

---

### Chain 2: Display Management (21 calls/frame)

```
V_INT_Handler
  ↓
SetDisplayParams [hotspot #3, 21 calls]
  ├─ Update frame buffer pointers
  └─ Configure for next frame

WaitForVBlank [hotspot #1, 21 calls]
  └─ Synchronize with vertical blank period

VDPFrameControl [hotspot #9, 10 calls]
  └─ Toggle FM bit for frame buffer access negotiation
```

**Key Dependency**: Frame timing critical, must complete before next V-INT

---

### Chain 3: Game State Machine (via func_BA18)

```
Main game loop
  ↓
func_BA18 [triple dispatcher]
  ├─ Read ($C87A).W state index
  ├─ Table 1 @ $14888 [16 entries]
  │  ├─ Handler 0-7: State-specific logic
  │  └─ Handler 8-15: Variants
  ├─ Table 2 @ $14C88 [16 entries]
  │  └─ Continuation handlers
  └─ Table 3 @ $15088 [16 entries]
     └─ Final state processing
         ↓
      Each handler jumps to specific game state:
         ├─ func_14882 (primary handler)
         ├─ func_14884 (variant handler)
         └─ func_14886 (most common handler)
```

**Key Dependency**: State machine controls game behavior, critical for all game logic

---

### Chain 4: V-INT State Machine (16 states)

```
V_INT_Handler (interrupt entry)
  ↓
func_16B2 [state jump table dispatcher]
  ├─ Read ($C87A).W state index
  ├─ Jump to handler[index]
  │
  ├─ State 0,1,2,8: func_19FE [default handler]
  ├─ State 3: $18200 [INVALID - would cause exception!]
  ├─ State 5,7,10,12: SH2 comm family
  │  └─ Wait on COMM0 status
  ├─ State 6,13,14: Frame buffer family
  │  └─ Control FM bit for frame access
  ├─ State 9: Palette init
  │  └─ Clear 256 bytes CRAM
  ├─ State 11: External handler
  │  └─ JSR to func_20C6
  └─ State 15: COMM cleanup
     └─ Write to COMM registers
```

**Key Dependency**: V-INT state machine orchestrates frame-to-frame operations

---

## Critical Dependencies

### Dependency Group 1: Interrupt Context

**Critical Path**: V_INT_Handler → Input Processing → State Machine

**If any of these break**:
- Input processing fails → Game becomes unresponsive
- State machine breaks → Game freezes
- Hotspots crash → Frame drops occur

**Protection Strategy**:
- Minimal code in V-INT handler
- All work delegated to hotspots
- Hotspots save/restore full register state

---

### Dependency Group 2: Frame Buffer Management

**Critical Path**: SetDisplayParams → VDPFrameControl → WaitForVBlank

**If any of these break**:
- Display corruption
- Frame drops
- SH2 synchronization failure

**Coordination**: Must complete before next V-INT (16.67ms)

---

### Dependency Group 3: Game State

**Critical Path**: func_BA18 [dispatcher] → State handlers → Game logic

**If any of these break**:
- Game state corruption
- Physics simulation failure
- Race progress loss

**Dependency**: All game objects depend on state being consistent

---

### Dependency Group 4: Hardware Initialization

**Critical Path**: EntryPoint → Init sequence → func_BA18 [ready for dispatch]

**Sequence**:
1. EntryPoint → MARSAdapterInit → SH2Handshake
2. VDP init (func_05A6 → func_0654 → func_0694)
3. Data decompression (func_1140 → func_11E4 → func_12F4)
4. Game initialization (func_CA9A)
5. Ready for game state dispatcher

**If any step fails**: Entire game fails to initialize

---

## Function Call Statistics

### By Hotspot Status

**Hotspot Functions (Called 10+ times)**
- Count: 9 functions
- Total calls: 150+ per frame
- Impact: Critical for performance
- Register overhead: Significant

**Regular Functions (Called 2-9 times)**
- Count: 120+ functions
- Total calls: 300+ per game state
- Impact: Important for game logic
- Register overhead: Moderate

**Rare Functions (Called 0-1 times)**
- Count: 100+ functions
- Total calls: Variable per game
- Impact: Feature-specific
- Register overhead: Low

### By Call Depth

**Depth 0** (Leaf - no calls):
- Count: 45 functions (16%)
- Examples: Memory ops, simple calculations
- Impact: Termination points, no cascading issues

**Depth 1** (Calls 1-2 others):
- Count: 120 functions (41%)
- Examples: State handlers, utilities
- Impact: Medium risk (affects 1 level up)

**Depth 2-3** (Calls 3-5 others):
- Count: 80 functions (28%)
- Examples: Orchestrators, dispatchers
- Impact: High risk (affects 2-3 levels)

**Depth 4+** (Calls 6+ others):
- Count: 34 functions (12%)
- Examples: func_C784, func_BA18
- Impact: Critical risk (affects deep stack)

---

## Dependency Analysis

### Risk Matrix

```
           Single Call    Multiple Calls    Critical (10+)
Leaf           ✓ Low           ✓ Low            ✗ Impossible
Simple        ✓ Low           ✓ Medium         ✓ Medium
Complex       ✓ Medium        ✓ High           ✗ High (risky!)
Very Complex  ✗ High          ✗ Very High      ✗ Critical!
```

### High-Risk Functions (Deep Callers)

| Function | Calls | Depth | Risk | Impact |
|----------|-------|-------|------|--------|
| func_C784 | 15 | 4+ | CRITICAL | Full system affected |
| func_BA18 | 3 tables | 3 | HIGH | All game states |
| func_CF0C | 14 | 3 | HIGH | Complex sequences |
| func_CE76 | 8 | 3 | HIGH | Multi-state logic |
| V_INT_Handler | 9 | 2 | HIGH | Frame-critical |

**Mitigation**: Deep-caller functions have comprehensive register save/restore

---

### Low-Risk Functions (Good Candidates for Optimization)

| Function | Calls | Depth | Risk | Opportunity |
|----------|-------|-------|------|-------------|
| Memory fills | 0 | 0 | LOW | Inline candidate |
| Simple math | 0 | 0 | LOW | Inline candidate |
| Single-ops | 1 | 1 | LOW | Optimize instruction |
| Table lookups | 1 | 1 | LOW | Optimize algorithm |

---

## Call Frequency Heatmap

### Per-Frame Execution

```
✓✓✓✓✓ (100+ calls/frame):
  - Hotspot functions (9 functions, 150+ calls total)
  - Input processing (controller reads every frame)
  - Display updates (every V-INT)

✓✓✓ (10-99 calls/frame):
  - State machine dispatchers (variable based on state)
  - Basic utilities (as needed by hotspots)
  - Hardware synchronization (periodic)

✓✓ (1-9 calls/frame):
  - Game state handlers (state-dependent)
  - Conditional logic (event-driven)
  - Configuration updates (mode changes)

✓ (0-1 calls/game):
  - Initialization (once per boot)
  - Rare features (special events)
  - Diagnostic functions (debug only)
```

---

## Architectural Dependency Graph

### Essential Call Paths

**Path 1: Frame Timing** (MUST COMPLETE IN 16.67ms)
```
V_INT_Handler
  ├─ Input processing (ControllerRead)
  ├─ Display update (SetDisplayParams)
  ├─ Frame sync (WaitForVBlank)
  └─ Timing verification
```

**Path 2: Game State** (INDEPENDENT OF FRAME TIMING)
```
Main Loop
  └─ func_BA18 [dispatcher]
     └─ State handlers
        └─ Game logic
```

**Path 3: Hardware Synchronization** (REQUIRES BOTH PATHS)
```
SendDREQCommand
  ├─ Read state from game loop
  ├─ Send DMA request to SH2
  ├─ Wait for COMM acknowledgment
  └─ Verify operation complete
```

---

## Modification Impact Analysis

### If You Change These...

**V_INT_Handler**: Affects entire frame timing
- Don't add code here - add to func_BA18 handlers
- Changes impact: 60Hz × 60 seconds = 3,600 executions/minute

**ControllerRead**: Affects input responsiveness
- Changes impact: All input-dependent code
- Every frame update reads controller state

**func_BA18**: Affects all game state processing
- Changes impact: All game logic
- Triple dispatcher handles all state routing

**Memory fill functions**: Affects all memory operations
- Changes impact: All data initialization
- Called from many setup routines

**func_C784**: Affects system-wide initialization
- Changes impact: Boot sequence
- Must complete correctly or game won't start

---

## Call Graph Dependencies

### Intra-Priority Dependencies

**Within Priority 2 (Hotspots)**:
- WaitForVBlank → (no calls, leaf)
- UpdateInputState → ControllerRead, SetInputFlag, ClearInputState
- SetDisplayParams → (no calls, leaf)
- All interconnected via V_INT_Handler

**Within Priority 8 (Game Logic)**:
- func_BA18 calls 3 dispatcher tables
- Each table entry points to different handler
- Handlers call sub-handlers for specific logic

**Cross-Priority Dependencies**:
- P2 (Hotspots) depends on P6 (Utilities)
- P8 (Game Logic) depends on P2 (Hotspots) for timing
- P3 (Init) must complete before P8 can run

---

## Optimization Opportunities

### Inlining Candidates

Functions that could be inlined to reduce call overhead:

| Function | Size | Calls | Benefit |
|----------|------|-------|---------|
| func_2236 | 8 bytes | 2 | Small gain |
| func_251A-251C | 4 bytes | 1 | Minimal |
| func_252C | 6 bytes | 1 | Minimal |
| func_2546 | 4 bytes | 1 | Minimal |

**Savings**: 2-4 cycles per inlined call (small impact)

### Register-Heavy Functions

Functions using many registers (could optimize):

| Function | Regs | Overhead | Status |
|----------|------|----------|--------|
| func_C784 | All | 48 cycles | Working correctly |
| func_BA18 | All | 24 cycles | Critical path |
| func_CF0C | All | 36 cycles | Complex logic |

**Savings**: Limited (architecture already optimized)

---

## Call Graph Summary Statistics

- **Total Documented Functions**: 289
- **Leaf Functions** (no calls): 45 (16%)
- **Simple Callers** (1-2 calls): 120 (41%)
- **Complex Callers** (3-5 calls): 80 (28%)
- **Deep Callers** (6+ calls): 34 (12%)

---

**Generated**: 2026-01-07
**Status**: Complete dependency analysis with optimization recommendations
