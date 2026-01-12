#!/usr/bin/env python3
"""
Annotate SH2 module files with disassembled mnemonics.

Takes a module file with DC.W data and adds SH2 instruction comments.
The DC.W data is preserved for byte-perfect builds.

Usage:
    python3 annotate_sh2_module.py <module_file> [--output <output_file>]
"""

import re
import sys
import argparse
from pathlib import Path

# Import the SH2 disassembler
sys.path.insert(0, str(Path(__file__).parent))
from sh2_disasm import SH2Disassembler


class SH2ModuleAnnotator:
    """Annotate SH2 module files with disassembled instructions."""

    def __init__(self):
        # Create a minimal disassembler (we'll feed it data directly)
        self.disasm = None

    def decode_word(self, opcode, addr):
        """Decode a single 16-bit word as SH2 instruction."""
        # Create dummy ROM data for the disassembler
        rom_data = bytes([opcode >> 8, opcode & 0xFF])
        disasm = SH2Disassembler(rom_data, 0, addr)
        instruction, _ = disasm.decode_opcode(opcode, addr)
        return instruction

    def is_likely_data(self, words, addr):
        """
        Heuristic to detect if a sequence of words is likely data, not code.

        Data patterns:
        - Sequential/incremental values (lookup tables)
        - Values clustered around a specific range
        - Repeated patterns
        """
        if len(words) < 4:
            return False

        # Check for sequential/near-sequential pattern (lookup tables)
        diffs = [abs(words[i+1] - words[i]) for i in range(len(words)-1)]
        avg_diff = sum(diffs) / len(diffs)
        if avg_diff < 20:  # Very small increments = likely table
            return True

        # Check for sine table pattern (values around 0x3FFF = 16383)
        sine_range = sum(1 for w in words if 0x3D00 <= w <= 0x4000)
        if sine_range > len(words) * 0.8:  # 80% in sine range
            return True

        return False

    def annotate_file(self, input_path, output_path=None):
        """Annotate a module file with SH2 mnemonics."""
        with open(input_path, 'r') as f:
            lines = f.readlines()

        output_lines = []
        current_addr = None
        in_data_section = False
        data_buffer = []

        for line in lines:
            # Parse org directive to get base address
            org_match = re.match(r'\s*org\s+\$([0-9A-Fa-f]+)', line)
            if org_match:
                current_addr = int(org_match.group(1), 16)
                output_lines.append(line)
                continue

            # Parse DC.W lines
            dcw_match = re.match(r'(\s+DC\.W\s+)(\$[0-9A-Fa-f,\$]+)\s*(;\s*\$([0-9A-Fa-f]+))?(.*)$', line)
            if dcw_match and current_addr is not None:
                prefix = dcw_match.group(1)
                data_str = dcw_match.group(2)
                addr_comment = dcw_match.group(4)
                extra = dcw_match.group(5) or ''

                # Parse the hex values
                words = []
                for val in data_str.split(','):
                    val = val.strip()
                    if val.startswith('$'):
                        words.append(int(val[1:], 16))

                # Get the line address
                if addr_comment:
                    line_addr = int(addr_comment, 16)
                else:
                    line_addr = current_addr

                # Check if this looks like data
                if self.is_likely_data(words, line_addr):
                    # Mark as data table
                    output_lines.append(f"{prefix}{data_str}  ; ${line_addr:06X} [DATA]\n")
                else:
                    # Disassemble each word
                    mnemonics = []
                    for i, word in enumerate(words):
                        word_addr = line_addr + (i * 2)
                        mnemonic = self.decode_word(word, word_addr)
                        mnemonics.append(mnemonic)

                    # Format: keep original format, add mnemonics
                    mnemonic_str = ' / '.join(mnemonics)

                    # Truncate if too long
                    if len(mnemonic_str) > 60:
                        mnemonic_str = mnemonic_str[:57] + '...'

                    output_lines.append(f"{prefix}{data_str}  ; ${line_addr:06X} | {mnemonic_str}\n")

                # Update address for next line
                current_addr = line_addr + len(words) * 2
            else:
                # Non-DC.W line, pass through
                output_lines.append(line)

        # Write output
        out_path = output_path or input_path
        with open(out_path, 'w') as f:
            f.writelines(output_lines)

        return out_path


def main():
    parser = argparse.ArgumentParser(description='Annotate SH2 module with disassembly')
    parser.add_argument('input_file', help='Input module file')
    parser.add_argument('--output', '-o', help='Output file (default: overwrite input)')
    parser.add_argument('--preview', '-p', action='store_true', help='Preview first 20 lines without writing')
    args = parser.parse_args()

    annotator = SH2ModuleAnnotator()

    if args.preview:
        # Preview mode
        with open(args.input_file, 'r') as f:
            lines = f.readlines()[:30]

        # Process and print preview
        print("Preview of annotation:")
        print("=" * 80)
        current_addr = None
        for line in lines:
            org_match = re.match(r'\s*org\s+\$([0-9A-Fa-f]+)', line)
            if org_match:
                current_addr = int(org_match.group(1), 16)
                print(line.rstrip())
                continue

            dcw_match = re.match(r'(\s+DC\.W\s+)(\$[0-9A-Fa-f,\$]+)\s*(;\s*\$([0-9A-Fa-f]+))?', line)
            if dcw_match and current_addr is not None:
                prefix = dcw_match.group(1)
                data_str = dcw_match.group(2)
                addr_comment = dcw_match.group(4)

                words = []
                for val in data_str.split(','):
                    val = val.strip()
                    if val.startswith('$'):
                        words.append(int(val[1:], 16))

                line_addr = int(addr_comment, 16) if addr_comment else current_addr

                mnemonics = []
                for i, word in enumerate(words):
                    word_addr = line_addr + (i * 2)
                    mnemonic = annotator.decode_word(word, word_addr)
                    mnemonics.append(mnemonic)

                mnemonic_str = ' / '.join(mnemonics)
                if len(mnemonic_str) > 60:
                    mnemonic_str = mnemonic_str[:57] + '...'

                print(f"{prefix}{data_str}  ; ${line_addr:06X} | {mnemonic_str}")
                current_addr = line_addr + len(words) * 2
            else:
                print(line.rstrip())
    else:
        output = annotator.annotate_file(args.input_file, args.output)
        print(f"Annotated: {output}")


if __name__ == '__main__':
    main()
