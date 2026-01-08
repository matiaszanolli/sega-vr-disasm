#!/usr/bin/env python3
"""
Update vrd.asm to include new sections and update remainder.
Run after batch_extract.py.
"""

import re
from pathlib import Path

def main():
    project_dir = Path(__file__).parent.parent
    vrd_path = project_dir / "disasm" / "vrd.asm"
    sections_dir = project_dir / "disasm" / "sections"
    rom_path = project_dir / "Virtua Racing Deluxe (USA).32x"

    # Find all code section files
    code_files = sorted(sections_dir.glob("code_*.asm"))

    # Parse the section ranges from filenames
    sections = []
    for f in code_files:
        match = re.match(r'code_([0-9a-f]+)\.asm', f.name, re.I)
        if match:
            start = int(match.group(1), 16)
            sections.append((start, f.name))

    sections.sort()

    if not sections:
        print("No code sections found!")
        return

    # Find the highest section end address
    last_start = sections[-1][0]
    last_end = last_start + 0x2000  # Assuming 8KB sections

    print(f"Found {len(sections)} code sections")
    print(f"Range: $000000 - ${last_end:06X}")

    # Generate new vrd.asm
    lines = []
    lines.append("; ============================================================================")
    lines.append("; Virtua Racing Deluxe (USA) - Sega 32X")
    lines.append("; Complete Disassembly - Master Assembly File")
    lines.append("; ============================================================================")
    lines.append(";")
    lines.append("; Product: V.R.DX")
    lines.append("; Serial: GM MK-84601-00")
    lines.append("; Copyright: (C)SEGA 1994.SEP")
    lines.append("; ROM Size: 3MB (3,145,728 bytes)")
    lines.append(";")
    lines.append("; Build: make all")
    lines.append("; Verify: make compare (should show PERFECT MATCH)")
    lines.append(";")
    lines.append("; ============================================================================")
    lines.append("; Disassembly Progress:")
    lines.append(";   $000000-$0001FF: Header + Vectors   - DISASSEMBLED")
    lines.append(";   $000200-$0003EF: 32X Jump Table     - DISASSEMBLED")
    lines.append(";   $0003F0-$000831: Entry Point        - DISASSEMBLED")
    lines.append(";   $000832-$000FFF: Exception/Init     - DISASSEMBLED")

    # Add code section progress entries
    for start, fname in sections:
        end = start + 0x2000
        lines.append(f";   ${start:06X}-${end-1:06X}: Code Section       - DISASSEMBLED")

    lines.append(f";   ${last_end:06X}-$2FFFFF: Code + Data        - BINARY BLOB (TODO)")
    lines.append("; ============================================================================")
    lines.append("")

    # Section 1: Header
    lines.append("; ============================================================================")
    lines.append("; Section 1: ROM Header ($000000 - $0001FF)")
    lines.append("; ============================================================================")
    lines.append('        include "sections/header.asm"')
    lines.append("")

    # Section 2: Jump Table
    lines.append("; ============================================================================")
    lines.append("; Section 2: 32X Jump Table ($000200 - $0003EF)")
    lines.append("; ============================================================================")
    lines.append('        include "sections/jump_table.asm"')
    lines.append("")

    # Section 3: Entry Point
    lines.append("; ============================================================================")
    lines.append("; Section 3: Entry Point & Initialization ($0003F0 - $000831)")
    lines.append("; ============================================================================")
    lines.append('        include "sections/entry_point.asm"')
    lines.append("")

    # Section 4: Exception Handlers
    lines.append("; ============================================================================")
    lines.append("; Section 4: Exception Handlers & MARS Init ($000832 - $000FFF)")
    lines.append("; ============================================================================")
    lines.append('        include "sections/exception_handlers.asm"')
    lines.append("")

    # Code sections
    section_num = 5
    for start, fname in sections:
        end = start + 0x2000
        lines.append("; ============================================================================")
        lines.append(f"; Section {section_num}: Code (${start:06X} - ${end-1:06X})")
        lines.append("; ============================================================================")
        lines.append(f'        include "sections/{fname}"')
        lines.append("")
        section_num += 1

    # Remainder
    lines.append("; ============================================================================")
    lines.append(f"; Section {section_num}: Remainder (Binary Blob)")
    lines.append("; ============================================================================")
    lines.append("; TODO: Incrementally replace with disassembled sections")
    lines.append(f"        org     ${last_end:06X}")
    lines.append('        incbin  "sections/rom_remainder.bin"')
    lines.append("")
    lines.append("; ============================================================================")
    lines.append("; End of ROM")
    lines.append("; ============================================================================")
    lines.append("")

    # Write updated vrd.asm
    vrd_path.write_text('\n'.join(lines))
    print(f"Updated {vrd_path.name}")

    # Update rom_remainder.bin
    rom_data = rom_path.read_bytes()
    remainder = rom_data[last_end:]
    remainder_path = sections_dir / "rom_remainder.bin"
    remainder_path.write_bytes(remainder)
    print(f"Updated rom_remainder.bin (starts at ${last_end:06X}, {len(remainder)} bytes)")


if __name__ == '__main__':
    main()
