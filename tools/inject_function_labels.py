#!/usr/bin/env python3
"""
Inject function labels from 68K_FUNCTION_REFERENCE.md into mnemonic section files.

This script:
1. Parses the function reference for address → name mappings
2. Finds the correct section file for each function
3. Inserts labels at the correct addresses
4. Adds brief comments from the description
"""

import os
import re
import sys
from pathlib import Path

def parse_function_reference(ref_file):
    """Parse 68K_FUNCTION_REFERENCE.md for function definitions."""
    functions = {}

    with open(ref_file, 'r') as f:
        lines = f.readlines()

    for line in lines:
        # Match table rows: | $XXXXXX | `func_name` | Description |
        # Also handles 4-column format: | $XXXXXX | `func_name` | State | Description |
        match = re.match(r'\|\s*\$([0-9A-Fa-f]+)\s*\|\s*`([^`]+)`\s*\|(.+)', line)
        if match:
            addr = int(match.group(1), 16)
            name = match.group(2)
            # Get description - may have multiple columns
            rest = match.group(3)
            parts = rest.split('|')
            # Description is last non-empty part
            desc = parts[-2].strip() if len(parts) >= 2 else parts[0].strip()
            functions[addr] = {'name': name, 'desc': desc}

    return functions

def find_section_file(addr, sections_dir):
    """Find which section file contains the given address."""
    # Section files are named code_XXXXX.asm where XXXXX is the start address in hex
    # They cover ranges like $00E200-$0101FF (8KB sections typically)

    for asm_file in sorted(sections_dir.glob('code_*.asm')):
        # Read header to get range
        with open(asm_file, 'r') as f:
            header = f.read(500)

        # Parse range from header: ($XXXXXX-$XXXXXX)
        range_match = re.search(r'\(\$([0-9A-Fa-f]+)-\$([0-9A-Fa-f]+)\)', header)
        if range_match:
            start = int(range_match.group(1), 16)
            end = int(range_match.group(2), 16)
            if start <= addr <= end:
                return asm_file

    return None

def inject_labels_into_file(asm_file, functions, dry_run=False):
    """Inject function labels into a section file."""
    with open(asm_file, 'r') as f:
        lines = f.readlines()

    # Find which functions belong to this file
    range_match = None
    for i, line in enumerate(lines[:10]):
        match = re.search(r'\(\$([0-9A-Fa-f]+)-\$([0-9A-Fa-f]+)\)', line)
        if match:
            range_match = match
            break

    if not range_match:
        return 0, []

    start_addr = int(range_match.group(1), 16)
    end_addr = int(range_match.group(2), 16)

    # Find functions in this range
    file_functions = {addr: info for addr, info in functions.items()
                      if start_addr <= addr <= end_addr}

    if not file_functions:
        return 0, []

    # Track what we inject
    injected = []
    modified_lines = []

    for line in lines:
        # Check if this line has an address we need to label
        # Pattern: "; $XXXXXX" or "loc_XXXXXX:" or just the instruction at that address
        addr_match = re.search(r';\s*\$([0-9A-Fa-f]{5,6})\b', line)

        if addr_match:
            line_addr = int(addr_match.group(1), 16)

            if line_addr in file_functions:
                func_info = file_functions[line_addr]
                name = func_info['name']
                desc = func_info['desc']

                # Check if already labeled
                if f'{name}:' not in line and f'loc_{line_addr:06X}' in line:
                    # Replace loc_XXXXXX with function name
                    line = line.replace(f'loc_{line_addr:06X}', name)
                    injected.append((line_addr, name))
                elif f'{name}:' not in line and f'; ${line_addr:06X}' in line:
                    # No label exists, add one before this line
                    # Add a separator comment and the label
                    label_block = f"""; ----------------------------------------------------------------------------
; {name} (${line_addr:06X}) - {desc}
; ----------------------------------------------------------------------------
{name}:
"""
                    modified_lines.append(label_block)
                    injected.append((line_addr, name))

        modified_lines.append(line)

    if injected and not dry_run:
        with open(asm_file, 'w') as f:
            f.writelines(modified_lines)

    return len(injected), injected

def main():
    import argparse
    parser = argparse.ArgumentParser(description='Inject function labels into mnemonic sections')
    parser.add_argument('--ref', type=Path, default='analysis/68K_FUNCTION_REFERENCE.md',
                       help='Function reference file')
    parser.add_argument('--sections', type=Path, default='disasm/sections-mnemonic',
                       help='Mnemonic sections directory')
    parser.add_argument('--dry-run', action='store_true',
                       help='Show what would be done without modifying files')
    parser.add_argument('--verbose', '-v', action='store_true',
                       help='Verbose output')
    args = parser.parse_args()

    # Parse function reference
    print(f"Parsing function reference: {args.ref}")
    functions = parse_function_reference(args.ref)
    print(f"  Found {len(functions)} function definitions")

    # Process each function
    total_injected = 0
    files_modified = 0

    # Group functions by file
    functions_by_file = {}
    for addr, info in sorted(functions.items()):
        section_file = find_section_file(addr, args.sections)
        if section_file:
            if section_file not in functions_by_file:
                functions_by_file[section_file] = {}
            functions_by_file[section_file][addr] = info
        elif args.verbose:
            print(f"  WARNING: No section file found for ${addr:06X} ({info['name']})")

    print(f"\nProcessing {len(functions_by_file)} section files...")

    for asm_file, file_funcs in sorted(functions_by_file.items()):
        count, injected = inject_labels_into_file(asm_file, file_funcs, args.dry_run)
        if count > 0:
            files_modified += 1
            total_injected += count
            if args.verbose:
                print(f"  {asm_file.name}: {count} labels")
                for addr, name in injected:
                    print(f"    ${addr:06X}: {name}")

    print(f"\n{'Would inject' if args.dry_run else 'Injected'} {total_injected} labels in {files_modified} files")

    if args.dry_run:
        print("\nRun without --dry-run to apply changes")

if __name__ == '__main__':
    main()
