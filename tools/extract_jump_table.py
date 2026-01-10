#!/usr/bin/env python3
"""
Extract 32X Jump Table from VRD ROM and generate assembly source.

The jump table at $200 uses JMP instructions (6 bytes each):
- 63 entries × 6 bytes = 378 bytes
- Followed by 35 NOPs (70 bytes) padding to $3C0
- Then MARS CHECK MODE security header at $3C0
- Entry point code begins at $3F0
"""

import struct
from pathlib import Path

ROM_PATH = "Virtua Racing Deluxe (USA).32x"
OUTPUT_PATH = "disasm/jump_table.asm"

# Known function names (for comments, actual code uses addresses)
KNOWN_FUNCTIONS = {
    0x00880832: "DefaultExceptionHandler",
    0x00880838: "MARSAdapterInit",
    0x0088170A: "H_INT_Handler",
    0x00881684: "V_INT_Handler",
}


def main():
    rom_data = Path(ROM_PATH).read_bytes()

    output = []
    output.append("; ============================================================================")
    output.append("; 32X Jump Table ($000200 - $0003BF)")
    output.append("; ============================================================================")
    output.append("; This is the 32X runtime jump table. The MARS BIOS uses this to dispatch")
    output.append("; exceptions. Each entry is a JMP absolute long instruction.")
    output.append(";")
    output.append("; Key entries:")
    output.append(";   Entry 0:  JMP $00880838 - MARSAdapterInit (main init routine)")
    output.append(";   Entry 27: JMP $0088170A - H-INT Handler")
    output.append(";   Entry 29: JMP $00881684 - V-INT Handler")
    output.append(";   Others:   JMP $00880832 - DefaultExceptionHandler (infinite loop)")
    output.append("; ============================================================================")
    output.append("")

    # Parse jump table entries
    offset = 0x200
    entry_num = 0
    entries = []

    while offset < 0x37A:  # JMPs end before NOPs start
        opcode = struct.unpack('>H', rom_data[offset:offset+2])[0]

        if opcode == 0x4EF9:  # JMP absolute long
            address = struct.unpack('>I', rom_data[offset+2:offset+6])[0]
            entries.append((entry_num, offset, address))
            offset += 6
            entry_num += 1
        elif opcode == 0x4E71:  # NOP
            break
        else:
            print(f"Unexpected opcode at ${offset:04X}: ${opcode:04X}")
            break

    # Group consecutive entries with same target
    output.append("JumpTable:")
    i = 0
    while i < len(entries):
        entry_num, entry_offset, address = entries[i]
        func_name = KNOWN_FUNCTIONS.get(address, "")

        # Count consecutive entries with same address
        count = 1
        while i + count < len(entries) and entries[i + count][2] == address:
            count += 1

        if count > 1 and address == 0x00880832:
            # Consecutive default handlers - use REPT or list range
            output.append(f"    ; Entries {entry_num}-{entry_num + count - 1}: Default handler")
            for j in range(count):
                output.append(f"    JMP     $00880832")
            i += count
        else:
            # Individual entry
            comment = ""
            if func_name:
                comment = f"  ; {func_name}"
            elif entry_num == 27:
                comment = "  ; H-INT (IRQ4)"
            elif entry_num == 29:
                comment = "  ; V-INT (IRQ6)"
            output.append(f"    JMP     ${address:08X}{comment}")
            i += 1

    output.append("")

    # Count NOPs
    nop_count = 0
    while offset < 0x3C0:
        opcode = struct.unpack('>H', rom_data[offset:offset+2])[0]
        if opcode == 0x4E71:
            nop_count += 1
            offset += 2
        else:
            break

    output.append("; NOP padding to align MARS header at $3C0")
    output.append(f"    REPT    {nop_count}")
    output.append("    NOP")
    output.append("    ENDR")
    output.append("")

    # MARS security header
    output.append("; ============================================================================")
    output.append("; MARS Security Header ($0003C0 - $0003EF)")
    output.append("; ============================================================================")
    output.append("; Required signature for 32X hardware validation")
    output.append("; ============================================================================")
    output.append("")

    # "MARS CHECK MODE " (16 bytes)
    mars_string = rom_data[0x3C0:0x3D0]
    output.append(f'MARSCheckMode:')
    output.append(f'    dc.b    "MARS CHECK MODE "')
    output.append("")

    # Security data ($3D0-$3EF = 32 bytes)
    output.append("; MARS security module descriptor")
    sec_data = rom_data[0x3D0:0x3F0]

    # Analyze the security data structure
    output.append(f"    dc.l    ${struct.unpack('>I', sec_data[0:4])[0]:08X}    ; Offset/reserved")
    output.append(f"    dc.l    ${struct.unpack('>I', sec_data[4:8])[0]:08X}    ; Module size ($20000 = 128KB)")
    output.append(f"    dc.l    ${struct.unpack('>I', sec_data[8:12])[0]:08X}    ; Reserved")
    output.append(f"    dc.w    ${struct.unpack('>H', sec_data[12:14])[0]:04X}        ; Reserved")

    # Remaining data as raw bytes
    output.append(f"    dc.l    ${struct.unpack('>I', sec_data[14:18])[0]:08X}    ; VDP config 1")
    output.append(f"    dc.l    ${struct.unpack('>I', sec_data[18:22])[0]:08X}    ; VDP config 2")
    output.append(f"    dc.l    ${struct.unpack('>I', sec_data[22:26])[0]:08X}    ; VDP config 3")
    output.append(f"    dc.l    ${struct.unpack('>I', sec_data[26:30])[0]:08X}    ; Reserved")
    output.append(f"    dc.w    ${struct.unpack('>H', sec_data[30:32])[0]:04X}        ; Flags")

    output.append("")
    output.append("; ============================================================================")
    output.append("; End of Jump Table and Security Header")
    output.append("; Entry Point code begins at $3F0")
    output.append("; ============================================================================")

    # Write output
    Path(OUTPUT_PATH).write_text('\n'.join(output) + '\n')
    print(f"Generated {OUTPUT_PATH}")
    print(f"Jump table entries: {len(entries)}")
    print(f"NOP padding words: {nop_count}")
    print(f"Covers: $200-$3EF (${0x3F0 - 0x200:X} bytes)")


if __name__ == '__main__':
    main()
