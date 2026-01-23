#!/usr/bin/env python3
"""
Phase 16: Multi-Vertex Transform with Staging

Proves Slave can transform multiple vertices using cache-through staging.

Memory Layout (all cache-through 0x22XXXXXX):
    0x22000200-0x2200023F: Input vertices (4 × 16 bytes)
        - V0: (1.0, 0.0, 0.0, 1.0) at +0x00
        - V1: (0.0, 1.0, 0.0, 1.0) at +0x10
        - V2: (0.0, 0.0, 1.0, 1.0) at +0x20
        - V3: (1.0, 1.0, 1.0, 1.0) at +0x30
        - Signature 0xCAFE1234 at +0x3C (last 4 bytes of V3.w)

    0x22000240-0x2200027F: Identity matrix (4×4 × 4 bytes = 64 bytes)

    0x22000280-0x220002BF: Output vertices (4 × 16 bytes)
        - Slave writes transformed vertices here
        - Signature copy at +0x3C (should match input)

    0x220002FC: Done flag (Slave writes 0x00010001 when complete)

Protocol:
    Master: Write inputs + matrix + signal COMM6=0x0012
    Slave:  Transform 4 vertices, copy signature, write done flag, ack COMM4

Validation:
    - Identity matrix: output should equal input
    - Signature at 0x220002BC should equal 0xCAFE1234
    - Done flag at 0x220002FC should equal 0x00010001
    - COMM4 should increment

Usage:
    python3 tools/inject_phase16_vertex_test.py build/vr_baseline_probe.32x build/vr_phase16.32x
"""

import sys
import struct
from pathlib import Path

# Memory layout (cache-through, 16-byte aligned)
INPUT_VERTICES_ADDR = 0x22000200   # 64 bytes (4 vertices × 16 bytes)
MATRIX_ADDR = 0x22000240           # 64 bytes (4×4 matrix)
OUTPUT_VERTICES_ADDR = 0x22000280  # 64 bytes (4 vertices × 16 bytes)
DONE_FLAG_ADDR = 0x220002FC        # 4 bytes
COMM4_ADDR = 0x20004028
COMM6_ADDR = 0x2000402C

# Signature for sanity check
SIGNATURE = 0xCAFE1234
DONE_VALUE = 0x00010001

# 16.16 fixed-point conversion
def to_fixed(f): return int(f * 65536) & 0xFFFFFFFF

# Test vertices (will be transformed by identity matrix, so output = input)
INPUT_VERTICES = [
    # V0: (1.0, 0.0, 0.0, 1.0) - X axis
    [to_fixed(1.0), to_fixed(0.0), to_fixed(0.0), to_fixed(1.0)],
    # V1: (0.0, 1.0, 0.0, 1.0) - Y axis
    [to_fixed(0.0), to_fixed(1.0), to_fixed(0.0), to_fixed(1.0)],
    # V2: (0.0, 0.0, 1.0, 1.0) - Z axis
    [to_fixed(0.0), to_fixed(0.0), to_fixed(1.0), to_fixed(1.0)],
    # V3: (1.0, 1.0, 1.0, SIGNATURE) - diagonal + signature in W
    [to_fixed(1.0), to_fixed(1.0), to_fixed(1.0), SIGNATURE],
]

# Identity matrix (4×4, row-major)
IDENTITY_MATRIX = [
    to_fixed(1.0), to_fixed(0.0), to_fixed(0.0), to_fixed(0.0),
    to_fixed(0.0), to_fixed(1.0), to_fixed(0.0), to_fixed(0.0),
    to_fixed(0.0), to_fixed(0.0), to_fixed(1.0), to_fixed(0.0),
    to_fixed(0.0), to_fixed(0.0), to_fixed(0.0), to_fixed(1.0),
]


def create_vertex_transform_handler(handler_addr: int) -> bytes:
    """
    Create Slave handler that transforms 4 vertices.

    For identity matrix, this simplifies to copying X,Y,Z and W directly.
    But we implement full 4x4 matrix multiply to prove the algorithm.

    For each vertex V = (x, y, z, w):
        out.x = M[0]*x + M[1]*y + M[2]*z + M[3]*w
        out.y = M[4]*x + M[5]*y + M[6]*z + M[7]*w
        out.z = M[8]*x + M[9]*y + M[10]*z + M[11]*w
        out.w = M[12]*x + M[13]*y + M[14]*z + M[15]*w

    Then copy signature and write done flag.
    """
    code = bytearray()

    # Load base addresses from literal pool
    input_mov = len(code)
    code.extend([0xD4, 0x00])   # MOV.L @(disp,PC),R4 - input vertices

    matrix_mov = len(code)
    code.extend([0xD5, 0x00])   # MOV.L @(disp,PC),R5 - matrix

    output_mov = len(code)
    code.extend([0xD6, 0x00])   # MOV.L @(disp,PC),R6 - output vertices

    # R7 = vertex counter (4 vertices)
    code.extend([0xE7, 0x04])   # MOV #4,R7

    # === VERTEX LOOP ===
    vertex_loop_start = len(code)

    # Load vertex components into R8-R11 (x, y, z, w)
    code.extend([0x68, 0x46])   # MOV.L @R4+,R8  - x
    code.extend([0x69, 0x46])   # MOV.L @R4+,R9  - y
    code.extend([0x6A, 0x46])   # MOV.L @R4+,R10 - z
    code.extend([0x6B, 0x46])   # MOV.L @R4+,R11 - w

    # Save R5 (matrix pointer) for reuse
    code.extend([0x2F, 0x56])   # MOV.L R5,@-R15 (push R5)

    # === Transform X component ===
    # out.x = M[0]*x + M[1]*y + M[2]*z + M[3]*w
    code.extend([0x00, 0x28])   # CLRMAC

    # M[0] * x
    code.extend([0x60, 0x56])   # MOV.L @R5+,R0 - M[0]
    code.extend([0x38, 0x0D])   # DMULS.L R0,R8
    code.extend([0x02, 0x0A])   # STS MACH,R2
    code.extend([0x03, 0x1A])   # STS MACL,R3
    code.extend([0x23, 0x2D])   # XTRCT R2,R3 - R3 = M[0]*x

    code.extend([0x6C, 0x33])   # MOV R3,R12 - accumulator

    # M[1] * y
    code.extend([0x60, 0x56])   # MOV.L @R5+,R0 - M[1]
    code.extend([0x39, 0x0D])   # DMULS.L R0,R9
    code.extend([0x02, 0x0A])   # STS MACH,R2
    code.extend([0x03, 0x1A])   # STS MACL,R3
    code.extend([0x23, 0x2D])   # XTRCT R2,R3

    code.extend([0x3C, 0x3C])   # ADD R3,R12

    # M[2] * z
    code.extend([0x60, 0x56])   # MOV.L @R5+,R0 - M[2]
    code.extend([0x3A, 0x0D])   # DMULS.L R0,R10
    code.extend([0x02, 0x0A])   # STS MACH,R2
    code.extend([0x03, 0x1A])   # STS MACL,R3
    code.extend([0x23, 0x2D])   # XTRCT R2,R3

    code.extend([0x3C, 0x3C])   # ADD R3,R12

    # M[3] * w
    code.extend([0x60, 0x56])   # MOV.L @R5+,R0 - M[3]
    code.extend([0x3B, 0x0D])   # DMULS.L R0,R11
    code.extend([0x02, 0x0A])   # STS MACH,R2
    code.extend([0x03, 0x1A])   # STS MACL,R3
    code.extend([0x23, 0x2D])   # XTRCT R2,R3

    code.extend([0x3C, 0x3C])   # ADD R3,R12

    # Store out.x
    code.extend([0x26, 0xC2])   # MOV.L R12,@R6
    code.extend([0x76, 0x04])   # ADD #4,R6

    # === Transform Y component ===
    code.extend([0x00, 0x28])   # CLRMAC

    code.extend([0x60, 0x56])   # MOV.L @R5+,R0 - M[4]
    code.extend([0x38, 0x0D])   # DMULS.L R0,R8
    code.extend([0x02, 0x0A])   # STS MACH,R2
    code.extend([0x03, 0x1A])   # STS MACL,R3
    code.extend([0x23, 0x2D])   # XTRCT R2,R3
    code.extend([0x6C, 0x33])   # MOV R3,R12

    code.extend([0x60, 0x56])   # MOV.L @R5+,R0 - M[5]
    code.extend([0x39, 0x0D])   # DMULS.L R0,R9
    code.extend([0x02, 0x0A])   # STS MACH,R2
    code.extend([0x03, 0x1A])   # STS MACL,R3
    code.extend([0x23, 0x2D])   # XTRCT R2,R3
    code.extend([0x3C, 0x3C])   # ADD R3,R12

    code.extend([0x60, 0x56])   # MOV.L @R5+,R0 - M[6]
    code.extend([0x3A, 0x0D])   # DMULS.L R0,R10
    code.extend([0x02, 0x0A])   # STS MACH,R2
    code.extend([0x03, 0x1A])   # STS MACL,R3
    code.extend([0x23, 0x2D])   # XTRCT R2,R3
    code.extend([0x3C, 0x3C])   # ADD R3,R12

    code.extend([0x60, 0x56])   # MOV.L @R5+,R0 - M[7]
    code.extend([0x3B, 0x0D])   # DMULS.L R0,R11
    code.extend([0x02, 0x0A])   # STS MACH,R2
    code.extend([0x03, 0x1A])   # STS MACL,R3
    code.extend([0x23, 0x2D])   # XTRCT R2,R3
    code.extend([0x3C, 0x3C])   # ADD R3,R12

    code.extend([0x26, 0xC2])   # MOV.L R12,@R6
    code.extend([0x76, 0x04])   # ADD #4,R6

    # === Transform Z component ===
    code.extend([0x00, 0x28])   # CLRMAC

    code.extend([0x60, 0x56])   # MOV.L @R5+,R0 - M[8]
    code.extend([0x38, 0x0D])   # DMULS.L R0,R8
    code.extend([0x02, 0x0A])   # STS MACH,R2
    code.extend([0x03, 0x1A])   # STS MACL,R3
    code.extend([0x23, 0x2D])   # XTRCT R2,R3
    code.extend([0x6C, 0x33])   # MOV R3,R12

    code.extend([0x60, 0x56])   # MOV.L @R5+,R0 - M[9]
    code.extend([0x39, 0x0D])   # DMULS.L R0,R9
    code.extend([0x02, 0x0A])   # STS MACH,R2
    code.extend([0x03, 0x1A])   # STS MACL,R3
    code.extend([0x23, 0x2D])   # XTRCT R2,R3
    code.extend([0x3C, 0x3C])   # ADD R3,R12

    code.extend([0x60, 0x56])   # MOV.L @R5+,R0 - M[10]
    code.extend([0x3A, 0x0D])   # DMULS.L R0,R10
    code.extend([0x02, 0x0A])   # STS MACH,R2
    code.extend([0x03, 0x1A])   # STS MACL,R3
    code.extend([0x23, 0x2D])   # XTRCT R2,R3
    code.extend([0x3C, 0x3C])   # ADD R3,R12

    code.extend([0x60, 0x56])   # MOV.L @R5+,R0 - M[11]
    code.extend([0x3B, 0x0D])   # DMULS.L R0,R11
    code.extend([0x02, 0x0A])   # STS MACH,R2
    code.extend([0x03, 0x1A])   # STS MACL,R3
    code.extend([0x23, 0x2D])   # XTRCT R2,R3
    code.extend([0x3C, 0x3C])   # ADD R3,R12

    code.extend([0x26, 0xC2])   # MOV.L R12,@R6
    code.extend([0x76, 0x04])   # ADD #4,R6

    # === Transform W component ===
    code.extend([0x00, 0x28])   # CLRMAC

    code.extend([0x60, 0x56])   # MOV.L @R5+,R0 - M[12]
    code.extend([0x38, 0x0D])   # DMULS.L R0,R8
    code.extend([0x02, 0x0A])   # STS MACH,R2
    code.extend([0x03, 0x1A])   # STS MACL,R3
    code.extend([0x23, 0x2D])   # XTRCT R2,R3
    code.extend([0x6C, 0x33])   # MOV R3,R12

    code.extend([0x60, 0x56])   # MOV.L @R5+,R0 - M[13]
    code.extend([0x39, 0x0D])   # DMULS.L R0,R9
    code.extend([0x02, 0x0A])   # STS MACH,R2
    code.extend([0x03, 0x1A])   # STS MACL,R3
    code.extend([0x23, 0x2D])   # XTRCT R2,R3
    code.extend([0x3C, 0x3C])   # ADD R3,R12

    code.extend([0x60, 0x56])   # MOV.L @R5+,R0 - M[14]
    code.extend([0x3A, 0x0D])   # DMULS.L R0,R10
    code.extend([0x02, 0x0A])   # STS MACH,R2
    code.extend([0x03, 0x1A])   # STS MACL,R3
    code.extend([0x23, 0x2D])   # XTRCT R2,R3
    code.extend([0x3C, 0x3C])   # ADD R3,R12

    code.extend([0x60, 0x56])   # MOV.L @R5+,R0 - M[15]
    code.extend([0x3B, 0x0D])   # DMULS.L R0,R11
    code.extend([0x02, 0x0A])   # STS MACH,R2
    code.extend([0x03, 0x1A])   # STS MACL,R3
    code.extend([0x23, 0x2D])   # XTRCT R2,R3
    code.extend([0x3C, 0x3C])   # ADD R3,R12

    code.extend([0x26, 0xC2])   # MOV.L R12,@R6
    code.extend([0x76, 0x04])   # ADD #4,R6

    # Restore matrix pointer for next vertex
    code.extend([0x65, 0xF6])   # MOV.L @R15+,R5 (pop R5)

    # Decrement vertex counter and loop
    code.extend([0x47, 0x10])   # DT R7
    vertex_loop_bf = len(code)
    bf_disp = (vertex_loop_start - (vertex_loop_bf + 4)) // 2
    code.extend([0x8B, bf_disp & 0xFF])  # BF vertex_loop

    # === Write done flag ===
    done_flag_mov = len(code)
    code.extend([0xD0, 0x00])   # MOV.L @(disp,PC),R0 - done flag addr

    done_value_mov = len(code)
    code.extend([0xD1, 0x00])   # MOV.L @(disp,PC),R1 - done value

    code.extend([0x20, 0x12])   # MOV.L R1,@R0

    # === Increment COMM4 ===
    comm4_mov = len(code)
    code.extend([0xD0, 0x00])   # MOV.L @(disp,PC),R0 - COMM4 addr

    code.extend([0x61, 0x02])   # MOV.L @R0,R1
    code.extend([0x71, 0x01])   # ADD #1,R1
    code.extend([0x20, 0x12])   # MOV.L R1,@R0

    # Return
    code.extend([0x00, 0x0B])   # RTS
    code.extend([0x00, 0x09])   # NOP

    # Align to 4 bytes
    while len(code) % 4 != 0:
        code.extend([0x00, 0x09])

    # === Literal pool ===
    input_lit = len(code)
    code.extend(struct.pack('>I', INPUT_VERTICES_ADDR))

    matrix_lit = len(code)
    code.extend(struct.pack('>I', MATRIX_ADDR))

    output_lit = len(code)
    code.extend(struct.pack('>I', OUTPUT_VERTICES_ADDR))

    done_flag_lit = len(code)
    code.extend(struct.pack('>I', DONE_FLAG_ADDR))

    done_value_lit = len(code)
    code.extend(struct.pack('>I', DONE_VALUE))

    comm4_lit = len(code)
    code.extend(struct.pack('>I', COMM4_ADDR))

    # Fix displacements
    def calc_disp(instr_offset, literal_offset):
        pc = handler_addr + instr_offset
        base = (pc & ~3) + 4
        return (handler_addr + literal_offset - base) // 4

    code[input_mov + 1] = calc_disp(input_mov, input_lit)
    code[matrix_mov + 1] = calc_disp(matrix_mov, matrix_lit)
    code[output_mov + 1] = calc_disp(output_mov, output_lit)
    code[done_flag_mov + 1] = calc_disp(done_flag_mov, done_flag_lit)
    code[done_value_mov + 1] = calc_disp(done_value_mov, done_value_lit)
    code[comm4_mov + 1] = calc_disp(comm4_mov, comm4_lit)

    return bytes(code)


def create_phase16_vblank_code(code_start_addr: int) -> bytes:
    """
    Create Master VBlank code that sets up vertex/matrix data and signals Slave.
    """
    code = bytearray()

    # VBlank poll
    vdp_mov = len(code)
    code.extend([0xD1, 0x00])

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

    # === Write input vertices (4 × 4 longwords = 16 writes) ===
    input_addr_mov = len(code)
    code.extend([0xD2, 0x00])  # R2 = input addr

    vertex_val_movs = []
    for v in INPUT_VERTICES:
        for component in v:
            vertex_val_movs.append((len(code), component))
            code.extend([0xD0, 0x00])  # MOV.L value
            code.extend([0x22, 0x02])  # MOV.L R0,@R2
            code.extend([0x72, 0x04])  # ADD #4,R2

    # === Write identity matrix (16 longwords) ===
    matrix_addr_mov = len(code)
    code.extend([0xD2, 0x00])  # R2 = matrix addr

    matrix_val_movs = []
    for val in IDENTITY_MATRIX:
        matrix_val_movs.append((len(code), val))
        code.extend([0xD0, 0x00])
        code.extend([0x22, 0x02])
        code.extend([0x72, 0x04])

    # === Clear done flag ===
    done_addr_mov = len(code)
    code.extend([0xD2, 0x00])  # R2 = done flag addr
    code.extend([0xE0, 0x00])  # MOV #0,R0
    code.extend([0x22, 0x02])  # MOV.L R0,@R2

    # === Signal Slave ===
    comm6_mov = len(code)
    code.extend([0xD0, 0x00])
    code.extend([0xE1, 0x12])  # MOV #$12,R1
    code.extend([0x20, 0x12])  # MOV.W R1,@R0

    # Restore
    code.extend([0x63, 0xF6])
    code.extend([0x62, 0xF6])
    code.extend([0x60, 0xF6])

    code.extend([0x00, 0x0B])  # RTS
    code.extend([0x00, 0x09])  # NOP

    # Align
    while len(code) % 4 != 0:
        code.extend([0x00, 0x09])

    # === Literal pool ===
    vdp_lit = len(code)
    code.extend(struct.pack('>I', 0x20004100))

    counter_lit = len(code)
    code.extend(struct.pack('>I', 0x22000100))

    input_addr_lit = len(code)
    code.extend(struct.pack('>I', INPUT_VERTICES_ADDR))

    vertex_val_lits = []
    for _, val in vertex_val_movs:
        vertex_val_lits.append(len(code))
        code.extend(struct.pack('>I', val))

    matrix_addr_lit = len(code)
    code.extend(struct.pack('>I', MATRIX_ADDR))

    matrix_val_lits = []
    for _, val in matrix_val_movs:
        matrix_val_lits.append(len(code))
        code.extend(struct.pack('>I', val))

    done_addr_lit = len(code)
    code.extend(struct.pack('>I', DONE_FLAG_ADDR))

    comm6_lit = len(code)
    code.extend(struct.pack('>I', COMM6_ADDR))

    # Fix displacements
    def calc_disp(instr_offset, literal_offset):
        pc = code_start_addr + instr_offset
        base = (pc & ~3) + 4
        return (code_start_addr + literal_offset - base) // 4

    code[vdp_mov + 1] = calc_disp(vdp_mov, vdp_lit)
    code[counter_mov + 1] = calc_disp(counter_mov, counter_lit)
    code[input_addr_mov + 1] = calc_disp(input_addr_mov, input_addr_lit)

    for i, (mov_offset, _) in enumerate(vertex_val_movs):
        code[mov_offset + 1] = calc_disp(mov_offset, vertex_val_lits[i])

    code[matrix_addr_mov + 1] = calc_disp(matrix_addr_mov, matrix_addr_lit)

    for i, (mov_offset, _) in enumerate(matrix_val_movs):
        code[mov_offset + 1] = calc_disp(mov_offset, matrix_val_lits[i])

    code[done_addr_mov + 1] = calc_disp(done_addr_mov, done_addr_lit)
    code[comm6_mov + 1] = calc_disp(comm6_mov, comm6_lit)

    return bytes(code)


def inject_phase16(input_rom: str, output_rom: str) -> bool:
    """Inject Phase 16 multi-vertex transform test."""

    print("=" * 70)
    print("PHASE 16: MULTI-VERTEX TRANSFORM WITH STAGING")
    print("=" * 70)
    print()

    rom_path = Path(input_rom)
    if not rom_path.exists():
        print(f"ROM not found: {input_rom}")
        return False

    rom_data = bytearray(rom_path.read_bytes())
    print(f"ROM loaded: {len(rom_data):,} bytes")
    print()

    # === Inject Slave handler ===
    handler_offset = 0x300027
    handler_addr = 0x02300027

    new_handler = create_vertex_transform_handler(handler_addr)
    print(f"Slave handler size: {len(new_handler)} bytes")

    if len(new_handler) > 512:
        print(f"WARNING: Handler too large ({len(new_handler)} > 512 bytes)")
        print("         May overflow into VBlank code area!")

    rom_data[handler_offset:handler_offset + len(new_handler)] = new_handler
    print(f"Injected handler at ROM 0x{handler_offset:06X}")
    print()

    # === Inject VBlank code ===
    # Place VBlank code after handler with padding
    vblank_offset = 0x300200  # Safe distance from handler
    vblank_addr = 0x02300200

    vblank_code = create_phase16_vblank_code(vblank_addr)
    print(f"VBlank code size: {len(vblank_code)} bytes")

    rom_data[vblank_offset:vblank_offset + len(vblank_code)] = vblank_code
    print(f"Injected VBlank at ROM 0x{vblank_offset:06X}")
    print()

    # === Update VBlank redirect ===
    # The original VBlank function at 0x243E0 was redirected to 0x300040
    # We need to redirect it to our new location 0x300200
    vblank_func = 0x243E0
    new_redirect = bytearray()
    new_redirect.extend([0xD1, 0x01])  # MOV.L @(4,PC),R1
    new_redirect.extend([0x41, 0x2B])  # JMP @R1
    new_redirect.extend([0x00, 0x09])  # NOP
    new_redirect.extend([0x00, 0x09])  # NOP
    new_redirect.extend(struct.pack('>I', vblank_addr))

    rom_data[vblank_func:vblank_func + len(new_redirect)] = new_redirect
    print(f"Updated VBlank redirect at ROM 0x{vblank_func:06X} → 0x{vblank_addr:08X}")
    print()

    # Write output
    Path(output_rom).write_bytes(rom_data)
    print(f"Output: {output_rom}")
    print()

    # === Summary ===
    print("=" * 70)
    print("MEMORY LAYOUT (Cache-Through)")
    print("=" * 70)
    print()
    print(f"Input vertices:  0x{INPUT_VERTICES_ADDR:08X} - 0x{INPUT_VERTICES_ADDR+63:08X} (64 bytes)")
    print(f"Matrix:          0x{MATRIX_ADDR:08X} - 0x{MATRIX_ADDR+63:08X} (64 bytes)")
    print(f"Output vertices: 0x{OUTPUT_VERTICES_ADDR:08X} - 0x{OUTPUT_VERTICES_ADDR+63:08X} (64 bytes)")
    print(f"Done flag:       0x{DONE_FLAG_ADDR:08X}")
    print()

    print("INPUT VERTICES:")
    for i, v in enumerate(INPUT_VERTICES):
        print(f"  V{i}: ({v[0]/65536:.1f}, {v[1]/65536:.1f}, {v[2]/65536:.1f}, 0x{v[3]:08X})")
    print()

    print("MATRIX: Identity (output should equal input)")
    print()

    print("=" * 70)
    print("VALIDATION CRITERIA")
    print("=" * 70)
    print()
    print("1. ROM boots without crash")
    print("2. COMM4 (0x20004028) increments each frame")
    print(f"3. Done flag (0x{DONE_FLAG_ADDR:08X}) = 0x{DONE_VALUE:08X}")
    print(f"4. Signature in output V3.w (0x{OUTPUT_VERTICES_ADDR+0x3C:08X}) = 0x{SIGNATURE:08X}")
    print("5. Output vertices match input (identity transform)")
    print()

    return True


def main():
    if len(sys.argv) != 3:
        print("Usage: python3 inject_phase16_vertex_test.py <input.32x> <output.32x>")
        print()
        print("Example:")
        print("  python3 inject_phase16_vertex_test.py build/vr_baseline_probe.32x build/vr_phase16.32x")
        sys.exit(1)

    success = inject_phase16(sys.argv[1], sys.argv[2])
    sys.exit(0 if success else 1)


if __name__ == '__main__':
    main()
