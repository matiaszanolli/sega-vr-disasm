#!/usr/bin/env python3
"""
Inject function labels into disassembly files.

Adds labels at known function addresses without modifying dc.w statements.
This maintains byte-accurate assembly while adding meaningful navigation.
"""

import re
from pathlib import Path

# Known function labels from comprehensive analysis
# Format: file_offset -> (label_name, brief_description)
FUNCTION_DATABASE = {
    # === Priority 1: Interrupt Handlers ===
    0x0832: ("DefaultExceptionHandler", "Infinite loop crash handler"),
    0x1684: ("V_INT_Handler", "V-blank main timing + state machine"),
    0x170A: ("H_INT_Handler", "H-blank handler (immediate RTE)"),

    # === Priority 2: Top Hotspots ===
    0x4998: ("WaitForVBlank", "Sync with V-INT (21 calls)"),
    0x49AA: ("SetDisplayParams", "Init display buffers (21 calls)"),
    0x2080: ("UpdateInputState", "Controller state machine (21 calls)"),
    0xFB36: ("SendDREQCommand", "DMA request to SH2 (17 calls)"),
    0x179E: ("ControllerRead", "Read controller ports (16 calls)"),
    0x205E: ("SetInputFlag", "Set input state flag (16 calls)"),
    0x14BE: ("TableLookup", "Indexed table access (12 calls)"),
    0x204A: ("ClearInputState", "Clear input RAM (11 calls)"),
    0x26C8: ("VDPFrameControl", "Frame buffer FM toggle (10 calls)"),

    # === Priority 3: Entry/Init ===
    0x03F0: ("EntryPoint", "Initial PC - MARS detect, Z80 init"),
    0x04C0: ("RAM_InitCode", "Code copied to work RAM"),
    0x04D4: ("VDP_InitTable", "VDP register init data (19 bytes)"),
    0x04E8: ("Z80_InitData", "Z80 boot code + PSG silence"),
    0x0512: ("SecurityStrings", "MARS security strings"),
    0x05A6: ("InitVDPRegs", "VDP register init function"),
    0x05CE: ("ClearVDPRAM", "Clear Genesis VDP memory"),
    0x0654: ("Init32XVDP", "32X VDP mode setup"),
    0x0694: ("ClearFrameBuffer", "Clear 32X frame buffer"),
    0x06BC: ("ClearWorkRAM", "Clear 64KB work RAM"),
    0x06E4: ("SecurityLoop", "Security delay loop"),
    0x06E8: ("MARSRegInit", "MARS register initialization"),
    0x07EC: ("ErrorPath1", "Error handler path"),
    0x07FC: ("ErrorPath2", "Error handler path"),
    0x0838: ("MARSAdapterInit", "32X adapter init - ADEN/REN"),
    0x08A8: ("SH2Handshake", "Wait for VRES/M_OK/S_OK"),
    0x0FBE: ("CopyInitCode", "Copy to Work RAM + Z80 bus"),
    0x1140: ("RLEDecompressor", "RLE/bit-packed decompressor"),
    0x11E4: ("ByteStreamDecoder", "Byte stream with $FF term"),
    0x12F4: ("BitFieldExtractor", "Bit field with bitmask table"),
    0x13A4: ("BitBufferRefill", "Bit buffer helper"),
    0x13B4: ("LZ77Decoder", "Stack-based LZ77-like decoder"),
    0x155E: ("func_155E", "Called 2x from init"),
    0x15EA: ("func_15EA", "Called 1x from init"),
    0x1992: ("func_1992", "Called 3x from init"),

    # === Priority 5: Controller/Input ===
    0x17EE: ("MapButtonBits", "Map hardware to game buttons"),
    0x185E: ("Read6ButtonPad", "6-button detection via TH"),

    # === Priority 6: Low Code Utilities ===
    0x2066: ("InitInputSystem", "Input system initialization"),
    0x20C6: ("ExtendedInputProcess", "V-INT state 11 input"),
    0x21CA: ("CopyInputState", "Copy to controller buffer"),
    0x2236: ("BitTestAndBranch", "Bit test utility"),
    0x24CA: ("DataProcessing1", "Data processing"),
    0x24FA: ("DataTransform", "Data transformation"),
    0x251A: ("MemoryInit1", "Memory initialization"),
    0x251C: ("MemoryOp1", "Memory operation"),
    0x252C: ("DataProcessing2", "Data processing"),
    0x253E: ("UtilityOp1", "Utility operation"),
    0x2546: ("DataHandling", "Data handling"),
    0x2558: ("MemoryUtil", "Memory utility"),
    0x25B0: ("MemoryOp2", "Memory operation"),
    0x266C: ("VDPOp1", "VDP-related operation"),
    0x268C: ("VDPOp2", "VDP-related operation"),
    0x270A: ("VDPOp3", "VDP operation"),
    0x2742: ("VDPAutoFill", "VDP auto-fill operation"),
    0x27A0: ("FrameBufferWrite", "Frame buffer write"),
    0x27F8: ("VDPFill", "VDP fill operation"),
    0x281E: ("VDPPrep", "VDP preparation"),
    0x284C: ("func_284C", "VDP-related"),
    0x2862: ("func_2862", "VDP-related"),
    0x28C2: ("func_28C2", "Called 2x"),
    0x318E: ("func_318E", "Low code utility"),
    0x344C: ("func_344C", "Low code utility"),
    0x38C0: ("func_38C0", "Low code utility"),
    0x3D2C: ("func_3D2C", "Low code utility"),
    0x3D6A: ("func_3D6A", "Low code utility"),
    0x3FD0: ("func_3FD0", "Low code utility"),

    # === Priority 7: V-INT State Handlers ===
    0x16B2: ("VINTStateTable", "V-INT jump table (16 entries)"),
    0x16D2: ("VINTState0", "Default handler"),
    0x16D6: ("VINTState1", "Default handler"),
    0x16DA: ("VINTState2", "Default handler"),
    0x16DE: ("VINTState3", "INVALID - odd address"),
    0x16E2: ("VINTState4", "Handler"),
    0x16E6: ("VINTState5", "SH2 COMM0 wait"),
    0x16EA: ("VINTState6", "Frame buffer ops"),
    0x16EE: ("VINTState7", "SH2 COMM0 wait"),
    0x16F2: ("VINTState8", "Default handler"),
    0x16F6: ("VINTState9", "Palette init"),
    0x16FA: ("VINTState10", "SH2 COMM0 wait"),
    0x16FE: ("VINTState11", "External $20C6"),
    0x1702: ("VINTState12", "SH2 COMM0 wait"),
    0x1706: ("VINTState13", "Frame buffer ops"),

    # === Main Code Hotspots ===
    0x4004: ("func_4004", "Main code 1"),
    0x426E: ("func_426E", "Main code 1"),
    0x4280: ("func_4280", "Called 2x"),
    0x4836: ("func_4836", "Menu/UI related"),
    0x483A: ("func_483A", "Menu/UI related"),
    0x483E: ("func_483E", "Menu/UI related"),
    0x4842: ("func_4842", "Called 2x"),
    0x4846: ("func_4846", "Menu/UI related"),
    0x4856: ("func_4856", "Menu/UI related"),
    0x485E: ("func_485E", "Menu/UI related"),
    0x48CA: ("func_48CA", "Called 2x"),
    0x48CE: ("func_48CE", "Called 2x"),
    0x48D2: ("func_48D2", "Called 2x"),
    0x4920: ("func_4920", "Called 6x"),
    0x4922: ("func_4922", "Called 2x"),

    # === High-frequency functions ===
    0x10674: ("func_10674", "Called 9x"),
    0x188EC: ("func_188EC", "Called 9x"),
    0xE52C: ("func_E52C", "Called 8x"),
    0xE35A: ("func_E35A", "Called 7x"),
    0xE316: ("func_E316", "Called 6x"),
    0xE4BC: ("func_E4BC", "Called 6x"),
    0xD1D4: ("func_D1D4", "Called 6x"),
    0xE406: ("func_E406", "Called 6x"),
}


def get_section_for_offset(offset):
    """Determine which section file an offset belongs to."""
    if offset < 0x1000:
        if offset >= 0x832:
            return "exception_handlers"
        elif offset >= 0x3F0:
            return "entry_point"
        elif offset >= 0x200:
            return "jump_table"
        else:
            return "header"

    # 8KB section files
    section_start = (offset // 0x2000) * 0x2000
    return f"code_{section_start:05x}"


def inject_labels(section_file):
    """Inject labels into a section file."""
    path = Path(section_file)
    if not path.exists():
        print(f"File not found: {section_file}")
        return 0

    content = path.read_text()
    lines = content.split('\n')

    # Find addresses in comments and check for labels
    new_lines = []
    injected = 0

    for i, line in enumerate(lines):
        # Look for address comments: ; 00XXXXXX:
        match = re.search(r';\s*([0-9A-Fa-f]{8}):', line)
        if match:
            cpu_addr = int(match.group(1), 16)
            file_offset = cpu_addr - 0x880000

            # Check if this address needs a label
            if file_offset in FUNCTION_DATABASE:
                label, desc = FUNCTION_DATABASE[file_offset]

                # Check if previous line already has this label
                if i > 0 and label + ':' in lines[i-1]:
                    new_lines.append(line)
                    continue

                # Check if label already exists anywhere in file
                if label + ':' in content:
                    new_lines.append(line)
                    continue

                # Inject label and comment
                new_lines.append(f"\n; --- {desc} ---")
                new_lines.append(f"{label}:")
                injected += 1

        new_lines.append(line)

    if injected > 0:
        path.write_text('\n'.join(new_lines))
        print(f"Injected {injected} labels into {path.name}")

    return injected


def inject_all_sections():
    """Inject labels into all section files."""
    sections_dir = Path("disasm/sections")
    if not sections_dir.exists():
        print("disasm/sections not found!")
        return

    total = 0

    # Process special sections first
    for name in ["entry_point.asm", "exception_handlers.asm"]:
        path = sections_dir / name
        if path.exists():
            total += inject_labels(path)

    # Process code sections
    for path in sorted(sections_dir.glob("code_*.asm")):
        total += inject_labels(path)

    print(f"\nTotal labels injected: {total}")


def main():
    import sys
    if len(sys.argv) > 1:
        for f in sys.argv[1:]:
            inject_labels(f)
    else:
        inject_all_sections()


if __name__ == '__main__':
    main()
