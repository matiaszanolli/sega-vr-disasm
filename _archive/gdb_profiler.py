#!/usr/bin/env python3
"""
GDB-based runtime profiler for Gens emulator

Usage:
1. Start Gens with ROM
2. Enable GDB stub in Gens menu (Tools → GDB Stub → Start)
3. Run this script: python3 gdb_profiler.py <profile_name>

Profiles:
- func_065: Profile func_065 register values and call frequency
- hot_functions: Profile top 10 most-called functions
- register_trace: Trace R13 initialization
"""

import sys
import subprocess
import time
from pathlib import Path

class GDBProfiler:
    """Interact with GDB to profile running ROM"""

    def __init__(self, gdb_port=6868):
        self.gdb_port = gdb_port
        self.gdb_commands = []

    def add_command(self, cmd):
        """Add GDB command"""
        self.gdb_commands.append(cmd)

    def run(self, script_file):
        """Execute GDB script"""
        # Write commands to file
        with open(script_file, 'w') as f:
            for cmd in self.gdb_commands:
                f.write(cmd + '\n')

        print(f"✓ GDB script written: {script_file}")
        print(f"\nTo run manually:")
        print(f"  gdb")
        print(f"  (gdb) source {script_file}")
        print()

        return script_file

def profile_func_065():
    """Profile func_065: register values, call frequency"""
    profiler = GDBProfiler()

    # Connect to emulator
    profiler.add_command("target remote localhost:6870")  # Master SH2 port
    profiler.add_command("set architecture sh2")

    # Set breakpoint at func_065
    profiler.add_command("break *0x02223F2E")

    # Define commands to run at breakpoint
    profiler.add_command("commands")
    profiler.add_command("  silent")
    profiler.add_command("  printf \"func_065 called\\n\"")
    profiler.add_command("  printf \"  R0 (index): 0x%08X\\n\", $r0")
    profiler.add_command("  printf \"  R9 (framebuf): 0x%08X\\n\", $r9")
    profiler.add_command("  printf \"  R10 (table): 0x%08X\\n\", $r10")
    profiler.add_command("  printf \"  R13 (stride): 0x%08X (%d)\\n\", $r13, $r13")
    profiler.add_command("  continue")
    profiler.add_command("end")

    # Continue execution
    profiler.add_command("continue")

    return profiler.run("gdb_scripts/profile_func_065.gdb")

def profile_hot_functions():
    """Profile top 10 most-called functions"""
    profiler = GDBProfiler()

    hot_funcs = [
        (0x022B58, "func_hot_1"),
        (0x021B2C, "func_hot_2"),
        (0x0203D8, "register_save"),
        (0x023F2E, "func_065"),
        (0x0221C6, "func_hot_5"),
        (0x021FAC, "func_hot_6"),
        (0x022206, "func_hot_7"),
        (0x022B4A, "func_hot_8"),
        (0x022248, "func_hot_9"),
        (0x023ED0, "func_065_inline"),
    ]

    profiler.add_command("target remote localhost:6870")  # Master SH2 port
    profiler.add_command("set architecture sh2")

    # Set counter variables
    for i, (addr, name) in enumerate(hot_funcs):
        profiler.add_command(f"set $count_{i} = 0")

    # Set breakpoints with counters
    for i, (addr, name) in enumerate(hot_funcs):
        profiler.add_command(f"break *0x{addr + 0x02000000:08X}")
        profiler.add_command("commands")
        profiler.add_command("  silent")
        profiler.add_command(f"  set $count_{i} = $count_{i} + 1")
        profiler.add_command("  continue")
        profiler.add_command("end")

    # Run for a bit, then print stats
    profiler.add_command("continue")
    profiler.add_command("# After running for a while, press Ctrl+C and type:")
    profiler.add_command("# info variables count_")

    return profiler.run("gdb_scripts/profile_hot_functions.gdb")

def trace_r13_init():
    """Trace where R13 is initialized"""
    profiler = GDBProfiler()

    profiler.add_command("target remote localhost:6870")  # Master SH2 port
    profiler.add_command("set architecture sh2")

    # Watch R13 writes
    profiler.add_command("watch $r13")

    # When R13 changes, show backtrace
    profiler.add_command("commands")
    profiler.add_command("  silent")
    profiler.add_command("  printf \"R13 changed to 0x%08X (%d)\\n\", $r13, $r13")
    profiler.add_command("  backtrace 5")
    profiler.add_command("  continue")
    profiler.add_command("end")

    profiler.add_command("continue")

    return profiler.run("gdb_scripts/trace_r13.gdb")

def dump_memory_at_r10():
    """Dump memory at R10 (lookup table)"""
    profiler = GDBProfiler()

    profiler.add_command("target remote localhost:6870")  # Master SH2 port
    profiler.add_command("set architecture sh2")

    # Break at func_065
    profiler.add_command("break *0x02223F2E")

    # Dump table at R10
    profiler.add_command("commands")
    profiler.add_command("  silent")
    profiler.add_command("  printf \"Dumping table at R10 = 0x%08X\\n\", $r10")
    profiler.add_command("  x/32wx $r10")
    profiler.add_command("  continue")
    profiler.add_command("end")

    profiler.add_command("continue")

    return profiler.run("gdb_scripts/dump_r10_table.gdb")

def profile_vdp_polling():
    """Profile VDP polling loops - identify wait times and bottlenecks"""
    profiler = GDBProfiler()

    # VDP polling locations from bottleneck analysis
    polling_loops = [
        (0x0243E2, "vdp_poll_1"),
        (0x02441E, "vdp_poll_2"),
        (0x02443A, "vdp_poll_3"),
        (0x024482, "vdp_poll_4"),
    ]

    profiler.add_command("target remote localhost:6870")  # Master SH2 port
    profiler.add_command("set architecture sh2")

    # Set counter variables for each polling loop
    for i, (addr, name) in enumerate(polling_loops):
        profiler.add_command(f"set $poll_count_{i} = 0")
        profiler.add_command(f"set $poll_cycles_{i} = 0")

    # Set breakpoints with counters
    for i, (addr, name) in enumerate(polling_loops):
        profiler.add_command(f"break *0x{addr + 0x02000000:08X}")
        profiler.add_command("commands")
        profiler.add_command("  silent")
        profiler.add_command(f"  set $poll_count_{i} = $poll_count_{i} + 1")
        profiler.add_command(f'  printf "VDP poll loop {name} at 0x{addr:06X} (count: %d)\\n", $poll_count_{i}')
        # Show VDP status register (cache-through address)
        profiler.add_command('  printf "  VDP Status: 0x%04X\\n", *(unsigned short*)0x20004100')
        profiler.add_command("  continue")
        profiler.add_command("end")

    # Run for a bit, then print stats
    profiler.add_command("continue")
    profiler.add_command("# After running for a few seconds, press Ctrl+C and examine:")
    profiler.add_command("# print $poll_count_0")
    profiler.add_command("# print $poll_count_1")
    profiler.add_command("# print $poll_count_2")
    profiler.add_command("# print $poll_count_3")

    return profiler.run("gdb_scripts/profile_vdp_polling.gdb")

def profile_slave_cpu():
    """Profile Slave SH2 CPU - find entry point and analyze idle state"""
    profiler = GDBProfiler()

    profiler.add_command("target remote localhost:6871")  # Slave SH2 port
    profiler.add_command("set architecture sh2")

    # Strategy: Watch COMM registers for Master→Slave communication
    # COMM0-7 are at 0x20004020-0x2000402E (cache-through)

    # Set up watchpoints on COMM registers (Master writes to these)
    profiler.add_command("# Watch COMM register writes (Master→Slave communication)")
    for i in range(8):
        comm_addr = 0x20004020 + (i * 2)
        profiler.add_command(f"watch *(unsigned short*)0x{comm_addr:08X}")
        profiler.add_command("commands")
        profiler.add_command("  silent")
        profiler.add_command(f'  printf "COMM{i} changed to 0x%04X at PC=0x%08X\\n", *(unsigned short*)0x{comm_addr:08X}, $pc')
        profiler.add_command("  backtrace 3")
        profiler.add_command("  continue")
        profiler.add_command("end")

    # Also track Slave CPU activity by sampling PC register
    profiler.add_command("# To sample Slave CPU PC, press Ctrl+C periodically and check:")
    profiler.add_command("# info registers pc")
    profiler.add_command("# continue")

    profiler.add_command("continue")

    return profiler.run("gdb_scripts/profile_slave_cpu.gdb")

def main():
    if len(sys.argv) < 2:
        print("Usage: python3 gdb_profiler.py <profile>")
        print()
        print("Available profiles:")
        print("  func_065          - Profile func_065 calls and registers")
        print("  hot_functions     - Count calls to top 10 functions")
        print("  r13_trace         - Trace R13 initialization")
        print("  r10_dump          - Dump lookup table at R10")
        print("  vdp_polling       - Profile VDP polling loops (Track 1)")
        print("  slave_cpu         - Profile Slave CPU activity (Track 2)")
        sys.exit(1)

    profile = sys.argv[1]

    # Create output directory
    Path("gdb_scripts").mkdir(exist_ok=True)

    print("=" * 70)
    print(" GDB Runtime Profiler")
    print("=" * 70)
    print()

    if profile == "func_065":
        script = profile_func_065()
        print("Profile: func_065 register values")
    elif profile == "hot_functions":
        script = profile_hot_functions()
        print("Profile: Hot function call counts")
    elif profile == "r13_trace":
        script = trace_r13_init()
        print("Profile: R13 initialization trace")
    elif profile == "r10_dump":
        script = dump_memory_at_r10()
        print("Profile: R10 table memory dump")
    elif profile == "vdp_polling":
        script = profile_vdp_polling()
        print("Profile: VDP polling loop analysis (Optimization Track 1)")
    elif profile == "slave_cpu":
        script = profile_slave_cpu()
        print("Profile: Slave CPU activity analysis (Optimization Track 2)")
    else:
        print(f"❌ Unknown profile: {profile}")
        sys.exit(1)

    print()
    print("=" * 70)
    print("INSTRUCTIONS")
    print("=" * 70)
    print()
    print("1. Start Gens emulator:")
    print("   ./Gens_KMod_v0.7.3/gens.exe \"Virtua Racing Deluxe (USA).32x\"")
    print()
    print("2. Enable GDB stub in Gens:")
    print("   Menu: Tools → GDB Stub → Start")
    print("   (Should show 'GDB stub started on port 6868')")
    print()
    print("3. Run GDB with generated script:")
    print(f"   gdb -x {script}")
    print()
    print("4. Let it run for a few seconds, then Ctrl+C")
    print()
    print("5. Examine results (variables, memory dumps, etc.)")
    print()

if __name__ == '__main__':
    main()
