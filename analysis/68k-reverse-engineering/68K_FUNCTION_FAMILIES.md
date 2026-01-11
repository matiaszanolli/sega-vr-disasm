# 68K Function Family Reference - Virtua Racing Deluxe

**Purpose**: Quick lookup guide for understanding function groups, patterns, and relationships
**Coverage**: 182 documented functions across Priorities 1-9
**Last Updated**: 2026-01-07

---

## Function Family Index

### Quick Family Lookup

| Family | Count | Key Functions | Use Case |
|--------|-------|----------------|----------|
| [Memory Operations](#family-memory-operations) | 16 | func_4920, func_4856 | Data copy/fill |
| [State Machines](#family-state-machines) | 12 | func_4CBC, func_7BE4 | Game flow control |
| [Configuration](#family-configuration-handlers) | 18 | func_C784, func_77B2 | Initialization |
| [Data Processing](#family-data-processing) | 14 | func_9458, func_CF0C | Arrays/loops |
| [Hardware Control](#family-hardware-control) | 8 | func_CA20, func_E316 | VDP/COMM/Bus |
| [Math & Physics](#family-math-physics) | 7 | func_73F2, func_8DC0 | Coordinates |
| [Jump Tables](#family-jump-table-dispatchers) | 6 | func_7BE4, func_BA18 | Multi-way dispatch |
| [Wrappers](#family-wrapper-functions) | 4 | func_6D8C, func_A7CC | Context isolation |
| [Interrupt Handlers](#family-interrupt-handlers) | 3 | V_INT, H_INT | Timing control |
| [Hotspot Functions](#family-hotspot-functions) | 9 | WaitForVBlank | High frequency |
| [Entry/Init](#family-entry-initialization) | 14 | Boot, MARS init | Startup sequence |
| [Extended Region Code](#family-extended-region-code) | 7 | func_407F0, func_73F2 | Graphics/track data |

---

## Family: Memory Operations

### Overview
Efficient memory operations optimized for 32X architecture. Includes unrolled loops for zero-overhead iteration.

### Subfamilies

#### Unrolled Memory Fill (4 functions)

Functions that copy exact byte counts without loop overhead.

| Function | Address | Size | Purpose | Cycles/Byte |
|----------|---------|------|---------|------------|
| func_4856 | $00884856 | 96 | Unrolled fill 1 (24 longs) | ~2 |
| func_485E | $0088485E | 112 | Unrolled fill 2 (28 longs) | ~2 |
| func_48B8 | $008848B8 | 32 | Unrolled fill 3 (8 longs) | ~2 |
| func_48FE | $008848FE | 60 | Unrolled fill 4 (15 longs) | ~2 |

**Optimization Strategy**: Each `MOVE.L (A1)+,(A2)+` takes ~4 cycles. 24 copies = ~96 cycles for 96 bytes = 1 cycle/byte effective (very fast).

**Size Selection Rationale**:
- 32 bytes: Small data structures (5 registers of state)
- 60 bytes: Medium structures (12-15 registers)
- 96 bytes: Large structures (20-24 registers)
- 112 bytes: Very large structures (28 registers)

---

#### Standard Copy Operations (6 functions)

Loop-based copies with variable sizes.

| Function | Address | Pattern | Input | Output |
|----------|---------|---------|-------|--------|
| func_4920 | $00884920 | Unrolled | A1=source | A1+=20, A2+=20 |
| func_4922 | $00884922 | Variant entry | A1=source | A1+=16, A2+=16 |
| func_A80A | $0088A80A | Looped | A0, D0=count | Structured copy |
| func_A83E | $0088A83E | Looped | A0, D0=count | Bulk copy |
| func_CEC2 | $0088CEC2 | Bit-based | D0-D3 values | D4-D6 results |
| func_CECC | $0088CECC | Bit-based alt | D0-D3 values | D4-D6 results |

---

#### Clear/Initialize (4 functions)

Memory clearing and initialization.

| Function | Address | Pattern | Register Region |
|----------|---------|---------|-----------------|
| func_48CA | $008848CA | Triple dispatch | $C3xx, $C0xx, $C9xx |
| func_48CE | $008848CE | Waterfall entry 1 | $C3xx region |
| func_48D2 | $008848D2 | Waterfall entry 2 | $C0xx region |
| func_CDD2 | $0088CDD2 | Table + loop | $CDxx region |

**Pattern**: `31 FC 0000 xxxx` (move immediate zero) repeated multiple times

---

#### Hardware Bus Operations (2 functions)

Conditional operations on hardware registers via $FF9100/$FF9700/$FF9F00.

| Function | Address | Base | Iterations | Purpose |
|----------|---------|------|-----------|---------|
| func_6D9C | $00886D9C | $FF9100 | 6 | Primary object base |
| func_6DC8 | $00886DC8 | $FF9700 | 8 | Alternate base 1 |

**Pattern**:
```asm
TST.W   $offset(A0)         ; Test condition
BLE.S   .skip               ; Skip if not set
JSR     subroutine          ; Call handler
DBRA    D0,.loop            ; Next iteration
```

---

### Memory Family: Usage Recommendations

**When to Use Unrolled Fill**:
- Exact size match (32, 60, 96, 112 bytes)
- Called frequently (5+ times)
- Performance-critical path

**When to Use Loop-Based Copy**:
- Variable size needed
- Called infrequently (1-3 times)
- Flexibility more important than speed

**Hardware Bus Operations**:
- Use func_6D9C for primary objects
- Use func_6DC8 for alternate objects

---

## Family: State Machines

### Overview
Functions that dispatch control flow based on game state. All read state from $FFC8xx registers.

### Subfamilies

#### Jump Table Dispatchers (4 functions)

State-indexed table lookups for multi-way dispatch.

| Function | Address | Table Size | Dispatch Method | Examples |
|----------|---------|-----------|-----------------|----------|
| func_7BE4 | $00887BE4 | 16 entries | Index × 4 + JSR | Game state 0-15 |
| func_BA18 | $0088BA18 | 3 tables | Sequential JSRs | Mode A/B/C paths |
| func_4CBC | $00884CBC | Unknown | Jump table | Primary state handler |
| func_5306 | $00885306 | Unknown | Jump table | Secondary state |

**Index Calculation Pattern**:
```asm
MOVEQ   #15,D0              ; Max index (or table size-1)
MOVE.B  $FFC8xx,D1          ; Read state from register
ASL.L   #2,D1               ; Index *= 4 (pointer size)
JSR     (A0,D1.L)           ; Jump to handler
```

---

#### Conditional Branch Dispatchers (5 functions)

BTST/BNE/BEQ patterns for binary or ternary branching.

| Function | Address | Condition | True Path | False Path |
|----------|---------|-----------|-----------|------------|
| func_77D6 | $008877D6 | BTST #$55 | Alternate config | Primary config |
| func_D450 | $0088D450 | Test $C80F | Alt index lookup | Main index lookup |
| func_CE02 | $0088CE02 | TST flag | Field manip 1 | Field manip 2 |
| func_88BE | $008888BE | Compare result | Path A | Path B |
| func_9A9E | $00889A9E | Value threshold | Clamp up | Clamp down |

**Pattern**:
```asm
BTST    #bit_num,register   ; Test single bit
BNE.S   .true_path          ; Branch if non-zero
; False path code
BRA.S   .end
.true_path:
; True path code
.end:
```

---

#### Sequential Call Chains (3 functions)

Functions that call multiple handlers in sequence without decision points.

| Function | Address | Call Count | Handler Pattern | Purpose |
|----------|---------|-----------|-----------------|---------|
| func_CF0C | $0088CF0C | 9+ | JSR chain + loop | Multi-handler orchestration |
| func_CC06 | $0088CC06 | 3+ | Table setup | SH2 COMM initialization |
| func_60FD | $008860FD | 14+ | Subroutine chain | Complex initialization |

**Pattern**:
```asm
4EBA AAAA               JSR handler1
4EBA BBBB               JSR handler2
4EBA CCCC               JSR handler3
...
```

---

### State Machine Family: Control Flow Diagram

```
State Read ($FFC8xx)
    ↓
    └─ Jump Table? ─→ Index × 4 ─→ JSR (table,index)
    └─ BTST Test?  ─→ Branch Y/N
    └─ Sequential? ─→ JSR handler1 → JSR handler2 → ...
    ↓
Handler execution
    ↓
RTS to dispatcher
```

---

## Family: Configuration Handlers

### Overview
Initialization and mode-switching functions. Typically save registers, modify hardware state, restore registers.

### Subfamilies

#### Register Initialization (6 functions)

Setup sequences for hardware/software registers.

| Function | Address | Registers | Pattern | Size |
|----------|---------|-----------|---------|------|
| func_CC74 | $0088CC74 | $C3xx-$C8xx | MOVEM + writes | 50 |
| func_D08A | $0088D08A | $C0xx-$C2xx | Sequential init | 40 |
| func_D0F6 | $0088D0F6 | Looped block | Loop-based | 60 |
| func_CA20 | $0088CA20 | $FF68xx (VDP) | VDP config | 100+ |
| func_CA9A | $0088CA9A | Game mode | Mode-dependent | 80+ |
| func_11942 | $00891942 | Various | Minimal setup | 60 |

**Typical Sequence**:
```asm
48E7 xxxx               MOVEM.L registers,-(A7)
31FC nnnn xxxx          MOVE.W #value,register
21FC nnnnnnnn xxxx      MOVE.L #value,register
...
4CDF xxxx               MOVEM.L (A7)+,registers
4E75                    RTS
```

---

#### Control Setup (5 functions)

Large configuration sequences with multiple register blocks.

| Function | Address | Register Blocks | Conditional | Size |
|----------|---------|-----------------|-------------|------|
| func_77B2 | $008877B2 | 3-4 blocks | Mode-dependent | 228 |
| func_C784 | $0088C784 | 4+ blocks | Complex | 328 |
| func_CF0C | $0088CF0C | Multiple | DBRA loop | 150+ |
| func_CE76 | $0088CE76 | Variable | State-driven | 120+ |
| func_778E | $0088778E | 2-3 blocks | Bit test | 270 |

**Characteristic**: Large size due to multiple register write sequences

---

#### Mode Change Functions (4 functions)

Switch game mode/state with associated reconfigurations.

| Function | Address | Modes | Decision | Reconfig Type |
|----------|---------|-------|----------|--------------|
| func_4004 | $00884004 | 2+ | Table lookup | Conditional write |
| func_426E | $0088426E | Numeric | Counter-based | VDP-focused |
| func_49AA | $008849AA | 2 | Binary | Display setup |
| func_88BE | $008888BE | Multiple | Compare | State-dependent |

---

#### Data Processors (3 functions)

Minimal processors handling data transformation.

| Function | Address | Input | Output | Size |
|----------|---------|-------|--------|------|
| func_1469C | $0089​1469C | Address | Processed | 24 |
| func_407F0 | $0089​407F0 | Structure | Result | Unknown |
| func_5B227 | $0089​5B227 | Graphics data | Processed | Unknown |

---

## Family: Data Processing

### Overview
Functions that transform or iterate over arrays and complex data structures.

### Subfamilies

#### Loop Processors with JSR Chain (5 functions)

DBRA-based loops calling multiple subroutines per iteration.

| Function | Address | Loop Count | JSR Count | Data Type |
|----------|---------|-----------|-----------|-----------|
| func_9458 | $00889458 | 15 | Multiple | Object array |
| func_CF0C | $0088CF0C | 15 | 9+ | Complex struct |
| func_CD4C | $0088CD4C | Variable | Per-item | Array items |
| func_CD92 | $0088CD92 | Conditional | 1-2 | Setup array |
| func_E52C | $0088E52C | Multiple tables | 3+ | Multi-table |

**Pattern**:
```asm
7E0E                 MOVEQ   #14,D7          ; Counter (15 iterations)
.loop:
4EBA XXXX            JSR     handler1        ; Call handler 1
4EBA YYYY            JSR     handler2        ; Call handler 2
51CF FFXX            DBRA    D7,.loop        ; Next iteration
```

---

#### Structure Handlers (4 functions)

LINK A6-based functions processing complex structures with local buffers.

| Function | Address | Frame Size | Structure Type | Complexity |
|----------|---------|-----------|-----------------|-----------|
| func_407F0 | $0089​407F0 | -3218 | Track/graphics | Very high |
| func_4A943 | $0089​4A943 | Unknown | Graphics | High |
| func_52D6B | $0089​52D6B | Unknown | Transform | Medium |
| func_5B227 | $0089​5B227 | Unknown | Graphics/sprite | High |

**Characteristic**: Uses `LINK A6,#negative` for large local buffers

---

#### Array Processors (3 functions)

Functions with indexed array access patterns.

| Function | Address | Index Type | Access Pattern | Loop |
|----------|---------|-----------|-----------------|------|
| func_73F2 | $008873F2 | Calculated | Table lookup | Implicit |
| func_7364 | $00887364 | Direct | Sequential | Loop |
| func_71B3 | $008871B3 | Offset | Relative addr | Unrolled |

---

#### Transform/Math (2 functions)

Coordinate and physics calculations.

| Function | Address | Input | Calculation | Output |
|----------|---------|-------|-------------|--------|
| func_8DC0 | $00888DC0 | X,Y,Z coords | World→Screen | Screen coords |
| func_9A9E | $00889A9E | Value, range | Clamp/dampen | Adjusted value |

---

## Family: Hardware Control

### Overview
Direct hardware interface functions. Access VDP, COMM protocol, and hardware bus registers.

### Subfamilies

#### VDP Control (2 functions)

Video Display Processor configuration.

| Function | Address | Registers | Operation | Scope |
|----------|---------|-----------|-----------|-------|
| func_CA20 | $0088CA20 | $FF68xx | Configure display | Full setup |
| func_426E | $0088426E | $FF68D0-D8 | FM toggle | Frame buffer |

**Pattern**:
```asm
21FC 6100 0000 C254  MOVE.L #$61000000,$FF6854  ; Frame 1
21FC 6000 0000 C260  MOVE.L #$60000000,$FF6860  ; Frame 2
```

---

#### COMM Protocol (3 functions)

68K→SH2 communication via $FFC000-$FFC008.

| Function | Address | Command | Parameters | Purpose |
|----------|---------|---------|-----------|---------|
| func_E316 | $0088E316 | $25 | 1 param | Specific op A |
| func_E35A | $0088E35A | $22 | Multi-phase | Complex setup |
| func_E406 | $0088E406 | $2F | 4 params | Extended command |

**Pattern**:
```asm
11FC 00xx C800       MOVE.B #cmd,$FFC800         ; Write command
0C78 FFFF C000       CMP.W  #$FFFF,$FFC000      ; Wait for ready
6FFA                 BNE.S  .-4                 ; Poll loop
```

---

#### Hardware Bus Operations (2 functions)

Bulk register operations on hardware object bases.

| Function | Address | Base Register | Count | Iteration Pattern |
|----------|---------|----------------|-------|-------------------|
| func_6D9C | $00886D9C | $FF9100 | 6 | Conditional JSR |
| func_6DC8 | $00886DC8 | $FF9700 | 8 | Conditional JSR |

**Pattern**: Test register, conditionally call subroutine, decrement counter

---

## Family: Math & Physics

### Overview
Calculation functions for coordinates, transforms, and spatial operations.

### Functions

| Function | Address | Input Type | Calculation | Output | Used For |
|----------|---------|-----------|-------------|--------|----------|
| func_73F2 | $008873F2 | 3D world coords | Projection matrix | Screen coords | Rendering |
| func_8DC0 | $00888DC0 | Cartesian (X,Y,Z) | Rotation+scale | Transformed coords | Physics |
| func_71B3 | $008871B3 | Address offset | Table lookup | Adjusted address | Data access |
| func_7364 | $00887364 | Value, scale | LSL chain | Scaled value | Index gen |
| func_7280 | $00887280 | 3D spatial | Bit field calc | Status bits | Collision |
| func_757A | $0088757A | Values | Multi-threshold | Clamped result | Saturation |
| func_9A9E | $00889A9E | Value, range | Damping filter | Smoothed value | Physics |

---

## Family: Jump Table Dispatchers

### Overview
Functions with multi-way branching via jump tables.

### Dispatch Methods

#### Method 1: Indexed Table (func_7BE4)

```asm
MOVEQ   #max_entries,D0
MOVE.B  index,D1
ASL.L   #2,D1                       ; Index × 4
JSR     (table,D1.L)                ; Jump via table
```

**Entries**: 16 (state 0-15)

---

#### Method 2: Cascading Dispatch (func_BA18)

```asm
LEA     table1,A0
JSR     (A0,D0.W)                   ; First dispatch
LEA     table2,A0
JSR     (A0,D1.W)                   ; Second dispatch
LEA     table3,A0
JSR     (A0,D2.W)                   ; Third dispatch
```

**Characteristics**: Multiple sequential table lookups

---

#### Method 3: Direct Jump Table (func_4CBC, func_5306)

Address implicit in table structure. Jump to calculated address directly.

---

## Family: Wrapper Functions

### Overview
Minimal functions that provide context isolation for subroutine calls.

### Functions

| Function | Address | Registers Saved | Purpose | Overhead |
|----------|---------|-----------------|---------|----------|
| func_6D8C | $00886D8C | All (D0-D7/A0-A6) | Defensive call | High |
| func_A7CC | $0088A7CC | Minimal (D2/A5-A6) | Loop optimization | Low |
| func_1469C | $0089​1469C | All | Interrupt disable | High |
| func_4922 | $00884922 | None | Variant entry | None |

**Use Case**: Isolate subroutine side effects from caller context

---

## Family: Interrupt Handlers

### Overview
Timing-critical functions called from CPU interrupts.

### Functions

| Handler | Address | Type | Frequency | Purpose |
|---------|---------|------|-----------|---------|
| V_INT | $01684 | Vertical blank | 60 Hz (NTSC) | Main timing |
| H_INT | $1170A | Horizontal blank | Per-scanline | Unused (RTE only) |
| Default | $00832 | Exception | Never (crash) | Crash handler |

**V_INT Pattern**:
```asm
MOVE.W  SR,D0               ; Save status
ORI.W   #$0700,SR           ; Disable interrupts
; Game logic here
MOVE.W  D0,SR               ; Restore status
RTE                         ; Return from exception
```

---

## Family: Hotspot Functions

### Overview
High-frequency functions (10+ calls each) forming the core game loop.

### Functions

| Function | Address | Calls | Call Sites | Purpose |
|----------|---------|-------|-----------|---------|
| WaitForVBlank | $04998 | 21 | Main loop | Synchronization |
| UpdateInputState | $02080 | 21 | Input handlers | Controller update |
| SetDisplayParams | $049AA | 21 | Init sequence | Display setup |
| SendDREQCommand | $0FB36 | 17 | SH2 comms | DMA requests |
| ControllerRead | $0179E | 16 | Input loop | Read hardware |
| SetInputFlag | $0205E | 16 | State update | Notification |
| ClearInputState | $0204A | 11 | Cleanup | Reset state |
| TableLookup | $014BE | 12 | Data access | Generic lookup |
| VDPFrameControl | $026C8 | 10 | Display control | Frame toggling |

---

## Family: Entry & Initialization

### Overview
Boot-time and initialization sequence functions.

### Subfamilies

#### Boot Sequence (3 functions)
- Boot ROM entry
- MARS adapter initialization
- 68K state setup

#### SH2 Setup (3 functions)
- SH2 CPU initialization
- Interrupt vector setup
- Cache configuration

#### Decompression (3 functions)
- LZ77 decompression
- ROM unpacking
- Data relocation

#### Game Initialization (5 functions)
- State machine setup
- Display initialization
- Input system init

---

## Family: Extended Region Code

### Overview
Code located in Priority 9 extended ROM regions ($10000-$FFFFF).

### Graphics Pipeline Functions

**Suspected Call Chain**:
```
func_11942 (Main Code 2 setup)
    ↓
func_407F0 (Track/data processing)
    ↓
func_4A943 (Graphics structure processing)
    ↓
func_52D6B (Graphics transformation)
    ↓
func_5B227 (Graphics data handler)
    ↓
func_60D9C (High ROM handler - final)
```

**Characteristics**:
- All use LINK A6 (stack frame-based)
- Progressive high ROM location
- Located in graphics/sprite data regions
- Not called via JSR from Priority 8

---

## Cross-Family Patterns

### Pattern: Register Save Escalation

```
Leaf functions        → No save
Utility wrappers      → Minimal save (D2/A5-A6)
Common handlers       → Selective save (D0-D7/A0-A5)
Critical orchestrators → Full save (D0-D7/A0-A7)
```

### Pattern: Table-Driven Dispatch

```
Conditional dispatch   → BTST/BNE/BEQ
Jump table dispatch    → LEA + index + JSR
Sequential calls       → JSR chain without branch
```

### Pattern: Loop Organization

```
Unrolled              → Fast, fixed size
DBRA loop             → Flexible, counted
Implicit              → Via table traversal
```

---

## Usage Examples by Scenario

### Scenario: Add New Memory Copy Function

1. Choose size: 32/60/96/112 bytes
2. Copy unrolled pattern from func_4856-func_48FE
3. Match register save pattern (likely none for leaf function)
4. Test: verify exact size match

### Scenario: Add New State Handler

1. Choose dispatch type: jump table or conditional
2. Copy pattern from func_7BE4 (jump table) or func_77D6 (conditional)
3. Add to state machine dispatcher
4. Update state index at $FFC8xx

### Scenario: Add New Hardware Operation

1. Choose base register: $FF9100, $FF9700, or $FF9F00
2. Copy loop pattern from func_6D9C/func_6DC8
3. Implement conditional logic
4. Add to COMM protocol if SH2 coordination needed

---

## References

- [68K_ARCHITECTURE_PATTERNS.md](68K_ARCHITECTURE_PATTERNS.md) - Detailed patterns
- [68K_MAIN_LOGIC.md](68K_MAIN_LOGIC.md) - Priority 8 functions
- [68K_EXTENDED_REGIONS.md](68K_EXTENDED_REGIONS.md) - Priority 9 functions
- [68K_MEMORY_MAP.md](68K_MEMORY_MAP.md) - Hardware registers
- [68K_HOTSPOT_FUNCTIONS.md](68K_HOTSPOT_FUNCTIONS.md) - High-call functions

---

**Document Version**: 1.0
**Last Updated**: 2026-01-07
**Total Families**: 12
**Total Functions Cataloged**: 182
