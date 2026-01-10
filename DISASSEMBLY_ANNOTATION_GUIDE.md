# Virtua Racing Deluxe - Disassembly Annotation Guide

**Project Status**: Complete disassembly achieved. Annotation phase in progress.

## Quick Start

```bash
# Build the ROM
make all

# Verify byte-accurate match
make compare  # Should show PERFECT MATCH

# View structure
cat disasm/vrd.asm
```

## Disassembly Overview

### Statistics
- **Total ROM Size**: 3MB (3,145,728 bytes)
- **Section Files**: 384 code sections + header/vectors/jump table
- **Total Assembly Lines**: ~1.6M lines across 388 files
- **Functions Documented**: 769 total, ~290 analyzed (37.6%)
- **Build Status**: PERFECT MATCH with original ROM

### File Organization

```
disasm/
├── vrd.asm                          # Master assembly file (entry point for build)
├── sections/
│   ├── header.asm                   # ROM header & vector table ($0000-$01FF)
│   ├── jump_table.asm               # 32X Jump Table ($0200-$03EF)
│   ├── entry_point.asm              # Entry/Init ($03F0-$0831)
│   ├── exception_handlers.asm       # Exception handlers ($0832-$0FFF)
│   ├── code_1000.asm - code_fe000.asm  # Main code sections (8KB each)
│   └── rom_remainder.bin            # Binary blob for unprocessed data
└── tools/
    ├── batch_extract.py             # Extract multiple ROM sections
    ├── extract_section.py            # Extract single ROM section
    ├── inject_labels.py              # Inject function labels
    ├── update_vrd.py                 # Auto-update vrd.asm master file
    ├── annotate_asm.py               # (WIP) Convert dc.w to mnemonics
    └── generate_68k_asm.py           # (Reference) Original generation tool
```

## Current Annotation Progress

### Completed (10 functions)

**Interrupt Handlers**:
- ✅ `V_INT_Handler` ($1684) - Frame sync state machine with documentation
- ✅ `H_INT_Handler` ($170A) - Unused H-blank handler
- ✅ `DefaultExceptionHandler` ($0832) - Crash handler

**Input System**:
- ✅ `ClearInputState` ($204A) - Input RAM cleanup (11 calls)
- ✅ `SetInputFlag` ($205E) - Input processing enable (16 calls)
- ✅ `InitInputSystem` ($2066) - Input initialization

**Frame Synchronization**:
- ✅ `WaitForVBlank` ($4998) - V-INT sync (21 calls)
- ✅ `SetDisplayParams` ($49AA) - Display init (21 calls)

**Function Labels**:
- ✅ 103 function labels injected across codebase
- ✅ All hotspot functions identified and labeled

### Remaining (759 functions)

**Priority Order** (by call frequency):
1. `SendDREQCommand` ($FB36) - 17 calls
2. `ControllerRead` ($179E) - 16 calls
3. `TableLookup` ($14BE) - 12 calls
4. `UpdateInputState` ($2080) - 21 calls (complex state machine)
5. All other functions (285 additional)

## Annotation Workflow

### Step 1: Identify Function
1. Look up address in `analysis/68K_ANNOTATION_TASKS.md`
2. Determine call frequency and purpose
3. Find the section file (e.g., `code_XXXX.asm`)

### Step 2: Read Disassembly
```bash
grep -n "FunctionName:" disasm/sections/code_XXXX.asm
```
Check the dc.w statements with disassembly comments.

### Step 3: Understand the Code
- Read comments showing disassembled instructions
- Identify instruction patterns (branches, loops, table lookups)
- Note which RAM/register locations are used
- Reference [development-guide.md](docs/development-guide.md) for 32X conventions

### Step 4: Convert to Mnemonics
Replace dc.w statements with proper 68K mnemonics:

```asm
; BEFORE:
        dc.w    $4A78                    ; 00881684: dc.w $4A78
        dc.w    $C87A                    ; 00881686: dc.w $C87A

; AFTER:
        tst.w   ($C87A).w               ; 00881684: Check V-INT state
        beq.s   .disabled               ; 00881688: Skip if zero
```

### Step 5: Add Documentation
```asm
; ============================================================================
; FunctionName - Brief Description
; ============================================================================
; Full explanation of purpose, behavior, and assumptions.
;
; Parameters/Usage:
;   Register setup or RAM requirements
;
; Returns:
;   What happens when function completes
;
; RAM Usage:
;   ($XXXX).W - Description
;   ($YYYY).L - Description
;
; Notes:
;   Important details about calling convention, timing, etc.
; ============================================================================
FunctionName:
        <converted mnemonics>
```

### Step 6: Verify Build
```bash
make all
cmp build/vr_rebuild.32x "Virtua Racing Deluxe (USA).32x"
# Should output: PERFECT MATCH (no output) with exit code 0
```

**Critical**: Byte-for-byte match MUST be maintained. Any error in conversion shows up immediately.

## Key Patterns to Recognize

### Pattern: V-INT Synchronization
```asm
move.w  #<STATE>,($C87A).w    ; Request V-INT state
move.w  #$2300,sr            ; Enable interrupts
.loop:
  tst.w   ($C87A).w           ; Check if handler cleared flag
  bne.s   .loop               ; Loop until zero
```
Used in `WaitForVBlank`, frame sync primitives.

### Pattern: RAM State Initialization
```asm
moveq   #$00,d0              ; Load zero
move.b  d0,($C822).w        ; Clear state byte
move.w  d0,($C8A4).w        ; Clear state word
```
Used in `ClearInputState`, `InitInputSystem`.

### Pattern: Loop Counter
```asm
move.w  #<COUNT>,d7         ; Initialize counter
.loop:
  <instruction>
  dbra    d7,.loop          ; Decrement and loop
```
Used in initialization loops, bulk operations.

### Pattern: MOVEM Register Save/Restore
```asm
movem.l d0-d7/a0-a6,-(sp)   ; Save registers
<function code>
movem.l (sp)+,d0-d7/a0-a6   ; Restore registers
```
Used in interrupt handlers, complex functions.

## Important RAM Locations

**Input State**:
- `$C822` - Current controller state
- `$C823` - Adjacent state byte
- `$C8A4` - Input counter
- `$C8A2` - Secondary input state
- `$8506` - Hardware input mode
- `$8504` - Hardware input control

**V-INT Synchronization**:
- `$C87A` - V-INT state flag (0=done, 1-15=handler ID)
- `$C964` - Frame counter (incremented every V-INT)

**VDP Control**:
- `$C86C` - Frame buffer address
- `$C86E` - Display parameters

**32X Hardware**:
- `$A10000` - I/O base
- `$A15100` - MARS adapter control
- `$A15120-$A1512E` - COMM registers (SH2 communication)
- `$A15200` - 32X frame buffer control

## Testing & Validation

### Single File Test
```bash
# Edit one section file
vim disasm/sections/code_XXXX.asm

# Build and test
make all
cmp build/vr_rebuild.32x "Virtua Racing Deluxe (USA).32x"
```

### Run in Emulator
```bash
# After successful build
blastem build/vr_rebuild.32x    # Linux
Gens.exe build/vr_rebuild.32x   # Windows
```

## Automated Tools

### Inject Labels
```bash
python3 tools/inject_labels.py
# Adds 103 function labels based on analysis database
```

### Batch Extract Sections
```bash
# Extract $20000-$40000 in 8KB chunks
python3 tools/batch_extract.py
# Creates code_20000.asm, code_22000.asm, etc.
```

### Update Master File
```bash
python3 tools/update_vrd.py
# Automatically updates disasm/vrd.asm includes
# Updates rom_remainder.bin to start after last section
```

## Resource Files

**Analysis Documentation** (essential references):
- `analysis/68K_ANNOTATION_TASKS.md` - Function inventory and status
- `analysis/68K_HOTSPOT_FUNCTIONS.md` - Top 20 most-called functions
- `analysis/68K_INTERRUPT_HANDLERS.md` - Exception handling
- `analysis/68K_ENTRY_INIT.md` - Boot sequence documentation
- `analysis/68K_CONTROLLER_INPUT.md` - Input system details
- `analysis/68K_VINT_STATES.md` - V-INT state machine
- `analysis/68K_MAIN_LOGIC.md` - Game loop architecture

**General Documentation**:
- `docs/development-guide.md` - CPU coordination and conventions
- `docs/32x-hardware-manual.md` - Complete hardware reference

## Next Priority Functions

**Tier 1 (Highest impact, fewer lines)**:
1. `SendDREQCommand` ($FB36) - 17 calls, SH2 communication
2. `ControllerRead` ($179E) - 16 calls, input polling
3. `TableLookup` ($14BE) - 12 calls, data access

**Tier 2 (Complex state machines)**:
1. `UpdateInputState` ($2080) - 21 calls, complex branching
2. `VDPFrameControl` ($26C8) - 10 calls, frame buffer sync

**Tier 3 (Initialization functions)**:
1. All functions in `entry_point.asm` remaining unconverted
2. All functions in `exception_handlers.asm` remaining unconverted

## Making Changes

### Safe Editing Process
1. Read the current file with the Read tool
2. Identify the exact old_string to replace (including addresses and comments)
3. Write the new version with proper formatting
4. Build and verify PERFECT MATCH
5. Only then move to next function

### Common Mistakes to Avoid
- ❌ Changing instruction addresses in comments
- ❌ Altering instruction sizes (2/4/6/8/10 byte opcodes)
- ❌ Modifying dc.w data sections meant to be binary data
- ❌ Inconsistent indentation (use tabs)
- ❌ Forgetting the disassembly comment on each line

### Verified Safe Changes
- ✅ Converting dc.w to proper mnemonics (same bytes)
- ✅ Adding labels for known functions
- ✅ Adding/improving documentation comments
- ✅ Using local labels (e.g., `.loop`, `.done`)

## Performance Notes

- Each function annotation is independent
- Sections can be worked on in any order
- Focus on hotspots first (highest call count)
- Build times: ~2-3 seconds with vasm
- Use `make clean && make all` to force rebuild

## Contributing Guidelines

1. **Pick a function** from remaining list in order of call count
2. **Read the analysis** - understand what it does
3. **Convert to mnemonics** - one section at a time
4. **Add documentation** - explain RAM/register usage
5. **Verify build** - PERFECT MATCH required
6. **Commit your work** - clear commit message
7. **Update progress** - note function in this guide

## Long-term Goals

- [x] Complete ROM disassembly (100% coverage)
- [x] Byte-accurate verification (PERFECT MATCH)
- [x] Function label injection (103 labels)
- [ ] Convert top 50 hotspot functions (in progress)
- [ ] Complete entry point annotation (14 functions)
- [ ] Complete exception handlers (4 functions)
- [ ] Annotate main game logic (128 functions)
- [ ] Achieve 100% function annotation (769 functions)

## Questions?

Refer to:
1. **How functions work** → `analysis/` documentation
2. **Hardware details** → `docs/32x-hardware-manual.md`
3. **Code conventions** → `docs/development-guide.md`
4. **Function locations** → `analysis/68K_ANNOTATION_TASKS.md`
