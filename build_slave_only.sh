#!/bin/bash
# ============================================================================
# Slave-Only Build Script
# Only injects Slave code - does NOT modify Master SH2 code
# ============================================================================

set -e

echo "============================================================================"
echo "SLAVE-ONLY BUILD - Safe test without Master modifications"
echo "============================================================================"
echo ""

cd /mnt/data/src/32x-playground

mkdir -p build

# ============================================================================
# Step 1: Build base 4MB ROM
# ============================================================================

echo "[1/4] Building 4MB base ROM..."
make clean > /dev/null 2>&1 || true
make all

ROM_SIZE=$(stat -c%s build/vr_rebuild.32x 2>/dev/null || stat -f%z build/vr_rebuild.32x)
if [ "$ROM_SIZE" -ne 4194304 ]; then
    echo "ERROR: ROM is not 4MB (got $ROM_SIZE bytes)"
    exit 1
fi
echo "      Base ROM: 4MB OK"

# ============================================================================
# Step 2: Assemble Slave SH2 code
# ============================================================================

echo "[2/4] Assembling Slave SH2 code..."

if ! sh-elf-as -o build/sh2_slave_expansion.o disasm/sh2_slave_expansion.asm 2>build/sh2_slave.log; then
    echo "ERROR: Slave assembly failed:"
    cat build/sh2_slave.log
    exit 1
fi

if ! sh-elf-objcopy -O binary build/sh2_slave_expansion.o build/sh2_slave_expansion.bin; then
    echo "ERROR: Slave binary conversion failed"
    exit 1
fi

SLAVE_SIZE=$(stat -c%s build/sh2_slave_expansion.bin 2>/dev/null || stat -f%z build/sh2_slave_expansion.bin)
echo "      Slave code: $SLAVE_SIZE bytes"

# ============================================================================
# Step 3: Inject Slave code ONLY at expansion area
# ============================================================================

echo "[3/4] Injecting Slave code at 0x300000 only..."

cp build/vr_rebuild.32x build/vr_slave_only.32x

# Inject Slave code at offset 0x300000 (expansion area - safe)
dd if=build/sh2_slave_expansion.bin of=build/vr_slave_only.32x \
   bs=1 seek=$((0x300000)) conv=notrunc 2>/dev/null

echo "      Slave code injected"

# ============================================================================
# Step 4: Patch Slave entry point
# ============================================================================

echo "[4/4] Patching Slave SH2 entry point..."

# Write 0x02300000 at offset 0x3E4 (Slave entry point)
printf '\x02\x30\x00\x00' | dd of=build/vr_slave_only.32x \
   bs=1 seek=$((0x3E4)) conv=notrunc 2>/dev/null

echo "      Slave entry: 0x02300000"

# ============================================================================
# Verification
# ============================================================================

echo ""
echo "============================================================================"
echo "BUILD COMPLETE"
echo "============================================================================"

FINAL_SIZE=$(stat -c%s build/vr_slave_only.32x 2>/dev/null || stat -f%z build/vr_slave_only.32x)
echo ""
echo "Output: build/vr_slave_only.32x ($FINAL_SIZE bytes)"
echo ""
echo "Slave entry point (offset 0x3E4):"
xxd -s 0x3E4 -l 4 build/vr_slave_only.32x

echo ""
echo "Slave code (offset 0x300000, first 32 bytes):"
xxd -s 0x300000 -l 32 build/vr_slave_only.32x

echo ""
echo "Master code at 0x23024 (should be ORIGINAL code, not overwritten):"
xxd -s 0x23024 -l 32 build/vr_slave_only.32x

echo ""
echo "Test: picodrive build/vr_slave_only.32x"
echo ""
echo "This ROM:"
echo "  - Slave SH2 starts at our code (0x02300000)"
echo "  - Master SH2 code is UNTOUCHED"
echo "  - Slave will wait for WORK signal from Master"
echo "  - Since Master is not modified, Slave will just wait"
echo "  - Game should run normally (Slave idle, no crash)"
echo "============================================================================"
