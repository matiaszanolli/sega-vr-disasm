# ============================================================================
# Virtua Racing Deluxe (32X) - Reassembly Build System
# ============================================================================

# Tools
ASM = tools/vasmm68k_mot
SH2_AS = sh-elf-as
SH2_OBJCOPY = sh-elf-objcopy
SH2_ASFLAGS = --isa=sh2
PYTHON = python3

# Directories
BUILD_DIR = build
DISASM_DIR = disasm
TOOLS_DIR = tools
ORIGINAL_ROM = Virtua Racing Deluxe (USA).32x
OUTPUT_ROM = $(BUILD_DIR)/vr_rebuild.32x

# Assembly flags
# -Fbin = binary output
# -m68000 = target CPU
# -no-opt = no optimization (preserve original code)
# -o = output file
ASMFLAGS = -Fbin -m68000 -no-opt -spaces -quiet

# Source files
M68K_SRC = $(DISASM_DIR)/vrd.asm
M68K_SRC_RAW = $(DISASM_DIR)/vrd_raw.asm
M68K_SRC_MODULAR = $(DISASM_DIR)/vrd_modular.asm
M68K_SRC_MNEMONIC = $(DISASM_DIR)/vrd_mnemonic.asm
OUTPUT_ROM_RAW = $(BUILD_DIR)/vr_rebuild_raw.32x
OUTPUT_ROM_MODULAR = $(BUILD_DIR)/vr_rebuild_modular.32x
OUTPUT_ROM_MNEMONIC = $(BUILD_DIR)/vr_rebuild_mnemonic.32x

.PHONY: all clean disasm compare tools test modular compare-modular raw compare-raw mnemonic compare-mnemonic profile-frame profile-pc

# ============================================================================
# Main targets
# ============================================================================

all: dirs sh2-assembly $(OUTPUT_ROM)

raw: dirs $(OUTPUT_ROM_RAW)

modular: dirs $(OUTPUT_ROM_MODULAR)

mnemonic: dirs $(OUTPUT_ROM_MNEMONIC)

dirs:
	@mkdir -p $(BUILD_DIR)

# Build the ROM from original sections/
# Depends on SH2 assembly to ensure generated includes exist
$(OUTPUT_ROM): $(M68K_SRC) $(SH2_FUNC000_INC) $(SH2_FUNC022_INC) $(SH2_FUNC017_INC) $(SH2_FUNC018_INC) $(SH2_FUNC019_INC) $(SH2_FUNC020_INC) $(SH2_FUNC021_ORIG_INC) $(SH2_FUNC023_INC) $(SH2_FUNC040_INC) $(SH2_FUNC032_INC) $(SH2_FUNC011_INC) $(SH2_FUNC012_INC) $(SH2_FUNC013_INC) $(SH2_FUNC014_015_INC) $(SH2_FUNC024_INC) $(SH2_FUNC025_INC) $(SH2_FUNC026_INC) $(SH2_FUNC003_004_INC) $(SH2_FUNC029_030_031_INC) $(SH2_FUNC033_INC) $(SH2_FUNC034_INC) $(SH2_FUNC036_INC) $(SH2_FUNC037_038_039_INC) $(SH2_FUNC005_INC) $(SH2_FUNC007_INC) $(SH2_FUNC006_INC) $(SH2_FUNC008_INC) $(SH2_FUNC016_INC) $(SH2_FUNC065_INC) $(SH2_FUNC066_INC) $(SH2_FUNC021_OPT_INC) $(SH2_BATCH_COPY_INC) $(SH2_CMD27_DRAIN_INC) $(SH2_SLAVE_WRAPPER_V2_INC) $(SH2_HANDLER_FRAME_SYNC_INC) $(SH2_MASTER_DISPATCH_HOOK_INC) $(SH2_SLAVE_TEST_FUNC_INC) $(SH2_SHADOW_PATH_WRAPPER_INC) $(SH2_CMDINT_HANDLER_INC) $(SH2_QUEUE_PROCESSOR_INC)
	@echo "==> Assembling 68000 code (from sections/)..."
	$(ASM) $(ASMFLAGS) -o $@ $<
	@echo "==> Build complete: $@"
	@ls -lh $@

# Build the ROM from raw DC.W sections (guaranteed correct)
$(OUTPUT_ROM_RAW): $(M68K_SRC_RAW)
	@echo "==> Assembling 68000 code (from sections_raw/)..."
	$(ASM) $(ASMFLAGS) -o $@ $<
	@echo "==> Build complete: $@"
	@ls -lh $@

# Build the ROM from modular structure
$(OUTPUT_ROM_MODULAR): $(M68K_SRC_MODULAR)
	@echo "==> Assembling 68000 code (from modules/)..."
	$(ASM) $(ASMFLAGS) -o $@ $<
	@echo "==> Build complete: $@"
	@ls -lh $@

# Build the ROM from mnemonic sections (proper assembly, not DC.W)
$(OUTPUT_ROM_MNEMONIC): $(M68K_SRC_MNEMONIC)
	@echo "==> Assembling 68000 code (from sections-mnemonic/)..."
	$(ASM) $(ASMFLAGS) -o $@ $<
	@echo "==> Build complete: $@"
	@ls -lh $@

# ============================================================================
# Disassembly targets
# ============================================================================

disasm: disasm-m68k disasm-sh2

disasm-m68k:
	@echo "==> Disassembling 68000 code..."
	$(PYTHON) $(TOOLS_DIR)/m68k_disasm.py "$(ORIGINAL_ROM)" 0x0 100

disasm-sh2:
	@echo "==> Disassembling SH2 code..."
	$(PYTHON) $(TOOLS_DIR)/sh2_disasm.py "$(ORIGINAL_ROM)" 0x245E4 100

# ============================================================================
# Verification targets
# ============================================================================

# Compare rebuilt ROM with original (from sections/)
compare: $(OUTPUT_ROM)
	@echo "==> Comparing ROM files (sections/ build)..."
	@if [ ! -f "$(ORIGINAL_ROM)" ]; then \
		echo "ERROR: Original ROM not found: $(ORIGINAL_ROM)"; \
		exit 1; \
	fi
	@ORIG_SIZE=$$(stat -c%s "$(ORIGINAL_ROM)"); \
	BUILD_SIZE=$$(stat -c%s "$(OUTPUT_ROM)"); \
	echo "Original ROM size: $$ORIG_SIZE bytes"; \
	echo "Rebuilt ROM size:  $$BUILD_SIZE bytes"; \
	if [ $$ORIG_SIZE -eq $$BUILD_SIZE ]; then \
		echo "✓ Sizes match!"; \
		echo "==> Comparing bytes..."; \
		cmp -l "$(ORIGINAL_ROM)" "$(OUTPUT_ROM)" | head -20; \
		DIFF_COUNT=$$(cmp -l "$(ORIGINAL_ROM)" "$(OUTPUT_ROM)" | wc -l); \
		if [ $$DIFF_COUNT -eq 0 ]; then \
			echo "✓✓✓ PERFECT MATCH! ROMs are identical! ✓✓✓"; \
		else \
			echo "⚠ Found $$DIFF_COUNT differing bytes"; \
		fi; \
	else \
		echo "✗ Size mismatch!"; \
	fi

# Compare raw ROM build with original
compare-raw: $(OUTPUT_ROM_RAW)
	@echo "==> Comparing ROM files (raw sections build)..."
	@if [ ! -f "$(ORIGINAL_ROM)" ]; then \
		echo "ERROR: Original ROM not found: $(ORIGINAL_ROM)"; \
		exit 1; \
	fi
	@ORIG_SIZE=$$(stat -c%s "$(ORIGINAL_ROM)"); \
	BUILD_SIZE=$$(stat -c%s "$(OUTPUT_ROM_RAW)"); \
	echo "Original ROM size: $$ORIG_SIZE bytes"; \
	echo "Raw build ROM size:  $$BUILD_SIZE bytes"; \
	if [ $$ORIG_SIZE -eq $$BUILD_SIZE ]; then \
		echo "✓ Sizes match!"; \
		echo "==> Comparing bytes..."; \
		cmp -l "$(ORIGINAL_ROM)" "$(OUTPUT_ROM_RAW)" | head -20; \
		DIFF_COUNT=$$(cmp -l "$(ORIGINAL_ROM)" "$(OUTPUT_ROM_RAW)" | wc -l); \
		if [ $$DIFF_COUNT -eq 0 ]; then \
			echo "✓✓✓ PERFECT MATCH! ROMs are identical! ✓✓✓"; \
		else \
			echo "⚠ Found $$DIFF_COUNT differing bytes"; \
		fi; \
	else \
		echo "✗ Size mismatch!"; \
	fi

# Compare modular ROM build with original
compare-modular: $(OUTPUT_ROM_MODULAR)
	@echo "==> Comparing ROM files (modules/ build)..."
	@if [ ! -f "$(ORIGINAL_ROM)" ]; then \
		echo "ERROR: Original ROM not found: $(ORIGINAL_ROM)"; \
		exit 1; \
	fi
	@ORIG_SIZE=$$(stat -c%s "$(ORIGINAL_ROM)"); \
	BUILD_SIZE=$$(stat -c%s "$(OUTPUT_ROM_MODULAR)"); \
	echo "Original ROM size: $$ORIG_SIZE bytes"; \
	echo "Modular build ROM size:  $$BUILD_SIZE bytes"; \
	if [ $$ORIG_SIZE -eq $$BUILD_SIZE ]; then \
		echo "✓ Sizes match!"; \
		echo "==> Comparing bytes..."; \
		cmp -l "$(ORIGINAL_ROM)" "$(OUTPUT_ROM_MODULAR)" | head -20; \
		DIFF_COUNT=$$(cmp -l "$(ORIGINAL_ROM)" "$(OUTPUT_ROM_MODULAR)" | wc -l); \
		if [ $$DIFF_COUNT -eq 0 ]; then \
			echo "✓✓✓ PERFECT MATCH! ROMs are identical! ✓✓✓"; \
		else \
			echo "⚠ Found $$DIFF_COUNT differing bytes"; \
		fi; \
	else \
		echo "✗ Size mismatch!"; \
	fi

# Compare mnemonic ROM build with DC.W build (both 4MB with expansion)
compare-mnemonic: $(OUTPUT_ROM_MNEMONIC) $(OUTPUT_ROM)
	@echo "==> Comparing mnemonic build vs DC.W build..."
	@MNEMONIC_SIZE=$$(stat -c%s "$(OUTPUT_ROM_MNEMONIC)"); \
	DCW_SIZE=$$(stat -c%s "$(OUTPUT_ROM)"); \
	echo "Mnemonic build size: $$MNEMONIC_SIZE bytes"; \
	echo "DC.W build size:     $$DCW_SIZE bytes"; \
	if [ $$MNEMONIC_SIZE -eq $$DCW_SIZE ]; then \
		echo "✓ Sizes match!"; \
		echo "==> Comparing bytes (first 3MB = 68K region)..."; \
		dd if="$(OUTPUT_ROM)" bs=1 count=3145728 2>/dev/null > /tmp/dcw_3mb.bin; \
		dd if="$(OUTPUT_ROM_MNEMONIC)" bs=1 count=3145728 2>/dev/null > /tmp/mnemonic_3mb.bin; \
		cmp -l /tmp/dcw_3mb.bin /tmp/mnemonic_3mb.bin | head -20; \
		DIFF_COUNT=$$(cmp -l /tmp/dcw_3mb.bin /tmp/mnemonic_3mb.bin | wc -l); \
		rm -f /tmp/dcw_3mb.bin /tmp/mnemonic_3mb.bin; \
		if [ $$DIFF_COUNT -eq 0 ]; then \
			echo "✓✓✓ PERFECT MATCH! Mnemonic build is byte-identical! ✓✓✓"; \
		else \
			echo "⚠ Found $$DIFF_COUNT differing bytes in 68K region"; \
		fi; \
	else \
		echo "✗ Size mismatch!"; \
	fi

# Compare both builds against each other
compare-both: $(OUTPUT_ROM) $(OUTPUT_ROM_MODULAR)
	@echo "==> Comparing sections/ vs modules/ builds..."
	@SECTIONS_SIZE=$$(stat -c%s "$(OUTPUT_ROM)"); \
	MODULAR_SIZE=$$(stat -c%s "$(OUTPUT_ROM_MODULAR)"); \
	echo "sections/ build size: $$SECTIONS_SIZE bytes"; \
	echo "modules/ build size:  $$MODULAR_SIZE bytes"; \
	if [ $$SECTIONS_SIZE -eq $$MODULAR_SIZE ]; then \
		echo "✓ Sizes match!"; \
		DIFF_COUNT=$$(cmp -l "$(OUTPUT_ROM)" "$(OUTPUT_ROM_MODULAR)" | wc -l); \
		if [ $$DIFF_COUNT -eq 0 ]; then \
			echo "✓✓✓ PERFECT MATCH! Both builds are identical! ✓✓✓"; \
		else \
			echo "⚠ Found $$DIFF_COUNT differing bytes between builds"; \
		fi; \
	else \
		echo "✗ Size mismatch between builds!"; \
	fi

# Quick hex dump comparison
hexdump: $(OUTPUT_ROM)
	@echo "==> Original ROM (first 512 bytes):"
	@hexdump -C "$(ORIGINAL_ROM)" | head -32
	@echo ""
	@echo "==> Rebuilt ROM (first 512 bytes):"
	@hexdump -C "$(OUTPUT_ROM)" | head -32

# ============================================================================
# Analysis targets
# ============================================================================

analyze:
	@echo "==> Analyzing ROM structure..."
	$(PYTHON) $(TOOLS_DIR)/analyze_rom.py

find-sections:
	@echo "==> Finding code sections..."
	$(PYTHON) $(TOOLS_DIR)/find_code_sections.py

# ============================================================================
# Tool building
# ============================================================================

tools: tools/vasmm68k_mot

tools/vasmm68k_mot:
	@echo "==> Building vasm assembler..."
	@mkdir -p tools/vasm
	@cd tools/vasm && \
		wget -q http://sun.hasenbraten.de/vasm/release/vasm.tar.gz && \
		tar -xzf vasm.tar.gz && \
		cd vasm && \
		make CPU=m68k SYNTAX=mot
	@cp tools/vasm/vasm/vasmm68k_mot tools/
	@echo "✓ vasm built successfully"

# ============================================================================
# SH2 Assembly
# ============================================================================

# SH2 source directories
SH2_SRC_DIR = $(DISASM_DIR)/sh2
SH2_GEN_DIR = $(SH2_SRC_DIR)/generated
SH2_3D_DIR = $(SH2_SRC_DIR)/3d_engine
SH2_LD = sh-elf-ld

# SH2 source files (Priority 1: simplest functions first)
SH2_FUNC000_SRC = $(SH2_3D_DIR)/func_000_data_copy.asm
SH2_FUNC000_LDS = $(SH2_3D_DIR)/func_000.lds
SH2_FUNC000_BIN = $(BUILD_DIR)/sh2/func_000.bin
SH2_FUNC000_INC = $(SH2_GEN_DIR)/func_000.inc

SH2_FUNC022_SRC = $(SH2_3D_DIR)/func_022_wait_ready.asm
SH2_FUNC022_LDS = $(SH2_3D_DIR)/func_022.lds
SH2_FUNC022_BIN = $(BUILD_DIR)/sh2/func_022.bin
SH2_FUNC022_INC = $(SH2_GEN_DIR)/func_022.inc

SH2_FUNC017_SRC = $(SH2_3D_DIR)/func_017_quad_helper.asm
SH2_FUNC017_LDS = $(SH2_3D_DIR)/func_017.lds
SH2_FUNC017_BIN = $(BUILD_DIR)/sh2/func_017.bin
SH2_FUNC017_INC = $(SH2_GEN_DIR)/func_017.inc

SH2_FUNC032_SRC = $(SH2_3D_DIR)/func_032_scanline_setup.asm
SH2_FUNC032_LDS = $(SH2_3D_DIR)/func_032.lds
SH2_FUNC032_BIN = $(BUILD_DIR)/sh2/func_032.bin
SH2_FUNC032_INC = $(SH2_GEN_DIR)/func_032.inc

SH2_FUNC011_SRC = $(SH2_3D_DIR)/func_011_display_list_loop.asm
SH2_FUNC011_LDS = $(SH2_3D_DIR)/func_011.lds
SH2_FUNC011_BIN = $(BUILD_DIR)/sh2/func_011.bin
SH2_FUNC011_INC = $(SH2_GEN_DIR)/func_011.inc

SH2_FUNC012_SRC = $(SH2_3D_DIR)/func_012_display_entry.asm
SH2_FUNC012_LDS = $(SH2_3D_DIR)/func_012.lds
SH2_FUNC012_BIN = $(BUILD_DIR)/sh2/func_012.bin
SH2_FUNC012_INC = $(SH2_GEN_DIR)/func_012.inc

SH2_FUNC013_SRC = $(SH2_3D_DIR)/func_013_vdp_init_short.asm
SH2_FUNC013_LDS = $(SH2_3D_DIR)/func_013.lds
SH2_FUNC013_BIN = $(BUILD_DIR)/sh2/func_013.bin
SH2_FUNC013_INC = $(SH2_GEN_DIR)/func_013.inc

SH2_FUNC014_015_SRC = $(SH2_3D_DIR)/func_014_015_vdp_copy_short.asm
SH2_FUNC014_015_LDS = $(SH2_3D_DIR)/func_014_015.lds
SH2_FUNC014_015_BIN = $(BUILD_DIR)/sh2/func_014_015.bin
SH2_FUNC014_015_INC = $(SH2_GEN_DIR)/func_014_015.inc

SH2_FUNC025_SRC = $(SH2_3D_DIR)/func_025_coord_offset_short.asm
SH2_FUNC025_LDS = $(SH2_3D_DIR)/func_025.lds
SH2_FUNC025_BIN = $(BUILD_DIR)/sh2/func_025.bin
SH2_FUNC025_INC = $(SH2_GEN_DIR)/func_025.inc

SH2_FUNC024_SRC = $(SH2_3D_DIR)/func_024_screen_coords_short.asm
SH2_FUNC024_LDS = $(SH2_3D_DIR)/func_024.lds
SH2_FUNC024_BIN = $(BUILD_DIR)/sh2/func_024.bin
SH2_FUNC024_INC = $(SH2_GEN_DIR)/func_024.inc

SH2_FUNC026_SRC = $(SH2_3D_DIR)/func_026_bounds_compare_short.asm
SH2_FUNC026_LDS = $(SH2_3D_DIR)/func_026.lds
SH2_FUNC026_BIN = $(BUILD_DIR)/sh2/func_026.bin
SH2_FUNC026_INC = $(SH2_GEN_DIR)/func_026.inc

SH2_FUNC003_004_SRC = $(SH2_3D_DIR)/func_003_004_offset_copy_short.asm
SH2_FUNC003_004_LDS = $(SH2_3D_DIR)/func_003_004.lds
SH2_FUNC003_004_BIN = $(BUILD_DIR)/sh2/func_003_004.bin
SH2_FUNC003_004_INC = $(SH2_GEN_DIR)/func_003_004.inc

SH2_FUNC029_030_031_SRC = $(SH2_3D_DIR)/func_029_030_031_visibility_short.asm
SH2_FUNC029_030_031_LDS = $(SH2_3D_DIR)/func_029_030_031.lds
SH2_FUNC029_030_031_BIN = $(BUILD_DIR)/sh2/func_029_030_031.bin
SH2_FUNC029_030_031_INC = $(SH2_GEN_DIR)/func_029_030_031.inc

SH2_FUNC033_SRC = $(SH2_3D_DIR)/func_033_render_quad_short.asm
SH2_FUNC033_LDS = $(SH2_3D_DIR)/func_033.lds
SH2_FUNC033_BIN = $(BUILD_DIR)/sh2/func_033.bin
SH2_FUNC033_INC = $(SH2_GEN_DIR)/func_033.inc

SH2_FUNC034_SRC = $(SH2_3D_DIR)/func_034_span_filler_short.asm
SH2_FUNC034_LDS = $(SH2_3D_DIR)/func_034.lds
SH2_FUNC034_BIN = $(BUILD_DIR)/sh2/func_034.bin
SH2_FUNC034_INC = $(SH2_GEN_DIR)/func_034.inc

SH2_FUNC036_SRC = $(SH2_3D_DIR)/func_036_render_dispatch_short.asm
SH2_FUNC036_LDS = $(SH2_3D_DIR)/func_036.lds
SH2_FUNC036_BIN = $(BUILD_DIR)/sh2/func_036.bin
SH2_FUNC036_INC = $(SH2_GEN_DIR)/func_036.inc

SH2_FUNC037_038_039_SRC = $(SH2_3D_DIR)/func_037_038_039_helpers_short.asm
SH2_FUNC037_038_039_LDS = $(SH2_3D_DIR)/func_037_038_039.lds
SH2_FUNC037_038_039_BIN = $(BUILD_DIR)/sh2/func_037_038_039.bin
SH2_FUNC037_038_039_INC = $(SH2_GEN_DIR)/func_037_038_039.inc

SH2_FUNC018_SRC = $(SH2_3D_DIR)/func_018_quad_batch_short.asm
SH2_FUNC018_LDS = $(SH2_3D_DIR)/func_018.lds
SH2_FUNC018_BIN = $(BUILD_DIR)/sh2/func_018.bin
SH2_FUNC018_INC = $(SH2_GEN_DIR)/func_018.inc

SH2_FUNC019_SRC = $(SH2_3D_DIR)/func_019_quad_batch_alt_short.asm
SH2_FUNC019_LDS = $(SH2_3D_DIR)/func_019.lds
SH2_FUNC019_BIN = $(BUILD_DIR)/sh2/func_019.bin
SH2_FUNC019_INC = $(SH2_GEN_DIR)/func_019.inc

SH2_FUNC020_SRC = $(SH2_3D_DIR)/func_020_vertex_helper_short.asm
SH2_FUNC020_LDS = $(SH2_3D_DIR)/func_020.lds
SH2_FUNC020_BIN = $(BUILD_DIR)/sh2/func_020.bin
SH2_FUNC020_INC = $(SH2_GEN_DIR)/func_020.inc

SH2_FUNC021_ORIG_SRC = $(SH2_3D_DIR)/func_021_original_short.asm
SH2_FUNC021_ORIG_LDS = $(SH2_3D_DIR)/func_021.lds
SH2_FUNC021_ORIG_BIN = $(BUILD_DIR)/sh2/func_021_orig.bin
SH2_FUNC021_ORIG_INC = $(SH2_GEN_DIR)/func_021_orig.inc

SH2_FUNC023_SRC = $(SH2_3D_DIR)/func_023_frustum_cull_short.asm
SH2_FUNC023_LDS = $(SH2_3D_DIR)/func_023.lds
SH2_FUNC023_BIN = $(BUILD_DIR)/sh2/func_023.bin
SH2_FUNC023_INC = $(SH2_GEN_DIR)/func_023.inc

SH2_FUNC040_SRC = $(SH2_3D_DIR)/func_040_display_list_short.asm
SH2_FUNC040_LDS = $(SH2_3D_DIR)/func_040.lds
SH2_FUNC040_BIN = $(BUILD_DIR)/sh2/func_040.bin
SH2_FUNC040_INC = $(SH2_GEN_DIR)/func_040.inc

SH2_FUNC040_CASES_SRC = $(SH2_3D_DIR)/func_040_cases_short.asm
SH2_FUNC040_CASES_LDS = $(SH2_3D_DIR)/func_040_cases.lds
SH2_FUNC040_CASES_BIN = $(BUILD_DIR)/sh2/func_040_cases.bin
SH2_FUNC040_CASES_INC = $(SH2_GEN_DIR)/func_040_cases.inc

SH2_FUNC040_UTIL_SRC = $(SH2_3D_DIR)/func_040_utility_short.asm
SH2_FUNC040_UTIL_LDS = $(SH2_3D_DIR)/func_040_utility.lds
SH2_FUNC040_UTIL_BIN = $(BUILD_DIR)/sh2/func_040_utility.bin
SH2_FUNC040_UTIL_INC = $(SH2_GEN_DIR)/func_040_utility.inc

SH2_FUNC041_SRC = $(SH2_3D_DIR)/func_041_render_coord_short.asm
SH2_FUNC041_LDS = $(SH2_3D_DIR)/func_041.lds
SH2_FUNC041_BIN = $(BUILD_DIR)/sh2/func_041.bin
SH2_FUNC041_INC = $(SH2_GEN_DIR)/func_041.inc

SH2_FUNC042_SRC = $(SH2_3D_DIR)/func_042_data_copy_short.asm
SH2_FUNC042_LDS = $(SH2_3D_DIR)/func_042.lds
SH2_FUNC042_BIN = $(BUILD_DIR)/sh2/func_042.bin
SH2_FUNC042_INC = $(SH2_GEN_DIR)/func_042.inc

SH2_FUNC043_SRC = $(SH2_3D_DIR)/func_043_polygon_batch_short.asm
SH2_FUNC043_LDS = $(SH2_3D_DIR)/func_043.lds
SH2_FUNC043_BIN = $(BUILD_DIR)/sh2/func_043.bin
SH2_FUNC043_INC = $(SH2_GEN_DIR)/func_043.inc

SH2_FUNC044_SRC = $(SH2_3D_DIR)/func_044_edge_scan_short.asm
SH2_FUNC044_LDS = $(SH2_3D_DIR)/func_044.lds
SH2_FUNC044_BIN = $(BUILD_DIR)/sh2/func_044.bin
SH2_FUNC044_INC = $(SH2_GEN_DIR)/func_044.inc

SH2_FUNC045_SRC = $(SH2_3D_DIR)/func_045_dispatch_loop_short.asm
SH2_FUNC045_LDS = $(SH2_3D_DIR)/func_045.lds
SH2_FUNC045_BIN = $(BUILD_DIR)/sh2/func_045.bin
SH2_FUNC045_INC = $(SH2_GEN_DIR)/func_045.inc

SH2_FUNC046_SRC = $(SH2_3D_DIR)/func_046_array_copy_short.asm
SH2_FUNC046_LDS = $(SH2_3D_DIR)/func_046.lds
SH2_FUNC046_BIN = $(BUILD_DIR)/sh2/func_046.bin
SH2_FUNC046_INC = $(SH2_GEN_DIR)/func_046.inc

SH2_FUNC047_SRC = $(SH2_3D_DIR)/func_047_bounds_check_short.asm
SH2_FUNC047_LDS = $(SH2_3D_DIR)/func_047.lds
SH2_FUNC047_BIN = $(BUILD_DIR)/sh2/func_047.bin
SH2_FUNC047_INC = $(SH2_GEN_DIR)/func_047.inc

SH2_FUNC048_SRC = $(SH2_3D_DIR)/func_048_bounds_handler_short.asm
SH2_FUNC048_LDS = $(SH2_3D_DIR)/func_048.lds
SH2_FUNC048_BIN = $(BUILD_DIR)/sh2/func_048.bin
SH2_FUNC048_INC = $(SH2_GEN_DIR)/func_048.inc

SH2_FUNC049_SRC = $(SH2_3D_DIR)/func_049_bounds_entry_short.asm
SH2_FUNC049_LDS = $(SH2_3D_DIR)/func_049.lds
SH2_FUNC049_BIN = $(BUILD_DIR)/sh2/func_049.bin
SH2_FUNC049_INC = $(SH2_GEN_DIR)/func_049.inc

SH2_FUNC050_SRC = $(SH2_3D_DIR)/func_050_multi_bsr_short.asm
SH2_FUNC050_LDS = $(SH2_3D_DIR)/func_050.lds
SH2_FUNC050_BIN = $(BUILD_DIR)/sh2/func_050.bin
SH2_FUNC050_INC = $(SH2_GEN_DIR)/func_050.inc

SH2_FUNC051_SRC = $(SH2_3D_DIR)/func_051_offset_bsr_short.asm
SH2_FUNC051_LDS = $(SH2_3D_DIR)/func_051.lds
SH2_FUNC051_BIN = $(BUILD_DIR)/sh2/func_051.bin
SH2_FUNC051_INC = $(SH2_GEN_DIR)/func_051.inc

SH2_FUNC052_SRC = $(SH2_3D_DIR)/func_052_small_bsr_short.asm
SH2_FUNC052_LDS = $(SH2_3D_DIR)/func_052.lds
SH2_FUNC052_BIN = $(BUILD_DIR)/sh2/func_052.bin
SH2_FUNC052_INC = $(SH2_GEN_DIR)/func_052.inc

SH2_FUNC053_SRC = $(SH2_3D_DIR)/func_053_offset_small_short.asm
SH2_FUNC053_LDS = $(SH2_3D_DIR)/func_053.lds
SH2_FUNC053_BIN = $(BUILD_DIR)/sh2/func_053.bin
SH2_FUNC053_INC = $(SH2_GEN_DIR)/func_053.inc

SH2_FUNC054_SRC = $(SH2_3D_DIR)/func_054_conditional_bsr_short.asm
SH2_FUNC054_LDS = $(SH2_3D_DIR)/func_054.lds
SH2_FUNC054_BIN = $(BUILD_DIR)/sh2/func_054.bin
SH2_FUNC054_INC = $(SH2_GEN_DIR)/func_054.inc

SH2_FUNC055_SRC = $(SH2_3D_DIR)/func_055_unrolled_copy_short.asm
SH2_FUNC055_LDS = $(SH2_3D_DIR)/func_055.lds
SH2_FUNC055_BIN = $(BUILD_DIR)/sh2/func_055.bin
SH2_FUNC055_INC = $(SH2_GEN_DIR)/func_055.inc

# NOTE: func_056 removed - code at $023F2E is already covered by func_065

SH2_FUNC067_SRC = $(SH2_3D_DIR)/func_067_rle_entry_alt1_short.asm
SH2_FUNC067_LDS = $(SH2_3D_DIR)/func_067.lds
SH2_FUNC067_BIN = $(BUILD_DIR)/sh2/func_067.bin
SH2_FUNC067_INC = $(SH2_GEN_DIR)/func_067.inc

SH2_FUNC068_SRC = $(SH2_3D_DIR)/func_068_rle_entry_alt2_short.asm
SH2_FUNC068_LDS = $(SH2_3D_DIR)/func_068.lds
SH2_FUNC068_BIN = $(BUILD_DIR)/sh2/func_068.bin
SH2_FUNC068_INC = $(SH2_GEN_DIR)/func_068.inc

SH2_FUNC069_SRC = $(SH2_3D_DIR)/func_069_block_copy_stride_short.asm
SH2_FUNC069_LDS = $(SH2_3D_DIR)/func_069.lds
SH2_FUNC069_BIN = $(BUILD_DIR)/sh2/func_069.bin
SH2_FUNC069_INC = $(SH2_GEN_DIR)/func_069.inc

SH2_FUNC070_SRC = $(SH2_3D_DIR)/func_070_loop_dispatcher_short.asm
SH2_FUNC070_LDS = $(SH2_3D_DIR)/func_070.lds
SH2_FUNC070_BIN = $(BUILD_DIR)/sh2/func_070.bin
SH2_FUNC070_INC = $(SH2_GEN_DIR)/func_070.inc

SH2_FUNC071_SRC = $(SH2_3D_DIR)/func_071_context_setup_short.asm
SH2_FUNC071_LDS = $(SH2_3D_DIR)/func_071.lds
SH2_FUNC071_BIN = $(BUILD_DIR)/sh2/func_071.bin
SH2_FUNC071_INC = $(SH2_GEN_DIR)/func_071.inc

SH2_FUNC072_SRC = $(SH2_3D_DIR)/func_072_element_processor_short.asm
SH2_FUNC072_LDS = $(SH2_3D_DIR)/func_072.lds
SH2_FUNC072_BIN = $(BUILD_DIR)/sh2/func_072.bin
SH2_FUNC072_INC = $(SH2_GEN_DIR)/func_072.inc

SH2_FUNC073_SRC = $(SH2_3D_DIR)/func_073_negative_handler_short.asm
SH2_FUNC073_LDS = $(SH2_3D_DIR)/func_073.lds
SH2_FUNC073_BIN = $(BUILD_DIR)/sh2/func_073.bin
SH2_FUNC073_INC = $(SH2_GEN_DIR)/func_073.inc

SH2_FUNC074_SRC = $(SH2_3D_DIR)/func_074_block_copy_14_short.asm
SH2_FUNC074_LDS = $(SH2_3D_DIR)/func_074.lds
SH2_FUNC074_BIN = $(BUILD_DIR)/sh2/func_074.bin
SH2_FUNC074_INC = $(SH2_GEN_DIR)/func_074.inc

SH2_FUNC075_SRC = $(SH2_3D_DIR)/func_075_block_iterator_short.asm
SH2_FUNC075_LDS = $(SH2_3D_DIR)/func_075.lds
SH2_FUNC075_BIN = $(BUILD_DIR)/sh2/func_075.bin
SH2_FUNC075_INC = $(SH2_GEN_DIR)/func_075.inc

SH2_FUNC076_SRC = $(SH2_3D_DIR)/func_076_vdp_pixel_write_short.asm
SH2_FUNC076_LDS = $(SH2_3D_DIR)/func_076.lds
SH2_FUNC076_BIN = $(BUILD_DIR)/sh2/func_076.bin
SH2_FUNC076_INC = $(SH2_GEN_DIR)/func_076.inc

SH2_FUNC077_SRC = $(SH2_3D_DIR)/func_077_value_dispatch_short.asm
SH2_FUNC077_LDS = $(SH2_3D_DIR)/func_077.lds
SH2_FUNC077_BIN = $(BUILD_DIR)/sh2/func_077.bin
SH2_FUNC077_INC = $(SH2_GEN_DIR)/func_077.inc

SH2_FUNC078_SRC = $(SH2_3D_DIR)/func_078_negative_fill_short.asm
SH2_FUNC078_LDS = $(SH2_3D_DIR)/func_078.lds
SH2_FUNC078_BIN = $(BUILD_DIR)/sh2/func_078.bin
SH2_FUNC078_INC = $(SH2_GEN_DIR)/func_078.inc

SH2_FUNC079_SRC = $(SH2_3D_DIR)/func_079_fill_decrement_short.asm
SH2_FUNC079_LDS = $(SH2_3D_DIR)/func_079.lds
SH2_FUNC079_BIN = $(BUILD_DIR)/sh2/func_079.bin
SH2_FUNC079_INC = $(SH2_GEN_DIR)/func_079.inc

SH2_FUNC080_SRC = $(SH2_3D_DIR)/func_080_memory_clear_short.asm
SH2_FUNC080_LDS = $(SH2_3D_DIR)/func_080.lds
SH2_FUNC080_BIN = $(BUILD_DIR)/sh2/func_080.bin
SH2_FUNC080_INC = $(SH2_GEN_DIR)/func_080.inc

SH2_FUNC081_SRC = $(SH2_3D_DIR)/func_081_multi_jsr_short.asm
SH2_FUNC081_LDS = $(SH2_3D_DIR)/func_081.lds
SH2_FUNC081_BIN = $(BUILD_DIR)/sh2/func_081.bin
SH2_FUNC081_INC = $(SH2_GEN_DIR)/func_081.inc

SH2_FUNC082_SRC = $(SH2_3D_DIR)/func_082_multi_jsr_alt_short.asm
SH2_FUNC082_LDS = $(SH2_3D_DIR)/func_082.lds
SH2_FUNC082_BIN = $(BUILD_DIR)/sh2/func_082.bin
SH2_FUNC082_INC = $(SH2_GEN_DIR)/func_082.inc

SH2_FUNC083_SRC = $(SH2_3D_DIR)/func_083_poll_wait_short.asm
SH2_FUNC083_LDS = $(SH2_3D_DIR)/func_083.lds
SH2_FUNC083_BIN = $(BUILD_DIR)/sh2/func_083.bin
SH2_FUNC083_INC = $(SH2_GEN_DIR)/func_083.inc

SH2_FUNC084_SRC = $(SH2_3D_DIR)/func_084_hw_init_short.asm
SH2_FUNC084_LDS = $(SH2_3D_DIR)/func_084.lds
SH2_FUNC084_BIN = $(BUILD_DIR)/sh2/func_084.bin
SH2_FUNC084_INC = $(SH2_GEN_DIR)/func_084.inc

SH2_FUNC085_SRC = $(SH2_3D_DIR)/func_085_poll_zero_short.asm
SH2_FUNC085_LDS = $(SH2_3D_DIR)/func_085.lds
SH2_FUNC085_BIN = $(BUILD_DIR)/sh2/func_085.bin
SH2_FUNC085_INC = $(SH2_GEN_DIR)/func_085.inc

SH2_FUNC086_SRC = $(SH2_3D_DIR)/func_086_clear_reg_short.asm
SH2_FUNC086_LDS = $(SH2_3D_DIR)/func_086.lds
SH2_FUNC086_BIN = $(BUILD_DIR)/sh2/func_086.bin
SH2_FUNC086_INC = $(SH2_GEN_DIR)/func_086.inc

SH2_FUNC087_SRC = $(SH2_3D_DIR)/func_087_poll_zero_alt_short.asm
SH2_FUNC087_LDS = $(SH2_3D_DIR)/func_087.lds
SH2_FUNC087_BIN = $(BUILD_DIR)/sh2/func_087.bin
SH2_FUNC087_INC = $(SH2_GEN_DIR)/func_087.inc

SH2_FUNC088_SRC = $(SH2_3D_DIR)/func_088_struct_init_short.asm
SH2_FUNC088_LDS = $(SH2_3D_DIR)/func_088.lds
SH2_FUNC088_BIN = $(BUILD_DIR)/sh2/func_088.bin
SH2_FUNC088_INC = $(SH2_GEN_DIR)/func_088.inc

SH2_FUNC089_SRC = $(SH2_3D_DIR)/func_089_poll_branch_short.asm
SH2_FUNC089_LDS = $(SH2_3D_DIR)/func_089.lds
SH2_FUNC089_BIN = $(BUILD_DIR)/sh2/func_089.bin
SH2_FUNC089_INC = $(SH2_GEN_DIR)/func_089.inc

SH2_FUNC090_SRC = $(SH2_3D_DIR)/func_090_poll_wait_short.asm
SH2_FUNC090_LDS = $(SH2_3D_DIR)/func_090.lds
SH2_FUNC090_BIN = $(BUILD_DIR)/sh2/func_090.bin
SH2_FUNC090_INC = $(SH2_GEN_DIR)/func_090.inc

SH2_FUNC091_SRC = $(SH2_3D_DIR)/func_091_poll_copy_short.asm
SH2_FUNC091_LDS = $(SH2_3D_DIR)/func_091.lds
SH2_FUNC091_BIN = $(BUILD_DIR)/sh2/func_091.bin
SH2_FUNC091_INC = $(SH2_GEN_DIR)/func_091.inc

SH2_FUNC005_SRC = $(SH2_3D_DIR)/func_005_transform_loop.asm
SH2_FUNC005_LDS = $(SH2_3D_DIR)/func_005.lds
SH2_FUNC005_BIN = $(BUILD_DIR)/sh2/func_005.bin
SH2_FUNC005_INC = $(SH2_GEN_DIR)/func_005.inc

SH2_FUNC007_SRC = $(SH2_3D_DIR)/func_007_alt_transform_loop.asm
SH2_FUNC007_LDS = $(SH2_3D_DIR)/func_007.lds
SH2_FUNC007_BIN = $(BUILD_DIR)/sh2/func_007.bin
SH2_FUNC007_INC = $(SH2_GEN_DIR)/func_007.inc

SH2_FUNC006_SRC = $(SH2_3D_DIR)/func_006_matrix_multiply.asm
SH2_FUNC006_BIN = $(BUILD_DIR)/sh2/func_006.bin
SH2_FUNC006_INC = $(SH2_GEN_DIR)/func_006.inc

SH2_FUNC008_SRC = $(SH2_3D_DIR)/func_008_alt_matrix_multiply.asm
SH2_FUNC008_BIN = $(BUILD_DIR)/sh2/func_008.bin
SH2_FUNC008_INC = $(SH2_GEN_DIR)/func_008.inc

SH2_FUNC016_SRC = $(SH2_3D_DIR)/func_016_coord_transform.asm
SH2_FUNC016_BIN = $(BUILD_DIR)/sh2/func_016.bin
SH2_FUNC016_INC = $(SH2_GEN_DIR)/func_016.inc

SH2_FUNC009_SRC = $(SH2_3D_DIR)/func_009_display_list_4elem.asm
SH2_FUNC009_BIN = $(BUILD_DIR)/sh2/func_009.bin
SH2_FUNC009_INC = $(SH2_GEN_DIR)/func_009.inc

SH2_FUNC010_SRC = $(SH2_3D_DIR)/func_010_display_list_3elem.asm
SH2_FUNC010_BIN = $(BUILD_DIR)/sh2/func_010.bin
SH2_FUNC010_INC = $(SH2_GEN_DIR)/func_010.inc

SH2_FUNC065_SRC = $(SH2_3D_DIR)/func_065_unrolled_data_copy.asm
SH2_FUNC065_BIN = $(BUILD_DIR)/sh2/func_065.bin
SH2_FUNC065_INC = $(SH2_GEN_DIR)/func_065.inc

SH2_FUNC066_SRC = $(SH2_3D_DIR)/func_066_rle_decoder.asm
SH2_FUNC066_BIN = $(BUILD_DIR)/sh2/func_066.bin
SH2_FUNC066_INC = $(SH2_GEN_DIR)/func_066.inc

# Expansion ROM functions (for Slave offloading)
SH2_EXP_DIR = $(SH2_SRC_DIR)/expansion
SH2_FUNC021_OPT_SRC = $(SH2_EXP_DIR)/func_021_optimized.asm
SH2_FUNC021_OPT_BIN = $(BUILD_DIR)/sh2/func_021_optimized.bin
SH2_FUNC021_OPT_INC = $(SH2_GEN_DIR)/func_021_optimized.inc

# Batch copy handler (optimization for cmd $26)
SH2_BATCH_COPY_SRC = $(SH2_SRC_DIR)/batch_copy_handler.asm
SH2_BATCH_COPY_BIN = $(BUILD_DIR)/sh2/batch_copy_handler.bin
SH2_BATCH_COPY_INC = $(SH2_GEN_DIR)/batch_copy_handler.inc

# cmd27 queue drain (async queue processor)
SH2_CMD27_DRAIN_SRC = $(SH2_EXP_DIR)/cmd27_queue_drain.asm
SH2_CMD27_DRAIN_BIN = $(BUILD_DIR)/sh2/cmd27_queue_drain.bin
SH2_CMD27_DRAIN_INC = $(SH2_GEN_DIR)/cmd27_queue_drain.inc

# slave_work_wrapper_v2 (with queue support)
SH2_SLAVE_WRAPPER_V2_SRC = $(SH2_EXP_DIR)/slave_work_wrapper_v2.asm
SH2_SLAVE_WRAPPER_V2_BIN = $(BUILD_DIR)/sh2/slave_work_wrapper_v2.bin
SH2_SLAVE_WRAPPER_V2_INC = $(SH2_GEN_DIR)/slave_work_wrapper_v2.inc

# handler_frame_sync (expansion ROM frame sync handler)
SH2_HANDLER_FRAME_SYNC_SRC = $(SH2_EXP_DIR)/handler_frame_sync.asm
SH2_HANDLER_FRAME_SYNC_LDS = $(SH2_EXP_DIR)/handler_frame_sync.lds
SH2_HANDLER_FRAME_SYNC_BIN = $(BUILD_DIR)/sh2/handler_frame_sync.bin
SH2_HANDLER_FRAME_SYNC_INC = $(SH2_GEN_DIR)/handler_frame_sync.inc

# master_dispatch_hook (expansion ROM command dispatcher)
SH2_MASTER_DISPATCH_HOOK_SRC = $(SH2_EXP_DIR)/master_dispatch_hook.asm
SH2_MASTER_DISPATCH_HOOK_LDS = $(SH2_EXP_DIR)/master_dispatch_hook.lds
SH2_MASTER_DISPATCH_HOOK_BIN = $(BUILD_DIR)/sh2/master_dispatch_hook.bin
SH2_MASTER_DISPATCH_HOOK_INC = $(SH2_GEN_DIR)/master_dispatch_hook.inc

# slave_test_func (expansion ROM parameter loader)
SH2_SLAVE_TEST_FUNC_SRC = $(SH2_EXP_DIR)/slave_test_func.asm
SH2_SLAVE_TEST_FUNC_LDS = $(SH2_EXP_DIR)/slave_test_func.lds
SH2_SLAVE_TEST_FUNC_BIN = $(BUILD_DIR)/sh2/slave_test_func.bin
SH2_SLAVE_TEST_FUNC_INC = $(SH2_GEN_DIR)/slave_test_func.inc

# shadow_path_wrapper (expansion ROM instrumentation wrapper)
SH2_SHADOW_PATH_WRAPPER_SRC = $(SH2_EXP_DIR)/shadow_path_wrapper.asm
SH2_SHADOW_PATH_WRAPPER_LDS = $(SH2_EXP_DIR)/shadow_path_wrapper.lds
SH2_SHADOW_PATH_WRAPPER_BIN = $(BUILD_DIR)/sh2/shadow_path_wrapper.bin
SH2_SHADOW_PATH_WRAPPER_INC = $(SH2_GEN_DIR)/shadow_path_wrapper.inc

# cmdint_handler (Phase 1 - CMDINT interrupt handler)
SH2_CMDINT_HANDLER_SRC = $(SH2_EXP_DIR)/cmdint_handler.asm
SH2_CMDINT_HANDLER_LDS = $(SH2_EXP_DIR)/cmdint_handler.lds
SH2_CMDINT_HANDLER_BIN = $(BUILD_DIR)/sh2/cmdint_handler.bin
SH2_CMDINT_HANDLER_INC = $(SH2_GEN_DIR)/cmdint_handler.inc

# queue_processor (Phase 1 - Ring buffer command processor)
SH2_QUEUE_PROCESSOR_SRC = $(SH2_EXP_DIR)/queue_processor.asm
SH2_QUEUE_PROCESSOR_LDS = $(SH2_EXP_DIR)/queue_processor.lds
SH2_QUEUE_PROCESSOR_BIN = $(BUILD_DIR)/sh2/queue_processor.bin
SH2_QUEUE_PROCESSOR_INC = $(SH2_GEN_DIR)/queue_processor.inc

.PHONY: sh2-assembly sh2-verify

# Build all SH2 assembly sources
sh2-assembly: dirs $(SH2_FUNC000_INC) $(SH2_FUNC022_INC) $(SH2_FUNC017_INC) $(SH2_FUNC018_INC) $(SH2_FUNC019_INC) $(SH2_FUNC020_INC) $(SH2_FUNC021_ORIG_INC) $(SH2_FUNC023_INC) $(SH2_FUNC040_INC) $(SH2_FUNC040_CASES_INC) $(SH2_FUNC040_UTIL_INC) $(SH2_FUNC041_INC) $(SH2_FUNC042_INC) $(SH2_FUNC043_INC) $(SH2_FUNC044_INC) $(SH2_FUNC045_INC) $(SH2_FUNC046_INC) $(SH2_FUNC047_INC) $(SH2_FUNC048_INC) $(SH2_FUNC049_INC) $(SH2_FUNC050_INC) $(SH2_FUNC051_INC) $(SH2_FUNC052_INC) $(SH2_FUNC053_INC) $(SH2_FUNC054_INC) $(SH2_FUNC055_INC) $(SH2_FUNC067_INC) $(SH2_FUNC068_INC) $(SH2_FUNC069_INC) $(SH2_FUNC070_INC) $(SH2_FUNC071_INC) $(SH2_FUNC072_INC) $(SH2_FUNC073_INC) $(SH2_FUNC074_INC) $(SH2_FUNC075_INC) $(SH2_FUNC076_INC) $(SH2_FUNC077_INC) $(SH2_FUNC078_INC) $(SH2_FUNC079_INC) $(SH2_FUNC080_INC) $(SH2_FUNC081_INC) $(SH2_FUNC082_INC) $(SH2_FUNC083_INC) $(SH2_FUNC084_INC) $(SH2_FUNC085_INC) $(SH2_FUNC086_INC) $(SH2_FUNC087_INC) $(SH2_FUNC088_INC) $(SH2_FUNC089_INC) $(SH2_FUNC090_INC) $(SH2_FUNC091_INC) $(SH2_FUNC032_INC) $(SH2_FUNC011_INC) $(SH2_FUNC012_INC) $(SH2_FUNC013_INC) $(SH2_FUNC014_015_INC) $(SH2_FUNC024_INC) $(SH2_FUNC025_INC) $(SH2_FUNC026_INC) $(SH2_FUNC003_004_INC) $(SH2_FUNC029_030_031_INC) $(SH2_FUNC033_INC) $(SH2_FUNC034_INC) $(SH2_FUNC036_INC) $(SH2_FUNC037_038_039_INC) $(SH2_FUNC005_INC) $(SH2_FUNC007_INC) $(SH2_FUNC006_INC) $(SH2_FUNC008_INC) $(SH2_FUNC016_INC) $(SH2_FUNC009_INC) $(SH2_FUNC010_INC) $(SH2_FUNC065_INC) $(SH2_FUNC066_INC) $(SH2_FUNC021_OPT_INC) $(SH2_BATCH_COPY_INC) $(SH2_CMD27_DRAIN_INC) $(SH2_SLAVE_WRAPPER_V2_INC) $(SH2_HANDLER_FRAME_SYNC_INC) $(SH2_MASTER_DISPATCH_HOOK_INC) $(SH2_SLAVE_TEST_FUNC_INC) $(SH2_SHADOW_PATH_WRAPPER_INC) $(SH2_CMDINT_HANDLER_INC) $(SH2_QUEUE_PROCESSOR_INC)

# Build func_000 binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC000_BIN): $(SH2_FUNC000_SRC) $(SH2_FUNC000_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_000 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_000.o $<
	$(SH2_LD) -T $(SH2_FUNC000_LDS) -o $(BUILD_DIR)/sh2/func_000.elf $(BUILD_DIR)/sh2/func_000.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_000.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 26)"

$(SH2_FUNC000_INC): $(SH2_FUNC000_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_000.inc..."
	@echo "; Auto-generated from $(SH2_FUNC000_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_022 binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC022_BIN): $(SH2_FUNC022_SRC) $(SH2_FUNC022_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_022 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_022.o $<
	$(SH2_LD) -T $(SH2_FUNC022_LDS) -o $(BUILD_DIR)/sh2/func_022.elf $(BUILD_DIR)/sh2/func_022.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_022.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 26)"

$(SH2_FUNC022_INC): $(SH2_FUNC022_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_022.inc..."
	@echo "; Auto-generated from $(SH2_FUNC022_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_017 binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC017_BIN): $(SH2_FUNC017_SRC) $(SH2_FUNC017_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_017 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_017.o $<
	$(SH2_LD) -T $(SH2_FUNC017_LDS) -o $(BUILD_DIR)/sh2/func_017.elf $(BUILD_DIR)/sh2/func_017.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_017.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 26)"

$(SH2_FUNC017_INC): $(SH2_FUNC017_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_017.inc..."
	@echo "; Auto-generated from $(SH2_FUNC017_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_032 binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC032_BIN): $(SH2_FUNC032_SRC) $(SH2_FUNC032_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_032 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_032.o $<
	$(SH2_LD) -T $(SH2_FUNC032_LDS) -o $(BUILD_DIR)/sh2/func_032.elf $(BUILD_DIR)/sh2/func_032.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_032.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 32)"

$(SH2_FUNC032_INC): $(SH2_FUNC032_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_032.inc..."
	@echo "; Auto-generated from $(SH2_FUNC032_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_011 binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC011_BIN): $(SH2_FUNC011_SRC) $(SH2_FUNC011_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_011 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_011.o $<
	$(SH2_LD) -T $(SH2_FUNC011_LDS) -o $(BUILD_DIR)/sh2/func_011.elf $(BUILD_DIR)/sh2/func_011.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_011.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 84)"

$(SH2_FUNC011_INC): $(SH2_FUNC011_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_011.inc..."
	@echo "; Auto-generated from $(SH2_FUNC011_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_012 binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC012_BIN): $(SH2_FUNC012_SRC) $(SH2_FUNC012_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_012 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_012.o $<
	$(SH2_LD) -T $(SH2_FUNC012_LDS) -o $(BUILD_DIR)/sh2/func_012.elf $(BUILD_DIR)/sh2/func_012.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_012.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 92)"

$(SH2_FUNC012_INC): $(SH2_FUNC012_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_012.inc..."
	@echo "; Auto-generated from $(SH2_FUNC012_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_013 binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC013_BIN): $(SH2_FUNC013_SRC) $(SH2_FUNC013_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_013 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_013.o $<
	$(SH2_LD) -T $(SH2_FUNC013_LDS) -o $(BUILD_DIR)/sh2/func_013.elf $(BUILD_DIR)/sh2/func_013.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_013.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 92)"

$(SH2_FUNC013_INC): $(SH2_FUNC013_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_013.inc..."
	@echo "; Auto-generated from $(SH2_FUNC013_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_014_015 binary from source (requires linker script for PC-relative addressing)
# VDP data copy utilities (56 bytes)
$(SH2_FUNC014_015_BIN): $(SH2_FUNC014_015_SRC) $(SH2_FUNC014_015_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_014_015 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_014_015.o $<
	$(SH2_LD) -T $(SH2_FUNC014_015_LDS) -o $(BUILD_DIR)/sh2/func_014_015.elf $(BUILD_DIR)/sh2/func_014_015.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_014_015.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 56)"

$(SH2_FUNC014_015_INC): $(SH2_FUNC014_015_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_014_015.inc..."
	@echo "; Auto-generated from $(SH2_FUNC014_015_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_024 binary from source (requires linker script for PC-relative addressing)
# Screen coordinate calculator (62 bytes)
$(SH2_FUNC024_BIN): $(SH2_FUNC024_SRC) $(SH2_FUNC024_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_024 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_024.o $<
	$(SH2_LD) -T $(SH2_FUNC024_LDS) -o $(BUILD_DIR)/sh2/func_024.elf $(BUILD_DIR)/sh2/func_024.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_024.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 62)"

$(SH2_FUNC024_INC): $(SH2_FUNC024_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_024.inc..."
	@echo "; Auto-generated from $(SH2_FUNC024_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_025 binary from source (requires linker script for PC-relative addressing)
# Coordinate offset calculator (16 bytes)
$(SH2_FUNC025_BIN): $(SH2_FUNC025_SRC) $(SH2_FUNC025_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_025 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_025.o $<
	$(SH2_LD) -T $(SH2_FUNC025_LDS) -o $(BUILD_DIR)/sh2/func_025.elf $(BUILD_DIR)/sh2/func_025.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_025.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 16)"

$(SH2_FUNC025_INC): $(SH2_FUNC025_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_025.inc..."
	@echo "; Auto-generated from $(SH2_FUNC025_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_026 binary from source (requires linker script for PC-relative addressing)
# Includes func_027 and func_028 (shared exit paths)
$(SH2_FUNC026_BIN): $(SH2_FUNC026_SRC) $(SH2_FUNC026_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_026 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_026.o $<
	$(SH2_LD) -T $(SH2_FUNC026_LDS) -o $(BUILD_DIR)/sh2/func_026.elf $(BUILD_DIR)/sh2/func_026.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_026.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 68)"

$(SH2_FUNC026_INC): $(SH2_FUNC026_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_026.inc..."
	@echo "; Auto-generated from $(SH2_FUNC026_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_003_004 binary from source (requires linker script for PC-relative addressing)
# Includes func_002 exit paths, func_003, and func_004
$(SH2_FUNC003_004_BIN): $(SH2_FUNC003_004_SRC) $(SH2_FUNC003_004_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_003_004 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_003_004.o $<
	$(SH2_LD) -T $(SH2_FUNC003_004_LDS) -o $(BUILD_DIR)/sh2/func_003_004.elf $(BUILD_DIR)/sh2/func_003_004.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_003_004.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 32)"

$(SH2_FUNC003_004_INC): $(SH2_FUNC003_004_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_003_004.inc..."
	@echo "; Auto-generated from $(SH2_FUNC003_004_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_029_030_031 binary from source (requires linker script for PC-relative addressing)
# Includes func_029 (visibility), func_030 and func_031 (shared exit paths)
$(SH2_FUNC029_030_031_BIN): $(SH2_FUNC029_030_031_SRC) $(SH2_FUNC029_030_031_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_029_030_031 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_029_030_031.o $<
	$(SH2_LD) -T $(SH2_FUNC029_030_031_LDS) -o $(BUILD_DIR)/sh2/func_029_030_031.elf $(BUILD_DIR)/sh2/func_029_030_031.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_029_030_031.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 82)"

$(SH2_FUNC029_030_031_INC): $(SH2_FUNC029_030_031_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_029_030_031.inc..."
	@echo "; Auto-generated from $(SH2_FUNC029_030_031_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_033 binary from source (requires linker script for PC-relative addressing)
# Quad rendering / edge walking (98 bytes)
$(SH2_FUNC033_BIN): $(SH2_FUNC033_SRC) $(SH2_FUNC033_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_033 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_033.o $<
	$(SH2_LD) -T $(SH2_FUNC033_LDS) -o $(BUILD_DIR)/sh2/func_033.elf $(BUILD_DIR)/sh2/func_033.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_033.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 98)"

$(SH2_FUNC033_INC): $(SH2_FUNC033_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_033.inc..."
	@echo "; Auto-generated from $(SH2_FUNC033_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_034 binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC034_BIN): $(SH2_FUNC034_SRC) $(SH2_FUNC034_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_034 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_034.o $<
	$(SH2_LD) -T $(SH2_FUNC034_LDS) -o $(BUILD_DIR)/sh2/func_034.elf $(BUILD_DIR)/sh2/func_034.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_034.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 122)"

$(SH2_FUNC034_INC): $(SH2_FUNC034_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_034.inc..."
	@echo "; Auto-generated from $(SH2_FUNC034_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_036 binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC036_BIN): $(SH2_FUNC036_SRC) $(SH2_FUNC036_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_036 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_036.o $<
	$(SH2_LD) -T $(SH2_FUNC036_LDS) -o $(BUILD_DIR)/sh2/func_036.elf $(BUILD_DIR)/sh2/func_036.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_036.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 72)"

$(SH2_FUNC036_INC): $(SH2_FUNC036_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_036.inc..."
	@echo "; Auto-generated from $(SH2_FUNC036_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_037_038_039 binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC037_038_039_BIN): $(SH2_FUNC037_038_039_SRC) $(SH2_FUNC037_038_039_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_037_038_039 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_037_038_039.o $<
	$(SH2_LD) -T $(SH2_FUNC037_038_039_LDS) -o $(BUILD_DIR)/sh2/func_037_038_039.elf $(BUILD_DIR)/sh2/func_037_038_039.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_037_038_039.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 64)"

$(SH2_FUNC037_038_039_INC): $(SH2_FUNC037_038_039_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_037_038_039.inc..."
	@echo "; Auto-generated from $(SH2_FUNC037_038_039_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_018 binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC018_BIN): $(SH2_FUNC018_SRC) $(SH2_FUNC018_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_018 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_018.o $<
	$(SH2_LD) -T $(SH2_FUNC018_LDS) -o $(BUILD_DIR)/sh2/func_018.elf $(BUILD_DIR)/sh2/func_018.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_018.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 112)"

$(SH2_FUNC018_INC): $(SH2_FUNC018_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_018.inc..."
	@echo "; Auto-generated from $(SH2_FUNC018_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_019 binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC019_BIN): $(SH2_FUNC019_SRC) $(SH2_FUNC019_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_019 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_019.o $<
	$(SH2_LD) -T $(SH2_FUNC019_LDS) -o $(BUILD_DIR)/sh2/func_019.elf $(BUILD_DIR)/sh2/func_019.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_019.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 140)"

$(SH2_FUNC019_INC): $(SH2_FUNC019_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_019.inc..."
	@echo "; Auto-generated from $(SH2_FUNC019_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_020 binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC020_BIN): $(SH2_FUNC020_SRC) $(SH2_FUNC020_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_020 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_020.o $<
	$(SH2_LD) -T $(SH2_FUNC020_LDS) -o $(BUILD_DIR)/sh2/func_020.elf $(BUILD_DIR)/sh2/func_020.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_020.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 40)"

$(SH2_FUNC020_INC): $(SH2_FUNC020_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_020.inc..."
	@echo "; Auto-generated from $(SH2_FUNC020_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_021_orig binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC021_ORIG_BIN): $(SH2_FUNC021_ORIG_SRC) $(SH2_FUNC021_ORIG_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_021_orig (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_021_orig.o $<
	$(SH2_LD) -T $(SH2_FUNC021_ORIG_LDS) -o $(BUILD_DIR)/sh2/func_021_orig.elf $(BUILD_DIR)/sh2/func_021_orig.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_021_orig.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 38)"

$(SH2_FUNC021_ORIG_INC): $(SH2_FUNC021_ORIG_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_021_orig.inc..."
	@echo "; Auto-generated from $(SH2_FUNC021_ORIG_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_023 binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC023_BIN): $(SH2_FUNC023_SRC) $(SH2_FUNC023_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_023 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_023.o $<
	$(SH2_LD) -T $(SH2_FUNC023_LDS) -o $(BUILD_DIR)/sh2/func_023.elf $(BUILD_DIR)/sh2/func_023.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_023.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 238)"

$(SH2_FUNC023_INC): $(SH2_FUNC023_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_023.inc..."
	@echo "; Auto-generated from $(SH2_FUNC023_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_040 binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC040_BIN): $(SH2_FUNC040_SRC) $(SH2_FUNC040_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_040 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_040.o $<
	$(SH2_LD) -T $(SH2_FUNC040_LDS) -o $(BUILD_DIR)/sh2/func_040.elf $(BUILD_DIR)/sh2/func_040.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_040.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 122)"

$(SH2_FUNC040_INC): $(SH2_FUNC040_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_040.inc..."
	@echo "; Auto-generated from $(SH2_FUNC040_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_040_cases binary from source (requires linker script)
$(SH2_FUNC040_CASES_BIN): $(SH2_FUNC040_CASES_SRC) $(SH2_FUNC040_CASES_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_040_cases (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_040_cases.o $<
	$(SH2_LD) -T $(SH2_FUNC040_CASES_LDS) -o $(BUILD_DIR)/sh2/func_040_cases.elf $(BUILD_DIR)/sh2/func_040_cases.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_040_cases.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 212)"

$(SH2_FUNC040_CASES_INC): $(SH2_FUNC040_CASES_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_040_cases.inc..."
	@echo "; Auto-generated from $(SH2_FUNC040_CASES_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_040_utility binary from source (requires linker script)
$(SH2_FUNC040_UTIL_BIN): $(SH2_FUNC040_UTIL_SRC) $(SH2_FUNC040_UTIL_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_040_utility (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_040_utility.o $<
	$(SH2_LD) -T $(SH2_FUNC040_UTIL_LDS) -o $(BUILD_DIR)/sh2/func_040_utility.elf $(BUILD_DIR)/sh2/func_040_utility.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_040_utility.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 28)"

$(SH2_FUNC040_UTIL_INC): $(SH2_FUNC040_UTIL_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_040_utility.inc..."
	@echo "; Auto-generated from $(SH2_FUNC040_UTIL_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_041 binary from source (requires linker script)
$(SH2_FUNC041_BIN): $(SH2_FUNC041_SRC) $(SH2_FUNC041_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_041 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_041.o $<
	$(SH2_LD) -T $(SH2_FUNC041_LDS) -o $(BUILD_DIR)/sh2/func_041.elf $(BUILD_DIR)/sh2/func_041.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_041.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 98)"

$(SH2_FUNC041_INC): $(SH2_FUNC041_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_041.inc..."
	@echo "; Auto-generated from $(SH2_FUNC041_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_042 binary from source (requires linker script)
$(SH2_FUNC042_BIN): $(SH2_FUNC042_SRC) $(SH2_FUNC042_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_042 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_042.o $<
	$(SH2_LD) -T $(SH2_FUNC042_LDS) -o $(BUILD_DIR)/sh2/func_042.elf $(BUILD_DIR)/sh2/func_042.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_042.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 20)"

$(SH2_FUNC042_INC): $(SH2_FUNC042_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_042.inc..."
	@echo "; Auto-generated from $(SH2_FUNC042_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_043 binary from source (requires linker script)
$(SH2_FUNC043_BIN): $(SH2_FUNC043_SRC) $(SH2_FUNC043_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_043 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_043.o $<
	$(SH2_LD) -T $(SH2_FUNC043_LDS) -o $(BUILD_DIR)/sh2/func_043.elf $(BUILD_DIR)/sh2/func_043.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_043.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 312)"

$(SH2_FUNC043_INC): $(SH2_FUNC043_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_043.inc..."
	@echo "; Auto-generated from $(SH2_FUNC043_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_044 binary from source (requires linker script)
$(SH2_FUNC044_BIN): $(SH2_FUNC044_SRC) $(SH2_FUNC044_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_044 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_044.o $<
	$(SH2_LD) -T $(SH2_FUNC044_LDS) -o $(BUILD_DIR)/sh2/func_044.elf $(BUILD_DIR)/sh2/func_044.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_044.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 268)"

$(SH2_FUNC044_INC): $(SH2_FUNC044_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_044.inc..."
	@echo "; Auto-generated from $(SH2_FUNC044_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_045 binary from source (requires linker script)
$(SH2_FUNC045_BIN): $(SH2_FUNC045_SRC) $(SH2_FUNC045_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_045 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_045.o $<
	$(SH2_LD) -T $(SH2_FUNC045_LDS) -o $(BUILD_DIR)/sh2/func_045.elf $(BUILD_DIR)/sh2/func_045.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_045.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 68)"

$(SH2_FUNC045_INC): $(SH2_FUNC045_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_045.inc..."
	@echo "; Auto-generated from $(SH2_FUNC045_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_046 binary from source (requires linker script)
$(SH2_FUNC046_BIN): $(SH2_FUNC046_SRC) $(SH2_FUNC046_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_046 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_046.o $<
	$(SH2_LD) -T $(SH2_FUNC046_LDS) -o $(BUILD_DIR)/sh2/func_046.elf $(BUILD_DIR)/sh2/func_046.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_046.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 36)"

$(SH2_FUNC046_INC): $(SH2_FUNC046_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_046.inc..."
	@echo "; Auto-generated from $(SH2_FUNC046_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_047 binary from source (requires linker script)
$(SH2_FUNC047_BIN): $(SH2_FUNC047_SRC) $(SH2_FUNC047_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_047 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_047.o $<
	$(SH2_LD) -T $(SH2_FUNC047_LDS) -o $(BUILD_DIR)/sh2/func_047.elf $(BUILD_DIR)/sh2/func_047.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_047.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 26)"

$(SH2_FUNC047_INC): $(SH2_FUNC047_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_047.inc..."
	@echo "; Auto-generated from $(SH2_FUNC047_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_048 binary from source (requires linker script)
$(SH2_FUNC048_BIN): $(SH2_FUNC048_SRC) $(SH2_FUNC048_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_048 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_048.o $<
	$(SH2_LD) -T $(SH2_FUNC048_LDS) -o $(BUILD_DIR)/sh2/func_048.elf $(BUILD_DIR)/sh2/func_048.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_048.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 22)"

$(SH2_FUNC048_INC): $(SH2_FUNC048_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_048.inc..."
	@echo "; Auto-generated from $(SH2_FUNC048_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_049 binary from source (requires linker script)
$(SH2_FUNC049_BIN): $(SH2_FUNC049_SRC) $(SH2_FUNC049_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_049 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_049.o $<
	$(SH2_LD) -T $(SH2_FUNC049_LDS) -o $(BUILD_DIR)/sh2/func_049.elf $(BUILD_DIR)/sh2/func_049.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_049.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 26)"

$(SH2_FUNC049_INC): $(SH2_FUNC049_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_049.inc..."
	@echo "; Auto-generated from $(SH2_FUNC049_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_050 binary from source (requires linker script)
$(SH2_FUNC050_BIN): $(SH2_FUNC050_SRC) $(SH2_FUNC050_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_050 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_050.o $<
	$(SH2_LD) -T $(SH2_FUNC050_LDS) -o $(BUILD_DIR)/sh2/func_050.elf $(BUILD_DIR)/sh2/func_050.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_050.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 88)"

$(SH2_FUNC050_INC): $(SH2_FUNC050_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_050.inc..."
	@echo "; Auto-generated from $(SH2_FUNC050_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_051 binary from source (requires linker script)
$(SH2_FUNC051_BIN): $(SH2_FUNC051_SRC) $(SH2_FUNC051_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_051 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_051.o $<
	$(SH2_LD) -T $(SH2_FUNC051_LDS) -o $(BUILD_DIR)/sh2/func_051.elf $(BUILD_DIR)/sh2/func_051.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_051.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 92)"

$(SH2_FUNC051_INC): $(SH2_FUNC051_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_051.inc..."
	@echo "; Auto-generated from $(SH2_FUNC051_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_052 binary from source (requires linker script)
$(SH2_FUNC052_BIN): $(SH2_FUNC052_SRC) $(SH2_FUNC052_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_052 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_052.o $<
	$(SH2_LD) -T $(SH2_FUNC052_LDS) -o $(BUILD_DIR)/sh2/func_052.elf $(BUILD_DIR)/sh2/func_052.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_052.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 22)"

$(SH2_FUNC052_INC): $(SH2_FUNC052_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_052.inc..."
	@echo "; Auto-generated from $(SH2_FUNC052_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_053 binary from source (requires linker script)
$(SH2_FUNC053_BIN): $(SH2_FUNC053_SRC) $(SH2_FUNC053_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_053 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_053.o $<
	$(SH2_LD) -T $(SH2_FUNC053_LDS) -o $(BUILD_DIR)/sh2/func_053.elf $(BUILD_DIR)/sh2/func_053.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_053.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 38)"

$(SH2_FUNC053_INC): $(SH2_FUNC053_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_053.inc..."
	@echo "; Auto-generated from $(SH2_FUNC053_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_054 binary from source (requires linker script)
$(SH2_FUNC054_BIN): $(SH2_FUNC054_SRC) $(SH2_FUNC054_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_054 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_054.o $<
	$(SH2_LD) -T $(SH2_FUNC054_LDS) -o $(BUILD_DIR)/sh2/func_054.elf $(BUILD_DIR)/sh2/func_054.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_054.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 56)"

$(SH2_FUNC054_INC): $(SH2_FUNC054_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_054.inc..."
	@echo "; Auto-generated from $(SH2_FUNC054_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_055 binary from source (requires linker script)
$(SH2_FUNC055_BIN): $(SH2_FUNC055_SRC) $(SH2_FUNC055_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_055 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_055.o $<
	$(SH2_LD) -T $(SH2_FUNC055_LDS) -o $(BUILD_DIR)/sh2/func_055.elf $(BUILD_DIR)/sh2/func_055.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_055.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 92)"

$(SH2_FUNC055_INC): $(SH2_FUNC055_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_055.inc..."
	@echo "; Auto-generated from $(SH2_FUNC055_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_067 binary from source (requires linker script)
$(SH2_FUNC067_BIN): $(SH2_FUNC067_SRC) $(SH2_FUNC067_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_067 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_067.o $<
	$(SH2_LD) -T $(SH2_FUNC067_LDS) -o $(BUILD_DIR)/sh2/func_067.elf $(BUILD_DIR)/sh2/func_067.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_067.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 14)"

$(SH2_FUNC067_INC): $(SH2_FUNC067_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_067.inc..."
	@echo "; Auto-generated from $(SH2_FUNC067_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_068 binary from source (requires linker script)
$(SH2_FUNC068_BIN): $(SH2_FUNC068_SRC) $(SH2_FUNC068_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_068 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_068.o $<
	$(SH2_LD) -T $(SH2_FUNC068_LDS) -o $(BUILD_DIR)/sh2/func_068.elf $(BUILD_DIR)/sh2/func_068.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_068.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 12)"

$(SH2_FUNC068_INC): $(SH2_FUNC068_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_068.inc..."
	@echo "; Auto-generated from $(SH2_FUNC068_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_069 binary from source (requires linker script)
$(SH2_FUNC069_BIN): $(SH2_FUNC069_SRC) $(SH2_FUNC069_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_069 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_069.o $<
	$(SH2_LD) -T $(SH2_FUNC069_LDS) -o $(BUILD_DIR)/sh2/func_069.elf $(BUILD_DIR)/sh2/func_069.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_069.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 76)"

$(SH2_FUNC069_INC): $(SH2_FUNC069_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_069.inc..."
	@echo "; Auto-generated from $(SH2_FUNC069_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_070 binary from source (requires linker script)
$(SH2_FUNC070_BIN): $(SH2_FUNC070_SRC) $(SH2_FUNC070_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_070 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_070.o $<
	$(SH2_LD) -T $(SH2_FUNC070_LDS) -o $(BUILD_DIR)/sh2/func_070.elf $(BUILD_DIR)/sh2/func_070.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_070.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 36)"

$(SH2_FUNC070_INC): $(SH2_FUNC070_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_070.inc..."
	@echo "; Auto-generated from $(SH2_FUNC070_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_071 binary from source (requires linker script)
$(SH2_FUNC071_BIN): $(SH2_FUNC071_SRC) $(SH2_FUNC071_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_071 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_071.o $<
	$(SH2_LD) -T $(SH2_FUNC071_LDS) -o $(BUILD_DIR)/sh2/func_071.elf $(BUILD_DIR)/sh2/func_071.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_071.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 122)"

$(SH2_FUNC071_INC): $(SH2_FUNC071_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_071.inc..."
	@echo "; Auto-generated from $(SH2_FUNC071_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_072 binary from source (requires linker script)
$(SH2_FUNC072_BIN): $(SH2_FUNC072_SRC) $(SH2_FUNC072_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_072 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_072.o $<
	$(SH2_LD) -T $(SH2_FUNC072_LDS) -o $(BUILD_DIR)/sh2/func_072.elf $(BUILD_DIR)/sh2/func_072.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_072.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 42)"

$(SH2_FUNC072_INC): $(SH2_FUNC072_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_072.inc..."
	@echo "; Auto-generated from $(SH2_FUNC072_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_073 binary from source (requires linker script)
$(SH2_FUNC073_BIN): $(SH2_FUNC073_SRC) $(SH2_FUNC073_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_073 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_073.o $<
	$(SH2_LD) -T $(SH2_FUNC073_LDS) -o $(BUILD_DIR)/sh2/func_073.elf $(BUILD_DIR)/sh2/func_073.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_073.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 16)"

$(SH2_FUNC073_INC): $(SH2_FUNC073_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_073.inc..."
	@echo "; Auto-generated from $(SH2_FUNC073_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_074 binary from source (requires linker script)
$(SH2_FUNC074_BIN): $(SH2_FUNC074_SRC) $(SH2_FUNC074_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_074 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_074.o $<
	$(SH2_LD) -T $(SH2_FUNC074_LDS) -o $(BUILD_DIR)/sh2/func_074.elf $(BUILD_DIR)/sh2/func_074.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_074.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 30)"

$(SH2_FUNC074_INC): $(SH2_FUNC074_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_074.inc..."
	@echo "; Auto-generated from $(SH2_FUNC074_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_075 binary from source (requires linker script)
$(SH2_FUNC075_BIN): $(SH2_FUNC075_SRC) $(SH2_FUNC075_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_075 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_075.o $<
	$(SH2_LD) -T $(SH2_FUNC075_LDS) -o $(BUILD_DIR)/sh2/func_075.elf $(BUILD_DIR)/sh2/func_075.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_075.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 26)"

$(SH2_FUNC075_INC): $(SH2_FUNC075_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_075.inc..."
	@echo "; Auto-generated from $(SH2_FUNC075_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_076 binary from source (requires linker script)
$(SH2_FUNC076_BIN): $(SH2_FUNC076_SRC) $(SH2_FUNC076_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_076 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_076.o $<
	$(SH2_LD) -T $(SH2_FUNC076_LDS) -o $(BUILD_DIR)/sh2/func_076.elf $(BUILD_DIR)/sh2/func_076.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_076.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 76)"

$(SH2_FUNC076_INC): $(SH2_FUNC076_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_076.inc..."
	@echo "; Auto-generated from $(SH2_FUNC076_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_077 binary from source (requires linker script)
$(SH2_FUNC077_BIN): $(SH2_FUNC077_SRC) $(SH2_FUNC077_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_077 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_077.o $<
	$(SH2_LD) -T $(SH2_FUNC077_LDS) -o $(BUILD_DIR)/sh2/func_077.elf $(BUILD_DIR)/sh2/func_077.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_077.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 46)"

$(SH2_FUNC077_INC): $(SH2_FUNC077_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_077.inc..."
	@echo "; Auto-generated from $(SH2_FUNC077_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_078 binary from source (requires linker script)
$(SH2_FUNC078_BIN): $(SH2_FUNC078_SRC) $(SH2_FUNC078_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_078 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_078.o $<
	$(SH2_LD) -T $(SH2_FUNC078_LDS) -o $(BUILD_DIR)/sh2/func_078.elf $(BUILD_DIR)/sh2/func_078.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_078.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 40)"

$(SH2_FUNC078_INC): $(SH2_FUNC078_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_078.inc..."
	@echo "; Auto-generated from $(SH2_FUNC078_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_079 binary from source (requires linker script)
$(SH2_FUNC079_BIN): $(SH2_FUNC079_SRC) $(SH2_FUNC079_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_079 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_079.o $<
	$(SH2_LD) -T $(SH2_FUNC079_LDS) -o $(BUILD_DIR)/sh2/func_079.elf $(BUILD_DIR)/sh2/func_079.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_079.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 20)"

$(SH2_FUNC079_INC): $(SH2_FUNC079_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_079.inc..."
	@echo "; Auto-generated from $(SH2_FUNC079_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_080 binary from source (requires linker script)
$(SH2_FUNC080_BIN): $(SH2_FUNC080_SRC) $(SH2_FUNC080_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_080 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_080.o $<
	$(SH2_LD) -T $(SH2_FUNC080_LDS) -o $(BUILD_DIR)/sh2/func_080.elf $(BUILD_DIR)/sh2/func_080.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_080.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 34)"

$(SH2_FUNC080_INC): $(SH2_FUNC080_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_080.inc..."
	@echo "; Auto-generated from $(SH2_FUNC080_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_081 binary from source (requires linker script)
$(SH2_FUNC081_BIN): $(SH2_FUNC081_SRC) $(SH2_FUNC081_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_081 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_081.o $<
	$(SH2_LD) -T $(SH2_FUNC081_LDS) -o $(BUILD_DIR)/sh2/func_081.elf $(BUILD_DIR)/sh2/func_081.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_081.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 52)"

$(SH2_FUNC081_INC): $(SH2_FUNC081_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_081.inc..."
	@echo "; Auto-generated from $(SH2_FUNC081_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_082 binary from source (requires linker script)
$(SH2_FUNC082_BIN): $(SH2_FUNC082_SRC) $(SH2_FUNC082_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_082 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_082.o $<
	$(SH2_LD) -T $(SH2_FUNC082_LDS) -o $(BUILD_DIR)/sh2/func_082.elf $(BUILD_DIR)/sh2/func_082.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_082.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 50)"

$(SH2_FUNC082_INC): $(SH2_FUNC082_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_082.inc..."
	@echo "; Auto-generated from $(SH2_FUNC082_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_083 binary from source (requires linker script)
$(SH2_FUNC083_BIN): $(SH2_FUNC083_SRC) $(SH2_FUNC083_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_083 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_083.o $<
	$(SH2_LD) -T $(SH2_FUNC083_LDS) -o $(BUILD_DIR)/sh2/func_083.elf $(BUILD_DIR)/sh2/func_083.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_083.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 12)"

$(SH2_FUNC083_INC): $(SH2_FUNC083_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_083.inc..."
	@echo "; Auto-generated from $(SH2_FUNC083_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_084 binary from source (requires linker script)
$(SH2_FUNC084_BIN): $(SH2_FUNC084_SRC) $(SH2_FUNC084_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_084 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_084.o $<
	$(SH2_LD) -T $(SH2_FUNC084_LDS) -o $(BUILD_DIR)/sh2/func_084.elf $(BUILD_DIR)/sh2/func_084.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_084.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 28)"

$(SH2_FUNC084_INC): $(SH2_FUNC084_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_084.inc..."
	@echo "; Auto-generated from $(SH2_FUNC084_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_085 binary from source (requires linker script)
$(SH2_FUNC085_BIN): $(SH2_FUNC085_SRC) $(SH2_FUNC085_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_085 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_085.o $<
	$(SH2_LD) -T $(SH2_FUNC085_LDS) -o $(BUILD_DIR)/sh2/func_085.elf $(BUILD_DIR)/sh2/func_085.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_085.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 12)"

$(SH2_FUNC085_INC): $(SH2_FUNC085_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_085.inc..."
	@echo "; Auto-generated from $(SH2_FUNC085_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_086 binary from source (requires linker script)
$(SH2_FUNC086_BIN): $(SH2_FUNC086_SRC) $(SH2_FUNC086_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_086 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_086.o $<
	$(SH2_LD) -T $(SH2_FUNC086_LDS) -o $(BUILD_DIR)/sh2/func_086.elf $(BUILD_DIR)/sh2/func_086.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_086.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 8)"

$(SH2_FUNC086_INC): $(SH2_FUNC086_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_086.inc..."
	@echo "; Auto-generated from $(SH2_FUNC086_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_087 binary from source (requires linker script)
$(SH2_FUNC087_BIN): $(SH2_FUNC087_SRC) $(SH2_FUNC087_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_087 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_087.o $<
	$(SH2_LD) -T $(SH2_FUNC087_LDS) -o $(BUILD_DIR)/sh2/func_087.elf $(BUILD_DIR)/sh2/func_087.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_087.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 12)"

$(SH2_FUNC087_INC): $(SH2_FUNC087_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_087.inc..."
	@echo "; Auto-generated from $(SH2_FUNC087_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_088 binary from source (requires linker script)
$(SH2_FUNC088_BIN): $(SH2_FUNC088_SRC) $(SH2_FUNC088_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_088 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_088.o $<
	$(SH2_LD) -T $(SH2_FUNC088_LDS) -o $(BUILD_DIR)/sh2/func_088.elf $(BUILD_DIR)/sh2/func_088.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_088.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 34)"

$(SH2_FUNC088_INC): $(SH2_FUNC088_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_088.inc..."
	@echo "; Auto-generated from $(SH2_FUNC088_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_089 binary from source (requires linker script)
$(SH2_FUNC089_BIN): $(SH2_FUNC089_SRC) $(SH2_FUNC089_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_089 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_089.o $<
	$(SH2_LD) -T $(SH2_FUNC089_LDS) -o $(BUILD_DIR)/sh2/func_089.elf $(BUILD_DIR)/sh2/func_089.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_089.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 40)"

$(SH2_FUNC089_INC): $(SH2_FUNC089_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_089.inc..."
	@echo "; Auto-generated from $(SH2_FUNC089_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_090 binary from source (requires linker script)
$(SH2_FUNC090_BIN): $(SH2_FUNC090_SRC) $(SH2_FUNC090_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_090 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_090.o $<
	$(SH2_LD) -T $(SH2_FUNC090_LDS) -o $(BUILD_DIR)/sh2/func_090.elf $(BUILD_DIR)/sh2/func_090.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_090.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 24)"

$(SH2_FUNC090_INC): $(SH2_FUNC090_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_090.inc..."
	@echo "; Auto-generated from $(SH2_FUNC090_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_091 binary from source (requires linker script)
$(SH2_FUNC091_BIN): $(SH2_FUNC091_SRC) $(SH2_FUNC091_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_091 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_091.o $<
	$(SH2_LD) -T $(SH2_FUNC091_LDS) -o $(BUILD_DIR)/sh2/func_091.elf $(BUILD_DIR)/sh2/func_091.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_091.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 18)"

$(SH2_FUNC091_INC): $(SH2_FUNC091_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_091.inc..."
	@echo "; Auto-generated from $(SH2_FUNC091_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_005 binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC005_BIN): $(SH2_FUNC005_SRC) $(SH2_FUNC005_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_005 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_005.o $<
	$(SH2_LD) -T $(SH2_FUNC005_LDS) -o $(BUILD_DIR)/sh2/func_005.elf $(BUILD_DIR)/sh2/func_005.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_005.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 56)"

$(SH2_FUNC005_INC): $(SH2_FUNC005_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_005.inc..."
	@echo "; Auto-generated from $(SH2_FUNC005_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_007 binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC007_BIN): $(SH2_FUNC007_SRC) $(SH2_FUNC007_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_007 (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_007.o $<
	$(SH2_LD) -T $(SH2_FUNC007_LDS) -o $(BUILD_DIR)/sh2/func_007.elf $(BUILD_DIR)/sh2/func_007.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/func_007.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 52)"

$(SH2_FUNC007_INC): $(SH2_FUNC007_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_007.inc..."
	@echo "; Auto-generated from $(SH2_FUNC007_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_006 binary from source
$(SH2_FUNC006_BIN): $(SH2_FUNC006_SRC) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_006..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_006.o $<
	$(SH2_OBJCOPY) -O binary $(BUILD_DIR)/sh2/func_006.o $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes)"

# Generate dc.w include from binary (big-endian format for 68K assembler)
$(SH2_FUNC006_INC): $(SH2_FUNC006_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_006.inc..."
	@echo "; Auto-generated from $(SH2_FUNC006_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_008 binary from source
$(SH2_FUNC008_BIN): $(SH2_FUNC008_SRC) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_008..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_008.o $<
	$(SH2_OBJCOPY) -O binary $(BUILD_DIR)/sh2/func_008.o $@
	@# Trim to exact 56 bytes (exclude delay slot - shared with func_009)
	@truncate -s 56 $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes)"

$(SH2_FUNC008_INC): $(SH2_FUNC008_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_008.inc..."
	@echo "; Auto-generated from $(SH2_FUNC008_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_016 binary from source
$(SH2_FUNC016_BIN): $(SH2_FUNC016_SRC) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_016..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_016.o $<
	$(SH2_OBJCOPY) -O binary $(BUILD_DIR)/sh2/func_016.o $@
	@# Trim to exact 34 bytes (remove assembler padding)
	@truncate -s 34 $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes)"

$(SH2_FUNC016_INC): $(SH2_FUNC016_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_016.inc..."
	@echo "; Auto-generated from $(SH2_FUNC016_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_009 binary from source
$(SH2_FUNC009_BIN): $(SH2_FUNC009_SRC) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_009..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_009.o $<
	$(SH2_OBJCOPY) -O binary $(BUILD_DIR)/sh2/func_009.o $@
	@# Trim to exact 30 bytes (remove assembler padding)
	@truncate -s 30 $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes)"

$(SH2_FUNC009_INC): $(SH2_FUNC009_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_009.inc..."
	@echo "; Auto-generated from $(SH2_FUNC009_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_010 binary from source
$(SH2_FUNC010_BIN): $(SH2_FUNC010_SRC) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_010..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_010.o $<
	$(SH2_OBJCOPY) -O binary $(BUILD_DIR)/sh2/func_010.o $@
	@# Trim to exact 26 bytes (remove assembler padding)
	@truncate -s 26 $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes)"

$(SH2_FUNC010_INC): $(SH2_FUNC010_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_010.inc..."
	@echo "; Auto-generated from $(SH2_FUNC010_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_065 binary from source
$(SH2_FUNC065_BIN): $(SH2_FUNC065_SRC) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_065..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_065.o $<
	$(SH2_OBJCOPY) -O binary $(BUILD_DIR)/sh2/func_065.o $@
	@# Trim to exact 152 bytes (remove assembler padding/delay slot)
	@truncate -s 152 $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes)"

$(SH2_FUNC065_INC): $(SH2_FUNC065_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_065.inc..."
	@echo "; Auto-generated from $(SH2_FUNC065_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_066 binary from source
$(SH2_FUNC066_BIN): $(SH2_FUNC066_SRC) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_066..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_066.o $<
	$(SH2_OBJCOPY) -O binary $(BUILD_DIR)/sh2/func_066.o $@
	@# Trim to exact 48 bytes (remove assembler padding)
	@truncate -s 48 $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes)"

$(SH2_FUNC066_INC): $(SH2_FUNC066_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_066.inc..."
	@echo "; Auto-generated from $(SH2_FUNC066_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build func_021_optimized binary from source (expansion ROM)
$(SH2_FUNC021_OPT_BIN): $(SH2_FUNC021_OPT_SRC) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: func_021_optimized..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/func_021_optimized.o $<
	$(SH2_OBJCOPY) -O binary $(BUILD_DIR)/sh2/func_021_optimized.o $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes)"

$(SH2_FUNC021_OPT_INC): $(SH2_FUNC021_OPT_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_021_optimized.inc..."
	@echo "; Auto-generated from $(SH2_FUNC021_OPT_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build batch_copy_handler binary from source
$(SH2_BATCH_COPY_BIN): $(SH2_BATCH_COPY_SRC) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: batch_copy_handler..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/batch_copy_handler.o $<
	$(SH2_OBJCOPY) -O binary $(BUILD_DIR)/sh2/batch_copy_handler.o $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes)"

$(SH2_BATCH_COPY_INC): $(SH2_BATCH_COPY_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: batch_copy_handler.inc..."
	@echo "; Auto-generated from $(SH2_BATCH_COPY_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build cmd27_queue_drain binary from source (expansion ROM)
$(SH2_CMD27_DRAIN_BIN): $(SH2_CMD27_DRAIN_SRC) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: cmd27_queue_drain..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/cmd27_queue_drain.o $<
	$(SH2_OBJCOPY) -O binary $(BUILD_DIR)/sh2/cmd27_queue_drain.o $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes)"

$(SH2_CMD27_DRAIN_INC): $(SH2_CMD27_DRAIN_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: cmd27_queue_drain.inc..."
	@echo "; Auto-generated from $(SH2_CMD27_DRAIN_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build slave_work_wrapper_v2 binary from source (expansion ROM)
$(SH2_SLAVE_WRAPPER_V2_BIN): $(SH2_SLAVE_WRAPPER_V2_SRC) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: slave_work_wrapper_v2..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/slave_work_wrapper_v2.o $<
	$(SH2_OBJCOPY) -O binary $(BUILD_DIR)/sh2/slave_work_wrapper_v2.o $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes)"

$(SH2_SLAVE_WRAPPER_V2_INC): $(SH2_SLAVE_WRAPPER_V2_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: slave_work_wrapper_v2.inc..."
	@echo "; Auto-generated from $(SH2_SLAVE_WRAPPER_V2_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build handler_frame_sync binary from source (expansion ROM, with linker script)
$(SH2_HANDLER_FRAME_SYNC_BIN): $(SH2_HANDLER_FRAME_SYNC_SRC) $(SH2_HANDLER_FRAME_SYNC_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: handler_frame_sync (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/handler_frame_sync.o $<
	$(SH2_LD) -T $(SH2_HANDLER_FRAME_SYNC_LDS) -o $(BUILD_DIR)/sh2/handler_frame_sync.elf $(BUILD_DIR)/sh2/handler_frame_sync.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/handler_frame_sync.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 22)"

$(SH2_HANDLER_FRAME_SYNC_INC): $(SH2_HANDLER_FRAME_SYNC_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: handler_frame_sync.inc..."
	@echo "; Auto-generated from $(SH2_HANDLER_FRAME_SYNC_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build master_dispatch_hook binary from source (expansion ROM, with linker script)
$(SH2_MASTER_DISPATCH_HOOK_BIN): $(SH2_MASTER_DISPATCH_HOOK_SRC) $(SH2_MASTER_DISPATCH_HOOK_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: master_dispatch_hook (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/master_dispatch_hook.o $<
	$(SH2_LD) -T $(SH2_MASTER_DISPATCH_HOOK_LDS) -o $(BUILD_DIR)/sh2/master_dispatch_hook.elf $(BUILD_DIR)/sh2/master_dispatch_hook.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/master_dispatch_hook.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 44)"

$(SH2_MASTER_DISPATCH_HOOK_INC): $(SH2_MASTER_DISPATCH_HOOK_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: master_dispatch_hook.inc..."
	@echo "; Auto-generated from $(SH2_MASTER_DISPATCH_HOOK_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build slave_test_func binary from source (expansion ROM, with linker script)
$(SH2_SLAVE_TEST_FUNC_BIN): $(SH2_SLAVE_TEST_FUNC_SRC) $(SH2_SLAVE_TEST_FUNC_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: slave_test_func (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/slave_test_func.o $<
	$(SH2_LD) -T $(SH2_SLAVE_TEST_FUNC_LDS) -o $(BUILD_DIR)/sh2/slave_test_func.elf $(BUILD_DIR)/sh2/slave_test_func.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/slave_test_func.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 44)"

$(SH2_SLAVE_TEST_FUNC_INC): $(SH2_SLAVE_TEST_FUNC_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: slave_test_func.inc..."
	@echo "; Auto-generated from $(SH2_SLAVE_TEST_FUNC_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build shadow_path_wrapper binary from source (expansion ROM, with linker script)
$(SH2_SHADOW_PATH_WRAPPER_BIN): $(SH2_SHADOW_PATH_WRAPPER_SRC) $(SH2_SHADOW_PATH_WRAPPER_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: shadow_path_wrapper (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/shadow_path_wrapper.o $<
	$(SH2_LD) -T $(SH2_SHADOW_PATH_WRAPPER_LDS) -o $(BUILD_DIR)/sh2/shadow_path_wrapper.elf $(BUILD_DIR)/sh2/shadow_path_wrapper.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/shadow_path_wrapper.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 52)"

$(SH2_SHADOW_PATH_WRAPPER_INC): $(SH2_SHADOW_PATH_WRAPPER_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: shadow_path_wrapper.inc..."
	@echo "; Auto-generated from $(SH2_SHADOW_PATH_WRAPPER_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build cmdint_handler binary from source (Phase 1 - expansion ROM, with linker script)
$(SH2_CMDINT_HANDLER_BIN): $(SH2_CMDINT_HANDLER_SRC) $(SH2_CMDINT_HANDLER_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: cmdint_handler (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/cmdint_handler.o $<
	$(SH2_LD) -T $(SH2_CMDINT_HANDLER_LDS) -o $(BUILD_DIR)/sh2/cmdint_handler.elf $(BUILD_DIR)/sh2/cmdint_handler.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/cmdint_handler.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes)"

$(SH2_CMDINT_HANDLER_INC): $(SH2_CMDINT_HANDLER_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: cmdint_handler.inc..."
	@echo "; Auto-generated from $(SH2_CMDINT_HANDLER_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build queue_processor binary from source (Phase 1 - expansion ROM, with linker script)
$(SH2_QUEUE_PROCESSOR_BIN): $(SH2_QUEUE_PROCESSOR_SRC) $(SH2_QUEUE_PROCESSOR_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: queue_processor (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/queue_processor.o $<
	$(SH2_LD) -T $(SH2_QUEUE_PROCESSOR_LDS) -o $(BUILD_DIR)/sh2/queue_processor.elf $(BUILD_DIR)/sh2/queue_processor.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/queue_processor.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes)"

$(SH2_QUEUE_PROCESSOR_INC): $(SH2_QUEUE_PROCESSOR_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: queue_processor.inc..."
	@echo "; Auto-generated from $(SH2_QUEUE_PROCESSOR_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Verify SH2 assembly matches original ROM
sh2-verify: $(SH2_FUNC000_BIN) $(SH2_FUNC022_BIN) $(SH2_FUNC017_BIN) $(SH2_FUNC018_BIN) $(SH2_FUNC032_BIN) $(SH2_FUNC011_BIN) $(SH2_FUNC012_BIN) $(SH2_FUNC013_BIN) $(SH2_FUNC014_015_BIN) $(SH2_FUNC024_BIN) $(SH2_FUNC025_BIN) $(SH2_FUNC026_BIN) $(SH2_FUNC003_004_BIN) $(SH2_FUNC029_030_031_BIN) $(SH2_FUNC033_BIN) $(SH2_FUNC034_BIN) $(SH2_FUNC036_BIN) $(SH2_FUNC037_038_039_BIN) $(SH2_FUNC005_BIN) $(SH2_FUNC007_BIN) $(SH2_FUNC006_BIN) $(SH2_FUNC008_BIN) $(SH2_FUNC016_BIN) $(SH2_FUNC009_BIN) $(SH2_FUNC010_BIN) $(SH2_FUNC065_BIN) $(SH2_FUNC066_BIN)
	@echo "==> Verifying SH2 assembly against original ROM..."
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x2300A)) count=26 2>/dev/null > $(BUILD_DIR)/sh2/func_000_original.bin
	@if diff -q $(SH2_FUNC000_BIN) $(BUILD_DIR)/sh2/func_000_original.bin > /dev/null 2>&1; then \
		echo "✓ func_000: PERFECT MATCH"; \
	else \
		echo "✗ func_000: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x234EE)) count=26 2>/dev/null > $(BUILD_DIR)/sh2/func_022_original.bin
	@if diff -q $(SH2_FUNC022_BIN) $(BUILD_DIR)/sh2/func_022_original.bin > /dev/null 2>&1; then \
		echo "✓ func_022: PERFECT MATCH"; \
	else \
		echo "✗ func_022: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x2338A)) count=26 2>/dev/null > $(BUILD_DIR)/sh2/func_017_original.bin
	@if diff -q $(SH2_FUNC017_BIN) $(BUILD_DIR)/sh2/func_017_original.bin > /dev/null 2>&1; then \
		echo "✓ func_017: PERFECT MATCH"; \
	else \
		echo "✗ func_017: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x233A4)) count=112 2>/dev/null > $(BUILD_DIR)/sh2/func_018_original.bin
	@if diff -q $(SH2_FUNC018_BIN) $(BUILD_DIR)/sh2/func_018_original.bin > /dev/null 2>&1; then \
		echo "✓ func_018: PERFECT MATCH"; \
	else \
		echo "✗ func_018: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23414)) count=140 2>/dev/null > $(BUILD_DIR)/sh2/func_019_original.bin
	@if diff -q $(SH2_FUNC019_BIN) $(BUILD_DIR)/sh2/func_019_original.bin > /dev/null 2>&1; then \
		echo "✓ func_019: PERFECT MATCH"; \
	else \
		echo "✗ func_019: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x234A0)) count=40 2>/dev/null > $(BUILD_DIR)/sh2/func_020_original.bin
	@if diff -q $(SH2_FUNC020_BIN) $(BUILD_DIR)/sh2/func_020_original.bin > /dev/null 2>&1; then \
		echo "✓ func_020: PERFECT MATCH"; \
	else \
		echo "✗ func_020: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x234C8)) count=38 2>/dev/null > $(BUILD_DIR)/sh2/func_021_orig_original.bin
	@if diff -q $(SH2_FUNC021_ORIG_BIN) $(BUILD_DIR)/sh2/func_021_orig_original.bin > /dev/null 2>&1; then \
		echo "✓ func_021_orig: PERFECT MATCH"; \
	else \
		echo "✗ func_021_orig: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23508)) count=238 2>/dev/null > $(BUILD_DIR)/sh2/func_023_original.bin
	@if diff -q $(SH2_FUNC023_BIN) $(BUILD_DIR)/sh2/func_023_original.bin > /dev/null 2>&1; then \
		echo "✓ func_023: PERFECT MATCH"; \
	else \
		echo "✗ func_023: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x2385E)) count=122 2>/dev/null > $(BUILD_DIR)/sh2/func_040_original.bin
	@if diff -q $(SH2_FUNC040_BIN) $(BUILD_DIR)/sh2/func_040_original.bin > /dev/null 2>&1; then \
		echo "✓ func_040: PERFECT MATCH"; \
	else \
		echo "✗ func_040: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x238D8)) count=212 2>/dev/null > $(BUILD_DIR)/sh2/func_040_cases_original.bin
	@if diff -q $(SH2_FUNC040_CASES_BIN) $(BUILD_DIR)/sh2/func_040_cases_original.bin > /dev/null 2>&1; then \
		echo "✓ func_040_cases: PERFECT MATCH"; \
	else \
		echo "✗ func_040_cases: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x239B0)) count=28 2>/dev/null > $(BUILD_DIR)/sh2/func_040_utility_original.bin
	@if diff -q $(SH2_FUNC040_UTIL_BIN) $(BUILD_DIR)/sh2/func_040_utility_original.bin > /dev/null 2>&1; then \
		echo "✓ func_040_utility: PERFECT MATCH"; \
	else \
		echo "✗ func_040_utility: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x239F0)) count=98 2>/dev/null > $(BUILD_DIR)/sh2/func_041_original.bin
	@if diff -q $(SH2_FUNC041_BIN) $(BUILD_DIR)/sh2/func_041_original.bin > /dev/null 2>&1; then \
		echo "✓ func_041: PERFECT MATCH"; \
	else \
		echo "✗ func_041: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23A52)) count=20 2>/dev/null > $(BUILD_DIR)/sh2/func_042_original.bin
	@if diff -q $(SH2_FUNC042_BIN) $(BUILD_DIR)/sh2/func_042_original.bin > /dev/null 2>&1; then \
		echo "✓ func_042: PERFECT MATCH"; \
	else \
		echo "✗ func_042: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23A70)) count=312 2>/dev/null > $(BUILD_DIR)/sh2/func_043_original.bin
	@if diff -q $(SH2_FUNC043_BIN) $(BUILD_DIR)/sh2/func_043_original.bin > /dev/null 2>&1; then \
		echo "✓ func_043: PERFECT MATCH"; \
	else \
		echo "✗ func_043: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23BA8)) count=268 2>/dev/null > $(BUILD_DIR)/sh2/func_044_original.bin
	@if diff -q $(SH2_FUNC044_BIN) $(BUILD_DIR)/sh2/func_044_original.bin > /dev/null 2>&1; then \
		echo "✓ func_044: PERFECT MATCH"; \
	else \
		echo "✗ func_044: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23CB4)) count=68 2>/dev/null > $(BUILD_DIR)/sh2/func_045_original.bin
	@if diff -q $(SH2_FUNC045_BIN) $(BUILD_DIR)/sh2/func_045_original.bin > /dev/null 2>&1; then \
		echo "✓ func_045: PERFECT MATCH"; \
	else \
		echo "✗ func_045: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23CF8)) count=36 2>/dev/null > $(BUILD_DIR)/sh2/func_046_original.bin
	@if diff -q $(SH2_FUNC046_BIN) $(BUILD_DIR)/sh2/func_046_original.bin > /dev/null 2>&1; then \
		echo "✓ func_046: PERFECT MATCH"; \
	else \
		echo "✗ func_046: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23D24)) count=26 2>/dev/null > $(BUILD_DIR)/sh2/func_047_original.bin
	@if diff -q $(SH2_FUNC047_BIN) $(BUILD_DIR)/sh2/func_047_original.bin > /dev/null 2>&1; then \
		echo "✓ func_047: PERFECT MATCH"; \
	else \
		echo "✗ func_047: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23D3E)) count=22 2>/dev/null > $(BUILD_DIR)/sh2/func_048_original.bin
	@if diff -q $(SH2_FUNC048_BIN) $(BUILD_DIR)/sh2/func_048_original.bin > /dev/null 2>&1; then \
		echo "✓ func_048: PERFECT MATCH"; \
	else \
		echo "✗ func_048: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23D54)) count=26 2>/dev/null > $(BUILD_DIR)/sh2/func_049_original.bin
	@if diff -q $(SH2_FUNC049_BIN) $(BUILD_DIR)/sh2/func_049_original.bin > /dev/null 2>&1; then \
		echo "✓ func_049: PERFECT MATCH"; \
	else \
		echo "✗ func_049: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23D6E)) count=88 2>/dev/null > $(BUILD_DIR)/sh2/func_050_original.bin
	@if diff -q $(SH2_FUNC050_BIN) $(BUILD_DIR)/sh2/func_050_original.bin > /dev/null 2>&1; then \
		echo "✓ func_050: PERFECT MATCH"; \
	else \
		echo "✗ func_050: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23DD8)) count=92 2>/dev/null > $(BUILD_DIR)/sh2/func_051_original.bin
	@if diff -q $(SH2_FUNC051_BIN) $(BUILD_DIR)/sh2/func_051_original.bin > /dev/null 2>&1; then \
		echo "✓ func_051: PERFECT MATCH"; \
	else \
		echo "✗ func_051: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23E48)) count=22 2>/dev/null > $(BUILD_DIR)/sh2/func_052_original.bin
	@if diff -q $(SH2_FUNC052_BIN) $(BUILD_DIR)/sh2/func_052_original.bin > /dev/null 2>&1; then \
		echo "✓ func_052: PERFECT MATCH"; \
	else \
		echo "✗ func_052: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23E64)) count=38 2>/dev/null > $(BUILD_DIR)/sh2/func_053_original.bin
	@if diff -q $(SH2_FUNC053_BIN) $(BUILD_DIR)/sh2/func_053_original.bin > /dev/null 2>&1; then \
		echo "✓ func_053: PERFECT MATCH"; \
	else \
		echo "✗ func_053: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23E90)) count=56 2>/dev/null > $(BUILD_DIR)/sh2/func_054_original.bin
	@if diff -q $(SH2_FUNC054_BIN) $(BUILD_DIR)/sh2/func_054_original.bin > /dev/null 2>&1; then \
		echo "✓ func_054: PERFECT MATCH"; \
	else \
		echo "✗ func_054: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23ED0)) count=92 2>/dev/null > $(BUILD_DIR)/sh2/func_055_original.bin
	@if diff -q $(SH2_FUNC055_BIN) $(BUILD_DIR)/sh2/func_055_original.bin > /dev/null 2>&1; then \
		echo "✓ func_055: PERFECT MATCH"; \
	else \
		echo "✗ func_055: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23FF4)) count=14 2>/dev/null > $(BUILD_DIR)/sh2/func_067_original.bin
	@if diff -q $(SH2_FUNC067_BIN) $(BUILD_DIR)/sh2/func_067_original.bin > /dev/null 2>&1; then \
		echo "✓ func_067: PERFECT MATCH"; \
	else \
		echo "✗ func_067: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x24002)) count=12 2>/dev/null > $(BUILD_DIR)/sh2/func_068_original.bin
	@if diff -q $(SH2_FUNC068_BIN) $(BUILD_DIR)/sh2/func_068_original.bin > /dev/null 2>&1; then \
		echo "✓ func_068: PERFECT MATCH"; \
	else \
		echo "✗ func_068: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x2400E)) count=76 2>/dev/null > $(BUILD_DIR)/sh2/func_069_original.bin
	@if diff -q $(SH2_FUNC069_BIN) $(BUILD_DIR)/sh2/func_069_original.bin > /dev/null 2>&1; then \
		echo "✓ func_069: PERFECT MATCH"; \
	else \
		echo "✗ func_069: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x24060)) count=36 2>/dev/null > $(BUILD_DIR)/sh2/func_070_original.bin
	@if diff -q $(SH2_FUNC070_BIN) $(BUILD_DIR)/sh2/func_070_original.bin > /dev/null 2>&1; then \
		echo "✓ func_070: PERFECT MATCH"; \
	else \
		echo "✗ func_070: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x24084)) count=122 2>/dev/null > $(BUILD_DIR)/sh2/func_071_original.bin
	@if diff -q $(SH2_FUNC071_BIN) $(BUILD_DIR)/sh2/func_071_original.bin > /dev/null 2>&1; then \
		echo "✓ func_071: PERFECT MATCH"; \
	else \
		echo "✗ func_071: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x241A4)) count=42 2>/dev/null > $(BUILD_DIR)/sh2/func_072_original.bin
	@if diff -q $(SH2_FUNC072_BIN) $(BUILD_DIR)/sh2/func_072_original.bin > /dev/null 2>&1; then \
		echo "✓ func_072: PERFECT MATCH"; \
	else \
		echo "✗ func_072: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x241D8)) count=16 2>/dev/null > $(BUILD_DIR)/sh2/func_073_original.bin
	@if diff -q $(SH2_FUNC073_BIN) $(BUILD_DIR)/sh2/func_073_original.bin > /dev/null 2>&1; then \
		echo "✓ func_073: PERFECT MATCH"; \
	else \
		echo "✗ func_073: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x241E8)) count=30 2>/dev/null > $(BUILD_DIR)/sh2/func_074_original.bin
	@if diff -q $(SH2_FUNC074_BIN) $(BUILD_DIR)/sh2/func_074_original.bin > /dev/null 2>&1; then \
		echo "✓ func_074: PERFECT MATCH"; \
	else \
		echo "✗ func_074: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x236DA)) count=32 2>/dev/null > $(BUILD_DIR)/sh2/func_032_original.bin
	@if diff -q $(SH2_FUNC032_BIN) $(BUILD_DIR)/sh2/func_032_original.bin > /dev/null 2>&1; then \
		echo "✓ func_032: PERFECT MATCH"; \
	else \
		echo "✗ func_032: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23220)) count=84 2>/dev/null > $(BUILD_DIR)/sh2/func_011_original.bin
	@if diff -q $(SH2_FUNC011_BIN) $(BUILD_DIR)/sh2/func_011_original.bin > /dev/null 2>&1; then \
		echo "✓ func_011: PERFECT MATCH"; \
	else \
		echo "✗ func_011: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23278)) count=92 2>/dev/null > $(BUILD_DIR)/sh2/func_012_original.bin
	@if diff -q $(SH2_FUNC012_BIN) $(BUILD_DIR)/sh2/func_012_original.bin > /dev/null 2>&1; then \
		echo "✓ func_012: PERFECT MATCH"; \
	else \
		echo "✗ func_012: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x232D4)) count=92 2>/dev/null > $(BUILD_DIR)/sh2/func_013_original.bin
	@if diff -q $(SH2_FUNC013_BIN) $(BUILD_DIR)/sh2/func_013_original.bin > /dev/null 2>&1; then \
		echo "✓ func_013: PERFECT MATCH"; \
	else \
		echo "✗ func_013: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23330)) count=56 2>/dev/null > $(BUILD_DIR)/sh2/func_014_015_original.bin
	@if diff -q $(SH2_FUNC014_015_BIN) $(BUILD_DIR)/sh2/func_014_015_original.bin > /dev/null 2>&1; then \
		echo "✓ func_014_015: PERFECT MATCH"; \
	else \
		echo "✗ func_014_015: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x235F6)) count=62 2>/dev/null > $(BUILD_DIR)/sh2/func_024_original.bin
	@if diff -q $(SH2_FUNC024_BIN) $(BUILD_DIR)/sh2/func_024_original.bin > /dev/null 2>&1; then \
		echo "✓ func_024: PERFECT MATCH"; \
	else \
		echo "✗ func_024: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23634)) count=16 2>/dev/null > $(BUILD_DIR)/sh2/func_025_original.bin
	@if diff -q $(SH2_FUNC025_BIN) $(BUILD_DIR)/sh2/func_025_original.bin > /dev/null 2>&1; then \
		echo "✓ func_025: PERFECT MATCH"; \
	else \
		echo "✗ func_025: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23644)) count=68 2>/dev/null > $(BUILD_DIR)/sh2/func_026_original.bin
	@if diff -q $(SH2_FUNC026_BIN) $(BUILD_DIR)/sh2/func_026_original.bin > /dev/null 2>&1; then \
		echo "✓ func_026: PERFECT MATCH"; \
	else \
		echo "✗ func_026: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x230C8)) count=32 2>/dev/null > $(BUILD_DIR)/sh2/func_003_004_original.bin
	@if diff -q $(SH2_FUNC003_004_BIN) $(BUILD_DIR)/sh2/func_003_004_original.bin > /dev/null 2>&1; then \
		echo "✓ func_003_004: PERFECT MATCH"; \
	else \
		echo "✗ func_003_004: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23688)) count=82 2>/dev/null > $(BUILD_DIR)/sh2/func_029_030_031_original.bin
	@if diff -q $(SH2_FUNC029_030_031_BIN) $(BUILD_DIR)/sh2/func_029_030_031_original.bin > /dev/null 2>&1; then \
		echo "✓ func_029_030_031: PERFECT MATCH"; \
	else \
		echo "✗ func_029_030_031: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x236FA)) count=98 2>/dev/null > $(BUILD_DIR)/sh2/func_033_original.bin
	@if diff -q $(SH2_FUNC033_BIN) $(BUILD_DIR)/sh2/func_033_original.bin > /dev/null 2>&1; then \
		echo "✓ func_033: PERFECT MATCH"; \
	else \
		echo "✗ func_033: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x2375C)) count=122 2>/dev/null > $(BUILD_DIR)/sh2/func_034_original.bin
	@if diff -q $(SH2_FUNC034_BIN) $(BUILD_DIR)/sh2/func_034_original.bin > /dev/null 2>&1; then \
		echo "✓ func_034: PERFECT MATCH"; \
	else \
		echo "✗ func_034: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x237D6)) count=72 2>/dev/null > $(BUILD_DIR)/sh2/func_036_original.bin
	@if diff -q $(SH2_FUNC036_BIN) $(BUILD_DIR)/sh2/func_036_original.bin > /dev/null 2>&1; then \
		echo "✓ func_036: PERFECT MATCH"; \
	else \
		echo "✗ func_036: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x2381E)) count=64 2>/dev/null > $(BUILD_DIR)/sh2/func_037_038_039_original.bin
	@if diff -q $(SH2_FUNC037_038_039_BIN) $(BUILD_DIR)/sh2/func_037_038_039_original.bin > /dev/null 2>&1; then \
		echo "✓ func_037_038_039: PERFECT MATCH"; \
	else \
		echo "✗ func_037_038_039: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x230E8)) count=56 2>/dev/null > $(BUILD_DIR)/sh2/func_005_original.bin
	@if diff -q $(SH2_FUNC005_BIN) $(BUILD_DIR)/sh2/func_005_original.bin > /dev/null 2>&1; then \
		echo "✓ func_005: PERFECT MATCH"; \
	else \
		echo "✗ func_005: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23178)) count=52 2>/dev/null > $(BUILD_DIR)/sh2/func_007_original.bin
	@if diff -q $(SH2_FUNC007_BIN) $(BUILD_DIR)/sh2/func_007_original.bin > /dev/null 2>&1; then \
		echo "✓ func_007: PERFECT MATCH"; \
	else \
		echo "✗ func_007: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23120)) count=88 2>/dev/null > $(BUILD_DIR)/sh2/func_006_original.bin
	@if diff -q $(SH2_FUNC006_BIN) $(BUILD_DIR)/sh2/func_006_original.bin > /dev/null 2>&1; then \
		echo "✓ func_006: PERFECT MATCH"; \
	else \
		echo "✗ func_006: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x231AC)) count=56 2>/dev/null > $(BUILD_DIR)/sh2/func_008_original.bin
	@if diff -q $(SH2_FUNC008_BIN) $(BUILD_DIR)/sh2/func_008_original.bin > /dev/null 2>&1; then \
		echo "✓ func_008: PERFECT MATCH"; \
	else \
		echo "✗ func_008: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23368)) count=34 2>/dev/null > $(BUILD_DIR)/sh2/func_016_original.bin
	@if diff -q $(SH2_FUNC016_BIN) $(BUILD_DIR)/sh2/func_016_original.bin > /dev/null 2>&1; then \
		echo "✓ func_016: PERFECT MATCH"; \
	else \
		echo "✗ func_016: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x231E4)) count=30 2>/dev/null > $(BUILD_DIR)/sh2/func_009_original.bin
	@if diff -q $(SH2_FUNC009_BIN) $(BUILD_DIR)/sh2/func_009_original.bin > /dev/null 2>&1; then \
		echo "✓ func_009: PERFECT MATCH"; \
	else \
		echo "✗ func_009: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23202)) count=26 2>/dev/null > $(BUILD_DIR)/sh2/func_010_original.bin
	@if diff -q $(SH2_FUNC010_BIN) $(BUILD_DIR)/sh2/func_010_original.bin > /dev/null 2>&1; then \
		echo "✓ func_010: PERFECT MATCH"; \
	else \
		echo "✗ func_010: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23F2C)) count=152 2>/dev/null > $(BUILD_DIR)/sh2/func_065_original.bin
	@if diff -q $(SH2_FUNC065_BIN) $(BUILD_DIR)/sh2/func_065_original.bin > /dev/null 2>&1; then \
		echo "✓ func_065: PERFECT MATCH"; \
	else \
		echo "✗ func_065: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23FC4)) count=48 2>/dev/null > $(BUILD_DIR)/sh2/func_066_original.bin
	@if diff -q $(SH2_FUNC066_BIN) $(BUILD_DIR)/sh2/func_066_original.bin > /dev/null 2>&1; then \
		echo "✓ func_066: PERFECT MATCH"; \
	else \
		echo "✗ func_066: MISMATCH"; \
		exit 1; \
	fi
	@echo "✓✓✓ All SH2 functions verified! ✓✓✓"

# ============================================================================
# Profiling & Testing
# ============================================================================

PROFILE_DIR = tools/libretro-profiling
PROFILE_FRONTEND = $(PROFILE_DIR)/profiling_frontend
PROFILE_CORE = $(PROFILE_DIR)/picodrive_libretro.so
PROFILE_FRAMES ?= 2400

# Frame-level CPU profiling (68K/MSH2/SSH2 cycles per frame)
profile-frame: all
	@echo "==> Running frame-level profiling ($(PROFILE_FRAMES) frames)..."
	cd $(PROFILE_DIR) && ./profiling_frontend ../../$(OUTPUT_ROM) $(PROFILE_FRAMES) --autoplay
	@echo "==> Analyzing frame profile..."
	$(PYTHON) $(PROFILE_DIR)/analyze_profile.py $(PROFILE_DIR)/frame_profile.csv

# PC-level hotspot profiling (per-address cycle breakdown)
profile-pc: all
	@echo "==> Running PC-level profiling ($(PROFILE_FRAMES) frames)..."
	cd $(PROFILE_DIR) && VRD_PROFILE_PC=1 VRD_PROFILE_PC_LOG=pc_profile.csv \
		./profiling_frontend ../../$(OUTPUT_ROM) $(PROFILE_FRAMES) --autoplay
	@echo "==> Analyzing PC profile..."
	$(PYTHON) $(PROFILE_DIR)/analyze_pc_profile.py $(PROFILE_DIR)/pc_profile.csv

# Quick boot test: run ROM for 300 frames (~5 seconds), verify no crash
test: all
	@echo "==> Boot-testing ROM (300 frames)..."
	@cd $(PROFILE_DIR) && ./profiling_frontend ../../$(OUTPUT_ROM) 300 --autoplay > /dev/null 2>&1 \
		&& echo "✓ ROM booted successfully (300 frames)" \
		|| (echo "✗ ROM failed to boot" && exit 1)

# ============================================================================
# Cleanup
# ============================================================================

clean:
	@echo "==> Cleaning build files..."
	rm -rf $(BUILD_DIR)
	rm -rf $(SH2_GEN_DIR)

clean-all: clean
	@echo "==> Cleaning all generated files..."
	rm -rf tools/vasm tools/vasmm68k_mot

# ============================================================================
# Help
# ============================================================================

help:
	@echo "Virtua Racing Deluxe (32X) - Build System"
	@echo ""
	@echo "Build Targets:"
	@echo "  all            - Build the ROM from sections/ (original disasm)"
	@echo "  raw            - Build the ROM from sections_raw/ (guaranteed correct)"
	@echo "  modular        - Build the ROM from modules/ (refactored structure)"
	@echo ""
	@echo "Verification:"
	@echo "  compare        - Compare sections/ build with original"
	@echo "  compare-raw    - Compare sections_raw/ build with original"
	@echo "  compare-modular- Compare modules/ build with original"
	@echo "  compare-both   - Compare sections/ vs modules/ builds"
	@echo "  hexdump        - Show hex dump comparison"
	@echo ""
	@echo "SH2 Assembly:"
	@echo "  sh2-assembly   - Build SH2 sources to dc.w includes"
	@echo "  sh2-verify     - Verify SH2 assembly matches original ROM"
	@echo ""
	@echo "Analysis:"
	@echo "  disasm         - Disassemble ROM sections"
	@echo "  disasm-m68k    - Disassemble 68000 code"
	@echo "  disasm-sh2     - Disassemble SH2 code"
	@echo "  analyze        - Analyze ROM structure"
	@echo "  find-sections  - Find code sections"
	@echo ""
	@echo "Profiling & Testing:"
	@echo "  profile-frame  - Frame-level CPU profiling (cycles per frame)"
	@echo "  profile-pc     - PC-level hotspot profiling (per-address)"
	@echo "  test           - Quick boot test (300 frames)"
	@echo ""
	@echo "Maintenance:"
	@echo "  clean          - Remove build files"
	@echo "  clean-all      - Remove all generated files including tools"
	@echo "  tools          - Build assembler tools"
	@echo ""
