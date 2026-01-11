# 68K V-INT State Handlers - Virtua Racing Deluxe

**Project**: Virtua Racing Deluxe (USA).32x
**Date**: 2026-01-06

## Overview

The V-INT (Vertical Interrupt) handler implements a state machine with 16 different states (0-15). Each state corresponds to a different game mode or screen (title, menu, gameplay, pause, results, etc.).

The state machine is controlled via a jump table at ROM offset `$16B2` (code address `$008816B2`), accessed from the V-INT handler at [68K_INTERRUPT_HANDLERS.md](68K_INTERRUPT_HANDLERS.md#v_int_handler-00881684---44-bytes).

## State Machine Operation

From V-INT handler at `$00881684`:

```asm
00881692  3038 C87A         MOVE.W  ($C87A).W,D0    ; Get state index
00881696  31FC 0000 C87A    MOVE.W  #$0000,($C87A).W ; Clear VBlank flag
0088169C  227B 0014         MOVEA.L $0014(PC,D0.W),A1 ; Load handler from jump table
008816A0  4E91              JSR     (A1)            ; Call state-specific handler
008816A2  52B8 C964         ADDQ.L  #1,($C964).W    ; Increment frame counter
```

**Key RAM Location**: `$C87A` (VBlank flag / state index)
- When non-zero: Specifies which state handler to execute
- Cleared to zero after reading
- Frame counter at `$C964` increments every V-INT regardless of state

## Jump Table

ROM offset `$16B2` contains 16 long-word pointers (64 bytes total):

```
Offset   State  Address    Notes
------   -----  --------   -----
$16B2    0      $008819FE  Shared handler (states 0,1,2,8)
$16B6    1      $008819FE  Shared handler (states 0,1,2,8)
$16BA    2      $008819FE  Shared handler (states 0,1,2,8)
$16BE    3      $00018200  ⚠️ INVALID (odd address, likely unused)
$16C2    4      $00881A6E  Minimal handler (NOP-like)
$16C6    5      $00881A72  SH2 communication
$16CA    6      $00881C66  Frame buffer + VDP control
$16CE    7      $00881ACA  SH2 communication
$16D2    8      $008819FE  Shared handler (states 0,1,2,8)
$16D6    9      $00881E42  Palette operations
$16DA    10     $00881B14  SH2 communication
$16DE    11     $00881A64  Delegate to func at $20C6
$16E2    12     $00881BA8  SH2 communication
$16E6    13     $00881E94  Frame buffer operations
$16EA    14     $00881F4A  Frame buffer operations
$16EE    15     $00882010  COMM register check
```

---

## State Handler Details

### State 0, 1, 2, 8: Default/Shared Handler ($008819FE)

**Purpose**: Common handler for multiple inactive or transitional states

**Code Address**: `$008819FE`
**ROM Offset**: `$19FE`
**States Using**: 0, 1, 2, 8

**Analysis**:
- Appears to be a data block or complex state handler
- Multiple states share this handler, suggesting it's a default or fallback
- Likely handles basic screen/menu operations common to several game states

**First bytes**: `3015 2ABC 6C00 0003 3CB8 8000...`

---

### State 3: Invalid Handler ($00018200) ⚠️

**Purpose**: INVALID / UNUSED STATE

**Code Address**: `$00018200` (odd address!)
**ROM Offset**: N/A

**Analysis**:
- **CRITICAL**: This is an ODD address, which is invalid for 68000 code execution
- 68K requires all code addresses to be word-aligned (even)
- Accessing this state would cause an Address Error exception
- **Conclusion**: State 3 is either:
  - Unused and uninitialized in the jump table
  - A deliberate error state to catch bugs
  - Never intended to be accessed during normal gameplay

**Recommendation**: Game code should never set `$C87A` to value that would select state 3.

---

### State 4: Minimal Handler ($00881A6E)

**Purpose**: NOP-like state or quick passthrough

**Code Address**: `$00881A6E`
**ROM Offset**: `$1A6E`
**Size**: 6 bytes

**Disassembly**:
```asm
00881A6E  3015              MOVE.W  (A5),D0         ; Read value from (A5)
00881A70  4E75              RTS                     ; Return immediately
```

**Analysis**:
- Extremely simple handler - just reads a word from `(A5)` into `D0` and returns
- Functions as essentially a NOP state
- Might be used during initialization or state transitions
- The value read from `(A5)` doesn't appear to be used (no store operations)

**Register Context**: A5 likely points to hardware register base (see [68K_HOTSPOT_FUNCTIONS.md](68K_HOTSPOT_FUNCTIONS.md))

---

### State 5: SH2 Communication ($00881A72)

**Purpose**: SH2 synchronization and data transfer

**Code Address**: `$00881A72`
**ROM Offset**: `$1A72`
**Size**: ~86 bytes (ends at RTS before next handler)

**Key Operations**:
1. Wait for SH2 ready (COMM0 == 0)
2. Write command $01 to COMM0
3. Wait for SH2 acknowledge via COMM1.bit1
4. Clear acknowledge bit
5. Return control

**Pattern Match**: Similar structure to states 7, 10, 12 (SH2 communication family)

**Disassembly Excerpt**:
```asm
00881A82  33FC 0100 00A1 1100    MOVE.W  #$0100,COMM0    ; Send command
00881A8A  0839 0000 00A1 1100    BTST    #0,COMM0        ; Check busy
00881A92  66F6                   BNE.S   $00881A8A       ; Wait loop
```

**Related Documentation**: [68K_COMM_PROTOCOL.md](68K_COMM_PROTOCOL.md)

---

### State 6: Frame Buffer + VDP Control ($00881C66)

**Purpose**: Frame buffer access and VDP register manipulation

**Code Address**: `$00881C66`
**ROM Offset**: `$1C66`
**Size**: ~164 bytes

**Key Operations**:
1. Check COMM0 status (SH2 busy check)
2. Test MARS_VDP_FBCTL bit 7 (frame buffer status)
3. Call subroutine at `$2878` (JSR $00882878)
4. Toggle MARS_VDP FM bit (frame buffer access control)
5. Return

**Disassembly Excerpt**:
```asm
00881CCA  4A39 00A1 5120         TST.B   COMM0           ; Check SH2 ready
00881CD0  6638                   BNE.S   $00881D0A       ; Skip if busy
00881CD2  08B9 0007 00A1 5100    BCLR    #7,MARS_SYS_INTCTL  ; Clear bit 7
00881CDA  0839 0007 00A1 518A    BTST    #7,MARS_VDP_FBCTL   ; Test FB bit
00881CE2  67F6                   BEQ.S   $00881CDA       ; Wait loop
00881CE4  4EBA 0B92              JSR     $00882878(PC)   ; Call function
00881CE8  0878 0000 C80C         BCHG    #0,($C80C).W    ; Toggle flag
00881CF0  08F9 0000 00A1 518B    BSET    #0,MARS_VDP_FBCTL+1 ; Set FM bit
00881D02  08F9 0007 00A1 5100    BSET    #7,MARS_SYS_INTCTL  ; Set bit 7
00881D0A  4E75                   RTS
```

**Critical**: Frame buffer FM bit must be coordinated with V-blank to prevent visual corruption (see [68K_COMM_PROTOCOL.md#frame-buffer-access-control](68K_COMM_PROTOCOL.md#frame-buffer-access-control))

---

### State 7: SH2 Communication ($00881ACA)

**Purpose**: SH2 synchronization and data transfer

**Code Address**: `$00881ACA`
**ROM Offset**: `$1ACA`
**Size**: ~62 bytes

**Key Operations**:
Similar to State 5 - COMM0 wait loop, command send, acknowledge wait pattern.

**Disassembly Excerpt**:
```asm
00881ACA  3015                   MOVE.W  (A5),D0
00881ACA  33FC 0100 00A1 1100    MOVE.W  #$0100,COMM0
00881AD4  0839 0000 00A1 1100    BTST    #0,COMM0
00881ADC  66F6                   BNE.S   $00881AD4
```

**Pattern**: Part of SH2 communication state family (5, 7, 10, 12)

---

### State 9: Palette Operations ($00881E42)

**Purpose**: Clear or initialize palette RAM

**Code Address**: `$00881E42`
**ROM Offset**: `$1E42`
**Size**: ~82 bytes

**Key Operations**:
1. Test and set MARS_VDP FM bit
2. Initialize palette memory at `$A15200` (CRAM)
3. Clear 128 words (256 bytes) of palette data

**Disassembly Excerpt**:
```asm
00881E60  31FC 0000 C87E         MOVE.W  #$0000,($C87E).W ; Clear flag
00881E66  0878 0000 C80C         BCHG    #0,($C80C).W     ; Toggle bit
00881E6E  08F9 0000 00A1 518B    BSET    #0,MARS_VDP_FBCTL+1 ; Set FM
00881E80  41F8 A100              LEA     $A100,A0         ; Base address
00881E84  43F9 00A1 5200         LEA     $A15200,A1       ; Palette RAM
00881E8A  707F                   MOVEQ   #$7F,D0          ; Counter = 128
00881E8C  22D8                   MOVE.L  (A0)+,(A1)+      ; Copy longword
00881E8E  51C8 FFFC              DBRA    D0,$00881E8C     ; Loop 128 times
00881E92  4E75                   RTS
```

**Note**: CRAM (Color RAM) at `$A15200-$A1525F` holds the 32X color palette (256 colors, RGB555 format).

---

### State 10: SH2 Communication ($00881B14)

**Purpose**: SH2 synchronization and data transfer

**Code Address**: `$00881B14`
**ROM Offset**: `$1B14`
**Size**: ~148 bytes

**Key Operations**:
Similar to States 5, 7 - COMM0 polling, command write, acknowledge wait.

**Pattern**: Part of SH2 communication state family

---

### State 11: Delegated Handler ($00881A64)

**Purpose**: Delegate to function at `$20C6`

**Code Address**: `$00881A64`
**ROM Offset**: `$1A64`
**Size**: 10 bytes

**Disassembly**:
```asm
00881A64  31FC 002C C87A         MOVE.W  #$002C,($C87A).W ; Set VBlank flag = $002C
00881A6A  4EFA 065A              JMP     $00882 0C6(PC)    ; Jump to $20C6
```

**Analysis**:
- Sets VBlank flag to `$002C` (decimal 44)
- Immediately jumps to function at `$008820C6`
- This is unusual - normally handlers return via RTS
- Function at `$20C6` likely performs the actual work for this state
- The `$002C` value might indicate next state or operation mode

**Next State**: After `$20C6` executes, state likely changes to $002C or system continues processing.

---

### State 12: SH2 Communication ($00881BA8)

**Purpose**: SH2 synchronization and data transfer

**Code Address**: `$00881BA8`
**ROM Offset**: `$1BA8`
**Size**: ~236 bytes

**Key Operations**:
Extended SH2 communication with additional processing steps compared to states 5/7/10.

**Pattern**: Part of SH2 communication state family

---

### State 13: Frame Buffer Operations ($00881E94)

**Purpose**: Frame buffer management and rendering

**Code Address**: `$00881E94`
**ROM Offset**: `$1E94`
**Size**: ~182 bytes

**Key Operations**:
1. COMM0/COMM1 register checks (SH2 sync)
2. Clear frame buffer control bit
3. Wait for VDP ready (MARS_VDP_FBCTL bit 7)
4. Call rendering functions (`$8848D6`, `$8848DA`)
5. Toggle FM bit for frame buffer access

**Disassembly Excerpt**:
```asm
00881E94  3015                   MOVE.W  (A5),D0
00881E9A  33FC 0100 00A1 1100    MOVE.W  #$0100,COMM0
00881EA2  0839 0000 00A1 1100    BTST    #0,COMM0
00881EA6  66F6                   BNE.S   $00881E9E       ; Wait for COMM0 clear
00881EDC  0839 0000 00A1 5123    BTST    #0,COMM1+1      ; Check COMM1
00881EE4  6762                   BEQ.S   $00881F48       ; Branch if clear
00881F02  08B9 0007 00A1 5100    BCLR    #7,MARS_SYS_INTCTL
00881F0A  0839 0007 00A1 518A    BTST    #7,MARS_VDP_FBCTL
00881F12  67F6                   BEQ.S   $00881F0A       ; Wait for VDP
00881F18  45F9 00A1 5200         LEA     $A15200,A2      ; Palette base
00881F1E  4EBA 29B6              JSR     $008848D6(PC)   ; Render call 1
00881F22  4EBA 29B6              JSR     $008848DA(PC)   ; Render call 2
00881F40  08F9 0007 00A1 5100    BSET    #7,MARS_SYS_INTCTL
00881F48  4E75                   RTS
```

**Note**: Calls rendering functions at `$8848D6` and `$8848DA` (likely sprite or polygon rendering).

---

### State 14: Frame Buffer Operations ($00881F4A)

**Purpose**: Frame buffer management and rendering

**Code Address**: `$00881F4A`
**ROM Offset**: `$1F4A`
**Size**: ~196 bytes

**Key Operations**:
Similar to State 13 - COMM register sync, VDP wait loops, rendering JSR calls, FM bit control.

**Disassembly Excerpt**:
```asm
00881FAE  0839 0000 00A1 5123    BTST    #0,COMM1+1
00881FB6  6756                   BEQ.S   $0088200E
00881FC0  31FC 0000 C87E         MOVE.W  #$0000,($C87E).W
00881FC6  08B9 0007 00A1 5100    BCLR    #7,MARS_SYS_INTCTL
00881FCE  0839 0007 00A1 518A    BTST    #7,MARS_VDP_FBCTL
00881FD6  67F6                   BEQ.S   $00881FCE
00881FD8  43F9 00FF 6E00         LEA     $FF6E00,A1      ; Work RAM pointer
00881FDE  45F9 00A1 5200         LEA     $A15200,A2      ; Palette RAM
00881FE4  4EBA 28F0              JSR     $008848D6(PC)   ; Render function
00881FE8  4EBA 28F0              JSR     $008848DA(PC)   ; Render function
```

**Difference from State 13**: Uses work RAM at `$FF6E00` for intermediate data.

---

### State 15: COMM Register Check ($00882010)

**Purpose**: Check and clear COMM1 status

**Code Address**: `$00882010`
**ROM Offset**: `$2010`
**Size**: ~40 bytes

**Disassembly**:
```asm
00882010  3015                   MOVE.W  (A5),D0
00882014  0839 0000 00A1 5123    BTST    #0,COMM1+1      ; Test COMM1.bit0
0088201A  671C                   BEQ.S   $00882038       ; Skip if clear
0088201C  08B9 0000 00A1 5123    BCLR    #0,COMM1+1      ; Clear bit
00882024  0C38 0018 C8C5         CMPI.B  #$18,($C8C5).W  ; Compare flag
0088202A  6606                   BNE.S   $00882032       ; Branch if not equal
0088202C  31FC 0000 C87E         MOVE.W  #$0000,($C87E).W ; Clear flag
00882032  11FC 0000 C8C4         MOVE.B  #$00,($C8C4).W   ; Clear flag
00882038  4E75                   RTS
```

**Analysis**:
- Minimal handler focused on COMM1 register management
- Checks flag at `$C8C5` and conditionally clears `$C87E`
- Likely used during state transitions or cleanup operations

---

## State Handler Families

Based on code patterns, the handlers fall into several families:

### Family 1: SH2 Communication (States 5, 7, 10, 12)

**Common Pattern**:
1. Wait for COMM0 == 0 (SH2 ready)
2. Write command to COMM0
3. Poll COMM1.bit1 for acknowledgement
4. Clear acknowledge bit
5. Return

**Purpose**: Send commands and data to SH2 CPUs for 3D rendering, sound, etc.

### Family 2: Frame Buffer Operations (States 6, 13, 14)

**Common Pattern**:
1. Check SH2 status via COMM registers
2. Wait for VDP ready (MARS_VDP_FBCTL bit 7)
3. Clear/set FM bit for frame buffer access control
4. Call rendering subroutines
5. Restore FM bit
6. Return

**Purpose**: Coordinate frame buffer access between 68K and SH2, render graphics.

### Family 3: Utility States (States 4, 9, 11, 15)

**Characteristics**:
- State 4: Minimal NOP-like handler
- State 9: Palette initialization
- State 11: Delegation to external function
- State 15: COMM register cleanup

**Purpose**: Initialization, cleanup, state transitions.

### Family 4: Shared/Default (States 0, 1, 2, 8)

**Characteristics**:
- All four states use same handler at `$19FE`
- Complex or data-heavy operations
- Likely handles common menu/UI operations

**Purpose**: Default handler for multiple game states.

---

## RAM Locations Used by State Handlers

| Address | Type | Purpose | States Using |
|---------|------|---------|--------------|
| $C87A | Word | **VBlank flag / State index** | ALL (read by V-INT) |
| $C87E | Word | Control flag | 9, 13, 14, 15 |
| $C80C | Byte | Toggle flag | 6, 9 |
| $C8C4 | Byte | Status flag | 15 |
| $C8C5 | Byte | Comparison value | 15 |
| $C964 | Long | **Frame counter** | V-INT (incremented every frame) |
| $C822 | Byte | Input state flag A | (from hotspot analysis) |
| $C8A4 | Long | Input state buffer | (from hotspot analysis) |

---

## Hardware Registers Accessed

| Register | Address | States Using | Purpose |
|----------|---------|--------------|---------|
| COMM0 | $A15120 | 5,6,7,10,12,13,14 | Command/status byte (SH2 busy flag) |
| COMM1 | $A15122 | 5,7,10,12,13,14,15 | Acknowledge flags |
| COMM2 | $A15124 | - | (not directly used in state handlers) |
| COMM4-7 | $A15128-$A1512E | - | (response data, see [68K_COMM_PROTOCOL.md](68K_COMM_PROTOCOL.md)) |
| MARS_SYS_INTCTL | $A15100 | 6, 13, 14 | Adapter control (bit 7 operations) |
| MARS_VDP_FBCTL | $A1518A | 6, 9, 13, 14 | Frame buffer control (FM bit, bit 7) |
| Palette RAM | $A15200-$A1525F | 9, 13, 14 | Color palette (CRAM) |

---

## State Transition Flow

The game changes states by writing to `$C87A` before the next V-INT occurs:

```
Current Frame:
1. Game logic executes in main loop
2. Determines next state needed (e.g., transition from menu to gameplay)
3. Writes state index to ($C87A).W
4. Calls WaitForVBlank or waits for V-INT

Next V-INT:
1. V-INT handler reads ($C87A).W into D0
2. Clears ($C87A).W to zero
3. Uses D0 to index jump table at $16B2
4. Calls appropriate state handler
5. Increments frame counter
6. Returns from interrupt

Next Frame:
1. Main loop continues with new state active
```

**Example**: Transition from title screen (state 0) to main menu (state 5):

```asm
; In main game loop
    MOVE.W  #5,($C87A).W        ; Request state 5 (menu)
    JSR     WaitForVBlank       ; Wait for V-INT
    ; After V-INT, state 5 handler has executed
    ; Continue with menu logic
```

---

## State Usage Hypothesis

Based on handler complexity and patterns:

| State | Likely Game Mode | Reasoning |
|-------|------------------|-----------|
| 0,1,2,8 | Title/Attract/Transition | Shared default handler |
| 3 | **UNUSED/ERROR** | Invalid odd address |
| 4 | Initialization/NOP | Minimal operation |
| 5 | Menu/Setup | SH2 communication for menu graphics |
| 6 | Gameplay (Racing) | Frame buffer ops, likely main game loop |
| 7 | Pause/UI Overlay | SH2 communication |
| 9 | Screen Clear/Init | Palette initialization |
| 10 | Loading/Transition | SH2 communication for data transfer |
| 11 | Special Mode | Delegated handler, unique behavior |
| 12 | Results/Stats | SH2 communication for stats display |
| 13 | Gameplay (Racing) | Frame buffer + rendering calls |
| 14 | Replay/Demo | Frame buffer + rendering with work RAM |
| 15 | Cleanup/Exit | COMM register cleanup |

**Note**: This is speculative based on code analysis. Actual state assignments would require gameplay testing and correlation.

---

## Performance Characteristics

### State Handler Execution Time

| State Family | Est. Cycles | Percentage of V-INT Budget |
|--------------|-------------|---------------------------|
| Minimal (4, 15) | ~50-100 | <1% |
| SH2 Comm (5,7,10,12) | 200-1000+ | 1-10% (depends on SH2 response time) |
| Frame Buffer (6,13,14) | 500-5000+ | 5-50% (includes rendering JSRs) |
| Palette (9) | ~600-800 | 5-8% |

**V-INT Budget**: At 60Hz (NTSC), V-INT occurs every ~16.7ms. The 68K running at 7.67MHz has ~128,000 cycles per frame.

**Critical**: States 6, 13, 14 can consume significant V-INT time due to rendering calls and SH2 synchronization. If these exceed V-INT budget, frame pacing issues occur.

---

## Debugging State-Related Issues

### Common Problems

**Problem**: Game stuck in one state
- **Symptom**: Screen frozen, no state changes
- **Cause**: `($C87A).W` not being updated by main loop
- **Fix**: Check main loop logic, ensure WaitForVBlank synchronization

**Problem**: Visual corruption during state transition
- **Symptom**: Glitched graphics, partial frames
- **Cause**: Frame buffer FM bit not properly coordinated
- **Fix**: Ensure states 6/13/14 properly set/clear FM bit during V-blank

**Problem**: Game crashes on specific state
- **Symptom**: Address error exception, system hang
- **Cause**: Invalid state index (especially state 3!)
- **Fix**: Validate state index before writing to `$C87A`

**Problem**: SH2 not responding (states 5/7/10/12 hang)
- **Symptom**: Infinite loop in COMM0 wait
- **Cause**: SH2 crashed, busy, or not running
- **Fix**: Check SH2 code, verify boot handshake completed

### Debug RAM Watch Points

Monitor these addresses to debug state issues:

```
$C87A (word)  - Current state index / VBlank flag
$C964 (long)  - Frame counter (should increment every 16.7ms)
$A15120 (word) - COMM0 (SH2 busy flag, should clear within ~1-2 frames)
$A1518A (byte) - MARS_VDP_FBCTL (FM bit should toggle during render states)
```

---

## Implementation Notes for Game Modifications

### Adding a New State

To add a custom state handler:

1. **Choose unused state index** (avoid 3, which is invalid)
2. **Write handler function** following existing patterns:
   ```asm
   MyStateHandler:
       ; Your code here
       ; Remember to preserve registers if needed
       ; Coordinate with SH2 via COMM registers
       ; Return via RTS (not JMP unless delegating)
       RTS
   ```
3. **Update jump table** at ROM offset `$16B2`:
   ```asm
   ; Example: Replace state 3 (invalid) with your handler
   ORG $008816BE
   DC.L MyStateHandler  ; Replace $00018200 with your address
   ```
4. **Trigger state** from main loop:
   ```asm
   MOVE.W  #3,($C87A).W    ; Request your custom state
   JSR     WaitForVBlank
   ; After V-INT, your handler has executed
   ```

### State Handler Best Practices

1. **Keep handlers short**: V-INT time is limited (~16.7ms @ 60Hz)
2. **Use SH2 for heavy work**: Offload 3D rendering, sound to SH2 CPUs
3. **Preserve registers**: Save/restore D0-D7/A0-A6 if modified (V-INT already does this, but be cautious)
4. **Coordinate FM bit**: Always check/set MARS_VDP_FBCTL when accessing frame buffer
5. **Check COMM0 before writing**: Prevent overwriting active SH2 commands
6. **Clear flags on exit**: Reset any RAM flags used during handler execution
7. **Return via RTS**: Let V-INT handler manage stack and register restoration

---

## References

- [68K_INTERRUPT_HANDLERS.md](68K_INTERRUPT_HANDLERS.md) - V-INT handler implementation
- [68K_COMM_PROTOCOL.md](68K_COMM_PROTOCOL.md) - 68K↔SH2 communication patterns
- [68K_MEMORY_MAP.md](68K_MEMORY_MAP.md) - Hardware register addresses
- [68K_HOTSPOT_FUNCTIONS.md](68K_HOTSPOT_FUNCTIONS.md) - WaitForVBlank and related functions
- [68K_ANNOTATION_TASKS.md](68K_ANNOTATION_TASKS.md) - Overall annotation progress

---

## Change Log

- 2026-01-06: Initial documentation of all 16 V-INT state handlers
- Documented state families (SH2 comm, frame buffer, utility)
- Identified state 3 as invalid/unused (odd address error)
- Mapped RAM locations and hardware registers used by states
- Created state transition flow documentation
