# Game Logic - Timers and Display Management

**Module:** [disasm/modules/68k/game/game_logic_2.asm](../disasm/modules/68k/game/game_logic_2.asm)
**Address Range:** $008200-$008B9C (~2.5KB)
**Status:** ✅ Complete analysis with decoded mnemonics
**Date:** 2026-01-17

---

## Overview

This module implements game timer management, score/time display formatting, and race result comparison logic. Unlike game_logic_1.asm which handles initialization, this module focuses on real-time game state updates during gameplay.

**Key Statistics:**
- 97 function labels
- 21 JSR function calls
- 4 primary subsystems: Timers, Display, Comparison, State Management

**Primary Functions:**
1. **Timer Countdown** - 8 independent timers decremented each frame
2. **Display Formatting** - Convert binary time/score to displayable format
3. **Result Comparison** - Compare race times and determine rankings
4. **VDP Updates** - Write formatted data to VDP display memory

---

## Architecture Overview

### Functional Breakdown

```
Module Structure:
├── State Management ($008200-$008254)
│   ├── Control flag handling ($C8A4, $C8AB)
│   ├── Display timer ($C04E)
│   └── Mode transitions
│
├── Display Formatters ($00825C-$0083BA)
│   ├── Time comparison display ($00825C)
│   ├── Number to decimal conversion ($00839A)
│   └── VDP memory writes ($00FF68F0, $00FF68F8)
│
├── Result Comparison ($0082FA-$008546)
│   ├── Time/score comparison logic
│   ├── Ranking determination
│   └── Best time storage ($C270, $C274)
│
└── Timer Management ($008548-$008598)
    ├── 8 independent countdown timers
    ├── Frame-based decrements
    └── Zero-bounded (stops at 0)
```

---

## Timer Management System

### Timer Countdown Function ($008548)

**Purpose:** Decrement 8 independent game timers each frame

**Timers Managed:**

| Offset | Address | Purpose (Inferred) | Decrement Pattern |
|--------|---------|-------------------|-------------------|
| $0098 | A0+$98 | Power-up duration? | SUBQ.W #1, BLE guard |
| $009A | A0+$9A | Invincibility timer? | SUBQ.W #1, BLE guard |
| $0086 | A0+$86 | Effect timer 1 | SUBQ.W #1, BLE guard |
| $0080 | A0+$80 | Effect timer 2 | SUBQ.W #1, BLE guard |
| $0082 | A0+$82 | Effect timer 3 | SUBQ.W #1, BLE guard |
| $0084 | A0+$84 | Effect timer 4 | SUBQ.W #1, BLE guard |
| $00E6 | A0+$E6 | Animation timer 1 | SUBQ.W #1, BLE guard |
| $00E8 | A0+$E8 | Animation timer 2 | SUBQ.W #1, BLE guard |

**Code Pattern (Repeated 8 Times):**

```asm
        DC.W    $4A68,$0098         ; TST.W  $0098(A0)
        DC.W    $6F04               ; BLE.S  loc_008552
        DC.W    $5368,$0098         ; SUBQ.W  #1,$0098(A0)
```

**Logic:**
1. Test if timer is already <= 0
2. If yes, skip decrement (timer stays at 0)
3. If no, decrement by 1

**Performance:**
- 8 timers × 4 cycles (TST+BLE+SUBQ) = ~32 cycles per frame
- Very efficient countdown mechanism

---

## Display Formatting System

### Number to Decimal Converter ($00839A)

**Purpose:** Convert 32-bit binary value to displayable decimal digits

**Input:**
- **A4** = Pointer to 4-byte binary value (long word)

**Output:**
- **A1** = Pointer to 8-byte decimal digit array (written incrementally)
- **D1** = Individual digit extracted

**Algorithm:**

```asm
nibble_unpack:
        DC.W    $1214               ; MOVE.B  (A4),D1         ; Byte 0
        DC.W    $6110               ; BSR.S  loc_0083AE       ; Convert to 2 digits
        DC.W    $122C,$0001         ; MOVE.B  $0001(A4),D1    ; Byte 1
        DC.W    $610A               ; BSR.S  loc_0083AE       ; Convert to 2 digits
        DC.W    $122C,$0002         ; MOVE.B  $0002(A4),D1    ; Byte 2
        DC.W    $12C1               ; MOVE.B  D1,(A1)+        ; Store directly
        DC.W    $122C,$0003         ; MOVE.B  $0003(A4),D1    ; Byte 3

loc_0083AE:
        DC.W    $1401               ; MOVE.B  D1,D2
        DC.W    $E80A               ; LSR.B  #4,D2           ; High nibble → D2
        DC.W    $12C2               ; MOVE.B  D2,(A1)+        ; Store high digit
        DC.W    $0201,$000F         ; ANDI.B  #$000F,D1       ; Mask low nibble
        DC.W    $12C1               ; MOVE.B  D1,(A1)+        ; Store low digit
        DC.W    $4E75               ; RTS
```

**Process:**
1. Read byte from source (A4)
2. Extract high nibble (bits 7-4) → first digit
3. Extract low nibble (bits 3-0) → second digit
4. Store both digits to output buffer (A1)+
5. Repeat for all 4 bytes

**Example:**
- Input: $12 34 56 78
- Output: 1 2 3 4 5 6 7 8 (8 separate bytes)

**Use Case:** Displaying race times (MM:SS.MS format)

---

### VDP Display Write ($008222)

**Purpose:** Write formatted time/status to VDP display memory

**VDP Registers Used:**

| Address | Purpose | Data Format |
|---------|---------|-------------|
| $00FF6960 | Display state flag | 0 or 1 (running/stopped) |
| $00FF68F0 | Status code | $00 = running, $03 = stopped |
| $00FF68F8 | Formatted time display | 8 decimal digits |

**Display State Logic ($008200):**

```asm
        DC.W    $C8A4               ; AND.L  -(A4),D4        ; Check flag
        DC.W    $6706               ; BEQ.S  .check_timer
        DC.W    $11FC,$00BF,$C8A4   ; MOVE.B  #$00BF,$C8A4.W ; Set to $BF

.check_timer:
        DC.W    $4A78,$C04E         ; TST.W  $C04E.W         ; Check timer
        DC.W    $6744               ; BEQ.S  table_lookup_object_field_to_race_state_byte      ; Skip if zero
        DC.W    $7000               ; MOVEQ   #$00,D0
        DC.W    $5378,$C04E         ; SUBQ.W  #1,$C04E.W     ; Decrement display timer
        DC.W    $670A               ; BEQ.S  .write_flag
        DC.W    $0838,$0002,$C8AB   ; BTST    #2,$C8AB.W     ; Check pause flag
        DC.W    $6602               ; BNE.S  .write_flag
        DC.W    $7001               ; MOVEQ   #$01,D0         ; D0 = 1 (running)
.write_flag:
        DC.W    $13C0,$00FF,$6960   ; MOVE.B  D0,$00FF6960    ; Write display state
```

**Pattern:**
1. Check display timer $C04E
2. Decrement timer each frame
3. When timer expires or pause flag set: D0 = 0 (stopped)
4. Otherwise: D0 = 1 (running)
5. Write state to VDP register $00FF6960

---

## Result Comparison System

### Time Comparison Function ($0082FA)

**Purpose:** Compare current race time with stored best time

**Memory Regions:**

| Address | Purpose | Size |
|---------|---------|------|
| $C806 | Temporary time buffer | 4 bytes |
| $C270 | Best time (mode 1) | 4 bytes |
| $C274 | Best time (mode 2) | 4 bytes |

**Code Structure:**

```asm
        DC.W    $43F8,$C806         ; LEA     $C806.W,A1      ; Source
        DC.W    $45F8,$C270         ; LEA     $C270.W,A2      ; Destination
        DC.W    $4EBA,$30CA         ; JSR     $00B3CE(PC)     ; Copy time
        DC.W    $7000               ; MOVEQ   #$00,D0
        DC.W    $43F8,$C270         ; LEA     $C270.W,A1
        DC.W    $4EBA,$3078         ; JSR     $00B386(PC)     ; Format time
        DC.W    $2A38,$C270         ; MOVE.L  $C270.W,D5      ; Load current time
        DC.W    $7C04               ; MOVEQ   #$04,D6         ; Mode offset
```

**Comparison Logic ($008334):**

```asm
.compute_index:
        DC.W    $47F8,$FDAA         ; LEA     $FDAA.W,A3      ; Best time table base
        DC.W    $3238,$C89C         ; MOVE.W  $C89C.W,D1      ; Track number
        DC.W    $EB49               ; LSL.W  #5,D1           ; × 32
        DC.W    $D278,$C8A0         ; ADD.W  $C8A0.W,D1      ; + Mode offset
        DC.W    $3438,$C8C8         ; MOVE.W  $C8C8.W,D2      ; Lap number
        DC.W    $E74A               ; LSL.W  #3,D2           ; × 8
        DC.W    $D478,$C8CC         ; ADD.W  $C8CC.W,D2      ; + Lap offset
        DC.W    $D242               ; ADD.W  D2,D1
        DC.W    $D246               ; ADD.W  D6,D1           ; + Mode
        DC.W    $47F3,$1000         ; LEA     $00(A3,D1.W),A3 ; Index into table

        DC.W    $0C85,$6000,$0000   ; CMPI.L  #$60000000,D5   ; Check for invalid time
        DC.W    $6D0C               ; BLT.S  three_way_value_comparison_router
        DC.W    $28BC,$DDDD,$0DDD   ; MOVE.L  #$DDDD0DDD,(A4) ; Invalid marker
        DC.W    $7001               ; MOVEQ   #$01,D0
        DC.W    $7200               ; MOVEQ   #$00,D1
        DC.W    $4E75               ; RTS

three_way_value_comparison_router:
        DC.W    $BA93               ; CMP.L  (A3),D5         ; Compare with best
        DC.W    $6D0E               ; BLT.S  object_state_assignment_00837a      ; Current < Best?
        DC.W    $6E1C               ; BGT.S  loc_00838A      ; Current > Best?
        DC.W    $28BC,$0000,$0000   ; MOVE.L  #$00000000,(A4) ; Tied
        DC.W    $720E               ; MOVEQ   #$0E,D1
        DC.W    $7000               ; MOVEQ   #$00,D0
        DC.W    $4E75               ; RTS
```

**Ranking Results:**

| Condition | D0 | D1 | Meaning | Display Code |
|-----------|----|----|---------|--------------|
| Current < Best | 2 | $0D | New record | Write current → best |
| Current = Best | 0 | $0E | Tied record | Display tie message |
| Current > Best | 1 | $0C | Not a record | Keep old best |
| Time invalid | 1 | $00 | Invalid/DNF | Marker $DDDD0DDD |

**Best Time Table Indexing:**

```
Index = (Track# × 32) + Mode_Offset + (Lap# × 8) + Lap_Offset + Mode
```

**Components:**
- **Track# ($C89C):** Which circuit (0-7?)
- **Mode ($C8A0):** Time attack / Grand Prix / etc.
- **Lap# ($C8C8):** Current lap (1-5?)
- **Lap_Offset ($C8CC):** Additional lap modifier

**Table Size:** ~32 tracks × 8 laps × 4 bytes = 1024 bytes

---

## Display Update Patterns

### Race Time Display ($00825C)

**Purpose:** Update on-screen race timer display

**Pattern:**
1. Check bit 6 of control flags ($0002 offset)
2. If set: Clear bit (ANDI.W #$BFFF) and process update
3. Clear game state $C8AA
4. Load display mode from $C319 bits 6-7
5. Shift mode right by 4 bits (EC48 / E808)
6. Dispatch to mode-specific handler via jump table
7. Format time and write to VDP memory $00FF68F8

**VDP Write Sequence:**

```asm
        DC.W    $43F9,$00FF,$68F8   ; LEA     $00FF68F8,A1
        DC.W    $1340,$FFF9         ; MOVE.B  D0,-$0007(A1)   ; Write digit 1
        DC.W    $12C1               ; MOVE.B  D1,(A1)+        ; Write digit 2
        DC.W    $4EBA,$00F6         ; JSR     nibble_unpack(PC)  ; Convert remaining
```

**Output Format:**
- 8 bytes written to VDP memory
- Format: MM:SS.MS (Minutes:Seconds.Milliseconds)

---

### Lap Time Display ($0083BC, $0083DA)

**Purpose:** Display individual lap times in results screen

**Two Display Slots:**

| Slot | Counter | Base Address | Display Buffer | Purpose |
|------|---------|--------------|----------------|---------|
| 1 | $A9E0 | $A9E3 | $A800 | Player 1 lap times |
| 2 | $A9E1 | $A9E7 | $A8F0 | Player 2 lap times |

**Code Structure (Slot 1):**

```asm
        DC.W    $0828,$0006,$0002   ; BTST    #6,$0002(A0)    ; Check update flag
        DC.W    $6602               ; BNE.S  entity_flag_bit_test_guard
        DC.W    $4E75               ; RTS                     ; Skip if not set

entity_flag_bit_test_guard:
        DC.W    $7000               ; MOVEQ   #$00,D0
        DC.W    $1038,$A9E0         ; MOVE.B  $A9E0.W,D0      ; Load lap counter
        DC.W    $5238,$A9E0         ; ADDQ.B  #1,$A9E0.W      ; Increment counter
        DC.W    $43F8,$A9E3         ; LEA     $A9E3.W,A1      ; Source data
        DC.W    $45F8,$A800         ; LEA     $A800.W,A2      ; Display buffer
        DC.W    $601C               ; BRA.S  dual_time_display_orch      ; Process
```

**Process:**
1. Check if lap time update requested (bit 6 of $0002)
2. Load current lap number from counter ($A9E0 or $A9E1)
3. Increment lap counter (max 255 laps)
4. Calculate display buffer offset: lap# × 4
5. Copy lap time to display buffer
6. Format and write to VDP

**Display Layout:**
- Each lap time: 4 bytes (long word)
- Buffer holds up to 60 lap times (240 bytes @ $A800)

---

## State Management Functions

### Control Flag Handling ($008280)

**Purpose:** Process game state transitions and display updates

**Key Control Flags:**

| Address | Bit | Purpose | Set By | Cleared By |
|---------|-----|---------|--------|------------|
| $0002(A0) | 6 | Update display | Game logic | This function (ANDI #$BFFF) |
| $0002(A0) | 1 | Result ready | Comparison | Mode handler |
| $C8AB | 2 | Pause active | Pause handler | Resume handler |
| $C8AA | - | Game state | Various | State transitions |

**State Transition Logic:**

```asm
        DC.W    $0828,$0006,$0002   ; BTST    #6,$0002(A0)    ; Check update flag
        DC.W    $6742               ; BEQ.S  .sub_0082A6      ; Skip if not set
        DC.W    $0268,$BFFF,$0002   ; ANDI.W  #$BFFF,$0002(A0); Clear update flag
        DC.W    $0828,$0001,$0002   ; BTST    #1,$0002(A0)    ; Check result flag
        DC.W    $670E               ; BEQ.S  timer_disp_update_004
        DC.W    $31FC,$0000,$C04E   ; MOVE.W  #$0000,$C04E.W  ; Clear timer
        DC.W    $0268,$FDFF,$0002   ; ANDI.W  #$FDFF,$0002(A0); Clear result flag
        DC.W    $4E75               ; RTS

timer_disp_update_004:
        DC.W    $4278,$C8AA         ; CLR.W  $C8AA.W         ; Clear game state
```

**Pattern:**
1. Check update flag (bit 6)
2. Clear update flag immediately (acknowledge)
3. Check result flag (bit 1)
4. If result ready: Clear timer, clear result flag, exit
5. If no result: Clear game state, continue processing

---

## Advanced Features

### Speed-Based Display Update ($00859A)

**Purpose:** Update display based on vehicle speed

**Algorithm:**

```asm
        DC.W    $3028,$0004         ; MOVE.W  $0004(A0),D0    ; Load speed
        DC.W    $48C0               ; EXT.L   D0              ; Sign extend
        DC.W    $7206               ; MOVEQ   #$06,D1
        DC.W    $E3A8               ; LSL.L  D1,D0           ; × 64
        DC.W    $6A02               ; BPL.S  loc_0085A8      ; Check sign
        DC.W    $7000               ; MOVEQ   #$00,D0         ; Clamp to 0

loc_0085A8:
        DC.W    $0C80,$0000,$1900   ; CMPI.L  #$00001900,D0   ; Check threshold
        DC.W    $650E               ; BCS.S  loc_0085BE      ; Skip scaling
        DC.W    $E588               ; LSL.L  #2,D0           ; × 4 (fast speed)
        DC.W    $0C80,$0000,$7000   ; CMPI.L  #$00007000,D0   ; Check max
        DC.W    $6504               ; BCS.S  loc_0085BE
        DC.W    $303C,$7080         ; MOVE.W  #$7080,D0       ; Clamp to max

loc_0085BE:
        DC.W    $9168,$00BC         ; SUB.W  D0,$00BC(A0)    ; Update offset
        DC.W    $4E75               ; RTS
```

**Speed Scaling:**
- Base: Speed × 64
- Threshold: $1900 (~6400 units)
- Fast scaling: Speed × 256 (above threshold)
- Maximum: $7080 (~28800 units)

**Purpose:** Adjust display offset based on vehicle speed (speedometer/tachometer?)

---

### Countdown Timer with Pause ($0085C4)

**Purpose:** Countdown timer with pause support

**Code:**

```asm
        DC.W    $4A38,$C8A2         ; TST.B  $C8A2.W         ; Check timer
        DC.W    $670C               ; BEQ.S  loc_0085D6      ; Skip if zero
        DC.W    $5338,$C8A2         ; SUBQ.B  #1,$C8A2.W     ; Decrement
        DC.W    $6606               ; BNE.S  loc_0085D6      ; Continue if > 0
        DC.W    $11FC,$0000,$C8A6   ; MOVE.B  #$0000,$C8A6.W ; Clear on expire
```

**Features:**
- Byte-sized timer at $C8A2
- Automatically clears $C8A6 when timer expires
- Used for temporary effects or animations

---

## Memory Map Summary

### Global State Variables

| Address | Size | Purpose | Access Pattern |
|---------|------|---------|----------------|
| $C04E | word | Display timer | Read/Write/Decrement |
| $C8A2 | byte | Effect timer | Decrement |
| $C8A4 | byte | Control flag | Read/Write |
| $C8A6 | byte | Effect state | Cleared on timer expire |
| $C8AA | word | Game state | Cleared frequently |
| $C8AB | byte | Pause/mode flags | Bit test |
| $C89C | word | Track number | Read only |
| $C8A0 | word | Mode offset | Read only |
| $C8C8 | word | Lap number | Read only |
| $C8CC | word | Lap offset | Read only |
| $C319 | byte | Display mode | Bits 6-7 used |
| $C270 | long | Best time (mode 1) | Read/Write |
| $C274 | long | Best time (mode 2) | Read/Write |
| $C806 | long | Temp time buffer | Write only |

### VDP Display Memory

| Address | Size | Purpose | Format |
|---------|------|---------|--------|
| $00FF6960 | byte | Display state | 0 = stopped, 1 = running |
| $00FF68F0 | byte | Status code | $00 = run, $03 = stop |
| $00FF68F8 | 8 bytes | Formatted time | 8 decimal digits |

### Lap Time Storage

| Address | Size | Purpose |
|---------|------|---------|
| $A9E0 | byte | Player 1 lap counter |
| $A9E1 | byte | Player 2 lap counter |
| $A9E3 | ? | Player 1 lap data |
| $A9E7 | ? | Player 2 lap data |
| $A800 | 240B | Player 1 display buffer (60 laps × 4) |
| $A8F0 | 240B | Player 2 display buffer (60 laps × 4) |
| $FDAA | ? | Best time table base |

---

## Performance Characteristics

### Cycle Estimates

| Function | Cycles (approx) | Frequency | Total/Frame |
|----------|----------------|-----------|-------------|
| Timer countdown (×8) | 32 | Every frame | 32 |
| Display state update | 40-60 | When $C04E > 0 | 0-60 |
| Time comparison | 100-200 | On lap completion | Variable |
| Number formatting | 80-120 | When displaying time | Variable |
| VDP writes | 20-40 | Per display update | Variable |

**Total Overhead:** ~50-300 cycles per frame depending on active features

---

## Integration Points

### Called By

This module is called from:
- V-INT state handlers (states 6, 9, 13, 14) for display updates
- Game initialization (game_logic_1.asm) - Function at $008548
- Main game loop for timer updates

### Calls To

This module calls:
- $00B3CE - Time copy/format function
- $00B386 - Time processing function
- $00B478 - Comparison helper
- $00B3BC - Display dispatcher

---

## Design Patterns

### Pattern 1: Zero-Bounded Countdown

Used for all 8 timers:
```asm
TST.W  timer
BLE    skip_decrement
SUBQ.W #1, timer
skip_decrement:
```

**Benefits:**
- Prevents underflow
- Timer stays at 0 when expired
- 4 cycles per timer (efficient)

### Pattern 2: Flag-Triggered Update

Used for all display functions:
```asm
BTST   #bit, flags
BEQ    skip_update
ANDI.W #mask, flags    ; Clear flag immediately
; ... perform update ...
```

**Benefits:**
- Updates only when needed
- Auto-acknowledgment prevents repeats
- Decouples trigger from handler

### Pattern 3: Index-Based Dispatch

Used for mode selection:
```asm
MOVE.B  mode_register, D0
ANDI.W  #$00C0, D0         ; Isolate bits 6-7
LSR.W   #shift, D0         ; Convert to table index
MOVEA.L table(PC,D0.W), A1
JSR     (A1)
```

**Benefits:**
- Fast mode switching
- Extensible (add modes to table)
- PC-relative (position-independent)

---

## Related Documentation

- [GAME_LOGIC_INITIALIZATION.md](GAME_LOGIC_INITIALIZATION.md) - Game initialization architecture
- [VINT_STATE_HANDLERS.md](VINT_STATE_HANDLERS.md) - V-INT state machine
- [VINT_HANDLER_ARCHITECTURE.md](VINT_HANDLER_ARCHITECTURE.md) - V-INT interrupt handling

---

**Last Updated:** 2026-01-17
**Status:** ✅ Complete architectural analysis
**Module:** game_logic_2.asm (2.5KB, 97 functions, 21 JSR calls)
