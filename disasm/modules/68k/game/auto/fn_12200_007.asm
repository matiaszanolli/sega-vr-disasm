; ============================================================================
; Sh2 Comm 007 (auto-analyzed)
; ROM Range: $012FE4-$013054 (112 bytes)
; ============================================================================
; Category: sh2
; Purpose: Accesses 32X registers: COMM0, COMM4, COMM6, COMM5
;
; Uses: D0, D1, D2, A0, A1
; Confidence: high
; ============================================================================

fn_12200_007:
.loc_0000:
        TST.B  COMM0_HI                        ; $012FE4
        BNE.S  .loc_0000                        ; $012FEA
        MOVE.L  A1,COMM4                    ; $012FEC
        MOVE.W  #$0101,COMM6                ; $012FF2
        MOVE.B  #$21,COMM0_LO                  ; $012FFA
        MOVE.B  #$01,COMM0_HI                  ; $013002
.loc_0026:
        TST.B  COMM6                        ; $01300A
        BNE.S  .loc_0026                        ; $013010
        MOVE.W  D0,COMM4                    ; $013012
        MOVE.W  D1,COMM5                    ; $013018
        MOVE.W  #$0101,COMM6                ; $01301E
        TST.B  COMM6                        ; $013026
        BNE.S  .loc_0026                        ; $01302C
        MOVE.W  D2,COMM4                    ; $01302E
        MOVE.W  #$0101,COMM6                ; $013034
.loc_0058:
        TST.B  COMM6                        ; $01303C
        BNE.S  .loc_0058                        ; $013042
        MOVE.L  A0,COMM4                    ; $013044
        MOVE.W  #$0101,COMM6                ; $01304A
        RTS                                     ; $013052
