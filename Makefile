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
OUTPUT_ROM_RAW = $(BUILD_DIR)/vr_rebuild_raw.32x
OUTPUT_ROM_MODULAR = $(BUILD_DIR)/vr_rebuild_modular.32x

.PHONY: all clean disasm compare tools test modular compare-modular raw compare-raw

# ============================================================================
# Main targets
# ============================================================================

all: dirs sh2-assembly $(OUTPUT_ROM)

raw: dirs $(OUTPUT_ROM_RAW)

modular: dirs $(OUTPUT_ROM_MODULAR)

dirs:
	@mkdir -p $(BUILD_DIR)

# Build the ROM from original sections/
# Depends on SH2 assembly to ensure generated includes exist
$(OUTPUT_ROM): $(M68K_SRC) $(SH2_FUNC000_INC) $(SH2_FUNC022_INC) $(SH2_FUNC017_INC) $(SH2_FUNC018_INC) $(SH2_FUNC019_INC) $(SH2_FUNC020_INC) $(SH2_FUNC021_ORIG_INC) $(SH2_FUNC023_INC) $(SH2_FUNC040_INC) $(SH2_FUNC032_INC) $(SH2_FUNC011_INC) $(SH2_FUNC012_INC) $(SH2_FUNC013_INC) $(SH2_FUNC014_015_INC) $(SH2_FUNC024_INC) $(SH2_FUNC025_INC) $(SH2_FUNC026_INC) $(SH2_FUNC003_004_INC) $(SH2_FUNC029_030_031_INC) $(SH2_FUNC033_INC) $(SH2_FUNC034_INC) $(SH2_FUNC036_INC) $(SH2_FUNC037_038_039_INC) $(SH2_FUNC005_INC) $(SH2_FUNC007_INC) $(SH2_FUNC006_INC) $(SH2_FUNC008_INC) $(SH2_FUNC016_INC) $(SH2_FUNC065_INC) $(SH2_FUNC066_INC) $(SH2_FUNC021_OPT_INC)
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

.PHONY: sh2-assembly sh2-verify

# Build all SH2 assembly sources
sh2-assembly: dirs $(SH2_FUNC000_INC) $(SH2_FUNC022_INC) $(SH2_FUNC017_INC) $(SH2_FUNC018_INC) $(SH2_FUNC019_INC) $(SH2_FUNC020_INC) $(SH2_FUNC021_ORIG_INC) $(SH2_FUNC023_INC) $(SH2_FUNC040_INC) $(SH2_FUNC040_CASES_INC) $(SH2_FUNC040_UTIL_INC) $(SH2_FUNC041_INC) $(SH2_FUNC042_INC) $(SH2_FUNC043_INC) $(SH2_FUNC044_INC) $(SH2_FUNC032_INC) $(SH2_FUNC011_INC) $(SH2_FUNC012_INC) $(SH2_FUNC013_INC) $(SH2_FUNC014_015_INC) $(SH2_FUNC024_INC) $(SH2_FUNC025_INC) $(SH2_FUNC026_INC) $(SH2_FUNC003_004_INC) $(SH2_FUNC029_030_031_INC) $(SH2_FUNC033_INC) $(SH2_FUNC034_INC) $(SH2_FUNC036_INC) $(SH2_FUNC037_038_039_INC) $(SH2_FUNC005_INC) $(SH2_FUNC007_INC) $(SH2_FUNC006_INC) $(SH2_FUNC008_INC) $(SH2_FUNC016_INC) $(SH2_FUNC009_INC) $(SH2_FUNC010_INC) $(SH2_FUNC065_INC) $(SH2_FUNC066_INC) $(SH2_FUNC021_OPT_INC) $(SH2_BATCH_COPY_INC)

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
	@echo "Maintenance:
	@echo "  clean          - Remove build files"
	@echo "  clean-all      - Remove all generated files including tools"
	@echo "  tools          - Build assembler tools"
	@echo ""
