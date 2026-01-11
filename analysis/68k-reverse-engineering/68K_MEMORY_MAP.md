# Motorola 68000 Memory Map - Sega 32X

**Reference**: Super Mega Drive Manual, 32X Hardware Manual
**Project**: Virtua Racing Deluxe (USA).32x

## Overview

The Sega 32X adds hardware to the base Mega Drive/Genesis. From the 68000's perspective, the 32X registers appear in the $A15xxx range, while standard Mega Drive hardware remains at standard addresses.

## Complete Memory Map

### ROM and RAM

| Address Range | Size | Description |
|---------------|------|-------------|
| `$000000-$0FFFFF` | 1MB | Cartridge ROM (directly accessible) |
| `$200000-$23FFFF` | 256KB | Backup RAM (optional) |
| `$400000-$7FFFFF` | 4MB | Extended ROM area (banked) |
| `$800000-$87FFFF` | 512KB | Shadow ROM / Boot ROM |
| `$880000-$8FFFFF` | 512KB | ROM mirror (mapped from $000000) |
| `$900000-$9FFFFF` | 1MB | Main cartridge emulation RAM |
| `$FC0000-$FEFFFF` | 192KB | Extended work RAM |
| `$FF0000-$FFFFFF` | 64KB | **Main Work RAM** |

### Z80 Sound CPU

| Address Range | Size | Description |
|---------------|------|-------------|
| `$A00000-$A0FFFF` | 64KB | Z80 RAM (only $0000-$1FFF used) |
| `$A10000-$A10FFF` | 4KB | I/O Area |
| `$A11000-$A11FFF` | 4KB | Control Area |
| `$A14000-$A14003` | 4B | TMSS Register |

### Mega Drive I/O Registers

| Address | R/W | Description |
|---------|-----|-------------|
| `$A10001` | R | **Version Register** (region, NTSC/PAL) |
| `$A10003` | R/W | **Controller Port 1 Data** |
| `$A10005` | R/W | **Controller Port 2 Data** |
| `$A10007` | R/W | **Expansion Port Data** |
| `$A10009` | R/W | Controller Port 1 Control |
| `$A1000B` | R/W | Controller Port 2 Control |
| `$A1000D` | R/W | Expansion Port Control |
| `$A1000F` | R/W | Controller Port 1 Serial TX |
| `$A10011` | R/W | Controller Port 1 Serial RX |
| `$A10013` | R/W | Controller Port 1 Serial Control |
| `$A10015` | R/W | Controller Port 2 Serial TX |
| `$A10017` | R/W | Controller Port 2 Serial RX |
| `$A10019` | R/W | Controller Port 2 Serial Control |
| `$A1001B` | R/W | Expansion Port Serial TX |
| `$A1001D` | R/W | Expansion Port Serial RX |
| `$A1001F` | R/W | Expansion Port Serial Control |

### Z80 Control

| Address | R/W | Description |
|---------|-----|-------------|
| `$A11100` | R/W | **Z80 Bus Request** (bit 0: 1=request) |
| `$A11200` | W | **Z80 Reset** (bit 0: 0=reset, 1=run) |

### 32X System Registers (CRITICAL)

| Address | R/W | Name | Description |
|---------|-----|------|-------------|
| `$A15100` | R/W | **MARS_SYS_INTCTL** | Adapter Control (FM, REN, RES, ADEN) |
| `$A15102` | R/W | **MARS_SYS_INTMASK** | Interrupt Control (INTS, INTM) |
| `$A15104` | R/W | **MARS_SYS_HCOUNT** | H Interrupt Vector |
| `$A15106` | R/W | **MARS_DREQ_CTRL** | DREQ Control Register |
| `$A15108` | R/W | **MARS_DREQ_SRC_H** | DREQ Source Address (high) |
| `$A1510A` | R/W | **MARS_DREQ_SRC_L** | DREQ Source Address (low) |
| `$A1510C` | R/W | **MARS_DREQ_DST_H** | DREQ Destination Address (high) |
| `$A1510E` | R/W | **MARS_DREQ_DST_L** | DREQ Destination Address (low) |
| `$A15110` | R/W | **MARS_DREQ_LEN** | DREQ Length |
| `$A15112` | R/W | **MARS_FIFO** | FIFO Data Register |

### 32X Communication Ports (68K ↔ SH2)

| Address | R/W | Name | Description |
|---------|-----|------|-------------|
| `$A15120` | R/W | **COMM0** | Communication Port 0 |
| `$A15122` | R/W | **COMM1** | Communication Port 1 |
| `$A15124` | R/W | **COMM2** | Communication Port 2 |
| `$A15126` | R/W | **COMM3** | Communication Port 3 |
| `$A15128` | R/W | **COMM4** | Communication Port 4 |
| `$A1512A` | R/W | **COMM5** | Communication Port 5 |
| `$A1512C` | R/W | **COMM6** | Communication Port 6 |
| `$A1512E` | R/W | **COMM7** | Communication Port 7 |

**Note**: These 8 word registers are the primary communication mechanism between the 68000 and both SH2 CPUs. When both CPUs write simultaneously, the value is undefined.

### 32X PWM Sound Registers

| Address | R/W | Name | Description |
|---------|-----|------|-------------|
| `$A15130` | R/W | **PWM_CTRL** | PWM Control |
| `$A15132` | R/W | **PWM_CYCLE** | PWM Cycle Register |
| `$A15134` | W | **PWM_LDATA** | PWM Left Channel Data |
| `$A15136` | W | **PWM_RDATA** | PWM Right Channel Data |
| `$A15138` | W | **PWM_MONO** | PWM Mono Data |

### 32X VDP Registers

| Address | R/W | Name | Description |
|---------|-----|------|-------------|
| `$A15180` | R/W | **MARS_VDP_MODE** | Bitmap Mode Register |
| `$A15182` | R/W | **MARS_VDP_SHIFT** | Screen Shift Control |
| `$A15184` | R/W | **MARS_VDP_FILLEN** | Auto Fill Length |
| `$A15186` | R/W | **MARS_VDP_FILLADR** | Auto Fill Start Address |
| `$A15188` | R/W | **MARS_VDP_FILLDATA** | Auto Fill Data |
| `$A1518A` | R/W | **MARS_VDP_FBCTL** | Frame Buffer Control |

### Mega Drive VDP

| Address | R/W | Description |
|---------|-----|-------------|
| `$C00000` | W | VDP Data Port |
| `$C00002` | W | VDP Data Port (mirror) |
| `$C00004` | R/W | VDP Control Port |
| `$C00006` | R/W | VDP Control Port (mirror) |
| `$C00008` | R | HV Counter |
| `$C0000A` | R | HV Counter (mirror) |
| `$C00011` | W | PSG Sound |
| `$C00013` | W | PSG Sound (mirror) |
| `$C00019` | W | PSG Sound (mirror) |
| `$C0001B` | W | PSG Sound (mirror) |
| `$C0001D` | W | PSG Sound (mirror) |
| `$C0001F` | W | PSG Sound (mirror) |

### Bank Switching (A130Fx)

| Address | R/W | Description |
|---------|-----|-------------|
| `$A130F0` | W | D-RAM Board Control (dev kit) |
| `$A130F1` | W | SRAM Enable / Bank 0 |
| `$A130F3` | W | Bank 1 ($080000-$0FFFFF) |
| `$A130F5` | W | Bank 2 ($100000-$17FFFF) |
| `$A130F7` | W | Bank 3 ($180000-$1FFFFF) |
| `$A130F9` | W | Bank 4 ($200000-$27FFFF) |
| `$A130FB` | W | Bank 5 ($280000-$2FFFFF) |
| `$A130FD` | W | Bank 6 ($300000-$37FFFF) |
| `$A130FF` | W | Bank 7 ($380000-$3FFFFF) |

## Exception Vectors (Virtua Racing Deluxe)

| Vector | Address | Handler | Description |
|--------|---------|---------|-------------|
| 0 | `$000000` | `$01000000` | Initial SSP |
| 1 | `$000004` | `$000003F0` | Initial PC (Entry Point) |
| 2-11 | `$000008-$02C` | `$00880832` | Bus/Address/Trap Errors |
| 24-27 | `$000060-$06C` | `$00880832` | Spurious/Level 1-3 IRQ |
| 28 | `$000070` | `$0088170A` | **Level 4 IRQ (H-INT)** |
| 29 | `$000074` | `$00880832` | Level 5 IRQ |
| 30 | `$000078` | `$00881684` | **Level 6 IRQ (V-INT)** |
| 31 | `$00007C` | `$00880832` | Level 7 IRQ (NMI) |
| 32-47 | `$000080-$0BC` | `$00880832` | TRAP #0-15 |

## MARS Adapter Control Register ($A15100)

```
Bit 7: FM    - Frame buffer access mode (0=68K, 1=SH2)
Bit 6: (unused)
Bit 5: (unused)
Bit 4: (unused)
Bit 3: (unused)
Bit 2: (unused)
Bit 1: REN   - ROM enable (0=disabled, 1=enabled)
Bit 0: ADEN  - Adapter enable (0=disabled, 1=enabled)
```

## Interrupt Control Register ($A15102)

```
Bit 7: (unused)
Bit 6: (unused)
Bit 5: (unused)
Bit 4: (unused)
Bit 3: (unused)
Bit 2: INTM  - Interrupt mask for CMD (0=masked, 1=enabled)
Bit 1: INTS  - Interrupt status for CMD
Bit 0: (unused)
```

## Version Register ($A10001)

```
Bit 7: Region (0=Japan, 1=Overseas)
Bit 6: PAL/NTSC (0=NTSC, 1=PAL)
Bit 5: Expansion unit connected
Bit 4: (reserved)
Bit 3-0: Hardware version
```

## Key Constants for Disassembly

```asm
; 32X System
MARS_SYS_INTCTL     equ $A15100
MARS_SYS_INTMASK    equ $A15102
MARS_SYS_HCOUNT     equ $A15104
MARS_DREQ_CTRL      equ $A15106
MARS_DREQ_SRC       equ $A15108
MARS_DREQ_DST       equ $A1510C
MARS_DREQ_LEN       equ $A15110
MARS_FIFO           equ $A15112

; Communication
COMM0               equ $A15120
COMM1               equ $A15122
COMM2               equ $A15124
COMM3               equ $A15126
COMM4               equ $A15128
COMM5               equ $A1512A
COMM6               equ $A1512C
COMM7               equ $A1512E

; PWM Sound
PWM_CTRL            equ $A15130
PWM_CYCLE           equ $A15132
PWM_LDATA           equ $A15134
PWM_RDATA           equ $A15136
PWM_MONO            equ $A15138

; 32X VDP
MARS_VDP_MODE       equ $A15180
MARS_VDP_SHIFT      equ $A15182
MARS_VDP_FILLEN     equ $A15184
MARS_VDP_FILLADR    equ $A15186
MARS_VDP_FILLDATA   equ $A15188
MARS_VDP_FBCTL      equ $A1518A

; Mega Drive I/O
MD_VERSION          equ $A10001
MD_DATA1            equ $A10003
MD_DATA2            equ $A10005
MD_CTRL1            equ $A10009
MD_CTRL2            equ $A1000B

; Z80 Control
Z80_BUSREQ          equ $A11100
Z80_RESET           equ $A11200

; VDP
VDP_DATA            equ $C00000
VDP_CTRL            equ $C00004
VDP_HVCNT           equ $C00008

; Work RAM
WORK_RAM            equ $FF0000
WORK_RAM_END        equ $FFFFFF
```

## Register Conventions (68K in 32X Games)

Based on analysis of Virtua Racing Deluxe:

| Register | Common Usage |
|----------|--------------|
| D0-D3 | Scratch/parameters/return values |
| D4-D7 | Loop counters, temporary storage |
| A0-A3 | Scratch address registers |
| A4 | Often `$A15100` (MARS_SYS base) |
| A5 | Often `$A10000` (MD I/O base) |
| A6 | Frame pointer or context pointer |
| A7 | Stack pointer (SP) |

## Communication Protocol Notes

The 68000 and SH2 CPUs communicate via the 8 COMM registers:
- **COMM0-COMM3**: Typically 68K → SH2 commands
- **COMM4-COMM7**: Typically SH2 → 68K responses

**Synchronization Pattern**:
1. 68K writes command to COMM0-3
2. 68K sets flag in COMM register
3. SH2 polls COMM, processes command
4. SH2 writes result to COMM4-7
5. SH2 clears/sets acknowledgment flag
6. 68K polls for acknowledgment

## References

- Super Mega Drive Manual (SEGA Confidential #161)
- 32X Hardware Manual
- Virtua Racing Deluxe ROM Analysis
