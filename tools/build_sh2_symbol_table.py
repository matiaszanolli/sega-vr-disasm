#!/usr/bin/env python3
"""
Build a global symbol table for SH2 functions from analysis.
Maps addresses to meaningful function names.
"""

import re
from pathlib import Path

DISASM_DIR = Path(__file__).parent.parent / "disasm"

# SH2 function names from detailed analysis
# Address format: 0x02XXXXXX (SH2 SDRAM addresses)
SH2_KNOWN_FUNCTIONS = {
    # =========================================================================
    # 3D Engine Core (from sh2_3d_engine_annotated.asm)
    # =========================================================================

    # Display List Processing (func_000 - func_010)
    0x0222300A: "data_init_stride_loop",     # func_000 - Copies 12 blocks with stride
    0x0222301C: "display_list_processor",    # func_001 - Hub: command loop, parses display list
    0x02223066: "render_init",               # func_002 - Calls func_003, func_004
    0x022230CC: "clear_render_state",        # func_003 - Leaf: clear rendering context
    0x022230DC: "load_render_params",        # func_004 - Leaf: load parameters
    0x022230E6: "matrix_transform_loop",     # func_005 - Hub: batch vertex transform via R14
    0x02223114: "matrix_vector_multiply",    # func_006 - Leaf: MAC.L intensive matrix*vec
    0x02223176: "alt_transform_loop",        # func_007 - Hub: alternative transform via R14
    0x022231A2: "transform_handler",         # func_008 - Leaf: coordinate transform
    0x022231E4: "command_handler_09",        # func_009 - Leaf: display list command handler
    0x02223202: "command_handler_10",        # func_010 - Leaf: display list command handler

    # Transform and Projection (func_011 - func_022)
    0x0222321C: "transform_wrapper",         # func_011 - Calls func_012
    0x02223268: "transform_dispatch",        # func_012 - Calls func_008, func_009
    0x022232C4: "projection_calc",           # func_013 - Leaf: projection calculation
    0x02223308: "depth_calc",                # func_014 - Leaf: depth/Z calculation
    0x02223340: "screen_coord_convert",      # func_015 - Leaf: screen coordinate conversion
    0x02223368: "coord_transform_util",      # func_016 - Leaf HOTSPOT: coord combine utility
    0x02223388: "coord_transform_single",    # func_017 - Calls func_016
    0x022233A2: "coord_transform_pair",      # func_018 - Calls func_016, func_020
    0x0222340C: "coord_transform_triple",    # func_019 - Calls func_016, func_020
    0x02223468: "recursive_tree_traverse",   # func_020 - Recursive: tree/list traversal
    0x022234C0: "transform_with_cull",       # func_021 - Calls func_016, func_023
    0x022234EC: "simple_transform",          # func_022 - Leaf: simple transformation

    # Frustum Culling and Rendering Dispatch (func_023 - func_038)
    0x02223500: "frustum_cull_dispatch",     # func_023 - Hub HOTSPOT: visibility/rendering
    0x022235F4: "render_param_setup",        # func_024 - Leaf: rendering parameter setup
    0x02223632: "param_helper",              # func_025 - Leaf: parameter helper
    0x02223642: "coord_boundary_clamp",      # func_026 - Leaf: coordinate clamping
    0x0222367A: "conditional_value_assign",  # func_027 - Leaf: boundary comparison
    0x02223682: "register_copy",             # func_028 - Leaf: R0 -> R2 copy
    0x02223686: "region_code_generate",      # func_029 - Leaf: quadrant/region code
    0x022236CA: "conditional_param_assign",  # func_030 - Leaf: conditional R11 set
    0x022236D4: "register_copy_v2",          # func_031 - Leaf: R0 -> R2 variant
    0x022236D8: "scanline_fill_loop",        # func_032 - Leaf: quad rendering loop
    0x022236F8: "polygon_scanline_gen",      # func_033 - Calls func_034: scanline generator
    0x0222375C: "bresenham_rasterize",       # func_034 - Leaf: line rasterization
    0x022237A8: "render_param_fetch",        # func_035 - Parameter fetch from stream
    0x022237D2: "conditional_block_proc",    # func_036 - Hub: bounds/value validation
    0x0222381C: "bounds_validate",           # func_037 - Leaf: bounds validation
    0x02223834: "zero_value_check",          # func_038 - Leaf: early return on zero

    # Data Copy and Memory Operations (func_040 - func_067)
    0x0222385C: "memory_fill_init",          # func_040 - Memory fill setup
    0x022238D6: "block_fill_loop",           # func_041 - Block fill iteration
    0x0222395C: "memory_copy_setup",         # func_042 - Copy setup
    0x022239AA: "recursive_gbr_copy",        # func_043 - Recursive: GBR data copy
    0x022239CA: "multi_level_dispatch",      # func_044 - Recursive hub: multi-path
    0x02223B3C: "stream_decode_loop",        # func_046 - Stream decoding
    0x02223BC2: "command_process",           # func_047 - Command processing
    0x02223BEC: "param_extract",             # func_048 - Parameter extraction
    0x02223C42: "utility_049",               # func_049 - Utility (unclear)
    0x02223C4C: "data_fetch_loop",           # func_050 - Data fetch iteration
    0x02223C60: "index_lookup",              # func_051 - Index table lookup
    0x02223CA2: "utility_052",               # func_052 - Utility (unclear)
    0x02223CAE: "byte_store_op",             # func_053 - Byte store: R0 -> @R1
    0x02223CB2: "word_store_op",             # func_054 - Word store operation
    0x02223CDA: "long_store_op",             # func_055 - Long store operation
    0x02223D1A: "ptr_advance",               # func_056 - Pointer advancement
    0x02223D3C: "size_calc",                 # func_057 - Size calculation
    0x02223D52: "offset_calc",               # func_058 - Offset calculation
    0x02223DC4: "multi_block_copy_orch",     # func_060 - Hub: orchestrates 10+ copy calls
    0x02223E32: "dual_block_copy",           # func_061 - Hub: 2-block data copy
    0x02223E5C: "conditional_dual_copy",     # func_062 - Hub: conditional 2-block copy
    0x02223E88: "triple_block_copy",         # func_063 - Hub: 3-block with flag tracking
    0x02223EC6: "inline_unrolled_copy",      # func_064 - Leaf: inline unrolled copy
    0x02223F2C: "unrolled_data_copy",        # func_065 - Leaf HOTSPOT: 75 instructions
    0x02223FC4: "block_copy_32",             # func_066 - Leaf: 32-byte block copy
    0x02223FF2: "block_copy_48",             # func_067 - Leaf: 48-byte block copy
    0x02224000: "block_copy_64",             # Data/frame copy operations

    # Polygon Rendering (func_078 - func_079)
    0x02224320: "polygon_dispatch_6way",     # func_078 - Hub: 6× JSR @R0 indirect
    0x02224366: "polygon_dispatch_variant",  # func_079 - Hub: 6× indirect variant
    0x02223E1C: "polygon_type_select",       # Polygon type selection
    0x02223E5E: "tri_render_flat",           # Leaf: flat-shaded triangle
    0x02223EA0: "tri_render_gouraud",        # Leaf: gouraud triangle
    0x02223F00: "quad_render_flat",          # Leaf: flat-shaded quad

    # Lookup Tables and Data (func_094 - func_100)
    0x02224598: "recursive_list_proc",       # func_094 - Recursive: list processing
    0x02224692: "sincos_lookup_table",       # func_100 - Data: 1112 bytes sine/cosine

    # High-Level Dispatchers (func_101 - func_106)
    0x02224AEC: "register_save_wrapper",     # func_101 - Hub: full reg save + indirect
    0x02224C7E: "stream_state_machine",      # func_105 - Hub: state machine loop
    0x02224D16: "multipath_render_dispatch", # func_106 - Hub: multi-mode polygon

    # =========================================================================
    # Frame Buffer Operations
    # =========================================================================
    0x02224100: "framebuffer_clear",         # Clear framebuffer region
    0x02224150: "framebuffer_flip",          # Flip front/back buffers
    0x022241A0: "palette_transfer",          # Copy palette to VDP

    # =========================================================================
    # SH2 Master Synchronization (from sh2_master_sync.asm)
    # =========================================================================
    0x020203D8: "master_sync_entry",         # Entry point for sync
    0x02020400: "comm_wait_68k",             # Wait for 68K COMM ready
    0x02020450: "comm_send_response",        # Send response to 68K
    0x020204A0: "frame_sync_wait",           # Wait for frame boundary

    # =========================================================================
    # Hot Functions from Call Graph Analysis (ROM-relative addresses)
    # =========================================================================
    0x022B58: "hot_transform_core",          # 36 calls - most called function
    0x021B2C: "hot_math_routine",            # 19 calls
    0x0203D8: "hot_sync_check",              # 18 calls - sync checking
    0x023F2E: "hot_copy_loop",               # 17 calls - memory copy loop
    0x0221C6: "hot_render_helper",           # 13 calls
    0x021FAC: "hot_coord_calc",              # 11 calls
    0x022206: "hot_vertex_proc",             # 11 calls
    0x022B4A: "hot_transform_prep",          # 11 calls
    0x022248: "hot_matrix_calc",             # 10 calls
    0x023ED0: "hot_data_fetch",              # 10 calls

    # Additional Frequently Called
    0x021FE6: "vertex_transform",            # 8 calls
    0x0234A0: "texture_lookup",              # 8 calls
    0x020AD8: "init_registers",              # 7 calls
    0x021B1C: "vector_normalize",            # 7 calls
    0x022514: "shade_calculate",             # 7 calls
    0x022006: "depth_compare",               # 6 calls
    0x021B04: "dot_product",                 # 5 calls
    0x0231AC: "lighting_calc",               # 5 calls
    0x021F3A: "clip_to_screen",              # 4 calls
    0x02218A: "face_normal_calc",            # 4 calls

    # =========================================================================
    # Slave Engine Functions (from sh2_slave_engine.asm)
    # =========================================================================
    0x22000400: "slave_main_loop",           # Slave main processing loop
    0x22001000: "slave_process_polygons",    # Polygon batch processor
    0x22001100: "parse_polygon_bounds",      # Polygon bounds parser
}


def build_sh2_symbol_table():
    """Build the SH2 symbol table."""
    symbols = dict(SH2_KNOWN_FUNCTIONS)
    return symbols


def generate_sh2_inc_file(symbols, output_path):
    """Generate assembly include file with EQU definitions."""
    with open(output_path, 'w') as f:
        f.write("; ============================================================================\n")
        f.write("; SH2 Global Symbol Table - Auto-generated\n")
        f.write("; ============================================================================\n\n")

        for addr in sorted(symbols.keys()):
            name = symbols[addr]
            f.write(f"{name:<32} EQU ${addr:08X}\n")

        f.write(f"\n; Total symbols: {len(symbols)}\n")


def generate_sh2_symbol_map(symbols, output_path):
    """Generate markdown symbol map."""
    with open(output_path, 'w') as f:
        f.write("# SH2 Global Symbol Map\n\n")
        f.write("| Address | Symbol | Description |\n")
        f.write("|---------|--------|-------------|\n")

        for addr in sorted(symbols.keys()):
            name = symbols[addr]
            # Extract description from comment if available
            f.write(f"| ${addr:08X} | {name} | |\n")

        f.write(f"\n**Total symbols:** {len(symbols)}\n")


def main():
    print("Building SH2 symbol table...")

    symbols = build_sh2_symbol_table()
    print(f"Found {len(symbols)} SH2 function symbols")

    # Generate output files
    inc_path = DISASM_DIR / "sh2_symbols.inc"
    generate_sh2_inc_file(symbols, inc_path)
    print(f"Generated: {inc_path}")

    map_path = DISASM_DIR / "SH2_SYMBOL_MAP.md"
    generate_sh2_symbol_map(symbols, map_path)
    print(f"Generated: {map_path}")


if __name__ == "__main__":
    main()
