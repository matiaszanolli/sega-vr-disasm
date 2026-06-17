#!/bin/bash
# Profiling Session Helper for Virtua Racing 32X
# Simplifies the workflow of running GDB profilers with Gens emulator

set -e

PROFILE_TYPE="${1:-vdp_polling}"
ROM="Virtua Racing Deluxe (USA).32x"
GENS_PATH="Gens_KMod_v0.7.3/gens.exe"

# Determine GDB port based on profile type
case "$PROFILE_TYPE" in
    slave_cpu)
        GDB_PORT=6871  # Slave SH2
        ;;
    *)
        GDB_PORT=6870  # Master SH2 (default)
        ;;
esac

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}======================================================================${NC}"
echo -e "${BLUE} Virtua Racing 32X - Profiling Session${NC}"
echo -e "${BLUE}======================================================================${NC}"
echo ""
echo -e "${GREEN}Profile Type:${NC} $PROFILE_TYPE"
echo -e "${GREEN}ROM:${NC} $ROM"
echo ""

# Check prerequisites
echo -e "${YELLOW}Checking prerequisites...${NC}"

if [ ! -f "$ROM" ]; then
    echo -e "${RED}❌ ROM not found: $ROM${NC}"
    exit 1
fi
echo -e "${GREEN}✓${NC} ROM found"

if [ ! -f "$GENS_PATH" ]; then
    echo -e "${RED}❌ Gens emulator not found: $GENS_PATH${NC}"
    exit 1
fi
echo -e "${GREEN}✓${NC} Gens emulator found"

if ! command -v gdb-multiarch &> /dev/null; then
    echo -e "${RED}❌ gdb-multiarch not found. Please install: sudo apt-get install gdb-multiarch${NC}"
    exit 1
fi
echo -e "${GREEN}✓${NC} gdb-multiarch found"

if ! command -v wine &> /dev/null; then
    echo -e "${YELLOW}⚠️  Wine not found. Gens may not run on Linux without Wine.${NC}"
    echo -e "${YELLOW}   Install with: sudo apt-get install wine${NC}"
fi

echo ""

# Generate GDB script
echo -e "${YELLOW}Generating GDB script for '$PROFILE_TYPE'...${NC}"
python3 tools/gdb_profiler.py "$PROFILE_TYPE" > /tmp/profiler_output.txt 2>&1

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Failed to generate GDB script${NC}"
    cat /tmp/profiler_output.txt
    exit 1
fi

GDB_SCRIPT=$(grep "GDB script written:" /tmp/profiler_output.txt | awk '{print $5}')
echo -e "${GREEN}✓${NC} GDB script generated: $GDB_SCRIPT"

echo ""
echo -e "${BLUE}======================================================================${NC}"
echo -e "${BLUE} PROFILING WORKFLOW${NC}"
echo -e "${BLUE}======================================================================${NC}"
echo ""

echo -e "${YELLOW}STEP 1: Start Gens Emulator${NC}"
echo -e "Run this command in a ${GREEN}SEPARATE TERMINAL${NC}:"
echo -e "${GREEN}  wine \"$GENS_PATH\" \"$ROM\"${NC}"
echo ""
echo -e "Then in Gens menu:"
echo -e "  1. Navigate to: ${GREEN}Tools → GDB Stub → Start${NC}"
echo -e "  2. Enable all GDB stubs (Main 68K, Sub 68K, Master SH2, Slave SH2)"
echo -e "  3. This profile will connect to: ${GREEN}port $GDB_PORT${NC}"
echo -e "     (Master SH2: 6870, Slave SH2: 6871)"
echo ""
echo -e "${RED}Press ENTER when Gens is running and GDB stub is enabled...${NC}"
read -r

echo ""
echo -e "${YELLOW}STEP 2: Testing GDB connection...${NC}"

# Test if GDB stub is accessible
timeout 2 bash -c "echo quit | gdb -batch -ex 'set confirm off' -ex 'target remote localhost:$GDB_PORT' 2>&1" > /tmp/gdb_test.txt || true

if grep -q "Remote debugging using" /tmp/gdb_test.txt; then
    echo -e "${GREEN}✓${NC} GDB stub is accessible on port $GDB_PORT"
else
    echo -e "${RED}❌ Cannot connect to GDB stub on port $GDB_PORT${NC}"
    echo -e "${YELLOW}Make sure you enabled the GDB stub in Gens menu!${NC}"
    echo ""
    echo "GDB connection test output:"
    cat /tmp/gdb_test.txt
    exit 1
fi

echo ""
echo -e "${YELLOW}STEP 3: Running GDB profiler...${NC}"
echo -e "This will:"
echo -e "  • Connect to Gens emulator"
echo -e "  • Set breakpoints at profiling locations"
echo -e "  • Start collecting data"
echo ""
echo -e "${GREEN}Instructions:${NC}"
echo -e "  1. Let the profiler run for ${YELLOW}5-10 seconds${NC}"
echo -e "  2. Press ${YELLOW}Ctrl+C${NC} to pause"
echo -e "  3. Examine results with: ${GREEN}info variables poll_count_${NC} (for VDP)"
echo -e "  4. Type ${GREEN}quit${NC} to exit GDB"
echo ""
echo -e "${RED}Press ENTER to start profiling...${NC}"
read -r

echo ""
echo -e "${GREEN}Starting GDB profiler...${NC}"
echo ""

# Run GDB with the generated script
gdb-multiarch -x "$GDB_SCRIPT"

echo ""
echo -e "${BLUE}======================================================================${NC}"
echo -e "${BLUE} PROFILING SESSION COMPLETE${NC}"
echo -e "${BLUE}======================================================================${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo -e "  1. Review the GDB output above"
echo -e "  2. Save important data to: ${GREEN}analysis/${PROFILE_TYPE^^}_DATA.txt${NC}"
echo -e "  3. Analyze the data and create: ${GREEN}analysis/${PROFILE_TYPE^^}_ANALYSIS.md${NC}"
echo ""
