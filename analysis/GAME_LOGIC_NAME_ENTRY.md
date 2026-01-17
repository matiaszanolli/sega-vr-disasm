# Game Logic Module: Name Entry & Character Selection ($010200-$012200)

## Overview

**File**: `disasm/modules/68k/game/game_10200.asm`
**Address Range**: $010200-$012200 (8,192 bytes)
**Module Size**: 2,251 lines, 201 functions, 178 JSR/BSR calls
**Purpose**: Player name entry screen with on-screen character grid keyboard

This module implements the game's **name entry system**, allowing players to input their initials or name using an on-screen character grid. Features:
- 52-character keyboard grid (26 uppercase + 26 lowercase)
- Special characters (period, exclamation, question, space)
- D-pad navigation with cursor movement
- Uppercase/lowercase toggle
- 3-character name buffer per player
- Split-screen support (P1/P2 simultaneous entry)
- Backspace/delete functionality

---

## Architecture Overview

### 1. Module Structure

```
┌────────────────────────────────────────────────────────────┐
│              Name Entry & Character Selection              │
├────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌──────────────────┐  ┌──────────────────┐               │
│  │  Character Grid  │  │  Name Buffer     │               │
│  │  (52 chars)      │  │  Management      │               │
│  │  ($010974-$0109AA│  │  (3 chars max)   │               │
│  └──────────────────┘  └──────────────────┘               │
│                                                              │
│  ┌────────────────────────────────────────────────────┐   │
│  │          Four State Machine Dispatchers             │   │
│  ├────────────────────────────────────────────────────┤   │
│  │  1. Name Entry Main ($011122 dispatcher)           │   │
│  │  2. Name Entry Alt  ($011144 dispatcher)           │   │
│  │  3. Name Entry Sub  ($01116C dispatcher)           │   │
│  │  4. Name Confirm    ($012062 dispatcher)           │   │
│  └────────────────────────────────────────────────────┘   │
│                                                              │
│  ┌──────────────────┐  ┌──────────────────┐               │
│  │  Input Handler   │  │  Graphics        │               │
│  │  (Grid Nav)      │  │  Rendering       │               │
│  │  ($010838-$010972│  │  (Cursor, Name)  │               │
│  └──────────────────┘  └──────────────────┘               │
│                                                              │
└────────────────────────────────────────────────────────────┘
```

### 2. Character Grid Layout

**ASCII Table** at $010974-$0109AA (54 bytes):

```
Index 0-25: Uppercase A-Z
    $00: 'A' ($41), 'B' ($42)
    $02: 'C' ($43), 'D' ($44)
    $04: 'E' ($45), 'F' ($46)
    $06: 'G' ($47), 'H' ($48)
    $08: 'I' ($49), 'J' ($4A)
    $0A: 'K' ($4B), 'L' ($4C)
    $0C: 'M' ($4D), 'N' ($4E)
    $0E: 'O' ($4F), 'P' ($50)
    $10: 'Q' ($51), 'R' ($52)
    $12: 'S' ($53), 'T' ($54)
    $14: 'U' ($55), 'V' ($56)
    $16: 'W' ($57), 'X' ($58)
    $18: 'Y' ($59), 'Z' ($5A)

Index 26-51: Lowercase a-z
    $1A: 'a' ($61), 'b' ($62)
    $1C: 'c' ($63), 'd' ($64)
    $1E: 'e' ($65), 'f' ($66)
    $20: 'g' ($67), 'h' ($68)
    $22: 'i' ($69), 'j' ($6A)
    $24: 'k' ($6B), 'l' ($6C)
    $26: 'm' ($6D), 'n' ($6E)
    $28: 'o' ($6F), 'p' ($70)
    $2A: 'q' ($71), 'r' ($72)
    $2C: 's' ($73), 't' ($74)
    $2E: 'u' ($75), 'v' ($76)
    $30: 'w' ($77), 'x' ($78)
    $32: 'y' ($79), 'z' ($7A)

Special Characters (end of table):
    $34: '.' ($2E), '!' ($21)
    $36: '?' ($3F), ' ' ($20) [space]
```

**Table Structure** (code at $010974):
```asm
        DC.W    $4142               ; "AB"
        DC.W    $4344               ; "CD"
        DC.W    $4546               ; "EF"
        ; ... (continues A-Z)
        DC.W    $6162               ; "ab"
        DC.W    $6364               ; "cd"
        ; ... (continues a-z)
        DC.W    $2E21               ; ".!"
        DC.W    $3F20               ; "? "
```

---

## State Machine Architecture

### Dispatcher 1: Name Entry Main Loop ($011122)

**Entry Point**: $011122
**Jump Table**: $011132
**States Identified**:
- **State 0** ($0111A4): Initialize name entry screen, load graphics
- **State 4** ($0111A4): Handle character selection (repeated state?)
- **State 8** ($011240): Process name input, handle cursor

**Key Initialization** ($0111A4):
```asm
$011122:  ; Pre-dispatcher call
    JSR     $00882080           ; Common dispatcher setup
    MOVE.W  $C87E.W,D0          ; Load sequence state
    MOVEA.L $04(PC,D0.W),A1     ; Index jump table
    JMP     (A1)                ; Jump to state handler
```

### Character Grid Navigation System

**Grid Navigation Function** ($010838-$010972):

```asm
loc_010838:  ; Handle D-pad input for character selection
    MOVE.W  $C86C.W,D1          ; Load button state

    ; Check UP button
    BTST    #7,D1               ; D-pad UP?
    BEQ.S   check_down
    ; ... (adjust $A026 cursor position)

check_down:
    ; Check DOWN button
    BTST    #6,D1
    BEQ.S   check_left
    ; ... (adjust $A026)

check_left:
    ; Check LEFT button
    BTST    #5,D1
    BEQ.S   check_right
    ; ... (subtract from $A026)

check_right:
    ; Check RIGHT button
    BTST    #4,D1
    BEQ.S   check_buttons
    ; ... (add to $A026)

check_buttons:
    ; Check A button (select character)
    BTST    #0,D1
    BEQ.S   check_b_button
    ; ... (insert character into name buffer)

check_b_button:
    ; Check B button (backspace)
    BTST    #1,D1
    BEQ.S   exit
    ; ... (delete last character)
```

**Cursor Position Variable**: `$A026` (word)
- Range: 0-25 (uppercase A-Z) or 26-51 (lowercase a-z)
- Range: 52-55 (special characters)

**Case Toggle** ($A028):
- 0 = Uppercase mode (indices 0-25)
- 1 = Lowercase mode (adds $1A to index)

**Character Selection Logic** ($010960):
```asm
loc_010960:
    MOVE.W  $A026.W,D0          ; Load cursor position
    CMPI.W  #$0019,D0           ; Compare to 25 (last uppercase)
    BGT.W   use_direct_index

    TST.W   $A028.W             ; Check case toggle
    BEQ.W   use_direct_index
    ADDI.W  #$001A,D0           ; Add 26 to get lowercase

use_direct_index:
    LEA     $00890974,A0        ; Character table address
    MOVE.B  $00(A0,D0.W),D0     ; Load ASCII character
    ANDI.W  #$00FF,D0           ; Mask to byte
    MOVE.W  D0,$A024.W          ; Store selected character
    RTS
```

---

## Name Buffer Management

### Name Buffer Structure

**Player 1 Name Buffer**: Pointed to by `$A018.L`
**Player 2 Name Buffer**: Pointed to by `$A01C.L`
**Buffer Size**: 3 characters maximum
**Current Position**: `$A020` (byte, 0-2)

### Character Insertion ($0102A6)

```asm
$0102A6:  ; Insert character into name buffer
    CLR.W   D1
    MOVE.B  $A020.W,D1          ; Load current position (0-2)
    MOVEA.L $A018.W,A0          ; Load P1 name buffer pointer
    MOVE.B  D0,$00(A0,D1.W)     ; Write character at position

    ; Check if P2 is active
    BTST    #1,$A014.W          ; P2 active flag
    BEQ.W   skip_p2

    ; Write to P2 buffer as well (split-screen)
    MOVEA.L $A01C.W,A0
    MOVE.B  D0,$00(A0,D1.W)

skip_p2:
    ADDQ.B  #1,$A020.W          ; Increment position
    CMPI.B  #$0003,$A020.W      ; Check if 3 characters entered
    BGE.W   advance_state       ; If full, advance to next state
```

### Character Deletion (Backspace) ($0102E0)

```asm
$0102E0:  ; Handle backspace (B button)
    TST.B   $A020.W             ; Check if buffer is empty
    BEQ.W   exit                ; Can't delete if empty

    CLR.W   D1
    MOVE.B  $A020.W,D1          ; Load current position

    ; Clear character at current position
    MOVEA.L $A018.W,A0
    MOVE.B  #$0020,$00(A0,D1.W) ; Write space to clear

    ; Clear for P2 if active
    BTST    #1,$A014.W
    BEQ.W   skip_p2_clear
    MOVEA.L $A01C.W,A0
    MOVE.B  #$0020,$00(A0,D1.W)

skip_p2_clear:
    SUBQ.B  #1,$A020.W          ; Decrement position

    ; Clear character at new position as well
    CLR.W   D1
    MOVE.B  $A020.W,D1
    MOVEA.L $A018.W,A0
    MOVE.B  #$0020,$00(A0,D1.W)
```

**Backspace Behavior**:
1. Check if buffer is empty ($A020 = 0)
2. Clear current character (write space $20)
3. Decrement position
4. Clear new current character (for blinking cursor effect)

---

## Input Handling & Sound Effects

### Button Mapping

**D-Pad Navigation**:
- `Bit 7` of `$C86C`: UP (decrements row)
- `Bit 6` of `$C86C`: DOWN (increments row)
- `Bit 5` of `$C86C`: LEFT (decrements column)
- `Bit 4` of `$C86C`: RIGHT (increments column)

**Action Buttons**:
- `Bit 0` of `$C86C`: A button (select character)
- `Bit 1` of `$C86C`: B button (backspace/delete)
- `Bit 4` of `$C86C`: START button (confirm name, advance)

### Sound Effects

**Cursor Movement Sound** ($01028A, $010918, $010942):
```asm
MOVE.B  #$00A8,$C8A4.W      ; Cursor move sound (different from menu)
; or
MOVE.B  #$00A9,$C8A4.W      ; Selection confirmation sound
```

**Sound Effect Codes**:
- `$A8`: Cursor move (character grid navigation)
- `$A9`: Selection confirmation (character selected)
- `$8E`: Game start/transition sound ($01103C)

**Sound Trigger Flags** ($010278):
```asm
MOVE.B  #$0001,$A02C.W      ; Enable sound flag
MOVE.B  #$0000,$A02D.W      ; Sound type flag
```

---

## Graphics Rendering

### Screen Initialization ($0109AC)

```asm
$0109AC:  ; Initialize name entry screen
    MOVE.W  #$002C,$00FF0008    ; Set parameter 1
    MOVE.W  #$002C,$C87A.W      ; Set parameter 2

    BCLR    #6,$C875.W          ; Clear flag
    MOVE.W  $C874.W,(A5)        ; Update VDP

    ; Setup 32X adapter
    MOVE.W  #$0083,$00A15100    ; Adapter enable (different from other screens)
    ANDI.B  #$00FC,$00A15181    ; Clear RV bits

    JSR     $008826C8           ; Graphics setup function
    MOVE.L  #$000A0907,D0       ; Graphics parameters
    JSR     $008814BE           ; Additional setup
```

### Character Grid Rendering

**Grid Dimensions** (inferred from navigation code):
- Rows: Variable (depends on character count / columns)
- Columns: Likely 8-10 characters per row
- Layout: Uppercase grid on top, lowercase below, special chars at bottom

**Cursor Rendering** (graphics buffer updates):
```asm
loc_010796:  ; Render cursor at character grid position
    ; (Function body reads character at position)
    ; Updates graphics buffers for P1/P2 split-screen
```

### Display Buffers

**VRAM Clear** ($010A0A-$010A1A):
```asm
loc_010A0A:  ; Clear VRAM for name entry screen
    MOVE.L  #$60000002,(A5)     ; VDP write command
    MOVE.W  #$17FF,D1           ; 6144 words (12KB)

loc_010A14:
    MOVE.L  D0,(A6)             ; Clear with zeros
    DBRA    D1,loc_010A14
```

**Graphics Initialization** ($0109F0-$010A06):
```asm
$0109F0:  ; Initialize character grid buffers
    MOVEQ   #$00,D0             ; Clear value
    LEA     $8480.W,A0          ; Buffer 1 start
    MOVEQ   #$1F,D1             ; 32 longwords

loc_0109F6:
    MOVE.L  D0,(A0)+            ; Clear buffer 1
    DBRA    D1,loc_0109F6

    LEA     $00FF7B80,A0        ; Buffer 2 start (larger buffer)
    MOVEQ   #$7F,D1             ; 128 longwords

loc_010A04:
    MOVE.L  D0,(A0)+            ; Clear buffer 2
    DBRA    D1,loc_010A04
```

---

## Memory Map

### Name Entry State Variables

| Address | Size | Purpose | Range/Values |
|---------|------|---------|--------------|
| `$C87E` | Word | Sequence state (shared) | 0, 4, 8, C, ... |
| `$C86C` | Word | Button input state (delta bits) | Bit flags |
| `$C8A4` | Byte | Sound effect trigger | $A8, $A9, $8E |
| `$C875` | Byte | Graphics control flag | Bit 6 used |
| `$C874` | Word | VDP parameter | TBD |
| `$C87A` | Word | Graphics parameter | Copy of $00FF0008 |
| `$C80D` | Byte | Scene flag | 0/1 |
| `$C809` | Byte | Unknown flag | 0/1 |
| `$C80A` | Byte | Unknown flag | 0/1 |
| `$C80E` | Byte | Transition flag | Bit 6 checked |
| `$C96C` | Long | Function pointer | $008BB4FC |

### Name Buffer Variables

| Address | Size | Purpose | Range/Values |
|---------|------|---------|--------------|
| `$A018` | Long | Player 1 name buffer pointer | Address (3 bytes) |
| `$A01C` | Long | Player 2 name buffer pointer | Address (3 bytes) |
| `$A014` | Word | Player flags | Bit 0=P1, Bit 1=P2 |
| `$A020` | Byte | Current character position | 0-2 (3 chars max) |
| `$A024` | Word | Selected character (ASCII) | $20-$7A |
| `$A026` | Word | Cursor position (grid index) | 0-55 |
| `$A028` | Word | Case toggle (uppercase/lowercase) | 0=upper, 1=lower |
| `$A02C` | Byte | Sound enable flag | 0/1 |
| `$A02D` | Byte | Sound type flag | 0/1 |
| `$A036` | Word | Confirmation flag | 0/1 |

### Display Memory

| Address | Size | Purpose |
|---------|------|---------|
| `$8480` | 128 bytes | Character grid buffer 1 |
| `$00FF7B80` | 512 bytes | Character grid buffer 2 (larger) |
| `$00FF0008` | Word | Graphics parameter |
| `$8000-$8002` | 4 bytes | Cleared during init |
| `$C880-$C882` | 4 bytes | Cleared during init |
| `$A012` | Word | Cleared during init |

---

## Design Patterns & Architecture

### 1. Dual-Mode Character Grid

The character table supports **uppercase and lowercase** via index offset:
- Uppercase: Direct index 0-25 → 'A'-'Z'
- Lowercase: Index + $1A (26) → 'a'-'z'

**Toggle Mechanism**:
```asm
; If $A028 = 1 and cursor is in range 0-25:
;   Character = table[$A026 + $1A]
; Else:
;   Character = table[$A026]
```

This saves memory (no duplicate table) while providing full alphabet.

### 2. Split-Screen Name Entry

All name buffer operations check `$A014 bit 1` for Player 2 and write to both buffers:

```asm
MOVE.B  D0,$00(A0,D1.W)     ; Write to P1 buffer
BTST    #1,$A014.W
BEQ.W   skip_p2
MOVEA.L $A01C.W,A0
MOVE.B  D0,$00(A0,D1.W)     ; Write to P2 buffer (mirror)
```

This allows **simultaneous name entry** in split-screen mode.

### 3. Cursor Blinking Effect

Backspace clears **both** the deleted character and the new cursor position:

```asm
SUBQ.B  #1,$A020.W          ; Move cursor back
MOVE.B  #$0020,$00(A0,D1.W) ; Clear character at new position
```

This suggests the cursor renders by showing/hiding a character, creating a blinking effect.

### 4. Grid Wrapping (Inferred)

Navigation code likely implements wrapping:
- RIGHT at end of row → wrap to next row start
- LEFT at row start → wrap to previous row end
- UP/DOWN → move between rows

(Exact implementation would require detailed analysis of navigation function)

### 5. Special Character Handling

Last 4 bytes of table ($2E21, $3F20) contain special characters:
- Period '.'
- Exclamation '!'
- Question '?'
- Space ' '

These are accessible at grid positions 52-55.

---

## State Transition Flow

```
State 0: Initialize Name Entry
  ↓ (graphics loaded)
State 4: Character Grid Active
  ↓ (player selects characters, fills 3-char buffer)
  ← Loop back: D-pad navigation, character selection
  → Advance: START pressed or 3 characters entered
State 8: Name Confirmation
  ↓ (player confirms or edits)
  → Advance: Confirmed
  ← Back: SUBQ.W #4,$C87E (return to editing)
State C+: Exit Name Entry
  → Reset: MOVE.W #0,$C87E
```

**Key State Transitions**:
- `ADDQ.W #4,$C87E`: Advance to next state
- `SUBQ.W #4,$C87E`: Return to previous state
- `MOVE.W #0,$C87E`: Reset to initial state

---

## External Dependencies

### Functions Called in Other Modules

| Address | Purpose | Likely Module |
|---------|---------|---------------|
| `$00882080` | Pre-state-machine dispatcher | Common utilities |
| `$00E52C` | Graphics setup (called in game_0e200.asm too) | Graphics module |
| `$00E35A` | SH2 graphics command (2-param) | Graphics module |
| `$00884998` | Unknown setup | Setup utilities |
| `$0088179E` | Input processing | Input handler |
| `$0088FB36` | Unknown function | TBD |
| `$008826C8` | Graphics operation | Graphics utilities |
| `$008814BE` | Unknown setup | Initialization |
| `$008849AA` | Event handler (called 2x) | Event system |
| `$010796` | Cursor rendering (internal) | This module |
| `$01084C` | Unknown handler (internal) | This module |

### Data Tables in Other Modules

| Address | Content | Size/Structure |
|---------|---------|----------------|
| `$00890974` | Character grid ASCII table | 54 bytes (27 words) |

---

## Performance Characteristics

### Cycle Estimates (Per Frame in Name Entry)

| Operation | Cycles (approx) | Frequency | Notes |
|-----------|----------------|-----------|-------|
| State dispatcher | ~50 | 1x per frame | Jump table lookup |
| Character grid navigation | ~200-300 | If D-pad pressed | Button checks + cursor update |
| Character insertion | ~100 | If A button pressed | Memory write + position increment |
| Backspace | ~150 | If B button pressed | Memory clear + position decrement |
| Cursor rendering | ~300-500 | 1x per frame | Graphics buffer update |
| VRAM clear (init only) | ~15,000 | On scene init | 6144 words × ~2.5 cycles |
| Character table lookup | ~30 | Per selection | Indexed load |

**Total name entry overhead**: ~500-1,500 cycles per frame (varies by input)

**Bottleneck**: None significant - simple input handling and memory operations.

---

## Future Analysis Tasks

1. **Trace cursor rendering function** ($010796) to understand grid layout
2. **Map all 4 state machine dispatchers** to understand full name entry flow
3. **Document grid wrapping logic** (navigation boundaries)
4. **Analyze graphics command codes** for cursor and name display
5. **Correlate with high score saving** to understand where names are stored
6. **Profile cursor blink timing** (likely tied to V-INT counter)

---

## Cross-References

- **Master Sequencer**: `game_logic_4.asm` (shares $C87E state variable)
- **Graphics/Menus**: `game_0e200.asm` (shares graphics command functions)
- **Input System**: `CONTROLLER_INPUT_ARCHITECTURE.md` ($C86C button state)
- **Sound System**: `GAME_LOGIC_TIMERS_DISPLAY.md` ($C8A4 sound trigger)
- **V-INT Handler**: `VINT_STATE_HANDLERS.md` (frame synchronization)

---

**Module Analysis Complete**: 2026-01-17
**Confidence Level**: High (character grid and buffer management documented), Medium (graphics rendering details incomplete)
