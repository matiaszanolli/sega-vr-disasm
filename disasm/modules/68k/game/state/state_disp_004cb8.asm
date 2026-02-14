; ============================================================================
; State Dispatcher (5-Entry Jump Table + 6 Subroutines, Data Prefix)
; ROM Range: $004CB8-$004D00 (72 bytes)
; ============================================================================
; Category: game
; Purpose: Data prefix: 2 words ($A2A0, $A100) — RAM buffer addresses.
;   Dispatches via 5-entry longword jump table indexed by
;   state_dispatch_idx ($C87E). State 0 handler: calls VDPSyncSH2,
;   init ($0020D6), animation_update, frame_update ($00B02C),
;   sprite_setup ($00B632), sprite_input_check, advances state by 4,
;   writes $10 to SH2 COMM.
;
; Uses: D0, D3, D7, A1, A2
; RAM:
;   $C87E: state_dispatch_idx (word)
; Calls:
;   $0020D6: init handler
;   $0028C2: VDPSyncSH2
;   $0058C8: sprite_input_check
;   $00B02C: frame_update
;   $00B09E: animation_update
;   $00B632: sprite_setup
; ============================================================================

state_disp_004cb8:
; --- data prefix: 2-word buffer addresses ---
        dc.w    $A2A0                           ; $004CB8  buffer addr A
        dc.w    $A100                           ; $004CBA  buffer addr B
; --- code ---
        move.w  ($FFFFC87E).w,D0               ; $004CBC  D0 = state_dispatch_idx
        movea.l $004CC6(PC,D0.W),A1            ; $004CC0  A1 = handler address
        jmp     (A1)                            ; $004CC4  dispatch
; --- jump table (5 longword entries) ---
        dc.l    $00884CDA                       ; $004CC6  [00] → state 0 handler
        dc.l    $00884D00                       ; $004CCA  [04] → $004D00 (past fn)
        dc.l    $00884D1A                       ; $004CCE  [08] → $004D1A (past fn)
        dc.l    $00884D7A                       ; $004CD2  [0C] → $004D7A (past fn)
        dc.l    $0088573C                       ; $004CD6  [10] → $00573C (past fn)
; --- state 0 handler ---
        jsr     mars_dma_xfer_vdp_fill(pc); $4EBA $DBE6
        jsr     sound_update_disp(pc)   ; $4EBA $D3F6
        jsr     cascaded_frame_counter+10(pc); $4EBA $63BA
        jsr     speed_scale_simple(pc)  ; $4EBA $6344
        jsr     lap_value_store_1(pc)   ; $4EBA $6946
        jsr     sh2_handler_dispatch_scene_init+98(pc); $4EBA $0BD8
        addq.w  #4,($FFFFC87E).w               ; $004CF2  advance state
        move.w  #$0010,$00FF0008               ; $004CF6  SH2 COMM = $10
        rts                                     ; $004CFE
