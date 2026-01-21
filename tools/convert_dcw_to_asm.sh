#!/bin/bash
# Convert dc.w section to proper SH2 assembly
# Usage: ./convert_dcw_to_asm.sh <section_file> <start_offset> <end_offset>

set -e

if [ $# -lt 3 ]; then
    echo "Usage: $0 <section_file> <start_offset> <end_offset>"
    echo "Example: $0 disasm/sections/code_20200.asm 0x02050C 0x02051E"
    exit 1
fi

SECTION_FILE="$1"
START_OFFSET="$2"
END_OFFSET="$3"

BASENAME=$(basename "$SECTION_FILE" .asm)
OUTPUT_DIR="disasm/sh2"
OUTPUT_FILE="${OUTPUT_DIR}/${BASENAME}_converted.asm"

mkdir -p "$OUTPUT_DIR"

echo "==================================================================="
echo "SH2 dc.w to Assembly Converter"
echo "==================================================================="
echo "Section file: $SECTION_FILE"
echo "Start offset: $START_OFFSET"
echo "End offset:   $END_OFFSET"
echo "Output:       $OUTPUT_FILE"
echo ""

# Step 1: Build current ROM to get binary reference
echo "[1/5] Building current ROM for binary reference..."
make clean > /dev/null 2>&1
make all > /dev/null 2>&1
echo "      ✓ ROM built"

# Step 2: Extract binary section from ROM
echo "[2/5] Extracting binary section..."
START_DEC=$((START_OFFSET))
END_DEC=$((END_OFFSET))
SIZE=$((END_DEC - START_DEC))

dd if=build/vr_rebuild.32x of=/tmp/section.bin bs=1 skip=$START_DEC count=$SIZE 2>/dev/null
echo "      ✓ Extracted $SIZE bytes"

# Step 3: Disassemble to assembly
echo "[3/5] Disassembling to assembly syntax..."
tools/sh2_disasm.py build/vr_rebuild.32x $START_OFFSET $((SIZE/2)) > /tmp/section_disasm.txt
echo "      ✓ Disassembled $((SIZE/2)) instructions"

# Step 4: Create assembly template
cat > "$OUTPUT_FILE" <<EOF
/*
 * Auto-converted from: $SECTION_FILE
 * Original offset: $START_OFFSET - $END_OFFSET ($SIZE bytes)
 *
 * IMPORTANT: This is a REFERENCE conversion. Manual review required for:
 * - Label placement (jumps/calls)
 * - Data vs code sections
 * - PC-relative addressing
 * - Comments and function boundaries
 */

.section .text
.align 2

/* TODO: Add proper labels and function names */
section_start:

EOF

# Step 5: Parse disassembly and convert to assembly mnemonics
echo "[4/5] Converting to assembly mnemonics..."
python3 <<'PYTHON' >> "$OUTPUT_FILE"
import sys

# Read disassembly
with open('/tmp/section_disasm.txt', 'r') as f:
    lines = f.readlines()

# Skip header lines
code_lines = [l for l in lines if l.strip() and not l.startswith('SH2') and not l.startswith('===')]

for line in code_lines:
    # Parse: "02220510  7101     ADD     #$01,R1"
    parts = line.strip().split()
    if len(parts) < 3:
        continue

    addr = parts[0]
    opcode = parts[1]
    mnemonic = ' '.join(parts[2:])

    # Convert to GNU as syntax (basic conversion)
    asm_line = mnemonic.lower()

    # Handle common conversions
    asm_line = asm_line.replace('#$', '#0x')
    asm_line = asm_line.replace('$', '0x')
    asm_line = asm_line.replace(',r', ',r')
    asm_line = asm_line.replace('@r', '@r')

    # Format with original address as comment
    print(f"    {asm_line:40s} /* {addr}: {opcode} */")

print("\n/* End of converted section */")
PYTHON

echo "      ✓ Converted to assembly"

echo "[5/5] Creating integration instructions..."
cat >> "$OUTPUT_FILE" <<EOF

/*
 * =================================================================
 * INTEGRATION STEPS
 * =================================================================
 *
 * 1. Review the assembly above:
 *    - Add proper function/label names
 *    - Separate code from data sections
 *    - Fix any addressing modes
 *
 * 2. Assemble to binary:
 *    sh-elf-as --isa=sh2 -o ${BASENAME}.o $OUTPUT_FILE
 *    sh-elf-objcopy -O binary ${BASENAME}.o ${BASENAME}.bin
 *
 * 3. Convert binary to dc.w format:
 *    od -An -tx2 -w2 ${BASENAME}.bin | awk '{print "        dc.w    \$" toupper(\$1)}'
 *
 * 4. Replace section in original file:
 *    - Backup original: cp $SECTION_FILE ${SECTION_FILE}.backup
 *    - Replace dc.w lines at offset $START_OFFSET
 *    - Rebuild and verify: make clean && make all
 *
 * 5. Verify byte-perfect match:
 *    hexdump -C build/vr_rebuild.32x -s $START_OFFSET -n $SIZE
 *    hexdump -C /tmp/section.bin -n $SIZE
 *
 * =================================================================
 */
EOF

echo ""
echo "==================================================================="
echo "✓ Conversion complete!"
echo "==================================================================="
echo "Output file: $OUTPUT_FILE"
echo ""
echo "Next steps:"
echo "  1. Review $OUTPUT_FILE"
echo "  2. Add labels and separate code/data"
echo "  3. Test assembly with: sh-elf-as --isa=sh2 -o /tmp/test.o $OUTPUT_FILE"
echo "  4. Verify binary matches: see integration steps in $OUTPUT_FILE"
echo ""
