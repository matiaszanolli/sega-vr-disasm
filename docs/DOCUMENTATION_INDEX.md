# Official SEGA Documentation Index

This directory contains official SEGA development documentation for Genesis/Mega Drive and 32X development.

## Hardware Manuals

### 32X Hardware Manual (90 pages)
**File:** `32XUSHardwareManual.pdf`

Complete 32X hardware reference including:
- SH2 CPU specifications
- Memory maps (ROM, SDRAM, frame buffers)
- VDP modes (Direct Color, Packed Pixel, Run Length)
- Communication registers (COMM0-COMM7)
- PWM sound system
- Hardware bugs and workarounds

**Key for:** 32X-specific development, SH2 programming, multi-CPU coordination

---

### Genesis Technical Overview (120 pages)
**File:** `GenesisTechnicalOverview.pdf`

Comprehensive Genesis/Mega Drive hardware specifications:

**CPU & Memory:**
- 68000 @ 7.67 MHz (main CPU)
- 1 MByte ROM area (expandable with bank switching)
- 64 KByte RAM area

**VDP (Video Display Processor):**
- Dedicated video display processor
- Controls playfield & sprites
- Character-based rendering
- 64 KBytes VRAM (Video RAM)
- 64 × 9-bit CRAM (Color RAM)
- 40 chars × 28 chars display (320×224 pixels)
- 3 planes: 2 scrolling playfields + 1 sprite plane
- Definable priorities between planes
- 512 possible colors (3 bits RGB)
- 4 palettes of 16 colors on-screen

**Z80 Sound System:**
- Z80 @ 4 MHz
- Controls PSG & FM chips
- 8 KBytes dedicated Sound RAM

**DMA:**
- Removes 68000 from bus
- Can move 205 bytes/scanline during VBLANK (30 scanlines)
- Can move 7380 bytes during VBLANK

**Interrupts:**
- Horizontal & Vertical interrupts available

**Key for:** Understanding Genesis base system, VDP programming, memory architecture

---

## Software Development Manuals

### Genesis Software Development Manual V2.0 (26 pages)
**File:** `Genesis_Software_Development_Manual_Version_2.0_1991-07-09.pdf`
**Date:** July 9, 1991

Official SEGA software development guide covering:
- Required cartridge ROM header format
- Initial program setup
- External RAM information
- I/O modem information
- Checksum calculation
- VDP setup data
- Compatibility settings for Genesis development
- 68000 commands and peripheral devices
- Joystick and peripheral device handling
- Software development precautions:
  - Z80 bus access rules
  - H_INT and V_INT usage in Genesis programs
  - Interrupt handling during communication
  - Control register (A/B screens) precautions
  - Main program and Z80 bus request precautions
  - Sound access precautions
  - Reset button handling
  - Control pad and read-program notes
- Notes on Mega Drive Europe version (PAL)
- Vertical 30-cell mode
- Backup RAM notes

**Key for:** ROM header requirements, peripheral I/O, development best practices

---

### Sega Genesis Software Manual (159 pages)
**File:** `SegaGenesisSoftwareManual_1990-02-06.pdf`
**Date:** February 6, 1990 (earlier comprehensive version)

Earlier, more comprehensive software manual. Likely contains additional details not in the V2.0 manual.

**Key for:** Complete Genesis software development reference

---

## Technical Bulletins

### Genesis Technical Bulletins (83 pages)
**File:** `GenesisTechnicalBulletins.pdf`

Official SEGA technical bulletins with errata, corrections, and development tips:

**Bulletin #1 (March 13, 1991):**
- Subject: ERRORS WITHIN THE MICROTEC EXAMPLES
- Corrections to asm68k command syntax
- Link command corrections
- C compiler documentation corrections ('STRINGSINTEXT' vs 'STRINTEXT')

**Bulletin #2 (June 19, 1990):**
- Subject: GENESIS LOADER BOARD
- Hardware modifications to prevent loading errors
- Resistor and jumper wire requirements
- Circuit board diagram with modifications

*Additional bulletins present - full list TBD*

**Key for:** Known issues, errata corrections, hardware workarounds

---

## Assembler Documentation

### SNASM68K Console and Z80 Notes (4 pages)
**File:** `SNASM68K_Console_and_Z80_Notes.pdf`

Official SEGA assembler (SNASM68K) syntax and usage notes:

**SNASM68K Specifics:**
- Power supply requirements (240V 50Hz for overseas, 9V 1A PSU for UK)
- Installation instructions
- Interface unit connection (68000 socket on target system)
- Ribbon cable connection (PC to Console interface)
- SCSI cable for Console interface with RAM/EPROM emulation
- 1Mb static RAM for EPROM emulation
- 32K battery-backed RAM for link software
- Main RAM mapping at $200000 (1Mb static)
- Write-protect LED indicators
- Front panel switch for main unit control
- Startup file: `startup.68k` (sets up 68000 vectors)
- Exception handling via `except.68k`
- Debug services callable from code (16 bytes into interface workspace)
- Register conventions for service calls (D0=service number, D1-D2=parameters)
- Status register manipulation flags
- KeepTraps variable control
- Pure binary mode for final ROM image generation
- Initial register values set via REGS directive
- Configuration file: `snbug658.cf?` (memory range definitions)
- DIP switches for RAM addressing and SCSI ID

**Z80 Assembler Notes:**
- Fully functional Z80 assembler (no linking support yet)
- Mostly same syntax as 68000 assembler
- Exceptions:
  - Local labels: `@` prefix (changed with `/l` switch to `$`)
  - PC value: `$` and `*` both valid
  - Hex numbers: trailing `H` or prefix `#` (hash)
  - Binary numbers: trailing `B`
- Extended features:
  - Abbreviations: `EX AF,AF` → `EXAF`, `JR NZ` → `JNZ`
  - `PUSH`/`POP` take multiple registers
  - Can omit initial `A` in `ADD`, `ADC`, `SBC`
  - `Opt hd64180+` enables extra 64180 instructions
- Only `DB` and `DW` directives for data (not DC)
- Binary output: `snasmz80 /p prog.z80,z80prog.bin`

**Key for:** Understanding official SEGA assembler syntax, proper development tool usage

---

## Quick Reference

### For 68K Assembly Translation Work:
1. **Genesis Technical Overview** - Hardware register addresses, VDP specs
2. **Genesis Software Manual** - ROM header format, development practices
3. **SNASM68K Notes** - Official assembler syntax

### For 32X Development:
1. **32X Hardware Manual** - Complete 32X hardware reference
2. **Genesis Technical Overview** - Base Genesis system understanding

### For Debugging Issues:
1. **Technical Bulletins** - Known errata and workarounds
2. **Software Manual** - Development precautions and best practices

---

## Integration with Existing Documentation

These PDFs complement the existing markdown documentation:
- `development-guide.md` - 32X development guide
- `32x-hardware-manual.md` - 32X hardware manual (markdown version)
- `32x-technical-info.md` - Hardware bugs and workarounds

The PDF files provide **official SEGA source material** that informed the markdown documentation.
