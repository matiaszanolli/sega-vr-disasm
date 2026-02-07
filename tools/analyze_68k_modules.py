#!/usr/bin/env python3
"""
analyze_68k_modules.py - Automated analysis and documentation of fn_* 68K modules.

Reads each fn_* module's assembly code, detects patterns (RAM addresses, register
usage, instruction signatures), assigns categories, suggests descriptive names,
and generates documentation headers.

Usage:
    python3 tools/analyze_68k_modules.py [--dry-run] [--module PATTERN] [-v] [--report-only]
"""

import argparse
import glob
import os
import re
import sys
from collections import defaultdict
from pathlib import Path

# ===========================================================================
# Known RAM addresses and their meanings (from DATA_STRUCTURES.md, STATE_MACHINES.md)
# ===========================================================================

# Map of RAM addresses -> (variable_name, category)
# Using the short-absolute form (negative values for $FF8000+)
# These are the addresses as they appear in the 68K address space ($FFxxxx)
RAM_ADDRESSES = {
    # State machine variables ($FFC0xx range)
    0xFFC048: ('camera_state', 'display'),
    0xFFC050: ('scroll_state', 'display'),
    0xFFC07C: ('input_state', 'input'),
    0xFFC082: ('menu_state', 'game'),
    0xFFC084: ('menu_substate', 'game'),
    0xFFC0A2: ('gfx_mode', 'graphics'),
    0xFFC0FA: ('timer_state', 'util'),

    # Game state variables ($FFC8xx range)
    0xFFC80E: ('ram_status', 'game'),
    0xFFC87A: ('vint_dispatch_state', 'vint'),
    0xFFC87E: ('game_state', 'game'),
    0xFFC89C: ('sh2_comm_state', 'sh2'),
    0xFFC89E: ('sh2_comm_sub', 'sh2'),
    0xFFC8A0: ('race_state', 'game'),
    0xFFC8AA: ('scene_state', 'game'),
    0xFFC8AC: ('state_dispatch_idx', 'game'),
    0xFFC8AE: ('effect_timer', 'game'),
    0xFFC8C8: ('vint_state', 'vint'),
    0xFFC8CA: ('race_substate_read', 'game'),
    0xFFC8CC: ('race_substate', 'game'),
    0xFFC964: ('frame_counter', 'main-loop'),
    0xFFC972: ('anim_state', 'graphics'),

    # Display state ($FF6xxx)
    0xFF6950: ('obj_flags', 'object'),
    0xFF6960: ('display_state_flag', 'display'),
    0xFF68F0: ('status_code', 'display'),
    0xFF68F8: ('time_display_buf', 'display'),
    0xFF6970: ('race_mode_flag', 'game'),

    # Object tables ($FF9xxx)
    0xFF9100: ('obj_table_1', 'object'),
    0xFF9700: ('obj_table_2', 'object'),
    0xFF9F00: ('obj_table_3', 'object'),
}

# 32X system registers (68K-side addresses)
SYSTEM_REGISTERS = {
    0xA15100: ('adapter_ctrl', 'sh2'),
    0xA15102: ('int_ctrl', 'sh2'),
    0xA15104: ('bank_set', 'sh2'),
    0xA15106: ('dreq_ctrl', 'sh2'),
    0xA15120: ('COMM0', 'sh2'),
    0xA15122: ('COMM1', 'sh2'),
    0xA15124: ('COMM2', 'sh2'),
    0xA15126: ('COMM3', 'sh2'),
    0xA15128: ('COMM4', 'sh2'),
    0xA1512A: ('COMM5', 'sh2'),
    0xA1512C: ('COMM6', 'sh2'),
    0xA1512E: ('COMM7', 'sh2'),
}

# Known function addresses -> names (from 68K_FUNCTION_REFERENCE.md)
KNOWN_FUNCTIONS = {
    0x000200: 'entry_point',
    0x000838: 'adapter_init',
    0x000C5A: 'save_all_registers',
    0x000D68: 'warm_boot_init',
    0x000DC4: 'sound_update_check',
    0x000FEA: 'z80_bus_vdp_init',
    0x0010C4: 'vdp_copy_rows',
    0x0010F4: 'tile_decompress_init',
    0x0013B4: 'bit_unpack_loop',
    0x0014BE: 'fm_write',
    0x00155E: 'sound_dma_transfer',
    0x0015EA: 'sound_dma_setup',
    0x001684: 'vint_handler',
    0x00170C: 'controller_port_init',
    0x00179E: 'poll_controllers',
    0x0017EE: 'button_remap',
    0x00185E: 'zbus_request',
    0x0018D8: 'io_port_init',
    0x001A64: 'vint_state_transition',
    0x001C66: 'vint_state_fb_toggle',
    0x00203A: 'sh2_frame_sync',
    0x002080: 'pre_dispatch_common',
    0x0020C6: 'sound_flag_handler',
    0x0021CA: 'sfx_queue_process',
    0x00247C: 'unpack_tiles_vdp',
    0x0024AE: 'tile_index_expand',
    0x0027DA: 'sh2_framebuffer_prep',
    0x0027F8: 'VDPFill',
    0x00281E: 'VDPPrep',
    0x002878: 'PaletteRAMCopy',
    0x0028C2: 'VDPSyncSH2',
    0x002890: 'sh2_comm_sync',
    0x002984: 'palette_update',
    0x002C9A: 'obj_render_check',
    0x002CDC: 'obj_transform_copy',
    0x002DCA: 'obj_texture_select',
    0x002E9E: 'obj_palette_select',
    0x002EC6: 'obj_visibility_check',
    0x002F04: 'obj_position_copy',
    0x003010: 'obj_render_flags_set',
    0x003126: 'vdp_reg_write',
    0x003160: 'vdp_dma_setup',
    0x0031A6: 'display_mode_dispatch',
    0x0036DE: 'clear_buffer',
    0x0037B6: 'memory_copy',
    0x0039EC: 'collision_distance_calc',
    0x003CC4: 'player_table_load',
    0x003C7E: 'player_table_setup',
    0x003F86: 'clear_display_vars',
    0x004836: 'QuadMemoryFill',
    0x004920: 'FastCopy20',
    0x004922: 'FastCopy16',
    0x00496E: 'random_number_gen',
    0x004998: 'WaitForVBlank',
    0x0049AA: 'SetDisplayParams',
    0x0049EE: 'reset_scroll_vars',
    0x0058C8: 'sprite_input_check',
    0x005908: 'sprite_update_check',
    0x00593C: 'sprite_state_process',
    0x0059EC: 'table_lookup',
    0x006200: 'game_logic_entry',
    0x006C46: 'sprite_table_init',
    0x006F98: 'calc_steering',
    0x006FDE: 'position_update_sub',
    0x0070AA: 'angle_to_sine',
    0x007084: 'obj_position_update',
    0x0071A6: 'obj_screen_coord',
    0x00734E: 'alt_screen_coord',
    0x0073E8: 'tile_position_calc',
    0x00748C: 'angle_normalize',
    0x0074A4: 'sprite_list_process',
    0x0075C8: 'vector_dot_product',
    0x0075FE: 'obj_distance_calc',
    0x007534: 'velocity_apply',
    0x007624: 'obj_angle_calc',
    0x007816: 'obj_collision_test',
    0x00789C: 'obj_frame_calc',
    0x007A40: 'obj_type_dispatch',
    0x007AB6: 'obj_heading_update',
    0x007C4E: 'obj_position_y',
    0x007CD8: 'obj_position_x',
    0x007E7A: 'obj_velocity_y',
    0x007EA4: 'player_target_verify',
    0x007F04: 'obj_bounds_check',
    0x007F50: 'obj_velocity_x',
    0x0080CC: 'load_object_params',
    0x008032: 'race_position_check',
    0x008170: 'object_frame_timer',
    0x008200: 'state_mgmt_entry',
    0x00825C: 'time_compare_display',
    0x0082FA: 'result_comparison',
    0x00839A: 'num_to_decimal',
    0x008548: 'timer_countdown',
    0x0086C8: 'state_jump_indexed',
    0x0086FE: 'state_dispatch_alt',
    0x008F4E: 'cosine_lookup',
    0x008F52: 'sine_lookup',
    0x009040: 'view_offset_calc',
    0x009064: 'view_bounds_check',
    0x009182: 'input_process',
    0x009312: 'timer_update',
    0x00961E: 'state_machine',
    0x009688: 'timer_process',
    0x009802: 'game_update',
    0x009B12: 'movement_calc',
    0x009B54: 'physics_calc',
    0x009CCE: 'math_routine',
    0x009E6E: 'obj_proximity_check',
    0x009EC0: 'state_jump_table',
    0x00A144: 'game_state_handler',
    0x00A1FC: 'race_state_read',
    0x00A200: 'physics_lookup_tables',
    0x00A350: 'effect_timer_mgmt',
    0x00A3BA: 'speed_calculation',
    0x00A434: 'ai_opponent_select',
    0x00A470: 'collision_avoidance',
    0x00A666: 'physics_integration',
    0x00A7A0: 'ai_steering_calc',
    0x00A8F8: 'obj_state_return',
    0x00AC3E: 'effect_countdown',
    0x00ACC0: 'race_mode_flag_set',
    0x00ACD4: 'ai_target_check',
    0x00B09E: 'animation_update',
    0x00B684: 'object_update',
    0x00B6DA: 'sprite_update',
    0x00B770: 'select_sprite_buffer',
    0x00B77C: 'sprite_buffer_alt',
    0x00C200: 'master_sequencer',
    0x00C662: 'scene_state_dispatch',
    0x00C870: 'scene_transition',
    0x00CC06: 'object_array_init',
    0x00D1D4: 'sound_init',
    0x00E1BC: 'sh2_palette_load',
    0x00E22C: 'sh2_graphics_cmd',
    0x00E2E4: 'sh2_copy_routine',
    0x00E2F0: 'sh2_load_data',
    0x00E316: 'sh2_send_cmd_wait',
    0x00E342: 'sh2_wait_response',
    0x00E35A: 'sh2_send_cmd',
    0x00E3B4: 'sh2_cmd_27',
    0x00E406: 'sh2_cmd_2F',
    0x00E466: 'text_render',
    0x00E52C: 'dma_transfer',
    0x00E90C: 'track_select_menu',
    0x00EA0E: 'menu_input_handler',
    0x00F41C: 'options_menu',
    0x01012E: 'results_screen',
    0x01014E: 'attract_mode',
    0x010838: 'name_input_handler',
    0x011122: 'name_entry_main',
    0x0118D4: 'time_digit_render',
    0x011942: 'name_digit_render',
    0x011A98: 'name_entry_check',
    0x012062: 'name_confirm',
    0x012200: 'race_camera_module',
    0x01231C: 'camera_scroll_update',
    0x012260: 'sh2_wait_ready',
    0x012A40: 'race_camera_dispatcher',
    0x0145F0: 'menu_state_check',
    0x0302EE: 'fm_sequence_process',
    0x030C8A: 'fm_init_channel',
    0x030CA2: 'fm_conditional_write',
    0x030CBA: 'fm_write_wrapper',
    0x030CCC: 'fm_write_conditional',
    0x030CD8: 'fm_write_port0',
    0x030D1C: 'z80_bus_request',
    0x030DF4: 'z80_dac_write',
    0x030FB2: 'fm_set_volume',
}

# Section address ranges -> high-level categories
SECTION_CATEGORIES = {
    '200':   'boot',       # $000200-$001FFF
    '2200':  'vint',       # $002200-$003FFF (V-INT, VDP, display)
    '4200':  'game',       # $004200-$005FFF
    '6200':  'game',       # $006200-$007FFF (game init, objects)
    '8200':  'game',       # $008200-$009FFF (state mgmt, game logic)
    'a200':  'game',       # $00A200-$00BFFF (AI, physics)
    'c200':  'game',       # $00C200-$00DFFF (master sequencer)
    'e200':  'sh2',        # $00E200-$00FFFF (SH2 comm, menus)
    '10200': 'game',       # $010200-$011FFF (name entry, results)
    '12200': 'game',       # $012200-$013FFF (race, camera)
    '14200': 'game',       # $014200-$015FFF
    '30200': 'sound',      # $030200-$031FFF (FM sound)
}

# Object structure offsets -> field names (from analysis)
OBJECT_OFFSETS = {
    0x02: 'flags/type',
    0x04: 'speed_index/velocity',
    0x06: 'speed',
    0x0A: 'param_a',
    0x0E: 'param_e',
    0x12: 'timer_12',
    0x14: 'effect_duration',
    0x16: 'calc_speed',
    0x1A: 'direction',
    0x30: 'x_position',
    0x34: 'y_position',
    0x3C: 'heading_mirror',
    0x40: 'heading_angle',
    0x44: 'display_offset',
    0x46: 'display_scale',
    0x54: 'steering_flags',
    0x7A: 'param_7a',
    0x8A: 'param_8a',
    0x8C: 'velocity_x',
    0x8E: 'velocity_y',
    0x90: 'acceleration',
    0x92: 'param_92',
    0xAE: 'obj_index',
    0xB0: 'frame_timer',
    0xB8: 'anim_counter',
    0xBC: 'scroll_offset',
    0xC0: 'render_flags',
}


# ===========================================================================
# Analysis engine
# ===========================================================================

class ModuleAnalyzer:
    """Analyzes a single fn_* module and produces documentation."""

    def __init__(self, filepath, verbose=False):
        self.filepath = filepath
        self.verbose = verbose
        self.filename = os.path.basename(filepath)
        self.lines = []
        self.code_lines = []   # Lines with actual instructions
        self.rom_start = 0
        self.rom_end = 0
        self.rom_size = 0
        self.func_name = ''
        self.section = ''

        # Analysis results
        self.ram_accesses = {}       # addr -> access_type ('read'/'write'/'rw')
        self.sys_reg_accesses = {}   # addr -> access_type
        self.obj_offsets = set()     # object structure offsets used
        self.obj_registers = set()   # which A-registers used as object pointers
        self.regs_read = set()       # D/A registers read before write
        self.regs_written = set()    # D/A registers written
        self.call_targets = {}       # address -> name (JSR/BSR targets)
        self.branch_external = []    # external branch targets
        self.has_rts = False
        self.has_jmp = False
        self.dcw_count = 0
        self.mnemonic_count = 0
        self.is_data = False
        self.category = 'game'       # default
        self.confidence = 'low'
        self.suggested_name = ''
        self.purpose = ''
        self.vdp_access = False
        self.controller_access = False
        self.uses_jump_table = False

    def analyze(self):
        """Run full analysis on the module."""
        self._parse_file()
        self._parse_instructions()
        self._detect_data_module()
        self._categorize()
        self._suggest_name()
        self._generate_purpose()

    def _parse_file(self):
        """Parse the module file to extract metadata and code lines."""
        with open(self.filepath, 'r') as f:
            self.lines = f.readlines()

        # Extract ROM range
        for line in self.lines:
            m = re.match(r';\s*ROM Range:\s*\$([0-9A-Fa-f]+)-\$([0-9A-Fa-f]+)\s*\((\d+)\s*bytes\)', line)
            if m:
                self.rom_start = int(m.group(1), 16)
                self.rom_end = int(m.group(2), 16)
                self.rom_size = int(m.group(3))
                break

        # Extract function name and section
        for line in self.lines:
            m = re.match(r'(fn_\w+):', line)
            if m:
                self.func_name = m.group(1)
                # Extract section from name: fn_SECTION_NNN
                parts = self.func_name.split('_')
                if len(parts) >= 3:
                    self.section = parts[1]
                break

        # Collect code lines (non-comment, non-empty, non-label-only)
        for line in self.lines:
            stripped = line.strip()
            if not stripped or stripped.startswith(';') or stripped.startswith('='):
                continue
            if re.match(r'^[\w.]+:\s*$', stripped):  # label-only line
                continue
            if stripped.startswith('DC.W') or stripped.startswith('dc.w'):
                self.code_lines.append(stripped)
                self.dcw_count += 1
            elif re.match(r'^[A-Z]', stripped) or re.match(r'^\.\w+', stripped):
                # Label line with instruction or instruction line
                # Extract just the instruction part
                parts = stripped.split(None, 1)
                if parts and re.match(r'^\.?\w+:', parts[0]):
                    if len(parts) > 1:
                        self.code_lines.append(parts[1].strip())
                        if not parts[1].strip().upper().startswith('DC.W'):
                            self.mnemonic_count += 1
                        else:
                            self.dcw_count += 1
                else:
                    self.code_lines.append(stripped)
                    if not stripped.upper().startswith('DC.W'):
                        self.mnemonic_count += 1
                    else:
                        self.dcw_count += 1

    def _parse_instructions(self):
        """Analyze individual instructions for patterns."""
        for line in self.lines:
            stripped = line.strip()
            if not stripped or stripped.startswith(';') or stripped.startswith('='):
                continue

            upper = stripped.upper()

            # Check for RTS/RTE
            if 'RTS' in upper and not upper.startswith(';'):
                self.has_rts = True
            if re.search(r'\bJMP\b', upper):
                self.has_jmp = True

            # Detect RAM address accesses (negative short absolute form)
            # Pattern: (-NNNNN).W or ($FFxxxx)
            for m in re.finditer(r'\((-\d+)\)\.W', stripped):
                neg_val = int(m.group(1))
                addr = 0x10000 + neg_val  # Convert to 16-bit unsigned
                addr = addr + 0xFF0000    # Map to 68K RAM space
                self._record_ram_access(addr, stripped)

            # Also check for explicit hex RAM addresses
            for m in re.finditer(r'\$00FF([0-9A-Fa-f]{4})', stripped):
                addr = 0xFF0000 + int(m.group(1), 16)
                self._record_ram_access(addr, stripped)

            for m in re.finditer(r'\$FFF([0-9A-Fa-f]{4})', stripped, re.IGNORECASE):
                addr = 0xFFF0000 + int(m.group(1), 16)
                # This is probably wrong, skip
                pass

            # Check for $A15xxx system register accesses
            for m in re.finditer(r'\$(?:00)?A15([0-9A-Fa-f]{2,3})', stripped, re.IGNORECASE):
                addr = 0xA15000 + int(m.group(1), 16)
                if addr in SYSTEM_REGISTERS:
                    self.sys_reg_accesses[addr] = SYSTEM_REGISTERS[addr]

            # Check for VDP register accesses ($C00000-$C0001F)
            if re.search(r'\$(?:00)?C000[0-9A-Fa-f]{2}', stripped, re.IGNORECASE):
                self.vdp_access = True

            # Check for controller port accesses ($A10003)
            if re.search(r'\$(?:00)?A1000[0-9A-Fa-f]', stripped, re.IGNORECASE):
                self.controller_access = True

            # Check for frame buffer accesses ($84xxxx)
            if re.search(r'\$(?:00)?8[4-7][0-9A-Fa-f]{4}', stripped, re.IGNORECASE):
                self.vdp_access = True

            # Detect object structure accesses (A0+$XX or A5+$XX patterns)
            for m in re.finditer(r'\$([0-9A-Fa-f]{2,4})\(A([0-6])\)', stripped):
                offset = int(m.group(1), 16)
                areg = int(m.group(2))
                if offset <= 0x100:  # Reasonable object offset
                    self.obj_offsets.add(offset)
                    self.obj_registers.add(f'A{areg}')

            # Also detect indexed forms: $XX(A0,D0.W)
            for m in re.finditer(r'\$([0-9A-Fa-f]{2,4})\(A([0-6]),', stripped):
                offset = int(m.group(1), 16)
                areg = int(m.group(2))
                if offset <= 0x100:
                    self.obj_offsets.add(offset)
                    self.obj_registers.add(f'A{areg}')

            # Detect JSR/BSR calls (from dc.w comments and proper mnemonics)
            # dc.w comment format: ; JSR $XXXXXX(PC)
            for m in re.finditer(r';\s*(?:JSR|BSR)\S*\s+\$([0-9A-Fa-f]+)', stripped):
                target = int(m.group(1), 16)
                name = KNOWN_FUNCTIONS.get(target, f'sub_{target:06X}')
                self.call_targets[target] = name

            # Proper mnemonic JSR/BSR with PC-relative labels
            for m in re.finditer(r'\b(?:JSR|BSR)\.\w\s+(\w+)', upper):
                label = m.group(1)
                # Internal labels start with .loc_
                if not label.startswith('.LOC_'):
                    # Try to match against known function names
                    pass

            # Detect jump table patterns
            if re.search(r'MOVEA\.L\s+.*\(PC,D\d\.W\),A\d', upper):
                self.uses_jump_table = True
            if re.search(r'JMP\s+.*\(PC,D\d\.W\)', upper):
                self.uses_jump_table = True
            # Also look for indexed addressing off PC
            if re.search(r'\(PC,D\d\.W\)', upper):
                self.uses_jump_table = True

            # Track register usage (simplified)
            for m in re.finditer(r'\b(D[0-7]|A[0-6])\b', upper):
                reg = m.group(1)
                self.regs_written.add(reg)

    def _record_ram_access(self, addr, line):
        """Record a RAM address access."""
        # Normalize to $FFxxxx range
        if addr >= 0xFF0000 and addr <= 0xFFFFFF:
            self.ram_accesses[addr] = RAM_ADDRESSES.get(addr, (f'ram_{addr:06X}', 'unknown'))

    def _detect_data_module(self):
        """Detect if this module is likely data, not code."""
        total = self.dcw_count + self.mnemonic_count
        if total == 0:
            self.is_data = True
            return

        # High dc.w ratio with no control flow = likely data
        dcw_ratio = self.dcw_count / total if total > 0 else 0
        if dcw_ratio > 0.8 and not self.has_rts and not self.has_jmp:
            self.is_data = True
        # Check for ASCII-looking data (fn_200_001 style)
        if self.rom_start < 0x600 and self.section == '200':
            # Boot section early bytes often contain header strings
            pass

    def _categorize(self):
        """Assign a category based on detected patterns."""
        if self.is_data:
            self.category = 'data'
            self.confidence = 'medium'
            return

        # Priority-ordered detection rules
        scores = defaultdict(float)

        # Rule 1: SH2 COMM register access -> sh2
        if self.sys_reg_accesses:
            scores['sh2'] += 3.0

        # Rule 2: VDP access -> vdp
        if self.vdp_access:
            scores['vdp'] += 2.5

        # Rule 3: Controller access -> input
        if self.controller_access:
            scores['input'] += 3.0

        # Rule 4: RAM address-based categorization
        for addr, (name, cat) in self.ram_accesses.items():
            if cat != 'unknown':
                scores[cat] += 1.5

        # Rule 5: Call target-based categorization
        for target, name in self.call_targets.items():
            if 'fm_' in name or 'z80_' in name or 'sound' in name:
                scores['sound'] += 2.0
            elif 'sh2_' in name:
                scores['sh2'] += 1.5
            elif 'vdp_' in name or 'VDP' in name or 'palette' in name:
                scores['vdp'] += 1.5
            elif 'obj_' in name or 'object' in name or 'sprite' in name:
                scores['object'] += 1.5
            elif 'sine' in name or 'cosine' in name or 'math' in name or 'angle' in name:
                scores['math'] += 1.5
            elif 'physics' in name or 'movement' in name or 'velocity' in name:
                scores['game'] += 1.0
            elif 'ai_' in name or 'steering' in name:
                scores['game'] += 1.0
            elif 'timer' in name:
                scores['game'] += 0.5
            elif 'state' in name or 'dispatch' in name:
                scores['game'] += 0.5
            elif 'memory' in name or 'clear' in name or 'copy' in name:
                scores['memory'] += 1.5
            elif 'dma' in name:
                scores['memory'] += 1.5

        # Rule 6: Object structure access patterns
        position_offsets = {0x30, 0x34}
        velocity_offsets = {0x8C, 0x8E, 0x90}
        heading_offsets = {0x3C, 0x40}
        if position_offsets & self.obj_offsets:
            scores['game'] += 1.0
        if velocity_offsets & self.obj_offsets:
            scores['game'] += 1.0
        if heading_offsets & self.obj_offsets:
            scores['game'] += 0.5

        # Rule 7: Section-based default
        section_cat = SECTION_CATEGORIES.get(self.section, 'game')
        scores[section_cat] += 0.5

        # Rule 8: Jump table -> dispatcher
        if self.uses_jump_table:
            scores['game'] += 0.5

        # Rule 9: Small leaf function
        if self.rom_size <= 12 and self.has_rts:
            scores['util'] += 0.5

        # Pick highest score
        if scores:
            self.category = max(scores, key=scores.get)
            max_score = scores[self.category]
            if max_score >= 3.0:
                self.confidence = 'high'
            elif max_score >= 1.5:
                self.confidence = 'medium'
            else:
                self.confidence = 'low'
        else:
            self.category = section_cat
            self.confidence = 'low'

    def _suggest_name(self):
        """Generate a suggested descriptive name."""
        num = self.func_name.split('_')[-1]  # e.g. '001'

        if self.is_data:
            self.suggested_name = f'data_{self.section}_{num}'
            return

        # Section-specific context for naming
        section_context = {
            '200':   'boot',
            '2200':  'vint',
            '4200':  'logic',
            '6200':  'obj',
            '8200':  'state',
            'a200':  'ai',
            'c200':  'scene',
            'e200':  'menu',
            '10200': 'name_entry',
            '12200': 'camera',
            '14200': 'util',
            '30200': 'fm',
        }

        # Use category as prefix
        cat_prefixes = {
            'sh2': 'sh2_comm',
            'vdp': 'vdp',
            'input': 'input',
            'sound': 'fm',
            'object': 'obj',
            'memory': 'mem',
            'display': 'display',
            'vint': 'vint',
            'math': 'math',
            'graphics': 'gfx',
            'boot': 'init',
            'main-loop': 'loop',
            'util': 'util',
            'game': section_context.get(self.section, 'game'),
        }
        prefix = cat_prefixes.get(self.category, 'game')

        # Try to generate a meaningful suffix based on patterns
        suffix = self._infer_purpose_suffix()

        if suffix:
            # Avoid redundancy (e.g., "name_entry_name_entry_check" -> "name_entry_check")
            if suffix.startswith(prefix):
                self.suggested_name = f'{suffix}_{num}'
            elif prefix in suffix:
                self.suggested_name = f'{suffix}_{num}'
            else:
                self.suggested_name = f'{prefix}_{suffix}_{num}'
        else:
            self.suggested_name = f'{prefix}_{num}'

    def _infer_purpose_suffix(self):
        """Try to infer what the function does from its patterns."""
        hints = []

        # Based on patterns (highest priority)
        if self.uses_jump_table:
            hints.append('dispatch')

        # Based on call targets (pick the most informative one)
        named_calls = [(addr, name) for addr, name in self.call_targets.items()
                       if not name.startswith('sub_')]
        if named_calls:
            for addr, name in sorted(named_calls):
                short = name
                for pfx in ['obj_', 'sh2_', 'vdp_', 'fm_']:
                    if short.startswith(pfx):
                        short = short[len(pfx):]
                        break
                if len(short) <= 20 and short not in hints:
                    hints.append(short)
                    break

        # Based on RAM accesses (pick the most specific)
        named_ram = [(addr, name) for addr, (name, cat) in self.ram_accesses.items()
                     if not name.startswith('ram_')]
        if named_ram:
            for addr, name in sorted(named_ram):
                short = name.replace('_state', '').replace('_flag', '')
                if short not in hints:
                    hints.append(short)
                    break

        # Based on object offsets (only for non-sound sections, since sound
        # uses A5/A6 for channel data with similar offsets)
        if self.section != '30200' and self.obj_offsets:
            has_position = bool({0x30, 0x34} & self.obj_offsets)
            has_velocity = bool({0x8C, 0x8E, 0x90} & self.obj_offsets)
            has_heading = bool({0x3C, 0x40} & self.obj_offsets)
            has_timer = 0xB0 in self.obj_offsets
            has_render = 0xC0 in self.obj_offsets

            obj_hint = None
            if has_position and has_velocity:
                obj_hint = 'physics'
            elif has_position and has_heading:
                obj_hint = 'movement'
            elif has_position:
                obj_hint = 'position'
            elif has_velocity:
                obj_hint = 'velocity'
            elif has_heading:
                obj_hint = 'heading'
            elif has_timer:
                obj_hint = 'timer'
            elif has_render:
                obj_hint = 'render'

            if obj_hint and not hints:
                hints.append(obj_hint)

        if not hints:
            return ''

        # Return only the first (most descriptive) hint
        return hints[0]

    def _generate_purpose(self):
        """Generate a purpose description string."""
        if self.is_data:
            self.purpose = f'Data table ({self.rom_size} bytes)'
            return

        parts = []

        # Describe based on category and patterns
        if self.uses_jump_table:
            parts.append('State dispatcher using jump table')
        elif len(self.call_targets) >= 3:
            parts.append(f'Orchestrator calling {len(self.call_targets)} subroutines')
        elif self.rom_size <= 12:
            parts.append('Small leaf function')
        elif self.rom_size <= 40:
            parts.append('Short helper function')

        # Add specific access info
        if self.sys_reg_accesses:
            regs = [v[0] for v in self.sys_reg_accesses.values()]
            parts.append(f'Accesses 32X registers: {", ".join(regs)}')

        if self.vdp_access:
            parts.append('Accesses VDP registers')

        if self.controller_access:
            parts.append('Reads controller input')

        # Named RAM accesses
        named_ram = [(addr, name) for addr, (name, cat) in self.ram_accesses.items()
                     if not name.startswith('ram_')]
        if named_ram:
            ram_strs = [f'${addr & 0xFFFF:04X} ({name})' for addr, name in named_ram[:4]]
            parts.append(f'RAM: {", ".join(ram_strs)}')

        # Call targets
        named_calls = [(addr, name) for addr, name in self.call_targets.items()
                       if not name.startswith('sub_')]
        if named_calls:
            call_strs = [name for _, name in named_calls[:4]]
            parts.append(f'Calls: {", ".join(call_strs)}')

        # Object access
        if self.obj_offsets:
            named_offsets = []
            for off in sorted(self.obj_offsets)[:6]:
                if off in OBJECT_OFFSETS:
                    named_offsets.append(f'+${off:02X} ({OBJECT_OFFSETS[off]})')
                else:
                    named_offsets.append(f'+${off:02X}')
            obj_regs = ', '.join(sorted(self.obj_registers))
            parts.append(f'Object ({obj_regs}): {", ".join(named_offsets)}')

        self.purpose = '. '.join(parts) if parts else f'Function in {self.section} section ({self.rom_size} bytes)'

    def generate_header(self):
        """Generate the documentation header block."""
        lines = []
        lines.append('; ============================================================================')

        # Title line
        display_name = self.suggested_name if self.suggested_name != self.func_name else self.func_name
        title = display_name.replace('_', ' ').title()
        lines.append(f'; {title} (auto-analyzed)')
        lines.append(f'; ROM Range: ${self.rom_start:06X}-${self.rom_end:06X} ({self.rom_size} bytes)')
        lines.append('; ============================================================================')

        # Category
        lines.append(f'; Category: {self.category}')

        # Purpose
        purpose_lines = self.purpose.split('. ')
        for i, pl in enumerate(purpose_lines):
            if i == 0:
                lines.append(f'; Purpose: {pl}')
            else:
                lines.append(f';   {pl}')
        lines.append(';')

        # Entry registers (object pointer info)
        if self.obj_registers:
            for reg in sorted(self.obj_registers):
                lines.append(f'; Entry: {reg} = object/entity pointer')

        # Registers used
        if self.regs_written:
            d_regs = sorted([r for r in self.regs_written if r.startswith('D')])
            a_regs = sorted([r for r in self.regs_written if r.startswith('A')])
            all_regs = d_regs + a_regs
            if all_regs:
                lines.append(f'; Uses: {", ".join(all_regs[:8])}')

        # RAM accesses
        named_ram = [(addr, name, cat) for addr, (name, cat) in self.ram_accesses.items()
                     if not name.startswith('ram_')]
        if named_ram:
            lines.append('; RAM:')
            for addr, name, cat in sorted(named_ram)[:6]:
                lines.append(f';   ${addr & 0xFFFF:04X}: {name}')

        # Call targets
        named_calls = [(addr, name) for addr, name in self.call_targets.items()
                       if not name.startswith('sub_')]
        if named_calls:
            lines.append('; Calls:')
            for addr, name in sorted(named_calls)[:6]:
                lines.append(f';   ${addr:06X}: {name}')

        # Object fields
        if self.obj_offsets:
            lines.append('; Object fields:')
            for off in sorted(self.obj_offsets)[:8]:
                if off in OBJECT_OFFSETS:
                    lines.append(f';   +${off:02X}: {OBJECT_OFFSETS[off]}')
                else:
                    lines.append(f';   +${off:02X}: [unknown]')

        # Confidence
        lines.append(f'; Confidence: {self.confidence}')
        lines.append('; ============================================================================')

        return '\n'.join(lines) + '\n'


# ===========================================================================
# Main script
# ===========================================================================

def find_fn_modules(module_dir, pattern=None):
    """Find all fn_* module files."""
    search = os.path.join(module_dir, 'fn_*.asm')
    files = sorted(glob.glob(search))

    if pattern:
        files = [f for f in files if pattern in os.path.basename(f)]

    return files


def apply_header(filepath, header_text):
    """Replace the existing header block in a module file with new header."""
    with open(filepath, 'r') as f:
        content = f.read()

    lines = content.split('\n')

    # Find the end of the existing header block
    # The header is from the first ; ==== line to the last ; ==== line before the function label
    header_start = -1
    header_end = -1
    func_label_line = -1

    for i, line in enumerate(lines):
        if line.strip().startswith('; ====') and header_start == -1:
            header_start = i
        if re.match(r'^fn_\w+:', line.strip()):
            func_label_line = i
            break

    if func_label_line == -1:
        return False

    # Find the last header line before the function label
    for i in range(func_label_line - 1, -1, -1):
        if lines[i].strip():
            header_end = i
            break

    if header_start == -1:
        header_start = 0

    # Reconstruct file: new header + empty line + function code
    new_lines = []
    new_lines.append(header_text.rstrip())
    new_lines.append('')
    new_lines.extend(lines[func_label_line:])

    new_content = '\n'.join(new_lines)

    # Ensure file ends with single newline
    new_content = new_content.rstrip('\n') + '\n'

    with open(filepath, 'w') as f:
        f.write(new_content)

    return True


def generate_report(results, output_path):
    """Generate the MODULE_ANALYSIS_REPORT.md."""
    # Count categories
    cat_counts = defaultdict(int)
    conf_counts = defaultdict(int)
    section_counts = defaultdict(lambda: defaultdict(int))

    for r in results:
        cat_counts[r['category']] += 1
        conf_counts[r['confidence']] += 1
        section_counts[r['section']][r['category']] += 1

    lines = []
    lines.append('# 68K Module Analysis Report')
    lines.append('')
    lines.append(f'**Generated**: Auto-analyzed {len(results)} fn_* modules')
    lines.append(f'**Tool**: tools/analyze_68k_modules.py')
    lines.append('')
    lines.append('---')
    lines.append('')

    # Category breakdown
    lines.append('## Category Breakdown')
    lines.append('')
    lines.append('| Category | Count | Percentage |')
    lines.append('|----------|-------|------------|')
    for cat, count in sorted(cat_counts.items(), key=lambda x: -x[1]):
        pct = count / len(results) * 100
        lines.append(f'| {cat} | {count} | {pct:.1f}% |')
    lines.append('')

    # Confidence breakdown
    lines.append('## Confidence Levels')
    lines.append('')
    lines.append('| Level | Count | Percentage |')
    lines.append('|-------|-------|------------|')
    for conf in ['high', 'medium', 'low']:
        count = conf_counts[conf]
        pct = count / len(results) * 100
        lines.append(f'| {conf} | {count} | {pct:.1f}% |')
    lines.append('')

    # Section breakdown
    lines.append('## By Section')
    lines.append('')
    for section in sorted(section_counts.keys()):
        cats = section_counts[section]
        total = sum(cats.values())
        lines.append(f'### Section {section} ({total} modules)')
        lines.append('')
        lines.append('| Category | Count |')
        lines.append('|----------|-------|')
        for cat, count in sorted(cats.items(), key=lambda x: -x[1]):
            lines.append(f'| {cat} | {count} |')
        lines.append('')

    # Full cross-reference table
    lines.append('## Full Module Reference')
    lines.append('')
    lines.append('| Module | Suggested Name | Category | Confidence | Size |')
    lines.append('|--------|---------------|----------|------------|------|')
    for r in sorted(results, key=lambda x: x['rom_start']):
        lines.append(f'| {r["filename"]} | {r["suggested_name"]} | {r["category"]} | {r["confidence"]} | {r["rom_size"]}B |')
    lines.append('')

    # Low confidence modules needing manual review
    low_conf = [r for r in results if r['confidence'] == 'low']
    if low_conf:
        lines.append('## Needs Manual Review (Low Confidence)')
        lines.append('')
        lines.append(f'{len(low_conf)} modules could not be confidently categorized:')
        lines.append('')
        for r in sorted(low_conf, key=lambda x: x['rom_start']):
            lines.append(f'- **{r["filename"]}** (${r["rom_start"]:06X}, {r["rom_size"]}B): {r["purpose"][:80]}')
        lines.append('')

    report = '\n'.join(lines)
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    with open(output_path, 'w') as f:
        f.write(report)

    return report


def main():
    parser = argparse.ArgumentParser(description='Analyze and document fn_* 68K modules')
    parser.add_argument('--dry-run', action='store_true',
                        help='Preview analysis without modifying files')
    parser.add_argument('--module', type=str, default=None,
                        help='Only process modules matching this pattern')
    parser.add_argument('-v', '--verbose', action='store_true',
                        help='Verbose output')
    parser.add_argument('--report-only', action='store_true',
                        help='Only generate report, do not modify files')
    args = parser.parse_args()

    # Find project root
    script_dir = os.path.dirname(os.path.abspath(__file__))
    project_root = os.path.dirname(script_dir)
    module_dir = os.path.join(project_root, 'disasm', 'modules', '68k', 'game')
    report_path = os.path.join(project_root, 'analysis', '68k-reverse-engineering',
                               'MODULE_ANALYSIS_REPORT.md')

    # Find modules
    files = find_fn_modules(module_dir, args.module)
    if not files:
        print('No fn_* modules found!')
        return 1

    print(f'Found {len(files)} fn_* modules to analyze')

    # Analyze all modules
    results = []
    cat_counts = defaultdict(int)
    conf_counts = defaultdict(int)
    modified = 0
    errors = 0

    for filepath in files:
        try:
            analyzer = ModuleAnalyzer(filepath, verbose=args.verbose)
            analyzer.analyze()

            result = {
                'filename': analyzer.filename,
                'func_name': analyzer.func_name,
                'section': analyzer.section,
                'rom_start': analyzer.rom_start,
                'rom_end': analyzer.rom_end,
                'rom_size': analyzer.rom_size,
                'category': analyzer.category,
                'confidence': analyzer.confidence,
                'suggested_name': analyzer.suggested_name,
                'purpose': analyzer.purpose,
                'is_data': analyzer.is_data,
                'dcw_count': analyzer.dcw_count,
                'mnemonic_count': analyzer.mnemonic_count,
                'call_targets': dict(analyzer.call_targets),
                'ram_accesses': {hex(k): v for k, v in analyzer.ram_accesses.items()},
                'obj_offsets': sorted(analyzer.obj_offsets),
            }
            results.append(result)
            cat_counts[analyzer.category] += 1
            conf_counts[analyzer.confidence] += 1

            if args.verbose:
                print(f'  {analyzer.filename}: {analyzer.category} ({analyzer.confidence}) -> {analyzer.suggested_name}')

            # Apply header to file
            if not args.dry_run and not args.report_only:
                header = analyzer.generate_header()
                if apply_header(filepath, header):
                    modified += 1
                else:
                    print(f'  WARNING: Could not apply header to {analyzer.filename}')
                    errors += 1

        except Exception as e:
            print(f'  ERROR analyzing {os.path.basename(filepath)}: {e}')
            errors += 1

    # Print summary
    print(f'\n=== Analysis Summary ===')
    print(f'Total modules analyzed: {len(results)}')
    print(f'\nCategories:')
    for cat, count in sorted(cat_counts.items(), key=lambda x: -x[1]):
        pct = count / len(results) * 100
        print(f'  {cat:15s}: {count:4d} ({pct:5.1f}%)')
    print(f'\nConfidence:')
    for conf in ['high', 'medium', 'low']:
        count = conf_counts[conf]
        pct = count / len(results) * 100
        print(f'  {conf:15s}: {count:4d} ({pct:5.1f}%)')

    if not args.dry_run and not args.report_only:
        print(f'\nFiles modified: {modified}')

    if errors:
        print(f'Errors: {errors}')

    # Generate report
    if not args.dry_run or args.report_only:
        generate_report(results, report_path)
        print(f'\nReport written to: {report_path}')

    return 0


if __name__ == '__main__':
    sys.exit(main())
