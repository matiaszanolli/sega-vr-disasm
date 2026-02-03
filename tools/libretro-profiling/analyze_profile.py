#!/usr/bin/env python3
"""
VRD v4.0 Profiling Data Analyzer
Analyzes CSV output from libretro-picodrive profiling instrumentation

Metrics captured:
- m68k_cycles: Motorola 68000 cycles per frame
- msh2_cycles: Master SH2 actual work cycles per frame
- ssh2_cycles: Slave SH2 actual work cycles per frame
- comm5: Slave acknowledgement counter ($2000402A)
- comm6: Master signal counter ($2000402C)
- comm7: COMM register state (frame boundaries only)
"""

import csv
import sys
from pathlib import Path


def analyze_profile(csv_path: str):
    """Analyze profiling data from CSV file."""
    m68k_cycles = []
    msh2_cycles = []
    ssh2_cycles = []
    comm7_changes = []
    comm5_values = []  # Slave acknowledgements
    comm6_values = []  # Master signals
    has_comm56 = False  # Track if CSV has COMM5/COMM6 columns

    with open(csv_path, 'r') as f:
        reader = csv.DictReader(f)
        for row in reader:
            if not row.get('frame'):
                continue
            frame = int(row['frame'])
            m68k = int(row.get('m68k_cycles', 0))  # Default to 0 for old CSV format
            msh2 = int(row['msh2_cycles'])
            ssh2 = int(row['ssh2_cycles'])
            comm7_before = int(row['comm7_before'], 16)
            comm7_after = int(row['comm7_after'], 16)

            # COMM5/COMM6 support (v4 profiler)
            if 'comm5_after' in row and 'comm6_after' in row:
                has_comm56 = True
                comm5_after = int(row['comm5_after'], 16)
                comm6_after = int(row['comm6_after'], 16)
                comm5_values.append((frame, comm5_after))
                comm6_values.append((frame, comm6_after))

            m68k_cycles.append((frame, m68k))
            msh2_cycles.append((frame, msh2))
            ssh2_cycles.append((frame, ssh2))

            if comm7_before != comm7_after or comm7_before != 0:
                comm7_changes.append((frame, comm7_before, comm7_after))

    if not msh2_cycles:
        print("No data found in CSV")
        return

    # Calculate statistics
    m68k_values = [c for _, c in m68k_cycles]
    msh2_values = [c for _, c in msh2_cycles]
    ssh2_values = [c for _, c in ssh2_cycles]

    print(f"=== VRD v4.0 Profiling Analysis: {Path(csv_path).name} ===\n")
    print(f"Total frames: {len(msh2_cycles)}")

    # 68K analysis
    if m68k_values and max(m68k_values) > 0:
        print(f"\n68000 Cycles:")
        print(f"  Min: {min(m68k_values):,}")
        print(f"  Max: {max(m68k_values):,}")
        print(f"  Avg: {sum(m68k_values)/len(m68k_values):,.1f}")

    print(f"\nMaster SH2 Cycles:")
    print(f"  Min: {min(msh2_values):,}")
    print(f"  Max: {max(msh2_values):,}")
    print(f"  Avg: {sum(msh2_values)/len(msh2_values):,.1f}")

    print(f"\nSlave SH2 Cycles:")
    print(f"  Min: {min(ssh2_values):,}")
    print(f"  Max: {max(ssh2_values):,}")
    print(f"  Avg: {sum(ssh2_values)/len(ssh2_values):,.1f}")

    # Cycle budget utilization (23 MHz @ 60fps for SH2, 7.67 MHz for 68K)
    sh2_cycles_per_frame = 23000000 // 60  # SH2 @ 23 MHz
    m68k_cycles_per_frame = 7670000 // 60  # 68K @ 7.67 MHz (Genesis clock / 7)
    avg_m68k = sum(m68k_values) / len(m68k_values) if m68k_values else 0
    avg_msh2 = sum(msh2_values) / len(msh2_values)
    avg_ssh2 = sum(ssh2_values) / len(ssh2_values)

    print(f"\nCycle Budget:")
    if avg_m68k > 0:
        print(f"  68000:  {m68k_cycles_per_frame:,}/frame @ 7.67 MHz")
        print(f"          Utilization: {100*avg_m68k/m68k_cycles_per_frame:.1f}%")
    print(f"  SH2:    {sh2_cycles_per_frame:,}/frame @ 23 MHz")
    print(f"          Master Utilization: {100*avg_msh2/sh2_cycles_per_frame:.1f}%")
    print(f"          Slave Utilization:  {100*avg_ssh2/sh2_cycles_per_frame:.1f}%")

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

    # COMM5/COMM6 parallel processing analysis
    if has_comm56 and comm5_values and comm6_values:
        print(f"\n=== PHASE 1 PARALLEL PROCESSING ANALYSIS ===")
        print(f"COMM6 = Master signals sent | COMM5 = Slave acknowledgements")

        # Get final values (counters are cumulative)
        final_comm5 = comm5_values[-1][1] if comm5_values else 0
        final_comm6 = comm6_values[-1][1] if comm6_values else 0
        gap = final_comm6 - final_comm5

        print(f"\nCumulative Counters (after {len(comm5_values)} frames):")
        print(f"  COMM6 (Master signals):  {final_comm6:,}")
        print(f"  COMM5 (Slave ACKs):      {final_comm5:,}")
        print(f"  Gap (pending work):      {gap:,}")

        if gap == 0:
            print(f"  Status: PERFECT SYNC - Slave keeping up with all Master signals")
        elif gap > 0 and gap <= 10:
            print(f"  Status: EXCELLENT - Slave nearly keeping up (gap < 10)")
        elif gap > 10 and gap <= 100:
            print(f"  Status: GOOD - Minor lag, Slave slightly behind")
        elif gap > 100:
            rate = 100.0 * final_comm5 / final_comm6 if final_comm6 > 0 else 0
            print(f"  Status: FALLING BEHIND - Slave processing {rate:.1f}% of Master signals")

        # Calculate signals per frame
        if len(comm5_values) > 1:
            frames = len(comm5_values)
            signals_per_frame = final_comm6 / frames
            acks_per_frame = final_comm5 / frames
            print(f"\nThroughput:")
            print(f"  Master signals/frame: {signals_per_frame:.2f}")
            print(f"  Slave ACKs/frame:     {acks_per_frame:.2f}")
    elif has_comm56:
        print(f"\n=== PHASE 1 PARALLEL PROCESSING ANALYSIS ===")
        print(f"No COMM5/COMM6 activity detected (title screen / no work dispatched)")

    # Work distribution analysis
    print("\n=== WORK DISTRIBUTION ===")
    total_sh2_work = avg_msh2 + avg_ssh2
    if total_sh2_work > 0:
        print(f"SH2 Work Distribution:")
        print(f"  Master share: {100*avg_msh2/total_sh2_work:.1f}%")
        print(f"  Slave share:  {100*avg_ssh2/total_sh2_work:.1f}%")
        if avg_ssh2 > avg_msh2:
            imbalance = 100*(avg_ssh2-avg_msh2)/avg_msh2
            print(f"  Imbalance: Slave doing {imbalance:+.1f}% more work than Master")

    # Total system work (68K + SH2s)
    if avg_m68k > 0:
        # Convert 68K cycles to SH2-equivalent cycles for comparison (23 MHz vs 7.67 MHz = 3x)
        m68k_equiv_sh2 = avg_m68k * (23000000 / 7670000)
        total_system_work = m68k_equiv_sh2 + avg_msh2 + avg_ssh2
        print(f"\nTotal System Work (SH2-equivalent cycles):")
        print(f"  68000:  {m68k_equiv_sh2:,.0f} cycles ({100*m68k_equiv_sh2/total_system_work:.1f}%)")
        print(f"  Master: {avg_msh2:,.0f} cycles ({100*avg_msh2/total_system_work:.1f}%)")
        print(f"  Slave:  {avg_ssh2:,.0f} cycles ({100*avg_ssh2/total_system_work:.1f}%)")
        print(f"  Total:  {total_system_work:,.0f} cycles/frame")

        # Frame time bottleneck analysis
        print(f"\nBottleneck Analysis:")
        max_m68k_time = avg_m68k / 7670000  # seconds
        max_msh2_time = avg_msh2 / 23000000  # seconds
        max_ssh2_time = avg_ssh2 / 23000000  # seconds
        bottleneck_time = max(max_m68k_time, max_msh2_time, max_ssh2_time)
        theoretical_fps = 1.0 / bottleneck_time if bottleneck_time > 0 else 0

        if max_m68k_time >= max_msh2_time and max_m68k_time >= max_ssh2_time:
            print(f"  Bottleneck: 68000 ({avg_m68k:,.0f} cycles @ 7.67 MHz = {max_m68k_time*1000:.2f} ms/frame)")
        elif max_msh2_time >= max_ssh2_time:
            print(f"  Bottleneck: Master SH2 ({avg_msh2:,.0f} cycles @ 23 MHz = {max_msh2_time*1000:.2f} ms/frame)")
        else:
            print(f"  Bottleneck: Slave SH2 ({avg_ssh2:,.0f} cycles @ 23 MHz = {max_ssh2_time*1000:.2f} ms/frame)")

        print(f"  Theoretical max FPS: {theoretical_fps:.1f} (based on bottleneck CPU)")
        print(f"  Note: Actual FPS may be lower due to blocking sync overhead")

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
    if max_cycles > sh2_cycles_per_frame:
        print(f"\nPerformance Warning: Peak SH2 cycles ({max_cycles:,}) exceed 60fps budget!")
        estimated_fps = 23000000 / max_cycles
        print(f"  Estimated min FPS: {estimated_fps:.1f}")


if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Usage: analyze_profile.py <profile.csv>")
        sys.exit(1)

    analyze_profile(sys.argv[1])
