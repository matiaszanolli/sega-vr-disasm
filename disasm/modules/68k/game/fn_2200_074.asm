; ============================================================================
; Vint Scene 074 (auto-analyzed)
; ROM Range: $003E7E-$003EA2 (36 bytes)
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

fn_2200_074:
        CMPI.W  #$0014,(-14166).W               ; $003E7E
        BLE.S  .loc_0022                        ; $003E84
        MOVE.L  #$222F038A,$00FF6988            ; $003E86
        MOVE.B  #$C1,(-14172).W                 ; $003E90
        MOVE.W  #$0000,(-14166).W               ; $003E96
        ADDQ.W  #4,(-14164).W                   ; $003E9C
.loc_0022:
        RTS                                     ; $003EA0
