; ============================================================================
; Vdp 005 (auto-analyzed)
; ROM Range: $01462A-$014696 (108 bytes)
; ============================================================================
; Category: vdp
; Purpose: Accesses VDP registers
;   Object (A6): +$6F
;
; Entry: A6 = object/entity pointer
; Uses: D0, D2, A0, A1, A2, A6
; Object fields:
;   +$6F: [unknown]
; Confidence: medium
; ============================================================================

fn_14200_005:
        ORI.L  #$E7320090,(A0)                  ; $01462A
        DC.W    $FD28                           ; $014630
        ORI.L  #$1BCA0091,(A1)                  ; $014632
        MOVE.W  -(A6),-$6F(A6,D0.W)             ; $014638
        SLE     -(A0)                           ; $01463C
        ORI.L  #$81900091,(A1)                  ; $01463E
        DC.W    $A1D8                           ; $014644
        ORI.L  #$C2FE0091,(A1)                  ; $014646
        ROR.B  #1,D2                            ; $01464C
        ORI.L  #$FD760092,(A1)                  ; $01464E
        DC.W    $1662                           ; $014654
        ORI.L  #$2DD40092,(A2)                  ; $014656
        MOVE    D0,CCR                          ; $01465C
        ORI.L  #$5AEA0092,(A2)                  ; $01465E
        MOVEQ   #-$3A,D0                        ; $014664
        ORI.L  #$86AE7000,(A2)                  ; $014666
        MOVE.B  D0,(-14323).W                   ; $01466C
        MOVE.B  D0,$00FF6870                    ; $014670
        MOVE.B  D0,$00FF68A0                    ; $014676
        MOVE.B  D0,$00FF6820                    ; $01467C
        MOVE.B  D0,$00FF6850                    ; $014682
        MOVE.B  D0,$00FF6830                    ; $014688
        MOVE.B  D0,$00FF68B0                    ; $01468E
        RTS                                     ; $014694
