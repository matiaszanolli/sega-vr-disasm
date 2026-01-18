; Generated assembly for $022200-$024200
; Branch targets: 356
; Labels: 349
; Format: DC.W with decoded mnemonics as comments

        org     $022200

        MOVEQ   #$10,D2                         ; $022200
        DC.W    $000B,$74D0         ; $022202 ORI.B  #$74D0,A3
        BTST    #29,$6503(A2)                   ; $022206
        DC.W    $482A               ; $02220C DC.W    $482A
        MOVE.B  -(A0),$1751(A3)                 ; $02220E
        MOVE.B  D2,-(A3)                        ; $022212
        MOVE.B  -(A3),-$1CFD(A3)                ; $022214
        BCS.S  loc_02225D                       ; $022218
        DC.W    $0028,$6673,$056F   ; $02221A ORI.B  #$6673,$056F(A0)
        MOVE.W  D4,-(A2)                        ; $022220
        BCHG    D2,$75F4(A7)                    ; $022222
        DC.W    $000A,$011A         ; $022226 ORI.B  #$011A,A2
        MOVE.L  A5,-(A0)                        ; $02222A
        DC.W    $0028,$056F,$7504   ; $02222C ORI.B  #$056F,$7504(A0)
        BCHG    D2,$000A(A7)                    ; $022232
        DC.W    $021A,$220D         ; $022236 ANDI.B  #$220D,(A2)+
        MOVE.B  (A0),D2                         ; $02223A
        MOVE.B  -(A2),D2                        ; $02223C
        DC.W    $4310               ; $02223E DC.W    $4310
        DIVS    $7410(A2),D7                    ; $022240
        DC.W    $000B,$74D0         ; $022244 ORI.B  #$74D0,A3
        BTST    #28,$6503(A2)                   ; $022248
        DC.W    $482A               ; $02224E DC.W    $482A
        MOVE.B  -(A0),$1701(A3)                 ; $022250
        MOVE.B  (A2),$1763(A3)                  ; $022254
        ASL.B  #1,D3                            ; $022258
        BCS.S  loc_02229F                       ; $02225A
        DC.W    $0028,$6673,$056F   ; $02225C ORI.B  #$6673,$056F(A0)
        BCHG    D2,$75F8(A7)                    ; $022262
        DC.W    $000A,$011A         ; $022266 ORI.B  #$011A,A2
        MOVE.L  A5,-(A0)                        ; $02226A
        DC.W    $0028,$056F,$056F   ; $02226C ORI.B  #$056F,$056F(A0)
        DC.W    $000A,$021A         ; $022272 ORI.B  #$021A,A2
        MOVE.L  A5,D1                           ; $022276
        MOVE.B  (A0),D2                         ; $022278
        MOVE.B  -(A1),D2                        ; $02227A
        DC.W    $4310               ; $02227C DC.W    $4310
        DIVS    $7410(A4),D7                    ; $02227E
        DC.W    $000B,$74D0         ; $022282 ORI.B  #$74D0,A3
        ADD.B  D6,D3                            ; $022286
        ADD.B  D0,D6                            ; $022288
        ADD.B  D7,D0                            ; $02228A
        ADD.B  D3,D7                            ; $02228C
        MOVEA.W (A4)+,A3                        ; $02228E
        MOVE.L  (A1)+,-(A2)                     ; $022290
        MOVE.L  (A1)+,D3                        ; $022292
        BCHG    D2,(A5)+                        ; $022294
        ADDI.W  #$4508,$4608(A5)                ; $022296
        DC.W    $000B,$605B         ; $02229C ORI.B  #$605B,A3
        DC.W    $0000,$0800         ; $0222A0 ORI.B  #$0800,D0
        DC.W    $0000,$1FFE         ; $0222A4 ORI.B  #$1FFE,D0
        MOVE.L  D2,D1                           ; $0222A8
        SUBQ.L  #5,D4                           ; $0222AA
        AND.B  D0,D0                            ; $0222AC
        DC.W    $0000,$D101         ; $0222AE ORI.B  #$D101,D0
        AND.B  D3,-$5FFC(A1)                    ; $0222B2
        DC.W    $0009,$0600         ; $0222B6 ORI.B  #$0600,A1
        DC.W    $456C               ; $0222BA DC.W    $456C
        ADD.B  D0,(A0)                          ; $0222BC
        AND.B  D3,(A6)+                         ; $0222BE
        ADD.B  (A0),D1                          ; $0222C0
        MOVE.L  (A2),D1                         ; $0222C2
        ADD.B  (A0),D7                          ; $0222C4
        LSL.B  #3,D0                            ; $0222C6
        ADD.B  D6,(A0)                          ; $0222C8
        BSR.S  loc_0222D2                       ; $0222CA
        MOVE.L  (A2),-(A6)                      ; $0222CC
        DC.W    $4710               ; $0222CE DC.W    $4710
        DIVS    $04(PC,D7.L),D7                 ; $0222D0
        AND.B  D3,(A1)                          ; $0222D4
        ASL.B  #3,D7                            ; $0222D6
        ADD.B  D6,A5                            ; $0222D8
        BSR.S  loc_0222E2                       ; $0222DA
        MOVE.L  (A2),-(A6)                      ; $0222DC
        DC.W    $4710               ; $0222DE DC.W    $4710
        DIVS    $04(PC,D7.L),D7                 ; $0222E0
        DC.W    $4F22               ; $0222E4 DC.W    $4F22
        CMP.W  (A7),D0                          ; $0222E6
        DC.W    $0009,$4F26         ; $0222E8 ORI.B  #$4F26,A1
        ADD.B  D6,A1                            ; $0222EC
        ADD.B  A2,D0                            ; $0222EE
        BSR.S  loc_0222F8                       ; $0222F0
        BHI.S  loc_0222FA                       ; $0222F2
        BLS.S  loc_0222FC                       ; $0222F4
        MOVE.B  (A0),-(A6)                      ; $0222F6
loc_0222F8:
        MOVE.B  -(A1),-(A6)                     ; $0222F8
loc_0222FA:
        DC.W    $000B,$1D32         ; $0222FA ORI.B  #$1D32,A3
        DC.W    $0000,$0600         ; $0222FE ORI.B  #$0600,D0
        DC.W    $4570               ; $022302 DC.W    $4570
        AND.B  D0,D0                            ; $022304
        BCLR    D3,(A0)+                        ; $022306
        AND.B  D0,D0                            ; $022308
        BTST    D3,D0                           ; $02230A
        AND.B  D0,D0                            ; $02230C
        BTST    D3,-(A0)                        ; $02230E
        AND.B  D0,D0                            ; $022310
        BTST    D3,D4                           ; $022312
        AND.B  D0,D0                            ; $022314
        DC.W    $0788               ; $022316 BCLR    D3,A0
        ADDI.B  #$2378,D0                       ; $022318
        DC.W    $0000,$0000         ; $02231C ORI.B  #$0000,D0
        DC.W    $0000,$0070         ; $022320 ORI.B  #$0070,D0
        DC.W    $0000,$7000         ; $022324 ORI.B  #$7000,D0
        DC.W    $00FF               ; $022328 DC.W    $00FF
        DC.W    $0000,$0080         ; $02232A ORI.B  #$0080,D0
        DC.W    $0000,$0000         ; $02232E ORI.B  #$0000,D0
        DC.W    $0000,$0600         ; $022332 ORI.B  #$0600,D0
        MOVE.L  #$0600F400,(A3)+                ; $022336
        ADDI.B  #$0000,D1                       ; $02233C
        ADDI.B  #$2FEC,D1                       ; $022340
        ADDI.B  #$8000,D1                       ; $022344
        ADDI.B  #$0000,D2                       ; $022348
        ADDI.B  #$3000,D2                       ; $02234C
        ADDI.B  #$DB00,D0                       ; $022350
        ADDI.B  #$DE00,D0                       ; $022354
        ADDI.B  #$F600,D0                       ; $022358
        ADDI.B  #$3000,D1                       ; $02235C
        ADDI.B  #$5FEC,D1                       ; $022360
        ADDI.B  #$C000,D1                       ; $022364
        ADDI.B  #$0010,D2                       ; $022368
        ADDI.B  #$3010,D2                       ; $02236C
        ADDI.B  #$DB01,D0                       ; $022370
        ADDI.B  #$DE01,D0                       ; $022374
        DC.W    $0000,$0000         ; $022378 ORI.B  #$0000,D0
        DC.W    $FFFC,$0000         ; $02237C MOVE.W  #$0000,<EA:3F>
        DC.W    $0000,$0000         ; $022380 ORI.B  #$0000,D0
        ADD.B  D0,D2                            ; $022384
        BRA.S  loc_022399                       ; $022386
        BRA.S  loc_022399                       ; $022388
        DC.W    $000B,$1E02         ; $02238A ORI.B  #$1E02,A3
        DC.W    $0000,$0600         ; $02238E ORI.B  #$0600,D0
        MULU    A6,D0                           ; $022392
        ADD.B  D6,D7                            ; $022394
        MOVE.B  D3,D7                           ; $022396
        SUB.B  D3,A0                            ; $022398
        ST      -(A3)                           ; $02239A
        MOVE.B  D0,-(A3)                        ; $02239C
        ST      -(A2)                           ; $02239E
        MOVE.B  D4,-(A3)                        ; $0223A0
        ASR.B  #8,D0                            ; $0223A2
        MOVE.B  D5,-(A3)                        ; $0223A4
        ADDQ.W  #8,$0B(A7,D0.W)                 ; $0223A6
        MOVE.B  D6,D7                           ; $0223AA
        MOVE.W  D0,-(A7)                        ; $0223AC
        DC.W    $0000,$C000         ; $0223AE ORI.B  #$C000,D0
        BTST    D3,D0                           ; $0223B2
        DC.W    $4F22               ; $0223B4 DC.W    $4F22
        DIVS    -(A0),D2                        ; $0223B6
        OR.B   D0,D4                            ; $0223B8
        OR.B   D4,(A2)+                         ; $0223BA
        DC.W    $2FE6               ; $0223BC MOVE.L  -(A6),<EA:3F>
        DC.W    $2FD6               ; $0223BE MOVE.L  (A6),<EA:3F>
        MOVE.L  -$59(A6,A3.W),$0009(A7)         ; $0223C0
        SF      -(A4)                           ; $0223C6
        ADD.B  A5,D7                            ; $0223C8
        ASL.B  #3,D4                            ; $0223CA
        BRA.S  loc_0223E3                       ; $0223CC
        NEGX.B $6215(A0)                        ; $0223CE
        BHI.S  loc_022401                       ; $0223D2
        MOVE.L  -$7800(A3),D0                   ; $0223D4
        OR.B   D4,D6                            ; $0223D8
        MOVE.L  (A6),-(A7)                      ; $0223DA
loc_0223DC:
        MOVE.L  $09(A6,A5.W),$410B(A7)          ; $0223DC
        BLT.S  loc_0223E7                       ; $0223E2
        BEQ.S  loc_0223DC                       ; $0223E4
loc_0223E6:
        BSR.S  loc_0223DE                       ; $0223E6
loc_0223E8:
        DC.W    $4710               ; $0223E8 DC.W    $4710
        DIVS    $67F6(A7),D5                    ; $0223EA
        BLT.S  loc_0223E6                       ; $0223EE
        BGT.S  loc_0223E8                       ; $0223F0
        MOVE.W  $10(A0,D4.W),-(A6)              ; $0223F2
loc_0223F6:
        DIVS    (A6)+,D7                        ; $0223F6
        MOVEQ   #$14,D7                         ; $0223F8
        DC.W    $4F26               ; $0223FA DC.W    $4F26
        DC.W    $000B,$0009         ; $0223FC ORI.B  #$0009,A3
        AND.B  D0,D0                            ; $022400
        BTST    D3,D0                           ; $022402
        AND.B  D0,D0                            ; $022404
        DC.W    $0000,$4F22         ; $022406 ORI.B  #$4F22,D0
        CMP.L  D3,D0                            ; $02240A
        DC.W    $0009,$DD0B         ; $02240C ORI.B  #$DD0B,A1
        ST      -(A4)                           ; $022410
        MOVE.W  A4,-(A6)                        ; $022412
        DIVS    -(A7),D2                        ; $022414
        BEQ.S  loc_02241B                       ; $022416
        ADD.B  A1,D7                            ; $022418
        ADD.B  A2,D0                            ; $02241A
        MOVE.B  D7,D7                           ; $02241C
        BRA.S  loc_0223F6                       ; $02241E
        DC.W    $2FD6               ; $022420 MOVE.L  (A6),<EA:3F>
        MOVE.L  $06(A6,A5.L),-$2EF8(A7)         ; $022422
        DC.W    $410B               ; $022428 DC.W    $410B
        BLT.S  loc_02242F                       ; $02242A
        BEQ.S  loc_022424                       ; $02242C
        DC.W    $4710               ; $02242E DC.W    $4710
        DIVS    -$0A(A5,D6.L),D7                ; $022430
        DC.W    $4F26               ; $022434 DC.W    $4F26
        DC.W    $000B,$0009         ; $022436 ORI.B  #$0009,A3
        DC.W    $0000,$0600         ; $02243A ORI.B  #$0600,D0
        AND.B  D0,D0                            ; $02243E
        AND.B  D0,D0                            ; $022440
        BTST    D3,D0                           ; $022442
        AND.B  D0,D0                            ; $022444
        DC.W    $01CE               ; $022446 BSET    D0,A6
        AND.B  D0,D0                            ; $022448
        DC.W    $0000,$4F22         ; $02244A ORI.B  #$4F22,D0
        CMP.W  -(A1),D0                         ; $02244E
        DC.W    $0009,$DD0C         ; $022450 ORI.B  #$DD0C,A1
        DIVS    -(A7),D2                        ; $022454
        BEQ.S  loc_02245B                       ; $022456
        AND.B  D4,D1                            ; $022458
        DC.W    $4701               ; $02245A DC.W    $4701
        MOVE.W  A4,-(A3)                        ; $02245C
        ADD.B  A2,D7                            ; $02245E
        ADD.B  A2,D0                            ; $022460
        MOVE.B  D7,D7                           ; $022462
        BRA.S  loc_02243C                       ; $022464
        DC.W    $2FD6               ; $022466 MOVE.L  (A6),<EA:3F>
        MOVE.L  $07(A6,A5.L),-$2EF8(A7)         ; $022468
        DC.W    $410B               ; $02246E DC.W    $410B
        BLT.S  loc_022475                       ; $022470
        BEQ.S  loc_02246A                       ; $022472
        BLT.S  loc_02246C                       ; $022474
        DC.W    $4710               ; $022476 DC.W    $4710
        DIVS    $04(A4,D7.L),D7                 ; $022478
        DC.W    $4F26               ; $02247C DC.W    $4F26
        DC.W    $000B,$0009         ; $02247E ORI.B  #$0009,A3
        DC.W    $0000,$0600         ; $022482 ORI.B  #$0600,D0
        AND.B  D0,D0                            ; $022486
        AND.B  D0,D0                            ; $022488
        BTST    D3,D0                           ; $02248A
        AND.B  D0,D0                            ; $02248C
        DC.W    $01CE               ; $02248E BSET    D0,A6
        AND.B  D0,D0                            ; $022490
        DC.W    $0000,$4F22         ; $022492 ORI.B  #$4F22,D0
        DC.W    $B03D               ; $022496 CMP.B  <EA:3D>,D0
        DC.W    $0009,$DD0C         ; $022498 ORI.B  #$DD0C,A1
        DIVS    -(A7),D2                        ; $02249C
        NEGX.B D1                               ; $02249E
        OR.B   D0,D4                            ; $0224A0
        OR.B   D4,A7                            ; $0224A2
        BEQ.S  loc_0224A9                       ; $0224A4
        ADD.B  A2,D7                            ; $0224A6
        ADD.B  A2,D0                            ; $0224A8
        MOVE.B  D7,D7                           ; $0224AA
        BRA.S  loc_022484                       ; $0224AC
        DC.W    $2FD6               ; $0224AE MOVE.L  (A6),<EA:3F>
        MOVE.L  $07(A6,A5.L),-$2EF8(A7)         ; $0224B0
        DC.W    $410B               ; $0224B6 DC.W    $410B
        BLT.S  loc_0224BD                       ; $0224B8
        BEQ.S  loc_0224B2                       ; $0224BA
        BLT.S  loc_0224B4                       ; $0224BC
        DC.W    $4710               ; $0224BE DC.W    $4710
        DIVS    $04(A4,D7.L),D7                 ; $0224C0
        DC.W    $4F26               ; $0224C4 DC.W    $4F26
        DC.W    $000B,$0009         ; $0224C6 ORI.B  #$0009,A3
        DC.W    $0000,$0600         ; $0224CA ORI.B  #$0600,D0
        AND.B  D4,D0                            ; $0224CE
        AND.B  D0,D0                            ; $0224D0
        BTST    D3,D0                           ; $0224D2
        AND.B  D0,D0                            ; $0224D4
        DC.W    $01CE               ; $0224D6 BSET    D0,A6
        AND.B  D0,D0                            ; $0224D8
        DC.W    $0000,$4F22         ; $0224DA ORI.B  #$4F22,D0
        DIVS    -(A0),D2                        ; $0224DE
        OR.B   D0,D4                            ; $0224E0
        OR.B   D4,A4                            ; $0224E2
        DC.W    $2FE6               ; $0224E4 MOVE.L  -(A6),<EA:3F>
        DC.W    $2FD6               ; $0224E6 MOVE.L  (A6),<EA:3F>
        MOVE.L  $13(A6,A3.W),$0009(A7)          ; $0224E8
        SLT     -(A4)                           ; $0224EE
loc_0224F0:
        ADD.B  D6,D7                            ; $0224F0
loc_0224F2:
        ADD.B  D7,D0                            ; $0224F2
loc_0224F4:
        DC.W    $400B               ; $0224F4 NEGX.B A3
        DC.W    $0009,$67F6         ; $0224F6 ORI.B  #$67F6,A1
loc_0224FA:
        BLT.S  loc_0224F2                       ; $0224FA
        BGT.S  loc_0224F4                       ; $0224FC
        MOVE.W  $10(A0,D4.W),-(A6)              ; $0224FE
        DIVS    $7E14(A4),D7                    ; $022502
        DC.W    $4F26               ; $022506 DC.W    $4F26
        DC.W    $000B,$0009         ; $022508 ORI.B  #$0009,A3
        AND.B  D0,D0                            ; $02250C
        BTST    D3,D0                           ; $02250E
        AND.B  D0,D0                            ; $022510
        DC.W    $0000,$DC04         ; $022512 ORI.B  #$DC04,D0
        LSL.B  #3,D4                            ; $022516
        BRA.S  loc_0224F0                       ; $022518
        MOVE.L  D2,D6                           ; $02251A
        DC.W    $4710               ; $02251C DC.W    $4710
        DIVS    $04(PC,D7.L),D7                 ; $02251E
        DC.W    $000B,$0009         ; $022522 ORI.B  #$0009,A3
        DC.W    $0000,$C000         ; $022526 ORI.B  #$C000,D0
        BCHG    D3,D0                           ; $02252A
        ADD.B  D0,D5                            ; $02252C
        ADD.B  D6,D0                            ; $02252E
        SUB.B  D3,D6                            ; $022530
        BHI.S  loc_02253A                       ; $022532
        MOVE.L  -(A2),-(A0)                     ; $022534
        DC.W    $4710               ; $022536 DC.W    $4710
        DIVS    $04(PC,D7.W),D7                 ; $022538
        MOVE.L  $09(A0,D0.W),$01B5(A1)          ; $02253C
        DC.W    $0000,$C000         ; $022542 ORI.B  #$C000,D0
        DC.W    $0000,$0600         ; $022546 ORI.B  #$0600,D0
        MOVE.L  A4,$4F22(A2)                    ; $02254A
        BMI.S  loc_022525                       ; $02254E
        CMP.L  (A0),D0                          ; $022550
        MOVE.W  D2,-(A6)                        ; $022552
        SPL     $5BE9(A3)                       ; $022554
        ST      $3B03(A2)                       ; $022558
        OR.B   D4,(A2)+                         ; $02255C
        BVS.S  loc_022535                       ; $02255E
        BRA.S  loc_0224FA                       ; $022560
        AND.B  D4,A6                            ; $022562
        OR.B   A4,D4                            ; $022564
        OR.B   D4,(A5)                          ; $022566
        BSR.S  loc_02256D                       ; $022568
        AND.B  D3,A4                            ; $02256A
        BTST    D0,(A5)+                        ; $02256C
        BTST    D0,D3                           ; $02256E
        DC.W    $4F22               ; $022570 DC.W    $4F22
        BRA.S  loc_022507                       ; $022572
        AND.B  D1,D4                            ; $022574
        OR.B   D5,D6                            ; $022576
        CMPA.W  (A6)+,A0                        ; $022578
        ASL.B  #3,D4                            ; $02257A
        DIVS    -$4F0B(A4),D4                   ; $02257C
        OR.B   D0,D4                            ; $022580
        DC.W    $AFEA,$50EA         ; $022582 MOVE.L  $50EA(A2),<EA:3F>
        CMPA.W  (A7),A0                         ; $022586
        ASL.B  #3,D3                            ; $022588
        DIVS    -(A5),D4                        ; $02258A
        EOR.B  D0,A2                            ; $02258C
        OR.B   D0,D4                            ; $02258E
        DC.W    $AFE3               ; $022590 MOVE.L  -(A3),<EA:3F>
        ST      $4F26(A2)                       ; $022592
        DC.W    $000B,$1EB9         ; $022596 ORI.B  #$1EB9,A3
        DC.W    $0009,$0032         ; $02259A ORI.B  #$0032,A1
        ORI.W  #$0052,A0                        ; $02259E
        ORI.W  #$5CE8,-(A2)                     ; $0225A2
        BRA.S  loc_02257D                       ; $0225A6
        DIVS    -(A1),D0                        ; $0225A8
        BNE.S  loc_022581                       ; $0225AA
loc_0225AC:
        CMP.W  A4,D0                            ; $0225AC
        ASL.B  #3,D0                            ; $0225AE
loc_0225B0:
        BNE.S  loc_022587                       ; $0225B0
        CMP.W  A1,D0                            ; $0225B2
loc_0225B4:
        ROXL.B  #3,D0                           ; $0225B4
        MOVE.L  -(A6),D0                        ; $0225B6
loc_0225B8:
        BNE.S  loc_02258F                       ; $0225B8
        ROXR.B  D3,D0                           ; $0225BA
        CMP.W  A7,D0                            ; $0225BC
        ROXL.B  #3,D0                           ; $0225BE
        MOVE.L  (A5)+,D0                        ; $0225C0
        DC.W    $4F26               ; $0225C2 DC.W    $4F26
        ROXR.B  D3,D0                           ; $0225C4
        CMP.W  A2,D0                            ; $0225C6
        ASL.B  #3,D0                            ; $0225C8
        ASR.B  D3,D0                            ; $0225CA
        CMP.W  D7,D0                            ; $0225CC
        ROXL.B  #3,D0                           ; $0225CE
        MOVE.L  (A5),D0                         ; $0225D0
        DC.W    $4F26               ; $0225D2 DC.W    $4F26
        ASR.B  D3,D0                            ; $0225D4
        CMP.W  D2,D0                            ; $0225D6
        ASL.B  #3,D0                            ; $0225D8
        MOVE.L  (A0),D0                         ; $0225DA
        DC.W    $4F26               ; $0225DC DC.W    $4F26
        ROXR.W  #3,D0                           ; $0225DE
        MOVE.W  A4,(A3)+                        ; $0225E0
        ASL.B  #3,D4                            ; $0225E2
        BRA.S  loc_0225AC                       ; $0225E4
        MOVE.B  D0,D3                           ; $0225E6
        BRA.S  loc_0225B0                       ; $0225E8
        MOVE.B  D1,D3                           ; $0225EA
        BRA.S  loc_0225B4                       ; $0225EC
        MOVE.B  D2,D3                           ; $0225EE
        BRA.S  loc_0225B8                       ; $0225F0
        MOVE.B  D3,D3                           ; $0225F2
        DC.W    $4710               ; $0225F4 DC.W    $4710
        DIVS    $10(A5,D7.W),D7                 ; $0225F6
        DC.W    $000B,$7C10         ; $0225FA ORI.B  #$7C10,A3
        DC.W    $4F22               ; $0225FE DC.W    $4F22
        BRA.S  loc_0225D7                       ; $022600
        DIVS    -(A1),D0                        ; $022602
        BNE.S  loc_0225DB                       ; $022604
        CMP.B  (A7)+,D0                         ; $022606
        ASL.B  D3,D0                            ; $022608
        AND.B  D1,D4                            ; $02260A
        ROXL.B  D3,D0                           ; $02260C
        OR.B   D5,D7                            ; $02260E
        CMP.B  (A2)+,D0                         ; $022610
        BNE.S  loc_0225E9                       ; $022612
        BRA.S  loc_0225A9                       ; $022614
        AND.B  -(A0),D4                         ; $022616
        OR.B   D5,A0                            ; $022618
        DC.W    $4F26               ; $02261A DC.W    $4F26
        DC.W    $000B,$0009         ; $02261C ORI.B  #$0009,A3
        MOVE.W  A4,$10(PC,D1.W)                 ; $022620
        MOVE.B  -(A1),-(A3)                     ; $022624
        MOVE.B  -$0C(A2,A2.L),-(A3)             ; $022626
        MOVE.B  D3,-$29FB(A3)                   ; $02262A
        BSR.S  loc_022605                       ; $02262E
        BHI.S  loc_022607                       ; $022630
        BLS.S  loc_022609                       ; $022632
        DC.W    $4108               ; $022634 DC.W    $4108
        CLR.B  A0                               ; $022636
        DC.W    $4308               ; $022638 DC.W    $4308
        MOVE.B  (A0),D3                         ; $02263A
        MOVE.B  -(A1),D3                        ; $02263C
        DC.W    $4F26               ; $02263E DC.W    $4F26
        DC.W    $000B,$1632         ; $022640 ORI.B  #$1632,A3
        AND.B  D0,D0                            ; $022644
        BCHG    D3,#$36AC                       ; $022646
        SUBQ.W  #8,-(A0)                        ; $02264A
        MOVE.W  A4,$61(PC,D5.W)                 ; $02264C
        SUBQ.W  #1,-(A2)                        ; $022650
        ADDQ.W  #2,-(A3)                        ; $022652
        MOVE.B  (A0),-(A3)                      ; $022654
        MOVE.B  -(A1),-(A3)                     ; $022656
        MOVE.B  $0B(A2,D0.W),-(A3)              ; $022658
        MOVE.B  D3,$36CC(A3)                    ; $02265C
        SUBQ.W  #8,-(A0)                        ; $022660
        ADDQ.W  #1,-(A1)                        ; $022662
        MOVE.W  A4,$62(PC,D5.W)                 ; $022664
        ADDQ.W  #2,-(A3)                        ; $022668
        MOVE.B  (A0),-(A3)                      ; $02266A
        MOVE.B  -(A1),-(A3)                     ; $02266C
        MOVE.B  $0B(A2,D0.W),-(A3)              ; $02266E
        MOVE.B  D3,$4F22(A3)                    ; $022672
        SPL     $5CE7(A3)                       ; $022676
        SVS     -(A3)                           ; $02267A
        SEQ     -(A2)                           ; $02267C
        ADD.B  D2,(A5)+                         ; $02267E
        SUB.B  $1D(A7,A5.W),D3                  ; $022680
        DC.W    $4C0B               ; $022684 DC.W    $4C0B
        BRA.S  loc_02265D                       ; $022686
        DC.W    $0028,$054F,$054F   ; $022688 ORI.B  #$054F,$054F(A0)
        DC.W    $054F               ; $02268E BCHG    D2,A7
        MOVE.W  $46(A4,D6.L),$000A(PC)          ; $022690
        BTST    D1,(A2)+                        ; $022696
        MOVE.L  A5,-(A1)                        ; $022698
        MOVE.W  A4,$30(A1,D1.W)                 ; $02269A
        MOVEA.B $00(A4,A6.W),A3                 ; $02269E
        MOVE.B  D5,D3                           ; $0226A2
        DC.W    $0028,$74D0,$054F   ; $0226A4 ORI.B  #$74D0,$054F(A0)
        MOVE.B  $4F(A2,D0.W),D5                 ; $0226AA
        DC.W    $054F               ; $0226AE BCHG    D2,A7
        MOVE.W  $46(A4,D6.L),$000A(PC)          ; $0226B0
        BTST    D0,(A2)+                        ; $0226B6
        DC.W    $0028,$210D,$318C   ; $0226B8 ORI.B  #$210D,$318C(A0)
        MOVE.B  (A0),D5                         ; $0226BE
        DC.W    $054F               ; $0226C0 BCHG    D2,A7
        DC.W    $054F               ; $0226C2 BCHG    D2,A7
        DC.W    $054F               ; $0226C4 BCHG    D2,A7
        MOVE.W  $37(A4,D3.L),$6846(PC)          ; $0226C6
        DC.W    $000A,$021A         ; $0226CC ORI.B  #$021A,A2
        MOVE.L  A5,D1                           ; $0226D0
        MOVE.W  A4,(A1)                         ; $0226D2
        MOVE.B  -(A1),D5                        ; $0226D4
        OR.B   D4,D6                            ; $0226D6
        SUBQ.W  #1,-(A7)                        ; $0226D8
        DC.W    $313D               ; $0226DA MOVE.W  <EA:3D>,-(A0)
        DC.W    $000A,$323D         ; $0226DC ORI.B  #$323D,A2
        OR.L   D0,-(A6)                         ; $0226E0
        DC.W    $000A,$81A7         ; $0226E2 ORI.B  #$81A7,A2
        DC.W    $4B10               ; $0226E6 DC.W    $4B10
        DIVS    A4,D7                           ; $0226E8
        MOVEQ   #$10,D5                         ; $0226EA
        DC.W    $4F26               ; $0226EC DC.W    $4F26
        DC.W    $000B,$0009         ; $0226EE ORI.B  #$0009,A3
        MOVE.W  D0,-(A7)                        ; $0226F2
        AND.B  D0,D0                            ; $0226F4
        BCHG    D3,$00(A0,A4.W)                 ; $0226F6
        BCHG    D3,-(A0)                        ; $0226FA
        BSR.S  loc_0226D3                       ; $0226FC
        DC.W    $4008               ; $0226FE NEGX.B A0
        DC.W    $4008               ; $022700 NEGX.B A0
        DC.W    $4008               ; $022702 NEGX.B A0
        MOVE.B  D0,-(A2)                        ; $022704
        BHI.S  loc_0226DD                       ; $022706
        DC.W    $4108               ; $022708 DC.W    $4108
        DC.W    $4108               ; $02270A DC.W    $4108
        DC.W    $4108               ; $02270C DC.W    $4108
        MOVE.B  (A1),-(A2)                      ; $02270E
        CLR.B  A0                               ; $022710
        CLR.B  A0                               ; $022712
        CLR.B  A0                               ; $022714
        DC.W    $000B,$1522         ; $022716 ORI.B  #$1522,A3
        BSR.S  loc_0226F1                       ; $02271A
        NEGX.B (A0)+                            ; $02271C
        DC.W    $4008               ; $02271E NEGX.B A0
        NEGX.B D0                               ; $022720
        MOVE.B  D0,-(A2)                        ; $022722
        BHI.S  loc_0226FB                       ; $022724
        DC.W    $4118               ; $022726 DC.W    $4118
        DC.W    $4108               ; $022728 DC.W    $4108
        DC.W    $4100               ; $02272A DC.W    $4100
        MOVE.B  (A1),-(A2)                      ; $02272C
        CLR.B  (A0)+                            ; $02272E
        CLR.B  A0                               ; $022730
        CLR.B  D0                               ; $022732
        DC.W    $000B,$1522         ; $022734 ORI.B  #$1522,A3
        SHI     -(A5)                           ; $022738
        BCS.S  loc_0226FF                       ; $02273A
        SLS     -(A4)                           ; $02273C
        ASR.B  #3,D2                            ; $02273E
        SCC     -(A3)                           ; $022740
        ASR.B  #8,D0                            ; $022742
        SUBQ.W  #8,(A0)                         ; $022744
        DC.W    $4111               ; $022746 DC.W    $4111
        OR.B   D4,D0                            ; $022748
        BSR.S  loc_022767                       ; $02274A
        MOVE.W  (A3),D1                         ; $02274C
        OR.B   D5,A3                            ; $02274E
        SUBQ.W  #8,(A2)                         ; $022750
        MOVE.W  (A3),-(A1)                      ; $022752
        OR.B   D5,A0                            ; $022754
        MOVE.W  (A3),D2                         ; $022756
        OR.B   D5,D0                            ; $022758
        MOVEA.L $4600(A3),A0                    ; $02275A
        DC.W    $4710               ; $02275E DC.W    $4710
        DIVS    $10(A0,D7.W),D7                 ; $022760
        DC.W    $000B,$0008         ; $022764 ORI.B  #$0008,A3
        DC.W    $000B,$0018         ; $022768 ORI.B  #$0018,A3
        OR.B   D6,$22(A2,D4.L)                  ; $02276C
        EOR.B  D7,$03(A5,D6.W)                  ; $022770
        AND.B  D3,D3                            ; $022774
        BTST    D0,(A5)+                        ; $022776
        BTST    D0,D3                           ; $022778
        DC.W    $4F22               ; $02277A DC.W    $4F22
        DC.W    $4F26               ; $02277C DC.W    $4F26
        DC.W    $000B,$7CB0         ; $02277E ORI.B  #$7CB0,A3
        DC.W    $0009,$0056         ; $022782 ORI.B  #$0056,A1
        DC.W    $0214,$0238         ; $022786 ANDI.B  #$0238,(A4)
        ANDI.W  #$0270,(A4)+                    ; $02278A
        ORI.W  #$0294,(A0)                      ; $02278E
        DC.W    $02A8,$02C2,$02E6,$0050; $022792 ANDI.L  #$02C202E6,$0050(A0)
        DC.W    $02FA               ; $02279A DC.W    $02FA
        DC.W    $030E               ; $02279C BTST    D1,A6
        BTST    D1,-(A2)                        ; $02279E
        BTST    D1,$50(A6,D0.W)                 ; $0227A0
        OR.B   D6,$4F22BF19                     ; $0227A4
        BSR.S  loc_0227AF                       ; $0227AA
        AND.B  D3,D3                            ; $0227AC
        BTST    D0,(A5)+                        ; $0227AE
        BTST    D0,D3                           ; $0227B0
        DC.W    $4F22               ; $0227B2 DC.W    $4F22
        DC.W    $4F26               ; $0227B4 DC.W    $4F26
        DC.W    $000B,$7CB0         ; $0227B6 ORI.B  #$7CB0,A3
        DC.W    $0009,$0064         ; $0227BA ORI.B  #$0064,A1
        BTST    D1,(A2)                         ; $0227BE
        BTST    D1,-(A6)                        ; $0227C0
        BCHG    D1,D6                           ; $0227C2
        BCHG    D1,(A2)+                        ; $0227C4
        BCHG    D1,$0382(A6)                    ; $0227C6
        DC.W    $0018,$4F26         ; $0227CA ORI.B  #$4F26,(A0)+
        DC.W    $000B,$0009         ; $0227CE ORI.B  #$0009,A3
        DC.W    $4F22               ; $0227D2 DC.W    $4F22
        BRA.S  loc_022769                       ; $0227D4
        AND.B  (A0),D4                          ; $0227D6
        OR.B   D4,D2                            ; $0227D8
        DC.W    $B03D               ; $0227DA CMP.B  <EA:3D>,D0
        DC.W    $4C1E               ; $0227DC DC.W    $4C1E
        DIVS    $54(A5,A3.W),D5                 ; $0227DE
        LSL.B  #8,D6                            ; $0227E2
        ST      -(A4)                           ; $0227E4
        MOVE.W  D3,D2                           ; $0227E6
        DIVS    -$51(A0,A3.W),D4                ; $0227E8
        DC.W    $E1FE               ; $0227EC ASL.W  <EA:3E>
        DIVS    $6093(A5),D4                    ; $0227EE
        AND.B  -(A0),D4                         ; $0227F2
        OR.B   D6,D2                            ; $0227F4
        DIVS    -(A1),D2                        ; $0227F6
        CMPA.L  (A4)+,A0                        ; $0227F8
        DC.W    $0028,$E1FE,$2019   ; $0227FA ORI.B  #$E1FE,$2019(A0)
        OR.L   D0,-$3D(A1,D5.W)                 ; $022800
        SF      D7                              ; $022804
        DBHI    D3,$027BD7                      ; $022806
        MOVE.B  D1,-(A5)                        ; $02280A
        MOVE.B  (A2),-(A5)                      ; $02280C
        MOVE.B  -(A3),-(A5)                     ; $02280E
        MOVE.B  $26(A4,D4.L),-(A5)              ; $022810
        DC.W    $000B,$7B14         ; $022814 ORI.B  #$7B14,A3
        DC.W    $4F22               ; $022818 DC.W    $4F22
        BRA.S  loc_0227AF                       ; $02281A
        AND.B  (A0),D4                          ; $02281C
        OR.B   D4,D2                            ; $02281E
        CMP.B  (A2)+,D0                         ; $022820
        DC.W    $4C1E               ; $022822 DC.W    $4C1E
        DIVS    (A2),D5                         ; $022824
        CMP.W  -$1EF2(A0),D0                    ; $022826
        ST      -(A4)                           ; $02282A
        MOVE.W  D3,D2                           ; $02282C
        DIVS    A5,D4                           ; $02282E
        CMP.L  A4,D0                            ; $022830
        DC.W    $E1FE               ; $022832 ASL.W  <EA:3E>
        DIVS    A2,D4                           ; $022834
        BRA.S  loc_0227CB                       ; $022836
        AND.B  -(A0),D4                         ; $022838
        OR.B   D6,D2                            ; $02283A
        DIVS    -(A1),D2                        ; $02283C
        EOR.L  D0,$0028CB01                     ; $02283E
        OR.L   D0,-$3D(A1,D5.W)                 ; $022844
        SF      D7                              ; $022848
        DBHI    D3,$02434D                      ; $02284A
        MOVE.B  (A2),-(A5)                      ; $02284E
        MOVE.B  -(A3),-(A5)                     ; $022850
        DC.W    $4F26               ; $022852 DC.W    $4F26
        DC.W    $000B,$7B10         ; $022854 ORI.B  #$7B10,A3
        AND.B  D2,A6                            ; $022858
        BSR.S  loc_02285F                       ; $02285A
        AND.B  D2,D6                            ; $02285C
        BCS.S  loc_022873                       ; $02285E
        MOVE.W  A0,-(A0)                        ; $022860
        AND.B  D2,(A7)                          ; $022862
        BHI.S  loc_022869                       ; $022864
        AND.B  D2,A7                            ; $022866
        BNE.S  loc_02286D                       ; $022868
        MOVE.W  A0,D1                           ; $02286A
        AND.B  D2,(A6)                          ; $02286C
        MOVE.L  (A7)+,D1                        ; $02286E
        ADD.B  D0,D5                            ; $022870
        MOVEA.W (A0)+,A0                        ; $022872
        MOVE.L  D5,-(A0)                        ; $022874
        AND.B  D2,D7                            ; $022876
        MOVEA.W $2105(A0),A0                    ; $022878
        DC.W    $411F               ; $02287C DC.W    $411F
        DC.W    $001A,$000B         ; $02287E ORI.B  #$000B,(A2)+
        NEGX.B (A5)                             ; $022882
        DC.W    $0009,$0009         ; $022884 ORI.B  #$0009,A1
        AND.B  D0,D0                            ; $022888
        BCLR    D3,(A0)+                        ; $02288A
        MOVE.L  (A1)+,$03(A0,A4.W)              ; $02288C
        BTST    D0,(A5)+                        ; $022890
        DBEQ    D6,$027F5E                      ; $022892
        SCS     D6                              ; $022896
        BTST    D0,-(A3)                        ; $022898
        SCC     D2                              ; $02289A
        DC.W    $000C,$0018         ; $02289C ORI.B  #$0018,A4
        DC.W    $0030,$0052,$0044   ; $0228A0 ORI.B  #$0052,$44(A0,D0.W)
        ORI.W  #$345C,(A0)+                     ; $0228A6
        MOVEA.W $347C(A4),A2                    ; $0228AA
        NEG.B  -(A1)                            ; $0228AE
        DC.W    $000B,$4421         ; $0228B0 ORI.B  #$4421,A3
        MOVEA.W $00(A3,A0.L),A2                 ; $0228B4
        BCC.S  loc_02292D                       ; $0228B8
        MOVEA.W -(A3),A2                        ; $0228BA
        OR.B   D5,D0                            ; $0228BC
        BCC.S  loc_022923                       ; $0228BE
        MOVEA.W (A3),A2                         ; $0228C0
        OR.B   D5,D1                            ; $0228C2
        DC.W    $000B,$6453         ; $0228C4 ORI.B  #$6453,A3
        DC.W    $000B,$0009         ; $0228C8 ORI.B  #$0009,A3
        MOVEA.W $00(A3,A0.L),A2                 ; $0228CC
        BCC.S  loc_022945                       ; $0228D0
        MOVEA.W -(A3),A2                        ; $0228D2
        OR.B   D4,D0                            ; $0228D4
        BCC.S  loc_02293B                       ; $0228D6
        MOVEA.W (A3),A2                         ; $0228D8
        DIVS    $0B(A5,D0.W),D4                 ; $0228DA
        BCC.S  loc_022933                       ; $0228DE
        ADD.B  D0,(A7)                          ; $0228E0
        DC.W    $002A,$BFF3,$3473   ; $0228E2 ORI.B  #$BFF3,$3473(A2)
        NEGX.B $000B(A2)                        ; $0228E8
        MOVE.W  (A4)+,D2                        ; $0228EC
        ADD.B  D0,(A5)                          ; $0228EE
        DC.W    $AFF8,$002A         ; $0228F0 MOVE.L  $002A.W,<EA:3F>
        ADD.B  D0,(A4)                          ; $0228F4
        DC.W    $AFF5,$002A         ; $0228F6 MOVE.L  $2A(A5,D0.W),<EA:3F>
        MOVE.L  (A1)+,$02(A0,A4.W)              ; $0228FA
        BTST    D0,(A5)+                        ; $0228FE
        DBNE    D2,$027EC8                      ; $022900
        BTST    D0,-(A3)                        ; $022904
        SCC     D2                              ; $022906
        DC.W    $000C,$FFB2         ; $022908 ORI.B  #$FFB2,A4
        DC.W    $FFCA               ; $02290C MOVE.W  A2,<EA:3F>
        DC.W    $002A,$001C,$0030   ; $02290E ORI.B  #$001C,$0030(A2)
        MOVEA.W (A4)+,A2                        ; $022914
        SUB.B  (A2),D0                          ; $022916
        MOVEA.W $340D(A4),A2                    ; $022918
        DC.W    $050A               ; $02291C BTST    D2,A2
        SUBI.B  #$000B,(A2)+                    ; $02291E
        MOVEA.L (A5)+,A2                        ; $022922
        ADD.B  D0,D6                            ; $022924
        DC.W    $002A,$BFD4,$3463   ; $022926 ORI.B  #$BFD4,$3463(A2)
        NEGX.B $000B(A2)                        ; $02292C
        MOVE.W  (A4)+,D2                        ; $022930
        ADD.B  D0,D4                            ; $022932
        DC.W    $AFF8,$002A         ; $022934 MOVE.L  $002A.W,<EA:3F>
        ADD.B  D0,D3                            ; $022938
        DC.W    $AFF5,$002A         ; $02293A MOVE.L  $2A(A5,D0.W),<EA:3F>
        SUBQ.W  #2,(A5)                         ; $02293E
        DC.W    $0010,$0000         ; $022940 ORI.B  #$0000,(A0)
        DC.W    $0018,$0000         ; $022944 ORI.B  #$0000,(A0)+
        DC.W    $0024,$0000         ; $022948 ORI.B  #$0000,-(A4)
        ROXR.B  #1,D0                           ; $02294C
        CLR.B  $3423(A0)                        ; $02294E
        OR.B   D5,(A0)                          ; $022952
        SHI     $53EF(A5)                       ; $022954
        NEG.B  (A1)+                            ; $022958
        NEG.B  A1                               ; $02295A
        NEG.B  A1                               ; $02295C
        MOVE.L  (A1)+,D2                        ; $02295E
        MOVE.W  A4,$6030(A1)                    ; $022960
        OR.B   (A0),D4                          ; $022964
        OR.B   D4,A3                            ; $022966
        NEG.B  A0                               ; $022968
        NEG.B  A0                               ; $02296A
        MOVEA.W A4,A1                           ; $02296C
        DC.W    $02B5,$7002,$000B,$2300; $02296E ANDI.L  #$7002000B,$00(A5,D2.W)
        SHI     $53EE(A4)                       ; $022976
        NEG.B  (A1)+                            ; $02297A
        DC.W    $AFEF,$4409         ; $02297C MOVE.L  $4409(A7),<EA:3F>
        MOVE.W  D2,-(A1)                        ; $022980
        BRA.S  loc_0229B4                       ; $022982
        OR.B   (A0),D4                          ; $022984
        OR.B   D4,D1                            ; $022986
        DC.W    $AFEE,$7402         ; $022988 MOVE.L  $7402(A6),<EA:3F>
        DC.W    $000B,$0009         ; $02298C ORI.B  #$0009,A3
        ASL.B  #8,D0                            ; $022990
        ROXR.B  #1,D0                           ; $022992
        CMPA.W  -(A0),A0                        ; $022994
        ASL.W  #1,D0                            ; $022996
        ASL.B  #8,D0                            ; $022998
        ROXR.B  D1,D0                           ; $02299A
        CMPA.W  (A4)+,A0                        ; $02299C
        ASL.B  #1,D0                            ; $02299E
        EOR.B  D7,(A0)+                         ; $0229A0
        DC.W    $4F22               ; $0229A2 DC.W    $4F22
        ROXL.B  #8,D0                           ; $0229A4
        CMPA.W  (A0),A0                         ; $0229A6
        ASR.B  D1,D0                            ; $0229A8
        ASL.W  #8,D0                            ; $0229AA
        CMPA.W  A5,A0                           ; $0229AC
        ROXR.B  #1,D0                           ; $0229AE
        MOVE.L  $26(A2,D4.L),-(A7)              ; $0229B0
loc_0229B4:
        ROXL.B  #8,D0                           ; $0229B4
        ASR.B  D1,D0                            ; $0229B6
        CMPA.W  A6,A0                           ; $0229B8
        ASL.W  #1,D0                            ; $0229BA
        ROXL.B  #8,D0                           ; $0229BC
        ASR.B  #1,D0                            ; $0229BE
        CMPA.W  A2,A0                           ; $0229C0
        ROXL.B  #1,D0                           ; $0229C2
        EOR.B  D7,D6                            ; $0229C4
        DC.W    $4F22               ; $0229C6 DC.W    $4F22
        ROXL.B  #8,D0                           ; $0229C8
        DC.W    $B0BE               ; $0229CA CMP.L  <EA:3E>,D0
        ASR.B  #1,D0                            ; $0229CC
        ASL.W  #8,D0                            ; $0229CE
        CMP.L  $10(PC,A6.W),D0                  ; $0229D0
        MOVE.L  -(A0),-(A7)                     ; $0229D4
        DC.W    $4F26               ; $0229D6 DC.W    $4F26
        ROXL.B  #8,D0                           ; $0229D8
        ASR.B  D1,D0                            ; $0229DA
        CMP.L  #$E310E100,D0                    ; $0229DC
        ROXR.B  D1,D0                           ; $0229E2
        CMP.L  $E300.W,D0                       ; $0229E4
        MOVE.L  $26(A3,D4.L),(A7)+              ; $0229E8
        ASL.B  D0,D0                            ; $0229EC
        ROXR.B  D1,D0                           ; $0229EE
        CMP.L  $40(A2,A6.W),D0                  ; $0229F0
        ASL.B  D0,D0                            ; $0229F4
        ROXR.B  #1,D0                           ; $0229F6
        CMP.L  -$1CE0(A6),D0                    ; $0229F8
        CMPA.W  $4F22(A2),A7                    ; $0229FC
        ROXL.B  D0,D0                           ; $022A00
        CMP.L  -(A2),D0                         ; $022A02
        ROXR.B  #1,D0                           ; $022A04
        ASL.W  #8,D0                            ; $022A06
        CMP.L  (A7)+,D0                         ; $022A08
        ASR.B  #1,D0                            ; $022A0A
        MOVE.L  D4,-(A7)                        ; $022A0C
        DC.W    $4F26               ; $022A0E DC.W    $4F26
        ASL.B  D0,D0                            ; $022A10
        ROXR.B  D1,D0                           ; $022A12
        CMP.L  -(A0),D0                         ; $022A14
        ASL.B  D1,D0                            ; $022A16
        ROXL.B  #8,D0                           ; $022A18
        ASR.B  #1,D0                            ; $022A1A
        CMP.L  (A4)+,D0                         ; $022A1C
        ROXL.B  #1,D0                           ; $022A1E
        MOVE.L  (A7),(A7)+                      ; $022A20
        DC.W    $4F26               ; $022A22 DC.W    $4F26
        ASL.B  D0,D0                            ; $022A24
        ROXR.B  D1,D0                           ; $022A26
        CMP.L  (A6),D0                          ; $022A28
        ROXL.B  #1,D0                           ; $022A2A
        ASL.B  #8,D0                            ; $022A2C
        ROXR.B  D1,D0                           ; $022A2E
        CMP.L  (A2),D0                          ; $022A30
        ASL.B  #1,D0                            ; $022A32
        ROXL.B  D0,D0                           ; $022A34
        CMP.L  A0,D0                            ; $022A36
        ASR.B  D1,D0                            ; $022A38
        MOVE.L  $4F26(A5),(A7)+                 ; $022A3A
        ROXL.B  D0,D0                           ; $022A3E
        ASR.B  #1,D0                            ; $022A40
        CMP.L  A1,D0                            ; $022A42
        ASL.W  #1,D0                            ; $022A44
        ROXL.B  D0,D0                           ; $022A46
        ASR.B  D1,D0                            ; $022A48
        CMP.L  D5,D0                            ; $022A4A
        ROXL.B  D1,D0                           ; $022A4C
        CMPA.W  D1,A7                           ; $022A4E
        DC.W    $4F22               ; $022A50 DC.W    $4F22
        ROXL.B  D0,D0                           ; $022A52
        CMP.W  $E210E140,D0                     ; $022A54
        CMP.W  $20(A6,A6.W),D0                  ; $022A5A
        MOVE.L  (A3)+,(A7)+                     ; $022A5E
        DC.W    $4F26               ; $022A60 DC.W    $4F26
        ASL.B  #8,D0                            ; $022A62
        ROXR.B  #1,D0                           ; $022A64
        CMP.W  $00(A7,A6.W),D0                  ; $022A66
        ROXL.B  D0,D0                           ; $022A6A
        ASR.B  D1,D0                            ; $022A6C
        CMP.W  $30(A3,A6.W),D0                  ; $022A6E
        MOVE.L  $4F26(A6),(A7)                  ; $022A72
        ROXL.B  #8,D0                           ; $022A76
        ASR.B  D1,D0                            ; $022A78
        CMP.W  -$1CF0(A5),D0                    ; $022A7A
        ROXL.B  D0,D0                           ; $022A7E
        ASR.B  D1,D0                            ; $022A80
        CMP.W  -$1D00(A1),D0                    ; $022A82
        MOVE.L  D7,(A7)+                        ; $022A86
        DC.W    $4F26               ; $022A88 DC.W    $4F26
        ROXL.B  D0,D0                           ; $022A8A
        ASR.B  #1,D0                            ; $022A8C
        CMP.W  -(A3),D0                         ; $022A8E
        ROXL.B  D1,D0                           ; $022A90
        ASL.B  D0,D0                            ; $022A92
        ROXR.B  #1,D0                           ; $022A94
        CMP.W  (A7)+,D0                         ; $022A96
        ASL.B  D1,D0                            ; $022A98
        MOVE.L  (A2)+,(A7)                      ; $022A9A
        DC.W    $4F26               ; $022A9C DC.W    $4F26
        ASL.B  #8,D0                            ; $022A9E
        ROXR.B  #1,D0                           ; $022AA0
        CMP.W  (A1)+,D0                         ; $022AA2
        ASL.B  #1,D0                            ; $022AA4
        ASL.B  D0,D0                            ; $022AA6
        ROXR.B  #1,D0                           ; $022AA8
        CMP.W  (A5),D0                          ; $022AAA
        ASL.B  D1,D0                            ; $022AAC
        CMP.L  $26(A3,D4.L),D7                  ; $022AAE
        ROXL.B  D0,D0                           ; $022AB2
        ASR.B  #1,D0                            ; $022AB4
        CMP.W  A7,D0                            ; $022AB6
        ASL.B  D1,D0                            ; $022AB8
        ROXL.B  #8,D0                           ; $022ABA
        ASR.B  #1,D0                            ; $022ABC
        CMP.W  A3,D0                            ; $022ABE
        ROXL.B  #1,D0                           ; $022AC0
        MOVE.L  $4F26(A1),(A7)                  ; $022AC2
        ASL.B  #8,D0                            ; $022AC6
        ASR.B  D1,D0                            ; $022AC8
        CMP.W  D5,D0                            ; $022ACA
        ROXL.B  D1,D0                           ; $022ACC
        ASL.B  #8,D0                            ; $022ACE
        ROXR.B  #1,D0                           ; $022AD0
        CMP.W  D1,D0                            ; $022AD2
        ASL.B  #1,D0                            ; $022AD4
        MOVEA.L #$4F26E110,A7                   ; $022AD6
        ASR.B  D1,D0                            ; $022ADC
        CMP.B  $40(PC,A6.W),D0                  ; $022ADE
        ROXL.B  #8,D0                           ; $022AE2
        ASR.B  #1,D0                            ; $022AE4
        CMP.B  $10(A7,A6.W),D0                  ; $022AE6
        ASL.B  D0,D0                            ; $022AEA
        CMP.B  -$1DD0(A5),D0                    ; $022AEC
        ASL.W  #8,D0                            ; $022AF0
        CMP.B  -$1DE0(A2),D0                    ; $022AF2
        MOVEA.L $4F26(A4),A7                    ; $022AF6
        ROXL.B  #8,D0                           ; $022AFA
        ASR.B  D1,D0                            ; $022AFC
        CMP.B  -$1CF0(A3),D0                    ; $022AFE
        ASL.B  #8,D0                            ; $022B02
        ASR.B  D1,D0                            ; $022B04
        CMP.B  -(A7),D0                         ; $022B06
        ASL.B  #1,D0                            ; $022B08
        MOVE.L  D5,(A7)                         ; $022B0A
        DC.W    $4F26               ; $022B0C DC.W    $4F26
        ASL.B  D0,D0                            ; $022B0E
        ASR.B  #1,D0                            ; $022B10
        CMP.B  -(A1),D0                         ; $022B12
        ROXL.B  D1,D0                           ; $022B14
        ASL.B  D0,D0                            ; $022B16
        ROXR.B  #1,D0                           ; $022B18
        CMP.B  (A5)+,D0                         ; $022B1A
        ASL.B  D1,D0                            ; $022B1C
        MOVEA.L (A0)+,A7                        ; $022B1E
        DC.W    $4F26               ; $022B20 DC.W    $4F26
        ASL.B  #8,D0                            ; $022B22
        ROXR.B  #1,D0                           ; $022B24
        CMP.B  (A7),D0                          ; $022B26
        ASL.B  #1,D0                            ; $022B28
        ASL.B  D0,D0                            ; $022B2A
        ROXR.B  #1,D0                           ; $022B2C
        CMP.B  (A3),D0                          ; $022B2E
        ASL.B  D1,D0                            ; $022B30
        MOVEA.L $26(A1,D4.L),A7                 ; $022B32
        ASL.B  D0,D0                            ; $022B36
        ASR.B  #1,D0                            ; $022B38
        CMP.B  A5,D0                            ; $022B3A
        ASL.B  D1,D0                            ; $022B3C
        ROXL.B  #8,D0                           ; $022B3E
        ASR.B  #1,D0                            ; $022B40
        CMP.B  A1,D0                            ; $022B42
        ROXL.B  #1,D0                           ; $022B44
        MOVEA.L -(A7),A7                        ; $022B46
        DC.W    $4F26               ; $022B48 DC.W    $4F26
        MOVE.W  A4,$32CC.W                      ; $022B4A
        ADDQ.B  #8,(A2)                         ; $022B4E
        MOVE.B  D2,D1                           ; $022B50
        ADDQ.B  #8,(A3)                         ; $022B52
        DC.W    $000B,$1203         ; $022B54 ORI.B  #$1203,A3
        SUB.B  D3,$31CC(A2)                     ; $022B58
        MOVE.W  A4,(A1)+                        ; $022B5C
        MOVE.W  A4,$50225412                    ; $022B5E
        MOVEA.W A0,A0                           ; $022B64
        MOVE.B  D0,-(A3)                        ; $022B66
        ST      -(A3)                           ; $022B68
        ADDQ.B  #2,-(A2)                        ; $022B6A
        MOVE.B  D2,-(A1)                        ; $022B6C
        MOVEA.W A0,A0                           ; $022B6E
        BCC.S  loc_022B7B                       ; $022B70
        BCC.S  loc_022BC3                       ; $022B72
        MOVE.B  D4,$4028(A3)                    ; $022B74
        MOVE.B  D5,-(A3)                        ; $022B78
        ADDQ.B  #2,-(A0)                        ; $022B7A
        SUBQ.B  #2,(A0)                         ; $022B7C
        MOVEA.W (A0)+,A2                        ; $022B7E
        ADDQ.W  #8,$0D(A7,D3.W)                 ; $022B80
        SUBI.B  #$051A,A2                       ; $022B84
        MOVE.L  A5,$5420(A2)                    ; $022B88
        MOVE.W  A4,$5421(A2)                    ; $022B8C
        ADDQ.B  #3,(A1)                         ; $022B90
        MOVEA.W $340D(A0),A2                    ; $022B92
        SUBI.B  #$061A,A2                       ; $022B96
        MOVEA.L A5,A3                           ; $022B9A
        ADDQ.B  #2,-(A1)                        ; $022B9C
        MOVEA.W A4,A3                           ; $022B9E
        SCC     -(A6)                           ; $022BA0
        MOVE.W  A5,$000A(A2)                    ; $022BA2
        OR.B   D0,$4D(A6,D3.W)                  ; $022BA6
        DC.W    $000A,$000B         ; $022BAA ORI.B  #$000B,A2
        OR.B   D0,$00(A7,A7.L)                  ; $022BAE
        DC.W    $0009,$D415         ; $022BB2 ORI.B  #$D415,A1
        ADD.B  D2,(A6)                          ; $022BB6
        DC.W    $054F               ; $022BB8 BCHG    D2,A7
        DC.W    $054F               ; $022BBA BCHG    D2,A7
        DC.W    $054F               ; $022BBC BCHG    D2,A7
        MOVEQ   #$04,D2                         ; $022BBE
        MOVE.W  $0A(A4,D0.W),$011A(PC)          ; $022BC0
        DC.W    $0028,$216D,$054F   ; $022BC6 ORI.B  #$216D,$054F(A0)
        DC.W    $054F               ; $022BCC BCHG    D2,A7
        DC.W    $054F               ; $022BCE BCHG    D2,A7
        MOVEQ   #$04,D2                         ; $022BD0
        MOVE.W  $0A(A4,D0.W),$021A(PC)          ; $022BD2
        DC.W    $0028,$226D,$054F   ; $022BD8 ORI.B  #$226D,$054F(A0)
        DC.W    $054F               ; $022BDE BCHG    D2,A7
        DC.W    $054F               ; $022BE0 BCHG    D2,A7
        ADDI.B  #$031A,A2                       ; $022BE2
        MOVE.L  $2F36(A5),$2F26(A1)             ; $022BE6
        MOVE.L  (A6),-(A7)                      ; $022BEC
        DC.W    $0028,$D508,$0F5F   ; $022BEE ORI.B  #$D508,$0F5F(A0)
        BCHG    D7,(A7)+                        ; $022BF4
        BCHG    D7,(A7)+                        ; $022BF6
        DC.W    $050A               ; $022BF8 BTST    D2,A2
        ROR.W  #$3657                           ; $022BFA
        OR.B   D4,A3                            ; $022BFE
        ASR.B  #3,D3                            ; $022C00
        MOVE.W  -(A7),-$76F8(A2)                ; $022C02
        DC.W    $4518               ; $022C06 DC.W    $4518
        DC.W    $000B,$305C         ; $022C08 ORI.B  #$305C,A3
        AND.B  D0,D0                            ; $022C0C
        BCHG    D3,D0                           ; $022C0E
        AND.B  D0,D0                            ; $022C10
        BCHG    D3,#$C000                       ; $022C12
        DC.W    $0788               ; $022C16 BCLR    D3,A0
        NOT.B  (A0)+                            ; $022C18
        DC.W    $000B,$306C         ; $022C1A ORI.B  #$306C,A3
        DC.W    $0009,$D006         ; $022C1E ORI.B  #$D006,A1
        BRA.W  $01B424                          ; $022C22
        OR.B   D4,D7                            ; $022C26
        ADD.B  D5,D1                            ; $022C28
        ADD.B  D0,D6                            ; $022C2A
        ASL.B  #3,D3                            ; $022C2C
        BRA.S  loc_022C45                       ; $022C2E
        MOVE.L  D1,D1                           ; $022C30
        DC.W    $4710               ; $022C32 DC.W    $4710
        DIVS    $02(PC,D7.W),D7                 ; $022C34
        DC.W    $000B,$0009         ; $022C38 ORI.B  #$0009,A3
        ADDI.B  #$C0D4,D0                       ; $022C3C
        AND.B  D0,D0                            ; $022C40
        BTST    D1,$00(A4,D0.W)                 ; $022C42
        MOVEA.L A0,A6                           ; $022C46
        BRA.S  loc_022C55                       ; $022C48
        DC.W    $000B,$4015         ; $022C4A ORI.B  #$4015,A3
        DC.W    $FFFF               ; $022C4E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $4F22               ; $022C50 DC.W    $4F22
        CMP.W  (A7)+,D6                         ; $022C52
        DC.W    $0009,$DD0A         ; $022C54 ORI.B  #$DD0A,A1
        ST      -(A4)                           ; $022C58
        MOVE.W  A4,-(A6)                        ; $022C5A
        DIVS    -(A7),D2                        ; $022C5C
        BEQ.S  loc_022C63                       ; $022C5E
        ADD.B  A0,D7                            ; $022C60
        ADD.B  A1,D0                            ; $022C62
        MOVE.B  D7,D7                           ; $022C64
        BRA.S  loc_022C3E                       ; $022C66
        DC.W    $2FD6               ; $022C68 MOVE.L  (A6),<EA:3F>
loc_022C6A:
        MOVE.L  $05(A6,A5.L),-$4FD9(A7)         ; $022C6A
        BLT.S  loc_022C75                       ; $022C70
        BEQ.S  loc_022C6A                       ; $022C72
        DC.W    $4710               ; $022C74 DC.W    $4710
        DIVS    -$0A(A6,D6.L),D7                ; $022C76
        DC.W    $4F26               ; $022C7A DC.W    $4F26
        DC.W    $000B,$0009         ; $022C7C ORI.B  #$0009,A3
        ADDI.B  #$C000,D0                       ; $022C80
        AND.B  D0,D0                            ; $022C84
        BTST    D3,D0                           ; $022C86
        ADDI.B  #$271A,D0                       ; $022C88
        DC.W    $4F22               ; $022C8C DC.W    $4F22
        DIVS    -(A0),D2                        ; $022C8E
        OR.B   D0,D4                            ; $022C90
        OR.B   D4,A3                            ; $022C92
        DC.W    $2FE6               ; $022C94 MOVE.L  -(A6),<EA:3F>
        DC.W    $2FD6               ; $022C96 MOVE.L  (A6),<EA:3F>
        MOVE.L  $3B(A6,A3.L),$0009(A7)          ; $022C98
        SLT     -(A4)                           ; $022C9E
loc_022CA0:
        ADD.B  D6,D7                            ; $022CA0
loc_022CA2:
        CMP.B  A5,D0                            ; $022CA2
        DC.W    $0009,$67F6         ; $022CA4 ORI.B  #$67F6,A1
        BLT.S  loc_022CA0                       ; $022CA8
        BGT.S  loc_022CA2                       ; $022CAA
        MOVE.W  $10(A0,D4.W),-(A6)              ; $022CAC
        DIVS    $7E14(A5),D7                    ; $022CB0
        DC.W    $4F26               ; $022CB4 DC.W    $4F26
        DC.W    $000B,$0009         ; $022CB6 ORI.B  #$0009,A3
        DC.W    $0000,$C000         ; $022CBA ORI.B  #$C000,D0
        BTST    D3,D0                           ; $022CBE
        DC.W    $4F22               ; $022CC0 DC.W    $4F22
        BRA.S  loc_022C99                       ; $022CC2
        BMI.S  loc_022C9B                       ; $022CC4
        DC.W    $4B15               ; $022CC6 DC.W    $4B15
        DC.W    $8B3F               ; $022CC8 OR.B   D5,<EA:3F>
loc_022CCA:
        MOVE.W  $D113.W,(A0)                    ; $022CCA
        DC.W    $410B               ; $022CCE DC.W    $410B
        MOVE.L  D6,-(A7)                        ; $022CD0
        BRA.S  loc_022CCA                       ; $022CD2
        BSR.S  loc_022CD9                       ; $022CD4
        DC.W    $4008               ; $022CD6 NEGX.B A0
        DC.W    $4100               ; $022CD8 DC.W    $4100
        MOVE.W  A4,-(A6)                        ; $022CDA
        MOVE.W  (A4)+,-(A6)                     ; $022CDC
        SPL     $5BE9(A3)                       ; $022CDE
        ST      $3B03(A2)                       ; $022CE2
        OR.B   D4,$69D5(A5)                     ; $022CE6
        BRA.S  loc_022C7F                       ; $022CEA
        AND.W  D0,D4                            ; $022CEC
        OR.B   D5,$6098(A1)                     ; $022CEE
        AND.B  D4,A6                            ; $022CF2
        OR.B   A4,D4                            ; $022CF4
        OR.B   D4,-(A5)                         ; $022CF6
        BSR.S  loc_022CFD                       ; $022CF8
        AND.B  D3,(A5)                          ; $022CFA
        BTST    D0,(A5)+                        ; $022CFC
        BTST    D0,D3                           ; $022CFE
        DC.W    $4F22               ; $022D00 DC.W    $4F22
        BRA.S  loc_022C97                       ; $022D02
        AND.B  D1,D4                            ; $022D04
        OR.B   D5,A7                            ; $022D06
        ADD.B  D5,D0                            ; $022D08
        DC.W    $400B               ; $022D0A NEGX.B A3
        ASL.B  #3,D4                            ; $022D0C
        DIVS    -$2EFC(A0),D4                   ; $022D0E
        DC.W    $410B               ; $022D12 DC.W    $410B
        OR.B   D0,D4                            ; $022D14
        DC.W    $AFE5               ; $022D16 MOVE.L  -(A5),<EA:3F>
        ST      $0000(A2)                       ; $022D18
        AND.B  D0,D0                            ; $022D1C
        BTST    D0,-$4000(A0)                   ; $022D1E
        BSET    D0,-$4000(A4)                   ; $022D22
        DC.W    $0220,$D004         ; $022D26 ANDI.B  #$D004,-(A0)
        DC.W    $400B               ; $022D2A NEGX.B A3
        ASL.B  #3,D3                            ; $022D2C
        DIVS    (A0)+,D4                        ; $022D2E
        ADD.B  D0,D3                            ; $022D30
        DC.W    $410B               ; $022D32 DC.W    $410B
        OR.B   D0,D4                            ; $022D34
        DC.W    $AFD5               ; $022D36 MOVE.L  (A5),<EA:3F>
        ST      $0000(A2)                       ; $022D38
        AND.B  D0,D0                            ; $022D3C
        BSET    D0,-$4000(A4)                   ; $022D3E
        ANDI.W  #$4F26,(A0)+                    ; $022D42
        DC.W    $000B,$1EB9         ; $022D46 ORI.B  #$1EB9,A3
        DC.W    $4F26               ; $022D4A DC.W    $4F26
        DC.W    $000B,$0009         ; $022D4C ORI.B  #$0009,A3
        ORI.W  #$0072,(A6)                      ; $022D50
        ORI.L  #$00965CE8,D0                    ; $022D54
        BRA.S  loc_022D31                       ; $022D5A
        DIVS    -(A1),D0                        ; $022D5C
        BNE.S  loc_022D35                       ; $022D5E
        ADD.B  D0,(A1)                          ; $022D60
loc_022D62:
        DC.W    $410B               ; $022D62 DC.W    $410B
        ASL.B  #3,D0                            ; $022D64
        BNE.S  loc_022D3D                       ; $022D66
        ADD.B  D0,A7                            ; $022D68
        DC.W    $410B               ; $022D6A DC.W    $410B
        ROXL.B  #3,D0                           ; $022D6C
        ADD.B  D0,A7                            ; $022D6E
        DC.W    $412B               ; $022D70 DC.W    $412B
        BNE.S  loc_022D49                       ; $022D72
        ROXR.B  D3,D0                           ; $022D74
        ADD.B  D0,A6                            ; $022D76
        DC.W    $410B               ; $022D78 DC.W    $410B
        ROXL.B  #3,D0                           ; $022D7A
        ADD.B  D0,A5                            ; $022D7C
        DC.W    $412B               ; $022D7E DC.W    $412B
        DC.W    $4F26               ; $022D80 DC.W    $4F26
        ROXR.B  D3,D0                           ; $022D82
        ADD.B  D0,A2                            ; $022D84
        DC.W    $410B               ; $022D86 DC.W    $410B
        ASL.B  #3,D0                            ; $022D88
        ASR.B  D3,D0                            ; $022D8A
        ADD.B  D0,A0                            ; $022D8C
        DC.W    $410B               ; $022D8E DC.W    $410B
        ROXL.B  #3,D0                           ; $022D90
        ADD.B  D0,A0                            ; $022D92
        DC.W    $412B               ; $022D94 DC.W    $412B
        DC.W    $4F26               ; $022D96 DC.W    $4F26
        ASR.B  D3,D0                            ; $022D98
        ADD.B  D0,D5                            ; $022D9A
        DC.W    $410B               ; $022D9C DC.W    $410B
        ASL.B  #3,D0                            ; $022D9E
        ADD.B  D0,D4                            ; $022DA0
        DC.W    $412B               ; $022DA2 DC.W    $412B
        DC.W    $4F26               ; $022DA4 DC.W    $4F26
        DC.W    $0000,$C000         ; $022DA6 ORI.B  #$C000,D0
        DC.W    $00FC               ; $022DAA DC.W    $00FC
        AND.B  D0,D0                            ; $022DAC
        DC.W    $00BA,$C000,$0112,$C000; $022DAE ORI.L  #$C0000112,-$4000(PC)
        DC.W    $00B2,$7D08,$C801,$8B00; $022DB6 ORI.L  #$7D08C801,$00(A2,A0.L)
        MOVE.W  D2,-(A6)                        ; $022DBE
        AND.B  -(A0),D4                         ; $022DC0
        OR.B   D4,D0                            ; $022DC2
        MOVE.W  D6,-(A6)                        ; $022DC4
loc_022DC6:
        BVS.S  loc_022D9D                       ; $022DC6
        BRA.S  loc_022D62                       ; $022DC8
        AND.B  D4,A6                            ; $022DCA
        OR.B   A4,D4                            ; $022DCC
        OR.L   D4,$88008D8B                     ; $022DCE
        BRA.S  loc_022D69                       ; $022DD4
loc_022DD6:
        MOVE.W  D4,-(A6)                        ; $022DD6
        AND.B  D1,D4                            ; $022DD8
        OR.B   D5,D0                            ; $022DDA
        MOVE.W  D2,-(A6)                        ; $022DDC
        AND.B  -(A0),D4                         ; $022DDE
        OR.B   D4,D0                            ; $022DE0
        MOVE.W  D6,-(A6)                        ; $022DE2
        DC.W    $AFEF,$0009         ; $022DE4 MOVE.L  $0009(A7),<EA:3F>
        ADD.B  A1,D6                            ; $022DE8
        ASL.B  #3,D3                            ; $022DEA
        ASR.B  #3,D3                            ; $022DEC
        BRA.S  loc_022DC6                       ; $022DEE
        DC.W    $4009               ; $022DF0 NEGX.B A1
        DC.W    $4009               ; $022DF2 NEGX.B A1
        DC.W    $4009               ; $022DF4 NEGX.B A1
        MOVE.L  D1,D6                           ; $022DF6
        NOT.B  (A0)                             ; $022DF8
        DIVS    $7C02.W,D7                      ; $022DFA
        BRA.S  loc_022DD6                       ; $022DFE
        MOVEQ   #$02,D6                         ; $022E00
        MOVE.L  D2,D6                           ; $022E02
        DC.W    $4710               ; $022E04 DC.W    $4710
        DIVS    $04(A1,D7.L),D7                 ; $022E06
        DC.W    $000B,$0009         ; $022E0A ORI.B  #$0009,A3
        DC.W    $0000,$C000         ; $022E0E ORI.B  #$C000,D0
        BCHG    D3,D0                           ; $022E12
        DC.W    $454F               ; $022E14 DC.W    $454F
        DC.W    $454F               ; $022E16 DC.W    $454F
        DC.W    $454F               ; $022E18 DC.W    $454F
        MOVEQ   #$02,D2                         ; $022E1A
        MOVE.W  $6846(PC),$031A(PC)             ; $022E1C
        DC.W    $4321               ; $022E22 DC.W    $4321
        DC.W    $4321               ; $022E24 DC.W    $4321
        DC.W    $4321               ; $022E26 DC.W    $4321
        DC.W    $4321               ; $022E28 DC.W    $4321
        MOVE.W  A4,$30(A1,D1.W)                 ; $022E2A
        MOVEA.B $00(A4,A6.W),A3                 ; $022E2E
        MOVE.B  D5,D3                           ; $022E32
        DC.W    $0028,$74DC,$454F   ; $022E34 ORI.B  #$74DC,$454F(A0)
        MOVE.B  $4F(A2,D4.W),D5                 ; $022E3A
        DC.W    $454F               ; $022E3E DC.W    $454F
        MOVEQ   #$02,D2                         ; $022E40
        MOVE.W  $6846(PC),$011A(PC)             ; $022E42
        DC.W    $4121               ; $022E48 DC.W    $4121
        DC.W    $4121               ; $022E4A DC.W    $4121
        DC.W    $4121               ; $022E4C DC.W    $4121
        DC.W    $4121               ; $022E4E DC.W    $4121
        DC.W    $0028,$318C,$1A10   ; $022E50 ORI.B  #$318C,$1A10(A0)
        DC.W    $454F               ; $022E56 DC.W    $454F
        DC.W    $454F               ; $022E58 DC.W    $454F
        DC.W    $454F               ; $022E5A DC.W    $454F
        MOVEQ   #$02,D2                         ; $022E5C
        MOVE.W  $6846(PC),$021A(PC)             ; $022E5E
        CLR.B  -(A1)                            ; $022E64
        CLR.B  -(A1)                            ; $022E66
        CLR.B  -(A1)                            ; $022E68
        CLR.B  -(A1)                            ; $022E6A
        MOVE.W  A4,(A1)                         ; $022E6C
        MOVE.B  -(A1),D5                        ; $022E6E
        MOVE.W  $07(A7,A0.L),-(A4)              ; $022E70
        SUBQ.W  #1,-(A7)                        ; $022E74
        DC.W    $313D               ; $022E76 MOVE.W  <EA:3D>,-(A0)
        DC.W    $000A,$323D         ; $022E78 ORI.B  #$323D,A2
        OR.L   D0,-(A6)                         ; $022E7C
        DC.W    $000A,$000B         ; $022E7E ORI.B  #$000B,A2
        OR.L   D0,-(A7)                         ; $022E82
        DC.W    $000B,$0009         ; $022E84 ORI.B  #$0009,A3
        DC.W    $454F               ; $022E88 DC.W    $454F
        DC.W    $454F               ; $022E8A DC.W    $454F
        DC.W    $454F               ; $022E8C DC.W    $454F
        MOVEQ   #$02,D2                         ; $022E8E
        MOVE.W  $6846(PC),$031A(PC)             ; $022E90
        DC.W    $4300               ; $022E96 DC.W    $4300
        MOVE.W  A4,$30(A1,D1.W)                 ; $022E98
        MOVEA.B $00(A4,A6.W),A3                 ; $022E9C
        MOVE.B  D5,D3                           ; $022EA0
        DC.W    $0028,$74DC,$454F   ; $022EA2 ORI.B  #$74DC,$454F(A0)
        MOVE.B  $4F(A2,D4.W),D5                 ; $022EA8
        DC.W    $454F               ; $022EAC DC.W    $454F
        MOVEQ   #$02,D2                         ; $022EAE
        MOVE.W  $6846(PC),$011A(PC)             ; $022EB0
        DC.W    $4100               ; $022EB6 DC.W    $4100
        DC.W    $0028,$318C,$1A10   ; $022EB8 ORI.B  #$318C,$1A10(A0)
        DC.W    $454F               ; $022EBE DC.W    $454F
        DC.W    $454F               ; $022EC0 DC.W    $454F
        DC.W    $454F               ; $022EC2 DC.W    $454F
        MOVEQ   #$02,D2                         ; $022EC4
        MOVE.W  $6846(PC),$021A(PC)             ; $022EC6
        CLR.B  D0                               ; $022ECC
        MOVE.W  A4,(A1)                         ; $022ECE
        MOVE.B  -(A1),D5                        ; $022ED0
        MOVE.W  $07(A7,A0.L),-(A4)              ; $022ED2
        SUBQ.W  #1,-(A7)                        ; $022ED6
        DC.W    $313D               ; $022ED8 MOVE.W  <EA:3D>,-(A0)
        DC.W    $000A,$323D         ; $022EDA ORI.B  #$323D,A2
        OR.L   D0,-(A6)                         ; $022EDE
        DC.W    $000A,$000B         ; $022EE0 ORI.B  #$000B,A2
        OR.L   D0,-(A7)                         ; $022EE4
        DC.W    $000B,$0009         ; $022EE6 ORI.B  #$0009,A3
        DC.W    $FFFF               ; $022EEA MOVE.W  <EA:3F>,<EA:3F>
        AND.B  D3,(A0)+                         ; $022EEC
        MOVE.L  D1,D0                           ; $022EEE
        DC.W    $0009,$C713         ; $022EF0 ORI.B  #$C713,A1
        ADD.B  A0,D7                            ; $022EF4
        ASL.B  #3,D4                            ; $022EF6
        ADD.B  D6,A0                            ; $022EF8
        BSR.S  loc_022F02                       ; $022EFA
        MOVE.L  (A2),-(A6)                      ; $022EFC
        DC.W    $4710               ; $022EFE DC.W    $4710
        DIVS    $04(PC,D7.L),D7                 ; $022F00
        AND.B  D3,D7                            ; $022F04
        ASL.B  #3,D7                            ; $022F06
        ADD.B  D6,D5                            ; $022F08
        BSR.S  loc_022F12                       ; $022F0A
        MOVE.L  (A2),-(A6)                      ; $022F0C
        DC.W    $4710               ; $022F0E DC.W    $4710
        DIVS    $04(PC,D7.L),D7                 ; $022F10
        DC.W    $000B,$0009         ; $022F14 ORI.B  #$0009,A3
        AND.B  D0,D0                            ; $022F18
        BTST    D3,D0                           ; $022F1A
        AND.B  D0,D0                            ; $022F1C
        BTST    D3,-(A0)                        ; $022F1E
        AND.B  D0,D0                            ; $022F20
        BTST    D3,D4                           ; $022F22
        DC.W    $0000,$0000         ; $022F24 ORI.B  #$0000,D0
        DC.W    $0000,$0070         ; $022F28 ORI.B  #$0070,D0
        DC.W    $0000,$0000         ; $022F2C ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $022F30 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $022F34 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $022F38 ORI.B  #$0000,D0
        ADDI.B  #$26FC,D0                       ; $022F3C
        ADDI.B  #$F400,D0                       ; $022F40
        ADDI.B  #$6000,D1                       ; $022F44
        ADDI.B  #$6FEC,D1                       ; $022F48
        ADDI.B  #$8000,D1                       ; $022F4C
        ADDI.B  #$F600,D0                       ; $022F50
        ADDI.B  #$7000,D1                       ; $022F54
        ADDI.B  #$7FEC,D1                       ; $022F58
        ADDI.B  #$C000,D1                       ; $022F5C
        DC.W    $4F22               ; $022F60 DC.W    $4F22
        DIVS    -(A0),D2                        ; $022F62
        OR.B   D0,D4                            ; $022F64
        OR.B   D4,A3                            ; $022F66
        DC.W    $2FE6               ; $022F68 MOVE.L  -(A6),<EA:3F>
        DC.W    $2FD6               ; $022F6A MOVE.L  (A6),<EA:3F>
        MOVE.L  $4D(A6,A3.W),$0009(A7)          ; $022F6C
        SLT     -(A4)                           ; $022F72
loc_022F74:
        ADD.B  D6,D7                            ; $022F74
loc_022F76:
        CMP.W  (A2)+,D0                         ; $022F76
        DC.W    $0009,$67F6         ; $022F78 ORI.B  #$67F6,A1
        BLT.S  loc_022F74                       ; $022F7C
        BGT.S  loc_022F76                       ; $022F7E
        MOVE.W  $10(A0,D4.W),-(A6)              ; $022F80
        DIVS    $7E14(A5),D7                    ; $022F84
        DC.W    $4F26               ; $022F88 DC.W    $4F26
        DC.W    $000B,$0009         ; $022F8A ORI.B  #$0009,A3
        DC.W    $0000,$C000         ; $022F8E ORI.B  #$C000,D0
        BTST    D3,D0                           ; $022F92
        DC.W    $4F22               ; $022F94 DC.W    $4F22
        DIVS    -(A0),D2                        ; $022F96
        OR.B   D0,D4                            ; $022F98
        OR.B   D4,A5                            ; $022F9A
        DC.W    $2FE6               ; $022F9C MOVE.L  -(A6),<EA:3F>
        DC.W    $2FD6               ; $022F9E MOVE.L  (A6),<EA:3F>
        MOVE.L  $33(A6,A3.W),$0009(A7)          ; $022FA0
        SLT     -(A4)                           ; $022FA6
        ADD.B  D7,D7                            ; $022FA8
        CMP.B  A7,D0                            ; $022FAA
loc_022FAC:
        DC.W    $0009,$B039         ; $022FAC ORI.B  #$B039,A1
        DC.W    $0009,$67F6         ; $022FB0 ORI.B  #$67F6,A1
        BLT.S  loc_022FAC                       ; $022FB4
        BGT.S  loc_022FAE                       ; $022FB6
        MOVE.W  $10(A0,D4.W),-(A6)              ; $022FB8
        DIVS    $7E14(A3),D7                    ; $022FBC
        DC.W    $4F26               ; $022FC0 DC.W    $4F26
        DC.W    $000B,$0009         ; $022FC2 ORI.B  #$0009,A3
        DC.W    $0000,$C000         ; $022FC6 ORI.B  #$C000,D0
        BTST    D3,D0                           ; $022FCA
        ADD.B  D0,D6                            ; $022FCC
        ADDQ.B  #8,(A3)+                        ; $022FCE
        SUB.B  D0,A0                            ; $022FD0
        MOVE.B  D0,-(A0)                        ; $022FD2
loc_022FD4:
        ST      -(A2)                           ; $022FD4
        MOVE.B  D4,-(A0)                        ; $022FD6
        ASR.B  #8,D0                            ; $022FD8
        MOVE.B  D5,-(A0)                        ; $022FDA
        ADDQ.B  #8,(A7)                         ; $022FDC
        MOVE.B  D6,D7                           ; $022FDE
        DC.W    $000B,$0009         ; $022FE0 ORI.B  #$0009,A3
        MOVE.W  D0,-(A7)                        ; $022FE4
        DC.W    $0000,$C000         ; $022FE6 ORI.B  #$C000,D0
        BCHG    D3,D0                           ; $022FEA
        ADD.B  D0,D5                            ; $022FEC
        ADD.B  D6,D0                            ; $022FEE
        SUB.B  D3,D6                            ; $022FF0
        BHI.S  loc_022FFA                       ; $022FF2
        MOVE.L  -(A2),-(A0)                     ; $022FF4
        DC.W    $4710               ; $022FF6 DC.W    $4710
        DIVS    $04(PC,D7.W),D7                 ; $022FF8
        DC.W    $000B,$0009         ; $022FFC ORI.B  #$0009,A3
        ORI.L  #$0000C000,D5                    ; $023000
        DC.W    $0000,$0600         ; $023006 ORI.B  #$0600,D0
        MOVE.W  A4,D0                           ; $02300A
        ADD.B  D4,D6                            ; $02300C
        LSL.B  #3,D4                            ; $02300E
        BRA.S  loc_022FE8                       ; $023010
        MOVE.L  D2,D6                           ; $023012
        DC.W    $4710               ; $023014 DC.W    $4710
        DIVS    $04(PC,D7.L),D7                 ; $023016
        DC.W    $000B,$0009         ; $02301A ORI.B  #$0009,A3
        DC.W    $0000,$C000         ; $02301E ORI.B  #$C000,D0
        BCHG    D3,D0                           ; $023022
        DC.W    $4F22               ; $023024 DC.W    $4F22
        CMP.L  -(A7),D0                         ; $023026
        MOVE.W  D2,-(A6)                        ; $023028
        MOVE.L  D3,D0                           ; $02302A
        DC.W    $0009,$4F22         ; $02302C ORI.B  #$4F22,A1
        CMP.W  (A2)+,D0                         ; $023030
        MOVE.W  D2,-(A6)                        ; $023032
        SPL     $5BE9(A3)                       ; $023034
        BVS.S  loc_02300F                       ; $023038
        BRA.S  loc_022FD4                       ; $02303A
        AND.B  D4,A6                            ; $02303C
        OR.B   A4,D4                            ; $02303E
        OR.B   D4,A7                            ; $023040
        BSR.S  loc_023047                       ; $023042
        AND.B  D3,A0                            ; $023044
        BTST    D0,(A5)+                        ; $023046
        BTST    D0,D3                           ; $023048
        DC.W    $0009,$6093         ; $02304A ORI.B  #$6093,A1
        AND.B  D1,D4                            ; $02304E
        OR.B   D5,D3                            ; $023050
        CMPA.W  A1,A0                           ; $023052
        DIVS    -(A1),D2                        ; $023054
        DC.W    $AFF0,$69D5         ; $023056 MOVE.L  -$2B(A0,D6.L),<EA:3F>
        CMPA.W  (A4),A0                         ; $02305A
        DIVS    -(A1),D2                        ; $02305C
        DC.W    $AFEC,$69D5         ; $02305E MOVE.L  $69D5(A4),<EA:3F>
        DC.W    $4F26               ; $023062 DC.W    $4F26
        DC.W    $000B,$1EB9         ; $023064 ORI.B  #$1EB9,A3
        DC.W    $0024,$003C         ; $023068 ORI.B  #$003C,-(A4)
        ORI.W  #$005A,A0                        ; $02306C
        DC.W    $4F22               ; $023070 DC.W    $4F22
        SGE     $60D5(A0)                       ; $023072
        DIVS    -(A1),D0                        ; $023076
        BNE.S  loc_02304F                       ; $023078
        CMP.B  -$1900(A3),D0                    ; $02307A
        BNE.S  loc_023055                       ; $02307E
        CMP.B  -$18F0(A0),D0                    ; $023080
        MOVE.L  (A1)+,D0                        ; $023084
        BNE.S  loc_02305D                       ; $023086
        DC.W    $4F22               ; $023088 DC.W    $4F22
        ROXR.B  D3,D0                           ; $02308A
        CMP.B  -(A7),D0                         ; $02308C
        ROXL.B  #3,D0                           ; $02308E
        MOVE.L  A7,D0                           ; $023090
        DC.W    $4F26               ; $023092 DC.W    $4F26
        DC.W    $4F22               ; $023094 DC.W    $4F22
        ROXR.B  D3,D0                           ; $023096
        CMP.B  -(A1),D0                         ; $023098
        ASL.B  #3,D0                            ; $02309A
        ASR.B  D3,D0                            ; $02309C
        CMP.B  (A6)+,D0                         ; $02309E
        ROXL.B  #3,D0                           ; $0230A0
        MOVE.L  D6,D0                           ; $0230A2
        DC.W    $4F26               ; $0230A4 DC.W    $4F26
        DC.W    $4F22               ; $0230A6 DC.W    $4F22
        ASR.B  D3,D0                            ; $0230A8
        CMP.B  (A0)+,D0                         ; $0230AA
        ASL.B  #3,D0                            ; $0230AC
        MOVE.L  D0,D0                           ; $0230AE
        DC.W    $4F26               ; $0230B0 DC.W    $4F26
        DC.W    $4F22               ; $0230B2 DC.W    $4F22
        BRA.S  loc_02308B                       ; $0230B4
        DIVS    -(A1),D0                        ; $0230B6
        BNE.S  loc_02308F                       ; $0230B8
        CMP.B  A3,D0                            ; $0230BA
        ASL.B  D3,D0                            ; $0230BC
        AND.B  D1,D4                            ; $0230BE
        ROXL.B  D3,D0                           ; $0230C0
        OR.B   D5,D4                            ; $0230C2
        CMP.B  D6,D0                            ; $0230C4
        BNE.S  loc_02309D                       ; $0230C6
        DC.W    $4F26               ; $0230C8 DC.W    $4F26
        DC.W    $000B,$0009         ; $0230CA ORI.B  #$0009,A3
        MOVE.W  A4,-$06(PC,A2.L)                ; $0230CE
        MOVE.B  D3,$36AC(A3)                    ; $0230D2
        MOVE.W  A4,$63(PC,D5.W)                 ; $0230D6
        DC.W    $000B,$1743         ; $0230DA ORI.B  #$1743,A3
        MOVE.W  A4,(A3)+                        ; $0230DE
        MOVE.W  A4,$63(PC,D5.W)                 ; $0230E0
        DC.W    $000B,$1743         ; $0230E4 ORI.B  #$1743,A3
        DC.W    $2FE6               ; $0230E8 MOVE.L  -(A6),<EA:3F>
        DC.W    $4F22               ; $0230EA DC.W    $4F22
        BMI.S  loc_0230C3                       ; $0230EC
        SPL     $5CE4(A3)                       ; $0230EE
        BVS.S  loc_0230BD                       ; $0230F2
        BVS.S  loc_023095                       ; $0230F4
        BGE.S  loc_0230C7                       ; $0230F6
        SEQ     -(A2)                           ; $0230F8
        ADD.B  D7,D2                            ; $0230FA
        ADD.B  D2,D7                            ; $0230FC
        SUB.B  A2,D3                            ; $0230FE
        SGT     -(A7)                           ; $023100
        DC.W    $4E0B               ; $023102 DC.W    $4E0B
        BRA.S  loc_0230DB                       ; $023104
        CMP.B  A3,D0                            ; $023106
        DC.W    $0028,$4B10,$8FF9   ; $023108 ORI.B  #$4B10,-$7007(A0)
        MOVEQ   #$10,D5                         ; $02310E
        DC.W    $4F26               ; $023110 DC.W    $4F26
        DC.W    $000B,$6EF6         ; $023112 ORI.B  #$6EF6,A3
        MOVE.W  D0,-(A7)                        ; $023116
        AND.B  D0,D0                            ; $023118
        BCHG    D3,-(A0)                        ; $02311A
        AND.B  D0,D0                            ; $02311C
        BCHG    D3,$4F(A0,D0.W)                 ; $02311E
        DC.W    $054F               ; $023122 BCHG    D2,A7
        DC.W    $054F               ; $023124 BCHG    D2,A7
        MOVE.W  $46(A4,D6.L),$74D0(PC)          ; $023126
        DC.W    $000A,$031A         ; $02312C ORI.B  #$031A,A2
        MOVE.L  A5,-(A1)                        ; $023130
        MOVE.W  A4,$30(A1,D1.W)                 ; $023132
        MOVEA.B $00(A4,A6.W),A3                 ; $023136
        MOVE.B  D5,D3                           ; $02313A
        DC.W    $0028,$054F,$054F   ; $02313C ORI.B  #$054F,$054F(A0)
        DC.W    $054F               ; $023142 BCHG    D2,A7
        MOVE.W  $46(A4,D6.L),$000A(PC)          ; $023144
        BTST    D0,(A2)+                        ; $02314A
        MOVE.L  A5,-(A0)                        ; $02314C
        MOVE.W  A4,$28(A0,D0.W)                 ; $02314E
        DC.W    $054F               ; $023152 BCHG    D2,A7
        DC.W    $054F               ; $023154 BCHG    D2,A7
        DC.W    $054F               ; $023156 BCHG    D2,A7
        MOVE.W  $46(A4,D6.L),$000A(PC)          ; $023158
        DC.W    $021A,$220D         ; $02315E ANDI.B  #$220D,(A2)+
        MOVE.W  A4,(A1)                         ; $023162
        SUBQ.W  #1,-(A7)                        ; $023164
        DC.W    $313D               ; $023166 MOVE.W  <EA:3D>,-(A0)
        DC.W    $000A,$309C         ; $023168 ORI.B  #$309C,A2
        OR.L   D0,-(A6)                         ; $02316C
        DC.W    $323D               ; $02316E MOVE.W  <EA:3D>,D1
        DC.W    $000A,$30CC         ; $023170 ORI.B  #$30CC,A2
        DC.W    $000B,$81A7         ; $023174 ORI.B  #$81A7,A3
        DC.W    $2FE6               ; $023178 MOVE.L  -(A6),<EA:3F>
        DC.W    $4F22               ; $02317A DC.W    $4F22
        BMI.S  loc_023153                       ; $02317C
        SPL     $5CE4(A3)                       ; $02317E
        BVS.S  loc_02314D                       ; $023182
        BVS.S  loc_023125                       ; $023184
        BGE.S  loc_023157                       ; $023186
        SLS     -(A6)                           ; $023188
        ADD.B  D6,D2                            ; $02318A
        ADD.B  D2,D6                            ; $02318C
        SGT     -(A7)                           ; $02318E
        DC.W    $4E0B               ; $023190 DC.W    $4E0B
        BRA.S  loc_023169                       ; $023192
        CMP.B  A2,D0                            ; $023194
        DC.W    $0028,$4B10,$8FF9   ; $023196 ORI.B  #$4B10,-$7007(A0)
        MOVEQ   #$10,D5                         ; $02319C
        DC.W    $4F26               ; $02319E DC.W    $4F26
        DC.W    $000B,$6EF6         ; $0231A0 ORI.B  #$6EF6,A3
        AND.B  D0,D0                            ; $0231A4
        BCHG    D3,D0                           ; $0231A6
        AND.B  D0,D0                            ; $0231A8
        BCHG    D3,$4F(A0,D0.W)                 ; $0231AA
        DC.W    $054F               ; $0231AE BCHG    D2,A7
        DC.W    $054F               ; $0231B0 BCHG    D2,A7
        MOVE.W  $46(A4,D6.L),$000A(PC)          ; $0231B2
        BTST    D0,(A2)+                        ; $0231B8
        MOVE.L  A5,-(A0)                        ; $0231BA
        MOVE.W  A4,$28(A0,D0.W)                 ; $0231BC
        DC.W    $054F               ; $0231C0 BCHG    D2,A7
        DC.W    $054F               ; $0231C2 BCHG    D2,A7
        DC.W    $054F               ; $0231C4 BCHG    D2,A7
        MOVE.W  $46(A4,D6.L),$74E0(PC)          ; $0231C6
        DC.W    $000A,$021A         ; $0231CC ORI.B  #$021A,A2
        MOVE.L  A5,D1                           ; $0231D0
        MOVE.W  A4,(A1)                         ; $0231D2
        DC.W    $313D               ; $0231D4 MOVE.W  <EA:3D>,-(A0)
        DC.W    $000A,$309C         ; $0231D6 ORI.B  #$309C,A2
        OR.L   D0,-(A6)                         ; $0231DA
        DC.W    $323D               ; $0231DC MOVE.W  <EA:3D>,D1
        DC.W    $000A,$30CC         ; $0231DE ORI.B  #$30CC,A2
        DC.W    $000B,$81A7         ; $0231E2 ORI.B  #$81A7,A3
        DIVS    -(A1),D2                        ; $0231E6
        OR.L   D0,-$3D(A1,D5.W)                 ; $0231E8
        SF      D7                              ; $0231EC
        DBHI    D3,$0285BF                      ; $0231EE
        MOVE.B  D1,-(A5)                        ; $0231F2
        MOVE.B  (A2),-(A5)                      ; $0231F4
        MOVE.B  -(A3),-(A5)                     ; $0231F6
        MOVE.B  $14(A4,D7.L),-(A5)              ; $0231F8
        DIVS    -(A3),D2                        ; $0231FC
        MOVEQ   #$01,D0                         ; $0231FE
        DC.W    $000B,$81E3         ; $023200 ORI.B  #$81E3,A3
        DIVS    -(A1),D2                        ; $023204
        OR.L   D0,-$3D(A1,D5.W)                 ; $023206
        SF      D7                              ; $02320A
        DBHI    D3,$024D0F                      ; $02320C
        MOVE.B  (A2),-(A5)                      ; $023210
        MOVE.B  -(A3),-(A5)                     ; $023212
        MOVE.W  (A0),-(A5)                      ; $023214
        DIVS    -(A3),D2                        ; $023216
        MOVEQ   #$01,D0                         ; $023218
        DC.W    $000B,$81E3         ; $02321A ORI.B  #$81E3,A3
        DC.W    $0009,$4F22         ; $02321E ORI.B  #$4F22,A1
        DIVS    -(A7),D2                        ; $023222
        OR.B   D0,D4                            ; $023224
        OR.B   D6,(A2)+                         ; $023226
        BCC.S  loc_02322D                       ; $023228
        DIVS    -(A1),D2                        ; $02322A
        NEGX.B (A0)+                            ; $02322C
        DC.W    $4008               ; $02322E NEGX.B A0
        DC.W    $4008               ; $023230 NEGX.B A0
        BSR.S  loc_023237                       ; $023232
        DIVS    -(A3),D2                        ; $023234
        NEGX.B (A0)+                            ; $023236
        DC.W    $4008               ; $023238 NEGX.B A0
        DC.W    $4008               ; $02323A NEGX.B A0
        BLS.S  loc_023241                       ; $02323C
        ADD.B  D2,A3                            ; $02323E
        ASR.B  #1,D0                            ; $023240
        ADD.B  A3,D0                            ; $023242
        MOVE.W  A0,-(A0)                        ; $023244
        MOVE.W  A4,-(A1)                        ; $023246
        MOVE.B  (A0),-(A2)                      ; $023248
        MOVE.B  -(A1),-(A2)                     ; $02324A
        MOVE.B  $43(A2,D6.W),-(A2)              ; $02324C
        DC.W    $2FE6               ; $023250 MOVE.L  -(A6),<EA:3F>
loc_023252:
        MOVE.L  $07(A6,A5.L),-$4FF1(A7)         ; $023252
        DIVS    -(A1),D0                        ; $023258
        BEQ.S  loc_023252                       ; $02325A
        BGT.S  loc_023254                       ; $02325C
        DC.W    $4710               ; $02325E DC.W    $4710
        DIVS    (A7)+,D7                        ; $023260
        MOVEQ   #$3C,D7                         ; $023262
        DC.W    $4F26               ; $023264 DC.W    $4F26
        DC.W    $000B,$0009         ; $023266 ORI.B  #$0009,A3
        DC.W    $0000,$C000         ; $02326A ORI.B  #$C000,D0
        BCHG    D3,$10(A0,D0.W)                 ; $02326E
        DC.W    $0000,$C000         ; $023272 ORI.B  #$C000,D0
        BTST    D3,D0                           ; $023276
        DC.W    $4F22               ; $023278 DC.W    $4F22
        SGE     -(A4)                           ; $02327A
        BVS.S  loc_023247                       ; $02327C
        BVS.S  loc_02321F                       ; $02327E
        BGE.S  loc_023251                       ; $023280
        SLS     -(A6)                           ; $023282
        ADD.B  (A0),D2                          ; $023284
        ADD.B  D2,(A1)                          ; $023286
        SPL     -$4071(A0)                      ; $023288
        DC.W    $0028,$7A10,$D00F   ; $02328C ORI.B  #$7A10,-$2FF1(A0)
        SUBQ.W  #8,(A0)                         ; $023292
        MOVE.W  A4,-(A0)                        ; $023294
        MOVE.B  (A0),-(A2)                      ; $023296
        EOR.L  D7,A0                            ; $023298
        DC.W    $0028,$7A10,$D00C   ; $02329A ORI.B  #$7A10,-$2FF4(A0)
        SUBQ.W  #8,(A2)                         ; $0232A0
        MOVE.W  A0,-(A0)                        ; $0232A2
        MOVE.B  (A2),-(A2)                      ; $0232A4
        EOR.L  D7,D1                            ; $0232A6
        DC.W    $0028,$7A10,$D008   ; $0232A8 ORI.B  #$7A10,-$2FF8(A0)
        SUBQ.W  #8,(A0)                         ; $0232AE
        MOVE.W  A0,-(A0)                        ; $0232B0
        MOVE.B  (A0),-(A2)                      ; $0232B2
        EOR.W  D7,$0028(PC)                     ; $0232B4
        SGE     $5BE9(A0)                       ; $0232B8
        EOR.L  D7,(A3)                          ; $0232BC
        DC.W    $0009,$4F26         ; $0232BE ORI.B  #$4F26,A1
        DC.W    $000B,$1EB9         ; $0232C2 ORI.B  #$1EB9,A3
        DC.W    $0000,$C000         ; $0232C6 ORI.B  #$C000,D0
        BCHG    D3,D0                           ; $0232CA
        AND.B  D0,D0                            ; $0232CC
        BCHG    D3,$20(A0,D0.W)                 ; $0232CE
        DC.W    $0000,$DE0D         ; $0232D2 ORI.B  #$DE0D,D0
        AND.B  D3,A7                            ; $0232D6
        LSL.B  #3,D6                            ; $0232D8
        BLT.S  loc_0232BF                       ; $0232DA
        MOVE.W  A4,-(A6)                        ; $0232DC
        BSR.S  loc_0232E6                       ; $0232DE
        MOVE.L  (A2),-(A6)                      ; $0232E0
        DC.W    $4710               ; $0232E2 DC.W    $4710
        DIVS    $04(PC,D7.L),D7                 ; $0232E4
        ADD.B  A1,D0                            ; $0232E8
        SF      $210B(A1)                       ; $0232EA
        LSR.B  #8,D0                            ; $0232EE
        SUB.B  D3,A3                            ; $0232F0
        OR.B   D0,(A6)+                         ; $0232F2
        MOVE.W  D0,-$7EE2(A0)                   ; $0232F4
        MOVE.W  D0,-$7EE2(A0)                   ; $0232F8
        MOVE.W  D0,-$7EE2(A0)                   ; $0232FC
        DC.W    $4710               ; $023300 DC.W    $4710
        DIVS    $40(A6,D7.W),D7                 ; $023302
        DC.W    $000B,$0009         ; $023306 ORI.B  #$0009,A3
        ORI.W  #$C000,D0                        ; $02330A
        BTST    D3,D0                           ; $02330E
        MOVE.L  D0,D0                           ; $023310
        DC.W    $0000,$0000         ; $023312 ORI.B  #$0000,D0
        ORI.L  #$00000070,-(A0)                 ; $023316
        DC.W    $0000,$0010         ; $02331C ORI.B  #$0010,D0
        DC.W    $0000,$00CF         ; $023320 ORI.B  #$00CF,D0
        DC.W    $0000,$0000         ; $023324 ORI.B  #$0000,D0
        DC.W    $0000,$013F         ; $023328 ORI.B  #$013F,D0
        ADDI.B  #$8000,D1                       ; $02332C
        ADD.B  D4,D1                            ; $023330
        ASL.B  #3,D6                            ; $023332
loc_023334:
        BRA.S  loc_02334C                       ; $023334
        MOVE.L  D2,D1                           ; $023336
        DC.W    $4710               ; $023338 DC.W    $4710
        DIVS    $04(PC,D7.W),D7                 ; $02333A
        DC.W    $000B,$0009         ; $02333E ORI.B  #$0009,A3
        DC.W    $0000,$C000         ; $023342 ORI.B  #$C000,D0
        DC.W    $070C               ; $023346 BTST    D3,A4
        ADD.B  D0,D5                            ; $023348
        ADD.B  D6,D0                            ; $02334A
loc_02334C:
        SUB.B  D3,D6                            ; $02334C
        BHI.S  loc_023356                       ; $02334E
        MOVE.L  -(A2),-(A0)                     ; $023350
        DC.W    $4710               ; $023352 DC.W    $4710
        DIVS    $04(PC,D7.W),D7                 ; $023354
        DC.W    $000B,$0009         ; $023358 ORI.B  #$0009,A3
        BCLR    D0,(A2)                         ; $02335C
        DC.W    $0000,$C000         ; $02335E ORI.B  #$C000,D0
        DC.W    $0000,$0600         ; $023362 ORI.B  #$0600,D0
        MOVE.W  $51E7(A0),$52E8(A1)             ; $023366
        DC.W    $4128               ; $02336C DC.W    $4128
        CLR.B  $50E5(A0)                        ; $02336E
        BLS.S  loc_023387                       ; $023372
        BCC.S  loc_023399                       ; $023374
        MOVE.L  A3,-(A0)                        ; $023376
        MOVE.L  A3,D1                           ; $023378
        MOVE.B  (A2)+,D7                        ; $02337A
        MOVE.B  $50E6(A3),D7                    ; $02337C
        MOVE.L  A3,-(A1)                        ; $023380
        MOVE.L  A3,D2                           ; $023382
        MOVE.B  #$000B,D7                       ; $023384
        MOVEA.B A5,A7                           ; $023388
        DC.W    $4F22               ; $02338A DC.W    $4F22
        CMPA.L  $0009(A4),A7                    ; $02338C
        BRA.S  loc_023334                       ; $023390
        OR.B   D0,D4                            ; $023392
        OR.B   D5,D6                            ; $023394
        MOVEQ   #-$04,D5                        ; $023396
        DC.W    $4710               ; $023398 DC.W    $4710
        DIVS    $7BC04F26,D7                    ; $02339A
        DC.W    $000B,$0009         ; $0233A0 ORI.B  #$0009,A3
        ASL.B  #8,D0                            ; $0233A4
        MOVE.L  (A2),D5                         ; $0233A6
        MOVEQ   #-$04,D5                        ; $0233A8
        NEGX.B D1                               ; $0233AA
        MOVE.B  D2,D7                           ; $0233AC
        MOVE.L  -(A6),$2F76(A7)                 ; $0233AE
        MOVE.L  -(A6),-$01(A7,A4.L)             ; $0233B2
        OR.B   D0,D4                            ; $0233B6
        OR.B   D4,D1                            ; $0233B8
        CMP.W  $22(A1,D4.L),D0                  ; $0233BA
        DC.W    $7BF0,$84EA         ; $0233BE MOVE.W  -$16(A0,A0.W),<EA:3D>
        OR.B   D0,D4                            ; $0233C2
        OR.B   D4,D1                            ; $0233C4
        CMP.W  $4F22(A3),D0                     ; $0233C6
        DC.W    $7BF0,$84E9         ; $0233CA MOVE.W  -$17(A0,A0.W),<EA:3D>
        OR.B   D0,D4                            ; $0233CE
        OR.B   D4,D1                            ; $0233D0
        CMP.W  -(A5),D0                         ; $0233D2
        DC.W    $4F22               ; $0233D4 DC.W    $4F22
        DC.W    $7BF0,$84E8         ; $0233D6 MOVE.W  -$18(A0,A0.W),<EA:3D>
loc_0233DA:
        OR.B   D0,D4                            ; $0233DA
loc_0233DC:
        OR.B   D4,D1                            ; $0233DC
loc_0233DE:
        CMP.W  (A7)+,D0                         ; $0233DE
        DC.W    $4F22               ; $0233E0 DC.W    $4F22
        BPL.S  loc_0233DA                       ; $0233E2
        BEQ.S  loc_0233DC                       ; $0233E4
        BNE.S  loc_0233DE                       ; $0233E6
        DC.W    $4710               ; $0233E8 DC.W    $4710
        DIVS    (A1),D7                         ; $0233EA
        DC.W    $7BF0,$AFD6         ; $0233EC MOVE.W  -$2A(A0,A2.L),<EA:3D>
        DC.W    $0009,$4F22         ; $0233F0 ORI.B  #$4F22,A1
        EOR.L  D7,$0009.W                       ; $0233F4
        BRA.S  loc_02339C                       ; $0233F8
        ADD.B  D0,D5                            ; $0233FA
        MOVE.L  (A0)+,D0                        ; $0233FC
        OR.B   D5,A1                            ; $0233FE
        MOVEQ   #-$04,D5                        ; $023400
        DC.W    $4710               ; $023402 DC.W    $4710
        DIVS    $7BC0.W,D7                      ; $023404
        DC.W    $4F26               ; $023408 DC.W    $4F26
        DC.W    $000B,$0009         ; $02340A ORI.B  #$0009,A3
        DC.W    $0000,$FF00         ; $02340E ORI.B  #$FF00,D0
        MOVE.W  D0,-(A7)                        ; $023412
        ADD.B  D0,A5                            ; $023414
        MOVE.L  A1,-(A0)                        ; $023416
        MOVE.L  (A2),D5                         ; $023418
        MOVEQ   #-$04,D5                        ; $02341A
        NEGX.B D1                               ; $02341C
        MOVE.B  D2,D7                           ; $02341E
        MOVE.L  -(A6),$2F76(A7)                 ; $023420
        MOVE.L  -(A6),-$16(A7,A0.W)             ; $023424
        OR.B   D0,D4                            ; $023428
        OR.B   D4,D1                            ; $02342A
        CMP.B  $4F22.W,D0                       ; $02342C
        DC.W    $7BE0               ; $023430 MOVE.W  -(A0),<EA:3D>
        DIVU    -$7800(A0),D2                   ; $023432
loc_023436:
        OR.B   D4,D1                            ; $023436
loc_023438:
        CMP.B  $22(A2,D4.L),D0                  ; $023438
        BPL.S  loc_023434                       ; $02343C
        BEQ.S  loc_023436                       ; $02343E
        BNE.S  loc_023438                       ; $023440
        DC.W    $4710               ; $023442 DC.W    $4710
        DIVS    (A0)+,D7                        ; $023444
        DC.W    $7BE0               ; $023446 MOVE.W  -(A0),<EA:3D>
        DC.W    $AFDE               ; $023448 MOVE.L  (A6)+,<EA:3F>
        DC.W    $0009,$00FF         ; $02344A ORI.B  #$00FF,A1
        DC.W    $00FF               ; $02344E DC.W    $00FF
        DC.W    $4F22               ; $023450 DC.W    $4F22
        EOR.L  D7,A1                            ; $023452
        DC.W    $0009,$60A2         ; $023454 ORI.B  #$60A2,A1
        OR.B   D0,D4                            ; $023458
        OR.B   D5,D6                            ; $02345A
        MOVEQ   #-$04,D5                        ; $02345C
        DC.W    $4710               ; $02345E DC.W    $4710
        DIVS    $7BC04F26,D7                    ; $023460
        DC.W    $000B,$0009         ; $023466 ORI.B  #$0009,A3
        ASL.B  #8,D0                            ; $02346A
        MOVE.L  (A2),D5                         ; $02346C
        MOVEQ   #-$04,D5                        ; $02346E
        NEGX.B D1                               ; $023470
        MOVE.B  D2,D7                           ; $023472
        MOVE.L  -(A6),$2F76(A7)                 ; $023474
        MOVE.L  -(A6),-$15(A7,A0.W)             ; $023478
        OR.B   D0,D4                            ; $02347C
        OR.B   D4,D1                            ; $02347E
        CMP.B  A6,D0                            ; $023480
        DC.W    $4F22               ; $023482 DC.W    $4F22
        DC.W    $7BE0               ; $023484 MOVE.W  -(A0),<EA:3D>
        DIVU    -$7800(A1),D2                   ; $023486
loc_02348A:
        OR.B   D4,D1                            ; $02348A
loc_02348C:
        CMP.B  A0,D0                            ; $02348C
        DC.W    $4F22               ; $02348E DC.W    $4F22
        BPL.S  loc_023488                       ; $023490
        BEQ.S  loc_02348A                       ; $023492
        BNE.S  loc_02348C                       ; $023494
        DC.W    $4710               ; $023496 DC.W    $4710
        DIVS    (A5)+,D7                        ; $023498
        DC.W    $7BE0               ; $02349A MOVE.W  -(A0),<EA:3D>
        DC.W    $AFE2               ; $02349C MOVE.L  -(A2),<EA:3F>
        DC.W    $0009,$2FB6         ; $02349E ORI.B  #$2FB6,A1
        BSR.S  loc_023459                       ; $0234A2
        ADD.B  D7,D4                            ; $0234A4
        BSR.S  loc_0234C5                       ; $0234A6
        MOVE.W  (A4)+,D4                        ; $0234A8
loc_0234AA:
        MOVE.L  $06(A6,D2.L),$2C(A7,A3.W)       ; $0234AA
        DC.W    $4F22               ; $0234B0 DC.W    $4F22
        BRA.S  loc_0234AA                       ; $0234B2
        BMI.S  loc_0234AC                       ; $0234B4
        NEGX.B (A0)                             ; $0234B6
        DIVS    -$0A(A3,D6.L),D5                ; $0234B8
        DC.W    $4F26               ; $0234BC DC.W    $4F26
        DC.W    $000B,$0009         ; $0234BE ORI.B  #$0009,A3
        DC.W    $0000,$0601         ; $0234C2 ORI.B  #$0601,D0
        DC.W    $0000,$4F22         ; $0234C6 ORI.B  #$4F22,D0
        EOR.W  D7,A5                            ; $0234CA
        DC.W    $0009,$2F76         ; $0234CC ORI.B  #$2F76,A1
loc_0234D0:
        MOVE.L  D6,$1A(A7,A3.W)                 ; $0234D0
        DC.W    $4F22               ; $0234D4 DC.W    $4F22
        BVC.S  loc_0234CE                       ; $0234D6
        BEQ.S  loc_0234D0                       ; $0234D8
        OR.L   D2,D1                            ; $0234DA
        AND.B  D1,D4                            ; $0234DC
        OR.B   D7,D1                            ; $0234DE
        MOVEQ   #$10,D4                         ; $0234E0
        MOVEQ   #$04,D4                         ; $0234E2
        DC.W    $4710               ; $0234E4 DC.W    $4710
        DIVS    $26(A2,D4.L),D5                 ; $0234E6
        DC.W    $000B,$0009         ; $0234EA ORI.B  #$0009,A3
        ADD.B  D5,D0                            ; $0234EE
        SF      $210B(A1)                       ; $0234F0
        OR.B   D2,(A6)+                         ; $0234F4
        AND.B  A0,D4                            ; $0234F6
        DIVS    #$51E9,D4                       ; $0234F8
        ASR.B  #8,D6                            ; $0234FC
        DC.W    $000B,$811E         ; $0234FE ORI.B  #$811E,A3
        DC.W    $0000,$2000         ; $023502 ORI.B  #$2000,D0
        DC.W    $0000,$4F22         ; $023506 ORI.B  #$4F22,D0
        ADD.B  (A2),D7                          ; $02350A
        ADD.B  D4,(A2)                          ; $02350C
        CMP.W  $02(A2,D7.L),D0                  ; $02350E
        CMP.L  (A7),D0                          ; $023512
        DC.W    $0009,$53E7         ; $023514 ORI.B  #$53E7,A1
        SCC     $3317(A0)                       ; $023518
        OR.B   D4,#$3247                        ; $02351C
        OR.B   D4,-$4F4F(PC)                    ; $023520
        DC.W    $0009,$53E5         ; $023524 ORI.B  #$53E5,A1
        SCC     -(A6)                           ; $023528
        MOVE.W  (A7),-(A1)                      ; $02352A
        OR.B   D4,(A0)+                         ; $02352C
        MOVEA.W D7,A1                           ; $02352E
        OR.B   D4,(A6)                          ; $023530
        MOVE.W  (A0),D1                         ; $023532
        OR.W   D4,(A4)+                         ; $023534
        SNE     -$2CF8(A1)                      ; $023536
        MOVE.L  -$7AC2(A3),-$37F8(A1)           ; $02353A
        DIVS    #$6963,D4                       ; $023540
        CMPA.W  A1,A0                           ; $023544
        ASR.B  #6,D4                            ; $023546
        BVS.S  loc_0235AD                       ; $023548
        MOVE.W  -(A0),-(A4)                     ; $02354A
        CMPA.W  D5,A0                           ; $02354C
        ROXR.W  #$A223                          ; $02354E
        DC.W    $4F26               ; $023552 DC.W    $4F26
        AND.B  D0,D0                            ; $023554
        BTST    D3,D0                           ; $023556
        AND.B  D0,D0                            ; $023558
        BCHG    D3,D0                           ; $02355A
        MOVE.L  D0,D0                           ; $02355C
        DC.W    $0000,$3237         ; $02355E ORI.B  #$3237,D0
        OR.W   D5,D5                            ; $023562
        MOVE.W  D7,-$76BD(A0)                   ; $023564
        MOVE.W  (A0),D1                         ; $023568
        OR.W   D4,D1                            ; $02356A
        SNE     -$2CF7(A1)                      ; $02356C
        MOVE.L  -$7AC2(A3),-$37F8(A1)           ; $023570
        DIVS    #$2F66,D4                       ; $023576
        BVS.S  loc_0235DF                       ; $02357A
        DC.W    $B0BD               ; $02357C CMP.L  <EA:3D>,D0
        ASR.B  #6,D4                            ; $02357E
        BNE.S  loc_023578                       ; $023580
        MOVE.L  -(A6),$6963(A7)                 ; $023582
        MOVE.W  -(A0),-(A4)                     ; $023586
        CMP.L  -$04(A7,A6.L),D0                 ; $023588
        BNE.S  loc_023584                       ; $02358C
        MOVE.L  D4,D1                           ; $02358E
        DC.W    $4F26               ; $023590 DC.W    $4F26
        DC.W    $0000,$2000         ; $023592 ORI.B  #$2000,D0
        DC.W    $0000,$B076         ; $023596 ORI.B  #$B076,D0
        DC.W    $0009,$53E5         ; $02359A ORI.B  #$53E5,A1
        SCC     -(A6)                           ; $02359E
        MOVE.W  $25(A7,A0.L),D1                 ; $0235A0
        MOVE.W  D7,-$76DD(A0)                   ; $0235A4
        MOVE.W  (A0),D1                         ; $0235A8
        OR.B   D4,-(A1)                         ; $0235AA
        ADD.B  D4,A4                            ; $0235AC
        CMP.L  -(A4),D0                         ; $0235AE
        ASR.B  #6,D4                            ; $0235B0
        ADD.B  D4,A4                            ; $0235B2
        CMP.L  -(A1),D0                         ; $0235B4
        ROXR.W  #$D809                          ; $0235B6
        ADD.B  D4,A3                            ; $0235BA
        EOR.B  D0,A4                            ; $0235BC
        DC.W    $4F22               ; $0235BE DC.W    $4F22
        TST.B  $4A08(A0)                        ; $0235C0
        DC.W    $4B08               ; $0235C4 DC.W    $4B08
        MOVE.L  $1EB1(A3),$06(A5,A5.L)          ; $0235C6
        ADD.B  D4,D7                            ; $0235CC
        EOR.B  D0,D3                            ; $0235CE
        DC.W    $4F22               ; $0235D0 DC.W    $4F22
        TST.B  $2BAB(A0)                        ; $0235D2
        SPL     -(A1)                           ; $0235D6
        MOVE.L  $1EB1(A3),$3F(A5,A2.W)          ; $0235D8
        DC.W    $4F26               ; $0235DE DC.W    $4F26
        AND.B  D0,D0                            ; $0235E0
        BCLR    D3,D0                           ; $0235E2
        AND.B  D0,D0                            ; $0235E4
        BCLR    D3,-(A0)                        ; $0235E6
        AND.B  D0,D0                            ; $0235E8
        BSET    D3,D0                           ; $0235EA
        AND.B  D0,D0                            ; $0235EC
        BSET    D3,-(A0)                        ; $0235EE
        DC.W    $4F26               ; $0235F0 DC.W    $4F26
        DC.W    $000B,$0009         ; $0235F2 ORI.B  #$0009,A3
        SF      -(A3)                           ; $0235F6
        SHI     -(A4)                           ; $0235F8
        BRA.S  loc_023581                       ; $0235FA
        DIVS    -(A0),D0                        ; $0235FC
        BRA.S  loc_023585                       ; $0235FE
        BCC.S  loc_023587                       ; $023600
        MOVE.W  (A4)+,D0                        ; $023602
        OR.L   D0,(A0)                          ; $023604
        MOVE.W  $604B(A0),D2                    ; $023606
        OR.L   D0,(A1)                          ; $02360A
        BRA.S  loc_023593                       ; $02360C
        BCC.S  loc_023595                       ; $02360E
        MOVE.W  (A4)+,D0                        ; $023610
        OR.L   D0,(A2)                          ; $023612
        MOVE.W  $604B(A0),D2                    ; $023614
        OR.L   D0,(A3)                          ; $023618
        BRA.S  loc_0235A1                       ; $02361A
        BCC.S  loc_0235A3                       ; $02361C
        MOVE.W  (A4)+,D0                        ; $02361E
        OR.L   D0,(A4)                          ; $023620
        MOVE.W  $604B(A0),D2                    ; $023622
        OR.L   D0,(A5)                          ; $023626
        DIVS    -(A0),D2                        ; $023628
        AND.B  D1,D4                            ; $02362A
        OR.B   D4,D2                            ; $02362C
        ADDQ.L  #8,(A2)                         ; $02362E
        DC.W    $000B,$1903         ; $023630 ORI.B  #$1903,A3
        BRA.S  loc_0235BB                       ; $023634
        BCC.S  loc_0235BD                       ; $023636
        MOVE.W  (A4)+,D0                        ; $023638
        OR.L   D0,(A6)                          ; $02363A
        MOVE.W  $604B(A0),D2                    ; $02363C
        DC.W    $000B,$8197         ; $023640 ORI.B  #$8197,A3
        ADD.B  D4,D4                            ; $023644
        OR.L   D2,D0                            ; $023646
        BSR.S  loc_02364D                       ; $023648
        BHI.S  loc_02364F                       ; $02364A
        OR.L   D2,D2                            ; $02364C
        MOVE.W  (A3),D0                         ; $02364E
        OR.B   D4,D4                            ; $023650
        MOVE.L  D6,D0                           ; $023652
        BSR.S  loc_023659                       ; $023654
        DC.W    $0000,$C000         ; $023656 ORI.B  #$C000,D0
        BCHG    D3,D0                           ; $02365A
        MOVE.W  D3,D1                           ; $02365C
        OR.B   D4,D0                            ; $02365E
        BHI.S  loc_023665                       ; $023660
        OR.L   D2,D4                            ; $023662
        MOVE.W  (A3),D0                         ; $023664
        OR.B   D4,D1                            ; $023666
        MOVE.L  D3,D0                           ; $023668
        BSR.S  loc_02366F                       ; $02366A
        MOVE.W  D3,D1                           ; $02366C
        OR.B   D4,D0                            ; $02366E
        BHI.S  loc_023675                       ; $023670
        OR.L   D2,D6                            ; $023672
        MOVE.W  (A3),D0                         ; $023674
        OR.B   D4,D1                            ; $023676
        DC.W    $000B,$6103         ; $023678 ORI.B  #$6103,A3
        MOVE.W  D3,D1                           ; $02367C
        OR.B   D4,D1                            ; $02367E
        DC.W    $000B,$6203         ; $023680 ORI.B  #$6203,A3
        DC.W    $000B,$0009         ; $023684 ORI.B  #$0009,A3
        ADD.B  D5,D4                            ; $023688
        OR.L   D2,D0                            ; $02368A
        ASR.B  #5,D0                            ; $02368C
        ASL.B  #5,D0                            ; $02368E
        BSR.S  loc_023695                       ; $023690
        BHI.S  loc_023697                       ; $023692
        OR.L   D2,D2                            ; $023694
        MOVE.W  (A3),D0                         ; $023696
        OR.B   D4,D4                            ; $023698
        ASR.B  #5,D4                            ; $02369A
        MOVE.L  D6,D0                           ; $02369C
        BSR.S  loc_0236A3                       ; $02369E
        AND.B  D0,D0                            ; $0236A0
        BCHG    D3,D2                           ; $0236A2
        MOVE.W  D3,D1                           ; $0236A4
        OR.B   D4,D1                            ; $0236A6
        ASL.B  #5,D4                            ; $0236A8
        BHI.S  loc_0236AF                       ; $0236AA
        OR.L   D2,D4                            ; $0236AC
        MOVE.W  (A3),D0                         ; $0236AE
        OR.B   D4,D2                            ; $0236B0
        LSR.B  #5,D0                            ; $0236B2
        MOVE.L  D4,D0                           ; $0236B4
        BSR.S  loc_0236BB                       ; $0236B6
        MOVE.W  D3,D1                           ; $0236B8
        OR.B   D4,D1                            ; $0236BA
        LSL.B  #5,D0                            ; $0236BC
        BHI.S  loc_0236C3                       ; $0236BE
        OR.L   D2,D6                            ; $0236C0
        MOVE.W  (A3),D0                         ; $0236C2
        OR.B   D4,D2                            ; $0236C4
        LSR.B  #5,D4                            ; $0236C6
        DC.W    $000B,$6103         ; $0236C8 ORI.B  #$6103,A3
        MOVE.W  D3,D1                           ; $0236CC
        OR.B   D4,D2                            ; $0236CE
        LSL.B  #5,D4                            ; $0236D0
        DC.W    $000B,$6203         ; $0236D2 ORI.B  #$6203,A3
        DC.W    $000B,$0009         ; $0236D6 ORI.B  #$0009,A3
        ADD.B  D5,D4                            ; $0236DA
        BRA.S  loc_023681                       ; $0236DC
        DC.W    $018E               ; $0236DE BCLR    D0,A6
        MOVE.L  (A2),-(A4)                      ; $0236E0
        MOVE.W  $06(A0,A0.L),(A0)               ; $0236E2
        MOVE.W  D4,-(A4)                        ; $0236E6
        MOVE.W  A4,(A0)+                        ; $0236E8
        DC.W    $AFF8,$C90C         ; $0236EA MOVE.L  $C90C.W,<EA:3F>
        DC.W    $0000,$C000         ; $0236EE ORI.B  #$C000,D0
        BCHG    D3,D0                           ; $0236F2
        DC.W    $E0FF               ; $0236F4 ASR.W  <EA:3F>
        DC.W    $000B,$2902         ; $0236F6 ORI.B  #$2902,A3
        ADD.B  A3,D4                            ; $0236FA
        BRA.S  loc_0236A1                       ; $0236FC
        SLS     -(A5)                           ; $0236FE
        DC.W    $018E               ; $023700 BCLR    D0,A6
        BCC.S  loc_023723                       ; $023702
        MOVE.W  $11(A3,A0.L),D2                 ; $023704
        BHI.S  loc_02371D                       ; $023708
        MOVE.W  A4,(A0)+                        ; $02370A
        AND.B  D4,A4                            ; $02370C
        DC.W    $018E               ; $02370E BCLR    D0,A6
        BCC.S  loc_023731                       ; $023710
        MOVE.W  -$08(A3,A0.L),D2                ; $023712
        DC.W    $4F22               ; $023716 DC.W    $4F22
        CMP.B  -(A1),D0                         ; $023718
        DC.W    $0009,$4F26         ; $02371A ORI.B  #$4F26,A1
        MOVE.L  $04(A2,D7.L),-(A4)              ; $02371E
        MOVE.L  A0,D0                           ; $023722
        SLS     -(A6)                           ; $023724
        DC.W    $0000,$C000         ; $023726 ORI.B  #$C000,D0
        BCHG    D3,D0                           ; $02372A
        MOVE.L  (A2),-(A4)                      ; $02372C
        MOVE.W  D4,-(A4)                        ; $02372E
        SLS     -(A6)                           ; $023730
        MOVE.W  A4,(A0)+                        ; $023732
        AND.B  D4,A4                            ; $023734
        BHI.S  loc_02374B                       ; $023736
        DC.W    $018E               ; $023738 BCLR    D0,A6
        BCC.S  loc_02375B                       ; $02373A
        MOVE.W  $05(A7,A0.L),D2                 ; $02373C
        MOVE.L  (A2),-(A4)                      ; $023740
        MOVE.W  D4,-(A4)                        ; $023742
        MOVE.W  $07(A0,A0.L),(A0)               ; $023744
        DC.W    $AFF4,$30CC         ; $023748 MOVE.L  -$34(A4,D3.W),<EA:3F>
        DC.W    $4F22               ; $02374C DC.W    $4F22
        CMP.B  D6,D0                            ; $02374E
        DC.W    $0009,$4F26         ; $023750 ORI.B  #$4F26,A1
        MOVE.L  $04(A2,D7.L),-(A4)              ; $023754
        DC.W    $E0FF               ; $023758 ASR.W  <EA:3F>
        DC.W    $000B,$2902         ; $02375A ORI.B  #$2902,A3
        BCC.S  loc_02377F                       ; $02375E
        BCS.S  loc_023791                       ; $023760
        MOVE.W  D3,-$76FE(A2)                   ; $023762
        BCC.S  loc_02377B                       ; $023766
loc_023768:
        BSR.S  loc_02378D                       ; $023768
        BHI.S  loc_0237AF                       ; $02376A
        BCC.S  loc_023787                       ; $02376C
        BCC.S  loc_0237BF                       ; $02376E
        BCS.S  loc_02379B                       ; $023770
        BCS.S  loc_0237D3                       ; $023772
        MOVEA.W (A0)+,A2                        ; $023774
        SUB.B  D3,(A0)+                         ; $023776
        BCS.S  loc_023799                       ; $023778
        BNE.S  loc_0237AB                       ; $02377A
        MOVE.W  $3757(A0),-$76EA(A2)            ; $02377C
        ADD.B  D3,A2                            ; $023782
        DC.W    $4500               ; $023784 DC.W    $4500
        MOVE.W  (A4)+,$6771(A3)                 ; $023786
loc_02378A:
        MOVE.L  A7,$651F(A3)                    ; $02378A
        BEQ.S  loc_0237CF                       ; $02378E
        SUBI.B  #$3758,(A2)+                    ; $023790
loc_023794:
        DC.W    $4728               ; $023794 DC.W    $4728
        NEG.B  A0                               ; $023796
        MOVE.W  A5,$633D(A3)                    ; $023798
        BCC.S  loc_0237B7                       ; $02379C
        DC.W    $070A               ; $02379E BTST    D3,A2
        BCC.S  loc_0237F1                       ; $0237A0
        MOVE.W  A4,$4728(A3)                    ; $0237A2
        DC.W    $000B,$237B         ; $0237A6 ORI.B  #$237B,A3
        MOVE.W  D1,-(A7)                        ; $0237AA
        ADDI.B  #$48D0,D0                       ; $0237AC
        BCS.S  loc_0237D1                       ; $0237B0
        BEQ.S  loc_0237F3                       ; $0237B2
        MOVE.W  (A0)+,$247F(A3)                 ; $0237B4
        SUB.B  D6,A4                            ; $0237B8
        BNE.S  loc_0237EB                       ; $0237BA
        MOVE.W  $071A(A0),$1D50(A2)             ; $0237BC
        MOVE.B  $3D(A1,D6.W),$6419(A6)          ; $0237C2
        BCC.S  loc_023819                       ; $0237C8
loc_0237CA:
        SEQ     (A7)                            ; $0237CA
        MOVE.W  A4,$4728(A3)                    ; $0237CC
        DC.W    $000B,$237B         ; $0237D0 ORI.B  #$237B,A3
        MOVE.W  D0,-(A7)                        ; $0237D4
        DC.W    $4F22               ; $0237D6 DC.W    $4F22
        CMP.B  -(A1),D0                         ; $0237D8
        BLS.S  loc_02375D                       ; $0237DA
        BPL.S  loc_0237E1                       ; $0237DC
        BGE.S  loc_0237E3                       ; $0237DE
        BLS.S  loc_023768                       ; $0237E0
        OR.B   D5,D1                            ; $0237E2
        MOVE.L  $04(A2,D7.L),-(A4)              ; $0237E4
        CMP.B  (A1)+,D0                         ; $0237E8
        BLS.S  loc_02376D                       ; $0237EA
        BMI.S  loc_0237F1                       ; $0237EC
        MOVE.L  A0,(A0)+                        ; $0237EE
        OR.B   D5,A4                            ; $0237F0
        MOVE.L  A3,(A0)+                        ; $0237F2
        AND.B  D6,D4                            ; $0237F4
        OR.B   D4,D6                            ; $0237F6
        CMP.B  (A4)+,D0                         ; $0237F8
        BRA.S  loc_0237BF                       ; $0237FA
        CMP.B  (A2)+,D0                         ; $0237FC
        BRA.S  loc_0237B3                       ; $0237FE
        BRA.S  loc_0237B5                       ; $023800
        AND.B  D6,D4                            ; $023802
        OR.B   D5,D2                            ; $023804
        BLS.S  loc_02378A                       ; $023806
        MOVE.L  $04(A2,D7.L),-(A4)              ; $023808
        MOVEQ   #$04,D4                         ; $02380C
        BGE.S  loc_0237C3                       ; $02380E
        BRA.S  loc_023794                       ; $023810
        DC.W    $88FF               ; $023812 DIVU    <EA:3F>,D4
        DIVS    -$1F01(A0),D5                   ; $023814
        DC.W    $4F26               ; $023818 DC.W    $4F26
        DC.W    $000B,$2902         ; $02381A ORI.B  #$2902,A3
        SF      -(A7)                           ; $02381E
        SHI     -$2000(A0)                      ; $023820
        MOVE.W  (A3),-(A1)                      ; $023824
        OR.B   D4,D0                            ; $023826
        AND.B  D5,D4                            ; $023828
        MOVE.W  $00(A3,A0.L),D1                 ; $02382A
        AND.B  D5,D2                            ; $02382E
        DC.W    $000B,$C806         ; $023830 ORI.B  #$C806,A3
        OR.B   D0,D4                            ; $023834
        OR.B   D5,D1                            ; $023836
        DC.W    $000B,$0009         ; $023838 ORI.B  #$0009,A3
        OR.B   D2,D4                            ; $02383C
        SLS     -$7700(A0)                      ; $02383E
        SLS     -(A7)                           ; $023842
        DC.W    $4F22               ; $023844 DC.W    $4F22
        BHI.S  loc_0237CA                       ; $023846
        BRA.S  loc_0237CD                       ; $023848
        MOVEQ   #-$04,D0                        ; $02384A
        BSR.S  loc_023850                       ; $02384C
        BHI.S  loc_023879                       ; $02384E
loc_023850:
        EOR.L  D7,D5                            ; $023850
        BSR.S  loc_02386D                       ; $023852
loc_023854:
        BLS.S  loc_02388F                       ; $023854
        MOVE.L  $26(A2,D4.L),-(A4)              ; $023856
        DC.W    $000B,$7904         ; $02385A ORI.B  #$7904,A3
        ADD.B  (A1),D4                          ; $02385E
        ADD.B  D4,(A1)                          ; $023860
        SNE     -$2EEF(A1)                      ; $023862
        MOVE.L  -$7AE2(A3),-$37F8(A0)           ; $023866
        DIVS    #$6A63,D4                       ; $02386C
        BMI.S  loc_0238D5                       ; $023870
        MOVE.W  -(A0),-(A5)                     ; $023872
        DIVS    -(A2),D2                        ; $023874
        OR.B   D0,D4                            ; $023876
        OR.B   D6,(A2)+                         ; $023878
loc_02387A:
        BLS.S  loc_02387F                       ; $02387A
        AND.B  D3,D2                            ; $02387C
        SF      $003D(A2)                       ; $02387E
        DC.W    $0023,$52EB         ; $023882 ORI.B  #$52EB,-(A3)
        DC.W    $0009,$002A         ; $023886 ORI.B  #$002A,A1
        ORI.W  #$0048,D2                        ; $02388A
        ORI.W  #$0052,A6                        ; $02388E
        ORI.W  #$007E,(A0)+                     ; $023892
        ORI.W  #$0088,A6                        ; $023896
        ORI.L  #$0058A007,A6                    ; $02389A
        DC.W    $0009,$0000         ; $0238A0 ORI.B  #$0000,A1
        AND.B  D0,D0                            ; $0238A4
        BSET    D3,D0                           ; $0238A6
        AND.B  D0,D0                            ; $0238A8
        BSET    D3,-(A0)                        ; $0238AA
        MOVE.L  D0,D0                           ; $0238AC
        DC.W    $0000,$6086         ; $0238AE ORI.B  #$6086,D0
        DC.W    $88FF               ; $0238B2 DIVU    <EA:3F>,D4
        OR.B   D4,D2                            ; $0238B4
        MOVE.L  D2,D5                           ; $0238B6
        DC.W    $AFFA,$7A04         ; $0238B8 MOVE.L  $7A04(PC),<EA:3F>
        BRA.S  loc_023854                       ; $0238BC
        DC.W    $88FF               ; $0238BE DIVU    <EA:3F>,D4
        OR.B   D4,$2B02(A5)                     ; $0238C0
        DC.W    $AFFA,$7B04         ; $0238C4 MOVE.L  $7B04(PC),<EA:3F>
        MOVE.L  -(A2),-(A5)                     ; $0238C8
        DC.W    $AFF1,$7B04         ; $0238CA MOVE.L  $04(A1,D7.L),<EA:3F>
        MOVE.L  (A2),-(A5)                      ; $0238CE
        DC.W    $AFEE,$7B04         ; $0238D0 MOVE.L  $7B04(A6),<EA:3F>
        DC.W    $000B,$0009         ; $0238D4 ORI.B  #$0009,A3
        MOVE.L  -(A2),D5                        ; $0238D8
        DC.W    $AFE9,$7A04         ; $0238DA MOVE.L  $7A04(A1),<EA:3F>
        DC.W    $E0FF               ; $0238DE ASR.W  <EA:3F>
        BLS.S  loc_023864                       ; $0238E0
        MOVE.W  D0,-(A1)                        ; $0238E2
        OR.B   D4,D6                            ; $0238E4
        BCC.S  loc_02387A                       ; $0238E6
        MOVE.W  D0,D2                           ; $0238E8
        OR.B   D4,D7                            ; $0238EA
        BLS.S  loc_02392D                       ; $0238EC
        BCC.S  loc_02393F                       ; $0238EE
        MOVE.W  $03(A7,A0.L),D2                 ; $0238F0
        BRA.S  loc_023888                       ; $0238F4
        MOVE.L  D2,D5                           ; $0238F6
        DC.W    $AFDA               ; $0238F8 MOVE.L  (A2)+,<EA:3F>
        MOVEQ   #$04,D5                         ; $0238FA
        BRA.S  loc_023880                       ; $0238FC
        MOVE.L  D2,-(A5)                        ; $0238FE
        DC.W    $AFD6               ; $023900 MOVE.L  (A6),<EA:3F>
        MOVE.W  D4,-(A5)                        ; $023902
        MOVE.L  -(A2),D5                        ; $023904
        MOVEQ   #$04,D5                         ; $023906
        MOVE.L  (A2),-(A5)                      ; $023908
        DC.W    $AFD1               ; $02390A MOVE.L  (A1),<EA:3F>
        MOVE.W  D4,-(A5)                        ; $02390C
        MOVE.L  (A2),D5                         ; $02390E
        DC.W    $AFCE               ; $023910 MOVE.L  A6,<EA:3F>
        MOVEQ   #$04,D5                         ; $023912
        MOVE.L  (A2),D5                         ; $023914
        MOVEQ   #$04,D5                         ; $023916
        MOVE.L  -(A2),-(A5)                     ; $023918
        DC.W    $AFC9               ; $02391A MOVE.L  A1,<EA:3F>
        MOVE.W  D4,-(A5)                        ; $02391C
        DIVS    -(A3),D2                        ; $02391E
        OR.B   D0,D4                            ; $023920
loc_023922:
        OR.B   D6,(A0)                          ; $023922
        BLS.S  loc_023929                       ; $023924
        AND.B  D3,D2                            ; $023926
        SF      $003D(A4)                       ; $023928
        DC.W    $0023,$52ED         ; $02392C ORI.B  #$52ED,-(A3)
        DC.W    $0016,$001E         ; $023930 ORI.B  #$001E,(A6)
        DC.W    $0024,$002A         ; $023934 ORI.B  #$002A,-(A4)
        DC.W    $002E,$0034,$0050   ; $023938 ORI.B  #$0034,$0050(A6)
        DC.W    $002A,$005A,$0060   ; $02393E ORI.B  #$005A,$0060(A2)
        DC.W    $0034,$E0FF,$2A02   ; $023944 ORI.B  #$E0FF,$02(A4,D2.L)
        MOVE.L  -(A6),D0                        ; $02394A
        MOVE.L  D2,-(A5)                        ; $02394C
        MOVE.L  -(A2),-(A5)                     ; $02394E
        DC.W    $AFF9,$7B04,$2B12   ; $023950 MOVE.L  $7B042B12,<EA:3F>
        DC.W    $AFF6,$7B04         ; $023956 MOVE.L  $04(A6,D7.L),<EA:3F>
        DC.W    $000B,$0009         ; $02395A ORI.B  #$0009,A3
        MOVE.L  -(A2),D5                        ; $02395E
        DC.W    $AFF1,$7A04         ; $023960 MOVE.L  $04(A1,D7.L),<EA:3F>
        MOVEQ   #-$04,D5                        ; $023964
        DC.W    $7BFC,$63A6         ; $023966 MOVE.W  #$63A6,<EA:3D>
        BCC.S  loc_023922                       ; $02396A
        BSR.S  loc_0239AD                       ; $02396C
        BHI.S  loc_0239BF                       ; $02396E
        MOVE.W  (A7),D1                         ; $023970
        OR.B   D4,D2                            ; $023972
        MOVE.L  -$1A(A2,A2.L),-(A5)             ; $023974
        MOVE.W  D4,-(A5)                        ; $023978
        MOVEA.L D2,A5                           ; $02397A
        DC.W    $AFE3               ; $02397C MOVE.L  -(A3),<EA:3F>
        MOVEQ   #$04,D5                         ; $02397E
        MOVE.L  -(A2),D5                        ; $023980
        MOVEQ   #$04,D5                         ; $023982
        MOVE.L  (A2),-(A5)                      ; $023984
        DC.W    $AFDE               ; $023986 MOVE.L  (A6)+,<EA:3F>
        MOVE.W  D4,-(A5)                        ; $023988
        MOVE.L  (A2),D5                         ; $02398A
        DC.W    $AFDB               ; $02398C MOVE.L  (A3)+,<EA:3F>
        MOVEQ   #$04,D5                         ; $02398E
        MOVE.L  (A2),D5                         ; $023990
        MOVEQ   #$04,D5                         ; $023992
        MOVE.L  -(A2),-(A5)                     ; $023994
        DC.W    $AFD6               ; $023996 MOVE.L  (A6),<EA:3F>
        MOVE.W  D4,-(A5)                        ; $023998
        DIVS    -(A0),D2                        ; $02399A
        OR.W   D0,-$1FFC(A7)                    ; $02399C
        OR.W   D0,-$6FFD(A6)                    ; $0239A0
        MOVEQ   #$40,D3                         ; $0239A4
        MOVE.L  A1,D3                           ; $0239A6
        DC.W    $000B,$1E69         ; $0239A8 ORI.B  #$1E69,A3
        DC.W    $BFFF               ; $0239AC CMPA.L  <EA:3F>,A7
        DC.W    $0009,$DE06         ; $0239AE ORI.B  #$DE06,A1
        AND.B  D3,A0                            ; $0239B2
        LSL.B  #3,D6                            ; $0239B4
        BLT.S  loc_02399B                       ; $0239B6
        MOVE.W  A4,-(A6)                        ; $0239B8
        BSR.S  loc_0239C2                       ; $0239BA
        MOVE.L  (A2),-(A6)                      ; $0239BC
        DC.W    $4710               ; $0239BE DC.W    $4710
        DIVS    $04(PC,D7.L),D7                 ; $0239C0
        ADD.B  D2,D0                            ; $0239C4
        NEGX.B (A6)+                            ; $0239C6
        DC.W    $000B,$0009         ; $0239C8 ORI.B  #$0009,A3
        AND.B  D0,D0                            ; $0239CC
        BTST    D3,D0                           ; $0239CE
        MOVE.L  D0,D0                           ; $0239D0
        DC.W    $4100               ; $0239D2 DC.W    $4100
        DC.W    $0000,$00A0         ; $0239D4 ORI.B  #$00A0,D0
        DC.W    $0000,$0070         ; $0239D8 ORI.B  #$0070,D0
        DC.W    $0000,$0010         ; $0239DC ORI.B  #$0010,D0
        DC.W    $0000,$00CF         ; $0239E0 ORI.B  #$00CF,D0
        DC.W    $0000,$0000         ; $0239E4 ORI.B  #$0000,D0
        DC.W    $0000,$013F         ; $0239E8 ORI.B  #$013F,D0
        ADDI.B  #$8000,D1                       ; $0239EC
        DC.W    $4F22               ; $0239F0 DC.W    $4F22
        ADD.B  A6,D0                            ; $0239F2
        DC.W    $400B               ; $0239F4 NEGX.B A3
        DC.W    $0009,$B02B         ; $0239F6 ORI.B  #$B02B,A1
        DC.W    $0009,$BFD8         ; $0239FA ORI.B  #$BFD8,A1
        DC.W    $0009,$D00B         ; $0239FE ORI.B  #$D00B,A1
        SF      $210B(A1)                       ; $023A02
        OR.B   D2,(A6)+                         ; $023A06
        AND.B  D4,D4                            ; $023A08
        OR.B   D4,(A5)+                         ; $023A0A
        AND.B  D2,D4                            ; $023A0C
loc_023A0E:
        OR.B   D5,(A3)                          ; $023A0E
        ADD.B  A0,D0                            ; $023A10
        DC.W    $400B               ; $023A12 NEGX.B A3
        DC.W    $2FE6               ; $023A14 MOVE.L  -(A6),<EA:3F>
        BGT.S  loc_023A0E                       ; $023A16
        SF      -$1FF8(A1)                      ; $023A18
        OR.B   D0,(A6)+                         ; $023A1C
        SUB.B  D4,D0                            ; $023A1E
        SF      $7140(A1)                       ; $023A20
        MOVE.L  A1,-(A0)                        ; $023A24
        DC.W    $AFEB,$1E19         ; $023A26 MOVE.L  $1E19(A3),<EA:3F>
        DC.W    $BFFF               ; $023A2A CMPA.L  <EA:3F>,A7
        ADDI.B  #$45CC,D0                       ; $023A2C
        MOVE.L  D0,D0                           ; $023A30
        DC.W    $0000,$C000         ; $023A32 ORI.B  #$C000,D0
        DC.W    $0000,$9003         ; $023A36 ORI.B  #$9003,D0
        OR.B   D0,(A6)+                         ; $023A3A
        ADD.B  D1,D0                            ; $023A3C
        NEGX.B $4F26(A3)                        ; $023A3E
        MOVE.L  D0,-(A5)                        ; $023A42
        ADDI.B  #$442C,D0                       ; $023A44
        ROXL.B  #3,D0                           ; $023A48
        DC.W    $4710               ; $023A4A DC.W    $4710
        DC.W    $8BFD               ; $023A4C DIVS    <EA:3D>,D5
        DC.W    $AFDA               ; $023A4E MOVE.L  (A2)+,<EA:3F>
        DC.W    $0009,$D105         ; $023A50 ORI.B  #$D105,A1
        ADD.B  D5,D0                            ; $023A54
        SUB.B  D3,D6                            ; $023A56
        BHI.S  loc_023A60                       ; $023A58
        MOVE.L  -(A2),-(A0)                     ; $023A5A
        DC.W    $4710               ; $023A5C DC.W    $4710
        DIVS    $04(PC,D7.W),D7                 ; $023A5E
        DC.W    $000B,$0009         ; $023A62 ORI.B  #$0009,A3
        ORI.L  #$C0000000,(A1)                  ; $023A66
        ADDI.B  #$3A70,D0                       ; $023A6C
        DC.W    $4F22               ; $023A70 DC.W    $4F22
        ADD.B  D0,-(A1)                         ; $023A72
        SVC     -$2000(A1)                      ; $023A74
        MOVE.L  A3,$02(A0,D2.W)                 ; $023A78
        MOVE.B  D4,-(A0)                        ; $023A7C
        MOVE.B  A0,-(A0)                        ; $023A7E
        MOVE.B  A4,-(A0)                        ; $023A80
        BVS.S  loc_023A07                       ; $023A82
        MOVE.W  -(A0),-(A4)                     ; $023A84
        DC.W    $0009,$0009         ; $023A86 ORI.B  #$0009,A1
        DC.W    $0009,$0009         ; $023A8A ORI.B  #$0009,A1
        BSR.S  loc_023A15                       ; $023A8E
        BHI.S  loc_023A17                       ; $023A90
        DC.W    $4111               ; $023A92 DC.W    $4111
        OR.W   D5,(A0)                          ; $023A94
        OR.L   D2,D1                            ; $023A96
        BCS.S  loc_023ABD                       ; $023A98
        MOVE.W  D0,D1                           ; $023A9A
        DIVS    $08(A7,D3.W),D4                 ; $023A9C
        CLR.B  (A5)                             ; $023AA0
        OR.W   D4,A1                            ; $023AA2
        ADD.B  (A5),D0                          ; $023AA4
        BNE.S  loc_023AD3                       ; $023AA6
        CLR.B  D0                               ; $023AA8
        BTST    D1,-$7A80(A5)                   ; $023AAA
        BGE.S  loc_023AC3                       ; $023AAE
        DC.W    $4C28               ; $023AB0 DC.W    $4C28
        MOVE.W  A0,-(A0)                        ; $023AB2
        MOVE.L  (A7)+,-(A1)                     ; $023AB4
        BSR.S  loc_023A4D                       ; $023AB6
        BHI.S  loc_023A4F                       ; $023AB8
        DC.W    $4111               ; $023ABA DC.W    $4111
        OR.B   D5,#$8591                        ; $023ABC
        MOVE.W  D0,D1                           ; $023AC0
        DIVS    $3208.W,D4                      ; $023AC2
        CLR.B  (A5)                             ; $023AC6
        OR.B   D4,$1A(A6,D0.L)                  ; $023AC8
        TST.B  A0                               ; $023ACC
        ADD.B  A3,D0                            ; $023ACE
        BEQ.S  loc_023AFD                       ; $023AD0
        CLR.B  D0                               ; $023AD2
        BTST    D1,-$7A70(A5)                   ; $023AD4
        BLT.S  loc_023AED                       ; $023AD8
        DC.W    $4D28               ; $023ADA DC.W    $4D28
        MOVE.W  A0,-(A0)                        ; $023ADC
        MOVE.L  (A7)+,-(A1)                     ; $023ADE
        ADD.B  D7,D0                            ; $023AE0
        MOVE.L  A3,D6                           ; $023AE2
        MOVE.L  A3,-(A6)                        ; $023AE4
        BTST    D5,(A2)+                        ; $023AE6
        DC.W    $4B08               ; $023AE8 DC.W    $4B08
        DC.W    $3DC0               ; $023AEA MOVE.W  D0,<EA:3E>
        OR.B   D4,A2                            ; $023AEC
        DC.W    $3DC7               ; $023AEE MOVE.W  D7,<EA:3E>
        OR.B   D4,(A6)                          ; $023AF0
        MOVE.L  A2,D0                           ; $023AF2
        BRA.S  loc_023B59                       ; $023AF4
        DC.W    $0000,$4000         ; $023AF6 ORI.B  #$4000,D0
        DC.W    $0000,$0600         ; $023AFA ORI.B  #$0600,D0
        MOVEM.L (A0),#$0000                     ; $023AFE
        OR.B   D0,D0                            ; $023B02
        MOVE.W  -(A7),$0B(A5,A0.L)              ; $023B04
        BRA.S  loc_023B6D                       ; $023B08
        BNE.S  loc_023B7F                       ; $023B0A
        BEQ.S  loc_023B11                       ; $023B0C
        BRA.S  loc_023A93                       ; $023B0E
        BVC.S  loc_023AA5                       ; $023B10
        BVS.S  loc_023B17                       ; $023B12
        BRA.S  loc_023AB9                       ; $023B14
        BPL.S  loc_023ACB                       ; $023B16
        BMI.S  loc_023B1D                       ; $023B18
        BRA.S  loc_023ADF                       ; $023B1A
        BGE.S  loc_023AF1                       ; $023B1C
        BLT.S  loc_023B23                       ; $023B1E
        CMP.W  D2,D0                            ; $023B20
        SF      $4E0B(A1)                       ; $023B22
        BSR.S  loc_023B7B                       ; $023B26
        SUB.B  D5,D0                            ; $023B28
        MOVE.W  A4,-(A2)                        ; $023B2A
        NOT.B  (A0)                             ; $023B2C
        OR.B   D7,(A3)+                         ; $023B2E
        MOVE.W  -$5FFB(A4),(A6)                 ; $023B30
        BSR.S  loc_023ABB                       ; $023B34
        DC.W    $0200,$4F26         ; $023B36 ANDI.B  #$4F26,D0
        DC.W    $000B,$0009         ; $023B3A ORI.B  #$0009,A3
        BSR.S  loc_023AC5                       ; $023B3E
        BHI.S  loc_023AC7                       ; $023B40
        OR.L   D2,D1                            ; $023B42
        NEGX.B (A1)                             ; $023B44
        OR.B   D5,$3200(A1)                     ; $023B46
        DIVS    $3208.W,D4                      ; $023B4A
        CLR.B  (A5)                             ; $023B4E
        DIVS    $11(A2,A5.W),D4                 ; $023B50
        BNE.S  loc_023B81                       ; $023B54
        CLR.B  D0                               ; $023B56
        BTST    D1,-$7A80(A5)                   ; $023B58
        BGE.S  loc_023B71                       ; $023B5C
        DC.W    $4C28               ; $023B5E DC.W    $4C28
        MOVE.W  A0,-(A0)                        ; $023B60
        MOVE.L  (A7)+,-(A1)                     ; $023B62
        DC.W    $0A1A,$4A08         ; $023B64 EORI.B  #$4A08,(A2)+
        DC.W    $4710               ; $023B68 DC.W    $4710
        DIVS    (A3)+,D7                        ; $023B6A
        MOVE.W  #$6195,-$6B(A6,D6.W)            ; $023B6C
        OR.L   D2,(A1)                          ; $023B72
        MOVE.W  D0,D1                           ; $023B74
        DIVS    $3208(PC),D4                    ; $023B76
        CLR.B  (A5)                             ; $023B7A
        DIVS    (A4)+,D4                        ; $023B7C
        ADD.B  D6,D0                            ; $023B7E
        BEQ.S  loc_023BAD                       ; $023B80
        CLR.B  D0                               ; $023B82
        BTST    D1,-$7A70(A5)                   ; $023B84
        BLT.S  loc_023B9D                       ; $023B88
        DC.W    $4D28               ; $023B8A DC.W    $4D28
        MOVE.W  A0,-(A0)                        ; $023B8C
        MOVE.L  (A7)+,-(A1)                     ; $023B8E
        BTST    D5,(A2)+                        ; $023B90
        DC.W    $AFC7               ; $023B92 MOVE.L  D7,<EA:3F>
        DC.W    $4B08               ; $023B94 DC.W    $4B08
        DC.W    $0000,$0600         ; $023B96 ORI.B  #$0600,D0
        MOVEM.L (A0),D2/D3/D4/D5/D7/A0/A2/A3/A4/A5; $023B9A
        BSR.S  loc_023BF3                       ; $023B9E
        DC.W    $4E2B               ; $023BA0 DC.W    $4E2B
        DC.W    $4F26               ; $023BA2 DC.W    $4F26
        DC.W    $AFFE               ; $023BA4 MOVE.L  <EA:3E>,<EA:3F>
        DC.W    $0009,$851F         ; $023BA6 ORI.B  #$851F,A1
        SUB.B  A3,D2                            ; $023BAA
        AND.B  D2,D4                            ; $023BAC
        OR.B   D5,A7                            ; $023BAE
        MOVEA.L A1,A0                           ; $023BB0
        BCC.S  loc_023BBC                       ; $023BB2
        MOVE.L  A3,D2                           ; $023BB4
        ADD.B  D4,D0                            ; $023BB6
        DC.W    $4518               ; $023BB8 DC.W    $4518
        DC.W    $4500               ; $023BBA DC.W    $4500
loc_023BBC:
        MOVE.W  A4,-(A2)                        ; $023BBC
        ADD.B  D3,D7                            ; $023BBE
        DC.W    $000B,$0009         ; $023BC0 ORI.B  #$0009,A3
        MOVE.W  D0,-(A7)                        ; $023BC4
        DC.W    $0000,$2400         ; $023BC6 ORI.B  #$2400,D0
        NEGX.B D0                               ; $023BCA
        AND.B  D0,D0                            ; $023BCC
        DC.W    $0188               ; $023BCE BCLR    D0,A0
        MOVE.L  A1,D2                           ; $023BD0
        BRA.S  loc_023C27                       ; $023BD2
        AND.B  D1,D4                            ; $023BD4
        OR.B   D5,D0                            ; $023BD6
        BCC.S  loc_023C22                       ; $023BD8
        ADD.B  D5,D0                            ; $023BDA
        DC.W    $4518               ; $023BDC DC.W    $4518
        DC.W    $4500               ; $023BDE DC.W    $4500
        MOVE.W  A4,-(A2)                        ; $023BE0
        ADD.B  D4,D7                            ; $023BE2
        AND.B  D2,D5                            ; $023BE4
        AND.B  D2,D4                            ; $023BE6
        DIVS    #$000B,D5                       ; $023BE8
        DC.W    $0009,$0000         ; $023BEC ORI.B  #$0000,A1
        MOVE.L  D2,D2                           ; $023BF0
        NEGX.B D0                               ; $023BF2
        AND.B  D0,D0                            ; $023BF4
        BSET    D0,-$37(A4,D6.W)                ; $023BF6
        BHI.S  loc_023C2B                       ; $023BFA
        BLS.S  loc_023BD7                       ; $023BFC
        BLS.S  loc_023C3F                       ; $023BFE
        MOVE.W  $3320(A4),-(A0)                 ; $023C00
        OR.B   D4,(A6)+                         ; $023C04
        AND.B  D2,D5                            ; $023C06
        AND.B  D2,D4                            ; $023C08
        DIVS    #$E001,D7                       ; $023C0A
        MOVE.L  A0,D1                           ; $023C0E
        OR.B   D4,D2                            ; $023C10
        MOVE.L  D0,$7101(A0)                    ; $023C12
        MOVEQ   #$01,D1                         ; $023C16
        MOVE.L  A0,-(A1)                        ; $023C18
        OR.B   D7,D3                            ; $023C1A
        BRA.S  loc_023C51                       ; $023C1C
        MOVEA.W (A4)+,A0                        ; $023C1E
        MOVEA.L D0,A0                           ; $023C20
loc_023C22:
        BRA.S  loc_023C57                       ; $023C22
        MOVE.W  $7001(A0),D0                    ; $023C24
        ASR.B  #1,D2                            ; $023C28
        MOVE.W  -(A3),D0                        ; $023C2A
        OR.B   D7,A0                            ; $023C2C
        NEGX.B D1                               ; $023C2E
        MOVEQ   #-$01,D0                        ; $023C30
        AND.B  D0,D2                            ; $023C32
        BRA.S  loc_023C49                       ; $023C34
        NEGX.B D1                               ; $023C36
        AND.B  D0,D3                            ; $023C38
        BRA.S  loc_023C7F                       ; $023C3A
        DC.W    $000B,$C104         ; $023C3C ORI.B  #$C104,A3
        DC.W    $000B,$0009         ; $023C40 ORI.B  #$0009,A3
        AND.B  D2,D5                            ; $023C44
        AND.B  D2,D4                            ; $023C46
        DIVS    #$000B,D5                       ; $023C48
        MOVE.L  D0,-$1DFE(A0)                   ; $023C4C
        MOVE.W  -(A3),D0                        ; $023C50
        DIVS    $01(A5,D4.W),D5                 ; $023C52
        MOVE.L  D1,$4010(A0)                    ; $023C56
        DIVS    #$7102,D7                       ; $023C5A
        DC.W    $000B,$0009         ; $023C5E ORI.B  #$0009,A3
        DC.W    $0009,$62C9         ; $023C62 ORI.B  #$62C9,A1
        BHI.S  loc_023C97                       ; $023C66
        BLS.S  loc_023C43                       ; $023C68
        BLS.S  loc_023CAB                       ; $023C6A
        BCC.S  loc_023CB6                       ; $023C6C
        MOVE.W  #$3320,-(A0)                    ; $023C6E
        OR.B   D4,(A7)                          ; $023C72
        BRA.S  loc_023CA9                       ; $023C74
        AND.B  D1,D4                            ; $023C76
        OR.B   D7,D3                            ; $023C78
        BRA.S  loc_023CC4                       ; $023C7A
        MOVE.L  D0,-(A0)                        ; $023C7C
        DC.W    $71FF,$73FF         ; $023C7E MOVE.W  <EA:3F>,$73FF.W
        MOVE.W  D1,-(A0)                        ; $023C82
        BRA.S  loc_023CB9                       ; $023C84
        MOVE.W  $7001(A0),D0                    ; $023C86
        ASL.B  #1,D2                            ; $023C8A
loc_023C8C:
        MOVE.W  $03(A3,A0.L),D0                 ; $023C8C
loc_023C90:
        NEGX.B D1                               ; $023C90
        NEGX.B (A0)                             ; $023C92
        DC.W    $8FFD               ; $023C94 DIVS    <EA:3D>,D7
        MOVE.L  D5,$6023(A0)                    ; $023C96
        AND.B  D1,D4                            ; $023C9A
        OR.B   D4,D0                            ; $023C9C
        MOVE.L  D4,$000B(A0)                    ; $023C9E
        DC.W    $0009,$6023         ; $023CA2 ORI.B  #$6023,A1
        AND.B  D1,D4                            ; $023CA6
        OR.B   D5,D2                            ; $023CA8
        BRA.S  loc_023CF4                       ; $023CAA
        DC.W    $000B,$2100         ; $023CAC ORI.B  #$2100,A3
        DC.W    $000B,$2140         ; $023CB0 ORI.B  #$2140,A3
        DC.W    $4F22               ; $023CB4 DC.W    $4F22
loc_023CB6:
        DIVU    -(A0),D2                        ; $023CB6
        OR.B   D0,D4                            ; $023CB8
        OR.B   D4,A1                            ; $023CBA
        DC.W    $2FE6               ; $023CBC MOVE.L  -(A6),<EA:3F>
        MOVE.L  $2C(A6,A1.L),-$2EE9(A7)         ; $023CBE
loc_023CC4:
        NEGX.B D0                               ; $023CC4
loc_023CC6:
        DC.W    $001D,$0003         ; $023CC6 ORI.B  #$0003,(A5)+
        DC.W    $0009,$67F6         ; $023CCA ORI.B  #$67F6,A1
        BGT.S  loc_023CC6                       ; $023CCE
        DC.W    $4710               ; $023CD0 DC.W    $4710
        DIVS    $10(A0,D7.L),D7                 ; $023CD2
        DC.W    $4F26               ; $023CD6 DC.W    $4F26
        DC.W    $000B,$0009         ; $023CD8 ORI.B  #$0009,A3
        DC.W    $002C,$002C,$00A2   ; $023CDC ORI.B  #$002C,$00A2(A4)
        DC.W    $010C               ; $023CE2 BTST    D0,A4
        BCLR    D0,(A0)+                        ; $023CE4
        BCLR    D0,(A0)+                        ; $023CE6
        BSET    D0,D4                           ; $023CE8
        ORI.W  #$0088,-$06(A2,D0.W)             ; $023CEA
        ORI.W  #$0328,(A0)+                     ; $023CF0
loc_023CF4:
        BTST    D1,$42(A6,D0.W)                 ; $023CF4
        SVC     -(A2)                           ; $023CF8
        SVS     -(A1)                           ; $023CFA
        BNE.S  loc_023C83                       ; $023CFC
        BEQ.S  loc_023C85                       ; $023CFE
        BSR.S  loc_023C95                       ; $023D00
        BHI.S  loc_023D67                       ; $023D02
        BRA.S  loc_023C8C                       ; $023D04
        MOVE.B  D0,-(A0)                        ; $023D06
        BRA.S  loc_023C90                       ; $023D08
        MOVE.B  D1,-(A0)                        ; $023D0A
        CLR.B  (A0)                             ; $023D0C
        DIVS    $71084710,D7                    ; $023D0E
        DIVS    -$24(A4,D3.L),D7                ; $023D14
        DC.W    $000B,$0009         ; $023D18 ORI.B  #$0009,A3
        DC.W    $0200,$0000         ; $023D1C ANDI.B  #$0000,D0
        ADDI.B  #$3CDC,D0                       ; $023D20
        DIVS    -(A1),D2                        ; $023D24
        SUB.B  D0,D7                            ; $023D26
        MOVE.W  (A3),D0                         ; $023D28
        OR.B   D4,D6                            ; $023D2A
        SVC     -(A2)                           ; $023D2C
        SVS     -(A1)                           ; $023D2E
        ASL.W  #$2019                           ; $023D30
        DC.W    $AFE2               ; $023D34 MOVE.L  -(A2),<EA:3F>
        MOVE.W  A4,-(A4)                        ; $023D36
        BCHG    D0,D0                           ; $023D38
        DC.W    $000B,$0009         ; $023D3A ORI.B  #$0009,A3
        DIVS    -(A1),D2                        ; $023D3E
        SUB.B  D0,D5                            ; $023D40
        MOVE.W  (A3),D0                         ; $023D42
        OR.B   D4,D4                            ; $023D44
        SVC     -(A2)                           ; $023D46
        SVS     -(A1)                           ; $023D48
        DC.W    $A13E               ; $023D4A MOVE.L  <EA:3E>,-(A0)
        MOVE.W  A4,-(A4)                        ; $023D4C
        DC.W    $0200,$000B         ; $023D4E ANDI.B  #$000B,D0
        DC.W    $0009,$85E1         ; $023D52 ORI.B  #$85E1,A1
        SUB.B  D0,D7                            ; $023D56
        MOVE.W  (A3),D0                         ; $023D58
        OR.B   D4,D6                            ; $023D5A
        SVS     -(A1)                           ; $023D5C
        ASL.W  #$2019                           ; $023D5E
        MOVE.W  A4,-(A4)                        ; $023D62
        MOVE.L  D5,D0                           ; $023D64
        DC.W    $4F22               ; $023D66 DC.W    $4F22
        BCHG    D0,D0                           ; $023D68
        DC.W    $000B,$0009         ; $023D6A ORI.B  #$0009,A3
        DC.W    $4F22               ; $023D6E DC.W    $4F22
        SVS     -(A1)                           ; $023D70
        ADD.B  (A5),D5                          ; $023D72
        DIVU    -(A1),D2                        ; $023D74
        DC.W    $4008               ; $023D76 NEGX.B A0
        DC.W    $0AAE,$84E8,$8800,$8901; $023D78 EORI.L  #$84E88800,-$76FF(A6)
        CMP.L  -(A6),D0                         ; $023D80
        DC.W    $0009,$7908         ; $023D82 ORI.B  #$7908,A1
        DIVU    -$7800(A1),D2                   ; $023D86
        OR.B   D4,D1                            ; $023D8A
        CMP.L  -(A0),D0                         ; $023D8C
        DC.W    $0009,$7908         ; $023D8E ORI.B  #$7908,A1
        CMP.L  (A5)+,D0                         ; $023D92
        DIVU    $7908(A2),D2                    ; $023D94
        CMP.L  (A2)+,D0                         ; $023D98
        LSR.B  #8,D2                            ; $023D9A
        MOVE.W  A0,-(A4)                        ; $023D9C
        CMP.L  (A7),D0                          ; $023D9E
        DIVU    $7908(A3),D2                    ; $023DA0
        CMP.L  (A4),D0                          ; $023DA4
        DIVU    $7908(A4),D2                    ; $023DA6
        CMP.L  (A1),D0                          ; $023DAA
        LSR.B  #8,D3                            ; $023DAC
        MOVE.W  A0,-(A4)                        ; $023DAE
        CMP.L  A6,D0                            ; $023DB0
        DIVU    $7908(A5),D2                    ; $023DB2
        CMP.L  A3,D0                            ; $023DB6
        DIVU    $7908(A6),D2                    ; $023DB8
        CMP.L  A0,D0                            ; $023DBC
        DIVU    $4F26(A7),D2                    ; $023DBE
        DC.W    $000B,$0009         ; $023DC2 ORI.B  #$0009,A3
        DC.W    $0000,$0600         ; $023DC6 ORI.B  #$0600,D0
        DC.W    $3DCC               ; $023DCA MOVE.W  A4,<EA:3E>
        ADDI.B  #$7B88,D0                       ; $023DCC
        ADDI.B  #$7F4C,D0                       ; $023DD0
        ADDI.B  #$8310,D0                       ; $023DD4
        DC.W    $4F22               ; $023DD8 DC.W    $4F22
        SVS     -(A1)                           ; $023DDA
        SUB.B  $390C(A2),D0                     ; $023DDC
        ADD.B  (A5),D5                          ; $023DE0
        DIVU    -(A1),D2                        ; $023DE2
        DC.W    $4008               ; $023DE4 NEGX.B A0
        DC.W    $0AAE,$84E8,$8800,$8901; $023DE6 EORI.L  #$84E88800,-$76FF(A6)
        CMP.L  (A6)+,D0                         ; $023DEE
        DC.W    $0009,$7908         ; $023DF0 ORI.B  #$7908,A1
        DIVU    -$7800(A1),D2                   ; $023DF4
        OR.B   D4,D1                            ; $023DF8
        CMP.L  (A0)+,D0                         ; $023DFA
        DC.W    $0009,$7908         ; $023DFC ORI.B  #$7908,A1
        CMP.L  (A5),D0                          ; $023E00
        DIVU    $7908(A2),D2                    ; $023E02
        CMP.L  (A2),D0                          ; $023E06
        LSR.B  #8,D2                            ; $023E08
        MOVE.W  A0,-(A4)                        ; $023E0A
        CMP.L  A7,D0                            ; $023E0C
        DIVU    $7908(A3),D2                    ; $023E0E
        CMP.L  A4,D0                            ; $023E12
        DIVU    $7908(A4),D2                    ; $023E14
        CMP.L  A1,D0                            ; $023E18
        LSR.B  #8,D3                            ; $023E1A
        MOVE.W  A0,-(A4)                        ; $023E1C
        CMP.L  D6,D0                            ; $023E1E
        DIVU    $7908(A5),D2                    ; $023E20
        CMP.L  D3,D0                            ; $023E24
        DIVU    $7908(A6),D2                    ; $023E26
        CMP.L  D0,D0                            ; $023E2A
        DIVU    $4F26(A7),D2                    ; $023E2C
        DC.W    $000B,$0009         ; $023E30 ORI.B  #$0009,A3
        SUBI.B  #$0000,D0                       ; $023E34
        ADDI.B  #$3E3C,D0                       ; $023E38
        ADDI.B  #$86E4,D0                       ; $023E3C
        ADDI.B  #$8E68,D0                       ; $023E40
        ADDI.B  #$95EC,D0                       ; $023E44
        DC.W    $4F22               ; $023E48 DC.W    $4F22
        SVS     -(A1)                           ; $023E4A
        ADD.B  D4,D5                            ; $023E4C
        CMP.W  -$7B16(A6),D0                    ; $023E4E
        MOVE.W  A0,-(A4)                        ; $023E52
        CMP.W  -$7B15(A3),D0                    ; $023E54
        DC.W    $4F26               ; $023E58 DC.W    $4F26
        DC.W    $000B,$0009         ; $023E5A ORI.B  #$0009,A3
        DC.W    $0000,$0600         ; $023E5E ORI.B  #$0600,D0
        DIVU    (A4),D3                         ; $023E62
        DC.W    $4F22               ; $023E64 DC.W    $4F22
        SVS     -(A1)                           ; $023E66
        SUB.B  A7,D0                            ; $023E68
        MOVE.W  A4,-(A4)                        ; $023E6A
        ADD.B  D7,D5                            ; $023E6C
        DIVU    -(A1),D2                        ; $023E6E
        DC.W    $4008               ; $023E70 NEGX.B A0
        DC.W    $0AAE,$84EA,$8800,$8901; $023E72 EORI.L  #$84EA8800,-$76FF(A6)
        CMP.W  (A0)+,D0                         ; $023E7A
        DC.W    $0009,$7908         ; $023E7C ORI.B  #$7908,A1
        CMP.W  (A5),D0                          ; $023E80
        DIVU    $4F26(A3),D2                    ; $023E82
        DC.W    $000B,$0009         ; $023E86 ORI.B  #$0009,A3
        SUBI.B  #$0600,D0                       ; $023E8A
        MOVE.W  #$4F22,D7                       ; $023E8E
        SVS     -(A1)                           ; $023E92
        SUB.B  (A0)+,D0                         ; $023E94
        MOVE.W  A4,-(A4)                        ; $023E96
        ADD.B  A4,D5                            ; $023E98
        DIVU    -(A1),D2                        ; $023E9A
        DC.W    $4008               ; $023E9C NEGX.B A0
        DC.W    $0AAE,$EC00,$84E9,$8800; $023E9E EORI.L  #$EC0084E9,-$7800(A6)
        OR.B   D4,D1                            ; $023EA6
        CMP.W  D1,D0                            ; $023EA8
        ASR.B  #6,D1                            ; $023EAA
        MOVE.W  A0,-(A4)                        ; $023EAC
        DIVU    $4C15(A2),D2                    ; $023EAE
        OR.B   D4,D1                            ; $023EB2
        OR.B   D0,D4                            ; $023EB4
        OR.B   D4,D1                            ; $023EB6
        CMP.B  $EC017908,D0                     ; $023EB8
        CMP.B  -$15(A6,A0.W),D0                 ; $023EBE
        DC.W    $4F26               ; $023EC2 DC.W    $4F26
        DC.W    $000B,$0009         ; $023EC4 ORI.B  #$0009,A3
        SUBI.B  #$0000,D0                       ; $023EC8
        ADDI.B  #$3E3C,D0                       ; $023ECC
        DC.W    $4008               ; $023ED0 NEGX.B A0
        DC.W    $4008               ; $023ED2 NEGX.B A0
        DC.W    $4008               ; $023ED4 NEGX.B A0
        MOVE.W  $6193(A4),(A0)                  ; $023ED6
        BHI.S  loc_023EE2                       ; $023EDA
        MOVE.B  -(A0),-(A0)                     ; $023EDC
        BHI.S  loc_023EE6                       ; $023EDE
        MOVE.B  -(A1),-(A0)                     ; $023EE0
loc_023EE2:
        MOVE.W  (A4)+,$6206.W                   ; $023EE2
loc_023EE6:
        MOVE.B  -(A0),-(A0)                     ; $023EE6
        BHI.S  loc_023EF0                       ; $023EE8
        MOVE.B  -(A1),-(A0)                     ; $023EEA
        MOVE.W  (A4)+,$6206.W                   ; $023EEC
loc_023EF0:
        MOVE.B  -(A0),-(A0)                     ; $023EF0
        BHI.S  loc_023EFA                       ; $023EF2
        MOVE.B  -(A1),-(A0)                     ; $023EF4
        MOVE.W  (A4)+,$6206.W                   ; $023EF6
loc_023EFA:
        MOVE.B  -(A0),-(A0)                     ; $023EFA
        BHI.S  loc_023F04                       ; $023EFC
        MOVE.B  -(A1),-(A0)                     ; $023EFE
        MOVE.W  (A4)+,$6206.W                   ; $023F00
loc_023F04:
        MOVE.B  -(A0),-(A0)                     ; $023F04
        BHI.S  loc_023F0E                       ; $023F06
        MOVE.B  -(A1),-(A0)                     ; $023F08
        MOVE.W  (A4)+,$6206.W                   ; $023F0A
loc_023F0E:
        MOVE.B  -(A0),-(A0)                     ; $023F0E
        BHI.S  loc_023F18                       ; $023F10
        MOVE.B  -(A1),-(A0)                     ; $023F12
        MOVE.W  (A4)+,$6206.W                   ; $023F14
loc_023F18:
        MOVE.B  -(A0),-(A0)                     ; $023F18
        BHI.S  loc_023F22                       ; $023F1A
        MOVE.B  -(A1),-(A0)                     ; $023F1C
        MOVE.W  (A4)+,$6206.W                   ; $023F1E
loc_023F22:
        MOVE.B  -(A0),-(A0)                     ; $023F22
        BHI.S  loc_023F2C                       ; $023F24
        MOVE.B  -(A1),-(A0)                     ; $023F26
        MOVE.W  (A4)+,$000B.W                   ; $023F28
loc_023F2C:
        DC.W    $0009,$4018         ; $023F2C ORI.B  #$4018,A1
        NEGX.B D1                               ; $023F30
        MOVE.W  $6193(A4),(A0)                  ; $023F32
        BHI.S  loc_023F3E                       ; $023F36
        MOVE.B  -(A0),-(A0)                     ; $023F38
        BHI.S  loc_023F42                       ; $023F3A
        MOVE.B  -(A1),-(A0)                     ; $023F3C
loc_023F3E:
        MOVE.W  (A4)+,$6206.W                   ; $023F3E
loc_023F42:
        MOVE.B  -(A0),-(A0)                     ; $023F42
        BHI.S  loc_023F4C                       ; $023F44
        MOVE.B  -(A1),-(A0)                     ; $023F46
        MOVE.W  (A4)+,$6206.W                   ; $023F48
loc_023F4C:
        MOVE.B  -(A0),-(A0)                     ; $023F4C
        BHI.S  loc_023F56                       ; $023F4E
        MOVE.B  -(A1),-(A0)                     ; $023F50
        MOVE.W  (A4)+,$6206.W                   ; $023F52
loc_023F56:
        MOVE.B  -(A0),-(A0)                     ; $023F56
        BHI.S  loc_023F60                       ; $023F58
        MOVE.B  -(A1),-(A0)                     ; $023F5A
        MOVE.W  (A4)+,$6206.W                   ; $023F5C
loc_023F60:
        MOVE.B  -(A0),-(A0)                     ; $023F60
        BHI.S  loc_023F6A                       ; $023F62
        MOVE.B  -(A1),-(A0)                     ; $023F64
        MOVE.W  (A4)+,$6206.W                   ; $023F66
loc_023F6A:
        MOVE.B  -(A0),-(A0)                     ; $023F6A
        BHI.S  loc_023F74                       ; $023F6C
        MOVE.B  -(A1),-(A0)                     ; $023F6E
        MOVE.W  (A4)+,$6206.W                   ; $023F70
loc_023F74:
        MOVE.B  -(A0),-(A0)                     ; $023F74
        BHI.S  loc_023F7E                       ; $023F76
        MOVE.B  -(A1),-(A0)                     ; $023F78
        MOVE.W  (A4)+,$6206.W                   ; $023F7A
loc_023F7E:
        MOVE.B  -(A0),-(A0)                     ; $023F7E
        BHI.S  loc_023F88                       ; $023F80
        MOVE.B  -(A1),-(A0)                     ; $023F82
        MOVE.W  (A4)+,$6206.W                   ; $023F84
loc_023F88:
        MOVE.B  -(A0),-(A0)                     ; $023F88
        BHI.S  loc_023F92                       ; $023F8A
        MOVE.B  -(A1),-(A0)                     ; $023F8C
        MOVE.W  (A4)+,$6206.W                   ; $023F8E
loc_023F92:
        MOVE.B  -(A0),-(A0)                     ; $023F92
        BHI.S  loc_023F9C                       ; $023F94
        MOVE.B  -(A1),-(A0)                     ; $023F96
        MOVE.W  (A4)+,$6206.W                   ; $023F98
loc_023F9C:
        MOVE.B  -(A0),-(A0)                     ; $023F9C
        BHI.S  loc_023FA6                       ; $023F9E
        MOVE.B  -(A1),-(A0)                     ; $023FA0
        MOVE.W  (A4)+,$6206.W                   ; $023FA2
loc_023FA6:
        MOVE.B  -(A0),-(A0)                     ; $023FA6
        BHI.S  loc_023FB0                       ; $023FA8
        MOVE.B  -(A1),-(A0)                     ; $023FAA
        MOVE.W  (A4)+,$6206.W                   ; $023FAC
loc_023FB0:
        MOVE.B  -(A0),-(A0)                     ; $023FB0
        BHI.S  loc_023FBA                       ; $023FB2
        MOVE.B  -(A1),-(A0)                     ; $023FB4
        MOVE.W  (A4)+,$6206.W                   ; $023FB6
loc_023FBA:
        MOVE.B  -(A0),-(A0)                     ; $023FBA
        BHI.S  loc_023FC4                       ; $023FBC
        MOVE.B  -(A1),-(A0)                     ; $023FBE
        MOVE.W  (A4)+,$000B.W                   ; $023FC0
loc_023FC4:
        DC.W    $0009,$58E2         ; $023FC4 ORI.B  #$58E2,A1
loc_023FC8:
        SVS     -(A1)                           ; $023FC8
        BEQ.S  loc_023F51                       ; $023FCA
loc_023FCC:
        BSR.S  loc_023F61                       ; $023FCC
        BRA.S  loc_023F55                       ; $023FCE
        OR.B   D0,D4                            ; $023FD0
        OR.B   D4,A2                            ; $023FD2
        BNE.S  loc_023FE2                       ; $023FD4
        NEGX.B (A1)+                            ; $023FD6
        DC.W    $C8FF               ; $023FD8 MULU    <EA:3F>,D4
        OR.B   D4,D4                            ; $023FDA
        NOT.B  (A0)                             ; $023FDC
        DC.W    $8FFD               ; $023FDE DIVS    <EA:3D>,D7
        MOVE.L  D4,-(A0)                        ; $023FE0
loc_023FE2:
        DC.W    $AFF5,$6085         ; $023FE2 MOVE.L  -$7B(A5,D6.W),<EA:3F>
        DC.W    $AFF2,$3168         ; $023FE6 MOVE.L  $68(A2,D3.W),<EA:3F>
        DC.W    $4710               ; $023FEA DC.W    $4710
        DIVS    $39DC(A6),D7                    ; $023FEC
        DC.W    $000B,$0009         ; $023FF0 ORI.B  #$0009,A3
        SVC     -(A2)                           ; $023FF4
        SVS     -(A1)                           ; $023FF6
        MOVEQ   #$02,D4                         ; $023FF8
        DIVS    -(A1),D2                        ; $023FFA
        BEQ.S  loc_024001                       ; $023FFC
        DC.W    $AFE5               ; $023FFE MOVE.L  -(A5),<EA:3F>
        BLT.S  loc_023FDD                       ; $024000
        SVC     -(A2)                           ; $024002
        SVS     -(A1)                           ; $024004
        MOVEQ   #$02,D4                         ; $024006
        DIVS    -(A1),D2                        ; $024008
        DC.W    $AFDF               ; $02400A MOVE.L  (A7)+,<EA:3F>
        BEQ.S  loc_024011                       ; $02400C
        SVC     -(A2)                           ; $02400E
        SVS     -(A1)                           ; $024010
        ASR.W  #$2909                           ; $024012
        BRA.S  loc_023FAB                       ; $024016
        SUB.B  D0,(A7)+                         ; $024018
        MOVE.L  (A1)+,D0                        ; $02401A
        SUB.B  D0,(A6)+                         ; $02401C
        MOVE.W  (A3),D0                         ; $02401E
        OR.B   D4,(A1)+                         ; $024020
        DC.W    $4009               ; $024022 NEGX.B A1
        NEGX.B D1                               ; $024024
        BNE.S  loc_023FAD                       ; $024026
        ASL.B  #2,D0                            ; $024028
        MOVEA.W $70D8(A4),A0                    ; $02402A
        NEGX.B (A5)                             ; $02402E
        OR.B   D5,D3                            ; $024030
        MOVE.W  A0,D3                           ; $024032
        BCS.S  loc_024039                       ; $024034
        DC.W    $4508               ; $024036 DC.W    $4508
        DC.W    $4500               ; $024038 DC.W    $4500
        BEQ.S  loc_023FC1                       ; $02403A
        BSR.S  loc_023FD1                       ; $02403C
        BHI.S  loc_0240A3                       ; $02403E
        BRA.S  loc_023FC8                       ; $024040
        MOVE.B  D0,-(A0)                        ; $024042
        BRA.S  loc_023FCC                       ; $024044
        MOVE.B  D1,-(A0)                        ; $024046
        CLR.B  (A0)                             ; $024048
        DIVS    $7108385C,D7                    ; $02404A
        DC.W    $4710               ; $024050 DC.W    $4710
        DIVS    -$24(A3,D3.L),D7                ; $024052
        DC.W    $000B,$0009         ; $024056 ORI.B  #$0009,A3
        DC.W    $01FF               ; $02405A BSET    D0,<EA:3F>
        BCHG    D0,D0                           ; $02405C
        DC.W    $FFFF               ; $02405E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $4F22               ; $024060 DC.W    $4F22
        DIVS    -(A0),D2                        ; $024062
        OR.B   D0,D4                            ; $024064
        OR.B   D4,D7                            ; $024066
        DC.W    $2FE6               ; $024068 MOVE.L  -(A6),<EA:3F>
        MOVE.L  $0A(A6,A3.W),$0009(A7)          ; $02406A
        CMP.L  (A0)+,D0                         ; $024070
        DC.W    $0009,$67F6         ; $024072 ORI.B  #$67F6,A1
        BGT.S  loc_02406E                       ; $024076
        DC.W    $4710               ; $024078 DC.W    $4710
        DIVS    $14(A2,D7.L),D7                 ; $02407A
        DC.W    $4F26               ; $02407E DC.W    $4F26
        DC.W    $000B,$0009         ; $024080 ORI.B  #$0009,A3
        ADD.B  D6,(A6)+                         ; $024084
        ADD.B  D0,(A7)+                         ; $024086
        DIVU    -(A2),D2                        ; $024088
        DC.W    $4008               ; $02408A NEGX.B A0
        DC.W    $001E,$2D02         ; $02408C ORI.B  #$2D02,(A6)+
        ASR.B  #8,D0                            ; $024090
        DIVS    (A2),D0                         ; $024092
        DIVS    -$7E2D(A0),D2                   ; $024094
        DIVS    -$7E2C(A1),D2                   ; $024098
        ASR.B  #8,D0                            ; $02409C
        DIVU    (A2)+,D0                        ; $02409E
        DIVU    $7030(A2),D2                    ; $0240A0
        DIVU    (A3)+,D0                        ; $0240A4
        ASR.B  D0,D7                            ; $0240A6
        DIVU    (A4)+,D0                        ; $0240A8
        DIVU    $7030(A3),D2                    ; $0240AA
        DIVU    (A5)+,D0                        ; $0240AE
        DIVU    $7030(A4),D2                    ; $0240B0
        DIVU    (A6)+,D0                        ; $0240B4
        ASR.B  D0,D2                            ; $0240B6
        DIVU    (A7)+,D0                        ; $0240B8
        MOVE.W  (A0),-(A6)                      ; $0240BA
        DIVU    $7030(A5),D2                    ; $0240BC
        DIVU    (A0),D0                         ; $0240C0
        DIVU    $7030(A6),D2                    ; $0240C2
        DIVU    (A1),D0                         ; $0240C6
        DIVU    $7030(A7),D2                    ; $0240C8
        DIVU    (A2),D0                         ; $0240CC
        ASR.B  #8,D0                            ; $0240CE
        DIVU    (A3),D0                         ; $0240D0
        DIVU    (A4),D0                         ; $0240D2
        DIVU    -(A3),D2                        ; $0240D4
        ADD.B  D0,A4                            ; $0240D6
        DC.W    $4008               ; $0240D8 NEGX.B A0
        NEGX.B D0                               ; $0240DA
        MOVE.W  A4,-(A0)                        ; $0240DC
        BRA.S  loc_0240F4                       ; $0240DE
        DIVU    (A5),D0                         ; $0240E0
        BRA.S  loc_0240F8                       ; $0240E2
        DIVU    (A6),D0                         ; $0240E4
        BRA.S  loc_0240FC                       ; $0240E6
        DIVU    (A7),D0                         ; $0240E8
        BRA.S  loc_024100                       ; $0240EA
        DIVU    (A0)+,D0                        ; $0240EC
        BRA.S  loc_024104                       ; $0240EE
        DIVU    (A1)+,D0                        ; $0240F0
        BRA.S  loc_024108                       ; $0240F2
loc_0240F4:
        DIVU    (A2)+,D0                        ; $0240F4
        BRA.S  loc_02410C                       ; $0240F6
loc_0240F8:
        DIVU    (A3)+,D0                        ; $0240F8
        DC.W    $000B,$0009         ; $0240FA ORI.B  #$0009,A3
        DC.W    $0000,$C000         ; $0240FE ORI.B  #$C000,D0
        DC.W    $0000,$0600         ; $024102 ORI.B  #$0600,D0
        DC.W    $410C               ; $024106 DC.W    $410C
loc_024108:
        ADDI.B  #$4184,D0                       ; $024108
loc_02410C:
        MOVE.L  -(A0),D0                        ; $02410C
        MOVE.L  -(A0),D0                        ; $02410E
        MOVE.L  $74(A1,D7.W),D0                 ; $024110
        MOVE.L  $64(A2,D6.L),D0                 ; $024114
        MOVE.L  $64(A3,D7.W),D0                 ; $024118
        MOVE.L  $68(A4,D7.W),D0                 ; $02411C
        MOVE.L  $68(A5,D7.W),D0                 ; $024120
        MOVE.L  $68(A6,D7.W),D0                 ; $024124
        MOVE.L  $68(A7,D7.W),D0                 ; $024128
        MOVE.L  $7468.W,D0                      ; $02412C
        MOVE.L  $74683130,D0                    ; $024130
        MOVEQ   #$68,D2                         ; $024136
        MOVE.W  $68(A1,D7.W),-(A0)              ; $024138
        MOVE.W  $68(A2,D7.W),-(A0)              ; $02413C
        MOVE.W  $68(A3,D7.W),-(A0)              ; $024140
        MOVE.W  $68(A4,D7.W),-(A0)              ; $024144
        MOVE.W  $68(A5,D7.W),-(A0)              ; $024148
        MOVE.W  $68(A6,D7.W),-(A0)              ; $02414C
        MOVE.W  $68(A7,D7.W),-(A0)              ; $024150
        MOVE.W  $7468.W,-(A0)                   ; $024154
        MOVE.W  $74683230,-(A0)                 ; $024158
        MOVEQ   #$68,D2                         ; $02415E
        MOVE.W  $74(A1,D7.W),D1                 ; $024160
        MOVE.W  $64(A2,D6.L),D1                 ; $024164
        MOVE.W  $64(A3,D7.W),D1                 ; $024168
        MOVE.W  $68(A4,D7.W),D1                 ; $02416C
        MOVE.W  $68(A5,D7.W),D1                 ; $024170
        MOVE.W  $68(A6,D7.W),D1                 ; $024174
        MOVE.W  $68(A7,D7.W),D1                 ; $024178
        MOVE.W  $7468.W,D1                      ; $02417C
        MOVE.W  $74680102,D1                    ; $024180
        BTST    D1,D4                           ; $024186
        BTST    D2,D6                           ; $024188
        BTST    D3,D0                           ; $02418A
        DC.W    $090A               ; $02418C BTST    D4,A2
        DC.W    $0B0C               ; $02418E BTST    D5,A4
        DC.W    $0D0E               ; $024190 BTST    D6,A6
        BTST    D7,D0                           ; $024192
        MOVE.B  (A2),-(A0)                      ; $024194
        MOVE.B  (A4),-(A1)                      ; $024196
        MOVE.B  (A6),-(A2)                      ; $024198
        MOVE.B  D0,-(A3)                        ; $02419A
loc_02419C:
        MOVE.B  (A2)+,-(A4)                     ; $02419C
        MOVE.B  (A4)+,-(A5)                     ; $02419E
loc_0241A0:
        MOVE.B  (A6)+,-(A6)                     ; $0241A0
        MOVE.B  D0,-(A7)                        ; $0241A2
        DC.W    $4F22               ; $0241A4 DC.W    $4F22
        ADD.B  A3,D6                            ; $0241A6
        SUB.B  D6,(A1)                          ; $0241A8
        SVS     -(A1)                           ; $0241AA
        SUB.B  (A0),D0                          ; $0241AC
        MOVE.W  A4,-(A4)                        ; $0241AE
        DIVS    -(A0),D2                        ; $0241B0
        NEGX.B (A1)                             ; $0241B2
        OR.B   D5,(A0)                          ; $0241B4
        BMI.S  loc_0241BB                       ; $0241B6
        BRA.S  loc_02417E                       ; $0241B8
        OR.B   D0,D4                            ; $0241BA
        OR.B   D4,D1                            ; $0241BC
        CMP.B  (A3),D0                          ; $0241BE
        DC.W    $0009,$4B10         ; $0241C0 ORI.B  #$4B10,A1
        DIVS    $7908.W,D7                      ; $0241C4
        DC.W    $4F26               ; $0241C8 DC.W    $4F26
        DC.W    $000B,$0009         ; $0241CA ORI.B  #$0009,A3
        DC.W    $0200,$0400         ; $0241CE ANDI.B  #$0400,D0
        DC.W    $0000,$C000         ; $0241D2 ORI.B  #$C000,D0
        DC.W    $0000,$600B         ; $0241D6 ORI.B  #$600B,D0
        ROL.B  #5,D4                            ; $0241DA
        MOVE.W  A0,-(A5)                        ; $0241DC
        MOVE.W  A4,D6                           ; $0241DE
        DC.W    $4008               ; $0241E0 NEGX.B A0
        NEGX.B D0                               ; $0241E2
        DC.W    $AFE8,$390C         ; $0241E4 MOVE.L  $390C(A0),<EA:3F>
        ADD.B  D7,D5                            ; $0241E8
        NEGX.B (A0)+                            ; $0241EA
        NEGX.B D1                               ; $0241EC
        MOVE.W  A4,D5                           ; $0241EE
        BSR.S  loc_024185                       ; $0241F0
        LSL.B  #3,D6                            ; $0241F2
        BHI.S  loc_02419C                       ; $0241F4
        MOVE.B  -(A0),-(A0)                     ; $0241F6
        BHI.S  loc_0241A0                       ; $0241F8
        MOVE.B  -(A1),-(A0)                     ; $0241FA
        DC.W    $4710               ; $0241FC DC.W    $4710
        DIVS    $31DC000B,D7                    ; $0241FE
