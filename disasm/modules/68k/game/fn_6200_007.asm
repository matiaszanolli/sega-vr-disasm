; ============================================================================
; Fn 6200 007
; ROM Range: $006A3A-$006AB4 (122 bytes)
; Source: code_6200
; ============================================================================

fn_6200_007:
        DC.W    $4EBA,$4D34         ; JSR     $00B770(PC); $006A3A
        MOVE.B  #$01,(-14336).W                 ; $006A3E
        MOVEQ   #$00,D0                         ; $006A44
        MOVE.W  D0,$0044(A0)                    ; $006A46
        MOVE.W  D0,$0046(A0)                    ; $006A4A
        MOVE.W  D0,$004A(A0)                    ; $006A4E
        DC.W    $4EBA,$1678         ; JSR     $0080CC(PC); $006A52
        DC.W    $4EBA,$1AF0         ; JSR     $008548(PC); $006A56
        DC.W    $4EBA,$2DA6         ; JSR     $009802(PC); $006A5A
        DC.W    $4EBA,$141A         ; JSR     $007E7A(PC); $006A5E
        DC.W    $4EBA,$0534         ; JSR     $006F98(PC); $006A62
        DC.W    $4EBA,$1270         ; JSR     $007CD8(PC); $006A66
        DC.W    $4EBA,$063E         ; JSR     $0070AA(PC); $006A6A
        DC.W    $4EBA,$06DA         ; JSR     $00714A(PC); $006A6E
        DC.W    $4EBA,$0BDA         ; JSR     $00764E(PC); $006A72
        DC.W    $4EBA,$14D8         ; JSR     $007F50(PC); $006A76
        DC.W    $4EBA,$41C2         ; JSR     $00AC3E(PC); $006A7A
        DC.W    $4EBA,$30D4         ; JSR     $009B54(PC); $006A7E
        MOVE.W  (-14176).W,D0                   ; $006A82
        MOVEA.L $006AB4(PC,D0.W),A1             ; $006A86
        JSR     (A1)                            ; $006A8A
        CMPI.W  #$0014,(-14166).W               ; $006A8C
        BNE.S  .loc_0078                        ; $006A92
        MOVE.W  (-16238).W,(-16262).W           ; $006A94
        MOVE.B  #$00,(-14336).W                 ; $006A9A
        MOVE.W  #$0004,(-14164).W               ; $006AA0
        TST.W  (-14180).W                       ; $006AA6
        BEQ.S  .loc_0078                        ; $006AAA
        MOVE.W  #$0020,(-14164).W               ; $006AAC
.loc_0078:
        RTS                                     ; $006AB2
