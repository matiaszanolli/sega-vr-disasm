# FPS Measurement Guide for Virtua Racing 32X

**Date:** 2026-01-06
**Purpose:** Practical methods to measure frame rate for optimization validation

---

## The Goal

Measure **baseline FPS** (~24 FPS) and **post-optimization FPS** (target: 60 FPS) to validate performance improvements.

---

## Option 1: Gens Built-in FPS Counter ⭐ **RECOMMENDED**

Most emulators have built-in FPS displays. Check Gens KMod menus for:

**Possible locations:**
- `Graphics → Frame Rate`
- `Graphics → Show FPS`
- `View → FPS Counter`
- `Info → Statistics`
- `CPU → Show Performance`
- `Sound → Frame Rate` (sometimes grouped here)

**How to check:**
```bash
wine Gens_KMod_v0.7.3/gens.exe "Virtua Racing Deluxe (USA).32x"
```

Then browse all menus looking for FPS/frame rate display option.

**If found:**
✅ Enable it
✅ Start a race
✅ Observe FPS (should be ~24 FPS for unoptimized ROM)
✅ Take screenshots for documentation

---

## Option 2: OBS Studio FPS Overlay 🎥

**Install OBS Studio:**
```bash
# Linux
sudo apt-get install obs-studio

# Or download from: https://obsproject.com/
```

**Setup:**
1. Launch OBS Studio
2. Add window capture source (Gens emulator)
3. Start recording or preview
4. OBS shows FPS in bottom status bar
5. Can also add FPS overlay to video:
   - Filters → Text (FreeType 2)
   - Add FPS counter text

**Advantages:**
- Shows exact FPS
- Records gameplay for analysis
- Works with any emulator
- Can compare side-by-side videos

---

## Option 3: MangoHud (Linux) 🐧

**Install:**
```bash
sudo apt-get install mangohud
```

**Usage:**
```bash
mangohud wine Gens_KMod_v0.7.3/gens.exe "Virtua Racing Deluxe (USA).32x"
```

Displays FPS overlay on screen automatically.

---

## Option 4: Manual Benchmarking ⏱️

If no FPS counter available, use **time-based benchmarks**:

### Method A: Timed Section
1. Pick reproducible section (e.g., "Time from start to first turn")
2. **Baseline**: Record time with stopwatch (should be ~1.7 seconds at 24 FPS)
3. **After optimization**: Record again (target: ~0.7 seconds at 60 FPS)
4. Calculate FPS improvement: `baseline_time / new_time`

### Method B: Frame Counting
1. Record 10 seconds of gameplay with phone camera
2. Play back in slow motion
3. Count frames displayed
4. FPS = frames / 10

### Method C: Lap Times
1. Complete full lap on same track
2. Note lap time
3. Faster lap time = higher FPS (assuming same driving)
4. Compare: `baseline_lap_time / optimized_lap_time`

---

## Option 5: In-ROM FPS Counter (Future)

**Status:** Planned but complex

See [analysis/FRAME_COUNTER_IMPLEMENTATION.md](analysis/FRAME_COUNTER_IMPLEMENTATION.md) for plan to inject native FPS counter into ROM.

**Requires:**
- SH2 assembly code injection
- Frame buffer digit rendering
- Frame counter logic

**Timeline:** Week 2-3 after basic optimizations prove successful

---

## Recommended Workflow

### Phase 1: Establish Baseline ✅

```bash
# 1. Check if Gens has FPS counter
wine Gens_KMod_v0.7.3/gens.exe "Virtua Racing Deluxe (USA).32x"
# Browse menus for FPS option

# 2. If not, use OBS Studio
obs-studio &
# Record gameplay with FPS visible

# 3. Run baseline test
#    - Start race
#    - Drive for 30 seconds
#    - Record FPS (should be ~24)
#    - Take screenshot
```

**Expected baseline:** ~24 FPS

### Phase 2: Apply Optimization

```bash
# Apply VDP interrupt patch (when ready)
python3 tools/patch_vdp_interrupts.py \
    "Virtua Racing Deluxe (USA).32x" \
    "VR-Optimized.32x"
```

### Phase 3: Measure Improvement ✅

```bash
# Run optimized ROM
wine Gens_KMod_v0.7.3/gens.exe "VR-Optimized.32x"

# Same test conditions as baseline:
#  - Same track
#  - Same race mode
#  - Same emulator settings

# Record FPS (target: 40-60 FPS)
# Take screenshot
```

**Expected improvement:** 24 FPS → 40+ FPS (1.6x-2.5x)

### Phase 4: Document Results 📊

```markdown
## Optimization Results

**Baseline (Unmodified ROM):**
- FPS: 24
- Frame time: 41.67ms
- VDP polling: 63.5% CPU wasted

**After VDP Interrupt Optimization:**
- FPS: 45 (estimated)
- Frame time: 22.22ms
- Improvement: 1.875x

**After Full Optimization (VDP + Slave CPU + 68K sync):**
- FPS: 60 (target)
- Frame time: 16.67ms
- Improvement: 2.5x
```

---

## Validation Checklist

Before/after comparison should include:

- [ ] Same track (recommend: First track, no traffic)
- [ ] Same game mode (time trial preferred - no AI)
- [ ] Same emulator version
- [ ] Same emulator settings (no frameskip, vsync off)
- [ ] 30+ seconds of gameplay for stable reading
- [ ] Screenshot of FPS counter
- [ ] Multiple runs to confirm consistency

---

## Expected FPS Targets

Based on our CPU analysis ([analysis/BOTTLENECK_ANALYSIS.md](analysis/BOTTLENECK_ANALYSIS.md)):

| Stage | FPS | Improvement | Bottleneck Remaining |
|-------|-----|-------------|----------------------|
| **Baseline** | 24 | - | VDP polling (63.5%) |
| **VDP Interrupts** | 40-50 | 1.6-2.0x | Slave CPU idle (99.97%) |
| **Slave CPU Active** | 55-65 | 2.3-2.7x | 68K sync overhead |
| **68K Optimization** | 60+ | 2.5x+ | Theoretical max |

---

## Quick Start

**Right now, let's measure baseline:**

1. Launch Gens and check for FPS counter:
   ```bash
   wine Gens_KMod_v0.7.3/gens.exe "Virtua Racing Deluxe (USA).32x"
   ```

2. Browse **all menus** for FPS/frame rate option

3. If found: Enable it and start a race

4. Take screenshot showing FPS

5. Report back with baseline FPS number

**If Gens doesn't have FPS counter**, we'll use OBS Studio (Option 2).

---

## Next Steps After Measurement

Once we have baseline FPS:

1. ✅ Confirm ~24 FPS baseline
2. ⏳ Implement VDP interrupt optimization
3. ⏳ Test optimized ROM
4. ⏳ Measure FPS improvement
5. ⏳ If <60 FPS, implement Slave CPU optimization
6. ⏳ Measure again
7. ⏳ Iterate until 60 FPS achieved

---

**Status:** Ready to measure baseline FPS
**Next:** Check if Gens has built-in FPS counter
