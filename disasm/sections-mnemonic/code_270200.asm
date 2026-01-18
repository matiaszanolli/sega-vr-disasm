; Generated assembly for $270200-$272200
; Branch targets: 0
; Labels: 0
; Format: DC.W with decoded mnemonics as comments

        org     $270200

        MOVEQ   #-$21,D2                        ; $270200
        MOVEQ   #-$20,D2                        ; $270202
        MOVEQ   #-$20,D2                        ; $270204
        MOVE.W  (A6)+,$72DD72DB                 ; $270206
        MOVE.W  (A2)+,$74D977D7                 ; $27020C
        DC.W    $7BD6               ; $270212 MOVE.W  (A6),<EA:3D>
        DC.W    $7DCD               ; $270214 MOVE.W  A5,<EA:3E>
        MOVE.W  -$60(A7,D7.L),-$7A(A7,A0.W)     ; $270216
        OR.W   -$7CB3(A1),D1                    ; $27021C
        OR.B   $22(A5,A0.W),D2                  ; $270220
        OR.B   D1,(A3)+                         ; $270224
        OR.B   D1,(A0)+                         ; $270226
        OR.B   (A7),D1                          ; $270228
        OR.B   D0,(A0)+                         ; $27022A
        OR.B   (A2)+,D0                         ; $27022C
        OR.B   (A3)+,D0                         ; $27022E
        OR.B   D0,(A5)+                         ; $270230
        OR.B   (A6)+,D1                         ; $270232
        OR.B   D1,(A7)+                         ; $270234
        OR.B   -(A0),D1                         ; $270236
        OR.B   -(A2),D1                         ; $270238
        OR.B   D0,-(A3)                         ; $27023A
        MOVE.W  -(A4),-(A7)                     ; $27023C
        MOVE.W  -(A6),-(A6)                     ; $27023E
        MOVE.W  $3B(A1,D7.L),-(A6)              ; $270240
        MOVE.W  -$7FCA(PC),-(A7)                ; $270244
        OR.B   D0,$823A.W                       ; $270248
        OR.B   $2F(A4,A0.W),D1                  ; $27024C
        OR.B   -$7CD1(A7),D1                    ; $270250
        OR.B   -$7BCE(A7),D2                    ; $270254
        OR.B   $45(PC,A0.W),D2                  ; $270258
        OR.W   A6,D2                            ; $27025C
        OR.W   D1,(A4)+                         ; $27025E
        OR.W   D1,-$7D(A0,A0.W)                 ; $270260
        OR.L   D1,A6                            ; $270264
        OR.L   D1,(A1)                          ; $270266
        OR.L   (A4)+,D1                         ; $270268
        OR.L   D0,-$3F(A3,D7.L)                 ; $27026A
        DC.W    $7FC1               ; $27026E MOVE.W  D1,<EA:3F>
        DIVS    D4,D0                           ; $270270
        DIVS    A7,D0                           ; $270272
        DC.W    $7FD8               ; $270274 MOVE.W  (A0)+,<EA:3F>
        DC.W    $7FE1               ; $270276 MOVE.W  -(A1),<EA:3F>
        DC.W    $7FE7               ; $270278 MOVE.W  -(A7),<EA:3F>
        DIVU    -(A3),D0                        ; $27027A
        DIVU    A2,D1                           ; $27027C
        OR.L   D1,-$7D55(A7)                    ; $27027E
        MOVEQ   #-$48,D7                        ; $270282
        DC.W    $7BC9               ; $270284 MOVE.W  A1,<EA:3D>
        MOVE.W  (A7),#$77DE                     ; $270286
        MOVE.W  -(A1),$73E3(PC)                 ; $27028A
        MOVEQ   #-$1D,D2                        ; $27028E
        MOVEQ   #-$1F,D3                        ; $270290
        MOVEQ   #-$20,D4                        ; $270292
        MOVE.W  (A6)+,-$23(PC,D7.W)             ; $270294
        MOVE.W  (A4)+,-$26(PC,D7.L)             ; $270298
        MOVE.W  (A1)+,-$28(PC,D7.L)             ; $27029C
        MOVEQ   #-$2A,D5                        ; $2702A0
        MOVEQ   #-$31,D7                        ; $2702A2
        OR.L   D0,-$71(A4,A0.W)                 ; $2702A4
        OR.W   D1,-$7BB4(A5)                    ; $2702A8
        OR.B   $22(A3,A0.W),D2                  ; $2702AC
        OR.B   D1,(A2)+                         ; $2702B0
        OR.B   (A0)+,D1                         ; $2702B2
        OR.B   (A0)+,D0                         ; $2702B4
        MOVEQ   #$19,D7                         ; $2702B6
        MOVEQ   #$1B,D7                         ; $2702B8
        MOVE.W  (A4)+,-(A7)                     ; $2702BA
        OR.B   D0,(A6)+                         ; $2702BC
        OR.B   (A7)+,D1                         ; $2702BE
        OR.B   -(A0),D1                         ; $2702C0
        OR.B   -(A1),D0                         ; $2702C2
        MOVE.W  -(A2),-(A7)                     ; $2702C4
        MOVEQ   #$23,D7                         ; $2702C6
        MOVEQ   #$25,D7                         ; $2702C8
        MOVEQ   #$26,D7                         ; $2702CA
        MOVE.W  -(A7),-(A7)                     ; $2702CC
        OR.B   -$7ED7(A0),D0                    ; $2702CE
        OR.B   -$7CD5(A2),D1                    ; $2702D2
        OR.B   -$7AD3(A4),D2                    ; $2702D6
        OR.B   -$7BD1(A6),D2                    ; $2702DA
        OR.B   D1,$31(A0,A0.W)                  ; $2702DE
        OR.B   D1,$33(A2,A0.W)                  ; $2702E2
        OR.B   D1,$39(A5,A0.W)                  ; $2702E6
        OR.W   D0,D2                            ; $2702EA
        OR.W   D1,A6                            ; $2702EC
        OR.W   D1,-(A2)                         ; $2702EE
        OR.W   D0,$80937FAF                     ; $2702F0
        DC.W    $7DCE               ; $2702F6 MOVE.W  A6,<EA:3E>
        MOVEQ   #-$1A,D6                        ; $2702F8
        DC.W    $7DEE,$7EF1         ; $2702FA MOVE.W  $7EF1(A6),<EA:3E>
        DC.W    $7FF2,$7FF1         ; $2702FE MOVE.W  -$0F(A2,D7.L),<EA:3F>
        MOVEQ   #-$11,D7                        ; $270302
        MOVEQ   #-$15,D7                        ; $270304
        DIVU    (A5)+,D0                        ; $270306
        DIVU    D6,D1                           ; $270308
        OR.L   -(A7),D2                         ; $27030A
        OR.L   D2,A2                            ; $27030C
        OR.W   #$827C,D2                        ; $27030E
        MOVE.W  A5,-$57(A7,D7.L)                ; $270312
        MOVE.W  A1,#$77DB                       ; $270316
        MOVE.W  -(A1),$75E5(PC)                 ; $27031A
        MOVEQ   #-$1A,D3                        ; $27031E
        MOVE.W  -(A5),-$1D(PC,D7.W)             ; $270320
        MOVE.W  -(A1),-$20(PC,D7.L)             ; $270324
        MOVE.W  (A6)+,-$23(PC,D7.L)             ; $270328
        MOVEQ   #-$24,D5                        ; $27032C
        DC.W    $7BDA               ; $27032E MOVE.W  (A2)+,<EA:3D>
        DC.W    $7DD8               ; $270330 MOVE.W  (A0)+,<EA:3E>
        DIVU    A4,D0                           ; $270332
        OR.L   -$7C77(A3),D1                    ; $270334
        OR.W   D1,-(A4)                         ; $270338
        OR.W   D5,D1                            ; $27033A
        OR.B   $29(A4,A0.W),D1                  ; $27033C
        OR.B   D0,(A5)+                         ; $270340
        OR.B   (A3)+,D1                         ; $270342
        OR.B   (A3)+,D1                         ; $270344
        OR.B   (A4)+,D1                         ; $270346
        OR.B   D0,(A5)+                         ; $270348
        OR.B   D0,(A7)+                         ; $27034A
        OR.B   -(A0),D1                         ; $27034C
        OR.B   -(A2),D1                         ; $27034E
        OR.B   -(A3),D1                         ; $270350
        MOVE.W  -(A4),-(A7)                     ; $270352
        MOVE.W  -(A5),-(A6)                     ; $270354
        MOVE.W  -(A6),-(A6)                     ; $270356
        MOVE.W  -(A7),-(A6)                     ; $270358
        MOVEQ   #$28,D7                         ; $27035A
        MOVE.W  $7F35(A4),-(A7)                 ; $27035C
        OR.B   -$7DCD(PC),D0                    ; $270360
        OR.B   D1,$31(A0,A0.W)                  ; $270364
        OR.B   $39(A3,A0.W),D1                  ; $270368
        OR.W   D0,D4                            ; $27036C
        OR.W   D0,A3                            ; $27036E
        OR.W   D0,A3                            ; $270370
        OR.W   D0,A3                            ; $270372
        OR.W   D0,A6                            ; $270374
        OR.W   (A3),D0                          ; $270376
        OR.W   -(A2),D0                         ; $270378
        DC.W    $7F79,$808B,$819A,$81A5; $27037A MOVE.W  $808B819A,-$7E5B(A7)
        OR.L   D0,-$7E52(A4)                    ; $270382
        OR.L   -$51(A0,A0.W),D1                 ; $270386
        OR.L   -$7D5E(A0),D1                    ; $27038A
        OR.L   D0,(A7)+                         ; $27038E
        OR.L   (A4),D1                          ; $270390
        DC.W    $847D               ; $270392 OR.W   <EA:3D>,D2
        OR.W   (A7)+,D4                         ; $270394
        OR.W   A2,D5                            ; $270396
        OR.W   D4,A1                            ; $270398
        OR.W   D2,-(A0)                         ; $27039A
        DC.W    $7F7F,$7BA3         ; $27039C MOVE.W  <EA:3F>,$7BA3(A7)
        MOVEQ   #-$32,D4                        ; $2703A0
        MOVE.W  -(A3),$73E9(PC)                 ; $2703A2
        DC.W    $73EF,$73EF,$73ED,$72EB; $2703A6 MOVE.W  $73EF(A7),$73ED72EB
        MOVEQ   #-$17,D1                        ; $2703AE
        DC.W    $73E8,$75E6,$77E5,$7AE4; $2703B0 MOVE.W  $75E6(A0),$77E57AE4
        MOVEQ   #-$1E,D6                        ; $2703B8
        MOVEQ   #-$21,D7                        ; $2703BA
        DIVU    (A2),D0                         ; $2703BC
        OR.L   D0,-$7B(A0,A0.W)                 ; $2703BE
        OR.W   D1,-(A5)                         ; $2703C2
        OR.W   D1,A1                            ; $2703C4
        OR.B   $2C(A5,A0.W),D1                  ; $2703C6
        OR.B   $7F30(A7),D0                     ; $2703CA
        OR.B   $2B(A0,A0.W),D0                  ; $2703CE
        OR.B   -(A7),D1                         ; $2703D2
        OR.B   D1,-$7BD8(A0)                    ; $2703D4
        OR.B   D1,-$7ED7(A0)                    ; $2703D8
        OR.B   $7F2B(A2),D0                     ; $2703DC
        OR.B   -$7ED3(A4),D0                    ; $2703E0
        OR.B   -$7FCF(A6),D0                    ; $2703E4
        DC.W    $7F3D               ; $2703E8 MOVE.W  <EA:3D>,-(A7)
        MOVE.W  A2,$7F5F(A7)                    ; $2703EA
        MOVEQ   #$76,D7                         ; $2703EE
        MOVEQ   #-$7A,D7                        ; $2703F0
        MOVE.W  A0,-$79(A7,A0.W)                ; $2703F2
        OR.L   D0,D0                            ; $2703F6
        OR.W   D1,$62(A1,A0.W)                  ; $2703F8
        OR.W   (A5),D2                          ; $2703FC
        OR.W   D1,A5                            ; $2703FE
        OR.W   D0,A6                            ; $270400
        MOVE.W  (A4),$7F52(A7)                  ; $270402
        OR.W   A5,D0                            ; $270406
        OR.W   D0,A2                            ; $270408
        OR.W   A1,D0                            ; $27040A
        OR.W   A5,D0                            ; $27040C
        OR.W   (A5)+,D0                         ; $27040E
        OR.W   -$71(A6,D7.L),D0                 ; $270410
        MOVEQ   #-$5C,D7                        ; $270414
        MOVEQ   #-$52,D7                        ; $270416
        MOVE.W  -$7D65(A0),-$6E(A7,A0.W)        ; $270418
        DC.W    $857F               ; $27041E OR.W   D2,<EA:3F>
        OR.W   (A7)+,D4                         ; $270420
        OR.W   D5,A2                            ; $270422
        OR.W   D4,A5                            ; $270424
        OR.W   $7F8D(A0),D2                     ; $270426
        DC.W    $79BE,$75DF         ; $27042A MOVE.W  <EA:3E>,-$21(A4,D7.W)
        MOVEQ   #-$15,D1                        ; $27042E
        MOVE.W  -$0B(A1,D7.W),$75F4.W           ; $270430
        MOVE.W  -$10(A2,D7.W),-$12(PC,D7.W)     ; $270436
        MOVE.W  $77EB(A4),$79E9(PC)             ; $27043C
        MOVEQ   #-$18,D5                        ; $270442
        MOVEQ   #-$1A,D6                        ; $270444
        DC.W    $7DE5               ; $270446 MOVE.W  -(A5),<EA:3E>
        MOVEQ   #-$20,D7                        ; $270448
        MOVEQ   #-$2F,D7                        ; $27044A
        MOVEQ   #-$3F,D7                        ; $27044C
        MOVE.W  -$65(A1,D7.L),$7D(A7,A0.W)      ; $27044E
        OR.W   -(A0),D0                         ; $270454
        OR.W   D0,A4                            ; $270456
        OR.B   $2B(PC,A0.W),D1                  ; $270458
        OR.B   D1,-(A6)                         ; $27045C
        OR.B   D1,-(A4)                         ; $27045E
        OR.B   -(A4),D1                         ; $270460
        OR.B   -(A5),D1                         ; $270462
        OR.B   -(A6),D1                         ; $270464
        OR.B   D1,-$7BD7(A0)                    ; $270466
        OR.B   -$7BD5(A2),D2                    ; $27046A
        OR.B   D1,-$7ED3(A4)                    ; $27046E
        MOVE.W  $3D(A0,D7.L),-(A7)              ; $270472
        MOVE.W  A3,$7F56(A7)                    ; $270476
        OR.W   (A3)+,D0                         ; $27047A
        OR.W   D0,(A7)                          ; $27047C
        OR.W   A3,D1                            ; $27047E
        OR.W   D1,D3                            ; $270480
        OR.W   D1,D3                            ; $270482
        OR.W   A2,D0                            ; $270484
        MOVEQ   #$5A,D7                         ; $270486
        MOVE.W  -(A5),$7D6B(A6)                 ; $270488
        MOVEQ   #$6A,D7                         ; $27048C
        MOVE.W  -(A4),-$7FAB(A7)                ; $27048E
        OR.W   D0,D7                            ; $270492
        OR.W   D0,D2                            ; $270494
        OR.W   D0,D6                            ; $270496
        OR.W   (A3),D0                          ; $270498
        OR.W   -(A5),D0                         ; $27049A
        OR.W   $7B(A2,A0.W),D0                  ; $27049C
        OR.L   D0,A0                            ; $2704A0
        MOVE.W  (A6),-$5D(A7,D7.L)              ; $2704A2
        OR.L   -$7D5B(A2),D0                    ; $2704A6
        OR.L   (A3)+,D2                         ; $2704AA
        OR.L   D2,(A0)                          ; $2704AC
        OR.L   D6,D3                            ; $2704AE
        OR.L   D0,D3                            ; $2704B0
        OR.L   D0,D3                            ; $2704B2
        OR.L   D1,A2                            ; $2704B4
        OR.L   (A1)+,D0                         ; $2704B6
        MOVEQ   #-$48,D6                        ; $2704B8
        MOVEQ   #-$22,D4                        ; $2704BA
        MOVE.W  $74EF(A2),$75F3(PC)             ; $2704BC
        MOVE.W  -$0E(A3,D7.W),$75F0(PC)         ; $2704C2
        MOVEQ   #-$12,D3                        ; $2704C8
        MOVE.W  $78EA(A4),-$17(PC,D7.L)         ; $2704CA
        MOVE.W  $7BE7(A0),#$7BE5                ; $2704D0
        DC.W    $7BE4               ; $2704D6 MOVE.W  -(A4),<EA:3D>
        DC.W    $7BE2               ; $2704D8 MOVE.W  -(A2),<EA:3D>
        DC.W    $7DE1               ; $2704DA MOVE.W  -(A1),<EA:3E>
        MOVEQ   #-$28,D7                        ; $2704DC
        MOVE.W  -$71(A7,A0.W),$69(A7,A0.W)      ; $2704DE
        OR.W   A1,D0                            ; $2704E4
        OR.B   -$7FDA(A7),D0                    ; $2704E6
        OR.B   -(A2),D1                         ; $2704EA
        OR.B   D1,-(A0)                         ; $2704EC
        OR.B   D1,-(A1)                         ; $2704EE
        OR.B   -(A3),D1                         ; $2704F0
        OR.B   -(A5),D1                         ; $2704F2
        OR.B   D1,-(A6)                         ; $2704F4
        OR.B   -$7BD7(A0),D2                    ; $2704F6
        OR.B   -$7CD5(A2),D2                    ; $2704FA
        OR.B   -$7DD3(A4),D1                    ; $2704FE
        OR.B   -$7DD1(A6),D1                    ; $270502
        OR.B   D0,$31(A0,A0.W)                  ; $270506
        OR.B   D0,$37(A3,A0.W)                  ; $27050A
        OR.B   D0,-$7FBC(PC)                    ; $27050E
        MOVE.W  (A4),$7C62(A6)                  ; $270512
        MOVE.W  -$7D(A3,D7.L),$7B8C(A5)         ; $270516
        MOVE.W  A7,-$7C(A6,D7.L)                ; $27051C
        MOVE.W  $7F5C(A5),$7F56(A7)             ; $270520
        MOVEQ   #$57,D7                         ; $270526
        MOVEQ   #$60,D7                         ; $270528
        MOVEQ   #$6C,D7                         ; $27052A
        MOVEQ   #$7A,D7                         ; $27052C
        MOVEQ   #-$74,D7                        ; $27052E
        MOVE.W  (A0)+,-$63(A7,A0.W)             ; $270530
        OR.L   (A5)+,D1                         ; $270534
        OR.L   D1,(A0)+                         ; $270536
        OR.L   (A0),D2                          ; $270538
        DC.W    $877D               ; $27053A OR.W   D3,<EA:3D>
        OR.W   -(A3),D5                         ; $27053C
        OR.W   (A0),D5                          ; $27053E
        OR.W   (A7)+,D3                         ; $270540
        OR.L   D0,D5                            ; $270542
        MOVE.W  -$26(A6,D7.L),-$17(A5,D7.W)     ; $270544
        MOVEQ   #-$10,D3                        ; $27054A
        MOVEQ   #-$0B,D3                        ; $27054C
        MOVEQ   #-$0C,D3                        ; $27054E
        MOVE.W  -$10(A2,D7.W),-$12(PC,D7.W)     ; $270550
        MOVEQ   #-$14,D4                        ; $270556
        MOVE.W  $79E9(A3),#$7AE8                ; $270558
        DC.W    $7BE7               ; $27055E MOVE.W  -(A7),<EA:3D>
        MOVEQ   #-$1A,D7                        ; $270560
        MOVEQ   #-$1C,D7                        ; $270562
        MOVEQ   #-$1D,D7                        ; $270564
        DC.W    $7DE1               ; $270566 MOVE.W  -(A1),<EA:3E>
        DC.W    $7DDD               ; $270568 MOVE.W  (A5)+,<EA:3E>
        MOVEQ   #-$34,D7                        ; $27056A
        MOVE.W  -$52(PC,D7.L),-$69(A7,D7.L)     ; $27056C
        OR.W   $51(A0,A0.W),D0                  ; $270572
        DC.W    $7F3E               ; $270576 MOVE.W  <EA:3E>,-(A7)
        MOVE.W  -$7FDD(A2),-(A7)                ; $270578
        OR.B   -(A1),D2                         ; $27057C
        OR.B   -(A0),D3                         ; $27057E
        OR.B   D2,-(A1)                         ; $270580
        OR.B   -(A3),D2                         ; $270582
        OR.B   -(A4),D2                         ; $270584
        OR.B   D1,-(A6)                         ; $270586
        OR.B   D0,-(A7)                         ; $270588
        MOVE.W  $7E29(A0),-(A7)                 ; $27058A
        OR.B   -$7FD5(A2),D0                    ; $27058E
        OR.B   -$7ED3(A4),D0                    ; $270592
        OR.B   D0,-$7FC9(A7)                    ; $270596
        MOVEQ   #$46,D7                         ; $27059A
        MOVE.W  (A1),$7D56(A6)                  ; $27059C
        MOVE.W  -(A4),$7D73(A6)                 ; $2705A0
        MOVEQ   #$7C,D6                         ; $2705A4
        MOVEQ   #$7E,D7                         ; $2705A6
        DC.W    $7F7F,$8078         ; $2705A8 MOVE.W  <EA:3F>,-$7F88(A7)
        OR.W   -$7FA0(A3),D0                    ; $2705AC
        MOVE.W  -(A3),$7F69(A7)                 ; $2705B0
        MOVEQ   #$69,D7                         ; $2705B4
        OR.W   -(A2),D0                         ; $2705B6
        OR.W   (A0)+,D1                         ; $2705B8
        OR.W   D1,(A4)+                         ; $2705BA
        OR.W   D1,-(A7)                         ; $2705BC
        OR.W   -$7A9C(A1),D2                    ; $2705BE
        OR.W   (A0)+,D4                         ; $2705C2
        OR.W   A0,D5                            ; $2705C4
        DC.W    $8C3F               ; $2705C6 OR.B   <EA:3F>,D6
        OR.B   D6,#$893E                        ; $2705C8
        OR.W   D2,(A4)                          ; $2705CC
        OR.W   #$7DAC,D0                        ; $2705CE
        MOVEQ   #-$2B,D5                        ; $2705D2
        MOVE.W  $74F2(A2),-$0A(PC,D7.W)         ; $2705D4
        MOVEQ   #-$09,D1                        ; $2705DA
        MOVEQ   #-$0B,D1                        ; $2705DC
        DC.W    $73F3,$74F1,$75EF,$76ED; $2705DE MOVE.W  -$0F(A3,D7.W),$75EF76ED
        MOVE.W  $79EB(A4),-$17(PC,D7.L)         ; $2705E6
        MOVEQ   #-$18,D6                        ; $2705EC
        MOVEQ   #-$19,D6                        ; $2705EE
        MOVEQ   #-$1B,D6                        ; $2705F0
        MOVEQ   #-$1F,D7                        ; $2705F2
        DC.W    $7FD1               ; $2705F4 MOVE.W  (A1),<EA:3F>
        OR.L   D0,-$62(A7,A0.W)                 ; $2705F6
        OR.L   D5,D1                            ; $2705FA
        OR.W   D0,-$7FA3(A4)                    ; $2705FC
        MOVE.W  A5,$7F37(A7)                    ; $270600
        OR.B   -$7DD9(A2),D0                    ; $270604
        OR.B   -(A5),D1                         ; $270608
        OR.B   -(A5),D1                         ; $27060A
        OR.B   -(A6),D1                         ; $27060C
        OR.B   D1,-(A7)                         ; $27060E
        OR.B   D1,-$7BD6(A0)                    ; $270610
        OR.B   D2,-$7BD4(A3)                    ; $270614
        OR.B   D0,$7E2E(A5)                     ; $270618
        MOVEQ   #$30,D6                         ; $27061C
        MOVEQ   #$3A,D6                         ; $27061E
        MOVE.W  D5,$7E45(A6)                    ; $270620
        OR.W   D4,D0                            ; $270624
        OR.W   D4,D1                            ; $270626
        OR.W   D6,D1                            ; $270628
        OR.W   A3,D1                            ; $27062A
        OR.W   D0,(A5)                          ; $27062C
        OR.W   -(A1),D0                         ; $27062E
        OR.W   -$7F83(A6),D0                    ; $270630
        OR.L   A2,D0                            ; $270634
        MOVE.W  (A1)+,-$54(A7,D7.L)             ; $270636
        DC.W    $7DC0               ; $27063A MOVE.W  D0,<EA:3E>
        MOVEQ   #-$35,D6                        ; $27063C
        DC.W    $7DCD               ; $27063E MOVE.W  A5,<EA:3E>
        MOVE.W  -$6C(PC,A0.W),$72(A7,A0.W)      ; $270640
        OR.W   -(A4),D1                         ; $270646
        OR.W   D0,-(A2)                         ; $270648
        OR.W   (A5)+,D1                         ; $27064A
        OR.W   (A5),D2                          ; $27064C
        OR.W   D3,A3                            ; $27064E
        OR.W   D3,D1                            ; $270650
        OR.B   D3,-$76C8(PC)                    ; $270652
        OR.B   D4,$8743.W                       ; $270656
        OR.W   $7CA3(A3),D1                     ; $27065A
        MOVEQ   #-$2C,D4                        ; $27065E
        MOVEQ   #-$1B,D3                        ; $270660
        MOVE.W  -$0B(A0,D7.W),$73F5(PC)         ; $270662
        MOVEQ   #-$0D,D1                        ; $270668
        MOVE.W  -$11(A1,D7.W),$73ED.W           ; $27066A
        MOVEQ   #-$14,D3                        ; $270670
        MOVEQ   #-$16,D5                        ; $270672
        DC.W    $7DE9,$7FE8         ; $270674 MOVE.W  $7FE8(A1),<EA:3E>
        DC.W    $7FE6               ; $270678 MOVE.W  -(A6),<EA:3F>
        MOVEQ   #-$1B,D7                        ; $27067A
        MOVEQ   #-$1E,D6                        ; $27067C
        MOVEQ   #-$2D,D6                        ; $27067E
        MOVEQ   #-$48,D7                        ; $270680
        MOVE.W  -(A5),-$68(A7,D7.L)             ; $270682
        MOVE.W  A0,$73(A6,D7.L)                 ; $270686
        MOVE.W  (A2)+,-$7FC1(A7)                ; $27068A
        OR.B   D0,-$7ED9(A4)                    ; $27068E
        OR.B   -(A4),D1                         ; $270692
        OR.B   -(A3),D1                         ; $270694
        OR.B   D1,-(A4)                         ; $270696
        OR.B   D2,-(A5)                         ; $270698
        OR.B   -(A7),D3                         ; $27069A
        OR.B   D3,-$78D7(A0)                    ; $27069C
        OR.B   -$7AD5(A2),D3                    ; $2706A0
        OR.B   D2,-$7CD3(A4)                    ; $2706A4
        OR.B   D0,-$7FD1(A6)                    ; $2706A8
        OR.B   $31(A0,D7.L),D0                  ; $2706AC
        MOVE.W  $34(A2,D7.L),-(A7)              ; $2706B0
        MOVEQ   #$3D,D7                         ; $2706B4
        MOVEQ   #$4A,D7                         ; $2706B6
        MOVEQ   #$53,D7                         ; $2706B8
        MOVEQ   #$5F,D7                         ; $2706BA
        MOVE.W  -$77(A2,D7.L),$7D9F(A6)         ; $2706BC
        MOVEQ   #-$50,D7                        ; $2706C2
        MOVEQ   #-$45,D7                        ; $2706C4
        MOVEQ   #-$3D,D7                        ; $2706C6
        MOVEQ   #-$3D,D7                        ; $2706C8
        MOVEQ   #-$44,D7                        ; $2706CA
        MOVE.W  $7FA9(A7),-$5D(A7,D7.L)         ; $2706CC
        MOVE.W  (A0)+,-$74(A7,A0.W)             ; $2706D2
        OR.W   D0,$67(PC,A0.W)                  ; $2706D6
        OR.W   D2,(A1)                          ; $2706DA
        DC.W    $863F               ; $2706DC OR.B   <EA:3F>,D3
        OR.B   $8B35.W,D4                       ; $2706DE
        OR.B   D6,$35(A4,A0.L)                  ; $2706E2
        DC.W    $863D               ; $2706E6 OR.B   <EA:3D>,D3
        MOVE.W  $79AC(A1),$77D6(A7)             ; $2706E8
        MOVEQ   #-$1A,D4                        ; $2706EE
        MOVE.W  $79F5(A7),#$78F4                ; $2706F0
        MOVEQ   #-$0E,D4                        ; $2706F6
        MOVEQ   #-$10,D4                        ; $2706F8
        MOVEQ   #-$12,D4                        ; $2706FA
        MOVEQ   #-$14,D4                        ; $2706FC
        MOVEQ   #-$16,D4                        ; $2706FE
        MOVEQ   #-$17,D4                        ; $270700
        MOVEQ   #-$18,D4                        ; $270702
        MOVE.W  -(A6),#$79E5                    ; $270704
        MOVE.W  -(A4),#$7AE3                    ; $270708
        MOVEQ   #-$1F,D6                        ; $27070C
        MOVEQ   #-$20,D6                        ; $27070E
        MOVEQ   #-$25,D6                        ; $270710
        MOVEQ   #-$38,D6                        ; $270712
        MOVE.W  $7E90(A4),$73(A6,D7.L)          ; $270714
        MOVE.W  A6,-$7FCF(A7)                   ; $27071A
        OR.B   -(A6),D1                         ; $27071E
        OR.B   D1,-(A1)                         ; $270720
        OR.B   (A6)+,D2                         ; $270722
        OR.B   D2,(A7)+                         ; $270724
        OR.B   D2,-(A0)                         ; $270726
        OR.B   -(A2),D3                         ; $270728
        OR.B   D3,-(A4)                         ; $27072A
        OR.B   -(A5),D4                         ; $27072C
        OR.B   D4,-(A6)                         ; $27072E
        OR.B   -(A7),D5                         ; $270730
        OR.B   D4,-$78D7(A0)                    ; $270732
        OR.B   D2,-$7BD4(A2)                    ; $270736
        OR.B   -$7ECA(A5),D1                    ; $27073A
        MOVE.W  A3,$7E60(A7)                    ; $27073E
        MOVE.W  $7A(A0,D7.L),$7D84(A6)          ; $270742
        MOVE.W  (A3),-$52(A5,D7.L)              ; $270748
        MOVEQ   #-$38,D5                        ; $27074C
        MOVE.W  (A2)+,#$78E5                    ; $27074E
        MOVE.W  $7BE9(A1),#$7CE3                ; $270752
        DC.W    $7DD4               ; $270758 MOVE.W  (A4),<EA:3E>
        MOVE.W  -$7F67(PC),$79(A7,A0.W)         ; $27075A
        OR.W   D0,(A7)+                         ; $270760
        OR.W   (A0),D0                          ; $270762
        OR.W   D6,D0                            ; $270764
        OR.B   -$7BD2(PC),D1                    ; $270766
        OR.B   D3,-$76D5(A3)                    ; $27076A
        OR.B   D5,-$73D4(A3)                    ; $27076E
        OR.B   -$79BF(A7),D5                    ; $270772
        OR.W   D0,$7D9A(A2)                     ; $270776
        DC.W    $7BC5               ; $27077A MOVE.W  D5,<EA:3D>
        DC.W    $7BDD               ; $27077C MOVE.W  (A5)+,<EA:3D>
        DC.W    $7BE6               ; $27077E MOVE.W  -(A6),<EA:3D>
        MOVE.W  $77EC(A3),#$76EB                ; $270780
        MOVEQ   #-$17,D3                        ; $270786
        MOVEQ   #-$19,D4                        ; $270788
        MOVE.W  -(A5),#$7BE3                    ; $27078A
        MOVEQ   #-$1E,D6                        ; $27078E
        MOVEQ   #-$1F,D6                        ; $270790
        MOVEQ   #-$20,D5                        ; $270792
        MOVE.W  (A7)+,#$79DD                    ; $270794
        MOVEQ   #-$24,D5                        ; $270798
        DC.W    $7BDB               ; $27079A MOVE.W  (A3)+,<EA:3D>
        MOVEQ   #-$27,D6                        ; $27079C
        DC.W    $7DD1               ; $27079E MOVE.W  (A1),<EA:3E>
        DC.W    $7DC1               ; $2707A0 MOVE.W  D1,<EA:3E>
        MOVEQ   #-$50,D7                        ; $2707A2
        MOVE.W  -(A1),-$74(A7,D7.L)             ; $2707A4
        OR.W   -$7EB6(A6),D0                    ; $2707A8
        OR.B   -$7CDF(A6),D1                    ; $2707AC
        OR.B   (A3)+,D2                         ; $2707B0
        OR.B   D2,(A1)+                         ; $2707B2
        OR.B   (A1)+,D3                         ; $2707B4
        OR.B   (A2)+,D3                         ; $2707B6
        OR.B   (A4)+,D3                         ; $2707B8
        OR.B   D3,(A6)+                         ; $2707BA
        OR.B   (A7)+,D4                         ; $2707BC
        OR.B   D3,-(A0)                         ; $2707BE
        OR.B   -(A1),D3                         ; $2707C0
        OR.B   D2,-(A3)                         ; $2707C2
        OR.B   -(A4),D2                         ; $2707C4
        OR.B   -(A5),D1                         ; $2707C6
        OR.B   -(A6),D0                         ; $2707C8
        MOVE.W  $7E3D(A4),-(A7)                 ; $2707CA
        MOVEQ   #$4E,D7                         ; $2707CE
        MOVEQ   #$61,D7                         ; $2707D0
        DC.W    $7D79,$7B89,$7A96,$79A6; $2707D2 MOVE.W  $7B897A96,$79A6(A6)
        MOVEQ   #-$4B,D4                        ; $2707DA
        MOVE.W  D6,#$7AD7                       ; $2707DC
        DC.W    $7BDF               ; $2707E0 MOVE.W  (A7)+,<EA:3D>
        MOVEQ   #-$26,D6                        ; $2707E2
        MOVEQ   #-$30,D7                        ; $2707E4
        DC.W    $7FC5               ; $2707E6 MOVE.W  D5,<EA:3F>
        OR.L   D0,-$62(A7,A0.W)                 ; $2707E8
        OR.W   #$855B,D2                        ; $2707EC
        OR.W   D2,D6                            ; $2707F0
        OR.B   $28(A3,A0.W),D2                  ; $2707F2
        OR.B   D4,-(A5)                         ; $2707F6
        OR.B   -(A4),D6                         ; $2707F8
        OR.B   D5,-(A5)                         ; $2707FA
        OR.B   D3,-(A7)                         ; $2707FC
        OR.B   -$7EBF(A3),D2                    ; $2707FE
        MOVEQ   #$5C,D7                         ; $270802
        MOVEQ   #$75,D6                         ; $270804
        MOVE.W  (A0),-$50(A5,D7.L)              ; $270806
        MOVE.W  A6,#$77DF                       ; $27080A
        MOVEQ   #-$1D,D3                        ; $27080E
        MOVEQ   #-$1A,D3                        ; $270810
        MOVEQ   #-$19,D4                        ; $270812
        MOVE.W  -(A5),#$79E3                    ; $270814
        MOVEQ   #-$1E,D5                        ; $270818
        MOVEQ   #-$20,D5                        ; $27081A
        DC.W    $7BDF               ; $27081C MOVE.W  (A7)+,<EA:3D>
        DC.W    $7DDD               ; $27081E MOVE.W  (A5)+,<EA:3E>
        MOVEQ   #-$25,D7                        ; $270820
        MOVEQ   #-$2A,D7                        ; $270822
        MOVEQ   #-$2D,D7                        ; $270824
        DC.W    $7DD5               ; $270826 MOVE.W  (A5),<EA:3E>
        MOVEQ   #-$2A,D6                        ; $270828
        DC.W    $7DD3               ; $27082A MOVE.W  (A3),<EA:3E>
        DC.W    $7DC9               ; $27082C MOVE.W  A1,<EA:3E>
        MOVEQ   #-$44,D7                        ; $27082E
        MOVEQ   #-$51,D7                        ; $270830
        MOVE.W  (A2)+,-$7F(A6,D7.L)             ; $270832
        OR.W   -$7EA8(A6),D0                    ; $270836
        OR.B   $20(A5,A0.W),D1                  ; $27083A
        OR.B   (A4)+,D4                         ; $27083E
        OR.B   D4,(A0)+                         ; $270840
        OR.B   D4,(A6)                          ; $270842
        OR.B   D4,(A0)+                         ; $270844
        OR.B   D4,(A1)+                         ; $270846
        OR.B   D3,(A3)+                         ; $270848
        OR.B   (A4)+,D2                         ; $27084A
        OR.B   D0,(A6)+                         ; $27084C
        OR.B   (A7)+,D0                         ; $27084E
        OR.B   D0,-(A3)                         ; $270850
        OR.B   D0,-$7DC9(A3)                    ; $270852
        OR.W   D6,D1                            ; $270856
        OR.W   (A5),D1                          ; $270858
        OR.W   D0,-(A2)                         ; $27085A
        MOVE.W  $7D7D(A7),$7B8D(A7)             ; $27085C
        MOVEQ   #-$62,D5                        ; $270862
        MOVE.W  -$37(A3,D7.L),-$27(A4,D7.L)     ; $270864
        MOVE.W  (A5)+,#$79E0                    ; $27086A
        MOVEQ   #-$20,D5                        ; $27086E
        MOVEQ   #-$21,D5                        ; $270870
        MOVEQ   #-$23,D5                        ; $270872
        DC.W    $7BDA               ; $270874 MOVE.W  (A2)+,<EA:3D>
        MOVEQ   #-$30,D6                        ; $270876
        MOVEQ   #-$44,D7                        ; $270878
        OR.L   (A2)+,D0                         ; $27087A
        OR.W   D1,-(A4)                         ; $27087C
        OR.B   $28(A5,A0.L),D4                  ; $27087E
        OR.B   (A7)+,D6                         ; $270882
        OR.B   D5,(A2)+                         ; $270884
        OR.B   D4,(A2)+                         ; $270886
        OR.B   (A4)+,D4                         ; $270888
        OR.B   (A7)+,D3                         ; $27088A
        OR.B   $7E56(A3),D1                     ; $27088C
        MOVE.W  D6,-$5A(A5,D7.L)                ; $270890
        DC.W    $7BBE,$7AD3         ; $270894 MOVE.W  <EA:3E>,-$2D(A5,D7.L)
        MOVE.W  (A4)+,#$78DE                    ; $270898
        MOVE.W  (A6)+,#$7ADD                    ; $27089C
        MOVEQ   #-$24,D5                        ; $2708A0
        DC.W    $7BDA               ; $2708A2 MOVE.W  (A2)+,<EA:3D>
        DC.W    $7BD8               ; $2708A4 MOVE.W  (A0)+,<EA:3D>
        DC.W    $7BD7               ; $2708A6 MOVE.W  (A7),<EA:3D>
        MOVEQ   #-$2A,D6                        ; $2708A8
        MOVEQ   #-$2B,D6                        ; $2708AA
        DC.W    $7DD4               ; $2708AC MOVE.W  (A4),<EA:3E>
        MOVEQ   #-$2F,D7                        ; $2708AE
        DC.W    $7FCC               ; $2708B0 MOVE.W  A4,<EA:3F>
        DIVU    D1,D0                           ; $2708B2
        OR.L   D0,-$5B(A2,A0.W)                 ; $2708B4
        OR.L   (A6)+,D0                         ; $2708B8
        OR.L   (A6),D0                          ; $2708BA
        MOVE.W  D7,$79(A7,A0.W)                 ; $2708BC
        OR.W   -(A6),D0                         ; $2708C0
        MOVE.W  (A1),-$7FC3(A7)                 ; $2708C2
        OR.B   -$7CE7(A0),D1                    ; $2708C6
        OR.B   D2,(A5)                          ; $2708CA
        OR.B   (A3),D3                          ; $2708CC
        OR.B   D2,(A3)                          ; $2708CE
        OR.B   (A4),D2                          ; $2708D0
        OR.B   (A6),D2                          ; $2708D2
        OR.B   (A7),D2                          ; $2708D4
        OR.B   (A1)+,D2                         ; $2708D6
        OR.B   (A2)+,D2                         ; $2708D8
        OR.B   (A3)+,D1                         ; $2708DA
        OR.B   D0,(A4)+                         ; $2708DC
        MOVE.W  (A6)+,-(A7)                     ; $2708DE
        MOVEQ   #$1F,D7                         ; $2708E0
        MOVE.W  -(A1),-(A6)                     ; $2708E2
        MOVE.W  $7E32(A1),-(A6)                 ; $2708E4
        MOVEQ   #$42,D7                         ; $2708E8
        MOVEQ   #$52,D7                         ; $2708EA
        MOVE.W  -(A6),$7B7D(A6)                 ; $2708EC
        MOVEQ   #-$6C,D5                        ; $2708F0
        MOVEQ   #-$57,D5                        ; $2708F2
        MOVEQ   #-$47,D5                        ; $2708F4
        MOVE.W  D6,#$7AD2                       ; $2708F6
        MOVEQ   #-$24,D5                        ; $2708FA
        DC.W    $7BDD               ; $2708FC MOVE.W  (A5)+,<EA:3D>
        MOVEQ   #-$25,D6                        ; $2708FE
        MOVEQ   #-$2D,D7                        ; $270900
        DC.W    $7FC1               ; $270902 MOVE.W  D1,<EA:3F>
        OR.L   D0,-$7D7B(A0)                    ; $270904
        OR.W   D2,(A1)+                         ; $270908
        OR.B   $27(A5,A0.L),D4                  ; $27090A
        OR.B   -(A1),D5                         ; $27090E
        OR.B   (A5)+,D4                         ; $270910
        OR.B   D3,(A6)+                         ; $270912
        OR.B   -(A0),D3                         ; $270914
        OR.B   D2,-(A5)                         ; $270916
        OR.B   D1,$60(PC,A0.W)                  ; $270918
        MOVE.W  D1,-$68(A7,D7.L)                ; $27091C
        MOVEQ   #-$51,D7                        ; $270920
        DC.W    $7DC9               ; $270922 MOVE.W  A1,<EA:3E>
        MOVEQ   #-$27,D6                        ; $270924
        DC.W    $7BDE               ; $270926 MOVE.W  (A6)+,<EA:3D>
        MOVEQ   #-$20,D5                        ; $270928
        MOVE.W  -(A0),#$79DF                    ; $27092A
        MOVE.W  (A5)+,#$7BDC                    ; $27092E
        MOVEQ   #-$26,D6                        ; $270932
        DC.W    $7DD9               ; $270934 MOVE.W  (A1)+,<EA:3E>
        MOVEQ   #-$28,D7                        ; $270936
        MOVEQ   #-$29,D7                        ; $270938
        MOVEQ   #-$2A,D7                        ; $27093A
        MOVEQ   #-$2B,D7                        ; $27093C
        MOVEQ   #-$2C,D6                        ; $27093E
        DC.W    $7BD3               ; $270940 MOVE.W  (A3),<EA:3D>
        DC.W    $7BD1               ; $270942 MOVE.W  (A1),<EA:3D>
        DC.W    $7BD0               ; $270944 MOVE.W  (A0),<EA:3D>
        MOVEQ   #-$31,D6                        ; $270946
        DC.W    $7DCD               ; $270948 MOVE.W  A5,<EA:3E>
        MOVEQ   #-$3D,D7                        ; $27094A
        MOVEQ   #-$51,D7                        ; $27094C
        MOVEQ   #-$62,D7                        ; $27094E
        MOVE.W  D7,$69(A6,D7.L)                 ; $270950
        OR.W   A5,D0                            ; $270954
        OR.B   -$7CE6(A6),D1                    ; $270956
        OR.B   D2,(A3)                          ; $27095A
        OR.B   (A0),D3                          ; $27095C
        OR.B   D3,A7                            ; $27095E
        OR.B   (A0),D3                          ; $270960
        OR.B   (A2),D2                          ; $270962
        OR.B   D1,(A4)                          ; $270964
        OR.B   D1,(A5)                          ; $270966
        OR.B   D1,(A7)                          ; $270968
        OR.B   D1,(A0)+                         ; $27096A
        OR.B   (A1)+,D1                         ; $27096C
        OR.B   D0,(A3)+                         ; $27096E
        OR.B   (A4)+,D0                         ; $270970
        MOVE.W  (A6)+,-(A7)                     ; $270972
        MOVE.W  -(A6),-(A6)                     ; $270974
        DC.W    $7B3D               ; $270976 MOVE.W  <EA:3D>,-(A5)
        MOVEQ   #$4F,D5                         ; $270978
        MOVE.W  (A7)+,$7C71(A5)                 ; $27097A
        MOVEQ   #-$7A,D6                        ; $27097E
        MOVEQ   #-$6C,D6                        ; $270980
        MOVE.W  (A5)+,-$5A(A6,D7.L)             ; $270982
        MOVE.W  $7DB8(A6),-$3F(A6,D7.L)         ; $270986
        DC.W    $7DC4               ; $27098C MOVE.W  D4,<EA:3E>
        MOVEQ   #-$46,D7                        ; $27098E
        MOVE.W  $7F96(A1),-$7E(A7,D7.L)         ; $270990
        OR.W   D0,-$7CBF(A0)                    ; $270996
        OR.B   -$77DC(A3),D3                    ; $27099A
        OR.B   -(A0),D4                         ; $27099E
        OR.B   D3,(A6)+                         ; $2709A0
        OR.B   D3,(A7)+                         ; $2709A2
        OR.B   D2,-(A4)                         ; $2709A4
        OR.B   D1,$825C8183                     ; $2709A6
        OR.L   -(A6),D0                         ; $2709AC
        MOVEQ   #-$39,D7                        ; $2709AE
        MOVEQ   #-$29,D7                        ; $2709B0
        DC.W    $7DDE               ; $2709B2 MOVE.W  (A6)+,<EA:3E>
        DC.W    $7BE1               ; $2709B4 MOVE.W  -(A1),<EA:3D>
        MOVEQ   #-$1F,D5                        ; $2709B6
        DC.W    $7BDF               ; $2709B8 MOVE.W  (A7)+,<EA:3D>
        MOVEQ   #-$22,D6                        ; $2709BA
        DC.W    $7DDC               ; $2709BC MOVE.W  (A4)+,<EA:3E>
        DC.W    $7DDA               ; $2709BE MOVE.W  (A2)+,<EA:3E>
        MOVEQ   #-$27,D6                        ; $2709C0
        DC.W    $7DD8               ; $2709C2 MOVE.W  (A0)+,<EA:3E>
        DC.W    $7DD7               ; $2709C4 MOVE.W  (A7),<EA:3E>
        MOVEQ   #-$2A,D6                        ; $2709C6
        DC.W    $7BD5               ; $2709C8 MOVE.W  (A5),<EA:3D>
        DC.W    $7BD3               ; $2709CA MOVE.W  (A3),<EA:3D>
        MOVEQ   #-$2E,D6                        ; $2709CC
        DC.W    $7DCF               ; $2709CE MOVE.W  A7,<EA:3E>
        MOVEQ   #-$39,D7                        ; $2709D0
        DC.W    $7DBE,$7DB5         ; $2709D2 MOVE.W  <EA:3E>,-$4B(A6,D7.L)
        MOVE.W  $7E9D(A0),-$74(A6,D7.L)         ; $2709D6
        MOVE.W  $69(PC,A0.W),-$7EAF(A7)         ; $2709DC
        OR.B   -$7CDD(PC),D1                    ; $2709E2
        OR.B   D1,(A7)                          ; $2709E6
        OR.B   (A3),D1                          ; $2709E8
        OR.B   (A2),D1                          ; $2709EA
        OR.B   D0,(A2)                          ; $2709EC
        OR.B   D0,(A3)                          ; $2709EE
        OR.B   (A5),D1                          ; $2709F0
        OR.B   (A6),D1                          ; $2709F2
        OR.B   D1,(A0)+                         ; $2709F4
        OR.B   (A1)+,D2                         ; $2709F6
        OR.B   D1,(A2)+                         ; $2709F8
        OR.B   D0,(A4)+                         ; $2709FA
        OR.B   (A5)+,D0                         ; $2709FC
        MOVEQ   #$20,D7                         ; $2709FE
        MOVE.W  $7C4B(A7),-(A6)                 ; $270A00
        MOVE.W  -(A2),$7C72(A5)                 ; $270A04
        MOVE.W  $78(A6,D7.L),$7D81(A6)          ; $270A08
        MOVEQ   #-$73,D6                        ; $270A0E
        MOVE.W  (A1)+,-$5E(A5,D7.L)             ; $270A10
        MOVE.W  -(A5),-$56(A6,D7.L)             ; $270A14
        MOVEQ   #-$4D,D6                        ; $270A18
        DC.W    $7BBD,$7CBF         ; $270A1A MOVE.W  <EA:3D>,-$41(A5,D7.L)
        MOVE.W  -$7F74(A6),$5E(A6,A0.W)         ; $270A1E
        OR.B   D3,$2A(A7,A0.L)                  ; $270A24
        OR.B   -(A3),D5                         ; $270A28
        OR.B   (A6)+,D5                         ; $270A2A
        OR.B   D3,(A7)+                         ; $270A2C
        OR.B   D2,-(A7)                         ; $270A2E
        OR.W   D0,A0                            ; $270A30
        MOVEQ   #$71,D7                         ; $270A32
        MOVEQ   #-$70,D7                        ; $270A34
        MOVEQ   #-$58,D7                        ; $270A36
        MOVEQ   #-$49,D7                        ; $270A38
        DC.W    $7DC1               ; $270A3A MOVE.W  D1,<EA:3E>
        DC.W    $7BCA               ; $270A3C MOVE.W  A2,<EA:3D>
        DC.W    $7BD2               ; $270A3E MOVE.W  (A2),<EA:3D>
        MOVEQ   #-$31,D6                        ; $270A40
        MOVEQ   #-$3D,D6                        ; $270A42
        DC.W    $7DC1               ; $270A44 MOVE.W  D1,<EA:3E>
        DC.W    $7DC4               ; $270A46 MOVE.W  D4,<EA:3E>
        DC.W    $7DC3               ; $270A48 MOVE.W  D3,<EA:3E>
        MOVEQ   #-$40,D7                        ; $270A4A
        MOVE.W  $7FB0(PC),-$57(A7,D7.L)         ; $270A4C
        MOVEQ   #-$57,D7                        ; $270A52
        MOVEQ   #-$54,D7                        ; $270A54
        MOVE.W  -$43(A4,D7.L),-$3C(A6,D7.L)     ; $270A56
        MOVEQ   #-$34,D6                        ; $270A5C
        DC.W    $7BD1               ; $270A5E MOVE.W  (A1),<EA:3D>
        DC.W    $7BD2               ; $270A60 MOVE.W  (A2),<EA:3D>
        MOVEQ   #-$2E,D6                        ; $270A62
        DC.W    $7DD0               ; $270A64 MOVE.W  (A0),<EA:3E>
        MOVEQ   #-$37,D7                        ; $270A66
        MOVE.W  -$6F(A4,A0.W),$6D(A7,A0.W)      ; $270A68
        OR.W   D1,(A4)                          ; $270A6E
        OR.W   D1,D1                            ; $270A70
        OR.B   $2E(A7,A0.W),D1                  ; $270A72
        OR.B   D1,-(A0)                         ; $270A76
        OR.B   (A7),D1                          ; $270A78
        OR.B   (A6),D1                          ; $270A7A
        OR.B   (A5),D1                          ; $270A7C
        OR.B   (A5),D1                          ; $270A7E
        OR.B   (A6),D1                          ; $270A80
        OR.B   D0,(A0)+                         ; $270A82
        OR.B   (A1)+,D0                         ; $270A84
        OR.B   (A3)+,D0                         ; $270A86
        MOVE.W  -(A0),-(A7)                     ; $270A88
        OR.B   -$7FD5(A1),D0                    ; $270A8A
        OR.B   D0,-$7ECD(A5)                    ; $270A8E
        DC.W    $7F3E               ; $270A92 MOVE.W  <EA:3E>,-(A7)
        MOVEQ   #$4B,D7                         ; $270A94
        MOVE.W  (A5)+,$7B74(A6)                 ; $270A96
        MOVE.W  A1,-$5F(A5,D7.L)                ; $270A9A
        MOVEQ   #-$45,D5                        ; $270A9E
        MOVE.W  (A3),#$79DA                     ; $270AA0
        MOVE.W  (A5)+,#$7ADF                    ; $270AA4
        MOVEQ   #-$22,D6                        ; $270AA8
        MOVEQ   #-$27,D7                        ; $270AAA
        DIVU    D5,D0                           ; $270AAC
        OR.L   D1,-(A3)                         ; $270AAE
        DC.W    $847D               ; $270AB0 OR.W   <EA:3D>,D2
        OR.W   (A4),D3                          ; $270AB2
        OR.B   D3,$24(A2,A0.L)                  ; $270AB4
        OR.B   (A7)+,D5                         ; $270AB8
        OR.B   D4,(A3)+                         ; $270ABA
        OR.B   (A4)+,D3                         ; $270ABC
        OR.B   -(A2),D1                         ; $270ABE
        DC.W    $7F3D               ; $270AC0 MOVE.W  <EA:3D>,-(A7)
        MOVEQ   #$68,D7                         ; $270AC2
        MOVE.W  (A0)+,-$43(A6,D7.L)             ; $270AC4
        DC.W    $7BD2               ; $270AC8 MOVE.W  (A2),<EA:3D>
        DC.W    $7DDA               ; $270ACA MOVE.W  (A2)+,<EA:3E>
        DC.W    $7DDD               ; $270ACC MOVE.W  (A5)+,<EA:3E>
        MOVEQ   #-$2C,D7                        ; $270ACE
        MOVEQ   #-$3D,D7                        ; $270AD0
        MOVEQ   #-$46,D7                        ; $270AD2
        DC.W    $7DBF,$7CC9         ; $270AD4 MOVE.W  <EA:3F>,-$37(A6,D7.L)
        MOVEQ   #-$32,D6                        ; $270AD8
        MOVEQ   #-$34,D6                        ; $270ADA
        DC.W    $7DC3               ; $270ADC MOVE.W  D3,<EA:3E>
        MOVE.W  -$4D(PC,D7.L),-$59(A6,D7.L)     ; $270ADE
        MOVE.W  (A7)+,-$60(A7,D7.L)             ; $270AE4
        MOVEQ   #-$58,D6                        ; $270AE8
        MOVEQ   #-$54,D6                        ; $270AEA
        MOVEQ   #-$57,D7                        ; $270AEC
        OR.L   -$7F5A(A0),D0                    ; $270AEE
        MOVE.W  (A6)+,-$73(A7,A0.W)             ; $270AF2
        OR.W   $6B(PC,A0.W),D1                  ; $270AF6
        OR.W   D0,-(A1)                         ; $270AFA
        OR.W   D0,(A5)                          ; $270AFC
        OR.W   D3,D1                            ; $270AFE
        OR.B   D1,$2F(A1,A0.W)                  ; $270B00
        OR.B   $35(A7,D7.L),D0                  ; $270B04
        MOVE.W  -$7FE0(A3),-(A7)                ; $270B08
        MOVE.W  (A4)+,-(A7)                     ; $270B0C
        MOVEQ   #$1A,D7                         ; $270B0E
        MOVEQ   #$19,D7                         ; $270B10
        MOVE.W  (A1)+,-(A7)                     ; $270B12
        MOVE.W  (A3)+,-(A7)                     ; $270B14
        MOVE.W  (A4)+,-(A7)                     ; $270B16
        MOVEQ   #$1D,D7                         ; $270B18
        MOVE.W  (A7)+,-(A6)                     ; $270B1A
        MOVEQ   #$22,D7                         ; $270B1C
        MOVE.W  $7C35(A1),-(A6)                 ; $270B1E
        MOVEQ   #$45,D6                         ; $270B22
        MOVE.W  (A6),$7B67(A5)                  ; $270B24
        MOVE.W  -$73(PC,D7.L),$7C99(A5)         ; $270B28
        MOVE.W  -(A0),-$5E(A6,D7.L)             ; $270B2E
        MOVE.W  -(A2),-$5E(A6,D7.L)             ; $270B32
        MOVE.W  (A5)+,-$74(A7,A0.W)             ; $270B36
        OR.W   $55(A0,A0.W),D2                  ; $270B3A
        OR.B   D3,$882D8827                     ; $270B3E
        OR.B   D4,-(A5)                         ; $270B44
        OR.B   -(A5),D4                         ; $270B46
        OR.B   D3,-(A6)                         ; $270B48
        OR.B   -$7DBD(A5),D2                    ; $270B4A
        OR.W   D0,(A1)+                         ; $270B4E
        OR.W   -$76(A0,D7.L),D0                 ; $270B50
        MOVEQ   #-$5F,D7                        ; $270B54
        MOVE.W  -$40(A1,D7.L),-$2F(A6,D7.L)     ; $270B56
        DC.W    $7BDF               ; $270B5C MOVE.W  (A7)+,<EA:3D>
        MOVEQ   #-$1D,D5                        ; $270B5E
        MOVEQ   #-$1C,D5                        ; $270B60
        MOVEQ   #-$1B,D6                        ; $270B62
        MOVEQ   #-$1C,D6                        ; $270B64
        DC.W    $7DE2               ; $270B66 MOVE.W  -(A2),<EA:3E>
        DC.W    $7DE1               ; $270B68 MOVE.W  -(A1),<EA:3E>
        MOVEQ   #-$21,D6                        ; $270B6A
        MOVEQ   #-$22,D6                        ; $270B6C
        DC.W    $7DDC               ; $270B6E MOVE.W  (A4)+,<EA:3E>
        MOVEQ   #-$29,D7                        ; $270B70
        DC.W    $7DD3               ; $270B72 MOVE.W  (A3),<EA:3E>
        DC.W    $7DD0               ; $270B74 MOVE.W  (A0),<EA:3E>
        MOVEQ   #-$33,D7                        ; $270B76
        MOVEQ   #-$33,D7                        ; $270B78
        MOVEQ   #-$2F,D7                        ; $270B7A
        MOVEQ   #-$2D,D7                        ; $270B7C
        DC.W    $7DD3               ; $270B7E MOVE.W  (A3),<EA:3E>
        MOVEQ   #-$2D,D6                        ; $270B80
        MOVEQ   #-$2E,D6                        ; $270B82
        MOVEQ   #-$30,D6                        ; $270B84
        MOVEQ   #-$3C,D7                        ; $270B86
        MOVE.W  -$7F6A(A5),$7E(A7,A0.W)         ; $270B88
        OR.W   -(A6),D0                         ; $270B8E
        OR.W   (A3),D0                          ; $270B90
        DC.W    $803E               ; $270B92 OR.B   <EA:3E>,D0
        OR.B   -$7FE5(A2),D0                    ; $270B94
        OR.B   D0,(A6)                          ; $270B98
        OR.B   (A4),D1                          ; $270B9A
        OR.B   D1,(A3)                          ; $270B9C
        OR.B   (A4),D1                          ; $270B9E
        OR.B   D0,(A6)                          ; $270BA0
        MOVE.W  (A7),-(A7)                      ; $270BA2
        MOVEQ   #$19,D7                         ; $270BA4
        MOVEQ   #$1A,D7                         ; $270BA6
        MOVEQ   #$1F,D7                         ; $270BA8
        MOVEQ   #$26,D7                         ; $270BAA
        MOVE.W  $7E34(A6),-(A7)                 ; $270BAC
        MOVEQ   #$3D,D7                         ; $270BB0
        MOVE.W  D5,$7C50(A6)                    ; $270BB2
        MOVE.W  (A5)+,$7B65(A5)                 ; $270BB6
        MOVEQ   #$6F,D6                         ; $270BBA
        MOVE.W  -$78(PC,D7.L),$7D92(A6)         ; $270BBC
        MOVE.W  (A7),-$6C(A6,D7.L)              ; $270BC2
        OR.L   A2,D0                            ; $270BC6
        OR.W   $84608546,D1                     ; $270BC8
        OR.B   $2A(A3,A0.W),D3                  ; $270BCE
        OR.B   D2,-(A6)                         ; $270BD2
        OR.B   D3,-(A5)                         ; $270BD4
        OR.B   D3,-(A6)                         ; $270BD6
        OR.B   -$7BC1(A2),D3                    ; $270BD8
        OR.W   -(A0),D1                         ; $270BDC
        DC.W    $817E               ; $270BDE OR.W   D0,<EA:3E>
        OR.L   D0,(A5)                          ; $270BE0
        OR.L   $7FC4(A6),D0                     ; $270BE2
        DC.W    $7DD7               ; $270BE6 MOVE.W  (A7),<EA:3E>
        MOVEQ   #-$1F,D6                        ; $270BE8
        MOVEQ   #-$1C,D5                        ; $270BEA
        MOVEQ   #-$1B,D5                        ; $270BEC
        MOVE.W  -(A4),#$7AE3                    ; $270BEE
        DC.W    $7BE1               ; $270BF2 MOVE.W  -(A1),<EA:3D>
        MOVEQ   #-$24,D6                        ; $270BF4
        MOVEQ   #-$2C,D6                        ; $270BF6
        DC.W    $7DCD               ; $270BF8 MOVE.W  A5,<EA:3E>
        DC.W    $7DC6               ; $270BFA MOVE.W  D6,<EA:3E>
        MOVE.W  #$7EB0,-$5D(A6,D7.L)            ; $270BFC
        OR.L   (A0)+,D0                         ; $270C02
        OR.L   (A5),D0                          ; $270C04
        MOVE.W  -(A3),-$48(A7,D7.L)             ; $270C06
        DC.W    $7DC7               ; $270C0A MOVE.W  D7,<EA:3E>
        MOVEQ   #-$32,D7                        ; $270C0C
        DC.W    $7FCC               ; $270C0E MOVE.W  A4,<EA:3F>
        DIVU    D5,D0                           ; $270C10
        MOVE.W  -$50(PC,D7.L),-$61(A7,D7.L)     ; $270C12
        MOVE.W  A4,$7A(A7,A0.W)                 ; $270C18
        OR.W   -$7EA2(A4),D0                    ; $270C1C
        OR.W   D0,(A4)                          ; $270C20
        OR.W   A4,D1                            ; $270C22
        DC.W    $823F               ; $270C24 OR.B   <EA:3F>,D1
        OR.B   -$7EE2(A4),D1                    ; $270C26
        OR.B   (A3)+,D0                         ; $270C2A
        MOVEQ   #$19,D7                         ; $270C2C
        MOVEQ   #$18,D7                         ; $270C2E
        MOVE.W  (A2)+,-(A6)                     ; $270C30
        MOVEQ   #$1C,D7                         ; $270C32
        MOVEQ   #$25,D7                         ; $270C34
        MOVE.W  $45(A7,D7.L),-(A6)              ; $270C36
        MOVE.W  A5,$7C52(A5)                    ; $270C3A
        MOVE.W  (A3)+,$7C60(A5)                 ; $270C3E
        MOVE.W  (A6)+,$7F60(A6)                 ; $270C42
        OR.W   -$7F8C(A1),D0                    ; $270C46
        OR.W   $7F(PC,A0.W),D0                  ; $270C4A
        OR.L   D0,A1                            ; $270C4E
        OR.L   (A0),D0                          ; $270C50
        OR.L   D7,D0                            ; $270C52
        OR.W   -$7AB3(A7),D1                    ; $270C54
        OR.B   $2C(A4,A0.W),D3                  ; $270C58
        OR.B   D3,-(A7)                         ; $270C5C
        OR.B   -(A4),D3                         ; $270C5E
        OR.B   -(A5),D2                         ; $270C60
        OR.B   D0,$7E35(A0)                     ; $270C62
        MOVEQ   #$48,D7                         ; $270C66
        MOVEQ   #$5C,D7                         ; $270C68
        MOVE.W  $7F83(A6),$7E9C(A7)             ; $270C6A
        MOVE.W  -$41(A2,D7.L),-$3E(A6,D7.L)     ; $270C70
        DC.W    $7BC4               ; $270C76 MOVE.W  D4,<EA:3D>
        DC.W    $7BC4               ; $270C78 MOVE.W  D4,<EA:3D>
        MOVEQ   #-$3F,D6                        ; $270C7A
        MOVEQ   #-$45,D6                        ; $270C7C
        MOVEQ   #-$49,D6                        ; $270C7E
        MOVE.W  $7E9F(A7),-$73(A6,D7.L)         ; $270C80
        MOVE.W  D1,$7F(A7,D7.L)                 ; $270C86
        MOVE.W  D1,-$78(A7,A0.W)                ; $270C8A
        OR.L   (A1),D1                          ; $270C8E
        OR.L   D1,(A1)+                         ; $270C90
        OR.L   D1,-(A1)                         ; $270C92
        OR.L   D1,-$7E49(A0)                    ; $270C94
        DIVU    A1,D0                           ; $270C98
        MOVEQ   #-$2A,D7                        ; $270C9A
        MOVEQ   #-$26,D7                        ; $270C9C
        DC.W    $7FDB               ; $270C9E MOVE.W  (A3)+,<EA:3F>
        DIVU    (A1)+,D0                        ; $270CA0
        DIVU    (A5),D0                         ; $270CA2
        DIVU    A1,D0                           ; $270CA4
        OR.L   -$59(A7,D7.L),D0                 ; $270CA6
        MOVEQ   #-$66,D7                        ; $270CAA
        MOVE.W  D7,$75(A6,D7.L)                 ; $270CAC
        MOVE.W  -(A5),$7D59(A6)                 ; $270CB0
        MOVEQ   #$51,D6                         ; $270CB4
        MOVEQ   #$44,D6                         ; $270CB6
        MOVE.W  $2B(A4,D7.L),-(A6)              ; $270CB8
        MOVE.W  $7E32(A4),-(A7)                 ; $270CBC
        MOVEQ   #$3C,D7                         ; $270CC0
        MOVEQ   #$4C,D7                         ; $270CC2
        MOVE.W  (A4)+,$7D6C(A6)                 ; $270CC4
        DC.W    $7D79,$7D84,$7D8D,$7D90; $270CC8 MOVE.W  $7D847D8D,$7D90(A6)
        MOVEQ   #-$73,D7                        ; $270CD0
        MOVE.W  A1,-$7C(A7,A0.W)                ; $270CD2
        OR.L   D0,D0                            ; $270CD6
        DC.W    $807F               ; $270CD8 OR.W   <EA:3F>,D0
        MOVE.W  D0,$7E(A7,A0.W)                 ; $270CDA
        OR.W   D0,$69(A6,A0.W)                  ; $270CDE
        OR.W   (A0)+,D2                         ; $270CE2
        OR.W   D2,A1                            ; $270CE4
        OR.B   #$8634,D3                        ; $270CE6
        OR.B   $34(A1,A0.W),D3                  ; $270CEA
        OR.B   D1,$38(A6,A0.W)                  ; $270CEE
        MOVE.W  D6,$7D5B(A7)                    ; $270CF2
        MOVE.W  -$76(A3,D7.L),$7B9F(A5)         ; $270CF6
        MOVEQ   #-$54,D6                        ; $270CFC
        MOVE.W  -$42(A6,D7.L),-$41(A5,D7.L)     ; $270CFE
        MOVEQ   #-$46,D5                        ; $270D04
        MOVE.W  -$51(A4,D7.L),-$5B(A5,D7.L)     ; $270D06
        MOVE.W  (A6),-$7A(A6,A0.W)              ; $270D0C
        DC.W    $817E               ; $270D10 OR.W   D0,<EA:3E>
        OR.W   D0,$8170816A                     ; $270D12
        OR.W   -$7D97(A0),D1                    ; $270D18
        OR.W   -$7E(A3,A0.W),D1                 ; $270D1C
        OR.L   (A2),D0                          ; $270D20
        MOVE.W  -(A5),-$4A(A7,D7.L)             ; $270D22
        MOVEQ   #-$3F,D7                        ; $270D26
        DC.W    $7FC3               ; $270D28 MOVE.W  D3,<EA:3F>
        DC.W    $80BF               ; $270D2A OR.L   <EA:3F>,D0
        MOVE.W  -$57(A5,D7.L),-$61(A7,D7.L)     ; $270D2C
        MOVE.W  (A4)+,-$62(A6,D7.L)             ; $270D32
        MOVE.W  (A5)+,-$63(A5,D7.L)             ; $270D36
        MOVE.W  (A4)+,-$71(A4,D7.L)             ; $270D3A
        MOVE.W  $68(PC,D7.L),$7E59(A5)          ; $270D3E
        MOVEQ   #$50,D7                         ; $270D44
        MOVEQ   #$4A,D7                         ; $270D46
        MOVEQ   #$48,D7                         ; $270D48
        MOVE.W  D3,-$7FC2(A7)                   ; $270D4A
        OR.W   D2,D0                            ; $270D4E
        MOVE.W  A0,$7E4D(A7)                    ; $270D50
        MOVEQ   #$54,D7                         ; $270D54
        MOVEQ   #$57,D7                         ; $270D56
        MOVEQ   #$59,D7                         ; $270D58
        MOVE.W  (A3)+,$7D5D(A6)                 ; $270D5A
        MOVEQ   #$5D,D7                         ; $270D5E
        OR.W   (A5)+,D0                         ; $270D60
        OR.W   D0,(A4)+                         ; $270D62
        OR.W   D0,(A1)+                         ; $270D64
        OR.W   D0,(A2)                          ; $270D66
        OR.W   D3,D1                            ; $270D68
        OR.B   D1,$2B(A3,A0.W)                  ; $270D6A
        OR.B   -$79D9(A0),D2                    ; $270D6E
        OR.B   D3,-(A7)                         ; $270D72
        OR.B   -$78D7(A0),D4                    ; $270D74
        OR.B   -$7CD0(A3),D3                    ; $270D78
        OR.W   D0,D0                            ; $270D7C
        MOVEQ   #$50,D7                         ; $270D7E
        MOVE.W  (A3)+,$7D66(A6)                 ; $270D80
        MOVEQ   #$78,D6                         ; $270D84
        MOVEQ   #-$73,D5                        ; $270D86
        MOVEQ   #-$5D,D4                        ; $270D88
        MOVE.W  $7AB8(A7),-$3E(A4,D7.L)         ; $270D8A
        DC.W    $7BCE               ; $270D90 MOVE.W  A6,<EA:3D>
        DC.W    $7BDA               ; $270D92 MOVE.W  (A2)+,<EA:3D>
        MOVEQ   #-$23,D6                        ; $270D94
        MOVEQ   #-$26,D6                        ; $270D96
        DC.W    $7DD6               ; $270D98 MOVE.W  (A6),<EA:3E>
        DC.W    $7DCD               ; $270D9A MOVE.W  A5,<EA:3E>
        MOVEQ   #-$38,D7                        ; $270D9C
        DC.W    $7FC7               ; $270D9E MOVE.W  D7,<EA:3F>
        DC.W    $7FC6               ; $270DA0 MOVE.W  D6,<EA:3F>
        DIVU    D2,D0                           ; $270DA2
        DC.W    $80BD               ; $270DA4 OR.L   <EA:3D>,D0
        DC.W    $7FBF,$7EC6         ; $270DA6 MOVE.W  <EA:3F>,-$3A(A7,D7.L)
        MOVEQ   #-$34,D7                        ; $270DAA
        DC.W    $7FD0               ; $270DAC MOVE.W  (A0),<EA:3F>
        DIVU    A6,D0                           ; $270DAE
        DIVU    A4,D0                           ; $270DB0
        DIVU    A6,D0                           ; $270DB2
        DC.W    $7FD3               ; $270DB4 MOVE.W  (A3),<EA:3F>
        MOVEQ   #-$2A,D7                        ; $270DB6
        MOVEQ   #-$29,D7                        ; $270DB8
        DC.W    $7DD7               ; $270DBA MOVE.W  (A7),<EA:3E>
        MOVEQ   #-$2A,D6                        ; $270DBC
        DC.W    $7BD5               ; $270DBE MOVE.W  (A5),<EA:3D>
        DC.W    $7BD3               ; $270DC0 MOVE.W  (A3),<EA:3D>
        DC.W    $7BC9               ; $270DC2 MOVE.W  A1,<EA:3D>
        MOVEQ   #-$48,D6                        ; $270DC4
        MOVEQ   #-$64,D7                        ; $270DC6
        OR.L   D0,D0                            ; $270DC8
        OR.W   -$7FAE(A0),D0                    ; $270DCA
        OR.W   D2,D0                            ; $270DCE
        MOVE.W  $7F31(PC),-(A7)                 ; $270DD0
        MOVEQ   #$2B,D7                         ; $270DD4
        MOVE.W  $7E2E(A2),-(A7)                 ; $270DD6
        MOVE.W  -$7FD7(A5),-(A7)                ; $270DDA
        OR.B   D0,-$7EC8(A5)                    ; $270DDE
        OR.W   D1,D0                            ; $270DE2
        MOVE.W  D3,$7F46(A7)                    ; $270DE4
        MOVE.W  A1,$7E4A(A7)                    ; $270DE8
        MOVE.W  D7,-$7FBD(A7)                   ; $270DEC
        OR.W   D0,D0                            ; $270DF0
        OR.B   D0,-$7ECD(PC)                    ; $270DF2
        OR.B   -$7CD7(A7),D1                    ; $270DF6
        OR.B   D1,-(A6)                         ; $270DFA
        OR.B   -(A6),D2                         ; $270DFC
        OR.B   D1,-$7ECC(A1)                    ; $270DFE
        DC.W    $803F               ; $270E02 OR.B   <EA:3F>,D0
        OR.W   D5,D0                            ; $270E04
        OR.W   A4,D0                            ; $270E06
        OR.W   (A4),D0                          ; $270E08
        MOVE.W  (A1)+,$7F5D(A7)                 ; $270E0A
        MOVEQ   #$61,D7                         ; $270E0E
        MOVE.W  $7B7E(A4),$7A91(A6)             ; $270E10
        MOVE.W  (A7)+,-$5A(A4,D7.L)             ; $270E16
        MOVEQ   #-$52,D6                        ; $270E1A
        MOVEQ   #-$47,D6                        ; $270E1C
        MOVEQ   #-$40,D6                        ; $270E1E
        MOVEQ   #-$3D,D6                        ; $270E20
        DC.W    $7DC0               ; $270E22 MOVE.W  D0,<EA:3E>
        MOVEQ   #-$47,D7                        ; $270E24
        MOVE.W  -$55(A0,D7.L),-$5C(A7,A0.W)     ; $270E26
        OR.L   D1,(A0)+                         ; $270E2C
        OR.L   D1,A5                            ; $270E2E
        OR.L   D1,A4                            ; $270E30
        OR.L   (A1),D1                          ; $270E32
        OR.L   D0,(A2)+                         ; $270E34
        OR.L   D0,-(A1)                         ; $270E36
        OR.L   D0,-(A7)                         ; $270E38
        OR.L   D0,-$7F4F(A3)                    ; $270E3A
        DC.W    $7FC0               ; $270E3E MOVE.W  D0,<EA:3F>
        DC.W    $7DD1               ; $270E40 MOVE.W  (A1),<EA:3E>
        DC.W    $7BD9               ; $270E42 MOVE.W  (A1)+,<EA:3D>
        DC.W    $7BDB               ; $270E44 MOVE.W  (A3)+,<EA:3D>
        MOVEQ   #-$23,D5                        ; $270E46
        MOVE.W  (A5)+,#$7ADC                    ; $270E48
        MOVEQ   #-$26,D6                        ; $270E4C
        MOVEQ   #-$27,D6                        ; $270E4E
        DC.W    $7BD5               ; $270E50 MOVE.W  (A5),<EA:3D>
        DC.W    $7BC8               ; $270E52 MOVE.W  A0,<EA:3D>
        MOVEQ   #-$4D,D6                        ; $270E54
        MOVE.W  (A3)+,-$79(A7,A0.W)             ; $270E56
        OR.W   $8063.W,D0                       ; $270E5A
        OR.W   D0,A5                            ; $270E5E
        DC.W    $823D               ; $270E60 OR.B   <EA:3D>,D1
        OR.B   D0,$3A(A6,D7.L)                  ; $270E62
        OR.B   $35(PC,A0.W),D0                  ; $270E66
        OR.B   D0,$37(A4,A0.W)                  ; $270E6A
        MOVE.W  $34(A7,D7.L),-(A7)              ; $270E6E
        MOVE.W  $2F(A2,D7.L),-(A7)              ; $270E72
        MOVE.W  $7F32(A6),-(A7)                 ; $270E76
        MOVE.W  $29(A0,D7.L),-(A7)              ; $270E7A
        OR.B   -(A5),D0                         ; $270E7E
        OR.B   D0,-(A5)                         ; $270E80
        OR.B   -(A5),D1                         ; $270E82
        OR.B   D1,-(A5)                         ; $270E84
        OR.B   D1,-(A6)                         ; $270E86
        OR.B   D1,-(A7)                         ; $270E88
        OR.B   D1,-$7ED6(A1)                    ; $270E8A
        OR.B   $4B(A2,D7.L),D0                  ; $270E8E
        MOVEQ   #$65,D6                         ; $270E92
        MOVEQ   #$7A,D6                         ; $270E94
        MOVEQ   #-$7A,D6                        ; $270E96
        MOVEQ   #-$70,D6                        ; $270E98
        MOVEQ   #-$65,D6                        ; $270E9A
        MOVEQ   #-$54,D5                        ; $270E9C
        DC.W    $79BE,$79CA         ; $270E9E MOVE.W  <EA:3E>,-$36(A4,D7.L)
        MOVE.W  (A6),#$79DF                     ; $270EA2
        DC.W    $7BDF               ; $270EA6 MOVE.W  (A7)+,<EA:3D>
        MOVEQ   #-$28,D6                        ; $270EA8
        MOVEQ   #-$30,D6                        ; $270EAA
        DC.W    $7DC2               ; $270EAC MOVE.W  D2,<EA:3E>
        MOVEQ   #-$4D,D7                        ; $270EAE
        OR.L   -$7E5E(A1),D0                    ; $270EB0
        OR.L   (A3)+,D1                         ; $270EB4
        OR.L   D1,A6                            ; $270EB6
        DC.W    $847F               ; $270EB8 OR.W   <EA:3F>,D2
        DC.W    $847E               ; $270EBA OR.W   <EA:3E>,D2
        OR.L   D2,D2                            ; $270EBC
        OR.W   #$8570,D2                        ; $270EBE
        OR.W   -$7A91(A2),D3                    ; $270EC2
        DC.W    $827E               ; $270EC6 OR.W   <EA:3E>,D1
        OR.L   A6,D0                            ; $270EC8
        OR.L   (A6)+,D0                         ; $270ECA
        MOVE.W  $7CC0(A7),-$33(A7,D7.L)         ; $270ECC
        MOVEQ   #-$29,D5                        ; $270ED2
        MOVE.W  (A3)+,#$7ADC                    ; $270ED4
        MOVEQ   #-$26,D5                        ; $270ED8
        DC.W    $7BD5               ; $270EDA MOVE.W  (A5),<EA:3D>
        MOVEQ   #-$33,D6                        ; $270EDC
        MOVEQ   #-$3E,D6                        ; $270EDE
        MOVE.W  -$5C(A3,D7.L),-$6F(A6,D7.L)     ; $270EE0
        DC.W    $7F79,$815F,$8245,$8331; $270EE6 MOVE.W  $815F8245,-$7CCF(A7)
        OR.B   -$7FD4(A1),D1                    ; $270EEE
        DC.W    $7F3D               ; $270EF2 MOVE.W  <EA:3D>,-(A7)
        MOVE.W  A3,$7F57(A7)                    ; $270EF4
        MOVE.W  (A6)+,$7F63(A7)                 ; $270EF8
        MOVEQ   #$6D,D7                         ; $270EFC
        DC.W    $7D79,$7C7D,$7D77,$7F69; $270EFE MOVE.W  $7C7D7D77,$7F69(A6)
        MOVE.W  (A2)+,$7F4B(A7)                 ; $270F06
        DC.W    $803D               ; $270F0A OR.B   <EA:3D>,D0
        OR.B   -$7EDA(A7),D0                    ; $270F0C
        OR.B   -(A3),D1                         ; $270F10
        OR.B   D1,-(A2)                         ; $270F12
        OR.B   D1,-(A2)                         ; $270F14
        OR.B   -(A5),D1                         ; $270F16
        OR.B   D0,$42(A0,A0.W)                  ; $270F18
        OR.W   (A4)+,D0                         ; $270F1C
        MOVE.W  $7D97(PC),$7DAD(A7)             ; $270F1E
        MOVEQ   #-$42,D6                        ; $270F24
        MOVEQ   #-$36,D6                        ; $270F26
        DC.W    $7BCB               ; $270F28 MOVE.W  A3,<EA:3D>
        MOVEQ   #-$3E,D5                        ; $270F2A
        MOVE.W  -$6A(A0,D7.L),$7C(A5,D7.L)      ; $270F2C
        MOVE.W  $7D67(A2),$7E68(A6)             ; $270F32
        MOVE.W  $7F72(A3),-$7F84(A7)            ; $270F38
        DC.W    $807F               ; $270F3E OR.W   <EA:3F>,D0
        OR.W   D0,$74(PC,A0.W)                  ; $270F40
        OR.W   D1,-$7B9A(A2)                    ; $270F44
        OR.W   D1,-$7C89(A3)                    ; $270F48
        DC.W    $827F               ; $270F4C OR.W   <EA:3F>,D1
        OR.L   D4,D1                            ; $270F4E
        OR.L   D0,A1                            ; $270F50
        OR.L   A6,D0                            ; $270F52
        MOVE.W  (A6),-$5F(A7,D7.L)              ; $270F54
        MOVEQ   #-$54,D7                        ; $270F58
        MOVEQ   #-$4B,D7                        ; $270F5A
        MOVEQ   #-$42,D7                        ; $270F5C
        DC.W    $7DCC               ; $270F5E MOVE.W  A4,<EA:3E>
        MOVEQ   #-$28,D6                        ; $270F60
        DC.W    $7BDB               ; $270F62 MOVE.W  (A3)+,<EA:3D>
        DC.W    $7BDC               ; $270F64 MOVE.W  (A4)+,<EA:3D>
        DC.W    $7BDD               ; $270F66 MOVE.W  (A5)+,<EA:3D>
        DC.W    $7BDC               ; $270F68 MOVE.W  (A4)+,<EA:3D>
        DC.W    $7BDA               ; $270F6A MOVE.W  (A2)+,<EA:3D>
        MOVEQ   #-$29,D6                        ; $270F6C
        MOVEQ   #-$3A,D7                        ; $270F6E
        OR.L   -$7F6D(A3),D0                    ; $270F70
        OR.W   D0,#$816E                        ; $270F74
        OR.W   D0,-$7F99(A2)                    ; $270F78
        OR.W   (A6)+,D0                         ; $270F7C
        OR.W   D0,(A6)                          ; $270F7E
        OR.W   D0,(A6)                          ; $270F80
        OR.W   (A4)+,D0                         ; $270F82
        MOVEQ   #$5F,D7                         ; $270F84
        MOVEQ   #$5D,D7                         ; $270F86
        MOVEQ   #$56,D7                         ; $270F88
        MOVEQ   #$4A,D7                         ; $270F8A
        MOVEQ   #$3B,D7                         ; $270F8C
        MOVEQ   #$2C,D7                         ; $270F8E
        MOVE.W  -(A3),-(A7)                     ; $270F90
        MOVE.W  -(A0),-(A7)                     ; $270F92
        OR.B   (A6)+,D0                         ; $270F94
        OR.B   (A6)+,D1                         ; $270F96
        OR.B   -(A0),D1                         ; $270F98
        OR.B   -(A1),D1                         ; $270F9A
        OR.B   -(A2),D0                         ; $270F9C
        OR.B   -(A4),D0                         ; $270F9E
        OR.B   -(A5),D1                         ; $270FA0
        OR.B   D1,-(A6)                         ; $270FA2
        OR.B   -$7ED3(A0),D1                    ; $270FA4
        OR.W   D6,D0                            ; $270FA8
        MOVE.W  -(A7),$7E80(A7)                 ; $270FAA
        MOVEQ   #-$6F,D7                        ; $270FAE
        MOVEQ   #-$65,D7                        ; $270FB0
        MOVE.W  (A7)+,-$5C(A7,A0.W)             ; $270FB2
        MOVE.W  $7EAA(A2),-$5D(A7,D7.L)         ; $270FB6
        MOVEQ   #-$66,D7                        ; $270FBC
        MOVE.W  (A4),-$6C(A6,D7.L)              ; $270FBE
        MOVE.W  (A5),-$6B(A5,D7.L)              ; $270FC2
        MOVEQ   #-$67,D6                        ; $270FC6
        MOVE.W  -(A5),-$4B(A6,D7.L)             ; $270FC8
        DC.W    $7DC6               ; $270FCC MOVE.W  D6,<EA:3E>
        MOVEQ   #-$35,D7                        ; $270FCE
        DC.W    $7FC9               ; $270FD0 MOVE.W  A1,<EA:3F>
        DC.W    $7FC7               ; $270FD2 MOVE.W  D7,<EA:3F>
        DIVU    D4,D0                           ; $270FD4
        DC.W    $80BF               ; $270FD6 OR.L   <EA:3F>,D0
        OR.L   D0,$82AF.W                       ; $270FD8
        OR.L   -$7E58(A3),D1                    ; $270FDC
        OR.L   -(A5),D0                         ; $270FE0
        OR.L   -(A3),D0                         ; $270FE2
        OR.L   $7FAF(A0),D0                     ; $270FE4
        MOVE.W  -$46(A4,A0.W),-$3E(A7,A0.W)     ; $270FE8
        DIVS    D7,D0                           ; $270FEE
        DIVU    D6,D0                           ; $270FF0
        DIVU    D4,D0                           ; $270FF2
        DC.W    $7FC1               ; $270FF4 MOVE.W  D1,<EA:3F>
        DC.W    $7FC2               ; $270FF6 MOVE.W  D2,<EA:3F>
        MOVEQ   #-$3A,D7                        ; $270FF8
        MOVEQ   #-$38,D7                        ; $270FFA
        MOVEQ   #-$38,D7                        ; $270FFC
        MOVEQ   #-$3B,D7                        ; $270FFE
        DC.W    $7FBF,$7FB3         ; $271000 MOVE.W  <EA:3F>,-$4D(A7,D7.L)
        OR.L   (A3)+,D0                         ; $271004
        OR.L   D0,D0                            ; $271006
        OR.W   $7F5D(A3),D0                     ; $271008
        MOVEQ   #$57,D7                         ; $27100C
        MOVEQ   #$56,D7                         ; $27100E
        MOVE.W  (A1)+,$7B5B(A6)                 ; $271010
        MOVE.W  (A6),$7C4F(A5)                  ; $271014
        MOVEQ   #$45,D6                         ; $271018
        MOVEQ   #$38,D6                         ; $27101A
        MOVE.W  $7D24(A2),-(A6)                 ; $27101C
        MOVE.W  (A6)+,-(A6)                     ; $271020
        MOVE.W  (A1)+,-(A6)                     ; $271022
        MOVE.W  (A0)+,-(A7)                     ; $271024
        OR.B   (A0)+,D0                         ; $271026
        OR.B   D0,(A1)+                         ; $271028
        OR.B   D0,(A2)+                         ; $27102A
        OR.B   (A4)+,D1                         ; $27102C
        OR.B   D1,(A5)+                         ; $27102E
        OR.B   D2,(A6)+                         ; $271030
        OR.B   D2,-(A0)                         ; $271032
        OR.B   -(A1),D2                         ; $271034
        OR.B   -(A2),D2                         ; $271036
        OR.B   D1,-(A7)                         ; $271038
        OR.B   $42(A3,A0.W),D1                  ; $27103A
        MOVE.W  (A4),$7F62(A7)                  ; $27103E
        MOVE.W  $7F6F(A1),$7E76(A7)             ; $271042
        DC.W    $7D79,$7D7A,$7D7F,$7D8B; $271048 MOVE.W  $7D7A7D7F,$7D8B(A6)
        MOVEQ   #-$66,D6                        ; $271050
        MOVEQ   #-$5B,D6                        ; $271052
        MOVEQ   #-$53,D6                        ; $271054
        MOVE.W  $7DC5.W,-$31(A6,D7.L)           ; $271056
        DC.W    $7FD4               ; $27105C MOVE.W  (A4),<EA:3F>
        DIVU    (A3)+,D0                        ; $27105E
        DIVU    (A7)+,D0                        ; $271060
        DC.W    $7FDF               ; $271062 MOVE.W  (A7)+,<EA:3F>
        DIVU    (A5)+,D0                        ; $271064
        DIVS    (A2),D0                         ; $271066
        DC.W    $82BF               ; $271068 OR.L   <EA:3F>,D1
        OR.L   -$54(A3,A0.W),D1                 ; $27106A
        OR.L   D0,-(A5)                         ; $27106E
        OR.L   D0,(A7)+                         ; $271070
        OR.L   D0,-(A1)                         ; $271072
        OR.L   $7FAE(A0),D0                     ; $271074
        MOVE.W  -$41(A4,D7.L),-$34(A7,D7.L)     ; $271078
        DC.W    $7DD1               ; $27107E MOVE.W  (A1),<EA:3E>
        DC.W    $7DD3               ; $271080 MOVE.W  (A3),<EA:3E>
        DC.W    $7DD3               ; $271082 MOVE.W  (A3),<EA:3E>
        DC.W    $7DD2               ; $271084 MOVE.W  (A2),<EA:3E>
        MOVEQ   #-$31,D6                        ; $271086
        DC.W    $7BC5               ; $271088 MOVE.W  D5,<EA:3D>
        MOVE.W  -$5C(A5,D7.L),-$6C(A5,D7.L)     ; $27108A
        MOVE.W  D5,$70(A6,D7.L)                 ; $271090
        OR.W   (A6)+,D0                         ; $271094
        OR.W   (A5),D0                          ; $271096
        MOVE.W  (A4),$7D4F(A7)                  ; $271098
        MOVEQ   #$4B,D6                         ; $27109C
        MOVE.W  (A2),$7A59(A5)                  ; $27109E
        MOVEQ   #$52,D5                         ; $2710A2
        MOVEQ   #$40,D6                         ; $2710A4
        MOVEQ   #$2E,D7                         ; $2710A6
        MOVE.W  -(A0),-(A7)                     ; $2710A8
        MOVEQ   #$1A,D7                         ; $2710AA
        MOVE.W  (A7),-(A7)                      ; $2710AC
        OR.B   D0,(A6)                          ; $2710AE
        OR.B   D1,(A7)                          ; $2710B0
        OR.B   D1,(A0)+                         ; $2710B2
        OR.B   (A2)+,D1                         ; $2710B4
        OR.B   (A3)+,D2                         ; $2710B6
        OR.B   (A5)+,D3                         ; $2710B8
        OR.B   (A6)+,D3                         ; $2710BA
        OR.B   (A7)+,D2                         ; $2710BC
        OR.B   -(A1),D1                         ; $2710BE
        OR.B   -$7EC1(A1),D1                    ; $2710C0
        OR.W   (A1)+,D0                         ; $2710C4
        MOVE.W  -$75(A2,D7.L),$7C9B(A7)         ; $2710C6
        MOVE.W  -(A4),-$51(A5,D7.L)             ; $2710CC
        MOVE.W  -$3D(PC,D7.L),-$3B(A4,D7.L)     ; $2710D0
        DC.W    $79BF,$7BB7         ; $2710D6 MOVE.W  <EA:3F>,-$49(A4,D7.L)
        MOVE.W  $7EAB(A7),-$54(A6,D7.L)         ; $2710DA
        MOVEQ   #-$51,D7                        ; $2710E0
        MOVE.W  -$7E59(A6),-$5C(A7,A0.W)        ; $2710E2
        OR.L   D0,-$7F49(A3)                    ; $2710E8
        DC.W    $7FC5               ; $2710EC MOVE.W  D5,<EA:3F>
        DIVU    A5,D0                           ; $2710EE
        DIVU    D4,D1                           ; $2710F0
        OR.L   D1,-$61(A2,A0.W)                 ; $2710F2
        OR.L   D1,(A3)                          ; $2710F6
        OR.L   D1,A1                            ; $2710F8
        DC.W    $837F               ; $2710FA OR.W   D1,<EA:3F>
        OR.W   D1,$70(A6,A0.W)                  ; $2710FC
        OR.W   D0,$76(A0,A0.W)                  ; $271100
        MOVEQ   #-$7E,D7                        ; $271104
        MOVEQ   #-$6D,D7                        ; $271106
        MOVE.W  -(A3),-$50(A6,D7.L)             ; $271108
        MOVE.W  #$7BC8,-$32(A5,D7.L)            ; $27110C
        DC.W    $7BCC               ; $271112 MOVE.W  A4,<EA:3D>
        MOVEQ   #-$41,D6                        ; $271114
        MOVEQ   #-$52,D7                        ; $271116
        MOVEQ   #-$5F,D7                        ; $271118
        MOVEQ   #-$67,D7                        ; $27111A
        MOVEQ   #-$6E,D7                        ; $27111C
        MOVEQ   #-$76,D7                        ; $27111E
        MOVEQ   #-$80,D7                        ; $271120
        MOVE.W  $6C(A7,D7.L),$7D5F(A6)          ; $271122
        MOVE.W  (A2),$7B4C(A6)                  ; $271128
        MOVE.W  D7,$7B43(A5)                    ; $27112C
        MOVEQ   #$3F,D6                         ; $271130
        MOVE.W  $36(PC,D7.L),-(A6)              ; $271132
        MOVE.W  $7F1C(A1),-(A7)                 ; $271136
        OR.B   (A1)+,D0                         ; $27113A
        OR.B   D0,(A0)+                         ; $27113C
        OR.B   (A7),D1                          ; $27113E
        OR.B   D2,(A0)+                         ; $271140
        OR.B   (A1)+,D3                         ; $271142
        OR.B   D3,(A2)+                         ; $271144
        OR.B   (A4)+,D3                         ; $271146
        OR.B   (A5)+,D3                         ; $271148
        OR.B   (A6)+,D2                         ; $27114A
        OR.B   -(A0),D1                         ; $27114C
        OR.B   D0,$7F3F(A0)                     ; $27114E
        MOVEQ   #$61,D7                         ; $271152
        MOVEQ   #-$7B,D6                        ; $271154
        MOVEQ   #-$5E,D5                        ; $271156
        MOVEQ   #-$47,D5                        ; $271158
        DC.W    $7BCD               ; $27115A MOVE.W  A5,<EA:3D>
        DC.W    $7BDA               ; $27115C MOVE.W  (A2)+,<EA:3D>
        MOVEQ   #-$23,D5                        ; $27115E
        MOVEQ   #-$23,D5                        ; $271160
        MOVEQ   #-$2C,D6                        ; $271162
        MOVE.W  $7EA5(PC),-$67(A6,D7.L)         ; $271164
        MOVEQ   #-$72,D7                        ; $27116A
        MOVE.W  D6,-$7C(A7,A0.W)                ; $27116C
        MOVE.W  A3,-$68(A7,D7.L)                ; $271170
        MOVEQ   #-$5A,D7                        ; $271174
        MOVEQ   #-$4A,D7                        ; $271176
        DC.W    $7FC5               ; $271178 MOVE.W  D5,<EA:3F>
        DIVS    D3,D0                           ; $27117A
        OR.L   -$5C(A5,A0.W),D1                 ; $27117C
        OR.L   (A2)+,D1                         ; $271180
        OR.L   D0,(A3)                          ; $271182
        OR.L   D0,A1                            ; $271184
        DC.W    $817E               ; $271186 OR.W   D0,<EA:3E>
        OR.W   $70(A5,A0.W),D1                  ; $271188
        OR.W   $70(A0,D7.L),D0                  ; $27118C
        MOVE.W  $74(A1,D7.L),$7D7D(A7)          ; $271190
        MOVEQ   #-$78,D6                        ; $271196
        MOVE.W  (A5),-$5D(A5,D7.L)              ; $271198
        MOVEQ   #-$57,D6                        ; $27119C
        MOVEQ   #-$5A,D6                        ; $27119E
        MOVE.W  (A6)+,-$64(A6,D7.L)             ; $2711A0
        MOVE.W  (A3)+,-$6C(A6,D7.L)             ; $2711A4
        MOVEQ   #-$75,D7                        ; $2711A8
        MOVE.W  D1,$76(A7,D7.L)                 ; $2711AA
        MOVEQ   #$71,D7                         ; $2711AE
        MOVEQ   #$74,D7                         ; $2711B0
        DC.W    $7D79,$7C78,$7D70,$7D6E; $2711B2 MOVE.W  $7C787D70,$7D6E(A6)
        MOVE.W  $7D61(A3),$7D52(A6)             ; $2711BA
        MOVE.W  D6,$7D40(A6)                    ; $2711C0
        MOVEQ   #$36,D7                         ; $2711C4
        MOVE.W  -(A4),-(A7)                     ; $2711C6
        OR.B   D0,(A4)+                         ; $2711C8
        OR.B   D1,(A2)+                         ; $2711CA
        OR.B   (A1)+,D2                         ; $2711CC
        OR.B   (A1)+,D3                         ; $2711CE
        OR.B   D3,(A3)+                         ; $2711D0
        OR.B   D3,(A4)+                         ; $2711D2
        OR.B   (A5)+,D3                         ; $2711D4
        OR.B   D2,(A7)+                         ; $2711D6
        OR.B   D2,-(A1)                         ; $2711D8
        OR.B   D1,-$7FC0(A0)                    ; $2711DA
        MOVE.W  (A7)+,$7B82(A6)                 ; $2711DE
        MOVEQ   #-$61,D5                        ; $2711E2
        MOVE.W  -$40(A4,D7.L),-$3B(A4,D7.L)     ; $2711E4
        MOVE.W  D3,#$7ABD                       ; $2711EA
        MOVE.W  -$45(PC,D7.L),-$4B(A4,D7.L)     ; $2711EE
        MOVE.W  -(A5),-$6C(A5,D7.L)             ; $2711F4
        MOVE.W  D3,$76(A7,A0.W)                 ; $2711F8
        OR.W   $7D(A1,D7.L),D0                  ; $2711FC
        MOVEQ   #-$67,D7                        ; $271200
        DC.W    $7DB9,$7ECC,$80D1,$82D1; $271202 MOVE.W  $7ECC80D1,-$2F(A6,A0.W)
        DIVS    A5,D1                           ; $27120A
        DIVS    D4,D1                           ; $27120C
        DC.W    $83BF               ; $27120E OR.L   D1,<EA:3F>
        DIVS    D0,D1                           ; $271210
        DIVU    D0,D1                           ; $271212
        OR.L   D0,-$5A(A5,A0.W)                 ; $271214
        MOVE.W  (A7)+,-$67(A7,D7.L)             ; $271218
        MOVEQ   #-$71,D7                        ; $27121C
        MOVE.W  D4,$7C(A7,D7.L)                 ; $27121E
        MOVE.W  $7E79(PC),$7D78(A7)             ; $271222
        DC.W    $7D7E,$7E87         ; $271228 MOVE.W  <EA:3E>,$7E87(A6)
        MOVE.W  A7,-$6C(A6,D7.L)                ; $27122C
        MOVEQ   #-$69,D7                        ; $271230
        MOVEQ   #-$6C,D7                        ; $271232
        MOVE.W  A6,-$76(A7,D7.L)                ; $271234
        MOVEQ   #-$74,D7                        ; $271238
        MOVE.W  (A0),-$6C(A6,D7.L)              ; $27123A
        MOVE.W  (A5),-$70(A5,D7.L)              ; $27123E
        MOVE.W  D3,$6F(A5,D7.L)                 ; $271242
        MOVEQ   #$59,D6                         ; $271246
        MOVEQ   #$4B,D6                         ; $271248
        MOVEQ   #$44,D6                         ; $27124A
        MOVEQ   #$3C,D6                         ; $27124C
        MOVE.W  $27(A3,D7.L),-(A6)              ; $27124E
        OR.B   (A3)+,D0                         ; $271252
        OR.B   (A0)+,D1                         ; $271254
        OR.B   (A7),D2                          ; $271256
        OR.B   D2,(A6)                          ; $271258
        OR.B   (A7),D3                          ; $27125A
        OR.B   (A0)+,D3                         ; $27125C
        OR.B   D3,(A2)+                         ; $27125E
        OR.B   (A3)+,D4                         ; $271260
        OR.B   (A4)+,D4                         ; $271262
        OR.B   (A6)+,D3                         ; $271264
        OR.B   -(A1),D1                         ; $271266
        MOVE.W  $53(A2,D7.L),-(A7)              ; $271268
        MOVEQ   #$73,D6                         ; $27126C
        MOVE.W  A7,-$5A(A5,D7.L)                ; $27126E
        MOVE.W  -$49(A3,D7.L),-$49(A6,D7.L)     ; $271272
        MOVEQ   #-$4D,D6                        ; $271278
        MOVE.W  -$51(A0,D7.L),-$56(A5,D7.L)     ; $27127A
        MOVE.W  (A4)+,-$74(A6,D7.L)             ; $271280
        MOVE.W  D0,$7E(A7,D7.L)                 ; $271284
        MOVEQ   #-$7C,D7                        ; $271288
        MOVEQ   #-$71,D7                        ; $27128A
        MOVEQ   #-$64,D7                        ; $27128C
        MOVEQ   #-$55,D7                        ; $27128E
        MOVEQ   #-$4B,D7                        ; $271290
        MOVE.W  $80B7.W,-$4F(A7,A0.W)           ; $271292
        OR.L   D0,-$7F56(A3)                    ; $271298
        OR.L   -$7E5B(A2),D0                    ; $27129C
        OR.L   (A7),D1                          ; $2712A0
        DC.W    $837F               ; $2712A2 OR.W   D1,<EA:3F>
        OR.W   D1,-(A7)                         ; $2712A4
        OR.W   (A4)+,D1                         ; $2712A6
        OR.W   D0,(A5)+                         ; $2712A8
        OR.W   -(A2),D0                         ; $2712AA
        OR.W   -$7F8D(A0),D0                    ; $2712AC
        MOVEQ   #-$7C,D7                        ; $2712B0
        MOVE.W  (A6),-$5C(A6,D7.L)              ; $2712B2
        MOVEQ   #-$56,D7                        ; $2712B6
        MOVE.W  -$7F5A(A3),-$5A(A7,D7.L)        ; $2712B8
        MOVE.W  $7CB5(A5),-$4A(A6,D7.L)         ; $2712BE
        MOVE.W  -$52(A1,D7.L),-$58(A6,D7.L)     ; $2712C4
        MOVEQ   #-$60,D7                        ; $2712CA
        MOVEQ   #-$6C,D7                        ; $2712CC
        MOVEQ   #-$7A,D7                        ; $2712CE
        MOVEQ   #$79,D7                         ; $2712D0
        MOVE.W  $7D66(A4),$7E67(A6)             ; $2712D2
        MOVEQ   #$63,D7                         ; $2712D8
        MOVE.W  (A5),-$7EBE(A7)                 ; $2712DA
        OR.B   $22(A0,A0.W),D1                  ; $2712DE
        OR.B   D1,(A1)+                         ; $2712E2
        OR.B   D2,(A6)                          ; $2712E4
        OR.B   D3,(A6)                          ; $2712E6
        OR.B   (A6),D4                          ; $2712E8
        OR.B   (A7),D3                          ; $2712EA
        OR.B   D1,(A1)+                         ; $2712EC
        OR.B   D0,(A5)+                         ; $2712EE
        MOVE.W  $7E44(A4),-(A7)                 ; $2712F0
        MOVEQ   #$59,D6                         ; $2712F4
        MOVEQ   #$73,D5                         ; $2712F6
        MOVE.W  A4,-$63(A4,D7.L)                ; $2712F8
        MOVEQ   #-$5C,D5                        ; $2712FC
        MOVEQ   #-$56,D5                        ; $2712FE
        MOVEQ   #-$50,D5                        ; $271300
        MOVEQ   #-$4F,D5                        ; $271302
        MOVE.W  $7BA4(A4),-$5E(A5,D7.L)         ; $271304
        MOVE.W  -(A5),-$5B(A5,D7.L)             ; $27130A
        MOVEQ   #-$60,D6                        ; $27130E
        MOVE.W  (A7)+,-$5C(A6,D7.L)             ; $271310
        MOVEQ   #-$56,D6                        ; $271314
        MOVEQ   #-$53,D6                        ; $271316
        MOVE.W  -$53(A0,D7.L),-$62(A6,A0.W)     ; $271318
        OR.L   D1,A2                            ; $27131E
        DC.W    $847D               ; $271320 OR.W   <EA:3D>,D2
        OR.W   D2,$6F(A5,A0.W)                  ; $271322
        OR.W   D2,-(A5)                         ; $271326
        OR.W   D2,(A0)+                         ; $271328
        OR.W   A7,D2                            ; $27132A
        OR.W   D1,A5                            ; $27132C
        OR.W   A4,D1                            ; $27132E
        OR.W   D1,D4                            ; $271330
        OR.B   $842E.W,D2                       ; $271332
        OR.B   D1,-$7CD6(A2)                    ; $271336
        OR.B   -$7DCE(A4),D1                    ; $27133A
        OR.B   D0,#$7F50                        ; $27133E
        MOVE.W  -(A7),$7C7D(A6)                 ; $271342
        MOVE.W  A5,-$6C(A6,D7.L)                ; $271346
        MOVE.W  (A1)+,-$65(A6,D7.L)             ; $27134A
        MOVEQ   #-$62,D7                        ; $27134E
        MOVEQ   #-$5D,D7                        ; $271350
        MOVEQ   #-$54,D7                        ; $271352
        MOVE.W  -$4B(A4,D7.L),-$51(A6,D7.L)     ; $271354
        MOVEQ   #-$5E,D7                        ; $27135A
        MOVE.W  (A3),-$78(A6,D7.L)              ; $27135C
        MOVEQ   #-$7C,D6                        ; $271360
        MOVEQ   #-$7A,D6                        ; $271362
        MOVE.W  D5,-$7D(A6,D7.L)                ; $271364
        OR.L   D4,D0                            ; $271368
        OR.L   D0,D0                            ; $27136A
        OR.W   D0,$6D(A7,A0.W)                  ; $27136C
        OR.W   (A6)+,D1                         ; $271370
        OR.W   D1,A6                            ; $271372
        OR.W   D1,D0                            ; $271374
        OR.B   D1,$2D(A3,A0.W)                  ; $271376
        OR.B   D0,$3E(A4,A0.W)                  ; $27137A
        MOVE.W  D6,$7E54(A7)                    ; $27137E
        MOVEQ   #$64,D6                         ; $271382
        MOVEQ   #$70,D5                         ; $271384
        MOVE.W  -$7B(PC,D7.L),$7A8B(A4)         ; $271386
        MOVE.W  A5,-$72(A5,D7.L)                ; $27138C
        MOVE.W  (A2),-$63(A5,D7.L)              ; $271390
        MOVEQ   #-$57,D5                        ; $271394
        MOVEQ   #-$56,D5                        ; $271396
        MOVE.W  -(A4),-$6C(A5,D7.L)             ; $271398
        MOVEQ   #$7D,D7                         ; $27139C
        MOVEQ   #$67,D7                         ; $27139E
        MOVEQ   #$5F,D7                         ; $2713A0
        MOVE.W  (A6)+,-$7FA3(A7)                ; $2713A2
        OR.W   (A2)+,D1                         ; $2713A6
        OR.W   (A7),D2                          ; $2713A8
        OR.W   D2,(A2)+                         ; $2713AA
        OR.W   -(A3),D3                         ; $2713AC
        OR.W   D2,-$7988(A7)                    ; $2713AE
        DC.W    $867D               ; $2713B2 OR.W   <EA:3D>,D3
        OR.L   D2,D2                            ; $2713B4
        OR.L   D3,D2                            ; $2713B6
        OR.L   D1,D3                            ; $2713B8
        OR.L   D1,D1                            ; $2713BA
        DC.W    $827D               ; $2713BC OR.W   <EA:3D>,D1
        OR.W   $7C(PC,A0.W),D1                  ; $2713BE
        DC.W    $817F               ; $2713C2 OR.W   D0,<EA:3F>
        OR.L   D2,D0                            ; $2713C4
        OR.L   D3,D0                            ; $2713C6
        MOVE.W  D7,-$6F(A7,D7.L)                ; $2713C8
        MOVE.W  (A4)+,-$5B(A7,D7.L)             ; $2713CC
        MOVEQ   #-$58,D7                        ; $2713D0
        MOVEQ   #-$58,D7                        ; $2713D2
        MOVEQ   #-$5A,D7                        ; $2713D4
        MOVE.W  $7DAE(A2),-$54(A6,D7.L)         ; $2713D6
        MOVE.W  -(A7),-$5C(A7,A0.W)             ; $2713DC
        MOVE.W  -(A7),-$53(A7,D7.L)             ; $2713E0
        MOVEQ   #-$4E,D6                        ; $2713E4
        MOVE.W  -$4B(A6,D7.L),-$54(A5,D7.L)     ; $2713E6
        MOVEQ   #-$60,D6                        ; $2713EC
        MOVE.W  (A4),-$77(A6,D7.L)              ; $2713EE
        MOVEQ   #$7E,D7                         ; $2713F2
        MOVE.W  $6C(A6,A0.W),-$7F9C(A7)         ; $2713F4
        OR.W   D0,(A3)+                         ; $2713FA
        OR.W   (A1),D0                          ; $2713FC
        OR.W   D0,D1                            ; $2713FE
        OR.B   D0,$22(A0,A0.W)                  ; $271400
        OR.B   (A7)+,D1                         ; $271404
        OR.B   (A5)+,D1                         ; $271406
        OR.B   -(A1),D0                         ; $271408
        MOVE.W  $40(A0,D7.L),-(A7)              ; $27140A
        MOVE.W  A6,$7C5B(A6)                    ; $27140E
        MOVEQ   #$68,D6                         ; $271412
        MOVEQ   #$72,D6                         ; $271414
        MOVEQ   #$73,D6                         ; $271416
        MOVEQ   #$76,D6                         ; $271418
        MOVEQ   #$7C,D6                         ; $27141A
        MOVEQ   #-$7D,D6                        ; $27141C
        MOVE.W  D5,-$7D(A5,D7.L)                ; $27141E
        MOVEQ   #$7C,D6                         ; $271422
        MOVE.W  $7E60(A7),$7F55(A6)             ; $271424
        OR.W   A5,D0                            ; $27142A
        MOVE.W  A2,-$7FB9(A7)                   ; $27142C
        OR.W   D7,D0                            ; $271430
        OR.W   D0,A2                            ; $271432
        OR.W   A7,D1                            ; $271434
        OR.W   D1,(A2)                          ; $271436
        OR.W   D1,(A4)                          ; $271438
        OR.W   (A4)+,D2                         ; $27143A
        OR.W   -(A7),D2                         ; $27143C
        OR.W   D1,$7C(A3,A0.W)                  ; $27143E
        OR.L   D1,A0                            ; $271442
        OR.L   (A2)+,D1                         ; $271444
        OR.L   D0,-(A4)                         ; $271446
        OR.L   D0,-$7E57(A0)                    ; $271448
        OR.L   D0,-(A7)                         ; $27144C
        OR.L   D0,-(A4)                         ; $27144E
        OR.L   D0,-(A0)                         ; $271450
        OR.L   D0,-(A0)                         ; $271452
        OR.L   $7FB5(A1),D0                     ; $271454
        DC.W    $7FBD,$80C8         ; $271458 MOVE.W  <EA:3D>,-$38(A7,A0.W)
        DIVU    (A4),D0                         ; $27145C
        DC.W    $7FDC               ; $27145E MOVE.W  (A4)+,<EA:3F>
        DC.W    $7FDD               ; $271460 MOVE.W  (A5)+,<EA:3F>
        DC.W    $7FDE               ; $271462 MOVE.W  (A6)+,<EA:3F>
        DC.W    $7FDD               ; $271464 MOVE.W  (A5)+,<EA:3F>
        DC.W    $7FDC               ; $271466 MOVE.W  (A4)+,<EA:3F>
        DC.W    $7FDA               ; $271468 MOVE.W  (A2)+,<EA:3F>
        MOVEQ   #-$2A,D7                        ; $27146A
        MOVEQ   #-$2E,D7                        ; $27146C
        DC.W    $7DCA               ; $27146E MOVE.W  A2,<EA:3E>
        MOVE.W  -$57(PC,D7.L),-$6A(A6,D7.L)     ; $271470
        MOVE.W  D7,$77(A6,D7.L)                 ; $271476
        MOVE.W  -(A4),$7D53(A6)                 ; $27147A
        MOVE.W  A0,$7C43(A6)                    ; $27147E
        MOVEQ   #$40,D6                         ; $271482
        MOVEQ   #$39,D7                         ; $271484
        OR.B   -$7EDE(A6),D0                    ; $271486
        OR.B   D0,(A6)+                         ; $27148A
        OR.B   D0,(A5)+                         ; $27148C
        OR.B   (A4)+,D1                         ; $27148E
        OR.B   (A5)+,D1                         ; $271490
        OR.B   D1,(A6)+                         ; $271492
        OR.B   -(A0),D1                         ; $271494
        OR.B   D0,-(A1)                         ; $271496
        OR.B   -(A3),D0                         ; $271498
        MOVE.W  $7E39(A0),-(A7)                 ; $27149A
        MOVE.W  D6,$7D4E(A6)                    ; $27149E
        MOVE.W  (A7),$7D66(A6)                  ; $2714A2
        MOVE.W  -$7F(A5,D7.L),$7E88(A6)         ; $2714A6
        MOVEQ   #-$73,D7                        ; $2714AC
        MOVE.W  (A4),-$6E(A7,A0.W)              ; $2714AE
        OR.L   A2,D0                            ; $2714B2
        OR.L   D0,D2                            ; $2714B4
        OR.W   D0,-$7E8D(PC)                    ; $2714B6
        OR.W   D0,-$7E91(A7)                    ; $2714BA
        OR.W   D0,$77(A1,A0.W)                  ; $2714BE
        OR.L   D0,D5                            ; $2714C2
        OR.L   (A5),D1                          ; $2714C4
        OR.L   D1,(A7)+                         ; $2714C6
        OR.L   -(A4),D2                         ; $2714C8
        OR.L   -(A5),D2                         ; $2714CA
        OR.L   -$7C4F(A0),D2                    ; $2714CC
        OR.L   -$7E3D(PC),D1                    ; $2714D0
        DIVU    D5,D0                           ; $2714D4
        DC.W    $80BF               ; $2714D6 OR.L   <EA:3F>,D0
        OR.L   -$4E(A6,A0.W),D0                 ; $2714D8
        OR.L   D0,-$7E57(A7)                    ; $2714DC
        OR.L   D0,-(A4)                         ; $2714E0
        OR.L   -(A5),D0                         ; $2714E2
        OR.L   -(A6),D0                         ; $2714E4
        MOVE.W  $7FAE(A1),-$4C(A7,D7.L)         ; $2714E6
        MOVEQ   #-$43,D7                        ; $2714EC
        MOVEQ   #-$3E,D7                        ; $2714EE
        DC.W    $7FC1               ; $2714F0 MOVE.W  D1,<EA:3F>
        MOVE.W  #$7FBC,-$3D(A7,D7.L)            ; $2714F2
        DC.W    $7BCC               ; $2714F8 MOVE.W  A4,<EA:3D>
        DC.W    $7BCC               ; $2714FA MOVE.W  A4,<EA:3D>
        DC.W    $7BC6               ; $2714FC MOVE.W  D6,<EA:3D>
        MOVEQ   #-$47,D6                        ; $2714FE
        MOVE.W  $7D9A(A0),-$73(A6,D7.L)         ; $271500
        MOVEQ   #$78,D7                         ; $271506
        MOVE.W  -(A5),$7F5B(A7)                 ; $271508
        MOVEQ   #$55,D7                         ; $27150C
        MOVE.W  A6,$7E42(A6)                    ; $27150E
        MOVE.W  $28(A2,A0.W),-(A7)              ; $271512
        OR.B   D0,-(A1)                         ; $271516
        OR.B   D0,(A3)+                         ; $271518
        OR.B   (A1)+,D1                         ; $27151A
        OR.B   (A1)+,D1                         ; $27151C
        OR.B   D0,(A2)+                         ; $27151E
        OR.B   (A4)+,D0                         ; $271520
        OR.B   (A5)+,D0                         ; $271522
        MOVE.W  -(A3),-(A7)                     ; $271524
        MOVEQ   #$2C,D7                         ; $271526
        MOVEQ   #$34,D7                         ; $271528
        MOVEQ   #$3F,D7                         ; $27152A
        MOVE.W  (A1),$7B61(A6)                  ; $27152C
        MOVE.W  -(A4),$7B65(A5)                 ; $271530
        MOVE.W  $7B6F(A2),$7B6D(A5)             ; $271534
        MOVEQ   #$6B,D6                         ; $27153A
        MOVEQ   #$69,D7                         ; $27153C
        MOVE.W  $7F70(A3),$7F73(A7)             ; $27153E
        OR.W   $77(A5,A0.W),D0                  ; $271544
        OR.W   D0,$74(A7,A0.W)                  ; $271548
        OR.W   -$7B93(A7),D2                    ; $27154C
        OR.W   D2,$75(A0,A0.W)                  ; $271550
        OR.W   -$7A7A(PC),D3                    ; $271554
        OR.L   (A2),D2                          ; $271558
        OR.L   D1,(A7)+                         ; $27155A
        OR.L   -$7D55(A0),D1                    ; $27155C
        OR.L   -$7D5B(A1),D1                    ; $271560
        OR.L   D0,-(A1)                         ; $271564
        OR.L   (A4)+,D0                         ; $271566
        MOVE.W  (A1)+,-$69(A7,D7.L)             ; $271568
        MOVE.W  (A1),-$75(A7,D7.L)              ; $27156C
        OR.L   A1,D0                            ; $271570
        OR.L   D3,D0                            ; $271572
        DC.W    $807D               ; $271574 OR.W   <EA:3D>,D0
        DC.W    $807D               ; $271576 OR.W   <EA:3D>,D0
        MOVE.W  D1,-$7A(A7,D7.L)                ; $271578
        MOVEQ   #-$70,D7                        ; $27157C
        MOVE.W  -(A0),-$51(A6,D7.L)             ; $27157E
        MOVEQ   #-$45,D6                        ; $271582
        DC.W    $7BC5               ; $271584 MOVE.W  D5,<EA:3D>
        MOVEQ   #-$33,D5                        ; $271586
        MOVEQ   #-$34,D5                        ; $271588
        DC.W    $7BC5               ; $27158A MOVE.W  D5,<EA:3D>
        MOVEQ   #-$49,D6                        ; $27158C
        MOVEQ   #-$60,D7                        ; $27158E
        MOVE.W  A0,$74(A7,A0.W)                 ; $271590
        OR.W   -(A4),D0                         ; $271594
        OR.W   (A4),D0                          ; $271596
        OR.W   A1,D0                            ; $271598
        OR.W   D0,D1                            ; $27159A
        OR.B   D0,$34(PC,A0.W)                  ; $27159C
        OR.B   $2F(A0,A0.W),D1                  ; $2715A0
        OR.B   -$7ED1(A6),D1                    ; $2715A4
        MOVE.W  $7E4C7D62,-(A7)                 ; $2715A8
        DC.W    $7D79,$7C88,$7B92,$7B93; $2715AE MOVE.W  $7C887B92,$7B93(A6)
        MOVE.W  (A1),-$6E(A5,D7.L)              ; $2715B6
        MOVEQ   #-$68,D5                        ; $2715BA
        MOVEQ   #-$64,D5                        ; $2715BC
        MOVE.W  (A7)+,-$5A(A5,D7.L)             ; $2715BE
        MOVEQ   #-$4E,D6                        ; $2715C2
        DC.W    $7BC1               ; $2715C4 MOVE.W  D1,<EA:3D>
        DC.W    $7BC9               ; $2715C6 MOVE.W  A1,<EA:3D>
        MOVEQ   #-$37,D6                        ; $2715C8
        MOVEQ   #-$42,D7                        ; $2715CA
        OR.L   -(A4),D0                         ; $2715CC
        OR.L   D0,D1                            ; $2715CE
        OR.W   D1,(A5)+                         ; $2715D0
        OR.W   D1,A3                            ; $2715D2
        OR.W   D1,D7                            ; $2715D4
        OR.W   D1,A1                            ; $2715D6
        OR.W   D1,A3                            ; $2715D8
        OR.W   D2,A3                            ; $2715DA
        OR.W   D2,A3                            ; $2715DC
        OR.W   D2,(A1)                          ; $2715DE
        OR.W   -(A0),D2                         ; $2715E0
        OR.W   -$80(A0,A0.W),D2                 ; $2715E2
        OR.L   (A0),D2                          ; $2715E6
        OR.L   (A6)+,D1                         ; $2715E8
        OR.L   D0,-(A7)                         ; $2715EA
        OR.L   $7FB7(A5),D0                     ; $2715EC
        DC.W    $7DC0               ; $2715F0 MOVE.W  D0,<EA:3E>
        DC.W    $7DC0               ; $2715F2 MOVE.W  D0,<EA:3E>
        MOVEQ   #-$47,D7                        ; $2715F4
        MOVE.W  $7FA0(A7),-$6F(A7,D7.L)         ; $2715F6
        MOVEQ   #-$79,D7                        ; $2715FC
        MOVEQ   #-$7A,D7                        ; $2715FE
        MOVEQ   #-$7A,D7                        ; $271600
        MOVE.W  D3,-$7D(A7,D7.L)                ; $271602
        MOVE.W  D5,-$7D(A6,D7.L)                ; $271606
        MOVEQ   #-$80,D6                        ; $27160A
        MOVEQ   #$7F,D6                         ; $27160C
        MOVE.W  D1,-$7B(A6,D7.L)                ; $27160E
        MOVEQ   #-$7A,D7                        ; $271612
        MOVEQ   #-$7C,D7                        ; $271614
        MOVEQ   #$7C,D7                         ; $271616
        MOVE.W  $6C(A2,D7.L),$7C6A(A6)          ; $271618
        MOVEQ   #$67,D6                         ; $27161E
        MOVE.W  -(A2),$7E5B(A6)                 ; $271620
        MOVEQ   #$55,D7                         ; $271624
        MOVEQ   #$50,D7                         ; $271626
        MOVE.W  D7,$7F3E(A7)                    ; $271628
        OR.B   $80378039,D0                     ; $27162C
        OR.B   -$7EC8(PC),D0                    ; $271632
        OR.B   $37(A6,A0.W),D1                  ; $271636
        OR.B   D0,$44(PC,A0.W)                  ; $27163A
        OR.W   (A3),D0                          ; $27163E
        MOVE.W  -(A2),$7E73(A7)                 ; $271640
        MOVE.W  A0,-$60(A6,D7.L)                ; $271644
        MOVE.W  -$3E(A6,D7.L),-$3B(A5,D7.L)     ; $271648
        MOVEQ   #-$40,D6                        ; $27164E
        MOVEQ   #-$47,D6                        ; $271650
        MOVEQ   #-$4E,D6                        ; $271652
        MOVE.W  -(A6),-$6A(A6,D7.L)             ; $271654
        MOVEQ   #-$78,D7                        ; $271658
        MOVE.W  $63(A7,A0.W),-$7EAD(A7)         ; $27165A
        OR.W   A2,D1                            ; $271660
        OR.W   D1,D0                            ; $271662
        OR.B   $29(A2,A0.W),D2                  ; $271664
        OR.B   -$7AD7(A0),D3                    ; $271668
        OR.B   $4A(A7,A0.W),D2                  ; $27166C
        OR.W   D2,(A1)+                         ; $271670
        OR.W   D2,-$7C7E(A3)                    ; $271672
        OR.L   (A7),D0                          ; $271676
        MOVE.W  $7FB5(A1),-$42(A7,D7.L)         ; $271678
        DIVU    D2,D0                           ; $27167E
        DIVU    D0,D0                           ; $271680
        OR.L   #$80B97FB6,D0                    ; $271682
        MOVEQ   #-$48,D7                        ; $271688
        DC.W    $7FB9,$80B8,$80B6,$7FB8; $27168A MOVE.W  $80B880B6,-$48(A7,D7.L)
        MOVEQ   #-$41,D7                        ; $271692
        MOVEQ   #-$3A,D7                        ; $271694
        MOVEQ   #-$35,D7                        ; $271696
        MOVEQ   #-$31,D7                        ; $271698
        MOVEQ   #-$30,D7                        ; $27169A
        MOVEQ   #-$2B,D6                        ; $27169C
        MOVEQ   #-$2A,D6                        ; $27169E
        DC.W    $7BD3               ; $2716A0 MOVE.W  (A3),<EA:3D>
        MOVEQ   #-$35,D6                        ; $2716A2
        MOVE.W  #$7DAB,-$64(A6,D7.L)            ; $2716A4
        MOVEQ   #-$73,D7                        ; $2716AA
        MOVEQ   #$7B,D7                         ; $2716AC
        MOVEQ   #$6B,D7                         ; $2716AE
        MOVE.W  (A7)+,$7E56(A7)                 ; $2716B0
        MOVEQ   #$4C,D7                         ; $2716B4
        DC.W    $7F3E               ; $2716B6 MOVE.W  <EA:3E>,-(A7)
        OR.B   $2C(A4,A0.W),D0                  ; $2716B8
        OR.B   D0,-(A4)                         ; $2716BC
        OR.B   (A6)+,D1                         ; $2716BE
        OR.B   D1,(A5)+                         ; $2716C0
        OR.B   D1,(A6)+                         ; $2716C2
        OR.B   -(A2),D1                         ; $2716C4
        OR.B   D0,$47(A5,A0.W)                  ; $2716C6
        OR.W   A7,D0                            ; $2716CA
        MOVE.W  (A7),$7F63(A7)                  ; $2716CC
        MOVEQ   #$70,D7                         ; $2716D0
        MOVEQ   #$7C,D7                         ; $2716D2
        MOVE.W  D6,-$76(A6,D7.L)                ; $2716D4
        MOVE.W  A7,-$67(A6,D7.L)                ; $2716D8
        MOVE.W  -(A5),-$54(A6,D7.L)             ; $2716DC
        MOVE.W  $7D99(A0),-$7B(A6,D7.L)         ; $2716E0
        MOVE.W  $67(A1,D7.L),-$7F9E(A7)         ; $2716E6
        OR.W   (A2)+,D1                         ; $2716EC
        OR.W   D1,A0                            ; $2716EE
        OR.B   D2,#$843E                        ; $2716F0
        OR.W   D1,D3                            ; $2716F4
        OR.W   D1,D6                            ; $2716F6
        OR.W   D1,A3                            ; $2716F8
        OR.W   D1,(A5)                          ; $2716FA
        OR.W   D1,-(A1)                         ; $2716FC
        OR.W   D1,-$7D8F(A2)                    ; $2716FE
        OR.W   D0,-$73(PC,A0.W)                 ; $271702
        MOVEQ   #-$65,D7                        ; $271706
        MOVEQ   #-$5D,D7                        ; $271708
        MOVE.W  -(A0),-$64(A7,D7.L)             ; $27170A
        MOVEQ   #-$63,D7                        ; $27170E
        MOVEQ   #-$64,D7                        ; $271710
        MOVEQ   #-$6A,D7                        ; $271712
        OR.L   A7,D0                            ; $271714
        OR.L   D0,A5                            ; $271716
        OR.L   (A1),D0                          ; $271718
        MOVE.W  (A7),-$61(A7,D7.L)              ; $27171A
        MOVE.W  $7BB5(A0),-$40(A6,D7.L)         ; $27171E
        DC.W    $7BC6               ; $271724 MOVE.W  D6,<EA:3D>
        MOVEQ   #-$30,D6                        ; $271726
        MOVEQ   #-$28,D6                        ; $271728
        MOVEQ   #-$28,D6                        ; $27172A
        DC.W    $7DD4               ; $27172C MOVE.W  (A4),<EA:3E>
        DC.W    $7DD0               ; $27172E MOVE.W  (A0),<EA:3E>
        DC.W    $7DC7               ; $271730 MOVE.W  D7,<EA:3E>
        MOVE.W  $7EA7(PC),-$70(A6,D7.L)         ; $271732
        OR.W   #$806D,D0                        ; $271738
        OR.W   -(A1),D0                         ; $27173C
        OR.W   (A4),D0                          ; $27173E
        OR.W   D0,A0                            ; $271740
        OR.B   D0,#$8032                        ; $271742
        OR.B   -$7FDC(A1),D0                    ; $271746
        MOVE.W  $7E3A(A2),-(A7)                 ; $27174A
        MOVE.W  A6,$7C60(A6)                    ; $27174E
        MOVEQ   #$6C,D6                         ; $271752
        MOVEQ   #$73,D6                         ; $271754
        MOVEQ   #$77,D6                         ; $271756
        MOVEQ   #$7B,D6                         ; $271758
        DC.W    $7B7F,$7B83         ; $27175A MOVE.W  <EA:3F>,$7B83(A5)
        MOVE.W  D6,-$80(A5,D7.L)                ; $27175E
        DC.W    $7B79,$7C75,$7C71,$7D6B; $271762 MOVE.W  $7C757C71,$7D6B(A5)
        MOVE.W  (A7)+,-$7EAC(A7)                ; $27176A
        OR.W   D0,A7                            ; $27176E
        OR.W   A5,D1                            ; $271770
        OR.W   D6,D1                            ; $271772
        OR.B   -$78D2(PC),D2                    ; $271774
        OR.B   -$77D6(A2),D4                    ; $271778
        OR.B   D3,-$79C9(A6)                    ; $27177C
        OR.W   D4,D3                            ; $271780
        OR.W   D2,(A0)                          ; $271782
        OR.W   (A1)+,D2                         ; $271784
        OR.W   D1,-(A5)                         ; $271786
        OR.W   D1,-$7D(A4,A0.W)                 ; $271788
        OR.L   (A1),D0                          ; $27178C
        OR.L   -(A0),D0                         ; $27178E
        MOVEQ   #-$4E,D7                        ; $271790
        DC.W    $7DC0               ; $271792 MOVE.W  D0,<EA:3E>
        DC.W    $7DC3               ; $271794 MOVE.W  D3,<EA:3E>
        MOVEQ   #-$42,D7                        ; $271796
        MOVEQ   #-$44,D7                        ; $271798
        DC.W    $7DBF,$7DC0         ; $27179A MOVE.W  <EA:3F>,-$40(A6,D7.L)
        DC.W    $7DBE,$7FBB         ; $27179E MOVE.W  <EA:3E>,-$45(A6,D7.L)
        OR.L   -$44(PC,D7.L),D0                 ; $2717A2
        MOVEQ   #-$42,D7                        ; $2717A6
        MOVEQ   #-$3E,D7                        ; $2717A8
        DC.W    $7DC6               ; $2717AA MOVE.W  D6,<EA:3E>
        MOVEQ   #-$35,D6                        ; $2717AC
        MOVEQ   #-$30,D6                        ; $2717AE
        MOVEQ   #-$2D,D6                        ; $2717B0
        DC.W    $7DD3               ; $2717B2 MOVE.W  (A3),<EA:3E>
        DC.W    $7DD4               ; $2717B4 MOVE.W  (A4),<EA:3E>
        DC.W    $7DD3               ; $2717B6 MOVE.W  (A3),<EA:3E>
        DC.W    $7DD0               ; $2717B8 MOVE.W  (A0),<EA:3E>
        DC.W    $7DC9               ; $2717BA MOVE.W  A1,<EA:3E>
        MOVE.W  #$7FA7,-$75(A6,A0.W)            ; $2717BC
        OR.W   $63(A2,A0.W),D1                  ; $2717C2
        OR.W   D0,(A0)+                         ; $2717C6
        OR.W   A7,D0                            ; $2717C8
        OR.W   D0,A0                            ; $2717CA
        OR.W   D0,D5                            ; $2717CC
        OR.W   D6,D0                            ; $2717CE
        MOVE.W  A4,$7E51(A7)                    ; $2717D0
        MOVEQ   #$58,D7                         ; $2717D4
        MOVE.W  (A7)+,$7C67(A6)                 ; $2717D6
        MOVE.W  $7C(A3,D7.L),$7C7E(A5)          ; $2717DA
        MOVE.W  #$7D77,$7D6F(A6)                ; $2717E0
        MOVE.W  -(A3),$7E56(A6)                 ; $2717E6
        MOVEQ   #$4E,D7                         ; $2717EA
        MOVEQ   #$4D,D7                         ; $2717EC
        MOVEQ   #$4D,D7                         ; $2717EE
        MOVEQ   #$51,D7                         ; $2717F0
        MOVEQ   #$5A,D7                         ; $2717F2
        MOVEQ   #$65,D7                         ; $2717F4
        MOVE.W  -$7F90(A6),-$7E96(A7)           ; $2717F6
        OR.W   (A4)+,D1                         ; $2717FC
        OR.W   D1,D7                            ; $2717FE
        OR.B   D1,$2A(A1,A0.W)                  ; $271800
        OR.B   -(A6),D2                         ; $271804
        OR.B   -(A4),D2                         ; $271806
        OR.B   -(A5),D2                         ; $271808
        OR.B   -$7BCC(A0),D2                    ; $27180A
        OR.W   D1,A1                            ; $27180E
        OR.W   -$7F76(A0),D1                    ; $271810
        MOVE.W  -(A3),-$4D(A7,D7.L)             ; $271814
        MOVEQ   #-$42,D7                        ; $271818
        DC.W    $7DC8               ; $27181A MOVE.W  A0,<EA:3E>
        MOVEQ   #-$36,D6                        ; $27181C
        DC.W    $7DCA               ; $27181E MOVE.W  A2,<EA:3E>
        DC.W    $7DCB               ; $271820 MOVE.W  A3,<EA:3E>
        DC.W    $7DCD               ; $271822 MOVE.W  A5,<EA:3E>
        DC.W    $7DCF               ; $271824 MOVE.W  A7,<EA:3E>
        DC.W    $7DCE               ; $271826 MOVE.W  A6,<EA:3E>
        DC.W    $7DC7               ; $271828 MOVE.W  D7,<EA:3E>
        MOVEQ   #-$40,D7                        ; $27182A
        MOVEQ   #-$47,D7                        ; $27182C
        MOVEQ   #-$4F,D7                        ; $27182E
        MOVE.W  -(A7),-$63(A7,A0.W)             ; $271830
        OR.L   (A7),D0                          ; $271834
        OR.L   (A5),D0                          ; $271836
        MOVE.W  (A4),-$6E(A7,D7.L)              ; $271838
        MOVEQ   #-$6E,D7                        ; $27183C
        MOVE.W  (A5),-$68(A6,D7.L)              ; $27183E
        MOVE.W  (A0)+,-$6C(A6,D7.L)             ; $271842
        MOVEQ   #-$70,D7                        ; $271846
        MOVEQ   #-$75,D7                        ; $271848
        MOVEQ   #-$79,D7                        ; $27184A
        MOVEQ   #-$7E,D7                        ; $27184C
        MOVE.W  $66(A7,A0.W),-$7DAF(A7)         ; $27184E
        OR.B   D1,$2D(PC,A0.W)                  ; $271854
        OR.B   -(A4),D1                         ; $271858
        OR.B   D0,-(A2)                         ; $27185A
        OR.B   -(A5),D0                         ; $27185C
        OR.B   -$7FC6(A4),D0                    ; $27185E
        MOVEQ   #$4C,D7                         ; $271862
        MOVE.W  (A7)+,$7D6E(A6)                 ; $271864
        MOVE.W  $76(A6,D7.L),$7E75(A6)          ; $271868
        DC.W    $7D79,$7C81,$7B88,$7C88; $27186E MOVE.W  $7C817B88,$7C88(A6)
        MOVEQ   #-$7E,D6                        ; $271876
        DC.W    $7D7E,$7E80         ; $271878 MOVE.W  <EA:3E>,$7E80(A6)
        MOVEQ   #-$78,D7                        ; $27187C
        MOVE.W  A5,-$79(A7,D7.L)                ; $27187E
        DC.W    $807E               ; $271882 OR.W   <EA:3E>,D0
        OR.W   $7E(PC,A0.W),D0                  ; $271884
        OR.W   #$8272,D0                        ; $271888
        OR.W   -(A7),D2                         ; $27188C
        OR.W   D2,-(A1)                         ; $27188E
        OR.W   D2,(A4)+                         ; $271890
        OR.W   D2,(A3)+                         ; $271892
        OR.W   (A4)+,D2                         ; $271894
        OR.W   D1,(A4)+                         ; $271896
        OR.W   (A7)+,D1                         ; $271898
        OR.W   -(A7),D0                         ; $27189A
        MOVE.W  -$80(A4,D7.L),$7F85(A7)         ; $27189C
        MOVE.W  A2,-$6E(A7,D7.L)                ; $2718A2
        MOVE.W  -(A0),-$4D(A7,D7.L)             ; $2718A6
        MOVEQ   #-$3F,D7                        ; $2718AA
        MOVEQ   #-$39,D7                        ; $2718AC
        MOVEQ   #-$37,D7                        ; $2718AE
        MOVEQ   #-$39,D7                        ; $2718B0
        DC.W    $7FC0               ; $2718B2 MOVE.W  D0,<EA:3F>
        DC.W    $7FB9,$80B4,$81B0,$81A8; $2718B4 MOVE.W  $80B481B0,-$58(A7,A0.W)
        OR.L   D0,(A7)+                         ; $2718BC
        OR.L   (A4)+,D0                         ; $2718BE
        MOVE.W  -(A0),-$5B(A7,D7.L)             ; $2718C0
        MOVEQ   #-$5A,D7                        ; $2718C4
        MOVE.W  -(A7),-$56(A6,D7.L)             ; $2718C6
        MOVEQ   #-$4F,D5                        ; $2718CA
        MOVEQ   #-$4B,D5                        ; $2718CC
        MOVEQ   #-$4C,D5                        ; $2718CE
        MOVE.W  $7CA4(A5),-$6B(A5,D7.L)         ; $2718D0
        MOVEQ   #-$80,D7                        ; $2718D6
        MOVE.W  -(A6),-$7EB7(A7)                ; $2718D8
        OR.B   -$7CDF(A6),D1                    ; $2718DC
        OR.B   D1,(A4)+                         ; $2718E0
        OR.B   (A2)+,D1                         ; $2718E2
        OR.B   D0,(A5)+                         ; $2718E4
        OR.B   -(A5),D0                         ; $2718E6
        OR.B   D0,-$7ECE(A3)                    ; $2718E8
        DC.W    $813D               ; $2718EC OR.B   D0,<EA:3D>
        OR.W   A0,D0                            ; $2718EE
        MOVE.W  (A3),$7F5C(A7)                  ; $2718F0
        MOVE.W  -(A2),$7F6D(A7)                 ; $2718F4
        MOVE.W  $7E7F.W,$7E82(A7)               ; $2718F8
        MOVEQ   #-$7D,D7                        ; $2718FE
        MOVE.W  A0,-$6F(A6,D7.L)                ; $271900
        MOVE.W  (A2)+,-$60(A6,D7.L)             ; $271904
        MOVEQ   #-$62,D7                        ; $271908
        MOVE.W  (A7),-$71(A7,D7.L)              ; $27190A
        MOVEQ   #-$7A,D7                        ; $27190E
        MOVE.W  #$7F72,$7F64(A7)                ; $271910
        MOVE.W  (A4),-$7FBD(A7)                 ; $271916
        OR.B   $2A(A3,A0.W),D1                  ; $27191A
        OR.B   -(A7),D1                         ; $27191E
        OR.B   D0,-$7FC6(A3)                    ; $271920
        OR.W   A3,D0                            ; $271924
        OR.W   D0,(A4)                          ; $271926
        OR.W   D0,(A4)                          ; $271928
        OR.W   D0,(A1)+                         ; $27192A
        MOVE.W  $7E7B(A0),$7E88(A7)             ; $27192C
        MOVE.W  (A2),-$5A(A7,D7.L)              ; $271932
        MOVE.W  -$39(PC,D7.L),-$37(A7,A0.W)     ; $271936
        DIVU    A1,D1                           ; $27193C
        DIVU    D6,D1                           ; $27193E
        OR.L   D0,-$54(PC,A0.W)                 ; $271940
        OR.L   -(A4),D1                         ; $271944
        OR.L   D0,-(A6)                         ; $271946
        MOVE.W  $7EAD(A2),-$4B(A7,D7.L)         ; $271948
        DC.W    $7DBF,$7CC9         ; $27194E MOVE.W  <EA:3F>,-$37(A6,D7.L)
        MOVEQ   #-$2D,D5                        ; $271952
        MOVEQ   #-$29,D5                        ; $271954
        DC.W    $7BD6               ; $271956 MOVE.W  (A6),<EA:3D>
        DC.W    $7BD2               ; $271958 MOVE.W  (A2),<EA:3D>
        MOVEQ   #-$38,D6                        ; $27195A
        MOVEQ   #-$4A,D6                        ; $27195C
        MOVEQ   #-$5B,D7                        ; $27195E
        MOVE.W  (A6),-$7A(A7,A0.W)              ; $271960
        OR.W   D0,$66(A4,A0.W)                  ; $271964
        OR.W   D1,(A7)                          ; $271968
        OR.W   D1,A2                            ; $27196A
        DC.W    $833F               ; $27196C OR.B   D1,<EA:3F>
        OR.B   $3D(PC,A0.W),D1                  ; $27196E
        OR.W   D5,D0                            ; $271972
        MOVE.W  (A0),$7E60(A7)                  ; $271974
        MOVE.W  -$7A(A2,D7.L),$7A99(A6)         ; $271978
        MOVE.W  $79B5(A2),-$46(A4,D7.L)         ; $27197E
        MOVEQ   #-$4B,D5                        ; $271984
        MOVE.W  $7BA6(A5),-$64(A5,D7.L)         ; $271986
        MOVEQ   #-$71,D6                        ; $27198C
        MOVE.W  D4,$79(A6,D7.L)                 ; $27198E
        MOVE.W  -$7FA7(A1),-$7EB1(A7)           ; $271992
        OR.W   D0,A0                            ; $271998
        OR.W   D0,D4                            ; $27199A
        OR.W   D0,D0                            ; $27199C
        DC.W    $813D               ; $27199E OR.B   D0,<EA:3D>
        OR.B   $30(A6,A0.W),D1                  ; $2719A0
        OR.B   D1,-$7CD8(A1)                    ; $2719A4
        OR.B   -$7DCF(A5),D1                    ; $2719A8
        OR.B   $39(A5,A0.W),D1                  ; $2719AC
        OR.B   -$7DC9(PC),D1                    ; $2719B0
        OR.B   $2C(A0,A0.W),D1                  ; $2719B4
        OR.B   D0,$3D(A0,A0.W)                  ; $2719B8
        MOVE.W  A6,-$7FA0(A7)                   ; $2719BC
        OR.W   D0,-$7E89(A7)                    ; $2719C0
        OR.W   D0,$7F(PC,A0.W)                  ; $2719C4
        OR.L   D4,D1                            ; $2719C8
        OR.L   D0,A1                            ; $2719CA
        OR.L   D0,A4                            ; $2719CC
        OR.L   D0,(A6)                          ; $2719CE
        OR.L   -(A5),D0                         ; $2719D0
        MOVE.W  -$3F(A5,D7.L),-$32(A7,D7.L)     ; $2719D2
        DC.W    $7DDB               ; $2719D8 MOVE.W  (A3)+,<EA:3E>
        MOVEQ   #-$1E,D6                        ; $2719DA
        DC.W    $7BE3               ; $2719DC MOVE.W  -(A3),<EA:3D>
        DC.W    $7BE3               ; $2719DE MOVE.W  -(A3),<EA:3D>
        DC.W    $7BE3               ; $2719E0 MOVE.W  -(A3),<EA:3D>
        MOVEQ   #-$1F,D6                        ; $2719E2
        MOVEQ   #-$21,D6                        ; $2719E4
        MOVEQ   #-$27,D6                        ; $2719E6
        DC.W    $7DCF               ; $2719E8 MOVE.W  A7,<EA:3E>
        MOVEQ   #-$3C,D7                        ; $2719EA
        MOVE.W  -$5F(A4,A0.W),-$72(A7,A0.W)     ; $2719EC
        OR.L   D2,D1                            ; $2719F2
        OR.W   $8172.W,D1                       ; $2719F4
        OR.W   D0,-$7E9C(A3)                    ; $2719F8
        OR.W   -(A0),D0                         ; $2719FC
        MOVE.W  (A3)+,$7E57(A7)                 ; $2719FE
        MOVE.W  (A5),$7D54(A6)                  ; $271A02
        MOVEQ   #$54,D6                         ; $271A06
        MOVEQ   #$5B,D6                         ; $271A08
        MOVE.W  -(A5),$7A6F(A5)                 ; $271A0A
        MOVE.W  $78(A5,D7.L),$7C79(A5)          ; $271A0E
        MOVE.W  $7E79(PC),$7E77(A6)             ; $271A14
        MOVE.W  $74(A5,D7.L),$7F74(A7)          ; $271A1A
        MOVE.W  $76(A6,A0.W),-$7F8C(A7)         ; $271A20
        OR.W   D0,-$7E9D(A5)                    ; $271A26
        OR.W   D0,(A1)+                         ; $271A2A
        OR.W   D0,A6                            ; $271A2C
        OR.B   D1,$2C(PC,A0.W)                  ; $271A2E
        OR.B   D1,-(A7)                         ; $271A32
        OR.B   D1,-(A5)                         ; $271A34
        OR.B   -(A5),D1                         ; $271A36
        OR.B   -$7DC5(A5),D1                    ; $271A38
        OR.W   D0,A2                            ; $271A3C
        OR.W   D0,(A7)                          ; $271A3E
        OR.W   -(A5),D0                         ; $271A40
        MOVE.W  $7F(A3,D7.L),$7E88(A7)          ; $271A42
        MOVEQ   #-$6E,D7                        ; $271A48
        MOVE.W  (A1)+,-$5F(A7,A0.W)             ; $271A4A
        OR.L   D0,-$7E52(A0)                    ; $271A4E
        OR.L   D0,-$4C(A2,A0.W)                 ; $271A52
        OR.L   D0,-$49(A5,A0.W)                 ; $271A56
        DC.W    $7FBF,$7DC9         ; $271A5A MOVE.W  <EA:3F>,-$37(A7,D7.L)
        DC.W    $7BD6               ; $271A5E MOVE.W  (A6),<EA:3D>
        MOVEQ   #-$24,D5                        ; $271A60
        MOVE.W  (A6)+,#$79DF                    ; $271A62
        MOVE.W  (A6)+,#$7ADD                    ; $271A66
        DC.W    $7BDC               ; $271A6A MOVE.W  (A4)+,<EA:3D>
        MOVEQ   #-$26,D6                        ; $271A6C
        MOVEQ   #-$28,D7                        ; $271A6E
        DIVU    (A0),D0                         ; $271A70
        DC.W    $82BD               ; $271A72 OR.L   <EA:3D>,D1
        OR.L   D1,-$7B72(A0)                    ; $271A74
        OR.W   D2,$5B(A1,A0.W)                  ; $271A78
        OR.W   D2,A5                            ; $271A7C
        OR.W   D2,D2                            ; $271A7E
        OR.B   D1,#$8339                        ; $271A80
        OR.B   $33(A5,A0.W),D2                  ; $271A84
        OR.B   D0,$7F3E.W                       ; $271A88
        MOVEQ   #$45,D7                         ; $271A8C
        MOVEQ   #$4A,D6                         ; $271A8E
        MOVEQ   #$4F,D6                         ; $271A90
        MOVE.W  (A0),$7B51(A5)                  ; $271A92
        MOVE.W  (A5),$7B5B(A5)                  ; $271A96
        MOVE.W  -(A2),$7C69(A5)                 ; $271A9A
        MOVEQ   #$6C,D6                         ; $271A9E
        MOVEQ   #$6A,D6                         ; $271AA0
        MOVEQ   #$67,D6                         ; $271AA2
        MOVEQ   #$68,D6                         ; $271AA4
        MOVEQ   #$6B,D6                         ; $271AA6
        MOVE.W  $7E67(A2),$7E61(A6)             ; $271AA8
        MOVEQ   #$5B,D7                         ; $271AAE
        MOVEQ   #$53,D7                         ; $271AB0
        MOVEQ   #$45,D7                         ; $271AB2
        MOVEQ   #$38,D7                         ; $271AB4
        MOVE.W  $2E(A0,A0.W),-(A7)              ; $271AB6
        OR.B   D0,-$7DC9(A7)                    ; $271ABA
        OR.W   D1,D1                            ; $271ABE
        OR.W   A1,D1                            ; $271AC0
        OR.W   D1,(A4)                          ; $271AC2
        OR.W   D1,(A5)+                         ; $271AC4
        OR.W   D1,-(A2)                         ; $271AC6
        OR.W   D1,-(A2)                         ; $271AC8
        OR.W   D1,-(A3)                         ; $271ACA
        OR.W   -$7D8A(A2),D1                    ; $271ACC
        OR.L   D1,D1                            ; $271AD0
        OR.L   A1,D2                            ; $271AD2
        OR.L   D2,A6                            ; $271AD4
        OR.L   D2,(A3)                          ; $271AD6
        OR.L   (A3)+,D2                         ; $271AD8
        OR.L   D1,-(A7)                         ; $271ADA
        OR.L   -$7E4E(A7),D1                    ; $271ADC
        OR.L   -$43(A6,D7.L),D0                 ; $271AE0
        MOVEQ   #-$3B,D7                        ; $271AE4
        DC.W    $7DCF               ; $271AE6 MOVE.W  A7,<EA:3E>
        MOVEQ   #-$25,D6                        ; $271AE8
        DC.W    $7BE1               ; $271AEA MOVE.W  -(A1),<EA:3D>
        MOVEQ   #-$1E,D5                        ; $271AEC
        MOVEQ   #-$1D,D5                        ; $271AEE
        MOVEQ   #-$1D,D5                        ; $271AF0
        MOVEQ   #-$1F,D5                        ; $271AF2
        MOVEQ   #-$20,D5                        ; $271AF4
        DC.W    $7BDE               ; $271AF6 MOVE.W  (A6)+,<EA:3D>
        MOVEQ   #-$25,D6                        ; $271AF8
        DC.W    $7DCF               ; $271AFA MOVE.W  A7,<EA:3E>
        MOVEQ   #-$40,D7                        ; $271AFC
        OR.L   -$57(A4,A0.W),D0                 ; $271AFE
        OR.L   D1,(A0)+                         ; $271B02
        OR.L   D5,D2                            ; $271B04
        OR.W   D2,$60(A2,A0.W)                  ; $271B06
        OR.W   D2,A2                            ; $271B0A
        OR.B   D2,$26(A5,A0.W)                  ; $271B0C
        OR.B   -(A2),D2                         ; $271B10
        OR.B   -(A7),D1                         ; $271B12
        OR.B   $43(A4,D7.L),D0                  ; $271B14
        MOVE.W  A5,$7D54(A6)                    ; $271B18
        MOVE.W  (A3)+,$7C64(A6)                 ; $271B1C
        MOVEQ   #$6D,D6                         ; $271B20
        MOVE.W  -$7E(A7,D7.L),$7A8B(A5)         ; $271B22
        MOVEQ   #-$76,D5                        ; $271B28
        MOVEQ   #-$7E,D6                        ; $271B2A
        DC.W    $7D7D,$7C7D         ; $271B2C MOVE.W  <EA:3D>,$7C7D(A6)
        MOVEQ   #-$7F,D6                        ; $271B30
        MOVEQ   #-$7E,D6                        ; $271B32
        MOVEQ   #$7D,D7                         ; $271B34
        MOVE.W  $6C(A3,D7.L),$7F6A(A7)          ; $271B36
        OR.W   -$7F99(A1),D0                    ; $271B3C
        OR.W   -(A3),D0                         ; $271B40
        OR.W   (A3)+,D0                         ; $271B42
        OR.W   D0,A6                            ; $271B44
        OR.W   D1,D5                            ; $271B46
        OR.W   D1,D2                            ; $271B48
        DC.W    $853E               ; $271B4A OR.B   D2,<EA:3E>
        OR.W   D2,D2                            ; $271B4C
        OR.W   A7,D2                            ; $271B4E
        OR.W   D1,(A0)+                         ; $271B50
        OR.W   D1,(A1)+                         ; $271B52
        OR.W   -(A1),D2                         ; $271B54
        OR.W   -$7C89(A4),D2                    ; $271B56
        OR.L   D5,D1                            ; $271B5A
        OR.L   (A3),D1                          ; $271B5C
        OR.L   -(A0),D1                         ; $271B5E
        OR.L   -$7C49(A3),D1                    ; $271B60
        DIVS    D1,D1                           ; $271B64
        DIVU    A4,D1                           ; $271B66
        DIVS    (A4),D0                         ; $271B68
        DC.W    $7FD2               ; $271B6A MOVE.W  (A2),<EA:3F>
        MOVEQ   #-$39,D7                        ; $271B6C
        DC.W    $7DC2               ; $271B6E MOVE.W  D2,<EA:3E>
        DC.W    $7BC1               ; $271B70 MOVE.W  D1,<EA:3D>
        MOVEQ   #-$40,D5                        ; $271B72
        MOVEQ   #-$44,D5                        ; $271B74
        MOVE.W  $7AB4.W,-$52(A5,D7.L)           ; $271B76
        MOVEQ   #-$5B,D5                        ; $271B7C
        MOVEQ   #-$66,D5                        ; $271B7E
        MOVE.W  (A0),-$7B(A5,D7.L)              ; $271B80
        DC.W    $7D79,$7F6E,$8066,$8160; $271B84 MOVE.W  $7F6E8066,-$7EA0(A6)
        OR.W   (A4)+,D1                         ; $271B8C
        OR.W   D1,(A6)                          ; $271B8E
        OR.W   (A2),D2                          ; $271B90
        OR.W   A7,D2                            ; $271B92
        OR.W   A4,D2                            ; $271B94
        OR.W   (A2),D2                          ; $271B96
        OR.W   D1,-(A2)                         ; $271B98
        OR.W   D0,-$7C(A5,D7.L)                 ; $271B9A
        MOVE.W  A1,-$75(A7,D7.L)                ; $271B9E
        MOVE.W  A3,-$72(A7,D7.L)                ; $271BA2
        MOVEQ   #-$6E,D7                        ; $271BA6
        MOVEQ   #-$66,D6                        ; $271BA8
        MOVE.W  -(A6),-$4C(A5,D7.L)             ; $271BAA
        MOVEQ   #-$48,D5                        ; $271BAE
        MOVEQ   #-$49,D5                        ; $271BB0
        MOVEQ   #-$4B,D5                        ; $271BB2
        MOVEQ   #-$51,D5                        ; $271BB4
        MOVEQ   #-$5D,D5                        ; $271BB6
        MOVEQ   #-$6C,D5                        ; $271BB8
        MOVE.W  D5,$7A(A5,D7.L)                 ; $271BBA
        MOVE.W  $7D56(A2),$7F44(A5)             ; $271BBE
        OR.B   $2E(A7,D7.L),D0                  ; $271BC4
        MOVE.W  -(A5),-(A7)                     ; $271BC8
        OR.B   -(A0),D0                         ; $271BCA
        OR.B   (A7)+,D1                         ; $271BCC
        OR.B   D1,-(A0)                         ; $271BCE
        OR.B   -(A0),D2                         ; $271BD0
        OR.B   D2,-(A2)                         ; $271BD2
        OR.B   D2,-(A3)                         ; $271BD4
        OR.B   D2,-(A4)                         ; $271BD6
        OR.B   D2,-(A7)                         ; $271BD8
        OR.B   D2,$39(A0,A0.W)                  ; $271BDA
        OR.W   D2,D5                            ; $271BDE
        OR.W   (A6),D2                          ; $271BE0
        OR.W   D1,-(A3)                         ; $271BE2
        OR.W   D1,-$7B8D(A3)                    ; $271BE4
        OR.W   D1,#$8384                        ; $271BE8
        OR.L   D1,A2                            ; $271BEC
        OR.L   D1,(A1)                          ; $271BEE
        OR.L   D1,(A2)+                         ; $271BF0
        OR.L   -$7F46(A1),D1                    ; $271BF2
        DC.W    $7FC7               ; $271BF6 MOVE.W  D7,<EA:3F>
        DC.W    $7FCF               ; $271BF8 MOVE.W  A7,<EA:3F>
        MOVEQ   #-$2E,D7                        ; $271BFA
        DC.W    $7DD4               ; $271BFC MOVE.W  (A4),<EA:3E>
        DC.W    $7BD6               ; $271BFE MOVE.W  (A6),<EA:3D>
        DC.W    $7BD5               ; $271C00 MOVE.W  (A5),<EA:3D>
        MOVEQ   #-$2F,D5                        ; $271C02
        MOVEQ   #-$34,D5                        ; $271C04
        MOVEQ   #-$37,D5                        ; $271C06
        DC.W    $7BC6               ; $271C08 MOVE.W  D6,<EA:3D>
        DC.W    $7BC6               ; $271C0A MOVE.W  D6,<EA:3D>
        MOVEQ   #-$37,D6                        ; $271C0C
        MOVEQ   #-$37,D6                        ; $271C0E
        DC.W    $7DC2               ; $271C10 MOVE.W  D2,<EA:3E>
        MOVE.W  -$56(A6,A0.W),-$5E(A7,A0.W)     ; $271C12
        OR.L   D0,(A7)+                         ; $271C18
        OR.L   D0,(A6)+                         ; $271C1A
        OR.L   (A5)+,D1                         ; $271C1C
        OR.L   (A3)+,D1                         ; $271C1E
        OR.L   (A1)+,D1                         ; $271C20
        OR.L   (A2),D1                          ; $271C22
        OR.L   D0,A0                            ; $271C24
        OR.L   D0,D1                            ; $271C26
        OR.L   D0,D0                            ; $271C28
        MOVEQ   #-$7E,D7                        ; $271C2A
        MOVEQ   #-$77,D7                        ; $271C2C
        MOVEQ   #-$73,D7                        ; $271C2E
        MOVE.W  A6,-$70(A6,D7.L)                ; $271C30
        MOVEQ   #-$6D,D6                        ; $271C34
        MOVE.W  (A6),-$6A(A5,D7.L)              ; $271C36
        MOVEQ   #-$6B,D5                        ; $271C3A
        MOVEQ   #-$6C,D5                        ; $271C3C
        MOVE.W  (A3),-$71(A4,D7.L)              ; $271C3E
        MOVE.W  D5,$78(A5,D7.L)                 ; $271C42
        MOVEQ   #$68,D7                         ; $271C46
        MOVE.W  (A7),$7F49(A7)                  ; $271C48
        MOVE.W  D3,$7F3F(A7)                    ; $271C4C
        MOVE.W  $80338133,-(A7)                 ; $271C50
        OR.B   D0,$2B(A3,A0.W)                  ; $271C56
        OR.B   -(A1),D2                         ; $271C5A
        OR.B   (A7)+,D2                         ; $271C5C
        OR.B   (A7)+,D2                         ; $271C5E
        OR.B   (A6)+,D2                         ; $271C60
        OR.B   D2,(A7)+                         ; $271C62
        OR.B   D2,-(A0)                         ; $271C64
        OR.B   -(A1),D3                         ; $271C66
        OR.B   D2,-(A3)                         ; $271C68
        OR.B   D2,-(A4)                         ; $271C6A
        OR.B   D2,-$7BBE(A1)                    ; $271C6C
        OR.W   -(A2),D1                         ; $271C70
        DC.W    $817D               ; $271C72 OR.W   D0,<EA:3D>
        OR.L   D0,(A0)                          ; $271C74
        OR.L   (A6)+,D0                         ; $271C76
        OR.L   $7FB7(A3),D0                     ; $271C78
        MOVEQ   #-$3A,D7                        ; $271C7C
        DC.W    $7DD5               ; $271C7E MOVE.W  (A5),<EA:3E>
        MOVEQ   #-$22,D6                        ; $271C80
        DC.W    $7BE0               ; $271C82 MOVE.W  -(A0),<EA:3D>
        DC.W    $7BE1               ; $271C84 MOVE.W  -(A1),<EA:3D>
        DC.W    $7BE1               ; $271C86 MOVE.W  -(A1),<EA:3D>
        DC.W    $7BDF               ; $271C88 MOVE.W  (A7)+,<EA:3D>
        DC.W    $7BDE               ; $271C8A MOVE.W  (A6)+,<EA:3D>
        MOVEQ   #-$24,D6                        ; $271C8C
        MOVEQ   #-$29,D6                        ; $271C8E
        DC.W    $7DCC               ; $271C90 MOVE.W  A4,<EA:3E>
        DC.W    $7DC4               ; $271C92 MOVE.W  D4,<EA:3E>
        DC.W    $7DBE,$7DB9         ; $271C94 MOVE.W  <EA:3E>,-$47(A6,D7.L)
        MOVE.W  -$4D(A6,D7.L),-$50(A6,D7.L)     ; $271C98
        OR.L   -(A7),D0                         ; $271C9E
        OR.L   D0,(A1)+                         ; $271CA0
        OR.L   A1,D1                            ; $271CA2
        OR.W   $826C.W,D1                       ; $271CA4
        OR.W   -(A6),D1                         ; $271CA8
        OR.W   -(A2),D1                         ; $271CAA
        OR.W   D0,(A7)                          ; $271CAC
        OR.W   D0,A4                            ; $271CAE
        OR.W   D0,A2                            ; $271CB0
        OR.W   A5,D0                            ; $271CB2
        MOVE.W  A5,$7E4A(A7)                    ; $271CB4
        MOVEQ   #$48,D7                         ; $271CB8
        MOVEQ   #$4A,D7                         ; $271CBA
        MOVE.W  (A1),$7C5B(A6)                  ; $271CBC
        MOVEQ   #$63,D6                         ; $271CC0
        MOVE.W  $7B70(A4),$7B6C(A5)             ; $271CC2
        MOVE.W  -(A5),$7B62(A5)                 ; $271CC8
        MOVEQ   #$64,D5                         ; $271CCC
        MOVEQ   #$69,D5                         ; $271CCE
        MOVEQ   #$6E,D5                         ; $271CD0
        MOVE.W  $7D67(A6),$7E60(A5)             ; $271CD2
        MOVE.W  (A5)+,-$7FA5(A7)                ; $271CD8
        OR.W   (A0)+,D0                         ; $271CDC
        OR.W   (A7),D0                          ; $271CDE
        OR.W   D0,(A0)+                         ; $271CE0
        OR.W   (A3),D1                          ; $271CE2
        OR.W   D1,D4                            ; $271CE4
        OR.B   $29(A1,A0.W),D2                  ; $271CE6
        OR.B   -(A6),D2                         ; $271CEA
        OR.B   D1,-(A4)                         ; $271CEC
        OR.B   D1,-(A5)                         ; $271CEE
        OR.B   D2,-$79D5(A2)                    ; $271CF0
        OR.B   -$79D4(A1),D3                    ; $271CF4
        OR.B   D2,$834E.W                       ; $271CF8
        OR.W   D0,-$6D(A0,A0.W)                 ; $271CFC
        MOVE.W  -$3A(A3,D7.L),-$2B(A7,D7.L)     ; $271D00
        DC.W    $7FE1               ; $271D06 MOVE.W  -(A1),<EA:3F>
        MOVEQ   #-$1A,D7                        ; $271D08
        DC.W    $7DE6               ; $271D0A MOVE.W  -(A6),<EA:3E>
        DC.W    $7DE5               ; $271D0C MOVE.W  -(A5),<EA:3E>
        DC.W    $7DE4               ; $271D0E MOVE.W  -(A4),<EA:3E>
        MOVEQ   #-$1D,D6                        ; $271D10
        DC.W    $7BE1               ; $271D12 MOVE.W  -(A1),<EA:3D>
        DC.W    $7BE0               ; $271D14 MOVE.W  -(A0),<EA:3D>
        DC.W    $7BDF               ; $271D16 MOVE.W  (A7)+,<EA:3D>
        DC.W    $7BDD               ; $271D18 MOVE.W  (A5)+,<EA:3D>
        DC.W    $7BDC               ; $271D1A MOVE.W  (A4)+,<EA:3D>
        MOVEQ   #-$25,D5                        ; $271D1C
        MOVEQ   #-$26,D5                        ; $271D1E
        DC.W    $7BD6               ; $271D20 MOVE.W  (A6),<EA:3D>
        MOVEQ   #-$33,D6                        ; $271D22
        MOVEQ   #-$36,D6                        ; $271D24
        MOVEQ   #-$35,D7                        ; $271D26
        DC.W    $7FC8               ; $271D28 MOVE.W  A0,<EA:3F>
        DC.W    $7FBF,$7FB4         ; $271D2A MOVE.W  <EA:3F>,-$4C(A7,D7.L)
        OR.L   -(A4),D0                         ; $271D2E
        OR.L   A7,D0                            ; $271D30
        OR.W   $6D(PC,A0.W),D1                  ; $271D32
        OR.W   (A1)+,D1                         ; $271D36
        OR.B   -$7DDD(PC),D1                    ; $271D38
        OR.B   (A4)+,D0                         ; $271D3C
        MOVEQ   #$1C,D7                         ; $271D3E
        MOVE.W  -(A6),-(A6)                     ; $271D40
        MOVEQ   #$2F,D6                         ; $271D42
        MOVEQ   #$30,D6                         ; $271D44
        MOVEQ   #$33,D6                         ; $271D46
        MOVE.W  $7B3F(PC),-(A5)                 ; $271D48
        MOVE.W  D0,$7C45(A5)                    ; $271D4C
        MOVE.W  (A0),$7A5A(A5)                  ; $271D50
        MOVEQ   #$60,D6                         ; $271D54
        MOVEQ   #$61,D7                         ; $271D56
        MOVEQ   #$63,D7                         ; $271D58
        MOVE.W  $7D73(A2),$7E76(A6)             ; $271D5A
        OR.W   $77(A6,A0.W),D0                  ; $271D60
        OR.W   $68(A3,A0.W),D0                  ; $271D64
        OR.W   (A2)+,D1                         ; $271D68
        OR.W   (A1),D1                          ; $271D6A
        OR.W   A5,D1                            ; $271D6C
        OR.W   A2,D1                            ; $271D6E
        OR.W   D6,D1                            ; $271D70
        OR.W   D0,D1                            ; $271D72
        OR.B   $822F.W,D1                       ; $271D74
        OR.B   D0,-$7DD8(A2)                    ; $271D78
        OR.B   D1,-$7CD7(A0)                    ; $271D7C
        OR.B   D1,-$7CC9(A3)                    ; $271D80
        OR.W   D0,A3                            ; $271D84
        MOVE.W  (A7)+,$7E71(A7)                 ; $271D86
        MOVEQ   #$7C,D7                         ; $271D8A
        MOVE.W  D4,-$6E(A7,A0.W)                ; $271D8C
        OR.L   D0,$7FC7(A3)                     ; $271D90
        MOVEQ   #-$25,D7                        ; $271D94
        MOVEQ   #-$1D,D7                        ; $271D96
        MOVEQ   #-$19,D7                        ; $271D98
        MOVEQ   #-$18,D7                        ; $271D9A
        MOVEQ   #-$18,D7                        ; $271D9C
        DC.W    $7DE6               ; $271D9E MOVE.W  -(A6),<EA:3E>
        MOVEQ   #-$1C,D6                        ; $271DA0
        MOVEQ   #-$1D,D6                        ; $271DA2
        MOVEQ   #-$1F,D6                        ; $271DA4
        MOVEQ   #-$21,D6                        ; $271DA6
        DC.W    $7BDC               ; $271DA8 MOVE.W  (A4)+,<EA:3D>
        DC.W    $7BDC               ; $271DAA MOVE.W  (A4)+,<EA:3D>
        DC.W    $7BDB               ; $271DAC MOVE.W  (A3)+,<EA:3D>
        DC.W    $7BD3               ; $271DAE MOVE.W  (A3),<EA:3D>
        MOVEQ   #-$3D,D6                        ; $271DB0
        MOVEQ   #-$53,D7                        ; $271DB2
        MOVE.W  (A4)+,-$69(A7,D7.L)             ; $271DB4
        MOVE.W  (A7),-$6B(A7,D7.L)              ; $271DB8
        OR.L   (A2),D0                          ; $271DBC
        OR.L   (A2),D0                          ; $271DBE
        MOVEQ   #-$6A,D7                        ; $271DC0
        MOVEQ   #-$68,D7                        ; $271DC2
        MOVEQ   #-$6C,D7                        ; $271DC4
        MOVEQ   #-$76,D7                        ; $271DC6
        MOVEQ   #$7F,D7                         ; $271DC8
        MOVEQ   #$73,D7                         ; $271DCA
        MOVEQ   #$6B,D7                         ; $271DCC
        MOVEQ   #$6A,D7                         ; $271DCE
        MOVE.W  $75(A1,D7.L),$7B75(A6)          ; $271DD0
        MOVE.W  $7B65(A7),$7C5F(A5)             ; $271DD6
        MOVEQ   #$5E,D6                         ; $271DDC
        MOVE.W  -(A0),$7C61(A5)                 ; $271DDE
        MOVE.W  -(A3),$7D68(A6)                 ; $271DE2
        MOVE.W  $7D73(A6),$7D78(A6)             ; $271DE6
        DC.W    $7D79,$7E72,$8066,$8159; $271DEC MOVE.W  $7E728066,-$7EA7(A6)
        OR.W   A6,D1                            ; $271DF4
        OR.W   D4,D1                            ; $271DF6
        DC.W    $823F               ; $271DF8 OR.B   <EA:3F>,D1
        OR.B   #$8236,D1                        ; $271DFA
        OR.B   -$7CDD(A1),D1                    ; $271DFE
        OR.B   D1,-(A2)                         ; $271E02
        OR.B   D1,-(A2)                         ; $271E04
        OR.B   -(A2),D1                         ; $271E06
        OR.B   D0,-(A3)                         ; $271E08
        OR.B   -(A4),D1                         ; $271E0A
        OR.B   -(A5),D1                         ; $271E0C
        OR.B   -(A6),D1                         ; $271E0E
        OR.B   D0,-$7ED5(A0)                    ; $271E10
        OR.B   -$7DCB(A4),D1                    ; $271E14
        OR.W   D0,A0                            ; $271E18
        MOVE.W  (A7)+,$7F73(A7)                 ; $271E1A
        MOVE.W  A4,-$5E(A7,D7.L)                ; $271E1E
        MOVEQ   #-$49,D7                        ; $271E22
        DC.W    $7DC9               ; $271E24 MOVE.W  A1,<EA:3E>
        DC.W    $7DDA               ; $271E26 MOVE.W  (A2)+,<EA:3E>
        MOVEQ   #-$1C,D6                        ; $271E28
        DC.W    $7BE7               ; $271E2A MOVE.W  -(A7),<EA:3D>
        MOVEQ   #-$19,D5                        ; $271E2C
        MOVEQ   #-$19,D5                        ; $271E2E
        MOVEQ   #-$1B,D5                        ; $271E30
        MOVEQ   #-$1C,D5                        ; $271E32
        MOVEQ   #-$1E,D5                        ; $271E34
        DC.W    $7BE1               ; $271E36 MOVE.W  -(A1),<EA:3D>
        DC.W    $7DDD               ; $271E38 MOVE.W  (A5)+,<EA:3E>
        DC.W    $7FCF               ; $271E3A MOVE.W  A7,<EA:3F>
        DC.W    $80BE               ; $271E3C OR.L   <EA:3E>,D0
        OR.L   -$57(A2,A0.W),D0                 ; $271E3E
        OR.L   -(A2),D0                         ; $271E42
        OR.L   (A5)+,D0                         ; $271E44
        OR.L   D0,(A1)+                         ; $271E46
        OR.L   D0,(A7)                          ; $271E48
        OR.L   (A6),D0                          ; $271E4A
        MOVE.W  (A7),-$68(A7,D7.L)              ; $271E4C
        MOVEQ   #-$6B,D7                        ; $271E50
        MOVEQ   #-$6E,D7                        ; $271E52
        MOVE.W  (A3),-$68(A6,D7.L)              ; $271E54
        MOVEQ   #-$67,D6                        ; $271E58
        MOVE.W  (A4),-$74(A6,D7.L)              ; $271E5A
        MOVE.W  D5,$7F(A6,D7.L)                 ; $271E5E
        MOVEQ   #$7A,D6                         ; $271E62
        MOVEQ   #$74,D6                         ; $271E64
        MOVEQ   #$69,D6                         ; $271E66
        MOVE.W  (A3)+,$7E51(A6)                 ; $271E68
        MOVEQ   #$51,D7                         ; $271E6C
        MOVE.W  (A2)+,$7D61(A6)                 ; $271E6E
        MOVEQ   #$61,D7                         ; $271E72
        MOVE.W  -(A1),$7F60(A7)                 ; $271E74
        OR.W   (A3)+,D0                         ; $271E78
        OR.W   (A3),D1                          ; $271E7A
        OR.W   D1,A7                            ; $271E7C
        OR.W   (A1),D1                          ; $271E7E
        OR.W   D0,(A1)+                         ; $271E80
        OR.W   D0,(A6)+                         ; $271E82
        OR.W   (A6)+,D1                         ; $271E84
        OR.W   D1,(A4)+                         ; $271E86
        OR.W   (A6),D2                          ; $271E88
        OR.W   D1,A6                            ; $271E8A
        OR.W   A0,D1                            ; $271E8C
        OR.W   D0,A0                            ; $271E8E
        OR.W   A5,D0                            ; $271E90
        MOVE.W  A1,-$7FC9(A7)                   ; $271E92
        OR.B   D0,-$7ED8(A3)                    ; $271E96
        OR.B   D0,-(A7)                         ; $271E9A
        OR.B   -(A7),D0                         ; $271E9C
        MOVE.W  $49(A2,D7.L),-(A7)              ; $271E9E
        MOVE.W  (A3)+,$7F6C(A7)                 ; $271EA2
        DC.W    $7F7F,$7F91         ; $271EA6 MOVE.W  <EA:3F>,$7F91(A7)
        OR.L   -(A3),D0                         ; $271EAA
        OR.L   -$41(A2,D7.L),D0                 ; $271EAC
        DC.W    $7FCA               ; $271EB0 MOVE.W  A2,<EA:3F>
        DC.W    $7FD8               ; $271EB2 MOVE.W  (A0)+,<EA:3F>
        DC.W    $7DE0               ; $271EB4 MOVE.W  -(A0),<EA:3E>
        MOVEQ   #-$1E,D6                        ; $271EB6
        DC.W    $7BE2               ; $271EB8 MOVE.W  -(A2),<EA:3D>
        DC.W    $7BE2               ; $271EBA MOVE.W  -(A2),<EA:3D>
        DC.W    $7BE1               ; $271EBC MOVE.W  -(A1),<EA:3D>
        DC.W    $7BDF               ; $271EBE MOVE.W  (A7)+,<EA:3D>
        MOVEQ   #-$23,D6                        ; $271EC0
        MOVEQ   #-$2A,D7                        ; $271EC2
        DC.W    $7FC2               ; $271EC4 MOVE.W  D2,<EA:3F>
        OR.L   -$7F5C(A7),D0                    ; $271EC6
        OR.L   D0,(A6)+                         ; $271ECA
        OR.L   D0,(A5)+                         ; $271ECC
        OR.L   D0,(A5)+                         ; $271ECE
        OR.L   D0,(A4)+                         ; $271ED0
        OR.L   D0,(A3)+                         ; $271ED2
        MOVE.W  -(A1),-$56(A7,D7.L)             ; $271ED4
        MOVEQ   #-$53,D6                        ; $271ED8
        MOVEQ   #-$57,D6                        ; $271EDA
        MOVEQ   #-$64,D6                        ; $271EDC
        MOVEQ   #-$73,D6                        ; $271EDE
        MOVEQ   #-$7F,D6                        ; $271EE0
        DC.W    $7D79,$7E70,$7E66,$7F59; $271EE2 MOVE.W  $7E707E66,$7F59(A6)
        MOVEQ   #$4B,D7                         ; $271EEA
        MOVEQ   #$3F,D7                         ; $271EEC
        MOVE.W  $7C36.W,-(A6)                   ; $271EEE
        MOVEQ   #$37,D6                         ; $271EF2
        MOVEQ   #$35,D6                         ; $271EF4
        MOVEQ   #$33,D6                         ; $271EF6
        MOVE.W  $7E45.W,-(A6)                   ; $271EF8
        MOVEQ   #$53,D7                         ; $271EFC
        MOVE.W  -(A0),-$7F9A(A7)                ; $271EFE
        OR.W   D0,-(A5)                         ; $271F02
        OR.W   D0,-(A4)                         ; $271F04
        OR.W   D0,-(A4)                         ; $271F06
        OR.W   D0,-(A0)                         ; $271F08
        OR.W   D1,(A0)+                         ; $271F0A
        OR.W   D2,A7                            ; $271F0C
        OR.W   D2,D5                            ; $271F0E
        OR.B   D2,$37(PC,A0.W)                  ; $271F10
        OR.B   D1,$35(A7,A0.W)                  ; $271F14
        OR.B   $7F2B(A7),D0                     ; $271F18
        MOVE.W  $7F28(A0),-(A7)                 ; $271F1C
        MOVE.W  $7E2B(A0),-(A7)                 ; $271F20
        MOVEQ   #$30,D7                         ; $271F24
        MOVEQ   #$37,D7                         ; $271F26
        MOVE.W  D2,-$7FB1(A7)                   ; $271F28
        OR.W   (A4)+,D0                         ; $271F2C
        OR.W   -$7F8C(A1),D0                    ; $271F2E
        MOVE.W  D1,-$6E(A7,D7.L)                ; $271F32
        MOVE.W  -(A3),-$4E(A7,D7.L)             ; $271F36
        DC.W    $7FBE,$7FCB         ; $271F3A MOVE.W  <EA:3E>,-$35(A7,D7.L)
        MOVEQ   #-$27,D7                        ; $271F3E
        DC.W    $7DE4               ; $271F40 MOVE.W  -(A4),<EA:3E>
        DC.W    $7DE6               ; $271F42 MOVE.W  -(A6),<EA:3E>
        MOVEQ   #-$19,D6                        ; $271F44
        MOVEQ   #-$19,D6                        ; $271F46
        MOVEQ   #-$1A,D6                        ; $271F48
        MOVEQ   #-$1C,D6                        ; $271F4A
        DC.W    $7DE3               ; $271F4C MOVE.W  -(A3),<EA:3E>
        DC.W    $7DE1               ; $271F4E MOVE.W  -(A1),<EA:3E>
        DC.W    $7DDC               ; $271F50 MOVE.W  (A4)+,<EA:3E>
        DC.W    $7DD2               ; $271F52 MOVE.W  (A2),<EA:3E>
        DC.W    $7DCC               ; $271F54 MOVE.W  A4,<EA:3E>
        DC.W    $7DCF               ; $271F56 MOVE.W  A7,<EA:3E>
        DC.W    $7DD5               ; $271F58 MOVE.W  (A5),<EA:3E>
        DC.W    $7DD7               ; $271F5A MOVE.W  (A7),<EA:3E>
        DC.W    $7DD6               ; $271F5C MOVE.W  (A6),<EA:3E>
        MOVEQ   #-$30,D7                        ; $271F5E
        MOVEQ   #-$38,D7                        ; $271F60
        MOVEQ   #-$3B,D7                        ; $271F62
        DC.W    $7DCB               ; $271F64 MOVE.W  A3,<EA:3E>
        MOVEQ   #-$2F,D6                        ; $271F66
        DC.W    $7BD1               ; $271F68 MOVE.W  (A1),<EA:3D>
        MOVEQ   #-$31,D6                        ; $271F6A
        DC.W    $7DC6               ; $271F6C MOVE.W  D6,<EA:3E>
        MOVEQ   #-$4A,D7                        ; $271F6E
        MOVE.W  -(A2),-$76(A7,A0.W)             ; $271F70
        OR.W   -$7EB8(A0),D0                    ; $271F74
        OR.B   D0,$2E(A4,D7.L)                  ; $271F78
        MOVEQ   #$2F,D7                         ; $271F7C
        MOVE.W  -$7FD4(A6),-(A7)                ; $271F7E
        OR.B   -$7FD4(A2),D0                    ; $271F82
        OR.B   $40(A6,A0.W),D0                  ; $271F86
        OR.W   D0,D1                            ; $271F8A
        OR.W   D0,D1                            ; $271F8C
        OR.W   D0,D2                            ; $271F8E
        OR.W   D0,D0                            ; $271F90
        OR.B   D0,$822F822A                     ; $271F92
        OR.B   D0,-$7FD3(A3)                    ; $271F98
        MOVE.W  $7F30(A6),-(A7)                 ; $271F9C
        MOVE.W  $3D(A6,D7.L),-(A7)              ; $271FA0
        MOVE.W  D2,$7D46(A6)                    ; $271FA4
        MOVEQ   #$47,D6                         ; $271FA8
        MOVEQ   #$44,D6                         ; $271FAA
        MOVEQ   #$3D,D6                         ; $271FAC
        MOVE.W  $3D(PC,D7.L),-(A6)              ; $271FAE
        DC.W    $7F3E               ; $271FB2 MOVE.W  <EA:3E>,-(A7)
        DC.W    $803D               ; $271FB4 OR.B   <EA:3D>,D0
        OR.B   #$833D,D1                        ; $271FB6
        OR.W   D1,D3                            ; $271FBA
        OR.W   D1,(A1)                          ; $271FBC
        OR.W   -(A3),D1                         ; $271FBE
        OR.W   D0,-$76(A6,A0.W)                 ; $271FC0
        OR.L   -(A1),D0                         ; $271FC4
        MOVE.W  -$35(A7,D7.L),-$29(A7,D7.L)     ; $271FC6
        MOVEQ   #-$22,D7                        ; $271FCC
        MOVEQ   #-$1C,D7                        ; $271FCE
        DC.W    $7DE7               ; $271FD0 MOVE.W  -(A7),<EA:3E>
        DC.W    $7BE7               ; $271FD2 MOVE.W  -(A7),<EA:3D>
        MOVEQ   #-$1A,D5                        ; $271FD4
        DC.W    $7BE4               ; $271FD6 MOVE.W  -(A4),<EA:3D>
        MOVEQ   #-$1E,D6                        ; $271FD8
        DC.W    $7DD7               ; $271FDA MOVE.W  (A7),<EA:3E>
        MOVEQ   #-$37,D7                        ; $271FDC
        MOVEQ   #-$47,D7                        ; $271FDE
        MOVEQ   #-$54,D7                        ; $271FE0
        MOVEQ   #-$5A,D7                        ; $271FE2
        MOVE.W  $7CAA(A0),-$58(A6,D7.L)         ; $271FE4
        MOVEQ   #-$57,D7                        ; $271FEA
        MOVEQ   #-$4E,D7                        ; $271FEC
        DC.W    $7DC0               ; $271FEE MOVE.W  D0,<EA:3E>
        MOVEQ   #-$35,D6                        ; $271FF0
        DC.W    $7DD1               ; $271FF2 MOVE.W  (A1),<EA:3E>
        DC.W    $7DD4               ; $271FF4 MOVE.W  (A4),<EA:3E>
        DC.W    $7DD2               ; $271FF6 MOVE.W  (A2),<EA:3E>
        MOVEQ   #-$33,D7                        ; $271FF8
        MOVEQ   #-$41,D7                        ; $271FFA
        MOVE.W  $7F99(A1),-$6F(A7,D7.L)         ; $271FFC
        MOVE.W  D7,$74(A6,D7.L)                 ; $272002
        MOVE.W  (A5)+,$7F50(A7)                 ; $272006
        MOVEQ   #$4A,D7                         ; $27200A
        MOVEQ   #$44,D7                         ; $27200C
        MOVE.W  -$7FCF(PC),-(A7)                ; $27200E
        OR.B   D0,-$7ED4(A4)                    ; $272012
        OR.B   D0,-$7CD3(A7)                    ; $272016
        OR.B   -(A7),D2                         ; $27201A
        OR.B   -(A2),D2                         ; $27201C
        OR.B   D1,-(A0)                         ; $27201E
        OR.B   -(A0),D1                         ; $272020
        OR.B   D0,-(A3)                         ; $272022
        OR.B   $42(A2,D7.L),D0                  ; $272024
        MOVEQ   #$49,D7                         ; $272028
        MOVE.W  A5,$7F51(A7)                    ; $27202A
        MOVEQ   #$55,D7                         ; $27202E
        MOVE.W  (A3)+,$7C66(A6)                 ; $272030
        MOVE.W  $6E(A1,D7.L),$7E5C(A5)          ; $272034
        OR.W   A1,D0                            ; $27203A
        OR.W   D2,D1                            ; $27203C
        OR.W   D4,D1                            ; $27203E
        OR.W   D5,D1                            ; $272040
        OR.W   D1,A1                            ; $272042
        OR.W   (A6),D2                          ; $272044
        OR.W   D1,-$7C83(A2)                    ; $272046
        OR.L   A2,D1                            ; $27204A
        OR.L   (A7),D1                          ; $27204C
        OR.L   D0,-(A3)                         ; $27204E
        MOVE.W  $7FB6(A7),-$45(A7,D7.L)         ; $272050
        DC.W    $7FC2               ; $272056 MOVE.W  D2,<EA:3F>
        MOVEQ   #-$33,D7                        ; $272058
        DC.W    $7DD6               ; $27205A MOVE.W  (A6),<EA:3E>
        MOVEQ   #-$23,D6                        ; $27205C
        MOVEQ   #-$20,D6                        ; $27205E
        MOVEQ   #-$25,D6                        ; $272060
        MOVEQ   #-$2F,D6                        ; $272062
        DC.W    $7DC5               ; $272064 MOVE.W  D5,<EA:3E>
        MOVEQ   #-$4A,D7                        ; $272066
        MOVE.W  -(A7),-$64(A7,A0.W)             ; $272068
        OR.L   (A6),D0                          ; $27206C
        OR.L   A7,D0                            ; $27206E
        OR.L   A5,D0                            ; $272070
        OR.L   D0,(A2)                          ; $272072
        OR.L   (A0)+,D0                         ; $272074
        MOVE.W  (A5)+,-$5E(A7,D7.L)             ; $272076
        MOVEQ   #-$57,D7                        ; $27207A
        MOVE.W  -$3F(A4,D7.L),-$33(A6,D7.L)     ; $27207C
        DC.W    $7DD1               ; $272082 MOVE.W  (A1),<EA:3E>
        MOVEQ   #-$32,D7                        ; $272084
        DC.W    $7FC8               ; $272086 MOVE.W  A0,<EA:3F>
        DC.W    $7FBD,$7FB1         ; $272088 MOVE.W  <EA:3D>,-$4F(A7,D7.L)
        MOVE.W  -(A1),-$74(A7,D7.L)             ; $27208C
        MOVEQ   #$7D,D7                         ; $272090
        MOVEQ   #$75,D7                         ; $272092
        MOVEQ   #$6D,D7                         ; $272094
        MOVE.W  -(A1),-$7EAC(A7)                ; $272096
        OR.W   D0,A1                            ; $27209A
        DC.W    $813E               ; $27209C OR.B   D0,<EA:3E>
        OR.B   $27(A4,A0.W),D1                  ; $27209E
        OR.B   (A6)+,D2                         ; $2720A2
        OR.B   D1,(A3)+                         ; $2720A4
        OR.B   (A3)+,D1                         ; $2720A6
        OR.B   D0,(A5)+                         ; $2720A8
        OR.B   $7F32(A0),D0                     ; $2720AA
        MOVEQ   #$3D,D7                         ; $2720AE
        MOVE.W  A2,$7C56(A6)                    ; $2720B0
        MOVE.W  (A6)+,$7B61(A5)                 ; $2720B4
        MOVE.W  -(A2),$7B65(A5)                 ; $2720B8
        MOVE.W  $7B6E(A2),$7C6F(A5)             ; $2720BC
        MOVE.W  $7F65(A5),-$7FA5(A6)            ; $2720C2
        OR.W   (A3),D0                          ; $2720C8
        OR.W   A7,D0                            ; $2720CA
        OR.W   A0,D0                            ; $2720CC
        OR.W   D0,D1                            ; $2720CE
        OR.B   $822E.W,D1                       ; $2720D0
        OR.B   -$7DCF(A3),D1                    ; $2720D4
        OR.W   D0,D3                            ; $2720D8
        MOVE.W  -(A0),$7F81(A7)                 ; $2720DA
        MOVEQ   #-$5C,D7                        ; $2720DE
        MOVEQ   #-$3F,D7                        ; $2720E0
        MOVEQ   #-$28,D7                        ; $2720E2
        MOVEQ   #-$1F,D7                        ; $2720E4
        MOVEQ   #-$1C,D7                        ; $2720E6
        DC.W    $7FDE               ; $2720E8 MOVE.W  (A6)+,<EA:3F>
        MOVEQ   #-$2E,D7                        ; $2720EA
        MOVEQ   #-$41,D7                        ; $2720EC
        MOVEQ   #-$4C,D7                        ; $2720EE
        MOVE.W  -$46(A4,D7.L),-$47(A6,D7.L)     ; $2720F0
        OR.L   -$5A(A1,A0.W),D0                 ; $2720F6
        OR.L   (A6)+,D1                         ; $2720FA
        OR.L   D0,(A6)+                         ; $2720FC
        OR.L   -(A6),D0                         ; $2720FE
        MOVE.W  -$7F50(A5),-$4C(A7,A0.W)        ; $272100
        OR.L   #$81CA7ED4,D1                    ; $272106
        MOVEQ   #-$2B,D6                        ; $27210C
        DC.W    $7BD7               ; $27210E MOVE.W  (A7),<EA:3D>
        MOVEQ   #-$29,D6                        ; $272110
        DC.W    $7DD6               ; $272112 MOVE.W  (A6),<EA:3E>
        DC.W    $7FD3               ; $272114 MOVE.W  (A3),<EA:3F>
        DIVU    D7,D0                           ; $272116
        OR.L   -$64(A1,D7.L),D0                 ; $272118
        MOVEQ   #-$73,D7                        ; $27211C
        MOVEQ   #-$7E,D7                        ; $27211E
        MOVEQ   #$6D,D7                         ; $272120
        MOVE.W  (A4),-$7FBB(A7)                 ; $272122
        OR.W   D1,D0                            ; $272126
        DC.W    $803D               ; $272128 OR.B   <EA:3D>,D0
        OR.B   $2B(A6,A0.W),D0                  ; $27212A
        OR.B   -(A0),D1                         ; $27212E
        OR.B   D0,(A3)+                         ; $272130
        OR.B   D0,(A2)+                         ; $272132
        OR.B   (A2)+,D0                         ; $272134
        OR.B   (A4)+,D0                         ; $272136
        MOVE.W  -(A2),-(A7)                     ; $272138
        MOVE.W  $3F(A0,D7.L),-(A6)              ; $27213A
        MOVEQ   #$49,D6                         ; $27213E
        MOVEQ   #$50,D6                         ; $272140
        MOVEQ   #$56,D6                         ; $272142
        MOVE.W  (A6),$7D54(A6)                  ; $272144
        MOVEQ   #$4F,D7                         ; $272148
        MOVEQ   #$49,D7                         ; $27214A
        MOVE.W  D7,-$7FBB(A7)                   ; $27214C
        OR.W   D1,D0                            ; $272150
        OR.B   D0,$31(PC,A0.W)                  ; $272152
        OR.B   -$7CD7(A2),D1                    ; $272156
        OR.B   D1,-$7CD7(A1)                    ; $27215A
        OR.B   D1,-$7DD3(A2)                    ; $27215E
        DC.W    $803F               ; $272162 OR.B   <EA:3F>,D0
        OR.W   (A5)+,D0                         ; $272164
        OR.W   D0,-$7A(A5,A0.W)                 ; $272166
        MOVE.W  (A0)+,-$54(A7,D7.L)             ; $27216A
        DC.W    $7DC1               ; $27216E MOVE.W  D1,<EA:3E>
        MOVEQ   #-$2D,D6                        ; $272170
        DC.W    $7DDF               ; $272172 MOVE.W  (A7)+,<EA:3E>
        DC.W    $7DE5               ; $272174 MOVE.W  -(A5),<EA:3E>
        MOVEQ   #-$1B,D7                        ; $272176
        DC.W    $7FE3               ; $272178 MOVE.W  -(A3),<EA:3F>
        DC.W    $7FE0               ; $27217A MOVE.W  -(A0),<EA:3F>
        DC.W    $7FDA               ; $27217C MOVE.W  (A2)+,<EA:3F>
        DIVU    (A1),D0                         ; $27217E
        DIVU    D6,D0                           ; $272180
        DC.W    $81BE               ; $272182 OR.L   D0,<EA:3E>
        OR.L   D0,-$7F48(PC)                    ; $272184
        OR.L   #$80C480CA,D0                    ; $272188
        DIVU    A6,D0                           ; $27218E
        DIVS    (A3),D0                         ; $272190
        DIVU    (A0)+,D0                        ; $272192
        DC.W    $7FD9               ; $272194 MOVE.W  (A1)+,<EA:3F>
        MOVEQ   #-$28,D7                        ; $272196
        MOVEQ   #-$28,D7                        ; $272198
        DC.W    $7DD7               ; $27219A MOVE.W  (A7),<EA:3E>
        DC.W    $7DD5               ; $27219C MOVE.W  (A5),<EA:3E>
        DC.W    $7DD4               ; $27219E MOVE.W  (A4),<EA:3E>
        DC.W    $7DD3               ; $2721A0 MOVE.W  (A3),<EA:3E>
        DC.W    $7DD1               ; $2721A2 MOVE.W  (A1),<EA:3E>
        MOVEQ   #-$35,D7                        ; $2721A4
        MOVE.W  -$68(A2,D7.L),-$7A(A7,A0.W)     ; $2721A6
        MOVE.W  $57(A2,A0.W),-$7EC4(A7)         ; $2721AC
        OR.B   D0,$2E(A1,A0.W)                  ; $2721B2
        OR.B   -$7EDC(A2),D0                    ; $2721B6
        OR.B   D0,(A6)+                         ; $2721BA
        OR.B   D0,(A3)+                         ; $2721BC
        MOVE.W  (A3)+,-(A7)                     ; $2721BE
        MOVE.W  (A1)+,-(A7)                     ; $2721C0
        MOVEQ   #$19,D7                         ; $2721C2
        MOVEQ   #$1B,D7                         ; $2721C4
        MOVEQ   #$20,D6                         ; $2721C6
        MOVEQ   #$27,D6                         ; $2721C8
        MOVE.W  $7E35(A6),-(A6)                 ; $2721CA
        MOVEQ   #$37,D7                         ; $2721CE
        MOVEQ   #$37,D7                         ; $2721D0
        MOVE.W  $7F38.W,-(A7)                   ; $2721D2
        MOVE.W  $37(A7,A0.W),-(A7)              ; $2721D6
        OR.B   D0,$813C8042                     ; $2721DA
        MOVE.W  A2,$7F52(A7)                    ; $2721E0
        OR.W   (A6),D0                          ; $2721E4
        OR.W   D0,(A7)                          ; $2721E6
        OR.W   D0,(A6)                          ; $2721E8
        OR.W   (A7),D0                          ; $2721EA
        OR.W   (A1)+,D0                         ; $2721EC
        OR.W   D0,(A4)+                         ; $2721EE
        OR.W   D0,-(A6)                         ; $2721F0
        OR.W   D0,-$73(A7,A0.W)                 ; $2721F2
        MOVE.W  -(A7),-$3F(A7,D7.L)             ; $2721F6
        DC.W    $7FCF               ; $2721FA MOVE.W  A7,<EA:3F>
        DIVU    (A7),D0                         ; $2721FC
        DIVS    (A6),D0                         ; $2721FE
