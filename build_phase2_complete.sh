#!/bin/bash
# ============================================================================
# Phase 2 Complete Build Script
# Builds Master-Slave parallelization test ROM
# ============================================================================

set -e  # Exit on error

echo "============================================================================"
echo "PHASE 2 COMPLETE BUILD - Master/Slave Parallelization"
echo "============================================================================"
echo ""

cd /mnt/data/src/32x-playground

# Ensure build directory exists
mkdir -p build

# ============================================================================
# Step 1: Build base 4MB ROM
# ============================================================================

echo "[1/6] Building 4MB base ROM..."
make clean > /dev/null 2>&1 || true
make all

# Verify ROM size is 4MB
ROM_SIZE=$(stat -c%s build/vr_rebuild.32x 2>/dev/null || stat -f%z build/vr_rebuild.32x)
if [ "$ROM_SIZE" -ne 4194304 ]; then
    echo "ERROR: ROM is not 4MB (got $ROM_SIZE bytes)"
    exit 1
fi
echo "      Base ROM: 4MB OK"

# ============================================================================
# Step 2: Assemble Slave SH2 code
# ============================================================================

echo "[2/6] Assembling Slave SH2 code..."

if ! command -v sh-elf-as &> /dev/null; then
    echo "ERROR: sh-elf-as not found. Install sh-elf-binutils."
    exit 1
fi

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
# Step 3: Assemble Master sync functions
# ============================================================================

echo "[3/6] Assembling Master sync functions..."

if ! sh-elf-as -o build/sh2_master_sync_phase2.o disasm/sh2_master_sync_phase2.asm 2>build/sh2_master_sync.log; then
    echo "ERROR: Master sync assembly failed:"
    cat build/sh2_master_sync.log
    exit 1
fi

if ! sh-elf-objcopy -O binary build/sh2_master_sync_phase2.o build/sh2_master_sync_phase2.bin; then
    echo "ERROR: Master sync binary conversion failed"
    exit 1
fi

MASTER_SYNC_SIZE=$(stat -c%s build/sh2_master_sync_phase2.bin 2>/dev/null || stat -f%z build/sh2_master_sync_phase2.bin)
echo "      Master sync code: $MASTER_SYNC_SIZE bytes"

# ============================================================================
# Step 4: Assemble Master minimal dispatcher
# ============================================================================

echo "[4/6] Assembling Master minimal dispatcher..."

if ! sh-elf-as -o build/sh2_master_minimal_dispatcher.o disasm/sh2_master_minimal_dispatcher.asm 2>build/sh2_master_disp.log; then
    echo "ERROR: Master dispatcher assembly failed:"
    cat build/sh2_master_disp.log
    exit 1
fi

if ! sh-elf-objcopy -O binary build/sh2_master_minimal_dispatcher.o build/sh2_master_minimal_dispatcher.bin; then
    echo "ERROR: Master dispatcher binary conversion failed"
    exit 1
fi

MASTER_DISP_SIZE=$(stat -c%s build/sh2_master_minimal_dispatcher.bin 2>/dev/null || stat -f%z build/sh2_master_minimal_dispatcher.bin)
echo "      Master dispatcher: $MASTER_DISP_SIZE bytes"

# ============================================================================
# Step 5: Inject code into ROM
# ============================================================================

echo "[5/6] Injecting code into ROM..."

# Copy base ROM to output
cp build/vr_rebuild.32x build/vr_phase2_complete.32x

# Inject Slave code at offset 0x300000 (expansion area)
echo "      Injecting Slave code at ROM offset 0x300000..."
dd if=build/sh2_slave_expansion.bin of=build/vr_phase2_complete.32x \
   bs=1 seek=$((0x300000)) conv=notrunc 2>/dev/null

# Inject Master sync functions at offset 0x20750 (unused area in SH2 code)
echo "      Injecting Master sync at ROM offset 0x20750..."
dd if=build/sh2_master_sync_phase2.bin of=build/vr_phase2_complete.32x \
   bs=1 seek=$((0x20750)) conv=notrunc 2>/dev/null

# Inject Master dispatcher at func_001 entry (0x23024)
echo "      Injecting Master dispatcher at ROM offset 0x23024..."
dd if=build/sh2_master_minimal_dispatcher.bin of=build/vr_phase2_complete.32x \
   bs=1 seek=$((0x23024)) conv=notrunc 2>/dev/null

# ============================================================================
# Step 6: Patch Slave entry point
# ============================================================================

echo "[6/6] Patching Slave SH2 entry point..."

# The 32X header has Slave entry point at offset 0x3E4
# Original value: 0x06000288 (SDRAM)
# New value: 0x02300000 (ROM expansion area)

# Write 0x02300000 at offset 0x3E4 (big-endian)
printf '\x02\x30\x00\x00' | dd of=build/vr_phase2_complete.32x \
   bs=1 seek=$((0x3E4)) conv=notrunc 2>/dev/null

echo "      Slave entry: 0x02300000"

# ============================================================================
# Verification
# ============================================================================

echo ""
echo "============================================================================"
echo "BUILD VERIFICATION"
echo "============================================================================"

FINAL_SIZE=$(stat -c%s build/vr_phase2_complete.32x 2>/dev/null || stat -f%z build/vr_phase2_complete.32x)
echo ""
echo "Final ROM size: $FINAL_SIZE bytes ($(($FINAL_SIZE / 1024 / 1024))MB)"

# Verify Slave entry point
echo ""
echo "Slave entry point (offset 0x3E4):"
xxd -s 0x3E4 -l 4 build/vr_phase2_complete.32x

# Verify Slave code area
echo ""
echo "Slave code area (offset 0x300000, first 64 bytes):"
xxd -s 0x300000 -l 64 build/vr_phase2_complete.32x

# Verify Master sync area
echo ""
echo "Master sync area (offset 0x20750, first 64 bytes):"
xxd -s 0x20750 -l 64 build/vr_phase2_complete.32x

# Verify Master dispatcher area
echo ""
echo "Master dispatcher area (offset 0x23024, first 64 bytes):"
xxd -s 0x23024 -l 64 build/vr_phase2_complete.32x

echo ""
echo "============================================================================"
echo "BUILD COMPLETE"
echo "============================================================================"
echo ""
echo "Output ROM: build/vr_phase2_complete.32x"
echo ""
echo "Code locations:"
echo "  - Slave code:       ROM 0x300000 = SH2 0x02300000 ($SLAVE_SIZE bytes)"
echo "  - Master sync:      ROM 0x020750 = SH2 0x02020750 ($MASTER_SYNC_SIZE bytes)"
echo "  - Master dispatch:  ROM 0x023024 = SH2 0x02023024 ($MASTER_DISP_SIZE bytes)"
echo ""
echo "Test with emulator:"
echo "  picodrive build/vr_phase2_complete.32x"
echo "  blastem build/vr_phase2_complete.32x"
echo ""
echo "Expected behavior:"
echo "  - Slave SH2 starts at ROM code (0x02300000)"
echo "  - Master signals WORK to Slave"
echo "  - Slave processes polygon range 400-799"
echo "  - Both CPUs synchronize via shared memory at 0x22000400"
echo "============================================================================"
