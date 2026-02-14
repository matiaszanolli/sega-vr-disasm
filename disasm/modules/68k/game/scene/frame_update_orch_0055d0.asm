; ============================================================================
; Frame Update Orchestrator (7 Subroutines + Scene Tick)
; ROM Range: $0055D0-$0055FE (46 bytes)
; ============================================================================
; Category: game
; Purpose: Calls 7 subroutines via bsr.w, increments scene_state ($C8AA),
;   advances game_state ($C87E) by 4. Display mode $0054.
;   Subroutine sequence: sfx_queue_process, controller_poll,
;   sprite_state_process, $00BC40, $00BAD4, sprite_update, object_update.
;
; Uses: D0 (from called routines)
; RAM:
;   $C8AA: scene_state (word, +1 per frame)
;   $C87E: game_state (word, advanced by 4)
; Calls:
;   $0021CA: sfx_queue_process
;   $00179E: controller_poll
;   $00593C: sprite_state_process
;   $00BC40: sub D
;   $00BAD4: sub E
;   $00B6DA: sprite_update
;   $00B684: object_update
; ============================================================================

frame_update_orch_0055d0:
        jsr     sound_update_disp+244(pc); $4EBA $CBF8
        jsr     controller_read_button_remap+16(pc); $4EBA $C1C8
        addq.w  #1,($FFFFC8AA).w               ; $0055D8  scene_state++
        jsr     race_entity_update_loop(pc); $4EBA $035E
        jsr     scene_command_disp+36(pc); $4EBA $665E
        jsr     scene_menu_init_and_input_handler+118(pc); $4EBA $64EE
        jsr     animated_seq_player+10(pc); $4EBA $60F0
        jsr     object_update(pc)       ; $4EBA $6096
        addq.w  #4,($FFFFC87E).w               ; $0055F0  advance game_state
        move.w  #$0054,$00FF0008               ; $0055F4  display mode = $0054
        rts                                     ; $0055FC
