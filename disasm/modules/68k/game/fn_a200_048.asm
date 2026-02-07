; ============================================================================
; Ai 048 (auto-analyzed)
; ROM Range: $00C05C-$00C0F0 (148 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A1, A2): +$00, +$0C
;
; Entry: A1 = object/entity pointer
; Entry: A2 = object/entity pointer
; Uses: D0, D1, D2, D3, A1, A2
; Object fields:
;   +$00: [unknown]
;   +$0C: [unknown]
; Confidence: low
; ============================================================================

fn_a200_048:
        DC.W    $0402                           ; $00C05C
        DC.W    $C030                           ; $00C05E
        DC.W    $0402                           ; $00C060
        ROXR.B  D0,D0                           ; $00C062
        SUBI.B  #$30,D3                         ; $00C064
        DC.W    $0403                           ; $00C068
        DC.W    $2030                           ; $00C06A
        DC.W    $0403                           ; $00C06C
        DC.W    $4030                           ; $00C06E
        LEA     $00FF6800,A1                    ; $00C070
        MOVEQ   #$10,D1                         ; $00C076
        MOVEQ   #$0F,D0                         ; $00C078
.loc_001E:
        CLR.W  (A1)                             ; $00C07A
        ADDA.W  D1,A1                           ; $00C07C
        DBRA    D0,.loc_001E                    ; $00C07E
        MOVE.W  (-16132).W,D2                   ; $00C082
        BEQ.W  .loc_0080                        ; $00C086
        BMI.S  .loc_003A                        ; $00C08A
        CLR.W  (-16130).W                       ; $00C08C
        BSET    #7,(-16132).W                   ; $00C090
.loc_003A:
        SUBQ.W  #1,D2                           ; $00C096
        ANDI.W  #$0007,D2                       ; $00C098
        DC.W    $D442                           ; $00C09C
        DC.W    $D442                           ; $00C09E
        LEA     $0089ACF0,A2                    ; $00C0A0
        MOVEA.L $00(A2,D2.W),A2                 ; $00C0A6
        LEA     $00FF6800,A1                    ; $00C0AA
        MOVE.W  (A2)+,D1                        ; $00C0B0
.loc_0056:
        MOVE.W  (A2)+,(A1)+                     ; $00C0B2
        MOVE.W  (A2)+,D3                        ; $00C0B4
        CLR.W  (A1)+                            ; $00C0B6
        MOVE.L  (A2)+,(A1)+                     ; $00C0B8
        MOVE.L  (A2)+,(A1)+                     ; $00C0BA
        CLR.L  (A1)+                            ; $00C0BC
        SUB.W  (-16130).W,D3                    ; $00C0BE
        BMI.S  .loc_007C                        ; $00C0C2
        CMPI.W  #$0050,D3                       ; $00C0C4
        BLE.S  .loc_0072                        ; $00C0C8
        MOVE.W  #$0050,D3                       ; $00C0CA
.loc_0072:
        DC.W    $D643                           ; $00C0CE
        DC.W    $D643                           ; $00C0D0
        EXT.L   D3                              ; $00C0D2
        ADD.L  D3,-$000C(A1)                    ; $00C0D4
.loc_007C:
        DBRA    D1,.loc_0056                    ; $00C0D8
.loc_0080:
        ADDQ.W  #8,(-16130).W                   ; $00C0DC
        CMPI.W  #$7FFF,(-16130).W               ; $00C0E0
        BLE.S  .loc_0092                        ; $00C0E6
        MOVE.W  #$7FFF,(-16130).W               ; $00C0E8
.loc_0092:
        RTS                                     ; $00C0EE
