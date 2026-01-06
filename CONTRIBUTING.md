# Contributing to Virtua Racing Deluxe Disassembly

Thanks for your interest in contributing! This project aims to create a complete, buildable disassembly of Virtua Racing Deluxe for the Sega 32X.

## Current Status

✅ **Phase 1 Complete**: Perfect byte-for-byte ROM match achieved
- Header fully disassembled (512 bytes)
- Build system functional
- All tools working

🚧 **Phase 2 In Progress**: Incremental code disassembly
- Disassemble 32X vector table
- Disassemble initialization routines
- Extract and disassemble SH2 code
- Replace binary blobs with source code

## How to Contribute

### 1. Disassembling Code Sections

The main goal is to replace sections of `rom_data_remainder.bin` with disassembled source code.

**Process:**
1. Pick a section to disassemble (see [Roadmap](#roadmap) below)
2. Use the disassembler tools to extract code
3. Add labels and comments
4. Replace the binary blob in `m68k_header.asm`
5. Verify the ROM still matches perfectly

**Example workflow:**
```bash
# Disassemble a section
python3 tools/m68k_disasm.py "Virtua Racing Deluxe (USA).32x" 0x832 50

# Edit the source file
# Replace the binary blob with disassembled code

# Build and verify
make clean && make all
md5sum build/vr_rebuild.32x  # Must still be 72b1ad0f949f68da7d0a6339ecd51a3f
```

### 2. Improving the Disassemblers

The custom disassemblers can always be improved.

**M68K Disassembler** (`tools/m68k_disasm.py`):
- Currently: 45+ opcodes
- Missing: Some addressing modes, floating-point ops
- Improvements needed: Better label generation, data recognition

**SH2 Disassembler** (`tools/sh2_disasm.py`):
- Currently: Basic instruction set
- Missing: Many SH2-specific instructions
- Improvements needed: Better branch detection, register tracking

**To contribute:**
1. Find an unknown opcode in disassembly output
2. Look up the instruction in the CPU manual
3. Add decoder to the appropriate tool
4. Test with real ROM sections
5. Submit a pull request

### 3. Documentation

**Code comments:**
- Add comments explaining what code does
- Document register usage
- Identify hardware access patterns
- Label data structures

**Analysis:**
- Document rendering pipeline
- Map out game state structures
- Identify physics calculations
- Document track data format

### 4. Tools and Scripts

**Useful tools to create:**
- Graphics extractor for textures/sprites
- Track data parser
- Car model extractor
- Sound sample extractor
- Automated label generator

## Roadmap

### Priority 1: Core System Code
- [ ] 32X Jump Table ($200-$3FF) - 512 bytes
- [ ] MARS Security Code ($3C0-$512)
- [ ] Exception Handler ($832) - ~10 instructions
- [ ] Initialization Routine ($838-$900) - ~200 bytes
- [ ] V-INT Handler ($1684)
- [ ] H-INT Handler ($170A)

### Priority 2: SH2 Code
- [ ] Locate SH2 Master entry point
- [ ] Locate SH2 Slave entry point
- [ ] Disassemble SH2 init code
- [ ] Identify 3D rendering routines

### Priority 3: Data Structures
- [ ] Identify ROM-to-RAM copy routines
- [ ] Map work RAM layout
- [ ] Document game state structures
- [ ] Parse track data format

### Priority 4: Game Logic
- [ ] Main game loop
- [ ] Input handling
- [ ] Physics engine
- [ ] AI routines
- [ ] Sound driver

## Code Style Guidelines

### Assembly Code
```asm
; Use consistent indentation (4 spaces or 1 tab)
; Format: LABEL: or .LocalLabel:
; Comments explain WHY, not WHAT

SomeRoutine:
    movem.l d0-d7/a0-a6,-(sp)       ; Save all registers
    lea     MARS_SYS_INTCTL,a0      ; Load 32X system registers

    ; Check if adapter is enabled
    btst    #0,(a0)                 ; Test ADEN bit
    beq.s   .NotEnabled             ; Branch if disabled

.NotEnabled:
    movem.l (sp)+,d0-d7/a0-a6       ; Restore registers
    rts
```

### Python Tools
```python
# Follow PEP 8
# Use type hints where helpful
# Add docstrings for functions

def decode_opcode(opcode: int, addr: int) -> tuple[str, int]:
    """
    Decode a 68000 opcode.

    Args:
        opcode: 16-bit opcode value
        addr: Current address for PC-relative calculations

    Returns:
        Tuple of (instruction_string, byte_size)
    """
    # Implementation
```

## Testing

**All contributions must:**
1. Maintain byte-for-byte ROM match (MD5: 72b1ad0f949f68da7d0a6339ecd51a3f)
2. Build successfully with `make all`
3. Not break existing functionality

**Verify your changes:**
```bash
make clean
make all
md5sum "Virtua Racing Deluxe (USA).32x" build/vr_rebuild.32x
# Both must show: 72b1ad0f949f68da7d0a6339ecd51a3f
```

## Pull Request Process

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/disasm-init-routine`
3. **Make your changes**
4. **Test thoroughly** (ROM must match!)
5. **Commit with clear messages**:
   ```
   Disassemble initialization routine at 0x838

   - Fully disassembled first 200 bytes
   - Added labels and comments
   - Identified 32X hardware register access
   - ROM still matches perfectly (MD5 verified)
   ```
6. **Push to your fork**
7. **Open a pull request**

## What NOT to Include

❌ **Do NOT commit:**
- ROM files (*.32x, *.bin ROM dumps)
- Emulators
- PDFs of copyrighted manuals
- Binary blobs that can be regenerated
- Build artifacts (build/ directory)

✅ **Do commit:**
- Disassembled source code
- Tools and scripts
- Documentation (your own analysis)
- Test scripts
- Makefile improvements

## Resources

### Documentation
- [docs/32x-hardware-manual.md](docs/32x-hardware-manual.md) - Complete hardware reference
- [docs/32x-technical-info.md](docs/32x-technical-info.md) - Known bugs
- [analysis/ROM_STRUCTURE.md](analysis/ROM_STRUCTURE.md) - ROM layout

### CPU Manuals
- M68000 Programmer's Reference Manual
- Hitachi SH7604 (SH2) Hardware Manual
- Z80 CPU Manual

### Existing Tools
- [tools/m68k_disasm.py](tools/m68k_disasm.py) - 68000 disassembler
- [tools/sh2_disasm.py](tools/sh2_disasm.py) - SH2 disassembler
- [tools/analyze_rom.py](tools/analyze_rom.py) - ROM analyzer

## Questions?

- Check [SETUP.md](SETUP.md) for initial setup
- Review [README.md](README.md) for overview
- Read [PROGRESS.md](PROGRESS.md) for current status
- Check existing issues for similar questions
- Open a new issue for discussion

## License

This project is for educational and preservation purposes. All original game code is © SEGA 1994. This repository contains only disassembly and analysis tools, not the game itself.

---

**Happy hacking!** 🛠️
