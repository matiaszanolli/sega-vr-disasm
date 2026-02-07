; ============================================================================
; Logic Sfx Queue Process 024 (auto-analyzed)
; ROM Range: $0055BA-$0055D0 (22 bytes)
; ============================================================================
; Category: game
; Purpose: Short helper function
;   RAM: $C87E (game_state)
;   Calls: sfx_queue_process, sprite_update_check
;
; RAM:
;   $C87E: game_state
; Calls:
;   $0021CA: sfx_queue_process
;   $005908: sprite_update_check
; Confidence: medium
; ============================================================================

fn_4200_024:
        DC.W    $4EBA,$CC0E         ; JSR     $0021CA(PC); $0055BA
        DC.W    $4EBA,$0348         ; JSR     $005908(PC); $0055BE
        ADDQ.W  #4,(-14210).W                   ; $0055C2
        MOVE.W  #$0010,$00FF0008                ; $0055C6
        RTS                                     ; $0055CE
