# Virtua Racing Deluxe - ROM Structure Analysis

## ROM Information

- **Size**: 3,145,728 bytes (3MB exactly)
- **Console**: SEGA 32X U
- **Copyright**: (C)SEGA 1994.SEP
- **Title**: V.R.DX (Virtua Racing Deluxe)
- **Serial**: GM MK-84601-00
- **Region**: U (USA)

## Memory Map (from ROM header)

| Region | Start | End | Size | Notes |
|--------|-------|-----|------|-------|
| ROM | 0x00000000 | 0x002FFFFF | 3MB | Entire cartridge space |
| RAM | 0x00FF0000 | 0x00FFFFFF | 64KB | Work RAM |

## ROM Layout

### 0x000000 - 0x0001FF: Initial Vectors
- **0x000000**: Initial Stack Pointer = 0x01000000
- **0x000004**: Initial Program Counter = 0x000003F0

### 0x000100 - 0x0001FF: Sega Header
- Standard Mega Drive/Genesis header
- Contains console ID, copyright, title, serial number

### 0x000200 - 0x0003BF: 68000 Vector Table
- Jump table format (32X style)
- Each entry: `4E F9 XX XX XX XX` (JMP xxxx.l)
- Most vectors point to 0x00880832 (error handler)
- **Exception**: Vector 0 (Reset SP) points to 0x00880838 (main init)

### 0x0003C0: "MARS CHECK MODE" String
- Contains: "MARS CHECK MODE " + padding
- Indicates 32X-specific initialization code

### Key Entry Points

| Address (ROM) | File Offset | Purpose |
|---------------|-------------|---------|
| 0x00880832 | 0x000832 | Default exception handler |
| 0x00880838 | 0x000838 | Main initialization routine |
| 0x000003F0 | 0x0003F0 | Initial program counter |

## ROM Address Space Mapping

The 32X ROM is mapped in 68000 address space as:
- Physical ROM offset 0x000000 → 68000 address 0x00880000
- To convert: `68000_addr = file_offset + 0x00880000`
- To convert: `file_offset = 68000_addr - 0x00880000`

This matches the 32X hardware manual specification where ROM appears at 0x880000 when ADEN=1.

## CPU Code Sections (Estimated)

Based on 32X architecture, the ROM likely contains:

1. **68000 Code** (0x000000 - ???)
   - Main game logic
   - Menu system
   - 2D graphics
   - Mega Drive compatibility

2. **SH2 Master Code** (??? - ???)
   - 3D polygon engine
   - Main rendering
   - Physics calculations

3. **SH2 Slave Code** (??? - ???)
   - Additional rendering
   - Parallel processing

4. **Z80 Sound Code** (??? - ???)
   - FM synthesis driver
   - PSG driver
   - Sound effects

5. **Data Sections** (??? - ???)
   - 3D model data
   - Textures
   - Track layouts
   - Car data
   - Sound samples (PWM)
   - Music data

## Next Steps

1. ✅ Analyze ROM structure and header
2. ⏳ Disassemble entry points (0x832, 0x838, 0x3F0)
3. ⏳ Find SH2 code sections
4. ⏳ Identify data vs code boundaries
5. ⏳ Map out major routines
6. ⏳ Extract and identify assets

## Tools Needed

- **68000 disassembler** (m68k-linux-gnu-objdump or Capstone)
- **SH2 disassembler** (sh-elf-objdump or custom)
- **Hex editor** for data analysis
- **Graphics extractors** for sprites/textures
- **Sound extractors** for PWM/FM data

## Challenges

1. **Multiple CPU architectures** - Need disassemblers for 68000, SH2, and Z80
2. **No debug symbols** - Must reverse engineer function boundaries
3. **Complex 3D engine** - Virtua Racing uses advanced polygon rendering
4. **Timing-critical code** - Must preserve exact timing for gameplay
5. **Compressed/encrypted data** - May need to identify compression schemes
