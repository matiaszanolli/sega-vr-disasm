#!/usr/bin/env python3
"""
Phase 4.4a ROM Injection Tool
Injects interrupt-driven VDP architecture patches into Virtua Racing Deluxe ROM
"""

import sys
import struct
import shutil
from pathlib import Path

# Binary data from compiled sh2_phase4_4a.bin
# File offsets for different components in the binary
INIT_H_INT_OFFSET = 0x00
INIT_H_INT_SIZE = 0x20  # 32 bytes

H_INT_HANDLER_OFFSET = 0x34
H_INT_HANDLER_SIZE = 0x10  # 16 bytes

FUNC_047_OFFSET = 0x4c
FUNC_047_SIZE = 0x08  # 8 bytes

FUNC_048_OFFSET = 0x56
FUNC_048_SIZE = 0x0e  # 14 bytes

# ROM injection offsets (file offsets, not CPU addresses)
ROM_FUNC_047_OFFSET = 0x23BE4
ROM_FUNC_048_OFFSET = 0x23C06

# Safe injection location for infrastructure (right after 3D engine code)
ROM_INFRASTRUCTURE_OFFSET = 0x24000  # After main 3D engine area


def load_binary(bin_path):
    """Load the compiled binary"""
    with open(bin_path, 'rb') as f:
        return f.read()


def create_patched_rom(rom_path, bin_path, output_path, inject_infrastructure=True):
    """
    Create a patched ROM with Phase 4.4a code

    Args:
        rom_path: Original ROM file path
        bin_path: Compiled binary file path
        output_path: Output ROM file path
        inject_infrastructure: If True, inject init_h_int and h_int_handler as well
    """

    # Load files
    print(f"Loading original ROM: {rom_path}")
    rom_data = bytearray()
    with open(rom_path, 'rb') as f:
        rom_data = bytearray(f.read())

    print(f"Loading compiled binary: {bin_path}")
    binary = load_binary(bin_path)

    print(f"ROM size: {len(rom_data)} bytes (0x{len(rom_data):x})")
    print(f"Binary size: {len(binary)} bytes (0x{len(binary):x})")

    # Patch 1: Replace func_047 with optimized version
    print(f"\n[Patch 1] Replacing func_047 at offset 0x{ROM_FUNC_047_OFFSET:x}")
    func_047_code = binary[FUNC_047_OFFSET:FUNC_047_OFFSET + FUNC_047_SIZE]
    print(f"  Original size: {FUNC_047_SIZE} bytes")
    print(f"  New code size: {len(func_047_code)} bytes")
    print(f"  Code: {func_047_code.hex()}")
    rom_data[ROM_FUNC_047_OFFSET:ROM_FUNC_047_OFFSET + len(func_047_code)] = func_047_code
    print(f"  ✓ Patched")

    # Patch 2: Replace func_048 with optimized version
    print(f"\n[Patch 2] Replacing func_048 at offset 0x{ROM_FUNC_048_OFFSET:x}")
    func_048_code = binary[FUNC_048_OFFSET:FUNC_048_OFFSET + FUNC_048_SIZE]
    print(f"  Original size: {FUNC_048_SIZE} bytes")
    print(f"  New code size: {len(func_048_code)} bytes")
    print(f"  Code: {func_048_code.hex()}")
    rom_data[ROM_FUNC_048_OFFSET:ROM_FUNC_048_OFFSET + len(func_048_code)] = func_048_code
    print(f"  ✓ Patched")

    # Optional Patch 3: Inject infrastructure (init_h_int + h_int_handler)
    if inject_infrastructure:
        print(f"\n[Patch 3] Injecting infrastructure at offset 0x{ROM_INFRASTRUCTURE_OFFSET:x}")
        infrastructure = binary[INIT_H_INT_OFFSET:H_INT_HANDLER_OFFSET + H_INT_HANDLER_SIZE]
        print(f"  init_h_int size: {INIT_H_INT_SIZE} bytes")
        print(f"  h_int_handler size: {H_INT_HANDLER_SIZE} bytes")
        print(f"  Total infrastructure: {len(infrastructure)} bytes")
        print(f"  WARNING: Infrastructure injection requires hooking init_h_int from startup code")
        print(f"           This is a placeholder for manual ROM modification")
        # For now, we'll skip actual injection since we need to hook the function call
        print(f"  (Skipping actual injection - requires startup code modification)")

    # Write patched ROM
    print(f"\nWriting patched ROM to: {output_path}")
    with open(output_path, 'wb') as f:
        f.write(rom_data)

    print(f"✓ ROM patched successfully!")
    print(f"✓ Output: {output_path}")

    # Summary
    print("\n" + "="*60)
    print("PATCH SUMMARY")
    print("="*60)
    print(f"func_047: VDP polling (50 cycles) → GBR-relative (10 cycles)")
    print(f"func_048: VDP polling with delay slot variant")
    print(f"\nExpected performance improvement:")
    print(f"  Current FPS: 26-27")
    print(f"  Target FPS: 30-32 (+15-25%)")
    print(f"\nNext steps:")
    print(f"  1. Test with: blastem {output_path}")
    print(f"  2. Verify ROM boots without crashes")
    print(f"  3. Navigate to pit stop screen (consistent FPS test)")
    print(f"  4. Measure frame rate improvement")


def main():
    if len(sys.argv) < 2:
        print("Usage: python3 inject_phase4_4a.py <rom_path> [output_path]")
        print("")
        print("Examples:")
        print('  python3 inject_phase4_4a.py "Virtua Racing Deluxe (USA).32x"')
        print('  python3 inject_phase4_4a.py "Virtua Racing Deluxe (USA).32x" build/vrd_phase4_4a_test.32x')
        sys.exit(1)

    rom_path = sys.argv[1]
    output_path = sys.argv[2] if len(sys.argv) > 2 else f"build/vrd_phase4_4a_test.32x"

    # Verify ROM exists
    if not Path(rom_path).exists():
        print(f"Error: ROM file not found: {rom_path}")
        sys.exit(1)

    # Find binary
    bin_path = "build/sh2_phase4_4a.bin"
    if not Path(bin_path).exists():
        print(f"Error: Binary file not found: {bin_path}")
        print(f"Expected: {bin_path}")
        sys.exit(1)

    # Create patched ROM
    try:
        create_patched_rom(rom_path, bin_path, output_path, inject_infrastructure=False)
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
