#!/usr/bin/env python3
"""
Annotate 68K module files with disassembled mnemonics.

Takes a module file with DC.W data and adds 68K instruction comments.
The DC.W data is preserved for byte-perfect builds.

Usage:
    python3 annotate_68k_module.py <module_file> [--output <output_file>]
"""

import re
import sys
import argparse
from pathlib import Path

# Import the 68K disassembler
sys.path.insert(0, str(Path(__file__).parent))
from m68k_disasm import M68KDisassembler


class M68KModuleAnnotator:
    """Annotate 68K module files with disassembled instructions."""

    def __init__(self):
        self.disasm = None

    def decode_word(self, opcode, addr):
        """Decode a single 16-bit word as 68K instruction (or start of multi-word instruction)."""
        # Create dummy ROM data for the disassembler
        rom_data = bytes([opcode >> 8, opcode & 0xFF])
        disasm = M68KDisassembler(rom_data, 0, addr)
        try:
            instruction, size = disasm.decode_opcode(opcode, addr)
            return instruction, size // 2  # Convert bytes to words
        except:
            return f"DC.W ${opcode:04X}", 1

    def annotate_file(self, input_path, output_path=None):
        """Annotate a module file with 68K mnemonics."""
        with open(input_path, 'r') as f:
            lines = f.readlines()

        output_lines = []
        current_addr = None

        for line in lines:
            # Parse org directive to get base address
            org_match = re.match(r'\s*org\s+\$([0-9A-Fa-f]+)', line)
            if org_match:
                current_addr = int(org_match.group(1), 16)
                output_lines.append(line)
                continue

            # Parse DC.W lines
            dcw_match = re.match(r'(\s+DC\.W\s+)(.+?)(;.*)$', line)
            if dcw_match and current_addr is not None:
                indent = dcw_match.group(1)
                data = dcw_match.group(2)
                comment = dcw_match.group(3)

                # Extract address from comment if present
                addr_match = re.search(r'\$([0-9A-Fa-f]+)', comment)
                if addr_match:
                    line_addr = int(addr_match.group(1), 16)
                else:
                    line_addr = current_addr

                # Parse hex values
                hex_values = re.findall(r'\$([0-9A-Fa-f]+)', data)
                words = [int(h, 16) for h in hex_values]

                # Disassemble instructions for this line
                mnemonics = []
                i = 0
                addr = line_addr
                while i < len(words):
                    opcode = words[i]

                    # Create a temporary ROM with remaining words for multi-word instructions
                    remaining_words = words[i:]
                    rom_bytes = []
                    for w in remaining_words:
                        rom_bytes.append(w >> 8)
                        rom_bytes.append(w & 0xFF)

                    rom_data = bytes(rom_bytes)
                    disasm = M68KDisassembler(rom_data, 0, addr)

                    try:
                        # Use decode_opcode which returns (instruction, size)
                        instruction, size = disasm.decode_opcode(opcode, addr)
                        words_consumed = size // 2
                        mnemonics.append(instruction)
                        i += words_consumed
                        addr += size
                    except Exception as e:
                        # Fallback for unknown instructions
                        mnemonics.append(f"DC.W ${opcode:04X}")
                        i += 1
                        addr += 2

                # Build annotated line
                mnemonic_str = " ; ".join(mnemonics)

                # Format: preserve original DC.W line, add mnemonics in comment
                output_lines.append(f"{indent}{data}{comment} {mnemonic_str}\n")

                # Update address for next line (8 words per line typically)
                current_addr = line_addr + (len(words) * 2)
            else:
                # Pass through non-DC.W lines unchanged
                output_lines.append(line)

        # Write output
        if output_path is None:
            output_path = input_path

        with open(output_path, 'w') as f:
            f.writelines(output_lines)

        print(f"✓ Annotated {input_path}")
        if output_path != input_path:
            print(f"✓ Written to {output_path}")


def main():
    parser = argparse.ArgumentParser(
        description='Annotate 68K module files with disassembled mnemonics'
    )
    parser.add_argument('input', type=Path, help='Input module file')
    parser.add_argument('--output', type=Path, help='Output file (default: overwrite input)')

    args = parser.parse_args()

    if not args.input.exists():
        print(f"Error: {args.input} not found")
        sys.exit(1)

    annotator = M68KModuleAnnotator()
    annotator.annotate_file(args.input, args.output)


if __name__ == '__main__':
    main()
