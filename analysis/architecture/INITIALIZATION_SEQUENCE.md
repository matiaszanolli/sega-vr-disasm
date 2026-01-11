# Virtua Racing Deluxe - Initialization Sequence Analysis

**Last Updated**: 2026-01-06
**Analyst**: Systematic reverse engineering effort
**Goal**: Complete understanding of boot process and system initialization

---

## Table of Contents
1. [Boot Sequence Overview](#boot-sequence-overview)
2. [Initial Program Counter (0x3F0)](#initial-program-counter-0x3f0)
3. [MARS Security Check](#mars-security-check)
4. [32X Register Initialization](#32x-register-initialization)
5. [Memory Map Setup](#memory-map-setup)
6. [SH2 Initialization](#sh2-initialization)
7. [Interrupt Handler Setup](#interrupt-handler-setup)

---

## Boot Sequence Overview

### Entry Point
- **Initial SP**: `$01000000` (16MB boundary - 32X SDRAM region)
- **Initial PC**: `$000003F0` (ROM offset 0x3F0)
- **ROM Base**: `$00880000` (from memory map)

### Boot Flow
```
Power On → ROM Header Loaded → CPU Jumps to $880003F0
    ↓
MARS Security Check ($8803C0)
    ↓
32X Register Init ($A10000+)
    ↓
Copy Init Code to RAM ($FF0000)
    ↓
Jump to RAM and continue init
    ↓
Start SH2 Processors
    ↓
Setup Interrupt Handlers
    ↓
Enter Main Loop
```

---

## Initial Program Counter (0x3F0)

### Location in ROM
- **ROM Offset**: `0x0003F0`
- **Execution Address**: `$008803F0` (ROM base + offset)

### Code Analysis (Hex Dump)
```
Offset   Hex Data                          Description
------------------------------------------------------------------------
0x0003F0 28 7C FF FF FF C0                 MOVEA.L #$FFFFFFC0,A4
0x0003F6 23 FC 00 00 00 00 00 A1 51 28    MOVE.L  #$00000000,$00A15128
0x000400 46 FC 27 00                       MOVE.W  #$2700,SR  (Disable interrupts)
0x000404 4B F9 00 A1 00 00                 LEA     $00A10000,A5
0x00040A 70 01                             MOVEQ   #$01,D0
```

### Purpose
1. **Disable Interrupts** (`MOVE.W #$2700,SR`)
   - Sets interrupt priority to 7 (blocks all maskable interrupts)
   - Critical for init sequence stability

2. **Setup Base Registers**
   - A4 = `$FFFFFFC0` (Stack/system pointer)
   - A5 = `$00A10000` (32X system registers base)

3. **MARS Check Preparation**
   - Prepares to read "MARS" signature from ROM
   - Validates 32X hardware presence

---

## MARS Security Check

### MARS String Location
- **ROM Offset**: `0x0003C0`
- **Content**: `"MARS CHECK MODE "` (16 bytes)
- **Followed by**: Security parameters

```
Offset   Hex Data                          ASCII / Description
------------------------------------------------------------------------
0x0003C0 4D 41 52 53 20 43 48 45           "MARS CHE"
0x0003C8 43 4B 20 4D 4F 44 45 20           "CK MODE "
0x0003D0 00 00 00 00                        Security params (0)
0x0003D4 00 02                              ? (value 2)
0x0003D6 00 00                              ? (value 0)
0x0003D8 00 00 00 00                        Reserved
0x0003DC 00 00 C0 00                        ? (value $C000)
```

### Security Check Code
```asm
; Check for "MARS" signature at ROM offset
00880410  0C AD 4D 41 52 53 30 EC    CMPI.L  #$4D415253,(A5)  ; Compare "MARS"
00880418  66 00 03 E6                 BNE     $008807FC        ; Branch if not equal (fail)
```

**Purpose**: Verifies 32X hardware is present by checking for expected ROM signature.
**Failure Action**: Branches to error handler at `$8807FC`.

---

## 32X Register Initialization

### 32X System Register Map
Base Address: `$00A10000` (stored in A5)

| Offset | Register Name         | Purpose                           |
|--------|-----------------------|-----------------------------------|
| $5100  | ADAPTER_CTRL          | 32X adapter control               |
| $5101  | INT_CTRL              | Interrupt control                 |
| $5102  | BANK_SET              | ROM bank switching                |
| $5104  | DREQ_CTRL_FIFO        | DMA request control               |
| $5106  | DREQ_SRC_ADDR_H       | DMA source address (high)         |
| $5108  | DREQ_SRC_ADDR_L       | DMA source address (low)          |
| $510A  | DREQ_DST_ADDR_H       | DMA destination address (high)    |
| $510C  | DREQ_DST_ADDR_L       | DMA destination address (low)     |
| $510E  | DREQ_LEN              | DMA transfer length               |
| $5128  | COMM0-COMM7           | Communication registers (SH2↔68K) |

### Initialization Sequence
```asm
00880418  08 2D 00 07 51 01          BTST    #7,$5101(A5)     ; Wait for adapter ready
0088041E  67 F8                      BEQ     $00880418        ; Loop until bit 7 set

00880420  4A AD 00 08                TST.W   $0008(A5)        ; Check some register
00880424  67 10                      BEQ     $00880436        ; Skip if zero

00880426  4A 6D 00 0C                TST.B   $000C(A5)        ; Check another register
0088042A  67 0A                      BEQ     $00880436        ; Skip if zero

0088042C  08 2D 00 00 51 01          BTST    #0,$5101(A5)     ; Check ADEN (Adapter Enable)
00880432  66 00 03 B8                BNE     $008807EC        ; Branch if enabled
```

**Purpose**:
- Waits for 32X hardware to be ready
- Checks adapter enable status
- Validates register states before proceeding

---

## Memory Map Setup

### Genesis/32X Memory Layout

```
Address Range        Size    Description
------------------------------------------------------------------------
$00000000-$003FFFFF  4MB     ROM (Cartridge, actual size 3MB)
$00400000-$007FFFFF  4MB     Expansion (unused in this game)
$00880000-$008FFFFF  512KB   ROM (32X remapped view)
$00A00000-$00A0FFFF  64KB    Z80 address space
$00A10000-$00A1FFFF  64KB    I/O and control registers
$00C00000-$00DFFFFF  2MB     VDP (Video Display Processor)
$00FF0000-$00FFFFFF  64KB    Work RAM (68000)

32X-Specific Memory:
$20000000-$203FFFFF  4MB     32X ROM (from SH2 perspective)
$22000000-$2203FFFF  256KB   SDRAM (2 Mbit)
$24000000-$2401FFFF  128KB   Frame Buffer
$24020000-$2403FFFF  128KB   Overwrite Image
```

### Code Copy to RAM
```asm
; Setup pointers for RAM copy
008804A0  41 F9 00 00 04 C0          LEA     $000004C0,A0     ; Source (ROM)
008804A6  43 F9 00 FF 00 00          LEA     $00FF0000,A1     ; Dest (RAM)

; Copy 32 bytes (8 longwords)
008804A8  22 D8                      MOVE.L  (A0)+,(A1)+
008804AA  22 D8                      MOVE.L  (A0)+,(A1)+
008804AC  22 D8                      MOVE.L  (A0)+,(A1)+
008804AE  22 D8                      MOVE.L  (A0)+,(A1)+
008804B0  22 D8                      MOVE.L  (A0)+,(A1)+
008804B2  22 D8                      MOVE.L  (A0)+,(A1)+
008804B4  22 D8                      MOVE.L  (A0)+,(A1)+
008804B6  22 D8                      MOVE.L  (A0)+,(A1)+

; Jump to RAM code
008804B8  41 F9 00 FF 00 00          LEA     $00FF0000,A0
008804BE  4E D0                      JMP     (A0)
```

**Purpose**:
- Copies initialization code from ROM to faster Work RAM
- Jumps to RAM to continue execution
- Common technique for faster execution and self-modification

### Code at RAM ($FF0000)
Looking at ROM offset `0x4C0`, this is what gets copied to RAM:
```
0x0004C0  1B 7C 00 01 51 01          MOVE.B  #$01,$5101(A5)   ; Enable adapter
0x0004C6  41 F9 00 00 06 BC          LEA     $000006BC,A0     ; Next init routine
0x0004CC  D1 FC 00 88 00 00          ADDA.L  #$00880000,A0    ; Add ROM base
0x0004D2  4E D0                      JMP     (A0)             ; Jump to it
```

**Analysis**:
- Enables 32X adapter by writing to $A15101
- Calculates address of next init routine
- Continues initialization chain

---

## SH2 Initialization

### SH2 Entry Points (To Be Documented)
The 68000 must tell the SH2s where to start executing. This is done through:
1. Writing entry point addresses to communication registers
2. Triggering SH2 interrupt to start execution

**Status**: Requires further analysis of:
- SH2 Master entry point location in ROM
- SH2 Slave entry point location in ROM
- Communication protocol between 68K and SH2s
- SH2 initialization code

---

## Interrupt Handler Setup

### Exception Vector Table (ROM $200-$3FF)
All exception vectors point to: `$00880832`

### Main Interrupt Handlers
- **V-INT (Vertical Interrupt)**: `$00881684` (Vector 30, offset $78)
- **H-INT (Horizontal Interrupt)**: `$0088170A` (Vector 28, offset $70)

### V-INT Handler Analysis (0x1684)
```asm
00881684  4A 78 C8 7A                TST.W   $C87A            ; Check some flag
00881688  67 26                      BEQ     $008816B0        ; If zero, skip to RTE
0088168A  46 FC 27 00                MOVE.W  #$2700,SR        ; Disable interrupts
0088168E  48 E7 FF FE                MOVEM.L D0-D7/A0-A6,-(SP); Save all registers
...
008816AE  4E 73                      RTE                      ; Return from exception
```

**Purpose**: Main game loop likely called from V-INT (60Hz on NTSC, 50Hz on PAL)

### H-INT Handler Analysis (0x170A)
```asm
0088170A  4E 73                      RTE                      ; Immediate return
```

**Purpose**: Horizontal interrupt currently unused (just returns immediately)

---

## Questions for Further Investigation

1. **SH2 Code Location**: Where in ROM is the SH2 Master/Slave code?
2. **SH2 Entry Points**: What addresses do the SH2s start executing from?
3. **Memory Layout**: What data structures are in RAM at runtime?
4. **V-INT Flag**: What is the flag at $C87A that controls V-INT execution?
5. **Main Loop**: What function is called from V-INT (at offset $0014)?
6. **Communication**: How do 68K and SH2s communicate during gameplay?

---

## Next Steps
1. Disassemble the code copied to RAM ($FF0000)
2. Trace execution from RAM copy to main loop entry
3. Locate SH2 binary code in ROM
4. Analyze SH2 initialization and main loop
5. Map out RAM usage and data structures
6. Document complete control flow

---

**Status**: Initial analysis complete. Ready for deeper dive into specific subsystems.
