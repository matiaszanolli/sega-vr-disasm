#!/usr/bin/env python3
"""
Regenerate clean section files with pure dc.w disassembly.
No instruction conversion - just raw word data.
This ensures byte-perfect ROM rebuilds.
"""

import os
import sys

# Configuration
ROM_FILE = "Virtua Racing Deluxe (USA).32x"
SECTIONS_DIR = "disasm/sections"
VRD_ASM = "disasm/vrd.asm"

# Section boundaries (8KB chunks, matching existing structure)
# First section starts at $0 for header, then $200 for code
HEADER_END = 0x200
SECTION_SIZE = 0x2000  # 8KB sections

def read_rom(rom_path):
    """Read ROM file and return bytes."""
    with open(rom_path, 'rb') as f:
        return f.read()

def generate_header_section(rom_data):
    """Generate header.asm (first $200 bytes) - pure dc.w for byte-perfect match."""
    lines = [
        "; ============================================================================",
        "; ROM Header and Vector Table ($000000-$0001FF)",
        "; ============================================================================",
        "; Contains 68000 exception vectors and SEGA standard header.",
        "; Pure dc.w for byte-perfect ROM rebuild.",
        "; ============================================================================",
        "",
        "        org     $000000",
        "",
        "header:",
    ]

    # Output everything as dc.w for guaranteed byte-perfect output
    for i in range(0, 0x200, 2):
        word = (rom_data[i] << 8) | rom_data[i+1]

        # Add comments for important offsets
        comments = {
            0x00: "Initial SSP (high)",
            0x02: "Initial SSP (low)",
            0x04: "Initial PC (high)",
            0x06: "Initial PC (low) - Reset vector",
            0x78: "IRQ6/VBlank vector (high)",
            0x7A: "IRQ6/VBlank vector (low)",
        }

        comment = comments.get(i, "")
        if comment:
            lines.append(f"        dc.w    ${word:04X}        ; ${i:04X}: {comment}")
        else:
            lines.append(f"        dc.w    ${word:04X}        ; ${i:04X}")

    return "\n".join(lines) + "\n"

def generate_code_section(rom_data, start_offset, end_offset):
    """Generate a code section with pure dc.w data."""
    section_name = f"code_{start_offset:x}"

    lines = [
        "; ============================================================================",
        f"; Code Section (${start_offset:06X}-${end_offset-1:06X})",
        "; ============================================================================",
        "",
        f"        org     ${start_offset:06X}",
        "",
        f"{section_name}:",
    ]

    # Output as dc.w statements
    for i in range(start_offset, min(end_offset, len(rom_data)), 2):
        if i + 1 < len(rom_data):
            word = (rom_data[i] << 8) | rom_data[i+1]
            lines.append(f"        dc.w    ${word:04X}        ; ${i:06X}")
        else:
            # Handle odd byte at end
            lines.append(f"        dc.b    ${rom_data[i]:02X}        ; ${i:06X}")

    return "\n".join(lines) + "\n"

def generate_vrd_asm(section_files):
    """Generate main vrd.asm file that includes all sections."""
    lines = [
        "; ============================================================================",
        "; Virtua Racing Deluxe (USA) - Sega 32X",
        "; Complete Disassembly - Master Assembly File",
        "; ============================================================================",
        ";",
        "; Product: V.R.DX",
        "; Serial: GM MK-84601-00",
        "; Copyright: (C)SEGA 1994.SEP",
        "; ROM Size: 3MB (3,145,728 bytes)",
        ";",
        "; Build: make all",
        "; Verify: make compare (should show PERFECT MATCH)",
        ";",
        "; ============================================================================",
        "",
        "        cpu     68000",
        "",
    ]

    # Include all section files in order
    for section_file in sorted(section_files, key=lambda x: int(x.replace("code_", "").replace(".asm", ""), 16) if "code_" in x else -1):
        lines.append(f'        include "sections/{section_file}"')

    return "\n".join(lines) + "\n"

def main():
    # Check for ROM
    if not os.path.exists(ROM_FILE):
        print(f"ERROR: ROM not found: {ROM_FILE}")
        sys.exit(1)

    print(f"Reading ROM: {ROM_FILE}")
    rom_data = read_rom(ROM_FILE)
    rom_size = len(rom_data)
    print(f"ROM size: {rom_size:,} bytes ({rom_size/1024/1024:.2f} MB)")

    # Create sections directory
    os.makedirs(SECTIONS_DIR, exist_ok=True)

    # Clear existing section files
    print(f"Clearing existing section files in {SECTIONS_DIR}/")
    for f in os.listdir(SECTIONS_DIR):
        if f.endswith('.asm'):
            os.remove(os.path.join(SECTIONS_DIR, f))

    section_files = []

    # Generate header section ($0000-$01FF)
    print("Generating header.asm ($0000-$01FF)")
    header_content = generate_header_section(rom_data)
    header_path = os.path.join(SECTIONS_DIR, "header.asm")
    with open(header_path, 'w') as f:
        f.write(header_content)
    section_files.append("header.asm")

    # Generate code sections starting at $200
    # Use 8KB ($2000) sections for manageability
    current_offset = HEADER_END

    while current_offset < rom_size:
        section_end = min(current_offset + SECTION_SIZE, rom_size)
        section_name = f"code_{current_offset:x}.asm"

        print(f"Generating {section_name} (${current_offset:06X}-${section_end-1:06X})")

        section_content = generate_code_section(rom_data, current_offset, section_end)
        section_path = os.path.join(SECTIONS_DIR, section_name)
        with open(section_path, 'w') as f:
            f.write(section_content)

        section_files.append(section_name)
        current_offset = section_end

    # Generate vrd.asm
    print(f"\nGenerating {VRD_ASM}")
    vrd_content = generate_vrd_asm(section_files)
    with open(VRD_ASM, 'w') as f:
        f.write(vrd_content)

    print(f"\n{'='*60}")
    print(f"Generated {len(section_files)} section files")
    print(f"Total ROM coverage: ${0:06X}-${rom_size-1:06X}")
    print(f"\nNext steps:")
    print(f"  1. Run: python3 tools/inject_labels.py")
    print(f"  2. Update Makefile: M68K_SRC = disasm/vrd.asm")
    print(f"  3. Build: make all")
    print(f"  4. Verify: make compare")
    print(f"{'='*60}")

if __name__ == "__main__":
    main()
