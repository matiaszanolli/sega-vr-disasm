# Priority 9 Call Graph and Interaction Map

**Date**: 2026-01-07
**Scope**: 54 Priority 9 functions (49 Main Code 2 + 5 Extended)

---

## Executive Summary

Priority 9 functions are **dispatcher handlers** called via the `func_BA18` triple dispatcher from Priority 8. They have minimal external dependencies and primarily operate as leaf or near-leaf functions.

**Key Findings**:
- **93.9%** of P9 functions have no register save (leaf-like)
- Only **5 external JSR targets** (3 core, 2 P8)
- **0 direct P9-to-P9 JSR calls** (only BSR to internal subroutines)
- Average function size: **39.7 bytes** (compact handlers)

---

## Call Graph Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                     PRIORITY 8 (Main Logic)                      │
│                                                                   │
│  func_BA18 (Triple Dispatcher)                                   │
│  ├─ Table 1 @ $14888 ──→ 16 handlers                            │
│  ├─ Table 2 @ $14C88 ──→ 16 handlers                            │
│  └─ Table 3 @ $15088 ──→ 16 handlers                            │
│                                                                   │
└───────────────────────────┬─────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────────┐
│                   PRIORITY 9 (Main Code 2)                       │
│                                                                   │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │ INITIALIZATION GROUP ($14438-$14540) - 8 functions       │   │
│  │                                                           │   │
│  │ func_14438 → func_14450 → func_1446C → ...               │   │
│  │ (Sequential execution via dispatcher, not direct calls)  │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                   │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │ HANDLER VARIANT GROUP ($1466A-$1473A) - 13 functions     │   │
│  │                                                           │   │
│  │ func_1466A, func_14696, func_1469C                       │   │
│  │ func_146B4, func_146BC, func_146CA → BSR internal        │   │
│  │ func_146DA → BSR internal, func_146EA → BSR internal     │   │
│  │ func_146FA → BSR internal, func_1470A → BSR internal     │   │
│  │ func_1471A → BSR internal, func_1472A → BSR internal     │   │
│  │ func_1473A → BSR internal                                │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                   │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │ STATE HANDLER GROUP ($1474A-$147C2) - 13 functions       │   │
│  │                                                           │   │
│  │ func_1474A, func_14754, func_1475E, func_14768           │   │
│  │ func_14772, func_1477C, func_14786, func_14790           │   │
│  │ func_1479A, func_147A4, func_147AE, func_147B8           │   │
│  │ func_147C2                                               │   │
│  │ (All leaf handlers - no calls)                           │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                   │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │ CORE HANDLER GROUP ($1480E-$14886) - 8 functions         │   │
│  │                                                           │   │
│  │ func_1480E, func_14816, func_1481E, func_14826           │   │
│  │ func_1482E, func_14848, func_14882, func_14884           │   │
│  │ func_14886 (most common BA18 handler)                    │   │
│  │ (All leaf handlers - no calls)                           │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                   │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │ HIGH HANDLER GROUP ($15494-$154D4) - 3 functions         │   │
│  │                                                           │   │
│  │ func_15494, func_154B4, func_154D4                       │   │
│  │ (Large handlers - 256+ bytes each)                       │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                   │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │ SPECIAL FUNCTIONS                                         │   │
│  │                                                           │   │
│  │ func_109AE: Early handler - JSR to P7/P8                 │   │
│  │ func_11942: Data processor - BSR internal subroutines    │   │
│  │ func_147E8: Mid-range handler                            │   │
│  └──────────────────────────────────────────────────────────┘   │
│                                                                   │
└─────────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────────┐
│                 EXTERNAL DEPENDENCIES                            │
│                                                                   │
│  ┌─ Core (P1-P7) ─────────────────────────────────────────────┐ │
│  │  $008814BE - TableLookup                                   │ │
│  │  $008826C8 - VDPFrameControl                               │ │
│  │  $00882890 - Unknown core function                         │ │
│  └────────────────────────────────────────────────────────────┘ │
│                                                                   │
│  ┌─ Priority 8 ───────────────────────────────────────────────┐ │
│  │  $008849AA - SetDisplayParams                              │ │
│  │  $0088D1D4 - Game state handler                            │ │
│  └────────────────────────────────────────────────────────────┘ │
│                                                                   │
└─────────────────────────────────────────────────────────────────┘
```

---

## Detailed Dependency Map

### Functions with External Calls

| Function | Address | Calls | Target | Purpose |
|----------|---------|-------|--------|---------|
| func_109AE | $008909AE | JSR | $008826C8 | VDP frame control |
| func_109AE | $008909AE | JSR | $008814BE | Table lookup |
| func_109AE | $008909AE | JSR | $008849AA | Display params (×2) |
| func_14540 | $00894540 | JMP | $00882890 | Tail call to core |
| func_14696 | $00894696 | JSR | $0088D1D4 | Game state dispatch |
| func_1469C | $0089469C | JSR | $0088D1D4 | Game state dispatch |

### Functions with Internal BSR

| Function | Address | BSR Target | Relationship |
|----------|---------|------------|--------------|
| func_11942 | $00891942 | $0089197E, $0089199A | Internal subroutines |
| func_146CA | $008946CA | $008946DC | Overlaps with func_146DA |
| func_146DA | $008946DA | $008946EC | Overlaps with func_146EA |
| func_146EA | $008946EA | $008946FE | Overlaps with func_146FA |
| func_146FA | $008946FA | $0089470E | Overlaps with func_1470A |
| func_1470A | $0089470A | $0089471C | Overlaps with func_1471A |
| func_1471A | $0089471A | $0089472C | Overlaps with func_1472A |
| func_1472A | $0089472A | $0089473E | Overlaps with func_1473A |
| func_1473A | $0089473A | $0089474E | Points to state handlers |

### Pure Leaf Functions (No Calls)

**33 functions** have zero JSR/BSR/JMP calls:

- func_14438, func_14450, func_1446C, func_144A8, func_144D0
- func_144F2, func_14518, func_1466A, func_146B4, func_146BC
- func_1474A through func_147C2 (13 state handlers)
- func_1480E through func_14886 (8 core handlers)
- func_15494, func_154B4, func_154D4

---

## Function Group Analysis

### Group 1: Initialization Handlers ($14438-$14540)

**Purpose**: Setup and configuration during game state transitions

```
func_14438 → Clear RAM locations, set mode flags
func_14450 → Load track data base address ($0090E732)
func_1446C → Initialize with lookup table
func_144A8 → Load alternate track data ($009286AE)
func_144D0 → Track data validation
func_144F2 → Setup secondary track data ($00929CA6)
func_14518 → Extended track initialization
func_14540 → Final init with JMP to core
```

**Common Pattern**: LEA to load addresses, MOVE to configure, RTS/JMP exit

### Group 2: Handler Variants ($1466A-$1473A)

**Purpose**: Increment/decrement operations on RAM locations

```
func_1466A → Clear multiple I/O registers ($FF68xx)
func_14696 → Full context save, call $0088D1D4
func_1469C → Full context save, call $0088D1D4
func_146B4 → Simple flag write
func_146BC → Bit set and RAM copy
func_146CA → Increment $C054, write to $FF0000, BSR
func_146DA → Decrement $C054, write to $FF0000, BSR
func_146EA → Increment $C056, write to $FF0000, BSR
func_146FA → Decrement $C056, write to $FF0000, BSR
func_1470A → Add $20 to $C054, write to $FF0000, BSR
func_1471A through func_1473A → Similar increment/BSR patterns
```

**Common Pattern**: MOVEQ immediate, arithmetic on RAM, BSR to shared code

### Group 3: State Handlers ($1474A-$147C2)

**Purpose**: Simple state machine handlers - likely race position/lap tracking

```
func_1474A through func_147C2:
All follow pattern:
  33FC xxxx yyyy  MOVE.W #value,($address)
  4E75           RTS
```

**Size**: 10 bytes each (identical structure)
**Pattern**: Direct RAM write, immediate return

### Group 4: Core Handlers ($1480E-$14886)

**Purpose**: Game state core operations

```
func_14882: 2-byte stub (possibly NOP or JMP)
func_14884: 2-byte stub
func_14886: 2-byte stub (most frequently used)
func_1480E-func_14848: 8-byte handlers
```

**Pattern**: Minimal code, likely state validation or pass-through

### Group 5: High Handlers ($15494-$154D4)

**Purpose**: Complex data processing

```
func_15494: 256+ bytes - complex data handler
func_154B4: 256+ bytes - complex data handler
func_154D4: 256+ bytes - complex data handler
```

**Pattern**: Large functions, likely graphics or physics calculations

---

## Interaction Patterns

### Pattern 1: Dispatcher Entry

All P9 functions are called exclusively via `func_BA18` dispatcher:

```
P8: func_BA18
    → Read state index from ($C87A)
    → Scale and lookup in table ($14888, $14C88, or $15088)
    → JSR to P9 handler
    → Return to P8
```

### Pattern 2: Chained BSR

Several handler variants use BSR to shared code:

```
func_146CA → BSR $146DC (inside func_146DA)
func_146DA → BSR $146EC (inside func_146EA)
...
func_1473A → BSR $1474E (near state handlers)
```

This creates a chain of related operations without direct function calls.

### Pattern 3: External Service Calls

Only 3 functions call external services:

```
func_109AE → VDP control, table lookup, display setup
func_14540 → Tail call to core (JMP, not JSR)
func_14696/func_1469C → Game state dispatch
```

---

## Call Frequency Analysis

### High-Frequency Handlers (Called Every Frame)

Based on dispatcher table analysis:

| Handler | Table Entries | Frequency |
|---------|---------------|-----------|
| func_14886 | Most common in all 3 tables | Very High |
| func_14884 | Secondary in tables 1-2 | High |
| func_14882 | Primary in table 1 | High |

### Low-Frequency Handlers (Initialization Only)

| Handler | Purpose |
|---------|---------|
| func_14438-func_14540 | Game mode initialization |
| func_109AE | Early main code setup |
| func_11942 | Data processing setup |

---

## Summary

### P9 Architecture

1. **Single Entry Point**: All functions entered via func_BA18 dispatcher
2. **Minimal Dependencies**: Only 5 external JSR targets total
3. **Leaf-Dominant**: 93.9% have no register save
4. **Compact Code**: Average 39.7 bytes per function
5. **State-Focused**: Most handlers update RAM state directly

### Optimization Opportunities

1. **Inlining**: Many 2-10 byte handlers could be inlined into dispatcher
2. **Table Consolidation**: Similar handlers could share code via data tables
3. **Register Allocation**: Most functions don't save registers - already optimal

### Risk Assessment

| Risk Level | Functions | Impact |
|------------|-----------|--------|
| Low | 46 (pure leaf) | Changes isolated |
| Medium | 6 (BSR calls) | Local impact |
| High | 3 (JSR external) | Cross-priority impact |

---

**Generated**: 2026-01-07
**Status**: Complete - P9 call graph and interaction map documented

