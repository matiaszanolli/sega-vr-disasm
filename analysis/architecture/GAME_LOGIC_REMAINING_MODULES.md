# Game Logic Modules: Race Display & Utilities ($012200-$018200)

## Overview

This document covers the final three game logic modules in the $012200-$018200 address range (24KB total):

1. **game_12200.asm** - Race start, camera transitions, viewport control
2. **game_14200.asm** - Utility functions and small helpers
3. **game_16200.asm** - Pure data section (graphics/sprite data)

These modules complete the game logic module series, handling race initialization, camera animation, and providing data tables for runtime game operations.

---

## Module 1: game_12200.asm - Race Start & Camera System

**File**: `disasm/modules/68k/game/game_12200.asm`
**Address Range**: $012200-$014200 (8,192 bytes)
**Module Size**: 2,256 lines, 207 functions, 142 JSR calls
**Purpose**: Race start sequence, camera zoom/scroll transitions, viewport positioning

### Architecture

This module handles the **race start camera sequence** and **viewport control** during transitions between scenes and race start.

#### Key Subsystems

```
┌──────────────────────────────────────────────────────┐
│         Race Start & Camera Control Module          │
├──────────────────────────────────────────────────────┤
│                                                        │
│  ┌────────────────┐  ┌────────────────┐             │
│  │  Camera        │  │  Viewport      │             │
│  │  Position/Zoom │  │  Parameters    │             │
│  │  ($A030-$A036) │  │  Management    │             │
│  └────────────────┘  └────────────────┘             │
│                                                        │
│  ┌────────────────────────────────────┐              │
│  │   State Machine Dispatcher         │              │
│  │   ($012A40, $C87E state)           │              │
│  └────────────────────────────────────┘              │
│                                                        │
│  ┌────────────────┐  ┌────────────────┐             │
│  │  Scroll/Zoom   │  │  Graphics      │             │
│  │  Engine        │  │  Command       │             │
│  │  ($A026)       │  │  Interface     │             │
│  └────────────────┘  └────────────────┘             │
│                                                        │
└──────────────────────────────────────────────────────┘
```

### Memory Variables

#### Camera & Viewport Control

| Address | Size | Purpose | Typical Values |
|---------|------|---------|----------------|
| `$A01E` | Long | Camera position parameter 1 | Race-dependent |
| `$A022` | Long | Camera position parameter 2 | Race-dependent |
| `$A026` | Long | Scroll/zoom offset | $0400 (zoom in), $FFFFFC00 (zoom out) |
| `$A02A` | Word | Animation counter | Countdown timer |
| `$A02C` | Word | Camera parameter index | $0010, varies |
| `$A02E` | Word | Viewport parameter | $0020 |
| `$A030` | Long/Word | Viewport X position | $00A0, $0402A060 (pointer) |
| `$A032` | Word | Viewport Y parameter | $0380 |
| `$A034` | Long/Word | Viewport scroll offset | $0000, $0402A020 (pointer) |
| `$A036` | Word | Viewport dimension | $0013 (19 decimal) |
| `$A038` | Word | Camera mode/state | 0, 1, 2 |

### Camera Zoom/Scroll System

**Scroll Offset Management** ($01231C-$012346):
```asm
$01231C:  ; Update camera scroll position
    MOVE.L  $A030.W,D1          ; Load current viewport X
    MOVE.L  $A026.W,D2          ; Load scroll offset
    ADD.L   D2,D1               ; Apply offset
    MOVE.L  D1,$A030.W          ; Store updated X

    MOVE.L  $A034.W,D1          ; Load current viewport scroll offset
    ADD.L   D2,D1               ; Apply scroll offset
    MOVE.L  D1,$A034.W          ; Store updated offset

    SUBQ.W  #1,$A02A.W          ; Decrement animation counter
    BCC.W   continue_animation  ; Branch if not zero

    ; Animation complete - check offset sign
    TST.L   $A026.W
    BPL.S   positive_offset
    ADDQ.W  #1,$A02C.W          ; Increment parameter index

positive_offset:
    CLR.L   $A026.W             ; Clear scroll offset

    ; Reset viewport to base addresses
    MOVE.L  #$0402A060,$A030.W  ; Reset viewport X pointer
    MOVE.L  #$0402A020,$A034.W  ; Reset scroll offset pointer
```

**Zoom In/Out Commands**:
- `MOVE.L #$00000400,$A026` → Zoom in (scroll forward $400 units)
- `MOVE.L #$FFFFFC00,$A026` → Zoom out (scroll backward -$400 units)

### State Machine Dispatcher

**Entry Point**: $012A40
**Jump Table**: $012A50
**States**:
- State 0 ($012A72): Initialize race start camera
- State 4 ($012C8A): Camera transition active
- State 8 ($012CC2): Camera position finalization
- State C ($012F0A): Complete and advance

**Dispatcher Pattern**:
```asm
$012A40:  ; Pre-dispatcher
    JSR     $00882080           ; Common setup
    MOVE.W  $C87E.W,D0          ; Load state
    MOVEA.L $04(PC,D0.W),A1     ; Index jump table
    JMP     (A1)                ; Jump to handler
```

### Graphics & SH2 Communication

**SH2 Command Submission** ($012260-$0122A0):
```asm
.wait_comm_ready:  ; Wait for SH2 ready
    TST.B   $00A15120
    BNE.S   .wait_comm_ready

    ; Send command $2C (camera setup)
    MOVE.W  #$0101,$00A1512C    ; Size/flags
    MOVE.W  #$A000,$00A15128    ; Parameter (viewport address)
    MOVE.B  #$002C,$00A15121    ; Command $2C
    MOVE.B  #$0001,$00A15120    ; Trigger SH2

.wait_comm6_clear:  ; Wait for completion
    TST.B   $00A1512C
    BNE.S   .wait_comm6_clear

    ; Second command
    MOVE.W  #$0018,$00A15128    ; Parameter
    MOVE.W  #$0101,$00A1512C    ; Size/flags
```

**SH2 Commands Used**:
- `$03`: System command (initialization)
- `$2C`: Camera/viewport setup command

### Race Initialization Sequence

**Initialization Function** ($0128E8-$0129DE):
```asm
$0128E8:  ; Initialize race start
    ; Load graphics data
    MOVEA.L #$0601xxxx,A0       ; Graphics source (SH2 SDRAM)
    JSR     sh2_send_cmd_wait(PC) ; Data transfer command ($25)

    ; Set race parameters
    MOVE.B  $C817.W,$A019.W     ; Load track index
    MOVE.W  #$0010,$A02C.W      ; Camera param = 16
    MOVE.W  #$0020,$A02E.W      ; Viewport param = 32
    MOVE.W  #$00A0,$A030.W      ; Viewport X = 160
    MOVE.W  #$0380,$A032.W      ; Viewport Y = 896
    MOVE.W  #$0000,$A034.W      ; Scroll offset = 0
    MOVE.W  #$0013,$A036.W      ; Dimension = 19

    ; Track-specific adjustments
    TST.B   $C81B.W             ; Check race mode flag
    BEQ.W   skip_adjustments
    CMPI.B  #$0002,$A019.W      ; Track 2?
    BEQ.S   skip_adjustments
    CMPI.B  #$0004,$A019.W      ; Track 4?
    BEQ.S   skip_adjustments
    MOVE.B  #$0002,$A019.W      ; Force track 2

skip_adjustments:
    JSR     $0088204A           ; Scene setup

    ; Configure 32X adapter
    ANDI.B  #$00FC,$00A15181    ; Clear RV bits
    ORI.B   #$0001,$00A15181    ; Set RV bit 0
    MOVE.W  #$8083,$00A15100    ; Adapter enable

    ; VDP setup
    BSET    #6,$C875.W          ; Set graphics flag
    MOVE.W  $C874.W,(A5)        ; Update VDP
    MOVE.W  #$0020,$00FF0008    ; Graphics parameter

    JSR     $00884998           ; Additional setup
    MOVE.W  #$0000,$C87E.W      ; Reset state machine

    ; Set function pointer
    MOVE.L  #$00892A40,$00FF0002

    ; Clear graphics buffer
    LEA     $00FF6100,A0
    MOVE.W  #$007F,D0           ; 128 iterations

clear_loop:
    CLR.L   (A0)+               ; Clear 5 longwords
    CLR.L   (A0)+
    CLR.L   (A0)+
    CLR.L   (A0)+
    CLR.L   (A0)+
    DBRA    D0,clear_loop

    ; Initialize SH2 for race
    TST.B   $00A15120
    BNE.S   wait_sh2
    CLR.B   $00A15122           ; Clear COMM register
    CLR.B   $00A15123
    MOVE.B  #$0003,$00A15121    ; Command $03 (init)
    MOVE.B  #$0001,$00A15120    ; Trigger

wait_sh2:
    TST.B   $00A15120
    BNE.S   wait_sh2
    RTS
```

### Sound Effects

**Race Start Sound** ($012994):
```asm
MOVE.B  #$0081,$C8A5.W      ; Sound effect $81 (race start/engine)
```

This is distinct from menu sounds ($A8, $A9) and game sounds ($8E).

### External Dependencies

#### Functions Called

| Address | Purpose | Likely Module |
|---------|---------|---------------|
| `$00882080` | State machine dispatcher setup | Common utilities |
| `$00E316` (`sh2_send_cmd_wait`) | SH2 data transfer command ($25) | Graphics module |
| `$00E35A` (`sh2_send_cmd`) | SH2 graphics command ($22) | Graphics module |
| `$0088204A` | Scene initialization | Scene management |
| `$00884998` | Unknown setup | Setup utilities |
| `$0088179E` | Input processing | Input handler |
| `$00B684` | Unknown function (called 2x) | TBD |
| `$00B6DA` | Unknown function | TBD |
| `$012534` | Internal function (BSR) | This module |
| `$01259C` | Internal function (BSR) | This module |
| `$0126A6` | Internal function (BSR) | This module |
| `$01260A` | Internal function (BSR) | This module |

#### Data Tables

| Address | Content | Size |
|---------|---------|------|
| `$FA48` | Camera/race parameter table | Variable |

### Key Findings

1. **Smooth Camera Transitions**: Uses scroll offset (`$A026`) that increments/decrements gradually via animation counter (`$A02A`)

2. **Viewport Pointer Management**: `$A030` and `$A034` can be either:
   - Direct values (words: $00A0, $0000)
   - Pointers (longs: $0402A060, $0402A020)

3. **Track-Specific Camera**: Logic checks track index (`$A019`) and adjusts camera parameters accordingly

4. **Race Mode Detection**: `$C81B` flag determines if special camera adjustments are needed

5. **SH2 Camera Synchronization**: Command $2C appears to configure SH2-side camera/viewport rendering

---

## Module 2: game_14200.asm - Utility Functions

**File**: `disasm/modules/68k/game/game_14200.asm`
**Address Range**: $014200-$016200 (8,192 bytes)
**Module Size**: 2,098 lines, 31 functions, 20 JSR calls
**Purpose**: Small utility functions, data processing helpers

### Architecture

This module provides **utility functions** called by other game logic modules. It contains mostly small helper functions with minimal state machine logic.

#### Characteristics

- **Low function call density**: Only 20 JSR/BSR calls for 2,098 lines suggests heavy data content
- **Few branch targets**: 43 branch targets across 31 functions indicates simple control flow
- **Likely contains**: Lookup tables, data conversion functions, mathematical helpers

#### SH2 Communication Pattern

**Graphics Command Submission** ($014222):
```asm
.wait_first_row:  ; Wait for SH2
    TST.B   $00A15120
    BNE.S   .wait_first_row
    ; ... (command submission follows same pattern as other modules)
```

#### Graphics Parameters

**Common Pattern**:
```asm
MOVE.W  #$0050,D0           ; Width = 80
MOVE.W  #$0007,D1           ; Height = 7
MOVE.W  #$003C,D2           ; Parameter = 60
```

### Analysis

Due to the low JSR/BSR density and simple structure, this module likely serves as:
1. **Data table provider** for graphics/sprite operations
2. **Small conversion functions** (coordinate transforms, etc.)
3. **Specialized helpers** called infrequently during specific game states

**Further investigation recommended** to identify specific utility functions and their callers.

---

## Module 3: game_16200.asm - Data Section (Non-Code)

**File**: `disasm/modules/68k/game/game_16200.asm`
**Address Range**: $016200-$018200 (8,192 bytes)
**Module Size**: 2,048 lines
**Content**: **Pure data section** - no executable code

### Characteristics

- **0 branch targets, 0 labels**: Confirms this is data, not code
- **Repeating patterns**: $222A, $222B (ROM addresses), $F580, $F66C (data values)
- **Word-aligned**: All data stored as DC.W entries

### Data Patterns Observed

```asm
DC.W    $315E,$222A         ; Data pair
DC.W    $F580,$0000,$0000
DC.W    $222A,$F66C,$222B   ; Repeating ROM address references
DC.W    $358E,$222A
DC.W    $F580,$0000,$0000
DC.W    $222A,$F66C,$222B
```

### Likely Content

Based on the pattern analysis:
1. **Sprite/Graphics Data**: ROM address pointers ($222A, $222B) suggest sprite definitions
2. **Animation Frames**: Repeating structure indicates frame sequences
3. **Coordinate Tables**: $F580 patterns could be X/Y coordinates
4. **Palette Indices**: Some values may be color indices or palette references

**Note**: This section should be reclassified as a **data section** rather than code. It does not contain executable 68K instructions.

---

## Cross-References

### Integration with Other Modules

**Camera System** (game_12200.asm) integrates with:
- **Scene Sequencer** (`game_logic_4.asm`): Receives scene transition triggers via `$C87E`
- **Graphics/Menus** (`game_0e200.asm`): Shares SH2 graphics command functions
- **V-INT Handler** (`VINT_HANDLER_ARCHITECTURE.md`): Synchronized camera updates per frame
- **SH2 3D Engine** (`SH2_3D_PIPELINE_ARCHITECTURE.md`): Camera parameters control 3D viewport

### Memory Variable Usage

Variables shared across modules:
- `$C87E`: State machine (shared with `game_logic_4.asm`)
- `$C86C`: Button input (shared with `CONTROLLER_INPUT_ARCHITECTURE.md`)
- `$C8A5`: Sound trigger (shared with timer/display modules)
- `$C817`, `$C81B`: Race mode flags
- `$A019`: Track index (shared with menu modules)

---

## Summary

### Module Responsibilities

| Module | Address Range | Primary Purpose | Key Feature |
|--------|---------------|----------------|-------------|
| game_12200.asm | $012200-$014200 | Race start camera & viewport | Smooth scroll/zoom transitions |
| game_14200.asm | $014200-$016200 | Utility functions | Small helpers & data processing |
| game_16200.asm | $016200-$018200 | Data section | Sprite/graphics data tables |

### Total Game Logic Module Count

With these final modules documented, we have completed analysis of:
- **12 executable game logic modules** (game_logic_0.asm through game_14200.asm)
- **1 data section** (game_16200.asm)
- **Total code**: ~22KB of game logic (9 major modules of 8KB each + smaller modules)

---

## Future Analysis Tasks

1. **Trace camera animation timings** to understand zoom speed and frame counts
2. **Map utility functions in game_14200.asm** to their callers
3. **Decode sprite data format** in game_16200.asm
4. **Correlate camera parameters** with SH2 3D rendering pipeline
5. **Profile camera transition performance** during race start sequence

---

**Module Analysis Complete**: 2026-01-17
**Confidence Level**: Medium-High (camera system documented, utilities need deeper analysis, data section identified)
