; ============================================================================
; Camera 032 (auto-analyzed)
; ROM Range: $0135C4-$0136AA (230 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A0): +$00
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, D2, A0
; Object fields:
;   +$00: [unknown]
; Confidence: low
; ============================================================================

fn_12200_032:
        MOVE.W  D1,D2                           ; $0135C4
        ANDI.B  #$F0,D2                         ; $0135C6
        BNE.W  .loc_00AE                        ; $0135CA
        BTST    #0,D1                           ; $0135CE
        BEQ.S  .loc_002E                        ; $0135D2
        JSR     $0088205E                       ; $0135D4
        MOVE.B  #$A9,(-14172).W                 ; $0135DA
        SUBQ.B  #1,(-24551).W                   ; $0135E0
        BCC.W  .loc_00CC                        ; $0135E4
        MOVE.B  #$05,(-24551).W                 ; $0135E8
        BRA.W  .loc_00CC                        ; $0135EE
.loc_002E:
        BTST    #1,D1                           ; $0135F2
        BEQ.S  .loc_0056                        ; $0135F6
        JSR     $0088205E                       ; $0135F8
        MOVE.B  #$A9,(-14172).W                 ; $0135FE
        ADDQ.B  #1,(-24551).W                   ; $013604
        CMPI.B  #$05,(-24551).W                 ; $013608
        BLE.W  .loc_00CC                        ; $01360E
        CLR.B  (-24551).W                       ; $013612
        BRA.W  .loc_00CC                        ; $013616
.loc_0056:
        BTST    #2,D1                           ; $01361A
        BEQ.S  .loc_0082                        ; $01361E
        MOVE.B  #$A9,(-14172).W                 ; $013620
        MOVE.W  #$FFFF,D0                       ; $013626
        LEA     $008936AA,A0                    ; $01362A
        CLR.W  D2                               ; $013630
        MOVE.B  (-24551).W,D2                   ; $013632
        DC.W    $D442                           ; $013636
        DC.W    $D442                           ; $013638
        MOVEA.L $00(A0,D2.W),A0                 ; $01363A
        CLR.W  D2                               ; $01363E
        JSR     (A0)                            ; $013640
        BRA.W  .loc_00CC                        ; $013642
.loc_0082:
        BTST    #3,D1                           ; $013646
        BEQ.S  .loc_00CC                        ; $01364A
        MOVE.B  #$A9,(-14172).W                 ; $01364C
        MOVE.W  #$0001,D0                       ; $013652
        LEA     $008936AA,A0                    ; $013656
        CLR.W  D2                               ; $01365C
        MOVE.B  (-24551).W,D2                   ; $01365E
        DC.W    $D442                           ; $013662
        DC.W    $D442                           ; $013664
        MOVEA.L $00(A0,D2.W),A0                 ; $013666
        CLR.W  D2                               ; $01366A
        JSR     (A0)                            ; $01366C
        BRA.W  .loc_00CC                        ; $01366E
.loc_00AE:
        MOVE.W  #$0001,(-24542).W               ; $013672
        BTST    #7,D1                           ; $013678
        BNE.S  .loc_00CC                        ; $01367C
        MOVE.W  #$0002,(-24542).W               ; $01367E
        BTST    #4,D1                           ; $013684
        BEQ.S  .loc_00CC                        ; $013688
        MOVE.W  #$0003,(-24542).W               ; $01368A
.loc_00CC:
        SUBQ.W  #1,(-24540).W                   ; $013690
        BCC.W  .loc_00E4                        ; $013694
        MOVE.W  $00FF2100,(-24540).W            ; $013698
        SUBQ.W  #1,(-24538).W                   ; $0136A0
        NEG.W  (-24538).W                       ; $0136A4
.loc_00E4:
        RTS                                     ; $0136A8
