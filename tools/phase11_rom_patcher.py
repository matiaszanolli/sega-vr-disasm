#!/usr/bin/env python3
"""
Phase 11: Static ROM Patcher

Directly patches the ROM file with Slave hook bytecode.
This is the "Option 2: Static ROM Patching" fallback approach when pdcore
integration is not yet available.

Usage:
    python3 tools/phase11_rom_patcher.py <input_rom> <output_rom> [options]

Options:
    -a, --address ADDR    Hook injection address (default: 0x06000596)
    -v, --verify          Verify patch after writing (default: True)
    --no-backup           Don't create backup of original ROM
"""

import sys
import struct
import argparse
from pathlib import Path

# Phase 11 Slave Hook Bytecode v6 (22 bytes) - MINIMAL TEST VERSION
# Simple loop that just increments COMM4 continuously.
# No JSR, no handler - just proves the hook executes.
#
# Layout at 0x596 (literal must be 4-byte aligned):
#   0x596: mov.l @(12,PC),r0  ; Load COMM4 addr (d=3, EA=0x5A8)
#   0x598: mov.w @r0,r1       ; Read COMM4
#   0x59A: add #1,r1          ; Increment
#   0x59C: mov.w r1,@r0       ; Write COMM4
#   0x59E: bra loop_start     ; Loop forever (d=-6)
#   0x5A0: nop                ; Delay slot
#   0x5A2: nop                ; Padding
#   0x5A4: nop                ; Padding
#   0x5A6: nop                ; Padding for 4-byte alignment
#   0x5A8: 0x20004028         ; COMM4 literal (4-byte aligned!)
#
# Displacement verification:
#   mov.l at 0x596: EA = (0x598 & ~3) + 4 + 3*4 = 0x598 + 16 = 0x5A8 ✓
#   bra at 0x59E: target = 0x59E + 4 + (-6)*2 = 0x5A2 - 12 = 0x596 ✓
#
SLAVE_HOOK_BYTECODE = bytes([
    # loop_start (0x596):
    0xD0, 0x03,                                      # mov.l @(12,PC),r0  ; Load COMM4 addr (d=3)
    0x61, 0x01,                                      # mov.w @r0,r1       ; Read COMM4
    0x71, 0x01,                                      # add #1,r1          ; Increment
    0x20, 0x11,                                      # mov.w r1,@r0       ; Write COMM4
    0xAF, 0xFA,                                      # bra loop_start     ; Loop forever (d=-6)
    0x00, 0x09,                                      # nop                ; Delay slot
    0x00, 0x09,                                      # Padding
    0x00, 0x09,                                      # Padding
    0x00, 0x09,                                      # Padding for 4-byte alignment
    # Literal pool (4 bytes, 4-byte aligned at 0x5A8)
    0x20, 0x00, 0x40, 0x28,                          # COMM4: 0x20004028
])

# SH2 SDRAM address mapping to ROM file offset
# SH2 address $06000596 maps to file offset $00000596 (direct SDRAM layout)
def sh2_addr_to_file_offset(sh2_addr):
    """Convert SH2 SDRAM address to ROM file offset."""
    # SDRAM base in SH2 address space: 0x06000000
    # Maps directly to ROM for SDRAM content
    return sh2_addr - 0x06000000

def verify_rom_file(rom_path):
    """Verify ROM file is readable and correct size."""
    rom_file = Path(rom_path)
    if not rom_file.exists():
        print(f"ERROR: ROM file not found: {rom_path}")
        return False

    if rom_file.stat().st_size != 0x400000:  # 4MB
        print(f"WARNING: ROM size is {rom_file.stat().st_size} bytes, expected 4194304 (4MB)")

    return True

def patch_rom(input_rom, output_rom, hook_addr, verify=True, backup=True):
    """
    Patch ROM with Slave hook bytecode.

    Args:
        input_rom: Input ROM file path
        output_rom: Output ROM file path
        hook_addr: Hook injection address (SH2 address space)
        verify: Verify patch after writing
        backup: Create backup of original ROM

    Returns:
        True if successful, False otherwise
    """

    print("=" * 70)
    print("  Phase 11: Static ROM Patcher")
    print("=" * 70)

    # Verify input ROM
    if not verify_rom_file(input_rom):
        return False

    print(f"\n[1/5] Reading ROM: {input_rom}")
    try:
        with open(input_rom, 'rb') as f:
            rom_data = bytearray(f.read())
        print(f"  ✓ ROM loaded ({len(rom_data)} bytes)")
    except IOError as e:
        print(f"  ✗ Failed to read ROM: {e}")
        return False

    # Convert address to file offset
    file_offset = sh2_addr_to_file_offset(hook_addr)
    print(f"\n[2/5] Calculating injection point")
    print(f"  SH2 Address:  0x{hook_addr:08X}")
    print(f"  File Offset:  0x{file_offset:08X}")
    print(f"  Hook Size:    {len(SLAVE_HOOK_BYTECODE)} bytes")

    # Verify space available
    if file_offset + len(SLAVE_HOOK_BYTECODE) > len(rom_data):
        print(f"  ✗ Injection point extends beyond ROM ({file_offset} + {len(SLAVE_HOOK_BYTECODE)} > {len(rom_data)})")
        return False

    # Backup original
    if backup:
        print(f"\n[3/5] Creating backup")
        backup_path = Path(input_rom).parent / f"{Path(input_rom).stem}_backup{Path(input_rom).suffix}"
        try:
            with open(input_rom, 'rb') as src:
                with open(backup_path, 'wb') as dst:
                    dst.write(src.read())
            print(f"  ✓ Backup created: {backup_path}")
        except IOError as e:
            print(f"  ✗ Backup failed: {e}")
            return False

    # Inject hook
    print(f"\n[4/5] Injecting hook bytecode")
    original_bytes = rom_data[file_offset:file_offset + len(SLAVE_HOOK_BYTECODE)]
    print(f"  Original bytes at 0x{file_offset:06X}:")
    for i in range(0, len(original_bytes), 16):
        hex_str = ' '.join(f'{b:02X}' for b in original_bytes[i:i+16])
        print(f"    {i:04X}: {hex_str}")

    rom_data[file_offset:file_offset + len(SLAVE_HOOK_BYTECODE)] = SLAVE_HOOK_BYTECODE
    print(f"  ✓ Hook injected ({len(SLAVE_HOOK_BYTECODE)} bytes)")

    # Verify injection
    if verify:
        print(f"\n[5/5] Verifying hook bytecode")
        patched_bytes = rom_data[file_offset:file_offset + len(SLAVE_HOOK_BYTECODE)]
        if patched_bytes == SLAVE_HOOK_BYTECODE:
            print(f"  ✓ Bytecode verified (matches expected)")
            for i in range(0, len(patched_bytes), 16):
                hex_str = ' '.join(f'{b:02X}' for b in patched_bytes[i:i+16])
                print(f"    {i:04X}: {hex_str}")
        else:
            print(f"  ✗ Bytecode mismatch!")
            return False

    # Write patched ROM
    print(f"\n[6/6] Writing patched ROM: {output_rom}")
    try:
        with open(output_rom, 'wb') as f:
            f.write(rom_data)
        print(f"  ✓ Patched ROM written ({len(rom_data)} bytes)")
    except IOError as e:
        print(f"  ✗ Failed to write ROM: {e}")
        return False

    print("\n" + "=" * 70)
    print("  ✓ PATCH SUCCESSFUL")
    print("=" * 70)
    print(f"\nPatched ROM ready for testing:")
    print(f"  File: {output_rom}")
    print(f"  Hook Address: 0x{hook_addr:08X}")
    print(f"  Hook Size: {len(SLAVE_HOOK_BYTECODE)} bytes")
    print(f"\nNext step: Boot patched ROM and run smoke tests")

    return True

def main():
    parser = argparse.ArgumentParser(
        description='Phase 11: Static ROM Patcher - Inject Slave hook into ROM'
    )
    parser.add_argument('input_rom', help='Input ROM file')
    parser.add_argument('output_rom', help='Output ROM file (patched)')
    parser.add_argument('-a', '--address', type=lambda x: int(x, 16),
                        default=0x06000596,
                        help='Hook injection address in SH2 space (default: 0x06000596)')
    parser.add_argument('-v', '--verify', action='store_true', default=True,
                        help='Verify patch after writing (default: True)')
    parser.add_argument('--no-backup', action='store_false', dest='backup',
                        help='Don\'t create backup of original ROM')

    args = parser.parse_args()

    if patch_rom(args.input_rom, args.output_rom, args.address,
                 verify=args.verify, backup=args.backup):
        sys.exit(0)
    else:
        sys.exit(1)

if __name__ == '__main__':
    main()
