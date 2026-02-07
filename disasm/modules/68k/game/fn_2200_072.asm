; ============================================================================
; Vint Scene 072 (auto-analyzed)
; ROM Range: $003E52-$003E64 (18 bytes)
; ============================================================================
; Category: game
; Purpose: Short helper function
;   RAM: $C8AA (scene_state), $C8AC (state_dispatch_idx)
;
; Uses: D2, D7, A1
; RAM:
;   $C8AA: scene_state
;   $C8AC: state_dispatch_idx
; Confidence: high
; ============================================================================

fn_2200_072:
        DC.W    $8383                           ; $003E52
        OR.L   (A1)+,D2                         ; $003E54
        SUB.L  (A1)+,D7                         ; $003E56
        MOVE.W  #$0000,(-14166).W               ; $003E58
        ADDQ.W  #4,(-14164).W                   ; $003E5E
        RTS                                     ; $003E62
