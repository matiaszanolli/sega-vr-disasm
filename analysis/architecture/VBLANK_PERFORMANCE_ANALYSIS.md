# V-Blank Performance Analysis

**Complements:** [VINT_HANDLER_ARCHITECTURE.md](VINT_HANDLER_ARCHITECTURE.md) (mechanics) and [VINT_STATE_HANDLERS.md](VINT_STATE_HANDLERS.md) (per-state detail)
**Profiling basis:** PC-level profiling, March 2026 (2400-frame run, race mode)
**Last Updated:** 2026-03-10

---

## 1. The 49.4% Figure — What It Actually Is

PC profiling shows two Work RAM addresses accounting for ~30% of 68K time, both in the `wait_for_vblank` spin loop:

| PC Address | Share | Instruction |
|------------|-------|-------------|
| `$FF0010` | ~24.6% | `TST.W VINT_STATE.w` (4 cycles) |
| `$FF0014` | ~5.7% | `BNE.S .spin` (10 cycles taken) |

Combined with other V-blank-related polling in the BIOS adapter loop that executes the same pattern across all TV frames, the total V-blank synchronization overhead is **49.4% of all 68K cycles per TV frame**.

The hotspot is in Work RAM (`$FF0010`, `$FF0014`) because the BIOS adapter copies its main polling loop there at boot for faster execution.

### The Spin-Wait Loop

From [wait_for_vblank.asm](../../disasm/modules/68k/frame/wait_for_vblank.asm) (`$004998`, 18 bytes):

```asm
wait_for_vblank:
    move.w  #$0004, VINT_STATE.w   ; set flag (request VDP sync on next V-INT)
    move    #$2300, sr              ; enable interrupts (level 3+ — allows V-INT at level 6)
.spin:
    tst.w   VINT_STATE.w           ; test flag (4 cycles)
    bne.s   .spin                  ; loop if still set (10 cycles — branch taken)
    rts                             ; return when V-INT has cleared the flag
```

**Per iteration: 14 cycles** (TST.W = 4, BNE.S taken = 10).
**At 20 FPS:** ~12,000–14,000 iterations between V-INTs = ~49% of available 68K cycles.

The V-INT handler clears `VINT_STATE` immediately on entry (before dispatching to its state handler), so the spin exits at the earliest possible moment after V-INT fires.

---

## 2. Why 49.4% Is Unavoidable — The FPS Math

The V-blank spin time is **proportional to how much idle time the 68K has per TV frame**. At current FPS:

### Current State (~20 FPS, 3 TV frames / game frame)

```
Total 68K cycles per TV frame:  127,987  (100% utilization)

Time breakdown:
  49.4%  V-blank spin   ≈ 63,225 cycles  = 1.48 × TV frame spent spinning
  10.8%  COMM overhead  ≈ 13,822 cycles  (B-003/B-004/B-005 reduced from ~22%)
  39.8%  Useful work    ≈ 50,939 cycles
```

**What this means:** The 68K finishes its useful work + COMM overhead in ~64,761 cycles (~0.51 TV frames), then spins for ~63,225 cycles (~0.49 TV frames) waiting for the next V-INT. This repeats 3× per game frame (3 TV frames) to produce one rendered frame.

Per game frame totals (3 TV frames × 127,987 = 383,961 cycles):
- Useful work: ~152,700 cycles (~1.19 TV frames)
- COMM overhead: ~41,400 cycles (~0.32 TV frames)
- V-blank spin: **~189,600 cycles (~1.48 TV frames)**

### At 30 FPS (Tracks A+B, 2 TV frames / game frame)

Tracks A+B reduce useful work by ~34% (~152,700 → ~100,800 cycles):

```
Active cycles per game frame:  ~100,800 (useful) + ~28,000 (COMM) = ~128,800
TV frames needed:               2 (since 128,800 / 127,987 ≈ 1.01 TV frames)
V-blank spin per game frame:   2 × 127,987 - 128,800 ≈ 127,174 cycles
As % of total:                 127,174 / 255,974 ≈ 50%  (barely changes!)
```

**Key insight:** The absolute spin time halves (189,600 → 127,174 cycles), but its *percentage* of total 68K time barely changes (~49% → ~50%). This is expected: the spin fills whatever idle time is left in the TV frame budget, and idle time is always ~50% of total when running at integer TV-frame multiples.

### At 60 FPS (Track C required)

Useful work after Tracks A+B: ~100,800 cycles. Per TV frame budget: 127,987 cycles.

```
Active cycles (post A+B):  ~100,800 + ~28,000 = ~128,800
TV frame budget:            127,987
128,800 > 127,987 → does NOT fit in 1 TV frame
```

**60 FPS is impossible without Track C (pipeline overlap).** Even with the maximum known offload candidates (cmd_27 + angle + physics + trig + depth_sort = ~38% reduction), the 68K still needs ~1.1 TV frames of active work. Pipeline overlap is the only way to bring effective 68K time below 1 TV frame.

---

## 3. The STOP Instruction Opportunity

The 68K `STOP #imm` instruction halts the CPU until an interrupt fires at or above the SR mask set by the immediate value:

```asm
; Proposed replacement for wait_for_vblank spin:
wait_for_vblank_stop:
    move.w  #$0004, VINT_STATE.w   ; request state 4 on next V-INT
    stop    #$2300                  ; halt until interrupt at level 3+ (V-INT = level 6)
    ; CPU resumes here AFTER V-INT handler returns (VINT_STATE already cleared)
    rts
```

### Cost/Benefit Analysis

| Metric | Spin-Wait (current) | STOP (proposed) |
|--------|--------------------|-----------------|
| Cycles while idle | ~63,225/TV frame (busy) | ~0 (halted) |
| CPU bus usage | Continuous WRAM reads | Zero |
| Wake latency | Immediate (flag already clear) | 1 interrupt + handler |
| DMA contention | Yes — 68K bus reads conflict with VDP DMA | No |
| SH2 bus effect | Negligible (SH2 uses own SDRAM) | Negligible |
| **FPS impact** | — | **0%** |
| Implementation complexity | — | Trivial (1 instruction change) |
| Risk | — | Very low |

**FPS impact is 0%** for the same reason B-003/B-004/B-005 saved cycles but gained no FPS: the 68K is at 100% utilization, and cycle savings in the spin loop just move the idle time elsewhere (another V-blank spin in the next TV frame).

### Why STOP Is Still Worth Considering

1. **Reduces DMA bus-steal contention.** During V-blank, the VDP can DMA from 68K Work RAM to CRAM/VSRAM. The 68K's spin loop continuously reads WRAM (`$FFC87A`), competing for bus slots. With STOP, the bus is idle, giving DMA transfers full bandwidth.

2. **Reduces electromagnetic noise.** Continuous memory bus cycling generates more EMI than halt state. Minor but real.

3. **Prepares for Track C (pipeline overlap).** When we implement pipelined game logic (68K starts frame N+1 while SH2 renders frame N), we may need the 68K to briefly yield control at precise points. A clean STOP-based wait is easier to reason about than a spin with conditional logic.

4. **Standard practice.** Most professional 68K game code on Sega hardware uses `STOP #$2300` for V-blank waits. VRD's spin-wait is an anomaly inherited from early Sega BIOS patterns.

### Safety Notes

- `STOP #$2300` enables interrupts at level 3+ (SR mask = `$2300`). V-INT is level 6 — it will wake the CPU.
- H-INT is level 4 — it would also wake the CPU. If H-INT fires during the STOP, the CPU executes the H-INT handler, then returns to `STOP` state (SR re-halted by the exception mechanism). The V-INT handler's flag clearing still works correctly.
- The existing V-INT handler logic is unchanged — it still reads `VINT_STATE`, calls the state handler, and clears the flag. The only change is that the 68K is halted instead of spinning when it arrives at the STOP instruction.
- `STOP` is a privileged instruction (supervisor mode). The game runs in supervisor mode throughout — no issue.

**Related:** This would be a clean, low-risk code change. It modifies only `wait_for_vblank.asm` (18 bytes → 12 bytes). No other files need changes.

---

## 4. Performance Hog Inventory

| Hog | Location | Measured Cycles | Fixable? | Notes |
|-----|----------|-----------------|----------|-------|
| **V-blank spin-wait** | `wait_for_vblank` spin (`$FF0010`) | **~63,225/TV frame** | FPS-bound only | Spinning on `VINT_STATE.w` |
| **V-INT handler overhead** | MOVEM.L push+pop, dispatch | ~300/V-INT | Not worth it | ~60 cycles × 60 Hz = 3,600/sec |
| **State 9 palette copy** | `vint_state_fb_setup` ($001E42) | ~1,400/call | Potentially | 128 MOVE.L copy of 512 bytes |
| **State 12 triple VDP config** | `vint_state_complex` ($001BA8) | ~1,200/call | Research needed | 3× VDP register sets |
| **State 13/14 palette + FB** | `vint_state_fb_palette`/`fb_dma` | ~1,600/call each | Potentially | Palette copy from different sources |
| **Z80 bus arbitration** | States 0, 5, 7, 10 | ~50-200/call | Potentially | `BTST #0, $A11100` spin |
| **FM bit BTST spin** | State 6 (`$001CDA`) | ~20-40 | Negligible | Wait for VBLK bit |
| **STOP not used** | `wait_for_vblank` | 0 FPS gain | Yes (trivial) | Use `STOP #$2300` |

### Notes on Palette Copy (State 9/13/14)

Three state handlers transfer palette data from MD Work RAM to 32X palette RAM (`$A15200`):
- State 9: 128 × `MOVE.L` (512 bytes from `$A100`)
- State 13: JSR to copy routine (from `$B400`)
- State 14: JSR to copy routine (from `$FF6E00`)

A 512-byte palette copy costs ~4,000 cycles (128 longwords × ~6 cycles per MOVE.L including addressing). This runs during V-blank and must complete within the ~4,500-cycle V-blank period. There is no obvious optimization here — palette transfer is time-critical and already well-optimized.

### Notes on Z80 Bus Arbitration

States 0, 5, 7, and 10 request the Z80 bus with `MOVE.W #$0100, $A11100` and spin on `BTST #0, $A11100`. If the Z80 is actively using the bus (e.g., playing sound), this spin can be 10-200 cycles. This is an inherent synchronization cost; eliminating it would require the Z80 to run independently without bus arbitration (requires Z80 DMA redesign).

---

## 5. What CAN Be Optimized Within V-Blank

### Tier 1: Safe, Minimal Impact

| Change | Cycles Saved | Risk | FPS Gain |
|--------|-------------|------|---------|
| Replace spin with `STOP #$2300` | ~0 (absorbed) | Low | 0% |
| Combine redundant Z80 bus grants | ~100-300/frame | Low | 0% |

### Tier 2: Research Needed

| Change | Potential | Risk | Prerequisite |
|--------|-----------|------|-------------|
| Skip palette copy on frames with no palette changes | ~4,000/frame | Medium | Track which frames change palette |
| Reduce V-INT state handler chaining | ~200/frame | Low | Map full state sequence for race mode |

### Tier 3: Not Worth It

| Change | Why Not |
|--------|---------|
| Eliminate V-INT handler MOVEM overhead | Saves ~300 cycles vs 127,987 total = 0.2% |
| Merge states 0/1/2/8 (all use same handler) | Already identical — no duplication |
| Eliminate frame counter increment | Used by game logic — must keep |

### The Honest Assessment

**The 49.4% V-blank sync cannot be eliminated** until either:
1. The game frame fits in fewer TV frames (Tracks A+B → 2 TV frames = 30 FPS)
2. The 68K does useful work during V-blank instead of spinning (Track C pipeline overlap)

The V-blank period itself (~4,500 cycles out of 127,987) is already fully used for VDP register writes and palette transfers — no optimization opportunity there. The optimization opportunity is entirely in reducing the spin time by making the game frame shorter.

---

## 6. FPS Model Implications for V-Blank

### Why V-Blank Percentage Stays ~49% Across FPS Targets

At any FPS where the game frame fits in N TV frames:
- Active work per game frame ≈ (N−1) × 127,987 cycles
- V-blank spin per game frame ≈ 1 × 127,987 cycles
- V-blank percentage ≈ 1/N

At 20 FPS (N=3): 1/3 ≈ 33%... but we measure 49.4%. The discrepancy: the 68K also spins during V-blank in TV frames N+1 and N+2 (the frames where useful work doesn't fill the entire TV frame budget). In practice, every TV frame has some spin.

### What Changes at Each Threshold

| Target FPS | TV Frames / Game Frame | Spin Per Game Frame | Net Effect |
|------------|------------------------|--------------------|-----------|
| Current ~20 | 3 | ~189,600 cycles | Baseline |
| **30 FPS** | **2** | **~127,174 cycles** | **−62,426 spin cycles** |
| 60 FPS | 1 | ~0 (impossible without Track C) | Requires pipeline overlap |

### The Track C Connection

For 60 FPS, the 68K must prepare frame N+1 while SH2 renders frame N. During the V-blank period:
- Current: V-INT handler runs for ~300 cycles, then 68K spins until next game frame starts
- Track C: V-INT handler runs, then 68K **immediately starts** frame N+1 game logic (no spin)

This requires:
1. Double-buffered game state (frame N+1 logic doesn't overwrite frame N's render data)
2. Explicit barrier before frame flip (don't flip until SH2 finishes frame N)
3. A new synchronization primitive: "SH2 render complete" signal

The `wait_for_vblank` function would be repurposed or eliminated. The V-INT handler would signal frame completion, and the 68K would respond by starting the next frame immediately. The 49.4% spin vanishes because there is no idle time.

---

## 7. Related Documents

| Document | Relevance |
|----------|----------|
| [VINT_HANDLER_ARCHITECTURE.md](VINT_HANDLER_ARCHITECTURE.md) | Handler entry, dispatch table, interrupt priority |
| [VINT_STATE_HANDLERS.md](VINT_STATE_HANDLERS.md) | Per-state detailed disassembly and cycle estimates |
| [OPTIMIZATION_PLAN.md](../../OPTIMIZATION_PLAN.md) | Tracks A/B/C — the FPS improvement strategy |
| [ARCHITECTURAL_BOTTLENECK_ANALYSIS.md](../ARCHITECTURAL_BOTTLENECK_ANALYSIS.md) | Root cause: blocking pipeline serializes 68K+SH2 |
| [SYSTEM_EXECUTION_FLOW.md](../SYSTEM_EXECUTION_FLOW.md) | V-INT in context of the full frame timeline |
| [disasm/modules/68k/frame/wait_for_vblank.asm](../../disasm/modules/68k/frame/wait_for_vblank.asm) | The 18-byte spin-wait source |

---

*Generated: March 2026*
*Profiling basis: PC-level hotspot analysis (2400-frame race mode run)*
*Status: Performance analysis complete. Optimization targets identified.*
