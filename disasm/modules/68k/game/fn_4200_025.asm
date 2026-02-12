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

fn_4200_025:
        dc.w    $4EBA,$CBF8                     ; $0055D0  bsr.w $0021CA (sfx_queue_process)
        dc.w    $4EBA,$C1C8                     ; $0055D4  bsr.w $00179E (controller_poll)
        addq.w  #1,($FFFFC8AA).w               ; $0055D8  scene_state++
        dc.w    $4EBA,$035E                     ; $0055DC  bsr.w $00593C (sprite_state_process)
        dc.w    $4EBA,$665E                     ; $0055E0  bsr.w $00BC40 (sub D)
        dc.w    $4EBA,$64EE                     ; $0055E4  bsr.w $00BAD4 (sub E)
        dc.w    $4EBA,$60F0                     ; $0055E8  bsr.w $00B6DA (sprite_update)
        dc.w    $4EBA,$6096                     ; $0055EC  bsr.w $00B684 (object_update)
        addq.w  #4,($FFFFC87E).w               ; $0055F0  advance game_state
        move.w  #$0054,$00FF0008               ; $0055F4  display mode = $0054
        rts                                     ; $0055FC
