; Generated assembly for $2B2200-$2B4200
; Branch targets: 69
; Labels: 63
; Format: DC.W with decoded mnemonics as comments

        org     $2B2200

        DC.W    $0210,$0500         ; $2B2200 ANDI.B  #$0500,(A0)
        BTST    D2,$20(A0,D0.W)                 ; $2B2204
        SUBI.B  #$0400,(A0)                     ; $2B2208
        BTST    D2,D0                           ; $2B220C
        DC.W    $04F0               ; $2B220E DC.W    $04F0
        DC.W    $0010,$6500         ; $2B2210 ORI.B  #$6500,(A0)
        BCHG    D2,D0                           ; $2B2214
        BCHG    D2,(A0)                         ; $2B2216
        BCHG    D2,-(A0)                        ; $2B2218
        BCHG    D2,$10(A0,D0.W)                 ; $2B221A
        BLS.W  loc_2B27B0                       ; $2B221E
        BCLR    D2,D0                           ; $2B2222
        SUBI.B  #$6400,(A0)                     ; $2B2224
        BCHG    D2,-(A0)                        ; $2B2228
        BCHG    D2,(A0)                         ; $2B222A
        DC.W    $0000,$6600         ; $2B222C ORI.B  #$6600,D0
        SUBI.L  #$04B004C0,-(A0)                ; $2B2230
        DC.W    $04D0               ; $2B2236 DC.W    $04D0
        DC.W    $0000,$6600         ; $2B2238 ORI.B  #$6600,D0
        BCLR    D2,-(A0)                        ; $2B223C
        BCLR    D2,-$40(A0,D0.W)                ; $2B223E
        BSET    D2,(A0)                         ; $2B2242
        CMPI.B  #$005E,D0                       ; $2B2244
        ORI.W  #$F827,(A6)+                     ; $2B2248
        DC.W    $030A               ; $2B224C BTST    D1,A2
        MOVE.W  A0,(A7)+                        ; $2B224E
        MOVE.W  $2F(A3,D0.W),(A4)+              ; $2B2250
        DC.W    $FDFF               ; $2B2254 MOVE.W  <EA:3F>,<EA:3E>
        MOVEA.W D5,A4                           ; $2B2256
        SUBI.W  #$FD5D,(A5)+                    ; $2B2258
        MOVE.W  (A1),$0431(A3)                  ; $2B225C
        MOVEA.W A6,A7                           ; $2B2260
        MOVE.W  (A4)+,$03A0(A4)                 ; $2B2262
        DC.W    $FE7D               ; $2B2266 MOVEA.W <EA:3D>,A7
        MOVE.W  D5,(A4)+                        ; $2B2268
        DC.W    $04E8               ; $2B226A DC.W    $04E8
        DC.W    $FDF8,$F890         ; $2B226C MOVE.W  $F890.W,<EA:3E>
        BCHG    D1,$46(PC,A7.L)                 ; $2B2270
        MOVE.W  (A1),-$44(PC,D0.W)              ; $2B2274
        MOVE.W  -$0817(A1),(A7)+                ; $2B2278
        DC.W    $04C5               ; $2B227C DC.W    $04C5
        MOVE.W  (A1),(A7)                       ; $2B227E
        MOVE.W  (A4),$5C(PC,D0.W)               ; $2B2280
        DC.W    $FDE9,$F759         ; $2B2284 MOVE.W  -$08A7(A1),<EA:3E>
        BTST    D2,-$026D(A7)                   ; $2B2288
        MOVE.W  D7,$6D(A3,D0.W)                 ; $2B228C
        MOVEA.W A4,A7                           ; $2B2290
        MOVEA.W -(A6),A4                        ; $2B2292
        DC.W    $04DC               ; $2B2294 DC.W    $04DC
        MOVE.W  (A5),D7                         ; $2B2296
        MOVE.W  D4,D4                           ; $2B2298
        BCLR    D2,D4                           ; $2B229A
        DC.W    $FDD0               ; $2B229C MOVE.W  (A0),<EA:3E>
        MOVE.W  $0472(A7),-$016B(A3)            ; $2B229E
        MOVE.W  -(A5),$0467(A3)                 ; $2B22A4
        MOVE.W  A0,-(A7)                        ; $2B22A8
        MOVE.W  $09(A5,D0.W),-$00B6(A3)         ; $2B22AA
        MOVE.W  D0,-$0C(A3,D0.W)                ; $2B22B0
        MOVE.W  (A6)+,(A7)+                     ; $2B22B4
        MOVE.W  A0,-$7E(PC,D0.W)                ; $2B22B6
        MOVE.W  (A3),(A7)+                      ; $2B22BA
        MOVE.W  (A2)+,$05(PC,D0.W)              ; $2B22BC
        MOVE.W  (A4)+,-(A7)                     ; $2B22C0
        MOVE.W  -(A7),$62(PC,D0.W)              ; $2B22C2
        MOVE.W  -$0842(A2),-(A7)                ; $2B22C6
        BCHG    D1,D2                           ; $2B22CA
        MOVE.W  -$0959(A3),$0319(A7)            ; $2B22CC
        MOVE.W  -(A7),(A7)                      ; $2B22D2
        MOVE.W  (A4),(A3)                       ; $2B22D4
        BTST    D1,$3C(A1,A7.L)                 ; $2B22D6
        MOVE.W  $0310(A0),$39(PC,A7.L)          ; $2B22DA
        MOVE.W  (A6),(A3)                       ; $2B22E0
        DC.W    $02DE               ; $2B22E2 DC.W    $02DE
        MOVEA.W A2,A7                           ; $2B22E4
        MOVE.W  $0335(A7),(A4)+                 ; $2B22E6
        MOVE.W  $59(A7,A7.L),$0356(A6)          ; $2B22EA
        MOVE.W  -(A7),-$0710(A6)                ; $2B22F0
        DC.W    $04A9,$FD7D,$F87D,$04A7; $2B22F4 SUBI.L  #$FD7DF87D,$04A7(A1)
        MOVE.W  (A1),$33(A6,A7.L)               ; $2B22FC
        BCHG    D1,D3                           ; $2B2300
        DC.W    $FDCE               ; $2B2302 MOVE.W  A6,<EA:3E>
        MOVE.W  D1,(A4)+                        ; $2B2304
        DC.W    $04B6,$FDE7,$F845,$0327; $2B2306 SUBI.L  #$FDE7F845,$27(A6,D0.W)
        MOVE.W  A6,(A6)                         ; $2B230E
        MOVE.W  $2B(A3,D0.W),(A4)               ; $2B2310
        MOVE.W  (A7)+,(A6)                      ; $2B2314
        MOVE.W  -$71(A0,D0.W),-$0256(A4)        ; $2B2316
        MOVE.W  $03A2(A4),-(A4)                 ; $2B231C
        DC.W    $FDD3               ; $2B2320 MOVE.W  (A3),<EA:3E>
        MOVEA.W -(A6),A4                        ; $2B2322
        DC.W    $02DB               ; $2B2324 DC.W    $02DB
        MOVE.W  (A4),(A6)                       ; $2B2326
        MOVE.W  A4,$0356(A4)                    ; $2B2328
        DC.W    $FDDA               ; $2B232C MOVE.W  (A2)+,<EA:3E>
        MOVE.W  (A4),-$3D(A3,D0.W)              ; $2B232E
        MOVEA.W -$77(A7,A7.W),A6                ; $2B2332
        DC.W    $02E1               ; $2B2336 DC.W    $02E1
        MOVE.W  D5,D6                           ; $2B2338
        MOVE.W  D3,(A4)+                        ; $2B233A
        ANDI.W  #$FCB0,-$0731(PC)               ; $2B233C
        BCHG    D1,(A5)+                        ; $2B2342
        MOVE.W  -(A1),-(A6)                     ; $2B2344
        MOVE.W  (A1)+,(A3)                      ; $2B2346
        BCLR    D0,-(A4)                        ; $2B2348
        MOVE.W  D0,-(A6)                        ; $2B234A
        MOVEA.W D2,A3                           ; $2B234C
        DC.W    $0205,$FDDC         ; $2B234E ANDI.B  #$FDDC,D5
        DC.W    $F77D,$019E         ; $2B2352 MOVE.W  <EA:3D>,$019E(A3)
        MOVE.W  D7,(A7)                         ; $2B2356
        MOVE.W  (A4),$3E(PC,D0.W)               ; $2B2358
        MOVE.W  -$08E0(A4),$00(A6,D0.W)         ; $2B235C
        DC.W    $FC3E               ; $2B2362 MOVE.W  <EA:3E>,D6
        MOVEA.W (A4)+,A4                        ; $2B2364
        BCLR    D0,(A1)+                        ; $2B2366
        MOVE.W  -$08C3(A1),(A6)+                ; $2B2368
        SUBI.B  #$FD51,-(A3)                    ; $2B236C
        MOVEA.W $03BD.W,A4                      ; $2B2370
        DC.W    $FDFC,$F64D         ; $2B2374 MOVE.W  #$F64D,<EA:3E>
        DC.W    $02E8               ; $2B2378 DC.W    $02E8
        MOVEA.W A5,A7                           ; $2B237A
        MOVE.W  A1,-$7E(A3,D0.W)                ; $2B237C
        MOVE.W  $F6B6.W,(A7)+                   ; $2B2380
        DC.W    $03C8               ; $2B2384 BSET    D1,A0
        MOVE.W  (A5),D7                         ; $2B2386
        MOVE.W  $62(A1,D0.W),-$41(PC,A7.L)      ; $2B2388
        MOVEA.W #$01D2,A4                       ; $2B238E
        MOVE.W  -(A0),-$0672(A7)                ; $2B2392
        BSET    D0,(A0)                         ; $2B2396
        DC.W    $FE7F               ; $2B2398 MOVEA.W <EA:3F>,A7
        MOVE.W  D2,-(A4)                        ; $2B239A
        BTST    D1,-$01FB(A6)                   ; $2B239C
        MOVE.W  -(A1),D4                        ; $2B23A0
        BTST    D1,-$0143(A7)                   ; $2B23A2
        MOVE.W  $26(A5,D0.W),#$FEFD             ; $2B23A6
        MOVE.W  $0384(A2),-$017C(A4)            ; $2B23AC
        MOVE.W  -(A5),(A4)+                     ; $2B23B2
        DC.W    $0228,$FFDE,$F88A   ; $2B23B4 ANDI.B  #$FFDE,-$0776(A0)
        BCLR    D1,D5                           ; $2B23BA
        MOVE.W  -$24(PC,A7.W),-(A7)             ; $2B23BC
        BSET    D0,D5                           ; $2B23C0
        MOVE.W  -$37(A5,A7.W),D7                ; $2B23C2
        BCHG    D0,-(A3)                        ; $2B23C6
        DC.W    $FEBD               ; $2B23C8 MOVE.W  <EA:3D>,(A7)
        MOVE.W  #$024A,-(A4)                    ; $2B23CA
        MOVE.W  (A1)+,$4F(A7,A7.L)              ; $2B23CE
        DC.W    $02AD,$FF10,$F780,$01F8; $2B23D2 ANDI.L  #$FF10F780,$01F8(A5)
        MOVE.W  (A1)+,(A7)                      ; $2B23DA
        MOVE.W  -$20(A4,D0.W),(A4)+             ; $2B23DC
        MOVE.W  -$5A(A4,A7.W),$0018(A7)         ; $2B23E0
        MOVE.W  -$0829(PC),(A7)+                ; $2B23E6
        ORI.W  #$FF58,A1                        ; $2B23EA
        MOVE.W  (A1),-$4A(PC,D0.W)              ; $2B23EE
        MOVE.W  (A3)+,(A7)                      ; $2B23F2
        MOVE.W  -(A1),-$7B(A3,D0.W)             ; $2B23F4
        DC.W    $FE3F               ; $2B23F8 MOVE.W  <EA:3F>,D7
        MOVE.W  -(A6),$003C(A3)                 ; $2B23FA
        MOVE.W  D2,-$089F(A7)                   ; $2B23FE
        BCLR    D0,-$0179(A0)                   ; $2B2402
        MOVE.W  D5,-(A3)                        ; $2B2406
        DC.W    $002D,$FE91,$F705   ; $2B2408 ORI.B  #$FE91,-$08FB(A5)
        DC.W    $FFF2,$FE91         ; $2B240E MOVE.W  -$6F(A2,A7.L),<EA:3F>
        MOVE.W  (A4),-$0E(PC,A7.L)              ; $2B2412
        MOVE.W  (A7),-$082C(A7)                 ; $2B2416
        ORI.W  #$FF57,A6                        ; $2B241A
        MOVE.W  -(A5),-(A4)                     ; $2B241E
        DC.W    $02C4               ; $2B2420 DC.W    $02C4
        MOVE.W  (A2)+,-(A7)                     ; $2B2422
        MOVE.W  -(A7),$5D(A4,D0.W)              ; $2B2424
        DC.W    $FF3D               ; $2B2428 MOVE.W  <EA:3D>,-(A7)
        MOVE.W  (A7)+,(A4)+                     ; $2B242A
        BTST    D0,D2                           ; $2B242C
        MOVE.W  -(A5),D7                        ; $2B242E
        MOVEA.W (A5)+,A4                        ; $2B2430
        BCHG    D0,-$01FD(A1)                   ; $2B2432
        MOVE.W  (A5),-$33(A4,D0.W)              ; $2B2436
        DC.W    $FEBF               ; $2B243A MOVE.W  <EA:3F>,(A7)
        MOVE.W  A4,(A4)+                        ; $2B243C
        BCHG    D0,-$59(A1,A7.L)                ; $2B243E
        MOVEA.W $00F7(A5),A4                    ; $2B2442
        DC.W    $FDEB,$F8B8         ; $2B2446 MOVE.W  -$0748(A3),<EA:3E>
        DC.W    $014C               ; $2B244A BCHG    D0,A4
        DC.W    $FDFD               ; $2B244C MOVE.W  <EA:3D>,<EA:3E>
        MOVE.W  (A4),$58(A4,D0.W)               ; $2B244E
        MOVE.W  $49(A2,A7.L),(A7)+              ; $2B2452
        DC.W    $0002,$FEE0         ; $2B2456 ORI.B  #$FEE0,D2
        DC.W    $F8BD               ; $2B245A MOVE.W  <EA:3D>,(A4)
        DC.W    $00FD               ; $2B245C DC.W    $00FD
        MOVE.W  -$0667(A1),$08(A6,D0.W)         ; $2B245E
        MOVE.W  (A6)+,(A7)                      ; $2B2464
        MOVE.W  -$0058(A6),(A4)+                ; $2B2466
        MOVEA.W (A2),A7                         ; $2B246A
        MOVE.W  A1,-(A4)                        ; $2B246C
        MOVE.W  $63(A6,A7.L),-$0642(A7)         ; $2B246E
        DC.W    $0009,$FF08         ; $2B2474 ORI.B  #$FF08,A1
        MOVE.W  (A5),$59(A4,D0.W)               ; $2B2478
        MOVE.W  $0010(A6),(A7)+                 ; $2B247C
        BTST    D2,D0                           ; $2B2480
        ANDI.W  #$0270,-(A0)                    ; $2B2482
        ANDI.L  #$02900210,D0                   ; $2B2486
        ADDI.B  #$0310,D0                       ; $2B248C
        BTST    D1,D0                           ; $2B2490
        SUBI.B  #$0500,(A0)                     ; $2B2492
        BCHG    D1,(A0)                         ; $2B2496
        BCHG    D1,D0                           ; $2B2498
        SUBI.B  #$0600,(A0)                     ; $2B249A
        BTST    D1,$20(A0,D0.W)                 ; $2B249E
        SUBI.B  #$0500,(A0)                     ; $2B24A2
        DC.W    $02C0               ; $2B24A6 DC.W    $02C0
        DC.W    $02B0,$0610,$0300,$0350; $2B24A8 ANDI.L  #$06100300,$50(A0,D0.W)
        DC.W    $02D0               ; $2B24B0 DC.W    $02D0
        DC.W    $0210,$0600         ; $2B24B2 ANDI.B  #$0600,(A0)
        ANDI.L  #$02B00610,-(A0)                ; $2B24B6
        BTST    D2,D0                           ; $2B24BC
        DC.W    $02F0               ; $2B24BE DC.W    $02F0
        DC.W    $02E0               ; $2B24C0 DC.W    $02E0
        ADDI.B  #$0300,(A0)                     ; $2B24C2
        BCHG    D1,(A0)                         ; $2B24C6
        BTST    D1,(A0)                         ; $2B24C8
        DC.W    $0210,$0300         ; $2B24CA ANDI.B  #$0300,(A0)
        ANDI.L  #$02800210,(A0)                 ; $2B24CE
        ADDI.B  #$0270,D0                       ; $2B24D4
        DC.W    $02E0               ; $2B24D8 DC.W    $02E0
        SUBI.B  #$0300,(A0)                     ; $2B24DA
        ANDI.W  #$0300,-(A0)                    ; $2B24DE
        DC.W    $0210,$0300         ; $2B24E2 ANDI.B  #$0300,(A0)
        BCHG    D1,D0                           ; $2B24E6
        ANDI.L  #$04100300,-(A0)                ; $2B24E8
        BTST    D1,-(A0)                        ; $2B24EE
        DC.W    $02B0,$0010,$6E00,$0000; $2B24F0 ANDI.L  #$00106E00,$00(A0,D0.W)
        DC.W    $0010,$0020         ; $2B24F8 ORI.B  #$0020,(A0)
        DC.W    $0030,$0610,$6F00   ; $2B24FC ORI.B  #$0610,$00(A0,D6.L)
        ORI.W  #$0050,D0                        ; $2B2502
        SUBI.B  #$7000,(A0)                     ; $2B2506
        ORI.W  #$0070,-(A0)                     ; $2B250A
        SUBI.B  #$6F00,(A0)                     ; $2B250E
        DC.W    $0000,$0030         ; $2B2512 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2B2516 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2B251A ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2B251E ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2B2522
        DC.W    $00B0,$0210,$0400,$00D0; $2B2528 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2B2530 DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2B2532
        ORI.L  #$00900611,-(A0)                 ; $2B2536
        BTST    D3,D1                           ; $2B253C
        DC.W    $00B0,$0010,$6A00,$00E0; $2B253E ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2B2546 DC.W    $00F0
        BTST    D0,D0                           ; $2B2548
        BTST    D0,(A0)                         ; $2B254A
        DC.W    $0210,$6C00         ; $2B254C ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2B2550
        SUBI.B  #$6B00,(A0)                     ; $2B2554
        BTST    D0,D0                           ; $2B2558
        DC.W    $00F0               ; $2B255A DC.W    $00F0
        DC.W    $0211,$6901         ; $2B255C ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2B2560 DC.W    $00E0
        DC.W    $0010,$6300         ; $2B2562 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2B2566
        BCHG    D0,(A0)                         ; $2B2568
        BCHG    D0,-(A0)                        ; $2B256A
        BCHG    D0,$10(A0,D0.W)                 ; $2B256C
        BCS.W  loc_2B2702                       ; $2B2570
        BCLR    D0,D0                           ; $2B2574
        SUBI.B  #$6400,(A0)                     ; $2B2576
        BCHG    D0,-(A0)                        ; $2B257A
        BCHG    D0,(A0)                         ; $2B257C
        ADDI.B  #$6201,(A1)                     ; $2B257E
        BCHG    D0,$10(A0,D0.W)                 ; $2B2582
        BPL.W  loc_2B2728                       ; $2B2586
        BCLR    D0,-$40(A0,D0.W)                ; $2B258A
        BSET    D0,(A0)                         ; $2B258E
        DC.W    $0210,$6C00         ; $2B2590 ANDI.B  #$6C00,(A0)
        BSET    D0,-$20(A0,D0.W)                ; $2B2594
        SUBI.B  #$6B00,(A0)                     ; $2B2598
        BSET    D0,D0                           ; $2B259C
        BCLR    D0,$11(A0,D0.W)                 ; $2B259E
        BVS.S  loc_2B25A5                       ; $2B25A2
        BSET    D0,(A0)                         ; $2B25A4
        DC.W    $0010,$6300         ; $2B25A6 ORI.B  #$6300,(A0)
        DC.W    $0200,$0210         ; $2B25AA ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2B25AE ANDI.B  #$0230,-(A0)
        DC.W    $0210,$6500         ; $2B25B2 ANDI.B  #$6500,(A0)
        ANDI.W  #$0240,(A0)                     ; $2B25B6
        SUBI.B  #$6400,(A0)                     ; $2B25BA
        DC.W    $0220,$0210         ; $2B25BE ANDI.B  #$0210,-(A0)
        DC.W    $0211,$6201         ; $2B25C2 ANDI.B  #$6201,(A1)
        DC.W    $0200,$0010         ; $2B25C6 ANDI.B  #$0010,D0
        BNE.W  loc_2B292C                       ; $2B25CA
        BCHG    D1,-$80(A0,D0.W)                ; $2B25CE
        BCLR    D1,(A0)                         ; $2B25D2
        ADDI.B  #$6700,(A0)                     ; $2B25D4
        BCLR    D1,-(A0)                        ; $2B25D8
        BCLR    D1,$10(A0,D0.W)                 ; $2B25DA
        BVC.W  loc_2B29A0                       ; $2B25DE
        BSET    D1,(A0)                         ; $2B25E2
        SUBI.B  #$6700,(A0)                     ; $2B25E4
        BCHG    D1,-(A0)                        ; $2B25E8
        BCLR    D1,(A0)                         ; $2B25EA
        DC.W    $0010,$0300         ; $2B25EC ORI.B  #$0300,(A0)
        BSET    D1,-(A0)                        ; $2B25F0
        BSET    D1,$00(A0,D0.W)                 ; $2B25F2
        SUBI.B  #$0210,(A0)                     ; $2B25F6
        BTST    D2,D0                           ; $2B25FA
        SUBI.B  #$0420,$10(A0,D0.W)             ; $2B25FC
        SUBI.B  #$0400,D0                       ; $2B2602
        BSET    D1,$10(A0,D0.W)                 ; $2B2606
        BCS.W  loc_2B2A4C                       ; $2B260A
        SUBI.W  #$0460,(A0)                     ; $2B260E
        SUBI.W  #$0210,$00(A0,D6.W)             ; $2B2612
        SUBI.L  #$04800410,(A0)                 ; $2B2618
        BCC.W  loc_2B2A80                       ; $2B261E
        SUBI.W  #$0010,(A0)                     ; $2B2622
        BTST    D1,D0                           ; $2B2626
        DC.W    $04E0               ; $2B2628 DC.W    $04E0
        DC.W    $04F0               ; $2B262A DC.W    $04F0
        BTST    D2,D0                           ; $2B262C
        BTST    D2,(A0)                         ; $2B262E
        DC.W    $0210,$0500         ; $2B2630 ANDI.B  #$0500,(A0)
        BTST    D2,$20(A0,D0.W)                 ; $2B2634
        SUBI.B  #$0400,(A0)                     ; $2B2638
        BTST    D2,D0                           ; $2B263C
        DC.W    $04F0               ; $2B263E DC.W    $04F0
        DC.W    $0010,$6500         ; $2B2640 ORI.B  #$6500,(A0)
        BCHG    D2,D0                           ; $2B2644
        BCHG    D2,(A0)                         ; $2B2646
        BCHG    D2,-(A0)                        ; $2B2648
        BCHG    D2,$10(A0,D0.W)                 ; $2B264A
        BLS.W  loc_2B2BE0                       ; $2B264E
        BCLR    D2,D0                           ; $2B2652
        SUBI.B  #$6400,(A0)                     ; $2B2654
        BCHG    D2,-(A0)                        ; $2B2658
        BCHG    D2,(A0)                         ; $2B265A
        DC.W    $0000,$6600         ; $2B265C ORI.B  #$6600,D0
        SUBI.L  #$04B004C0,-(A0)                ; $2B2660
        DC.W    $04D0               ; $2B2666 DC.W    $04D0
        DC.W    $0000,$6600         ; $2B2668 ORI.B  #$6600,D0
        BCLR    D2,-(A0)                        ; $2B266C
        BCLR    D2,-$40(A0,D0.W)                ; $2B266E
        BSET    D2,(A0)                         ; $2B2672
        CMPI.B  #$004E,D0                       ; $2B2674
        ORI.W  #$F860,A6                        ; $2B2678
        BSET    D0,D3                           ; $2B267C
        MOVE.W  (A1),(A7)                       ; $2B267E
        MOVE.W  -$1E(A7,D0.W),-$01B3(A4)        ; $2B2680
        MOVE.W  -$7F(A1,D0.W),-(A4)             ; $2B2686
        MOVE.W  -$1D(A7,A7.W),(A6)+             ; $2B268A
        ANDI.W  #$FD48,(A5)+                    ; $2B268E
        MOVE.W  $0291(PC),-$0154(A4)            ; $2B2692
        MOVE.W  $59(A6,D0.W),-(A4)              ; $2B2698
        MOVE.W  -$079C(A3),$0273(A6)            ; $2B269C
        MOVE.W  -$0819(A7),(A7)+                ; $2B26A2
        BTST    D1,-$44(A5,A7.L)                ; $2B26A6
        MOVE.W  $0327(A5),D4                    ; $2B26AA
        MOVE.W  D0,-$7C(A6,A7.L)                ; $2B26AE
        ANDI.L  #$FD29F842,A3                   ; $2B26B2
        BTST    D1,D3                           ; $2B26B8
        MOVEA.W A5,A6                           ; $2B26BA
        MOVE.W  $0386.W,-$2F(PC,A7.L)           ; $2B26BC
        MOVE.W  (A0)+,(A4)+                     ; $2B26C2
        BTST    D1,-$02A8(PC)                   ; $2B26C4
        MOVE.W  -(A3),(A4)                      ; $2B26C8
        BCLR    D1,(A1)+                        ; $2B26CA
        MOVE.W  -$083D(A0),(A6)                 ; $2B26CC
        ANDI.L  #$FD72F785,-(A0)                ; $2B26D0
        DC.W    $02D4               ; $2B26D6 DC.W    $02D4
        DC.W    $FDC4               ; $2B26D8 MOVE.W  D4,<EA:3E>
        MOVE.W  D3,$01DF(A3)                    ; $2B26DA
        DC.W    $FEBD               ; $2B26DE MOVE.W  <EA:3D>,(A7)
        MOVE.W  #$0194,-$017E(A3)               ; $2B26E0
        MOVE.W  $02DE.W,-$43(PC,A7.L)           ; $2B26E6
        MOVE.W  -$2E(A1,D0.W),-$33(A3,A7.L)     ; $2B26EC
        MOVE.W  D2,$27(PC,D0.W)                 ; $2B26F2
        MOVE.W  -(A7),(A7)                      ; $2B26F6
        MOVE.W  #$022C,-$012C(A3)               ; $2B26F8
        MOVE.W  (A3)+,(A3)+                     ; $2B26FE
        BCHG    D0,-$0218(A7)                   ; $2B2700
        MOVE.W  #$0143,(A3)+                    ; $2B2704
        MOVE.W  A0,-$4E(A6,A7.W)                ; $2B2708
        BSET    D0,-$011E(A5)                   ; $2B270C
        MOVE.W  $0108(A5),(A3)+                 ; $2B2710
        DC.W    $FDC2               ; $2B2714 MOVE.W  D2,<EA:3E>
        MOVE.W  A6,-(A4)                        ; $2B2716
        BSET    D0,D7                           ; $2B2718
        MOVE.W  $7B(A2,A7.L),$01BE(A6)          ; $2B271A
        MOVE.W  D7,-$5D(A6,A7.L)                ; $2B2720
        BTST    D1,(A2)+                        ; $2B2724
        MOVE.W  D4,-$06C6(A6)                   ; $2B2726
        BCHG    D1,D2                           ; $2B272A
        MOVE.W  -$06CB(A1),-(A6)                ; $2B272C
        BSET    D0,(A7)                         ; $2B2730
        DC.W    $FDD9               ; $2B2732 MOVE.W  (A1)+,<EA:3E>
        MOVE.W  -(A0),$0351(A4)                 ; $2B2734
        MOVE.W  (A1),-$4E(A6,A7.L)              ; $2B2738
        BTST    D0,-(A4)                        ; $2B273C
        MOVE.W  D7,(A6)                         ; $2B273E
        MOVE.W  (A2),-(A4)                      ; $2B2740
        BTST    D0,-(A6)                        ; $2B2742
        DC.W    $FCBF               ; $2B2744 MOVE.W  <EA:3F>,(A6)
        MOVE.W  A3,-$04(A4,D0.W)                ; $2B2746
        MOVE.W  -$06BC(A6),$28(A6,D0.W)         ; $2B274A
        MOVE.W  -$0747(A1),-$1B(A6,D0.W)        ; $2B2750
        MOVE.W  #$F94B,(A6)                     ; $2B2756
        BSET    D0,-$0220(A1)                   ; $2B275A
        MOVEA.W $00D0(A2),A4                    ; $2B275E
        MOVE.W  -(A5),-$0638(A7)                ; $2B2762
        DC.W    $00E2               ; $2B2766 DC.W    $00E2
        MOVE.W  $78(A7,A7.L),-(A7)              ; $2B2768
        DC.W    $0209,$FE3C         ; $2B276C ANDI.B  #$FE3C,A1
        MOVEA.W (A2)+,A4                        ; $2B2770
        BSET    D0,-$019D(PC)                   ; $2B2772
        MOVE.W  (A4),#$015C                     ; $2B2776
        DC.W    $FFC2               ; $2B277A MOVE.W  D2,<EA:3F>
        MOVE.W  D5,-$7D(A4,D0.W)                ; $2B277C
        MOVE.W  D7,(A7)+                        ; $2B2780
        MOVEA.W $4A(A6,D0.W),A4                 ; $2B2782
        DC.W    $FFF0,$F866         ; $2B2786 MOVE.W  $66(A0,A7.L),<EA:3F>
        ANDI.W  #$FEED,$65(A4,A7.L)             ; $2B278A
        DC.W    $014B               ; $2B2790 BCHG    D0,A3
        DC.W    $FDE7               ; $2B2792 MOVE.W  -(A7),<EA:3E>
        MOVE.W  $00FC(A3),$3F(PC,A7.L)          ; $2B2794
        MOVE.W  -(A0),(A4)+                     ; $2B279A
        DC.W    $014C               ; $2B279C BCHG    D0,A4
        DC.W    $FFDF               ; $2B279E MOVE.W  (A7)+,<EA:3F>
        MOVE.W  (A3)+,$019B(A4)                 ; $2B27A0
        MOVE.W  D7,-$06(A7,A7.W)                ; $2B27A4
        BCLR    D0,-(A1)                        ; $2B27A8
        MOVE.W  (A6),D7                         ; $2B27AA
        MOVE.W  $01F0(A7),(A4)+                 ; $2B27AC
loc_2B27B0:
        MOVE.W  -$47(A6,A7.W),-$0E(A7,A7.L)     ; $2B27B0
        MOVE.W  (A3),-(A7)                      ; $2B27B6
        MOVE.W  (A7),$48(PC,D0.W)               ; $2B27B8
        MOVE.W  (A1)+,-$07F7(A7)                ; $2B27BC
        BTST    D0,$12(PC,A7.L)                 ; $2B27C0
        MOVE.W  $00E4(A3),-$34(PC,A7.L)         ; $2B27C4
        MOVE.W  $002E(A5),-$00CB(A3)            ; $2B27CA
        MOVE.W  (A6)+,$20(A3,D0.W)              ; $2B27D0
        DC.W    $FDEE,$F716         ; $2B27D4 MOVE.W  -$08EA(A6),<EA:3E>
        DC.W    $FFEE,$FE94         ; $2B27D8 MOVE.W  -$016C(A6),<EA:3F>
        MOVE.W  (A6),-(A3)                      ; $2B27DC
        MOVE.W  -$5B(A6,A7.L),-$2C(A7,A7.W)     ; $2B27DE
        DC.W    $FFF4,$FF72         ; $2B27E4 MOVE.W  $72(A4,A7.L),<EA:3F>
        MOVE.W  (A4),$4C(PC,D0.W)               ; $2B27E8
        MOVE.W  (A7),-$06F2(A7)                 ; $2B27EC
        BSET    D0,(A3)                         ; $2B27F0
        DC.W    $FFBF,$F971         ; $2B27F2 MOVE.W  <EA:3F>,$71(A7,A7.L)
        DC.W    $014A               ; $2B27F6 BCHG    D0,A2
        DC.W    $FFC9               ; $2B27F8 MOVE.W  A1,<EA:3F>
        MOVE.W  (A4)+,$0115(A4)                 ; $2B27FA
        DC.W    $FDE3               ; $2B27FE MOVE.W  -(A3),<EA:3E>
        MOVE.W  $019E.W,(A4)+                   ; $2B2800
        DC.W    $FDD9               ; $2B2804 MOVE.W  (A1)+,<EA:3E>
        MOVE.W  (A4)+,-$13(A4,D0.W)             ; $2B2806
        MOVE.W  -$79(A6,A7.L),-$48(A7,D0.W)     ; $2B280A
        DC.W    $FDCF               ; $2B2810 MOVE.W  A7,<EA:3E>
        MOVE.W  -(A2),-(A4)                     ; $2B2812
        BTST    D0,(A0)                         ; $2B2814
        MOVE.W  D6,$4B(A6,A7.L)                 ; $2B2816
        BCHG    D0,-(A4)                        ; $2B281A
        DC.W    $FDC8               ; $2B281C MOVE.W  A0,<EA:3E>
        MOVE.W  (A0),$57(A4,D0.W)               ; $2B281E
        MOVE.W  $67(A6,A7.L),(A7)+              ; $2B2822
        DC.W    $0002,$FEB4         ; $2B2826 ORI.B  #$FEB4,D2
        MOVE.W  A0,$22(A4,D0.W)                 ; $2B282A
        DC.W    $FD7F,$F9CC         ; $2B282E MOVE.W  <EA:3F>,-$0634(A6)
        DC.W    $0014,$FEAD         ; $2B2832 ORI.B  #$FEAD,(A4)
        MOVE.W  -$63(A7,A7.L),-(A4)             ; $2B2836
        MOVE.W  -$06C4(A4),D7                   ; $2B283A
        MOVE.W  -$01B3(A4),-$0662(A7)           ; $2B283E
        DC.W    $000C,$FF25         ; $2B2844 ORI.B  #$FF25,A4
        MOVE.W  (A6),$58(A4,D0.W)               ; $2B2848
        MOVE.W  $10(A1,D0.W),(A7)+              ; $2B284C
        BGT.W  loc_2B2852                       ; $2B2850
        DC.W    $0010,$0020         ; $2B2854 ORI.B  #$0020,(A0)
        DC.W    $0030,$0610,$6F00   ; $2B2858 ORI.B  #$0610,$00(A0,D6.L)
        ORI.W  #$0050,D0                        ; $2B285E
        SUBI.B  #$7000,(A0)                     ; $2B2862
        ORI.W  #$0070,-(A0)                     ; $2B2866
        SUBI.B  #$6F00,(A0)                     ; $2B286A
        DC.W    $0000,$0030         ; $2B286E ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2B2872 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2B2876 ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2B287A ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2B287E
        DC.W    $00B0,$0210,$0400,$00D0; $2B2884 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2B288C DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2B288E
        ORI.L  #$00900611,-(A0)                 ; $2B2892
        BTST    D3,D1                           ; $2B2898
        DC.W    $00B0,$0010,$6A00,$00E0; $2B289A ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2B28A2 DC.W    $00F0
        BTST    D0,D0                           ; $2B28A4
        BTST    D0,(A0)                         ; $2B28A6
        DC.W    $0210,$6C00         ; $2B28A8 ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2B28AC
        SUBI.B  #$6B00,(A0)                     ; $2B28B0
        BTST    D0,D0                           ; $2B28B4
        DC.W    $00F0               ; $2B28B6 DC.W    $00F0
        DC.W    $0211,$6901         ; $2B28B8 ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2B28BC DC.W    $00E0
        DC.W    $0010,$6300         ; $2B28BE ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2B28C2
        BCHG    D0,(A0)                         ; $2B28C4
        BCHG    D0,-(A0)                        ; $2B28C6
        BCHG    D0,$10(A0,D0.W)                 ; $2B28C8
        BCS.W  loc_2B2A5E                       ; $2B28CC
        BCLR    D0,D0                           ; $2B28D0
        SUBI.B  #$6400,(A0)                     ; $2B28D2
        BCHG    D0,-(A0)                        ; $2B28D6
        BCHG    D0,(A0)                         ; $2B28D8
        ADDI.B  #$6201,(A1)                     ; $2B28DA
        BCHG    D0,$10(A0,D0.W)                 ; $2B28DE
        BPL.W  loc_2B2A84                       ; $2B28E2
        BCLR    D0,-$40(A0,D0.W)                ; $2B28E6
        BSET    D0,(A0)                         ; $2B28EA
        DC.W    $0210,$6C00         ; $2B28EC ANDI.B  #$6C00,(A0)
        BSET    D0,-$20(A0,D0.W)                ; $2B28F0
        SUBI.B  #$6B00,(A0)                     ; $2B28F4
        BSET    D0,D0                           ; $2B28F8
        BCLR    D0,$11(A0,D0.W)                 ; $2B28FA
        BVS.S  loc_2B2901                       ; $2B28FE
        BSET    D0,(A0)                         ; $2B2900
        DC.W    $0010,$6300         ; $2B2902 ORI.B  #$6300,(A0)
        DC.W    $0200,$0210         ; $2B2906 ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2B290A ANDI.B  #$0230,-(A0)
        DC.W    $0210,$6500         ; $2B290E ANDI.B  #$6500,(A0)
        ANDI.W  #$0240,(A0)                     ; $2B2912
        SUBI.B  #$6400,(A0)                     ; $2B2916
        DC.W    $0220,$0210         ; $2B291A ANDI.B  #$0210,-(A0)
        DC.W    $0211,$6201         ; $2B291E ANDI.B  #$6201,(A1)
        DC.W    $0200,$0010         ; $2B2922 ANDI.B  #$0010,D0
        BNE.W  loc_2B2B88                       ; $2B2926
        ANDI.W  #$0280,-$70(A0,D0.W)            ; $2B292A
        ADDI.B  #$6700,(A0)                     ; $2B2930
        ANDI.L  #$02B00410,-(A0)                ; $2B2934
        BVC.W  loc_2B2BFC                       ; $2B293A
        DC.W    $02D0               ; $2B293E DC.W    $02D0
        SUBI.B  #$6700,(A0)                     ; $2B2940
        ANDI.W  #$0290,-(A0)                    ; $2B2944
        DC.W    $0010,$0300         ; $2B2948 ORI.B  #$0300,(A0)
        DC.W    $02E0               ; $2B294C DC.W    $02E0
        DC.W    $02F0               ; $2B294E DC.W    $02F0
        BTST    D1,D0                           ; $2B2950
        BTST    D1,(A0)                         ; $2B2952
        DC.W    $0210,$0500         ; $2B2954 ANDI.B  #$0500,(A0)
        BTST    D1,$20(A0,D0.W)                 ; $2B2958
        SUBI.B  #$0400,(A0)                     ; $2B295C
        BTST    D1,D0                           ; $2B2960
        DC.W    $02F0               ; $2B2962 DC.W    $02F0
        DC.W    $0010,$6500         ; $2B2964 ORI.B  #$6500,(A0)
        BCHG    D1,D0                           ; $2B2968
        BCHG    D1,(A0)                         ; $2B296A
        BCHG    D1,-(A0)                        ; $2B296C
        BCHG    D1,$10(A0,D0.W)                 ; $2B296E
        BLS.W  loc_2B2D04                       ; $2B2972
        BCLR    D1,D0                           ; $2B2976
        SUBI.B  #$6400,(A0)                     ; $2B2978
        BCHG    D1,-(A0)                        ; $2B297C
        BCHG    D1,(A0)                         ; $2B297E
        DC.W    $0010,$0300         ; $2B2980 ORI.B  #$0300,(A0)
        BSET    D1,-(A0)                        ; $2B2984
        BSET    D1,$00(A0,D0.W)                 ; $2B2986
        SUBI.B  #$0210,(A0)                     ; $2B298A
        BTST    D2,D0                           ; $2B298E
        SUBI.B  #$0420,$10(A0,D0.W)             ; $2B2990
        SUBI.B  #$0400,D0                       ; $2B2996
        BSET    D1,$10(A0,D0.W)                 ; $2B299A
        BCS.W  loc_2B2DE0                       ; $2B299E
        SUBI.W  #$0460,(A0)                     ; $2B29A2
        SUBI.W  #$0210,$00(A0,D6.W)             ; $2B29A6
        SUBI.L  #$04800410,(A0)                 ; $2B29AC
        BCC.W  loc_2B2E14                       ; $2B29B2
        SUBI.W  #$0000,(A0)                     ; $2B29B6
        BNE.W  loc_2B2D5C                       ; $2B29BA
        BCLR    D1,-$40(A0,D0.W)                ; $2B29BE
        BSET    D1,(A0)                         ; $2B29C2
        DC.W    $0000,$6600         ; $2B29C4 ORI.B  #$6600,D0
        SUBI.L  #$04B004C0,-(A0)                ; $2B29C8
        DC.W    $04D0               ; $2B29CE DC.W    $04D0
        CMPI.B  #$004E,D0                       ; $2B29D0
        ORI.W  #$F91D,A6                        ; $2B29D4
        DC.W    $023F,$FE13         ; $2B29D8 ANDI.B  #$FE13,<EA:3F>
        MOVE.W  (A5)+,D5                        ; $2B29DC
        ANDI.W  #$FE97,A4                       ; $2B29DE
        MOVE.W  A4,(A5)+                        ; $2B29E2
        DC.W    $02F6               ; $2B29E4 DC.W    $02F6
        MOVE.W  -$0667(A6),$02E6(A6)            ; $2B29E6
        MOVE.W  (A0),(A6)+                      ; $2B29EC
        MOVE.W  $02F9(A1),#$FEEA                ; $2B29EE
        MOVE.W  A5,(A5)                         ; $2B29F4
        DC.W    $03CB               ; $2B29F6 BSET    D1,A3
        DC.W    $FDD4               ; $2B29F8 MOVE.W  (A4),<EA:3E>
        MOVE.W  $02EC(A1),(A4)+                 ; $2B29FA
        MOVEA.W -(A7),A7                        ; $2B29FE
        MOVE.W  (A2)+,$03BB(A4)                 ; $2B2A00
        MOVE.W  -$4B(A7,A7.L),-(A6)             ; $2B2A04
        BCLR    D1,-$02C9(A3)                   ; $2B2A08
        MOVE.W  $030A(A1),D5                    ; $2B2A0C
        MOVE.W  -(A4),-(A6)                     ; $2B2A10
        MOVE.W  A4,(A5)                         ; $2B2A12
        DC.W    $038A               ; $2B2A14 BCLR    D1,A2
        MOVEA.W (A2)+,A6                        ; $2B2A16
        MOVE.W  D3,D5                           ; $2B2A18
        SUBI.B  #$FC95,(A0)                     ; $2B2A1A
        MOVEA.W (A2),A5                         ; $2B2A1E
        BCLR    D1,-$78(A3,A7.L)                ; $2B2A20
        MOVE.W  -(A0),(A5)                      ; $2B2A24
        SUBI.B  #$FCE6,(A0)+                    ; $2B2A26
        MOVE.W  -$69(A3,D0.W),-$0304(A4)        ; $2B2A2A
        MOVE.W  D3,-(A4)                        ; $2B2A30
        DC.W    $037E               ; $2B2A32 BCHG    D1,<EA:3E>
        MOVE.W  D4,-(A6)                        ; $2B2A34
        MOVE.W  $021B(A4),(A4)+                 ; $2B2A36
        MOVE.W  -$06A5(A6),(A6)+                ; $2B2A3A
        DC.W    $0215,$FCE5         ; $2B2A3E ANDI.B  #$FCE5,(A5)
        MOVE.W  D3,$0395(A4)                    ; $2B2A42
        MOVE.W  -(A1),-$06D4(A6)                ; $2B2A46
        DC.W    $0212,$FD49         ; $2B2A4A ANDI.B  #$FD49,(A2)
        MOVE.W  D2,$0252(A4)                    ; $2B2A4E
        DC.W    $FCFF               ; $2B2A52 MOVE.W  <EA:3F>,(A6)+
        MOVE.W  $45(A0,D0.W),(A4)+              ; $2B2A54
        MOVE.W  D2,-(A6)                        ; $2B2A58
        MOVE.W  (A5)+,-(A4)                     ; $2B2A5A
        BTST    D0,(A5)                         ; $2B2A5C
loc_2B2A5E:
        MOVEA.W -$0688(A1),A6                   ; $2B2A5E
        DC.W    $00E1               ; $2B2A62 DC.W    $00E1
        MOVEA.W D5,A6                           ; $2B2A64
        MOVE.W  (A7)+,-(A4)                     ; $2B2A66
        DC.W    $022C,$FD41,$F955   ; $2B2A68 ANDI.B  #$FD41,-$06AB(A4)
        DC.W    $00BB,$FC87,$FAEC,$0217; $2B2A6E ORI.L  #$FC87FAEC,$17(PC,D0.W)
        MOVE.W  D5,D7                           ; $2B2A76
        MOVE.W  (A2)+,-(A5)                     ; $2B2A78
        DC.W    $023A,$FE64,$FAF5   ; $2B2A7A ANDI.B  #$FE64,-$050B(PC)
loc_2B2A80:
        DC.W    $038D               ; $2B2A80 BCLR    D1,A5
        DC.W    $FDFC,$FAC3         ; $2B2A82 MOVE.W  #$FAC3,<EA:3E>
        DC.W    $0389               ; $2B2A86 BCLR    D1,A1
        MOVE.W  (A4),-$53(A6,A7.L)              ; $2B2A88
        DC.W    $022C,$FE5E,$FA84   ; $2B2A8C ANDI.B  #$FE5E,-$057C(A4)
        BCLR    D1,(A5)+                        ; $2B2A92
        DC.W    $FDED,$FB9A         ; $2B2A94 MOVE.W  -$0466(A5),<EA:3E>
        DC.W    $0211,$FD1D         ; $2B2A98 ANDI.B  #$FD1D,(A1)
        MOVE.W  $0212(A1),-$74(A5,A7.L)         ; $2B2A9C
        MOVE.W  -(A1),(A5)+                     ; $2B2AA2
        ANDI.W  #$FE8F,-$5B(A5,A7.L)            ; $2B2AA4
        ANDI.L  #$FE59FB9D,A2                   ; $2B2AAA
        BSET    D0,D3                           ; $2B2AB0
        DC.W    $FD3D               ; $2B2AB2 MOVE.W  <EA:3D>,-(A6)
        MOVE.W  $023D(A0),(A5)                  ; $2B2AB4
        MOVEA.W $F8D8012B,A7                    ; $2B2AB8
        MOVE.W  (A0)+,(A7)                      ; $2B2ABE
        MOVE.W  (A3)+,D5                        ; $2B2AC0
        DC.W    $0149               ; $2B2AC2 BCHG    D0,A1
        MOVE.W  -(A2),-(A7)                     ; $2B2AC4
        MOVE.W  $02A1(A2),D5                    ; $2B2AC6
        MOVEA.W -(A0),A7                        ; $2B2ACA
        MOVE.W  -(A1),-(A4)                     ; $2B2ACC
        ANDI.L  #$FDEFF9D4,A0                   ; $2B2ACE
        BCLR    D0,(A7)+                        ; $2B2AD4
        MOVE.W  -$1C(A6,A7.L),-$09(A7,D0.W)     ; $2B2AD6
        MOVE.W  -$70(A3,A7.L),(A7)+             ; $2B2ADC
        BCLR    D0,D1                           ; $2B2AE0
        MOVE.W  -$0726(A4),-(A7)                ; $2B2AE2
        DC.W    $02DF               ; $2B2AE6 DC.W    $02DF
        MOVE.W  D3,(A7)                         ; $2B2AE8
        MOVE.W  (A5),-(A4)                      ; $2B2AEA
        DC.W    $FFED,$FED7         ; $2B2AEC MOVE.W  -$0129(A5),<EA:3F>
        MOVEA.W #$0014,A4                       ; $2B2AF0
        MOVE.W  (A5),-(A7)                      ; $2B2AF4
        DC.W    $F8FF               ; $2B2AF6 MOVE.W  <EA:3F>,(A4)+
        BSET    D0,-$00D4(A3)                   ; $2B2AF8
        MOVE.W  (A1)+,-$3D(A4,D0.W)             ; $2B2AFC
        MOVE.W  -$074F(A5),(A7)+                ; $2B2B00
        DC.W    $000E,$FE73         ; $2B2B04 ORI.B  #$FE73,A6
        MOVE.W  -$1C(A5,D0.W),-(A4)             ; $2B2B08
        MOVE.W  A2,(A7)                         ; $2B2B0C
        MOVE.W  -$0A(A2,A7.L),$21(A3,D0.W)      ; $2B2B0E
        MOVE.W  $0064(A5),$00(A3,D0.W)          ; $2B2B14
        MOVE.W  $17(PC,D0.W),(A4)               ; $2B2B1A
        MOVE.W  (A7),(A7)+                      ; $2B2B1E
        MOVE.W  D0,(A4)+                        ; $2B2B20
        MOVE.W  -$0109(A1),$6B(A7,A7.W)         ; $2B2B22
        DC.W    $000D,$FFDC         ; $2B2B28 ORI.B  #$FFDC,A5
        MOVEA.W $FFC1FEB1,A4                    ; $2B2B2C
        MOVE.W  -$7D(A0,A7.L),$4C(A3,A7.L)      ; $2B2B32
        MOVE.W  -$00A6(A1),$76(A3,A7.L)         ; $2B2B38
        MOVE.W  -(A1),$26(A3,D0.W)              ; $2B2B3E
        DC.W    $003D,$F7AC         ; $2B2B42 ORI.B  #$F7AC,<EA:3D>
        ORI.W  #$FFFC,-(A7)                     ; $2B2B46
        MOVE.W  (A7),$0241(A4)                  ; $2B2B4A
        MOVE.W  -$0689(A7),-(A7)                ; $2B2B4E
        BCLR    D0,-$006F(PC)                   ; $2B2B52
        MOVE.W  A6,D5                           ; $2B2B56
        DC.W    $00C0               ; $2B2B58 DC.W    $00C0
        MOVE.W  A1,D7                           ; $2B2B5A
        MOVE.W  $0146(A6),#$FDA6                ; $2B2B5C
        MOVE.W  (A5)+,#$023B                    ; $2B2B62
        MOVE.W  -(A6),-$058C(A7)                ; $2B2B66
        BCHG    D0,D0                           ; $2B2B6A
        DC.W    $FDDE               ; $2B2B6C MOVE.W  (A6)+,<EA:3E>
        MOVE.W  D4,D5                           ; $2B2B6E
        DC.W    $00A8,$FD9A,$FA25,$0104; $2B2B70 ORI.L  #$FD9AFA25,$0104(A0)
        DC.W    $FDD8               ; $2B2B78 MOVE.W  (A0)+,<EA:3E>
        MOVE.W  (A1),$59(A4,D0.W)               ; $2B2B7A
        MOVE.W  -$0691(A6),-(A7)                ; $2B2B7E
        DC.W    $FFFD               ; $2B2B82 MOVE.W  <EA:3D>,<EA:3F>
        MOVE.W  $63(A0,A7.L),(A7)+              ; $2B2B84
loc_2B2B88:
        ORI.L  #$FDC2F9CD,-(A4)                 ; $2B2B88
        DC.W    $FFF9,$FF17,$F99F   ; $2B2B8E MOVE.W  $FF17F99F,<EA:3F>
        MOVE.W  D6,$68(A7,A7.L)                 ; $2B2B94
        MOVE.W  (A5)+,$59(A4,A7.L)              ; $2B2B98
        MOVE.W  A6,(A7)                         ; $2B2B9C
        MOVE.W  (A2),$11(A4,D0.W)               ; $2B2B9E
        MOVE.W  -$066C(A0),$0059(A7)            ; $2B2BA2
        MOVE.W  $0010(A5),-(A7)                 ; $2B2BA8
        BGT.W  loc_2B2BAE                       ; $2B2BAC
        DC.W    $0010,$0020         ; $2B2BB0 ORI.B  #$0020,(A0)
        DC.W    $0030,$0610,$6F00   ; $2B2BB4 ORI.B  #$0610,$00(A0,D6.L)
        ORI.W  #$0050,D0                        ; $2B2BBA
        SUBI.B  #$7000,(A0)                     ; $2B2BBE
        ORI.W  #$0070,-(A0)                     ; $2B2BC2
        SUBI.B  #$6F00,(A0)                     ; $2B2BC6
        DC.W    $0000,$0030         ; $2B2BCA ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2B2BCE ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2B2BD2 ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2B2BD6 ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2B2BDA
loc_2B2BE0:
        DC.W    $00B0,$0210,$0400,$00D0; $2B2BE0 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2B2BE8 DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2B2BEA
        ORI.L  #$00900611,-(A0)                 ; $2B2BEE
        BTST    D3,D1                           ; $2B2BF4
        DC.W    $00B0,$0010,$6A00,$00E0; $2B2BF6 ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2B2BFE DC.W    $00F0
        BTST    D0,D0                           ; $2B2C00
        BTST    D0,(A0)                         ; $2B2C02
        DC.W    $0210,$6C00         ; $2B2C04 ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2B2C08
        SUBI.B  #$6B00,(A0)                     ; $2B2C0C
        BTST    D0,D0                           ; $2B2C10
        DC.W    $00F0               ; $2B2C12 DC.W    $00F0
        DC.W    $0211,$6901         ; $2B2C14 ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2B2C18 DC.W    $00E0
        DC.W    $0010,$6300         ; $2B2C1A ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2B2C1E
        BCHG    D0,(A0)                         ; $2B2C20
        BCHG    D0,-(A0)                        ; $2B2C22
        BCHG    D0,$10(A0,D0.W)                 ; $2B2C24
        BCS.W  loc_2B2DBA                       ; $2B2C28
        BCLR    D0,D0                           ; $2B2C2C
        SUBI.B  #$6400,(A0)                     ; $2B2C2E
        BCHG    D0,-(A0)                        ; $2B2C32
        BCHG    D0,(A0)                         ; $2B2C34
        ADDI.B  #$6201,(A1)                     ; $2B2C36
        BCHG    D0,$10(A0,D0.W)                 ; $2B2C3A
        BPL.W  loc_2B2DE0                       ; $2B2C3E
        BCLR    D0,-$40(A0,D0.W)                ; $2B2C42
        BSET    D0,(A0)                         ; $2B2C46
        DC.W    $0210,$6C00         ; $2B2C48 ANDI.B  #$6C00,(A0)
        BSET    D0,-$20(A0,D0.W)                ; $2B2C4C
        SUBI.B  #$6B00,(A0)                     ; $2B2C50
        BSET    D0,D0                           ; $2B2C54
        BCLR    D0,$11(A0,D0.W)                 ; $2B2C56
        BVS.S  loc_2B2C5D                       ; $2B2C5A
        BSET    D0,(A0)                         ; $2B2C5C
        DC.W    $0010,$6300         ; $2B2C5E ORI.B  #$6300,(A0)
        DC.W    $0200,$0210         ; $2B2C62 ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2B2C66 ANDI.B  #$0230,-(A0)
        DC.W    $0210,$6500         ; $2B2C6A ANDI.B  #$6500,(A0)
        ANDI.W  #$0240,(A0)                     ; $2B2C6E
        SUBI.B  #$6400,(A0)                     ; $2B2C72
        DC.W    $0220,$0210         ; $2B2C76 ANDI.B  #$0210,-(A0)
        DC.W    $0211,$6201         ; $2B2C7A ANDI.B  #$6201,(A1)
        DC.W    $0200,$0010         ; $2B2C7E ANDI.B  #$0010,D0
        BNE.W  loc_2B2EE4                       ; $2B2C82
        ANDI.W  #$0280,-$70(A0,D0.W)            ; $2B2C86
        ADDI.B  #$6700,(A0)                     ; $2B2C8C
        ANDI.L  #$02B00410,-(A0)                ; $2B2C90
        BVC.W  loc_2B2F58                       ; $2B2C96
        DC.W    $02D0               ; $2B2C9A DC.W    $02D0
        SUBI.B  #$6700,(A0)                     ; $2B2C9C
        ANDI.W  #$0290,-(A0)                    ; $2B2CA0
        DC.W    $0010,$0300         ; $2B2CA4 ORI.B  #$0300,(A0)
        DC.W    $02E0               ; $2B2CA8 DC.W    $02E0
        DC.W    $02F0               ; $2B2CAA DC.W    $02F0
        BTST    D1,D0                           ; $2B2CAC
        BTST    D1,(A0)                         ; $2B2CAE
        DC.W    $0210,$0500         ; $2B2CB0 ANDI.B  #$0500,(A0)
        BTST    D1,$20(A0,D0.W)                 ; $2B2CB4
        SUBI.B  #$0400,(A0)                     ; $2B2CB8
        BTST    D1,D0                           ; $2B2CBC
        DC.W    $02F0               ; $2B2CBE DC.W    $02F0
        DC.W    $0010,$6500         ; $2B2CC0 ORI.B  #$6500,(A0)
        BCHG    D1,D0                           ; $2B2CC4
        BCHG    D1,(A0)                         ; $2B2CC6
        BCHG    D1,-(A0)                        ; $2B2CC8
        BCHG    D1,$10(A0,D0.W)                 ; $2B2CCA
        BLS.W  loc_2B3060                       ; $2B2CCE
        BCLR    D1,D0                           ; $2B2CD2
        SUBI.B  #$6400,(A0)                     ; $2B2CD4
        BCHG    D1,-(A0)                        ; $2B2CD8
        BCHG    D1,(A0)                         ; $2B2CDA
        DC.W    $0010,$0300         ; $2B2CDC ORI.B  #$0300,(A0)
        BSET    D1,-(A0)                        ; $2B2CE0
        BSET    D1,$00(A0,D0.W)                 ; $2B2CE2
        SUBI.B  #$0210,(A0)                     ; $2B2CE6
        BTST    D2,D0                           ; $2B2CEA
        SUBI.B  #$0420,$10(A0,D0.W)             ; $2B2CEC
        SUBI.B  #$0400,D0                       ; $2B2CF2
        BSET    D1,$10(A0,D0.W)                 ; $2B2CF6
        BCS.W  loc_2B313C                       ; $2B2CFA
        SUBI.W  #$0460,(A0)                     ; $2B2CFE
        SUBI.W  #$0210,$00(A0,D6.W)             ; $2B2D02
        SUBI.L  #$04800410,(A0)                 ; $2B2D08
        BCC.W  loc_2B3170                       ; $2B2D0E
        SUBI.W  #$0000,(A0)                     ; $2B2D12
        BNE.W  loc_2B30B8                       ; $2B2D16
        BCLR    D1,-$40(A0,D0.W)                ; $2B2D1A
        BSET    D1,(A0)                         ; $2B2D1E
        DC.W    $0000,$6600         ; $2B2D20 ORI.B  #$6600,D0
        SUBI.L  #$04B004C0,-(A0)                ; $2B2D24
        DC.W    $04D0               ; $2B2D2A DC.W    $04D0
        CMPI.B  #$005E,D0                       ; $2B2D2C
        ORI.W  #$F8F7,(A6)+                     ; $2B2D30
        ANDI.L  #$FE21F9ED,D6                   ; $2B2D34
        ANDI.W  #$FEB7,-$44(A3,A7.L)            ; $2B2D3A
        BTST    D1,-$4F(A1,A7.L)                ; $2B2D40
        MOVE.W  (A5),$47(A4,D0.W)               ; $2B2D44
        DC.W    $FCFD               ; $2B2D48 MOVE.W  <EA:3D>,(A6)+
        DC.W    $F9BD,$0319         ; $2B2D4A MOVE.W  <EA:3D>,$19(A4,D0.W)
        MOVE.W  (A2)+,-(A7)                     ; $2B2D4E
        MOVE.W  D2,(A5)                         ; $2B2D50
        BSET    D1,#$FE2A                       ; $2B2D52
        MOVE.W  D7,(A4)+                        ; $2B2D56
        BTST    D1,-$017B(A4)                   ; $2B2D58
loc_2B2D5C:
        MOVE.W  (A3)+,$0413(A4)                 ; $2B2D5C
        MOVE.W  $F9B4.W,$03FC(A6)               ; $2B2D60
        MOVE.W  $20(PC,A7.L),$0358(A6)          ; $2B2D66
        MOVE.W  (A7)+,-$0567(A6)                ; $2B2D6C
        BSET    D1,-(A6)                        ; $2B2D70
        MOVE.W  -$05EC(A4),(A6)                 ; $2B2D72
        SUBI.W  #$FCEC,-$05B5(A6)               ; $2B2D76
        BSET    D1,-$28(A1,A7.L)                ; $2B2D7C
        MOVE.W  $0462(A2),(A5)                  ; $2B2D80
        MOVE.W  A0,-$068C(A6)                   ; $2B2D84
        BSET    D1,$3F(PC,A7.L)                 ; $2B2D88
        MOVE.W  D3,-(A4)                        ; $2B2D8C
        BSET    D1,-(A4)                        ; $2B2D8E
        MOVE.W  $F8EA0288,-(A6)                 ; $2B2D90
        MOVE.W  $59(A1,A7.L),(A6)+              ; $2B2D96
        ANDI.L  #$FCF1F93C,D0                   ; $2B2D9A
        BSET    D1,-$0263(A4)                   ; $2B2DA0
        MOVE.W  -(A0),-(A4)                     ; $2B2DA4
        ANDI.W  #$FD4F,$41(A0,A7.L)             ; $2B2DA6
        DC.W    $02B5,$FD0C,$F8EE,$02AC; $2B2DAC ANDI.L  #$FD0CF8EE,-$54(A5,D0.W)
        MOVE.W  D7,-(A6)                        ; $2B2DB4
        MOVE.W  (A7),-(A4)                      ; $2B2DB6
        BCLR    D0,D6                           ; $2B2DB8
loc_2B2DBA:
        MOVEA.W (A5)+,A6                        ; $2B2DBA
        MOVE.W  $4E(A2,D0.W),-$03C4(A4)         ; $2B2DBC
        MOVE.W  (A7),-(A4)                      ; $2B2DC2
        ANDI.L  #$FD47F948,A4                   ; $2B2DC4
        BTST    D0,-(A5)                        ; $2B2DCA
        MOVEA.W $FA64.W,A6                      ; $2B2DCC
        ANDI.W  #$FE99,D4                       ; $2B2DD0
        MOVE.W  (A0)+,(A5)                      ; $2B2DD4
        ANDI.W  #$FEF4,-$051A(A1)               ; $2B2DD6
        BCLR    D1,(A1)+                        ; $2B2DDC
        MOVEA.W A2,A7                           ; $2B2DDE
loc_2B2DE0:
        MOVE.W  $038FFDE1,(A5)                  ; $2B2DE0
        MOVE.W  $027D(A4),D5                    ; $2B2DE6
        MOVE.W  -(A6),(A7)+                     ; $2B2DEA
        MOVE.W  D0,(A5)                         ; $2B2DEC
        DC.W    $03C8               ; $2B2DEE BSET    D1,A0
        MOVE.W  -$04EE(A6),D7                   ; $2B2DF0
        DC.W    $021A,$FDB2         ; $2B2DF4 ANDI.B  #$FDB2,(A2)+
        MOVE.W  (A7)+,-(A5)                     ; $2B2DF8
        DC.W    $021E,$FE1F         ; $2B2DFA ANDI.B  #$FE1F,(A6)+
        MOVEA.W $02BC(A6),A5                    ; $2B2DFE
        MOVE.W  (A7),-(A7)                      ; $2B2E02
        MOVE.W  $02DB(PC),D5                    ; $2B2E04
        MOVE.W  (A6)+,(A7)+                     ; $2B2E08
        MOVE.W  D2,-(A5)                        ; $2B2E0A
        BSET    D0,(A0)                         ; $2B2E0C
        DC.W    $FDD5               ; $2B2E0E MOVE.W  (A5),<EA:3E>
        MOVE.W  $0291(A2),D5                    ; $2B2E10
loc_2B2E14:
        MOVE.W  D3,-(A7)                        ; $2B2E14
        MOVE.W  (A7)+,-(A5)                     ; $2B2E16
        DC.W    $0208,$FCCA         ; $2B2E18 ANDI.B  #$FCCA,A0
        MOVE.W  A2,-(A5)                        ; $2B2E1C
        BTST    D0,(A6)                         ; $2B2E1E
        MOVE.W  (A6),-(A6)                      ; $2B2E20
        MOVE.W  A0,(A5)+                        ; $2B2E22
        DC.W    $0189               ; $2B2E24 BCLR    D0,A1
        MOVEA.W -$23(A2,A7.L),A7                ; $2B2E26
        ANDI.W  #$FE26,-$06AF(PC)               ; $2B2E2A
        ORI.W  #$FCF7,-$50(A5,A7.L)             ; $2B2E30
        BTST    D0,-(A4)                        ; $2B2E36
        MOVE.W  (A6)+,(A6)                      ; $2B2E38
        MOVEA.W $0197(A6),A4                    ; $2B2E3A
        DC.W    $FDFB,$F90F         ; $2B2E3E MOVE.W  $0F(PC,A7.L),<EA:3E>
        DC.W    $00E8               ; $2B2E42 DC.W    $00E8
        MOVEA.W (A3),A7                         ; $2B2E44
        MOVEA.W A2,A5                           ; $2B2E46
        ORI.W  #$FD28,-$05F7(A7)                ; $2B2E48
        DC.W    $00E2               ; $2B2E4E DC.W    $00E2
        MOVE.W  D5,(A7)                         ; $2B2E50
        DC.W    $FA7D               ; $2B2E52 MOVEA.W <EA:3D>,A5
        DC.W    $02B7,$FC72,$FA3B,$0329; $2B2E54 ANDI.L  #$FC72FA3B,$29(A7,D0.W)
        DC.W    $FDCE               ; $2B2E5C MOVE.W  A6,<EA:3E>
        MOVE.W  D5,(A4)+                        ; $2B2E5E
        DC.W    $0216,$FC53         ; $2B2E60 ANDI.B  #$FC53,(A6)
        MOVE.W  D3,(A4)                         ; $2B2E64
        ANDI.L  #$FDB0F984,A1                   ; $2B2E66
        DC.W    $02BD,$FC40,$F942   ; $2B2E6C ANDI.L  #$FC40F942,<EA:3D>
        BTST    D1,-$63(A0,A7.L)                ; $2B2E72
        MOVE.W  A7,(A4)                         ; $2B2E76
        BCHG    D0,-(A7)                        ; $2B2E78
        MOVE.W  -(A2),(A7)                      ; $2B2E7A
        MOVE.W  A5,#$0167                       ; $2B2E7C
        MOVE.W  #$FA00,-(A7)                    ; $2B2E80
        DC.W    $02C3               ; $2B2E84 DC.W    $02C3
        MOVE.W  A1,(A7)                         ; $2B2E86
        MOVE.W  -$3D(PC,D0.W),(A4)+             ; $2B2E88
        MOVE.W  A3,D7                           ; $2B2E8C
        MOVE.W  D6,-$43(A4,D0.W)                ; $2B2E8E
        DC.W    $FFCF               ; $2B2E92 MOVE.W  A7,<EA:3F>
        MOVE.W  $0319(PC),$1D(A4,A7.L)          ; $2B2E94
        MOVEA.W D7,A4                           ; $2B2E9A
        DC.W    $01BE               ; $2B2E9C BCLR    D0,<EA:3E>
        MOVE.W  -$4B(A6,A7.L),-(A7)             ; $2B2E9E
        BTST    D1,(A2)+                        ; $2B2EA2
        MOVE.W  (A6)+,(A7)                      ; $2B2EA4
        MOVE.W  $1F(A7,D0.W),(A4)               ; $2B2EA6
        MOVE.W  (A2),-$07D0(A7)                 ; $2B2EAA
        ORI.W  #$FFA3,-(A1)                     ; $2B2EAE
        MOVE.W  D3,(A4)+                        ; $2B2EB2
        DC.W    $0223,$FF2C         ; $2B2EB4 ANDI.B  #$FF2C,-(A3)
        MOVE.W  A1,$01E3(A4)                    ; $2B2EB8
        MOVE.W  (A4)+,(A7)+                     ; $2B2EBC
        MOVEA.W D0,A4                           ; $2B2EBE
        DC.W    $0031,$FF02,$F8D2   ; $2B2EC0 ORI.B  #$FF02,-$2E(A1,A7.L)
        BSET    D0,-$76(A3,A7.L)                ; $2B2EC6
        MOVE.W  (A3)+,-$06(A3,A7.L)             ; $2B2ECA
        DC.W    $00C0               ; $2B2ECE DC.W    $00C0
        MOVE.W  $0066(PC),$00AB(A3)             ; $2B2ED0
        MOVEA.W -(A4),A4                        ; $2B2ED6
        ORI.W  #$FF5A,-$077B(A0)                ; $2B2ED8
        DC.W    $FFFC,$FF6F         ; $2B2EDE MOVE.W  #$FF6F,<EA:3F>
        MOVE.W  D7,$0006(A3)                    ; $2B2EE2
        ORI.L  #$F8300008,D6                    ; $2B2EE6
        MOVE.W  $6D(A6,A7.W),-(A7)              ; $2B2EEC
        MOVE.W  (A6),-$1D(A7,A7.L)              ; $2B2EF0
        MOVE.W  -$0097(A2),$0009(A3)            ; $2B2EF4
        MOVE.W  $22(A5,D0.W),$00E3(A3)          ; $2B2EFA
        DC.W    $F779,$0069,$00A5,$F8FD; $2B2F00 MOVE.W  $006900A5,-$0703(A3)
        ANDI.W  #$FF30,(A7)                     ; $2B2F08
        MOVE.W  $01E5(A1),-(A4)                 ; $2B2F0C
        MOVE.W  -(A6),$05(A7,A7.L)              ; $2B2F10
        DC.W    $00D4               ; $2B2F14 DC.W    $00D4
        MOVEA.W A7,A7                           ; $2B2F16
        MOVE.W  (A1)+,#$0146                    ; $2B2F18
        DC.W    $FDDA               ; $2B2F1C MOVE.W  (A2)+,<EA:3E>
        DC.W    $F97E,$026D         ; $2B2F1E MOVE.W  <EA:3E>,$026D(A4)
        MOVE.W  -$05A6(A7),$015D(A7)            ; $2B2F22
        MOVE.W  (A1)+,D7                        ; $2B2F28
        MOVE.W  A0,D5                           ; $2B2F2A
        DC.W    $00B9,$FDDE,$FA13,$011A,$FE1A; $2B2F2C ORI.L  #$FDDEFA13,$011AFE1A
        MOVE.W  A7,$58(A4,D0.W)                 ; $2B2F36
        MOVE.W  -$067B(A2),-$0009(A7)           ; $2B2F3A
        MOVE.W  -$059D(A6),-(A7)                ; $2B2F40
        DC.W    $00C9               ; $2B2F44 DC.W    $00C9
        MOVE.W  A3,D7                           ; $2B2F46
        MOVE.W  -(A0),#$0007                    ; $2B2F48
        MOVE.W  (A3)+,-$063B(A7)                ; $2B2F4C
        DC.W    $FFF9,$FE62,$F9C6   ; $2B2F50 MOVE.W  $FE62F9C6,<EA:3F>
        DC.W    $FFBF,$FE6F         ; $2B2F56 MOVE.W  <EA:3F>,$6F(A7,A7.L)
        MOVE.W  (A5),-$03(A4,A7.L)              ; $2B2F5A
        MOVE.W  D3,-$6D(A7,A7.L)                ; $2B2F5E
        ORI.W  #$FF6E,(A7)                      ; $2B2F62
        DC.W    $0010,$0500         ; $2B2F66 ORI.B  #$0500,(A0)
        ANDI.W  #$0270,-(A0)                    ; $2B2F6A
        ANDI.L  #$02900210,D0                   ; $2B2F6E
        ADDI.B  #$0310,D0                       ; $2B2F74
        BTST    D1,D0                           ; $2B2F78
        SUBI.B  #$0500,(A0)                     ; $2B2F7A
        BCHG    D1,(A0)                         ; $2B2F7E
        BCHG    D1,D0                           ; $2B2F80
        SUBI.B  #$0600,(A0)                     ; $2B2F82
        BTST    D1,$20(A0,D0.W)                 ; $2B2F86
        SUBI.B  #$0500,(A0)                     ; $2B2F8A
        DC.W    $02C0               ; $2B2F8E DC.W    $02C0
        DC.W    $02B0,$0610,$0300,$0350; $2B2F90 ANDI.L  #$06100300,$50(A0,D0.W)
        DC.W    $02D0               ; $2B2F98 DC.W    $02D0
        DC.W    $0210,$0600         ; $2B2F9A ANDI.B  #$0600,(A0)
        ANDI.L  #$02B00610,-(A0)                ; $2B2F9E
        BTST    D2,D0                           ; $2B2FA4
        DC.W    $02F0               ; $2B2FA6 DC.W    $02F0
        DC.W    $02E0               ; $2B2FA8 DC.W    $02E0
        ADDI.B  #$0300,(A0)                     ; $2B2FAA
        BCHG    D1,(A0)                         ; $2B2FAE
        BTST    D1,(A0)                         ; $2B2FB0
        DC.W    $0210,$0300         ; $2B2FB2 ANDI.B  #$0300,(A0)
        ANDI.L  #$02800210,(A0)                 ; $2B2FB6
        ADDI.B  #$0270,D0                       ; $2B2FBC
        DC.W    $02E0               ; $2B2FC0 DC.W    $02E0
        SUBI.B  #$0300,(A0)                     ; $2B2FC2
        ANDI.W  #$0300,-(A0)                    ; $2B2FC6
        DC.W    $0210,$0300         ; $2B2FCA ANDI.B  #$0300,(A0)
        BCHG    D1,D0                           ; $2B2FCE
        ANDI.L  #$04100300,-(A0)                ; $2B2FD0
        BTST    D1,-(A0)                        ; $2B2FD6
        DC.W    $02B0,$0010,$6E00,$0000; $2B2FD8 ANDI.L  #$00106E00,$00(A0,D0.W)
        DC.W    $0010,$0020         ; $2B2FE0 ORI.B  #$0020,(A0)
        DC.W    $0030,$0610,$6F00   ; $2B2FE4 ORI.B  #$0610,$00(A0,D6.L)
        ORI.W  #$0050,D0                        ; $2B2FEA
        SUBI.B  #$7000,(A0)                     ; $2B2FEE
        ORI.W  #$0070,-(A0)                     ; $2B2FF2
        SUBI.B  #$6F00,(A0)                     ; $2B2FF6
        DC.W    $0000,$0030         ; $2B2FFA ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2B2FFE ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2B3002 ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2B3006 ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2B300A
        DC.W    $00B0,$0210,$0400,$00D0; $2B3010 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2B3018 DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2B301A
        ORI.L  #$00900611,-(A0)                 ; $2B301E
        BTST    D3,D1                           ; $2B3024
        DC.W    $00B0,$0010,$6A00,$00E0; $2B3026 ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2B302E DC.W    $00F0
        BTST    D0,D0                           ; $2B3030
        BTST    D0,(A0)                         ; $2B3032
        DC.W    $0210,$6C00         ; $2B3034 ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2B3038
        SUBI.B  #$6B00,(A0)                     ; $2B303C
        BTST    D0,D0                           ; $2B3040
        DC.W    $00F0               ; $2B3042 DC.W    $00F0
        DC.W    $0211,$6901         ; $2B3044 ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2B3048 DC.W    $00E0
        DC.W    $0010,$6300         ; $2B304A ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2B304E
        BCHG    D0,(A0)                         ; $2B3050
        BCHG    D0,-(A0)                        ; $2B3052
        BCHG    D0,$10(A0,D0.W)                 ; $2B3054
        BCS.W  loc_2B31EA                       ; $2B3058
        BCLR    D0,D0                           ; $2B305C
        SUBI.B  #$6400,(A0)                     ; $2B305E
        BCHG    D0,-(A0)                        ; $2B3062
        BCHG    D0,(A0)                         ; $2B3064
        ADDI.B  #$6201,(A1)                     ; $2B3066
        BCHG    D0,$10(A0,D0.W)                 ; $2B306A
        BPL.W  loc_2B3210                       ; $2B306E
        BCLR    D0,-$40(A0,D0.W)                ; $2B3072
        BSET    D0,(A0)                         ; $2B3076
        DC.W    $0210,$6C00         ; $2B3078 ANDI.B  #$6C00,(A0)
        BSET    D0,-$20(A0,D0.W)                ; $2B307C
        SUBI.B  #$6B00,(A0)                     ; $2B3080
        BSET    D0,D0                           ; $2B3084
        BCLR    D0,$11(A0,D0.W)                 ; $2B3086
        BVS.S  loc_2B308D                       ; $2B308A
        BSET    D0,(A0)                         ; $2B308C
        DC.W    $0010,$6300         ; $2B308E ORI.B  #$6300,(A0)
        DC.W    $0200,$0210         ; $2B3092 ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2B3096 ANDI.B  #$0230,-(A0)
        DC.W    $0210,$6500         ; $2B309A ANDI.B  #$6500,(A0)
        ANDI.W  #$0240,(A0)                     ; $2B309E
        SUBI.B  #$6400,(A0)                     ; $2B30A2
        DC.W    $0220,$0210         ; $2B30A6 ANDI.B  #$0210,-(A0)
        DC.W    $0211,$6201         ; $2B30AA ANDI.B  #$6201,(A1)
        DC.W    $0200,$0010         ; $2B30AE ANDI.B  #$0010,D0
        BNE.W  loc_2B3414                       ; $2B30B2
        BCHG    D1,-$80(A0,D0.W)                ; $2B30B6
        BCLR    D1,(A0)                         ; $2B30BA
        ADDI.B  #$6700,(A0)                     ; $2B30BC
        BCLR    D1,-(A0)                        ; $2B30C0
        BCLR    D1,$10(A0,D0.W)                 ; $2B30C2
        BVC.W  loc_2B3488                       ; $2B30C6
        BSET    D1,(A0)                         ; $2B30CA
        SUBI.B  #$6700,(A0)                     ; $2B30CC
        BCHG    D1,-(A0)                        ; $2B30D0
        BCLR    D1,(A0)                         ; $2B30D2
        DC.W    $0010,$0300         ; $2B30D4 ORI.B  #$0300,(A0)
        BSET    D1,-(A0)                        ; $2B30D8
        BSET    D1,$00(A0,D0.W)                 ; $2B30DA
        SUBI.B  #$0210,(A0)                     ; $2B30DE
        BTST    D2,D0                           ; $2B30E2
        SUBI.B  #$0420,$10(A0,D0.W)             ; $2B30E4
        SUBI.B  #$0400,D0                       ; $2B30EA
        BSET    D1,$10(A0,D0.W)                 ; $2B30EE
        BCS.W  loc_2B3534                       ; $2B30F2
        SUBI.W  #$0460,(A0)                     ; $2B30F6
        SUBI.W  #$0210,$00(A0,D6.W)             ; $2B30FA
        SUBI.L  #$04800410,(A0)                 ; $2B3100
        BCC.W  loc_2B3568                       ; $2B3106
        SUBI.W  #$0010,(A0)                     ; $2B310A
        BTST    D1,D0                           ; $2B310E
        DC.W    $04E0               ; $2B3110 DC.W    $04E0
        DC.W    $04F0               ; $2B3112 DC.W    $04F0
        BTST    D2,D0                           ; $2B3114
        BTST    D2,(A0)                         ; $2B3116
        DC.W    $0210,$0500         ; $2B3118 ANDI.B  #$0500,(A0)
        BTST    D2,$20(A0,D0.W)                 ; $2B311C
        SUBI.B  #$0400,(A0)                     ; $2B3120
        BTST    D2,D0                           ; $2B3124
        DC.W    $04F0               ; $2B3126 DC.W    $04F0
        DC.W    $0010,$6500         ; $2B3128 ORI.B  #$6500,(A0)
        BCHG    D2,D0                           ; $2B312C
        BCHG    D2,(A0)                         ; $2B312E
        BCHG    D2,-(A0)                        ; $2B3130
        BCHG    D2,$10(A0,D0.W)                 ; $2B3132
        BLS.W  loc_2B36C8                       ; $2B3136
        BCLR    D2,D0                           ; $2B313A
loc_2B313C:
        SUBI.B  #$6400,(A0)                     ; $2B313C
        BCHG    D2,-(A0)                        ; $2B3140
        BCHG    D2,(A0)                         ; $2B3142
        DC.W    $0000,$6600         ; $2B3144 ORI.B  #$6600,D0
        SUBI.L  #$04B004C0,-(A0)                ; $2B3148
        DC.W    $04D0               ; $2B314E DC.W    $04D0
        DC.W    $0000,$6600         ; $2B3150 ORI.B  #$6600,D0
        BCLR    D2,-(A0)                        ; $2B3154
        BCLR    D2,-$40(A0,D0.W)                ; $2B3156
        BSET    D2,(A0)                         ; $2B315A
        CMPI.B  #$005E,D0                       ; $2B315C
        ORI.W  #$F84C,(A6)+                     ; $2B3160
        BTST    D1,$7D(A0,A7.L)                 ; $2B3164
        MOVE.W  $0304(A7),(A4)+                 ; $2B3168
        MOVE.W  (A3),(A7)                       ; $2B316C
        MOVE.W  (A4)+,D4                        ; $2B316E
loc_2B3170:
        BSET    D1,-$024D(A2)                   ; $2B3170
        MOVE.W  (A2)+,$041E(A3)                 ; $2B3174
        MOVE.W  A3,(A7)+                        ; $2B3178
        MOVE.W  $0397(A0),-$0135(A4)            ; $2B317A
        MOVE.W  -$62(A2,D0.W),(A4)              ; $2B3180
        DC.W    $FDF7,$F8C6         ; $2B3184 MOVE.W  -$3A(A7,A7.L),<EA:3E>
        BSET    D1,D3                           ; $2B3188
        MOVE.W  -$11(A6,A7.W),-$2D(A7,D0.W)     ; $2B318A
        MOVE.W  (A1),-(A7)                      ; $2B3190
        MOVE.W  -$44(A5,D0.W),-$48(PC,A7.L)     ; $2B3192
        MOVE.W  D7,$1E(PC,D0.W)                 ; $2B3198
        MOVEA.W A0,A7                           ; $2B319C
        MOVE.W  -$38(A7,D0.W),-(A3)             ; $2B319E
        DC.W    $FDC4               ; $2B31A2 MOVE.W  D4,<EA:3E>
        MOVE.W  D3,$43(A3,D0.W)                 ; $2B31A4
        MOVEA.W A6,A7                           ; $2B31A8
        MOVEA.W (A2)+,A4                        ; $2B31AA
        SUBI.L  #$FE27F7E7,-(A1)                ; $2B31AC
        BTST    D2,-$0241(A0)                   ; $2B31B2
        MOVE.W  (A6)+,-$51(A3,D0.W)             ; $2B31B6
        MOVE.W  -$086D(A5),(A7)+                ; $2B31BA
        SUBI.L  #$FF60F784,(A6)+                ; $2B31BE
        DC.W    $033D               ; $2B31C4 BTST    D1,<EA:3D>
        MOVE.W  A7,-$73(A7,A7.W)                ; $2B31C6
        BTST    D1,-$00E0(A6)                   ; $2B31CA
        MOVE.W  $04B3.W,$2D(PC,A7.L)            ; $2B31CE
        MOVE.W  $0333(A0),$60(PC,A7.L)          ; $2B31D4
        MOVE.W  D1,-$77(PC,D0.W)                ; $2B31DA
        MOVE.W  A2,-$0853(A7)                   ; $2B31DE
        BCHG    D1,-$69(A3,A7.L)                ; $2B31E2
        MOVE.W  A2,(A3)+                        ; $2B31E6
        ANDI.L  #$FF1DF6AD,(A1)                 ; $2B31E8
        ANDI.W  #$FEB5,-$16(A5,A7.W)            ; $2B31EE
        DC.W    $034A               ; $2B31F4 BCHG    D1,A2
        MOVE.W  -$2B(A1,A7.W),$0238(A7)         ; $2B31F6
        MOVE.W  (A4)+,(A7)+                     ; $2B31FC
        MOVE.W  (A6)+,(A4)+                     ; $2B31FE
        DC.W    $02D2               ; $2B3200 DC.W    $02D2
        DC.W    $FDEA,$F942         ; $2B3202 MOVE.W  -$06BE(A2),<EA:3E>
        DC.W    $02F1               ; $2B3206 DC.W    $02F1
        DC.W    $FDC6               ; $2B3208 MOVE.W  D6,<EA:3E>
        MOVE.W  A2,(A4)+                        ; $2B320A
        DC.W    $043D,$FD95         ; $2B320C SUBI.B  #$FD95,<EA:3D>
loc_2B3210:
        MOVEA.W (A3)+,A4                        ; $2B3210
        DC.W    $043C,$FDB5,$F929   ; $2B3212 SUBI.B  #$FDB5,#$F929
        DC.W    $02F7               ; $2B3218 DC.W    $02F7
        MOVE.W  -$5A(A3,A7.L),D7                ; $2B321A
        SUBI.W  #$FDFC,-(A2)                    ; $2B321E
        MOVE.W  A3,D4                           ; $2B3222
        DC.W    $02E1               ; $2B3224 DC.W    $02E1
        MOVE.W  (A7)+,-(A6)                     ; $2B3226
        MOVEA.W $02D7(PC),A4                    ; $2B3228
        MOVE.W  (A7)+,-(A6)                     ; $2B322C
        MOVE.W  $0338(A1),-$0200(A4)            ; $2B322E
        MOVE.W  $0357(A7),-(A4)                 ; $2B3234
        MOVE.W  $23(A2,A7.L),D7                 ; $2B3238
        ANDI.L  #$FD27F947,(A1)                 ; $2B323C
        DC.W    $0308               ; $2B3242 BTST    D1,A0
        MOVE.W  -$08CF(PC),D7                   ; $2B3244
        DC.W    $02E1               ; $2B3248 DC.W    $02E1
        MOVE.W  A2,(A6)+                        ; $2B324A
        MOVE.W  -(A5),$01E8(A3)                 ; $2B324C
        MOVE.W  A4,(A6)+                        ; $2B3250
        MOVE.W  $022F(A6),(A4)                  ; $2B3252
        MOVE.W  -$0787(A4),$0327(A6)            ; $2B3256
        MOVE.W  -$092E(A2),$0115(A6)            ; $2B325C
        MOVEA.W (A5),A7                         ; $2B3262
        MOVEA.W -(A2),A3                        ; $2B3264
        BCLR    D0,-$0A(A6,A7.L)                ; $2B3266
        MOVE.W  $01FC(A4),-$6A(A3,A7.L)         ; $2B326A
        MOVE.W  (A4)+,D4                        ; $2B3270
        BCHG    D0,(A3)+                        ; $2B3272
        MOVE.W  $3E(A5,A7.W),(A7)+              ; $2B3274
        BTST    D0,-$0290(A1)                   ; $2B3278
        MOVE.W  D7,(A4)                         ; $2B327C
        BCHG    D0,$10(A0,A7.L)                 ; $2B327E
        MOVE.W  D0,(A3)+                        ; $2B3282
        BCLR    D1,D3                           ; $2B3284
        MOVE.W  -$07F7(A3),$03C8(A6)            ; $2B3286
        MOVE.W  A4,D7                           ; $2B328C
        MOVE.W  $02AF(A6),D3                    ; $2B328E
        MOVE.W  $77(A5,A7.W),(A7)+              ; $2B3292
        DC.W    $02F5               ; $2B3296 DC.W    $02F5
        MOVE.W  (A5),$54(A7,A7.W)               ; $2B3298
        BCHG    D1,-$01AF(A5)                   ; $2B329C
        MOVE.W  (A6)+,-$4C(A3,D0.W)             ; $2B32A0
        MOVE.W  -$2B(A1,A7.L),(A7)+             ; $2B32A4
        DC.W    $0205,$0018         ; $2B32A8 ANDI.B  #$0018,D5
        MOVE.W  A1,-$1B(A4,D0.W)                ; $2B32AC
        MOVE.W  -$0725(A2),(A7)+                ; $2B32B0
        BTST    D1,-$7D(A7,A7.L)                ; $2B32B4
        MOVEA.W D6,A4                           ; $2B32B8
        BCHG    D1,(A2)                         ; $2B32BA
        MOVE.W  $16(PC,A7.L),$0244(A7)          ; $2B32BC
        MOVE.W  $67(A4,A7.L),-(A7)              ; $2B32C2
        BCLR    D1,(A6)                         ; $2B32C6
        MOVE.W  A4,(A7)+                        ; $2B32C8
        MOVE.W  -(A2),$0264(A4)                 ; $2B32CA
        ORI.W  #$F8D3,-(A2)                     ; $2B32CE
        BCLR    D1,-$3B(A1,A7.L)                ; $2B32D2
        MOVE.W  $2D(A6,D0.W),D4                 ; $2B32D6
        MOVE.W  (A0),$75(A7,A7.L)               ; $2B32DA
        BTST    D0,(A4)                         ; $2B32DE
        DC.W    $002B,$F994,$029D   ; $2B32E0 ORI.B  #$F994,$029D(A3)
        DC.W    $FFF5,$F954         ; $2B32E6 MOVE.W  $54(A5,A7.L),<EA:3F>
        DC.W    $02B6,$FF5A,$F7EF,$016F; $2B32EA ANDI.L  #$FF5AF7EF,$6F(A6,D0.W)
        DC.W    $FFFB,$F90D         ; $2B32F2 MOVE.W  $0D(PC,A7.L),<EA:3F>
        DC.W    $02F8               ; $2B32F6 DC.W    $02F8
        DC.W    $FFC5               ; $2B32F8 MOVE.W  D5,<EA:3F>
        MOVE.W  A3,(A4)+                        ; $2B32FA
        DC.W    $FFF9,$00CE,$F900   ; $2B32FC MOVE.W  $00CEF900,<EA:3F>
        ORI.W  #$0101,(A0)                      ; $2B3302
        MOVEA.W (A7),A4                         ; $2B3306
        BCHG    D0,(A0)                         ; $2B3308
        DC.W    $FFF1,$F821         ; $2B330A MOVE.W  $21(A1,A7.L),<EA:3F>
        DC.W    $00F8               ; $2B330E DC.W    $00F8
        DC.W    $FFBF,$F898         ; $2B3310 MOVE.W  <EA:3F>,-$68(A7,A7.L)
        DC.W    $0027,$011A         ; $2B3314 ORI.B  #$011A,-(A7)
        MOVE.W  $0127(A7),$0A(PC,D0.W)          ; $2B3318
        MOVE.W  D2,(A4)                         ; $2B331E
        MOVE.W  $32(A4,D0.W),$7D(A7,A7.L)       ; $2B3320
        MOVE.W  D3,$52(A7,D0.W)                 ; $2B3326
        MOVE.W  $00070130,(A4)+                 ; $2B332A
        DC.W    $F8FF               ; $2B3330 MOVE.W  <EA:3F>,(A4)+
        ORI.W  #$00FD,(A4)                      ; $2B3332
        MOVE.W  (A7)+,$02EB(A4)                 ; $2B3336
        MOVE.W  D6,-$1D(A7,A7.L)                ; $2B333A
        ANDI.L  #$FF85F8C0,D1                   ; $2B333E
        BTST    D0,(A1)+                        ; $2B3344
        MOVE.W  -(A5),(A7)+                     ; $2B3346
        MOVE.W  -$7C(PC,D0.W),D4                ; $2B3348
        MOVE.W  -(A6),(A7)+                     ; $2B334C
        MOVE.W  $02E6(A0),$09(A4,A7.L)          ; $2B334E
        MOVE.W  D6,(A4)                         ; $2B3354
        DC.W    $017E               ; $2B3356 BCHG    D0,<EA:3E>
        MOVEA.W -$07C3(A1),A7                   ; $2B3358
        BTST    D0,(A4)+                        ; $2B335C
        MOVE.W  (A2),(A7)+                      ; $2B335E
        MOVE.W  (A4),(A4)                       ; $2B3360
        BCHG    D0,-(A7)                        ; $2B3362
        MOVE.W  D7,(A7)+                        ; $2B3364
        MOVE.W  (A7),$57(A4,D0.W)               ; $2B3366
        MOVE.W  -$06C0(A4),$000C(A7)            ; $2B336A
        MOVE.W  $72(A7,A7.L),$0118(A7)          ; $2B3370
        MOVEA.W -$068B(PC),A7                   ; $2B3376
        DC.W    $0009,$FF1F         ; $2B337A ORI.B  #$FF1F,A1
        MOVE.W  -$000C(A2),$60(A4,A7.L)         ; $2B337E
        MOVE.W  -$44(A7,A7.L),$6E(A4,A7.L)      ; $2B3384
        MOVE.W  -(A5),-$01(A4,A7.L)             ; $2B338A
        MOVE.W  D5,-$6E(A7,A7.L)                ; $2B338E
        ORI.W  #$FF6E,(A7)                      ; $2B3392
        DC.W    $0010,$0500         ; $2B3396 ORI.B  #$0500,(A0)
        ANDI.W  #$0270,-(A0)                    ; $2B339A
        ANDI.L  #$02900210,D0                   ; $2B339E
        ADDI.B  #$0310,D0                       ; $2B33A4
        BTST    D1,D0                           ; $2B33A8
        SUBI.B  #$0500,(A0)                     ; $2B33AA
        BCHG    D1,(A0)                         ; $2B33AE
        BCHG    D1,D0                           ; $2B33B0
        SUBI.B  #$0600,(A0)                     ; $2B33B2
        BTST    D1,$20(A0,D0.W)                 ; $2B33B6
        SUBI.B  #$0500,(A0)                     ; $2B33BA
        DC.W    $02C0               ; $2B33BE DC.W    $02C0
        DC.W    $02B0,$0610,$0300,$0350; $2B33C0 ANDI.L  #$06100300,$50(A0,D0.W)
        DC.W    $02D0               ; $2B33C8 DC.W    $02D0
        DC.W    $0210,$0600         ; $2B33CA ANDI.B  #$0600,(A0)
        ANDI.L  #$02B00610,-(A0)                ; $2B33CE
        BTST    D2,D0                           ; $2B33D4
        DC.W    $02F0               ; $2B33D6 DC.W    $02F0
        DC.W    $02E0               ; $2B33D8 DC.W    $02E0
        ADDI.B  #$0300,(A0)                     ; $2B33DA
        BCHG    D1,(A0)                         ; $2B33DE
        BTST    D1,(A0)                         ; $2B33E0
        DC.W    $0210,$0300         ; $2B33E2 ANDI.B  #$0300,(A0)
        ANDI.L  #$02800210,(A0)                 ; $2B33E6
        ADDI.B  #$0270,D0                       ; $2B33EC
        DC.W    $02E0               ; $2B33F0 DC.W    $02E0
        SUBI.B  #$0300,(A0)                     ; $2B33F2
        ANDI.W  #$0300,-(A0)                    ; $2B33F6
        DC.W    $0210,$0300         ; $2B33FA ANDI.B  #$0300,(A0)
        BCHG    D1,D0                           ; $2B33FE
        ANDI.L  #$04100300,-(A0)                ; $2B3400
        BTST    D1,-(A0)                        ; $2B3406
        DC.W    $02B0,$0010,$6E00,$0000; $2B3408 ANDI.L  #$00106E00,$00(A0,D0.W)
        DC.W    $0010,$0020         ; $2B3410 ORI.B  #$0020,(A0)
loc_2B3414:
        DC.W    $0030,$0610,$6F00   ; $2B3414 ORI.B  #$0610,$00(A0,D6.L)
        ORI.W  #$0050,D0                        ; $2B341A
        SUBI.B  #$7000,(A0)                     ; $2B341E
        ORI.W  #$0070,-(A0)                     ; $2B3422
        SUBI.B  #$6F00,(A0)                     ; $2B3426
        DC.W    $0000,$0030         ; $2B342A ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2B342E ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2B3432 ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2B3436 ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2B343A
        DC.W    $00B0,$0210,$0400,$00D0; $2B3440 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2B3448 DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2B344A
        ORI.L  #$00900611,-(A0)                 ; $2B344E
        BTST    D3,D1                           ; $2B3454
        DC.W    $00B0,$0010,$6A00,$00E0; $2B3456 ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2B345E DC.W    $00F0
        BTST    D0,D0                           ; $2B3460
        BTST    D0,(A0)                         ; $2B3462
        DC.W    $0210,$6C00         ; $2B3464 ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2B3468
        SUBI.B  #$6B00,(A0)                     ; $2B346C
        BTST    D0,D0                           ; $2B3470
        DC.W    $00F0               ; $2B3472 DC.W    $00F0
        DC.W    $0211,$6901         ; $2B3474 ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2B3478 DC.W    $00E0
        DC.W    $0010,$6300         ; $2B347A ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2B347E
        BCHG    D0,(A0)                         ; $2B3480
        BCHG    D0,-(A0)                        ; $2B3482
        BCHG    D0,$10(A0,D0.W)                 ; $2B3484
loc_2B3488:
        BCS.W  loc_2B361A                       ; $2B3488
        BCLR    D0,D0                           ; $2B348C
        SUBI.B  #$6400,(A0)                     ; $2B348E
        BCHG    D0,-(A0)                        ; $2B3492
        BCHG    D0,(A0)                         ; $2B3494
        ADDI.B  #$6201,(A1)                     ; $2B3496
        BCHG    D0,$10(A0,D0.W)                 ; $2B349A
        BPL.W  loc_2B3640                       ; $2B349E
        BCLR    D0,-$40(A0,D0.W)                ; $2B34A2
        BSET    D0,(A0)                         ; $2B34A6
        DC.W    $0210,$6C00         ; $2B34A8 ANDI.B  #$6C00,(A0)
        BSET    D0,-$20(A0,D0.W)                ; $2B34AC
        SUBI.B  #$6B00,(A0)                     ; $2B34B0
        BSET    D0,D0                           ; $2B34B4
        BCLR    D0,$11(A0,D0.W)                 ; $2B34B6
        BVS.S  loc_2B34BD                       ; $2B34BA
        BSET    D0,(A0)                         ; $2B34BC
        DC.W    $0010,$6300         ; $2B34BE ORI.B  #$6300,(A0)
        DC.W    $0200,$0210         ; $2B34C2 ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2B34C6 ANDI.B  #$0230,-(A0)
        DC.W    $0210,$6500         ; $2B34CA ANDI.B  #$6500,(A0)
        ANDI.W  #$0240,(A0)                     ; $2B34CE
        SUBI.B  #$6400,(A0)                     ; $2B34D2
        DC.W    $0220,$0210         ; $2B34D6 ANDI.B  #$0210,-(A0)
        DC.W    $0211,$6201         ; $2B34DA ANDI.B  #$6201,(A1)
        DC.W    $0200,$0010         ; $2B34DE ANDI.B  #$0010,D0
        BNE.W  loc_2B3844                       ; $2B34E2
        BCHG    D1,-$80(A0,D0.W)                ; $2B34E6
        BCLR    D1,(A0)                         ; $2B34EA
        ADDI.B  #$6700,(A0)                     ; $2B34EC
        BCLR    D1,-(A0)                        ; $2B34F0
        BCLR    D1,$10(A0,D0.W)                 ; $2B34F2
        BVC.W  loc_2B38B8                       ; $2B34F6
        BSET    D1,(A0)                         ; $2B34FA
        SUBI.B  #$6700,(A0)                     ; $2B34FC
        BCHG    D1,-(A0)                        ; $2B3500
        BCLR    D1,(A0)                         ; $2B3502
        DC.W    $0010,$0300         ; $2B3504 ORI.B  #$0300,(A0)
        BSET    D1,-(A0)                        ; $2B3508
        BSET    D1,$00(A0,D0.W)                 ; $2B350A
        SUBI.B  #$0210,(A0)                     ; $2B350E
        BTST    D2,D0                           ; $2B3512
        SUBI.B  #$0420,$10(A0,D0.W)             ; $2B3514
        SUBI.B  #$0400,D0                       ; $2B351A
        BSET    D1,$10(A0,D0.W)                 ; $2B351E
        BCS.W  loc_2B3964                       ; $2B3522
        SUBI.W  #$0460,(A0)                     ; $2B3526
        SUBI.W  #$0210,$00(A0,D6.W)             ; $2B352A
        SUBI.L  #$04800410,(A0)                 ; $2B3530
        BCC.W  loc_2B3998                       ; $2B3536
        SUBI.W  #$0010,(A0)                     ; $2B353A
        BTST    D1,D0                           ; $2B353E
        DC.W    $04E0               ; $2B3540 DC.W    $04E0
        DC.W    $04F0               ; $2B3542 DC.W    $04F0
        BTST    D2,D0                           ; $2B3544
        BTST    D2,(A0)                         ; $2B3546
        DC.W    $0210,$0500         ; $2B3548 ANDI.B  #$0500,(A0)
        BTST    D2,$20(A0,D0.W)                 ; $2B354C
        SUBI.B  #$0400,(A0)                     ; $2B3550
        BTST    D2,D0                           ; $2B3554
        DC.W    $04F0               ; $2B3556 DC.W    $04F0
        DC.W    $0010,$6500         ; $2B3558 ORI.B  #$6500,(A0)
        BCHG    D2,D0                           ; $2B355C
        BCHG    D2,(A0)                         ; $2B355E
        BCHG    D2,-(A0)                        ; $2B3560
        BCHG    D2,$10(A0,D0.W)                 ; $2B3562
        BLS.W  loc_2B3AF8                       ; $2B3566
        BCLR    D2,D0                           ; $2B356A
        SUBI.B  #$6400,(A0)                     ; $2B356C
        BCHG    D2,-(A0)                        ; $2B3570
        BCHG    D2,(A0)                         ; $2B3572
        DC.W    $0000,$6600         ; $2B3574 ORI.B  #$6600,D0
        SUBI.L  #$04B004C0,-(A0)                ; $2B3578
        DC.W    $04D0               ; $2B357E DC.W    $04D0
        DC.W    $0000,$6600         ; $2B3580 ORI.B  #$6600,D0
        BCLR    D2,-(A0)                        ; $2B3584
        BCLR    D2,-$40(A0,D0.W)                ; $2B3586
        BSET    D2,(A0)                         ; $2B358A
        CMPI.B  #$005E,D0                       ; $2B358C
        ORI.W  #$F9A4,(A6)+                     ; $2B3590
        DC.W    $030E               ; $2B3594 BTST    D1,A6
        DC.W    $0079,$F9A0,$0319,$FF5A; $2B3596 ORI.W  #$F9A0,$0319FF5A
        MOVE.W  A5,(A4)                         ; $2B359E
        SUBI.B  #$FF4C,-(A4)                    ; $2B35A0
        MOVE.W  (A2),(A4)                       ; $2B35A4
        SUBI.B  #$00A4,(A7)                     ; $2B35A6
        MOVE.W  -$60(A3,D0.W),D5                ; $2B35AA
        MOVE.W  (A5)+,-$06BF(A7)                ; $2B35AE
        DC.W    $04CA               ; $2B35B2 DC.W    $04CA
        MOVE.W  A7,-$05C8(A7)                   ; $2B35B4
        BCLR    D1,(A5)                         ; $2B35B8
        ORI.W  #$F947,-$43(PC,D0.W)             ; $2B35BA
        ORI.L  #$F91704BA,-(A7)                 ; $2B35C0
        ORI.W  #$F8A1,(A1)+                     ; $2B35C6
        SUBI.B  #$FFFE,-$0E(A6,A7.W)            ; $2B35CA
        DC.W    $04F4               ; $2B35D0 DC.W    $04F4
        DC.W    $0008,$F88C         ; $2B35D2 ORI.B  #$F88C,A0
        BCHG    D2,(A1)                         ; $2B35D6
        ORI.W  #$F914,-(A1)                     ; $2B35D8
        DC.W    $04C0               ; $2B35DC DC.W    $04C0
        MOVE.W  -$0777(A0),$58(A7,D0.W)         ; $2B35DE
        MOVE.W  -$23(A1,A7.L),$7E(A7,D0.W)      ; $2B35E4
        DC.W    $00B0,$F920,$0475,$010D; $2B35EA ORI.L  #$F9200475,$0D(A0,D0.W)
        MOVE.W  #$0319,-(A4)                    ; $2B35F2
        BCHG    D0,(A1)                         ; $2B35F6
        MOVE.W  $03(PC,D0.W),(A4)+              ; $2B35F8
        DC.W    $00F9               ; $2B35FC DC.W    $00F9
        MOVE.W  A3,$0485(A4)                    ; $2B35FE
        ORI.L  #$F96A0309,-(A3)                 ; $2B3602
        DC.W    $00ED               ; $2B3608 DC.W    $00ED
        MOVE.W  #$035F,-(A4)                    ; $2B360A
        DC.W    $00F0               ; $2B360E DC.W    $00F0
        MOVE.W  -(A0),$034E(A4)                 ; $2B3610
        BTST    D0,$F869026C                    ; $2B3614
loc_2B361A:
        BCLR    D0,D1                           ; $2B361A
        MOVE.W  (A0),D4                         ; $2B361C
        ANDI.W  #$0147,A3                       ; $2B361E
        MOVE.W  $22(A5,D0.W),$00F7(A4)          ; $2B3622
        MOVEA.W A1,A4                           ; $2B3628
        DC.W    $020F,$014E         ; $2B362A ANDI.B  #$014E,A7
        MOVE.W  $0F(PC,D0.W),-$00E1(A4)         ; $2B362E
        MOVE.W  $0331(A5),-$3F(A4,A7.L)         ; $2B3634
        MOVE.W  A5,-(A4)                        ; $2B363A
        SUBI.W  #$FEE2,-$0733(A6)               ; $2B363C
        SUBI.W  #$FF42,-$0621(A0)               ; $2B3642
        BCHG    D1,D1                           ; $2B3648
        MOVE.W  -(A3),-(A7)                     ; $2B364A
        MOVE.W  -$66(A1,D0.W),-(A4)             ; $2B364C
        MOVE.W  D6,-$0780(A7)                   ; $2B3650
        ANDI.L  #$FF04F8D3,D0                   ; $2B3654
        ANDI.L  #$FEBEF9D1,(A1)+                ; $2B365A
        DC.W    $037E               ; $2B3660 BCHG    D1,<EA:3E>
        MOVE.W  (A1),(A7)+                      ; $2B3662
        MOVE.W  -$6A(A6,D0.W),$1B(A4,A7.L)      ; $2B3664
        MOVE.W  $0241FEFD,(A4)                  ; $2B366A
        MOVE.W  $0359(A6),#$FF15                ; $2B3670
        MOVE.W  $1C(A7,D0.W),-$0B(A3,A7.L)      ; $2B3676
        MOVE.W  -(A2),$20(A3,D0.W)              ; $2B367C
        MOVE.W  (A6)+,(A7)+                     ; $2B3680
        MOVE.W  (A6),-(A4)                      ; $2B3682
        DC.W    $0202,$FEE3         ; $2B3684 ANDI.B  #$FEE3,D2
        MOVE.W  $02FD(A2),-(A4)                 ; $2B3688
        MOVE.W  -$76(PC,A7.W),(A7)+             ; $2B368C
        BCHG    D0,D6                           ; $2B3690
        ORI.W  #$F795,-$18(PC,D0.W)             ; $2B3692
        BCHG    D0,D0                           ; $2B3698
        MOVE.W  A1,-(A4)                        ; $2B369A
        DC.W    $01C8               ; $2B369C BSET    D0,A0
        BCHG    D0,D5                           ; $2B369E
        DC.W    $F8FD               ; $2B36A0 MOVE.W  <EA:3D>,(A4)+
        BTST    D0,-(A6)                        ; $2B36A2
        ORI.L  #$F790015E,D2                    ; $2B36A4
        DC.W    $FF7F,$F904         ; $2B36AA MOVE.W  <EA:3F>,-$06FC(A7)
        DC.W    $013E               ; $2B36AE BTST    D0,<EA:3E>
        MOVE.W  D6,-$3E(A7,A7.W)                ; $2B36B0
        DC.W    $03BE               ; $2B36B4 BCLR    D1,<EA:3E>
        MOVE.W  -$06CA(PC),-$61(A7,D0.W)        ; $2B36B6
        DC.W    $FFBF,$F7A9         ; $2B36BC MOVE.W  <EA:3F>,-$57(A7,A7.W)
        DC.W    $02E4               ; $2B36C0 DC.W    $02E4
        BCHG    D0,(A0)+                        ; $2B36C2
        MOVE.W  (A5)+,-(A4)                     ; $2B36C4
        DC.W    $02C5               ; $2B36C6 DC.W    $02C5
loc_2B36C8:
        BCHG    D0,(A5)+                        ; $2B36C8
        MOVE.W  #$03A6,-$4A(A3,D0.W)            ; $2B36CA
        MOVE.W  -$78(A0,D0.W),-(A4)             ; $2B36D0
        DC.W    $00BB,$FA4A,$01DD,$0099; $2B36D4 ORI.L  #$FA4A01DD,-$67(PC,D0.W)
        MOVEA.W (A0),A5                         ; $2B36DC
        BSET    D0,(A6)+                        ; $2B36DE
        MOVE.W  $F99A033C,-(A7)                 ; $2B36E0
        MOVE.W  (A0)+,-$066A(A7)                ; $2B36E6
        BTST    D1,$78(PC,D0.W)                 ; $2B36EA
        MOVE.W  $34(A4,D0.W),(A5)+              ; $2B36EE
        MOVE.W  #$FA3F,-(A7)                    ; $2B36F2
        BCLR    D1,(A1)                         ; $2B36F6
        MOVE.W  (A2)+,-$0511(A7)                ; $2B36F8
        DC.W    $0232,$009C,$FA3A   ; $2B36FC ANDI.B  #$009C,$3A(A2,A7.L)
        BCLR    D1,(A0)                         ; $2B3702
        ORI.W  #$F97F,$12(PC,D0.W)              ; $2B3704
        ORI.L  #$FA000103,(A4)                  ; $2B370A
        BTST    D0,D2                           ; $2B3710
        MOVE.W  -(A6),(A5)+                     ; $2B3712
        ANDI.W  #$0025,$66(A6,A7.L)             ; $2B3714
        ANDI.L  #$FFB9F973,D6                   ; $2B371A
        BCHG    D0,-(A1)                        ; $2B3720
        DC.W    $010D               ; $2B3722 BTST    D0,A5
        MOVEA.W (A2)+,A5                        ; $2B3724
        DC.W    $02D4               ; $2B3726 DC.W    $02D4
        DC.W    $0031,$FAA2,$FFF8   ; $2B3728 ORI.B  #$FAA2,-$08(A1,A7.L)
        BCLR    D0,D2                           ; $2B372E
        MOVE.W  -(A7),(A5)+                     ; $2B3730
        ORI.W  #$018B,(A3)                      ; $2B3732
        MOVE.W  A1,#$013B                       ; $2B3736
        DC.W    $00D7               ; $2B373A DC.W    $00D7
        MOVE.W  D4,-$20(A4,D0.W)                ; $2B373C
        DC.W    $00CE               ; $2B3740 DC.W    $00CE
        MOVE.W  (A2)+,(A5)                      ; $2B3742
        DC.W    $0030,$01D8,$F97B   ; $2B3744 ORI.B  #$01D8,$7B(A0,A7.L)
        BTST    D0,(A7)                         ; $2B374A
        BTST    D0,-(A4)                        ; $2B374C
        MOVE.W  D0,D5                           ; $2B374E
        MOVE.W  $0151(A7),$18(A7,A7.L)          ; $2B3750
        MOVE.W  #$0167,-$04F7(A7)               ; $2B3756
        DC.W    $0008,$01AB         ; $2B375C ORI.B  #$01AB,A0
        MOVE.W  -(A4),(A5)+                     ; $2B3760
        ORI.W  #$018A,(A7)                      ; $2B3762
        MOVE.W  -$2C(A2,D0.W),(A5)              ; $2B3766
        DC.W    $FFF0,$FAF6         ; $2B376A MOVE.W  -$0A(A0,A7.L),<EA:3F>
        ANDI.W  #$FFA1,A7                       ; $2B376E
        DC.W    $F93D               ; $2B3772 MOVE.W  <EA:3D>,-(A4)
        BCLR    D0,D1                           ; $2B3774
        MOVE.W  -$09(PC,A7.L),$0207(A7)         ; $2B3776
        DC.W    $FFCA               ; $2B377C MOVE.W  A2,<EA:3F>
        MOVE.W  $02DFFF60,(A5)                  ; $2B377E
        DC.W    $F8FE               ; $2B3784 MOVE.W  <EA:3E>,(A4)+
        DC.W    $0211,$FF3A         ; $2B3786 ANDI.B  #$FF3A,(A1)
        MOVE.W  A6,(A4)+                        ; $2B378A
        BSET    D0,D2                           ; $2B378C
        MOVE.W  -$06CB(A7),-$21(A7,D0.W)        ; $2B378E
        MOVE.W  D2,-$64(A7,A7.L)                ; $2B3794
        ORI.W  #$FF6B,(A2)                      ; $2B3798
        MOVE.W  $36(A6,D0.W),-(A4)              ; $2B379C
        MOVE.W  (A7),-$2C(A7,A7.L)              ; $2B37A0
        DC.W    $01C9               ; $2B37A4 BSET    D0,A1
        MOVE.W  D7,-$06C5(A7)                   ; $2B37A6
        DC.W    $003D,$FF31         ; $2B37AA ORI.B  #$FF31,<EA:3D>
        MOVE.W  D2,(A4)+                        ; $2B37AE
        DC.W    $FFE0               ; $2B37B0 MOVE.W  -(A0),<EA:3F>
        MOVE.W  (A2),(A7)+                      ; $2B37B2
        MOVE.W  (A3)+,(A4)+                     ; $2B37B4
        MOVE.W  -$0133(A1),-$43(A7,A7.L)        ; $2B37B6
        DC.W    $0003,$FF65         ; $2B37BC ORI.B  #$FF65,D3
        MOVE.W  (A6),$58(A4,D0.W)               ; $2B37C0
        MOVE.W  $0010(A4),$0500(A7)             ; $2B37C4
        ANDI.W  #$0270,-(A0)                    ; $2B37CA
        ANDI.L  #$02900210,D0                   ; $2B37CE
        ADDI.B  #$0310,D0                       ; $2B37D4
        BTST    D1,D0                           ; $2B37D8
        SUBI.B  #$0500,(A0)                     ; $2B37DA
        BCHG    D1,(A0)                         ; $2B37DE
        BCHG    D1,D0                           ; $2B37E0
        SUBI.B  #$0600,(A0)                     ; $2B37E2
        BTST    D1,$20(A0,D0.W)                 ; $2B37E6
        SUBI.B  #$0500,(A0)                     ; $2B37EA
        DC.W    $02C0               ; $2B37EE DC.W    $02C0
        DC.W    $02B0,$0610,$0300,$0350; $2B37F0 ANDI.L  #$06100300,$50(A0,D0.W)
        DC.W    $02D0               ; $2B37F8 DC.W    $02D0
        DC.W    $0210,$0600         ; $2B37FA ANDI.B  #$0600,(A0)
        ANDI.L  #$02B00610,-(A0)                ; $2B37FE
        BTST    D2,D0                           ; $2B3804
        DC.W    $02F0               ; $2B3806 DC.W    $02F0
        DC.W    $02E0               ; $2B3808 DC.W    $02E0
        ADDI.B  #$0300,(A0)                     ; $2B380A
        BCHG    D1,(A0)                         ; $2B380E
        BTST    D1,(A0)                         ; $2B3810
        DC.W    $0210,$0300         ; $2B3812 ANDI.B  #$0300,(A0)
        ANDI.L  #$02800210,(A0)                 ; $2B3816
        ADDI.B  #$0270,D0                       ; $2B381C
        DC.W    $02E0               ; $2B3820 DC.W    $02E0
        SUBI.B  #$0300,(A0)                     ; $2B3822
        ANDI.W  #$0300,-(A0)                    ; $2B3826
        DC.W    $0210,$0300         ; $2B382A ANDI.B  #$0300,(A0)
        BCHG    D1,D0                           ; $2B382E
        ANDI.L  #$04100300,-(A0)                ; $2B3830
        BTST    D1,-(A0)                        ; $2B3836
        DC.W    $02B0,$0010,$6E00,$0000; $2B3838 ANDI.L  #$00106E00,$00(A0,D0.W)
        DC.W    $0010,$0020         ; $2B3840 ORI.B  #$0020,(A0)
loc_2B3844:
        DC.W    $0030,$0610,$6F00   ; $2B3844 ORI.B  #$0610,$00(A0,D6.L)
        ORI.W  #$0050,D0                        ; $2B384A
        SUBI.B  #$7000,(A0)                     ; $2B384E
        ORI.W  #$0070,-(A0)                     ; $2B3852
        SUBI.B  #$6F00,(A0)                     ; $2B3856
        DC.W    $0000,$0030         ; $2B385A ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2B385E ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2B3862 ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2B3866 ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2B386A
        DC.W    $00B0,$0210,$0400,$00D0; $2B3870 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2B3878 DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2B387A
        ORI.L  #$00900611,-(A0)                 ; $2B387E
        BTST    D3,D1                           ; $2B3884
        DC.W    $00B0,$0010,$6A00,$00E0; $2B3886 ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2B388E DC.W    $00F0
        BTST    D0,D0                           ; $2B3890
        BTST    D0,(A0)                         ; $2B3892
        DC.W    $0210,$6C00         ; $2B3894 ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2B3898
        SUBI.B  #$6B00,(A0)                     ; $2B389C
        BTST    D0,D0                           ; $2B38A0
        DC.W    $00F0               ; $2B38A2 DC.W    $00F0
        DC.W    $0211,$6901         ; $2B38A4 ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2B38A8 DC.W    $00E0
        DC.W    $0010,$6300         ; $2B38AA ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2B38AE
        BCHG    D0,(A0)                         ; $2B38B0
        BCHG    D0,-(A0)                        ; $2B38B2
        BCHG    D0,$10(A0,D0.W)                 ; $2B38B4
loc_2B38B8:
        BCS.W  loc_2B3A4A                       ; $2B38B8
        BCLR    D0,D0                           ; $2B38BC
        SUBI.B  #$6400,(A0)                     ; $2B38BE
        BCHG    D0,-(A0)                        ; $2B38C2
        BCHG    D0,(A0)                         ; $2B38C4
        ADDI.B  #$6201,(A1)                     ; $2B38C6
        BCHG    D0,$10(A0,D0.W)                 ; $2B38CA
        BPL.W  loc_2B3A70                       ; $2B38CE
        BCLR    D0,-$40(A0,D0.W)                ; $2B38D2
        BSET    D0,(A0)                         ; $2B38D6
        DC.W    $0210,$6C00         ; $2B38D8 ANDI.B  #$6C00,(A0)
        BSET    D0,-$20(A0,D0.W)                ; $2B38DC
        SUBI.B  #$6B00,(A0)                     ; $2B38E0
        BSET    D0,D0                           ; $2B38E4
        BCLR    D0,$11(A0,D0.W)                 ; $2B38E6
        BVS.S  loc_2B38ED                       ; $2B38EA
        BSET    D0,(A0)                         ; $2B38EC
        DC.W    $0010,$6300         ; $2B38EE ORI.B  #$6300,(A0)
        DC.W    $0200,$0210         ; $2B38F2 ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2B38F6 ANDI.B  #$0230,-(A0)
        DC.W    $0210,$6500         ; $2B38FA ANDI.B  #$6500,(A0)
        ANDI.W  #$0240,(A0)                     ; $2B38FE
        SUBI.B  #$6400,(A0)                     ; $2B3902
        DC.W    $0220,$0210         ; $2B3906 ANDI.B  #$0210,-(A0)
        DC.W    $0211,$6201         ; $2B390A ANDI.B  #$6201,(A1)
        DC.W    $0200,$0010         ; $2B390E ANDI.B  #$0010,D0
        BNE.W  loc_2B3C74                       ; $2B3912
        BCHG    D1,-$80(A0,D0.W)                ; $2B3916
        BCLR    D1,(A0)                         ; $2B391A
        ADDI.B  #$6700,(A0)                     ; $2B391C
        BCLR    D1,-(A0)                        ; $2B3920
        BCLR    D1,$10(A0,D0.W)                 ; $2B3922
        BVC.W  loc_2B3CE8                       ; $2B3926
        BSET    D1,(A0)                         ; $2B392A
        SUBI.B  #$6700,(A0)                     ; $2B392C
        BCHG    D1,-(A0)                        ; $2B3930
        BCLR    D1,(A0)                         ; $2B3932
        DC.W    $0010,$0300         ; $2B3934 ORI.B  #$0300,(A0)
        BSET    D1,-(A0)                        ; $2B3938
        BSET    D1,$00(A0,D0.W)                 ; $2B393A
        SUBI.B  #$0210,(A0)                     ; $2B393E
        BTST    D2,D0                           ; $2B3942
        SUBI.B  #$0420,$10(A0,D0.W)             ; $2B3944
        SUBI.B  #$0400,D0                       ; $2B394A
        BSET    D1,$10(A0,D0.W)                 ; $2B394E
        BCS.W  loc_2B3D94                       ; $2B3952
        SUBI.W  #$0460,(A0)                     ; $2B3956
        SUBI.W  #$0210,$00(A0,D6.W)             ; $2B395A
        SUBI.L  #$04800410,(A0)                 ; $2B3960
        BCC.W  loc_2B3DC8                       ; $2B3966
        SUBI.W  #$0010,(A0)                     ; $2B396A
        BTST    D1,D0                           ; $2B396E
        DC.W    $04E0               ; $2B3970 DC.W    $04E0
        DC.W    $04F0               ; $2B3972 DC.W    $04F0
        BTST    D2,D0                           ; $2B3974
        BTST    D2,(A0)                         ; $2B3976
        DC.W    $0210,$0500         ; $2B3978 ANDI.B  #$0500,(A0)
        BTST    D2,$20(A0,D0.W)                 ; $2B397C
        SUBI.B  #$0400,(A0)                     ; $2B3980
        BTST    D2,D0                           ; $2B3984
        DC.W    $04F0               ; $2B3986 DC.W    $04F0
        DC.W    $0010,$6500         ; $2B3988 ORI.B  #$6500,(A0)
        BCHG    D2,D0                           ; $2B398C
        BCHG    D2,(A0)                         ; $2B398E
        BCHG    D2,-(A0)                        ; $2B3990
        BCHG    D2,$10(A0,D0.W)                 ; $2B3992
        BLS.W  loc_2B3F28                       ; $2B3996
        BCLR    D2,D0                           ; $2B399A
        SUBI.B  #$6400,(A0)                     ; $2B399C
        BCHG    D2,-(A0)                        ; $2B39A0
        BCHG    D2,(A0)                         ; $2B39A2
        DC.W    $0000,$6600         ; $2B39A4 ORI.B  #$6600,D0
        SUBI.L  #$04B004C0,-(A0)                ; $2B39A8
        DC.W    $04D0               ; $2B39AE DC.W    $04D0
        DC.W    $0000,$6600         ; $2B39B0 ORI.B  #$6600,D0
        BCLR    D2,-(A0)                        ; $2B39B4
        BCLR    D2,-$40(A0,D0.W)                ; $2B39B6
        BSET    D2,(A0)                         ; $2B39BA
        CMPI.B  #$004E,D0                       ; $2B39BC
        ORI.W  #$F900,A6                        ; $2B39C0
        DC.W    $020E,$007A         ; $2B39C4 ANDI.B  #$007A,A6
        MOVE.W  $18(A6,D0.W),(A4)+              ; $2B39C8
        MOVE.W  (A3)+,-$082D(A7)                ; $2B39CC
        BTST    D1,(A3)                         ; $2B39D0
        MOVE.W  (A1),-$0820(A7)                 ; $2B39D2
        BTST    D1,D6                           ; $2B39D6
        DC.W    $00A9,$F982,$02A7,$FF5C; $2B39D8 ORI.L  #$F98202A7,-$00A4(A1)
        DC.W    $F87E               ; $2B39E0 MOVEA.W <EA:3E>,A4
        BSET    D1,D3                           ; $2B39E2
        MOVE.W  (A1),-$0675(A7)                 ; $2B39E4
        ANDI.L  #$007AF88A,(A4)+                ; $2B39E8
        BCLR    D1,-$55(A6,D0.W)                ; $2B39EE
        MOVEA.W (A2)+,A4                        ; $2B39F2
        BCLR    D1,$5C(A0,D0.W)                 ; $2B39F4
        MOVE.W  $0325(A2),$02(PC,D0.W)          ; $2B39F8
        MOVE.W  -$26(A0,D0.W),-(A3)             ; $2B39FE
        DC.W    $000F,$F7C6         ; $2B3A02 ORI.B  #$F7C6,A7
        DC.W    $043F,$0066         ; $2B3A06 SUBI.B  #$0066,<EA:3F>
        MOVEA.W (A3),A4                         ; $2B3A0A
        BCLR    D1,-$54(A6,A7.L)                ; $2B3A0C
        MOVE.W  D0,$45(PC,D0.W)                 ; $2B3A10
        MOVE.W  $29(A6,A7.L),-$7D(A7,D0.W)      ; $2B3A14
        DC.W    $00B7,$F86C,$036F,$0113; $2B3A1A ORI.L  #$F86C036F,$13(A7,D0.W)
        MOVEA.W $0E(PC,D0.W),A4                 ; $2B3A22
        BTST    D0,#$F839                       ; $2B3A26
        DC.W    $0201,$00E4         ; $2B3A2A ANDI.B  #$00E4,D1
        MOVE.W  (A7),(A4)                       ; $2B3A2E
        BCLR    D1,D6                           ; $2B3A30
        DC.W    $00A9,$F8A7,$0204,$00D7; $2B3A32 ORI.L  #$F8A70204,$00D7(A1)
        MOVE.W  (A4),(A4)                       ; $2B3A3A
        ANDI.W  #$00DE,-(A2)                    ; $2B3A3C
        MOVE.W  $45(A0,D0.W),(A4)               ; $2B3A40
        BTST    D0,-(A6)                        ; $2B3A44
        MOVE.W  D4,-$57(A3,D0.W)                ; $2B3A46
loc_2B3A4A:
        BCHG    D0,(A4)+                        ; $2B3A4A
        MOVE.W  -(A6),-(A3)                     ; $2B3A4C
        BCLR    D0,-(A3)                        ; $2B3A4E
        BTST    D0,(A7)+                        ; $2B3A50
        MOVE.W  #$0218,(A4)                     ; $2B3A52
        DC.W    $00E2               ; $2B3A56 DC.W    $00E2
        MOVE.W  A5,$015A(A3)                    ; $2B3A58
        BTST    D0,-(A3)                        ; $2B3A5C
        MOVE.W  $06(A6,D0.W),(A4)               ; $2B3A5E
        MOVE.W  A7,-(A7)                        ; $2B3A62
        MOVE.W  $022C(A0),(A4)+                 ; $2B3A64
        MOVE.W  $4F(A4,A7.L),(A7)               ; $2B3A68
        BCHG    D1,-$011C(A1)                   ; $2B3A6C
loc_2B3A70:
        MOVE.W  A7,D4                           ; $2B3A70
        BCHG    D1,-(A0)                        ; $2B3A72
        MOVE.W  D3,-$06E6(A7)                   ; $2B3A74
        DC.W    $0235,$FF17,$F873   ; $2B3A78 ANDI.B  #$FF17,$73(A5,A7.L)
        DC.W    $038F               ; $2B3A7E BCLR    D1,A7
        MOVE.W  A3,-$0871(A7)                   ; $2B3A80
        DC.W    $021B,$FF00         ; $2B3A84 ANDI.B  #$FF00,(A3)+
        MOVE.W  -(A2),$14(PC,D0.W)              ; $2B3A88
        MOVE.W  $F92A.W,(A7)                    ; $2B3A8C
        ANDI.W  #$FEC8,$1D(A7,A7.L)             ; $2B3A90
        ANDI.L  #$FF15F7A7,(A4)                 ; $2B3A96
        DC.W    $01CC               ; $2B3A9C BSET    D0,A4
        MOVE.W  $36(A5,A7.L),(A7)+              ; $2B3A9E
        ANDI.W  #$FF0A,D4                       ; $2B3AA2
        MOVE.W  (A0)+,#$00EC                    ; $2B3AA6
        ORI.L  #$F9DA00EC,(A2)+                 ; $2B3AAA
        MOVE.W  -$070B(PC),-(A7)                ; $2B3AB0
        DC.W    $022D,$FF59,$F8F3   ; $2B3AB4 ANDI.B  #$FF59,-$070D(A5)
        DC.W    $022E,$0079,$FA70   ; $2B3ABA ANDI.B  #$0079,-$0590(A6)
        BCHG    D0,(A0)+                        ; $2B3AC0
        MOVE.W  -$74(PC,A7.L),-(A7)             ; $2B3AC2
        ANDI.L  #$FF59FA6E,(A0)+                ; $2B3AC6
        BCHG    D0,(A0)+                        ; $2B3ACC
        ORI.L  #$F98B0298,(A3)+                 ; $2B3ACE
        DC.W    $0079,$F963,$FFEC,$00AD; $2B3AD4 ORI.W  #$F963,$FFEC00AD
        MOVE.W  D6,#$001D                       ; $2B3ADC
        BTST    D0,-$05AC(A5)                   ; $2B3AE0
        BCLR    D0,-(A0)                        ; $2B3AE4
        DC.W    $0025,$F9F1         ; $2B3AE6 ORI.B  #$F9F1,-(A5)
        BCHG    D0,-$005A(A6)                   ; $2B3AEA
        MOVE.W  -(A4),-(A4)                     ; $2B3AEE
        ORI.W  #$010D,D4                        ; $2B3AF0
        MOVE.W  -$39(A3,D0.W),$06(A4,D0.W)      ; $2B3AF4
        MOVE.W  -$001C(A1),(A5)+                ; $2B3AFA
        BSET    D0,(A1)                         ; $2B3AFE
        MOVE.W  $0053(A0),(A5)+                 ; $2B3B00
        BCLR    D0,$7F(A7,A7.L)                 ; $2B3B04
        DC.W    $0024,$00F8         ; $2B3B08 ORI.B  #$00F8,-(A4)
        MOVE.W  D0,-$4B(A4,A7.L)                ; $2B3B0C
        BTST    D0,(A3)                         ; $2B3B10
        MOVE.W  #$0022,(A5)                     ; $2B3B12
        DC.W    $0216,$F953         ; $2B3B16 ANDI.B  #$F953,(A6)
        DC.W    $FFF4,$0157         ; $2B3B1A MOVE.W  $57(A4,D0.W),<EA:3F>
        MOVEA.W -$009A(A1),A5                   ; $2B3B1E
        DC.W    $0221,$FA9A         ; $2B3B22 ANDI.B  #$FA9A,-(A1)
        MOVE.W  D5,$0221(A7)                    ; $2B3B26
        MOVE.W  $21(A0,D0.W),-(A5)              ; $2B3B2A
        BCLR    D0,-$051E(PC)                   ; $2B3B2E
        ORI.W  #$01BA,(A6)                      ; $2B3B32
        MOVEA.W (A3),A5                         ; $2B3B36
        BSET    D0,-(A0)                        ; $2B3B38
        DC.W    $FFFA,$FA6B         ; $2B3B3A MOVE.W  -$0595(PC),<EA:3F>
        BCHG    D0,(A2)                         ; $2B3B3E
        MOVE.W  (A7)+,-$79(A7,A7.L)             ; $2B3B40
        BTST    D0,(A4)+                        ; $2B3B44
        MOVE.W  $6F(A2,A7.L),$01A9(A7)          ; $2B3B46
        DC.W    $FFCD               ; $2B3B4C MOVE.W  A5,<EA:3F>
        MOVEA.W (A7)+,A5                        ; $2B3B4E
        BSET    D0,$6B(A3,A7.L)                 ; $2B3B50
        MOVEA.W $01BE(PC),A4                    ; $2B3B54
        DC.W    $FF3E               ; $2B3B58 MOVE.W  <EA:3E>,-(A7)
        MOVE.W  -(A2),D4                        ; $2B3B5A
        BTST    D0,(A4)+                        ; $2B3B5C
        MOVE.W  (A6)+,$6C(A7,A7.L)              ; $2B3B5E
        BCHG    D0,-$0085(A5)                   ; $2B3B62
        MOVE.W  (A0)+,$57(A4,D0.W)              ; $2B3B66
        MOVE.W  -$06B2(A4),$0006(A7)            ; $2B3B6A
        MOVE.W  A7,$29(A7,A7.L)                 ; $2B3B70
        BTST    D0,-$00C7(A3)                   ; $2B3B74
        MOVE.W  (A7),$0013(A4)                  ; $2B3B78
        MOVE.W  -$0756(A1),-(A7)                ; $2B3B7C
        DC.W    $FFDD               ; $2B3B80 MOVE.W  (A5)+,<EA:3F>
        DC.W    $FEFD               ; $2B3B82 MOVE.W  <EA:3D>,(A7)+
        MOVE.W  D2,(A4)+                        ; $2B3B84
        MOVE.W  -(A7),-$0C(A7,A7.L)             ; $2B3B86
        MOVE.W  #$0003,$5E(A4,A7.L)             ; $2B3B8A
        MOVE.W  (A7),$58(A4,D0.W)               ; $2B3B90
        MOVE.W  $0010(A3),$6E00(A7)             ; $2B3B94
        DC.W    $0000,$0010         ; $2B3B9A ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2B3B9E ORI.B  #$0030,-(A0)
        ADDI.B  #$6F00,(A0)                     ; $2B3BA2
        ORI.W  #$0050,D0                        ; $2B3BA6
        SUBI.B  #$7000,(A0)                     ; $2B3BAA
        ORI.W  #$0070,-(A0)                     ; $2B3BAE
        SUBI.B  #$6F00,(A0)                     ; $2B3BB2
        DC.W    $0000,$0030         ; $2B3BB6 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2B3BBA ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2B3BBE ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2B3BC2 ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2B3BC6
        DC.W    $00B0,$0210,$0400,$00D0; $2B3BCC ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2B3BD4 DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2B3BD6
        ORI.L  #$00900611,-(A0)                 ; $2B3BDA
        BTST    D3,D1                           ; $2B3BE0
        DC.W    $00B0,$0010,$6A00,$00E0; $2B3BE2 ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2B3BEA DC.W    $00F0
        BTST    D0,D0                           ; $2B3BEC
        BTST    D0,(A0)                         ; $2B3BEE
        DC.W    $0210,$6C00         ; $2B3BF0 ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2B3BF4
        SUBI.B  #$6B00,(A0)                     ; $2B3BF8
        BTST    D0,D0                           ; $2B3BFC
        DC.W    $00F0               ; $2B3BFE DC.W    $00F0
        DC.W    $0211,$6901         ; $2B3C00 ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2B3C04 DC.W    $00E0
        DC.W    $0010,$6300         ; $2B3C06 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2B3C0A
        BCHG    D0,(A0)                         ; $2B3C0C
        BCHG    D0,-(A0)                        ; $2B3C0E
        BCHG    D0,$10(A0,D0.W)                 ; $2B3C10
        BCS.W  loc_2B3DA6                       ; $2B3C14
        BCLR    D0,D0                           ; $2B3C18
        SUBI.B  #$6400,(A0)                     ; $2B3C1A
        BCHG    D0,-(A0)                        ; $2B3C1E
        BCHG    D0,(A0)                         ; $2B3C20
        ADDI.B  #$6201,(A1)                     ; $2B3C22
        BCHG    D0,$10(A0,D0.W)                 ; $2B3C26
        BPL.W  loc_2B3DCC                       ; $2B3C2A
        BCLR    D0,-$40(A0,D0.W)                ; $2B3C2E
        BSET    D0,(A0)                         ; $2B3C32
        DC.W    $0210,$6C00         ; $2B3C34 ANDI.B  #$6C00,(A0)
        BSET    D0,-$20(A0,D0.W)                ; $2B3C38
        SUBI.B  #$6B00,(A0)                     ; $2B3C3C
        BSET    D0,D0                           ; $2B3C40
        BCLR    D0,$11(A0,D0.W)                 ; $2B3C42
        BVS.S  loc_2B3C49                       ; $2B3C46
        BSET    D0,(A0)                         ; $2B3C48
        DC.W    $0010,$6300         ; $2B3C4A ORI.B  #$6300,(A0)
        DC.W    $0200,$0210         ; $2B3C4E ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2B3C52 ANDI.B  #$0230,-(A0)
        DC.W    $0210,$6500         ; $2B3C56 ANDI.B  #$6500,(A0)
        ANDI.W  #$0240,(A0)                     ; $2B3C5A
        SUBI.B  #$6400,(A0)                     ; $2B3C5E
        DC.W    $0220,$0210         ; $2B3C62 ANDI.B  #$0210,-(A0)
        DC.W    $0211,$6201         ; $2B3C66 ANDI.B  #$6201,(A1)
        DC.W    $0200,$0010         ; $2B3C6A ANDI.B  #$0010,D0
        BNE.W  loc_2B3ED0                       ; $2B3C6E
        ANDI.W  #$0280,-$70(A0,D0.W)            ; $2B3C72
        ADDI.B  #$6700,(A0)                     ; $2B3C78
        ANDI.L  #$02B00410,-(A0)                ; $2B3C7C
        BVC.W  loc_2B3F44                       ; $2B3C82
        DC.W    $02D0               ; $2B3C86 DC.W    $02D0
        SUBI.B  #$6700,(A0)                     ; $2B3C88
        ANDI.W  #$0290,-(A0)                    ; $2B3C8C
        DC.W    $0010,$0300         ; $2B3C90 ORI.B  #$0300,(A0)
        DC.W    $02E0               ; $2B3C94 DC.W    $02E0
        DC.W    $02F0               ; $2B3C96 DC.W    $02F0
        BTST    D1,D0                           ; $2B3C98
        BTST    D1,(A0)                         ; $2B3C9A
        DC.W    $0210,$0500         ; $2B3C9C ANDI.B  #$0500,(A0)
        BTST    D1,$20(A0,D0.W)                 ; $2B3CA0
        SUBI.B  #$0400,(A0)                     ; $2B3CA4
        BTST    D1,D0                           ; $2B3CA8
        DC.W    $02F0               ; $2B3CAA DC.W    $02F0
        DC.W    $0010,$6500         ; $2B3CAC ORI.B  #$6500,(A0)
        BCHG    D1,D0                           ; $2B3CB0
        BCHG    D1,(A0)                         ; $2B3CB2
        BCHG    D1,-(A0)                        ; $2B3CB4
        BCHG    D1,$10(A0,D0.W)                 ; $2B3CB6
        BLS.W  loc_2B404C                       ; $2B3CBA
        BCLR    D1,D0                           ; $2B3CBE
        SUBI.B  #$6400,(A0)                     ; $2B3CC0
        BCHG    D1,-(A0)                        ; $2B3CC4
        BCHG    D1,(A0)                         ; $2B3CC6
        DC.W    $0010,$0300         ; $2B3CC8 ORI.B  #$0300,(A0)
        BSET    D1,-(A0)                        ; $2B3CCC
        BSET    D1,$00(A0,D0.W)                 ; $2B3CCE
        SUBI.B  #$0210,(A0)                     ; $2B3CD2
        BTST    D2,D0                           ; $2B3CD6
        SUBI.B  #$0420,$10(A0,D0.W)             ; $2B3CD8
        SUBI.B  #$0400,D0                       ; $2B3CDE
        BSET    D1,$10(A0,D0.W)                 ; $2B3CE2
        BCS.W  loc_2B4128                       ; $2B3CE6
        SUBI.W  #$0460,(A0)                     ; $2B3CEA
        SUBI.W  #$0210,$00(A0,D6.W)             ; $2B3CEE
        SUBI.L  #$04800410,(A0)                 ; $2B3CF4
        BCC.W  loc_2B415C                       ; $2B3CFA
        SUBI.W  #$0000,(A0)                     ; $2B3CFE
        BNE.W  loc_2B40A4                       ; $2B3D02
        BCLR    D1,-$40(A0,D0.W)                ; $2B3D06
        BSET    D1,(A0)                         ; $2B3D0A
        DC.W    $0000,$6600         ; $2B3D0C ORI.B  #$6600,D0
        SUBI.L  #$04B004C0,-(A0)                ; $2B3D10
        DC.W    $04D0               ; $2B3D16 DC.W    $04D0
        CMPI.B  #$004E,D0                       ; $2B3D18
        ORI.W  #$F95E,A6                        ; $2B3D1C
        BSET    D0,(A4)+                        ; $2B3D20
        DC.W    $00C1               ; $2B3D22 DC.W    $00C1
        MOVE.W  (A5)+,(A4)+                     ; $2B3D24
        DC.W    $020B,$FFC4         ; $2B3D26 ANDI.B  #$FFC4,A3
        MOVE.W  -(A6),-$50(A3,D0.W)             ; $2B3D2A
        ORI.W  #$F841,(A7)+                     ; $2B3D2E
        ANDI.W  #$018F,$3E(A7,A7.L)             ; $2B3D32
        DC.W    $02B8,$FFB3,$F81E,$0384; $2B3D38 ANDI.L  #$FFB3F81E,$0384.W
        ORI.W  #$F9BF,A1                        ; $2B3D40
        ANDI.L  #$00B0F8B9,A1                   ; $2B3D44
        DC.W    $034B               ; $2B3D4A BCHG    D1,A3
        BCHG    D0,$F86E0343                    ; $2B3D4C
        BCHG    D0,D3                           ; $2B3D52
        DC.W    $F7FF,$02AF         ; $2B3D54 MOVE.W  <EA:3F>,-$51(PC,D0.W)
        DC.W    $00FB               ; $2B3D58 DC.W    $00FB
        DC.W    $F73E               ; $2B3D5A MOVE.W  <EA:3E>,-(A3)
        BTST    D1,$0174(A0)                    ; $2B3D5C
        MOVE.W  (A4),-$5C(PC,D0.W)              ; $2B3D60
        BCLR    D0,-(A3)                        ; $2B3D64
        MOVE.W  (A7)+,D4                        ; $2B3D66
        BCHG    D1,-(A1)                        ; $2B3D68
        ORI.L  #$F78503C1,-(A7)                 ; $2B3D6A
        DC.W    $0108               ; $2B3D70 BTST    D0,A0
        MOVEA.W $02E3(A6),A4                    ; $2B3D72
        BCLR    D0,-(A0)                        ; $2B3D76
        MOVE.W  (A4),(A4)+                      ; $2B3D78
        DC.W    $02E2               ; $2B3D7A DC.W    $02E2
        BSET    D0,(A4)                         ; $2B3D7C
        MOVE.W  -$4E(A2,D0.W),$016F(A4)         ; $2B3D7E
        MOVE.W  (A0)+,-(A4)                     ; $2B3D84
        BCLR    D0,(A0)+                        ; $2B3D86
        BTST    D0,-$3F(A3,A7.L)                ; $2B3D88
        BTST    D1,(A5)+                        ; $2B3D8C
        BCHG    D0,$6B(A3,A7.L)                 ; $2B3D8E
        BSET    D0,(A2)                         ; $2B3D92
loc_2B3D94:
        BTST    D0,D5                           ; $2B3D94
        MOVE.W  A6,$2D(A4,D0.W)                 ; $2B3D96
        DC.W    $0108               ; $2B3D9A BTST    D0,A0
        MOVE.W  $01(A3,D0.W),$43(A4,D0.W)       ; $2B3D9C
        MOVE.W  A2,(A4)                         ; $2B3DA2
        BSET    D0,$01EC(A3)                    ; $2B3DA4
        MOVE.W  -(A4),D4                        ; $2B3DA8
        DC.W    $0213,$01D4         ; $2B3DAA ANDI.B  #$01D4,(A3)
        MOVE.W  (A1),-$27(A4,D0.W)              ; $2B3DAE
        BTST    D0,D3                           ; $2B3DB2
        MOVE.W  -(A7),D4                        ; $2B3DB4
        DC.W    $01BF               ; $2B3DB6 BCLR    D0,<EA:3F>
        BSET    D0,(A0)                         ; $2B3DB8
        MOVE.W  D6,(A4)                         ; $2B3DBA
        DC.W    $021D,$FF2D         ; $2B3DBC ANDI.B  #$FF2D,(A5)+
        MOVE.W  A6,(A4)                         ; $2B3DC0
        ANDI.W  #$FEED,-$29(A7,A7.W)            ; $2B3DC2
loc_2B3DC8:
        BTST    D1,-$21(A3,A7.L)                ; $2B3DC8
loc_2B3DCC:
        DC.W    $F7BF,$02E8         ; $2B3DCC MOVE.W  <EA:3F>,-$18(A3,D0.W)
        DC.W    $0034,$F8DC,$0262   ; $2B3DD0 ORI.B  #$F8DC,$62(A4,D0.W)
        MOVE.W  $F815032E,-(A7)                 ; $2B3DD6
        ORI.W  #$F769,D0                        ; $2B3DDC
        DC.W    $0225,$FFAE         ; $2B3DE0 ANDI.B  #$FFAE,-(A5)
        MOVE.W  (A1)+,$4B(A3,D0.W)              ; $2B3DE4
        MOVE.W  (A0),-$072C(A7)                 ; $2B3DE8
        DC.W    $02C3               ; $2B3DEC DC.W    $02C3
        MOVE.W  (A2),-(A7)                      ; $2B3DEE
        MOVE.W  $02B8(A0),(A4)+                 ; $2B3DF0
        MOVE.W  -(A2),-$088B(A7)                ; $2B3DF4
        BSET    D0,-$008B(A0)                   ; $2B3DF8
        MOVE.W  $7B(A4,D0.W),(A4)+              ; $2B3DFC
        MOVE.W  -$0622(A2),-(A7)                ; $2B3E00
        DC.W    $00EB               ; $2B3E04 DC.W    $00EB
        DC.W    $00CC               ; $2B3E06 DC.W    $00CC
        MOVE.W  -(A4),-$18(A4,D0.W)             ; $2B3E08
        MOVE.W  -$25(A0,A7.L),$0236(A7)         ; $2B3E0C
        MOVE.W  -$06F6(A7),$39(A7,D0.W)         ; $2B3E12
        DC.W    $00CC               ; $2B3E18 DC.W    $00CC
        DC.W    $FA3F               ; $2B3E1A MOVE.W  <EA:3F>,D5
        DC.W    $014A               ; $2B3E1C BCHG    D0,A2
        MOVE.W  (A5),-$068B(A7)                 ; $2B3E1E
        ANDI.L  #$FF95FA78,(A0)+                ; $2B3E22
        DC.W    $014D               ; $2B3E28 BCHG    D0,A5
        DC.W    $00B2,$F9A4,$029A,$00B2; $2B3E2A ORI.L  #$F9A4029A,-$4E(A2,D0.W)
        MOVE.W  $0D(A4,D0.W),-(A4)              ; $2B3E32
        DC.W    $00F8               ; $2B3E36 DC.W    $00F8
        MOVE.W  $0032(A5),$69(A4,D0.W)          ; $2B3E38
        MOVEA.W (A5),A5                         ; $2B3E3E
        BCLR    D0,(A1)                         ; $2B3E40
        ORI.W  #$F9DD,D1                        ; $2B3E42
        BCHG    D0,-$002F(A4)                   ; $2B3E46
        MOVE.W  (A0),-(A4)                      ; $2B3E4A
        ORI.W  #$015C,-$47(A1,A7.L)             ; $2B3E4C
        BSET    D0,(A0)                         ; $2B3E52
        DC.W    $0034,$FAE5,$FFE7   ; $2B3E54 ORI.B  #$FAE5,-$19(A4,A7.L)
        BSET    D0,(A2)+                        ; $2B3E5A
        MOVE.W  $0054(A1),(A5)+                 ; $2B3E5C
        BCLR    D0,$F961.W                      ; $2B3E60
        DC.W    $003E,$0141         ; $2B3E64 ORI.B  #$0141,<EA:3E>
        MOVE.W  (A5)+,-$002F(A4)                ; $2B3E68
        BCHG    D0,-(A4)                        ; $2B3E6C
        MOVE.W  A3,(A5)+                        ; $2B3E6E
        DC.W    $002E,$0220,$F943   ; $2B3E70 ORI.B  #$0220,-$06BD(A6)
        DC.W    $0017,$01A9         ; $2B3E76 ORI.B  #$01A9,(A7)
        MOVEA.W -$0099(A2),A5                   ; $2B3E7A
        DC.W    $0221,$FA9B         ; $2B3E7E ANDI.B  #$FA9B,-(A1)
        MOVE.W  D6,$0221(A7)                    ; $2B3E82
        MOVE.W  $22(A1,D0.W),-(A5)              ; $2B3E86
        BCLR    D0,-$051C(PC)                   ; $2B3E8A
        ORI.W  #$01BA,(A7)                      ; $2B3E8E
        MOVE.W  -$37(A3,D0.W),D5                ; $2B3E92
        DC.W    $002F,$FA4E,$0152   ; $2B3E96 ORI.B  #$FA4E,$0152(A7)
        MOVE.W  $70(PC,A7.L),-$11(A7,D0.W)      ; $2B3E9C
        MOVE.W  -$07AD(A4),$66(A7,D0.W)         ; $2B3EA2
        DC.W    $0020,$FA2E         ; $2B3EA8 ORI.B  #$FA2E,-(A0)
        BSET    D0,-$5A(A7,A7.L)                ; $2B3EAC
        MOVEA.W A6,A4                           ; $2B3EB0
        BCLR    D0,(A5)                         ; $2B3EB2
        MOVE.W  (A0)+,$11(A7,A7.L)              ; $2B3EB4
        DC.W    $00D8               ; $2B3EB8 DC.W    $00D8
        DC.W    $FFDE               ; $2B3EBA MOVE.W  (A6)+,<EA:3F>
        MOVEA.W A4,A4                           ; $2B3EBC
        BTST    D0,$FFC5.W                      ; $2B3EBE
        MOVE.W  (A7),$57(A4,D0.W)               ; $2B3EC2
        MOVE.W  -$06A3(A5),-$0009(A7)           ; $2B3EC6
        MOVE.W  D6,$0E(A7,A7.L)                 ; $2B3ECC
loc_2B3ED0:
        DC.W    $00F8               ; $2B3ED0 DC.W    $00F8
        MOVE.W  #$F959,$0017(A7)                ; $2B3ED2
        MOVE.W  -(A4),-(A7)                     ; $2B3ED8
        MOVE.W  (A1)+,(A4)                      ; $2B3EDA
        DC.W    $FFDE               ; $2B3EDC MOVE.W  (A6)+,<EA:3F>
        MOVE.W  -$0751(A2),-(A7)                ; $2B3EDE
        MOVE.W  -$00E2(A0),-$47(A7,A7.L)        ; $2B3EE2
        DC.W    $0003,$FF57         ; $2B3EE8 ORI.B  #$FF57,D3
        MOVE.W  (A7),$58(A4,D0.W)               ; $2B3EEC
        MOVE.W  $0010(A2),$6E00(A7)             ; $2B3EF0
        DC.W    $0000,$0010         ; $2B3EF6 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2B3EFA ORI.B  #$0030,-(A0)
        ADDI.B  #$6F00,(A0)                     ; $2B3EFE
        ORI.W  #$0050,D0                        ; $2B3F02
        SUBI.B  #$7000,(A0)                     ; $2B3F06
        ORI.W  #$0070,-(A0)                     ; $2B3F0A
        SUBI.B  #$6F00,(A0)                     ; $2B3F0E
        DC.W    $0000,$0030         ; $2B3F12 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2B3F16 ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2B3F1A ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2B3F1E ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2B3F22
loc_2B3F28:
        DC.W    $00B0,$0210,$0400,$00D0; $2B3F28 ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2B3F30 DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2B3F32
        ORI.L  #$00900611,-(A0)                 ; $2B3F36
        BTST    D3,D1                           ; $2B3F3C
        DC.W    $00B0,$0010,$6A00,$00E0; $2B3F3E ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2B3F46 DC.W    $00F0
        BTST    D0,D0                           ; $2B3F48
        BTST    D0,(A0)                         ; $2B3F4A
        DC.W    $0210,$6C00         ; $2B3F4C ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2B3F50
        SUBI.B  #$6B00,(A0)                     ; $2B3F54
        BTST    D0,D0                           ; $2B3F58
        DC.W    $00F0               ; $2B3F5A DC.W    $00F0
        DC.W    $0211,$6901         ; $2B3F5C ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2B3F60 DC.W    $00E0
        DC.W    $0010,$6300         ; $2B3F62 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2B3F66
        BCHG    D0,(A0)                         ; $2B3F68
        BCHG    D0,-(A0)                        ; $2B3F6A
        BCHG    D0,$10(A0,D0.W)                 ; $2B3F6C
        BCS.W  loc_2B4102                       ; $2B3F70
        BCLR    D0,D0                           ; $2B3F74
        SUBI.B  #$6400,(A0)                     ; $2B3F76
        BCHG    D0,-(A0)                        ; $2B3F7A
        BCHG    D0,(A0)                         ; $2B3F7C
        ADDI.B  #$6201,(A1)                     ; $2B3F7E
        BCHG    D0,$10(A0,D0.W)                 ; $2B3F82
        BPL.W  loc_2B4128                       ; $2B3F86
        BCLR    D0,-$40(A0,D0.W)                ; $2B3F8A
        BSET    D0,(A0)                         ; $2B3F8E
        DC.W    $0210,$6C00         ; $2B3F90 ANDI.B  #$6C00,(A0)
        BSET    D0,-$20(A0,D0.W)                ; $2B3F94
        SUBI.B  #$6B00,(A0)                     ; $2B3F98
        BSET    D0,D0                           ; $2B3F9C
        BCLR    D0,$11(A0,D0.W)                 ; $2B3F9E
        BVS.S  loc_2B3FA5                       ; $2B3FA2
        BSET    D0,(A0)                         ; $2B3FA4
        DC.W    $0010,$6300         ; $2B3FA6 ORI.B  #$6300,(A0)
        DC.W    $0200,$0210         ; $2B3FAA ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2B3FAE ANDI.B  #$0230,-(A0)
        DC.W    $0210,$6500         ; $2B3FB2 ANDI.B  #$6500,(A0)
        ANDI.W  #$0240,(A0)                     ; $2B3FB6
        SUBI.B  #$6400,(A0)                     ; $2B3FBA
        DC.W    $0220,$0210         ; $2B3FBE ANDI.B  #$0210,-(A0)
        DC.W    $0211,$6201         ; $2B3FC2 ANDI.B  #$6201,(A1)
        DC.W    $0200,$0010         ; $2B3FC6 ANDI.B  #$0010,D0
        BNE.W  $2B422C                          ; $2B3FCA
        ANDI.W  #$0280,-$70(A0,D0.W)            ; $2B3FCE
        ADDI.B  #$6700,(A0)                     ; $2B3FD4
        ANDI.L  #$02B00410,-(A0)                ; $2B3FD8
        BVC.W  $2B42A0                          ; $2B3FDE
        DC.W    $02D0               ; $2B3FE2 DC.W    $02D0
        SUBI.B  #$6700,(A0)                     ; $2B3FE4
        ANDI.W  #$0290,-(A0)                    ; $2B3FE8
        DC.W    $0010,$0300         ; $2B3FEC ORI.B  #$0300,(A0)
        DC.W    $02E0               ; $2B3FF0 DC.W    $02E0
        DC.W    $02F0               ; $2B3FF2 DC.W    $02F0
        BTST    D1,D0                           ; $2B3FF4
        BTST    D1,(A0)                         ; $2B3FF6
        DC.W    $0210,$0500         ; $2B3FF8 ANDI.B  #$0500,(A0)
        BTST    D1,$20(A0,D0.W)                 ; $2B3FFC
        SUBI.B  #$0400,(A0)                     ; $2B4000
        BTST    D1,D0                           ; $2B4004
        DC.W    $02F0               ; $2B4006 DC.W    $02F0
        DC.W    $0010,$6500         ; $2B4008 ORI.B  #$6500,(A0)
        BCHG    D1,D0                           ; $2B400C
        BCHG    D1,(A0)                         ; $2B400E
        BCHG    D1,-(A0)                        ; $2B4010
        BCHG    D1,$10(A0,D0.W)                 ; $2B4012
        BLS.W  $2B43A8                          ; $2B4016
        BCLR    D1,D0                           ; $2B401A
        SUBI.B  #$6400,(A0)                     ; $2B401C
        BCHG    D1,-(A0)                        ; $2B4020
        BCHG    D1,(A0)                         ; $2B4022
        DC.W    $0010,$0300         ; $2B4024 ORI.B  #$0300,(A0)
        BSET    D1,-(A0)                        ; $2B4028
        BSET    D1,$00(A0,D0.W)                 ; $2B402A
        SUBI.B  #$0210,(A0)                     ; $2B402E
        BTST    D2,D0                           ; $2B4032
        SUBI.B  #$0420,$10(A0,D0.W)             ; $2B4034
        SUBI.B  #$0400,D0                       ; $2B403A
        BSET    D1,$10(A0,D0.W)                 ; $2B403E
        BCS.W  $2B4484                          ; $2B4042
        SUBI.W  #$0460,(A0)                     ; $2B4046
        SUBI.W  #$0210,$00(A0,D6.W)             ; $2B404A
        SUBI.L  #$04800410,(A0)                 ; $2B4050
        BCC.W  $2B44B8                          ; $2B4056
        SUBI.W  #$0000,(A0)                     ; $2B405A
        BNE.W  $2B4400                          ; $2B405E
        BCLR    D1,-$40(A0,D0.W)                ; $2B4062
        BSET    D1,(A0)                         ; $2B4066
        DC.W    $0000,$6600         ; $2B4068 ORI.B  #$6600,D0
        SUBI.L  #$04B004C0,-(A0)                ; $2B406C
        DC.W    $04D0               ; $2B4072 DC.W    $04D0
        CMPI.B  #$0052,D0                       ; $2B4074
        ORI.W  #$F963,(A2)                      ; $2B4078
        BSET    D0,(A7)                         ; $2B407C
        DC.W    $00BF,$F8E0,$020B   ; $2B407E ORI.L  #$F8E0020B,<EA:3F>
        DC.W    $FFC5               ; $2B4084 MOVE.W  D5,<EA:3F>
        MOVE.W  -(A5),-$61(A3,D0.W)             ; $2B4086
        ORI.W  #$F842,-(A5)                     ; $2B408A
        ANDI.W  #$0193,-(A1)                    ; $2B408E
        MOVE.W  #$02BB,-(A4)                    ; $2B4092
        MOVE.W  -$07EA(PC),$78(A7,D0.W)         ; $2B4096
        ORI.W  #$F9BF,(A0)+                     ; $2B409C
        ANDI.L  #$00B4F8B3,D7                   ; $2B40A0
        BTST    D1,$0186(PC)                    ; $2B40A6
        MOVEA.W $0332(A1),A4                    ; $2B40AA
        DC.W    $014E               ; $2B40AE BCHG    D0,A6
        DC.W    $F7FE,$029B         ; $2B40B0 MOVE.W  <EA:3E>,-$65(PC,D0.W)
        BTST    D0,D2                           ; $2B40B4
        MOVE.W  $030B0180,-(A3)                 ; $2B40B6
        MOVE.W  A3,-$76(PC,D0.W)                ; $2B40BC
        BCLR    D0,$18(A3,A7.L)                 ; $2B40C0
        BCHG    D1,(A1)                         ; $2B40C4
        DC.W    $00B4,$F77B,$03A9,$0118; $2B40C6 ORI.L  #$F77B03A9,$18(A4,D0.W)
        MOVEA.W $02EC(A6),A4                    ; $2B40CE
        BCLR    D0,-$072C(A1)                   ; $2B40D2
        DC.W    $02DC               ; $2B40D6 DC.W    $02DC
        BSET    D0,(A5)+                        ; $2B40D8
        MOVE.W  $0190018A,-(A4)                 ; $2B40DA
        MOVE.W  (A4)+,(A4)+                     ; $2B40E0
        BCLR    D0,D3                           ; $2B40E2
        DC.W    $014F               ; $2B40E4 BCHG    D0,A7
        MOVE.W  A0,(A4)+                        ; $2B40E6
        BTST    D1,(A4)                         ; $2B40E8
        BCHG    D0,$36(A7,A7.L)                 ; $2B40EA
        BCLR    D0,$011D(A1)                    ; $2B40EE
        MOVE.W  D4,$0207(A4)                    ; $2B40F2
        BTST    D0,-$068F(A7)                   ; $2B40F6
        BSET    D0,(A2)+                        ; $2B40FA
        BCHG    D0,-(A4)                        ; $2B40FC
        MOVEA.W (A1),A4                         ; $2B40FE
        BCHG    D0,$0205(PC)                    ; $2B4100
        MOVE.W  -(A7),-$6E(PC,D0.W)             ; $2B4104
        BSET    D0,$57(A1,A7.L)                 ; $2B4108
        BCLR    D0,$1E(A7,D0.W)                 ; $2B410C
        MOVE.W  $0142.W,-$1F(PC,D0.W)           ; $2B4110
        MOVE.W  -$0B(A7,D0.W),(A4)              ; $2B4116
        BCHG    D0,-(A2)                        ; $2B411A
        DC.W    $F6FE               ; $2B411C MOVE.W  <EA:3E>,(A3)+
        DC.W    $01CE               ; $2B411E BSET    D0,A6
        ANDI.W  #$F7AE,-$4F(A1,D0.W)            ; $2B4120
        BSET    D0,-$58(A6,A7.L)                ; $2B4126
        DC.W    $0027,$015C         ; $2B412A ORI.B  #$015C,-(A7)
        MOVEA.W (A6)+,A4                        ; $2B412E
        DC.W    $0210,$FF2F         ; $2B4130 ANDI.B  #$FF2F,(A0)
        MOVEA.W $026B(A7),A4                    ; $2B4134
        MOVE.W  -$2F(A1,A7.W),(A7)+             ; $2B4138
        BTST    D1,-$14(A2,A7.L)                ; $2B413C
        MOVE.W  -$17(A2,D0.W),$3F(A3,D0.W)      ; $2B4140
        MOVE.W  $4A(PC,D0.W),(A4)               ; $2B4146
        MOVE.W  #$F810,-(A7)                    ; $2B414A
        BTST    D1,-(A3)                        ; $2B414E
        ORI.W  #$F748,A3                        ; $2B4150
        ANDI.W  #$FFBF,D3                       ; $2B4154
        MOVE.W  $0262(PC),-$00A0(A3)            ; $2B4158
        MOVE.W  D0,(A4)+                        ; $2B415E
        DC.W    $02AD,$FF17,$F8D5,$029E; $2B4160 ANDI.L  #$FF17F8D5,$029E(A5)
        MOVE.W  -(A5),-$08B7(A7)                ; $2B4168
        DC.W    $0206,$FF86         ; $2B416C ANDI.B  #$FF86,D6
        MOVE.W  (A7),(A4)+                      ; $2B4170
        ANDI.W  #$FF2D,-(A0)                    ; $2B4172
        MOVE.W  D2,#$00E6                       ; $2B4176
        DC.W    $00CC               ; $2B417A DC.W    $00CC
        MOVE.W  A6,-$15(A4,D0.W)                ; $2B417C
        MOVE.W  -$27(A0,A7.L),$0244(A7)         ; $2B4180
        MOVE.W  $04(A0,A7.L),$40(A7,D0.W)       ; $2B4186
        DC.W    $00CD               ; $2B418C DC.W    $00CD
        MOVE.W  $0143(A7),D5                    ; $2B418E
        MOVE.W  (A1)+,-$0687(A7)                ; $2B4192
        ANDI.L  #$FF99FA63,(A4)+                ; $2B4196
        DC.W    $013E               ; $2B419C BTST    D0,<EA:3E>
        DC.W    $00B6,$F9A4,$0298,$00B7; $2B419E ORI.L  #$F9A40298,-$49(A6,D0.W)
        MOVE.W  D1,-$0015(A4)                   ; $2B41A6
        DC.W    $00ED               ; $2B41AA DC.W    $00ED
        MOVE.W  $17(A5,D0.W),$61(A4,D0.W)       ; $2B41AC
        DC.W    $FA3F               ; $2B41B2 MOVE.W  <EA:3F>,D5
        DC.W    $018E               ; $2B41B4 BCLR    D0,A6
        ORI.W  #$F9CC,D6                        ; $2B41B6
        BCHG    D0,-(A1)                        ; $2B41BA
        DC.W    $FFD3               ; $2B41BC MOVE.W  (A3),<EA:3F>
        MOVE.W  (A3),-(A4)                      ; $2B41BE
        ORI.W  #$0151,A0                        ; $2B41C0
        MOVE.W  (A5)+,-$42(A4,D0.W)             ; $2B41C4
        DC.W    $0038,$FAF0,$FFE7   ; $2B41C8 ORI.B  #$FAF0,$FFE7.W
        BSET    D0,(A7)                         ; $2B41CE
        MOVE.W  $0054(A2),(A5)+                 ; $2B41D0
        BCLR    D0,$68(A7,A7.L)                 ; $2B41D4
        DC.W    $001E,$0138         ; $2B41D8 ORI.B  #$0138,(A6)+
        MOVE.W  -$0050(A6),$0157(A4)            ; $2B41DC
        MOVE.W  A6,(A5)+                        ; $2B41E2
        DC.W    $0028,$021E,$F94C   ; $2B41E4 ORI.B  #$021E,-$06B4(A0)
        DC.W    $FFF2,$019E         ; $2B41EA MOVE.W  -$62(A2,D0.W),<EA:3F>
        MOVEA.W -$0098(A3),A5                   ; $2B41EE
        DC.W    $0221,$FA9C         ; $2B41F2 ANDI.B  #$FA9C,-(A1)
        MOVE.W  D7,$0221(A7)                    ; $2B41F6
        MOVE.W  $23(A2,D0.W),-(A5)              ; $2B41FA
        BCLR    D0,-$051B(PC)                   ; $2B41FE
