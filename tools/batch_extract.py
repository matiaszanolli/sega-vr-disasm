#!/usr/bin/env python3
"""
Batch extract ROM sections as assembly.
Extracts multiple 4KB sections at once.
"""

import subprocess
import sys
from pathlib import Path

# Sections to extract (start, end, label)
# Generate dynamically for a range
START = 0x2C0000
END = 0x300000
STEP = 0x2000  # 8KB sections

SECTIONS = [(addr, addr + STEP, f"Code_{addr:05X}") for addr in range(START, END, STEP)]


def main():
    script_dir = Path(__file__).parent
    project_dir = script_dir.parent
    sections_dir = project_dir / "disasm" / "sections"

    for start, end, label in SECTIONS:
        output_file = sections_dir / f"{label.lower()}.asm"
        print(f"Extracting {label} (${start:04X}-${end:04X})...")

        # Run extraction
        result = subprocess.run(
            ["python3", str(script_dir / "extract_section.py"),
             f"{start:X}", f"{end:X}", label],
            capture_output=True,
            text=True,
            cwd=project_dir
        )

        if result.returncode != 0:
            print(f"  ERROR: {result.stderr}")
            continue

        # Add org directive
        lines = result.stdout.split('\n')
        header_end = 0
        for i, line in enumerate(lines):
            if line.startswith(f"{label}:"):
                header_end = i
                break

        # Insert org before label
        new_lines = lines[:header_end] + [
            f"        org     ${start:06X}",
            ""
        ] + lines[header_end:]

        output_file.write_text('\n'.join(new_lines))
        print(f"  -> {output_file.name}")

    print("\nDone! Update vrd.asm to include the new sections.")
    print("Then run: dd if=ROM of=rom_remainder.bin bs=1 skip=$(<final_offset>)")


if __name__ == '__main__':
    main()
