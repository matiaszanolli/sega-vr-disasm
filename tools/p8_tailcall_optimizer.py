#!/usr/bin/env python3
"""
Priority 8 Tail-Call Optimizer for func_D1D4

This script identifies and optimizes tail-call patterns in func_D1D4:
  - Pattern: JSR $xxxxxxxx followed immediately by RTS
  - Optimization: Replace JSR with JMP (eliminates one RTS)
  - Savings: 6 cycles per tail-call (33% improvement per pattern)

Usage:
    python3 p8_tailcall_optimizer.py [--dry-run] [--verbose]

Options:
    --dry-run   Analyze only, don't modify ROM
    --verbose   Show detailed instruction analysis
"""

import struct
import sys
import os

# Configuration
ROM_PATH = 'Virtua Racing Deluxe (USA).32x'
OUTPUT_PATH = 'build/vr_optimized_tailcall.32x'

# func_D1D4 boundaries
FUNC_D1D4_START = 0xD1D4
FUNC_D1D4_END = 0xD2DD  # 552 bytes

# Opcodes
JSR_ABSOLUTE = 0x4EB9  # JSR with absolute long address
JMP_ABSOLUTE = 0x4EF9  # JMP with absolute long address
RTS = 0x4E75           # Return from subroutine
NOP = 0x4E71           # No operation


def read_word(rom, offset):
    """Read big-endian word from ROM"""
    return (rom[offset] << 8) | rom[offset + 1]


def read_long(rom, offset):
    """Read big-endian long from ROM"""
    return (rom[offset] << 24) | (rom[offset + 1] << 16) | \
           (rom[offset + 2] << 8) | rom[offset + 3]


def find_tailcalls(rom, func_start, func_end, verbose=False):
    """
    Find all tail-call patterns in the specified function range.

    Pattern: JSR $xxxxxxxx (6 bytes) followed by RTS (2 bytes)

    Returns: List of (offset, target_address) tuples
    """
    tailcalls = []
    i = func_start

    if verbose:
        print(f"\nScanning ${func_start:05X} - ${func_end:05X} for tail-calls...")
        print("=" * 70)

    while i < func_end - 8:
        opcode = read_word(rom, i)

        if opcode == JSR_ABSOLUTE:
            # Found JSR with absolute address
            target = read_long(rom, i + 2)
            next_opcode = read_word(rom, i + 6)

            if next_opcode == RTS:
                # Found tail-call pattern: JSR + RTS
                tailcalls.append((i, target))
                if verbose:
                    cpu_addr = i + 0x880000
                    print(f"  ${cpu_addr:08X}: JSR ${target:08X} ; RTS follows at ${cpu_addr + 6:08X}")
                i += 8  # Skip both instructions
            else:
                i += 2
        else:
            i += 2

    return tailcalls


def verify_target_function(rom, target_addr, verbose=False):
    """
    Verify that target function ends with RTS (safe for tail-call).

    We scan forward from the target to find an RTS within reasonable distance.
    """
    # Convert CPU address to file offset
    if target_addr >= 0x880000:
        file_offset = target_addr - 0x880000
    else:
        file_offset = target_addr

    # Scan up to 1024 bytes for an RTS
    max_scan = min(1024, len(rom) - file_offset - 2)

    for i in range(0, max_scan, 2):
        opcode = read_word(rom, file_offset + i)
        if opcode == RTS:
            if verbose:
                print(f"    Target ${target_addr:08X}: RTS found at offset +{i} bytes")
            return True

    if verbose:
        print(f"    Target ${target_addr:08X}: WARNING - No RTS found within {max_scan} bytes")
    return False


def apply_tailcall_optimization(rom_data, tailcalls, verbose=False):
    """
    Apply tail-call optimization to ROM.

    For each tailcall:
      1. Replace JSR (0x4EB9) with JMP (0x4EF9)
      2. Replace RTS (0x4E75) with NOP (0x4E71) for padding

    Returns: Modified ROM data as bytearray
    """
    rom = bytearray(rom_data)
    patches_applied = 0

    if verbose:
        print("\nApplying tail-call optimizations...")
        print("=" * 70)

    for offset, target in tailcalls:
        cpu_addr = offset + 0x880000

        # Replace JSR with JMP
        original_jsr = read_word(rom, offset)
        if original_jsr != JSR_ABSOLUTE:
            print(f"  ERROR: Expected JSR at ${cpu_addr:08X}, found ${original_jsr:04X}")
            continue

        # Apply patch: JSR -> JMP
        rom[offset] = (JMP_ABSOLUTE >> 8) & 0xFF
        rom[offset + 1] = JMP_ABSOLUTE & 0xFF

        # Replace RTS with NOP (padding to maintain alignment)
        rts_offset = offset + 6
        original_rts = read_word(rom, rts_offset)
        if original_rts != RTS:
            print(f"  ERROR: Expected RTS at ${cpu_addr + 6:08X}, found ${original_rts:04X}")
            continue

        rom[rts_offset] = (NOP >> 8) & 0xFF
        rom[rts_offset + 1] = NOP & 0xFF

        if verbose:
            print(f"  ${cpu_addr:08X}: JSR ${target:08X} -> JMP ${target:08X}")
            print(f"  ${cpu_addr + 6:08X}: RTS -> NOP (padding)")

        patches_applied += 1

    return rom, patches_applied


def analyze_savings(tailcalls):
    """Calculate cycle savings from optimization"""
    num_tailcalls = len(tailcalls)

    # Per tail-call savings:
    # Original: JSR (6) + handler RTS (6) + caller RTS (6) = 18 cycles
    # Optimized: JMP (6) + handler RTS (6) = 12 cycles
    # Savings: 6 cycles per tail-call
    cycles_per_tailcall = 6
    total_savings = num_tailcalls * cycles_per_tailcall

    print("\n" + "=" * 70)
    print("OPTIMIZATION ANALYSIS")
    print("=" * 70)
    print(f"\nTail-calls found: {num_tailcalls}")
    print(f"Cycles saved per tail-call: {cycles_per_tailcall}")
    print(f"Total cycles saved per func_D1D4 call: {total_savings}")
    print()

    # Frame-level analysis
    print("Frame-Level Impact (if func_D1D4 is frame-critical):")
    print("-" * 50)

    scenarios = [
        ("60 calls/frame (frame-critical)", 60),
        ("30 calls/frame (frequent)", 30),
        ("10 calls/frame (moderate)", 10),
        ("1 call/frame (occasional)", 1),
    ]

    frame_budget = 386667  # cycles at 60 Hz

    for desc, calls in scenarios:
        frame_savings = total_savings * calls
        percentage = (frame_savings / frame_budget) * 100
        print(f"  {desc}:")
        print(f"    Savings: {frame_savings} cycles/frame ({percentage:.2f}%)")

    return total_savings


def main():
    # Parse arguments
    dry_run = '--dry-run' in sys.argv
    verbose = '--verbose' in sys.argv or '-v' in sys.argv

    print("=" * 70)
    print("Priority 8 Tail-Call Optimizer for func_D1D4")
    print("=" * 70)
    print(f"\nROM Path: {ROM_PATH}")
    print(f"Output Path: {OUTPUT_PATH}")
    print(f"Mode: {'DRY RUN (analysis only)' if dry_run else 'LIVE (will modify ROM)'}")
    print(f"Verbose: {verbose}")

    # Read ROM
    if not os.path.exists(ROM_PATH):
        print(f"\nERROR: ROM file not found: {ROM_PATH}")
        print("Please ensure the ROM file is in the current directory.")
        return 1

    with open(ROM_PATH, 'rb') as f:
        rom = f.read()

    original_size = len(rom)
    print(f"\nOriginal ROM size: {original_size:,} bytes")

    # Find tail-call patterns
    print("\n" + "-" * 70)
    print("PHASE 1: Pattern Detection")
    print("-" * 70)

    tailcalls = find_tailcalls(rom, FUNC_D1D4_START, FUNC_D1D4_END, verbose)

    if not tailcalls:
        print("\nNo tail-call patterns found in func_D1D4.")
        print("This could mean:")
        print("  1. The function doesn't use tail-calls")
        print("  2. Tail-calls are already optimized")
        print("  3. The function boundaries need adjustment")
        return 0

    print(f"\nFound {len(tailcalls)} tail-call pattern(s)")

    # Verify target functions
    print("\n" + "-" * 70)
    print("PHASE 2: Target Verification")
    print("-" * 70)

    verified_tailcalls = []
    for offset, target in tailcalls:
        if verify_target_function(rom, target, verbose):
            verified_tailcalls.append((offset, target))
        else:
            cpu_addr = offset + 0x880000
            print(f"  SKIPPING ${cpu_addr:08X}: Target function verification failed")

    if not verified_tailcalls:
        print("\nNo tail-calls passed verification.")
        return 0

    print(f"\nVerified {len(verified_tailcalls)} tail-call(s) for optimization")

    # Analyze savings
    total_savings = analyze_savings(verified_tailcalls)

    if dry_run:
        print("\n" + "=" * 70)
        print("DRY RUN COMPLETE - No changes made")
        print("=" * 70)
        print("\nTo apply optimization, run without --dry-run flag")
        return 0

    # Apply optimization
    print("\n" + "-" * 70)
    print("PHASE 3: Apply Optimization")
    print("-" * 70)

    optimized_rom, patches_applied = apply_tailcall_optimization(
        rom, verified_tailcalls, verbose
    )

    # Verify size unchanged
    if len(optimized_rom) != original_size:
        print(f"\nERROR: ROM size changed! Original: {original_size}, New: {len(optimized_rom)}")
        return 1

    print(f"\nPatches applied: {patches_applied}")
    print(f"ROM size unchanged: {len(optimized_rom):,} bytes")

    # Write optimized ROM
    os.makedirs(os.path.dirname(OUTPUT_PATH), exist_ok=True)
    with open(OUTPUT_PATH, 'wb') as f:
        f.write(optimized_rom)

    print(f"Optimized ROM written to: {OUTPUT_PATH}")

    # Verification summary
    print("\n" + "=" * 70)
    print("OPTIMIZATION COMPLETE")
    print("=" * 70)
    print(f"\nSummary:")
    print(f"  • Tail-calls optimized: {patches_applied}")
    print(f"  • Bytes modified: {patches_applied * 4} (2 per JSR->JMP, 2 per RTS->NOP)")
    print(f"  • Cycles saved per call: {total_savings}")
    print(f"  • ROM size: {len(optimized_rom):,} bytes (unchanged)")

    print(f"\nNext steps:")
    print(f"  1. Verify with: cmp -l '{ROM_PATH}' '{OUTPUT_PATH}' | head -20")
    print(f"  2. Test in emulator: blastem {OUTPUT_PATH}")
    print(f"  3. If successful, commit to feature branch")

    return 0


if __name__ == '__main__':
    sys.exit(main())
