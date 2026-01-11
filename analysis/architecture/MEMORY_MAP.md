# Virtua Racing Deluxe - Complete Memory Map

**Last Updated**: 2026-01-06
**Purpose**: Comprehensive documentation of all memory regions, registers, and address spaces

---

## Table of Contents
1. [Address Space Overview](#address-space-overview)
2. [ROM Layout](#rom-layout)
3. [RAM Layout](#ram-layout)
4. [32X Register Map](#32x-register-map)
5. [VDP Register Map](#vdp-register-map)
6. [SH2 Memory View](#sh2-memory-view)

---

## Address Space Overview

### 68000 Address Space (24-bit, 16MB)

```
┌─────────────────────────────────────────────────────────────────┐
│ 68000 CPU Address Space                                         │
├─────────────────┬──────────┬─────────────────────────────────────┤
│ Address Range   │ Size     │ Description                         │
├─────────────────┼──────────┼─────────────────────────────────────┤
│ $000000-$3FFFFF │ 4MB      │ ROM Cartridge Space                 │
│ $400000-$7FFFFF │ 4MB      │ Expansion (unused)                  │
│ $800000-$9FFFFF │ 2MB      │ Reserved                            │
│ $A00000-$A0FFFF │ 64KB     │ Z80 Address Space                   │
│ $A10000-$A1FFFF │ 64KB     │ I/O and Control Registers           │
│ $A20000-$BFFFFF │ ~2MB     │ Expansion                           │
│ $C00000-$DFFFFF │ 2MB      │ VDP (Video Display Processor)       │
│ $E00000-$FEFFFF │ ~1MB     │ Reserved                            │
│ $FF0000-$FFFFFF │ 64KB     │ Work RAM (68000 scratch)            │
└─────────────────┴──────────┴─────────────────────────────────────┘
```

### 32X Extended Addressing
When the 32X adapter is enabled, some addresses are remapped:
- ROM is visible at both $000000 and $880000
- 32X registers overlay at $A15xxx range

---

## ROM Layout

### Physical ROM Structure (3MB = 3,145,728 bytes)

```
┌─────────────────────────────────────────────────────────────────┐
│ ROM Organization (Offset → Execution Address)                   │
├──────────┬─────────────┬──────────────────────────────────────────┤
│ Offset   │ Exec Addr   │ Contents                                 │
├──────────┼─────────────┼──────────────────────────────────────────┤
│ $000000  │ $880000     │ Initial SP (4 bytes)                     │
│ $000004  │ $880004     │ Initial PC (4 bytes)                     │
│ $000008  │ $880008     │ 68K Exception Vectors (62 × 4 = 248)     │
│ $000100  │ $880100     │ Sega Heade

r (256 bytes)                  │
│ $000200  │ $880200     │ 32X Jump Table (512 bytes)               │
│ $0003C0  │ $8803C0     │ MARS Security String                     │
│ $0003F0  │ $8803F0     │ 68K Init Code Start                      │
│ $000800  │ $880800     │ 68K Main Program                         │
│ ~$020000 │ ~$8A0000    │ Data Tables (graphics/sound?)            │
│ ~$024000 │ ~$8A4000    │ Potential SH2 Code Section 1             │
│ ~$2F0000 │ ~$B70000    │ Potential SH2 Code Section 2             │
│ $2FFFFF  │ $A7FFFF     │ End of ROM (last byte)                   │
└──────────┴─────────────┴──────────────────────────────────────────┘
```

### ROM Header Detail ($000100-$0001FF)
```
Offset   Size  Field                Value
──────────────────────────────────────────────────────────────
$000100   16   Console ID           "SEGA 32X U      "
$000110   16   Copyright            "(C)SEGA 1994.SEP"
$000120   48   Domestic Name        "V.R.DX..."
$000150   48   Overseas Name        "V.R.DX..."
$000180   14   Serial Number        "GM MK-84601-00"
$00018E    2   Checksum             $1E4D
$000190   16   I/O Support          "J6              " (6-button pad)
$0001A0    4   ROM Start            $00000000
$0001A4    4   ROM End              $002FFFFF (3MB)
$0001A8    4   RAM Start            $00FF0000
$0001AC    4   RAM End              $00FFFFFF
$0001B0   64   Backup/Modem/Notes   (all spaces - no backup RAM)
$0001F0   16   Region               "U               " (USA)
```

### 32X Jump Table ($000200-$0003FF)
512 bytes of 32X-specific jump table and initialization data.

**Known Entries:**
- Vector 0 (Reset): → $00880838
- Most vectors:     → $00880832 (common exception handler)
- V-INT (Vector 30): → $00881684
- H-INT (Vector 28): → $0088170A

---

## RAM Layout

### 68000 Work RAM ($FF0000-$FFFFFF, 64KB)

```
┌─────────────────────────────────────────────────────────────────┐
│ Work RAM Usage (68000)                                          │
├──────────────┬──────────────────────────────────────────────────┤
│ Address      │ Purpose                                          │
├──────────────┼──────────────────────────────────────────────────┤
│ $FF0000      │ Init Code (copied from ROM $4C0)                 │
│ $FF0020      │ Stack area?                                      │
│ $FF????      │ Game state variables (TBD)                       │
│ $FFC87A      │ V-INT enable flag                                │
│ $FFFFFF      │ End of Work RAM                                  │
└──────────────┴──────────────────────────────────────────────────┘
```

**Notes:**
- During initialization, code from ROM is copied to $FF0000
- RAM is cleared to $00 on startup
- Stack pointer set to $01000000 (32X SDRAM region)

### Z80 RAM ($A00000-$A0FFFF view from 68K, 8KB actual)
Used for sound driver and Z80 program.

---

## 32X Register Map

### Base Address: $A15000 (from 68K perspective)

```
┌─────────────────────────────────────────────────────────────────┐
│ 32X System Registers                                            │
├────────┬─────┬────────────┬─────────────────────────────────────┤
│ Offset │ R/W │ Name       │ Description                         │
├────────┼─────┼────────────┼─────────────────────────────────────┤
│ $5100  │ R/W │ ADAPTER    │ Adapter Control/Status              │
│        │     │            │   Bit 7: FM (Frame Mode)            │
│        │     │            │   Bit 1: ADEN (Adapter Enable)      │
│        │     │            │   Bit 0: REN (ROM Enable)           │
├────────┼─────┼────────────┼─────────────────────────────────────┤
│ $5101  │ R/W │ INTCTL     │ Interrupt Control                   │
│        │     │            │   Bit 7: Adapter Ready              │
│        │     │            │   Bit 0: VINT Pending               │
├────────┼─────┼────────────┼─────────────────────────────────────┤
│ $5102  │ W   │ BANKSET    │ ROM Bank Switching                  │
├────────┼─────┼────────────┼─────────────────────────────────────┤
│ $5104  │ R/W │ DREQ_CTRL  │ DMA Request Control/FIFO            │
│ $5106  │ W   │ DREQ_SRC_H │ DMA Source Address (high)           │
│ $5108  │ W   │ DREQ_SRC_L │ DMA Source Address (low)            │
│ $510A  │ W   │ DREQ_DST_H │ DMA Destination Address (high)      │
│ $510C  │ W   │ DREQ_DST_L │ DMA Destination Address (low)       │
│ $510E  │ W   │ DREQ_LEN   │ DMA Transfer Length                 │
├────────┼─────┼────────────┼─────────────────────────────────────┤
│ $5110  │ R/W │ FIFO_REG   │ FIFO Data Register                  │
├────────┼─────┼────────────┼─────────────────────────────────────┤
│ $5120  │ R/W │ COMM0      │ Communication Register 0 (68K↔SH2)  │
│ $5122  │ R/W │ COMM1      │ Communication Register 1            │
│ $5124  │ R/W │ COMM2      │ Communication Register 2            │
│ $5126  │ R/W │ COMM3      │ Communication Register 3            │
│ $5128  │ R/W │ COMM4      │ Communication Register 4            │
│ $512A  │ R/W │ COMM5      │ Communication Register 5            │
│ $512C  │ R/W │ COMM6      │ Communication Register 6            │
│ $512E  │ R/W │ COMM7      │ Communication Register 7            │
├────────┼─────┼────────────┼─────────────────────────────────────┤
│ $5130  │ R/W │ PWM_CTRL   │ PWM Control Register                │
│ $5132  │ R/W │ PWM_CYCLE  │ PWM Cycle Register                  │
│ $5134  │ R/W │ PWM_LCHPW  │ PWM Left Channel Pulse Width        │
│ $5136  │ R/W │ PWM_RCHPW  │ PWM Right Channel Pulse Width       │
│ $5138  │ R/W │ PWM_MONO   │ PWM Monaural Pulse Width            │
└────────┴─────┴────────────┴─────────────────────────────────────┘
```

### Communication Register Usage
**Purpose**: Allow 68K and SH2 processors to exchange data
- COMM0-COMM7: 8 word-sized registers (16-bit each)
- Shared between all three CPUs (68K, SH2 Master, SH2 Slave)
- Used for synchronization, command passing, and data transfer

---

## VDP Register Map

### Base Address: $C00000 (VDP Data), $C00004 (VDP Control)

Standard Sega Genesis VDP registers, plus 32X enhancements.

**Status**: Requires detailed analysis of video initialization code.

---

## SH2 Memory View

### SH2 Address Space (32-bit addressing)

```
┌─────────────────────────────────────────────────────────────────┐
│ SH2 CPU Address Space (Master & Slave)                         │
├──────────────┬──────────┬─────────────────────────────────────────┤
│ Address      │ Size     │ Description                           │
├──────────────┼──────────┼─────────────────────────────────────────┤
│ $00000000    │ 4KB      │ SH2 Internal Cache/Work RAM           │
│ $00001000    │ ~        │ (varies by SH2 model)                 │
│              │          │                                       │
│ $02000000    │ 256KB    │ Frame Buffer (uncached)               │
│ $02020000    │ 256KB    │ Overwrite Image (uncached)            │
│              │          │                                       │
│ $04000000    │ 256KB    │ Frame Buffer (cached)                 │
│ $04020000    │ 256KB    │ Overwrite Image (cached)              │
│              │          │                                       │
│ $06000000    │ 4MB      │ ROM (cartridge, uncached)             │
│ $06000000    │ 3MB      │ Virtua Racing ROM (actual)            │
│ $0FFFFFFF    │          │ (end of ROM space)                    │
│              │          │                                       │
│ $20000000    │ 4MB      │ ROM (cartridge, cached)               │
│ $20000000    │ 3MB      │ Virtua Racing ROM (actual)            │
│              │          │                                       │
│ $22000000    │ 256KB    │ SDRAM (2 Mbit, uncached)              │
│ $2203FFFF    │          │ End of SDRAM                          │
│              │          │                                       │
│ $24000000    │ 128KB    │ Frame Buffer (direct access)          │
│ $24020000    │ 128KB    │ Overwrite Image (direct access)       │
│              │          │                                       │
│ $26000000    │ ~        │ 32X Registers (SH2 view)              │
│              │          │                                       │
│ $60000000    │ 256KB    │ SDRAM (cached, cache-through)         │
└──────────────┴──────────┴─────────────────────────────────────────┘
```

### SH2 Memory Performance Notes
- **Cached access**: Faster, uses cache lines (good for code/data)
- **Uncached access**: Slower, direct memory access (good for DMA targets)
- **Cache-through**: Writes update both cache and memory

### SH2 SDRAM Usage ($22000000, 256KB)
- Primary working memory for SH2 programs
- Used for 3D transformation matrices
- Used for polygon data structures
- Used for SH2 stack

**Status**: Detailed SDRAM layout requires runtime analysis

---

## Interrupt and Exception Vectors

### 68000 Exception Vectors ($880008-$8800FF)
```
Vector#  Address   Purpose                    Handler
──────────────────────────────────────────────────────────
 0       $880200   Reset SP                   → $880838
 1       $880206   Reset PC                   → $880832
 2       $88020C   Bus Error                  → $880832
 3       $880212   Address Error              → $880832
 4       $880218   Illegal Instruction        → $880832
 ...
28       $880278   Level 4 IRQ (H-INT)        → $88170A
29       $88027E   Level 5 IRQ                → $880832
30       $880284   Level 6 IRQ (V-INT)        → $881684
31       $88028A   Level 7 IRQ (NMI)          → $880832
32-47    $880290   TRAP #0-15                 → $880832
48-63    $8802D0   Reserved                   (zeros)
```

### SH2 Exception Vectors
**Status**: Requires locating SH2 code to analyze vector table

---

## Data Structure Locations (To Be Documented)

### Known Flags and Variables
- **$FFC87A**: V-INT execution flag (checked in V-INT handler)
- **$A15128**: Written during init (unknown purpose)

### To Be Discovered
- Game state structure
- Player car data
- Track data format
- 3D transformation matrices
- Polygon display lists
- Texture data
- Sound driver variables

---

## Next Steps

1. Locate SH2 Master entry point in ROM
2. Locate SH2 Slave entry point in ROM
3. Map SDRAM usage at runtime
4. Document data structure formats
5. Trace main game loop execution
6. Map V-INT handler complete flow

---

**Status**: Foundation complete, detailed mapping in progress
