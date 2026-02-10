# Genesis Technical Overview

> Converted from `GenesisTechnicalOverview.pdf` (120 pages).
> CONFIDENTIAL -- PROPERTY OF SEGA


---

## System Overview

### Genesis Hardware

**68000 @ 8 MHz**
- Main CPU
- 1 MByte (8 Mbit) ROM Area
- 64 KByte RAM Area

**VDP** (Video Display Processor)
- Dedicated video display processor
  - Controls playfield & sprites
  - Capable of DMA
  - Horizontal & Vertical interrupts
- 64 KBytes of dedicated VRAM (Video RAM)
- 64 x 9-bits of CRAM (Color RAM)

**Z80 @ 4 MHz**
- Controls PSG (Programmable Sound Generator) & FM Chips
- 8 KBytes of dedicated Sound RAM

### Video

> NOTE: Playfield and Sprites are character-based

**Display Area (visual)**
- 40 chars wide x 28 chars high
  - Each char is 8 x 8 pixels
  - Pixel resolution = 320 x 224

**3 Planes:**
- 2 scrolling playfields
- 1 sprite plane
- Definable priorities between planes

**Playfields:**
- 6 different sizes
- 1 playfield can have a "fixed" window
- Playfield map:
  - Each char position takes 2 Bytes, that includes:
    - Char name (10 bits); points to char definition
    - Horizontal flip
    - Vertical flip
    - Color palette (2 bits); index into CRAM
    - Priority

**Scrolling:**
- 1 pixel scrolling resolution
- Horizontal:
  - Whole playfield as unit
  - Each character line
  - Each scan line
- Vertical:
  - Whole playfield as unit
  - 2 char wide columns

**Sprites:**
- 1 x 1 char up to 4 x 4 chars
- Up to 80 sprites can be defined
- Up to 20 sprites displayed on a scan line
- Sprite priorities

**Character Definitions:**
- 4 bits/pixel; points to color register
- 4 bytes/scanline of char
- 32 bytes for complete char definition
- Playfield & sprite chars are the same!

### Color

- Uses CRAM (part of the VDP)
  - 64 9-bit wide color registers
    - 64 colors out of 512 possible colors
      - 3 bits of Red
      - 3 bits of Green
      - 3 bits of Blue
    - 4 palettes of 16 colors
      - 0th color (of each palette) is always transparent

### Other

- **DMA**
  - Removes the 68000 from the BUS
  - Can move 205 Bytes/scanline during VBLANK
    - There are 36 scanlines during VBLANK
    - DMA can move 7380 Bytes during VBLANK
- Horizontal & Vertical interrupts

### Sound

- Z80 controls:
  - PSG (TI 76489 chip)
  - FM chip (Yamaha YM 2612)
    - 6-channel stereo
  - Z80 can access ROM data
  - 8 KBytes RAM

### Hardware

- 2 controllers
  - Joypad
  - 3 buttons
  - Start button
- 1 external port
- 2 video-outs (RF & RGB)
- Audio jack (stereo)
- Volume control (for audio jack)

---

## Table of Contents (Index)

### 1. Memory Map

- **S 1 MEGA DRIVE 16BIT MODE**
  - 68000 Memory Map ..................... 1
  - Z80 Memory Map ...................... 2
  - 68000 Access to Z80 Memory .......... 2
  - I/O Area ............................. 3
  - Control Area ......................... 3
  - VDP Area ............................. 4

### 2. VDP 315-5313 (Video Display Processor)

- Terminology .......................... 6
- **S 1** Display Specification ............. 7
- **S 2** VDP Structure ..................... 9
  - CTRL ................................. 9
  - VRAM ................................. 9
  - CRAM ................................. 9
  - VSRAM ................................ 9
  - DMA .................................. 9
- **S 3** Interrupts ........................ 10
  - Vertical Interrupt ................... 10
  - Horizontal Interrupt ................. 10
  - External Interrupt ................... 11
- **S 4** VDP Interface ..................... 12
  - $C00000 (Data Channel) ............... 13
  - $C00004 (Control Channel) ............ 13
  - $C00008 (HV Counter) ................. 15
- **S 5** VDP Register ...................... 15
  - Reg. #0 - Reg. #3 ................... 16
  - Reg. #4 - Reg. #10 .................. 17
  - Reg. #11 - Reg. #14 ................. 18
  - Reg. #15 - Reg. #18 ................. 19
  - Reg. #19 - Reg. #23 ................. 20
- **S 6** Access VDP RAM .................... 21
  - Address Setting ...................... 21
  - VRAM Access .......................... 22
  - CRAM Access .......................... 26
  - VSRAM Access ......................... 27
  - Access Timing ........................ 28
  - HV Counter ........................... 29
- **S 7** DMA ............................... 30
  - Memory to VRAM ....................... 30
  - VRAM Fill ............................ 32
  - VRAM Copy ............................ 36
  - DMA Ability .......................... 38
- **S 8** Scroll ............................ 39
  - Screen Size .......................... 40
  - Horizontal Scroll .................... 41
  - Vertical Scroll ...................... 43
  - Scroll Pattern ....................... 45
  - Pattern Name ......................... 46
- **S 9** Window ............................ 48
  - Position ............................. 49
  - Priority ............................. 52
  - Pattern Name ......................... 52
- **S 10** Sprite ........................... 54
  - Position ............................. 54
  - Attribute ............................ 56
  - Size ................................. 57
  - Ability .............................. 57
  - Priority (Sprites) ................... 58
  - Pattern Generator .................... 60
- **S 11** Priority ......................... 61
- **S 12** Color Palette .................... 67
- **S 13** Interlace Mode ................... 69

### 3. 8/16 Bit Compatibility

- Mark III (MS - Japan) ................. 71
- MS ................................... 71
- RAM Card ............................. 71

### 4. I/O

- **S 1** Version No. ....................... 72
- **S 2** I/O ............................... 72
- **S 3** Memory Mode ....................... 76
- **S 4** Z80 Controls ...................... 76
  - Z80 BUSREQ ........................... 76
  - Z80 RESET ............................ 76
- **S 5** Z80 Area .......................... 77
  - Sound RAM ............................ 77
  - Sound Chip ........................... 77
  - Bank Register ........................ 77

### 5. VRAM Mapping ......................... 79

### 6. Appendix ............................. XX

---

## 1. Memory Map

### S 1 -- Mega Drive 16 Bit Mode

(As distinct from Master System compatibility mode)

### 68K Memory Map

| Address Range       | Contents          |
|---------------------|-------------------|
| $000000 - $3FFFFF   | ROM CARTRIDGE     |
| $400000 - $5FFFFF   | (unused)          |
| $600000 - $7FFFFF   | SEGA RESERVED     |
| $800000 - $9FFFFF   | SEGA RESERVED     |
| $A00000 - $A0FFFF   | Z80               |
| $A10000 - $A10FFF   | I/O               |
| $A11000 - $A11FFF   | CONTROL           |
| $A12000 - $AFFFFF   | SEGA RESERVED     |
| $B00000 - $BFFFFF   | SEGA RESERVED     |
| $C00000 - $DFFFFF   | VDP               |
| $E00000 - $FEFFFF   | ACCESS PROHIBITED |
| $FF0000 - $FFFFFF   | WORK RAM          |

### Z80 Memory Map

| Address Range  | Contents              |
|----------------|-----------------------|
| 0000h - 1FFFh  | SOUND RAM             |
| 2000h - 3FFFh  | SEGA RESERVED         |
| 4000h - 5FFFh  | SOUND CHIP (YM2612)   |
| 6000h - 7FFFh  | MISC.                 |
| 8000h - FFFFh  | 68000 BANK            |

**Z80 Sound Chip Detail (4000h - 5FFFh):**

| Address | Register     |
|---------|--------------|
| 4000h   | YM2612 A0    |
| 4001h   | YM2612 D0    |
| 4002h   | YM2612 A1    |
| 4003h   | YM2612 D1    |
| 4004h   | ACCESS PROHIBITED |

**Z80 Misc. Area (6000h - 7FFFh):**

| Address | Register        |
|---------|-----------------|
| 6000h   | BANK REGISTER   |
| 6001h   | ACCESS PROHIBITED |
| 7F11h   | PSG 76489       |
| 7F12h   | ACCESS PROHIBITED |

### 68000 Access to Z80 Memory

(The 68000 can access the Z80 address space through addresses $A00000-$A0FFFF.)

### I/O Area

| Address Range       | Contents                  |
|---------------------|---------------------------|
| $A10000 - $A10001   | Version No.               |
| $A10002 - $A10007   | DATA (CTRL 1), DATA (CTRL 2), DATA (EXP) |
| $A10008 - $A1000D   | CONTROL (1), CONTROL (2), CONTROL (E) |
| $A1000E - $A10013   | TxDATA, RxDATA, S-MODE (1) |
| $A10014 - $A10019   | TxDATA, RxDATA, S-MODE (2) |
| $A1001A - $A1001F   | TxDATA, RxDATA, S-MODE (3) |
| $A10020 - $A1FFFF   | ACCESS PROHIBITED         |

### Control Area

| Address Range       | Contents          |
|---------------------|-------------------|
| $A11000 - $A11001   | MEMORY MODE       |
| $A11002 - $A110FF   | ACCESS PROHIBITED |
| $A11100 - $A11101   | Z80 BUSREQ        |
| $A11102 - $A111FF   | ACCESS PROHIBITED |
| $A11200 - $A11201   | Z80 RESET          |
| $A11202 - $A1FFFF   | ACCESS PROHIBITED |

### VDP Area

| Address Range       | Contents          |
|---------------------|-------------------|
| $C00000 - $C00003   | DATA              |
| $C00004 - $C00007   | CONTROL           |
| $C00008 - $C00009   | HV COUNTER        |
| $C0000A - $C0000F   | ACCESS PROHIBITED |
| $C00010 - $C00011   | ACCESS PROHIBITED / PSG 76489 |
| $C00012 - $DFFFFF   | ACCESS PROHIBITED |

---

## 2. VDP 315-5313 (Video Display Processor)

The VDP controls screen display. VDP has graphic modes IV and V. Mode IV is for compatibility with the MASTER SYSTEM and V is for the new Mega Drive functions. There are no advantages to using mode IV, so it is assumed that all Mega Drive development will use mode V.

In Mode V, the VDP display has 4 planes: SPRITE, SCROLL A/WINDOW, SCROLL B, and BACKGROUND.

**Graphic IV Mode (Compatibility Mode):**
- SCROLL and SPRITE feed into PRIORITY CONTROLLER, which outputs to DISPLAY alongside BACKGROUND.

**Graphic V Mode (16 Bit Mode):**
- SCROLL B, SCROLL A, WINDOW, and SPRITE all feed into PRIORITY CONTROLLER, which outputs to DISPLAY alongside BACKGROUND.

### Terminology

1. A unit of position on X Y coordinates is called a "DOT".
2. A minimum unit of display is called a "PIXEL".
3. "CELL" means an 8 (pixel) x 8 (pixel) pattern.
4. SCROLL indicates a repositionable screen-spanning play field.
5. CPU usually indicates the 68000.
6. VDP stands for Video Display Processor.
7. CTRL stands for Control.
8. VRAM stands for VDP RAM, the 64K bytes area of RAM accessible only through the VDP.
9. CRAM stands for Color RAM, 64 9-bit words inside the VDP chip.
10. VSRAM stands for Vertical Scroll RAM. 40 10-bit words inside the VDP chip.
11. DMA stands for Direct Memory Access, the process by which the VDP performs high speed fills or memory copies.
12. PSG stands for Programmable Sound Generator. A class of low-capability Sound chips. The Mega Drive contains a Texas Instruments 76489 PSG chip.
13. FM stands for Frequency Modulation, a class of high-capability sound chip. The Mega Drive contains a Yamaha 2612 FM chip.

---

### S 1 -- Display Specification

| Feature               | Specification |
|-----------------------|---------------|
| **Display Size**      | Two modes: 32x28 CELL (256x224 PIXEL), 40x28 CELL (320x224 PIXEL) |
| **Character Generator** | 8x8 CELLS, 1300-1800 depending on general system configuration |
| **Scroll Playfields** | Two scrolling play fields. Size in cells selectable from: 32x32, 32x64, 32x128, 64x32, 64x64, 128x32 |
| **Sprite**            | Size is programmable per sprite: 8x8, 8x16, 8x24, 8x32, 16x8, 16x16, 16x24, 16x32, 24x8, 24x16, 24x24, 24x32, 32x8, 32x16, 32x24, 32x32. 64 sprites in 32-cell mode, 80 in 40-cell mode. |
| **Window**            | 1 window associated with the Scroll A play field |
| **Colors**            | 64 colors / 512 possibilities |

For PAL (the European Television 50Hz standard), a vertical size of 30 cells (240 dots) is selectable.

### Display Timing

The VDP supports both NTSC and PAL television standards. In both cases, the screen is divided into active scan, where the picture is displayed, and vertical retrace (or vertical blanking) where the monitor prepares for the next display.

**Raster counts per screen:**

| Standard | Lines/Screen | VCELL | Line No. (Display) | Line No. (Retrace) |
|----------|-------------|-------|--------------------|--------------------|
| NTSC     | 262         | 28    | 224 RASTER         | 38 RASTER          |
| PAL      | 312         | 28    | 224 RASTER         | 98 RASTER          |
| PAL      | 312         | 30    | 240 RASTER         | 82 RASTER          |

---

### S 2 -- VDP Structure

The CPU controls the VDP by special I/O memory locations.

**CTRL (Control):**
This controls REGISTER, VRAM, CRAM, VSRAM, DMA DISPLAY, etc.

**VRAM (VDP RAM):**
General purpose storage area for display data.

**CRAM (Color RAM):**
64 colors divided into 4 palettes of 16 colors each.

**VSRAM (Vertical Scroll RAM):**
Up to 20 different vertical scroll values each for scrolling play fields A and B.

**DMA (Direct Memory Access):**
The VDP may move data at high speed from CPU memory to VRAM, CRAM, and VSRAM instead of the CPU, by taking the 68000 off the bus and doing DMA itself. The VDP can also fill the VRAM with a constant, or copy from VRAM to VRAM without disturbing the 68000.

---

### S 3 -- Interrupts

There are three interrupts: Vertical, Horizontal, and External. You can control each interrupt by the IE0, IE1, and IE2 bits in the VDP registers. The interrupts use the AUTO-VECTOR mode of the 68000 and are at levels 6, 4, and 2 respectively. The level 6 vertical interrupt has the highest priority.

| Bit | Interrupt          | Level   |
|-----|--------------------|---------|
| IE0 | V Interrupt        | LEVEL 6 |
| IE1 | H Interrupt        | LEVEL 4 |
| IE2 | External Interrupt | LEVEL 2 |

- 1 : Enable
- 0 : Disable

#### Vertical Interrupt (V-INT)

The vertical interrupt occurs just after V retrace.

#### Horizontal Interrupt (H-INT)

The horizontal interrupt occurs just before H retrace (about 36 CPU clocks before the VDP fetches information for the next line).

The VDP loads the required display information, including all required register values, for the line in about 36 clocks, thus the CPU can control the display of the next line but not the line on which the interrupt occurs.

The horizontal interrupt is controlled by a line counter in register #10. If this line counter is changed at each interrupt, the desired spacing of interrupts may be achieved.

- If Register #10 equals 00h then the interrupt occurs every line.
- If Register #10 equals 01h then the interrupt occurs every other line.
- If Register #10 equals 02h then the interrupt occurs every third line.

#### External Interrupt (EX-INT)

The external interrupt is generated by a peripheral device (gun, modem) and stops the counter for later examination by the CPU.

Please see other sections of this manual for information about the H, V counter and the initialization of the external interrupt.

---

### S 4 -- VDP Port

The VDP ports are at location $C00000 in the 68000 memory space.

| Address  | Function      |
|----------|---------------|
| $C00000  | DATA PORT     |
| $C00002  | DATA PORT (mirror) |
| $C00004  | CONTROL PORT  |
| $C00006  | CONTROL PORT (mirror) |
| $C00008  | HV COUNTER    |
| $C0000A  | PROHIBITED    |
| $C0000C  | PROHIBITED    |
| $C0000E  | PROHIBITED    |
| $C00010  | PROHIBITED / PSG |

#### $C00000 (Data Port)

**READ/WRITE: VRAM, VSRAM, CRAM**

$C00000 and $C00002 are functionally equivalent.

Data format: D15-D8 (upper byte), D7-D0 (lower byte).

#### $C00004 (Control Port)

$C00004 and $C00006 are functionally equivalent.

**READ: Status Register**

| Bit  | Name | Description |
|------|------|-------------|
| D15-D10 | *  | NO USE |
| D9   | EMPT | 1: Write FIFO Empty, 0: not empty |
| D8   | FULL | 1: Write FIFO Full, 0: not full |
| D7   | F    | 1: V interrupt happened |
| D6   | SOVR | 1: Sprite overflow occurred, too many in one line (over 17 in 32-cell mode, over 21 in 40-cell mode) |
| D5   | C    | 1: Collision happened between non-zero pixels in two sprites |
| D4   | ODD  | 1: Odd frame in interlace mode, 0: Even frame in interlace mode |
| D3   | VB   | 1: During V blanking |
| D2   | HB   | 1: During H blanking |
| D1   | DMA  | 1: DMA BUSY |
| D0   | PAL  | 1: PAL MODE, 0: NTSC MODE |

**WRITE1: Register Set**

```
$C00004:  [1] [0] [0] [RS4] [RS3] [RS2] [RS1] [RS0]   (D15 ~ D8)
          [D7] [D6] [D5] [D4] [D3] [D2] [D1] [D0]     (D7 ~ D0)

RS4 ~ RS0 : Register No.
D7 ~ D0   : Data
```

You must use word or long word access to VDP ports when setting the registers. Long word access is equivalent to two word accesses, with D31-D16 written first.

**WRITE2: Address Set**

```
1st       [CD1] [CD0] [A13] [A12] [A11] [A10] [A9] [A8]   (D15 ~ D8)
$C00004   [A7]  [A6]  [A5]  [A4]  [A3]  [A2]  [A1] [A9]   (D7 ~ D0)

2nd       [0] [0] [0] [0] [0] [0] [0] [0]                  (D15 ~ D8)
$C00004   [CD5] [CD4] [CD3] [CD2] [0] [0] [A15] [A14]     (D7 ~ D0)

CD5 ~ CD0 : ID CODE
A15 ~ A0  : DESTINATION RAM ADDRESS
```

**Access Mode Table:**

| Access Mode  | CD5 | CD4 | CD3 | CD2 | CD1 | CD0 |
|-------------|-----|-----|-----|-----|-----|-----|
| VRAM WRITE  | 0   | 0   | 0   | 0   | 0   | 1   |
| CRAM WRITE  | 0   | 0   | 0   | 0   | 1   | 1   |
| VSRAM WRITE | 0   | 0   | 0   | 1   | 0   | 1   |
| VRAM READ   | 0   | 0   | 0   | 0   | 0   | 0   |
| CRAM READ   | 0   | 0   | 1   | 0   | 0   | 0   |
| VSRAM READ  | 0   | 0   | 0   | 1   | 0   | 0   |

You must use word or long word when performing these operations.

#### $C00008 (HV Counter)

**Non Interlace Mode:**

```
$C00008:  [VC7] [VC6] [VC5] [VC4] [VC3] [VC2] [VC1] [VC0]   (D15 ~ D8)
          [HC8] [HC7] [HC6] [HC5] [HC4] [HC3] [HC2] [HC1]   (D7 ~ D0)
```

**Interlace Mode:**

```
$C00008:  [VC7] [VC6] [VC5] [VC4] [VC3] [VC2] [VC1] [VC8]   (D15 ~ D8)
          [HC8] [HC7] [HC6] [HC5] [HC4] [HC3] [HC2] [HC1]   (D7 ~ D0)

HC8 ~ HC1 : H COUNTER
VC8 ~ VC0 : V COUNTER
```

---

### S 5 -- VDP Registers

VDP has write-only registers #0 through #23 and read-only status register, for a total of 25 registers. There are two modes for register settings. One is mode 4 and another is mode 5. This section covers mode 5. If you change mode in one frame you can get various effects.

#### Mode Set Register No. 1 (REG #0)

```
MSB                                              LSB
REG #0:  [0] [0] [0] [IE1] [0] [1] [M3] [0]
```

| Bit | Function |
|-----|----------|
| IE1 | 1: Enable H interrupt (68000 Level 4) |
|     | 0: Disable H interrupt (REG #10) |
| M3  | 1: HV Counter stop |
|     | 0: Enable read HV counter |

#### Mode Set Register No. 2 (REG #1)

```
MSB                                              LSB
REG #1:  [0] [DISP] [IE0] [M1] [M2] [1] [0] [0]
```

| Bit  | Function |
|------|----------|
| DISP | 1: Enable Display, 0: Disable Display |
| IE0  | 1: Enable V interrupt (68000 Level 6), 0: Disable V interrupt |
| M1   | 1: DMA Enable, 0: DMA Disable |
| M2   | 1: V 30 cell mode (PAL mode), 0: V 28 cell mode (PAL mode, always 0 in NTSC mode) |

#### Pattern Name Table Base Address for Scroll A (REG #2)

```
MSB                                              LSB
REG #2:  [0] [0] [SA15] [SA14] [SA13] [0] [0] [0]
```
VRAM ADDR $XXX0\_0000\_0000\_0000

#### Pattern Name Table Base Address for Window (REG #3)

```
MSB                                              LSB
REG #3:  [0] [0] [WD15] [WD14] [WD13] [WD12] [WD11] [0]
```
- WD11 should be 0 in H40 cell mode
- VRAM ADDR $XXXX\_X000\_0000\_0000 (H 32 cell mode)
- VRAM ADDR $XXXX\_0000\_0000\_0000 (H 40 cell mode)

#### Pattern Name Table Base Address for Scroll B (REG #4)

```
MSB                                              LSB
REG #4:  [0] [0] [0] [0] [0] [SB15] [SB14] [SB13]
```
VRAM ADDR $XXX0\_0000\_0000\_0000

#### Sprite Attribute Table Base Address (REG #5)

```
MSB                                              LSB
REG #5:  [0] [AT15] [AT14] [AT13] [AT12] [AT11] [AT10] [AT9]
```
- AT9 should be 0 in H 40 cell mode
- VRAM ADDR $XXXX\_XXX0\_0000\_0000 (32 cell)
- VRAM ADDR $XXXX\_XX00\_0000\_0000 (40 cell)

#### REG #6

```
MSB                                              LSB
REG #6:  [0] [0] [0] [0] [0] [0] [0] [0]
```
(Unused -- always 0)

#### Background Color (REG #7)

```
MSB                                              LSB
REG #7:  [0] [0] [CPT1] [CPT0] [COL3] [COL2] [COL1] [COL0]
```

| Field     | Function |
|-----------|----------|
| CPT1,CPT0 | COLOR PALETTE |
| COL3~COL0 | COLOR CODE |

#### REG #8, REG #9

Both unused (always 0).

#### H Interrupt Register (REG #10)

```
MSB                                              LSB
REG #10: [BIT7] [BIT6] [BIT5] [BIT4] [BIT3] [BIT2] [BIT1] [BIT0]
```

This register sets H interrupt timing by number of raster lines. H interrupt is enabled by IE1=1.

#### Mode Set Register No. 3 (REG #11)

```
MSB                                              LSB
REG #11: [0] [0] [0] [0] [IE2] [VSCR] [HSCR] [LSCR]
```

| Bit  | Function |
|------|----------|
| IE2  | 1: Enable external interrupt (68000 Level 2), 0: Disable external interrupt |

**VSCR: V scroll mode**

| VSCR | Function |
|------|----------|
| 0    | FULL SCROLL |
| 1    | EACH 2 CELL SCROLL |

**HSCR, LSCR: H scroll mode** (both Scroll A and B)

| HSCR | LSCR | Function |
|------|------|----------|
| 0    | 0    | FULL SCROLL |
| 0    | 1    | PROHIBITED |
| 1    | 0    | EACH 1 CELL SCROLL |
| 1    | 1    | EACH 1 LINE SCROLL |

#### Mode Set Register No. 4 (REG #12)

```
MSB                                              LSB
REG #12: [RS0] [0] [0] [S/TE] [LSM1] [LSM0] [RS1]
```

| Bit  | Function |
|------|----------|
| RS0  | 0: Horizontal 32 cell mode, 1: Horizontal 40 cell mode |
| RS1  | 0: Horizontal 32 cell mode, 1: Horizontal 40 cell mode |
| S/TE | 1: Enable SHADOW and HIGHLIGHT, 0: Disable SHADOW and HIGHLIGHT |
| LSM1, LSM0 | Interlace mode setting |

You should set the same value in RS0 and RS1:
- 32 cell: 0000\_XXX0
- 40 cell: 1000\_XXX1

**Interlace Mode:**

| LSM1 | LSM0 | Function |
|------|------|----------|
| 0    | 0    | NO INTERLACE |
| 0    | 1    | INTERLACE |
| 1    | 0    | PROHIBITED |
| 1    | 1    | INTERLACE (Double Resolution) |

#### H Scroll Data Table Base Address (REG #13)

```
MSB                                              LSB
REG #13: [0] [0] [HS15] [HS14] [HS13] [HS12] [HS11] [HS10]
```
VRAM ADDR $XXXX\_XX00\_0000\_0000

#### REG #14

Unused (always 0).

#### Auto Increment Data (REG #15)

```
MSB                                              LSB
REG #15: [INC7] [INC6] [INC5] [INC4] [INC3] [INC2] [INC1] [INC0]
```

INC7~INC0: Bias number (0 ~ $FF). This number is added automatically after RAM access.

#### Scroll Size (REG #16)

```
MSB                                              LSB
REG #16: [0] [0] [VSZ1] [VSZ0] [0] [0] [HSZ1] [HSZ0]
```

**Vertical scroll size:**

| VSZ1 | VSZ0 | Function |
|------|------|----------|
| 0    | 0    | V 32 cell |
| 0    | 1    | V 64 cell |
| 1    | 0    | PROHIBITED |
| 1    | 1    | V 128 cell |

**Horizontal scroll size:** (both Scroll A and B)

| HSZ1 | HSZ0 | Function |
|------|------|----------|
| 0    | 0    | H 32 cell |
| 0    | 1    | H 64 cell |
| 1    | 0    | PROHIBITED |
| 1    | 1    | H 128 cell |

#### Window H Position (REG #17)

```
MSB                                              LSB
REG #17: [RIGT] [0] [0] [WHP5] [WHP4] [WHP3] [WHP2] [WHP1]
```

| Bit   | Function |
|-------|----------|
| RIGT  | 0: Window is in left side from base point, 1: Window is in right side from base point |
| WHP5~WHP1 | Base pointer. 0=Left Side, 1=1 cell right, 2=2 cells right... |

#### Window V Position (REG #18)

```
MSB                                              LSB
REG #18: [DOWN] [0] [0] [WVP4] [WVP3] [WVP2] [WVP1] [WVP0]
```

| Bit   | Function |
|-------|----------|
| DOWN  | 0: Window is in upper side from base point, 1: Window is in lower side from base point |
| WVP4~WVP0 | Base pointer. 0=Upper side, 1=1 cell down, 2=2 cells down... |

#### DMA Length Counter Low (REG #19)

```
MSB                                              LSB
REG #19: [LG7] [LG6] [LG5] [LG4] [LG3] [LG2] [LG1] [LG0]
```

#### DMA Length Counter High (REG #20)

```
MSB                                              LSB
REG #20: [LG15] [LG14] [LG13] [LG12] [LG11] [LG10] [LG9] [LG8]
```

LG15~LG0: DMA LENGTH COUNTER

#### DMA Source Address Low (REG #21)

```
MSB                                              LSB
REG #21: [SA8] [SA7] [SA6] [SA5] [SA4] [SA3] [SA2] [SA1]
```

#### DMA Source Address Mid (REG #22)

```
MSB                                              LSB
REG #22: [SA16] [SA15] [SA14] [SA13] [SA12] [SA11] [SA10] [SA9]
```

#### DMA Source Address High (REG #23)

```
MSB                                              LSB
REG #23: [DMD1] [DMD0] [SA22] [SA21] [SA20] [SA19] [SA18] [SA17]
```

| Field      | Function |
|------------|----------|
| SA22~SA1   | DMA Source address |
| DMD1, DMD0 | DMA MODE |

| DMD1 | DMD0 | Function |
|------|------|----------|
| 0    | SA23 | MEMORY TO VRAM |
| 1    | 0    | VRAM FILL |
| 1    | 1    | VRAM COPY |

---

### S 6 -- Access VDP RAM

#### RAM Address Setting

You can access VRAM, CRAM, and VSRAM after writing 32 bits of control data to $C00004 or $C00006.

You have to use word or long word when addressing. If you use long word, D31-D16 is 1st, D15-D0 is 2nd.

```
1st       [CD1] [CD0] [A13] [A12] [A11] [A10] [A9] [A8]   (D15 ~ D8)
$C00004   [A7]  [A6]  [A5]  [A4]  [A3]  [A2]  [A1] [A9]   (D7 ~ D0)

2nd       [0] [0] [0] [0] [0] [0] [0] [0]                  (D15 ~ D8)
$C00004   [CD5] [CD4] [CD3] [CD2] [0] [0] [A15] [A14]     (D7 ~ D0)
```

**Access Mode Table:**

| Access Mode  | CD5 | CD4 | CD3 | CD2 | CD1 | CD0 |
|-------------|-----|-----|-----|-----|-----|-----|
| VRAM WRITE  | 0   | 0   | 0   | 0   | 0   | 1   |
| CRAM WRITE  | 0   | 0   | 0   | 0   | 1   | 1   |
| VSRAM WRITE | 0   | 0   | 0   | 1   | 0   | 1   |
| VRAM READ   | 0   | 0   | 0   | 0   | 0   | 0   |
| CRAM READ   | 0   | 0   | 1   | 0   | 0   | 0   |
| VSRAM READ  | 0   | 0   | 0   | 1   | 0   | 0   |

#### VRAM Access

VRAM address range from 0 to 0FFFFh, 64K bytes total.

**VRAM Write Addressing:**

```
1st       [0] [1] [A13] [A12] [A11] [A10] [A9] [A8]       (D15 ~ D8)
$C00004   [A7] [A6] [A5] [A4] [A3] [A2] [A1] [A0]         (D7 ~ D0)

2nd       [0] [0] [0] [0] [0] [0] [0] [0]                  (D15 ~ D8)
$C00004   [C] [0] [0] [0] [0] [A15] [A14]                  (D7 ~ D0)

A15 ~ A0 : VRAM address

Data      [D15] [D14] [D13] [D12] [D11] [D10] [D9] [D8]   (D15 ~ D8)
$C00000   [D7] [D6] [D5] [D4] [D3] [D2] [D1] [D0]         (D7 ~ D0)
D15 ~ D0 : VRAM data
```

When you use long word, D31~D16 is 1st, D15~D0 is 2nd. When you do byte writing, data is D7~D0, and may be written to $C00000 or $C00001.

VRAM address is increased by the value of REGISTER #15 (independent of data size). VRAM address A0 is used in the calculation of the address increment, but is ignored during address decoding.

**VRAM addressing and decoding:**
The CRAM address decode uses A15~A1, and A0 specifies the data write format. Write data cannot cross a word boundary -- high and low bytes are exchanged if A0=1.

**Byte/Word/Long Word write behavior with different A0 and REG #15 settings** are detailed in extensive examples (see original document pages 29-30 for complete tables showing data ordering for START ADDRESS 0 and 1 with REG #15=2 and REG #15=1).

**VRAM Read:**

```
1st       [0] [0] [A13] [A12] [A11] [A10] [A9] [A8]       (D15 ~ D8)
$C00004   [A7] [A6] [A5] [A4] [A3] [A2] [A1] [A0]         (D7 ~ D0)

2nd       [0] [0] [0] [0] [0] [0] [0] [0]                  (D15 ~ D8)
$C00004   [0] [0] [0] [0] [0] [A15] [A14]                  (D7 ~ D0)
```

Data is always read in word units. A0 is ignored during the read; no swap of bytes occurs if A0=1. Subsequent reads are from address incremented by REGISTER #15. A0 is used in calculation of the next address.

#### CRAM Access

The CRAM contains 128 bytes, addresses 0 to 7Fh.

**CRAM Write:**

```
1st       [1] [1] [0] [0] [0] [0] [0] [0]                 (D15 ~ D8)
$C00004   [0] [A6] [A5] [A4] [A3] [A2] [A1] [A0]          (D7 ~ D0)

2nd       [0] [0] [0] [0] [0] [0] [0] [0]                  (D15 ~ D8)
$C00004   [0] [0] [0] [0] [0] [0] [0] [0]                  (D7 ~ D0)

A6 ~ A0 : VRAM address
```

**CRAM Data format (write):**

```
$C00000   [0] [0] [0] [B2] [B1] [B0] [0]                  (D15 ~ D8)
          [G2] [G1] [G0] [0] [R2] [R1] [R0] [0]           (D7 ~ D0)
```

D15~D0 are valid when we use word for data set. If the writes are byte wide, write the high byte to $C00000 and the low byte to $C00001. A long word wide access is equivalent to two sequential word wide accesses.

Note that A0 is used in the increment but not in address decoding, resulting in some interesting side-effects if writes are attempted at odd addresses.

**CRAM Read format:**

```
$C00000   [*] [*] [*] [*] [B2] [B1] [B0] [*]              (D15 ~ D8)
          [G2] [G1] [G0] [*] [R2] [R1] [R0] [*]           (D7 ~ D0)
```

#### VSRAM Access

The VSRAM contains 80 bytes, addresses 0 to 4Fh.

**VSRAM Write:**

```
1st       [0] [1] [0] [0] [0] [0] [0] [0]                 (D15 ~ D8)
$C00004   [0] [A6] [A5] [A4] [A3] [A2] [A1] [A0]          (D7 ~ D0)

2nd       [0] [0] [0] [0] [0] [0] [0] [0]                  (D15 ~ D8)
$C00004   [0] [0] [1] [0] [0] [0] [0] [0]                  (D7 ~ D0)

Data      [VS10] [VS9] [VS8]                               (D15 ~ D8)
$C00000   [VS7] [VS6] [VS5] [VS4] [VS3] [VS2] [VS1] [VS0] (D7 ~ D0)
VS10 ~ VS0 : V quantity of scroll
```

Same byte/word/long-word and A0 rules apply as for CRAM access.

**VSRAM Read** uses similar addressing with CD3=1 for the read code.

#### Access Timing

The CPU and VDP access VRAM, CRAM, and VSRAM using timesharing. Because the VDP is very busy during the active scan, the CPU accesses are limited. However, during vertical blanking the CPU may access the VDP continuously.

The number of permitted accesses by the CPU additionally depends on whether the screen is in 32 cell mode or 40 cell mode. Additionally the access size depends on the RAM type; a VRAM access is byte wide, but CRAM and VSRAM are word wide.

**Access timing per scan line:**

| Scan Period   | H 32 cell | H 40 cell |
|--------------|-----------|-----------|
| 1 scan total | 167 times | 205 times |

For example, in 32 cell mode, the CPU may access the VRAM 16 times during horizontal scan in a single line. Each access is a byte write, so this amounts to 2 words. However CRAM and VSRAM, though sharing the 16 time limit, are word accesses so that 16 words may be written in a single line.

Although there is a four-word FIFO, if writes are done in a tight loop during active scan the FIFO will fill up and the CPU will eventually end up waiting to write.

**Maximum wait times:**

| Display Mode | Maximum Waiting Time |
|-------------|---------------------|
| H 32 cell   | Approximate 5.96 usec |
| H 40 cell   | Approximate 4.77 usec |

As the CPU has unlimited access to the RAMs during vertical blanking, the wait case never arises.

#### HV Counter

The HV counter's function is to give the horizontal and vertical location of the television beam. If the "M3" bit of REGISTER #0 is set, the HV counter will then freeze when trigger signal HL goes high, as well as triggering a level 2 interrupt.

| M3 | Counter Latch Mode |
|----|-------------------|
| 0  | COUNTER IS NOT LATCHED BY TRIGGER SIGNAL |
| 1  | COUNTER IS LATCHED BY TRIGGER SIGNAL |

M3: Register #0

**Non Interlace Mode:**

```
$C00008:  [VC7] [VC6] [VC5] [VC4] [VC3] [VC2] [VC1] [VC8]   (D15 ~ D8)
          [HC8] [HC7] [HC6] [HC5] [HC4] [HC3] [HC2] [HC1]   (D7 ~ D0)
```

**Interlace Mode:**

```
$C00008:  [VC7] [VC6] [VC5] [VC4] [VC3] [VC2] [VC1] [VC8]   (D15 ~ D8)
          [HC8] [HC7] [HC6] [HC5] [HC4] [HC3] [HC2] [HC1]   (D7 ~ D0)
```

**V-Counter ranges:**

| Display Mode | Counter Data |
|-------------|-------------|
| V 28 cell   | 0 ~ DFh     |
| V 30 cell   | 0 ~ EFh     |

**H-Counter ranges:**

| Display Mode | Counter Data |
|-------------|-------------|
| H 32 cell   | 0 ~ 7Fh     |
| H 40 cell   | 0 ~ 9Fh     |

The counter only has eight bits each for H and V, so interlace mode and 40 cell (320 dots) modes present some problems. During interlace mode, the LSB of the vertical position is replaced by the new MSB. And the horizontal resolution problem is solved by ALWAYS dropping the LSB.

**CAUTION:** As the HV counter's value is not valid during vertical blanking, check to be sure that it is active scan before using the value.

---

### S 7 -- DMA Transfer

DMA (Direct Memory Access) is a high speed technique for memory accesses to the VRAM, CRAM and VSRAM. During DMA, VRAM, CRAM and VSRAM occur at the fastest possible rate. There are three modes of DMA access, all of which may be done to VRAM or CRAM or VSRAM. The 68K is stopped during memory to VRAM/CRAM/VSRAM DMA, but the Z80 continues to run as long as it does not attempt access to the 68K memory space.

The DMA is quite fast during VBLANK -- about double the tightest possible 68K loop's speed, but during active scan the speed is the same as a 68K loop.

Please note that after this point, VRAM is used as a generic term for VRAM/CRAM/VSRAM.

| DMD1 | DMD0 | DMA Mode         | Size               |
|------|------|------------------|---------------------|
| 0    | SA23 | A. MEMORY TO V-RAM | WORD to BYTE(H)&(L) |
| 1    | 0    | B. VRAM FILL     | BYTE to BYTE        |
| 1    | 1    | C. VRAM COPY     | BYTE to BYTE        |

DMD1, DMD0: REG #23, DMD0=SA23

Source address range: $000000-$3FFFFF (ROM) and $FF0000-$FFFFFF (RAM).

**Hardware bug for ROM to VRAM transfers:** A hardware feature causes occasional failure of DMA unless the following two conditions are observed:
1. The destination address write (to address $C00004) must be a word write.
2. The final write must use the work RAM. There are two ways to accomplish this: by copying the DMA program into RAM, or by doing a final `move.w` to RAM address $C00004.

#### Memory to VRAM

The function transfers data from 68K memory to VRAM, CRAM or VSRAM. During this DMA, all 68K processing stops. The source address is $000000-$3FFFFF for ROM or $FF0000-$FFFFFF for RAM. The DMA reads are word wide. Writes are byte wide for VRAM and word wide for CRAM and VSRAM. The destination is specified by:

| CD2 | CD1 | CD0 | Memory Type |
|-----|-----|-----|-------------|
| 0   | 0   | 1   | VRAM        |
| 0   | 1   | 1   | CRAM        |
| 1   | 0   | 1   | VSRAM       |

**Setting of DMA (Memory to VRAM):**

1. (A) M1 (REG. #1)=1 : DMA ENABLE
2. (B) Increment No. set to #15 (normally 2)
3. (C) Transfer word No. set into #19, #20
4. (D) Source address and DMA mode set into #21, #22, #23
5. (E) Set the destination address
6. (F) VDP gets the CPU bus
7. (G) DMA start
8. (H) VDP releases the CPU bus
9. (I) M1 have to be 0 after confirmation of DMA finish: DMA DISABLED

DMA starts after (E). You must set M1=1 only during DMA otherwise we cannot guarantee the operation. Source address is increased with +2 and destination address is increased with content of register #15.

**Register contents for Memory to VRAM DMA:**

```
REG. #15: [INC7-INC0]              No. of increment
REG. # 1: [0|DISP|IE0|M1|M2|1|0|0]
REG. #19: [LG7-LG0]               }
REG. #20: [LG15-LG8]              } DMA length
REG. #21: [SA8-SA1]               }
           (REG #22 between)      } Source address
REG. #23: [DMD1|DMD0|SA22-SA17]   }

1st $C00004: [CD1|CD0|DA13-DA8]   (D15~D8)
             [A7-A9]              (D7~D0)
2nd $C00004: [1|0|0|CD2|0|0|DA15|DA14]  (D7~D0)

LG15-LG0  : No. of move word
SA23-SA1  : Source address (in 68000)
DA15-DA0  : Destination address (in VDP)
CD2-CD0   : RAM selection
```

#### VRAM Fill

FILL mode fills with same data from free even VRAM address. FILL is for only VRAM.

**How to set FILL(DMA):**

1. (A) M1 (REG. #1)=1 : DMA ENABLE
2. (B) Increment No. set to #15 (normally 1)
3. (C) Fill size set to #19, #20
4. (D) DMA mode set to #23
5. (E) Destination address and FILL data set
6. (F) DMA start
7. (G) M1=0 after confirmation of finishing: DMA DISABLED

DMA starts after (E). M1 should be 1 in the DMA transfer, otherwise we cannot guarantee the operation. Destination address is incremented with register #15. VDP does not ask bus open for CPU, but CPU cannot access VDP without PSG, HV counter and status. You can realize end of DMA by the DMA bit in status register.

**Register contents for VRAM Fill:**

```
REG. #15: [INC7-INC0]             Increment No.
REG. # 1: [0|DISP|IE0|M1|M2|1|0|0]
REG. #19: [LG7-LG0]              }
REG. #20: [LG15-LG8]             } Fill size
REG. #23: [DMD1|DMD0|SA22-SA17]

1st $C00004: [0|1|DA13-DA8]       (D15~D8)
             [A7-A9]              (D7~D0)
2nd $C00004: [1|0|0|0|0|DA15|DA14] (D7~D0)

Data $C00000: [FD15-FD0]

LG15-LG0  : FILL byte No.
DA15-DA0  : Destination address
FD15-FD0  : FILL data
```

When setting 1st and 2nd by long word, 1st will be D31-D16 and 2nd will be D15-D0.

**VRAM Fill behavior example (FILL data are word; register #15=1):**

**a. V-RAM address is even:**
1. (A) First, low side of FILL data are written in V-RAM address.
2. (B) Second, upper side of FILL data are written in V-RAM+1.
3. (C) And, V-RAM address is added register #15, written upper side FILL data in V-RAM at next each step.

**b. V-RAM address is odd:**
1. (D) First, upper side of Fill data are written in V-RAM address-1.
2. (E) Second, low side of Fill data are written in V-RAM.
3. (F) Same as (C).

Note: You must rewrite data (C) into ADD+1 after write data (B).

### 2. TERM: FILL data are word; register #15=2

**VRAM address=even:**

| Address | Content | Notes |
|---------|---------|-------|
| ADD | (A) lower | even |
| ADD+1 | (B) upper | odd |
| ADD+2 | (C) lower | |
| ADD+3 | upper | |
| ADD+4 | (C) lower | |
| ADD+5 | upper | |
| ADD+6 | (C) lower | |
| ADD+7 | upper | |

**VRAM address=odd:**

| Address | Content | Notes |
|---------|---------|-------|
| ADD-1 | (D) upper | even |
| ADD | (E) lower | odd |
| ADD+1 | | |
| ADD+2 | (F) upper | |
| ADD+3 | lower | |
| ADD+4 | (F) upper | |
| ADD+5 | lower | |
| ADD+6 | (F) upper | |
| ADD+7 | lower | |

### 3. TERM: Fill data are byte

**a. V-RAM address is even.**

(A) = (B) = (C) = BYTE * DATA

**b. V-RAM address is odd.**

(D) = (E) = (F) = BYTE * DATA

---

## VRAM COPY

This function does copy from source address to destination address by number of COPY byte.

DMA setting:

- (A) M1 (REG. #1) = 1 : DMA ENABLE
- (B) Number of copy bytes in #19, #20
- (C) Source address and DMA mode in #23
- (D) Destination address set
- (E) *DMA transfer
- (F) After confirming DMA finish: M1=0: DMA DISABLED

DMA starts when (D) above is finished. Apply M1=1 only during DMA transfer. In other cases, if M1=1 is set, there is no guaranty that it will function correctly. At the time of DMA transfer, the destination address is incremented by the set value of REG. #15. During DMA transfer, although the VDP does not require CPU to make a bus available, no access is possible from CPU to VDP except for PSG, HV counter. STATUS READ. DMA transfer finish can be recognized by referring to the STATUS REGISTER's DMA bit.

### Example: With TRANSFER BYTE=3 at the time of VRAM COPY

| SOURCE ADDRESS | REG#15=1 DESTINATION ADDRESS | REG#15=2 DESTINATION ADDRESS |
|----------------|------------------------------|------------------------------|
| DATA 1 | DATA 1 | DATA 1 |
| DATA 2 | DATA 2 | |
| DATA 3 | DATA 3 | DATA 2 |
| DATA 4 | | |
| DATA 5 | | DATA 3 |
| DATA 6 | | |
| DATA 7 | | |

**CAUTION:** In the case of VRAM COPY, "read from VRAM" and "write to VRAM" are repeated per byte. Therefore, when the SOURCE AREA and TRANSFER AREA are overlapped, the transfer may not be performed correctly.

---

## PSG Sound

The attenuators are set for the four channels by writing the following bytes to I/O location $7F:

| Channel | Bit 7 | Bit 6 | Bit 5-4 | Bit 3 | Bit 2 | Bit 1 | Bit 0 |
|---------|-------|-------|---------|-------|-------|-------|-------|
| Tone Generator #1 | 1 | 0 | | | A3 | A2 | A1 | A0 |
| Tone Generator #2 | 1 | 1 | | | A3 | A2 | A1 | A0 |
| Tone Generator #3 | 1 | 0 | | | A3 | A2 | A1 | A0 |
| Noise Generator | 1 | | | | A3 | A2 | A1 | A0 |

### EXAMPLE

When the Mk3 is powered on, the following code is executed:

```z80
    LD    HL,CLRTB     ; clear table
    LD    C,PSG_PRT    ; psg port is $7F
    LD    B,4          ; load four bytes
    OTIR              ; write them
    (etc.)

CLTB  defb $9F,$BF,$DF,$FF
```

This code turns the four sound channels off. It's a good idea to also execute this code when the PAUSE button is pressed, so that the sound does not stay on continuously for the pause interval.

---

## DMA Register Summary

REGISTER are as follows. REGISTER #1 includes bits set for purposes other than DMA. Therefore, pay careful attention in this regard.

**REG. #15** - Auto-Increment:

| INC7 | INC6 | INC5 | INC4 | INC3 | INC2 | INC1 | INC0 |
|------|------|------|------|------|------|------|------|

INC7 ~ INC0 : Increment No.

**STATUS Register:**

| F | SOVR | C | ODD | VB | * | HB | DMA | PAL |
|---|------|---|-----|----|----|----|----|-----|
| | | | | | | |EMPT|FULL|

DMA : 1: DMA BUSY

**REG. #1:**

| 0 | DISP | IE0 | M1 | M2 | 1 | 0 | 0 |
|---|------|-----|----|----|---|---|---|

**REG. #19** (DMA Length Low):

| LG7 | LG6 | LG5 | LG4 | LG3 | LG2 | LG1 | LG0 |
|-----|-----|-----|-----|-----|-----|-----|-----|

**REG. #20** (DMA Length High):

| LG15 | LG14 | LG13 | LG12 | LG11 | LG10 | LG9 | LG8 |
|------|------|------|------|------|------|-----|-----|

**REG. #21** (DMA Source Low):

| SA7 | SA6 | SA5 | SA4 | SA3 | SA2 | SA1 | SA0 |
|-----|-----|-----|-----|-----|-----|-----|-----|

**REG. #23** (DMA Source High / Mode):

| 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0 |
|---|---|---|---|---|---|---|---|

DMA command word format (1st write to $C00004):

| 0 | 0 | DA13 | DA12 | DA11 | DA10 | DA9 | DA8 | (D15 ~ D8) |
|---|---|------|------|------|------|-----|-----|-------------|
| DA7 | DA6 | DA5 | DA4 | DA3 | DA2 | DA1 | DA0 | (D7 ~ D0) |

DMA command word format (2nd write to $C00004):

| 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | (D15 ~ D8) |
|---|---|---|---|---|---|---|---|-------------|
| 1 | 1 | 0 | 0 | 0 | 0 | DA15 | DA14 | (D7 ~ D0) |

- LG15 - LG0 : Number of copy byte
- SA23 - SA1 : Source address
- DA15 - DA0 : Destination address

When setting 1st and 2nd by long word, 1st will be D31 - D16 and 2nd, D15 - D0.

---

## DMA TRANSFER CAPACITY

Transfer quantity varies depending on the DISPLAY MODE as follows:

| DMA MODE | DISPLAY MODE | SCREEN SCANNING | TRANSFER BYTES PER LINE |
|----------|-------------|-----------------|------------------------|
| MEMORY TO VRAM | H32 CELL | DURING EFFECTIVE SCREEN | 16 Bytes |
| | | DURING V BLANK | 167 Bytes |
| | H40 CELL | DURING EFFECTIVE SCREEN | 18 Bytes |
| | | DURING V BLANK | 205 Bytes |
| VRAM FILL | H32 CELL | DURING EFFECTIVE SCREEN | 15 Bytes |
| | | DURING V BLANK | 166 Bytes |
| | H40 CELL | DURING EFFECTIVE SCREEN | 17 Bytes |
| | | DURING V BLANK | 204 Bytes |
| VRAM COPY | H32 CELL | DURING EFFECTIVE SCREEN | 8 Bytes |
| | | DURING V BLANK | 83 Bytes |
| | H40 CELL | DURING EFFECTIVE SCREEN | 9 Bytes |
| | | DURING V BLANK | 102 Bytes |

In the MEMORY TO VRAM, in the case where CRAM and VSRAM are the destinations, number of words (not byte) should apply. One line during V BLANK allows for data transfer to all the address of CRAM and VSRAM.

Note that when calculating, the transfer quantity in one screen (1/60 sec) varies depending on the number of LINES during V BLANK (refer to DISPLAY MODE) in the case of NTSC (video signal) and PAL systems.

| DISPLAY MODE | No. of Horizontal line |
|-------------|----------------------|
| V 28 CELL (NTSC) | 36 |
| V 28 CELL (PAL) | 87 |
| V 30 CELL (PAL) | 71 |

Where REGISTER #1 DISP=0, i.e. when on-screen display is not made, the TRANSFER quantity is the same as TRANSFER BYTES PER LINE during BLANKING.

---

## S8 SCROLLING SCREEN

There are two different scroll screens, i.e. A and B which separately can scroll vertically and horizontally on a basis of a one dot unit. In the horizontal direction, scrolling overall or based on a one cell unit or one line unit can be selected. And in the vertical direction, scrolling overall or in a two cell unit can be selected. Also, the scroll screen size can be changed on a basis of a 32 cell unit.

### Register Settings

**SCROLL "A" PATTERN NAME TABLE BASE ADDRESS**

REG. #2:

| 0 | 0 | SA15 | SA14 | SA13 | 0 | 0 | 0 |
|---|---|------|------|------|---|---|---|

**SCROLL "B" PATTERN NAME TABLE BASE ADDRESS**

REG. #4:

| 0 | 0 | 0 | 0 | 0 | SB15 | SB14 | SB13 |
|---|---|---|---|---|------|------|------|

**MODE SET REGISTER No. 3**

REG. #11:

| 0 | 0 | 0 | 0 | IE2 | VSCR | HSCR | LSCR |
|---|---|---|---|-----|------|------|------|

**MODE SET REGISTER No. 4**

REG. #12:

| RS0 | 0 | 0 | 0 | S/TE | LSM1 | LSM0 | RS1 |
|-----|---|---|---|------|------|------|-----|

**H SCROLL DATA TABLE BASE ADDRESS**

REG. #13:

| 0 | 0 | HS15 | HS14 | HS13 | HS12 | HS11 | HS10 |
|---|---|------|------|------|------|------|------|

**SCROLL SIZE**

REG. #16:

| 0 | 0 | VSZ1 | VSZ0 | 0 | 0 | HSZ1 | HSZ0 |
|---|---|------|------|---|---|------|------|

**VRAM allocations:**

| Area | Max Size |
|------|----------|
| SCROLL "A" PATTERN NAME TABLE | Max 8KByte |
| SCROLL "B" PATTERN NAME TABLE | Max 8KByte |
| H SCROLL DATA TABLE | Max 960 Byte |

**VSRAM:**

| Area | Max Size |
|------|----------|
| V SCROLL DATA TABLE | Max 80 Byte |

---

### SCROLLING SCREEN SIZE

The screen size can be set by VSZ1, VSZ0, HSZ1, and HSZ0 (REG. #16). The following 6 kinds can be set both for SCROLL SCREEN A and B.

32\*32 / 32\*64 / 32\*128
64\*32 / 64\*64
128\*32

| VSZ1 | VSZ0 | FUNCTION |
|------|------|----------|
| 0 | 0 | V 32 CELL |
| 0 | 1 | V 64 CELL |
| 1 | 0 | PROHIBITED |
| 1 | 1 | V 128 CELL |

| HSZ1 | HSZ0 | FUNCTION |
|------|------|----------|
| 0 | 0 | H 32 CELL |
| 0 | 1 | H 64 CELL |
| 1 | 0 | PROHIBITED |
| 1 | 1 | H 128 CELL |

SCROLL SCREEN's PATTERN NAME TABLE ADDRESS exists in the VRAM and is designated by REGISTER #2 and #4. Depending VRAM and SCROLL screen correspond to each other differently.

### EXAMPLE

**REG. #16 = 00H : 32 * 32 CELL**

```
        0    1              30   31
   0  0000 0002  32 CELL  003C 003E
   1  0040 0042            007C 007E
       ...
      32 CELL
       ...
  30  0780 0782            07BC 07BE
  31  07C0 07C2            07FC 07FE
```

**REG. #16 = 11H : 64 * 64 CELL**

```
        0    1              62   63
   0  0000 0002  64 CELL  007C 007E
   1  0080 0082            00FC 00FE
       ...
      64 CELL
       ...
  62  1F00 1F02            1F7C 1F7E
  63  1FC0 1FC2            1FFC 1FFE
```

**REG. #16 = 03H : 32 * 128 CELL**

```
        0    1             126  127
   0  0000 0002 128 CELL  00FC 00FE
   1  0100 0102            01FC 01FE
       ...
      32 CELL
       ...
  30  1E00 1E02            1EFC 1EFE
  31  1F00 1F02            1FFC 1FFE
```

A value shown in a frame indicates an offset from the PATTERN NAME TABLE BASE ADDRESS.

---

### HORIZONTAL SCROLLING

The DISPLAY SCREEN allows for scrolling overall, or based on one cell unit, or on an dot by dot basis in one line unit. Either one of the above scrolling can be selected by HSCR and LSCR (REGISTER#11). A setting applies to both SCROLL screen A and B.

| HSCR | LSCR | FUNCTION |
|------|------|----------|
| 0 | 0 | OVERALL SCROLLING |
| 0 | 1 | PROHIBITED |
| 1 | 0 | SCROLL IN ONE CELL UNIT |
| 1 | 1 | SCROLL IN ONE LINE UNIT |

HSCR, LSCR: REG. #11

The effective scroll quantity is equivalent to 10 bits (000H-3FFH).

Taking the DISPLAY SCREEN as standard, the SCROLL direction will be as follows:

```
    -------- DISPLAY SCREEN --------
              MOVING
    <--     DIRECTION     -->

         -   SCROLL    +
              QUANTITY
```

### H Scroll Data Table

Horizontally scrolling quantity setting area: H Scroll DATA TABLE is in VRAM. From the base address which was set by REG.#13, set the scrolling quantity of SCREEN A and B alternately. Also the scrolling quantity data setting position varies depending on the following mode (OVERALL, 1 CELL, or 1 LINE).

| MODE | SETTING POSITION |
|------|-----------------|
| OVERALL | LINE 0 |
| 1 CELL | EVERY 8th LINE STARTING FROM LINE 0 |
| 1 LINE | ALL LINES |

H Scroll Data Table layout (bits 15-0):

| Offset | Content | Applicable Modes |
|--------|---------|-----------------|
| 00 | A: SCROLLING QUANTITY OF SCREEN A | OVERALL, CELL, LINE |
| 02 | B: SCROLLING QUANTITY OF SCREEN B | OVERALL, CELL, LINE |
| 04 | A: SCROLLING QUANTITY OF SCREEN A | LINE |
| 06 | B: SCROLLING QUANTITY OF SCREEN B | LINE |
| 08 | A: SCROLLING QUANTITY OF SCREEN A | LINE |
| 0A | B: SCROLLING QUANTITY OF SCREEN B | LINE |
| ... | ... | ... |
| 1C | A: SCROLLING QUANTITY OF SCREEN A | LINE |
| 1E | B: SCROLLING QUANTITY OF SCREEN B | LINE |
| 20 | A: SCROLLING QUANTITY OF SCREEN A | CELL, LINE |
| 22 | B: SCROLLING QUANTITY OF SCREEN B | CELL, LINE |
| ... | ... | ... |
| 3FC | A: SCROLLING QUANTITY OF SCREEN A | LINE |
| 3FE | B: SCROLLING QUANTITY OF SCREEN B | LINE |

D15 - D10 can be greatly utilized for program software.

---

### V SCROLL

The DISPLAY SCREEN allows for scrolling overall or every 2 Cells in a dot unit. The setting can be done by VSCR (REG.#11). A setting applies to both SCROLL SCREEN A and B.

| VSCR | FUNCTION |
|------|----------|
| 0 | OVERALL SCROLL |
| 1 | 2-CELL UNIT SCROLL |

VSCR: REG #11

The scrolling quantity is equivalent to 11 bits (000H--7FFH). However, it will be as shown below in the INTERLACE MODE.

- **NON INTERLACE:** The effective scrolling quantity is equivalent to 10 bits.
- **INTERLACE 1:** -ditto-
- **INTERLACE 2:** The effective scrolling quantity is equivalent to 11 bits.

Taking the DISPLAY SCREEN as standard, the scrolling direction will be as follows:

```
    -------- DISPLAY SCREEN --------
         ^          +
       MOVING     SCROLL
      DIRECTION  QUANTITY
         v          -
```

### V Scroll Data Table (VSRAM)

Set the V SCROLL quantity by VSRAM. Alternately set the Scroll quantity of SCREEN A and B.

Depending on the SCROLL MODE, the DATA setting positions differ.

| MODE | SETTING POSITION |
|------|-----------------|
| OVERALL | ONLY AT THE BEGINNING |
| 2-CELL SEGMENT | TO ALL |

V Scroll Data Table layout (bits 15-0):

| Offset | Content | Applicable Cells |
|--------|---------|-----------------|
| 00 | A: SCROLL QUANTITY OF SCREEN A | 0,1 CELL, OVERALL |
| 02 | B: SCROLL QUANTITY OF SCREEN B | 0,1 CELL, OVERALL |
| 04 | A: SCROLL QUANTITY OF SCREEN A | 2,3 CELL |
| 06 | B: SCROLL QUANTITY OF SCREEN B | 2,3 CELL |
| 08 | A: SCROLL QUANTITY OF SCREEN A | 4,5 CELL |
| 0A | B: SCROLL QUANTITY OF SCREEN B | 4,5 CELL |
| 0C | A: SCROLL QUANTITY OF SCREEN A | 6,7 CELL |
| 0E | B: SCROLL QUANTITY OF SCREEN B | 6,7 CELL |
| ... | ... | ... |
| 4C | A: SCROLL QUANTITY OF SCREEN A | 38,39 CELL |
| 4E | B: SCROLL QUANTITY OF SCREEN B | 38,39 CELL |

D15 - D11 is indefinite.

---

### SCROLL PATTERN NAME

The SCROLL SCREEN's name table is in VRAM and set by REG. #2 and #4. The PATTERN NAME requires 2 bytes (1 word) per CELL the SCROLL screen. Depending on the SCROLL screen's size, VRAM and SCROLL SCREEN correspond with each other differently. Refer to SCROLL SCREEN SIZE.

**PATTERN NAME** (word format):

| Bit | D15 | D14 | D13 | D12 | D11 | D10 | D9 | D8 |
|-----|-----|-----|-----|-----|-----|-----|----|----|
| Field | pri | cp1 | cp0 | vf | hf | pt10 | pt9 | pt8 |

| Bit | D7 | D6 | D5 | D4 | D3 | D2 | D1 | D0 |
|-----|----|----|----|----|----|----|----|----|
| Field | pt7 | pt6 | pt5 | pt4 | pt3 | pt2 | pt1 | pt0 |

- **pri** : Refer to PRIORITY
- **cp1** : Color palette selection bit (See COLOR PALETTE)
- **cp0** : -ditto-
- **vf** : V REVERSE bit (1: REVERSE)
- **hf** : H REVERSE bit (1: REVERSE)
- **pt10 - pt0** : PATTERN GENERATOR NUMBER

**REVERSE BIT vf and hf:** Allows for H and V reverse on CELL unit basis.

The four combinations of vf and hf produce the following orientations:

- `vf = 0, hf = 0` : Normal (no flip)
- `vf = 1, hf = 0` : Vertical flip
- `vf = 0, hf = 1` : Horizontal flip
- `vf = 1, hf = 1` : Both vertical and horizontal flip

---

### PATTERN GENERATOR

PATTERN GENERATOR has VRAM 0000H as base address, and a pattern is expressed on a 8x8 dot basis. To define a pattern, 32 bytes are required. Starting from 0000H, it proceeds in the sequence of PATTERN GENERATOR 0, 1, 2, ... The relationship between the display pattern and memory is as follows:

8x8 dot pattern layout (rows a-h, columns 1-8):

```
    1 2 3 4 5 6 7 8
a   . . . . . . . .
b   . . . . . . . .
c   . . . . . . . .
d   . . . . . . . .
e   . . . . . . . .
f   . . . . . . . .
g   . . . . . . . .
h   . . . . . . . .
```

Memory layout (4 bytes per row):

| Offset | Byte 0 (D7-D0) | Byte 1 (D7-D0) | Byte 2 (D7-D0) | Byte 3 (D7-D0) |
|--------|-----------------|-----------------|-----------------|-----------------|
| 00 | a1, a2 | a3, a4 | a5, a6 | a7, a8 |
| 04 | b1, b2 | b3, b4 | b5, b6 | b7, b8 |
| 08 | c1, c2 | c3, c4 | c5, c6 | c7, c8 |
| 0C | d1, d2 | d3, d4 | d5, d6 | d7, d8 |
| 10 | e1, e2 | e3, e4 | e5, e6 | e7, e8 |
| 14 | f1, f2 | f3, f4 | f5, f6 | f7, f8 |
| 18 | g1, g2 | g3, g4 | g5, g6 | g7, g8 |
| 1C | h1, h2 | h3, h4 | h5, h6 | h7, h8 |

The display colors and memory relationship is as follows:

| D7 | D6 | D5 | D4 | D3 | D2 | D1 | D0 |
|----|----|----|----|----|----|----|----|
| COL3 | COL2 | COL1 | COL0 | COL3 | COL2 | COL1 | COL0 |

Each pixel uses 4 bits (COL3-COL0), so each byte contains 2 pixels.

### Interlace Mode 2 Pattern Generator

In INTERLACE MODE 2, one cell consists of 8x16 dots and therefore, 64 Bytes (16 long words) are required.

8x16 dot pattern layout (rows a-p, columns 1-8):

Memory layout (4 bytes per row, 64 bytes total):

| Offset | Byte 0 | Byte 1 | Byte 2 | Byte 3 |
|--------|--------|--------|--------|--------|
| 00 | a1, a2 | a3, a4 | a5, a6 | a7, a8 |
| 04 | b1, b2 | b3, b4 | b5, b6 | b7, b8 |
| 08 | c1, c2 | c3, c4 | c5, c6 | c7, c8 |
| 0C | d1, d2 | d3, d4 | d5, d6 | d7, d8 |
| 10 | e1, e2 | e3, e4 | e5, e6 | e7, e8 |
| 14 | f1, f2 | f3, f4 | f5, f6 | f7, f8 |
| 18 | g1, g2 | g3, g4 | g5, g6 | g7, g8 |
| 1C | h1, h2 | h3, h4 | h5, h6 | h7, h8 |
| 20 | i1, i2 | i3, i4 | i5, i6 | i7, i8 |
| 24 | j1, j2 | j3, j4 | j5, j6 | j7, j8 |
| 28 | k1, k2 | k3, k4 | k5, k6 | k7, k8 |
| 2C | l1, l2 | l3, l4 | l5, l6 | l7, l8 |
| 30 | m1, m2 | m3, m4 | m5, m6 | m7, m8 |
| 34 | n1, n2 | n3, n4 | n5, n6 | n7, n8 |
| 38 | o1, o2 | o3, o4 | o5, o6 | o7, o8 |
| 40 | p1, p2 | p3, p4 | p5, p6 | p7, p8 |

---

## S WINDOW

For WINDOW display, the following register setting and VRAM areas are required.

**WINDOW PATTERN NAME TABLE AND BASE ADDRESS**

REG. #3:

| 0 | 0 | WD15 | WD14 | WD13 | WD12 | WD11 | 0 |
|---|---|------|------|------|------|------|---|

**MODE SET REGISTER No. 4**

REG. #12:

| RS0 | 0 | 0 | 0 | S/TE | LSM1 | LSM0 | RS1 |
|-----|---|---|---|------|------|------|-----|

**WINDOW H POSITION**

REG. #17:

| RIGT | 0 | 0 | WHP5 | WHP4 | WHP3 | WHP2 | WHP1 |
|------|---|---|------|------|------|------|------|

**WINDOW V POSITION**

REG. #18:

| DOWN | 0 | 0 | WVP4 | WVP3 | WVP2 | WVP1 | WVP0 |
|------|---|---|------|------|------|------|------|

**VRAM: WINDOW PATTERN NAME TABLE MAX 4K BYTES**

---

### DISPLAY POSITION

The WINDOW DISPLAY POSITION is designated by REG #17 and #18.

Screen display can be divided on a unit basis of H 2 cells and V 1 cell. The dividing position varies depending on resolution.

```
    H 40 CELLS / V 28 CELLS MODE

    0  1  2  3  4  5  ...  34 35 36 37 38 39
0  [  ][  ][  ][  ][  ][  ]...[  ][  ][  ][  ][  ][  ]
1  [  ][  ][  ][  ][  ][  ]...[  ][  ][  ][  ][  ][  ]
2  [  ][  ][  ][  ][  ][  ]...[  ][  ][  ][  ][  ][  ]
...
25 [  ][  ][  ][  ][  ][  ]...[  ][  ][  ][  ][  ][  ]
26 [  ][  ][  ][  ][  ][  ]...[  ][  ][  ][  ][  ][  ]
27 [  ][  ][  ][  ][  ][  ]...[  ][  ][  ][  ][  ][  ]
```

REG. #17:

| RIGT | 0 | 0 | WHP5 | WHP4 | WHP3 | WHP2 | WHP1 |
|------|---|---|------|------|------|------|------|

REG. #18:

| DOWN | 0 | 0 | WVP4 | WVP3 | WVP2 | WVP1 | WVP0 |
|------|---|---|------|------|------|------|------|

- **RIGT:** 0 = Displays WINDOW from the left end to H dividing position. 1 = Displays WINDOW from the H dividing position to the right end.
- **DOWN:** 0 = Displays WINDOW from the top end to the V dividing position. 1 = Displays WINDOW from the V dividing position to the bottom end.
- **WHP5 - WHP1** : H dividing position
- **WVP4 - WVP0** : V dividing position

| H RESOLUTION | DIVIDING POSITION (WHP) | V RESOLUTION | DIVIDING POSITION (WVP) |
|-------------|------------------------|-------------|------------------------|
| 32 CELL | 0 - 16 (0 - 32 CELL) | 28 CELL | 0 - 28 |
| 40 CELL | 0 - 20 (0 - 40 CELL) | 30 CELL | 0 - 30 |

---

### SETTING EXAMPLE

**Example 1:**

REG. #17 : 00H + 01H = WINDOW from the left end to the second cell
REG. #18 : 00H + 10H = WINDOW from the top end to the 16th cell

```
    0  1  2  3  4  ...  39
0  [      WINDOW        ]
   ...
15 [      WINDOW        ]
16 [                     ]
   [    SCROLL A         ]
27 [                     ]
   DISPLAY SCREEN: 40 X 28 CELL MODE
```

**Example 2:**

REG. #17 : 80H + 02H = WINDOW from the left end 4th cell to the right end
REG. #18 : 80H + 01H = WINDOW from the 2nd cell to the bottom end

```
    0  1  2  3  4  ...  39
0  [SCROLL A ]
1  [    ][                ]
   [    ][    WINDOW      ]
   ...
27 [    ][    WINDOW      ]
   DISPLAY SCREEN: 40 X 28 CELL MODE
```

**Example 3:**

REG. #17 : 80H + 01H = WINDOW from the 4th cell to the right end
REG. #18 : 00H + 10H = WINDOW from the top end to the 16th cell

```
    0  1  2  3  4  ...  39
0  [                     ]
   [     WINDOW          ]
   ...
15 [     WINDOW          ]
16 [SCROLL][              ]
   [  A   ][              ]
27 [      ][              ]
   DISPLAY SCREEN: 40 X 28 CELL MODE
```

**Example 4:**

REG. #17 : 00H + 02H = WINDOW to the 4th cell from the left
REG. #18 : 80H + 01H = WINDOW from the 2nd cell to the bottom end

```
    0  1  2  3  4  ...  39
0  [         SCROLL A    ]
1  [                     ]
   [     WINDOW          ]
   ...
27 [     WINDOW          ]
   DISPLAY SCREEN: 40 X 28 CELL MODE
```

---

### WINDOW PRIORITY

WINDOW PRIORITY is handled in the same way as in SCROLL A. SCROLL A is not displayed in the area where WINDOW is displayed. Also, only when WINDOW is set to the left and SCROLL A is moved in H direction, the character corresponding to 2 cells on the right side of the boundary between WINDOW and SCROLL A will be disfigured. There will be no malfunctioning when the WINDOW is set to the left side and SCROLL A is moved only in V direction, and also when WINDOW is set to the right side.

**Note:** Display of the boundary section will be disfigured, therefore mask SCROLL A by using high priority.

---

### WINDOW PATTERN NAME

WINDOW PATTERN NAME TABLE is on VRAM, and the BASE ADDRESS is designated by REG. #3. The PATTERN NAME, the same as in SCROLL SCREEN, requires 2 bytes (1 Word) per cell.

**PATTERN NAME** (word format):

| Bit | D15 | D14 | D13 | D12 | D11 | D10 | D9 | D8 |
|-----|-----|-----|-----|-----|-----|-----|----|----|
| Field | pri | cp1 | cp0 | vf | hf | pt10 | pt9 | pt8 |

| Bit | D7 | D6 | D5 | D4 | D3 | D2 | D1 | D0 |
|-----|----|----|----|----|----|----|----|----|
| Field | pt7 | pt6 | pt5 | pt4 | pt3 | pt2 | pt1 | pt0 |

- **pri** : Refer to PRIORITY
- **cp1** : Color palette selection bit (See COLOR PALETTE)
- **cp0** : -ditto-
- **vf** : V REVERSE bit (1: REVERSE)
- **hf** : H REVERSE bit (1: REVERSE)
- **pt10 - pt0** : PATTERN GENERATOR NUMBER

PATTERN NAME and VRAM relation varies depending on H 32 cell/40 cell mode. Pay careful attention to this point.

**H 32 CELL MODE:**

```
        0    1              30   31
   0  0000 0002  32 CELL  003C 003E
   1  0040 0042            007C 007E
       ...
      32 CELL
       ...
  30  0780 0782            07BC 07BE
  31  07C0 07C2            07FC 07FE
```

**H 40 CELL MODE** (40 -> 63 are not displayed):

```
        0    1         39   40         62   63
   0  0000 0002      004E 0050       007C 007E
   1  0080 0082      00DC 00E0       00FC 00FE
       ...
      32 CELL
       ...
  30  0F00 0F02      0F4E 0F50       0F7C 0F7E
  31  0FC0 0FC2      0FDE 0FE0       0FFC 0FFE
```

Values shown are offset from the BASE ADDRESS.

In the H 40 cell mode, there exists the area for H 64 cells. However, there will be no display from the 41st cell in the H direction.

Also in the V 28 cell mode, there will be no display from V 29th cell and in the 30th cell mode, there will be no display from 31st cell.

---

## S 11 PRIORITY

PRIORITY between SPRITE, SCROLL A and SCROLL B can be designated.

PRIORITY can be designated by each PATTERN NAME and ATTRIBUTE PRIORITY bit. It will be set for the SCROLL SCREEN on a cell unit basis and for each SPRITE. By combining each priority bit, PRIORITY will be as follows: However, the BACKGROUND PRIORITY is always the lowest.

| S pri | A pri | B pri | PRIORITY |
|-------|-------|-------|----------|
| 0 | 0 | 0 | S>A>B>G |
| 1 | 0 | 0 | S>A>B>G |
| 0 | 1 | 0 | A>S>B>G |
| 1 | 1 | 0 | S>A>B>G |
| 0 | 0 | 1 | B>S>A>G |
| 1 | 0 | 1 | S>B>A>G |
| 0 | 1 | 1 | A>B>S>G |
| 1 | 1 | 1 | S>A>B>G |

- S : SPRITE
- A : SCROLL A
- B : SCROLL B
- G : BACKGROUND

Also, by combining S/TEN (REG. #12) and the above priority, SHADOW - HIGHLIGHT effect function can be utilized.

---

### Priority Diagrams (S/TEN = 0)

When SPRITE is not related to PRIORITY, the following PRIORITY applies.

**S/TEN = 0:**

The priority order from front to back for each combination of A and B priority bits:

- A=0, B=0: S > A > B > G (front to back)
- A=0, B=1: B > S > A > G
- A=1, B=0: A > S > B > G
- A=1, B=1: A > B > S > G

**S/TEN = 1 (with shadow/highlight):**

The above shows PRIORITY situation of SPRITE, SCROLL A, SCROLL B and BACKGROUND. The dot to which COLOR CODE 0 is designated is transparent, therefore, either one of SCROLL SCREEN A, B, or BACKGROUND, the priority of which is one step lower than the transparent one, will appear.

---

### Shadow/Highlight Effect

**S/TEN = 1, SPRITE COLOR PALETTE 3, COLOR CODE 14:**

When S/TEN=1 and using sprite color palette 3, color code 14, the sprite dots act as a HIGHLIGHT operator on the screen for elements with lower priority than the SPRITE.

The priority combinations with highlight status (S=0/1, A=0/1, B=0/1) produce different layering with highlighted elements shown brighter.

Since SPRITE dots work as an operator, this will not be displayed.

**S/TEN = 1, SPRITE COLOR PALETTE 0-3, COLOR CODE 0-15 / COLOR PALETTE 3, COLOR CODE 0-13:**

Normal sprite priority with shadow effect. Where S/TEN=1, when the PRIORITY bit of both SCROLL A and SCROLL B is 0, there will be SHADOW. For the color status, refer to the color palette.

**S/TEN = 1, SPRITE COLOR PALETTE 3, COLOR CODE 15:**

The dots of SPRITE COLOR code 15 work as a SHADOW operator on the screen for elements with lower priority than the SPRITE.

Since SPRITE dots work as an operator, this will not be displayed.

---

### Sprite Link Data Setting Example

| LI | NK DATA |
|---|---------|
| SPRITE 0 | 2 |
| SPRITE 1 | 10 |
| SPRITE 2 | 1 |
| SPRITE 3 | 4 |
| SPRITE 4 | 5 |
| SPRITE 5 | 15 |
| SPRITE 6 | ---- |
| SPRITE 7 | 0 |
| SPRITE 8 | ---- |
| SPRITE 9 | ---- |
| SPRITE 10 | 11 |
| SPRITE 11 | 13 |
| SPRITE 12 | ---- |
| SPRITE 13 | 3 |
| SPRITE 14 | ---- |
| SPRITE 15 | 7 |
| SPRITE 16 | ---- |

**Display Priority (front to back):**

SPRITE 0 -> SPRITE 2 -> SPRITE 1 -> SPRITE 10 -> SPRITE 11 -> SPRITE 13 -> SPRITE 3 -> SPRITE 4 -> SPRITE 5 -> SPRITE 15 -> SPRITE 7

The 11 SPRITEs shown in the DISPLAY PRIORITY are displayed on the screen. SPRITE No. 6, 8, 9, 12, 14, and 16 onward are not displayed because they are not linked with LINK DATA LIST.

---

### SPRITE PATTERN GENERATOR

The SPRITE PATTERN GENERATOR with VRAM 0000H as BASE ADDRESS, expresses one pattern on a basis of 8x8 dots. 32 bytes are required to define one pattern. Every 32 bytes, one pattern is expressed in the sequence of PATTERN GENERATOR 0, 1, 2... The relationship of DISPLAY PATTERN and MEMORY is the same as in PATTERN GENERATOR. Also, SPRITE SIZE and PATTERN GENERATOR relationship is as follows:

**V 1 cell, H 1 cell:**

```
[0]
```

**V 1 cell, H 2 cell:**

```
[0][1]
```

**V 1 cell, H 3 cell:**

```
[0][1][2]
```

**V 2 cell, H 1 cell:**

```
[0]
[1]
```

**V 2 cell, H 2 cell:**

```
[0][2]
[1][3]
```

**V 2 cell, H 3 cell:**

```
[0][2][4]
[1][3][5]
```

**V 3 cell, H 1 cell:**

```
[0]
[1]
[2]
```

**V 3 cell, H 2 cell:**

```
[0][3]
[1][4]
[2][5]
```

**V 3 cell, H 3 cell:**

```
[0][3][6]
[1][4][7]
[2][5][8]
```

**V 4 cell, H 1 cell:**

```
[0]
[1]
[2]
[3]
```

**V 4 cell, H 2 cell:**

```
[0][4]
[1][5]
[2][6]
[3][7]
```

**V 4 cell, H 3 cell:**

```
[0][4][8]
[1][5][9]
[2][6][A]
[3][7][B]
```

---

## S INTERLACE MODE

RASTER SCAN MODE can be changed by setting LSM0 and LSM1 (REG. #12).

| LSM1 | LSM0 | RASTER SCAN MODE |
|------|------|-----------------|
| 0 | 0 | NON INTERLACE MODE |
| 0 | 1 | INTERLACE 1: In the NON-INTERLACE mode, the same PATTERN is displayed on the rasters of even and odd numbered fields. |
| 1 | 1 | INTERLACE 2: In the INTERLACE mode, the different PATTERN is displayed on the rasters of even and odd numbered fields. |

In the INTERLACE MODE and INTERLACE 1, one cell is defined by 8x8 dots and in INTERLACE 2, 8x16 dots. For DISPLAY, one cell consists of 8x8 dots in the NON INTERLACE MODE and in the INTERLACE MODE 8x16 dots.

In any case, number of cells in one screen are the same.

Depending on the type of DISPLAY, in the case of INTERLACE DISPLAY, there may occur a serious blur in the vertical direction. Therefore, when using the DISPLAY pay careful attention in this regard.

The interlace modes display fields alternately:
- **NON-INTERLACE**: Each field displays the same pattern on all raster lines
- **INTERLACE 1**: Same pattern displayed on both even and odd fields (Field No. 1 and Field No. 2)
- **INTERLACE 2**: Different patterns displayed on even and odd fields (Field No. 1 and Field No. 2)

---

## 3. BACKWARD COMPATIBILITY MODE

In the case of BACKWARD COMPATIBILITY MODE, the MEGA DRIVE differs from the original Mark III & MASTER SYSTEM in the following points:

### MARK III (MS-JAPAN)

**OS-ROM is not incorporated.**

ROM CARTRIDGE/CARD selections are made by hardware in the same manner as in the case of MARK III. START UP SLOT number is not written in 0C000H. START UP Sega logo is not displayed.

**FM sound source is not incorporated.**

FM sound is incorporated in MS-JAPAN (standard) and MARK III (optional) (OPLL). However, MEGA DRIVE has no option for that, although connection is possible. Consider the MEGA DRIVE's Japanese Specifications as that of MARK III with MS-JAPAN's JOYSTICK Port, or as MS-JAPAN without FM sound source and OS-ROM.

### MASTER SYSTEM

**OS-ROM is not incorporated.**

0C000H-0DFFFH RAM is not clear on POWER-UP. RAM 0C000 has no meaningful value. START UP Sega logo not displayed.

**FM sound source is not incorporated.**

FM sound source is incorporated in MS by option (OPLL). However, MEGA DRIVE has no option, although connection is possible.

Please regard the MEGA DRIVE overseas version as a MASTER SYSTEM without an Operating System ROM.

### RAM BOARD

In the MEGA DRIVE's MARK III & MASTER SYSTEM BACKWARD COMPATIBILITY MODE, the RAM BOARD for development (for which D-RAM was used) can not be used due to the problem of REFRESH. The other BOARDs for development (which utilizes S-RAM) can be used without any problem.

---

## 4. SYSTEM I/O

MEGA DRIVE SYSTEM I/O area assignment starts from $A00000, with the Z80 SUB-CPU's memory area.

### S 1 VERSION NO.

Indicates the Mega Drive's hardware version.

**$A10001:**

| MODE | VMOD | DISK | RSV | VER3 | VER2 | VER1 | VER0 |
|------|------|------|-----|------|------|------|------|

- **MODE** (R): 0 = Domestic Model, 1 = Overseas Model
- **VMOD** (R): 0 = NTSC CPU clock 7.67 MHz, 1 = PAL CPU clock 7.60 MHz
- **DISK** (R): 0 = FDD unit connected, 1 = FDD unit not connected
- **RSV** (R): Currently not used
- **VER3-0** (R): MEGA DRIVE version is indicated by $0-$F. The present hardware version is indicated by $0.

### S 2 I/O PORT

The MEGA DRIVE has the three general purpose I/O ports, CTRL1, CTRL2 and EXP. Although each port differs from the others in physical shape it functions in the same manner. Each port has the following S REGISTERs for CONTROL.

| Register | Function | Access |
|----------|----------|--------|
| DATA | PARALLEL DATA | R/W |
| CTRL | PARALLEL CONTROL | R/W |
| S-CTRL | SERIAL CONTROL | R/W |
| TxDATA | Txd DATA | R/W |
| RxDATA | Rxd DATA | R |

### I/O Port Register Architecture

The relationship between REGISTERs is as follows:

```
DATA D0 --[I/O]-- UP
     D1 --[I/O]-- DOWN
     D2 --[I/O]-- LEFT
     D3 --[I/O]-- RIGHT
     D4 --[I/O]--[P/S]-- TL
     D5 --[I/O]--[P/S]-- TR
     D6 --[I/O]-- TH

CTRL -------
HL TERMINAL --[INT]--

S-CTRL -------
RxDATA --[S>P]--    JS CON
TxDATA --[P>S]--    (CTRL 1)
                    (CTRL 2)
                    (EXP   )
```

- I/O : I/O change
- P/S : PARALLEL/SERIAL MODE change
- INT : INTERRUPT CONTROL
- S>P : SERIAL-PARALLEL CONVERSION
- P>S : PARALLEL-SERIAL CONVERSION

### I/O Port Address Mapping

```
$A10003 : DATA 1 ( CTRL1 )
$A10005 : DATA 2 ( CTRL2 )
$A10007 : DATA 3 ( EXP   )
$A10009 : CTRL 1
$A1000B : CTRL 2
$A1000D : CTRL 3
$A1000F : TxDATA 1
$A10011 : RxDATA 1
$A10013 : S-CTRL 1
$A10015 : TxDATA 2
$A10017 : RxDATA 2
$A10019 : S-CTRL 2
$A1001B : TxDATA 3
$A1001D : RxDATA 3
$A1001F : S-CTRL 3
```

Both BYTE and WORD access are possible. However, in the case of WORD access, only the lower byte is meaningful.

### DATA Register

DATA shows the status of each port. The I/O direction of each bit is set by CTRL and S-CTRL.

| PD7 | PD6 | PD5 | PD4 | PD3 | PD2 | PD1 | PD0 |
|-----|-----|-----|-----|-----|-----|-----|-----|

- PD7 (RW)
- PD6 (RW) TH
- PD5 (RW) TR
- PD4 (RW) TL
- PD3 (RW) RIGHT
- PD2 (RW) LEFT
- PD1 (RW) DOWN
- PD0 (RW) UP

### CTRL Register

CTRL designates the I/O direction of each port and the INTERRUPT CONTROL of TH.

| INT | PC6 | PC5 | PC4 | PC3 | PC2 | PC1 | PC0 |
|-----|-----|-----|-----|-----|-----|-----|-----|

- **INT** (RW): 0 = TH-INT PROHIBITED, 1 = TH-INT ALLOWED
- **PC6** (RW): 0 = PD6 INPUT MODE, 1 = OUTPUT MODE
- **PC5** (RW): 0 = PD5 INPUT MODE, 1 = OUTPUT MODE
- **PC4** (RW): 0 = PD4 INPUT MODE, 1 = OUTPUT MODE
- **PC3** (RW): 0 = PD3 INPUT MODE, 1 = OUTPUT MODE
- **PC2** (RW): 0 = PD2 INPUT MODE, 1 = OUTPUT MODE
- **PC1** (RW): 0 = PD1 INPUT MODE, 1 = OUTPUT MODE
- **PC0** (RW): 0 = PD0 INPUT MODE, 1 = OUTPUT MODE

### S-CTRL Register

S-CTRL is for the status, etc. of each port's mode change, baud rate and SERIAL.

| BPS1 | BPS0 | SIN | SOUT | RINT | RERR | RRDY | TFUL |
|------|------|-----|------|------|------|------|------|

- **SIN** (RW): 0 = TR-PARALLEL MODE, 1 = SERIAL IN
- **SOUT** (RW): 0 = TL-PARALLEL MODE, 1 = SERIAL OUT
- **RINT** (RW): 0 = Rxd READY INTERRUPT PROHIBITED, 1 = Rxd READY INTERRUPT ALLOWED
- **RERR** (R): 0 = OK, 1 = Rxd ERROR
- **RRDY** (R): 0 = Not ready, 1 = Rxd READY
- **TFUL** (R): 0 = Not full, 1 = Txd FULL

**Baud Rate Settings:**

| BPS1 | BPS0 | bps |
|------|------|-----|
| 0 | 0 | 4800 |
| 0 | 1 | 2400 |
| 1 | 0 | 1200 |
| 1 | 1 | 300 |

---

### MEMORY MODE

The MEGA DRIVE is able to generate internally the REFRESH signal for the D-RAM development cartridge. When using the development cartridge set to D-RAM MODE. In the case of a production cartridge, set to ROM MODE.

Only D8 of address $A11000 is effective and for WRITE ONLY.

```
$A11000    D8 ( W )  0: ROM MODE
                     1: D-RAM MODE
```

ACCESS to $A11000 can be based on BYTE.

### S 4 Z80 CONTROL

### Z80 BUSREQ

When accessing the Z80 memory from the 68000, first stop the Z80 by using BUSREQ. At the time of POWER ON RESET, the 68000 has access to the Z80 bus.

```
$A11100    D8 ( W )  0: BUSREQ CANCEL
                     1: BUSREQ REQUEST
           ( R )     0: CPU FUNCTION STOP ACCESSIBLE
                     1: FUNCTIONING
```

Access to Z80 AREA in the following manner:

1. Write $0100 in $A11100 by using a WORD access.
2. Check to see that D8 of $A11100 becomes 0.
3. Access to Z80 AREA.
4. Write $0000 in $A11100 by using a WORD access.

Access to $A11100 can also be based on BYTE.

### Z80 RESET

The 68000 may also reset the Z80. The Z80 is automatically reset during the MEGA DRIVE hardware's POWER ON RESET sequence.

```
$A11200    D8 ( W )  0: RESET REQUEST
                     1: RESET CANCEL
```

Access to $A11100 can also be based on BYTE.

---

### S5 Z80 AREA

Mapping is performed starting from $A00000 for Z80, a SUB-CPU.

As viewed from 68000, the memory map will be as follows:

| Address | Content |
|---------|---------|
| $A00000 | SOUND RAM |
| $A02000 | SEGA RESERVED / PROHIBITED |
| $A04000 | SOUND CHIP (YM 2612) |
| $A04004 | PROHIBITED |
| $A06000 | BANK REGISTER |
| $A06002 | PROHIBITED |
| $A08000 | ACCESS PROHIBITED |
| $A0FFFF | (end) |

### SOUND RAM

This is for the Z80 program. Access from 68000 by BYTE.

### SOUND CHIP

This is the mapping area for FM sound source (YM 2612). When accessing from 68000 use BYTE due to timing problem.

### BANK REGISTER

Access to the 68000 side MEMORY AREA from Z80 will be based on a 32K BYTE unit. At this time, this REGISTER sets which BANK is to be accessed. Registering from 68000 can be set, however, do not access to Z80 Bank MEMORY AREA by 68000.

### SETTING METHOD

When accessing the 68000 side addresses from Z80 side, all the addresses can be classified into BANKs. BANK can be set by writing 9 times in 0 bit of 8000 (Z80 Address). The 9 bits correspond to 68000 address 15 - 23 as shown below:

Z80 Memory Map:

| Address | Content |
|---------|---------|
| 0000 | S_RAM |
| 4000 | SOUND / OTHERS |
| 8000 | BANK 68000 |
| (end) | |

Bank address at Z80 address 6000:

| Write # | 68000 Address Bit |
|---------|-------------------|
| 1 TIME | A23 |
| 2 TIMES | A22 |
| 3 TIMES | A21 |
| 4 TIMES | A20 |
| 5 TIMES | A19 |
| 6 TIMES | A18 |
| 7 TIMES | A17 |
| 8 TIMES | A16 |
| 9 TIMES | A15 |

The Z80 accesses 68000 memory through the BANK window at Z80 address 8000-FFFF, with VDP access at 7FF0.

---

## 5. VRAM MAPPING

In VRAM, there are various TABLEs and PATTERN GENERATORs as stated below. Among those, the base address of PATTERN GENERATOR TABLE and SPRITE GENERATOR TABLE are 0000H and fixed. However, the other base addresses can be freely assigned in VRAM by setting VDP REGISTER. Also, AREA can be overlapped. Therefore, TABLE can be commonly used by SCROLL screen and WINDOW for example.

**SCROLL A PATTERN NAME TABLE** Max. 8K Byte.
Base address designated by Register #2.

**SCROLL B PATTERN NAME TABLE** Max. 8K Byte.
Base address designated by REGISTER #4.

**WINDOW PATTERN NAME TABLE** Varies by H Resolution.
Base address designated by REGISTER #3.

**H SCROLL DATA TABLE** 1K Byte.
Base address designated by REGISTER #13.

**SPRITE ATTRIBUTE TABLE** Varies by H Resolution.
Base address designated by REGISTER #5.

**PATTERN GENERATOR TABLE**
Base address is 0000H (fixed).

**SPRITE GENERATOR TABLE**
Base address is 0000H (fixed).

There are 1K Bytes for H SCROLL TABLE, however, as for display 896 Bytes in V28 cell mode and 980 bytes in V30 cell mode. There are 2K bytes for WINDOW PATTERN NAME TABLE in H32 cell mode, and 4K byte area in H 40 cell mode. For details refer to WINDOW. There are 512 bytes for SPRITE ATTRIBUTE TABLE in H32 cell and 1K byte area in H40 cell mode. However as for display, there are 640 bytes in H40 cell mode.

---

### Setting Example

#### 1. H 32 cell mode

```
SCROLL A PATTERN NAME TABLE
  8K Bytes from 0C000H  :  REG. #2 = $30
SCROLL B PATTERN NAME TABLE
  8K Bytes from 0E000H  :  REG. #4 = $07
WINDOW PATTERN NAME TABLE
  2K Bytes from 0B000H  :  REG. #3 = $2C
H SCROLL DATA TABLE
  1K Bytes from 0B800H  :  REG. #13= $2E
SPRITE ATTRIBUTE TABLE
  512 Bytes from 0BE00H :  REG. #5 = $5F
```

Unoccupied area is used as PATTERN GENERATOR and SPRITE GENERATOR.

VRAM Layout (H 32 cell mode):

```
00000H  [                    ]
        [ PATTERN GENERATOR  ]
        [ & SPRITE GENERATOR ]
        [                    ]
0B000H  [      WINDOW        ]
0B800H  [     H SCROLL       ]
0BE00H  [  SPRITE ATTRIBUTE  ]
0C000H  [                    ]
        [     SCROLL A       ]
        [                    ]
0E000H  [                    ]
        [     SCROLL B       ]
        [                    ]
```

## H40 Cell Mode

```
SCROLL A PATTERN NAME TABLE
  8K Bytes from 0C000H  :  REG. #2 = $30
SCROLL B PATTERN NAME TABLE
  8K Bytes from 0E000H  :  REG. #4 = $07
WINDOW PATTERN NAME TABLE
  4K Bytes from 0B000H  :  REG. #3 = $2C
H SCROLL DATA TABLE
  2K Bytes from 0AC00H  :  REG. #13= $2B
SPRITE ATTRIBUTE TABLE
  1K Bytes from 0A800H  :  REG. #5 = $54
```

Unoccupied area is used as PATTERN GENERATOR and SPRITE GENERATOR.

**VRAM Layout (H40 Cell Mode):**

| Address | Contents |
|---------|----------|
| 00000H | (Pattern/Sprite Generator) |
| 0AB00H | SPRITE ATTRIBUTE |
| 0AC00H | H SCROLL |
| 0B000H | WINDOW |
| 0C000H | SCROLL A |
| 0E000H | SCROLL B |

---

## Precautions for MS (Master System) Software Programming

When programming the MS software, pay attention to the following:

1. The program of DMA (RAM, ROM-VRAM, CRAM, VSRAM) should be resident in RAM, or it should be as in LIST1 for example. However, in either one on the above 2 cases, a long word access is not possible as regards the last VRAM address set.

2. ID should be as in the next page.

3. Put LIST2 at your program's start. This is the U.S. security software.

### LIST1

```asm
DMA_RAM:
        lea     vdp_cmd,An          ; vdp_cmd: $C00000
                                    ; An = ADDRESS REGISTER
        ; Set source ADDRESS to VDP REGISTER
        ; Set DATA LENGTH to VDP REGISTER
        move.l  xx,ram0             ; xx: DESTINATION ADDRESS
                                    ; ram0 :WORK RAM
        move.w  ram0,(An)
        move.w  ram0+2,(An)         ; Pay careful attention to the
                                    ; sequential order of 1st
                                    ; word and 2nd word.
        rts                         ; DESTINATION ADDRESS should be set
                                    ; by WORD and not by LONG WORD.
```

### LIST 2

```asm
        move.b  $A10001,d0          ; Get version number
        andi.b  #$0F,d0             ;
        beq.b   ?0                  ; If not version $0
        move.l  $'SEGA',$A14000     ; Output ASCII
?0:
```

---

## ROM Cartridge Data for Mega Drive

Write in ROM's 100H-1FFH.

| Offset | Contents | Field |
|--------|----------|-------|
| 100H | `'SEGA MEGA DRIVE '` | 1 |
| 110H | `'(C)SEGA 1988.JUL'` | 2 |
| 120H | GAME NAME (DOMESTIC) | 3 |
| 150H | GAME NAME (OVERSEAS) | 4 |
| 180H | `'GM XXXXXXX-XX'` | 5 |
| 18EH | $XXXX | 6 |
| 190H | CONTROL DATA | 7 |
| 1A0H | $000000, $XXXXXX | 8 |
| 1A8H | $FF0000, $FFFFFF | 9 |
| 1B0H | EXTERNAL RAM DATA | 10 |
| 1BCH | MODEM DATA | 11 |
| 1C8H | MEMO | 12 |
| 1F0H | Country in which the product can be released | 13 |

### Field Descriptions

1. SEGA system name and TITLE in common with all ROMs.
2. Copyright notice and year/month of release (Firm name in ASCII 4 character.)
3. Game name for Domestic (JIS KANJI CODE OK)
4. Game name for overseas market (JIS KANJI CODE OK)
5. Type of CARTRIDGE and Products, NO.. Version No.

| Field | Value |
|-------|-------|
| TYPE | GAME: GM, EDUCATION: Al |
| NO. | PRODUCT NO. |
| VER. | Data varies depending on the type of ROM or software version. |

6. Check sum

7. I/O use support data

| Device | Code | Device | Code |
|--------|------|--------|------|
| JOYSTICK FOR MS | 0 | TABLET | T |
| JOYSTICK | J | CONTROL BALL | B |
| KEYBOARD | K | PADDLE CONTROLLER | V |
| SERIAL (RS232C) | R | FDD | F |
| PRINTER | P | CDROM | C |

8. ROM capacity: START ADDRESS, END ADDRESS
9. RAM capacity: START ADDRESS, END ADDRESS

10. When no external RAM is mounted, fill the address by a space code and when it is mounted follow the following:

```
1 B 0 H:    dc.b    'RA',%1x1yzOOO,%00100000
             x       1 for BACKUP and 0 if not BACKUP
             y z     10 if even address only. 11 if odd address only
                     00 if both even and odd address
1 B 4 H:    dc.l    RAM start address RAM end address
```

11. If corresponding to MODEM, fill it by space code and if not, follow the following:

```
1 B C H:    dc.b    'MO','xxxx','yy.z'
             xxxx    Firm name the same as in 2
             yy      MODEM NO.
             z       Version
```

13. Data of the countries in which the product can be released.

| Region | Code |
|--------|------|
| JAPAN | J |
| USA | U |
| EUROPE | E |

Be sure to input a space code in the unoccupied 1 ~ 7, 9 ~ 13 space.

---

## How to Obtain Check Sum

The CHECK SUM obtaining program is shown as follows. The program starts with OFF8000H, RAM space. First fill game capacity by -1 (0FFH) and then load all of the programs. Next, load the CHECK SUM program and run the program from OFF8000H. After a while, stop running the program. At this time, the lower WORD of DATA REGISTER 0 (d0) is the CHECK SUM value. Note that BREAK in MEMORY should be canceled in advance. Also, when burning to ROM, first fill the game capacity by -1 (0FFH).

```asm
end_addr        equ     $1A4
                org     -$8000

start:
                move.l  (a0),d1
                addq.l  #$1,d1
                movea.l #$200,a0
                sub.l   a0,d1
                amr.l   s1,d1               ; counter
                move    d1,d2 .,
                subq.w  #$1,d2
                swap    d1
                moveq   #$0,d0
        ?l2:
                add     (a0)+,d0
                dbra    d2,?l2
                dbra    d1,?l2
                nop
                nop
                nop
                nop
                nop
                nop
        ?le:
                nop
                nop
                bra.b   ?le
```

---

## Memory Mapping for Emulation

For the 68000 EMULATION

All address should be disabled initially: 0 to 0FFFFFF

Required areas should then be enabled as follows:

1. Program and Data are in 0 to 007FFFF
2. S-RAM is for Z-80 in 0A00000 to 0A01FFF
3. FM sound chip interface is in 0A04000 to 0A04FFF
4. I/O and Z-80 control port are in 0A10000 to 0A11FFF
5. VDP and sound control port are in 0C00000 to 0C00FFF
6. Scratch RAM is in 0FF0000 to 0FFFFFF

### RAM CARD (No. 171-5642-02)

This board has two memory areas:

```
MAIN MEMORY    (D-RAM) $000000 - $0FFFFF
BACK UP MEMORY (S-RAM) $200000 - $203FFF
```

1. **INITIALIZE**
   - Write 0100H into $0A11000
   - Write 1 into $0A130F0
   - (Green LED light up)

2. **WRITE PROTECT**
   - Write 3 into $0A130F0
   - (Red LED light up)

3. **READ/WRITE**
   - Write 1 into $0A130F0
   - (Red LED turns off)

4. **NOTE** - Emulator access to these ports should be enabled before the writes, then disabled after words.

### VDP Register Settings for Emulation

| Register | Bits to set to 0 |
|----------|-----------------|
| 15 | (all available) |
| 16 | D7, D6, D3, D2 |
| 17 | D6, D5 |
| 18 | D6, D5 |
| 19-23 | (DMA registers)* |

\* DMA cannot be performed emulated ROM or RAM on most ICEs.

---

## Genesis Sound Software Manual

### Index

- **I. Z80 Mapping**
  - (1) Z80 Memory Map
  - (2) Interrupt
- **II. 68K Control of Z-80**
  - (1) Z80 Start Up
  - (2) Z80 Handshake
- **III. FM Sound Control**
  - (1) 68K Access FM Chip
  - (2) Z80 Access FM Chip
- **IV. PSG Control**
- **V. D/A Control**

This manual explains memory mapping and way of accessing especially. FM sound generation and PSG are explained another manual.

---

## I. Z80 Mapping

### (1) Z80 Map

I/O is contained in memory map.

**1) PROGRAM AREA**

Program, data and scratch are in 0 to 1FFFH, is S-RAM.

**2) BANK**

From 8000H - FFFFH is window of 68K memory. Z-80 can access all of 68K memory by BANK switching. BANK select data create 68K address from A15 to A23. You must write these 9 bits one at a time into 6000H serially, byte units, using the LSB.

**Z80 Address Map:**

| Address Range | Contents |
|---------------|----------|
| 0000 - 1FFF | S.RAM |
| 4000 - 5FFF | FM |
| 6000 - 7F11 | BANK SELECT |
| 7F11 | PSG |
| 8000 - FFFF | BANK AREA |

The 9-bit bank address (A23-A15) is written serially, LSB first, one byte at a time to address 6000H. Each write shifts in one bit from D0.

**3) I/O**

| Address | Function |
|---------|----------|
| 4000H | FM1 register select (Channel 1-3) |
| 4001H | FM1 DATA |
| 4002H | FM2 register select (Channel 4-6) |
| 4003H | FM2 DATA |

PSG address is in 7F11H.

### (2) Interrupt

Z-80 gets the only VIDEO vertical interrupt.

This interrupt is generated 16ms period and 64ms length.

---

## II. 68K Control of Z80

### (1) Z80 Start Up

Z-80 OPERATION SEQUENCE:

1. BUS REQ ON
2. BUS RESET OFF
3. 68K copies program into Z-80 S-RAM
4. BUS RESET ON
5. BUS REQ OFF
6. BUS RESET OFF

**BUS REQUEST:**

| Operation | Value | Address |
|-----------|-------|---------|
| BUS REQ ON | DATA 100H (WORD) | -> $A11100 |
| BUS REQ OFF | DATA 0H (WORD) | -> $A11100 |

**RESET Z-80:**

| Operation | Value | Address |
|-----------|-------|---------|
| RESET ON | DATA 0H (Word) | -> $A11200 |
| RESET OFF | DATA 100H (Word) | -> $A11200 |

This period requires 26ms. Also FM sound source is cleared at the same time.

**CONFIRMATION OF BUS STATUS:**

This information is in $A11100 bit 0:

- 0 - Z80 is using
- 1 - 68K can access

### (2) Z80 Handshake

If you access the Handshake area (A00000 - A07FFF) you must use BUS REQ. 68K has to access the Z-80 S-RAM by byte.

---

## III. FM Sound Control

1. **68K accesses the FM source.** 68K needs BUS REQ when accessing the FM source, because this memory is controlled by Z-80.

2. **Z80 accesses the FM source.** Z80 normally controls the FM (4000H - 4003H)

---

## IV. PSG Control

PSG accepts access of 68K and Z80 anytime, but you have to coordinate 68K and Z80 accesses. PSG is in $C00011 from 68K and in 7F11H from Z80.

---

## FM Sound (YM-2612) Overview

The Yamaha 2612 Frequency Modulation (FM) sound synthesis IC resembles the Yamaha 2151 (used in Sega's coin-op machines) and the chips used in Yamaha's synthesizers.

Its capabilities include:

- 6 channels of FM sound
- An 8-bit Digitized Audio channel (as replacement for one of the FM channels) -- Stereo output capability
- One LFO (low frequency oscillator) to distort the FM sounds
- 2 timers for use by software

To define these terms more carefully; an FM channel is capable of expressing, with a high degree of realism, a single note in almost any instrument's voice. Chords are generally created by using multiple FM channels.

The standard FM channels each have a single overall frequency and data for how to turn this frequency into the complex final wave form (the voice). This conversion process uses four dedicated channel components called 'operators', each possessing a frequency (a variant of the overall frequency), an envelope, and the capability to modulate its input using the frequency and envelope. The operator frequencies are offsets of integral multiples of the overall frequency.

There are two sets of three FM channels, named channels 1 to 3 and 4 to 6 respectively. Channels 3 and 6, the last in each set, have the capability to use a totally separate frequency for each operator rather than offsets of integral multiples. This works well (I believe) for percussion instruments, which have harmonics at odd multiples such as 1.4 or 1.7 of the fundamental.

The 8-bit Digitized Audio exists as a replacement of FM channel 6, meaning that turning on the DAC turns off FM channel 6. Unfortunately, all timing must be done by software -- meaning that unless the software has been very cleverly constructed, it is impossible to use any of the FM channels at the same time as the DAC.

Stereo output capability means that any of the sounds, FM or DAC, may be directed to the left, the right, or both outputs. The stereo is output only through the headphone jack.

The LFO, or Low Frequency Oscillator, allows for amplitude and/or frequency distortions of the FM sounds. Each channel elects the degree to which it will be distorted by the LFO, if at all. This could be used, for example, in a guitar solo.

Finally, the system has two software timers, which may be used as an alternative to the Z80 VBLANK interrupt. Unfortunately, these timers do not cause interrupts -- they must be read by the software to determine if they have finished counting.

### A Little Bit About Operators

There are four dedicated operators assigned to every channel, with the following properties:

- An operator has an input, a frequency and envelope with which to modify the input, and an output.
- The operators have two types, those whose outputs feed into another operator, and those that are summed to form the final wave form. The latter are called "slots".
- The slots may be independently enabled, though Sega's software always enables or disables them all simultaneously.
- Operator 1 may feed back into itself, resulting in a more complex wave form.

These operators may be arranged in eight different configurations, called "algorithms".

### FM Algorithms

| Algorithm | Typical Instruments |
|-----------|-------------------|
| Algorithm 0 | distortion guitar, "high hat chopper" (?) bass |
| Algorithm 1 | harp, PSG (programmable sound generator) sound |
| Algorithm 2 | bass, electric guitar, brass, piano, woods |
| Algorithm 3 | strings, folk guitar, chimes |
| Algorithm 4 | flute, bells, chorus, bass drum, snare drum, tom-tom |
| Algorithm 5 | brass, organ |
| Algorithm 6 | xylophone, tom-tom, organ, vibraphone, snare drum, base drum |
| Algorithm 7 | pipe organ |

**Algorithm Operator Configurations:**

- **#0**: 1 -> 2 -> 3 -> [4] (serial chain, slot = operator 4)
- **#1**: (1+2) -> 3 -> [4] (operators 1,2 parallel into 3, slot = operator 4)
- **#2**: (2 + (1->3)) -> [4] (operator 1 feeds 3, summed with 2 into 4)
- **#3**: ((1->2) + 3) -> [4] (operator 1 feeds 2, summed with 3 into 4)
- **#4**: (1->2) + (3->[4]) (two parallel pairs, slots = operators 2,4)
- **#5**: 1 -> ([2] + [3] + [4]) (operator 1 feeds all three slots)
- **#6**: (1->2) + [3] + [4] (one pair plus two independent slots)
- **#7**: [1] + [2] + [3] + [4] (all four operators are slots/outputs)

Slots (output operators) are indicated by shading in the original diagram.

---

### Register Overview

The system is controlled by means of a large number of registers. General system registers are:

- Timer values and status, software use
- LFO enable and frequency, to distort the FM channels
- DAC enable and amplitude
- Output enables for each of the 6 FM channels
- Number of frequencies to be used in FM channels 3 and 6. Usually, an FM channel has only one overall frequency, but if so elected, FM channels 3 and 6 use four separate frequencies, one for each operator.

The remainder of the registers apply to a single FM channel, or to an operator in that channel. Registers that refer to the channel as a whole are:

- Frequency number (in the standard case) -- algorithm number
- Extent of self-feedback in operator 1
- Output type, to L, R, or both speakers. This can only be heard if headphones are used.
- The extent to which the channel is distorted by the LFO.

Registers that refer to each operator make up the remainder. The four operator's connections are determined by the algorithm used, but the envelope is always specified individually for each operator. In the case of FM channels 3 and 6, the frequency may be specified individually for each operator.

---

### Envelope Specification

The sound starts when the key is depressed, a process called 'key on'. The sound has an attack, a strong primary decay, followed by a slow secondary decay. The sound continues this secondary decay until the key is released, a process called 'key off'. The sound then begins a rapid final decay, representing for example a piano note after the key has been released and the damper has come down on the strings.

The envelope is represented by the above amplitudes and angles, and a few supplementary registers:

| Parameter | Description |
|-----------|-------------|
| TL | Total level, the highest amplitude of the wave form |
| AR | Attack rate, the angle of initial amplitude increase. This can be made very steep if desired. The problem with slow attack rates is that if the notes are short, the release (called 'key off') occurs before the note has reached a reasonable level. |
| D1R | The angle of initial amplitude decrease |
| T1L | The amplitude at which the slower amplitude decrease starts |
| D2R | The angle of secondary amplitude decrease. This will continue indefinitely unless 'key off' occurs. |
| RR | The final angle of amplitude decrease, after 'key off'. |

Additional registers are:

| Parameter | Description |
|-----------|-------------|
| RS | Rate scaling. The degree to which envelopes become shorter as frequencies become higher. For example, high notes on a piano fade much more quickly than low notes. |
| AM | Amplitude Modulation enable, whether or not this operator will allow itself to be modified by the LFO. Changing the amplitude of the slots (those colored gray in the diagram on page 3) changes the loudness of the note; changing the amplitude of the other operators changes its flavor. |
| SSG-EG | A proprietary register whose usage is unknown. It should be set to 0. |

---

### FM-2612 Register Access

The FM-2612 may be accessed from either the 68000 or the Z80. In both cases, however, the bus is only 8 bits wide.

The FM-2612 is accessed through memory locations 4000H - 4003H in the Z80 case, or A04000H - A04003H in the 68000 case. These will be referred to as 4000 to 4003.

To write to units in Part I, write the 8-bit address to 4000 and the data to 4001. To write to PART II, write the 8-bit address to 4002 and the data to 4003.

**CAUTION:** Before writing, read from any address to determine if the YM-2612 I/O is still busy from the last write. Delay until bit 7 returns to 0.

**CAUTION:** In the case of registers that are "ganged together" to form a longer number - for example the 10-bit Timer A value or the 14-bit frequencies, write the high register first.

**READ DATA:** Reading from any of the four locations:

| D7 | D6-D3 | D1 | D0 |
|----|-------|-----|-----|
| BUSY | X X X X | OVERFLOW A | OVERFLOW B |

- BUSY - 1 if busy, 0 if ready for new data
- OVERFLOW - 1 if the timer has counted up and overflowed. See register 27H.

---

### Part I Memory Map

**System Registers (22H-2BH):**

| Register | Bit 7 | Bit 6 | Bit 5 | Bit 4 | Bit 3 | Bit 2 | Bit 1 | Bit 0 |
|----------|-------|-------|-------|-------|-------|-------|-------|-------|
| 22H | X | X | X | X | LFO EN | LFO FREQ (3 bits) |||
| 24H | TIMER A MSBs (8 bits) ||||||||
| 25H | X | X | X | X | X | X | TIMER A LSBs (2 bits) ||
| 26H | TIMER B (8 bits) ||||||||
| 27H | CH 3 MODE (2 bits) || RESET B | RESET A | ENABLE B | ENABLE A | LOAD B | LOAD A |
| 28H | OPERATOR (4 bits) |||| X || CHANNEL (2 bits) ||
| 29H | (reserved) ||||||||
| 2AH | DAC DATA (8 bits) ||||||||
| 2BH | DAC EN | X | X | X | X | X | X | X |

**Operator Registers (30H-9EH):**

| Register | Contents |
|----------|----------|
| 30H+ | X, DT1 (3 bits), MUL (4 bits) |
| 40H+ | X, TL (7 bits) |
| 50H+ | RS (2 bits), X, AR (5 bits) |
| 60H+ | AM (1 bit), X, X, D1R (5 bits) |
| 70H+ | X, X, X, D2R (5 bits) |
| 80H+ | D1L (4 bits), RR (4 bits) |
| 90H+ | X, X, X, X, SSG-EG (4 bits) |

Each of 30H - 90H has 12 entries: 3 channels x 4 operators. Channels 1-3 become channels 4-6 in PART II.

**Channel/Operator Address Layout:**

| Address | Assignment |
|---------|-----------|
| x0H | CH 1, OP 1 |
| x1H | CH 2, OP 1 |
| x2H | CH 3, OP 1 |
| x4H | CH 1, OP 2 |
| x5H | CH 2, OP 2 |
| x6H | CH 3, OP 2 |
| x8H | CH 1, OP 3 |
| x9H | CH 2, OP 3 |
| xAH | CH 3, OP 3 |
| xCH | CH 1, OP 4 |
| xDH | CH 2, OP 4 |
| xEH | CH 3, OP 4 |

**Channel Registers (A0H-B6H):**

| Register | Contents |
|----------|----------|
| A0H+ | FREQ. NUM (8 bits LSB) |
| A4H+ | X, X, BLOCK (3 bits), FREQ NUM (3 bits MSB) |
| A8H+ | CH 3 SUPPLEMENTARY FREQ# |
| ACH+ | X, X, CH 3 SUPP BLOCK, CH3 SUPP FREQ NUM |
| B0H+ | X, X, FEEDBACK (3 bits), ALGORITHM (3 bits) |
| B4H+ | L, R, AMS (2 bits), X, FMS (3 bits) |

Each of the above (A0H-B6H) has three entries. All follow the pattern:

| Address | Channel |
|---------|---------|
| x0H | CH 1 |
| x1H | CH 2 |
| x2H | CH 3 |

With the exception that A8H and ACH follow the pattern:

| Address | Assignment |
|---------|-----------|
| A8H | CH 3, OP2 |
| A9H | CH 3, OP3 |
| AAH | CH 3, OP4 |

"PART II" is a duplication of 30H - B4H, where channels 1-3 are replaced by 4-6.

---

### Register Details

#### Register 22H - LFO

| Bit 3 | Bits 2-0 |
|-------|----------|
| LFO EN | LFO FREQ |

LFO EN - 1 is enabled, 0 is disabled.

**LFO FREQ values:**

| Value | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
|-------|------|------|------|------|------|------|------|------|
| Hz | 3.98 | 5.56 | 6.02 | 6.37 | 6.88 | 9.63 | 48.1 | 72.2 |

The LFO (Low frequency Oscillator) is used to distort the FM sounds amplitude and phase. It is triple enabled, as there is:

- A) A global enable in Reg. 22H
- B) A sensitivity enable on a channel by channel basis, in Regs. 60H - 6EH.
- C) Channel-level control by setting registers B4 - B6H.

Finally, if a channel's amplitude is affected, make sure that it is only the "slots" that are affected by setting registers 60H - 6EH.

#### Registers 24H/25H - Timer A

| Register | Contents |
|----------|----------|
| 24H | TIMER A MSBs (8 bits) |
| 25H | X X X X X X, TIMER A LSBs (2 bits) |

Registers 24H and 25H are ganged together to form 10-bit TIMER A, with register 25H containing the least significant bits. They should be set in the order 24H, 25H. The timer lasts:

```
18 * (1024 - TIMER A) microseconds
```

- Timer A = all 1's -> 18 us = 0.018 ms
- Timer A = all 0's -> 18,400 us = 18.4 ms

#### Register 26H - Timer B

| Register | Contents |
|----------|----------|
| 26H | TIMER B (8 bits) |

8 Bit Timer B lasts:

```
288 * (256 - TIMER B) microseconds
```

- TIMER B = all 1's -> 0.288 ms
- TIMER B = all 0's -> 73.44 ms

#### Register 27H - Timer Control / Channel 3 Mode

Register 27H controls the software timers and the Channel 3 (and 6) mode, two entirely separate items.

| CH 3 MODE | D7 | D6 | Description |
|-----------|----|----|-------------|
| NORMAL | 0 | 0 | Channel 3 is the same as the others |
| SPECIAL | 0 | 1 | Channel 3 has 4 separate frequencies |
| ILLEGAL | 1 | X | -------- |

A normal channel's operators use offsets of integral multiples of a single frequency. In special mode, each operator has an entirely separate frequency. Channel 3 operator 1's frequency is in registers A2 and A6. Operators 2 to 4 are in Regs. A8 and AC, A9 and AD, and AA and AE respectively.

No one at Sega has used the timer feature, but the Japanese manual says:

- **LOAD** - 1 starts the timer, 0 stops it.
- **ENABLE** - 1 causes timer overflow to set the read register flag. 0 means the timer keeps cycling without setting the flag.
- **RESET** - Writing a 1 clears the read register flag, writing a 0 has no effect.

#### Register 28H - Key On/Off

| Bits 7-4 | Bit 3 | Bits 2-0 |
|----------|-------|----------|
| OPERATOR | X | CHANNEL |

This register is used for "Key on" and "Key off". "Key on" is the depression of the synthesizer key. "Key off" is its release. The sequence of operations is: set parameters, Key on, wait, key off. When key off occurs, the FM channel stops its slow decline and starts the rapid decline specified by "RR", the release rate.

In a single write to register 28H, one sets the status of all operators for a single channel. Sega always sets them to the same value, on (1) or off (0). Using a special channel 3, I believe it is possible to have each operator be a separate note, so there is possible justification for turning then on and off separately.

**OPERATOR bits:**

| Bit | Operator |
|-----|----------|
| 4 | Operator 1 |
| 5 | Operator 2 |
| 6 | Operator 3 |
| 7 | Operator 4 |

**CHANNEL encoding:**

| D2 | D1 | D0 | Channel |
|----|----|----|---------|
| 0 | 0 | 0 | Channel 1 |
| 0 | 0 | 1 | Channel 2 |
| 0 | 1 | 0 | Channel 3 |
| 1 | 0 | 0 | Channel 4 |
| 1 | 0 | 1 | Channel 5 |
| 1 | 1 | 0 | Channel 6 |

#### Register 2AH - DAC Data

| Register | Contents |
|----------|----------|
| 2AH | DAC DATA (8 bits) |

Register 2AH contains 8 bit DAC data.

#### Register 2BH - DAC Enable

| Bit 7 | Bits 6-0 |
|-------|----------|
| DAC EN | X X X X X X X |

If the DAC enable is 1, the DAC data is output as a replacement for channel 6. The only Channel 6 register that affects the DAC is the stereo output portion of reg. B4H.

---

### Operator Registers (30H-90H)

Registers 30H - 90H are all single-operator registers. Please see page 8 for how the twelve channel-operator combinations are arranged.

#### Register 30H - DT1/MUL (Detune/Multiple)

| Bit 7 | Bits 6-4 | Bits 3-0 |
|-------|----------|----------|
| X | DT1 | MUL |

Both DT1 (Detune) and MUL (Multiple) relate the operator's frequency to the overall frequency.

MUL ranges from 0 to 15, and multiples the overall frequency, with the exception that 0 results in multiplication by 1/2. That is, MUL=0 to 15 gives \*1/2, \*1, \*2, ... \*15.

DT1 gives small variations from the overall frequency \* MUL. The MSB of DT1 is a primitive sign bit, and the two LSB's are magnitude bits.

**DT1 Multiplicative Effect:**

| D6 | D5 | D4 | Effect |
|----|----|----|--------|
| 0 | 0 | 0 | No Change |
| 0 | 0 | 1 | X ( 1 + 1\*E ) |
| 0 | 1 | 0 | X ( 1 + 2\*E ) |
| 0 | 1 | 1 | X ( 1 + 3\*E ) |
| 1 | 0 | 0 | No Change |
| 1 | 0 | 1 | X ( 1 + 1\*E ) |
| 1 | 1 | 0 | X ( 1 + 2\*E ) |
| 1 | 1 | 1 | X ( 1 + 3\*E ) |

Where E is a small number.

#### Register 40H - TL (Total Level)

| Bit 7 | Bits 6-0 |
|-------|----------|
| X | TL |

TL (total level) represents the envelope's highest amplitude, with 0 being the largest and 127 the smallest. A change of one unit is about 0.75 dB.

To make a note softer, only change the TL of the slots (the output operators). Changing the other operators will affect the flavor of the note.

#### Register 50H - RS/AR (Rate Scaling / Attack Rate)

| Bits 7-6 | Bit 5 | Bits 4-0 |
|----------|-------|----------|
| RS | X | AR |

Register 50H contains RS (rate scaling) and AR (attack rate). AR is the steepness of the initial amplitude rise, shown on page 4.

RS affects AR, D1R, D2R and RR in the same way. RS is the degree to which the envelope becomes narrower as the frequency becomes higher.

The frequency's top five bits (3 octave bits and 2 note bits) are called KC (Key code) in the following rate formulas:

```
RS=0 -> Final Rate = 2 * Rate + (KC/8)
RS=1 -> Final Rate = 2 * Rate + (KC/4)
RS=2 -> Final Rate = 2 * Rate + (KC/2)
RS=3 -> Final Rate = 2 * Rate + (KC/1)
```

KC/N is always rounded down.

As rate ranges from 0-31, this means that the RS influence ranges from small (at 0-3) to very large (at 0-31).

#### Register 60H - AM/D1R (Amplitude Modulation / First Decay Rate)

| Bit 7 | Bits 6-5 | Bits 4-0 |
|-------|----------|----------|
| AM | X X | D1R |

D1R (First Decay Rate) is the initial steep amplitude decay rate (see page 4). It is, like all rates, 0-31 in value and affected by RS.

AM is the amplitude modulation enable, whether or not this operator will be subject to amplitude modulation by the LFO. This bit is not relevant unless both the LFO is enabled and register B4's AMS (Amplitude modulation sensitivity) is non-zero.

#### Register 70H - D2R (Secondary Decay Rate)

| Bits 7-5 | Bits 4-0 |
|----------|----------|
| X X X | D2R |

D2R (secondary decay rate) is the long tail off of the sound that continues as long as the key is depressed.

#### Register 80H - D1L/RR (Secondary Amplitude / Release Rate)

| Bits 7-4 | Bits 3-0 |
|----------|----------|
| D1L | RR |

D1L is the secondary amplitude reached after the first period of rapid decay. It should be multiplied by 8 if one wishes to compare it to TL. Again as TL, the higher the number, the more attenuated the sound.

RR is the release rate, the final sharp decrease in volume after the key is released. All rates are 5 bit numbers, but there are only four bits available in the register. Thus, for comparison and calculation purposes, these four bits are the MSBs and the LSB is always 1. In other words, double it and add one.

#### Register 90H - SSG-EG

| Bits 7-4 | Bits 3-0 |
|----------|----------|
| X X X X | SSG-EG |

This register is proprietary and should be set to zero.

---

### Channel Registers (A0H-B6H)

The final registers relate mostly to a single channel. Each register is tripled; please see the diagram on page 9.

#### Registers A0H/A4H - Frequency

| Register | Contents |
|----------|----------|
| A0H+ | FREQ. NUM (8 bits LSB) |
| A4H+ | X, X, BLOCK (3 bits), FREQ NUM (3 bits MSB) |

#### Registers A8H/ACH - CH3 Supplementary Frequency

| Register | Contents |
|----------|----------|
| A8H+ | CH3 SUPP. FREQ. NUM |
| ACH+ | X, X, CH 3 SUPP BLOCK, CH 3 SUPP FREQ NUM |

Channel 1's frequency is in A0 and A4H.
Channel 2's frequency is in A1 and A5H.
Channel 3's frequency is in normal mode (see page 12) is in A2 and A6H.

If Channel 3 is in special mode:

- Operator 1's frequency is in A7 and A6H
- Operator 2's frequency is in A8 and ACH
- Operator 3's frequency is in A9 and ADH
- Operator 4's frequency is in AA and AEH

The frequency is a 14-bit number that should be set high byte, low byte (e.g. A4H then A0H). The highest 3 bits called the "block", give the octave. The next 10 bits give position in the octave, and a possible 12-tone sequence is:

| Note | Value |
|------|-------|
| Low | 617 |
| | 653 |
| | 692 |
| | 733 |
| | 777 |
| | 823 |
| | 872 |
| | 924 |
| | 979 |
| | 1037 |
| | 1099 |
| High | 1164 |

All numbers in base 10. This sequence should be used inside each octave.

#### Register B0H - Feedback/Algorithm

| Bits 7-6 | Bits 5-3 | Bits 2-0 |
|----------|----------|----------|
| X X | FEEDBACK | ALGORITHM |

FEEDBACK is the degree to which operator 1 feeds back into itself. In the voice library, self feedback is represented as a loop arrow on operator 1.

The ALGORITHM is the type of inter-operator connection used. Please see the list of the eight operators on page 3.

#### Register B4H - Stereo/LFO Sensitivity

| Bit 7 | Bit 6 | Bits 5-4 | Bit 3 | Bits 2-0 |
|-------|-------|----------|-------|----------|
| L | R | AMS | X | FMS |

Register B4H contains stereo output control and LFO sensitivity control.

- L - Left Output, 1 is on, 0 is off.
- R - Right Output, 1 is on, 0 is off.

**NOTE:** The stereo may only be heard by headphones.

**AMS (Amplitude modulation sensitivity):**

| AMS | 0 | 1 | 2 | 3 |
|-----|---|---|-----|------|
| dB | 0 | 1.4 | 5.9 | 11.8 |

**FMS (Frequency modulation sensitivity):**

| FMS | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
|-----|---|------|------|------|------|------|------|------|
| % of a halftone | 0 | +/- 3.4 | +/- 6.7 | +/-10 | +/- 14 | +/- 20 | +/- 40 | +/- 80 |

---

### Test Program

Here's a tested power-on initialization and sample note in the "Grand Piano" voice:

| Register | Value | Comments |
|----------|-------|----------|
| 22H | 0 | LFO off |
| 27H | 0 | Channel 3 mode normal |
| 28H | 0 | all channels off |
| " | 1 | all channels off |
| " | 2 | all channels off |
| " | 4 | all channels off |
| " | 5 | all channels off |
| " | 6 | all channels off |
| 2BH | 0 | DAC off |
| 30H | 71H | DT1/MUL |
| 34H | 0DH | DT1/MUL |
| 38H | 33H | DT1/MUL |
| 3CH | 01H | DT1/MUL |
| 40H | 23H | Total Level |
| 44H | 2DH | Total Level |
| 48H | 26H | Total Level |
| 4CH | 00H | Total Level |
| 50H | 5FH | RS/AR |
| 54H | 99H | RS/AR |
| 58H | 5FH | RS/AR |
| 5CH | 94H | RS/AR |
| 60H | 05 | AM/D1R |
| 64H | 05 | AM/D1R |
| 68H | 05 | AM/D1R |
| 6CH | 07 | AM/D1R |
| 70H | 02 | D2R |
| 74H | 02 | D2R |
| 78H | 02 | D2R |
| 7CH | 02 | D2R |
| 80H | 11H | D1L/RR |
| 84H | 11H | D1L/RR |
| 88H | 11H | D1L/RR |
| 8CH | A6H | D1L/RR |
| 90H | 00 | Proprietary |
| 94H | 00 | Proprietary |
| 98H | 00 | Proprietary |
| 9CH | 00 | Proprietary |
| B0H | 32H | FEEDBACK/ALGORITHM |
| B4H | C0H | Both Speakers on |
| 28H | 00H | Key off |
| A4H | 22H | Set Frequency |
| A0H | 69H | Set Frequency |
| 28H | F0H | Key on |
| \<Wait\> | | |
| 28H | 00H | Key off |

**Notes:**
1. Write address then data.
2. Loop until read register D7 becomes 0.
3. Follow MSB/LSB sequence.

---

## Programmable Sound Generator (PSG)

The PSG contains four sound channels, consisting of three tone generators and a noise generator. Each of the four channels has an independent volume control (attenuator). The PSG is controlled through output port $7F.

### Tone Generator Frequency

The frequency (pitch) of a tone generator is set by a 10-bit value. This value is counted down until it reaches zero, at which time the tone output toggles and the 10-bit value is reloaded into the counter. Thus, higher 10-bit numbers produce lower frequencies.

To load a new frequency value into one of the tone generators, you write a pair of bytes to I/O-location $7F according to the following format:

```
First Byte : 1 R2 R1 R0 d3 d2 d1 d0
Second Byte: 0 0  d9 d8 d7 d6 d5 d4
```

The R2:R1:R0 field selects the tone channel as follows:

| R2 | R1 | R0 | Tone Chan. |
|----|----|----|------------|
| 0 | 0 | 0 | #1 |
| 0 | 1 | 0 | #2 |
| 1 | 0 | 0 | #3 |

10-bit data is: (MSB) d9 d8 d7 d6 d5 d4 d3 d2 d1 d0 (LSB)

### Noise Generator Control

The noise generator uses three control bits to select the "character" of the noise sound. A bit called "FB" (Feedback) produces periodic noise or "white" noise:

| FB | Noise Type |
|----|------------|
| 0 | Periodic (like low-frequency tone) |
| 1 | White (hiss) |

The frequency of the noise is selected by two bits NF1:NF0 according to the following:

| NF1 | NF0 | Noise Generator Clock Source |
|-----|-----|----------------------------|
| 0 | 0 | Clock/2 [Higher pitch, "less coarse"] |
| 0 | 1 | Clock/4 |
| 1 | 0 | Clock/8 [Lower pitch, "more coarse"] |
| 1 | 1 | Tone Generator #3 |

**NOTE:** "Clock" is fixed in frequency. It is a crystal controlled oscillator signal connected to the PSG.

When NF1:NF0 is 11, Tone Generator #3 supplies the noise clock source. This allows the noise to be "swept" in frequency. This effect might be used for a jet engine runup, for example.

To load these noise generator control bits, write the following byte to I/O port $7F:

```
Out ($7F):  | 1 | 1 | 1 | 0 | 0 | FB | NF1 | NF0 |
```

### Attenuators

Four attenuators adjust the volume of the three tone generators and the noise channel. Four bits A3:A2:A1:A0 control the attenuation as follows:

| A3 | A2 | A1 | A0 | Attenuation |
|----|----|----|-----|-------------|
| 0 | 0 | 0 | 0 | 0 dB (maximum volume) |
| 0 | 0 | 0 | 1 | 2 dB NOTE: a higher attenuation results in a quieter sound. |
| 0 | 0 | 1 | 0 | 4 dB |
| 0 | 0 | 1 | 1 | 6 dB |
| 0 | 1 | 0 | 0 | 8 dB |
| 0 | 1 | 0 | 1 | 10 dB |
| 0 | 1 | 1 | 0 | 12 dB |
| 0 | 1 | 1 | 1 | 14 dB |
| 1 | 0 | 0 | 0 | 16 dB |
| 1 | 0 | 0 | 1 | 18 dB |
| 1 | 0 | 1 | 0 | 20 dB |
| 1 | 0 | 1 | 1 | 22 dB |
| 1 | 1 | 0 | 0 | 24 dB |
| 1 | 1 | 0 | 1 | 26 dB |
| 1 | 1 | 1 | 0 | 28 dB |
| 1 | 1 | 1 | 1 | -Off- |
