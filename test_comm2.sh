#!/bin/bash
# Quick test script for COMM2 increment

set -e

ROM="build/vr_rebuild.32x"

if [ ! -f "$ROM" ]; then
    echo "ROM not found: $ROM"
    exit 1
fi

echo "Testing COMM2 increment on Slave SH2..."
echo "ROM: $ROM"
echo ""

# Run pdcore integration test
cd pdcore/test
timeout 3 ./integration_real ../../$ROM 2>&1 | tee /tmp/test_output.txt || true

echo ""
echo "=== Results ==="
grep -E "(COMM2|SSH2|Frame)" /tmp/test_output.txt | head -20 || echo "No COMM2 updates found"
