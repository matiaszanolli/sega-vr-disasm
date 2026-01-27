#!/usr/bin/env python3
"""
VRD Delay Loop Patcher
Patches the busy-wait delay loop to test performance improvement

Original delay loop at ROM offset 0x2060A (SDRAM 0x0600060A):
  0x02000608: E740  MOV #0x40, R7  ; Load delay count = 64 iterations
  0x0200060A: 0009  NOP            ; Loop entry (66.5% hotspot)
  0x0200060C: 4710  DT R7          ; Decrement R7
  0x0200060E: 8BFC  BF loop        ; Branch back if R7 != 0

Test configurations:
  - Original:   MOV #0x40, R7  (64 iterations = 192 cycles)
  - 50% reduction:  MOV #0x20, R7  (32 iterations = 96 cycles)
  - 75% reduction:  MOV #0x10, R7  (16 iterations = 48 cycles)
  - 98% reduction:  MOV #0x01, R7  (1 iteration = 3 cycles)
  - Full bypass:    NOP (eliminates loop entirely)
"""

import sys
import shutil
from pathlib import Path


def patch_delay_loop(input_rom: str, output_rom: str, delay_value: int):
    """
    Patch the delay loop with a new iteration count

    Args:
        input_rom: Path to original ROM
        output_rom: Path to output patched ROM
        delay_value: New delay iteration count (0x01-0x7F)
                     Use 0 for full bypass (NOP the MOV instruction)
    """

    # Read original ROM
    with open(input_rom, 'rb') as f:
        rom_data = bytearray(f.read())

    # Patch location: file offset 0x2060A
    # But we patch the MOV instruction at 0x20608 (2 bytes before loop)
    patch_offset = 0x20608

    if delay_value == 0:
        # Full bypass: NOP the MOV instruction
        rom_data[patch_offset] = 0x00
        rom_data[patch_offset + 1] = 0x09
        print(f"Patching: Full bypass (NOP at 0x{patch_offset:06X})")
    else:
        # Partial reduction: Change the immediate value
        if delay_value > 0x7F:
            print(f"Error: delay_value must be 0x00-0x7F (got 0x{delay_value:02X})")
            return False

        # MOV #imm, Rn instruction: 1110 nnnn iiii iiii
        # For R7: 1110 0111 iiii iiii = 0xE7xx
        rom_data[patch_offset] = 0xE7
        rom_data[patch_offset + 1] = delay_value
        print(f"Patching: MOV #0x{delay_value:02X}, R7 at 0x{patch_offset:06X}")

    # Write patched ROM
    with open(output_rom, 'wb') as f:
        f.write(rom_data)

    print(f"Created patched ROM: {output_rom}")
    print(f"  Original delay: 64 iterations (0x40)")
    print(f"  Patched delay:  {delay_value} iterations (0x{delay_value:02X})")

    # Calculate expected performance gain
    original_cycles_per_call = 64 * 3  # 192 cycles
    new_cycles_per_call = delay_value * 3 if delay_value > 0 else 0
    reduction = 100 * (original_cycles_per_call - new_cycles_per_call) / original_cycles_per_call

    # Frame-level calculation (1037 calls per frame)
    calls_per_frame = 1037
    original_overhead = original_cycles_per_call * calls_per_frame  # ~199K
    new_overhead = new_cycles_per_call * calls_per_frame

    original_slave = 300000  # Original Slave cycles/frame
    new_slave = original_slave - original_overhead + new_overhead

    print(f"\nExpected Performance:")
    print(f"  Per-call reduction: {reduction:.1f}%")
    print(f"  Original overhead:  {original_overhead:,} cycles/frame")
    print(f"  New overhead:       {new_overhead:,} cycles/frame")
    print(f"  Slave cycles/frame: {original_slave:,} → {new_slave:,}")
    print(f"  Theoretical FPS:    24 → {int(23000000 / (new_slave + 139568))}")

    return True


def main():
    if len(sys.argv) < 4:
        print("Usage: patch_delay_loop.py <input.32x> <output.32x> <delay_value>")
        print()
        print("delay_value options:")
        print("  0x40 (64)   - Original delay (no change)")
        print("  0x20 (32)   - 50% reduction")
        print("  0x10 (16)   - 75% reduction")
        print("  0x04 (4)    - 94% reduction")
        print("  0x01 (1)    - 98% reduction (recommended test)")
        print("  0x00 (0)    - Full bypass (eliminates delay entirely)")
        print()
        print("Example:")
        print("  ./patch_delay_loop.py input.32x output_fast.32x 0x01")
        sys.exit(1)

    input_rom = sys.argv[1]
    output_rom = sys.argv[2]

    # Parse delay value (support hex or decimal)
    delay_str = sys.argv[3]
    if delay_str.startswith('0x') or delay_str.startswith('0X'):
        delay_value = int(delay_str, 16)
    else:
        delay_value = int(delay_str)

    if not Path(input_rom).exists():
        print(f"Error: Input ROM not found: {input_rom}")
        sys.exit(1)

    if not patch_delay_loop(input_rom, output_rom, delay_value):
        sys.exit(1)

    print(f"\nNext steps:")
    print(f"  1. Profile test ROM: cd tools/libretro-profiling && ./run_pc_profiling.sh ../../{output_rom} 2400")
    print(f"  2. Analyze results: python3 analyze_profile.py vrd_profile_pc_frames.csv")
    print(f"  3. Test gameplay: picodrive {output_rom}")


if __name__ == "__main__":
    main()
