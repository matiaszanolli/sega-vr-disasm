# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is a **Sega 32X development playground** - a knowledge base and development environment for creating games and software for the Sega 32X hardware (1994). The 32X is a power-up booster for the Sega Mega Drive/Genesis featuring:

- Two SH2 32-bit RISC CPUs (23 MHz)
- 2 Mbit SDRAM
- Two 1 Mbit frame buffers (32,768 color display)
- PWM stereo sound source
- VDP with Direct Color, Packed Pixel, and Run Length modes

## Documentation Structure

Comprehensive hardware and development documentation is located in `/docs`:

### Core Hardware References

- **[32x-hardware-manual.md](docs/32x-hardware-manual.md)** - Complete hardware reference
  - Memory maps (68000 and SH2)
  - Register documentation (System, VDP, PWM)
  - VDP graphics modes and timing
  - Clock specifications and timing diagrams

- **[32x-technical-info.md](docs/32x-technical-info.md)** - Critical bug fixes and errata
  - 22 documented hardware bugs and workarounds
  - Development board modifications
  - Version-specific issues (Ver 2.0A, 2.0B, 2.1, 3.0)

- **[32x-technical-info-attachment1.md](docs/32x-technical-info-attachment1.md)** - VRES/RV bit handling
  - Complete code examples for 68000, SH2 Master, and SH2 Slave
  - Critical reset behavior implementation

### Development Hardware

- **[32x-sram-cartridge-manual.md](docs/32x-sram-cartridge-manual.md)** - SRAM dev cartridge (837-11068)
  - 32 Mbit SRAM with bank switching
  - Battery-backed 256K-1Mbit data area
  - DIP switch configuration
  - LED status indicators

- **[32x-eprom-cartridge-manual.md](docs/32x-eprom-cartridge-manual.md)** - EPROM dev cartridge (837-11070)
  - Up to 64 Mbit EPROM capacity
  - Production master testing
  - EPROM programming requirements

### Audio System

- **[sound-driver-v3.md](docs/sound-driver-v3.md)** - Sound Driver V3.00
  - System call interface (00H-0DH)
  - FM synthesis (YM-2612), PSG, PWM, PCM
  - Music and sound effect data formats
  - Sequence commands and sound source IDs

## Critical Hardware Constraints

When developing for 32X, be aware of these **critical issues** from the technical documentation:

### Must-Know Bugs and Limitations

1. **RV Bit + VRES**: If VRES occurs while RV=1, system won't restart (Ver 2.0x). Requires watchdog reset code in VRES handler (Ver 2.1+ hardware fix, software workaround needed for older boards).

2. **PWM Sound**: Cannot stop individual channels once started. Plan audio accordingly.

3. **ROM Access**: When RV=1, certain addresses (`$001070-$001073`, `$002070-$002073`, `$003070-$003073`) are not readable.

4. **Z80 Write Restrictions**: Z80 cannot write to `$840000-$9FFFFF` or `$A15100-$A153FF` (causes 68000 lockup in Ver 2.0B+).

5. **PWM Register Access**: SH2 must use **word-only access** to PWM pulse width registers (`20004034H`, `20004036H`, `20004038H`). Byte access is prohibited.

6. **VDP Shift Bit**: Invalid when line table lower byte is `$FE`. Avoid `$FF` in line tables when using shift.

7. **EPROM Speed**: Must be 120 ns or faster (150 ns for EPROM carts).

### Memory Access Priorities

- **SH2 has priority** over 68000 when accessing cartridge ROM
- **FM bit switching**: Writing to FM bit forces VDP access switch, even during active VDP operations
- **Frame buffer access**: Only when FM=1 (SH2) or FM=0 (68000). Check VBLK=1 or FS bit before access.

### Register Addresses (Quick Reference)

**MEGA Drive side:**
- Adapter Control: `A1 5100h` (FM, REN, RES, ADEN)
- Interrupt Control: `A1 5102h` (INTS, INTM)
- Bank Set: `A1 5104h`
- VDP registers: `A1 5180h-A1 518Ah`
- Communication ports: `A1 5120h-A1 512Eh` (8 words bi-directional)

**SH2 side:**
- System registers: `2000 4000h-2000 403Eh` (cache-through)
- VDP registers: `2000 4100h-2000 410Ah` (cache-through)
- Frame buffer: `2400 0000h` (1 Mbit, with 4-word write FIFO)
- SDRAM: `2200 0000h` (2 Mbit)

## Development Workflow

### Testing ROMs

Use the included Gens KMod emulator (Windows):
```
./Gens_KMod_v0.7.3/gens.exe
```

Sample ROM available: `Virtua Racing Deluxe (USA).32x`

### Bank Switching (Development Cartridges)

Both SRAM and EPROM cartridges use identical register interface at `A130F1H-A130FFH`:

```assembly
; Example: Switch Area 2 to Bank 5
move.b  #$05, $A130F5

; Enable ROM area writes (SRAM cart only)
move.b  #$01, $A130F1    ; LED1 will turn ON

; Switch to backup RAM
move.b  #$01, $A130F1    ; Bit 0: ROM->RAM
```

### Sound Driver Usage

Initialize and use Sound Driver V3:

```assembly
; Initialize (call once at startup)
moveq   #0, d0          ; System call 00H
moveq   #0, d1          ; NTSC mode (2=PAL)
jsr     SoundDriver+8

; Request music
moveq   #1, d0          ; System call 01H
moveq   #5, d1          ; Music number
jsr     SoundDriver+8

; Play sound effect
moveq   #2, d0          ; System call 02H
moveq   #$80, d1        ; SE number (80H-EFH range)
jsr     SoundDriver+8

; Call driver every V-INT (~16ms)
; In your V-INT handler:
jsr     SoundDriver+0
```

## Code Architecture Notes

### CPU Coordination

- **68000**: Main CPU, handles Mega Drive compatibility and I/O
- **SH2 Master**: Primary 32X CPU, gets bus priority
- **SH2 Slave**: Secondary CPU, requests bus access from Master
- **Z80**: Dedicated to sound (100% CPU usage when Sound Driver active)

### Communication Between CPUs

**68000 ↔ SH2:**
- 8 communication port registers (`A1 5120h-A1 512Eh` / `2000 4020h-2000 402Eh`)
- CMD interrupt (68000 can trigger SH2 interrupt via `A1 5102h`)
- FIFO for DMA transfers (4-word buffer)

**Important:** When writing same register from both CPUs simultaneously, value becomes undefined. Implement proper synchronization.

### Memory Caching (SH2)

SH2 has two address spaces for same hardware:
- **Cache addresses**: `0xxx xxxxh` - Use for SDRAM code/data
- **Cache-through addresses**: `2xxx xxxxh` - **Required** for I/O registers (VDP, System, PWM)

**Never cache I/O registers** - values can change externally and cache won't be updated.

## Common Pitfalls

1. **Accessing VDP during wrong FM state**: Always check FM bit before VDP access
2. **Not clearing interrupts**: VRES, V, H, CMD, PWM interrupts must be explicitly cleared or they won't re-occur
3. **68000 interrupts during RV=1**: Must be disabled (causes crashes)
4. **Mixing EPROM types**: Never mix 8 Mbit and 16 Mbit EPROMs on same cartridge
5. **Forgetting to initialize Free Run Timer**: Required even if not using interrupts
6. **Not handling HEN bit**: H-interrupt behavior changes during V-blank based on HEN setting

## Hardware Versions

Development targets have evolved:
- **Ver 2.0**: PWM bug, chip must be exchanged
- **Ver 2.0A**: Slow speed, Z80 lockup issue
- **Ver 2.0B**: Z80 write restrictions added
- **Ver 2.1**: VRES fix, Z80 fix, NMI collection (Sept 1994)
- **Ver 3.0**: Different encoder/filter, more vivid colors, less blur (end of Sept 1994)

**Always do final testing on Ver 3.0 or production hardware** - graphics appearance differs from Ver 2.0x.

## When Writing New Code

### For Graphics (VDP)

- Use cache-through addresses (`2000 4100h+`) for VDP registers
- Frame buffer has 4-word write FIFO (3 clocks/word, 5 clocks when writing 4+ words)
- Always check `VBLK=1` or `FS` bit change before accessing frame buffer after swap
- Check `FEN=0` after AUTO FILL before accessing DRAM
- Palette access only when `PEN=1` (or anytime in Direct Color mode)

### For Audio (PWM/Sound Driver)

- Sound Driver uses ~3KB ROM, ~2.8KB RAM, 9% CPU (music playing)
- PWM channels cannot be individually stopped once started
- Call Sound Driver every V-INT
- Use system calls (00H-0DH) rather than direct work space access for compatibility

### For Memory Banking

- Area 0 always fixed (vectors)
- Areas 1-7 can map to any bank via `A130F3H-A130FFH`
- Default on power-up: Area N → Bank N
- Invalid bank numbers cause malfunction (0-7 for 32Mbit, 0-15 for 64Mbit)

## Additional Resources

- Original PDF manual: `32XUSHardwareManual.pdf`
- YM-2612 (FM chip) documentation: Reference external YM-2612 Application Manual
- SH2 CPU documentation: Reference SH7095 (Hitachi) documentation
