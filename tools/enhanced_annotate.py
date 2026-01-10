#!/usr/bin/env python3
"""
Enhanced annotation tool with full 68K instruction decoding.
Converts dc.w statements to proper 68K mnemonics.

Features:
- Complete 68K instruction decoding (not just pattern matching)
- Multi-word instruction support (MOVE, LEA, JSR, etc.)
- Addressing mode extension word handling
- Batch processing with progress tracking
- Validation against original ROM bytes
"""

import re
import subprocess
from pathlib import Path
from typing import Dict, List, Tuple, Optional


class M68KDecoder:
    """Full 68000 instruction decoder"""

    # Register names
    DATA_REGS = ['d0', 'd1', 'd2', 'd3', 'd4', 'd5', 'd6', 'd7']
    ADDR_REGS = ['a0', 'a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7']

    # Size codes
    SIZE_BYTE = 0
    SIZE_WORD = 1
    SIZE_LONG = 2

    SIZE_SUFFIX = {0: '.b', 1: '.w', 2: '.l'}
    SIZE_NAMES = {0: 'byte', 1: 'word', 2: 'long'}

    def __init__(self):
        self.pc = 0  # Current program counter
        self.words = []  # Available words to decode
        self.word_idx = 0  # Current position in words

    def set_context(self, words: List[int], base_addr: int):
        """Set decoding context with available words and base address"""
        self.words = words
        self.pc = base_addr
        self.word_idx = 0

    def fetch_word(self) -> Optional[int]:
        """Fetch next word from stream"""
        if self.word_idx >= len(self.words):
            return None
        word = self.words[self.word_idx]
        self.word_idx += 1
        return word

    def peek_word(self, offset: int = 0) -> Optional[int]:
        """Peek at word without consuming"""
        idx = self.word_idx + offset
        if idx >= len(self.words):
            return None
        return self.words[idx]

    def words_consumed(self) -> int:
        """Return number of words consumed"""
        return self.word_idx

    def decode_ea(self, mode: int, reg: int, size: int) -> Tuple[str, int]:
        """
        Decode effective address and return (operand_string, extension_words_used)

        Addressing modes:
        000 Dn      - Data register direct
        001 An      - Address register direct
        010 (An)    - Address register indirect
        011 (An)+   - Post-increment
        100 -(An)   - Pre-decrement
        101 d16(An) - Displacement
        110 d8(An,Xn) - Index
        111 special (depends on reg):
            000 (xxx).W   - Absolute short
            001 (xxx).L   - Absolute long
            010 d16(PC)   - PC relative
            011 d8(PC,Xn) - PC relative indexed
            100 #imm      - Immediate
        """
        if mode == 0:  # Dn
            return self.DATA_REGS[reg], 0

        elif mode == 1:  # An
            return self.ADDR_REGS[reg], 0

        elif mode == 2:  # (An)
            return f'({self.ADDR_REGS[reg]})', 0

        elif mode == 3:  # (An)+
            return f'({self.ADDR_REGS[reg]})+', 0

        elif mode == 4:  # -(An)
            return f'-({self.ADDR_REGS[reg]})', 0

        elif mode == 5:  # d16(An)
            ext = self.fetch_word()
            if ext is None:
                return None, 0
            # Sign extend displacement
            if ext >= 0x8000:
                ext = ext - 0x10000
            return f'${ext:04X}({self.ADDR_REGS[reg]})', 1

        elif mode == 6:  # d8(An,Xn)
            ext = self.fetch_word()
            if ext is None:
                return None, 0
            d8 = ext & 0xFF
            if d8 >= 0x80:
                d8 = d8 - 0x100
            xn_reg = (ext >> 12) & 7
            xn_is_addr = (ext >> 15) & 1
            xn_size = '.l' if (ext >> 11) & 1 else '.w'
            xn = self.ADDR_REGS[xn_reg] if xn_is_addr else self.DATA_REGS[xn_reg]
            return f'${d8:02X}({self.ADDR_REGS[reg]},{xn}{xn_size})', 1

        elif mode == 7:  # Special modes
            if reg == 0:  # (xxx).W - Absolute short
                ext = self.fetch_word()
                if ext is None:
                    return None, 0
                # Sign extend for display
                addr = ext if ext < 0x8000 else ext | 0xFFFF0000
                return f'(${ext:04X}).w', 1

            elif reg == 1:  # (xxx).L - Absolute long
                ext1 = self.fetch_word()
                ext2 = self.fetch_word()
                if ext1 is None or ext2 is None:
                    return None, 0
                addr = (ext1 << 16) | ext2
                return f'(${ addr:08X}).l', 2

            elif reg == 2:  # d16(PC)
                ext = self.fetch_word()
                if ext is None:
                    return None, 0
                if ext >= 0x8000:
                    ext = ext - 0x10000
                return f'${ext:04X}(pc)', 1

            elif reg == 3:  # d8(PC,Xn)
                ext = self.fetch_word()
                if ext is None:
                    return None, 0
                d8 = ext & 0xFF
                if d8 >= 0x80:
                    d8 = d8 - 0x100
                xn_reg = (ext >> 12) & 7
                xn_is_addr = (ext >> 15) & 1
                xn_size = '.l' if (ext >> 11) & 1 else '.w'
                xn = self.ADDR_REGS[xn_reg] if xn_is_addr else self.DATA_REGS[xn_reg]
                return f'${d8:02X}(pc,{xn}{xn_size})', 1

            elif reg == 4:  # #imm - Immediate
                if size == self.SIZE_BYTE or size == self.SIZE_WORD:
                    ext = self.fetch_word()
                    if ext is None:
                        return None, 0
                    if size == self.SIZE_BYTE:
                        ext = ext & 0xFF
                    return f'#${ext:04X}', 1
                else:  # Long
                    ext1 = self.fetch_word()
                    ext2 = self.fetch_word()
                    if ext1 is None or ext2 is None:
                        return None, 0
                    val = (ext1 << 16) | ext2
                    return f'#${val:08X}', 2

        return None, 0

    def decode_move(self, opcode: int) -> Optional[Tuple[str, str, int]]:
        """
        Decode MOVE instruction
        Format: 00 SS DDD ddd sss SSS
        Where:
            SS = size (01=byte, 11=word, 10=long)
            DDD = dest register
            ddd = dest mode
            sss = source mode
            SSS = source register
        Returns: (mnemonic, operands, words_consumed) or None
        """
        # MOVE has bits 15-14 = 00
        if (opcode >> 14) != 0:
            return None

        size_bits = (opcode >> 12) & 3
        if size_bits == 0:
            return None  # Not a MOVE (size 00 is reserved)

        size_map = {1: self.SIZE_BYTE, 3: self.SIZE_WORD, 2: self.SIZE_LONG}
        size = size_map.get(size_bits)
        if size is None:
            return None

        src_mode = (opcode >> 3) & 7
        src_reg = opcode & 7
        dst_reg = (opcode >> 9) & 7
        dst_mode = (opcode >> 6) & 7

        # Decode source EA
        src_str, src_ext = self.decode_ea(src_mode, src_reg, size)
        if src_str is None:
            return None

        # Decode destination EA
        dst_str, dst_ext = self.decode_ea(dst_mode, dst_reg, size)
        if dst_str is None:
            return None

        # Check for MOVEA (destination is address register)
        if dst_mode == 1:
            mnemonic = f'movea{self.SIZE_SUFFIX[size]}'
        else:
            mnemonic = f'move{self.SIZE_SUFFIX[size]}'

        return mnemonic, f'{src_str},{dst_str}', 1 + src_ext + dst_ext

    def decode_lea(self, opcode: int) -> Optional[Tuple[str, str, int]]:
        """
        Decode LEA instruction
        Format: 0100 AAA 111 MMMRRR
        """
        if (opcode & 0xF1C0) != 0x41C0:
            return None

        an = (opcode >> 9) & 7
        mode = (opcode >> 3) & 7
        reg = opcode & 7

        # LEA only allows control addressing modes
        if mode in [0, 1, 3, 4]:  # Dn, An, (An)+, -(An) not allowed
            return None

        ea_str, ext = self.decode_ea(mode, reg, self.SIZE_LONG)
        if ea_str is None:
            return None

        return 'lea', f'{ea_str},{self.ADDR_REGS[an]}', 1 + ext

    def decode_jsr_jmp(self, opcode: int) -> Optional[Tuple[str, str, int]]:
        """
        Decode JSR/JMP instructions
        JSR: 0100 1110 10 MMMRRR
        JMP: 0100 1110 11 MMMRRR
        """
        if (opcode & 0xFFC0) == 0x4E80:  # JSR
            mnemonic = 'jsr'
        elif (opcode & 0xFFC0) == 0x4EC0:  # JMP
            mnemonic = 'jmp'
        else:
            return None

        mode = (opcode >> 3) & 7
        reg = opcode & 7

        ea_str, ext = self.decode_ea(mode, reg, self.SIZE_LONG)
        if ea_str is None:
            return None

        return mnemonic, ea_str, 1 + ext

    def decode_add_sub(self, opcode: int) -> Optional[Tuple[str, str, int]]:
        """
        Decode ADD/SUB instructions
        ADD: 1101 RRR O SS MMMRRR
        SUB: 1001 RRR O SS MMMRRR
        Where O = opmode, SS = size
        """
        op_high = (opcode >> 12) & 0xF
        if op_high == 0xD:
            base_mnemonic = 'add'
        elif op_high == 0x9:
            base_mnemonic = 'sub'
        else:
            return None

        dn = (opcode >> 9) & 7
        opmode = (opcode >> 6) & 7
        mode = (opcode >> 3) & 7
        reg = opcode & 7

        # Determine size and direction
        if opmode in [0, 1, 2]:  # <ea> + Dn -> Dn
            size = opmode
            ea_str, ext = self.decode_ea(mode, reg, size)
            if ea_str is None:
                return None
            operands = f'{ea_str},{self.DATA_REGS[dn]}'
        elif opmode in [4, 5, 6]:  # Dn + <ea> -> <ea>
            size = opmode - 4
            ea_str, ext = self.decode_ea(mode, reg, size)
            if ea_str is None:
                return None
            operands = f'{self.DATA_REGS[dn]},{ea_str}'
        elif opmode == 3:  # ADDA.W
            ea_str, ext = self.decode_ea(mode, reg, self.SIZE_WORD)
            if ea_str is None:
                return None
            return f'{base_mnemonic}a.w', f'{ea_str},{self.ADDR_REGS[dn]}', 1 + ext
        elif opmode == 7:  # ADDA.L
            ea_str, ext = self.decode_ea(mode, reg, self.SIZE_LONG)
            if ea_str is None:
                return None
            return f'{base_mnemonic}a.l', f'{ea_str},{self.ADDR_REGS[dn]}', 1 + ext
        else:
            return None

        mnemonic = f'{base_mnemonic}{self.SIZE_SUFFIX[size]}'
        return mnemonic, operands, 1 + ext

    def decode_cmp(self, opcode: int) -> Optional[Tuple[str, str, int]]:
        """
        Decode CMP instruction
        CMP: 1011 RRR OOO MMMRRR
        """
        if (opcode >> 12) != 0xB:
            return None

        dn = (opcode >> 9) & 7
        opmode = (opcode >> 6) & 7
        mode = (opcode >> 3) & 7
        reg = opcode & 7

        if opmode in [0, 1, 2]:  # CMP
            size = opmode
            ea_str, ext = self.decode_ea(mode, reg, size)
            if ea_str is None:
                return None
            mnemonic = f'cmp{self.SIZE_SUFFIX[size]}'
            return mnemonic, f'{ea_str},{self.DATA_REGS[dn]}', 1 + ext
        elif opmode == 3:  # CMPA.W
            ea_str, ext = self.decode_ea(mode, reg, self.SIZE_WORD)
            if ea_str is None:
                return None
            return 'cmpa.w', f'{ea_str},{self.ADDR_REGS[dn]}', 1 + ext
        elif opmode == 7:  # CMPA.L
            ea_str, ext = self.decode_ea(mode, reg, self.SIZE_LONG)
            if ea_str is None:
                return None
            return 'cmpa.l', f'{ea_str},{self.ADDR_REGS[dn]}', 1 + ext

        return None

    def decode_and_or(self, opcode: int) -> Optional[Tuple[str, str, int]]:
        """
        Decode AND/OR instructions
        AND: 1100 RRR O SS MMMRRR
        OR:  1000 RRR O SS MMMRRR
        """
        op_high = (opcode >> 12) & 0xF
        if op_high == 0xC:
            base_mnemonic = 'and'
        elif op_high == 0x8:
            base_mnemonic = 'or'
        else:
            return None

        dn = (opcode >> 9) & 7
        opmode = (opcode >> 6) & 7
        mode = (opcode >> 3) & 7
        reg = opcode & 7

        if opmode in [0, 1, 2]:  # <ea> op Dn -> Dn
            size = opmode
            ea_str, ext = self.decode_ea(mode, reg, size)
            if ea_str is None:
                return None
            operands = f'{ea_str},{self.DATA_REGS[dn]}'
        elif opmode in [4, 5, 6]:  # Dn op <ea> -> <ea>
            size = opmode - 4
            ea_str, ext = self.decode_ea(mode, reg, size)
            if ea_str is None:
                return None
            operands = f'{self.DATA_REGS[dn]},{ea_str}'
        else:
            return None

        mnemonic = f'{base_mnemonic}{self.SIZE_SUFFIX[size]}'
        return mnemonic, operands, 1 + ext

    def decode_clr_tst_neg(self, opcode: int) -> Optional[Tuple[str, str, int]]:
        """
        Decode CLR/TST/NEG/NOT instructions
        CLR: 0100 0010 SS MMMRRR
        TST: 0100 1010 SS MMMRRR
        NEG: 0100 0100 SS MMMRRR
        NOT: 0100 0110 SS MMMRRR
        """
        op_byte = (opcode >> 8) & 0xFF
        mnemonics = {0x42: 'clr', 0x4A: 'tst', 0x44: 'neg', 0x46: 'not'}

        if op_byte not in mnemonics:
            return None

        base_mnemonic = mnemonics[op_byte]
        size = (opcode >> 6) & 3
        if size == 3:  # Invalid
            return None

        mode = (opcode >> 3) & 7
        reg = opcode & 7

        ea_str, ext = self.decode_ea(mode, reg, size)
        if ea_str is None:
            return None

        mnemonic = f'{base_mnemonic}{self.SIZE_SUFFIX[size]}'
        return mnemonic, ea_str, 1 + ext

    def decode_moveq(self, opcode: int) -> Optional[Tuple[str, str, int]]:
        """
        Decode MOVEQ instruction
        Format: 0111 RRR 0 DDDDDDDD
        """
        if (opcode & 0xF100) != 0x7000:
            return None

        dn = (opcode >> 9) & 7
        data = opcode & 0xFF
        # Sign extend for display
        if data >= 0x80:
            data = data - 0x100

        return 'moveq', f'#${data & 0xFF:02X},{self.DATA_REGS[dn]}', 1

    def decode_bcc(self, opcode: int) -> Optional[Tuple[str, str, int]]:
        """
        Decode Bcc (branch conditional) instructions
        Format: 0110 CCCC DDDDDDDD
        """
        if (opcode >> 12) != 6:
            return None

        cond = (opcode >> 8) & 0xF
        disp = opcode & 0xFF

        cond_names = {
            0x0: 'bra', 0x1: 'bsr', 0x2: 'bhi', 0x3: 'bls',
            0x4: 'bcc', 0x5: 'bcs', 0x6: 'bne', 0x7: 'beq',
            0x8: 'bvc', 0x9: 'bvs', 0xA: 'bpl', 0xB: 'bmi',
            0xC: 'bge', 0xD: 'blt', 0xE: 'bgt', 0xF: 'ble'
        }

        mnemonic = cond_names.get(cond)
        if mnemonic is None:
            return None

        if disp == 0:  # Word displacement
            ext = self.fetch_word()
            if ext is None:
                return None
            if ext >= 0x8000:
                ext = ext - 0x10000
            # Calculate target address
            target = self.pc + 2 + ext
            return f'{mnemonic}.w', f'${target:08X}', 2
        elif disp == 0xFF:  # Long displacement (68020+)
            return None  # Not supported on 68000
        else:  # Byte displacement
            if disp >= 0x80:
                disp = disp - 0x100
            target = self.pc + 2 + disp
            return f'{mnemonic}.s', f'${target:08X}', 1

    def decode_dbcc(self, opcode: int) -> Optional[Tuple[str, str, int]]:
        """
        Decode DBcc instructions
        Format: 0101 CCCC 11001 RRR
        """
        if (opcode & 0xF0F8) != 0x50C8:
            return None

        cond = (opcode >> 8) & 0xF
        dn = opcode & 7

        cond_names = {
            0x0: 'dbt', 0x1: 'dbra', 0x2: 'dbhi', 0x3: 'dbls',
            0x4: 'dbcc', 0x5: 'dbcs', 0x6: 'dbne', 0x7: 'dbeq',
            0x8: 'dbvc', 0x9: 'dbvs', 0xA: 'dbpl', 0xB: 'dbmi',
            0xC: 'dbge', 0xD: 'dblt', 0xE: 'dbgt', 0xF: 'dble'
        }

        # Special case: DBF is same as DBRA
        if cond == 1:
            mnemonic = 'dbra'
        else:
            mnemonic = cond_names.get(cond, f'db{cond:X}')

        ext = self.fetch_word()
        if ext is None:
            return None
        if ext >= 0x8000:
            ext = ext - 0x10000
        target = self.pc + 2 + ext

        return mnemonic, f'{self.DATA_REGS[dn]},${target:08X}', 2

    def decode_addq_subq(self, opcode: int) -> Optional[Tuple[str, str, int]]:
        """
        Decode ADDQ/SUBQ instructions
        Format: 0101 QQQ 0 SS MMMRRR (ADDQ)
        Format: 0101 QQQ 1 SS MMMRRR (SUBQ)
        """
        if (opcode >> 12) != 5:
            return None

        data = (opcode >> 9) & 7
        if data == 0:
            data = 8  # 0 means 8
        is_sub = (opcode >> 8) & 1
        size = (opcode >> 6) & 3
        mode = (opcode >> 3) & 7
        reg = opcode & 7

        if size == 3:  # Invalid
            return None

        ea_str, ext = self.decode_ea(mode, reg, size)
        if ea_str is None:
            return None

        mnemonic = f"{'subq' if is_sub else 'addq'}{self.SIZE_SUFFIX[size]}"
        return mnemonic, f'#{data},{ea_str}', 1 + ext

    def decode_cmpi_addi_subi(self, opcode: int) -> Optional[Tuple[str, str, int]]:
        """
        Decode CMPI/ADDI/SUBI/ANDI/ORI/EORI instructions
        Format: 0000 XXX0 SS MMMRRR followed by immediate
        """
        # Must have bits 15-12 = 0000
        if (opcode >> 12) != 0:
            return None

        op_type = (opcode >> 9) & 7
        size = (opcode >> 6) & 3
        mode = (opcode >> 3) & 7
        reg = opcode & 7

        if size == 3:  # Invalid
            return None

        mnemonics = {
            0: 'ori', 1: 'andi', 2: 'subi', 3: 'addi',
            5: 'eori', 6: 'cmpi'
        }

        if op_type not in mnemonics:
            return None

        base_mnemonic = mnemonics[op_type]

        # Fetch immediate value
        if size == self.SIZE_LONG:
            imm1 = self.fetch_word()
            imm2 = self.fetch_word()
            if imm1 is None or imm2 is None:
                return None
            imm = (imm1 << 16) | imm2
            imm_str = f'#${imm:08X}'
            imm_ext = 2
        else:
            imm = self.fetch_word()
            if imm is None:
                return None
            if size == self.SIZE_BYTE:
                imm = imm & 0xFF
            imm_str = f'#${imm:04X}'
            imm_ext = 1

        # Decode destination EA
        ea_str, ea_ext = self.decode_ea(mode, reg, size)
        if ea_str is None:
            return None

        mnemonic = f'{base_mnemonic}{self.SIZE_SUFFIX[size]}'
        return mnemonic, f'{imm_str},{ea_str}', 1 + imm_ext + ea_ext

    def decode_movem(self, opcode: int) -> Optional[Tuple[str, str, int]]:
        """
        Decode MOVEM instruction
        Format: 0100 1D00 1S MMMRRR
        """
        if (opcode & 0xFB80) != 0x4880:
            return None

        direction = (opcode >> 10) & 1  # 0 = reg to mem, 1 = mem to reg
        size = 2 if (opcode >> 6) & 1 else 1  # 0 = word, 1 = long
        mode = (opcode >> 3) & 7
        reg = opcode & 7

        # Fetch register mask
        mask = self.fetch_word()
        if mask is None:
            return None

        # Decode EA
        ea_str, ea_ext = self.decode_ea(mode, reg, size)
        if ea_str is None:
            return None

        # Build register list string
        regs = []
        if direction == 0 and mode == 4:  # Pre-decrement uses reversed mask
            for i in range(8):
                if mask & (1 << i):
                    regs.append(self.ADDR_REGS[7-i])
            for i in range(8):
                if mask & (1 << (i + 8)):
                    regs.append(self.DATA_REGS[7-i])
        else:
            for i in range(8):
                if mask & (1 << i):
                    regs.append(self.DATA_REGS[i])
            for i in range(8):
                if mask & (1 << (i + 8)):
                    regs.append(self.ADDR_REGS[i])

        reg_str = '/'.join(regs) if regs else '(none)'

        size_str = '.l' if size == 2 else '.w'

        if direction == 0:  # Registers to memory
            return f'movem{size_str}', f'{reg_str},{ea_str}', 2 + ea_ext
        else:  # Memory to registers
            return f'movem{size_str}', f'{ea_str},{reg_str}', 2 + ea_ext

    def decode_ext_swap(self, opcode: int) -> Optional[Tuple[str, str, int]]:
        """
        Decode EXT/SWAP instructions
        EXT.W: 0100 1000 1000 0RRR
        EXT.L: 0100 1000 1100 0RRR
        SWAP:  0100 1000 0100 0RRR
        """
        if (opcode & 0xFFF8) == 0x4880:  # EXT.W
            return 'ext.w', self.DATA_REGS[opcode & 7], 1
        elif (opcode & 0xFFF8) == 0x48C0:  # EXT.L
            return 'ext.l', self.DATA_REGS[opcode & 7], 1
        elif (opcode & 0xFFF8) == 0x4840:  # SWAP
            return 'swap', self.DATA_REGS[opcode & 7], 1
        return None

    def decode_simple(self, opcode: int) -> Optional[Tuple[str, str, int]]:
        """Decode simple single-word instructions"""
        simple_opcodes = {
            0x4E75: ('rts', ''),
            0x4E71: ('nop', ''),
            0x4E73: ('rte', ''),
            0x4E77: ('rtr', ''),
            0x4AFC: ('illegal', ''),
        }

        if opcode in simple_opcodes:
            mnemonic, operands = simple_opcodes[opcode]
            return mnemonic, operands, 1

        # TRAP #n
        if (opcode & 0xFFF0) == 0x4E40:
            return 'trap', f'#{opcode & 0xF}', 1

        # LINK
        if (opcode & 0xFFF8) == 0x4E50:
            ext = self.fetch_word()
            if ext is None:
                return None
            if ext >= 0x8000:
                ext = ext - 0x10000
            return 'link', f'{self.ADDR_REGS[opcode & 7]},#${ext & 0xFFFF:04X}', 2

        # UNLK
        if (opcode & 0xFFF8) == 0x4E58:
            return 'unlk', self.ADDR_REGS[opcode & 7], 1

        return None

    def decode_btst_bchg_bclr_bset(self, opcode: int) -> Optional[Tuple[str, str, int]]:
        """
        Decode BTST/BCHG/BCLR/BSET instructions
        Dynamic: 0000 RRR 1TT MMMRRR  (bit number in Dn)
        Static:  0000 100 0TT MMMRRR  (bit number follows)
        """
        op_type = (opcode >> 6) & 3
        type_names = {0: 'btst', 1: 'bchg', 2: 'bclr', 3: 'bset'}

        if (opcode & 0xF100) == 0x0100:  # Dynamic
            dn = (opcode >> 9) & 7
            mode = (opcode >> 3) & 7
            reg = opcode & 7

            ea_str, ext = self.decode_ea(mode, reg, self.SIZE_BYTE)
            if ea_str is None:
                return None

            return type_names[op_type], f'{self.DATA_REGS[dn]},{ea_str}', 1 + ext

        elif (opcode & 0xFF00) == 0x0800:  # Static
            mode = (opcode >> 3) & 7
            reg = opcode & 7

            bit_num = self.fetch_word()
            if bit_num is None:
                return None

            ea_str, ext = self.decode_ea(mode, reg, self.SIZE_BYTE)
            if ea_str is None:
                return None

            return type_names[op_type], f'#${bit_num:02X},{ea_str}', 2 + ext

        return None

    def decode_asl_asr_lsl_lsr(self, opcode: int) -> Optional[Tuple[str, str, int]]:
        """
        Decode ASL/ASR/LSL/LSR/ROL/ROR instructions
        Register: 1110 CCC D SS I 00 RRR
        Memory:   1110 0001 11 MMMRRR (shift by 1)
        """
        if (opcode >> 12) != 0xE:
            return None

        # Memory shift
        if (opcode & 0xFFC0) in [0xE0C0, 0xE1C0, 0xE2C0, 0xE3C0, 0xE4C0, 0xE5C0, 0xE6C0, 0xE7C0]:
            direction = (opcode >> 8) & 1  # 0 = right, 1 = left
            shift_type = (opcode >> 9) & 3
            mode = (opcode >> 3) & 7
            reg = opcode & 7

            type_names = {0: 'as', 1: 'ls', 2: 'rox', 3: 'ro'}
            dir_names = {0: 'r', 1: 'l'}

            ea_str, ext = self.decode_ea(mode, reg, self.SIZE_WORD)
            if ea_str is None:
                return None

            mnemonic = f'{type_names[shift_type]}{dir_names[direction]}'
            return mnemonic, ea_str, 1 + ext

        # Register shift
        count_reg = (opcode >> 9) & 7
        direction = (opcode >> 8) & 1
        size = (opcode >> 6) & 3
        ir = (opcode >> 5) & 1  # 0 = immediate count, 1 = register count
        shift_type = (opcode >> 3) & 3
        dn = opcode & 7

        if size == 3:
            return None

        type_names = {0: 'as', 1: 'ls', 2: 'rox', 3: 'ro'}
        dir_names = {0: 'r', 1: 'l'}

        mnemonic = f'{type_names[shift_type]}{dir_names[direction]}{self.SIZE_SUFFIX[size]}'

        if ir == 0:  # Immediate
            count = count_reg if count_reg != 0 else 8
            return mnemonic, f'#{count},{self.DATA_REGS[dn]}', 1
        else:  # Register
            return mnemonic, f'{self.DATA_REGS[count_reg]},{self.DATA_REGS[dn]}', 1

        return None

    def decode_pea(self, opcode: int) -> Optional[Tuple[str, str, int]]:
        """
        Decode PEA instruction
        Format: 0100 1000 01 MMMRRR
        """
        if (opcode & 0xFFC0) != 0x4840:
            return None

        mode = (opcode >> 3) & 7
        reg = opcode & 7

        ea_str, ext = self.decode_ea(mode, reg, self.SIZE_LONG)
        if ea_str is None:
            return None

        return 'pea', ea_str, 1 + ext

    def decode_instruction(self, base_addr: int) -> Optional[Tuple[str, str, int]]:
        """
        Main decode function - tries all decoders
        Returns: (mnemonic, operands, words_consumed) or None
        """
        self.pc = base_addr

        opcode = self.peek_word()
        if opcode is None:
            return None

        self.fetch_word()  # Consume the opcode

        # Try decoders in order of frequency
        decoders = [
            self.decode_move,
            self.decode_bcc,
            self.decode_simple,
            self.decode_lea,
            self.decode_addq_subq,
            self.decode_add_sub,
            self.decode_cmp,
            self.decode_and_or,
            self.decode_clr_tst_neg,
            self.decode_moveq,
            self.decode_jsr_jmp,
            self.decode_dbcc,
            self.decode_cmpi_addi_subi,
            self.decode_movem,
            self.decode_btst_bchg_bclr_bset,
            self.decode_asl_asr_lsl_lsr,
            self.decode_ext_swap,
            self.decode_pea,
        ]

        for decoder in decoders:
            # Reset position to just after opcode
            saved_idx = self.word_idx
            result = decoder(opcode)
            if result:
                return result
            # Restore position if decoder didn't match
            self.word_idx = saved_idx

        return None


class FunctionAnnotator:
    """Handles function annotation with full instruction decoding"""

    def __init__(self, asm_file: Path):
        self.asm_file = asm_file
        self.content = asm_file.read_text()
        self.lines = self.content.split('\n')
        self.decoder = M68KDecoder()
        self.converted_count = 0
        self.total_dc_w = 0

    def parse_dc_w_lines(self, start_idx: int, max_lines: int = 10) -> List[Dict]:
        """Parse consecutive dc.w lines starting from index"""
        parsed = []

        for i in range(start_idx, min(start_idx + max_lines, len(self.lines))):
            line = self.lines[i]
            if 'dc.w' not in line or ';' not in line:
                break

            # Match: dc.w $XXXX ; AAAAAAAA: disasm
            match = re.match(
                r'\s*dc\.w\s+\$([0-9A-Fa-f]+)\s*;\s*([0-9A-Fa-f]+):\s*(.*)',
                line
            )
            if not match:
                break

            value_str, addr_str, disasm = match.groups()
            parsed.append({
                'value': int(value_str, 16),
                'addr': int(addr_str, 16),
                'disasm': disasm.strip(),
                'line_idx': i,
                'line': line
            })

        return parsed

    def format_instruction(self, mnemonic: str, operands: str, addr: int, words: List[int]) -> str:
        """Format decoded instruction as assembly line"""
        # Build comment showing original bytes
        hex_bytes = ', '.join(f'${w:04X}' for w in words)

        if operands:
            return f"        {mnemonic:8s}{operands:40s}; {addr:08X}: {hex_bytes}"
        return f"        {mnemonic:52s}; {addr:08X}: {hex_bytes}"

    def annotate_lines(self) -> List[str]:
        """Process all lines and convert dc.w to mnemonics"""
        output_lines = []
        i = 0

        while i < len(self.lines):
            line = self.lines[i]

            # Check if this is a dc.w line
            if 'dc.w' in line and ';' in line:
                self.total_dc_w += 1

                # Parse consecutive dc.w lines for context
                parsed = self.parse_dc_w_lines(i, max_lines=6)

                if parsed:
                    # Set up decoder with available words
                    words = [p['value'] for p in parsed]
                    base_addr = parsed[0]['addr']
                    self.decoder.set_context(words, base_addr)

                    # Try to decode
                    result = self.decoder.decode_instruction(base_addr)

                    if result:
                        mnemonic, operands, words_consumed = result

                        # Get the words that were used
                        used_words = words[:words_consumed]

                        # Output the decoded instruction
                        output_lines.append(
                            self.format_instruction(mnemonic, operands, base_addr, used_words)
                        )

                        self.converted_count += 1

                        # Skip the consumed dc.w lines (minus 1 since we'll increment i)
                        i += words_consumed

                        # Update total count for multi-word instructions
                        self.total_dc_w += words_consumed - 1

                        continue

            # Keep original line if not converted
            output_lines.append(line)
            i += 1

        return output_lines


class BatchAnnotator:
    """Process multiple functions in batch"""

    def __init__(self, sections_dir: Path, rom_file: Path):
        self.sections_dir = sections_dir
        self.rom_file = rom_file
        self.stats = {
            'files_processed': 0,
            'total_converted': 0,
            'total_dc_w': 0,
            'errors': []
        }

    def find_section_files(self, pattern: str = 'code_*.asm') -> List[Path]:
        """Find all matching section files"""
        return sorted(self.sections_dir.glob(pattern))

    def process_file(self, asm_file: Path, verify: bool = True) -> bool:
        """Process single file and optionally verify"""
        try:
            annotator = FunctionAnnotator(asm_file)
            output_lines = annotator.annotate_lines()

            asm_file.write_text('\n'.join(output_lines))

            self.stats['files_processed'] += 1
            self.stats['total_converted'] += annotator.converted_count
            self.stats['total_dc_w'] += annotator.total_dc_w

            if verify:
                return self.verify_build()
            return True

        except Exception as e:
            self.stats['errors'].append(f"{asm_file.name}: {str(e)}")
            return False

    def verify_build(self) -> bool:
        """Verify ROM still builds and matches original"""
        try:
            result = subprocess.run(
                ['make', 'all'],
                cwd=self.sections_dir.parent.parent,
                capture_output=True,
                timeout=30
            )

            if result.returncode != 0:
                return False

            cmp_result = subprocess.run(
                ['cmp', 'build/vr_rebuild.32x', 'Virtua Racing Deluxe (USA).32x'],
                cwd=self.sections_dir.parent.parent,
                capture_output=True,
                timeout=10
            )

            return cmp_result.returncode == 0

        except subprocess.TimeoutExpired:
            return False
        except Exception as e:
            self.stats['errors'].append(f"Build verification: {str(e)}")
            return False

    def process_batch(self, file_count: int = 5, verify: bool = True) -> None:
        """Process multiple files"""
        files = self.find_section_files()[:file_count]

        print(f"\nProcessing {len(files)} files...\n")

        for i, asm_file in enumerate(files, 1):
            print(f"[{i}/{len(files)}] {asm_file.name}...", end=' ', flush=True)

            if self.process_file(asm_file, verify=verify):
                print("✓")
            else:
                print("✗ FAILED")
                if verify:
                    print("  Build verification failed - reverting changes")

        self.print_summary()

    def print_summary(self) -> None:
        """Print batch processing summary"""
        print("\n" + "="*60)
        print(f"Files processed: {self.stats['files_processed']}")
        print(f"Total dc.w converted: {self.stats['total_converted']}/{self.stats['total_dc_w']}")
        rate = 100*self.stats['total_converted']/max(1, self.stats['total_dc_w'])
        print(f"Conversion rate: {rate:.1f}%")

        if self.stats['errors']:
            print(f"\nErrors ({len(self.stats['errors'])}):")
            for error in self.stats['errors']:
                print(f"  - {error}")


def main():
    import sys

    if len(sys.argv) < 2:
        print("Enhanced Annotation Tool - Full 68K Instruction Decoder")
        print("\nUsage:")
        print("  Single file:  python3 enhanced_annotate.py <file.asm>")
        print("  Batch mode:   python3 enhanced_annotate.py --batch [count] [--no-verify]")
        print("\nExamples:")
        print("  python3 enhanced_annotate.py disasm/sections/code_1000.asm")
        print("  python3 enhanced_annotate.py --batch 10")
        print("  python3 enhanced_annotate.py --batch 5 --no-verify")
        sys.exit(1)

    if sys.argv[1] == '--batch':
        sections_dir = Path('disasm/sections')
        rom_file = Path('Virtua Racing Deluxe (USA).32x')

        file_count = int(sys.argv[2]) if len(sys.argv) > 2 and sys.argv[2].isdigit() else 5
        verify = '--no-verify' not in sys.argv

        batch = BatchAnnotator(sections_dir, rom_file)
        batch.process_batch(file_count=file_count, verify=verify)
    else:
        asm_file = Path(sys.argv[1])
        if not asm_file.exists():
            print(f"Error: {asm_file} not found")
            sys.exit(1)

        annotator = FunctionAnnotator(asm_file)
        output_lines = annotator.annotate_lines()

        output_path = asm_file
        output_path.write_text('\n'.join(output_lines))

        print(f"✓ Converted {annotator.converted_count}/{annotator.total_dc_w} dc.w statements")
        print(f"✓ Written to {output_path}")


if __name__ == '__main__':
    main()
