; ============================================================================
; Code Section ($000200-$0021FF)
; Generated from ROM bytes - guaranteed accurate
; ============================================================================

        org     $000200

        include "modules/68k/boot/exception_vector_trampolines.asm"
        include "modules/68k/boot/adapter_boot_entry.asm"
; === Original copyright/security text (DO NOT MODIFY - game checks this!) ===
        include "modules/68k/game/render/vdp_reg_table_load.asm"
        include "modules/68k/game/render/vdp_vram_clear_via_dma.asm"
        include "modules/68k/game/render/framebuffer_auto_fill_clear.asm"
        include "modules/68k/game/render/gfx_32x_cram_fill.asm"
        include "modules/68k/game/state/system_boot_init.asm"
        include "modules/68k/game/state/register_restore_from_table.asm"
        include "modules/68k/game/state/hardware_init.asm"
        include "modules/68k/game/scene/system_init_orch.asm"
        include "modules/68k/game/state/double_cond_guard.asm"
        include "modules/68k/game/render/vdp_display_init.asm"
        include "modules/68k/game/render/vdp_reg_init.asm"
        include "modules/68k/game/render/vdp_dma_xfer_vram_clear.asm"
        include "modules/68k/vdp/vdp_data_fill.asm"
        include "modules/68k/vdp/vdp_data_fill_constant.asm"
        include "modules/68k/game/data/tile_decompressor_setup.asm"
        include "modules/68k/game/data/huffman_lz_decompression_inner_loop.asm"
        include "modules/68k/game/data/tile_decompressor_inner_loop_a.asm"
        include "modules/68k/game/data/tile_decompressor_inner_loop_b.asm"
        include "modules/68k/game/data/tile_decompressor_inner_loop_c.asm"
        include "modules/68k/game/data/tile_data_stream_byte_read.asm"
        include "modules/68k/game/data/tile_decompressor_engine.asm"
        include "modules/68k/game/data/tile_bit_stream_unpacker.asm"
        include "modules/68k/game/data/tile_bit_stream_refill_with_mask_table.asm"
        include "modules/68k/util/lzss_decompress.asm"
        include "modules/68k/vdp/vdp_reg_write_multi.asm"
        include "modules/68k/vdp/vdp_reg_write_simple.asm"
        include "modules/68k/vdp/vdp_reg_write_read.asm"
        include "modules/68k/game/data/tile_decompression_disp_a.asm"
        include "modules/68k/game/data/tile_decompression_disp_b.asm"
        include "modules/68k/game/render/nametable_copy_disp.asm"
        include "modules/68k/game/data/descriptor_table_bit_unpacker_disp.asm"
        include "modules/68k/game/render/vdp_row_copy_disp.asm"
; --- VDP row copy parameter table ($00166C-$001682, 24 bytes DATA) ---
; Two 12-byte entries: each has autoincrement, DMA length, source addr, count fields.
; Entry 1: VRAM $659C, 13 words, 3 rows.  Entry 2: VRAM $6000, 39 words, 27 rows.
        dc.w    $00FF        ; $00166C - Entry 1: auto-increment
        dc.w    $1000        ; $00166E
        dc.w    $659C        ; $001670 - VRAM destination
        dc.w    $0002        ; $001672
        dc.w    $000D        ; $001674 - DMA word count
        dc.w    $0003        ; $001676 - Row count
        dc.w    $00FF        ; $001678 - Entry 2: auto-increment
        dc.w    $1000        ; $00167A
        dc.w    $6000        ; $00167C - VRAM destination
        dc.w    $0002        ; $00167E
        dc.w    $0027        ; $001680 - DMA word count
        dc.w    $001B        ; $001682 - Row count
; ============================================================================
; V-INT Handler ($001684) - Assembly mnemonics
; Per VINT_HANDLER_ARCHITECTURE.md - 16-state dispatch system
; Note: .w suffix forces absolute short addressing (4 bytes vs 6 for long)
; ============================================================================
vint_handler:                           ; $001684
        tst.w   $FFFFC87A.w             ; Check pending V-INT state
        beq.s   .no_work                ; If zero, nothing to do

        move.w  #$2700,sr               ; Disable all interrupts
        movem.l d0-d7/a0-a6,-(sp)       ; Save 14 registers
        move.w  $FFFFC87A.w,d0          ; Load state index
        move.w  #0,$FFFFC87A.w          ; Clear - MUST be 6 bytes (not CLR.W=4 bytes)!
        dc.w    $227B,$0014             ; MOVEA.L (PC,$14),A1 - vasm can't mnemonic this!
        jsr     (a1)                    ; Dispatch to state handler
        addq.l  #1,$FFFFC964.w          ; Increment frame counter (Work RAM)
        ; ASYNC: Disabled entirely (no space for init code in 68K section)
        movem.l (sp)+,d0-d7/a0-a6       ; Restore 14 registers
        move.w  #$2300,sr               ; Re-enable interrupts
        rte                             ; Return from V-INT

.no_work:
        rte                             ; $16B0 - Early exit (state was 0)
vint_jump_table:                        ; $0016B2
        include "modules/68k/game/state/input_dispatch_table_and_controller_port_init.asm"
        include "modules/68k/game/state/controller_read_button_remap.asm"
        include "modules/68k/game/state/clear_input_state_flags.asm"
        include "modules/68k/input/joypad_process.asm"
        include "modules/68k/input/joypad_read_hw.asm"
        include "modules/68k/input/joypad_read_3btn.asm"
        include "modules/68k/game/state/controller_input_init.asm"
        include "modules/68k/input/joypad_read_port.asm"
        include "modules/68k/game/render/vdp_dma_xfer_setup_0019ea.asm"
        include "modules/68k/game/render/set_v_int_dispatch_state_vdp_status_read.asm"
        include "modules/68k/game/render/vdp_dma_xfer_setup_001a72.asm"
        include "modules/68k/game/render/vdp_dma_xfer_setup_001aca.asm"
        include "modules/68k/game/render/vdp_dma_transfer_setup.asm"
        include "modules/68k/game/render/vdp_dma_palette_xfer_036.asm"
        include "modules/68k/game/render/vdp_dma_frame_swap_037.asm"
        include "modules/68k/game/render/vdp_reg_write_32x_adapter_control.asm"
        include "modules/68k/game/render/vdp_reg_write_frame_swap_cram_copy.asm"
        include "modules/68k/game/render/vdp_dma_cram_xfer.asm"
        include "modules/68k/game/render/vdp_dma_scroll_frame_swap.asm"
        include "modules/68k/game/scene/v_int_comm1_signal_handler.asm"
        include "modules/68k/game/scene/sh2_frame_sync_wrapper.asm"
        include "modules/68k/game/scene/clear_communication_state_variables.asm"
        include "modules/68k/game/state/set_communication_ready_flag.asm"
        include "modules/68k/game/race/sound_state_init_clear_comm_variables.asm"
        dc.w    $4E75        ; $00207E - RTS stub (empty function)
        include "modules/68k/game/race/sound_command_dispatch_sound_driver_call.asm"
        include "modules/68k/game/state/sound_update_disp.asm"
; --- Start of counter_increment_flag_set ($0021EE-$0021FE, 18 bytes) ---
; This function continues into code_2200.asm. MOVE.B #$0A,$FFFFC827;
; MOVE.B #$0F,$FFFFC828; TST.W $FFFFC8C8; BEQ.S $002204
        dc.w    $11FC        ; $0021EE
        dc.w    $000A        ; $0021F0
        dc.w    $C827        ; $0021F2
        dc.w    $11FC        ; $0021F4
        dc.w    $000F        ; $0021F6
        dc.w    $C828        ; $0021F8
        dc.w    $4A78        ; $0021FA - TST.W $C8C8
        dc.w    $C8C8        ; $0021FC
        dc.w    $6704        ; $0021FE - BEQ.S $002204
