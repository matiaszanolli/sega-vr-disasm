# Quick Extended Gameplay Capture

Since pit stop is automatic, here's the simplest approach:

## One-Command Extended Capture

For Phase 3.2:
```bash
timeout 180 picodrive build/vrd_phase3_final.32x 2>&1 | tee logs/phase3_gameplay_3min.log
```

For Phase 4.1:
```bash
timeout 180 picodrive build/vrd_phase4_linked.32x 2>&1 | tee logs/phase4_gameplay_3min.log
```

This will:
- Run each ROM for 3 minutes (180 seconds)
- Capture all output to a log file
- Include startup + at least 2-3 pit stops worth of time
- Give us 100s-1000s of DREQ blocks if blocking is real

## Then Analyze

```bash
python3 tools/analyze_fifo.py logs/phase3_gameplay_3min.log
python3 tools/analyze_fifo.py logs/phase4_gameplay_3min.log
```

## What to Expect

If FIFO blocking is real during pit stop:
```
Total blocks: 1500-3000
Blocks/second: 8-17
Blocks/frame (60 FPS): 0.1-0.3
```

(Much higher than the startup-only numbers we're seeing now)

## Current Findings

From startup-only logs:

| Metric | Phase 3.2 | Phase 4.1 |
|--------|-----------|-----------|
| Total DREQ blocks | 33 | 71 |
| Duration captured | 95s | 210s |
| Blocks/second | 0.3 | 0.3 |
| Blocks/frame | ~0 | ~0 |
| **Status** | Startup only | Startup only |

This is the "idle" or "startup" FIFO pattern - essentially negligible.

## Let's Get Gameplay Data

The difference between startup blocking and gameplay blocking is likely 10-100x different. Running for 3 minutes will give us actual pit stop + racing data.

Ready? Just run one of the one-command captures above for either ROM!
