; ============================================================================
; Vint 041 (auto-analyzed)
; ROM Range: $003126-$003160 (58 bytes)
; ============================================================================
; Category: vint
; Purpose: RAM: $C8C8 (vint_state)
;   Object (A1): +$02 (flags/type), +$06 (speed), +$08, +$0A (param_a), +$0C
;
; Entry: A1 = object/entity pointer
; Uses: D0, A0, A1
; RAM:
;   $C8C8: vint_state
; Object fields:
;   +$02: flags/type
;   +$06: speed
;   +$08: [unknown]
;   +$0A: param_a
;   +$0C: [unknown]
; Confidence: medium
; ============================================================================

fn_2200_041:
        LEA     (-28672).W,A0                   ; $003126
        LEA     $00FF6100,A1                    ; $00312A
        MOVE.W  (-16250).W,$0002(A1)            ; $003130
        DC.W    $4EBA,$F85E         ; JSR     $002996(PC); $003136
        MOVE.W  (-16210).W,D0                   ; $00313A
        ADD.W  D0,$0008(A1)                     ; $00313E
        MOVE.W  (-16208).W,D0                   ; $003142
        ADD.W  D0,$000A(A1)                     ; $003146
        MOVE.W  (-16206).W,D0                   ; $00314A
        ADD.W  D0,$000C(A1)                     ; $00314E
        TST.W  (-14136).W                       ; $003152
        BEQ.S  .loc_0038                        ; $003156
        ADDI.W  #$00E0,$0006(A1)                ; $003158
.loc_0038:
        RTS                                     ; $00315E
