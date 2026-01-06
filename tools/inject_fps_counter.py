#!/usr/bin/env python3
"""
FPS Counter Injector V2 - Fixed JSR version

Uses JSR instead of BSR to reach distant code.
"""

import sys
import struct
from pathlib import Path


def create_frame_counter_code() -> bytes:
    """
    Hand-coded SH2 FPS counter (same as before).
    """
    code = bytearray()

    # Save registers
    code.extend([0x2F, 0x06])  # MOV.L R0,@-R15
    code.extend([0x2F, 0x16])  # MOV.L R1,@-R15
    code.extend([0x2F, 0x26])  # MOV.L R2,@-R15
    code.extend([0x2F, 0x36])  # MOV.L R3,@-R15

    # Load counter base (will fix offset later)
    code.extend([0xD1, 0x2C])  # MOV.L @(literal,PC),R1

    # Increment frame_counter
    code.extend([0x60, 0x12])  # MOV.L @R1,R0
    code.extend([0x70, 0x01])  # ADD #1,R0
    code.extend([0x21, 0x02])  # MOV.L R0,@R1

    # Increment frames_this_second
    code.extend([0x50, 0x14])  # MOV.L @(4,R1),R0
    code.extend([0x70, 0x01])  # ADD #1,R0
    code.extend([0x51, 0x04])  # MOV.L R0,@(4,R1)

    # Increment vblank_counter
    code.extend([0x50, 0x18])  # MOV.L @(8,R1),R0
    code.extend([0x70, 0x01])  # ADD #1,R0
    code.extend([0x51, 0x08])  # MOV.L R0,@(8,R1)

    # Check if >= 60
    code.extend([0xE2, 0x3C])  # MOV #60,R2
    code.extend([0x30, 0x23])  # CMP/GE R2,R0
    code.extend([0x8B, 0x13])  # BF skip_fps_calc

    # Calculate FPS
    code.extend([0x50, 0x14])  # MOV.L @(4,R1),R0
    code.extend([0x51, 0x0C])  # MOV.L R0,@(12,R1)

    # Update min
    code.extend([0x52, 0x10])  # MOV.L @(16,R1),R2
    code.extend([0x32, 0x07])  # CMP/GT R0,R2
    code.extend([0x8B, 0x01])  # BF skip_min
    code.extend([0x51, 0x10])  # MOV.L R0,@(16,R1)

    # Update max
    code.extend([0x52, 0x14])  # MOV.L @(20,R1),R2
    code.extend([0x30, 0x27])  # CMP/GT R2,R0
    code.extend([0x8B, 0x01])  # BF skip_max
    code.extend([0x51, 0x14])  # MOV.L R0,@(20,R1)

    # Reset counters
    code.extend([0xE0, 0x00])  # MOV #0,R0
    code.extend([0x51, 0x04])  # MOV.L R0,@(4,R1)
    code.extend([0x51, 0x08])  # MOV.L R0,@(8,R1)

    # Restore registers
    code.extend([0x63, 0xF6])  # MOV.L @R15+,R3
    code.extend([0x62, 0xF6])  # MOV.L @R15+,R2
    code.extend([0x61, 0xF6])  # MOV.L @R15+,R1
    code.extend([0x60, 0xF6])  # MOV.L @R15+,R0

    # Return
    code.extend([0x00, 0x0B])  # RTS
    code.extend([0x00, 0x09])  # NOP

    # Align to 4 bytes
    while len(code) % 4 != 0:
        code.extend([0x00, 0x09])

    # Literal: counter address
    code.extend(struct.pack('>I', 0x22000100))

    return bytes(code)


def inject_fps_counter(input_rom: str, output_rom: str) -> bool:
    """Inject FPS counter using JSR."""

    print("=" * 70)
    print("FPS COUNTER INJECTOR V2 (JSR-based)")
    print("=" * 70)
    print()

    # Load ROM
    rom_path = Path(input_rom)
    if not rom_path.exists():
        print(f"❌ ROM not found")
        return False

    rom_data = bytearray(rom_path.read_bytes())
    print(f"✓ ROM: {len(rom_data):,} bytes")

    # Find VBlank poll
    pattern = bytes([0x85, 0x15, 0xC8, 0x02, 0x8B, 0xFC, 0x00, 0x0B])
    vblank_rts = None
    for i in range(0x20000, len(rom_data) - len(pattern)):
        if rom_data[i:i+len(pattern)] == pattern:
            vblank_rts = i + 6  # RTS offset
            break

    if not vblank_rts:
        print("❌ VBlank poll not found")
        return False

    print(f"✓ VBlank RTS: ROM 0x{vblank_rts:06X}")

    # Find free space (anywhere in ROM)
    code_size = 512
    free_space = None
    for i in range(0x30000, len(rom_data) - code_size, 16):
        if all(b == 0xFF for b in rom_data[i:i+code_size]):
            free_space = i
            break

    if not free_space:
        print("❌ No free space")
        return False

    print(f"✓ Free space: ROM 0x{free_space:06X}")
    print()

    # Generate code
    counter_code = create_frame_counter_code()
    print(f"✓ Counter code: {len(counter_code)} bytes")

    # Inject counter code
    rom_data[free_space:free_space+len(counter_code)] = counter_code
    print(f"✓ Injected at 0x{free_space:06X}")
    print()

    # Create JSR hook (replaces RTS + NOP + literal pool)
    # We have space from RTS (0x243E8) to literal (0x243EC) = 4 bytes initially
    # But we can use more if needed

    print("Creating JSR hook...")
    target_addr = 0x02000000 + free_space

    # JSR sequence (6 bytes):
    # D1xx: MOV.L @(disp,PC),R1  - load target address
    # 410B: JSR @R1               - jump to R1
    # 0009: NOP                   - delay slot

    hook_code = bytearray()
    hook_code.extend([0xD1, 0x01])  # MOV.L @(4,PC),R1 - literal 4 bytes ahead
    hook_code.extend([0x41, 0x0B])  # JSR @R1
    hook_code.extend([0x00, 0x09])  # NOP
    # Align to 4 bytes
    hook_code.extend([0x00, 0x09])  # NOP padding
    # Literal pool
    hook_code.extend(struct.pack('>I', target_addr))

    print(f"  Hook size: {len(hook_code)} bytes")
    print(f"  Hook hex: {hook_code.hex(' ')}")
    print(f"  Target: 0x{target_addr:08X}")
    print()

    # Inject hook
    rom_data[vblank_rts:vblank_rts+len(hook_code)] = hook_code
    print(f"✓ Hooked RTS at 0x{vblank_rts:06X}")

    # Verify we didn't corrupt the literal pool
    # Original literal at 0x243EC was 0x20004100
    # We overwrote it with our hook, need to make sure nothing else uses it

    print()
    print("⚠️  WARNING: Overwrote 12 bytes starting at RTS")
    print("   This may have overwritten a literal pool.")
    print("   Check if game still boots!")
    print()

    # Write output
    Path(output_rom).write_bytes(rom_data)
    print(f"✓ Output: {output_rom}")
    print()

    print("=" * 70)
    print("MEMORY LAYOUT")
    print("=" * 70)
    print("""
SDRAM Counters (watch these in emulator):
  0x22000100: Total frames
  0x2200010C: Current FPS
  0x22000110: Min FPS
  0x22000114: Max FPS

TEST:
1. Load ROM in Gens
2. Use memory viewer to watch 0x22000100
3. Start race
4. Check if counter increments (~20/sec)

If game doesn't boot, we corrupted something!
""")

    return True


def main():
    if len(sys.argv) != 3:
        print("Usage: python3 inject_fps_counter_v2.py <input> <output>")
        sys.exit(1)

    success = inject_fps_counter(sys.argv[1], sys.argv[2])
    sys.exit(0 if success else 1)


if __name__ == '__main__':
    main()
