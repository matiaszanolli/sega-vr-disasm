# Phase 17 Memory Inspection Guide

**Purpose:** Read cycle measurement results from Phase 17.1 (Slave) and Phase 17.2 (Master) ROMs

**Date:** 2026-01-22

---

## Memory Map

### Phase 17.1: Slave CPU Results

| Address | Contents | Expected Value |
|---------|----------|----------------|
| 0x22000300 | Slave cycle count | ~376-440 cycles |
| 0x22000304 | Slave FRT start | 0x0000-0xFFFF |
| 0x22000308 | Slave FRT end | 0x0000-0xFFFF |
| 0x2200030C | Slave wrap flag | 0 (no wrap) or 1 (wrapped) |

### Phase 17.2: Master CPU Results

| Address | Contents | Expected Value |
|---------|----------|----------------|
| 0x22000320 | Master cycle count | ~376-440 cycles |
| 0x22000324 | Master FRT start | 0x0000-0xFFFF |
| 0x22000328 | Master FRT end | 0x0000-0xFFFF |
| 0x2200032C | Master wrap flag | 0 (no wrap) or 1 (wrapped) |

### Shared Data

| Address | Contents | Expected Value |
|---------|----------|----------------|
| 0x220002FC | Done flag | 0x00010001 (transform complete) |
| 0x22000200 | Input vertices | 4 × 16 bytes |
| 0x22000240 | Identity matrix | 64 bytes |
| 0x22000280 | Output vertices | 4 × 16 bytes (should match input) |

---

## Reading Memory with Debugger

### Option 1: PicoDrive with pdcore (Recommended)

```bash
# Build pdcore library (if not already built)
cd pdcore
make clean && make

# Create memory reader tool
gcc -o read_cycle_counts tools/read_cycle_counts.c \
    pdcore/src/*.c pdcore/tests/pdcore_bridge_stubs.c \
    -Ipdcore/include -O2

# Read Phase 17.1 (Slave) results
./read_cycle_counts build/vr_phase17_1.32x 180

# Read Phase 17.2 (Master) results
./read_cycle_counts build/vr_phase17_2.32x 180
```

**Note:** Currently requires fully integrated PicoDrive build with `ENABLE_PDCORE=1`. See [PICODRIVE_PDCORE_INTEGRATION.md](../PICODRIVE_PDCORE_INTEGRATION.md) for setup.

### Option 2: Manual Memory Inspection

1. Boot ROM in emulator
2. Let it run for ~3 seconds (180 frames)
3. Pause emulation
4. Inspect SDRAM at addresses above
5. Values are stored in **big-endian 32-bit format**

**Example (using GDB or similar):**
```
# Read Slave cycle count
x/1xw 0x22000300

# Read Master cycle count
x/1xw 0x22000320
```

### Option 3: Save State Inspection

Some emulators allow dumping memory from save states:
1. Load ROM
2. Run for 180 frames
3. Save state
4. Extract SDRAM section from save state file
5. Read bytes at offsets above (subtract 0x22000000 from addresses)

---

## Expected Results

### Transform Performance

Each ROM transforms **4 vertices** using identity matrix:
- **Input:** (1,0,0,1), (0,1,0,1), (0,0,1,1), (1,1,1,CAFE1234)
- **Output:** Should match input (identity transform)
- **Expected cycles:** ~376-440 total (94-110 cycles/vertex)

### Calculation

The cycle count is calculated from FRT (Free Running Timer) deltas:

```
if (FRT_end < FRT_start):
    delta = (0x10000 + FRT_end) - FRT_start  # Wrapped
else:
    delta = FRT_end - FRT_start               # Normal

cycles = delta × 8  # FRT runs at CPU_CLK/8
```

### Comparison

Phase 17.2 (Master) and Phase 17.1 (Slave) should show:
- **Cycle counts within ~10 cycles** (measurement noise)
- Both CPUs run at same clock (23 MHz)
- Same code, same input, same expected output

**If results differ significantly:**
- Check wrap flag (unexpected wraparound)
- Check done flag (handler may not have run)
- Verify ROM booted correctly

---

## Troubleshooting

### Cycle count is zero
- Handler didn't run
- Check COMM4/COMM6 signals (Phase 17.1)
- Check VBlank hook (Phase 17.2)

### Cycle count too high (>1000)
- Wraparound occurred
- Check wrap flag at 0x2200030C/0x2200032C
- Delta calculation may have failed

### Cycle count too low (<300)
- Unexpected interrupt during measurement
- Transform code may have been optimized out
- Check output vertices match input

### Done flag not set (0x00010001)
- Transform didn't complete
- ROM crashed or handler didn't run
- Check COMM registers or VBlank hook

---

## Next Steps

Once cycle counts are verified:

1. **Validate measurement accuracy**
   - Compare Master vs Slave (should match)
   - Check wrap probability (~0.02% for 4 vertices)

2. **Scale to realistic workload**
   - 32-64 vertices (Phase 17.3+)
   - Measure actual wraparound frequency
   - Verify linear scaling

3. **Integration with game**
   - Hook into actual transform pipeline
   - Measure per-frame vertex processing
   - Estimate parallel speedup potential

---

## References

- [tools/inject_phase17_1_cycle_safe.py](../tools/inject_phase17_1_cycle_safe.py) - Slave implementation
- [tools/inject_phase17_2_master_comparison.py](../tools/inject_phase17_2_master_comparison.py) - Master implementation
- [tools/read_cycle_counts.c](../tools/read_cycle_counts.c) - Memory reader tool
- [SLAVE_INTEGRATION_RESEARCH.md](SLAVE_INTEGRATION_RESEARCH.md) - Integration strategy
- [pdcore/README.md](../pdcore/README.md) - Debugger documentation

---

**Status:** Tools created, awaiting debugger integration for automated memory reading.
