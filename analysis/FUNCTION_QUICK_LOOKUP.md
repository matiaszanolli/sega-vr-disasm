# Function Quick Lookup
**Virtua Racing Deluxe — LLM-Optimized Flat Reference**
**Total entries**: 799 | Sorted by ROM address

Format: `$ADDRESS  name  [category]  — description`

---

```
$000000  ROM Header and Exception Vector Table ($000000-$0001FF)  [Boot]
         Contains 68000 exception vectors and SEGA standard header.

$000512  vdp_reg_table_load                                [Game / Render]
         VDP Register Table Load Data prefix ($000512-$0005A5) contains the game's internal identification strings: "MAIN Course.
         in:A0 = VDP register value table (19 bytes) | mod:D0, D1, D7, A0, A1

$0005CE  vdp_vram_clear_via_dma                            [Game / Render]
         VDP VRAM Clear via DMA Clears VDP VRAM using DMA fill operations.
         in:D1 = initial DMA fill value | mod:D0, D1, D7, A0, A1

$00063E  framebuffer_auto_fill_clear                       [Game / Render]
         Framebuffer Auto-Fill Clear Data prefix ($00063E-$000653): VDP register values for DMA fill setup ($8114, $8F01, $93FF, $94FF, $9500, $9600, $9780,...
         in:Called from system_boot_init at $000654 (NOT at framebuffer_ | mod:D0, D1, D7, A1 Hardware: MARS_VDP_MODE (

$000694  gfx_32x_cram_fill                                 [Game / Render]
         32X CRAM Fill Fills all 256 entries (512 bytes) of 32X CRAM with the color value in D0.
         in:D0 = 32-bit color value to fill (typically 0 for black/clear | mod:D0, D7, A0 Hardware: MARS_CRAM ($A15200)

$0006BC  system_boot_init                                  [Game / State]
         System Boot Initialization Main system boot orchestrator.
         mod:D0, D1, D2, D3, D4, D5, D6, D7, A0, A1,  | calls:$000654: framebuffer_auto_fill_clear (BSR) $000694: cram_fil

$000838  32X Adapter Initialization ($000838-$000C59)      [Boot]
         Initializes the 32X adapter hardware after ROM entry point.
         in:Called from entry_point ($000200) via JMP $00880838 (after 3

$000C5A  register_restore_from_table                       [Game / State]
         Register Restore from Table Loads all 68K registers (D0-D7, A0-A6) from a PC-relative data table at $000C70 (the start of hardware_init, whose firs...
         in:None (standalone initialization helper) | mod:D0-D7, A0-A6

$000C70  hardware_init                                     [Game / State]
         Hardware Initialization Data prefix ($000C70-$000C7F): Register initialization values read by register_restore_from_table via MOVEM.
         in:Called from system_boot_init at $000C80 | mod:D0, D1, D7, A1 | calls:$0018D8: io_port_init (JSR PC-relative) $00170C: controller_

$000D68  System Initialization Orchestrator                [Game / Scene]
         Main system initialization routine.
         in:none | mod:D0, D1, D7, A1, A2 | calls:$000DB0 (RAM clear), $000FEA (z80_bus_vdp_init), $00170C (co

$000DC4  Double-Conditional Guard                          [Game / State]
         Returns ONLY if $EF05 is nonzero AND $EF06 is zero.
         in:none | Exit: returns or falls through | mod:none

$000DD2  vdp_display_init                                  [Game / Render]
         VDP Display Initialization VDP display initialization and main dispatch loop setup: 1.
         mod:D0, D1, D4, D6, D7, A0, A1, A5 | calls:$000FEA: z80_bus_vdp_init

$000FEA  VDP Register Initialization                       [Game / Render]
         Disables interrupts, requests Z80 bus, calls io_port_init ($0018D8), releases Z80 bus, restores SR.
         in:A5 = VDP control port | Exit: VDP initialized | mod:D0, D7, A0, A5

$001034  VDP DMA Transfer + VRAM Clear (10-Word Data Prefix)  [Game / Render]
         Data prefix: 10 words — VDP DMA config or padding.
         mod:D0, D1, D3, D4, D7, A5, A6 | calls:$0048A8: cram_handler $004888: vsram_handler

$0010C4  VDP Data Fill                                     [Vdp]
         2D block transfer from RAM to VDP data port.
         in:A0 = source data, A5 = VDP control port, A6 = VDP data port  | mod:D0, D1, D3, D4, A0

$0010DC  VDP Data Fill Constant                            [Vdp]
         Fills VDP region with a constant word value D3.
         in:A5 = VDP control port, A6 = VDP data port D0 = VDP address c | mod:D0, D1, D4, D5

$0010F4  tile_decompressor_setup                           [Game / Data]
         Tile Decompressor Setup Entry point for tile decompression.
         in:A0 = pointer to compressed tile data | mod:D0-D7, A0, A1, A3, A4, A5

$001140  huffman_lz_decompression_inner_loop               [Game / Data]
         Huffman/LZ Decompression Inner Loop Bit-level decoder for compressed data.
         in:A0 = compressed data stream pointer A1 = Huffman/lookup tabl | mod:D0, D1, D3, D4, D5, D6, D7, A0

$0011C2  tile_decompressor_inner_loop_a                    [Game / Data]
         Tile Decompressor Inner Loop A Decompression variant A: XOR-combine and store without post-increment.
         in:D2 = accumulated data, D4 = XOR mask, A4 = VDP_DATA, A5 = co | mod:D2, D4, A4, A5

$0011CE  tile_decompressor_inner_loop_b                    [Game / Data]
         Tile Decompressor Inner Loop B Decompression variant B: Store with post-increment, no XOR.
         in:D4 = tile data, A4 = VDP_DATA, A5 = counter | mod:D4, A4, A5

$0011D8  tile_decompressor_inner_loop_c                    [Game / Data]
         Tile Decompressor Inner Loop C Decompression variant C: XOR-combine and store with post-increment.
         in:D2 = accumulated data, D4 = XOR mask, A4 = VDP_DATA, A5 = co | mod:D2, D4, A4, A5

$0011E4  tile_data_stream_byte_read                        [Game / Data]
         Tile Data Stream Byte Read Reads next byte from tile data stream (A0)+.
         in:A0 = pointer to compressed tile data stream | mod:D0, A0

$0011EE  tile_decompressor_engine                          [Game / Data]
         Tile Decompressor Engine Main tile decompression engine.
         in:A0 = compressed data, A1 = output buffer, D0 = initial value | mod:D0-D7, A0-A5 | calls:$0012F4: tile_bit_stream_unpacker (BSR PC-relative) $0013A4:

$0012F4  tile_bit_stream_unpacker                          [Game / Data]
         Tile Bit-Stream Unpacker Unpacks a tile value from a compressed bit-stream.
         in:D1 = bit-shift accumulator, D3 = base tile (from A3) D4 = sh | mod:D0, D1, D3, D4, D5, D6, D7, A0

$00136E  tile_bit_stream_refill_with_mask_table            [Game / Data]
         Tile Bit-Stream Refill with Mask Table Continuation of tile bit-stream unpacker.
         in:D0 = bits needed, D5 = bit-stream, D6 = bits remaining, A0 = | mod:D0, D1, D5, D6, D7, A0, A5

$0013B4  LZSS Decompressor                                 [Util]
         LZSS/LZ77-variant decompression algorithm.
         in:A0 = compressed source, A1 = decompression destination | mod:D0-D6, A0, A1 (A7 for 2-byte flag buffer

$001454  VDP Register Write (Multi-Register Save)          [Vdp]
         Converts a linear VRAM address in D0 to VDP command format and writes it atomically to VDP control port (A5) with interrupts disabled.
         in:D0 = 24-bit VRAM address, A5 = VDP control port | mod:D0, D6, D7 (saved/restored)

$001482  VDP Register Write (Simple)                       [Vdp]
         Compact VDP VRAM write command builder.
         in:D0 = VRAM address, A5 = VDP control port | mod:D0 (saved/restored)

$0014A2  VDP CRAM Read Setup                               [Vdp]
         Sets up VDP for CRAM read access.
         in:D0 = CRAM address, A5 = VDP control port | mod:D0 (saved/restored)

$0014BE  tile_decompression_disp_a                         [Game / Data]
         Tile Decompression Dispatcher A Dispatches up to 4 tile decompression jobs packed in D0 (one byte per job).
         in:D0 = 4 packed job IDs (one per byte), A5 = VDP_CTRL | mod:D0, D1, D2, A0, A5 | calls:$0010F4: tile_decompressor_setup (JSR PC-relative)

$0014E0  tile_decompression_disp_b                         [Game / Data]
         Tile Decompression Dispatcher B Data prefix ($0014E0-$00152F): Tile decompression parameter table.
         in:D0 = 4 packed job IDs (one per byte) | mod:D0, D1, D2, D6, A0, A2, A4, A5 | calls:$001106: tile_decompressor_setup_alt (JSR PC-relative)

$00154E  nametable_copy_disp                               [Game / Render]
         Nametable Copy Dispatcher Data prefix ($00154E-$00155D): 16 bytes of initialization data (decoded as ORI.
         in:D1 = 4 packed job IDs (one per byte) | mod:D0, D1, D2, D3, A0, A1 | calls:$001236: nametable_decompressor (JSR PC-relative)

$001586  descriptor_table_bit_unpacker_disp                [Game / Data]
         Descriptor Table + Bit Unpacker Dispatcher Contains a 10-entry descriptor table (100 bytes) followed by code that iterates 4 bytes of D0 (via ROR.
         in:D0 = packed 4-byte index (each byte selects a descriptor) | mod:D0, D1, D2, A0, A1, A2, A4, A5 | calls:$0013B4 (bit_unpack_loop)

$001610  vdp_row_copy_disp                                 [Game / Render]
         VDP Row Copy Dispatcher Data prefix ($001610-$001637): VDP row copy parameter table.
         in:D0 = 4 packed job IDs (one per byte) | mod:D0, D1, D2, A0 | calls:$0010C4: vdp_copy_rows (JSR PC-relative)

$001684  V-INT Handler ($001684-$0017EE)                   [Main Loop]
         The Vertical Interrupt handler is called every frame (~60Hz NTSC) during VBlank.
         in:Vector at $000078-$00007B points to $00001684 (vint_handler)

$0016B2  input_dispatch_table_and_controller_port_init     [Game / State]
         Input Dispatch Table and Controller Port Init Data prefix ($0016B2-$00170B): Input handler dispatch table containing ROM subroutine addresses ($008...
         in:Called from hardware_init | mod:D0, D7, A0, A1, A3, A4, A5

$00170C  Controller Input Functions ($00170C - $0018FF)    [Input]
         Controller initialization and polling for both Mega Drive controller ports.

$00178E  Controller Read + Button Remap (Port 1)           [Game / State]
         Reads controller port 1 via Z80 bus, remaps buttons.
         mod:D0, D2, A0, A1, A2, A3 | calls:$0017EE: button_remap $00185E: zbus_request

$0017D6  Clear Input State Flags                           [Game / State]
         Clears both input state flag bytes at $C86C and $C86E to zero.
         in:none | Exit: flags cleared | Uses: none

$0017E4  Joypad Process (Button Mapping + Edge Detection)  [Input]
         Reads joypad via joypad_read_hw, maps raw button/direction bits to a standardized format using a configurable mapping table, and performs edge dete...
         in:A0 = output buffer (2 bytes), A2 = state buffer (4 bytes) A3 | mod:D0-D2, D6, D7, A0-A3 | calls:joypad_read_hw

$00185E  Joypad Hardware Read (6-Button Protocol)          [Input]
         Low-level Genesis/Mega Drive joypad hardware read using the standard TH-toggle protocol.
         in:A1 = joypad data port address (e.g., $A10003 or $A10005) | mod:D0, D1, D5, D6, D7 Hardware: $A11100 (Z8

$0018C8  Joypad 3-Button Fallback                          [Input]
         3-button controller exit path.
         in:D0 = raw button state, D5 = $00FF mask, D7 = $40 (TH=1) A1 =

$0018D8  Controller Input Init                             [Game / State]
         Reads controller IDs via BSR.
         mod:D0, D7, A1 | calls:$001992: controller_id_read (BSR.W, external) $00185E: zbus_

$001992  Joypad Read Port (Generic Protocol)               [Input]
         Generic joypad port reader with configurable I/O protocol.
         in:D0 = port index (0-2) | mod:D0, D1, D2, A0, A1 (D1/D2/A1 saved/resto

$0019EA  VDP DMA Transfer Setup (Scroll Data)              [Game / Render]
         Data prefix: 10-word VDP register configuration table.
         mod:D0, D3, D4, D5, A1, A5, A6

$001A64  Set V-INT Dispatch State + VDP Status Read        [Game / Render]
         Two sub-entries: first sets V-INT dispatch state to $002C and jumps to a handler at $0020C6.
         mod:D0, A5

$001A72  VDP DMA Transfer Setup                            [Game / Render]
         Configures and triggers a VDP DMA transfer.
         in:A5 = VDP control port, A6 = VDP data port | mod:D0, D4, A5, A6

$001ACA  VDP DMA Transfer Setup                            [Game / Render]
         Requests Z80 bus, configures VDP DMA registers for a transfer, updates the VDP register cache ($C874/$C876), and releases the Z80 bus.
         in:A5 = VDP control port | Exit: DMA configured | Uses: D0, D4,

$001B14  vdp_dma_transfer_setup                            [Game / Render]
         VDP DMA Transfer Setup Sets up VDP DMA transfers for display tables.
         mod:D0, D4, A5, A6 Hardware: Z80_BUSREQ: Z80

$001C66  VDP DMA + Palette Transfer 036                    [Game / Render]
         Performs VDP register writes, DMA transfer, and palette copy Writes scroll/color data, sets up VDP DMA from ROM to VRAM Toggles frame buffer via ad...
         mod:D0, D4, A5, A6 | calls:$002878: PaletteRAMCopy

$001D0C  VDP DMA + Frame Swap 037                          [Game / Render]
         Performs VDP register writes, DMA transfer, and frame buffer swap Similar to vdp_dma_palette_xfer_036 but checks COMM1 for game state reset Clears ...
         mod:D0, D4, A5, A6

$001DBE  VDP Register Write + 32X Adapter Control          [Game / Render]
         Saves VDP status, waits 100 NOPs, writes VDP scroll data from RAM $8000/$8002 to VRAM $6C00, writes game params $C880/$C882 to VDP CRAM $4000.
         mod:D0, D7, A5, A6

$001E42  VDP Register Write, Frame Swap, and CRAM Copy     [Game / Render]
         End-of-frame display update: writes VDP scroll/VRAM data via the VDP ports (A5=control, A6=data), resets the game state, toggles the MARS frame buf...
         in:A5 = VDP control port, A6 = VDP data port | mod:D0, A0, A1

$001E94  VDP DMA + CRAM Transfer                           [Game / Render]
         Performs VDP DMA to CRAM with Z80 bus synchronization.
         in:A5 = VDP control port | mod:D0, D4, A1, A2, A5 | calls:$0048D6: palette_copy_a (JSR PC-relative) $0048DA: palette_c

$001F4A  VDP DMA + Scroll + Frame Swap                     [Game / Render]
         Writes H-scroll and V-scroll data to VDP, then performs DMA to CRAM with Z80 bus synchronization.
         in:A5 = VDP control port, A6 = VDP data port | mod:D0, D4, A1, A2, A5, A6 | calls:$0048D6: palette_copy_a (JSR PC-relative) $0048DA: palette_c

$002010  V-INT COMM1 Signal Handler                        [Game / Scene]
         Checks COMM1 bit 0 for an SH2 signal.
         in:A5 = VDP control port | Exit: D0 = (A5) | Uses: D0, A5

$002010  V-INT (Vertical Interrupt) Handler Helpers ($002010 - $002038)  [Vint]
         Helper functions called by the V-INT handler for cleanup and state management at the end of vertical blank processing.

$00203A  Frame Sync & Communication Utilities ($00203A - $00207E)  [Frame]
         Functions for frame synchronization between 68K and SH2, plus related communication variable management.

$00203A  sh2_frame_sync_wrapper                            [Game / Scene]
         SH2 Frame Sync Wrapper Saves all registers (D0-D7, A0-A6), calls the SH2 frame synchronization routine at $008B0004, then restores all registers an...
         mod:D0-D7, A0-A6 (saved/restored) | calls:$008B0004: sh2_frame_sync

$00204A  Clear Communication and State Variables           [Game / Scene]
         Clears five state/communication variables to zero: $C8A4, $C822 (comm ready flag), $C823, and $C8A2.
         in:none | Exit: variables cleared | Uses: D0

$00205E  Set Communication Ready Flag                      [Game / State]
         Sets the communication flag at $C822 to $F0, signalling that the 68K is ready for SH2 communication.
         in:none | Exit: flag set | Uses: none

$002066  Sound State Init + Clear Comm Variables           [Game / Race]
         Initializes sound driver configuration ($8506 = $03 tempo, $8504 = $30 volume/mode), then clears comm ready flag ($C822) and state variable ($C8A4)...
         in:none | Exit: sound + comm initialized | Uses: D0

$002080  Sound Command Dispatch + Sound Driver Call        [Game / Race]
         Processes pending sound commands from 3 RAM slots: Priority 1 ($C822): if nonzero, writes to Z80 command ($8509), clears $C822 and $C8A4, then call...
         mod:D0, A5, A6

$0020D6  sound_update_disp                                 [Game / State]
         Sound Update Dispatcher Sound command update dispatcher with 7 entry points (one per game state variant).
         mod:D0, A5, A6 | calls:$008B0000: sound_driver_update $00232E: next handler (JMP PC

$002200  Counter Increment and Flag Set                    [Util]
         Increments a byte counter at $C828 and sets bit 1 of the control flag byte at $C80B.
         in:No register inputs | mod:(none modified beyond RAM writes)

$00220C  Audio Frequency Update (Dual Channel)             [Game / Race]
         Updates audio frequency for two channels (A and B).
         mod:D0, D1, A1, A2, A3

$002294  randomized_timer_decrement_a                      [Game / State]
         Randomized Timer Decrement A If (A1) equals target value $1E00, generates a random number (0-15) and subtracts it from D1 to introduce jitter.
         in:D1 = timer value, A1 = timer storage pointer | mod:D0, D1, A1 | calls:$00496E: random_number_gen (JSR PC-relative)

$0022AA  weighted_timer_average_a                          [Game / State]
         Weighted Timer Average A Computes weighted average for frame timing smoothing: D1 = (D0/16) * ~1.
         in:D0 = raw timing input, A1 = timer storage pointer | mod:D0, D1, A1

$0022D6  randomized_timer_decrement_b                      [Game / State]
         Randomized Timer Decrement B If (A1) equals target value $21D0, generates a random number (0-15) and subtracts it from D1.
         in:D1 = timer value, A1 = timer storage pointer | mod:D0, D1, A1 | calls:$00496E: random_number_gen (JSR PC-relative)

$0022EC  weighted_timer_average_b                          [Game / State]
         Weighted Timer Average B Computes weighted average for frame timing smoothing: D1 = (D0/16) * ~1.
         in:D0 = raw timing input, A1 = timer storage pointer | mod:D0, D1, A1

$002314  randomized_timer_decrement_c                      [Game / State]
         Randomized Timer Decrement C If (A1) equals target value $21A0, generates a random number (0-15) and subtracts it from D1.
         in:D1 = timer value, A1 = timer storage pointer | mod:D0, D1, A1 | calls:$00496E: random_number_gen (JSR PC-relative)

$00232A  Audio Trigger + Frequency Calc                    [Game / Race]
         Manages audio trigger state for channel B.
         mod:D0, D1, A1

$0023C2  Randomized Sound Parameter (Base $1E00)           [Game / Race]
         Loads base value $1E00 into D1.
         in:A1 = parameter pointer | Exit: sound param updated | Uses: D

$0023DC  Weighted Average Position Clamp (Variant B)       [Game / Physics]
         Computes weighted average: D1 = (D0×29/256 + $1A5E + *A1) / 2.
         in:D0 = input value, A1 = position pointer | mod:D0, D1, A1

$00240C  Randomized Sound Parameter (Base $21D0)           [Game / Race]
         Loads base value $21D0 into D1.
         in:A1 = parameter pointer | Exit: sound param updated | Uses: D

$002426  Weighted Average Position Clamp                   [Game / Physics]
         Computes weighted average: D1 = (D0×7/64 + $1A5E + *A1) / 2.
         in:D0 = input value, A1 = position pointer | mod:D0, D1, A1

$002452  Randomized Sound Parameter (Base $21A0)           [Game / Race]
         Loads base value $21A0 into D1.
         in:A1 = parameter pointer | Exit: sound param updated | Uses: D

$00246C  Set Display Flag $01                              [Display]
         Sets display mode flag at $8507 to $01.
         in:none | mod:none

$002474  Set Display Flag $80                              [Display]
         Sets display mode flag at $8507 to $80.
         in:none | mod:none

$00247C  Pixel Unpack 2 Pairs                              [Graphics]
         Unpacks 2 bytes into 4 pixels (4bpp packed pixel format).
         in:A0 = source data, A6 = VDP data port | mod:D0, D1, D6, A0 (advances by 2)

$00247C  VDP Tile Expansion Functions ($00247C - $0024AC)  [Vdp]
         Expands packed nibble tile data to VDP format.

$0024AE  Pixel Unpack 1 Pair                               [Graphics]
         Unpacks 1 byte into 2 pixels (4bpp packed pixel format).
         in:A0 = source data, A6 = VDP data port | mod:D0, D1, D6, A0 (advances by 1)

$0024CA  VDP Tile Unpack (12 regions)                      [Game / Data]
         Unpacks tile data to 12 VRAM regions via repeated calls to unpack_tiles_vdp.
         in:A5 = VDP control port | mod:A0, A5 | calls:$00247C: unpack_tiles_vdp (JSR PC-relative, called 12 times)

$002594  Conditional Tile Index Expand                     [Game / Hud]
         Tests VDP update flag ($C80D).
         in:A5 = VDP port | Exit: tiles updated or skipped | Uses: A0, A

$0025B0  VDP Tile Unpack (12× Calls to unpack_tiles_vdp)   [Game / Data]
         If skip_flag ($C80D) is clear: unpacks tile data to two VRAM nametable rows via 12 calls to unpack_tiles_vdp ($00247C).
         mod:A0, A5 | calls:$00247C: unpack_tiles_vdp (12×)

$00263E  MARS System Registers Init (13 Words)             [Hardware Regs]
         Copies 13 words from a data table (following this function) to MARS system registers at $A15100-$A15118.
         in:none (data table at PC+$12) | mod:A1, A2, D7

$002652  gfx_32x_vdp_mode_reg_setup                        [Game / Render]
         32X VDP Mode Register Setup Data prefix ($002652-$00266B): 32X VDP mode register initialization values (12 bytes: 6 words for bitmap mode, screen s...
         mod:D0, D3, D7, A1, A2 Hardware: MARS_VDP_MO

$002680  MARS Adapter State Init + Framebuffer Setup       [Game / Render]
         Two entry points for MARS framebuffer initialization.
         in:none | Exit: framebuffers initialized | mod:D0, A4

$00270A  MARS Framebuffer Preparation (Double-Buffered)    [Game / Render]
         Prepares both MARS framebuffers in sequence.
         in:none | Exit: both framebuffers prepared | mod:D0, D2, A4

$00273C  VDP Fill Frame Buffer                             [Vdp]
         Fills the entire 32X VDP frame buffer with zeros (screen clear).
         in:none | mod:A2, A3, A4, D0, D1, D2, D7

$00277A  VDP Clear Palette                                 [Vdp]
         Clears all 256 CRAM palette entries to 0 (black).
         in:D0 = fill value (typically 0) | mod:A2, D7

$002798  VDP Fill Line Table (Flat)                        [Vdp]
         Fills VDP line table with constant value for all 224 display lines.
         in:none | mod:A1, D2, D7

$0027B6  VDP Fill Line Table (Ramp)                        [Vdp]
         Fills line table with incrementing addresses for linear scanline display.
         in:none | mod:A1, D0, D1, D7

$0027DA  gfx_32x_framebuffer_palette_fill                  [Game / Render]
         32X Framebuffer Palette Fill Fills 32X framebuffer palette entries using auto-fill registers.
         in:None (calls VDPPrep internally) | mod:D0, D1, D2, D7, A2, A3, A4 Hardware: MAR | calls:$00281E: VDPPrep (BSR)

$0027F8  VDP Operations and Synchronization ($0027F8-$002982)  [Display]
         Core VDP (Video Display Processor) functions for 32X frame buffer management, palette operations, and SH2 synchronization via COMM ports and FIFO.

$0027F8  VDP Operations ($0027F8 - $002900)                [Vdp]
         VDP (Video Display Processor) access functions for the 32X.

$00281E  VDP Fill Pattern                                  [Vdp]
         Fills a VDP region at address $1F00 with pattern $0101.
         in:none | mod:A2, A3, A4, D0, D1

$00284C  Palette Copy Full                                 [Vdp]
         Copies 512 bytes from (A2) to CRAM palette (full 256 entries).
         in:A2 = source palette data | mod:A2, A3, D7

$002862  Palette Copy Partial                              [Vdp]
         Copies 128 bytes to CRAM starting at offset $40 (entries 32-63).
         in:A2 = source palette data | mod:A2, A3, D7

$002878  V-INT CRAM Transfer Gate                          [Game / Render]
         Checks the CRAM update flag at $C821.
         in:none | Exit: palette copied if flag set | mod:A1, A2

$002890  MARS Communication Write                          [Sh2]
         Writes a command to SH2 via communication registers (COMM0/COMM1).
         in:Command bytes in $C8A8/$C8A9 | mod:none (only modifies MARS registers and R

$0028C2  MARS DMA Transfer + VDP Fill                      [Game / Render]
         Two entry points: (1) DMA transfer — sets MARS DREQ length/mode, writes command to COMM0, waits for ACK via COMM1, then streams data from $FF6000 t...
         mod:D0, D1, D2, D7, A1, A2, A3, A4

$002984  camera_param_calc                                 [Game / Camera]
         Camera Parameter Calculation Computes camera/view parameters from entity state.
         in:Uses fixed addresses A0=$FF9000, A1=$FF6100 | mod:D0, D1, A0, A1

$002A72  Object Enable Fields + State Dispatch             [Game / State]
         Sets 5 enable fields on object (A1) to 1 ($00/+$14/+$28/+$3C/+$50).
         mod:D0, A0, A1

$002AAA  Object Velocity Init + Conditional Clear          [Game / Physics]
         Copies velocity data from $C748 to object A1 offset +$24.
         in:A0 = source object, A1 = target object

$002AC4  Entity Set Model (Type 0)                         [Object]
         Sets entity model pointer from lookup table at $C710 and conditionally sets visibility based on mode flag at A0+$8C.
         in:A0 = source entity, A1 = destination entity | mod:none (only modifies memory)

$002ADE  camera_param_calc_b                               [Game / Camera]
         Camera Parameter Calculation B Computes camera view parameters from entity A0 ($FF9000), stores to camera buffer A1 ($FF6100).
         in:A0 = entity ($FF9000), A1 = camera buffer ($FF6100) | mod:D0, D1, A0, A1

$002BB0  object_render_disp                                [Game / Render]
         Object Render Dispatcher Dispatches object rendering pipeline for both players.
         mod:D0, A0, A1, A2 | calls:$002C58: render_visibility_check (internal) $002CDC: camera_

$002C9A  Entity Visibility Check                           [Game / Entity]
         Determines entity visibility based on race mode, entity flags, and global state.
         in:A0 = entity, A2 = display slot buffer | mod:D0

$002CDC  camera_param_calc_c                               [Game / Camera]
         Camera Parameter Calculation C (Dual Output) Computes camera view parameters from entity A0, stores to both camera buffer A1 and secondary buffer A2.
         in:A0 = entity, A1 = primary camera buffer, A2 = secondary buff | mod:D0, D1, A0, A1, A2

$002DCA  Object Param 8A Dispatch (Variant A)              [Game / State]
         Reads object param_8a (A0+$8A) and dispatches: param=0 → branches forward to $002E14 (external handler) param=1 → branches forward to $002DF4 (exte...
         in:A0 = source object, A1 = target object 1, A2 = target object | mod:D0, A0, A1, A2

$002DF4  Object Velocity Init (Dual Object)                [Game / Physics]
         Copies velocity data from $C748 to both A1+$24 and A2+$128.
         in:A0 = source obj, A1 = target obj 1, A2 = target obj 2

$002E14  Object Velocity Init (Dual Object, Source $C710)  [Game / Physics]
         Copies velocity data from $C710 to both A1+$24 and A2+$128.
         in:A0 = source obj, A1 = target obj 1, A2 = target obj 2

$002E34  Object Param 8A Dispatch (Variant B)              [Game / State]
         Reads object param_8a (A0+$8A) and dispatches: param=0 → branches forward to $002E7E (external handler) param=1 → branches forward to $002E5E (exte...
         in:A0 = source object, A1 = target object 1, A2 = target object | mod:D0, A0, A1, A2

$002E5E  Object Velocity Init (Dual Object, Alt Source)    [Game / Physics]
         Copies velocity data from $C75C to both A1+$24 and A2+$128.
         in:A0 = source obj, A1 = target obj 1, A2 = target obj 2

$002E7E  Object Velocity Init (Dual Object, Source $C754)  [Game / Physics]
         Copies velocity data from $C754 to both A1+$24 and A2+$128.
         in:A0 = source obj, A1 = target obj 1, A2 = target obj 2

$002E9E  Load Display List Pointer (Set A)                 [Game / Render]
         Loads a display list pointer from $C724 into A1+$24.
         in:A0 = param source, A1 = dest struct

$002EB2  Load Display List Pointer (Set B)                 [Game / Render]
         Loads a display list pointer from $C758 into A1+$24.
         in:A0 = param source, A1 = dest struct

$002EC6  Object Field Clear (Conditional)                  [Game / Entity]
         If $C31C is nonzero and obj.
         in:A0 = source object, A1 = target object | mod:D0, A0, A1

$002EC6  Object Visibility Functions ($002EC6 - $002F02)   [Object]
         Functions for managing object visibility state.

$002EEE  object_visibility_enable                          [Game / Render]
         Object Visibility Enable Sets visibility flag to 1 for all 5 render slots in the camera buffer: (A1)+$00, +$14, +$28, +$3C, +$50.
         in:A1 = camera/render buffer pointer | mod:D0, A1

$002F04  camera_param_calc_d                               [Game / Camera]
         Camera Parameter Calculation D (Dual Output) Computes camera view parameters with dual output (A1 + A2), plus angular velocity smoothing.
         in:A0 = entity, A1 = primary camera buffer, A2 = secondary buff | mod:D0, D1, A0, A1, A2

$003010  object_pos_copy_with_render_flags                 [Game / Render]
         Object Position Copy with Render Flags Copies entity positions to render buffer (A2) and sets render visibility flags.
         in:A0 = entity, A1 = camera buffer, A2 = render output buffer | mod:D0, D1, D2, D3, A0, A1, A2

$0030C6  Camera Offset Clamping (Y + X Limits)             [Game / Camera]
         If $C30E bit 5 set (race active): Y clamping: loads VDP field $FF610A, subtracts camera_offset_y ($C0B0).
         mod:D0, D1, A1

$003116  Camera Offset Check (2-Player)                    [Display]
         In 2-player mode, adds $40 vertical offset to camera position.
         in:none | mod:none (only modifies memory)

$003126  VDP Buffer Transfer + Camera Offset Apply         [Game / Camera]
         Copies camera parameters to VDP buffer at $FF6100.
         mod:D0, A0, A1 | calls:$002996: VDP buffer init

$003160  VDP Config Transfer + Scaled Parameters           [Game / Render]
         Writes $0001 to VDP control ($FF6100).
         mod:D0, A1, A2

$0031A6  Object State Dispatcher (11-Entry Jump Table)     [Game / State]
         Dispatches via 11-entry longword jump table indexed by dispatch_idx ($C305) as byte.
         mod:D0, D1, D4, A0, A1, A2, A6

$003204  Object Timer Tick + SFX Lookup + Field Clear      [Game / Race]
         Decrements countdown ($C308); when zero: compares $C08E with $C07A — if different, indexes SFX table at $008989EE by object field +$2C and writes t...
         mod:D0, A0, A1

$003250  Load Object Pointer + Clear Object State          [Game / State]
         Loads object pointer from $C258 into A1, sets object command byte (offset $00) to $02, then clears three state bytes: two SH2 shared ($FF6940, $FF6...
         in:none | Exit: object + state cleared | Uses: A1

$003272  race_result_recording_003272                      [Game / Race]
         Race Result Recording Records race completion result for single-player.
         in:A0 = entity pointer (car) | mod:D0, A0, A1, A2, A3

$00337A  Lap Check Dispatcher (15-Entry Jump Table + Lap Advance)  [Game / Race]
         Dispatches via 15-entry longword jump table indexed by dispatch_idx ($C305).
         mod:D0, D2, D4, A0, A1, A2, A4, A6

$0033E4  Set Game State $34                                [Game / State]
         Sets game state byte at $C305 to $34.
         in:none | mod:none

$0033EC  Sound Lookup and Play                             [Sound]
         Looks up a sound effect by index from entity data and plays it.
         in:A0 = entity | mod:D0, A1

$003404  race_result_recording_003404                      [Game / Race]
         Race Result Recording (2-Player) Records race completion result for 2-player mode.
         in:A0 = entity pointer (car), selects player by address | mod:D0, A0, A1, A2, A3

$0034D2  Calculate State from Flags                        [Game / State]
         Calculates game state from bits 0-1 of flag byte at $C8AB.
         in:none | mod:D0

$0034E8  Object State Dispatcher (12-Entry Jump Table)     [Game / State]
         Dispatches via 12-entry longword jump table indexed by dispatch_idx ($C305) as byte.
         mod:D0, A1, A2, A3, A4

$003540  Object Timer Tick + SFX Lookup (Variant B         [Game / Race]
         Extra Flag Check) Like object_timer_tick_sfx_lookup_field_clear but adds extra checks: Decrements countdown ($C308); when zero and $C08E !
         mod:D0, A0, A1

$00359C  Clear Object State Bytes                          [Game / State]
         Clears three object-related bytes: two in SH2 shared memory ($FF6940, $FF6950) and flag byte $C305 in 68K RAM.
         in:none | Exit: 3 bytes cleared | Uses: none

$0035B4  race_result_with_leaderboard_update               [Game / Race]
         Race Result with Leaderboard Update Extended race result recording with leaderboard/records comparison.
         in:A0 = entity pointer (car) | mod:D0, D1, D2, A0, A1, A2, A3

$0036C8  Calculate State from Flags (Copy 2)               [Game / State]
         Identical to calc_state_from_flags.
         in:none | mod:D0

$0036DE  object_table_sprite_param_update                  [Game / Render]
         Object Table Sprite Parameter Update Iterates through 15 objects (D7=$0E), reading sprite type from entity +$C1 and computing render parameters for...
         in:Fixed addresses A0=$FF9100, A1=$FF6218 | mod:D0, D5, D6, D7, A0, A1, A3

$0037B6  object_proximity_check_jump_table_dispatch        [Game / Collision]
         Object Proximity Check + Jump Table Dispatch Checks distance between an object at ($FFFF9000) and up to 3 target objects.
         in:(implicit — uses RAM addresses directly) | mod:D0, D1, D2, D4, D7, A0, A1, A2

$00385E  Conditional Return on Display Flag                [Game / State]
         Tests the display control byte at $C80F.
         in:none | Exit: returns if flag set, falls through if clear | mod:condition codes

$003866  Proximity Check with Sine Billboard               [Game / Collision]
         3D proximity + sine-animated sprite Checks object position against sprite table entries in 3D space.
         in:A0 = player entity pointer (+$30=X, +$32=Y, +$34=Z); A1 (loa | mod:D0, D1, D2, D3, D4, D5, A0, A1, A2 | calls:$008F52: sine_lookup

$003924  Sprite Init + Collision Check (56-Byte Data Prefix)  [Game / Collision]
         Data prefix: 56 bytes ($3924-$395B) of sprite/collision configuration records (4 × 14-byte entries with $222A markers).
         mod:D0, D1, D2, D7, A1, A2, A3, A6 | calls:$0039EC: collision_distance_calc

$00397C  Sprite Parameter Setup (Two Sprite Blocks)        [Game / Render]
         Initializes sprite block A at $FF65D8: advances sprite_counter ($C8E2) by $1E, masks to 13 bits, writes to +$20 (rotation angle).
         mod:D0, D1, D3, A1, A2 | calls:$0038C0: sprite_param_calc

$0039EC  Proximity Check Simple                            [Game / Collision]
         3D range test with sprite data copy Tests entity position (A0 +$30/+$32/+$34) against reference object (A1) in 3 axes: X/Z threshold $0C80, Y thres...
         in:A0 = player entity pointer (+$30=X, +$32=Y, +$34=Z); A1 = re | mod:D0, D1, D2, D3, D4, D5

$003A3E  Proximity Loop Iterator A                         [Game / Collision]
         advance and repeat proximity check Advances A1 by 10 bytes to next object entry, loops back to proximity_check_simple body via DBRA D7.
         in:A1 = current object pointer (advanced by $0A per iteration); | mod:D7, A1

$003A4E  Sprite Init + Collision Check (92-Byte Data Prefix)  [Game / Collision]
         Data prefix: 92 bytes ($3A4E-$3AA9) of sprite/collision configuration records.
         mod:none (just data + simple test)

$003AB2  Proximity Check 062                               [Game / Collision]
         Tests if object is within 3D bounding box of reference point Checks X, Z, Y deltas against thresholds ($0C80 and $1400) On match: copies reference ...
         in:A0 = object/entity pointer | mod:D0, D1, D2, D3, D4, D5, A0, A1, A2

$003B28  Object Table 3 Proximity with Animation           [Game / Collision]
         trackside object visibility Loads player position from object table 3 ($9F00), gets sprite table via indexed ROM lookup at $00895A64.
         in:A0 (loaded internally from $9F00 obj_table_3) | mod:D0, D1, D2, D3, D4, D5, D7, A0, A1, A2

$003C1A  Proximity Loop Iterator B                         [Game / Collision]
         advance and repeat object_table_3_proximity_with_animation inner loop Advances A1 by 10 bytes to next object entry, loops back to object_table_3_pr...
         in:A1 = current object pointer (advanced by $0A per iteration); | mod:D7, A1

$003C2A  sprite_hud_layout_builder                         [Game / Hud]
         Sprite/HUD Layout Builder Builds 4 sprite entries at $FF66DC from two PC-relative data tables: - Animation table at sprite_hud_layout_builder (18 w...
         mod:D0, D1, D2, A1, A2, A3

$003CCE  VDP Sprite Pointer Setup + Conditional Display Clear  [Game / Render]
         Sets up 4 sprite block pointers at $FF66EC (stride $14) from ROM pointer table at $00895B7E, indexed by D0 × 16.
         mod:D0, D1, A1, A2, A3

$003D22  SFX Trigger + Object Enable Fields                [Game / Race]
         If D1 == 4 or D1 == $16: plays SFX $BA via $C8A4.
         in:D1 = event index | mod:D0, D1, A1

$003D5A  HUD Element Initialization                        [Game / Hud]
         configure 3 HUD display slots Initializes 3 HUD element slots with type $09 and ROM data pointers: Slot 1 ($FF6980): type=$09, data=$040268F8, aux=...
         mod:A1

$003D9A  Reset Timer and Advance State                     [Game / State]
         Resets the frame counter at $C8AA to zero and advances the state machine at $C8AC by 4.
         in:No register inputs | mod:(none modified beyond RAM writes)

$003DA6  Conditional Scene Transition (State $A6)          [Game / Menu]
         Checks if scene state ($C8AA) exceeds 20.
         in:none | Exit: scene transitioned or no-op | Uses: A1, A6

$003DD4  Conditional Scene Transition (State $A7)          [Game / Menu]
         Checks if scene state ($C8AA) exceeds 20.
         in:none | Exit: scene transitioned or no-op | Uses: none

$003E08  Scene Transition Check + VDP Clear                [Game / Render]
         At scene_state ($C8AA) == 10: loads SFX from table at $003E52 indexed by $C89C, writes to $C8A5.
         mod:D0

$003E52  Clear Scene State + Advance Dispatch Index        [Game / Scene]
         Data prefix (6 bytes) followed by code that clears the scene state ($C8AA) and advances the dispatch index ($C8AC) by 4.
         in:none | Exit: scene state reset, dispatch advanced | mod:D2, D7, A1

$003E64  Clear Scene State + Advance Dispatch + Set Mode   [Game / Scene]
         Clears scene state ($C8AA), advances dispatch index ($C8AC) by 4, sends command $09 to SH2 shared memory ($FF6980), and sets the state variable ($C...
         in:none | Exit: state advanced | Uses: none

$003E7E  Conditional Scene Transition (State $C1)          [Game / Menu]
         Checks if scene state ($C8AA) exceeds 20.
         in:none | Exit: scene transitioned or no-op | Uses: none

$003EA2  Conditional Scene Transition (State $C2)          [Game / Menu]
         Checks if scene state ($C8AA) exceeds 20.
         in:none | Exit: scene transitioned or no-op | Uses: none

$003EC6  Conditional Scene Transition (State $C3)          [Game / Menu]
         Checks if scene state ($C8AA) exceeds 20.
         in:none | Exit: scene transitioned or no-op | Uses: none

$003EF6  Scene State Timer + VDP Output                    [Game / Render]
         If scene_state ($C8AA) == 5 → plays SFX $98 via $C8A5.
         mod:D0

$003F2E  Render Slot Setup                                 [Game / Render]
         configure 7 trackside object render slots Four entry points for different viewport configurations: Entry 1 ($003F2E): 1P mode — viewport A ($FF64AC...
         in:A0 = player entity pointer (+$C0=render_flags) | mod:D0, D1, D2, D3, D4, A0, A1, A2

$004084  Display State Dispatcher                          [Game / Render]
         13-state game display controller Dispatches to one of 13 display states via jump table indexed by RAM $C07C.
         mod:D0, A0, A1, A2

$00413A  Object Speed Ramp-Up + State Advance              [Game / Physics]
         Ramps up object speed at $FF6754: increments $C25C by 8 each frame, copies to obj.
         mod:D0, A2

$004168  Check Timeout (60 Frames)                         [Game / State]
         Checks if timer at $C8AA has reached 60 frames (1 second).
         in:none | mod:none (only modifies memory)

$00417C  Race Completion Check + Lap Bit Tracking          [Game / Race]
         If scene_state ($C8AA) == $15 (race checkpoint): copies $C096 → $C07A, advances $C07C by 4, clears $FF6754.
         mod:D0

$004200  Sprite Config Setup 001                           [Game / Render]
         Configures sprite display entries from racer data Looks up sprite graphics pointers from ROM tables Copies position data from work buffers via BSR ...
         mod:D0, D1, D5, D7, A0, A1, A2, A3

$004280  Data Unpack Nibbles                               [Util]
         Unpacks packed nibble data from (A1)+ into byte fields at A2+$09 through A2+$0F.
         in:A1 = source data, A2 = destination structure | mod:D0, A1 (advances)

$0042BA  Timer Threshold Init (Sprite Setup)               [Game / State]
         Waits for frame counter > 20, then initializes a sprite at $FF6754 with position/attribute data, sets sound effect $95, advances state.
         in:none | mod:A2

$004300  Scroll Update Animation                           [Display]
         Updates scroll animation on sprite at $FF6754.
         in:none | mod:D0, A2

$00432E  Timer Wait and Clear Sprite                       [Game / State]
         Waits 60 frames, then advances state, resets counter, disables sprite.
         in:none | mod:none (modifies memory only)

$00434A  Fade Subtract Array (Palette Fade-Out)            [Display]
         Performs palette fade-out by subtracting 30 from 8 palette entries (spaced 16 bytes apart at $FF6802).
         in:none | mod:D0, A2

$004384  Advance State and Clear Timer                     [Game / State]
         Advances the state machine at $C07C by 4 and resets the frame counter at $C8AA to zero.
         in:No register inputs | mod:(none modified beyond RAM writes)

$004390  Timer Wait and Set Transition Flags               [Game / State]
         Waits for the frame counter at $C8AA to reach 40 ($0028).
         in:No register inputs | mod:(none modified beyond RAM writes)

$0043BC  Sound Queue and Advance (SH2 Gate)                [Game / Race]
         If SH2 processing flag (bit 7 of $C80E) is clear, queues sound $F3 and advances state machine.
         in:none | mod:none

$0043D0  Game Init + State Dispatch 002                    [Game / State]
         Two entry points: Entry A ($0043D0): Game initialization — clears work buffers, resets state Entry B ($00442E): State dispatcher with 4-entry jump ...
         mod:D0, A0, A1, A6 | calls:$00B4CA: ai_scene_interpolation $002890: v_int_comm1_signal_

$004460  Scene State Check + Conditional Advance           [Game / Scene]
         Checks scene_state counter: - If == 1: calls init sub at $002066 - If == 60 ($3C): advances input_state, clears scene_state, enables display flags ...
         calls:$002066: scene init sub (PC-relative)

$004498  Flag Check and Advance State                      [Game / State]
         Waits for SH2 processing to complete (bit 7 of $C80E clear), then advances state machine.
         in:none | mod:none

$0044A6  Comprehensive State Reset                         [Game / State]
         Full state reset clearing control flags, counters, display parameters, and setting the execution vector.
         in:No register inputs | mod:D0

$0044E8  Display State Dispatcher (Two Jump Tables: 9 + 4 Entries)  [Game / State]
         Sets camera_active ($C048) = 1.
         mod:D0, D2, A1, A2, A4, A6

$004538  Call Sub + Address Check + Set Race Mode          [Game / Race]
         Calls sub at $00B25E, advances input state ($C07C) by 4.
         in:A0 = address from sub | Exit: conditional return | Uses: A0

$004556  Set Effect Flag and Clear Sprite                  [Display]
         Sets effect code $AB and disables sprite at $FF6940.
         in:none | mod:none

$004566  Advance Input State                               [Game / State]
         Advances the input/controller state machine by one step (4 = one entry).
         in:none | Exit: state advanced | Uses: none

$00456C  Input State Dispatcher (4-Entry Jump Table + Init)  [Game / State]
         Dispatches via 4-entry longword jump table indexed by input_state ($C819) × 4.
         mod:D0, A0, A1, A2, A6

$0045CE  Sprite Position Check (Player Compare)            [Game / Render]
         Initializes sprite and checks player score against threshold.
         in:A0 = player base, A2 = sprite struct | mod:D0

$00461A  Sprite Clear (Alternate Path)                     [Game / Render]
         Clears position flag and sets alternate sprite attributes.
         in:A2 = sprite struct | mod:none

$004630  Reset Step Counter to 3                           [Game / State]
         Resets step counter at $C819 to 3.
         in:none | mod:none

$004638  Sound Queue, Sprite Adjust, Advance               [Game / Race]
         Queues sound $F2, moves sprite up by 6 pixels, advances state.
         in:none | mod:none

$00464A  Flag $96, Sprite Adjust, Advance                  [Game / State]
         Sets effect code $96, moves sprite up by 6 pixels, advances state.
         in:none | mod:none

$00465C  Scroll Limit Update (Sprite Y Clamp)              [Display]
         Scrolls sprite upward by 10/frame, clamping at Y=230.
         in:A0 = entity | mod:A2

$004682  Visibility Flag Set (Sprite Enable)               [Display]
         Sets sprite visibility at $FF69E0 based on bit 2 of $C8AB.
         in:none | mod:D0

$004696  Counter Check and Advance Secondary State         [Game / State]
         Checks if step counter equals 3; if so, advances secondary state at $C8BE and resets frame counter.
         in:none | mod:none

$0046AA  Timer Complete with Conditional Flags             [Game / State]
         Waits for frame counter $C8AA to reach 40 ($0028).
         in:No register inputs | mod:(none modified beyond RAM writes)

$0046EE  Block Copy 1KB with SH2 Check                     [Memory]
         Copies 1024 bytes from $B400 to $A400 using MOVEM block copy.
         in:none | mod:D0-D6, A1-A3, D7

$00471E  Game Logic Init + State Dispatch                  [Game / State]
         Two entry points: (1) init path — sets up VDP, sprite table, SH2 command handler, then jumps to external init routine; (2) dispatch path — sets cam...
         mod:D0, A1, A5 | calls:$002890: game_init (JMP PC-relative) $00B25E: state_advance 

$0047CA  Flag Set, Sound Config, Advance                   [Game / State]
         SH2 Gate Sets the process flag at $C048, then checks if the SH2 has completed (display bit 7 at $C80E).
         in:No register inputs | mod:(none modified beyond RAM writes)

$0047E4  Full State Reset                                  [Game / State]
         Race Mode Full state reset for race mode.
         in:No register inputs | mod:D0

$00482A  Word Pack and Swap (VDP Command Format)           [Util]
         Packs D0 value with VDP flag bit: shift left 2, shift low word right 2, set bit 14, swap words.
         in:D0 = value | mod:D0

$004836  Fast Memory Copy/Fill Functions ($004836 - $00496E)  [Memory]
         Highly optimized unrolled memory copy and fill routines.

$004836  Memory Fill and Copy Operations ($004836-$004996)  [Memory]
         High-performance unrolled memory operations for buffer initialization and data transfer.

$004836  Quad Memory Fill (JSR Cascade)                    [Memory]
         High-speed memory fill using JSR cascade trick.
         in:D1 = fill value, A1 = destination | mod:A1 (advances), stack (cascade returns)

$004888  Fast Fill 128 Bytes (Fixed Address)               [Memory]
         Writes D1 to fixed address (A6) 32 times (128 bytes).
         in:D1 = fill value, A6 = destination (fixed) | mod:none

$0048CA  Triple Memory Copy (JSR Cascade)                  [Memory]
         High-speed memory copy using JSR cascade trick.
         in:A1 = source, A2 = destination | mod:A1, A2 (advance), stack (cascade returns

$00492C  Fast Copy 128 Bytes to Fixed Address              [Memory]
         Copies 32 longs from (A1)+ to fixed address (A6).
         in:A1 = source, A6 = destination (fixed) | mod:A1 (advances)

$00496E  Pseudo-Random Number Generator                    [Math]
         Linear congruential PRNG.
         in:none | mod:D0 (D1 preserved)

$004998  Scroll Variables & Display Parameters ($004998 - $004A30)  [Display]
         Functions for managing scroll position variables, display limits, and V-blank synchronization.

$004998  Wait For V-Blank                                  [Frame]
         Waits for V-blank by setting flag and spinning until V-INT clears it.
         in:none | mod:SR (temporarily set to $2300)

$0049AA  Input Clear                                       [Input]
         Both Players Clears input state for both players.
         in:No register inputs | mod:(none modified beyond RAM writes)

$0049C8  Input Clear                                       [Input]
         Both Players + P1 Extended Clears P1/P2 input words to $FF00 and resets P1 extended input only.
         in:No register inputs | mod:(none modified beyond RAM writes)

$0049DE  Input Clear                                       [Input]
         P2 + P2 Extended Clears P2 input word to $FF00 and resets P2 extended input only.
         in:No register inputs | mod:(none modified beyond RAM writes)

$0049EE  Input Mask                                        [Input]
         Both Players Masks both player input words to retain only direction bits (AND with $FF80), then clears both extended input longs.
         in:No register inputs | mod:(none modified beyond RAM writes)

$004A0C  Input Mask                                        [Input]
         Both Players + P1 Extended Clear Masks P1/P2 input words to direction bits ($FF80) and clears P1 extended input only.
         in:No register inputs | mod:(none modified beyond RAM writes)

$004A22  Input Mask                                        [Input]
         P2 + P2 Extended Clear Masks P2 input word to direction bits ($FF80) and clears P2 extended input only.
         in:No register inputs | mod:(none modified beyond RAM writes)

$004A32  race_scene_init_004a32                            [Game / Race]
         Race Scene Initialization (1-Player) Initializes a 1-player race scene.
         in:Called as scene init orchestrator | mod:D0, D1, A0, A1, A2, A5 MARS: adapter_ctr

$004C8A  Set State + Pre-Dispatch + Init SH2 Scene         [Game / Scene]
         Sets race/mode state ($C8A5) to $9A, calls pre_dispatch_common ($002080) and WaitForVBlank ($004998), then initializes SH2 scene handler to $008856...
         in:none | Exit: SH2 scene initialized | Uses: none

$004CB8  State Dispatcher (5-Entry Jump Table + 6 Subroutines, Data Prefix)  [Game / State]
         Data prefix: 2 words ($A2A0, $A100) — RAM buffer addresses.
         mod:D0, D3, D7, A1, A2 | calls:$0020D6: init handler $0028C2: VDPSyncSH2 $0058C8: sprite_in

$004D00  Call Subs + Advance Game State                    [Game / Menu]
         Calls three subroutines: $00210A, animation_update ($00B09E), and sprite_update_check ($005908).
         in:none | Exit: game state advanced | Uses: none

$004D1A  Game Frame Orchestrator 013                       [Game / Scene]
         Main game frame update — calls rendering + logic subroutines Path A: full update (10 calls + input record + sprite/object update) Path B: minimal u...
         mod:D0, D1, A0 | calls:$00212E: vdp_display_init (pre-frame) $00179E: poll_controll

$004D98  race_scene_init_004d98                            [Game / Race]
         Race Scene Initialization (2-Player) Initializes a 2-player split-screen race scene.
         in:Called as scene init orchestrator | mod:D0-D7, A0, A1, A2, A5 MARS: adapter_ctrl

$005020  State Dispatcher (5-Entry Jump Table + 8 Subroutines, Data Prefix)  [Game / State]
         Data prefix: 2 words ($A5A3, $A400) — RAM buffer addresses.
         mod:D0, D2, A0, A1, A6 | calls:$002154: init handler $0028C2: VDPSyncSH2 $00B03C: frame_upd

$005070  Frame Update Orchestrator (8 Subroutines)         [Game / Scene]
         Calls 8 subroutines via bsr.
         mod:D0 (from called routines) | calls:$002180: frame init $00179E: controller_poll $00B09E: animat

$00509E  Frame Orchestrator (12 Subroutines, 2 Entry Points)  [Game / Scene]
         Two entry points: Entry 1 ($509E): Full orchestrator — calls 12 subroutines (init, scene logic, animation, frame update, sprite processing), increm...
         mod:D0, D3, D7, A1, A2 | calls:$00179E: poll_controllers $0021A4: init handler A $006496: s

$005100  race_scene_init_005100                            [Game / Race]
         Race Scene Initialization (Grand Prix) Initializes a Grand Prix race scene.
         in:Called as scene init orchestrator | mod:D0, D1, A0, A1, A2, A5 MARS: adapter_ctr

$005308  State Dispatcher (5-Entry Jump Table + 5 Subroutines)  [Game / State]
         Dispatches via 5-entry longword jump table indexed by state_dispatch_idx ($C87E).
         mod:D0, A0, A1, A6 | calls:$0020D6: init handler $0028C2: VDPSyncSH2 $00B02C: frame_upd

$005348  Call Subs + Advance Game State + Set Frame Delay  [Game / Menu]
         Calls two sub-routines ($00210A and animation_update at $00B09E), then advances the main game state by 4 and sets frame delay to $0010.
         in:none | Exit: state advanced | Uses: none

$00535E  Frame Orchestrator (9 Subroutines + Controller Tail-Jump)  [Game / Scene]
         Two entry points: Entry 1 ($00535E): Full frame — calls 9 subroutines (init, controllers, animation, 2 updates, 2 setups, sprite+object).
         mod:D0, D2, A0, A1, A2, A6 | calls:$00179E: poll_controllers $0020D6: init handler (from $00212

$0053B0  race_scene_init_0053b0                            [Game / Race]
         Race Scene Initialization (Free Run) Initializes a Free Run / Time Attack race scene.
         in:Called as scene init orchestrator | mod:D0, D1, A0, A2, A5 MARS: adapter_ctrl, C

$005586  State Dispatcher (4-Entry Jump Table)             [Game / State]
         Dispatches via 4-entry longword jump table indexed by state_dispatch_idx ($C87E).
         mod:D0, A0, A1 | calls:$0021CA: sfx_queue_process $0028C2: VDPSyncSH2 $0058C8: spri

$0055BA  SFX Queue + Sprite Check + Advance Game State     [Game / Menu]
         Calls sfx_queue_process ($0021CA) and sprite_update_check ($005908), then advances the main game state by 4 and sets frame delay to $0010.
         in:none | Exit: state advanced | Uses: none

$0055D0  Frame Update Orchestrator (7 Subroutines + Scene Tick)  [Game / Scene]
         Calls 7 subroutines via bsr.
         mod:D0 (from called routines) | calls:$0021CA: sfx_queue_process $00179E: controller_poll $00593C:

$0055FE  Process SFX + Poll Controllers + Advance Frame    [Game / Race]
         Calls SFX queue process ($0021CA), poll controllers ($00179E), and sub at $00BAD4.
         in:none | Exit: controllers polled, frame advanced | Uses: none

$005618  State Dispatcher (5-Entry Jump Table + 4 Subroutines)  [Game / State]
         Dispatches via 5-entry longword jump table indexed by state_dispatch_idx ($C87E).
         mod:D0, D6, A0, A1, A6 | calls:$0021CA: sfx_queue_process $0028C2: VDPSyncSH2 $0058C8: spri

$005658  Call 4 Subs + Advance Game State                  [Game / Menu]
         Calls SFX queue process ($0021CA), two game subs ($00B02C, $00B632), and sprite_update_check ($005908).
         in:none | Exit: game state advanced | Uses: none

$005676  Frame Orchestrator (8 Subroutines, 2 Entry Points, Controller Decode)  [Game / Scene]
         Entry 1 ($5676): calls sfx, poll_controllers, 2 sprite handlers, increments scene_state, reads controller byte from RAM pointer ($C8C0), decodes to...
         mod:D0, D1, A0 | calls:$00179E: poll_controllers $0021CA: sfx_queue_process $00593C

$0056E4  Pause Menu Handler + Controller Check             [Game / State]
         Three entry points: Entry 1 ($0056E4): BCLR bit 7 of $FDA8, tail-jump to $00D48A.
         mod:D0 | calls:$0049AA: SetDisplayParams $00D48A: pause handler (tail-jump 

$00573C  State Dispatcher (4-Entry Jump Table, Variant B)  [Game / State]
         Calls sfx_queue_process, increments $A510 tick counter, then dispatches via 4-entry longword jump table indexed by sub_state ($C8C4).
         mod:D0, A0, A1 | calls:$0021CA: sfx_queue_process $0028C2: VDPSyncSH2

$005772  Counter Increment and Set Display Size            [Display]
         Advances sub-state counter by 4 and sets display viewport size.
         in:none | mod:none

$005780  State Dispatcher + Controller Poll + Sprite Update  [Game / State]
         Calls poll_controllers, advances sub_state ($C8C4) by 4, writes $44 to SH2 COMM.
         mod:D0, D2, A0, A1, A2, A6 | calls:$00179E: poll_controllers $00B684: object_update (tail-jump)

$0057CA  Advance Sub-Sequence Timer                        [Game / State]
         Increments the sub-sequence timer byte at $C8C5 by 4.
         in:none | Exit: timer updated | Uses: none

$0057D0  Controller Input Check + Start Button Handler     [Game / State]
         Two entry points: Entry 1 ($0057D0): increments $C8C5 by 4, tail-jumps to $00246C.
         mod:D0

$00581A  Set Timer Value (20)                              [Game / State]
         Sets timer/counter at $C8C5 to 20.
         in:none | mod:none

$005822  Sound Queue + Enable Flags + Advance State        [Game / Race]
         Calls the sound queue sub at $002474, enables SH2 flag ($C809), display mode flag ($C80A), sets sync bit 7 ($C80E), enables command flag ($C802), s...
         in:none | Exit: flags set, state advanced | Uses: none

$00584A  Flag Check, VDP Init, Clear Display Mode          [Game / State]
         Waits for SH2 completion, writes VDP register $8B00, clears display mode bytes, advances sub-state.
         in:A5 = VDP control port | mod:D0

$005866  SH2 Handler Dispatch + Scene Init                 [Game / Scene]
         Two code paths: (1) reads current SH2 handler address from $00FF0002, matches against 4 known values, replaces with corresponding new handler, then...
         mod:D0, D1, D4, D7, A0, A1, A4, A6 | calls:$002474: vint_init (JMP PC-relative) $002890: game_init (JMP

$0058EA  Object Table Lookup Loop (6 Iterations)           [Game / Entity]
         Masks D0 with $0130 — if non-zero, branches back to previous function.
         in:D0 = status bits | Exit: table processed | Uses: D0, D7, A0

$005908  SH2 Comm Check + Conditional Guard                [Game / Scene]
         Loads base address $A000 into A4, reads $C26C into D0.
         in:none | Exit: conditional return or fall-through | Uses: D0, 

$005926  Object Table Clear Loop                           [Game / Entity]
         If D0 has any bits in $0130 set, branches back (to caller's loop).
         in:D0 = status flags | Exit: table processed | mod:D0, D7, A0

$00593C  race_entity_update_loop                           [Game / Race]
         Race Entity Update Loop Per-frame update for race entities.
         in:A0 = entity base pointer | mod:D0, D1, D7, A0, A1, A2, A4, A6

$005AB6  entity_render_pipeline                            [Game / Render]
         Entity Render Pipeline Multi-variant entity render pipeline with 4 entry points.
         in:A0 = entity base pointer | mod:D0, A0

$005D08  player_entity_frame_update                        [Game / Entity]
         Player Entity Frame Update Per-frame player entity update.
         in:A0 = player entity pointer | mod:D0, A0, A1

$005DC8  entity_data_table_render_pipeline_variant         [Game / Render]
         Entity Data Table + Render Pipeline Variant ROM address lookup table (3 longword entries) followed by a render pipeline variant.
         in:A0 = entity base pointer | mod:D0, A0, A2, A6

$005E38  Game Frame Orchestrator                           [Game / Scene]
         Master frame orchestrator — initializes display params then calls 37 subroutines covering physics, steering, rendering, AI, palette, display mode, ...
         in:A0 = object/entity pointer | mod:D0, A0

$005EEA  entity_render_pipeline_with_vdp_dma               [Game / Render]
         Entity Render Pipeline with VDP DMA Extended entity render pipeline with VDP register writes and DMA transfers.
         in:A0 = entity base pointer | mod:D0, A0

$006200  Object State Dispatcher + Scene Transition        [Game / Scene]
         Dispatches via 2-entry jump table at $006240 (BEQ selects D0=0 or D0=4 based on Z flag from caller).
         mod:D0, A1

$006240  entity_render_pipeline_with_vdp_dma_2p_copy       [Game / Render]
         Entity Render Pipeline with VDP DMA + 2P Copy Multi-entry entity render pipeline with VDP register writes and DMA.
         in:A0 = entity base pointer | mod:D0-D7, A0, A1, A4, A6

$006496  gfx_2_player_entity_frame_orch                    [Game / Scene]
         2-Player Entity Frame Orchestrator Updates both player viewports in 2-player mode.
         in:Called from 2-player race frame loop | mod:D0-D7, A0, A1, A2, A3, A4

$00659C  entity_render_pipeline_jump_table                 [Game / Render]
         Entity Render Pipeline Jump Table Jump table (8 longword ROM addresses) followed by 4 render pipeline variants.
         in:A0 = entity base pointer | mod:D0, A0

$00671A  Race Init Orchestrator 005                        [Game / Race]
         Initializes race frame — calls 12 subroutines sequentially Sets up camera, loads params, runs steering/position/velocity calcs On frame 20 ($14): c...
         in:A0 = object/entity pointer | mod:D0, A0 | calls:$00B770: camera_state_selector (camera init) $0080CC: load_o

$00677A  entity_render_pipeline_with_2_player_dispatch     [Game / Render]
         Entity Render Pipeline with 2-Player Dispatch Large multi-entry entity render pipeline with 2-player dispatch.
         in:A0 = entity base pointer | mod:D0, D1, A0, A1, A4

$006A3A  Race Frame Update (State 7)                       [Game / Race]
         Race-mode frame update: calls camera selector, sets game_active, clears display offsets, then executes 12 subroutine calls for physics/steering/pos...
         in:A0 = object pointer (+$44, +$46, +$4A cleared) | mod:D0, A0, A1 | calls:$006F98: calc_steering (JSR PC-relative) $0070AA: angle_to_s

$006AB4  entity_data_table_full_render_pipeline            [Game / Render]
         Entity Data Table + Full Render Pipeline ROM address lookup table (3 longword entries) followed by a reduced render pipeline and a full render pipe...
         in:A0 = entity base pointer | mod:D0, A0, A2, A6

$006B96  Object Bitmask Table + Lookup                     [Game / Entity]
         40-byte data table of 10 bitmask pairs (powers of 2 from 1-512), followed by 3-instruction lookup: reads word index from $C07A, fetches word from o...
         mod:D0

$006BCA  Object Bitmask Table + Button Flag Handler        [Game / State]
         32-byte data table of 8 bitmask pairs (powers of 2 from 1-128), referenced by object_bitmask_table_lookup as lookup table.
         mod:D0

$006C08  Control Flag Check + Conditional Position Copy    [Game / State]
         Reads control flag ($C30E), checks bits 0 and 5.
         in:none | Exit: flag processed | Uses: D0

$006C26  Conditional Scroll State Init                     [Game / State]
         Reads scroll trigger ($C050).
         in:none | Exit: scroll state initialized or no-op | Uses: D0

$006C46  tile_block_dma_setup                              [Game / Render]
         Tile Block DMA Setup Sets up tile block data for DMA transfers.
         in:Called during scene initialization | mod:D5, D6, D7, A1, A2, A3, A4

$006C46  Sprite System Functions ($006C46 - $006D40)       [Graphics]
         Sprite table initialization and management.

$006C88  Button Bit Dispatcher (7 Bit Tests)               [Game / State]
         If SH2 buffer ($FF3000) == 0: calls sprite_table_init.
         mod:D0, D1 | calls:$006C46: sprite_table_init Branch targets (all past fn): $00

$006CDC  conditional_pos_add                               [Game / Physics]
         Conditional Position Add Calls condition check at $006D00, then adds D0 to (A1) if condition is met (Z flag clear).
         in:D0 = adjustment value, A1 = target address | mod:D0, A1

$006CE4  conditional_pos_subtract                          [Game / Physics]
         Conditional Position Subtract Calls condition check at $006D00, then subtracts D0 from (A1) if condition is met (Z flag clear).
         in:D0 = adjustment value, A1 = target address | mod:D0, A1

$006CEC  conditional_speed_add                             [Game / Physics]
         Conditional Speed Add Calls condition check at $006D00, then adds D0 to A1+$04 (speed field) if condition is met (Z flag clear).
         in:D0 = adjustment value, A1 = entity pointer | mod:D0, A1

$006CF6  conditional_speed_subtract                        [Game / Physics]
         Conditional Speed Subtract Calls condition check at $006D00, then subtracts D0 from A1+$04 (speed field) if condition is met (Z flag clear).
         in:D0 = adjustment value, A1 = entity pointer | mod:D0, A1

$006D30  Position Adjust Helpers                           [Object]
         Six tiny leaf functions for return values and position adjustment.
         mod:D0, D1 (position helpers use D0 on A0 en

$006D50  Object Position Table Lookup                      [Game / Entity]
         Increments object+$1C frame counter, multiplies by 4 (two ADD.
         in:A0 = object pointer | Exit: position updated | Uses: D0, A0,

$006D6E  Position Table Lookup (Decrement Counter)         [Game / State]
         Decrements object frame counter at +$1C, then uses it as index into position table at ($C700) to update object X/Y position.
         in:A0 = object pointer | mod:D0, A2

$006D8C  steering_calc_reg_safe_wrapper                    [Game / Ai]
         Steering Calculation Register-Safe Wrapper Saves all 15 registers (D0-D7/A0-A6) to stack, calls calc_steering at $006F98, then restores all registers.
         in:A0 = entity base pointer (passed through to calc_steering) | mod:(all preserved)

$006D9C  race_frame_main_dispatch_entity_updates           [Game / Race]
         Race Frame Main Dispatch + Entity Updates Main race frame dispatch.
         in:A0 = entity base pointer | mod:D0, D1, D6, D7, A0, A1, A2, A3

$006F98  entity_pos_update                                 [Game / Physics]
         Entity Position Update — Heading-Based Movement Computes entity X/Y position delta from heading angle and speed using sine/cosine lookups.
         in:A0 = entity base pointer | mod:D0, D2, D3, D4, D5, D6, A0

$006FFA  Counter Guard                                     [Object]
         Decrements a counter at A0+$92, tests object type field at A0+$06.
         in:A0 = object pointer | mod:none (only modifies A0+$92) Fields acces

$007008  Camera Position Smoothing                         [Object]
         Smooths camera/entity position using interpolation and trig-based movement.
         in:A0 = entity/camera object | mod:D0-D3, D6 Fields accessed: A0+$1E: Targe

$007084  Position Velocity Update                          [Object]
         Applies velocity components to object position fields.
         in:A0 = object pointer | mod:D0 Fields accessed: A0+$30: Position X (

$0070AA  Trigonometry Lookup Functions ($0070AA - $007148)  [Math]
         High-frequency sine/cosine lookup and velocity calculations for objects.

$00714A  Object Link Copy + Table Lookup                   [Game / Entity]
         Follows object link (A0+$CE → A1), copies type byte A1+$1B to A0+$1D.
         mod:D0, D1, A0, A1, A2

$0071A6  object_visibility_collector                       [Game / Render]
         Object Visibility Collector Computes a camera direction key from an object's own x/y positions (+$30/+$34) and collects visible geometry entries in...
         in:A0 = object pointer (+$30=x_pos, +$34=y_pos, +$CA=cam_key, + | mod:D0, D1, D2, D3, D4, D7, A0, A1, A2, A3, 

$0071A6  Screen Coordinate Calculation Functions ($0071A6 - $007246)  [Graphics]
         Calculates screen coordinates for 3D objects, mapping world positions to 2D screen locations for rendering.

$007248  vdp_nametable_setup_display_list_build            [Game / Render]
         VDP Nametable Setup + Display List Build Configures VDP nametable addresses (scroll A at $C000, scroll B at $E000) and scroll mode via register wri...
         in:A5/A6 = VDP register write ports | mod:D0, D4, A2, A5, A6

$007270  Frame Buffer Setup                                [Vdp]
         Loads frame buffer base address into A2, calls a setup subroutine, then stores D4 to a frame buffer control register.
         in:D4 = value to store | mod:A2 | calls:Subroutine at $7280 (via BSR.S)

$007280  track_tile_object_display_list_builder            [Game / Render]
         Track Tile Object Display List Builder Builds display list of visible track objects.
         in:A0 = entity pointer, A2 = display list write pointer | mod:D0, D1, D2, D3, D4, D6, D7, A0, A1, A3, 

$00734E  Object Geometry Visibility Collect                [Game / Render]
         Builds a visible-object list for the current viewpoint.
         in:A0 = object pointer (reads +$CC for segment index) | mod:D0, D1, D2, D3, D4, D7, A0, A1, A2, A3, 

$0073E8  Track Data Index Computation + Table Lookup       [Game / Track]
         Computes track segment index from D1/D2 velocity components and D3 base offset.
         mod:D0, D1, D2, D3, D4, D5, A0, A1, A2

$00748C  Angle Normalize and BSP Visibility Test           [Math]
         Normalizes viewing angles to a 512-step rotation system and performs BSP-style visibility testing for polygon culling.
         in:D1 = viewing angle 1, D2 = viewing angle 2, A1 = BSP data pt | mod:D0-D7, A1-A2 Dependencies: None (pure ma

$00748C  Angle Normalization and Visibility Functions ($00748C - $0075D2)  [Math]
         Normalizes angles to a 512-step rotation and performs BSP-style visibility testing for polygon culling.

$0075C8  Plane Evaluation Pair                             [Math]
         Two BSP plane evaluation helpers for visibility testing.
         in:D1 = normalized angle 1, D2 = normalized angle 2, A2 = plane | mod:D1, D2 Fields accessed: A2+$12: Plane co

$0075FE  Object Distance Calculation                       [Object]
         Computes distance value and stores at A0+$CC.
         in:A0 = object pointer | mod:D0 Fields accessed: A0+$3C: Base positio

$007624  Conditional Object Velocity Negate                [Game / Physics]
         If the word at $C0BA is nonzero, loads the word at $C0C2, negates it, and stores the result into object+$CC.
         in:A0 = object pointer | Exit: object+$CC set or falls through | mod:D0, A0

$007636  Calculate Object Heading Composite                [Game / Physics]
         Computes a heading value: ($C0CA + $C0B0) * 8 + object+$3C + object+$96, storing the result in object+$CC.
         in:A0 = object pointer | Exit: +$CC updated | Uses: D0, A0

$00764E  rotational_offset_calc                            [Game / Collision]
         Rotational Offset Calculation Computes rotational offsets for billboard rendering.
         in:A0 = entity base pointer | mod:D0, D2, D3, D4, D5, A0

$0076A2  Track Data Extract 033                            [Game / Track]
         Extracts signed byte pairs from 3D track data pages Reads from 3 pages ($800 apart) into work buffer fields
         in:D0 = track segment index (pre-shifted) | mod:D0, D2, A1, A2

$007700  collision_response_surface_tracking               [Game / Collision]
         Collision Response + Surface Tracking Iterative collision response with surface tracking.
         in:A0 = entity base pointer | mod:D0, D1, D2, D3, D4, D5, D6, D7

$00789C  track_boundary_collision_detection                [Game / Collision]
         Track Boundary Collision Detection Probes 4 points around entity for track boundary collisions.
         in:A0 = entity base pointer, A4 = scratch buffer pointer | mod:D0, D1, D2, A0, A1, A2, A3, A4

$007A40  object_type_dispatch                              [Game / State]
         Object Type Dispatch Reads object type from A2+$18 (low 4 bits), multiplies by 4 for longword index, dispatches through 14-entry jump table.
         in:A2 = object pointer (tile data) | mod:D0, D5, A1, A2

$007A8E  object_type_return_007a8e                         [Game / Entity]
         Object Type Return — Type 2 Returns constant 2 in D0.
         in:(from jump table dispatch) | mod:D0

$007A92  Increment Object Counter + Return $04             [Game / State]
         Increments the object pending counter at $C31A and returns D0 = $04.
         in:none | Exit: D0 = $04 | Uses: D0

$007A9A  Increment Object Counter + Return $08             [Game / State]
         Increments the object pending counter at $C31A and returns D0 = $08.
         in:none | Exit: D0 = $08 | Uses: D0

$007AA2  Increment Object Counter + Return $10             [Game / State]
         Increments the object pending counter at $C31A and returns D0 = $10.
         in:none | Exit: D0 = $10 | Uses: D0

$007AAA  object_type_return_007aaa                         [Game / Entity]
         Object Type Return — Type 2 (B) Returns constant 2 in D0.
         mod:D0

$007AAE  object_type_return_007aae                         [Game / Entity]
         Object Type Return — Type 2 (C) Returns constant 2 in D0.
         mod:D0

$007AB2  entity_heading_init                               [Game / Physics]
         Entity Heading Initialization Initializes entity heading angles.
         in:A0 = entity base pointer | mod:D0, D1, A0

$007AD6  directional_collision_probe                       [Game / Collision]
         Directional Collision Probe Probes for collisions in the entity's heading direction.
         in:A0 = entity base pointer, A4 = scratch buffer pointer | mod:D0, D1, D2, A0, A1, A2, A3, A4

$007BAC  Visibility Evaluation Caller                      [Object]
         Loads object position, calls angle normalization and BSP visibility test.
         in:A0 = object pointer, A2 = BSP data pointer (set by caller) | mod:D0-D2, A2 Fields accessed: A0+$30: Posit

$007BE4  object_type_dispatch_b                            [Game / State]
         Object Type Dispatch B Reads object type from A2+$18 (low 4 bits), multiplies by 4 for longword index, dispatches through 14-entry jump table.
         in:A2 = object pointer (tile data) | mod:D0, D6, A1, A2

$007C32  object_type_return_007c32                         [Game / Entity]
         Object Type Return — Type 2 (D) Returns constant 2 in D0.
         mod:D0

$007C36  object_type_return_007c36                         [Game / Entity]
         Object Type Return — Type 4 Returns constant 4 in D0.
         mod:D0

$007C3A  object_type_return_007c3a                         [Game / Entity]
         Object Type Return — Type 8 Returns constant 8 in D0.
         mod:D0

$007C3E  object_type_return_007c3e                         [Game / Entity]
         Object Type Return — Type 16 Returns constant $10 (16) in D0.
         mod:D0

$007C42  object_type_return_007c42                         [Game / Entity]
         Object Type Return — Type 2 (E) Returns constant 2 in D0.
         mod:D0

$007C46  object_type_return_007c46                         [Game / Entity]
         Object Type Return — Type 2 (F) Returns constant 2 in D0.
         mod:D0

$007C4A  entity_speed_guard                                [Game / Physics]
         Entity Speed Guard Guard function with data prefix (4 bytes).
         in:A0 = entity base pointer | mod:D0, A0

$007C56  Tire Screech Sound Trigger 053                    [Game / Physics]
         Checks 4 collision/contact channels and triggers screech sound Each channel: tests cooldown timer, checks contact bit, sets 15-frame timer Only que...
         in:A0 = object/entity pointer | mod:D2, A0

$007CD8  Multi-Flag Test                                   [Object]
         ANDs four flag bytes together and tests bit 1 of the result.
         in:A0 = object pointer | mod:D0, D1 Fields accessed: A0+$56: Flag byt

$007CF0  Collision Flag Check 054                          [Game / Collision]
         Checks collision conditions and sets object flags Tests speed threshold, lateral position, and collision state On collision: sets flag bits $1000/$...
         in:D0 = input flags; A0 = object/entity pointer | mod:D0, D1, A0 | calls:$007EA4: obj_collision_response (tail call via JMP) Object f

$007D56  Object Drift Check + SFX Trigger                  [Game / Physics]
         Plays SFX $B5 (skid sound).
         in:A0 = object pointer | mod:D0, A0

$007D82  Race State Read + Sound Trigger                   [Game / Race]
         Checks race_substate, handles camera state transitions, reads object position data, applies speed multiplier via shift lookup table, loads velocity...
         in:A0 = object pointer (+$14, +$24, +$8A, +$8C, +$E5) | mod:D0, D1, D6, A0, A1 | calls:$007EB8: speed_calc (JSR PC-relative) $00A1FC: race_state_re

$007E0C  Drift Init 057                                    [Game / Physics]
         Initiates drift/skid sequence when conditions met Checks race state, collision state, and speed threshold On trigger: computes drift direction, ang...
         in:D0 = current speed value; A0 = object/entity pointer | mod:D0, D1, A0 | calls:$007EA4: obj_collision_response (tail call via JMP) Object f

$007E74  Object Animation Timer + Speed Clear              [Game / Physics]
         6-byte data prefix ($0101 × 3, referenced externally).
         in:A0 = object pointer | mod:D0, D1, A0

$007EA4  Conditional Return on State Match                 [Game / State]
         Sets D1 = $14 (object type/size), then compares words at $C07A and $C098.
         in:none | Exit: D1 = $14, returns if match | mod:D1, D4

$007EB2  Object Movement Velocity Computation              [Game / Physics]
         Computes per-frame velocity for position interpolation.
         mod:D0, D1, D2, D3, A0, A1

$007EFC  Object Heading Deviation Check + Warning Flag     [Game / Physics]
         Two entry points (A2 selects VDP target): Entry 1 ($007EFC): A2 = $FF6940 Entry 2 ($007F04): A2 = $FF6930 Computes heading_mirror (A0+$3C) - headin...
         mod:D0, A0, A2

$007F50  Position Threshold Check                          [Object]
         Compares difference of two position fields against threshold 100.
         in:A0 = object pointer | mod:D0 Fields accessed: A0+$24: Position val

$007F64  Lap Complete Check 062                            [Game / Race]
         Processes lap completion and race finish conditions Increments checkpoint counter, checks lap vs total_laps On race finish: sets flags, timer, and ...
         in:D0 = speed/proximity value; A0 = object/entity pointer | mod:D0, D1, A0

$007FDA  Clear Object Flags + Reset State                  [Game / State]
         Clears bit 14 of the object flags at A0+$02, then zeroes out state variable $C04E and flag byte $C305.
         in:A0 = object pointer | Exit: flags/state reset | Uses: A0

$007FEE  Conditional Set State Byte from Object Comparison  [Game / State]
         Compares D0 with object+$2D.
         in:A0 = object pointer, D0 = comparison value

$008004  Object Position Compare + Flag Set                [Game / State]
         Compares object fields $2C/$2E (current/target position).
         in:A0 = object pointer | mod:D0, A0

$008032  Input Guard + Conditional Decrement               [Game / State]
         Guards against large position differences.
         in:A0 = object pointer | mod:D0

$008054  Object Scoring + Lap Advance Check                [Game / Race]
         Mid-function entry: if D0 >= $FF9C (-100) → returns to caller.
         mod:D0, D1, A0

$0080AE  Triple-Guard Set State to $BE                     [Game / State]
         Compares D0 with object+$2D.
         in:A0 = object, D0 = comparison value | Exit: state set | Uses:

$0080CC  Field Check Guard                                 [Object]
         Loads A0+$8C into D2.
         in:A0 = object pointer | mod:D2 Fields accessed: A0+$8C: Guard field 

$0080D6  Object Camera Position Update                     [Game / Camera]
         Updates object camera/position state from ROM parameter table.
         in:A0 = object pointer, D2 = table index | mod:D0, D2, A0, A1

$008170  Object Timer Expire + Speed Parameter Reset       [Game / Physics]
         Decrements object timer (A0+$62).
         mod:D0, A0

$008200  Display State Timer + Flag Update                 [Game / State]
         ANDs -(A4) with D4 (flag check); if result nonzero writes $BF to $C8A4 (SFX).
         mod:D0, D4, A0, A4

$008246  Table Lookup                                      [Game / Race]
         Object Field to Race State Byte Uses the word at object+$2C as an index into a lookup table immediately following this function ($008256+), and sto...
         in:A0 = object pointer | Exit: table value stored | mod:D0, A0, A1

$008256  Object Flag Process + Conditional Clear           [Game / State]
         Data prefix (6 bytes: $85 $86 $87 $88 $89 $00), then object flag processing.
         in:A0 = object pointer | Exit: flags processed | Uses: A0

$008280  Timer Display Update 004                          [Game / State]
         Updates race timer display via num_to_decimal conversion Dispatches through jump table based on controller bits 6-7 Handles timer countdown with fl...
         in:A0 = object/entity pointer | mod:D0, D1, D6, D7, A0, A1 | calls:$00839A: num_to_decimal Jump table at digit_extraction_via_d

$0082E0  write_status_code_to_ram                          [Game / State]
         Write Status Code to RAM Stores D7 as the current status code at RAM $68F0.
         in:D7 = status code value | mod:D7

$0082E8  digit_extraction_via_division                     [Game / Hud]
         Digit Extraction via Division Data prefix (2 bytes) followed by a division chain.
         in:D1 = value to extract digits from, A0 = output buffer pointe | mod:D1, A0

$0082FA  3D Transform Setup 007                            [Game / Render]
         Sets up 3D transformation parameters for rendering Calls matrix/vector routines, computes composite index from state words Checks depth threshold (...
         in:A3 (clobbered), A4 = output pointer | mod:D0, D1, D2, D5, D6, A1, A2, A3 | calls:$00B3CE: matrix_multiply $00B386: vector_transform

$008368  three_way_value_comparison_router                 [Game / State]
         Three-Way Value Comparison Router Compares D5 with longword at (A3).
         in:D5 = value to compare, A3 = reference pointer, A4 = state ou | mod:D0, D1, D5, A3, A4

$00837A  object_state_assignment_00837a                    [Game / State]
         Object State Assignment — Less-Than Case Less-than handler for the three-way comparison (three_way_value_comparison_router).
         in:D5 = new speed value, A3 = source pointer, A4 = object point | mod:D0, D1, D5, A3, A4

$00838A  object_state_assignment_00838a                    [Game / State]
         Object State Assignment — Greater-Than Case Greater-than handler for the three-way comparison (three_way_value_comparison_router).
         in:D5 = new value, A3 = source pointer, A4 = object pointer | mod:D0, D1, D5, A3, A4

$00839A  Nibble Unpack (4 bytes to 7 nibbles)              [Util]
         Unpacks 4 bytes from (A4) into 7 nibble-separated bytes at (A1)+.
         in:A4 = source (4 bytes), A1 = destination (7 bytes) | mod:D1, D2, A1 (advances)

$0083BC  entity_flag_bit_test_guard                        [Game / Entity]
         Entity Flag Bit Test Guard Tests bit 6 of entity flags field +$02(A0).
         in:A0 = entity pointer | mod:A0

$0083C6  Object Spawn Counter + Table Setup                [Game / State]
         Loads and increments spawn counter ($A9E0), sets up table base addresses ($A9E3 → A1, $A800 → A2), then branches forward past this module to contin...
         in:A0 = object pointer | Exit: setup or guard | Uses: D0, A0-A2

$0083E4  dual_time_display_orch                            [Game / Scene]
         Dual Time Display Orchestrator Main time display handler for 1P and 2P modes.
         in:A0 = player 1 entity, A1 = player 2 entity | mod:D0, D1, D7, A0, A1, A2, A3 | calls:$00839A (num_to_decimal), $00B3CE, $00B3BC, $0084F4 (time_ar

$0084F4  time_array_entry_comparison                       [Game / State]
         Time Array Entry Comparison Compares indexed longword entries from two arrays (A2, A3).
         in:D1 = entry count, A2 = array 1 base, A3 = array 2 base | mod:D0, D1, D4, D5, A2, A3

$00850A  return_success_flag                               [Game / State]
         Return Success Flag Returns D0=1 (success/true).
         mod:D0

$00850E  fixed_point_threshold_state_marker                [Game / State]
         Fixed-Point Threshold State Marker Compares D5 against fixed-point threshold $60000000.
         in:D5 = fixed-point value, A4 = object pointer | mod:D0, D1, D5, A4

$008522  value_equality_check_with_state_clear             [Game / State]
         Value Equality Check with State Clear Compares D4 and D5.
         in:D4, D5 = values to compare, A4 = state output pointer | mod:D0, D1, D4, D5, A4

$008532  object_state_assignment_008532                    [Game / State]
         Object State Assignment — Not-Equal Case Not-equal handler paired with value_equality_check_with_state_clear.
         in:D4, D5 = values to store, A4 = object pointer | mod:D0, D1, D4, D5, A4

$008548  Timer Decrement Multi (8 Entity Timers)           [Game / State]
         Decrements 8 timer fields in entity (A0) if positive.
         in:A0 = entity | mod:none (modifies entity fields)

$00859A  Speed Degrade Calculation                         [Game / Physics]
         Calculates speed degradation for entity.
         in:A0 = entity | mod:D0, D1

$0085C4  Tire Squeal Check (1-Player)                      [Sound]
         Checks lateral speed and triggers tire squeal sound effect.
         in:A0 = entity | mod:D0

$008610  Tire Squeal Check (2-Player)                      [Sound]
         Two-player version of tire squeal check.
         in:none | mod:D0, D2

$008672  Proximity Zone Simple (Single Entity Pair)        [Game / Collision]
         Calculates proximity zone between entities (A0) and (A1).
         in:A0 = entity, A1 = target entity | mod:D2, D4, D5, D6

$0086C8  Proximity Zone Multi (Entity Loop with Camera Override)  [Game / Collision]
         Multi-entity proximity check with camera position override.
         in:A0 = entity | mod:D0-D7, A1

$00877A  Proximity Zone Loop (Fixed Thresholds)            [Game / Collision]
         Simplified proximity loop over 15 entities.
         in:A0 = entity | mod:D0-D7, A1

$0087E2  race_pos_comparison_with_sound_triggers           [Game / Race]
         Race Position Comparison with Sound Triggers Compares race positions of two entities (A0, A2) using segment/position indices.
         in:A0 = player 1 entity, A2 = player 2/AI entity | mod:D0, D1, D2, D3, D4, A0, A2 | calls:$008F4E (cosine_lookup), $008F52 (sine_lookup)

$0088BE  Camera View Toggle 020                            [Game / Camera]
         Toggles camera view mode and configures rendering parameters Button press (bits 5-6) toggles view flag When view active: computes zoom, scroll spee...
         mod:D0, D1, A0

$00896E  camera_state_disp_viewport_control                [Game / Camera]
         Camera State Dispatcher + Viewport Control Multi-state camera controller with acceleration/deceleration phases, button/flag checks, and a jump tabl...
         in:A0 = camera/entity pointer | mod:D0, D1, D2, D3, D4, D5, D6, D7

$008B28  State Handler Table + Init                        [Game / State]
         13-entry jump table for state handlers, followed by two 16-byte parameter blocks (data), then initialization code that clears camera/waypoint state...
         mod:D0, D2, D5, D6, D7, A0, A2, A3

$008B9C  Camera Direct Setup                               [Game / Camera]
         Direct camera parameter setup from stored configuration values.
         in:No register inputs | mod:D0

$008BC2  Camera Buffer Setup                               [Game / Camera]
         Camera setup reading from the parameter buffer at $C0C0.
         in:No register inputs | mod:D0, A1

$008BF2  Camera Simple Setup                               [Game / Camera]
         Simple camera setup from the $C0C0 parameter buffer.
         in:No register inputs | mod:D0, A1

$008C16  Camera Offset Setup                               [Game / Camera]
         Camera setup with elevation offset from $C0BC.
         in:No register inputs | mod:D0, A1

$008C40  Camera Parameter Init (Two-Level Dispatch)        [Game / Camera]
         Clears $C0BA, then dispatches via 3-entry word-offset table indexed by $C896 (two-level: load offset, then JMP).
         mod:D0, D6

$008CB0  Camera Scroll Update                              [Game / Camera]
         Increments camera scroll positions (pitch and yaw) by 8 each frame, then copies working values to viewport registers.
         in:No register inputs | mod:(none modified beyond RAM writes)

$008CCE  State Dispatcher + Register Copy Handler          [Game / State]
         Reads state index from $C896, dispatches via PC-relative word-offset jump table (4 entries for states 0/2/4/6).
         mod:D0 | calls:$00888DC0: shared exit

$008D06  Counter Check Flag                                [Game / State]
         Mode Advance Decrements a countdown counter at $C8F6.
         in:No register inputs | mod:(none modified beyond RAM writes)

$008D12  Camera Yaw Increment + Mirror to Viewports        [Game / Camera]
         Increments working yaw ($C894) by $0050, clamped at $EC0A.
         in:none | Exit: yaw incremented | Uses: none

$008D38  Camera Value Store Full                           [Game / Camera]
         Sets the working yaw to a fixed value ($EC0A), copies it to both viewport backup and shared memory, then advances the mode counter.
         in:No register inputs | mod:(none modified beyond RAM writes)

$008D52  Camera Value Store                                [Game / Camera]
         Copies the working yaw value ($C894) to both the viewport backup register ($C0BE) and the shared memory location ($00FF3028) for SH2 access.
         in:No register inputs | mod:(none modified beyond RAM writes)

$008D62  AI Steering Angle Calc 026                        [Game / Ai]
         Calculates steering angle from position delta + cosine lookup Calls ai_steering_calc, cosine_lookup, then computes final angle
         in:A0 = object/entity pointer | mod:D0, D1, D2, D3, A0 | calls:$00A7A0: ai_steering_calc $008F4E: cosine_lookup $00A7A4: ai

$008DC0  camera_angle_smoothing_with_trigonometry          [Game / Camera]
         Camera Angle Smoothing with Trigonometry Computes smoothed camera angles using ai_steering_calc for initial angle, then applies cosine/sine lookups...
         in:A0 = entity pointer | mod:D0, D1, D2, D3, A0 | calls:$008F4E (cosine_lookup), $008F52 (sine_lookup), $00A7A0 (ai_

$008EB6  AI Steering Calculation + Negate                  [Game / Ai]
         Calculates relative angle between viewport and object position, subtracts quarter turn ($4000), negates result → stores as heading in $C0C2.
         in:A0 = object pointer | mod:D0, D1, D2, D3 | calls:$00A7A0: ai_steering_calc (D0=refX, D1=refY, D2=objX, D3=obj

$008ED6  Calculate Relative Position + Negate              [Game / Physics]
         Computes relative position from object to viewport: loads object+$32 minus $C0BC (X offset), shifted right 4.
         in:A0 = object pointer | Exit: $C0C0 set | Uses: D0, D2, D3

$008EF4  Clear Camera Override                             [Game / Camera]
         Clears camera position override flag.
         in:none | mod:none

$008EFC  AI Steering Angle + Distance Computation          [Game / Ai]
         Computes AI steering angle: loads target position ($C0BA/$C0BE), calls ai_steering_calc ($00A7A0) with object position (A0+$30/$34).
         mod:D0, D1, D2, D3, A0 | calls:$008F4E: cosine_lookup $00A7A0: ai_steering_calc Object (A0)

$008F4E  sine_cosine_quadrant_lookup                       [Game / Physics]
         Sine/Cosine Quadrant Lookup Shared sine/cosine lookup with two entry points: $008F4E = cosine (adds 90° phase shift, falls through to sine) $008F52...
         in:D0 = angle (0-$FFFF = 0-360°) | mod:D0, D1, A1

$008F88  Sine Table Lookup                                 [Math]
         Looks up sine value from ROM table at $930000.
         in:D0.W = angle | mod:D0, A1

$008F9C  Cosine Table Lookup                               [Math]
         Looks up cosine value from ROM table at $930000.
         in:D0.W = angle | mod:D0, A1

$008FB0  Sine Negated Lookup (3rd Quadrant)                [Math]
         Looks up negated sine value (offset by -$400).
         in:D0.W = angle | mod:D0, A1

$008FC8  Arctangent Calculation (Segmented Table Lookup)   [Math]
         Segmented arctangent calculation using 3 ROM lookup tables.
         in:D0.L = input value (signed) | mod:D0, D1, D2, A1

$009040  Heading from Position                             [Game / Physics]
         Computes heading from entity position data.
         in:none | mod:D0

$009064  Scroll Pan Calculation + VDP Write                [Game / Render]
         If $C313 bit 3 clear: reads obj.
         in:A0 = object pointer | mod:D0, A0

$00909C  Clear Heading Register                            [Game / Physics]
         Clears heading register at $8000.
         in:none | mod:none

$0090A4  Heading with Camera Rotation                      [Game / Physics]
         Heading calculation with camera rotation offset from $C0B0.
         in:none | mod:D0

$0090CE  Heading Broadcast (Bulk Entity Fill)              [Game / Physics]
         Computes heading and writes to entity table via MOVEM bulk fill.
         in:A0 = entity, A1 = entity table destination | mod:D0-D7

$009124  Entity Position Init (Table Fill + Compare)       [Game / Entity]
         Initializes entity position table.
         in:A0 = entity | mod:D0, D1, D7, A1, A2

$009182  entity_speed_acceleration_and_braking             [Game / Physics]
         Entity Speed Acceleration and Braking Manages entity longitudinal speed using acceleration/braking tables at $0088A1F0 and $00939EDE.
         in:A0 = entity pointer | mod:D0, D1, D2, A0, A1

$009300  entity_force_integration_and_speed_calc           [Game / Physics]
         Entity Force Integration and Speed Calculation Integrates forces on entity: computes drag from speed tables, applies directional force from param $...
         in:A0 = entity pointer | mod:D0, D1, D2, D3, A0, A1, A2

$009458  Speed Calculation + Multiplier Chain              [Game / Physics]
         Computes effective speed ($0016) from velocity index ($0004) via ROM lookup table, applies MULS scaling by track_speed_factor, then applies ×6 mult...
         in:A0 = object/entity pointer | mod:D0, D1, A0, A1 | calls:$009B32: wind_resistance_calc

$0094F4  steering_input_processing_and_velocity_update     [Game / Physics]
         Steering Input Processing and Velocity Update Data prefix (2 bytes) at start.
         in:A0 = entity pointer | mod:D0, D1, D2, D3, A0, A1

$00961E  Tilt Adjust (Entity Banking)                      [Game / Physics]
         Adjusts entity tilt for banking.
         in:A0 = entity | mod:D0, D1

$009688  drift_physics_and_camera_offset_calc              [Game / Camera]
         Drift Physics and Camera Offset Calculation Computes lateral drift from steering velocity +$8E, applies speed-based scaling with sine lookup, updat...
         in:A0 = entity pointer | mod:D0, D1, D2, D3, A0 | calls:$008F52 (sine_lookup)

$009802  Suspension Steering Damping                       [Game / Ai]
         Dispatches via 3-entry jump table indexed by race_substate_b.
         in:A0 = object pointer (+$4C, +$62, +$88, +$92, +$94, +$96) | mod:D0, D1, D4, A0, A1, A2

$00987E  lateral_drift_velocity_processing_00987e          [Game / Physics]
         Lateral Drift Velocity Processing (A) Processes lateral drift/slide physics.
         in:A0 = entity pointer | mod:D0, D1, D2, A0

$0099AA  lateral_drift_velocity_processing_0099aa          [Game / Physics]
         Lateral Drift Velocity Processing (B) Variant of lateral_drift_velocity_processing_00987e with speed-dependent grip reduction and AI boost.
         in:A0 = entity pointer | mod:D0, D1, D2, D6, D7, A0

$009B12  Entity Speed Clamp                                [Game / Entity]
         Clamps entity speed to max, multiplies by $48, stores result.
         in:A0 = entity | mod:D0

$009B32  Speed Modifier (Conditional Scaling)              [Game / Physics]
         Applies speed modification based on ($C31A).
         in:A0 = entity | mod:D0, D1 (preserved)

$009B54  Set Camera Registers to Invalid ($FFFF)           [Game / Camera]
         Sets 3 camera registers to $FFFF unconditionally.
         mod:D0

$009B82  tire_animation_and_smoke_effect_counters          [Game / Render]
         Tire Animation and Smoke Effect Counters Updates tire/wheel animation and smoke effect counters.
         in:A0 = entity pointer | mod:D0, D1, A0

$009C9C  race_pos_sorting_and_rank_assignment              [Game / Race]
         Race Position Sorting and Rank Assignment Data tables (50 bytes) at start, then race position sorting logic.
         in:A0 = player entity pointer | mod:D0, D1, D2, D3, D4, D5, D6, D7, A0-A3

$009DD6  depth_sort                                        [Game / Render]
         Depth Sort (Bubble Sort by Priority + Direction Tie-Break) Sorts a 16-element array of 4-byte entries using bubble sort.
         in:A0 = sort array (16 entries × 4 bytes: word key + word obj_p | mod:D0, D1, D2, D7, A0, A1, A2, A3 Object fi

$009E5A  timer_decrement_and_rank_check_guard              [Game / State]
         Timer Decrement and Rank Check Guard Decrements timer +$A8 if nonzero.
         in:A0 = entity pointer | mod:A0

$009E6E  Proximity Trigger (Cooldown Timer)                [Game / Collision]
         Proximity trigger with cooldown.
         in:A0 = entity | mod:D0, D1, A1

$009EC0  race_start_countdown_sequence                     [Game / Race]
         Race Start Countdown Sequence Multi-phase race start countdown dispatcher.
         mod:D0, D6, D7, A0, A1

$00A050  Race Parameter Block Load + Table Pointer Setup   [Game / Race]
         Loads 15 parameter words + 1 longword from data table at $00898824 into RAM block $C278.
         mod:D0, D1, A1

$00A0B4  track_physics_param_table_loader                  [Game / Physics]
         Track Physics Parameter Table Loader Data prefix (144 bytes of track configuration data) followed by parameter loader.
         mod:D0, D1, A0, A1

$00A200  Physics Lookup Tables Module                      [Game / Physics]
         Contains: - physics_lookup_accessor: Index calculation function for table access - Acceleration/speed lookup tables - Sine/cosine table (64 entries...

$00A350  Effect Timer Management                           [Game / State]
         Manages animation effect timers using sine table lookups.
         in:A0 = object/entity pointer | mod:D0, A1 Fields accessed: A0+$02: Flag wor

$00A3BA  Speed Calculation (Table-Based)                   [Game / Physics]
         Reads speed value from lookup table, optionally divides by 4 based on a RAM flag, then applies a speed boost if effect timer is active.
         in:A0 = object/entity pointer | mod:D0, A1 Fields accessed: A0+$04: Speed ta

$00A3EA  Speed Interpolation (Table-Based with Clamping)   [Game / Physics]
         Gradually adjusts speed toward a target value read from a lookup table.
         in:A0 = object/entity pointer | mod:D0, D1, A1 Fields accessed: A0+$04: Spee

$00A434  AI Opponent Select                                [Game / Ai]
         Conditionally activates AI opponent targeting based on game mode, entity speed class, game state, and cooldown timer.
         in:A0 = object/entity pointer | mod:D0 Fields accessed: A0+$04: Speed table 

$00A666  Physics Integration                               [Game / Physics]
         Computes distance to target, derives a steering factor, calls ai_steering_calc to get a target heading angle, then smoothly interpolates toward it.
         in:A0 = object/entity pointer ($A000).W = target X coordinate ( | mod:D0, D1, D2, D3, D6 | calls:ai_steering_calc ($A7A0), sine_lookup ($8F52), cosine_lookup

$00A7A0  AI Steering Calculation                           [Game / Ai]
         Computes a steering angle from relative position deltas using an arctangent approximation.
         in:D0 = entity Y position, D1 = entity X position D2 = target Y | mod:D0, D1, D2, D3, D6 (preserved via stack) | calls:atan2_lookup ($8FC8)

$00A7E2  Entity Table Load (Mode-Based)                    [Game / Entity]
         Loads entity data from a ROM speed/attribute table into RAM entity entries.
         mod:D0, A1, A2

$00A80A  Entity Table Load (Mode+Index Combined)           [Game / Entity]
         Loads entity data from a RAM lookup table into entity entries, using a combined mode and secondary index to select the table offset.
         mod:D0, D1, A1, A2

$00A83E  Bulk Table Copy (Two ROM Blocks to RAM)           [Game / Data]
         Copies two ROM data blocks to RAM during initialization: Block 1: 288 bytes from $00937E7E to ($FAD8).
         mod:D0, A1, A2

$00A8F8  Object State Return                               [Game / Entity]
         Computes or interpolates a position value for an entity.
         in:A0 = object/entity pointer | mod:D0, D1, A1 Fields accessed: A0+$04: Spee

$00A972  ai_entity_main_update_orch                        [Game / Ai]
         AI Entity Main Update Orchestrator Main per-frame update for AI entities.
         in:A0 = AI entity pointer | mod:D0, D1, D2, D3, D4, D5, A0, A1 | calls:$003C7E (player_table_setup), $006FDE (position_update), $00

$00AC3E  Effect Countdown                                  [Game / State]
         Manages an effect countdown timer at ($C8AE).
         in:A0 = object/entity pointer | mod:D0, A1 Fields accessed: A0+$AC: Entity e

$00ACC0  Race Mode Flag Set                                [Game / Race]
         Sets flag at $FF6970 based on bit 2 of ($C8AB).
         mod:D0

$00ACD4  AI Target Check                                   [Game / Ai]
         Checks entity conditions then calls a validation routine for two entity slots.
         in:A0 = object/entity pointer | mod:D0, A1 Fields accessed: A0+$6A: Timer (m | calls:validation routine at $ADC4 (via JSR PC-relative) Note: BNE.

$00AD14  Entity Target Action                              [Game / Entity]
         Chained from ai_target_check via BNE.
         in:A0 = object, A1 = entity target (from ai_target_check) | mod:D0-D3 Fields accessed: A0/A1+$02: Status

$00ADC4  Proximity Distance Check                          [Game / Collision]
         Checks 3D proximity between two entities (A0, A1).
         in:A0 = entity A, A1 = entity B (from entity_target_action chai | mod:D0 Fields accessed: A0/A1+$30: Position 

$00AE06  Zone Check Inner                                  [Game / Collision]
         Angle-Based Visibility Chained from proximity_distance_check via JMP when entities are close.
         in:A0 = entity A, A1 = entity B | mod:D0-D7, A2

$00AED8  Entity Directional Push                           [Game / Entity]
         Applies a fixed directional offset ($18 = 24 units) to entity X/Y position based on 4 direction bits in A0+$88: Bit 0: X += D1, Y -= D1  (push righ...
         in:A0 = object/entity pointer | mod:D0, D1 Fields accessed: A0+$30: X positi

$00AF18  Object Collision Detection                        [Game / Collision]
         Checks collision between two objects (A0 = player, A1 = $9F00).
         in:A0 = player object, A1 = opponent (loaded from $9F00) | mod:D0, D1, D2, D3, A0, A1 | calls:$00AE0A: proximity_check (returns Z=1 if no collision) $00AF

$00AFC2  Close Position Flags                              [Game / Collision]
         Stores speed param D1 to A0+$06, then sets status flag bits based on direction flags in A0+$88 (same logic as entity_target_action .
         in:A0 = entity, A1 = target, D1 = speed param value | mod:D0, D1 Fields accessed: A0+$02: Status f

$00AFFE  Position Separation                               [Game / Collision]
         Pushes two entities apart by 16 units on both X and Y axes.
         in:A0 = first entity, A1 = second entity | mod:D0, D1 Fields accessed: A0+$30: X positi

$00B02C  Speed Scale Simple                                [Game / Physics]
         Loads a value from RAM ($FF907E), scales it via speed_scale_calc, and stores the result to $FF674C.
         mod:D0, D1 | calls:speed_scale_calc (via BSR.S)

$00B03C  Speed Scale Conditional                           [Game / Physics]
         Conditionally scales two speed values based on flag bits: If bit 5 of ($C30E).
         mod:D0, D1 | calls:speed_scale_calc (via BSR.S)

$00B06A  Speed Scale Calculation                           [Game / Physics]
         Converts a raw distance/speed value to a scaled result: 1.
         in:D0.W = raw value | mod:D0, D1

$00B094  Cascaded Frame Counter (Two Entry Points)         [Game / State]
         Two entry points (A0 selects counter block, D0 = flags byte): Entry 1 ($B094): A0 = $C813, D0 = $B4EE Entry 2 ($B09E): A0 = $C806, D0 = $C30E If D0...
         mod:D0, A0

$00B0DE  AI Timer Increment (Dual Counter with Carry)      [Game / Ai]
         Two entry points that share increment logic at $00B0F2: Entry 1 ($00B0DE): A0→$A9E7, D0 from $B4EE → BSR to shared, then falls into entry 2.
         mod:D0, A0

$00B11A  AI Buffer Setup (4 Entry Points)                  [Game / Ai]
         Four entry points that set up A1 (buffer), A2 (RAM pointer), and D3 (parameter), then branch to shared handler at $00B15E.
         mod:D0, D3, A1, A2

$00B15E  sequence_data_byte_decoder                        [Game / Sound]
         Sequence Data Byte Decoder Decodes 3 bytes from sequence stream (A2) into display/sound format.
         in:D3 = output offset, A1 = output buffer, A2 = source stream | mod:D0, D1, D3, A0, A1, A2

$00B1B8  AI Digit Lookup + Best Lap                        [Game / Ai]
         Looks up 3 digit values from ROM tables and writes them to a per-racer display buffer at ($C200 + racer*4).
         in:(none — reads racer index from $902C) | mod:D0, D3, A1, A3 | calls:$00B2EC, $00B422, $00B260 ROM tables: $00899884: digit_looku

$00B25E  BCD Scoring Calculation                           [Game / Hud]
         Reads 4 seed bytes + 18 groups of 4 params from a RAM buffer at $C200.
         mod:D0, D1, D2, D3, D4, D5, D6, D7

$00B2D8  AI Table Lookup + Conditional Fall-through        [Game / Ai]
         Data prefix (12 bytes), then loads object+$2C index, computes table offset (index-1)*4 from AI table base ($C200).
         in:A0 = object pointer | Exit: conditional | Uses: D0, D3, A0, 

$00B2FC  BCD Time Update 010                               [Game / Hud]
         Updates BCD time counter (MM:SS:FF format) Reads speed factor from lookup table, scales by obj speed Subtracts BCD delta from time digits using SBC...
         in:A0 = object/entity pointer; A1 = BCD time buffer (4 bytes: [ | mod:D0, D1, D2, A0, A1, A3

$00B36E  AI Parameter Lookup + Threshold Check (Data Prefix)  [Game / Ai]
         24-byte data table of 12 parameter words indexed by race_state, followed by lookup code: adds race_state ($C8A0) to entry D0, fetches parameter fro...
         in:D0 = base index (word offset), A1 = object pointer | mod:D0, A0, A1

$00B398  AI Parameter Lookup + Threshold Check (Data Prefix, Variant B)  [Game / Ai]
         36-byte data table of 18 parameter words indexed by race_state, followed by lookup code: adds race_state ($C8A0) to entry D0, fetches parameter fro...
         in:D0 = base index (word offset), A1 = object pointer | mod:D0, A0, A1

$00B3CE  sequence_data_word_decoder                        [Game / Sound]
         Sequence Data Word Decoder Decodes 3 bytes from sequence stream (A1) into word-sized output (A2).
         in:A1 = source stream, A2 = output buffer | mod:D0, A1, A2, A3

$00B40E  sound_buffer_copy_with_decode                     [Game / Sound]
         Sound Buffer Copy with Decode Loads decode buffer A3 from $FF68D8, calls shared decoder at $00B43C, then copies 8 bytes from decode buffer to sound...
         mod:A1, A3

$00B422  sound_buffer_copy_with_offset                     [Game / Sound]
         Sound Buffer Copy with Offset Variant of sound_buffer_copy_with_decode with D3-based offset into decode buffer $FF68D8.
         in:D3 = buffer entry index | mod:D3, A1, A3

$00B43C  word_to_nibble_unpacker                           [Game / Data]
         Word-to-Nibble Unpacker Unpacks two words from (A1) into individual nibble bytes at (A3).
         in:A1 = source word pointer, A3 = output nibble buffer | mod:D0, A1, A3

$00B478  bcd_nibble_subtractor                             [Game / Hud]
         BCD Nibble Subtractor Performs BCD subtraction on nibble pairs stored at (A4).
         in:A4 = nibble buffer pointer | mod:D0, D1, A4

$00B4CA  Display Digit Extract (Multi-Entry)               [Game / Hud]
         Multiple entry points for extracting BCD/display digits from various game values.
         mod:D0, D1, A0, A1, A2 | calls:$004920: data_copy (JMP PC-relative)

$00B55A  HUD Panel Config                                  [Game / Hud]
         Conditionally configures a HUD panel structure at $FF69E0.
         mod:D0, D1

$00B590  Conditional Return on Display Config Flag         [Game / State]
         Tests the display config flag at $C819.
         in:none | Exit: returns if flag set, falls through if clear | mod:none

$00B598  AI Data Load + Conditional Return on Flag         [Game / Ai]
         Loads shared memory pointer into A1, reads AI parameter from $9F2C, calls a sub-routine at $00B5B8, then tests bit 5 of the control flag at $C30E.
         in:none | Exit: returns if flag set | Uses: D0, A1

$00B5AE  Lap Display Update + VDP Tile Write               [Game / Race]
         Two entry points: Entry 1 ($00B5AE): Sets A1 → $FF689A, reads $902C (lap count), adds 1, doubles (×2), indexes table at $00899884 for display value...
         mod:D0, A0, A1

$00B604  AI Flag Setup at Object Array                     [Game / Ai]
         Initializes AI control flags at $FF68D0+D0 offset.
         in:D0 = offset into $FF68D0 array | mod:D0, A1

$00B632  Lap Value Store 1                                 [Game / Race]
         If flag ($C30F).
         mod:D0

$00B646  Lap Value Store 2                                 [Game / Race]
         If flag ($FEB0).
         mod:D0

$00B65A  SFX Dispatch + Object Update + Animation Sequence  [Game / Race]
         Three parts: 1) SFX dispatch ($B65A): sets $C802=1, calls dispatch_sfx ($B670) 3× with A2=$8480 work buffer.
         mod:D0, D1, A1, A2

$00B6D0  Animated Sequence Player (Byte Table + Counter)   [Game / Render]
         Data prefix: 10-byte descending sequence ($FF.
         mod:D0, D1, A1 | calls:$004846: sequence completion handler

$00B722  Animation Sequence Player (3-Word Data Prefix + Frame Loop)  [Game / Render]
         Data prefix: 3 words ($0102,$0304,$0506) — bit test masks.
         mod:D0, D1, D2, D3, D4, D6, D7, A0

$00B770  Camera State Selector                             [Game / Camera]
         Selects camera view based on button input.
         in:A0 = buffer selector ($9000 = alternate) | mod:D0, A0, A1, A2

$00B7E6  display_state_bit_10_guard                        [Game / Render]
         Display State Bit 10 Guard Tests bit 10 of D0.
         in:D0 = flags word | mod:D0

$00B7EE  camera_animation_state_disp                       [Game / Camera]
         Camera Animation State Dispatcher State machine for camera animation transitions.
         in:A0 = player entity, A2 = display object | mod:D0, D1, D2, D4, A0, A1, A2, A4

$00B964  AI Timer Decrement + Conditional State Clear      [Game / Ai]
         Calls sub at $00B990, clears AI active flag ($C31C), decrements the AI timer at $C303.
         in:none | Exit: timer decremented | Uses: none

$00B97A  AI Timer Decrement + State Clear + Reactivate     [Game / Ai]
         Calls sub at $00B990, decrements the AI timer at $C303.
         in:none | Exit: timer decremented | Uses: none

$00B990  Track Segment Load 031                            [Game / Track]
         Loads track segment data from ROM into work buffers Reads position pair via indexed table lookup Copies 5 longwords + 9 words from segment data to ...
         in:D0 = segment offset (added to base index) | mod:D0, A1, A2

$00BA1A  Triple Dispatch (3 Jump Tables by Controller Byte)  [Game / State]
         Three sequential dispatches, each loading a controller byte ($C86C/$C86D/$C86E), multiplying by 4 (D0×2×2), indexing into a longword jump table at ...
         mod:D0, A1

$00BA5E  scene_menu_init_and_input_handler                 [Game / Scene]
         Scene Menu Initialization and Input Handler Two-phase function: initialization clears camera state, counters, entity rank, and configures animation...
         in:A0 = entity pointer (during init) | mod:D0, A0

$00BC1C  scene_command_disp                                [Game / Scene]
         Scene Command Dispatcher Data prefix with 5 BRA.
         in:A0 = scene data pointer, A1 = display object | mod:D0, D6, A0, A1, A6

$00BCCA  Reset Scene and Menu State                        [Game / Menu]
         Clears the scene state ($C8AA) and menu sub-state ($C084), then sets the state variable at $C07A to $001C.
         in:none | Exit: states reset | Uses: none

$00BCDA  Clear State + Copy Scroll Data from Object        [Game / State]
         Clears scene_state and menu_substate, then copies 6 words from object data at A0+$02 to scroll/position registers.
         in:A0 = object pointer | mod:A1

$00BD00  Backward Object Scan + Copy Scroll Data           [Game / Entity]
         Scans backward through 16-byte object entries starting from A0, skipping entries with type byte $0C.
         in:A0 = object pointer (scan start) | mod:A1

$00BD2A  AI Scene Interpolation (6 Components)             [Game / Ai]
         Interpolates 6 component values between two keyframes using scene_state as the interpolation factor.
         in:A0 = keyframe data pointer (+$01 = total frames, +$02 = end  | mod:D0, D1, D2, A0, A1, A2

$00BD9E  Abort With Flag                                   [Game / State]
         Pops the caller's return address from stack (ADDQ #4,SP), sets flag ($C308).
         mod:(modifies SP)

$00BDA8  HUD Activate Check                                [Game / Hud]
         Conditionally activates HUD elements: If ($A0F0).
         mod:(none modified)

$00BDC8  Counter Init Check                                [Game / State]
         Initializes counter ($A0F0).
         mod:(none modified)

$00BDD6  AI Object Setup + Conditional Flag Set            [Game / Ai]
         Tests AI data word ($A0F0).
         in:none | Exit: object setup or fall-through | Uses: D1, A1

$00BDFE  Display Parameter Computation (Shift+Multiply, Word Table)  [Game / Render]
         Computes display viewport parameters from word lookup table.
         mod:D0, D1, D2, A1, A2

$00BE50  AI State Dispatch (Offset Table + Timer)          [Game / Ai]
         Reads state index from ai_state ($A0EA), dispatches via 15-entry jump table.
         mod:D0, D4, D7, A0, A2, A4, A6

$00BEC4  AI Dispatch + Triple Object Setup                 [Game / Ai]
         Advances AI dispatch counter, clears substate.
         mod:D0, A1

$00BEFC  display_entry_builder                             [Game / Hud]
         Display Entry Builder (5 Racers) Builds 5 display entries at $FF6900 from racer data in RAM table ($EF08) and ROM data at $0088C05C (display_list_b...
         in:A6 = base pointer for dispatch table offsets | mod:D0, D1, D2, D3, A1, A2, A3

$00BF9E  VDP Table Entry Write (Frame-Indexed)             [Game / Render]
         Increments frame counter $A0EC, computes row and column: row = ($A0EC × 2) / 28, column = remainder + 2.
         mod:D0, D1, D2, A1

$00BFD4  Advance AI State Machine                          [Game / Ai]
         Advances the AI state variable at $A0EA by 4 (jump table index step) and clears the AI sub-state at $A0EC.
         in:none | Exit: state advanced | Uses: none

$00BFDE  VDP Table Entry Write (Frame-Indexed, Variant B   [Game / Render]
         Negated Column) Like vdp_table_entry_write_00bf9e but negates the column value and checks for $FFE4 (column -28).
         mod:D0, D1, D2, A1

$00C01E  Advance AI State Machine (Duplicate)              [Game / Ai]
         Advances the AI state variable at $A0EA by 4 (jump table index step) and clears the AI sub-state at $A0EC.
         in:none | Exit: state advanced | Uses: none

$00C028  HUD Buffer Clear                                  [Game / Hud]
         Clears HUD display buffer entries: - Zeroes first byte at $FF6800, $FF6810, $FF6820 - Clears 6 word entries at $FF6900 with $14 stride
         mod:D0, D1, A1

$00C05C  Display List Builder                              [Game / Hud]
         Clears 16 display slots ($FF6800, stride $10), then if display_list_count ($C0FC) is nonzero, reads entries from a ROM offset table and populates s...
         mod:D0, D1, D2, D3, A1, A2

$00C200  Scene Init Orchestrator                           [Game / Scene]
         Master scene initialization — calls 9 setup subroutines, configures MARS VDP mode (240-line bitmap), sets SH2 interrupt control, initializes frame ...
         in:(none — standalone orchestrator) | mod:D0, A0, A5 | calls:$00A1FC: race_state_read $00C974: track_segment_init $00CF0C

$00C30A  State Dispatcher (5-Entry Jump Table + 6 Subroutines)  [Game / State]
         Dispatches via 5-entry longword jump table indexed by state_dispatch_idx ($C87E).
         mod:D0, D1, D2, A0, A1, A6 | calls:$0021CA: init handler $0028C2: VDPSyncSH2 $0058C8: sprite_in

$00C368  Scene Init with Multiple SH2 Calls                [Game / Scene]
         Calls four subroutines (3 SH2 + 1 local), increments the frame counter ($C886), advances game state dispatch ($C87E) by 4, and sets display mode/fr...
         in:none | Exit: scene initialized | Uses: none

$00C390  Scene Orchestrator (5 Subroutines + Controller Decode, 2 Entry Points)  [Game / Scene]
         Entry 1 ($C390): calls init ($21CA), poll_controllers ($179E), increments frame_counter ($C080) and scene_state, decodes controller byte from RAM p...
         mod:D0, D1, A0 | calls:$00179E: poll_controllers $0021CA: init handler $0024CA: sce

$00C416  Scene Dispatch (Jump Table)                       [Game / Scene]
         Reads scene dispatch index from $C8F5, looks up target scene ID from PC-relative table at $C44C.
         mod:D0 | calls:$008849AA: SH2 scene init

$00C44C  Scene State Dispatcher (Data Prefix + 4-Entry Jump Table)  [Game / Scene]
         Data prefix: 9-word parameter table (7 offsets + 2 × $1000).
         mod:D0, D2, A1, A2, A4, A6 | calls:$0021CA: sfx_queue_process $0025B0: init_handler $0028C2: VD

$00C4A4  Scene Frame Update + Display Mode Set             [Game / Scene]
         Calls two SH2 routines, increments the frame counter ($C886), advances the sub-sequence state ($C8C4) by 4, and sets the display mode/frame delay t...
         in:none | Exit: frame updated | Uses: none

$00C4C2  Scene Dispatch + Input Replay                     [Game / Scene]
         Increments frame/scene counters, reads next input byte from replay buffer (splitting direction + button bits), calls scene logic, then dispatches t...
         mod:D0, D1, D2, A0, A1, A2 | calls:$00B684: object_update (JSR PC-relative) $00B6DA: sprite_upd

$00C544  Scene Phase Timer                                 [Game / Scene]
         Setup Source: code_c200 Initializes a phase-based timer system that drives scene transitions.
         in:No register inputs | mod:D0

$00C56A  Scene Phase Timer                                 [Game / Scene]
         Tick and Data Tables Source: code_c200 Contains two inline data tables used by scene_phase_timer_setup (fn_c200_031) for phase-based scene timing, ...
         in:No register inputs | mod:(none modified beyond RAM writes)

$00C592  Scene Phase Timer                                 [Game / Scene]
         Reset Source: code_c200 Resets the phase timer system to its initial state.
         in:No register inputs | mod:(none)

$00C5AE  Countdown Timer Setup                             [Game / Race]
         Race Start Initialization Source: code_c200 Manages the race-start countdown trigger based on the timeline frame counter ($C080).
         in:No register inputs (reads timeline from RAM) | mod:D0

$00C618  Countdown Timer Update                            [Game / Race]
         Animation and Race Start Trigger Source: code_c200 Called each frame after the countdown begins (timeline > 995).
         in:No register inputs | mod:D0 (preserved by subroutine call convent

$00C662  Scene State Dispatcher                            [Game / Race]
         Race Initialization Phases Source: code_c200 Dispatches to the appropriate race initialization handler based on the scene state byte ($C8F4).
         in:No register inputs (A5 may be VDP control port for state 8) | mod:D0, A1

$00C680  Race Init Phase 1                                 [Game / Race]
         Flag Setup Source: code_c200 First phase of race initialization, called when scene state ($C8F4) = 4.
         in:No register inputs | mod:(none modified beyond RAM writes)

$00C6A4  Race Init Phase 2                                 [Game / Race]
         VDP Scroll Mode Configuration Source: code_c200 Second phase of race initialization, called when scene state ($C8F4) = 8.
         in:A5 = VDP control port | mod:(none modified beyond VDP write and RAM)

$00C6B6  race_scene_data_loader                            [Game / Race]
         Race Scene Data Loader Race initialization orchestrator.
         mod:D0-D7, A0-A6 (saves/restores via MOVEM)

$00C7C2  track_graphics_and_sound_loader                   [Game / Track]
         Track Graphics and Sound Loader Data prefix (animation frame table, 30 bytes).
         mod:D0, D1, D3, D4, D7, A0, A1, A2 | calls:$0048EA (data_copy), $004922 (FastCopy16)

$00C8E6  Scene Dispatch + Track Data Setup                 [Game / Scene]
         Reads race_substate ($C8CC) to index a 6-word data table, storing two config words to $FF6122/$FF6352.
         mod:D0, A1, A2, A3, A4 | calls:$00C9AE: post_dispatch (called 3 times via BSR/BRA)

$00C9AE  Object Field Store Helper                         [Game / Entity]
         Source: code_c200 Stores a word value and a long pointer into an object entry.
         in:D0 = word value to store at object base A1 = object entry po | mod:A4 (post-incremented)

$00C9B6  VDP Register Table Copy (with Shared Block Copy Subroutine)  [Game / Render]
         Source: code_c200 Copies a 512-byte VDP register configuration table from ROM to 32X work RAM.
         in:No register inputs | mod:D0, A1, A2

$00C9E0  VDP Register Table Init                           [Game / Render]
         Multi-Entry Loader Source: code_c200 Provides five entry points that each load a different VDP configuration table from ROM into the 32X VDP work a...
         in:None (each entry point is self-contained) | mod:D0, D1, A1, A2

$00CA4C  VDP Slot Activation                               [Game / Menu]
         Configuration A Source: code_c200 Activates three VDP register slots by writing control bytes to their base addresses in the VDP work area ($FF6800).
         in:No register inputs | mod:(none)

$00CA66  VDP Slot Activation                               [Game / Menu]
         Configuration B Source: code_c200 Activates three VDP register slots by writing control bytes to their base addresses in the VDP work area ($FF6800).
         in:No register inputs | mod:(none)

$00CA80  VDP Slot Activation                               [Game / Menu]
         Configuration C Source: code_c200 Activates three VDP register slots by writing control bytes to their base addresses in the VDP work area ($FF6800).
         in:No register inputs | mod:(none)

$00CA9A  race_track_overlay_config                         [Game / Race]
         Race Track Overlay Configuration Configures race track overlays and HUD elements.
         mod:D0, D1, D4, D5, D7, A1, A2, A3

$00CC06  Object Array Initialization from ROM Tables       [Game / Entity]
         Source: code_c200 Initializes a 15-element object array in work RAM at $FF6218.
         in:No register inputs (reads index from $C8CC) | mod:D0, D1, D7, A1, A2, A3, A4

$00CC74  Scene Camera Init                                 [Game / Camera]
         Initializes camera/scene for race start.
         in:D0 = ROM table offset (first entry only) A0 = object/entity  | mod:D0, A0, A1, A2 | calls:$00884922: segment_copy_to_buffer (JMP/JSR target)

$00CD4C  Object Table Init                                 [Game / Entity]
         256-Byte Entry Array Source: code_c200 Initializes a 15-element object table at $FFFF9100, with each entry being 256 ($100) bytes.
         in:No register inputs | mod:D0, D1, D7, A0, A1, A2, A3

$00CD92  Scene Init + SH2 Buffer Clear Loop                [Game / Scene]
         Saves/restores $C260 across SH2 init call ($88483A with A1→$C000).
         mod:D1, D7, A1 | calls:$0088483A: SH2 init A $00884842: SH2 init B (called 16 times

$00CDD2  Object Entry Loader                               [Game / Entity]
         16-Entry Loop with Table Lookup Source: code_c200 Initializes 16 consecutive 256-byte object entries at $FFFF9000 by performing a double-indexed RO...
         in:D0 = base entry offset (added to game mode for sub-index) | mod:D0, D2, D7, A0, A1

$00CE02  Dual Object Entry Init                            [Game / Entity]
         Primary and Alternate Entries Source: code_c200 Initializes two specific object entries: the primary entry at $FFFF9000 and an alternate entry at $...
         in:D0 = entry offset selector (passed to object_entry_data_copy | mod:D0, D1, D2, A0, A1

$00CE22  Object Entry Data Copy (with Shared Field Copy Subroutine)  [Game / Entity]
         Source: code_c200 Copies field data from a ROM table into a single 256-byte object entry.
         in:D0 = entry offset selector (combined with game mode) D1 = va | mod:D0, D2, A0, A1

$00CE56  Object Entries Reset                              [Game / Entity]
         16-Entry Init from Fixed Table Source: code_c200 Initializes 16 consecutive 256-byte object entries at $FFFF9000 using data from a fixed ROM table ...
         in:No register inputs | mod:D7, A0, A1

$00CE76  Scene Initialization (Variable Reset)             [Game / Scene]
         Initializes scene variables: clears display flags ($C81D/$C81F/$C820), sets work buffer ($A9E0-$A9E9) to default values ($0000C4C4), clears $C819 a...
         mod:D1, A1 | calls:$00884842: SH2 init A $00884846: SH2 init B $00884856: SH2 i

$00CEC2  Score/Stat Lookup and Accumulate                  [Game / Hud]
         Dual Entry Point Source: code_c200 Looks up a score or stat modifier from a PC-relative data table and adds it to an accumulator at $C0E8.
         in:No register inputs (entry point selects configuration) | mod:D0, D1, A0

$00CEEE  entity_heading_and_turn_rate_calculator           [Game / Physics]
         Entity Heading and Turn Rate Calculator Data prefix (3 × 10-byte parameter blocks).
         in:A0 = entity table base | mod:D0, D7, A0, A1, A2, A6

$00CFD6  Scene Init + VDP Block Setup + Counter Reset      [Game / Render]
         Loads scene data pointer from $00895BCC indexed by race_substate ($C8CC), calls block_copy ($CFC2) 4× to copy to VDP buffers at $FF6178/$FF627C/$FF...
         mod:D0, A1, A2, A3 | calls:$00CFC2: block_copy (4×)

$00D04C  Race Scene Init + 6-Entry Jump Table Dispatch     [Game / Race]
         Data prefix: 4 words ($5041,$4100,$504B,$4600) — ASCII-like scene identifiers ("PA","A\0","PK","F\0").
         mod:D0, D1, A0, A1, A3 | calls:$00D00C: scene pre-init

$00D08A  race_sprite_table_init                            [Game / Race]
         Race Sprite Table Initialization Initializes race sprite table.
         mod:D0, D1, D7, A1, A2, A3 | calls:$006C46 (sprite_table_init), $00B43C (word_to_nibble_unpacke

$00D19C  Game Mode and Track Configuration                 [Game / Scene]
         Source: code_c200 Configures the game mode and track selection variables used by the entire game engine.
         in:D0 = game mode (0-3) D1 = track number | mod:D0, D1, D2

$00D1D4  vdp_dma_config_and_display_init                   [Game / Render]
         VDP DMA Configuration and Display Init Configures VDP via multiple DMA transfers.
         mod:D0, D1, D2, D4, D7, A0, A1, A2

$00D3FC  Scene Init + VDP DMA Setup + Track Parameter Load  [Game / Render]
         Data prefix: 48 bytes (12 longword entries) of scene config.
         mod:D0, D1, A0, A1, A5 | calls:$00483E: nametable_init_A $004842: nametable_init_B $0048B8:

$00D482  sh2_display_and_palette_init                      [Game / Render]
         SH2 Display and Palette Initialization Major scene initialization orchestrator.
         mod:D0, D1, D2, D3, D4, A0, A1, A5 | calls:$00E1BC (sh2_palette_load), $00E22C (sh2_graphics_cmd), $00E

$00D7B2  scene_state_disp_with_palette_data                [Game / Render]
         Scene State Dispatcher with Palette Data Data prefix (~178 bytes) containing palette/color tables and scene configuration parameters.
         mod:D0, D1, D4, D5, D6, A0, A1, A2

$00D8B8  Object Update + Conditional Game State Advance    [Game / Entity]
         Calls object_update ($00B684), then checks sync flag bit 6.
         in:none | Exit: state optionally advanced | Uses: none

$00D8CC  palette_data_loader_and_cycle_handler             [Game / Render]
         Palette Data Loader and Cycle Handler Loads palette data from ROM tables $0088DAA8/$0088DA90 indexed by current palette selection.
         mod:D0, D1, D7, A0, A1, A2 | calls:$00E52C (dma_transfer)

$00DA90  scene_param_adjustment_and_dma_upload             [Game / Render]
         Scene Parameter Adjustment and DMA Upload Data prefix (48 bytes: 6 longword pointers + 6 word pairs).
         mod:D0, D1, D3, D4, D5, A0, A1, A4 | calls:$00E35A (sh2_send_cmd), $00E52C (dma_transfer), $00DCAC/$00D

$00DCAC  Positive Velocity Step                            [Game / Physics]
         Small Increment Source: code_c200 Adjusts D0 toward positive limit.
         in:D0 = velocity/position value (word) | mod:D0

$00DCBE  Negative Velocity Step                            [Game / Physics]
         Small Decrement Source: code_c200 Adjusts D0 toward negative limit.
         in:D0 = velocity/position value (word) | mod:D0

$00DCD0  sh2_object_and_sprite_update_orch                 [Game / Scene]
         SH2 Object and Sprite Update Orchestrator Per-frame SH2 communication orchestrator.
         mod:D0, D1, D2, D3, D4, A0, A1, A2 | calls:$00B684 (object_update), $00B6DA (sprite_update), $00E35A (s

$00DE98  sh2_dual_screen_object_update_orch                [Game / Scene]
         SH2 Dual-Screen Object Update Orchestrator Data prefix (54 bytes: display command tables for single/dual screen configurations).
         mod:D0, D1, D2, D3, A0, A1, A2, A5 | calls:$00B684 (object_update), $00B6DA (sprite_update), $00E35A (s

$00DFEC  SH2 Handshake and State Advance                   [Game / Scene]
         Source: code_c200 Performs a synchronization handshake with the SH2 via 32X communication registers, then advances the state machine.
         in:No register inputs | mod:(none modified beyond RAM/register write

$00E00C  Scene Setup / Game Mode Transition                [Game / Scene]
         Source: code_c200 Configures the game's scene handler function pointer ($FF0002) based on the current game sub-mode ($A024) and related flags.
         in:No register inputs (reads state from RAM) | mod:No registers modified (all operands are 

$00E118  SH2 Cmd 27 Sprite Render                          [Game / Render]
         Sends two sprite render commands to SH2 via sh2_cmd_27.
         mod:D0, D1, D2, D3, A0, A1 | calls:$00E3B4: sh2_cmd_27 (JSR PC-relative)

$00E5AC  default_palette_color_data                        [Game / Render]
         Default Palette Color Data Static palette color data table.

$00E5CE  sh2_split_screen_display_init                     [Game / Render]
         SH2 Split-Screen Display Initialization Scene initialization for split-screen modes.
         mod:D0, D1, D2, D3, D4, A0, A1, A5 | calls:$00E1BC (sh2_palette_load), $00E22C (sh2_graphics_cmd), $00E

$00E93A  sh2_geometry_transfer_and_palette_cycle_handler   [Game / Render]
         SH2 Geometry Transfer and Palette Cycle Handler Sends SH2 geometry and sprite data via sh2_send_cmd.
         mod:D0, D1, D7, A0, A1, A2 | calls:$00E35A (sh2_send_cmd), $00E52C (dma_transfer)

$00ECBE  sh2_scene_object_update_with_lookup_tables        [Game / Scene]
         SH2 Scene Object Update with Lookup Tables Data prefix (~280 bytes: sine/cosine lookup tables for animation interpolation, palette color tables, an...
         mod:D0, D1, D2, D3, D4, D5, D6, D7 | calls:$00B684 (object_update), $00B6DA (sprite_update), $00E35A (s

$00EFC2  SH2 COMM Transfer Setup A (Horizontal World Data)  [Sh2]
         Sets up SH2 COMM transfer block at $FF6100 with world coordinate data from $FF2000-$FF2004, callback $222BDAE6.
         in:D0 = parameter value | mod:A1

$00F040  SH2 COMM Transfer Setup B (Secondary World Data)  [Sh2]
         Sets up SH2 COMM transfer block at $FF6100 with world coordinate data from $FF2006-$FF200A, callback $222BEA76.
         in:D0 = parameter value | mod:A1

$00F0BE  SH2 COMM Transfer Setup C (Third World Data)      [Sh2]
         Sets up SH2 COMM transfer block at $FF6100 with world coordinate data from $FF200C-$FF2010, callback $222BF710.
         in:D0 = parameter value | mod:A1

$00F130  sh2_three_panel_display_init                      [Game / Render]
         SH2 Three-Panel Display Initialization Data prefix (12 bytes: 3 longword entry point pointers).
         mod:D0, D1, D2, D3, D4, A0, A1, A5 | calls:$00E1BC (sh2_palette_load), $00E22C (sh2_graphics_cmd), $00E

$00F39C  scene_state_disp_with_color_tables                [Game / Scene]
         Scene State Dispatcher with Color Tables Data prefix (~128 bytes: palette/color tables and scene configuration parameters).
         mod:D0, D1, D5, D6, A1, A2, A3, A4 | calls:$00B684 (object_update)

$00F44C  multi_screen_palette_navigation_handler           [Game / Render]
         Multi-Screen Palette Navigation Handler Handles palette navigation for multi-screen (up to 3-panel) display modes.
         mod:D0, D1, D2, A0, A1, A2 | calls:$00E35A (sh2_send_cmd), $00F88C (palette_switch)

$00F682  sh2_multi_panel_object_update_orch                [Game / Scene]
         SH2 Multi-Panel Object Update Orchestrator Data prefix (~96 bytes: SH2 command tables for single/dual-screen tile transfer configurations).
         mod:D0, D1, D2, D3, D6, A0, A1, A2 | calls:$00B684 (object_update), $00B6DA (sprite_update), $00E35A (s

$00F85C  SH2 Sync Wait and State Reset                     [Sh2]
         Waits for SH2 to finish (polls $A15120), clears SH2 status, resets state counter, and selects function pointer based on ($A018) flag.
         mod:None (modifies memory only)

$00F88C  Palette Table Init                                [Display]
         Initializes palette table regions.
         in:D0 = table selector (0=A, nonzero=B) | mod:D0, D1, D2, A0-A3

$00F8F6  sh2_multi_panel_tile_renderer                     [Game / Render]
         SH2 Multi-Panel Tile Renderer Data prefix (32 bytes: default palette color data, same as default_palette_color_data).
         mod:D0, D1, D2, A0, A1 | calls:$00E3B4 (sh2_cmd_27)

$00FB36  COMM Transfer Block (Command $2D)                 [Sh2]
         Sends command $2D and transfers 28 words from buffer via FIFO.
         mod:D7, A1, A2

$00FB98  time_trial_records_display_init                   [Game / Menu]
         Time Trial Records Display Initialization Major scene initialization for time trial records display.
         mod:D0, D1, D2, D3, D4, D5, A0, A1 | calls:$00E1BC (sh2_palette_load), $00E22C (sh2_graphics_cmd), $00E

$010084  records_scene_state_disp                          [Game / Menu]
         Records Scene State Dispatcher Data prefix (~164 bytes: scene configuration tables with display parameters, palette/color data).
         mod:D0, D1, D2, D3, D4, D5, D6, A0 | calls:$00B684 (object_update)

$010200  Name Entry SH2 Transfer + Advance                 [Game / Menu]
         Reads current name byte from buffer, sends two SH2 DMA commands.
         mod:D0, D1, A0, A1 | calls:$00E35A: sh2_send_cmd (A0=src, A1=dest, D0=size, D1=width)

$010244  Name Entry Character Input (Player 1)             [Game / Menu]
         Handles character input for player 1 name entry.
         mod:D0, D1, D2, A0 | calls:$00E52C: dma_transfer (D0=mode) $010796: cursor_render (A0=b

$01035C  Name Entry Object Update + DMA                    [Game / Menu]
         DMA transfer, object update, and character table rendering.
         mod:D0, D1, A0, A1, A2 | calls:$00B684: object_update $00E35A: sh2_send_cmd (A0=src, A1=des

$0103C4  Name Entry Character Input (Player 2)             [Game / Menu]
         Handles character input for player 2 name entry.
         mod:D0, D1, D2, A0 | calls:$00E52C: dma_transfer $010796: cursor_render $0088179E: cont

$0104A2  Name Entry Sprite Update + Animation              [Game / Menu]
         Orchestrates name entry sprite display with DMA, animation, and character preview rendering.
         mod:D0, D1, A0, A1, A4 | calls:$00B6DA: sprite_update $00E35A: sh2_send_cmd $00E52C: dma_tr

$0105DE  SH2 Comm Reset and Mode Set                       [Game / Scene]
         Waits for SH2 to become idle (COMM0 high byte = 0), clears COMM1, resets game state to 0, sets display mode $0020, and writes the SH2 entry point a...
         in:none | Exit: SH2 idle, game state reset, mode configured | mod:none (beyond RAM/register writes)

$010606  lap_time_digit_renderer_a                         [Game / Hud]
         Lap Time Digit Renderer A Renders a BCD-encoded lap time as digit tiles to SH2 framebuffer region A ($06023200).
         in:A1 = destination tile pointer, A2 = BCD time data pointer | mod:D1, D3, A1, A2 | calls:bcd_nibble_splitter_a: BCD nibble splitter (high + low digit

$01063A  bcd_nibble_splitter_a                             [Game / Hud]
         BCD Nibble Splitter A Splits byte in D3 into high nibble (shift right 4) and low nibble (AND $0F), rendering each as a digit tile via digit_tile_dm...
         in:D3 = BCD byte, A1 = destination tile pointer | mod:D1, D3, A1 | calls:digit_tile_dma_to_framebuffer_a: digit tile DMA to framebuff

$010656  digit_tile_dma_to_framebuffer_a                   [Game / Hud]
         Digit Tile DMA to Framebuffer A Computes SH2 framebuffer address for digit tile D1: offset = D1 × 192 (D1<<6 + D1<<7), added to base $06023200.
         in:D1 = tile/digit index | mod:D0, D1, A0 | calls:$00E35A: sh2_send_cmd

$010674  ascii_character_to_tile_index_mapper_010674       [Game / Hud]
         ASCII Character to Tile Index Mapper (SH2, Alternate) Maps ASCII/special character code in D0 to a tile index, computes the ROM address at base $06...
         in:D0 = character code | mod:D0, D1, A0 | calls:$00E35A (sh2_send_cmd)

$01071C  name_entry_background_tile_transfer               [Game / Menu]
         Name Entry Background Tile Transfer Transfers 5 tile data blocks to SH2 framebuffer for the name entry screen background and UI elements.
         mod:D0, D1, A0, A1 | calls:$00E35A: sh2_send_cmd

$010796  Name Entry Cursor Render                          [Game / Menu]
         Renders name entry cursor with blink animation.
         in:A0 = name buffer pointer | mod:D0, A0, A1, A4 | calls:$010674: sprite_slot_render (A0=source, A1=dest, D0=char)

$01084C  Name Entry Input Handler                          [Game / Menu]
         Processes directional input for name entry cursor.
         in:D1 = controller input bits | mod:D0, D1, D2

$010974  name_entry_screen_init                            [Game / Menu]
         Name Entry Screen Initialization Large orchestrator that initializes the entire name entry screen for high score entry.
         in:(no register parameters — uses global RAM state) | mod:D0, D1, D2, D3, D4, D5, D7, A0, A1, A2 | calls:$00E1BC: sh2_palette_load $00E22C: sh2_graphics_cmd $00E2F0:

$01103E  name_entry_state_disp                             [Game / Menu]
         Name Entry State Dispatcher Data prefix ($01103E-$011121) contains structured parameter blocks for each name entry sub-state: entity field offsets ...
         in:A0 = object/entity pointer | mod:D0, D1, D2, D3, D4, D5, D6, A0 | calls:$00B684: object_update

$0111A4  Advance Game State + Set Frame Delay              [Game / Menu]
         Calls a sub-routine at $011B08, then advances the main game state by 4 and sets the frame delay parameter to $0018 (24 frames).
         in:none | Exit: state advanced | Uses: none

$0111B6  Name Entry Score Display Transfer                 [Game / Menu]
         Sends 4 SH2 DMA transfers for score display areas, then renders two time digit fields from BCD buffers at $A046 and $A04A.
         mod:D0, D1, A0, A1, A2 | calls:$00E35A: sh2_send_cmd (A0=src, A1=dest, D0=size, D1=width) $

$011240  Name Entry Mode Select + Input Handler            [Game / Menu]
         DMA + object_update + sprite_update, then 4 sh2_send_cmd transfers (score display, scroll view, time digits, status bar).
         mod:D0, D1, D2, A0, A1, A2 | calls:$00B684: object_update $00B6DA: sprite_update $00E35A: sh2_s

$01141A  Name Entry SH2 COMM Setup + DMA                   [Game / Menu]
         DMA transfer, then sends two SH2 COMM commands.
         mod:D0 | calls:$00E52C: dma_transfer (D0=mode)

$01146E  Name Entry Scroll View + Action Handler           [Game / Menu]
         DMA transfer, updates objects and sprites, sends SH2 DMA.
         mod:D0, D1, D2, A0, A1 | calls:$00B684: object_update $00B6DA: sprite_update $00E35A: sh2_s

$0115A8  Name Entry SH2 COMM + Scroll DMA + Blink          [Game / Menu]
         DMA transfer, sends SH2 COMM commands (same as name_entry_sh2_comm_setup_dma), then sends scroll view DMA ($26028000+offset → $24010018, $80×$50).
         mod:D0, D1, A0, A1 | calls:$00E35A: sh2_send_cmd $00E52C: dma_transfer $011C7E: score_a

$011630  Name Entry Dual Scroll View + Action Handler      [Game / Menu]
         DMA + object_update + sprite_update, then sh2_send_cmd for scroll view (source $26032000 + offset $A032, dest $240100A0).
         mod:D0, D1, D2, A0, A1 | calls:$00B684: object_update $00B6DA: sprite_update $00E35A: sh2_s

$0117F4  SH2 Scene Reset                                   [Game / Menu]
         Name Entry Mode Dispatcher Resets SH2 communication and selects a scene handler based on game mode flags.
         in:none | Exit: SH2 scene configured | Uses: none

$011862  SH2 Scene Reset                                   [Game / Scene]
         Set Handler $88D4A4 Waits for SH2 idle (COMM0 clear), then resets game state and configures a new SH2 scene handler at $0088D4A4 with display mode ...
         in:none | Exit: SH2 reconfigured | Uses: none

$01188A  Sprite Buffer Clear + SH2 Scene Reset             [Game / Scene]
         Clears the 512-byte sprite data buffer at $FF6E00, triggers a sprite update via JSR to sprite_update ($00B6DA), then conditionally resets the SH2 s...
         in:none | Exit: sprites cleared, SH2 optionally reset | mod:D0, A0

$0118D4  lap_time_digit_renderer_b                         [Game / Hud]
         Lap Time Digit Renderer B Identical logic to lap_time_digit_renderer_a but renders to SH2 framebuffer region B ($0601DF00) for the second display a...
         in:A1 = destination tile pointer, A2 = BCD time data pointer | mod:D1, D3, A1, A2 | calls:bcd_nibble_splitter_b: BCD nibble splitter B digit_tile_dma_

$011908  bcd_nibble_splitter_b                             [Game / Hud]
         BCD Nibble Splitter B Identical logic to bcd_nibble_splitter_a — splits byte in D3 into high and low nibbles, rendering each as a digit tile via di...
         in:D3 = BCD byte, A1 = destination tile pointer | mod:D1, D3, A1 | calls:digit_tile_dma_to_framebuffer_b: digit tile DMA to framebuff

$011924  digit_tile_dma_to_framebuffer_b                   [Game / Hud]
         Digit Tile DMA to Framebuffer B Identical logic to digit_tile_dma_to_framebuffer_a — computes SH2 framebuffer address for digit tile D1: offset = D...
         in:D1 = tile/digit index | mod:D0, D1, A0 | calls:$00E35A: sh2_send_cmd

$011942  lap_time_digit_renderer_c                         [Game / Hud]
         Lap Time Digit Renderer C (Register-Saving) Same logic as lap_time_digit_renderer_a/030 but saves/restores D3/D4 on stack via MOVEM.
         in:A1 = destination tile pointer, A2 = BCD time data pointer | mod:D1, D3, D4, A1, A2 | calls:bcd_nibble_splitter_c: BCD nibble splitter C digit_tile_blit

$01197E  bcd_nibble_splitter_c                             [Game / Hud]
         BCD Nibble Splitter C Same logic as bcd_nibble_splitter_a/031 — splits byte in D3 into high and low nibbles, rendering each as a digit tile via dig...
         in:D3 = BCD byte, A1 = destination tile pointer | mod:D1, D3, A1 | calls:digit_tile_blit_to_framebuffer: digit tile blit to framebuff

$01199A  digit_tile_blit_to_framebuffer                    [Game / Hud]
         Digit Tile Blit to Framebuffer Same structure as digit_tile_dma_to_framebuffer_a/032 — computes framebuffer address for digit tile D1: offset = D1 ...
         in:D1 = tile/digit index | mod:D0, D1, A0 | calls:$011A98: name_entry_check (tile blit with stride)

$0119B8  Name Entry Color/Palette Update                   [Game / Menu]
         Updates name entry palette with animated color cycling.
         mod:D0, D1, D2, D3, D4, D5, A0, A1

$011A5C  cursor_pos_clamp                                  [Game / Menu]
         Cursor Position Clamp [0, 31] Adds D1 offset to D5 then clamps result to [0, 31].
         in:D1 = offset to add, D5 = current position | mod:D5

$011A70  sh2_command_sender                                [Game / Scene]
         SH2 Command Sender (Multi-Parameter) Sends multiple parameters to the SH2 via COMM registers using a handshake protocol.
         in:D0, D1, D2 = parameter words; A0, A1 = parameter pointers | mod:D0, D1, D2, A0, A1 32X registers: COMM0_

$011B08  name_entry_ui_tile_refresh                        [Game / Menu]
         Name Entry UI Tile Refresh Refreshes 4 UI tile blocks on the name entry screen via sh2_send_cmd: 1.
         mod:D0, D1, A0, A1 | calls:$00E35A: sh2_send_cmd

$011B6A  Name Entry BCD Score Comparison                   [Game / Menu]
         Compares player's score against high score table using BCD arithmetic.
         mod:D0, D1, D2, D3, D4, D5, D6, D7, A0, A1, 

$011C7E  Name Entry Score Area DMA Transfer                [Game / Menu]
         Sends SH2 DMA for one of 4 score display areas based on ranking result ($A04E) and display toggle ($A050).
         mod:D0, D1, A0, A1 | calls:$00E35A: sh2_send_cmd (A0=src, A1=dest, D0=size, D1=width)

$011D0A  records_screen_init                               [Game / Menu]
         Records Screen Initialization Initializes the records/results display screen.
         mod:D0, D1, D2, D3, D4, A0, A1, A5 | calls:$00E1BC: sh2_palette_load $00E22C: sh2_graphics_cmd $00E2F0:

$011F38  records_screen_state_disp                         [Game / Menu]
         Records Screen State Dispatcher Data prefix ($011F38-$012055) contains: - 15-bit RGB color palette ($0000, $0421, $0842.
         in:A0 = object/entity pointer | mod:D0, D1, D3, D4, D5, D6, A0, A1 | calls:$00B684: object_update

$012084  Name Entry Rendering + SH2 Transfer               [Game / Menu]
         DMA transfer + 3 static sh2_send_cmd DMA transfers.
         mod:D0, D1, D2, D3, A0, A1 | calls:$00E35A: sh2_send_cmd $00E3B4: sh2_cmd_27 $00E52C: dma_trans

$012200  records_viewer_main_loop                          [Game / Menu]
         Records Viewer Main Loop Data prefix ($012200-$012223) contains VDP/entity parameter blocks ($0401 entries with field offsets +$3A, +$3B for displa...
         mod:D0, D1, D2, D5, A0, A1, A2, A5 | calls:$00B684: object_update $00B6DA: sprite_update $00E35A: sh2_s

$01250C  SH2 Scene Reset                                   [Game / Scene]
         Set Handler $8926D2 Waits for SH2 idle (COMM0 clear), then resets game state and configures a new SH2 scene handler at $008926D2 with display mode ...
         in:none | Exit: SH2 reconfigured | Uses: none

$012534  Camera Tile Render (3D Array Index)               [Game / Menu]
         Calculates 3D array offset into tile data at $EF08: section (D0) × $3C0 + row (D1) × 160 + column (D2) × 8.
         in:D0 = section index, D1 = row index, D2 = column index, A1 =  | mod:D0, D1, D2, D3, D4, D5, A1, A2, A3, A4 | calls:$01259C: tile_render_sub_A (A1=dest, A2=source) $01260A: til

$01259C  lap_time_digit_renderer                           [Game / Hud]
         Lap Time Digit Renderer (Records Screen) Same pattern as lap_time_digit_renderer_a — renders BCD lap time as digit tiles to SH2 framebuffer at $060...
         in:A1 = destination tile pointer, A2 = BCD time data pointer | mod:D1, D3, A1, A2 | calls:bcd_nibble_splitter: BCD nibble splitter digit_tile_dma: dig

$0125D0  bcd_nibble_splitter                               [Game / Hud]
         BCD Nibble Splitter (Records Screen) Same pattern as bcd_nibble_splitter_a — splits byte in D3 into high and low nibbles, rendering each as a digit...
         in:D3 = BCD byte, A1 = destination tile pointer | mod:D1, D3, A1 | calls:digit_tile_dma: digit tile DMA to $0601F000

$0125EC  digit_tile_dma                                    [Game / Hud]
         Digit Tile DMA (Records Screen) Same pattern as digit_tile_dma_to_framebuffer_a — computes SH2 framebuffer address for digit tile D1: offset = D1 ×...
         in:D1 = tile/digit index | mod:D0, D1, A0 | calls:$00E35A: sh2_send_cmd

$01260A  byte_iterator                                     [Game / Menu]
         Byte Iterator (3-Byte Loop) Reads 3 bytes sequentially from (A2)+, calling the immediately following subroutine (BSR.
         in:A2 = source data pointer, D1 = byte value (set per iteration | mod:D1, D2, A2

$012618  ascii_character_to_tile_index_mapper_012618       [Game / Hud]
         ASCII Character to Tile Index Mapper (SH2) Maps ASCII character code in D1 to a tile index, computes the ROM address of the tile at base $060207C0 ...
         in:D1 = ASCII character code | mod:D0, D1, A0, A1 | calls:$00E35A (sh2_send_cmd)

$0126A6  camera_tile_block_send                            [Game / Camera]
         Camera Tile Block Send Sends a 56×16 tile block from SH2 framebuffer to display.
         in:D5 = camera index (0-3) | mod:D0, D1, D5, A0 | calls:$00E35A: sh2_send_cmd

$0126D2  camera_replay_screen_init                         [Game / Menu]
         Camera/Replay Screen Initialization Initializes the camera selection/replay viewing screen.
         mod:D0, D1, D2, D3, D4, A0, A1, A5 | calls:$00E1BC: sh2_palette_load $00E22C: sh2_graphics_cmd $00E2F0:

$0129E0  Scene State Dispatcher with Track Data Tables     [Game / Scene]
         Contains three 16-word track-specific data tables followed by a scene state dispatcher.
         in:scene_state_disp_track_data_tables → data tables (not execut | mod:D0, A1 | calls:sound_command_dispatch_sound_driver_call: scene setup object

$012A72  Camera Demo Palette + SH2 Setup                   [Game / Menu]
         DMA transfer, palette setup, SH2 object configuration.
         mod:D0, D1, D7, A0, A1, A2 | calls:$00E52C: dma_transfer

$012BFA  Camera DMA Transfer (Data Prefix)                 [Game / Menu]
         Data prefix (144 bytes) containing sprite descriptors (6 entries at $012BFA, 24 bytes each) and palette pointer table (6 longword pointers at $012C...
         mod:D0 | calls:$00E52C: dma_transfer

$012C9E  camera_angle_increment_clamp                      [Game / Camera]
         Camera Angle Increment Clamp Adds a small increment ($10) to D0 if D0 ≤ $4000 (≤ 90° in 16-bit angle space).
         in:D0 = camera angle (16-bit, $0000-$FFFF) | mod:D0

$012CB0  camera_angle_decrement_clamp                      [Game / Camera]
         Camera Angle Decrement Clamp Subtracts a small decrement ($10) from D0 if D0 ≥ $C000 (≥ 270° in 16-bit angle space).
         in:D0 = camera angle (16-bit, $0000-$FFFF) | mod:D0

$012CC2  camera_selection_main_loop                        [Game / Camera]
         Camera Selection Main Loop Per-frame update for the camera selection screen.
         mod:D0, D1, D2, A0, A1 | calls:$00B684: object_update $00B6DA: sprite_update $00E35A: sh2_s

$012F0A  SH2 Mode Dispatcher                               [Game / Menu]
         Select Scene by Track/Mode Resets the SH2 communication state, reads the player 1 selection from $A019, copies it to the race mode flag at $C817, t...
         in:none | Exit: SH2 scene configured | mod:D1

$012F56  Camera SH2 Command 27 Dispatch (Data Prefix)      [Game / Menu]
         Data prefix (28 bytes, 7 longword pointers referenced elsewhere) + SH2 command dispatch.
         mod:D0, D1, D2 | calls:$00E3B4: sh2_cmd_27

$012F9C  vdp_tile_fill_with_data_table                     [Game / Menu]
         VDP Tile Fill with Data Table Data prefix ($012F9C-$012FBF) contains structured VDP parameters: repeated $0401 entries with field offsets (+$38, +$...
         in:D0 = VDP base address, D1 = words per row, D2 = row count, D | mod:D0, D1, D2, D3, D4, D5, D6

$012FE4  sh2_multi_param_command_send                      [Game / Menu]
         SH2 Multi-Parameter Command Send Sends command $21 to SH2 with 4 parameters via COMM register handshake: 1.
         in:A0 = param 4, A1 = param 1, D0 = param 2 hi, D1 = param 2 lo | mod:D0, D1, D2, A0, A1

$013054  standings_screen_init                             [Game / Menu]
         Standings Screen Initialization Initializes the championship standings/results screen.
         mod:D0, D1, D2, D3, D4, A0, A1, A5 | calls:$00E1BC: sh2_palette_load $00E22C: sh2_graphics_cmd $00E2F0:

$013292  Camera State Dispatcher (Data Prefix + Jump Table)  [Game / Menu]
         Data prefix (128 bytes of object/sprite descriptors) + state dispatcher.
         mod:D0, D4, A0, A1 | calls:$00B684: object_update $00882080: initialization $0088205E: 

$013346  Camera Render DMA + Overlay                       [Game / Menu]
         DMA transfer + 3 static SH2 DMA transfers (header, main display, bottom panel).
         mod:D0, D1, D2, A0, A1 | calls:$00E35A: sh2_send_cmd $00E3B4: sh2_cmd_27 $00E52C: dma_trans

$0134C8  Camera Menu Orchestrator (Data Prefix)            [Game / Menu]
         Data prefix (40 bytes) + camera menu orchestrator.
         mod:D0, D1, D2, A0 | calls:$00B684: object_update $00B6DA: sprite_update $00E52C: dma_t

$0135C4  Camera Menu Input Handler                         [Game / Menu]
         Processes controller input for camera selection menu.
         in:D1 = controller data | mod:D0, D1, D2, A0

$0136AA  Camera Selection Counter (Replay Angle)           [Game / Menu]
         Data prefix (24 bytes), then code at $0136C2.
         in:D0 = increment/decrement, D2 = action flag | mod:D0, D2

$0136EA  Camera Selection Counter (Music Track)            [Game / Menu]
         If D2 == 0: adds D0 to music track counter ($A01C), wraps 0-25.
         in:D0 = increment, D2 = action flag | mod:D0, D2, A0

$013734  Camera Selection Counter (Sound Effect A)         [Game / Menu]
         If D2 == 0: adds D0 to SFX counter A ($A01E), wraps 0-12.
         in:D0 = increment, D2 = action flag | mod:D0, D2, A0

$01377A  Camera Selection Counter (Sound Effect B)         [Game / Menu]
         If D2 == 0: adds D0 to SFX counter B ($A020), wraps 0-9.
         in:D0 = increment, D2 = action flag | mod:D0, D2, A0

$0137C0  Conditional State Set + Enable Flags + SH2 Call (with ST)  [Game / Menu]
         Tests D2.
         in:D2 = condition value | Exit: flags set or no-op | Uses: D2

$0137F4  Conditional State Set + Enable Flags + SH2 Call   [Game / Menu]
         Tests D2.
         in:D2 = condition value | Exit: flags set or no-op | Uses: D2

$013824  SH2 Scene Reset                                   [Game / Scene]
         Conditional Handler by Player 2 Flag Waits for SH2 idle, copies the player 2 active flag ($A01A) to a local variable ($FDB9), then selects the SH2 ...
         in:none | Exit: SH2 scene configured | Uses: D0

$013864  race_config_screen_init                           [Game / Menu]
         Race Config Screen Initialization Initializes the race configuration/car selection screen.
         mod:D0, D1, D2, D3, D4, A0, A1, A5 | calls:$00E1BC: sh2_palette_load $00E22C: sh2_graphics_cmd $00E2F0:

$013A88  race_config_state_disp                            [Game / Menu]
         Race Config State Dispatcher Data prefix ($013A88-$013BC5) contains: - 15-bit RGB color palette (grayscale ramp + game-specific colors) - Structure...
         mod:D0, D1, D2, D3, D4, D5, D6, D7

$013C30  Camera SH2 Scene Transition + Dual DMA            [Game / Menu]
         Calls SH2 scene transition, then DMA transfer.
         mod:D0, D1, A0, A1 | calls:$00E35A: sh2_send_cmd $00E52C: dma_transfer $0088205E: SH2 s

$013CBA  race_config_main_loop                             [Game / Menu]
         Race Config Main Loop Per-frame update for the race configuration / car selection screen: 1.
         mod:D0, D1, D2, D3, D4, A0, A1, A2 | calls:$00E35A: sh2_send_cmd $00E52C: dma_transfer

$013F80  I/O Port Config Backup + SH2 Scene Reset          [Game / Menu]
         Conditionally copies 8-byte I/O port configuration blocks for each controller port whose status byte equals $06.
         in:none | Exit: port configs backed up, SH2 reset | mod:D0, A0, A1

$013FE0  car_driver_selection_input_handler                [Game / Menu]
         Car/Driver Selection Input Handler Processes input for car/driver selection on the race config screen.
         in:D0 = max car count flag, D1 = button state, D2 = player inde | mod:D0, D1, D2, D3, D4, A0, A1, A2

$01418E  table_entry_swap_by_index                         [Game / Menu]
         Table Entry Swap by Index Swaps two entries in array (A1) based on lookup indices.
         in:A1 = sortable array, A3 = pointer to index 1, A4 = pointer t | mod:D0, D1, D3, D4, D5, D6, A0, A1

$014200  sprite_strip_renderer_via_sh2_cmd_27              [Game / Menu]
         Sprite Strip Renderer via SH2 Cmd 27 DC.
         in:A0 = base data, A1 = entity table, D1 = initial Y offset, D3 | mod:D0, D1, D2, D3, D4, D5, A0, A1 | calls:$00E3B4: sh2_cmd_27

$014262  game_mode_transition_init                         [Game / Menu]
         Game Mode Transition Init Initializes hardware state for a game mode transition.
         mod:D0, D1, D4, D7, A5, A6

$0143C6  State Dispatcher + Controller Init (Jump Table)   [Game / State]
         Calls SH2 init ($882080), reads game_state ($C87E), dispatches via 3-entry longword jump table: State 0 → $008943E2 (controller poll + advance, wit...
         mod:D0, A1 | calls:$00882080: SH2 init $0088179E: controller_poll $01440E: inpu

$0143FA  Advance Game State                                [Game / Menu]
         Advances the main game state machine by one step (4 = one state entry).
         in:none | Exit: state advanced | Uses: none

$014400  Menu State Dispatch and Display Mode Set          [Game / Menu]
         Calls the menu state dispatcher at $01457C, then sets the display mode to $0024 via the adapter register at $FF0008.
         in:none | Exit: menu dispatched, display mode set | mod:(per called function)

$01440E  Menu State Dispatch 042                           [Game / Menu]
         Menu state dispatcher with 8-entry jump table State 0: clears substate + fade, advances state State 1: loads DMA transfer, calls menu_state_check S...
         mod:D0, D1, A0, A1, A2, A4 | calls:$0145F0: menu_state_check

$01446C  Menu Item Draw Loop (Jump Table Indexed)          [Game / Menu]
         Calls $014566 (check/init); if nonzero sets $C084 = $0F.
         mod:D0, D1, A0, A1 | calls:$014566: menu check/init $0145F0: menu_state_check Jump tabl

$0144A8  Menu State Check + Timer Countdown (Variant A)    [Game / Menu]
         Loads table address and parameter, calls menu_state_check.
         in:none | Exit: timer decremented | Uses: D1, A1

$0144D0  Menu State Check + Conditional Advance (Variant A)  [Game / Menu]
         Loads table address and parameter, calls menu_state_check.
         in:none | Exit: menu state checked | Uses: D1, A1

$0144F2  Menu State Check + Conditional Advance (Variant B)  [Game / Menu]
         Loads alternate table address and parameter, calls menu_state_check.
         in:none | Exit: menu state checked | Uses: D1, A1

$014518  Menu State Check + Timer Countdown (Variant B)    [Game / Menu]
         Loads alternate table address and parameter, calls menu_state_check.
         in:none | Exit: timer decremented | Uses: D1, A1

$014540  Conditional SH2 Scene Reset                       [Game / Scene]
         Tests player data word ($A008).
         in:none | Exit: scene reset or early return | Uses: none

$014566  Read Combined Start Button State                  [Game / Menu]
         Reads the start button flag from $C86D.
         in:none | Exit: D0.B bit 7 = start pressed (either player) | mod:D0

$01457C  Palette Fade 003                                  [Game / Menu]
         Applies brightness fade to 256-entry CRAM palette Scales R/G/B channels (5-bit each in $7C00/$03E0/$001F format) Decrements fade counter; clears wh...
         mod:D0, D1, D2, D3, D4, D5, A1

$0145F0  Menu Tile Copy to VDP (Block Transfer)            [Game / Menu]
         Copies tile data from (A1) to VDP nametable at $00844000 + D1.
         mod:D0, D1, D2, D3, D4, A1, A2, A3

$01462A  Menu Item Address Table + VDP Register Clear      [Game / Menu]
         Data prefix: 16-entry longword table of menu item data addresses ($0090E732.
         mod:D0

$014696  SH2 Call with Interrupt Mask                      [Game / Scene]
         Sets VDP update flag ($C80D), saves all registers, raises interrupt priority mask to level 7 (disable all), calls SH2 routine at $0088D1D4, restore...
         in:none | Exit: SH2 routine called | Uses: all (saved/restored)

$0146B4  Set Control Flag $C30D                            [Game / Menu]
         Sets the control flag byte at $C30D to 1.
         in:none | Exit: flag set | Uses: none

$0146BC  Set Mode Flag and Copy State Counter              [Game / Menu]
         Sets bit 0 of the mode flag at $C30E, then copies the state value from $C096 to the V-INT state variable at $C07A.
         in:none | Exit: flag set, state copied | Uses: none

$0146CA  Scroll X: Increment by 1                          [Game / Menu]
         Adds 1 to the horizontal scroll position and copies to SH2 shared memory.
         in:none | Exit: scroll X incremented | Uses: D0

$0146DA  Scroll X: Decrement by 1                          [Game / Menu]
         Subtracts 1 from the horizontal scroll position and copies to SH2.
         in:none | Exit: scroll X decremented | Uses: D0

$0146EA  Scroll Y: Increment by 1                          [Game / Menu]
         Adds 1 to the vertical scroll position and copies to SH2 shared memory.
         in:none | Exit: scroll Y incremented | Uses: D0

$0146FA  Scroll Y: Decrement by 1                          [Game / Menu]
         Subtracts 1 from the vertical scroll position and copies to SH2.
         in:none | Exit: scroll Y decremented | Uses: D0

$01470A  Scroll X: Increment by 32                         [Game / Menu]
         Adds 32 ($20) to the horizontal scroll position and copies to SH2.
         in:none | Exit: scroll X incremented by 32 | Uses: D0

$01471A  Scroll X: Decrement by 32                         [Game / Menu]
         Subtracts 32 ($20) from the horizontal scroll position and copies to SH2.
         in:none | Exit: scroll X decremented by 32 | Uses: D0

$01472A  Scroll Y: Increment by 32                         [Game / Menu]
         Adds 32 ($20) to the vertical scroll position and copies to SH2.
         in:none | Exit: scroll Y incremented by 32 | Uses: D0

$01473A  Scroll Y: Decrement by 32                         [Game / Menu]
         Subtracts 32 ($20) from the vertical scroll position and copies to SH2.
         in:none | Exit: scroll Y decremented by 32 | Uses: D0

$01474A  Add Track Segment Offset                          [Game / Menu]
         Reads the track segment value from $C8B0 and adds it to the accumulator at $C056.
         in:none | Exit: accumulator updated | Uses: D0

$014754  Subtract Track Segment Offset                     [Game / Menu]
         Reads the track segment value from $C8B0 and subtracts it from the accumulator at $C056.
         in:none | Exit: accumulator updated | Uses: D0

$01475E  Add Track Segment 1 Offset                        [Game / Menu]
         Reads track segment value 1 from $C8B2 and adds it to its accumulator at $C086.
         in:none | Exit: accumulator updated | Uses: D0

$014768  Subtract Track Segment 1 Offset                   [Game / Menu]
         Reads track segment value 1 from $C8B2 and subtracts it from its accumulator at $C086.
         in:none | Exit: accumulator updated | Uses: D0

$014772  Add Track Segment 2 Offset                        [Game / Menu]
         Reads track segment value 2 from $C8B4 and adds it to its accumulator at $C0B0.
         in:none | Exit: accumulator updated | Uses: D0

$01477C  Subtract Track Segment 2 Offset                   [Game / Menu]
         Reads track segment value 2 from $C8B4 and subtracts it from its accumulator at $C0B0.
         in:none | Exit: accumulator updated | Uses: D0

$014786  Add Track Segment 3 Offset                        [Game / Menu]
         Reads track segment value 3 from $C8B6 and adds it to its accumulator at $C0AE.
         in:none | Exit: accumulator updated | Uses: D0

$014790  Subtract Track Segment 3 Offset                   [Game / Menu]
         Reads track segment value 3 from $C8B6 and subtracts it from its accumulator at $C0AE.
         in:none | Exit: accumulator updated | Uses: D0

$01479A  Add Track Segment 4 Offset                        [Game / Menu]
         Reads track segment value 4 from $C8B8 and adds it to its accumulator at $C0B2.
         in:none | Exit: accumulator updated | Uses: D0

$0147A4  Subtract Track Segment 4 Offset                   [Game / Menu]
         Reads track segment value 4 from $C8B8 and subtracts it from its accumulator at $C0B2.
         in:none | Exit: accumulator updated | Uses: D0

$0147AE  Add Track Segment 5 Offset                        [Game / Menu]
         Reads track segment value 5 from $C8BA and adds it to the scroll X accumulator at $C054.
         in:none | Exit: accumulator updated | Uses: D0

$0147B8  Subtract Track Segment 5 Offset                   [Game / Menu]
         Reads track segment value 5 from $C8BA and subtracts it from the scroll X accumulator at $C054.
         in:none | Exit: accumulator updated | Uses: D0

$0147C2  Initialize Scroll + Position Registers            [Game / Menu]
         Sets initial values for scroll and track position registers.
         in:none | Exit: scroll/position initialized | Uses: none

$0147E8  Initialize Track Segment Values to Center         [Game / Menu]
         Sets all 6 track segment variables ($C8B0-$C8BA) to $0080 (center/default).
         in:none | Exit: all segments centered | Uses: none

$01480E  Adjust $903C: Add $0400                           [Game / Menu]
         Adds $0400 to the word at $903C.
         in:none | Exit: value incremented | Uses: none

$014816  Adjust $903C: Subtract $0400                      [Game / Menu]
         Subtracts $0400 from the word at $903C.
         in:none | Exit: value decremented | Uses: none

$01481E  Adjust $903C: Add $1000                           [Game / Menu]
         Adds $1000 to the word at $903C.
         in:none | Exit: value incremented | Uses: none

$014826  Adjust $903C: Add $2000                           [Game / Menu]
         Adds $2000 to the word at $903C.
         in:none | Exit: value incremented | Uses: none

$01482E  Fade Level Increment (Brightness Up)              [Game / Menu]
         Reads the fade level from $C888 (long), increments by 8, and clamps at $00FFFFFF (maximum).
         in:none | Exit: fade level incremented | Uses: D0

$014848  Fade Level Decrement (Brightness Down)            [Game / Menu]
         Reads the fade level from $C888 (long), decrements by 8, and clamps at minimum $00FF6000.
         in:none | Exit: fade level decremented | Uses: D0

$014862  scroll_pos_increment                              [Game / Menu]
         Scroll Position Increment Increments a scroll position by $10 (16 pixels).
         in:A1 = current position pointer, A2 = target position pointer | mod:D0, A1, A2

$014872  scroll_pos_decrement                              [Game / Menu]
         Scroll Position Decrement Decrements a scroll position by $10 (16 pixels).
         in:A1 = current position pointer, A2 = target position pointer | mod:D0, A1, A2

$030200  Sound Stream Load                                 [Sound]
         Reads sequential bytes from a data stream (A0)+ into channel state fields at A5+$18/$19/$1A/$1B, with the last byte right-shifted by 1.
         in:A0 = data stream pointer, A5 = channel state pointer | mod:D0 Fields written: A5+$18, A5+$19, A5+$1

$03021A  FM Channel Timer Check                            [Game / Sound]
         decrement timer and reinit on expiry Checks FM sound channel timer at A5+$12.
         in:A5 = FM channel structure pointer (+$01=sign, +$12=timer) | mod:A5, A7 (stack pop) | calls:$030C8A: fm_init_channel

$03023A  FM Set Volume Wrapper                             [Game / Sound]
         call fm_set_volume and skip caller Calls fm_set_volume subroutine, then pops return address from stack (ADDQ.
         calls:$030FB2: fm_set_volume

$030242  Sound Timer Check                                 [Sound]
         Tests bit 7 of A5+$0A.
         in:A5 = channel state pointer | mod:none Fields accessed: A5+$0A (bit test),

$030256  Sound Timer Decrement                             [Sound]
         Decrements counter at A5+$19.
         in:A5 = channel state pointer | mod:none Fields accessed: A5+$19 (counter)

$03025E  Sound State Reload                                [Sound]
         Reloads channel state from a pointer at A5+$14.
         in:A5 = channel state pointer | mod:A0 Fields accessed: A5+$14 (pointer), A5

$03027A  Sound Accumulate                                  [Sound]
         Decrements field $1B, then accumulates a signed byte from field $1A into the word at field $1C, and adds field $10 to the result in D6.
         in:A5 = channel state pointer | mod:D6 Fields accessed: A5+$1A, A5+$1B, A5+$

$030292  Sound Field Test                                  [Sound]
         Tests word at A5+$10.
         in:A5 = channel state pointer | mod:D6 Fields accessed: A5+$10, (A5) bit 1

$03029E  FM Sequence Process Orchestrator                  [Game / Sound]
         check channel and write frequency Checks FM channel status (A5+$0A active, bit 1 not muted, bit 2 not key-off).
         in:A5 = FM channel structure pointer; A6 = sound driver state p | mod:D0, D1, D6, A0, A4, A5, A6 | calls:$0302EE: fm_sequence_process $030CCC: fm_write_conditional $

$0302EE  FM Sequence Data Reader                           [Game / Sound]
         read note/frequency from sequence table Reads FM sequence data from ROM tables.
         in:A5 = FM channel structure pointer | mod:D0, D6, A0, A5

$030354  Stack Pop Return                                  [Game / Sound]
         skip caller's remaining code Pops return address from stack (ADDQ.

$030358  FM Sequence Command Handler                       [Game / Sound]
         process special sequence bytes Multiple entry points for FM sequence special commands, jumped to from fm_sequence_data_reader (fm_sequence_data_rea...
         in:A5 = FM channel structure pointer; A6 = sound driver state p | mod:D0, D1, D3, D5, D6, A0, A1, A2 | calls:$030CD8: fm_write_port0 $030D1C: z80_bus_request

$0303CC  FM Register Table + State Dispatcher              [Game / Sound]
         panning register data and dispatch 8 FM register bytes used by fm_sequence_command_handler's operator write loop ($AD,$A9,$AC,$A8,$AE,$AA,$A6,$A2 —...
         in:A5 = FM channel structure pointer | mod:D0, A5

$0303E8  FM State Dispatcher B                             [Game / Sound]
         3-state indexed jump for panning Jump table prefix: 3 BRA.
         in:A5 = FM channel structure pointer | mod:D0, A5

$030404  FM Panning Envelope Processor                     [Game / Sound]
         step through panning envelope data Processes FM panning envelope: reads envelope position (A5+$21) against envelope length (A5+$22), advances throu...
         in:A5 = FM channel structure pointer | mod:D0, D1, D3, A0, A5 | calls:$030CA2: fm_conditional_write

$03046C  FM Panning Init + Channel Stereo Setup            [Game / Sound]
         initialize panning for all channels 4 longword pointers to panning envelope tables (used by fm_panning_envelope_proc).
         in:A6 = sound driver state pointer | mod:D0, D1, D2, D3, D4, A5, A6 | calls:$030CCC: fm_write_conditional $030CD8: fm_write_port0 $030D1

$030536  FM Sound Priority Check                           [Game / Sound]
         compare and accept higher-priority commands Reads new sound command from A6+$0A, looks up its priority in table at $032B30 (128 entries, indexed by...
         in:A6 = sound channel state (+$00=priority, +$09=cmd, +$0A=new_ | mod:D0, D1, D2, D3, A0, A1, A6

$03056A  FM Sound Command Dispatcher                       [Game / Sound]
         route command byte to handler Reads sound command byte from A6+$09, dispatches to appropriate handler based on value range.
         in:A6 = sound channel state (+$09=command byte) | mod:D2, D6, D7, A0, A6

$0305BA  FM System Command Dispatcher                      [Game / Sound]
         route $F0-$FE system commands Dispatches system commands ($F0-$FE) via 16-entry jump table.
         in:D7 = command byte ($F0-$FE range) | mod:D7 | calls:$030D1C: z80_bus_request

$03061C  FM Instrument Setup                               [Game / Sound]
         load instrument data and configure channels Loads instrument definition from ROM table at $032AB8 (indexed by D7-$81).
         in:A6 = sound driver state pointer; D7 = sound command byte ($8 | mod:D0, D1, D4, D5, D6, D7, A0, A1, A2, A3,  | calls:$030C8A: fm_init_channel $030CBA: fm_write_wrapper $030D1C: 

$03078C  FM Channel Register Map + Instrument Loader B     [Game / Sound]
         $A0-$D2 commands FM/PSG register assignment bytes used by fm_instrument_setup.
         in:A6 = sound driver state pointer; D7 = sound command byte ($A | mod:D0, D1, D2, D3, D4, D5, D6, D7, A0, A1, 

$030852  FM Channel Pointer Table + SFX Loader             [Game / Sound]
         $D6-$D7 sound effects 16 longword pointers to channel structs within A6 sound driver state (used by fm_instrument_setup, fm_channel_reg_map_instrum...
         in:A6 = sound driver state pointer; D7 = sound command byte ($D | mod:D0, D2, D3, D4, D5, D6, D7, A0, A1, A2, 

$030936  FM Channel Stop Register Map + Stop All           [Game / Sound]
         silence all active channels channel struct pointer table (used alongside $030852 table).
         in:A6 = sound driver state pointer | mod:D0, D1, D3, D4, D6, A0, A1, A3, A5 | calls:$030C8A: fm_init_channel $030CBA: fm_write_wrapper $030FB2: 

$0309F2  FM Special Channel Cleanup                        [Game / Sound]
         stop DAC and noise effect channels Handles cleanup of two special sound channels: Channel $0340 (DAC/PCM): clears active flag, checks key-off, call...
         in:A6 = sound driver state pointer | mod:D0, A1, A5, A6

$030A5C  FM Full Silence                                   [Game / Sound]
         stop all channels and reset tempo Calls channel stop ($03094E) to silence all FM/PSG channels, then calls special channel cleanup ($0309F2) for DAC...
         in:A6 = sound driver state pointer | mod:A6

$030A72  Sound Counter Check                               [Sound]
         Reads A6+$04 status byte.
         in:A6 = sound state pointer | mod:D0 Fields accessed: A6+$04 (status), A6+

$030A86  FM Envelope Tick Update                           [Game / Sound]
         advance all channel envelopes per frame Decrements frame counter (A6+$04); if zero, branches to silence handler ($030B90).
         in:A6 = sound driver state pointer | mod:D6, D7, A5, A6 | calls:$030DF4: z80_dac_write $03135A: [fm_envelope_write] $030F60:

$030AF8  Sound Overflow Scan                               [Sound]
         Reads byte from A6+$02, adds to A6+$01.
         in:A6 = sound state pointer | mod:D0, D1, A0 Fields accessed: A6+$01, A6+$

$030B1C  FM Total Level Reset                              [Game / Sound]
         set all operator volumes to maximum attenuation Requests Z80 bus, then writes all FM Total Level registers ($40-$53) with $7F (maximum attenuation ...
         mod:D0, D1, D3, D4 | calls:$030CCC: fm_write_conditional $030D1C: z80_bus_request

$030B50  FM Key-Off + Volume Zero                          [Game / Sound]
         key-off all channels and zero volumes Requests Z80 bus, writes key-off (register $28) for all 6 FM channels (0-2 and 4-6).
         mod:D0, D1, D2, D3 | calls:$030CD8: fm_write_port0 $030D1C: z80_bus_request

$030B90  FM Sound Driver Reset                             [Game / Sound]
         full/partial silence and state clear Two entry points: $030B90 (full reset): Writes DAC enable ($2B=$80), key-off all ($27=$00), clears entire driv...
         in:A6 = sound driver state pointer | mod:D0, D1, A0, A6 | calls:$030CBA: fm_write_wrapper

$030BE0  Sound Buffer Clear                                [Sound]
         Clears 120 longwords ($1E0 bytes) starting at A6+$40, then sets byte at A6+$09 to $80.
         in:A6 = sound state pointer | mod:D0, A0 Fields written: A6+$40 through A6

$030BF6  Z80 Sound Program Upload + FM Key-On              [Game / Sound]
         load driver and key-on helper Two parts: $030BF6: Requests Z80 bus, uploads sound program from $031688 to Z80 RAM ($A00000, $28D bytes), uploads DA...
         in:A5 = FM channel structure pointer (for key-on entry); A6 = s | mod:D0, D1, A0, A1, A5, A6

$030C8A  FM Init Channel                                   [Game / Sound]
         key-on with flag checks (fm_init_channel) Two entry points: $030C8A: Checks bit 4 (sustain) and bit 2 (key-off).
         in:A5 = FM channel structure pointer (+$01=channel number) | mod:D0, D1, A5

$030CA2  FM Conditional Write with Bus                     [Game / Sound]
         write FM register if not key-off Checks bit 2 (key-off) on channel (A5).
         in:A5 = FM channel structure pointer; D0 = FM register number,  | mod:D0, D1, A5 | calls:$030CCC: fm_write_conditional $030D1C: z80_bus_request

$030CBA  FM Write Wrapper                                  [Game / Sound]
         request bus, write port 0, release (fm_write_wrapper) Convenience wrapper: requests Z80 bus, calls fm_write_port0 to write register D0 with data D1...
         in:D0 = FM register number, D1 = data value | calls:$030CD8: fm_write_port0 $030D1C: z80_bus_request

$030CCC  FM Write Conditional                              [Game / Sound]
         write port 0 with channel offset (fm_write_conditional) Checks bit 2 in A5+$01 (channel flags).
         in:A5 = FM channel structure pointer (+$01=channel/flags); D0 = | mod:D0, D1, A0

$030CF4  FM Write Port 0/1                                 [Game / Sound]
         channel-offset write + direct port 1 write Two entry points: $030CF4 (fm_write_port0): Reads channel byte from A5+$01, clears bit 2, adds offset to...
         in:A5 = FM channel structure pointer (for port 0 entry); D0 = F | mod:D0, D1, D2, A0

$030D1C  Z80 Bus Wait                                      [Sound]
         Requests Z80 bus, waits for grant, then checks sound driver status at Z80 RAM $A00FFF bit 7.
         in:none | mod:none (all implicit via hardware register

$030D4E  FM Fade In/Out Processor                          [Game / Sound]
         adjust all channel volumes per frame Checks fade state at A6+$38 (0=off, 2=done → skip).
         in:A6 = sound driver state pointer | mod:D5, D6, D7, A5, A6

$030DEE  FM Fade Clear                                     [Game / Sound]
         reset fade state to off Clears fade state byte (A6+$38 = 0) to disable fade processing.
         in:A6 = sound driver state pointer | mod:A6

$030DF4  Z80 Sound Write                                   [Sound]
         Requests Z80 bus, waits for grant, reads channel volume from A5+$09, shifts right 3 and masks to 4 bits, writes to Z80 RAM at $A00FFD, then release...
         in:A5 = channel state pointer | mod:D0 Hardware: $A11100 (Z80 bus request), 

$030E20  PSG Channel Processor                             [Game / Sound]
         tick handler with sequence parser FM/PSG register pair table at $030E20-$030E37.
         in:A5 = PSG channel structure pointer | mod:D1, D5, D6, A0, A3, A4, A5, A6

$030ECE  PSG Sequence Tick                                 [Game / Sound]
         read frequency and write PSG tone registers Checks channel active (A5+$0A), mute (bit 1), key-off (bit 2).
         in:A5 = PSG channel structure pointer | mod:D0, D1, D6, A5 | calls:$0302EE: fm_sequence_process

$030F0E  PSG Volume Envelope Processor                     [Game / Sound]
         step through volume envelope data Reads envelope position (A5+$09) as base volume D6.
         in:A5 = PSG channel structure pointer | mod:D0, D6, A0, A5

$030F82  PSG Vibrato Check                                 [Game / Sound]
         conditional PSG write based on vibrato state Checks vibrato enable (A5+$13).
         in:A5 = PSG channel structure pointer | mod:A5

$030F90  PSG Envelope Command Handler                      [Game / Sound]
         rewind/mute for volume envelope Two entry points for special envelope command bytes: $030F90: Rewind 2 positions (SUBQ.
         in:A5 = PSG channel structure pointer | mod:A5

$030FA2  PSG Set Position + Silence                        [Game / Sound]
         envelope position set and PSG mute Multiple entry points: $030FA2: Set envelope position from next data byte, resume reading.
         in:A5 = PSG channel structure pointer | mod:D0, A0

$030FC8  PSG All Silence                                   [Game / Sound]
         mute all 4 PSG channels Writes maximum attenuation to all 4 PSG channels via $C00011: $9F (ch0 vol=F), $BF (ch1 vol=F), $DF (ch2 vol=F), $FF (ch3 v...
         mod:A0

$030FE0  PSG Frequency Table + Special Command Dispatcher  [Game / Sound]
         data and $E0+ handler Data prefix ($030FE0-$031093): 128-entry PSG frequency lookup table (16-bit big-endian values, note $00-$7F).
         in:A5 = channel structure pointer, A4 = sequence pointer; A6 =  | mod:D0, D1, D3, D4, D5, D7, A0, A1, A4, A5, 

$031166  Z80 DAC Byte Write                                [Game / Sound]
         write sequence byte to Z80 DAC register Reads one byte from sequence pointer (A4), requests Z80 bus, writes byte to Z80 DAC register at $A00FFE, re...
         in:A4 = sequence data pointer (advanced by 1) | mod:D0, A4 | calls:$030D1C: z80_bus_request

$03117C  Set Base Frequency                                [Game / Sound]
         read 16-bit frequency from sequence Reads 2 bytes from sequence pointer (A4) as big-endian 16-bit value (high byte first via LSL #8).
         in:A4 = sequence data pointer (advanced by 2); A5 = channel str | mod:D0, A4

$031188  Pitch Bend Apply                                  [Game / Sound]
         apply portamento/bend to base frequency Reads channel index from sequence (A4), doubles for word offset.
         in:A4 = sequence data pointer (advanced by 1); A5 = channel str | mod:D0, D1, A4

$0311A8  Sound Subtract Field                              [Sound]
         Reads an indexed word from A6 structure, subtracts it from A5+$1E, then clears the indexed byte.
         in:D0 = index*2, A5 = channel state, A6 = sound state | mod:D1 Fields accessed: A6+$12+D0.W (word), 

$0311B8  FM Set Panning                                    [Game / Sound]
         write panning register from sequence byte Reads panning value from sequence (A4).
         in:A5 = channel structure pointer, A4 = sequence pointer | mod:D0, D1, A4

$0311D8  Sound Set Position                                [Sound]
         Reads a byte from stream (A4)+, sign-extends to word, and stores to A5+$1E (position field).
         in:A4 = data stream pointer, A5 = channel state | mod:D0 Fields written: A5+$1E

$0311E2  Set Channel Multiplier                            [Game / Sound]
         read multiplier from sequence Reads one byte from sequence pointer (A4), stores to sound driver channel multiplier at A6+$03.
         in:A4 = sequence pointer, A6 = sound driver state pointer | mod:A4

$0311E8  TL Reset + Panning Envelope Setup                 [Game / Sound]
         reset volumes or init envelope Two entry points: $0311E8: Calls TL reset ($030B1C) to silence all operators, then branches to $031418 for further p...
         in:A5 = channel structure pointer, A4 = sequence pointer | mod:A4

$03120C  Write Panning + PSG Volume Adjust                 [Game / Sound]
         two sequence command handlers Two entry points: $03120C: Writes current panning value (A5+$27) to register $B4 via fm_conditional_write ($030CA2).
         in:A5 = channel structure pointer, A4 = sequence pointer | mod:D0, D1, A4

$031228  Volume Adjust + Write                             [Game / Sound]
         add delta and route to channel writer Two entry points: $031228: Reads volume delta from sequence (A4), adds to A5+$09.
         in:A5 = channel structure pointer, A4 = sequence pointer; A6 =  | mod:D0, A4

$031240  Sound Load Pair                                   [Sound]
         Reads one byte from (A4) without increment to A5+$12, then reads (A4)+ with increment to A5+$13.
         in:A4 = data stream pointer, A5 = channel state | mod:none Fields written: A5+$12, A5+$13

$03124A  FM Operator Register Write                        [Game / Sound]
         load and write 4 operator values Loads instrument data from A6+$30 pointer (or A5+$20 if set).
         in:A5 = channel structure pointer, A4 = sequence pointer; A6 =  | mod:D0, D1, D3, D6, A0, A1, A2, A4 | calls:$030CA2: fm_conditional_write $030CBA: fm_write_wrapper

$0312A6  Set Instrument Number                             [Game / Sound]
         read instrument index from sequence Reads one byte from sequence pointer (A4), stores to sound driver instrument number at A6+$0A.
         in:A4 = sequence pointer, A6 = sound driver state pointer | mod:A4

$0312AC  Sound Add Transpose                               [Sound]
         Reads a byte from stream (A4)+ and adds it to A5+$09 (transpose).
         in:A4 = data stream, A5 = channel state | mod:D0 Fields modified: A5+$09

$0312B4  FM Instrument Register Write                      [Game / Sound]
         full operator + TL register setup Multiple entry points: $0312B4: Write register pair (D0,D1 from seq) via fm_conditional_write.
         in:A5 = channel structure pointer, A4 = sequence pointer; A6 =  | mod:D0, D1, D3, D4, D5, A1, A2, A4 | calls:$030CCC: fm_write_conditional $030D1C: z80_bus_request

$031352  FM TL Scaling Table + Volume Register Writer      [Game / Sound]
         update TL with volume 8-byte key scaling table at $031352 (operator TL scaling bits for 8 algorithm types).
         in:A5 = channel structure pointer; A6 = sound driver state poin | mod:D0, D1, D3, D4, D5, A1, A2 | calls:$030CCC: fm_write_conditional $030D1C: z80_bus_request

$0313CA  FM Register Table + Vibrato Setup                 [Game / Sound]
         operator registers and vibrato init Data prefix ($0313CA-$0313E1): FM operator register number table (20 register bytes for DT/MUL, TL, RS/AR, DR, ...
         in:A5 = channel structure pointer, A4 = sequence pointer | mod:D0, A4

$031406  PSG Set Envelope                                  [Game / Sound]
         route by channel type and set envelope number Reads byte from sequence.
         in:A5 = channel structure pointer, A4 = sequence pointer | mod:D0, A4

$031418  FM Note-Off Handler                               [Game / Sound]
         key-off channel and cleanup related channels Clears active (bit 7) and sustain (bit 4) flags.
         in:A5 = channel structure pointer; A6 = sound driver state poin | mod:D0, D1, A0, A1, A3, A5 | calls:$030C8A: fm_init_channel $030CBA: fm_write_wrapper $030FB2: 

$0314DC  Sound PSG Write                                   [Sound]
         Sets A5+$01 to $E0 (PSG latch byte), reads stream byte to A5+$25, then if bit 2 of (A5) is clear, writes the byte to PSG port $C00011.
         in:A4 = data stream, A5 = channel state | mod:none Fields modified: A5+$01, A5+$25 Har

$0314F6  Set Envelope Number                               [Game / Sound]
         read envelope index from sequence Reads one byte from sequence pointer (A4), stores to channel envelope number at A5+$0A.
         in:A5 = channel structure pointer, A4 = sequence pointer | mod:A4

$0314FC  Set Instrument Index                              [Game / Sound]
         read instrument number from sequence Reads one byte from sequence pointer (A4), stores to channel instrument index at A5+$0B.
         in:A5 = channel structure pointer, A4 = sequence pointer | mod:A4

$031502  Sound Stream Jump                                 [Sound]
         Reads a big-endian 16-bit word from the data stream (A4), adds it as a signed displacement to A4, then adjusts by -1.
         in:A4 = data stream pointer | mod:D0, A4 (repositioned)

$03150E  Sequence Loop Counter                             [Game / Sound]
         decrement loop and skip on exhaust Reads loop index and initial count from sequence (A4).
         in:A5 = channel structure pointer, A4 = sequence pointer | mod:D0, D1, A4

$031528  Sequence Call/Return Stack                        [Game / Sound]
         push/pop sequence pointer Two entry points: $031528 (call): Reads stack pointer from A5+$0D, decrements by 4, pushes current A4 to stack at A5+offset.
         in:A5 = channel structure pointer, A4 = sequence pointer | mod:D0, A4

$03154E  Set Channel Tempo                                 [Game / Sound]
         read tempo byte from sequence Reads one byte from sequence pointer (A4), stores to channel tempo divider at A5+$02.
         in:A5 = channel structure pointer, A4 = sequence pointer | mod:A4

$031554  Sound Add Volume                                  [Sound]
         Reads a byte from stream (A4)+ and adds it to A5+$08 (volume).
         in:A4 = data stream, A5 = channel state | mod:D0 Fields modified: A5+$08

$03155C  Sound Flag Set                                    [Sound]
         Sets bit 7 of field $0A at A5 (enables channel processing).
         in:A5 = channel state pointer | mod:none Fields modified: A5+$0A (bit 7 set)

$031564  Sound Flag Clear                                  [Sound]
         Clears bit 7 of field $0A at A5 (disables channel processing).
         in:A5 = channel state pointer | mod:none Fields modified: A5+$0A (bit 7 clea

$03156C  Sound Channel Mute                                [Sound]
         Clears byte at A6+$00 (mutes channel by zeroing status).
         in:A6 = sound state pointer | mod:D0 Fields modified: A6+$00

$031574  FM SSG-EG Register Write                          [Game / Sound]
         write 4 operator SSG-EG values Loads register table from $031590 (8 bytes: 4 pairs of SSG-EG register + reset register numbers).
         in:A5 = channel structure pointer, A4 = sequence pointer | mod:D0, D1, D3, A1, A4 | calls:$030CA2: fm_conditional_write

$031590  FM Register Table + Channel Pause                 [Game / Sound]
         data and pause all active channels Data prefix ($031590-$031597): 8 FM register numbers for SSG-EG writes (used by fm_ssg_eg_reg_write).
         in:A5 = channel structure pointer, A4 = sequence pointer; A6 =  | mod:D0, D1, D3, D4, A3, A5 | calls:$030C8A: fm_init_channel $030CA2: fm_conditional_write $030F

$0315F4  FM Channel Resume Panning                         [Game / Sound]
         restore panning for paused channels Resumes paused channels by restoring panning registers.
         in:A5 = channel structure pointer (saved/restored); A6 = sound  | mod:D0, D1, D3, D4, A3, A5 | calls:$030CA2: fm_conditional_write

$031650  Sound Set All Channels                            [Sound]
         Reads a byte from stream (A4)+ and writes it to offset $02 of each of 10 channel entries (spaced $30 bytes apart) starting at A6+$40.
         in:A4 = data stream, A6 = sound state | mod:D0, D1, D2, A0 Fields modified: A6+$40+n

$031666  sequence_fade_rate_set                            [Game / Sound]
         Sequence Fade Rate Set Sets fade rate parameters from sequence data.
         in:A4 = sequence data pointer, A6 = channel struct pointer | mod:A4, A6 Channel fields: +$38: fade state 

$031680  Sound Master Flag                                 [Sound]
         Sets byte at A6+$38 to $80 (master sound flag).
         in:A6 = sound state pointer | mod:none Fields modified: A6+$38

??????  Init Sequence                                     [Boot]
         (no description)

??????  Ring Buffer Initialization ($TBD)                 [Boot]
         Initializes the async command queue ring buffer in SDRAM.

??????  Hw Reg Init                                       [Hardware Regs]
         (no description)

??????  Bank Register Probe                               [Optimization]
         Identifies 68K access path to expansion ROM Location: Optimization area (code_1c200 section) The expansion ROM ($300000-$3FFFFF) contains 1MB of mo...

??????  FPS Marker Hook - Size-neutral palette+marker wrapper  [Optimization]
         Location: Optimization area (code_1c200) Called from fn_200_041 in place of two PC-relative JSRs to palette copy routines at $0048D6 and $0048DA.

??????  FPS Renderer - 2-Digit Frame Counter Display      [Optimization]
         Location: Optimization area ($89C208+, after fps_vint_wrapper) Renders the current FPS value (from fps_value at $FFFFF802) to both frame buffers us...

??????  FPS V-INT Wrapper - Frame Rate Measurement via FS Bit Tracking  [Optimization]
         Location: MUST be first module in optimization area ($89C208) Thin wrapper inserted before the original V-INT handler via vector redirect.

??????  Virtua Racing Deluxe - SH2 Code Section           [Sh2]
         Module: 68k/sh2/section_24200.

??????  Virtua Racing Deluxe - SH2 Data Section           [Sh2]
         Module: 68k/sh2/section_26200.

??????  Z80 Commands                                      [Sound]
         (no description)

??????  Random Number Generation ($00496E)                [Util]
         Pseudo-random number generator using Linear Congruential Generator (LCG).

??????  Utility Functions ($0049xx)                       [Util]
         General-purpose utility functions used throughout the game: - Random number generation - V-blank synchronization - Display parameter initialization...

```
