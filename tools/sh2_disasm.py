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
            return f"MOV.W   @(${target:08X},PC),R{n}", 2

        # MOV.L @(disp,PC),Rn (Dndd)
        if (opcode & 0xF000) == 0xD000:
            n = (opcode >> 8) & 0xF
            disp = (opcode & 0xFF) * 4
            target = (addr & 0xFFFFFFFC) + 4 + disp
            return f"MOV.L   @(${target:08X},PC),R{n}", 2

        # MOV.L Rm,@(disp,Rn) (1nmd) - Store with displacement
        if (opcode & 0xF000) == 0x1000:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            disp = (opcode & 0xF) * 4
            return f"MOV.L   R{m},@(${disp:X},R{n})", 2

        # MOV.L @(disp,Rm),Rn (5nmd) - Load with displacement
        if (opcode & 0xF000) == 0x5000:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            disp = (opcode & 0xF) * 4
            return f"MOV.L   @(${disp:X},R{m}),R{n}", 2

        # MOV.B R0,@(disp,Rn) (80nd-87nd) - Store R0 with displacement
        if (opcode & 0xF800) == 0x8000:
            n = (opcode >> 8) & 0xF
            # Skip if it's a comparison or branch instruction (88-8F)
            if n < 8:
                disp = opcode & 0xF
                return f"MOV.B   R0,@(${disp:X},R{n})", 2

        # MOV.W R0,@(disp,Rn) (81nd-87nd) - Store R0 word with displacement
        if (opcode & 0xF800) == 0x8100:
            n = (opcode >> 8) & 0xF
            # Skip if it's a comparison or branch instruction (88-8F)
            if n < 8:
                disp = (opcode & 0xF) * 2
                return f"MOV.W   R0,@(${disp:X},R{n})", 2

        # MOV.B @(disp,Rm),R0 (84md-87md) - Load R0 with displacement
        if (opcode & 0xFC00) == 0x8400:
            m = (opcode >> 4) & 0xF
            disp = opcode & 0xF
            return f"MOV.B   @(${disp:X},R{m}),R0", 2

        # MOV.W @(disp,Rm),R0 (85md-87md) - Load R0 word with displacement
        if (opcode & 0xFC00) == 0x8500:
            m = (opcode >> 4) & 0xF
            disp = (opcode & 0xF) * 2
            return f"MOV.W   @(${disp:X},R{m}),R0", 2

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

        # BT/S disp (8Ddd) - Branch if True with delay slot
        if (opcode & 0xFF00) == 0x8D00:
            disp = opcode & 0xFF
            if disp & 0x80:
                disp = disp - 256
            target = addr + 4 + (disp * 2)
            return f"BT/S    ${target:08X}", 2

        # BF/S disp (8Fdd) - Branch if False with delay slot
        if (opcode & 0xFF00) == 0x8F00:
            disp = opcode & 0xFF
            if disp & 0x80:
                disp = disp - 256
            target = addr + 4 + (disp * 2)
            return f"BF/S    ${target:08X}", 2

        # CMP/EQ #imm,R0 (88ii)
        if (opcode & 0xFF00) == 0x8800:
            imm = opcode & 0xFF
            return f"CMP/EQ  #${imm:02X},R0", 2

        # === Arithmetic Operations ===

        # SUB Rm,Rn (3nm8)
        if (opcode & 0xF00F) == 0x3008:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"SUB     R{m},R{n}", 2

        # SUBC Rm,Rn (3nma) - Subtract with carry
        if (opcode & 0xF00F) == 0x300A:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"SUBC    R{m},R{n}", 2

        # SUBV Rm,Rn (3nmb) - Subtract with overflow check
        if (opcode & 0xF00F) == 0x300B:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"SUBV    R{m},R{n}", 2

        # ADDC Rm,Rn (30me) - Add with carry
        if (opcode & 0xF00F) == 0x300E:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"ADDC    R{m},R{n}", 2

        # ADDV Rm,Rn (30mf) - Add with overflow check
        if (opcode & 0xF00F) == 0x300F:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"ADDV    R{m},R{n}", 2

        # === Comparison Operations ===

        # CMP/EQ Rm,Rn (3nm0)
        if (opcode & 0xF00F) == 0x3000:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"CMP/EQ  R{m},R{n}", 2

        # CMP/HS Rm,Rn (3nm2) - Compare unsigned >=
        if (opcode & 0xF00F) == 0x3002:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"CMP/HS  R{m},R{n}", 2

        # CMP/GE Rm,Rn (3nm3) - Compare signed >=
        if (opcode & 0xF00F) == 0x3003:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"CMP/GE  R{m},R{n}", 2

        # CMP/HI Rm,Rn (3nm6) - Compare unsigned >
        if (opcode & 0xF00F) == 0x3006:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"CMP/HI  R{m},R{n}", 2

        # CMP/GT Rm,Rn (3nm7) - Compare signed >
        if (opcode & 0xF00F) == 0x3007:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"CMP/GT  R{m},R{n}", 2

        # CMP/PZ Rn (4n11) - Compare with zero (>= 0)
        if (opcode & 0xF0FF) == 0x4011:
            n = (opcode >> 8) & 0xF
            return f"CMP/PZ  R{n}", 2

        # CMP/PL Rn (4n15) - Compare with zero (> 0)
        if (opcode & 0xF0FF) == 0x4015:
            n = (opcode >> 8) & 0xF
            return f"CMP/PL  R{n}", 2

        # === Logic Operations ===

        # AND Rm,Rn (2nm9)
        if (opcode & 0xF00F) == 0x2009:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"AND     R{m},R{n}", 2

        # OR Rm,Rn (2nmb)
        if (opcode & 0xF00F) == 0x200B:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"OR      R{m},R{n}", 2

        # XOR Rm,Rn (2nma)
        if (opcode & 0xF00F) == 0x200A:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"XOR     R{m},R{n}", 2

        # NOT Rm,Rn (6nm7)
        if (opcode & 0xF00F) == 0x6007:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"NOT     R{m},R{n}", 2

        # TST Rm,Rn (2nm8)
        if (opcode & 0xF00F) == 0x2008:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"TST     R{m},R{n}", 2

        # === Shift Operations ===

        # SHLL Rn (4n00) - Shift left logical
        if (opcode & 0xF0FF) == 0x4000:
            n = (opcode >> 8) & 0xF
            return f"SHLL    R{n}", 2

        # SHLR Rn (4n01) - Shift right logical
        if (opcode & 0xF0FF) == 0x4001:
            n = (opcode >> 8) & 0xF
            return f"SHLR    R{n}", 2

        # SHAL Rn (4n20) - Shift left arithmetic
        if (opcode & 0xF0FF) == 0x4020:
            n = (opcode >> 8) & 0xF
            return f"SHAL    R{n}", 2

        # SHAR Rn (4n21) - Shift right arithmetic
        if (opcode & 0xF0FF) == 0x4021:
            n = (opcode >> 8) & 0xF
            return f"SHAR    R{n}", 2

        # ROTL Rn (4n04) - Rotate left
        if (opcode & 0xF0FF) == 0x4004:
            n = (opcode >> 8) & 0xF
            return f"ROTL    R{n}", 2

        # ROTR Rn (4n05) - Rotate right
        if (opcode & 0xF0FF) == 0x4005:
            n = (opcode >> 8) & 0xF
            return f"ROTR    R{n}", 2

        # ROTCL Rn (4n24) - Rotate left through carry
        if (opcode & 0xF0FF) == 0x4024:
            n = (opcode >> 8) & 0xF
            return f"ROTCL   R{n}", 2

        # ROTCR Rn (4n25) - Rotate right through carry
        if (opcode & 0xF0FF) == 0x4025:
            n = (opcode >> 8) & 0xF
            return f"ROTCR   R{n}", 2

        # SHLL2 Rn (4n08) - Shift left logical 2
        if (opcode & 0xF0FF) == 0x4008:
            n = (opcode >> 8) & 0xF
            return f"SHLL2   R{n}", 2

        # SHLR2 Rn (4n09) - Shift right logical 2
        if (opcode & 0xF0FF) == 0x4009:
            n = (opcode >> 8) & 0xF
            return f"SHLR2   R{n}", 2

        # SHLL8 Rn (4n18) - Shift left logical 8
        if (opcode & 0xF0FF) == 0x4018:
            n = (opcode >> 8) & 0xF
            return f"SHLL8   R{n}", 2

        # SHLR8 Rn (4n19) - Shift right logical 8
        if (opcode & 0xF0FF) == 0x4019:
            n = (opcode >> 8) & 0xF
            return f"SHLR8   R{n}", 2

        # SHLL16 Rn (4n28) - Shift left logical 16
        if (opcode & 0xF0FF) == 0x4028:
            n = (opcode >> 8) & 0xF
            return f"SHLL16  R{n}", 2

        # SHLR16 Rn (4n29) - Shift right logical 16
        if (opcode & 0xF0FF) == 0x4029:
            n = (opcode >> 8) & 0xF
            return f"SHLR16  R{n}", 2

        # === Extension/Swap Operations ===

        # EXTU.B Rm,Rn (6nmc) - Zero-extend byte
        if (opcode & 0xF00F) == 0x600C:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"EXTU.B  R{m},R{n}", 2

        # EXTU.W Rm,Rn (6nmd) - Zero-extend word
        if (opcode & 0xF00F) == 0x600D:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"EXTU.W  R{m},R{n}", 2

        # EXTS.B Rm,Rn (6nme) - Sign-extend byte
        if (opcode & 0xF00F) == 0x600E:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"EXTS.B  R{m},R{n}", 2

        # EXTS.W Rm,Rn (6nmf) - Sign-extend word
        if (opcode & 0xF00F) == 0x600F:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"EXTS.W  R{m},R{n}", 2

        # SWAP.B Rm,Rn (6nm8) - Swap bytes
        if (opcode & 0xF00F) == 0x6008:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"SWAP.B  R{m},R{n}", 2

        # SWAP.W Rm,Rn (6nm9) - Swap words
        if (opcode & 0xF00F) == 0x6009:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"SWAP.W  R{m},R{n}", 2

        # XTRCT Rm,Rn (2nmd) - Extract
        if (opcode & 0xF00F) == 0x200D:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"XTRCT   R{m},R{n}", 2

        # === Negate Operations ===

        # NEG Rm,Rn (6nmb)
        if (opcode & 0xF00F) == 0x600B:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"NEG     R{m},R{n}", 2

        # NEGC Rm,Rn (6nma) - Negate with carry
        if (opcode & 0xF00F) == 0x600A:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"NEGC    R{m},R{n}", 2

        # === Control Flow ===

        # DT Rn (4n10) - Decrement and test
        if (opcode & 0xF0FF) == 0x4010:
            n = (opcode >> 8) & 0xF
            return f"DT      R{n}", 2

        # JMP @Rn (4n2b)
        if (opcode & 0xF0FF) == 0x402B:
            n = (opcode >> 8) & 0xF
            return f"JMP     @R{n}", 2

        # JSR @Rn (4n0b)
        if (opcode & 0xF0FF) == 0x400B:
            n = (opcode >> 8) & 0xF
            return f"JSR     @R{n}", 2

        # === Special Registers ===

        # LDC Rm,VBR (4nm0e) - Load to VBR (Vector Base Register)
        if (opcode & 0xF0FF) == 0x400E:
            m = (opcode >> 8) & 0xF
            return f"LDC     R{m},VBR", 2

        # STC VBR,Rn (0n02) - Store from VBR
        if (opcode & 0xF0FF) == 0x0002:
            n = (opcode >> 8) & 0xF
            return f"STC     VBR,R{n}", 2

        # LDC Rm,GBR (4nm1e) - Load to GBR (Global Base Register)
        if (opcode & 0xF0FF) == 0x401E:
            m = (opcode >> 8) & 0xF
            return f"LDC     R{m},GBR", 2

        # STC GBR,Rn (0n12) - Store from GBR
        if (opcode & 0xF0FF) == 0x0012:
            n = (opcode >> 8) & 0xF
            return f"STC     GBR,R{n}", 2

        # LDC Rm,SR (4nm0f) - Load to SR (Status Register)
        if (opcode & 0xF0FF) == 0x400F:
            m = (opcode >> 8) & 0xF
            return f"LDC     R{m},SR", 2

        # STC SR,Rn (0n03) - Store from SR
        if (opcode & 0xF0FF) == 0x0003:
            n = (opcode >> 8) & 0xF
            return f"STC     SR,R{n}", 2

        # LDS Rm,PR (4nm2a) - Load to PR
        if (opcode & 0xF0FF) == 0x402A:
            m = (opcode >> 8) & 0xF
            return f"LDS     R{m},PR", 2

        # STS PR,Rn (0n2a) - Store from PR
        if (opcode & 0xF0FF) == 0x002A:
            n = (opcode >> 8) & 0xF
            return f"STS     PR,R{n}", 2

        # LDS Rm,MACH (4nm0a) - Load to MACH
        if (opcode & 0xF0FF) == 0x400A:
            m = (opcode >> 8) & 0xF
            return f"LDS     R{m},MACH", 2

        # LDS Rm,MACL (4nm1a) - Load to MACL
        if (opcode & 0xF0FF) == 0x401A:
            m = (opcode >> 8) & 0xF
            return f"LDS     R{m},MACL", 2

        # STS MACH,Rn (0n0a) - Store from MACH
        if (opcode & 0xF0FF) == 0x000A:
            n = (opcode >> 8) & 0xF
            return f"STS     MACH,R{n}", 2

        # STS MACL,Rn (0n1a) - Store from MACL
        if (opcode & 0xF0FF) == 0x001A:
            n = (opcode >> 8) & 0xF
            return f"STS     MACL,R{n}", 2

        # STS.L PR,@-Rn (4n22) - Push PR to stack
        if (opcode & 0xF0FF) == 0x4022:
            n = (opcode >> 8) & 0xF
            if n == 15:  # R15 is stack pointer
                return f"STS.L   PR,@-R15    ; Push PR", 2
            return f"STS.L   PR,@-R{n}", 2

        # LDS.L @Rm+,PR (4n26) - Pop PR from stack
        if (opcode & 0xF0FF) == 0x4026:
            m = (opcode >> 8) & 0xF
            if m == 15:  # R15 is stack pointer
                return f"LDS.L   @R15+,PR    ; Pop PR", 2
            return f"LDS.L   @R{m}+,PR", 2

        # === Multiply Operations ===

        # MULU.W Rm,Rn (2nme) - Multiply unsigned word
        if (opcode & 0xF00F) == 0x200E:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"MULU.W  R{m},R{n}", 2

        # MULS.W Rm,Rn (2nmf) - Multiply signed word
        if (opcode & 0xF00F) == 0x200F:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"MULS.W  R{m},R{n}", 2

        # MAC.L @Rm+,@Rn+ (0nmf) - Multiply-accumulate long
        if (opcode & 0xF00F) == 0x000F:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"MAC.L   @R{m}+,@R{n}+", 2

        # MAC.W @Rm+,@Rn+ (4nmf) - Multiply-accumulate word
        if (opcode & 0xF00F) == 0x400F:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            return f"MAC.W   @R{m}+,@R{n}+", 2

        # MOV.W @Rm+,Rn (6nm5) - already defined but listing for completeness
        # MOV.L @Rm+,Rn (6nm6) - already defined

        # MOV.L Rm,@-Rn (2FE6) - Push to stack (common pattern)
        if (opcode & 0xF00F) == 0x2006:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            if n == 15:  # R15 is stack pointer
                return f"MOV.L   R{m},@-R15  ; Push R{m}", 2
            return f"MOV.L   R{m},@-R{n}", 2

        # MOV.L @Rm+,Rn (6XF6) - Pop from stack (common pattern)
        if (opcode & 0xF00F) == 0x6006:
            n = (opcode >> 8) & 0xF
            m = (opcode >> 4) & 0xF
            if m == 15:  # R15 is stack pointer
                return f"MOV.L   @R15+,R{n}  ; Pop R{n}", 2
            return f"MOV.L   @R{m}+,R{n}", 2

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
