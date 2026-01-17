#!/usr/bin/env python3
"""
Fix invalid mnemonics in assembly files by replacing them with DC.W using actual ROM opcodes.

Handles:
- <EA:XX> placeholders from disassembler
- MOVEM.L with (A7)+ syntax (not supported by vasm)
- Bit operations on address registers (BTST/BCLR/BSET/BCHG on A0-A7)
"""

import re
from pathlib import Path

ROM_PATH = Path('Virtua Racing Deluxe (USA).32x')
SECTIONS_DIR = Path('disasm/sections')

def read_rom_word(rom_data, address):
    """Read a big-endian word from ROM at the given address"""
    return int.from_bytes(rom_data[address:address+2], 'big')

def fix_line(line, rom_data):
    """Fix a line containing <EA:XX>, invalid MOVEM, or invalid bit operations by replacing with DC.W"""
    # Check for any of the invalid patterns
    has_ea = '<EA:' in line
    has_movem_invalid = re.search(r'MOVEM\.[LW]\s+.*,(D[0-7]|\(A[0-7]\)\+)', line) is not None
    has_bit_op_on_areg = re.search(r'(BTST|BCLR|BSET|BCHG)\s+.*,A[0-7]', line) is not None
    has_and_with_areg = re.search(r'AND(\.[BWL])?\s+(A[0-7],[DA][0-7]|[DA][0-7],A[0-7])', line) is not None
    has_bit_op_two_immediate = re.search(r'(BTST|BCLR|BSET|BCHG)\s+#\d+,#', line) is not None
    has_or_and_to_immediate = re.search(r'(OR|AND)(\.[BWL])?\s+[DA][0-7],#', line) is not None
    has_move_byte_from_areg = re.search(r'MOVE\.B\s+A[0-7],', line) is not None
    has_branch_absolute = re.search(r'(B(CC|CS|EQ|GE|GT|HI|LE|LS|LT|MI|NE|PL|VC|VS|SR|RA)|DB(CC|CS|EQ|F|GE|GT|HI|LE|LS|LT|MI|NE|PL|T|VC|VS|RA))(\.[SWL])?\s+[DA]?\d?,?\$008[89]', line) is not None
    has_large_displacement = re.search(r'\$[89A-F][0-9A-F]{3}\(A[0-7]\)', line) is not None
    has_pc_relative_absolute = re.search(r'(JSR|LEA|PEA|MOVE[AQ]?)\s+.*\$008[89][0-9A-F]{4}\(PC\)', line) is not None
    has_large_byte_immediate = re.search(r'(MOVE|CMPI?|ADDI?|SUBI?|ANDI?|ORI?|EORI?)\.B\s+#\$[0-9A-F]{4},', line) is not None
    has_absolute_short_large = re.search(r'\$[89A-F][0-9A-F]{3}\.W', line) is not None

    if not (has_ea or has_movem_invalid or has_bit_op_on_areg or has_and_with_areg or
            has_bit_op_two_immediate or has_or_and_to_immediate or has_move_byte_from_areg or
            has_branch_absolute or has_large_displacement or has_pc_relative_absolute or
            has_large_byte_immediate or has_absolute_short_large):
        return line, False

    # Extract address from comment: ; $XXXXXX
    addr_match = re.search(r';\s*\$([0-9A-F]+)', line)
    if not addr_match:
        print(f"  WARNING: Cannot extract address from: {line.strip()}")
        return line, False

    addr_str = addr_match.group(1)
    address = int(addr_str, 16)

    # Determine instruction size by checking opcode and addressing mode
    try:
        opcode = read_rom_word(rom_data, address)
    except IndexError:
        print(f"  WARNING: Address 0x{addr_str} out of ROM range")
        return line, False

    # Determine if this is a multi-word instruction
    num_words = 1

    # Check if it's a branch with word displacement (Bcc.W opcode is 0x6X00)
    if (opcode & 0xF000) == 0x6000 and (opcode & 0x00FF) == 0x0000:
        num_words = 2  # Bcc.W: opcode + word displacement
    # Check if it's a DBRA/DBcc (opcode 0x5XC8-0x5XFF with extension word)
    elif (opcode & 0xF0C0) == 0x50C8:
        num_words = 2  # DBcc: opcode + word displacement
    # Check for JSR/JMP/LEA/PEA with various addressing modes that need extension words
    elif (opcode & 0xFFC0) in [0x4EB8, 0x4EB9, 0x4EBA, 0x4EBB]:  # JSR variants
        if (opcode & 0x0007) in [0, 1]:  # Absolute or PC-relative
            num_words = 2
    elif (opcode & 0xFFC0) in [0x41F8, 0x41F9, 0x41FA, 0x41FB]:  # LEA variants
        if (opcode & 0x0007) in [0, 1, 2]:
            num_words = 2

    # Extract indentation
    indent_match = re.match(r'^(\s*)', line)
    indent = indent_match.group(1) if indent_match else '        '

    # Read all words and create DC.W directives
    words = []
    for i in range(num_words):
        try:
            word = read_rom_word(rom_data, address + (i * 2))
            words.append(word)
        except IndexError:
            print(f"  WARNING: Address 0x{address + (i*2):06X} out of ROM range")
            return line, False

    # Create DC.W directive(s)
    if num_words == 1:
        new_line = f"{indent}DC.W ${words[0]:04X}               ; ${addr_str}\n"
    else:
        # Multiple words: output as single line with all values
        dc_words = ', '.join([f'${w:04X}' for w in words])
        new_line = f"{indent}DC.W {dc_words}     ; ${addr_str}\n"

    return new_line, True

def fix_file(filepath, rom_data):
    """Fix all invalid mnemonics in a file (<EA:XX>, MOVEM.L with (A7)+, bit ops on address regs)"""
    lines = []
    changes = 0

    with open(filepath, 'r') as f:
        for line_num, line in enumerate(f, 1):
            new_line, changed = fix_line(line, rom_data)
            lines.append(new_line)
            if changed:
                changes += 1

    if changes > 0:
        with open(filepath, 'w') as f:
            f.writelines(lines)
        print(f"✓ Fixed {changes} lines in {filepath.name}")
        return changes

    return 0

def main():
    if not ROM_PATH.exists():
        print(f"Error: ROM file not found: {ROM_PATH}")
        return 1

    if not SECTIONS_DIR.exists():
        print(f"Error: Sections directory not found: {SECTIONS_DIR}")
        return 1

    # Read entire ROM into memory
    print(f"Reading ROM: {ROM_PATH}")
    with open(ROM_PATH, 'rb') as f:
        rom_data = f.read()

    print(f"ROM size: {len(rom_data)} bytes\n")

    total_fixes = 0
    for asm_file in sorted(SECTIONS_DIR.glob('*.asm')):
        fixes = fix_file(asm_file, rom_data)
        total_fixes += fixes

    print(f"\n✓ Total fixes: {total_fixes}")
    return 0

if __name__ == '__main__':
    import sys
    sys.exit(main())
