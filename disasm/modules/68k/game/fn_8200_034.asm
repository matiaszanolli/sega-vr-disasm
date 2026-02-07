; ============================================================================
; State Velocity 034 (auto-analyzed)
; ROM Range: $009300-$009458 (344 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A0, A1, A2): +$00, +$04 (speed_index/velocity), +$06 (speed), +$0C, +$0E (param_e), +$10
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Entry: A2 = object/entity pointer
; Uses: D0, D1, D2, D3, A0, A1, A2
; Object fields:
;   +$00: [unknown]
;   +$04: speed_index/velocity
;   +$06: speed
;   +$0C: [unknown]
;   +$0E: param_e
;   +$10: [unknown]
;   +$16: calc_speed
;   +$74: [unknown]
; Confidence: medium
; ============================================================================

fn_8200_034:
        MOVE.W  #$FFCD,$000E(A0)                ; $009300
        MOVE.W  $0074(A0),D2                    ; $009306
        MOVE.W  $007A(A0),D1                    ; $00930A
        DC.W    $D241                           ; $00930E
        DC.W    $609C               ; BRA.S  $0092AE; $009310
        MOVE.W  $0074(A0),D1                    ; $009312
        BGE.S  .loc_001C                        ; $009316
        MOVEQ   #$00,D1                         ; $009318
        BRA.S  .loc_0026                        ; $00931A
.loc_001C:
        CMPI.W  #$4268,D1                       ; $00931C
        BLE.S  .loc_0026                        ; $009320
        MOVE.W  #$4268,D1                       ; $009322
.loc_0026:
        ASR.W  #7,D1                            ; $009326
        LEA     $0093910E,A1                    ; $009328
        TST.B  (-15601).W                       ; $00932E
        BNE.S  .loc_003A                        ; $009332
        LEA     $00938FCE,A1                    ; $009334
.loc_003A:
        DC.W    $D241                           ; $00933A
        MOVE.W  $00(A1,D1.W),D2                 ; $00933C
        MOVEA.L (-15752).W,A2                   ; $009340
        MOVE.W  $007A(A0),D3                    ; $009344
        DC.W    $D643                           ; $009348
        MULU    $00(A2,D3.W),D2                 ; $00934A
        LSR.L  #5,D2                            ; $00934E
        MULS    $000E(A0),D2                    ; $009350
        ASR.L  #7,D2                            ; $009354
        BGT.S  .loc_0064                        ; $009356
        MOVE.L  #$FFFFFE00,D0                   ; $009358
        CMP.L  D0,D2                            ; $00935E
        BLT.S  .loc_0064                        ; $009360
        MOVE.L  D0,D2                           ; $009362
.loc_0064:
        DC.W    $4EBA,$00F2         ; JSR     $009458(PC); $009364
        MOVE.W  $0016(A0),D1                    ; $009368
        EXT.L   D1                              ; $00936C
        LSL.L  #4,D1                            ; $00936E
        DC.W    $9481                           ; $009370
        MOVE.W  $0010(A0),D1                    ; $009372
        MULS    #$71C0,D1                       ; $009376
        ASR.L  #7,D1                            ; $00937A
        DC.W    $9481                           ; $00937C
        BPL.S  .loc_0082                        ; $00937E
        DC.W    $D482                           ; $009380
.loc_0082:
        MOVE.W  #$0100,$0078(A0)                ; $009382
        MOVE.W  (-16148).W,D0                   ; $009388
        NEG.W  D0                               ; $00938C
        EXT.L   D0                              ; $00938E
        CMP.L  D0,D2                            ; $009390
        BGT.S  .loc_00C0                        ; $009392
        MOVE.L  D0,D1                           ; $009394
        DC.W    $D281                           ; $009396
        CMP.L  D1,D2                            ; $009398
        BGT.S  .loc_00BC                        ; $00939A
        MOVE.W  $0080(A0),D1                    ; $00939C
        OR.W   $008C(A0),D1                     ; $0093A0
        BNE.S  .loc_00BC                        ; $0093A4
        CMPI.W  #$0014,$0004(A0)                ; $0093A6
        BLE.W  .loc_00BC                        ; $0093AC
        MOVE.W  #$000F,$0080(A0)                ; $0093B0
        MOVE.B  #$B1,(-14172).W                 ; $0093B6
.loc_00BC:
        MOVE.L  D0,D2                           ; $0093BC
        BRA.S  .loc_00FC                        ; $0093BE
.loc_00C0:
        MOVEQ   #$00,D0                         ; $0093C0
        MOVE.W  (-16150).W,D0                   ; $0093C2
        CMP.L  D0,D2                            ; $0093C6
        BLE.W  .loc_00FC                        ; $0093C8
        MOVE.L  D2,D1                           ; $0093CC
        DC.W    $9280                           ; $0093CE
        ASL.L  #8,D1                            ; $0093D0
        DIVS    D0,D1                           ; $0093D2
        SUB.W  D1,$0078(A0)                     ; $0093D4
        CMPI.W  #$0080,D1                       ; $0093D8
        BLE.S  .loc_00E4                        ; $0093DC
        MOVE.W  #$0080,$0078(A0)                ; $0093DE
.loc_00E4:
        TST.W  $007A(A0)                        ; $0093E4
        BNE.S  .loc_00FC                        ; $0093E8
        TST.W  $0082(A0)                        ; $0093EA
        BNE.S  .loc_00FC                        ; $0093EE
        MOVE.W  #$000F,$0082(A0)                ; $0093F0
        MOVE.B  #$B4,(-14172).W                 ; $0093F6
.loc_00FC:
        ASR.L  #1,D2                            ; $0093FC
        MULS    $0078(A0),D2                    ; $0093FE
        ASR.L  #7,D2                            ; $009402
        MOVE.W  D2,D1                           ; $009404
        ASR.W  #2,D1                            ; $009406
        EXT.L   D1                              ; $009408
        DIVS    #$0190,D1                       ; $00940A
        MOVE.W  D1,$000C(A0)                    ; $00940E
        ADD.W  D1,$0006(A0)                     ; $009412
        BPL.S  .loc_011C                        ; $009416
        CLR.W  $0006(A0)                        ; $009418
.loc_011C:
        MOVEA.L (-15752).W,A1                   ; $00941C
        MOVE.W  $007A(A0),D1                    ; $009420
        DC.W    $D241                           ; $009424
        MOVE.W  $00(A1,D1.W),D3                 ; $009426
        MULS    $0006(A0),D3                    ; $00942A
        ASL.L  #2,D3                            ; $00942E
        MOVE.L  D3,D1                           ; $009430
        ASL.L  #2,D3                            ; $009432
        DC.W    $D283                           ; $009434
        ASL.L  #2,D3                            ; $009436
        DC.W    $D283                           ; $009438
        ASL.L  #3,D3                            ; $00943A
        DC.W    $D681                           ; $00943C
        MOVEQ   #$0C,D1                         ; $00943E
        LSR.L  D1,D3                            ; $009440
        BGE.S  .loc_0146                        ; $009442
        MOVEQ   #$00,D3                         ; $009444
.loc_0146:
        CMPI.L  #$00004268,D3                   ; $009446
        BLE.S  .loc_0152                        ; $00944C
        MOVE.W  #$4268,D3                       ; $00944E
.loc_0152:
        MOVE.W  D3,$0074(A0)                    ; $009452
        RTS                                     ; $009456
