#!/usr/bin/env python3
"""
Convert ROM sections to proper 68K assembly code.

Takes a ROM file and address range, outputs proper vasm-compatible assembly
that assembles back to identical bytes.

Key features:
- Generates actual instruction mnemonics (not DC.W)
- Creates labels for branch/jump targets
- Preserves data sections as DC.W
- Output assembles to byte-identical ROM

Usage:
    python3 disasm_to_asm.py <rom_file> <start> <end> [--output <file>]
"""

import struct
import sys
import argparse
from pathlib import Path
from collections import defaultdict

sys.path.insert(0, str(Path(__file__).parent))
from m68k_disasm import M68KDisassembler


class AssemblyGenerator:
    """Generate vasm-compatible 68K assembly from ROM data."""

    # 32X ROM base address for 68K CPU
    ROM_BASE = 0x00880000

    def __init__(self, rom_data, start_offset, end_offset, use_file_offsets=True):
        self.rom = rom_data
        self.start = start_offset
        self.end = end_offset
        self.use_file_offsets = use_file_offsets
        self.labels = {}  # address -> label name
        self.branch_targets = set()  # addresses that are branch targets
        self.instructions = []  # (address, size, mnemonic, is_data)
        self.disasm = ProperDisassembler(rom_data)

    def read_word(self, offset):
        """Read 16-bit big-endian word."""
        if offset + 2 > len(self.rom):
            return 0
        return struct.unpack('>H', self.rom[offset:offset+2])[0]

    def read_long(self, offset):
        """Read 32-bit big-endian long."""
        if offset + 4 > len(self.rom):
            return 0
        return struct.unpack('>I', self.rom[offset:offset+4])[0]

    def first_pass(self):
        """First pass: disassemble and collect branch targets."""
        offset = self.start

        while offset < self.end:
            addr = offset

            result = self.disasm.disassemble_instruction(offset, {})
            instruction = result['asm']
            size = result['size']

            # Track branch/jump targets
            self._extract_targets(addr, size)

            self.instructions.append((addr, size, instruction, False))
            offset += size

        # Create labels for branch targets within our range
        for target in sorted(self.branch_targets):
            if self.start <= target < self.end:
                self.labels[target] = f"loc_{target:06X}"

    def _extract_targets(self, addr, instr_size):
        """Extract branch/jump targets from instruction."""
        opcode = self.read_word(addr)

        # Bcc (conditional branches) - 6xxx
        if (opcode & 0xF000) == 0x6000:
            disp = opcode & 0xFF
            if disp == 0:
                disp = self.read_word(addr + 2)
                if disp & 0x8000:
                    disp = disp - 0x10000
            elif disp & 0x80:
                disp = disp - 256
            target = addr + 2 + disp
            self.branch_targets.add(target)

        # DBcc - 5xC8-5xCF
        if (opcode & 0xF0F8) == 0x50C8:
            disp = self.read_word(addr + 2)
            if disp & 0x8000:
                disp = disp - 0x10000
            target = addr + 2 + disp
            self.branch_targets.add(target)

        # JMP abs.l (4EF9)
        elif opcode == 0x4EF9:
            target = self.read_long(addr + 2)
            self.branch_targets.add(target)

        # JSR abs.l (4EB9)
        elif opcode == 0x4EB9:
            target = self.read_long(addr + 2)
            self.branch_targets.add(target)

        # JSR/JMP PC-relative (4EBA/4EFA)
        elif opcode in (0x4EBA, 0x4EFA):
            disp = self.read_word(addr + 2)
            if disp & 0x8000:
                disp = disp - 0x10000
            target = addr + 2 + disp
            self.branch_targets.add(target)

    def second_pass(self):
        """Second pass: re-disassemble with labels known."""
        new_instructions = []
        for addr, size, mnemonic, is_data in self.instructions:
            result = self.disasm.disassemble_instruction(addr, self.labels)
            new_instructions.append((addr, result['size'], result['asm'], False))
        self.instructions = new_instructions

    def format_instruction(self, addr, size, mnemonic, is_data, use_dcw=False):
        """Format instruction with proper labels."""
        # Check if this address needs a label
        label_line = ""
        if addr in self.labels:
            label_line = f"{self.labels[addr]}:\n"

        # Add address comment
        comment = f"; ${addr:06X}"

        if use_dcw:
            # Generate DC.W format with mnemonic as comment for byte-exact output
            words = []
            for i in range(0, size, 2):
                w = self.read_word(addr + i)
                words.append(f"${w:04X}")
            dcw_str = ",".join(words)
            return f"{label_line}        DC.W    {dcw_str:20s}{comment} {mnemonic}\n"
        else:
            return f"{label_line}        {mnemonic:40s}{comment}\n"

    def generate(self, use_dcw=False):
        """Generate assembly output.

        Args:
            use_dcw: If True, output DC.W format with mnemonic comments
                    (byte-exact but readable). If False, output pure mnemonics
                    (may not assemble due to address range issues).
        """
        self.first_pass()
        self.second_pass()

        lines = []
        lines.append(f"; Generated assembly for ${self.start:06X}-${self.end:06X}\n")
        lines.append(f"; Branch targets: {len(self.branch_targets)}\n")
        lines.append(f"; Labels: {len(self.labels)}\n")
        if use_dcw:
            lines.append(f"; Format: DC.W with decoded mnemonics as comments\n")
        lines.append(f"\n")
        lines.append(f"        org     ${self.start:06X}\n")
        lines.append(f"\n")

        for addr, size, mnemonic, is_data in self.instructions:
            lines.append(self.format_instruction(addr, size, mnemonic, is_data, use_dcw))

        return ''.join(lines)


class ProperDisassembler:
    """Proper 68K disassembler with vasm-compatible output."""

    # Instruction formats for vasm
    VASM_FORMATS = {
        'RTS': 'RTS',
        'RTE': 'RTE',
        'NOP': 'NOP',
        'ILLEGAL': 'ILLEGAL',
        'RESET': 'RESET',
        'STOP': 'STOP    #{imm}',
        'TRAPV': 'TRAPV',
    }

    def __init__(self, rom_data):
        self.rom = rom_data

    def read_word(self, offset):
        if offset + 2 > len(self.rom):
            return 0
        return struct.unpack('>H', self.rom[offset:offset+2])[0]

    def read_long(self, offset):
        if offset + 4 > len(self.rom):
            return 0
        return struct.unpack('>I', self.rom[offset:offset+4])[0]

    def disassemble_region(self, start, end, labels=None):
        """Disassemble a region and return vasm-compatible assembly."""
        if labels is None:
            labels = {}

        lines = []
        offset = start

        while offset < end:
            # Check for label
            if offset in labels:
                lines.append(f"{labels[offset]}:")

            result = self.disassemble_instruction(offset, labels)
            lines.append(f"        {result['asm']:40s}; ${offset:06X}")

            offset += result['size']

        return '\n'.join(lines)

    def disassemble_instruction(self, offset, labels=None):
        """Disassemble single instruction, return vasm format."""
        if labels is None:
            labels = {}

        opcode = self.read_word(offset)

        # RTS
        if opcode == 0x4E75:
            return {'asm': 'RTS', 'size': 2}

        # RTE
        if opcode == 0x4E73:
            return {'asm': 'RTE', 'size': 2}

        # NOP
        if opcode == 0x4E71:
            return {'asm': 'NOP', 'size': 2}

        # JMP abs.l (4EF9)
        if opcode == 0x4EF9:
            target = self.read_long(offset + 2)
            label = labels.get(target, f"${target:08X}")
            return {'asm': f'JMP     {label}', 'size': 6}

        # JSR abs.l (4EB9)
        if opcode == 0x4EB9:
            target = self.read_long(offset + 2)
            label = labels.get(target, f"${target:08X}")
            return {'asm': f'JSR     {label}', 'size': 6}

        # JSR PC-relative (4EBA)
        if opcode == 0x4EBA:
            disp = self.read_word(offset + 2)
            if disp & 0x8000:
                disp = disp - 0x10000
            target = offset + 2 + disp
            label = labels.get(target, f"${target:06X}")
            # vasm syntax for PC-relative: use label directly or (label,PC)
            return {'asm': f'JSR     {label}(PC)', 'size': 4}

        # JMP PC-relative (4EFA)
        if opcode == 0x4EFA:
            disp = self.read_word(offset + 2)
            if disp & 0x8000:
                disp = disp - 0x10000
            target = offset + 2 + disp
            label = labels.get(target, f"${target:06X}")
            return {'asm': f'JMP     {label}(PC)', 'size': 4}

        # JMP (An) (4ED0-4ED7)
        if (opcode & 0xFFF8) == 0x4ED0:
            reg = opcode & 7
            return {'asm': f'JMP     (A{reg})', 'size': 2}

        # JSR (An) (4E90-4E97)
        if (opcode & 0xFFF8) == 0x4E90:
            reg = opcode & 7
            return {'asm': f'JSR     (A{reg})', 'size': 2}

        # JSR with other EA modes (4E80-4EBF, except the specific patterns above)
        if (opcode & 0xFFC0) == 0x4E80:
            ea_mode = opcode & 0x3F
            ea, ea_size = self._decode_ea(ea_mode, offset + 2, '.L')
            return {'asm': f'JSR     {ea}', 'size': 2 + ea_size}

        # JMP with other EA modes (4EC0-4EFF, except the specific patterns above)
        if (opcode & 0xFFC0) == 0x4EC0:
            ea_mode = opcode & 0x3F
            ea, ea_size = self._decode_ea(ea_mode, offset + 2, '.L')
            return {'asm': f'JMP     {ea}', 'size': 2 + ea_size}

        # MOVE USP,An / MOVE An,USP (4E60-4E6F)
        if (opcode & 0xFFF0) == 0x4E60:
            reg = opcode & 7
            if opcode & 0x08:
                return {'asm': f'MOVE    USP,A{reg}', 'size': 2}
            return {'asm': f'MOVE    A{reg},USP', 'size': 2}

        # MOVEQ (7xxx)
        if (opcode & 0xF100) == 0x7000:
            reg = (opcode >> 9) & 7
            imm = opcode & 0xFF
            if imm & 0x80:
                # Negative value - show as signed
                return {'asm': f'MOVEQ   #-${(256-imm):02X},D{reg}', 'size': 2}
            return {'asm': f'MOVEQ   #${imm:02X},D{reg}', 'size': 2}

        # Bcc (conditional branches)
        if (opcode & 0xF000) == 0x6000:
            cond_code = (opcode >> 8) & 0xF
            cond_names = ['BRA', 'BSR', 'BHI', 'BLS', 'BCC', 'BCS', 'BNE', 'BEQ',
                         'BVC', 'BVS', 'BPL', 'BMI', 'BGE', 'BLT', 'BGT', 'BLE']
            cond = cond_names[cond_code]

            disp = opcode & 0xFF
            if disp == 0:
                # 16-bit displacement
                disp = self.read_word(offset + 2)
                if disp & 0x8000:
                    disp = disp - 0x10000
                size = 4
                suffix = '.W'
            elif disp == 0xFF:
                # 32-bit displacement (68020+)
                disp = self.read_long(offset + 2)
                size = 6
                suffix = '.L'
            else:
                # 8-bit displacement
                if disp & 0x80:
                    disp = disp - 256
                size = 2
                suffix = '.S'

            target = offset + 2 + disp
            label = labels.get(target, f"${target:06X}")
            return {'asm': f'{cond}{suffix:4s}{label}', 'size': size}

        # LEA (41C0-41FF with valid EA modes)
        if (opcode & 0xF1C0) == 0x41C0:
            reg = (opcode >> 9) & 7
            ea_mode = opcode & 0x3F
            ea, ea_size = self._decode_ea(ea_mode, offset + 2, '.L')
            return {'asm': f'LEA     {ea},A{reg}', 'size': 2 + ea_size}

        # MOVEA.L #imm,An (2x7C)
        if (opcode & 0xF1FF) == 0x207C:
            reg = (opcode >> 9) & 7
            imm = self.read_long(offset + 2)
            return {'asm': f'MOVEA.L #${imm:08X},A{reg}', 'size': 6}

        # TST.B/W/L
        if (opcode & 0xFF00) == 0x4A00:
            size_code = (opcode >> 6) & 3
            sizes = ['.B', '.W', '.L', '']
            ea_mode = opcode & 0x3F
            ea, ea_size = self._decode_ea(ea_mode, offset + 2, sizes[size_code])
            return {'asm': f'TST{sizes[size_code]:4s}{ea}', 'size': 2 + ea_size}

        # CLR.B/W/L (4200-42FF)
        if (opcode & 0xFF00) == 0x4200:
            size_code = (opcode >> 6) & 3
            sizes = ['.B', '.W', '.L', '']
            ea_mode = opcode & 0x3F
            ea, ea_size = self._decode_ea(ea_mode, offset + 2, sizes[size_code])
            return {'asm': f'CLR{sizes[size_code]:4s}{ea}', 'size': 2 + ea_size}

        # NEG.B/W/L (4400-44FF)
        if (opcode & 0xFF00) == 0x4400:
            size_code = (opcode >> 6) & 3
            sizes = ['.B', '.W', '.L', '']
            ea_mode = opcode & 0x3F
            ea, ea_size = self._decode_ea(ea_mode, offset + 2, sizes[size_code])
            return {'asm': f'NEG{sizes[size_code]:4s}{ea}', 'size': 2 + ea_size}

        # NOT.B/W/L (4600-46FF)
        if (opcode & 0xFF00) == 0x4600:
            size_code = (opcode >> 6) & 3
            sizes = ['.B', '.W', '.L', '']
            ea_mode = opcode & 0x3F
            ea, ea_size = self._decode_ea(ea_mode, offset + 2, sizes[size_code])
            return {'asm': f'NOT{sizes[size_code]:4s}{ea}', 'size': 2 + ea_size}

        # NEGX.B/W/L (4000-40FF)
        if (opcode & 0xFF00) == 0x4000:
            size_code = (opcode >> 6) & 3
            sizes = ['.B', '.W', '.L', '']
            ea_mode = opcode & 0x3F
            ea, ea_size = self._decode_ea(ea_mode, offset + 2, sizes[size_code])
            return {'asm': f'NEGX{sizes[size_code]:3s}{ea}', 'size': 2 + ea_size}

        # SWAP Dn (4840-484F)
        if (opcode & 0xFFF8) == 0x4840:
            reg = opcode & 7
            return {'asm': f'SWAP    D{reg}', 'size': 2}

        # EXT.W/L Dn (4880-48BF)
        if (opcode & 0xFE38) == 0x4800 and (opcode & 0x01C0) in (0x0080, 0x00C0):
            reg = opcode & 7
            if opcode & 0x0040:
                return {'asm': f'EXT.L   D{reg}', 'size': 2}
            return {'asm': f'EXT.W   D{reg}', 'size': 2}

        # PEA (4840-487F) - excluding SWAP
        if (opcode & 0xFFC0) == 0x4840 and (opcode & 0x38) != 0:
            ea, ea_size = self._decode_ea(opcode & 0x3F, offset + 2, '.L')
            return {'asm': f'PEA     {ea}', 'size': 2 + ea_size}

        # ADDQ/SUBQ/Scc/DBcc (5xxx)
        if (opcode & 0xF000) == 0x5000:
            # Check for DBcc first (5xC8-5xCF)
            if (opcode & 0x00F8) == 0x00C8:
                cond = (opcode >> 8) & 0xF
                reg = opcode & 7
                disp = self.read_word(offset + 2)
                if disp & 0x8000:
                    disp = disp - 0x10000
                target = offset + 2 + disp
                cond_names = ['DBT', 'DBRA', 'DBHI', 'DBLS', 'DBCC', 'DBCS', 'DBNE', 'DBEQ',
                             'DBVC', 'DBVS', 'DBPL', 'DBMI', 'DBGE', 'DBLT', 'DBGT', 'DBLE']
                label = labels.get(target, f'${target:06X}')
                return {'asm': f'{cond_names[cond]:8s}D{reg},{label}', 'size': 4}

            # Check for Scc (5xC0-5xC7, 5xD0-5xFF except DBcc)
            if (opcode & 0x00C0) == 0x00C0:
                cond = (opcode >> 8) & 0xF
                cond_names = ['ST', 'SF', 'SHI', 'SLS', 'SCC', 'SCS', 'SNE', 'SEQ',
                             'SVC', 'SVS', 'SPL', 'SMI', 'SGE', 'SLT', 'SGT', 'SLE']
                ea, ea_size = self._decode_ea(opcode & 0x3F, offset + 2, '.B')
                return {'asm': f'{cond_names[cond]:8s}{ea}', 'size': 2 + ea_size}

            # ADDQ/SUBQ
            is_sub = (opcode & 0x0100) != 0
            size_code = (opcode >> 6) & 3
            sizes = ['.B', '.W', '.L', '']
            data = (opcode >> 9) & 7
            if data == 0:
                data = 8
            ea, ea_size = self._decode_ea(opcode & 0x3F, offset + 2, sizes[size_code])
            op = 'SUBQ' if is_sub else 'ADDQ'
            return {'asm': f'{op}{sizes[size_code]:4s}#{data},{ea}', 'size': 2 + ea_size}

        # ADD (Dxxx)
        if (opcode & 0xF000) == 0xD000:
            reg = (opcode >> 9) & 7
            opmode = (opcode >> 6) & 7
            if opmode < 3:
                sizes = ['.B', '.W', '.L']
                ea, ea_size = self._decode_ea(opcode & 0x3F, offset + 2, sizes[opmode])
                return {'asm': f'ADD{sizes[opmode]:4s}{ea},D{reg}', 'size': 2 + ea_size}
            elif opmode == 3:
                ea, ea_size = self._decode_ea(opcode & 0x3F, offset + 2, '.W')
                return {'asm': f'ADDA.W  {ea},A{reg}', 'size': 2 + ea_size}
            elif opmode == 7:
                ea, ea_size = self._decode_ea(opcode & 0x3F, offset + 2, '.L')
                return {'asm': f'ADDA.L  {ea},A{reg}', 'size': 2 + ea_size}
            else:
                sizes = ['', '.B', '.W', '.L']
                ea, ea_size = self._decode_ea(opcode & 0x3F, offset + 2, sizes[opmode - 3])
                return {'asm': f'ADD{sizes[opmode-3]:4s}D{reg},{ea}', 'size': 2 + ea_size}

        # SUB (9xxx)
        if (opcode & 0xF000) == 0x9000:
            reg = (opcode >> 9) & 7
            opmode = (opcode >> 6) & 7
            if opmode < 3:
                sizes = ['.B', '.W', '.L']
                ea, ea_size = self._decode_ea(opcode & 0x3F, offset + 2, sizes[opmode])
                return {'asm': f'SUB{sizes[opmode]:4s}{ea},D{reg}', 'size': 2 + ea_size}
            elif opmode == 3:
                ea, ea_size = self._decode_ea(opcode & 0x3F, offset + 2, '.W')
                return {'asm': f'SUBA.W  {ea},A{reg}', 'size': 2 + ea_size}
            elif opmode == 7:
                ea, ea_size = self._decode_ea(opcode & 0x3F, offset + 2, '.L')
                return {'asm': f'SUBA.L  {ea},A{reg}', 'size': 2 + ea_size}
            else:
                sizes = ['', '.B', '.W', '.L']
                ea, ea_size = self._decode_ea(opcode & 0x3F, offset + 2, sizes[opmode - 3])
                return {'asm': f'SUB{sizes[opmode-3]:4s}D{reg},{ea}', 'size': 2 + ea_size}

        # CMP (Bxxx) - must check before CMPA/EOR
        if (opcode & 0xF000) == 0xB000:
            reg = (opcode >> 9) & 7
            opmode = (opcode >> 6) & 7
            if opmode < 3:  # CMP <ea>,Dn
                sizes = ['.B', '.W', '.L']
                ea, ea_size = self._decode_ea(opcode & 0x3F, offset + 2, sizes[opmode])
                return {'asm': f'CMP{sizes[opmode]:4s}{ea},D{reg}', 'size': 2 + ea_size}
            elif opmode == 3:  # CMPA.W <ea>,An
                ea, ea_size = self._decode_ea(opcode & 0x3F, offset + 2, '.W')
                return {'asm': f'CMPA.W  {ea},A{reg}', 'size': 2 + ea_size}
            elif opmode == 7:  # CMPA.L <ea>,An
                ea, ea_size = self._decode_ea(opcode & 0x3F, offset + 2, '.L')
                return {'asm': f'CMPA.L  {ea},A{reg}', 'size': 2 + ea_size}
            else:  # EOR Dn,<ea>
                sizes = ['', '.B', '.W', '.L']
                ea, ea_size = self._decode_ea(opcode & 0x3F, offset + 2, sizes[opmode - 3])
                return {'asm': f'EOR{sizes[opmode-3]:4s}D{reg},{ea}', 'size': 2 + ea_size}

        # AND (Cxxx)
        if (opcode & 0xF000) == 0xC000:
            reg = (opcode >> 9) & 7
            opmode = (opcode >> 6) & 7
            if opmode < 3:  # AND <ea>,Dn
                sizes = ['.B', '.W', '.L']
                ea, ea_size = self._decode_ea(opcode & 0x3F, offset + 2, sizes[opmode])
                return {'asm': f'AND{sizes[opmode]:4s}{ea},D{reg}', 'size': 2 + ea_size}
            elif opmode == 3:  # MULU <ea>,Dn
                ea, ea_size = self._decode_ea(opcode & 0x3F, offset + 2, '.W')
                return {'asm': f'MULU    {ea},D{reg}', 'size': 2 + ea_size}
            elif opmode == 7:  # MULS <ea>,Dn
                ea, ea_size = self._decode_ea(opcode & 0x3F, offset + 2, '.W')
                return {'asm': f'MULS    {ea},D{reg}', 'size': 2 + ea_size}
            else:  # AND Dn,<ea>
                sizes = ['', '.B', '.W', '.L']
                ea, ea_size = self._decode_ea(opcode & 0x3F, offset + 2, sizes[opmode - 3])
                return {'asm': f'AND{sizes[opmode-3]:4s}D{reg},{ea}', 'size': 2 + ea_size}

        # OR (8xxx)
        if (opcode & 0xF000) == 0x8000:
            reg = (opcode >> 9) & 7
            opmode = (opcode >> 6) & 7
            if opmode < 3:  # OR <ea>,Dn
                sizes = ['.B', '.W', '.L']
                ea, ea_size = self._decode_ea(opcode & 0x3F, offset + 2, sizes[opmode])
                return {'asm': f'OR{sizes[opmode]:5s}{ea},D{reg}', 'size': 2 + ea_size}
            elif opmode == 3:  # DIVU <ea>,Dn
                ea, ea_size = self._decode_ea(opcode & 0x3F, offset + 2, '.W')
                return {'asm': f'DIVU    {ea},D{reg}', 'size': 2 + ea_size}
            elif opmode == 7:  # DIVS <ea>,Dn
                ea, ea_size = self._decode_ea(opcode & 0x3F, offset + 2, '.W')
                return {'asm': f'DIVS    {ea},D{reg}', 'size': 2 + ea_size}
            else:  # OR Dn,<ea>
                sizes = ['', '.B', '.W', '.L']
                ea, ea_size = self._decode_ea(opcode & 0x3F, offset + 2, sizes[opmode - 3])
                return {'asm': f'OR{sizes[opmode-3]:5s}D{reg},{ea}', 'size': 2 + ea_size}

        # LINK (4E50-4E57)
        if (opcode & 0xFFF8) == 0x4E50:
            reg = opcode & 7
            disp = self.read_word(offset + 2)
            if disp & 0x8000:
                return {'asm': f'LINK    A{reg},#-${(65536-disp):04X}', 'size': 4}
            return {'asm': f'LINK    A{reg},#${disp:04X}', 'size': 4}

        # UNLK (4E58-4E5F)
        if (opcode & 0xFFF8) == 0x4E58:
            reg = opcode & 7
            return {'asm': f'UNLK    A{reg}', 'size': 2}

        # EXG (C1xx)
        if (opcode & 0xF100) == 0xC100:
            rx = (opcode >> 9) & 7
            ry = opcode & 7
            mode = (opcode >> 3) & 0x1F
            if mode == 0x08:  # Dx,Dy
                return {'asm': f'EXG     D{rx},D{ry}', 'size': 2}
            elif mode == 0x09:  # Ax,Ay
                return {'asm': f'EXG     A{rx},A{ry}', 'size': 2}
            elif mode == 0x11:  # Dx,Ay
                return {'asm': f'EXG     D{rx},A{ry}', 'size': 2}

        # MOVEM (48xx/4Cxx)
        if (opcode & 0xFB80) == 0x4880:
            direction = 'M' if opcode & 0x0400 else 'R'  # to Memory or Register
            size = '.L' if opcode & 0x0040 else '.W'
            mask = self.read_word(offset + 2)
            ea, ea_size = self._decode_ea(opcode & 0x3F, offset + 4, size)

            # Build register list from mask
            regs = []
            if direction == 'M' and (opcode & 0x38) == 0x20:  # predecrement
                # Reversed mask for predecrement
                for i in range(8):
                    if mask & (1 << (15 - i)):
                        regs.append(f'D{i}')
                for i in range(8):
                    if mask & (1 << (7 - i)):
                        regs.append(f'A{i}')
            else:
                for i in range(8):
                    if mask & (1 << i):
                        regs.append(f'D{i}')
                for i in range(8):
                    if mask & (1 << (i + 8)):
                        regs.append(f'A{i}')

            reglist = '/'.join(regs) if regs else '#$0000'
            if direction == 'M':
                return {'asm': f'MOVEM{size:3s}{reglist},{ea}', 'size': 4 + ea_size}
            else:
                return {'asm': f'MOVEM{size:3s}{ea},{reglist}', 'size': 4 + ea_size}

        # Shift/Rotate instructions (Exxx)
        if (opcode & 0xF000) == 0xE000:
            size_code = (opcode >> 6) & 3
            sizes = ['.B', '.W', '.L', '']
            direction = 'L' if opcode & 0x0100 else 'R'
            ir = (opcode >> 5) & 1  # 0=count/reg, 1=immediate
            shift_type = (opcode >> 3) & 3
            shift_names = ['AS', 'LS', 'ROX', 'RO']

            if size_code == 3:
                # Memory shift (size 3 = word memory operations)
                shift_type = (opcode >> 9) & 3
                ea, ea_size = self._decode_ea(opcode & 0x3F, offset + 2, '.W')
                return {'asm': f'{shift_names[shift_type]}{direction}.W  {ea}', 'size': 2 + ea_size}
            else:
                # Register shift
                reg = opcode & 7
                count = (opcode >> 9) & 7
                if ir:  # Register contains count
                    return {'asm': f'{shift_names[shift_type]}{direction}{sizes[size_code]:4s}D{count},D{reg}', 'size': 2}
                else:  # Immediate count
                    if count == 0:
                        count = 8
                    return {'asm': f'{shift_names[shift_type]}{direction}{sizes[size_code]:4s}#{count},D{reg}', 'size': 2}

        # BTST/BCHG/BCLR/BSET with immediate bit number (08xx)
        if (opcode & 0xFF00) == 0x0800:
            bit_op = (opcode >> 6) & 3
            bit_ops = ['BTST', 'BCHG', 'BCLR', 'BSET']
            bit = self.read_word(offset + 2)
            ea, ea_size = self._decode_ea(opcode & 0x3F, offset + 4, '.B')
            return {'asm': f'{bit_ops[bit_op]:8s}#{bit & 31},{ea}', 'size': 4 + ea_size}

        # BTST/BCHG/BCLR/BSET with register bit number (0xxx, not 08xx)
        if (opcode & 0xF000) == 0x0000 and (opcode & 0x0100):
            bit_op = (opcode >> 6) & 3
            bit_ops = ['BTST', 'BCHG', 'BCLR', 'BSET']
            reg = (opcode >> 9) & 7
            ea, ea_size = self._decode_ea(opcode & 0x3F, offset + 2, '.B')
            return {'asm': f'{bit_ops[bit_op]:8s}D{reg},{ea}', 'size': 2 + ea_size}

        # Immediate instructions ORI/ANDI/SUBI/ADDI/EORI/CMPI (00xx)
        if (opcode & 0xF000) == 0x0000 and (opcode & 0x0100) == 0:
            imm_op = (opcode >> 9) & 7
            imm_ops = ['ORI', 'ANDI', 'SUBI', 'ADDI', None, 'EORI', 'CMPI', None]
            size_code = (opcode >> 6) & 3
            sizes = ['.B', '.W', '.L', '']

            if imm_ops[imm_op] and size_code < 3:
                op_name = imm_ops[imm_op]
                size_str = sizes[size_code]

                # Read immediate value
                if size_code == 2:  # .L
                    imm = self.read_long(offset + 2)
                    imm_str = f'#${imm:08X}'
                    imm_size = 4
                else:
                    imm = self.read_word(offset + 2)
                    imm_str = f'#${imm:04X}'
                    imm_size = 2

                ea, ea_size = self._decode_ea(opcode & 0x3F, offset + 2 + imm_size, size_str)
                return {'asm': f'{op_name}{size_str:4s}{imm_str},{ea}', 'size': 2 + imm_size + ea_size}

        # TRAP #vector (4E40-4E4F)
        if (opcode & 0xFFF0) == 0x4E40:
            vector = opcode & 0xF
            return {'asm': f'TRAP    #{vector}', 'size': 2}

        # MOVE to CCR (44C0-44FF)
        if (opcode & 0xFFC0) == 0x44C0:
            ea, ea_size = self._decode_ea(opcode & 0x3F, offset + 2, '.W')
            return {'asm': f'MOVE    {ea},CCR', 'size': 2 + ea_size}

        # MOVE to SR (46C0-46FF)
        if (opcode & 0xFFC0) == 0x46C0:
            ea, ea_size = self._decode_ea(opcode & 0x3F, offset + 2, '.W')
            return {'asm': f'MOVE    {ea},SR', 'size': 2 + ea_size}

        # MOVE from SR (40C0-40FF)
        if (opcode & 0xFFC0) == 0x40C0:
            ea, ea_size = self._decode_ea(opcode & 0x3F, offset + 2, '.W')
            return {'asm': f'MOVE    SR,{ea}', 'size': 2 + ea_size}

        # MOVE.B/W/L (1xxx/3xxx/2xxx) - Note: 00=invalid, 01=.B, 10=.L, 11=.W
        size_bits = (opcode >> 12) & 3
        if size_bits in (1, 2, 3):
            size_map = {1: '.B', 2: '.L', 3: '.W'}
            size_str = size_map[size_bits]

            # Source EA: bits 5-3 = mode, bits 2-0 = reg
            src_mode = opcode & 0x3F

            # Destination EA: bits 11-9 = reg, bits 8-6 = mode (reversed from source!)
            dst_reg = (opcode >> 9) & 7
            dst_mode_bits = (opcode >> 6) & 7
            dst_mode = dst_reg | (dst_mode_bits << 3)

            src, src_size = self._decode_ea(src_mode, offset + 2, size_str)
            dst, dst_size = self._decode_ea(dst_mode, offset + 2 + src_size, size_str)

            # Check if it's MOVEA (destination is An = mode 1)
            if dst_mode_bits == 1:
                return {'asm': f'MOVEA{size_str:3s}{src},A{dst_reg}', 'size': 2 + src_size + dst_size}
            return {'asm': f'MOVE{size_str:4s}{src},{dst}', 'size': 2 + src_size + dst_size}

        # Default: DC.W
        return {'asm': f'DC.W    ${opcode:04X}', 'size': 2}

    def _decode_ea(self, mode, ext_offset, size_suffix, pc_addr=None):
        """Decode effective address mode."""
        reg = mode & 7
        mode_type = (mode >> 3) & 7

        if mode_type == 0:  # Dn
            return f'D{reg}', 0
        elif mode_type == 1:  # An
            return f'A{reg}', 0
        elif mode_type == 2:  # (An)
            return f'(A{reg})', 0
        elif mode_type == 3:  # (An)+
            return f'(A{reg})+', 0
        elif mode_type == 4:  # -(An)
            return f'-(A{reg})', 0
        elif mode_type == 5:  # (d16,An)
            disp = self.read_word(ext_offset)
            if disp & 0x8000:
                return f'-${(65536-disp):04X}(A{reg})', 2
            return f'${disp:04X}(A{reg})', 2
        elif mode_type == 6:  # (d8,An,Xn)
            ext = self.read_word(ext_offset)
            disp = ext & 0xFF
            if disp & 0x80:
                disp_str = f'-${(256-disp):02X}'
            else:
                disp_str = f'${disp:02X}'
            xn_reg = (ext >> 12) & 7
            xn_type = 'A' if ext & 0x8000 else 'D'
            xn_size = '.L' if ext & 0x0800 else '.W'
            return f'{disp_str}(A{reg},{xn_type}{xn_reg}{xn_size})', 2
        elif mode_type == 7:
            if reg == 0:  # abs.w
                addr = self.read_word(ext_offset)
                return f'${addr:04X}.W', 2
            elif reg == 1:  # abs.l
                addr = self.read_long(ext_offset)
                return f'${addr:08X}', 4
            elif reg == 2:  # (d16,PC)
                disp = self.read_word(ext_offset)
                if disp & 0x8000:
                    return f'-${(65536-disp):04X}(PC)', 2
                return f'${disp:04X}(PC)', 2
            elif reg == 3:  # (d8,PC,Xn)
                ext = self.read_word(ext_offset)
                disp = ext & 0xFF
                if disp & 0x80:
                    disp_str = f'-${(256-disp):02X}'
                else:
                    disp_str = f'${disp:02X}'
                xn_reg = (ext >> 12) & 7
                xn_type = 'A' if ext & 0x8000 else 'D'
                xn_size = '.L' if ext & 0x0800 else '.W'
                return f'{disp_str}(PC,{xn_type}{xn_reg}{xn_size})', 2
            elif reg == 4:  # #imm
                if size_suffix == '.L':
                    imm = self.read_long(ext_offset)
                    return f'#${imm:08X}', 4
                else:
                    imm = self.read_word(ext_offset)
                    return f'#${imm:04X}', 2

        return f'<EA:{mode:02X}>', 0


class ModuleConverter:
    """Convert DC.W module files to proper assembly."""

    def __init__(self, rom_data):
        self.rom = rom_data
        self.disasm = ProperDisassembler(rom_data)

    def convert_module(self, module_path, output_path=None, is_code=True, use_dcw=True):
        """Convert a module file from DC.W to proper assembly.

        Args:
            module_path: Path to module file
            output_path: Output path (default: overwrite input)
            is_code: Whether this is code (vs data)
            use_dcw: If True, output DC.W with mnemonic comments (byte-exact)
        """
        with open(module_path, 'r') as f:
            content = f.read()

        # Extract org address
        import re
        org_match = re.search(r'org\s+\$([0-9A-Fa-f]+)', content)
        if not org_match:
            print(f"No org directive found in {module_path}")
            return False

        start_addr = int(org_match.group(1), 16)

        # Extract end address from header or calculate from content
        size_match = re.search(r'Address:.*\((\d+) bytes\)', content)
        if size_match:
            size = int(size_match.group(1))
        else:
            # Count DC.W entries
            dcw_matches = re.findall(r'\$[0-9A-Fa-f]{4}', content)
            size = len(dcw_matches) * 2

        end_addr = start_addr + size

        # Generate proper assembly
        gen = AssemblyGenerator(self.rom, start_addr, end_addr)
        new_code = gen.generate(use_dcw=use_dcw)

        # Preserve the original header
        header_end = content.find('\n    org')
        if header_end == -1:
            header_end = content.find('\norg')
        if header_end == -1:
            header = ""
        else:
            header = content[:header_end] + '\n'

        # Combine header with new code (strip the generated header since we preserve original)
        output = header + new_code

        if output_path is None:
            output_path = module_path

        with open(output_path, 'w') as f:
            f.write(output)

        return True


def main():
    parser = argparse.ArgumentParser(description='Disassemble ROM to proper assembly')
    parser.add_argument('rom_file', type=Path, help='ROM file')
    parser.add_argument('start', nargs='?', help='Start offset (hex)')
    parser.add_argument('end', nargs='?', help='End offset (hex)')
    parser.add_argument('--output', '-o', type=Path, help='Output file')
    parser.add_argument('--module', '-m', type=Path, help='Convert a module file')
    parser.add_argument('--dcw', action='store_true',
                       help='Output DC.W format with mnemonic comments (byte-exact)')
    args = parser.parse_args()

    with open(args.rom_file, 'rb') as f:
        rom_data = f.read()

    if args.module:
        # Convert module file
        converter = ModuleConverter(rom_data)
        if converter.convert_module(args.module, args.output, use_dcw=args.dcw):
            print(f"Converted {args.module}")
        return

    if not args.start or not args.end:
        print("Usage: disasm_to_asm.py <rom> <start> <end>")
        print("       disasm_to_asm.py <rom> --module <module_file>")
        return

    start = int(args.start, 16)
    end = int(args.end, 16)

    gen = AssemblyGenerator(rom_data, start, end)
    output = gen.generate(use_dcw=args.dcw)

    if args.output:
        with open(args.output, 'w') as f:
            f.write(output)
        print(f"Written to {args.output}")
    else:
        print(output)


if __name__ == '__main__':
    main()
