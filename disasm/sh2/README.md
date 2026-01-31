# SH2 Assembly Source Directory

This directory contains **proper SH2 assembly code** using mnemonics instead of dc.w hex values.

## Why This Exists

The main disassembly uses `dc.w` hex format which is:
- ❌ Error-prone (D102 vs D002 register confusion)
- ❌ Hard to read ($2012 vs mov.l r1,@r0)
- ❌ Difficult to modify
- ❌ No assembler validation

This directory provides:
- ✅ Readable assembly with mnemonics
- ✅ Assembler catches errors
- ✅ Proper labels and comments
- ✅ Easier to modify and debug

## Workflow

### Writing New Code

1. **Create assembly file**: `disasm/sh2/my_function.asm`
```asm
.section .text
.align 2

.global my_function
my_function:
    mov.l   data_addr,r0
    mov     #0,r1
    rts
    nop

.align 4
data_addr:
    .long   0x20004024
```

2. **Build to binary**:
```bash
make sh2/my_function.bin
```

3. **Generate dc.w include** (automatic):
```bash
# Creates: disasm/sh2/generated/my_function_dcw.inc
```

4. **Include in main section**:
```asm
; In disasm/sections/code_20200.asm
my_function:
        include "sh2/generated/my_function_dcw.inc"
```

5. **Build ROM**:
```bash
make all
```

## Converting Existing dc.w Sections

### Step 1: Extract Section
```bash
tools/convert_dcw_to_asm.sh disasm/sections/code_20200.asm 0x02050C 0x02051E
```

### Step 2: Review and Edit
Edit `disasm/sh2/code_20200_converted.asm`:
- Add proper labels
- Separate code from data
- Add comments
- Fix addressing modes

### Step 3: Test Assembly
```bash
sh-elf-as --isa=sh2 -o /tmp/test.o disasm/sh2/code_20200_converted.asm
sh-elf-objcopy -O binary /tmp/test.o /tmp/test.bin
```

### Step 4: Verify Binary Match
```bash
# Compare with original
hexdump -C /tmp/test.bin
hexdump -C build/vr_rebuild.32x -s 0x02050C -n 18
```

### Step 5: Integrate
Replace dc.w section with assembly-generated include.

## Current Files

### 3D Engine (`3d_engine/`)
- `func_000_data_copy.asm` - Matrix/constant copy to VDP (12 longwords)
- `func_001_main_coordinator.asm` - Central dispatch for 3D engine
- `func_002_case_handlers.asm` - Jump table handlers
- `func_003_004_offset_copy.asm` - Tiny offset-based copy utilities
- `func_005_transform_loop.asm` - Vertex transform loop
- `func_006_matrix_multiply.asm` - 4x4 matrix multiplication
- `func_021_original.asm` - Original vertex transform function
- `func_023_frustum_cull.asm` - Frustum culling logic
- `master_command_loop.asm` - Master SH2 command dispatcher
- `slave_idle_loop.asm` - Slave initial idle state
- `slave_command_dispatcher.asm` - Slave command polling loop (66.5% idle confirmed)
- `func_025_027_028_030_031_small_utils.asm` - Min/max tracking utilities
- `func_034_span_filler.asm` - Edge interpolation for rasterizer
- `func_036_render_dispatch.asm` - Display list processor
- `func_037_038_039_helpers.asm` - Visibility test helpers
- `func_040_059_display_engine.asm` - Display list processing (~20 funcs)
- `func_060_063_raster_batch.asm` - Batch copy coordinators (call func_065)
- `func_067_plus_vdp_hw.asm` - VDP hardware init and RLE unpacker
- *(41 total function files, ~100+ functions translated)*

### Expansion (`expansion/`)
- `func_021_optimized.asm` - Optimized vertex transform for Slave
- `phase11_hook_v2.asm` - Master→Slave dispatch hook

### Root
- `batch_copy_handler.asm` - Batch memory copy handler (cmd $26) ✅ **INTEGRATED**

### Legacy Test Files
- `slave_test_loop.asm` - COMM2 increment test (with .align)
- `slave_test_exact.asm` - COMM2 increment test (exact layout) ✅ **BYTE-PERFECT**

## Build System Integration

The Makefile now supports SH2 assembly:

```bash
# Build all SH2 assembly to dc.w includes
make sh2-assembly

# Build full ROM (automatically runs sh2-assembly first)
make all

# Verify SH2 assembly matches original ROM
make sh2-verify
```

Each function has explicit rules in the Makefile with size truncation for exact matches:
- Assembly: `sh-elf-as --isa=sh2 -o func.o func.asm`
- Binary: `sh-elf-objcopy -O binary func.o func.bin`
- Include: `xxd -p func.bin | fold -w4 | awk '{print "dc.w $$" toupper($1)}'`

## Advantages of This Approach

1. **Incremental Migration**: Convert sections as we touch them
2. **Backward Compatible**: Works with existing dc.w build system
3. **Best of Both Worlds**: Write in assembly, build as dc.w
4. **Safe**: Byte-perfect verification before integration
5. **Gradual**: No "big bang" conversion required

## Testing Strategy

For each converted section:

1. **Build Baseline**:
   ```bash
   make clean && make all
   cp build/vr_rebuild.32x build/baseline.32x
   ```

2. **Convert Section**: Use conversion workflow

3. **Build With Assembly**:
   ```bash
   make clean && make all
   ```

4. **Verify Identical**:
   ```bash
   diff build/vr_rebuild.32x build/baseline.32x
   # Should output nothing (files identical)
   ```

5. **Test in Emulator**:
   ```bash
   third_party/picodrive/picodrive build/vr_rebuild.32x
   ```

## Status

- ✅ Assembly toolchain working (sh-elf-as)
- ✅ Byte-perfect output proven (slave_test_exact.asm)
- ✅ Conversion workflow created
- ✅ Build system integration (Makefile rules for 19 functions)
- ⏳ Batch conversion tools (planned)

## Functions in Build System

The following functions are automatically built via `make sh2-assembly`:

| Function | Source | Size | Notes |
|----------|--------|------|-------|
| func_000 | 3d_engine/ | 26B | Data copy to VDP (with linker script) |
| func_005 | 3d_engine/ | 56B | Transform loop (with linker script) |
| func_006 | 3d_engine/ | 88B | Matrix multiply |
| func_007 | 3d_engine/ | 52B | Alt transform loop (with linker script) |
| func_008 | 3d_engine/ | 56B | Alt matrix multiply |
| func_009 | 3d_engine/ | 30B | Display list 4elem |
| func_010 | 3d_engine/ | 26B | Display list 3elem |
| func_011 | 3d_engine/ | 84B | Display list loop (with linker script) |
| func_012 | 3d_engine/ | 92B | Display entry handler (with linker script) |
| func_013 | 3d_engine/ | 92B | VDP init short (with linker script) |
| func_026 | 3d_engine/ | 68B | Bounds compare + exit paths (with linker script) |
| func_016 | 3d_engine/ | 34B | Coord transform |
| func_017 | 3d_engine/ | 26B | Quad helper (with linker script) |
| func_022 | 3d_engine/ | 26B | Wait ready/HW sync (with linker script) |
| func_032 | 3d_engine/ | 32B | Table lookup loop (with linker script) |
| func_065 | 3d_engine/ | 152B | Unrolled data copy |
| func_066 | 3d_engine/ | 48B | RLE decoder |
| func_021_optimized | expansion/ | 96B | Slave vertex transform |
| batch_copy_handler | root | 56B | Batch copy cmd $26 |

## Next Priorities

1. Convert `code_20200.asm` section around $02050C (our active code)
2. Activate batch_copy_handler in jump table (cmd $26)
3. Document conversion best practices
4. Convert sections incrementally as we touch them
