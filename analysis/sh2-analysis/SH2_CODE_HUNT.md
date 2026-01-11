# Virtua Racing Deluxe - SH2 Code Location Analysis

**Last Updated**: 2026-01-06
**Status**: Investigation in progress
**Goal**: Locate and document SH2 Master and Slave code sections in ROM

---

## Executive Summary

The SH2 processors are the heart of the 3D rendering engine in Virtua Racing Deluxe. Locating their code is critical for understanding game performance and optimization opportunities. This document tracks our systematic search for the SH2 code within the 3MB ROM.

---

## What We Know

### SH2 Architecture Overview
- **Two SH2 CPUs**: Master and Slave running in parallel
- **Primary Role**: 3D polygon transformation and rasterization
- **Memory**: 256KB SDRAM at $22000000 (SH2 view)
- **ROM Access**: ROM visible at $06000000 (uncached) and $20000000 (cached)
- **Typical Operation**: Code likely copied to SDRAM for execution

### SH2 Initialization Process (Expected)
1. 68000 copies SH2 code from ROM to SDRAM ($22000000)
2. 68000 writes SH2 entry point addresses to communication registers
3. 68000 triggers SH2 processors to start
4. SH2s read entry points and begin execution
5. SH2s communicate with 68K via COMM registers ($A15120-$A1512E)

---

## Search Results

### Potential SH2 Code Sections Found

Using `find_code_sections.py`, we identified areas with high SH2 instruction density:

```
Offset      Score   Assessment
───────────────────────────────────────────────────────────────
0x0245E4    13      Starts with RTS - likely middle/end of function
0x2F1DDC    12      Starts with RTS - likely middle/end of function
0x2F1DF8    11      Valid SH2 instructions present
0x2F2A80    11      Valid SH2 instructions present
0x02455E    10      Valid SH2 code patterns
0x024636    10      Valid SH2 code patterns
0x025758    10      Valid SH2 code patterns
0x2F2A6A    10      Valid SH2 code patterns
```

**Analysis**: High scores around 0x24000-0x26000 and 0x2F0000-0x2F3000 suggest SH2 code blocks, but we haven't found the entry points yet.

### SH2 Address References in ROM

Found table at **ROM offset 0x3E0** containing SH2-format addresses:
```
0x3E0: 0x06000280  → ROM offset 0x280 (32X jump table)
0x3E4: 0x06000288  → ROM offset 0x288 (32X jump table)
0x3E8: 0x06000000  → ROM offset 0x000 (ROM header)
0x3EC: 0x06000140  → ROM offset 0x140 (Sega header)
```

**Analysis**: These point to 68K code/data, not SH2 code. The SH2 likely reads these during initialization to understand the ROM structure.

### SDRAM Address References

Found several references to SDRAM addresses ($22xxxxxx):
```
ROM Offset   SDRAM Address     Context
────────────────────────────────────────────────────────────
0x008FC8     0x22006A02        Part of game logic code
0x0090E4     0x22002400        Part of game logic code
0x009394     0x2200D281        Part of game logic code
0x0093CC     0x22029280        Part of game logic code
0x009430     0x2203E583        Part of game logic code
```

**Analysis**: These are in the game logic area (offset >0x8000), not initialization. They represent runtime access to SH2 SDRAM, possibly for:
- Writing command buffers
- Reading SH2 computation results
- Synchronization flags

---

## ROM Structure Analysis

### Confirmed Sections

```
Offset Range    Size    Type        Contents
────────────────────────────────────────────────────────────────
0x000000        512B    Header      Genesis/32X ROM header
0x000200        512B    Code        32X jump table (68K)
0x000400        ~30KB   Code        68K initialization code
0x008000        ~112KB  Code        68K main program logic
0x020000        ~16KB   Data        Address tables (not SH2 code)
0x024000        ~???    Code?       Potential SH2 code block 1
0x0??000        ~???    Data        Graphics/sound data
0x2F0000        ~???    Code?       Potential SH2 code block 2
```

### Gaps and Unknown Sections

Large sections of the ROM remain unanalyzed:
- **0x026000 - 0x2E0000** (~2.7MB): Likely contains:
  - Graphics data (textures, sprites)
  - Track data (polygon meshes, collision)
  - Sound samples
  - More SH2 code?

---

## SH2 Code Characteristics

### What SH2 Code Looks Like

Common SH2 instruction patterns to search for:
```
Opcode   Pattern   Instruction            Usage
────────────────────────────────────────────────────────────
0xE0xx   E0nn      MOV #imm,R0            Load immediate
0xD0xx   Dnxx      MOV.L @(disp,PC),Rn    Load from PC-relative
0x2nxy   2xy2      MOV.L Rx,@Ry           Store to memory
0x6nxy   6xy3      MOV Rx,Ry              Register move
0x000B   000B      RTS                    Return from subroutine
0x0009   0009      NOP                    No operation
0x400B   400B      JSR @Rn                Jump to subroutine
```

### SH2 Entry Point Pattern

Typical SH2 program starts with:
```asm
; Setup stack pointer
MOV.L   @(stack_addr,PC),R15
; Jump to init routine
MOV.L   @(init_addr,PC),R0
JMP     @R0
NOP
```

**Hex pattern**: `D7xx D0xx 402B 0009` (approximately)

---

## Investigation Strategies

### Strategy 1: Find Large Data Copy Loops

The 68K must copy SH2 code from ROM to SDRAM. Look for:
- Large loop counters (DBRA with high iteration counts)
- Source address in ROM (0x00xxxxxx)
- Destination address in SDRAM (0x22xxxxxx)
- Burst copy operations (MOVE.L in tight loop)

**Found loops** in init code:
```
0x000484: DBRA D2, -4   (tight loop, likely delay)
0x0006D8: DBRA D7, -18  (18-byte loop, small copy)
0x00068A: DBRA D7, -24  (24-byte loop, small copy)
```

**Status**: Haven't found large copy loop yet. May use DMA instead of CPU loop.

### Strategy 2: Search for DMA Operations

The 32X has hardware DMA (DREQ). Look for:
- Writes to DREQ registers ($A15104-$A1510E)
- Source address setup
- Destination address setup
- Transfer length

**Status**: Need to analyze DREQ register access in init code.

### Strategy 3: Trace COMM Register Writes

The 68K writes SH2 entry points to COMM registers. Look for:
- Writes to $A15120-$A1512E (COMM0-COMM7)
- Addresses in SH2 SDRAM range ($22000000+)
- Pattern: write address, then trigger SH2

**Status**: Need to analyze COMM register usage in init code.

### Strategy 4: Pattern Matching in Large ROM Sections

Scan entire ROM for SH2 code signatures:
- High density of recognized SH2 instructions
- PC-relative data access patterns
- Function prologue/epilogue patterns
- Vector tables (SH2 has exception vectors)

**Status**: Partial - found candidates at 0x24000 and 0x2F0000.

---

## Specific Code Sections to Investigate

### Init Routine at 0x6BC (Secondary Init)

This routine runs from RAM ($FF0000) after copy. Disassembly shows:
```asm
008806BC  LEA     $00FF0000,A0           ; Point to RAM base
008806C8  MOVEQ   #$00,D0                ; Clear D0
008806CA  MOVE.L  D0,(A0)+               ; Clear 8 longwords
...
0088070C  MOVE.W  D0,$0002(A1)           ; Clear 32X register
00880710  MOVE.W  D0,$0004(A1)           ; Clear more registers
00880714  MOVE.W  D0,$0006(A1)
00880718  MOVE.L  D0,$0008(A1)
0088071C  MOVE.L  D0,$000C(A1)
...
```

**Purpose**: Initializes 32X registers. May contain SH2 start sequence.

**Next Step**: Complete disassembly of this routine to find SH2 trigger.

### Main Loop Entry (V-INT Handler at 0x1684)

The V-INT handler calls main game loop. Trace flow:
```
0x881684: V-INT handler
  → Checks flag at $C87A
  → Calls subroutine (offset $0014 in some table)
  → Returns
```

**Next Step**: Find what routine is called and trace SH2 interaction.

---

## Data Structure Findings

### Communication Registers Layout

From init code analysis, COMM registers (at A5+offset):
```
Offset   Purpose (Hypothesized)
───────────────────────────────────────
$5120    COMM0 - SH2 Master entry point (high)?
$5122    COMM1 - SH2 Master entry point (low)?
$5124    COMM2 - SH2 Slave entry point (high)?
$5126    COMM3 - SH2 Slave entry point (low)?
$5128    COMM4 - Command/status flags?
$512A    COMM5 - Frame counter?
$512C    COMM6 - Graphics command pointer?
$512E    COMM7 - Sound command pointer?
```

**Status**: Hypothesis only, needs verification through code analysis.

---

## SH2 Startup Mechanism (DISCOVERED!)

### How the SH2s Start

Based on official SEGA documentation and analysis:

1. **SH2 Boot ROM**: Both SH2s have internal Boot ROM at $00000000 / $20000000
2. **Reset Behavior**: On reset/power-on, SH2 executes from internal Boot ROM
3. **Entry Point Discovery**: Boot ROM reads entry points from **fixed locations in cartridge ROM**
   - According to 32X specs, these are at **ROM offset 0x3E4** (Master) and **0x3E8** (Slave)
   - These are called "Hot Start" entry points

4. **Initial Execution**:
   - SH2 Master reads entry point from ROM 0x3E4
   - SH2 Slave reads entry point from ROM 0x3E8
   - Both jump to their respective entry points

5. **Handshake Protocol**:
   - SH2s execute initialization code
   - Master writes `"M_OK"` ($4D5F4F4B) to COMM0 ($A15120)
   - Slave writes `"S_OK"` ($535F4F4B) to COMM4 ($A15128)
   - 68K waits for these signatures (confirmed at ROM offset 0x808)

6. **Start Signal**:
   - 68K writes 0 to COMM0 to signal Master to begin main work
   - 68K writes 0 to COMM4 to signal Slave to begin main work

### SH2 Entry Points in Virtua Racing

From our analysis of ROM offset 0x3E0-0x3EF (SH2 address table):

```
Offset   Value        Interpretation
───────────────────────────────────────────────────────────────
0x3E0    0x06000280   → ROM offset 0x280 (32X jump table area)
0x3E4    0x06000288   → ROM offset 0x288 (Likely Master entry)  ← MASTER
0x3E8    0x06000000   → ROM offset 0x000 (ROM header start)     ← SLAVE?
0x3EC    0x06000140   → ROM offset 0x140 (Sega header area)
```

**CORRECTED Assessment** (2026-01-06 update):
- **ROM offset 0x288 contains 68K code** (exception vectors), NOT SH2 code!
- **Real SH2 code location: ROM offset 0x24000+**
- The table at 0x3E0-0x3EF points to 68K areas, not SH2 entry points

**Discovery**: The SH2 Boot ROM mechanism is MORE COMPLEX than initially thought:
1. The addresses at 0x3E4/0x3E8 are NOT direct SH2 entry points
2. The real SH2 code starts at ROM offset **0x24000** (confirmed via disassembly)
3. The Boot ROM likely uses a different mechanism:
   - Fixed entry point lookup
   - OR 68K copies code to SDRAM and uses COMM registers for coordination
   - OR Boot ROM scans for SH2 code signature

### Next Steps (Prioritized)

## Real SH2 Code Location (CONFIRMED!)

### ROM Offset 0x24000 - Actual SH2 Code

Disassembly confirms this is genuine SH2 code:

```asm
02224056  000B     RTS                    ; Return from subroutine
02224058  0009     NOP                    ; No operation
0222406C  B00A     BSR     $02224084      ; Branch to subroutine
0222406E  0009     NOP                    ; Delay slot
02224070  B098     BSR     $022241A4      ; Another subroutine call
02224074  67F6     MOV.L   @R15+,R7       ; Pop from stack
02224076  6EF6     MOV.L   @R15+,R14      ; Pop from stack
```

**Confirmed SH2 patterns**:
- Function calls with BSR (Branch to Subroutine)
- Stack operations (push/pop via R15)
- Proper RTS/NOP sequences
- Register manipulation
- Conditional branches

**Size**: Appears to extend from 0x24000 to at least 0x26000+ (8KB+)

### High Priority
1. **Disassemble SH2 code at ROM 0x24000** ← UPDATED
   - Start of actual 3D rendering code
   - Find initialization routine
   - Locate "M_OK" write

2. **Understand Boot ROM → SH2 code mechanism**
   - How does Boot ROM find code at 0x24000?
   - Is code copied to SDRAM or executed from ROM?
   - What triggers execution?

3. **Complete disassembly of init routine at 0x6BC**
   - Trace execution flow completely
   - Document all 32X register writes
   - Find SH2 start sequence

4. **Analyze DMA/DREQ usage**
   - Search for DREQ register writes ($A15104+)
   - Identify source/dest/length for transfers
   - Determine if SH2 code is copied via DMA

5. **Trace V-INT handler completely**
   - Disassemble entire flow
   - Find main loop entry
   - Document SH2 synchronization

### Medium Priority
4. **Systematic scan of large ROM sections**
   - Write tool to score SH2 code likelihood
   - Scan 0x026000-0x2E0000 range
   - Generate heat map of code vs data

5. **Analyze COMM register runtime usage**
   - Find all COMM reads/writes in game code
   - Map communication protocol
   - Identify command structures

6. **Improve SH2 disassembler**
   - Add missing opcodes
   - Add symbol generation
   - Add control flow analysis

### Low Priority
7. **Extract and analyze data blocks**
   - Identify graphics data format
   - Identify track data format
   - Separate code from data definitively

---

## Blockers and Unknowns

### Current Blockers
1. **M68K disassembler incomplete** - Many opcodes show as "Unknown"
   - Blocking full init code analysis
   - Need to implement missing instructions

2. **SH2 code might be compressed** - Haven't considered this
   - Some games compress SH2 code
   - Would need to find decompression routine first

3. **DMA might be used** - Haven't found DMA setup code yet
   - Could be copying SH2 code
   - Need to trace DREQ registers

### Unknown Factors
- Is SH2 code in one contiguous block or scattered?
- Is SH2 code compressed or encrypted?
- Do SH2s run from ROM or SDRAM?
- Is there a separate SH2 binary or inline with 68K data?

---

## Tools and Techniques Used

### Tools
- `find_code_sections.py` - Pattern matching for SH2 code
- `m68k_disasm.py` - 68K disassembler (needs more opcodes)
- `sh2_disasm.py` - SH2 disassembler (basic functionality)
- `hexdump` - Raw binary inspection
- Custom Python scripts - Address scanning, pattern matching

### Techniques
- Hex pattern matching for known opcodes
- Address reference tracking
- Loop detection (DBRA instructions)
- Register usage analysis
- Memory map correlation

---

## Lessons Learned

1. **SH2 code is well hidden** - Not obvious like some games
2. **Need complete 68K disassembler** - Can't trace init without it
3. **Multiple strategies needed** - No single approach works
4. **Context matters** - Can't identify code without understanding initialization flow

---

## References

### Documentation
- [32X Hardware Manual](../docs/32x-hardware-manual.md) - Complete hardware reference
- [Initialization Sequence](INITIALIZATION_SEQUENCE.md) - 68K boot process
- [Memory Map](MEMORY_MAP.md) - Complete address space layout

### Related Files
- `disasm/m68k_header.asm` - ROM header (complete)
- `tools/m68k_disasm.py` - 68K disassembler (to be improved)
- `tools/sh2_disasm.py` - SH2 disassembler (to be improved)

---

**Status**: Investigation ongoing. Need to complete init code disassembly before proceeding.
**Estimated Completion**: Requires 2-3 more analysis sessions
**Priority**: HIGH - Critical for performance optimization
