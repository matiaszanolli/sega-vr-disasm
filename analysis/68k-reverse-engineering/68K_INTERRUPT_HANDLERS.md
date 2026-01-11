# 68K Interrupt Handlers - Virtua Racing Deluxe

**Project**: Virtua Racing Deluxe (USA).32x
**Date**: 2026-01-06

## Overview

The 68000 interrupt handlers in Virtua Racing Deluxe are located in the ROM at the mapped address range $880xxx. The vector table at $000000-$0000FF points to these handlers.

## Vector Table Summary

| Vector | Address | Handler | Description |
|--------|---------|---------|-------------|
| 0 | $000000 | $01000000 | Initial SSP |
| 1 | $000004 | $000003F0 | Initial PC (Entry Point) |
| 2-11 | $000008-$02C | $00880832 | Bus/Address/Trap Errors |
| 24-27 | $000060-$06C | $00880832 | Spurious/Level 1-3 IRQ |
| 28 | $000070 | $0088170A | **Level 4 IRQ (H-INT)** |
| 29 | $000074 | $00880832 | Level 5 IRQ |
| 30 | $000078 | $00881684 | **Level 6 IRQ (V-INT)** |
| 31 | $00007C | $00880832 | Level 7 IRQ (NMI) |
| 32-47 | $000080-$0BC | $00880832 | TRAP #0-15 |

---

## Default Exception Handler ($00880832)

```
; ═══════════════════════════════════════════════════════════════════════════
; DefaultExceptionHandler: Infinite Loop (Crash Handler)
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00880832 - $00880837
; Size: 6 bytes
; Called by: Most exception vectors (Bus Error, Address Error, etc.)
;
; Purpose: Halt the system on unhandled exceptions. This is a simple
;          spin loop that keeps the CPU busy without doing anything.
;          Used for debugging - system will visibly freeze.
;
; Input: None
; Output: Never returns
; ═══════════════════════════════════════════════════════════════════════════

00880832  4E71              NOP                     ; Do nothing
00880834  4E71              NOP                     ; Do nothing
00880836  60F2              BRA.S   $00880832       ; Loop forever
```

**Analysis**: This is a minimal crash handler. When an unhandled exception occurs (bus error, illegal instruction, etc.), the system enters this infinite loop. The NOPs followed by a branch back create a visible "freeze" state that's detectable during debugging.

---

## H-INT Handler ($0088170A)

```
; ═══════════════════════════════════════════════════════════════════════════
; H_INT_Handler: Horizontal Blank Interrupt (Level 4)
; ═══════════════════════════════════════════════════════════════════════════
; Address: $0088170A - $0088170B
; Size: 2 bytes
; Called by: Hardware on each horizontal blank (if enabled)
;
; Purpose: Handle horizontal blank interrupt. In this game, H-INT is
;          not used for any processing - immediate return.
;
; Input: None
; Output: None
; ═══════════════════════════════════════════════════════════════════════════

0088170A  4E73              RTE                     ; Return from exception
```

**Analysis**: The H-INT handler is effectively disabled. It immediately returns without doing any processing. This is common in games that don't need per-scanline effects like:
- Raster effects (palette changes mid-frame)
- Split-screen without hardware scroll
- Parallax scrolling tricks

Virtua Racing Deluxe relies on the 32X's hardware capabilities for rendering, so H-INT processing isn't needed.

---

## V-INT Handler ($00881684)

```
; ═══════════════════════════════════════════════════════════════════════════
; V_INT_Handler: Vertical Blank Interrupt (Level 6) - Main Frame Handler
; ═══════════════════════════════════════════════════════════════════════════
; Address: $00881684 - $008816B0
; Size: 44 bytes (main handler)
; Called by: Hardware at start of each vertical blank (~60Hz NTSC, ~50Hz PAL)
;
; Purpose: Main timing interrupt. Called every frame to:
;          - Synchronize game logic with display
;          - Process controller input
;          - Coordinate with SH2 CPUs
;          - Update game state
;
; Input: None
; Output: None
; Modifies: All registers (saved/restored internally)
; ═══════════════════════════════════════════════════════════════════════════

; --- Entry Point ---
00881684  4A78 C87A         TST.W   ($C87A).W       ; Test VBlank flag in RAM
00881688  6726              BEQ.S   $008816B0       ; If zero, skip processing (RTE)

; --- Disable Interrupts & Save Context ---
0088168A  46FC 2700         MOVE.W  #$2700,SR       ; Disable all interrupts (IPL=7)
0088168E  48E7 FFFE         MOVEM.L D1-D7/A0-A6,-(SP) ; Save all registers except D0/A7

; --- Main Processing ---
00881692  3038 C87A         MOVE.W  ($C87A).W,D0    ; Get VBlank flag value (state index?)
00881696  31FC 0000 C87A    MOVE.W  #$0000,($C87A).W ; Clear VBlank flag
0088169C  227B 0014         MOVEA.L $0014(PC,D0.W),A1 ; Get handler address from jump table
008816A0  4E91              JSR     (A1)            ; Call the handler

; --- Increment Frame Counter ---
008816A2  52B8 C964         ADDQ.L  #1,($C964).W    ; Increment frame counter at $C964

; --- Restore Context & Return ---
008816A6  4CDF 7FFF         MOVEM.L (SP)+,D0-D7/A0-A6 ; Restore all registers
008816AA  46FC 2300         MOVE.W  #$2300,SR       ; Re-enable interrupts (IPL=3)
008816AE  4E73              RTE                     ; Return from exception

; --- Early Exit (no processing needed) ---
008816B0  4E73              RTE                     ; Return immediately
```

### V-INT Handler Jump Table ($008816B2)

Starting at $008816B2, there's a jump table of 32-bit handler addresses:

| Index | Address | Handler | Purpose |
|-------|---------|---------|---------|
| 0 | $008816B2 | $008819FE | State 0 handler |
| 1 | $008816B6 | $008819FE | State 1 handler |
| 2 | $008816BA | $008819FE | State 2 handler |
| 3 | $008816BE | $00018200 | State 3 handler (?) |
| 4 | $008816C2 | $00881A6E | State 4 handler |
| 5 | $008816C6 | $00881A72 | State 5 handler |
| 6 | $008816CA | $00881C66 | State 6 handler |
| 7 | $008816CE | $00881ACA | State 7 handler |
| 8 | $008816D2 | $008819FE | State 8 handler |
| 9 | $008816D6 | $00881E42 | State 9 handler |
| 10 | $008816DA | $00881B14 | State 10 handler |
| 11 | $008816DE | $00881A64 | State 11 handler |
| 12 | $008816E2 | $00881BA8 | State 12 handler |
| 13 | $008816E6 | $00881E94 | State 13 handler |
| 14 | $008816EA | $00881F4A | State 14 handler |
| 15 | $008816EE | $00882010 | State 15 handler |

**Note**: States 0, 1, 2, and 8 all point to the same handler ($008819FE), which is likely a "no-op" or default state handler.

### Key RAM Locations

| Address | Type | Purpose |
|---------|------|---------|
| $C87A | Word | VBlank processing flag / state index |
| $C964 | Long | Frame counter (incremented each V-INT) |

---

## Analysis Summary

### V-INT Handler Flow

```
V-INT Triggered
    │
    ▼
Test $C87A flag ──── Zero? ──── Yes ──► RTE (skip processing)
    │
    No
    ▼
Disable interrupts (IPL=7)
    │
    ▼
Save registers (D1-D7, A0-A6)
    │
    ▼
Read state index from $C87A
    │
    ▼
Clear $C87A flag
    │
    ▼
Call handler from jump table
    │
    ▼
Increment frame counter at $C964
    │
    ▼
Restore registers
    │
    ▼
Re-enable interrupts (IPL=3)
    │
    ▼
RTE
```

### State Machine

The V-INT handler implements a simple state machine:
- The value at $C87A determines which state handler is called
- Game logic sets $C87A to request specific V-INT processing
- Handler clears the flag after reading it
- This allows different processing for different game modes:
  - Title screen
  - Menu navigation
  - Race gameplay
  - Pause screen
  - Results screen
  - etc.

### Interrupt Priority

- **During V-INT processing**: IPL=7 (all interrupts disabled)
- **Normal operation**: IPL=3 (Level 4+ interrupts enabled)
- This means H-INT is blocked during V-INT processing

### Frame Counter

The frame counter at $C964 is incremented every V-INT, providing:
- Timing reference for game logic
- Animation timing
- Music/sound synchronization
- Pseudo-random seed source

---

## References

- 68K_MEMORY_MAP.md - Register addresses
- 68K_ANNOTATION_PLAN.md - Overall annotation strategy
- Super Mega Drive Manual - Hardware documentation
