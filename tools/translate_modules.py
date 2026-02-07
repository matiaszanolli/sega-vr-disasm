#!/usr/bin/env python3
"""
Translate dc.w hex opcodes to proper 68K assembly mnemonics in module files.

Processes fn_* module files in disasm/modules/68k/game/:
- Parses ROM Range from module headers
- Disassembles from ROM binary using ProperDisassembler
- Outputs proper mnemonics with local labels for branch targets
- Keeps dc.w for instructions the disassembler can't decode

Usage:
    python3 translate_modules.py <rom_file> [--dry-run] [--module <pattern>]
"""

import argparse
import re
import struct
import sys
from pathlib import Path
from collections import defaultdict

sys.path.insert(0, str(Path(__file__).parent))
from disasm_to_asm import ProperDisassembler


MODULES_DIR = Path('disasm/modules/68k/game')


def parse_module(module_path):
    """Parse a module file and extract metadata.

    Returns dict with: func_name, start, end, size, header_lines, has_dcw
    or None if the module doesn't need translation.
    """
    with open(module_path) as f:
        content = f.read()
        lines = content.split('\n')

    # Extract ROM range
    range_match = re.search(
        r'ROM Range: \$([0-9A-Fa-f]+)-\$([0-9A-Fa-f]+) \((\d+) bytes\)',
        content
    )
    if not range_match:
        return None

    start = int(range_match.group(1), 16)
    end = int(range_match.group(2), 16)
    size = int(range_match.group(3))

    # Extract function name (label line)
    func_name = None
    for line in lines:
        m = re.match(r'^(\w+):$', line.rstrip())
        if m:
            func_name = m.group(1)
            break

    if not func_name:
        return None

    # Check if already translated (has non-dc.w instructions)
    dcw_count = 0
    mnemonic_count = 0
    for line in lines:
        stripped = line.strip()
        if stripped.startswith('dc.w') or stripped.startswith('DC.W'):
            dcw_count += 1
        elif stripped and not stripped.startswith(';') and not stripped.startswith('.') and ':' not in stripped and stripped != '':
            # Looks like an instruction mnemonic
            if any(stripped.startswith(m) for m in [
                'move', 'MOVE', 'add', 'ADD', 'sub', 'SUB', 'lea', 'LEA',
                'bra', 'BRA', 'bsr', 'BSR', 'bne', 'BNE', 'beq', 'BEQ',
                'rts', 'RTS', 'clr', 'CLR', 'tst', 'TST', 'cmp', 'CMP',
                'and', 'AND', 'or', 'OR', 'eor', 'EOR', 'lsr', 'LSR',
                'lsl', 'LSL', 'asl', 'ASL', 'asr', 'ASR', 'jsr', 'JSR',
                'jmp', 'JMP', 'ext', 'EXT', 'swap', 'SWAP', 'neg', 'NEG',
                'not', 'NOT', 'nop', 'NOP', 'moveq', 'MOVEQ', 'dbra', 'DBRA',
                'movem', 'MOVEM', 'btst', 'BTST', 'bset', 'BSET',
                'bclr', 'BCLR', 'divs', 'DIVS', 'divu', 'DIVU',
                'muls', 'MULS', 'mulu', 'MULU', 'pea', 'PEA',
                'link', 'LINK', 'unlk', 'UNLK', 'trap', 'TRAP',
                'rte', 'RTE', 'addq', 'ADDQ', 'subq', 'SUBQ',
            ]):
                mnemonic_count += 1

    if dcw_count == 0:
        return None  # No dc.w to translate

    if mnemonic_count > dcw_count:
        return None  # Already mostly translated

    # Get header lines (everything before the first dc.w)
    header_lines = []
    for line in lines:
        stripped = line.strip()
        if stripped.startswith('dc.w') or stripped.startswith('DC.W'):
            break
        header_lines.append(line)

    return {
        'func_name': func_name,
        'start': start,
        'end': end,
        'size': size,
        'header_lines': header_lines,
        'dcw_count': dcw_count,
        'mnemonic_count': mnemonic_count,
    }


def translate_module(rom_data, module_path, info, dry_run=False):
    """Translate a single module from dc.w to mnemonics.

    Returns (success, stats_dict).
    """
    start = info['start']
    end = info['end']  # end is exclusive (start + size)
    func_name = info['func_name']

    disasm = ProperDisassembler(rom_data)

    # First pass: disassemble and find branch targets
    instructions = []  # (offset, size, asm_str)
    branch_targets = set()
    offset = start

    while offset < end:
        result = disasm.disassemble_instruction(offset, {})
        instr_size = result['size']

        # Don't let instructions extend past function end
        if offset + instr_size > end:
            # Emit remaining as dc.w
            while offset < end:
                w = struct.unpack('>H', rom_data[offset:offset+2])[0]
                instructions.append((offset, 2, f'DC.W    ${w:04X}'))
                offset += 2
            break

        instructions.append((offset, instr_size, result['asm']))

        # Extract branch targets
        opcode = struct.unpack('>H', rom_data[offset:offset+2])[0]
        _extract_branch_targets(rom_data, offset, opcode, branch_targets, start, end)

        offset += instr_size

    # Detect data-heavy modules: if >50% of instructions are fallbacks, skip
    # These are likely data tables misidentified as functions
    first_pass_fallbacks = len(disasm.fallbacks)
    total_instrs = len(instructions)
    if total_instrs > 0 and first_pass_fallbacks / total_instrs > 0.5:
        return False, {
            'translated': 0,
            'fallback': total_instrs,
            'labels': 0,
            'reason': f'data-heavy ({first_pass_fallbacks}/{total_instrs} fallbacks)',
        }

    # Filter branch targets to only those within function and at instruction boundaries
    instr_addrs = {addr for addr, _, _ in instructions}
    internal_targets = {t for t in branch_targets if start <= t < end and t in instr_addrs}

    # Create local label map: offset -> .loc_XX
    label_map = {}
    for i, target in enumerate(sorted(internal_targets)):
        # Use offset relative to function start for readable label names
        rel_offset = target - start
        label_map[target] = f'.loc_{rel_offset:04X}'

    # Second pass: re-disassemble with labels
    final_instructions = []
    for addr, size, _ in instructions:
        result = disasm.disassemble_instruction(addr, label_map)
        asm = result['asm']

        needs_dcw_fallback = False

        # Check for PC-relative references outside the function ($XXXXXX(PC))
        if '(PC)' in asm and not any(lbl in asm for lbl in label_map.values()):
            needs_dcw_fallback = True

        # Check for branches/jumps to external addresses (raw $XXXXXX targets)
        # These appear as BNE.S $031502, BSR.W $00A200, etc.
        if not needs_dcw_fallback:
            opcode = struct.unpack('>H', rom_data[addr:addr+2])[0]
            ext_target = _get_branch_target(rom_data, addr, opcode)
            if ext_target is not None and not (start <= ext_target < end):
                needs_dcw_fallback = True

        if needs_dcw_fallback:
            words = []
            for i in range(0, size, 2):
                w = struct.unpack('>H', rom_data[addr+i:addr+i+2])[0]
                words.append(f'${w:04X}')
            dcw_str = ','.join(words)
            asm = f'DC.W    {dcw_str:20s}; {asm}'

        final_instructions.append((addr, size, asm))

    # Count stats
    translated = sum(1 for _, _, a in final_instructions if not a.strip().startswith('DC.W'))
    fallback = sum(1 for _, _, a in final_instructions if a.strip().startswith('DC.W'))

    if dry_run:
        return True, {
            'translated': translated,
            'fallback': fallback,
            'labels': len(label_map),
        }

    # Generate output
    out = []

    # Preserve original header (comments + empty line + function label)
    for line in info['header_lines']:
        out.append(line)

    # Add translated instructions
    for addr, size, asm in final_instructions:
        # Add label if this address has one
        if addr in label_map:
            out.append(f'{label_map[addr]}:')

        out.append(f'        {asm:40s}; ${addr:06X}')

    out.append('')  # trailing newline

    with open(module_path, 'w') as f:
        f.write('\n'.join(out))

    return True, {
        'translated': translated,
        'fallback': fallback,
        'labels': len(label_map),
    }


def _get_branch_target(rom_data, offset, opcode):
    """Get the target address of a branch/jump instruction, or None if not a branch."""
    def read_word(off):
        if off + 2 > len(rom_data):
            return 0
        return struct.unpack('>H', rom_data[off:off+2])[0]

    def read_long(off):
        if off + 4 > len(rom_data):
            return 0
        return struct.unpack('>I', rom_data[off:off+4])[0]

    # Bcc/BRA/BSR - 6xxx
    if (opcode & 0xF000) == 0x6000:
        disp = opcode & 0xFF
        if disp == 0:
            disp = read_word(offset + 2)
            if disp & 0x8000:
                disp = disp - 0x10000
        elif disp == 0xFF:
            return None  # 32-bit (68020+)
        else:
            if disp & 0x80:
                disp = disp - 256
        return offset + 2 + disp

    # DBcc - 5xC8-5xCF
    if (opcode & 0xF0F8) == 0x50C8:
        disp = read_word(offset + 2)
        if disp & 0x8000:
            disp = disp - 0x10000
        return offset + 2 + disp

    # JSR/JMP PC-relative (4EBA/4EFA)
    if opcode in (0x4EBA, 0x4EFA):
        disp = read_word(offset + 2)
        if disp & 0x8000:
            disp = disp - 0x10000
        return offset + 2 + disp

    return None


def _extract_branch_targets(rom_data, offset, opcode, targets, func_start, func_end):
    """Extract branch/jump targets from an instruction."""
    def read_word(off):
        if off + 2 > len(rom_data):
            return 0
        return struct.unpack('>H', rom_data[off:off+2])[0]

    def read_long(off):
        if off + 4 > len(rom_data):
            return 0
        return struct.unpack('>I', rom_data[off:off+4])[0]

    # Bcc (conditional branches) - 6xxx
    if (opcode & 0xF000) == 0x6000:
        disp = opcode & 0xFF
        if disp == 0:
            disp = read_word(offset + 2)
            if disp & 0x8000:
                disp = disp - 0x10000
        elif disp == 0xFF:
            return  # 32-bit displacement (68020+)
        else:
            if disp & 0x80:
                disp = disp - 256
        target = offset + 2 + disp
        targets.add(target)

    # DBcc - 5xC8-5xCF
    elif (opcode & 0xF0F8) == 0x50C8:
        disp = read_word(offset + 2)
        if disp & 0x8000:
            disp = disp - 0x10000
        target = offset + 2 + disp
        targets.add(target)


def find_untranslated_modules():
    """Find all fn_ modules that need translation."""
    modules = []
    for asm_file in sorted(MODULES_DIR.glob('fn_*.asm')):
        modules.append(asm_file)
    return modules


def main():
    parser = argparse.ArgumentParser(
        description='Translate dc.w to proper 68K assembly in module files'
    )
    parser.add_argument('rom_file', type=Path, help='ROM file for disassembly')
    parser.add_argument('--dry-run', action='store_true', help='Show stats without modifying')
    parser.add_argument('--module', type=str, help='Only process modules matching pattern')
    parser.add_argument('--verbose', '-v', action='store_true', help='Show per-module details')
    args = parser.parse_args()

    if not args.rom_file.exists():
        print(f"Error: ROM file {args.rom_file} not found")
        sys.exit(1)

    with open(args.rom_file, 'rb') as f:
        rom_data = f.read()
    print(f"ROM: {args.rom_file} ({len(rom_data):,} bytes)")

    modules = find_untranslated_modules()
    if args.module:
        modules = [m for m in modules if args.module in str(m)]

    print(f"Found {len(modules)} fn_* modules")

    total_translated = 0
    total_fallback = 0
    total_labels = 0
    total_converted = 0
    total_skipped = 0

    for module_path in modules:
        info = parse_module(module_path)
        if info is None:
            total_skipped += 1
            if args.verbose:
                print(f"  SKIP {module_path.name} (already translated or no dc.w)")
            continue

        success, stats = translate_module(rom_data, module_path, info, dry_run=args.dry_run)
        if success:
            total_converted += 1
            total_translated += stats['translated']
            total_fallback += stats['fallback']
            total_labels += stats['labels']
            if args.verbose:
                pct = stats['translated'] / max(1, stats['translated'] + stats['fallback']) * 100
                print(f"  {module_path.name}: {stats['translated']} mnemonics, "
                      f"{stats['fallback']} dc.w, {stats['labels']} labels ({pct:.0f}%)")
        else:
            total_skipped += 1
            if args.verbose:
                reason = stats.get('reason', 'unknown')
                print(f"  SKIP {module_path.name} ({reason})")

    print(f"\n{'='*60}")
    print(f"{'[DRY RUN] ' if args.dry_run else ''}Summary:")
    print(f"  Modules converted: {total_converted}")
    print(f"  Modules skipped:   {total_skipped}")
    print(f"  Instructions as mnemonics: {total_translated}")
    print(f"  Instructions as dc.w:      {total_fallback}")
    print(f"  Local labels created:       {total_labels}")
    if total_translated + total_fallback > 0:
        pct = total_translated / (total_translated + total_fallback) * 100
        print(f"  Translation rate:           {pct:.1f}%")


if __name__ == '__main__':
    main()
