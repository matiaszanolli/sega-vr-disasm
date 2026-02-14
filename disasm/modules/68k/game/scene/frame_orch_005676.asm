; ============================================================================
; Frame Orchestrator (8 Subroutines, 2 Entry Points, Controller Decode)
; ROM Range: $005676-$0056E4 (110 bytes)
; ============================================================================
; Category: game
; Purpose: Entry 1 ($5676): calls sfx, poll_controllers, 2 sprite handlers,
;   increments scene_state, reads controller byte from RAM pointer ($C8C0),
;   decodes to AI flags ($C971/$C973), calls 4 handlers, advances state,
;   writes $54 to SH2 COMM, tail-jumps to $56F8. Entry 2 ($56CE):
;   calls sfx, poll_controllers, increments scene_counter, writes $54.
;
; Uses: D0, D1, A0
; RAM:
;   $C87E: state_dispatch_idx (word)
;   $C8C0: controller_ptr (word)
;   $C886: scene_counter (byte)
;   $C8AA: scene_state (word)
;   $C970: work_param (longword, set to $FFFF0000)
;   $C971: ai_input_flags (byte, bits 2,3,4,6)
;   $C973: ai_direction_flags (byte, bits 0-1)
; Calls:
;   $00179E: poll_controllers
;   $0021CA: sfx_queue_process
;   $00593C: sprite_state_process
;   $00B504/$00B522/$00B5CA: sprite handlers
;   $00B684: object_update
;   $00B6DA: sprite_update
; ============================================================================

frame_orch_005676:
; --- entry 1: full orchestrator ---
        jsr     sound_update_disp+244(pc); $4EBA $CB52
        jsr     controller_read_button_remap+16(pc); $4EBA $C122
        jsr     display_digit_extract+58(pc); $4EBA $5E84
        jsr     display_digit_extract+88(pc); $4EBA $5E9E
        addq.w  #1,($FFFFC8AA).w                ; $005686  scene_state++
        move.l  #$FFFF0000,($FFFFC970).w        ; $00568A  clear work param
        movea.w ($FFFFC8C0).w,A0                ; $005692  A0 = controller_ptr
        move.b  (A0)+,D0                        ; $005696  D0 = controller byte
        move.b  D0,D1                           ; $005698  D1 = copy
        andi.b  #$5C,D0                         ; $00569A  extract bits 2,3,4,6
        move.b  D0,($FFFFC971).w                ; $00569E  ai_input_flags
        andi.b  #$03,D1                         ; $0056A2  extract bits 0-1
        move.b  D1,($FFFFC973).w                ; $0056A6  ai_direction_flags
        move.w  A0,($FFFFC8C0).w                ; $0056AA  advance controller_ptr
        jsr     lap_disp_update_vdp_tile_write+28(pc); $4EBA $5F1A
        jsr     race_entity_update_loop(pc); $4EBA $0288
        jsr     animated_seq_player+10(pc); $4EBA $6022
        jsr     object_update(pc)       ; $4EBA $5FC8
        addq.w  #4,($FFFFC87E).w                ; $0056BE  advance state
        move.w  #$0054,$00FF0008                ; $0056C2  SH2 COMM = $54
        jmp     pause_menu_handler_ctrl_check+20(pc); $4EFA $002C
; --- entry 2: reduced orchestrator ---
        jsr     sound_update_disp+244(pc); $4EBA $CAFA
        jsr     controller_read_button_remap+16(pc); $4EBA $C0CA
        addq.b  #1,($FFFFC886).w                ; $0056D6  scene_counter++
        move.w  #$0054,$00FF0008                ; $0056DA  SH2 COMM = $54
        rts                                     ; $0056E2
