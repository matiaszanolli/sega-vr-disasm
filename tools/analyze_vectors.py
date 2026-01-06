#!/usr/bin/env python3
"""
Analyze SH2 interrupt vector table in Virtua Racing Deluxe
"""

import struct
import sys

# SH2 Vector table offsets and names (based on SH7604 manual)
VECTOR_TABLE = [
    (0x00, "Power-on PC (SP)"),
    (0x04, "Power-on PC"),
    (0x08, "Manual reset PC (SP)"),
    (0x0C, "Manual reset PC"),
    (0x10, "Illegal instruction"),
    (0x14, "Reserved"),
    (0x18, "Slot illegal instruction"),
    (0x1C, "Reserved"),
    (0x20, "Reserved"),
    (0x24, "CPU address error"),
    (0x28, "DMA address error"),
    (0x2C, "NMI"),
    (0x30, "User break"),
    (0x34, "Reserved"),
    (0x38, "Reserved"),
    (0x3C, "Reserved"),
    (0x40, "Reserved"),
    (0x44, "Reserved"),
    (0x48, "Reserved"),
    (0x4C, "Reserved"),
    (0x50, "Reserved"),
    (0x54, "Reserved"),
    (0x58, "Reserved"),
    (0x5C, "Reserved"),
    (0x60, "Reserved"),
    (0x64, "TRAPA #0"),
    (0x68, "TRAPA #1"),
    (0x6C, "TRAPA #2"),
    (0x70, "TRAPA #3"),
    (0x74, "TRAPA #4"),
    (0x78, "TRAPA #5"),
    (0x7C, "TRAPA #6"),
    (0x80, "TRAPA #7"),
    (0x84, "TRAPA #8"),
    (0x88, "TRAPA #9"),
    (0x8C, "TRAPA #10"),
    (0x90, "TRAPA #11"),
    (0x94, "TRAPA #12"),
    (0x98, "TRAPA #13"),
    (0x9C, "TRAPA #14"),
    (0xA0, "TRAPA #15"),
    (0xA4, "TRAPA #16"),
    (0xA8, "TRAPA #17"),
    (0xAC, "TRAPA #18"),
    (0xB0, "TRAPA #19"),
    (0xB4, "TRAPA #20"),
    (0xB8, "TRAPA #21"),
    (0xBC, "TRAPA #22"),
    (0xC0, "TRAPA #23"),
    (0xC4, "TRAPA #24"),
    (0xC8, "TRAPA #25"),
    (0xCC, "TRAPA #26"),
    (0xD0, "TRAPA #27"),
    (0xD4, "TRAPA #28"),
    (0xD8, "TRAPA #29"),
    (0xDC, "TRAPA #30"),
    (0xE0, "TRAPA #31"),
    (0xE4, "IRQ0"),
    (0xE8, "IRQ1"),
    (0xEC, "IRQ2"),
    (0xF0, "IRQ3"),
    (0xF4, "IRQ4"),
    (0xF8, "IRQ5"),
    (0xFC, "IRQ6"),
]

# Additional vectors continue...
# 32X specific vectors are at higher offsets
SEGA_32X_VECTORS = [
    (0x100, "VBlank (V interrupt)"),       # 32X VDP VBlank
    (0x104, "HBlank (H interrupt)"),       # 32X VDP HBlank
    (0x108, "CMD interrupt"),              # 68000 -> SH2 command interrupt
    (0x10C, "PWM interrupt"),              # PWM sound interrupt
]

def read_long(rom, offset):
    """Read 32-bit big-endian value"""
    return struct.unpack('>I', rom[offset:offset+4])[0]

def analyze_vectors(rom_path):
    with open(rom_path, 'rb') as f:
        rom = f.read()

    print("=" * 80)
    print("SH2 INTERRUPT VECTOR TABLE ANALYSIS - Virtua Racing Deluxe")
    print("=" * 80)
    print()

    # Initial stack and PC
    initial_sp = read_long(rom, 0x00)
    initial_pc = read_long(rom, 0x04)
    print(f"Initial SP: 0x{initial_sp:08X}")
    print(f"Initial PC: 0x{initial_pc:08X}")
    print()

    # Collect unique handler addresses
    handlers = {}

    print("STANDARD SH2 VECTORS (0x08-0xFF):")
    print("-" * 80)

    for offset, name in VECTOR_TABLE:
        if offset < 0x08:  # Skip initial SP/PC
            continue
        addr = read_long(rom, offset)

        if addr != 0:
            if addr not in handlers:
                handlers[addr] = []
            handlers[addr].append(name)

        print(f"  [{offset:03X}] {name:30s} -> 0x{addr:08X}")

    print()
    print("32X-SPECIFIC VECTORS (0x100+):")
    print("-" * 80)

    # Check for 32X specific interrupt vectors
    # These would typically be at higher offsets or in a custom table
    # Let's scan the area around 0x100-0x200 for patterns

    for offset, name in SEGA_32X_VECTORS:
        if offset < len(rom):
            addr = read_long(rom, offset)
            if addr != 0:
                if addr not in handlers:
                    handlers[addr] = []
                handlers[addr].append(name)
                print(f"  [{offset:03X}] {name:30s} -> 0x{addr:08X}")

    print()
    print("=" * 80)
    print("UNIQUE INTERRUPT HANDLERS:")
    print("=" * 80)

    for addr in sorted(handlers.keys()):
        vectors = handlers[addr]
        print(f"\nHandler at 0x{addr:08X}:")
        for v in vectors:
            print(f"  - {v}")

    return handlers

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: analyze_vectors.py <rom_file>")
        sys.exit(1)

    handlers = analyze_vectors(sys.argv[1])
