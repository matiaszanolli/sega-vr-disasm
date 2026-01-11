# 68K Controller & Input System - Virtua Racing Deluxe

**Project**: Virtua Racing Deluxe (USA).32x
**Date**: 2026-01-06

## Overview

The 68K handles all controller input processing for Virtua Racing Deluxe. The input system supports both 3-button and 6-button Sega Genesis/Mega Drive controllers, with sophisticated button mapping and state management.

## Input System Architecture

```
Controller Ports (MD_DATA1/MD_DATA2)
           ↓
    ControllerRead ($179E)
           ↓
    ┌──────┴──────┐
    ↓             ↓
Read6ButtonPad   MapButtonBits
  ($185E)         ($17EE)
           ↓
    UpdateInputState ($2080)
           ↓
    Input State RAM ($C822, $C8A4, etc.)
           ↓
    Game Logic / SH2 Commands
```

---

## Hardware Registers

| Address | Name | Purpose |
|---------|------|---------|
| $A10003 | MD_DATA1 | Controller Port 1 Data |
| $A10005 | MD_DATA2 | Controller Port 2 Data |
| $A10009 | MD_CTRL1 | Controller Port 1 Control (TH direction) |
| $A1000B | MD_CTRL2 | Controller Port 2 Control (TH direction) |

### Controller Port Pinout (Data Register)

| Bit | TH=1 (3-btn) | TH=0 (3-btn) | TH=1 (6-btn cycle 1) | TH=0 (6-btn cycle 2) |
|-----|--------------|--------------|----------------------|----------------------|
| 0   | Up           | Up           | Up                   | Up                   |
| 1   | Down         | Down         | Down                 | Down                 |
| 2   | Left         | 0            | Left                 | 0                    |
| 3   | Right        | 0            | Right                | 0                    |
| 4   | B button     | A button     | B button             | A button             |
| 5   | C button     | Start        | C button             | Start                |
| 6   | TH (output)  | TH (output)  | TH                   | TH                   |
| 7   | -            | -            | -                    | -                    |

**6-Button Extended Reads**:
- Additional TH cycles reveal X, Y, Z, Mode buttons
- 6-button pads identified by specific response pattern

---

## Core Functions

### ControllerRead ($0088179E) - 16 calls

**Purpose**: Main controller reading entry point

**Code Address**: `$0088179E`
**ROM Offset**: `$179E`
**Size**: ~192 bytes
**Called by**: 16 locations (main game loop, input polling)

**Disassembly (cleaned up)**:
```asm
; ═══════════════════════════════════════════════════════════════════════════
; ControllerRead: Read Both Controller Ports
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088179E - $0088185D
; Purpose: Poll both controller ports (1 and 2), supporting 3-button and
;          6-button controllers. Calls helper functions to perform the actual
;          6-button detection and button mapping.
; ═══════════════════════════════════════════════════════════════════════════

0088179E  ; Check if controller 1 is enabled
          CMPI.B  #$0D,($C810).W          ; Check controller 1 enable flag
          BNE.S   skip_controller1        ; Skip if disabled

          ; Set up pointers for controller 1
          LEA     ($C86C).W,A0            ; Input buffer for controller 1
          MOVE.L  (A0),$00FF60D0          ; Store previous state
          LEA     MD_DATA1,A1             ; A1 = Controller Port 1 data register
          LEA     ($C970).W,A2            ; Button state buffer
          LEA     ($FE82).W,A3            ; Button mapping table

          ; Read controller 1
          JSR     Read6ButtonPad(PC)      ; $0088185E - read with 6-button support
          JSR     MapButtonBits(PC)       ; $008817EE - map hardware bits to game buttons

          ; Check if controller 2 is enabled
          CMPI.B  #$0D,($C811).W          ; Check controller 2 enable flag
          BEQ.S   read_controller2        ; Read if enabled

          ; Controller 2 disabled - clear its state
          MOVE.B  #$00,($C86E).W          ; Clear controller 2 state
          RTS

skip_controller1:
          ; Both controllers disabled - clear state
          MOVE.B  #$00,($C86C).W          ; Clear controller 1 state
          MOVE.B  #$00,($C86E).W          ; Clear controller 2 state
          RTS

read_controller2:
          ; Set up pointers for controller 2
          LEA     MD_DATA2,A1             ; A1 = Controller Port 2 data register
          JSR     Read6ButtonPad(PC)      ; Read controller 2
          ; Falls through to MapButtonBits...
```

**Key Features**:
- Checks enable flags at `$C810` (controller 1) and `$C811` (controller 2)
- Stores previous input state for edge detection
- Uses button mapping table at `$FE82`
- Supports both 3-button and 6-button controllers

---

### Read6ButtonPad ($0088185E) - Called by ControllerRead

**Purpose**: Read controller with 6-button detection

**Code Address**: `$0088185E`
**ROM Offset**: `$185E`
**Size**: ~122 bytes

**Disassembly (cleaned up)**:
```asm
; ═══════════════════════════════════════════════════════════════════════════
; Read6ButtonPad: Read Controller with 6-Button Support
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088185E - $008818D7
; Input:  A1 = Controller data register (MD_DATA1 or MD_DATA2)
; Output: D0 = Raw button state (16-bit)
; Purpose: Perform the 6-button controller detection sequence by toggling
;          the TH pin and reading the data register multiple times.
; ═══════════════════════════════════════════════════════════════════════════

0088185E  ; Wait for controller ready
          MOVE.W  #$0100,COMM0            ; Signal busy (SH2 sync)
          BTST    #0,COMM0                ; Check ready
          BNE.S   wait_ready              ; Loop until clear

          ; Start TH toggle sequence
          MOVE.B  #$40,(A1)               ; TH = 1 (read phase 1)
          MOVEQ   #0,D6                   ; Clear accumulator
          MOVEQ   #$3F,D1                 ; Mask for data bits
          AND.B   (A1),D1                 ; Read with TH=1
          MOVE.B  D1,(A1)                 ; (store for debugging)

          ; Read with TH=0
          MOVEQ   #$40,D7                 ; TH bit mask
          MOVEQ   #$30,D0                 ; Mask for specific bits
          AND.B   (A1),D0                 ; Read partial state
          LSL.B   #2,D0                   ; Shift into position
          OR.W    D0,D0                   ; Combine with result
          MOVE.B  D7,(A1)                 ; Set TH=1 again

          NOP                             ; Timing delay
          NOP
          NOP
          NOP

          ; Additional reads for 6-button detection
          MOVE.B  (A1),D1                 ; Read again
          MOVE.B  D6,(A1)                 ; TH=0
          MOVEA.W #$00FF,A5               ; 6-button signature check value
          MOVE.B  (A1),D1                 ; Read state
          MOVE.B  D7,(A1)                 ; TH=1
          MOVE.B  (A1),D1                 ; Read state
          MOVE.B  D6,(A1)                 ; TH=0

          NOP                             ; Timing delay
          NOP
          NOP

          ; Check for 6-button controller signature
          MOVEQ   #$0F,D1                 ; Mask low nibble
          AND.B   (A1),D1                 ; Read signature bits
          BNE.S   is_3button              ; Non-zero = 3-button controller

          ; 6-button controller detected
          MOVE.B  D7,(A1)                 ; TH=1
          NOP
          NOP
          NOP

          ; Read extended buttons (X, Y, Z, Mode)
          MOVEQ   #$0F,D1                 ; Mask for extended buttons
          AND.B   (A1),D1                 ; Read extended state
          LSL.W   #8,D1                   ; Shift to high byte
          OR.W    D0,D0                   ; Combine with main buttons
          NOT.W   D0                      ; Invert (buttons are active-low)

          MOVE.W  #$0000,COMM0            ; Clear busy flag
          RTS

is_3button:
          ; 3-button controller (standard)
          NOT.W   D0                      ; Invert (active-low)
          AND.W   $1287(A0),D0            ; Mask valid bits
          MOVE.B  D7,(A1)                 ; TH=1 (idle state)

          MOVE.W  #$0000,COMM0            ; Clear busy flag
          RTS
```

**Analysis**:
- Implements 6-button controller detection protocol
- Uses TH pin toggling to cycle through read phases
- NOP delays ensure proper timing between reads
- Returns inverted button state (active-low to active-high)
- Synchronizes with SH2 via COMM0 register

---

### MapButtonBits ($008817EE) - Called by ControllerRead

**Purpose**: Map hardware button bits to game button flags

**Code Address**: `$008817EE`
**ROM Offset**: `$17EE`
**Size**: ~112 bytes

**Disassembly (cleaned up)**:
```asm
; ═══════════════════════════════════════════════════════════════════════════
; MapButtonBits: Map Controller Bits to Game Buttons
; ═══════════════════════════════════════════════════════════════════════════
; Address: $008817EE - $0088185D
; Input:  A0 = Raw controller data from Read6ButtonPad
;         A2 = Output buffer for mapped buttons
;         A3 = Button mapping table ($FE82)
; Output: Mapped button flags in buffer at (A2)
; Purpose: Convert hardware controller bit positions to game-specific button
;          flags using a lookup table. This allows remapping buttons.
; ═══════════════════════════════════════════════════════════════════════════

008817EE  ; Initialize
          MOVE.B  (A2),D2                 ; Load previous button state
          MOVE.W  D0,D1                   ; Copy current raw state
          CMP.B   D2,(A0)                 ; Compare with previous
          AND.B   D0,(A0)                 ; Mask off invalid bits
          MOVE.B  (A0)+,(A0)+             ; Store state
          MOVE.B  D0,(A0)+                ; Store masked state

          ; Clear output accumulator
          MOVEQ   #0,D6                   ; D6 will hold mapped buttons
          OR.B    D0,D6                   ; Start with base state

          ; Map 8 buttons using table lookup
          ; Each iteration: read table entry, test bit, set output bit if pressed

          ; Button 0 (from mapping table)
          BTST    #12,D6                  ; Test bit position
          MOVE.B  (A3)+,D7                ; Get table entry (bit position)
          BTST    D7,(A0)                 ; Test if button pressed
          BEQ.S   skip_btn0               ; Skip if not pressed
          BSET    #4,D6                   ; Set output bit 4
skip_btn0:

          ; Button 1
          MOVE.B  (A3)+,D7                ; Get table entry
          BTST    D7,(A0)                 ; Test button
          BEQ.S   skip_btn1
          BSET    #6,D6                   ; Set output bit 6
skip_btn1:

          ; Button 2
          MOVE.B  (A3)+,D7
          BTST    D7,(A0)
          BEQ.S   skip_btn2
          BSET    #1,D6                   ; Set output bit 1
skip_btn2:

          ; Button 3
          MOVE.B  (A3)+,D7
          BTST    D7,(A0)
          BEQ.S   skip_btn3
          BSET    #0,D6                   ; Set output bit 0 (Start button)
skip_btn3:

          ; Button 4
          MOVE.B  (A3)+,D7
          BTST    D7,(A0)
          BEQ.S   skip_btn4
          BSET    #10,D6                  ; Set output bit 10
skip_btn4:

          ; Button 5
          MOVE.B  (A3)+,D7
          BTST    D7,(A0)
          BEQ.S   skip_btn5
          BSET    #5,D6                   ; Set output bit 5
skip_btn5:

          ; Button 6
          MOVE.B  (A3)+,D7
          BTST    D7,(A0)
          BEQ.S   skip_btn6
          BSET    #9,D6                   ; Set output bit 9
skip_btn6:

          ; Button 7
          MOVE.B  (A3)+,D7
          BTST    D7,(A0)
          BEQ.S   skip_btn7
          BSET    #8,D6                   ; Set output bit 8
skip_btn7:

          ; Store results
          MOVE.W  (A2),D2                 ; Get previous state
          MOVE.W  D6,(A2)+                ; Store new mapped buttons
          CMP.W   D2,(A0)                 ; Compare with previous
          AND.W   D2,(A0)                 ; Calculate button changes
          MOVE.W  D6,(A2)+                ; Store again (duplicate for edge detection)
          RTS
```

**Analysis**:
- Uses lookup table at `$FE82` to map hardware buttons to game buttons
- Supports button remapping without changing core read logic
- Stores both current state and previous state for edge detection
- Maps 8 buttons (D-pad + A/B/C/Start + extended buttons)

**Button Mapping Table Structure**:
```
$FE82: Byte - Bit position for game button 0
$FE83: Byte - Bit position for game button 1
$FE84: Byte - Bit position for game button 2
$FE85: Byte - Bit position for game button 3 (usually Start)
$FE86: Byte - Bit position for game button 4
$FE87: Byte - Bit position for game button 5
$FE88: Byte - Bit position for game button 6
$FE89: Byte - Bit position for game button 7
```

---

### UpdateInputState ($00882080) - 21 calls

**Purpose**: High-level input state machine (documented in [68K_HOTSPOT_FUNCTIONS.md](68K_HOTSPOT_FUNCTIONS.md))

**Code Address**: `$00882080`
**ROM Offset**: `$2080`
**Size**: ~70 bytes
**Called by**: 21 locations (main game loop every frame)

**Key Operations**:
1. Read input state flag from `$C822`
2. If flag set, copy controller 1 state to `$8509`
3. Clear input processing flags
4. Branch to extended processing at `$20C6` if needed
5. Handle controller 2 state similarly

**See**: [68K_HOTSPOT_FUNCTIONS.md#updateinputstate-00882080---21-calls](68K_HOTSPOT_FUNCTIONS.md#updateinputstate-00882080---21-calls)

---

### SetInputFlag ($0088205E) - 16 calls

**Purpose**: Set input processing flag (documented in [68K_HOTSPOT_FUNCTIONS.md](68K_HOTSPOT_FUNCTIONS.md))

**Code Address**: `$0088205E`
**ROM Offset**: `$205E`
**Size**: 8 bytes

**Disassembly**:
```asm
0088205E  MOVE.B  #$F0,($C822).W   ; Set input flag to $F0
00882064  RTS
```

**Analysis**: Sets flag to `$F0`, indicating all input channels active.

**See**: [68K_HOTSPOT_FUNCTIONS.md#setinputflag-0088205e---16-calls](68K_HOTSPOT_FUNCTIONS.md#setinputflag-0088205e---16-calls)

---

### ClearInputState ($0088204A) - 11 calls

**Purpose**: Clear all input state variables (documented in [68K_HOTSPOT_FUNCTIONS.md](68K_HOTSPOT_FUNCTIONS.md))

**Code Address**: `$0088204A`
**ROM Offset**: `$204A`
**Size**: 20 bytes

**Disassembly**:
```asm
0088204A  MOVEQ   #0,D0            ; Clear D0
0088204C  MOVE.W  D0,($C8A4).W     ; Clear input buffer (word)
00882050  MOVE.B  D0,($C822).W     ; Clear input flag A
00882054  MOVE.B  D0,($C823).W     ; Clear input flag B
00882058  MOVE.W  D0,($C8A2).W     ; Clear input state (word)
0088205C  RTS
```

**Analysis**: Bulk clear of input RAM. Called during state transitions.

**See**: [68K_HOTSPOT_FUNCTIONS.md#clearinputstate-0088204a---11-calls](68K_HOTSPOT_FUNCTIONS.md#clearinputstate-0088204a---11-calls)

---

## Input System RAM Locations

### Controller State Buffers

| Address | Size | Purpose |
|---------|------|---------|
| $FF8509 | Byte | Controller 1 button state (game format) |
| $FF850A | Byte | Controller 2 button state (game format) |
| $FFC810 | Byte | Controller 1 enable flag ($0D = enabled) |
| $FFC811 | Byte | Controller 2 enable flag ($0D = enabled) |
| $FFC812 | Byte | Controller 3/extension enable flag |
| $FFC86C | Word | Controller 1 raw data buffer |
| $FFC86E | Word | Controller 2 raw data buffer |
| $FFC970 | Word | Button state buffer (working area) |
| $FF60D0 | Long | Previous controller 1 state (for edge detection) |

### Input Processing Flags

| Address | Size | Purpose |
|---------|------|---------|
| $FFC822 | Byte | Input processing flag A ($F0 = active) |
| $FFC823 | Byte | Input processing flag B |
| $FFC8A2 | Word | Input state (word) |
| $FFC8A4 | Long | Input state buffer (long) |
| $FFC8A5 | Byte | Input state flag B |
| $FFC8A6 | Byte | Controller 2 previous state |
| $FFC8A7 | Byte | Input state flag C |

### Button Mapping Table

| Address | Size | Purpose |
|---------|------|---------|
| $FFFE82 | 8 bytes | Button remapping table (8 entries) |

---

## Button Layout

### Virtua Racing Control Scheme

Based on button mapping analysis:

**3-Button Controller**:
- **D-Pad**: Steering (Left/Right), Gear shift (Up/Down)
- **A Button**: Accelerate
- **B Button**: Brake
- **C Button**: Not used / Camera change
- **Start**: Pause / Menu

**6-Button Controller** (extended):
- Same as 3-button, plus:
- **X, Y, Z**: Camera views / Additional functions
- **Mode**: Configuration menu

**Inferred Mapping**:
- Bit 0: Start button
- Bit 1: A button (Accelerate)
- Bit 4: B button (Brake)
- Bit 5: C button
- Bit 6: D-pad Up
- Bit 8: X button (6-button only)
- Bit 9: Y button (6-button only)
- Bit 10: Z button (6-button only)

---

## Input Processing Flow

### Frame-by-Frame Processing

```
V-INT occurs (every ~16.7ms @ 60Hz)
    ↓
V-INT Handler ($1684)
    ↓
State-specific handler called
    ↓
[During main loop or state handler]
    ↓
SetInputFlag ($205E)              ← Called to request input processing
    ↓
    Sets $C822 = $F0
    ↓
ControllerRead ($179E)            ← Called once per frame
    ↓
    ├─→ Read6ButtonPad ($185E)    ← Read raw controller data
    │       ↓
    │   Toggle TH pin, read data register
    │   Detect 3-button vs 6-button
    │   Return raw 16-bit button state
    │       ↓
    └─→ MapButtonBits ($17EE)     ← Map to game buttons
            ↓
        Use table at $FE82 to remap
        Store in $C86C, $C970
            ↓
UpdateInputState ($2080)          ← Called to process input
    ↓
    Check $C822 flag
    If set:
        Copy $C86C → $8509 (controller 1)
        Copy $C86E → $850A (controller 2)
        Clear flags
    ↓
    Store in game-accessible RAM
    ↓
Game logic reads from $8509, $850A
    ↓
[Next frame repeats]
```

### Edge Detection

The system tracks button state changes:
1. **Current state** stored in `$C86C` (controller 1)
2. **Previous state** stored in `$FF60D0`
3. **Rising edge** = button just pressed (was 0, now 1)
4. **Falling edge** = button just released (was 1, now 0)

**Calculation**:
```
rising_edge  = current_state AND NOT(previous_state)
falling_edge = NOT(current_state) AND previous_state
held         = current_state AND previous_state
```

---

## 6-Button Controller Detection

### Detection Sequence

The 6-button controller uses a specific response pattern:

**3-Button Controller**:
1. TH=1: Returns `00RLDU BC` (direction bits)
2. TH=0: Returns `00RL00 SA` (some directions + start/A)
3. Repeated TH toggles: Same pattern repeats

**6-Button Controller**:
1. TH=1 (cycle 1): Returns `00RLDU BC`
2. TH=0 (cycle 1): Returns `00RL00 SA`
3. TH=1 (cycle 2): Returns `00RLDU BC` (same as cycle 1)
4. TH=0 (cycle 2): Returns `00RL00 SA` (same)
5. TH=1 (cycle 3): Returns `000000 00` ← **Signature!**
6. TH=0 (cycle 3): Returns `0000 MZYX` ← **Extra buttons!**

**Detection Logic**:
```
After multiple TH toggles:
    if (data_register & 0x0F == 0x00):
        controller_type = 6_BUTTON
        read_extended_buttons()
    else:
        controller_type = 3_BUTTON
```

---

## Timing Requirements

### TH Toggle Timing

According to Sega documentation:
- **TH pulse width**: Minimum 1.5μs
- **Setup time**: 20μs between TH changes
- **Hold time**: Data valid for 1.5μs after TH stable

Virtua Racing uses **NOP delays** to ensure proper timing:
```asm
MOVE.B  D7,(A1)     ; Toggle TH
NOP                 ; ~0.52μs @ 7.67MHz
NOP                 ; ~1.04μs total
NOP                 ; ~1.56μs total
MOVE.B  (A1),D1     ; Read (now safely within timing)
```

**68K Clock**: 7.67MHz → ~130ns per cycle
- 4 NOPs = ~520ns (meets 1.5μs requirement with some margin)

---

## Troubleshooting

### Common Issues

**Problem**: Controller not responding
- **Cause**: Enable flag not set
- **Fix**: Ensure `$C810` = `$0D` (controller 1) or `$C811` = `$0D` (controller 2)

**Problem**: 6-button controller detected as 3-button
- **Cause**: TH timing too fast, controller not finishing response
- **Fix**: Add more NOP delays between TH toggles

**Problem**: Button presses not registered
- **Cause**: Input processing flag not set
- **Fix**: Call SetInputFlag (`$205E`) before ControllerRead

**Problem**: Buttons mapped incorrectly
- **Cause**: Button mapping table corrupted
- **Fix**: Verify table at `$FE82` contains valid bit positions (0-15)

**Problem**: Input latency or skipped frames
- **Cause**: ControllerRead called multiple times per frame
- **Fix**: Call once per V-INT, after SetInputFlag

---

## Input System Best Practices

### For Game Modifications

1. **Call Order**: Always call in this sequence:
   ```asm
   JSR  SetInputFlag        ; Request input processing
   JSR  WaitForVBlank       ; Sync to V-INT
   JSR  ControllerRead      ; Read controllers
   JSR  UpdateInputState    ; Process into game format
   ; Now read from $8509, $850A
   ```

2. **Button Remapping**: Modify table at `$FE82` instead of changing code:
   ```asm
   ; Example: Swap A and B buttons
   ORG $FE82
   DC.B 4  ; Button 0 → bit 4 (was B, now A)
   DC.B 1  ; Button 1 → bit 1 (was A, now B)
   ```

3. **Edge Detection**: Use previous state for one-shot actions:
   ```asm
   MOVE.B  ($8509).W,D0     ; Current state
   MOVE.B  ($FF60D0).W,D1   ; Previous state
   NOT.B   D1               ; Invert previous
   AND.B   D0,D1            ; D1 = buttons just pressed
   BTST    #0,D1            ; Test Start button
   BEQ.S   not_pressed
   ; Handle Start press...
   ```

4. **Clear State on Transitions**: Always call ClearInputState when changing game modes:
   ```asm
   ; Before switching from menu to gameplay
   JSR  ClearInputState     ; Reset all input RAM
   MOVE.W  #5,($C87A).W     ; Change V-INT state to gameplay
   ```

---

## Performance Characteristics

| Operation | Cycles (approx) | Time @ 7.67MHz |
|-----------|-----------------|----------------|
| SetInputFlag | ~20 | 2.6μs |
| ClearInputState | ~60 | 7.8μs |
| Read6ButtonPad | ~300-600 | 39-78μs |
| MapButtonBits | ~200-400 | 26-52μs |
| ControllerRead (total) | ~800-1500 | 104-195μs |
| UpdateInputState | ~150-300 | 19-39μs |

**Total per frame**: ~1200-2000 cycles = **~156-260μs**

**% of V-INT budget**: ~0.15-0.25% @ 60Hz (plenty of headroom)

---

## Integration with SH2

### Controller Data Sent to SH2

The 68K processes raw controller input and sends it to the SH2 via:
1. **COMM registers** (for immediate state)
2. **DREQ transfers** (for buffered input logs)

**COMM Protocol**:
```
COMM0 = Command byte (input update request)
COMM1 = Controller 1 state (byte)
COMM2 = Controller 2 state (byte)
COMM3 = Flags (6-button detect, etc.)
```

**DREQ Transfer**:
```
SRC = $FF8509 (controller state buffer)
DST = SH2 SDRAM input buffer
LEN = Input state structure size
```

See [68K_COMM_PROTOCOL.md](68K_COMM_PROTOCOL.md) for details on COMM/DREQ usage.

---

## References

- [68K_HOTSPOT_FUNCTIONS.md](68K_HOTSPOT_FUNCTIONS.md) - UpdateInputState, SetInputFlag, ClearInputState
- [68K_MEMORY_MAP.md](68K_MEMORY_MAP.md) - Controller port register addresses
- [68K_COMM_PROTOCOL.md](68K_COMM_PROTOCOL.md) - 68K↔SH2 communication
- [docs/32x-hardware-manual.md](../docs/32x-hardware-manual.md) - 32X hardware specification
- Sega 6-Button Controller Technical Documentation

---

## Change Log

- 2026-01-06: Initial documentation of controller/input system
- Documented ControllerRead, Read6ButtonPad, MapButtonBits
- Mapped RAM locations for input state
- Created 6-button detection sequence documentation
- Documented button mapping table structure
