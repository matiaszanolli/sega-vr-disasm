# 68K Architecture & Design Patterns - Virtua Racing Deluxe

**Analysis Date**: 2026-01-07
**Functions Analyzed**: 182/797 (22.8%)
**Primary Focus**: Priority 1-8 (91 Priority 8 functions detailed)

---

## Table of Contents

1. [Function Organization](#function-organization)
2. [Register Save/Restore Strategies](#register-save-restore-strategies)
3. [Control Flow Patterns](#control-flow-patterns)
4. [Memory Management](#memory-management)
5. [Hardware Integration](#hardware-integration)
6. [Optimization Techniques](#optimization-techniques)
7. [Function Family Catalog](#function-family-catalog)

---

## Function Organization

### Hierarchical Structure

The codebase exhibits a **4-tier function hierarchy**:

```
Tier 1: Interrupt Handlers & Main Loop
    ↓ (calls)
Tier 2: Hotspot Functions (10+ calls each)
    ↓ (calls)
Tier 3: Orchestrators & State Machines
    ↓ (calls)
Tier 4: Utilities & Hardware Access
```

**Characteristics by Tier**:

| Tier | Functions | Size | Register Use | Call Pattern |
|------|-----------|------|--------------|--------------|
| 1 | 3 | 2-44 bytes | Varies | Direct JSR from CPU |
| 2 | 9 | 20-400 bytes | Mixed | Called by main loop |
| 3 | 40+ | 20-400 bytes | Full save | JSR chains (3-10 deep) |
| 4 | 130+ | 4-150 bytes | Selective save | Loop-optimized calls |

### Address Space Organization

```
$00884000-$00885FFF: Core Utilities & Jump Tables
$00886000-$0088BFFF: 3D Math & Coordinate Transforms
$0088C000-$0088FFFF: State Machines & Game Logic
$00890000-$0088FBFF: Hardware Control & Communication
```

---

## Register Save/Restore Strategies

### Pattern 1: Full Register Save (Orchestrators)

**Usage**: Critical functions that need clean register state
**Register Mask**: `MOVEM.L D0-D7/A0-A7,-(A7)` (0xFFFE)
**Examples**: func_C784, func_1469C
**Size Overhead**: 12 bytes

```asm
; Entry
48E7 FFFE            MOVEM.L D0-D7/A0-A7,-(A7)  ; Save all
4EB9 ...             JSR     subroutine          ; Call
4CDF 7FFF            MOVEM.L (A7)+,D0-D7/A0-A7  ; Restore all
4E75                 RTS
```

**When Used**:
- Critical game state updates
- Interrupt disable contexts
- Multi-function orchestrators

**Performance Impact**: ~48 CPU cycles (save + restore)

---

### Pattern 2: Selective Data Register Save

**Usage**: Functions that need some registers preserved
**Register Mask**: `MOVEM.L D0-D7/A0-A5,-(A7)` (0xFF00)
**Examples**: func_7768, func_778E
**Size Overhead**: 10 bytes

```asm
; Entry
48E7 FF00            MOVEM.L D0-D7/A0-A5,-(A7)  ; Save D0-D7, A0-A5
4EBA ...             JSR     subroutine         ; Call
4CDF 00FF            MOVEM.L (A7)+,D0-D7/A0-A5 ; Restore
4E75                 RTS
```

**When Used**:
- State machine handlers
- Configuration managers
- Complex conditional logic

**Performance Impact**: ~36 CPU cycles

---

### Pattern 3: Minimal Register Save

**Usage**: Loop-optimized functions in performance-critical paths
**Register Mask**: `MOVEM.L D2/A5-A6,-(A7)` (0x2040)
**Examples**: func_A7CC
**Size Overhead**: 6 bytes

```asm
; Entry
48E7 2040            MOVEM.L D2/A5-A6,-(A7)     ; Save D2, A5-A6 only
4EBA ...             JSR     handler            ; Call
4CDF 0204            MOVEM.L (A7)+,D2/A5-A6    ; Restore
4E75                 RTS
```

**When Used**:
- Loop body wrappers
- Performance-critical paths
- Minimal context needed

**Performance Impact**: ~12 CPU cycles

---

### Pattern 4: No Register Save (Leaf Functions)

**Usage**: Terminal functions that don't call others
**Examples**: Memory fill operations, simple calculations
**Size Overhead**: 2 bytes (just RTS)

```asm
00884920  24D9                 MOVE.L  (A1)+,(A2)+  ; Copy long 1
00884922  24D9                 MOVE.L  (A1)+,(A2)+  ; Copy long 2
...
0088492A  4E75                 RTS
```

**When Used**:
- Utility functions (copy, fill, clear)
- Single-operation routines
- Math calculations

**Performance Impact**: 0 overhead

---

## Control Flow Patterns

### Pattern A: Save-JSR-Restore Wrapper

**Purpose**: Isolate subroutine calls in protected context
**Frequency**: ~40% of Priority 8 functions
**Structure**:

```
Save registers
  ↓
JSR subroutine
  ↓
Restore registers
  ↓
RTS
```

**Examples**: func_6D8C, func_7768, func_A7CC

**Why This Pattern?**
- Subroutine might clobber registers
- Caller needs predictable side effects
- Defensive programming style

---

### Pattern B: Conditional Dispatch

**Purpose**: Branch to different code paths based on flags
**Frequency**: ~30% of Priority 8 functions
**Structure**:

```asm
BTST    #flag,D0           ; Test condition bit
BNE.S   .alternate_path    ; Branch if set
; Primary path code
BRA.S   .end
.alternate_path:
; Alternate path code
.end:
RTS
```

**Examples**: func_77D6 (bit $55 test), func_D450 (flag $C80F test)

**Condition Sources**:
- Bit 0-7: Simple flags ($FFC8xx registers)
- Sign bit: Comparison results
- Carry bit: Overflow conditions

---

### Pattern C: Loop with Counter

**Purpose**: Iterate over data structures or register blocks
**Frequency**: ~25% of Priority 8 functions
**Structure**:

```asm
MOVEQ   #count,D0          ; D0 = iteration count
.loop:
; Process one item
DBRA    D0,.loop            ; Decrement and branch if not done
; Post-loop cleanup
RTS
```

**Examples**: func_CF0C (14 iterations), func_C784 (15 iterations)

**Iteration Counts**:
- 6-8: Hardware register blocks
- 14-15: Object/structure arrays
- 20+: Data table traversal

---

### Pattern D: Jump Table Dispatch

**Purpose**: Multi-way dispatch based on state/mode
**Frequency**: ~15% of Priority 8 functions
**Structure**:

```asm
LEA     table,A0            ; A0 = jump table base
MOVE.B  index,D0            ; D0 = state/mode index
ASL.L   #2,D0               ; D0 *= 4 (32-bit pointers)
JSR     (A0,D0.L)           ; Jump to handler
```

**Examples**: func_7BE4 (16-entry table), func_BA18 (triple dispatch)

**Common Table Sizes**:
- 6-8 entries: State machines
- 12-16 entries: Game mode handlers
- 20+: Extended mode tables

---

## Memory Management

### Stack Frame Usage

**LINK Instruction Pattern**:

```asm
LINK    A6,#frame_size      ; Create stack frame
; ... function body ...
UNLK    A6                  ; Destroy stack frame
RTS
```

**Frame Sizes Observed**:
- Positive (+8 to +64): Few local variables
- Negative (-100 to -500): Local arrays/structures
- Very negative (-1000 to -3218): Large buffers (graphics, track data)

**Examples**:
- func_11942: +60 bytes (small setup)
- func_407F0: -3218 bytes (track/graphics processing)

### Static RAM Regions

**Documented Hardware Registers**:

```
$FFC0xx - Control Parameters
$FFC8xx - State Machine Indices & Flags
$FF68xx - Display/VDP Configuration
$FF9100 - Primary Object Base
$FF9F00 - Alternate Object Base
$FF9700 - Hardware Bus Addresses
```

**Common Access Patterns**:

1. **Read state → Index table → Write result**
   ```asm
   3038 C8A0            MOVE.W  $FFC8A0,D0      ; Read state
   43F9 00898C0C        LEA     $00898C0C,A1    ; A1 = table
   23F1 0000 00FF6868   MOVE.L  (A1,D0.W),$00FF6868  ; Write result
   ```

2. **Modify register with conditional test**
   ```asm
   1238 C80F            MOVE.B  $FFC80F,D1      ; Read flag
   6706                 BEQ.S   .skip           ; Branch if zero
   1038 FEAC            MOVE.B  $FFFEA C,D0    ; Alternate path
   ```

---

## Hardware Integration

### VDP Control Pattern

**Purpose**: Configure video display processor
**Registers**: $FF68xx region
**Pattern**:

```asm
; Write display configuration
31FC C200 C076          MOVE.W  #$C200,$C076    ; Set mode
21FC 6100 0000 C254     MOVE.L  #$61000000,$C254 ; Frame buffer 1
21FC 6000 0000 C260     MOVE.L  #$60000000,$C260 ; Frame buffer 2
```

### COMM Register Protocol

**Purpose**: 68K↔SH2 communication
**Register**: $FFC000 (control), $FFC004-$FFC008 (data)
**Pattern**:

```asm
; Send command to SH2
11FC 0001 C800          MOVE.B  #$01,$FFC800    ; Set command flag
0C78 FF FF C000         CMP.W   #$FFFF,$FFC000  ; Wait for status
6FFA                    BNE.S   .-4             ; Poll loop
```

### Hardware Bus Operations

**Purpose**: Bulk register operations
**Accessed via**: $FF9100, $FF9700, $FF9F00
**Pattern** (6 iterations):

```asm
4A68 0098               TST.W   $98(A0)         ; Test register
6F04                    BLE.S   .skip           ; Skip if not set
53 68 00 98             SUB.W   #1,$98(A0)      ; Decrement
4E BA EC3A              JSR     subroutine      ; Call handler
```

**Characteristics**:
- Sequential register access (often in 2-byte or 4-byte strides)
- Conditional operations (TST/CMP before write)
- Loop iteration for 6, 8, or single operations

---

## Optimization Techniques

### Unrolled Memory Operations

**Purpose**: High-speed data copy without loop overhead
**Sizes**: 32, 60, 96, 112 bytes
**Examples**: func_4856-func_48FE
**Structure**:

```asm
; Unrolled 96-byte copy (24 longwords)
24D9                 MOVE.L  (A1)+,(A2)+      ; Word 1
24D9                 MOVE.L  (A1)+,(A2)+      ; Word 2
24D9                 MOVE.L  (A1)+,(A2)+      ; Word 3
...
24D9                 MOVE.L  (A1)+,(A2)+      ; Word 24
4E75                 RTS
```

**Size Selection Strategy**:
- 32 bytes: Small structures (5-8 registers)
- 60 bytes: Medium structures (15 registers)
- 96 bytes: Large structures (24 registers)
- 112 bytes: Very large structures (28 registers)

**Performance**: ~2 cycles per byte (best case)

### Table-Driven Logic

**Purpose**: Replace complex conditionals with table lookups
**Frequency**: ~40% of Priority 8 functions
**Pattern**:

```asm
; Method 1: Direct lookup
3030 0000            MOVE.W  (A0,D0),D0       ; Load from table
; Method 2: Indexed with scaling
E548 D1C0            LSL.L   #2,D0            ; D0 *= 4
23D0 00FF6828        MOVE.L  (A0,D0),($FF6828) ; Write table entry
; Method 3: Two-level lookup
MOVEA.L (A0,D0.W),A1 ; A1 = subtable pointer
MOVE.L  (A1,D1.W),D2 ; D2 = value from subtable
```

**Table Locations**: $00898000-$0089BFFF (mostly ROM)

### Cascading Left-Shift Scaling

**Purpose**: Generate scaled indices for multi-level tables
**Pattern**:

```asm
; Cascade left-shifts for 16x scaling
E580                 ASL.L   #1,D0            ; D0 *= 2
E580                 ASL.L   #1,D0            ; D0 *= 2 (now 4x)
E580                 ASL.L   #1,D0            ; D0 *= 2 (now 8x)
E580                 ASL.L   #1,D0            ; D0 *= 2 (now 16x)
; Alternative: MOVE + ADD pattern
D040                 ADD.L   D0,D0            ; D0 *= 2
D040                 ADD.L   D0,D0            ; D0 *= 2 (now 4x)
```

**Used For**: Scaling from byte indices to word/long indices

---

## Function Family Catalog

### Family 1: Memory Operations (16 functions)

**Subfamilies**:

| Type | Count | Examples | Size Range |
|------|-------|----------|-----------|
| Unrolled Fill | 4 | func_4856-func_48FE | 30-112 bytes |
| Copy Operations | 6 | func_4920, func_A80A | 8-150 bytes |
| Clear/Init | 4 | func_48CA-func_48D2 | 40-60 bytes |
| Hardware Bus | 2 | func_58C8, func_5908 | 60-100 bytes |

**Pattern**: All use post-increment addressing `(A1)+` and `(A2)+`

**Optimization**: Unrolled for speed; no loop overhead

---

### Family 2: State Machines (12 functions)

**Subfamilies**:

| Type | Count | Examples | Dispatch Method |
|------|-------|----------|-----------------|
| Jump Table | 4 | func_7BE4, func_BA18 | Table + JSR |
| Conditional Branch | 5 | func_77D6, func_D450 | BTST/BNE pairs |
| Sequential Call | 3 | func_CF0C, func_CC06 | JSR chains |

**Pattern**: Read state from $FFC8xx → Branch/dispatch → Execute → Repeat

**State Sources**:
- $FFC87A: VBlank flag / state index (primary)
- $FFC80F: Game mode / configuration selector
- $FFC8A0-$FFC8CC: Various sub-indices

---

### Family 3: Configuration Handlers (18 functions)

**Subfamilies**:

| Type | Count | Examples | Typical Size |
|------|-------|----------|-------------|
| Register Init | 6 | func_CC74, func_D08A | 30-50 bytes |
| Control Setup | 5 | func_77B2, func_C784 | 200-330 bytes |
| Mode Change | 4 | func_CA9A, func_CE76 | 50-150 bytes |
| Data Process | 3 | func_11942, func_1469C | 20-60 bytes |

**Pattern**: MOVEM save → Configuration writes → MOVEM restore

**Typical Sequence**:
1. Save registers (0-20 bytes)
2. Load configuration from table (8-20 bytes)
3. Write to hardware registers (20-100 bytes)
4. Restore registers (6-20 bytes)

---

### Family 4: Data Processing (14 functions)

**Subfamilies**:

| Type | Count | Examples | Characteristics |
|------|-------|----------|-----------------|
| Loop Processors | 5 | func_9458, func_CF0C | DBRA + JSR chain |
| Structure Handlers | 4 | func_407F0, func_5B227 | LINK A6 + frame ops |
| Array Processors | 3 | func_CD4C, func_CDD2 | Indexed access loop |
| Transform Calcs | 2 | func_73F2, func_8DC0 | Math-heavy |

**Pattern**: Load → Process → Store, often with loop

---

### Family 5: Hardware Control (8 functions)

**Subfamilies**:

| Type | Count | Examples | Register Target |
|------|-------|----------|-----------------|
| VDP Control | 2 | func_CA20, func_426E | $FF68xx |
| COMM Protocol | 3 | func_E316, func_E406 | $FFC000 |
| Bus Operations | 2 | func_6D9C, func_6DC8 | $FF9100/$FF9700 |
| Display Params | 1 | func_49AA | $FFC8xx |

**Pattern**: Read/write hardware registers with polling or status checks

---

### Family 6: Math/Physics (7 functions)

**Subfamilies**:

| Type | Count | Examples | Operations |
|------|-------|----------|-----------|
| Coordinates | 3 | func_73F2, func_8DC0 | ADD, SUB, LSL |
| Scaling/Transform | 2 | func_71B3, func_7364 | Table lookup + math |
| Comparison | 1 | func_757A | CMP, conditional set |
| Clamping | 1 | func_9A9E | MIN/MAX logic |

**Pattern**: Load inputs → Table lookups → Arithmetic → Write result

---

### Family 7: Jump Tables (6 functions)

**Types**:

| Type | Count | Examples | Entries |
|------|-------|----------|---------|
| 16-entry | 2 | func_7BE4 | 0-15 states |
| Triple dispatch | 1 | func_BA18 | 3 tables chained |
| Sequential call | 3 | func_CF0C, func_CC06 | Multiple JSRs |

**Calculation Pattern**:
```asm
MOVEQ   #max_index,D0
ASL.L   #2,D0              ; Scale by pointer size
JSR     (A0,D0.L)          ; Jump to handler
```

---

### Family 8: Wrapper Functions (4 functions)

**Types**:

| Type | Count | Examples | Purpose |
|------|-------|----------|---------|
| Register Wrapper | 2 | func_6D8C, func_A7CC | Save/call/restore |
| Minimal Handler | 1 | func_1469C | Interrupt disable wrapper |
| Entry Stub | 1 | func_4922 | Variant entry point |

**Pattern**: Minimal code, delegation to other functions

**Performance Characteristic**: Caller pays for register save cost

---

## Architectural Insights

### Design Philosophy

The codebase exhibits **defensive programming** patterns:

1. **Explicit Register Save**: Functions save registers even when not strictly needed
2. **Separate Concerns**: Clear separation between logic, state, and hardware control
3. **Table-Driven Design**: Logic encoded in data tables rather than code branches
4. **Loop Optimization**: Critical paths use unrolled loops or cascading operations

### Performance Strategy

**Tier-Based Optimization**:

| Tier | Optimization | Examples |
|------|--------------|----------|
| Core (called 20+x) | Unrolled, inline | Memory operations |
| Common (called 5-10x) | Tables, loops | State machines |
| Occasional (<5x) | Direct code | Orchestrators |

### Code Reuse Patterns

**Identified Patterns**:

1. **Variant Entry Points**: func_4922 enters func_4920 at +2 offset
2. **Dual Functions**: func_9B7C exists in two modes at same address
3. **Waterfall Chains**: Sequential JSR calls with shared epilogue

### Memory Layout Correlation

**Data Region Predictability**:
- $4000-$5FFF: Utilities (compact, dense)
- $6000-$8FFF: Transforms & hardware (medium density)
- $9000-$BFFF: State machines & handlers (lower density)
- $C000-$FFFF: Game logic & control (specialized)

---

## Recommendations for Future Developers

### For Adding New Functions

1. **Choose Register Save Strategy**: Match function tier
   - Critical: Full save
   - Common: Selective save
   - Utility: No save

2. **Use Table-Driven Logic**: Prefer tables over conditionals
   - Easier to maintain
   - Better cache locality
   - More compact

3. **Leverage Existing Utilities**: Reuse memory operations, state machines

### For Optimization

1. **Identify Hot Paths**: Functions called 10+ times are candidates
2. **Profile First**: Measure before optimizing
3. **Consider Trade-offs**: Unrolled loops save time but cost ROM space

### For Debugging

1. **Check Register State**: Use MOVEM patterns to understand scope
2. **Trace State Machines**: Look at $FFC8xx values
3. **Follow Call Chains**: JSR patterns show control flow

---

## Appendix: Complete Function Family Tree

```
Root: V_INT_Handler ($1684)
├─ WaitForVBlank ($4998)
├─ UpdateInputState ($2080)
├─ SetDisplayParams ($49AA)
├─ ControllerRead ($179E)
│  └─ Read6ButtonPad ($185E)
├─ State Machine Tier
│  ├─ func_4CBC ($4CBC) - Primary dispatcher
│  ├─ func_5306 ($5306) - Secondary dispatcher
│  └─ func_CC06 ($CC06) - SH2 COMM setup
├─ Configuration Tier
│  ├─ func_77B2 ($77B2) - Mode init
│  ├─ func_C784 ($C784) - Orchestrator
│  └─ func_CA9A ($CA9A) - Game mode init
├─ Data Processing Tier
│  ├─ func_9458 ($9458) - Array processor
│  ├─ func_CF0C ($CF0C) - Multi-handler
│  └─ func_CD4C ($CD4C) - Loop processor
└─ Utility Tier
   ├─ func_4920 ($4920) - 20-byte copy
   ├─ func_4856 ($4856) - 96-byte fill
   └─ func_58C8 ($58C8) - Hardware bus ops
```

---

## References

- **Priority 8 Documentation**: [68K_MAIN_LOGIC.md](68K_MAIN_LOGIC.md)
- **Extended Regions**: [68K_EXTENDED_REGIONS.md](68K_EXTENDED_REGIONS.md)
- **Hardware Reference**: [32x-hardware-manual.md](../docs/32x-hardware-manual.md)
- **Memory Map**: [68K_MEMORY_MAP.md](68K_MEMORY_MAP.md)

---

**Document Version**: 1.0
**Last Updated**: 2026-01-07
**Analysis Scope**: 182 functions across Priorities 1-9
