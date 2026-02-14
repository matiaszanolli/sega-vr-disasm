#!/usr/bin/env python3
"""
translate_68k_modules.py — Batch dc.w → mnemonic translator for 68K modules.

Reads each .asm module file, finds dc.w lines containing hex opcodes,
decodes them to 68K mnemonics using a built-in opcode table, and outputs
proper vasm (Motorola syntax) assembly.

The decoder works from the HEX BYTES (ground truth), not from comment
annotations, to ensure accuracy. Comments are preserved as documentation.

Usage:
    python3 translate_68k_modules.py FILE.asm              # Single file
    python3 translate_68k_modules.py --batch DIR            # All .asm in dir tree
    python3 translate_68k_modules.py --dry-run FILE.asm     # Preview only
    python3 translate_68k_modules.py --stats DIR            # Count convertible lines
"""

import re
import sys
import os
import struct

# ---------------------------------------------------------------------------
# Address formatting helpers
# ---------------------------------------------------------------------------

def fmt_abs_short(addr16):
    """Format a 16-bit absolute short address for vasm.
    Sign-extends >= $8000 to $FFFFxxxx for readability."""
    if addr16 >= 0x8000:
        return f"($FFFF{addr16:04X}).w"
    else:
        return f"(${addr16:04X}).w"

def fmt_abs_long(addr32):
    """Format a 32-bit absolute long address."""
    return f"(${addr32:08X}).l" if addr32 < 0x10000 else f"${addr32:08X}"

def fmt_imm_byte(val):
    return f"#${val & 0xFF:02X}"

def fmt_imm_word(val):
    return f"#${val & 0xFFFF:04X}"

def fmt_imm_long(val):
    return f"#${val & 0xFFFFFFFF:08X}"

def fmt_dn(n):
    return f"d{n}"

def fmt_an(n):
    return f"a{n}"

SIZE_NAMES = {0: '.b', 1: '.w', 2: '.l'}

# ---------------------------------------------------------------------------
# Effective Address mode validation
# ---------------------------------------------------------------------------

def is_control_mode(mode, reg):
    """Check if EA mode is a control addressing mode (for LEA, PEA, JSR, JMP).
    Control modes: (An), d16(An), d8(An,Xn), (xxx).W, (xxx).L, d16(PC), d8(PC,Xn)"""
    if mode == 2:  return True   # (An)
    if mode == 5:  return True   # d16(An)
    if mode == 6:  return True   # d8(An,Xn)
    if mode == 7 and reg <= 3:  return True  # abs.W, abs.L, d16(PC), d8(PC,Xn)
    return False

def is_data_alterable(mode, reg):
    """Check if EA mode is data alterable (no An, no PC-relative, no immediate)."""
    if mode == 1:  return False  # An
    if mode == 7 and reg >= 2:  return False  # PC-relative, immediate
    return True

# ---------------------------------------------------------------------------
# Effective Address decoder
# ---------------------------------------------------------------------------

def decode_ea(mode, reg, words, idx, size_suffix):
    """Decode a 68K effective address.

    Args:
        mode: 3-bit mode field
        reg: 3-bit register field
        words: list of all hex words
        idx: index into words for extension words
        size_suffix: '.b', '.w', or '.l' for immediate sizing

    Returns:
        (ea_string, num_extension_words) or None
    """
    if mode <= 4:
        # Modes 0-4: no extension words
        if mode == 0:  # Dn
            return fmt_dn(reg), 0
        elif mode == 1:  # An
            return fmt_an(reg), 0
        elif mode == 2:  # (An)
            return f"({fmt_an(reg)})", 0
        elif mode == 3:  # (An)+
            return f"({fmt_an(reg)})+", 0
        elif mode == 4:  # -(An)
            return f"-({fmt_an(reg)})", 0

    elif mode == 5:  # d16(An)
        if idx >= len(words):
            return None
        disp = words[idx]
        if disp & 0x8000:
            disp_signed = disp - 0x10000
        else:
            disp_signed = disp
        if disp_signed == 0:
            return f"({fmt_an(reg)})", 1
        elif disp_signed < 0:
            return f"(-${abs(disp_signed):X})({fmt_an(reg)})", 1
        else:
            return f"${disp:04X}({fmt_an(reg)})", 1

    elif mode == 6:  # d8(An,Xn)
        if idx >= len(words):
            return None
        ext = words[idx]
        # Brief extension word format:
        # bit 15: D/A (0=Dn, 1=An)
        # bits 14-12: register number
        # bit 11: W/L (0=word, 1=long)
        # bits 7-0: displacement (signed byte)
        da = (ext >> 15) & 1
        xreg = (ext >> 12) & 7
        wl = (ext >> 11) & 1
        disp8 = ext & 0xFF
        if disp8 & 0x80:
            disp8 = disp8 - 256

        xreg_name = fmt_an(xreg) if da else fmt_dn(xreg)
        xsize = '.l' if wl else '.w'

        if disp8 == 0:
            return f"({fmt_an(reg)},{xreg_name}{xsize})", 1
        else:
            return f"({disp8},{fmt_an(reg)},{xreg_name}{xsize})", 1

    elif mode == 7:
        if reg == 0:  # (xxx).W - absolute short
            if idx >= len(words):
                return None
            addr = words[idx]
            return fmt_abs_short(addr), 1

        elif reg == 1:  # (xxx).L - absolute long
            if idx + 1 >= len(words):
                return None
            addr = (words[idx] << 16) | words[idx + 1]
            # For addresses that could be short, force .l suffix
            if addr < 0x10000:
                return f"(${addr:08X}).l", 2
            return f"${addr:08X}", 2

        elif reg == 2:  # d16(PC)
            # PC-relative - we can't easily resolve this without knowing the address
            return None

        elif reg == 3:  # d8(PC,Xn)
            return None

        elif reg == 4:  # #imm
            if size_suffix == '.b' or size_suffix == '.w':
                if idx >= len(words):
                    return None
                val = words[idx]
                if size_suffix == '.b':
                    # vasm zeroes high byte; skip if original
                    # has non-zero high byte
                    if val & 0xFF00:
                        return None
                    return fmt_imm_byte(val), 1
                return fmt_imm_word(val), 1
            elif size_suffix == '.l':
                if idx + 1 >= len(words):
                    return None
                val = (words[idx] << 16) | words[idx + 1]
                return fmt_imm_long(val), 2

    return None


# ---------------------------------------------------------------------------
# Instruction decoders by group
# ---------------------------------------------------------------------------

def decode_group0(words):
    """Group 0: ORI, ANDI, SUBI, ADDI, EORI, CMPI, BTST/BCHG/BCLR/BSET."""
    opcode = words[0]

    # Dynamic bit operations: 0000 nnn 1xx mmm rrr
    # BTST/BCHG/BCLR/BSET Dn,<ea>
    if (opcode & 0xF100) == 0x0100:
        dn = (opcode >> 9) & 7
        subop = (opcode >> 6) & 3  # 00=BTST, 01=BCHG, 10=BCLR, 11=BSET
        # But 01 with ea_mode=001 is MOVEP — skip
        ea_mode = (opcode >> 3) & 7
        ea_reg = opcode & 7
        if ea_mode == 1:  # MOVEP
            return None
        names = ['btst', 'bchg', 'bclr', 'bset']
        ea_result = decode_ea(ea_mode, ea_reg, words, 1, '.b')
        if ea_result is None:
            return None
        ea_str, ea_ext = ea_result
        return f"{names[subop]}    {fmt_dn(dn)},{ea_str}", 1 + ea_ext

    # Static bit operations: 0000 1000 xx mmm rrr
    # BTST/BCHG/BCLR/BSET #n,<ea>
    top8 = (opcode >> 8) & 0xFF
    if top8 == 0x08:
        subop = (opcode >> 6) & 3  # 00=BTST, 01=BCHG, 10=BCLR, 11=BSET
        names = ['btst', 'bchg', 'bclr', 'bset']
        ea_mode = (opcode >> 3) & 7
        ea_reg = opcode & 7
        if len(words) < 2:
            return None
        bit_num = words[1]
        ea_result = decode_ea(ea_mode, ea_reg, words, 2, '.b')
        if ea_result is None:
            return None
        ea_str, ea_ext = ea_result
        total = 2 + ea_ext  # opcode + bit_num + ea extensions
        mnemonic = f"{names[subop]}    #{bit_num},{ea_str}"
        return mnemonic, total

    # Immediate operations: 0000 xxx0 ss mmm rrr
    # where xxx = 000 ORI, 001 ANDI, 010 SUBI, 011 ADDI, 100 (reserved),
    #             101 EORI, 110 CMPI
    imm_op = (opcode >> 9) & 7
    if imm_op in (0, 1, 2, 3, 5, 6) and ((opcode >> 8) & 1) == 0:
        names = {0: 'ori', 1: 'andi', 2: 'subi', 3: 'addi', 5: 'eori', 6: 'cmpi'}
        name = names[imm_op]
        size_bits = (opcode >> 6) & 3  # 00=byte, 01=word, 10=long
        if size_bits == 3:
            return None  # Invalid
        size_suffix = SIZE_NAMES[size_bits]
        ea_mode = (opcode >> 3) & 7
        ea_reg = opcode & 7

        # Immediate ops require data alterable destination
        if not is_data_alterable(ea_mode, ea_reg):
            return None

        # Read immediate value
        if size_bits <= 1:  # byte or word: 1 extension word
            if len(words) < 2:
                return None
            imm_val = words[1]
            if size_bits == 0:
                # For .B immediates, vasm zeroes the high byte.
                # If original has non-zero high byte, skip to
                # preserve byte-identical output.
                if imm_val & 0xFF00:
                    return None
                imm_str = fmt_imm_byte(imm_val)
            else:
                imm_str = fmt_imm_word(imm_val)
            imm_words = 1
        else:  # long: 2 extension words
            if len(words) < 3:
                return None
            imm_val = (words[1] << 16) | words[2]
            imm_str = fmt_imm_long(imm_val)
            imm_words = 2

        ea_result = decode_ea(ea_mode, ea_reg, words, 1 + imm_words, size_suffix)
        if ea_result is None:
            return None
        ea_str, ea_ext = ea_result

        total = 1 + imm_words + ea_ext
        mnemonic = f"{name}{size_suffix}  {imm_str},{ea_str}"
        return mnemonic, total

    return None


def decode_move(words):
    """Groups 1/2/3: MOVE.B / MOVE.L / MOVE.W"""
    opcode = words[0]
    group = (opcode >> 12) & 0xF

    size_map = {1: '.b', 2: '.l', 3: '.w'}
    if group not in size_map:
        return None
    size_suffix = size_map[group]

    # Source EA
    src_mode = (opcode >> 3) & 7
    src_reg = opcode & 7

    # Destination EA (MOVE uses reversed field order: reg then mode)
    dst_reg = (opcode >> 9) & 7
    dst_mode = (opcode >> 6) & 7

    # MOVE.B restrictions: An (mode 1) is invalid as both source and destination
    if size_suffix == '.b':
        if src_mode == 1:
            return None  # MOVE.B An,<ea> doesn't exist — this is data
        if dst_mode == 1:
            return None  # MOVEA.B doesn't exist — this is data

    # Check for MOVEA (dst mode = 1 → address register)
    is_movea = (dst_mode == 1)

    # Decode source EA
    src_result = decode_ea(src_mode, src_reg, words, 1, size_suffix)
    if src_result is None:
        return None
    src_str, src_ext = src_result

    # Decode destination EA
    if is_movea:
        dst_str = fmt_an(dst_reg)
        dst_ext = 0
    else:
        dst_result = decode_ea(dst_mode, dst_reg, words, 1 + src_ext, size_suffix)
        if dst_result is None:
            return None
        dst_str, dst_ext = dst_result

    total = 1 + src_ext + dst_ext

    if is_movea:
        mnemonic = f"movea{size_suffix} {src_str},{dst_str}"
    else:
        mnemonic = f"move{size_suffix}  {src_str},{dst_str}"

    return mnemonic, total


def decode_group4(words):
    """Group 4: Miscellaneous — CLR, NEG, NEGX, NOT, TST, LEA, PEA, JSR, JMP,
    EXT, SWAP, MOVEM, LINK, UNLK, TRAP, MOVE to/from SR/CCR, etc."""
    opcode = words[0]

    # MOVE from SR: 0100 0000 11 mmm rrr (data alterable only)
    if (opcode & 0xFFC0) == 0x40C0:
        ea_mode = (opcode >> 3) & 7
        ea_reg = opcode & 7
        if not is_data_alterable(ea_mode, ea_reg):
            return None
        ea_result = decode_ea(ea_mode, ea_reg, words, 1, '.w')
        if ea_result is None:
            return None
        ea_str, ea_ext = ea_result
        return f"move.w  sr,{ea_str}", 1 + ea_ext

    # MOVE to CCR: 0100 0100 11 mmm rrr ($44C0-$44FF)
    if (opcode & 0xFFC0) == 0x44C0:
        ea_mode = (opcode >> 3) & 7
        ea_reg = opcode & 7
        ea_result = decode_ea(ea_mode, ea_reg, words, 1, '.w')
        if ea_result is None:
            return None
        ea_str, ea_ext = ea_result
        return f"move.w  {ea_str},ccr", 1 + ea_ext

    # MOVE to SR: 0100 0110 11 mmm rrr ($46C0-$46FF)
    if (opcode & 0xFFC0) == 0x46C0:
        ea_mode = (opcode >> 3) & 7
        ea_reg = opcode & 7
        ea_result = decode_ea(ea_mode, ea_reg, words, 1, '.w')
        if ea_result is None:
            return None
        ea_str, ea_ext = ea_result
        return f"move.w  {ea_str},sr", 1 + ea_ext

    # CLR: 0100 0010 ss mmm rrr (data alterable only)
    if (opcode & 0xFF00) == 0x4200:
        size_bits = (opcode >> 6) & 3
        if size_bits == 3:
            return None
        size_suffix = SIZE_NAMES[size_bits]
        ea_mode = (opcode >> 3) & 7
        ea_reg = opcode & 7
        if not is_data_alterable(ea_mode, ea_reg):
            return None
        ea_result = decode_ea(ea_mode, ea_reg, words, 1, size_suffix)
        if ea_result is None:
            return None
        ea_str, ea_ext = ea_result
        return f"clr{size_suffix}    {ea_str}", 1 + ea_ext

    # NEG: 0100 0100 ss mmm rrr (data alterable only)
    if (opcode & 0xFF00) == 0x4400:
        size_bits = (opcode >> 6) & 3
        if size_bits == 3:
            return None
        size_suffix = SIZE_NAMES[size_bits]
        ea_mode = (opcode >> 3) & 7
        ea_reg = opcode & 7
        if not is_data_alterable(ea_mode, ea_reg):
            return None
        ea_result = decode_ea(ea_mode, ea_reg, words, 1, size_suffix)
        if ea_result is None:
            return None
        ea_str, ea_ext = ea_result
        return f"neg{size_suffix}    {ea_str}", 1 + ea_ext

    # NEGX: 0100 0000 ss mmm rrr (data alterable only)
    if (opcode & 0xFF00) == 0x4000:
        size_bits = (opcode >> 6) & 3
        if size_bits == 3:
            return None
        size_suffix = SIZE_NAMES[size_bits]
        ea_mode = (opcode >> 3) & 7
        ea_reg = opcode & 7
        if not is_data_alterable(ea_mode, ea_reg):
            return None
        ea_result = decode_ea(ea_mode, ea_reg, words, 1, size_suffix)
        if ea_result is None:
            return None
        ea_str, ea_ext = ea_result
        return f"negx{size_suffix}   {ea_str}", 1 + ea_ext

    # NOT: 0100 0110 ss mmm rrr (data alterable only)
    if (opcode & 0xFF00) == 0x4600:
        size_bits = (opcode >> 6) & 3
        if size_bits == 3:
            return None
        size_suffix = SIZE_NAMES[size_bits]
        ea_mode = (opcode >> 3) & 7
        ea_reg = opcode & 7
        if not is_data_alterable(ea_mode, ea_reg):
            return None
        ea_result = decode_ea(ea_mode, ea_reg, words, 1, size_suffix)
        if ea_result is None:
            return None
        ea_str, ea_ext = ea_result
        return f"not{size_suffix}    {ea_str}", 1 + ea_ext

    # TST: 0100 1010 ss mmm rrr
    if (opcode & 0xFF00) == 0x4A00:
        size_bits = (opcode >> 6) & 3
        if size_bits == 3:
            return None  # TAS or illegal
        size_suffix = SIZE_NAMES[size_bits]
        ea_mode = (opcode >> 3) & 7
        ea_reg = opcode & 7
        ea_result = decode_ea(ea_mode, ea_reg, words, 1, size_suffix)
        if ea_result is None:
            return None
        ea_str, ea_ext = ea_result
        return f"tst{size_suffix}    {ea_str}", 1 + ea_ext

    # TAS: 0100 1010 11 mmm rrr
    if (opcode & 0xFFC0) == 0x4AC0:
        ea_mode = (opcode >> 3) & 7
        ea_reg = opcode & 7
        ea_result = decode_ea(ea_mode, ea_reg, words, 1, '.b')
        if ea_result is None:
            return None
        ea_str, ea_ext = ea_result
        return f"tas     {ea_str}", 1 + ea_ext

    # LEA: 0100 nnn 111 mmm rrr (control modes only)
    if (opcode & 0xF1C0) == 0x41C0:
        an = (opcode >> 9) & 7
        ea_mode = (opcode >> 3) & 7
        ea_reg = opcode & 7
        if not is_control_mode(ea_mode, ea_reg):
            return None
        ea_result = decode_ea(ea_mode, ea_reg, words, 1, '.l')
        if ea_result is None:
            return None
        ea_str, ea_ext = ea_result
        return f"lea     {ea_str},{fmt_an(an)}", 1 + ea_ext

    # PEA: 0100 1000 01 mmm rrr (control modes only)
    if (opcode & 0xFFC0) == 0x4840:
        ea_mode = (opcode >> 3) & 7
        ea_reg = opcode & 7
        if not is_control_mode(ea_mode, ea_reg):
            return None
        ea_result = decode_ea(ea_mode, ea_reg, words, 1, '.l')
        if ea_result is None:
            return None
        ea_str, ea_ext = ea_result
        return f"pea     {ea_str}", 1 + ea_ext

    # EXT.W: 0100 1000 1000 0 nnn
    if (opcode & 0xFFF8) == 0x4880:
        dn = opcode & 7
        return f"ext.w   {fmt_dn(dn)}", 1

    # EXT.L: 0100 1000 1100 0 nnn
    if (opcode & 0xFFF8) == 0x48C0:
        dn = opcode & 7
        return f"ext.l   {fmt_dn(dn)}", 1

    # SWAP: 0100 1000 0100 0 nnn
    if (opcode & 0xFFF8) == 0x4840:
        dn = opcode & 7
        return f"swap    {fmt_dn(dn)}", 1

    # LINK: 0100 1110 0101 0 nnn
    if (opcode & 0xFFF8) == 0x4E50:
        an = opcode & 7
        if len(words) < 2:
            return None
        disp = words[1]
        if disp & 0x8000:
            disp_signed = disp - 0x10000
            return f"link    {fmt_an(an)},#-${abs(disp_signed):04X}", 2
        return f"link    {fmt_an(an)},#${disp:04X}", 2

    # UNLK: 0100 1110 0101 1 nnn
    if (opcode & 0xFFF8) == 0x4E58:
        an = opcode & 7
        return f"unlk    {fmt_an(an)}", 1

    # TRAP: 0100 1110 0100 vvvv
    if (opcode & 0xFFF0) == 0x4E40:
        vector = opcode & 0xF
        return f"trap    #{vector}", 1

    # RTS: 4E75
    if opcode == 0x4E75:
        return "rts", 1

    # RTE: 4E73
    if opcode == 0x4E73:
        return "rte", 1

    # NOP: 4E71
    if opcode == 0x4E71:
        return "nop", 1

    # JSR (xxx).L: 4EB9
    if opcode == 0x4EB9:
        if len(words) < 3:
            return None
        addr = (words[1] << 16) | words[2]
        return f"jsr     ${addr:08X}", 3

    # JSR (xxx).W: 4EB8
    if opcode == 0x4EB8:
        if len(words) < 2:
            return None
        addr = words[1]
        return f"jsr     {fmt_abs_short(addr)}", 2

    # JSR (An): 4E90-4E97
    if (opcode & 0xFFF8) == 0x4E90:
        reg = opcode & 7
        return f"jsr     ({fmt_an(reg)})", 1

    # JSR d16(An): 4EA8-4EAF
    if (opcode & 0xFFF8) == 0x4EA8:
        reg = opcode & 7
        if len(words) < 2:
            return None
        disp = words[1]
        if disp & 0x8000:
            disp = disp - 0x10000
        return f"jsr     ${disp & 0xFFFF:04X}({fmt_an(reg)})", 2

    # JMP (xxx).L: 4EF9
    if opcode == 0x4EF9:
        if len(words) < 3:
            return None
        addr = (words[1] << 16) | words[2]
        return f"jmp     ${addr:08X}", 3

    # JMP (xxx).W: 4EF8
    if opcode == 0x4EF8:
        if len(words) < 2:
            return None
        addr = words[1]
        return f"jmp     {fmt_abs_short(addr)}", 2

    # JMP (An): 4ED0-4ED7
    if (opcode & 0xFFF8) == 0x4ED0:
        reg = opcode & 7
        return f"jmp     ({fmt_an(reg)})", 1

    # JMP d16(An): 4EE8-4EEF
    if (opcode & 0xFFF8) == 0x4EE8:
        reg = opcode & 7
        if len(words) < 2:
            return None
        disp = words[1]
        return f"jmp     ${disp:04X}({fmt_an(reg)})", 2

    # MOVEM: 0100 1d00 1s mmm rrr (d=0 reg-to-mem, d=1 mem-to-reg)
    if (opcode & 0xFB80) == 0x4880:
        direction = (opcode >> 10) & 1  # 0=reg-to-mem, 1=mem-to-reg
        size_bit = (opcode >> 6) & 1  # 0=word, 1=long
        size_suffix = '.l' if size_bit else '.w'
        ea_mode = (opcode >> 3) & 7
        ea_reg = opcode & 7

        if len(words) < 2:
            return None
        reg_mask = words[1]

        # For predecrement mode, the mask is reversed
        if direction == 0 and ea_mode == 4:
            reg_mask = reverse_mask(reg_mask)

        reg_list = format_regmask(reg_mask)
        ea_result = decode_ea(ea_mode, ea_reg, words, 2, size_suffix)
        if ea_result is None:
            return None
        ea_str, ea_ext = ea_result

        total = 2 + ea_ext  # opcode + mask + ea extensions
        if direction == 0:
            return f"movem{size_suffix} {reg_list},{ea_str}", total
        else:
            return f"movem{size_suffix} {ea_str},{reg_list}", total

    return None


def decode_group5(words):
    """Group 5: ADDQ, SUBQ, Scc, DBcc."""
    opcode = words[0]

    # Check for DBcc: 0101 cccc 1100 1 rrr
    if (opcode & 0xF0F8) == 0x50C8:
        cond = (opcode >> 8) & 0xF
        reg = opcode & 7
        if len(words) < 2:
            return None
        # DBcc displacement — can't resolve without address context
        return None

    # Check for Scc: 0101 cccc 11 mmm rrr (but not DBcc)
    if (opcode & 0xF0C0) == 0x50C0:
        cond = (opcode >> 8) & 0xF
        cc_names = ['t', 'f', 'hi', 'ls', 'cc', 'cs', 'ne', 'eq',
                    'vc', 'vs', 'pl', 'mi', 'ge', 'lt', 'gt', 'le']
        ea_mode = (opcode >> 3) & 7
        ea_reg = opcode & 7
        ea_result = decode_ea(ea_mode, ea_reg, words, 1, '.b')
        if ea_result is None:
            return None
        ea_str, ea_ext = ea_result
        return f"s{cc_names[cond]}      {ea_str}", 1 + ea_ext

    # ADDQ / SUBQ: 0101 ddd 0 ss mmm rrr / 0101 ddd 1 ss mmm rrr
    data3 = (opcode >> 9) & 7
    data = 8 if data3 == 0 else data3
    is_sub = (opcode >> 8) & 1
    size_bits = (opcode >> 6) & 3
    if size_bits == 3:
        return None  # This is Scc/DBcc
    size_suffix = SIZE_NAMES[size_bits]
    ea_mode = (opcode >> 3) & 7
    ea_reg = opcode & 7

    # ADDQ/SUBQ to An only supports .W and .L, not .B
    if ea_mode == 1 and size_bits == 0:
        return None

    name = 'subq' if is_sub else 'addq'
    ea_result = decode_ea(ea_mode, ea_reg, words, 1, size_suffix)
    if ea_result is None:
        return None
    ea_str, ea_ext = ea_result

    return f"{name}{size_suffix}  #{data},{ea_str}", 1 + ea_ext


def decode_group7(words):
    """Group 7: MOVEQ."""
    opcode = words[0]
    if (opcode & 0xF100) != 0x7000:
        return None
    reg = (opcode >> 9) & 7
    imm = opcode & 0xFF
    return f"moveq   #${imm:02X},{fmt_dn(reg)}", 1


def decode_arith(words):
    """Groups 8-9, B-D: OR/DIV, SUB, CMP/EOR, AND/MUL/EXG, ADD."""
    opcode = words[0]
    group = (opcode >> 12) & 0xF

    if group not in (8, 9, 0xB, 0xC, 0xD):
        return None

    dn = (opcode >> 9) & 7
    opmode = (opcode >> 6) & 7
    ea_mode = (opcode >> 3) & 7
    ea_reg = opcode & 7

    # EXG (Group C only): 1100 Rx 1 opmode Ry
    if group == 0xC:
        if (opcode & 0xF1F8) == 0xC140:  # EXG Dx,Dy
            return f"exg     {fmt_dn(dn)},{fmt_dn(ea_reg)}", 1
        if (opcode & 0xF1F8) == 0xC148:  # EXG Ax,Ay
            return f"exg     {fmt_an(dn)},{fmt_an(ea_reg)}", 1
        if (opcode & 0xF1F8) == 0xC188:  # EXG Dx,Ay
            return f"exg     {fmt_dn(dn)},{fmt_an(ea_reg)}", 1

    # ADDX (Group D): 1101 Rx 1 ss 00 m Ry
    if group == 0xD and opmode in (4, 5, 6) and ea_mode == 0:
        size_suffix = SIZE_NAMES[opmode - 4]
        return f"addx{size_suffix}  {fmt_dn(ea_reg)},{fmt_dn(dn)}", 1
    if group == 0xD and opmode in (4, 5, 6) and ea_mode == 1:
        size_suffix = SIZE_NAMES[opmode - 4]
        return f"addx{size_suffix}  -({fmt_an(ea_reg)}),-({fmt_an(dn)})", 1

    # SUBX (Group 9): 1001 Rx 1 ss 00 m Ry
    if group == 9 and opmode in (4, 5, 6) and ea_mode == 0:
        size_suffix = SIZE_NAMES[opmode - 4]
        return f"subx{size_suffix}  {fmt_dn(ea_reg)},{fmt_dn(dn)}", 1
    if group == 9 and opmode in (4, 5, 6) and ea_mode == 1:
        size_suffix = SIZE_NAMES[opmode - 4]
        return f"subx{size_suffix}  -({fmt_an(ea_reg)}),-({fmt_an(dn)})", 1

    # CMPM (Group B): 1011 Rx 1 ss 001 Ry
    if group == 0xB and opmode in (4, 5, 6) and ea_mode == 1:
        size_suffix = SIZE_NAMES[opmode - 4]
        return f"cmpm{size_suffix}  ({fmt_an(ea_reg)})+,({fmt_an(dn)})+", 1

    # Size from opmode
    if opmode in (0, 4):
        size_suffix = '.b'
    elif opmode in (1, 5):
        size_suffix = '.w'
    elif opmode in (2, 6):
        size_suffix = '.l'
    elif opmode == 3:
        size_suffix = '.w'  # ADDA.W / SUBA.W / CMPA.W
    elif opmode == 7:
        size_suffix = '.l'  # ADDA.L / SUBA.L / CMPA.L
    else:
        return None

    # EA mode restrictions for arithmetic groups:
    # OR/AND (groups 8, C): An (mode 1) not valid at all
    if group in (8, 0xC) and ea_mode == 1:
        return None
    # ADD/SUB/CMP with An source (opmode 0-2): .B is invalid
    if group in (9, 0xB, 0xD) and opmode in (0,) and ea_mode == 1:
        return None  # .B with An source
    # EOR (group B, opmode 4-6): Dn→EA, An not valid as destination
    if group == 0xB and opmode in (4, 5, 6) and ea_mode == 1:
        return None
    # ADD/SUB (groups 9, D) Dn→EA: An not valid as destination
    if group in (9, 0xD) and opmode in (4, 5, 6) and ea_mode == 1:
        return None
    # Encoding ambiguity: Dn→Dn ops have two valid encodings
    # (opmode 0-2 vs 4-6). vasm picks canonical form which may
    # differ from original. Skip to preserve byte-identical output.
    if opmode in (4, 5, 6) and ea_mode == 0:
        if group in (8, 9, 0xB, 0xC, 0xD):
            return None

    ea_result = decode_ea(ea_mode, ea_reg, words, 1, size_suffix)
    if ea_result is None:
        return None
    ea_str, ea_ext = ea_result

    # Determine operation name and direction
    if group == 0xD:  # ADD
        if opmode in (3, 7):
            return f"adda{size_suffix}  {ea_str},{fmt_an(dn)}", 1 + ea_ext
        elif opmode <= 2:
            return f"add{size_suffix}   {ea_str},{fmt_dn(dn)}", 1 + ea_ext
        else:
            return f"add{size_suffix}   {fmt_dn(dn)},{ea_str}", 1 + ea_ext

    elif group == 9:  # SUB
        if opmode in (3, 7):
            return f"suba{size_suffix}  {ea_str},{fmt_an(dn)}", 1 + ea_ext
        elif opmode <= 2:
            return f"sub{size_suffix}   {ea_str},{fmt_dn(dn)}", 1 + ea_ext
        else:
            return f"sub{size_suffix}   {fmt_dn(dn)},{ea_str}", 1 + ea_ext

    elif group == 0xB:  # CMP / EOR
        if opmode in (3, 7):
            return f"cmpa{size_suffix}  {ea_str},{fmt_an(dn)}", 1 + ea_ext
        elif opmode <= 2:
            return f"cmp{size_suffix}   {ea_str},{fmt_dn(dn)}", 1 + ea_ext
        else:
            return f"eor{size_suffix}   {fmt_dn(dn)},{ea_str}", 1 + ea_ext

    elif group == 0xC:  # AND / MUL / EXG
        if opmode == 3:  # MULU
            return f"mulu.w  {ea_str},{fmt_dn(dn)}", 1 + ea_ext
        elif opmode == 7:  # MULS
            return f"muls.w  {ea_str},{fmt_dn(dn)}", 1 + ea_ext
        elif opmode <= 2:
            return f"and{size_suffix}   {ea_str},{fmt_dn(dn)}", 1 + ea_ext
        else:
            return f"and{size_suffix}   {fmt_dn(dn)},{ea_str}", 1 + ea_ext

    elif group == 8:  # OR / DIV
        if opmode == 3:  # DIVU
            return f"divu.w  {ea_str},{fmt_dn(dn)}", 1 + ea_ext
        elif opmode == 7:  # DIVS
            return f"divs.w  {ea_str},{fmt_dn(dn)}", 1 + ea_ext
        elif opmode <= 2:
            return f"or{size_suffix}    {ea_str},{fmt_dn(dn)}", 1 + ea_ext
        else:
            return f"or{size_suffix}    {fmt_dn(dn)},{ea_str}", 1 + ea_ext

    return None


def decode_shift(words):
    """Group E: ASL, ASR, LSL, LSR, ROL, ROR, ROXL, ROXR."""
    opcode = words[0]
    if (opcode >> 12) != 0xE:
        return None

    # Memory shifts: 1110 0xx 011 mmm rrr
    if (opcode & 0xF8C0) == 0xE0C0:
        subop = (opcode >> 9) & 3  # 00=ASR, 01=LSR (wait, encoding is different)
        direction = (opcode >> 8) & 1  # 0=right, 1=left

        shift_type = (opcode >> 9) & 3
        names_r = ['asr.w', 'lsr.w', 'roxr.w', 'ror.w']
        names_l = ['asl.w', 'lsl.w', 'roxl.w', 'rol.w']

        name = names_l[shift_type] if direction else names_r[shift_type]
        ea_mode = (opcode >> 3) & 7
        ea_reg = opcode & 7
        # Memory shifts require memory alterable (not Dn or An)
        if ea_mode in (0, 1):
            return None
        ea_result = decode_ea(ea_mode, ea_reg, words, 1, '.w')
        if ea_result is None:
            return None
        ea_str, ea_ext = ea_result
        return f"{name}   {ea_str}", 1 + ea_ext

    # Register shifts: 1110 ccc d ss i tt rrr
    count = (opcode >> 9) & 7
    direction = (opcode >> 8) & 1  # 0=right, 1=left
    size_bits = (opcode >> 6) & 3
    if size_bits == 3:
        return None  # Memory shift (handled above)
    size_suffix = SIZE_NAMES[size_bits]
    ir = (opcode >> 5) & 1  # 0=immediate count, 1=register count
    shift_type = (opcode >> 3) & 3
    reg = opcode & 7

    names_r = ['asr', 'lsr', 'roxr', 'ror']
    names_l = ['asl', 'lsl', 'roxl', 'rol']
    name = names_l[shift_type] if direction else names_r[shift_type]

    if ir == 0:
        cnt = 8 if count == 0 else count
        return f"{name}{size_suffix}   #{cnt},{fmt_dn(reg)}", 1
    else:
        return f"{name}{size_suffix}   {fmt_dn(count)},{fmt_dn(reg)}", 1

    return None


# ---------------------------------------------------------------------------
# MOVEM register mask formatting
# ---------------------------------------------------------------------------

def reverse_mask(mask):
    """Reverse a 16-bit register mask (for predecrement addressing)."""
    result = 0
    for i in range(16):
        if mask & (1 << i):
            result |= (1 << (15 - i))
    return result

def format_regmask(mask):
    """Format a MOVEM register mask as a register list string."""
    regs = []
    # Bits 0-7: D0-D7, Bits 8-15: A0-A7
    for i in range(8):
        if mask & (1 << i):
            regs.append(f"d{i}")
    for i in range(8):
        if mask & (1 << (i + 8)):
            regs.append(f"a{i}")

    if not regs:
        return "#$0000"  # Empty mask (shouldn't happen)

    # Try to compress ranges: d0-d3/a0/a6
    return compress_reglist(regs)

def compress_reglist(regs):
    """Compress register list: ['d0','d1','d2','d3','a0','a6'] → 'd0-d3/a0/a6'"""
    groups = []
    d_regs = sorted([int(r[1]) for r in regs if r[0] == 'd'])
    a_regs = sorted([int(r[1]) for r in regs if r[0] == 'a'])

    for prefix, nums in [('d', d_regs), ('a', a_regs)]:
        i = 0
        while i < len(nums):
            start = nums[i]
            end = start
            while i + 1 < len(nums) and nums[i + 1] == end + 1:
                i += 1
                end = nums[i]
            if start == end:
                groups.append(f"{prefix}{start}")
            else:
                groups.append(f"{prefix}{start}-{prefix}{end}")
            i += 1

    return '/'.join(groups)


# ---------------------------------------------------------------------------
# Master instruction decoder
# ---------------------------------------------------------------------------

def decode_instruction(words):
    """Decode a 68K instruction from a list of hex words.

    Returns (mnemonic_string, num_words_consumed) or None.
    """
    if not words:
        return None

    opcode = words[0]
    group = (opcode >> 12) & 0xF

    if group == 0:
        return decode_group0(words)
    elif group in (1, 2, 3):
        return decode_move(words)
    elif group == 4:
        return decode_group4(words)
    elif group == 5:
        return decode_group5(words)
    elif group == 7:
        return decode_group7(words)
    elif group in (8, 9, 0xB, 0xC, 0xD):
        return decode_arith(words)
    elif group == 0xE:
        return decode_shift(words)

    return None


# ---------------------------------------------------------------------------
# File processing
# ---------------------------------------------------------------------------

# Pattern to match dc.w/DC.W lines with hex values
# Handles both formats:
#   dc.w    $XXXX,$YYYY     ; comment
#   DC.W    $XXXX,$YYYY; $ADDR MNEMONIC
DCW_PATTERN = re.compile(
    r'^(\s+)[Dd][Cc]\.[Ww]\s+'    # indent + dc.w/DC.W
    r'(\$[0-9A-Fa-f]+(?:\s*,\s*\$[0-9A-Fa-f]+)*)'  # hex values
    r'\s*(;.*)?$'                  # optional comment (may be adjacent)
)

def parse_hex_words(hex_str):
    """Parse '$XXXX,$YYYY,...' into list of integers."""
    parts = re.findall(r'\$([0-9A-Fa-f]+)', hex_str)
    return [int(p, 16) for p in parts]

def is_likely_data(line, comment):
    """Heuristic: does this dc.w line look like data rather than code?
    Only triggers on comments that clearly describe data, not code comments
    that happen to mention data-related words."""
    if comment:
        lower = comment.lower().strip().lstrip(';').strip()
        # Only match when the comment STARTS with data keywords
        # (i.e., the dc.w IS the data, not code that accesses data)
        data_starts = [
            'data ', 'data:', 'table ', 'table:',
            'padding', 'string ', 'string:',
            'lookup table', 'offset table',
            'pointer table', 'jump table',
            'vector table',
        ]
        if any(lower.startswith(kw) for kw in data_starts):
            return True
    return False

def process_dcw_line(line):
    """Process a single dc.w line. Returns (new_line, converted) tuple."""
    match = DCW_PATTERN.match(line.rstrip())
    if not match:
        return line, False

    indent = match.group(1)
    hex_str = match.group(2)
    comment = match.group(3) or ''

    words = parse_hex_words(hex_str)
    if not words:
        return line, False

    # Skip likely data lines
    if is_likely_data(line, comment):
        return line, False

    # Try to decode the instruction
    result = decode_instruction(words)
    if result is None:
        return line, False

    mnemonic, num_words = result

    # Check that we consumed all the words on this line
    if num_words != len(words):
        # The dc.w might contain multiple instructions or extra data
        # Only convert if we consumed exactly the right number of words
        return line, False

    # Build the original hex for the comment
    hex_comment = ' '.join(f"${w:04X}" for w in words)

    # Preserve any description from the original comment
    desc = ''
    if comment:
        # Strip leading ; and whitespace
        comment_text = comment.strip().lstrip(';').strip()
        # Try to find description after " - " or after the mnemonic annotation
        if ' - ' in comment_text:
            desc = comment_text.split(' - ', 1)[1].strip()
            desc = f" — {desc}"

    # Format: indent + mnemonic padded to col 40 + ; hex_comment + desc
    mnemonic_padded = f"{indent}{mnemonic}"
    # Pad to reasonable column for comment
    if len(mnemonic_padded) < 40:
        mnemonic_padded = mnemonic_padded.ljust(40)
    new_line = f"{mnemonic_padded}; {hex_comment}{desc}\n"

    return new_line, True


def process_file(filepath, dry_run=False):
    """Process a single .asm file. Returns (total_dcw, converted, failed)."""
    with open(filepath, 'r') as f:
        lines = f.readlines()

    new_lines = []
    total_dcw = 0
    converted = 0

    for line in lines:
        # Only process dc.w lines (lowercase, as in our codebase)
        # Match against original line (preserves leading whitespace)
        if re.match(r'\s+dc\.w\s+\$', line, re.IGNORECASE):
            total_dcw += 1
            new_line, was_converted = process_dcw_line(line)
            new_lines.append(new_line)
            if was_converted:
                converted += 1
        else:
            new_lines.append(line)

    if not dry_run and converted > 0:
        with open(filepath, 'w') as f:
            f.writelines(new_lines)

    return total_dcw, converted, total_dcw - converted


def find_asm_files(directory, exclude_sh2=True):
    """Recursively find all .asm files in directory.
    Excludes only actual SH2 machine code files (section_24200.asm, section_26200.asm)."""
    SH2_MACHINE_CODE = {'section_24200.asm', 'section_26200.asm'}
    result = []
    for root, dirs, files in os.walk(directory):
        for f in files:
            if f.endswith('.asm'):
                if exclude_sh2 and f in SH2_MACHINE_CODE:
                    continue
                result.append(os.path.join(root, f))
    return sorted(result)


# ---------------------------------------------------------------------------
# Label map for PC-relative resolution
# ---------------------------------------------------------------------------

# Global label map: ROM address -> label_name
# Module ranges: list of (start_addr, end_addr, entry_label)
_label_map = {}
_module_ranges = []


def _get_included_modules(disasm_root):
    """Get the set of module file paths that are actually included in the build.

    Scans section files and vrd.asm for include directives.
    Returns set of absolute file paths.
    """
    included = set()
    search_files = []

    sections_dir = os.path.join(disasm_root, 'sections')
    if os.path.isdir(sections_dir):
        for fname in os.listdir(sections_dir):
            if fname.endswith('.asm'):
                search_files.append(os.path.join(sections_dir, fname))

    vrd_path = os.path.join(disasm_root, 'vrd.asm')
    if os.path.isfile(vrd_path):
        search_files.append(vrd_path)

    include_pat = re.compile(r'include\s+"([^"]+)"', re.IGNORECASE)
    for fpath in search_files:
        try:
            with open(fpath, 'r') as f:
                for line in f:
                    m = include_pat.search(line)
                    if m:
                        inc_path = m.group(1)
                        abs_path = os.path.normpath(os.path.join(disasm_root, inc_path))
                        included.add(abs_path)
        except (IOError, OSError):
            pass

    return included


def build_label_map(disasm_root):
    """Build a comprehensive ROM address -> label map from all source files.

    Only includes labels from files that are part of the actual build.

    Scans:
    1. Module files included in the build (via section includes)
    2. Multi-function modules for internal labels with ROM address comments
    3. Section files for inline labels

    Populates global _label_map and _module_ranges.
    """
    global _label_map, _module_ranges
    _label_map = {}
    _module_ranges = []

    sections_dir = os.path.join(disasm_root, 'sections')

    # Get the set of modules actually included in the build
    included_modules = _get_included_modules(disasm_root)

    # --- Phase 1: Module entry labels from included modules ---
    # Only process files in modules/ directory (not section files which have
    # wide ROM ranges that would incorrectly map to single labels)
    SH2_MACHINE_CODE = {'section_24200.asm', 'section_26200.asm'}
    modules_marker = os.sep + 'modules' + os.sep
    for fpath in sorted(included_modules):
        if not fpath.endswith('.asm'):
            continue
        if os.path.basename(fpath) in SH2_MACHINE_CODE:
            continue
        if modules_marker not in fpath:
            continue  # Skip section files — they're handled in Phase 2
        _scan_module_labels(fpath)

    # --- Phase 2: Section files for inline labels ---
    if os.path.isdir(sections_dir):
        for fname in sorted(os.listdir(sections_dir)):
            if not fname.endswith('.asm'):
                continue
            fpath = os.path.join(sections_dir, fname)
            _scan_section_labels(fpath)


def _scan_module_labels(fpath):
    """Extract labels from a module file using ROM Range + address comments."""
    try:
        with open(fpath, 'r') as f:
            lines = f.readlines()
    except (IOError, OSError):
        return

    # Extract ROM Range
    rom_start = None
    rom_end = None
    for line in lines:
        m = re.match(r';\s*ROM Range:\s*\$([0-9A-Fa-f]+)-\$([0-9A-Fa-f]+)', line)
        if m:
            rom_start = int(m.group(1), 16)
            rom_end = int(m.group(2), 16)
            break

    # Also check multi-function header format: "Functions ($XXXX - $YYYY)"
    if rom_start is None:
        for line in lines:
            m = re.match(r';\s*\w.*\(\$([0-9A-Fa-f]+)\s*-\s*\$([0-9A-Fa-f]+)\)', line)
            if m:
                rom_start = int(m.group(1), 16)
                rom_end = int(m.group(2), 16)
                break

    if rom_start is None:
        return

    # Find entry label (first non-dot label)
    entry_label = None
    for line in lines:
        m = re.match(r'^([a-zA-Z_][a-zA-Z0-9_]*):', line)
        if m:
            entry_label = m.group(1)
            _label_map[rom_start] = entry_label
            break

    if entry_label and rom_end:
        _module_ranges.append((rom_start, rom_end, entry_label))

    # Scan for additional global labels with ROM address comments
    # Pattern: label followed by an instruction line with "; $XXXXXX" comment
    pending_label = None
    for line in lines:
        stripped = line.strip()

        # Check for global label
        m = re.match(r'^([a-zA-Z_][a-zA-Z0-9_]*):', stripped)
        if m:
            lbl = m.group(1)
            if lbl != entry_label:
                pending_label = lbl
            continue

        # Check for ROM address in comment for the pending label
        if pending_label:
            # Look for "; $XXXXXX:" or "; $XXXXXX " pattern in comments
            addr_match = re.search(r';\s*\$([0-9A-Fa-f]{5,6})[:\s]', stripped)
            if addr_match:
                addr = int(addr_match.group(1), 16)
                if addr < 0x300000:
                    _label_map[addr] = pending_label
            pending_label = None
            continue

        # Non-label, non-instruction line — reset pending
        if stripped and not stripped.startswith(';'):
            pending_label = None


def _scan_section_labels(fpath):
    """Extract labels from section files using address comments."""
    try:
        with open(fpath, 'r') as f:
            lines = f.readlines()
    except (IOError, OSError):
        return

    pending_label = None
    for line in lines:
        stripped = line.strip()

        # Check for global label (not local, not 'include', not 'org')
        m = re.match(r'^([a-zA-Z_][a-zA-Z0-9_]*):', stripped)
        if m:
            lbl = m.group(1)
            pending_label = lbl
            continue

        if pending_label:
            # Check for ROM address comment
            addr_match = re.search(r';\s*\$([0-9A-Fa-f]{5,6})[:\s]', stripped)
            if addr_match:
                addr = int(addr_match.group(1), 16)
                if addr < 0x300000:
                    _label_map[addr] = pending_label
                pending_label = None
                continue

            # Also check for dc.w with address in comment
            addr_match2 = re.search(r';\s*\$([0-9A-Fa-f]{5,6})$', stripped)
            if addr_match2:
                addr = int(addr_match2.group(1), 16)
                if addr < 0x300000:
                    _label_map[addr] = pending_label
                pending_label = None
                continue

            # If we see code or dc.w but no address comment, skip
            if stripped and not stripped.startswith(';') and not stripped.startswith('include'):
                pending_label = None


def resolve_pc_target(target_addr):
    """Resolve a PC-relative target address to a label expression.

    Returns:
        label_expression (str) or None if unresolvable.
    """
    # Direct label match
    if target_addr in _label_map:
        return _label_map[target_addr]

    # Find containing module and compute entry_label+offset
    for mstart, mend, entry_label in _module_ranges:
        if mstart < target_addr < mend:
            offset = target_addr - mstart
            return f"{entry_label}+{offset}"

    return None


# ---------------------------------------------------------------------------
# PC-relative instruction decoder
# ---------------------------------------------------------------------------

def extract_pc_relative_target(words, current_pc, comment):
    """Extract the target address for a PC-relative instruction.

    Uses multiple methods in priority order:
    1. Target address from comment (most reliable): "; JSR $TARGET(PC)"
    2. Computed from current_pc + displacement (fallback)

    Returns target address as int, or None.
    """
    opcode = words[0] if words else 0

    # Method 1: Extract target from comment annotations
    if comment:
        # Pattern: "JSR $XXXXXX(PC)" or "JMP $XXXXXX(PC)" or "BSR $XXXXXX(PC)"
        # or "LEA $XXXXXX(PC)" or "loc_XXXXXX(PC)"
        m = re.search(r'(?:JSR|JMP|BSR|LEA|loc_)\s*\$([0-9A-Fa-f]{5,6})\(PC\)', comment, re.IGNORECASE)
        if m:
            return int(m.group(1), 16)

        # Pattern: "→ $XXXXXX" (arrow to target)
        m = re.search(r'→\s*\$([0-9A-Fa-f]{5,6})', comment)
        if m:
            return int(m.group(1), 16)

        # Pattern: "jsr label(pc) → $XXXXXX"
        m = re.search(r'→\s*\$([0-9A-Fa-f]{5,6})', comment)
        if m:
            return int(m.group(1), 16)

    # Method 2: Compute from PC + displacement
    if current_pc is not None and len(words) >= 2:
        disp16 = words[1]
        if disp16 & 0x8000:
            disp_signed = disp16 - 0x10000
        else:
            disp_signed = disp16
        return (current_pc + 2 + disp_signed) & 0xFFFFFF

    return None


def decode_pc_relative(words, current_pc, comment=''):
    """Decode PC-relative instructions (JSR/JMP/BSR/LEA d16(PC)).

    Args:
        words: list of hex words from dc.w line
        current_pc: ROM address of this instruction (or None if unknown)
        comment: the dc.w line's comment string

    Returns:
        (mnemonic_string, num_words_consumed) or None
    """
    if not words or len(words) < 2:
        return None

    opcode = words[0]

    # Check if this is a PC-relative opcode before computing target
    is_jsr = (opcode == 0x4EBA)
    is_jmp = (opcode == 0x4EFA)
    is_bsr = (opcode == 0x6100)
    is_lea = ((opcode & 0xF1FF) == 0x41FA)

    if not (is_jsr or is_jmp or is_bsr or is_lea):
        return None

    target = extract_pc_relative_target(words, current_pc, comment)
    if target is None:
        return None

    label_expr = resolve_pc_target(target)
    if label_expr is None:
        return None

    # JSR d16(PC): $4EBA
    if is_jsr:
        return f"jsr     {label_expr}(pc)", 2

    # JMP d16(PC): $4EFA
    if is_jmp:
        return f"jmp     {label_expr}(pc)", 2

    # BSR.W: $6100
    # Note: BSR is a branch instruction — no (pc) suffix. It implicitly
    # uses PC-relative displacement like all Bcc/BRA/BSR instructions.
    if is_bsr:
        return f"bsr.w   {label_expr}", 2

    # LEA d16(PC),An: $41FA-$4DFA (pattern: 0100 nnn 111 111 010)
    if is_lea:
        an = (opcode >> 9) & 7
        return f"lea     {label_expr}(pc),{fmt_an(an)}", 2

    return None


# ---------------------------------------------------------------------------
# Branch instruction decoder
# ---------------------------------------------------------------------------

CC_NAMES = ['ra', 'sr', 'hi', 'ls', 'cc', 'cs', 'ne', 'eq',
            'vc', 'vs', 'pl', 'mi', 'ge', 'lt', 'gt', 'le']


def decode_branch(words, current_pc, local_labels):
    """Decode branch instructions (Bcc.S, Bcc.W, BRA, BSR.S).

    Branches are always within the same module, so we use local labels.

    Args:
        words: hex words from dc.w line
        current_pc: ROM address of this instruction
        local_labels: dict of {rom_addr: '.label_name'} within current module

    Returns:
        (mnemonic_string, num_words_consumed) or None
    """
    if not words or current_pc is None:
        return None

    opcode = words[0]
    group = (opcode >> 8) & 0xFF

    # Bcc/BRA/BSR: group 6 (0110 cccc dddddddd)
    if (group & 0xF0) != 0x60:
        return None

    cond = (group & 0x0F)
    disp8 = opcode & 0xFF

    if disp8 == 0x00:
        # Bcc.W: 16-bit displacement in next word
        if len(words) < 2:
            return None
        disp16 = words[1]
        if disp16 & 0x8000:
            disp_signed = disp16 - 0x10000
        else:
            disp_signed = disp16
        target = (current_pc + 2 + disp_signed) & 0xFFFFFF

        # Check if target has a local label
        if target not in local_labels:
            return None
        label = local_labels[target]

        cond_name = CC_NAMES[cond]
        if cond == 0:  # BRA.W
            return f"bra.w   {label}", 2
        elif cond == 1:  # BSR.W — handled by decode_pc_relative
            return None
        else:
            return f"b{cond_name}.w   {label}", 2

    elif disp8 == 0xFF:
        # Bcc.L (68020+ only, not valid for 68000)
        return None

    else:
        # Bcc.S: 8-bit displacement in opcode
        if disp8 & 0x80:
            disp_signed = disp8 - 256
        else:
            disp_signed = disp8
        target = (current_pc + 2 + disp_signed) & 0xFFFFFF

        # Check if target has a local label
        if target not in local_labels:
            return None
        label = local_labels[target]

        cond_name = CC_NAMES[cond]
        if cond == 0:  # BRA.S
            return f"bra.s   {label}", 1
        elif cond == 1:  # BSR.S
            return f"bsr.s   {label}", 1
        else:
            return f"b{cond_name}.s   {label}", 1


def decode_dbcc(words, current_pc, local_labels):
    """Decode DBcc instructions.

    Args:
        words: hex words from dc.w line
        current_pc: ROM address of this instruction
        local_labels: dict of {rom_addr: '.label_name'} within current module

    Returns:
        (mnemonic_string, num_words_consumed) or None
    """
    if not words or len(words) < 2 or current_pc is None:
        return None

    opcode = words[0]

    # DBcc: 0101 cccc 1100 1 rrr
    if (opcode & 0xF0F8) != 0x50C8:
        return None

    cond = (opcode >> 8) & 0xF
    reg = opcode & 7

    disp16 = words[1]
    if disp16 & 0x8000:
        disp_signed = disp16 - 0x10000
    else:
        disp_signed = disp16
    target = (current_pc + 2 + disp_signed) & 0xFFFFFF

    if target not in local_labels:
        return None
    label = local_labels[target]

    cc_names = ['t', 'f', 'hi', 'ls', 'cc', 'cs', 'ne', 'eq',
                'vc', 'vs', 'pl', 'mi', 'ge', 'lt', 'gt', 'le']

    return f"db{cc_names[cond]}     {fmt_dn(reg)},{label}", 2


# ---------------------------------------------------------------------------
# Address extraction from dc.w comments
# ---------------------------------------------------------------------------

def extract_current_pc(comment):
    """Extract the current PC (source address) from a dc.w comment.

    Handles formats:
        ; JSR $00B77C(PC); $005AB6    -> returns $005AB6 (after semicolon separator)
        ; BNE.S $007C56; $007C52      -> returns $007C52 (after semicolon separator)
        ; BRA.S $0092AE; $009310      -> returns $009310 (after semicolon separator)

    Does NOT match formats where the address is a target, not source:
        ; jmp state_advance(pc) → $00B25E   -> returns None (no source PC)
    """
    if not comment:
        return None

    # Strip leading "; " comment marker
    text = comment.strip()
    if not text.startswith(';'):
        return None
    text = text[1:].strip()

    # Look for source PC after a semicolon SEPARATOR within the comment
    # Pattern: "...; $XXXXXX" where ; is a separator (not the comment start)
    # This distinguishes "; JSR $TARGET(PC); $SOURCE" from "; → $TARGET"
    sep_match = re.search(r';\s*\$([0-9A-Fa-f]{5,6})\s*$', text)
    if sep_match:
        addr = int(sep_match.group(1), 16)
        if addr < 0x300000:
            return addr

    # Also match format: "$XXXXXX  INSTR" (source at start of comment)
    start_match = re.match(r'\$([0-9A-Fa-f]{6})\s+\w', text)
    if start_match:
        addr = int(start_match.group(1), 16)
        if addr < 0x300000:
            return addr

    return None


# ---------------------------------------------------------------------------
# Module-level label and address scanner for branch resolution
# ---------------------------------------------------------------------------

def scan_module_addresses(lines):
    """Scan a module's lines to build:
    1. local_labels: {rom_addr: '.label_name'} for all local labels
    2. global_labels: {rom_addr: 'label_name'} for all global labels within module
    3. line_addrs: {line_index: rom_addr} for lines with address comments

    Uses ROM Range header and address comments on instruction lines.
    """
    local_labels = {}
    global_labels = {}
    line_addrs = {}

    # Get ROM Range start
    rom_start = None
    for line in lines:
        m = re.match(r';\s*ROM Range:\s*\$([0-9A-Fa-f]+)', line)
        if m:
            rom_start = int(m.group(1), 16)
            break
    # Also check multi-function header
    if rom_start is None:
        for line in lines:
            m = re.match(r';\s*\w.*\(\$([0-9A-Fa-f]+)\s*-\s*\$([0-9A-Fa-f]+)\)', line)
            if m:
                rom_start = int(m.group(1), 16)
                break

    if rom_start is None:
        return local_labels, global_labels, line_addrs

    # Walk lines tracking addresses
    current_addr = rom_start
    uncertain = False
    pending_label = None
    pending_label_type = None  # 'local' or 'global'

    for i, line in enumerate(lines):
        stripped = line.strip()

        if not stripped or stripped.startswith(';'):
            continue

        # Global label
        m = re.match(r'^([a-zA-Z_][a-zA-Z0-9_]*):', stripped)
        if m:
            pending_label = m.group(1)
            pending_label_type = 'global'
            if not uncertain:
                global_labels[current_addr] = pending_label
            continue

        # Local label
        m = re.match(r'^(\.[a-zA-Z_][a-zA-Z0-9_]*):', stripped)
        if m:
            pending_label = m.group(1)
            pending_label_type = 'local'
            if not uncertain:
                local_labels[current_addr] = pending_label
            continue

        # Separate code and comment
        if ';' in stripped:
            code_part = stripped[:stripped.index(';')].strip()
            comment_part = stripped[stripped.index(';'):]
        else:
            code_part = stripped
            comment_part = ''

        if not code_part:
            continue

        # Try to extract ROM address from comment
        rom_addr = None
        # Format: "; $XXXXXX:" or "; $XXXXXX " (6-digit, colon or space after)
        addr_match = re.search(r';\s*\$([0-9A-Fa-f]{5,6})[:\s]', comment_part)
        if addr_match:
            addr_val = int(addr_match.group(1), 16)
            if addr_val < 0x300000:
                rom_addr = addr_val
        # Also check end-of-line format: "    ; $XXXXXX"
        if rom_addr is None:
            addr_match2 = re.search(r';\s*\$([0-9A-Fa-f]{6})$', comment_part)
            if addr_match2:
                addr_val = int(addr_match2.group(1), 16)
                if addr_val < 0x300000:
                    rom_addr = addr_val

        if rom_addr is not None:
            current_addr = rom_addr
            uncertain = False
            # Register pending label at this address
            if pending_label:
                if pending_label_type == 'local':
                    local_labels[current_addr] = pending_label
                else:
                    global_labels[current_addr] = pending_label
                pending_label = None

        # Extract PC from dc.w comment (e.g., "; BNE.S $TARGET; $SOURCE")
        if rom_addr is None and comment_part:
            pc_addr = extract_current_pc(comment_part)
            if pc_addr is not None:
                current_addr = pc_addr
                uncertain = False
                if pending_label:
                    if pending_label_type == 'local':
                        local_labels[current_addr] = pending_label
                    else:
                        global_labels[current_addr] = pending_label
                    pending_label = None

        # Record this line's address (only when tracking is reliable)
        if not uncertain:
            line_addrs[i] = current_addr

        # Advance by instruction size
        # dc.w line: count hex values
        dcw_match = re.match(r'[Dd][Cc]\.[Ww]\s+(\$[0-9A-Fa-f]+(?:\s*,\s*\$[0-9A-Fa-f]+)*)',
                             code_part)
        if dcw_match:
            hex_vals = re.findall(r'\$[0-9A-Fa-f]+', dcw_match.group(1))
            current_addr += len(hex_vals) * 2
            pending_label = None
            continue

        # Hex opcode comment: count words
        hex_words = re.findall(r'\$[0-9A-Fa-f]{4}', comment_part)
        if hex_words and all(re.match(r'^\$[0-9A-Fa-f]{4}$', w) for w in
                            comment_part.strip().lstrip(';').strip().split()[:len(hex_words)]):
            current_addr += len(hex_words) * 2
            pending_label = None
            continue

        # For mnemonic lines without hex comments, try to estimate size
        # but mark uncertain for safety
        if rom_addr is not None:
            # We anchored from ROM address; advance by a reasonable estimate
            uncertain = True
        else:
            uncertain = True

        pending_label = None

    return local_labels, global_labels, line_addrs


# ---------------------------------------------------------------------------
# Enhanced file processing with PC-relative and branch support
# ---------------------------------------------------------------------------

def process_file_phase2(filepath, label_map, module_ranges, dry_run=False):
    """Process a file with PC-relative and branch resolution.

    Args:
        filepath: path to .asm file
        label_map: {rom_addr: label_name} global label map
        module_ranges: [(start, end, entry_label)] for offset computation
        dry_run: if True, don't write changes

    Returns:
        (total_dcw, converted, remaining)
    """
    with open(filepath, 'r') as f:
        lines = f.readlines()

    # Scan this module for local labels and addresses
    local_labels, global_labels_in_mod, line_addrs = scan_module_addresses(lines)

    # Merge: for branch resolution, targets can be local or global labels within module
    branch_targets = {}
    branch_targets.update(local_labels)
    branch_targets.update(global_labels_in_mod)

    new_lines = []
    total_dcw = 0
    converted = 0

    for i, line in enumerate(lines):
        if not re.match(r'\s+[Dd][Cc]\.[Ww]\s+\$', line):
            new_lines.append(line)
            continue

        total_dcw += 1

        # First try Phase 1 decoder (non-PC-relative)
        new_line, was_converted = process_dcw_line(line)
        if was_converted:
            new_lines.append(new_line)
            converted += 1
            continue

        # Try PC-relative and branch decoders
        match = DCW_PATTERN.match(line.rstrip())
        if not match:
            new_lines.append(line)
            continue

        indent = match.group(1)
        hex_str = match.group(2)
        comment = match.group(3) or ''

        words = parse_hex_words(hex_str)
        if not words:
            new_lines.append(line)
            continue

        if is_likely_data(line, comment):
            new_lines.append(line)
            continue

        # Get current PC from comment or line_addrs
        current_pc = line_addrs.get(i)
        if current_pc is None:
            current_pc = extract_current_pc(comment)

        mnemonic = None
        num_words = None

        # Try PC-relative decoder
        if current_pc is not None:
            result = decode_pc_relative(words, current_pc, comment)
            if result:
                mnemonic, num_words = result

        # Try branch decoder
        if mnemonic is None and current_pc is not None:
            result = decode_branch(words, current_pc, branch_targets)
            if result:
                mnemonic, num_words = result

        # Try DBcc decoder
        if mnemonic is None and current_pc is not None:
            result = decode_dbcc(words, current_pc, branch_targets)
            if result:
                mnemonic, num_words = result

        if mnemonic is None or num_words != len(words):
            new_lines.append(line)
            continue

        # Build output line
        hex_comment = ' '.join(f"${w:04X}" for w in words)
        desc = ''
        if comment:
            comment_text = comment.strip().lstrip(';').strip()
            if ' - ' in comment_text:
                desc = comment_text.split(' - ', 1)[1].strip()
                desc = f" — {desc}"

        mnemonic_padded = f"{indent}{mnemonic}"
        if len(mnemonic_padded) < 40:
            mnemonic_padded = mnemonic_padded.ljust(40)
        new_line = f"{mnemonic_padded}; {hex_comment}{desc}\n"
        new_lines.append(new_line)
        converted += 1

    if not dry_run and converted > 0:
        with open(filepath, 'w') as f:
            f.writelines(new_lines)

    return total_dcw, converted, total_dcw - converted


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    import argparse
    parser = argparse.ArgumentParser(description='Translate dc.w to 68K mnemonics')
    parser.add_argument('target', help='File or directory to process')
    parser.add_argument('--batch', action='store_true', help='Process all .asm files in directory tree')
    parser.add_argument('--dry-run', action='store_true', help='Preview changes without writing')
    parser.add_argument('--stats', action='store_true', help='Show statistics only')
    parser.add_argument('--verbose', '-v', action='store_true', help='Show per-file details')
    parser.add_argument('--phase2', action='store_true',
                        help='Enable Phase 2: PC-relative, branch, and DBcc translation')
    parser.add_argument('--disasm-root', default=None,
                        help='Path to disasm/ root (for label map building in Phase 2)')
    args = parser.parse_args()

    if args.batch or args.stats or os.path.isdir(args.target):
        files = find_asm_files(args.target)
    else:
        files = [args.target]

    # Build label map for Phase 2
    if args.phase2:
        disasm_root = args.disasm_root
        if disasm_root is None:
            # Auto-detect: walk up from target to find disasm/
            test_path = os.path.abspath(args.target)
            while test_path and test_path != '/':
                candidate = os.path.join(test_path, 'sections')
                if os.path.isdir(candidate):
                    disasm_root = test_path
                    break
                test_path = os.path.dirname(test_path)
            if disasm_root is None:
                # Try relative to script location
                script_dir = os.path.dirname(os.path.abspath(__file__))
                disasm_root = os.path.join(os.path.dirname(script_dir), 'disasm')

        print(f"Building label map from {disasm_root}...")
        build_label_map(disasm_root)
        print(f"Label map: {len(_label_map)} labels, {len(_module_ranges)} module ranges")

    grand_total = 0
    grand_converted = 0
    grand_remaining = 0
    files_modified = 0

    for filepath in files:
        if args.phase2:
            total, conv, remaining = process_file_phase2(
                filepath, _label_map, _module_ranges,
                dry_run=args.dry_run or args.stats)
        else:
            total, conv, remaining = process_file(filepath, dry_run=args.dry_run or args.stats)
        grand_total += total
        grand_converted += conv
        grand_remaining += remaining
        if conv > 0:
            files_modified += 1
        if (args.verbose or not (args.batch or args.stats)) and (total > 0):
            status = "[DRY RUN] " if args.dry_run else ""
            print(f"{status}{filepath}: {conv}/{total} converted, {remaining} remaining")

    action = "Would convert" if (args.dry_run or args.stats) else "Converted"
    print(f"\n{'='*60}")
    print(f"Files scanned:    {len(files)}")
    print(f"Files with dc.w:  {files_modified + (grand_remaining > 0 and not files_modified)}")
    print(f"Files modified:   {files_modified}")
    print(f"Total dc.w lines: {grand_total}")
    print(f"{action}:       {grand_converted}")
    print(f"Remaining:        {grand_remaining}")
    if grand_total > 0:
        pct = grand_converted / grand_total * 100
        print(f"Conversion rate:  {pct:.1f}%")
    print(f"{'='*60}")


if __name__ == '__main__':
    main()
