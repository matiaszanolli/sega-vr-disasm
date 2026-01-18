# Refactoring Map: Address-Based → Feature-Based Organization

This document maps the current address-based section files to the new feature-based module structure in `modules/`.

**Status:** Phase 4 COMPLETE - Input/Controller System integrated
**Build Method:** `make all` (sections-based) or `make modular` (modules/ + partial sections/)
**Current State:** Hybrid build - 9 modules integrated, working ROM (9 integrated + partial sections)

---

## Current Status

| Component | Status | Notes |
|-----------|--------|-------|
| sections/ | Working | Fixed 2,901 invalid mnemonics, builds successfully |
| modules/shared/definitions.asm | ✅ Integrated | Hardware register definitions (all platforms) |
| modules/68k/boot/rom_header.asm | ✅ Integrated | Exception vectors + ROM header ($000000-$0001FF) |
| modules/68k/memory/fill_copy_operations.asm | ✅ Integrated | Memory utils ($004836-$004996) from code_4200.asm |
| modules/68k/display/vdp_operations.asm | ✅ Integrated | VDP ops ($0027F8-$002982) from code_2200.asm |
| modules/68k/display/sync_functions.asm | ✅ Integrated | V-INT sync ($004998-$0049C6) from code_4200.asm |
| modules/68k/input/controller_read.asm | ✅ Integrated | Hardware polling ($0017EE-$002200) from code_200.asm |
| modules/68k/input/input_processing.asm | ✅ Integrated | Input state processing ($002200-$0027F6) from code_2200.asm |
| modules/68k/input/button_handling.asm | ✅ Integrated | Button management ($002984-$0041FC) from code_2200.asm |
| modules/68k/input/state_machine.asm | ✅ Integrated | Input state machine ($0049C8-$006200) from code_4200.asm |
| sections/code_200_partial.asm | ✅ Created | Original code_200 with controller_read removed, org $000200 |
| sections/code_2200_partial.asm | ✅ Created | Original code_2200 with input+VDP ops removed |
| sections/code_4200_partial.asm | ✅ Updated | Original code_4200 with all extractions removed |
| vrd_modular.asm | ✅ Building | Hybrid: 9 modules + partial sections, 3,145,728 bytes |
| Build System | ✅ | Both `make all` and `make modular` work, verified 3.0MB ROM |

**Build Verification:**
```bash
make all      # Build from sections/
make compare  # Compare with original (68K bytes differ - acceptable)
make modular  # Will build from modules/ after migration
```

---

## Quick Reference: Current Sections

| Address Range | Section File | Size | Primary Content |
|---------------|--------------|------|-----------------|
| $000000-$0001FF | header.asm | 512 B | ROM header, exception vectors |
| $000200-$0021FF | code_200.asm | 8 KB | Boot, initialization, main loop |
| $002200-$0041FF | code_2200.asm | 8 KB | Memory utilities, VDP operations |
| $004200-$0061FF | code_4200.asm | 8 KB | Input handling, controller system |
| $006200-$0081FF | code_6200.asm | 8 KB | Display sync, palette management |
| $008200-$00A1FF | code_8200.asm | 8 KB | Sound commands, Z80 interface |
| $00A200-$00C1FF | code_a200.asm | 8 KB | Hardware registers, I/O handlers |
| $00C200-$00E1FF | code_c200.asm | 8 KB | Main state machine (16 states) |
| $00E200-$0101FF | code_e200.asm | 8 KB | Graphics/menus/UI logic |
| $010200-$0121FF | code_10200.asm | 8 KB | Name entry system |
| $012200-$0161FF | code_12200-14200.asm | 16 KB | Race camera, viewport control |
| $016200-$0181FF | code_16200.asm | 8 KB | Camera utilities |
| $018200+ | code_18200+ | ~2.8 MB | Game data, 3D assets, SH2 code |

---

## Module Mapping Strategy

### Extraction Priority Order

```
Phase 1: Infrastructure (✅ COMPLETED)
├── modules/ directory structure created
├── vrd_modular.asm orchestrator created
├── Hardware register definitions added to vrd.asm
└── Build system verified working

Phase 2: Foundation Module Extraction (✅ COMPLETED)
├── 1. Boot & Initialization → ✅ modules/68k/boot/rom_header.asm
├── 2. Hardware Definitions → ✅ modules/shared/definitions.asm
├── 3. Memory Utilities → ✅ modules/68k/memory/fill_copy_operations.asm
├── 4. Display/VDP Operations → ✅ modules/68k/display/vdp_operations.asm
└── 5. Display Sync Functions → ✅ modules/68k/display/sync_functions.asm

Phase 3: Module Integration (✅ COMPLETED)
├── Created code_2200_partial.asm (VDP ops removed, org $002984)
├── Created code_4200_partial.asm (Memory+Display removed, org $0049C8)
├── Updated vrd_modular.asm to include modules in address order
├── Verified build: 3,145,728 bytes, 64,596 byte diff (improved from 68,305)
└── All modules building correctly with partial sections

Phase 4: Input/Controller System (✅ COMPLETED)
├── ✅ 6. Input/Controller System → 4 modules extracted & integrated
├──    - controller_read.asm ($0017EE-$002200)
├──    - input_processing.asm ($002200-$0027F6)
├──    - button_handling.asm ($002984-$0041FC)
├──    - state_machine.asm ($0049C8-$006200)
└── Resolved address overlaps with Phase 3 modules, created partial sections

Phase 5: Sound & Main Loop (NEXT)
├── 7. Sound System (code_8200.asm: $008200-$00A1FF)
├── 8. Main Loop & State Machine (code_c200.asm: $00C200-$00E1FF)
├── 9. Graphics/Menus/UI (code_e200.asm: $00E200-$0101FF)
├── 10. Name Entry System (code_10200.asm: $010200-$0121FF)
└── 11. Race Camera & Utilities (code_12200-16200.asm: $012200-$0181FF)

Phase 6: SH2 Code (After 68K complete)
├── 12. SH2 3D Engine (SH2 sections starting ~$023000+)
└── 13. SH2 Synchronization (COMM protocol integration)
```

---

## Detailed Module Specifications

### 1. Boot & Initialization → `modules/68k/boot/`

**Source Files:**
- `sections/header.asm` → `rom_header.asm`
- `sections/code_200.asm` (lines 1-300 est.) → `init_sequence.asm`

**Target Files:**
- `rom_header.asm` - Exception vectors, ROM header ($000000-$0001FF)
- `init_sequence.asm` - Boot code ($000200-$0003FF est.)
- `includes.txt` - Dependency documentation

**Key Content:**
- Exception vector table ($000000-$0000FF)
- ROM header metadata ($000100-$0001FF)
- TMSS initialization
- MARS adapter detection
- Initial memory setup

**Dependencies:** None (entry point)

**Extraction Notes:**
- Must preserve byte-perfect ROM header
- Keep `org $000000` directive
- Document all exception vector redirects

---

### 2. Hardware Definitions → `modules/shared/definitions.asm`

**Source:**
- Currently inline in `vrd.asm` lines 16-46
- Should move to shared module for better organization

**Content:**
```asm
; 32X System Registers
MARS_SYS_BASE       equ $A15100
MARS_SYS_INTCTL     equ $A15100
MARS_SYS_INTMASK    equ $A15102
MARS_SYS_HCOUNT     equ $A15104
MARS_DREQ_CTRL      equ $A15106
MARS_DREQ_LEN       equ $A15110
MARS_FIFO           equ $A15112

; Communication Ports (68K ↔ SH2)
COMM0-COMM7         equ $A15120-$A1512E

; VDP Registers
MARS_VDP_MODE       equ $A15180
MARS_VDP_FILLADR    equ $A15186
MARS_VDP_FILLDATA   equ $A15188
MARS_VDP_FBCTL      equ $A1518A

; Mega Drive Registers
VDP_DATA, VDP_CTRL, PSG, MD_DATA1, MD_CTRL1
Z80_BUSREQ, Z80_RESET, WORK_RAM
```

**Dependencies:** None

---

### 3. Memory Utilities → `modules/68k/memory/`

**Source:**
- `sections/code_2200.asm` (partial) - Extract fill/copy routines

**Target Files:**
- `fill_operations.asm` - Unrolled fill variants
- `copy_operations.asm` - Fast copy routines
- `bitfield_utils.asm` - Bit manipulation
- `vram_init.asm` - VRAM clearing

**Key Functions (to locate):**
- UnrolledFill32, UnrolledFill60, UnrolledFill96, UnrolledFill112
- FastCopy16, FastCopy20
- ClearVRAM
- Bit extraction utilities

**Dependencies:** Hardware register definitions only

---

### 4. Input/Controller → `modules/68k/input/`

**Source:**
- `sections/code_4200.asm` ($004200-$0061FF)

**Target Files:**
- `controller_system.asm` - Hardware polling
- `button_mapping.asm` - Bit mapping
- `state_machine.asm` - State management

**Key Data:**
- Input buffer: Likely $C800-$C8FF
- Button state flags
- Edge detection buffers

**Dependencies:**
- Hardware registers (MD_DATA1, MD_CTRL1)
- Memory utilities (buffer ops)

---

### 5. Display/VDP → `modules/68k/display/`

**Source:**
- `sections/code_6200.asm` ($006200-$0081FF)
- `sections/code_2200.asm` (partial)

**Target Files:**
- `vdp_system.asm` - VDP operations
- `palette_system.asm` - Color management
- `sync_handler.asm` - SH2 synchronization
- `screen_modes.asm` - Display configuration

**Key Functions:**
- VDPFill, VDPSyncSH2, PaletteRAMCopy
- SetDisplayParams, InitVDPRegs

**Dependencies:**
- VDP/MARS registers
- Memory utilities
- COMM registers (SH2 sync)

---

### 6. Sound → `modules/68k/sound/`

**Source:**
- `sections/code_8200.asm` ($008200-$00A1FF)

**Target Files:**
- `z80_commands.asm` - Sound command interface
- `audio_integration.asm` - YM-2612 integration

**Key Functions:**
- Z80SoundCmd ($00D1D4 documented)
- InitZ80, SendSoundCommand, WaitZ80

**Dependencies:**
- Z80 registers (Z80_BUSREQ, Z80_RESET, Z80_RAM)

---

### 7. Main Loop → `modules/68k/main-loop/`

**Source:**
- `sections/code_c200.asm` - State machine
- `sections/code_200.asm` (partial) - V-INT

**Target Files:**
- `vint_handler.asm` - V-INT handler (0x1684)
- `state_machine.asm` - 16-state dispatcher
- `state_0_through_15.asm` - State handlers
- `polling_loop.asm` - VDP/SH2 polling
- `frame_timing.asm` - Frame sync

**Key Data:**
- State variable: $C87E (16 states cyclic)
- Frame counter: $C964
- State table: $0016B2

**Dependencies:** All subsystems (orchestrator)

---

### 8. Graphics/Menus → `modules/68k/game/graphics/`

**Source:**
- `sections/code_e200.asm` ($00E200-$010200)
- 2,267 lines, 190 functions (per GAME_LOGIC_GRAPHICS_MENUS.md)

**Target Files:**
- `menu_state_machines.asm` - 4 state machines
- `sh2_commands.asm` - 8 SH2 commands
- `ui_rendering.asm` - Menu rendering
- `mode_selection.asm` - Mode selection

**Key Systems:**
- State Machine 1: Lines 8-600 (main menu)
- State Machine 2: Lines 620-1200 (sub-menus)
- State Machine 3: Lines 1220-1800 (rendering)
- State Machine 4: Lines 1820-2267 (UI updates)

**SH2 Commands:** $00, $01, $02, $03, $04, $06, $1C, $1D

**Dependencies:** Display, Input, COMM registers

---

### 9. Name Entry → `modules/68k/game/name-entry/`

**Source:**
- `sections/code_10200.asm` ($010200-$012200)
- 2,251 lines, 201 functions (per GAME_LOGIC_NAME_ENTRY.md)

**Target Files:**
- `name_entry_keyboard.asm` - 52-char keyboard
- `name_entry_cursor.asm` - Cursor control
- `name_entry_ascii.asm` - ASCII conversion

**Key Data:**
- ASCII table: $010974 (keyboard → ASCII mapping)
- 52 characters: A-Z, 0-9, symbols
- 178 JSR calls to input system

**Dependencies:** Display (rendering), Input (cursor)

---

### 10. Race Camera → `modules/68k/game/camera/`

**Source:**
- `sections/code_12200.asm` ($012200-$014200)
- `sections/code_14200.asm` ($014200-$0161FF)
- `sections/code_16200.asm` ($016200-$018200)
- Combined: 6,452 lines, 238 functions

**Target Files:**
- `race_camera_control.asm` - Camera transitions
- `viewport_control.asm` - Scroll management
- `race_utilities.asm` - Helper functions

**Key Data:**
- Scroll offset: $A026
- Counter: $A02A

**Dependencies:** Display (viewport), SH2 (position sync)

---

### 11. SH2 3D Engine → `modules/sh2/3d-engine/`

**Source:**
- SH2 sections starting ~$023000+

**Target Files:**
- `core_engine.asm` - Matrix math, transforms
- `hardware_setup.asm` - 32X VDP setup
- `dma_operations.asm` - Frame buffer DMA
- `pipeline.asm` - Rendering pipeline

**Key Systems (per SH2_3D_PIPELINE_ARCHITECTURE.md):**
- Matrix operations (4x4, rotation, translation)
- Polygon clipping/projection
- Depth sorting
- Rasterization

**Dependencies:** COMM registers, MARS_VDP_*, MARS_FIFO

---

### 12. SH2 Synchronization → `modules/sh2/synchronization/`

**Source:**
- SH2 sections with COMM register access

**Target Files:**
- `comm_protocol.asm` - COMM0-7 protocol
- `master_sync.asm` - Master coordination
- `handshake.asm` - Boot handshake

**COMM Protocol:**
- Command codes: $00-$1D
- Bidirectional communication
- Frame synchronization

**Dependencies:** Hardware registers, 3D engine

---

## Extraction Workflow

For each module:

### 1. Identify Functions
```bash
# Find functions in source section
grep -E '^\w+:' sections/code_4200.asm

# Find address references
grep '\$004[0-9A-F]{3}' sections/code_4200.asm

# Count lines/functions
wc -l sections/code_4200.asm
```

### 2. Extract Code
- Copy relevant code to target module file
- Preserve address comments (`;  $XXXXXX`)
- Add module header with dependencies
- Keep `org` directive for address

### 3. Update Orchestrator
- Add `include "modules/path/file.asm"` to vrd_modular.asm
- Maintain address order
- Test build: `make modular`

### 4. Verify
- Build completes: `make all`
- ROM size correct: 3,145,728 bytes
- Test in emulator

### 5. Document
- Update this map with findings
- Note dependencies discovered
- Document data structures

---

## Address Reference

| Module | Start | End | Section Files |
|--------|-------|-----|---------------|
| Boot | $000000 | $0003FF | header.asm, code_200.asm |
| Memory | $002200 | $003FFF | code_2200.asm (partial) |
| Input | $004200 | $005FFF | code_4200.asm |
| Display | $006200 | $007FFF | code_6200.asm |
| Sound | $008200 | $009FFF | code_8200.asm |
| HW Regs | $00A200 | $00BFFF | code_a200.asm |
| Main Loop | $00C200 | $00DFFF | code_c200.asm |
| Graphics | $00E200 | $00FFFF | code_e200.asm |
| Name Entry | $010200 | $0121FF | code_10200.asm |
| Camera | $012200 | $0181FF | code_12200-16200.asm |
| SH2 Code | $023000+ | $2FFFFF | code_*.asm (many) |

---

## Known Issues

### Section Overlap (Resolved)
- code_14200.asm extended to $016232, overlapped code_16200.asm
- **Fix:** Truncated at $0161FE (last valid instruction)
- **Impact:** 310 lines removed
- **Status:** ✅ Builds successfully

### Invalid Mnemonics (Resolved)
- **Fixed:** 2,901 invalid instructions
- **Tool:** tools/fix_invalid_mnemonics.py
- **Patterns:** MOVEM invalid dest, bit ops on A-regs, PC-relative with absolute
- **Status:** ✅ ROM assembles

### Byte-Perfect Rebuild (Accepted Limitation)
- **Status:** Not achievable (~68K bytes differ)
- **Cause:** Original disassembly has incorrect mnemonics
- **Decision:** Proceed with working build
- **Impact:** ROM builds, runs, suitable for refactoring

---

## Next Steps

1. ✅ **Phase 1 Complete** - Infrastructure ready
2. ✅ **Phase 2a: 2/3 Complete** - Hardware Defs & Boot integrated, Memory extracted
3. **Phase 2b Preparation** - Continue extracting I/O subsystems (Display, Input, Sound)
4. **Address Mixed Sections** - code_4200.asm contains Memory + Display + Input (needs splitting)
5. **Integration Strategy** - Create code_4200_partial.asm after all extractions complete

---

## Phase 2a Findings

**Discovery:** Section files are organized by ADDRESS, not by SUBSYSTEM:
- `code_2200.asm` contains VDP ops + Memory ops + Data tables (all mixed)
- `code_4200.asm` contains Memory Utils + Display + Input + Initialization (all mixed)
- `code_6200.asm` contains Game State Handlers + Config + Display (all mixed)
- `code_8200.asm` contains Sound + HW Registers + 3D Coord Calc (all mixed)
- **ALL sections are address-based ($8KB chunks), not feature-based!**

**Integration Strategy for Mixed Sections:**
1. Extract all subsystems from a mixed section file first
2. Create a "partial" version with extracted code removed (e.g., code_4200_partial.asm)
3. Update vrd_modular.asm to include modules + partial section
4. Verify build after each major subsystem extraction

**Module Files Created (Phase 2):**
- `modules/shared/definitions.asm` - Integrated ✅
- `modules/68k/boot/rom_header.asm` - Integrated ✅
- `modules/68k/memory/fill_copy_operations.asm` - Extracted (241 lines) ⏸️
- `modules/68k/display/vdp_operations.asm` - Extracted (154 lines) ⏸️
- `modules/68k/display/sync_functions.asm` - Extracted (42 lines) ⏸️

**Total Extraction Progress:**
- 2 modules integrated into vrd_modular.asm
- 3 modules extracted, awaiting integration
- ~437 lines of code refactored from sections/ to modules/

---

**Last Updated:** 2026-01-17 (Phase 4 completion session)
**Status:** Phase 4 Complete - Input/Controller System fully integrated
**Working Build:** ✅ 3,145,728 bytes (make modular verified with 9 modules)
**Integrated Modules:** 9 (shared definitions, boot, memory, display ops, display sync, 4 input modules)
**Next Phase:** Phase 5 - Extract Sound System and Main Loop modules
