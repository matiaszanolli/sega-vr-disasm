# GDB Port Reference - Gens Emulator

## Port Configuration

When you enable "GDB Stub → Start" in Gens, it opens **4 separate GDB servers** on different ports, one for each CPU:

| CPU | Port | Used By | Purpose |
|-----|------|---------|---------|
| Main 68K | 6868 | - | Mega Drive main CPU |
| Sub 68K | 6869 | - | (unused in most games) |
| **Master SH2** | **6870** | **VDP profiler, func_065, hot functions** | **Primary 32X CPU** |
| **Slave SH2** | **6871** | **Slave CPU profiler** | **Secondary 32X CPU** |

## Why This Matters

The VDP polling loops and most game code run on the **Master SH2** (port 6870), not the Main 68K. Our profilers now connect to the correct ports:

### Master SH2 Profilers (Port 6870)
- `vdp_polling` - VDP polling analysis
- `func_065` - func_065 register profiling
- `hot_functions` - Top function call counts
- `r13_trace` - R13 initialization trace
- `r10_dump` - Lookup table dump

### Slave SH2 Profiler (Port 6871)
- `slave_cpu` - Slave CPU activity analysis

## Connecting to Specific CPU

In GDB scripts, you target a specific CPU like this:

```gdb
# Connect to Master SH2
target remote localhost:6870
set architecture sh2

# OR connect to Slave SH2
target remote localhost:6871
set architecture sh2
```

## Setting Up Gens

1. Start Gens with ROM
2. Menu: **Tools → GDB Stub → Start**
3. Check all 4 checkboxes:
   - ☑ use GDB (Main 68K) - Port 6868
   - ☑ use GDB (Sub 68K) - Port 6869
   - ☑ use GDB (Master SH2) - Port 6870
   - ☑ use GDB (Slave SH2) - Port 6871
4. Click "need restart" if shown

## Testing Connection

You can test if a specific port is accessible:

```bash
# Test Master SH2 connection
echo quit | gdb -batch -ex "target remote localhost:6870"

# Test Slave SH2 connection
echo quit | gdb -batch -ex "target remote localhost:6871"
```

If successful, you'll see: `Remote debugging using localhost:XXXX`

## Common Issues

### "Connection refused"
- GDB stub not enabled in Gens menu
- Wrong port number
- Gens not running

### Breakpoints never hit
- Connected to wrong CPU port
- Code runs on different CPU than you're debugging
- Example: SH2 code won't hit breakpoints if connected to 68K port

### Two GDB sessions at once?
You can connect to multiple CPUs simultaneously by running GDB in different terminals:

```bash
# Terminal 1: Debug Master SH2
gdb -x gdb_scripts/profile_vdp_polling.gdb

# Terminal 2: Debug Slave SH2 (at the same time!)
gdb -x gdb_scripts/profile_slave_cpu.gdb
```

This is useful for profiling Master/Slave communication!

## How Our Tools Handle Ports

The `gdb_profiler.py` tool automatically uses the correct port for each profile:

| Profile Command | Target CPU | Port |
|----------------|-----------|------|
| `python3 tools/gdb_profiler.py vdp_polling` | Master SH2 | 6870 |
| `python3 tools/gdb_profiler.py slave_cpu` | Slave SH2 | 6871 |
| `python3 tools/gdb_profiler.py func_065` | Master SH2 | 6870 |
| `python3 tools/gdb_profiler.py hot_functions` | Master SH2 | 6870 |
| `python3 tools/gdb_profiler.py r13_trace` | Master SH2 | 6870 |
| `python3 tools/gdb_profiler.py r10_dump` | Master SH2 | 6870 |

---

**Updated:** 2026-01-06 (fixed port configuration for SH2 debugging)
