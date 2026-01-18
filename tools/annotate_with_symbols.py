#!/usr/bin/env python3
"""
Annotate assembly files with symbol names in comments.
Preserves original instructions but adds symbol names for readability.
"""

import re
import sys
from pathlib import Path

SECTIONS_DIR = Path(__file__).parent.parent / "disasm" / "sections"


def load_symbols(inc_file):
    """Load symbols from .inc file."""
    symbols = {}

    with open(inc_file, 'r') as f:
        for line in f:
            match = re.match(r'^(\w+)\s+EQU\s+\$([0-9A-Fa-f]+)', line)
            if match:
                name = match.group(1)
                addr = int(match.group(2), 16)
                symbols[addr] = name

    return symbols


def annotate_file(asm_file, symbols, dry_run=False):
    """Add symbol annotations to a file."""
    with open(asm_file, 'r') as f:
        lines = f.readlines()

    modified = False
    new_lines = []

    for line in lines:
        # Match: JSR/JMP $XXXXXX(PC)  ; $YYYYYY
        # or: JSR/JMP $XXXXXX(PC)  ; $YYYYYY existing_comment
        match = re.match(
            r'^(\s*)(JSR|JMP)\s+\$([0-9A-Fa-f]+)\(PC\)(\s+;\s+\$[0-9A-Fa-f]+)(.*?)$',
            line.rstrip()
        )

        if match:
            indent = match.group(1)
            instr = match.group(2)
            addr_str = match.group(3)
            comment = match.group(4)
            extra = match.group(5).strip()

            try:
                addr = int(addr_str, 16)
                # Already has symbol annotation?
                if extra and not extra.startswith('['):
                    new_lines.append(line)
                    continue

                if addr in symbols:
                    sym_name = symbols[addr]
                    # Add symbol name in brackets
                    new_line = f"{indent}{instr}     ${addr_str}(PC){comment} [{sym_name}]\n"
                    new_lines.append(new_line)
                    modified = True
                    continue
            except ValueError:
                pass

        new_lines.append(line)

    if modified and not dry_run:
        with open(asm_file, 'w') as f:
            f.writelines(new_lines)

    return modified


def main():
    dry_run = '--dry-run' in sys.argv

    inc_file = SECTIONS_DIR / "symbols.inc"
    if not inc_file.exists():
        print("Error: symbols.inc not found. Run build_symbol_table.py first.")
        sys.exit(1)

    symbols = load_symbols(inc_file)
    print(f"Loaded {len(symbols)} symbols")

    files_annotated = 0

    for asm_file in sorted(SECTIONS_DIR.glob("code_*.asm")):
        if annotate_file(asm_file, symbols, dry_run):
            files_annotated += 1
            if dry_run:
                print(f"Would annotate: {asm_file.name}")

    print(f"\n{'Would annotate' if dry_run else 'Annotated'} {files_annotated} files")


if __name__ == "__main__":
    main()
