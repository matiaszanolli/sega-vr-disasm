#!/bin/bash
# Async FPS Profiling Script
# Compares FPS between blocking and async versions

set -e

echo "========================================="
echo "Async Command Submission - FPS Profiling"
echo "========================================="
echo

# Build both versions
echo "Step 1: Building BLOCKING version (async disabled)..."
# Temporarily disable async call site
sed -i 's/\$EC16.*ASYNC/\$E3B6        ; $/mnt/data/src/32x-playground/disasm/sections/code_e200.asm
make clean && make all > /dev/null 2>&1
cp build/vr_rebuild.32x build/vr_blocking.32x
echo "  ✓ Built: build/vr_blocking.32x"
echo

echo "Step 2: Building ASYNC version (async enabled)..."
# Re-enable async call site
sed -i 's/\$E3B6.*$/\$EC16        ; $00FF60 - ASYNC: ENABLED/' /mnt/data/src/32x-playground/disasm/sections/code_e200.asm
make clean && make all > /dev/null 2>&1
cp build/vr_rebuild.32x build/vr_async.32x
echo "  ✓ Built: build/vr_async.32x"
echo

echo "Step 3: Manual Profiling Instructions"
echo "========================================="
echo
echo "BLOCKING VERSION TEST:"
echo "1. Load: build/vr_blocking.32x in PicoDrive"
echo "2. Start Time Trial - Grand Prix Canyon"
echo "3. Race for EXACTLY 60 seconds (use stopwatch)"
echo "4. After 60s, pause emulator and read memory:"
echo "   Address: 0x22000400 (SH2 frame counter)"
echo "5. Record the value as BLOCKING_FRAMES"
echo

echo "ASYNC VERSION TEST:"
echo "1. Load: build/vr_async.32x in PicoDrive"
echo "2. **CRITICAL**: Clear queue memory first!"
echo "   Using GDB or memory editor, write zeros to:"
echo "   Address: 0x00FFD000, Size: 32 bytes"
echo "3. Start same test scenario (Time Trial - Grand Prix Canyon)"
echo "4. Race for EXACTLY 60 seconds"
echo "5. Pause and read memory at 0x22000400"
echo "6. Record the value as ASYNC_FRAMES"
echo

echo "Step 4: Calculate Results"
echo "========================================="
echo
echo "Baseline FPS  = BLOCKING_FRAMES / 60"
echo "Async FPS     = ASYNC_FRAMES / 60"
echo "Improvement % = (ASYNC_FRAMES - BLOCKING_FRAMES) / BLOCKING_FRAMES * 100"
echo

echo "Expected baseline: ~1200 frames (20 FPS)"
echo "Success criteria: Async FPS > Blocking FPS"
echo

echo "========================================="
echo "Profiling setup complete!"
echo "Follow the manual instructions above."
echo "========================================="
