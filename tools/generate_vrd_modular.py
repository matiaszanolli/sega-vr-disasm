#!/usr/bin/env python3
"""
Generate the vrd_modular.asm includes section based on extracted modules.
"""

import os
import re

HEADER = """; ============================================================================
; Virtua Racing Deluxe (USA) - Sega 32X
; Modular Assembly File - REFACTORED VERSION
; ============================================================================
;
; Product: V.R.DX
; Serial: GM MK-84601-00
; Copyright: (C)SEGA 1994.SEP
; ROM Size: 3MB (3,145,728 bytes)
;
; Build: make modular
; Verify: make compare-modular (should show PERFECT MATCH)
;
; MODULE ORGANIZATION:
;   All code is now organized in modules/ directory by feature:
;   - boot/: ROM header, init sequence
;   - main-loop/: V-INT handler, state machine
;   - input/: Controller handling
;   - display/: VDP operations
;   - sound/: Z80 sound interface
;   - hardware-regs/: MARS register access
;   - game/: Game logic
;   - data/: Data sections and SH2 code
;
; ============================================================================

        include "sections/mars_defs.asm"

; ============================================================================
; Modular sections (all code organized by feature)
; ============================================================================

"""

def get_addr_from_module(filepath):
    """Extract the start address from a module file."""
    with open(filepath, 'r') as f:
        for line in f:
            match = re.search(r'org\s+\$([0-9A-Fa-f]+)', line)
            if match:
                return int(match.group(1), 16)
    return None

def main():
    modules_dir = 'disasm/modules/68k'
    output_file = 'disasm/vrd_modular.asm'

    # Collect all modules with their addresses
    modules = []

    for root, dirs, files in os.walk(modules_dir):
        for f in files:
            if f.endswith('.asm'):
                filepath = os.path.join(root, f)
                addr = get_addr_from_module(filepath)
                if addr is not None:
                    # Get relative path from disasm/
                    rel_path = os.path.relpath(filepath, 'disasm')
                    modules.append((addr, rel_path, f))

    # Sort by address
    modules.sort(key=lambda x: x[0])

    print(f"Found {len(modules)} modules")

    # Generate output
    with open(output_file, 'w') as f:
        f.write(HEADER)

        current_category = None
        for addr, path, filename in modules:
            # Determine category from path
            if 'boot/' in path:
                cat = 'Boot'
            elif 'main-loop/' in path:
                cat = 'Main Loop'
            elif 'input/' in path:
                cat = 'Input'
            elif 'display/' in path:
                cat = 'Display'
            elif 'sound/' in path:
                cat = 'Sound'
            elif 'hardware-regs/' in path:
                cat = 'Hardware'
            elif 'game/' in path:
                cat = 'Game Logic'
            elif 'data/' in path:
                cat = 'Data/SH2'
            elif 'sh2/' in path:
                cat = 'SH2 Code'
            else:
                cat = 'Other'

            # Print category header if changed
            if cat != current_category:
                if current_category is not None:
                    f.write("\n")
                f.write(f"; --- {cat} ---\n")
                current_category = cat

            # Write include
            f.write(f"        include \"{path}\"\n")

    print(f"Generated {output_file}")

if __name__ == '__main__':
    main()
