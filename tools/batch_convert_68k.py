#!/usr/bin/env python3
"""
Batch convert all 68K code modules to readable assembly with proper mnemonics.

Preserves DC.W format for byte-exact assembly but adds decoded mnemonic comments.

Usage:
    python3 batch_convert_68k.py <rom_file> [--dry-run]
"""

import argparse
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))
from disasm_to_asm import ModuleConverter


# 68K code modules (not data sections)
CODE_MODULE_DIRS = [
    'boot',
    'display',
    'game',
    'hardware-regs',
    'input',
    'main-loop',
    'sound',
]


def main():
    parser = argparse.ArgumentParser(
        description='Batch convert 68K modules to readable assembly'
    )
    parser.add_argument('rom_file', type=Path, help='ROM file for disassembly')
    parser.add_argument('--dry-run', action='store_true', help='Show what would be done')
    parser.add_argument('--module', type=str, help='Only process specific module')
    args = parser.parse_args()

    if not args.rom_file.exists():
        print(f"Error: ROM file {args.rom_file} not found")
        sys.exit(1)

    # Load ROM
    print(f"Loading ROM: {args.rom_file}")
    with open(args.rom_file, 'rb') as f:
        rom_data = f.read()
    print(f"ROM size: {len(rom_data):,} bytes")

    converter = ModuleConverter(rom_data)

    # Find module base directory
    modules_dir = Path('disasm/modules/68k')
    if not modules_dir.exists():
        print(f"Error: Modules directory not found: {modules_dir}")
        sys.exit(1)

    total_modules = 0
    total_converted = 0

    for dir_name in CODE_MODULE_DIRS:
        dir_path = modules_dir / dir_name
        if not dir_path.exists():
            continue

        print(f"\n{'='*60}")
        print(f"Processing {dir_name}/")
        print(f"{'='*60}")

        for asm_file in sorted(dir_path.glob('*.asm')):
            if args.module and args.module not in str(asm_file):
                continue

            print(f"\n  {asm_file.name}")
            total_modules += 1

            if args.dry_run:
                print(f"    [DRY RUN] Would convert {asm_file}")
                continue

            try:
                # Convert with DC.W format (byte-exact with mnemonic comments)
                if converter.convert_module(asm_file, use_dcw=True):
                    print(f"    Converted successfully")
                    total_converted += 1
                else:
                    print(f"    Skipped (no org directive)")
            except Exception as e:
                print(f"    ERROR: {e}")

    print(f"\n{'='*60}")
    print(f"Summary")
    print(f"{'='*60}")
    print(f"Modules found: {total_modules}")
    print(f"Modules converted: {total_converted}")

    if not args.dry_run and total_converted > 0:
        print(f"\nRun 'make compare-modular' to verify the build is still correct.")


if __name__ == '__main__':
    main()
