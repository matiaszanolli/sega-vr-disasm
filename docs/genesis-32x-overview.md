# Genesis Super 32X System Overview and Hardware Reference

> Converted from PDF: `Genesis32XUSOverview.pdf`

**SEGA OF AMERICA, INC.**
**Consumer Products Division**

**Document Date:** 4/26/94
**Copyright:** 1994 SEGA. All Rights Reserved.
**Classification:** CONFIDENTIAL - PROPERTY OF SEGA

---

## Table of Contents

- [Introduction and System Features](#introduction-and-system-features)
  - [Introduction](#introduction)
  - [System Features](#system-features)
- [32X Hardware Specifications](#32x-hardware-specifications)
  - [GSX Hardware Specifications](#gsx-hardware-specifications)
  - [SH2](#sh2)
  - [RAM](#ram)
  - [Frame Buffer](#frame-buffer)
  - [Video](#video)
  - [Audio](#audio)
- [32X Development Tools Overview](#32x-development-tools-overview)
- [32X Software Library](#32x-software-library)
- [32X Graphics Development Environment](#32x-graphics-development-environment)
  - [Data Format Support](#data-format-support)
  - [2D Development](#2d-development)
  - [3D Development](#3d-development)
  - [Hardware Requirements](#hardware-requirements)
  - [Software Requirements](#software-requirements)
- [32X Sound Development Environment](#32x-sound-development-environment)
- [32X Hardware Manual (MARS-10-032394)](#32x-hardware-manual-mars-10-032394)

---

## Introduction and System Features

### Introduction

Genesis Super 32X (32X) is a "2 X 32 bit" hardware upgrade that will provide arcade-quality game experiences from existing 16-bit Genesis hardware.

When attached to the Sega Genesis or Sega CD, the 32X will incorporate some of the game play capabilities to be found on the upcoming "Saturn" system.

The 32X will use the Hitachi SH2 RISC chips destined for Saturn. The two SH2 chips in the 32X will complement a newly-designed VDP (video digital processor) chip to bring to the Genesis faster processing speed, high color definition, texture mapping, improved computer polygon graphics technology, ever-changing 3D perspective, software motion video, enhanced scaling and rotation and improved audio.

The 32X will enhance both Sega CD disks and Sega Genesis cartridges designed and developed exclusively for the system. In addition, the 500+ regular games available for the Sega Genesis, and the 100+ games available for the Sega CD can still be played while the 32X is attached to the Genesis hardware unit.

### System Features

The following are some of the features on the 32X:

- Plugs into the Genesis Cartridge port with a pass through cartridge port.
- Run by two SH2 processors rendering to a new frame buffer on the 32X itself (not the frame buffer in the Genesis).
- Three display modes support 16 bit, 8 bit, RLE color.
- Will run 32X-only and Genesis cartridges. If the user has a Sega CD system, 32X can be hooked up to the CD system and will run 32X-only and Sega-CD compact discs as well.
- 32X will feature improved graphics capability, more sprites, quicker animation, and allow texture mapping.
- The Genesis and 32X video/sound are mixed together. Thus, graphics and sound from both systems can be overlayed through output. For example, for any given game, the background can be done through the Genesis, and the rendering through the 32X (and vice versa).
- 4 Mbits total (2 Mbits = Frame Buffer; 2 Mbits = SD-RAM).

---

## 32X Hardware Specifications

*[Pages 3-4 contain the GSX Block Diagram (Version 3/4/1994) showing the internal architecture of the 32X, including: ROM Cartridge, Address Selector, ROM Interface, ROM Data Buffer, Genesis Data Buffer, Genesis Interface, Boot ROM, SH II Interface, two SH II processors, 2M SDRAM, two 1M DRAM chips, System Register, FIFO (DMA), Communication Interface, VDP, VDP Register, DRAM Interface, 144-pin O/A, RAM DAC, PWM (12bit), PLL (46MHz to 23MHz), Filter, Sound Mix, and Video Mix. The block diagram shows the interconnection of all these components.]*

*[Page 6 contains Figure 1: 32X Hardware Configuration, showing the physical connection between two SH-2 processors, SDRAM 2Mbit, the 32X chip with I/F G/A and PWM, RAM 1Mbit x2, Cartridge I/F, Mixing IC, OP-AMP (MARS SOUND), and optional Mega CD/Sega CD connection.]*

### GSX Hardware Specifications

| Category | Specification |
|----------|---------------|
| **CPU** | |
| SH2 (32 bit RISC) x 2 | 23.01 MHz, 20 MIPS x 2, 4 KByte cache |
| Internal DSP (add, times & divide) | 23.01 MHz |
| **RAM** | |
| Main Work RAM | 2 Mbit SDRAM |
| Frame Buffer | 1 Mbit x 2 DRAM |
| **VDP** | |
| Maximum screen size | 320 pixel wide x 224 pixel high |
| Maximum colors | 32,768 |
| Display Functions | Direct color mode, Packed pixel mode, Run-length mode, Line table method |
| **MD/GENESIS I/F** | |
| Communication Port | Eight words of dual port registers are available for communication and data transfer |
| Interrupts | An interrupt to the 32X |
| **Sound** | |
| Two channel PWM | Resolution 10 bits at 22 kHz |

### SH2

#### Dual SH2's

Same CPU configuration as the Saturn. Each SH2 has 4K internal RAM. This RAM has two modes selectable from software. Mode 1 is 4K cache, which is useful for general CPU tasks. Mode 2 is 2K cache/2K RAM, which is useful for tight loop tasks such as graphic routines, geometry calculations, and sorting. The SH2's share a common bus that holds the RAM and Frame Buffers. This configuration should lead to unique programming tricks.

#### SD-RAM

The 2Mbits of SD-RAM, which is the same as what is used in the Saturn, has three timing tiers. The read time when reading sequentially is 1 cycle.

#### Master Access to Frame Buffers

Both CPU's reside on the same bus. When they attempt to access the bus at the same time, the Master SH2 will win. Because both SH2's have internal cache memory, the conflict rate is low. Because there is one bus, both SH2's can write to the frame buffer. This allows a programmer to split the draw work for the display into two parts if the game requires.

#### DMA Channels

Each SH2 has two DMA channels that can be configured to respond to the DREQ line on the chip, creating a DMA located in the background of the CPU running. On the 32X, this line toggles every time the 68000 writes to a register on the Genesis. This allows a DMA from the 68000 to the SH2 without halting the SH2 to do the DMA. This will enable the SEGA CD to do high-performance video playback and data transfers.

#### IRQ Lines

The 68000 has two new IRQ's, one sent to each SH2.

#### I/O Ports

The number of I/O ports is still undetermined. Data can be passed through I/O ports and toggle the IRQ to initiate work.

#### FIFO

The FIFO (First In, First Out) allows the SH2 to write data to the frame buffer without a usual wait for the D-RAM.

#### Cycle Stealing

The cartridge will exist on the 68000 side. Both SH2's have master/slave access to the cartridge at all times via the cycle stealing technique. Unless the 68000 is doing a DMA, the cartridge is available at all times.

### RAM

#### System RAM

2 Mbit SDRAM

#### 512 Byte RAM Clear Hardware

Used for flat-shaded polygons.

### Frame Buffer

#### Dual Frame Buffer Design

Two display buffers, each 1 MBit, are featured on the 32X itself. The SH2's can talk to one of them, while the other is being drawn to the screen.

#### Access From MD Side

The VDP and Frame Buffer from the Mega Drive can also be accessed.

### Video

#### Three Display Modes

The following display modes will be supported by 32X:

- Runlength/256 CLUT display mode
- 15-bit RGB 555 color display mode
- 256 CLUT display mode

#### 32,768/256 Color Support

Supports 32,768 colors on screen at once. Each pixel can directly select its RGB color. Direct selecting of color allows movie like special effects, like cross-fading, fade wipes, gouraud shading, and photo realistic image. This is the same color depth as VDP 1 on the Saturn.

#### Line Start Table

Each line of the video display has a start address. This allows for special effects, memory conservation in blank pixel areas, and hardware scrolling.

#### S-Video Support

The 32X supports S-Video, which allows the Genesis to output S-video in pass-through mode.

### Audio

#### Two Channel PWM

PWM registers are used for title screen audio, and the Z80 for gameplay audio.

---

## 32X Development Tools Overview

The following is a list of programming tools to be used with the GSX.

### Hardware

| Hardware | Comments |
|----------|----------|
| IBM PC compatible | Code development for SH2, 68000, Z80. CPU-486 (66 MHz); 8 MB RAM or more; 300MB HDD or more; MS-DOS 5.0 or higher. |
| Macintosh | For graphic and sound tools |
| Unix Work Stations | Works with Hitachi E7000 through ethernet GNU tools. |
| Hitachi ICES for SH2 | |
| - E7000PC | IBM-PC parallel I/F SH2 ICE |
| - E7000 | Ethernet type SH2 ICE |
| - EVAL Board | Low cost IBM-PC parallel I/F SH2 ICE |
| Zacks ICE | 68000 |
| CartDev | Monitor-based development system. Available in June. |
| SegaDev | Cartridge ROM emulator |
| 32X Target | 32X development board |
| CD Emulator | SEGA CD emulator |

### Software

| Software | Comments |
|----------|----------|
| SH2 Compiler | GNU, Hitachi |
| SH2 Cross Assembler | GNU, Hitachi, SNASM2 |
| SH2 Debugger | Hitachi with ICE, SNASM2 |
| 68000 Debugger | SNASM2, etc. |

*[Pages 12-13 contain the Stand-Alone System diagrams showing two development configurations:*

*Configuration 1 (full): IBM-PC with Bus Board connected to 32X Target with two E7000 PCs for SH2 debugging, plus 68000 ICE. CD Development Environment with CD Emulator connected via 68000 ICE.*

*Configuration 2 (simplified): IBM-PC with EVA Board connected to 32X Target with ROM Emulator and 68000 ICE.]*

---

## 32X Software Library

The following diagram lists the 32X software libraries and the programs in them.

### System Library

- Initialization Program
- MegaDrive/Genesis I/F

### Program Library

- Graphics Library
- High speed, simple calculations
- PWM Sound Driver
- Interrupt control
- DMA

### Sample Programs

- System start-up samples
- Using library samples
- MegaDrive/Genesis I/F samples

### Graphics Library

#### 3D Library

- Set viewpoint
- Matrix composition
- Coordinate transformation
- Perspective projection
- Surface display priority
- HSE (Hidden Surface Elimination/AAZ-sort)
- Real-time shading (Vector setting, Luminosity)
- 3D clipping

#### 2D Library

- Direct color drawing
- Packed pixel drawing
- Run-length drawing
- 2D clipping
- Color mode setting

---

## 32X Graphics Development Environment

### Data Format Support

The following data and formats are or will be supported.

| Data Type | Comment |
|-----------|---------|
| **Image Data** | |
| PICT | Macintosh picture data |
| DGT2 | DC mode, PP mode, RLE mode supported |
| **Model Data** | |
| DXF | Auto CAD data |
| **3D Data** | |
| SEGA3D | Modeling, Material, Object data |
| **Animation Data** | |
| PICS | Macintosh animation data |

**Other Formats** - The following formats are scheduled to be supported in the future:

- BOB
- TIFF
- BMP
- PCX

### 2D Development

*[2D Development pipeline diagram:]*

Paint Tool (O.T.S) --> Image data --> Image data (Bitmap, Color palette)

Motion editor --> Simulation

### 3D Development

*[3D Development pipeline diagram:]*

Modelling Tool (O.T.S) --> Model data --> 3D Editor --> 3D data (Object, Material, Model)

Image data (Texture map) feeds into 3D Editor

Simulation feedback loop from 3D Editor

### Hardware Requirements

The following hardware is required for graphic development.

| Tool | Hardware | Comment |
|------|----------|---------|
| Development System | Macintosh | CPU 68040, 16MB RAM, 100 MB HDD or more |
| Video Card | A 24-bit Video card, or a 24-bit color system | |
| Target | A SCSI system available in June | |

*[System Layout diagram: Macintosh monitor <-> Video card <-> Macintosh <-> SCSI <-> 32X SCSI System <-> TV]*

### Software Requirements

The following software is required for graphic development.

| Tool | Comment |
|------|---------|
| **2D Edit** | |
| SEGA converter | Same tool as for Saturn |
| Simple painter | Same tool as for Saturn |
| Simple animator | Same tool as for Saturn |
| **3D Edit** | |
| Simple 3D editor | Same tool as for Saturn |

#### Simple Painter

A simple paint tool.

| Function | Simple paint tool |
|----------|-------------------|
| Input | Image data is PICT, DGT2 |
| Output | Image data is PICT, DGT2 |

*[Workflow: PICT/DGT2 --> Load --> Simple Painter --> Save --> PICT/DGT2]*

#### Simple Animator

A sprite animation tool.

| Function | Sprite animation tool |
|----------|-----------------------|
| Input | Image data is PICT, DGT2; Animation data is PICS |
| Output | Animation data is PICS |

*[Workflow: PICT/DGT2 --> Load --> 2D Motion Editor --> Save --> PICS]*

#### Simple 3D Editor

A model data viewer that sets 3D data (material, object).

| Function | Model data viewer |
|----------|-------------------|
| Input | Model data is DXF; 3D data is SEGA3D; Image data is PICT, DGT2 (for texture mapping) |
| Output | 3D data: SEGA3D |

*[Workflow: DXF (Load Model) + PICT/DGT2 (Load Texture) --> 3D Editor <--> SEGA3D (Load/Save)]*

#### SEGA Converter

A data format conversion tool.

| Function | Data format conversion |
|----------|-----------------------|
| Input | Image data is PICT, DGT2 (TIFF, BMP, PCX are being planned) |
| Output | Image data is PICT, DGT2 (TIFF, BMP, PCX are being planned) |

*[Workflow: PICT/DGT2 --> Load --> SEGA Converter --> Save --> PICT/DGT2]*

---

## 32X Sound Development Environment

### GSX Sound Control Plan

2 WORDS will be set aside for the 32X communication port. Of the 2 WORDS, 1 WORD will be used for main program (SH2) sound requests. The remaining 1 WORD is exclusively for the sound driver give-and-take control over SH2 and 68000.

### PWM Sound Driver

The following are some of the functions of the PWM sound driver:

- 8 bit data
- Left and right, 2-channel PWM
- Maximum sampling rate of 44.1 KHz
- Looping (forward, alternate)
- 32 step volume change
- 3 cent step pitch control
- **CPU Power Consumption**
  - Pitch, volume control off: 2 us (22 us)
  - Pitch, volume control on: 20 us (22 us)

Presently, the SH2 timer is fixed at 22 us.

### PWM Data Format

Divide PWM data into the following information and data areas.

#### Information Areas

| Field | Type |
|-------|------|
| TOP ADRS | LONG |
| LOOP START ADRS | LONG |
| LOOP POINT ADRS | LONG |
| ORIGINAL SAMPLING KEY | WORD |
| ENVELOPE VOLUME | WORD |
| PAN | WORD |
| NOTE ON/OFF | WORD |
| STATUS | WORD |
| FREQUENCY | WORD |

#### Data Area

Wave data converted to PWM format.

*[Data structure diagram: WAVE-1 through WAVE-N HEADERs followed by WAVE-1 through WAVE-N PCM DATA]*

### GSX Sound Development Environment

#### Sound Program Development Layout

*[Development layout diagram: Macintosh <-> COV. BOARD <-> ICE-6800 <-> 32X + Super Target <-> ICE-SH2 <-> IBM-PC]*

#### Sound/Music Composition

*[Composition layout diagram: MDI instrument --> CartDev <-> Target with Sound Adapter; Mac <-> SCSI <-> CartDev]*

#### Program Development

*[Initial development: CartDev <-> SCSI <-> PC, with Target connected to CartDev]*

When the 32X available, development can be done on the game system as follows:

*[32X development: Target = Genesis + 32X + CartDev <-> SCSI <-> PC]*

---

## 32X Hardware Manual (MARS-10-032394)

### MD Memory Map

#### When Power is ON (ADEN = 0)

| Address Range | Contents |
|---------------|----------|
| $000000-$3FFFFF | ROM |
| $400000+ | See MD Manual |

#### When Using the 32X (ADEN = 1)

| Address Range | Contents |
|---------------|----------|
| $000000-$0FFFFF | Vector ROM |
| $100000-$3FFFFF | (ROM area) |
| $400000+ | See MD Manual |
| $840000-$85FFFF | DRAM |
| $860000-$87FFFF | Over Write Image |
| $880000-$8FFFFF | ROM Image (Fix) |
| $900000-$9FFFFF | ROM Image (Bank) - 4 bank: $000000, $100000, $200000, $300000, $400000 |
| $A00000+ | See MD Manual |
| $A130FC | 32X ID |
| $A131D0 | See MD Manual |
| $A15100 | 32X SYS REG |
| $A15180 | VDP REG |
| $A15200 | Palette |
| $A15400+ | See MD Manual |

**Custom Internal ROM** - Vector ROM contains entries pointing to:

| Offset | Address |
|--------|---------|
| 0 | $00000000 |
| 4 | $00880200 |
| 8 | $00880206 |
| C | $0088020C |
| ... | ... |
| FC | (end) |

#### Notes When Using 32X (ADEN = 1)

- A custom internal ROM is allocated to 68K Vector area ($000000-$0000FF). All Jump destinations with this RAM are to FIX ROM. Image area cartridge ROM is allocated to this area only when ROM to VRAM DMA.
- The cartridge $000000-$07FFFF (4 Mbit) area is allocated to the $880000-$8FFFFF area, and cannot allocate other cartridge ROM areas.
- The $900000-$9FFFFF area accesses a 32 Mbit cartridge area and divides it into four banks by setting the bank inside SYSREG.
- 68K and SH2 can freely access ROM, but when 68K and SH2 are accessed at the same time, SH2 has priority. The CPU then waits until the access before it has ended.
- Only the H INT (Level 4) Vector becomes RAM.
- The Jump source is set to the Fix ROM Image area when the initial program ends.
- Only when FM equals 0 within SYSREG is access of areas $840000 - $87FFFF and $A15100 - $A153FF possible.
- The 32X ID is "MARS."
- Palette can access only by word; it can not access by byte.

### SH2 Memory Map

#### CS 0 Area

| Cached | Cache Through | Contents |
|--------|---------------|----------|
| $00000000 | $20000000 | Boot ROM |
| $00004000 | $20004000 | SYS REG |
| $00004100 | $20004100 | VDP REG |
| $00004200 | $20004200 | Palette |
| $00004400 | $20004400 | (reserved) |

Only when FM = 0 within SYSREG can VDP REG and Palette access.

Palette can access only by word; it can not access by byte.

#### CS 1 Area

| Cached | Cache Through | Contents |
|--------|---------------|----------|
| $02000000 | $22000000 | Cartridge ROM |
| $02400000 | $22400000 | (reserved, Write Protect) |
| $04000000 | $24000000 | (end) |

Access prohibited when RV=1 within SYS REG.

#### CS 2 Area

| Cached | Cache Through | Contents |
|--------|---------------|----------|
| $04000000 | $24000000 | DRAM |
| $04020000 | $24020000 | Over Write Image |
| $04040000 | $24040000 | (reserved) |
| $06000000 | $26000000 | (end) |

However, Accessible only when FM=1 inside SYSREG.

With Write FIFO, write is possible by 3 Sclk. Because there are only two words, a wait is required when more is written continuously.

#### CS 3 Area

| Cached | Cache Through | Contents |
|--------|---------------|----------|
| $06000000 | $26000000 | SDRAM |
| $06040000 | $26040000 | (reserved) |
| $08000000 | $28000000 | (end) |

### Interrupt Levels

| IRL | Name | Description |
|-----|------|-------------|
| 14 | VRES | Interrupt when the MD reset button has been pressed |
| 12 | VINT | V Blank Interrupt |
| 10 | HINT | H Blank Interrupt |
| 8 | CMD INT | Interrupt through register set from MD side |
| 6 | PWM TIMER | Interrupt through PWM synchronous timer |

### DMA

- DMA is a dual address mode (DREQ 0 fixed) for SH side RAM from FIFO (MD side data).
- The ROM to PWM DMA is also a dual address mode.
- For other memory to memory DMA, use the auto request mode.
- DMA can set both master and slave, but both should not be set at the same time.
- When scanning MD DMA data in DMA for the SH side RAM from FIFO, the MD Source Address works properly only by the CD word RAM. FIFO will not run properly even if you set the MD work RAM.

### MD Side SYS REG

#### Adapter Control Register

**Address:** $A15100

```
D15 D14 D13 D12 D11 D10 D9  D8  D7  D6  D5  D4  D3  D2  D1  D0
[FM][            Read Only              ][REN][ -- ][ -- ][RES][ADEN]
```

| Bit | Name | Description |
|-----|------|-------------|
| D0 | ADEN | Adapter Enable Bit. 0: Prohibits use of 32X (initial value). 1: Permits use of 32X |
| D1 | RES | Resets SH2. 0: Reset (initial value). 1: Cancel reset |
| D7 | REN | SH Reset Enable. 0: No. 1: Yes |
| D15 | FM | Frame Buffer Access Permission. 0: MD (initial value). 1: SH |

Switching the access permission is done simultaneously to writing to the FM bit. Therefore, be aware that the SH side will switch even while accessing the VDP.

#### Interrupt Control Register

**Address:** $A15102

```
D15 D14 D13 D12 D11 D10 D9  D8  D7  D6  D5  D4  D3  D2  D1  D0
[                                       ][ RW  RW ]
[                                       ][INTS][INTM]
```

| Bit | Name | Description |
|-----|------|-------------|
| D0 | INTM | Master SH2, Interrupt command. 0: NO OPERATION (initial value). 1: Interrupt command |
| D1 | INTS | Slave SH2, Interrupt command. 0: NO OPERATION (initial value). 1: Interrupt command |

Both are automatically cleared if SH performs interrupt clear.

#### Bank Set Register

**Address:** $A15104

```
D15 D14 D13 D12 D11 D10 D9  D8  D7  D6  D5  D4  D3  D2  D1  D0
[                                                        ][BK1][BK0]
```

#### DREQ Control Register

**Address:** $A15106

```
D15   D14 D13 D12 D11 D10 D9  D8  D7  D6  D5  D4  D3  D2  D1  D0
[Full][            Read Only                       ][68S][DMA][RV ]
```

| Bit | Name | Description |
|-----|------|-------------|
| D0 | RV | ROM to VRAM DMA. 0: NO OPERATION (initial value). 1: Start DMA |
| D1 | DMA | DMA mode bit |
| D2 | 68S | 68K side operation bit |
| D15 | Full | FIFO Full. 0: Writeable. 1: Unwriteable |

The SH side cannot access the ROM when RV = 1. (When doing ROM to VRAM DMA, be sure that RV=1.) When you want to access it, wait until RV=0. (When DEL=1 no action will occur even when writing to FIFO.)

| DMA | 68S | Mode |
|-----|-----|------|
| 0 | 0 | No Operation |
| 0 | 1 | CPU Write (68K writes data in FIFO) |
| 1 | 0 | No Operation |
| 1 | 1 | DMA Write (Performs data capture using MD side DMA). *Valid only when CD is connected.* |

The 32X begins operation when 68S is 1. Writing 0 ends the operation. It automatically becomes 0 after DMA ends.

#### 68 TO SH DREQ Source Address

**Address:** $A15108 (High Order), $A1510A (Low Order)

Sets the source address when performing DMA of the MD side. The inside circuit begins operation of the SH side DREQ circuit from the time that the addresses match. But because the DREQ circuit does not use this data, nothing needs to be set at the time of CPU WRITE.

#### 68 TO SH DREQ Destination Address

**Address:** $A1510C (High Order), $A1510E (Low Order)

Sets the SH side (SDRAM) address. The DREQ circuit does not use this data. Thus, when the destination address is known beforehand by SH, or when SH doesn't need to know, no settings are needed.

#### 68 TO SH DREQ Length

**Address:** $A15110

Sets the data number (Units: Word) to be sent to SH side. The value to be set is in 4 word units. Low order 2 bit write is ignored (00 defined). Be sure to set this register for both CPU WRITE and DMA WRITE. At each transfer, this register is decremented and when it becomes 0, the DREQ operation ends. Transfer is done 65636 times when 0 is set. Read time reads the actual count value.

#### FIFO

**Address:** $A15112 (Write Only)

Data is written to this register when DREQ is used by CPU WRITE.

#### SEGA TV Register

**Address:** $A1511A

```
D15 D14 D13 D12 D11 D10 D9  D8  D7  D6  D5  D4  D3  D2  D1  D0
[                                                              ][CM]
```

| Bit | Name | Description |
|-----|------|-------------|
| D0 | CM | Cartridge Mode. 0: ROM (initial value). 1: DRAM |

Use of this bit is prohibited with other applications for the SEGA TV.

#### Communication Port

**Addresses:** $A15120 - $A1512E (8 words)

```
D15 D14 D13 D12 D11 D10 D9  D8  D7  D6  D5  D4  D3  D2  D1  D0
                              R/W
A15120 [                                                          ]
A15122 [                                                          ]
A15124 [                                                          ]
A15126 [                                                          ]
A15128 [                                                          ]
A1512A [                                                          ]
A1512C [                                                          ]
A1512E [                                                          ]
```

This is an 8 word bi-directional register. Read/write is possible from both the MD and SH directions, but be aware that if writing the same register from both at the same time, the value of that register becomes undefined.

#### PWM Control

**Address:** $A15130

```
D15 D14 D13 D12 D11 D10 D9  D8  D7  D6  D5  D4  D3  D2  D1  D0
[ -- ][ -- ][TM3][TM2][TM1][TM0][RTP][ -- ][MONO][RMD0][RMD1][LMD0][LMD1]
```

| Bit | Name | Description |
|-----|------|-------------|
| D0-D1 | LMD0/LMD1 | Left channel mode |
| D2-D3 | RMD0/RMD1 | Right channel mode |
| D4 | MONO | Sets stereo/mono. 0: stereo (initial value). 1: mono |
| D8 | RTP | DREQ 1 occurrence enable (SH side only). 0: OFF (initial value). 1: ON |
| D9-D12 | TM0-TM3 | Timer value |

When set at mono only registers used for mono are valid.

| RMD0 | RMD1 | OUT | LMD0 | LMD1 | OUT |
|------|------|----|------|------|----|
| 0 | 0 | OFF | 0 | 0 | OFF |
| 0 | 1 | R | 0 | 1 | R |
| 1 | 0 | L | 1 | 0 | L |
| 1 | 1 | no setting | 1 | 1 | no setting |

Neither can be set to Lch or Rch.

Cycle Register: base clock f = 23.01 MHz (fixed)

ATIM 0 ~ 3 sets the PWM time interrupt interval as well as the ROM to PWM transfer synchronization. Interrupt is produced by:

```
(cycle register set value X TM cycle)
```

#### Cycle Register

**Address:** $A15132

```
D15 D14 D13 D12 D11 D10 D9  D8  D7  D6  D5  D4  D3  D2  D1  D0
[ -- ][ -- ][                          R/W                        ]
```

The set value x cyc becomes the cycle.

```
NTSC  Scyc = 1/23.01 [MHz]        PAL  Scyc = 1/22.8 [MHz]
```

#### L ch Pulse Width Register

**Address:** $A15134

The set value x cyc becomes the pulse width.

#### R ch Pulse Width Register

**Address:** $A15136

The set value x cyc becomes the pulse width.

#### Mono Pulse Width Register

**Address:** $A15138

The set value x cyc becomes the pulse width. If writing to this register, the same value is written to both Lch and Rch.

### SH Side SYS REG

#### Interrupt Mask

**Address:** $4000

```
D15 D14 D13 D12 D11 D10 D9  D8  D7  D6  D5  D4  D3  D2  D1  D0
[FM][            Read Only     ][ADEN][CART][HEN][ -- ][ V ][ H ][CMD][PWM]
 ^
 delta
```

| Bit | Name | Description |
|-----|------|-------------|
| D0 | PWM | PWM time interrupt mask. 0: Mask (initial value). 1: Effective |
| D1 | CMD | Command Interrupt Mask. 0: Mask (initial value). 1: Effective |
| D2 | H | H Interrupt Mask. 0: Mask (initial value). 1: Effective |
| D3 | V | V Interrupt Mask. 0: Mask (initial value). 1: Effective |
| D5 | HEN | H INT approval within V Blank. 0: H INT not approved (initial value). 1: H INT approved |
| D7 | Cart | Cartridge insert condition. 0: is inserted. 1: is not inserted |
| D8 | ADEN | Adapter enable bit. 0: 32X use prohibited. 1: 32X use allowed |
| D15 (delta) | FM | Frame Buffer Access Permission. 0: MD (initial value). 1: SH |

D0 ~ D3 have separated registers in master and slave. Switching access permission is done simultaneously to writing to the FM bit. Therefore, be aware that the MD side will switch even while accessing the VDP.

#### Stand By Change

**Address:** $4002 (Write Only)

Use with system (Boot ROM). Access to this register from the application is prohibited.

#### H Count

**Address:** $4004 (Access: Byte/Word)

Sets H int occurrence interval. 0 = each line (default).

#### DREQ Control Register (SH Side)

**Address:** $4006 (Access: Byte/Word)

```
D15   D14 D13 D12 D11 D10 D9  D8  D7  D6  D5  D4  D3  D2  D1  D0
[FULL][EMPT][ -- ][ -- ][ -- ][ -- ][ -- ][ -- ][ -- ][ -- ][68S][DMA][RV]
```

| Bit | Name | Description |
|-----|------|-------------|
| D15 | Full | Frame Buffer, Right Cache Full. 0: Space. 1: No Space |
| D14 | EMPT | Frame Buffer, Right Cache Empty. 0: Data. 1: No Data |

For others see MD side.

#### 68 to SH DREQ Source Address (SH Side)

**Address:** $4008 (High Order), $400A (Low Order) - Read Only

See MD side.

#### 68 to SH DREQ Destination Address (SH Side)

**Address:** $400C (High Order), $400E (Low Order) - Read Only

See MD side.

#### 68 to SH DREQ Length (SH Side)

**Address:** $4010 (Access: Word) - Read Only

See MD side.

#### FIFO (SH Side)

**Address:** $4012 (Access: Word) - Read Only

See MD side.

#### VRES Interrupt Clear

**Address:** $4014 (Access: Word) - Write Only

Clears VRES interrupt. If not cleared, interrupt will continue indefinitely.

#### V Interrupt Clear

**Address:** $4016 (Access: Word) - Write Only

Clears V interrupt. If not cleared, interrupt will continue indefinitely.

#### H Interrupt Clear

**Address:** $4018 (Access: Word) - Write Only

Clears H interrupt. If not cleared, interrupt will continue indefinitely.

#### CMD Interrupt Clear

**Address:** $401A (Access: Word) - Write Only

Clears CMD interrupt. If not cleared, interrupt will continue indefinitely.

#### PWM Interrupt Clear

**Address:** $401C (Access: Word) - Write Only

Clears PWM interrupt. If not cleared, interrupt will continue indefinitely.

#### Communication Port (SH Side)

**Address:** $4020 - $402E (Access: Byte/Word)

```
4020 [                                                          ]
4022 [                                                          ]
4024 [                                                          ]
4026 [                                                          ]
4028 [                                                          ]
402A [                                                          ]
402C [                                                          ]
402E [                                                          ]
```

See MD side.

#### PWM Control (SH Side)

**Address:** $4030 (Access: Byte/Word)

See MD side.

#### Cycle Register (SH Side)

**Address:** $4032

See MD side.

#### L Pulse Width Register (SH Side)

**Address:** $4034

See MD side.

#### R Pulse Width Register (SH Side)

**Address:** $4036

See MD side.

#### Mono Pulse Width Register (SH Side)

**Address:** $4038

See MD side.

### VDP REG (MD and SH Common)

#### Bit Map Mode

**Address:** MD: $A15180, SH: $4100 (Access: Byte/Word)

```
D15  D14 D13 D12 D11 D10 D9  D8  D7  D6  D5  D4  D3  D2  D1  D0
[PAL][     Read Only      ][PRI][240][ -- ][ -- ][ -- ][ M1][ M0]
```

| M1 | M0 | Mode |
|----|----|------|
| 0 | 0 | Blank |
| 0 | 1 | Packed Pixel Mode |
| 1 | 0 | Direct Color Mode |
| 1 | 1 | Run Length Mode |

| Bit | Name | Description |
|-----|------|-------------|
| D6 | 240 | 240 Line Mode (Valid only when PAL). 0: 224 Line (initial value). 1: 240 Line. Changing can only be done within V Blank |
| D7 | PRI | Screen Priority (explained later). 0: MD has priority (initial value). 1: 32X has priority. Change can be done anytime but is valid from the next line. |
| D15 | PAL | TV format. 0: PAL. 1: NTSC |

#### Packed Pixel Control

**Address:** MD: $A15182, SH: $4102 (Access: Byte/Word)

```
D15 D14 D13 D12 D11 D10 D9  D8  D7  D6  D5  D4  D3  D2  D1  D0
[                                                              ][SFT]
```

| Bit | Name | Description |
|-----|------|-------------|
| D0 | SFT | Screen dot left shift (explained later). 0: OFF. 1: ON |

Change can be done anytime but is valid from the next line.

#### Auto Fill Length

**Address:** MD: $A15184, SH: $4104 (Access: Byte/Word)

Word length (0-255) when DRAM is being filled.

Note: The Auto Fill function will be explained later.

#### Auto Fill Start Address

**Address:** MD: $A15186, SH: $4106 (Access: Byte/Word)

```
D15  D14  D13  D12  D11  D10  D9   D8   D7   D6   D5   D4   D3   D2   D1   D0
[A16][A15][A14][A13][A12][A11][A10][ A9][ A8][ A7][ A6][ A5][ A4][ A3][ A2][ A1]
```

Sets the lead of the address you want to fill. A16 ~ A9 remain as set but A8 ~ A1 are incremented at each Fill.

#### Auto Fill Data

**Address:** MD: $A15188, SH: $4108 (Access: Byte/Word)

Sets data to be filled. The Fill operation will begin by setting this register.

#### Frame Buffer Control

**Address:** MD: $A1518A, SH: $410A

```
D15   D14   D13  D12  D11  D10  D9  D8  D7  D6  D5  D4  D3  D2  D1  D0
[VBLK][HBLK][PEN][                  Read Only                   ][FEN][FS]
                                                                   ^
                                                                 delta
```

| Bit | Name | Description |
|-----|------|-------------|
| D0 | FS | Frame Buffer Swap. 0: Transfers DRAM0 to VDP side (initial value). 1: Transfers DRAM1 to VDP side |
| D1 | FEN | Frame Buffer Access authorization. 0: Access allowed (initial value). 1: Access denied |
| D2 (R Only) | FM | Frame Buffer Access Right. 0: MD (initial value). 1: SH |
| D13 | PEN | Palette Access Approval. 0: Access approved. 1: Access denied |
| D14 | HBLK | H Blank. 0: During display period. 1: While Blank |
| D15 | VBLK | V Blank. 0: During display period. 1: While Blank |

Change of FS Bit is possible only during V Blank (VBLK = 1). When changing FS Bit, FM bit, and performing FILL, be sure to access the Frame Buff after confirming that FEN is equal to 0. Palette access is possible only during H and V blank. The bit map mode can access at anytime when in the direct color mode as well as Blank.

### VDP

#### Data Format

**Run Length Mode:**

```
MSB                    LSB
|   8 bits   |   8 bits   |
|  Length     | Color No.  |
```

Length is the display dot number minus 1. 1 dot when Length = 0.

**Packed Pixel Mode:**

```
MSB                    LSB
|   8 bits   |   8 bits   |
|   dot 0    |   dot 1    |
    Color No.
```

**Direct Color Mode:**

```
MSB                         LSB
| 1 |   5   |   5   |   5   |
| T |   B   |   G   |   R   |
  ^
  Through bit
```

**Color Data when Run Length and Packed Pixel:**

```
MSB                         LSB
| 1 |   5   |   5   |   5   |
| T |   B   |   G   |   R   |
  ^
  Through bit
```

#### Priority

**VDP Register PRI = 0:** (MD has priority)
- Throughbit = 1: 32X surface is behind MD surface
- Throughbit = 0: 32X surface is in front of MD surface

**VDP Register PRI = 1:** (32X has priority)
- Throughbit = 1: MD surface is behind 32X surface
- Throughbit = 0: MD surface is in front of 32X surface

- The MD surface is transparent when Color No. = 0.
- Only the MD surface is displayed when in the Blank Mode.

#### DRAM (FRAME Buffer) MAP

```
Address 0x0000: Line Table
  0    Start address for line 1
  2    Start address for line 2
  4    Start address for line 3
  ...
  1FC  Start address for line 255
  1FE  Start address for line 256

Address 0x0200: Pixel Data
  ...
Address 0x1FFFF: End
```

Note: One line is defined by 320 dots.

#### Surface Shift Control

```
         | 0 | 1 | 2 | ................ | 319 | 320 | 321 |

SFT=0    |<------- Display Region (0-319) ------->|

SFT=1        |<------- Display Region (1-320) ------->|
```

Because address data that is set in a line table is in word units, it can only change a table in 2 dot units when a packed pixel. Therefore, to change the display position by 1 dot units, use the SFT bit (when performing H scroll for example). Dot shifting can be done only in screen units.

#### Auto Fill

This function fills the DRAM (Frame Buffer) with page (256 Word) units. Please be aware that fill can be done only inside a page.

**Example 1:**
- Start = $0022A
- Length = $E3
- Data = $AA

Fill from $0022A for length $E3, ending at $003F0. Fill Data = $AA.

**Example 2:**
- Start = $00280
- Length = $E0
- Data = $55

If a Length value is set that exceeds the page, as in example 2, then the address will return to the head of the page.

Auto Fill Address revises the values as shown below:

```
D15  D14  D13  D12  D11  D10  D9   D8   D7   D6   D5   D4   D3   D2   D1   D0
[A16][A15][A14][A13][A12][A11][A10][ A9][ A8][ A7][ A6][ A5][ A4][ A3][ A2][ A1]
|<---- Remains set ---->|<---- Incremented ---->|
```

Fill time calculation formula: `7 + 3 x Length` (cyc)

```
NTSC  Scyc = 1/23.01 [MHz]        PAL  Scyc = 1/22.8 [MHz]
```

### Precautions Concerning VDP

- When accessing the palette RAM during the display interval (HBLK = 0 and VBLK = 0) in the packed pixel mode, there will be a wait until entering Blank.
- The internal circuit ignores the access of a CPU accessing VDP that does not have permission for VDP access by FS bit. Be particularly aware when reading that undefined data will be readout.
- The four areas that receive access control from the FM bit are the Frame Buffer, Over Write Image, VDP Register, and Palette RAM.
- The development board halts access of the VDP by the CPU that does not have permission from the FM bit to access the VDP.

### Access Time Table

**(These may change depending on the development situation hereafter.)**

```
Sclk = 23.01 MHz        Vclk = 7.67 MHz
```

#### ROM Image Area

|  | Read / Write |  |
|--|-------------|--|
| SH2 | min. 5 Sclk wait | |
|  | max. 15 Sclk wait | (14 Sclk wait when reading access of 68K that is in an interval) |
| 68K | min. 0 Vclk wait | |
|  | max. 5 Vclk wait | |

#### Frame Buffer

|  | Read | Write |
|--|------|-------|
| SH2 | min. 4 Sclk wait | 1 Sclk wait |
|  | max. 8 Sclk wait | 8 Sclk wait |
| 68K | Read / Write | |
|  | min. 1 Vclk wait | |
|  | max. 3 Vclk wait | |

#### SYS REG

|  | Read | Write |
|--|------|-------|
| SH2 | 1 Sclk wait | 1 Sclk wait |
| 68K | 0 Vclk wait | 0 Vclk wait |

#### VDP REG

|  | Read | Write |
|--|------|-------|
| SH2 | 4 Sclk wait | 4 Sclk wait |
| 68K | 1 Vclk wait | 0 Vclk wait |

#### Boot ROM

| | Wait |
|--|------|
| SH2 | 1 Sclk wait |

### Precautions When Using SH2 ICE

The following restrictions apply until you are able to change to the latest ICE (about 6 months).

- All SH7604 E7000 V1.0 restrictions are in effect.
- SDRAM cannot be accessed by the cache through.
- Data cannot be properly transferred even when treating SDRAM in the DMA source and the destination in the SDRAM by DMA.
- With an Expansion Board:
  - SH ROM access has a minimum 6 clock wait (8 clock access)
  - SH VDP register has a minimum 5 clock wait (7 clock access)
- The current SH2 ICE cannot access the SDRAM with cache through. You must be careful when read/writing data by both master and slave since the cache can not be turned OFF. The SH2 final chip does not occur in the problem mentioned above.
- VDP REG and Palette have a minimum 5 clock wait (7 Clock access)

**Note:** SH in this document refers to SH7604 (SH2).
