; ============================================================================
; Vint Velocity 028 (auto-analyzed)
; ROM Range: $002DCA-$002DF4 (42 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A0, A1): +$24, +$64, +$8A (param_8a), +$8C (velocity_x)
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, A0, A1, A2
; Object fields:
;   +$24: [unknown]
;   +$64: [unknown]
;   +$8A: param_8a
;   +$8C: velocity_x
; Confidence: low
; ============================================================================

fn_2200_028:
        MOVE.W  $008A(A0),D0                    ; $002DCA
        DC.W    $6744               ; BEQ.S  $002E14; $002DCE
        SUBQ.W  #1,D0                           ; $002DD0
        DC.W    $6720               ; BEQ.S  $002DF4; $002DD2
        MOVE.L  (-14516).W,$0024(A1)            ; $002DD4
        MOVE.L  (-14516).W,$0128(A2)            ; $002DDA
        MOVE.W  #$0001,$0064(A1)                ; $002DE0
        TST.W  $008C(A0)                        ; $002DE6
        DC.W    $6746               ; BEQ.S  $002E32; $002DEA
        MOVE.W  #$0000,$0064(A1)                ; $002DEC
        RTS                                     ; $002DF2
