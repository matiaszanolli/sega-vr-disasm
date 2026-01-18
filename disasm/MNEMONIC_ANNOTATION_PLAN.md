# Mnemonic Annotation Plan for DC.W Sections

**Purpose:** Add human-readable 68000 instruction mnemonics as comments to the pure DC.W disassembly while preserving 100% byte accuracy.

---

## Overview

The current disassembly uses pure DC.W statements that assemble to exact original ROM bytes. This plan describes how to add mnemonic comments for readability without affecting the assembled output.

### Current Format
```asm
        dc.w    $4EF9        ; $000200
        dc.w    $0088        ; $000202
        dc.w    $0838        ; $000204
```

### Target Format
```asm
        dc.w    $4EF9        ; $000200  JMP
        dc.w    $0088        ; $000202  | $00880838
        dc.w    $0838        ; $000204  |
```

Or more verbose:
```asm
        dc.w    $4EF9        ; $000200  JMP $00880838
        dc.w    $0088        ; $000202
        dc.w    $0838        ; $000204
```

---

## Critical Rules

### 1. NEVER Modify the DC.W Values
The hex values are the ROM bytes. Changing them breaks the build.

**WRONG:**
```asm
        dc.w    $4EF9        ; JMP - oops I changed this from $4EFA
```

**RIGHT:**
```asm
        dc.w    $4EF9        ; $000200  JMP $00880838
```

### 2. All Changes Go in Comments Only
Everything after the semicolon is a comment and doesn't affect assembly.

### 3. Preserve Address Comments
The `; $XXXXXX` address comments are valuable for navigation. Keep them.

### 4. When Uncertain, Skip It
If an instruction decoding is ambiguous, leave it as-is. Better no comment than a wrong comment.

---

## 68000 Instruction Encoding Reference

### Quick Decode Table (First Word)

| Opcode Range | Instruction Type |
|--------------|-----------------|
| $0000-$00FF | ORI, ANDI, SUBI, ADDI, EORI, CMPI, BTST/BCHG/BCLR/BSET |
| $0200-$02FF | ANDI |
| $0400-$04FF | SUBI |
| $0600-$06FF | ADDI |
| $0800-$08FF | BTST/BCHG/BCLR/BSET (immediate bit number) |
| $0A00-$0AFF | EORI |
| $0C00-$0CFF | CMPI |
| $1000-$1FFF | MOVE.B |
| $2000-$2FFF | MOVE.L |
| $3000-$3FFF | MOVE.W |
| $4000-$4FFF | Miscellaneous (CLR, NEG, NOT, TST, MOVEM, LEA, PEA, JMP, JSR, RTS, RTE, NOP, TRAP, LINK, UNLK, SWAP, EXT) |
| $5000-$5FFF | ADDQ, SUBQ, Scc, DBcc |
| $6000-$6FFF | Bcc (branches), BSR, BRA |
| $7000-$7FFF | MOVEQ |
| $8000-$8FFF | OR, DIV, SBCD |
| $9000-$9FFF | SUB, SUBX, SUBA |
| $A000-$AFFF | Line-A (unimplemented) |
| $B000-$BFFF | CMP, EOR, CMPM, CMPA |
| $C000-$CFFF | AND, MUL, ABCD, EXG |
| $D000-$DFFF | ADD, ADDX, ADDA |
| $E000-$EFFF | Shift/Rotate (ASL, ASR, LSL, LSR, ROL, ROR, ROXL, ROXR) |
| $F000-$FFFF | Line-F (coprocessor/unimplemented) |

### Common Single-Word Instructions

| Opcode | Mnemonic |
|--------|----------|
| $4E71 | NOP |
| $4E75 | RTS |
| $4E73 | RTE |
| $4E77 | RTR |
| $4E76 | TRAPV |
| $4AFC | ILLEGAL |

### Common Patterns

#### MOVEQ (Quick Move Immediate)
- Format: `$7XYZ` where X = register, YZ = 8-bit value
- Example: `$7000` = MOVEQ #0,D0
- Example: `$7001` = MOVEQ #1,D0
- Example: `$7201` = MOVEQ #1,D1
- Example: `$7EFF` = MOVEQ #-1,D7 (or MOVEQ #$FF,D7)

#### BRA/BSR/Bcc (Branches)
- `$6000` + displacement = BRA
- `$6100` + displacement = BSR
- `$6200` = BHI, `$6300` = BLS, `$6400` = BCC, `$6500` = BCS
- `$6600` = BNE, `$6700` = BEQ, `$6800` = BVC, `$6900` = BVS
- `$6A00` = BPL, `$6B00` = BMI, `$6C00` = BGE, `$6D00` = BLT
- `$6E00` = BGT, `$6F00` = BLE

If low byte is $00, next word is 16-bit displacement.
If low byte is $FF, next two words are 32-bit displacement.
Otherwise, low byte is 8-bit displacement.

#### JMP/JSR
- `$4EF9` + 32-bit addr = JMP absolute long
- `$4EF8` + 16-bit addr = JMP absolute short
- `$4EB9` + 32-bit addr = JSR absolute long
- `$4EB8` + 16-bit addr = JSR absolute short

#### LEA (Load Effective Address)
- `$41F9` + 32-bit addr = LEA addr,A0
- `$43F9` + 32-bit addr = LEA addr,A1
- `$45F9` + 32-bit addr = LEA addr,A2
- ... pattern: `$4XF9` where X = (reg * 2) + 1

#### MOVEA (Move to Address Register)
- `$2040` = MOVEA.L D0,A0
- `$2079` + 32-bit addr = MOVEA.L (addr).L,A0

#### MOVE.W to/from SR
- `$46FC` + word = MOVE #word,SR
- `$40E7` = MOVE SR,-(SP)

---

## Effective Address Encoding

The 68000 uses a 6-bit effective address field (3 bits mode, 3 bits register):

| Mode | Register | Syntax | Description |
|------|----------|--------|-------------|
| 000 | Dn | Dn | Data Register Direct |
| 001 | An | An | Address Register Direct |
| 010 | An | (An) | Address Register Indirect |
| 011 | An | (An)+ | Address Register Indirect with Postincrement |
| 100 | An | -(An) | Address Register Indirect with Predecrement |
| 101 | An | d(An) | Address Register Indirect with Displacement |
| 110 | An | d(An,Xn) | Address Register Indirect with Index |
| 111 | 000 | (xxx).W | Absolute Short |
| 111 | 001 | (xxx).L | Absolute Long |
| 111 | 010 | d(PC) | Program Counter with Displacement |
| 111 | 011 | d(PC,Xn) | Program Counter with Index |
| 111 | 100 | #imm | Immediate |

---

## Workflow

### Step 1: Set Up Reference Tools

Use the original ROM for verification:
```bash
# Compare rebuilt ROM with original
make all
cmp roms/vrd_usa.32x build/vr_rebuild.32x
# Should report: files are identical
```

### Step 2: Work Section by Section

Start with the entry point section (code_200.asm) and work forward:

```bash
# List sections in order
ls -1 disasm/sections/code_*.asm | sort -t'_' -k2 -V | head -20
```

### Step 3: Decode and Annotate

For each section:

1. **Read the current DC.W values**
2. **Look up the opcode in the reference table**
3. **Determine instruction length** (how many words)
4. **Add mnemonic as comment**
5. **Verify build still matches**

Example session:
```
; Before
        dc.w    $4EF9        ; $000200
        dc.w    $0088        ; $000202
        dc.w    $0838        ; $000204

; After analysis: $4EF9 = JMP, followed by 32-bit address $00880838
        dc.w    $4EF9        ; $000200  JMP $00880838
        dc.w    $0088        ; $000202
        dc.w    $0838        ; $000204
```

### Step 4: Handle Multi-Word Instructions

Many instructions span 2-6 words. Mark continuation words with `|`:

```asm
        dc.w    $41F9        ; $000208  LEA $00FFC000,A0
        dc.w    $00FF        ; $00020A  |
        dc.w    $C000        ; $00020C  |
```

### Step 5: Verify After Each Section

```bash
make clean && make all
cmp roms/vrd_usa.32x build/vr_rebuild.32x
# Must always report: files are identical
```

---

## Priority Order

### High Priority (decode first)
1. **code_200.asm** - Entry point, vector table references
2. **code_2200.asm** through **code_a200.asm** - Main initialization
3. Any section with heavy branching (lots of $6xxx opcodes)

### Medium Priority
4. Sections with clear structure (loops, subroutines)
5. Sections referenced by known code

### Low Priority
6. Data sections (tables, graphics) - may not be code at all
7. Sections above $100000 (less critical)

---

## Common Gotchas

### 1. Data vs Code
Not all ROM bytes are instructions. Tables, graphics, and strings should NOT have mnemonic comments.

Signs it might be data:
- Repeating patterns
- ASCII values ($20-$7E range)
- Values that don't decode to valid instructions

### 2. Word Alignment
68000 instructions must be word-aligned (even addresses). If you see odd patterns, it might be data or a disassembly offset error.

### 3. Immediate Values Can Look Like Opcodes
An immediate value of $4E75 is just a number, not RTS. Context matters.

### 4. Address Calculations
Remember that code runs at address $880000 + file_offset:
- ROM offset $000200 → CPU address $880200
- ROM offset $001000 → CPU address $881000

Branch targets are calculated from PC (which is 2-4 bytes past the instruction start).

---

## Tools

### Existing Tool
```bash
# Generate fresh DC.W from ROM (if needed)
python tools/rom_to_dcw.py roms/vrd_usa.32x 0x200 0x2200 output.asm
```

### Suggested Enhancement
Create `tools/annotate_dcw.py` that:
1. Reads a DC.W section file
2. Decodes instructions (read-only analysis)
3. Outputs annotated version with mnemonics in comments
4. Never modifies the DC.W values themselves

---

## Example Annotated Section

```asm
; ============================================================================
; Code Section ($000200-$0021FF)
; Entry point and initial vectors
; ============================================================================

        org     $000200

        dc.w    $4EF9        ; $000200  JMP $00880838
        dc.w    $0088        ; $000202
        dc.w    $0838        ; $000204
        dc.w    $0000        ; $000206  (vector table entry)
        dc.w    $0824        ; $000208
        dc.w    $0000        ; $00020A  (vector table entry)
        dc.w    $0830        ; $00020C
        ; ...
        dc.w    $7000        ; $000300  MOVEQ #0,D0
        dc.w    $6100        ; $000302  BSR.W $000306+displacement
        dc.w    $0010        ; $000304  | displacement = +$0010
        dc.w    $4E75        ; $000306  RTS
```

---

## Summary

1. **Comments only** - never change DC.W values
2. **Verify often** - `make all && cmp` after each section
3. **Skip uncertain** - better no annotation than wrong annotation
4. **Work incrementally** - one section at a time
5. **Preserve addresses** - keep the `; $XXXXXX` comments

This approach ensures the ROM always assembles correctly while gradually improving readability.
