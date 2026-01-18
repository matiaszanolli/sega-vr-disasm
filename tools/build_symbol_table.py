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
    # Boot/Init (from analysis/VINT_HANDLER_ARCHITECTURE.md)
    0x000200: "entry_point",
    0x000838: "adapter_init",

    # V-INT Handler (from analysis/VINT_HANDLER_ARCHITECTURE.md)
    0x001684: "vint_handler",           # V-INT entry point
    0x0016B0: "vint_early_exit",        # RTE when no state change
    0x00170A: "vint_return",            # RTE instruction
    0x00170C: "controller_port_init",   # Initialize controller ports

    # V-INT State Handlers (from analysis/VINT_STATE_HANDLERS.md)
    0x0019FE: "vint_state_common",      # States 0,1,2,8 - VDP sync + RAM
    0x001A6E: "vint_state_minimal",     # State 4 - Quick VDP read
    0x001A72: "vint_state_vdp_sync",    # State 5 - Full VDP sync
    0x001C66: "vint_state_fb_toggle",   # State 6 - Frame buffer toggle
    0x001ACA: "vint_state_sprite_cfg",  # State 7 - Sprite config
    0x001E42: "vint_state_fb_setup",    # State 9 - Frame buffer setup
    0x001B14: "vint_state_vdp_config",  # State 10 - VDP config
    0x001A64: "vint_state_transition",  # State 11 - Set next state
    0x001BA8: "vint_state_complex",     # State 12 - Complex VDP ops
    0x001E94: "vint_state_fb_palette",  # State 13 - FB + palette
    0x001F4A: "vint_state_fb_dma",      # State 14 - FB DMA
    0x002010: "vint_state_cleanup",     # State 15 - Clear SH2 flags

    # Controller Input (from analysis/CONTROLLER_INPUT_ARCHITECTURE.md)
    0x0017EE: "button_remap",           # Button remapping function
    0x00185E: "zbus_request",           # Z-Bus request

    # SH2 Communication (from code analysis)
    0x00E316: "sh2_send_cmd_wait",      # Waits for ready, sends command
    0x00E35A: "sh2_send_cmd",           # Sends command to SH2
    0x00E342: "sh2_wait_response",      # Waits for SH2 response

    # VDP/Display (from modules/68k/display/)
    0x0027F8: "VDPFill",
    0x00281E: "VDPPrep",
    0x002878: "PaletteRAMCopy",
    0x0028C2: "VDPSyncSH2",
    0x008548: "vdp_operation",
    0x00859A: "vdp_write",

    # Memory operations (from modules/68k/memory/)
    0x004836: "QuadMemoryFill",
    0x00483A: "MemoryFillWaterfall1",
    0x00483E: "MemoryFillWaterfall2",
    0x004842: "MemoryFill60A1",
    0x004846: "MemoryFill60A4",
    0x004856: "UnrolledFill96",
    0x00485E: "UnrolledFill112",
    0x0048B8: "UnrolledFill32",
    0x0048CA: "TripleMemoryFill",
    0x0048CE: "MemoryFillWaterfall3",
    0x0048D2: "MemoryFillWaterfall4",
    0x0048FE: "UnrolledFill60",
    0x004920: "FastCopy20",
    0x004922: "FastCopy16",
    0x004998: "WaitForVBlank",
    0x0049AA: "SetDisplayParams",
    0x0036DE: "clear_buffer",
    0x0037B6: "memory_copy",

    # Sound (from modules/68k/sound/)
    0x00D1D4: "sound_init",             # FM chip initialization
    0x0014BE: "fm_write",               # FM register write
    0x0015EA: "sound_dma_setup",        # Sound DMA setup
    0x00155E: "sound_dma_transfer",     # Sound DMA transfer

    # Game Initialization (from analysis/GAME_LOGIC_INITIALIZATION.md)
    0x006200: "game_logic_entry",       # Main entry with jump table
    0x00625A: "init_state_0",           # Minimal init + main loop
    0x006292: "init_state_1",           # Full system initialization
    0x00633A: "init_state_2",           # Partial initialization
    0x006394: "init_state_3",           # Alternate partial init
    0x00640E: "init_state_4",           # Display mode initialization
    0x006496: "init_state_5",           # Alternate display mode
    0x0065BC: "init_state_6",           # Extended initialization

    # Timers/Display (from analysis/GAME_LOGIC_TIMERS_DISPLAY.md)
    0x008200: "state_mgmt_entry",       # State management entry
    0x00825C: "time_compare_display",   # Time comparison display
    0x00839A: "num_to_decimal",         # Number to decimal conversion
    0x0082FA: "result_comparison",      # Race result comparison
    0x008548: "timer_countdown",        # 8 independent game timers

    # AI/Physics (from analysis/GAME_LOGIC_AI_PHYSICS.md)
    0x00A200: "physics_lookup_tables",  # Speed/acceleration tables
    0x00A350: "effect_timer_mgmt",      # Effect timers management
    0x00A3BA: "speed_calculation",      # Table-based speed lookup
    0x00A434: "ai_opponent_select",     # AI opponent targeting
    0x00A470: "collision_avoidance",    # Steering/braking adjustments
    0x00A666: "physics_integration",    # 3D position calculations

    # Master Sequencer (from analysis/GAME_LOGIC_SEQUENCER.md)
    0x00C200: "master_sequencer",         # Scene flow controller
    0x002080: "pre_dispatch_common",      # Common pre-dispatch function

    # Menu System (from analysis/GAME_LOGIC_GRAPHICS_MENUS.md)
    0x00E90C: "track_select_menu",        # Track selection dispatcher
    0x00F41C: "options_menu",             # Options/difficulty menu
    0x01012E: "results_screen",           # Results/statistics screen
    0x01014E: "attract_mode",             # Replay/attract mode
    0x00E466: "text_render",              # Text/digit rendering
    0x00EA0E: "menu_input_handler",       # Menu navigation input

    # Name Entry (from analysis/GAME_LOGIC_NAME_ENTRY.md)
    0x011122: "name_entry_main",          # Name entry dispatcher
    0x011144: "name_entry_alt",           # Alternate entry mode
    0x01116C: "name_entry_sub",           # Sub-state handler
    0x012062: "name_confirm",             # Name confirmation
    0x010838: "name_input_handler",       # Grid navigation input

    # Race Start & Camera (from analysis/GAME_LOGIC_REMAINING_MODULES.md)
    0x012200: "race_camera_module",       # Camera system entry
    0x012260: "sh2_wait_ready",           # Wait for SH2 COMM ready
    0x01231C: "camera_scroll_update",     # Update camera scroll position
    0x012A40: "race_camera_dispatcher",   # Camera state machine

    # Frequently called utilities (from code analysis)
    0x0070AA: "angle_to_sine",            # Trig table lookup, 29 calls
    0x0080CC: "load_object_params",       # Object table lookup, 27 calls
    0x00247C: "unpack_tiles_vdp",         # Nibble expand to VDP, 24 calls
    0x008170: "object_frame_timer",       # Frame countdown handler, 22 calls
    0x00E3B4: "sh2_cmd_27",               # SH2 command $27 submit, 21 calls
    0x006F98: "calc_steering",            # Steering/velocity calc, 19 calls
    0x00179E: "poll_controllers",         # Controller read + mode check, 12 calls
    0x007F50: "obj_velocity_x",           # X velocity update, 18 calls
    0x007E7A: "obj_velocity_y",           # Y velocity update, 18 calls
    0x007CD8: "obj_position_x",           # X position update, 18 calls
    0x007C4E: "obj_position_y",           # Y position update, 18 calls
    0x00E22C: "sh2_graphics_cmd",         # Graphics command to SH2, 14 calls
    0x00E2F0: "sh2_load_data",            # Data load via SH2, 10 calls
    0x00E2E4: "sh2_copy_routine",         # SH2 memory copy, 7 calls

    # Game logic (frequent callers)
    0x009802: "game_update",
    0x00B684: "object_update",
    0x009B54: "physics_calc",
    0x00B6DA: "sprite_update",
    0x009182: "input_process",
    0x00961E: "state_machine",
    0x009B12: "movement_calc",
    0x009312: "timer_update",
    0x00E52C: "dma_transfer",
    0x009CCE: "math_routine",
    0x0059EC: "table_lookup",
    0x0094FA: "sound_trigger",
    0x00764E: "render_prep",
    0x00714A: "transform_calc",
    0x00B09E: "animation_update",

    # Additional utilities (from code analysis)
    0x00B770: "select_sprite_buffer",     # Sprite buffer select, 11 calls
    0x003F86: "clear_display_vars",       # Clear viewport params, 11 calls
    0x007F04: "obj_bounds_check",         # Object boundary check, 11 calls
    0x007816: "obj_collision_test",       # Object collision test, 11 calls
    0x0075FE: "obj_distance_calc",        # Distance calculation, 11 calls
    0x00E1BC: "sh2_palette_load",         # Load palette via SH2, 9 calls
    0x00C870: "scene_transition",         # Scene state transition, 5 calls

    # FM Sound chip functions ($030xxx range)
    0x030CD8: "fm_write_port0",           # FM chip register write, 9 calls
    0x030CBA: "fm_write_wrapper",         # FM write with bus release, 8 calls
    0x030CA2: "fm_conditional_write",     # Conditional FM write, 7 calls
    0x030C8A: "fm_init_channel",          # FM channel init, 5 calls
    0x030FB2: "fm_set_volume",            # FM volume control, 5 calls

    # Coordinate/position calculations
    0x0071A6: "obj_screen_coord",         # Object screen position, 9 calls
    0x0073E8: "tile_position_calc",       # Tile buffer position, 9 calls
    0x00734E: "alt_screen_coord",         # Alternate coord (SH2), 7 calls
    0x00748C: "angle_normalize",          # Angle normalization, 8 calls
    0x0074A4: "sprite_list_process",      # Sprite list iterator, 6 calls

    # Jump table dispatchers
    0x008F52: "state_dispatch_vdp",       # VDP state dispatcher, 9 calls
    0x008F4E: "state_dispatch_prep",      # State dispatch setup, 9 calls

    # Misc high-call functions
    0x0020C6: "sound_flag_handler",       # Sound flag handling, 5 calls
    0x007624: "obj_angle_calc",           # Object angle calculation, 7 calls
    0x007534: "velocity_apply",           # Velocity application, 6 calls
    0x00A1FC: "race_state_read",          # Race state from $C8CA, 10 calls
    0x00AC3E: "effect_countdown",         # Effect timer at $C8AE, 11 calls
    0x00A8F8: "obj_state_return",         # Object state return, 5 calls

    # Z80/FM bus control
    0x030D1C: "z80_bus_request",          # Z80 bus request + wait, 13 calls
    0x030CCC: "fm_write_conditional",     # Conditional FM register write, 13 calls

    # Object system
    0x007AB6: "obj_heading_update",       # Object heading/angle init, 10 calls
    0x009E6E: "obj_proximity_check",      # Object proximity comparison, 10 calls
    0x0021CA: "sfx_queue_process",        # Sound effect queue handler, 9 calls

    # Additional high-call functions
    0x003126: "vdp_reg_write",            # VDP register write, 9 calls
    0x003160: "vdp_dma_setup",            # VDP DMA setup, 7 calls
    0x002984: "palette_update",           # Palette color update, 7 calls
    0x0086C8: "state_jump_indexed",       # Indexed state jump, 9 calls
    0x009688: "timer_process",            # Game timer processing, 9 calls

    # More frequently called
    0x00ACD4: "ai_target_check",          # AI opponent targeting, 9 calls
    0x009EC0: "state_jump_table",         # State dispatcher via $C8AC, 7 calls
    0x00496E: "random_number_gen",        # PRNG using $EF00.W, 6 calls
    0x003CC4: "player_table_load",        # Load player pointers, 6 calls
    0x0058C8: "sprite_input_check",       # Sprite/input validation, 6 calls
    0x005908: "sprite_update_check",      # Sprite update conditional, 6 calls
    0x00593C: "sprite_state_process",     # Sprite state processing, 6 calls
    0x00789C: "obj_frame_calc",           # Object frame calculation, 6 calls
    0x0086FE: "state_dispatch_alt",       # Alternate state dispatch, 6 calls
    0x00B77C: "sprite_buffer_alt",        # Alt sprite buffer, 6 calls
    0x00A7A0: "ai_steering_calc",         # AI steering calculation, 6 calls
    0x0145F0: "menu_state_check",         # Menu state check, 6 calls

    # Final batch - remaining 5+ call functions
    0x009040: "view_offset_calc",         # Camera/view offset calc, 7 calls
    0x009064: "view_bounds_check",        # Camera bounds checking, 6 calls
    0x0031A6: "display_mode_dispatch",    # Display mode dispatcher, 6 calls
    0x007084: "obj_position_update",      # Update object positions, 5 calls
    0x008032: "race_position_check",      # Race position delta check, 5 calls
    0x00A144: "game_state_handler",       # Game state handler, 5 calls
    0x011A98: "name_entry_check",         # Name entry state check, 5 calls
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
