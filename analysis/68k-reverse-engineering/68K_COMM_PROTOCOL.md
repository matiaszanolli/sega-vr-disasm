# 68K ↔ SH2 Communication Protocol - Virtua Racing Deluxe

**Project**: Virtua Racing Deluxe (USA).32x
**Last Updated**: 2026-01-26
**Revision History**:
- v1.1 (2026-01-26): Added v4.0 parallel processing commands, clarified command $16 scope
- v1.0 (2026-01-06): Initial documentation

## Overview

The Motorola 68000 and dual Hitachi SH2 CPUs communicate via 8 word-sized communication registers (COMM0-COMM7) mapped at $A15120-$A1512E in the 68K address space.

## Hardware Communication Registers

| Register | 68K Address | SH2 Address | Direction | Purpose |
|----------|-------------|-------------|-----------|---------|
| COMM0 | $A15120 | $20004020 | Bi-directional | Command/Status byte 0 |
| COMM1 | $A15122 | $20004022 | Bi-directional | Command/Status byte 1 |
| COMM2 | $A15124 | $20004024 | Bi-directional | Command/Status byte 2 |
| COMM3 | $A15126 | $20004026 | Bi-directional | Command/Status byte 3 |
| COMM4 | $A15128 | $20004028 | Bi-directional | Response byte 0 |
| COMM5 | $A1512A | $2000402A | Bi-directional | Response byte 1 |
| COMM6 | $A1512C | $2000402C | Bi-directional | Response byte 2 |
| COMM7 | $A1512E | $2000402E | Bi-directional | Response byte 3 |

**Note**: All COMM registers are 16-bit (word) accessible from both CPUs. Simultaneous writes from different CPUs result in undefined values.

---

## Communication Patterns

### Pattern 1: Command/Response

**Typical Usage**: 68K sends command, waits for SH2 response

```
68K                                  SH2
────────────────────────────────────────────────────────
1. Wait for COMM0 == 0          │   (Processing previous)
   (SH2 ready)                  │
                                │
2. Write command to COMM0       │
   COMM0 = $xx                  │
                                │   3. Detect COMM0 != 0
                                │      Read command
                                │
                                │   4. Process command
                                │
                                │   5. Write result to COMM4/5/6/7
                                │
                                │   6. Set acknowledge bit
                                │      COMM1.bit1 = 1
                                │
7. Poll COMM1.bit1              │
   Wait for acknowledge         │
                                │
8. Read result from COMM4-7     │
                                │
9. Clear acknowledge            │
   COMM1.bit1 = 0               │
                                │
10. Clear command               │
    COMM0 = 0                   │
```

### Pattern 2: Status Polling

**Typical Usage**: 68K checks SH2 busy state

```
68K                                  SH2
────────────────────────────────────────────────────────
1. Read COMM0                   │   Maintains status in COMM0
   Check if zero                │   - 0 = Ready
                                │   - Non-zero = Busy
2. If non-zero, wait            │
                                │
3. Proceed when COMM0 == 0      │
```

### Pattern 3: Signature Handshake

**Typical Usage**: Boot synchronization

```
68K                                  SH2 Master          SH2 Slave
───────────────────────────────────────────────────────────────────────────
1. Wait for 'VRES'          │   Write 'VRES' to   │
   in COMM6                 │   COMM6             │
   (timeout: $1000)         │                     │
                            │                     │
2. Wait for 'M_OK'          │   Write 'M_OK' to   │
   in COMM0                 │   COMM0             │
   (infinite wait)          │                     │
                            │                     │
3. Wait for 'S_OK'          │                     │   Write 'S_OK' to
   in COMM2                 │                     │   COMM2
   (infinite wait)          │                     │
                            │                     │
4. All CPUs ready           │   Continue          │   Continue
   Clear COMM0              │                     │
```

---

## DREQ (DMA Request) Protocol

The DREQ system uses both COMM registers and dedicated DREQ control registers for efficient data transfers.

### DREQ Registers

| Register | Address | Purpose |
|----------|---------|---------|
| MARS_DREQ_CTRL | $A15106 | Control flags |
| MARS_DREQ_SRC_H | $A15108 | Source address (high word) |
| MARS_DREQ_SRC_L | $A1510A | Source address (low word) |
| MARS_DREQ_DST_H | $A1510C | Destination address (high word) |
| MARS_DREQ_DST_L | $A1510E | Destination address (low word) |
| MARS_DREQ_LEN | $A15110 | Transfer length |

### DREQ Transfer Sequence

From [SendDREQCommand](68K_HOTSPOT_FUNCTIONS.md#senddreqcommand-0088fb36---17-calls) ($0088FB36):

```asm
; 1. Wait for SH2 ready
0088FB36  TST.B   COMM0                    ; Test COMM0 low byte
0088FB3C  BNE.S   $0088FB36                ; Loop while non-zero

; 2. Set up DREQ parameters
0088FB3E  MOVE.W  #$001C,MARS_DREQ_LEN     ; Length = 28 bytes
0088FB46  MOVE.B  #$04,MARS_DREQ_CTRL+1    ; Control flags = $04

; 3. Send command
0088FB4E  CLR.B   COMM1+1                  ; Clear COMM1 high byte
0088FB54  MOVE.B  #$2D,COMM0+1             ; Command = $2D
0088FB5C  MOVE.B  #$01,COMM0               ; Signal ready

; 4. Wait for acknowledge
0088FB64  BTST    #1,COMM1+1               ; Test ack bit
0088FB6C  BEQ.S   $0088FB64                ; Loop until set

; 5. Clear acknowledge
0088FB6E  BCLR    #1,COMM1+1               ; Clear ack bit
```

**DREQ Commands**:
- $2D: Data transfer request (from SendDREQCommand)
- Additional commands likely exist for different transfer types

---

## Known Command Codes

| Command | COMM Register | Direction | Purpose | Source |
|---------|---------------|-----------|---------|--------|
| $2D | COMM0 | 68K → SH2 | DREQ transfer | SendDREQCommand ($FB36) |
| $16 | COMM7 | **Master SH2 → Slave SH2** | **Vertex transform offload (v4.0)** | **func_021 trampoline ($0234C8)** |
| 'VRES' | COMM6 | SH2 → 68K | Video resolution init | Boot sequence ($8A8) |
| 'M_OK' | COMM0 | Master SH2 → 68K | Master SH2 ready | Boot sequence ($8CE) |
| 'S_OK' | COMM2 | Slave SH2 → 68K | Slave SH2 ready | Boot sequence ($8D8) |

**Note**: Command $16 is **Master SH2 → Slave SH2** only, not issued by 68K.

### New: Parallel Processing Commands (v4.0) ⚠️ EXPERIMENTAL

**Command $16: Vertex Transform Offload**
- **COMM Register**: COMM7 ($A1512E / $2000402E)
- **Direction**: **Master SH2 → Slave SH2** (SH2-internal communication)
- **Purpose**: Signal Slave SH2 to execute vertex transform in parallel
- **Parameter Block**: $2203E000 (16 bytes: R14, R7, R8, R5)
- **Counter**: COMM5 incremented by 101 per call (debug telemetry only)
- **Status**: ⚠️ Infrastructure ready, activation deferred due to timing concerns

---

## Frame Buffer Access Control

The FM (Frame access Mode) bit in MARS_VDP_FBCTL ($A1518A) controls which CPU can access the frame buffer.

From [VDPFrameControl](68K_HOTSPOT_FUNCTIONS.md#vdpframecontrol-008826c8---10-calls) ($008826C8):

```asm
; Grant 68K access to frame buffer
008826CE  BCLR    #0,$8B(A4)               ; Clear FM bit
                                           ; FM=0 → 68K access

; ... 68K processes frame buffer ...

; Return control to SH2
008826DA  BSET    #0,$8B(A4)               ; Set FM bit
                                           ; FM=1 → SH2 access
```

**Critical**: The FM bit must be synchronized with V-blank to avoid visual artifacts. Only one CPU should access the frame buffer at a time.

---

## Communication Flow Examples

### Example 1: Send Display List to SH2

```
68K Side                              SH2 Side
────────────────────────────────────────────────────────
// Prepare display list in 68K RAM
display_list = build_frame()

// Wait for SH2 ready
while (COMM0 != 0) { }

// Set up DREQ transfer
MARS_DREQ_SRC = address_of(display_list)
MARS_DREQ_DST = SH2_SDRAM_ADDRESS
MARS_DREQ_LEN = sizeof(display_list)
MARS_DREQ_CTRL = $0004

// Send command
COMM0 = $012D  // Command $2D, signal bit

// Wait for completion
while (!(COMM1 & 0x02)) { }          // Wait for ack
COMM1 &= ~0x02                       // Clear ack
                                     // Detect COMM0 != 0
                                     // Read command $2D

                                     // Execute DREQ transfer
                                     // (DMA from 68K RAM to SH2 RAM)

                                     // Set ack bit
                                     COMM1 |= 0x02

                                     // Process display list
                                     render_frame(display_list)
```

### Example 2: V-Blank Synchronization

```
68K Side                              SH2 Side
────────────────────────────────────────────────────────
// In V-INT handler
V_INT_Handler:
    state = read_state_flag()
    call_state_handler(state)
    increment_frame_counter()
                                     // SH2 polls frame counter
                                     old_frame = frame_counter
                                     while (frame_counter == old_frame) {
                                         // Spin wait for V-INT
                                     }

                                     // Frame changed, continue render
```

---

## Synchronization Primitives

### WaitForVBlank

From [WaitForVBlank](68K_HOTSPOT_FUNCTIONS.md#waitforvblank-00884998---21-calls) ($00884998):

```asm
00884998  MOVE.W  #$0004,($C87A).W   ; Set V-INT state = 4
0088499E  MOVE.W  #$2300,SR          ; Enable interrupts
008849A2  TST.W   ($C87A).W          ; Test flag
008849A6  BNE.S   $008849A2          ; Loop while non-zero
008849A8  RTS                        ; Return when cleared
```

The V-INT handler clears $C87A after processing, creating a synchronization point.

### Busy-Wait Pattern

```asm
; Wait for SH2 ready (COMM0 == 0)
wait_loop:
    TST.B   COMM0
    BNE.S   wait_loop
    ; Continue when ready
```

---

## Best Practices

### 1. Always Check Before Writing

```asm
; ✅ CORRECT
wait_ready:
    TST.B   COMM0
    BNE.S   wait_ready
    MOVE.B  #$XX,COMM0    ; Safe to write

; ❌ WRONG
    MOVE.B  #$XX,COMM0    ; May overwrite active command
```

### 2. Use Acknowledge Bits

```asm
; ✅ CORRECT
    MOVE.B  #$01,COMM0    ; Send command
wait_ack:
    BTST    #1,COMM1+1    ; Wait for ack
    BEQ.S   wait_ack
    BCLR    #1,COMM1+1    ; Clear ack

; ❌ WRONG
    MOVE.B  #$01,COMM0    ; Send command
    ; (no wait - may proceed before SH2 processes)
```

### 3. Coordinate Frame Buffer Access

```asm
; ✅ CORRECT
    BCLR    #0,MARS_VDP_FBCTL  ; Request FB access
    ; ... modify frame buffer ...
    BSET    #0,MARS_VDP_FBCTL  ; Return to SH2

; ❌ WRONG
    ; (no FM bit control - both CPUs access simultaneously)
    ; RESULT: Visual corruption
```

---

## Timing Constraints

| Operation | Typical Duration | Notes |
|-----------|------------------|-------|
| COMM register read | 1-2 cycles | Direct memory access |
| COMM register write | 1-2 cycles | Direct memory access |
| DREQ transfer (28 bytes) | ~100 cycles | Hardware DMA |
| SH2 command processing | Variable | Depends on command |
| V-INT period (NTSC) | 262 scanlines | ~16.7ms at 60Hz |
| V-INT period (PAL) | 312 scanlines | ~20ms at 50Hz |

---

## Error Conditions

### Timeout on Handshake

From boot sequence ($8A8):

```asm
008808A8  MOVE.W  #$1000,D7              ; Timeout = 4096 iterations
008808AC  CMPI.L  #'VRES',COMM6          ; Check signature
008808B6  DBEQ    D7,$008808AC           ; Loop with timeout
008808BA  BEQ     $008809B6              ; Branch if timeout
```

If 'VRES' doesn't appear within 4096 iterations, error handler is called.

### Undefined Value from Simultaneous Write

From 32X Hardware Manual:
> "When both CPUs write to the same COMM register simultaneously, the value becomes undefined."

**Solution**: Use proper handshaking to ensure only one CPU writes at a time.

---

## Pattern 4: Parallel Processing Offload (v4.0) ⚠️ NOT YET ACTIVATED

**🚨 CRITICAL STATUS**: Infrastructure ready, **NOT LIVE**. Shadow path validated only, live activation deferred pending timing validation.

**Typical Usage** (when activated): Master SH2 offloads work to Slave SH2 without blocking

```
Master SH2 (func_021)              Slave SH2 (slave_work_wrapper)
────────────────────────────────────────────────────────────────────
Game calls func_021
  ↓
Trampoline at $0234C8
  ↓
1. Capture parameters to $2203E000
   R14 → [$2203E000] (rendering context)
   R7  → [$2203E004] (loop count)
   R8  → [$2203E008] (data pointer)
   R5  → [$2203E00C] (output pointer)
  ↓
2. Signal Slave via COMM7
   COMM7 = $16                │
  ↓                           │
3. Return immediately (!)     │   Polling COMM7
  ↓                           │   Detects COMM7 = $16
⚠️ NOT YET LIVE ⚠️             │   ↓
(both CPUs parallel           │   Read parameters from $2203E000
 when activated)              │
                              │   ↓
                              │   Call func_021_optimized
                              │   (func_016 inlined)
                              │   ↓
                              │   Increment COMM5 += 101 (debug telemetry)
                              │   ↓
                              │   Clear COMM7 (ready for next)
```

**Key Difference from Pattern 1 (Command/Response)**:
- Pattern 1: Master WAITS for Slave response (blocking)
- Pattern 4: Master RETURNS immediately (non-blocking, parallel)

**Memory Locations**:
- **Parameter Block**: $2203E000-$2203E00F (16 bytes, SH2 SDRAM)
- **Command Signal**: COMM7 ($2000402E)
- **Work Counter**: COMM5 ($2000402A)

**Implementation**:
- **Master Hook**: $02046A → `master_dispatch_hook` at $300050
- **Slave Worker**: $300200 → `slave_work_wrapper` (command dispatch)
- **Trampoline**: $0234C8 → `func_021` parameter capture
- **Optimized Code**: $300100 → `func_021_optimized` (with func_016 inlined)

---

## Communication Register Usage Summary

### Common Patterns

| Register(s) | Typical Use |
|-------------|-------------|
| COMM0 | Command byte, busy flag (68K ↔ SH2) |
| COMM1 | Acknowledge flags, status |
| COMM2 | Secondary command/status |
| COMM3 | Command parameters |
| COMM4-7 | Response data, multi-byte results |
| **COMM5** | **Work counter (v4.0: debug telemetry, +101 per transform)** |
| COMM6 | Signature strings ('VRES') |
| **COMM7** | **Parallel processing (v4.0: Master SH2 → Slave SH2 cmd $16)** |

---

## References

- 68K_MEMORY_MAP.md - COMM register addresses
- 68K_HOTSPOT_FUNCTIONS.md - SendDREQCommand, VDPFrameControl
- 68K_ENTRY_INIT.md - Boot handshake sequence
- docs/32x-hardware-manual.md - COMM register specification
- SH2 3D Engine Documentation - SH2 side of protocol
