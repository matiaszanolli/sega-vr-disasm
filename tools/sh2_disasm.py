#!/usr/bin/env python3
"""
Basic SH2 Disassembler for Sega 32X
Covers common instructions found in Virtua Racing
"""

import struct
import sys

class SH2Disassembler:
    def __init__(self, rom_data, start_offset=0, base_address=0x02200000):
        self.rom = rom_data
        self.offset = start_offset
        self.base_address = base_address  # SH2 SDRAM base

    def read_word(self, offset=None):
        """Read 16-bit big-endian word"""
        if offset is None:
            offset = self.offset
        return struct.unpack('>H', self.rom[offset:offset+2])[0]

    def get_address(self):
        """Get current address"""
        return self.base_address + self.offset

    def disassemble_instruction(self):
        """Disassemble single SH2 instruction"""
        addr = self.get_address()
        opcode = self.read_word()

        start_offset = self.offset
        self.offset += 2

        # Decode instruction
        instruction, size = self.decode_opcode(opcode, addr)

        # Format output
        bytes_str = f"{opcode:04X}"

        return f"{addr:08X}  {bytes_str:8s} {instruction}"

    def decode_opcode(self, opcode, addr):
        """Decode SH2 opcode"""

        # NOP (0009)
        if opcode == 0x0009:
            return "NOP", 2

        # RTS (000B)
        if opcode == 0x000B:
            return "RTS", 2

        # RTE (002B)
        if opcode == 0x002B:
            return "RTE", 2

        # CLRMAC (0028)
        if opcode == 0x0028:
            return "CLRMAC", 2

        # CLRT (0008)
        if opcode == 0x0008:
            return "CLRT", 2

        # SETT (0018)
        if opcode == 0x0018:
            return "SETT", 2

        # SLEEP (001B)
        if opcode == 0x001B:
            return "SLEEP", 2

        # MOV.B Rm,@Rn (2nm0)
        if (opcode & 0xF00F) == 0x2000:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"MOV.B   R{m},@R{n}", 2

        # MOV.W Rm,@Rn (2nm1)
        if (opcode & 0xF00F) == 0x2001:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"MOV.W   R{m},@R{n}", 2

        # MOV.L Rm,@Rn (2nm2)
        if (opcode & 0xF00F) == 0x2002:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"MOV.L   R{m},@R{n}", 2

        # MOV.B @Rm,Rn (6nm0)
        if (opcode & 0xF00F) == 0x6000:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"MOV.B   @R{m},R{n}", 2

        # MOV.W @Rm,Rn (6nm1)
        if (opcode & 0xF00F) == 0x6001:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"MOV.W   @R{m},R{n}", 2

        # MOV.L @Rm,Rn (6nm2)
        if (opcode & 0xF00F) == 0x6002:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"MOV.L   @R{m},R{n}", 2

        # MOV Rm,Rn (6nm3)
        if (opcode & 0xF00F) == 0x6003:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"MOV     R{m},R{n}", 2

        # MOV.B Rm,@-Rn (2nm4)
        if (opcode & 0xF00F) == 0x2004:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"MOV.B   R{m},@-R{n}", 2

        # MOV.W Rm,@-Rn (2nm5)
        if (opcode & 0xF00F) == 0x2005:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"MOV.W   R{m},@-R{n}", 2

        # MOV.L Rm,@-Rn (2nm6)
        if (opcode & 0xF00F) == 0x2006:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"MOV.L   R{m},@-R{n}", 2

        # MOV.B @Rm+,Rn (6nm4)
        if (opcode & 0xF00F) == 0x6004:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"MOV.B   @R{m}+,R{n}", 2

        # MOV.W @Rm+,Rn (6nm5)
        if (opcode & 0xF00F) == 0x6005:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"MOV.W   @R{m}+,R{n}", 2

        # MOV.L @Rm+,Rn (6nm6)
        if (opcode & 0xF00F) == 0x6006:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"MOV.L   @R{m}+,R{n}", 2

        # ADD Rm,Rn (3nmc)
        if (opcode & 0xF00F) == 0x300C:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"ADD     R{m},R{n}", 2

        # ADD #imm,Rn (7nii)
        if (opcode & 0xF000) == 0x7000:
            n = (opcode >> 8) & 0xF
            imm = opcode & 0xFF
            if imm & 0x80:  # Sign extend
                imm = imm - 256
            return f"ADD     #${imm & 0xFF:02X},R{n}", 2

        # MOV #imm,Rn (Enii)
        if (opcode & 0xF000) == 0xE000:
            n = (opcode >> 8) & 0xF
            imm = opcode & 0xFF
            return f"MOV     #${imm:02X},R{n}", 2

        # MOV.W @(disp,PC),Rn (9ndd)
        if (opcode & 0xF000) == 0x9000:
            n = (opcode >> 8) & 0xF
            disp = (opcode & 0xFF) * 2
            target = (addr & 0xFFFFFFFC) + 4 + disp
            return f"MOV.W   @(${{target:08X}},PC),R{n}", 2

        # MOV.L @(disp,PC),Rn (Dndd)
        if (opcode & 0xF000) == 0xD000:
            n = (opcode >> 8) & 0xF
            disp = (opcode & 0xFF) * 4
            target = (addr & 0xFFFFFFFC) + 4 + disp
            return f"MOV.L   @(${target:08X},PC),R{n}", 2

        # BRA disp (Addd)
        if (opcode & 0xF000) == 0xA000:
            disp = opcode & 0xFFF
            if disp & 0x800:  # Sign extend
                disp = disp - 0x1000
            target = addr + 4 + (disp * 2)
            return f"BRA     ${target:08X}", 2

        # BSR disp (Bddd)
        if (opcode & 0xF000) == 0xB000:
            disp = opcode & 0xFFF
            if disp & 0x800:
                disp = disp - 0x1000
            target = addr + 4 + (disp * 2)
            return f"BSR     ${target:08X}", 2

        # BT disp (89dd)
        if (opcode & 0xFF00) == 0x8900:
            disp = opcode & 0xFF
            if disp & 0x80:
                disp = disp - 256
            target = addr + 4 + (disp * 2)
            return f"BT      ${target:08X}", 2

        # BF disp (8Bdd)
        if (opcode & 0xFF00) == 0x8B00:
            disp = opcode & 0xFF
            if disp & 0x80:
                disp = disp - 256
            target = addr + 4 + (disp * 2)
            return f"BF      ${target:08X}", 2

        # CMP/EQ #imm,R0 (88ii)
        if (opcode & 0xFF00) == 0x8800:
            imm = opcode & 0xFF
            return f"CMP/EQ  #${imm:02X},R0", 2

        # Unknown instruction
        return f"DW      ${opcode:04X}", 2

    def disassemble_range(self, start_offset, end_offset, max_instructions=None):
        """Disassemble a range of SH2 code"""
        self.offset = start_offset
        instructions = []
        count = 0

        while self.offset < end_offset:
            if max_instructions and count >= max_instructions:
                break

            try:
                instr = self.disassemble_instruction()
                instructions.append(instr)
                count += 1
            except Exception as e:
                addr = self.get_address()
                instructions.append(f"{addr:08X}  <ERROR: {e}>")
                break

        return instructions

def main():
    if len(sys.argv) < 2:
        print("Usage: sh2_disasm.py <rom_file> [start_offset] [count]")
        sys.exit(1)

    rom_file = sys.argv[1]
    start_offset = int(sys.argv[2], 16) if len(sys.argv) > 2 else 0x0245E4
    count = int(sys.argv[3]) if len(sys.argv) > 3 else 50

    with open(rom_file, 'rb') as f:
        rom_data = f.read()

    print(f"SH2 Disassembly from offset 0x{start_offset:06X} ({count} instructions)")
    print("=" * 70)

    disasm = SH2Disassembler(rom_data, start_offset)
    instructions = disasm.disassemble_range(start_offset, len(rom_data), count)

    for instr in instructions:
        print(instr)

if __name__ == "__main__":
    main()
