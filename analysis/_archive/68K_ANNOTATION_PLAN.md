# 68K Code Annotation Plan

**Project**: Virtua Racing Deluxe (USA).32x
**Target**: Motorola 68000 CPU code
**Date**: 2026-01-06

## Executive Summary

Following the successful 100% completion of SH2 3D engine annotation (109 functions), we now turn to the 68K side of the codebase. The 68K code is significantly larger and serves different purposes - primarily handling initialization, I/O, synchronization with SH2, and game logic coordination.

## Code Statistics

### Overview
| Metric | Value |
|--------|-------|
| Total Function Entry Points | 769 |
| Total RTS Instructions | 822 |
| Unique JSR.L Targets | 83 |
| Unique BSR Targets | 689 |
| Hotspot Functions (10+ calls) | 9 |

### Functions by ROM Region
| Region | Address Range | Functions | Purpose |
|--------|---------------|-----------|---------|
| Boot/Init | 0x000200-0x001FFF | 17 | System initialization, MARS setup |
| Low Code | 0x002000-0x003FFF | 33 | Core utilities, memory operations |
| Main Code 1 | 0x004000-0x00FFFF | 124 | Primary game logic |
| Main Code 2 | 0x010000-0x01FFFF | 61 | Extended game logic |
| SH2 Region | 0x020000-0x02FFFF | 126 | SH2 code (already documented) |
| Extended | 0x030000-0x0FFFFF | 123 | Data handlers, track logic |
| High ROM | 0x100000+ | 285 | Game data, track data, graphics |

**Note**: The 0x020000-0x02FFFF region overlaps with SH2 code. These BSR targets may be false positives from the SH2 code region we already documented.

## Key Entry Points

### Interrupt Handlers (Critical)
| Vector | Address | Purpose |
|--------|---------|---------|
| V-INT (Level 6) | 0x001684 | Vertical blank interrupt - main timing |
| H-INT (Level 4) | 0x00170A | Horizontal interrupt - minimal handler |
| Default Handler | 0x000832 | Exception handler - spin loop |

### Initialization Chain
| Address | Purpose |
|---------|---------|
| 0x0003F0 | Entry point (from vector table) |
| 0x000832 | Default exception handler |
| 0x000838 | 32X adapter initialization |

## Top Hotspot Functions

These functions are called most frequently and should be prioritized:

| Rank | Address | Calls | Priority |
|------|---------|-------|----------|
| 1 | 0x004998 | 21 | HIGH |
| 2 | 0x002080 | 21 | HIGH |
| 3 | 0x0049AA | 21 | HIGH |
| 4 | 0x00FB36 | 17 | HIGH |
| 5 | 0x00179E | 16 | HIGH |
| 6 | 0x00205E | 16 | HIGH |
| 7 | 0x0014BE | 12 | HIGH |
| 8 | 0x00204A | 11 | HIGH |
| 9 | 0x0026C8 | 10 | HIGH |
| 10 | 0x0188EC | 9 | MEDIUM |
| 11 | 0x010674 | 9 | MEDIUM |
| 12 | 0x030000 | 8 | MEDIUM |
| 13 | 0x00E52C | 8 | MEDIUM |

## Annotation Priorities

### Priority 1: Critical System Functions (17 functions)
**Region**: 0x000200-0x001FFF (Boot/Init)

Focus on:
- Entry point chain (0x3F0 → initialization)
- 32X adapter setup
- SH2 synchronization
- Memory initialization
- Exception handlers

### Priority 2: Interrupt Handlers (3+ functions)
**Addresses**: V-INT (0x1684), H-INT (0x170A), Default (0x832)

Focus on:
- V-blank processing
- SH2 communication
- Frame timing
- Controller input

### Priority 3: Hotspot Functions (9 functions with 10+ calls)
**Goal**: Understand the most-used utility functions

Key targets:
- 0x004998 (21 calls) - Wait/sync function?
- 0x002080 (21 calls) - Status handler?
- 0x0049AA (21 calls) - Related to 0x4998?
- 0x00179E (16 calls) - Input/compare function?

### Priority 4: Low Code Utilities (33 functions)
**Region**: 0x002000-0x003FFF

Focus on:
- Memory copy routines
- Data conversion
- Communication helpers

### Priority 5: Main Game Logic (124 functions)
**Region**: 0x004000-0x00FFFF

Focus on:
- Game state management
- Race logic
- Car physics interface
- Track selection

### Priority 6: Remaining Functions (~465 functions)
**Regions**: 0x010000+

Lower priority - document as needed for understanding.

## Technical Challenges

### Disassembler Improvements Needed

The current m68k_disasm.py has issues with:
1. **Mode 6 addressing** (d8(An,Xn)) - index register modes
2. **Certain opcode patterns** - showing as Unknown or incorrect
3. **Data vs code detection** - some data interpreted as code

### 68K Register Conventions (To Document)

| Register | Common Usage |
|----------|--------------|
| D0-D7 | Data registers (return values in D0) |
| A0-A3 | Scratch address registers |
| A4 | Often MARS_SYS base ($A15100) |
| A5 | Often MD I/O base ($A10000) |
| A6 | Frame pointer or context |
| A7 | Stack pointer (SP) |

### Memory Map (68K Perspective)

| Address | Size | Description |
|---------|------|-------------|
| $000000-$3FFFFF | 4MB | ROM (mapped to $880000) |
| $880000-$8FFFFF | 512KB | ROM mirror (direct access) |
| $A00000-$A0FFFF | 64KB | Z80 RAM |
| $A10000-$A1FFFF | - | I/O and control registers |
| $A15100-$A151FF | - | 32X system registers |
| $C00000-$C0001F | - | VDP registers |
| $FF0000-$FFFFFF | 64KB | Work RAM |

## Documentation Deliverables

### Files to Create
1. `analysis/68K_FUNCTION_INVENTORY.md` - Complete function list
2. `analysis/68K_INTERRUPT_HANDLERS.md` - Interrupt documentation
3. `analysis/68K_COMM_PROTOCOL.md` - SH2 communication protocol
4. `disasm/m68k_annotated.asm` - Annotated disassembly

### Format
Follow the same annotation template as SH2 work:
```asm
; ═══════════════════════════════════════════════════════════════════════════
; func_XXX: [Descriptive Name]
; ═══════════════════════════════════════════════════════════════════════════
; Address: 0x00XXXX - 0x00XXXX
; Size: XX bytes
; Called by: [list callers]
; Calls: [list callees]
;
; Purpose: [description]
;
; Input: D0 = xxx, A0 = xxx
; Output: D0 = xxx
; ═══════════════════════════════════════════════════════════════════════════
```

## Estimated Effort

| Priority | Functions | Est. Sessions |
|----------|-----------|---------------|
| 1. Boot/Init | 17 | 2-3 |
| 2. Interrupts | 3 | 1 |
| 3. Hotspots | 9 | 2-3 |
| 4. Low Code | 33 | 3-4 |
| 5. Main Logic | 124 | 8-10 |
| 6. Extended | 465+ | Many |

**Total**: Significantly larger than SH2 project. Recommend focusing on Priorities 1-4 first (~62 functions).

## Comparison: SH2 vs 68K

| Aspect | SH2 3D Engine | 68K Code |
|--------|---------------|----------|
| Functions | 109 | 769 |
| Code Region | 8KB | ~200KB+ |
| Purpose | 3D rendering | System control |
| Complexity | High (math) | Medium (I/O) |
| Documentation | 100% complete | 0% complete |

## Next Steps

1. **Improve disassembler** - Fix decoding issues
2. **Create function inventory** - List all 769 functions with sizes
3. **Analyze V-INT handler** - Critical for understanding timing
4. **Document entry point** - Trace initialization sequence
5. **Map SH2 communication** - Understand COMM register usage

## Success Criteria

- [ ] All interrupt handlers documented
- [ ] Entry point chain traced
- [ ] Top 30 hotspot functions annotated
- [ ] SH2 communication protocol documented
- [ ] Boot sequence understood
- [ ] 50+ functions fully annotated
