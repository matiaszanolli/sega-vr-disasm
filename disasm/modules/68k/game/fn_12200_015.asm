; ============================================================================
; Sh2 Comm Object Update 015 (auto-analyzed)
; ROM Range: $012200-$01250C (780 bytes)
; ============================================================================
; Category: sh2
; Purpose: Orchestrator calling 8 subroutines
;   Accesses 32X registers: COMM0, COMM6, COMM4
;   RAM: $C87E (game_state)
;   Calls: dma_transfer, object_update, sprite_update, sh2_send_cmd
;   Object (A5): +$3B
;
; Entry: A5 = object/entity pointer
; Uses: D0, D1, D2, D5, A0, A1, A2, A5
; RAM:
;   $C87E: game_state
; Calls:
;   $00B684: object_update
;   $00B6DA: sprite_update
;   $00E35A: sh2_send_cmd
;   $00E52C: dma_transfer
; Object fields:
;   +$3B: [unknown]
; Confidence: high
; ============================================================================

fn_12200_015:
        SUB.W  $0401(A7),D0                     ; $012200
        SUBA.W  A7,A0                           ; $012204
        DC.W    $0401                           ; $012206
        AND.B  (A0),D0                          ; $012208
        DC.W    $003A                           ; $01220A
        DC.W    $0401                           ; $01220C
        DC.W    $C049                           ; $01220E
        DC.W    $003B                           ; $012210
        DC.W    $0401                           ; $012212
        DC.W    $C083                           ; $012214
        DC.W    $003A                           ; $012216
        DC.W    $0401                           ; $012218
        AND.L  #$003A0401,D0                    ; $01221A
        MULU    $3B(A5,D0.W),D0                 ; $012220
        CLR.W  D0                               ; $012224
        DC.W    $4EBA,$C304         ; JSR     $00E52C(PC); $012226
        DC.W    $4EBA,$9458         ; JSR     $00B684(PC); $01222A
        DC.W    $4EBA,$94AA         ; JSR     $00B6DA(PC); $01222E
        MOVEA.L (-24528).W,A1                   ; $012232
        MOVE.L  (-24546).W,D0                   ; $012236
        MOVE.L  (-24542).W,D1                   ; $01223A
        MOVEQ   #$00,D2                         ; $01223E
        MOVE.W  (-24532).W,D2                   ; $012240
        DC.W    $6100,$02EE         ; BSR.W  $012534; $012244
        MOVEA.L #$0601AD00,A0                   ; $012248
        MOVEA.L #$04008020,A1                   ; $01224E
        MOVE.W  #$0110,D0                       ; $012254
        MOVE.W  #$0010,D1                       ; $012258
        DC.W    $4EBA,$C0FC         ; JSR     $00E35A(PC); $01225C
.loc_0060:
        TST.B  $00A15120                        ; $012260
        BNE.S  .loc_0060                        ; $012266
        MOVE.W  #$0101,$00A1512C                ; $012268
        MOVE.W  #$A000,$00A15128                ; $012270
        MOVE.B  #$2C,$00A15121                  ; $012278
        MOVE.B  #$01,$00A15120                  ; $012280
.loc_0088:
        TST.B  $00A1512C                        ; $012288
        BNE.S  .loc_0088                        ; $01228E
        MOVE.W  #$0018,$00A15128                ; $012290
        MOVE.W  #$0101,$00A1512C                ; $012298
        MOVEA.L #$06018580,A0                   ; $0122A0
        LEA     $04035018,A1                    ; $0122A6
        MOVE.W  #$0038,D0                       ; $0122AC
        MOVE.W  #$0010,D1                       ; $0122B0
        DC.W    $4EBA,$C0A4         ; JSR     $00E35A(PC); $0122B4
        LEA     $04035060,A1                    ; $0122B8
        LEA     (-1464).W,A2                    ; $0122BE
        MOVE.L  (-24546).W,D0                   ; $0122C2
        DC.W    $D040                           ; $0122C6
        DC.W    $D040                           ; $0122C8
        DC.W    $D040                           ; $0122CA
        MOVE.W  D0,D1                           ; $0122CC
        DC.W    $D040                           ; $0122CE
        DC.W    $D041                           ; $0122D0
        DC.W    $D040                           ; $0122D2
        ADDA.L  D0,A2                           ; $0122D4
        MOVE.L  (-24542).W,D0                   ; $0122D6
        DC.W    $D040                           ; $0122DA
        DC.W    $D040                           ; $0122DC
        DC.W    $D040                           ; $0122DE
        ADDA.L  D0,A2                           ; $0122E0
        DC.W    $6100,$0326         ; BSR.W  $01260A; $0122E2
        ADDA.L  #$00000010,A1                   ; $0122E6
        MOVE.B  (A2)+,D5                        ; $0122EC
        DC.W    $6100,$02AC         ; BSR.W  $01259C; $0122EE
        ADDA.L  #$00000020,A1                   ; $0122F2
        DC.W    $6100,$03AC         ; BSR.W  $0126A6; $0122F8
        MOVEA.L #$06030000,A0                   ; $0122FC
        LEA     $040378A2,A1                    ; $012302
        MOVE.W  #$0088,D0                       ; $012308
        MOVE.W  #$0008,D1                       ; $01230C
        DC.W    $4EBA,$C048         ; JSR     $00E35A(PC); $012310
        TST.L  (-24538).W                       ; $012314
        BEQ.W  .loc_015A                        ; $012318
        MOVE.L  (-24528).W,D1                   ; $01231C
        MOVE.L  (-24538).W,D2                   ; $012320
        DC.W    $D282                           ; $012324
        MOVE.L  D1,(-24528).W                   ; $012326
        MOVE.L  (-24524).W,D1                   ; $01232A
        DC.W    $D282                           ; $01232E
        MOVE.L  D1,(-24524).W                   ; $012330
        SUBQ.W  #1,(-24534).W                   ; $012334
        BCC.W  .loc_02FE                        ; $012338
        TST.L  (-24538).W                       ; $01233C
        BPL.S  .loc_0146                        ; $012340
        ADDQ.W  #1,(-24532).W                   ; $012342
.loc_0146:
        CLR.L  (-24538).W                       ; $012346
        MOVE.L  #$0402A060,(-24528).W           ; $01234A
        MOVE.L  #$0402A020,(-24524).W           ; $012352
.loc_015A:
        CMPI.W  #$0001,(-24520).W               ; $01235A
        BEQ.W  .loc_02CE                        ; $012360
        CMPI.W  #$0002,(-24520).W               ; $012364
        BEQ.W  .loc_02E4                        ; $01236A
        JSR     $0088179E                       ; $01236E
        MOVE.W  (-14228).W,D1                   ; $012374
        BTST    #4,D1                           ; $012378
        BEQ.S  .loc_0180                        ; $01237C
        BRA.S  .loc_0186                        ; $01237E
.loc_0180:
        BTST    #7,D1                           ; $012380
        BEQ.S  .loc_01B4                        ; $012384
.loc_0186:
        MOVE.B  #$A8,(-14172).W                 ; $012386
        MOVE.W  #$0002,(-24520).W               ; $01238C
        MOVE.B  #$01,(-14327).W                 ; $012392
        MOVE.B  #$01,(-14326).W                 ; $012398
        BSET    #7,(-14322).W                   ; $01239E
        MOVE.B  #$01,(-14334).W                 ; $0123A4
        JSR     $0088205E                       ; $0123AA
        BRA.W  .loc_02FE                        ; $0123B0
.loc_01B4:
        BTST    #2,D1                           ; $0123B4
        BEQ.S  .loc_01E8                        ; $0123B8
        MOVE.B  #$A9,(-14172).W                 ; $0123BA
        TST.B  (-24551).W                       ; $0123C0
        BEQ.S  .loc_01CE                        ; $0123C4
        SUBQ.B  #1,(-24551).W                   ; $0123C6
        BRA.W  .loc_02FE                        ; $0123CA
.loc_01CE:
        TST.B  (-24550).W                       ; $0123CE
        BNE.S  .loc_01DE                        ; $0123D2
        MOVE.B  #$02,(-24551).W                 ; $0123D4
        BRA.W  .loc_02FE                        ; $0123DA
.loc_01DE:
        MOVE.B  #$04,(-24551).W                 ; $0123DE
        BRA.W  .loc_02FE                        ; $0123E4
.loc_01E8:
        BTST    #3,D1                           ; $0123E8
        BEQ.S  .loc_0222                        ; $0123EC
        MOVE.B  #$A9,(-14172).W                 ; $0123EE
        TST.B  (-24550).W                       ; $0123F4
        BNE.S  .loc_020A                        ; $0123F8
        CMPI.B  #$02,(-24551).W                 ; $0123FA
        BGE.S  .loc_021A                        ; $012400
        ADDQ.B  #1,(-24551).W                   ; $012402
        BRA.W  .loc_02FE                        ; $012406
.loc_020A:
        CMPI.B  #$04,(-24551).W                 ; $01240A
        BGE.S  .loc_021A                        ; $012410
        ADDQ.B  #1,(-24551).W                   ; $012412
        BRA.W  .loc_02FE                        ; $012416
.loc_021A:
        CLR.B  (-24551).W                       ; $01241A
        BRA.W  .loc_02FE                        ; $01241E
.loc_0222:
        BTST    #0,D1                           ; $012422
        BEQ.S  .loc_024A                        ; $012426
        TST.B  (-24550).W                       ; $012428
        BEQ.W  .loc_02FE                        ; $01242C
        MOVE.B  #$A9,(-14172).W                 ; $012430
        MOVE.B  (-24551).W,(-24548).W           ; $012436
        MOVE.B  (-24549).W,(-24551).W           ; $01243C
        CLR.B  (-24550).W                       ; $012442
        BRA.W  .loc_02FE                        ; $012446
.loc_024A:
        BTST    #1,D1                           ; $01244A
        BEQ.S  .loc_0274                        ; $01244E
        TST.B  (-24550).W                       ; $012450
        BNE.W  .loc_02FE                        ; $012454
        MOVE.B  #$A9,(-14172).W                 ; $012458
        MOVE.B  (-24551).W,(-24549).W           ; $01245E
        MOVE.B  (-24548).W,(-24551).W           ; $012464
        MOVE.B  #$01,(-24550).W                 ; $01246A
        BRA.W  .loc_02FE                        ; $012470
.loc_0274:
        LSR.W  #8,D1                            ; $012474
        BTST    #6,D1                           ; $012476
        BEQ.S  .loc_02AA                        ; $01247A
        TST.W  (-24532).W                       ; $01247C
        BEQ.W  .loc_02FE                        ; $012480
        MOVE.L  #$00000400,(-24538).W           ; $012484
        MOVE.W  #$0007,(-24534).W               ; $01248C
        SUBQ.W  #1,(-24532).W                   ; $012492
        SUBI.L  #$00002000,(-24528).W           ; $012496
        SUBI.L  #$00002000,(-24524).W           ; $01249E
        BRA.W  .loc_02FE                        ; $0124A6
.loc_02AA:
        BTST    #5,D1                           ; $0124AA
        BEQ.W  .loc_02FE                        ; $0124AE
        CMPI.W  #$000F,(-24532).W               ; $0124B2
        BGE.W  .loc_02FE                        ; $0124B8
        MOVE.L  #$FFFFFC00,(-24538).W           ; $0124BC
        MOVE.W  #$0007,(-24534).W               ; $0124C4
        BRA.W  .loc_02FE                        ; $0124CA
.loc_02CE:
        JSR     $0088FB36                       ; $0124CE
        BTST    #6,(-14322).W                   ; $0124D4
        BNE.S  .loc_02FE                        ; $0124DA
        CLR.W  (-24520).W                       ; $0124DC
        BRA.W  .loc_02FE                        ; $0124E0
.loc_02E4:
        JSR     $0088FB36                       ; $0124E4
        BTST    #7,(-14322).W                   ; $0124EA
        BNE.S  .loc_02FE                        ; $0124F0
        CLR.W  (-24520).W                       ; $0124F2
        ADDQ.W  #4,(-14210).W                   ; $0124F6
        BRA.W  .loc_0302                        ; $0124FA
.loc_02FE:
        SUBQ.W  #4,(-14210).W                   ; $0124FE
.loc_0302:
        MOVE.W  #$0018,$00FF0008                ; $012502
        RTS                                     ; $01250A
