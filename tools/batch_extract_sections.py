#!/usr/bin/env python3
"""
Batch extract all remaining raw sections into modules.
Creates game/data modules for sections that haven't been manually categorized.

Usage:
    python3 batch_extract_sections.py
"""

import os
import subprocess
import sys

# Sections already processed (will be skipped)
PROCESSED_SECTIONS = {
    '00200', '02200', '04200', '06200', '08200', '0a200', '0c200',
    '0e200', '10200', '12200', '14200', '16200'
}

def main():
    sections_dir = 'disasm/sections_raw'
    output_dir = 'disasm/modules/68k'

    # Find all section files
    section_files = []
    for f in sorted(os.listdir(sections_dir)):
        if f.startswith('code_') and f.endswith('.asm'):
            section_id = f.replace('code_', '').replace('.asm', '')
            if section_id not in PROCESSED_SECTIONS:
                section_files.append((section_id, os.path.join(sections_dir, f)))

    print(f"Found {len(section_files)} sections to process")

    # Process in batches
    batch_size = 50
    for i in range(0, len(section_files), batch_size):
        batch = section_files[i:i+batch_size]
        print(f"\nProcessing batch {i//batch_size + 1} ({len(batch)} sections)...")

        for section_id, filepath in batch:
            # Determine category based on address range
            addr = int(section_id, 16)

            if addr < 0x18200:
                category = 'game'
            elif addr < 0x23000:
                category = 'data'
            elif addr < 0x27000:
                category = 'sh2'  # SH2 code region
            else:
                category = 'data'

            output_module = f"{category}/section_{section_id}"

            # Run the split tool
            cmd = [
                'python3', 'tools/split_section.py',
                filepath,
                output_dir,
                f"0x{section_id}:{output_module}"
            ]

            result = subprocess.run(cmd, capture_output=True, text=True)
            if result.returncode != 0:
                print(f"  ERROR processing {section_id}: {result.stderr}")
            else:
                # Just print a dot to show progress
                print('.', end='', flush=True)

        print()  # Newline after batch

    print("\nDone! Now update vrd_modular.asm")

if __name__ == '__main__':
    main()
