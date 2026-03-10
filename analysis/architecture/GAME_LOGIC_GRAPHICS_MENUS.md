# Game Logic Module: Graphics, Menus & UI Rendering ($00E200-$010200)

## Overview

**File**: `disasm/modules/68k/game/game_0e200.asm`
**Address Range**: $00E200-$010200 (8,192 bytes)
**Module Size**: 2,267 lines, 190 functions, 115 JSR/BSR calls
**Purpose**: Menu system, track/option selection screens, UI rendering, and SH2 graphics command submission

This module implements the game's **menu and selection screen system**, handling:
- Track selection menus with preview rendering
- Option/difficulty selection screens
- Player-specific UI rendering (split-screen support)
- Graphics data loading and palette management
- SH2 rendering command protocol
- Input handling for menu navigation

---

## Architecture Overview

### 1. Module Structure

```
┌─────────────────────────────────────────────────────────────┐
│                   Menu & Graphics Module                     │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌──────────────────┐  ┌──────────────────┐                │
│  │  SH2 Command     │  │  Graphics Data   │                │
│  │  Protocol        │  │  Loading System  │                │
│  │  ($00E316-$00E464│  │  ($00E2F0-$00E2E4│                │
│  └──────────────────┘  └──────────────────┘                │
│                                                               │
│  ┌──────────────────────────────────────────────────────┐  │
│  │          Four State Machine Dispatchers               │  │
│  ├──────────────────────────────────────────────────────┤  │
│  │  1. Track Selection Menu     ($00E90C dispatcher)    │  │
│  │  2. Options/Settings Menu    ($00F41C dispatcher)    │  │
│  │  3. Results/Statistics       ($01012E dispatcher)    │  │
│  │  4. Replay/Attract Mode      ($01014E dispatcher)    │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                               │
│  ┌──────────────────┐  ┌──────────────────┐                │
│  │  Text/Digit      │  │  Input Handler   │                │
│  │  Rendering       │  │  (Menu Nav)      │                │
│  │  ($00E466-$00E4BC│  │  ($00EA0E-$00EAB4│                │
│  └──────────────────┘  └──────────────────┘                │
│                                                               │
└─────────────────────────────────────────────────────────────┘
```

### 2. State Machine Architecture

All four menu screens share the same state machine infrastructure:

**State Variable**: $C87E (sequence state, shared with `game_logic_4.asm`)
**State Transitions**:
- `ADDQ.W #4,$C87E` → Advance to next state
- `SUBQ.W #4,$C87E` → Return to previous state
- `MOVE.W #0,$C87E` → Reset to state 0

**Dispatcher Pattern** (used 4 times):
```asm
JSR     $00882080           ; Common pre-dispatch function
MOVE.W  $C87E.W,D0          ; Load current state
MOVEA.L $04(PC,D0.W),A1     ; Index into jump table
JMP     (A1)                ; Jump to state handler
```

---

## SH2 Communication Protocol

### SH2 Command Submission Functions

The module defines **6 main SH2 command submission functions** using COMM registers:

| Function Address | Purpose | COMM Registers Used | Command Code Register |
|-----------------|---------|-------------------|---------------------|
| `sh2_send_cmd_wait` ($00E316) | Data transfer (ROM→SH2) | $A15128 (addr), $A1512C (status) | $A15121 ($25) |
| `sh2_send_cmd` ($00E35A) | Graphics command (2 params) | $A15128, $A1512C | $A15121 ($22) |
| `sh2_cmd_27` ($00E3B4) | Sprite/tile command | $A15128, $A1512C | $A15121 ($27) |
| `sh2_cmd_2F` ($00E406) | Extended command (3 params) | $A15128-$A1512C | $A15121 ($2F) |
| `DigitToASCII` | Text rendering command | Custom protocol | $A15121 ($21) |
| `sh2_send_cmd_wait` ($00E316) (alt) | Palette upload | $A15128, $A1512C | $A15121 ($03) |

### Command Codes Documented

| Code | Purpose | Parameters | Example Usage |
|------|---------|-----------|---------------|
| $03 | System command | Varies | Initialization sequences |
| $21 | Text rendering | String data address | Menu text display |
| $22 | Graphics operation (2-param) | D0, D1 (coords/size) | Tile copy operations |
| $25 | Data transfer | A0 (src ROM), A1 (dst SH2) | Load graphics to SDRAM |
| $27 | Sprite command | A0 (data), D0-D1 (params) | Sprite rendering |
| $2A | HUD/UI update | Complex structure | Real-time UI updates |
| $2D | Palette operation | Palette data | Color updates |
| $2F | Extended operation (3-param) | D0-D2 (coords/size/flags) | Complex rendering |

### SH2 Communication Pattern

All SH2 commands follow this synchronization protocol:

```asm
sh2_send_cmd_wait:  ; Example: Data Transfer Command ($25)
    ; Wait for SH2 ready
    TST.B   $00A15120           ; Check SH2 busy flag
    BNE.S   sh2_send_cmd_wait   ; Spin until clear

    ; Convert ROM address to SH2 address space
    ADDA.L  #$02000000,A0       ; ROM offset → SH2 address

    ; Set up parameters
    MOVE.L  A0,$00A15128        ; COMM4/5: Source address
    MOVE.W  #$0101,$00A1512C    ; COMM6: Size/flags

    ; Issue command
    MOVE.B  #$0025,$00A15121    ; COMM0+1: Command code
    MOVE.B  #$0001,$00A15120    ; COMM0: Trigger SH2

    ; Wait for completion
.wait_consumed:
    TST.B   $00A1512C           ; Check completion flag
    BNE.S   .wait_consumed      ; Wait for SH2 acknowledgment

    RTS
```

**Key COMM Registers**:
- `$A15120` (COMM0): SH2 busy flag (0=ready, 1=busy)
- `$A15121` (COMM0+1): Command code
- `$A15128-$A1512B` (COMM4-5): Parameter 1 (often address)
- `$A1512C-$A1512F` (COMM6-7): Parameter 2 (often size/flags)

---

## State Machine Dispatchers

### Dispatcher 1: Track Selection Menu ($00E90C)

**Entry Point**: $00E90C
**Jump Table**: $00E91C
**States Identified**:
- **State 0** ($00E93A): Load track preview graphics, load palettes
- **State 4** ($00EDDA): Handle track selection input, render selection cursor
- **State 8** ($00EEF2): Confirm selection, transition to next screen

**Key Operations**:
```asm
$00E93A:  ; State 0 - Initialize track selection
    ; Load track preview graphics to SH2 SDRAM
    MOVEA.L #$06038000,A0       ; SH2 SDRAM destination
    MOVEA.L #$04012010,A1       ; Graphics data offset
    MOVE.W  #$0120,D0           ; Width: 288 pixels
    MOVE.W  #$0030,D1           ; Height: 48 lines
    JSR     sh2_send_cmd(PC)    ; Submit graphics command ($22)

    ; Load track-specific palette
    MOVEQ   #$00,D0
    TST.B   $A01A.W             ; Check player 2 active
    BNE.S   use_p2_track
    MOVE.B  $A019.W,D0          ; Player 1 track index

use_p2_track:
    ; Index into track palette table ($0088EACE)
    ; Copy 128 words of palette data to $00FF6E00
```

**Memory Variables**:
- `$A019`: Player 1 track selection (0-2)
- `$A01A`: Player 2 active flag
- `$A01E`: Player 2 track selection
- `$A014.L`: Graphics buffer pointer

### Dispatcher 2: Options/Difficulty Menu ($00F41C)

**Entry Point**: $00F41C
**Jump Table**: $00F42C
**States Identified**:
- **State 0** ($00F44C): Load options menu graphics
- **State 4** ($00F6E2): Handle option selection (difficulty, laps, etc.)
- **State 8** ($00F85C): Confirm and save options

**Key Operations**:
```asm
$00F44C:  ; State 0 - Initialize options menu
    CLR.W   D0
    MOVE.B  $A01B.W,D0          ; Load current option index
    BSR.W   sync_wait_reset     ; Render option selection

    ; Check for input
    TST.W   $A024.W             ; Input state
    BNE.W   multi_screen_palette_navigation_handler  ; Handle input

    MOVE.B  $A019.W,D0          ; Current selection
    MOVE.W  $C86C.W,D1          ; Button state
    BTST    #3,D1               ; Check D-pad up
    BEQ.S   check_down

    ; Increment selection (with wrapping)
    MOVE.B  #$00A9,$C8A4.W      ; Trigger cursor move sound
    TST.B   $A01B.W             ; Check option category
    BEQ.W   option_cat_0
    CMPI.B  #$0001,$A01B.W
    BEQ.W   option_cat_1
    CMPI.B  #$0004,D0           ; Max value for this category
    BLT.W   increment_selection
    CLR.B   D0                  ; Wrap to 0
```

**Memory Variables**:
- `$A01B`: Option category (0=difficulty, 1=laps, 2=time attack)
- `$A024`: Input state for options menu
- `$A019`: Current selection within category
- `$C8A4`: Sound effect trigger (menu cursor sound = $A9)

### Dispatcher 3: Results/Statistics Screen ($01012E)

**Entry Point**: $01012E
**Jump Table**: $010138
**States Identified**:
- **State 0** ($01017A): Initialize results display
- **State 4** ($010244): Render lap times and statistics
- **State 8** ($0104A2): Display final rankings
- **State C** ($0105DE): Wait for player confirmation

**Key Operations**:
```asm
$01017A:  ; State 0 - Display results
    CLR.W   D0
    BSR.W   mem_init_buffers          ; Initialize results UI (unresolved)
    JSR     $00B684(PC)         ; Load race statistics
    BSR.W   $01071C             ; Render results screen

    ; Load results graphics
    MOVEA.L #$0601AA00,A0       ; Results screen graphics
    MOVEA.L #$2400C060,A1       ; SH2 frame buffer position
    MOVE.W  #$0038,D0           ; Width
    MOVE.W  #$0010,D1           ; Height
    JSR     sh2_send_cmd(PC)    ; Submit to SH2

    ; Check for player 2 (split-screen results)
    BTST    #1,$A014.W          ; P2 active?
    BNE.S   load_p2_results
```

### Dispatcher 4: Replay/Attract Mode ($01014E)

**Entry Point**: $01014E
**Jump Table**: $010158
**Purpose**: Demo/attract mode playback or replay viewing

---

## Graphics Data Loading System

### VRAM Copy Function — vdp_block_load ($00E2F0)

Fast VRAM fill/copy operation for initializing 32X frame buffer:

```asm
vdp_block_load:
    MOVE.L  #$60000002,(A5)     ; VDP write command
    MOVEQ   #$1B,D0             ; 28 blocks to copy

.row_loop:
    MOVE.W  #$001F,D1           ; 32 words per block

.copy_data:
    MOVE.L  (A0)+,(A6)          ; Copy data to VRAM
    DBRA    D1,.copy_data

    ; Fill with zeros
    MOVE.W  #$001F,D1
.write_zeros:
    MOVE.L  #$00000000,(A6)     ; Clear next section
    DBRA    D1,.write_zeros

    DBRA    D0,.row_loop
    RTS
```

**Purpose**: Initialize 32X frame buffer with graphics patterns, used during scene transitions.

### Tile/Sprite Border Rendering — sh2_graphics_cmd ($00E22C)

Draws decorative borders around UI elements:

```asm
sh2_graphics_cmd:  ; Draw bordered rectangle
    ; Input: D0 = pattern index (0-3)
    ;        D1 = X coord (tiles)
    ;        D2 = Y coord (tiles)
    ;        D3 = width (tiles)
    ;        D4 = height (tiles)

    MOVEA.L A0,A1               ; Save base address
    LSL.W   #1,D1               ; X * 2 (words)
    LSL.W   #7,D2               ; Y * 128 (line stride)
    ADD.W   D2,D1               ; Y*128 + X*2
    LEA     $00(A0,D1.W),A0     ; Calculate address

    ; Encode tile pattern
    ANDI.W  #$0003,D0           ; Mask to 0-3
    LSL.W   #8,D0               ; Shift to tile pattern field
    LSL.W   #5,D0               ; Further shift
    ADDI.W  #$0100,D0           ; Add base tile index
    BCLR    #11,D0              ; Clear flip bits
    BCLR    #12,D0

    ; Draw top border
    MOVEQ   #$00,D1
    MOVE.W  #$0006,D2           ; Corner tile offset
    ADD.W   D0,D2
    MOVE.W  D2,(A0)             ; Top-left corner
    ADDA.L  #$00000080,A0       ; Next line

    ; ... (continues with edge and fill tiles)
```

**Pattern Encoding**:
- Bits 13-15: Pattern set (0-3 maps to different border styles)
- Bits 8-12: Tile index offset
- Bits 0-7: Unused

---

## Text and Digit Rendering

### Time Display Function ($00E466)

Renders race time in MM:SS.MS format:

```asm
$00E466:  ; Render time display
    MOVE.B  (A2)+,D1            ; Read minutes
    ANDI.W  #$000F,D1           ; Extract digit
    BSR.W   DigitToASCII        ; Render digit tile
    ADDQ.L  #8,A1               ; Advance position

    MOVE.W  #$000A,D1           ; Colon character
    BSR.W   DigitToASCII
    ADDQ.L  #8,A1

    MOVE.B  (A2)+,D2            ; Read seconds
    BSR.W   ByteProcessLoop     ; Render 2-digit number

    MOVE.W  #$000B,D1           ; Decimal point
    BSR.W   DigitToASCII
    ADDQ.L  #8,A1

    MOVE.B  (A2)+,D1            ; Read centiseconds
    ANDI.W  #$000F,D1
    BSR.W   DigitToASCII
    ADDQ.L  #8,A1

    MOVE.B  (A2)+,D2            ; Read milliseconds
    BSR.W   ByteProcessLoop
    RTS
```

### Digit Tile Renderer — DigitToASCII ($00E4BC)

Converts numeric digit to tile index:

```asm
DigitToASCII:  ; Render single digit
    ; Input: D1 = digit (0-9) or special char (10=:, 11=.)
    ; Uses global tile base offset stored in D0

    MOVE.W  D2,D6               ; Working register
    ADD.W   D0,D6               ; Add base tile offset
    ADD.W   D1,D6               ; Add digit offset
    BCHG    #0,D1               ; Toggle alternate tile flag
    RTS
```

**Tile Mapping**:
- Digits 0-9 → Tile indices 0-9 (offset by base)
- Character ':' → Tile index 10
- Character '.' → Tile index 11

---

## Input Handling for Menu Navigation

### Menu Input Handler ($00EA0E-$00EAB4)

Processes D-pad and button input for menu selection:

```asm
$00EA0E:  ; Handle menu input
    TST.W   $A020.W             ; Check if input enabled
    BNE.W   skip_input          ; Skip if disabled

    MOVE.B  $A019.W,D0          ; Current selection
    MOVE.W  $C86C.W,D1          ; Button state (delta bits)

    ; Check UP button
    BTST    #3,D1
    BEQ.S   check_down
    MOVE.B  #$00A9,$C8A4.W      ; Play cursor sound

    TST.B   $A01A.W             ; Check if P2 menu
    BEQ.W   p1_up_handler
    CMPI.B  #$0001,D0           ; P2: check lower bound
    BGE.S   do_increment
    BRA.W   update_selection

p1_up_handler:
    CMPI.B  #$0002,D0           ; P1: check lower bound
    BGE.S   do_increment

do_increment:
    ADDQ.B  #1,D0               ; Increment selection
    BRA.S   update_selection

check_down:
    ; Check DOWN button
    BTST    #2,D1
    BEQ.S   check_start
    MOVE.B  #$00A9,$C8A4.W      ; Play cursor sound

    TST.B   D0
    BLE.S   wrap_to_max
    SUBQ.B  #1,D0               ; Decrement selection
    BRA.S   update_selection

wrap_to_max:
    TST.B   $A01A.W
    BEQ.W   set_p1_max
    MOVE.B  #$0001,D0           ; P2 max value
    BRA.S   update_selection

set_p1_max:
    MOVE.B  #$0002,D0           ; P1 max value

update_selection:
    ; ... continue with START button check and state transition
```

**Input Variables**:
- `$C86C.W`: Button state (bit flags for U/D/L/R/A/B/C/Start)
  - Bit 0: Button pressed this frame
  - Bit 2: D-pad DOWN
  - Bit 3: D-pad UP
- `$C8A4`: Sound effect trigger ($A9 = menu cursor sound)
- `$A020`: Input enable flag (0=enabled, nonzero=disabled)

---

## Memory Map

### Game State Variables

| Address | Size | Purpose | Range/Values |
|---------|------|---------|--------------|
| `$C87E` | Word | Sequence state (shared with `game_logic_4.asm`) | 0, 4, 8, C, 10, ... |
| `$C86C` | Word | Button input state (delta bits) | Bit flags |
| `$C8A4` | Byte | Sound effect trigger | $A9 = cursor, varies |
| `$C80E` | Byte | Scene transition flag | Bit 6 checked |

### Selection State Variables

| Address | Size | Purpose | Range/Values |
|---------|------|---------|--------------|
| `$A014` | Long | Player flags / graphics buffer pointer | Bit 0=P1, Bit 1=P2 |
| `$A018` | Long | Player 1 data pointer | Address |
| `$A01C` | Long | Player 2 data pointer | Address |
| `$A019` | Byte | Player 1 selection (track/option) | 0-4 (varies by menu) |
| `$A01A` | Byte | Player 2 active flag | 0=inactive, 1=active |
| `$A01B` | Byte | Option category index | 0-2 |
| `$A01D` | Byte | Player 1 saved selection | Saved value |
| `$A01E` | Byte | Player 2 track selection | 0-2 |
| `$A020` | Byte | Input enable flag | 0=enabled, else disabled |
| `$A024` | Word | Input state for options menu | 0=idle, else processing |
| `$A026` | Word | Unknown state variable | TBD |
| `$A028` | Word | Unknown state variable | TBD |
| `$A02A` | Byte | Unknown flag | TBD |
| `$A02B` | Byte | Unknown flag | TBD |
| `$A02C` | Byte | Unknown flag | TBD |
| `$A02D` | Byte | Unknown flag | TBD |
| `$A02E` | Word | Unknown counter | TBD |
| `$A030` | Word | Unknown parameter | TBD |
| `$A032` | Word | Graphics parameter pointer | Address offset |

### Display Buffers

| Address | Size | Purpose |
|---------|------|---------|
| `$00FF6E00` | 256 bytes | Palette RAM buffer (128 colors × 2 bytes) |
| `$00FF60C8` | 136 bytes | HUD/UI tile buffer |
| `$00FF6100` | ~200 bytes | Graphics command buffer |
| `$00FF0002` | Long | Function pointer for scene handler |
| `$00FF0008` | Word | Scene-specific parameter |
| `$00FF2000-$00FF2010` | 16 bytes | Graphics coordinates/parameters |

### SH2 Address Space (Accessed via COMM)

| Address | Size | Purpose |
|---------|------|---------|
| `$06038000` | Varies | SH2 SDRAM: Track preview graphics |
| `$0603B600` | Varies | SH2 SDRAM: UI graphics data |
| `$0601AA00` | Varies | SH2 SDRAM: Results screen graphics |
| `$0601AD80` | Varies | SH2 SDRAM: Player 1 UI elements |
| `$0601B200` | Varies | SH2 SDRAM: Player 2 UI elements |
| `$04012010` | Varies | SH2 frame buffer: Graphics position 1 |
| `$0401B010` | Varies | SH2 frame buffer: Graphics position 2 |
| `$2400C060` | Varies | SH2 frame buffer: Results display area |
| `$2400E050` | Varies | SH2 frame buffer: Split-screen area 1 |
| `$2400E038` | Varies | SH2 frame buffer: Split-screen area 2 |

---

## Design Patterns & Architecture

### 1. Shared State Machine with game_logic_4.asm

This module **shares the same state variable** (`$C87E`) as `game_logic_4.asm` (Scene Sequencer). This indicates:

- **Hierarchical control**: `game_logic_4.asm` (master sequencer) transitions between major scenes
- **Per-scene state machines**: This module provides 4 sub-state-machines for different menu/UI scenes
- **Synchronized state transitions**: Both modules use the same state increments (multiples of 4)

**Architectural Implication**:
The master sequencer (`game_logic_4.asm`) likely calls specific functions in this module based on the current sequence state, then this module's state machines handle the detailed menu flow.

### 2. Split-Screen / 2-Player Support

Heavy use of player flags and dual rendering paths:

```
if ($A014 bit 0 set) → Render Player 1 UI elements
if ($A014 bit 1 set) → Render Player 2 UI elements
```

All graphics commands check player flags and adjust:
- Destination addresses in SH2 frame buffer
- Palette loading (separate palettes for P1/P2)
- Selection state variables (`$A019` vs `$A01E`)

### 3. Asynchronous SH2 Command Queue

The SH2 communication protocol uses a **polling-based handshake**:
1. 68K waits for SH2 ready (`TST.B $A15120`)
2. 68K writes parameters to COMM registers
3. 68K triggers SH2 (`MOVE.B #1,$A15120`)
4. 68K polls completion flag (`TST.B $A1512C`)

This allows the 68K to queue multiple commands, with the SH2 processing them asynchronously.

**Performance Implication**: The 68K CPU is blocked during SH2 operations (polling), which could contribute to frame rate overhead (as identified in `BOTTLENECK_ANALYSIS.md` Priority 8 polling).

### 4. Sound Effect Integration

Menu interactions trigger sound effects via `$C8A4`:
- `$A9` = Cursor movement sound
- Other values for selection confirmation, cancellation, etc.

This is a **write-only trigger** - the sound driver (likely running on Z80 or via V-INT handler) reads and clears this variable.

### 5. Data-Driven Rendering

Graphics rendering uses **lookup tables** extensively:
- Track preview graphics: Table at `$0088EACE` (4-byte entries per track)
- Option handlers: Table at `$0088EAC2` (4-byte function pointers)
- Border patterns: Indexed by D0 bits 0-1 (4 patterns)
- Digit tiles: Sequential tile indices with base offset

This makes adding new tracks/options relatively easy (just extend tables).

---

## External Dependencies

### Functions Called in Other Modules

| Address | Purpose | Likely Module |
|---------|---------|---------------|
| `$00882080` | Pre-state-machine dispatcher | Common utilities |
| `$008826C8` | Unknown graphics operation | Graphics utilities |
| `$008814BE` | Unknown initialization | Initialization module |
| `$008849AA` | Unknown handler (called 2x) | Event handler |
| `$0088204A` | Scene initialization | Scene management |
| `$00884998` | Unknown setup | Setup utilities |
| `$0088179E` | Input processing | Input handler |
| `$00B684` | Statistics loading | Results processing |

### Data Tables in Other Modules

| Address | Content | Size/Structure |
|---------|---------|----------------|
| `$0088EACE` | Track preview graphics pointers | 4 bytes per track (3 tracks) |
| `$0088EAC2` | Option handler function pointers | 4 bytes per option |
| `$0088EFB6` | Unknown table | Indexed by track selection |

---

## Performance Characteristics

### Cycle Estimates (Per Frame in Menu Screens)

| Operation | Cycles (approx) | Frequency | Notes |
|-----------|----------------|-----------|-------|
| State dispatcher | ~50 | 1x per frame | Jump table lookup |
| SH2 command submission | ~500-2000 | Varies | Polling overhead (wait for SH2) |
| Input handling | ~200-300 | 1x per frame | Button state checks |
| Palette copy (128 words) | ~800 | On scene change | DBRA loop |
| VRAM fill (28 blocks) | ~3500 | On scene init | Double DBRA loop |
| Digit rendering | ~50 per digit | As needed | Time display (8 digits) |

**Total menu overhead**: ~1,000-5,000 cycles per frame (varies by operations)

**Bottleneck**: SH2 command submission polling (identified in Priority 8 analysis) - can block for variable time depending on SH2 workload.

---

## Future Analysis Tasks

1. **Trace all 8 SH2 command codes** to understand exact SH2-side rendering operations
2. **Map all 32 external function calls** to their source modules
3. **Document all data tables** (track graphics, option handlers, etc.)
4. **Analyze State 8+ handlers** for each dispatcher (currently incomplete)
5. **Correlate with SH2 code** in `sh2-analysis/` to understand full graphics pipeline
6. **Profile SH2 polling overhead** in this module vs Priority 8 findings

---

## Cross-References

- **Master Sequencer**: `game_logic_4.asm` (shares $C87E state variable)
- **68K↔SH2 Communication**: `68K_SH2_COMMUNICATION.md`
- **Performance Bottlenecks**: `optimization/BOTTLENECK_ANALYSIS.md` (Priority 8 polling)
- **Input System**: `CONTROLLER_INPUT_ARCHITECTURE.md` ($C86C button state)
- **V-INT Handler**: `VINT_STATE_HANDLERS.md` (frame synchronization)
- **SH2 Rendering**: `sh2-analysis/SH2_3D_PIPELINE_ARCHITECTURE.md`

---

**Module Analysis Complete**: 2026-01-17
**Confidence Level**: High (architecture and protocol documented), Medium (external dependencies incomplete)
