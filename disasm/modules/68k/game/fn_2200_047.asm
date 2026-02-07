; ============================================================================
; Vint Dispatch 047 (auto-analyzed)
; ROM Range: $00337A-$0033E4 (106 bytes)
; ============================================================================
; Category: vint
; Purpose: State dispatcher using jump table
;   Object (A0, A4): +$2C, +$88
;
; Entry: A0 = object/entity pointer
; Entry: A4 = object/entity pointer
; Uses: D0, D2, D4, A0, A1, A2, A4, A6
; Object fields:
;   +$2C: [unknown]
;   +$88: [unknown]
; Confidence: low
; ============================================================================

fn_2200_047:
        MOVEQ   #$00,D0                         ; $00337A
        MOVE.B  (-15611).W,D0                   ; $00337C
        MOVEA.L $003386(PC,D0.W),A1             ; $003380
        JMP     (A1)                            ; $003384
        DC.W    $0088                           ; $003386
        MOVE.W  -(A6),(A2)+                     ; $003388
        DC.W    $0088                           ; $00338A
        MOVE.W  D4,D2                           ; $00338C
        DC.W    $0088                           ; $00338E
        MOVE.W  D2,$008833C2                    ; $003390
        DC.W    $0088                           ; $003396
        MOVE.W  D2,$008833C2                    ; $003398
        DC.W    $0088                           ; $00339E
        MOVE.W  D2,$008833C2                    ; $0033A0
        DC.W    $0088                           ; $0033A6
        MOVE.W  D2,$008833C2                    ; $0033A8
        DC.W    $0088                           ; $0033AE
        MOVE.W  D2,$008833C2                    ; $0033B0
        DC.W    $0088                           ; $0033B6
        MOVE.W  $0088(A4),$33FC0088             ; $0033B8
        MOVE.W  A2,(A2)+                        ; $0033C0
        MOVE.W  (-16242).W,D0                   ; $0033C2
        CMP.W  (-16262).W,D0                    ; $0033C6
        DC.W    $6718               ; BEQ.S  $0033E4; $0033CA
        ADDQ.B  #4,(-15611).W                   ; $0033CC
        MOVE.W  $002C(A0),D0                    ; $0033D0
        SUBQ.W  #1,D0                           ; $0033D4
        CMP.B  (-15600).W,D0                    ; $0033D6
        BNE.S  .loc_0068                        ; $0033DA
        MOVE.B  #$30,(-15611).W                 ; $0033DC
.loc_0068:
        RTS                                     ; $0033E2
