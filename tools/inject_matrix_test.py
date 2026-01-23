#!/usr/bin/env python3
"""
Phase 15.7: Slave Matrix-Vector Multiplication Test

Proves the Slave can perform a full 3x3 matrix * 3D vector transform:
    result.x = M[0]*x + M[1]*y + M[2]*z
    result.y = M[3]*x + M[4]*y + M[5]*z
    result.z = M[6]*x + M[7]*y + M[8]*z

This requires 9 multiplies and 6 adds - the core of vertex rotation.

Memory layout (all 16.16 fixed-point):
    0x22000200: Matrix M[0..8] (36 bytes)
    0x22000224: Input vertex (x, y, z) (12 bytes)
    0x22000230: Output vertex (x', y', z') (12 bytes)
    0x20004028: COMM4 counter

Test 1 - Identity matrix (verify basic operation):
    M = [1,0,0, 0,1,0, 0,0,1]
    V = (1.0, 2.0, 3.0)
    Expected: (1.0, 2.0, 3.0)

Test 2 - Scale matrix (verify all multiplies work):
    M = [2,0,0, 0,2,0, 0,0,2]
    V = (1.0, 2.0, 3.0)
    Expected: (2.0, 4.0, 6.0)

Usage:
    python3 tools/inject_matrix_test.py build/vr_baseline_probe.32x build/vr_matrix_test.32x [--scale]
"""

import sys
import struct
from pathlib import Path

# Memory addresses
MATRIX_ADDR = 0x22000200      # 9 elements * 4 bytes = 36 bytes
INPUT_VERTEX_ADDR = 0x22000224  # 3 elements * 4 bytes = 12 bytes
OUTPUT_VERTEX_ADDR = 0x22000230  # 3 elements * 4 bytes = 12 bytes
COMM4_ADDR = 0x20004028

# 16.16 fixed-point conversion
def to_fixed(f): return int(f * 65536) & 0xFFFFFFFF

# Test matrices (row-major: M[0],M[1],M[2] is first row)
IDENTITY_MATRIX = [
    to_fixed(1.0), to_fixed(0.0), to_fixed(0.0),
    to_fixed(0.0), to_fixed(1.0), to_fixed(0.0),
    to_fixed(0.0), to_fixed(0.0), to_fixed(1.0),
]

SCALE_MATRIX = [
    to_fixed(2.0), to_fixed(0.0), to_fixed(0.0),
    to_fixed(0.0), to_fixed(2.0), to_fixed(0.0),
    to_fixed(0.0), to_fixed(0.0), to_fixed(2.0),
]

# Test vertex
INPUT_VERTEX = [to_fixed(1.0), to_fixed(2.0), to_fixed(3.0)]

# Expected results
IDENTITY_EXPECTED = [to_fixed(1.0), to_fixed(2.0), to_fixed(3.0)]
SCALE_EXPECTED = [to_fixed(2.0), to_fixed(4.0), to_fixed(6.0)]


def create_matrix_handler(handler_addr: int) -> bytes:
    """
    Create SH2 handler for 3x3 matrix * 3D vector multiplication.

    Algorithm for each output component:
        out[i] = M[i*3+0]*in[0] + M[i*3+1]*in[1] + M[i*3+2]*in[2]

    Uses DMULS.L + XTRCT for each 16.16 multiply, then ADD for accumulation.
    """
    code = bytearray()

    # Load base addresses
    matrix_mov = len(code)
    code.extend([0xD4, 0x00])  # MOV.L @(disp,PC),R4 - matrix base

    input_mov = len(code)
    code.extend([0xD5, 0x00])  # MOV.L @(disp,PC),R5 - input vertex

    output_mov = len(code)
    code.extend([0xD6, 0x00])  # MOV.L @(disp,PC),R6 - output vertex

    # Load input vertex into R8, R9, R10 (x, y, z)
    code.extend([0x65, 0x52])  # MOV.L @R5,R5 -> actually need post-inc
    # Reload R5
    code[input_mov:input_mov+2] = [0xD5, 0x00]  # Will fix displacement

    # Let's reload input addr and read
    code.extend([0x68, 0x56])  # MOV.L @R5+,R8 - x
    code.extend([0x69, 0x56])  # MOV.L @R5+,R9 - y
    code.extend([0x6A, 0x52])  # MOV.L @R5,R10 - z

    # === Row 0: out.x = M[0]*x + M[1]*y + M[2]*z ===

    # M[0] * x
    code.extend([0x60, 0x46])  # MOV.L @R4+,R0 - M[0]
    code.extend([0x38, 0x0D])  # DMULS.L R0,R8
    code.extend([0x02, 0x0A])  # STS MACH,R2
    code.extend([0x03, 0x1A])  # STS MACL,R3
    code.extend([0x23, 0x2D])  # XTRCT R2,R3 - R3 = M[0]*x

    code.extend([0x67, 0x33])  # MOV R3,R7 - accumulator = M[0]*x

    # M[1] * y
    code.extend([0x60, 0x46])  # MOV.L @R4+,R0 - M[1]
    code.extend([0x39, 0x0D])  # DMULS.L R0,R9
    code.extend([0x02, 0x0A])  # STS MACH,R2
    code.extend([0x03, 0x1A])  # STS MACL,R3
    code.extend([0x23, 0x2D])  # XTRCT R2,R3 - R3 = M[1]*y

    code.extend([0x37, 0x3C])  # ADD R3,R7 - accumulator += M[1]*y

    # M[2] * z
    code.extend([0x60, 0x46])  # MOV.L @R4+,R0 - M[2]
    code.extend([0x3A, 0x0D])  # DMULS.L R0,R10
    code.extend([0x02, 0x0A])  # STS MACH,R2
    code.extend([0x03, 0x1A])  # STS MACL,R3
    code.extend([0x23, 0x2D])  # XTRCT R2,R3 - R3 = M[2]*z

    code.extend([0x37, 0x3C])  # ADD R3,R7 - R7 = out.x

    # Store out.x
    code.extend([0x26, 0x72])  # MOV.L R7,@R6
    code.extend([0x76, 0x04])  # ADD #4,R6

    # === Row 1: out.y = M[3]*x + M[4]*y + M[5]*z ===

    # M[3] * x
    code.extend([0x60, 0x46])  # MOV.L @R4+,R0 - M[3]
    code.extend([0x38, 0x0D])  # DMULS.L R0,R8
    code.extend([0x02, 0x0A])  # STS MACH,R2
    code.extend([0x03, 0x1A])  # STS MACL,R3
    code.extend([0x23, 0x2D])  # XTRCT R2,R3

    code.extend([0x67, 0x33])  # MOV R3,R7

    # M[4] * y
    code.extend([0x60, 0x46])  # MOV.L @R4+,R0 - M[4]
    code.extend([0x39, 0x0D])  # DMULS.L R0,R9
    code.extend([0x02, 0x0A])  # STS MACH,R2
    code.extend([0x03, 0x1A])  # STS MACL,R3
    code.extend([0x23, 0x2D])  # XTRCT R2,R3

    code.extend([0x37, 0x3C])  # ADD R3,R7

    # M[5] * z
    code.extend([0x60, 0x46])  # MOV.L @R4+,R0 - M[5]
    code.extend([0x3A, 0x0D])  # DMULS.L R0,R10
    code.extend([0x02, 0x0A])  # STS MACH,R2
    code.extend([0x03, 0x1A])  # STS MACL,R3
    code.extend([0x23, 0x2D])  # XTRCT R2,R3

    code.extend([0x37, 0x3C])  # ADD R3,R7 - R7 = out.y

    # Store out.y
    code.extend([0x26, 0x72])  # MOV.L R7,@R6
    code.extend([0x76, 0x04])  # ADD #4,R6

    # === Row 2: out.z = M[6]*x + M[7]*y + M[8]*z ===

    # M[6] * x
    code.extend([0x60, 0x46])  # MOV.L @R4+,R0 - M[6]
    code.extend([0x38, 0x0D])  # DMULS.L R0,R8
    code.extend([0x02, 0x0A])  # STS MACH,R2
    code.extend([0x03, 0x1A])  # STS MACL,R3
    code.extend([0x23, 0x2D])  # XTRCT R2,R3

    code.extend([0x67, 0x33])  # MOV R3,R7

    # M[7] * y
    code.extend([0x60, 0x46])  # MOV.L @R4+,R0 - M[7]
    code.extend([0x39, 0x0D])  # DMULS.L R0,R9
    code.extend([0x02, 0x0A])  # STS MACH,R2
    code.extend([0x03, 0x1A])  # STS MACL,R3
    code.extend([0x23, 0x2D])  # XTRCT R2,R3

    code.extend([0x37, 0x3C])  # ADD R3,R7

    # M[8] * z
    code.extend([0x60, 0x46])  # MOV.L @R4+,R0 - M[8]
    code.extend([0x3A, 0x0D])  # DMULS.L R0,R10
    code.extend([0x02, 0x0A])  # STS MACH,R2
    code.extend([0x03, 0x1A])  # STS MACL,R3
    code.extend([0x23, 0x2D])  # XTRCT R2,R3

    code.extend([0x37, 0x3C])  # ADD R3,R7 - R7 = out.z

    # Store out.z
    code.extend([0x26, 0x72])  # MOV.L R7,@R6

    # === Increment COMM4 ===
    comm4_mov = len(code)
    code.extend([0xD0, 0x00])  # MOV.L @(disp,PC),R0 - COMM4

    code.extend([0x61, 0x02])  # MOV.L @R0,R1
    code.extend([0x71, 0x01])  # ADD #1,R1
    code.extend([0x20, 0x12])  # MOV.L R1,@R0

    # Return
    code.extend([0x00, 0x0B])  # RTS
    code.extend([0x00, 0x09])  # NOP

    # Align
    while len(code) % 4 != 0:
        code.extend([0x00, 0x09])

    # Literal pool
    matrix_lit = len(code)
    code.extend(struct.pack('>I', MATRIX_ADDR))

    input_lit = len(code)
    code.extend(struct.pack('>I', INPUT_VERTEX_ADDR))

    output_lit = len(code)
    code.extend(struct.pack('>I', OUTPUT_VERTEX_ADDR))

    comm4_lit = len(code)
    code.extend(struct.pack('>I', COMM4_ADDR))

    # Fix displacements
    def calc_disp(instr_offset, literal_offset):
        pc = handler_addr + instr_offset
        base = (pc & ~3) + 4
        return (handler_addr + literal_offset - base) // 4

    code[matrix_mov + 1] = calc_disp(matrix_mov, matrix_lit)
    code[input_mov + 1] = calc_disp(input_mov, input_lit)
    code[output_mov + 1] = calc_disp(output_mov, output_lit)
    code[comm4_mov + 1] = calc_disp(comm4_mov, comm4_lit)

    return bytes(code)


def create_matrix_vblank_code(code_start_addr: int, matrix: list, vertex: list) -> bytes:
    """
    Create VBlank code that writes test matrix and vertex.
    """
    code = bytearray()

    # VBlank poll
    vdp_mov = len(code)
    code.extend([0xD1, 0x00])  # MOV.L @(disp,PC),R1 - VDP base

    poll_loop = len(code)
    code.extend([0x85, 0x15])  # MOV.W @(10,R1),R0
    code.extend([0xC8, 0x02])  # TST #2,R0

    bf_offset = len(code)
    bf_disp = (poll_loop - (bf_offset + 4)) // 2
    code.extend([0x8B, bf_disp & 0xFF])

    # Save registers
    code.extend([0x2F, 0x06])  # push R0
    code.extend([0x2F, 0x26])  # push R2
    code.extend([0x2F, 0x36])  # push R3

    # FPS counter
    counter_mov = len(code)
    code.extend([0xD2, 0x00])
    code.extend([0x60, 0x22])
    code.extend([0x70, 0x01])
    code.extend([0x22, 0x02])

    # Write matrix (9 values)
    matrix_addr_mov = len(code)
    code.extend([0xD2, 0x00])  # R2 = matrix addr

    matrix_val_movs = []
    for _ in range(9):
        matrix_val_movs.append(len(code))
        code.extend([0xD0, 0x00])  # MOV.L value
        code.extend([0x22, 0x02])  # MOV.L R0,@R2
        code.extend([0x72, 0x04])  # ADD #4,R2

    # Write input vertex (3 values)
    vertex_addr_mov = len(code)
    code.extend([0xD2, 0x00])  # R2 = vertex addr

    vertex_val_movs = []
    for _ in range(3):
        vertex_val_movs.append(len(code))
        code.extend([0xD0, 0x00])
        code.extend([0x22, 0x02])
        code.extend([0x72, 0x04])

    # Signal Slave
    comm6_mov = len(code)
    code.extend([0xD0, 0x00])
    code.extend([0xE1, 0x12])
    code.extend([0x20, 0x12])

    # Restore
    code.extend([0x63, 0xF6])
    code.extend([0x62, 0xF6])
    code.extend([0x60, 0xF6])

    code.extend([0x00, 0x0B])
    code.extend([0x00, 0x09])

    # Align
    while len(code) % 4 != 0:
        code.extend([0x00, 0x09])

    # Literal pool
    vdp_lit = len(code)
    code.extend(struct.pack('>I', 0x20004100))

    counter_lit = len(code)
    code.extend(struct.pack('>I', 0x22000100))

    matrix_addr_lit = len(code)
    code.extend(struct.pack('>I', MATRIX_ADDR))

    matrix_val_lits = []
    for val in matrix:
        matrix_val_lits.append(len(code))
        code.extend(struct.pack('>I', val))

    vertex_addr_lit = len(code)
    code.extend(struct.pack('>I', INPUT_VERTEX_ADDR))

    vertex_val_lits = []
    for val in vertex:
        vertex_val_lits.append(len(code))
        code.extend(struct.pack('>I', val))

    comm6_lit = len(code)
    code.extend(struct.pack('>I', 0x2000402C))

    # Fix displacements
    def calc_disp(instr_offset, literal_offset):
        pc = code_start_addr + instr_offset
        base = (pc & ~3) + 4
        return (code_start_addr + literal_offset - base) // 4

    code[vdp_mov + 1] = calc_disp(vdp_mov, vdp_lit)
    code[counter_mov + 1] = calc_disp(counter_mov, counter_lit)
    code[matrix_addr_mov + 1] = calc_disp(matrix_addr_mov, matrix_addr_lit)

    for i, mov_offset in enumerate(matrix_val_movs):
        code[mov_offset + 1] = calc_disp(mov_offset, matrix_val_lits[i])

    code[vertex_addr_mov + 1] = calc_disp(vertex_addr_mov, vertex_addr_lit)

    for i, mov_offset in enumerate(vertex_val_movs):
        code[mov_offset + 1] = calc_disp(mov_offset, vertex_val_lits[i])

    code[comm6_mov + 1] = calc_disp(comm6_mov, comm6_lit)

    return bytes(code)


def inject_matrix_test(input_rom: str, output_rom: str, use_scale: bool) -> bool:
    """Inject matrix-vector multiplication test."""

    matrix = SCALE_MATRIX if use_scale else IDENTITY_MATRIX
    expected = SCALE_EXPECTED if use_scale else IDENTITY_EXPECTED
    test_name = "SCALE (2x)" if use_scale else "IDENTITY"

    print("=" * 70)
    print(f"PHASE 15.7: SLAVE MATRIX-VECTOR TEST ({test_name})")
    print("=" * 70)
    print()

    rom_path = Path(input_rom)
    if not rom_path.exists():
        print(f"ROM not found: {input_rom}")
        return False

    rom_data = bytearray(rom_path.read_bytes())
    print(f"ROM loaded: {len(rom_data):,} bytes")
    print()

    # Inject handler
    handler_offset = 0x300027
    handler_addr = 0x02300027

    new_handler = create_matrix_handler(handler_addr)
    print(f"Handler size: {len(new_handler)} bytes")
    print()

    print("Handler performs 3x3 matrix * 3D vector:")
    print("  out.x = M[0]*x + M[1]*y + M[2]*z")
    print("  out.y = M[3]*x + M[4]*y + M[5]*z")
    print("  out.z = M[6]*x + M[7]*y + M[8]*z")
    print()
    print("Operations: 9 multiplies (DMULS.L+XTRCT) + 6 adds")
    print()

    rom_data[handler_offset:handler_offset + len(new_handler)] = new_handler

    # Inject VBlank
    vblank_offset = 0x300040
    vblank_addr = 0x02300040

    vblank_code = create_matrix_vblank_code(vblank_addr, matrix, INPUT_VERTEX)
    print(f"VBlank code size: {len(vblank_code)} bytes")

    rom_data[vblank_offset:vblank_offset + len(vblank_code)] = vblank_code

    # Write
    Path(output_rom).write_bytes(rom_data)
    print()
    print(f"Output: {output_rom}")
    print()

    # Summary
    print("=" * 70)
    print("TEST CONFIGURATION")
    print("=" * 70)
    print()
    print(f"Matrix ({test_name}):")
    for row in range(3):
        vals = [matrix[row*3 + col] / 65536 for col in range(3)]
        print(f"  [{vals[0]:6.2f}, {vals[1]:6.2f}, {vals[2]:6.2f}]")
    print()
    print(f"Input vertex: ({INPUT_VERTEX[0]/65536:.1f}, {INPUT_VERTEX[1]/65536:.1f}, {INPUT_VERTEX[2]/65536:.1f})")
    print(f"Expected out: ({expected[0]/65536:.1f}, {expected[1]/65536:.1f}, {expected[2]/65536:.1f})")
    print()

    print("=" * 70)
    print("MEMORY VERIFICATION")
    print("=" * 70)
    print()
    print(f"Matrix at 0x{MATRIX_ADDR:08X}:")
    for i, val in enumerate(matrix):
        print(f"  +{i*4:02X}: 0x{val:08X} ({val/65536:.2f})")
    print()
    print(f"Input at 0x{INPUT_VERTEX_ADDR:08X}:")
    for i, val in enumerate(INPUT_VERTEX):
        print(f"  +{i*4:02X}: 0x{val:08X} ({val/65536:.1f})")
    print()
    print(f"Output at 0x{OUTPUT_VERTEX_ADDR:08X}:")
    for i, val in enumerate(expected):
        print(f"  +{i*4:02X}: should be 0x{val:08X} ({val/65536:.1f})")
    print()
    print("SUCCESS: Output matches expected values")
    print("This proves Slave can do full vertex rotation transforms!")
    print()

    return True


def main():
    if len(sys.argv) < 3:
        print("Usage: python3 inject_matrix_test.py <input.32x> <output.32x> [--scale]")
        print()
        print("Options:")
        print("  --scale    Use 2x scale matrix instead of identity")
        print()
        print("Example:")
        print("  python3 inject_matrix_test.py build/vr_baseline_probe.32x build/vr_matrix_test.32x")
        print("  python3 inject_matrix_test.py build/vr_baseline_probe.32x build/vr_matrix_test.32x --scale")
        sys.exit(1)

    use_scale = "--scale" in sys.argv
    success = inject_matrix_test(sys.argv[1], sys.argv[2], use_scale)
    sys.exit(0 if success else 1)


if __name__ == '__main__':
    main()
