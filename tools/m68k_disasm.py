#!/usr/bin/env python3
"""
Simple Motorola 68000 Disassembler
For Virtua Racing Deluxe reverse engineering
"""

import struct
import sys

class M68KDisassembler:
    # Hardware register addresses and symbolic names (from Super MD Manual / 32X Hardware Manual)
    HARDWARE_REGISTERS = {
        # Mega Drive I/O Registers
        0xA10001: "MD_VERSION",         # Version register (region, NTSC/PAL)
        0xA10003: "MD_DATA1",            # Controller Port 1 Data
        0xA10005: "MD_DATA2",            # Controller Port 2 Data
        0xA10007: "MD_DATAEXP",          # Expansion Port Data
        0xA10009: "MD_CTRL1",            # Controller Port 1 Control
        0xA1000B: "MD_CTRL2",            # Controller Port 2 Control
        0xA1000D: "MD_CTRLEXP",          # Expansion Port Control
        0xA1000F: "MD_TXDATA1",          # Controller Port 1 Serial TX
        0xA10011: "MD_RXDATA1",          # Controller Port 1 Serial RX
        0xA10013: "MD_SCTRL1",           # Controller Port 1 Serial Control
        0xA10015: "MD_TXDATA2",          # Controller Port 2 Serial TX
        0xA10017: "MD_RXDATA2",          # Controller Port 2 Serial RX
        0xA10019: "MD_SCTRL2",           # Controller Port 2 Serial Control
        0xA1001B: "MD_TXDATAEXP",        # Expansion Port Serial TX
        0xA1001D: "MD_RXDATAEXP",        # Expansion Port Serial RX
        0xA1001F: "MD_SCTRLEXP",         # Expansion Port Serial Control

        # Z80 Control
        0xA11100: "Z80_BUSREQ",          # Z80 Bus Request
        0xA11200: "Z80_RESET",           # Z80 Reset

        # TMSS Register
        0xA14000: "TMSS",                # Trademark Security System
        0xA14001: "TMSS+1",
        0xA14002: "TMSS+2",
        0xA14003: "TMSS+3",

        # 32X System Registers (MARS)
        0xA15100: "MARS_SYS_INTCTL",     # Adapter Control (FM, REN, RES, ADEN)
        0xA15101: "MARS_SYS_INTCTL+1",
        0xA15102: "MARS_SYS_INTMASK",    # Interrupt Control (INTS, INTM)
        0xA15103: "MARS_SYS_INTMASK+1",
        0xA15104: "MARS_SYS_HCOUNT",     # H Interrupt Vector / Bank Set
        0xA15105: "MARS_SYS_HCOUNT+1",
        0xA15106: "MARS_DREQ_CTRL",      # DREQ Control Register
        0xA15107: "MARS_DREQ_CTRL+1",
        0xA15108: "MARS_DREQ_SRC_H",     # DREQ Source Address (high)
        0xA1510A: "MARS_DREQ_SRC_L",     # DREQ Source Address (low)
        0xA1510C: "MARS_DREQ_DST_H",     # DREQ Destination Address (high)
        0xA1510E: "MARS_DREQ_DST_L",     # DREQ Destination Address (low)
        0xA15110: "MARS_DREQ_LEN",       # DREQ Length
        0xA15112: "MARS_FIFO",           # FIFO Data Register

        # 32X Communication Ports (68K ↔ SH2)
        0xA15120: "COMM0",               # Communication Port 0
        0xA15122: "COMM1",               # Communication Port 1
        0xA15124: "COMM2",               # Communication Port 2
        0xA15126: "COMM3",               # Communication Port 3
        0xA15128: "COMM4",               # Communication Port 4
        0xA1512A: "COMM5",               # Communication Port 5
        0xA1512C: "COMM6",               # Communication Port 6
        0xA1512E: "COMM7",               # Communication Port 7

        # 32X PWM Sound Registers
        0xA15130: "PWM_CTRL",            # PWM Control
        0xA15132: "PWM_CYCLE",           # PWM Cycle Register
        0xA15134: "PWM_LDATA",           # PWM Left Channel Data
        0xA15136: "PWM_RDATA",           # PWM Right Channel Data
        0xA15138: "PWM_MONO",            # PWM Mono Data

        # 32X VDP Registers
        0xA15180: "MARS_VDP_MODE",       # Bitmap Mode Register
        0xA15182: "MARS_VDP_SHIFT",      # Screen Shift Control
        0xA15184: "MARS_VDP_FILLEN",     # Auto Fill Length
        0xA15186: "MARS_VDP_FILLADR",    # Auto Fill Start Address
        0xA15188: "MARS_VDP_FILLDATA",   # Auto Fill Data
        0xA1518A: "MARS_VDP_FBCTL",      # Frame Buffer Control

        # Mega Drive VDP
        0xC00000: "VDP_DATA",            # VDP Data Port
        0xC00002: "VDP_DATA2",           # VDP Data Port (mirror)
        0xC00004: "VDP_CTRL",            # VDP Control Port
        0xC00006: "VDP_CTRL2",           # VDP Control Port (mirror)
        0xC00008: "VDP_HVCNT",           # HV Counter
        0xC0000A: "VDP_HVCNT2",          # HV Counter (mirror)
        0xC00011: "PSG",                 # PSG Sound

        # Bank Switching Registers
        0xA130F0: "DRAM_CTRL",           # D-RAM Board Control (dev kit)
        0xA130F1: "SRAM_BANK0",          # SRAM Enable / Bank 0
        0xA130F3: "BANK1",               # Bank 1 ($080000-$0FFFFF)
        0xA130F5: "BANK2",               # Bank 2 ($100000-$17FFFF)
        0xA130F7: "BANK3",               # Bank 3 ($180000-$1FFFFF)
        0xA130F9: "BANK4",               # Bank 4 ($200000-$27FFFF)
        0xA130FB: "BANK5",               # Bank 5 ($280000-$2FFFFF)
        0xA130FD: "BANK6",               # Bank 6 ($300000-$37FFFF)
        0xA130FF: "BANK7",               # Bank 7 ($380000-$3FFFFF)

        # Common Memory Regions
        0xFF0000: "WORK_RAM",            # Main Work RAM start
        0xFFFFFF: "WORK_RAM_END",        # Work RAM end
        0xA00000: "Z80_RAM",             # Z80 RAM start
        0xA10000: "MD_IO_BASE",          # MD I/O Base
        0xA15100: "MARS_SYS_BASE",       # 32X System Register Base
    }

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
        """Format address for display with symbolic names"""
        # Check user-defined labels first
        if addr in self.labels:
            return self.labels[addr]
        # Check hardware registers
        if addr in self.HARDWARE_REGISTERS:
            return self.HARDWARE_REGISTERS[addr]
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

        # MOVEA.L #imm, An (2x7C pattern for all registers)
        if (opcode & 0xF1FF) == 0x207C:
            reg = (opcode >> 9) & 7
            imm = self.read_long()
            self.offset += 4
            return f"MOVEA.L #${imm:08X},A{reg}", 6

        # MOVEA.W #imm, An (3x7C)
        if (opcode & 0xF1FF) == 0x307C:
            reg = (opcode >> 9) & 7
            imm = self.read_word()
            self.offset += 2
            return f"MOVEA.W #${imm:04X},A{reg}", 4

        # MOVEA.L from memory/EA (2xxx)
        if (opcode & 0xF1C0) == 0x2040:
            reg = (opcode >> 9) & 7
            ea, ea_size = self.decode_ea(opcode & 0x3F, ".L")
            return f"MOVEA.L {ea},A{reg}", 2 + ea_size

        # MOVEA.W from memory/EA (3xxx)
        if (opcode & 0xF1C0) == 0x3040:
            reg = (opcode >> 9) & 7
            ea, ea_size = self.decode_ea(opcode & 0x3F, ".W")
            return f"MOVEA.W {ea},A{reg}", 2 + ea_size

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
            size = (opcode >> 6) & 3
            size_map = {0: ".B", 1: ".W", 2: ".L"}
            size_str = size_map.get(size, "")
            ea, ea_size = self.decode_ea(opcode & 0x3F, size_str)
            return f"TST{size_str:4s}{ea}", 2 + ea_size

        # CLR
        if (opcode & 0xFF00) == 0x4200:
            size_str = [".B", ".W", ".L"][((opcode >> 6) & 3) - 1] if ((opcode >> 6) & 3) != 0 else ""
            ea, ea_size = self.decode_ea(opcode & 0x3F, size_str)
            return f"CLR{size_str:4s}{ea}", 2 + ea_size

        # CMPI - Must come before bit operations!
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
        if opcode == 0x46FC:  # MOVE.W #imm,SR
            imm = self.read_word()
            self.offset += 2
            return f"MOVE.W  #${imm:04X},SR", 4

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

        # CMP - Compare (Bxxx)
        if (opcode & 0xF000) == 0xB000:
            reg = (opcode >> 9) & 7
            opmode = (opcode >> 6) & 7
            # opmode: 0=CMP.B, 1=CMP.W, 2=CMP.L, 3=CMPA.W, 7=CMPA.L
            if opmode == 3:  # CMPA.W
                ea, ea_size = self.decode_ea(opcode & 0x3F, ".W")
                return f"CMPA.W  {ea},A{reg}", 2 + ea_size
            elif opmode == 7:  # CMPA.L
                ea, ea_size = self.decode_ea(opcode & 0x3F, ".L")
                return f"CMPA.L  {ea},A{reg}", 2 + ea_size
            else:
                size_map = {0: ".B", 1: ".W", 2: ".L"}
                size_str = size_map.get(opmode, "")
                ea, ea_size = self.decode_ea(opcode & 0x3F, size_str)
                return f"CMP{size_str:4s}{ea},D{reg}", 2 + ea_size

        # ADD/SUB (Dxxx for ADD, 9xxx for SUB)
        if (opcode & 0xF000) == 0xD000 or (opcode & 0xF000) == 0x9000:
            is_add = (opcode & 0xF000) == 0xD000
            op = "ADD" if is_add else "SUB"
            reg = (opcode >> 9) & 7
            opmode = (opcode >> 6) & 7
            size_map = {0: ".B", 1: ".W", 2: ".L", 3: ".W", 7: ".L"}
            size_str = size_map.get(opmode, "")

            # opmode bit 8 determines direction: 0=EA+Dn->Dn, 1=Dn+EA->EA
            if opmode < 3:  # <ea> + Dn -> Dn
                ea, ea_size = self.decode_ea(opcode & 0x3F, size_str)
                return f"{op}{size_str:4s}{ea},D{reg}", 2 + ea_size
            elif opmode == 3 or opmode == 7:  # ADDA/SUBA
                ea, ea_size = self.decode_ea(opcode & 0x3F, size_str)
                return f"{op}A{size_str:3s}{ea},A{reg}", 2 + ea_size
            else:  # Dn + <ea> -> <ea>
                ea, ea_size = self.decode_ea(opcode & 0x3F, size_str)
                return f"{op}{size_str:4s}D{reg},{ea}", 2 + ea_size

        # AND/OR (Cxxx for AND, 8xxx for OR)
        if (opcode & 0xF000) == 0xC000 or (opcode & 0xF000) == 0x8000:
            is_and = (opcode & 0xF000) == 0xC000
            op = "AND" if is_and else "OR"
            reg = (opcode >> 9) & 7
            opmode = (opcode >> 6) & 7
            size_map = {0: ".B", 1: ".W", 2: ".L"}
            size_str = size_map.get(opmode & 3, "")

            if opmode < 4:  # <ea> & Dn -> Dn
                ea, ea_size = self.decode_ea(opcode & 0x3F, size_str)
                return f"{op}{size_str:4s}{ea},D{reg}", 2 + ea_size
            else:  # Dn & <ea> -> <ea>
                ea, ea_size = self.decode_ea(opcode & 0x3F, size_str)
                return f"{op}{size_str:4s}D{reg},{ea}", 2 + ea_size

        # EOR - Exclusive OR (Bxxx with specific opmode)
        if (opcode & 0xF100) == 0xB100:
            reg = (opcode >> 9) & 7
            size = (opcode >> 6) & 3
            size_map = {0: ".B", 1: ".W", 2: ".L"}
            size_str = size_map.get(size, "")
            ea, ea_size = self.decode_ea(opcode & 0x3F, size_str)
            return f"EOR{size_str:4s}D{reg},{ea}", 2 + ea_size

        # ASL/ASR/LSL/LSR shifts (Exxx)
        if (opcode & 0xF000) == 0xE000:
            count_reg = (opcode >> 9) & 7
            direction = (opcode >> 8) & 1  # 0=right, 1=left
            size = (opcode >> 6) & 3
            type_op = (opcode >> 3) & 3  # 0=AS, 1=LS, 2=ROX, 3=RO
            is_reg = (opcode >> 5) & 1
            data_reg = opcode & 7

            size_map = {0: ".B", 1: ".W", 2: ".L"}
            size_str = size_map.get(size, "")
            type_names = ["AS", "LS", "ROX", "RO"]
            dir_str = "L" if direction else "R"
            op_name = type_names[type_op] + dir_str

            if is_reg:  # Register count
                return f"{op_name}{size_str:4s}D{count_reg},D{data_reg}", 2
            else:  # Immediate count
                count = count_reg if count_reg != 0 else 8
                return f"{op_name}{size_str:4s}#{count},D{data_reg}", 2

        # EXT - Sign extend
        if (opcode & 0xFFF8) == 0x4880:  # EXT.W
            reg = opcode & 7
            return f"EXT.W   D{reg}", 2
        if (opcode & 0xFFF8) == 0x48C0:  # EXT.L
            reg = opcode & 7
            return f"EXT.L   D{reg}", 2

        # SWAP - Swap register halves
        if (opcode & 0xFFF8) == 0x4840:
            reg = opcode & 7
            return f"SWAP    D{reg}", 2

        # NEG/NEGX/NOT
        if (opcode & 0xFF00) == 0x4400:  # NEG
            size = (opcode >> 6) & 3
            size_map = {0: ".B", 1: ".W", 2: ".L"}
            size_str = size_map.get(size, "")
            ea, ea_size = self.decode_ea(opcode & 0x3F, size_str)
            return f"NEG{size_str:4s}{ea}", 2 + ea_size

        if (opcode & 0xFF00) == 0x4000:  # NEGX
            size = (opcode >> 6) & 3
            size_map = {0: ".B", 1: ".W", 2: ".L"}
            size_str = size_map.get(size, "")
            ea, ea_size = self.decode_ea(opcode & 0x3F, size_str)
            return f"NEGX{size_str:3s}{ea}", 2 + ea_size

        if (opcode & 0xFF00) == 0x4600:  # NOT
            size = (opcode >> 6) & 3
            size_map = {0: ".B", 1: ".W", 2: ".L"}
            size_str = size_map.get(size, "")
            ea, ea_size = self.decode_ea(opcode & 0x3F, size_str)
            return f"NOT{size_str:4s}{ea}", 2 + ea_size

        # MULS/MULU (Cxxx pattern)
        if (opcode & 0xF1C0) == 0xC0C0:  # MULU
            reg = (opcode >> 9) & 7
            ea, ea_size = self.decode_ea(opcode & 0x3F, ".W")
            return f"MULU.W  {ea},D{reg}", 2 + ea_size

        if (opcode & 0xF1C0) == 0xC1C0:  # MULS
            reg = (opcode >> 9) & 7
            ea, ea_size = self.decode_ea(opcode & 0x3F, ".W")
            return f"MULS.W  {ea},D{reg}", 2 + ea_size

        # DIVU/DIVS (8xxx pattern)
        if (opcode & 0xF1C0) == 0x80C0:  # DIVU
            reg = (opcode >> 9) & 7
            ea, ea_size = self.decode_ea(opcode & 0x3F, ".W")
            return f"DIVU.W  {ea},D{reg}", 2 + ea_size

        if (opcode & 0xF1C0) == 0x81C0:  # DIVS
            reg = (opcode >> 9) & 7
            ea, ea_size = self.decode_ea(opcode & 0x3F, ".W")
            return f"DIVS.W  {ea},D{reg}", 2 + ea_size

        # LINK/UNLK
        if (opcode & 0xFFF8) == 0x4E50:  # LINK
            reg = opcode & 7
            disp = self.read_word()
            self.offset += 2
            if disp & 0x8000:
                disp = disp - 0x10000
            return f"LINK    A{reg},#${disp & 0xFFFF:04X}", 4

        if (opcode & 0xFFF8) == 0x4E58:  # UNLK
            reg = opcode & 7
            return f"UNLK    A{reg}", 2

        # PEA - Push Effective Address
        if (opcode & 0xFFC0) == 0x4840:
            ea, ea_size = self.decode_ea(opcode & 0x3F, ".L")
            return f"PEA     {ea}", 2 + ea_size

        # Unknown instruction
        return f"DC.W    ${opcode:04X}  ; Unknown", 2

    def decode_move(self, opcode):
        """Decode MOVE instruction"""
        size = (opcode >> 12) & 3
        size_map = {1: ".B", 3: ".W", 2: ".L"}
        size_str = size_map.get(size, "")

        src_ea, src_size = self.decode_ea(opcode & 0x3F, size_str)

        # Destination: bits 11-9 = register, bits 8-6 = mode
        # EA code format: bits 5-3 = mode, bits 2-0 = register
        dst_mode = (opcode >> 6) & 7
        dst_reg = (opcode >> 9) & 7
        dst_ea_code = (dst_mode << 3) | dst_reg  # mode in upper bits, reg in lower
        dst_ea, dst_size = self.decode_ea(dst_ea_code, size_str)

        return f"MOVE{size_str:4s}{src_ea},{dst_ea}", 2 + src_size + dst_size

    def decode_ea(self, ea_code, size_str):
        """Decode effective address - returns (ea_string, additional_bytes)"""
        # EA encoding: bits 5-3 = mode, bits 2-0 = register
        mode = (ea_code >> 3) & 0x07
        reg = ea_code & 0x07

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
