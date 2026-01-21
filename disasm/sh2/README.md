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

- `slave_test_loop.asm` - COMM2 increment test (with .align)
- `slave_test_exact.asm` - COMM2 increment test (exact layout) ✅ **BYTE-PERFECT**

## Build System Integration

The Makefile will eventually support:

```makefile
# Auto-build all SH2 assembly to dc.w includes
sh2-assembly: $(SH2_ASM_FILES:.asm=.inc)

%.inc: %.asm
	sh-elf-as --isa=sh2 -o $(@:.inc=.o) $<
	sh-elf-objcopy -O binary $(@:.inc=.o) $(@:.inc=.bin)
	od -An -tx2 -w2 $(@:.inc=.bin) | awk '{print "        dc.w    $$" toupper($$1)}' > $@
```

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
- ⏳ Build system integration (planned)
- ⏳ Batch conversion tools (planned)

## Next Priorities

1. Convert `code_20200.asm` section around $02050C (our active code)
2. Create Makefile rules for automatic assembly→dc.w
3. Document conversion best practices
4. Convert sections incrementally as we touch them
