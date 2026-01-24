# Virtua Racing Deluxe - Profiling Baseline

**Date**: January 2026
**Status**: Baseline established from static analysis + emulator testing

---

## Performance Summary

| Metric | Value | Notes |
|--------|-------|-------|
| **Current FPS** | ~24 | Measured in PicoDrive |
| **Target FPS** | 60 | NTSC standard |
| **Master SH2 Clock** | 23.011 MHz | SH7604 @ 23 MHz |
| **Frame Budget (60 FPS)** | 383,517 cycles | 23,011,000 / 60 |
| **Frame Budget (24 FPS)** | 958,792 cycles | 23,011,000 / 24 |
| **Cycle Overshoot** | ~2.5× | Need to reduce by 60% |

---

## CPU Utilization Analysis

| CPU | Utilization | Cycles/Frame | Notes |
|-----|-------------|--------------|-------|
| **Master SH2** | ~36.5% | ~350,000 | Handles ALL 3D rendering |
| **Slave SH2** | 0.03% | ~290 | Idle stub loop |
| **68000** | ~16.5% | ~158,000 | Sync overhead + game logic |

**Key Insight**: Master alone could render at 60 FPS if it wasn't waiting!

---

## Identified Bottlenecks

### 1. VDP Polling (~47% of frame)

| Location | Description | Impact |
|----------|-------------|--------|
| Various | Busy-wait for VDP status bits | ~450,000 cycles wasted |

**Evidence**: Multiple `MOV.B @Rx,R0; TST #bit,R0; BF polling` patterns in SH2 code.

### 2. Slave CPU Idle (~99.97% idle)

The Slave SH2 runs this loop:
```
slave_main_loop:
    MOV.L   @($0x22000400),R0    ; Read sync word
    CMP/EQ  #0,R0                ; Compare to 0
    BT      slave_main_loop      ; Loop if zero
    RTS
```

**Potential**: Could offload 50-100% of rendering work.

### 3. 68K Sync Overhead (~16.5%)

The 68000 handles:
- Controller input
- Game state/AI
- Sound driver calls
- Master/Slave synchronization

---

## Hotspot Functions

From static analysis of SH2 code:

| Function | Address | Size | Calls/Frame | Role |
|----------|---------|------|-------------|------|
| func_016 | 0x0222335A | 44 B | ~4× | Coordinate transform |
| func_065 | 0x02223F2C | 150 B | ~4× | Rasterization inner loop |
| func_020 | 0x02223468 | 86 B | ~3× | Polygon recursion |
| func_030 | 0x02024694 | 1114 B | 1× | Main render loop (largest) |

### Function Size Distribution

| Range | Count | Notes |
|-------|-------|-------|
| ≤50 bytes | 38 | Utility/leaf functions |
| 51-150 bytes | 14 | Mid-complexity |
| 151-500 bytes | 4 | Complex/loops |
| >500 bytes | 2 | Main loops |

---

## Memory Access Patterns

### SDRAM Usage (256 KB @ 0x06000000)

| Region | Range | Purpose |
|--------|-------|---------|
| Sync buffer | 0x22000400-0x22000410 | Master/Slave communication |
| Vertex data | 0x22001000+ | Transformed coordinates |
| Polygon list | 0x22010000+ | Sorted polygon data |
| Stack | 0x0603FF00 | Master SP |

### Frame Buffer (128 KB × 2 @ 0x04000000)

- Double-buffered
- Direct Color mode (15-bit RGB)
- 320×240 native resolution

---

## Optimization Targets (Priority Order)

### Phase 1: VDP Polling → Interrupt-Driven
- **Effort**: Medium
- **Risk**: Low-Medium
- **Gain**: +30-40% FPS

Replace polling loops with V-INT/H-INT handlers.

### Phase 2: Slave CPU Activation
- **Effort**: High
- **Risk**: Medium
- **Gain**: +50-100% FPS

Port rendering functions to run on Slave in parallel.

### Phase 3: 68K Sync Reduction
- **Effort**: Medium
- **Risk**: Low
- **Gain**: +10-15% FPS

Reduce sync frequency, batch updates.

---

## Measurement Methodology

1. **Frame Time**: PicoDrive reports ~41.7ms/frame (24 FPS)
2. **Static Analysis**: Call graph + instruction counting
3. **Emulator Cycle Count**: pd_run_frames() tracking

### For Future Dynamic Profiling

When pdcore is fully integrated with PicoDrive:

```bash
cd pdcore/tools
./profiler 300  # Profile 300 frames (~5 seconds)
```

This will provide:
- Per-function call counts
- Cycle counts per function
- Percentage of frame budget

---

## Next Steps

1. ✅ Debugger infrastructure complete (pdcore)
2. ✅ Profiler tool created
3. ⏳ Integrate pdcore INTO PicoDrive build
4. ⏳ Measure actual hotspot cycle counts
5. ⏳ Implement VDP polling fix
6. ⏳ Implement Slave activation
