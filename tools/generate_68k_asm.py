#!/usr/bin/env python3
"""
Generate 68K assembly source from ROM binary.

This tool extracts sections of the ROM and generates vasm-compatible assembly.
It supports both code disassembly and raw data output.
"""

import struct
from pathlib import Path
from typing import List, Tuple, Dict

ROM_PATH = "Virtua Racing Deluxe (USA).32x"

# MC68000 instruction decoding (simplified)
# Format: opcode_mask, opcode_match, mnemonic, size, format_func

def decode_instruction(data: bytes, offset: int) -> Tuple[str, int, str]:
    """
    Decode a single MC68000 instruction.
    Returns: (assembly_string, instruction_size, comment)
    """
    if len(data) < 2:
        return f"dc.b    ${data[0]:02X}", 1, ""

    word = struct.unpack('>H', data[0:2])[0]

    # Common instructions
    # JMP absolute long
    if word == 0x4EF9 and len(data) >= 6:
        addr = struct.unpack('>I', data[2:6])[0]
        return f"JMP     ${addr:08X}", 6, ""

    # JSR absolute long
    if word == 0x4EB9 and len(data) >= 6:
        addr = struct.unpack('>I', data[2:6])[0]
        return f"JSR     ${addr:08X}", 6, ""

    # LEA absolute long, An
    if (word & 0xF1FF) == 0x41F9 and len(data) >= 6:
        reg = (word >> 9) & 7
        addr = struct.unpack('>I', data[2:6])[0]
        return f"LEA     ${addr:08X},A{reg}", 6, ""

    # MOVEA.L #imm, An
    if (word & 0xF1FF) == 0x207C and len(data) >= 6:
        reg = (word >> 9) & 7
        val = struct.unpack('>I', data[2:6])[0]
        return f"MOVEA.L #${val:08X},A{reg}", 6, ""

    # MOVE.L #imm, absolute long
    if word == 0x23FC and len(data) >= 10:
        val = struct.unpack('>I', data[2:6])[0]
        addr = struct.unpack('>I', data[6:10])[0]
        return f"MOVE.L  #${val:08X},${addr:08X}", 10, ""

    # MOVE.W #imm, SR
    if word == 0x46FC and len(data) >= 4:
        val = struct.unpack('>H', data[2:4])[0]
        return f"MOVE.W  #${val:04X},SR", 4, ""

    # MOVEQ #imm, Dn
    if (word & 0xF100) == 0x7000:
        reg = (word >> 9) & 7
        val = word & 0xFF
        if val > 127:
            val = val - 256
        return f"MOVEQ   #${val & 0xFF:02X},D{reg}", 2, f"; {val}"

    # NOP
    if word == 0x4E71:
        return "NOP", 2, ""

    # RTS
    if word == 0x4E75:
        return "RTS", 2, ""

    # RTE
    if word == 0x4E73:
        return "RTE", 2, ""

    # BRA.S (short)
    if (word & 0xFF00) == 0x6000 and (word & 0xFF) != 0:
        disp = word & 0xFF
        if disp > 127:
            disp = disp - 256
        target = offset + 2 + disp
        return f"BRA.S   ${target + 0x880000:08X}", 2, ""

    # BRA.W (word)
    if word == 0x6000 and len(data) >= 4:
        disp = struct.unpack('>h', data[2:4])[0]
        target = offset + 2 + disp
        return f"BRA.W   ${target + 0x880000:08X}", 4, ""

    # BEQ.S (short)
    if (word & 0xFF00) == 0x6700 and (word & 0xFF) != 0:
        disp = word & 0xFF
        if disp > 127:
            disp = disp - 256
        target = offset + 2 + disp
        return f"BEQ.S   ${target + 0x880000:08X}", 2, ""

    # BNE.S (short)
    if (word & 0xFF00) == 0x6600 and (word & 0xFF) != 0:
        disp = word & 0xFF
        if disp > 127:
            disp = disp - 256
        target = offset + 2 + disp
        return f"BNE.S   ${target + 0x880000:08X}", 2, ""

    # BEQ.W (word)
    if word == 0x6700 and len(data) >= 4:
        disp = struct.unpack('>h', data[2:4])[0]
        target = offset + 2 + disp
        return f"BEQ.W   ${target + 0x880000:08X}", 4, ""

    # BNE.W (word)
    if word == 0x6600 and len(data) >= 4:
        disp = struct.unpack('>h', data[2:4])[0]
        target = offset + 2 + disp
        return f"BNE.W   ${target + 0x880000:08X}", 4, ""

    # BSR.W (word)
    if word == 0x6100 and len(data) >= 4:
        disp = struct.unpack('>h', data[2:4])[0]
        target = offset + 2 + disp
        return f"BSR.W   ${target + 0x880000:08X}", 4, ""

    # BTST #bit, d(An)
    if (word & 0xFFF8) == 0x0828 and len(data) >= 6:
        reg = word & 7
        bit = struct.unpack('>H', data[2:4])[0]
        disp = struct.unpack('>h', data[4:6])[0]
        return f"BTST    #{bit},${disp:04X}(A{reg})", 6, ""

    # CMPI.L #imm, d(An)
    if (word & 0xFFF8) == 0x0CA8 and len(data) >= 10:
        reg = word & 7
        val = struct.unpack('>I', data[2:6])[0]
        disp = struct.unpack('>h', data[6:8])[0]
        return f"CMPI.L  #${val:08X},${disp:04X}(A{reg})", 8, ""

    # MOVE.B d(An), Dn
    if (word & 0xF1F8) == 0x102D and len(data) >= 4:
        dreg = (word >> 9) & 7
        areg = word & 7
        disp = struct.unpack('>h', data[2:4])[0]
        return f"MOVE.B  ${disp:04X}(A{areg}),D{dreg}", 4, ""

    # ANDI.B #imm, Dn
    if (word & 0xFFF8) == 0x0200 and len(data) >= 4:
        reg = word & 7
        val = struct.unpack('>H', data[2:4])[0] & 0xFF
        return f"ANDI.B  #${val:02X},D{reg}", 4, ""

    # TST.L d(An)
    if (word & 0xFFF8) == 0x4AA8 and len(data) >= 4:
        reg = word & 7
        disp = struct.unpack('>h', data[2:4])[0]
        return f"TST.L   ${disp:04X}(A{reg})", 4, ""

    # TST.W d(An)
    if (word & 0xFFF8) == 0x4A68 and len(data) >= 4:
        reg = word & 7
        disp = struct.unpack('>h', data[2:4])[0]
        return f"TST.W   ${disp:04X}(A{reg})", 4, ""

    # MOVE.L (An)+, (A1)+
    if word == 0x22D8:
        return "MOVE.L  (A0)+,(A1)+", 2, ""

    # MOVE.W Dn, d(An)
    if (word & 0xF1F8) == 0x3B40 and len(data) >= 4:
        dreg = word & 7
        areg = (word >> 9) & 7
        disp = struct.unpack('>H', data[2:4])[0]
        return f"MOVE.W  D{dreg},${disp:04X}(A{areg})", 4, ""

    # MOVE.W #imm, d(An)
    if (word & 0xF1FF) == 0x317C and len(data) >= 6:
        areg = (word >> 9) & 7
        val = struct.unpack('>H', data[2:4])[0]
        disp = struct.unpack('>h', data[4:6])[0]
        return f"MOVE.W  #${val:04X},${disp:04X}(A{areg})", 6, ""

    # DBRA Dn, disp
    if (word & 0xFFF8) == 0x51C8 and len(data) >= 4:
        reg = word & 7
        disp = struct.unpack('>h', data[2:4])[0]
        target = offset + 2 + disp
        return f"DBRA    D{reg},${target + 0x880000:08X}", 4, ""

    # MOVE.B (An)+, (An)+
    if word == 0x12DB:
        return "MOVE.B  (A3)+,(A1)+", 2, ""

    # MOVE.B (An)+, (An)
    if word == 0x149B:
        return "MOVE.B  (A3)+,(A2)", 2, ""

    # JMP (An)
    if (word & 0xFFF8) == 0x4ED0:
        reg = word & 7
        return f"JMP     (A{reg})", 2, ""

    # MOVEA.L Dn, An
    if (word & 0xF1FF) == 0x2041:
        dreg = word & 7
        areg = (word >> 9) & 7
        return f"MOVEA.L D{dreg},A{areg}", 2, ""

    # MOVEM.L regs, -(SP)
    if word == 0x48E7 and len(data) >= 4:
        mask = struct.unpack('>H', data[2:4])[0]
        regs = format_movem_mask(mask, True)
        return f"MOVEM.L {regs},-(SP)", 4, ""

    # MOVEM.L (SP)+, regs
    if word == 0x4CDF and len(data) >= 4:
        mask = struct.unpack('>H', data[2:4])[0]
        regs = format_movem_mask(mask, False)
        return f"MOVEM.L (SP)+,{regs}", 4, ""

    # Default: output as dc.w
    return f"dc.w    ${word:04X}", 2, "; Unknown opcode"


def format_movem_mask(mask: int, predecrement: bool) -> str:
    """Format MOVEM register mask."""
    regs = []
    if predecrement:
        # For -(An), bit 15=D0, bit 8=D7, bit 7=A0, bit 0=A7
        for i in range(8):
            if mask & (1 << (15 - i)):
                regs.append(f"D{i}")
        for i in range(8):
            if mask & (1 << (7 - i)):
                regs.append(f"A{i}")
    else:
        # For (An)+, bit 0=D0, bit 7=D7, bit 8=A0, bit 15=A7
        for i in range(8):
            if mask & (1 << i):
                regs.append(f"D{i}")
        for i in range(8):
            if mask & (1 << (8 + i)):
                regs.append(f"A{i}")
    return "/".join(regs) if regs else "?"


def extract_as_code(rom_data: bytes, start: int, end: int, label: str = None) -> List[str]:
    """Extract a section as disassembled code."""
    lines = []
    if label:
        lines.append(f"{label}:")

    offset = start
    while offset < end:
        remaining = rom_data[offset:end]
        asm, size, comment = decode_instruction(remaining, offset)
        cpu_addr = offset + 0x880000
        if comment:
            lines.append(f"        {asm:40s} {comment}")
        else:
            lines.append(f"        {asm}")
        offset += size

    return lines


def extract_as_data(rom_data: bytes, start: int, end: int, label: str = None,
                    width: int = 16) -> List[str]:
    """Extract a section as raw data bytes."""
    lines = []
    if label:
        lines.append(f"{label}:")

    offset = start
    while offset < end:
        chunk = rom_data[offset:min(offset + width, end)]
        hex_str = ", ".join(f"${b:02X}" for b in chunk)
        lines.append(f"        dc.b    {hex_str}")
        offset += len(chunk)

    return lines


def extract_as_ascii(rom_data: bytes, start: int, end: int, label: str = None) -> List[str]:
    """Extract a section as ASCII string."""
    lines = []
    if label:
        lines.append(f"{label}:")

    data = rom_data[start:end]
    # Split by null terminators or at reasonable lengths
    current = ""
    for b in data:
        if b == 0:
            if current:
                lines.append(f'        dc.b    "{current}", $00')
                current = ""
        elif 32 <= b <= 126:
            current += chr(b)
            if len(current) >= 60:
                lines.append(f'        dc.b    "{current}"')
                current = ""
        else:
            if current:
                lines.append(f'        dc.b    "{current}"')
                current = ""
            lines.append(f"        dc.b    ${b:02X}")

    if current:
        lines.append(f'        dc.b    "{current}"')

    return lines


def main():
    rom_data = Path(ROM_PATH).read_bytes()

    output = []
    output.append("; ============================================================================")
    output.append("; 68K Entry Point and Initialization Code ($0003F0 - $00065F)")
    output.append("; ============================================================================")
    output.append("; Auto-generated from ROM binary")
    output.append("; ============================================================================")
    output.append("")

    # Define known code/data sections
    sections = [
        # (start, end, type, label, comment)
        (0x3F0, 0x4C0, "code", "EntryPoint", "Main entry point"),
        (0x4C0, 0x4D4, "code", "RAM_InitCode", "Code copied to work RAM"),
        (0x4D4, 0x4E8, "data", "VDP_InitTable", "VDP register init data"),
        (0x4E8, 0x510, "data", "Z80_InitData", "Z80 boot code + PSG init"),
        (0x510, 0x5A6, "ascii", "SecurityStrings", "MARS security strings"),
        (0x5A6, 0x660, "code", "InitVDPRegs", "VDP initialization code"),
    ]

    for start, end, stype, label, comment in sections:
        output.append(f"; --- {comment} (${start:04X}-${end:04X}) ---")
        if stype == "code":
            output.extend(extract_as_code(rom_data, start, end, label))
        elif stype == "data":
            output.extend(extract_as_data(rom_data, start, end, label))
        elif stype == "ascii":
            output.extend(extract_as_ascii(rom_data, start, end, label))
        output.append("")

    # Write output
    output_path = Path("disasm/entry_point_gen.asm")
    output_path.write_text('\n'.join(output))
    print(f"Generated {output_path}")
    print(f"Total sections: {len(sections)}")


if __name__ == '__main__':
    main()
