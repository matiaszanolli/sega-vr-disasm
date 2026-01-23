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
$(OUTPUT_ROM): $(M68K_SRC) $(SH2_FUNC006_INC) $(SH2_FUNC008_INC)
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

# SH2 source files
SH2_FUNC006_SRC = $(SH2_3D_DIR)/func_006_matrix_multiply.asm
SH2_FUNC006_BIN = $(BUILD_DIR)/sh2/func_006.bin
SH2_FUNC006_INC = $(SH2_GEN_DIR)/func_006.inc

SH2_FUNC008_SRC = $(SH2_3D_DIR)/func_008_alt_matrix_multiply.asm
SH2_FUNC008_BIN = $(BUILD_DIR)/sh2/func_008.bin
SH2_FUNC008_INC = $(SH2_GEN_DIR)/func_008.inc

.PHONY: sh2-assembly sh2-verify

# Build all SH2 assembly sources
sh2-assembly: dirs $(SH2_FUNC006_INC) $(SH2_FUNC008_INC)

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
	@# Trim to exact 58 bytes (remove assembler padding)
	@truncate -s 58 $@
	@echo "    Output: $@ ($$(wc -c < $@) bytes)"

$(SH2_FUNC008_INC): $(SH2_FUNC008_BIN)
	@mkdir -p $(SH2_GEN_DIR)
	@echo "==> Generating dc.w include: func_008.inc..."
	@echo "; Auto-generated from $(SH2_FUNC008_SRC)" > $@
	@echo "; DO NOT EDIT - regenerate with 'make sh2-assembly'" >> $@
	@echo "" >> $@
	@xxd -p $< | fold -w4 | awk '{print "        dc.w    $$" toupper($$1)}' >> $@
	@echo "    Output: $@ ($$(wc -l < $@) lines)"

# Verify SH2 assembly matches original ROM
sh2-verify: $(SH2_FUNC006_BIN) $(SH2_FUNC008_BIN)
	@echo "==> Verifying SH2 assembly against original ROM..."
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x23120)) count=88 2>/dev/null > $(BUILD_DIR)/sh2/func_006_original.bin
	@if diff -q $(SH2_FUNC006_BIN) $(BUILD_DIR)/sh2/func_006_original.bin > /dev/null 2>&1; then \
		echo "✓ func_006: PERFECT MATCH"; \
	else \
		echo "✗ func_006: MISMATCH"; \
		exit 1; \
	fi
	@dd if="$(ORIGINAL_ROM)" bs=1 skip=$$((0x231AC)) count=58 2>/dev/null > $(BUILD_DIR)/sh2/func_008_original.bin
	@if diff -q $(SH2_FUNC008_BIN) $(BUILD_DIR)/sh2/func_008_original.bin > /dev/null 2>&1; then \
		echo "✓ func_008: PERFECT MATCH"; \
	else \
		echo "✗ func_008: MISMATCH"; \
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
