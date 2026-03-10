# Game Logic - Scene Sequencer and State Manager

**Module:** [disasm/modules/68k/game/game_logic_4.asm](../disasm/modules/68k/game/game_logic_4.asm)
**Address Range:** $00C200-$00D1D4 (~4KB)
**Status:** ✅ Complete analysis with decoded mnemonics
**Date:** 2026-01-17

---

## Overview

This module implements the game's master sequencer - a hierarchical state machine that orchestrates scene transitions, data loading, and synchronization between 68K and SH2 CPUs. It manages the flow from boot → attract mode → game start → gameplay → results.

**Key Statistics:**
- **999 total lines**
- **60 function labels**
- **87 JSR function calls**
- **4 nested state machines** with jump table dispatchers

**Primary Subsystems:**
1. **Master Initialization** - Boot sequence and 32X setup
2. **Sequence State Machine** - Main scene progression ($C87E)
3. **Sub-Sequence State Machine** - Scene-specific steps ($C8C4)
4. **Transition State Machine** - Inter-scene transitions ($C8F4)
5. **Data Loading** - ROM → RAM transfers for scenes
6. **32X Synchronization** - COMM register protocols

---

## Architecture Overview

### Hierarchical State Machine Structure

```
Master Sequencer ($00C200)
├── Main Initialization
│   └── 32X adapter setup
│
├── Sequence State ($C87E)
│   ├── State 0: Scene A setup
│   ├── State 4: Scene B setup
│   ├── State 8: Scene C setup
│   └── State 16: Scene D setup
│
├── Sub-Sequence ($C8C4)
│   ├── State 0: Load data
│   ├── State 4: Process
│   ├── State 8: Display
│   └── State 12: Cleanup
│
└── Transition State ($C8F4)
    ├── State 0: Idle
    ├── State 4: Begin transition
    ├── State 8: Wait sync
    └── State 12: Complete
```

---

## State Machine Variables

### Primary State Registers

| Address | Purpose | Update Pattern | Range |
|---------|---------|----------------|-------|
| $C87E | Sequence state | ADDQ.W #4 | 0, 4, 8, 12, 16+ |
| $C8C4 | Sub-sequence state | ADDQ.B #4 | 0-255 (byte) |
| $C886 | Frame counter | ADDQ.B #1 | 0-255 (byte) |
| $C8F4 | Transition state | ADDQ.B #4 | 0, 4, 8, 12 |
| $C8AA | Game state progress | ADDQ.W #1 | 0-65535 |
| $C080 | Timeline counter | ADDQ.W #1 | 0-65535 |

### Supporting State Variables

| Address | Purpose | Type |
|---------|---------|------|
| $C87E | Master sequence index | word |
| $C8C0 | Data pointer | word |
| $C8C5 | Timer value | byte |
| $C809 | SH2 enable flag | byte |
| $C80A | Display mode | byte |
| $C80E | Sync flags | byte (bits 6, 7) |
| $C802 | Command flag | byte |
| $C81C | Debug/mode flags | byte (bits 0, 7) |

---

## Master Initialization Sequence

### Boot Entry Point ($00C200)

**Purpose:** Initialize all game subsystems and prepare for first scene

**Code Structure:**

```asm
        DC.W    $41F8,$9000         ; LEA     $9000.W,A0      ; Object array base
        DC.W    $4EBA,$DFF6         ; JSR     $00A1FC(PC)     ; Clear objects
        DC.W    $4EBA,$076A         ; JSR     track_segment_init(PC)  ; Init subsystem 1
        DC.W    $4EBA,$0CFE         ; JSR     scene_param_setup(PC)  ; Init subsystem 2
        DC.W    $4EBA,$09F4         ; JSR     object_array_init_rom_tables(PC)  ; Init subsystem 3
        DC.W    $4EBA,$0D98         ; JSR     scene_display_init(PC)  ; Init subsystem 4
```

**State Initialization ($00C218):**

```asm
        DC.W    $31FC,$0000,$C87E   ; MOVE.W  #$0000,$C87E.W  ; Reset sequence
        DC.W    $31FC,$0000,$C8F4   ; MOVE.W  #$0000,$C8F4.W  ; Reset transition
        DC.W    $08B8,$0007,$FEB7   ; BCLR    #7,$FEB7.W      ; Clear VDP flag
        DC.W    $08B8,$0000,$C81C   ; BCLR    #0,$C81C.W      ; Clear mode flag
        DC.W    $31FC,$C9A0,$C8C0   ; MOVE.W  #$C9A0,$C8C0.W  ; Data pointer
        DC.W    $11FC,$0002,$C80A   ; MOVE.B  #$0002,$C80A.W  ; Display mode 2
```

**32X Adapter Setup ($00C24C):**

```asm
        DC.W    $0239,$00FC,$00A1,$5181 ; ANDI.B  #$00FC,$00A15181  ; Clear RV bits
        DC.W    $0039,$0001,$00A1,$5181 ; ORI.B   #$0001,$00A15181  ; Set RV bit 0
        DC.W    $33FC,$8083,$00A1,$5100 ; MOVE.W  #$8083,$00A15100  ; Enable 32X
```

**COMM Register Protocol:**
- $A15181: RV (ROM/VRES control) - Set bit 0 for SH2 access
- $A15100: Adapter control register - $8083 enables 32X mode

---

### Synchronization Wait Loop ($00C28C)

**Purpose:** Wait for system stabilization before scene start

```asm
        DC.W    $31FC,$0080,$A000   ; MOVE.W  #$0080,$A000.W  ; Timer = 128 frames

.frame_loop:
        DC.W    $4EB9,$0088,$2080   ; JSR     $00882080       ; Update system
        DC.W    $4EB9,$0088,$4998   ; JSR     $00884998       ; Process frame
        DC.W    $5378,$A000         ; SUBQ.W  #1,$A000.W      ; Decrement timer
        DC.W    $66EE               ; BNE.S  .frame_loop      ; Loop until 0
```

**Pattern:** Busy-wait loop for ~2 seconds (128 frames @ 60fps)

---

### SH2 Handshake Protocol ($00C2C0)

**Purpose:** Wait for SH2 to signal ready

```asm
.wait_sh2:
        DC.W    $0839,$0000,$00A1,$5123 ; BTST    #0,$00A15123   ; Check COMM3 bit 0
        DC.W    $67F6               ; BEQ.S  .wait_sh2      ; Wait until set
        DC.W    $08B9,$0000,$00A1,$5123 ; BCLR    #0,$00A15123   ; Clear handshake
```

**COMM3 Protocol:**
- SH2 sets bit 0 when initialization complete
- 68K acknowledges by clearing bit 0
- Prevents race conditions during startup

---

## Sequence State Machine

### Main Dispatcher ($00C30A)

**Purpose:** Route to scene-specific handlers based on sequence state

**Code:**

```asm
        DC.W    $3038,$C87E         ; MOVE.W  $C87E.W,D0      ; Load state
        DC.W    $227B,$0004         ; MOVEA.L $04(PC,D0.W),A1 ; Get handler
        DC.W    $4ED1               ; JMP     (A1)            ; Jump to handler
```

**Jump Table ($00C314):**

| State | Address | Handler | Purpose |
|-------|---------|---------|---------|
| 0 | $00C328 | Scene_Setup_A | Initial scene setup |
| 4 | $00C368 | Scene_Setup_B | Alternate setup |
| 8 | $00C390 | Scene_Setup_C | Gameplay setup |
| 12 | $00C3FC | Scene_Setup_D | Results/transition |

**State Progression Pattern:**
```
Init → State 0 → State 4 → State 8 → State 12 → Loop/Exit
```

---

### Scene Setup A ($00C328)

**Purpose:** Primary scene initialization

**Operations:**

```asm
        DC.W    $4EB9,$0088,$28C2   ; JSR     $008828C2       ; Load graphics data
        DC.W    $4EB9,$0088,$21CA   ; JSR     $008821CA       ; Init display
        DC.W    $3F38,$C86C         ; MOVE.W  $C86C.W,-(A7)   ; Save state
        DC.W    $31FC,$FF00,$C86C   ; MOVE.W  #$FF00,$C86C.W  ; Temp state
        DC.W    $0838,$0000,$C81C   ; BTST    #0,$C81C.W      ; Check debug
        DC.W    $6606               ; BNE.S  .skip_sfx
        DC.W    $4EB9,$0088,$88BE   ; JSR     $008888BE       ; Load scene data
.skip_sfx:
        DC.W    $31DF,$C86C         ; MOVE.W  (A7)+,$C86C.W   ; Restore state
        DC.W    $4EB9,$0088,$58C8   ; JSR     $008858C8       ; Finalize
```

**State Advancement:**

```asm
        DC.W    $5238,$C886         ; ADDQ.B  #1,$C886.W      ; Increment frame
        DC.W    $5878,$C87E         ; ADDQ.W  #4,$C87E.W      ; Next state
        DC.W    $33FC,$0010,$00FF,$0008 ; MOVE.W  #$0010,$00FF0008  ; Frame delay
```

**Frame Delay:** $00FF0008 = frame sync register (16 frames = ~267ms)

---

### Scene Setup C ($00C390) - Gameplay Entry

**Purpose:** Initialize gameplay scene with track data

**Track Data Loading ($00C3A4):**

```asm
        DC.W    $21FC,$FFFF,$0000,$C970 ; MOVE.L  #$FFFF0000,$C970.W  ; Display flags
        DC.W    $3078,$C8C0         ; MOVEA.W $C8C0.W,A0      ; Load data pointer
        DC.W    $1018               ; MOVE.B  (A0)+,D0        ; Read byte
        DC.W    $1200               ; MOVE.B  D0,D1           ; Copy
        DC.W    $0200,$005C         ; ANDI.B  #$005C,D0       ; Mask bits 6-4,3-2
        DC.W    $11C0,$C971         ; MOVE.B  D0,$C971.W      ; Store track config
        DC.W    $0201,$0003         ; ANDI.B  #$0003,D1       ; Mask bits 1-0
        DC.W    $11C1,$C973         ; MOVE.B  D1,$C973.W      ; Store laps
        DC.W    $31C8,$C8C0         ; MOVE.W  A0,$C8C0.W      ; Update pointer
```

**Track Configuration Byte:**
```
Bits 6-4: Track selection (0-7)
Bits 3-2: Difficulty (0-3)
Bits 1-0: Lap count (0-3)
```

**Subsystem Initialization:**

```asm
        DC.W    $4EB9,$0088,$593C   ; JSR     $0088593C       ; Load track geometry
        DC.W    $4EB9,$0088,$24CA   ; JSR     $008824CA       ; Init AI opponents
        DC.W    $4EBA,$F304         ; JSR     $00B6DA(PC)     ; Init physics
        DC.W    $4EBA,$F2AA         ; JSR     $00B684(PC)     ; Init rendering
```

---

## Sub-Sequence State Machine

### Dispatcher ($00C45E)

**Purpose:** Handle scene-specific sub-steps

**Code:**

```asm
        DC.W    $7000               ; MOVEQ   #$00,D0
        DC.W    $1038,$C8C4         ; MOVE.B  $C8C4.W,D0      ; Load sub-state
        DC.W    $227B,$0004         ; MOVEA.L $04(PC,D0.W),A1 ; Get handler
        DC.W    $4ED1               ; JMP     (A1)            ; Jump
```

**Jump Table ($00C470):**

| State | Handler | Purpose |
|-------|---------|---------|
| 0 | $00C480 | Load phase |
| 4 | $00C4A4 | Process phase |
| 8 | $00C4C2 | Display phase |
| 12 | $00C53C | Cleanup/transition |

---

### Timeline-Based Trigger ($00C416)

**Purpose:** Trigger events at specific frame counts

**Lookup Table ($00C44C):**

```asm
        DC.W    $0089               ; Frame 137
        DC.W    $0117               ; Frame 279
        DC.W    $016A               ; Frame 362
        DC.W    $01E0               ; Frame 480
        DC.W    $025E               ; Frame 606
        DC.W    $02E2               ; Frame 738
        DC.W    $034D               ; Frame 845
        DC.W    $1000               ; End marker
```

**Trigger Logic:**

```asm
        DC.W    $7000               ; MOVEQ   #$00,D0
        DC.W    $1038,$C8F5         ; MOVE.B  $C8F5.W,D0      ; Load table index
        DC.W    $303B,$002E         ; MOVE.W  $2E(PC,D0.W),D0 ; Load frame target
        DC.W    $B078,$C080         ; CMP.W  $C080.W,D0      ; Compare with timeline
        DC.W    $6624               ; BNE.S  .done      ; Skip if not matched

        ; Match found - trigger action
        DC.W    $31FC,$0010,$C87E   ; MOVE.W  #$0010,$C87E.W  ; Change sequence
        DC.W    $31FC,$0C00,$C8C4   ; MOVE.W  #$0C00,$C8C4.W  ; Reset sub-sequence
        DC.W    $5438,$C8F5         ; ADDQ.B  #2,$C8F5.W      ; Next table entry
```

**Pattern:** Event system for cutscenes and timed events

---

## Transition State Machine

### State Flow ($00C662)

**Purpose:** Manage transitions between scenes with fade/sync

**Dispatcher:**

```asm
        DC.W    $7000               ; MOVEQ   #$00,D0
        DC.W    $1038,$C8F4         ; MOVE.B  $C8F4.W,D0      ; Load state
        DC.W    $227B,$0004         ; MOVEA.L $04(PC,D0.W),A1 ; Get handler
        DC.W    $4ED1               ; JMP     (A1)            ; Jump
```

**Jump Table ($00C66E):**

| State | Handler | Purpose |
|-------|---------|---------|
| 0 | $00C67E | Idle (no transition) |
| 4 | $00C680 | Begin transition |
| 8 | $00C6A4 | Wait for sync |
| 12 | $00C6B6 | Complete transition |

---

### Begin Transition ($00C680)

**Purpose:** Start scene transition with SH2 sync

```asm
        DC.W    $11FC,$0001,$C809   ; MOVE.B  #$0001,$C809.W  ; Enable SH2
        DC.W    $11FC,$0001,$C80A   ; MOVE.B  #$0001,$C80A.W  ; Display mode 1
        DC.W    $08F8,$0007,$C80E   ; BSET    #7,$C80E.W      ; Set sync flag
        DC.W    $11FC,$0001,$C802   ; MOVE.B  #$0001,$C802.W  ; Command flag
        DC.W    $11FC,$00F3,$C822   ; MOVE.B  #$00F3,$C822.W  ; Fade value
        DC.W    $5838,$C8F4         ; ADDQ.B  #4,$C8F4.W      ; Next state
```

**Sync Protocol:**
- Set flag bit 7 at $C80E
- SH2 checks this flag and clears it when ready
- 68K waits in next state

---

### Wait for Sync ($00C6A4)

**Purpose:** Wait for SH2 to acknowledge transition

```asm
        DC.W    $0838,$0007,$C80E   ; BTST    #7,$C80E.W      ; Check sync flag
        DC.W    $6608               ; BNE.S  .done      ; Still waiting
        DC.W    $3ABC,$8B00         ; MOVE.W  #$8B00,(A5)     ; Z80 command
        DC.W    $5838,$C8F4         ; ADDQ.B  #4,$C8F4.W      ; Next state
.done:
        DC.W    $4E75               ; RTS
```

**Pattern:** Busy-wait until SH2 clears sync flag

---

### Complete Transition ($00C6B6)

**Purpose:** Finalize transition and return to main loop

```asm
        DC.W    $11FC,$0000,$C8F4   ; MOVE.B  #$0000,$C8F4.W  ; Reset state
        DC.W    $08B8,$0007,$C81C   ; BCLR    #7,$C81C.W      ; Clear mode flag
        DC.W    $23FC,$0089,$4262,$00FF,$0002 ; MOVE.L  #$00894262,$00FF0002
        DC.W    $33FC,$0020,$00FF,$0008 ; MOVE.W  #$0020,$00FF0008  ; 32 frame delay
        DC.W    $4EF9,$0088,$2890   ; JMP     $00882890       ; Return to main
```

**Cleanup:**
- Reset transition state
- Clear flags
- Set interrupt vector at $00FF0002
- Final frame delay before loop

---

## Data Loading System

### ROM Data Transfer ($00C6DA)

**Purpose:** Load scene-specific data from ROM to RAM buffers

**Multiple Data Blocks:**

```asm
        ; Block 1: Graphics data
        DC.W    $43F9,$008B,$B45C   ; LEA     $008BB45C,A1    ; Source ROM
        DC.W    $45F8,$B000         ; LEA     $B000.W,A2      ; Dest RAM
        DC.W    $4EBA,$8204         ; JSR     $0048EA(PC)     ; Copy function

        ; Block 2: Palette data
        DC.W    $43F9,$008B,$AFC4   ; LEA     $008BAFC4,A1
        DC.W    $45F8,$B400         ; LEA     $B400.W,A2
        DC.W    $4EBA,$81DE         ; JSR     $0048D2(PC)

        ; Block 3: Track-specific data (indexed)
        DC.W    $43F9,$008B,$A220   ; LEA     $008BA220,A1    ; Table base
        DC.W    $3038,$C8A0         ; MOVE.W  $C8A0.W,D0      ; Track index
        DC.W    $2271,$0000         ; MOVEA.L $00(A1,D0.W),A1 ; Get address
        DC.W    $45F9,$00FF,$6E00   ; LEA     $00FF6E00,A2    ; VDP dest
        DC.W    $4EBA,$81C6         ; JSR     $0048D2(PC)     ; Copy
```

**Data Blocks Loaded:**
- $008BB45C → $B000: Graphics tiles (sprites/backgrounds)
- $008BAFC4 → $B400: Palette data
- $008BA220[track] → $FF6E00: Track-specific VDP data
- $008BAE38[lap] → $FF6E40: Lap-specific data

---

### Speed Table Initialization ($00C7C2)

**Purpose:** Load speed/acceleration values for vehicles

**Table Data:**

```asm
        DC.W    $04A9,$0483,$0471,$046E  ; Speed values
        DC.W    $0462,$0456,$0444,$0433
        DC.W    $0429,$040E,$03F3,$03E2
        DC.W    $03D7,$03C1,$03C0
```

**15 Speed Entries:** Different values for vehicle types/modes

**Loading Code ($00C784):**

```asm
        DC.W    $48E7,$FFFE         ; MOVEM.L -(A7),D1-D7/A0-A7  ; Save all regs
        DC.W    $43FA,$0036         ; LEA     $0036(PC),A1    ; Speed table
        DC.W    $45F8,$9100         ; LEA     $9100.W,A2      ; Object array
        DC.W    $700E               ; MOVEQ   #$0E,D0         ; 15 iterations

.copy_sort_keys:
        DC.W    $3551,$00B6         ; MOVE.W  (A1),$00B6(A2)  ; Copy to offset $B6
        DC.W    $3559,$000A         ; MOVE.W  (A1)+,$000A(A2) ; Copy to offset $A
        DC.W    $45EA,$0100         ; LEA     $0100(A2),A2    ; Next object (+256)
        DC.W    $51C8,$FFF2         ; DBRA    D0,.copy_sort_keys   ; Loop
```

**Pattern:** Copy speed values to 15 objects at $9100, $9200, ..., $9E00

---

## Gameplay Initialization

### Camera and View Setup ($00C752)

**Purpose:** Initialize 3D camera and display parameters

**Camera Position ($00C73A):**

```asm
        DC.W    $21F8,$EEFC,$C254   ; MOVE.L  $EEFC.W,$C254.W  ; Camera origin
        DC.W    $31FC,$00C0,$C054   ; MOVE.W  #$00C0,$C054.W   ; X position
        DC.W    $31FC,$0540,$C056   ; MOVE.W  #$0540,$C056.W   ; Y position
        DC.W    $31FC,$0000,$C896   ; MOVE.W  #$0000,$C896.W   ; Z offset
```

**3D Projection Parameters ($00C75A):**

```asm
        DC.W    $31FC,$00C0,$C0C8   ; MOVE.W  #$00C0,$C0C8.W   ; FOV horizontal
        DC.W    $31FC,$07D0,$C8D4   ; MOVE.W  #$07D0,$C8D4.W   ; Near plane
        DC.W    $31FC,$0600,$C8D6   ; MOVE.W  #$0600,$C8D6.W   ; Far plane
        DC.W    $31FC,$3000,$C8D8   ; MOVE.W  #$3000,$C8D8.W   ; Projection scale
```

**Camera Tracking ($00C772):**

```asm
        DC.W    $31FC,$0000,$C8DA   ; MOVE.W  #$0000,$C8DA.W   ; Track X offset
        DC.W    $31FC,$00C0,$C8DC   ; MOVE.W  #$00C0,$C8DC.W   ; Track Y offset
        DC.W    $31FC,$0540,$C8DE   ; MOVE.W  #$0540,$C8DE.W   ; Track Z offset
```

---

### Countdown Timer Setup ($00C5AE)

**Purpose:** Manage race start countdown and transitions

**Countdown Trigger Logic:**

```asm
        DC.W    $3038,$C080         ; MOVE.W  $C080.W,D0      ; Load timeline
        DC.W    $0C40,$03E3         ; CMPI.W  #$03E3,D0       ; Frame 995?
        DC.W    $6D00,$00A8         ; BLT.W  countdown_done      ; Skip if before
        DC.W    $0C40,$03E3         ; CMPI.W  #$03E3,D0       ; Exact match?
        DC.W    $6658               ; BNE.S  countdown_timer_update_anim_race_start      ; Skip if after
```

**Countdown Start ($00C5C0):**

```asm
        DC.W    $08F8,$0000,$C81C   ; BSET    #0,$C81C.W      ; Set countdown flag
        DC.W    $31FC,$00C0,$C0C8   ; MOVE.W  #$00C0,$C0C8.W  ; Camera setting
        DC.W    $33FC,$0100,$00FF,$60CC ; MOVE.W  #$0100,$00FF60CC  ; Display flag
```

**Countdown Update ($00C618):**

```asm
        DC.W    $5478,$C0C6         ; ADDQ.W  #2,$C0C6.W      ; Increment counter
        DC.W    $0C78,$0030,$C0C6   ; CMPI.W  #$0030,$C0C6.W  ; Max = 48?
        DC.W    $6F06               ; BLE.S  .advance_zoom
        DC.W    $31FC,$0030,$C0C6   ; MOVE.W  #$0030,$C0C6.W  ; Clamp to 48
```

**Camera Transition ($00C62A):**

```asm
        DC.W    $0678,$0080,$C0B0   ; ADDI.W  #$0080,$C0B0.W  ; Zoom in
        DC.W    $0C78,$1000,$C0B0   ; CMPI.W  #$1000,$C0B0.W  ; Max zoom?
        DC.W    $6F06               ; BLE.S  .check_prerace
        DC.W    $31FC,$1000,$C0B0   ; MOVE.W  #$1000,$C0B0.W  ; Clamp
```

**Race Start Trigger ($00C64C):**

```asm
        DC.W    $0C78,$0510,$C080   ; CMPI.W  #$0510,$C080.W  ; Frame 1296?
        DC.W    $6D0C               ; BLT.S  countdown_done      ; Skip if before
        DC.W    $11FC,$0004,$C8F4   ; MOVE.B  #$0004,$C8F4.W  ; Start transition
```

**Timeline:**
- Frame 995: Countdown begins
- Frame 995-1295: Camera zooms in (300 frames = 5 seconds)
- Frame 1296: Race starts

---

## Memory Map Summary

### Sequence State Variables

| Address | Size | Purpose | Initial Value |
|---------|------|---------|---------------|
| $C87E | word | Sequence state | $0000 |
| $C8C4 | word | Sub-sequence state | varies |
| $C886 | byte | Frame counter | incremented |
| $C8F4 | byte | Transition state | $00 |
| $C8AA | word | Game progress | incremented |
| $C080 | word | Timeline counter | incremented |
| $C8C0 | word | Data pointer | $C9A0 |
| $C8F5 | byte | Event table index | $00 |

### Display/Camera Parameters

| Address | Size | Purpose | Value |
|---------|------|---------|-------|
| $C054 | word | Camera X | $00C0 |
| $C056 | word | Camera Y | $0540 |
| $C896 | word | Camera Z offset | $0000 |
| $C0C8 | word | FOV/viewport | $00C0 |
| $C0C6 | word | Countdown counter | $0000-$0030 |
| $C0B0 | word | Zoom level | $0000-$1000 |
| $C8D4 | word | Near plane | $07D0 |
| $C8D6 | word | Far plane | $0600 |
| $C8D8 | word | Projection scale | $3000 |

### Track Configuration

| Address | Size | Purpose |
|---------|------|---------|
| $C971 | byte | Track selection + difficulty |
| $C973 | byte | Lap count |
| $C970 | long | Display flags |
| $C254 | long | Camera origin |

### 32X Communication

| Address | Purpose |
|---------|---------|
| $A15100 | 32X adapter control ($8083 = enable) |
| $A15181 | RV control (bit 0 = SH2 access) |
| $A15123 | COMM3 - Handshake register |

---

## Integration Points

### Called By

This module is the **master sequencer** - it is called from:
- Boot initialization (initial entry at $00C200)
- Main game loop (returns to $00882890)
- V-INT handlers for frame updates

### Calls To

This module calls:
- **$00A1FC** - Clear object array
- **$0048EA/$0048D2** - Data copy functions
- **$00882080** - System update
- **$00884998** - Frame processor
- **$008821CA** - Display init
- **$008828C2** - Graphics loader
- **$0088593C** - Track geometry
- **$008824CA** - AI initialization
- **$00B6DA/$00B684** - Physics/rendering init

---

## Design Patterns

### Pattern 1: Hierarchical State Machines

Multiple state machines with different granularities:
```
Main Sequence (scenes) → Sub-Sequence (steps) → Transition (sync)
```

**Benefits:**
- Clear separation of concerns
- Easy to add new scenes
- Parallel state tracking

### Pattern 2: Timeline-Based Events

Frame counter with lookup table:
```
if (timeline_counter == event_table[index])
    trigger_event()
    index++
```

**Benefits:**
- Precise timing control
- Easy to author sequences
- No polling overhead

### Pattern 3: Synchronous Data Loading

ROM → RAM transfers before scene start:
```
begin_transition()
load_all_data()
wait_for_sync()
start_scene()
```

**Benefits:**
- No loading during gameplay
- Predictable performance
- Clean scene boundaries

### Pattern 4: Indexed Data Blocks

Track-specific data via indirection:
```
table_base = $008BA220
data_address = table_base[track_index]
copy(data_address, vdp_buffer)
```

**Benefits:**
- Compact storage
- Fast lookup
- Easy to add tracks

---

## Performance Characteristics

### Cycle Estimates

| Operation | Cycles (approx) | Frequency | Notes |
|-----------|----------------|-----------|-------|
| State dispatch | 30-50 | Per frame | Jump table lookup |
| Timeline check | 20-40 | Per frame | Compare + branch |
| Data loading | 10000+ | Scene transitions | DMA transfers |
| Sync wait | Variable | Transitions | SH2-dependent |

**Initialization Overhead:** ~8000 cycles for full scene setup

---

## Related Documentation

- [GAME_LOGIC_INITIALIZATION.md](GAME_LOGIC_INITIALIZATION.md) - Game initialization
- [GAME_LOGIC_TIMERS_DISPLAY.md](GAME_LOGIC_TIMERS_DISPLAY.md) - Timer management
- [GAME_LOGIC_AI_PHYSICS.md](GAME_LOGIC_AI_PHYSICS.md) - AI and physics
- [VINT_STATE_HANDLERS.md](VINT_STATE_HANDLERS.md) - V-INT state machine
- [68K_SH2_COMMUNICATION.md](68K_SH2_COMMUNICATION.md) - COMM protocols

---

**Last Updated:** 2026-01-17
**Status:** ✅ Complete architectural analysis
**Module:** game_logic_4.asm (4KB, 60 functions, 87 JSR calls)
