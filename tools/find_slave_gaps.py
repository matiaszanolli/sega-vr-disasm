#!/usr/bin/env python3
"""
Find unused code gaps in Slave SH2 ROM sections.

Scans for sequences of NOPs ($0009) and other padding patterns to identify
safe injection points for new code.
"""

import sys
import re

def find_gaps_in_asm(filepath, min_gap_size=4):
    """
    Find sequences of NOPs and padding in assembly files.

    Args:
        filepath: Path to .asm file
        min_gap_size: Minimum number of consecutive words to report

    Returns:
        List of (start_addr, end_addr, size_words, content) tuples
    """
    gaps = []
    current_gap = None

    with open(filepath, 'r') as f:
        for line in f:
            line = line.strip()

            # Match dc.w lines with address comments
            match = re.match(r'dc\.w\s+\$([0-9A-Fa-f]+)\s*;\s*\$([0-9A-Fa-f]+)(?:\s*-\s*(.*))?', line)
            if not match:
                # End current gap if we hit non-data
                if current_gap and current_gap['count'] >= min_gap_size:
                    gaps.append(current_gap)
                current_gap = None
                continue

            value = match.group(1)
            addr = int(match.group(2), 16)
            comment = match.group(3) or ""

            # Check if this is a NOP or unused padding
            is_gap = False
            gap_type = None

            if value == '0009':
                is_gap = True
                gap_type = 'NOP'
            elif 'unused' in comment.lower() or 'padding' in comment.lower():
                is_gap = True
                gap_type = 'PADDING'
            elif value == 'FFFF':
                is_gap = True
                gap_type = 'FILL_FF'

            if is_gap:
                if current_gap is None:
                    # Start new gap
                    current_gap = {
                        'start': addr,
                        'end': addr,
                        'count': 1,
                        'type': gap_type,
                        'values': [value]
                    }
                elif current_gap['type'] == gap_type and addr == current_gap['end'] + 2:
                    # Continue existing gap
                    current_gap['end'] = addr
                    current_gap['count'] += 1
                    current_gap['values'].append(value)
                else:
                    # Type changed or non-contiguous - save and start new
                    if current_gap['count'] >= min_gap_size:
                        gaps.append(current_gap)
                    current_gap = {
                        'start': addr,
                        'end': addr,
                        'count': 1,
                        'type': gap_type,
                        'values': [value]
                    }
            else:
                # Not a gap - save current if long enough
                if current_gap and current_gap['count'] >= min_gap_size:
                    gaps.append(current_gap)
                current_gap = None

    # Save final gap if exists
    if current_gap and current_gap['count'] >= min_gap_size:
        gaps.append(current_gap)

    return gaps

def main():
    if len(sys.argv) < 2:
        print("Usage: python3 find_slave_gaps.py <slave_code.asm>")
        sys.exit(1)

    filepath = sys.argv[1]
    min_gap = int(sys.argv[2]) if len(sys.argv) > 2 else 4

    print(f"Scanning {filepath} for gaps of {min_gap}+ words...")
    print()

    gaps = find_gaps_in_asm(filepath, min_gap)

    if not gaps:
        print("No gaps found.")
        return

    print(f"Found {len(gaps)} gaps:\n")
    print("=" * 80)

    total_words = 0
    for gap in gaps:
        size_words = gap['count']
        size_bytes = size_words * 2
        total_words += size_words

        print(f"Address: $0{gap['start']:05X} - $0{gap['end']:05X}")
        print(f"Size:    {size_words} words ({size_bytes} bytes)")
        print(f"Type:    {gap['type']}")

        # Show what fits
        if size_bytes >= 20:
            print(f"Fits:    Full work_check function (20 bytes)")
        elif size_bytes >= 12:
            print(f"Fits:    JSR helper (12 bytes)")
        elif size_bytes >= 8:
            print(f"Fits:    BSR + address literal (8 bytes)")
        else:
            print(f"Fits:    Small patch only")

        print("-" * 80)

    print()
    print(f"Total usable space: {total_words} words ({total_words * 2} bytes)")

if __name__ == '__main__':
    main()
