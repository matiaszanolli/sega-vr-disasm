# 32X Introduction and System Features

**Date:** 4/26/94
**Document:** CONFIDENTIAL - PROPERTY OF SEGA
**Copyright:** 1994 SEGA. All Rights Reserved.

---

## Table of Contents

1. [Introduction](#introduction)
2. [System Features](#system-features)
3. [GSX Block Diagram](#gsx-block-diagram)
4. [32X Hardware Specifications](#32x-hardware-specifications)
   - [GSX Hardware Specifications](#gsx-hardware-specifications)
   - [SH2](#sh2)
   - [RAM](#ram)
   - [Frame Buffer](#frame-buffer)
   - [Video](#video)
   - [Audio](#audio)
5. [32X Development Tools Overview](#32x-development-tools-overview)
6. [32X Software Library](#32x-software-library)
7. [32X Graphics Development Environment](#32x-graphics-development-environment)
8. [32X Sound Development Environment](#32x-sound-development-environment)
9. [32X Hardware Manual](#32x-hardware-manual)
   - [MD Memory Map](#md-memory-map)
   - [SH2 Memory Map](#sh2-memory-map)
   - [Interrupt Levels](#interrupt-levels)
   - [DMA](#dma)
   - [MD Side SYS REG](#md-side-sys-reg)
   - [SH Side SYS REG](#sh-side-sys-reg)
   - [VDP REG](#vdp-reg)
   - [VDP](#vdp)
   - [Access Time Table](#access-time-table)
   - [Precautions](#precautions)

---

## Introduction

Genesis Super 32X (32X) is a "2 X 32 bit" hardware upgrade that will provide arcade-quality game experiences from existing 16-bit Genesis hardware.

When attached to the Sega Genesis or Sega CD, the 32X will incorporate some of the game play capabilities to be found on the upcoming "Saturn" system.

The 32X will use the Hitachi SH2 RISC chips destined for Saturn. The two SH2 chips in the 32X will complement a newly-designed VDP (video digital processor) chip to bring to the Genesis faster processing speed, high color definition, texture mapping, improved computer polygon graphics technology, ever-changing 3D perspective, software motion video, enhanced scaling and rotation and improved audio.

The 32X will enhance both Sega CD disks and Sega Genesis cartridges designed and developed exclusively for the system. In addition, the 500+ regular games available for the Sega Genesis, and the 100+ games available for the Sega CD can still be played while the 32X is attached to the Genesis hardware unit.

## System Features

The following are some of the features on the 32X:

- Plugs into the Genesis Cartridge port with a pass through cartridge port.
- Run by two SH2 processors rendering to a new frame buffer on the 32X itself (not the frame buffer in the Genesis).
- Three display modes support 16 bit, 8 bit, RLE color.
- Will run 32X-only and Genesis cartridges. If the user has a Sega-CD system, 32X can be hooked up to the CD system and will run 32X-only and Sega-CD compact discs as well.
- 32X will feature improved graphics capability, more sprites, quicker animation, and allow texture mapping.
- The Genesis and 32X video/sound are mixed together. Thus, graphics and sound from both systems can be overlayed through output. For example, for any given game, the background can be done through the Genesis, and the rendering through the 32X (and vice versa).
- 4 Mbits total (2 Mbits = Frame Buffer; 2 Mbits = SD-RAM).

---

## GSX Block Diagram

**GSX BLOCK - Version 3/4/1994**

*Genesis Super 32X System Overview*

The system block diagram shows the following major components and their interconnections:

- **ROM Cartridge** connects through an **Address Selector** to the **ROM Interface**
- **ROM Data Buffer** feeds into the **126pin Q/A** and **Genesis Data Buffer**
- **Boot ROM** connects to the **SH II Interface**, which links to two **SH II** processors
- **2M SDRAM** provides shared working memory for both SH2 CPUs
- **System Register** block manages system configuration
- **FIFO (DMA)** handles data transfer between 68K and SH2 sides
- **PWM (12bit)** provides sound output with Left and Right channels
- **Communication Interface** (x2) bridges between the Genesis side and SH2 side
- **Genesis Interface** connects to the Mega Drive/Genesis bus (CART, VA1-VA23, A0-A23, etc.)
- **1M DRAM** (x2) serves as dual frame buffers
- **DRAM Interface** manages frame buffer access
- **VDP Register** and **VDP** handle 32X video processing
- **144pin Q/A** connects to the **RAM DAC** for video output
- **Filter** processes audio output
- **Sound MIX** combines Genesis and 32X audio
- **Video MIX** combines Genesis and 32X video for final output
- **PLL** generates the 21 MHz internal clock from the 46 MHz Genesis clock
- Signals include: HSYNC, VSYNC, BCLK, YS, NTSC/PAL, MRES, TEST

---

## 32X Hardware Specifications

**Date:** 4/26/94
**Copyright:** 1994 SEGA. All rights reserved.

### GSX Hardware Specifications

| Category | Specification | Details |
|----------|--------------|---------|
| **CPU** | | |
| SH2 (32 bit RISC) x 2 | | 23.01 MHz, 20 MIPS x 2, 4 KByte cache |
| Internal DSP (add, times & divide) | | 23.01 MHz |
| **RAM** | | |
| Main Work RAM | | 2 Mbit SDRAM |
| Frame Buffer | | 1 Mbit x 2 DRAM |
| **VDP** | | |
| Maximum screen size | | 320 pixel wide x 224 pixel high |
| Maximum colors | | 32,768 |
| Display Functions | | Direct color mode, Packed pixel mode, Run-length mode, Line table method |
| **MD/GENESIS I/F** | | |
| Communication Port | | Eight words of dual port registers are available for communication and data transfer |
| Interrupts | | An interrupt to the 32X |
| **Sound** | | |
| Two channel PWM | | Resolution 10 bits at 22 kHz |

### Hardware Configuration

*Fig. 1 - 32X Hardware Configuration*

The hardware configuration shows:
- Two **SH-2** processors connected to **SDRAM 2Mbit** and the **32X** custom IC
- **I/F G/A (PWM)** gate array handling interfacing
- **32X** custom IC connected to two **RAM 1Mbit** frame buffer chips
- **RGB** output from 32X feeds into **MIXING IC**
- **OP AMP** handles **MARS SOUND** output through a **Filter**
- **Cartridge I/F** connects to both the ROM cartridge slot and the Genesis/Mega CD below
- **Mega CD / Sega CD** connects via Cartridge I/F providing **SOUND**, **RGB** signals
- Final outputs are **MIXED SOUND** and **MIXED RGB** to the display

---

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

---

### RAM

#### System RAM

2 Mbit SDRAM

#### 512 Byte RAM Clear Hardware

Used for flat-shaded polygons.

---

### Frame Buffer

#### Dual Frame Buffer Design

Two display buffers, each 1 MBit, are featured on the 32X itself. The SH2's can talk to one of them, while the other is being drawn to the screen.

#### Access From MD Side

The VDP and Frame Buffer from the Mega Drive can also be accessed.

---

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

The 32X supports S-Video, which allows the Genesis to output S-Video in pass-through mode.

---

### Audio

#### Two Channel PWM

PWM registers are used for title screen audio, and the Z80 for gameplay audio.

---

## 32X Development Tools Overview

**Date:** 4/26/94
**Copyright:** 1994 SEGA. All Rights Reserved.

The following is a list of programming tools to be used with the GSX.

### Hardware

| Hardware | Comments |
|----------|----------|
| IBM PC compatible | Code development for SH2, 68000, Z80. CPU- 486 (66 MHz); 8 MB RAM or more; 300MB HDD or more; MS-DOS 5.0 or higher. |
| Macintosh | For graphic and sound tools |
| Unix Work Stations | Works with Hitachi E7000 through ethernet GNU tools. |
| **Hitachi ICES for SH2** | |
| E7000PC | IBM-PC parallel I/F SH2 ICE |
| E7000 | Ethernet type SH2 ICE |
| EVAL Board | Low cost IBM-PC parallel I/F SH2 ICE |
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

### Stand-Alone System

The development environment supports two configurations:

**Configuration 1 (Full ICE Setup):**
- IBM-PC connected via Bus Board to E7000 PC (x2) for dual SH2 debugging
- 68000 ICE connected to the 32X Target
- Optional CD Development Environment with separate 68000 ICE and CD Emulator

**Configuration 2 (EVA Board Setup):**
- IBM-PC connected to two EVA Boards and ROM Emulator
- 68000 ICE connected to the 32X Target

---

## 32X Software Library

**Date:** 4/26/94
**Copyright:** 1994 SEGA. All Rights Reserved.

### 32X Software Library Overview

The following diagram lists the 32X software libraries and the programs in them.

#### System Library
- Initialization Program
- MegaDrive/Genesis I/F

#### Program Library
- Graphics Library
- High speed, simple calculations
- PWM Sound Driver
- Interrupt control
- DMA

#### Sample Programs
- System start-up samples
- Using library samples
- MegaDrive/Genesis I/F samples

#### Graphics Library

**3D Library:**
- Set view point
- Matrix composition
- Coordinate transformation
- Perspective projection
- Surface display priority (Hidden Surface Elimination/Z-sort)
- Real-time shading (Vector setting, Luminosity)
- 3D clipping

**2D Library:**
- Direct color drawing
- Packed pixel drawing
- Run-length drawing
- 2D clipping
- Color mode setting

---

## 32X Graphics Development Environment

**Date:** 4/26/94
**Copyright:** 1994 SEGA. All Rights Reserved.

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
| **Other Formats** | |
| BOB, BMP, TIFF, PCX | Scheduled to be supported in the future |

### 2D Development

**Workflow:**
1. **Paint Tool (O.T.S)** produces **Image data**
2. Image data feeds into **Motion editor** for **Simulation**
3. Final output: **Image data** (Bitmap, Color palette)

### 3D Development

**Workflow:**
1. **Modelling Tool (O.T.S)** produces **Model data**
2. Model data loads into **3D Editor**
3. **Image data** (Texture map) also loads into 3D Editor
4. 3D Editor performs **Simulation**
5. **SEGA3D** data can be loaded/saved bidirectionally
6. Final output: **3D data** (Object, Material, Model)

### Hardware Requirements

The following hardware is required for graphic development.

| Tool | Hardware | Comment |
|------|----------|---------|
| Development System | Macintosh | CPU 68040, 16MB RAM, 100 MB HDD or more |
| Video Card | A 24-bit Video card, or a 24-bit color system. | |
| Target | A SCSI system available in June. | |

**System Layout:**
- Macintosh monitor connected to Macintosh with Video card
- Macintosh connected via SCSI to 32X SCSI System
- 32X SCSI System outputs to TV

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

### Simple Painter

A simple paint tool.

| Function | Simple paint tool |
|----------|------------------|
| Input | Image data is PICT, DGT2 |
| Output | Image data is PICT, DGT2 |

**Workflow:** Load PICT/DGT2 into Simple Painter, edit, Save as PICT/DGT2.

### Simple Animator

A sprite animation tool.

| Function | Sprite animation tool |
|----------|-----------------------|
| Input | Image data is PICT, DGT2; Animation data is PICS |
| Output | Animation data is PICS |

**Workflow:** Load PICT/DGT2 into 2D Motion Editor, edit, Save as PICS.

### Simple 3D Editor

A model data viewer that sets 3D data (material, object).

| Function | Model data viewer |
|----------|-------------------|
| Input | Model data is DXF; 3D data is SEGA3D; Image data is PICT, DGT2 (for texture mapping) |
| Output | 3D data: SEGA3D |

**Workflow:**
- Load Model (DXF) into 3D Editor
- Load Texture (PICT, DGT2) into 3D Editor
- Load/Save SEGA3D data bidirectionally

### SEGA Converter

A data format conversion tool.

| Function | Data format conversion |
|----------|-----------------------|
| Input | Image data is PICT, DGT2 (TIFF, BMP, PCX are being planned) |
| Output | Image data is PICT, DGT2 (TIFF, BMP, PCX are being planned) |

**Workflow:** Load PICT/DGT2 into SEGA Converter, Save as PICT/DGT2.

---

## 32X Sound Development Environment

**Date:** 4/26/94
**Copyright:** 1994 SEGA. All Rights Reserved.

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
- **CPU Power Consumption:**
  - Pitch, volume control off: 2 us (22 us interval)
  - Pitch, volume control on: 20 us (22 us interval)

Presently, the SH2 timer is fixed at 22 us.

### PWM Data Format

Divide PWM data into the following information and data areas.

**Information areas (Wave Header):**

| Field | Type |
|-------|------|
| TOP ADRS. | LONG |
| LOOP START ADRS. | LONG |
| LOOP POINT ADRS. | LONG |
| ORIGINAL SAMPLING KEY | WORD |
| ENVELOPE VOLUME | WORD |
| PAN | WORD |
| NOTE ON/OFF | WORD |
| STATUS | WORD |
| FREQUENCY | WORD |

**Data area:**

Wave data converted to PWM format. Structure consists of:
- WAVE-1 through WAVE-N HEADER entries
- WAVE-1 through WAVE-N PCM DATA blocks

### GSX Sound Development Environment

#### Sound Program Development Layout

- Macintosh connected via COV. BOARD to ICE-6800
- ICE-6800 connects to 32X + Super Target
- ICE-SH2 also connects to the target
- IBM-PC connects to ICE-SH2

#### Sound/Music Composition

- MIDI instrument connects to CartDev and Sound Adapter
- CartDev connects via SCSI to Mac
- Sound Adapter connects to Target

#### Program Development

Basic setup:
- CartDev connected via SCSI to PC
- CartDev connected to Target

When the 32X is available, development can be done on the game system as follows:
- Target = Genesis + 32X + CartDev
- CartDev connected via SCSI to PC

---

## 32X Hardware Manual

**(Doc. # MARS-10-032394)**

**Copyright:** 1994 SEGA. All Rights Reserved.

---

### MD Memory Map

#### When Power is ON (ADEN = 0)

| Address Range | Contents |
|---------------|----------|
| $000000-$3FFFFF | ROM |
| $400000+ | See MD Manual |
| $A130FC | 32X ID |
| $A131D0 | See MD Manual |
| $A15100 | 32X SYS REG |
| $A15180+ | See MD Manual |

#### When Using 32X (ADEN = 1)

| Address Range | Contents |
|---------------|----------|
| $000000-$0FFFFF | Vector ROM (Custom Internal ROM) |
| $100000-$3FFFFF | (continued) |
| $400000+ | See MD Manual |
| $840000-$85FFFF | DRAM |
| $860000-$87FFFF | Over Write Image |
| $880000-$8FFFFF | ROM Image (Fix) |
| $900000-$9FFFFF | ROM Image (Bank) - 4 banks: $000000, $100000, $200000, $300000, $400000 |
| $A00000+ | See MD Manual |
| $A130FC | 32X ID |
| $A131D0 | See MD Manual |
| $A15100 | 32X SYS REG |
| $A15180+ | See MD Manual |
| $A15200 | VDP REG |
| $A15400 | Palette |

**Custom Internal ROM Vector Table:**

| Address | Vector |
|---------|--------|
| $00000000 | 0 |
| $00880200 | 4 |
| $00880206 | 8 |
| $0088020C | C |
| ... | ... |
| | FC |

#### Notes on Using 32X (ADEN = 1)

- A custom internal ROM is allocated to 68K Vector area ($000000-$0000FF). All jump destinations with this RAM are to FIX ROM. Image area cartridge ROM is allocated to this area only when ROM to VRAM DMA.
- The cartridge $000000-$07FFFF (4 Mbit) area is allocated to the $880000-$8FFFFF area, and cannot allocate other cartridge ROM areas.
- The $900000-$9FFFFF area accesses a 32 Mbit cartridge area and divides it into four banks by setting the bank inside SYSREG.
- 68K and SH2 can freely access ROM, but when 68K and SH2 are accessed at the same time, SH2 has priority. The CPU then waits until the access before it has ended.
- Only the H INT (Level 4) Vector becomes RAM.
- The Jump source is set to the Fix ROM Image area when the initial program ends.
- Only when FM equals 0 within SYSREG is access of areas $840000-$87FFFF and $A15100-$A153FF possible.
- The 32X ID is "MARS."
- Palette can access only by word; it can not access by byte.

---

### SH2 Memory Map

#### CS 0 Area

| Cache Address | Contents | Cache-Through Address |
|---------------|----------|-----------------------|
| $00000000 | Boot ROM | $20000000 |
| $00004000 | SYS REG | $20004000 |
| $00004100 | VDP REG | $20004100 |
| $00004200 | Palette | $20004200 |
| $00004400 | | $20004400 |
| $02000000 | | $22000000 |

Only when FM = 0 within SYSREG can VDP REG and Palette access.

#### CS 1 Area

| Cache Address | Contents | Cache-Through Address |
|---------------|----------|-----------------------|
| $02000000 | Cartridge ROM | $22000000 |
| $02400000 | | $22400000 |
| $04000000 | | $24000000 |

- Write Protect
- Access prohibited when RV=1 within SYS REG

#### CS 2 Area

| Cache Address | Contents | Cache-Through Address |
|---------------|----------|-----------------------|
| $04000000 | DRAM | $24000000 |
| $04020000 | Over Write Image | $24020000 |
| $04040000 | | $24040000 |
| $06000000 | | $26000000 |

- Accessible only when FM=1 inside SYSREG
- With Write FIFO, write is possible by 3 Sclk. Because there are only two words, a wait is required when more is written continuously.

#### CS 3 Area

| Cache Address | Contents | Cache-Through Address |
|---------------|----------|-----------------------|
| $06000000 | SDRAM | $26000000 |
| $06040000 | | $26040000 |
| $08000000 | | $28000000 |

---

### Interrupt Levels

| IRL | Name | Description |
|-----|------|-------------|
| 14 | VRES | Interrupt when the MD reset button has been pressed |
| 12 | VINT | V Blank Interrupt |
| 10 | HINT | H Blank Interrupt |
| 8 | CMD INT | Interrupt through register set from MD side |
| 6 | PWM TIMER | Interrupt through PWM synchronous timer |

---

### DMA

- DMA is a dual address mode (DREQ 0 fixed) for the SH side RAM from FIFO (MD side data).
- The ROM to PWM DMA is also a dual address mode.
- For other memory to memory DMA, use the auto request mode.
- DMA can set both master and slave, but both should not be set at the same time.
- When scanning MD DMA data in DMA for the SH side RAM from FIFO, the MD Source Address works properly only by the CD word RAM. FIFO will not run properly even if you set the MD work RAM.

---

### MD Side SYS REG

#### Adapter Control Register

**Address:** $A15100

```
D15 D14 D13 D12 D11 D10 D9  D8  D7  D6  D5  D4  D3  D2  D1  D0
FM  --- --- --- --- --- --- REN --- --- --- --- --- --- RES ADEN
                            Read Only                   R/W R/W
```

| Bit | Name | Description |
|-----|------|-------------|
| D0 | ADEN | Adapter Enable Bit. 0: Prohibits use of 32X (initial value). 1: Permits use of 32X |
| D1 | RES | Resets SH2. 0: Reset (initial value). 1: Cancel reset |
| D7 | REN | SH Reset Enable (Read Only). 0: No. 1: Yes |
| D15 | FM | Frame Buffer Access Permission. 0: MD (initial value). 1: SH |

Switching the access permission is done simultaneously to writing to the FM bit. Therefore, be aware that the SH side will switch even while accessing the VDP.

#### Interrupt Control Register

**Address:** $A15102

```
D15 D14 D13 D12 D11 D10 D9  D8  D7  D6  D5  D4  D3  D2  D1  D0
--- --- --- --- --- --- --- --- --- --- --- --- --- --- INTS INTM
                                                        R/W  R/W
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
--- --- --- --- --- --- --- --- --- --- --- --- --- --- BK1  BK0
                                                        R/W  R/W
```

#### DREQ Control Register

**Address:** $A15106

```
D15  D14 D13 D12 D11 D10 D9  D8  D7  D6  D5  D4  D3  D2  D1  D0
Full --- --- --- --- --- --- --- --- --- --- --- --- 68S  DMA  RV
Read                                                 R/W  R/W  R/W
Only
```

| Bit | Name | Description |
|-----|------|-------------|
| D0 | RV | ROM to VRAM DMA. 0: NO OPERATION (initial value). 1: Start DMA |
| D1 | DMA | DMA mode |
| D2 | 68S | 68K side control |
| D15 | Full | FIFO Full. 0: Writeable. 1: Unwriteable |

The SH side cannot access the ROM when RV = 1. (When doing ROM to VRAM DMA, be sure that RV=1.) When you want to access it, wait until RV=0. (When DEL=1 no action will occur even when writing to FIFO.)

**DMA/68S Mode Table:**

| DMA | 68S | Mode |
|-----|-----|------|
| 0 | 0 | No Operation |
| 0 | 1 | CPU Write (68K writes data in FIFO) |
| 1 | 0 | No Operation |
| 1 | 1 | DMA Write (Performs data capture using MD side DMA) *Valid only when CD is connected |

The 32X begins operation when 68S is 1. Writing 0 ends the operation. It automatically becomes 0 after DMA ends.

#### 68 TO SH DREQ Source Address

**Address:** $A15108 (High Order), $A1510A (Low Order)

R/W. Sets the source address when performing DMA of the MD side. The inside circuit begins operation of the SH side DREQ circuit from the time that the addresses match. But because the DREQ circuit does not use this data, nothing needs to be set at the time of CPU WRITE.

#### 68 TO SH DREQ Destination Address

**Address:** $A1510C (High Order), $A1510E (Low Order)

R/W. Sets the SH side (SDRAM) address. The DREQ circuit does not use this data. Thus, when the destination address is known beforehand by SH, or when SH doesn't need to know, no settings are needed.

#### 68 TO SH DREQ Length

**Address:** $A15110

R/W. Sets the data number (Units: Word) to be sent to SH side. The value to be set is in 4 word units. Low order 2 bit write is ignored (00 defined). Be sure to set this register for both CPU WRITE and DMA WRITE. At each transfer, this register is decremented and when it becomes 0, the DREQ operation ends. Transfer is done 65636 times when 0 is set. Read time reads the actual count value.

#### FIFO

**Address:** $A15112

Write Only. Data is written to this register when DREQ is used by CPU WRITE.

#### SEGA TV Register

**Address:** $A1511A

```
D15 D14 D13 D12 D11 D10 D9  D8  D7  D6  D5  D4  D3  D2  D1  D0
--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- CM
                                                            R/W
```

| Bit | Name | Description |
|-----|------|-------------|
| D0 | CM | Cartridge Mode. 0: ROM (initial value). 1: DRAM |

Use of this bit is prohibited with other applications for the SEGA TV.

#### Communication Port

**Addresses:** $A15120 - $A1512E (8 words)

R/W. This is an 8 word bi-directional register. Read/write is possible from both the MD and SH directions, but be aware that if writing the same register from both at the same time, the value of that register becomes undefined.

| Address | Register |
|---------|----------|
| $A15120 | COMM0 |
| $A15122 | COMM1 |
| $A15124 | COMM2 |
| $A15126 | COMM3 |
| $A15128 | COMM4 |
| $A1512A | COMM5 |
| $A1512C | COMM6 |
| $A1512E | COMM7 |

#### PWM Control

**Address:** $A15130

```
D15 D14 D13 D12 D11 D10 D9   D8   D7  D6  D5   D4    D3   D2   D1   D0
--- --- --- --- TM3  TM2  TM1  TM0  RTP --- MONO RMD0  RMD1 LMD0 LMD1
                R/W  R/W  R/W  R/W  R/W     R/W  R/W   R/W  R/W  R/W
                                     R Only
```

| Bit | Name | Description |
|-----|------|-------------|
| D0-D1 | LMD1/LMD0 | Left channel mode |
| D2-D3 | RMD1/RMD0 | Right channel mode |
| D4 | MONO | Sets stereo/mono. 0: stereo (initial value). 1: mono |
| D6 | RTP | DREQ 1 occurrence enable (SH side only). 0: OFF (initial value). 1: ON |
| D8-D11 | TM0-TM3 | Timer interval |

**Channel Mode Table (Right and Left):**

| xMD0 | xMD1 | OUT |
|------|------|-----|
| 0 | 0 | OFF |
| 0 | 1 | R |
| 1 | 0 | L |
| 1 | 1 | no setting |

Neither can be set to Lch or Rch.

Cycle Register base clock f = 23.01 MHz (fixed).

TM0-TM3 sets the PWM time interrupt interval as well as the ROM to PWM transfer synchronization. Interrupt is produced by:

```
(cycle register set value x TM cycle)
```

#### Cycle Register

**Address:** $A15132

R/W. The set value x cyc becomes the cycle.

```
NTSC  Scyc = 1/23.01 [MHz]       PAL  Scyc = 1/22.8 [MHz]
```

#### L ch Pulse Width Register

**Address:** $A15134

R/W. The set value x cyc becomes the pulse width.

#### R ch Pulse Width Register

**Address:** $A15136

R/W. The set value x cyc becomes the pulse width.

#### Mono Pulse Width Register

**Address:** $A15138

R/W. The set value x cyc becomes the pulse width. If writing to this register, the same value is written to both Lch and Rch.

---

### SH Side SYS REG

#### Interrupt Mask

**Address:** $4000

```
D15  D14 D13 D12 D11 D10 D9   D8  D7  D6  D5  D4  D3  D2  D1  D0
FM   --- --- --- --- ADEN CART HEN --- --- --- V   H   --- CMD  PWM
(delta)              R/O  R/O  R/W                          R/W  R/W
```

| Bit | Name | Description |
|-----|------|-------------|
| D0 | PWM | PWM time interrupt mask. 0: Mask (initial value). 1: Effective |
| D1 | CMD | Command Interrupt Mask. 0: Mask (initial value). 1: Effective |
| D3 | H | H Interrupt Mask. 0: Mask (initial value). 1: Effective |
| D4 | V | V Interrupt Mask. 0: Mask (initial value). 1: Effective |
| D8 | HEN | H INT approval within V Blank. 0: H INT not approved (initial value). 1: H INT approved |
| D9 | Cart | Cartridge insert condition. 0: is inserted. 1: is not inserted |
| D10 | ADEN | Adapter enable bit. 0: 32X use prohibited. 1: 32X use allowed |
| D15 | FM (delta) | Frame Buffer Access Permission. 0: MD (initial value). 1: SH |

D0-D3 have separated registers in master and slave. Switching access permission is done simultaneously to writing to the FM bit. Therefore, be aware that the MD side will switch even while accessing the VDP.

#### Stand By Change

**Address:** $4002

Write Only. Use with system (Boot ROM). Access to this register from the application is prohibited.

#### H Count

**Address:** $4004

R/W. (Access: Byte/Word)

Sets H int occurrence interval. 0 = each line (default).

#### DREQ Control Register (SH Side)

**Address:** $4006

(Access: Byte/Word)

```
D15  D14  D13 D12 D11 D10 D9  D8  D7  D6  D5  D4  D3  D2  D1  D0
Full EMPT --- --- --- --- --- --- --- --- --- --- --- 68S  DMA  RV
R/O  R/O                                              R/O  R/O  R/O
```

| Bit | Name | Description |
|-----|------|-------------|
| D15 | Full | Frame Buffer, Right Cache Full. 0: Space. 1: No Space |
| D14 | EMPT | Frame Buffer, Right Cache Empty. 0: Data. 1: No Data |
| D0-D2 | | For others see MD side |

#### 68 to SH DREQ Source Address (SH Side)

**Address:** $4008 (High Order), $400A (Low Order)

(Access: Word). Read Only. See MD side.

#### 68 to SH DREQ Destination Address (SH Side)

**Address:** $400C (High Order), $400E (Low Order)

(Access: Word). Read Only. See MD side.

#### 68 to SH DREQ Length (SH Side)

**Address:** $4010

(Access: Word). Read Only. See MD side.

#### FIFO (SH Side)

**Address:** $4012

(Access: Word). Read Only. See MD side.

#### VRES Interrupt Clear

**Address:** $4014

(Access: Word). Write Only. Clears VRES interrupt. If not cleared, interrupt will continue indefinitely.

#### V Interrupt Clear

**Address:** $4016

(Access: Word). Write Only. Clears V interrupt. If not cleared, interrupt will continue indefinitely.

#### H Interrupt Clear

**Address:** $4018

(Access: Word). Write Only. Clears H interrupt. If not cleared, interrupt will continue indefinitely.

#### CMD Interrupt Clear

**Address:** $401A

(Access: Word). Write Only. Clears CMD interrupt. If not cleared, interrupt will continue indefinitely.

#### PWM Interrupt Clear

**Address:** $401C

(Access: Word). Write Only. Clears PWM interrupt. If not cleared, interrupt will continue indefinitely.

#### Communication Port (SH Side)

**Addresses:** $4020 - $402E (8 words)

(Access: Byte/Word). R/W. See MD side.

| Address | Register |
|---------|----------|
| $4020 | COMM0 |
| $4022 | COMM1 |
| $4024 | COMM2 |
| $4026 | COMM3 |
| $4028 | COMM4 |
| $402A | COMM5 |
| $402C | COMM6 |
| $402E | COMM7 |

#### PWM Control (SH Side)

**Address:** $4030

(Access: Byte/Word). See MD side.

#### Cycle Register (SH Side)

**Address:** $4032

R/W. See MD side.

#### L Pulse Width Register (SH Side)

**Address:** $4034

R/W. See MD side.

#### R Pulse Width Register (SH Side)

**Address:** $4036

R/W. See MD side.

#### Mono Pulse Width Register (SH Side)

**Address:** $4038

R/W. See MD side.

---

### VDP REG

**MD and SH Common**

#### Bit Map Mode

**Address:** MD: $A15180 / SH: $4100

(Access: Byte/Word)

```
D15  D14 D13 D12 D11 D10 D9  D8  D7  D6  D5  D4  D3  D2  D1  D0
PAL  --- --- --- --- --- --- PRI 240 --- --- --- --- --- M1   M0
R/O                          R/W R/W                      R/W  R/W
```

**Display Mode (M1/M0):**

| M1 | M0 | Mode |
|----|----|------|
| 0 | 0 | Blank |
| 0 | 1 | Packed Pixel Mode |
| 1 | 0 | Direct Color Mode |
| 1 | 1 | Run Length Mode |

| Bit | Name | Description |
|-----|------|-------------|
| D7 | 240 | 240 Line Mode (Valid only when PAL). 0: 224 Line (initial value). 1: 240 Line. Changing can only be done within V Blank |
| D8 | PRI | Screen Priority. 0: MD has priority (initial value). 1: 32X has priority. Change can be done anytime but is valid from the next line |
| D15 | PAL | TV format (Read Only). 0: PAL. 1: NTSC |

#### Packed Pixel Control

**Address:** MD: $A15182 / SH: $4102

(Access: Byte/Word)

```
D15 D14 D13 D12 D11 D10 D9  D8  D7  D6  D5  D4  D3  D2  D1  D0
--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- SFT
                                                            R/W
```

| Bit | Name | Description |
|-----|------|-------------|
| D0 | SFT | Screen dot left shift. 0: OFF. 1: ON |

Change can be done anytime but is valid from the next line.

#### Auto Fill Length

**Address:** MD: $A15184 / SH: $4104

(Access: Byte/Word). R/W.

Word length (0-255) when DRAM is being filled.

Note: The Auto Fill function will be explained later.

#### Auto Fill Start Address

**Address:** MD: $A15186 / SH: $4106

R/W.

```
D15  D14  D13  D12  D11  D10  D9  D8  D7  D6  D5  D4  D3  D2  D1
A16  A15  A14  A13  A12  A11  A10 A9  A8  A7  A6  A5  A4  A3  A2  A1
```

Sets the lead of the address you want to fill. A16-A9 remain as set but A8-A1 are incremented at each Fill.

#### Auto Fill Data

**Address:** MD: $A15188 / SH: $4108

(Access: Byte/Word). R/W.

Sets data to be filled. The Fill operation will begin by setting this register.

#### Frame Buffer Control

**Address:** MD: $A1518A / SH: $410A

```
D15   D14   D13  D12 D11 D10 D9  D8  D7  D6  D5  D4  D3  D2  D1  D0
VBLK  HBLK  PEN  --- --- --- --- --- --- --- --- --- --- FEN  FM   FS
R/O   R/O   R/O                                          R/O  R/O  R/W
                                                                     (delta)
```

| Bit | Name | Description |
|-----|------|-------------|
| D0 | FS | Frame Buffer Swap. 0: Transfers DRAM0 to VDP side (initial value). 1: Transfers DRAM1 to VDP side |
| D1 | FM | Frame Buffer Access Right (Read Only). 0: MD (initial value). 1: SH |
| D2 | FEN | Frame Buffer Access authorization (Read Only). 0: Access allowed (initial value). 1: Access denied |
| D13 | PEN | Palette Access Approval (Read Only). 0: Access approved. 1: Access denied |
| D14 | HBLK | H Blank (Read Only). 0: During display period. 1: While Blank |
| D15 | VBLK | V Blank (Read Only). 0: During display period. 1: While Blank |

Change of the FS Bit is possible only during V Blank (VBLK = 1). When changing FS Bit, FM bit, and performing FILL, be sure to access the Frame Buffer after confirming that FEN is equal to 0. Palette access is possible only during H and V blank. The bit map mode can access at anytime when in the direct color mode as well as Blank.

---

### VDP

#### Data Format

**Run Length Mode:**

```
MSB                LSB
| 8 bits  | 8 bits  |
| Length   | Color No|
```

Length is the display dot number minus 1. 1 dot when Length = 0.

**Packed Pixel Mode:**

```
MSB                LSB
| 8 bits  | 8 bits  |
| dot 0   | dot 1   |
    Color No
```

**Direct Color Mode:**

```
MSB                        LSB
| 1 |  5  |  5  |  5  |
| T |  B   |  G   |  R   |
  Through bit
```

**Color Data when Run Length and Packed Pixel:**

```
MSB                        LSB
| 1 |  5  |  5  |  5  |
| T |  B   |  G   |  R   |
  Through bit
```

#### Priority

**VDP Register PRI = 0:**
- Throughbit = 1: 32X surface is displayed in front of MD surface
- Throughbit = 0: MD surface is displayed in front of 32X surface

**VDP Register PRI = 1:**
- Throughbit = 1: MD surface is displayed in front of 32X surface
- Throughbit = 0: 32X surface is displayed in front of MD surface

Notes:
- The MD surface is transparent when Color No. = 0.
- Only the MD surface is displayed when in the Blank Mode.

#### DRAM (FRAME Buffer) MAP

```
Address $0000: Line Table (256 words)
Address $0200: Pixel Data
Address $1FFFF: End
```

**Line Table Structure:**

| Offset | Contents |
|--------|----------|
| $000 | Start address for line 1 |
| $002 | Start address for line 2 |
| $004 | Start address for line 3 |
| ... | ... |
| $1FC | Start address for line 255 (55) |
| $1FE | Start address for line 256 |

Note: One line is defined by 320 dots.

#### Surface Shift Control

The frame buffer has 322 dot positions (0-321). The display region covers 320 dots:

- **SFT=0:** Display Region covers dots 0-319
- **SFT=1:** Display Region covers dots 1-320

Because address data that is set in a line table is in word units, it can only change a table in 2 dot units when a packed pixel. Therefore, to change the display position by 1 dot units, use the SFT bit (when performing H scroll for example). Dot shifting can be done only in screen units.

#### Auto Fill

This function fills the DRAM (Frame Buffer) with page (256 Word) units. Please be aware that fill can be done only inside a page.

**Example 1:**
- Start = $0022A
- Length = $E3
- Data = $AA
- Fills from $0022A to $003F0 with $AA

**Example 2:**
- Start = $00280
- Length = $E0
- Data = $55
- If a Length value is set that exceeds the page, the address will return to the head of the page
- Region 1: Fills from $00280 to end of page
- Region 2: Wraps and fills from $00200 to $00240

Auto Fill Address revises the values as shown below:

```
D15  D14  D13  D12  D11  D10  D9  D8  D7  D6  D5  D4  D3  D2  D1
A16  A15  A14  A13  A12  A11  A10 A9  A8  A7  A6  A5  A4  A3  A2  A1
|<-- Remains set -->|<-- Incremented -->|
```

**Fill time calculation formula:**

```
7 + 3 x Length (cyc)
```

```
NTSC  Scyc = 1/23.01 [MHz]       PAL  Scyc = 1/22.8 [MHz]
```

---

### Precautions Concerning VDP

- When accessing the palette RAM during the display interval (HBLK = 0 and VBLK = 0) in the packed pixel mode, there will be a wait until entering Blank.
- The internal circuit ignores the access of a CPU accessing VDP that does not have permission for VDP access by FS bit. Be particularly aware when reading that undefined data will be readout.
- The four areas that receive access control from the FM bit are the Frame Buffer, Over Write Image, VDP Register, and Palette RAM.
- The development board halts access of the VDP by the CPU that does not have permission from the FM bit to access the VDP.

---

### Access Time Table

*(These may change depending on the development situation hereafter.)*

**Clock References:**
- Sclk = 23.01 MHz
- Vclk = 7.67 MHz

#### ROM Image Area

| CPU | Operation | Wait |
|-----|-----------|------|
| SH2 | Read/Write min. | 5 Sclk wait |
| SH2 | Read/Write max. | 15 Sclk wait (14 Sclk wait when reading access of 68K that is in an interval) |
| 68K | min. | 0 Vclk wait |
| 68K | max. | 5 Vclk wait |

#### Frame Buffer

| CPU | Read | Write |
|-----|------|-------|
| SH2 | min. 4 Sclk wait | 1 Sclk wait |
| SH2 | max. 8 Sclk wait | 8 Sclk wait |
| 68K | min. 1 Vclk wait (Read/Write) | |
| 68K | max. 3 Vclk wait (Read/Write) | |

#### SYS REG

| CPU | Read | Write |
|-----|------|-------|
| SH2 | 1 Sclk wait | 1 Sclk wait |
| 68K | 0 Vclk wait | 0 Vclk wait |

#### VDP REG

| CPU | Read | Write |
|-----|------|-------|
| SH2 | 4 Sclk wait | 4 Sclk wait |
| 68K | 1 Vclk wait | 0 Vclk wait |

#### Boot ROM

| CPU | Wait |
|-----|------|
| SH2 | 1 Sclk wait |

---

### Precautions When Using SH2 ICE

The following restrictions apply until you are able to change to the latest ICE (about 6 months).

- All SH7604 E7000 V1.0 restrictions are in effect.
- SDRAM cannot be accessed by the cache through.
- Data cannot be properly transferred even when treating SDRAM in the DMA source and the destination in the SDRAM by DMA.
- With an Expansion Board:
  - SH ROM access has a minimum 6 clock wait (8 clock access)
  - SH VDP register has a minimum 5 clock wait (7 clock access)
- The current SH2 ICE cannot access the SDRAM with cache through. You must be careful when read/writing data by both master and slave since the cache can not be turned OFF. The SH2 final chip does not occur in the problem mentioned above.
- VDP REG and Palette have a minimum 5 clock Wait (7 Clock access)

**Note:** SH in this document refers to SH7604 (SH2).
