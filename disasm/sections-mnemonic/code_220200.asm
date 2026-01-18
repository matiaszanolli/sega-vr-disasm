; Generated assembly for $220200-$222200
; Branch targets: 42
; Labels: 31
; Format: DC.W with decoded mnemonics as comments

        org     $220200

        BSET    D0,-(A0)                        ; $220200
        BSET    D0,$00(A0,D0.W)                 ; $220202
        ORI.W  #$9A01,D1                        ; $220206
        DC.W    $0210,$0220         ; $22020A ANDI.B  #$0220,(A0)
        DC.W    $0230,$0041,$9A01   ; $22020E ANDI.B  #$0041,$01(A0,A1.L)
loc_220214:
        ANDI.W  #$0200,D0                       ; $220214
        ANDI.W  #$0052,(A0)                     ; $220218
        BTST    D0,D0                           ; $22021C
        ANDI.W  #$0270,-(A0)                    ; $22021E
        ANDI.L  #$02900041,D0                   ; $220222
        SUB.B  D5,D1                            ; $220228
        ANDI.L  #$02B002C0,-(A0)                ; $22022A
        ORI.W  #$9901,D1                        ; $220230
        DC.W    $02D0               ; $220234 DC.W    $02D0
        ANDI.W  #$0220,(A0)                     ; $220236
        ORI.W  #$9B01,D1                        ; $22023A
        DC.W    $02E0               ; $22023E DC.W    $02E0
        DC.W    $02F0               ; $220240 DC.W    $02F0
        BTST    D1,D0                           ; $220242
        ORI.W  #$9B01,D1                        ; $220244
        BTST    D1,(A0)                         ; $220248
        DC.W    $02C0               ; $22024A DC.W    $02C0
        DC.W    $02F0               ; $22024C DC.W    $02F0
        CMPI.B  #$0033,D0                       ; $22024E
        DC.W    $001B,$F06B         ; $220252 ORI.B  #$F06B,(A3)+
        DC.W    $00F0               ; $220256 DC.W    $00F0
        BNE.S  loc_22029E                       ; $220258
        ROR.W  $0115(A1)                        ; $22025A
loc_22025E:
        BCS.S  loc_220229                       ; $22025E
        ASL.B  #7,D1                            ; $220260
        DC.W    $00C4               ; $220262 DC.W    $00C4
        BLS.S  loc_22024F                       ; $220264
        MOVE.W  -(A1),(A0)+                     ; $220266
        DC.W    $00C4               ; $220268 DC.W    $00C4
        BCC.S  loc_2202DF                       ; $22026A
        ASL.L  D5,D3                            ; $22026C
        BTST    D0,(A5)                         ; $22026E
        BNE.S  loc_2202E2                       ; $220270
        ROXR.L  #5,D3                           ; $220272
        DC.W    $00F0               ; $220274 DC.W    $00F0
        BEQ.S  loc_2202F0                       ; $220276
        ASL.W  #4,D5                            ; $220278
        DC.W    $00C4               ; $22027A DC.W    $00C4
        BNE.S  loc_22029D                       ; $22027C
        ROR.L  D5,D5                            ; $22027E
        DC.W    $00C4               ; $220280 DC.W    $00C4
        BCC.S  loc_22024F                       ; $220282
        ASL.B  D6,D2                            ; $220284
        BTST    D0,-(A0)                        ; $220286
loc_220288:
        BCS.S  loc_22025E                       ; $220288
        ROXR.W  -(A6)                           ; $22028A
        DC.W    $00C4               ; $22028C DC.W    $00C4
        BLS.S  loc_220288                       ; $22028E
        LSR.L  #4,D4                            ; $220290
        ANDI.W  #$6019,D1                       ; $220292
        LSR.L  #4,D4                            ; $220296
        DC.W    $00B1,$6018,$E9A5,$00B1; $220298 ORI.L  #$6018E9A5,-$4F(A1,D0.W)
        BRA.S  loc_2202AF                       ; $2202A0
        ASL.L  D4,D4                            ; $2202A2
        ANDI.W  #$600E,D1                       ; $2202A4
        ROXL.L  D4,D0                           ; $2202A8
        DC.W    $00B2,$6132,$E9B0,$0241; $2202AA ORI.L  #$6132E9B0,$41(A2,D0.W)
        BSR.S  loc_2202E6                       ; $2202B2
        ROXR.L  #4,D7                           ; $2202B4
        ANDI.W  #$613D,D1                       ; $2202B6
        ROXR.L  #4,D7                           ; $2202BA
        DC.W    $00B2,$613D,$E8A3,$00B2; $2202BC ORI.L  #$613DE8A3,-$4E(A2,D0.W)
        BHI.S  loc_220326                       ; $2202C4
        ASR.L  D4,D3                            ; $2202C6
        ANDI.W  #$6260,D1                       ; $2202C8
        ASL.L  #3,D2                            ; $2202CC
        ANDI.W  #$6148,D1                       ; $2202CE
        LSL.L  #3,D5                            ; $2202D2
        ANDI.W  #$626B,D1                       ; $2202D4
        ROXR.L  #4,D7                           ; $2202D8
        DC.W    $02DC               ; $2202DA DC.W    $02DC
        BSR.S  loc_22031B                       ; $2202DC
        LSR.L  #4,D4                            ; $2202DE
        DC.W    $02DC               ; $2202E0 DC.W    $02DC
loc_2202E2:
        BRA.S  loc_2202FD                       ; $2202E2
        ROXL.W  D3,D6                           ; $2202E4
loc_2202E6:
        ANDI.W  #$6024,D1                       ; $2202E6
        ROXL.W  D3,D6                           ; $2202EA
        DC.W    $02DC               ; $2202EC DC.W    $02DC
        BRA.S  loc_220314                       ; $2202EE
loc_2202F0:
        LSR.B  #4,D3                            ; $2202F0
        SUBI.B  #$60B1,(A6)                     ; $2202F2
        ASL.W  D5,D7                            ; $2202F6
        ANDI.W  #$6100,A3                       ; $2202F8
        ROXR.L  D5,D0                           ; $2202FC
        DC.W    $00B4,$6169,$EC04,$00B4; $2202FE ORI.L  #$6169EC04,-$4C(A4,D0.W)
        BRA.S  loc_2202B0                       ; $220306
        ASR.L  D7,D7                            ; $220308
        ANDI.W  #$6192,-(A5)                    ; $22030A
        ROXL.W  D6                              ; $22030E
        DC.W    $00B4,$6100,$EF6A,$00B4; $220310 ORI.L  #$6100EF6A,-$4C(A4,D0.W)
        BHI.S  loc_22032A                       ; $220318
        ROXR.W  (A3)                            ; $22031A
        ANDI.L  #$60CBE989,(A1)+                ; $22031C
        DC.W    $02E9               ; $220322 DC.W    $02E9
        BLS.S  loc_22036B                       ; $220324
loc_220326:
        LSR.L  D4,D2                            ; $220326
        DC.W    $00B4,$6367,$EA66,$00B4; $220328 ORI.L  #$6367EA66,-$4C(A4,D0.W)
        BLS.S  loc_220348                       ; $220330
        LSR.B  #5,D4                            ; $220332
        BTST    D1,$61DC(A2)                    ; $220334
        ROXL.W  D4,D5                           ; $220338
        DC.W    $00B4,$625F,$E7D3,$02C7; $22033A ORI.L  #$625FE7D3,-$39(A4,D0.W)
        BRA.S  loc_220361                       ; $220342
        ROL.W  (A3)                             ; $220344
        ANDI.W  #$601D,A4                       ; $220346
        ROXR.B  D4,D5                           ; $22034A
        ANDI.W  #$601A,A4                       ; $22034C
        ROXR.B  D4,D5                           ; $220350
        DC.W    $02C7               ; $220352 DC.W    $02C7
        BRA.S  loc_220370                       ; $220354
        ASR.B  #4,D3                            ; $220356
        SUBI.L  #$60B1E803,A6                   ; $220358
        SUBI.B  #$60B1,D5                       ; $22035E
        ROXR.B  #4,D3                           ; $220362
        SUBI.B  #$60B0,D5                       ; $220364
        ROXR.B  #4,D3                           ; $220368
        SUBI.L  #$60B0E7DD,A6                   ; $22036A
loc_220370:
        SUBI.W  #$60B3,-$1823(A1)               ; $220370
        SUBI.W  #$60B3,(A4)+                    ; $220376
        ROR.B  D4,D1                            ; $22037A
        SUBI.W  #$60AE,(A4)+                    ; $22037C
        ROR.B  D4,D1                            ; $220380
        SUBI.W  #$60AE,$0014(A1)                ; $220382
        MOVE.B  D0,-(A3)                        ; $220388
        ORI.L  #$00B000C0,-(A0)                 ; $22038A
        DC.W    $00D0               ; $220390 DC.W    $00D0
        SUBI.B  #$1300,(A0)                     ; $220392
        DC.W    $00E0               ; $220396 DC.W    $00E0
        DC.W    $00F0               ; $220398 DC.W    $00F0
        DC.W    $0210,$BF00         ; $22039A ANDI.B  #$BF00,(A0)
        BTST    D0,D0                           ; $22039E
        ORI.L  #$04101300,-(A0)                 ; $2203A0
        BCHG    D0,-(A0)                        ; $2203A6
        BCHG    D0,$14(A0,D0.W)                 ; $2203A8
        MOVE.B  D0,-(A3)                        ; $2203AC
        BCLR    D0,(A0)                         ; $2203AE
        BCLR    D0,D0                           ; $2203B0
        ADDI.B  #$C001,(A1)                     ; $2203B2
        BCLR    D0,-(A0)                        ; $2203B6
        ADDI.B  #$BE01,(A1)                     ; $2203B8
        BCHG    D0,-(A0)                        ; $2203BC
        DC.W    $0006,$8500         ; $2203BE ORI.B  #$8500,D6
        DC.W    $0000,$0010         ; $2203C2 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2203C6 ORI.B  #$0030,-(A0)
        ADDI.B  #$8600,D0                       ; $2203CA
        ORI.L  #$00900400,D0                    ; $2203CE
        OR.B   D3,D0                            ; $2203D4
        ORI.W  #$0070,D0                        ; $2203D6
        SUBI.B  #$8600,D0                       ; $2203DA
        ORI.W  #$0060,(A0)                      ; $2203DE
        DC.W    $0010,$1300         ; $2203E2 ORI.B  #$1300,(A0)
        BTST    D0,D0                           ; $2203E6
        BTST    D0,(A0)                         ; $2203E8
        BTST    D0,-(A0)                        ; $2203EA
        BTST    D0,$10(A0,D0.W)                 ; $2203EC
        MOVE.B  D0,-(A6)                        ; $2203F0
        BCHG    D0,(A0)                         ; $2203F2
        BCHG    D0,D0                           ; $2203F4
        ORI.W  #$9A01,D1                        ; $2203F6
        BCLR    D0,-$40(A0,D0.W)                ; $2203FA
        BSET    D0,(A0)                         ; $2203FE
        ORI.W  #$9A01,D1                        ; $220400
        BSET    D0,-(A0)                        ; $220404
        BSET    D0,$00(A0,D0.W)                 ; $220406
        ORI.W  #$9901,D1                        ; $22040A
        DC.W    $0210,$01D0         ; $22040E ANDI.B  #$01D0,(A0)
        BSET    D0,$41(A0,D0.W)                 ; $220412
        SUB.B  D5,D1                            ; $220416
        DC.W    $0220,$0230         ; $220418 ANDI.B  #$0230,-(A0)
        ANDI.W  #$0041,D0                       ; $22041C
        SUB.B  D4,D1                            ; $220420
loc_220422:
        ANDI.W  #$0260,(A0)                     ; $220422
        BSET    D0,D0                           ; $220426
        ORI.W  #$0100,(A2)                      ; $220428
        ANDI.W  #$0280,-$70(A0,D0.W)            ; $22042C
        ANDI.L  #$00401B00,-(A0)                ; $220432
        DC.W    $02B0,$02C0,$02D0,$02E0; $220438 ANDI.L  #$02C002D0,-$20(A0,D0.W)
        ORI.W  #$1B00,D0                        ; $220440
        DC.W    $02F0               ; $220444 DC.W    $02F0
        BTST    D1,D0                           ; $220446
        BTST    D1,(A0)                         ; $220448
        BTST    D1,-(A0)                        ; $22044A
        CMPI.B  #$0008,D0                       ; $22044C
        DC.W    $0008,$F687         ; $220450 ORI.B  #$F687,A0
        BCHG    D0,$63D5(A5)                    ; $220454
        MOVE.W  A0,(A2)                         ; $220458
        DC.W    $007E,$63C7         ; $22045A ORI.W  #$63C7,<EA:3E>
        DC.W    $F3BE,$007E         ; $22045E MOVE.W  <EA:3E>,$7E(A1,D0.W)
        BSR.S  loc_220422                       ; $220462
        MOVE.W  $016D(A3),$6189(PC)             ; $220464
        MOVE.W  (A6),$007E5F77                  ; $22046A
        MOVE.W  $016D(A6),$5F66(PC)             ; $220470
        MOVE.W  -(A3),(A4)                      ; $220476
        ANDI.W  #$624A,A3                       ; $220478
        MOVE.W  -(A6),D4                        ; $22047C
        ANDI.W  #$5FFE,A3                       ; $22047E
        DC.W    $0014,$8600         ; $220482 ORI.B  #$8600,(A4)
        DC.W    $0000,$0010         ; $220486 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $22048A ORI.B  #$0030,-(A0)
        SUBI.B  #$8500,(A4)                     ; $22048E
        ORI.W  #$0050,D0                        ; $220492
        DC.W    $0216,$8400         ; $220496 ANDI.B  #$8400,(A6)
        ORI.W  #$0060,$15(A0,D0.W)              ; $22049A
        OR.B   D2,D1                            ; $2204A0
        DC.W    $0000,$0C00         ; $2204A2 ORI.B  #$0C00,D0
        DC.W    $001A,$001A         ; $2204A6 ORI.B  #$001A,(A2)+
        ROXR.B  #8,D1                           ; $2204AA
        DC.W    $00C0               ; $2204AC DC.W    $00C0
        SPL     D0                              ; $2204AE
        ADDA.L  (A5)+,A7                        ; $2204B0
        DC.W    $00C0               ; $2204B2 DC.W    $00C0
        SUBQ.W  #3,(A2)+                        ; $2204B4
        ADDA.L  -(A6),A7                        ; $2204B6
        DC.W    $00C0               ; $2204B8 DC.W    $00C0
        SUBQ.W  #3,(A5)                         ; $2204BA
        ROR.B  #8,D2                            ; $2204BC
        DC.W    $00C0               ; $2204BE DC.W    $00C0
        ADDQ.L  #5,-$6D(A7,A5.L)                ; $2204C0
        DC.W    $00C0               ; $2204C4 DC.W    $00C0
        SUBQ.L  #3,D2                           ; $2204C6
        ADDA.L  A0,A7                           ; $2204C8
        DC.W    $00C0               ; $2204CA DC.W    $00C0
        SUBQ.B  #5,A2                           ; $2204CC
        ADD.W  D7,$00C0(A5)                     ; $2204CE
        SUBQ.W  #5,-$20CE(A5)                   ; $2204D2
        DC.W    $00C0               ; $2204D6 DC.W    $00C0
        SUBQ.L  #3,$DADC.W                      ; $2204D8
        DC.W    $00C2               ; $2204DC DC.W    $00C2
        SUBQ.L  #7,(A6)                         ; $2204DE
        ADD.W  D4,-(A4)                         ; $2204E0
        DC.W    $00C2               ; $2204E2 DC.W    $00C2
        ADDQ.W  #4,-(A3)                        ; $2204E4
        ADD.W  D6,D0                            ; $2204E6
        DC.W    $00C2               ; $2204E8 DC.W    $00C2
        ADDQ.B  #4,(A1)                         ; $2204EA
        ADD.W  D6,-$3E(A4,D0.W)                 ; $2204EC
        SGE     (A0)+                           ; $2204F0
        ADD.W  D7,$00C8(A6)                     ; $2204F2
        SUBQ.W  #5,-$20CE(A4)                   ; $2204F6
        DC.W    $00C8               ; $2204FA DC.W    $00C8
        SUBQ.L  #3,$30(A7,A5.L)                 ; $2204FC
        DC.W    $00C8               ; $220500 DC.W    $00C8
        DC.W    $57FF               ; $220502 SEQ     <EA:3F>
        ADD.W  -(A6),D7                         ; $220504
        DC.W    $00C8               ; $220506 DC.W    $00C8
        ADDQ.B  #6,(A0)                         ; $220508
        ADD.W  D7,-(A5)                         ; $22050A
        DC.W    $00C8               ; $22050C DC.W    $00C8
        SUBQ.W  #5,$6D(A5,A5.L)                 ; $22050E
        DC.W    $00DD               ; $220512 DC.W    $00DD
        SUBQ.W  #5,-$209B(A5)                   ; $220514
        DC.W    $00E5               ; $220518 DC.W    $00E5
        SUBQ.W  #5,$31(A5,A5.L)                 ; $22051A
        DC.W    $00DD               ; $22051E DC.W    $00DD
        SUBQ.L  #3,$DF29.W                      ; $220520
        DC.W    $00E5               ; $220524 DC.W    $00E5
        SUBQ.L  #3,$54(A0,A5.L)                 ; $220526
        BCLR    D0,(A5)                         ; $22052A
        BHI.S  loc_220548                       ; $22052C
        ADD.L  (A0)+,D3                         ; $22052E
        BCLR    D0,(A5)                         ; $220530
        SUBQ.W  #4,$DAC0029A                    ; $220532
        ADDQ.B  #4,A4                           ; $220538
        ADD.B  D5,A6                            ; $22053A
        BCHG    D0,D1                           ; $22053C
        DC.W    $577F               ; $22053E SUBQ.W  #3,<EA:3F>
        ADD.W  $33(A6,D0.W),D5                  ; $220540
        ADDQ.L  #4,A3                           ; $220544
        DC.W    $0008,$1400         ; $220546 ORI.B  #$1400,A0
        ORI.W  #$0050,D0                        ; $22054A
        ORI.W  #$0070,-(A0)                     ; $22054E
        SUBI.B  #$B100,(A0)+                    ; $220552
        DC.W    $00C0               ; $220556 DC.W    $00C0
        DC.W    $00D0               ; $220558 DC.W    $00D0
        SUBI.B  #$B200,(A6)                     ; $22055A
        DC.W    $00F0               ; $22055E DC.W    $00F0
        DC.W    $00E0               ; $220560 DC.W    $00E0
        SUBI.B  #$A400,(A6)                     ; $220562
        DC.W    $00B0,$00A0,$0418,$8500; $220566 ORI.L  #$00A00418,$00(A0,A0.W)
        ORI.L  #$00900416,D0                    ; $22056E
        OR.B   D0,D3                            ; $220574
        BCHG    D0,(A0)                         ; $220576
        BCHG    D0,-(A0)                        ; $220578
        DC.W    $0004,$1B00         ; $22057A ORI.B  #$1B00,D4
        DC.W    $0000,$0010         ; $22057E ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $220582 ORI.B  #$0030,-(A0)
        DC.W    $0000,$2000         ; $220586 ORI.B  #$2000,D0
        BTST    D0,D0                           ; $22058A
        DC.W    $00C0               ; $22058C DC.W    $00C0
        BTST    D0,(A0)                         ; $22058E
        BTST    D0,-(A0)                        ; $220590
        DC.W    $0000,$2000         ; $220592 ORI.B  #$2000,D0
        BTST    D0,$10(A0,D0.W)                 ; $220596
        BTST    D0,-(A0)                        ; $22059A
        BCHG    D0,D0                           ; $22059C
        DC.W    $0001,$9A01         ; $22059E ORI.B  #$9A01,D1
        BCHG    D0,-$80(A0,D0.W)                ; $2205A2
        BCLR    D0,(A0)                         ; $2205A6
        CMPI.B  #$004D,D0                       ; $2205A8
        ORI.W  #$E5D2,D5                        ; $2205AC
        DC.W    $00B7,$5F0F,$E76B,$00B1; $2205B0 ORI.L  #$5F0FE76B,-$4F(A7,D0.W)
        SUBQ.B  #7,D2                           ; $2205B8
        ROXL.W  D3,D7                           ; $2205BA
        DC.W    $00B1,$6024,$E5D6,$00B1; $2205BC ORI.L  #$6024E5D6,-$4F(A1,D0.W)
        BRA.S  loc_2205FA                       ; $2205C4
        ROXL.W  D2,D5                           ; $2205C6
        DC.W    $00B1,$6038,$E573,$00C3; $2205C8 ORI.L  #$6038E573,-$3D(A1,D0.W)
        ADDQ.L  #7,-$197B(A5)                   ; $2205D0
        DC.W    $00C4               ; $2205D4 DC.W    $00C4
        ADDQ.L  #7,(A5)                         ; $2205D6
        ROR.W  D4,D6                            ; $2205D8
        DC.W    $00C0               ; $2205DA DC.W    $00C0
        ADDQ.L  #7,A0                           ; $2205DC
        ASR.L  #4,D1                            ; $2205DE
        DC.W    $00B1,$5EF6,$E83A,$00BA; $2205E0 ORI.L  #$5EF6E83A,-$46(A1,D0.W)
        ADDQ.L  #5,$E65800BE                    ; $2205E8
        SPL     D0                              ; $2205EE
        ROR.W  #3,D0                            ; $2205F0
        DC.W    $00BE,$5AB6,$E839   ; $2205F2 ORI.L  #$5AB6E839,<EA:3E>
        DC.W    $00BA,$5AAF,$E83E,$00BA; $2205F8 ORI.L  #$5AAFE83E,$00BA(PC)
        SUBQ.B  #5,A2                           ; $220600
        ASR.W  #4,D4                            ; $220602
        DC.W    $00BA,$5B6F,$E663,$00BE; $220604 ORI.L  #$5B6FE663,$00BE(PC)
        DC.W    $5B7D               ; $22060C SUBQ.W  #5,<EA:3D>
        ROR.W  #3,D5                            ; $22060E
        DC.W    $00BE,$5B17,$E7F5   ; $220610 ORI.L  #$5B17E7F5,<EA:3E>
        DC.W    $00BA,$562C,$E614,$00BE; $220616 ORI.L  #$562CE614,$00BE(PC)
        DBCS    D7,$21E0FC                      ; $22061E
        DC.W    $00C2               ; $220622 DC.W    $00C2
        SUBQ.L  #7,(A6)                         ; $220624
        ASR.W  D2,D7                            ; $220626
        DC.W    $00BE,$59B4,$E64A   ; $220628 ORI.L  #$59B4E64A,<EA:3E>
        DC.W    $00BE,$59B4,$E64A   ; $22062E ORI.L  #$59B4E64A,<EA:3E>
        DC.W    $00BE,$59BE,$E468   ; $220634 ORI.L  #$59BEE468,<EA:3E>
        DC.W    $00BE,$59BE,$E44F   ; $22063A ORI.L  #$59BEE44F,<EA:3E>
        DC.W    $00BF,$580A,$E633   ; $220640 ORI.L  #$580AE633,<EA:3F>
        DC.W    $00BE,$5809,$E633   ; $220646 ORI.L  #$5809E633,<EA:3E>
        DC.W    $00BE,$5813,$E44F   ; $22064C ORI.L  #$5813E44F,<EA:3E>
        DC.W    $00BF,$5813,$E3F4   ; $220652 ORI.L  #$5813E3F4,<EA:3F>
        DC.W    $00BF,$5A26,$E3CC   ; $220658 ORI.L  #$5A26E3CC,<EA:3F>
        DC.W    $00BF,$5A4D,$E011   ; $22065E ORI.L  #$5A4DE011,<EA:3F>
        DC.W    $00C0               ; $220664 DC.W    $00C0
        SPL     D0                              ; $220666
        ROR.B  #8,D2                            ; $220668
        DC.W    $00C0               ; $22066A DC.W    $00C0
        ADDQ.L  #5,$6D(A7,A5.L)                 ; $22066C
        DC.W    $00C0               ; $220670 DC.W    $00C0
        SUBQ.W  #5,-$2038(A5)                   ; $220672
        DC.W    $00C0               ; $220676 DC.W    $00C0
        SUBQ.B  #5,A2                           ; $220678
        ROL.B  D2,D7                            ; $22067A
        DC.W    $00C0               ; $22067C DC.W    $00C0
        SUBQ.L  #2,A5                           ; $22067E
        ASR.W  #4,D4                            ; $220680
        DC.W    $00C0               ; $220682 DC.W    $00C0
        SUBQ.W  #5,-$199C(A7)                   ; $220684
        DC.W    $00C4               ; $220688 DC.W    $00C4
        SUBQ.W  #5,#$E1BB                       ; $22068A
        DC.W    $00C0               ; $22068E DC.W    $00C0
        SUBQ.B  #4,(A5)                         ; $220690
        LSR.B  #1,D2                            ; $220692
        DC.W    $00C0               ; $220694 DC.W    $00C0
        SVC     D5                              ; $220696
        LSR.W  #4,D5                            ; $220698
        DC.W    $00C0               ; $22069A DC.W    $00C0
        SMI     $61(A5,A6.W)                    ; $22069C
        DC.W    $00C4               ; $2206A0 DC.W    $00C4
        ADDQ.B  #6,D2                           ; $2206A2
        ADD.W  D7,$00C8(A6)                     ; $2206A4
        SUBQ.W  #5,-$181E(A4)                   ; $2206A8
        DC.W    $00C2               ; $2206AC DC.W    $00C2
        SGE     (A1)                            ; $2206AE
        LSR.W  D3,D4                            ; $2206B0
        DC.W    $00C4               ; $2206B2 DC.W    $00C4
        SGE     (A0)+                           ; $2206B4
        ADD.W  D6,-$3E(A4,D0.W)                 ; $2206B6
        SGE     (A0)+                           ; $2206BA
        ROL.W  -$3E(PC,D0.W)                    ; $2206BC
        ADDQ.L  #7,A7                           ; $2206C0
        ADD.W  -(A6),D7                         ; $2206C2
        DC.W    $00C8               ; $2206C4 DC.W    $00C8
        ADDQ.B  #6,(A0)                         ; $2206C6
        ROR.W  #3,D4                            ; $2206C8
        DC.W    $00C4               ; $2206CA DC.W    $00C4
        SUBQ.L  #5,D4                           ; $2206CC
        ASR.W  D3,D5                            ; $2206CE
        DC.W    $00D9               ; $2206D0 DC.W    $00D9
        SUBQ.W  #5,#$E65D                       ; $2206D2
        DC.W    $00E1               ; $2206D6 DC.W    $00E1
        SUBQ.L  #5,D4                           ; $2206D8
        LSR.W  (A1)+                            ; $2206DA
        DC.W    $00C7               ; $2206DC DC.W    $00C7
        DC.W    $5B7F               ; $2206DE SUBQ.W  #5,<EA:3F>
        LSR.W  -(A1)                            ; $2206E0
        DC.W    $00C7               ; $2206E2 DC.W    $00C7
        SUBQ.W  #5,-$1E(A7,A6.W)                ; $2206E4
        DC.W    $00DC               ; $2206E8 DC.W    $00DC
        SUBQ.W  #5,-$26(A7,A6.W)                ; $2206EA
        DC.W    $00E4               ; $2206EE DC.W    $00E4
        DC.W    $5B7F               ; $2206F0 SUBQ.W  #5,<EA:3F>
        ADD.W  D7,$00DD(A5)                     ; $2206F2
        SUBQ.W  #5,-$209B(A5)                   ; $2206F6
        DC.W    $00E5               ; $2206FA DC.W    $00E5
        SUBQ.W  #5,$3B(A5,A6.W)                 ; $2206FC
        DC.W    $022D,$5F1D,$DFDF   ; $220700 ANDI.B  #$5F1D,-$2021(A5)
        DC.W    $00B4,$5F3B,$E0A0,$00B4; $220706 ORI.L  #$5F3BE0A0,-$4C(A4,D0.W)
        SUBQ.B  #7,D1                           ; $22070E
        LSL.B  #8,D1                            ; $220710
        ANDI.W  #$5F07,-(A1)                    ; $220712
        ROL.W  D0,D0                            ; $220716
        DC.W    $00B4,$5F14,$E28E,$0289; $220718 ORI.L  #$5F14E28E,-$77(A4,D0.W)
        SUBQ.L  #7,(A5)                         ; $220720
        ROR.B  D1,D1                            ; $220722
        DC.W    $00B4,$5F55,$E2D8,$00B4; $220724 ORI.L  #$5F55E2D8,-$4C(A4,D0.W)
        SLE     (A1)+                           ; $22072C
        ASL.W  -(A3)                            ; $22072E
        ANDI.L  #$5F35E880,(A6)                 ; $220730
        ANDI.W  #$5EF7,D1                       ; $220736
        LSL.W  D3,D2                            ; $22073A
        ANDI.W  #$5F02,D1                       ; $22073C
        ROXL.W  D3,D6                           ; $220740
        ANDI.W  #$6024,D1                       ; $220742
        LSR.L  #4,D4                            ; $220746
        ANDI.W  #$6019,D1                       ; $220748
        ROR.B  #4,D3                            ; $22074C
        DC.W    $00BA,$58B5,$E632,$00BE; $22074E ORI.L  #$58B5E632,$00BE(PC)
        ADDQ.B  #4,D3                           ; $220756
        ROXR.B  D3,D2                           ; $220758
        DC.W    $00BE,$57F9,$E81B   ; $22075A ORI.L  #$57F9E81B,<EA:3E>
        DC.W    $00BA,$58AA,$E7BE,$012D; $220760 ORI.L  #$58AAE7BE,$012D(PC)
        SGT     -$42(PC,A6.W)                   ; $220768
        DC.W    $00B2,$5EFB,$E820,$00B2; $22076C ORI.L  #$5EFBE820,-$4E(A2,D0.W)
        SGT     $E820.W                         ; $220774
        BTST    D0,$5EF8(A5)                    ; $220778
        DC.W    $0008,$1400         ; $22077C ORI.B  #$1400,A0
        DC.W    $00D0               ; $220780 DC.W    $00D0
        DC.W    $00E0               ; $220782 DC.W    $00E0
        DC.W    $00F0               ; $220784 DC.W    $00F0
        BTST    D0,D0                           ; $220786
        DC.W    $0208,$0E00         ; $220788 ANDI.B  #$0E00,A0
        BTST    D0,-(A0)                        ; $22078C
        BTST    D0,(A0)                         ; $22078E
        ADDI.B  #$0D00,A0                       ; $220790
        DC.W    $0210,$0220         ; $220794 ANDI.B  #$0220,(A0)
        ADDI.B  #$1300,A0                       ; $220798
        DC.W    $00F0               ; $22079C DC.W    $00F0
        DC.W    $0200,$0418         ; $22079E ANDI.B  #$0418,D0
        CMP.B  D0,D0                            ; $2207A2
        ANDI.W  #$0290,D0                       ; $2207A4
        ADDI.B  #$B100,(A0)+                    ; $2207A8
        DC.W    $00E0               ; $2207AC DC.W    $00E0
        DC.W    $0230,$0216,$B400   ; $2207AE ANDI.B  #$0216,$00(A0,A3.W)
        ANDI.W  #$0280,$16(A0,D0.W)             ; $2207B4
        MOVE.L  D0,D2                           ; $2207BA
        ANDI.L  #$02B00418,-(A0)                ; $2207BC
        OR.B   D2,D0                            ; $2207C2
        DC.W    $02D0               ; $2207C4 DC.W    $02D0
        ORI.W  #$0216,-(A0)                     ; $2207C6
        OR.B   D0,D2                            ; $2207CA
        BTST    D0,-$40(A0,D0.W)                ; $2207CC
        DC.W    $0216,$A300         ; $2207D0 ANDI.B  #$A300,(A6)
        DC.W    $02E0               ; $2207D4 DC.W    $02E0
        ANDI.L  #$0416B300,D0                   ; $2207D6
        ANDI.L  #$02400016,(A0)                 ; $2207DC
        MOVE.L  D0,D2                           ; $2207E2
        ORI.W  #$0060,(A0)                      ; $2207E4
        DC.W    $0010,$0000         ; $2207E8 ORI.B  #$0000,(A0)
        ADDI.B  #$A400,(A6)                     ; $2207EC
        ORI.W  #$0080,$10(A0,D0.W)              ; $2207F0
        MOVE.B  D0,-(A4)                        ; $2207F6
        SUBI.B  #$0420,(A0)                     ; $2207F8
        SUBI.B  #$BF00,(A0)                     ; $2207FC
        SUBI.W  #$0430,D0                       ; $220800
        DC.W    $0210,$1300         ; $220804 ANDI.B  #$1300,(A0)
        DC.W    $0020,$0010         ; $220808 ORI.B  #$0010,-(A0)
        SUBI.B  #$8400,(A6)                     ; $22080C
        DC.W    $0030,$0000,$0416   ; $220810 ORI.B  #$0000,$16(A0,D0.W)
        MOVE.L  D0,D2                           ; $220816
        ORI.W  #$0050,D0                        ; $220818
        SUBI.B  #$8501,(A1)+                    ; $22081C
        BTST    D0,$04(A0,D0.W)                 ; $220820
        MOVE.B  D0,-(A5)                        ; $220824
        ORI.L  #$00A000B0,(A0)                  ; $220826
        DC.W    $00C0               ; $22082C DC.W    $00C0
        ADDI.B  #$1B00,D4                       ; $22082E
        BSET    D0,-(A0)                        ; $220832
        BSET    D0,$05(A0,D0.W)                 ; $220834
        MOVE.W  D1,-(A4)                        ; $220838
        BSET    D0,D0                           ; $22083A
        DC.W    $00B0,$01D0,$0204,$F900; $22083C ORI.L  #$01D00204,$00(A0,A7.L)
        ANDI.W  #$0260,(A0)                     ; $220844
        DC.W    $0000,$2000         ; $220848 ORI.B  #$2000,D0
        BTST    D1,-(A0)                        ; $22084C
        BTST    D1,$40(A0,D0.W)                 ; $22084E
        BCHG    D1,(A0)                         ; $220852
        SUBI.B  #$2000,D0                       ; $220854
        BTST    D1,D0                           ; $220858
        BTST    D1,(A0)                         ; $22085A
        DC.W    $0004,$F900         ; $22085C ORI.B  #$F900,D4
        BCHG    D0,D0                           ; $220860
        BCHG    D0,(A0)                         ; $220862
        BCHG    D0,-(A0)                        ; $220864
        BCHG    D0,$04(A0,D0.W)                 ; $220866
        MOVE.W  D0,-(A4)                        ; $22086A
        BCLR    D0,D0                           ; $22086C
        BCLR    D0,(A0)                         ; $22086E
        BCLR    D0,-(A0)                        ; $220870
        BCLR    D0,$00(A0,D0.W)                 ; $220872
        MOVE.L  D0,D0                           ; $220876
        DC.W    $02F0               ; $220878 DC.W    $02F0
        ANDI.W  #$0300,D0                       ; $22087A
        BTST    D1,(A0)                         ; $22087E
        DC.W    $0000,$2000         ; $220880 ORI.B  #$2000,D0
        BCHG    D1,-(A0)                        ; $220884
        BCHG    D1,D0                           ; $220886
        BCHG    D1,(A0)                         ; $220888
        BCHG    D1,$01(A0,D0.W)                 ; $22088A
        SUB.B  D3,D1                            ; $22088E
        BCLR    D1,D0                           ; $220890
        BCLR    D1,(A0)                         ; $220892
        BCLR    D1,-(A0)                        ; $220894
        DC.W    $0001,$9801         ; $220896 ORI.B  #$9801,D1
        BCLR    D1,-$60(A0,D0.W)                ; $22089A
        BSET    D1,D0                           ; $22089E
        DC.W    $0001,$9801         ; $2208A0 ORI.B  #$9801,D1
        BSET    D1,(A0)                         ; $2208A4
        BSET    D1,-(A0)                        ; $2208A6
        BSET    D1,$01(A0,D0.W)                 ; $2208A8
        SUB.B  D3,D1                            ; $2208AC
        SUBI.B  #$03C0,D0                       ; $2208AE
        BSET    D1,-(A0)                        ; $2208B2
        ORI.W  #$0A00,D4                        ; $2208B4
        SUBI.W  #$0460,(A0)                     ; $2208B8
        SUBI.W  #$0480,$52(A0,D0.W)             ; $2208BC
        BTST    D0,D0                           ; $2208C2
        SUBI.L  #$04A004B0,(A0)                 ; $2208C4
        DC.W    $04C0               ; $2208CA DC.W    $04C0
        CMPI.B  #$0059,D0                       ; $2208CC
        ORI.W  #$F03C,A5                        ; $2208D0
        ORI.L  #$5995EE24,A2                    ; $2208D4
        ORI.L  #$5A22EE22,(A6)+                 ; $2208DA
        ORI.L  #$5A19F039,(A6)+                 ; $2208E0
        ORI.L  #$598CF055,A2                    ; $2208E6
        ORI.L  #$59E3F076,A2                    ; $2208EC
        ORI.L  #$5A46EE49,A5                    ; $2208F2
        ORI.L  #$5AD2EE34,(A6)+                 ; $2208F8
        ORI.L  #$5A6DF076,(A6)+                 ; $2208FE
        ORI.L  #$5A47EE4A,(A4)                  ; $220904
        ORI.L  #$5AD2F0A1,-(A4)                 ; $22090A
        ORI.L  #$5AC1EE65,(A4)                  ; $220910
        ORI.L  #$5B51EE88,-(A4)                 ; $220916
        ORI.L  #$5C26F0E8,-(A4)                 ; $22091C
        ORI.L  #$5B8BEC15,(A4)                  ; $220922
        DC.W    $00AB,$5A76,$EC14,$00AB; $220928 ORI.L  #$5A76EC14,$00AB(A3)
        ADDQ.W  #5,-$1210(A4)                   ; $220930
        ORI.L  #$592FEBF7,(A6)+                 ; $220934
        DC.W    $00AB,$5988,$EBF5,$00AB; $22093A ORI.L  #$5988EBF5,$00AB(A3)
        DC.W    $597E               ; $220942 SUBQ.W  #4,<EA:3E>
        ROXL.W  $009E(A6)                       ; $220944
        SUBQ.B  #4,-(A5)                        ; $220948
        LSR.B  D6,D3                            ; $22094A
        DC.W    $00AB,$5B29,$EC1F,$00AB; $22094C ORI.L  #$5B29EC1F,$00AB(A3)
        SPL     D5                              ; $220954
        ROXL.B  D6,D5                           ; $220956
        ORI.L  #$55BCEB84,(A6)+                 ; $220958
        DC.W    $00AB,$560C,$EC2C,$00B2; $22095E ORI.L  #$560CEC2C,$00B2(A3)
        SUBQ.B  #5,-$13C1(A2)                   ; $220966
        DC.W    $00B2,$5BAD,$ECC3,$00B2; $22096A ORI.L  #$5BADECC3,-$4E(A2,D0.W)
        SUBQ.W  #7,-(A3)                        ; $220972
loc_220974:
        ROXR.W  #6,D6                           ; $220974
        DC.W    $00B2,$5C82,$EF25,$00A4; $220976 ORI.L  #$5C82EF25,-$5C(A2,D0.W)
        SGT     $1D(PC,A6.L)                    ; $22097E
        DC.W    $00B4,$5AAA,$EA1C,$00B4; $220982 ORI.L  #$5AAAEA1C,-$4C(A4,D0.W)
        ADDQ.L  #5,-(A0)                        ; $22098A
        ASR.B  D5,D6                            ; $22098C
        DC.W    $00B4,$5B61,$EA20,$00B4; $22098E ORI.L  #$5B61EA20,-$4C(A4,D0.W)
        SPL     #$E9F1                          ; $220996
        DC.W    $00B4,$5638,$EE45,$00A4; $22099A ORI.L  #$5638EE45,-$5C(A4,D0.W)
        SPL     (A4)+                           ; $2209A2
        LSR.W  #7,D3                            ; $2209A4
        DC.W    $00B9,$5AD3,$EE45,$00C1,$5ADC; $2209A6 ORI.L  #$5AD3EE45,$00C15ADC
        ASL.W  D4,D4                            ; $2209B0
        DC.W    $00B1,$6011,$E88C,$00B1; $2209B2 ORI.L  #$6011E88C,-$4F(A1,D0.W)
        BRA.S  loc_2209D4                       ; $2209BA
        ASR.L  #4,D1                            ; $2209BC
        DC.W    $00B1,$5EF6,$E95E,$00B5; $2209BE ORI.L  #$5EF6E95E,-$4B(A1,D0.W)
        SGT     $28(A5,A6.L)                    ; $2209C6
        DC.W    $00BB,$5B61,$E99F,$00BB; $2209CA ORI.L  #$5B61E99F,-$45(PC,D0.W)
        ADDQ.L  #7,D5                           ; $2209D2
loc_2209D4:
        ASL.L  D4,D5                            ; $2209D4
        DC.W    $00B1,$600D,$EA31,$00BB; $2209D6 ORI.L  #$600DEA31,-$45(A1,D0.W)
        SMI     -(A7)                           ; $2209DE
        LSR.W  #5,D0                            ; $2209E0
        DC.W    $00BB,$5CBC,$E83A,$00BA; $2209E2 ORI.L  #$5CBCE83A,-$46(PC,D0.W)
        ADDQ.L  #5,$E83900BA                    ; $2209EA
        ADDQ.L  #5,-$15ED(A7)                   ; $2209F0
        DC.W    $00B4,$59A1,$E829,$00BA; $2209F4 ORI.L  #$59A1E829,-$46(A4,D0.W)
        SUBQ.L  #4,-(A2)                        ; $2209FC
        LSR.B  D4,D1                            ; $2209FE
        DC.W    $00BA,$5998,$EA12,$00B4; $220A00 ORI.L  #$5998EA12,$00B4(PC)
        SUBQ.L  #4,(A7)                         ; $220A08
        ASR.W  #4,D4                            ; $220A0A
        DC.W    $00BA,$5B6F,$E83E,$00BA; $220A0C ORI.L  #$5B6FE83E,$00BA(PC)
        SUBQ.B  #5,A2                           ; $220A14
        ROL.W  -$46(A5,D0.W)                    ; $220A16
        ADDQ.B  #3,-$1782(A4)                   ; $220A1A
        DC.W    $00C0               ; $220A1E DC.W    $00C0
        ADDQ.L  #7,A0                           ; $220A20
        ASR.W  #4,D4                            ; $220A22
        DC.W    $00C0               ; $220A24 DC.W    $00C0
        SUBQ.W  #5,-$179B(A7)                   ; $220A26
        DC.W    $00C0               ; $220A2A DC.W    $00C0
        DBGE    D2,$21F27B                      ; $220A2C
        DC.W    $00C0               ; $220A30 DC.W    $00C0
        SMI     -$1E(A5,A6.W)                   ; $220A32
        DC.W    $00C2               ; $220A36 DC.W    $00C2
        SGE     (A1)                            ; $220A38
        ROL.W  -$3E(PC,D0.W)                    ; $220A3A
        ADDQ.L  #7,A7                           ; $220A3E
        ASR.B  D5,D0                            ; $220A40
        DC.W    $00BB,$5B6A,$EA27,$00D0; $220A42 ORI.L  #$5B6AEA27,-$30(PC,D0.W)
        SUBQ.W  #5,-(A1)                        ; $220A4A
        ASR.B  D5,D0                            ; $220A4C
        DC.W    $00D8               ; $220A4E DC.W    $00D8
        SUBQ.W  #5,-$199B(A2)                   ; $220A50
        DC.W    $00D9               ; $220A54 DC.W    $00D9
        SUBQ.W  #5,#$E65D                       ; $220A56
        DC.W    $00E1               ; $220A5A DC.W    $00E1
        SUBQ.L  #5,D4                           ; $220A5C
        LSL.L  D5,D6                            ; $220A5E
        ANDI.W  #$5F74,A3                       ; $220A60
        ROXL.B  D5,D5                           ; $220A64
        DC.W    $00B4,$5F9C,$EC31,$00B4; $220A66 ORI.L  #$5F9CEC31,-$4C(A4,D0.W)
        SUBQ.W  #7,D1                           ; $220A6E
        ROXL.W  D5                              ; $220A70
        ANDI.W  #$5F3F,-(A5)                    ; $220A72
        ROXL.B  D6,D1                           ; $220A76
        DC.W    $00B4,$5F2B,$EE52,$00B4; $220A78 ORI.L  #$5F2BEE52,-$4C(A4,D0.W)
        SUBQ.W  #7,D5                           ; $220A80
        ROXR.L  D6,D6                           ; $220A82
        ANDI.L  #$5F37E88C,(A1)+                ; $220A84
        ANDI.W  #$6019,D1                       ; $220A8A
        ASR.L  #4,D0                            ; $220A8E
        ANDI.W  #$5EF7,D1                       ; $220A90
        ROR.L  D5,D6                            ; $220A94
        BTST    D1,$5FCF(A2)                    ; $220A96
        ASR.W  #5,D1                            ; $220A9A
        DC.W    $00B4,$6007,$EE11,$009E; $220A9C ORI.L  #$6007EE11,-$62(A4,D0.W)
        DBVS    D2,$21FAC2                      ; $220AA4
        ORI.L  #$5931F01F,A2                    ; $220AA8
        ORI.L  #$593AEE13,A2                    ; $220AAE
        ORI.L  #$59D4EC08,(A6)+                 ; $220AB4
        DC.W    $00AB,$5A11,$EC09,$00AB; $220ABA ORI.L  #$5A11EC09,$00AB(A3)
        ADDQ.B  #5,(A2)+                        ; $220AC2
        ROXR.B  D5,D5                           ; $220AC4
        DC.W    $00B4,$59FC,$EA36,$00B4; $220AC6 ORI.L  #$59FCEA36,-$4C(A4,D0.W)
        ADDQ.B  #5,D5                           ; $220ACE
        ROXL.B  #4,D3                           ; $220AD0
        DC.W    $00B7,$58BE,$E81B,$00BA; $220AD2 ORI.L  #$58BEE81B,-$46(A7,D0.W)
        ADDQ.L  #4,$1B(A5,A6.L)                 ; $220ADA
        DC.W    $00BA,$58AA,$E912,$00B7; $220ADE ORI.L  #$58AAE912,$00B7(PC)
        ADDQ.L  #4,$16(A3,D0.W)                 ; $220AE6
        MOVE.L  D0,D2                           ; $220AEA
        ANDI.L  #$02700370,D0                   ; $220AEC
        ANDI.L  #$04168400,-(A0)                ; $220AF2
        BCLR    D1,(A0)                         ; $220AF8
        DC.W    $02D0               ; $220AFA DC.W    $02D0
        ADDI.B  #$A300,(A6)                     ; $220AFC
        BSET    D1,D0                           ; $220B00
        BCLR    D1,$17(A0,D0.W)                 ; $220B02
        MOVE.L  D1,-(A1)                        ; $220B06
        BCLR    D1,-(A0)                        ; $220B08
        DC.W    $0216,$A400         ; $220B0A ANDI.B  #$A400,(A6)
        DC.W    $02C0               ; $220B0E DC.W    $02C0
        DC.W    $02D0               ; $220B10 DC.W    $02D0
        SUBI.B  #$A300,(A6)                     ; $220B12
        BCLR    D0,(A0)                         ; $220B16
        BCLR    D0,$16(A0,D0.W)                 ; $220B18
        CMP.B  D0,D1                            ; $220B1C
        ANDI.L  #$01800616,(A0)                 ; $220B1E
        EOR.B  D1,D0                            ; $220B24
        BCLR    D1,-(A0)                        ; $220B26
        BCLR    D1,D0                           ; $220B28
        DC.W    $0218,$B000         ; $220B2A ANDI.B  #$B000,(A0)+
        BCHG    D1,D0                           ; $220B2E
        BSET    D0,$18(A0,D0.W)                 ; $220B30
        EOR.B  D0,D0                            ; $220B34
        BCHG    D0,D0                           ; $220B36
        BCLR    D0,D0                           ; $220B38
        ADDI.B  #$1400,A0                       ; $220B3A
        DC.W    $0200,$0150         ; $220B3E ANDI.B  #$0150,D0
        ADDI.B  #$1500,A0                       ; $220B42
        BCHG    D1,D0                           ; $220B46
        BCHG    D1,(A0)                         ; $220B48
        DC.W    $0208,$0F00         ; $220B4A ANDI.B  #$0F00,A0
        BCHG    D1,-(A0)                        ; $220B4E
        DC.W    $0210,$0208         ; $220B50 ANDI.B  #$0208,(A0)
        DC.W    $0E00               ; $220B54 DC.W    $0E00
        BCHG    D0,$50(A0,D0.W)                 ; $220B56
        SUBI.B  #$0D00,A0                       ; $220B5A
        BCHG    D0,-(A0)                        ; $220B5E
        ORI.W  #$0208,$00(A0,D1.W)              ; $220B60
        ORI.W  #$0140,-(A0)                     ; $220B66
        ADDI.B  #$1400,A0                       ; $220B6A
        ORI.W  #$0050,D0                        ; $220B6E
        DC.W    $0218,$B100         ; $220B72 ANDI.B  #$B100,(A0)+
        ORI.L  #$00900218,D0                    ; $220B76
        CMP.B  D0,D0                            ; $220B7C
        BCLR    D0,D0                           ; $220B7E
        BCHG    D0,D0                           ; $220B80
        ADDI.B  #$B300,(A6)                     ; $220B82
        DC.W    $00B0,$0190,$0616,$B400; $220B86 ORI.L  #$01900616,$00(A0,A3.W)
        ORI.L  #$00A00216,D0                    ; $220B8E
        MOVE.L  D0,-(A1)                        ; $220B94
        DC.W    $00D0               ; $220B96 DC.W    $00D0
        DC.W    $00C0               ; $220B98 DC.W    $00C0
        DC.W    $0216,$A200         ; $220B9A ANDI.B  #$A200,(A6)
        BCLR    D0,-$70(A0,D0.W)                ; $220B9E
        ADDI.B  #$8400,(A6)                     ; $220BA2
        BSET    D0,D0                           ; $220BA6
        BCLR    D0,-(A0)                        ; $220BA8
        DC.W    $0218,$8500         ; $220BAA ANDI.B  #$8500,(A0)+
        ANDI.L  #$02D00617,-(A0)                ; $220BAE
        OR.B   D1,D2                            ; $220BB4
        DC.W    $02B0,$0216,$A400,$0250; $220BB6 ANDI.L  #$0216A400,$50(A0,D0.W)
        ANDI.L  #$04188500,D0                   ; $220BBE
        ANDI.W  #$0270,-(A0)                    ; $220BC4
        SUBI.B  #$1300,(A0)                     ; $220BC8
        SUBI.L  #$04A00004,(A0)                 ; $220BCC
        MOVE.B  D0,-(A5)                        ; $220BD2
        DC.W    $0000,$0010         ; $220BD4 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $220BD8 ORI.B  #$0030,-(A0)
        ADDI.B  #$1B00,D4                       ; $220BDC
        DC.W    $00E0               ; $220BE0 DC.W    $00E0
        DC.W    $00F0               ; $220BE2 DC.W    $00F0
        SUBI.B  #$1B00,D4                       ; $220BE4
        BSET    D0,(A0)                         ; $220BE8
        BSET    D0,-(A0)                        ; $220BEA
        SUBI.B  #$1B00,D4                       ; $220BEC
        DC.W    $02E0               ; $220BF0 DC.W    $02E0
        DC.W    $02F0               ; $220BF2 DC.W    $02F0
        DC.W    $0000,$2000         ; $220BF4 ORI.B  #$2000,D0
        BSET    D1,(A0)                         ; $220BF8
        ANDI.L  #$03E003F0,(A0)                 ; $220BFA
        SUBI.B  #$2000,D0                       ; $220C00
        DC.W    $0230,$0240,$0004   ; $220C04 ANDI.B  #$0240,$04(A0,D0.W)
        MOVE.W  D0,-(A4)                        ; $220C0A
        BTST    D0,D0                           ; $220C0C
        BTST    D0,(A0)                         ; $220C0E
        BTST    D0,-(A0)                        ; $220C10
        BTST    D0,$00(A0,D0.W)                 ; $220C12
        MOVE.L  D0,D0                           ; $220C16
        DC.W    $0220,$0090         ; $220C18 ANDI.B  #$0090,-(A0)
        DC.W    $0230,$0240,$0004   ; $220C1C ANDI.B  #$0240,$04(A0,D0.W)
        MOVE.W  D0,-(A4)                        ; $220C22
        BTST    D1,D0                           ; $220C24
        BTST    D1,(A0)                         ; $220C26
        BTST    D1,-(A0)                        ; $220C28
        BTST    D1,$00(A0,D0.W)                 ; $220C2A
        MOVE.L  D0,D0                           ; $220C2E
        SUBI.B  #$03E0,D0                       ; $220C30
        BSET    D1,$10(A0,D0.W)                 ; $220C34
        DC.W    $0001,$9701         ; $220C38 ORI.B  #$9701,D1
        SUBI.B  #$0430,-(A0)                    ; $220C3C
        SUBI.W  #$0001,D0                       ; $220C40
        SUB.B  D3,D1                            ; $220C44
        SUBI.W  #$0460,(A0)                     ; $220C46
        SUBI.W  #$0001,$01(A0,A1.L)             ; $220C4A
        SUBI.L  #$04400460,D0                   ; $220C50
        DC.W    $0001,$9801         ; $220C56 ORI.B  #$9801,D1
        DC.W    $04B0,$04C0,$0430,$0044; $220C5A SUBI.L  #$04C00430,$44(A0,D0.W)
        DC.W    $0A00,$04D0         ; $220C62 EORI.B  #$04D0,D0
        DC.W    $04E0               ; $220C66 DC.W    $04E0
        DC.W    $04F0               ; $220C68 DC.W    $04F0
        BTST    D2,D0                           ; $220C6A
        ANDI.W  #$0900,D4                       ; $220C6C
        BTST    D2,-(A0)                        ; $220C70
        BTST    D2,(A0)                         ; $220C72
        SUBI.W  #$0A00,D4                       ; $220C74
        BCHG    D2,D0                           ; $220C78
        BTST    D2,$44(A0,D0.W)                 ; $220C7A
        BTST    D5,D0                           ; $220C7E
        BCHG    D2,(A0)                         ; $220C80
        BCHG    D2,-(A0)                        ; $220C82
        BCHG    D2,-$80(A0,D0.W)                ; $220C84
        CMPI.B  #$002E,D0                       ; $220C88
        DC.W    $002A,$F49B,$0065   ; $220C8C ORI.B  #$F49B,$0065(A2)
        DBEQ    D5,$21FEE2                      ; $220C92
        ORI.W  #$58E4,$4A(A7,A7.W)              ; $220C96
        ORI.W  #$58DB,-$6A(A7,A7.W)             ; $220C9C
        ORI.W  #$57C5,-(A5)                     ; $220CA2
        MOVE.W  $0065(A1),(A2)+                 ; $220CA6
        ADDQ.W  #4,D7                           ; $220CAA
        MOVE.W  -(A1),-(A2)                     ; $220CAC
        ORI.W  #$58A6,-$0D5C(A6)                ; $220CAE
        ORI.W  #$59A5,$7B(PC,A7.W)              ; $220CB4
        ORI.W  #$5942,$32(A7,A7.L)              ; $220CBA
        ORI.W  #$56D4,$20(A2,A7.W)              ; $220CC0
        ORI.W  #$58A7,$57(A4,A7.W)              ; $220CC6
        ORI.W  #$5903,-$3D(A4,A7.W)             ; $220CCC
        ORI.W  #$59C0,-$5C(A4,A7.W)             ; $220CD2
        ORI.L  #$59A5F2D3,D2                    ; $220CD8
        ORI.L  #$5A0FF33F,D2                    ; $220CDE
        ORI.L  #$5AC1F448,D2                    ; $220CE4
        ORI.L  #$5D71F03C,D2                    ; $220CEA
        ORI.L  #$5995F039,A2                    ; $220CF0
        ORI.L  #$598CF1C8,A2                    ; $220CF6
        ORI.W  #$57CC,-$1D(A7,A6.L)             ; $220CFC
        ORI.L  #$5880EFE0,A2                    ; $220D02
        ORI.L  #$5877F1C3,A2                    ; $220D08
        ORI.W  #$57C3,$76(A7,A7.W)              ; $220D0E
        ORI.L  #$5A46F055,A5                    ; $220D14
        ORI.L  #$59E3F076,A2                    ; $220D1A
        ORI.L  #$5A47F0A1,(A4)                  ; $220D20
        ORI.L  #$5AC1F1C1,(A4)                  ; $220D26
        ORI.L  #$5E47F0E8,(A4)                  ; $220D2C
        ORI.L  #$5B8BF2A0,(A4)                  ; $220D32
        ORI.L  #$59AFF2A5,D2                    ; $220D38
        ORI.L  #$59A5F2A0,(A7)                  ; $220D3E
        ORI.L  #$59AFF932,(A7)+                 ; $220D44
        ORI.L  #$56D4F92F,D7                    ; $220D4A
        ORI.L  #$56DFEF25,A7                    ; $220D50
        ORI.L  #$5EFBEE88,-(A4)                 ; $220D56
        ORI.L  #$5C26EE4B,-(A4)                 ; $220D5C
        DC.W    $00B9,$5AD3,$EE45,$00C1,$5ADC; $220D62 ORI.L  #$5AD3EE45,$00C15ADC
        MOVE.W  $67(A0,D0.W),(A3)+              ; $220D6C
        ADDQ.W  #6,(A0)+                        ; $220D70
        MOVE.W  $016D(A6),$5F66(PC)             ; $220D72
        MOVE.W  (A6),$007E5F77                  ; $220D78
        MOVE.W  -(A6),D4                        ; $220D7E
        ANDI.W  #$5FFE,A3                       ; $220D80
        MOVE.W  $6E(A6,D0.W),(A5)+              ; $220D84
        ADDQ.W  #5,$1C(A7,A7.W)                 ; $220D88
        ORI.L  #$5931F1FD,A2                    ; $220D8C
        ORI.W  #$583C,$02(A7,A7.W)              ; $220D92
        ORI.W  #$5845,$1F(A7,A7.W)              ; $220D98
        ORI.L  #$593A0019,A2                    ; $220D9E
        CMP.B  D1,D0                            ; $220DA4
        ORI.W  #$0080,(A0)                      ; $220DA6
        ORI.L  #$0617B301,(A0)                  ; $220DAA
        ORI.L  #$0617A201,-(A0)                 ; $220DB0
        DC.W    $00B0,$0216,$A300,$00E0; $220DB6 ORI.L  #$0216A300,-$20(A0,D0.W)
        DC.W    $00D0               ; $220DBE DC.W    $00D0
        DC.W    $0216,$B400         ; $220DC0 ANDI.B  #$B400,(A6)
        DC.W    $00C0               ; $220DC4 DC.W    $00C0
        ORI.L  #$0418B100,(A0)                  ; $220DC6
        ORI.W  #$0050,-(A0)                     ; $220DCC
        SUBI.B  #$1400,A0                       ; $220DD0
        ORI.W  #$0040,$08(A0,D0.W)              ; $220DD4
        MOVE.B  D0,-(A2)                        ; $220DDA
        BCHG    D0,-(A0)                        ; $220DDC
        BCHG    D0,$18(A0,D0.W)                 ; $220DDE
        CMP.B  D0,D0                            ; $220DE2
        DC.W    $00C0               ; $220DE4 DC.W    $00C0
        BCLR    D0,D0                           ; $220DE6
        SUBI.B  #$B300,(A6)                     ; $220DE8
        DC.W    $00D0               ; $220DEC DC.W    $00D0
        BCLR    D0,(A0)                         ; $220DEE
        SUBI.B  #$A400,(A6)                     ; $220DF0
        DC.W    $00E0               ; $220DF4 DC.W    $00E0
        BCLR    D0,$16(A0,D0.W)                 ; $220DF6
        OR.B   D0,D2                            ; $220DFA
        DC.W    $00F0               ; $220DFC DC.W    $00F0
        BCLR    D0,-(A0)                        ; $220DFE
        ADDI.B  #$8501,(A1)+                    ; $220E00
        DC.W    $00B0,$0217,$8301,$0250; $220E04 ORI.L  #$02178301,$50(A0,D0.W)
        DC.W    $0216,$8400         ; $220E0C ANDI.B  #$8400,(A6)
        ANDI.W  #$0270,-(A0)                    ; $220E10
        ADDI.B  #$8300,(A0)                     ; $220E14
        ANDI.L  #$02800004,(A0)                 ; $220E18
        MOVE.B  D0,-(A5)                        ; $220E1E
        DC.W    $0000,$0010         ; $220E20 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $220E24 ORI.B  #$0030,-(A0)
        ADDI.B  #$1B00,D4                       ; $220E28
        BTST    D0,D0                           ; $220E2C
        BTST    D0,(A0)                         ; $220E2E
        DC.W    $0000,$2000         ; $220E30 ORI.B  #$2000,D0
        BSET    D0,D0                           ; $220E34
        DC.W    $00C0               ; $220E36 DC.W    $00C0
        BSET    D0,(A0)                         ; $220E38
        BSET    D0,-(A0)                        ; $220E3A
        SUBI.B  #$2000,D0                       ; $220E3C
        BSET    D0,$00(A0,D0.W)                 ; $220E40
        DC.W    $0004,$F900         ; $220E44 ORI.B  #$F900,D4
        BTST    D0,-(A0)                        ; $220E48
        BTST    D0,$40(A0,D0.W)                 ; $220E4A
        BCHG    D0,(A0)                         ; $220E4E
        DC.W    $0018,$8500         ; $220E50 ORI.B  #$8500,(A0)+
        DC.W    $0210,$0220         ; $220E54 ANDI.B  #$0220,(A0)
        BCLR    D0,-$60(A0,D0.W)                ; $220E58
        DC.W    $0000,$2000         ; $220E5C ORI.B  #$2000,D0
        DC.W    $0230,$01D0,$01E0   ; $220E60 ANDI.B  #$01D0,-$20(A0,D0.W)
        ANDI.W  #$0044,D0                       ; $220E66
        BTST    D5,D0                           ; $220E6A
        ANDI.L  #$02B002C0,-(A0)                ; $220E6C
        DC.W    $02D0               ; $220E72 DC.W    $02D0
        CMPI.B  #$000C,D0                       ; $220E74
        DC.W    $000C,$F932         ; $220E78 ORI.B  #$F932,A4
        ORI.W  #$56D4,-$50(A2,A7.L)             ; $220E7C
        BCHG    D0,$57EB(A3)                    ; $220E82
        MOVE.W  D3,$0074(PC)                    ; $220E86
        SVS     D0                              ; $220E8A
        MOVE.W  $68(A1,D0.W),$5820(A6)          ; $220E8C
        DC.W    $FDD9               ; $220E92 MOVE.W  (A1)+,<EA:3E>
        ORI.W  #$5726,A7                        ; $220E94
        DC.W    $FFEB,$004F         ; $220E98 MOVE.W  $004F(A3),<EA:3F>
        SVC     D0                              ; $220E9C
        MOVE.W  $0168(A1),$59E3(A7)             ; $220E9E
        MOVE.W  $67(A0,D0.W),(A3)+              ; $220EA4
        ADDQ.W  #6,(A0)+                        ; $220EA8
        MOVE.W  $6E(A6,D0.W),(A5)+              ; $220EAA
        ADDQ.W  #5,$52(A7,A7.L)                 ; $220EAE
        BCHG    D0,$57C6(A0)                    ; $220EB2
        DC.W    $FC77,$026D         ; $220EB6 MOVEA.W $6D(A7,D0.W),A6
        ADDQ.B  #5,-(A5)                        ; $220EBA
        MOVEA.W (A4),A7                         ; $220EBC
        ANDI.W  #$5B2D,$0017(A5)                ; $220EBE
        OR.B   D1,D1                            ; $220EC4
        DC.W    $0000,$0010         ; $220EC6 ORI.B  #$0010,D0
        DC.W    $0020,$0616         ; $220ECA ORI.B  #$0616,-(A0)
        OR.B   D0,D1                            ; $220ECE
        ORI.L  #$00700617,D0                    ; $220ED0
        OR.B   D1,D1                            ; $220ED6
        ORI.L  #$02168400,(A0)                  ; $220ED8
        DC.W    $0030,$00A0,$0414   ; $220EDE ORI.B  #$00A0,$14(A0,D0.W)
        OR.B   D2,D0                            ; $220EE4
        ORI.W  #$00B0,-(A0)                     ; $220EE6
        ADDI.B  #$8600,(A4)                     ; $220EEA
        ORI.W  #$0050,D0                        ; $220EEE
        CMPI.B  #$0004,D0                       ; $220EF2
        DC.W    $0004,$D698         ; $220EF6 ORI.B  #$D698,D4
        BCLR    D0,(A5)                         ; $220EFA
        SUBQ.W  #4,$D6CA0195                    ; $220EFC
        SUBQ.W  #2,(A7)                         ; $220F02
        ADD.B  D4,A6                            ; $220F04
        DC.W    $00C2               ; $220F06 DC.W    $00C2
        DBCC    D1,$21E86E                      ; $220F08
        DC.W    $00C2               ; $220F0C DC.W    $00C2
        ADDQ.W  #4,-(A3)                        ; $220F0E
        DC.W    $0016,$8700         ; $220F10 ORI.B  #$8700,(A6)
        DC.W    $0000,$0010         ; $220F14 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $220F18 ORI.B  #$0030,-(A0)
        CMPI.B  #$004E,D0                       ; $220F1C
        DC.W    $003C,$DFDD,$00C0   ; $220F20 ORI.B  #$DFDD,#$00C0
        SUBQ.W  #3,(A2)+                        ; $220F26
        ADD.L  D7,$00C1(A2)                     ; $220F28
        SLS     -$4D(A3,A5.L)                   ; $220F2C
        DC.W    $00C1               ; $220F30 DC.W    $00C1
        SLS     -$1A(A2,A5.L)                   ; $220F32
        DC.W    $00C0               ; $220F36 DC.W    $00C0
        SUBQ.W  #3,(A5)                         ; $220F38
        ADD.B  D7,-$40(A2,D0.W)                 ; $220F3A
        SUBQ.L  #3,$DEF6.W                      ; $220F3E
        DC.W    $00C1               ; $220F42 DC.W    $00C1
        ADDQ.B  #2,D3                           ; $220F44
        ADD.W  D7,(A5)+                         ; $220F46
        DC.W    $00C1               ; $220F48 DC.W    $00C1
        SLS     -$206D(PC)                      ; $220F4A
        DC.W    $00C0               ; $220F4E DC.W    $00C0
        SUBQ.L  #3,D2                           ; $220F50
        ADD.L  D7,D3                            ; $220F52
        DC.W    $00C1               ; $220F54 DC.W    $00C1
        ADDQ.B  #1,-$74(A4,A5.L)                ; $220F56
        DC.W    $00C1               ; $220F5A DC.W    $00C1
        ADDQ.B  #1,$59(A3,A5.L)                 ; $220F5C
        DC.W    $00C1               ; $220F60 DC.W    $00C1
        ADDQ.W  #8,$62(A2,A5.L)                 ; $220F62
        DC.W    $00C1               ; $220F66 DC.W    $00C1
        ADDQ.W  #8,-$29(A0,A5.L)                ; $220F68
        DC.W    $00C1               ; $220F6C DC.W    $00C1
        SLS     -$2131(A7)                      ; $220F6E
        DC.W    $00C1               ; $220F72 DC.W    $00C1
        ADDQ.W  #1,A7                           ; $220F74
        ADD.B  D7,-$3F(A5,D0.W)                 ; $220F76
        ADDQ.W  #1,D0                           ; $220F7A
        ADD.L  $00C1(A0),D7                     ; $220F7C
        ADDQ.L  #8,(A0)+                        ; $220F80
        ADD.B  D7,A5                            ; $220F82
        DC.W    $00C1               ; $220F84 DC.W    $00C1
        ADDQ.L  #8,D3                           ; $220F86
        ADD.W  D4,-(A4)                         ; $220F88
        DC.W    $00C2               ; $220F8A DC.W    $00C2
        ADDQ.W  #4,-(A3)                        ; $220F8C
        ADD.B  D4,A6                            ; $220F8E
        DC.W    $00C2               ; $220F90 DC.W    $00C2
        DBCC    D1,$21EC9B                      ; $220F92
        DC.W    $00C2               ; $220F96 DC.W    $00C2
        ADDQ.B  #2,$40(A6,A5.L)                 ; $220F98
        DC.W    $00C2               ; $220F9C DC.W    $00C2
        ADDQ.B  #4,(A1)                         ; $220F9E
        ADDA.W  $00C2(A3),A4                    ; $220FA0
        SUBQ.B  #1,(A5)+                        ; $220FA4
        ADDA.W  $00C2(A2),A6                    ; $220FA6
        DC.W    $527F               ; $220FAA ADDQ.W  #1,<EA:3F>
        ADDA.W  A2,A6                           ; $220FAC
        DC.W    $00C2               ; $220FAE DC.W    $00C2
        ST      $72(A1,A5.L)                    ; $220FB0
        DC.W    $00C2               ; $220FB4 DC.W    $00C2
        LEA     A2,A7                           ; $220FB6
        ADD.L  (A2)+,D6                         ; $220FB8
        DC.W    $00C2               ; $220FBA DC.W    $00C2
        DC.W    $4FA6               ; $220FBC DC.W    $4FA6
        ADD.B  D7,-$38(A2,D0.W)                 ; $220FBE
        SUBQ.L  #3,-$09(A7,A5.L)                ; $220FC2
        DC.W    $00C8               ; $220FC6 DC.W    $00C8
        ADDQ.B  #2,D3                           ; $220FC8
        ADDA.W  A6,A7                           ; $220FCA
        DC.W    $00C8               ; $220FCC DC.W    $00C8
        ADDQ.W  #1,(A0)                         ; $220FCE
        ADD.L  $00C8(A2),D7                     ; $220FD0
        ADDQ.L  #8,(A1)+                        ; $220FD4
        ADDA.L  $00C8541C,A6                    ; $220FD6
        ADD.B  -$38(A0,D0.W),D7                 ; $220FDC
        DC.W    $57FF               ; $220FE0 SEQ     <EA:3F>
        ADDA.L  (A1),A6                         ; $220FE2
        DC.W    $00C8               ; $220FE4 DC.W    $00C8
        ADDQ.W  #1,-$2253(A4)                   ; $220FE6
        DC.W    $00C8               ; $220FEA DC.W    $00C8
        DBT     D2,$21ED60                      ; $220FEC
        DC.W    $00C8               ; $220FF0 DC.W    $00C8
        DC.W    $4F5F               ; $220FF2 DC.W    $4F5F
        ADDA.W  $00C8(A5),A7                    ; $220FF4
        SLS     #$DEF5                          ; $220FF8
        DC.W    $00DD               ; $220FFC DC.W    $00DD
        ADDQ.B  #2,D3                           ; $220FFE
        ADDA.W  $00E5(A5),A7                    ; $221000
        SLS     $29(PC,A5.L)                    ; $221004
        DC.W    $00C8               ; $221008 DC.W    $00C8
        SUBQ.L  #3,$31(A0,A5.L)                 ; $22100A
        DC.W    $00DD               ; $22100E DC.W    $00DD
        SUBQ.L  #3,$DF29.W                      ; $221010
        DC.W    $00E5               ; $221014 DC.W    $00E5
        SUBQ.L  #3,-$5F(A0,A5.L)                ; $221016
        DC.W    $00C9               ; $22101A DC.W    $00C9
        ADDQ.L  #8,(A1)                         ; $22101C
        ADD.L  $00DE(A1),D7                     ; $22101E
        ADDQ.L  #8,(A1)+                        ; $221022
        ADD.L  -(A1),D7                         ; $221024
        DC.W    $00E6               ; $221026 DC.W    $00E6
        ADDQ.L  #8,(A2)                         ; $221028
        ADDA.W  A2,A3                           ; $22102A
        BCLR    D0,(A5)                         ; $22102C
        SUBQ.W  #2,(A7)                         ; $22102E
        ADD.W  D3,A1                            ; $221030
        BCLR    D0,(A5)                         ; $221032
        SUBQ.L  #1,(A6)+                        ; $221034
        ADD.W  D3,-$6B(A2,D0.W)                 ; $221036
        ST      (A2)                            ; $22103A
        ADDA.W  A7,A7                           ; $22103C
        DC.W    $023C,$540E,$DEB0   ; $22103E ANDI.B  #$540E,#$DEB0
        DC.W    $00FC               ; $221044 DC.W    $00FC
        SUBQ.L  #1,#$DEEE00FC                   ; $221046
        ADDQ.W  #2,-(A0)                        ; $22104C
        ADD.W  -(A5),D7                         ; $22104E
        DC.W    $023C,$508F,$DE33   ; $221050 ANDI.B  #$508F,#$DE33
        DC.W    $00FC               ; $221056 DC.W    $00FC
        ADDQ.W  #8,D7                           ; $221058
        ADD.L  (A0)+,D7                         ; $22105A
        DC.W    $00FC               ; $22105C DC.W    $00FC
        ST      (A7)                            ; $22105E
        ADD.L  -(A0),D5                         ; $221060
        ANDI.L  #$54F7DA36,-(A4)                ; $221062
        BCHG    D0,(A1)+                        ; $221068
        ADDQ.L  #2,(A3)                         ; $22106A
        ADDA.W  $59(A1,D0.W),A5                 ; $22106C
        SUBQ.W  #2,A3                           ; $221070
        ADD.B  D5,(A4)                          ; $221072
        DC.W    $02B1,$55E6,$DB2D,$014F; $221074 ANDI.L  #$55E6DB2D,$4F(A1,D0.W)
        ADDQ.W  #3,(A5)+                        ; $22107C
        ADD.B  D5,(A4)+                         ; $22107E
        BTST    D1,$56F5DB0E                    ; $221080
        BCHG    D0,D1                           ; $221086
        DC.W    $577F               ; $221088 SUBQ.W  #3,<EA:3F>
        ADDA.W  $023C57AC,A7                    ; $22108A
        ADDA.W  (A2)+,A7                        ; $221090
        DC.W    $00FC               ; $221092 DC.W    $00FC
        SUBQ.W  #3,(A2)+                        ; $221094
        ADD.B  D7,(A1)+                         ; $221096
        DC.W    $00FC               ; $221098 DC.W    $00FC
        DC.W    $57FE               ; $22109A SEQ     <EA:3E>
        ADD.L  (A6)+,D7                         ; $22109C
        DC.W    $023C,$524F,$DE74   ; $22109E ANDI.B  #$524F,#$DE74
        DC.W    $00FC               ; $2210A4 DC.W    $00FC
        ADDQ.B  #1,D2                           ; $2210A6
        ADDA.W  A0,A7                           ; $2210A8
        DC.W    $00FC               ; $2210AA DC.W    $00FC
        ADDQ.L  #1,(A4)+                        ; $2210AC
        ADD.L  A3,D5                            ; $2210AE
        ANDI.L  #$50CEDABB,(A2)+                ; $2210B0
        BCHG    D0,D1                           ; $2210B6
        DC.W    $503D               ; $2210B8 ADDQ.B  #8,<EA:3D>
        ADD.W  $0133(A4),D5                     ; $2210BA
        SUBQ.W  #8,A5                           ; $2210BE
        DC.W    $DABF               ; $2210C0 ADD.L  <EA:3F>,D5
        BTST    D1,-(A1)                        ; $2210C2
        ADDQ.W  #1,-$76(A3,A5.L)                ; $2210C4
        BCHG    D0,(A2)                         ; $2210C8
        ADDQ.B  #1,D4                           ; $2210CA
        ADDA.W  $0152(A0),A5                    ; $2210CC
        DC.W    $52BD               ; $2210D0 ADDQ.L  #1,<EA:3D>
        ADD.B  $0334(PC),D5                     ; $2210D2
        SF      (A0)+                           ; $2210D6
        ADDA.L  (A3),A4                         ; $2210D8
        BCHG    D0,(A2)                         ; $2210DA
        SUBQ.L  #8,-$29(A5,A5.L)                ; $2210DC
        BTST    D1,$01(A4,D5.W)                 ; $2210E0
        ADDA.W  $52(PC,D0.W),A5                 ; $2210E4
        SUBQ.L  #1,A0                           ; $2210E8
        ADD.L  $52(A2,D0.W),D5                  ; $2210EA
        ADDQ.W  #2,-(A1)                        ; $2210EE
        ADDA.W  $0364(A6),A5                    ; $2210F0
        SUBQ.B  #1,-(A6)                        ; $2210F4
        DC.W    $0008,$1500         ; $2210F6 ORI.B  #$1500,A0
        ORI.W  #$0050,D0                        ; $2210FA
        ORI.W  #$0070,-(A0)                     ; $2210FE
        ADDI.B  #$1400,A0                       ; $221102
        DC.W    $00D0               ; $221106 DC.W    $00D0
        DC.W    $00E0               ; $221108 DC.W    $00E0
        SUBI.B  #$1300,A0                       ; $22110A
        DC.W    $00F0               ; $22110E DC.W    $00F0
        BTST    D0,D0                           ; $221110
        ADDI.B  #$B000,(A0)+                    ; $221112
        BSET    D0,D0                           ; $221116
        BSET    D0,(A0)                         ; $221118
        ADDI.B  #$B100,(A0)+                    ; $22111A
        ORI.W  #$01B0,(A0)                      ; $22111E
        SUBI.B  #$B000,(A0)+                    ; $221122
        ORI.W  #$01A0,D0                        ; $221126
        DC.W    $0216,$B300         ; $22112A ANDI.B  #$B300,(A6)
        BSET    D0,-$20(A0,D0.W)                ; $22112E
        SUBI.B  #$A300,(A6)                     ; $221132
        BCHG    D0,D0                           ; $221136
        BTST    D0,$16(A0,D0.W)                 ; $221138
        OR.B   D0,D2                            ; $22113C
        BTST    D0,(A0)                         ; $22113E
        BTST    D0,-(A0)                        ; $221140
        DC.W    $0218,$8500         ; $221142 ANDI.B  #$8500,(A0)+
        BCHG    D0,(A0)                         ; $221146
        BCHG    D0,-(A0)                        ; $221148
        DC.W    $0216,$A200         ; $22114A ANDI.B  #$A200,(A6)
        DC.W    $0200,$01E0         ; $22114E ANDI.B  #$01E0,D0
        SUBI.B  #$B400,(A6)                     ; $221152
        BSET    D0,D0                           ; $221156
        BCLR    D0,$16(A0,D0.W)                 ; $221158
        EOR.B  D1,D0                            ; $22115C
        DC.W    $0210,$01D0         ; $22115E ANDI.B  #$01D0,(A0)
        ADDI.B  #$A300,(A6)                     ; $221162
        BCHG    D0,-(A0)                        ; $221166
        BCHG    D0,$16(A0,D0.W)                 ; $221168
        MOVE.L  D0,D2                           ; $22116C
        BCLR    D0,(A0)                         ; $22116E
        DC.W    $0220,$0619         ; $221170 ANDI.B  #$0619,-(A0)
        OR.B   D2,D1                            ; $221174
        BCLR    D0,D0                           ; $221176
        ADDI.B  #$8400,(A6)                     ; $221178
        BCHG    D0,-(A0)                        ; $22117C
        BCHG    D0,(A0)                         ; $22117E
        DC.W    $0216,$8700         ; $221180 ANDI.B  #$8700,(A6)
        DC.W    $02D0               ; $221184 DC.W    $02D0
        DC.W    $02E0               ; $221186 DC.W    $02E0
        ADDI.B  #$8600,(A6)                     ; $221188
        BTST    D0,-(A0)                        ; $22118C
        DC.W    $02C0               ; $22118E DC.W    $02C0
        DC.W    $0004,$1B00         ; $221190 ORI.B  #$1B00,D4
        DC.W    $0000,$0010         ; $221194 ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $221198 ORI.B  #$0030,-(A0)
        ADDI.B  #$1B00,D4                       ; $22119C
        ORI.L  #$00900404,D0                    ; $2211A0
        MOVE.B  D0,-(A5)                        ; $2211A6
        ORI.L  #$00B00000,-(A0)                 ; $2211A8
        MOVE.L  D0,D0                           ; $2211AE
        ANDI.L  #$01D002A0,(A0)                 ; $2211B0
        DC.W    $02B0,$0400,$2000,$0240; $2211B6 ANDI.L  #$04002000,$40(A0,D0.W)
        ANDI.W  #$0400,(A0)                     ; $2211BE
        MOVE.L  D0,D0                           ; $2211C2
        ANDI.W  #$0280,$05(A0,D0.W)             ; $2211C4
        MOVE.W  D1,-(A4)                        ; $2211CA
        DC.W    $0020,$0090         ; $2211CC ORI.B  #$0090,-(A0)
        DC.W    $00C0               ; $2211D0 DC.W    $00C0
        DC.W    $0000,$2000         ; $2211D2 ORI.B  #$2000,D0
        DC.W    $0230,$01B0,$0240   ; $2211D6 ANDI.B  #$01B0,$40(A0,D0.W)
        ANDI.W  #$0000,(A0)                     ; $2211DC
        MOVE.L  D0,D0                           ; $2211E0
        ANDI.W  #$01A0,-(A0)                    ; $2211E2
        ANDI.W  #$0280,$03(A0,D0.W)             ; $2211E6
        OR.B   D0,D1                            ; $2211EC
        DC.W    $02F0               ; $2211EE DC.W    $02F0
        BTST    D1,D0                           ; $2211F0
        BTST    D1,(A0)                         ; $2211F2
        DC.W    $0003,$8101         ; $2211F4 ORI.B  #$8101,D3
        BTST    D1,-(A0)                        ; $2211F8
        BTST    D1,$40(A0,D0.W)                 ; $2211FA
        DC.W    $0001,$9901         ; $2211FE ORI.B  #$9901,D1
        BCHG    D1,(A0)                         ; $221202
        BCHG    D1,-(A0)                        ; $221204
        BCHG    D1,$01(A0,D0.W)                 ; $221206
        SUB.B  D1,D5                            ; $22120A
        BCLR    D1,D0                           ; $22120C
        BCHG    D1,-$70(A0,D0.W)                ; $22120E
        DC.W    $0001,$9901         ; $221212 ORI.B  #$9901,D1
        BCLR    D1,-(A0)                        ; $221216
        BCLR    D1,(A0)                         ; $221218
        BCLR    D1,$43(A0,D0.W)                 ; $22121A
        OR.B   D1,D1                            ; $22121E
        BSET    D1,D0                           ; $221220
        BSET    D1,(A0)                         ; $221222
        BSET    D1,-(A0)                        ; $221224
        ORI.W  #$8201,D3                        ; $221226
        BSET    D1,$00(A0,D0.W)                 ; $22122A
        SUBI.B  #$0041,(A0)                     ; $22122E
        SUB.B  D1,D5                            ; $221232
        SUBI.B  #$0430,-(A0)                    ; $221234
        SUBI.W  #$0041,D0                       ; $221238
        SUB.B  D1,D4                            ; $22123C
        SUBI.W  #$0460,(A0)                     ; $22123E
        SUBI.W  #$0041,$01(A0,A1.W)             ; $221242
        SUBI.L  #$04900460,D0                   ; $221248
        ORI.W  #$9801,D1                        ; $22124E
        SUBI.L  #$04B004C0,-(A0)                ; $221252
        ORI.W  #$9701,D1                        ; $221258
        DC.W    $04D0               ; $22125C DC.W    $04D0
        SUBI.W  #$04B0,$00(A0,D0.L)             ; $22125E
        ORI.L  #$006FE803,A7                    ; $221264
        DC.W    $00BA,$5719,$E625,$00BE; $22126A ORI.L  #$5719E625,$00BE(PC)
        SUBQ.B  #3,(A6)                         ; $221272
        ASR.B  D3,D5                            ; $221274
        DC.W    $00BE,$570C,$E803   ; $221276 ORI.L  #$570CE803,<EA:3E>
        DC.W    $00BA,$570F,$E614,$00BE; $22127C ORI.L  #$570FE614,$00BE(PC)
        DBCS    D7,$21F894                      ; $221284
        DC.W    $00BE,$556A,$E7EF   ; $221288 ORI.L  #$556AE7EF,<EA:3E>
        DC.W    $00BA,$55C6,$E7F5,$00BA; $22128E ORI.L  #$55C6E7F5,$00BA(PC)
        ADDQ.B  #3,-$1B08(A4)                   ; $221296
        DC.W    $00C0               ; $22129A DC.W    $00C0
        SUBQ.B  #3,A1                           ; $22129C
        ASL.B  #2,D1                            ; $22129E
        DC.W    $00C0               ; $2212A0 DC.W    $00C0
        DC.W    $56FF               ; $2212A2 SNE     <EA:3F>
        ROL.B  D2,D7                            ; $2212A4
        DC.W    $00C0               ; $2212A6 DC.W    $00C0
        SUBQ.L  #2,A5                           ; $2212A8
        ROL.L  #2,D2                            ; $2212AA
        DC.W    $00C0               ; $2212AC DC.W    $00C0
        SUBQ.B  #2,-$19F2(A2)                   ; $2212AE
        DC.W    $00C4               ; $2212B2 DC.W    $00C4
        SUBQ.W  #2,-$1811(A2)                   ; $2212B4
        DC.W    $00C0               ; $2212B8 DC.W    $00C0
        SCS     D6                              ; $2212BA
        ROL.W  D1,D7                            ; $2212BC
        DC.W    $00C0               ; $2212BE DC.W    $00C0
        SUBQ.L  #3,(A6)                         ; $2212C0
        ROL.W  D1,D1                            ; $2212C2
        DC.W    $00C0               ; $2212C4 DC.W    $00C0
        SUBQ.W  #3,(A5)                         ; $2212C6
        ASL.L  #1,D2                            ; $2212C8
        DC.W    $00C0               ; $2212CA DC.W    $00C0
        SUBQ.W  #3,A4                           ; $2212CC
        LSL.L  #1,D1                            ; $2212CE
        DC.W    $00C0               ; $2212D0 DC.W    $00C0
        SUBQ.L  #3,(A6)                         ; $2212D2
        ROXR.W  (A3)                            ; $2212D4
        DC.W    $00C0               ; $2212D6 DC.W    $00C0
        SCS     $E4DC00C0                       ; $2212D8
        SCS     $59(A1,A6.W)                    ; $2212DE
        DC.W    $00C0               ; $2212E2 DC.W    $00C0
        SUBQ.L  #2,$50(A0,A6.W)                 ; $2212E4
        DC.W    $00C0               ; $2212E8 DC.W    $00C0
        SUBQ.L  #2,-$52(A1,A6.W)                ; $2212EA
        DC.W    $00C0               ; $2212EE DC.W    $00C0
        DC.W    $54BF               ; $2212F0 ADDQ.L  #2,<EA:3F>
        ROXR.L  D2,D7                           ; $2212F2
        DC.W    $00C0               ; $2212F4 DC.W    $00C0
        ADDQ.L  #2,-$1E45(PC)                   ; $2212F6
        DC.W    $00C0               ; $2212FA DC.W    $00C0
        SUBQ.B  #4,(A5)                         ; $2212FC
        ROXR.L  #8,D6                           ; $2212FE
        DC.W    $00C0               ; $221300 DC.W    $00C0
        SNE     -$28(A6,A6.W)                   ; $221302
        DC.W    $00C0               ; $221306 DC.W    $00C0
        SNE     (A2)                            ; $221308
        LSR.B  #1,D2                            ; $22130A
        DC.W    $00C0               ; $22130C DC.W    $00C0
        SVC     D5                              ; $22130E
        ASL.B  D2,D0                            ; $221310
        DC.W    $00C0               ; $221312 DC.W    $00C0
        ADDQ.L  #2,D2                           ; $221314
        ADDA.L  A0,A7                           ; $221316
        DC.W    $00C0               ; $221318 DC.W    $00C0
        SUBQ.B  #5,A2                           ; $22131A
        ADD.L  D7,(A3)                          ; $22131C
        DC.W    $00C0               ; $22131E DC.W    $00C0
        SUBQ.L  #3,D2                           ; $221320
        ASL.L  #2,D1                            ; $221322
        DC.W    $00C0               ; $221324 DC.W    $00C0
        ADDQ.W  #2,A4                           ; $221326
        LSL.L  #8,D6                            ; $221328
        DC.W    $00C0               ; $22132A DC.W    $00C0
        SEQ     D1                              ; $22132C
        LSL.W  D0,D7                            ; $22132E
        DC.W    $00C0               ; $221330 DC.W    $00C0
        ADDQ.L  #3,D1                           ; $221332
        ROL.W  D0,D0                            ; $221334
        DC.W    $00C0               ; $221336 DC.W    $00C0
        ADDQ.W  #3,-$68(PC,A6.W)                ; $221338
        DC.W    $00C0               ; $22133C DC.W    $00C0
        SEQ     D0                              ; $22133E
        ASL.W  D0,D7                            ; $221340
        DC.W    $00C0               ; $221342 DC.W    $00C0
        DBCS    D1,$21F4A4                      ; $221344
        DC.W    $00C0               ; $221348 DC.W    $00C0
        DBCS    D2,$21F7DD                      ; $22134A
        DC.W    $00C1               ; $22134E DC.W    $00C1
        SUBQ.L  #1,D1                           ; $221350
        ROR.L  #2,D3                            ; $221352
        DC.W    $00C1               ; $221354 DC.W    $00C1
        SUBQ.L  #1,D0                           ; $221356
        ADD.L  D7,-$3F(A3,D0.W)                 ; $221358
        SLS     -$29(A2,A5.L)                   ; $22135C
        DC.W    $00C1               ; $221360 DC.W    $00C1
        SLS     -$20A3(A7)                      ; $221362
        DC.W    $00C1               ; $221366 DC.W    $00C1
        SLS     -$1AFF(PC)                      ; $221368
        DC.W    $00C1               ; $22136C DC.W    $00C1
        SUBQ.W  #1,$68(A7,A6.W)                 ; $22136E
        DC.W    $00C1               ; $221372 DC.W    $00C1
        SUBQ.W  #1,-$1B9D(A5)                   ; $221374
        DC.W    $00C1               ; $221378 DC.W    $00C1
        SUBQ.W  #8,#$E46C                       ; $22137A
        DC.W    $00C1               ; $22137E DC.W    $00C1
        SUBQ.W  #8,-$1BD4(PC)                   ; $221380
        DC.W    $00C1               ; $221384 DC.W    $00C1
        DC.W    $4F68               ; $221386 DC.W    $4F68
        ROXR.B  D2,D5                           ; $221388
        DC.W    $00C1               ; $22138A DC.W    $00C1
        DC.W    $4F66               ; $22138C DC.W    $4F66
        LSL.B  D0,D6                            ; $22138E
        DC.W    $00C1               ; $221390 DC.W    $00C1
        SLS     (A0)                            ; $221392
        LSL.B  #8,D1                            ; $221394
        DC.W    $00C1               ; $221396 DC.W    $00C1
        SF      $12(PC,A6.W)                    ; $221398
        DC.W    $00C1               ; $22139C DC.W    $00C1
        SF      $E13800C1                       ; $22139E
        DBLS    D7,$21F6C6                      ; $2213A4
        DC.W    $00C1               ; $2213A8 DC.W    $00C1
        SUBQ.L  #1,-(A2)                        ; $2213AA
        LSR.W  $00C1.W                          ; $2213AC
        SUBQ.L  #8,$01(A1,A6.W)                 ; $2213B0
        DC.W    $00C1               ; $2213B4 DC.W    $00C1
        SUBQ.L  #8,$2A(A0,A6.W)                 ; $2213B6
        DC.W    $00C1               ; $2213BA DC.W    $00C1
        SUBQ.L  #1,-(A2)                        ; $2213BC
        ADD.B  D7,-$3F(A5,D0.W)                 ; $2213BE
        ADDQ.W  #1,D0                           ; $2213C2
        ROXR.W  (A0)                            ; $2213C4
        DC.W    $00C1               ; $2213C6 DC.W    $00C1
        SUBQ.W  #8,-$20F3(A4)                   ; $2213C8
        DC.W    $00C1               ; $2213CC DC.W    $00C1
        ADDQ.L  #8,D3                           ; $2213CE
        ROXR.L  #2,D7                           ; $2213D0
        DC.W    $00C1               ; $2213D2 DC.W    $00C1
        DC.W    $4F51               ; $2213D4 DC.W    $4F51
        ROXL.B  D2,D6                           ; $2213D6
        DC.W    $00C1               ; $2213D8 DC.W    $00C1
        SUBQ.W  #8,(A5)+                        ; $2213DA
        ROXR.W  #$00C1                          ; $2213DC
        DC.W    $4F3B               ; $2213E0 DC.W    $4F3B
        ROL.L  #2,D2                            ; $2213E2
        DC.W    $00C8               ; $2213E4 DC.W    $00C8
        SUBQ.B  #2,-$19AD(A4)                   ; $2213E6
        DC.W    $00C8               ; $2213EA DC.W    $00C8
        ADDQ.W  #2,-$182C(A0)                   ; $2213EC
        DC.W    $00C0               ; $2213F0 DC.W    $00C0
        ADDQ.W  #2,D5                           ; $2213F2
        ASL.L  #2,D2                            ; $2213F4
        DC.W    $00C8               ; $2213F6 DC.W    $00C8
        ADDQ.W  #2,A6                           ; $2213F8
        LSL.W  D2,D1                            ; $2213FA
        DC.W    $00C8               ; $2213FC DC.W    $00C8
        SUBQ.W  #1,$35(A0,A6.W)                 ; $2213FE
        DC.W    $00C8               ; $221402 DC.W    $00C8
        SUBQ.W  #8,(A7)+                        ; $221404
        ROXR.W  -$38(PC,D0.W)                   ; $221406
        DC.W    $4F3A               ; $22140A DC.W    $4F3A
        ROL.B  #3,D0                            ; $22140C
        DC.W    $00C9               ; $22140E DC.W    $00C9
        SUBQ.W  #1,A3                           ; $221410
        ROR.B  D3,D0                            ; $221412
        DC.W    $00C8               ; $221414 DC.W    $00C8
        SUBQ.W  #1,(A5)+                        ; $221416
        ASR.B  #3,D4                            ; $221418
        DC.W    $00C8               ; $22141A DC.W    $00C8
        SUBQ.B  #8,-$1A36(PC)                   ; $22141C
        DC.W    $00C8               ; $221420 DC.W    $00C8
        DC.W    $4F10               ; $221422 DC.W    $4F10
        ROR.W  (A6)                             ; $221424
        DC.W    $00C9               ; $221426 DC.W    $00C9
        SUBQ.B  #8,-$16D7(A0)                   ; $221428
        DC.W    $00C9               ; $22142C DC.W    $00C9
        LEA     (A4),A7                         ; $22142E
        ROL.W  $00C1(A0)                        ; $221430
        DC.W    $55BE               ; $221434 SUBQ.L  #2,<EA:3E>
        ROL.W  -$2B(A0,D0.W)                    ; $221436
        SCS     D7                              ; $22143A
        ROL.W  $00DD(A0)                        ; $22143C
        DC.W    $55BE               ; $221440 SUBQ.L  #2,<EA:3E>
        LSR.B  #3,D3                            ; $221442
        DC.W    $00C4               ; $221444 DC.W    $00C4
        SUBQ.W  #2,-(A0)                        ; $221446
        LSR.B  #3,D6                            ; $221448
        DC.W    $00D9               ; $22144A DC.W    $00D9
        SUBQ.W  #2,-$19F5(A2)                   ; $22144C
        DC.W    $00E1               ; $221450 DC.W    $00E1
        SUBQ.W  #2,-(A0)                        ; $221452
        ASL.L  D2,D0                            ; $221454
        DC.W    $00DF               ; $221456 DC.W    $00DF
        SUBQ.B  #2,-(A5)                        ; $221458
        ASL.L  D2,D0                            ; $22145A
        DC.W    $00C7               ; $22145C DC.W    $00C7
        SUBQ.B  #2,-(A5)                        ; $22145E
        ROXL.W  D3                              ; $221460
        DC.W    $00C7               ; $221462 DC.W    $00C7
        SCC     -$1A3D(A1)                      ; $221464
        DC.W    $00DF               ; $221468 DC.W    $00DF
        SCC     -$1A1A(A1)                      ; $22146A
        DC.W    $00DF               ; $22146E DC.W    $00DF
        SUBQ.B  #2,-(A5)                        ; $221470
        ROXL.W  -(A6)                           ; $221472
        DC.W    $00C7               ; $221474 DC.W    $00C7
        SUBQ.B  #2,-(A5)                        ; $221476
        ASL.L  D2,D1                            ; $221478
        DC.W    $00C8               ; $22147A DC.W    $00C8
        SUBQ.B  #2,-(A3)                        ; $22147C
        ASL.L  D2,D1                            ; $22147E
        DC.W    $00E4               ; $221480 DC.W    $00E4
        SUBQ.B  #2,-(A3)                        ; $221482
        ROL.L  #2,D3                            ; $221484
        DC.W    $00DC               ; $221486 DC.W    $00DC
        SUBQ.B  #2,-$1A97(A4)                   ; $221488
        DC.W    $00DC               ; $22148C DC.W    $00DC
        SUBQ.W  #1,$6F(A0,A6.W)                 ; $22148E
        DC.W    $00C8               ; $221492 DC.W    $00C8
        SUBQ.W  #1,-(A7)                        ; $221494
        ROXL.W  D2,D0                           ; $221496
        DC.W    $00E4               ; $221498 DC.W    $00E4
        SUBQ.W  #1,-(A7)                        ; $22149A
        ROXR.W  -$24(PC,D0.W)                   ; $22149C
        DC.W    $4F39               ; $2214A0 DC.W    $4F39
        ASL.B  #2,D2                            ; $2214A2
        DC.W    $00E4               ; $2214A4 DC.W    $00E4
        DC.W    $4F30               ; $2214A6 DC.W    $4F30
        ASL.L  D2,D0                            ; $2214A8
        DC.W    $00F6               ; $2214AA DC.W    $00F6
        SUBQ.B  #2,-(A5)                        ; $2214AC
        ROXL.W  -(A6)                           ; $2214AE
        DC.W    $00F6               ; $2214B0 DC.W    $00F6
        SUBQ.B  #2,-(A5)                        ; $2214B2
        ROXL.W  D3                              ; $2214B4
        DC.W    $00F6               ; $2214B6 DC.W    $00F6
        SCC     -$1A60(A1)                      ; $2214B8
        DC.W    $010E               ; $2214BC BTST    D0,A6
        SUBQ.B  #2,-(A5)                        ; $2214BE
        ROXL.W  -(A6)                           ; $2214C0
        DC.W    $010E               ; $2214C2 BTST    D0,A6
        SUBQ.B  #2,-(A5)                        ; $2214C4
        ROXL.W  D3                              ; $2214C6
        DC.W    $010E               ; $2214C8 BTST    D0,A6
        SCC     -$1A60(A1)                      ; $2214CA
        BTST    D0,-(A6)                        ; $2214CE
        SUBQ.B  #2,-(A5)                        ; $2214D0
        ROXL.W  -(A6)                           ; $2214D2
        BTST    D0,-(A6)                        ; $2214D4
        SUBQ.B  #2,-(A5)                        ; $2214D6
        ROXL.W  D3                              ; $2214D8
        BTST    D0,-(A6)                        ; $2214DA
        SCC     -$1A4C(A1)                      ; $2214DC
        BCHG    D0,$1A(A3,D5.W)                 ; $2214E0
        ROXL.W  D3                              ; $2214E4
        BCHG    D0,-$01(A3,D5.W)                ; $2214E6
        ROXL.W  (A2)                            ; $2214EA
        BCHG    D0,$1A(A3,D5.W)                 ; $2214EC
        ROXL.W  D3                              ; $2214F0
        DC.W    $02CB               ; $2214F2 DC.W    $02CB
        DC.W    $54FF               ; $2214F4 SCC     <EA:3F>
        ROXL.L  D2,D4                           ; $2214F6
        DC.W    $02CB               ; $2214F8 DC.W    $02CB
        SUBQ.B  #2,(A2)+                        ; $2214FA
        ROXL.W  (A2)                            ; $2214FC
        DC.W    $02CB               ; $2214FE DC.W    $02CB
        SUBQ.B  #2,(A2)+                        ; $221500
        ROL.W  D2                               ; $221502
        DC.W    $00BA,$56B9,$E619,$00BE; $221504 ORI.L  #$56B9E619,$00BE(PC)
        ADDQ.B  #3,$18(A0,A6.W)                 ; $22150C
        DC.W    $00BE,$5625,$E7C1   ; $221510 ORI.L  #$5625E7C1,<EA:3E>
        DC.W    $00BA,$56AF,$E69C,$00BD; $221516 ORI.L  #$56AFE69C,$00BD(PC)
        SUBQ.B  #3,D0                           ; $22151E
        ASR.B  D3,D3                            ; $221520
        DC.W    $00BE,$56E3,$E622   ; $221522 ORI.L  #$56E3E622,<EA:3E>
        DC.W    $00BE,$56D7,$E69B   ; $221528 ORI.L  #$56D7E69B,<EA:3E>
        DC.W    $00BD,$56F5,$E515   ; $22152E ORI.L  #$56F5E515,<EA:3D>
        DC.W    $00C0               ; $221534 DC.W    $00C0
        SUBQ.L  #2,$1C(A7,A6.W)                 ; $221536
        DC.W    $00C0               ; $22153A DC.W    $00C0
        SUBQ.L  #2,$32(A0,A6.W)                 ; $22153C
        DC.W    $00BE,$5803,$E442   ; $221540 ORI.L  #$5803E442,<EA:3E>
        DC.W    $00C0               ; $221546 DC.W    $00C0
        ADDQ.L  #3,A3                           ; $221548
        LSR.W  #2,D1                            ; $22154A
        DC.W    $00C0               ; $22154C DC.W    $00C0
        ADDQ.L  #3,D4                           ; $22154E
        ROXR.B  D3,D2                           ; $221550
        DC.W    $00BE,$57F9,$E4BD   ; $221552 ORI.L  #$57F9E4BD,<EA:3E>
        DC.W    $00C0               ; $221558 DC.W    $00C0
        ADDQ.B  #3,A7                           ; $22155A
        ROXR.W  D4                              ; $22155C
        DC.W    $00C0               ; $22155E DC.W    $00C0
        ADDQ.B  #3,A1                           ; $221560
        LSR.B  #2,D1                            ; $221562
        DC.W    $00C0               ; $221564 DC.W    $00C0
        SUBQ.B  #2,(A1)+                        ; $221566
        ROXR.B  #2,D3                           ; $221568
        DC.W    $00C0               ; $22156A DC.W    $00C0
        SUBQ.B  #2,(A3)                         ; $22156C
        ROXL.W  #1,D5                           ; $22156E
        DC.W    $00C0               ; $221570 DC.W    $00C0
        SUBQ.W  #2,-$1CA2(PC)                   ; $221572
        DC.W    $00C0               ; $221576 DC.W    $00C0
        SUBQ.W  #2,-$31(A5,A6.W)                ; $221578
        DC.W    $00C0               ; $22157C DC.W    $00C0
        SUBQ.B  #2,$E3D7.W                      ; $22157E
        DC.W    $00C0               ; $221582 DC.W    $00C0
        SUBQ.B  #2,$34(A4,A6.W)                 ; $221584
        DC.W    $00C1               ; $221588 DC.W    $00C1
        SUBQ.L  #1,$E240.W                      ; $22158A
        DC.W    $00C1               ; $22158E DC.W    $00C1
        SUBQ.L  #1,$72(A7,A6.W)                 ; $221590
        DC.W    $00C1               ; $221594 DC.W    $00C1
        SUBQ.L  #1,$7D(A2,A6.W)                 ; $221596
        DC.W    $00C1               ; $22159A DC.W    $00C1
        SUBQ.L  #1,$67(A1,A6.W)                 ; $22159C
        DC.W    $00C1               ; $2215A0 DC.W    $00C1
        ADDQ.B  #1,(A2)                         ; $2215A2
        ROXR.W  D0,D4                           ; $2215A4
        DC.W    $00C1               ; $2215A6 DC.W    $00C1
        ADDQ.B  #1,(A1)                         ; $2215A8
        ROXL.B  D0,D7                           ; $2215AA
        DC.W    $00C1               ; $2215AC DC.W    $00C1
        SF      $29(A4,A6.W)                    ; $2215AE
        DC.W    $00C1               ; $2215B2 DC.W    $00C1
        ADDQ.W  #8,D5                           ; $2215B4
        ROXR.B  D0,D3                           ; $2215B6
        DC.W    $00C1               ; $2215B8 DC.W    $00C1
        ADDQ.W  #8,D3                           ; $2215BA
        ASL.W  #8,D1                            ; $2215BC
        DC.W    $00C1               ; $2215BE DC.W    $00C1
        SF      $08(A2,D0.W)                    ; $2215C0
        MOVE.B  D0,D2                           ; $2215C4
        ORI.W  #$0050,D0                        ; $2215C6
        ORI.W  #$0070,-(A0)                     ; $2215CA
        ADDI.B  #$B000,(A0)+                    ; $2215CE
        DC.W    $00C0               ; $2215D2 DC.W    $00C0
        DC.W    $00D0               ; $2215D4 DC.W    $00D0
        ADDI.B  #$B100,(A0)+                    ; $2215D6
        DC.W    $00B0,$03F0,$0608,$1300; $2215DA ORI.L  #$03F00608,$00(A0,D1.W)
        ORI.W  #$00A0,D0                        ; $2215E2
        DC.W    $0208,$1400         ; $2215E6 ANDI.B  #$1400,A0
        BSET    D0,D0                           ; $2215EA
        BSET    D0,$08(A0,D0.W)                 ; $2215EC
        DC.W    $0E00               ; $2215F0 DC.W    $0E00
        BSET    D0,(A0)                         ; $2215F2
        BSET    D0,-(A0)                        ; $2215F4
        DC.W    $0208,$0E00         ; $2215F6 ANDI.B  #$0E00,A0
        ANDI.L  #$02B00208,-(A0)                ; $2215FA
        MOVE.B  D0,-(A2)                        ; $221600
        DC.W    $02C0               ; $221602 DC.W    $02C0
        BSET    D0,$08(A0,D0.W)                 ; $221604
        MOVE.B  D0,D2                           ; $221608
        BCLR    D1,-(A0)                        ; $22160A
        BSET    D1,(A0)                         ; $22160C
        ADDI.B  #$0D00,A0                       ; $22160E
        ANDI.L  #$03900208,-(A0)                ; $221612
        CMPI.B  #$03B0,D0                       ; $221618
        BSET    D1,D0                           ; $22161C
        DC.W    $0208,$1300         ; $22161E ANDI.B  #$1300,A0
        BSET    D1,-(A0)                        ; $221622
        BSET    D1,(A0)                         ; $221624
        SUBI.B  #$B100,(A0)+                    ; $221626
        SUBI.W  #$0440,(A0)                     ; $22162A
        DC.W    $0218,$B000         ; $22162E ANDI.B  #$B000,(A0)+
        SUBI.B  #$02C0,$18(A0,D0.W)             ; $221632
        EOR.B  D0,D0                            ; $221638
        SUBI.B  #$01F0,-(A0)                    ; $22163A
        SUBI.B  #$B000,(A0)+                    ; $22163E
        BSET    D1,-$50(A0,D0.W)                ; $221642
        ADDI.B  #$B301,(A7)                     ; $221646
        SUBI.B  #$0217,D0                       ; $22164A
        CMP.B  D1,D1                            ; $22164E
        DC.W    $00C0               ; $221650 DC.W    $00C0
        ADDI.B  #$B300,(A6)                     ; $221652
        SUBI.B  #$00D0,(A0)                     ; $221656
        ADDI.B  #$A401,(A7)                     ; $22165A
        SUBI.W  #$0617,-(A0)                    ; $22165E
        MOVE.L  D1,-(A1)                        ; $221662
        SUBI.W  #$0616,$00(A0,A3.W)             ; $221664
        SUBI.B  #$0430,-(A0)                    ; $22166A
        DC.W    $0216,$B300         ; $22166E ANDI.B  #$B300,(A6)
        SUBI.W  #$0480,D0                       ; $221672
        SUBI.B  #$B400,(A6)                     ; $221676
        SUBI.W  #$0490,(A0)                     ; $22167A
        DC.W    $0217,$A301         ; $22167E ANDI.B  #$A301,(A7)
        SUBI.L  #$0216A400,-(A0)                ; $221682
        SUBI.W  #$0470,-(A0)                    ; $221688
        ADDI.B  #$8401,(A7)                     ; $22168C
        DC.W    $04B0,$0010,$0300,$0520; $221690 SUBI.L  #$00100300,$20(A0,D0.W)
        BTST    D2,$40(A0,D0.W)                 ; $221698
        BCHG    D2,(A0)                         ; $22169C
        SUBI.B  #$0300,(A0)                     ; $22169E
        BCHG    D2,$60(A0,D0.W)                 ; $2216A2
        SUBI.B  #$0300,(A0)                     ; $2216A6
        BTST    D2,$20(A0,D0.W)                 ; $2216AA
        DC.W    $0210,$F900         ; $2216AE ANDI.B  #$F900,(A0)
        ADDI.B  #$0610,D0                       ; $2216B2
        ADDI.B  #$F900,(A0)                     ; $2216B6
        BCHG    D2,(A0)                         ; $2216BA
        ADDI.B  #$0410,-(A0)                    ; $2216BC
        MOVE.W  D0,-(A4)                        ; $2216C0
        BCHG    D2,-(A0)                        ; $2216C2
        ADDI.B  #$0210,(A0)                     ; $2216C4
        BTST    D1,D0                           ; $2216C8
        ADDI.W  #$0650,D0                       ; $2216CA
        ADDI.B  #$0300,(A0)                     ; $2216CE
        ADDI.B  #$0630,D0                       ; $2216D2
        SUBI.B  #$0300,(A0)                     ; $2216D6
        ADDI.B  #$0650,-(A0)                    ; $2216DA
        DC.W    $0210,$F900         ; $2216DE ANDI.B  #$F900,(A0)
        ADDI.L  #$06600210,D0                   ; $2216E2
        MOVE.W  D0,-(A4)                        ; $2216E8
        ADDI.W  #$0640,$10(A0,D0.W)             ; $2216EA
        MOVE.W  D0,-(A4)                        ; $2216F0
        ADDI.L  #$06500610,D0                   ; $2216F2
        DC.W    $0A00,$06B0         ; $2216F8 EORI.B  #$06B0,D0
        ADDI.L  #$02100F00,-(A0)                ; $2216FC
        ADDI.L  #$06600410,(A0)                 ; $221702
        MOVE.B  D0,-(A1)                        ; $221708
        DC.W    $06B0,$0670,$0610,$0F00; $22170A ADDI.L  #$06700610,$00(A0,D0.L)
        DC.W    $06D0               ; $221712 DC.W    $06D0
        DC.W    $06E0               ; $221714 DC.W    $06E0
        ADDI.B  #$0A00,(A0)                     ; $221716
        ADDI.L  #$06C00410,-(A0)                ; $22171A
        BTST    #16,D0                          ; $221720
        DC.W    $06E0               ; $221724 DC.W    $06E0
        DC.W    $0004,$1B00         ; $221726 ORI.B  #$1B00,D4
        DC.W    $0000,$0010         ; $22172A ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $22172E ORI.B  #$0030,-(A0)
        ADDI.B  #$1B00,D4                       ; $221732
        ORI.L  #$00900404,D0                    ; $221736
        MOVE.B  D0,-(A5)                        ; $22173C
        BTST    D0,-(A0)                        ; $22173E
        BTST    D0,$04(A0,D0.W)                 ; $221740
        MOVE.B  D0,-(A5)                        ; $221744
        BCHG    D0,-(A0)                        ; $221746
        BCHG    D0,$04(A0,D0.W)                 ; $221748
        MOVE.B  D0,-(A5)                        ; $22174C
        ANDI.W  #$0270,-(A0)                    ; $22174E
        SUBI.B  #$1B00,D4                       ; $221752
        DC.W    $02D0               ; $221756 DC.W    $02D0
        DC.W    $02E0               ; $221758 DC.W    $02E0
        SUBI.B  #$1B00,D4                       ; $22175A
        DC.W    $02F0               ; $22175E DC.W    $02F0
        BTST    D1,D0                           ; $221760
        DC.W    $0000,$2000         ; $221762 ORI.B  #$2000,D0
        DC.W    $04C0               ; $221766 DC.W    $04C0
        DC.W    $00D0               ; $221768 DC.W    $00D0
        DC.W    $04D0               ; $22176A DC.W    $04D0
        DC.W    $04E0               ; $22176C DC.W    $04E0
        SUBI.B  #$2000,D0                       ; $22176E
        BTST    D2,D0                           ; $221772
        BTST    D2,(A0)                         ; $221774
        SUBI.B  #$2000,D0                       ; $221776
        BCLR    D2,-(A0)                        ; $22177A
        BCLR    D2,(A0)                         ; $22177C
        SUBI.B  #$2000,D0                       ; $22177E
        BCLR    D2,-$30(A0,D0.W)                ; $221782
        SUBI.B  #$2000,D0                       ; $221786
        SUBI.B  #$05C0,$04(A0,D0.W)             ; $22178A
        MOVE.W  D0,-(A4)                        ; $221790
        DC.W    $00E0               ; $221792 DC.W    $00E0
        DC.W    $00F0               ; $221794 DC.W    $00F0
        BTST    D0,D0                           ; $221796
        BTST    D0,(A0)                         ; $221798
        ADDI.B  #$F900,D4                       ; $22179A
        BCHG    D0,(A0)                         ; $22179E
        BCHG    D0,D0                           ; $2217A0
        DC.W    $0004,$F900         ; $2217A2 ORI.B  #$F900,D4
        BCLR    D0,D0                           ; $2217A6
        BCLR    D0,(A0)                         ; $2217A8
        BCLR    D0,-(A0)                        ; $2217AA
        BCLR    D0,$04(A0,D0.W)                 ; $2217AC
        MOVE.W  D0,-(A4)                        ; $2217B0
        ANDI.L  #$02900004,D0                   ; $2217B2
        MOVE.W  D0,-(A4)                        ; $2217B8
        DC.W    $0200,$0210         ; $2217BA ANDI.B  #$0210,D0
        DC.W    $0220,$0230         ; $2217BE ANDI.B  #$0230,-(A0)
        ADDI.B  #$F900,D4                       ; $2217C2
        ANDI.W  #$0240,(A0)                     ; $2217C6
        DC.W    $0004,$F900         ; $2217CA ORI.B  #$F900,D4
        BTST    D1,(A0)                         ; $2217CE
        BTST    D1,-(A0)                        ; $2217D0
        BTST    D1,$40(A0,D0.W)                 ; $2217D2
        DC.W    $0004,$F900         ; $2217D6 ORI.B  #$F900,D4
        BCHG    D1,(A0)                         ; $2217DA
        BCHG    D1,-(A0)                        ; $2217DC
        BCHG    D1,-$80(A0,D0.W)                ; $2217DE
        DC.W    $0000,$2000         ; $2217E2 ORI.B  #$2000,D0
        DC.W    $04F0               ; $2217E6 DC.W    $04F0
        DC.W    $00C0               ; $2217E8 DC.W    $00C0
        BTST    D2,D0                           ; $2217EA
        BTST    D2,(A0)                         ; $2217EC
        DC.W    $0000,$2000         ; $2217EE ORI.B  #$2000,D0
        BSET    D1,-$80(A0,D0.W)                ; $2217F2
        BCLR    D2,(A0)                         ; $2217F6
        BCLR    D2,-(A0)                        ; $2217F8
        DC.W    $0000,$2000         ; $2217FA ORI.B  #$2000,D0
        BCLR    D2,-$20(A0,D0.W)                ; $2217FE
        BSET    D2,-$30(A0,D0.W)                ; $221802
        ORI.W  #$0900,D4                        ; $221806
        BTST    D3,$40(A0,D0.W)                 ; $22180A
        BCHG    D3,(A0)                         ; $22180E
        BCHG    D3,-(A0)                        ; $221810
        ADDI.W  #$0800,D4                       ; $221812
        BSET    D3,(A0)                         ; $221816
        BSET    D3,-(A0)                        ; $221818
        SUBI.W  #$0900,D4                       ; $22181A
        BTST    #0,$44(A0,D0.W)                 ; $22181E
        BTST    D4,D0                           ; $221824
        BCHG    #0,$44(A0,D0.W)                 ; $221826
        BTST    #16,D0                          ; $22182C
        BSET    #4,-(A0)                        ; $221830
        BTST    D3,D0                           ; $221834
        BSET    #16,D0                          ; $221836
        ORI.W  #$0800,D4                        ; $22183A
        DC.W    $06F0               ; $22183E DC.W    $06F0
        BTST    D3,D0                           ; $221840
        BTST    D3,(A0)                         ; $221842
        BTST    D3,-(A0)                        ; $221844
        ADDI.W  #$0700,D4                       ; $221846
        BCHG    D3,-$80(A0,D0.W)                ; $22184A
        SUBI.W  #$0800,D4                       ; $22184E
        BSET    D3,$00(A0,D0.L)                 ; $221852
        SUBI.W  #$0800,D4                       ; $221856
        BCHG    #0,(A0)                         ; $22185A
        SUBI.W  #$0700,D4                       ; $22185E
        BCLR    #0,(A0)                         ; $221862
        ORI.W  #$0900,D4                        ; $221866
        BCLR    D3,(A0)                         ; $22186A
        BCLR    D3,-(A0)                        ; $22186C
        BCLR    D3,-$40(A0,D0.W)                ; $22186E
        ADDI.W  #$0A00,D4                       ; $221872
        BTST    #0,(A0)                         ; $221876
        CMPI.B  #$0053,D0                       ; $22187A
        ORI.W  #$F22D,A3                        ; $22187E
        ORI.W  #$50CB,-(A4)                     ; $221882
        ROR.W  $007D(A7)                        ; $221886
        DBRA    D5,loc_22071A                   ; $22188A
        ORI.L  #$4FB6F089,A6                    ; $22188E
        ORI.W  #$5534,$0D(A7,A6.L)              ; $221894
        ORI.L  #$55EAEF0A,A2                    ; $22189A
        ORI.L  #$55E1F084,A2                    ; $2218A0
        ORI.W  #$552B,-$27(A7,A6.L)             ; $2218A6
        ORI.L  #$5547EEB8,A2                    ; $2218AC
        ORI.L  #$54E4F01E,A2                    ; $2218B2
        ORI.W  #$5447,$47(A7,A7.W)              ; $2218B8
        ORI.W  #$54AA,-$47(A7,A6.L)             ; $2218BE
        ORI.L  #$54E3F01E,(A1)                  ; $2218C4
        DC.W    $007E,$5447         ; $2218CA ORI.W  #$5447,<EA:3E>
        ROXL.W  #$0091                          ; $2218CE
        SUBQ.W  #1,-(A5)                        ; $2218D2
        ASL.W  #7,D7                            ; $2218D4
        DC.W    $007E,$52ED         ; $2218D6 ORI.W  #$52ED,<EA:3E>
        ASL.L  D6,D5                            ; $2218DA
        ORI.L  #$5273ED5D,(A2)                  ; $2218DC
        ORI.L  #$5679ED5B,(A6)+                 ; $2218E2
        ORI.L  #$566FED35,(A6)+                 ; $2218E8
        ORI.L  #$55BCED1F,(A6)+                 ; $2218EE
        ORI.L  #$5558F055,(A6)+                 ; $2218F4
        ORI.L  #$59E3EE34,A2                    ; $2218FA
        ORI.L  #$5A6DED1F,(A6)+                 ; $221900
        ORI.L  #$5558ECBA,-(A4)                 ; $221906
        ORI.L  #$53C0EC8B,-(A4)                 ; $22190C
        ORI.L  #$52D4EEAF,-(A3)                 ; $221912
        ORI.L  #$54DFEEB9,(A1)                  ; $221918
        ORI.L  #$54E3EEAF,-(A6)                 ; $22191E
        DC.W    $00AE,$54DF,$EC26,$00B3; $221924 ORI.L  #$54DFEC26,$00B3(A6)
        SUBQ.B  #8,A5                           ; $22192C
        MOVE.W  (A6)+,D0                        ; $22192E
        ORI.L  #$5447F012,(A2)                  ; $221930
        ORI.L  #$5445EB9E,(A2)+                 ; $221936
        DC.W    $00AB,$56D9,$EB9D,$00AB; $22193C ORI.L  #$56D9EB9D,$00AB(A3)
        SNE     (A0)                            ; $221944
        ROXL.L  #6,D7                           ; $221946
        ORI.L  #$578CEBC0,(A6)+                 ; $221948
        DC.W    $00AB,$57E0,$EBBF,$00AB; $22194E ORI.L  #$57E0EBBF,$00AB(A3)
        SEQ     (A6)                            ; $221956
        ROXL.L  #6,D5                           ; $221958
        ORI.L  #$5783EB84,(A6)+                 ; $22195A
        DC.W    $00AB,$560C,$EB78,$00AB; $221960 ORI.L  #$560CEB78,$00AB(A3)
        SUBQ.L  #2,-(A7)                        ; $221968
        ROL.W  D5,D1                            ; $22196A
        DC.W    $00B2,$55A8,$EB54,$00B2; $22196C ORI.L  #$55A8EB54,-$4E(A2,D0.W)
        ADDQ.B  #2,D7                           ; $221974
        LSL.B  D5,D5                            ; $221976
        DC.W    $00B3,$5333,$E9F9,$00B4; $221978 ORI.L  #$5333E9F9,-$4C(A3,D0.W)
        SUBQ.B  #3,A0                           ; $221980
        ASL.W  $00B456FE                        ; $221982
        ASL.W  -$4C(A1,D0.W)                    ; $221988
        ADDQ.B  #3,$E9EB.W                      ; $22198C
        DC.W    $00B4,$55D3,$ED14,$00A4; $221990 ORI.L  #$55D3ED14,-$5C(A4,D0.W)
        SUBQ.W  #2,(A2)                         ; $221998
        ROL.B  #6,D6                            ; $22199A
        DC.W    $00B9,$5557,$ED14,$00C1,$5552; $22199C ORI.L  #$5557ED14,$00C15552
        ASL.W  $00BB(A3)                        ; $2219A6
        SCS     (A3)                            ; $2219AA
        ROXL.L  D4,D4                           ; $2219AC
        DC.W    $00BB,$5438,$E981,$00BB; $2219AE ORI.L  #$5438E981,-$45(PC,D0.W)
        SUBQ.W  #1,-(A5)                        ; $2219B6
        ASR.B  #4,D3                            ; $2219B8
        DC.W    $00BA,$5719,$E803,$00BA; $2219BA ORI.L  #$5719E803,$00BA(PC)
        SUBQ.B  #3,A7                           ; $2219C2
        ASR.B  #5,D2                            ; $2219C4
        DC.W    $00B4,$57F6,$E810,$00BA; $2219C6 ORI.L  #$57F6E810,-$46(A4,D0.W)
        SEQ     $10(A7,A6.L)                    ; $2219CE
        DC.W    $00BA,$57EE,$EA02,$00B4; $2219D2 ORI.L  #$57EEEA02,$00B4(PC)
        SEQ     -$180B(A4)                      ; $2219DA
        DC.W    $00BA,$562C,$E7EF,$00BA; $2219DE ORI.L  #$562CE7EF,$00BA(PC)
        SCS     D6                              ; $2219E6
        ROL.W  $00C0(A7)                        ; $2219E8
        SCS     D6                              ; $2219EC
        LSL.B  D4,D1                            ; $2219EE
        DC.W    $00C9               ; $2219F0 DC.W    $00C9
        LEA     (A4),A7                         ; $2219F2
        ROL.W  (A4)                             ; $2219F4
        DC.W    $00C0               ; $2219F6 DC.W    $00C0
        ADDQ.W  #2,D5                           ; $2219F8
        LSL.W  D5,D7                            ; $2219FA
        DC.W    $00B2,$55A1,$EB79,$00C7; $2219FC ORI.L  #$55A1EB79,-$39(A2,D0.W)
        SUBQ.L  #2,-(A7)                        ; $221A04
        LSL.W  D5,D7                            ; $221A06
        DC.W    $00CF               ; $221A08 DC.W    $00CF
        SUBQ.L  #2,-(A1)                        ; $221A0A
        ROL.B  #3,D0                            ; $221A0C
        DC.W    $00C9               ; $221A0E DC.W    $00C9
        SUBQ.W  #1,A3                           ; $221A10
        ASL.W  -(A4)                            ; $221A12
        DC.W    $00BB,$55CC,$E9EC,$00CF; $221A14 ORI.L  #$55CCE9EC,-$31(PC,D0.W)
        SCS     (A3)                            ; $221A1C
        ASL.W  -(A3)                            ; $221A1E
        DC.W    $00D7               ; $221A20 DC.W    $00D7
        DBCS    D4,loc_220214                   ; $221A22
        DC.W    $00D5               ; $221A26 DC.W    $00D5
        SCS     D7                              ; $221A28
        ROL.W  $00DD(A0)                        ; $221A2A
        DC.W    $55BE               ; $221A2E SUBQ.L  #2,<EA:3E>
        MOVE.W  (A1),(A0)+                      ; $221A30
        ORI.W  #$5271,$48(A0,A6.L)              ; $221A32
        DC.W    $03CD               ; $221A38 BSET    D1,A5
        SHI     -$1111(A4)                      ; $221A3A
        DC.W    $03CD               ; $221A3E BSET    D1,A5
        DBRA    D6,loc_220974                   ; $221A40
        ORI.L  #$565CF09D,A2                    ; $221A44
        ORI.W  #$555E,-$5F(A7,A7.W)             ; $221A4A
        ORI.W  #$5568,$35(A7,A6.L)              ; $221A50
        ORI.L  #$5666ED7D,A2                    ; $221A56
        ORI.L  #$570FED7F,(A6)+                 ; $221A5C
        ORI.L  #$5718EBE5,(A6)+                 ; $221A62
        DC.W    $00AA,$5736,$EBE6,$00AA; $221A68 ORI.L  #$5736EBE6,$00AA(A2)
        DC.W    $573F               ; $221A70 SUBQ.B  #3,<EA:3F>
        DC.W    $0015,$1C01         ; $221A72 ORI.B  #$1C01,(A5)
        SUBI.L  #$00E00490,D0                   ; $221A76
        ADDI.B  #$1600,(A0)                     ; $221A7C
        DC.W    $0010,$04A0         ; $221A80 ORI.B  #$04A0,(A0)
        ADDI.B  #$A300,(A6)                     ; $221A84
        DC.W    $00D0               ; $221A88 DC.W    $00D0
        DC.W    $00F0               ; $221A8A DC.W    $00F0
        ADDI.B  #$B400,(A6)                     ; $221A8C
        DC.W    $00C0               ; $221A90 DC.W    $00C0
        DC.W    $00B0,$0418,$B100,$0090; $221A92 ORI.L  #$0418B100,-$70(A0,D0.W)
        ORI.L  #$04081500,D0                    ; $221A9A
        ORI.L  #$00700208,-(A0)                 ; $221AA0
        MOVE.B  D0,D2                           ; $221AA6
        BTST    D0,-(A0)                        ; $221AA8
        BTST    D0,$18(A0,D0.W)                 ; $221AAA
        CMP.B  D0,D0                            ; $221AAE
        BCHG    D0,-(A0)                        ; $221AB0
        DC.W    $00B0,$0416,$B300,$0170; $221AB2 ORI.L  #$0416B300,$70(A0,D0.W)
        DC.W    $00D0               ; $221ABA DC.W    $00D0
        SUBI.B  #$A400,(A6)                     ; $221ABC
        BCLR    D0,D0                           ; $221AC0
        DC.W    $00F0               ; $221AC2 DC.W    $00F0
        ADDI.B  #$A300,(A6)                     ; $221AC4
        ANDI.L  #$02900616,D0                   ; $221AC8
        CMP.B  D0,D1                            ; $221ACE
        BCHG    D0,-(A0)                        ; $221AD0
        ANDI.W  #$0418,$00(A0,A3.W)             ; $221AD2
        BTST    D0,$60(A0,D0.W)                 ; $221AD8
        SUBI.B  #$1300,A0                       ; $221ADC
        BTST    D0,-(A0)                        ; $221AE0
        ANDI.W  #$0208,(A0)                     ; $221AE2
        MOVE.B  D0,D2                           ; $221AE6
        DC.W    $02C0               ; $221AE8 DC.W    $02C0
        DC.W    $02D0               ; $221AEA DC.W    $02D0
        DC.W    $0218,$B000         ; $221AEC ANDI.B  #$B000,(A0)+
        BTST    D1,(A0)                         ; $221AF0
        ANDI.W  #$0618,$00(A0,A3.W)             ; $221AF2
        BCLR    D1,-$40(A0,D0.W)                ; $221AF8
        DC.W    $0216,$B400         ; $221AFC ANDI.B  #$B400,(A6)
        BSET    D1,-(A0)                        ; $221B00
        BTST    D1,-(A0)                        ; $221B02
        DC.W    $0216,$B300         ; $221B04 ANDI.B  #$B300,(A6)
        ANDI.L  #$02700616,D0                   ; $221B08
        MOVE.L  D0,D1                           ; $221B0E
        BTST    D1,-$70(A0,D0.W)                ; $221B10
        ADDI.B  #$A300,(A6)                     ; $221B14
        BSET    D1,-(A0)                        ; $221B18
        SUBI.B  #$0219,-(A0)                    ; $221B1A
        OR.B   D2,D1                            ; $221B1E
        BSET    D1,(A0)                         ; $221B20
        DC.W    $0216,$8400         ; $221B22 ANDI.B  #$8400,(A6)
        BSET    D0,D0                           ; $221B26
        ANDI.L  #$04198501,(A0)                 ; $221B28
        BCLR    D0,D0                           ; $221B2E
        ADDI.B  #$8400,(A6)                     ; $221B30
        DC.W    $0020,$00F0         ; $221B34 ORI.B  #$00F0,-(A0)
        SUBI.B  #$8501,(A1)+                    ; $221B38
        DC.W    $0010,$0617         ; $221B3C ORI.B  #$0617,(A0)
        OR.B   D1,D2                            ; $221B40
        DC.W    $0000,$0004         ; $221B42 ORI.B  #$0004,D0
        MOVE.B  D0,-(A5)                        ; $221B46
        DC.W    $0030,$0040,$0050   ; $221B48 ORI.B  #$0040,$50(A0,D0.W)
        ORI.W  #$0604,-(A0)                     ; $221B4E
        MOVE.B  D0,-(A5)                        ; $221B52
        BTST    D0,D0                           ; $221B54
        BTST    D0,(A0)                         ; $221B56
        SUBI.B  #$1B00,D4                       ; $221B58
        BSET    D0,$00(A0,D0.W)                 ; $221B5C
        SUBI.B  #$1B00,D4                       ; $221B60
        ANDI.L  #$02B00404,-(A0)                ; $221B64
        MOVE.B  D0,-(A5)                        ; $221B6A
        BCHG    D1,D0                           ; $221B6C
        BCHG    D1,(A0)                         ; $221B6E
        DC.W    $0000,$2000         ; $221B70 ORI.B  #$2000,D0
        BCLR    D0,(A0)                         ; $221B74
        DC.W    $00B0,$01A0,$01B0,$0400; $221B76 ORI.L  #$01A001B0,$00(A0,D0.W)
        MOVE.L  D0,D0                           ; $221B7E
        DC.W    $02F0               ; $221B80 DC.W    $02F0
        BTST    D1,D0                           ; $221B82
        SUBI.B  #$2000,D0                       ; $221B84
        SUBI.B  #$0410,D0                       ; $221B88
        SUBI.B  #$2000,D0                       ; $221B8C
        SUBI.W  #$0450,D0                       ; $221B90
        SUBI.B  #$2000,D0                       ; $221B94
        SUBI.W  #$0470,-(A0)                    ; $221B98
        DC.W    $0008,$0E00         ; $221B9C ORI.B  #$0E00,A0
        ORI.W  #$0140,$50(A0,D0.W)              ; $221BA0
        BTST    D0,-(A0)                        ; $221BA6
        DC.W    $0000,$2000         ; $221BA8 ORI.B  #$2000,D0
        BSET    D0,(A0)                         ; $221BAC
        BCLR    D0,-(A0)                        ; $221BAE
        BCLR    D0,-$20(A0,D0.W)                ; $221BB0
        DC.W    $0004,$F900         ; $221BB4 ORI.B  #$F900,D4
        DC.W    $0210,$0220         ; $221BB8 ANDI.B  #$0220,(A0)
        DC.W    $0230,$0240,$0000   ; $221BBC ANDI.B  #$0240,$00(A0,D0.W)
        MOVE.L  D0,D0                           ; $221BC2
        DC.W    $02E0               ; $221BC4 DC.W    $02E0
        BCHG    D0,-(A0)                        ; $221BC6
        DC.W    $02F0               ; $221BC8 DC.W    $02F0
        BTST    D1,D0                           ; $221BCA
        DC.W    $0004,$F900         ; $221BCC ORI.B  #$F900,D4
        BCHG    D1,-(A0)                        ; $221BD0
        BCHG    D1,-$80(A0,D0.W)                ; $221BD2
        BCLR    D1,(A0)                         ; $221BD6
        DC.W    $0008,$1500         ; $221BD8 ORI.B  #$1500,A0
        BCLR    D1,-(A0)                        ; $221BDC
        BCLR    D1,-$30(A0,D0.W)                ; $221BDE
        DC.W    $02C0               ; $221BE2 DC.W    $02C0
        DC.W    $0000,$2000         ; $221BE4 ORI.B  #$2000,D0
        BSET    D1,$70(A0,D0.W)                 ; $221BE8
        SUBI.B  #$0410,D0                       ; $221BEC
        DC.W    $0000,$2000         ; $221BF0 ORI.B  #$2000,D0
        SUBI.B  #$0310,$40(A0,D0.W)             ; $221BF4
        SUBI.W  #$0044,(A0)                     ; $221BFA
        BTST    D4,D0                           ; $221BFE
        DC.W    $04B0,$04C0,$04D0,$04E0; $221C00 SUBI.L  #$04C004D0,-$20(A0,D0.W)
        ANDI.W  #$0800,D4                       ; $221C08
        BTST    D2,D0                           ; $221C0C
        DC.W    $04F0               ; $221C0E DC.W    $04F0
        SUBI.W  #$0700,D4                       ; $221C10
        BTST    D2,-(A0)                        ; $221C14
        BTST    D2,(A0)                         ; $221C16
        CMPI.B  #$0078,D0                       ; $221C18
        ORI.W  #$F3C5,(A2)                      ; $221C1C
        ORI.W  #$51F4,(A7)+                     ; $221C20
        MOVE.W  (A1),$005E(A1)                  ; $221C24
        DBHI    D7,loc_220F73                   ; $221C28
        ORI.W  #$52CA,(A6)+                     ; $221C2C
        MOVE.W  $5F(PC,D0.W),-$0B(A1,D5.W)      ; $221C30
        MOVE.W  D5,(A1)+                        ; $221C36
        ORI.W  #$5272,(A6)+                     ; $221C38
        MOVEA.W $5F(A5,D0.W),A1                 ; $221C3C
        ADDQ.B  #1,(A4)+                        ; $221C40
        MOVE.W  (A4)+,(A1)+                     ; $221C42
        ORI.W  #$5213,(A7)+                     ; $221C44
        MOVE.W  (A4)+,$005F(A3)                 ; $221C48
        SUBQ.W  #1,(A0)+                        ; $221C4C
        DC.W    $F77F,$005F         ; $221C4E MOVE.W  <EA:3F>,$005F(A3)
        SUBQ.W  #8,-$78(A6,A7.W)                ; $221C52
        ORI.W  #$5174,(A7)+                     ; $221C56
        MOVE.W  -(A4),$005F(A3)                 ; $221C5A
        SUBQ.W  #1,(A2)+                        ; $221C5E
        MOVE.W  -(A1),D4                        ; $221C60
        ORI.W  #$5160,(A7)+                     ; $221C62
        MOVE.W  -(A4),(A4)+                     ; $221C66
        ORI.W  #$5680,(A7)+                     ; $221C68
        MOVE.W  -(A7),(A3)+                     ; $221C6C
        ORI.W  #$552E,(A7)+                     ; $221C6E
        MOVE.W  (A7)+,(A3)+                     ; $221C72
        ORI.W  #$5529,(A7)+                     ; $221C74
        MOVEA.W -(A0),A3                        ; $221C78
        ORI.W  #$5619,-(A0)                     ; $221C7A
        MOVEA.W -(A7),A3                        ; $221C7E
        ORI.W  #$561F,-(A0)                     ; $221C80
        MOVEA.W (A0),A2                         ; $221C84
        ORI.W  #$563E,-(A4)                     ; $221C86
        MOVE.W  D0,$005F(PC)                    ; $221C8A
        ADDQ.W  #2,-$0A37(A3)                   ; $221C8E
        ORI.W  #$5471,(A7)+                     ; $221C92
        MOVEA.W (A0)+,A2                        ; $221C96
        ORI.W  #$5644,-(A4)                     ; $221C98
        MOVE.W  $0065(A7),D1                    ; $221C9C
        ADDQ.B  #2,D0                           ; $221CA0
        MOVE.W  $0065(A1),D1                    ; $221CA2
        SLS     $F1E3.W                         ; $221CA6
        ORI.W  #$538A,-(A5)                     ; $221CAA
        MOVE.W  $0065(A3),$2B(A0,D5.W)          ; $221CAE
        MOVEA.W -(A3),A2                        ; $221CB4
        ORI.W  #$5384,(A7)+                     ; $221CB6
        DC.W    $F2FD               ; $221CBA MOVE.W  <EA:3D>,(A1)+
        ORI.W  #$5544,-(A5)                     ; $221CBC
        MOVE.W  $0065.W,(A1)+                   ; $221CC0
        SUBQ.B  #2,#$F45B                       ; $221CC4
        ORI.W  #$537E,(A7)+                     ; $221CC8
        MOVEA.W $0062(A6),A1                    ; $221CCC
        ADDQ.B  #1,(A3)                         ; $221CD0
        MOVE.W  $0065(A1),(A2)+                 ; $221CD2
        ADDQ.W  #4,D7                           ; $221CD6
        MOVE.W  $64(A7,D0.W),$572F(A2)          ; $221CD8
        MOVE.W  $64(A1,D0.W),$5728(A2)          ; $221CDE
        MOVE.W  -(A6),D2                        ; $221CE4
        ORI.W  #$4FBE,-$0BE4(A0)                ; $221CE6
        ORI.W  #$4FBF,-$08CE(A0)                ; $221CEC
        ORI.W  #$4F6C,-$08D8(A0)                ; $221CF2
        ORI.W  #$4F6D,-$0D0B(A0)                ; $221CF8
        ORI.W  #$4FE0,-$0CEC(A0)                ; $221CFE
        ORI.W  #$4FDB,-$0877(A0)                ; $221D04
        ORI.W  #$4F62,-$0B65(A0)                ; $221D0A
        ORI.W  #$57CD,-(A5)                     ; $221D10
        MOVE.W  (A6),(A2)                       ; $221D14
        ORI.W  #$57C5,-(A5)                     ; $221D16
        MOVEA.W (A5),A4                         ; $221D1A
        ORI.W  #$515E,-(A1)                     ; $221D1C
        DC.W    $F7BD,$006B         ; $221D20 MOVE.W  <EA:3D>,$6B(A3,D0.W)
        DC.W    $4F5A               ; $221D24 DC.W    $4F5A
        MOVE.W  $006B(A5),(A1)+                 ; $221D26
        LEA     -(A2),A7                        ; $221D2A
        MOVE.W  $006C(A3),$2B(A0,D5.W)          ; $221D2C
        MOVE.W  (A1),(A0)+                      ; $221D32
        ORI.W  #$5271,$5D(A0,A7.W)              ; $221D34
        ORI.W  #$51F8,-(A2)                     ; $221D3A
        MOVE.W  $72(A2,D0.W),-(A4)              ; $221D3E
        SNE     (A4)                            ; $221D42
        MOVE.W  -(A1),-(A2)                     ; $221D44
        ORI.W  #$58A6,-$0D98(A6)                ; $221D46
        ORI.W  #$5209,$5D(A2,A7.W)              ; $221D4C
        ORI.W  #$51F8,-$2B(A2,A7.W)             ; $221D52
        ORI.W  #$4FE5,$2D(PC,A7.W)              ; $221D58
        ORI.W  #$50CB,-(A4)                     ; $221D5E
        MOVE.W  A1,(A0)                         ; $221D62
        ORI.W  #$5534,-$7C(A7,A7.W)             ; $221D64
        ORI.W  #$552B,$47(A7,A7.W)              ; $221D6A
        ORI.W  #$54AA,$1E(A7,A7.W)              ; $221D70
        ORI.W  #$5447,$7B(A7,A7.W)              ; $221D76
        ORI.W  #$5942,$64(A7,A7.W)              ; $221D7C
        ORI.W  #$5215,-(A2)                     ; $221D82
        MOVEA.W -(A4),A1                        ; $221D86
        DC.W    $007F,$5215         ; $221D88 ORI.W  #$5215,<EA:3F>
        MOVEA.W $0077(A7),A1                    ; $221D8C
        ADDQ.B  #1,(A3)                         ; $221D90
        MOVE.W  -(A5),(A1)+                     ; $221D92
        ORI.W  #$4FE3,$1E(PC,A7.W)              ; $221D94
        DC.W    $007E,$5447         ; $221D9A ORI.W  #$5447,<EA:3E>
        ASL.W  #7,D7                            ; $221D9E
        DC.W    $007E,$52ED         ; $221DA0 ORI.W  #$52ED,<EA:3E>
        MOVE.W  -(A0),$6C(A0,D0.W)              ; $221DA4
        SUBQ.B  #1,-$0E55(A4)                   ; $221DA8
        ORI.L  #$532BF1A0,D1                    ; $221DAC
        ORI.L  #$532CF10E,A1                    ; $221DB2
        ORI.W  #$5649,$60(A7,A6.L)              ; $221DB8
        ORI.L  #$56E9EF5D,A2                    ; $221DBE
        ORI.L  #$56E0F109,A2                    ; $221DC4
        ORI.W  #$5640,$55(A7,A7.W)              ; $221DCA
        ORI.L  #$59E3EED9,A2                    ; $221DD0
        ORI.L  #$5547F013,A2                    ; $221DD6
        DC.W    $007E,$5445         ; $221DDC ORI.W  #$5445,<EA:3E>
        MOVE.W  (A6)+,D0                        ; $221DE0
        ORI.L  #$5447F012,(A2)                  ; $221DE2
        ORI.L  #$5445F25B,(A2)+                 ; $221DE8
        DC.W    $03CD               ; $221DEE BSET    D1,A5
        SF      $2D(A7,A7.W)                    ; $221DF0
        DC.W    $03CD               ; $221DF4 BSET    D1,A5
        DBT     D3,loc_220D40                   ; $221DF6
        DC.W    $03CD               ; $221DFA BSET    D1,A5
        SHI     -$1111(A4)                      ; $221DFC
        DC.W    $007D,$51CD         ; $221E00 ORI.W  #$51CD,<EA:3D>
        ROR.W  $03CD(A7)                        ; $221E04
        DBRA    D6,loc_221121                   ; $221E08
        ORI.W  #$52A8,(A6)+                     ; $221E0C
        MOVE.W  $005F(A3),$5200(A1)             ; $221E10
        MOVE.W  $5F(A5,D0.W),$51FE(A1)          ; $221E16
        MOVE.W  (A7)+,-(A1)                     ; $221E1C
        ORI.W  #$52AE,(A6)+                     ; $221E1E
        MOVE.W  (A6)+,(A2)+                     ; $221E22
        ORI.W  #$5334,(A7)+                     ; $221E24
        MOVE.W  (A5)+,-(A2)                     ; $221E28
        ORI.W  #$52BB,(A7)+                     ; $221E2A
        MOVE.W  -(A6),-(A2)                     ; $221E2E
        ORI.W  #$52BD,(A7)+                     ; $221E30
        MOVE.W  -(A6),(A2)+                     ; $221E34
        ORI.W  #$5337,(A7)+                     ; $221E36
        MOVE.W  (A2),$005F(A2)                  ; $221E3A
        DC.W    $51BF               ; $221E3E SUBQ.L  #8,<EA:3F>
        MOVE.W  (A3)+,$005F(A2)                 ; $221E40
        DC.W    $51BE               ; $221E44 SUBQ.L  #8,<EA:3E>
        MOVE.W  $0065(A1),D1                    ; $221E46
        SLS     $2E(A7,A7.W)                    ; $221E4A
        ORI.W  #$5400,-(A5)                     ; $221E4E
        DC.W    $F43D               ; $221E52 MOVE.W  <EA:3D>,D2
        ORI.W  #$4FBC,-$0BB8(A0)                ; $221E54
        ORI.W  #$4FBB,-$0AA2(A0)                ; $221E5A
        ORI.W  #$4F9D,-$0A99(A0)                ; $221E60
        ORI.W  #$4F9C,-$0F63(A0)                ; $221E66
        ORI.W  #$555E,-$5F(A7,A7.W)             ; $221E6C
        ORI.W  #$5568,$52(A7,A7.W)              ; $221E72
        ORI.W  #$5734,-$0DFE(A3)                ; $221E78
        ORI.W  #$5845,-$03(A7,A7.W)             ; $221E7E
        ORI.W  #$583C,$4D(A7,A7.W)              ; $221E84
        ORI.W  #$572C,-$0DBD(A3)                ; $221E8A
        DC.W    $00FF               ; $221E90 DC.W    $00FF
        ADDQ.B  #1,D1                           ; $221E92
        MOVEA.W D3,A1                           ; $221E94
        ORI.L  #$5201EF64,(A0)                  ; $221E96
        ORI.L  #$52E6EF64,(A5)                  ; $221E9C
        BTST    D0,D4                           ; $221EA2
        SHI     -(A6)                           ; $221EA4
        MOVEA.W D3,A1                           ; $221EA6
        BSET    D0,(A6)+                        ; $221EA8
        ADDQ.B  #1,D0                           ; $221EAA
        MOVEA.W D3,A1                           ; $221EAC
        BCHG    D0,$5200(A6)                    ; $221EAE
        ASL.W  D7,D4                            ; $221EB2
        BCHG    D0,-$1A(A3,D5.W)                ; $221EB4
        ASL.W  D7,D4                            ; $221EB8
        BSET    D0,-(A1)                        ; $221EBA
        SHI     -(A6)                           ; $221EBC
        MOVEA.W D3,A1                           ; $221EBE
        DC.W    $02BC,$5200,$F243,$024D,$5200; $221EC0 ANDI.L  #$5200F243,#$024D5200
        ASL.W  D7,D4                            ; $221ECA
        ANDI.W  #$52E6,(A0)                     ; $221ECC
        ASL.W  D7,D5                            ; $221ED0
        DC.W    $02BE,$52E6,$EF65   ; $221ED2 ANDI.L  #$52E6EF65,<EA:3E>
        BTST    D1,$52E6(A5)                    ; $221ED8
        ASL.W  D7,D5                            ; $221EDC
        BCLR    D1,(A3)+                        ; $221EDE
        SHI     -(A6)                           ; $221EE0
        MOVEA.W D3,A1                           ; $221EE2
        BCLR    D1,(A3)+                        ; $221EE4
        ADDQ.B  #1,D0                           ; $221EE6
        MOVEA.W D3,A1                           ; $221EE8
        BTST    D1,$5200(A3)                    ; $221EEA
        DC.W    $0018,$B200         ; $221EEE ORI.B  #$B200,(A0)+
        BTST    D1,$40(A0,D0.W)                 ; $221EF2
        BSET    D1,-(A0)                        ; $221EF6
        BTST    D1,-(A0)                        ; $221EF8
        DC.W    $0218,$B200         ; $221EFA ANDI.B  #$B200,(A0)+
        BSET    D0,(A0)                         ; $221EFE
        DC.W    $02F0               ; $221F00 DC.W    $02F0
        ADDI.B  #$AD00,(A4)                     ; $221F02
        BSET    D1,-(A0)                        ; $221F06
        DC.W    $02C0               ; $221F08 DC.W    $02C0
        DC.W    $0208,$1400         ; $221F0A ANDI.B  #$1400,A0
        ANDI.W  #$0050,(A0)                     ; $221F0E
        DC.W    $0209,$1401         ; $221F12 ANDI.B  #$1401,A1
        BCLR    D0,D0                           ; $221F16
        ADDI.B  #$1300,A0                       ; $221F18
        ORI.W  #$0170,D0                        ; $221F1C
        ADDI.B  #$1401,A1                       ; $221F20
        ORI.W  #$0608,-(A0)                     ; $221F24
        MOVE.B  D0,-(A2)                        ; $221F28
        ANDI.W  #$0260,(A0)                     ; $221F2A
        DC.W    $0208,$0F00         ; $221F2E ANDI.B  #$0F00,A0
        ANDI.W  #$00B0,$08(A0,D0.W)             ; $221F32
        DC.W    $0E00               ; $221F38 DC.W    $0E00
        DC.W    $00C0               ; $221F3A DC.W    $00C0
        ORI.W  #$0408,D0                        ; $221F3C
        BTST    D6,D0                           ; $221F40
        BSET    D0,-(A0)                        ; $221F42
        BCHG    D0,$08(A0,D0.W)                 ; $221F44
        DC.W    $0E00               ; $221F48 DC.W    $0E00
        BCLR    D1,-(A0)                        ; $221F4A
        BCLR    D1,D0                           ; $221F4C
        DC.W    $0208,$1400         ; $221F4E ANDI.B  #$1400,A0
        BCLR    D1,(A0)                         ; $221F52
        BCLR    D0,D0                           ; $221F54
        SUBI.B  #$B000,(A0)+                    ; $221F56
        BSET    D1,-$30(A0,D0.W)                ; $221F5A
        DC.W    $0219,$B101         ; $221F5E ANDI.B  #$B101,(A1)+
        BSET    D0,(A0)                         ; $221F62
        ADDI.B  #$B400,(A6)                     ; $221F64
        DC.W    $02E0               ; $221F68 DC.W    $02E0
        DC.W    $02F0               ; $221F6A DC.W    $02F0
        SUBI.B  #$1C00,(A4)                     ; $221F6C
        DC.W    $04F0               ; $221F70 DC.W    $04F0
        DC.W    $04D0               ; $221F72 DC.W    $04D0
        SUBI.B  #$1A00,(A0)                     ; $221F74
        BTST    D2,(A0)                         ; $221F78
        DC.W    $04E0               ; $221F7A DC.W    $04E0
        SUBI.B  #$0F00,(A0)                     ; $221F7C
        BTST    D2,D0                           ; $221F80
        BCHG    D1,(A0)                         ; $221F82
        DC.W    $0210,$1600         ; $221F84 ANDI.B  #$1600,(A0)
        DC.W    $02F0               ; $221F88 DC.W    $02F0
        DC.W    $04D0               ; $221F8A DC.W    $04D0
        ADDI.B  #$8401,(A7)                     ; $221F8C
        BCHG    D1,D0                           ; $221F90
        DC.W    $0004,$1B00         ; $221F92 ORI.B  #$1B00,D4
        DC.W    $0230,$0090,$0080   ; $221F96 ANDI.B  #$0090,-$80(A0,D0.W)
        ANDI.W  #$0604,D0                       ; $221F9C
        MOVE.B  D0,-(A5)                        ; $221FA0
        ORI.L  #$00700404,-(A0)                 ; $221FA2
        MOVE.B  D0,-(A5)                        ; $221FA8
        DC.W    $00D0               ; $221FAA DC.W    $00D0
        DC.W    $00E0               ; $221FAC DC.W    $00E0
        SUBI.B  #$1B00,D4                       ; $221FAE
        BTST    D0,D0                           ; $221FB2
        DC.W    $00F0               ; $221FB4 DC.W    $00F0
        SUBI.B  #$1B00,D4                       ; $221FB6
        BSET    D0,$00(A0,D0.W)                 ; $221FBA
        SUBI.B  #$1B00,D4                       ; $221FBE
        ANDI.L  #$02900004,D0                   ; $221FC2
        MOVE.B  D0,-(A5)                        ; $221FC8
        DC.W    $0210,$0000         ; $221FCA ANDI.B  #$0000,(A0)
        DC.W    $0030,$0220,$0604   ; $221FCE ORI.B  #$0220,$04(A0,D0.W)
        MOVE.B  D0,-(A5)                        ; $221FD4
        DC.W    $0010,$0020         ; $221FD6 ORI.B  #$0020,(A0)
        SUBI.B  #$1B00,D4                       ; $221FDA
        BCHG    D0,(A0)                         ; $221FDE
        BCHG    D0,-(A0)                        ; $221FE0
        SUBI.B  #$1B00,D4                       ; $221FE2
        BCHG    D1,-(A0)                        ; $221FE6
        BCHG    D1,$00(A0,D0.W)                 ; $221FE8
        MOVE.L  D0,D0                           ; $221FEC
        SUBI.B  #$02D0,(A0)                     ; $221FEE
        SUBI.B  #$0430,-(A0)                    ; $221FF2
        SUBI.B  #$2000,D0                       ; $221FF6
        DC.W    $04B0,$04C0,$0004,$F900; $221FFA SUBI.L  #$04C00004,$00(A0,A7.L)
        BTST    D0,(A0)                         ; $222002
        BTST    D0,-(A0)                        ; $222004
        BTST    D0,$40(A0,D0.W)                 ; $222006
        DC.W    $0004,$F900         ; $22200A ORI.B  #$F900,D4
        BCLR    D0,(A0)                         ; $22200E
        BCLR    D0,-(A0)                        ; $222010
        BCLR    D0,-$40(A0,D0.W)                ; $222012
        DC.W    $0008,$1500         ; $222016 ORI.B  #$1500,A0
        ANDI.L  #$00B00270,-(A0)                ; $22201A
        DC.W    $02B0,$0008,$1300,$00C0; $222020 ANDI.L  #$00081300,-$40(A0,D0.W)
        BTST    D1,D0                           ; $222028
        BTST    D1,(A0)                         ; $22202A
        BSET    D0,-(A0)                        ; $22202C
        DC.W    $0000,$2000         ; $22202E ORI.B  #$2000,D0
        BSET    D0,(A0)                         ; $222032
        BCLR    D1,-$40(A0,D0.W)                ; $222034
        BSET    D1,(A0)                         ; $222038
        DC.W    $0016,$B300         ; $22203A ORI.B  #$B300,(A6)
        DC.W    $02D0               ; $22203E DC.W    $02D0
        BSET    D1,$00(A0,D0.W)                 ; $222040
        DC.W    $02E0               ; $222044 DC.W    $02E0
        DC.W    $0000,$2000         ; $222046 ORI.B  #$2000,D0
        BSET    D1,(A0)                         ; $22204A
        SUBI.B  #$0430,-(A0)                    ; $22204C
        BSET    D1,D0                           ; $222050
        DC.W    $0004,$F900         ; $222052 ORI.B  #$F900,D4
        SUBI.W  #$0450,D0                       ; $222056
        SUBI.W  #$0470,-(A0)                    ; $22205A
        DC.W    $0008,$0F00         ; $22205E ORI.B  #$0F00,A0
        BCLR    D1,D0                           ; $222062
        BCLR    D1,-(A0)                        ; $222064
        SUBI.L  #$04900000,D0                   ; $222066
        MOVE.L  D0,D0                           ; $22206C
        SUBI.L  #$03F004B0,-(A0)                ; $22206E
        DC.W    $04C0               ; $222074 DC.W    $04C0
        ORI.W  #$0900,D4                        ; $222076
        BTST    D2,-$20(A0,D0.W)                ; $22207A
        BSET    D2,$40(A0,D0.W)                 ; $22207E
        ANDI.W  #$0800,D4                       ; $222082
        BCHG    D2,(A0)                         ; $222086
        BTST    D2,-(A0)                        ; $222088
        SUBI.W  #$0700,D4                       ; $22208A
        BSET    D2,(A0)                         ; $22208E
        BSET    D2,D0                           ; $222090
        SUBI.W  #$0800,D4                       ; $222092
        ADDI.B  #$0620,$44(A0,D0.W)             ; $222096
        DC.W    $0A00,$0560         ; $22209C EORI.B  #$0560,D0
        BCHG    D2,-$80(A0,D0.W)                ; $2220A0
        BCLR    D2,(A0)                         ; $2220A4
        ADDI.W  #$0A00,D4                       ; $2220A6
        BCLR    D2,-(A0)                        ; $2220AA
        BCLR    D2,$44(A0,D0.W)                 ; $2220AC
        BTST    D5,D0                           ; $2220B0
        ADDI.B  #$0610,D0                       ; $2220B2
        ORI.W  #$0A00,D4                        ; $2220B6
        ADDI.W  #$0650,D0                       ; $2220BA
        ADDI.W  #$0670,-(A0)                    ; $2220BE
        ORI.W  #$B600,(A2)                      ; $2220C2
        ADDI.L  #$069006A0,D0                   ; $2220C6
        DC.W    $06B0,$0052,$B600,$06C0; $2220CC ADDI.L  #$0052B600,-$40(A0,D0.W)
        DC.W    $06D0               ; $2220D4 DC.W    $06D0
        DC.W    $06E0               ; $2220D6 DC.W    $06E0
        DC.W    $06F0               ; $2220D8 DC.W    $06F0
        ORI.W  #$B600,(A2)                      ; $2220DA
        BTST    D3,D0                           ; $2220DE
        BTST    D3,(A0)                         ; $2220E0
        BTST    D3,-(A0)                        ; $2220E2
        BTST    D3,$52(A0,D0.W)                 ; $2220E4
        CMP.B  D0,D3                            ; $2220E8
        BCHG    D3,D0                           ; $2220EA
        BCHG    D3,(A0)                         ; $2220EC
        BCHG    D3,-(A0)                        ; $2220EE
        BCHG    D3,$00(A0,D0.L)                 ; $2220F0
        DC.W    $001D,$001D         ; $2220F4 ORI.B  #$001D,(A5)+
        MOVE.W  -(A6),$004F(A4)                 ; $2220F8
        ADDQ.L  #2,-(A5)                        ; $2220FC
        MOVE.W  -(A3),(A4)+                     ; $2220FE
        ORI.W  #$5141,A7                        ; $222100
        MOVE.W  (A5)+,(A5)+                     ; $222104
        ORI.W  #$50E9,A7                        ; $222106
        MOVE.W  D5,$4F(A5,D0.W)                 ; $22210A
        ADDQ.W  #3,-(A1)                        ; $22210E
        ORI.L  #$004F5799,D4                    ; $222110
        DC.W    $FFEB,$004F         ; $222116 MOVE.W  $004F(A3),<EA:3F>
        SVC     D0                              ; $22211A
        MOVE.W  $72(A2,D0.W),-(A4)              ; $22211C
        SNE     (A4)                            ; $222120
        MOVEA.W -(A1),A4                        ; $222122
        ORI.W  #$515D,-$37(A2,A7.W)             ; $222124
        ORI.W  #$4F59,$4B(PC,A7.L)              ; $22212A
        ORI.W  #$4F3D,A7                        ; $222130
        MOVE.W  -(A4),(A4)+                     ; $222134
        ORI.W  #$5680,(A7)+                     ; $222136
        MOVE.W  -(A1),D4                        ; $22213A
        ORI.W  #$5160,(A7)+                     ; $22213C
        MOVEA.W (A5),A4                         ; $222140
        ORI.W  #$515E,-(A1)                     ; $222142
        MOVEA.W (A5),A4                         ; $222146
        ORI.W  #$515F,-$43(A2,A7.W)             ; $222148
        ORI.W  #$4F5A,-$0843(A3)                ; $22214E
        ORI.W  #$4F5A,$2E(PC,A7.L)              ; $222154
        ORI.W  #$56DF,$32(A2,A7.L)              ; $22215A
        ORI.L  #$56D4F92F,D7                    ; $222160
        ORI.L  #$56DFFB86,A7                    ; $222166
        DC.W    $00B1,$5081,$00CB,$00B1; $22216C ORI.L  #$508100CB,-$4F(A1,D0.W)
        SNE     $52(A2,A7.L)                    ; $222174
        BCHG    D0,$57C6(A0)                    ; $222178
        DC.W    $FDD9               ; $22217C MOVE.W  (A1)+,<EA:3E>
        ORI.W  #$5726,A7                        ; $22217E
        MOVE.W  $68(A1,D0.W),$5820(A6)          ; $222182
        MOVE.W  $6B(A0,D0.W),-$15(A4,D5.W)      ; $222188
        MOVEA.W (A4),A6                         ; $22218E
        DC.W    $034F               ; $222190 BCHG    D1,A7
        ADDQ.W  #8,(A2)                         ; $222192
        BTST    D0,-$0F(A2,D0.W)                ; $222194
        ADDQ.W  #3,-$40(A7,D0.W)                ; $222198
        SUBI.W  #$54FB,(A0)                     ; $22219C
        MOVE.W  A7,-$51(A6,D0.W)                ; $2221A0
        LEA     A4,A7                           ; $2221A4
        DC.W    $0008,$1400         ; $2221A6 ORI.B  #$1400,A0
        ORI.W  #$00A0,-(A0)                     ; $2221AA
        DC.W    $00B0,$00C0,$0219,$B001; $2221AE ORI.L  #$00C00219,$01(A0,A3.W)
        DC.W    $00D0               ; $2221B6 DC.W    $00D0
        ADDI.B  #$B100,(A0)+                    ; $2221B8
        DC.W    $00E0               ; $2221BC DC.W    $00E0
        DC.W    $00F0               ; $2221BE DC.W    $00F0
        DC.W    $0214,$B200         ; $2221C0 ANDI.B  #$B200,(A4)
        ORI.L  #$00700416,D0                    ; $2221C4
        MOVE.B  D0,D1                           ; $2221CA
        ORI.L  #$00100216,(A0)                  ; $2221CC
        MOVE.B  D0,D1                           ; $2221D2
        DC.W    $0000,$0060         ; $2221D4 ORI.B  #$0060,D0
        SUBI.B  #$8401,(A7)                     ; $2221D8
        DC.W    $0030,$0616,$9400   ; $2221DC ORI.B  #$0616,$00(A0,A1.W)
        DC.W    $0010,$0020         ; $2221E2 ORI.B  #$0020,(A0)
        DC.W    $0216,$9500         ; $2221E6 ANDI.B  #$9500,(A6)
        ORI.W  #$0050,D0                        ; $2221EA
        ADDI.B  #$8300,(A6)                     ; $2221EE
        BTST    D0,$40(A0,D0.W)                 ; $2221F2
        SUBI.B  #$9F00,(A6)                     ; $2221F6
        BCLR    D0,(A0)                         ; $2221FA
        BCLR    D0,-(A0)                        ; $2221FC
        SUBI.B  #$A000,(A6)                     ; $2221FE
