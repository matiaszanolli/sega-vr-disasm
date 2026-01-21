#!/bin/bash
# ============================================================================
# Slave SH2 Activation Build Script
# Builds Slave rendering code and injects into 4MB ROM
# ============================================================================

set -e  # Exit on error

echo "============================================================================"
echo "SLAVE SH2 ACTIVATION BUILD"
echo "============================================================================"
echo ""

cd /mnt/data/src/32x-playground

# Ensure build directory exists
mkdir -p build

# ============================================================================
# Step 1: Build base 4MB ROM
# ============================================================================

echo "[1/5] Building 4MB base ROM..."
make clean > /dev/null 2>&1 || true
make all

# Verify ROM size is 4MB
ROM_SIZE=$(stat -c%s build/vr_rebuild.32x 2>/dev/null || stat -f%z build/vr_rebuild.32x)
if [ "$ROM_SIZE" -ne 4194304 ]; then
    echo "ERROR: ROM is not 4MB (got $ROM_SIZE bytes)"
    exit 1
fi
echo "      Base ROM: 4MB"

# ============================================================================
# Step 2: Assemble Slave SH2 code
# ============================================================================

echo "[2/5] Assembling Slave SH2 code..."

# Check for assembler
if ! command -v sh-elf-as &> /dev/null; then
    echo "ERROR: sh-elf-as not found. Install sh-elf-binutils."
    exit 1
fi

# Assemble the Slave code
if ! sh-elf-as -o build/sh2_slave_expansion.o disasm/sh2_slave_expansion.asm 2>build/sh2_assemble.log; then
    echo "ERROR: Assembly failed. Check build/sh2_assemble.log"
    cat build/sh2_assemble.log
    exit 1
fi

# Convert to binary
if ! sh-elf-objcopy -O binary build/sh2_slave_expansion.o build/sh2_slave_expansion.bin; then
    echo "ERROR: Binary conversion failed"
    exit 1
fi

SLAVE_SIZE=$(stat -c%s build/sh2_slave_expansion.bin 2>/dev/null || stat -f%z build/sh2_slave_expansion.bin)
echo "      Slave code assembled: $SLAVE_SIZE bytes"

# ============================================================================
# Step 3: Assemble Master sync hooks
# ============================================================================

echo "[3/5] Assembling Master sync hooks..."

if ! sh-elf-as -o build/sh2_master_sync_phase2.o disasm/sh2_master_sync_phase2.asm 2>>build/sh2_assemble.log; then
    echo "ERROR: Master sync assembly failed"
    exit 1
fi

if ! sh-elf-objcopy -O binary build/sh2_master_sync_phase2.o build/sh2_master_sync_phase2.bin; then
    echo "ERROR: Master sync binary conversion failed"
    exit 1
fi

MASTER_SIZE=$(stat -c%s build/sh2_master_sync_phase2.bin 2>/dev/null || stat -f%z build/sh2_master_sync_phase2.bin)
echo "      Master sync code: $MASTER_SIZE bytes"

# ============================================================================
# Step 4: Inject code into ROM
# ============================================================================

echo "[4/5] Injecting Slave code into ROM..."

# Copy base ROM to output
cp build/vr_rebuild.32x build/vr_slave_activated.32x

# Inject Slave code at offset 0x300000 (expansion area)
echo "      Injecting Slave code at ROM offset 0x300000..."
dd if=build/sh2_slave_expansion.bin of=build/vr_slave_activated.32x \
   bs=1 seek=$((0x300000)) conv=notrunc 2>/dev/null

# Verify injection
INJECTED=$(xxd -s 0x300000 -l 32 build/vr_slave_activated.32x)
if echo "$INJECTED" | grep -q "0000 0000 0000 0000"; then
    echo "WARNING: Injection may have failed (zeros at injection point)"
fi

echo "      Code injected successfully"

# ============================================================================
# Step 5: Verify and report
# ============================================================================

echo "[5/5] Verifying build..."

FINAL_SIZE=$(stat -c%s build/vr_slave_activated.32x 2>/dev/null || stat -f%z build/vr_slave_activated.32x)
echo "      Final ROM size: $FINAL_SIZE bytes ($(($FINAL_SIZE / 1024 / 1024))MB)"

# Check ROM header still shows 4MB
HEADER=$(xxd -s 0x1A4 -l 4 build/vr_slave_activated.32x | awk '{print $2$3}')
if [ "$HEADER" != "003fffff" ]; then
    echo "WARNING: ROM header may be incorrect (expected 003fffff, got $HEADER)"
fi

# Show first bytes of Slave code area
echo ""
echo "Slave code area (0x300000):"
xxd -s 0x300000 -l 64 build/vr_slave_activated.32x

echo ""
echo "============================================================================"
echo "BUILD COMPLETE"
echo "============================================================================"
echo ""
echo "Output ROM: build/vr_slave_activated.32x"
echo "Size: $FINAL_SIZE bytes (4MB)"
echo ""
echo "Slave SH2 code:"
echo "  - Location: ROM 0x300000 = SH2 CPU 0x02300000"
echo "  - Size: $SLAVE_SIZE bytes"
echo "  - Entry: slave_main_loop at 0x02300000"
echo ""
echo "Test on emulator:"
echo "  blastem build/vr_slave_activated.32x"
echo ""
echo "Note: This ROM has Slave code installed but the Slave entry point"
echo "needs to be set in the 32X header/vectors for full activation."
echo "============================================================================"
