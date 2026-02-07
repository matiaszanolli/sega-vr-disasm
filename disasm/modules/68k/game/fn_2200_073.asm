; ============================================================================
; Vint Scene 073 (auto-analyzed)
; ROM Range: $003E64-$003E7E (26 bytes)
; ============================================================================
; Category: game
; Purpose: Short helper function
;   RAM: $C8AA (scene_state), $C8AC (state_dispatch_idx)
;
; RAM:
;   $C8AA: scene_state
;   $C8AC: state_dispatch_idx
; Confidence: high
; ============================================================================

fn_2200_073:
        MOVE.W  #$0000,(-14166).W               ; $003E64
        ADDQ.W  #4,(-14164).W                   ; $003E6A
        MOVE.B  #$09,$00FF6980                  ; $003E6E
        MOVE.B  #$C0,(-14172).W                 ; $003E76
        RTS                                     ; $003E7C
