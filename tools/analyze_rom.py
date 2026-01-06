#!/usr/bin/env python3
"""
Virtua Racing Deluxe (32X) ROM Analyzer
Extracts header information and maps ROM structure
"""

import struct
import sys

def read_long(data, offset):
    """Read big-endian 32-bit value"""
    return struct.unpack('>I', data[offset:offset+4])[0]

def read_word(data, offset):
    """Read big-endian 16-bit value"""
    return struct.unpack('>H', data[offset:offset+2])[0]

def analyze_header(rom_data):
    """Analyze 32X ROM header"""

    print("=" * 70)
    print("VIRTUA RACING DELUXE - ROM ANALYSIS")
    print("=" * 70)

    # Initial vectors (0x00-0x07)
    initial_sp = read_long(rom_data, 0x00)
    initial_pc = read_long(rom_data, 0x04)

    print(f"\n[INITIAL VECTORS]")
    print(f"Initial Stack Pointer: 0x{initial_sp:08X}")
    print(f"Initial Program Counter: 0x{initial_pc:08X}")

    # 32X Header (0x100-0x1FF)
    header_offset = 0x100

    console_name = rom_data[header_offset:header_offset+16].decode('ascii', errors='ignore')
    copyright = rom_data[header_offset+16:header_offset+32].decode('ascii', errors='ignore')
    domestic_name = rom_data[header_offset+32:header_offset+80].decode('ascii', errors='ignore')
    overseas_name = rom_data[header_offset+80:header_offset+128].decode('ascii', errors='ignore')
    serial = rom_data[header_offset+128:header_offset+142].decode('ascii', errors='ignore')

    print(f"\n[32X HEADER @ 0x100]")
    print(f"Console: {console_name.strip()}")
    print(f"Copyright: {copyright.strip()}")
    print(f"Domestic Name: {domestic_name.strip()}")
    print(f"Overseas Name: {overseas_name.strip()}")
    print(f"Serial Number: {serial.strip()}")

    # ROM/RAM info (0x1A0-0x1AF)
    rom_start = read_long(rom_data, 0x1A0)
    rom_end = read_long(rom_data, 0x1A4)
    ram_start = read_long(rom_data, 0x1A8)
    ram_end = read_long(rom_data, 0x1AC)

    rom_size = rom_end - rom_start + 1

    print(f"\n[MEMORY MAP]")
    print(f"ROM: 0x{rom_start:08X} - 0x{rom_end:08X} ({rom_size:,} bytes, {rom_size//1024}KB)")
    print(f"RAM: 0x{ram_start:08X} - 0x{ram_end:08X}")

    # Region (0x1F0)
    region = rom_data[0x1F0:0x1F0+16].decode('ascii', errors='ignore').strip()
    print(f"Region: {region}")

    return {
        'initial_sp': initial_sp,
        'initial_pc': initial_pc,
        'rom_start': rom_start,
        'rom_end': rom_end,
        'rom_size': rom_size
    }

def analyze_vectors(rom_data):
    """Analyze 68000 vector table starting at 0x200"""

    print(f"\n[68000 VECTOR TABLE @ 0x200]")
    print("-" * 70)

    vector_names = [
        "Reset SP", "Reset PC", "Bus Error", "Address Error",
        "Illegal Instruction", "Divide by Zero", "CHK Exception", "TRAPV Exception",
        "Privilege Violation", "Trace", "Line 1010 Emulator", "Line 1111 Emulator",
        "Reserved 12", "Reserved 13", "Format Error", "Uninitialized Interrupt",
        "Reserved 16", "Reserved 17", "Reserved 18", "Reserved 19",
        "Reserved 20", "Reserved 21", "Reserved 22", "Reserved 23",
        "Spurious Interrupt", "Level 1 IRQ", "Level 2 IRQ (H-INT)", "Level 3 IRQ",
        "Level 4 IRQ (V-INT)", "Level 5 IRQ", "Level 6 IRQ (32X)", "Level 7 IRQ (NMI)",
    ]

    # 32X uses jump table starting at 0x200 instead of direct vectors
    # Each entry is: 4E F9 XX XX XX XX (JMP xxxx.l)

    vectors = []
    for i in range(32):
        offset = 0x200 + (i * 6)

        # Check if it's a JMP instruction (4E F9)
        opcode = read_word(rom_data, offset)
        if opcode == 0x4EF9:  # JMP instruction
            target = read_long(rom_data, offset + 2)
            # Convert from ROM address space (0x00880000+) to file offset
            if target >= 0x00880000:
                file_offset = target - 0x00880000
                vectors.append((i, vector_names[i], target, file_offset))
                if i < 8:  # Only print first few
                    print(f"Vector {i:2d} ({vector_names[i]:22s}): JMP 0x{target:08X} (file offset: 0x{file_offset:06X})")
        else:
            print(f"Vector {i:2d} ({vector_names[i]:22s}): 0x{opcode:04X} (not JMP)")

    print(f"... ({len(vectors)} total vectors)")

    return vectors

def find_sega_header(rom_data):
    """Look for 'MARS' or '32X' strings that indicate 32X-specific code"""

    print(f"\n[SEARCHING FOR 32X MARKERS]")
    print("-" * 70)

    # Look for "MARS" string (32X identifier)
    mars_pos = rom_data.find(b'MARS')
    if mars_pos != -1:
        print(f"Found 'MARS' at offset: 0x{mars_pos:06X}")
        # Show context
        context = rom_data[mars_pos:mars_pos+32]
        print(f"Context: {context.hex(' ')}")

    # Look for "SEGA 32X"
    sega32x_pos = rom_data.find(b'SEGA 32X')
    if sega32x_pos != -1:
        print(f"Found 'SEGA 32X' at offset: 0x{sega32x_pos:06X}")

def main():
    rom_file = "/mnt/data/src/32x-playground/Virtua Racing Deluxe (USA).32x"

    try:
        with open(rom_file, 'rb') as f:
            rom_data = f.read()
    except FileNotFoundError:
        print(f"Error: ROM file not found: {rom_file}")
        sys.exit(1)

    print(f"\nROM Size: {len(rom_data):,} bytes ({len(rom_data)//1024}KB, {len(rom_data)//1024//1024}MB)")

    # Analyze header
    info = analyze_header(rom_data)

    # Analyze vectors
    vectors = analyze_vectors(rom_data)

    # Find 32X markers
    find_sega_header(rom_data)

    print("\n" + "=" * 70)
    print("Analysis complete!")
    print("=" * 70)

if __name__ == "__main__":
    main()
