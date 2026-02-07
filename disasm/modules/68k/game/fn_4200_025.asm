; ============================================================================
; Obj Poll Controllers 025 (auto-analyzed)
; ROM Range: $0055D0-$0055FE (46 bytes)
; ============================================================================
; Category: object
; Purpose: Orchestrator calling 7 subroutines
;   RAM: $C8AA (scene_state), $C87E (game_state)
;   Calls: sfx_queue_process, poll_controllers, sprite_state_process, sprite_update
;
; RAM:
;   $C87E: game_state
;   $C8AA: scene_state
; Calls:
;   $00179E: poll_controllers
;   $0021CA: sfx_queue_process
;   $00593C: sprite_state_process
;   $00B684: object_update
;   $00B6DA: sprite_update
; Confidence: high
; ============================================================================

fn_4200_025:
        DC.W    $4EBA,$CBF8         ; JSR     $0021CA(PC); $0055D0
        DC.W    $4EBA,$C1C8         ; JSR     $00179E(PC); $0055D4
        ADDQ.W  #1,(-14166).W                   ; $0055D8
        DC.W    $4EBA,$035E         ; JSR     $00593C(PC); $0055DC
        DC.W    $4EBA,$665E         ; JSR     $00BC40(PC); $0055E0
        DC.W    $4EBA,$64EE         ; JSR     $00BAD4(PC); $0055E4
        DC.W    $4EBA,$60F0         ; JSR     $00B6DA(PC); $0055E8
        DC.W    $4EBA,$6096         ; JSR     $00B684(PC); $0055EC
        ADDQ.W  #4,(-14210).W                   ; $0055F0
        MOVE.W  #$0054,$00FF0008                ; $0055F4
        RTS                                     ; $0055FC
