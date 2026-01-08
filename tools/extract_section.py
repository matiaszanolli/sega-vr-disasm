#!/usr/bin/env python3
"""
Extract ROM sections as byte-accurate assembly with disassembly comments.

This tool outputs dc.w statements that assemble back to exact bytes,
with comments showing the 68K disassembly for reference.
"""

import struct
import sys
from pathlib import Path

ROM_PATH = "Virtua Racing Deluxe (USA).32x"

# Simple 68K disassembler for comments
def disasm_instruction(data: bytes, offset: int) -> tuple[str, int]:
    """Returns (disassembly_string, instruction_size)"""
    if len(data) < 2:
        return "???", 1

    word = struct.unpack('>H', data[0:2])[0]
    cpu_addr = offset + 0x880000

    # JMP absolute long
    if word == 0x4EF9 and len(data) >= 6:
        addr = struct.unpack('>I', data[2:6])[0]
        return f"JMP ${addr:08X}", 6

    # JSR absolute long
    if word == 0x4EB9 and len(data) >= 6:
        addr = struct.unpack('>I', data[2:6])[0]
        return f"JSR ${addr:08X}", 6

    # LEA absolute long, An
    if (word & 0xF1FF) == 0x41F9 and len(data) >= 6:
        reg = (word >> 9) & 7
        addr = struct.unpack('>I', data[2:6])[0]
        return f"LEA ${addr:08X},A{reg}", 6

    # MOVEA.L #imm, An
    if (word & 0xF1FF) == 0x207C and len(data) >= 6:
        reg = (word >> 9) & 7
        val = struct.unpack('>I', data[2:6])[0]
        return f"MOVEA.L #${val:08X},A{reg}", 6

    # MOVE.L #imm, absolute long
    if word == 0x23FC and len(data) >= 10:
        val = struct.unpack('>I', data[2:6])[0]
        addr = struct.unpack('>I', data[6:10])[0]
        return f"MOVE.L #${val:08X},${addr:08X}", 10

    # MOVE.W #imm, SR
    if word == 0x46FC and len(data) >= 4:
        val = struct.unpack('>H', data[2:4])[0]
        return f"MOVE.W #${val:04X},SR", 4

    # MOVEQ #imm, Dn
    if (word & 0xF100) == 0x7000:
        reg = (word >> 9) & 7
        val = word & 0xFF
        return f"MOVEQ #${val:02X},D{reg}", 2

    # NOP
    if word == 0x4E71:
        return "NOP", 2

    # RTS
    if word == 0x4E75:
        return "RTS", 2

    # RTE
    if word == 0x4E73:
        return "RTE", 2

    # BRA/BEQ/BNE short
    if (word & 0xF000) == 0x6000 and (word & 0xFF) != 0:
        cond = (word >> 8) & 0xF
        disp = word & 0xFF
        if disp > 127:
            disp = disp - 256
        target = cpu_addr + 2 + disp
        cond_names = {0: "BRA", 1: "BSR", 2: "BHI", 3: "BLS", 4: "BCC", 5: "BCS",
                      6: "BNE", 7: "BEQ", 8: "BVC", 9: "BVS", 10: "BPL", 11: "BMI",
                      12: "BGE", 13: "BLT", 14: "BGT", 15: "BLE"}
        return f"{cond_names.get(cond, 'B??')}.S ${target:08X}", 2

    # BRA/BEQ/BNE word
    if (word & 0xF0FF) == 0x6000 and len(data) >= 4:
        cond = (word >> 8) & 0xF
        disp = struct.unpack('>h', data[2:4])[0]
        target = cpu_addr + 2 + disp
        cond_names = {0: "BRA", 1: "BSR", 2: "BHI", 3: "BLS", 4: "BCC", 5: "BCS",
                      6: "BNE", 7: "BEQ", 8: "BVC", 9: "BVS", 10: "BPL", 11: "BMI",
                      12: "BGE", 13: "BLT", 14: "BGT", 15: "BLE"}
        return f"{cond_names.get(cond, 'B??')}.W ${target:08X}", 4

    # CMPI.L #imm, d(An)
    if (word & 0xFFF8) == 0x0CA8 and len(data) >= 8:
        reg = word & 7
        val = struct.unpack('>I', data[2:6])[0]
        disp = struct.unpack('>h', data[6:8])[0]
        return f"CMPI.L #${val:08X},${disp:04X}(A{reg})", 8

    # BTST #bit, d(An)
    if (word & 0xFFF8) == 0x0828 and len(data) >= 6:
        reg = word & 7
        bit = struct.unpack('>H', data[2:4])[0]
        disp = struct.unpack('>h', data[4:6])[0]
        return f"BTST #{bit},${disp:04X}(A{reg})", 6

    # MOVEM.L regs, -(SP)
    if word == 0x48E7 and len(data) >= 4:
        return "MOVEM.L regs,-(SP)", 4

    # MOVEM.L (SP)+, regs
    if word == 0x4CDF and len(data) >= 4:
        return "MOVEM.L (SP)+,regs", 4

    # DBRA Dn, disp
    if (word & 0xFFF8) == 0x51C8 and len(data) >= 4:
        reg = word & 7
        disp = struct.unpack('>h', data[2:4])[0]
        target = cpu_addr + 2 + disp
        return f"DBRA D{reg},${target:08X}", 4

    # JMP (An)
    if (word & 0xFFF8) == 0x4ED0:
        reg = word & 7
        return f"JMP (A{reg})", 2

    # MOVE.L (A0)+,(A1)+
    if word == 0x22D8:
        return "MOVE.L (A0)+,(A1)+", 2

    # MOVE.B (A3)+,(A1)+
    if word == 0x12DB:
        return "MOVE.B (A3)+,(A1)+", 2

    # MOVE.B (A3)+,(A2)
    if word == 0x149B:
        return "MOVE.B (A3)+,(A2)", 2

    # Default: unknown
    return f"dc.w ${word:04X}", 2


def extract_section(start: int, end: int, label: str = None):
    """Extract a ROM section as dc.w with disassembly comments."""
    rom_data = Path(ROM_PATH).read_bytes()

    lines = []
    lines.append(f"; ============================================================================")
    lines.append(f"; {label or 'Code Section'} (${start:04X}-${end:04X})")
    lines.append(f"; ============================================================================")
    lines.append("")

    if label:
        lines.append(f"{label}:")

    offset = start
    while offset < end:
        remaining = rom_data[offset:end]
        cpu_addr = offset + 0x880000

        # Get disassembly for comment
        disasm, size = disasm_instruction(remaining, offset)

        # Ensure we don't go past end
        if offset + size > end:
            size = end - offset

        # Output as dc.w with comment
        if size == 2:
            word = struct.unpack('>H', remaining[0:2])[0]
            lines.append(f"        dc.w    ${word:04X}                    ; {cpu_addr:08X}: {disasm}")
        elif size == 4:
            w1 = struct.unpack('>H', remaining[0:2])[0]
            w2 = struct.unpack('>H', remaining[2:4])[0]
            lines.append(f"        dc.w    ${w1:04X}, ${w2:04X}            ; {cpu_addr:08X}: {disasm}")
        elif size == 6:
            w1 = struct.unpack('>H', remaining[0:2])[0]
            w2 = struct.unpack('>H', remaining[2:4])[0]
            w3 = struct.unpack('>H', remaining[4:6])[0]
            lines.append(f"        dc.w    ${w1:04X}, ${w2:04X}, ${w3:04X}    ; {cpu_addr:08X}: {disasm}")
        elif size == 8:
            w1 = struct.unpack('>H', remaining[0:2])[0]
            w2 = struct.unpack('>H', remaining[2:4])[0]
            w3 = struct.unpack('>H', remaining[4:6])[0]
            w4 = struct.unpack('>H', remaining[6:8])[0]
            lines.append(f"        dc.w    ${w1:04X}, ${w2:04X}, ${w3:04X}, ${w4:04X}  ; {cpu_addr:08X}: {disasm}")
        elif size == 10:
            w1 = struct.unpack('>H', remaining[0:2])[0]
            w2 = struct.unpack('>H', remaining[2:4])[0]
            w3 = struct.unpack('>H', remaining[4:6])[0]
            w4 = struct.unpack('>H', remaining[6:8])[0]
            w5 = struct.unpack('>H', remaining[8:10])[0]
            lines.append(f"        dc.w    ${w1:04X}, ${w2:04X}, ${w3:04X}, ${w4:04X}, ${w5:04X}  ; {cpu_addr:08X}: {disasm}")
        else:
            # Fallback for odd sizes
            for i in range(0, size, 2):
                if i + 2 <= size:
                    word = struct.unpack('>H', remaining[i:i+2])[0]
                    lines.append(f"        dc.w    ${word:04X}")
                else:
                    lines.append(f"        dc.b    ${remaining[i]:02X}")

        offset += size

    lines.append("")
    return '\n'.join(lines)


def main():
    if len(sys.argv) < 3:
        print("Usage: extract_section.py <start_hex> <end_hex> [label]")
        print("Example: extract_section.py 3F0 832 EntryPoint")
        sys.exit(1)

    start = int(sys.argv[1], 16)
    end = int(sys.argv[2], 16)
    label = sys.argv[3] if len(sys.argv) > 3 else None

    output = extract_section(start, end, label)
    print(output)


if __name__ == '__main__':
    main()
