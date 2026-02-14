; ============================================================================
; Frame Update Orchestrator (8 Subroutines)
; ROM Range: $005070-$00509E (46 bytes)
; ============================================================================
; Category: game
; Purpose: Calls 8 subroutines via bsr.w in sequence:
;   $002180 (frame init), $00179E (controller_poll),
;   $00B09E (animation_update), $00B094, $00B0DE, $00B128, $00B136,
;   $00640E (object handler).
;   Advances game_state by 4, sets display mode $001C.
;
; Uses: D0 (from called routines)
; RAM:
;   $C87E: game_state (word, advanced by 4)
; Calls:
;   $002180: frame init
;   $00179E: controller_poll
;   $00B09E: animation_update
;   $00B094: animation sub B
;   $00B0DE: animation sub C
;   $00B128: animation sub D
;   $00B136: animation sub E
;   $00640E: object handler
; ============================================================================

frame_update_orch_005070:
        jsr     sound_update_disp+170(pc); $4EBA $D10E
        jsr     controller_read_button_remap+16(pc); $4EBA $C728
        jsr     cascaded_frame_counter+10(pc); $4EBA $6024
        jsr     cascaded_frame_counter(pc); $4EBA $6016
        jsr     ai_timer_inc(pc)        ; $4EBA $605C
        jsr     ai_buffer_setup+14(pc)  ; $4EBA $60A2
        jsr     ai_buffer_setup+28(pc)  ; $4EBA $60AC
        jsr     entity_render_pipeline_with_vdp_dma_2p_copy+462(pc); $4EBA $1380
        addq.w  #4,($FFFFC87E).w               ; $005090  advance game_state
        move.w  #$001C,$00FF0008               ; $005094  display mode = $001C
        rts                                     ; $00509C
