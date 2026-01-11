# 68K Hotspot Functions - Virtua Racing Deluxe

**Project**: Virtua Racing Deluxe (USA).32x
**Date**: 2026-01-06

## Overview

These are the most frequently called 68K functions, identified through BSR/JSR analysis. Understanding these functions is critical to understanding the game's architecture.

---

## WaitForVBlank ($00884998) - 21 calls

```
; ═══════════════════════════════════════════════════════════════════════════
; WaitForVBlank: Wait for Vertical Blank Interrupt
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00884998 - $008849A8
; Size: 18 bytes
; Called by: 21 locations throughout the game
;
; Purpose: Synchronize game logic with display refresh. Sets a flag that
;          the V-INT handler will process and clear, then spins waiting
;          for that processing to complete.
;
; Input: None
; Output: None
; Modifies: SR (enables interrupts)
; ═══════════════════════════════════════════════════════════════════════════

; Raw hex: 31FC 0004 C87A 46FC 2300 4A78 C87A 66FA 4E75

00884998  31FC 0004 C87A     MOVE.W  #$0004,($C87A).W   ; Set VBlank flag to 4 (state 4 handler request)
0088499E  46FC 2300          MOVE.W  #$2300,SR          ; Enable interrupts (IPL=3)
008849A2  4A78 C87A          TST.W   ($C87A).W          ; Test VBlank flag
008849A6  66FA               BNE.S   $008849A2          ; Loop while non-zero (wait for V-INT to clear)
008849A8  4E75               RTS                        ; Return when flag cleared
```

**Analysis**: This is a classic "wait for VBlank" function. The value 4 written to $C87A corresponds to entry 4 in the V-INT handler's jump table (handler at $00881A6E).

### Call Pattern

```
Game Logic → WaitForVBlank() → Sets flag → Spins
                                            ↓
              V-INT fires → Reads flag → Calls state 4 handler → Clears flag
                                                                    ↓
                                           ← Returns ← Loop exits ←
```

---

## SetDisplayParams ($008849AA) - 21 calls

```
; ═══════════════════════════════════════════════════════════════════════════
; SetDisplayParams: Initialize Display Buffer Parameters
; ═══════════════════════════════════════════════════════════════════════════
; Address: $008849AA - $008849C6
; Size: 28 bytes
; Called by: 21 locations throughout the game
;
; Purpose: Set up display-related parameters. Likely initializes buffer
;          pointers or clears display state before rendering a new frame.
;
; Input: None
; Output: None
; Modifies: Memory at $C86C, $C86E, $C970, $C974
; ═══════════════════════════════════════════════════════════════════════════

; Raw hex: 31FC FF00 C86C 31FC FF00 C86E 21FC FFFF 0000 C970 21FC FFFF 0000 C974 4E75

008849AA  31FC FF00 C86C     MOVE.W  #$FF00,($C86C).W   ; Set display param 1
008849B0  31FC FF00 C86E     MOVE.W  #$FF00,($C86E).W   ; Set display param 2
008849B6  21FC FFFF0000 C970 MOVE.L  #$FFFF0000,($C970).W ; Set display param 3 (long)
008849C0  21FC FFFF0000 C974 MOVE.L  #$FFFF0000,($C974).W ; Set display param 4 (long)
008849C6  4E75               RTS
```

**Analysis**: This function initializes display-related memory locations. The $FF00 and $FFFF0000 values suggest clearing or marking these buffers as "invalid" or "uninitialized".

---

## UpdateInputState ($00882080) - 21 calls

```
; ═══════════════════════════════════════════════════════════════════════════
; UpdateInputState: Update Controller/Input State Machine
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00882080 - $008820C5
; Size: 70 bytes
; Called by: 21 locations throughout the game
;
; Purpose: Process input state changes. Reads from state buffers and
;          updates various game state locations based on input.
;
; Input: None
; Output: None
; Modifies: D0, memory at $8509, $850A, $C822-$C8A7
; ═══════════════════════════════════════════════════════════════════════════

; Manual decode from raw hex:
; 1038 C822 6710 11C0 8509 7000 11C0 C822 21C0 C8A4 6030...

00882080  1038 C822          MOVE.B  ($C822).W,D0       ; Read state byte from $C822
00882084  6710               BEQ.S   $00882096          ; Skip if zero
00882086  11C0 8509          MOVE.B  D0,($8509).W       ; Store to state location
0088208A  7000               MOVEQ   #0,D0              ; Clear D0
0088208C  11C0 C822          MOVE.B  D0,($C822).W       ; Clear source state
00882090  21C0 C8A4          MOVE.L  D0,($C8A4).W       ; Clear long at $C8A4
00882094  6030               BRA.S   $008820C6          ; Jump to end

; ... continues with more state checks and updates
```

**Analysis**: This function implements a state machine for input processing. It reads state flags from the $C8xx region (work RAM) and updates corresponding locations. The branching structure suggests handling multiple input states (buttons, directions, etc.).

---

## Top Hotspot Functions Summary

| Rank | Address | Calls | Function Name | Purpose |
|------|---------|-------|---------------|---------|
| 1 | $00884998 | 21 | WaitForVBlank | Sync with display |
| 2 | $00882080 | 21 | UpdateInputState | Process controller |
| 3 | $008849AA | 21 | SetDisplayParams | Init display buffers |
| 4 | $0088FB36 | 17 | **SendDREQCommand** | DMA request to SH2 |
| 5 | $0088179E | 16 | ControllerRead | Read controller port |
| 6 | $0088205E | 16 | **SetInputFlag** | Set input state flag |
| 7 | $008814BE | 12 | **TableLookup** | Indexed table access |
| 8 | $0088204A | 11 | **ClearInputState** | Clear input RAM |
| 9 | $008826C8 | 10 | **VDPFrameControl** | Frame buffer FM toggle |

---

## Key RAM Locations (68K Work RAM $FF0000-$FFFFFF)

Based on hotspot function analysis:

| Address | Size | Purpose |
|---------|------|---------|
| $C822 | Byte | Input state flag A |
| $C87A | Word | VBlank processing flag (0-15 = state index) |
| $C86C | Word | Display parameter 1 |
| $C86E | Word | Display parameter 2 |
| $C8A4 | Long | Input state buffer |
| $C8A5 | Byte | Input state flag B |
| $C8A7 | Byte | Input state flag C |
| $C964 | Long | Frame counter |
| $C970 | Long | Display parameter 3 |
| $C974 | Long | Display parameter 4 |
| $8509 | Byte | Controller state A |
| $850A | Byte | Controller state B |

**Note**: Addresses in the $8xxx and $Cxxx range are actually $FF8xxx and $FFCxxx in absolute terms (work RAM is at $FF0000).

---

## Controller Reading ($0088179E) - 16 calls

```
; ═══════════════════════════════════════════════════════════════════════════
; ControllerRead: Read Controller Port Data
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088179E - ~$008817xx
; Size: ~TBD
; Called by: 16 locations
;
; Purpose: Read data from Mega Drive controller ports. This is the low-level
;          function that interfaces with the hardware at $A10003 (MD_DATA1)
;          and $A10005 (MD_DATA2).
;
; References: MD_DATA1 at $A10003, MD_DATA2 at $A10005
; ═══════════════════════════════════════════════════════════════════════════
```

**Note**: The controller reading code at $179E is near the I/O initialization code at $170C. This area handles the 6-button controller protocol (multiple reads with TH toggling).

---

## SendDREQCommand ($0088FB36) - 17 calls

```
; ═══════════════════════════════════════════════════════════════════════════
; SendDREQCommand: Send DMA Request Command to SH2
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088FB36 - $0088FB7A
; Size: ~68 bytes
; Called by: 17 locations throughout the game
;
; Purpose: Send a DREQ (DMA Request) command to the SH2 processors via the
;          communication registers. This is the primary 68K→SH2 data transfer
;          mechanism for sending track data, display lists, etc.
;
; Input: Parameters set up before call (source, dest, length in registers)
; Output: None (waits for SH2 acknowledgment)
; Modifies: COMM0, COMM1, DREQ registers
; ═══════════════════════════════════════════════════════════════════════════

; Raw hex: 4A39 00A1 5120 66F8 33FC 001C 00A1 5110...

0088FB36  4A39 00A15120     TST.B   COMM0            ; Test COMM0 low byte
0088FB3C  66F8              BNE.S   $0088FB36        ; Wait while non-zero (SH2 busy)
0088FB3E  33FC 001C 00A15110 MOVE.W #$001C,MARS_DREQ_LEN ; Set DREQ length = 28
0088FB46  13FC 0004 00A15107 MOVE.B #$04,MARS_DREQ_CTRL+1 ; Set DREQ control flags
0088FB4E  4239 00A15123     CLR.B   COMM1+1          ; Clear COMM1 high byte
0088FB54  13FC 002D 00A15121 MOVE.B #$2D,COMM0+1     ; Write command $2D to COMM0
0088FB5C  13FC 0001 00A15120 MOVE.B #$01,COMM0       ; Signal SH2 (command ready)
0088FB64  0839 0001 00A15123 BTST   #1,COMM1+1       ; Test acknowledge bit in COMM1
0088FB6C  67F6              BEQ.S   $0088FB64        ; Loop until SH2 acknowledges
0088FB6E  08B9 0001 00A15123 BCLR   #1,COMM1+1       ; Clear acknowledge bit
```

**Analysis**: Critical 68K↔SH2 communication function. Uses the DREQ (DMA Request) system to transfer data blocks. The protocol:
1. Wait for COMM0 clear (SH2 ready)
2. Set up DREQ length and control
3. Write command code ($2D) to COMM0
4. Signal command ready
5. Poll COMM1 for SH2 acknowledgment
6. Clear ack bit and return

---

## SetInputFlag ($0088205E) - 16 calls

```
; ═══════════════════════════════════════════════════════════════════════════
; SetInputFlag: Set Input Processing Flag
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088205E - $00882065
; Size: 8 bytes
; Called by: 16 locations throughout the game
;
; Purpose: Set the input state flag to $F0, indicating input processing
;          is requested or in progress.
;
; Input: None
; Output: None
; Modifies: $C822
; ═══════════════════════════════════════════════════════════════════════════

0088205E  11FC 00F0 C822     MOVE.B  #$F0,($C822).W   ; Set input flag to $F0
00882064  4E75               RTS
```

**Analysis**: Simple flag-setting function. The value $F0 likely indicates "all input channels active" or serves as a bitmask for which inputs to process.

---

## ClearInputState ($0088204A) - 11 calls

```
; ═══════════════════════════════════════════════════════════════════════════
; ClearInputState: Clear All Input State Variables
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088204A - $0088205D
; Size: 20 bytes
; Called by: 11 locations throughout the game
;
; Purpose: Reset all input-related RAM locations to zero. Used when
;          transitioning between game states or initializing input system.
;
; Input: None
; Output: None
; Modifies: D0, $C822, $C823, $C8A2, $C8A4
; ═══════════════════════════════════════════════════════════════════════════

0088204A  7000               MOVEQ   #0,D0            ; Clear D0
0088204C  31C0 C8A4          MOVE.W  D0,($C8A4).W     ; Clear input buffer (word)
00882050  11C0 C822          MOVE.B  D0,($C822).W     ; Clear input flag A
00882054  11C0 C823          MOVE.B  D0,($C823).W     ; Clear input flag B
00882058  31C0 C8A2          MOVE.W  D0,($C8A2).W     ; Clear input state (word)
0088205C  4E75               RTS
```

**Analysis**: Bulk clear function for input state. Called during state transitions (menu→game, game→results, etc.) to ensure clean input handling.

---

## TableLookup ($008814BE) - 12 calls

```
; ═══════════════════════════════════════════════════════════════════════════
; TableLookup: Index into Parameter Table
; ═══════════════════════════════════════════════════════════════════════════
; Address: $008814BE - $008814DD
; Size: 32 bytes (+ embedded table data)
; Called by: 12 locations throughout the game
;
; Purpose: Look up values from an embedded table based on index in D0.
;          Multiplies index by 8 to get table offset.
;
; Input: D0.B = index (0-3)
; Output: Values loaded from table
; Modifies: D1, D2, A0
; ═══════════════════════════════════════════════════════════════════════════

008814BE  7403               MOVEQ   #3,D2            ; Set loop counter to 3
008814C0  7200               MOVEQ   #0,D1            ; Clear D1
008814C2  1200               MOVE.B  D0,D1            ; Copy index to D1
008814C4  6712               BEQ.S   $008814D8        ; If zero, skip to end
008814C6  E749               LSL.W   #3,D1            ; index * 8 (entry size)
008814C8  41FA 0016          LEA     $008814E0(PC),A0 ; Get table base address
; ... continues with table access
```

**Analysis**: Generic table lookup with 8-byte entries. The embedded table at $14E0 contains configuration data (possibly VDP commands based on the values visible in the hex dump: $4000, $4220, etc.).

---

## VDPFrameControl ($008826C8) - 10 calls

```
; ═══════════════════════════════════════════════════════════════════════════
; VDPFrameControl: Manage 32X Frame Buffer Access
; ═══════════════════════════════════════════════════════════════════════════
; Address: $008826C8 - $00882709
; Size: ~66 bytes
; Called by: 10 locations throughout the game
;
; Purpose: Control access to the 32X frame buffer by toggling the FM bit
;          in MARS_VDP_FBCTL. The FM bit determines whether 68K or SH2
;          has access to the frame buffer.
;
; Input: None
; Output: None
; Modifies: A4, various VDP registers
; ═══════════════════════════════════════════════════════════════════════════

008826C8  49F9 00A15100      LEA     MARS_SYS_BASE,A4  ; Load 32X register base
008826CE  08AC 0000 008B     BCLR    #0,$8B(A4)        ; Clear FM bit (68K access)
008826D4  616C               BSR.S   $00882742         ; Call helper function
008826D6  4EBA 00C8          JSR     $008827A0(PC)     ; Process frame
008826DA  08EC 0000 008B     BSET    #0,$8B(A4)        ; Set FM bit (SH2 access)
008826E0  615C               BSR.S   $0088273E         ; Call helper
; ... continues with more VDP operations
```

**Analysis**: Critical frame buffer management function. Controls the FM (Frame access Mode) bit:
- FM=0: 68K has frame buffer access
- FM=1: SH2 has frame buffer access

This must be coordinated with V-blank timing to avoid visual artifacts.

---

## Function Call Graph (Partial)

```
main_loop
    │
    ├── WaitForVBlank ($4998)
    │       │
    │       └── V-INT Handler ($1684)
    │               ├── State handlers (jump table)
    │               └── ControllerRead ($179E)
    │
    ├── UpdateInputState ($2080)
    │       └── Reads $C822, updates $8509/$850A
    │
    └── SetDisplayParams ($49AA)
            └── Initializes $C86C/$C86E/$C970/$C974
```

---

## References

- 68K_INTERRUPT_HANDLERS.md - V-INT handler details
- 68K_MEMORY_MAP.md - Hardware register addresses
- 68K_FUNCTION_INVENTORY.md - Complete function list
