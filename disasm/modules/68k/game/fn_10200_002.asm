; ============================================================================
; Name Entry 002 (auto-analyzed)
; ROM Range: $01084C-$010974 (296 bytes)
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

fn_10200_002:
        MOVE.W  D1,D2                           ; $01084C
        LSR.W  #8,D2                            ; $01084E
        CMP.B  (-24534).W,D2                    ; $010850
        BNE.W  .loc_0026                        ; $010854
        ADDQ.B  #1,(-24533).W                   ; $010858
        CMPI.B  #$0F,(-24533).W                 ; $01085C
        BLT.W  .loc_002A                        ; $010862
        MOVE.B  #$0C,(-24533).W                 ; $010866
        MOVE.W  D2,D1                           ; $01086C
        BRA.W  .loc_002A                        ; $01086E
.loc_0026:
        CLR.B  (-24533).W                       ; $010872
.loc_002A:
        MOVE.B  D2,(-24534).W                   ; $010876
        BTST    #2,D1                           ; $01087A
        BEQ.S  .loc_006E                        ; $01087E
        MOVE.B  #$01,(-24532).W                 ; $010880
        MOVE.B  #$00,(-24531).W                 ; $010886
        MOVE.B  #$A9,(-14172).W                 ; $01088C
        TST.W  (-24538).W                       ; $010892
        BEQ.S  .loc_0064                        ; $010896
        SUBQ.W  #1,(-24538).W                   ; $010898
        CMPI.W  #$0033,(-24538).W               ; $01089C
        BNE.W  .loc_00FC                        ; $0108A2
        MOVE.W  #$0019,(-24538).W               ; $0108A6
        BRA.W  .loc_00FC                        ; $0108AC
.loc_0064:
        MOVE.W  #$0039,(-24538).W               ; $0108B0
        BRA.W  .loc_00FC                        ; $0108B6
.loc_006E:
        BTST    #3,D1                           ; $0108BA
        BEQ.S  .loc_00AE                        ; $0108BE
        MOVE.B  #$01,(-24532).W                 ; $0108C0
        MOVE.B  #$00,(-24531).W                 ; $0108C6
        MOVE.B  #$A9,(-14172).W                 ; $0108CC
        CMPI.W  #$0039,(-24538).W               ; $0108D2
        BGE.S  .loc_00A6                        ; $0108D8
        ADDQ.W  #1,(-24538).W                   ; $0108DA
        CMPI.W  #$001A,(-24538).W               ; $0108DE
        BNE.W  .loc_00FC                        ; $0108E4
        MOVE.W  #$0034,(-24538).W               ; $0108E8
        BRA.W  .loc_00FC                        ; $0108EE
.loc_00A6:
        CLR.W  (-24538).W                       ; $0108F2
        BRA.W  .loc_00FC                        ; $0108F6
.loc_00AE:
        BTST    #0,D1                           ; $0108FA
        BEQ.S  .loc_00D6                        ; $0108FE
        TST.W  (-24536).W                       ; $010900
        BEQ.W  .loc_00FC                        ; $010904
        MOVE.B  #$01,(-24532).W                 ; $010908
        MOVE.B  #$00,(-24531).W                 ; $01090E
        CLR.W  (-24536).W                       ; $010914
        MOVE.B  #$A9,(-14172).W                 ; $010918
        BRA.W  .loc_00FC                        ; $01091E
.loc_00D6:
        BTST    #1,D1                           ; $010922
        BEQ.S  .loc_00FC                        ; $010926
        TST.W  (-24536).W                       ; $010928
        BNE.W  .loc_00FC                        ; $01092C
        MOVE.B  #$01,(-24532).W                 ; $010930
        MOVE.B  #$00,(-24531).W                 ; $010936
        MOVE.W  #$0001,(-24536).W               ; $01093C
        MOVE.B  #$A9,(-14172).W                 ; $010942
.loc_00FC:
        MOVE.W  (-24538).W,D0                   ; $010948
        CMPI.W  #$0019,D0                       ; $01094C
        BGT.W  .loc_0114                        ; $010950
        TST.W  (-24536).W                       ; $010954
        BEQ.W  .loc_0114                        ; $010958
        ADDI.W  #$001A,D0                       ; $01095C
.loc_0114:
        LEA     $00890974,A0                    ; $010960
        MOVE.B  $00(A0,D0.W),D0                 ; $010966
        ANDI.W  #$00FF,D0                       ; $01096A
        MOVE.W  D0,(-24540).W                   ; $01096E
        RTS                                     ; $010972
