; ============================================================================
; Vint Scene 070 (auto-analyzed)
; ROM Range: $003DD4-$003E08 (52 bytes)
; ============================================================================
; Category: game
; Purpose: RAM: $C8AA (scene_state), $C8AC (state_dispatch_idx)
;
; RAM:
;   $C8AA: scene_state
;   $C8AC: state_dispatch_idx
; Confidence: high
; ============================================================================

fn_2200_070:
        CMPI.W  #$0014,(-14166).W               ; $003DD4
        BLE.S  .loc_0032                        ; $003DDA
        MOVE.L  #$222F29EE,$00FF69C8            ; $003DDC
        MOVE.L  #$222F1716,$00FF6998            ; $003DE6
        MOVE.W  #$0000,(-14166).W               ; $003DF0
        MOVE.B  #$A7,(-14172).W                 ; $003DF6
        BSET    #4,(-15602).W                   ; $003DFC
        ADDQ.W  #4,(-14164).W                   ; $003E02
.loc_0032:
        RTS                                     ; $003E06
