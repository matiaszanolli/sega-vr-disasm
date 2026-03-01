# SH2 Build Integration Analysis

> **SUPERSEDED (2026-02-28):** All 92 SH2 function IDs are now fully integrated into the build system. This document was a planning draft from January 2026. For current integration status, see [SH2_TRANSLATION_INTEGRATION.md](../sh2-analysis/SH2_TRANSLATION_INTEGRATION.md).

**Date:** 2026-01-31
**Purpose:** Methodical plan for integrating translated SH2 functions into the build system
**Status:** COMPLETE — all 92 function IDs integrated (see superseding doc above)

---

## Executive Summary

- **Total translated files:** 41 files in `disasm/sh2/3d_engine/`
- **Currently build-integrated:** 9 functions (7 in ROM, 2 in expansion)
- **Remaining candidates:** 32 files (many are documentation-only or composite)

---

## 1. Currently Build-Integrated Functions

These functions are assembled via `make sh2-assembly` and included in the ROM:

### ROM-Replacing Functions (verified against original)

| Function | ROM Offset | Size | Include Location | Verified |
|----------|------------|------|------------------|----------|
| func_006 | 0x23120 | 88B | code_22200.asm:1948 | Yes (sh2-verify) |
| func_008 | 0x231AC | 56B | code_22200.asm:1980 | Yes (sh2-verify) |
| func_009 | 0x231E4 | 30B | code_22200.asm:1987 | Yes (sh2-verify) |
| func_010 | 0x23202 | 26B | code_22200.asm:1993 | Yes (sh2-verify) |
| func_016 | 0x23368 | 34B | code_22200.asm:2162 | Yes (sh2-verify) |
| func_065 | 0x23F2C | 152B | code_22200.asm:3661 | Yes (sh2-verify) |
| func_066 | 0x23FC4 | 48B | code_22200.asm:3669 | Yes (sh2-verify) |

### Expansion ROM Functions (new code, not replacing original)

| Function | Expansion Addr | Size | Include Location | Notes |
|----------|----------------|------|------------------|-------|
| func_021_optimized | 0x300100 | 96B | expansion_300000.asm:138 | Slave vertex transform |
| batch_copy_handler | 0x300500 | 56B | expansion_300000.asm:400 | Batch copy cmd $26 |

---

## 2. Function Classification

> **Note:** Categories are not mutually exclusive. Some functions appear in both
> a numbered category (A-E) and the Appendix. Total file count is 41; function
> counts overlap because composite files contain multiple functions.

### Category A: Standalone Functions (Easiest to Integrate)

These have clear boundaries, no shared exits, and can be verified independently.

| Function | ROM Offset | Size | Notes |
|----------|------------|------|-------|
| func_000 | 0x2300A | 26B* | Data copy to VDP (verified) |
| func_005 | 0x230E8 | 56B* | Transform loop (verified) |
| func_007 | 0x23178 | 52B* | Alt transform (verified) |
| func_011 | 0x23220 | 70B | Display list loop |
| func_012 | 0x23278 | 74B | Display entry handler |
| func_013 | 0x232D4 | 64B* | VDP init (verified, includes literals) |
| func_017 | 0x2338A | 26B* | Quad helper (verified) |
| func_021_original | 0x234C8 | 36B | ⚠️ DO NOT INTEGRATE (async experiments active) |
| func_022 | 0x234EE | 26B* | Wait ready (verified) |
| func_026 | 0x23644 | 52B | Bounds compare |
| func_029 | 0x23688 | 64B | Visibility classify |
| func_032 | 0x236DA | 30B* | Scanline setup (verified) |
| func_033 | 0x236F8 | 98B | Render quad |

**Total Category A:** 13 functions (12 integrable, 1 blocked by experiments)

### Category B: Multi-Function Files (Grouped Translations)

These files contain multiple related functions that share code or exits.

| File | Functions | ROM Range | Total Size | Complexity |
|------|-----------|-----------|------------|------------|
| func_003_004_offset_copy.asm | 2 | 0x230CC-0x230E7 | 28B* | Low |
| func_025_027_028_030_031_small_utils.asm | 5 | 0x23634-0x236D8 | ~68B | Medium (shared exits) |
| func_037_038_039_helpers.asm | 3 | 0x2381E-0x2385A | ~60B | Low |
| func_060_063_raster_batch.asm | 4 | 0x23DD8-0x23EC6 | 238B | Low |

**Total Category B:** 4 files covering 14 functions

### Category C: Large Composite Files (Documentation Only)

These are summary/documentation files covering many functions. They explain the code but aren't designed for direct assembly.

| File | Functions | ROM Range | Notes |
|------|-----------|-----------|-------|
| func_001_main_coordinator.asm | 1 | 0x23024-0x2306E | Includes jump table |
| func_002_case_handlers.asm | ~8 | 0x23070-0x230CA | Case handlers for func_001 |
| func_018_quad_batch.asm | 1 | 0x233A2-0x2340A | 106B, complex |
| func_019_quad_batch_alt.asm | 1 | 0x2340C-0x23466 | 92B, complex |
| func_020_recursive_quad.asm | 1 | 0x23468-0x234BE | 86B, recursive |
| func_023_frustum_cull.asm | 1 | 0x23508-0x235F2 | 234B, largest standalone |
| func_024_screen_coords.asm | 1 | 0x235F6-0x23632 | 60B |
| func_034_span_filler.asm | 1 | 0x2375C-0x237D0 | ~116B |
| func_036_render_dispatch.asm | 1 | 0x237D6-0x2381C | ~70B |
| func_040_059_display_engine.asm | ~20 | 0x2385A-0x23DD6 | 1404B, summary file |
| func_067_plus_vdp_hw.asm | ~10 | 0x23FF4-0x24200+ | 524B+, VDP region (starts after func_066) |

**Total Category C:** 11 files covering ~46 functions

### Category D: System-Level Functions

These are command loops and dispatchers, not typically replaced.

| File | ROM Offset | Size | Notes |
|------|------------|------|-------|
| master_command_loop.asm | 0x20450 | 64B | Master SH2 main loop |
| slave_command_dispatcher.asm | 0x20570 | 162B | Slave SH2 polling |
| slave_idle_loop.asm | 0x203CC | 14B | Initial idle state |

**Total Category D:** 3 files

### Category E: Supplementary Functions

Functions identified outside the main numbering sequence.

| File | ROM Offset | Size | Notes |
|------|------------|------|-------|
| func_block_copy_2d.asm | 0x251B0 | 68B | 2D block copy |
| func_display_state_machine.asm | 0x239F0 | 128B | Display state |
| func_vdp_init_with_delay.asm | 0x244F0 | 60B | VDP init variant |

**Total Category E:** 3 files

---

## 3. Integration Priority Matrix

### Priority 1: Quick Wins (High confidence, small size)

These can likely be integrated with minimal risk:

| Rank | Function | Header | Verified | ROM Range | Risk Level |
|------|----------|--------|----------|-----------|------------|
| 1 | func_000 | 24B | **26B*** | 0x2300A-0x23023 | Very Low |
| 2 | func_022 | 18B | **26B*** | 0x234EE-0x23507 | Very Low |
| 3 | func_017 | 22B | **26B*** | 0x2338A-0x233A3 | Very Low |
| 4 | func_003_004 | 26B | **28B*** | 0x230CC-0x230E7 | Low |
| 5 | func_032 | 28B | **30B*** | 0x236DA-0x236F7 | Low |
| 6 | func_005 | 52B | **56B*** | 0x230E8-0x2311F | Low |
| 7 | func_007 | 50B | **52B*** | 0x23178-0x231AB | Low |
| 8 | func_013 | 50B | **64B*** | 0x232D4-0x23313 | Low |

**All Priority 1 sizes verified empirically (2026-01-31).** Discrepancies due to:
- Delay slots (2B per RTS)
- Literal pool alignment padding (2-4B)
- Literals included in actual ROM range

### Priority 2: Medium Functions (Moderate size, standalone)

| Rank | Function | Size | ROM Offset | Risk Level | Verify Size |
|------|----------|------|------------|------------|-------------|
| 9 | func_026 | 52B | 0x23644 | Low | Needed |
| 10 | func_024 | 60B | 0x235F6 | Low | Needed |
| 11 | func_029 | 64B | 0x23688 | Low | Needed |
| 12 | func_011 | 70B | 0x23220 | Low | Needed |
| 13 | func_012 | 74B | 0x23278 | Low | Needed |
| 14 | func_033 | 98B | 0x236F8 | Medium | Needed |

### Priority 3: Complex Functions (Requires careful verification)

| Rank | Function | Size | ROM Offset | Risk Level |
|------|----------|------|------------|------------|
| 15 | func_018 | 106B | 0x233A2 | Medium |
| 16 | func_019 | 92B | 0x2340C | Medium |
| 17 | func_020 | 86B | 0x23468 | Medium |
| 18 | func_034 | 116B | 0x2375C | Medium |
| 19 | func_036 | 70B | 0x237D6 | Medium |
| 20 | func_023 | 234B | 0x23508 | High (largest) |

### Priority 4: Multi-Function Groups

| Rank | File | Size | ROM Range | Risk Level |
|------|------|------|-----------|------------|
| 21 | func_037_038_039_helpers | 60B | 0x2381E-0x2385A | Medium |
| 22 | func_025_027_028_030_031 | 68B | 0x23634-0x236D8 | Medium (shared exits) |
| 23 | func_060_063_raster_batch | 238B | 0x23DD8-0x23EC6 | Medium |

### Priority 5: Deferred (Documentation Only)

These are summary files not intended for direct integration:
- func_001_main_coordinator.asm
- func_002_case_handlers.asm
- func_040_059_display_engine.asm
- func_067_plus_vdp_hw.asm

---

## 4. Integration Workflow

> **⚠️ PC-Relative Addressing Warning:** Functions with `MOV.L @(disp,PC),Rn`
> instructions have limited displacement range. Relocating or splitting a function
> can break literal pool references. Always verify assembled output matches expected
> addresses before integration.

For each function, follow this workflow:

### Step 1: Verify Source Compiles
```bash
sh-elf-as --isa=sh2 -o test.o disasm/sh2/3d_engine/func_XXX.asm
sh-elf-objcopy -O binary test.o test.bin
```

### Step 2: Compare Against Original ROM
```bash
dd if="Virtua Racing Deluxe (USA).32x" bs=1 skip=$((ROM_OFFSET)) count=SIZE > original.bin
diff test.bin original.bin
```

### Step 3: Add Makefile Rules
```makefile
SH2_FUNCXXX_SRC = $(SH2_3D_DIR)/func_XXX.asm
SH2_FUNCXXX_BIN = $(BUILD_DIR)/sh2/func_XXX.bin
SH2_FUNCXXX_INC = $(SH2_GEN_DIR)/func_XXX.inc
```

### Step 4: Add to sh2-assembly Target
```makefile
sh2-assembly: ... $(SH2_FUNCXXX_INC)
```

### Step 5: Add Build and Include Rules
```makefile
$(SH2_FUNCXXX_BIN): $(SH2_FUNCXXX_SRC) | dirs
    $(SH2_AS) $(SH2_ASFLAGS) -o ...
    $(SH2_OBJCOPY) -O binary ...
    @truncate -s SIZE $@  # If needed
```

### Step 6: Replace dc.w in Section File
```asm
; Old:
        dc.w    $XXXX
        dc.w    $XXXX
        ...

; New:
        include "sh2/generated/func_XXX.inc"
```

### Step 7: Add to sh2-verify Target
```makefile
@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((ROM_OFFSET)) count=SIZE > original.bin
@diff -q $(SH2_FUNCXXX_BIN) original.bin
```

### Step 8: Full Build and Test
```bash
make clean && make all
make compare
# Test in emulator
```

---

## 5. Known Issues and Considerations

### 5.0 Header Size Accuracy

**IMPORTANT:** Some function headers have size discrepancies due to:
- Padding bytes for literal alignment
- Miscounting delay slots
- Boundary confusion

Example: func_000 header claims "18 bytes + 6 bytes data = 24 bytes" but actual is:
- 20 bytes code (10 instructions)
- 2 bytes padding
- 4 bytes literal
- **Total: 26 bytes** (0x2300A to 0x23023)

**Recommendation:** Always verify sizes empirically before integration:
```bash
# Find exact end by locating next function's prologue (4F22 = STS.L PR,@-R15)
xxd -s $START -l 64 "Virtua Racing Deluxe (USA).32x" | grep -m1 "4f22"
```

### 5.1 Size Truncation

Many SH2 assembly files produce output larger than expected due to:
- Alignment padding (.align directives)
- Shared delay slots with next function
- Literal pool alignment

The `truncate -s SIZE` command is used to trim to exact size.

### 5.2 Shared Exit Points

Functions like func_027, func_028, func_030, func_031 are actually shared exit points for func_026 and func_029. They must be integrated together.

### 5.3 Adjacent Functions

Some functions share delay slots:
- func_008's RTS delay slot is func_009's first instruction
- This requires careful size calculation

### 5.4 Literal Pool Placement

Functions with PC-relative loads must have literals within range:
- MOV.L @(disp,PC) has limited displacement
- Literals must be 4-byte aligned

### 5.5 Label Conflicts

Generated includes don't preserve labels. If other code references internal labels, integration may break things.

---

## 6. Verification Checklist

For each integrated function:

- [ ] Source file compiles without errors
- [ ] Binary output matches original ROM bytes exactly
- [ ] Makefile rules added correctly
- [ ] sh2-assembly builds successfully
- [ ] sh2-verify passes for this function
- [ ] Full ROM builds successfully
- [ ] ROM boots in emulator
- [ ] Gameplay appears normal

---

## 7. Recommended Integration Order

### Phase 1: Quick Wins (Week 1)
1. func_000 (26B*) - Simplest, verified
2. func_022 (26B*) - Verified
3. func_017 (26B*) - Verified
4. func_032 (30B*) - Verified

### Phase 2: Small Standalone (Week 2)
5. func_003_004 (28B*) - Grouped pair, verified
6. func_005 (56B*) - Transform loop, verified
7. func_007 (52B*) - Alt transform, verified
8. func_013 (64B*) - VDP init, verified (includes literals)

### Phase 3: Medium Functions (Week 3)
9. func_026 (52B)
10. func_024 (60B)
11. func_029 (64B)
12. func_011 (70B)

### Phase 4: Larger Functions (Week 4+)
13. func_012 (74B)
14. func_033 (98B)
15. func_018 (106B)
16. func_019 (92B)

### Phase 5: Complex Integration (Future)
17. func_020 (86B) - Recursive
18. func_023 (234B) - Largest
19. Multi-function groups

---

## 8. Next Steps

1. **Cross-validate this analysis** - User reviews ROM offsets and sizes
2. **Start with func_000** - Simplest integration to prove workflow
3. **Establish verification baseline** - Confirm `make sh2-verify` catches mismatches
4. **Iterate through Priority 1** - 8 functions, ~260 bytes total

---

## Appendix A: Full Function Inventory

> **Range Convention:** ROM End is the **last byte** of the function (inclusive).
> Size = ROM End - ROM Start + 1. Sizes marked with `*` have been verified against ROM.

| File | ROM Start | ROM End | Size | Status |
|------|-----------|---------|------|--------|
| func_000_data_copy.asm | 0x2300A | 0x23023 | 26B* | Not integrated |
| func_001_main_coordinator.asm | 0x23024 | 0x2306E | 74B | Doc only |
| func_002_case_handlers.asm | 0x23070 | 0x230CA | 90B | Doc only |
| func_003_004_offset_copy.asm | 0x230CC | 0x230E7 | 28B* | Not integrated |
| func_005_transform_loop.asm | 0x230E8 | 0x2311F | 56B* | Not integrated |
| func_006_matrix_multiply.asm | 0x23120 | 0x23177 | 88B | **INTEGRATED** |
| func_007_alt_transform_loop.asm | 0x23178 | 0x231AB | 52B* | Not integrated |
| func_008_alt_matrix_multiply.asm | 0x231AC | 0x231E3 | 56B | **INTEGRATED** |
| func_009_display_list_4elem.asm | 0x231E4 | 0x23201 | 30B | **INTEGRATED** |
| func_010_display_list_3elem.asm | 0x23202 | 0x2321B | 26B | **INTEGRATED** |
| func_011_display_list_loop.asm | 0x23220 | 0x23266 | 70B | Not integrated |
| func_012_display_entry_handler.asm | 0x23278 | 0x232C2 | 74B | Not integrated |
| func_013_vdp_init.asm | 0x232D4 | 0x23313 | 64B* | Not integrated |
| func_016_coord_transform.asm | 0x23368 | 0x2338A | 34B | **INTEGRATED** |
| func_017_quad_helper.asm | 0x2338A | 0x233A3 | 26B* | Not integrated |
| func_018_quad_batch.asm | 0x233A2 | 0x2340A | 106B | Not integrated |
| func_019_quad_batch_alt.asm | 0x2340C | 0x23466 | 92B | Not integrated |
| func_020_recursive_quad.asm | 0x23468 | 0x234BE | 86B | Not integrated |
| func_021_original.asm | 0x234C8 | 0x234EC | 36B | Not integrated |
| func_022_wait_ready.asm | 0x234EE | 0x23507 | 26B* | Not integrated |
| func_023_frustum_cull.asm | 0x23508 | 0x235F2 | 234B | Not integrated |
| func_024_screen_coords.asm | 0x235F6 | 0x23632 | 60B | Not integrated |
| func_025_027_028_030_031_small_utils.asm | 0x23634 | 0x236D8 | ~68B | Not integrated |
| func_026_bounds_compare.asm | 0x23644 | 0x23678 | 52B | Not integrated |
| func_029_visibility_classify.asm | 0x23688 | 0x236C8 | 64B | Not integrated |
| func_032_scanline_setup.asm | 0x236DA | 0x236F7 | 30B* | Not integrated |
| func_033_render_quad.asm | 0x236F8 | 0x2375A | 98B | Not integrated |
| func_034_span_filler.asm | 0x2375C | 0x237D0 | ~116B | Not integrated |
| func_036_render_dispatch.asm | 0x237D6 | 0x2381C | ~70B | Not integrated |
| func_037_038_039_helpers.asm | 0x2381E | 0x2385A | ~60B | Not integrated |
| func_040_059_display_engine.asm | 0x2385A | 0x23DD6 | 1404B | Doc only |
| func_060_063_raster_batch.asm | 0x23DD8 | 0x23EC6 | 238B | Not integrated |
| func_065_unrolled_data_copy.asm | 0x23F2C | 0x23FC3 | 152B | **INTEGRATED** |
| func_066_rle_decoder.asm | 0x23FC4 | 0x23FF3 | 48B | **INTEGRATED** |
| func_067_plus_vdp_hw.asm | 0x23FF4 | 0x24200+ | 524B+ | Doc only (starts after func_066) |

---

---

**Notes:**
- `*` = Size verified empirically against ROM (may differ from header)
- All other sizes are from file headers and should be verified before integration

---

**Document:** SH2_BUILD_INTEGRATION_ANALYSIS.md
**Created:** 2026-01-31
**For:** Cross-validation of integration plan
