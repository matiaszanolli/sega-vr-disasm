; ============================================================================
; Vint Scene 075 (auto-analyzed)
; ROM Range: $003EA2-$003EC6 (36 bytes)
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

fn_2200_075:
        CMPI.W  #$0014,(-14166).W               ; $003EA2
        BLE.S  .loc_0022                        ; $003EA8
        MOVE.L  #$222F002C,$00FF6988            ; $003EAA
        MOVE.B  #$C2,(-14172).W                 ; $003EB4
        MOVE.W  #$0000,(-14166).W               ; $003EBA
        ADDQ.W  #4,(-14164).W                   ; $003EC0
.loc_0022:
        RTS                                     ; $003EC4
