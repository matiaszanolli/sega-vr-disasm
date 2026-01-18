#!/usr/bin/env python3
"""
Build a global symbol table from assembly files and analysis.
Identifies function entry points and assigns meaningful names.
"""

import re
import os
from pathlib import Path
from collections import defaultdict

SECTIONS_DIR = Path(__file__).parent.parent / "disasm" / "sections"

# Known hardware registers (from 32X documentation)
HARDWARE_SYMBOLS = {
    0x00A15100: "ADAPTER_CTRL",
    0x00A15102: "INT_CTRL",
    0x00A15104: "BANK_SET",
    0x00A15106: "DREQ_CTRL",
    0x00A15120: "COMM_PORT_0",
    0x00A15122: "COMM_PORT_1",
    0x00A15124: "COMM_PORT_2",
    0x00A15126: "COMM_PORT_3",
    0x00A15128: "COMM_PORT_4",
    0x00A1512A: "COMM_PORT_5",
    0x00A1512C: "COMM_PORT_6",
    0x00A1512E: "COMM_PORT_7",
    0x00C00000: "VDP_DATA",
    0x00C00004: "VDP_CTRL",
}

# Manual function annotations from analysis
KNOWN_FUNCTIONS = {
    # Boot/Init
    0x000200: "entry_point",
    0x000838: "adapter_init",

    # SH2 Communication (from code analysis)
    0x00E316: "sh2_send_cmd_wait",      # Waits for ready, sends command
    0x00E35A: "sh2_send_cmd",           # Sends command to SH2
    0x00E342: "sh2_wait_response",      # Waits for SH2 response

    # VDP/Display
    0x008548: "vdp_operation",
    0x00859A: "vdp_write",

    # Game logic (frequent callers)
    0x009802: "game_update",
    0x00B684: "object_update",
    0x009B54: "physics_calc",
    0x00A350: "collision_check",
    0x00B6DA: "sprite_update",
    0x009182: "input_process",
    0x00961E: "state_machine",
    0x009B12: "movement_calc",
    0x009312: "timer_update",
    0x00E52C: "dma_transfer",
    0x009CCE: "math_routine",
    0x0037B6: "memory_copy",
    0x0059EC: "table_lookup",
    0x00A434: "score_update",
    0x0094FA: "sound_trigger",
    0x0036DE: "clear_buffer",
    0x00764E: "render_prep",
    0x00714A: "transform_calc",
    0x00B09E: "animation_update",
}


def find_function_entries(asm_file):
    """Find function entry points in an assembly file."""
    entries = {}

    with open(asm_file, 'r') as f:
        lines = f.readlines()

    prev_was_rts = False
    for i, line in enumerate(lines):
        # Look for labels
        label_match = re.match(r'^(loc_[0-9A-Fa-f]+):', line)
        if label_match:
            label = label_match.group(1)
            addr = int(label.replace('loc_', ''), 16)
            # If previous instruction was RTS, this is likely a function start
            if prev_was_rts:
                entries[addr] = f"func_{addr:06X}"

        # Track RTS instructions
        prev_was_rts = 'RTS' in line and '; $' in line

    return entries


def collect_call_targets(asm_file):
    """Collect all JSR/JMP target addresses."""
    targets = defaultdict(int)

    with open(asm_file, 'r') as f:
        content = f.read()

    # Find JSR/JMP targets
    for match in re.finditer(r'(?:JSR|JMP)\s+(?:loc_)?(\$?[0-9A-Fa-f]{4,8})', content):
        addr_str = match.group(1).replace('$', '').replace('loc_', '')
        try:
            addr = int(addr_str, 16)
            # Normalize to file offset range
            if addr >= 0x00880000:
                addr -= 0x00880000
            targets[addr] += 1
        except ValueError:
            pass

    return targets


def build_symbol_table():
    """Build complete symbol table."""
    symbols = {}
    call_counts = defaultdict(int)

    # Start with known functions
    symbols.update(KNOWN_FUNCTIONS)

    # Scan all assembly files
    for asm_file in sorted(SECTIONS_DIR.glob("code_*.asm")):
        # Collect call targets
        targets = collect_call_targets(asm_file)
        for addr, count in targets.items():
            call_counts[addr] += count

        # Find function entries
        entries = find_function_entries(asm_file)
        for addr, name in entries.items():
            if addr not in symbols:
                symbols[addr] = name

    # Add unnamed but frequently called addresses
    for addr, count in sorted(call_counts.items(), key=lambda x: -x[1]):
        if addr not in symbols and count >= 5:
            symbols[addr] = f"func_{addr:06X}"

    return symbols, call_counts


def generate_inc_file(symbols, output_path):
    """Generate assembly include file with EQU definitions."""
    with open(output_path, 'w') as f:
        f.write("; ============================================================================\n")
        f.write("; Global Symbol Table - Auto-generated\n")
        f.write("; ============================================================================\n\n")

        f.write("; Hardware Registers\n")
        for addr, name in sorted(HARDWARE_SYMBOLS.items()):
            f.write(f"{name:24} EQU ${addr:08X}\n")

        f.write("\n; Function Entry Points\n")
        for addr, name in sorted(symbols.items()):
            f.write(f"{name:24} EQU ${addr:06X}\n")


def generate_symbol_map(symbols, call_counts, output_path):
    """Generate human-readable symbol map."""
    with open(output_path, 'w') as f:
        f.write("# Global Symbol Map\n\n")
        f.write("| Address | Symbol | Call Count |\n")
        f.write("|---------|--------|------------|\n")

        for addr, name in sorted(symbols.items()):
            count = call_counts.get(addr, 0)
            f.write(f"| ${addr:06X} | {name} | {count} |\n")


def main():
    print("Building symbol table...")

    symbols, call_counts = build_symbol_table()

    print(f"Found {len(symbols)} function symbols")
    print(f"Top 10 most called:")
    for addr, count in sorted(call_counts.items(), key=lambda x: -x[1])[:10]:
        name = symbols.get(addr, f"${addr:06X}")
        print(f"  {name}: {count} calls")

    # Generate outputs
    inc_path = SECTIONS_DIR / "symbols.inc"
    map_path = SECTIONS_DIR / "SYMBOL_MAP.md"

    generate_inc_file(symbols, inc_path)
    print(f"\nGenerated: {inc_path}")

    generate_symbol_map(symbols, call_counts, map_path)
    print(f"Generated: {map_path}")

    return symbols


if __name__ == "__main__":
    main()
