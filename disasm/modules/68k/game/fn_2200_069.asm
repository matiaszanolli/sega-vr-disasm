; ============================================================================
; Vint Scene 069 (auto-analyzed)
; ROM Range: $003DA6-$003DD4 (46 bytes)
; ============================================================================
; Category: game
; Purpose: RAM: $C8AA (scene_state), $C8AC (state_dispatch_idx)
;   Object (A1): +$00, +$08
;
; Entry: A1 = object/entity pointer
; Uses: A1, A6
; RAM:
;   $C8AA: scene_state
;   $C8AC: state_dispatch_idx
; Object fields:
;   +$00: [unknown]
;   +$08: [unknown]
; Confidence: high
; ============================================================================

fn_2200_069:
        CMPI.W  #$0014,(-14166).W               ; $003DA6
        BLE.S  .loc_002C                        ; $003DAC
        LEA     $00FF69C0,A1                    ; $003DAE
        MOVE.B  #$09,$0000(A1)                  ; $003DB4
        MOVE.L  #$222F1D4A,$0008(A1)            ; $003DBA
        MOVE.W  #$0000,(-14166).W               ; $003DC2
        MOVE.B  #$A6,(-14172).W                 ; $003DC8
        ADDQ.W  #4,(-14164).W                   ; $003DCE
.loc_002C:
        RTS                                     ; $003DD2
