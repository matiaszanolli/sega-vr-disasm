; ============================================================================
; Fm Dispatch 050 (auto-analyzed)
; ROM Range: $0312B4-$031352 (158 bytes)
; ============================================================================
; Category: sound
; Purpose: State dispatcher using jump table
;   Calls: z80_bus_request, fm_write_conditional
;   Object (A5, A6): +$09, +$0B, +$0E (param_e), +$20, +$25, +$27
;
; Entry: A5 = object/entity pointer
; Entry: A6 = object/entity pointer
; Uses: D0, D1, D3, D4, D5, A1, A2, A4
; Calls:
;   $030CCC: fm_write_conditional
;   $030D1C: z80_bus_request
; Object fields:
;   +$09: [unknown]
;   +$0B: [unknown]
;   +$0E: param_e
;   +$20: [unknown]
;   +$25: [unknown]
;   +$27: [unknown]
;   +$30: x_position
;   +$34: y_position
; Confidence: high
; ============================================================================

fn_30200_050:
        MOVE.B  (A4)+,D0                        ; $0312B4
        MOVE.B  (A4)+,D1                        ; $0312B6
        DC.W    $6000,$F9E8         ; BRA.W  $030CA2; $0312B8
        MOVE.B  (A4)+,D0                        ; $0312BC
        MOVE.B  (A4)+,D1                        ; $0312BE
        DC.W    $6000,$F9F8         ; BRA.W  $030CBA; $0312C0
        MOVEQ   #$00,D0                         ; $0312C4
        MOVE.B  (A4)+,D0                        ; $0312C6
        MOVE.B  D0,$000B(A5)                    ; $0312C8
        BTST    #2,(A5)                         ; $0312CC
        BNE.W  .loc_009C                        ; $0312D0
        MOVEA.L $0030(A6),A1                    ; $0312D4
        TST.B  $000E(A6)                        ; $0312D8
        BEQ.S  .loc_0034                        ; $0312DC
        MOVEA.L $0020(A5),A1                    ; $0312DE
        BMI.S  .loc_0034                        ; $0312E2
        MOVEA.L $0034(A6),A1                    ; $0312E4
.loc_0034:
        SUBQ.W  #1,D0                           ; $0312E8
        BMI.S  .loc_0042                        ; $0312EA
        MOVE.W  #$0019,D1                       ; $0312EC
.loc_003C:
        ADDA.W  D1,A1                           ; $0312F0
        DBRA    D0,.loc_003C                    ; $0312F2
.loc_0042:
        DC.W    $4EBA,$FA24         ; JSR     $030D1C(PC); $0312F6
        MOVE.B  (A1)+,D1                        ; $0312FA
        MOVE.B  D1,$0025(A5)                    ; $0312FC
        MOVE.B  D1,D4                           ; $031300
        MOVE.B  #$B0,D0                         ; $031302
        DC.W    $4EBA,$F9C4         ; JSR     $030CCC(PC); $031306
        DC.W    $45FA,$00BE         ; LEA     $0313CA(PC),A2; $03130A
        MOVEQ   #$13,D3                         ; $03130E
.loc_005C:
        MOVE.B  (A2)+,D0                        ; $031310
        MOVE.B  (A1)+,D1                        ; $031312
        DC.W    $4EBA,$F9B6         ; JSR     $030CCC(PC); $031314
        DBRA    D3,.loc_005C                    ; $031318
        MOVEQ   #$03,D5                         ; $03131C
        ANDI.W  #$0007,D4                       ; $03131E
        MOVE.B  $031352(PC,D4.W),D4             ; $031322
        MOVE.B  $0009(A5),D3                    ; $031326
.loc_0076:
        MOVE.B  (A2)+,D0                        ; $03132A
        MOVE.B  (A1)+,D1                        ; $03132C
        LSR.B  #1,D4                            ; $03132E
        BCC.S  .loc_0080                        ; $031330
        DC.W    $D203                           ; $031332
.loc_0080:
        DC.W    $4EBA,$F996         ; JSR     $030CCC(PC); $031334
        DBRA    D5,.loc_0076                    ; $031338
        MOVE.B  #$B4,D0                         ; $03133C
        MOVE.B  $0027(A5),D1                    ; $031340
        DC.W    $4EBA,$F986         ; JSR     $030CCC(PC); $031344
        MOVE.W  #$0000,$00A11100                ; $031348
.loc_009C:
        RTS                                     ; $031350
