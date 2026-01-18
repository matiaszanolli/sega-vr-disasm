# Phase 4.3: Proper FIFO Log Capture for Gameplay Analysis

**Status**: Initial capture complete, but captured startup only
**Issue**: Need extended gameplay logs to measure steady-state FIFO blocking
**Next**: Manual capture with proper timing

---

## Problem with Automated Capture

The initial `capture_and_analyze.sh` run captured:
- **Phase 3.2**: 33 DREQ blocks over startup period (95ms)
- **Phase 4.1**: 71 DREQ blocks over startup period (210ms)

This is **not representative** of steady-state gameplay. The messages were clustered at:
- Phase 3.2 timestamps: 01924-02019 (startup/initialization phase)
- Phase 4.1 timestamps: 01382-01592 (startup/initialization phase)

Your observation of "hundreds per frame during pit stop" is different - that's active gameplay blocking, not startup blocking.

---

## How to Capture Actual Gameplay Logs

### Method 1: Manual Redirect (Recommended)

```bash
# Terminal 1: Capture Phase 3.2 logs
# Let it run for 30-60 seconds, spend time at pit stop
picodrive build/vrd_phase3_final.32x 2>&1 | tee logs/phase3_gameplay.log &
PICODRIVE_PID=$!
sleep 20  # Wait for startup
# [Manually play at pit stop for 30+ seconds in the game window]
sleep 35
kill $PICODRIVE_PID 2>/dev/null || true
wait $PICODRIVE_PID 2>/dev/null
```

```bash
# Terminal 2: Capture Phase 4.1 logs
picodrive build/vrd_phase4_linked.32x 2>&1 | tee logs/phase4_gameplay.log &
PICODRIVE_PID=$!
sleep 20  # Wait for startup
# [Manually play at pit stop for 30+ seconds in the game window]
sleep 35
kill $PICODRIVE_PID 2>/dev/null || true
wait $PICODRIVE_PID 2>/dev/null
```

### Method 2: Separate Startup + Gameplay Capture

Separate the analysis into startup vs gameplay phases:

```bash
# Capture with long duration
picodrive build/vrd_phase3_final.32x 2>&1 | tee logs/phase3_full.log

# Then analyze just the gameplay portion:
# Skip first 30 seconds (startup), analyze from 30-90s (60s of gameplay)
grep "DREQ FIFO" logs/phase3_full.log | awk -F: '($1 > 30000) && ($1 < 90000)' > logs/phase3_gameplay_only.txt
python3 tools/analyze_fifo.py logs/phase3_gameplay_only.txt
```

---

## What to Look For in Gameplay Logs

**Expected steady-state pattern**:
```
02400:100: DREQ FIFO w16 without 68S?
02403:150: DREQ FIFO w16 without 68S?
02406:200: DREQ FIFO w16 without 68S?
...
[Many messages clustered together]
...
Per frame: 200-300+ blocks
Blocks/second: 4000-6000+
```

**Startup pattern** (what we captured):
```
01900:002: DREQ FIFO w16 without 68S?
01903:100: DREQ FIFO w16 without 68S?
...
[Sparse messages, then gap]
...
Per frame: <1 block
Blocks/second: <1
```

The difference is dramatic - gameplay should show **100-1000x more blocking** than startup.

---

## Key Insight from Initial Capture

Even though the startup logs show minimal blocking, we can observe:

| Metric | Phase 3.2 | Phase 4.1 | Comparison |
|--------|-----------|-----------|-----------|
| Total startup blocks | 33 | 71 | +115% (worse) |
| Time window | 95ms | 210ms | 2.2× longer |
| Blocks/second | 0.35 | 0.34 | Same rate |
| Startup pattern | Early spike | Early spike | Both startup-dominated |

**Interpretation**: Phase 4.1 has MORE total startup blocking (71 vs 33), but over longer time, so about the same rate.

---

## Next Steps

### Option A: Quick Verification (5 minutes)
1. Manually start Phase 3.2 ROM
2. Wait 10 seconds for startup
3. Stay at pit stop for 30 seconds
4. Quit and save logs
5. Re-run analysis on gameplay portion only

### Option B: Detailed Gameplay Analysis (15 minutes)
1. Capture 60+ seconds of each ROM
2. Separate into startup (0-10s) and gameplay (10-60s) portions
3. Analyze each separately
4. Compare blocking rates for actual rendering work

### Option C: If Startup Blocking is Already the Issue
If we determine that startup blocking is significant, we could:
- Profile the startup sequence to identify which operations trigger DREQ
- Optimize startup initialization order
- Defer non-critical frame buffer writes until after game starts

---

## Current Findings Summary

Based on initial capture:

**Startup FIFO Blocking**:
- Phase 3.2: 33 blocks (baseline)
- Phase 4.1: 71 blocks (+115% relative to Phase 3.2)
- **Possible interpretation**: Phase 4.1 parallelization creates additional startup overhead

**Actual Gameplay Blocking**:
- Unknown (need extended logs)
- Expected: 100-1000x higher based on your observation

**Priority**:
1. **Immediate**: Capture actual pit stop gameplay logs (20 minutes)
2. **Then**: Analyze gameplay blocking pattern
3. **Then**: Identify if VDP polling is bottleneck or something else

---

## Updated Analyzer Output Interpretation

When you see output like:
```
Total blocks: 33
Blocks/second: 0.35
Blocks/frame (60 FPS): 0.0
```

This means:
- 33 total DREQ blocking events in the log capture
- About 1 block every 3 seconds
- Essentially 0 blocks per frame (1 block per ~170 frames)
- **Verdict**: This is startup/idle blocking, not gameplay blocking

When you see (expected for gameplay):
```
Total blocks: 18000
Blocks/second: 300
Blocks/frame (60 FPS): 5
```

This would mean:
- 18,000 DREQ blocking events in a 60-second capture
- 300 blocks every second
- About 5 blocks per frame
- **Verdict**: Significant FIFO contention during rendering

---

## Quick Test: Are You Actually Seeing Startup Blocking?

Run this to count DREQ messages in the existing logs:

```bash
echo "Phase 3.2 startup:"
grep -c "DREQ FIFO" logs/phase3_baseline.log

echo "Phase 4.1 startup:"
grep -c "DREQ FIFO" logs/phase4_optimized.log

echo ""
echo "Time spans:"
echo "Phase 3.2: $(grep 'DREQ FIFO' logs/phase3_baseline.log | head -1 | cut -d: -f1) to $(grep 'DREQ FIFO' logs/phase3_baseline.log | tail -1 | cut -d: -f1)"
echo "Phase 4.1: $(grep 'DREQ FIFO' logs/phase4_optimized.log | head -1 | cut -d: -f1) to $(grep 'DREQ FIFO' logs/phase4_optimized.log | tail -1 | cut -d: -f1)"
```

---

## File Locations

- **Baseline logs**: `logs/phase3_baseline.log`, `logs/phase4_optimized.log`
- **Analyzer**: `tools/analyze_fifo.py`
- **Capture script**: `tools/capture_and_analyze.sh` (captures startup only, use manual method for gameplay)

---

## Recommendation

**For definitive FIFO analysis**, manually capture longer logs following Method 1 above, ensuring you spend 30+ seconds at pit stop during active rendering. This will show the true steady-state FIFO blocking pattern and guide optimization prioritization.

The initial startup logs suggest Phase 4.1 may have slightly more overhead, but we need gameplay data to make optimization decisions.
