; ============================================================================
; Fm Dispatch 051 (auto-analyzed)
; ROM Range: $031352-$0313CA (120 bytes)
; ============================================================================
; Category: sound
; Purpose: State dispatcher using jump table
;   Calls: z80_bus_request, fm_write_conditional
;   Object (A5, A6): +$09, +$0B, +$0E (param_e), +$20, +$25, +$30 (x_position)
;
; Entry: A5 = object/entity pointer
; Entry: A6 = object/entity pointer
; Uses: D0, D1, D3, D4, D5, A1, A2, A5
; Calls:
;   $030CCC: fm_write_conditional
;   $030D1C: z80_bus_request
; Object fields:
;   +$09: [unknown]
;   +$0B: [unknown]
;   +$0E: param_e
;   +$20: [unknown]
;   +$25: [unknown]
;   +$30: x_position
;   +$34: y_position
; Confidence: high
; ============================================================================

fn_30200_051:
        DC.W    $0808                           ; $031352
        DC.W    $0808                           ; $031354
        DC.W    $0A0E                           ; $031356
        DC.W    $0E0F                           ; $031358
        BTST    #2,(A5)                         ; $03135A
        BNE.S  .loc_0076                        ; $03135E
        MOVEQ   #$00,D0                         ; $031360
        MOVE.B  $000B(A5),D0                    ; $031362
        MOVEA.L $0030(A6),A1                    ; $031366
        TST.B  $000E(A6)                        ; $03136A
        BEQ.S  .loc_002C                        ; $03136E
        MOVEA.L $0020(A5),A1                    ; $031370
        TST.B  $000E(A6)                        ; $031374
        BMI.S  .loc_002C                        ; $031378
        MOVEA.L $0034(A6),A1                    ; $03137A
.loc_002C:
        SUBQ.W  #1,D0                           ; $03137E
        BMI.S  .loc_003A                        ; $031380
        MOVE.W  #$0019,D1                       ; $031382
.loc_0034:
        ADDA.W  D1,A1                           ; $031386
        DBRA    D0,.loc_0034                    ; $031388
.loc_003A:
        ADDA.W  #$0015,A1                       ; $03138C
        DC.W    $45FA,$004C         ; LEA     $0313DE(PC),A2; $031390
        MOVE.B  $0025(A5),D0                    ; $031394
        ANDI.W  #$0007,D0                       ; $031398
        MOVE.B  $031352(PC,D0.W),D4             ; $03139C
        MOVE.B  $0009(A5),D3                    ; $0313A0
        BMI.S  .loc_0076                        ; $0313A4
        MOVEQ   #$03,D5                         ; $0313A6
        DC.W    $4EBA,$F972         ; JSR     $030D1C(PC); $0313A8
.loc_005A:
        MOVE.B  (A2)+,D0                        ; $0313AC
        MOVE.B  (A1)+,D1                        ; $0313AE
        LSR.B  #1,D4                            ; $0313B0
        BCC.S  .loc_006A                        ; $0313B2
        DC.W    $D203                           ; $0313B4
        BCS.S  .loc_006A                        ; $0313B6
        DC.W    $4EBA,$F912         ; JSR     $030CCC(PC); $0313B8
.loc_006A:
        DBRA    D5,.loc_005A                    ; $0313BC
        MOVE.W  #$0000,$00A11100                ; $0313C0
.loc_0076:
        RTS                                     ; $0313C8
