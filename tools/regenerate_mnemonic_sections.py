#!/usr/bin/env python3
"""
Regenerate all mnemonic section files using the fixed disassembler.

Reads each section file to get its address range, then regenerates
with proper mnemonics instead of DC.W.
"""

import os
import re
import sys
from pathlib import Path

# Add tools directory to path
sys.path.insert(0, str(Path(__file__).parent))
from disasm_to_asm import AssemblyGenerator


def parse_section_range(section_file):
    """Extract start and end addresses from a section file header."""
    with open(section_file, 'r') as f:
        content = f.read(1000)  # Only need to read the header

    # Look for range in header comment: ($XXXXXX-$XXXXXX)
    match = re.search(r'\(\$([0-9A-Fa-f]+)-\$([0-9A-Fa-f]+)\)', content)
    if match:
        return int(match.group(1), 16), int(match.group(2), 16) + 1  # +1 because end is inclusive

    # Fallback: calculate from filename and content
    org_match = re.search(r'org\s+\$([0-9A-Fa-f]+)', content)
    if org_match:
        start = int(org_match.group(1), 16)
        # Count dc.w entries
        dcw_count = len(re.findall(r'dc\.w\s+\$[0-9A-Fa-f]+', content, re.IGNORECASE))
        return start, start + dcw_count * 2

    return None, None


def regenerate_section(rom_data, section_file, output_dir):
    """Regenerate a single section file with mnemonics."""
    start, end = parse_section_range(section_file)
    if start is None:
        print(f"  WARNING: Could not parse range from {section_file}")
        return False, 0, "Could not parse range"

    gen = AssemblyGenerator(rom_data, start, end)
    output = gen.generate(use_dcw=False)  # Pure mnemonics

    # Get the output filename
    basename = os.path.basename(section_file)
    output_path = os.path.join(output_dir, basename)

    # Generate with header
    header = f"""; ============================================================================
; Code Section (${start:06X}-${end-1:06X})
; Regenerated with fixed disassembler - proper mnemonics
; ============================================================================

"""

    # The generate() function includes its own header, so strip the first few lines
    lines = output.split('\n')
    # Find where the actual code starts (after the generated header)
    code_start = 0
    for i, line in enumerate(lines):
        if line.strip().startswith('org'):
            code_start = i
            break

    final_output = header + '\n'.join(lines[code_start:])

    with open(output_path, 'w') as f:
        f.write(final_output)

    fallback_count = len(gen.disasm.fallbacks)
    return True, fallback_count, None


def main():
    import argparse
    parser = argparse.ArgumentParser(description='Regenerate mnemonic sections')
    parser.add_argument('--rom', type=Path, default='build/vr_rebuild.32x',
                       help='ROM file to disassemble')
    parser.add_argument('--input-dir', type=Path, default='disasm/sections',
                       help='Directory with DC.W section files')
    parser.add_argument('--output-dir', type=Path, default='disasm/sections-mnemonic',
                       help='Output directory for mnemonic files')
    parser.add_argument('--limit', type=int, default=0,
                       help='Limit number of files to process (0=all)')
    args = parser.parse_args()

    # Load ROM
    print(f"Loading ROM: {args.rom}")
    with open(args.rom, 'rb') as f:
        rom_data = f.read()
    print(f"  ROM size: {len(rom_data):,} bytes")

    # Create output directory
    os.makedirs(args.output_dir, exist_ok=True)

    # Get list of section files
    section_files = sorted(args.input_dir.glob('code_*.asm'))
    total_files = len(section_files)
    print(f"\nFound {total_files} section files")

    if args.limit > 0:
        section_files = section_files[:args.limit]
        print(f"Processing first {args.limit} files only")

    # Process each file
    success_count = 0
    fail_count = 0
    total_fallbacks = 0

    for i, section_file in enumerate(section_files, 1):
        basename = section_file.name
        print(f"[{i:3d}/{len(section_files):3d}] {basename}...", end='', flush=True)

        success, fallbacks, error = regenerate_section(rom_data, section_file, args.output_dir)

        if success:
            success_count += 1
            total_fallbacks += fallbacks
            print(f" OK ({fallbacks} fallbacks)")
        else:
            fail_count += 1
            print(f" FAILED: {error}")

    # Summary
    print(f"\n{'='*60}")
    print(f"Summary:")
    print(f"  Files processed: {success_count + fail_count}")
    print(f"  Successful: {success_count}")
    print(f"  Failed: {fail_count}")
    print(f"  Total DC.W fallbacks: {total_fallbacks}")
    print(f"\nOutput written to: {args.output_dir}")


if __name__ == '__main__':
    main()
