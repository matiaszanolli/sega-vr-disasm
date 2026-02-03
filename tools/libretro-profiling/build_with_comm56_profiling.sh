#!/bin/bash
#
# Build PicoDrive libretro with COMM5/COMM6 + 68K + SH2 profiling (v4)
#
# This script:
# 1. Applies the v4 profiling patch (COMM5/COMM6 + PC sampling)
# 2. Builds picodrive_libretro.so with profiling enabled
# 3. Copies the binary to tools/libretro-profiling/
#

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$SCRIPT_DIR/../.."
PICODRIVE_DIR="$PROJECT_ROOT/third_party/picodrive"
PATCH_FILE="$SCRIPT_DIR/libretro_vrd_profiling_v4_comm56.patch"

cd "$PICODRIVE_DIR"

echo "=== PicoDrive v4 COMM5/COMM6 Profiling Build ==="
echo "PicoDrive dir: $PICODRIVE_DIR"
echo "Patch file: $PATCH_FILE"
echo ""

# Check if patch is already applied
if git diff --quiet; then
    echo "Applying profiling patch..."
    git apply "$PATCH_FILE"
    echo "✓ Patch applied"
else
    echo "⚠ Working tree has uncommitted changes"
    echo "  If patch already applied, continuing with build..."
fi

echo ""
echo "=== Building libretro core ==="
make -f Makefile.libretro platform=unix clean
make -f Makefile.libretro platform=unix -j$(nproc)

echo ""
echo "=== Copying binary ==="
cp picodrive_libretro.so "$SCRIPT_DIR/"
ls -lh "$SCRIPT_DIR/picodrive_libretro.so"

echo ""
echo "=== Build Complete ==="
echo "Binary: $SCRIPT_DIR/picodrive_libretro.so"
echo ""
echo "Usage (Frame-level profiling with COMM5/COMM6):"
echo "  VRD_PROFILE_LOG=frame.csv \\"
echo "  ./profiling_frontend /path/to/rom.32x 2400 --autoplay"
echo ""
echo "Usage (Frame + PC-level profiling):"
echo "  VRD_PROFILE_LOG=frame.csv \\"
echo "  VRD_PROFILE_PC=1 \\"
echo "  VRD_PROFILE_PC_LOG=pc.csv \\"
echo "  ./profiling_frontend /path/to/rom.32x 2400 --autoplay"
echo ""
echo "Analysis:"
echo "  python3 analyze_profile.py frame.csv"
echo ""
