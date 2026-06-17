#!/usr/bin/env python3
"""
VRD PC-Level Profile Analyzer
Analyzes program counter-level profiling data to identify hotspots

Output format: cpu,pc,total_cycles,count,avg_cycles,share
"""

import bisect
import csv
import re
import sys
from pathlib import Path


def load_function_map(lookup_path: str) -> tuple:
    """Load function address→name mapping from FUNCTION_QUICK_LOOKUP.md.
    Returns (sorted_addrs, addr_to_name) for binary search lookup."""
    addr_to_name = {}
    pattern = re.compile(r'^\$([0-9A-Fa-f]{6})\s+(.+?)\s+\[')

    with open(lookup_path, 'r') as f:
        for line in f:
            m = pattern.match(line.strip())
            if m:
                addr = int(m.group(1), 16)
                name = m.group(2).strip()
                # Truncate long names for display
                if len(name) > 40:
                    name = name[:37] + "..."
                addr_to_name[addr] = name
    sorted_addrs = sorted(addr_to_name.keys())
    return sorted_addrs, addr_to_name


def resolve_function(pc: int, sorted_addrs: list, addr_to_name: dict) -> str:
    """Resolve a 68K PC to its containing function name.
    Converts 32X CPU address ($88xxxx) to ROM file offset first."""
    # Convert 68K CPU address to ROM file offset
    if pc >= 0x880000 and pc < 0xC80000:
        file_offset = pc - 0x880000
    elif pc >= 0xFF0000:
        return "WRAM_code"  # BIOS adapter code in Work RAM
    else:
        file_offset = pc

    idx = bisect.bisect_right(sorted_addrs, file_offset) - 1
    if idx >= 0:
        return addr_to_name[sorted_addrs[idx]]
    return "???"


def get_sh2_memory_region(pc: int) -> str:
    """Identify SH2 memory region from PC address."""
    if pc < 0x00001000:
        return "BIOS"
    elif pc >= 0x02000000 and pc < 0x02400000:
        return "ROM"
    elif pc >= 0x06000000 and pc < 0x06100000:
        return "SDRAM"
    elif pc >= 0x20000000 and pc < 0x20100000:
        return "SDRAM-C"  # Cache-through SDRAM
    elif pc >= 0x22000000 and pc < 0x22100000:
        return "FB"  # Frame buffer
    elif pc >= 0x24000000 and pc < 0x24100000:
        return "VRAM"
    elif pc >= 0xC0000000 and pc < 0xC0100000:
        return "ROM-C"  # Cache-through ROM
    else:
        return "UNK"


def get_68k_memory_region(pc: int) -> str:
    """Identify 68K memory region from PC address.
    In 32X mode, ROM is mapped at $880000 in 68K address space."""
    if pc >= 0x880000 and pc < 0x8A0000:
        return "ROM-68K"   # 32X ROM (68K game code)
    elif pc >= 0x8A0000 and pc < 0xB80000:
        return "ROM-SH2"   # 32X ROM (SH2 code area)
    elif pc >= 0xB80000 and pc < 0xC80000:
        return "ROM-EXP"   # 32X ROM (expansion)
    elif pc < 0x020000:
        return "ROM-68K"   # Non-32X ROM
    elif pc < 0x300000:
        return "ROM-SH2"   # Non-32X SH2 area
    elif pc < 0x400000:
        return "ROM-EXP"   # Non-32X expansion
    elif pc >= 0xFF0000:
        return "WRAM"      # Work RAM
    elif pc >= 0xA15100 and pc < 0xA15200:
        return "MARS-REG"  # 32X registers
    elif pc >= 0xC00000 and pc < 0xC00020:
        return "VDP"       # VDP registers
    else:
        return "UNK"


def analyze_pc_profile(csv_path: str, top_n: int = 20):
    """Analyze PC-level profiling data and show hotspots."""

    # Try to load function name lookup
    script_dir = Path(__file__).resolve().parent
    lookup_path = script_dir / "../../analysis/FUNCTION_QUICK_LOOKUP.md"
    sorted_addrs, addr_to_name = [], {}
    if lookup_path.exists():
        sorted_addrs, addr_to_name = load_function_map(str(lookup_path))

    m68k_samples = []
    master_samples = []
    slave_samples = []

    with open(csv_path, 'r') as f:
        reader = csv.DictReader(f)
        for row in reader:
            cpu = row['cpu'].strip()
            if cpu.startswith('#') or cpu.startswith('WRAM_CALLER') or cpu == 'BUDGET':
                continue
            pc = int(row['pc'], 16)
            total_cycles = int(row['total_cycles'])
            count = int(row['count'])
            avg_cycles = float(row['avg_cycles'])
            share = float(row['share'])

            if cpu in ('68K', '68k', 'm68k'):
                func = resolve_function(pc, sorted_addrs, addr_to_name) if sorted_addrs else ""
                entry = {
                    'pc': pc,
                    'region': get_68k_memory_region(pc),
                    'func': func,
                    'total_cycles': total_cycles,
                    'count': count,
                    'avg_cycles': avg_cycles,
                    'share': share
                }
                m68k_samples.append(entry)
            else:
                entry = {
                    'pc': pc,
                    'region': get_sh2_memory_region(pc),
                    'total_cycles': total_cycles,
                    'count': count,
                    'avg_cycles': avg_cycles,
                    'share': share
                }
                if cpu == 'master':
                    master_samples.append(entry)
                else:
                    slave_samples.append(entry)

    print(f"=== VRD PC-Level Profile Analysis: {Path(csv_path).name} ===\n")

    # 68K hotspots
    print(f"=== 68000 Top {top_n} Hotspots ===")
    print(f"Total PCs captured: {len(m68k_samples)}")

    if m68k_samples:
        m68k_samples.sort(key=lambda x: x['total_cycles'], reverse=True)
        total_68k = sum(s['total_cycles'] for s in m68k_samples)

        print(f"Total cycles: {total_68k:,}")
        print()
        print("    PC        Region    Total Cycles    Count    Avg     Share   Cumul   Function")
        print("----------  --------  --------------  --------  ------  ------  ------  --------")

        cumulative = 0.0
        for entry in m68k_samples[:top_n]:
            cumulative += entry['share']
            func_str = entry.get('func', '')
            print(f"0x{entry['pc']:08X}  {entry['region']:8s}  {entry['total_cycles']:13,}  {entry['count']:8,}  "
                  f"{entry['avg_cycles']:6.1f}  {entry['share']:5.2f}%  {cumulative:5.1f}%  {func_str}")
        print()
    else:
        print("No 68K data captured\n")

    # Master SH2 hotspots
    print(f"=== Master SH2 Top {top_n} Hotspots ===")
    print(f"Total PCs captured: {len(master_samples)}")

    if master_samples:
        master_samples.sort(key=lambda x: x['total_cycles'], reverse=True)
        total_master = sum(s['total_cycles'] for s in master_samples)

        print(f"Total cycles: {total_master:,}")
        print()
        print("    PC        Region    Total Cycles    Count    Avg     Share   Cumulative")
        print("----------  --------  --------------  --------  ------  ------  ----------")

        cumulative = 0.0
        for i, entry in enumerate(master_samples[:top_n]):
            cumulative += entry['share']
            print(f"0x{entry['pc']:08X}  {entry['region']:8s}  {entry['total_cycles']:13,}  {entry['count']:8,}  "
                  f"{entry['avg_cycles']:6.1f}  {entry['share']:5.2f}%  {cumulative:6.2f}%")
        print()
    else:
        print("No Master SH2 data captured\n")

    # Slave SH2 hotspots
    print(f"=== Slave SH2 Top {top_n} Hotspots ===")
    print(f"Total PCs captured: {len(slave_samples)}")

    if slave_samples:
        slave_samples.sort(key=lambda x: x['total_cycles'], reverse=True)
        total_slave = sum(s['total_cycles'] for s in slave_samples)

        print(f"Total cycles: {total_slave:,}")
        print()
        print("    PC        Region    Total Cycles    Count    Avg     Share   Cumulative")
        print("----------  --------  --------------  --------  ------  ------  ----------")

        cumulative = 0.0
        for i, entry in enumerate(slave_samples[:top_n]):
            cumulative += entry['share']
            print(f"0x{entry['pc']:08X}  {entry['region']:8s}  {entry['total_cycles']:13,}  {entry['count']:8,}  "
                  f"{entry['avg_cycles']:6.1f}  {entry['share']:5.2f}%  {cumulative:6.2f}%")
        print()
    else:
        print("No Slave SH2 data captured\n")

    # Function-level aggregation for 68K
    if m68k_samples and sorted_addrs:
        func_agg = {}
        for entry in m68k_samples:
            func = entry.get('func', '???')
            if func not in func_agg:
                func_agg[func] = {'total_cycles': 0, 'count': 0, 'share': 0.0, 'pcs': 0}
            func_agg[func]['total_cycles'] += entry['total_cycles']
            func_agg[func]['count'] += entry['count']
            func_agg[func]['share'] += entry['share']
            func_agg[func]['pcs'] += 1

        sorted_funcs = sorted(func_agg.items(), key=lambda x: x[1]['total_cycles'], reverse=True)

        print(f"=== 68000 Function-Level Aggregation (Top {top_n}) ===")
        print()
        print("Function                                   PCs  Total Cycles     Share   Cumul")
        print("-----------------------------------------  ---  --------------  ------  ------")

        cumulative = 0.0
        for name, data in sorted_funcs[:top_n]:
            cumulative += data['share']
            display_name = name[:41] if len(name) > 41 else name
            print(f"{display_name:41s}  {data['pcs']:3d}  {data['total_cycles']:13,}  {data['share']:5.2f}%  {cumulative:5.1f}%")
        print()

    # Analysis summary
    print("=== Analysis Summary ===")

    if m68k_samples:
        top_10_share = sum(s['share'] for s in m68k_samples[:10])
        top_20_share = sum(s['share'] for s in m68k_samples[:20])
        print(f"68K concentration:")
        print(f"  Top 10 PCs account for {top_10_share:.1f}% of total cycles")
        print(f"  Top 20 PCs account for {top_20_share:.1f}% of total cycles")
        print()

    if slave_samples:
        top_10_share = sum(s['share'] for s in slave_samples[:10])
        top_20_share = sum(s['share'] for s in slave_samples[:20])
        print(f"Slave SH2 concentration:")
        print(f"  Top 10 PCs account for {top_10_share:.1f}% of total cycles")
        print(f"  Top 20 PCs account for {top_20_share:.1f}% of total cycles")
        print()

    # WRAM caller analysis (from profiler's WRAM_CALLER rows)
    wram_callers = []
    with open(csv_path, 'r') as f:
        for line in f:
            if line.startswith('WRAM_CALLER,'):
                parts = line.strip().split(',')
                if len(parts) >= 5:
                    pc = int(parts[1], 16)
                    total_cycles = int(parts[2])
                    count = int(parts[3])
                    share = float(parts[5])
                    func = resolve_function(pc, sorted_addrs, addr_to_name) if sorted_addrs else ""
                    wram_callers.append({
                        'pc': pc, 'total_cycles': total_cycles,
                        'count': count, 'share': share, 'func': func
                    })

    if wram_callers:
        print(f"=== WRAM Polling Callers (Who triggers the 49% COMM wait?) ===")
        print(f"Total unique callers: {len(wram_callers)}")
        print()
        print("    PC        Total Cycles    Count    Share   Function")
        print("----------  --------------  --------  ------  --------")
        for entry in wram_callers[:top_n]:
            print(f"0x{entry['pc']:08X}  {entry['total_cycles']:13,}  {entry['count']:8,}  "
                  f"{entry['share']:5.2f}%  {entry['func']}")
        print()

        # Aggregate callers by function
        caller_agg = {}
        for entry in wram_callers:
            func = entry['func']
            if func not in caller_agg:
                caller_agg[func] = {'total_cycles': 0, 'share': 0.0, 'pcs': 0}
            caller_agg[func]['total_cycles'] += entry['total_cycles']
            caller_agg[func]['share'] += entry['share']
            caller_agg[func]['pcs'] += 1
        sorted_caller_funcs = sorted(caller_agg.items(), key=lambda x: x[1]['total_cycles'], reverse=True)

        print("=== WRAM Callers by Function ===")
        print()
        print("Function                                   PCs   Share   Cumul")
        print("-----------------------------------------  ---  ------  ------")
        cumulative = 0.0
        for name, data in sorted_caller_funcs[:20]:
            cumulative += data['share']
            display_name = name[:41] if len(name) > 41 else name
            print(f"{display_name:41s}  {data['pcs']:3d}  {data['share']:5.2f}%  {cumulative:5.1f}%")
        print()

    # Export hotspots for disassembly annotation
    for cpu_name, samples in [("68k", m68k_samples), ("slave", slave_samples)]:
        if samples:
            hotspot_file = Path(csv_path).parent / f"{cpu_name}_hotspots.txt"
            with open(hotspot_file, 'w') as f:
                f.write(f"# {cpu_name.upper()} Hotspots - Top 20 PCs by cycle share\n")
                f.write("# Format: PC [Region] (share%) function_name\n\n")
                for i, entry in enumerate(samples[:20], 1):
                    func_str = entry.get('func', '')
                    f.write(f"{i:2d}. 0x{entry['pc']:08X} [{entry['region']:8s}] ({entry['share']:5.2f}%) {func_str}\n")
            print(f"{cpu_name.upper()} hotspots exported to: {hotspot_file}")


if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Usage: analyze_pc_profile.py <pc_profile.csv> [top_n]")
        sys.exit(1)

    top_n = int(sys.argv[2]) if len(sys.argv) > 2 else 20
    analyze_pc_profile(sys.argv[1], top_n)
