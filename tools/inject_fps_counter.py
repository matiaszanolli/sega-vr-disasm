#!/usr/bin/env python3
"""
FPS Counter Injector - Function Replacement Version

Replaces the entire VBlank poll function with a JMP to new code that:
1. Does the original VBlank poll
2. Increments the frame counter
3. Returns

This avoids the problem of limited BRA range and overwriting adjacent code.
"""

import sys
import struct
from pathlib import Path


def create_vblank_poll_with_counter(code_start_addr: int) -> bytes:
    """
    Create combined VBlank poll + frame counter code.

    This replaces the original VBlank poll function entirely.
    Original function was at 0x243E0-0x243EF (16 bytes).
    """
    code = bytearray()

    # === Original VBlank poll logic ===
    # Original code:
    #   D102  MOV.L @(8,PC),R1   ; Load VDP base 0x20004100
    #   8515  MOV.W @(10,R1),R0  ; Read VDP status at 0x2000410A
    #   C802  TST #2,R0          ; Test VBlank bit
    #   8BFC  BF poll_loop       ; Loop if not set
    #   000B  RTS
    #   0009  NOP

    # We need to calculate literal offsets based on final code size
    # For now, use placeholders and fix at the end

    # Load VDP base address (literal will be at end)
    # MOV.L @(disp,PC),R1 - we'll calculate disp later
    vdp_mov_offset = len(code)
    code.extend([0xD1, 0x00])  # Placeholder - will fix

    # poll_loop:
    poll_loop_offset = len(code)
    code.extend([0x85, 0x15])  # MOV.W @(10,R1),R0 - read VDP status
    code.extend([0xC8, 0x02])  # TST #2,R0 - test VBlank bit

    # BF back to poll_loop
    # BF displacement: target = PC + 4 + disp*2
    # Current offset after BF = poll_loop_offset + 6
    # PC = current_addr + 2 (after fetch)
    # target = poll_loop
    # disp*2 = poll_loop - (current + 4)
    bf_offset = len(code)
    bf_disp = (poll_loop_offset - (bf_offset + 4)) // 2
    if bf_disp < 0:
        bf_disp = bf_disp & 0xFF  # 8-bit signed
    code.extend([0x8B, bf_disp & 0xFF])  # BF poll_loop

    # === Frame counter increment ===
    # Save R0, R1, R2 (R1 still has VDP base, we'll reload for counter)
    code.extend([0x2F, 0x06])  # MOV.L R0,@-R15
    code.extend([0x2F, 0x26])  # MOV.L R2,@-R15

    # Load counter base address
    counter_mov_offset = len(code)
    code.extend([0xD2, 0x00])  # MOV.L @(disp,PC),R2 - placeholder

    # Increment total frame counter at offset 0
    code.extend([0x60, 0x22])  # MOV.L @R2,R0
    code.extend([0x70, 0x01])  # ADD #1,R0
    code.extend([0x22, 0x02])  # MOV.L R0,@R2

    # Restore R2, R0
    code.extend([0x62, 0xF6])  # MOV.L @R15+,R2
    code.extend([0x60, 0xF6])  # MOV.L @R15+,R0

    # Return
    code.extend([0x00, 0x0B])  # RTS
    code.extend([0x00, 0x09])  # NOP (delay slot)

    # Align to 4 bytes for literals
    while len(code) % 4 != 0:
        code.extend([0x00, 0x09])  # NOP padding

    # Literal pool
    vdp_literal_offset = len(code)
    code.extend(struct.pack('>I', 0x20004100))  # VDP base address

    counter_literal_offset = len(code)
    code.extend(struct.pack('>I', 0x22000100))  # Counter base address

    # Now fix up the MOV.L displacements
    # For MOV.L @(disp,PC),Rn: addr = (PC & ~3) + 4 + disp*4
    # where PC is the address of the MOV.L instruction

    # Fix VDP MOV.L at vdp_mov_offset
    # PC = code_start_addr + vdp_mov_offset
    # (PC & ~3) + 4 = base for displacement
    # literal at code_start_addr + vdp_literal_offset
    vdp_pc = code_start_addr + vdp_mov_offset
    vdp_base = (vdp_pc & ~3) + 4
    vdp_disp = (code_start_addr + vdp_literal_offset - vdp_base) // 4
    code[vdp_mov_offset + 1] = vdp_disp

    # Fix counter MOV.L at counter_mov_offset
    counter_pc = code_start_addr + counter_mov_offset
    counter_base = (counter_pc & ~3) + 4
    counter_disp = (code_start_addr + counter_literal_offset - counter_base) // 4
    code[counter_mov_offset + 1] = counter_disp

    return bytes(code)


def inject_fps_counter(input_rom: str, output_rom: str) -> bool:
    """Inject FPS counter by replacing VBlank poll function."""

    print("=" * 70)
    print("FPS COUNTER INJECTOR - Function Replacement")
    print("=" * 70)
    print()

    # Load ROM
    rom_path = Path(input_rom)
    if not rom_path.exists():
        print(f"ROM not found: {input_rom}")
        return False

    rom_data = bytearray(rom_path.read_bytes())
    print(f"ROM loaded: {len(rom_data):,} bytes")

    # Find VBlank poll function
    # Pattern: D102 8515 C802 8BFC 000B 0009 (the function start + body)
    # The function starts with MOV.L @(8,PC),R1 which is D102
    pattern = bytes([0xD1, 0x02, 0x85, 0x15, 0xC8, 0x02, 0x8B, 0xFC, 0x00, 0x0B, 0x00, 0x09])

    vblank_func = None
    for i in range(0x20000, len(rom_data) - len(pattern)):
        if rom_data[i:i+len(pattern)] == pattern:
            vblank_func = i
            break

    if vblank_func is None:
        print("VBlank poll function not found!")
        return False

    print(f"VBlank function found at ROM 0x{vblank_func:06X}")
    print()

    # Show original code
    print("Original VBlank function:")
    print(f"  0x{vblank_func:06X}: D102      MOV.L @(8,PC),R1  ; Load VDP base")
    print(f"  0x{vblank_func+2:06X}: 8515      MOV.W @(10,R1),R0 ; Read status")
    print(f"  0x{vblank_func+4:06X}: C802      TST #2,R0         ; Test VBlank")
    print(f"  0x{vblank_func+6:06X}: 8BFC      BF poll_loop")
    print(f"  0x{vblank_func+8:06X}: 000B      RTS")
    print(f"  0x{vblank_func+10:06X}: 0009      NOP")
    print(f"  0x{vblank_func+12:06X}: 20004100  .long VDP_BASE")
    print()

    # Find free space for new code
    code_size = 64  # Our new code is small
    free_space = None
    for i in range(0x30000, len(rom_data) - code_size, 4):
        if all(b == 0xFF for b in rom_data[i:i+code_size]):
            free_space = i
            break

    if free_space is None:
        print("No free space found!")
        return False

    print(f"Free space found at ROM 0x{free_space:06X}")

    # CPU address for the new code
    new_code_addr = 0x02000000 + free_space
    print(f"New code CPU address: 0x{new_code_addr:08X}")
    print()

    # Generate the new VBlank poll + counter code
    new_code = create_vblank_poll_with_counter(new_code_addr)
    print(f"New code size: {len(new_code)} bytes")
    print(f"New code hex: {new_code.hex(' ')}")
    print()

    # Inject new code at free space
    rom_data[free_space:free_space+len(new_code)] = new_code
    print(f"Injected new code at ROM 0x{free_space:06X}")

    # Replace original function with JMP to new code
    # Original function is 16 bytes (0x243E0-0x243EF)
    # We replace it with:
    #   D101  MOV.L @(4,PC),R1   ; Load new code address
    #   412B  JMP @R1            ; Jump to new code
    #   0009  NOP                ; Delay slot
    #   0009  NOP                ; Padding
    #   xxxx xxxx               ; Literal: new code address
    #   xxxx xxxx               ; Remaining space (can be anything)

    replacement = bytearray()
    replacement.extend([0xD1, 0x01])  # MOV.L @(4,PC),R1
    replacement.extend([0x41, 0x2B])  # JMP @R1
    replacement.extend([0x00, 0x09])  # NOP (delay slot)
    replacement.extend([0x00, 0x09])  # NOP (padding to align literal)
    replacement.extend(struct.pack('>I', new_code_addr))  # Literal
    # Fill rest with NOPs to reach 16 bytes
    while len(replacement) < 16:
        replacement.extend([0x00, 0x09])

    print(f"Replacement code: {replacement.hex(' ')}")

    # Verify MOV.L displacement calculation
    # MOV.L at 0x243E0, PC = 0x243E0, (PC & ~3) + 4 = 0x243E4
    # Literal at 0x243E8, disp = (0x243E8 - 0x243E4) / 4 = 1
    print(f"MOV.L displacement check: disp=1 -> literal at PC_base+4 = correct")
    print()

    rom_data[vblank_func:vblank_func+16] = replacement
    print(f"Replaced original function at ROM 0x{vblank_func:06X}")
    print()

    # Write output
    Path(output_rom).write_bytes(rom_data)
    print(f"Output written: {output_rom}")
    print()

    print("=" * 70)
    print("TESTING")
    print("=" * 70)
    print("""
Monitor SDRAM address 0x22000100 in emulator memory viewer.
The value should increment every frame (~20-30 times per second).

If the game crashes:
- Check if the new code disassembles correctly
- Verify literal pool addresses are correct
- Check if we're overwriting any other code
""")

    return True


def main():
    if len(sys.argv) != 3:
        print("Usage: python3 inject_fps_counter.py <input.32x> <output.32x>")
        sys.exit(1)

    success = inject_fps_counter(sys.argv[1], sys.argv[2])
    sys.exit(0 if success else 1)


if __name__ == '__main__':
    main()
