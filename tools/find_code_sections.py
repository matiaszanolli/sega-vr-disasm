#!/usr/bin/env python3
"""
ROM Section Scanner for Virtua Racing Deluxe
Identifies different code and data sections
"""

import struct
import sys

def read_long(data, offset):
    """Read big-endian 32-bit value"""
    return struct.unpack('>I', data[offset:offset+4])[0]

def read_word(data, offset):
    """Read big-endian 16-bit value"""
    return struct.unpack('>H', data[offset:offset+2])[0]

def find_strings(rom_data):
    """Find interesting strings in ROM"""
    print("\n[SCANNING FOR STRINGS]")
    print("=" * 70)

    strings_found = []
    current_string = b""
    start_offset = 0

    for i, byte in enumerate(rom_data):
        if 32 <= byte <= 126:  # Printable ASCII
            if not current_string:
                start_offset = i
            current_string += bytes([byte])
        else:
            if len(current_string) >= 8:
                strings_found.append((start_offset, current_string.decode('ascii')))
            current_string = b""

    # Print interesting strings
    keywords = ['MARS', 'SEGA', 'SH', 'MASTER', 'SLAVE', 'VR', 'COPYRIGHT',
                'ROM', 'INIT', 'SOUND', 'MUSIC', 'GAME', 'VERSION']

    for offset, string in strings_found[:200]:  # First 200 strings
        if any(kw.lower() in string.lower() for kw in keywords):
            print(f"0x{offset:06X}: {string[:60]}")

def scan_for_sh2_code(rom_data):
    """Look for SH2 code patterns"""
    print("\n[SCANNING FOR SH2 CODE PATTERNS]")
    print("=" * 70)

    # SH2 code often starts with MOV or similar instructions
    # Look for sequences that don't look like 68000 code

    # SH2 typical patterns:
    # - MOV.L patterns (often Exxx or Dxxx)
    # - RTS: 0x000B
    # - NOP: 0x0009

    potential_sh2_sections = []

    # Look for high concentration of SH2-like opcodes
    for i in range(0, len(rom_data) - 100, 2):
        word = read_word(rom_data, i)

        # SH2 RTS instruction
        if word == 0x000B:
            # Check surrounding bytes for SH2 patterns
            sh2_score = 0
            for j in range(max(0, i-20), min(len(rom_data)-2, i+20), 2):
                w = read_word(rom_data, j)
                # Common SH2 opcodes
                if (w & 0xF000) == 0xE000:  # MOV #imm
                    sh2_score += 1
                if (w & 0xF000) == 0xD000:  # MOV.L @(disp,PC)
                    sh2_score += 1
                if w == 0x0009 or w == 0x000B:  # NOP or RTS
                    sh2_score += 1

            if sh2_score > 5:
                potential_sh2_sections.append((i, sh2_score))

    # Print top candidates
    potential_sh2_sections.sort(key=lambda x: x[1], reverse=True)
    print("Top SH2 code section candidates:")
    for offset, score in potential_sh2_sections[:10]:
        print(f"  Offset 0x{offset:06X} (score: {score})")
        # Show first few bytes
        snippet = rom_data[offset:offset+16].hex(' ')
        print(f"    Data: {snippet}")

def find_data_sections(rom_data):
    """Look for large data blocks"""
    print("\n[SCANNING FOR DATA SECTIONS]")
    print("=" * 70)

    # Look for repetitive patterns (graphics data often has repetition)
    # Look for high entropy sections (compressed data)
    # Look for low entropy sections (padding, simple graphics)

    section_size = 0x1000  # 4KB chunks

    for i in range(0, len(rom_data), section_size):
        chunk = rom_data[i:i+section_size]

        # Calculate some basic statistics
        zero_count = chunk.count(0)
        ff_count = chunk.count(0xFF)

        # High zero or FF count suggests padding or simple data
        if zero_count > section_size * 0.9:
            print(f"0x{i:06X}: Mostly zeros (padding?)")
        elif ff_count > section_size * 0.9:
            print(f"0x{i:06X}: Mostly 0xFF (empty/padding?)")

def analyze_vector_jumps(rom_data):
    """Analyze where vector table jumps lead"""
    print("\n[ANALYZING VECTOR TABLE JUMPS]")
    print("=" * 70)

    jump_targets = set()

    # Vector table starts at 0x200, each entry is 6 bytes (JMP instruction)
    for i in range(0x200, 0x200 + (32 * 6), 6):
        opcode = read_word(rom_data, i)
        if opcode == 0x4EF9:  # JMP xxxx.l
            target = read_long(rom_data, i + 2)
            file_offset = target - 0x00880000
            jump_targets.add(file_offset)
            if i < 0x230:  # First few vectors
                print(f"Vector @ 0x{i:04X}: JMP to 0x{target:08X} (file: 0x{file_offset:06X})")

    print(f"\nFound {len(jump_targets)} unique jump targets in vector table")
    return sorted(jump_targets)

def main():
    rom_file = "/mnt/data/src/32x-playground/Virtua Racing Deluxe (USA).32x"

    with open(rom_file, 'rb') as f:
        rom_data = f.read()

    print(f"ROM Size: {len(rom_data):,} bytes")

    # Find strings
    find_strings(rom_data)

    # Find SH2 code
    scan_for_sh2_code(rom_data)

    # Analyze vectors
    jump_targets = analyze_vector_jumps(rom_data)

    # Look for data sections
    # find_data_sections(rom_data)

    print("\n" + "=" * 70)
    print("Scan complete!")

if __name__ == "__main__":
    main()
