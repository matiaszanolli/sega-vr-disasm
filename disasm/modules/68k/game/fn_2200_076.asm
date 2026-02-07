; ============================================================================
; Vint Scene 076 (auto-analyzed)
; ROM Range: $003EC6-$003EF6 (48 bytes)
; ============================================================================
; Category: game
; Purpose: RAM: $C8AA (scene_state), $C8AC (state_dispatch_idx)
;
; RAM:
;   $C8AA: scene_state
;   $C8AC: state_dispatch_idx
; Confidence: high
; ============================================================================

fn_2200_076:
        CMPI.W  #$0014,(-14166).W               ; $003EC6
        BLE.S  .loc_002E                        ; $003ECC
        MOVE.L  #$222EEF3A,$00FF6988            ; $003ECE
        MOVE.B  #$C3,(-14172).W                 ; $003ED8
        MOVE.W  #$0000,(-14166).W               ; $003EDE
        BSET    #4,(-15602).W                   ; $003EE4
        BSET    #4,(-19218).W                   ; $003EEA
        ADDQ.W  #4,(-14164).W                   ; $003EF0
.loc_002E:
        RTS                                     ; $003EF4
