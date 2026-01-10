#!/usr/bin/env python3
"""
Annotate assembly: Convert dc.w statements to proper 68K mnemonics.

This tool reads assembly files with dc.w + disassembly comments and
converts them to proper instructions while preserving labels and comments.
"""

import re
import struct
from pathlib import Path

# Known function labels from analysis
KNOWN_LABELS = {
    # Entry/Init
    0x03F0: "EntryPoint",
    0x04C0: "RAM_InitCode",
    0x04D4: "VDP_InitTable",
    0x04E8: "Z80_InitData",
    0x0512: "SecurityStrings",
    0x05A6: "InitVDPRegs",
    0x05CE: "ClearVDPRAM",
    0x0654: "Init32XVDP",
    0x0694: "ClearFrameBuffer",
    0x06BC: "ClearWorkRAM",
    0x06E4: "SecurityLoop",
    0x06E8: "MARSRegInit",
    0x07EC: "ErrorPath1",
    0x07FC: "ErrorPath2",
    0x0832: "DefaultExceptionHandler",
    0x0838: "MARSAdapterInit",
    0x08A8: "SH2Handshake",
    0x0FBE: "CopyInitCode",
    0x1140: "RLEDecompressor",
    0x11E4: "ByteStreamDecoder",
    0x12F4: "BitFieldExtractor",
    0x13A4: "BitBufferRefill",
    0x13B4: "LZ77Decoder",
    0x14BE: "TableLookup",
    0x1684: "V_INT_Handler",
    0x170A: "H_INT_Handler",
    0x179E: "ControllerRead",
    0x17EE: "MapButtonBits",
    0x185E: "Read6ButtonPad",
    # Low Code
    0x204A: "ClearInputState",
    0x205E: "SetInputFlag",
    0x2066: "InitInputSystem",
    0x2080: "UpdateInputState",
    0x20C6: "ExtendedInputProcess",
    0x21CA: "CopyInputState",
    0x26C8: "VDPFrameControl",
    0x2742: "VDPAutoFill",
    # Main hotspots
    0x4998: "WaitForVBlank",
    0x49AA: "SetDisplayParams",
    0xFB36: "SendDREQCommand",
}

# Address constants for reference
MARS_REGISTERS = {
    0xA10000: "IO_BASE",
    0xA15100: "MARS_ADAPTER_CTRL",
    0xA15101: "MARS_INT_CTRL",
    0xA15120: "MARS_COMM0",
    0xA15122: "MARS_COMM2",
    0xA15124: "MARS_COMM4",
    0xA15126: "MARS_COMM6",
    0xA15128: "MARS_COMM8",
    0xA1512A: "MARS_COMM10",
    0xA1512C: "MARS_COMM12",
    0xA1512E: "MARS_COMM14",
    0xC00000: "VDP_DATA",
    0xC00004: "VDP_CTRL",
    0xC00011: "PSG_PORT",
}


def parse_dc_line(line):
    """Parse a dc.w line and extract values and comment."""
    # Match pattern: dc.w $XXXX, $YYYY, ...  ; address: disasm
    match = re.match(r'\s*dc\.w\s+(.+?)\s*;\s*([0-9A-Fa-f]+):\s*(.+)', line)
    if not match:
        return None

    values_str = match.group(1)
    addr_str = match.group(2)
    disasm = match.group(3).strip()

    # Parse hex values
    values = []
    for v in re.findall(r'\$([0-9A-Fa-f]+)', values_str):
        values.append(int(v, 16))

    addr = int(addr_str, 16)

    return {
        'addr': addr,
        'values': values,
        'disasm': disasm,
        'raw': line
    }


def convert_to_mnemonic(parsed):
    """Convert parsed dc.w to proper mnemonic if possible."""
    if not parsed:
        return None

    disasm = parsed['disasm']
    values = parsed['values']
    addr = parsed['addr']

    # Skip if already "dc.w $XXXX" (unknown opcode)
    if disasm.startswith('dc.w ') or disasm.startswith('dc.b '):
        return None

    # Map common instructions to proper assembly
    # Format: instruction + operands

    # Clean up disasm - it should be the mnemonic
    parts = disasm.split()
    if not parts:
        return None

    mnemonic = parts[0]
    operands = ' '.join(parts[1:]) if len(parts) > 1 else ''

    # Build the assembly line
    if operands:
        asm_line = f"        {mnemonic:8s}{operands}"
    else:
        asm_line = f"        {mnemonic}"

    return asm_line


def annotate_file(input_path, output_path=None):
    """Annotate an assembly file by converting dc.w to mnemonics."""
    content = Path(input_path).read_text()
    lines = content.split('\n')

    output_lines = []
    converted = 0
    total_dcw = 0

    for line in lines:
        # Check for dc.w lines
        if 'dc.w' in line and ';' in line:
            total_dcw += 1
            parsed = parse_dc_line(line)
            if parsed:
                mnemonic = convert_to_mnemonic(parsed)
                if mnemonic:
                    # Check if we need to add a label
                    file_addr = parsed['addr'] - 0x880000
                    if file_addr in KNOWN_LABELS:
                        output_lines.append(f"\n{KNOWN_LABELS[file_addr]}:")

                    # Add the converted mnemonic with original as comment
                    output_lines.append(f"{mnemonic:48s}; {parsed['addr']:08X}")
                    converted += 1
                    continue

        # Keep line as-is
        output_lines.append(line)

    result = '\n'.join(output_lines)

    if output_path:
        Path(output_path).write_text(result)
        print(f"Converted {converted}/{total_dcw} dc.w statements")
        print(f"Written to {output_path}")

    return result


def main():
    import sys
    if len(sys.argv) < 2:
        print("Usage: annotate_asm.py <input.asm> [output.asm]")
        print("If output not specified, writes to input_annotated.asm")
        sys.exit(1)

    input_path = sys.argv[1]
    if len(sys.argv) > 2:
        output_path = sys.argv[2]
    else:
        p = Path(input_path)
        output_path = p.parent / f"{p.stem}_annotated{p.suffix}"

    annotate_file(input_path, output_path)


if __name__ == '__main__':
    main()
