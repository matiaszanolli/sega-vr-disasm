# COMM5/COMM6 Profiling (v4)

## Overview

Version 4 of the VRD profiling instrumentation adds support for tracking COMM5 and COMM6 registers to measure Master→Slave signal throughput and verify that the Slave SH2 can keep up with parallel processing signals.

## What's New in v4

### COMM Register Tracking
- **COMM5 ($2000402A)**: Slave acknowledgement counter
  - Incremented by Slave when it acknowledges a COMM7 signal
  - Phase 1: Slave increments this without executing work (measurement only)

- **COMM6 ($2000402C)**: Master signal counter
  - Incremented by Master when it sends work signal to Slave
  - Currently incremented via Phase 1 trampoline when func_021 is called

- **COMM7 ($2000402E)**: Signal register (unchanged from v3)
  - Set to 0x16 by Master to signal vertex transform work
  - Cleared to 0x00 by Slave to acknowledge

### Gap Analysis
The key metric is **Gap = COMM6 - COMM5**:
- Gap = 0: Perfect sync, Slave keeping up with all Master signals
- Gap > 0: Slave falling behind, work queue building up
- Gap < 0: Invalid state (should never happen)

## Building

```bash
cd tools/libretro-profiling
./build_with_comm56_profiling.sh
```

This will:
1. Apply `libretro_vrd_profiling_v4_comm56.patch` to PicoDrive
2. Build the instrumented libretro core
3. Copy `picodrive_libretro.so` to the profiling directory

## Usage

### Frame-Level Profiling with COMM5/COMM6
```bash
cd tools/libretro-profiling
VRD_PROFILE_LOG=profile.csv ./profiling_frontend ../../build/vr_rebuild.32x 3600 --autoplay
python3 analyze_profile.py profile.csv
```

### Combined Frame + PC-Level Profiling
```bash
VRD_PROFILE_LOG=frame.csv \
VRD_PROFILE_PC=1 \
VRD_PROFILE_PC_LOG=pc.csv \
./profiling_frontend ../../build/vr_rebuild.32x 2400 --autoplay

python3 analyze_profile.py frame.csv
python3 analyze_pc_profile.py pc.csv
```

## CSV Output Format

The v4 profiler produces CSV with these columns:

```
frame,m68k_cycles,msh2_cycles,ssh2_cycles,comm5_before,comm5_after,comm6_before,comm6_after,comm7_before,comm7_after,is_32x
```

### New Columns
- `comm5_before`: COMM5 value at frame start
- `comm5_after`: COMM5 value at frame end (Slave ACK count)
- `comm6_before`: COMM6 value at frame start
- `comm6_after`: COMM6 value at frame end (Master signal count)

## Analysis Output

The `analyze_profile.py` script now includes a **Phase 1 Parallel Processing Analysis** section:

```
=== PHASE 1 PARALLEL PROCESSING ANALYSIS ===
COMM6 = Master signals sent | COMM5 = Slave acknowledgements

Cumulative Counters (after 3600 frames):
  COMM6 (Master signals):  15,234
  COMM5 (Slave ACKs):      15,234
  Gap (pending work):      0
  Status: PERFECT SYNC - Slave keeping up with all Master signals

Throughput:
  Master signals/frame: 4.23
  Slave ACKs/frame:     4.23
```

### Status Interpretation
- **PERFECT SYNC** (gap = 0): Slave processing all signals
- **EXCELLENT** (gap 1-10): Slave nearly keeping up
- **GOOD** (gap 11-100): Minor lag
- **FALLING BEHIND** (gap > 100): Slave can't keep up with signal rate

## Implementation Details

### Patch Changes
The v4 patch (`libretro_vrd_profiling_v4_comm56.patch`) modifies:

1. **platform/libretro/libretro.c**:
   - Added COMM5/COMM6 sampling before/after frame
   - Updated CSV header with new columns
   - Modified fprintf to log COMM5/COMM6 values

2. **Unchanged from v3**:
   - 68K PC sampling (pico/pico_cmn.c)
   - SH2 PC sampling (cpu/sh2/mame/sh2pico.c)
   - Work cycle tracking (pico/32x/32x.c)

### Performance Impact
- Frame-level overhead: Negligible (6 additional register reads per frame)
- PC-level overhead: Same as v3 (~5-10% emulation slowdown)

## Phase 1 Measurement Goals

The v4 profiler is designed to validate Phase 1 implementation:

1. **Verify signaling**: Confirm Master sends signals via COMM7/COMM6
2. **Verify acknowledgement**: Confirm Slave processes signals and increments COMM5
3. **Measure gap**: Determine if Slave can keep up with Master's signal rate
4. **Baseline throughput**: Establish signals/frame before adding actual work in Phase 2

## Next Steps

Once Phase 1 shows **Gap ≈ 0** (Slave keeping up):
1. **Phase 2**: Have Slave actually execute work (call func_021_optimized)
2. **Validate synchronization**: Ensure no data races or corruption
3. **Measure FPS improvement**: Compare baseline vs parallel processing performance

## Reverting to v3

To revert to v3 profiler (without COMM5/COMM6):
```bash
cd third_party/picodrive
git checkout .  # Revert all patches
cd ../../tools/libretro-profiling
./build_with_68k_profiling.sh  # Rebuild with v3 patch
```

## Files Modified

- `libretro_vrd_profiling_v4_comm56.patch` (new)
- `build_with_comm56_profiling.sh` (new)
- `analyze_profile.py` (updated to read COMM5/COMM6)
- `README_COMM56_PROFILING.md` (this file)
