#!/usr/bin/env python3
"""
Simple Motorola 68000 Disassembler
For Virtua Racing Deluxe reverse engineering
"""

import struct
import sys

class M68KDisassembler:
    def __init__(self, rom_data, start_offset=0, base_address=0x00880000):
        self.rom = rom_data
        self.offset = start_offset
        self.base_address = base_address
        self.labels = {}  # Address -> Label name mapping
        self.references = []  # Track code references for labels

    def read_word(self, offset=None):
        """Read 16-bit big-endian word"""
        if offset is None:
            offset = self.offset
        return struct.unpack('>H', self.rom[offset:offset+2])[0]

    def read_long(self, offset=None):
        """Read 32-bit big-endian long"""
        if offset is None:
            offset = self.offset
        return struct.unpack('>I', self.rom[offset:offset+4])[0]

    def get_address(self):
        """Get current ROM address"""
        return self.base_address + self.offset

    def format_address(self, addr):
        """Format address for display"""
        if addr in self.labels:
            return self.labels[addr]
        return f"${addr:08X}"

    def disassemble_instruction(self):
        """Disassemble single instruction at current offset"""
        addr = self.get_address()
        opcode = self.read_word()

        # Store original offset for multi-word instructions
        start_offset = self.offset
        self.offset += 2

        # Decode instruction
        instruction, size = self.decode_opcode(opcode, addr)

        # Format output
        bytes_str = ""
        for i in range(0, size, 2):
            word = self.read_word(start_offset + i)
            bytes_str += f"{word:04X} "

        return f"{addr:08X}  {bytes_str:20s} {instruction}"

    def decode_opcode(self, opcode, addr):
        """Decode 68000 opcode - returns (instruction_string, total_bytes)"""

        # JMP instruction (4E F9 = JMP xxxx.l)
        if opcode == 0x4EF9:
            target = self.read_long()
            self.offset += 4
            self.references.append(target)
            return f"JMP     {self.format_address(target)}", 6

        # JMP (An) - indirect jump
        if (opcode & 0xFFF8) == 0x4ED0:
            reg = opcode & 7
            return f"JMP     (A{reg})", 2

        # JSR instruction (4E B9 = JSR xxxx.l)
        if opcode == 0x4EB9:
            target = self.read_long()
            self.offset += 4
            self.references.append(target)
            return f"JSR     {self.format_address(target)}", 6

        # JSR (PC+d16) - PC relative (4EBA)
        if opcode == 0x4EBA:
            disp = self.read_word()
            self.offset += 2
            if disp & 0x8000:
                disp = disp - 0x10000
            target = addr + 2 + disp
            self.references.append(target)
            return f"JSR     {self.format_address(target)}(PC)", 4

        # JSR (An) - indirect call
        if (opcode & 0xFFF8) == 0x4E90:
            reg = opcode & 7
            return f"JSR     (A{reg})", 2

        # RTS (4E75)
        if opcode == 0x4E75:
            return "RTS", 2

        # RTE (4E73)
        if opcode == 0x4E73:
            return "RTE", 2

        # NOP (4E71)
        if opcode == 0x4E71:
            return "NOP", 2

        # MOVE.L #imm, An (2x7C)
        if (opcode & 0xF1F8) == 0x207C:
            reg = (opcode >> 9) & 7
            imm = self.read_long()
            self.offset += 4
            return f"MOVE.L  #${imm:08X},A{reg}", 6

        # MOVE.W #imm, An (3x7C)
        if (opcode & 0xF1F8) == 0x307C:
            reg = (opcode >> 9) & 7
            imm = self.read_word()
            self.offset += 2
            return f"MOVE.W  #${imm:04X},A{reg}", 4

        # MOVEA.L #imm, An (2x7C variant)
        if (opcode & 0xF1F8) == 0x2A7C:
            reg = (opcode >> 9) & 7
            imm = self.read_long()
            self.offset += 4
            return f"MOVEA.L #${imm:08X},A{reg}", 6

        # LEA xxxx.l, An (41F9)
        if (opcode & 0xF1FF) == 0x41F9:
            reg = (opcode >> 9) & 7
            addr = self.read_long()
            self.offset += 4
            return f"LEA     {self.format_address(addr)},A{reg}", 6

        # LEA (PC+d16), An - PC relative (41FA, 43FA, 45FA, 47FA, etc.)
        if (opcode & 0xF1FF) == 0x41FA:
            reg = (opcode >> 9) & 7
            disp = self.read_word()
            self.offset += 2
            if disp & 0x8000:
                disp = disp - 0x10000
            target = addr + 2 + disp
            return f"LEA     {self.format_address(target)}(PC),A{reg}", 4

        # MOVEQ #imm, Dn (7xxx)
        if (opcode & 0xF100) == 0x7000:
            reg = (opcode >> 9) & 7
            imm = opcode & 0xFF
            if imm & 0x80:  # Sign extend
                imm = imm - 256
            return f"MOVEQ   #${imm & 0xFF:02X},D{reg}", 2

        # MOVE.W (An), (An) - common pattern
        if (opcode & 0xF000) == 0x3000:
            return self.decode_move(opcode)

        # MOVE.L (An), (An) - common pattern
        if (opcode & 0xF000) == 0x2000:
            return self.decode_move(opcode)

        # MOVE.B (An), (An) - common pattern
        if (opcode & 0xF000) == 0x1000:
            return self.decode_move(opcode)

        # BRA (6xxx)
        if (opcode & 0xFF00) == 0x6000:
            disp = opcode & 0xFF
            if disp == 0:  # 16-bit displacement
                disp = self.read_word()
                self.offset += 2
                if disp & 0x8000:
                    disp = disp - 0x10000
                size = 4
            else:
                if disp & 0x80:
                    disp = disp - 256
                size = 2
            target = addr + 2 + disp
            self.references.append(target)
            return f"BRA     {self.format_address(target)}", size

        # BSR (61xx)
        if (opcode & 0xFF00) == 0x6100:
            disp = opcode & 0xFF
            if disp == 0:
                disp = self.read_word()
                self.offset += 2
                if disp & 0x8000:
                    disp = disp - 0x10000
                size = 4
            else:
                if disp & 0x80:
                    disp = disp - 256
                size = 2
            target = addr + 2 + disp
            self.references.append(target)
            return f"BSR     {self.format_address(target)}", size

        # Bcc (6xxx where xx != 00 and != FF)
        if (opcode & 0xF000) == 0x6000:
            cond = (opcode >> 8) & 0x0F
            cond_names = ["BRA", "BSR", "BHI", "BLS", "BCC", "BCS", "BNE", "BEQ",
                         "BVC", "BVS", "BPL", "BMI", "BGE", "BLT", "BGT", "BLE"]
            disp = opcode & 0xFF
            if disp == 0:
                disp = self.read_word()
                self.offset += 2
                if disp & 0x8000:
                    disp = disp - 0x10000
                size = 4
            else:
                if disp & 0x80:
                    disp = disp - 256
                size = 2
            target = addr + 2 + disp
            self.references.append(target)
            return f"{cond_names[cond]:8s}{self.format_address(target)}", size

        # TST
        if (opcode & 0xFF00) == 0x4A00:
            size_str = [".B", ".W", ".L"][((opcode >> 6) & 3) - 1] if ((opcode >> 6) & 3) != 0 else ""
            ea, ea_size = self.decode_ea(opcode & 0x3F, size_str)
            return f"TST{size_str:4s}{ea}", 2 + ea_size

        # CLR
        if (opcode & 0xFF00) == 0x4200:
            size_str = [".B", ".W", ".L"][((opcode >> 6) & 3) - 1] if ((opcode >> 6) & 3) != 0 else ""
            ea, ea_size = self.decode_ea(opcode & 0x3F, size_str)
            return f"CLR{size_str:4s}{ea}", 2 + ea_size

        # BTST (0x0800 - bit test with immediate)
        if opcode == 0x0800 or opcode == 0x0840 or opcode == 0x0880:
            bit = self.read_word()
            self.offset += 2
            ea, ea_size = self.decode_ea(self.read_word() if ea_size else opcode & 0x3F, ".B")
            if ea_size:
                self.offset += 2
            return f"BTST    #{bit & 0xFF},<EA>", 4

        # BTST dynamic (08xx pattern for bit operations)
        if (opcode & 0xFFC0) == 0x0800:
            bit_word = self.read_word()
            self.offset += 2
            ea, ea_size = self.decode_ea(opcode & 0x3F, ".B")
            return f"BTST    #{bit_word & 0xFF},{ea}", 4 + ea_size

        # BSET, BCLR, BCHG (08xx patterns)
        if (opcode & 0xF000) == 0x0000:
            bit_op = (opcode >> 6) & 3
            bit_ops = ["BTST", "BCHG", "BCLR", "BSET"]
            if (opcode & 0x0100):  # Register bit number
                bit_reg = (opcode >> 9) & 7
                ea, ea_size = self.decode_ea(opcode & 0x3F, ".B")
                return f"{bit_ops[bit_op]:8s}D{bit_reg},{ea}", 2 + ea_size
            else:  # Immediate bit number
                bit = self.read_word()
                self.offset += 2
                ea, ea_size = self.decode_ea(opcode & 0x3F, ".B")
                return f"{bit_ops[bit_op]:8s}#{bit & 0xFF},{ea}", 4 + ea_size

        # ORI/ANDI/SUBI/ADDI to CCR/SR
        if (opcode & 0xFFF8) == 0x003C:  # ORI to CCR
            imm = self.read_word()
            self.offset += 2
            return f"ORI     #${imm:02X},CCR", 4
        if (opcode & 0xFFF8) == 0x023C:  # ANDI to CCR
            imm = self.read_word()
            self.offset += 2
            return f"ANDI    #${imm:02X},CCR", 4
        if (opcode & 0xFFF8) == 0x007C:  # ORI to SR
            imm = self.read_word()
            self.offset += 2
            return f"ORI     #${imm:04X},SR", 4
        if (opcode & 0xFFF8) == 0x027C:  # ANDI to SR
            imm = self.read_word()
            self.offset += 2
            return f"ANDI    #${imm:04X},SR", 4

        # CMPI
        if (opcode & 0xFF00) == 0x0C00:
            size = (opcode >> 6) & 3
            size_map = {0: ".B", 1: ".W", 2: ".L"}
            size_str = size_map.get(size, "")
            if size == 2:
                imm = self.read_long()
                self.offset += 4
                imm_str = f"#${imm:08X}"
                ea_size = 6
            else:
                imm = self.read_word()
                self.offset += 2
                imm_str = f"#${imm:04X}" if size == 1 else f"#${imm:02X}"
                ea_size = 4
            ea, ea_add = self.decode_ea(opcode & 0x3F, size_str)
            return f"CMPI{size_str:4s}{imm_str},{ea}", ea_size + ea_add

        # DBcc (51C8-51CF for DBRA, etc.)
        if (opcode & 0xF0F8) == 0x50C8:
            cond = (opcode >> 8) & 0x0F
            reg = opcode & 0x07
            disp = self.read_word()
            self.offset += 2
            if disp & 0x8000:
                disp = disp - 0x10000
            target = addr + 2 + disp
            cond_names = ["DBT", "DBRA", "DBHI", "DBLS", "DBCC", "DBCS", "DBNE", "DBEQ",
                         "DBVC", "DBVS", "DBPL", "DBMI", "DBGE", "DBLT", "DBGT", "DBLE"]
            return f"{cond_names[cond]:8s}D{reg},{self.format_address(target)}", 4

        # MOVEM - Move Multiple Registers (48xx = register to memory, 4Cxx = memory to register)
        if (opcode & 0xFB80) == 0x4880:  # MOVEM register to memory
            size_str = ".W" if (opcode & 0x0040) == 0 else ".L"
            mask = self.read_word()
            self.offset += 2
            ea, ea_size = self.decode_ea(opcode & 0x3F, size_str)
            # Decode register mask
            reg_list = []
            for i in range(8):
                if mask & (1 << i):
                    reg_list.append(f"D{i}")
            for i in range(8):
                if mask & (1 << (i+8)):
                    reg_list.append(f"A{i}")
            regs = "/".join(reg_list) if reg_list else "none"
            return f"MOVEM{size_str:3s}{regs},{ea}", 4 + ea_size

        if (opcode & 0xFB80) == 0x4C80:  # MOVEM memory to register
            size_str = ".W" if (opcode & 0x0040) == 0 else ".L"
            mask = self.read_word()
            self.offset += 2
            ea, ea_size = self.decode_ea(opcode & 0x3F, size_str)
            # Decode register mask
            reg_list = []
            for i in range(8):
                if mask & (1 << i):
                    reg_list.append(f"D{i}")
            for i in range(8):
                if mask & (1 << (i+8)):
                    reg_list.append(f"A{i}")
            regs = "/".join(reg_list) if reg_list else "none"
            return f"MOVEM{size_str:3s}{ea},{regs}", 4 + ea_size

        # MOVE to/from SR
        if (opcode & 0xFFC0) == 0x46C0:  # MOVE SR,<ea>
            ea, ea_size = self.decode_ea(opcode & 0x3F, ".W")
            return f"MOVE    SR,{ea}", 2 + ea_size

        if (opcode & 0xFFC0) == 0x44C0:  # MOVE <ea>,CCR
            ea, ea_size = self.decode_ea(opcode & 0x3F, ".W")
            return f"MOVE    {ea},CCR", 2 + ea_size

        if (opcode & 0xFFC0) == 0x40C0:  # MOVE SR,<ea> (alternate encoding)
            ea, ea_size = self.decode_ea(opcode & 0x3F, ".W")
            return f"MOVE    SR,{ea}", 2 + ea_size

        # SUBQ/ADDQ
        if (opcode & 0xF100) == 0x5000:
            is_sub = (opcode & 0x0100) == 0
            size = (opcode >> 6) & 3
            size_map = {0: ".B", 1: ".W", 2: ".L"}
            size_str = size_map.get(size, "")
            data = (opcode >> 9) & 7
            if data == 0:
                data = 8
            ea, ea_size = self.decode_ea(opcode & 0x3F, size_str)
            op = "SUBQ" if is_sub else "ADDQ"
            return f"{op}{size_str:4s}#{data},{ea}", 2 + ea_size

        # Unknown instruction
        return f"DC.W    ${opcode:04X}  ; Unknown", 2

    def decode_move(self, opcode):
        """Decode MOVE instruction"""
        size = (opcode >> 12) & 3
        size_map = {1: ".B", 3: ".W", 2: ".L"}
        size_str = size_map.get(size, "")

        src_ea, src_size = self.decode_ea(opcode & 0x3F, size_str)

        dst_mode = (opcode >> 6) & 7
        dst_reg = (opcode >> 9) & 7
        dst_ea_code = (dst_reg << 3) | dst_mode
        dst_ea, dst_size = self.decode_ea(dst_ea_code, size_str)

        return f"MOVE{size_str:4s}{src_ea},{dst_ea}", 2 + src_size + dst_size

    def decode_ea(self, ea_code, size_str):
        """Decode effective address - returns (ea_string, additional_bytes)"""
        mode = ea_code & 0x07
        reg = (ea_code >> 3) & 0x07

        if mode == 0:  # Dn
            return f"D{reg}", 0
        elif mode == 1:  # An
            return f"A{reg}", 0
        elif mode == 2:  # (An)
            return f"(A{reg})", 0
        elif mode == 3:  # (An)+
            return f"(A{reg})+", 0
        elif mode == 4:  # -(An)
            return f"-(A{reg})", 0
        elif mode == 5:  # d16(An)
            disp = self.read_word()
            self.offset += 2
            return f"${disp:04X}(A{reg})", 2
        elif mode == 7:
            if reg == 0:  # xxx.W
                addr = self.read_word()
                self.offset += 2
                return f"${addr:04X}.W", 2
            elif reg == 1:  # xxx.L
                addr = self.read_long()
                self.offset += 4
                return f"{self.format_address(addr)}", 4
            elif reg == 4:  # #imm
                if size_str == ".L":
                    imm = self.read_long()
                    self.offset += 4
                    return f"#${imm:08X}", 4
                else:
                    imm = self.read_word()
                    self.offset += 2
                    return f"#${imm:04X}", 2

        return f"<EA:{ea_code:02X}>", 0

    def disassemble_range(self, start_offset, end_offset, max_instructions=None):
        """Disassemble a range of code"""
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
                # If we hit data, stop
                addr = self.get_address()
                instructions.append(f"{addr:08X}  <ERROR: {e}>")
                break

        return instructions


def main():
    if len(sys.argv) < 2:
        print("Usage: m68k_disasm.py <rom_file> [start_offset] [count]")
        sys.exit(1)

    rom_file = sys.argv[1]
    start_offset = int(sys.argv[2], 16) if len(sys.argv) > 2 else 0x832
    count = int(sys.argv[3]) if len(sys.argv) > 3 else 50

    with open(rom_file, 'rb') as f:
        rom_data = f.read()

    print(f"Disassembling from offset 0x{start_offset:06X} ({count} instructions)")
    print("=" * 80)

    disasm = M68KDisassembler(rom_data, start_offset)
    instructions = disasm.disassemble_range(start_offset, len(rom_data), count)

    for instr in instructions:
        print(instr)

    # Print referenced addresses
    if disasm.references:
        print("\n" + "=" * 80)
        print("Code References Found:")
        unique_refs = sorted(set(disasm.references))
        for ref in unique_refs[:20]:  # First 20
            file_offset = ref - 0x00880000
            print(f"  {ref:08X} (file offset: 0x{file_offset:06X})")

if __name__ == "__main__":
    main()
