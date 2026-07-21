# Virtua Racing Deluxe - Complete Memory Map

**Last Updated**: 2026-02-05
**Purpose**: Comprehensive documentation of all memory regions, registers, and address spaces
**Status**: Historical reference; expansion ROM builds, but parallel path is inactive/unvalidated

> **2026-07-21 correction:** `$020/$220` is cartridge ROM; SDRAM is `$060/$260`.
> The old `$2203E000` parameter block and “parallel operational” conclusion are invalid.

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

### Physical ROM Structure (4MB = 4,194,304 bytes)

```
┌─────────────────────────────────────────────────────────────────┐
│ ROM Organization (Offset → SH2 Execution Address)               │
├──────────┬─────────────┬──────────────────────────────────────────┤
│ Offset   │ SH2 Addr    │ Contents                                 │
├──────────┼─────────────┼──────────────────────────────────────────┤
│ $000000  │ $02000000   │ Initial SP (4 bytes)                     │
│ $000004  │ $02000004   │ Initial PC (4 bytes)                     │
│ $000008  │ $02000008   │ 68K Exception Vectors (62 × 4 = 248)     │
│ $000100  │ $02000100   │ Sega Header (256 bytes)                  │
│ $000200  │ $02000200   │ 32X Jump Table (512 bytes)               │
│ $0003C0  │ $020003C0   │ MARS Security String                     │
│ $0003F0  │ $020003F0   │ 68K Init Code Start                      │
│ $000800  │ $02000800   │ 68K Main Program                         │
│ $0234C8  │ $020234C8   │ vertex_transform trampoline (captures params)    │
│ $02046A  │ $0202046A   │ Master dispatch (redirected to $300050)  │
│ ~$024000 │ ~$02024000  │ SH2 Code Section 1                       │
│ ~$2F0000 │ ~$022F0000  │ SH2 Code Section 2                       │
│ $2FFFFF  │ $022FFFFF   │ End of Original ROM                      │
├──────────┼─────────────┼──────────────────────────────────────────┤
│ $300000  │ $02300000   │ **EXPANSION ROM START**                  │
│ $300028  │ $02300028   │ handler_frame_sync (22B)                 │
│ $300050  │ $02300050   │ master_dispatch_hook (44B)               │
│ $300100  │ $02300100   │ vertex_transform_optimized (96B)                 │
│ $300200  │ $02300200   │ slave_work_wrapper (76B)                 │
│ $300280  │ $02300280   │ slave_test_func (44B)                    │
│ $3FFFFF  │ $023FFFFF   │ End of Expansion ROM (1MB)               │
└──────────┴─────────────┴──────────────────────────────────────────┘
```

### Expansion ROM Section ($300000-$3FFFFF)

**CRITICAL**: This section is executed by **SH2 processors ONLY**.
- Contains SH2 code in `dc.w` format (raw 16-bit opcodes)
- Cannot contain 68K assembly mnemonics
- Maps to SH2 address space $02300000-$023FFFFF

**⚠️ RV BIT WARNING**: When 68000 sets RV bit = 1 for ROM→VRAM DMA, SH2 access to this ROM region **BLOCKS** until 68000 clears RV back to 0. If VRD uses ROM DMA during gameplay, critical expansion code should be copied to SDRAM ($0600_0000) at boot to avoid stalls.
- RV bit location: Part of DREQ_CTRL register ($A15106 from 68K side), bit 0
- Impact: All SH2 ROM access (0x0200_0000 - 0x023F_FFFF) waits when RV=1
- Status: **NEEDS VERIFICATION** - check if VRD sets RV=1 during gameplay

| Address | Size | Function | Purpose |
|---------|------|----------|---------|
| $300028 | 22B | `handler_frame_sync` | Frame synchronization |
| $300050 | 44B | `master_dispatch_hook` | Skips COMM7 write for cmd 0x16 |
| $300100 | 96B | `vertex_transform_optimized` | Vertex transform (coord_transform inlined) |
| $300200 | 76B | `slave_work_wrapper` | Command dispatch for Slave SH2 |
| $300280 | 44B | `slave_test_func` | Reads params, calls vertex_transform_optimized |

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

**For detailed register specifications, behavioral hazards, and critical notes, see:**
**[32X_REGISTERS.md](32X_REGISTERS.md)** - Complete register reference with FM bit preemption, COMM port race conditions, and interrupt clearing requirements.

### Base Address: $A15000 (from 68K perspective)

```
┌─────────────────────────────────────────────────────────────────┐
│ 32X System Registers                                            │
├────────┬─────┬────────────┬─────────────────────────────────────┤
│ Offset │ R/W │ Name       │ Description                         │
├────────┼─────┼────────────┼─────────────────────────────────────┤
│ $5100  │ R/W │ ADAPTER    │ Adapter Control/Status              │
│        │     │            │   Bit 15: FM (Frame Mode)           │
│        │     │            │   Bit 7: REN (SH2 Reset Enable)     │
│        │     │            │   Bit 1: RES (SH2 Reset)            │
│        │     │            │   Bit 0: ADEN (Adapter Enable)      │
├────────┼─────┼────────────┼─────────────────────────────────────┤
│ $5102  │ R/W │ INTCTL     │ Interrupt Control                   │
│        │     │            │   Bit 1: INTS (Slave SH2 INT)       │
│        │     │            │   Bit 0: INTM (Master SH2 INT)      │
├────────┼─────┼────────────┼─────────────────────────────────────┤
│ $5104  │ R/W │ BANKSET    │ ROM Bank Switching                  │
├────────┼─────┼────────────┼─────────────────────────────────────┤
│ $5106  │ R/W │ DREQ_CTRL  │ DMA Request Control                 │
│        │     │            │   Bit 7: FULL (R/O), Bit 2: 68S,    │
│        │     │            │   Bit 0: RV (ROM to VRAM DMA)       │
│ $5108  │ W   │ DREQ_SRC_H │ DMA Source Address (high)           │
│ $510A  │ W   │ DREQ_SRC_L │ DMA Source Address (low)            │
│ $510C  │ W   │ DREQ_DST_H │ DMA Destination Address (high)      │
│ $510E  │ W   │ DREQ_DST_L │ DMA Destination Address (low)       │
│ $5110  │ W   │ DREQ_LEN   │ DMA Transfer Length                 │
├────────┼─────┼────────────┼─────────────────────────────────────┤
│ $5112  │ R/W │ FIFO_REG   │ FIFO Data Register                  │
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
│        │     │            │   TM/RTP: Read-Only from MD side     │
│        │     │            │   LMD/RMD: R/W                       │
│ $5132  │ R/W │ PWM_CYCLE  │ PWM Cycle Register                  │
│ $5134  │ W   │ PWM_LCHPW  │ PWM Left Channel Pulse Width        │
│        │     │            │   FULL/EMPTY bits: Read-Only          │
│ $5136  │ W   │ PWM_RCHPW  │ PWM Right Channel Pulse Width       │
│ $5138  │ W   │ PWM_MONO   │ PWM Monaural Pulse Width            │
└────────┴─────┴────────────┴─────────────────────────────────────┘
```

### Communication Register Usage
**Purpose**: Allow 68K and SH2 processors to exchange data
- COMM0-COMM7: 8 word-sized registers (16-bit each)
- Shared between all three CPUs (68K, SH2 Master, SH2 Slave)
- Used for synchronization, command passing, and data transfer

#### Documented COMM Register Functions

| Register | 68K Addr | SH2 Addr | Purpose |
|----------|----------|----------|---------|
| COMM0 | $A15120 | $20004020 | Command ID (68K→Master SH2) |
| COMM1 | $A15122 | $20004022 | Parameter / Status |
| COMM2 | $A15124 | $20004024 | Parameter / Status |
| COMM3 | $A15126 | $20004026 | Parameter / Status |
| COMM4 | $A15128 | $20004028 | Parameter / Status |
| COMM5 | $A1512A | $2000402A | **Vertex transform counter** (+101 per call) |
| COMM6 | $A1512C | $2000402C | Parameter / Status |
| COMM7 | $A1512E | $2000402E | **Master→Slave signal** (0x16 = vertex work) |

**Parallel Processing Protocol:**
1. Master writes command to COMM7 (0x16 for vertex transform)
2. Slave polls COMM7, picks up work when non-zero
3. Slave increments COMM5 by 101 per vertex batch processed
4. Historical design attempted parameter passing at invalid ROM alias `$2203E000`

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
│ $02000000    │ 3MB      │ Original ROM (cached)                 │
│ $02300000    │ 1MB      │ **EXPANSION ROM** (cached)            │
│ $02300050    │ 44B      │   → master_dispatch_hook              │
│ $02300100    │ 96B      │   → vertex_transform_optimized                │
│ $02300200    │ 76B      │   → slave_work_wrapper                │
│ $023FFFFF    │          │ End of Expansion ROM                  │
│              │          │                                       │
│ $04000000    │ 256KB    │ Frame Buffer (cached)                 │
│ $04020000    │ 256KB    │ Overwrite Image (cached)              │
│              │          │                                       │
│ $06000000    │ 256KB    │ SDRAM (cached)                        │
│              │          │ Per hardware manual §3.1 SH2 map      │
│              │          │                                       │
│ $20004000    │ ~        │ 32X System Registers                  │
│ $20004020    │ 16B      │   → COMM0-COMM7 registers             │
│              │          │                                       │
│ $22000000    │ 4MB      │ ROM Cartridge (cache-through)          │
│ $2203E000    │ 16B      │   → **Invalid historical ROM alias**  |
│              │          │   (project uses this addr; hw manual  │
│              │          │    says SDRAM c/t is $2600xxxx)        │
│              │          │                                       │
│ $24000000    │ 128KB    │ Frame Buffer (cache-through)           │
│ $24020000    │ 128KB    │ Overwrite Image (cache-through)        │
│              │          │                                       │
│ $26000000    │ 256KB    │ SDRAM (cache-through)                 │
│ $2603FFFF    │          │ End of SDRAM                          │
└──────────────┴──────────┴─────────────────────────────────────────┘
```

### SH2 Memory Performance Notes
- **Cached access**: Faster, uses cache lines (good for code/data)
- **Uncached access**: Slower, direct memory access (good for DMA targets)
- **Cache-through**: Writes update both cache and memory

### SH2 Access Timing (Official - Hardware Manual §4.1)

| Memory Region | Read | Write | Notes |
|--------------|------|-------|-------|
| **SDRAM** ($06000000) | 12 clocks | 2 clocks | Burst mode: 12 + 2×(n-1) for n words |
| **Frame Buffer** ($04000000) | 6 clocks | 3-5 clocks | 3 if FIFO not full, 5 if full |
| **VDP Registers** ($04004100) | 5 clocks | 5 clocks | |
| **System Registers** ($20004000) | 1 clock | 1 clock | COMM registers, interrupt control |
| **Color Palette** ($04004200) | 5 clocks | 5 clocks | |

**SDRAM Burst Mode Optimization**:
- Initial access: 12 clocks (expensive)
- Subsequent words in burst: 2 clocks each
- 8-word burst: 12 + 14 = 26 clocks (vs. 96 for 8 individual reads)
- **Align data structures for sequential access to exploit burst mode**

**Frame Buffer FIFO** (per 32X Hardware Manual):
- 4-word write FIFO for frame buffer and overwrite image
- **Single write**: 3 clock cycles per word
- **Burst write (4+ consecutive words)**: 5 clock cycles total for first 4 words = 1.25 cycles/word average
- **Performance gain**: 2.4x speedup when using 4-word bursts
- **Optimization opportunity**: Write frame buffer data in 4-word (8-byte) bursts
- **Status**: Need to profile if VRD already uses burst writes

### SH2 SDRAM Usage ($06000000 cached / $26000000 cache-through, 256KB)
- Primary working memory for SH2 programs
- Used for 3D transformation matrices
- Used for polygon data structures
- Used for SH2 stack

#### Retracted Historical Parameter Locations

| Address | Size | Purpose |
|---------|------|---------|
| $2203E000 | 4B | Invalid ROM alias historically labeled R14 |
| $2203E004 | 4B | Invalid ROM alias historically labeled R7 |
| $2203E008 | 4B | Invalid ROM alias historically labeled R8 |
| $2203E00C | 4B | Invalid ROM alias historically labeled R5 |

**Correction:** no writable parameter block exists at these addresses. A future design would
need collision-checked `$260xxxxx` SDRAM and fresh producer/consumer validation.

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

## Data Structure Locations

### Known Flags and Variables
- **$FFC87A**: V-INT execution flag (checked in V-INT handler)
- **$A15128**: Written during init (unknown purpose)
- **$2203E000**: Invalid historical parameter-block literal (cartridge ROM)

### SH2 Key Addresses (Discovered)

| Address | Function | Description |
|---------|----------|-------------|
| $02046A | Master dispatch | Original command dispatch (now redirected) |
| $0234C8 | vertex_transform trampoline | Captures params, signals Slave via COMM7 |
| $02300050 | master_dispatch_hook | Expansion ROM: skips COMM7 for cmd 0x16 |
| $02300100 | vertex_transform_optimized | Expansion ROM: vertex transform |
| $02300200 | slave_work_wrapper | Expansion ROM: Slave command dispatch |

---

## Completed Milestones

- ✅ Located SH2 Master entry point in ROM
- ✅ Located SH2 Slave entry point in ROM
- ⚠ Historical `$2203E000` mapping disproven (cartridge-ROM alias)
- ✅ Documented COMM register protocol
- ✅ Implemented expansion ROM (1MB at $300000)
- ⚠ Parallel-processing path remains inactive and behaviorally unvalidated

## Next Steps

1. **Performance Testing** - Measure FPS improvement from parallel processing
2. **Synchronization** - Ensure Slave completes before next frame
3. **Load Balancing** - Split polygon workload between CPUs

---

**Status**: Historical conclusion retracted; no validated parallel execution result
