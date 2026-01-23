#!/usr/bin/env python3
"""
Phase 17.2: Master-Only Cycle Measurement (Comparison Baseline)

Runs the SAME 4-vertex transform on Master CPU for direct comparison with Phase 17.1 Slave.

Purpose:
- Validate cycle measurement code works correctly
- Establish baseline: Master vs Slave performance should be identical
- Verify wraparound-safe delta calculation

Key Differences from Phase 17.1:
- Runs on MASTER CPU (not Slave)
- Triggered at VBlank (not via COMM6 signal)
- No COMM4 increment (no Master/Slave coordination)
- Results stored at 0x22000320+ (separate from Slave results)

Memory Layout:
    Slave Results (from Phase 17.1):
        0x22000300: Slave cycle count
        0x22000304: Slave FRT start
        0x22000308: Slave FRT end
        0x2200030C: Slave wrap flag

    Master Results (NEW):
        0x22000320: Master cycle count
        0x22000324: Master FRT start
        0x22000328: Master FRT end
        0x2200032C: Master wrap flag

    Shared Input/Output (same as Phase 17.1):
        0x22000200: Input vertices (4 × 16 bytes)
        0x22000240: Identity matrix (64 bytes)
        0x22000280: Output vertices (4 × 16 bytes)
        0x220002FC: Done flag

Expected Results:
- Master and Slave cycle counts should be nearly identical
- Difference should be < 10 cycles (measurement noise)

Usage:
    python3 tools/inject_phase17_2_master_comparison.py build/vr_baseline_probe.32x build/vr_phase17_2.32x
"""

import sys
import struct
from pathlib import Path

# Memory addresses (shared with Phase 17.1)
INPUT_VERTICES_ADDR = 0x22000200
MATRIX_ADDR = 0x22000240
OUTPUT_VERTICES_ADDR = 0x22000280
DONE_FLAG_ADDR = 0x220002FC

# Master result addresses (NEW - separate from Slave)
MASTER_CYCLE_COUNT_ADDR = 0x22000320
MASTER_FRT_START_ADDR = 0x22000324
MASTER_FRT_END_ADDR = 0x22000328
MASTER_WRAP_FLAG_ADDR = 0x2200032C

# Slave result addresses (from Phase 17.1 - for reference)
SLAVE_CYCLE_COUNT_ADDR = 0x22000300
SLAVE_FRT_START_ADDR = 0x22000304
SLAVE_FRT_END_ADDR = 0x22000308
SLAVE_WRAP_FLAG_ADDR = 0x2200030C

# Hardware
FRC_ADDR = 0xFFFFFE12  # Free Running Counter (16-bit)

# Test data
SIGNATURE = 0xCAFE1234
DONE_VALUE = 0x00010001

def to_fixed(f): return int(f * 65536) & 0xFFFFFFFF

INPUT_VERTICES = [
    [to_fixed(1.0), to_fixed(0.0), to_fixed(0.0), to_fixed(1.0)],
    [to_fixed(0.0), to_fixed(1.0), to_fixed(0.0), to_fixed(1.0)],
    [to_fixed(0.0), to_fixed(0.0), to_fixed(1.0), to_fixed(1.0)],
    [to_fixed(1.0), to_fixed(1.0), to_fixed(1.0), SIGNATURE],
]

IDENTITY_MATRIX = [
    to_fixed(1.0), to_fixed(0.0), to_fixed(0.0), to_fixed(0.0),
    to_fixed(0.0), to_fixed(1.0), to_fixed(0.0), to_fixed(0.0),
    to_fixed(0.0), to_fixed(0.0), to_fixed(1.0), to_fixed(0.0),
    to_fixed(0.0), to_fixed(0.0), to_fixed(0.0), to_fixed(1.0),
]


def create_master_comparison_handler(handler_addr: int) -> bytes:
    """
    Create Master-only handler with wraparound-safe cycle measurement.

    This is IDENTICAL to Phase 17.1 Slave handler, except:
    - No COMM4 increment
    - Stores results at 0x22000320+ instead of 0x22000300+
    """
    code = bytearray()

    # === READ FRT START ===
    frc_start_mov = len(code)
    code.extend([0xD0, 0x00])   # MOV.L @(disp,PC),R0 - FRC address
    code.extend([0x90, 0x02])   # MOV.W @R0,R0 - read FRC (16-bit)
    code.extend([0x60, 0x0F])   # EXTU.W R0,R0 - zero extend to 32-bit

    code.extend([0x6D, 0x03])   # MOV R0,R13 - R13 = FRT_start

    frt_start_stor_mov = len(code)
    code.extend([0xD1, 0x00])   # MOV.L @(disp,PC),R1
    code.extend([0x20, 0xD2])   # MOV.L R13,@R1

    # === TRANSFORM CODE ===
    input_mov = len(code)
    code.extend([0xD4, 0x00])   # MOV.L @(disp,PC),R4

    matrix_mov = len(code)
    code.extend([0xD5, 0x00])   # MOV.L @(disp,PC),R5

    output_mov = len(code)
    code.extend([0xD6, 0x00])   # MOV.L @(disp,PC),R6

    # R2 = row counter (4 vertices)
    code.extend([0xE2, 0x04])   # MOV #4,R2

    # === VERTEX LOOP START ===
    vertex_loop_start = len(code)

    # R3 = component counter (4 components: x,y,z,w)
    code.extend([0xE3, 0x04])   # MOV #4,R3

    # === COMPONENT LOOP START ===
    component_loop_start = len(code)

    # R7 = accumulator = 0
    code.extend([0xE7, 0x00])   # MOV #0,R7

    # R1 = component counter (4 matrix elements per component)
    code.extend([0xE1, 0x04])   # MOV #4,R1

    # === DOT PRODUCT LOOP START ===
    dot_loop_start = len(code)

    # Load matrix element: R8 = *R5++
    code.extend([0x65, 0x82])   # MOV.L @R5+,R8

    # Load vertex component: R9 = *R4++
    code.extend([0x64, 0x92])   # MOV.L @R4+,R9

    # DMULS.L R8,R9 -> MACH:MACL (64-bit result)
    code.extend([0x39, 0x8D])   # DMULS.L R8,R9

    # STS MACH,R10
    code.extend([0x00, 0x1A])   # STS MACH,R10

    # STS MACL,R11
    code.extend([0x00, 0x2A])   # STS MACL,R11

    # XTRCT R10,R11 -> extract middle 32 bits (16.16 fixed-point result)
    code.extend([0x2A, 0xBD])   # XTRCT R10,R11

    # R7 += R11 (accumulate)
    code.extend([0x3B, 0x7C])   # ADD R11,R7

    # Loop: DT R1; BF dot_loop
    code.extend([0x41, 0x10])   # DT R1
    offset = dot_loop_start - (len(code) + 2)
    code.extend([0x8B, offset & 0xFF])  # BF dot_loop

    # === DOT PRODUCT LOOP END ===

    # Store result: *R6++ = R7
    code.extend([0x26, 0x72])   # MOV.L R7,@R6+

    # Reset R4 back 16 bytes (reuse vertex for next component)
    code.extend([0x74, 0xF0])   # ADD #-16,R4

    # Advance R5 to next row (already advanced by loop)

    # Loop: DT R3; BF component_loop
    code.extend([0x43, 0x10])   # DT R3
    offset = component_loop_start - (len(code) + 2)
    code.extend([0x8B, offset & 0xFF])  # BF component_loop

    # === COMPONENT LOOP END ===

    # Advance R4 to next vertex (+16 bytes)
    code.extend([0x74, 0x10])   # ADD #16,R4

    # Reset R5 back to matrix start
    code.extend([0x75, 0xC0])   # ADD #-64,R5

    # Loop: DT R2; BF vertex_loop
    code.extend([0x42, 0x10])   # DT R2
    offset = vertex_loop_start - (len(code) + 2)
    code.extend([0x8B, offset & 0xFF])  # BF vertex_loop

    # === VERTEX LOOP END ===

    # === READ FRT END ===
    frc_end_mov = len(code)
    code.extend([0xD0, 0x00])   # MOV.L @(disp,PC),R0 - FRC address
    code.extend([0x90, 0x02])   # MOV.W @R0,R0
    code.extend([0x60, 0x0F])   # EXTU.W R0,R0

    code.extend([0x6E, 0x03])   # MOV R0,R14 - R14 = FRT_end

    frt_end_stor_mov = len(code)
    code.extend([0xD1, 0x00])   # MOV.L @(disp,PC),R1
    code.extend([0x20, 0xE2])   # MOV.L R14,@R1

    # === WRAPAROUND DETECTION ===
    # if (FRT_end < FRT_start) then wrapped
    # R13 = FRT_start, R14 = FRT_end

    code.extend([0x3D, 0xE7])   # CMP/GT R13,R14 - sets T if R14 > R13
    bt_no_wrap_offset = len(code)
    code.extend([0x89, 0x00])   # BT no_wrap (placeholder offset)

    # === WRAP PATH ===
    # delta = (0x10000 + FRT_end) - FRT_start
    code.extend([0xE0, 0x01])   # MOV #1,R0
    code.extend([0x40, 0x28])   # SHLL16 R0 - R0 = 0x10000
    code.extend([0x30, 0xEC])   # ADD R14,R0 - R0 = 0x10000 + FRT_end
    code.extend([0x3D, 0x08])   # SUB R13,R0 - R0 = delta

    # Store wrap flag = 1
    wrap_flag_mov = len(code)
    code.extend([0xD1, 0x00])   # MOV.L @(disp,PC),R1 - wrap flag addr
    code.extend([0xE2, 0x01])   # MOV #1,R2
    code.extend([0x21, 0x22])   # MOV.L R2,@R1

    bra_end_offset = len(code)
    code.extend([0xA0, 0x00])   # BRA end_wrap (placeholder offset)
    code.extend([0x00, 0x09])   # NOP (delay slot)

    # === NO WRAP PATH ===
    no_wrap_start = len(code)
    # Patch BT offset
    code[bt_no_wrap_offset + 1] = (no_wrap_start - (bt_no_wrap_offset + 2)) & 0xFF

    # delta = FRT_end - FRT_start
    code.extend([0x6E, 0x03])   # MOV R14,R0 - R0 = FRT_end
    code.extend([0x3D, 0x08])   # SUB R13,R0 - R0 = delta

    # Store wrap flag = 0
    wrap_flag_no_wrap_mov = len(code)
    code.extend([0xD1, 0x00])   # MOV.L @(disp,PC),R1
    code.extend([0xE2, 0x00])   # MOV #0,R2
    code.extend([0x21, 0x22])   # MOV.L R2,@R1

    # === END WRAP ===
    end_wrap = len(code)
    # Patch BRA offset
    code[bra_end_offset + 1] = (end_wrap - (bra_end_offset + 2)) & 0xFF

    # === CONVERT DELTA TO CYCLES ===
    # R0 = delta (in FRT ticks)
    # cycles = delta × 8

    code.extend([0x40, 0x00])   # SHLL R0
    code.extend([0x40, 0x00])   # SHLL R0
    code.extend([0x40, 0x00])   # SHLL R0
    # R0 now contains cycles

    # Store cycle count
    cycle_count_mov = len(code)
    code.extend([0xD1, 0x00])   # MOV.L @(disp,PC),R1
    code.extend([0x20, 0x02])   # MOV.L R0,@R1

    # === SET DONE FLAG ===
    done_flag_mov = len(code)
    code.extend([0xD1, 0x00])   # MOV.L @(disp,PC),R1
    done_val_mov = len(code)
    code.extend([0xD0, 0x00])   # MOV.L @(disp,PC),R0
    code.extend([0x20, 0x02])   # MOV.L R0,@R1

    # === RTS ===
    code.extend([0x00, 0x0B])   # RTS
    code.extend([0x00, 0x09])   # NOP (delay slot)

    # === LITERAL POOL ===
    # Align to 4 bytes
    while len(code) % 4 != 0:
        code.extend([0x00, 0x09])  # NOP

    # Patch PC-relative offsets
    def patch_literal(mov_offset, value):
        lit_pool_offset = len(code)
        code.extend(struct.pack('>I', value))
        disp = (lit_pool_offset - (mov_offset + 4)) // 4
        if disp > 255:
            raise ValueError(f"Literal pool too far: disp={disp}")
        code[mov_offset + 1] = disp

    patch_literal(frc_start_mov, FRC_ADDR)
    patch_literal(frt_start_stor_mov, MASTER_FRT_START_ADDR)
    patch_literal(input_mov, INPUT_VERTICES_ADDR)
    patch_literal(matrix_mov, MATRIX_ADDR)
    patch_literal(output_mov, OUTPUT_VERTICES_ADDR)
    patch_literal(frc_end_mov, FRC_ADDR)
    patch_literal(frt_end_stor_mov, MASTER_FRT_END_ADDR)
    patch_literal(wrap_flag_mov, MASTER_WRAP_FLAG_ADDR)
    patch_literal(wrap_flag_no_wrap_mov, MASTER_WRAP_FLAG_ADDR)
    patch_literal(cycle_count_mov, MASTER_CYCLE_COUNT_ADDR)
    patch_literal(done_flag_mov, DONE_FLAG_ADDR)
    patch_literal(done_val_mov, DONE_VALUE)

    return bytes(code)


def create_vblank_hook(vblank_addr: int, handler_addr: int) -> bytes:
    """
    Create VBlank hook that calls Master comparison handler.

    Triggered at VBlank boundary (once per frame).
    """
    code = bytearray()

    # Call handler
    handler_call_mov = len(code)
    code.extend([0xD1, 0x00])   # MOV.L @(disp,PC),R1 - handler addr
    code.extend([0x41, 0x0B])   # JSR @R1
    code.extend([0x00, 0x09])   # NOP (delay slot)

    # RTS
    code.extend([0x00, 0x0B])   # RTS
    code.extend([0x00, 0x09])   # NOP (delay slot)

    # Align to 4 bytes
    while len(code) % 4 != 0:
        code.extend([0x00, 0x09])  # NOP

    # Literal pool
    lit_pool_offset = len(code)
    code.extend(struct.pack('>I', handler_addr))
    disp = (lit_pool_offset - (handler_call_mov + 4)) // 4
    if disp > 255:
        raise ValueError(f"Literal pool too far: disp={disp}")
    code[handler_call_mov + 1] = disp

    return bytes(code)


def inject_master_comparison(input_rom: Path, output_rom: Path):
    """Main injection routine."""

    # Read ROM
    rom_data = bytearray(input_rom.read_bytes())

    # === INJECT TEST DATA ===
    # Input vertices
    offset = INPUT_VERTICES_ADDR - 0x02000000
    for vertex in INPUT_VERTICES:
        for component in vertex:
            rom_data[offset:offset+4] = struct.pack('>I', component)
            offset += 4

    # Identity matrix
    offset = MATRIX_ADDR - 0x02000000
    for element in IDENTITY_MATRIX:
        rom_data[offset:offset+4] = struct.pack('>I', element)
        offset += 4

    # Clear output area
    offset = OUTPUT_VERTICES_ADDR - 0x02000000
    rom_data[offset:offset+64] = b'\x00' * 64

    # Clear result areas
    offset = MASTER_CYCLE_COUNT_ADDR - 0x02000000
    rom_data[offset:offset+16] = b'\x00' * 16  # Master results
    offset = SLAVE_CYCLE_COUNT_ADDR - 0x02000000
    rom_data[offset:offset+16] = b'\x00' * 16  # Slave results (from Phase 17.1)

    # Clear done flag
    offset = DONE_FLAG_ADDR - 0x02000000
    rom_data[offset:offset+4] = b'\x00' * 4

    # === INJECT HANDLER ===
    HANDLER_ADDR = 0x02300000  # Expansion space
    handler_code = create_master_comparison_handler(HANDLER_ADDR)
    offset = HANDLER_ADDR - 0x02000000
    rom_data[offset:offset+len(handler_code)] = handler_code

    print(f"Handler injected at 0x{HANDLER_ADDR:08X} ({len(handler_code)} bytes)")

    # === INJECT VBLANK HOOK ===
    VBLANK_ADDR = 0x02300200
    vblank_code = create_vblank_hook(VBLANK_ADDR, HANDLER_ADDR)
    offset = VBLANK_ADDR - 0x02000000
    rom_data[offset:offset+len(vblank_code)] = vblank_code

    print(f"VBlank hook injected at 0x{VBLANK_ADDR:08X} ({len(vblank_code)} bytes)")

    # === REDIRECT VBLANK ENTRY ===
    VBLANK_ENTRY = 0x020243E0
    offset = VBLANK_ENTRY - 0x02000000

    redirect = bytearray()
    redirect.extend([0xD1, 0x01])  # MOV.L @(disp,PC),R1
    redirect.extend([0x41, 0x2B])  # JMP @R1
    redirect.extend([0x00, 0x09])  # NOP (delay slot)
    redirect.extend([0x00, 0x09])  # NOP (alignment)
    redirect.extend(struct.pack('>I', VBLANK_ADDR))

    rom_data[offset:offset+len(redirect)] = redirect
    print(f"Updated VBlank redirect at 0x{VBLANK_ENTRY:08X}")

    # Write output
    output_rom.write_bytes(rom_data)
    print(f"\nOutput: {output_rom}")
    print(f"\nMemory Map:")
    print(f"  Input vertices:     0x{INPUT_VERTICES_ADDR:08X}")
    print(f"  Matrix:             0x{MATRIX_ADDR:08X}")
    print(f"  Output vertices:    0x{OUTPUT_VERTICES_ADDR:08X}")
    print(f"  Done flag:          0x{DONE_FLAG_ADDR:08X}")
    print(f"\n  Master cycle count: 0x{MASTER_CYCLE_COUNT_ADDR:08X}")
    print(f"  Master FRT start:   0x{MASTER_FRT_START_ADDR:08X}")
    print(f"  Master FRT end:     0x{MASTER_FRT_END_ADDR:08X}")
    print(f"  Master wrap flag:   0x{MASTER_WRAP_FLAG_ADDR:08X}")
    print(f"\n  Slave cycle count:  0x{SLAVE_CYCLE_COUNT_ADDR:08X} (from Phase 17.1)")
    print(f"  Slave FRT start:    0x{SLAVE_FRT_START_ADDR:08X} (from Phase 17.1)")
    print(f"  Slave FRT end:      0x{SLAVE_FRT_END_ADDR:08X} (from Phase 17.1)")
    print(f"  Slave wrap flag:    0x{SLAVE_WRAP_FLAG_ADDR:08X} (from Phase 17.1)")
    print(f"\nExpected: Master and Slave cycle counts should match within ~10 cycles")


if __name__ == '__main__':
    if len(sys.argv) != 3:
        print("Usage: inject_phase17_2_master_comparison.py <input_rom> <output_rom>")
        sys.exit(1)

    inject_master_comparison(Path(sys.argv[1]), Path(sys.argv[2]))
