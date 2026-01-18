# Phase 4.3: FIFO/DMA Bottleneck Investigation

**Status**: Active Investigation
**Date**: January 10, 2026
**Priority**: CRITICAL - Real performance bottleneck identified

---

## Quick Start: Three Steps to Measure Impact

### Step 1: Capture Picodrive Logs

**Option A: Automated (Recommended)**
```bash
./tools/capture_and_analyze.sh
```
This will:
1. Prompt you to run Phase 3.2 for 30 seconds (pit stop recommended)
2. Prompt you to run Phase 4.1 for 30 seconds
3. Automatically analyze both logs
4. Display comparison results

**Option B: Manual Log Capture**

For Phase 3.2:
```bash
picodrive build/vrd_phase3_final.32x 2>&1 | tee logs/phase3_baseline.log
# Run game for 30 seconds at pit stop, then quit Picodrive
```

For Phase 4.1:
```bash
picodrive build/vrd_phase4_linked.32x 2>&1 | tee logs/phase4_optimized.log
# Run game for 30 seconds at pit stop, then quit Picodrive
```

### Step 2: Analyze the Logs

```bash
mkdir -p analysis
python3 tools/analyze_fifo.py logs/phase3_baseline.log > analysis/phase3_fifo.txt
python3 tools/analyze_fifo.py logs/phase4_optimized.log > analysis/phase4_fifo.txt

# View results
cat analysis/phase3_fifo.txt
cat analysis/phase4_fifo.txt
```

### Step 3: Compare and Identify the Bottleneck

The key metric to watch:
```
Blocks/frame (60 FPS): [CRITICAL NUMBER]
Estimated impact: [Percentage of frame]
```

---

## What the Results Mean

### Example Output Interpretation

**If you see**:
```
Blocks/frame (60 FPS): 200
Percentage of frame: 15%
```

**This means**:
- Every frame, the SH2 is blocked ~200 times trying to write to frame buffer
- This consumes approximately 15% of total frame time
- Potential FPS gain if fixed: +15% (example: 26 FPS → 30 FPS)

### Expected Findings by Phase

| Scenario | Blocks/Frame | Impact | Interpretation |
|----------|--------------|--------|-----------------|
| **Severe blocking** | >300 | >20% | Major bottleneck, high-impact optimizations essential |
| **Moderate blocking** | 150-300 | 10-20% | Significant bottleneck, worth addressing |
| **Light blocking** | 50-150 | 5-10% | Minor bottleneck, optimization optional |
| **Minimal blocking** | <50 | <5% | Not a major issue, look elsewhere |

---

## Optimization Strategy Decision Tree

Based on your FIFO blocking measurements, prioritize optimizations:

### Decision 1: How severe is the blocking?

**IF blocking is >20% of frame time:**
→ Implement **Opportunity 1: Interrupt-Driven VDP** (highest impact)
- Replace 47% VDP polling loop with interrupt-driven monitoring
- Expected impact: 30-40% reduction in blocking
- Effort: Medium (requires VDP interrupt setup)

**ELSE IF blocking is 10-20%:**
→ Implement **Opportunity 2: FIFO Batching** first
- Consolidate individual pixel writes into block transfers
- Expected impact: 20-30% reduction in blocking
- Effort: Low (simple assembly change)

**ELSE IF blocking is <10%:**
→ Focus on other optimizations or next phases
- Blocking not primary constraint anymore
- Consider cache coherency or frame buffer partitioning

### Decision 2: Is blocking clustered or spread?

The analyzer reports:
```
Clusters: [NUMBER]
Avg blocks/cluster: [SIZE]
Max cluster size: [SIZE]
```

**IF clusters are large (>50 blocks/cluster):**
→ Problem is Master stalling on specific operations
→ Solution: Identify VDP polling points, replace with interrupts

**ELSE IF clusters are small/random (<10 blocks/cluster):**
→ Problem is scattered access pattern
→ Solution: Implement FIFO batching to consolidate writes

---

## Phase 4.3.1: Baseline Measurement (Current Task)

**Objective**: Quantify the FIFO bottleneck impact

**What to do**:
1. Run capture_and_analyze.sh (or manual steps above)
2. Record the key metrics:
   - Phase 3.2 blocks/frame: ______
   - Phase 3.2 impact %: ______
   - Phase 4.1 blocks/frame: ______
   - Phase 4.1 impact %: ______
   - Improvement: ______%

**Success criteria**:
- ✅ Both logs captured and analyzed
- ✅ Quantitative metrics extracted
- ✅ Impact percentage calculated
- ✅ Next optimization identified

**Expected outcome**:
You'll know exactly:
1. **How much blocking is happening** (blocks per frame)
2. **How much performance is being lost** (% of frame time)
3. **Whether Phase 4.1 parallelization helped or hurt** FIFO behavior
4. **Which optimization has the best ROI** (return on investment)

---

## Phase 4.3.2: Optimization Evaluation (After Baseline)

Once you have baseline measurements, we'll evaluate the four opportunities:

### Opportunity 1: Interrupt-Driven VDP Monitoring
**Current approach**: Master polls VDP status in tight loop (47% of frame)
```assembly
.vdp_poll_loop:
    mov.b   @(vdp_status), r0
    tst     r0, r0
    bt      .vdp_poll_loop  ; Loop until ready
```

**Problem**: During polling, Master can't service DMA requests
**Solution**: Use VDP interrupt to signal when ready, let Master do other work

**Estimated impact**:
- Frees up 47% of Master CPU time
- If blocking is in polling context: 30-40% reduction in FIFO blocks
- Potential FPS gain: +10-15%

---

### Opportunity 2: FIFO Write Batching
**Current approach**: Individual pixel writes (one word at a time)
```assembly
mov.l   r1, @r9      ; Write pixel (blocks if FIFO full)
add     #4, r9
mov.l   r1, @r9      ; Write pixel (blocks again)
add     #4, r9
```

**Problem**: Each write is separate FIFO operation, high block frequency
**Solution**: Write 3-4 words in sequence to maximize FIFO utilization

**Estimated impact**:
- 20-30% reduction in block count (some writes will be faster)
- Smoother frame buffer access pattern
- Potential FPS gain: +3-8%

---

### Opportunity 3: Slave Write Pattern Optimization
**Current approach**: Random offset writes to frame buffer
```assembly
Frame buffer address = base + random_offset
```

**Problem**: No spatial locality, cache misses, unpredictable access
**Solution**: Sequential writes (line-by-line, pixel-by-pixel)

**Estimated impact**:
- 10-15% reduction in blocking (better cache locality)
- More predictable memory access pattern
- Potential FPS gain: +2-4%

---

### Opportunity 4: Master/Slave Work Interleaving
**Current approach**: Sequential execution
```
Frame N:   Master renders → Slave renders → sync → Frame N+1
```

**Problem**: Master waits for Slave on each frame
**Solution**: Pipelined execution
```
Master frame N+1     while Slave frame N
```

**Estimated impact**:
- Depends on implementation, but potentially +5-10% if perfectly pipelined
- Requires careful timing to avoid desync

---

## Analysis Files Created

- **`tools/analyze_fifo.py`** - Log parser (executable)
- **`tools/capture_and_analyze.sh`** - Automated capture + analysis (executable)
- **`logs/`** - Directory for captured logs (create as needed)
- **`analysis/`** - Directory for analysis results (create as needed)

---

## Command Reference

### Capture logs
```bash
./tools/capture_and_analyze.sh
```

### Analyze manually
```bash
python3 tools/analyze_fifo.py logs/phase3_baseline.log
python3 tools/analyze_fifo.py logs/phase4_optimized.log
```

### Compare results
```bash
diff analysis/phase3_fifo.txt analysis/phase4_fifo.txt
```

---

## Next Steps After Baseline

### If FIFO blocking is HIGH (>20%)
1. Measure exactly how much time is spent in VDP polling
2. Identify the polling loop location in Master code
3. Design interrupt-driven replacement
4. Implement and test

### If FIFO blocking is MODERATE (10-20%)
1. Implement FIFO write batching in Slave rendering functions
2. Test performance improvement
3. If still not optimal, implement Opportunity 1

### If FIFO blocking is LOW (<10%)
1. Focus on other bottlenecks
2. May proceed to Phase 4.4+ optimizations (cache, memory layout)

---

## Expected Timeline

- **Baseline measurement**: 30 minutes (log capture + analysis)
- **Decision making**: 15 minutes (review results, select optimization)
- **Implementation**: 2-4 hours depending on complexity
- **Testing**: 1-2 hours (measure improvement, validate correctness)

**Total**: 4-8 hours to complete Phase 4.3 including implementation of one optimization

---

## Key Metric to Watch

```
Potential FPS gain if fixed: [X%]
```

This single number tells you how much performance improvement is theoretically possible if you completely eliminate FIFO blocking. If it's >15%, the effort is definitely worth it.

---

## Reference

- **Log format**: `HH:MM:SSS: DREQ FIFO w16 without 68S?`
- **DREQ**: DMA Request (SH2 wants to write)
- **FIFO**: Queue buffer for DMA operations
- **w16**: 16-bit word write
- **without 68S**: 68000 not in SH2-Write-Safe state
- **?**: Operation blocked/rejected

---

## Begin Analysis Now

Ready to measure the bottleneck?

```bash
./tools/capture_and_analyze.sh
```

Or manually:
```bash
# Terminal 1: Capture Phase 3.2
picodrive build/vrd_phase3_final.32x 2>&1 | tee logs/phase3_baseline.log

# Terminal 2: Capture Phase 4.1
picodrive build/vrd_phase4_linked.32x 2>&1 | tee logs/phase4_optimized.log

# Terminal 3: Analyze
mkdir -p analysis logs
python3 tools/analyze_fifo.py logs/phase3_baseline.log > analysis/phase3_fifo.txt
python3 tools/analyze_fifo.py logs/phase4_optimized.log > analysis/phase4_fifo.txt
cat analysis/phase3_fifo.txt
cat analysis/phase4_fifo.txt
```

**Let me know the results and we'll identify which optimization to implement first!**
