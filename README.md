# Virtua Racing Deluxe (32X) - Complete Disassembly & Analysis

**Status: ✅ v4.3.0 - 68K Translation In Progress**

A complete, buildable disassembly of Virtua Racing Deluxe for the Sega 32X, with comprehensive reverse engineering documentation. The ROM rebuilds to a **byte-identical** binary in all translated regions, with **4MB expansion ROM** containing SH2 parallel processing infrastructure.

## Key Features

- **Byte-perfect rebuild** - All translated functions verified identical to original ROM
- **75 SH2 functions translated** - Proper `.short` opcode assembly across 36 files
- **5 68K modules translated** - Boot, game logic, physics, adapter init, SH2 communication
- **4MB expansion ROM** - 1MB SH2 working space with parallel processing infrastructure (not yet activated)
- **503+ named 68K functions** - Categorized by subsystem with 200+ auto-injected labels
- **107 named SH2 functions** - 3D engine fully mapped
- **Cross-validated documentation** - All analysis docs verified against disassembly

## Quick Start

```bash
# Build the ROM
make all

# Verify SH2 functions match original
make sh2-verify
# Output: ✓✓✓ All SH2 functions verified! ✓✓✓

# Test in emulator
picodrive build/vr_rebuild.32x
```

## Project Structure

```
32x-playground/
├── disasm/
│   ├── vrd.asm                    # Main build file
│   ├── sections/                  # Pure DC.W (buildable)
│   ├── sections-mnemonic/         # Readable mnemonics (reference)
│   ├── modules/68k/               # Translated 68K assembly
│   │   ├── boot/                  # Hardware initialization
│   │   ├── main-loop/             # V-INT and state machines
│   │   ├── game/                  # Game logic and physics
│   │   └── sh2/                   # SH2 communication
│   ├── sh2/3d_engine/             # Translated SH2 functions
│   ├── sh2_symbols.inc            # 107 SH2 function symbols
│   └── SH2_SYMBOL_MAP.md          # SH2 symbol reference
│
├── analysis/                      # Reverse engineering docs
│   ├── ARCHITECTURAL_BOTTLENECK_ANALYSIS.md  # Key insight
│   ├── 68K_FUNCTION_REFERENCE.md  # 503+ functions
│   ├── 68K_SH2_COMMUNICATION.md   # Communication protocol
│   ├── architecture/              # Memory maps, state machines
│   ├── sh2-analysis/              # SH2 3D engine docs
│   ├── optimization/              # Optimization research
│   └── debugger-design/           # PicoDrive debugger
│
├── docs/                          # Hardware manuals & guides
│   ├── 32x-hardware-manual.md     # Complete HW reference
│   ├── development-guide.md       # CPU coordination guide
│   └── ...
│
├── tools/                         # Python analysis tools
│   ├── build_symbol_table.py      # 68K symbol generator
│   ├── build_sh2_symbol_table.py  # SH2 symbol generator
│   ├── inject_function_labels.py  # Auto-inject labels from reference
│   ├── m68k_disasm.py             # 68K disassembler
│   ├── sh2_disasm.py              # SH2 disassembler
│   └── generate_call_graph.py     # Call graph generator
│
└── build/
    └── vr_rebuild.32x             # Output ROM (4.0 MB with expansion)
```

## Key Architectural Insight

The original game runs at ~20 FPS due to a **blocking synchronization model**, not hardware limitations:

```
ORIGINAL (Current):
68K: sh2_graphics_cmd → sh2_send_cmd_wait (BLOCKS) → sh2_wait_response
                                ↑
                        Global serialization barrier

PLANNED OPTIMIZATION (Infrastructure Ready):
Game calls func_021 → Trampoline captures params → COMM7=0x16
                    → Master returns immediately
                    → Slave picks up work, executes func_021_optimized
                    → Both CPUs running in parallel
```

- Frame production is serialized through blocking waits (current behavior)
- **Optimization infrastructure prepared** in expansion ROM at $300000+
- Parallel processing hooks ready but **not yet activated** in main ROM

See [ARCHITECTURAL_BOTTLENECK_ANALYSIS.md](analysis/ARCHITECTURAL_BOTTLENECK_ANALYSIS.md) for full details.

## Disassembly Formats

Two complementary formats for different use cases:

### 1. Buildable (sections/)
```asm
dc.w    $4EBA        ; $01020A
dc.w    $E14E        ; $01020C
dc.w    $207C        ; $01020E
```
Pure DC.W - guaranteed byte-accurate builds.

### 2. Readable (sections-mnemonic/)
```asm
JSR     $00E35A(PC)                     ; $01020A
MOVEA.L #$06020000,A0                   ; $01020E
loc_010220:
LEA     $00(A0,D0.W),A0                 ; $010220
```
Decoded mnemonics with labels - for code analysis.

## Build Commands

```bash
make all          # Build 4MB ROM from source (with 1MB SH2 expansion)
make compare      # Verify byte-perfect match (original 3MB section)
make clean        # Remove build artifacts
make tools        # Build vasm assembler
```

## Requirements

- Python 3.x
- GCC and Make (for vasm)
- Unix-like environment (Linux, macOS, WSL)

### ROM (NOT INCLUDED)
You must provide your own legal ROM dump:
- File: `Virtua Racing Deluxe (USA).32x` (in `roms/` directory)
- Size: 3,145,728 bytes (original) → 4,194,304 bytes (with expansion)
- MD5: `72b1ad0f949f68da7d0a6339ecd51a3f` (original 3MB)

## Next Steps

1. ~~SH2 function translation (major pass)~~ ✅ Done (75 functions)
2. ~~Parallel processing infrastructure~~ ✅ Done (expansion ROM ready)
3. **68K assembly translation** - Converting dc.w to proper assembly (in progress)
4. **Activate parallel hooks** - Wire up dispatch redirect and func_021 trampoline
5. **Performance Testing** - Measure FPS improvement from parallel processing
6. **Synchronization** - Ensure Slave completes before next frame

## Documentation

| Category | Key Documents |
|----------|---------------|
| **Architecture** | [ARCHITECTURAL_BOTTLENECK_ANALYSIS.md](analysis/ARCHITECTURAL_BOTTLENECK_ANALYSIS.md) |
| **4MB Expansion** | [ROM_EXPANSION_4MB_IMPLEMENTATION.md](analysis/architecture/ROM_EXPANSION_4MB_IMPLEMENTATION.md) |
| **68K Functions** | [68K_FUNCTION_REFERENCE.md](analysis/68K_FUNCTION_REFERENCE.md) (503+ functions) |
| **68K Modules** | [disasm/modules/68k/](disasm/modules/68k/) (translated assembly) |
| **SH2 Functions** | [SH2_SYMBOL_MAP.md](disasm/SH2_SYMBOL_MAP.md) (107 functions) |
| **SH2 3D Pipeline** | [SH2_3D_PIPELINE_ARCHITECTURE.md](analysis/sh2-analysis/SH2_3D_PIPELINE_ARCHITECTURE.md) |
| **SH2 Function Ref** | [SH2_3D_FUNCTION_REFERENCE.md](analysis/sh2-analysis/SH2_3D_FUNCTION_REFERENCE.md) (75 translated) |
| **Communication** | [68K_SH2_COMMUNICATION.md](analysis/68K_SH2_COMMUNICATION.md) |
| **Data Structures** | [DATA_STRUCTURES.md](analysis/architecture/DATA_STRUCTURES.md) |
| **Hardware** | [32x-hardware-manual.md](docs/32x-hardware-manual.md) |
| **Development** | [development-guide.md](docs/development-guide.md) |

### SH2 3D Engine Translations

Complete annotated translations of 75 SH2 functions are in `disasm/sh2/3d_engine/`. All produce byte-identical output to the original ROM. Key findings:

| Function | Size | Purpose |
|----------|------|---------|
| func_023 | **238 B** | Largest - Frustum culling hub, dispatches to all render paths |
| func_006 | 88 B | Core MAC.L matrix × vector transform (~45 cycles/vertex) |
| func_034 | 122 B | Span filler with reciprocal table at 0x060048D0 |
| func_040 | 122 B | Display list with 12-entry jump table |
| func_016 | 34 B | Coord packing - HOTSPOT: 17% frame budget when called 4×/polygon |

**Verified VDP Addresses**: 0xC00007C0 (buffer A), 0xC00007E0 (buffer B), 0xC0000740 (edge buffer)

### 68K Assembly Translations

Converting raw `dc.w` opcodes to readable, maintainable 68000 assembly. Translations use EQU constants and preserve original bytes in comments for verification.

**Translated Modules** (in `disasm/modules/68k/`):

| Module | Address Range | Purpose |
|--------|---------------|---------|
| [adapter_init.asm](disasm/modules/68k/boot/adapter_init.asm) | $000838-$0009BA | 32X hardware init, VDP setup, main loop entry |
| [vint_handler.asm](disasm/modules/68k/main-loop/vint_handler.asm) | $001684-$0017EE | V-INT state machine (16 states), controller init |
| [game_logic_core.asm](disasm/modules/68k/game/game_logic_core.asm) | $006200-$006312 | Game state dispatcher (7 states) |
| [object_system.asm](disasm/modules/68k/game/object_system.asm) | $006F98-$007200 | High-frequency physics (150+ calls/frame) |
| [sh2_communication.asm](disasm/modules/68k/sh2/sh2_communication.asm) | $00E316-$00E3B2 | **Blocking sync** - root cause of ~20 FPS limit |

**Translation Format:**
```asm
; Constants at top with EQU
VINT_STATE      equ     $C87A   ; V-INT state flag (word)
ADAPTER_BASE    equ     $A15100 ; 32X adapter control

; Code preserves original bytes for verification
vint_handler:
        tst.w   VINT_STATE.w                    ; $001684: $4A78 $C87A - Test state
        beq.s   vint_early_exit                 ; $001688: $6726       - Exit if 0
```

**Key Discoveries:**
- Object structure has 150+ byte offsets (position at $30/$34, velocity at $44/$46, angles at $5A-$5E)
- Trig tables at $0093A02C (sine) and $0093A42C (cosine) with 1024 entries each
- V-INT state machine uses jump table with 16 handler functions

## Technical Details

| Component | Details |
|-----------|---------|
| Platform | Sega 32X (Mega Drive add-on) |
| 68000 CPU | 12.5 MHz, game logic & coordination |
| SH2 CPUs | 2x 23 MHz, 3D rendering |
| Z80 CPU | Sound processing |
| ROM Size | 4 MB (4,194,304 bytes) with 1MB SH2 expansion |
| Original Size | 3 MB (3,145,728 bytes) |
| Original Frame Rate | ~20 FPS (architectural limit due to blocking sync) |
| Current Status | 75 SH2 + 5 68K modules translated, parallel hooks prepared |

## 4MB Expansion ROM

The project builds the full **4MB official cartridge size** with a dedicated 1MB expansion section containing SH2 parallel processing infrastructure:

```
Address Range    Size      Contents
──────────────────────────────────────────
$000000-$2FFFFF  3.0 MB    Original Game Code
$300000-$3FFFFF  1.0 MB    SH2 Expansion Space
──────────────────────────────────────────
Total            4.0 MB    Full Cartridge
```

### Expansion ROM Layout

| Address | Size | Function |
|---------|------|----------|
| $300028 | 22B | `handler_frame_sync` |
| $300050 | 44B | `master_dispatch_hook` (skips COMM7 for cmd 0x16) |
| $300100 | 96B | `func_021_optimized` (func_016 inlined) |
| $300200 | 76B | `slave_work_wrapper` (command dispatch) |
| $300280 | 44B | `slave_test_func` (reads params, calls func_021_optimized) |

### Key Memory Locations

| Address | Purpose |
|---------|---------|
| $0234C8 | func_021 trampoline (captures params, signals Slave) |
| $2203E000 | Parameter block (R14, R7, R8, R5 - 16 bytes) |
| $2000402E | COMM7 (Master→Slave signal) |
| $2000402A | COMM5 (vertex transform counter, +101 per call) |

**Infrastructure Status:**
- ✅ **Expansion code ready** - Parallel processing handlers implemented at $300000+
- ✅ **func_021_optimized** - Vertex transform with func_016 inlined at $300100
- ⏳ **Hooks not activated** - Dispatch redirect and trampoline not yet patched
- ✅ **Backward compatible** - Original 3MB code section unchanged, plays identically

**Critical Constraint:** The expansion section ($300000-$3FFFFF) is executed by SH2 processors only. It cannot contain 68K assembly mnemonics. Use raw SH2 opcodes in `dc.w` format or padding.

See [ROM_EXPANSION_4MB_IMPLEMENTATION.md](analysis/architecture/ROM_EXPANSION_4MB_IMPLEMENTATION.md) for complete details.

## Custom PicoDrive Profiler

A cycle-accurate profiling system built from scratch on top of PicoDrive's libretro core. This is the **only working 32X profiler** that provides per-CPU cycle counting and PC-level hotspot analysis.

**Location:** [tools/libretro-profiling/](tools/libretro-profiling/)

### Features
- **Frame-level profiling** - Cycles per frame for all 3 CPUs (68K, Master SH2, Slave SH2)
- **PC-level hotspot analysis** - Identifies which addresses consume the most cycles
- **Headless frontend** - Automated profiling without GUI
- **Autoplay support** - Navigates menus automatically for consistent profiling

### Quick Start
```bash
cd tools/libretro-profiling
./build_with_68k_profiling.sh

# Profile 2400 frames
VRD_PROFILE_PC=1 VRD_PROFILE_PC_LOG=profile.csv \
./profiling_frontend ../../build/vr_rebuild.32x 2400 --autoplay

# Analyze results
python3 analyze_pc_profile.py profile.csv
```

### Key Findings
- **68K**: 127,987 cycles/frame @ 7.67 MHz (100% utilization - bottleneck)
- **Master SH2**: 139,568 cycles/frame @ 23 MHz (36% utilization)
- **Slave SH2**: 299,958 cycles/frame @ 23 MHz (78% utilization)

**Note:** This profiler deserves its own dedicated repository - it's useful for any 32X development project.

## Credits

- **Original Game**: SEGA (1994)
- **Disassembly & Analysis**: Claude Code with human guidance
- **Tools**: vasm by Volker Barthelmann & Frank Wille
- **Profiler**: Custom PicoDrive libretro patches (built from scratch)

## License

Reverse engineering project for educational and preservation purposes. Original game © SEGA 1994. No copyrighted content included - you must provide your own legal ROM.

---

**Verification**: `MD5: 72b1ad0f949f68da7d0a6339ecd51a3f`
