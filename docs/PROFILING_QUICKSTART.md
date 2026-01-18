# Profiling Quick Start Guide

## The Problem

VRD runs at **60 Hz V-INT** (Mega Drive timer) but only renders **~20 FPS SH2 frames** (actual graphics output). The V-INT counter (`$C964`) is useless for profiling because it doesn't reflect real frame rate.

**Solution**: Measure actual SH2 frame count over 60 seconds.

## Current Setup

### Frame Counter Location
- **Memory**: SDRAM address `0x22000400`
- **Size**: 32-bit word
- **Increments**: Once per SH2 frame (at `final_exit`)
- **Expected baseline**: ~1200 frames (20 FPS × 60s)

### Counter Code
- **ROM offset**: `0x02DD5C` (injected but not yet hooked)
- **CPU address**: `0x0202DD5C`
- **Status**: Ready for use but manual hook installation needed

## Quick Benchmark Test

### Without Hook (Manual Mode)

Since the automatic hook isn't installed, use this direct method:

```
BASELINE MEASUREMENT:
1. Load: build/vr_sh2_frame_counter_complete.32x
2. Start PicoDrive, navigate to your test scenario (racing, menu, etc.)
3. Note wall clock time at exactly start of gameplay
4. Play for exactly 60 seconds (use timer on phone/watch)
5. Check memory at 0x22000400 (emulator debugger if available)
6. Record the value → this is your baseline frame count

OPTIMIZED MEASUREMENT:
1. Build optimized version
2. Repeat steps 2-6
3. Compare: new_count / baseline_count = speedup
```

## The Bottleneck: VDP Polling (47% of CPU!)

From the analysis, **47% of V-INT time is wasted in polling loops**:

```
V-INT Handler (16.67ms total):
  Game logic:    1.4ms (8%)
  VDP polling:   7.8ms (47%) ← OPTIMIZE THIS!
  Idle/wait:     5.7ms (35%)
```

**Optimization target**: Replace polling with interrupt-driven approach to gain ~40% performance.

## Key Addresses

| Address | Purpose | Expected Value |
|---------|---------|-----------------|
| `0x22000400` | SH2 frame counter | ~1200 after 60s |
| `$C964` | V-INT counter | 3600 after 60s (not useful) |

## Summary

The profiling phase is complete:
- ✓ Frame completion point identified
- ✓ Measurement location ready (0x22000400)
- ✓ Benchmark methodology documented
- → Run manual 60-second test for baseline
- → Next: VDP polling optimization

See `PROFILING_PHASE_COMPLETE.md` for full technical details.
