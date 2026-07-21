# Virtua Racing Deluxe - Reverse Engineering Analysis

**Project**: Complete disassembly and optimization of Virtua Racing Deluxe (Sega 32X)
**Status**: Foundation complete, deep analysis in progress
**Last Updated**: 2026-01-06

---

## 📁 Analysis Documents

This directory contains comprehensive reverse engineering documentation for Virtua Racing Deluxe. Each document focuses on a specific aspect of the game's architecture.

### Core Documentation

#### [INITIALIZATION_SEQUENCE.md](INITIALIZATION_SEQUENCE.md)
**Status**: ✅ Complete
**Purpose**: Documents the complete boot sequence from power-on to main loop

**Contents**:
- Boot sequence overview and flow diagram
- Initial program counter analysis (0x3F0)
- MARS security check details
- 32X register initialization sequence
- Memory map setup and code copying to RAM
- Interrupt handler setup
- Entry points for further investigation

**Key Findings**:
- Initial PC at $8803F0
- Code copied from ROM ($4C0) to RAM ($FF0000) for faster execution
- 32X adapter enabled via $A15101
- V-INT handler at $881684, H-INT at $88170A

---

#### [MEMORY_MAP.md](MEMORY_MAP.md)
**Status**: ✅ Complete
**Purpose**: Complete memory layout for all processors and address spaces

**Contents**:
- 68000 address space (24-bit, 16MB)
- ROM layout and structure (3MB)
- Work RAM layout ($FF0000-$FFFFFF, 64KB)
- 32X register map ($A15000+)
- SH2 memory view (32-bit addressing)
- Interrupt and exception vectors
- Known data structure locations

**Key Findings**:
- ROM visible at $000000 and $880000 (32X remapped)
- SH2 sees cartridge ROM at `$02000000` (cached) / `$22000000` (cache-through)
- SH2 SDRAM is `$06000000` (cached) / `$26000000` (cache-through), 256KB
- Communication registers $A15120-$A1512E for CPU synchronization

---

#### [SH2_CODE_HUNT.md](SH2_CODE_HUNT.md)
**Status**: ✅ Entry Points Located!
**Purpose**: Systematic search for SH2 Master and Slave code in ROM

**Contents**:
- Search methodology and strategies
- SH2 startup mechanism (COMPLETE!)
- SH2 entry point discovery
- Handshake protocol analysis
- ROM structure analysis
- Next steps for disassembly

**Key Findings**:
- **SH2 Master entry point: ROM offset 0x288** (execution address $06000288)
- **SH2 Slave entry point: ROM offset 0x000** (needs verification)
- Entry points stored at fixed ROM offsets: 0x3E4 (Master), 0x3E8 (Slave)
- SH2 Boot ROM reads these addresses on startup
- Handshake protocol confirmed: Master writes "M_OK", Slave writes "S_OK"
- 68K waits for handshake at ROM 0x808, then writes 0 to COMM0/COMM4 to start
- High-probability SH2 code also at offsets 0x24000-0x26000 and 0x2F0000+

**Status**: Ready for SH2 code disassembly!

---

#### [SH2_MASTER_CODE.md](SH2_MASTER_CODE.md)
**Status**: 📝 Framework Complete
**Purpose**: Analysis of SH2 Master 3D rendering code

**Contents**:
- Entry point at ROM offset 0x288
- Expected code structure
- Memory layout from Master's perspective
- Communication protocols
- Analysis framework and next steps

**Key Information**:
- Entry point: ROM $288 → SH2 address $06000288
- Handshake: Writes "M_OK" to COMM0
- Main loop: Coordinates with Slave, processes 3D transforms
- SDRAM usage: Stack, matrices, polygon buffers

**Next**: Disassemble and analyze the initialization code

---

#### [ROM_STRUCTURE.md](ROM_STRUCTURE.md)
**Status**: ⚠️ Needs Update
**Purpose**: Original ROM layout analysis (created during initial exploration)

**Note**: This document was created early in the project. Much of its content has been superseded by INITIALIZATION_SEQUENCE.md and MEMORY_MAP.md. Should be updated or merged.

---

## 🎯 Current Investigation Status

### ✅ Completed
- [x] Perfect byte-for-byte ROM match achieved (MD5: 72b1ad0f949f68da7d0a6339ecd51a3f)
- [x] ROM header fully disassembled (512 bytes)
- [x] Build system functional
- [x] 32X hardware documentation (1000+ pages)
- [x] Initial boot sequence traced
- [x] Memory map documented
- [x] Vector table analyzed
- [x] 32X register layout mapped
- [x] M68K disassembler enhanced (60+ opcodes added)
- [x] SH2 entry points located (Master: ROM 0x288, Slave: ROM 0x000)
- [x] SH2 startup mechanism documented
- [x] 68K init code fully analyzed (up to 0x850)

### 🔄 In Progress
- [ ] SH2 Master code disassembly (ROM 0x288)
- [ ] SH2 Slave entry point verification
- [ ] V-INT handler flow analysis
- [ ] Main game loop identification

### 📋 Planned
- [ ] Complete SH2 Master code analysis
- [ ] 3D rendering pipeline analysis
- [ ] Graphics data format documentation
- [ ] Track data structure mapping
- [ ] Sound driver analysis
- [ ] Complete function reference guide

---

## 🔧 Tools and Methods

### Disassemblers
- **[tools/m68k_disasm.py](../tools/m68k_disasm.py)**: Motorola 68000 disassembler
  - 45+ opcodes implemented
  - Needs: More addressing modes, remaining opcodes

- **[tools/sh2_disasm.py](../tools/sh2_disasm.py)**: Hitachi SH2 disassembler
  - Basic instruction set
  - Needs: Complete opcode coverage, control flow analysis

- **[tools/analyze_rom.py](../tools/analyze_rom.py)**: ROM structure analyzer
  - Header parsing
  - Vector table analysis
  - Pattern detection

- **[tools/find_code_sections.py](../tools/find_code_sections.py)**: Code vs data classifier
  - SH2 pattern matching
  - Scoring algorithm for code likelihood

### Analysis Techniques
1. **Pattern Matching**: Search for known instruction sequences
2. **Address Tracking**: Follow memory references and pointers
3. **Control Flow Analysis**: Trace branches, jumps, and calls
4. **Register Usage**: Track what registers store (base addresses, counters, etc.)
5. **Loop Detection**: Identify iteration patterns (DBRA, etc.)
6. **Cross-Referencing**: Correlate findings across different tools

---

## 📊 ROM Layout Summary

```
Offset Range      Size      Type        Status          Description
────────────────────────────────────────────────────────────────────────────
0x000000          512B      Header      ✅ Complete     68K vectors + Sega header
0x000200          512B      Code        📝 Partial      32X jump table
0x000400          ~30KB     Code        🔄 In Progress  68K initialization
0x008000          ~112KB    Code        📋 Planned      68K main program
0x020000          ~16KB     Data        ✅ Identified   Address tables
0x024000          ~???      Code?       🔍 Investigation SH2 code candidate 1
0x02E000          ~2.7MB    Data/Code   📋 Planned      Graphics/sound/SH2?
0x2F0000          ~???      Code?       🔍 Investigation SH2 code candidate 2
0x2FFFFF          (end)     -           -               Last ROM byte
```

**Legend**:
- ✅ Complete: Fully understood and documented
- 🔄 In Progress: Currently being analyzed
- 📝 Partial: Some understanding, needs more work
- 🔍 Investigation: Hypothesis stage, needs verification
- 📋 Planned: Not yet started, scheduled for future

---

## 🎮 System Architecture

### Processor Roles

**68000 (Main CPU)**:
- System initialization and control
- Input handling (controllers)
- Game logic and AI
- Sound driver management
- SH2 coordination

**SH2 Master & Slave (Graphics Processors)**:
- 3D transformation matrices
- Polygon projection and clipping
- Rasterization and rendering
- Frame buffer management
- Parallel processing for performance

**Z80 (Sound Processor)**:
- PSG (Programmable Sound Generator) control
- FM synthesis
- PCM sample playback
- Sound effect mixing

### Communication Flow
```
┌─────────┐         ┌──────────┐         ┌──────────┐
│  68000  │◄───────►│SH2 Master│◄───────►│SH2 Slave │
│  Main   │  COMM   │3D Render │  SDRAM  │3D Render │
│  CPU    │  Regs   │          │  Share  │          │
└────┬────┘         └──────────┘         └──────────┘
     │
     │ Commands
     ▼
┌─────────┐
│   Z80   │
│  Sound  │
└─────────┘
```

---

## 🚀 Optimization Opportunities

### Identified (Potential)
Once SH2 code is located and analyzed, look for:

1. **Rendering Pipeline**:
   - Polygon sorting algorithms
   - Clipping optimization
   - Fill rate bottlenecks
   - Cache usage patterns

2. **Data Structures**:
   - Polygon mesh organization
   - Vertex transformation caching
   - Display list optimization

3. **Synchronization**:
   - Frame pacing
   - SH2 workload balancing
   - FIFO utilization

4. **Memory Access**:
   - Cache vs uncached regions
   - DMA usage efficiency
   - SDRAM access patterns

**Note**: Cannot proceed with optimization until SH2 code is located and understood.

---

## 📝 Next Session Goals

### Immediate (Next 1-2 hours)
1. Improve M68K disassembler - add missing opcodes
2. Complete disassembly of init routine at 0x6BC
3. Trace COMM register writes to find SH2 entry points

### Short Term (Next session)
4. Locate SH2 Master code entry point
5. Locate SH2 Slave code entry point
6. Begin SH2 code disassembly

### Medium Term (Future sessions)
7. Map complete SH2 program structure
8. Analyze 3D rendering pipeline
9. Document all game data structures
10. Create complete function call map

---

## 📚 References

### Project Documentation
- [/README.md](../README.md) - Project overview
- [/PROGRESS.md](../PROGRESS.md) - Build status and achievements
- [/SETUP.md](../SETUP.md) - Setup instructions
- [/CONTRIBUTING.md](../CONTRIBUTING.md) - Contribution guidelines

### Hardware Documentation
- [/docs/32x-hardware-manual.md](../docs/32x-hardware-manual.md) - Complete 32X hardware reference
- [/docs/32x-technical-info.md](../docs/32x-technical-info.md) - Known hardware bugs
- [/docs/sound-driver-v3.md](../docs/sound-driver-v3.md) - Sound driver documentation

### External References
- M68000 Programmer's Reference Manual (Motorola)
- SH7604 Hardware Manual (Hitachi SH2)
- Z80 CPU User Manual (Zilog)
- Genesis/Mega Drive VDP Documentation

---

## 💡 Key Insights

### What Makes This Game Interesting
1. **Advanced 3D Engine**: One of the best on Genesis/32X
2. **Dual SH2 Utilization**: Effective parallel processing
3. **Optimization Techniques**: Must extract lessons for modern code
4. **Historical Significance**: Cutting-edge 1994 technology

### Challenges
- **Complex Architecture**: Three CPUs, each with different roles
- **Limited Tools**: Must build custom disassemblers
- **Sparse Documentation**: No official source code or comments
- **Time Investment**: Each layer reveals more complexity

### Rewards
- **Complete Understanding**: Will document every byte
- **Optimization Knowledge**: Learn techniques applicable today
- **Preservation**: Document for future generations
- **Personal Achievement**: Master-level reverse engineering

---

## 📧 Contributing

Found something interesting? Have questions? Want to help?

See [CONTRIBUTING.md](../CONTRIBUTING.md) for guidelines on:
- Code style
- Documentation format
- Testing requirements
- Pull request process

---

**"First, we understand every function, every event, how every location in memory works. Only then can we detect potential improvement points."**

*- The proper way to reverse engineer a 3D engine*

---

**Status**: 📖 Foundation documentation complete. Deep dive in progress. Stay tuned!
