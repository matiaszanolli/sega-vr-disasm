; Generated assembly for $272200-$274200
; Branch targets: 0
; Labels: 0
; Format: DC.W with decoded mnemonics as comments

        org     $272200

        DIVS    A6,D0                           ; $272200
        DIVS    A1,D0                           ; $272202
        DIVS    A0,D0                           ; $272204
        DIVU    A1,D0                           ; $272206
        DIVU    D7,D0                           ; $272208
        DIVS    D3,D0                           ; $27220A
        DC.W    $81BD               ; $27220C OR.L   D0,<EA:3D>
        OR.L   D0,-$50(A6,A0.W)                 ; $27220E
        OR.L   D0,-$7E55(A5)                    ; $272212
        OR.L   D0,-(A3)                         ; $272216
        OR.L   D0,(A1)+                         ; $272218
        OR.L   D0,(A7)                          ; $27221A
        OR.L   -(A0),D0                         ; $27221C
        MOVE.W  $7EBB(A6),-$39(A7,D7.L)         ; $27221E
        MOVEQ   #-$32,D6                        ; $272224
        DC.W    $7BD3               ; $272226 MOVE.W  (A3),<EA:3D>
        DC.W    $7BD7               ; $272228 MOVE.W  (A7),<EA:3D>
        MOVEQ   #-$29,D5                        ; $27222A
        DC.W    $7BD6               ; $27222C MOVE.W  (A6),<EA:3D>
        DC.W    $7BD5               ; $27222E MOVE.W  (A5),<EA:3D>
        DC.W    $7BD3               ; $272230 MOVE.W  (A3),<EA:3D>
        MOVEQ   #-$36,D6                        ; $272232
        DC.W    $7DBE,$7DB6         ; $272234 MOVE.W  <EA:3E>,-$4A(A6,D7.L)
        MOVE.W  -(A5),-$73(A6,D7.L)             ; $272238
        MOVE.W  $70(PC,D7.L),$7F66(A7)          ; $27223C
        OR.W   (A1)+,D0                         ; $272242
        OR.W   D0,A4                            ; $272244
        OR.W   D1,D0                            ; $272246
        OR.B   $7F2C801E,D0                     ; $272248
        OR.B   (A1)+,D0                         ; $27224E
        OR.B   D0,(A7)                          ; $272250
        OR.B   (A7),D0                          ; $272252
        OR.B   D0,(A7)                          ; $272254
        OR.B   (A0)+,D1                         ; $272256
        OR.B   D0,(A2)+                         ; $272258
        OR.B   D0,(A3)+                         ; $27225A
        MOVE.W  (A5)+,-(A7)                     ; $27225C
        MOVEQ   #$1E,D7                         ; $27225E
        MOVEQ   #$21,D7                         ; $272260
        MOVEQ   #$2D,D7                         ; $272262
        MOVEQ   #$3D,D7                         ; $272264
        MOVE.W  A4,$7D58(A6)                    ; $272266
        MOVE.W  (A7)+,$7E5E(A6)                 ; $27226A
        MOVEQ   #$57,D7                         ; $27226E
        MOVE.W  A7,$7F49(A7)                    ; $272270
        MOVE.W  D2,-$7FC2(A7)                   ; $272274
        OR.W   D0,D1                            ; $272278
        OR.W   D0,A0                            ; $27227A
        OR.W   (A1)+,D0                         ; $27227C
        OR.W   -$75(A3,A0.W),D0                 ; $27227E
        OR.L   D0,(A3)+                         ; $272282
        OR.L   -(A7),D1                         ; $272284
        OR.L   D1,-$7C54(A4)                    ; $272286
        OR.L   -$7D57(A1),D1                    ; $27228A
        OR.L   -$7D4E(A6),D1                    ; $27228E
        OR.L   -$47(A6,A0.W),D1                 ; $272292
        OR.L   -$7E46(PC),D1                    ; $272296
        OR.L   #$80BF80C0,D0                    ; $27229A
        DC.W    $81BD               ; $2722A0 OR.L   D0,<EA:3D>
        OR.L   D0,-$42(PC,A0.W)                 ; $2722A2
        DC.W    $7FC3               ; $2722A6 MOVE.W  D3,<EA:3F>
        DC.W    $7FC6               ; $2722A8 MOVE.W  D6,<EA:3F>
        DC.W    $7FC5               ; $2722AA MOVE.W  D5,<EA:3F>
        DIVU    D1,D0                           ; $2722AC
        MOVEQ   #-$40,D7                        ; $2722AE
        DC.W    $7DC6               ; $2722B0 MOVE.W  D6,<EA:3E>
        MOVEQ   #-$30,D6                        ; $2722B2
        DC.W    $7BD3               ; $2722B4 MOVE.W  (A3),<EA:3D>
        MOVEQ   #-$2C,D6                        ; $2722B6
        MOVEQ   #-$2C,D7                        ; $2722B8
        MOVEQ   #-$2C,D7                        ; $2722BA
        DC.W    $7FD3               ; $2722BC MOVE.W  (A3),<EA:3F>
        MOVEQ   #-$2F,D7                        ; $2722BE
        MOVEQ   #-$31,D7                        ; $2722C0
        DC.W    $7DCF               ; $2722C2 MOVE.W  A7,<EA:3E>
        DC.W    $7DCE               ; $2722C4 MOVE.W  A6,<EA:3E>
        DC.W    $7DCA               ; $2722C6 MOVE.W  A2,<EA:3E>
        DC.W    $7DC1               ; $2722C8 MOVE.W  D1,<EA:3E>
        MOVEQ   #-$4D,D7                        ; $2722CA
        MOVEQ   #-$5C,D7                        ; $2722CC
        MOVEQ   #-$6A,D7                        ; $2722CE
        MOVE.W  D5,$6E(A6,D7.L)                 ; $2722D0
        MOVEQ   #$53,D7                         ; $2722D4
        MOVE.W  $1D(A6,A0.W),-(A7)              ; $2722D6
        OR.B   D0,(A4)                          ; $2722DA
        OR.B   D1,(A0)                          ; $2722DC
        OR.B   D1,A6                            ; $2722DE
        OR.B   D1,A7                            ; $2722E0
        OR.B   (A0),D1                          ; $2722E2
        OR.B   D0,(A2)                          ; $2722E4
        OR.B   (A4),D0                          ; $2722E6
        OR.B   (A5),D0                          ; $2722E8
        MOVE.W  (A7),-(A7)                      ; $2722EA
        MOVEQ   #$18,D7                         ; $2722EC
        MOVE.W  (A3)+,-(A6)                     ; $2722EE
        MOVE.W  -(A5),-(A6)                     ; $2722F0
        MOVEQ   #$30,D6                         ; $2722F2
        MOVEQ   #$3C,D6                         ; $2722F4
        MOVE.W  A4,$7B5D(A5)                    ; $2722F6
        MOVEQ   #$69,D6                         ; $2722FA
        MOVE.W  $7F6F(A5),$7F73(A6)             ; $2722FC
        OR.W   $81828284,D0                     ; $272302
        OR.W   D1,$65(A7,A0.W)                  ; $272308
        OR.W   D1,(A3)+                         ; $27230C
        OR.W   D1,(A7)+                         ; $27230E
        OR.W   -$7D8A(A0),D1                    ; $272310
        OR.L   D1,D7                            ; $272314
        OR.L   D1,(A0)+                         ; $272316
        OR.L   -(A5),D1                         ; $272318
        OR.L   -$7E57(A4),D1                    ; $27231A
        OR.L   D0,-(A2)                         ; $27231E
        OR.L   D0,(A4)+                         ; $272320
        OR.L   (A0)+,D0                         ; $272322
        MOVE.W  (A0)+,-$63(A7,D7.L)             ; $272324
        MOVE.W  -(A1),-$5F(A7,D7.L)             ; $272328
        OR.L   (A7)+,D0                         ; $27232C
        OR.L   (A5)+,D0                         ; $27232E
        OR.L   D0,(A3)+                         ; $272330
        OR.L   D0,(A3)+                         ; $272332
        OR.L   (A2)+,D0                         ; $272334
        OR.L   (A6),D0                          ; $272336
        OR.L   (A1),D0                          ; $272338
        MOVE.W  A6,-$6E(A7,D7.L)                ; $27233A
        MOVEQ   #-$64,D7                        ; $27233E
        MOVEQ   #-$58,D7                        ; $272340
        MOVEQ   #-$4B,D7                        ; $272342
        MOVEQ   #-$3D,D7                        ; $272344
        DC.W    $7DCF               ; $272346 MOVE.W  A7,<EA:3E>
        MOVEQ   #-$2E,D6                        ; $272348
        MOVEQ   #-$2C,D6                        ; $27234A
        MOVEQ   #-$2C,D6                        ; $27234C
        MOVEQ   #-$2D,D6                        ; $27234E
        DC.W    $7BD2               ; $272350 MOVE.W  (A2),<EA:3D>
        MOVEQ   #-$30,D5                        ; $272352
        MOVE.W  A7,#$7ACD                       ; $272354
        DC.W    $7BC6               ; $272358 MOVE.W  D6,<EA:3D>
        MOVEQ   #-$4A,D6                        ; $27235A
        MOVEQ   #-$5C,D6                        ; $27235C
        MOVE.W  A4,$6C(A6,D7.L)                 ; $27235E
        OR.W   D0,A2                            ; $272362
        OR.B   -$7DE8(A0),D1                    ; $272364
        OR.B   D1,(A2)                          ; $272368
        OR.B   A7,D1                            ; $27236A
        OR.B   D0,A6                            ; $27236C
        MOVE.W  (A0),-(A7)                      ; $27236E
        MOVEQ   #$12,D7                         ; $272370
        MOVE.W  (A4),-(A7)                      ; $272372
        MOVE.W  (A5),-(A7)                      ; $272374
        MOVEQ   #$17,D7                         ; $272376
        MOVE.W  (A3)+,-(A6)                     ; $272378
        MOVEQ   #$28,D6                         ; $27237A
        MOVEQ   #$34,D6                         ; $27237C
        DC.W    $7D3D               ; $27237E MOVE.W  <EA:3D>,-(A6)
        MOVEQ   #$45,D7                         ; $272380
        MOVEQ   #$4D,D7                         ; $272382
        MOVE.W  (A5),$7D5A(A6)                  ; $272384
        MOVEQ   #$5C,D7                         ; $272388
        MOVE.W  (A4)+,-$7EA5(A7)                ; $27238A
        OR.W   D0,(A5)+                         ; $27238E
        OR.W   -(A5),D1                         ; $272390
        OR.W   -$7D9C(A1),D1                    ; $272392
        OR.W   D1,(A6)+                         ; $272396
        OR.W   D1,-(A0)                         ; $272398
        OR.W   D1,-$7C94(A0)                    ; $27239A
        OR.W   -$7A97(A2),D2                    ; $27239E
        OR.W   $7E(A2,A0.W),D2                  ; $2723A2
        OR.L   D0,D7                            ; $2723A6
        OR.L   D0,A5                            ; $2723A8
        OR.L   D0,(A2)                          ; $2723AA
        OR.L   (A6),D0                          ; $2723AC
        MOVE.W  (A3)+,-$5E(A7,D7.L)             ; $2723AE
        OR.L   -(A7),D0                         ; $2723B2
        MOVE.W  $7FA7(A0),-$5B(A7,A0.W)         ; $2723B4
        OR.L   -(A1),D0                         ; $2723BA
        OR.L   D0,(A4)+                         ; $2723BC
        OR.L   D0,(A1)+                         ; $2723BE
        OR.L   D0,(A2)                          ; $2723C0
        OR.L   A2,D1                            ; $2723C2
        OR.L   D5,D1                            ; $2723C4
        OR.L   D0,D0                            ; $2723C6
        OR.L   D6,D0                            ; $2723C8
        MOVE.W  (A4)+,-$4A(A7,D7.L)             ; $2723CA
        MOVEQ   #-$36,D6                        ; $2723CE
        MOVEQ   #-$2D,D6                        ; $2723D0
        MOVEQ   #-$29,D6                        ; $2723D2
        MOVEQ   #-$27,D6                        ; $2723D4
        MOVEQ   #-$27,D6                        ; $2723D6
        DC.W    $7BD8               ; $2723D8 MOVE.W  (A0)+,<EA:3D>
        MOVEQ   #-$2A,D5                        ; $2723DA
        MOVEQ   #-$2B,D5                        ; $2723DC
        DC.W    $7BD3               ; $2723DE MOVE.W  (A3),<EA:3D>
        MOVEQ   #-$2E,D5                        ; $2723E0
        MOVEQ   #-$30,D5                        ; $2723E2
        DC.W    $7BCD               ; $2723E4 MOVE.W  A5,<EA:3D>
        DC.W    $7DBD,$7E9E         ; $2723E6 MOVE.W  <EA:3D>,-$62(A6,D7.L)
        DC.W    $7F7F,$7F66         ; $2723EA MOVE.W  <EA:3F>,$7F66(A7)
        MOVE.W  A7,$7F38(A7)                    ; $2723EE
        OR.B   -(A4),D0                         ; $2723F2
        MOVE.W  (A0)+,-(A7)                     ; $2723F4
        MOVEQ   #$14,D7                         ; $2723F6
        MOVEQ   #$13,D7                         ; $2723F8
        MOVEQ   #$13,D7                         ; $2723FA
        MOVEQ   #$14,D7                         ; $2723FC
        MOVEQ   #$16,D7                         ; $2723FE
        MOVEQ   #$18,D7                         ; $272400
        MOVE.W  (A2)+,-(A6)                     ; $272402
        MOVEQ   #$22,D6                         ; $272404
        MOVEQ   #$28,D6                         ; $272406
        MOVE.W  -(A6),-(A6)                     ; $272408
        MOVEQ   #$23,D7                         ; $27240A
        MOVEQ   #$24,D7                         ; $27240C
        MOVE.W  -$7FD0(A1),-(A7)                ; $27240E
        OR.B   $8141.W,D0                       ; $272412
        OR.W   D0,D5                            ; $272416
        OR.W   D0,D4                            ; $272418
        OR.W   D1,D1                            ; $27241A
        OR.W   D1,D0                            ; $27241C
        OR.W   D3,D2                            ; $27241E
        OR.W   D2,A5                            ; $272420
        OR.W   (A0)+,D3                         ; $272422
        OR.W   (A7)+,D3                         ; $272424
        OR.W   (A7)+,D3                         ; $272426
        OR.W   D2,-(A1)                         ; $272428
        OR.W   -$7C88(A3),D2                    ; $27242A
        OR.L   D6,D1                            ; $27242E
        OR.L   (A6),D1                          ; $272430
        OR.L   -(A3),D1                         ; $272432
        OR.L   D0,-$7E4F(A3)                    ; $272434
        OR.L   D0,-$4B(A5,A0.W)                 ; $272438
        OR.L   -$4B(A3,A0.W),D0                 ; $27243C
        OR.L   D0,-$4D(A5,A0.W)                 ; $272440
        OR.L   -$4A(A3,A0.W),D0                 ; $272444
        MOVE.W  $7FBC(PC),-$43(A7,D7.L)         ; $272448
        DC.W    $7FC0               ; $27244E MOVE.W  D0,<EA:3F>
        DC.W    $7FC3               ; $272450 MOVE.W  D3,<EA:3F>
        MOVEQ   #-$40,D7                        ; $272452
        MOVEQ   #-$45,D7                        ; $272454
        MOVEQ   #-$48,D7                        ; $272456
        DC.W    $7DBD,$7BC7         ; $272458 MOVE.W  <EA:3D>,-$39(A6,D7.L)
        DC.W    $7BCF               ; $27245C MOVE.W  A7,<EA:3D>
        DC.W    $7BD3               ; $27245E MOVE.W  (A3),<EA:3D>
        DC.W    $7BD3               ; $272460 MOVE.W  (A3),<EA:3D>
        DC.W    $7BD0               ; $272462 MOVE.W  (A0),<EA:3D>
        DC.W    $7BCC               ; $272464 MOVE.W  A4,<EA:3D>
        MOVEQ   #-$33,D5                        ; $272466
        MOVEQ   #-$2F,D5                        ; $272468
        MOVE.W  (A1),#$79D0                     ; $27246A
        MOVEQ   #-$32,D5                        ; $27246E
        MOVEQ   #-$3F,D6                        ; $272470
        MOVEQ   #-$51,D6                        ; $272472
        MOVEQ   #-$60,D6                        ; $272474
        MOVEQ   #-$69,D6                        ; $272476
        MOVEQ   #-$74,D6                        ; $272478
        MOVE.W  $66(PC,D7.L),$7E4E(A6)          ; $27247A
        MOVEQ   #$3D,D7                         ; $272480
        MOVEQ   #$33,D7                         ; $272482
        MOVEQ   #$29,D7                         ; $272484
        MOVEQ   #$1F,D7                         ; $272486
        MOVEQ   #$1A,D7                         ; $272488
        MOVEQ   #$18,D7                         ; $27248A
        MOVE.W  (A6),-(A6)                      ; $27248C
        MOVEQ   #$16,D7                         ; $27248E
        MOVEQ   #$17,D7                         ; $272490
        MOVE.W  (A0)+,-(A7)                     ; $272492
        OR.B   (A1)+,D0                         ; $272494
        OR.B   D0,(A2)+                         ; $272496
        OR.B   D0,(A4)+                         ; $272498
        OR.B   D0,(A5)+                         ; $27249A
        OR.B   D0,(A6)+                         ; $27249C
        OR.B   D0,(A7)+                         ; $27249E
        OR.B   -(A0),D1                         ; $2724A0
        OR.B   D1,-(A2)                         ; $2724A2
        OR.B   D2,-(A5)                         ; $2724A4
        OR.B   -$78D3(A1),D3                    ; $2724A6
        OR.B   -$79D3(A6),D3                    ; $2724AA
        OR.B   -$7AD3(A5),D3                    ; $2724AE
        OR.B   $44(A6,A0.W),D2                  ; $2724B2
        OR.W   D0,(A2)                          ; $2724B6
        OR.W   -(A5),D0                         ; $2724B8
        DC.W    $807F               ; $2724BA OR.W   <EA:3F>,D0
        MOVE.W  (A4)+,-$4F(A7,D7.L)             ; $2724BC
        DC.W    $7FC0               ; $2724C0 MOVE.W  D0,<EA:3F>
        MOVEQ   #-$36,D7                        ; $2724C2
        DC.W    $7DCB               ; $2724C4 MOVE.W  A3,<EA:3E>
        MOVEQ   #-$3B,D7                        ; $2724C6
        MOVE.W  #$7FB2,-$57(A7,A0.W)            ; $2724C8
        MOVE.W  -(A2),-$61(A7,A0.W)             ; $2724CE
        OR.L   D0,(A1)+                         ; $2724D2
        OR.L   (A1),D1                          ; $2724D4
        OR.L   D1,A5                            ; $2724D6
        OR.L   D1,A6                            ; $2724D8
        OR.L   (A1),D1                          ; $2724DA
        OR.L   D0,(A3)                          ; $2724DC
        OR.L   D0,(A6)                          ; $2724DE
        MOVE.W  (A5)+,-$57(A7,D7.L)             ; $2724E0
        MOVEQ   #-$46,D6                        ; $2724E4
        DC.W    $7BCB               ; $2724E6 MOVE.W  A3,<EA:3D>
        MOVEQ   #-$28,D5                        ; $2724E8
        MOVE.W  (A4)+,#$79DE                    ; $2724EA
        MOVE.W  (A6)+,#$7ADD                    ; $2724EE
        MOVEQ   #-$24,D5                        ; $2724F2
        MOVEQ   #-$26,D5                        ; $2724F4
        MOVEQ   #-$27,D5                        ; $2724F6
        MOVEQ   #-$28,D5                        ; $2724F8
        MOVEQ   #-$29,D5                        ; $2724FA
        MOVE.W  (A5),#$7AD4                     ; $2724FC
        MOVEQ   #-$2D,D5                        ; $272500
        DC.W    $7BD2               ; $272502 MOVE.W  (A2),<EA:3D>
        DC.W    $7BD0               ; $272504 MOVE.W  (A0),<EA:3D>
        DC.W    $7BC8               ; $272506 MOVE.W  A0,<EA:3D>
        MOVE.W  #$7EAC,-$69(A6,D7.L)            ; $272508
        DC.W    $817F               ; $27250E OR.W   D0,<EA:3F>
        OR.W   -(A4),D1                         ; $272510
        OR.W   A3,D1                            ; $272512
        OR.B   $21(A4,A0.W),D1                  ; $272514
        OR.B   (A6),D1                          ; $272518
        OR.B   (A3),D1                          ; $27251A
        OR.B   (A2),D1                          ; $27251C
        OR.B   (A3),D1                          ; $27251E
        OR.B   (A4),D1                          ; $272520
        OR.B   (A6),D1                          ; $272522
        OR.B   D0,(A7)                          ; $272524
        OR.B   D0,(A1)+                         ; $272526
        OR.B   (A2)+,D1                         ; $272528
        OR.B   (A3)+,D1                         ; $27252A
        OR.B   D1,(A4)+                         ; $27252C
        OR.B   D1,(A6)+                         ; $27252E
        OR.B   D1,(A7)+                         ; $272530
        OR.B   D1,-(A0)                         ; $272532
        OR.B   D1,-(A1)                         ; $272534
        OR.B   -(A4),D1                         ; $272536
        OR.B   D0,-$7FC7(A5)                    ; $272538
        OR.W   D4,D0                            ; $27253C
        MOVE.W  A6,$7F5D(A7)                    ; $27253E
        MOVEQ   #$6A,D7                         ; $272542
        MOVEQ   #$70,D7                         ; $272544
        MOVE.W  -$7F9F(A3),$7F64(A7)            ; $272546
        MOVEQ   #$75,D7                         ; $27254C
        MOVEQ   #-$78,D7                        ; $27254E
        MOVE.W  (A4)+,-$50(A7,A0.W)             ; $272550
        DC.W    $80BE               ; $272554 OR.L   <EA:3E>,D0
        DIVS    D5,D0                           ; $272556
        DIVU    D4,D1                           ; $272558
        OR.L   D1,-$54(PC,A0.W)                 ; $27255A
        OR.L   (A3)+,D2                         ; $27255E
        OR.L   A4,D2                            ; $272560
        DC.W    $847D               ; $272562 OR.W   <EA:3D>,D2
        OR.W   $7C(A6,A0.W),D2                  ; $272564
        OR.L   A1,D0                            ; $272568
        MOVE.W  (A3),-$6B(A7,D7.L)              ; $27256A
        MOVEQ   #-$70,D7                        ; $27256E
        MOVE.W  A6,-$69(A6,D7.L)                ; $272570
        MOVEQ   #-$55,D4                        ; $272574
        MOVE.W  D1,-$32(PC,D7.L)                ; $272576
        MOVE.W  (A0),#$79D1                     ; $27257A
        MOVE.W  (A1)+,-$25(PC,D7.W)             ; $27257E
        MOVE.W  (A2)+,-$26(PC,D7.L)             ; $272582
        MOVEQ   #-$27,D4                        ; $272586
        MOVEQ   #-$28,D4                        ; $272588
        MOVE.W  (A7),#$7AD6                     ; $27258A
        DC.W    $7BD4               ; $27258E MOVE.W  (A4),<EA:3D>
        DC.W    $7BD3               ; $272590 MOVE.W  (A3),<EA:3D>
        DC.W    $7DCF               ; $272592 MOVE.W  A7,<EA:3E>
        DC.W    $7FBD,$81A5         ; $272594 MOVE.W  <EA:3D>,-$5B(A7,A0.W)
        OR.L   D1,A4                            ; $272598
        OR.W   D1,$8265.W                       ; $27259A
        OR.W   D0,(A7)                          ; $27259E
        OR.W   D0,A4                            ; $2725A0
        DC.W    $813E               ; $2725A2 OR.B   D0,<EA:3E>
        OR.B   -(A6),D1                         ; $2725A4
        OR.B   D1,(A3)+                         ; $2725A6
        OR.B   D2,(A0)+                         ; $2725A8
        OR.B   (A6),D2                          ; $2725AA
        OR.B   (A6),D1                          ; $2725AC
        OR.B   D0,(A7)                          ; $2725AE
        OR.B   D0,(A0)+                         ; $2725B0
        OR.B   D0,(A2)+                         ; $2725B2
        OR.B   D0,(A3)+                         ; $2725B4
        OR.B   D0,(A5)+                         ; $2725B6
        OR.B   (A6)+,D1                         ; $2725B8
        OR.B   (A7)+,D1                         ; $2725BA
        OR.B   -(A3),D1                         ; $2725BC
        OR.B   -$7FD0(A2),D1                    ; $2725BE
        MOVE.W  $7E497D56,-(A7)                 ; $2725C2
        MOVE.W  (A5)+,$7E61(A6)                 ; $2725C8
        MOVEQ   #$66,D7                         ; $2725CC
        MOVEQ   #$6D,D7                         ; $2725CE
        MOVEQ   #$77,D7                         ; $2725D0
        MOVEQ   #$7F,D7                         ; $2725D2
        MOVE.W  D5,-$77(A7,A0.W)                ; $2725D4
        OR.L   D0,A1                            ; $2725D8
        OR.L   D0,A3                            ; $2725DA
        OR.L   D0,(A4)                          ; $2725DC
        OR.L   D0,(A6)+                         ; $2725DE
        OR.L   -(A1),D1                         ; $2725E0
        OR.L   (A5)+,D2                         ; $2725E2
        OR.L   D2,(A1)+                         ; $2725E4
        OR.L   D2,(A2)+                         ; $2725E6
        OR.L   (A5)+,D2                         ; $2725E8
        OR.L   (A6)+,D2                         ; $2725EA
        OR.L   D1,-(A0)                         ; $2725EC
        OR.L   D1,(A7)+                         ; $2725EE
        OR.L   (A4),D1                          ; $2725F0
        OR.L   D7,D1                            ; $2725F2
        OR.L   D0,D0                            ; $2725F4
        MOVE.W  D2,-$7B(A7,D7.L)                ; $2725F6
        MOVE.W  D7,-$78(A6,D7.L)                ; $2725FA
        MOVE.W  (A1),-$5F(A5,D7.L)              ; $2725FE
        MOVEQ   #-$4F,D4                        ; $272602
        MOVEQ   #-$42,D4                        ; $272604
        MOVE.W  D6,#$78CB                       ; $272606
        MOVEQ   #-$31,D4                        ; $27260A
        MOVEQ   #-$2E,D4                        ; $27260C
        MOVE.W  (A4),#$7BD6                     ; $27260E
        DC.W    $7BD8               ; $272612 MOVE.W  (A0)+,<EA:3D>
        DC.W    $7BD8               ; $272614 MOVE.W  (A0)+,<EA:3D>
        MOVEQ   #-$29,D5                        ; $272616
        MOVEQ   #-$2A,D5                        ; $272618
        DC.W    $7BD5               ; $27261A MOVE.W  (A5),<EA:3D>
        MOVEQ   #-$2C,D6                        ; $27261C
        DC.W    $7DD3               ; $27261E MOVE.W  (A3),<EA:3E>
        MOVEQ   #-$2F,D7                        ; $272620
        DC.W    $7FC8               ; $272622 MOVE.W  A0,<EA:3F>
        OR.L   -$63(A6,A0.W),D0                 ; $272624
        DC.W    $807D               ; $272628 OR.W   <EA:3D>,D0
        OR.W   D0,(A5)+                         ; $27262A
        OR.W   D0,D4                            ; $27262C
        OR.B   D0,-$7FE4(A4)                    ; $27262E
        OR.B   (A5),D0                          ; $272632
        OR.B   (A3),D0                          ; $272634
        OR.B   (A3),D1                          ; $272636
        OR.B   D1,(A4)                          ; $272638
        OR.B   D1,(A6)                          ; $27263A
        OR.B   (A0)+,D1                         ; $27263C
        OR.B   D0,(A1)+                         ; $27263E
        OR.B   D0,(A2)+                         ; $272640
        OR.B   D0,(A4)+                         ; $272642
        OR.B   (A5)+,D1                         ; $272644
        OR.B   D0,(A6)+                         ; $272646
        OR.B   D0,(A7)+                         ; $272648
        OR.B   -(A0),D0                         ; $27264A
        OR.B   -(A3),D0                         ; $27264C
        MOVE.W  $7F35(A2),-(A7)                 ; $27264E
        DC.W    $7F3D               ; $272652 MOVE.W  <EA:3D>,-(A7)
        MOVE.W  D6,$7F4C(A7)                    ; $272654
        MOVEQ   #$52,D7                         ; $272658
        MOVE.W  (A3)+,$7F69(A7)                 ; $27265A
        MOVE.W  $7D(A5,A0.W),-$7E7A(A7)         ; $27265E
        OR.L   D0,A4                            ; $272664
        OR.L   D0,A3                            ; $272666
        OR.L   D1,A2                            ; $272668
        OR.L   D1,A7                            ; $27266A
        OR.L   D1,(A0)+                         ; $27266C
        OR.L   D1,-(A1)                         ; $27266E
        OR.L   D1,-(A7)                         ; $272670
        OR.L   D1,-$7C54(A1)                    ; $272672
        OR.L   D1,-$4A(A0,A0.W)                 ; $272676
        OR.L   $81B780B5,D1                     ; $27267A
        MOVE.W  -$4C(A6,D7.L),-$51(A7,D7.L)     ; $272680
        MOVE.W  $7CAD(A3),-$46(A6,D7.L)         ; $272686
        MOVEQ   #-$36,D4                        ; $27268C
        MOVE.W  (A4),-$29(PC,D7.W)              ; $27268E
        MOVE.W  (A2)+,-$26(PC,D7.L)             ; $272692
        MOVE.W  (A1)+,#$7AD5                    ; $272696
        DC.W    $7BCA               ; $27269A MOVE.W  A2,<EA:3D>
        DC.W    $7BBF,$7BBF         ; $27269C MOVE.W  <EA:3F>,-$41(A5,D7.L)
        MOVEQ   #-$39,D5                        ; $2726A0
        MOVEQ   #-$33,D5                        ; $2726A2
        DC.W    $7BCE               ; $2726A4 MOVE.W  A6,<EA:3D>
        DC.W    $7BCF               ; $2726A6 MOVE.W  A7,<EA:3D>
        DC.W    $7BCF               ; $2726A8 MOVE.W  A7,<EA:3D>
        MOVEQ   #-$32,D6                        ; $2726AA
        DC.W    $7DC7               ; $2726AC MOVE.W  D7,<EA:3E>
        DC.W    $7DBD,$7DB2         ; $2726AE MOVE.W  <EA:3D>,-$4E(A6,D7.L)
        MOVEQ   #-$5D,D7                        ; $2726B2
        MOVEQ   #-$6E,D7                        ; $2726B4
        MOVE.W  -$7FA4(PC),-$7EC8(A7)           ; $2726B6
        OR.B   D0,(A6)+                         ; $2726BC
        OR.B   (A4),D1                          ; $2726BE
        OR.B   (A0),D1                          ; $2726C0
        OR.B   D1,A6                            ; $2726C2
        OR.B   A7,D2                            ; $2726C4
        OR.B   D2,(A0)                          ; $2726C6
        OR.B   D2,(A2)                          ; $2726C8
        OR.B   (A4),D2                          ; $2726CA
        OR.B   (A6),D2                          ; $2726CC
        OR.B   D1,(A7)                          ; $2726CE
        OR.B   D1,(A0)+                         ; $2726D0
        OR.B   D0,(A1)+                         ; $2726D2
        OR.B   D0,(A3)+                         ; $2726D4
        OR.B   D0,(A4)+                         ; $2726D6
        OR.B   D0,(A5)+                         ; $2726D8
        OR.B   D0,-(A1)                         ; $2726DA
        OR.B   $7F2F(A2),D0                     ; $2726DC
        OR.B   -$7FD4(A5),D0                    ; $2726E0
        OR.B   $39(A1,D7.L),D0                  ; $2726E4
        MOVE.W  D2,-$7FB6(A7)                   ; $2726E8
        OR.W   D0,A5                            ; $2726EC
        OR.W   A2,D1                            ; $2726EE
        OR.W   D5,D1                            ; $2726F0
        OR.W   A1,D1                            ; $2726F2
        OR.W   D0,(A5)                          ; $2726F4
        OR.W   -$7F7E(A3),D0                    ; $2726F6
        OR.L   (A4),D0                          ; $2726FA
        OR.L   -(A4),D0                         ; $2726FC
        OR.L   D0,-$45(A2,A0.W)                 ; $2726FE
        DC.W    $7FBE,$7FC1         ; $272702 MOVE.W  <EA:3E>,-$3F(A7,D7.L)
        MOVEQ   #-$3D,D7                        ; $272706
        MOVEQ   #-$3C,D7                        ; $272708
        MOVEQ   #-$3C,D7                        ; $27270A
        DC.W    $7DC3               ; $27270C MOVE.W  D3,<EA:3E>
        DC.W    $7DC1               ; $27270E MOVE.W  D1,<EA:3E>
        MOVE.W  -$4D(PC,D7.L),-$52(A6,D7.L)     ; $272710
        MOVEQ   #-$56,D6                        ; $272716
        MOVE.W  -(A5),-$59(A5,D7.L)             ; $272718
        MOVE.W  -$43(A1,D7.L),-$38(A4,D7.L)     ; $27271C
        DC.W    $7BCE               ; $272722 MOVE.W  A6,<EA:3D>
        DC.W    $7DCD               ; $272724 MOVE.W  A5,<EA:3E>
        MOVEQ   #-$39,D7                        ; $272726
        MOVEQ   #-$3D,D7                        ; $272728
        DC.W    $7DC3               ; $27272A MOVE.W  D3,<EA:3E>
        MOVEQ   #-$3A,D6                        ; $27272C
        MOVEQ   #-$33,D6                        ; $27272E
        MOVEQ   #-$2E,D6                        ; $272730
        MOVEQ   #-$2E,D6                        ; $272732
        MOVEQ   #-$2D,D6                        ; $272734
        DC.W    $7DD3               ; $272736 MOVE.W  (A3),<EA:3E>
        DC.W    $7DD2               ; $272738 MOVE.W  (A2),<EA:3E>
        DC.W    $7DD0               ; $27273A MOVE.W  (A0),<EA:3E>
        DC.W    $7DCC               ; $27273C MOVE.W  A4,<EA:3E>
        DC.W    $7DC1               ; $27273E MOVE.W  D1,<EA:3E>
        MOVEQ   #-$48,D7                        ; $272740
        MOVEQ   #-$4F,D7                        ; $272742
        MOVE.W  -(A7),-$6A(A7,A0.W)             ; $272744
        OR.L   D0,D3                            ; $272748
        OR.W   -$7DA6(A7),D1                    ; $27274A
        OR.W   D0,A0                            ; $27274E
        OR.B   $24(A5,A0.W),D1                  ; $272750
        OR.B   (A6),D1                          ; $272754
        OR.B   (A3),D1                          ; $272756
        OR.B   (A1),D1                          ; $272758
        OR.B   (A1),D1                          ; $27275A
        OR.B   D0,(A2)                          ; $27275C
        OR.B   D0,(A4)                          ; $27275E
        OR.B   (A5),D0                          ; $272760
        MOVE.W  (A7),-(A7)                      ; $272762
        MOVEQ   #$18,D7                         ; $272764
        MOVE.W  (A1)+,-(A7)                     ; $272766
        MOVE.W  (A3)+,-(A7)                     ; $272768
        MOVE.W  (A4)+,-(A7)                     ; $27276A
        MOVE.W  (A5)+,-(A7)                     ; $27276C
        MOVE.W  (A7)+,-(A7)                     ; $27276E
        OR.B   -(A4),D0                         ; $272770
        OR.B   -$7EC9(A4),D0                    ; $272772
        OR.W   D0,D6                            ; $272776
        OR.W   (A4),D0                          ; $272778
        OR.W   D0,(A3)+                         ; $27277A
        OR.W   D0,(A6)+                         ; $27277C
        OR.W   D0,(A4)+                         ; $27277E
        OR.W   D0,(A0)+                         ; $272780
        OR.W   A5,D0                            ; $272782
        OR.B   D0,$8038.W                       ; $272784
        MOVEQ   #$56,D7                         ; $272788
        MOVEQ   #$7A,D6                         ; $27278A
        MOVEQ   #-$67,D6                        ; $27278C
        MOVE.W  $7DCA.W,-$31(A6,D7.L)           ; $27278E
        DC.W    $7DCC               ; $272794 MOVE.W  A4,<EA:3E>
        DC.W    $7DC9               ; $272796 MOVE.W  A1,<EA:3E>
        MOVEQ   #-$3B,D7                        ; $272798
        MOVEQ   #-$3F,D7                        ; $27279A
        MOVEQ   #-$42,D7                        ; $27279C
        MOVE.W  $7FB2(PC),-$58(A7,D7.L)         ; $27279E
        MOVE.W  (A7)+,-$6A(A7,D7.L)             ; $2727A4
        MOVE.W  (A0),-$6D(A6,D7.L)              ; $2727A8
        MOVEQ   #-$69,D6                        ; $2727AC
        MOVE.W  (A6)+,-$53(A5,D7.L)             ; $2727AE
        MOVEQ   #-$40,D5                        ; $2727B2
        MOVEQ   #-$36,D5                        ; $2727B4
        DC.W    $7BC7               ; $2727B6 MOVE.W  D7,<EA:3D>
        MOVEQ   #-$40,D6                        ; $2727B8
        MOVEQ   #-$46,D6                        ; $2727BA
        MOVE.W  $7BB9.W,-$42(A5,D7.L)           ; $2727BC
        DC.W    $7BC9               ; $2727C2 MOVE.W  A1,<EA:3D>
        DC.W    $7BD0               ; $2727C4 MOVE.W  (A0),<EA:3D>
        DC.W    $7BD1               ; $2727C6 MOVE.W  (A1),<EA:3D>
        DC.W    $7BD2               ; $2727C8 MOVE.W  (A2),<EA:3D>
        MOVEQ   #-$2E,D6                        ; $2727CA
        MOVEQ   #-$2F,D6                        ; $2727CC
        DC.W    $7DD0               ; $2727CE MOVE.W  (A0),<EA:3E>
        MOVEQ   #-$36,D7                        ; $2727D0
        DC.W    $7FB9,$7F9E,$8086,$8170; $2727D2 MOVE.W  $7F9E8086,$70(A7,A0.W)
        OR.W   D0,(A1)+                         ; $2727DA
        DC.W    $823D               ; $2727DC OR.B   <EA:3D>,D1
        OR.B   D1,-(A5)                         ; $2727DE
        OR.B   D1,(A7)                          ; $2727E0
        OR.B   D1,(A3)                          ; $2727E2
        OR.B   D1,(A1)                          ; $2727E4
        OR.B   D1,(A1)                          ; $2727E6
        OR.B   (A3),D1                          ; $2727E8
        OR.B   D0,(A4)                          ; $2727EA
        OR.B   D0,(A6)                          ; $2727EC
        OR.B   (A0)+,D1                         ; $2727EE
        OR.B   D0,(A1)+                         ; $2727F0
        OR.B   D0,(A2)+                         ; $2727F2
        OR.B   D0,(A3)+                         ; $2727F4
        OR.B   D0,(A5)+                         ; $2727F6
        OR.B   D0,(A6)+                         ; $2727F8
        OR.B   D0,-(A5)                         ; $2727FA
        OR.B   $46(A5,D7.L),D0                  ; $2727FC
        MOVE.W  (A4),$7F61(A7)                  ; $272800
        MOVEQ   #$6D,D7                         ; $272804
        MOVEQ   #$74,D7                         ; $272806
        MOVE.W  $6D(A3,D7.L),$7F64(A7)          ; $272808
        MOVE.W  (A7)+,$7E69(A7)                 ; $27280E
        DC.W    $7D7D,$7D94         ; $272812 MOVE.W  <EA:3D>,$7D94(A6)
        MOVEQ   #-$55,D7                        ; $272816
        MOVEQ   #-$44,D7                        ; $272818
        MOVEQ   #-$38,D7                        ; $27281A
        MOVEQ   #-$30,D7                        ; $27281C
        DC.W    $7DD7               ; $27281E MOVE.W  (A7),<EA:3E>
        DC.W    $7DDD               ; $272820 MOVE.W  (A5)+,<EA:3E>
        MOVEQ   #-$23,D7                        ; $272822
        MOVEQ   #-$25,D7                        ; $272824
        DC.W    $7FD2               ; $272826 MOVE.W  (A2),<EA:3F>
        DIVU    D6,D0                           ; $272828
        OR.L   #$80B280A2,D0                    ; $27282A
        OR.L   D0,A4                            ; $272830
        OR.W   D0,$64(A7,A0.W)                  ; $272832
        MOVEQ   #$5E,D7                         ; $272836
        MOVE.W  -(A6),$7B74(A6)                 ; $272838
        MOVEQ   #$7E,D5                         ; $27283C
        MOVE.W  D6,-$6F(A5,D7.L)                ; $27283E
        MOVEQ   #-$63,D5                        ; $272842
        MOVE.W  $7AB1(A0),-$47(A4,D7.L)         ; $272844
        MOVE.W  #$7BBC,-$3E(A5,D7.L)            ; $27284A
        MOVEQ   #-$34,D5                        ; $272850
        MOVE.W  (A0),#$7AD0                     ; $272852
        DC.W    $7BD1               ; $272856 MOVE.W  (A1),<EA:3D>
        MOVEQ   #-$30,D6                        ; $272858
        MOVEQ   #-$31,D7                        ; $27285A
        DC.W    $7FCD               ; $27285C MOVE.W  A5,<EA:3F>
        DIVU    D4,D0                           ; $27285E
        OR.L   D0,-$7E73(A4)                    ; $272860
        OR.W   D0,-$7EB5(A3)                    ; $272864
        OR.B   D0,$1C(A2,A0.W)                  ; $272868
        OR.B   D0,(A3)                          ; $27286C
        OR.B   (A0),D1                          ; $27286E
        OR.B   (A0),D1                          ; $272870
        OR.B   D0,(A0)                          ; $272872
        OR.B   (A2),D1                          ; $272874
        OR.B   (A4),D1                          ; $272876
        OR.B   (A6),D1                          ; $272878
        OR.B   D0,(A7)                          ; $27287A
        OR.B   (A0)+,D0                         ; $27287C
        OR.B   (A1)+,D0                         ; $27287E
        OR.B   (A3)+,D0                         ; $272880
        MOVE.W  (A4)+,-(A7)                     ; $272882
        MOVE.W  (A7)+,-(A7)                     ; $272884
        MOVE.W  $7E37(A2),-(A7)                 ; $272886
        MOVE.W  $39(PC,D7.L),-(A6)              ; $27288A
        MOVE.W  D0,$7D4F(A6)                    ; $27288E
        MOVE.W  (A1)+,$7F5D(A6)                 ; $272892
        OR.W   -(A2),D0                         ; $272896
        OR.W   D0,-(A6)                         ; $272898
        OR.W   D0,-(A6)                         ; $27289A
        OR.W   D0,-(A2)                         ; $27289C
        OR.W   -(A1),D0                         ; $27289E
        OR.W   -$7F82(A4),D0                    ; $2728A0
        MOVE.W  (A2),-$55(A7,A0.W)              ; $2728A4
        DIVU    D1,D0                           ; $2728A8
        DC.W    $7FD3               ; $2728AA MOVE.W  (A3),<EA:3F>
        DC.W    $7FDD               ; $2728AC MOVE.W  (A5)+,<EA:3F>
        DC.W    $7FE0               ; $2728AE MOVE.W  -(A0),<EA:3F>
        DIVU    -(A1),D0                        ; $2728B0
        DIVS    (A4)+,D0                        ; $2728B2
        DIVS    (A6),D0                         ; $2728B4
        DIVU    (A1),D0                         ; $2728B6
        DIVU    D4,D0                           ; $2728B8
        OR.L   -$7F61(A7),D0                    ; $2728BA
        MOVE.W  (A6),-$71(A7,D7.L)              ; $2728BE
        MOVE.W  A1,-$7D(A6,D7.L)                ; $2728C2
        MOVE.W  A1,-$65(A5,D7.L)                ; $2728C6
        MOVE.W  $77BC(A7),-$3E(A3,D7.L)         ; $2728CA
        DC.W    $7BC3               ; $2728D0 MOVE.W  D3,<EA:3D>
        DC.W    $7BC4               ; $2728D2 MOVE.W  D4,<EA:3D>
        DC.W    $7BC6               ; $2728D4 MOVE.W  D6,<EA:3D>
        DC.W    $7BC6               ; $2728D6 MOVE.W  D6,<EA:3D>
        DC.W    $7BC8               ; $2728D8 MOVE.W  A0,<EA:3D>
        DC.W    $7BCE               ; $2728DA MOVE.W  A6,<EA:3D>
        DC.W    $7BD0               ; $2728DC MOVE.W  (A0),<EA:3D>
        MOVEQ   #-$31,D6                        ; $2728DE
        MOVEQ   #-$31,D7                        ; $2728E0
        MOVEQ   #-$31,D7                        ; $2728E2
        DC.W    $7DCD               ; $2728E4 MOVE.W  A5,<EA:3E>
        MOVEQ   #-$37,D7                        ; $2728E6
        OR.L   $81A2.W,D0                       ; $2728E8
        OR.L   D0,(A3)                          ; $2728EC
        OR.L   A1,D0                            ; $2728EE
        MOVE.W  D2,$73(A7,A0.W)                 ; $2728F0
        OR.W   D0,(A7)+                         ; $2728F4
        OR.W   D0,A0                            ; $2728F6
        OR.B   D0,$1C(A1,A0.W)                  ; $2728F8
        OR.B   D1,(A4)                          ; $2728FC
        OR.B   D1,(A0)                          ; $2728FE
        OR.B   A7,D1                            ; $272900
        OR.B   D0,A7                            ; $272902
        OR.B   (A1),D0                          ; $272904
        OR.B   (A3),D0                          ; $272906
        MOVE.W  (A4),-(A7)                      ; $272908
        MOVE.W  (A6),-(A7)                      ; $27290A
        OR.B   (A7),D0                          ; $27290C
        OR.B   (A0)+,D0                         ; $27290E
        OR.B   D0,(A2)+                         ; $272910
        OR.B   D0,(A3)+                         ; $272912
        OR.B   D0,(A4)+                         ; $272914
        OR.B   D0,(A5)+                         ; $272916
        OR.B   D0,(A7)+                         ; $272918
        OR.B   D0,-(A4)                         ; $27291A
        OR.B   D0,-$7FC4(A7)                    ; $27291C
        OR.W   A0,D0                            ; $272920
        OR.W   (A1),D0                          ; $272922
        OR.W   (A6),D0                          ; $272924
        OR.W   (A4),D0                          ; $272926
        OR.W   A2,D0                            ; $272928
        OR.W   A0,D0                            ; $27292A
        MOVEQ   #$59,D7                         ; $27292C
        MOVEQ   #$73,D6                         ; $27292E
        MOVEQ   #-$71,D6                        ; $272930
        MOVE.W  -(A7),-$43(A6,D7.L)             ; $272932
        DC.W    $7DCD               ; $272936 MOVE.W  A5,<EA:3E>
        MOVEQ   #-$28,D7                        ; $272938
        MOVEQ   #-$29,D7                        ; $27293A
        DC.W    $7FD0               ; $27293C MOVE.W  (A0),<EA:3F>
        DIVU    D5,D0                           ; $27293E
        DC.W    $7FB9,$7FAC,$7F9E,$8092; $272940 MOVE.W  $7FAC7F9E,-$6E(A7,A0.W)
        OR.L   A4,D0                            ; $272948
        OR.L   A2,D0                            ; $27294A
        OR.L   A2,D0                            ; $27294C
        MOVE.W  A4,-$6F(A7,D7.L)                ; $27294E
        MOVEQ   #-$6A,D6                        ; $272952
        MOVE.W  (A4)+,-$5D(A5,D7.L)             ; $272954
        MOVE.W  $7BAE(A0),-$48(A5,D7.L)         ; $272958
        DC.W    $7BBE,$7CBF         ; $27295E MOVE.W  <EA:3E>,-$41(A5,D7.L)
        DC.W    $7DC1               ; $272962 MOVE.W  D1,<EA:3E>
        DC.W    $7DC5               ; $272964 MOVE.W  D5,<EA:3E>
        DC.W    $7DC9               ; $272966 MOVE.W  A1,<EA:3E>
        DC.W    $7DCB               ; $272968 MOVE.W  A3,<EA:3E>
        DC.W    $7DCC               ; $27296A MOVE.W  A4,<EA:3E>
        DC.W    $7DD0               ; $27296C MOVE.W  (A0),<EA:3E>
        DC.W    $7DD2               ; $27296E MOVE.W  (A2),<EA:3E>
        MOVEQ   #-$2F,D7                        ; $272970
        MOVEQ   #-$2F,D7                        ; $272972
        DC.W    $7FD0               ; $272974 MOVE.W  (A0),<EA:3F>
        DC.W    $7FCF               ; $272976 MOVE.W  A7,<EA:3F>
        DC.W    $7FCE               ; $272978 MOVE.W  A6,<EA:3F>
        DC.W    $7FCC               ; $27297A MOVE.W  A4,<EA:3F>
        DIVU    A0,D0                           ; $27297C
        DC.W    $80BE               ; $27297E OR.L   <EA:3E>,D0
        OR.L   -$7F68(A4),D0                    ; $272980
        OR.L   D0,D0                            ; $272984
        OR.W   -(A0),D0                         ; $272986
        OR.W   D0,D0                            ; $272988
        OR.B   D0,-$7EE2(A5)                    ; $27298A
        OR.B   D0,(A3)                          ; $27298E
        OR.B   D0,A7                            ; $272990
        OR.B   A7,D0                            ; $272992
        OR.B   A7,D0                            ; $272994
        OR.B   D0,(A0)                          ; $272996
        OR.B   D0,(A2)                          ; $272998
        OR.B   D0,(A4)                          ; $27299A
        OR.B   (A5),D1                          ; $27299C
        OR.B   D0,(A7)                          ; $27299E
        OR.B   D0,(A0)+                         ; $2729A0
        OR.B   (A1)+,D1                         ; $2729A2
        OR.B   D0,(A2)+                         ; $2729A4
        OR.B   (A3)+,D0                         ; $2729A6
        OR.B   (A5)+,D0                         ; $2729A8
        MOVE.W  (A7)+,-(A7)                     ; $2729AA
        MOVE.W  $7F36(A0),-(A7)                 ; $2729AC
        OR.W   D0,D0                            ; $2729B0
        OR.W   A2,D0                            ; $2729B2
        OR.W   (A5),D0                          ; $2729B4
        OR.W   (A5)+,D0                         ; $2729B6
        MOVE.W  -(A3),$7F61(A7)                 ; $2729B8
        MOVE.W  (A5)+,$7F65(A7)                 ; $2729BC
        MOVE.W  -$6C(PC,D7.L),$7FAE(A7)         ; $2729C0
        DIVU    D2,D0                           ; $2729C6
        DIVU    A7,D0                           ; $2729C8
        DC.W    $7FD6               ; $2729CA MOVE.W  (A6),<EA:3F>
        DC.W    $7FD4               ; $2729CC MOVE.W  (A4),<EA:3F>
        DIVU    A6,D0                           ; $2729CE
        DIVS    D2,D0                           ; $2729D0
        OR.L   D0,-$5D(A1,A0.W)                 ; $2729D2
        OR.L   (A7),D0                          ; $2729D6
        OR.L   A0,D0                            ; $2729D8
        DC.W    $7F79,$7E6F,$7D6E,$7B6F; $2729DA MOVE.W  $7E6F7D6E,$7B6F(A7)
        MOVE.W  -$80(A4,D7.L),$7A90(A5)         ; $2729E2
        MOVEQ   #-$62,D5                        ; $2729E8
        MOVE.W  $7CAE(A1),-$53(A5,D7.L)         ; $2729EA
        MOVE.W  $7DB5(A7),-$44(A6,D7.L)         ; $2729F0
        DC.W    $7DC4               ; $2729F6 MOVE.W  D4,<EA:3E>
        MOVEQ   #-$32,D7                        ; $2729F8
        MOVEQ   #-$2D,D7                        ; $2729FA
        MOVEQ   #-$2C,D7                        ; $2729FC
        MOVEQ   #-$2B,D7                        ; $2729FE
        MOVEQ   #-$2C,D7                        ; $272A00
        DC.W    $7DD3               ; $272A02 MOVE.W  (A3),<EA:3E>
        MOVEQ   #-$2E,D7                        ; $272A04
        MOVEQ   #-$2F,D7                        ; $272A06
        MOVEQ   #-$31,D7                        ; $272A08
        DC.W    $7FCA               ; $272A0A MOVE.W  A2,<EA:3F>
        DC.W    $7FB9,$81A0,$8281,$8363; $272A0C MOVE.W  $81A08281,$63(A7,A0.W)
        OR.W   D1,D6                            ; $272A14
        OR.B   $1D(A0,A0.W),D1                  ; $272A16
        OR.B   (A4),D1                          ; $272A1A
        OR.B   (A1),D1                          ; $272A1C
        OR.B   D1,(A1)                          ; $272A1E
        OR.B   D1,(A2)                          ; $272A20
        OR.B   D1,(A3)                          ; $272A22
        OR.B   D1,(A5)                          ; $272A24
        OR.B   D1,(A7)                          ; $272A26
        OR.B   D1,(A0)+                         ; $272A28
        OR.B   D1,(A1)+                         ; $272A2A
        OR.B   (A2)+,D1                         ; $272A2C
        OR.B   D0,(A4)+                         ; $272A2E
        OR.B   (A5)+,D0                         ; $272A30
        OR.B   -(A2),D0                         ; $272A32
        OR.B   $7F3C(A6),D0                     ; $272A34
        MOVEQ   #$4A,D7                         ; $272A38
        MOVE.W  (A1)+,$7D6A(A6)                 ; $272A3A
        MOVEQ   #$75,D7                         ; $272A3E
        MOVE.W  $8079.W,-$7E82(A7)              ; $272A40
        OR.L   D0,D0                            ; $272A46
        OR.L   D6,D0                            ; $272A48
        MOVE.W  (A3),-$5E(A7,D7.L)              ; $272A4A
        MOVEQ   #-$57,D7                        ; $272A4E
        MOVE.W  $7FA8(A0),-$53(A7,D7.L)         ; $272A50
        MOVE.W  -$42(A6,D7.L),-$41(A7,D7.L)     ; $272A56
        MOVE.W  -$55(A7,D7.L),-$61(A7,D7.L)     ; $272A5C
        MOVE.W  (A3),-$7B(A7,A0.W)              ; $272A62
        OR.W   $806E.W,D0                       ; $272A66
        OR.W   $7F72(A3),D0                     ; $272A6A
        MOVEQ   #$79,D7                         ; $272A6E
        MOVEQ   #$7A,D7                         ; $272A70
        MOVEQ   #$7E,D7                         ; $272A72
        MOVEQ   #-$79,D7                        ; $272A74
        MOVEQ   #-$70,D7                        ; $272A76
        MOVE.W  (A3)+,-$56(A6,D7.L)             ; $272A78
        MOVE.W  $7CC2.W,-$38(A6,D7.L)           ; $272A7C
        DC.W    $7DCD               ; $272A82 MOVE.W  A5,<EA:3E>
        DC.W    $7DD1               ; $272A84 MOVE.W  (A1),<EA:3E>
        DC.W    $7DD4               ; $272A86 MOVE.W  (A4),<EA:3E>
        MOVEQ   #-$2C,D6                        ; $272A88
        MOVEQ   #-$2C,D6                        ; $272A8A
        DC.W    $7DD3               ; $272A8C MOVE.W  (A3),<EA:3E>
        MOVEQ   #-$2E,D7                        ; $272A8E
        DC.W    $7FD1               ; $272A90 MOVE.W  (A1),<EA:3F>
        DIVU    (A0),D0                         ; $272A92
        DIVU    A6,D0                           ; $272A94
        DIVU    D5,D0                           ; $272A96
        OR.L   D0,-$7E71(A2)                    ; $272A98
        OR.W   D0,$8161.W                       ; $272A9C
        OR.W   D6,D0                            ; $272AA0
        OR.B   -$7FE3(A7),D0                    ; $272AA2
        OR.B   (A4),D0                          ; $272AA6
        OR.B   (A2),D0                          ; $272AA8
        OR.B   D0,(A1)                          ; $272AAA
        OR.B   (A2),D0                          ; $272AAC
        OR.B   (A3),D0                          ; $272AAE
        OR.B   (A5),D0                          ; $272AB0
        OR.B   D0,(A6)                          ; $272AB2
        OR.B   D0,(A0)+                         ; $272AB4
        OR.B   D0,(A1)+                         ; $272AB6
        OR.B   D0,(A2)+                         ; $272AB8
        OR.B   (A4)+,D0                         ; $272ABA
        OR.B   (A5)+,D0                         ; $272ABC
        OR.B   (A6)+,D0                         ; $272ABE
        OR.B   D0,(A7)+                         ; $272AC0
        OR.B   D0,-(A2)                         ; $272AC2
        OR.B   D0,-$7FC9(A3)                    ; $272AC4
        OR.W   D4,D0                            ; $272AC8
        OR.W   (A2),D0                          ; $272ACA
        OR.W   -(A2),D0                         ; $272ACC
        OR.W   -$7F8D(A5),D0                    ; $272ACE
        OR.W   $807F8085,D0                     ; $272AD2
        MOVE.W  A7,-$64(A7,D7.L)                ; $272AD8
        MOVE.W  -(A6),-$52(A7,D7.L)             ; $272ADC
        MOVE.W  -$44(A6,D7.L),-$43(A7,D7.L)     ; $272AE0
        OR.L   -$47(PC,A0.W),D0                 ; $272AE6
        OR.L   D0,-$55(A3,A0.W)                 ; $272AEA
        OR.L   D0,-(A5)                         ; $272AEE
        OR.L   D0,(A6)+                         ; $272AF0
        OR.L   D0,(A6)                          ; $272AF2
        OR.L   D0,(A2)                          ; $272AF4
        OR.L   (A5),D0                          ; $272AF6
        MOVEQ   #-$63,D7                        ; $272AF8
        MOVEQ   #-$58,D6                        ; $272AFA
        MOVE.W  -$41(A7,D7.L),-$40(A5,D7.L)     ; $272AFC
        DC.W    $7BC6               ; $272B02 MOVE.W  D6,<EA:3D>
        DC.W    $7BCB               ; $272B04 MOVE.W  A3,<EA:3D>
        DC.W    $7BCA               ; $272B06 MOVE.W  A2,<EA:3D>
        MOVEQ   #-$38,D6                        ; $272B08
        MOVEQ   #-$39,D6                        ; $272B0A
        MOVEQ   #-$3E,D6                        ; $272B0C
        MOVEQ   #-$44,D6                        ; $272B0E
        MOVE.W  $7DB6(PC),-$51(A6,D7.L)         ; $272B10
        OR.L   -(A7),D0                         ; $272B16
        OR.L   -(A0),D0                         ; $272B18
        OR.L   (A6)+,D0                         ; $272B1A
        OR.L   (A6)+,D0                         ; $272B1C
        OR.L   (A4)+,D0                         ; $272B1E
        MOVE.W  (A4)+,-$61(A7,D7.L)             ; $272B20
        MOVEQ   #-$61,D7                        ; $272B24
        MOVE.W  (A3)+,-$6F(A7,A0.W)             ; $272B26
        OR.L   D4,D0                            ; $272B2A
        OR.W   $5E(A4,A0.W),D0                  ; $272B2C
        OR.W   D0,D5                            ; $272B30
        OR.B   D0,-$7EE2(A7)                    ; $272B32
        OR.B   D0,(A5)                          ; $272B36
        OR.B   D0,(A3)                          ; $272B38
        OR.B   D0,(A2)                          ; $272B3A
        OR.B   D0,(A3)                          ; $272B3C
        OR.B   (A5),D1                          ; $272B3E
        OR.B   (A6),D1                          ; $272B40
        OR.B   (A0)+,D1                         ; $272B42
        OR.B   (A1)+,D1                         ; $272B44
        OR.B   (A2)+,D1                         ; $272B46
        OR.B   (A4)+,D1                         ; $272B48
        OR.B   (A5)+,D1                         ; $272B4A
        OR.B   (A6)+,D1                         ; $272B4C
        OR.B   D0,(A7)+                         ; $272B4E
        OR.B   D0,-(A2)                         ; $272B50
        OR.B   -$7FD7(A0),D0                    ; $272B52
        OR.B   $7F34(A3),D0                     ; $272B56
        MOVEQ   #$3F,D7                         ; $272B5A
        MOVEQ   #$49,D7                         ; $272B5C
        MOVEQ   #$53,D7                         ; $272B5E
        MOVEQ   #$58,D7                         ; $272B60
        MOVE.W  (A1)+,$7F5B(A7)                 ; $272B62
        MOVE.W  -(A1),$7F6D(A7)                 ; $272B66
        DC.W    $807F               ; $272B6A OR.W   <EA:3F>,D0
        MOVE.W  (A4),-$5C(A7,D7.L)              ; $272B6C
        MOVE.W  -$45(A2,D7.L),-$41(A7,D7.L)     ; $272B70
        DC.W    $80BD               ; $272B76 OR.L   <EA:3D>,D0
        OR.L   -$4F(A7,A0.W),D0                 ; $272B78
        OR.L   -$7F54(A5),D0                    ; $272B7C
        MOVE.W  $7EB1(A6),-$4A(A7,D7.L)         ; $272B80
        MOVE.W  -$3E(PC,D7.L),-$37(A6,D7.L)     ; $272B86
        MOVEQ   #-$34,D6                        ; $272B8C
        MOVEQ   #-$33,D6                        ; $272B8E
        DC.W    $7DC8               ; $272B90 MOVE.W  A0,<EA:3E>
        MOVEQ   #-$42,D7                        ; $272B92
        MOVE.W  -$4F(A5,D7.L),-$4F(A7,D7.L)     ; $272B94
        MOVE.W  -$51(A0,D7.L),-$4D(A7,D7.L)     ; $272B9A
        MOVEQ   #-$4A,D7                        ; $272BA0
        MOVE.W  -$54(A3,A0.W),-$56(A7,A0.W)     ; $272BA2
        OR.L   $7FB7(A7),D0                     ; $272BA8
        MOVEQ   #-$42,D7                        ; $272BAC
        MOVEQ   #-$3C,D7                        ; $272BAE
        DC.W    $7DC8               ; $272BB0 MOVE.W  A0,<EA:3E>
        DC.W    $7DCB               ; $272BB2 MOVE.W  A3,<EA:3E>
        MOVEQ   #-$35,D6                        ; $272BB4
        MOVEQ   #-$3A,D6                        ; $272BB6
        MOVEQ   #-$43,D7                        ; $272BB8
        MOVE.W  $7F8F(A2),$71(A7,D7.L)          ; $272BBA
        OR.W   (A0)+,D0                         ; $272BC0
        OR.W   D3,D0                            ; $272BC2
        OR.B   $26(A2,A0.W),D0                  ; $272BC4
        OR.B   (A1)+,D1                         ; $272BC8
        OR.B   D1,(A4)                          ; $272BCA
        OR.B   (A3),D2                          ; $272BCC
        OR.B   (A3),D2                          ; $272BCE
        OR.B   (A4),D2                          ; $272BD0
        OR.B   (A5),D2                          ; $272BD2
        OR.B   (A7),D2                          ; $272BD4
        OR.B   (A0)+,D2                         ; $272BD6
        OR.B   D1,(A2)+                         ; $272BD8
        OR.B   (A3)+,D1                         ; $272BDA
        OR.B   (A4)+,D1                         ; $272BDC
        OR.B   D0,(A5)+                         ; $272BDE
        OR.B   (A7)+,D0                         ; $272BE0
        OR.B   -(A4),D0                         ; $272BE2
        MOVE.W  $45(A1,D7.L),-(A7)              ; $272BE4
        MOVE.W  (A0)+,$7D67(A6)                 ; $272BE8
        MOVEQ   #$6E,D7                         ; $272BEC
        MOVE.W  $75(A2,D7.L),$7F79(A7)          ; $272BEE
        DC.W    $7F7E,$7E82         ; $272BF4 MOVE.W  <EA:3E>,$7E82(A7)
        MOVEQ   #-$78,D7                        ; $272BF8
        MOVE.W  (A3),-$60(A6,D7.L)              ; $272BFA
        MOVEQ   #-$56,D6                        ; $272BFE
        MOVE.W  -$3F(A7,D7.L),-$3A(A6,D7.L)     ; $272C00
        DC.W    $7FC9               ; $272C06 MOVE.W  A1,<EA:3F>
        DIVU    D7,D0                           ; $272C08
        DC.W    $80BD               ; $272C0A OR.L   <EA:3D>,D0
        OR.L   D0,-$7E66(A4)                    ; $272C0C
        OR.L   D0,A0                            ; $272C10
        OR.W   $6F(A7,A0.W),D1                  ; $272C12
        OR.W   -$7F(A3,D7.L),D0                 ; $272C16
        MOVEQ   #-$71,D7                        ; $272C1A
        MOVEQ   #-$68,D7                        ; $272C1C
        MOVEQ   #-$5F,D7                        ; $272C1E
        MOVEQ   #-$54,D7                        ; $272C20
        MOVE.W  -$52(A2,D7.L),-$5B(A6,D7.L)     ; $272C22
        MOVE.W  (A6)+,-$62(A7,D7.L)             ; $272C28
        MOVE.W  -(A5),-$52(A6,D7.L)             ; $272C2C
        MOVEQ   #-$4D,D7                        ; $272C30
        MOVEQ   #-$48,D7                        ; $272C32
        MOVEQ   #-$40,D7                        ; $272C34
        MOVEQ   #-$38,D7                        ; $272C36
        DC.W    $7DCF               ; $272C38 MOVE.W  A7,<EA:3E>
        MOVEQ   #-$2F,D6                        ; $272C3A
        MOVEQ   #-$2E,D6                        ; $272C3C
        DC.W    $7BD1               ; $272C3E MOVE.W  (A1),<EA:3D>
        DC.W    $7BCF               ; $272C40 MOVE.W  A7,<EA:3D>
        MOVEQ   #-$37,D6                        ; $272C42
        MOVEQ   #-$3D,D6                        ; $272C44
        MOVE.W  $7EA9.W,-$6C(A6,A0.W)           ; $272C46
        OR.W   D0,#$8262                        ; $272C4C
        OR.W   D6,D1                            ; $272C50
        OR.B   -$7CE6(A6),D1                    ; $272C52
        OR.B   (A4),D2                          ; $272C56
        OR.B   (A1),D2                          ; $272C58
        OR.B   D1,(A0)                          ; $272C5A
        OR.B   (A1),D2                          ; $272C5C
        OR.B   (A3),D2                          ; $272C5E
        OR.B   (A5),D2                          ; $272C60
        OR.B   (A6),D2                          ; $272C62
        OR.B   (A0)+,D2                         ; $272C64
        OR.B   (A1)+,D2                         ; $272C66
        OR.B   (A2)+,D2                         ; $272C68
        OR.B   D1,(A4)+                         ; $272C6A
        OR.B   D0,(A7)+                         ; $272C6C
        MOVEQ   #$32,D7                         ; $272C6E
        MOVE.W  A3,$7D60(A6)                    ; $272C70
        MOVE.W  $7D76(A7),$7D78(A6)             ; $272C74
        MOVE.W  $74(A6,D7.L),$7E74(A6)          ; $272C7A
        MOVE.W  $77(A5,D7.L),$7E79(A6)          ; $272C80
        DC.W    $7D7E,$7D88         ; $272C86 MOVE.W  <EA:3E>,$7D88(A6)
        MOVE.W  A7,-$6F(A6,D7.L)                ; $272C8A
        MOVE.W  (A1)+,-$63(A7,D7.L)             ; $272C8E
        MOVE.W  (A5)+,-$63(A7,A0.W)             ; $272C92
        OR.L   (A3)+,D1                         ; $272C96
        OR.L   (A0)+,D1                         ; $272C98
        OR.L   D1,(A3)                          ; $272C9A
        OR.L   D1,(A3)                          ; $272C9C
        OR.L   (A3),D1                          ; $272C9E
        OR.L   (A3),D1                          ; $272CA0
        OR.L   (A2),D1                          ; $272CA2
        OR.L   D0,(A0)                          ; $272CA4
        OR.L   D0,A3                            ; $272CA6
        OR.L   A2,D0                            ; $272CA8
        MOVEQ   #-$6F,D7                        ; $272CAA
        MOVE.W  (A5)+,-$56(A6,D7.L)             ; $272CAC
        MOVEQ   #-$4B,D6                        ; $272CB0
        MOVE.W  $7DBB(PC),-$43(A6,D7.L)         ; $272CB2
        DC.W    $7DC0               ; $272CB8 MOVE.W  D0,<EA:3E>
        MOVEQ   #-$41,D6                        ; $272CBA
        MOVE.W  #$7DBA,-$43(A6,D7.L)            ; $272CBC
        DC.W    $7DBE,$7EBF         ; $272CC2 MOVE.W  <EA:3E>,-$41(A6,D7.L)
        MOVEQ   #-$3C,D7                        ; $272CC6
        MOVEQ   #-$36,D7                        ; $272CC8
        MOVEQ   #-$34,D7                        ; $272CCA
        MOVEQ   #-$37,D7                        ; $272CCC
        MOVEQ   #-$3C,D7                        ; $272CCE
        MOVEQ   #-$42,D7                        ; $272CD0
        MOVE.W  -$61(A0,A0.W),-$6F(A7,A0.W)     ; $272CD2
        MOVE.W  D3,$75(A7,D7.L)                 ; $272CD8
        MOVE.W  -(A3),-$7FB2(A7)                ; $272CDC
        OR.B   -$7ED5(PC),D0                    ; $272CE0
        OR.B   D0,-(A0)                         ; $272CE4
        OR.B   (A5),D1                          ; $272CE6
        OR.B   D1,(A2)                          ; $272CE8
        OR.B   D1,(A2)                          ; $272CEA
        OR.B   (A2),D1                          ; $272CEC
        OR.B   (A3),D1                          ; $272CEE
        OR.B   D1,(A5)                          ; $272CF0
        OR.B   D1,(A6)                          ; $272CF2
        OR.B   D1,(A0)+                         ; $272CF4
        OR.B   (A1)+,D1                         ; $272CF6
        OR.B   D0,(A3)+                         ; $272CF8
        OR.B   D0,(A4)+                         ; $272CFA
        OR.B   D0,-(A1)                         ; $272CFC
        OR.B   $4E(A5,D7.L),D0                  ; $272CFE
        MOVE.W  -(A3),$7F73(A7)                 ; $272D02
        DC.W    $7F79,$7F7C,$7E7E,$7E7C; $272D06 MOVE.W  $7F7C7E7E,$7E7C(A7)
        DC.W    $7F79,$7E79,$7E7B,$7D81; $272D0E MOVE.W  $7E797E7B,$7D81(A7)
        MOVE.W  A4,-$6B(A6,D7.L)                ; $272D16
        MOVEQ   #-$63,D7                        ; $272D1A
        OR.L   -$7F4A(A0),D0                    ; $272D1C
        DIVU    D1,D0                           ; $272D20
        DIVS    D5,D0                           ; $272D22
        DIVU    D6,D1                           ; $272D24
        DIVU    D4,D1                           ; $272D26
        DC.W    $81BF               ; $272D28 OR.L   D0,<EA:3F>
        OR.L   #$80B77FAF,D0                    ; $272D2A
        MOVEQ   #-$59,D7                        ; $272D30
        MOVE.W  -(A2),-$63(A6,D7.L)             ; $272D32
        MOVE.W  (A0)+,-$6A(A6,D7.L)             ; $272D36
        MOVEQ   #-$68,D6                        ; $272D3A
        MOVEQ   #-$67,D6                        ; $272D3C
        MOVE.W  (A7),-$6F(A6,D7.L)              ; $272D3E
        MOVEQ   #-$76,D7                        ; $272D42
        MOVEQ   #-$79,D7                        ; $272D44
        MOVEQ   #-$7C,D7                        ; $272D46
        MOVEQ   #-$7C,D7                        ; $272D48
        MOVEQ   #-$72,D7                        ; $272D4A
        MOVEQ   #-$61,D7                        ; $272D4C
        MOVE.W  $7EB7(A6),-$46(A6,D7.L)         ; $272D4E
        MOVE.W  #$7EBE,-$40(A7,D7.L)            ; $272D54
        MOVEQ   #-$3F,D7                        ; $272D5A
        DC.W    $7DC2               ; $272D5C MOVE.W  D2,<EA:3E>
        DC.W    $7DC4               ; $272D5E MOVE.W  D4,<EA:3E>
        DC.W    $7DBD,$7EAC         ; $272D60 MOVE.W  <EA:3D>,-$54(A6,D7.L)
        MOVE.W  (A2)+,-$78(A7,A0.W)             ; $272D64
        MOVE.W  $66(A7,D7.L),-$7FAE(A7)         ; $272D68
        OR.B   D0,$8220.W                       ; $272D6E
        OR.B   (A5),D1                          ; $272D72
        OR.B   D0,(A1)                          ; $272D74
        OR.B   D0,A7                            ; $272D76
        OR.B   A7,D1                            ; $272D78
        OR.B   D1,(A1)                          ; $272D7A
        OR.B   D1,(A3)                          ; $272D7C
        OR.B   (A4),D1                          ; $272D7E
        OR.B   D0,(A6)                          ; $272D80
        OR.B   D0,(A7)                          ; $272D82
        OR.B   D0,(A1)+                         ; $272D84
        OR.B   (A2)+,D0                         ; $272D86
        MOVE.W  (A4)+,-(A7)                     ; $272D88
        MOVEQ   #$26,D7                         ; $272D8A
        MOVE.W  $7F46(PC),-(A7)                 ; $272D8C
        OR.W   A3,D0                            ; $272D90
        OR.W   (A2),D0                          ; $272D92
        MOVE.W  (A7),$7F59(A7)                  ; $272D94
        MOVE.W  (A1)+,$7F55(A7)                 ; $272D98
        MOVE.W  (A4),$7E57(A7)                  ; $272D9C
        MOVEQ   #$60,D7                         ; $272DA0
        MOVEQ   #$70,D7                         ; $272DA2
        MOVEQ   #-$7B,D7                        ; $272DA4
        MOVEQ   #-$6A,D7                        ; $272DA6
        MOVEQ   #-$5B,D7                        ; $272DA8
        MOVE.W  -$40(A3,D7.L),-$38(A7,A0.W)     ; $272DAA
        DIVU    A2,D0                           ; $272DB0
        DIVS    D5,D0                           ; $272DB2
        OR.L   D0,$80AD.W                       ; $272DB4
        MOVEQ   #-$57,D7                        ; $272DB8
        MOVE.W  $7CB7(A6),-$42(A6,D7.L)         ; $272DBA
        DC.W    $7DBF,$7DBE         ; $272DC0 MOVE.W  <EA:3F>,-$42(A6,D7.L)
        MOVEQ   #-$46,D7                        ; $272DC4
        MOVEQ   #-$50,D7                        ; $272DC6
        MOVE.W  -(A6),-$61(A7,D7.L)             ; $272DC8
        MOVE.W  (A6)+,-$60(A7,D7.L)             ; $272DCC
        MOVE.W  -(A1),-$5A(A7,D7.L)             ; $272DD0
        MOVE.W  $7FB3(A4),-$46(A7,D7.L)         ; $272DD4
        MOVEQ   #-$44,D7                        ; $272DDA
        MOVE.W  $7FBA(PC),-$44(A7,D7.L)         ; $272DDC
        MOVEQ   #-$40,D7                        ; $272DE2
        MOVEQ   #-$3F,D7                        ; $272DE4
        MOVEQ   #-$45,D7                        ; $272DE6
        MOVEQ   #-$4D,D7                        ; $272DE8
        MOVEQ   #-$56,D7                        ; $272DEA
        MOVEQ   #-$5F,D7                        ; $272DEC
        MOVEQ   #-$67,D7                        ; $272DEE
        MOVEQ   #-$71,D7                        ; $272DF0
        MOVE.W  D2,$71(A6,D7.L)                 ; $272DF2
        MOVEQ   #$5F,D7                         ; $272DF6
        MOVE.W  (A0),$7F40(A7)                  ; $272DF8
        OR.B   $26(A2,A0.W),D0                  ; $272DFC
        MOVE.W  (A6)+,-(A7)                     ; $272E00
        MOVE.W  (A7),-(A7)                      ; $272E02
        MOVE.W  (A3),-(A7)                      ; $272E04
        OR.B   (A3),D0                          ; $272E06
        OR.B   (A3),D0                          ; $272E08
        OR.B   D0,(A4)                          ; $272E0A
        OR.B   D0,(A5)                          ; $272E0C
        OR.B   D0,(A7)                          ; $272E0E
        OR.B   D0,(A0)+                         ; $272E10
        OR.B   D0,(A2)+                         ; $272E12
        OR.B   (A3)+,D0                         ; $272E14
        OR.B   (A5)+,D0                         ; $272E16
        MOVE.W  -(A6),-(A7)                     ; $272E18
        MOVE.W  $7F4D(PC),-(A7)                 ; $272E1A
        MOVE.W  (A5)+,$7F69(A7)                 ; $272E1E
        MOVE.W  $7F71(A7),$7F73(A7)             ; $272E22
        MOVE.W  $77(A6,D7.L),$7F75(A7)          ; $272E28
        MOVE.W  $7F63(A7),$7F5B(A7)             ; $272E2E
        MOVEQ   #$61,D7                         ; $272E34
        MOVE.W  -$6F(A6,D7.L),$7EAB(A6)         ; $272E36
        DC.W    $7FC2               ; $272E3C MOVE.W  D2,<EA:3F>
        DC.W    $7FD0               ; $272E3E MOVE.W  (A0),<EA:3F>
        DC.W    $7FD1               ; $272E40 MOVE.W  (A1),<EA:3F>
        DC.W    $7FC6               ; $272E42 MOVE.W  D6,<EA:3F>
        MOVE.W  $80A8.W,-$6A(A7,D7.L)           ; $272E44
        OR.L   D7,D0                            ; $272E4A
        DC.W    $807F               ; $272E4C OR.W   <EA:3F>,D0
        OR.W   $7C(PC,A0.W),D0                  ; $272E4E
        OR.L   D3,D0                            ; $272E52
        MOVE.W  A5,-$6B(A7,D7.L)                ; $272E54
        MOVE.W  (A2)+,-$64(A6,D7.L)             ; $272E58
        MOVE.W  (A5)+,-$63(A6,D7.L)             ; $272E5C
        MOVEQ   #-$62,D7                        ; $272E60
        MOVEQ   #-$61,D7                        ; $272E62
        MOVEQ   #-$60,D7                        ; $272E64
        MOVEQ   #-$5A,D7                        ; $272E66
        MOVEQ   #-$53,D7                        ; $272E68
        MOVE.W  -$44(A5,D7.L),-$3F(A6,D7.L)     ; $272E6A
        MOVEQ   #-$3B,D6                        ; $272E70
        MOVEQ   #-$39,D6                        ; $272E72
        MOVEQ   #-$35,D6                        ; $272E74
        MOVEQ   #-$30,D6                        ; $272E76
        MOVEQ   #-$30,D6                        ; $272E78
        MOVEQ   #-$30,D6                        ; $272E7A
        DC.W    $7DCE               ; $272E7C MOVE.W  A6,<EA:3E>
        DC.W    $7DC4               ; $272E7E MOVE.W  D4,<EA:3E>
        MOVE.W  -$5C(A5,D7.L),-$6F(A6,D7.L)     ; $272E80
        MOVE.W  #$8065,-$7EB0(A7)               ; $272E86
        OR.B   D0,$28(PC,A0.W)                  ; $272E8C
        OR.B   D0,(A1)+                         ; $272E90
        OR.B   (A4),D1                          ; $272E92
        OR.B   (A2),D1                          ; $272E94
        OR.B   D1,(A2)                          ; $272E96
        OR.B   D1,(A3)                          ; $272E98
        OR.B   (A5),D1                          ; $272E9A
        OR.B   D0,(A6)                          ; $272E9C
        OR.B   D0,(A0)+                         ; $272E9E
        OR.B   (A1)+,D1                         ; $272EA0
        OR.B   (A2)+,D1                         ; $272EA2
        OR.B   D0,(A4)+                         ; $272EA4
        OR.B   -(A3),D0                         ; $272EA6
        OR.B   -$7ECE(A3),D0                    ; $272EA8
        OR.B   $803C.W,D0                       ; $272EAC
        DC.W    $803F               ; $272EB0 OR.B   <EA:3F>,D0
        MOVE.W  D7,$7F54(A7)                    ; $272EB2
        MOVE.W  (A5)+,$7D61(A6)                 ; $272EB6
        MOVEQ   #$61,D7                         ; $272EBA
        MOVEQ   #$60,D7                         ; $272EBC
        MOVEQ   #$64,D7                         ; $272EBE
        MOVE.W  -$7A(A1,D7.L),$7D99(A6)         ; $272EC0
        MOVEQ   #-$55,D7                        ; $272EC6
        DC.W    $7FB9,$80BF,$81BE,$82BC; $272EC8 MOVE.W  $80BF81BE,-$44(A7,A0.W)
        OR.L   D0,-$7E4E(PC)                    ; $272ED0
        OR.L   -(A7),D1                         ; $272ED4
        OR.L   (A7)+,D1                         ; $272ED6
        OR.L   D0,(A7)+                         ; $272ED8
        OR.L   -(A1),D0                         ; $272EDA
        MOVE.W  -(A3),-$5C(A7,A0.W)             ; $272EDC
        OR.L   -(A4),D0                         ; $272EE0
        MOVE.W  (A7)+,-$68(A7,D7.L)             ; $272EE2
        MOVEQ   #-$6A,D7                        ; $272EE6
        MOVE.W  (A5)+,-$57(A6,D7.L)             ; $272EE8
        MOVEQ   #-$4E,D6                        ; $272EEC
        MOVE.W  -$51(A3,D7.L),-$4C(A6,D7.L)     ; $272EEE
        MOVEQ   #-$40,D6                        ; $272EF4
        DC.W    $7BC9               ; $272EF6 MOVE.W  A1,<EA:3D>
        DC.W    $7BCD               ; $272EF8 MOVE.W  A5,<EA:3D>
        DC.W    $7BD0               ; $272EFA MOVE.W  (A0),<EA:3D>
        DC.W    $7BD3               ; $272EFC MOVE.W  (A3),<EA:3D>
        DC.W    $7BD3               ; $272EFE MOVE.W  (A3),<EA:3D>
        MOVEQ   #-$2D,D6                        ; $272F00
        DC.W    $7DD2               ; $272F02 MOVE.W  (A2),<EA:3E>
        DC.W    $7DD0               ; $272F04 MOVE.W  (A0),<EA:3E>
        DC.W    $7DCD               ; $272F06 MOVE.W  A5,<EA:3E>
        DC.W    $7DC2               ; $272F08 MOVE.W  D2,<EA:3E>
        MOVEQ   #-$4C,D7                        ; $272F0A
        MOVE.W  -(A7),-$64(A7,D7.L)             ; $272F0C
        MOVEQ   #-$70,D7                        ; $272F10
        MOVE.W  D3,$71(A7,A0.W)                 ; $272F12
        OR.W   (A7)+,D0                         ; $272F16
        OR.W   D0,A7                            ; $272F18
        DC.W    $813D               ; $272F1A OR.B   D0,<EA:3D>
        OR.B   -(A5),D1                         ; $272F1C
        OR.B   D1,(A7)                          ; $272F1E
        OR.B   D1,(A4)                          ; $272F20
        OR.B   (A1),D1                          ; $272F22
        OR.B   D1,(A1)                          ; $272F24
        OR.B   (A2),D2                          ; $272F26
        OR.B   (A4),D2                          ; $272F28
        OR.B   D1,(A6)                          ; $272F2A
        OR.B   (A7),D1                          ; $272F2C
        OR.B   D0,(A0)+                         ; $272F2E
        OR.B   D0,(A2)+                         ; $272F30
        OR.B   D0,(A3)+                         ; $272F32
        OR.B   D0,(A4)+                         ; $272F34
        OR.B   (A6)+,D0                         ; $272F36
        OR.B   -(A6),D0                         ; $272F38
        OR.B   $3E(A3,D7.L),D0                  ; $272F3A
        MOVE.W  D3,-$7FB9(A7)                   ; $272F3E
        MOVE.W  A7,$7E5B(A7)                    ; $272F42
        MOVEQ   #$6A,D7                         ; $272F46
        MOVEQ   #$77,D7                         ; $272F48
        MOVEQ   #-$7C,D7                        ; $272F4A
        MOVEQ   #-$73,D7                        ; $272F4C
        MOVE.W  (A2),-$6A(A7,D7.L)              ; $272F4E
        OR.L   (A3)+,D0                         ; $272F52
        OR.L   D0,-(A2)                         ; $272F54
        OR.L   D0,-$7E4A(A3)                    ; $272F56
        DIVU    D1,D0                           ; $272F5A
        DC.W    $7FC7               ; $272F5C MOVE.W  D7,<EA:3F>
        DC.W    $7FC8               ; $272F5E MOVE.W  A0,<EA:3F>
        DC.W    $7FC0               ; $272F60 MOVE.W  D0,<EA:3F>
        MOVE.W  -$5A(A1,D7.L),-$58(A7,D7.L)     ; $272F62
        MOVEQ   #-$52,D6                        ; $272F68
        MOVEQ   #-$53,D6                        ; $272F6A
        MOVE.W  -(A5),-$61(A6,D7.L)             ; $272F6C
        MOVE.W  (A1)+,-$6C(A6,D7.L)             ; $272F70
        MOVE.W  (A2),-$6D(A6,D7.L)              ; $272F74
        MOVEQ   #-$6A,D7                        ; $272F78
        MOVE.W  (A2)+,-$64(A6,D7.L)             ; $272F7A
        MOVE.W  -(A2),-$55(A6,D7.L)             ; $272F7E
        MOVE.W  $7CA6(A3),-$5A(A6,D7.L)         ; $272F82
        MOVEQ   #-$58,D6                        ; $272F88
        MOVEQ   #-$53,D6                        ; $272F8A
        MOVEQ   #-$48,D6                        ; $272F8C
        DC.W    $7DC3               ; $272F8E MOVE.W  D3,<EA:3E>
        MOVEQ   #-$37,D7                        ; $272F90
        DC.W    $7FC7               ; $272F92 MOVE.W  D7,<EA:3F>
        DC.W    $7FC2               ; $272F94 MOVE.W  D2,<EA:3F>
        MOVE.W  -$4B(PC,D7.L),-$53(A7,D7.L)     ; $272F96
        MOVE.W  -(A4),-$67(A7,A0.W)             ; $272F9C
        OR.L   D0,A3                            ; $272FA0
        OR.W   D0,$6C(PC,A0.W)                  ; $272FA2
        OR.W   D0,(A1)+                         ; $272FA6
        OR.W   D5,D0                            ; $272FA8
        OR.B   $21(A1,A0.W),D0                  ; $272FAA
        OR.B   (A7),D0                          ; $272FAE
        OR.B   (A4),D0                          ; $272FB0
        OR.B   D0,(A3)                          ; $272FB2
        OR.B   (A3),D1                          ; $272FB4
        OR.B   D1,(A4)                          ; $272FB6
        OR.B   D1,(A6)                          ; $272FB8
        OR.B   D1,(A7)                          ; $272FBA
        OR.B   D1,(A1)+                         ; $272FBC
        OR.B   (A2)+,D1                         ; $272FBE
        OR.B   (A3)+,D1                         ; $272FC0
        OR.B   D0,(A5)+                         ; $272FC2
        OR.B   D0,(A6)+                         ; $272FC4
        OR.B   -(A3),D0                         ; $272FC6
        MOVE.W  $48(A4,D7.L),-(A7)              ; $272FC8
        MOVEQ   #$5A,D7                         ; $272FCC
        MOVEQ   #$68,D7                         ; $272FCE
        MOVEQ   #$6E,D7                         ; $272FD0
        MOVE.W  -$7F97(A5),-$7F90(A7)           ; $272FD2
        DC.W    $7F7E,$7E89         ; $272FD8 MOVE.W  <EA:3E>,$7E89(A7)
        MOVE.W  A6,-$6C(A7,A0.W)                ; $272FDC
        MOVE.W  (A5)+,-$57(A7,D7.L)             ; $272FE0
        MOVE.W  -$46(A4,D7.L),-$46(A6,D7.L)     ; $272FE4
        MOVEQ   #-$45,D7                        ; $272FEA
        DC.W    $7DBE,$7DBC         ; $272FEC MOVE.W  <EA:3E>,-$44(A6,D7.L)
        MOVEQ   #-$4A,D7                        ; $272FF0
        MOVEQ   #-$4B,D7                        ; $272FF2
        MOVEQ   #-$4B,D7                        ; $272FF4
        MOVE.W  -$48(A6,D7.L),-$4B(A6,D7.L)     ; $272FF6
        OR.L   -$52(A0,A0.W),D0                 ; $272FFC
        OR.L   -$7F59(A5),D0                    ; $273000
        OR.L   D0,(A6)+                         ; $273004
        OR.L   D0,(A3)                          ; $273006
        OR.L   A4,D0                            ; $273008
        MOVEQ   #-$77,D7                        ; $27300A
        MOVE.W  A2,-$76(A6,D7.L)                ; $27300C
        MOVE.W  A0,-$77(A6,D7.L)                ; $273010
        MOVE.W  A3,-$73(A6,D7.L)                ; $273014
        MOVE.W  (A0),-$6E(A6,D7.L)              ; $273018
        MOVE.W  (A3),-$68(A7,A0.W)              ; $27301C
        OR.L   (A6)+,D0                         ; $273020
        OR.L   -(A5),D0                         ; $273022
        MOVE.W  $7FAE(A3),-$52(A7,D7.L)         ; $273024
        MOVE.W  $7F9F(A2),-$6E(A7,D7.L)         ; $27302A
        MOVEQ   #-$77,D7                        ; $273030
        MOVEQ   #$7E,D7                         ; $273032
        MOVEQ   #$75,D7                         ; $273034
        MOVE.W  $7F5E(A4),$7F4D(A7)             ; $273036
        OR.B   D0,$2D(PC,A0.W)                  ; $27303C
        OR.B   D0,(A7)+                         ; $273040
        OR.B   D0,(A0)+                         ; $273042
        OR.B   (A6),D1                          ; $273044
        OR.B   D1,(A6)                          ; $273046
        OR.B   (A6),D2                          ; $273048
        OR.B   (A0)+,D2                         ; $27304A
        OR.B   D1,(A1)+                         ; $27304C
        OR.B   (A3)+,D1                         ; $27304E
        OR.B   D0,(A4)+                         ; $273050
        OR.B   (A7)+,D0                         ; $273052
        MOVE.W  $7F3D(A2),-(A7)                 ; $273054
        MOVE.W  (A2),$7F65(A7)                  ; $273058
        MOVE.W  -$7D(A4,D7.L),$7E8D(A7)         ; $27305C
        MOVE.W  (A3),-$6B(A6,D7.L)              ; $273062
        MOVEQ   #-$6E,D7                        ; $273066
        MOVE.W  A1,$75(A7,A0.W)                 ; $273068
        OR.W   -(A0),D0                         ; $27306C
        OR.W   (A1)+,D0                         ; $27306E
        MOVE.W  (A6)+,$7E6B(A7)                 ; $273070
        MOVE.W  #$7F8C,$7F98(A7)                ; $273074
        OR.L   (A6)+,D0                         ; $27307A
        OR.L   -(A0),D0                         ; $27307C
        OR.L   (A6)+,D0                         ; $27307E
        OR.L   (A2)+,D0                         ; $273080
        MOVE.W  (A1)+,-$63(A7,D7.L)             ; $273082
        MOVEQ   #-$5F,D7                        ; $273086
        MOVEQ   #-$60,D7                        ; $273088
        MOVE.W  (A4)+,-$63(A7,D7.L)             ; $27308A
        MOVEQ   #-$5C,D7                        ; $27308E
        MOVE.W  $7DB1(A4),-$4B(A6,D7.L)         ; $273090
        MOVE.W  -$4A(A7,D7.L),-$4B(A6,D7.L)     ; $273096
        MOVEQ   #-$4D,D7                        ; $27309C
        MOVE.W  -$4E(A2,D7.L),-$4A(A7,D7.L)     ; $27309E
        DC.W    $7FBE,$7FC8         ; $2730A4 MOVE.W  <EA:3E>,-$38(A7,D7.L)
        MOVEQ   #-$31,D7                        ; $2730A8
        MOVEQ   #-$2F,D7                        ; $2730AA
        MOVEQ   #-$2E,D7                        ; $2730AC
        MOVEQ   #-$2E,D7                        ; $2730AE
        MOVEQ   #-$2F,D7                        ; $2730B0
        DC.W    $7DD0               ; $2730B2 MOVE.W  (A0),<EA:3E>
        DC.W    $7DCE               ; $2730B4 MOVE.W  A6,<EA:3E>
        DC.W    $7DCC               ; $2730B6 MOVE.W  A4,<EA:3E>
        MOVEQ   #-$3F,D7                        ; $2730B8
        MOVEQ   #-$50,D7                        ; $2730BA
        MOVEQ   #-$61,D7                        ; $2730BC
        MOVE.W  A3,$72(A7,A0.W)                 ; $2730BE
        OR.W   D0,(A0)+                         ; $2730C2
        OR.B   D0,-$7EE0(PC)                    ; $2730C4
        OR.B   (A4),D1                          ; $2730C8
        OR.B   (A1),D1                          ; $2730CA
        OR.B   D1,A6                            ; $2730CC
        OR.B   D1,A7                            ; $2730CE
        OR.B   D1,(A1)                          ; $2730D0
        OR.B   (A2),D2                          ; $2730D2
        OR.B   D2,(A4)                          ; $2730D4
        OR.B   (A6),D2                          ; $2730D6
        OR.B   D1,(A7)                          ; $2730D8
        OR.B   (A0)+,D1                         ; $2730DA
        OR.B   D0,(A2)+                         ; $2730DC
        OR.B   D0,(A5)+                         ; $2730DE
        OR.B   D0,-$7FC4(A2)                    ; $2730E0
        OR.W   A2,D0                            ; $2730E4
        MOVE.W  (A3),$7F57(A7)                  ; $2730E6
        MOVEQ   #$5B,D7                         ; $2730EA
        MOVEQ   #$61,D7                         ; $2730EC
        MOVE.W  -(A4),$7D62(A6)                 ; $2730EE
        MOVEQ   #$5F,D7                         ; $2730F2
        MOVEQ   #$5C,D7                         ; $2730F4
        MOVEQ   #$57,D7                         ; $2730F6
        MOVE.W  (A1),-$7FB2(A7)                 ; $2730F8
        OR.W   (A3),D0                          ; $2730FC
        MOVE.W  (A6)+,$7F6B(A7)                 ; $2730FE
        MOVE.W  #$7F8E,$7FA1(A7)                ; $273102
        MOVE.W  -$42(A0,D7.L),-$3B(A7,D7.L)     ; $273108
        DIVU    D4,D0                           ; $27310E
        DIVU    D1,D0                           ; $273110
        DIVU    D2,D0                           ; $273112
        DC.W    $7FC6               ; $273114 MOVE.W  D6,<EA:3F>
        DC.W    $7FC8               ; $273116 MOVE.W  A0,<EA:3F>
        DC.W    $7FC8               ; $273118 MOVE.W  A0,<EA:3F>
        DIVU    D5,D0                           ; $27311A
        OR.L   -$7E52(PC),D0                    ; $27311C
        OR.L   $7EA9(A0),D0                     ; $273120
        MOVE.W  $7DB1(A4),-$47(A6,D7.L)         ; $273124
        DC.W    $7DBE,$7DBF         ; $27312A MOVE.W  <EA:3E>,-$41(A6,D7.L)
        MOVEQ   #-$43,D7                        ; $27312E
        MOVEQ   #-$40,D7                        ; $273130
        DC.W    $7FC6               ; $273132 MOVE.W  D6,<EA:3F>
        DC.W    $7FCB               ; $273134 MOVE.W  A3,<EA:3F>
        DC.W    $7FCD               ; $273136 MOVE.W  A5,<EA:3F>
        DC.W    $7FCF               ; $273138 MOVE.W  A7,<EA:3F>
        MOVEQ   #-$30,D7                        ; $27313A
        DC.W    $7DCF               ; $27313C MOVE.W  A7,<EA:3E>
        DC.W    $7DCE               ; $27313E MOVE.W  A6,<EA:3E>
        MOVEQ   #-$33,D7                        ; $273140
        MOVEQ   #-$36,D7                        ; $273142
        MOVEQ   #-$3E,D7                        ; $273144
        MOVEQ   #-$4A,D7                        ; $273146
        MOVEQ   #-$5A,D7                        ; $273148
        MOVE.W  (A3),$7E(A7,D7.L)               ; $27314A
        MOVE.W  -$7FAA(A2),-$7EBD(A7)           ; $27314E
        OR.B   -$7CE6(A6),D1                    ; $273154
        OR.B   D1,(A2)                          ; $273158
        OR.B   D1,A7                            ; $27315A
        OR.B   D1,A6                            ; $27315C
        OR.B   D1,A7                            ; $27315E
        OR.B   (A0),D1                          ; $273160
        OR.B   (A2),D1                          ; $273162
        OR.B   (A3),D1                          ; $273164
        OR.B   (A5),D1                          ; $273166
        OR.B   (A6),D1                          ; $273168
        OR.B   (A0)+,D1                         ; $27316A
        OR.B   (A1)+,D0                         ; $27316C
        MOVE.W  (A7)+,-(A7)                     ; $27316E
        MOVE.W  $7F32(A2),-(A7)                 ; $273170
        OR.B   $2A(A1,A0.W),D0                  ; $273174
        MOVE.W  -(A7),-(A7)                     ; $273178
        MOVEQ   #$2E,D7                         ; $27317A
        MOVE.W  $7D40.W,-(A6)                   ; $27317C
        MOVE.W  D3,$7E43(A6)                    ; $273180
        MOVEQ   #$3F,D7                         ; $273184
        DC.W    $7F3E               ; $273186 MOVE.W  <EA:3E>,-(A7)
        MOVE.W  D0,$7E48(A7)                    ; $273188
        MOVE.W  (A7),$7E6E(A6)                  ; $27318C
        MOVEQ   #-$77,D7                        ; $273190
        MOVE.W  -(A5),-$49(A7,A0.W)             ; $273192
        DIVU    D2,D0                           ; $273196
        DIVU    A2,D0                           ; $273198
        DIVU    (A5),D0                         ; $27319A
        DC.W    $7FDF               ; $27319C MOVE.W  (A7)+,<EA:3F>
        DC.W    $7FE0               ; $27319E MOVE.W  -(A0),<EA:3F>
        DC.W    $7FE0               ; $2731A0 MOVE.W  -(A0),<EA:3F>
        DIVU    (A4)+,D0                        ; $2731A2
        DIVU    A5,D0                           ; $2731A4
        DC.W    $7FC0               ; $2731A6 MOVE.W  D0,<EA:3F>
        DC.W    $7FB9,$7EB4,$7EAD,$7EA5; $2731A8 MOVE.W  $7EB47EAD,-$5B(A7,D7.L)
        MOVEQ   #-$64,D7                        ; $2731B0
        MOVEQ   #-$68,D7                        ; $2731B2
        MOVE.W  (A3)+,-$5A(A6,D7.L)             ; $2731B4
        MOVE.W  $7EB2(A6),-$4C(A6,D7.L)         ; $2731B8
        DC.W    $7FB9,$7EBE,$7EC2,$7EC7; $2731BE MOVE.W  $7EBE7EC2,-$39(A7,D7.L)
        MOVEQ   #-$33,D7                        ; $2731C6
        MOVEQ   #-$2F,D7                        ; $2731C8
        MOVEQ   #-$2F,D7                        ; $2731CA
        MOVEQ   #-$31,D7                        ; $2731CC
        MOVEQ   #-$36,D7                        ; $2731CE
        MOVEQ   #-$39,D7                        ; $2731D0
        DC.W    $7DC2               ; $2731D2 MOVE.W  D2,<EA:3E>
        MOVEQ   #-$49,D7                        ; $2731D4
        MOVE.W  -(A7),-$6D(A7,A0.W)             ; $2731D6
        MOVE.W  D2,$72(A7,D7.L)                 ; $2731DA
        MOVE.W  -(A1),$7F4B(A7)                 ; $2731DE
        OR.B   $2A(A7,A0.W),D0                  ; $2731E2
        OR.B   D0,-(A1)                         ; $2731E6
        OR.B   (A7),D1                          ; $2731E8
        OR.B   D1,(A3)                          ; $2731EA
        OR.B   D1,(A3)                          ; $2731EC
        OR.B   D1,(A3)                          ; $2731EE
        OR.B   (A4),D1                          ; $2731F0
        OR.B   (A5),D1                          ; $2731F2
        OR.B   (A7),D1                          ; $2731F4
        OR.B   D0,(A0)+                         ; $2731F6
        OR.B   D0,(A2)+                         ; $2731F8
        OR.B   (A3)+,D0                         ; $2731FA
        OR.B   (A6)+,D0                         ; $2731FC
        MOVE.W  -(A6),-(A7)                     ; $2731FE
        MOVE.W  $3C(A2,D7.L),-(A7)              ; $273200
        MOVE.W  D2,$7F48(A7)                    ; $273204
        MOVEQ   #$49,D7                         ; $273208
        MOVE.W  D7,$7D48(A6)                    ; $27320A
        MOVE.W  A2,$7D4C(A6)                    ; $27320E
        MOVE.W  A6,$7E4E(A6)                    ; $273212
        MOVEQ   #$4F,D7                         ; $273216
        MOVE.W  (A4),$7F60(A7)                  ; $273218
        MOVEQ   #$73,D7                         ; $27321C
        MOVE.W  A0,-$65(A7,A0.W)                ; $27321E
        OR.L   -(A7),D0                         ; $273222
        OR.L   -$7F4E(A6),D0                    ; $273224
        OR.L   $7FC47FCE,D0                     ; $273228
        DC.W    $7FD2               ; $27322E MOVE.W  (A2),<EA:3F>
        MOVEQ   #-$31,D7                        ; $273230
        DC.W    $7FC6               ; $273232 MOVE.W  D6,<EA:3F>
        MOVE.W  -$50(PC,D7.L),-$5B(A7,D7.L)     ; $273234
        MOVEQ   #-$64,D7                        ; $27323A
        MOVEQ   #-$68,D7                        ; $27323C
        MOVEQ   #-$6B,D7                        ; $27323E
        MOVEQ   #-$6D,D7                        ; $273240
        MOVEQ   #-$6D,D7                        ; $273242
        MOVE.W  (A3),-$6E(A7,D7.L)              ; $273244
        OR.L   (A3),D0                          ; $273248
        MOVE.W  (A1)+,-$5A(A7,D7.L)             ; $27324A
        MOVE.W  -$3F(A5,D7.L),-$37(A7,D7.L)     ; $27324E
        DC.W    $7DD1               ; $273254 MOVE.W  (A1),<EA:3E>
        MOVEQ   #-$2B,D6                        ; $273256
        MOVEQ   #-$2A,D6                        ; $273258
        MOVEQ   #-$2A,D6                        ; $27325A
        MOVEQ   #-$2B,D6                        ; $27325C
        MOVEQ   #-$2E,D6                        ; $27325E
        DC.W    $7DC9               ; $273260 MOVE.W  A1,<EA:3E>
        DC.W    $7DBD,$7EB2         ; $273262 MOVE.W  <EA:3D>,-$4E(A6,D7.L)
        MOVE.W  -$7F66(A0),-$76(A7,A0.W)        ; $273266
        OR.W   D0,-$7E99(PC)                    ; $27326C
        OR.W   (A7),D0                          ; $273270
        OR.W   A2,D0                            ; $273272
        OR.W   D3,D0                            ; $273274
        DC.W    $803E               ; $273276 OR.B   <EA:3E>,D0
        OR.B   $2C(A6,A0.W),D0                  ; $273278
        OR.B   (A6)+,D1                         ; $27327C
        OR.B   (A1)+,D1                         ; $27327E
        OR.B   (A0)+,D1                         ; $273280
        OR.B   D0,(A7)                          ; $273282
        OR.B   (A7),D0                          ; $273284
        OR.B   (A1)+,D0                         ; $273286
        OR.B   (A2)+,D0                         ; $273288
        OR.B   (A5)+,D0                         ; $27328A
        MOVE.W  -(A1),-(A7)                     ; $27328C
        OR.B   -$7FD0(A0),D0                    ; $27328E
        OR.B   $80437F4F,D0                     ; $273292
        MOVEQ   #$5E,D7                         ; $273298
        MOVEQ   #$6C,D7                         ; $27329A
        MOVEQ   #$76,D7                         ; $27329C
        MOVE.W  #$7D7A,$7E75(A6)                ; $27329E
        MOVE.W  $7F64(A6),$7F5D(A7)             ; $2732A4
        MOVE.W  (A2)+,$7F59(A7)                 ; $2732AA
        OR.W   (A5)+,D0                         ; $2732AE
        OR.W   -$7F87(A1),D0                    ; $2732B0
        MOVE.W  D7,-$6C(A7,D7.L)                ; $2732B4
        MOVEQ   #-$60,D7                        ; $2732B8
        MOVE.W  $7CB6(A3),-$43(A6,D7.L)         ; $2732BA
        MOVE.W  #$7EB5,-$55(A6,D7.L)            ; $2732C0
        MOVE.W  (A4)+,-$71(A7,D7.L)             ; $2732C6
        MOVE.W  A3,-$71(A7,D7.L)                ; $2732CA
        MOVE.W  (A5),-$62(A7,D7.L)              ; $2732CE
        MOVEQ   #-$56,D7                        ; $2732D2
        MOVEQ   #-$49,D7                        ; $2732D4
        MOVEQ   #-$43,D7                        ; $2732D6
        MOVEQ   #-$45,D7                        ; $2732D8
        MOVE.W  $7EBA.W,-$3E(A7,D7.L)           ; $2732DA
        DC.W    $7BCC               ; $2732E0 MOVE.W  A4,<EA:3D>
        DC.W    $7BD3               ; $2732E2 MOVE.W  (A3),<EA:3D>
        DC.W    $7BD5               ; $2732E4 MOVE.W  (A5),<EA:3D>
        MOVEQ   #-$2A,D6                        ; $2732E6
        MOVEQ   #-$2A,D6                        ; $2732E8
        MOVEQ   #-$2A,D6                        ; $2732EA
        DC.W    $7DD4               ; $2732EC MOVE.W  (A4),<EA:3E>
        MOVEQ   #-$2D,D7                        ; $2732EE
        DC.W    $7DD1               ; $2732F0 MOVE.W  (A1),<EA:3E>
        DC.W    $7DCB               ; $2732F2 MOVE.W  A3,<EA:3E>
        MOVEQ   #-$43,D7                        ; $2732F4
        MOVE.W  -(A4),-$7A(A7,A0.W)             ; $2732F6
        OR.W   $63(A1,A0.W),D0                  ; $2732FA
        OR.W   (A5),D0                          ; $2732FE
        OR.W   D0,D5                            ; $273300
        OR.B   $2A(A7,A0.W),D1                  ; $273302
        OR.B   (A5)+,D1                         ; $273306
        OR.B   D1,(A7)                          ; $273308
        OR.B   (A6),D2                          ; $27330A
        OR.B   D1,(A5)                          ; $27330C
        OR.B   D1,(A6)                          ; $27330E
        OR.B   D1,(A7)                          ; $273310
        OR.B   D1,(A1)+                         ; $273312
        OR.B   (A2)+,D1                         ; $273314
        OR.B   D0,(A3)+                         ; $273316
        OR.B   D0,(A5)+                         ; $273318
        OR.B   (A6)+,D1                         ; $27331A
        OR.B   D0,(A7)+                         ; $27331C
        OR.B   -(A0),D0                         ; $27331E
        OR.B   -(A3),D0                         ; $273320
        MOVE.W  $7E3E(A7),-(A7)                 ; $273322
        MOVE.W  A5,$7D5A(A6)                    ; $273326
        MOVE.W  -(A3),$7D69(A6)                 ; $27332A
        MOVE.W  $7D74(A6),$7D77(A6)             ; $27332E
        MOVEQ   #$79,D7                         ; $273334
        MOVE.W  $71(A6,D7.L),$7F71(A7)          ; $273336
        DC.W    $7F79,$7E84,$7E90,$7F9D; $27333C MOVE.W  $7E847E90,$7F9D(A7)
        MOVE.W  $7FB1(A0),-$48(A7,D7.L)         ; $273344
        DC.W    $7FBD,$7EC2         ; $27334A MOVE.W  <EA:3D>,-$3E(A7,D7.L)
        MOVEQ   #-$3C,D7                        ; $27334E
        MOVEQ   #-$3C,D7                        ; $273350
        DC.W    $7FC2               ; $273352 MOVE.W  D2,<EA:3F>
        DC.W    $7FBF,$80BB         ; $273354 MOVE.W  <EA:3F>,-$45(A7,A0.W)
        MOVE.W  -$43(PC,D7.L),-$43(A7,D7.L)     ; $273358
        DC.W    $80BD               ; $27335E OR.L   <EA:3D>,D0
        DC.W    $80BD               ; $273360 OR.L   <EA:3D>,D0
        DC.W    $7FBD,$7FBF         ; $273362 MOVE.W  <EA:3D>,-$41(A7,D7.L)
        MOVEQ   #-$3B,D7                        ; $273366
        DC.W    $7DCC               ; $273368 MOVE.W  A4,<EA:3E>
        DC.W    $7DD1               ; $27336A MOVE.W  (A1),<EA:3E>
        DC.W    $7DD3               ; $27336C MOVE.W  (A3),<EA:3E>
        DC.W    $7DD4               ; $27336E MOVE.W  (A4),<EA:3E>
        DC.W    $7DD4               ; $273370 MOVE.W  (A4),<EA:3E>
        MOVEQ   #-$2C,D6                        ; $273372
        MOVEQ   #-$2D,D6                        ; $273374
        MOVEQ   #-$2F,D6                        ; $273376
        DC.W    $7BD0               ; $273378 MOVE.W  (A0),<EA:3D>
        DC.W    $7BCF               ; $27337A MOVE.W  A7,<EA:3D>
        DC.W    $7BCC               ; $27337C MOVE.W  A4,<EA:3D>
        MOVEQ   #-$3F,D6                        ; $27337E
        MOVEQ   #-$4F,D7                        ; $273380
        MOVEQ   #-$62,D7                        ; $273382
        MOVEQ   #-$79,D7                        ; $273384
        MOVE.W  $61(A4,D7.L),-$7FAF(A7)         ; $273386
        OR.W   D6,D0                            ; $27338C
        OR.B   -$7ED8(PC),D0                    ; $27338E
        OR.B   (A0)+,D1                         ; $273392
        OR.B   D1,(A4)                          ; $273394
        OR.B   D1,(A2)                          ; $273396
        OR.B   (A2),D1                          ; $273398
        OR.B   D1,(A2)                          ; $27339A
        OR.B   D1,(A4)                          ; $27339C
        OR.B   D1,(A5)                          ; $27339E
        OR.B   D1,(A7)                          ; $2733A0
        OR.B   D1,(A0)+                         ; $2733A2
        OR.B   (A2)+,D1                         ; $2733A4
        OR.B   D0,(A3)+                         ; $2733A6
        OR.B   D0,(A4)+                         ; $2733A8
        OR.B   (A5)+,D0                         ; $2733AA
        MOVE.W  (A7)+,-(A7)                     ; $2733AC
        MOVEQ   #$20,D7                         ; $2733AE
        MOVE.W  $7C3B(A0),-(A6)                 ; $2733B0
        MOVE.W  (A1),$7B63(A5)                  ; $2733B4
        MOVE.W  $7F(A3,D7.L),$7C87(A5)          ; $2733B8
        MOVE.W  A2,-$76(A6,D7.L)                ; $2733BE
        MOVEQ   #-$77,D7                        ; $2733C2
        MOVEQ   #-$77,D7                        ; $2733C4
        MOVEQ   #-$78,D7                        ; $2733C6
        MOVE.W  D5,-$7A(A7,D7.L)                ; $2733C8
        OR.L   A3,D0                            ; $2733CC
        OR.L   (A0),D0                          ; $2733CE
        OR.L   D0,(A7)                          ; $2733D0
        OR.L   D0,-(A1)                         ; $2733D2
        OR.L   $7FB8(A5),D0                     ; $2733D4
        DC.W    $7FBE,$7FC0         ; $2733D8 MOVE.W  <EA:3E>,-$40(A7,D7.L)
        DC.W    $7FC0               ; $2733DC MOVE.W  D0,<EA:3F>
        DC.W    $7FBF,$7FBE         ; $2733DE MOVE.W  <EA:3F>,-$42(A7,D7.L)
        DC.W    $7FBF,$7FBB         ; $2733E2 MOVE.W  <EA:3F>,-$45(A7,D7.L)
        OR.L   -$4C(A7,A0.W),D0                 ; $2733E6
        OR.L   -$51(A0,A0.W),D0                 ; $2733EA
        MOVE.W  -$4C(A2,D7.L),-$4E(A7,D7.L)     ; $2733EE
        MOVEQ   #-$51,D7                        ; $2733F4
        MOVEQ   #-$51,D7                        ; $2733F6
        MOVE.W  -$4A(A1,D7.L),-$45(A6,D7.L)     ; $2733F8
        DC.W    $7DBF,$7DC0         ; $2733FE MOVE.W  <EA:3F>,-$40(A6,D7.L)
        DC.W    $7DBF,$7DBE         ; $273402 MOVE.W  <EA:3F>,-$42(A6,D7.L)
        MOVE.W  $7DB7(PC),-$4D(A6,D7.L)         ; $273406
        MOVE.W  $7E9F(A2),-$6D(A6,D7.L)         ; $27340C
        MOVE.W  D7,$79(A7,D7.L)                 ; $273412
        OR.W   -$7F9B(A7),D0                    ; $273416
        OR.W   (A5)+,D0                         ; $27341A
        OR.W   D0,(A4)+                         ; $27341C
        OR.W   D0,(A3)+                         ; $27341E
        OR.W   D0,(A2)                          ; $273420
        OR.W   D1,D1                            ; $273422
        OR.B   D1,-$7DE4(A5)                    ; $273424
        OR.B   (A7),D1                          ; $273428
        OR.B   (A4),D1                          ; $27342A
        OR.B   D0,(A3)                          ; $27342C
        OR.B   D0,(A3)                          ; $27342E
        OR.B   (A5),D0                          ; $273430
        OR.B   (A7),D0                          ; $273432
        OR.B   (A0)+,D0                         ; $273434
        MOVE.W  (A2)+,-(A7)                     ; $273436
        MOVE.W  (A3)+,-(A7)                     ; $273438
        MOVE.W  (A5)+,-(A7)                     ; $27343A
        MOVEQ   #$26,D7                         ; $27343C
        MOVE.W  $3E(A2,D7.L),-(A6)              ; $27343E
        MOVEQ   #$4A,D7                         ; $273442
        MOVEQ   #$58,D7                         ; $273444
        MOVEQ   #$60,D7                         ; $273446
        MOVEQ   #$62,D7                         ; $273448
        MOVE.W  -(A0),-$7FA5(A7)                ; $27344A
        OR.W   (A7),D0                          ; $27344E
        OR.W   (A5),D0                          ; $273450
        OR.W   (A6),D0                          ; $273452
        OR.W   (A7),D0                          ; $273454
        OR.W   (A4)+,D0                         ; $273456
        MOVE.W  -(A6),$7F71(A7)                 ; $273458
        MOVE.W  -$7A(PC,D7.L),$7F96(A7)         ; $27345C
        MOVEQ   #-$57,D7                        ; $273462
        MOVEQ   #-$42,D7                        ; $273464
        MOVEQ   #-$36,D7                        ; $273466
        DC.W    $7FCD               ; $273468 MOVE.W  A5,<EA:3F>
        DC.W    $7FCA               ; $27346A MOVE.W  A2,<EA:3F>
        DC.W    $7FC4               ; $27346C MOVE.W  D4,<EA:3F>
        MOVE.W  #$7EB3,-$55(A7,D7.L)            ; $27346E
        MOVEQ   #-$5A,D7                        ; $273474
        MOVE.W  -(A0),-$61(A7,D7.L)             ; $273476
        OR.L   -(A2),D0                         ; $27347A
        OR.L   -(A6),D0                         ; $27347C
        MOVE.W  -$7F54(A0),-$51(A7,A0.W)        ; $27347E
        MOVE.W  -$50(A0,D7.L),-$4D(A7,D7.L)     ; $273484
        MOVEQ   #-$48,D7                        ; $27348A
        DC.W    $7DBE,$7DC3         ; $27348C MOVE.W  <EA:3E>,-$3D(A6,D7.L)
        DC.W    $7DC7               ; $273490 MOVE.W  D7,<EA:3E>
        DC.W    $7DC7               ; $273492 MOVE.W  D7,<EA:3E>
        DC.W    $7DC5               ; $273494 MOVE.W  D5,<EA:3E>
        DC.W    $7DC2               ; $273496 MOVE.W  D2,<EA:3E>
        MOVEQ   #-$43,D7                        ; $273498
        MOVEQ   #-$49,D7                        ; $27349A
        MOVE.W  $7FA4(A6),-$61(A7,D7.L)         ; $27349C
        MOVEQ   #-$62,D7                        ; $2734A2
        MOVEQ   #-$63,D7                        ; $2734A4
        MOVEQ   #-$66,D7                        ; $2734A6
        MOVE.W  (A5),-$71(A7,D7.L)              ; $2734A8
        MOVE.W  A0,$7E(A7,A0.W)                 ; $2734AC
        OR.W   -$7FA3(A7),D0                    ; $2734B0
        OR.W   A1,D0                            ; $2734B4
        OR.B   $25(A7,A0.W),D0                  ; $2734B6
        OR.B   D0,(A0)+                         ; $2734BA
        OR.B   D0,(A4)                          ; $2734BC
        OR.B   D0,(A3)                          ; $2734BE
        OR.B   (A3),D0                          ; $2734C0
        OR.B   D0,(A4)                          ; $2734C2
        OR.B   D0,(A6)                          ; $2734C4
        OR.B   D0,(A0)+                         ; $2734C6
        OR.B   (A1)+,D0                         ; $2734C8
        MOVE.W  (A3)+,-(A7)                     ; $2734CA
        MOVE.W  (A5)+,-(A7)                     ; $2734CC
        MOVE.W  -(A7),-(A7)                     ; $2734CE
        MOVE.W  $47(A7,D7.L),-(A7)              ; $2734D0
        MOVEQ   #$53,D7                         ; $2734D4
        MOVEQ   #$5B,D7                         ; $2734D6
        MOVEQ   #$62,D7                         ; $2734D8
        MOVEQ   #$66,D7                         ; $2734DA
        MOVEQ   #$66,D7                         ; $2734DC
        MOVE.W  -(A2),$7F5F(A7)                 ; $2734DE
        MOVE.W  (A4)+,$7E5C(A7)                 ; $2734E2
        MOVEQ   #$5F,D7                         ; $2734E6
        MOVEQ   #$60,D7                         ; $2734E8
        MOVE.W  (A7)+,$7F5F(A7)                 ; $2734EA
        MOVE.W  -(A3),$7F6C(A7)                 ; $2734EE
        MOVE.W  -$78(A7,D7.L),$7F9E(A7)         ; $2734F2
        MOVE.W  -$41(A1,D7.L),-$39(A7,A0.W)     ; $2734F8
        DC.W    $7FCC               ; $2734FE MOVE.W  A4,<EA:3F>
        DC.W    $7FCC               ; $273500 MOVE.W  A4,<EA:3F>
        DIVU    D4,D0                           ; $273502
        OR.L   $80AF80A8,D0                     ; $273504
        MOVE.W  -(A5),-$59(A7,D7.L)             ; $27350A
        MOVEQ   #-$56,D7                        ; $27350E
        MOVEQ   #-$54,D7                        ; $273510
        MOVEQ   #-$52,D7                        ; $273512
        MOVE.W  -$4B(A1,D7.L),-$49(A6,D7.L)     ; $273514
        MOVEQ   #-$4B,D6                        ; $27351A
        MOVEQ   #-$4C,D6                        ; $27351C
        MOVEQ   #-$4B,D6                        ; $27351E
        MOVEQ   #-$49,D6                        ; $273520
        MOVEQ   #-$48,D6                        ; $273522
        MOVEQ   #-$47,D6                        ; $273524
        MOVE.W  $7DBA(PC),-$47(A6,D7.L)         ; $273526
        MOVE.W  -$4D(A7,D7.L),-$51(A6,D7.L)     ; $27352C
        MOVEQ   #-$55,D7                        ; $273532
        MOVE.W  -(A2),-$6A(A7,A0.W)             ; $273534
        OR.L   A2,D0                            ; $273538
        DC.W    $817D               ; $27353A OR.W   D0,<EA:3D>
        OR.W   D0,$6B(A3,A0.W)                  ; $27353C
        OR.W   D0,(A6)+                         ; $273540
        OR.W   A3,D1                            ; $273542
        OR.B   D1,$1E(A1,A0.W)                  ; $273544
        OR.B   (A0)+,D2                         ; $273548
        OR.B   D1,(A5)                          ; $27354A
        OR.B   (A4),D1                          ; $27354C
        OR.B   (A5),D1                          ; $27354E
        OR.B   (A6),D1                          ; $273550
        OR.B   D0,(A0)+                         ; $273552
        OR.B   D0,(A1)+                         ; $273554
        OR.B   (A3)+,D0                         ; $273556
        OR.B   (A4)+,D0                         ; $273558
        OR.B   (A6)+,D0                         ; $27355A
        OR.B   -(A2),D0                         ; $27355C
        MOVE.W  $7F37(A3),-(A7)                 ; $27355E
        MOVEQ   #$40,D7                         ; $273562
        MOVEQ   #$47,D7                         ; $273564
        MOVEQ   #$4E,D7                         ; $273566
        MOVE.W  (A7),$7E5F(A7)                  ; $273568
        MOVEQ   #$67,D7                         ; $27356C
        MOVEQ   #$6D,D7                         ; $27356E
        MOVEQ   #$73,D7                         ; $273570
        MOVEQ   #$79,D7                         ; $273572
        MOVEQ   #-$7F,D7                        ; $273574
        MOVEQ   #-$78,D7                        ; $273576
        MOVE.W  A6,-$6E(A7,A0.W)                ; $273578
        OR.L   (A5),D0                          ; $27357C
        OR.L   (A4)+,D0                         ; $27357E
        MOVE.W  -(A7),-$4B(A7,D7.L)             ; $273580
        DC.W    $7FC0               ; $273584 MOVE.W  D0,<EA:3F>
        DC.W    $7FC7               ; $273586 MOVE.W  D7,<EA:3F>
        DIVU    A1,D0                           ; $273588
        DIVU    D4,D0                           ; $27358A
        OR.L   D0,-$7D4F(PC)                    ; $27358C
        OR.L   D0,-$7F60(A1)                    ; $273590
        OR.L   (A4)+,D0                         ; $273594
        MOVE.W  (A7)+,-$5D(A7,D7.L)             ; $273596
        MOVE.W  $7FAE(A1),-$52(A7,D7.L)         ; $27359A
        MOVE.W  $7DA9(A2),-$53(A6,D7.L)         ; $2735A0
        MOVEQ   #-$52,D6                        ; $2735A6
        MOVEQ   #-$56,D6                        ; $2735A8
        MOVEQ   #-$5B,D6                        ; $2735AA
        MOVEQ   #-$57,D6                        ; $2735AC
        MOVE.W  -$43(A4,D7.L),-$3D(A5,D7.L)     ; $2735AE
        MOVEQ   #-$38,D7                        ; $2735B4
        MOVEQ   #-$37,D7                        ; $2735B6
        MOVEQ   #-$3B,D7                        ; $2735B8
        DC.W    $7FC1               ; $2735BA MOVE.W  D1,<EA:3F>
        DC.W    $80BD               ; $2735BC OR.L   <EA:3D>,D0
        OR.L   -$4F(A6,A0.W),D0                 ; $2735BE
        OR.L   -$7F62(A4),D0                    ; $2735C2
        OR.L   D0,A3                            ; $2735C6
        OR.W   D0,#$8170                        ; $2735C8
        OR.W   -(A0),D0                         ; $2735CC
        OR.W   A6,D0                            ; $2735CE
        DC.W    $803D               ; $2735D0 OR.B   <EA:3D>,D0
        OR.B   -$7FE3(A3),D0                    ; $2735D2
        OR.B   D0,(A6)                          ; $2735D6
        OR.B   (A4),D1                          ; $2735D8
        OR.B   (A3),D1                          ; $2735DA
        OR.B   (A4),D1                          ; $2735DC
        OR.B   D0,(A5)                          ; $2735DE
        OR.B   D0,(A7)                          ; $2735E0
        OR.B   D0,(A0)+                         ; $2735E2
        OR.B   (A1)+,D0                         ; $2735E4
        MOVE.W  (A3)+,-(A7)                     ; $2735E6
        MOVE.W  (A4)+,-(A7)                     ; $2735E8
        OR.B   (A5)+,D0                         ; $2735EA
        MOVE.W  -(A0),-(A7)                     ; $2735EC
        MOVEQ   #$2A,D7                         ; $2735EE
        MOVEQ   #$34,D7                         ; $2735F0
        MOVEQ   #$3C,D7                         ; $2735F2
        MOVE.W  D1,$7F43(A7)                    ; $2735F4
        OR.W   D6,D0                            ; $2735F8
        OR.W   A5,D0                            ; $2735FA
        OR.W   (A1)+,D0                         ; $2735FC
        MOVE.W  $7F7B(A2),$7E88(A7)             ; $2735FE
        MOVEQ   #-$6E,D7                        ; $273604
        MOVE.W  -(A0),-$54(A7,D7.L)             ; $273606
        MOVE.W  -$48(A4,A0.W),-$46(A7,A0.W)     ; $27360A
        OR.L   D0,$80BC80C1                     ; $273610
        DC.W    $7FC6               ; $273616 MOVE.W  D6,<EA:3F>
        DIVU    A6,D0                           ; $273618
        DIVU    (A5),D0                         ; $27361A
        DIVS    (A6),D0                         ; $27361C
        DIVS    A4,D0                           ; $27361E
        DC.W    $80BF               ; $273620 OR.L   <EA:3F>,D0
        MOVE.W  -$56(A4,D7.L),-$60(A7,D7.L)     ; $273622
        MOVE.W  (A1)+,-$6C(A7,D7.L)             ; $273628
        MOVEQ   #-$70,D7                        ; $27362C
        MOVE.W  A4,-$74(A6,D7.L)                ; $27362E
        MOVEQ   #-$6F,D6                        ; $273632
        MOVEQ   #-$6A,D6                        ; $273634
        MOVE.W  (A0)+,-$68(A6,D7.L)             ; $273636
        MOVEQ   #-$66,D7                        ; $27363A
        MOVEQ   #-$63,D7                        ; $27363C
        MOVE.W  (A7)+,-$5C(A6,D7.L)             ; $27363E
        MOVE.W  $7DB9(A6),-$3E(A6,D7.L)         ; $273642
        MOVEQ   #-$38,D7                        ; $273648
        DC.W    $7FC9               ; $27364A MOVE.W  A1,<EA:3F>
        DIVU    D7,D0                           ; $27364C
        DC.W    $80BF               ; $27364E OR.L   <EA:3F>,D0
        OR.L   -$64(A0,A0.W),D0                 ; $273650
        OR.L   D5,D1                            ; $273654
        OR.W   $66(A1,A0.W),D1                  ; $273656
        OR.W   D0,(A7)+                         ; $27365A
        OR.W   D0,(A7)                          ; $27365C
        OR.W   D0,A6                            ; $27365E
        OR.W   D0,D4                            ; $273660
        OR.B   D0,$22(A4,A0.W)                  ; $273662
        OR.B   (A1)+,D1                         ; $273666
        OR.B   (A6),D1                          ; $273668
        OR.B   (A5),D1                          ; $27366A
        OR.B   (A5),D1                          ; $27366C
        OR.B   D0,(A6)                          ; $27366E
        OR.B   D0,(A0)+                         ; $273670
        OR.B   D0,(A1)+                         ; $273672
        OR.B   (A3)+,D0                         ; $273674
        MOVE.W  -(A1),-(A7)                     ; $273676
        MOVE.W  -$7FD0(A3),-(A7)                ; $273678
        OR.B   $36(A4,D7.L),D0                  ; $27367C
        MOVE.W  $3A(A7,D7.L),-(A7)              ; $273680
        MOVEQ   #$3B,D7                         ; $273684
        MOVE.W  $7F387F38,-(A7)                 ; $273686
        DC.W    $7F3E               ; $27368C MOVE.W  <EA:3E>,-(A7)
        MOVE.W  A0,$7F56(A7)                    ; $27368E
        MOVEQ   #$66,D7                         ; $273692
        MOVE.W  $7F87.W,$7F93(A7)               ; $273694
        OR.L   -(A1),D0                         ; $27369A
        OR.L   -$40(A2,A0.W),D0                 ; $27369C
        DIVU    A4,D0                           ; $2736A0
        DIVU    (A2),D0                         ; $2736A2
        DIVU    (A3),D0                         ; $2736A4
        DIVU    A6,D0                           ; $2736A6
        DIVU    D7,D0                           ; $2736A8
        DC.W    $7FBF,$7FB5         ; $2736AA MOVE.W  <EA:3F>,-$4B(A7,D7.L)
        MOVE.W  $7FA6(A4),-$58(A7,D7.L)         ; $2736AE
        MOVEQ   #-$52,D7                        ; $2736B4
        MOVE.W  -$4B(A5,D7.L),-$50(A6,D7.L)     ; $2736B6
        MOVEQ   #-$54,D7                        ; $2736BC
        MOVEQ   #-$57,D7                        ; $2736BE
        MOVE.W  -(A5),-$5B(A6,D7.L)             ; $2736C0
        MOVEQ   #-$55,D7                        ; $2736C4
        MOVE.W  -$43(A5,D7.L),-$3E(A6,D7.L)     ; $2736C6
        MOVEQ   #-$3D,D7                        ; $2736CC
        MOVEQ   #-$3F,D7                        ; $2736CE
        DC.W    $7FBD,$7FB8         ; $2736D0 MOVE.W  <EA:3D>,-$48(A7,D7.L)
        OR.L   -$57(A1,A0.W),D0                 ; $2736D4
        OR.L   -(A2),D0                         ; $2736D8
        OR.L   -(A0),D0                         ; $2736DA
        OR.L   -(A1),D0                         ; $2736DC
        MOVE.W  -(A2),-$5E(A7,A0.W)             ; $2736DE
        OR.L   (A7)+,D0                         ; $2736E2
        OR.L   (A1)+,D0                         ; $2736E4
        OR.L   D0,(A1)                          ; $2736E6
        OR.L   D0,A1                            ; $2736E8
        DC.W    $817F               ; $2736EA OR.W   D0,<EA:3F>
        OR.W   D0,$5F(A1,A0.W)                  ; $2736EC
        OR.W   D0,A5                            ; $2736F0
        OR.W   D0,D2                            ; $2736F2
        OR.B   $26(A5,A0.W),D0                  ; $2736F4
        OR.B   D0,(A2)+                         ; $2736F8
        OR.B   D0,(A7)                          ; $2736FA
        OR.B   D0,(A6)                          ; $2736FC
        OR.B   D0,(A5)                          ; $2736FE
        OR.B   D0,(A6)                          ; $273700
        OR.B   (A0)+,D0                         ; $273702
        MOVE.W  (A1)+,-(A7)                     ; $273704
        MOVE.W  (A3)+,-(A7)                     ; $273706
        MOVE.W  (A4)+,-(A7)                     ; $273708
        MOVEQ   #$1E,D7                         ; $27370A
        MOVE.W  -(A3),-(A6)                     ; $27370C
        MOVE.W  $7C32(A2),-(A6)                 ; $27370E
        MOVE.W  $7D3F7E47,-(A6)                 ; $273712
        MOVEQ   #$50,D7                         ; $273718
        MOVE.W  (A1)+,-$7F9D(A7)                ; $27371A
        OR.W   D0,-$7E8E(A4)                    ; $27371E
        OR.W   $7B(A6,A0.W),D1                  ; $273722
        OR.L   D0,D1                            ; $273726
        OR.L   D0,D1                            ; $273728
        OR.L   D0,D4                            ; $27372A
        OR.L   D0,A7                            ; $27372C
        OR.L   -(A3),D0                         ; $27372E
        MOVE.W  -$32(PC,D7.L),-$28(A7,A0.W)     ; $273730
        DC.W    $7FDC               ; $273736 MOVE.W  (A4)+,<EA:3F>
        MOVEQ   #-$29,D7                        ; $273738
        MOVEQ   #-$33,D7                        ; $27373A
        DC.W    $7DC0               ; $27373C MOVE.W  D0,<EA:3E>
        MOVE.W  -$58(A3,D7.L),-$5E(A6,D7.L)     ; $27373E
        MOVE.W  (A7)+,-$61(A6,D7.L)             ; $273744
        MOVE.W  -(A2),-$5A(A6,D7.L)             ; $273748
        MOVEQ   #-$59,D7                        ; $27374C
        MOVEQ   #-$56,D7                        ; $27374E
        MOVEQ   #-$52,D7                        ; $273750
        MOVE.W  $7DAE(A7),-$55(A6,D7.L)         ; $273752
        MOVEQ   #-$5A,D7                        ; $273758
        MOVEQ   #-$5C,D7                        ; $27375A
        MOVEQ   #-$5C,D7                        ; $27375C
        MOVEQ   #-$5A,D7                        ; $27375E
        MOVE.W  $7FAA(A0),-$53(A7,D7.L)         ; $273760
        MOVE.W  -$50(A1,D7.L),-$55(A7,A0.W)     ; $273766
        OR.L   -(A7),D0                         ; $27376C
        OR.L   -(A5),D0                         ; $27376E
        OR.L   -(A2),D0                         ; $273770
        OR.L   -(A2),D0                         ; $273772
        OR.L   -(A6),D0                         ; $273774
        OR.L   -(A7),D0                         ; $273776
        OR.L   (A5)+,D0                         ; $273778
        OR.L   D0,A6                            ; $27377A
        DC.W    $817E               ; $27377C OR.W   D0,<EA:3E>
        OR.W   -$7FAA(A5),D0                    ; $27377E
        DC.W    $803F               ; $273782 OR.B   <EA:3F>,D0
        OR.B   D0,-$7EE6(A1)                    ; $273784
        OR.B   (A6),D0                          ; $273788
        OR.B   (A3),D0                          ; $27378A
        OR.B   D0,(A3)                          ; $27378C
        OR.B   D0,(A4)                          ; $27378E
        OR.B   (A6),D0                          ; $273790
        OR.B   (A0)+,D0                         ; $273792
        OR.B   (A1)+,D0                         ; $273794
        OR.B   (A2)+,D0                         ; $273796
        OR.B   (A4)+,D0                         ; $273798
        MOVE.W  (A5)+,-(A7)                     ; $27379A
        MOVE.W  -(A1),-(A7)                     ; $27379C
        MOVE.W  -(A5),-(A7)                     ; $27379E
        OR.B   -$7FD5(A0),D0                    ; $2737A0
        OR.B   $3F(A3,A0.W),D0                  ; $2737A4
        OR.W   A5,D0                            ; $2737A8
        OR.W   D0,(A7)                          ; $2737AA
        OR.W   -(A0),D1                         ; $2737AC
        OR.W   -$7D8F(A0),D1                    ; $2737AE
        OR.W   $79(A6,A0.W),D1                  ; $2737B2
        DC.W    $827D               ; $2737B6 OR.W   <EA:3D>,D1
        OR.L   D0,D7                            ; $2737B8
        OR.L   D0,(A5)                          ; $2737BA
        OR.L   -(A5),D0                         ; $2737BC
        MOVE.W  -$3C(A6,D7.L),-$32(A7,D7.L)     ; $2737BE
        DC.W    $7DCF               ; $2737C4 MOVE.W  A7,<EA:3E>
        DC.W    $7DCB               ; $2737C6 MOVE.W  A3,<EA:3E>
        MOVEQ   #-$39,D6                        ; $2737C8
        MOVEQ   #-$3E,D6                        ; $2737CA
        MOVE.W  -$4C(PC,D7.L),-$56(A6,D7.L)     ; $2737CC
        MOVEQ   #-$5E,D7                        ; $2737D2
        MOVEQ   #-$5E,D7                        ; $2737D4
        MOVEQ   #-$5A,D7                        ; $2737D6
        MOVEQ   #-$5A,D7                        ; $2737D8
        MOVE.W  -(A1),-$63(A7,D7.L)             ; $2737DA
        MOVE.W  (A6)+,-$5D(A7,D7.L)             ; $2737DE
        MOVEQ   #-$56,D7                        ; $2737E2
        MOVE.W  $7FA8(A5),-$61(A7,A0.W)         ; $2737E4
        MOVE.W  (A1)+,-$66(A7,D7.L)             ; $2737EA
        OR.L   -(A1),D0                         ; $2737EE
        OR.L   D0,-$7E54(A1)                    ; $2737F0
        OR.L   D0,-$7E51(A4)                    ; $2737F4
        OR.L   -$40(A7,D7.L),D0                 ; $2737F8
        MOVEQ   #-$3A,D7                        ; $2737FC
        MOVEQ   #-$37,D7                        ; $2737FE
        MOVEQ   #-$39,D7                        ; $273800
        MOVEQ   #-$3F,D7                        ; $273802
        MOVEQ   #-$49,D7                        ; $273804
        MOVEQ   #-$55,D7                        ; $273806
        MOVE.W  (A5)+,-$6E(A6,D7.L)             ; $273808
        MOVEQ   #-$7A,D7                        ; $27380C
        MOVE.W  $58(A2,A0.W),-$7EC3(A7)         ; $27380E
        OR.B   D0,-(A5)                         ; $273814
        OR.B   D0,(A0)+                         ; $273816
        OR.B   (A4),D1                          ; $273818
        OR.B   (A1),D1                          ; $27381A
        OR.B   D0,(A1)                          ; $27381C
        OR.B   D0,(A3)                          ; $27381E
        OR.B   D0,(A5)                          ; $273820
        OR.B   (A6),D1                          ; $273822
        OR.B   (A0)+,D1                         ; $273824
        OR.B   (A1)+,D1                         ; $273826
        OR.B   (A2)+,D1                         ; $273828
        OR.B   (A4)+,D1                         ; $27382A
        OR.B   D0,(A5)+                         ; $27382C
        OR.B   (A6)+,D0                         ; $27382E
        OR.B   -(A0),D0                         ; $273830
        OR.B   -(A7),D0                         ; $273832
        OR.B   -$7EC8(A7),D0                    ; $273834
        OR.W   D0,D3                            ; $273838
        OR.W   (A2),D0                          ; $27383A
        OR.W   -(A6),D0                         ; $27383C
        MOVE.W  #$7E8A,$7F96(A7)                ; $27383E
        MOVE.W  -(A4),-$52(A7,D7.L)             ; $273844
        MOVE.W  -$3A(A6,D7.L),-$2A(A7,D7.L)     ; $273848
        MOVEQ   #-$25,D6                        ; $27384E
        DC.W    $7DD7               ; $273850 MOVE.W  (A7),<EA:3E>
        MOVEQ   #-$2A,D7                        ; $273852
        MOVEQ   #-$25,D7                        ; $273854
        MOVEQ   #-$25,D7                        ; $273856
        MOVEQ   #-$27,D7                        ; $273858
        DC.W    $7FD4               ; $27385A MOVE.W  (A4),<EA:3F>
        DC.W    $7FCA               ; $27385C MOVE.W  A2,<EA:3F>
        MOVEQ   #-$47,D7                        ; $27385E
        MOVE.W  -(A4),-$6C(A7,D7.L)             ; $273860
        MOVE.W  A1,-$7D(A7,D7.L)                ; $273864
        MOVE.W  D2,-$7A(A7,D7.L)                ; $273868
        MOVE.W  A4,-$6E(A7,D7.L)                ; $27386C
        MOVE.W  (A6),-$6B(A7,D7.L)              ; $273870
        OR.L   (A1),D0                          ; $273874
        OR.L   A6,D0                            ; $273876
        MOVE.W  (A0),-$6C(A7,D7.L)              ; $273878
        MOVE.W  (A4),-$6B(A7,D7.L)              ; $27387C
        MOVEQ   #-$65,D7                        ; $273880
        MOVEQ   #-$60,D7                        ; $273882
        MOVEQ   #-$5A,D7                        ; $273884
        MOVE.W  -$46(A0,A0.W),-$3E(A7,D7.L)     ; $273886
        MOVEQ   #-$38,D7                        ; $27388C
        DC.W    $7DCC               ; $27388E MOVE.W  A4,<EA:3E>
        DC.W    $7DC7               ; $273890 MOVE.W  D7,<EA:3E>
        DC.W    $7DBD,$7EB0         ; $273892 MOVE.W  <EA:3D>,-$50(A6,D7.L)
        MOVEQ   #-$60,D7                        ; $273896
        MOVE.W  A5,$79(A7,A0.W)                 ; $273898
        OR.W   -(A6),D0                         ; $27389C
        OR.W   D0,(A2)                          ; $27389E
        OR.B   D0,#$8226                        ; $2738A0
        OR.B   (A0)+,D1                         ; $2738A4
        OR.B   (A3),D1                          ; $2738A6
        OR.B   D1,(A1)                          ; $2738A8
        OR.B   (A1),D2                          ; $2738AA
        OR.B   D1,(A2)                          ; $2738AC
        OR.B   (A3),D1                          ; $2738AE
        OR.B   (A5),D1                          ; $2738B0
        OR.B   (A6),D1                          ; $2738B2
        OR.B   (A0)+,D1                         ; $2738B4
        OR.B   (A1)+,D1                         ; $2738B6
        OR.B   (A2)+,D0                         ; $2738B8
        MOVE.W  (A3)+,-(A7)                     ; $2738BA
        OR.B   (A5)+,D0                         ; $2738BC
        OR.B   (A6)+,D0                         ; $2738BE
        MOVE.W  -(A0),-(A7)                     ; $2738C0
        MOVE.W  $7F38(A0),-(A7)                 ; $2738C2
        MOVE.W  D7,-$7FB0(A7)                   ; $2738C6
        OR.W   (A0)+,D0                         ; $2738CA
        OR.W   -(A1),D0                         ; $2738CC
        OR.W   -$7F89(A4),D0                    ; $2738CE
        MOVE.W  D3,-$6A(A7,D7.L)                ; $2738D2
        MOVEQ   #-$56,D7                        ; $2738D6
        DC.W    $7DBF,$7DD1         ; $2738D8 MOVE.W  <EA:3F>,-$2F(A6,D7.L)
        DC.W    $7DDC               ; $2738DC MOVE.W  (A4)+,<EA:3E>
        MOVEQ   #-$22,D6                        ; $2738DE
        DC.W    $7DE0               ; $2738E0 MOVE.W  -(A0),<EA:3E>
        DC.W    $7DDF               ; $2738E2 MOVE.W  (A7)+,<EA:3E>
        MOVEQ   #-$26,D7                        ; $2738E4
        MOVEQ   #-$32,D7                        ; $2738E6
        DC.W    $7FC0               ; $2738E8 MOVE.W  D0,<EA:3F>
        MOVE.W  -$58(A2,D7.L),-$5C(A7,D7.L)     ; $2738EA
        MOVE.W  -(A2),-$62(A7,D7.L)             ; $2738F0
        OR.L   (A5)+,D0                         ; $2738F4
        OR.L   (A6)+,D0                         ; $2738F6
        MOVE.W  (A7)+,-$5F(A7,D7.L)             ; $2738F8
        MOVE.W  -(A4),-$5E(A7,A0.W)             ; $2738FC
        OR.L   (A4)+,D0                         ; $273900
        OR.L   (A2)+,D0                         ; $273902
        MOVE.W  (A3)+,-$63(A7,D7.L)             ; $273904
        MOVE.W  (A5)+,-$63(A7,A0.W)             ; $273908
        MOVE.W  -(A0),-$5B(A7,D7.L)             ; $27390C
        MOVEQ   #-$58,D7                        ; $273910
        MOVE.W  $7FB8(A6),-$42(A7,D7.L)         ; $273912
        MOVEQ   #-$49,D7                        ; $273918
        MOVE.W  $7EA6(A5),-$61(A7,D7.L)         ; $27391A
        MOVEQ   #-$68,D7                        ; $273920
        MOVEQ   #-$6C,D7                        ; $273922
        MOVE.W  (A0),-$78(A7,D7.L)              ; $273924
        OR.W   $6C(PC,A0.W),D0                  ; $273928
        OR.W   D0,(A7)                          ; $27392C
        DC.W    $813F               ; $27392E OR.B   D0,<EA:3F>
        OR.B   -(A7),D1                         ; $273930
        OR.B   (A1)+,D1                         ; $273932
        OR.B   D1,(A3)                          ; $273934
        OR.B   D1,(A1)                          ; $273936
        OR.B   (A1),D1                          ; $273938
        OR.B   (A2),D1                          ; $27393A
        OR.B   D0,(A4)                          ; $27393C
        OR.B   D0,(A5)                          ; $27393E
        OR.B   D0,(A7)                          ; $273940
        OR.B   D0,(A0)+                         ; $273942
        OR.B   (A2)+,D0                         ; $273944
        OR.B   (A3)+,D0                         ; $273946
        MOVE.W  (A5)+,-(A7)                     ; $273948
        MOVE.W  -(A5),-(A7)                     ; $27394A
        MOVE.W  $45(A6,D7.L),-(A7)              ; $27394C
        MOVEQ   #$50,D7                         ; $273950
        MOVE.W  (A5)+,$7F69(A7)                 ; $273952
        MOVE.W  $7F(A3,A0.W),-$7F74(A7)         ; $273956
        MOVE.W  (A5),-$68(A7,D7.L)              ; $27395C
        MOVE.W  (A2)+,-$6A(A7,D7.L)             ; $273960
        MOVE.W  D7,$7C(A7,D7.L)                 ; $273964
        MOVEQ   #-$7A,D7                        ; $273968
        MOVEQ   #-$62,D6                        ; $27396A
        MOVE.W  -$3A(A3,D7.L),-$2D(A5,D7.L)     ; $27396C
        DC.W    $7DD9               ; $273972 MOVE.W  (A1)+,<EA:3E>
        MOVEQ   #-$28,D7                        ; $273974
        MOVEQ   #-$30,D7                        ; $273976
        MOVEQ   #-$39,D7                        ; $273978
        MOVEQ   #-$43,D7                        ; $27397A
        MOVE.W  -$60(A0,D7.L),-$6F(A7,A0.W)     ; $27397C
        OR.L   D7,D0                            ; $273982
        MOVE.W  D4,-$77(A7,D7.L)                ; $273984
        MOVE.W  A7,-$6B(A7,D7.L)                ; $273988
        MOVE.W  (A3)+,-$62(A7,D7.L)             ; $27398C
        MOVE.W  (A5)+,-$66(A7,A0.W)             ; $273990
        MOVE.W  (A1)+,-$69(A7,D7.L)             ; $273994
        MOVE.W  (A3),-$6F(A7,D7.L)              ; $273998
        MOVE.W  (A5),-$66(A7,D7.L)              ; $27399C
        MOVEQ   #-$64,D7                        ; $2739A0
        MOVEQ   #-$60,D7                        ; $2739A2
        MOVEQ   #-$58,D7                        ; $2739A4
        MOVEQ   #-$51,D7                        ; $2739A6
        MOVEQ   #-$4A,D7                        ; $2739A8
        DC.W    $7DBD,$7DBD         ; $2739AA MOVE.W  <EA:3D>,-$43(A6,D7.L)
        MOVE.W  -$5A(A5,D7.L),-$68(A6,D7.L)     ; $2739AE
        MOVEQ   #-$73,D7                        ; $2739B4
        MOVE.W  D3,$75(A7,D7.L)                 ; $2739B6
        OR.W   -(A6),D0                         ; $2739BA
        OR.W   (A3),D0                          ; $2739BC
        OR.W   D0,D0                            ; $2739BE
        OR.B   D0,-$7EE3(A6)                    ; $2739C0
        OR.B   (A5),D1                          ; $2739C4
        OR.B   (A3),D2                          ; $2739C6
        OR.B   (A2),D2                          ; $2739C8
        OR.B   D1,(A2)                          ; $2739CA
        OR.B   D1,(A4)                          ; $2739CC
        OR.B   D1,(A6)                          ; $2739CE
        OR.B   D1,(A7)                          ; $2739D0
        OR.B   (A0)+,D1                         ; $2739D2
        OR.B   D0,(A2)+                         ; $2739D4
        OR.B   (A3)+,D0                         ; $2739D6
        OR.B   (A5)+,D0                         ; $2739D8
        MOVE.W  -(A1),-(A7)                     ; $2739DA
        MOVE.W  $7E3E(A6),-(A7)                 ; $2739DC
        MOVEQ   #$50,D7                         ; $2739E0
        MOVE.W  (A7)+,$7F69(A7)                 ; $2739E2
        MOVE.W  $7F6F(A4),$7F74(A7)             ; $2739E6
        MOVE.W  #$7F80,-$7F7F(A7)               ; $2739EC
        OR.L   D2,D0                            ; $2739F2
        MOVE.W  A0,-$6C(A7,D7.L)                ; $2739F4
        MOVEQ   #-$58,D7                        ; $2739F8
        MOVEQ   #-$40,D7                        ; $2739FA
        DC.W    $7DD2               ; $2739FC MOVE.W  (A2),<EA:3E>
        MOVEQ   #-$27,D6                        ; $2739FE
        MOVEQ   #-$24,D6                        ; $273A00
        MOVEQ   #-$22,D6                        ; $273A02
        DC.W    $7DDB               ; $273A04 MOVE.W  (A3)+,<EA:3E>
        MOVEQ   #-$2D,D7                        ; $273A06
        MOVEQ   #-$3B,D7                        ; $273A08
        MOVEQ   #-$4B,D7                        ; $273A0A
        MOVEQ   #-$58,D7                        ; $273A0C
        MOVEQ   #-$61,D7                        ; $273A0E
        MOVEQ   #-$66,D7                        ; $273A10
        MOVE.W  (A1)+,-$68(A7,A0.W)             ; $273A12
        OR.L   (A5),D0                          ; $273A16
        OR.L   D0,A7                            ; $273A18
        OR.L   D0,A0                            ; $273A1A
        OR.L   D0,D1                            ; $273A1C
        OR.L   D0,D0                            ; $273A1E
        MOVE.W  D3,-$76(A7,D7.L)                ; $273A20
        MOVE.W  (A1),-$67(A7,A0.W)              ; $273A24
        OR.L   -(A2),D0                         ; $273A28
        OR.L   -(A7),D0                         ; $273A2A
        MOVE.W  $7FAF(A1),-$4C(A7,D7.L)         ; $273A2C
        MOVEQ   #-$4B,D7                        ; $273A32
        MOVEQ   #-$4B,D7                        ; $273A34
        MOVEQ   #-$4E,D7                        ; $273A36
        MOVE.W  $7DA9(A3),-$52(A6,D7.L)         ; $273A38
        MOVEQ   #-$50,D6                        ; $273A3E
        MOVE.W  $7EAA(A6),-$64(A6,D7.L)         ; $273A40
        MOVEQ   #-$79,D7                        ; $273A46
        MOVE.W  $5C(A3,A0.W),-$7FBC(A7)         ; $273A48
        OR.B   D0,-$7DE2(A7)                    ; $273A4E
        OR.B   (A4),D1                          ; $273A52
        OR.B   D1,(A2)                          ; $273A54
        OR.B   D1,(A1)                          ; $273A56
        OR.B   (A1),D1                          ; $273A58
        OR.B   (A3),D1                          ; $273A5A
        OR.B   (A5),D1                          ; $273A5C
        OR.B   (A6),D1                          ; $273A5E
        OR.B   D0,(A0)+                         ; $273A60
        OR.B   D0,(A1)+                         ; $273A62
        OR.B   (A2)+,D0                         ; $273A64
        OR.B   (A4)+,D0                         ; $273A66
        OR.B   -(A1),D0                         ; $273A68
        OR.B   -$7FCF(A2),D0                    ; $273A6A
        OR.B   $42(A7,A0.W),D0                  ; $273A6E
        MOVE.W  (A0),$7E62(A7)                  ; $273A72
        MOVE.W  $7D87.W,$7E91(A6)               ; $273A76
        MOVEQ   #-$69,D7                        ; $273A7C
        MOVEQ   #-$67,D7                        ; $273A7E
        MOVEQ   #-$68,D7                        ; $273A80
        MOVEQ   #-$65,D7                        ; $273A82
        MOVE.W  -(A6),-$4A(A6,D7.L)             ; $273A84
        MOVEQ   #-$39,D6                        ; $273A88
        MOVEQ   #-$2C,D6                        ; $273A8A
        MOVEQ   #-$27,D6                        ; $273A8C
        MOVEQ   #-$25,D6                        ; $273A8E
        MOVEQ   #-$24,D6                        ; $273A90
        DC.W    $7DD9               ; $273A92 MOVE.W  (A1)+,<EA:3E>
        DC.W    $7DCC               ; $273A94 MOVE.W  A4,<EA:3E>
        MOVEQ   #-$46,D7                        ; $273A96
        MOVE.W  -(A6),-$69(A7,D7.L)             ; $273A98
        OR.L   A6,D0                            ; $273A9C
        OR.L   A2,D0                            ; $273A9E
        OR.L   A1,D0                            ; $273AA0
        OR.L   A4,D0                            ; $273AA2
        OR.L   (A0),D0                          ; $273AA4
        OR.L   A4,D0                            ; $273AA6
        OR.L   D5,D0                            ; $273AA8
        MOVE.W  D6,-$76(A7,D7.L)                ; $273AAA
        MOVE.W  A4,-$71(A6,D7.L)                ; $273AAE
        MOVEQ   #-$70,D7                        ; $273AB2
        MOVEQ   #-$73,D7                        ; $273AB4
        MOVE.W  A3,-$70(A7,D7.L)                ; $273AB6
        MOVEQ   #-$69,D7                        ; $273ABA
        MOVEQ   #-$64,D7                        ; $273ABC
        MOVE.W  -(A2),-$59(A7,D7.L)             ; $273ABE
        MOVEQ   #-$56,D7                        ; $273AC2
        MOVEQ   #-$55,D7                        ; $273AC4
        MOVEQ   #-$53,D7                        ; $273AC6
        MOVE.W  -$4F(A0,D7.L),-$54(A6,D7.L)     ; $273AC8
        MOVEQ   #-$5F,D7                        ; $273ACE
        MOVEQ   #-$6A,D7                        ; $273AD0
        MOVE.W  A5,-$7E(A7,D7.L)                ; $273AD2
        OR.W   $5D(A2,A0.W),D0                  ; $273AD6
        OR.W   D0,A1                            ; $273ADA
        OR.B   D0,$8124.W                       ; $273ADC
        OR.B   (A7),D1                          ; $273AE0
        OR.B   D1,(A5)                          ; $273AE2
        OR.B   D1,(A3)                          ; $273AE4
        OR.B   (A3),D1                          ; $273AE6
        OR.B   (A4),D1                          ; $273AE8
        OR.B   (A6),D1                          ; $273AEA
        OR.B   D0,(A7)                          ; $273AEC
        OR.B   (A1)+,D0                         ; $273AEE
        OR.B   (A2)+,D0                         ; $273AF0
        OR.B   (A4)+,D0                         ; $273AF2
        MOVE.W  (A6)+,-(A7)                     ; $273AF4
        MOVE.W  -(A6),-(A7)                     ; $273AF6
        OR.B   -$7FCF(A4),D0                    ; $273AF8
        OR.B   $3B(A6,A0.W),D0                  ; $273AFC
        OR.W   D5,D0                            ; $273B00
        MOVE.W  (A3),$7F61(A7)                  ; $273B02
        MOVEQ   #$69,D7                         ; $273B06
        MOVEQ   #$6E,D7                         ; $273B08
        MOVEQ   #$77,D7                         ; $273B0A
        MOVEQ   #-$7B,D7                        ; $273B0C
        MOVE.W  (A7),-$56(A6,D7.L)              ; $273B0E
        MOVEQ   #-$40,D6                        ; $273B12
        DC.W    $7BD5               ; $273B14 MOVE.W  (A5),<EA:3D>
        DC.W    $7BDC               ; $273B16 MOVE.W  (A4)+,<EA:3D>
        DC.W    $7BDF               ; $273B18 MOVE.W  (A7)+,<EA:3D>
        MOVEQ   #-$20,D6                        ; $273B1A
        MOVEQ   #-$20,D6                        ; $273B1C
        MOVEQ   #-$24,D6                        ; $273B1E
        MOVEQ   #-$2D,D6                        ; $273B20
        DC.W    $7DCA               ; $273B22 MOVE.W  A2,<EA:3E>
        MOVEQ   #-$3C,D7                        ; $273B24
        DC.W    $7FBF,$7FBA         ; $273B26 MOVE.W  <EA:3F>,-$46(A7,D7.L)
        MOVE.W  -$50(A5,D7.L),-$55(A7,D7.L)     ; $273B2A
        MOVE.W  -(A7),-$60(A7,D7.L)             ; $273B30
        MOVE.W  (A1)+,-$6E(A7,D7.L)             ; $273B34
        MOVE.W  (A0),-$71(A7,D7.L)              ; $273B38
        MOVE.W  (A0),-$70(A7,D7.L)              ; $273B3C
        OR.L   A3,D0                            ; $273B40
        OR.L   D5,D0                            ; $273B42
        OR.L   D3,D0                            ; $273B44
        MOVE.W  D4,-$7B(A7,D7.L)                ; $273B46
        MOVE.W  D7,-$79(A7,A0.W)                ; $273B4A
        MOVE.W  D7,-$7A(A7,D7.L)                ; $273B4E
        MOVEQ   #-$7C,D7                        ; $273B52
        MOVEQ   #-$7C,D7                        ; $273B54
        MOVE.W  A3,-$69(A6,D7.L)                ; $273B56
        MOVE.W  (A6)+,-$61(A5,D7.L)             ; $273B5A
        MOVE.W  (A7)+,-$65(A6,D7.L)             ; $273B5E
        MOVEQ   #-$6F,D7                        ; $273B62
        DC.W    $7F7F,$806A         ; $273B64 MOVE.W  <EA:3F>,-$7F96(A7)
        OR.W   (A5),D0                          ; $273B68
        OR.W   D3,D0                            ; $273B6A
        OR.B   $21(A1,A0.W),D0                  ; $273B6C
        OR.B   (A0)+,D1                         ; $273B70
        OR.B   (A6),D1                          ; $273B72
        OR.B   (A5),D1                          ; $273B74
        OR.B   D0,(A6)                          ; $273B76
        OR.B   D0,(A7)                          ; $273B78
        OR.B   (A1)+,D1                         ; $273B7A
        OR.B   (A2)+,D1                         ; $273B7C
        OR.B   D0,(A4)+                         ; $273B7E
        OR.B   D0,(A6)+                         ; $273B80
        OR.B   -(A6),D0                         ; $273B82
        OR.B   $44(A4,D7.L),D0                  ; $273B84
        MOVE.W  (A4),$7E64(A7)                  ; $273B88
        MOVEQ   #$71,D7                         ; $273B8C
        MOVEQ   #$79,D7                         ; $273B8E
        MOVEQ   #$7F,D7                         ; $273B90
        MOVEQ   #-$7C,D7                        ; $273B92
        MOVE.W  D6,-$79(A6,D7.L)                ; $273B94
        MOVE.W  A1,-$73(A6,D7.L)                ; $273B98
        MOVE.W  A6,-$72(A6,D7.L)                ; $273B9C
        MOVE.W  (A2),-$65(A6,D7.L)              ; $273BA0
        MOVE.W  $7BC7(A7),-$2C(A5,D7.L)         ; $273BA4
        DC.W    $7BD9               ; $273BAA MOVE.W  (A1)+,<EA:3D>
        MOVEQ   #-$25,D6                        ; $273BAC
        DC.W    $7DDA               ; $273BAE MOVE.W  (A2)+,<EA:3E>
        DC.W    $7DD1               ; $273BB0 MOVE.W  (A1),<EA:3E>
        DC.W    $7DC5               ; $273BB2 MOVE.W  D5,<EA:3E>
        MOVE.W  -$5D(A6,D7.L),-$6A(A6,D7.L)     ; $273BB4
        MOVE.W  (A2),-$72(A7,D7.L)              ; $273BBA
        MOVE.W  A0,-$7D(A7,D7.L)                ; $273BBE
        DC.W    $7F7F,$7F7A         ; $273BC2 MOVE.W  <EA:3F>,$7F7A(A7)
        OR.W   $6C(A4,A0.W),D0                  ; $273BC6
        OR.W   D0,-(A6)                         ; $273BCA
        OR.W   D0,-(A0)                         ; $273BCC
        OR.W   D0,-(A0)                         ; $273BCE
        OR.W   -(A7),D0                         ; $273BD0
        OR.W   $79(A0,A0.W),D0                  ; $273BD2
        OR.L   D0,D0                            ; $273BD6
        MOVE.W  D6,-$73(A7,D7.L)                ; $273BD8
        MOVEQ   #-$6B,D7                        ; $273BDC
        MOVE.W  (A5)+,-$5B(A6,D7.L)             ; $273BDE
        MOVE.W  $7CBB(A7),-$3A(A6,D7.L)         ; $273BE2
        MOVEQ   #-$33,D6                        ; $273BE8
        DC.W    $7DCF               ; $273BEA MOVE.W  A7,<EA:3E>
        DC.W    $7DCA               ; $273BEC MOVE.W  A2,<EA:3E>
        MOVEQ   #-$3F,D7                        ; $273BEE
        MOVEQ   #-$4C,D7                        ; $273BF0
        MOVE.W  -(A1),-$75(A7,A0.W)             ; $273BF2
        OR.W   D0,$8164.W                       ; $273BF6
        OR.W   D0,A6                            ; $273BFA
        OR.B   $8226.W,D1                       ; $273BFC
        OR.B   D1,(A2)+                         ; $273C00
        OR.B   D1,(A6)                          ; $273C02
        OR.B   D1,(A5)                          ; $273C04
        OR.B   (A4),D2                          ; $273C06
        OR.B   D1,(A6)                          ; $273C08
        OR.B   (A7),D1                          ; $273C0A
        OR.B   (A1)+,D1                         ; $273C0C
        OR.B   (A2)+,D1                         ; $273C0E
        OR.B   (A4)+,D1                         ; $273C10
        OR.B   D0,(A5)+                         ; $273C12
        OR.B   (A6)+,D0                         ; $273C14
        OR.B   -(A0),D0                         ; $273C16
        OR.B   -(A4),D0                         ; $273C18
        MOVE.W  $42(A0,D7.L),-(A7)              ; $273C1A
        MOVE.W  (A3),$7D61(A6)                  ; $273C1E
        MOVE.W  $7D73(A2),$7C7E(A6)             ; $273C22
        MOVEQ   #-$75,D6                        ; $273C28
        MOVEQ   #-$66,D6                        ; $273C2A
        MOVEQ   #-$56,D6                        ; $273C2C
        DC.W    $7BB9,$7BCA,$7AD9,$7ADD; $273C2E MOVE.W  $7BCA7AD9,-$23(A5,D7.L)
        MOVEQ   #-$22,D5                        ; $273C36
        DC.W    $7BDD               ; $273C38 MOVE.W  (A5)+,<EA:3D>
        MOVEQ   #-$2D,D6                        ; $273C3A
        MOVEQ   #-$36,D6                        ; $273C3C
        MOVEQ   #-$3B,D6                        ; $273C3E
        MOVEQ   #-$41,D6                        ; $273C40
        MOVE.W  -$56(A5,D7.L),-$5E(A6,D7.L)     ; $273C42
        MOVE.W  (A4)+,-$69(A7,A0.W)             ; $273C48
        OR.L   A5,D0                            ; $273C4C
        OR.L   D0,D1                            ; $273C4E
        OR.W   $68(A3,A0.W),D1                  ; $273C50
        OR.W   -(A5),D1                         ; $273C54
        OR.W   -$7D92(A0),D1                    ; $273C56
        OR.W   $7B(A4,A0.W),D1                  ; $273C5A
        OR.L   D0,D5                            ; $273C5E
        OR.L   (A0),D0                          ; $273C60
        MOVE.W  (A5)+,-$55(A7,D7.L)             ; $273C62
        MOVEQ   #-$4D,D7                        ; $273C66
        MOVEQ   #-$4E,D7                        ; $273C68
        MOVEQ   #-$4E,D7                        ; $273C6A
        MOVE.W  -$38(PC,D7.L),-$32(A6,D7.L)     ; $273C6C
        DC.W    $7BCF               ; $273C72 MOVE.W  A7,<EA:3D>
        MOVEQ   #-$30,D6                        ; $273C74
        MOVEQ   #-$31,D6                        ; $273C76
        DC.W    $7DC6               ; $273C78 MOVE.W  D6,<EA:3E>
        MOVE.W  -$61(A4,D7.L),-$75(A6,D7.L)     ; $273C7A
        MOVE.W  #$806F,-$7EA0(A7)               ; $273C80
        OR.W   (A4),D1                          ; $273C86
        OR.W   D6,D1                            ; $273C88
        OR.B   -$7CE4(A7),D1                    ; $273C8A
        OR.B   (A6),D2                          ; $273C8E
        OR.B   D1,(A4)                          ; $273C90
        OR.B   D1,(A2)                          ; $273C92
        OR.B   D1,(A3)                          ; $273C94
        OR.B   D1,(A5)                          ; $273C96
        OR.B   D1,(A6)                          ; $273C98
        OR.B   (A0)+,D1                         ; $273C9A
        OR.B   (A1)+,D1                         ; $273C9C
        OR.B   (A3)+,D1                         ; $273C9E
        OR.B   (A4)+,D1                         ; $273CA0
        OR.B   (A5)+,D1                         ; $273CA2
        OR.B   D0,-(A0)                         ; $273CA4
        MOVE.W  $7E41(A3),-(A7)                 ; $273CA6
        MOVE.W  (A2)+,$7C75(A6)                 ; $273CAA
        MOVE.W  A1,-$68(A5,D7.L)                ; $273CAE
        MOVEQ   #-$58,D6                        ; $273CB2
        MOVEQ   #-$48,D6                        ; $273CB4
        DC.W    $7BC6               ; $273CB6 MOVE.W  D6,<EA:3D>
        MOVEQ   #-$30,D5                        ; $273CB8
        MOVEQ   #-$2B,D5                        ; $273CBA
        MOVEQ   #-$28,D5                        ; $273CBC
        MOVE.W  (A3)+,#$78DB                    ; $273CBE
        MOVE.W  (A2)+,#$7AD9                    ; $273CC2
        DC.W    $7BD8               ; $273CC6 MOVE.W  (A0)+,<EA:3D>
        DC.W    $7BD6               ; $273CC8 MOVE.W  (A6),<EA:3D>
        MOVEQ   #-$2D,D6                        ; $273CCA
        MOVEQ   #-$3A,D7                        ; $273CCC
        MOVE.W  -$5B(A4,D7.L),-$62(A7,D7.L)     ; $273CCE
        MOVE.W  (A6),-$76(A7,D7.L)              ; $273CD4
        OR.W   D0,$8263834C                     ; $273CD8
        DC.W    $843D               ; $273CDE OR.B   <EA:3D>,D2
        OR.B   $40(PC,A0.W),D2                  ; $273CE0
        OR.W   D1,A3                            ; $273CE4
        OR.W   D1,(A2)+                         ; $273CE6
        OR.W   D1,-(A6)                         ; $273CE8
        OR.W   -$7D88(A7),D1                    ; $273CEA
        OR.L   D0,D4                            ; $273CEE
        MOVE.W  A6,-$6C(A7,D7.L)                ; $273CF0
        MOVE.W  (A3)+,-$5B(A6,D7.L)             ; $273CF4
        MOVE.W  -$43(A2,D7.L),-$38(A5,D7.L)     ; $273CF8
        DC.W    $7BCE               ; $273CFE MOVE.W  A6,<EA:3D>
        DC.W    $7BD0               ; $273D00 MOVE.W  (A0),<EA:3D>
        MOVEQ   #-$30,D6                        ; $273D02
        DC.W    $7DCF               ; $273D04 MOVE.W  A7,<EA:3E>
        DC.W    $7DC8               ; $273D06 MOVE.W  A0,<EA:3E>
        MOVEQ   #-$47,D7                        ; $273D08
        MOVEQ   #-$5C,D7                        ; $273D0A
        MOVE.W  A2,$71(A7,A0.W)                 ; $273D0C
        OR.W   -(A0),D0                         ; $273D10
        OR.W   D0,A3                            ; $273D12
        OR.B   $27(A7,A0.W),D1                  ; $273D14
        OR.B   D1,(A3)+                         ; $273D18
        OR.B   (A4),D1                          ; $273D1A
        OR.B   D1,(A2)                          ; $273D1C
        OR.B   (A2),D2                          ; $273D1E
        OR.B   (A3),D2                          ; $273D20
        OR.B   (A4),D2                          ; $273D22
        OR.B   (A6),D1                          ; $273D24
        OR.B   (A7),D1                          ; $273D26
        OR.B   D0,(A1)+                         ; $273D28
        OR.B   D0,(A2)+                         ; $273D2A
        OR.B   (A3)+,D0                         ; $273D2C
        OR.B   (A5)+,D0                         ; $273D2E
        OR.B   -(A1),D0                         ; $273D30
        MOVE.W  $7E3A(A4),-(A7)                 ; $273D32
        MOVEQ   #$46,D7                         ; $273D36
        MOVE.W  (A4),$7C64(A6)                  ; $273D38
        MOVE.W  $7C(A1,D7.L),$7A86(A5)          ; $273D3C
        MOVEQ   #-$6E,D5                        ; $273D42
        MOVEQ   #-$5E,D5                        ; $273D44
        MOVE.W  -$3D(A3,D7.L),-$2F(A4,D7.L)     ; $273D46
        MOVEQ   #-$26,D5                        ; $273D4C
        MOVEQ   #-$24,D5                        ; $273D4E
        MOVEQ   #-$24,D5                        ; $273D50
        DC.W    $7BD8               ; $273D52 MOVE.W  (A0)+,<EA:3D>
        DC.W    $7DC8               ; $273D54 MOVE.W  A0,<EA:3E>
        MOVEQ   #-$45,D7                        ; $273D56
        MOVEQ   #-$4A,D7                        ; $273D58
        MOVE.W  -$50(A3,D7.L),-$50(A7,A0.W)     ; $273D5A
        OR.L   D0,-$7E5D(A6)                    ; $273D60
        OR.L   (A6),D1                          ; $273D64
        OR.L   D1,A2                            ; $273D66
        DC.W    $847F               ; $273D68 OR.W   <EA:3F>,D2
        OR.W   $6A(A3,A0.W),D2                  ; $273D6A
        OR.W   -(A3),D2                         ; $273D6E
        OR.W   -(A3),D2                         ; $273D70
        OR.W   D1,-$7D8D(A1)                    ; $273D72
        DC.W    $817E               ; $273D76 OR.W   D0,<EA:3E>
        OR.L   A1,D0                            ; $273D78
        OR.L   A6,D0                            ; $273D7A
        MOVE.W  (A1),-$68(A7,D7.L)              ; $273D7C
        MOVE.W  -(A0),-$5D(A6,D7.L)             ; $273D80
        MOVEQ   #-$58,D6                        ; $273D84
        MOVEQ   #-$4F,D6                        ; $273D86
        MOVE.W  -$44(A7,D7.L),-$3E(A5,D7.L)     ; $273D88
        MOVEQ   #-$39,D5                        ; $273D8E
        DC.W    $7BC6               ; $273D90 MOVE.W  D6,<EA:3D>
        MOVEQ   #-$40,D6                        ; $273D92
        MOVE.W  -$55(A7,D7.L),-$64(A6,D7.L)     ; $273D94
        OR.L   A2,D0                            ; $273D9A
        OR.W   -$7F95(PC),D0                    ; $273D9C
        OR.W   D0,(A4)+                         ; $273DA0
        OR.W   D0,A3                            ; $273DA2
        OR.B   D1,$1E(A3,A0.W)                  ; $273DA4
        OR.B   (A6),D2                          ; $273DA8
        OR.B   (A3),D2                          ; $273DAA
        OR.B   D1,(A1)                          ; $273DAC
        OR.B   D1,(A2)                          ; $273DAE
        OR.B   (A3),D1                          ; $273DB0
        OR.B   (A5),D1                          ; $273DB2
        OR.B   D0,(A7)                          ; $273DB4
        OR.B   D0,(A0)+                         ; $273DB6
        OR.B   D0,(A1)+                         ; $273DB8
        OR.B   (A3)+,D0                         ; $273DBA
        OR.B   (A5)+,D0                         ; $273DBC
        MOVE.W  -(A7),-(A7)                     ; $273DBE
        MOVE.W  $49(A7,D7.L),-(A7)              ; $273DC0
        MOVEQ   #$59,D6                         ; $273DC4
        MOVE.W  $7B77(A1),$7B84(A5)             ; $273DC6
        MOVE.W  A7,-$68(A5,D7.L)                ; $273DCC
        MOVEQ   #-$60,D5                        ; $273DD0
        MOVEQ   #-$5F,D5                        ; $273DD2
        MOVE.W  (A4)+,-$67(A5,D7.L)             ; $273DD4
        MOVEQ   #-$5C,D5                        ; $273DD8
        MOVEQ   #-$49,D5                        ; $273DDA
        MOVEQ   #-$38,D5                        ; $273DDC
        MOVEQ   #-$2D,D6                        ; $273DDE
        DC.W    $7DD7               ; $273DE0 MOVE.W  (A7),<EA:3E>
        MOVEQ   #-$27,D7                        ; $273DE2
        DC.W    $7FD7               ; $273DE4 MOVE.W  (A7),<EA:3F>
        DIVU    A0,D0                           ; $273DE6
        OR.L   D0,-$67(A2,A0.W)                 ; $273DE8
        OR.L   D0,D5                            ; $273DEC
        OR.W   #$8277,D1                        ; $273DEE
        OR.W   $75(A4,A0.W),D1                  ; $273DF2
        OR.W   $8279.W,D1                       ; $273DF6
        OR.W   $72(A6,A0.W),D1                  ; $273DFA
        OR.W   -$7E95(A7),D1                    ; $273DFE
        OR.W   $7F70(A3),D0                     ; $273E02
        MOVE.W  $7E(A6,D7.L),$7D89(A7)          ; $273E06
        MOVE.W  (A7),-$5E(A6,D7.L)              ; $273E0C
        MOVEQ   #-$55,D6                        ; $273E10
        MOVEQ   #-$4D,D6                        ; $273E12
        MOVEQ   #-$47,D6                        ; $273E14
        MOVE.W  #$7BC1,-$38(A5,D7.L)            ; $273E16
        MOVEQ   #-$33,D6                        ; $273E1C
        MOVEQ   #-$32,D6                        ; $273E1E
        DC.W    $7DCA               ; $273E20 MOVE.W  A2,<EA:3E>
        MOVEQ   #-$3E,D7                        ; $273E22
        MOVEQ   #-$48,D7                        ; $273E24
        MOVE.W  -$7F5F(A6),-$74(A7,A0.W)        ; $273E26
        OR.W   D0,$59(A2,A0.W)                  ; $273E2C
        DC.W    $823E               ; $273E30 OR.B   <EA:3E>,D1
        OR.B   D1,-(A7)                         ; $273E32
        OR.B   (A7),D2                          ; $273E34
        OR.B   (A3),D2                          ; $273E36
        OR.B   (A1),D2                          ; $273E38
        OR.B   (A1),D2                          ; $273E3A
        OR.B   D1,(A2)                          ; $273E3C
        OR.B   D0,(A4)                          ; $273E3E
        OR.B   D0,(A6)                          ; $273E40
        OR.B   (A7),D1                          ; $273E42
        OR.B   D0,(A0)+                         ; $273E44
        OR.B   D0,(A2)+                         ; $273E46
        OR.B   (A3)+,D0                         ; $273E48
        OR.B   (A5)+,D0                         ; $273E4A
        MOVE.W  -(A5),-(A7)                     ; $273E4C
        MOVE.W  $40(A2,D7.L),-(A7)              ; $273E4E
        MOVEQ   #$4E,D7                         ; $273E52
        MOVE.W  (A2)+,$7D65(A6)                 ; $273E54
        MOVEQ   #$73,D6                         ; $273E58
        MOVEQ   #$7F,D6                         ; $273E5A
        MOVE.W  A4,-$66(A5,D7.L)                ; $273E5C
        MOVE.W  -(A7),-$50(A5,D7.L)             ; $273E60
        MOVEQ   #-$46,D6                        ; $273E64
        DC.W    $7BC5               ; $273E66 MOVE.W  D5,<EA:3D>
        DC.W    $7BCF               ; $273E68 MOVE.W  A7,<EA:3D>
        DC.W    $7BD7               ; $273E6A MOVE.W  (A7),<EA:3D>
        DC.W    $7BDA               ; $273E6C MOVE.W  (A2)+,<EA:3D>
        MOVEQ   #-$25,D6                        ; $273E6E
        MOVEQ   #-$26,D6                        ; $273E70
        DC.W    $7DD6               ; $273E72 MOVE.W  (A6),<EA:3E>
        MOVEQ   #-$34,D7                        ; $273E74
        DC.W    $7FC2               ; $273E76 MOVE.W  D2,<EA:3F>
        MOVE.W  $7FB0(PC),-$5D(A7,A0.W)         ; $273E78
        OR.L   D0,(A2)                          ; $273E7E
        OR.L   D1,D1                            ; $273E80
        OR.W   $6A(A2,A0.W),D1                  ; $273E82
        OR.W   -$7D8B(A5),D1                    ; $273E86
        OR.W   D1,$7D(PC,A0.W)                  ; $273E8A
        DC.W    $827F               ; $273E8E OR.W   <EA:3F>,D1
        OR.L   D0,D1                            ; $273E90
        OR.L   D4,D0                            ; $273E92
        MOVE.W  D7,-$7A(A7,D7.L)                ; $273E94
        DC.W    $7F7F,$7E79         ; $273E98 MOVE.W  <EA:3F>,$7E79(A7)
        MOVEQ   #$7C,D7                         ; $273E9C
        MOVE.W  D6,-$6C(A6,D7.L)                ; $273E9E
        MOVEQ   #-$5D,D6                        ; $273EA2
        MOVEQ   #-$52,D6                        ; $273EA4
        MOVEQ   #-$4C,D6                        ; $273EA6
        MOVEQ   #-$48,D6                        ; $273EA8
        MOVE.W  #$7DBE,-$47(A6,D7.L)            ; $273EAA
        MOVEQ   #-$53,D7                        ; $273EB0
        MOVE.W  (A4)+,-$75(A7,A0.W)             ; $273EB2
        OR.L   D0,D0                            ; $273EB6
        OR.W   $69(A7,A0.W),D0                  ; $273EB8
        OR.W   D0,(A3)                          ; $273EBC
        DC.W    $813D               ; $273EBE OR.B   D0,<EA:3D>
        OR.B   D0,-$7EE2(A4)                    ; $273EC0
        OR.B   D0,(A6)                          ; $273EC4
        OR.B   (A4),D1                          ; $273EC6
        OR.B   (A3),D1                          ; $273EC8
        OR.B   D1,(A4)                          ; $273ECA
        OR.B   D1,(A6)                          ; $273ECC
        OR.B   D1,(A7)                          ; $273ECE
        OR.B   (A1)+,D1                         ; $273ED0
        OR.B   (A2)+,D1                         ; $273ED2
        OR.B   D1,(A3)+                         ; $273ED4
        OR.B   D1,(A5)+                         ; $273ED6
        OR.B   (A6)+,D1                         ; $273ED8
        OR.B   -(A0),D0                         ; $273EDA
        MOVEQ   #$2B,D7                         ; $273EDC
        MOVE.W  D3,$7C5C(A6)                    ; $273EDE
        MOVE.W  -$76(A3,D7.L),$7B9D(A5)         ; $273EE2
        MOVE.W  $7BB2(A3),-$48(A5,D7.L)         ; $273EE8
        MOVEQ   #-$3D,D5                        ; $273EEE
        MOVE.W  (A0),#$78D8                     ; $273EF0
        MOVE.W  (A2)+,#$7ADB                    ; $273EF4
        DC.W    $7BDB               ; $273EF8 MOVE.W  (A3)+,<EA:3D>
        MOVEQ   #-$26,D6                        ; $273EFA
        DC.W    $7DD9               ; $273EFC MOVE.W  (A1)+,<EA:3E>
        MOVEQ   #-$29,D7                        ; $273EFE
        DC.W    $7FD4               ; $273F00 MOVE.W  (A4),<EA:3F>
        DC.W    $7FCB               ; $273F02 MOVE.W  A3,<EA:3F>
        DC.W    $80BE               ; $273F04 OR.L   <EA:3E>,D0
        OR.L   D0,-$7D64(A7)                    ; $273F06
        OR.L   D1,A0                            ; $273F0A
        OR.W   D1,$69(A5,A0.W)                  ; $273F0C
        OR.W   -(A4),D1                         ; $273F10
        OR.W   -(A2),D1                         ; $273F12
        OR.W   D0,(A7)+                         ; $273F14
        OR.W   -(A0),D1                         ; $273F16
        OR.W   -(A1),D1                         ; $273F18
        OR.W   -(A1),D1                         ; $273F1A
        OR.W   (A6)+,D1                         ; $273F1C
        OR.W   (A3)+,D1                         ; $273F1E
        OR.W   (A2)+,D1                         ; $273F20
        OR.W   D0,(A6)+                         ; $273F22
        MOVE.W  -(A5),$7E69(A7)                 ; $273F24
        MOVEQ   #$6F,D7                         ; $273F28
        MOVE.W  #$7C8C,$7C95(A6)                ; $273F2A
        MOVEQ   #-$65,D6                        ; $273F30
        MOVEQ   #-$5C,D6                        ; $273F32
        MOVEQ   #-$50,D6                        ; $273F34
        MOVEQ   #-$4A,D6                        ; $273F36
        MOVE.W  -$48(A6,D7.L),-$40(A6,D7.L)     ; $273F38
        MOVEQ   #-$3D,D7                        ; $273F3E
        MOVE.W  -$7F57(PC),-$66(A7,A0.W)        ; $273F40
        OR.L   A3,D0                            ; $273F46
        OR.W   -$7E9E(PC),D0                    ; $273F48
        OR.W   D0,A3                            ; $273F4C
        OR.B   D0,-$7ED3(PC)                    ; $273F4E
        OR.B   D0,(A6)+                         ; $273F52
        OR.B   (A7),D1                          ; $273F54
        OR.B   D1,(A6)                          ; $273F56
        OR.B   (A5),D1                          ; $273F58
        OR.B   D0,(A6)                          ; $273F5A
        OR.B   (A7),D1                          ; $273F5C
        OR.B   (A1)+,D1                         ; $273F5E
        OR.B   (A2)+,D1                         ; $273F60
        OR.B   D0,(A4)+                         ; $273F62
        OR.B   D0,(A5)+                         ; $273F64
        OR.B   (A7)+,D0                         ; $273F66
        MOVE.W  $7E36(A0),-(A7)                 ; $273F68
        MOVE.W  D3,$7D4F(A6)                    ; $273F6C
        MOVE.W  (A4)+,$7C68(A6)                 ; $273F70
        MOVE.W  -$80(A3,D7.L),$798D(A5)         ; $273F74
        MOVE.W  (A4)+,-$54(A4,D7.L)             ; $273F7A
        DC.W    $79BF,$7ACC         ; $273F7E MOVE.W  <EA:3F>,-$34(A4,D7.L)
        MOVEQ   #-$2E,D6                        ; $273F82
        DC.W    $7DD2               ; $273F84 MOVE.W  (A2),<EA:3E>
        DC.W    $7DCF               ; $273F86 MOVE.W  A7,<EA:3E>
        DC.W    $7DCA               ; $273F88 MOVE.W  A2,<EA:3E>
        DC.W    $7DC5               ; $273F8A MOVE.W  D5,<EA:3E>
        MOVEQ   #-$3D,D7                        ; $273F8C
        MOVE.W  -$54(PC,A0.W),-$67(A7,A0.W)     ; $273F8E
        OR.L   A0,D1                            ; $273F94
        DC.W    $827F               ; $273F96 OR.W   <EA:3F>,D1
        DC.W    $817F               ; $273F98 OR.W   D0,<EA:3F>
        OR.L   D0,D7                            ; $273F9A
        OR.L   D0,A5                            ; $273F9C
        OR.L   D0,(A1)                          ; $273F9E
        OR.L   D0,(A3)                          ; $273FA0
        OR.L   D0,(A3)                          ; $273FA2
        OR.L   D0,A7                            ; $273FA4
        OR.L   D0,A1                            ; $273FA6
        DC.W    $817F               ; $273FA8 OR.W   D0,<EA:3F>
        OR.W   D0,$6C(A4,A0.W)                  ; $273FAA
        OR.W   D0,-(A7)                         ; $273FAE
        OR.W   D0,-$7F92(A1)                    ; $273FB0
        MOVE.W  $7C(A4,D7.L),$7D87(A7)          ; $273FB4
        MOVEQ   #-$6D,D6                        ; $273FBA
        MOVE.W  -(A3),-$50(A5,D7.L)             ; $273FBC
        MOVEQ   #-$46,D6                        ; $273FC0
        DC.W    $7DC2               ; $273FC2 MOVE.W  D2,<EA:3E>
        MOVEQ   #-$33,D7                        ; $273FC4
        MOVEQ   #-$2F,D7                        ; $273FC6
        MOVEQ   #-$2F,D7                        ; $273FC8
        DC.W    $7FCB               ; $273FCA MOVE.W  A3,<EA:3F>
        DC.W    $7FC0               ; $273FCC MOVE.W  D0,<EA:3F>
        MOVEQ   #-$4C,D7                        ; $273FCE
        MOVEQ   #-$5B,D7                        ; $273FD0
        MOVEQ   #-$6B,D7                        ; $273FD2
        MOVE.W  D7,$76(A7,D7.L)                 ; $273FD4
        MOVE.W  -(A6),-$7FAA(A7)                ; $273FD8
        OR.W   D1,D0                            ; $273FDC
        OR.B   D0,-$7EE4(A3)                    ; $273FDE
        OR.B   D0,(A7)                          ; $273FE2
        OR.B   (A5),D1                          ; $273FE4
        OR.B   (A4),D1                          ; $273FE6
        OR.B   (A5),D1                          ; $273FE8
        OR.B   (A7),D1                          ; $273FEA
        OR.B   (A1)+,D1                         ; $273FEC
        OR.B   (A2)+,D1                         ; $273FEE
        OR.B   D0,(A3)+                         ; $273FF0
        OR.B   D0,(A5)+                         ; $273FF2
        OR.B   D0,(A7)+                         ; $273FF4
        MOVE.W  -(A5),-(A7)                     ; $273FF6
        MOVEQ   #$37,D7                         ; $273FF8
        MOVE.W  A2,$7C59(A6)                    ; $273FFA
        MOVEQ   #$68,D6                         ; $273FFE
        MOVEQ   #$77,D6                         ; $274000
        MOVE.W  D2,-$76(A5,D7.L)                ; $274002
        MOVEQ   #-$72,D5                        ; $274006
        MOVEQ   #-$74,D5                        ; $274008
        MOVE.W  A0,-$74(A5,D7.L)                ; $27400A
        MOVEQ   #-$64,D5                        ; $27400E
        MOVEQ   #-$4B,D5                        ; $274010
        DC.W    $7BCC               ; $274012 MOVE.W  A4,<EA:3D>
        DC.W    $7DD6               ; $274014 MOVE.W  (A6),<EA:3E>
        DC.W    $7FDA               ; $274016 MOVE.W  (A2)+,<EA:3F>
        DIVU    (A5),D0                         ; $274018
        DIVU    D3,D0                           ; $27401A
        OR.L   -$7F64(A4),D0                    ; $27401C
        OR.L   (A2),D0                          ; $274020
        OR.L   D7,D0                            ; $274022
        OR.L   D0,D1                            ; $274024
        OR.L   D0,D1                            ; $274026
        OR.L   D0,D5                            ; $274028
        OR.L   D0,A5                            ; $27402A
        OR.L   D0,(A5)                          ; $27402C
        OR.L   (A2)+,D0                         ; $27402E
        OR.L   (A0)+,D0                         ; $274030
        OR.L   (A5),D0                          ; $274032
        OR.L   (A1),D0                          ; $274034
        OR.L   A0,D0                            ; $274036
        OR.W   D0,$816A.W                       ; $274038
        OR.W   -(A6),D0                         ; $27403C
        MOVE.W  -(A7),$7E6E(A7)                 ; $27403E
        DC.W    $7D79,$7C85,$7C8C,$7C93; $274042 MOVE.W  $7C857C8C,$7C93(A6)
        MOVEQ   #-$61,D6                        ; $27404A
        MOVEQ   #-$51,D6                        ; $27404C
        MOVEQ   #-$42,D6                        ; $27404E
        DC.W    $7DC8               ; $274050 MOVE.W  A0,<EA:3E>
        MOVEQ   #-$32,D7                        ; $274052
        DC.W    $7FD2               ; $274054 MOVE.W  (A2),<EA:3F>
        DC.W    $7FD3               ; $274056 MOVE.W  (A3),<EA:3F>
        DC.W    $7FD2               ; $274058 MOVE.W  (A2),<EA:3F>
        DC.W    $7FCC               ; $27405A MOVE.W  A4,<EA:3F>
        DC.W    $7FC0               ; $27405C MOVE.W  D0,<EA:3F>
        MOVE.W  $7E9D(A7),-$76(A7,D7.L)         ; $27405E
        MOVEQ   #$78,D7                         ; $274064
        MOVEQ   #$65,D7                         ; $274066
        MOVE.W  (A1),-$7FC1(A7)                 ; $274068
        OR.B   D0,-$7DE3(A4)                    ; $27406C
        OR.B   D1,(A7)                          ; $274070
        OR.B   (A5),D2                          ; $274072
        OR.B   (A4),D2                          ; $274074
        OR.B   D1,(A5)                          ; $274076
        OR.B   D1,(A7)                          ; $274078
        OR.B   D1,(A0)+                         ; $27407A
        OR.B   D1,(A2)+                         ; $27407C
        OR.B   D1,(A3)+                         ; $27407E
        OR.B   (A4)+,D1                         ; $274080
        OR.B   D0,(A6)+                         ; $274082
        OR.B   (A7)+,D0                         ; $274084
        MOVE.W  -(A2),-(A7)                     ; $274086
        MOVEQ   #$29,D7                         ; $274088
        MOVE.W  $3A(A1,D7.L),-(A6)              ; $27408A
        MOVEQ   #$4B,D6                         ; $27408E
        MOVE.W  -(A0),$7B73(A5)                 ; $274090
        MOVE.W  D4,-$6E(A5,D7.L)                ; $274094
        MOVEQ   #-$5F,D5                        ; $274098
        MOVE.W  -$3F(A0,D7.L),-$33(A5,D7.L)     ; $27409A
        MOVEQ   #-$2B,D6                        ; $2740A0
        DC.W    $7DDC               ; $2740A2 MOVE.W  (A4)+,<EA:3E>
        DC.W    $7DDE               ; $2740A4 MOVE.W  (A6)+,<EA:3E>
        MOVEQ   #-$21,D7                        ; $2740A6
        MOVEQ   #-$22,D7                        ; $2740A8
        MOVEQ   #-$24,D7                        ; $2740AA
        DC.W    $7FD6               ; $2740AC MOVE.W  (A6),<EA:3F>
        DC.W    $7FCC               ; $2740AE MOVE.W  A4,<EA:3F>
        DIVU    D3,D0                           ; $2740B0
        OR.L   D0,-$50(PC,A0.W)                 ; $2740B2
        OR.L   -(A5),D0                         ; $2740B6
        OR.L   (A4)+,D0                         ; $2740B8
        OR.L   (A4),D0                          ; $2740BA
        OR.L   D0,A2                            ; $2740BC
        OR.L   D0,D2                            ; $2740BE
        DC.W    $817F               ; $2740C0 OR.W   D0,<EA:3F>
        DC.W    $817D               ; $2740C2 OR.W   D0,<EA:3D>
        OR.W   D0,$826F.W                       ; $2740C4
        OR.W   -(A5),D1                         ; $2740C8
        OR.W   D0,-(A2)                         ; $2740CA
        OR.W   -(A2),D0                         ; $2740CC
        MOVE.W  -(A4),$7F69(A7)                 ; $2740CE
        MOVEQ   #$6F,D7                         ; $2740D2
        MOVEQ   #$73,D7                         ; $2740D4
        MOVEQ   #$7D,D7                         ; $2740D6
        MOVEQ   #-$71,D7                        ; $2740D8
        MOVE.W  -(A4),-$49(A6,D7.L)             ; $2740DA
        MOVEQ   #-$3D,D7                        ; $2740DE
        MOVEQ   #-$3E,D7                        ; $2740E0
        DC.W    $7FC1               ; $2740E2 MOVE.W  D1,<EA:3F>
        MOVEQ   #-$38,D7                        ; $2740E4
        DC.W    $7DCE               ; $2740E6 MOVE.W  A6,<EA:3E>
        MOVEQ   #-$31,D6                        ; $2740E8
        MOVEQ   #-$37,D7                        ; $2740EA
        MOVEQ   #-$47,D7                        ; $2740EC
        MOVEQ   #-$5C,D7                        ; $2740EE
        MOVEQ   #-$71,D7                        ; $2740F0
        MOVEQ   #$7B,D7                         ; $2740F2
        MOVEQ   #$66,D7                         ; $2740F4
        MOVE.W  (A2),-$7FC2(A7)                 ; $2740F6
        OR.B   D0,-$7DE5(A2)                    ; $2740FA
        OR.B   D1,(A6)                          ; $2740FE
        OR.B   (A4),D2                          ; $274100
        OR.B   (A4),D2                          ; $274102
        OR.B   (A5),D2                          ; $274104
        OR.B   D2,(A6)                          ; $274106
        OR.B   D2,(A0)+                         ; $274108
        OR.B   D2,(A1)+                         ; $27410A
        OR.B   (A3)+,D2                         ; $27410C
        OR.B   (A4)+,D1                         ; $27410E
        OR.B   (A5)+,D0                         ; $274110
        MOVE.W  -(A0),-(A7)                     ; $274112
        MOVE.W  $7C4C(A7),-(A6)                 ; $274114
        MOVE.W  -(A7),$7A7A(A5)                 ; $274118
        MOVEQ   #-$76,D5                        ; $27411C
        MOVEQ   #-$69,D5                        ; $27411E
        MOVEQ   #-$5E,D5                        ; $274120
        MOVE.W  $79AE(A1),-$4B(A4,D7.L)         ; $274122
        MOVEQ   #-$41,D5                        ; $274128
        MOVEQ   #-$37,D5                        ; $27412A
        DC.W    $7BD1               ; $27412C MOVE.W  (A1),<EA:3D>
        MOVEQ   #-$29,D6                        ; $27412E
        MOVEQ   #-$27,D6                        ; $274130
        DC.W    $7DD9               ; $274132 MOVE.W  (A1)+,<EA:3E>
        MOVEQ   #-$27,D7                        ; $274134
        MOVEQ   #-$28,D7                        ; $274136
        DC.W    $7FD6               ; $274138 MOVE.W  (A6),<EA:3F>
        DIVU    (A0),D0                         ; $27413A
        DIVU    A0,D0                           ; $27413C
        DC.W    $80BE               ; $27413E OR.L   <EA:3E>,D0
        OR.L   D0,-$7D5F(A7)                    ; $274140
        OR.L   (A7),D1                          ; $274144
        OR.L   A5,D1                            ; $274146
        DC.W    $837E               ; $274148 OR.W   D1,<EA:3E>
        OR.W   D1,$67(A0,A0.W)                  ; $27414A
        OR.W   D1,-(A3)                         ; $27414E
        OR.W   D1,(A6)+                         ; $274150
        OR.W   D1,(A5)                          ; $274152
        OR.W   D1,(A0)                          ; $274154
        OR.W   A6,D1                            ; $274156
        OR.W   D0,A1                            ; $274158
        OR.W   D0,D7                            ; $27415A
        OR.W   D0,A1                            ; $27415C
        OR.W   (A2),D0                          ; $27415E
        MOVE.W  -(A0),$7E6F(A7)                 ; $274160
        MOVEQ   #$7C,D7                         ; $274164
        MOVEQ   #-$72,D7                        ; $274166
        MOVEQ   #-$5F,D7                        ; $274168
        MOVEQ   #-$4E,D7                        ; $27416A
        MOVEQ   #-$42,D7                        ; $27416C
        MOVEQ   #-$3B,D7                        ; $27416E
        DC.W    $7DCC               ; $274170 MOVE.W  A4,<EA:3E>
        MOVEQ   #-$31,D6                        ; $274172
        MOVEQ   #-$32,D6                        ; $274174
        DC.W    $7DC7               ; $274176 MOVE.W  D7,<EA:3E>
        MOVE.W  #$7DB2,-$58(A6,D7.L)            ; $274178
        MOVE.W  (A3)+,-$76(A6,D7.L)             ; $27417E
        OR.W   $5C(A4,A0.W),D0                  ; $274182
        OR.W   D3,D1                            ; $274186
        OR.B   D1,-$7BE4(A6)                    ; $274188
        OR.B   D2,(A5)                          ; $27418C
        OR.B   D2,(A3)                          ; $27418E
        OR.B   D2,(A2)                          ; $274190
        OR.B   D2,(A3)                          ; $274192
        OR.B   (A5),D2                          ; $274194
        OR.B   (A6),D2                          ; $274196
        OR.B   D1,(A0)+                         ; $274198
        OR.B   D0,(A1)+                         ; $27419A
        OR.B   (A3)+,D0                         ; $27419C
        MOVE.W  (A4)+,-(A7)                     ; $27419E
        MOVE.W  -(A0),-(A6)                     ; $2741A0
        MOVEQ   #$32,D6                         ; $2741A2
        MOVE.W  A0,$7B5D(A5)                    ; $2741A4
        MOVEQ   #$72,D5                         ; $2741A8
        MOVE.W  D6,-$6B(A4,D7.L)                ; $2741AA
        MOVEQ   #-$63,D4                        ; $2741AE
        MOVEQ   #-$5E,D4                        ; $2741B0
        MOVE.W  -(A6),-$57(A4,D7.L)             ; $2741B2
        MOVE.W  $7CAC(A3),-$51(A5,D7.L)         ; $2741B6
        MOVE.W  -$48(A2,D7.L),-$41(A6,D7.L)     ; $2741BC
        DC.W    $7FC4               ; $2741C2 MOVE.W  D4,<EA:3F>
        DIVU    D5,D0                           ; $2741C4
        DIVU    D3,D0                           ; $2741C6
        DC.W    $80BF               ; $2741C8 OR.L   <EA:3F>,D0
        OR.L   $81B082A5,D0                     ; $2741CA
        OR.L   (A5)+,D1                         ; $2741D0
        OR.L   D1,(A2)+                         ; $2741D2
        OR.L   (A1)+,D1                         ; $2741D4
        OR.L   (A6),D1                          ; $2741D6
        OR.L   D1,A7                            ; $2741D8
        OR.L   D3,D1                            ; $2741DA
        OR.W   $6B(A6,A0.W),D1                  ; $2741DC
        OR.W   -(A1),D1                         ; $2741E0
        OR.W   (A2)+,D1                         ; $2741E2
        OR.W   D0,(A7)                          ; $2741E4
        OR.W   D0,(A6)                          ; $2741E6
        OR.W   D0,(A7)                          ; $2741E8
        OR.W   (A3)+,D0                         ; $2741EA
        OR.W   -(A4),D0                         ; $2741EC
        MOVE.W  -$7D(A2,D7.L),$7E93(A7)         ; $2741EE
        MOVE.W  -(A2),-$52(A6,D7.L)             ; $2741F4
        MOVEQ   #-$46,D6                        ; $2741F8
        MOVEQ   #-$3E,D6                        ; $2741FA
        DC.W    $7DCB               ; $2741FC MOVE.W  A3,<EA:3E>
        DC.W    $7DD0               ; $2741FE MOVE.W  (A0),<EA:3E>
