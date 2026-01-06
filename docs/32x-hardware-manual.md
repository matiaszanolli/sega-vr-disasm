# Sega 32X Hardware Manual

**Document Number:** MAR-32-R4-072294

## Document History

- **Provisional Version 1** (May 11, 1994): Introduction, Section 1-3.4, 6.2, 6.3 (64 pages)
- **Provisional Version 2** (May 23, 1994): Sections 3.5, 4.1-4.4, 6.1, additions (99 pages)
- **Revision 1** (May 25, 1994): Introduction, Chapters 1 and 2, terminology updates
- **Revision 2** (May 30, 1994): Improved structure of Chapter 4
- **Provisional Version 3** (June 1, 1994): SH2 Memory Map updates (84 pages)

## Introduction

This manual applies to the development of game software and explains the power-up booster "32X" hardware functions for the MEGA Drive.

## Manual Configuration

### Chapter 1: Introduction to the 32X
Introduces the main functions of the 32X.

### Chapter 2: Configuration
Explains the hardware configuration and purpose of each part.

### Chapter 3: Functions

#### Mapping
Explains the layout on CPU address space of each hardware part.

#### Registers
Explains the meaning of register and buffer function, sequence and address, and set values.

#### VDP
Explains functions such as image data formatting, screen shift, character overwrite, and Fill.

#### PWM
Explains the PWM sound source and the PCM data play method.

#### SH2
Explains the main CPU features and its communication with the MEGA Drive.

### Chapter 4: Accessing the 32X Block
Explains registers and buffers that can be accessed from each CPU, the method of taking access authority, and access time.

### Chapter 5: Miscellaneous

#### Boot ROM
Explains operations from when the power is turned on until executing the application.

#### Security
Explains areas decided by previous uses of the cartridge ROM.

#### Restrictions
Explains cautionary points in creating applications.

---

## Terminology

### RISC (Reduced Instruction Set Computer)
Computer architecture that improves performance by simplifying instruction specifications and has simplified hardware achieving high-efficiency pipeline (parallel process of instructions within the computer).

### SH2 (SH7095)
At the core of the RISC-type CPU is the Hitachi original microcomputer, a 32-bit divider and cache memory.

### Cache
Comparatively small, high-speed memory placed between large, low-speed memory and the CPU. When data of the address to be accessed by the CPU is stored in cache memory, it is referred to as a "cache hit" and the CPU can operate at high speeds. When address data to be accessed is not stored in cache memory, it is referred to as a "cache miss." The contents of the cache memory are replaced by data in the main memory.

### SDRAM (Synchronous Dynamic Random Access Memory)
Differs from typical DRAM in that data of a two-line address is held internally once. This is independently synchronized to the clock and transfers continuously separate from internal DRAM operation speed.

### DSP (Digital Signal Processor)
Signal processor containing a high-speed divider.

### DMA (Direct Memory Access)
Transfers data directly between memory and peripheral units (I/O) or between memories without going through the CPU, usually achieved by the DMA controller (DMAC).

### FIFO (First-In First-Out)
Method of outputting in the same order as inputting in the input/output operation of a buffer register or buffer memory.

### Master/Slave
Refers to the priority order of user authorization of a bus to which more than one processor is connected. Master takes normal bus authorization; slave obtains permission of the master and takes bus authorization when slave bus access occurs.

---

# Chapter 1: Introduction to 32X

## 1.1 Introduction to 32X

The 32X is a power-up booster installed in the MEGA Drive cartridge slot. This adds a bitmap screen of up to 32,768 simultaneous colors and stereo sound source that plays PCM data to the graphics and sound of the existing MEGA Drive. Two 32-bit RISC CPUs are mounted for screen graphics processing.

### New Screen Offered

- **Frame Buffer:** 1 Mbit DRAM × 2 (alternating draw/display)
- **Maximum 32,768 colors**, bitmap format
- **3 mode data formats:**
  - Direct Color
  - Packed Pixel
  - Run Length
- Scroll by hardware, no sprites exist

### New Sounds Offered

- Stereo sound source that plays PCM data
- D/A conversion by PWM modulation (11-bit resolution)

### High-Speed Microprocessor

- Two SH2 chips for the main CPU
- 32-bit RISC chip with built-in process similar to DSP

### Memory

- 4KByte Cache memory (built into the CPU)
- 2Mbit SDRAM (main memory)

### Development Language

- C Language
- Assembly Language

---

# Chapter 2: Configuration

## 2.1 32X Block Diagram

The 32X is made up of the following parts:

- **MEGA Drive I/F Component** (I/F chip built-in)
- **32X Cartridge**
- **SH2 Component**
- **SDRAM (2 Mbit)**
- **Frame Buffer (1 Mbit × 2)**
- **VDP Component**
- **Color Palette Component** (VDP chip built-in)
- **PWM Component** (I/F chip built-in)

These hardware resources (excluding the SH2 and SDRAM components) contained by 32X are directly controlled by the MEGA Drive 68000 CPU. The ROM cartridge can be read from both the MEGA Drive and 32X. Images and sound made by 32X are combined with images and sound made by the MEGA Drive.

## 2.2 About the 32X Block

### MEGA Drive I/F Component

Interface connecting the 32X to the MEGA Drive. The 32X hardware resources (graphics, sound, and communication with SH2) and cartridge ROM are mapped through the MEGA Drive I/F in the MEGA Drive main CPU (68000) address space.

### 32X Cartridge Component

The ROM cartridge installed in the 32X cartridge slot can be read from both the 32X CPU SH2 side and the MEGA Drive side 68000 (and Z80). Nevertheless, SH2 has priority when conflict between the two exists.

### SH2 Component

Two SH2 chips as main CPUs mounted in the 32X. The cartridge ROM is connected with the 32X hardware resources (graphics, sound, and communication to 68000) on a common bus. The 2 SH2 units are fixed to master and slave by packaged conditions; the master gets bus authorization normally and slave gets bus authorization after obtaining permission of the master at the time of bus access.

MEGA Drive hardware cannot map in SH2 address space. Consequently, MEGA Drive information is indirectly received by communication with the 68000. The 32X has:
- A control register that issues interrupts from 68000 to SH2
- A FIFO register that can send data written from the 68000 to the DMA built into the SH2
- A register that can be read and written from both the 68000 and SH2

### SDRAM Component

The 32X has 2Mbits of SDRAM (synchronous DRAM) as main memory for the SH2 chips. The SH2 program on the cartridge ROM is loaded into SDRAM, then executed. The SDRAM arranges 16 bytes and reads to the buffer inside the chip; after which, in order to synchronize to the SH2 clock and transfer sequentially, all data after the second data set can be transferred without restrictions incurred by operation within the memory. The SH2 can rapidly execute data replacement by combining with the SDRAM when cache miss occurs.

### Frame Buffer Component

Memory that saves the display contents of one part of the color display is called a frame buffer. For one screen, the display flickers when rewrite does not finish in V Blank (vertical retrace line interval). Therefore, the memory is arranged as two screens in 32X and a method is used to alternatively switch between the update screen and display screen. The frame buffer performs the switching operations with each Mbit and program.

### VDP Component

32X VDP holds the frame buffer as a control screen and controls the display of the color display. This screen combines MEGA Drive scroll A, scroll B, and sprite as one screen in the front or back. The following three modes can be selected from data formats in the frame buffer:

#### Direct Color Mode
Allocates each of 16 bits to 1 pixel on the screen, of which 15 bits are used to indicate any color from 32,768 colors.

#### Packed Pixel Mode
Allocates each of 8 bits to 1 pixel on the screen and colors indicated on the color palette are indirectly indicated.

#### Run Length Mode
Allocates 16 bits as a collection of identically colored pixels that continue with more than 1 pixel in the direction of the scan line. Pixel numbers that are continuous with 8 of the 16 bits and colors indicated on the color palette with the remaining 8 bits are indirectly indicated.

### Color Palette Component

The color palette is a 256-word RAM block. When in the packed pixel mode or run length mode, pixel data in the frame buffer select colors (256 colors from among 32,768 colors) indirectly selected in advance.

The color selection format is the same whether selecting per frame buffer in the direct color mode, or per color palette in the run-length mode. One color is 16 bits, of which 15 bits are used, and any color can be selected from 32,768 colors. The remaining 1 bit is called a priority-bit (through-bit); pixels indicated by this bit's color are displayed opposite to the MEGA Drive screen.

### PWM Component

PWM (Pulse Width Modulation) replaces sampling data with the pulse width and outputs the pulse width. If output is through an integrated circuit, the amplitude can be controlled by the pulse width. The 32X can regenerate in stereo PCM wave data converted in advance for PWM.

---

# Chapter 3: Functions

## 3.1 Mapping

The 32X hardware can be controlled from both the main CPU SH2 and MEGA Drive 68000.

### MEGA Drive Memory Map

In using the 32X, the exclusive initial program provided by SEGA is laid out in cartridge ROM at 3FAh or more and jumped by the reset vector. To map the 32X in 68000 address space, this program sets the ADEN (address enable) bit to 1, initializes the hardware, and executes the application.

#### When Power is On (ADEN = 0)

| Address Range | Contents |
|--------------|----------|
| 000000h | Custom internal ROM Vector ROM |
| 00h-FCh | (various vectors) |
| 40 0000h | See MD Manual |
| A0 0000h | - |
| A1 30ECh | Super 32X ID |
| 100 0000h | - |

#### When Using Super 32X (ADEN = 1)

| Address Range | Contents |
|--------------|----------|
| 00 0000h | ROM Cartridge (vectors at 88 0200h + offset) |
| 40 0000h | See MD Manual |
| 84 0000h | Frame Buffer |
| 86 0000h | Overwrite Image |
| 88 0000h | ROM Cartridge (00 0000h-0007 FFFFh, 4 bank) |
| 90 0000h | ROM Cartridge (4 Bank Switch) |
| A0 0000h | - |
| A1 30ECh | Super 32X ID "MARS" |
| A1 30F0h | Bank Set Register |
| A1 5100h | Super 32X SYS REG |
| A1 5180h | VDP REG |
| A1 5200h | Color Palette |
| A1 5400h | - |
| 100 0000h | See MD Manual |

### ROM Access When Using the 32X

- The 68000 vector area (00 0000h - 00 00FFh) is assigned by the custom built-in ROM
- ROM contents are at 88 0200h, 88 0206h, 88 020Ch... (6-byte JUMP commands arranged into a jump table)
- Only when the RV (ROM to VRAM DMA) bit is 1 is 100h - 3F FFFFh assigned by the cartridge ROM
- When RV bit is 0, access from 88 0000h - 9F FFFFh goes to the cartridge ROM
- 88 0000h - 8F FFFFh is allocated by fixing 00 0000h - 7F FFFFh (4Mbit) of the cartridge ROM
- In 90 0000h - 9F FFFFh, a cartridge area of 32Mbits is divided into 4 banks and accessed by the bank set register
- When the 68000 and SH2 access the same area at the same time, the SH2 has priority

### Access to the 32X VDP

The FM (VDP access authorization) bit must be 0 before the MEGA Drive can access the Mars frame buffer, overwrite images, VDP register, or color palette. When the bit is 1, reads are undefined and writes are ignored. Color palette access is words only, not bytes.

### SH2 Memory Map

The 32X has two SH2 chips mounted to a common bus. Memory maps of the two chips are the same. The SH2 has built-in cache memory for increasing the speed of command and data accessing.

#### Cache Address Mapping

| Cache Address | Cache Through Address | Contents |
|--------------|----------------------|----------|
| 0000 0000h | 2000 0000h | Boot ROM |
| 0000 4000h | 2000 4000h | Super 32X SYS REG |
| 0000 4100h | 2000 4100h | VDP REG |
| 0000 4200h | 2000 4200h | Color Palette |
| 0000 4400h | 2000 4400h | - |
| 0200 0000h | 2200 0000h | SDRAM |
| 0240 0000h | 2240 0000h | - |
| 0400 0000h | 2400 0000h | ROM Cartridge |
| 0402 0000h | 2402 0000h | Frame Buffer |
| 0404 0000h | 2404 0000h | Overwrite Image |
| 0600 0000h | 2600 0000h | - |
| 0604 0000h | 2604 0000h | - |
| 0800 0000h | 2800 0000h | - |

**Notes:**
- Cannot be accessed when FM = 0 (Frame Buffer and Overwrite Image)
- Color palette can access only in words
- Cannot be accessed when RV = 1 (ROM Cartridge)
- 4-word write FIFO available for Frame Buffer and Overwrite Image

### Cache Area Access

Cache memory is used for rapidly supplying commands, operands, and data to the CPU. In 32X, after commands and data are loaded into SDRAM, cache access is performed. The 32X system register and VDP register must be cache-through accessed because values can be replaced through the VDP or other CPU and the contents of the cache can no longer be guaranteed.

### Cartridge ROM Access

Only when the RV (ROM to VRAM DMA) bit is 0 can SH2 access the cartridge ROM. When the RV bit is 1 and SH2 accesses the cartridge ROM, a wait occurs until 68000 replaces the RV bit with 0. The RV bit from SH2 can only be read.

### 32X VDP Access

Only when the FM (VDP access authorization) bit is 1 can the frame buffer, overwrite images, VDP register, and color palette be accessed from the SH2 side. When the FM bit is 0, read is undefined and write is ignored. The color palette can access only in words but not in bytes.

The frame buffer and overwrite image have 4-word write FIFO and can write in 3 clock cycles. Five clock cycles are required when continuously writing 4 words or more.

---

## 3.2 Registers

32X registers are classified as shown below.

### 32X System Register [MEGA Drive]

- **Adapter control register** - Able to use 32X
- **Interrupt control register** - Issues interrupt for SH2
- **Bank set register** - ROM cartridge bank switching
- **DREQ control register** - Transfers data to SH2 DMAC
- **68 to SH DREQ Source Address register**
- **68 to SH DREQ Destination Address register**
- **68 to SH DREQ Length register**
- **FIFO register**
- **SEGA TV register** - Register signal output to cartridge register
- **Communication port register** - Communication in both directions with SH2
- **PWM Control register** - Control of PWM Sound Source
- **Cycle register**
- **L ch pulse width register**
- **R ch pulse width register**
- **Mono pulse width register**

### 32X System Register [SH2]

- **Interrupt mask register** - Interrupt control for SH2
- **H Count register**
- **VRES interrupt clear register**
- **V interrupt clear register**
- **H interrupt clear register**
- **CMD interrupt clear register**
- **PWM interrupt clear register**
- **Standby changer register** - 32X custom component activation
- **DREQ control register** - MEGA Drive data received by DMAC of SH2
- **68 to SH DREQ Source Address register**
- **68 to SH DREQ Destination Address register**
- **68 to SH DREQ Length register**
- **FIFO register**
- **SEGA TV register**
- **Communication port register**
- **PWM Control register**
- **Cycle register**
- **L ch pulse width register**
- **R ch pulse width register**
- **Mono pulse width register**

### VDP Register

- **Bitmap Mode register** - Display mode selection, Frame buffer switch
- **Frame buffer control register**
- **Screen shift control register** - Screen shift
- **Auto Fill Length register** - Data fill for frame buffer
- **Auto Fill Start Address register**
- **Auto Fill Data register**

---

## 3.2.1 System Registers [MEGA Drive side]

### Adapter Control Register (Access: Byte/Word)

**Address:** A1 5100h

| Bit | 15-8 | 7 | 6 | 5-2 | 1 | 0 |
|-----|------|---|---|-----|---|---|
| Field | - | FM | - | - | REN/RES | ADEN |
| R/W | Read only | R/W | - | - | R/W | R/W |

**FM: VDP Access Authorization**
- 0: MD (Initial value)
- 1: SH2

**REN: SH2 Reset Enable**
- 0: Disable
- 1: Enable

**RES: Resets SH2**
- 0: Reset
- 1: Cancel reset (initialization by initial program, change not allowed)

**ADEN: Adapter Enable Bit**
- 0: Prohibits use of 32X
- 1: Permits use of 32X (initialization by initial program, change not allowed)

**Important:** Switching access authorization is done while writing to the FM bit. Be aware that if writing to the FM bit is done by MEGA Drive while SH2 accesses VDP, access authorization is forced to switch to MEGA Drive.

### Interrupt Control Register (Access: Byte/Word)

**Address:** A1 5102h

| Bit | 15-2 | 1 | 0 |
|-----|------|---|---|
| Field | - | INTS | INTM |
| R/W | - | R/W | R/W |

**INTS: Slave SH2 Interrupt command**
- 0: NO OPERATION (initial value)
- 1: Interrupt command

**INTM: Master SH2 interrupt command**
- 0: NO OPERATION (initial value)
- 1: Interrupt command

Both are automatically cleared if SH2 does not interrupt clear.

### Bank Set Register (Access: Byte/Word)

**Address:** A1 5104h

| Bit | 15-2 | 1 | 0 |
|-----|------|---|---|
| Field | - | BK1 | BK0 |
| R/W | - | R/W | R/W |

**Bank Selection:**

| BK1 | BK0 | Data seen in 90 0000h - 9F FFFFh |
|-----|-----|----------------------------------|
| 0 | 0 | 00 0000h - 0F FFFFh (initial value) |
| 0 | 1 | 10 0000h - 1F FFFFh |
| 1 | 0 | 20 0000h - 2F FFFFh |
| 1 | 1 | 30 0000h - 3F FFFFh |

### DREQ Control Register (Access: Byte/Word)

**Address:** A1 5106h

| Bit | 15-3 | 2 | 1 | 0 |
|-----|------|---|---|---|
| Field | - | FULL | RV | 68S |
| R/W | - | Read only | R/W | R/W |

**FULL: DMA FIFO Full**
- 0: Can write
- 1: Cannot write

**RV: ROM to VRAM DMA**
- 0: NO OPERATION (initial value)
- 1: DMA Start Allowed

The SH2 side cannot access the ROM when RV = 1. Waits until value becomes 0 (RV = 0) before accessing.

**68S: Mode**
- 0: No Operation
- 1: CPU Write (68K writes data in FIFO)

The internal system starts operation when 68S is 1. Writing 0 force-ends the operation. It is automatically set to 0 after DMA ends.

### 68K to SH DREQ Source Address Register (Access: Word)

**Address:** A1 5108h (High Order), A1 510Ah (Low Order, bit 0)

Because the DREQ circuit does not use this data, nothing needs to be set at the time of CPU WRITE.

### 68K to SH DREQ Destination Address Register (Access: Word)

**Address:** A1 510Ch (High Order), A1 510Eh (Low Order, bit 0)

Sets the SH2 side (SDRAM) address. The DREQ circuit does not use this data. When the destination address is known beforehand by SH2, or when SH2 doesn't need to know, no settings are needed.

### 68K to SH DREQ Length Register (Access: Word)

**Address:** A1 5110h

| Bit | 15 | 14-2 | 1-0 |
|-----|-----|------|-----|
| Field | 0 | Length | 0 |
| R/W | - | R/W | - |

Sets the number of data items (unit: word) to be sent to SH2 side. The value to be set is in 4-word units. Low order 2 bits write is ignored (00 fixed). Be sure to set this register for CPU WRITE. At each transfer, this register is decremented and when it becomes 0, the DREQ operation ends. Transfer is done 65,536 times when 0 is set. Read time reads the actual count value.

### FIFO Register (Access: Word)

**Address:** A1 5112h

Data is written to this register when DREQ is used by CPU WRITE.

### SEGA TV Register (Access: Byte/Word)

**Address:** A1 511Ah

| Bit | 15-1 | 0 |
|-----|------|---|
| Field | - | CM |
| R/W | - | R/W |

**CM: Cartridge Mode**
- 0: ROM (initial value)
- 1: DRAM

This is a SEGA TV exclusive register; use of this bit with other applications is prohibited.

### Communication Port (Access: Byte/Word)

**Addresses:** A1 5120h, A1 5122h, A1 5124h, A1 5126h, A1 5128h, A1 512Ah, A1 512Ch, A1 512Eh

This is an 8-word bi-directional register. Read/write is possible from the MEGA Drive and SH2 directions, but when writing the same register from both at the same time, the value of that register becomes undefined. Caution is advised.

### PWM Control Register (Access: Byte/Word)

**Address:** A1 5130h

| Bit | 15-12 | 11-8 | 7 | 6-4 | 3-0 |
|-----|-------|------|---|-----|-----|
| Field | - | TM3-0 | RTP | - | RMD0, RMD1, LMD0, LMD1 |
| R/W | Read only | R/W | R/W | Read only | R/W |

**TM3-0: PWM timer interrupt interval**

**RTP: DREQ1 occurrence enable (SH2 side only)**
- 0: OFF (initial value)
- 1: ON

**Output Configuration:**

| LMD0 | LMD1 | OUT | RMD0 | RMD1 | OUT |
|------|------|-----|------|------|-----|
| 0 | 0 | OFF | 0 | 0 | OFF |
| 0 | 1 | R | 0 | 1 | L |
| 1 | 1 | Not allowed | 1 | 1 | Not allowed |

Both cannot be set to L ch or R ch.

### Cycle Register (Access: Byte/Word)

**Address:** A1 5132h

The base clock frequency of the cycle registers are fixed respectively:
- **NTSC:** 23.01MHz (set value × Scyc becomes the cycle)
  - Scyc = 1/23.01 [MHz]
- **PAL:** 22.8MHz (set value × Scyc becomes the cycle)
  - Scyc = 1/22.8 [MHz]

The cycle counter does not operate when both L ch and R ch are off.

### L ch Pulse Width Register (Access: Byte/Word)

**Address:** A1 5134h

| Bit | 15 | 14 | 13-12 | 11-0 |
|-----|-----|-----|-------|------|
| Field | FULL | EMPTY | - | Pulse Width |
| R/W | Read only | Read only | - | Write only |

The value set by bit 11-0 × Scyc becomes the pulse width.

**FULL: Conditions of pulse width FIFO**
- 0: Space available
- 1: No space available

**EMPTY: Conditions of pulse width FIFO**
- 0: Data per FIFO
- 1: No data per FIFO

### R ch Pulse Width Register (Access: Byte/Word)

**Address:** A1 5136h

See explanation of L ch pulse width register.

### Mono Pulse Width Register (Access: Byte/Word)

**Address:** A1 5138h

See explanation of L ch pulse width register. If writing to this register, the same value is written to both L ch and R ch.

**Note:** Bits D0-D11 of all L ch, R ch, and MONO pulse width registers are write only. When read is performed, undefined data is read. Each PWM of L ch and R ch have three separate FIFO steps. When both L and R channels are off, because the cycle counter does not operate, once the FULL bit is set to 1, it will not become 0 as long as the channels are not turned on. When either L or R channel is on, because the OFF side FIFO is also operating, no sound will be output; however, data within FIFO will disappear. If writing when FIFO is FULL, the oldest data is discarded and shift occurs one item at a time.

---

## 3.2.2 System Registers [SH2 side]

### Interrupt Mask Register (Access: Byte/Word)

**Address:** 2000 4000h

| Bit | 15 | 14-10 | 9 | 8 | 7 | 6-4 | 3 | 2 | 1 | 0 |
|-----|-----|-------|---|---|---|-----|---|---|---|---|
| Field | FM | - | ADEN | CART | HEN | - | V | H | CMD | PWM |
| R/W | Read only | - | R/W | Read only | R/W | - | R/W | R/W | R/W | R/W |

**FM: VDP Access Authorization**
- 0: MEGA DRIVE (initial value)
- 1: SH2

**ADEN: Adapter enable bit**
- 0: The 32X use prohibited
- 1: The 32X use allowed

**CART: Cartridge insert condition**
- 0: Inserted
- 1: Not inserted

**HEN: H INT approval within V Blank**
- 0: H INT not approved (initial value)
- 1: H INT approved

**V: V INT Mask**
- 0: Mask (initial value)
- 1: Valid

**H: H INT Mask**
- 0: Mask (initial value)
- 1: Valid

**CMD: Command Interrupt Mask**
- 0: Mask (initial value)
- 1: Valid

**PWM: PWM timer interrupt mask**
- 0: Mask (initial value)
- 1: Valid

This register is mapped to the same address for both SH2 master and slave. However, V, H, CMD, and PWM each possess exclusive addresses on the master side and the slave side. Other bits are common to both master and slave. **Important:** If a 1 is written to the FM bit, access authorization is forced to switch to the SH2 side, even if access of VDP is in progress on the MEGA Drive side.

### H Count Register (Access: Byte/Word)

**Address:** 2000 4004h

Sets H Int occurrence interval. Designates by the number of lines. 0 = each line (initial value).

### VRES Interrupt Clear Register (Access: Word)

**Address:** 2000 4014h

Clears VRES interrupt (interrupt caused by pressing the MEGA Drive reset button). If not cleared, interrupt will no longer occur.

### V Interrupt Clear Register (Access: Word)

**Address:** 2000 4016h

Clears V interrupt. If not cleared, interrupt will no longer occur.

### H Interrupt Clear Register (Access: Word)

**Address:** 2000 4018h

Clears H interrupt. If not cleared, interrupt will no longer occur.

### CMD Interrupt Clear Register (Access: Word)

**Address:** 2000 401Ah

Clears CMD interrupt (command interrupt). If not cleared, interrupt will no longer occur.

### PWM Interrupt Clear Register (Access: Word)

**Address:** 2000 401Ch

Clears PWM interrupt (command interrupt). If not cleared, interrupt will no longer occur.

### Points to Be Aware of Concerning Interrupts

1. **32X Interrupt Types:** VRESINT, VINT, HINT, CMDINT, and PWMINT
   - **CMDINT differs from other interrupts:**
     - **VRES INT, VINT, HINT, PWMINT:** INT continues to occur until each INT is cleared
     - **CMDINT:** INT is negated. But when CMDINT is enabled after CMDINT is not received, CMDINT is again asserted.

2. **HEN (HINT authorization bit during V Blank)** inside the interrupt mask register of SH2 is common in both Master and Slave. The HINT occurrence interval is affected by this HEN bit.

3. The value set in the H Count register is enabled as the next H Blank occurs, after being loaded in the internal counter when H Blank is negated. The internal counter generates HINT as a result of the count, but when H Blank is negated the H Count register value is reloaded. Therefore, when the H Count register is set when H Blank does not occur (because it is not loaded in the internal counter until the next H Blank occurs), HINT may occur according to the value prior to setting the H Count.

**Examples:**
1. When H Count register = 0, 1 is set in the H Count register during H Blank. When HEN = 0, HINT occurs within the second H Blank after the existing H Blank is negated.

2. H Count register = 0 and H Count is set to 1 when H Blank does not occur. When HEN = 0, HINT occurs during the next H Blank. HINT occurs during the 2nd H Blank after the H Blank is negated because the H Count register setting (value) is loaded in the internal counter when this H Blank is negated.

### StandBy Changer Register (Access: Word)

**Address:** 2000 4002h

Use with system (Boot ROM). Access to this register from the application is prohibited.

### DREQ Control Register (Access: Byte/Word)

**Address:** 2000 4006h

| Bit | 15 | 14 | 13-2 | 1 | 0 |
|-----|-----|-----|------|---|---|
| Field | FULL | EMPTY | - | 68S | RV |
| R/W | Read only | Read only | - | Read only | Read only |

**FULL: Frame Buffer, Write Cache Full**
- 0: Space
- 1: No Space

**EMPTY: Frame Buffer, Write Cache Empty**
- 0: Data
- 1: No Data

See explanation of MEGA Drive register for more.

### 68K to SH DREQ Source Address Register (Access: Word)

**Address:** 2000 4008h (High Order), 2000 400Ah (Low Order, bit 0)

See explanation of MEGA Drive register.

### 68K to SH DREQ Destination Address Register (Access: Word)

**Address:** 2000 400Ch (High Order), 2000 400Eh (Low Order, bit 0)

See explanation of MEGA Drive register.

### 68K to SH DREQ Length Register (Access: Word)

**Address:** 2000 4010h

See explanation of MEGA Drive register.

### FIFO Register (Access: Word)

**Address:** 2000 4012h

See explanation of MEGA Drive register.

### Communication Port Register (Access: Byte/Word)

**Addresses:** 2000 4020h, 2000 4022h, 2000 4024h, 2000 4026h, 2000 4028h, 2000 402Ah, 2000 402Ch, 2000 402Eh

See explanation of MEGA Drive register.

### PWM Control Register (Access: Byte/Word)

**Address:** 2000 4030h

See explanation of MEGA Drive register.

TM0-3 set the PWM timer interrupt interval and ROM to PWM transfer cycle. Interrupt occurs by cycle register set value × TM cycle. When TM = 1, the interval is the same as the cycle register. When TM = 0, the interval is 16 times the cycle register.

### Cycle Register (Access: Byte/Word)

**Address:** 2000 4032h

See explanation of MEGA Drive register.

### L ch Pulse Width Register (Access: Byte/Word)

**Address:** 2000 4034h

See explanation of MEGA Drive register.

### R ch Pulse Width Register (Access: Byte/Word)

**Address:** 2000 4036h

See explanation of MEGA Drive register.

### Mono Pulse Width Register (Access: Byte/Word)

**Address:** 2000 4038h

See explanation of MEGA Drive register.

---

## 3.2.3 VDP Registers (Both MEGA Drive and SH2 Common)

### Bitmap Mode Register (Access: Byte/Word)

**MD Side:** A1 5180h
**SH Side:** 2000 4100h

| Bit | 15 | 14 | 13 | 12-8 | 7 | 6-2 | 1 | 0 |
|-----|-----|-----|-----|------|---|-----|---|---|
| Field | PAL | - | PRI | - | 240 | - | M1 | M0 |
| R/W | Read only | - | R/W | - | R/W | - | R/W | R/W |

**PAL: TV format**
- 0: PAL
- 1: NTSC

Switching is possible only during V Blank.

**PRI: Screen priority**
- 0: MEGA Drive has priority (initial value)
- 1: 32X has priority

Switching is always allowed, but is valid from the next line.

**240: 240 Line Mode** (Valid only when PAL)
- 0: 224 Line (initial value)
- 1: 240 Line

**Mode Selection:**

| M1 | M0 | Mode |
|----|-----|------|
| 0 | 0 | Blank Mode (initial value) |
| 0 | 1 | Packed Pixel Mode |
| 1 | 0 | Direct Color Mode |
| 1 | 1 | Run Length Mode |

Switching is always allowed, but is valid from the next line.

### Frame Buffer Control Register (Access: Byte/Word)

**MD Side:** A1 518Ah
**SH Side:** 2000 410Ah

| Bit | 15 | 14 | 13 | 12-2 | 1 | 0 |
|-----|-----|-----|-----|------|---|---|
| Field | VBLK | HBLK | PEN | - | FEN | FS |
| R/W | Read only | Read only | Read only | - | R/W | R/W |

**VBLK: V Blank**
- 0: During display period
- 1: During V Blank

**HBLK: H Blank**
- 0: During display period
- 1: During H Blank

**PEN: Palette Access Approval**
- 0: Access denied
- 1: Access approved

**FEN: Frame Buffer Authorization**
- 0: Access approved
- 1: Access denied

**FS: Frame Buffer Swap**
- 0: Transfers DRAM0 to VDP side (initial value)
- 1: Transfers DRAM1 to VDP side

Swapping the Frame Buffer is allowed during V Blank (VBLK = 1) or when in blank mode. However, writing the FS bit is always allowed, and when written during display, swapping is done at the next V Blank. With respect to read, the value which indicates DRAM during display until the next V Blank is returned.

When having swapped the Frame Buffer, be sure to access the Frame Buffer after confirming that VBLK = 1 or FS bit has changed.

When having performed FILL, be sure to access the Frame Buffer after confirming that FEN is equal to 0.

Palette access is possible only during H and V blank.

Palette can access whenever the bitmap mode is in the direct color mode, as well as during Blank.

### Screen Shift Control Register (Access: Byte/Word)

**MD Side:** A1 5182h
**SH Side:** 2000 4102h

| Bit | 15-1 | 0 |
|-----|------|---|
| Field | - | SFT |
| R/W | - | R/W |

**SFT: Screen 1 dot left shift**
- 0: OFF
- 1: ON

Switching is allowed at any time, but is valid from the next line.

### Auto Fill Length Register (Access: Byte/Word)

**MD Side:** A1 5184h
**SH Side:** 2000 4104h

Word length when filling DRAM (frame buffer). To set this value, set the value for the to-be-filled word length (0-255).

**Note:** The Auto Fill function will be explained later.

### Auto Fill Start Address Register (Access: Word)

**MD Side:** A1 5186h
**SH Side:** 2000 4106h

| Bit | 16 | 15-9 | 8-1 |
|-----|-----|------|-----|
| Field | A16 | A15-A9 | A8-A1 |
| R/W | R/W | R/W | R/W |

Sets the start address of the area to be filled. A16-A9 remains as fixed, but A8-A1 are incremented at each Fill.

### Auto Fill Data Register (Access: Word)

**MD Side:** A1 5188h
**SH Side:** 2000 4108h

Sets data to be filled. The Fill operation begins when setting this register.

---

## 3.3 VDP

32X VDP controls the color display and has two 1 Mbit frame buffer surfaces for control display screens. Display (to the display screen) is synthesized and composed contextually of a single screen (plane) from these screens and the existing MEGA Drive screen.

### Display Mode

Enables output of images that correspond to the NTSC format (Japan, USA) and the PAL format (Western Europe). When the 32X image output is not blank, the MEGA Drive display mode should select a resolution that is equal to the 32X resolution.

#### Display Mode Possible Combinations

| 32X | MD |
|-----|-----|
| **Non-blank Graphic V**<br>320 × 224 pixels | 40 × 28 cells (320 × 224 pixels) |
| **Non-blank Graphic V**<br>320 × 240 pixels | 40 × 30 cells (320 × 240 pixels) |
| **Blank** | Graphics IV 32 × 28 (256 × 192 pixels)<br>Graphics V 32 × 28 cells (256 × 224 pixels)<br>40 × 28 cells (320 × 224 pixels)<br>32 × 30 cells (256 × 240 pixels)<br>40 × 30 cells (320 × 240 pixels) |

### VDP Configuration

VDP is mapped from SH2 address 2000 4100h and 2400 0000h. These exist as I/O devices for the CPU. As a result, accessing without the color palette is only a cache-through address.

#### VDP Memory Map

| SH (cache-through) | Component |
|-------------------|-----------|
| 2000 4100h | VDP Register - Bitmap mode |
| 2000 4102h | Screen Shift Control |
| 2000 4104h | Auto Fill Length |
| 2000 4106h | Auto Fill Start Address |
| 2000 4108h | Auto Fill Data |
| 2000 410Ah | Frame Buffer Control |
| 2000 410Ch | Reserve |
| 2000 4200h | Color Palette |
| 2000 4400h | - |
| 2400 0000h | DRAM (1Mbit) |
| 2402 0000h | Over Write Image |
| 2404 0000h | - |

### VDP Register

The VDP register controls RAM block access, the VDP mode, priority, etc. The VDP register is read to the VDP display circuit when a horizontal return line is complete. Consequently, after the register is set, the settings from the next line become valid for the bitmap mode and screen shift control.

### Color Palette

The color palette is a RAM block that designates display colors. A cache address is possible. This block must always be word accessed.

### DRAM

Also called a frame buffer, DRAM stores line tables and bit pattern data for each line. Mapping is done for either DRAM0 or DRAM1. This block can write 8-bit or 16-bit widths. Write speeds are all the same, but 0 cannot be written in byte access.

### Over Write Image

Data write can also be done from this area to the frame buffer. Because there is specialization in character overwrite, if the significant or insignificant byte of data is 0 when accessing by word, only that part ignores overwrite and holds the original value. This block can write in 8-bit or 16-bit widths. Write speeds are all the same, but 0 cannot be written in byte access.

### Switching Frame Buffers

By switching the FS bit, the DRAM drawn previously by the CPU is transferred to the VDP and the contents are displayed. In addition, DRAM that has been displayed is mapped instead in the address space, allowing the draw. For instance, animation can be displayed repeatedly per each single frame (1/60 sec), and for the period equivalent to a single frame (1/60 sec), write process can continue. Frame buffer can be switched only in VBlank. During display, even when writing to the FS bit, the buffer does not switch until VBlank occurs. The FS bit, when read, returns the buffer selected on the current display side. DRAM access should take place after confirming that VBLK=1, or the FS bit has been switched.

### Color Palette

There is one DRAM0 and DRAM1 common color palette in the 32X, and 0-255 palette code can be specified per each pixel. The color data format is 16-bit:

**Color Format:**
- **Bit 15:** Through bit (priority)
- **Bits 14-10:** Blue (5 bits, 32 tones, 1Fh max to 00h min)
- **Bits 9-5:** Green (5 bits, 32 tones, 1Fh max to 00h min)
- **Bits 4-0:** Red (5 bits, 32 tones, 1Fh max to 00h min)
- **Total:** 32 × 32 × 32 = 32,768 colors

The color for each pixel can be directly selected (when in direct color mode), but data size can be kept down by indirect-selecting using the 8-bit palette code.

**Note:** Palette access is possible when PEN = 1 (Frame Buffer Control Register). If accessing when PEN = 0, wait is held until PEN = 1. Also, when PEN goes from 1 to 0, the written value is not guaranteed. When the color is directly selected, color palette can always be accessed.

### Over Write Image

Allows RAM block that is physically identical to the DRAM area to be accessed from this area. When writing data from this area, data on the frame buffer is not changed and remains in its original state when 00h is written in 1 byte units.

### Overview of Display Specifications

| Feature | Specification |
|---------|--------------|
| **Display Size** | 320 pixels × 224 pixels or 320 pixels × 240 pixels (non-interlace mode only) |
| **Display Colors** | 32,768 color direct or 256 colors from 32,768 colors (color palette) |
| **Frame Buffer** | 1Mbit DRAM × 2 (Line Table Format) |
| **Draw Modes** | Direct Color Mode (16 bit/1 pixel, 32K color direct)<br>Packed Pixel Mode (8 bits/1 pixel, 256 of 32K colors)<br>Run Length Mode (16 bits/continuous same color pixels, 256 of 32K colors) |
| **Priority** | Combine with MEGA Drive screen<br>32X screen is synthesized in front or back of MD scroll A, B, and sprites |
| **Other** | Supports DRAM FILL at VDP side |

### Line Table Format

There are 256 words in the line table in the frame buffer lead. When writing an address in which pixel data for each line is entered, that line is displayed. The data format following that address can select three modes. Mode selection is set by combining VDP register bits M1 and M0.

**Mode Selection:**
- (M1, M0) = (0, 0): Blank display
- (M1, M0) = (0, 1): Packed pixel mode
- (M1, M0) = (1, 0): Direct color mode
- (M1, M0) = (1, 1): Run length mode

**Display Precautions:** VDP mechanically displays 320 pixels worth of data from the address specified per the line table. Consequently, caution is required since the overwrite image area data is displayed as is when there is no DRAM area for 320 pixels worth of data after the specified address.

### Priority

Select whether or not to use the PRI bit of the VDP register, and whether the 32X is to be displayed in front of or behind the MD screen. Also, each through-bit (1-bit) is added to the color data. If the PRI bit is used, the pixel that designated the color is displayed in the side opposite of the MD screen. When the MD color code is 0, and when the 32X designates blank by the VDP register, each becomes transparent and the MD background is displayed.

### Direct Color Mode

This mode directly expresses data of each line from the pixel in the left corner of the screen by each through bit B, G, R (16-bit). From the size of the frame buffer at 320 words per 1 line:

1 Mbit = 65,536 words = 256 words + 320 × 204 words

Only 204 lines can be displayed. The number of lines can be increased by making identical line data to be common.

### Packed Pixel Mode

This mode indirectly expresses data of each line by individual color palette codes (8-bit) from pixels in the left corner of the screen.

Since two pixels are expressed by 1 word, and 1 line contains 160 words:

1 Mbit = 65,536 words = 256 words + 160 × 408 words

It is possible to have 408 lines of display data.

### Screen Shift Control

Because of word units, address data that can be set in the line table can change the table only in 2-dot units when in the packed pixel mode. As a result, use the screen shift control bit (SFT) to change the display position by 1-dot units for horizontal scrolling.

### Run Length Mode

In this mode, pixel data is handled in units as the same colors that continue horizontally, and is represented in palette code (8-bit) and continuing number of pixels = run length data (8-bit). Through-bits are valid in this mode as well. When the run length exceeds 320 pixels for one line of data, the 320 pixels are displayed from the left, and all pixels thereafter are ignored.

### FILL Function

Auto Fill uses three registers: the start address, word length, and fill data. VDP begins the fill operation when writing to the fill data register. The portion that exceeds the page border is filled from the start of the page. Because VDP and SH2 DRAM accesses conflict while executing Auto Fill, do not access from SH2.

**Fill execution time** = 7 + 3 × length (cycle)

After executing Auto Fill, DRAM should be accessed after confirming that VDP register FEN = 0 (completion of frame buffer access via VDP).

### Clock Used by the 32X

The master clocks for NTSC and PAL used by the MEGA Drive and 32X are different.

**Mega Drive Master Clock Cycle:**
- Mck = 1/fosc [sec]
- **NTSC:** fosc = 53.693175 [MHz]
- **PAL:** fosc = 53.203424 [MHz]

**68000 Clock Cycle:**
- Vclk = 7Mck (where Mck is the value above)

**SH2 Clock Cycle:**
- Sclk = Vclk/3 (where Vclk is the value above)

### HBlank and Display Periods

- **A: Blank Period** - 100 dot (860 Mck)
- **B: Display Period** - 320 dot (2560 Mck)
- **C: HBLANK - VBLANK** - 27 dot (224 Mck)
- **D: HBLANK - XHDISP** - 3 dot (24 Mck)

### VBlank and Display Periods

|  | NTSC | PAL (224) | PAL (240) |
|---|------|-----------|-----------|
| **A: Blank Period** | 38h | 89h | 73h |
| **B: Display Period** | 224h | 224h | 240h |

### VDP Register Latch Timing

- **A: H Blank - PEN** - 3 dot (24 Mck)
- **B: FEN Width** - 40 Sclk (VDP side refresh)
- **C: H Blank - latch** - 76 dot (668 Mck)

The register set within interval C is valid at line n (the nth line), and for interval D is valid at line n+1. Please avoid the type of phenomenon in which the VDP register latch and CPU register access overlap. When the DRAM is being refreshed FEN is 1, but access of the DRAM is possible. Be aware that if 1 is set in 240 bits when in the NTSC mode VDP will have operating errors.

---

## 3.4 PWM

### PWM Sound Source

32X outputs a 2 ch pulse wave as a sound source. The integrated wave form converts the pulse width to wave height. A variety of sounds can be produced by continuously changing the pulse width.

### Functions of 32X PWM

There are five registers within the SYS REG for controlling PWM of the 32X (see section 3.2). It is possible to access from both the SH2 and the MEGA Drive. Since any register can be accessed in bytes, the MEGA Drive side can switch banks and be accessed from the 68000 or Z80.

**Register Addresses:**

| MD side | SH side | Register |
|---------|---------|----------|
| A1 5130h | 2000 4030h | PWM Control |
| A1 5132h | 2000 4032h | Cycle Register |
| A1 5134h | 2000 4034h | L ch Pulse Width |
| A1 5136h | 2000 4036h | R ch Pulse Width |
| A1 5138h | 2000 4038h | Mono Pulse Width |

---

*[Document continues but was truncated in the original message]*
