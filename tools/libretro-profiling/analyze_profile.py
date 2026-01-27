#!/usr/bin/env python3
"""
VRD v4.0 Profiling Data Analyzer
Analyzes CSV output from libretro-picodrive profiling instrumentation

Metrics captured:
- msh2_cycles: Master SH2 actual work cycles per frame
- ssh2_cycles: Slave SH2 actual work cycles per frame
- comm7: COMM register state (frame boundaries only)
"""

import csv
import sys
from pathlib import Path


def analyze_profile(csv_path: str):
    """Analyze profiling data from CSV file."""
    msh2_cycles = []
    ssh2_cycles = []
    comm7_changes = []

    with open(csv_path, 'r') as f:
        reader = csv.DictReader(f)
        for row in reader:
            if not row.get('frame'):
                continue
            frame = int(row['frame'])
            msh2 = int(row['msh2_cycles'])
            ssh2 = int(row['ssh2_cycles'])
            comm7_before = int(row['comm7_before'], 16)
            comm7_after = int(row['comm7_after'], 16)

            msh2_cycles.append((frame, msh2))
            ssh2_cycles.append((frame, ssh2))

            if comm7_before != comm7_after or comm7_before != 0:
                comm7_changes.append((frame, comm7_before, comm7_after))

    if not msh2_cycles:
        print("No data found in CSV")
        return

    # Calculate statistics
    msh2_values = [c for _, c in msh2_cycles]
    ssh2_values = [c for _, c in ssh2_cycles]

    print(f"=== VRD v4.0 Profiling Analysis: {Path(csv_path).name} ===\n")
    print(f"Total frames: {len(msh2_cycles)}")

    print(f"\nMaster SH2 Cycles:")
    print(f"  Min: {min(msh2_values):,}")
    print(f"  Max: {max(msh2_values):,}")
    print(f"  Avg: {sum(msh2_values)/len(msh2_values):,.1f}")

    print(f"\nSlave SH2 Cycles:")
    print(f"  Min: {min(ssh2_values):,}")
    print(f"  Max: {max(ssh2_values):,}")
    print(f"  Avg: {sum(ssh2_values)/len(ssh2_values):,.1f}")

    # Cycle budget utilization (23 MHz @ 60fps)
    cycles_per_frame = 23000000 // 60
    avg_msh2 = sum(msh2_values) / len(msh2_values)
    avg_ssh2 = sum(ssh2_values) / len(ssh2_values)

    print(f"\nCycle Budget (23MHz @ 60fps = {cycles_per_frame:,}/frame):")
    print(f"  Master Utilization: {100*avg_msh2/cycles_per_frame:.1f}%")
    print(f"  Slave Utilization:  {100*avg_ssh2/cycles_per_frame:.1f}%")

    # Balance analysis
    diffs = [abs(m - s) for (_, m), (_, s) in zip(msh2_cycles, ssh2_cycles)]
    print(f"\nMaster/Slave Balance:")
    print(f"  Avg difference: {sum(diffs)/len(diffs):.1f} cycles")
    print(f"  Max difference: {max(diffs)} cycles")

    # COMM7 activity
    print(f"\nCOMM7 Activity:")
    if comm7_changes:
        print(f"  {len(comm7_changes)} frames with COMM7 changes")
        cmd_counts = {}
        for frame, before, after in comm7_changes:
            cmd_counts[after] = cmd_counts.get(after, 0) + 1
        for cmd, count in sorted(cmd_counts.items()):
            print(f"    0x{cmd:04X}: {count} occurrences")
    else:
        print("  No COMM7 changes detected (title screen / no gameplay)")

    # Work distribution analysis
    print("\n=== WORK DISTRIBUTION ===")
    total_work = avg_msh2 + avg_ssh2
    if total_work > 0:
        print(f"Master share: {100*avg_msh2/total_work:.1f}%")
        print(f"Slave share:  {100*avg_ssh2/total_work:.1f}%")
        if avg_ssh2 > avg_msh2:
            print(f"Slave is doing {100*(avg_ssh2-avg_msh2)/avg_msh2:+.1f}% more work than Master")

    # Parallel processing detection
    print("\n=== PARALLEL PROCESSING VALIDATION ===")

    # Check if cycles are balanced (within 1% = synchronous)
    # or imbalanced (parallel processing active)
    if avg_msh2 > 0:
        balance_ratio = sum(diffs) / len(diffs) / avg_msh2 * 100
        if balance_ratio < 1.0:
            print(f"CPU Balance: SYNCHRONOUS (diff={balance_ratio:.2f}% - lockstep operation)")
        else:
            print(f"CPU Balance: ASYMMETRIC (diff={balance_ratio:.2f}% - work distribution detected)")

    # 3-frame pattern detection (common in VRD)
    if len(msh2_values) >= 9:
        pattern_avgs = []
        for offset in range(3):
            pattern_frames = msh2_values[offset::3]
            pattern_avgs.append(sum(pattern_frames) / len(pattern_frames))

        max_pattern = max(pattern_avgs)
        min_pattern = min(pattern_avgs)
        if max_pattern > 0 and (max_pattern - min_pattern) / max_pattern > 0.3:
            print(f"3-Frame Cycle Detected:")
            for i, avg in enumerate(pattern_avgs):
                print(f"  Pattern {i}: Master avg = {avg:,.0f}")

    # Frame time estimation
    max_cycles = max(max(msh2_values), max(ssh2_values))
    if max_cycles > cycles_per_frame:
        print(f"\nPerformance Warning: Peak cycles ({max_cycles:,}) exceed 60fps budget!")
        estimated_fps = 23000000 / max_cycles
        print(f"  Estimated min FPS: {estimated_fps:.1f}")


if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Usage: analyze_profile.py <profile.csv>")
        sys.exit(1)

    analyze_profile(sys.argv[1])
