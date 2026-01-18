#!/usr/bin/env python3
"""
Apply global symbols to assembly files.
Replaces absolute addresses in JSR/JMP/branches with symbol names.
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
            # Parse: SYMBOL_NAME    EQU $XXXXXX
            match = re.match(r'^(\w+)\s+EQU\s+\$([0-9A-Fa-f]+)', line)
            if match:
                name = match.group(1)
                addr = int(match.group(2), 16)
                symbols[addr] = name

    return symbols


def apply_symbols_to_file(asm_file, symbols, dry_run=False):
    """Apply symbols to a single assembly file."""
    with open(asm_file, 'r') as f:
        content = f.read()

    original = content
    replacements = 0

    # Replace JSR $XXXXXXXX with JSR symbol_name
    def replace_jsr_jmp(match):
        nonlocal replacements
        instr = match.group(1)  # JSR or JMP
        addr_str = match.group(2)

        try:
            addr = int(addr_str, 16)
            # Handle 68K address space ($00880000+)
            if addr >= 0x00880000:
                file_addr = addr - 0x00880000
            else:
                file_addr = addr

            if file_addr in symbols:
                replacements += 1
                return f"{instr}     {symbols[file_addr]}"
        except ValueError:
            pass

        return match.group(0)

    # Pattern: JSR/JMP followed by absolute address
    # Matches: JSR     $00880832, JMP $00E35A, etc.
    content = re.sub(
        r'(JSR|JMP)\s+\$([0-9A-Fa-f]{4,8})(?!\()',  # Exclude d(An) modes
        replace_jsr_jmp,
        content
    )

    if replacements > 0 and not dry_run:
        with open(asm_file, 'w') as f:
            f.write(content)

    return replacements


def main():
    dry_run = '--dry-run' in sys.argv

    inc_file = SECTIONS_DIR / "symbols.inc"
    if not inc_file.exists():
        print("Error: symbols.inc not found. Run build_symbol_table.py first.")
        sys.exit(1)

    symbols = load_symbols(inc_file)
    print(f"Loaded {len(symbols)} symbols")

    total_replacements = 0
    files_modified = 0

    for asm_file in sorted(SECTIONS_DIR.glob("code_*.asm")):
        replacements = apply_symbols_to_file(asm_file, symbols, dry_run)
        if replacements > 0:
            total_replacements += replacements
            files_modified += 1
            if dry_run:
                print(f"Would modify {asm_file.name}: {replacements} replacements")

    print(f"\n{'Would replace' if dry_run else 'Replaced'} {total_replacements} addresses in {files_modified} files")

    if dry_run:
        print("\nRun without --dry-run to apply changes")


if __name__ == "__main__":
    main()
