# 32X Frame Buffer Format Documentation

**Date**: 2026-01-07
**Purpose**: Document the 32X VDP frame buffer architecture for Virtua Racing Deluxe

---

## Overview

The Sega 32X uses a dual-buffer frame buffer system with three display modes. VRD (Virtua Racing Deluxe) uses the **Packed Pixel Mode** for all gameplay rendering. This document explains the frame buffer architecture discovered during FPS counter implementation.

---

## Hardware Architecture

### Memory Map (68K Side)

| Address Range | Size | Description |
|---------------|------|-------------|
| `$840000-$85FFFF` | 128KB | Frame Buffer 0 (DRAM0) |
| `$860000-$87FFFF` | 128KB | Frame Buffer 1 (DRAM1) / Overwrite Image |
| `$A15180` | Word | MARS_VDP_MODE - VDP Mode Register |
| `$A1518A` | Word | MARS_VDP_FBCTL - Frame Buffer Control |
| `$A15200-$A153FF` | 512B | 32X Color Palette (256 × 16-bit) |

### Memory Map (SH2 Side)

| Address Range | Description |
|---------------|-------------|
| `$04020000` / `$24020000` | Frame Buffer (cache/cache-through) |
| `$04040000` / `$24040000` | Overwrite Image |
| `$20004100` | VDP Registers (cache-through only) |
| `$20004200` | Color Palette |

---

## VDP Modes

The 32X VDP supports three graphics modes, selected via MARS_VDP_MODE register:

| M1 | M0 | Mode | Bits/Pixel | Colors |
|----|-----|------|------------|--------|
| 0 | 0 | Blank Mode | N/A | None (transparent) |
| 0 | 1 | **Packed Pixel Mode** | 8 | 256 from 32,768 |
| 1 | 0 | Direct Color Mode | 16 | 32,768 |
| 1 | 1 | Run Length Mode | Variable | 256 from 32,768 |

**VRD uses Packed Pixel Mode** for its 3D racing graphics.

---

## Frame Buffer Layout (Packed Pixel Mode)

### Line Table Format

The frame buffer uses a **Line Table** architecture:

```
$840000 +---------------+
        | Line Table    |  256 words (512 bytes)
        | Entry 0       |  → Pointer to line 0 pixel data
        | Entry 1       |  → Pointer to line 1 pixel data
        | ...           |
        | Entry 255     |  → Pointer to line 255 pixel data
$840200 +---------------+
        | Pixel Data    |  Variable size
        | Line 0: 320B  |  (320 pixels × 1 byte each)
        | Line 1: 320B  |
        | ...           |
        +---------------+
```

### Line Table Entry Format

Each line table entry is a **16-bit word**:
- Bits 0-15: Offset within frame buffer to pixel data for that line
- The VDP reads 320 pixels starting from this offset

**Example**: If line table entry 0 contains `$0200`, pixel data for line 0 starts at `$840000 + $0200 = $840200`.

### Pixel Data Format (Packed Pixel)

- **1 byte per pixel** (8bpp)
- Each byte is an index into the 256-entry color palette at `$A15200`
- Line width: **320 bytes** (320 pixels)
- Typical screen: 224 lines × 320 pixels = 71,680 bytes

### Color Palette Format

Each palette entry is a **16-bit word** in BGR format:

```
Bit 15: Priority (through-bit)
Bits 14-10: Blue (5 bits, 0-31)
Bits 9-5: Green (5 bits, 0-31)
Bits 4-0: Red (5 bits, 0-31)
```

**Priority Bit**: When set, the pixel appears on the opposite side of the MD screen (for layering effects).

---

## Access Control (FM Bit)

The **FM (Frame access Mode) bit** controls which CPU can access the frame buffer:

| Register | Bit | Value | Access |
|----------|-----|-------|--------|
| `$A15100` | 7 | 0 | 68K has frame buffer access |
| `$A15100` | 7 | 1 | SH2 has frame buffer access |

**CRITICAL**: Only one CPU should access the frame buffer at a time. Writes while the wrong CPU has access are ignored; reads return undefined data.

### Access Coordination in VRD

VRD coordinates FM bit via V-INT handlers:
1. During V-blank, 68K checks COMM0 for SH2 status
2. If SH2 is ready, 68K clears FM bit (`BCLR #0,$A1518B`)
3. 68K performs frame buffer operations
4. 68K sets FM bit (`BSET #0,$A1518B`) to return access to SH2

---

## Frame Buffer Control Register (MARS_VDP_FBCTL)

Address: `$A1518A` (68K) / `$20004108` (SH2)

| Bit | Name | R/W | Description |
|-----|------|-----|-------------|
| 15 | VBLK | R | V-Blank active (1 = in V-blank) |
| 14 | HBLK | R | H-Blank active |
| 13 | PEN | R | Palette access permitted (1 = yes) |
| 1 | FEN | R/W | Fill enable (1 = fill in progress) |
| 0 | FS | R/W | Frame buffer select (0 = DRAM0, 1 = DRAM1) |

### Double Buffering

The 32X uses double buffering:
1. One buffer is displayed (read by VDP)
2. One buffer is drawn to (written by CPUs)
3. FS bit swaps which is which during V-blank

---

## VRD-Specific Details

### How VRD Uses the Frame Buffer

1. **SH2 renders 3D graphics** to the draw buffer
2. **68K handles V-INT** and coordinates FM bit swapping
3. **During V-blank**, buffers are swapped via FS bit
4. **Copyright text** and other overlays are rendered by SH2 to frame buffer

### Key Functions

| Function | Address | Description |
|----------|---------|-------------|
| func_27A0 | `$008827A0` | Direct frame buffer write (68K) |
| func_2742 | `$00882742` | VDP auto-fill operation |
| func_0694 | `$00880694` | Frame buffer clear (512 bytes) |
| VDPFrameControl | `$008826C8` | FM bit coordination |

### Timing Constraints

- V-blank duration: ~4.5ms (NTSC)
- Safe access window: When VBLK=1 or FM=0
- Always check FEN=0 after auto-fill before accessing

---

## Writing to the Frame Buffer (68K)

### Basic Write Procedure

```asm
; 1. Check FM bit
    BTST    #7,$A15100          ; Test FM bit
    BNE.S   skip_write          ; Skip if SH2 has access

; 2. Read line table to find pixel address
    LEA     $840000,A0          ; Frame buffer base
    MOVE.W  (line*2,A0),D0      ; Read line table entry
    LEA     (A0,D0.W),A1        ; Calculate pixel address

; 3. Write pixel data
    MOVE.B  #$FF,(x_offset,A1)  ; Write pixel (palette index $FF)

skip_write:
```

### Caveats

- **Byte write limitation**: Cannot write $00 using byte access (use word access)
- **Timing**: Writes during active display may cause visual artifacts
- **FIFO**: SH2 has 4-word write FIFO for faster burst writes

---

## Direct Color Mode (Alternative)

VRD doesn't use this, but for reference:

- 16 bits per pixel (RGB555 + priority)
- Line width: 640 bytes (320 pixels × 2 bytes)
- Maximum ~204 lines due to DRAM size constraints

---

## References

- 32X Hardware Manual (MAR-32-R4-072294)
- VRD 68K Analysis: [68K_LOW_CODE_UTILITIES.md](68K_LOW_CODE_UTILITIES.md)
- V-INT State Documentation: [68K_VINT_STATES.md](68K_VINT_STATES.md)

---

## Change Log

- 2026-01-07: Initial documentation based on FPS counter implementation analysis
