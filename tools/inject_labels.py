#!/usr/bin/env python3
"""
Inject function labels into disassembly files.

Adds labels at known function addresses without modifying dc.w statements.
This maintains byte-accurate assembly while adding meaningful navigation.

Updated: 2026-01-07 with comprehensive 289-function database from analysis.
"""

import re
from pathlib import Path

# Known function labels from comprehensive analysis
# Format: file_offset -> (label_name, brief_description)
FUNCTION_DATABASE = {
    # ==========================================================================
    # Priority 1: Interrupt Handlers (3 functions)
    # ==========================================================================
    0x0832: ("DefaultExceptionHandler", "Infinite loop crash handler"),
    0x1684: ("V_INT_Handler", "V-blank main timing + state machine"),
    0x170A: ("H_INT_Handler", "H-blank handler (immediate RTE)"),

    # ==========================================================================
    # Priority 2: Top Hotspots - 10+ calls (9 functions)
    # ==========================================================================
    0x4998: ("WaitForVBlank", "Sync with V-INT (21 calls)"),
    0x49AA: ("SetDisplayParams", "Init display buffers (21 calls)"),
    0x2080: ("UpdateInputState", "Controller state machine (21 calls)"),
    0xFB36: ("SendDREQCommand", "DMA request to SH2 (17 calls)"),
    0x179E: ("ControllerRead", "Read controller ports (16 calls)"),
    0x205E: ("SetInputFlag", "Set input state flag (16 calls)"),
    0x14BE: ("TableLookup", "Indexed table access (12 calls)"),
    0x204A: ("ClearInputState", "Clear input RAM (11 calls)"),
    0x26C8: ("VDPFrameControl", "Frame buffer FM toggle (10 calls)"),

    # ==========================================================================
    # Priority 3: Entry Point & Initialization (14 functions)
    # ==========================================================================
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

    # ==========================================================================
    # Priority 5: Controller/Input System (6 functions)
    # ==========================================================================
    0x17EE: ("MapButtonBits", "Map hardware to game buttons"),
    0x185E: ("Read6ButtonPad", "6-button detection via TH toggle"),

    # ==========================================================================
    # Priority 6: Low Code Utilities $2000-$3FFF (33 functions)
    # ==========================================================================
    0x2066: ("InitInputSystem", "Input system initialization"),
    0x20C6: ("ExtendedInputProcess", "V-INT state 11 input handler"),
    0x21CA: ("CopyInputState", "Copy to controller buffer"),
    0x2236: ("BitTestAndBranch", "Bit test and branch utility"),
    0x24CA: ("DataProcessing1", "Data processing utility"),
    0x24FA: ("DataTransform", "Data transformation"),
    0x251A: ("MemoryInit1", "Memory initialization 1"),
    0x251C: ("MemoryOp1", "Memory operation 1"),
    0x252C: ("DataProcessing2", "Data processing 2"),
    0x253E: ("UtilityOp1", "Utility operation 1"),
    0x2546: ("DataHandling", "Data handling routine"),
    0x2558: ("MemoryUtil", "Memory utility"),
    0x25B0: ("MemoryOp2", "Memory operation 2"),
    0x266C: ("VDPOp1", "VDP-related operation 1"),
    0x268C: ("VDPOp2", "VDP-related operation 2"),
    0x270A: ("VDPOp3", "VDP operation 3"),
    0x2742: ("VDPAutoFill", "VDP auto-fill operation"),
    0x27A0: ("FrameBufferWrite", "Frame buffer write"),
    0x27F8: ("VDPFill", "VDP fill operation"),
    0x281E: ("VDPPrep", "VDP preparation"),
    0x284C: ("VDPOp4", "VDP operation 4"),
    0x2862: ("MemoryOp3", "Memory operation 3"),
    0x2878: ("PaletteRAMCopy", "Palette RAM copy (V-INT state 6)"),
    0x28C2: ("VDPSyncSH2", "VDP/SH2 COMM synchronization"),
    0x318E: ("HighLevelUtil1", "High-level utility 1"),
    0x344C: ("HighLevelUtil2", "High-level utility 2"),
    0x38C0: ("HighLevelUtil3", "High-level utility 3"),
    0x3D2C: ("HighLevelUtil4", "High-level utility 4"),
    0x3D6A: ("HighLevelUtil5", "High-level utility 5"),
    0x3FD0: ("HighLevelUtil6", "High-level utility 6"),

    # ==========================================================================
    # Priority 7: V-INT State Handlers (16 handlers)
    # ==========================================================================
    0x16B2: ("VINTStateTable", "V-INT jump table (16 entries)"),
    0x19FE: ("VINTDefaultHandler", "Shared default handler for states 0,1,2,8"),
    0x1A6E: ("VINTState4Handler", "Minimal NOP-like handler"),
    0x1A72: ("VINTState5Handler", "SH2 COMM0 wait - communication"),
    0x1C66: ("VINTState6Handler", "Frame buffer + VDP control"),
    0x1ACA: ("VINTState7Handler", "SH2 COMM0 wait - communication"),
    0x1E42: ("VINTState9Handler", "Palette initialization"),
    0x1B14: ("VINTState10Handler", "SH2 COMM0 wait - communication"),
    0x1A64: ("VINTState11Handler", "Delegate to $20C6"),
    0x1BA8: ("VINTState12Handler", "SH2 COMM0 wait - communication"),
    0x1E94: ("VINTState13Handler", "Frame buffer operations"),
    0x1F4A: ("VINTState14Handler", "Frame buffer operations"),
    0x2010: ("VINTState15Handler", "COMM register cleanup"),

    # ==========================================================================
    # Priority 8: Main Game Logic $4000-$FFFF (128 functions)
    # ==========================================================================
    # Memory fill routines
    0x4004: ("DualTableLookupWrite", "Dual conditional table lookup & write"),
    0x426E: ("ConditionalVDPWrite", "Conditional VDP write with counter"),
    0x4280: ("NibbleExtractor", "Nibble extractor & field populator"),
    0x4836: ("QuadMemoryFill", "Quad memory fill dispatcher"),
    0x483A: ("MemoryFillWaterfall1", "Memory fill waterfall entry 1"),
    0x483E: ("MemoryFillWaterfall2", "Memory fill waterfall entry 2"),
    0x4842: ("MemoryFill60A1", "Memory fill 60 bytes (A1)"),
    0x4846: ("MemoryFill60A4", "Memory fill 60 bytes (A4)"),
    0x4856: ("UnrolledFill96", "Unrolled memory fill (96 bytes)"),
    0x485E: ("UnrolledFill112", "Unrolled memory fill (112 bytes)"),
    0x48B8: ("UnrolledFill32", "Unrolled memory fill (32 bytes)"),
    0x48CA: ("TripleMemoryFill", "Triple memory fill dispatcher"),
    0x48CE: ("MemoryFillWaterfall3", "Memory fill waterfall entry 3"),
    0x48D2: ("MemoryFillWaterfall4", "Memory fill waterfall entry 4"),
    0x48FE: ("UnrolledFill60", "Unrolled memory fill (60 bytes)"),
    0x4920: ("FastCopy20", "Fast 20-byte memory copy (A1->A2)"),
    0x4922: ("FastCopy16", "Fast 16-byte copy (variant entry)"),

    # Game state dispatchers
    0x4CBC: ("GameStateDispatcher1", "Game state jump table dispatcher"),
    0x5306: ("GameStateDispatcher2", "Game state dispatcher 2 (parallel)"),
    0x5308: ("EarlyLowHandler1", "Early low address handler"),
    0x5618: ("EarlyLowHandler2", "Early low address handler"),

    # Bus/hardware operation loops
    0x58C8: ("BusOpLoop6", "Conditional bus operation loop (6 iter)"),
    0x5908: ("BusOpLoop8", "Conditional bus operation loop (8 iter)"),
    0x593C: ("BusOpLoopSingle", "Conditional bus operation loop (single)"),

    # Object/entity functions
    0x5A52: ("ObjectFieldCalc", "Object field calculator (table lookup)"),
    0x5AB6: ("HardwareConfigDispatch1", "Hardware config dispatcher 1"),
    0x5B6E: ("MultiCallOrchestrator", "Multi-call orchestrator"),
    0x5BE0: ("RegisterConfig1", "Register configuration 1"),
    0x5BEC: ("HardwareConfigHandler2", "Hardware config handler 2"),
    0x5C5A: ("RegisterWriteSeq", "Register write sequence"),
    0x5D08: ("ConfigDispatcher", "Configuration dispatcher"),
    0x5DE0: ("DualHandlerCoord", "Dual handler coordinator"),
    0x5E38: ("MultiPortHWInit", "Multi-port hardware initializer"),
    0x5EEA: ("PortArrayWriter", "Port array writer"),
    0x5F9A: ("CascadingConfig", "Cascading configuration"),
    0x6008: ("FieldZeroHandler", "Field zeroing handler"),
    0x6014: ("ConfigFinalizer", "Configuration finalizer"),

    # Subroutine call chains
    0x60D4: ("HardwareStateCtrl", "Hardware state controller"),
    0x60FE: ("SubroutineCallChain", "Subroutine call chain (14+ calls)"),
    0x617A: ("ConditionalHandler1", "Conditional handler 1"),
    0x6292: ("PortConfigHandler", "Port configuration handler"),
    0x633A: ("ConfigHandlerVariant", "Configuration handler variant"),
    0x6394: ("PortConfigVariant", "Port configuration variant"),
    0x64A8: ("ObjectInitSetup", "Object initialization & setup"),

    # Game state handlers
    0x65BC: ("GameStateHandler1", "Game state handler 1"),
    0x662A: ("GameStateHandler2", "Game state handler 2"),
    0x6636: ("GameStateHandler3", "Game state handler 3"),
    0x66B4: ("GameStateHandler4", "Game state handler 4"),
    0x6718: ("GameStateHandler5", "Game state handler 5"),
    0x671A: ("GameStateHandler6", "Game state handler 6"),
    0x677A: ("GameStateHandler7", "Game state handler 7"),
    0x6804: ("GameStateHandler8", "Game state handler 8"),
    0x68C8: ("GameStateUtil", "Game state utility"),
    0x693E: ("ConditionalStateProc", "Conditional game state processor"),
    0x694A: ("GameStateLogicVariant", "Game state logic variant"),
    0x69D0: ("ConfigHandler2", "Configuration handler 2"),
    0x6A38: ("EarlyAddrHandler1", "Early address handler 1"),
    0x6A3A: ("EarlyAddrHandler2", "Early address variant handler"),
    0x6ACC: ("DataProcessor1", "Data processor 1"),
    0x6B04: ("EarlyRegionTerm", "Early region terminator"),

    # Bitfield and table operations
    0x6C88: ("BitfieldDispatcher7", "Bitfield dispatcher (7-way)"),
    0x6D00: ("TableSearchCondIdx", "Table search with conditional index"),
    0x6D8C: ("RegSaveRestoreWrap", "Register save/restore wrapper"),
    0x6D9C: ("HardwareLoop1", "Hardware loop 1 (6 iter, $FF9100)"),
    0x6DC8: ("HardwareLoop2", "Hardware loop 2 (8 iter, $FF9700)"),
    0x6DF0: ("HardwareLoop3", "Hardware loop 3 (single, $FF9F00)"),

    # Display/coordination handlers
    0x6E48: ("DisplayCoordHandler1", "Display/coordination handler 1"),
    0x6EAE: ("MultiStageInitCoord", "Multi-stage init coordinator"),
    0x6EBE: ("DisplayCoordHandler2", "Display/coordination handler 2"),
    0x6ECA: ("DisplayCoordHandler3", "Display/coordination handler 3"),
    0x6F98: ("ConditionalObjUpdate", "Conditional object update"),

    # Address calculators
    0x71B3: ("TableAddrCalc", "Table-based address calculator"),
    0x7252: ("AddrCalc1", "Address calculator 1"),
    0x727C: ("AddrCalc2", "Address calculator 2"),
    0x7280: ("BitfieldCalc3D", "Bitfield calculator (3D spatial)"),
    0x7364: ("ParallelAddrCalc", "Parallel address calculator"),
    0x7374: ("AddrCalcVariant", "Address calculator variant"),
    0x73F2: ("CoordTransformCalc", "3D coordinate transform calculator"),
    0x7406: ("TransformVariant", "Transform variant"),
    0x757A: ("MultiThresholdCmp", "Multi-threshold comparator"),
    0x7768: ("ComplexCondHandler", "Complex conditional handler"),
    0x778E: ("SubstantialConfigMgr", "Substantial configuration manager"),
    0x77B2: ("ConfigInitializer", "Configuration initializer"),
    0x77D6: ("ConfigPathHandler", "Configuration path handler"),

    # func_7BE4 dispatcher and handlers
    0x7BE4: ("JumpTableDispatcher16", "16-entry jump table dispatcher"),
    0x7C2E: ("Dispatch7BE4Handler1", "func_7BE4 dispatch handler 1"),
    0x7C32: ("Dispatch7BE4Handler2", "func_7BE4 dispatch handler 2"),
    0x7C36: ("Dispatch7BE4Handler3", "func_7BE4 dispatch handler 3"),
    0x7C3A: ("Dispatch7BE4Handler4", "func_7BE4 dispatch handler 4"),
    0x7C3E: ("Dispatch7BE4Handler5", "func_7BE4 dispatch handler 5"),
    0x7C42: ("Dispatch7BE4Handler6", "func_7BE4 dispatch handler 6"),

    # Sound/PSG functions
    0x83AE: ("PSGNibbleSplitter", "PSG nibble splitter"),

    # Object state and hardware
    0x88BE: ("ComplexCondState", "Complex conditional state handler"),
    0x8B9C: ("HWRegInit1", "Hardware register initializer 1"),
    0x8BC2: ("HWRegInit2", "Hardware register initializer 2"),
    0x8BF2: ("HWRegInit3", "Hardware register initializer 3"),
    0x8C16: ("HWRegInit4", "Hardware register initializer 4"),
    0x8C40: ("SelectorHWRouter", "Selector-based hardware router"),
    0x8CCE: ("DataLoaderValidator", "Data loader & validator"),
    0x8D62: ("MidRangeHandler1", "Mid-range handler"),
    0x8DC0: ("Coord3DCalc", "3D coordinate calculation"),
    0x8EB6: ("MidRangeHandler2", "Mid-range handler variant"),
    0x8ED6: ("MidRangeTerminator", "Mid-range terminator handler"),
    0x8EF2: ("HWRegHandler1", "Hardware register handler 1"),
    0x8EF4: ("ControlRegWriter", "Control register writer"),
    0x8EFC: ("ExtendedCtrlHandler", "Extended control handler"),

    # VDP calculation and other
    0x9084: ("VDPCalcWrite", "VDP calculation & write"),
    0x9458: ("LoopDataUpdater", "Loop-based data updater"),
    0x9A9E: ("ValueClampDamp", "Value clamp with damping"),
    0x9B7C: ("DualFuncWriteValid", "Dual function (write + validator)"),
    0x9B84: ("ValidatorVariant", "Validator variant"),

    # Table-based initialization
    0xA144: ("TableDataInit", "Table-based data initialization"),
    0xA1D8: ("DataInit2", "Data initialization 2"),
    0xA7CC: ("MinimalRegHandler", "Minimal register handler"),
    0xA80A: ("LoopDataCopy1", "Loop-based data copy 1 (structured)"),
    0xA83E: ("LoopDataCopy2", "Loop-based data copy 2 (bulk)"),

    # High address handlers
    0xB8A4: ("HighAddrHandler1", "High address handler 1"),
    0xB964: ("HighAddrHandler2", "High address handler variant"),
    0xB97A: ("HighAddrProcessor", "High address processor"),
    0xBA18: ("TripleJumpDispatcher", "Triple jump table dispatcher"),

    # Game mode and VDP config
    0xC784: ("OrchestratorFullSave", "Orchestrator with full save"),
    0xCA20: ("HWRegConfigVDP", "Hardware register config (VDP)"),
    0xCA9A: ("GameModeInit", "Game mode initialization"),
    0xCC06: ("SH2COMMSetup", "SH2 COMM setup with table lookup"),
    0xCC74: ("RegFlagInit", "Register and flag initialization"),
    0xCC88: ("CtrlRegContinue", "Control register continuation"),
    0xCD4C: ("LoopArrayProcessor", "Loop-based array processor"),
    0xCD92: ("ConditionalPushSetup", "Conditional push with setup"),
    0xCDD2: ("TableLookupLoopUpdate", "Table lookup with loop update"),
    0xCE02: ("FieldManipCondPaths", "Field manipulation (conditional)"),
    0xCE76: ("MultiHandlerOrch", "Multi-handler orchestration"),
    0xCEC2: ("BitCalcShifts", "Bit calculation with shifts"),
    0xCECC: ("BitCalcAltVariant", "Bit calculation (alt variant)"),
    0xCF0C: ("MultiJSROrchLoop", "Multi-JSR orchestration with loop"),
    0xCFAE: ("ComplexDataCopy", "Complex data copy (mode handling)"),
    0xD054: ("SubrTableWrite", "Subroutine call with table write"),
    0xD08A: ("MultiRegCtrlInit", "Multi-register control init"),
    0xD0F6: ("LoopedRegConfig", "Looped register configuration"),
    0xD19C: ("ComparisonSelector", "Comparison selector with state"),

    # Z80 sound
    0xD1D4: ("Z80SoundCmd", "Z80 sound command sender"),
    0xD42C: ("DispatcherDataCopy", "Dispatcher with data copy"),
    0xD450: ("ConditionalDataProc", "Conditional data processing"),

    # SH2 COMM command senders
    0xE316: ("SendCOMMCmd25", "Send COMM command $25 to SH2"),
    0xE35A: ("SendCOMMCmd22", "Send COMM command $22 (multi-phase)"),
    0xE406: ("SendCOMMCmd2F", "Send COMM command $2F (4 params)"),
    0xE4BC: ("ComputeSendCmd21", "Compute + send COMM command $21"),
    0xE52C: ("MultiTableProcessor", "Multi-table processor (8 calls)"),

    # DREQ and high ROM
    0xFB98: ("HighAddrRegionHandler", "High address region handler"),

    # Early initialization handlers
    0x4536: ("EarlyInitHandler1", "Early initialization handler 1"),
    0x4538: ("EarlyInitHandler2", "Early initialization handler 2"),
    0x4566: ("EarlyInitHandler3", "Early initialization handler 3"),
    0x456C: ("EarlyInitHandler4", "Early initialization handler 4"),
    0x4638: ("EarlyInitHandler5", "Early initialization handler 5"),
    0x464A: ("EarlyInitHandler6", "Early initialization handler 6"),
    0x465C: ("EarlyInitHandler7", "Early initialization handler 7"),
    0x4682: ("EarlyInitHandler8", "Early initialization handler 8"),

    # ==========================================================================
    # Priority 9: Extended Regions - Main Code 2 ($10000-$1FFFF)
    # ==========================================================================
    # High-frequency Main Code 2
    0x10674: ("MC2HighFreq1", "Main Code 2 high-freq (9 calls)"),

    # BA18 dispatcher handlers
    0x14438: ("BA18InitHandler1", "BA18 initialization handler 1"),
    0x14450: ("BA18InitHandler2", "BA18 initialization handler 2"),
    0x1446C: ("BA18InitHandler3", "BA18 initialization handler 3"),
    0x144A8: ("BA18InitHandler4", "BA18 initialization handler 4"),
    0x144D0: ("BA18InitHandler5", "BA18 initialization handler 5"),
    0x144F2: ("BA18InitHandler6", "BA18 initialization handler 6"),
    0x14518: ("BA18InitHandler7", "BA18 initialization handler 7"),
    0x14540: ("BA18InitHandler8", "BA18 initialization handler 8"),

    # State machine handlers
    0x1474A: ("StateMachineHandler1", "State machine handler 1"),
    0x14754: ("StateMachineHandler2", "State machine handler 2"),
    0x1475E: ("StateMachineHandler3", "State machine handler 3"),
    0x14768: ("StateMachineHandler4", "State machine handler 4"),
    0x14772: ("StateMachineHandler5", "State machine handler 5"),
    0x1477C: ("StateMachineHandler6", "State machine handler 6"),
    0x14786: ("StateMachineHandler7", "State machine handler 7"),
    0x14790: ("StateMachineHandler8", "State machine handler 8"),
    0x1479A: ("StateMachineHandler9", "State machine handler 9"),
    0x147A4: ("StateMachineHandler10", "State machine handler 10"),
    0x147AE: ("StateMachineHandler11", "State machine handler 11"),
    0x147B8: ("StateMachineHandler12", "State machine handler 12"),
    0x147C2: ("StateMachineHandler13", "State machine handler 13"),
    0x147E8: ("MidRangeStateHandler", "Mid-range state handler"),

    # Core handlers
    0x1480E: ("CoreHandler1", "Core handler 1"),
    0x14816: ("CoreHandler2", "Core handler 2"),
    0x1481E: ("CoreExtension1", "Core extension 1"),
    0x14826: ("CoreExtension2", "Core extension 2"),
    0x1482E: ("CoreExtension3", "Core extension 3"),
    0x14848: ("CoreExtension4", "Core extension 4"),
    0x14882: ("PrimaryBA18Handler", "Primary BA18 handler"),
    0x14884: ("VariantBA18Handler", "Variant BA18 handler"),
    0x14886: ("CommonBA18Handler", "Most common BA18 handler"),

    # Extended jump table handlers
    0x109AE: ("EarlyMC2Handler", "Early main code 2 handler"),
    0x1466A: ("HandlerVariant1", "Handler variant 1"),
    0x14696: ("HandlerVariant2", "Handler variant 2"),
    0x146B4: ("HandlerVariant3", "Handler variant 3"),
    0x146BC: ("HandlerVariant4", "Handler variant 4"),
    0x146CA: ("HandlerVariant5", "Handler variant 5"),
    0x146DA: ("HandlerVariant6", "Handler variant 6"),
    0x146EA: ("HandlerVariant7", "Handler variant 7"),
    0x146FA: ("HandlerVariant8", "Handler variant 8"),
    0x1470A: ("HandlerVariant9", "Handler variant 9"),
    0x1471A: ("HandlerVariant10", "Handler variant 10"),
    0x1472A: ("HandlerVariant11", "Handler variant 11"),
    0x1473A: ("HandlerVariant12", "Handler variant 12"),

    # High Main Code 2
    0x15494: ("HighMC2Handler1", "High MC2 handler 1"),
    0x154B4: ("HighMC2Handler2", "High MC2 handler 2"),
    0x154D4: ("HighMC2Handler3", "High MC2 handler 3"),
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
        file_offset = None

        # Try new format: ; $XXXXXX (6-digit file offset)
        match = re.search(r';\s*\$([0-9A-Fa-f]{6})\b', line)
        if match:
            file_offset = int(match.group(1), 16)

        # Try old format: ; 00XXXXXX: (8-digit CPU address)
        if file_offset is None:
            match = re.search(r';\s*([0-9A-Fa-f]{8}):', line)
            if match:
                cpu_addr = int(match.group(1), 16)
                file_offset = cpu_addr - 0x880000

        if file_offset is not None:
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
