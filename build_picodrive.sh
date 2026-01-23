#!/bin/bash
#
# PicoDrive Build Wrapper
#
# Usage:
#   ./build_picodrive.sh               # Standard build (no pdcore)
#   ./build_picodrive.sh --pdcore      # Build with pdcore integration
#   ./build_picodrive.sh --clean       # Clean build artifacts
#

set -e

cd third_party/picodrive

if [ "$1" = "--clean" ]; then
    echo "==> Cleaning PicoDrive..."
    make clean
    exit 0
fi

if [ "$1" = "--pdcore" ]; then
    echo "==> Building PicoDrive WITH pdcore integration..."
    ENABLE_PDCORE=1 make
    echo ""
    echo "✓ PicoDrive built with pdcore support"
    echo "  Binary: third_party/picodrive/picodrive"
    echo "  Debug hooks enabled (breakpoints, V-BLANK callbacks)"
    exit 0
fi

# Default: standard build without pdcore
echo "==> Building PicoDrive (standard, no pdcore)..."
make
echo ""
echo "✓ PicoDrive built (standard configuration)"
echo "  Binary: third_party/picodrive/picodrive"
echo "  Debug hooks present but inactive (NULL pointers)"
