#!/usr/bin/env python3
"""
FPS Counter Injector for Virtua Racing Deluxe (68K Side)

Based on our analysis of the game structure:
- V-INT handler at $00881684 (ROM offset $1684)
- Frame counter at $C964 (already incremented every V-INT)
- State machine via $C87A

This tool hooks the V-INT to:
1. Calculate FPS every 60 frames using existing counter at $C964
2. Store FPS value at a known RAM location for monitoring
3. Optionally render directly to 32X frame buffer for on-screen display

IMPORTANT: VRD uses the 32X VDP exclusively - the Genesis VDP is behind
the 32X overlay and not visible. We must write directly to the 32X frame
buffer at $840000 for the display to be visible.

Usage:
    python3 inject_fps_68k.py <input.32x> <output.32x> [--display]
"""

import sys
import struct
from pathlib import Path

# Memory addresses from analysis
FRAME_COUNTER = 0xC964      # Existing frame counter (long)
VBLANK_FLAG = 0xC87A        # V-blank state flag (word)

# V-INT handler location
VINT_HANDLER_ROM = 0x1684   # ROM offset
VINT_HANDLER_CPU = 0x881684 # CPU address

# We'll store FPS data at end of work RAM (safe area)
FPS_CURRENT = 0xFFFE00      # Current FPS value (word)
FPS_LAST_COUNT = 0xFFFE04   # Last second's frame count (long)
FPS_COUNTDOWN = 0xFFFE08    # Frames until next update (word)

# 32X Hardware addresses (from 32X Hardware Manual MAR-32-R4-072294)
MARS_ADAPTER_CTRL = 0xA15100  # Adapter Control Register
                              # Bit 7: FM (VDP Access Authorization) - 0=MD, 1=SH2
                              # Bit 1: REN/RES (SH2 Reset)
                              # Bit 0: ADEN (Adapter Enable)
MARS_VDP_FBCTL = 0xA1518A     # Frame Buffer Control (VBLK bit 15, FEN bit 1, FS bit 0)
FRAME_BUFFER_BASE = 0x840000  # 32X frame buffer base (68K address when FM=0)

# IMPORTANT: FM bit is at $A15100 bit 7, NOT $A1518B bit 0!
# IMPORTANT: Cannot write 0x00 using byte access to frame buffer - use word writes!

# 32X Frame Buffer Layout (Packed Pixel Mode - 8bpp):
# - First 512 bytes: Line Table (256 words, one per scanline)
# - Each line table entry points to the pixel data for that line
# - Pixel data: 320 bytes per line (one byte per pixel, palette index)
#
# For simple display, we write at a fixed offset in the frame buffer
# Line table starts at $840000, pixel data typically starts at $840200
FPS_LINE_TABLE_OFFSET = 0       # Line table at start of frame buffer
FPS_DISPLAY_LINE = 16           # Display on line 16 (below sky, more visible)
FPS_DISPLAY_X = 8               # Left side of screen (easier to spot)

# FPS display RAM flag (to track if initialized)
FPS_INITIALIZED = 0xFFFE0C     # Byte: 0 = not init, $FF = initialized

# Palette indices for FPS display (will use existing game palette)
# VRD's palette: index 0x00 = transparent, low indices typically have UI colors
# Try index 0x01 which is very often white or a bright color in most games
FPS_COLOR_BG = 0x00             # Background (transparent/black)
FPS_COLOR_FG = 0x01             # Foreground (palette index 1 - usually white)


def create_digit_font_8bpp() -> bytes:
    """
    Create a minimal 8x8 pixel font for digits 0-9.
    32X Packed Pixel Mode: 8bpp = 1 byte per pixel.
    8x8 = 64 bytes per digit, 10 digits = 640 bytes total.
    """
    # Simple blocky digit patterns (1 = pixel on, 0 = off)
    patterns = {
        0: [
            "01111110",
            "11000011",
            "11000011",
            "11000011",
            "11000011",
            "11000011",
            "11000011",
            "01111110",
        ],
        1: [
            "00011000",
            "00111000",
            "00011000",
            "00011000",
            "00011000",
            "00011000",
            "00011000",
            "01111110",
        ],
        2: [
            "01111110",
            "11000011",
            "00000011",
            "00001110",
            "00111000",
            "01100000",
            "11000000",
            "11111111",
        ],
        3: [
            "01111110",
            "11000011",
            "00000011",
            "00111110",
            "00000011",
            "00000011",
            "11000011",
            "01111110",
        ],
        4: [
            "00001110",
            "00011110",
            "00110110",
            "01100110",
            "11000110",
            "11111111",
            "00000110",
            "00000110",
        ],
        5: [
            "11111111",
            "11000000",
            "11000000",
            "11111110",
            "00000011",
            "00000011",
            "11000011",
            "01111110",
        ],
        6: [
            "00111110",
            "01100000",
            "11000000",
            "11111110",
            "11000011",
            "11000011",
            "11000011",
            "01111110",
        ],
        7: [
            "11111111",
            "00000011",
            "00000110",
            "00001100",
            "00011000",
            "00110000",
            "00110000",
            "00110000",
        ],
        8: [
            "01111110",
            "11000011",
            "11000011",
            "01111110",
            "11000011",
            "11000011",
            "11000011",
            "01111110",
        ],
        9: [
            "01111110",
            "11000011",
            "11000011",
            "11000011",
            "01111111",
            "00000011",
            "00000110",
            "01111100",
        ],
    }

    font_data = bytearray()

    for digit in range(10):
        pattern = patterns[digit]
        for row in pattern:
            # 8bpp: 1 byte per pixel
            for px in range(8):
                color = FPS_COLOR_FG if row[px] == '1' else FPS_COLOR_BG
                font_data.append(color)

    return bytes(font_data)


def find_free_space(rom_data: bytearray, min_size: int = 256, near_addr: int = None) -> int | None:
    """Find free space (0xFF bytes) in ROM for our code."""
    # If near_addr specified, search within BRA.W range first
    if near_addr is not None:
        # BRA.W range is +/- 32KB
        start_range = max(0x400, near_addr - 0x7F00)
        end_range = min(len(rom_data) - min_size, near_addr + 0x7F00)
        for start in range(start_range, end_range, 4):
            if all(b == 0xFF for b in rom_data[start:start + min_size]):
                return start

    # Search in safe areas (after main code, before graphics data)
    for start in range(0x20000, len(rom_data) - min_size, 4):
        if all(b == 0xFF for b in rom_data[start:start + min_size]):
            return start
    return None


def create_fps_hook_code(code_addr: int, return_addr: int) -> bytes:
    """
    Create 68K assembly code for FPS calculation.

    This code:
    1. Increments frame counter (original behavior)
    2. Decrements countdown, on zero: calculate FPS
    3. Jumps back to original V-INT handler continuation

    Args:
        code_addr: CPU address where this code will be placed
        return_addr: CPU address to return to after our code
    """
    code = bytearray()

    # Helper functions
    def add_word(val):
        code.extend(struct.pack('>H', val))

    def add_long(val):
        code.extend(struct.pack('>I', val))

    # ============================================================
    # FPS Hook Code (68000 Assembly)
    # ============================================================

    # Original V-INT code we're replacing:
    #   008816A2  52B8 C964   ADDQ.L  #1,($C964).W  ; Increment frame counter
    # We preserve this functionality and add FPS calculation

    # --- Preserve original behavior: increment frame counter ---
    # ADDQ.L #1,($C964).W
    add_word(0x52B8)  # ADDQ.L #1,xxx.W
    add_word(FRAME_COUNTER & 0xFFFF)

    # --- FPS Calculation ---
    # Save D0/D1 (we need them for calculation)
    # MOVEM.L D0-D1,-(SP)
    add_word(0x48E7)
    add_word(0xC000)  # D0-D1 mask

    # Decrement countdown
    # SUBQ.W #1,($FPS_COUNTDOWN).L
    add_word(0x5378)  # SUBQ.W #1,xxx.W
    add_word(FPS_COUNTDOWN & 0xFFFF)

    # BNE.S skip_update (if not zero, skip FPS update)
    skip_branch_pos = len(code)
    add_word(0x6600)  # BNE.W offset (placeholder)
    add_word(0x0000)  # offset placeholder

    # --- FPS Update (countdown reached zero) ---

    # Load current frame count
    # MOVE.L ($C964).W,D0
    add_word(0x2038)
    add_word(FRAME_COUNTER & 0xFFFF)

    # Load last frame count
    # MOVE.L ($FPS_LAST_COUNT).L,D1
    add_word(0x2239)
    add_long(FPS_LAST_COUNT)

    # Calculate FPS = current - last
    # SUB.L D1,D0
    add_word(0x9081)

    # Store FPS value
    # MOVE.W D0,($FPS_CURRENT).L
    add_word(0x33C0)
    add_long(FPS_CURRENT)

    # Update last count = current
    # MOVE.L ($C964).W,($FPS_LAST_COUNT).L
    add_word(0x23F8)
    add_word(FRAME_COUNTER & 0xFFFF)
    add_long(FPS_LAST_COUNT)

    # Reset countdown to 60
    # MOVE.W #60,($FPS_COUNTDOWN).L
    add_word(0x33FC)
    add_word(60)
    add_long(FPS_COUNTDOWN)

    # --- Skip label ---
    skip_target = len(code)
    # Fix up the BNE.W branch offset
    branch_offset = skip_target - (skip_branch_pos + 4)
    code[skip_branch_pos + 2] = (branch_offset >> 8) & 0xFF
    code[skip_branch_pos + 3] = branch_offset & 0xFF

    # Restore D0/D1
    # MOVEM.L (SP)+,D0-D1
    add_word(0x4CDF)
    add_word(0x0003)  # D0-D1 mask (reversed for restore)

    # Jump back to original V-INT handler
    # JMP return_addr
    add_word(0x4EF9)
    add_long(return_addr)

    return bytes(code)


def create_fps_wrapper_code(code_addr: int, original_handler: int, with_display: bool = False, font_rom_addr: int = 0) -> bytes:
    """
    Create 68K code that wraps the original V-INT handler.

    This code:
    1. Saves registers
    2. Does FPS calculation
    3. Optionally renders FPS to BOTH 32X frame buffers (double-buffered)
    4. Restores registers
    5. JMP to original handler (which ends with RTE)

    Args:
        code_addr: CPU address where this code will be placed
        original_handler: CPU address of original V-INT handler ($881684)
        with_display: If True, include 32X frame buffer rendering code
        font_rom_addr: CPU address of font data (only used if with_display)
    """
    code = bytearray()

    def add_word(val):
        code.extend(struct.pack('>H', val))

    def add_long(val):
        code.extend(struct.pack('>I', val))

    # ============================================================
    # FPS Wrapper - runs BEFORE original handler
    # We draw to BOTH frame buffers to handle double-buffering
    # ============================================================

    # Save registers: MOVEM.L D0-D7/A0-A3,-(SP)
    add_word(0x48E7)
    add_word(0xFF30)  # D0-D7, A0-A3

    # Decrement countdown: SUBQ.W #1,($FPS_COUNTDOWN).L
    add_word(0x5379)
    add_long(FPS_COUNTDOWN)

    # BGT.W skip_update (branch if countdown > 0)
    skip_branch_pos = len(code)
    add_word(0x6E00)  # BGT.W (placeholder)
    add_word(0x0000)

    # --- FPS Update ---
    # Load current frame count: MOVE.L ($C964).W,D0
    add_word(0x2038)
    add_word(FRAME_COUNTER & 0xFFFF)

    # Load last count: MOVE.L ($FPS_LAST_COUNT).L,D1
    add_word(0x2239)
    add_long(FPS_LAST_COUNT)

    # SUB.L D1,D0: FPS = current - last
    add_word(0x9081)

    # Store FPS: MOVE.W D0,($FPS_CURRENT).L
    add_word(0x33C0)
    add_long(FPS_CURRENT)

    # Update last count: MOVE.L ($C964).W,($FPS_LAST_COUNT).L
    add_word(0x23F8)
    add_word(FRAME_COUNTER & 0xFFFF)
    add_long(FPS_LAST_COUNT)

    # Reset countdown: MOVE.W #60,($FPS_COUNTDOWN).L
    add_word(0x33FC)
    add_word(60)
    add_long(FPS_COUNTDOWN)

    # --- Skip label ---
    skip_target = len(code)
    branch_offset = skip_target - (skip_branch_pos + 4)
    code[skip_branch_pos + 2] = (branch_offset >> 8) & 0xFF
    code[skip_branch_pos + 3] = branch_offset & 0xFF

    if with_display:
        # ============================================================
        # 32X Frame Buffer Display Code - SIMPLIFIED
        # ============================================================
        # Write directly to BOTH frame buffers to handle double-buffering.
        # Use direct pixel addresses (bypass line table for simplicity).
        #
        # Standard Packed Pixel layout:
        # - Line table: $840000 / $860000 (256 words = 512 bytes)
        # - Pixel data: $840200 / $860200
        # - Line N address = base + $200 + (N * 320)
        #
        # We write to line 10 (near top) for visibility.
        # X position 8 (left side of screen).

        DISPLAY_LINE = 10
        DISPLAY_X = 8
        LINE_WIDTH = 320
        # Pixel offset = $200 (after line table) + line*320 + x
        PIXEL_OFFSET_0 = 0x200 + (DISPLAY_LINE * LINE_WIDTH) + DISPLAY_X
        PIXEL_OFFSET_1 = 0x200 + (DISPLAY_LINE * LINE_WIDTH) + DISPLAY_X

        # --- Clear FM bit for 68K frame buffer access ---
        # FM bit is at $A15100, bit 7 (not $A1518B bit 0!)
        # BCLR.B #7,$A15100
        add_word(0x08B9)  # BCLR.B immediate absolute long
        add_word(0x0007)  # bit 7
        add_long(MARS_ADAPTER_CTRL)

        # --- Load FPS value ---
        # MOVE.W ($FPS_CURRENT).L,D0
        add_word(0x3039)
        add_long(FPS_CURRENT)

        # Clamp to 99 max
        # CMP.W #99,D0
        add_word(0x0C40)
        add_word(99)
        # BLS.S no_clamp (+4 to skip next instruction)
        add_word(0x6304)  # BLS.B +4
        # MOVE.W #99,D0
        add_word(0x303C)
        add_word(99)

        # --- Convert to BCD: D1 = tens, D2 = ones ---
        # DIVU #10,D0 -> D0.W = quotient (tens), D0 high word = remainder (ones)
        add_word(0x80FC)
        add_word(10)
        # MOVE.W D0,D1 (tens digit)
        add_word(0x3200)
        # SWAP D0
        add_word(0x4840)
        # MOVE.W D0,D2 (ones digit)
        add_word(0x3400)

        # --- Calculate font pointers ---
        # D3 = tens font offset = D1 * 64
        # D4 = ones font offset = D2 * 64
        # MOVE.W D1,D3
        add_word(0x3601)
        # LSL.W #6,D3
        add_word(0xED4B)
        # MOVE.W D2,D4
        add_word(0x3802)
        # LSL.W #6,D4
        add_word(0xED4C)

        # A2 = font data base in ROM
        # LEA font_rom_addr,A2
        add_word(0x45F9)
        add_long(font_rom_addr)

        # --- Draw to BOTH frame buffers ---
        # D5 = buffer counter (0 = buffer 0, 1 = buffer 1)
        # MOVEQ #0,D5
        add_word(0x7A00)

        buffer_loop_pos = len(code)

        # Calculate frame buffer base: $840000 for D5=0, $860000 for D5=1
        # A0 = $840000 + D5 * $20000
        # MOVE.L #$840000,A0
        add_word(0x207C)
        add_long(0x840000)
        # TST.W D5
        add_word(0x4A45)
        # BEQ.S skip_add_offset (+6 to skip ADDA.L which is 6 bytes)
        add_word(0x6706)
        # ADDA.L #$20000,A0
        add_word(0xD1FC)
        add_long(0x20000)

        # skip_add_offset: A0 now points to correct frame buffer base

        # --- Draw 8 rows of digits ---
        # D6 = row counter (0-7)
        # MOVEQ #0,D6
        add_word(0x7C00)

        row_loop_pos = len(code)

        # Calculate pixel address for this row
        # A1 = A0 + PIXEL_OFFSET + (D6 * LINE_WIDTH)
        # MOVE.L A0,A1
        add_word(0x2248)
        # ADD.L #PIXEL_OFFSET,A1
        add_word(0xD3FC)
        add_long(PIXEL_OFFSET_0)
        # MOVE.W D6,D7
        add_word(0x3E06)
        # MULU #320,D7 (D7 = D6 * 320)
        add_word(0xCEFC)
        add_word(LINE_WIDTH)
        # ADD.L D7,A1
        add_word(0xD3C7)

        # A3 = tens digit row: A2 + D3 + (D6 * 8)
        # MOVE.L A2,A3
        add_word(0x264A)
        # ADD.W D3,A3
        add_word(0xD6C3)
        # MOVE.W D6,D7
        add_word(0x3E06)
        # LSL.W #3,D7
        add_word(0xE74F)
        # ADD.W D7,A3
        add_word(0xD6C7)

        # Copy 8 bytes for tens digit (one row)
        # MOVE.L (A3)+,(A1)+
        add_word(0x22DB)
        # MOVE.L (A3)+,(A1)+
        add_word(0x22DB)

        # A3 = ones digit row: A2 + D4 + (D6 * 8)
        # MOVE.L A2,A3
        add_word(0x264A)
        # ADD.W D4,A3
        add_word(0xD6C4)
        # MOVE.W D6,D7
        add_word(0x3E06)
        # LSL.W #3,D7
        add_word(0xE74F)
        # ADD.W D7,A3
        add_word(0xD6C7)

        # Copy 8 bytes for ones digit
        # MOVE.L (A3)+,(A1)+
        add_word(0x22DB)
        # MOVE.L (A3)+,(A1)+
        add_word(0x22DB)

        # Increment row counter
        # ADDQ.W #1,D6
        add_word(0x5246)
        # CMP.W #8,D6
        add_word(0x0C46)
        add_word(8)
        # BLT.S row_loop
        row_bra_back = row_loop_pos - (len(code) + 2)
        add_word(0x6D00 | (row_bra_back & 0xFF))

        # Increment buffer counter
        # ADDQ.W #1,D5
        add_word(0x5245)
        # CMP.W #2,D5
        add_word(0x0C45)
        add_word(2)
        # BLT.S buffer_loop
        buf_bra_back = buffer_loop_pos - (len(code) + 2)
        add_word(0x6D00 | (buf_bra_back & 0xFF))

        # --- Restore FM bit for SH2 access ---
        # FM bit is at $A15100, bit 7
        # BSET.B #7,$A15100
        add_word(0x08F9)  # BSET.B immediate absolute long
        add_word(0x0007)  # bit 7
        add_long(MARS_ADAPTER_CTRL)

    # Restore registers: MOVEM.L (SP)+,D0-D7/A0-A3
    add_word(0x4CDF)
    add_word(0x0CFF)  # D0-D7, A0-A3 (reversed)

    # Jump to original handler: JMP original_handler
    add_word(0x4EF9)
    add_long(original_handler)

    return bytes(code)


# Font loader is not needed for 32X frame buffer approach
# We read font data directly from ROM when rendering


def inject_fps_counter(input_rom: str, output_rom: str, with_display: bool = False) -> bool:
    """
    Inject FPS counter into VRD ROM.

    Strategy (Vector Modification):
    1. Find free space in ROM
    2. Write FPS wrapper code there (with optional 32X frame buffer display)
    3. If with_display: also inject 8bpp font data
    4. Modify V-INT vector to point to our code
    5. Our code does FPS calc, optionally renders to 32X frame buffer, then
       jumps to original handler
    """

    print("=" * 70)
    print("FPS Counter Injector (68K) - Virtua Racing Deluxe")
    print("=" * 70)
    print()

    # Load ROM
    rom_path = Path(input_rom)
    if not rom_path.exists():
        print(f"ERROR: ROM not found: {input_rom}")
        return False

    rom_data = bytearray(rom_path.read_bytes())
    print(f"ROM loaded: {len(rom_data):,} bytes")

    # Verify this is VRD by checking header
    if rom_data[0x120:0x126] != b'V.R.DX':
        print("WARNING: This doesn't appear to be Virtua Racing Deluxe")

    # Read current V-INT vector (offset 0x78 = vector 30 * 4)
    VINT_VECTOR_OFFSET = 0x78
    original_handler = struct.unpack('>I', rom_data[VINT_VECTOR_OFFSET:VINT_VECTOR_OFFSET+4])[0]
    print(f"Original V-INT vector: ${original_handler:08X}")

    if original_handler != 0x00881684:
        print(f"WARNING: Expected V-INT at $00881684, got ${original_handler:08X}")

    # Calculate space needed
    if with_display:
        # Need space for: font data (640 bytes for 10 digits × 64 bytes) + wrapper (~250)
        space_needed = 1024
    else:
        space_needed = 128

    # Find free space for our code
    free_space = find_free_space(rom_data, space_needed)
    if free_space is None:
        print("ERROR: No free space found in ROM")
        return False

    print(f"Free space at ROM 0x{free_space:05X} ({space_needed} bytes needed)")

    current_offset = free_space
    font_cpu_addr = 0  # Will be set if with_display

    if with_display:
        # --- Inject 8bpp font data ---
        font_data = create_digit_font_8bpp()
        font_rom_offset = current_offset
        font_cpu_addr = font_rom_offset + 0x880000
        rom_data[font_rom_offset:font_rom_offset + len(font_data)] = font_data
        print(f"Injected 8bpp font data at ROM 0x{font_rom_offset:05X} ({len(font_data)} bytes)")
        current_offset += len(font_data)

        # Align to word boundary
        if current_offset % 2:
            current_offset += 1

    # --- Generate wrapper code ---
    wrapper_offset = current_offset
    wrapper_cpu_addr = wrapper_offset + 0x880000
    fps_code = create_fps_wrapper_code(
        wrapper_cpu_addr, original_handler,
        with_display=with_display, font_rom_addr=font_cpu_addr
    )
    rom_data[wrapper_offset:wrapper_offset + len(fps_code)] = fps_code
    print(f"Injected FPS wrapper at ROM 0x{wrapper_offset:05X} ({len(fps_code)} bytes)")

    # V-INT vector points to wrapper
    new_vector = wrapper_cpu_addr

    # Modify V-INT vector to point to our code
    rom_data[VINT_VECTOR_OFFSET:VINT_VECTOR_OFFSET+4] = struct.pack('>I', new_vector)
    print(f"Modified V-INT vector: ${original_handler:08X} -> ${new_vector:08X}")

    # Write output ROM
    output_path = Path(output_rom)
    output_path.write_bytes(rom_data)
    print(f"\nOutput written: {output_rom}")

    # Summary
    print()
    print("=" * 70)
    if with_display:
        print("FPS COUNTER WITH 32X FRAME BUFFER DISPLAY INSTALLED")
    else:
        print("FPS COUNTER INSTALLED (NO DISPLAY)")
    print("=" * 70)

    if with_display:
        print(f"""
Memory locations:
  Frame counter:    $C964 (existing, long)
  FPS value:        ${FPS_CURRENT:06X} (new, word)
  Last count:       ${FPS_LAST_COUNT:06X} (new, long)
  Countdown:        ${FPS_COUNTDOWN:06X} (new, word)

32X Frame Buffer Display:
  Target:           32X frame buffer at $840000 (Packed Pixel Mode)
  Font data:        ROM ${font_cpu_addr:08X} (8bpp, 640 bytes)
  Display line:     {FPS_DISPLAY_LINE} (near top of screen)
  X position:       {FPS_DISPLAY_X} pixels from left (right side)
  Format:           2-digit FPS (00-99), 8x8 pixel digits

IMPORTANT:
  - Display writes directly to 32X frame buffer
  - Requires FM bit = 0 (68K access mode)
  - Draws full 8x8 pixel digits (16 pixels wide total)

To test:
  1. Load the ROM in a 32X emulator (PicoDrive recommended)
  2. FPS should appear as a line of pixels at top-right of screen
  3. Updates every second
""")
    else:
        print(f"""
Memory locations:
  Frame counter:    $C964 (existing, long)
  FPS value:        ${FPS_CURRENT:06X} (new, word)
  Last count:       ${FPS_LAST_COUNT:06X} (new, long)
  Countdown:        ${FPS_COUNTDOWN:06X} (new, word)

To verify in emulator:
  1. Load the ROM in a 32X emulator (PicoDrive, Kega Fusion, etc.)
  2. Open memory viewer
  3. Watch address ${FPS_CURRENT:06X} - should show ~60 (NTSC) or ~50 (PAL)
  4. Value updates every second

Note: FPS value is stored but NOT displayed on screen.
      Use emulator's memory viewer to see the value.
""")

    return True


def main():
    if len(sys.argv) < 3:
        print("Usage: python3 inject_fps_68k.py <input.32x> <output.32x> [--display]")
        print()
        print("Injects FPS counter based on our VRD analysis:")
        print("  - Hooks V-INT handler at $881684")
        print("  - Uses existing frame counter at $C964")
        print("  - Stores FPS at $FFFE00 (work RAM)")
        print()
        print("Options:")
        print("  --display    Show FPS on screen via 32X frame buffer")
        print()
        print("Note: VRD uses 32X VDP exclusively (Genesis VDP is behind overlay).")
        print("      Display mode writes directly to 32X frame buffer at $840000.")
        sys.exit(1)

    input_rom = sys.argv[1]
    output_rom = sys.argv[2]
    with_display = '--display' in sys.argv

    success = inject_fps_counter(input_rom, output_rom, with_display=with_display)
    sys.exit(0 if success else 1)


if __name__ == '__main__':
    main()
