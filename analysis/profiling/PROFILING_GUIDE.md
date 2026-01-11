# GDB Profiling Guide - Week 1 Analysis Tools

**Date:** 2026-01-06
**Status:** Ready for use
**Purpose:** Empirical data collection for optimization tracks

## Overview

We've extended [gdb_profiler.py](../tools/gdb_profiler.py) with two new profiling capabilities to support the strategic optimization plan:

1. **VDP Polling Profiler** - Track 1: VDP Polling Elimination
2. **Slave CPU Profiler** - Track 2: Slave CPU Activation

These tools generate GDB scripts that connect to Gens emulator's GDB stub to collect runtime data.

---

## Available Profiles

### 1. VDP Polling Profiler 🔥 **HIGH PRIORITY**

**Command:**
```bash
python3 tools/gdb_profiler.py vdp_polling
```

**Output:** `gdb_scripts/profile_vdp_polling.gdb`

**What it does:**
- Sets breakpoints at 4 VDP polling loop locations:
  - `0x0243E2` (vdp_poll_1)
  - `0x02441E` (vdp_poll_2)
  - `0x02443A` (vdp_poll_3)
  - `0x024482` (vdp_poll_4)
- Counts how many times each loop is hit per frame
- Captures VDP status register value at each poll
- Tracks wait time distribution

**Expected data:**
- Which polling loops are most frequent
- What VDP status bits are being polled
- How long CPU waits in each loop

**Use for:**
- Track 1: VDP Polling Elimination design
- Understanding what hardware events are being waited for
- Prioritizing which loops to convert to interrupts first

---

### 2. Slave CPU Profiler 🔥 **VERY HIGH PRIORITY**

**Command:**
```bash
python3 tools/gdb_profiler.py slave_cpu
```

**Output:** `gdb_scripts/profile_slave_cpu.gdb`

**What it does:**
- Sets watchpoints on all 8 COMM registers (0x20004020-0x2000402E)
- Triggers when Master writes to COMM registers (Master→Slave communication)
- Shows PC location and backtrace when communication occurs
- Allows manual PC sampling to see where Slave CPU is executing

**Expected data:**
- Master→Slave communication protocol
- COMM register usage patterns
- Slave CPU entry point location
- Where Slave CPU spends its time (idle loop location)

**Use for:**
- Track 2: Slave CPU Activation design
- Understanding current Slave CPU usage (why 99.97% idle)
- Identifying synchronization points
- Designing work queue system

---

### 3. func_065 Profiler (Existing)

**Command:**
```bash
python3 tools/gdb_profiler.py func_065
```

**What it does:**
- Breaks at func_065 entry (0x02223F2E)
- Captures R0 (index), R9 (framebuf), R10 (table), R13 (stride)
- Counts call frequency

**Status:** ✅ Complete - func_065 optimization abandoned

---

### 4. Hot Functions Profiler (Existing)

**Command:**
```bash
python3 tools/gdb_profiler.py hot_functions
```

**What it does:**
- Counts calls to top 10 most-called functions
- Tracks execution frequency

**Use for:**
- Identifying optimization targets beyond VDP/Slave CPU

---

### 5. R13 Trace (Existing)

**Command:**
```bash
python3 tools/gdb_profiler.py r13_trace
```

**What it does:**
- Watches R13 register changes
- Shows backtrace when R13 is modified

**Use for:**
- Understanding register conventions
- Tracing parameter passing

---

### 6. R10 Dump (Existing)

**Command:**
```bash
python3 tools/gdb_profiler.py r10_dump
```

**What it does:**
- Dumps 32 words at R10 (lookup table)
- Shows precomputed data structure

**Use for:**
- Understanding lookup table contents

---

## Usage Workflow

### Step 1: Generate GDB Script

```bash
python3 tools/gdb_profiler.py vdp_polling
```

Output shows generated script location and instructions.

### Step 2: Start Emulator

```bash
./Gens_KMod_v0.7.3/gens.exe "Virtua Racing Deluxe (USA).32x"
```

### Step 3: Enable GDB Stub in Gens

- Menu: **Tools → GDB Stub → Start**
- Enable all GDB stubs. Port assignments:
  - **Main 68K:** 6868
  - **Sub 68K:** 6869
  - **Master SH2:** 6870 (VDP polling, hot functions profilers)
  - **Slave SH2:** 6871 (Slave CPU profiler)

### Step 4: Run GDB with Script

```bash
# Use gdb-multiarch for SH2 architecture support
gdb-multiarch -x gdb_scripts/profile_vdp_polling.gdb
```

GDB will:
1. Connect to emulator on port 6868
2. Set breakpoints/watchpoints
3. Start execution with `continue`

### Step 5: Let Run and Observe

- Let emulator run for 5-10 seconds
- Watch GDB output for profiling data
- Press **Ctrl+C** to pause

### Step 6: Examine Results

**For VDP polling:**
```gdb
(gdb) info variables poll_count_
```

Shows call counts for each polling loop.

**For Slave CPU:**
- Watch COMM register change messages
- Sample Slave PC:
  ```gdb
  (gdb) info registers pc
  (gdb) continue
  ```

### Step 7: Save Output

Copy GDB terminal output to analysis file:
```bash
# Save to analysis/VDP_POLLING_DATA.txt
# or analysis/SLAVE_CPU_DATA.txt
```

---

## Expected Week 1 Deliverables

Using these profilers, we aim to create:

### From VDP Polling Profiler

**File:** `analysis/VDP_POLLING_ANALYSIS.md`

**Should contain:**
- Empirical wait time measurements
- Which VDP status bits are polled
- Call frequency per loop
- Hardware state documentation
- Interrupt design recommendations

### From Slave CPU Profiler

**File:** `analysis/SLAVE_CPU_ANALYSIS.md`

**Should contain:**
- Slave CPU entry point address
- Current idle loop location
- COMM protocol documentation
- Master↔Slave communication patterns
- Work distribution opportunities

---

## Profiling Best Practices

### 1. Short Sessions

Run profiling for **5-10 seconds max** to avoid overwhelming GDB output.

### 2. Single Profile at a Time

Don't combine multiple profiles - use dedicated sessions for each.

### 3. Save Output Immediately

Copy GDB output to text files before closing session.

### 4. Multiple Samples

Run each profile 2-3 times to verify consistency.

### 5. Document Context

Note what's happening in-game when profiling:
- Main menu?
- Gameplay?
- Specific track section?

### 6. Check Emulator Speed

GDB slows down emulation significantly. This is expected and normal.

---

## Troubleshooting

### "Connection refused" on port 6868

- Ensure Gens GDB stub is started (Tools → GDB Stub → Start)
- Check no other GDB session is connected

### Breakpoints never hit

- Verify ROM is running (not paused)
- Check addresses are correct for your ROM version
- Try `break *0x02000000` to test if breakpoints work at all

### Too much output

- Reduce breakpoint locations
- Use `commands ... silent ... end` to suppress extra messages
- Run for shorter duration

### Emulator freezes

- Normal when GDB is processing breakpoints
- Press Ctrl+C in GDB to regain control
- Type `continue` to resume

---

## Next Steps

After collecting profiling data:

1. ✅ **Analyze data** - understand empirical behavior
2. ✅ **Document findings** - create analysis markdown files
3. ✅ **Design solution** - plan interrupt-driven VDP or work queue
4. ✅ **Implement** - write code based on data, not guesses

**Philosophy:** Profile before coding, understand before optimizing!

---

## Files

**Tool:** [tools/gdb_profiler.py](../tools/gdb_profiler.py)

**Generated Scripts:**
- `gdb_scripts/profile_vdp_polling.gdb`
- `gdb_scripts/profile_slave_cpu.gdb`
- `gdb_scripts/profile_func_065.gdb`
- `gdb_scripts/profile_hot_functions.gdb`
- `gdb_scripts/trace_r13.gdb`
- `gdb_scripts/dump_r10_table.gdb`

**Analysis Output (to be created):**
- `analysis/VDP_POLLING_ANALYSIS.md` (Week 1 deliverable)
- `analysis/SLAVE_CPU_ANALYSIS.md` (Week 1 deliverable)
- `analysis/VDP_POLLING_DATA.txt` (raw GDB output)
- `analysis/SLAVE_CPU_DATA.txt` (raw GDB output)

---

## Summary

| Profile | Purpose | Priority | Status |
|---------|---------|----------|--------|
| vdp_polling | Track VDP polling loops | 🔥 HIGH | ✅ Ready |
| slave_cpu | Analyze Slave CPU usage | 🔥 HIGH | ✅ Ready |
| func_065 | Profile func_065 calls | N/A | ✅ Complete (abandoned) |
| hot_functions | Count top function calls | ⬇️ LOW | ✅ Available |
| r13_trace | Trace R13 register | ⬇️ LOW | ✅ Available |
| r10_dump | Dump lookup table | ⬇️ LOW | ✅ Available |

**Week 1 Focus:** Run `vdp_polling` and `slave_cpu` profiles to gather empirical data for optimization design.

---

**Last Updated:** 2026-01-06
**Ready for Week 1 profiling campaign!** ✅
