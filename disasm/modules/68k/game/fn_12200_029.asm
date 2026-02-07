; ============================================================================
; Camera Dispatch 029 (auto-analyzed)
; ROM Range: $013292-$013346 (180 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   RAM: $C87E (game_state)
;   Calls: object_update
;   Object (A0, A1): +$77, +$89
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, D1, D4, D5, D6, D7, A0, A1
; RAM:
;   $C87E: game_state
; Calls:
;   $00B684: object_update
; Object fields:
;   +$77: [unknown]
;   +$89: [unknown]
; Confidence: high
; ============================================================================

fn_12200_029:
        DC.W    $7FFF                           ; $013292
        DC.W    $7FFF                           ; $013294
        DC.W    $7FFF                           ; $013296
        DC.W    $7FFF                           ; $013298
        DC.W    $7FFF                           ; $01329A
        DC.W    $7FFF                           ; $01329C
        DC.W    $7FFF                           ; $01329E
        DC.W    $7FFF                           ; $0132A0
        DC.W    $7FFF                           ; $0132A2
        DC.W    $7FFF                           ; $0132A4
        DC.W    $7FFF                           ; $0132A6
        DC.W    $7FFF                           ; $0132A8
        DC.W    $4DC8                           ; $0132AA
        DC.W    $520B                           ; $0132AC
        ADDQ.W  #5,$62D1(A6)                    ; $0132AE
        DC.W    $4DC8                           ; $0132B2
        DC.W    $520B                           ; $0132B4
        ADDQ.W  #5,$62D1(A6)                    ; $0132B6
        DC.W    $4DC8                           ; $0132BA
        DC.W    $520B                           ; $0132BC
        ADDQ.W  #5,$62D1(A6)                    ; $0132BE
        DC.W    $4DC8                           ; $0132C2
        DC.W    $520B                           ; $0132C4
        ADDQ.W  #5,$62D1(A6)                    ; $0132C6
        DC.W    $4DC8                           ; $0132CA
        DC.W    $520B                           ; $0132CC
        ADDQ.W  #5,$62D1(A6)                    ; $0132CE
        MOVE.W  A2,($35EB).W                    ; $0132D2
        MOVE.W  $466F(A5),D7                    ; $0132D6
        DC.W    $7FFF                           ; $0132DA
        DC.W    $7FFF                           ; $0132DC
        DC.W    $7FFF                           ; $0132DE
        DC.W    $7FFF                           ; $0132E0
        DC.W    $7FFF                           ; $0132E2
        DC.W    $7FFF                           ; $0132E4
        DC.W    $7FFF                           ; $0132E6
        DC.W    $7FFF                           ; $0132E8
        MOVE.W  A2,($35EB).W                    ; $0132EA
        MOVE.W  $466F(A5),D7                    ; $0132EE
        MOVE.B  D1,(A2)+                        ; $0132F2
        MOVE.B  -(A2),-(A6)                     ; $0132F4
        DC.W    $2984                           ; $0132F6
        DC.W    $35E6                           ; $0132F8
.loc_0068:
        NEG.W  D5                               ; $0132FA
        SUBQ.B  #8,$6212(A3)                    ; $0132FC
        BGT.S  .loc_0068                        ; $013300
        DC.W    $7FFF                           ; $013302
        BTST    D1,(A7)+                        ; $013304
        DC.W    $7FFF                           ; $013306
        DC.W    $7FFF                           ; $013308
        MOVE.B  D1,(A2)+                        ; $01330A
        MOVE.B  -(A2),-(A6)                     ; $01330C
        DC.W    $2984                           ; $01330E
        DC.W    $35E6                           ; $013310
        JSR     $00882080                       ; $013312
        MOVE.W  (-14210).W,D0                   ; $013318
        MOVEA.L $013322(PC,D0.W),A1             ; $01331C
        JMP     (A1)                            ; $013320
        DC.W    $0089                           ; $013322
        MOVE.W  D6,$0089(A1)                    ; $013324
        MOVE.W  -$77(A0,D0.W),(A2)+             ; $013328
        MOVE.W  -(A4),D4                        ; $01332C
        DC.W    $4EBA,$8354         ; JSR     $00B684(PC); $01332E
        BTST    #6,(-14322).W                   ; $013332
        BNE.S  .loc_00AC                        ; $013338
        ADDQ.W  #4,(-14210).W                   ; $01333A
.loc_00AC:
        JSR     $0088205E                       ; $01333E
        RTS                                     ; $013344
