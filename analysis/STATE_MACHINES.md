# Virtua Racing Deluxe - State Machine Documentation

This document catalogs the state machines used in the 68K codebase, their state variables, jump table locations, and purposes.

## Overview

The game uses **PC-relative jump table dispatchers** for state machine implementation:

```asm
MOVE.W  $Cxxx.W,D0         ; Load state index (multiplied by 4)
MOVEA.L $04(PC,D0.W),A1    ; Load handler address from jump table
JMP     (A1)               ; Jump to handler
```

State values are typically multiplied by 4 (using ADDQ.W #4 / SUBQ.W #4) to index into long-word aligned jump tables.

---

## Primary State Machines

### 1. Main Game State Machine (`$C87E`)

**Purpose:** Controls high-level game flow (menus, race, results)

| Property | Value |
|----------|-------|
| State Variable | `$C87E` |
| State Range | 0-15 (16 states, cyclic) |
| Frame Counter | `$C964` |
| State Table | `$0016B2` |

**Usage Locations:**
- `code_e200.asm`: Menu/graphics state machine (lines 486, 1271, 2216, 2223)
- `code_4200.asm`: Game state dispatcher (lines 741, 932)
- `code_14200.asm`: Menu state machine (line 119)

**State Transitions:**
```
State 0 → State 1 (ADDQ.W #4,$C87E.W)  ; Advance
State N → State N-1 (SUBQ.W #4,$C87E.W) ; Retreat
State reset (MOVE.W #$0000,$C87E.W)     ; Reset to 0
```

**State Handlers (from code_e200.asm:489-492):**
| Offset | Address | Handler |
|--------|---------|---------|
| 0 | $00E93A | State 0 handler |
| 4 | $00E988 | State 1 handler |
| ... | ... | ... |

---

### 2. Race State Machine (`$C8A0`)

**Purpose:** Controls race gameplay phases (countdown, racing, finish)

| Property | Value |
|----------|-------|
| State Variable | `$C8A0` |
| Related | `$C8CC` (sub-state) |

**Usage Locations:**
- `code_a200.asm`: Race state dispatcher (lines 2079, 2139, 2180, 2379, 2579)
- `code_4200.asm`: Race phase control (lines 635, 701, 820, 912, 1011, 1071)

**Known States:**
| Value | Phase |
|-------|-------|
| 0 | Pre-race (countdown) |
| 4 | Racing |
| 8 | Lap complete |
| 12 | Race finish |

---

### 3. Menu State Machine (`$C082`)

**Purpose:** Controls menu navigation and selection

| Property | Value |
|----------|-------|
| State Variable | `$C082` |
| Related | `$C084` (sub-menu state) |

**Usage Locations:**
- `code_a200.asm`: Menu state (lines 2141, 2182)
- `code_14200.asm`: Menu navigation (line 136)
- `code_4200.asm`: Menu control (line 91)

---

### 4. Input/Controller State Machine (`$C07C`)

**Purpose:** Controls input polling and controller state

| Property | Value |
|----------|-------|
| State Variable | `$C07C` |

**Usage Locations:**
- `code_4200.asm`: Input state dispatcher (lines 147, 190, 350)

---

### 5. SH2 Communication State Machine (`$C89C`)

**Purpose:** Controls 68K-SH2 communication protocol

| Property | Value |
|----------|-------|
| State Variable | `$C89C` |
| Related | `$C89E` (comm sub-state) |

**Usage Locations:**
- `code_a200.asm`: SH2 comm state (lines 547, 2396)
- `code_a200.asm`: Comm sub-state (lines 679, 1480)

**Known States:**
| Value | Phase |
|-------|-------|
| 0 | Idle |
| 4 | Busy/transmitting |
| 8 | Data transfer |
| 12 | Complete |

---

### 6. V-INT State Machine (`$C8C8`)

**Purpose:** Controls V-blank interrupt processing phases

| Property | Value |
|----------|-------|
| State Variable | `$C8C8` |

**Usage Locations:**
- `code_a200.asm`: V-INT state (line 561)
- `code_4200.asm`: V-INT control (lines 639, 717, 824, 893, 902, 1062)

---

### 7. Scene/Display State Machine (`$C8AA`)

**Purpose:** Controls scene transitions (fade in/out, wipes)

| Property | Value |
|----------|-------|
| State Variable | `$C8AA` |

**Usage Locations:**
- `code_a200.asm`: Scene state (line 2244)

---

### 8. Timer State Machine (`$C0FA`)

**Purpose:** Controls timer/countdown states

| Property | Value |
|----------|-------|
| State Variable | `$C0FA` |

**Usage Locations:**
- `code_a200.asm`: Timer state (line 175)

---

### 9. Object State Machine (`$C25C`)

**Purpose:** Controls object/sprite system states

| Property | Value |
|----------|-------|
| State Variable | `$C25C` |

**Usage Locations:**
- `code_4200.asm`: Object state (line 74)

---

### 10. Misc State Machines

| Variable | Purpose | Primary File |
|----------|---------|--------------|
| `$C048` | Camera state | code_a200.asm |
| `$C050` | Scroll state | code_a200.asm |
| `$C0A2` | Graphics mode | code_e200.asm |
| `$C972` | Animation state | code_a200.asm |
| `$C8B0-$C8BA` | Track segment states | code_14200.asm |
| `$C8BE` | Race position state | code_4200.asm |

---

## Jump Table Pattern Analysis

### Pattern 1: Standard PC-Relative Dispatch
```asm
; Load state index (pre-multiplied by 4)
MOVE.W  $Cxxx.W,D0
; Load handler from jump table at PC+4
MOVEA.L $04(PC,D0.W),A1
; Execute handler
JMP     (A1)
; Jump table immediately follows
.long   handler_0
.long   handler_1
...
```

### Pattern 2: Offset PC-Relative Dispatch
```asm
; Load state index
MOVE.W  $Cxxx.W,D0
; Load from table at negative offset
MOVEA.L -$24(PC,D0.W),A1
JMP     (A1)
```

### Pattern 3: Indirect Table Dispatch
```asm
; Load index
MOVE.W  D0,D1
ADD.W   D1,D1
ADD.W   D1,D1            ; D1 *= 4
LEA     table(PC),A0
MOVEA.L (A0,D1.W),A0
JMP     (A0)
```

---

## State Transition Functions

### Named Functions (from symbol table)

| Symbol | Address | Purpose |
|--------|---------|---------|
| `game_state_dispatch` | $004CBC | Main game state dispatcher |
| `scene_state_dispatch` | $00C662 | Scene state jump table |
| `menu_state_dispatch` | $01440E | Menu state dispatcher |
| `race_state_init` | $00CC88 | Initialize race state |
| `race_state_read` | $00A1FC | Read current race state |
| `game_state_handler` | $00A144 | Process game state |
| `adapter_state_init` | $00268C | Initialize 32X adapter state |
| `sound_state_init` | $002066 | Initialize sound state |

---

## Memory Map: State Variables ($C000-$C9FF)

```
$C000-$C0FF: System state variables
  $C048   Camera state
  $C050   Scroll state
  $C07C   Input state
  $C082   Menu state
  $C084   Sub-menu state
  $C0A2   Graphics mode
  $C0FA   Timer state

$C200-$C2FF: Object/transform state
  $C25C   Object system state

$C800-$C8FF: Game state variables
  $C87E   Main game state (16 states)
  $C89C   SH2 comm state
  $C89E   SH2 comm sub-state
  $C8A0   Race state
  $C8AA   Scene state
  $C8B0-$C8BA   Track segment states (6 vars)
  $C8BE   Race position state
  $C8C8   V-INT state
  $C8CC   Race sub-state

$C900-$C9FF: Frame/timing state
  $C964   Frame counter
  $C972   Animation state
```

---

## Cross-References

### Files with Most State Machine Usage

| File | State Vars | Dispatchers |
|------|------------|-------------|
| code_4200.asm | 46 refs | game_state, race_state |
| code_a200.asm | 26 refs | SH2 comm, race, scene |
| code_c200.asm | 25 refs | V-INT, polling |
| code_2200.asm | 26 refs | Input, controller |
| code_6200.asm | 18 refs | Object system |
| code_8200.asm | 17 refs | Camera, display |
| code_14200.asm | 13 refs | Menu, track |

---

## Related Documentation

- [REFACTORING_MAP.md](../disasm/REFACTORING_MAP.md) - Module organization
- [SYMBOL_MAP.md](../disasm/sections/SYMBOL_MAP.md) - Function symbols
- [ANNOTATION_FRAMEWORK.md](../ANNOTATION_FRAMEWORK.md) - Code annotation guide

---

*Generated: January 2026*
*Total state variables documented: 20+*
*Total state machine dispatchers: 8 primary*
