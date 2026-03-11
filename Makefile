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
.PHONY: all clean disasm tools test profile-frame profile-pc

# ============================================================================
# Main targets
# ============================================================================

all: dirs sh2-assembly $(OUTPUT_ROM)

dirs:
	@mkdir -p $(BUILD_DIR)

# Build the ROM from original sections/
# Depends on SH2 assembly to ensure generated includes exist
$(OUTPUT_ROM): $(M68K_SRC) $(SH2_FUNC000_INC) $(SH2_FUNC022_INC) $(SH2_FUNC017_INC) $(SH2_FUNC018_INC) $(SH2_FUNC019_INC) $(SH2_FUNC020_INC) $(SH2_FUNC021_ORIG_INC) $(SH2_FUNC023_INC) $(SH2_FUNC040_INC) $(SH2_FUNC032_INC) $(SH2_FUNC011_INC) $(SH2_FUNC012_INC) $(SH2_FUNC013_INC) $(SH2_FUNC014_015_INC) $(SH2_FUNC024_INC) $(SH2_FUNC025_INC) $(SH2_FUNC026_INC) $(SH2_FUNC001_INC) $(SH2_FUNC002_INC) $(SH2_FUNC003_004_INC) $(SH2_FUNC029_030_031_INC) $(SH2_FUNC033_INC) $(SH2_FUNC034_INC) $(SH2_FUNC036_INC) $(SH2_FUNC037_038_039_INC) $(SH2_FUNC005_INC) $(SH2_FUNC007_INC) $(SH2_FUNC006_INC) $(SH2_FUNC008_INC) $(SH2_FUNC016_INC) $(SH2_FUNC065_INC) $(SH2_FUNC066_INC) $(SH2_FUNC021_OPT_INC) $(SH2_BATCH_COPY_INC) $(SH2_CMD27_DRAIN_INC) $(SH2_SLAVE_WRAPPER_V2_INC) $(SH2_HANDLER_FRAME_SYNC_INC) $(SH2_MASTER_DISPATCH_HOOK_INC) $(SH2_SLAVE_TEST_FUNC_INC) $(SH2_SHADOW_PATH_WRAPPER_INC) $(SH2_CMDINT_HANDLER_INC) $(SH2_QUEUE_PROCESSOR_INC) $(SH2_GEN_DRAIN_INC)
	@echo "==> Assembling 68000 code (from sections/)..."
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
SH2_FUNC000_SRC = $(SH2_3D_DIR)/data_copy.asm
SH2_FUNC000_LDS = $(SH2_3D_DIR)/data_copy.lds
SH2_FUNC000_BIN = $(BUILD_DIR)/sh2/data_copy.bin
SH2_FUNC000_INC = $(SH2_GEN_DIR)/data_copy.inc

SH2_FUNC022_SRC = $(SH2_3D_DIR)/wait_ready.asm
SH2_FUNC022_LDS = $(SH2_3D_DIR)/wait_ready.lds
SH2_FUNC022_BIN = $(BUILD_DIR)/sh2/wait_ready.bin
SH2_FUNC022_INC = $(SH2_GEN_DIR)/wait_ready.inc

SH2_FUNC017_SRC = $(SH2_3D_DIR)/quad_helper.asm
SH2_FUNC017_LDS = $(SH2_3D_DIR)/quad_helper.lds
SH2_FUNC017_BIN = $(BUILD_DIR)/sh2/quad_helper.bin
SH2_FUNC017_INC = $(SH2_GEN_DIR)/quad_helper.inc

SH2_FUNC032_SRC = $(SH2_3D_DIR)/scanline_setup.asm
SH2_FUNC032_LDS = $(SH2_3D_DIR)/scanline_setup.lds
SH2_FUNC032_BIN = $(BUILD_DIR)/sh2/scanline_setup.bin
SH2_FUNC032_INC = $(SH2_GEN_DIR)/scanline_setup.inc

SH2_FUNC011_SRC = $(SH2_3D_DIR)/display_list_loop.asm
SH2_FUNC011_LDS = $(SH2_3D_DIR)/display_list_loop.lds
SH2_FUNC011_BIN = $(BUILD_DIR)/sh2/display_list_loop.bin
SH2_FUNC011_INC = $(SH2_GEN_DIR)/display_list_loop.inc

SH2_FUNC012_SRC = $(SH2_3D_DIR)/display_entry.asm
SH2_FUNC012_LDS = $(SH2_3D_DIR)/display_entry.lds
SH2_FUNC012_BIN = $(BUILD_DIR)/sh2/display_entry.bin
SH2_FUNC012_INC = $(SH2_GEN_DIR)/display_entry.inc

SH2_FUNC013_SRC = $(SH2_3D_DIR)/vdp_init_short.asm
SH2_FUNC013_LDS = $(SH2_3D_DIR)/vdp_init_short.lds
SH2_FUNC013_BIN = $(BUILD_DIR)/sh2/vdp_init_short.bin
SH2_FUNC013_INC = $(SH2_GEN_DIR)/vdp_init_short.inc

SH2_FUNC014_015_SRC = $(SH2_3D_DIR)/vdp_copy_short.asm
SH2_FUNC014_015_LDS = $(SH2_3D_DIR)/vdp_copy_short.lds
SH2_FUNC014_015_BIN = $(BUILD_DIR)/sh2/vdp_copy_short.bin
SH2_FUNC014_015_INC = $(SH2_GEN_DIR)/vdp_copy_short.inc

SH2_FUNC025_SRC = $(SH2_3D_DIR)/coord_offset_short.asm
SH2_FUNC025_LDS = $(SH2_3D_DIR)/coord_offset_short.lds
SH2_FUNC025_BIN = $(BUILD_DIR)/sh2/coord_offset_short.bin
SH2_FUNC025_INC = $(SH2_GEN_DIR)/coord_offset_short.inc

SH2_FUNC024_SRC = $(SH2_3D_DIR)/screen_coords_short.asm
SH2_FUNC024_LDS = $(SH2_3D_DIR)/screen_coords_short.lds
SH2_FUNC024_BIN = $(BUILD_DIR)/sh2/screen_coords_short.bin
SH2_FUNC024_INC = $(SH2_GEN_DIR)/screen_coords_short.inc

SH2_FUNC026_SRC = $(SH2_3D_DIR)/bounds_compare_short.asm
SH2_FUNC026_LDS = $(SH2_3D_DIR)/bounds_compare_short.lds
SH2_FUNC026_BIN = $(BUILD_DIR)/sh2/bounds_compare_short.bin
SH2_FUNC026_INC = $(SH2_GEN_DIR)/bounds_compare_short.inc

SH2_FUNC001_SRC = $(SH2_3D_DIR)/main_coordinator_short.asm
SH2_FUNC001_LDS = $(SH2_3D_DIR)/main_coordinator_short.lds
SH2_FUNC001_BIN = $(BUILD_DIR)/sh2/main_coordinator_short.bin
SH2_FUNC001_INC = $(SH2_GEN_DIR)/main_coordinator_short.inc

SH2_FUNC002_SRC = $(SH2_3D_DIR)/case_handlers_short.asm
SH2_FUNC002_LDS = $(SH2_3D_DIR)/case_handlers_short.lds
SH2_FUNC002_BIN = $(BUILD_DIR)/sh2/case_handlers_short.bin
SH2_FUNC002_INC = $(SH2_GEN_DIR)/case_handlers_short.inc

SH2_FUNC003_004_SRC = $(SH2_3D_DIR)/offset_copy_short.asm
SH2_FUNC003_004_LDS = $(SH2_3D_DIR)/offset_copy_short.lds
SH2_FUNC003_004_BIN = $(BUILD_DIR)/sh2/offset_copy_short.bin
SH2_FUNC003_004_INC = $(SH2_GEN_DIR)/offset_copy_short.inc

SH2_FUNC029_030_031_SRC = $(SH2_3D_DIR)/visibility_short.asm
SH2_FUNC029_030_031_LDS = $(SH2_3D_DIR)/visibility_short.lds
SH2_FUNC029_030_031_BIN = $(BUILD_DIR)/sh2/visibility_short.bin
SH2_FUNC029_030_031_INC = $(SH2_GEN_DIR)/visibility_short.inc

SH2_FUNC033_SRC = $(SH2_3D_DIR)/render_quad_short.asm
SH2_FUNC033_LDS = $(SH2_3D_DIR)/render_quad_short.lds
SH2_FUNC033_BIN = $(BUILD_DIR)/sh2/render_quad_short.bin
SH2_FUNC033_INC = $(SH2_GEN_DIR)/render_quad_short.inc

SH2_FUNC034_SRC = $(SH2_3D_DIR)/span_filler_short.asm
SH2_FUNC034_LDS = $(SH2_3D_DIR)/span_filler_short.lds
SH2_FUNC034_BIN = $(BUILD_DIR)/sh2/span_filler_short.bin
SH2_FUNC034_INC = $(SH2_GEN_DIR)/span_filler_short.inc

SH2_FUNC036_SRC = $(SH2_3D_DIR)/render_dispatch_short.asm
SH2_FUNC036_LDS = $(SH2_3D_DIR)/render_dispatch_short.lds
SH2_FUNC036_BIN = $(BUILD_DIR)/sh2/render_dispatch_short.bin
SH2_FUNC036_INC = $(SH2_GEN_DIR)/render_dispatch_short.inc

SH2_FUNC037_038_039_SRC = $(SH2_3D_DIR)/helpers_short.asm
SH2_FUNC037_038_039_LDS = $(SH2_3D_DIR)/helpers_short.lds
SH2_FUNC037_038_039_BIN = $(BUILD_DIR)/sh2/helpers_short.bin
SH2_FUNC037_038_039_INC = $(SH2_GEN_DIR)/helpers_short.inc

SH2_FUNC018_SRC = $(SH2_3D_DIR)/quad_batch_short.asm
SH2_FUNC018_LDS = $(SH2_3D_DIR)/quad_batch_short.lds
SH2_FUNC018_BIN = $(BUILD_DIR)/sh2/quad_batch_short.bin
SH2_FUNC018_INC = $(SH2_GEN_DIR)/quad_batch_short.inc

SH2_FUNC019_SRC = $(SH2_3D_DIR)/quad_batch_alt_short.asm
SH2_FUNC019_LDS = $(SH2_3D_DIR)/quad_batch_alt_short.lds
SH2_FUNC019_BIN = $(BUILD_DIR)/sh2/quad_batch_alt_short.bin
SH2_FUNC019_INC = $(SH2_GEN_DIR)/quad_batch_alt_short.inc

SH2_FUNC020_SRC = $(SH2_3D_DIR)/vertex_helper_short.asm
SH2_FUNC020_LDS = $(SH2_3D_DIR)/vertex_helper_short.lds
SH2_FUNC020_BIN = $(BUILD_DIR)/sh2/vertex_helper_short.bin
SH2_FUNC020_INC = $(SH2_GEN_DIR)/vertex_helper_short.inc

SH2_FUNC021_ORIG_SRC = $(SH2_3D_DIR)/vertex_transform_orig.asm
SH2_FUNC021_ORIG_LDS = $(SH2_3D_DIR)/vertex_transform.lds
SH2_FUNC021_ORIG_BIN = $(BUILD_DIR)/sh2/vertex_transform_orig.bin
SH2_FUNC021_ORIG_INC = $(SH2_GEN_DIR)/vertex_transform_orig.inc

SH2_FUNC023_SRC = $(SH2_3D_DIR)/frustum_cull_short.asm
SH2_FUNC023_LDS = $(SH2_3D_DIR)/frustum_cull_short.lds
SH2_FUNC023_BIN = $(BUILD_DIR)/sh2/frustum_cull_short.bin
SH2_FUNC023_INC = $(SH2_GEN_DIR)/frustum_cull_short.inc

SH2_FUNC040_SRC = $(SH2_3D_DIR)/display_list_short.asm
SH2_FUNC040_LDS = $(SH2_3D_DIR)/display_list_short.lds
SH2_FUNC040_BIN = $(BUILD_DIR)/sh2/display_list_short.bin
SH2_FUNC040_INC = $(SH2_GEN_DIR)/display_list_short.inc

SH2_FUNC040_CASES_SRC = $(SH2_3D_DIR)/display_cases_short.asm
SH2_FUNC040_CASES_LDS = $(SH2_3D_DIR)/display_cases_short.lds
SH2_FUNC040_CASES_BIN = $(BUILD_DIR)/sh2/display_cases_short.bin
SH2_FUNC040_CASES_INC = $(SH2_GEN_DIR)/display_cases_short.inc

SH2_FUNC040_UTIL_SRC = $(SH2_3D_DIR)/display_utility_short.asm
SH2_FUNC040_UTIL_LDS = $(SH2_3D_DIR)/display_utility_short.lds
SH2_FUNC040_UTIL_BIN = $(BUILD_DIR)/sh2/display_utility_short.bin
SH2_FUNC040_UTIL_INC = $(SH2_GEN_DIR)/display_utility_short.inc

SH2_FUNC041_SRC = $(SH2_3D_DIR)/render_coord_short.asm
SH2_FUNC041_LDS = $(SH2_3D_DIR)/render_coord_short.lds
SH2_FUNC041_BIN = $(BUILD_DIR)/sh2/render_coord_short.bin
SH2_FUNC041_INC = $(SH2_GEN_DIR)/render_coord_short.inc

SH2_FUNC042_SRC = $(SH2_3D_DIR)/data_copy_util_short.asm
SH2_FUNC042_LDS = $(SH2_3D_DIR)/data_copy_util_short.lds
SH2_FUNC042_BIN = $(BUILD_DIR)/sh2/data_copy_util_short.bin
SH2_FUNC042_INC = $(SH2_GEN_DIR)/data_copy_util_short.inc

SH2_FUNC043_SRC = $(SH2_3D_DIR)/polygon_batch_short.asm
SH2_FUNC043_LDS = $(SH2_3D_DIR)/polygon_batch_short.lds
SH2_FUNC043_BIN = $(BUILD_DIR)/sh2/polygon_batch_short.bin
SH2_FUNC043_INC = $(SH2_GEN_DIR)/polygon_batch_short.inc

SH2_FUNC044_SRC = $(SH2_3D_DIR)/edge_scan_short.asm
SH2_FUNC044_LDS = $(SH2_3D_DIR)/edge_scan_short.lds
SH2_FUNC044_BIN = $(BUILD_DIR)/sh2/edge_scan_short.bin
SH2_FUNC044_INC = $(SH2_GEN_DIR)/edge_scan_short.inc

SH2_FUNC045_SRC = $(SH2_3D_DIR)/dispatch_loop_short.asm
SH2_FUNC045_LDS = $(SH2_3D_DIR)/dispatch_loop_short.lds
SH2_FUNC045_BIN = $(BUILD_DIR)/sh2/dispatch_loop_short.bin
SH2_FUNC045_INC = $(SH2_GEN_DIR)/dispatch_loop_short.inc

SH2_FUNC046_SRC = $(SH2_3D_DIR)/array_copy_short.asm
SH2_FUNC046_LDS = $(SH2_3D_DIR)/array_copy_short.lds
SH2_FUNC046_BIN = $(BUILD_DIR)/sh2/array_copy_short.bin
SH2_FUNC046_INC = $(SH2_GEN_DIR)/array_copy_short.inc

SH2_FUNC047_SRC = $(SH2_3D_DIR)/bounds_check_short.asm
SH2_FUNC047_LDS = $(SH2_3D_DIR)/bounds_check_short.lds
SH2_FUNC047_BIN = $(BUILD_DIR)/sh2/bounds_check_short.bin
SH2_FUNC047_INC = $(SH2_GEN_DIR)/bounds_check_short.inc

SH2_FUNC048_SRC = $(SH2_3D_DIR)/bounds_handler_short.asm
SH2_FUNC048_LDS = $(SH2_3D_DIR)/bounds_handler_short.lds
SH2_FUNC048_BIN = $(BUILD_DIR)/sh2/bounds_handler_short.bin
SH2_FUNC048_INC = $(SH2_GEN_DIR)/bounds_handler_short.inc

SH2_FUNC049_SRC = $(SH2_3D_DIR)/bounds_entry_short.asm
SH2_FUNC049_LDS = $(SH2_3D_DIR)/bounds_entry_short.lds
SH2_FUNC049_BIN = $(BUILD_DIR)/sh2/bounds_entry_short.bin
SH2_FUNC049_INC = $(SH2_GEN_DIR)/bounds_entry_short.inc

SH2_FUNC050_SRC = $(SH2_3D_DIR)/multi_bsr_short.asm
SH2_FUNC050_LDS = $(SH2_3D_DIR)/multi_bsr_short.lds
SH2_FUNC050_BIN = $(BUILD_DIR)/sh2/multi_bsr_short.bin
SH2_FUNC050_INC = $(SH2_GEN_DIR)/multi_bsr_short.inc

SH2_FUNC051_SRC = $(SH2_3D_DIR)/offset_bsr_short.asm
SH2_FUNC051_LDS = $(SH2_3D_DIR)/offset_bsr_short.lds
SH2_FUNC051_BIN = $(BUILD_DIR)/sh2/offset_bsr_short.bin
SH2_FUNC051_INC = $(SH2_GEN_DIR)/offset_bsr_short.inc

SH2_FUNC052_SRC = $(SH2_3D_DIR)/small_bsr_short.asm
SH2_FUNC052_LDS = $(SH2_3D_DIR)/small_bsr_short.lds
SH2_FUNC052_BIN = $(BUILD_DIR)/sh2/small_bsr_short.bin
SH2_FUNC052_INC = $(SH2_GEN_DIR)/small_bsr_short.inc

SH2_FUNC053_SRC = $(SH2_3D_DIR)/offset_small_short.asm
SH2_FUNC053_LDS = $(SH2_3D_DIR)/offset_small_short.lds
SH2_FUNC053_BIN = $(BUILD_DIR)/sh2/offset_small_short.bin
SH2_FUNC053_INC = $(SH2_GEN_DIR)/offset_small_short.inc

SH2_FUNC054_SRC = $(SH2_3D_DIR)/conditional_bsr_short.asm
SH2_FUNC054_LDS = $(SH2_3D_DIR)/conditional_bsr_short.lds
SH2_FUNC054_BIN = $(BUILD_DIR)/sh2/conditional_bsr_short.bin
SH2_FUNC054_INC = $(SH2_GEN_DIR)/conditional_bsr_short.inc

SH2_FUNC055_SRC = $(SH2_3D_DIR)/unrolled_copy_short.asm
SH2_FUNC055_LDS = $(SH2_3D_DIR)/unrolled_copy_short.lds
SH2_FUNC055_BIN = $(BUILD_DIR)/sh2/unrolled_copy_short.bin
SH2_FUNC055_INC = $(SH2_GEN_DIR)/unrolled_copy_short.inc

# NOTE: func_056 removed - code at $023F2E is already covered by unrolled_data_copy

SH2_FUNC067_SRC = $(SH2_3D_DIR)/rle_entry_alt1_short.asm
SH2_FUNC067_LDS = $(SH2_3D_DIR)/rle_entry_alt1_short.lds
SH2_FUNC067_BIN = $(BUILD_DIR)/sh2/rle_entry_alt1_short.bin
SH2_FUNC067_INC = $(SH2_GEN_DIR)/rle_entry_alt1_short.inc

SH2_FUNC068_SRC = $(SH2_3D_DIR)/rle_entry_alt2_short.asm
SH2_FUNC068_LDS = $(SH2_3D_DIR)/rle_entry_alt2_short.lds
SH2_FUNC068_BIN = $(BUILD_DIR)/sh2/rle_entry_alt2_short.bin
SH2_FUNC068_INC = $(SH2_GEN_DIR)/rle_entry_alt2_short.inc

SH2_FUNC069_SRC = $(SH2_3D_DIR)/block_copy_stride_short.asm
SH2_FUNC069_LDS = $(SH2_3D_DIR)/block_copy_stride_short.lds
SH2_FUNC069_BIN = $(BUILD_DIR)/sh2/block_copy_stride_short.bin
SH2_FUNC069_INC = $(SH2_GEN_DIR)/block_copy_stride_short.inc

SH2_FUNC070_SRC = $(SH2_3D_DIR)/loop_dispatcher_short.asm
SH2_FUNC070_LDS = $(SH2_3D_DIR)/loop_dispatcher_short.lds
SH2_FUNC070_BIN = $(BUILD_DIR)/sh2/loop_dispatcher_short.bin
SH2_FUNC070_INC = $(SH2_GEN_DIR)/loop_dispatcher_short.inc

SH2_FUNC071_SRC = $(SH2_3D_DIR)/context_setup_short.asm
SH2_FUNC071_LDS = $(SH2_3D_DIR)/context_setup_short.lds
SH2_FUNC071_BIN = $(BUILD_DIR)/sh2/context_setup_short.bin
SH2_FUNC071_INC = $(SH2_GEN_DIR)/context_setup_short.inc

SH2_FUNC072_SRC = $(SH2_3D_DIR)/element_processor_short.asm
SH2_FUNC072_LDS = $(SH2_3D_DIR)/element_processor_short.lds
SH2_FUNC072_BIN = $(BUILD_DIR)/sh2/element_processor_short.bin
SH2_FUNC072_INC = $(SH2_GEN_DIR)/element_processor_short.inc

SH2_FUNC073_SRC = $(SH2_3D_DIR)/negative_handler_short.asm
SH2_FUNC073_LDS = $(SH2_3D_DIR)/negative_handler_short.lds
SH2_FUNC073_BIN = $(BUILD_DIR)/sh2/negative_handler_short.bin
SH2_FUNC073_INC = $(SH2_GEN_DIR)/negative_handler_short.inc

SH2_FUNC074_SRC = $(SH2_3D_DIR)/block_copy_14_short.asm
SH2_FUNC074_LDS = $(SH2_3D_DIR)/block_copy_14_short.lds
SH2_FUNC074_BIN = $(BUILD_DIR)/sh2/block_copy_14_short.bin
SH2_FUNC074_INC = $(SH2_GEN_DIR)/block_copy_14_short.inc

SH2_FUNC075_SRC = $(SH2_3D_DIR)/block_iterator_short.asm
SH2_FUNC075_LDS = $(SH2_3D_DIR)/block_iterator_short.lds
SH2_FUNC075_BIN = $(BUILD_DIR)/sh2/block_iterator_short.bin
SH2_FUNC075_INC = $(SH2_GEN_DIR)/block_iterator_short.inc

SH2_FUNC076_SRC = $(SH2_3D_DIR)/vdp_pixel_write_short.asm
SH2_FUNC076_LDS = $(SH2_3D_DIR)/vdp_pixel_write_short.lds
SH2_FUNC076_BIN = $(BUILD_DIR)/sh2/vdp_pixel_write_short.bin
SH2_FUNC076_INC = $(SH2_GEN_DIR)/vdp_pixel_write_short.inc

SH2_FUNC077_SRC = $(SH2_3D_DIR)/value_dispatch_short.asm
SH2_FUNC077_LDS = $(SH2_3D_DIR)/value_dispatch_short.lds
SH2_FUNC077_BIN = $(BUILD_DIR)/sh2/value_dispatch_short.bin
SH2_FUNC077_INC = $(SH2_GEN_DIR)/value_dispatch_short.inc

SH2_FUNC078_SRC = $(SH2_3D_DIR)/negative_fill_short.asm
SH2_FUNC078_LDS = $(SH2_3D_DIR)/negative_fill_short.lds
SH2_FUNC078_BIN = $(BUILD_DIR)/sh2/negative_fill_short.bin
SH2_FUNC078_INC = $(SH2_GEN_DIR)/negative_fill_short.inc

SH2_FUNC079_SRC = $(SH2_3D_DIR)/fill_decrement_short.asm
SH2_FUNC079_LDS = $(SH2_3D_DIR)/fill_decrement_short.lds
SH2_FUNC079_BIN = $(BUILD_DIR)/sh2/fill_decrement_short.bin
SH2_FUNC079_INC = $(SH2_GEN_DIR)/fill_decrement_short.inc

SH2_FUNC080_SRC = $(SH2_3D_DIR)/memory_clear_short.asm
SH2_FUNC080_LDS = $(SH2_3D_DIR)/memory_clear_short.lds
SH2_FUNC080_BIN = $(BUILD_DIR)/sh2/memory_clear_short.bin
SH2_FUNC080_INC = $(SH2_GEN_DIR)/memory_clear_short.inc

SH2_FUNC081_SRC = $(SH2_3D_DIR)/multi_jsr_short.asm
SH2_FUNC081_LDS = $(SH2_3D_DIR)/multi_jsr_short.lds
SH2_FUNC081_BIN = $(BUILD_DIR)/sh2/multi_jsr_short.bin
SH2_FUNC081_INC = $(SH2_GEN_DIR)/multi_jsr_short.inc

SH2_FUNC082_SRC = $(SH2_3D_DIR)/multi_jsr_alt_short.asm
SH2_FUNC082_LDS = $(SH2_3D_DIR)/multi_jsr_alt_short.lds
SH2_FUNC082_BIN = $(BUILD_DIR)/sh2/multi_jsr_alt_short.bin
SH2_FUNC082_INC = $(SH2_GEN_DIR)/multi_jsr_alt_short.inc

SH2_FUNC083_SRC = $(SH2_3D_DIR)/poll_wait_short.asm
SH2_FUNC083_LDS = $(SH2_3D_DIR)/poll_wait_short.lds
SH2_FUNC083_BIN = $(BUILD_DIR)/sh2/poll_wait_short.bin
SH2_FUNC083_INC = $(SH2_GEN_DIR)/poll_wait_short.inc

SH2_FUNC084_SRC = $(SH2_3D_DIR)/hw_init_short.asm
SH2_FUNC084_LDS = $(SH2_3D_DIR)/hw_init_short.lds
SH2_FUNC084_BIN = $(BUILD_DIR)/sh2/hw_init_short.bin
SH2_FUNC084_INC = $(SH2_GEN_DIR)/hw_init_short.inc

SH2_FUNC085_SRC = $(SH2_3D_DIR)/poll_zero_short.asm
SH2_FUNC085_LDS = $(SH2_3D_DIR)/poll_zero_short.lds
SH2_FUNC085_BIN = $(BUILD_DIR)/sh2/poll_zero_short.bin
SH2_FUNC085_INC = $(SH2_GEN_DIR)/poll_zero_short.inc

SH2_FUNC086_SRC = $(SH2_3D_DIR)/clear_reg_short.asm
SH2_FUNC086_LDS = $(SH2_3D_DIR)/clear_reg_short.lds
SH2_FUNC086_BIN = $(BUILD_DIR)/sh2/clear_reg_short.bin
SH2_FUNC086_INC = $(SH2_GEN_DIR)/clear_reg_short.inc

SH2_FUNC087_SRC = $(SH2_3D_DIR)/poll_zero_alt_short.asm
SH2_FUNC087_LDS = $(SH2_3D_DIR)/poll_zero_alt_short.lds
SH2_FUNC087_BIN = $(BUILD_DIR)/sh2/poll_zero_alt_short.bin
SH2_FUNC087_INC = $(SH2_GEN_DIR)/poll_zero_alt_short.inc

SH2_FUNC088_SRC = $(SH2_3D_DIR)/struct_init_short.asm
SH2_FUNC088_LDS = $(SH2_3D_DIR)/struct_init_short.lds
SH2_FUNC088_BIN = $(BUILD_DIR)/sh2/struct_init_short.bin
SH2_FUNC088_INC = $(SH2_GEN_DIR)/struct_init_short.inc

SH2_FUNC089_SRC = $(SH2_3D_DIR)/poll_branch_short.asm
SH2_FUNC089_LDS = $(SH2_3D_DIR)/poll_branch_short.lds
SH2_FUNC089_BIN = $(BUILD_DIR)/sh2/poll_branch_short.bin
SH2_FUNC089_INC = $(SH2_GEN_DIR)/poll_branch_short.inc

SH2_FUNC090_SRC = $(SH2_3D_DIR)/poll_wait_2_short.asm
SH2_FUNC090_LDS = $(SH2_3D_DIR)/poll_wait_2_short.lds
SH2_FUNC090_BIN = $(BUILD_DIR)/sh2/poll_wait_2_short.bin
SH2_FUNC090_INC = $(SH2_GEN_DIR)/poll_wait_2_short.inc

SH2_FUNC091_SRC = $(SH2_3D_DIR)/poll_copy_short.asm
SH2_FUNC091_LDS = $(SH2_3D_DIR)/poll_copy_short.lds
SH2_FUNC091_BIN = $(BUILD_DIR)/sh2/poll_copy_short.bin
SH2_FUNC091_INC = $(SH2_GEN_DIR)/poll_copy_short.inc

SH2_FUNC005_SRC = $(SH2_3D_DIR)/transform_loop.asm
SH2_FUNC005_LDS = $(SH2_3D_DIR)/transform_loop.lds
SH2_FUNC005_BIN = $(BUILD_DIR)/sh2/transform_loop.bin
SH2_FUNC005_INC = $(SH2_GEN_DIR)/transform_loop.inc

SH2_FUNC007_SRC = $(SH2_3D_DIR)/alt_transform_loop.asm
SH2_FUNC007_LDS = $(SH2_3D_DIR)/alt_transform_loop.lds
SH2_FUNC007_BIN = $(BUILD_DIR)/sh2/alt_transform_loop.bin
SH2_FUNC007_INC = $(SH2_GEN_DIR)/alt_transform_loop.inc

SH2_FUNC006_SRC = $(SH2_3D_DIR)/matrix_multiply.asm
SH2_FUNC006_BIN = $(BUILD_DIR)/sh2/matrix_multiply.bin
SH2_FUNC006_INC = $(SH2_GEN_DIR)/matrix_multiply.inc

SH2_FUNC008_SRC = $(SH2_3D_DIR)/alt_matrix_multiply.asm
SH2_FUNC008_BIN = $(BUILD_DIR)/sh2/alt_matrix_multiply.bin
SH2_FUNC008_INC = $(SH2_GEN_DIR)/alt_matrix_multiply.inc

SH2_FUNC016_SRC = $(SH2_3D_DIR)/coord_transform.asm
SH2_FUNC016_BIN = $(BUILD_DIR)/sh2/coord_transform.bin
SH2_FUNC016_INC = $(SH2_GEN_DIR)/coord_transform.inc

SH2_FUNC009_SRC = $(SH2_3D_DIR)/display_list_4elem.asm
SH2_FUNC009_BIN = $(BUILD_DIR)/sh2/display_list_4elem.bin
SH2_FUNC009_INC = $(SH2_GEN_DIR)/display_list_4elem.inc

SH2_FUNC010_SRC = $(SH2_3D_DIR)/display_list_3elem.asm
SH2_FUNC010_BIN = $(BUILD_DIR)/sh2/display_list_3elem.bin
SH2_FUNC010_INC = $(SH2_GEN_DIR)/display_list_3elem.inc

SH2_FUNC065_SRC = $(SH2_3D_DIR)/unrolled_data_copy.asm
SH2_FUNC065_BIN = $(BUILD_DIR)/sh2/unrolled_data_copy.bin
SH2_FUNC065_INC = $(SH2_GEN_DIR)/unrolled_data_copy.inc

SH2_FUNC066_SRC = $(SH2_3D_DIR)/rle_decoder.asm
SH2_FUNC066_BIN = $(BUILD_DIR)/sh2/rle_decoder.bin
SH2_FUNC066_INC = $(SH2_GEN_DIR)/rle_decoder.inc

# Expansion ROM functions (for Slave offloading)
SH2_EXP_DIR = $(SH2_SRC_DIR)/expansion
SH2_FUNC021_OPT_SRC = $(SH2_EXP_DIR)/vertex_transform_optimized.asm
SH2_FUNC021_OPT_BIN = $(BUILD_DIR)/sh2/vertex_transform_optimized.bin
SH2_FUNC021_OPT_INC = $(SH2_GEN_DIR)/vertex_transform_optimized.inc

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

# general_queue_drain (Phase 3 - General command async queue processor)
SH2_GEN_DRAIN_SRC = $(SH2_EXP_DIR)/general_queue_drain.asm
SH2_GEN_DRAIN_BIN = $(BUILD_DIR)/sh2/general_queue_drain.bin
SH2_GEN_DRAIN_INC = $(SH2_GEN_DIR)/general_queue_drain.inc

# slave_comm7_idle_check (COMM7 doorbell handler for Slave idle loop)
SH2_COMM7_CHECK_SRC = $(SH2_EXP_DIR)/slave_comm7_idle_check.asm
SH2_COMM7_CHECK_BIN = $(BUILD_DIR)/sh2/slave_comm7_idle_check.bin
SH2_COMM7_CHECK_INC = $(SH2_GEN_DIR)/slave_comm7_idle_check.inc

# cmd22_single_shot (B-004 single-shot 2D block copy handler)
SH2_CMD22_SINGLE_SHOT_SRC = $(SH2_EXP_DIR)/cmd22_single_shot.asm
SH2_CMD22_SINGLE_SHOT_BIN = $(BUILD_DIR)/sh2/cmd22_single_shot.bin
SH2_CMD22_SINGLE_SHOT_INC = $(SH2_GEN_DIR)/cmd22_single_shot.inc

# cmd25_single_shot (B-005 single-shot decompression handler)
SH2_CMD25_SINGLE_SHOT_SRC = $(SH2_EXP_DIR)/cmd25_single_shot.asm
SH2_CMD25_SINGLE_SHOT_BIN = $(BUILD_DIR)/sh2/cmd25_single_shot.bin
SH2_CMD25_SINGLE_SHOT_INC = $(SH2_GEN_DIR)/cmd25_single_shot.inc

.PHONY: sh2-assembly sh2-verify

# Build all SH2 assembly sources
sh2-assembly: dirs $(SH2_FUNC000_INC) $(SH2_FUNC022_INC) $(SH2_FUNC017_INC) $(SH2_FUNC018_INC) $(SH2_FUNC019_INC) $(SH2_FUNC020_INC) $(SH2_FUNC021_ORIG_INC) $(SH2_FUNC023_INC) $(SH2_FUNC040_INC) $(SH2_FUNC040_CASES_INC) $(SH2_FUNC040_UTIL_INC) $(SH2_FUNC041_INC) $(SH2_FUNC042_INC) $(SH2_FUNC043_INC) $(SH2_FUNC044_INC) $(SH2_FUNC045_INC) $(SH2_FUNC046_INC) $(SH2_FUNC047_INC) $(SH2_FUNC048_INC) $(SH2_FUNC049_INC) $(SH2_FUNC050_INC) $(SH2_FUNC051_INC) $(SH2_FUNC052_INC) $(SH2_FUNC053_INC) $(SH2_FUNC054_INC) $(SH2_FUNC055_INC) $(SH2_FUNC067_INC) $(SH2_FUNC068_INC) $(SH2_FUNC069_INC) $(SH2_FUNC070_INC) $(SH2_FUNC071_INC) $(SH2_FUNC072_INC) $(SH2_FUNC073_INC) $(SH2_FUNC074_INC) $(SH2_FUNC075_INC) $(SH2_FUNC076_INC) $(SH2_FUNC077_INC) $(SH2_FUNC078_INC) $(SH2_FUNC079_INC) $(SH2_FUNC080_INC) $(SH2_FUNC081_INC) $(SH2_FUNC082_INC) $(SH2_FUNC083_INC) $(SH2_FUNC084_INC) $(SH2_FUNC085_INC) $(SH2_FUNC086_INC) $(SH2_FUNC087_INC) $(SH2_FUNC088_INC) $(SH2_FUNC089_INC) $(SH2_FUNC090_INC) $(SH2_FUNC091_INC) $(SH2_FUNC032_INC) $(SH2_FUNC011_INC) $(SH2_FUNC012_INC) $(SH2_FUNC013_INC) $(SH2_FUNC014_015_INC) $(SH2_FUNC024_INC) $(SH2_FUNC025_INC) $(SH2_FUNC026_INC) $(SH2_FUNC001_INC) $(SH2_FUNC002_INC) $(SH2_FUNC003_004_INC) $(SH2_FUNC029_030_031_INC) $(SH2_FUNC033_INC) $(SH2_FUNC034_INC) $(SH2_FUNC036_INC) $(SH2_FUNC037_038_039_INC) $(SH2_FUNC005_INC) $(SH2_FUNC007_INC) $(SH2_FUNC006_INC) $(SH2_FUNC008_INC) $(SH2_FUNC016_INC) $(SH2_FUNC009_INC) $(SH2_FUNC010_INC) $(SH2_FUNC065_INC) $(SH2_FUNC066_INC) $(SH2_FUNC021_OPT_INC) $(SH2_BATCH_COPY_INC) $(SH2_CMD27_DRAIN_INC) $(SH2_SLAVE_WRAPPER_V2_INC) $(SH2_HANDLER_FRAME_SYNC_INC) $(SH2_MASTER_DISPATCH_HOOK_INC) $(SH2_SLAVE_TEST_FUNC_INC) $(SH2_SHADOW_PATH_WRAPPER_INC) $(SH2_CMDINT_HANDLER_INC) $(SH2_QUEUE_PROCESSOR_INC) $(SH2_COMM7_CHECK_INC) $(SH2_GEN_DRAIN_INC) $(SH2_CMD22_SINGLE_SHOT_INC) $(SH2_CMD25_SINGLE_SHOT_INC)

# Build data_copy binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC000_BIN): $(SH2_FUNC000_SRC) $(SH2_FUNC000_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: data_copy (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/data_copy.o $<
	$(SH2_LD) -T $(SH2_FUNC000_LDS) -o $(BUILD_DIR)/sh2/data_copy.elf $(BUILD_DIR)/sh2/data_copy.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/data_copy.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 26)"

$(SH2_FUNC000_INC): $(SH2_FUNC000_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: data_copy.inc..."
	@echo "; Auto-generated from $(SH2_FUNC000_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build wait_ready binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC022_BIN): $(SH2_FUNC022_SRC) $(SH2_FUNC022_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: wait_ready (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/wait_ready.o $<
	$(SH2_LD) -T $(SH2_FUNC022_LDS) -o $(BUILD_DIR)/sh2/wait_ready.elf $(BUILD_DIR)/sh2/wait_ready.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/wait_ready.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 26)"

$(SH2_FUNC022_INC): $(SH2_FUNC022_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: wait_ready.inc..."
	@echo "; Auto-generated from $(SH2_FUNC022_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build quad_helper binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC017_BIN): $(SH2_FUNC017_SRC) $(SH2_FUNC017_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: quad_helper (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/quad_helper.o $<
	$(SH2_LD) -T $(SH2_FUNC017_LDS) -o $(BUILD_DIR)/sh2/quad_helper.elf $(BUILD_DIR)/sh2/quad_helper.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/quad_helper.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 26)"

$(SH2_FUNC017_INC): $(SH2_FUNC017_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: quad_helper.inc..."
	@echo "; Auto-generated from $(SH2_FUNC017_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build scanline_setup binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC032_BIN): $(SH2_FUNC032_SRC) $(SH2_FUNC032_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: scanline_setup (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/scanline_setup.o $<
	$(SH2_LD) -T $(SH2_FUNC032_LDS) -o $(BUILD_DIR)/sh2/scanline_setup.elf $(BUILD_DIR)/sh2/scanline_setup.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/scanline_setup.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 32)"

$(SH2_FUNC032_INC): $(SH2_FUNC032_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: scanline_setup.inc..."
	@echo "; Auto-generated from $(SH2_FUNC032_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build display_list_loop binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC011_BIN): $(SH2_FUNC011_SRC) $(SH2_FUNC011_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: display_list_loop (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/display_list_loop.o $<
	$(SH2_LD) -T $(SH2_FUNC011_LDS) -o $(BUILD_DIR)/sh2/display_list_loop.elf $(BUILD_DIR)/sh2/display_list_loop.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/display_list_loop.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 84)"

$(SH2_FUNC011_INC): $(SH2_FUNC011_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: display_list_loop.inc..."
	@echo "; Auto-generated from $(SH2_FUNC011_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build display_entry binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC012_BIN): $(SH2_FUNC012_SRC) $(SH2_FUNC012_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: display_entry (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/display_entry.o $<
	$(SH2_LD) -T $(SH2_FUNC012_LDS) -o $(BUILD_DIR)/sh2/display_entry.elf $(BUILD_DIR)/sh2/display_entry.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/display_entry.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 92)"

$(SH2_FUNC012_INC): $(SH2_FUNC012_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: display_entry.inc..."
	@echo "; Auto-generated from $(SH2_FUNC012_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build vdp_init_short binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC013_BIN): $(SH2_FUNC013_SRC) $(SH2_FUNC013_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: vdp_init_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/vdp_init_short.o $<
	$(SH2_LD) -T $(SH2_FUNC013_LDS) -o $(BUILD_DIR)/sh2/vdp_init_short.elf $(BUILD_DIR)/sh2/vdp_init_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/vdp_init_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 92)"

$(SH2_FUNC013_INC): $(SH2_FUNC013_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: vdp_init_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC013_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build vdp_copy_short binary from source (requires linker script for PC-relative addressing)
# VDP data copy utilities (56 bytes)
$(SH2_FUNC014_015_BIN): $(SH2_FUNC014_015_SRC) $(SH2_FUNC014_015_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: vdp_copy_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/vdp_copy_short.o $<
	$(SH2_LD) -T $(SH2_FUNC014_015_LDS) -o $(BUILD_DIR)/sh2/vdp_copy_short.elf $(BUILD_DIR)/sh2/vdp_copy_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/vdp_copy_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 56)"

$(SH2_FUNC014_015_INC): $(SH2_FUNC014_015_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: vdp_copy_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC014_015_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build screen_coords_short binary from source (requires linker script for PC-relative addressing)
# Screen coordinate calculator (62 bytes)
$(SH2_FUNC024_BIN): $(SH2_FUNC024_SRC) $(SH2_FUNC024_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: screen_coords_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/screen_coords_short.o $<
	$(SH2_LD) -T $(SH2_FUNC024_LDS) -o $(BUILD_DIR)/sh2/screen_coords_short.elf $(BUILD_DIR)/sh2/screen_coords_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/screen_coords_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 62)"

$(SH2_FUNC024_INC): $(SH2_FUNC024_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: screen_coords_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC024_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build coord_offset_short binary from source (requires linker script for PC-relative addressing)
# Coordinate offset calculator (16 bytes)
$(SH2_FUNC025_BIN): $(SH2_FUNC025_SRC) $(SH2_FUNC025_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: coord_offset_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/coord_offset_short.o $<
	$(SH2_LD) -T $(SH2_FUNC025_LDS) -o $(BUILD_DIR)/sh2/coord_offset_short.elf $(BUILD_DIR)/sh2/coord_offset_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/coord_offset_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 16)"

$(SH2_FUNC025_INC): $(SH2_FUNC025_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: coord_offset_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC025_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build bounds_compare_short binary from source (requires linker script for PC-relative addressing)
# Includes func_027 and func_028 (shared exit paths)
$(SH2_FUNC026_BIN): $(SH2_FUNC026_SRC) $(SH2_FUNC026_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: bounds_compare_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/bounds_compare_short.o $<
	$(SH2_LD) -T $(SH2_FUNC026_LDS) -o $(BUILD_DIR)/sh2/bounds_compare_short.elf $(BUILD_DIR)/sh2/bounds_compare_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/bounds_compare_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 68)"

$(SH2_FUNC026_INC): $(SH2_FUNC026_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: bounds_compare_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC026_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build main_coordinator_short binary from source (main coordinator / switch dispatcher)
$(SH2_FUNC001_BIN): $(SH2_FUNC001_SRC) $(SH2_FUNC001_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: main_coordinator_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/main_coordinator_short.o $<
	$(SH2_LD) -T $(SH2_FUNC001_LDS) -o $(BUILD_DIR)/sh2/main_coordinator_short.elf $(BUILD_DIR)/sh2/main_coordinator_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/main_coordinator_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 76)"

$(SH2_FUNC001_INC): $(SH2_FUNC001_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: main_coordinator_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC001_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build case_handlers_short binary from source (case handlers block)
$(SH2_FUNC002_BIN): $(SH2_FUNC002_SRC) $(SH2_FUNC002_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: case_handlers_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/case_handlers_short.o $<
	$(SH2_LD) -T $(SH2_FUNC002_LDS) -o $(BUILD_DIR)/sh2/case_handlers_short.elf $(BUILD_DIR)/sh2/case_handlers_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/case_handlers_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 88)"

$(SH2_FUNC002_INC): $(SH2_FUNC002_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: case_handlers_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC002_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build offset_copy_short binary from source (requires linker script for PC-relative addressing)
# Includes case_handlers_short exit paths, func_003, and func_004
$(SH2_FUNC003_004_BIN): $(SH2_FUNC003_004_SRC) $(SH2_FUNC003_004_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: offset_copy_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/offset_copy_short.o $<
	$(SH2_LD) -T $(SH2_FUNC003_004_LDS) -o $(BUILD_DIR)/sh2/offset_copy_short.elf $(BUILD_DIR)/sh2/offset_copy_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/offset_copy_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 32)"

$(SH2_FUNC003_004_INC): $(SH2_FUNC003_004_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: offset_copy_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC003_004_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build visibility_short binary from source (requires linker script for PC-relative addressing)
# Includes func_029 (visibility), func_030 and func_031 (shared exit paths)
$(SH2_FUNC029_030_031_BIN): $(SH2_FUNC029_030_031_SRC) $(SH2_FUNC029_030_031_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: visibility_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/visibility_short.o $<
	$(SH2_LD) -T $(SH2_FUNC029_030_031_LDS) -o $(BUILD_DIR)/sh2/visibility_short.elf $(BUILD_DIR)/sh2/visibility_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/visibility_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 82)"

$(SH2_FUNC029_030_031_INC): $(SH2_FUNC029_030_031_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: visibility_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC029_030_031_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build render_quad_short binary from source (requires linker script for PC-relative addressing)
# Quad rendering / edge walking (98 bytes)
$(SH2_FUNC033_BIN): $(SH2_FUNC033_SRC) $(SH2_FUNC033_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: render_quad_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/render_quad_short.o $<
	$(SH2_LD) -T $(SH2_FUNC033_LDS) -o $(BUILD_DIR)/sh2/render_quad_short.elf $(BUILD_DIR)/sh2/render_quad_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/render_quad_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 98)"

$(SH2_FUNC033_INC): $(SH2_FUNC033_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: render_quad_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC033_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build span_filler_short binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC034_BIN): $(SH2_FUNC034_SRC) $(SH2_FUNC034_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: span_filler_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/span_filler_short.o $<
	$(SH2_LD) -T $(SH2_FUNC034_LDS) -o $(BUILD_DIR)/sh2/span_filler_short.elf $(BUILD_DIR)/sh2/span_filler_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/span_filler_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 122)"

$(SH2_FUNC034_INC): $(SH2_FUNC034_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: span_filler_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC034_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build render_dispatch_short binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC036_BIN): $(SH2_FUNC036_SRC) $(SH2_FUNC036_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: render_dispatch_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/render_dispatch_short.o $<
	$(SH2_LD) -T $(SH2_FUNC036_LDS) -o $(BUILD_DIR)/sh2/render_dispatch_short.elf $(BUILD_DIR)/sh2/render_dispatch_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/render_dispatch_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 72)"

$(SH2_FUNC036_INC): $(SH2_FUNC036_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: render_dispatch_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC036_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build helpers_short binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC037_038_039_BIN): $(SH2_FUNC037_038_039_SRC) $(SH2_FUNC037_038_039_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: helpers_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/helpers_short.o $<
	$(SH2_LD) -T $(SH2_FUNC037_038_039_LDS) -o $(BUILD_DIR)/sh2/helpers_short.elf $(BUILD_DIR)/sh2/helpers_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/helpers_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 64)"

$(SH2_FUNC037_038_039_INC): $(SH2_FUNC037_038_039_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: helpers_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC037_038_039_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build quad_batch_short binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC018_BIN): $(SH2_FUNC018_SRC) $(SH2_FUNC018_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: quad_batch_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/quad_batch_short.o $<
	$(SH2_LD) -T $(SH2_FUNC018_LDS) -o $(BUILD_DIR)/sh2/quad_batch_short.elf $(BUILD_DIR)/sh2/quad_batch_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/quad_batch_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 112)"

$(SH2_FUNC018_INC): $(SH2_FUNC018_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: quad_batch_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC018_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build quad_batch_alt_short binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC019_BIN): $(SH2_FUNC019_SRC) $(SH2_FUNC019_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: quad_batch_alt_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/quad_batch_alt_short.o $<
	$(SH2_LD) -T $(SH2_FUNC019_LDS) -o $(BUILD_DIR)/sh2/quad_batch_alt_short.elf $(BUILD_DIR)/sh2/quad_batch_alt_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/quad_batch_alt_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 140)"

$(SH2_FUNC019_INC): $(SH2_FUNC019_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: quad_batch_alt_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC019_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build vertex_helper_short binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC020_BIN): $(SH2_FUNC020_SRC) $(SH2_FUNC020_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: vertex_helper_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/vertex_helper_short.o $<
	$(SH2_LD) -T $(SH2_FUNC020_LDS) -o $(BUILD_DIR)/sh2/vertex_helper_short.elf $(BUILD_DIR)/sh2/vertex_helper_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/vertex_helper_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 40)"

$(SH2_FUNC020_INC): $(SH2_FUNC020_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: vertex_helper_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC020_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build vertex_transform_orig binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC021_ORIG_BIN): $(SH2_FUNC021_ORIG_SRC) $(SH2_FUNC021_ORIG_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: vertex_transform_orig (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/vertex_transform_orig.o $<
	$(SH2_LD) -T $(SH2_FUNC021_ORIG_LDS) -o $(BUILD_DIR)/sh2/vertex_transform_orig.elf $(BUILD_DIR)/sh2/vertex_transform_orig.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/vertex_transform_orig.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 38)"

$(SH2_FUNC021_ORIG_INC): $(SH2_FUNC021_ORIG_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: vertex_transform_orig.inc..."
	@echo "; Auto-generated from $(SH2_FUNC021_ORIG_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build frustum_cull_short binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC023_BIN): $(SH2_FUNC023_SRC) $(SH2_FUNC023_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: frustum_cull_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/frustum_cull_short.o $<
	$(SH2_LD) -T $(SH2_FUNC023_LDS) -o $(BUILD_DIR)/sh2/frustum_cull_short.elf $(BUILD_DIR)/sh2/frustum_cull_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/frustum_cull_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 238)"

$(SH2_FUNC023_INC): $(SH2_FUNC023_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: frustum_cull_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC023_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build display_list_short binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC040_BIN): $(SH2_FUNC040_SRC) $(SH2_FUNC040_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: display_list_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/display_list_short.o $<
	$(SH2_LD) -T $(SH2_FUNC040_LDS) -o $(BUILD_DIR)/sh2/display_list_short.elf $(BUILD_DIR)/sh2/display_list_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/display_list_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 122)"

$(SH2_FUNC040_INC): $(SH2_FUNC040_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: display_list_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC040_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build display_cases_short binary from source (requires linker script)
$(SH2_FUNC040_CASES_BIN): $(SH2_FUNC040_CASES_SRC) $(SH2_FUNC040_CASES_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: display_cases_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/display_cases_short.o $<
	$(SH2_LD) -T $(SH2_FUNC040_CASES_LDS) -o $(BUILD_DIR)/sh2/display_cases_short.elf $(BUILD_DIR)/sh2/display_cases_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/display_cases_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 212)"

$(SH2_FUNC040_CASES_INC): $(SH2_FUNC040_CASES_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: display_cases_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC040_CASES_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build display_utility_short binary from source (requires linker script)
$(SH2_FUNC040_UTIL_BIN): $(SH2_FUNC040_UTIL_SRC) $(SH2_FUNC040_UTIL_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: display_utility_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/display_utility_short.o $<
	$(SH2_LD) -T $(SH2_FUNC040_UTIL_LDS) -o $(BUILD_DIR)/sh2/display_utility_short.elf $(BUILD_DIR)/sh2/display_utility_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/display_utility_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 28)"

$(SH2_FUNC040_UTIL_INC): $(SH2_FUNC040_UTIL_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: display_utility_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC040_UTIL_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build render_coord_short binary from source (requires linker script)
$(SH2_FUNC041_BIN): $(SH2_FUNC041_SRC) $(SH2_FUNC041_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: render_coord_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/render_coord_short.o $<
	$(SH2_LD) -T $(SH2_FUNC041_LDS) -o $(BUILD_DIR)/sh2/render_coord_short.elf $(BUILD_DIR)/sh2/render_coord_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/render_coord_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 98)"

$(SH2_FUNC041_INC): $(SH2_FUNC041_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: render_coord_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC041_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build data_copy_util_short binary from source (requires linker script)
$(SH2_FUNC042_BIN): $(SH2_FUNC042_SRC) $(SH2_FUNC042_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: data_copy_util_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/data_copy_util_short.o $<
	$(SH2_LD) -T $(SH2_FUNC042_LDS) -o $(BUILD_DIR)/sh2/data_copy_util_short.elf $(BUILD_DIR)/sh2/data_copy_util_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/data_copy_util_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 20)"

$(SH2_FUNC042_INC): $(SH2_FUNC042_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: data_copy_util_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC042_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build polygon_batch_short binary from source (requires linker script)
$(SH2_FUNC043_BIN): $(SH2_FUNC043_SRC) $(SH2_FUNC043_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: polygon_batch_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/polygon_batch_short.o $<
	$(SH2_LD) -T $(SH2_FUNC043_LDS) -o $(BUILD_DIR)/sh2/polygon_batch_short.elf $(BUILD_DIR)/sh2/polygon_batch_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/polygon_batch_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 312)"

$(SH2_FUNC043_INC): $(SH2_FUNC043_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: polygon_batch_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC043_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build edge_scan_short binary from source (requires linker script)
$(SH2_FUNC044_BIN): $(SH2_FUNC044_SRC) $(SH2_FUNC044_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: edge_scan_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/edge_scan_short.o $<
	$(SH2_LD) -T $(SH2_FUNC044_LDS) -o $(BUILD_DIR)/sh2/edge_scan_short.elf $(BUILD_DIR)/sh2/edge_scan_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/edge_scan_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 268)"

$(SH2_FUNC044_INC): $(SH2_FUNC044_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: edge_scan_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC044_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build dispatch_loop_short binary from source (requires linker script)
$(SH2_FUNC045_BIN): $(SH2_FUNC045_SRC) $(SH2_FUNC045_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: dispatch_loop_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/dispatch_loop_short.o $<
	$(SH2_LD) -T $(SH2_FUNC045_LDS) -o $(BUILD_DIR)/sh2/dispatch_loop_short.elf $(BUILD_DIR)/sh2/dispatch_loop_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/dispatch_loop_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 68)"

$(SH2_FUNC045_INC): $(SH2_FUNC045_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: dispatch_loop_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC045_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build array_copy_short binary from source (requires linker script)
$(SH2_FUNC046_BIN): $(SH2_FUNC046_SRC) $(SH2_FUNC046_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: array_copy_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/array_copy_short.o $<
	$(SH2_LD) -T $(SH2_FUNC046_LDS) -o $(BUILD_DIR)/sh2/array_copy_short.elf $(BUILD_DIR)/sh2/array_copy_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/array_copy_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 36)"

$(SH2_FUNC046_INC): $(SH2_FUNC046_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: array_copy_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC046_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build bounds_check_short binary from source (requires linker script)
$(SH2_FUNC047_BIN): $(SH2_FUNC047_SRC) $(SH2_FUNC047_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: bounds_check_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/bounds_check_short.o $<
	$(SH2_LD) -T $(SH2_FUNC047_LDS) -o $(BUILD_DIR)/sh2/bounds_check_short.elf $(BUILD_DIR)/sh2/bounds_check_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/bounds_check_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 26)"

$(SH2_FUNC047_INC): $(SH2_FUNC047_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: bounds_check_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC047_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build bounds_handler_short binary from source (requires linker script)
$(SH2_FUNC048_BIN): $(SH2_FUNC048_SRC) $(SH2_FUNC048_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: bounds_handler_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/bounds_handler_short.o $<
	$(SH2_LD) -T $(SH2_FUNC048_LDS) -o $(BUILD_DIR)/sh2/bounds_handler_short.elf $(BUILD_DIR)/sh2/bounds_handler_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/bounds_handler_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 22)"

$(SH2_FUNC048_INC): $(SH2_FUNC048_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: bounds_handler_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC048_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build bounds_entry_short binary from source (requires linker script)
$(SH2_FUNC049_BIN): $(SH2_FUNC049_SRC) $(SH2_FUNC049_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: bounds_entry_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/bounds_entry_short.o $<
	$(SH2_LD) -T $(SH2_FUNC049_LDS) -o $(BUILD_DIR)/sh2/bounds_entry_short.elf $(BUILD_DIR)/sh2/bounds_entry_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/bounds_entry_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 26)"

$(SH2_FUNC049_INC): $(SH2_FUNC049_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: bounds_entry_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC049_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build multi_bsr_short binary from source (requires linker script)
$(SH2_FUNC050_BIN): $(SH2_FUNC050_SRC) $(SH2_FUNC050_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: multi_bsr_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/multi_bsr_short.o $<
	$(SH2_LD) -T $(SH2_FUNC050_LDS) -o $(BUILD_DIR)/sh2/multi_bsr_short.elf $(BUILD_DIR)/sh2/multi_bsr_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/multi_bsr_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 88)"

$(SH2_FUNC050_INC): $(SH2_FUNC050_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: multi_bsr_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC050_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build offset_bsr_short binary from source (requires linker script)
$(SH2_FUNC051_BIN): $(SH2_FUNC051_SRC) $(SH2_FUNC051_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: offset_bsr_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/offset_bsr_short.o $<
	$(SH2_LD) -T $(SH2_FUNC051_LDS) -o $(BUILD_DIR)/sh2/offset_bsr_short.elf $(BUILD_DIR)/sh2/offset_bsr_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/offset_bsr_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 92)"

$(SH2_FUNC051_INC): $(SH2_FUNC051_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: offset_bsr_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC051_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build small_bsr_short binary from source (requires linker script)
$(SH2_FUNC052_BIN): $(SH2_FUNC052_SRC) $(SH2_FUNC052_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: small_bsr_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/small_bsr_short.o $<
	$(SH2_LD) -T $(SH2_FUNC052_LDS) -o $(BUILD_DIR)/sh2/small_bsr_short.elf $(BUILD_DIR)/sh2/small_bsr_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/small_bsr_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 22)"

$(SH2_FUNC052_INC): $(SH2_FUNC052_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: small_bsr_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC052_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build offset_small_short binary from source (requires linker script)
$(SH2_FUNC053_BIN): $(SH2_FUNC053_SRC) $(SH2_FUNC053_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: offset_small_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/offset_small_short.o $<
	$(SH2_LD) -T $(SH2_FUNC053_LDS) -o $(BUILD_DIR)/sh2/offset_small_short.elf $(BUILD_DIR)/sh2/offset_small_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/offset_small_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 38)"

$(SH2_FUNC053_INC): $(SH2_FUNC053_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: offset_small_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC053_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build conditional_bsr_short binary from source (requires linker script)
$(SH2_FUNC054_BIN): $(SH2_FUNC054_SRC) $(SH2_FUNC054_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: conditional_bsr_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/conditional_bsr_short.o $<
	$(SH2_LD) -T $(SH2_FUNC054_LDS) -o $(BUILD_DIR)/sh2/conditional_bsr_short.elf $(BUILD_DIR)/sh2/conditional_bsr_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/conditional_bsr_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 56)"

$(SH2_FUNC054_INC): $(SH2_FUNC054_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: conditional_bsr_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC054_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build unrolled_copy_short binary from source (requires linker script)
$(SH2_FUNC055_BIN): $(SH2_FUNC055_SRC) $(SH2_FUNC055_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: unrolled_copy_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/unrolled_copy_short.o $<
	$(SH2_LD) -T $(SH2_FUNC055_LDS) -o $(BUILD_DIR)/sh2/unrolled_copy_short.elf $(BUILD_DIR)/sh2/unrolled_copy_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/unrolled_copy_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 92)"

$(SH2_FUNC055_INC): $(SH2_FUNC055_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: unrolled_copy_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC055_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build rle_entry_alt1_short binary from source (requires linker script)
$(SH2_FUNC067_BIN): $(SH2_FUNC067_SRC) $(SH2_FUNC067_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: rle_entry_alt1_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/rle_entry_alt1_short.o $<
	$(SH2_LD) -T $(SH2_FUNC067_LDS) -o $(BUILD_DIR)/sh2/rle_entry_alt1_short.elf $(BUILD_DIR)/sh2/rle_entry_alt1_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/rle_entry_alt1_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 14)"

$(SH2_FUNC067_INC): $(SH2_FUNC067_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: rle_entry_alt1_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC067_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build rle_entry_alt2_short binary from source (requires linker script)
$(SH2_FUNC068_BIN): $(SH2_FUNC068_SRC) $(SH2_FUNC068_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: rle_entry_alt2_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/rle_entry_alt2_short.o $<
	$(SH2_LD) -T $(SH2_FUNC068_LDS) -o $(BUILD_DIR)/sh2/rle_entry_alt2_short.elf $(BUILD_DIR)/sh2/rle_entry_alt2_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/rle_entry_alt2_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 12)"

$(SH2_FUNC068_INC): $(SH2_FUNC068_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: rle_entry_alt2_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC068_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build block_copy_stride_short binary from source (requires linker script)
$(SH2_FUNC069_BIN): $(SH2_FUNC069_SRC) $(SH2_FUNC069_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: block_copy_stride_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/block_copy_stride_short.o $<
	$(SH2_LD) -T $(SH2_FUNC069_LDS) -o $(BUILD_DIR)/sh2/block_copy_stride_short.elf $(BUILD_DIR)/sh2/block_copy_stride_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/block_copy_stride_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 76)"

$(SH2_FUNC069_INC): $(SH2_FUNC069_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: block_copy_stride_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC069_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build loop_dispatcher_short binary from source (requires linker script)
$(SH2_FUNC070_BIN): $(SH2_FUNC070_SRC) $(SH2_FUNC070_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: loop_dispatcher_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/loop_dispatcher_short.o $<
	$(SH2_LD) -T $(SH2_FUNC070_LDS) -o $(BUILD_DIR)/sh2/loop_dispatcher_short.elf $(BUILD_DIR)/sh2/loop_dispatcher_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/loop_dispatcher_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 36)"

$(SH2_FUNC070_INC): $(SH2_FUNC070_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: loop_dispatcher_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC070_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build context_setup_short binary from source (requires linker script)
$(SH2_FUNC071_BIN): $(SH2_FUNC071_SRC) $(SH2_FUNC071_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: context_setup_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/context_setup_short.o $<
	$(SH2_LD) -T $(SH2_FUNC071_LDS) -o $(BUILD_DIR)/sh2/context_setup_short.elf $(BUILD_DIR)/sh2/context_setup_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/context_setup_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 122)"

$(SH2_FUNC071_INC): $(SH2_FUNC071_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: context_setup_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC071_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build element_processor_short binary from source (requires linker script)
$(SH2_FUNC072_BIN): $(SH2_FUNC072_SRC) $(SH2_FUNC072_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: element_processor_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/element_processor_short.o $<
	$(SH2_LD) -T $(SH2_FUNC072_LDS) -o $(BUILD_DIR)/sh2/element_processor_short.elf $(BUILD_DIR)/sh2/element_processor_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/element_processor_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 42)"

$(SH2_FUNC072_INC): $(SH2_FUNC072_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: element_processor_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC072_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build negative_handler_short binary from source (requires linker script)
$(SH2_FUNC073_BIN): $(SH2_FUNC073_SRC) $(SH2_FUNC073_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: negative_handler_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/negative_handler_short.o $<
	$(SH2_LD) -T $(SH2_FUNC073_LDS) -o $(BUILD_DIR)/sh2/negative_handler_short.elf $(BUILD_DIR)/sh2/negative_handler_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/negative_handler_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 16)"

$(SH2_FUNC073_INC): $(SH2_FUNC073_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: negative_handler_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC073_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build block_copy_14_short binary from source (requires linker script)
$(SH2_FUNC074_BIN): $(SH2_FUNC074_SRC) $(SH2_FUNC074_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: block_copy_14_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/block_copy_14_short.o $<
	$(SH2_LD) -T $(SH2_FUNC074_LDS) -o $(BUILD_DIR)/sh2/block_copy_14_short.elf $(BUILD_DIR)/sh2/block_copy_14_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/block_copy_14_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 30)"

$(SH2_FUNC074_INC): $(SH2_FUNC074_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: block_copy_14_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC074_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build block_iterator_short binary from source (requires linker script)
$(SH2_FUNC075_BIN): $(SH2_FUNC075_SRC) $(SH2_FUNC075_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: block_iterator_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/block_iterator_short.o $<
	$(SH2_LD) -T $(SH2_FUNC075_LDS) -o $(BUILD_DIR)/sh2/block_iterator_short.elf $(BUILD_DIR)/sh2/block_iterator_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/block_iterator_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 26)"

$(SH2_FUNC075_INC): $(SH2_FUNC075_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: block_iterator_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC075_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build vdp_pixel_write_short binary from source (requires linker script)
$(SH2_FUNC076_BIN): $(SH2_FUNC076_SRC) $(SH2_FUNC076_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: vdp_pixel_write_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/vdp_pixel_write_short.o $<
	$(SH2_LD) -T $(SH2_FUNC076_LDS) -o $(BUILD_DIR)/sh2/vdp_pixel_write_short.elf $(BUILD_DIR)/sh2/vdp_pixel_write_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/vdp_pixel_write_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 76)"

$(SH2_FUNC076_INC): $(SH2_FUNC076_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: vdp_pixel_write_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC076_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build value_dispatch_short binary from source (requires linker script)
$(SH2_FUNC077_BIN): $(SH2_FUNC077_SRC) $(SH2_FUNC077_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: value_dispatch_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/value_dispatch_short.o $<
	$(SH2_LD) -T $(SH2_FUNC077_LDS) -o $(BUILD_DIR)/sh2/value_dispatch_short.elf $(BUILD_DIR)/sh2/value_dispatch_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/value_dispatch_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 46)"

$(SH2_FUNC077_INC): $(SH2_FUNC077_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: value_dispatch_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC077_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build negative_fill_short binary from source (requires linker script)
$(SH2_FUNC078_BIN): $(SH2_FUNC078_SRC) $(SH2_FUNC078_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: negative_fill_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/negative_fill_short.o $<
	$(SH2_LD) -T $(SH2_FUNC078_LDS) -o $(BUILD_DIR)/sh2/negative_fill_short.elf $(BUILD_DIR)/sh2/negative_fill_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/negative_fill_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 40)"

$(SH2_FUNC078_INC): $(SH2_FUNC078_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: negative_fill_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC078_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build fill_decrement_short binary from source (requires linker script)
$(SH2_FUNC079_BIN): $(SH2_FUNC079_SRC) $(SH2_FUNC079_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: fill_decrement_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/fill_decrement_short.o $<
	$(SH2_LD) -T $(SH2_FUNC079_LDS) -o $(BUILD_DIR)/sh2/fill_decrement_short.elf $(BUILD_DIR)/sh2/fill_decrement_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/fill_decrement_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 20)"

$(SH2_FUNC079_INC): $(SH2_FUNC079_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: fill_decrement_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC079_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build memory_clear_short binary from source (requires linker script)
$(SH2_FUNC080_BIN): $(SH2_FUNC080_SRC) $(SH2_FUNC080_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: memory_clear_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/memory_clear_short.o $<
	$(SH2_LD) -T $(SH2_FUNC080_LDS) -o $(BUILD_DIR)/sh2/memory_clear_short.elf $(BUILD_DIR)/sh2/memory_clear_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/memory_clear_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 34)"

$(SH2_FUNC080_INC): $(SH2_FUNC080_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: memory_clear_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC080_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build multi_jsr_short binary from source (requires linker script)
$(SH2_FUNC081_BIN): $(SH2_FUNC081_SRC) $(SH2_FUNC081_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: multi_jsr_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/multi_jsr_short.o $<
	$(SH2_LD) -T $(SH2_FUNC081_LDS) -o $(BUILD_DIR)/sh2/multi_jsr_short.elf $(BUILD_DIR)/sh2/multi_jsr_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/multi_jsr_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 52)"

$(SH2_FUNC081_INC): $(SH2_FUNC081_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: multi_jsr_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC081_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build multi_jsr_alt_short binary from source (requires linker script)
$(SH2_FUNC082_BIN): $(SH2_FUNC082_SRC) $(SH2_FUNC082_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: multi_jsr_alt_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/multi_jsr_alt_short.o $<
	$(SH2_LD) -T $(SH2_FUNC082_LDS) -o $(BUILD_DIR)/sh2/multi_jsr_alt_short.elf $(BUILD_DIR)/sh2/multi_jsr_alt_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/multi_jsr_alt_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 50)"

$(SH2_FUNC082_INC): $(SH2_FUNC082_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: multi_jsr_alt_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC082_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build poll_wait_short binary from source (requires linker script)
$(SH2_FUNC083_BIN): $(SH2_FUNC083_SRC) $(SH2_FUNC083_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: poll_wait_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/poll_wait_short.o $<
	$(SH2_LD) -T $(SH2_FUNC083_LDS) -o $(BUILD_DIR)/sh2/poll_wait_short.elf $(BUILD_DIR)/sh2/poll_wait_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/poll_wait_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 12)"

$(SH2_FUNC083_INC): $(SH2_FUNC083_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: poll_wait_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC083_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build hw_init_short binary from source (requires linker script)
$(SH2_FUNC084_BIN): $(SH2_FUNC084_SRC) $(SH2_FUNC084_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: hw_init_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/hw_init_short.o $<
	$(SH2_LD) -T $(SH2_FUNC084_LDS) -o $(BUILD_DIR)/sh2/hw_init_short.elf $(BUILD_DIR)/sh2/hw_init_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/hw_init_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 28)"

$(SH2_FUNC084_INC): $(SH2_FUNC084_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: hw_init_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC084_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build poll_zero_short binary from source (requires linker script)
$(SH2_FUNC085_BIN): $(SH2_FUNC085_SRC) $(SH2_FUNC085_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: poll_zero_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/poll_zero_short.o $<
	$(SH2_LD) -T $(SH2_FUNC085_LDS) -o $(BUILD_DIR)/sh2/poll_zero_short.elf $(BUILD_DIR)/sh2/poll_zero_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/poll_zero_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 12)"

$(SH2_FUNC085_INC): $(SH2_FUNC085_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: poll_zero_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC085_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build clear_reg_short binary from source (requires linker script)
$(SH2_FUNC086_BIN): $(SH2_FUNC086_SRC) $(SH2_FUNC086_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: clear_reg_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/clear_reg_short.o $<
	$(SH2_LD) -T $(SH2_FUNC086_LDS) -o $(BUILD_DIR)/sh2/clear_reg_short.elf $(BUILD_DIR)/sh2/clear_reg_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/clear_reg_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 8)"

$(SH2_FUNC086_INC): $(SH2_FUNC086_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: clear_reg_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC086_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build poll_zero_alt_short binary from source (requires linker script)
$(SH2_FUNC087_BIN): $(SH2_FUNC087_SRC) $(SH2_FUNC087_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: poll_zero_alt_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/poll_zero_alt_short.o $<
	$(SH2_LD) -T $(SH2_FUNC087_LDS) -o $(BUILD_DIR)/sh2/poll_zero_alt_short.elf $(BUILD_DIR)/sh2/poll_zero_alt_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/poll_zero_alt_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 12)"

$(SH2_FUNC087_INC): $(SH2_FUNC087_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: poll_zero_alt_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC087_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build struct_init_short binary from source (requires linker script)
$(SH2_FUNC088_BIN): $(SH2_FUNC088_SRC) $(SH2_FUNC088_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: struct_init_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/struct_init_short.o $<
	$(SH2_LD) -T $(SH2_FUNC088_LDS) -o $(BUILD_DIR)/sh2/struct_init_short.elf $(BUILD_DIR)/sh2/struct_init_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/struct_init_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 34)"

$(SH2_FUNC088_INC): $(SH2_FUNC088_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: struct_init_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC088_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build poll_branch_short binary from source (requires linker script)
$(SH2_FUNC089_BIN): $(SH2_FUNC089_SRC) $(SH2_FUNC089_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: poll_branch_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/poll_branch_short.o $<
	$(SH2_LD) -T $(SH2_FUNC089_LDS) -o $(BUILD_DIR)/sh2/poll_branch_short.elf $(BUILD_DIR)/sh2/poll_branch_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/poll_branch_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 40)"

$(SH2_FUNC089_INC): $(SH2_FUNC089_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: poll_branch_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC089_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build poll_wait_2_short binary from source (requires linker script)
$(SH2_FUNC090_BIN): $(SH2_FUNC090_SRC) $(SH2_FUNC090_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: poll_wait_2_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/poll_wait_2_short.o $<
	$(SH2_LD) -T $(SH2_FUNC090_LDS) -o $(BUILD_DIR)/sh2/poll_wait_2_short.elf $(BUILD_DIR)/sh2/poll_wait_2_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/poll_wait_2_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 24)"

$(SH2_FUNC090_INC): $(SH2_FUNC090_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: poll_wait_2_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC090_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build poll_copy_short binary from source (requires linker script)
$(SH2_FUNC091_BIN): $(SH2_FUNC091_SRC) $(SH2_FUNC091_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: poll_copy_short (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/poll_copy_short.o $<
	$(SH2_LD) -T $(SH2_FUNC091_LDS) -o $(BUILD_DIR)/sh2/poll_copy_short.elf $(BUILD_DIR)/sh2/poll_copy_short.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/poll_copy_short.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 18)"

$(SH2_FUNC091_INC): $(SH2_FUNC091_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: poll_copy_short.inc..."
	@echo "; Auto-generated from $(SH2_FUNC091_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build transform_loop binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC005_BIN): $(SH2_FUNC005_SRC) $(SH2_FUNC005_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: transform_loop (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/transform_loop.o $<
	$(SH2_LD) -T $(SH2_FUNC005_LDS) -o $(BUILD_DIR)/sh2/transform_loop.elf $(BUILD_DIR)/sh2/transform_loop.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/transform_loop.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 56)"

$(SH2_FUNC005_INC): $(SH2_FUNC005_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: transform_loop.inc..."
	@echo "; Auto-generated from $(SH2_FUNC005_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build alt_transform_loop binary from source (requires linker script for PC-relative addressing)
$(SH2_FUNC007_BIN): $(SH2_FUNC007_SRC) $(SH2_FUNC007_LDS) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: alt_transform_loop (with linker script)..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/alt_transform_loop.o $<
	$(SH2_LD) -T $(SH2_FUNC007_LDS) -o $(BUILD_DIR)/sh2/alt_transform_loop.elf $(BUILD_DIR)/sh2/alt_transform_loop.o
	$(SH2_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/sh2/alt_transform_loop.elf $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 52)"

$(SH2_FUNC007_INC): $(SH2_FUNC007_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: alt_transform_loop.inc..."
	@echo "; Auto-generated from $(SH2_FUNC007_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build matrix_multiply binary from source
$(SH2_FUNC006_BIN): $(SH2_FUNC006_SRC) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: matrix_multiply..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/matrix_multiply.o $<
	$(SH2_OBJCOPY) -O binary $(BUILD_DIR)/sh2/matrix_multiply.o $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes)"

# Generate dc.w include from binary (big-endian format for 68K assembler)
$(SH2_FUNC006_INC): $(SH2_FUNC006_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: matrix_multiply.inc..."
	@echo "; Auto-generated from $(SH2_FUNC006_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build alt_matrix_multiply binary from source
$(SH2_FUNC008_BIN): $(SH2_FUNC008_SRC) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: alt_matrix_multiply..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/alt_matrix_multiply.o $<
	$(SH2_OBJCOPY) -O binary $(BUILD_DIR)/sh2/alt_matrix_multiply.o $@
	@# Trim to exact 56 bytes (exclude delay slot - shared with display_list_4elem)
	@truncate -s 56 $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes)"

$(SH2_FUNC008_INC): $(SH2_FUNC008_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: alt_matrix_multiply.inc..."
	@echo "; Auto-generated from $(SH2_FUNC008_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build coord_transform binary from source
$(SH2_FUNC016_BIN): $(SH2_FUNC016_SRC) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: coord_transform..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/coord_transform.o $<
	$(SH2_OBJCOPY) -O binary $(BUILD_DIR)/sh2/coord_transform.o $@
	@# Trim to exact 34 bytes (remove assembler padding)
	@truncate -s 34 $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes)"

$(SH2_FUNC016_INC): $(SH2_FUNC016_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: coord_transform.inc..."
	@echo "; Auto-generated from $(SH2_FUNC016_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build display_list_4elem binary from source
$(SH2_FUNC009_BIN): $(SH2_FUNC009_SRC) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: display_list_4elem..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/display_list_4elem.o $<
	$(SH2_OBJCOPY) -O binary $(BUILD_DIR)/sh2/display_list_4elem.o $@
	@# Trim to exact 30 bytes (remove assembler padding)
	@truncate -s 30 $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes)"

$(SH2_FUNC009_INC): $(SH2_FUNC009_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: display_list_4elem.inc..."
	@echo "; Auto-generated from $(SH2_FUNC009_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build display_list_3elem binary from source
$(SH2_FUNC010_BIN): $(SH2_FUNC010_SRC) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: display_list_3elem..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/display_list_3elem.o $<
	$(SH2_OBJCOPY) -O binary $(BUILD_DIR)/sh2/display_list_3elem.o $@
	@# Trim to exact 26 bytes (remove assembler padding)
	@truncate -s 26 $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes)"

$(SH2_FUNC010_INC): $(SH2_FUNC010_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: display_list_3elem.inc..."
	@echo "; Auto-generated from $(SH2_FUNC010_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build unrolled_data_copy binary from source
$(SH2_FUNC065_BIN): $(SH2_FUNC065_SRC) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: unrolled_data_copy..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/unrolled_data_copy.o $<
	$(SH2_OBJCOPY) -O binary $(BUILD_DIR)/sh2/unrolled_data_copy.o $@
	@# Trim to exact 152 bytes (remove assembler padding/delay slot)
	@truncate -s 152 $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes)"

$(SH2_FUNC065_INC): $(SH2_FUNC065_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: unrolled_data_copy.inc..."
	@echo "; Auto-generated from $(SH2_FUNC065_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build rle_decoder binary from source
$(SH2_FUNC066_BIN): $(SH2_FUNC066_SRC) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: rle_decoder..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/rle_decoder.o $<
	$(SH2_OBJCOPY) -O binary $(BUILD_DIR)/sh2/rle_decoder.o $@
	@# Trim to exact 48 bytes (remove assembler padding)
	@truncate -s 48 $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes)"

$(SH2_FUNC066_INC): $(SH2_FUNC066_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: rle_decoder.inc..."
	@echo "; Auto-generated from $(SH2_FUNC066_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build vertex_transform_optimized binary from source (expansion ROM)
$(SH2_FUNC021_OPT_BIN): $(SH2_FUNC021_OPT_SRC) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: vertex_transform_optimized..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/vertex_transform_optimized.o $<
	$(SH2_OBJCOPY) -O binary $(BUILD_DIR)/sh2/vertex_transform_optimized.o $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes)"

$(SH2_FUNC021_OPT_INC): $(SH2_FUNC021_OPT_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: vertex_transform_optimized.inc..."
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
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 28)"

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

# Build general_queue_drain binary from source (Phase 3 - expansion ROM)
$(SH2_GEN_DRAIN_BIN): $(SH2_GEN_DRAIN_SRC) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: general_queue_drain..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/general_queue_drain.o $<
	$(SH2_OBJCOPY) -O binary $(BUILD_DIR)/sh2/general_queue_drain.o $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes)"

$(SH2_GEN_DRAIN_INC): $(SH2_GEN_DRAIN_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: general_queue_drain.inc..."
	@echo "; Auto-generated from $(SH2_GEN_DRAIN_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build slave_comm7_idle_check binary from source (expansion ROM)
$(SH2_COMM7_CHECK_BIN): $(SH2_COMM7_CHECK_SRC) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: slave_comm7_idle_check..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/slave_comm7_idle_check.o $<
	$(SH2_OBJCOPY) -O binary $(BUILD_DIR)/sh2/slave_comm7_idle_check.o $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes)"

$(SH2_COMM7_CHECK_INC): $(SH2_COMM7_CHECK_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: slave_comm7_idle_check.inc..."
	@echo "; Auto-generated from $(SH2_COMM7_CHECK_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build cmd22_single_shot binary from source (B-004 expansion ROM)
$(SH2_CMD22_SINGLE_SHOT_BIN): $(SH2_CMD22_SINGLE_SHOT_SRC) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: cmd22_single_shot..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/cmd22_single_shot.o $<
	$(SH2_OBJCOPY) -O binary $(BUILD_DIR)/sh2/cmd22_single_shot.o $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 176)"

$(SH2_CMD22_SINGLE_SHOT_INC): $(SH2_CMD22_SINGLE_SHOT_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: cmd22_single_shot.inc..."
	@echo "; Auto-generated from $(SH2_CMD22_SINGLE_SHOT_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Build cmd25_single_shot binary from source (B-005 expansion ROM)
$(SH2_CMD25_SINGLE_SHOT_BIN): $(SH2_CMD25_SINGLE_SHOT_SRC) | dirs
	@mkdir -p $(BUILD_DIR)/sh2
	@echo "==> Assembling SH2: cmd25_single_shot..."
	$(SH2_AS) $(SH2_ASFLAGS) -o $(BUILD_DIR)/sh2/cmd25_single_shot.o $<
	$(SH2_OBJCOPY) -O binary $(BUILD_DIR)/sh2/cmd25_single_shot.o $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes, expected 64)"

$(SH2_CMD25_SINGLE_SHOT_INC): $(SH2_CMD25_SINGLE_SHOT_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: cmd25_single_shot.inc..."
	@echo "; Auto-generated from $(SH2_CMD25_SINGLE_SHOT_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Verify SH2 assembly matches original ROM
sh2-verify: $(SH2_FUNC000_BIN) $(SH2_FUNC022_BIN) $(SH2_FUNC017_BIN) $(SH2_FUNC018_BIN) $(SH2_FUNC032_BIN) $(SH2_FUNC011_BIN) $(SH2_FUNC012_BIN) $(SH2_FUNC013_BIN) $(SH2_FUNC014_015_BIN) $(SH2_FUNC024_BIN) $(SH2_FUNC025_BIN) $(SH2_FUNC026_BIN) $(SH2_FUNC003_004_BIN) $(SH2_FUNC029_030_031_BIN) $(SH2_FUNC033_BIN) $(SH2_FUNC034_BIN) $(SH2_FUNC036_BIN) $(SH2_FUNC037_038_039_BIN) $(SH2_FUNC005_BIN) $(SH2_FUNC007_BIN) $(SH2_FUNC006_BIN) $(SH2_FUNC008_BIN) $(SH2_FUNC016_BIN) $(SH2_FUNC009_BIN) $(SH2_FUNC010_BIN) $(SH2_FUNC065_BIN) $(SH2_FUNC066_BIN)
	@echo "==> Verifying SH2 assembly against original ROM..."
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x2300A)) count=26 2>/dev/null > $(BUILD_DIR)/sh2/data_copy_original.bin
	@if diff -q $(SH2_FUNC000_BIN) $(BUILD_DIR)/sh2/data_copy_original.bin > /dev/null 2>&1; then \
		echo "✓ data_copy: PERFECT MATCH"; \
	else \
		echo "✗ data_copy: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x234EE)) count=26 2>/dev/null > $(BUILD_DIR)/sh2/wait_ready_original.bin
	@if diff -q $(SH2_FUNC022_BIN) $(BUILD_DIR)/sh2/wait_ready_original.bin > /dev/null 2>&1; then \
		echo "✓ wait_ready: PERFECT MATCH"; \
	else \
		echo "✗ wait_ready: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x2338A)) count=26 2>/dev/null > $(BUILD_DIR)/sh2/quad_helper_original.bin
	@if diff -q $(SH2_FUNC017_BIN) $(BUILD_DIR)/sh2/quad_helper_original.bin > /dev/null 2>&1; then \
		echo "✓ quad_helper: PERFECT MATCH"; \
	else \
		echo "✗ quad_helper: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x233A4)) count=112 2>/dev/null > $(BUILD_DIR)/sh2/quad_batch_short_original.bin
	@if diff -q $(SH2_FUNC018_BIN) $(BUILD_DIR)/sh2/quad_batch_short_original.bin > /dev/null 2>&1; then \
		echo "✓ quad_batch_short: PERFECT MATCH"; \
	else \
		echo "✗ quad_batch_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23414)) count=140 2>/dev/null > $(BUILD_DIR)/sh2/quad_batch_alt_short_original.bin
	@if diff -q $(SH2_FUNC019_BIN) $(BUILD_DIR)/sh2/quad_batch_alt_short_original.bin > /dev/null 2>&1; then \
		echo "✓ quad_batch_alt_short: PERFECT MATCH"; \
	else \
		echo "✗ quad_batch_alt_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x234A0)) count=40 2>/dev/null > $(BUILD_DIR)/sh2/vertex_helper_short_original.bin
	@if diff -q $(SH2_FUNC020_BIN) $(BUILD_DIR)/sh2/vertex_helper_short_original.bin > /dev/null 2>&1; then \
		echo "✓ vertex_helper_short: PERFECT MATCH"; \
	else \
		echo "✗ vertex_helper_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x234C8)) count=38 2>/dev/null > $(BUILD_DIR)/sh2/vertex_transform_orig_original.bin
	@if diff -q $(SH2_FUNC021_ORIG_BIN) $(BUILD_DIR)/sh2/vertex_transform_orig_original.bin > /dev/null 2>&1; then \
		echo "✓ vertex_transform_orig: PERFECT MATCH"; \
	else \
		echo "✗ vertex_transform_orig: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23508)) count=238 2>/dev/null > $(BUILD_DIR)/sh2/frustum_cull_short_original.bin
	@if diff -q $(SH2_FUNC023_BIN) $(BUILD_DIR)/sh2/frustum_cull_short_original.bin > /dev/null 2>&1; then \
		echo "✓ frustum_cull_short: PERFECT MATCH"; \
	else \
		echo "✗ frustum_cull_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x2385E)) count=122 2>/dev/null > $(BUILD_DIR)/sh2/display_list_short_original.bin
	@if diff -q $(SH2_FUNC040_BIN) $(BUILD_DIR)/sh2/display_list_short_original.bin > /dev/null 2>&1; then \
		echo "✓ display_list_short: PERFECT MATCH"; \
	else \
		echo "✗ display_list_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x238D8)) count=212 2>/dev/null > $(BUILD_DIR)/sh2/display_cases_short_original.bin
	@if diff -q $(SH2_FUNC040_CASES_BIN) $(BUILD_DIR)/sh2/display_cases_short_original.bin > /dev/null 2>&1; then \
		echo "✓ display_cases_short: PERFECT MATCH"; \
	else \
		echo "✗ display_cases_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x239B0)) count=28 2>/dev/null > $(BUILD_DIR)/sh2/display_utility_short_original.bin
	@if diff -q $(SH2_FUNC040_UTIL_BIN) $(BUILD_DIR)/sh2/display_utility_short_original.bin > /dev/null 2>&1; then \
		echo "✓ display_utility_short: PERFECT MATCH"; \
	else \
		echo "✗ display_utility_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x239F0)) count=98 2>/dev/null > $(BUILD_DIR)/sh2/render_coord_short_original.bin
	@if diff -q $(SH2_FUNC041_BIN) $(BUILD_DIR)/sh2/render_coord_short_original.bin > /dev/null 2>&1; then \
		echo "✓ render_coord_short: PERFECT MATCH"; \
	else \
		echo "✗ render_coord_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23A52)) count=20 2>/dev/null > $(BUILD_DIR)/sh2/data_copy_util_short_original.bin
	@if diff -q $(SH2_FUNC042_BIN) $(BUILD_DIR)/sh2/data_copy_util_short_original.bin > /dev/null 2>&1; then \
		echo "✓ data_copy_util_short: PERFECT MATCH"; \
	else \
		echo "✗ data_copy_util_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23A70)) count=312 2>/dev/null > $(BUILD_DIR)/sh2/polygon_batch_short_original.bin
	@if diff -q $(SH2_FUNC043_BIN) $(BUILD_DIR)/sh2/polygon_batch_short_original.bin > /dev/null 2>&1; then \
		echo "✓ polygon_batch_short: PERFECT MATCH"; \
	else \
		echo "✗ polygon_batch_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23BA8)) count=268 2>/dev/null > $(BUILD_DIR)/sh2/edge_scan_short_original.bin
	@if diff -q $(SH2_FUNC044_BIN) $(BUILD_DIR)/sh2/edge_scan_short_original.bin > /dev/null 2>&1; then \
		echo "✓ edge_scan_short: PERFECT MATCH"; \
	else \
		echo "✗ edge_scan_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23CB4)) count=68 2>/dev/null > $(BUILD_DIR)/sh2/dispatch_loop_short_original.bin
	@if diff -q $(SH2_FUNC045_BIN) $(BUILD_DIR)/sh2/dispatch_loop_short_original.bin > /dev/null 2>&1; then \
		echo "✓ dispatch_loop_short: PERFECT MATCH"; \
	else \
		echo "✗ dispatch_loop_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23CF8)) count=36 2>/dev/null > $(BUILD_DIR)/sh2/array_copy_short_original.bin
	@if diff -q $(SH2_FUNC046_BIN) $(BUILD_DIR)/sh2/array_copy_short_original.bin > /dev/null 2>&1; then \
		echo "✓ array_copy_short: PERFECT MATCH"; \
	else \
		echo "✗ array_copy_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23D24)) count=26 2>/dev/null > $(BUILD_DIR)/sh2/bounds_check_short_original.bin
	@if diff -q $(SH2_FUNC047_BIN) $(BUILD_DIR)/sh2/bounds_check_short_original.bin > /dev/null 2>&1; then \
		echo "✓ bounds_check_short: PERFECT MATCH"; \
	else \
		echo "✗ bounds_check_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23D3E)) count=22 2>/dev/null > $(BUILD_DIR)/sh2/bounds_handler_short_original.bin
	@if diff -q $(SH2_FUNC048_BIN) $(BUILD_DIR)/sh2/bounds_handler_short_original.bin > /dev/null 2>&1; then \
		echo "✓ bounds_handler_short: PERFECT MATCH"; \
	else \
		echo "✗ bounds_handler_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23D54)) count=26 2>/dev/null > $(BUILD_DIR)/sh2/bounds_entry_short_original.bin
	@if diff -q $(SH2_FUNC049_BIN) $(BUILD_DIR)/sh2/bounds_entry_short_original.bin > /dev/null 2>&1; then \
		echo "✓ bounds_entry_short: PERFECT MATCH"; \
	else \
		echo "✗ bounds_entry_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23D6E)) count=88 2>/dev/null > $(BUILD_DIR)/sh2/multi_bsr_short_original.bin
	@if diff -q $(SH2_FUNC050_BIN) $(BUILD_DIR)/sh2/multi_bsr_short_original.bin > /dev/null 2>&1; then \
		echo "✓ multi_bsr_short: PERFECT MATCH"; \
	else \
		echo "✗ multi_bsr_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23DD8)) count=92 2>/dev/null > $(BUILD_DIR)/sh2/offset_bsr_short_original.bin
	@if diff -q $(SH2_FUNC051_BIN) $(BUILD_DIR)/sh2/offset_bsr_short_original.bin > /dev/null 2>&1; then \
		echo "✓ offset_bsr_short: PERFECT MATCH"; \
	else \
		echo "✗ offset_bsr_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23E48)) count=22 2>/dev/null > $(BUILD_DIR)/sh2/small_bsr_short_original.bin
	@if diff -q $(SH2_FUNC052_BIN) $(BUILD_DIR)/sh2/small_bsr_short_original.bin > /dev/null 2>&1; then \
		echo "✓ small_bsr_short: PERFECT MATCH"; \
	else \
		echo "✗ small_bsr_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23E64)) count=38 2>/dev/null > $(BUILD_DIR)/sh2/offset_small_short_original.bin
	@if diff -q $(SH2_FUNC053_BIN) $(BUILD_DIR)/sh2/offset_small_short_original.bin > /dev/null 2>&1; then \
		echo "✓ offset_small_short: PERFECT MATCH"; \
	else \
		echo "✗ offset_small_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23E90)) count=56 2>/dev/null > $(BUILD_DIR)/sh2/conditional_bsr_short_original.bin
	@if diff -q $(SH2_FUNC054_BIN) $(BUILD_DIR)/sh2/conditional_bsr_short_original.bin > /dev/null 2>&1; then \
		echo "✓ conditional_bsr_short: PERFECT MATCH"; \
	else \
		echo "✗ conditional_bsr_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23ED0)) count=92 2>/dev/null > $(BUILD_DIR)/sh2/unrolled_copy_short_original.bin
	@if diff -q $(SH2_FUNC055_BIN) $(BUILD_DIR)/sh2/unrolled_copy_short_original.bin > /dev/null 2>&1; then \
		echo "✓ unrolled_copy_short: PERFECT MATCH"; \
	else \
		echo "✗ unrolled_copy_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23FF4)) count=14 2>/dev/null > $(BUILD_DIR)/sh2/rle_entry_alt1_short_original.bin
	@if diff -q $(SH2_FUNC067_BIN) $(BUILD_DIR)/sh2/rle_entry_alt1_short_original.bin > /dev/null 2>&1; then \
		echo "✓ rle_entry_alt1_short: PERFECT MATCH"; \
	else \
		echo "✗ rle_entry_alt1_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x24002)) count=12 2>/dev/null > $(BUILD_DIR)/sh2/rle_entry_alt2_short_original.bin
	@if diff -q $(SH2_FUNC068_BIN) $(BUILD_DIR)/sh2/rle_entry_alt2_short_original.bin > /dev/null 2>&1; then \
		echo "✓ rle_entry_alt2_short: PERFECT MATCH"; \
	else \
		echo "✗ rle_entry_alt2_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x2400E)) count=76 2>/dev/null > $(BUILD_DIR)/sh2/block_copy_stride_short_original.bin
	@if diff -q $(SH2_FUNC069_BIN) $(BUILD_DIR)/sh2/block_copy_stride_short_original.bin > /dev/null 2>&1; then \
		echo "✓ block_copy_stride_short: PERFECT MATCH"; \
	else \
		echo "✗ block_copy_stride_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x24060)) count=36 2>/dev/null > $(BUILD_DIR)/sh2/loop_dispatcher_short_original.bin
	@if diff -q $(SH2_FUNC070_BIN) $(BUILD_DIR)/sh2/loop_dispatcher_short_original.bin > /dev/null 2>&1; then \
		echo "✓ loop_dispatcher_short: PERFECT MATCH"; \
	else \
		echo "✗ loop_dispatcher_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x24084)) count=122 2>/dev/null > $(BUILD_DIR)/sh2/context_setup_short_original.bin
	@if diff -q $(SH2_FUNC071_BIN) $(BUILD_DIR)/sh2/context_setup_short_original.bin > /dev/null 2>&1; then \
		echo "✓ context_setup_short: PERFECT MATCH"; \
	else \
		echo "✗ context_setup_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x241A4)) count=42 2>/dev/null > $(BUILD_DIR)/sh2/element_processor_short_original.bin
	@if diff -q $(SH2_FUNC072_BIN) $(BUILD_DIR)/sh2/element_processor_short_original.bin > /dev/null 2>&1; then \
		echo "✓ element_processor_short: PERFECT MATCH"; \
	else \
		echo "✗ element_processor_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x241D8)) count=16 2>/dev/null > $(BUILD_DIR)/sh2/negative_handler_short_original.bin
	@if diff -q $(SH2_FUNC073_BIN) $(BUILD_DIR)/sh2/negative_handler_short_original.bin > /dev/null 2>&1; then \
		echo "✓ negative_handler_short: PERFECT MATCH"; \
	else \
		echo "✗ negative_handler_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x241E8)) count=30 2>/dev/null > $(BUILD_DIR)/sh2/block_copy_14_short_original.bin
	@if diff -q $(SH2_FUNC074_BIN) $(BUILD_DIR)/sh2/block_copy_14_short_original.bin > /dev/null 2>&1; then \
		echo "✓ block_copy_14_short: PERFECT MATCH"; \
	else \
		echo "✗ block_copy_14_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x236DA)) count=32 2>/dev/null > $(BUILD_DIR)/sh2/scanline_setup_original.bin
	@if diff -q $(SH2_FUNC032_BIN) $(BUILD_DIR)/sh2/scanline_setup_original.bin > /dev/null 2>&1; then \
		echo "✓ scanline_setup: PERFECT MATCH"; \
	else \
		echo "✗ scanline_setup: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23220)) count=84 2>/dev/null > $(BUILD_DIR)/sh2/display_list_loop_original.bin
	@if diff -q $(SH2_FUNC011_BIN) $(BUILD_DIR)/sh2/display_list_loop_original.bin > /dev/null 2>&1; then \
		echo "✓ display_list_loop: PERFECT MATCH"; \
	else \
		echo "✗ display_list_loop: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23278)) count=92 2>/dev/null > $(BUILD_DIR)/sh2/display_entry_original.bin
	@if diff -q $(SH2_FUNC012_BIN) $(BUILD_DIR)/sh2/display_entry_original.bin > /dev/null 2>&1; then \
		echo "✓ display_entry: PERFECT MATCH"; \
	else \
		echo "✗ display_entry: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x232D4)) count=92 2>/dev/null > $(BUILD_DIR)/sh2/vdp_init_short_original.bin
	@if diff -q $(SH2_FUNC013_BIN) $(BUILD_DIR)/sh2/vdp_init_short_original.bin > /dev/null 2>&1; then \
		echo "✓ vdp_init_short: PERFECT MATCH"; \
	else \
		echo "✗ vdp_init_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23330)) count=56 2>/dev/null > $(BUILD_DIR)/sh2/vdp_copy_short_original.bin
	@if diff -q $(SH2_FUNC014_015_BIN) $(BUILD_DIR)/sh2/vdp_copy_short_original.bin > /dev/null 2>&1; then \
		echo "✓ vdp_copy_short: PERFECT MATCH"; \
	else \
		echo "✗ vdp_copy_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x235F6)) count=62 2>/dev/null > $(BUILD_DIR)/sh2/screen_coords_short_original.bin
	@if diff -q $(SH2_FUNC024_BIN) $(BUILD_DIR)/sh2/screen_coords_short_original.bin > /dev/null 2>&1; then \
		echo "✓ screen_coords_short: PERFECT MATCH"; \
	else \
		echo "✗ screen_coords_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23634)) count=16 2>/dev/null > $(BUILD_DIR)/sh2/coord_offset_short_original.bin
	@if diff -q $(SH2_FUNC025_BIN) $(BUILD_DIR)/sh2/coord_offset_short_original.bin > /dev/null 2>&1; then \
		echo "✓ coord_offset_short: PERFECT MATCH"; \
	else \
		echo "✗ coord_offset_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23644)) count=68 2>/dev/null > $(BUILD_DIR)/sh2/bounds_compare_short_original.bin
	@if diff -q $(SH2_FUNC026_BIN) $(BUILD_DIR)/sh2/bounds_compare_short_original.bin > /dev/null 2>&1; then \
		echo "✓ bounds_compare_short: PERFECT MATCH"; \
	else \
		echo "✗ bounds_compare_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23024)) count=76 2>/dev/null > $(BUILD_DIR)/sh2/main_coordinator_short_original.bin
	@if diff -q $(SH2_FUNC001_BIN) $(BUILD_DIR)/sh2/main_coordinator_short_original.bin > /dev/null 2>&1; then \
		echo "✓ main_coordinator_short: PERFECT MATCH"; \
	else \
		echo "✗ main_coordinator_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23070)) count=88 2>/dev/null > $(BUILD_DIR)/sh2/case_handlers_short_original.bin
	@if diff -q $(SH2_FUNC002_BIN) $(BUILD_DIR)/sh2/case_handlers_short_original.bin > /dev/null 2>&1; then \
		echo "✓ case_handlers_short: PERFECT MATCH"; \
	else \
		echo "✗ case_handlers_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x230C8)) count=32 2>/dev/null > $(BUILD_DIR)/sh2/offset_copy_short_original.bin
	@if diff -q $(SH2_FUNC003_004_BIN) $(BUILD_DIR)/sh2/offset_copy_short_original.bin > /dev/null 2>&1; then \
		echo "✓ offset_copy_short: PERFECT MATCH"; \
	else \
		echo "✗ offset_copy_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23688)) count=82 2>/dev/null > $(BUILD_DIR)/sh2/visibility_short_original.bin
	@if diff -q $(SH2_FUNC029_030_031_BIN) $(BUILD_DIR)/sh2/visibility_short_original.bin > /dev/null 2>&1; then \
		echo "✓ visibility_short: PERFECT MATCH"; \
	else \
		echo "✗ visibility_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x236FA)) count=98 2>/dev/null > $(BUILD_DIR)/sh2/render_quad_short_original.bin
	@if diff -q $(SH2_FUNC033_BIN) $(BUILD_DIR)/sh2/render_quad_short_original.bin > /dev/null 2>&1; then \
		echo "✓ render_quad_short: PERFECT MATCH"; \
	else \
		echo "✗ render_quad_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x2375C)) count=122 2>/dev/null > $(BUILD_DIR)/sh2/span_filler_short_original.bin
	@if diff -q $(SH2_FUNC034_BIN) $(BUILD_DIR)/sh2/span_filler_short_original.bin > /dev/null 2>&1; then \
		echo "✓ span_filler_short: PERFECT MATCH"; \
	else \
		echo "✗ span_filler_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x237D6)) count=72 2>/dev/null > $(BUILD_DIR)/sh2/render_dispatch_short_original.bin
	@if diff -q $(SH2_FUNC036_BIN) $(BUILD_DIR)/sh2/render_dispatch_short_original.bin > /dev/null 2>&1; then \
		echo "✓ render_dispatch_short: PERFECT MATCH"; \
	else \
		echo "✗ render_dispatch_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x2381E)) count=64 2>/dev/null > $(BUILD_DIR)/sh2/helpers_short_original.bin
	@if diff -q $(SH2_FUNC037_038_039_BIN) $(BUILD_DIR)/sh2/helpers_short_original.bin > /dev/null 2>&1; then \
		echo "✓ helpers_short: PERFECT MATCH"; \
	else \
		echo "✗ helpers_short: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x230E8)) count=56 2>/dev/null > $(BUILD_DIR)/sh2/transform_loop_original.bin
	@if diff -q $(SH2_FUNC005_BIN) $(BUILD_DIR)/sh2/transform_loop_original.bin > /dev/null 2>&1; then \
		echo "✓ transform_loop: PERFECT MATCH"; \
	else \
		echo "✗ transform_loop: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23178)) count=52 2>/dev/null > $(BUILD_DIR)/sh2/alt_transform_loop_original.bin
	@if diff -q $(SH2_FUNC007_BIN) $(BUILD_DIR)/sh2/alt_transform_loop_original.bin > /dev/null 2>&1; then \
		echo "✓ alt_transform_loop: PERFECT MATCH"; \
	else \
		echo "✗ alt_transform_loop: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23120)) count=88 2>/dev/null > $(BUILD_DIR)/sh2/matrix_multiply_original.bin
	@if diff -q $(SH2_FUNC006_BIN) $(BUILD_DIR)/sh2/matrix_multiply_original.bin > /dev/null 2>&1; then \
		echo "✓ matrix_multiply: PERFECT MATCH"; \
	else \
		echo "✗ matrix_multiply: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x231AC)) count=56 2>/dev/null > $(BUILD_DIR)/sh2/alt_matrix_multiply_original.bin
	@if diff -q $(SH2_FUNC008_BIN) $(BUILD_DIR)/sh2/alt_matrix_multiply_original.bin > /dev/null 2>&1; then \
		echo "✓ alt_matrix_multiply: PERFECT MATCH"; \
	else \
		echo "✗ alt_matrix_multiply: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23368)) count=34 2>/dev/null > $(BUILD_DIR)/sh2/coord_transform_original.bin
	@if diff -q $(SH2_FUNC016_BIN) $(BUILD_DIR)/sh2/coord_transform_original.bin > /dev/null 2>&1; then \
		echo "✓ coord_transform: PERFECT MATCH"; \
	else \
		echo "✗ coord_transform: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x231E4)) count=30 2>/dev/null > $(BUILD_DIR)/sh2/display_list_4elem_original.bin
	@if diff -q $(SH2_FUNC009_BIN) $(BUILD_DIR)/sh2/display_list_4elem_original.bin > /dev/null 2>&1; then \
		echo "✓ display_list_4elem: PERFECT MATCH"; \
	else \
		echo "✗ display_list_4elem: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23202)) count=26 2>/dev/null > $(BUILD_DIR)/sh2/display_list_3elem_original.bin
	@if diff -q $(SH2_FUNC010_BIN) $(BUILD_DIR)/sh2/display_list_3elem_original.bin > /dev/null 2>&1; then \
		echo "✓ display_list_3elem: PERFECT MATCH"; \
	else \
		echo "✗ display_list_3elem: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23F2C)) count=152 2>/dev/null > $(BUILD_DIR)/sh2/unrolled_data_copy_original.bin
	@if diff -q $(SH2_FUNC065_BIN) $(BUILD_DIR)/sh2/unrolled_data_copy_original.bin > /dev/null 2>&1; then \
		echo "✓ unrolled_data_copy: PERFECT MATCH"; \
	else \
		echo "✗ unrolled_data_copy: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23FC4)) count=48 2>/dev/null > $(BUILD_DIR)/sh2/rle_decoder_original.bin
	@if diff -q $(SH2_FUNC066_BIN) $(BUILD_DIR)/sh2/rle_decoder_original.bin > /dev/null 2>&1; then \
		echo "✓ rle_decoder: PERFECT MATCH"; \
	else \
		echo "✗ rle_decoder: MISMATCH"; \
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
