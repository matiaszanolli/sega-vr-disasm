; Generated assembly for $2B4200-$2B6200
; Branch targets: 126
; Labels: 122
; Format: DC.W with decoded mnemonics as comments

        org     $2B4200

        MOVE.W  -(A5),(A5)+                     ; $2B4200
        ORI.W  #$01BA,(A0)+                     ; $2B4202
        MOVE.W  (A6)+,D5                        ; $2B4206
        BSET    D0,D4                           ; $2B4208
        DC.W    $0034,$FA3F,$014F   ; $2B420A ORI.B  #$FA3F,$4F(A4,D0.W)
        DC.W    $FFBD,$F864         ; $2B4210 MOVE.W  <EA:3D>,$64(A7,A7.L)
        DC.W    $00DC               ; $2B4214 DC.W    $00DC
        MOVE.W  -$07BD(A1),$50(A7,D0.W)         ; $2B4216
        DC.W    $001F,$FA18         ; $2B421C ORI.B  #$FA18,(A7)+
        BSET    D0,-$54(A4,A7.L)                ; $2B4220
        DC.W    $F83D               ; $2B4224 MOVE.W  <EA:3D>,D4
        BCLR    D0,D1                           ; $2B4226
        MOVE.W  (A0)+,$08(A7,A7.L)              ; $2B4228
        DC.W    $00BE,$FFDA,$F83D   ; $2B422C ORI.L  #$FFDAF83D,<EA:3E>
        BTST    D0,-(A2)                        ; $2B4232
        DC.W    $FFC3               ; $2B4234 MOVE.W  D3,<EA:3F>
        MOVE.W  (A7),$57(A4,D0.W)               ; $2B4236
        MOVE.W  -$069E(A5),-$000C(A7)           ; $2B423A
        MOVE.W  D4,$04(A7,A7.L)                 ; $2B4240
        DC.W    $00E0               ; $2B4244 DC.W    $00E0
        MOVE.W  $F95E.W,$0015(A7)               ; $2B4246
        MOVE.W  -(A2),-(A7)                     ; $2B424C
        MOVE.W  (A4),(A4)                       ; $2B424E
        DC.W    $FFE1               ; $2B4250 MOVE.W  -(A1),<EA:3F>
        MOVE.W  D3,-$0759(A7)                   ; $2B4252
        MOVE.W  -$00CB(A2),-$4A(A7,A7.L)        ; $2B4256
        DC.W    $0003,$FF53         ; $2B425C ORI.B  #$FF53,D3
        MOVE.W  (A7),$58(A4,D0.W)               ; $2B4260
        MOVE.W  $0010(A2),$6E00(A7)             ; $2B4264
        DC.W    $0000,$0010         ; $2B426A ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2B426E ORI.B  #$0030,-(A0)
        ADDI.B  #$6F00,(A0)                     ; $2B4272
        ORI.W  #$0050,D0                        ; $2B4276
        SUBI.B  #$7000,(A0)                     ; $2B427A
        ORI.W  #$0070,-(A0)                     ; $2B427E
        SUBI.B  #$6F00,(A0)                     ; $2B4282
        DC.W    $0000,$0030         ; $2B4286 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2B428A ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2B428E ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2B4292 ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2B4296
        DC.W    $00B0,$0210,$0400,$00D0; $2B429C ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2B42A4 DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2B42A6
        ORI.L  #$00900611,-(A0)                 ; $2B42AA
        BTST    D3,D1                           ; $2B42B0
        DC.W    $00B0,$0010,$6A00,$00E0; $2B42B2 ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2B42BA DC.W    $00F0
        BTST    D0,D0                           ; $2B42BC
        BTST    D0,(A0)                         ; $2B42BE
        DC.W    $0210,$6C00         ; $2B42C0 ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2B42C4
        SUBI.B  #$6B00,(A0)                     ; $2B42C8
        BTST    D0,D0                           ; $2B42CC
        DC.W    $00F0               ; $2B42CE DC.W    $00F0
        DC.W    $0211,$6901         ; $2B42D0 ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2B42D4 DC.W    $00E0
        DC.W    $0010,$6300         ; $2B42D6 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2B42DA
        BCHG    D0,(A0)                         ; $2B42DC
        BCHG    D0,-(A0)                        ; $2B42DE
        BCHG    D0,$10(A0,D0.W)                 ; $2B42E0
        BCS.W  loc_2B4476                       ; $2B42E4
        BCLR    D0,D0                           ; $2B42E8
        SUBI.B  #$6400,(A0)                     ; $2B42EA
        BCHG    D0,-(A0)                        ; $2B42EE
        BCHG    D0,(A0)                         ; $2B42F0
        ADDI.B  #$6201,(A1)                     ; $2B42F2
        BCHG    D0,$10(A0,D0.W)                 ; $2B42F6
        BPL.W  loc_2B44DC                       ; $2B42FA
        BSET    D0,$00(A0,D0.W)                 ; $2B42FE
        DC.W    $0210,$0210         ; $2B4302 ANDI.B  #$0210,(A0)
        BGE.W  loc_2B4538                       ; $2B4306
        DC.W    $0220,$0410         ; $2B430A ANDI.B  #$0410,-(A0)
        BMI.W  loc_2B4510                       ; $2B430E
        BSET    D0,$11(A0,D0.W)                 ; $2B4312
        BVS.S  loc_2B4319                       ; $2B4316
        DC.W    $0210,$0010         ; $2B4318 ANDI.B  #$0010,(A0)
        BLS.W  loc_2B455E                       ; $2B431C
        ANDI.W  #$0260,(A0)                     ; $2B4320
        ANDI.W  #$0210,$00(A0,D6.W)             ; $2B4324
        ANDI.L  #$02800410,(A0)                 ; $2B432A
        BCC.W  loc_2B4592                       ; $2B4330
        ANDI.W  #$0211,(A0)                     ; $2B4334
        BHI.S  loc_2B433B                       ; $2B4338
        ANDI.W  #$0010,D0                       ; $2B433A
        BNE.W  loc_2B45E0                       ; $2B433E
        DC.W    $02B0,$02C0,$02D0,$0610; $2B4342 ANDI.L  #$02C002D0,$10(A0,D0.W)
        BEQ.W  loc_2B462C                       ; $2B434A
        DC.W    $02F0               ; $2B434E DC.W    $02F0
        SUBI.B  #$6800,(A0)                     ; $2B4350
        BTST    D1,D0                           ; $2B4354
        BTST    D1,(A0)                         ; $2B4356
        SUBI.B  #$6700,(A0)                     ; $2B4358
        ANDI.L  #$02D00010,-(A0)                ; $2B435C
        BTST    D1,D0                           ; $2B4362
        BTST    D1,-(A0)                        ; $2B4364
        BTST    D1,$40(A0,D0.W)                 ; $2B4366
        BCHG    D1,(A0)                         ; $2B436A
        DC.W    $0210,$0500         ; $2B436C ANDI.B  #$0500,(A0)
        BCHG    D1,$60(A0,D0.W)                 ; $2B4370
        SUBI.B  #$0400,(A0)                     ; $2B4374
        BCHG    D1,D0                           ; $2B4378
        BTST    D1,$10(A0,D0.W)                 ; $2B437A
        BCS.W  loc_2B4700                       ; $2B437E
        BCLR    D1,(A0)                         ; $2B4382
        BCLR    D1,-(A0)                        ; $2B4384
        BCLR    D1,$10(A0,D0.W)                 ; $2B4386
        BLS.W  loc_2B475C                       ; $2B438A
        BSET    D1,D0                           ; $2B438E
        SUBI.B  #$6400,(A0)                     ; $2B4390
        BCLR    D1,-(A0)                        ; $2B4394
        BCLR    D1,(A0)                         ; $2B4396
        DC.W    $0010,$0300         ; $2B4398 ORI.B  #$0300,(A0)
        SUBI.B  #$0430,-(A0)                    ; $2B439C
        SUBI.W  #$0450,D0                       ; $2B43A0
        DC.W    $0210,$0500         ; $2B43A4 ANDI.B  #$0500,(A0)
        SUBI.W  #$0460,$10(A0,D0.W)             ; $2B43A8
        SUBI.B  #$0440,D0                       ; $2B43AE
        SUBI.B  #$0010,$00(A0,D6.W)             ; $2B43B2
        SUBI.L  #$049004A0,D0                   ; $2B43B8
        DC.W    $04B0,$0210,$6300,$04D0; $2B43BE SUBI.L  #$02106300,-$30(A0,D0.W)
        DC.W    $04C0               ; $2B43C6 DC.W    $04C0
        SUBI.B  #$6400,(A0)                     ; $2B43C8
        SUBI.L  #$04900000,-(A0)                ; $2B43CC
        BVS.W  loc_2B4574                       ; $2B43D2
        BCLR    D0,-$40(A0,D0.W)                ; $2B43D6
        BSET    D0,(A0)                         ; $2B43DA
        DC.W    $0000,$6600         ; $2B43DC ORI.B  #$6600,D0
        BSET    D1,-(A0)                        ; $2B43E0
        BSET    D1,$00(A0,D0.W)                 ; $2B43E2
        SUBI.B  #$0000,(A0)                     ; $2B43E6
        BNE.W  loc_2B48CC                       ; $2B43EA
        DC.W    $04F0               ; $2B43EE DC.W    $04F0
        BTST    D2,D0                           ; $2B43F0
        BTST    D2,(A0)                         ; $2B43F2
        CMPI.B  #$0052,D0                       ; $2B43F4
        ORI.W  #$F8ED,(A2)                      ; $2B43F8
        DC.W    $0221,$0088         ; $2B43FC ANDI.B  #$0088,-(A1)
        MOVE.W  $023D(A5),(A4)+                 ; $2B4400
        MOVE.W  -$0809(A2),$0365(A7)            ; $2B4404
        MOVE.W  -$0809(A2),$0343(A7)            ; $2B440A
        DC.W    $00C1               ; $2B4410 DC.W    $00C1
        MOVE.W  A5,-$4C(A4,D0.W)                ; $2B4412
        MOVE.W  -$44(A5,A7.L),$03F6(A7)         ; $2B4416
        MOVE.W  $F98D.W,$0297(A7)               ; $2B441C
        ORI.L  #$F8BC03D4,(A4)                  ; $2B4422
        DC.W    $00CF               ; $2B4428 DC.W    $00CF
        MOVE.W  A6,(A4)                         ; $2B442A
        BSET    D1,(A3)+                        ; $2B442C
        ORI.L  #$F80C0369,D0                    ; $2B442E
        DC.W    $001C,$F771         ; $2B4434 ORI.B  #$F771,(A4)+
        DC.W    $0439,$0030,$F813,$047E; $2B4438 SUBI.B  #$0030,$F813047E
        ORI.L  #$F88E03EB,(A0)                  ; $2B4440
        DC.W    $FFD0               ; $2B4446 MOVE.W  (A0),<EA:3F>
        MOVE.W  (A3),D4                         ; $2B4448
        SUBI.L  #$FFE1F83F,(A0)                 ; $2B444A
        BCHG    D1,-(A7)                        ; $2B4450
        DC.W    $00CC               ; $2B4452 DC.W    $00CC
        DC.W    $F87D               ; $2B4454 MOVEA.W <EA:3D>,A4
        BCHG    D1,(A0)                         ; $2B4456
        BTST    D0,-$0698(A4)                   ; $2B4458
        ANDI.W  #$00CE,(A6)                     ; $2B445C
        DC.W    $F93F               ; $2B4460 MOVE.W  <EA:3F>,-(A4)
        ANDI.W  #$0067,(A4)                     ; $2B4462
        MOVE.W  (A3),(A4)                       ; $2B4466
        BCLR    D1,$00E6(A4)                    ; $2B4468
        MOVE.W  (A2),-$67(A4,D0.W)              ; $2B446C
        ORI.L  #$F97202E6,D1                    ; $2B4470
loc_2B4476:
        DC.W    $00AF,$F98C,$02AF,$00E6; $2B4476 ORI.L  #$F98C02AF,$00E6(A7)
        DC.W    $F87F               ; $2B447E MOVEA.W <EA:3F>,A4
        BSET    D0,-(A7)                        ; $2B4480
        ORI.L  #$F82C01F3,(A3)+                 ; $2B4482
        ORI.W  #$F9A6,(A3)                      ; $2B4488
        DC.W    $02A8,$0098,$F860,$01B6; $2B448C ANDI.L  #$0098F860,$01B6(A0)
        DC.W    $003D,$F950         ; $2B4494 ORI.B  #$F950,<EA:3D>
        BSET    D0,D7                           ; $2B4498
        DC.W    $003A,$F71F,$01CD   ; $2B449A ORI.B  #$F71F,$01CD(PC)
        DC.W    $003B,$F851,$0120   ; $2B44A0 ORI.B  #$F851,$20(PC,D0.W)
        DC.W    $FFFC,$F996         ; $2B44A6 MOVE.W  #$F996,<EA:3F>
        BTST    D0,(A0)                         ; $2B44AA
        DC.W    $FFF7,$F845         ; $2B44AC MOVE.W  $45(A7,A7.L),<EA:3F>
        ANDI.W  #$FF42,(A1)                     ; $2B44B0
        MOVEA.W #$025A,A4                       ; $2B44B4
        MOVE.W  -(A3),(A7)+                     ; $2B44B8
        MOVE.W  A3,(A4)                         ; $2B44BA
        BCLR    D1,#$FF07                       ; $2B44BC
        MOVEA.W (A3),A4                         ; $2B44C0
        BSET    D1,(A3)                         ; $2B44C2
        MOVE.W  -$074C(A2),$024D(A7)            ; $2B44C4
        MOVE.W  D2,-$073E(A7)                   ; $2B44CA
        DC.W    $03CF               ; $2B44CE BSET    D1,A7
        MOVE.W  -$08DC(A2),$0264(A7)            ; $2B44D0
        MOVE.W  $75(A4,A7.W),-(A7)              ; $2B44D6
        ANDI.W  #$FEEA,A6                       ; $2B44DA
        MOVE.W  D7,(A4)+                        ; $2B44DE
        ANDI.L  #$FEF1F8BF,A2                   ; $2B44E0
        DC.W    $02AC,$FF3C,$F733,$0212; $2B44E6 ANDI.L  #$FF3CF733,$0212(A4)
        MOVE.W  -$0733(A4),-(A7)                ; $2B44EE
        ANDI.W  #$FF34,(A2)+                    ; $2B44F2
        MOVE.W  D3,-$1A(A4,D0.W)                ; $2B44F6
        DC.W    $00AB,$F998,$00EB,$FF4A; $2B44FA ORI.L  #$F99800EB,-$00B6(A3)
        MOVE.W  $50(A2,D0.W),(A4)+              ; $2B4502
        MOVE.W  -(A6),-$071F(A7)                ; $2B4506
        ANDI.W  #$0086,A4                       ; $2B450A
        MOVEA.W D0,A5                           ; $2B450E
loc_2B4510:
        BTST    D0,$FF55.W                      ; $2B4510
        MOVE.W  (A2)+,-$63(A4,D0.W)             ; $2B4514
        MOVE.W  $2A(A1,A7.L),$0133(A7)          ; $2B4518
        DC.W    $00B6,$F989,$0299,$0092; $2B451E ORI.L  #$F9890299,-$6E(A6,D0.W)
        MOVE.W  D5,-$53(A4,A7.L)                ; $2B4526
        ORI.L  #$F9DCFFEA,-(A4)                 ; $2B452A
        BTST    D0,-$05F1(A0)                   ; $2B4530
        BCLR    D0,(A5)                         ; $2B4534
        ORI.W  #$F9B8,D2                        ; $2B4536
        BCHG    D0,(A1)+                        ; $2B453A
        DC.W    $FFBF,$F935         ; $2B453C MOVE.W  <EA:3F>,$35(A7,A7.L)
        DC.W    $FFEE,$010B         ; $2B4540 MOVE.W  $010B(A6),<EA:3F>
        MOVE.W  $0199(A0),$0024(A4)             ; $2B4544
        MOVE.W  D7,-(A5)                        ; $2B454A
        DC.W    $FFE8,$01C8         ; $2B454C MOVE.W  $01C8(A0),<EA:3F>
        MOVE.W  $0056(A4),(A5)+                 ; $2B4550
        BCLR    D0,-$6B(A7,A7.L)                ; $2B4554
        DC.W    $FFE4               ; $2B4558 MOVE.W  -(A4),<EA:3F>
        DC.W    $00F4               ; $2B455A DC.W    $00F4
        MOVE.W  $75(A0,A7.L),$07(A4,D0.W)       ; $2B455C
        MOVE.W  A6,(A5)+                        ; $2B4562
        DC.W    $0015,$0211         ; $2B4564 ORI.B  #$0211,(A5)
        MOVE.W  -$5D(A7,A7.L),$014F(A4)         ; $2B4568
        MOVEA.W -$0097(A4),A5                   ; $2B456E
        DC.W    $0220,$FA9D         ; $2B4572 ANDI.B  #$FA9D,-(A0)
        MOVE.W  D7,$0220(A7)                    ; $2B4576
        MOVE.W  $23(A4,D0.W),-(A5)              ; $2B457A
        BCLR    D0,$FAE70058                    ; $2B457E
        BCLR    D0,$FA1201C8                    ; $2B4584
        DC.W    $001C,$FA3D         ; $2B458A ORI.B  #$FA3D,(A4)+
        BCHG    D0,D4                           ; $2B458E
        MOVE.W  $64(PC,A7.L),-$15(A7,D0.W)      ; $2B4590
        MOVE.W  -(A3),-$07C7(A7)                ; $2B4596
        BCHG    D0,-$003B(A6)                   ; $2B459A
        MOVE.W  -(A5),D5                        ; $2B459E
        BSET    D0,-$006F(A0)                   ; $2B45A0
        MOVEA.W A4,A4                           ; $2B45A4
        DC.W    $018E               ; $2B45A6 BCLR    D0,A6
        MOVE.W  $F80000D6,-(A7)                 ; $2B45A8
        MOVE.W  D5,$3D(A7,A7.L)                 ; $2B45AE
        BTST    D0,$6E(A5,A7.L)                 ; $2B45B2
        MOVE.W  (A6),$57(A4,D0.W)               ; $2B45B6
        MOVE.W  -$06A6(A5),-$0007(A7)           ; $2B45BA
        MOVE.W  D4,$0E(A7,A7.L)                 ; $2B45C0
        DC.W    $00EC               ; $2B45C4 DC.W    $00EC
        MOVE.W  -(A1),-(A7)                     ; $2B45C6
        MOVE.W  $000F(A0),-$00E0(A4)            ; $2B45C8
        MOVE.W  (A3),(A4)                       ; $2B45CE
        DC.W    $FFE2               ; $2B45D0 MOVE.W  -(A2),<EA:3F>
        MOVE.W  D4,-$075A(A7)                   ; $2B45D2
        MOVE.W  -$00CA(A4),-$4A(A7,A7.L)        ; $2B45D6
        DC.W    $0003,$FF53         ; $2B45DC ORI.B  #$FF53,D3
loc_2B45E0:
        MOVE.W  (A7),$58(A4,D0.W)               ; $2B45E0
        MOVE.W  $0010(A2),$6E00(A7)             ; $2B45E4
        DC.W    $0000,$0010         ; $2B45EA ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2B45EE ORI.B  #$0030,-(A0)
        ADDI.B  #$6F00,(A0)                     ; $2B45F2
        ORI.W  #$0050,D0                        ; $2B45F6
        SUBI.B  #$7000,(A0)                     ; $2B45FA
        ORI.W  #$0070,-(A0)                     ; $2B45FE
        SUBI.B  #$6F00,(A0)                     ; $2B4602
        DC.W    $0000,$0030         ; $2B4606 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2B460A ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2B460E ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2B4612 ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2B4616
        DC.W    $00B0,$0210,$0400,$00D0; $2B461C ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2B4624 DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2B4626
        ORI.L  #$00900611,-(A0)                 ; $2B462A
        BTST    D3,D1                           ; $2B4630
        DC.W    $00B0,$0010,$6A00,$00E0; $2B4632 ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2B463A DC.W    $00F0
        BTST    D0,D0                           ; $2B463C
        BTST    D0,(A0)                         ; $2B463E
        DC.W    $0210,$6C00         ; $2B4640 ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2B4644
        SUBI.B  #$6B00,(A0)                     ; $2B4648
        BTST    D0,D0                           ; $2B464C
        DC.W    $00F0               ; $2B464E DC.W    $00F0
        DC.W    $0211,$6901         ; $2B4650 ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2B4654 DC.W    $00E0
        DC.W    $0010,$6300         ; $2B4656 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2B465A
        BCHG    D0,(A0)                         ; $2B465C
        BCHG    D0,-(A0)                        ; $2B465E
        BCHG    D0,$10(A0,D0.W)                 ; $2B4660
        BCS.W  loc_2B47F6                       ; $2B4664
        BCLR    D0,D0                           ; $2B4668
        SUBI.B  #$6400,(A0)                     ; $2B466A
        BCHG    D0,-(A0)                        ; $2B466E
        BCHG    D0,(A0)                         ; $2B4670
        ADDI.B  #$6201,(A1)                     ; $2B4672
        BCHG    D0,$10(A0,D0.W)                 ; $2B4676
        BPL.W  loc_2B485C                       ; $2B467A
        BSET    D0,$00(A0,D0.W)                 ; $2B467E
        DC.W    $0210,$0210         ; $2B4682 ANDI.B  #$0210,(A0)
        BGE.W  loc_2B48B8                       ; $2B4686
        DC.W    $0220,$0410         ; $2B468A ANDI.B  #$0410,-(A0)
        BMI.W  loc_2B4890                       ; $2B468E
        BSET    D0,$11(A0,D0.W)                 ; $2B4692
        BVS.S  loc_2B4699                       ; $2B4696
        DC.W    $0210,$0010         ; $2B4698 ANDI.B  #$0010,(A0)
        BLS.W  loc_2B48DE                       ; $2B469C
        ANDI.W  #$0260,(A0)                     ; $2B46A0
        ANDI.W  #$0210,$00(A0,D6.W)             ; $2B46A4
        ANDI.L  #$02800410,(A0)                 ; $2B46AA
        BCC.W  loc_2B4912                       ; $2B46B0
        ANDI.W  #$0211,(A0)                     ; $2B46B4
        BHI.S  loc_2B46BB                       ; $2B46B8
        ANDI.W  #$0010,D0                       ; $2B46BA
        BNE.W  loc_2B4960                       ; $2B46BE
        DC.W    $02B0,$02C0,$02D0,$0610; $2B46C2 ANDI.L  #$02C002D0,$10(A0,D0.W)
        BEQ.W  loc_2B49AC                       ; $2B46CA
        DC.W    $02F0               ; $2B46CE DC.W    $02F0
        SUBI.B  #$6800,(A0)                     ; $2B46D0
        BTST    D1,D0                           ; $2B46D4
        BTST    D1,(A0)                         ; $2B46D6
        SUBI.B  #$6700,(A0)                     ; $2B46D8
        ANDI.L  #$02D00010,-(A0)                ; $2B46DC
        BTST    D1,D0                           ; $2B46E2
        BTST    D1,-(A0)                        ; $2B46E4
        BTST    D1,$40(A0,D0.W)                 ; $2B46E6
        BCHG    D1,(A0)                         ; $2B46EA
        DC.W    $0210,$0500         ; $2B46EC ANDI.B  #$0500,(A0)
        BCHG    D1,$60(A0,D0.W)                 ; $2B46F0
        SUBI.B  #$0400,(A0)                     ; $2B46F4
        BCHG    D1,D0                           ; $2B46F8
        BTST    D1,$10(A0,D0.W)                 ; $2B46FA
        BCS.W  loc_2B4A80                       ; $2B46FE
        BCLR    D1,(A0)                         ; $2B4702
        BCLR    D1,-(A0)                        ; $2B4704
        BCLR    D1,$10(A0,D0.W)                 ; $2B4706
        BLS.W  loc_2B4ADC                       ; $2B470A
        BSET    D1,D0                           ; $2B470E
        SUBI.B  #$6400,(A0)                     ; $2B4710
        BCLR    D1,-(A0)                        ; $2B4714
        BCLR    D1,(A0)                         ; $2B4716
        DC.W    $0010,$0300         ; $2B4718 ORI.B  #$0300,(A0)
        SUBI.B  #$0430,-(A0)                    ; $2B471C
        SUBI.W  #$0450,D0                       ; $2B4720
        DC.W    $0210,$0500         ; $2B4724 ANDI.B  #$0500,(A0)
        SUBI.W  #$0460,$10(A0,D0.W)             ; $2B4728
        SUBI.B  #$0440,D0                       ; $2B472E
        SUBI.B  #$0010,$00(A0,D6.W)             ; $2B4732
        SUBI.L  #$049004A0,D0                   ; $2B4738
        DC.W    $04B0,$0210,$6300,$04D0; $2B473E SUBI.L  #$02106300,-$30(A0,D0.W)
        DC.W    $04C0               ; $2B4746 DC.W    $04C0
        SUBI.B  #$6400,(A0)                     ; $2B4748
        SUBI.L  #$04900000,-(A0)                ; $2B474C
        BVS.W  loc_2B48F4                       ; $2B4752
        BCLR    D0,-$40(A0,D0.W)                ; $2B4756
        BSET    D0,(A0)                         ; $2B475A
loc_2B475C:
        DC.W    $0000,$6600         ; $2B475C ORI.B  #$6600,D0
        BSET    D1,-(A0)                        ; $2B4760
        BSET    D1,$00(A0,D0.W)                 ; $2B4762
        SUBI.B  #$0000,(A0)                     ; $2B4766
        BNE.W  loc_2B4C4C                       ; $2B476A
        DC.W    $04F0               ; $2B476E DC.W    $04F0
        BTST    D2,D0                           ; $2B4770
        BTST    D2,(A0)                         ; $2B4772
        CMPI.B  #$0052,D0                       ; $2B4774
        ORI.W  #$F8F1,(A2)                      ; $2B4778
        DC.W    $021C,$0089         ; $2B477C ANDI.B  #$0089,(A4)+
        MOVE.W  $38(A0,D0.W),(A4)+              ; $2B4780
        MOVE.W  -$0813(A3),$0354(A7)            ; $2B4784
        MOVE.W  -$0811(A3),$0333(A7)            ; $2B478A
        DC.W    $00C2               ; $2B4790 DC.W    $00C2
        MOVE.W  A3,-$4B(A4,D0.W)                ; $2B4792
        MOVE.W  -$54(A6,A7.L),$03EE(A7)         ; $2B4796
        MOVE.W  $F98C.W,$0299(A7)               ; $2B479C
        ORI.L  #$F8AE03CC,(A4)                  ; $2B47A2
        DC.W    $00CF               ; $2B47A8 DC.W    $00CF
        DC.W    $F87E               ; $2B47AA MOVEA.W <EA:3E>,A4
        BSET    D1,(A0)                         ; $2B47AC
        ORI.L  #$F802035A,D1                    ; $2B47AE
        DC.W    $001D,$F75E         ; $2B47B4 ORI.B  #$F75E,(A5)+
        SUBI.B  #$0032,-(A2)                    ; $2B47B8
        MOVE.W  #$0470,-$6F(PC,D0.W)            ; $2B47BC
        DC.W    $F87D               ; $2B47C2 MOVEA.W <EA:3D>,A4
        BSET    D1,-(A2)                        ; $2B47C4
        DC.W    $FFD1               ; $2B47C6 MOVE.W  (A1),<EA:3F>
        MOVE.W  -$7F(PC,D0.W),-$1E(PC,A7.L)     ; $2B47C8
        MOVE.W  $60(A6,D0.W),D4                 ; $2B47CE
        DC.W    $00CD               ; $2B47D2 DC.W    $00CD
        MOVEA.W $48(A4,D0.W),A4                 ; $2B47D4
        BTST    D0,-$069E(A4)                   ; $2B47D8
        ANDI.W  #$00CA,(A1)                     ; $2B47DC
        MOVE.W  $02520063,-(A4)                 ; $2B47E0
        MOVE.W  A1,(A4)                         ; $2B47E6
        BCLR    D1,-(A4)                        ; $2B47E8
        DC.W    $00E8               ; $2B47EA DC.W    $00E8
        MOVE.W  A4,-$69(A4,D0.W)                ; $2B47EC
        DC.W    $007D,$F96F         ; $2B47F0 ORI.W  #$F96F,<EA:3D>
        DC.W    $02E5               ; $2B47F4 DC.W    $02E5
loc_2B47F6:
        DC.W    $00AE,$F988,$02AB,$00E4; $2B47F6 ORI.L  #$F98802AB,$00E4(A6)
        MOVEA.W -$12(A4,D0.W),A4                ; $2B47FE
        ORI.L  #$F81F01FE,(A1)+                 ; $2B4802
        ORI.W  #$F9A0,(A3)                      ; $2B4808
        ANDI.L  #$0095F850,-(A5)                ; $2B480C
        BSET    D0,D0                           ; $2B4812
        DC.W    $003A,$F942,$01C9   ; $2B4814 ORI.B  #$F942,$01C9(PC)
        DC.W    $0034,$F712,$01E2   ; $2B481A ORI.B  #$F712,-$1E(A4,D0.W)
        DC.W    $003E,$F83C         ; $2B4820 ORI.B  #$F83C,<EA:3E>
        BTST    D0,-$0009(A4)                   ; $2B4824
        MOVE.W  D0,$11(A4,D0.W)                 ; $2B4828
        DC.W    $FFEC,$F846         ; $2B482C MOVE.W  -$07BA(A4),<EA:3F>
        ANDI.W  #$FF41,D5                       ; $2B4830
        DC.W    $F87D               ; $2B4834 MOVEA.W <EA:3D>,A4
        ANDI.W  #$FEE1,A7                       ; $2B4836
        MOVEA.W #$03B2,A4                       ; $2B483A
        MOVE.W  A0,-(A7)                        ; $2B483E
        MOVEA.W D4,A4                           ; $2B4840
        BSET    D1,D7                           ; $2B4842
        MOVE.W  -$074B(A2),$0245(A7)            ; $2B4844
        MOVE.W  D1,-$074D(A7)                   ; $2B484A
        BSET    D1,D7                           ; $2B484E
        MOVE.W  -$08D9(A3),$0268(A7)            ; $2B4850
        MOVE.W  $77(A4,A7.W),-(A7)              ; $2B4856
        ANDI.W  #$FEEA,(A1)                     ; $2B485A
        MOVE.W  A2,(A4)+                        ; $2B485E
        ANDI.L  #$FEF0F8C4,D2                   ; $2B4860
        ANDI.L  #$FF3BF733,-(A3)                ; $2B4866
        DC.W    $0216,$FF2A         ; $2B486C ANDI.B  #$FF2A,(A6)
        MOVE.W  (A0),(A4)+                      ; $2B4870
        ANDI.W  #$FF33,(A0)                     ; $2B4872
        MOVE.W  D4,-$19(A4,D0.W)                ; $2B4876
        DC.W    $00AC,$F999,$00EC,$FF4B; $2B487A ORI.L  #$F99900EC,-$00B5(A4)
        MOVE.W  $51(A2,D0.W),(A4)+              ; $2B4882
        MOVE.W  -(A6),-$071F(A7)                ; $2B4886
        ANDI.W  #$0087,A5                       ; $2B488A
        MOVEA.W D1,A5                           ; $2B488E
loc_2B4890:
        BTST    D0,-$00A9(PC)                   ; $2B4890
        MOVE.W  (A2)+,-$61(A4,D0.W)             ; $2B4894
        MOVE.W  $2C(A1,A7.L),$0135(A7)          ; $2B4898
        DC.W    $00B7,$F989,$029B,$0092; $2B489E ORI.L  #$F989029B,-$6E(A7,D0.W)
        MOVE.W  D5,-$51(A4,A7.L)                ; $2B48A6
        ORI.L  #$F9DDFFEB,-(A4)                 ; $2B48AA
        BTST    D0,-$05F1(A0)                   ; $2B48B0
        BCLR    D0,(A7)                         ; $2B48B4
        ORI.W  #$F9B7,D3                        ; $2B48B6
        BCHG    D0,(A3)+                        ; $2B48BA
        DC.W    $FFC0               ; $2B48BC MOVE.W  D0,<EA:3F>
        MOVE.W  -$11(A6,A7.L),-(A4)             ; $2B48BE
        DC.W    $010C               ; $2B48C2 BTST    D0,A4
        MOVE.W  $019B(A0),$0025(A4)             ; $2B48C4
        MOVE.W  A0,-(A5)                        ; $2B48CA
loc_2B48CC:
        DC.W    $FFE8,$01C7         ; $2B48CC MOVE.W  $01C7(A0),<EA:3F>
        MOVE.W  $0056(A5),(A5)+                 ; $2B48D0
        BCLR    D0,-$6A(A6,A7.L)                ; $2B48D4
        DC.W    $FFE6               ; $2B48D8 MOVE.W  -(A6),<EA:3F>
        DC.W    $00F5               ; $2B48DA DC.W    $00F5
        MOVE.W  $77(A1,A7.L),$07(A4,D0.W)       ; $2B48DC
        MOVE.W  (A0),(A5)+                      ; $2B48E2
        DC.W    $0015,$0211         ; $2B48E4 ORI.B  #$0211,(A5)
        MOVE.W  $FFA4.W,$014F(A4)               ; $2B48E8
        MOVEA.W -$0097(A5),A5                   ; $2B48EE
        DC.W    $0220,$FA9E         ; $2B48F2 ANDI.B  #$FA9E,-(A0)
        MOVE.W  A0,$0220(A7)                    ; $2B48F6
        MOVE.W  $24(A5,D0.W),-(A5)              ; $2B48FA
        BCLR    D0,$FAE80059                    ; $2B48FE
        BCLR    D0,$FA1101C9                    ; $2B4904
        DC.W    $001D,$FA3D         ; $2B490A ORI.B  #$FA3D,(A5)+
        BCHG    D0,D6                           ; $2B490E
        MOVE.W  #$F864,-$14(A7,D0.W)            ; $2B4910
        MOVE.W  -(A3),-$07C7(A7)                ; $2B4916
        BCHG    D0,-$003A(A7)                   ; $2B491A
        MOVE.W  -(A5),D5                        ; $2B491E
        BSET    D0,-$006D(A1)                   ; $2B4920
        MOVEA.W A5,A4                           ; $2B4924
        DC.W    $018F               ; $2B4926 BCLR    D0,A7
        MOVE.W  -$0800(PC),-(A7)                ; $2B4928
        DC.W    $00D7               ; $2B492C DC.W    $00D7
        MOVE.W  D5,$3E(A7,A7.L)                 ; $2B492E
        BTST    D0,$6E(A6,A7.L)                 ; $2B4932
        MOVE.W  (A6),$57(A4,D0.W)               ; $2B4936
        MOVE.W  -$06A6(A5),-$0007(A7)           ; $2B493A
        MOVE.W  D4,$0F(A7,A7.L)                 ; $2B4940
        DC.W    $00ED               ; $2B4944 DC.W    $00ED
        MOVE.W  -(A1),-(A7)                     ; $2B4946
        MOVE.W  -(A7),$000F(A4)                 ; $2B4948
        MOVE.W  -(A0),-(A7)                     ; $2B494C
        MOVE.W  (A3),(A4)                       ; $2B494E
        DC.W    $FFE2               ; $2B4950 MOVE.W  -(A2),<EA:3F>
        MOVE.W  D4,-$075A(A7)                   ; $2B4952
        MOVE.W  -$00CA(A4),-$4A(A7,A7.L)        ; $2B4956
        DC.W    $0003,$FF53         ; $2B495C ORI.B  #$FF53,D3
loc_2B4960:
        MOVE.W  (A7),$58(A4,D0.W)               ; $2B4960
        MOVE.W  $0010(A2),$6E00(A7)             ; $2B4964
        DC.W    $0000,$0010         ; $2B496A ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2B496E ORI.B  #$0030,-(A0)
        ADDI.B  #$6F00,(A0)                     ; $2B4972
        ORI.W  #$0050,D0                        ; $2B4976
        SUBI.B  #$7000,(A0)                     ; $2B497A
        ORI.W  #$0070,-(A0)                     ; $2B497E
        SUBI.B  #$6F00,(A0)                     ; $2B4982
        DC.W    $0000,$0030         ; $2B4986 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2B498A ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2B498E ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2B4992 ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2B4996
        DC.W    $00B0,$0210,$0400,$00D0; $2B499C ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2B49A4 DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2B49A6
        ORI.L  #$00900611,-(A0)                 ; $2B49AA
        BTST    D3,D1                           ; $2B49B0
        DC.W    $00B0,$0010,$6A00,$00E0; $2B49B2 ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2B49BA DC.W    $00F0
        BTST    D0,D0                           ; $2B49BC
        BTST    D0,(A0)                         ; $2B49BE
        DC.W    $0210,$6C00         ; $2B49C0 ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2B49C4
        SUBI.B  #$6B00,(A0)                     ; $2B49C8
        BTST    D0,D0                           ; $2B49CC
        DC.W    $00F0               ; $2B49CE DC.W    $00F0
        DC.W    $0211,$6901         ; $2B49D0 ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2B49D4 DC.W    $00E0
        DC.W    $0010,$6300         ; $2B49D6 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2B49DA
        BCHG    D0,(A0)                         ; $2B49DC
        BCHG    D0,-(A0)                        ; $2B49DE
        BCHG    D0,$10(A0,D0.W)                 ; $2B49E0
        BCS.W  loc_2B4B76                       ; $2B49E4
        BCLR    D0,D0                           ; $2B49E8
        SUBI.B  #$6400,(A0)                     ; $2B49EA
        BCHG    D0,-(A0)                        ; $2B49EE
        BCHG    D0,(A0)                         ; $2B49F0
        ADDI.B  #$6201,(A1)                     ; $2B49F2
        BCHG    D0,$10(A0,D0.W)                 ; $2B49F6
        BPL.W  loc_2B4BDC                       ; $2B49FA
        BSET    D0,$00(A0,D0.W)                 ; $2B49FE
        DC.W    $0210,$0210         ; $2B4A02 ANDI.B  #$0210,(A0)
        BGE.W  loc_2B4C38                       ; $2B4A06
        DC.W    $0220,$0410         ; $2B4A0A ANDI.B  #$0410,-(A0)
        BMI.W  loc_2B4C10                       ; $2B4A0E
        BSET    D0,$11(A0,D0.W)                 ; $2B4A12
        BVS.S  loc_2B4A19                       ; $2B4A16
        DC.W    $0210,$0010         ; $2B4A18 ANDI.B  #$0010,(A0)
        BLS.W  loc_2B4C5E                       ; $2B4A1C
        ANDI.W  #$0260,(A0)                     ; $2B4A20
        ANDI.W  #$0210,$00(A0,D6.W)             ; $2B4A24
        ANDI.L  #$02800410,(A0)                 ; $2B4A2A
        BCC.W  loc_2B4C92                       ; $2B4A30
        ANDI.W  #$0211,(A0)                     ; $2B4A34
        BHI.S  loc_2B4A3B                       ; $2B4A38
        ANDI.W  #$0010,D0                       ; $2B4A3A
        BNE.W  loc_2B4CE0                       ; $2B4A3E
        DC.W    $02B0,$02C0,$02D0,$0610; $2B4A42 ANDI.L  #$02C002D0,$10(A0,D0.W)
        BEQ.W  loc_2B4D2C                       ; $2B4A4A
        DC.W    $02F0               ; $2B4A4E DC.W    $02F0
        SUBI.B  #$6800,(A0)                     ; $2B4A50
        BTST    D1,D0                           ; $2B4A54
        BTST    D1,(A0)                         ; $2B4A56
        SUBI.B  #$6700,(A0)                     ; $2B4A58
        ANDI.L  #$02D00010,-(A0)                ; $2B4A5C
        BTST    D1,D0                           ; $2B4A62
        BTST    D1,-(A0)                        ; $2B4A64
        BTST    D1,$40(A0,D0.W)                 ; $2B4A66
        BCHG    D1,(A0)                         ; $2B4A6A
        DC.W    $0210,$0500         ; $2B4A6C ANDI.B  #$0500,(A0)
        BCHG    D1,$60(A0,D0.W)                 ; $2B4A70
        SUBI.B  #$0400,(A0)                     ; $2B4A74
        BCHG    D1,D0                           ; $2B4A78
        BTST    D1,$10(A0,D0.W)                 ; $2B4A7A
        BCS.W  loc_2B4E00                       ; $2B4A7E
        BCLR    D1,(A0)                         ; $2B4A82
        BCLR    D1,-(A0)                        ; $2B4A84
        BCLR    D1,$10(A0,D0.W)                 ; $2B4A86
        BLS.W  loc_2B4E5C                       ; $2B4A8A
        BSET    D1,D0                           ; $2B4A8E
        SUBI.B  #$6400,(A0)                     ; $2B4A90
        BCLR    D1,-(A0)                        ; $2B4A94
        BCLR    D1,(A0)                         ; $2B4A96
        DC.W    $0010,$0300         ; $2B4A98 ORI.B  #$0300,(A0)
        SUBI.B  #$0430,-(A0)                    ; $2B4A9C
        SUBI.W  #$0450,D0                       ; $2B4AA0
        DC.W    $0210,$0500         ; $2B4AA4 ANDI.B  #$0500,(A0)
        SUBI.W  #$0460,$10(A0,D0.W)             ; $2B4AA8
        SUBI.B  #$0440,D0                       ; $2B4AAE
        SUBI.B  #$0010,$00(A0,D6.W)             ; $2B4AB2
        SUBI.L  #$049004A0,D0                   ; $2B4AB8
        DC.W    $04B0,$0210,$6300,$04D0; $2B4ABE SUBI.L  #$02106300,-$30(A0,D0.W)
        DC.W    $04C0               ; $2B4AC6 DC.W    $04C0
        SUBI.B  #$6400,(A0)                     ; $2B4AC8
        SUBI.L  #$04900000,-(A0)                ; $2B4ACC
        BVS.W  loc_2B4C74                       ; $2B4AD2
        BCLR    D0,-$40(A0,D0.W)                ; $2B4AD6
        BSET    D0,(A0)                         ; $2B4ADA
loc_2B4ADC:
        DC.W    $0000,$6600         ; $2B4ADC ORI.B  #$6600,D0
        BSET    D1,-(A0)                        ; $2B4AE0
        BSET    D1,$00(A0,D0.W)                 ; $2B4AE2
        SUBI.B  #$0000,(A0)                     ; $2B4AE6
        BNE.W  loc_2B4FCC                       ; $2B4AEA
        DC.W    $04F0               ; $2B4AEE DC.W    $04F0
        BTST    D2,D0                           ; $2B4AF0
        BTST    D2,(A0)                         ; $2B4AF2
        CMPI.B  #$0052,D0                       ; $2B4AF4
        ORI.W  #$F8F5,(A2)                      ; $2B4AF8
        DC.W    $0218,$008A         ; $2B4AFC ANDI.B  #$008A,(A0)+
        MOVE.W  $33(A2,D0.W),(A4)+              ; $2B4B00
        MOVE.W  -$081B(A4),$0345(A7)            ; $2B4B04
        MOVE.W  -$0817(A4),$0324(A7)            ; $2B4B0A
        DC.W    $00C3               ; $2B4B10 DC.W    $00C3
        MOVE.W  A0,-$4A(A4,D0.W)                ; $2B4B12
        MOVE.W  -$64(A6,A7.L),$03E6(A7)         ; $2B4B16
        DC.W    $FF79,$F98B,$029B,$0095; $2B4B1C MOVE.W  $F98B029B,$0095(A7)
        MOVE.W  -(A0),(A4)                      ; $2B4B24
        BSET    D1,D5                           ; $2B4B26
        DC.W    $00D0               ; $2B4B28 DC.W    $00D0
        MOVEA.W -$39(A1,D0.W),A4                ; $2B4B2A
        ORI.L  #$F7F8034B,D2                    ; $2B4B2E
        DC.W    $001E,$F74D         ; $2B4B34 ORI.B  #$F74D,(A6)+
        SUBI.B  #$0033,A5                       ; $2B4B38
        MOVE.W  $0461(A1),-$6E(PC,D0.W)         ; $2B4B3C
        MOVEA.W $03D8(A7),A4                    ; $2B4B42
        DC.W    $FFD1               ; $2B4B46 MOVE.W  (A1),<EA:3F>
        MOVE.W  -(A7),$72(PC,D0.W)              ; $2B4B48
        DC.W    $FFE2               ; $2B4B4C MOVE.W  -(A2),<EA:3F>
        MOVE.W  $035A(A6),D4                    ; $2B4B4E
        DC.W    $00CE               ; $2B4B52 DC.W    $00CE
        MOVEA.W $0340(A4),A4                    ; $2B4B54
        BTST    D0,-$06A4(A4)                   ; $2B4B58
        ANDI.W  #$00C5,A5                       ; $2B4B5C
        MOVE.W  $50(A2,D0.W),-(A4)              ; $2B4B60
        ORI.W  #$F87F,(A6)+                     ; $2B4B64
        BCLR    D1,(A6)+                        ; $2B4B68
        DC.W    $00EB               ; $2B4B6A DC.W    $00EB
        MOVE.W  D5,-$6B(A4,D0.W)                ; $2B4B6C
        ORI.W  #$F96C,$02E2(PC)                 ; $2B4B70
loc_2B4B76:
        DC.W    $00AD,$F984,$02A6,$00E1; $2B4B76 ORI.L  #$F98402A6,$00E1(A5)
        MOVEA.W $01F4(A0),A4                    ; $2B4B7E
        ORI.L  #$F813020A,(A7)                  ; $2B4B82
        ORI.W  #$F99B,(A2)                      ; $2B4B88
        ANDI.L  #$0092F842,-(A2)                ; $2B4B8C
        DC.W    $01C9               ; $2B4B92 BSET    D0,A1
        DC.W    $0038,$F933,$01CB   ; $2B4B94 ORI.B  #$F933,$01CB.W
        DC.W    $002E,$F705,$01F6   ; $2B4B9A ORI.B  #$F705,$01F6(A6)
        ORI.W  #$F827,D1                        ; $2B4BA0
        BTST    D0,$FFF1F96A                    ; $2B4BA4
        BTST    D0,(A3)                         ; $2B4BAA
        DC.W    $FFE1               ; $2B4BAC MOVE.W  -(A1),<EA:3F>
        MOVEA.W D7,A4                           ; $2B4BAE
        DC.W    $0239,$FF40,$F87E,$0246; $2B4BB0 ANDI.B  #$FF40,$F87E0246
        MOVE.W  -(A0),(A7)+                     ; $2B4BB8
        MOVEA.W -$59(A0,D0.W),A4                ; $2B4BBA
        MOVE.W  A0,-(A7)                        ; $2B4BBE
        MOVE.W  -$45(A7,D0.W),D4                ; $2B4BC0
        MOVE.W  -$074A(A3),$023E(A7)            ; $2B4BC4
        MOVE.W  D0,-$075B(A7)                   ; $2B4BCA
        DC.W    $03BF               ; $2B4BCE BCLR    D1,<EA:3F>
        MOVE.W  -$08D7(A4),$026C(A7)            ; $2B4BD0
        MOVE.W  $78(A5,A7.W),-(A7)              ; $2B4BD6
        ANDI.W  #$FEEA,(A3)                     ; $2B4BDA
        MOVE.W  A5,(A4)+                        ; $2B4BDE
        DC.W    $0279,$FEEF,$F8C8,$029B; $2B4BE0 ANDI.W  #$FEEF,$F8C8029B
        MOVE.W  $33(PC,A7.W),-(A7)              ; $2B4BE8
        DC.W    $0219,$FF2C         ; $2B4BEC ANDI.B  #$FF2C,(A1)+
        MOVE.W  (A1),(A4)+                      ; $2B4BF0
        ANDI.W  #$FF32,A0                       ; $2B4BF2
        MOVE.W  D4,-$17(A4,D0.W)                ; $2B4BF6
        DC.W    $00AD,$F999,$00ED,$FF4C; $2B4BFA ORI.L  #$F99900ED,-$00B4(A5)
        MOVE.W  $52(A2,D0.W),(A4)+              ; $2B4C02
        MOVE.W  -(A7),-$071F(A7)                ; $2B4C06
        ANDI.W  #$0088,A6                       ; $2B4C0A
        MOVEA.W D1,A5                           ; $2B4C0E
loc_2B4C10:
        BTST    D0,$58(PC,A7.L)                 ; $2B4C10
        MOVE.W  (A2)+,-$60(A4,D0.W)             ; $2B4C14
        MOVE.W  $2C(A2,A7.L),$0136(A7)          ; $2B4C18
        DC.W    $00B8,$F989,$029C,$0093; $2B4C1E ORI.L  #$F989029C,$0093.W
        MOVE.W  D6,-$50(A4,A7.L)                ; $2B4C26
        ORI.L  #$F9DEFFEC,-(A4)                 ; $2B4C2A
        BTST    D0,-$05F0(A0)                   ; $2B4C30
        BCLR    D0,(A0)+                        ; $2B4C34
        ORI.W  #$F9B7,D3                        ; $2B4C36
        BCHG    D0,(A4)+                        ; $2B4C3A
        DC.W    $FFC1               ; $2B4C3C MOVE.W  D1,<EA:3F>
        MOVE.W  -$10(A7,A7.L),-(A4)             ; $2B4C3E
        DC.W    $010C               ; $2B4C42 BTST    D0,A4
        MOVE.W  $019C(A0),$0027(A4)             ; $2B4C44
        MOVE.W  A2,-(A5)                        ; $2B4C4A
loc_2B4C4C:
        DC.W    $FFE9,$01C6         ; $2B4C4C MOVE.W  $01C6(A1),<EA:3F>
        MOVE.W  $0057(A7),(A5)+                 ; $2B4C50
        BCLR    D0,-$6A(A6,A7.L)                ; $2B4C54
        DC.W    $FFE7               ; $2B4C58 MOVE.W  -(A7),<EA:3F>
        DC.W    $00F5               ; $2B4C5A DC.W    $00F5
        MOVE.W  $78(A1,A7.L),$07(A4,D0.W)       ; $2B4C5C
        MOVE.W  (A1),(A5)+                      ; $2B4C62
        DC.W    $0015,$0210         ; $2B4C64 ORI.B  #$0210,(A5)
        DC.W    $F979,$FFA5,$014F,$FA6E; $2B4C68 MOVE.W  $FFA5014F,-$0592(A4)
        MOVE.W  $021F(A2),-$0561(A7)            ; $2B4C70
        MOVE.W  A0,$021F(A7)                    ; $2B4C76
        MOVE.W  $24(A6,D0.W),-(A5)              ; $2B4C7A
        BCLR    D0,$FAE9.W                      ; $2B4C7E
        ORI.W  #$01B8,(A1)+                     ; $2B4C82
        MOVE.W  (A1),D5                         ; $2B4C86
        DC.W    $01CA               ; $2B4C88 BSET    D0,A2
        DC.W    $001E,$FA3D         ; $2B4C8A ORI.B  #$FA3D,(A6)+
        BCHG    D0,D7                           ; $2B4C8E
        MOVE.W  #$F865,-$14(A7,D0.W)            ; $2B4C90
        MOVE.W  -(A4),-$07C7(A7)                ; $2B4C96
        BCHG    D0,-$003A(A7)                   ; $2B4C9A
        MOVE.W  -(A5),D5                        ; $2B4C9E
        BSET    D0,-$006D(A3)                   ; $2B4CA0
        MOVEA.W A5,A4                           ; $2B4CA4
        BCLR    D0,(A0)                         ; $2B4CA6
        MOVE.W  $00(PC,A7.L),-(A7)              ; $2B4CA8
        DC.W    $00D8               ; $2B4CAC DC.W    $00D8
        MOVE.W  D6,$3E(A7,A7.L)                 ; $2B4CAE
        BTST    D0,$6F(A6,A7.L)                 ; $2B4CB2
        MOVE.W  (A6),$57(A4,D0.W)               ; $2B4CB6
        MOVE.W  -$06A7(A5),-$0007(A7)           ; $2B4CBA
        MOVE.W  D4,$0F(A7,A7.L)                 ; $2B4CC0
        DC.W    $00EE               ; $2B4CC4 DC.W    $00EE
        MOVE.W  -(A2),-(A7)                     ; $2B4CC6
        MOVE.W  -(A7),$000F(A4)                 ; $2B4CC8
        MOVE.W  -(A0),-(A7)                     ; $2B4CCC
        MOVE.W  (A3),(A4)                       ; $2B4CCE
        DC.W    $FFE2               ; $2B4CD0 MOVE.W  -(A2),<EA:3F>
        MOVE.W  D4,-$075A(A7)                   ; $2B4CD2
        MOVE.W  -$00CA(A4),-$4A(A7,A7.L)        ; $2B4CD6
        DC.W    $0003,$FF53         ; $2B4CDC ORI.B  #$FF53,D3
loc_2B4CE0:
        MOVE.W  (A7),$58(A4,D0.W)               ; $2B4CE0
        MOVE.W  $0010(A2),$6E00(A7)             ; $2B4CE4
        DC.W    $0000,$0010         ; $2B4CEA ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2B4CEE ORI.B  #$0030,-(A0)
        ADDI.B  #$6F00,(A0)                     ; $2B4CF2
        ORI.W  #$0050,D0                        ; $2B4CF6
        SUBI.B  #$7000,(A0)                     ; $2B4CFA
        ORI.W  #$0070,-(A0)                     ; $2B4CFE
        SUBI.B  #$6F00,(A0)                     ; $2B4D02
        DC.W    $0000,$0030         ; $2B4D06 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2B4D0A ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2B4D0E ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2B4D12 ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2B4D16
        DC.W    $00B0,$0210,$0400,$00D0; $2B4D1C ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2B4D24 DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2B4D26
        ORI.L  #$00900611,-(A0)                 ; $2B4D2A
        BTST    D3,D1                           ; $2B4D30
        DC.W    $00B0,$0010,$6A00,$00E0; $2B4D32 ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2B4D3A DC.W    $00F0
        BTST    D0,D0                           ; $2B4D3C
        BTST    D0,(A0)                         ; $2B4D3E
        DC.W    $0210,$6C00         ; $2B4D40 ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2B4D44
        SUBI.B  #$6B00,(A0)                     ; $2B4D48
        BTST    D0,D0                           ; $2B4D4C
        DC.W    $00F0               ; $2B4D4E DC.W    $00F0
        DC.W    $0211,$6901         ; $2B4D50 ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2B4D54 DC.W    $00E0
        DC.W    $0010,$6300         ; $2B4D56 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2B4D5A
        BCHG    D0,(A0)                         ; $2B4D5C
        BCHG    D0,-(A0)                        ; $2B4D5E
        BCHG    D0,$10(A0,D0.W)                 ; $2B4D60
        BCS.W  loc_2B4EF6                       ; $2B4D64
        BCLR    D0,D0                           ; $2B4D68
        SUBI.B  #$6400,(A0)                     ; $2B4D6A
        BCHG    D0,-(A0)                        ; $2B4D6E
        BCHG    D0,(A0)                         ; $2B4D70
        ADDI.B  #$6201,(A1)                     ; $2B4D72
        BCHG    D0,$10(A0,D0.W)                 ; $2B4D76
        BPL.W  loc_2B4F5C                       ; $2B4D7A
        BSET    D0,$00(A0,D0.W)                 ; $2B4D7E
        DC.W    $0210,$0210         ; $2B4D82 ANDI.B  #$0210,(A0)
        BGE.W  loc_2B4FB8                       ; $2B4D86
        DC.W    $0220,$0410         ; $2B4D8A ANDI.B  #$0410,-(A0)
        BMI.W  loc_2B4F90                       ; $2B4D8E
        BSET    D0,$11(A0,D0.W)                 ; $2B4D92
        BVS.S  loc_2B4D99                       ; $2B4D96
        DC.W    $0210,$0010         ; $2B4D98 ANDI.B  #$0010,(A0)
        BLS.W  loc_2B4FDE                       ; $2B4D9C
        ANDI.W  #$0260,(A0)                     ; $2B4DA0
        ANDI.W  #$0210,$00(A0,D6.W)             ; $2B4DA4
        ANDI.L  #$02800410,(A0)                 ; $2B4DAA
        BCC.W  loc_2B5012                       ; $2B4DB0
        ANDI.W  #$0211,(A0)                     ; $2B4DB4
        BHI.S  loc_2B4DBB                       ; $2B4DB8
        ANDI.W  #$0010,D0                       ; $2B4DBA
        BNE.W  loc_2B5060                       ; $2B4DBE
        DC.W    $02B0,$02C0,$02D0,$0610; $2B4DC2 ANDI.L  #$02C002D0,$10(A0,D0.W)
        BEQ.W  loc_2B50AC                       ; $2B4DCA
        DC.W    $02F0               ; $2B4DCE DC.W    $02F0
        SUBI.B  #$6800,(A0)                     ; $2B4DD0
        BTST    D1,D0                           ; $2B4DD4
        BTST    D1,(A0)                         ; $2B4DD6
        SUBI.B  #$6700,(A0)                     ; $2B4DD8
        ANDI.L  #$02D00010,-(A0)                ; $2B4DDC
        BTST    D1,D0                           ; $2B4DE2
        BTST    D1,-(A0)                        ; $2B4DE4
        BTST    D1,$40(A0,D0.W)                 ; $2B4DE6
        BCHG    D1,(A0)                         ; $2B4DEA
        DC.W    $0210,$0500         ; $2B4DEC ANDI.B  #$0500,(A0)
        BCHG    D1,$60(A0,D0.W)                 ; $2B4DF0
        SUBI.B  #$0400,(A0)                     ; $2B4DF4
        BCHG    D1,D0                           ; $2B4DF8
        BTST    D1,$10(A0,D0.W)                 ; $2B4DFA
        BCS.W  loc_2B5180                       ; $2B4DFE
        BCLR    D1,(A0)                         ; $2B4E02
        BCLR    D1,-(A0)                        ; $2B4E04
        BCLR    D1,$10(A0,D0.W)                 ; $2B4E06
        BLS.W  loc_2B51DC                       ; $2B4E0A
        BSET    D1,D0                           ; $2B4E0E
        SUBI.B  #$6400,(A0)                     ; $2B4E10
        BCLR    D1,-(A0)                        ; $2B4E14
        BCLR    D1,(A0)                         ; $2B4E16
        DC.W    $0010,$0300         ; $2B4E18 ORI.B  #$0300,(A0)
        SUBI.B  #$0430,-(A0)                    ; $2B4E1C
        SUBI.W  #$0450,D0                       ; $2B4E20
        DC.W    $0210,$0500         ; $2B4E24 ANDI.B  #$0500,(A0)
        SUBI.W  #$0460,$10(A0,D0.W)             ; $2B4E28
        SUBI.B  #$0440,D0                       ; $2B4E2E
        SUBI.B  #$0010,$00(A0,D6.W)             ; $2B4E32
        SUBI.L  #$049004A0,D0                   ; $2B4E38
        DC.W    $04B0,$0210,$6300,$04D0; $2B4E3E SUBI.L  #$02106300,-$30(A0,D0.W)
        DC.W    $04C0               ; $2B4E46 DC.W    $04C0
        SUBI.B  #$6400,(A0)                     ; $2B4E48
        SUBI.L  #$04900000,-(A0)                ; $2B4E4C
        BVS.W  loc_2B4FF4                       ; $2B4E52
        BCLR    D0,-$40(A0,D0.W)                ; $2B4E56
        BSET    D0,(A0)                         ; $2B4E5A
loc_2B4E5C:
        DC.W    $0000,$6600         ; $2B4E5C ORI.B  #$6600,D0
        BSET    D1,-(A0)                        ; $2B4E60
        BSET    D1,$00(A0,D0.W)                 ; $2B4E62
        SUBI.B  #$0000,(A0)                     ; $2B4E66
        BNE.W  loc_2B534C                       ; $2B4E6A
        DC.W    $04F0               ; $2B4E6E DC.W    $04F0
        BTST    D2,D0                           ; $2B4E70
        BTST    D2,(A0)                         ; $2B4E72
        CMPI.B  #$0052,D0                       ; $2B4E74
        ORI.W  #$F8F9,(A2)                      ; $2B4E78
        DC.W    $0214,$008B         ; $2B4E7C ANDI.B  #$008B,(A4)
        MOVE.W  $2F(A5,D0.W),(A4)+              ; $2B4E80
        MOVE.W  -$0822(A5),$0336(A7)            ; $2B4E84
        MOVE.W  -$081D(A5),$0316(A7)            ; $2B4E8A
        DC.W    $00C4               ; $2B4E90 DC.W    $00C4
        MOVE.W  D6,-$48(A4,D0.W)                ; $2B4E92
        MOVE.W  -$71(A7,A7.L),$03DE(A7)         ; $2B4E96
        MOVE.W  -$0676(PC),$029C(A7)            ; $2B4E9C
        ORI.L  #$F89503BE,(A5)                  ; $2B4EA2
        DC.W    $00D1               ; $2B4EA8 DC.W    $00D1
        MOVEA.W -(A5),A4                        ; $2B4EAA
        DC.W    $03BE               ; $2B4EAC BCLR    D1,<EA:3E>
        ORI.L  #$F7F1033E,D2                    ; $2B4EAE
        DC.W    $001F,$F73F         ; $2B4EB4 ORI.B  #$F73F,(A7)+
        BSET    D1,$0034.W                      ; $2B4EB8
        MOVE.W  (A0)+,$52(PC,D0.W)              ; $2B4EBC
        ORI.L  #$F86203CE,(A2)                  ; $2B4EC0
        DC.W    $FFD2               ; $2B4EC6 MOVE.W  (A2),<EA:3F>
        MOVE.W  (A4),$63(PC,D0.W)               ; $2B4EC8
        DC.W    $FFE3               ; $2B4ECC MOVE.W  -(A3),<EA:3F>
        MOVE.W  -(A5),D4                        ; $2B4ECE
        BCHG    D1,(A3)                         ; $2B4ED0
        DC.W    $00CE               ; $2B4ED2 DC.W    $00CE
        MOVEA.W -(A5),A4                        ; $2B4ED4
        BTST    D1,$012DF954                    ; $2B4ED6
        ANDI.W  #$00C0,A0                       ; $2B4EDC
        MOVE.W  $024D(A4),-(A4)                 ; $2B4EE0
        ORI.W  #$F877,(A2)+                     ; $2B4EE4
        BCLR    D1,(A0)+                        ; $2B4EE8
        DC.W    $00ED               ; $2B4EEA DC.W    $00ED
        DC.W    $F97D,$0292         ; $2B4EEC MOVE.W  <EA:3D>,$0292(A4)
        ORI.W  #$F969,-$21(A7,D0.W)             ; $2B4EF0
loc_2B4EF6:
        DC.W    $00AC,$F97F,$02A1,$00DF; $2B4EF6 ORI.L  #$F97F02A1,$00DF(A4)
        MOVEA.W (A5)+,A4                        ; $2B4EFE
        BSET    D0,-$6B(PC,D0.W)                ; $2B4F00
        MOVE.W  D7,D4                           ; $2B4F04
        DC.W    $0215,$0052         ; $2B4F06 ANDI.B  #$0052,(A5)
        MOVE.W  (A5),-$62(A4,D0.W)              ; $2B4F0A
        ORI.L  #$F83401D3,A7                    ; $2B4F0E
        DC.W    $0036,$F924,$01CD   ; $2B4F14 ORI.B  #$F924,-$33(A6,D0.W)
        DC.W    $0027,$F6F7         ; $2B4F1A ORI.B  #$F6F7,-(A7)
        DC.W    $020C,$0044         ; $2B4F1E ANDI.B  #$0044,A4
        MOVE.W  (A3),D4                         ; $2B4F22
        BCHG    D0,D5                           ; $2B4F24
        DC.W    $FFEC,$F953         ; $2B4F26 MOVE.W  -$06AD(A4),<EA:3F>
        BTST    D0,(A5)                         ; $2B4F2A
        DC.W    $FFD7               ; $2B4F2C MOVE.W  (A7),<EA:3F>
        MOVEA.W D7,A4                           ; $2B4F2E
        DC.W    $022F,$FF3E,$F87F   ; $2B4F30 ANDI.B  #$FF3E,-$0781(A7)
        DC.W    $023E,$FEDF         ; $2B4F36 ANDI.B  #$FEDF,<EA:3E>
        MOVEA.W -(A5),A4                        ; $2B4F3A
        BCLR    D1,(A6)+                        ; $2B4F3C
        MOVE.W  A1,-(A7)                        ; $2B4F3E
        MOVE.W  $03B0(A2),D4                    ; $2B4F40
        MOVE.W  -$074A(A3),$0237(A7)            ; $2B4F44
        DC.W    $FF3F               ; $2B4F4A MOVE.W  <EA:3F>,-(A7)
        MOVE.W  (A1)+,(A4)                      ; $2B4F4C
        BCLR    D1,$FF6D.W                      ; $2B4F4E
        MOVE.W  $0270(A5),-(A3)                 ; $2B4F52
        MOVE.W  $7A(A6,A7.W),-(A7)              ; $2B4F56
        ANDI.W  #$FEEB,(A6)                     ; $2B4F5A
        MOVE.W  A7,(A4)+                        ; $2B4F5E
        ANDI.W  #$FEEE,-$34(A2,A7.L)            ; $2B4F60
        ANDI.L  #$FF3AF734,(A3)                 ; $2B4F66
        DC.W    $021D,$FF2C         ; $2B4F6C ANDI.B  #$FF2C,(A5)+
        MOVE.W  (A2),(A4)+                      ; $2B4F70
        ANDI.W  #$FF31,D0                       ; $2B4F72
        MOVE.W  D5,-$16(A4,D0.W)                ; $2B4F76
        DC.W    $00AD,$F999,$00EF,$FF4D; $2B4F7A ORI.L  #$F99900EF,-$00B3(A5)
        MOVE.W  $53(A2,D0.W),(A4)+              ; $2B4F82
        MOVE.W  -$071F(A0),$0250(A7)            ; $2B4F86
        ORI.L  #$FA41013C,A1                    ; $2B4F8C
        MOVE.W  (A1)+,-$0666(A7)                ; $2B4F92
        ANDI.L  #$FF73FA2C,-(A1)                ; $2B4F96
        BTST    D0,$00B8.W                      ; $2B4F9C
        MOVE.W  A1,-$63(A4,D0.W)                ; $2B4FA0
        ORI.L  #$F986FFB1,(A3)                  ; $2B4FA4
        ORI.L  #$F9DFFFED,-(A5)                 ; $2B4FAA
        BTST    D0,-$05F0(A0)                   ; $2B4FB0
        BCLR    D0,(A2)+                        ; $2B4FB4
        ORI.W  #$F9B7,D4                        ; $2B4FB6
        BCHG    D0,(A6)+                        ; $2B4FBA
        DC.W    $FFC1               ; $2B4FBC MOVE.W  D1,<EA:3F>
        MOVE.W  -$0F(A7,A7.L),-(A4)             ; $2B4FBE
        DC.W    $010D               ; $2B4FC2 BTST    D0,A5
        MOVE.W  $019E(A0),$0028(A4)             ; $2B4FC4
        MOVE.W  A3,-(A5)                        ; $2B4FCA
loc_2B4FCC:
        DC.W    $FFE9,$01C6         ; $2B4FCC MOVE.W  $01C6(A1),<EA:3F>
        MOVE.W  $57(A0,D0.W),(A5)+              ; $2B4FD0
        BCLR    D0,-$69(A5,A7.L)                ; $2B4FD4
        DC.W    $FFE8,$00F5         ; $2B4FD8 MOVE.W  $00F5(A0),<EA:3F>
        MOVE.W  $79(A2,A7.L),$07(A4,D0.W)       ; $2B4FDC
        MOVE.W  (A3),(A5)+                      ; $2B4FE2
        DC.W    $0016,$0210         ; $2B4FE4 ORI.B  #$0210,(A6)
        MOVE.W  -$005A(PC),$0150(A4)            ; $2B4FE8
        MOVEA.W -$0095(A7),A5                   ; $2B4FEE
        DC.W    $021F,$FAA0         ; $2B4FF2 ANDI.B  #$FAA0,(A7)+
        MOVE.W  A1,$021F(A7)                    ; $2B4FF6
        MOVE.W  $0025.W,-(A5)                   ; $2B4FFA
        BCLR    D0,$FAEB.W                      ; $2B4FFE
        ORI.W  #$01B8,(A2)+                     ; $2B5002
        MOVE.W  (A1),D5                         ; $2B5006
        DC.W    $01CC               ; $2B5008 BSET    D0,A4
        DC.W    $001F,$FA3D         ; $2B500A ORI.B  #$FA3D,(A7)+
        DC.W    $0149               ; $2B500E BCHG    D0,A1
        DC.W    $FFBD,$F865         ; $2B5010 MOVE.W  <EA:3D>,$65(A7,A7.L)
        DC.W    $00ED               ; $2B5014 DC.W    $00ED
        MOVE.W  -(A4),-$07C7(A7)                ; $2B5016
        BCHG    D0,-$39(A0,A7.L)                ; $2B501A
        MOVE.W  -(A5),D5                        ; $2B501E
        BSET    D0,-$006C(A4)                   ; $2B5020
        MOVEA.W A5,A4                           ; $2B5024
        BCLR    D0,(A0)                         ; $2B5026
        MOVE.W  $00(PC,A7.L),-(A7)              ; $2B5028
        DC.W    $00D8               ; $2B502C DC.W    $00D8
        MOVE.W  D6,$3F(A7,A7.L)                 ; $2B502E
        BTST    D0,$6F(A7,A7.L)                 ; $2B5032
        MOVE.W  (A6),$57(A4,D0.W)               ; $2B5036
        MOVE.W  -$06A7(A5),-$0007(A7)           ; $2B503A
        MOVE.W  D4,$0F(A7,A7.L)                 ; $2B5040
        DC.W    $00EF               ; $2B5044 DC.W    $00EF
        MOVE.W  -(A2),-(A7)                     ; $2B5046
        MOVE.W  -(A7),$000F(A4)                 ; $2B5048
        MOVE.W  -(A0),-(A7)                     ; $2B504C
        MOVE.W  (A3),(A4)                       ; $2B504E
        DC.W    $FFE2               ; $2B5050 MOVE.W  -(A2),<EA:3F>
        MOVE.W  D4,-$075A(A7)                   ; $2B5052
        MOVE.W  -$00CA(A4),-$4A(A7,A7.L)        ; $2B5056
        DC.W    $0003,$FF53         ; $2B505C ORI.B  #$FF53,D3
loc_2B5060:
        MOVE.W  (A7),$58(A4,D0.W)               ; $2B5060
        MOVE.W  $0010(A2),$6E00(A7)             ; $2B5064
        DC.W    $0000,$0010         ; $2B506A ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2B506E ORI.B  #$0030,-(A0)
        ADDI.B  #$6F00,(A0)                     ; $2B5072
        ORI.W  #$0050,D0                        ; $2B5076
        SUBI.B  #$7000,(A0)                     ; $2B507A
        ORI.W  #$0070,-(A0)                     ; $2B507E
        SUBI.B  #$6F00,(A0)                     ; $2B5082
        DC.W    $0000,$0030         ; $2B5086 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2B508A ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2B508E ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2B5092 ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2B5096
        DC.W    $00B0,$0210,$0400,$00D0; $2B509C ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2B50A4 DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2B50A6
        ORI.L  #$00900611,-(A0)                 ; $2B50AA
        BTST    D3,D1                           ; $2B50B0
        DC.W    $00B0,$0010,$6A00,$00E0; $2B50B2 ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2B50BA DC.W    $00F0
        BTST    D0,D0                           ; $2B50BC
        BTST    D0,(A0)                         ; $2B50BE
        DC.W    $0210,$6C00         ; $2B50C0 ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2B50C4
        SUBI.B  #$6B00,(A0)                     ; $2B50C8
        BTST    D0,D0                           ; $2B50CC
        DC.W    $00F0               ; $2B50CE DC.W    $00F0
        DC.W    $0211,$6901         ; $2B50D0 ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2B50D4 DC.W    $00E0
        DC.W    $0010,$6300         ; $2B50D6 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2B50DA
        BCHG    D0,(A0)                         ; $2B50DC
        BCHG    D0,-(A0)                        ; $2B50DE
        BCHG    D0,$10(A0,D0.W)                 ; $2B50E0
        BCS.W  loc_2B5276                       ; $2B50E4
        BCLR    D0,D0                           ; $2B50E8
        SUBI.B  #$6400,(A0)                     ; $2B50EA
        BCHG    D0,-(A0)                        ; $2B50EE
        BCHG    D0,(A0)                         ; $2B50F0
        ADDI.B  #$6201,(A1)                     ; $2B50F2
        BCHG    D0,$10(A0,D0.W)                 ; $2B50F6
        BPL.W  loc_2B52DC                       ; $2B50FA
        BSET    D0,$00(A0,D0.W)                 ; $2B50FE
        DC.W    $0210,$0210         ; $2B5102 ANDI.B  #$0210,(A0)
        BGE.W  loc_2B5338                       ; $2B5106
        DC.W    $0220,$0410         ; $2B510A ANDI.B  #$0410,-(A0)
        BMI.W  loc_2B5310                       ; $2B510E
        BSET    D0,$11(A0,D0.W)                 ; $2B5112
        BVS.S  loc_2B5119                       ; $2B5116
        DC.W    $0210,$0010         ; $2B5118 ANDI.B  #$0010,(A0)
        BLS.W  loc_2B535E                       ; $2B511C
        ANDI.W  #$0260,(A0)                     ; $2B5120
        ANDI.W  #$0210,$00(A0,D6.W)             ; $2B5124
        ANDI.L  #$02800410,(A0)                 ; $2B512A
        BCC.W  loc_2B5392                       ; $2B5130
        ANDI.W  #$0211,(A0)                     ; $2B5134
        BHI.S  loc_2B513B                       ; $2B5138
        ANDI.W  #$0010,D0                       ; $2B513A
        BNE.W  loc_2B53E0                       ; $2B513E
        DC.W    $02B0,$02C0,$02D0,$0610; $2B5142 ANDI.L  #$02C002D0,$10(A0,D0.W)
        BEQ.W  loc_2B542C                       ; $2B514A
        DC.W    $02F0               ; $2B514E DC.W    $02F0
        SUBI.B  #$6800,(A0)                     ; $2B5150
        BTST    D1,D0                           ; $2B5154
        BTST    D1,(A0)                         ; $2B5156
        SUBI.B  #$6700,(A0)                     ; $2B5158
        ANDI.L  #$02D00010,-(A0)                ; $2B515C
        BTST    D1,D0                           ; $2B5162
        BTST    D1,-(A0)                        ; $2B5164
        BTST    D1,$40(A0,D0.W)                 ; $2B5166
        BCHG    D1,(A0)                         ; $2B516A
        DC.W    $0210,$0500         ; $2B516C ANDI.B  #$0500,(A0)
        BCHG    D1,$60(A0,D0.W)                 ; $2B5170
        SUBI.B  #$0400,(A0)                     ; $2B5174
        BCHG    D1,D0                           ; $2B5178
        BTST    D1,$10(A0,D0.W)                 ; $2B517A
        BCS.W  loc_2B5500                       ; $2B517E
        BCLR    D1,(A0)                         ; $2B5182
        BCLR    D1,-(A0)                        ; $2B5184
        BCLR    D1,$10(A0,D0.W)                 ; $2B5186
        BLS.W  loc_2B555C                       ; $2B518A
        BSET    D1,D0                           ; $2B518E
        SUBI.B  #$6400,(A0)                     ; $2B5190
        BCLR    D1,-(A0)                        ; $2B5194
        BCLR    D1,(A0)                         ; $2B5196
        DC.W    $0010,$0300         ; $2B5198 ORI.B  #$0300,(A0)
        SUBI.B  #$0430,-(A0)                    ; $2B519C
        SUBI.W  #$0450,D0                       ; $2B51A0
        DC.W    $0210,$0500         ; $2B51A4 ANDI.B  #$0500,(A0)
        SUBI.W  #$0460,$10(A0,D0.W)             ; $2B51A8
        SUBI.B  #$0440,D0                       ; $2B51AE
        SUBI.B  #$0010,$00(A0,D6.W)             ; $2B51B2
        SUBI.L  #$049004A0,D0                   ; $2B51B8
        DC.W    $04B0,$0210,$6300,$04D0; $2B51BE SUBI.L  #$02106300,-$30(A0,D0.W)
        DC.W    $04C0               ; $2B51C6 DC.W    $04C0
        SUBI.B  #$6400,(A0)                     ; $2B51C8
        SUBI.L  #$04900000,-(A0)                ; $2B51CC
        BVS.W  loc_2B5374                       ; $2B51D2
        BCLR    D0,-$40(A0,D0.W)                ; $2B51D6
        BSET    D0,(A0)                         ; $2B51DA
loc_2B51DC:
        DC.W    $0000,$6600         ; $2B51DC ORI.B  #$6600,D0
        BSET    D1,-(A0)                        ; $2B51E0
        BSET    D1,$00(A0,D0.W)                 ; $2B51E2
        SUBI.B  #$0000,(A0)                     ; $2B51E6
        BNE.W  loc_2B56CC                       ; $2B51EA
        DC.W    $04F0               ; $2B51EE DC.W    $04F0
        BTST    D2,D0                           ; $2B51F0
        BTST    D2,(A0)                         ; $2B51F2
        CMPI.B  #$0052,D0                       ; $2B51F4
        ORI.W  #$F8FC,(A2)                      ; $2B51F8
        DC.W    $020F,$008C         ; $2B51FC ANDI.B  #$008C,A7
        MOVE.W  $29(A7,D0.W),(A4)+              ; $2B5200
        MOVE.W  -$0828(A6),$0328(A7)            ; $2B5204
        MOVE.W  -$0821(A6),$030A(A7)            ; $2B520A
        DC.W    $00C5               ; $2B5210 DC.W    $00C5
        MOVE.W  D4,-$4A(A4,D0.W)                ; $2B5212
        MOVE.W  -$7B(A7,A7.L),$03D6(A7)         ; $2B5216
        MOVE.W  -$0677(PC),$029C(A7)            ; $2B521C
        ORI.L  #$F88C03B6,(A6)                  ; $2B5222
        DC.W    $00D1               ; $2B5228 DC.W    $00D1
        MOVEA.W (A5)+,A4                        ; $2B522A
        BCLR    D1,-$7D(A5,D0.W)                ; $2B522C
        MOVE.W  $0332(A4),$1F(PC,D0.W)          ; $2B5230
        MOVE.W  -$19(A5,D0.W),-(A3)             ; $2B5236
        DC.W    $0034,$F7CA,$0445   ; $2B523A ORI.B  #$F7CA,$45(A4,D0.W)
        ORI.L  #$F85903C5,(A3)                  ; $2B5240
        DC.W    $FFD2               ; $2B5246 MOVE.W  (A2),<EA:3F>
        MOVE.W  D7,$56(PC,D0.W)                 ; $2B5248
        DC.W    $FFE3               ; $2B524C MOVE.W  -(A3),<EA:3F>
        MOVE.W  -(A0),D4                        ; $2B524E
        DC.W    $034F               ; $2B5250 BCHG    D1,A7
        DC.W    $00CF               ; $2B5252 DC.W    $00CF
        MOVEA.W (A7)+,A4                        ; $2B5254
        BTST    D1,$2C(A2,D0.W)                 ; $2B5256
        MOVE.W  A5,$0242(A4)                    ; $2B525A
        DC.W    $00BC,$F924,$024A,$0054,$F872; $2B525E ORI.L  #$F924024A,#$0054F872
        BCLR    D1,(A2)                         ; $2B5268
        DC.W    $00EF               ; $2B526A DC.W    $00EF
        MOVE.W  -$73(A7,D0.W),$0074(A4)         ; $2B526C
        MOVE.W  -(A7),$02DB(A4)                 ; $2B5272
loc_2B5276:
        DC.W    $00AB,$F97B,$029B,$00DC; $2B5276 ORI.L  #$F97B029B,$00DC(A3)
        MOVEA.W (A1),A4                         ; $2B527E
        DC.W    $0203,$0093         ; $2B5280 ANDI.B  #$0093,D3
        MOVE.W  $20(PC,D0.W),$51(PC,D0.W)       ; $2B5284
        MOVE.W  (A0),-$68(A4,D0.W)              ; $2B528A
        ORI.L  #$F82501DF,A4                    ; $2B528E
        DC.W    $0033,$F915,$01CE   ; $2B5294 ORI.B  #$F915,-$32(A3,D0.W)
        DC.W    $0021,$F6EC         ; $2B529A ORI.B  #$F6EC,-(A1)
        DC.W    $0223,$0048         ; $2B529E ANDI.B  #$0048,-(A3)
        DC.W    $F7FD,$0153         ; $2B52A2 MOVE.W  <EA:3D>,$53(PC,D0.W)
        DC.W    $FFE7               ; $2B52A6 MOVE.W  -(A7),<EA:3F>
        MOVE.W  #$0116,-(A4)                    ; $2B52A8
        DC.W    $FFCB               ; $2B52AC MOVE.W  A3,<EA:3F>
        MOVEA.W A0,A4                           ; $2B52AE
        DC.W    $0224,$FF3D         ; $2B52B0 ANDI.B  #$FF3D,-(A4)
        DC.W    $F87F               ; $2B52B4 MOVEA.W <EA:3F>,A4
        DC.W    $0236,$FEDF,$F85D   ; $2B52B6 ANDI.B  #$FEDF,$5D(A6,A7.L)
        BCLR    D1,(A5)                         ; $2B52BC
        MOVE.W  A1,-(A7)                        ; $2B52BE
        MOVE.W  -(A2),D4                        ; $2B52C0
        BCLR    D1,-(A4)                        ; $2B52C2
        MOVE.W  -$0749(A4),$0230(A7)            ; $2B52C4
        DC.W    $FF3F               ; $2B52CA MOVE.W  <EA:3F>,-(A7)
        MOVE.W  (A0),(A4)                       ; $2B52CC
        BCLR    D1,-$0093(A7)                   ; $2B52CE
        MOVE.W  $0274(A7),-(A3)                 ; $2B52D2
        MOVE.W  $7B(A6,A7.W),-(A7)              ; $2B52D6
        ANDI.W  #$FEEB,(A0)+                    ; $2B52DA
        MOVE.W  (A1),(A4)+                      ; $2B52DE
        ANDI.W  #$FEEE,-$0731(A2)               ; $2B52E0
        ANDI.L  #$FF3AF734,A3                   ; $2B52E6
        DC.W    $0221,$FF2D         ; $2B52EC ANDI.B  #$FF2D,-(A1)
        MOVE.W  (A4),(A4)+                      ; $2B52F0
        DC.W    $0238,$FF30,$F985   ; $2B52F2 ANDI.B  #$FF30,$F985.W
        DC.W    $00E9               ; $2B52F8 DC.W    $00E9
        DC.W    $00AE,$F999,$00EE,$FF4E; $2B52FA ORI.L  #$F99900EE,-$00B2(A6)
        MOVE.W  $52(A2,D0.W),(A4)+              ; $2B5302
        MOVE.W  -$071F(A1),$024F(A7)            ; $2B5306
        ORI.L  #$FA41013C,A1                    ; $2B530C
        MOVE.W  (A1)+,-$0666(A7)                ; $2B5312
        ANDI.L  #$FF73FA2D,-(A0)                ; $2B5316
        BTST    D0,-$47(A7,D0.W)                ; $2B531C
        MOVE.W  A1,-$63(A4,D0.W)                ; $2B5320
        ORI.L  #$F988FFB0,(A4)                  ; $2B5324
        ORI.L  #$F9E1FFEC,-(A5)                 ; $2B532A
        BTST    D0,-$05F0(A1)                   ; $2B5330
        BCLR    D0,(A1)+                        ; $2B5334
        ORI.W  #$F9B7,D5                        ; $2B5336
        BCHG    D0,(A5)+                        ; $2B533A
        DC.W    $FFC2               ; $2B533C MOVE.W  D2,<EA:3F>
        MOVE.W  $FFF0010E,-(A4)                 ; $2B533E
        MOVE.W  $019D(A0),$0029(A4)             ; $2B5344
        MOVE.W  A5,-(A5)                        ; $2B534A
loc_2B534C:
        DC.W    $FFEA,$01C5         ; $2B534C MOVE.W  $01C5(A2),<EA:3F>
        MOVE.W  $58(A1,D0.W),(A5)+              ; $2B5350
        BCLR    D0,-$67(A5,A7.L)                ; $2B5354
        DC.W    $FFE7               ; $2B5358 MOVE.W  -(A7),<EA:3F>
        DC.W    $00F6               ; $2B535A DC.W    $00F6
        MOVE.W  $78(A4,A7.L),$07(A4,D0.W)       ; $2B535C
        MOVE.W  (A5),(A5)+                      ; $2B5362
        DC.W    $0016,$020F         ; $2B5364 ORI.B  #$020F,(A6)
        MOVE.W  #$FFA5,$0150(A4)                ; $2B5368
        MOVEA.W $69(A4,A7.L),A5                 ; $2B536E
        DC.W    $021E,$FAA6         ; $2B5372 ANDI.B  #$FAA6,(A6)+
        MOVE.W  A0,$021E(A7)                    ; $2B5376
        MOVE.W  $0026(PC),-(A5)                 ; $2B537A
        BCLR    D0,-$14(A7,A7.L)                ; $2B537E
        ORI.W  #$01B7,(A2)+                     ; $2B5382
        MOVE.W  (A2),D5                         ; $2B5386
        DC.W    $01CA               ; $2B5388 BSET    D0,A2
        DC.W    $0020,$FA3E         ; $2B538A ORI.B  #$FA3E,-(A0)
        DC.W    $0148               ; $2B538E BCHG    D0,A0
        DC.W    $FFBE,$F865         ; $2B5390 MOVE.W  <EA:3E>,$65(A7,A7.L)
        DC.W    $00ED               ; $2B5394 DC.W    $00ED
        MOVE.W  -(A4),-$07C7(A7)                ; $2B5396
        BCHG    D0,-$0039(A7)                   ; $2B539A
        MOVE.W  -(A5),D5                        ; $2B539E
        BSET    D0,-$006B(A3)                   ; $2B53A0
        MOVEA.W A5,A4                           ; $2B53A4
        BCLR    D0,(A1)                         ; $2B53A6
        MOVE.W  #$F802,-(A7)                    ; $2B53A8
        DC.W    $00D8               ; $2B53AC DC.W    $00D8
        MOVE.W  D6,$3F(A7,A7.L)                 ; $2B53AE
        BTST    D0,$70(A7,A7.L)                 ; $2B53B2
        MOVE.W  (A6),$57(A4,D0.W)               ; $2B53B6
        MOVE.W  -$06A7(A5),-$0007(A7)           ; $2B53BA
        MOVE.W  D4,$10(A7,A7.L)                 ; $2B53C0
        DC.W    $00EF               ; $2B53C4 DC.W    $00EF
        MOVE.W  -(A2),-(A7)                     ; $2B53C6
        MOVE.W  -(A7),$0010(A4)                 ; $2B53C8
        MOVE.W  -(A0),-(A7)                     ; $2B53CC
        MOVE.W  (A3),(A4)                       ; $2B53CE
        DC.W    $FFE2               ; $2B53D0 MOVE.W  -(A2),<EA:3F>
        MOVE.W  D4,-$075A(A7)                   ; $2B53D2
        MOVE.W  -$00CA(A4),-$4A(A7,A7.L)        ; $2B53D6
        DC.W    $0003,$FF53         ; $2B53DC ORI.B  #$FF53,D3
loc_2B53E0:
        MOVE.W  (A7),$58(A4,D0.W)               ; $2B53E0
        MOVE.W  $0010(A2),$6E00(A7)             ; $2B53E4
        DC.W    $0000,$0010         ; $2B53EA ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2B53EE ORI.B  #$0030,-(A0)
        ADDI.B  #$6F00,(A0)                     ; $2B53F2
        ORI.W  #$0050,D0                        ; $2B53F6
        SUBI.B  #$7000,(A0)                     ; $2B53FA
        ORI.W  #$0070,-(A0)                     ; $2B53FE
        SUBI.B  #$6F00,(A0)                     ; $2B5402
        DC.W    $0000,$0030         ; $2B5406 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2B540A ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2B540E ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2B5412 ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2B5416
        DC.W    $00B0,$0210,$0400,$00D0; $2B541C ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2B5424 DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2B5426
        ORI.L  #$00900611,-(A0)                 ; $2B542A
        BTST    D3,D1                           ; $2B5430
        DC.W    $00B0,$0010,$6A00,$00E0; $2B5432 ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2B543A DC.W    $00F0
        BTST    D0,D0                           ; $2B543C
        BTST    D0,(A0)                         ; $2B543E
        DC.W    $0210,$6C00         ; $2B5440 ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2B5444
        SUBI.B  #$6B00,(A0)                     ; $2B5448
        BTST    D0,D0                           ; $2B544C
        DC.W    $00F0               ; $2B544E DC.W    $00F0
        DC.W    $0211,$6901         ; $2B5450 ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2B5454 DC.W    $00E0
        DC.W    $0010,$6300         ; $2B5456 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2B545A
        BCHG    D0,(A0)                         ; $2B545C
        BCHG    D0,-(A0)                        ; $2B545E
        BCHG    D0,$10(A0,D0.W)                 ; $2B5460
        BCS.W  loc_2B55F6                       ; $2B5464
        BCLR    D0,D0                           ; $2B5468
        SUBI.B  #$6400,(A0)                     ; $2B546A
        BCHG    D0,-(A0)                        ; $2B546E
        BCHG    D0,(A0)                         ; $2B5470
        ADDI.B  #$6201,(A1)                     ; $2B5472
        BCHG    D0,$10(A0,D0.W)                 ; $2B5476
        BPL.W  loc_2B565C                       ; $2B547A
        BSET    D0,$00(A0,D0.W)                 ; $2B547E
        DC.W    $0210,$0210         ; $2B5482 ANDI.B  #$0210,(A0)
        BGE.W  loc_2B56B8                       ; $2B5486
        DC.W    $0220,$0410         ; $2B548A ANDI.B  #$0410,-(A0)
        BMI.W  loc_2B5690                       ; $2B548E
        BSET    D0,$11(A0,D0.W)                 ; $2B5492
        BVS.S  loc_2B5499                       ; $2B5496
        DC.W    $0210,$0010         ; $2B5498 ANDI.B  #$0010,(A0)
        BLS.W  loc_2B56DE                       ; $2B549C
        ANDI.W  #$0260,(A0)                     ; $2B54A0
        ANDI.W  #$0210,$00(A0,D6.W)             ; $2B54A4
        ANDI.L  #$02800410,(A0)                 ; $2B54AA
        BCC.W  loc_2B5712                       ; $2B54B0
        ANDI.W  #$0211,(A0)                     ; $2B54B4
        BHI.S  loc_2B54BB                       ; $2B54B8
        ANDI.W  #$0010,D0                       ; $2B54BA
        BNE.W  loc_2B5760                       ; $2B54BE
        DC.W    $02B0,$02C0,$02D0,$0610; $2B54C2 ANDI.L  #$02C002D0,$10(A0,D0.W)
        BEQ.W  loc_2B57AC                       ; $2B54CA
        DC.W    $02F0               ; $2B54CE DC.W    $02F0
        SUBI.B  #$6800,(A0)                     ; $2B54D0
        BTST    D1,D0                           ; $2B54D4
        BTST    D1,(A0)                         ; $2B54D6
        SUBI.B  #$6700,(A0)                     ; $2B54D8
        ANDI.L  #$02D00010,-(A0)                ; $2B54DC
        BTST    D1,D0                           ; $2B54E2
        BTST    D1,-(A0)                        ; $2B54E4
        BTST    D1,$40(A0,D0.W)                 ; $2B54E6
        BCHG    D1,(A0)                         ; $2B54EA
        DC.W    $0210,$0500         ; $2B54EC ANDI.B  #$0500,(A0)
        BCHG    D1,$60(A0,D0.W)                 ; $2B54F0
        SUBI.B  #$0400,(A0)                     ; $2B54F4
        BCHG    D1,D0                           ; $2B54F8
        BTST    D1,$10(A0,D0.W)                 ; $2B54FA
        BCS.W  loc_2B5880                       ; $2B54FE
        BCLR    D1,(A0)                         ; $2B5502
        BCLR    D1,-(A0)                        ; $2B5504
        BCLR    D1,$10(A0,D0.W)                 ; $2B5506
        BLS.W  loc_2B58DC                       ; $2B550A
        BSET    D1,D0                           ; $2B550E
        SUBI.B  #$6400,(A0)                     ; $2B5510
        BCLR    D1,-(A0)                        ; $2B5514
        BCLR    D1,(A0)                         ; $2B5516
        DC.W    $0010,$0300         ; $2B5518 ORI.B  #$0300,(A0)
        SUBI.B  #$0430,-(A0)                    ; $2B551C
        SUBI.W  #$0450,D0                       ; $2B5520
        DC.W    $0210,$0500         ; $2B5524 ANDI.B  #$0500,(A0)
        SUBI.W  #$0460,$10(A0,D0.W)             ; $2B5528
        SUBI.B  #$0440,D0                       ; $2B552E
        SUBI.B  #$0010,$00(A0,D6.W)             ; $2B5532
        SUBI.L  #$049004A0,D0                   ; $2B5538
        DC.W    $04B0,$0210,$6300,$04D0; $2B553E SUBI.L  #$02106300,-$30(A0,D0.W)
        DC.W    $04C0               ; $2B5546 DC.W    $04C0
        SUBI.B  #$6400,(A0)                     ; $2B5548
        SUBI.L  #$04900000,-(A0)                ; $2B554C
        BVS.W  loc_2B56F4                       ; $2B5552
        BCLR    D0,-$40(A0,D0.W)                ; $2B5556
        BSET    D0,(A0)                         ; $2B555A
loc_2B555C:
        DC.W    $0000,$6600         ; $2B555C ORI.B  #$6600,D0
        BSET    D1,-(A0)                        ; $2B5560
        BSET    D1,$00(A0,D0.W)                 ; $2B5562
        SUBI.B  #$0000,(A0)                     ; $2B5566
        BNE.W  loc_2B5A4C                       ; $2B556A
        DC.W    $04F0               ; $2B556E DC.W    $04F0
        BTST    D2,D0                           ; $2B5570
        BTST    D2,(A0)                         ; $2B5572
        CMPI.B  #$0052,D0                       ; $2B5574
        ORI.W  #$FA6F,(A2)                      ; $2B5578
        BCLR    D0,-(A7)                        ; $2B557C
        ORI.L  #$FA7A01AD,A3                    ; $2B557E
        MOVE.W  -$0647(A4),$02F6(A7)            ; $2B5584
        MOVE.W  A5,-$0654(A7)                   ; $2B558A
        DC.W    $02F0               ; $2B558E DC.W    $02F0
        ORI.L  #$FB2C0207,-(A5)                 ; $2B5590
        MOVE.W  -$6D(A4,A7.L),$0366(A7)         ; $2B5596
        MOVE.W  (A0)+,-$04E0(A7)                ; $2B559C
        DC.W    $0203,$0093         ; $2B55A0 ANDI.B  #$0093,D3
        MOVE.W  D6,(A5)                         ; $2B55A4
        BCHG    D1,-(A1)                        ; $2B55A6
        DC.W    $00B0,$FA5A,$0368,$005F; $2B55A8 ORI.L  #$FA5A0368,$5F(A0,D0.W)
        MOVE.W  A1,#$0306                       ; $2B55B0
        DC.W    $FFFF               ; $2B55B4 MOVE.W  <EA:3F>,<EA:3F>
        MOVE.W  (A2),$03EC(A4)                  ; $2B55B6
        DC.W    $FFFF               ; $2B55BA MOVE.W  <EA:3F>,<EA:3F>
        MOVE.W  $1F(PC,D0.W),#$005F             ; $2B55BC
        MOVEA.W -(A1),A5                        ; $2B55C2
        BCHG    D1,-$0051(A3)                   ; $2B55C4
        MOVE.W  D3,D5                           ; $2B55C8
        SUBI.B  #$FFAE,-(A2)                    ; $2B55CA
        MOVE.W  -$09(A2,D0.W),#$00B8            ; $2B55CE
        MOVE.W  -$04(A2,D0.W),D5                ; $2B55D4
        BTST    D0,(A0)+                        ; $2B55D8
        MOVE.W  -(A0),(A5)+                     ; $2B55DA
        BSET    D0,D6                           ; $2B55DC
        BTST    D0,-$0550(A3)                   ; $2B55DE
        BCLR    D0,-(A5)                        ; $2B55E2
        DC.W    $00CB               ; $2B55E4 DC.W    $00CB
        MOVEA.W (A2),A5                         ; $2B55E6
        BTST    D1,$00B5(A6)                    ; $2B55E8
        MOVE.W  (A1),-(A5)                      ; $2B55EC
        BSET    D0,(A4)+                        ; $2B55EE
        DC.W    $00C9               ; $2B55F0 DC.W    $00C9
        MOVE.W  D3,$022F(A5)                    ; $2B55F2
loc_2B55F6:
        DC.W    $00D4               ; $2B55F6 DC.W    $00D4
        MOVE.W  #$020A,-(A5)                    ; $2B55F8
        BTST    D0,(A6)+                        ; $2B55FC
        MOVE.W  $0242(A2),#$0119                ; $2B55FE
        MOVE.W  $0274(A0),-$31(A4,D0.W)         ; $2B5604
        MOVE.W  -$23(A6,D0.W),-(A5)             ; $2B560A
        DC.W    $00D9               ; $2B560E DC.W    $00D9
        MOVE.W  (A2)+,$21(A4,D0.W)              ; $2B5610
        DC.W    $00D3               ; $2B5614 DC.W    $00D3
        MOVEA.W D6,A5                           ; $2B5616
        BCHG    D0,$00D4.W                      ; $2B5618
        MOVE.W  (A4),(A4)+                      ; $2B561C
        BTST    D1,(A5)+                        ; $2B561E
        DC.W    $00BC,$F917,$01BF,$00CF,$F9E4; $2B5620 ORI.L  #$F91701BF,#$00CFF9E4
        DC.W    $00C3               ; $2B562A DC.W    $00C3
        DC.W    $00DF               ; $2B562C DC.W    $00DF
        MOVE.W  $040A(A6),$17(A4,A7.L)          ; $2B562E
        MOVE.W  (A2)+,-$30(A4,D0.W)             ; $2B5634
        MOVE.W  -$053D(PC),(A7)                 ; $2B5638
        BTST    D1,(A4)                         ; $2B563C
        MOVE.W  -$050E(A5),(A7)+                ; $2B563E
        BTST    D1,#$FF4F                       ; $2B5642
        MOVE.W  -$53(A2,D0.W),-$00E5(A4)        ; $2B5646
        MOVE.W  -$21(A7,D0.W),(A5)              ; $2B564C
        MOVE.W  (A3),-$05F5(A7)                 ; $2B5650
        BTST    D2,(A6)+                        ; $2B5654
        MOVE.W  -$22(A2,A7.L),(A7)+             ; $2B5656
        DC.W    $04D3               ; $2B565A DC.W    $04D3
loc_2B565C:
        MOVE.W  -$0659(A6),(A7)                 ; $2B565C
        BCLR    D1,D3                           ; $2B5660
        MOVE.W  A4,(A7)+                        ; $2B5662
        MOVE.W  A1,#$0385                       ; $2B5664
        MOVE.W  (A0)+,-(A7)                     ; $2B5668
        DC.W    $F9B9,$052B,$FEE8,$F976; $2B566A MOVE.W  $052BFEE8,$76(A4,A7.L)
        BCLR    D1,(A1)                         ; $2B5672
        MOVE.W  A6,-(A7)                        ; $2B5674
        MOVEA.W A0,A5                           ; $2B5676
        ORI.L  #$00AEFA5D,D2                    ; $2B5678
        ORI.W  #$FF4E,-$057C(PC)                ; $2B567E
        DC.W    $0203,$FF69         ; $2B5684 ANDI.B  #$FF69,D3
        MOVEA.W $09(A3,D0.W),A5                 ; $2B5688
        ORI.L  #$FB140067,A1                    ; $2B568C
        MOVE.W  (A1)+,-$04C4(A7)                ; $2B5692
        BSET    D0,-$008D(A7)                   ; $2B5696
        DC.W    $FAFF               ; $2B569A MOVE.W  <EA:3F>,(A5)+
        ORI.W  #$00B9,-$04D4(A6)                ; $2B569C
        BSET    D0,-$6C(A5,D0.W)                ; $2B56A2
        MOVE.W  $01E8(A6),-$54(A4,D0.W)         ; $2B56A6
        MOVE.W  D0,#$0188                       ; $2B56AC
        BTST    D0,-$01(A6,A7.L)                ; $2B56B0
        ORI.W  #$0046,-$0514(A4)                ; $2B56B4
        DC.W    $00CC               ; $2B56BA DC.W    $00CC
        DC.W    $FFBD,$FA16         ; $2B56BC MOVE.W  <EA:3D>,$16(A7,A7.L)
        DC.W    $0212,$0106         ; $2B56C0 ANDI.B  #$0106,(A2)
        MOVE.W  (A5),$00F6(A5)                  ; $2B56C4
        DC.W    $0016,$F960         ; $2B56C8 ORI.B  #$F960,(A6)
loc_2B56CC:
        ORI.W  #$01D7,-$0635(A3)                ; $2B56CC
        ORI.W  #$01B5,(A0)+                     ; $2B56D2
        MOVE.W  (A3),#$01C8                     ; $2B56D6
        BTST    D0,D1                           ; $2B56DA
        MOVE.W  -(A7),$01DC(A4)                 ; $2B56DC
        BTST    D0,-(A3)                        ; $2B56E0
        MOVE.W  $0089(A2),$17(A4,D0.W)          ; $2B56E2
        MOVE.W  -$07(A2,D0.W),$64(A4,D0.W)      ; $2B56E8
        MOVE.W  $44(A5,A7.L),$01B7(A4)          ; $2B56EE
loc_2B56F4:
        MOVE.W  -$00D2(A5),-$49(A4,D0.W)        ; $2B56F4
        MOVE.W  (A2)+,D5                        ; $2B56FA
        DC.W    $0035,$01B7,$F9C4   ; $2B56FC ORI.B  #$01B7,-$3C(A5,A7.L)
        ORI.W  #$01B7,(A1)+                     ; $2B5702
        MOVE.W  (A2)+,$00B9(A5)                 ; $2B5706
        DC.W    $001C,$FAEF         ; $2B570A ORI.B  #$FAEF,(A4)+
        ORI.W  #$FFBC,-(A0)                     ; $2B570E
loc_2B5712:
        MOVE.W  -(A0),#$01F1                    ; $2B5712
        MOVE.W  $4B(A5,A7.L),$024A(A7)          ; $2B5716
        DC.W    $FFD7               ; $2B571C MOVE.W  (A7),<EA:3F>
        MOVE.W  $00B7(PC),-$0070(A5)            ; $2B571E
        MOVEA.W $0248(A4),A5                    ; $2B5724
        MOVE.W  A1,-$064D(A7)                   ; $2B5728
        ANDI.W  #$FF9D,A7                       ; $2B572C
        MOVE.W  (A5)+,D5                        ; $2B5730
        DC.W    $022E,$FF82,$F99C   ; $2B5732 ANDI.B  #$FF82,-$0664(A6)
        DC.W    $00A9,$FF6D,$F932,$00CA; $2B5738 ORI.L  #$FF6DF932,$00CA(A1)
        MOVE.W  A0,-$37(A7,A7.L)                ; $2B5740
        ANDI.W  #$FF3A,A5                       ; $2B5744
        MOVE.W  A1,$00C8(A4)                    ; $2B5748
        MOVE.W  -(A4),-(A7)                     ; $2B574C
        MOVE.W  (A2),(A4)                       ; $2B574E
        DC.W    $003A,$FF68,$F8A4   ; $2B5750 ORI.B  #$FF68,-$075C(PC)
        DC.W    $0002,$FF68         ; $2B5756 ORI.B  #$FF68,D2
        MOVE.W  $5B(A5,D0.W),$68(A4,A7.L)       ; $2B575A
loc_2B5760:
        MOVE.W  (A7),-$4C(A4,D0.W)              ; $2B5760
        MOVE.W  $0010(A0),$6E00(A7)             ; $2B5764
        DC.W    $0000,$0010         ; $2B576A ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2B576E ORI.B  #$0030,-(A0)
        ADDI.B  #$6F00,(A0)                     ; $2B5772
        ORI.W  #$0050,D0                        ; $2B5776
        SUBI.B  #$7000,(A0)                     ; $2B577A
        ORI.W  #$0070,-(A0)                     ; $2B577E
        SUBI.B  #$6F00,(A0)                     ; $2B5782
        DC.W    $0000,$0030         ; $2B5786 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2B578A ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2B578E ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2B5792 ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2B5796
        DC.W    $00B0,$0210,$0400,$00D0; $2B579C ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2B57A4 DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2B57A6
        ORI.L  #$00900611,-(A0)                 ; $2B57AA
        BTST    D3,D1                           ; $2B57B0
        DC.W    $00B0,$0010,$6A00,$00E0; $2B57B2 ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2B57BA DC.W    $00F0
        BTST    D0,D0                           ; $2B57BC
        BTST    D0,(A0)                         ; $2B57BE
        DC.W    $0210,$6C00         ; $2B57C0 ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2B57C4
        SUBI.B  #$6B00,(A0)                     ; $2B57C8
        BTST    D0,D0                           ; $2B57CC
        DC.W    $00F0               ; $2B57CE DC.W    $00F0
        DC.W    $0211,$6901         ; $2B57D0 ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2B57D4 DC.W    $00E0
        DC.W    $0010,$6300         ; $2B57D6 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2B57DA
        BCHG    D0,(A0)                         ; $2B57DC
        BCHG    D0,-(A0)                        ; $2B57DE
        BCHG    D0,$10(A0,D0.W)                 ; $2B57E0
        BCS.W  loc_2B5976                       ; $2B57E4
        BCLR    D0,D0                           ; $2B57E8
        SUBI.B  #$6400,(A0)                     ; $2B57EA
        BCHG    D0,-(A0)                        ; $2B57EE
        BCHG    D0,(A0)                         ; $2B57F0
        ADDI.B  #$6201,(A1)                     ; $2B57F2
        BCHG    D0,$10(A0,D0.W)                 ; $2B57F6
        BPL.W  loc_2B59DC                       ; $2B57FA
        BSET    D0,$00(A0,D0.W)                 ; $2B57FE
        DC.W    $0210,$0210         ; $2B5802 ANDI.B  #$0210,(A0)
        BGE.W  loc_2B5A38                       ; $2B5806
        DC.W    $0220,$0410         ; $2B580A ANDI.B  #$0410,-(A0)
        BMI.W  loc_2B5A10                       ; $2B580E
        BSET    D0,$11(A0,D0.W)                 ; $2B5812
        BVS.S  loc_2B5819                       ; $2B5816
        DC.W    $0210,$0010         ; $2B5818 ANDI.B  #$0010,(A0)
        BLS.W  loc_2B5A5E                       ; $2B581C
        ANDI.W  #$0260,(A0)                     ; $2B5820
        ANDI.W  #$0210,$00(A0,D6.W)             ; $2B5824
        ANDI.L  #$02800410,(A0)                 ; $2B582A
        BCC.W  loc_2B5A92                       ; $2B5830
        ANDI.W  #$0211,(A0)                     ; $2B5834
        BHI.S  loc_2B583B                       ; $2B5838
        ANDI.W  #$0010,D0                       ; $2B583A
        BNE.W  loc_2B5AE0                       ; $2B583E
        DC.W    $02B0,$02C0,$02D0,$0610; $2B5842 ANDI.L  #$02C002D0,$10(A0,D0.W)
        BEQ.W  loc_2B5B2C                       ; $2B584A
        DC.W    $02F0               ; $2B584E DC.W    $02F0
        SUBI.B  #$6800,(A0)                     ; $2B5850
        BTST    D1,D0                           ; $2B5854
        BTST    D1,(A0)                         ; $2B5856
        SUBI.B  #$6700,(A0)                     ; $2B5858
        ANDI.L  #$02D00010,-(A0)                ; $2B585C
        BTST    D1,D0                           ; $2B5862
        BTST    D1,-(A0)                        ; $2B5864
        BTST    D1,$40(A0,D0.W)                 ; $2B5866
        BCHG    D1,(A0)                         ; $2B586A
        DC.W    $0210,$0500         ; $2B586C ANDI.B  #$0500,(A0)
        BCHG    D1,$60(A0,D0.W)                 ; $2B5870
        SUBI.B  #$0400,(A0)                     ; $2B5874
        BCHG    D1,D0                           ; $2B5878
        BTST    D1,$10(A0,D0.W)                 ; $2B587A
        BCS.W  loc_2B5C00                       ; $2B587E
        BCLR    D1,(A0)                         ; $2B5882
        BCLR    D1,-(A0)                        ; $2B5884
        BCLR    D1,$10(A0,D0.W)                 ; $2B5886
        BLS.W  loc_2B5C5C                       ; $2B588A
        BSET    D1,D0                           ; $2B588E
        SUBI.B  #$6400,(A0)                     ; $2B5890
        BCLR    D1,-(A0)                        ; $2B5894
        BCLR    D1,(A0)                         ; $2B5896
        DC.W    $0010,$0300         ; $2B5898 ORI.B  #$0300,(A0)
        SUBI.B  #$0430,-(A0)                    ; $2B589C
        SUBI.W  #$0450,D0                       ; $2B58A0
        DC.W    $0210,$0500         ; $2B58A4 ANDI.B  #$0500,(A0)
        SUBI.W  #$0460,$10(A0,D0.W)             ; $2B58A8
        SUBI.B  #$0440,D0                       ; $2B58AE
        SUBI.B  #$0010,$00(A0,D6.W)             ; $2B58B2
        SUBI.L  #$049004A0,D0                   ; $2B58B8
        DC.W    $04B0,$0210,$6300,$04D0; $2B58BE SUBI.L  #$02106300,-$30(A0,D0.W)
        DC.W    $04C0               ; $2B58C6 DC.W    $04C0
        SUBI.B  #$6400,(A0)                     ; $2B58C8
        SUBI.L  #$04900000,-(A0)                ; $2B58CC
        BVS.W  loc_2B5A74                       ; $2B58D2
        BCLR    D0,-$40(A0,D0.W)                ; $2B58D6
        BSET    D0,(A0)                         ; $2B58DA
loc_2B58DC:
        DC.W    $0000,$6600         ; $2B58DC ORI.B  #$6600,D0
        BSET    D1,-(A0)                        ; $2B58E0
        BSET    D1,$00(A0,D0.W)                 ; $2B58E2
        SUBI.B  #$0000,(A0)                     ; $2B58E6
        BNE.W  loc_2B5DCC                       ; $2B58EA
        DC.W    $04F0               ; $2B58EE DC.W    $04F0
        BTST    D2,D0                           ; $2B58F0
        BTST    D2,(A0)                         ; $2B58F2
        CMPI.B  #$0052,D0                       ; $2B58F4
        ORI.W  #$FBE1,(A2)                      ; $2B58F8
        BCHG    D0,(A2)+                        ; $2B58FC
        ORI.L  #$FBEC0158,A4                    ; $2B58FE
        MOVE.W  -$03EC(A4),$02D4(A7)            ; $2B5904
        MOVE.W  A6,-$03F9(A7)                   ; $2B590A
        DC.W    $02D7               ; $2B590E DC.W    $02D7
        ORI.L  #$FCB10138,-(A6)                 ; $2B5910
        MOVE.W  $06(A4,A7.L),$02AD(A7)          ; $2B5916
        MOVE.W  (A0)+,-$035B(A7)                ; $2B591C
        BTST    D0,$0093(PC)                    ; $2B5920
        MOVE.W  $02B0.W,(A6)+                   ; $2B5924
        DC.W    $00B0,$FCDA,$02CF,$005F; $2B5928 ORI.L  #$FCDA02CF,$5F(A0,D0.W)
        MOVE.W  $02D7(A2),D6                    ; $2B5930
        DC.W    $0000,$FC54         ; $2B5934 ORI.B  #$FC54,D0
        BSET    D1,(A7)                         ; $2B5938
        DC.W    $0000,$FCFA         ; $2B593A ORI.B  #$FCFA,D0
        BCLR    D1,(A3)+                        ; $2B593E
        ORI.W  #$FCE1,(A7)+                     ; $2B5940
        DC.W    $02CE               ; $2B5944 DC.W    $02CE
        MOVE.W  -$02FE(A7),-$67(A7,D0.W)        ; $2B5946
        MOVE.W  -$03C9(A7),$30(A7,D0.W)         ; $2B594C
        DC.W    $00B5,$FC6C,$024D,$0117; $2B5952 ORI.L  #$FC6C024D,$17(A5,D0.W)
        MOVE.W  (A4),-$79(A6,D0.W)              ; $2B595A
        BTST    D0,-(A4)                        ; $2B595E
        MOVE.W  $0158.W,$00C3(A6)               ; $2B5960
        MOVEA.W -$74(A4,D0.W),A6                ; $2B5966
        DC.W    $00B7,$FDB7,$01B4,$00C5; $2B596A ORI.L  #$FDB701B4,-$3B(A7,D0.W)
        MOVE.W  -(A1),$10(A6,D0.W)              ; $2B5972
loc_2B5976:
        DC.W    $00D3               ; $2B5976 DC.W    $00D3
        MOVE.W  -$12(A6,D0.W),$1C(A6,D0.W)      ; $2B5978
        MOVE.W  (A7),(A6)                       ; $2B597E
        BTST    D0,$13(A2,D0.W)                 ; $2B5980
        MOVEA.W D4,A6                           ; $2B5984
        BTST    D0,$00C8(A4)                    ; $2B5986
        DC.W    $FDCF               ; $2B598A MOVE.W  A7,<EA:3E>
        DC.W    $01CA               ; $2B598C BSET    D0,A2
        DC.W    $00D6               ; $2B598E DC.W    $00D6
        MOVEA.W -$1A(A2,D0.W),A6                ; $2B5990
        DC.W    $00CA               ; $2B5994 DC.W    $00CA
        MOVE.W  -(A4),$00DF(A6)                 ; $2B5996
        DC.W    $00CA               ; $2B599A DC.W    $00CA
        MOVE.W  $18(A6,D0.W),-(A5)              ; $2B599C
        DC.W    $00B5,$FC55,$0044,$00C1; $2B59A0 ORI.L  #$FC550044,-$3F(A5,D0.W)
        MOVE.W  (A7),$16(A6,D0.W)               ; $2B59A8
        DC.W    $00CE               ; $2B59AC DC.W    $00CE
        MOVE.W  D7,(A6)                         ; $2B59AE
        BCLR    D1,$23(A4,A7.L)                 ; $2B59B0
        MOVEA.W (A0)+,A6                        ; $2B59B4
        DC.W    $038F               ; $2B59B6 BCLR    D1,A7
        MOVE.W  D6,(A7)+                        ; $2B59B8
        DC.W    $FCFD               ; $2B59BA MOVE.W  <EA:3D>,(A6)+
        ANDI.W  #$FEEC,(A6)                     ; $2B59BC
        MOVE.W  #$025F,-(A6)                    ; $2B59C0
        MOVE.W  A4,-$03DB(A7)                   ; $2B59C4
        BCLR    D1,D1                           ; $2B59C8
        MOVE.W  -(A7),-(A7)                     ; $2B59CA
        MOVE.W  (A2)+,(A6)+                     ; $2B59CC
        DC.W    $022C,$FF51,$FDA8   ; $2B59CE ANDI.B  #$FF51,-$0258(A4)
        BSET    D1,(A1)+                        ; $2B59D4
        MOVE.W  (A3),-(A7)                      ; $2B59D6
        MOVE.W  (A4),$03D4(A6)                  ; $2B59D8
loc_2B59DC:
        MOVE.W  A2,(A7)+                        ; $2B59DC
        MOVE.W  -(A0),D6                        ; $2B59DE
        DC.W    $033F               ; $2B59E0 BTST    D1,<EA:3F>
        MOVE.W  (A0)+,(A7)+                     ; $2B59E2
        MOVE.W  $22(A2,D0.W),D6                 ; $2B59E4
        MOVE.W  -(A2),-(A7)                     ; $2B59E8
        MOVE.W  D4,$23(A6,D0.W)                 ; $2B59EA
        MOVE.W  A2,-(A7)                        ; $2B59EE
        MOVE.W  A5,D6                           ; $2B59F0
        BCHG    D1,-$00E7(A5)                   ; $2B59F2
        MOVE.W  A1,-(A5)                        ; $2B59F6
        ORI.L  #$00AEFB14,(A5)+                 ; $2B59F8
        ORI.L  #$FF4EFC30,A3                    ; $2B59FE
        BCLR    D0,(A5)+                        ; $2B5A04
        MOVE.W  -$03DA(A1),$01AD(A7)            ; $2B5A06
        ORI.L  #$FB940006,A1                    ; $2B5A0C
        MOVE.W  (A1)+,-$0350(A7)                ; $2B5A12
        BTST    D0,(A0)+                        ; $2B5A16
        MOVE.W  -$76(A3,A7.L),$0018(A7)         ; $2B5A18
        DC.W    $00B9,$FCA6,$0127,$0094,$FB6F; $2B5A1E ORI.L  #$FCA60127,$0094FB6F
        DC.W    $0210,$00B5         ; $2B5A28 ANDI.B  #$00B5,(A0)
        MOVE.W  D0,-(A5)                        ; $2B5A2C
        BCLR    D0,$0114(PC)                    ; $2B5A2E
        MOVE.W  A3,$19(A5,D0.W)                 ; $2B5A32
        DC.W    $003C,$FBFA,$006F   ; $2B5A36 ORI.B  #$FBFA,#$006F
        DC.W    $FFDE               ; $2B5A3C MOVE.W  (A6)+,<EA:3F>
        MOVE.W  -(A3),-$20(A5,D0.W)             ; $2B5A3E
        BTST    D0,$2E(A3,A7.L)                 ; $2B5A42
        DC.W    $003F,$005C         ; $2B5A46 ORI.B  #$005C,<EA:3F>
        DC.W    $F9FE,$0279         ; $2B5A4A MOVE.W  <EA:3E>,#$0279
        DC.W    $018B               ; $2B5A4E BCLR    D0,A3
        MOVE.W  $020A(A4),#$01A2                ; $2B5A50
        MOVE.W  A6,$01A7(A5)                    ; $2B5A56
        DC.W    $00ED               ; $2B5A5A DC.W    $00ED
        MOVE.W  -(A1),$0216(A5)                 ; $2B5A5C
        DC.W    $00D4               ; $2B5A60 DC.W    $00D4
        MOVE.W  -(A3),D5                        ; $2B5A62
        ANDI.W  #$01E5,(A7)                     ; $2B5A64
        MOVE.W  D5,-$0C(A5,D0.W)                ; $2B5A68
        BTST    D0,-$0707(A7)                   ; $2B5A6C
        BCHG    D0,$01A4(A5)                    ; $2B5A70
loc_2B5A74:
        MOVE.W  (A6),-(A4)                      ; $2B5A74
        BTST    D0,$01A4FA13                    ; $2B5A76
        BSET    D0,D0                           ; $2B5A7C
        BCLR    D0,-(A4)                        ; $2B5A7E
        MOVE.W  -(A7),#$0212                    ; $2B5A80
        BCLR    D0,-(A4)                        ; $2B5A84
        MOVE.W  (A2)+,D6                        ; $2B5A86
        ORI.W  #$000F,-(A4)                     ; $2B5A88
        MOVE.W  -(A0),$0E(A5,D0.W)              ; $2B5A8C
        DC.W    $FFBF,$FAA4         ; $2B5A90 MOVE.W  <EA:3F>,-$5C(A7,A7.L)
        BCLR    D0,-$0083(A4)                   ; $2B5A94
        MOVE.W  (A6)+,-(A5)                     ; $2B5A98
        DC.W    $0203,$FFCE         ; $2B5A9A ANDI.B  #$FFCE,D3
        MOVE.W  $0058(A4),D6                    ; $2B5A9E
        MOVE.W  D0,$30(A7,A7.L)                 ; $2B5AA2
        BSET    D0,$3F(A6,A7.L)                 ; $2B5AA6
        MOVE.W  A0,(A5)+                        ; $2B5AAA
        DC.W    $0223,$FFAD         ; $2B5AAC ANDI.B  #$FFAD,-(A3)
        DC.W    $FAFF               ; $2B5AB0 MOVE.W  <EA:3F>,(A5)+
        BSET    D0,D6                           ; $2B5AB2
        MOVE.W  D7,-$67(A7,A7.L)                ; $2B5AB4
        DC.W    $00FE               ; $2B5AB8 DC.W    $00FE
        MOVE.W  -$069E(A4),$015D(A7)            ; $2B5ABA
        MOVE.W  (A1),-$2C(A7,A7.L)              ; $2B5AC0
        DC.W    $021B,$FF46         ; $2B5AC4 ANDI.B  #$FF46,(A3)+
        MOVE.W  $0154(A7),-$00D4(A4)            ; $2B5AC8
        MOVE.W  (A2),(A4)                       ; $2B5ACE
        ORI.L  #$FF68F8A4,(A6)                  ; $2B5AD0
        ORI.W  #$FF68,(A6)+                     ; $2B5AD6
        MOVE.W  -$49(A5,D0.W),$68(A4,A7.L)      ; $2B5ADA
loc_2B5AE0:
        MOVE.W  (A7),$0F(A4,D0.W)               ; $2B5AE0
        MOVE.W  $0010(A0),$6E00(A7)             ; $2B5AE4
        DC.W    $0000,$0010         ; $2B5AEA ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2B5AEE ORI.B  #$0030,-(A0)
        ADDI.B  #$6F00,(A0)                     ; $2B5AF2
        ORI.W  #$0050,D0                        ; $2B5AF6
        SUBI.B  #$7000,(A0)                     ; $2B5AFA
        ORI.W  #$0070,-(A0)                     ; $2B5AFE
        SUBI.B  #$6F00,(A0)                     ; $2B5B02
        DC.W    $0000,$0030         ; $2B5B06 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2B5B0A ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2B5B0E ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2B5B12 ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2B5B16
        DC.W    $00B0,$0210,$0400,$00D0; $2B5B1C ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2B5B24 DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2B5B26
        ORI.L  #$00900611,-(A0)                 ; $2B5B2A
        BTST    D3,D1                           ; $2B5B30
        DC.W    $00B0,$0010,$6A00,$00E0; $2B5B32 ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2B5B3A DC.W    $00F0
        BTST    D0,D0                           ; $2B5B3C
        BTST    D0,(A0)                         ; $2B5B3E
        DC.W    $0210,$6C00         ; $2B5B40 ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2B5B44
        SUBI.B  #$6B00,(A0)                     ; $2B5B48
        BTST    D0,D0                           ; $2B5B4C
        DC.W    $00F0               ; $2B5B4E DC.W    $00F0
        DC.W    $0211,$6901         ; $2B5B50 ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2B5B54 DC.W    $00E0
        DC.W    $0010,$6300         ; $2B5B56 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2B5B5A
        BCHG    D0,(A0)                         ; $2B5B5C
        BCHG    D0,-(A0)                        ; $2B5B5E
        BCHG    D0,$10(A0,D0.W)                 ; $2B5B60
        BCS.W  loc_2B5CF6                       ; $2B5B64
        BCLR    D0,D0                           ; $2B5B68
        SUBI.B  #$6400,(A0)                     ; $2B5B6A
        BCHG    D0,-(A0)                        ; $2B5B6E
        BCHG    D0,(A0)                         ; $2B5B70
        ADDI.B  #$6201,(A1)                     ; $2B5B72
        BCHG    D0,$10(A0,D0.W)                 ; $2B5B76
        BPL.W  loc_2B5D5C                       ; $2B5B7A
        BSET    D0,$00(A0,D0.W)                 ; $2B5B7E
        DC.W    $0210,$0210         ; $2B5B82 ANDI.B  #$0210,(A0)
        BGE.W  loc_2B5DB8                       ; $2B5B86
        DC.W    $0220,$0410         ; $2B5B8A ANDI.B  #$0410,-(A0)
        BMI.W  loc_2B5D90                       ; $2B5B8E
        BSET    D0,$11(A0,D0.W)                 ; $2B5B92
        BVS.S  loc_2B5B99                       ; $2B5B96
        DC.W    $0210,$0010         ; $2B5B98 ANDI.B  #$0010,(A0)
        BLS.W  loc_2B5DDE                       ; $2B5B9C
        ANDI.W  #$0260,(A0)                     ; $2B5BA0
        ANDI.W  #$0210,$00(A0,D6.W)             ; $2B5BA4
        ANDI.L  #$02800410,(A0)                 ; $2B5BAA
        BCC.W  loc_2B5E12                       ; $2B5BB0
        ANDI.W  #$0211,(A0)                     ; $2B5BB4
        BHI.S  loc_2B5BBB                       ; $2B5BB8
        ANDI.W  #$0010,D0                       ; $2B5BBA
        BNE.W  loc_2B5E60                       ; $2B5BBE
        DC.W    $02B0,$02C0,$02D0,$0610; $2B5BC2 ANDI.L  #$02C002D0,$10(A0,D0.W)
        BEQ.W  loc_2B5EAC                       ; $2B5BCA
        DC.W    $02F0               ; $2B5BCE DC.W    $02F0
        SUBI.B  #$6800,(A0)                     ; $2B5BD0
        BTST    D1,D0                           ; $2B5BD4
        BTST    D1,(A0)                         ; $2B5BD6
        SUBI.B  #$6700,(A0)                     ; $2B5BD8
        ANDI.L  #$02D00010,-(A0)                ; $2B5BDC
        BTST    D1,D0                           ; $2B5BE2
        BTST    D1,-(A0)                        ; $2B5BE4
        BTST    D1,$40(A0,D0.W)                 ; $2B5BE6
        BCHG    D1,(A0)                         ; $2B5BEA
        DC.W    $0210,$0500         ; $2B5BEC ANDI.B  #$0500,(A0)
        BCHG    D1,$60(A0,D0.W)                 ; $2B5BF0
        SUBI.B  #$0400,(A0)                     ; $2B5BF4
        BCHG    D1,D0                           ; $2B5BF8
        BTST    D1,$10(A0,D0.W)                 ; $2B5BFA
        BCS.W  loc_2B5F80                       ; $2B5BFE
        BCLR    D1,(A0)                         ; $2B5C02
        BCLR    D1,-(A0)                        ; $2B5C04
        BCLR    D1,$10(A0,D0.W)                 ; $2B5C06
        BLS.W  loc_2B5FDC                       ; $2B5C0A
        BSET    D1,D0                           ; $2B5C0E
        SUBI.B  #$6400,(A0)                     ; $2B5C10
        BCLR    D1,-(A0)                        ; $2B5C14
        BCLR    D1,(A0)                         ; $2B5C16
        DC.W    $0010,$0300         ; $2B5C18 ORI.B  #$0300,(A0)
        SUBI.B  #$0430,-(A0)                    ; $2B5C1C
        SUBI.W  #$0450,D0                       ; $2B5C20
        DC.W    $0210,$0500         ; $2B5C24 ANDI.B  #$0500,(A0)
        SUBI.W  #$0460,$10(A0,D0.W)             ; $2B5C28
        SUBI.B  #$0440,D0                       ; $2B5C2E
        SUBI.B  #$0010,$00(A0,D6.W)             ; $2B5C32
        SUBI.L  #$049004A0,D0                   ; $2B5C38
        DC.W    $04B0,$0210,$6300,$04D0; $2B5C3E SUBI.L  #$02106300,-$30(A0,D0.W)
        DC.W    $04C0               ; $2B5C46 DC.W    $04C0
        SUBI.B  #$6400,(A0)                     ; $2B5C48
        SUBI.L  #$04900000,-(A0)                ; $2B5C4C
        BVS.W  loc_2B5DF4                       ; $2B5C52
        BCLR    D0,-$40(A0,D0.W)                ; $2B5C56
        BSET    D0,(A0)                         ; $2B5C5A
loc_2B5C5C:
        DC.W    $0000,$6600         ; $2B5C5C ORI.B  #$6600,D0
        BSET    D1,-(A0)                        ; $2B5C60
        BSET    D1,$00(A0,D0.W)                 ; $2B5C62
        SUBI.B  #$0000,(A0)                     ; $2B5C66
        BNE.W  loc_2B614C                       ; $2B5C6A
        DC.W    $04F0               ; $2B5C6E DC.W    $04F0
        BTST    D2,D0                           ; $2B5C70
        BTST    D2,(A0)                         ; $2B5C72
        CMPI.B  #$0052,D0                       ; $2B5C74
        ORI.W  #$FC7F,(A2)                      ; $2B5C78
        BTST    D0,-$74(A7,D0.W)                ; $2B5C7C
        MOVE.W  A3,(A6)                         ; $2B5C80
        BTST    D0,$6C(A3,A7.L)                 ; $2B5C82
        MOVE.W  D3,-(A6)                        ; $2B5C86
        ANDI.L  #$FF4EFCF5,(A6)+                ; $2B5C88
        ANDI.L  #$00A6FD44,-(A3)                ; $2B5C8E
        DC.W    $00EA               ; $2B5C94 DC.W    $00EA
        MOVE.W  -$1A(A4,A7.L),$0244(A7)         ; $2B5C96
        MOVE.W  (A0)+,-$02C7(A7)                ; $2B5C9C
        DC.W    $00EE               ; $2B5CA0 DC.W    $00EE
        ORI.L  #$FDDA024A,(A3)                  ; $2B5CA2
        DC.W    $00B1,$FDC2,$0270,$0060; $2B5CA8 ORI.L  #$FDC20270,$60(A1,D0.W)
        MOVE.W  (A1)+,-(A6)                     ; $2B5CB0
        ANDI.L  #$0000FD78,(A4)+                ; $2B5CB2
        DC.W    $038D               ; $2B5CB8 BCLR    D1,A5
        DC.W    $0000,$FE0E         ; $2B5CBA ORI.B  #$FE0E,D0
        BTST    D1,$5F(A0,D0.W)                 ; $2B5CBE
        DC.W    $FDC9               ; $2B5CC2 MOVE.W  A1,<EA:3E>
        ANDI.W  #$FFAF,-$01EC(A5)               ; $2B5CC4
        BTST    D1,-$0051(A5)                   ; $2B5CCA
        MOVE.W  A5,-(A6)                        ; $2B5CCE
        BSET    D0,(A4)                         ; $2B5CD0
        DC.W    $00B6,$FD42,$01F4,$0118; $2B5CD2 ORI.L  #$FD4201F4,$18(A6,D0.W)
        MOVEA.W $0147011D,A7                    ; $2B5CDA
        MOVEA.W -(A1),A7                        ; $2B5CE0
        BTST    D0,(A7)                         ; $2B5CE2
        DC.W    $00BC,$FD43,$0235,$00B8,$FE96; $2B5CE4 ORI.L  #$FD430235,#$00B8FE96
        BCHG    D0,$00BE.W                      ; $2B5CEE
        MOVE.W  -$6D(PC,D0.W),D7                ; $2B5CF2
loc_2B5CF6:
        DC.W    $00CC               ; $2B5CF6 DC.W    $00CC
        MOVEA.W -(A4),A7                        ; $2B5CF8
        BCLR    D0,(A2)                         ; $2B5CFA
        BTST    D0,(A5)                         ; $2B5CFC
        MOVEA.W (A5)+,A7                        ; $2B5CFE
        DC.W    $003B,$0112,$FE33   ; $2B5D00 ORI.B  #$0112,$33(PC,A7.L)
        DC.W    $FFF3,$00C9         ; $2B5D06 MOVE.W  -$37(A3,D0.W),<EA:3F>
        MOVE.W  A7,(A7)                         ; $2B5D0A
        BCLR    D0,(A1)                         ; $2B5D0C
        DC.W    $00CE               ; $2B5D0E DC.W    $00CE
        MOVE.W  D7,(A7)                         ; $2B5D10
        DC.W    $FFF1,$00CB         ; $2B5D12 MOVE.W  -$35(A1,D0.W),<EA:3F>
        MOVE.W  (A5),-(A7)                      ; $2B5D16
        DC.W    $00B4,$00C6,$FDAA,$FF09; $2B5D18 ORI.L  #$00C6FDAA,$09(A4,A7.L)
        DC.W    $00BC,$FEFB,$FF7E,$00C4,$FFD8; $2B5D20 ORI.L  #$FEFBFF7E,#$00C4FFD8
        ORI.W  #$00CA,-$0249(A5)                ; $2B5D2A
        BCHG    D1,(A6)+                        ; $2B5D30
        MOVE.W  -(A6),-(A7)                     ; $2B5D32
        DC.W    $FD7E,$0348         ; $2B5D34 MOVE.W  <EA:3E>,$0348(A6)
        MOVE.W  A1,(A7)+                        ; $2B5D38
        DC.W    $FDCA               ; $2B5D3A MOVE.W  A2,<EA:3E>
        BSET    D0,-$0114(A6)                   ; $2B5D3C
        MOVE.W  A1,D7                           ; $2B5D40
        BSET    D0,-(A4)                        ; $2B5D42
        MOVE.W  A4,-$02B6(A7)                   ; $2B5D44
        BCHG    D1,D7                           ; $2B5D48
        MOVE.W  -$0263(A4),-(A7)                ; $2B5D4A
        DC.W    $01CD               ; $2B5D4E BSET    D0,A5
        MOVE.W  (A0),-$0133(A7)                 ; $2B5D50
        DC.W    $02F3               ; $2B5D54 DC.W    $02F3
        MOVE.W  (A4)+,-(A7)                     ; $2B5D56
        MOVE.W  D0,(A7)                         ; $2B5D58
        BTST    D1,(A4)                         ; $2B5D5A
loc_2B5D5C:
        MOVE.W  (A2),(A7)+                      ; $2B5D5C
        MOVE.W  $030F(A2),-(A6)                 ; $2B5D5E
        MOVE.W  (A2)+,(A7)+                     ; $2B5D62
        MOVE.W  $02EC(A5),-(A6)                 ; $2B5D64
        MOVE.W  -(A4),-(A7)                     ; $2B5D68
        MOVE.W  A4,(A7)+                        ; $2B5D6A
        BCHG    D1,D6                           ; $2B5D6C
        MOVE.W  (A3),-(A7)                      ; $2B5D6E
        MOVE.W  $0340(A2),-(A6)                 ; $2B5D70
        MOVE.W  (A4)+,-(A7)                     ; $2B5D74
        MOVE.W  D7,-$62(A5,D0.W)                ; $2B5D76
        DC.W    $00AE,$FB8F,$008B,$FF4E; $2B5D7A ORI.L  #$FB8F008B,-$00B2(A6)
        MOVE.W  (A5),(A6)+                      ; $2B5D82
        BCHG    D0,-(A6)                        ; $2B5D84
        MOVE.W  -$0331(A1),$0176(A7)            ; $2B5D86
        ORI.L  #$FBF5FFF2,A1                    ; $2B5D8C
        MOVE.W  (A1)+,-$02C4(A7)                ; $2B5D92
        DC.W    $00CC               ; $2B5D96 DC.W    $00CC
        MOVE.W  -$13(A3,A7.L),$0005(A7)         ; $2B5D98
        DC.W    $00B9,$FD36,$00DD,$0094,$FC43; $2B5D9E ORI.L  #$FD3600DD,$0094FC43
        BSET    D0,-$61(PC,D0.W)                ; $2B5DA8
        DC.W    $FBD0               ; $2B5DAC MOVE.W  (A0),<EA:3D>
        BSET    D0,D1                           ; $2B5DAE
        DC.W    $010E               ; $2B5DB0 BTST    D0,A6
        DC.W    $FBEB,$0006         ; $2B5DB2 MOVE.W  $0006(A3),<EA:3D>
        ORI.W  #$FC5F,D1                        ; $2B5DB6
        ORI.W  #$FFD4,D0                        ; $2B5DBA
        MOVEA.W $01C6011B,A6                    ; $2B5DBE
        MOVE.W  (A4),(A6)                       ; $2B5DC4
        DC.W    $000A,$004E         ; $2B5DC6 ORI.B  #$004E,A2
        MOVE.W  $023B(A4),(A5)                  ; $2B5DCA
        BCLR    D0,D5                           ; $2B5DCE
        MOVE.W  $01C8(A2),(A5)                  ; $2B5DD0
        BCLR    D0,(A0)                         ; $2B5DD4
        MOVE.W  (A7)+,D6                        ; $2B5DD6
        BCLR    D0,-$1B(A4,D0.W)                ; $2B5DD8
        MOVE.W  -(A0),D6                        ; $2B5DDC
loc_2B5DDE:
        DC.W    $0226,$00DB         ; $2B5DDE ANDI.B  #$00DB,-(A6)
        MOVE.W  (A2),(A5)+                      ; $2B5DE2
        DC.W    $0214,$01DD         ; $2B5DE4 ANDI.B  #$01DD,(A4)
        MOVEA.W D6,A6                           ; $2B5DE8
        DC.W    $0200,$0132         ; $2B5DEA ANDI.B  #$0132,D0
        MOVE.W  A6,-$6C(A4,D0.W)                ; $2B5DEE
        BCLR    D0,(A2)                         ; $2B5DF2
loc_2B5DF4:
        MOVE.W  (A3),$59(A4,D0.W)               ; $2B5DF4
        BCLR    D0,(A2)                         ; $2B5DF8
        MOVE.W  $74(A1,D0.W),(A5)               ; $2B5DFA
        BCLR    D0,(A2)                         ; $2B5DFE
        MOVE.W  -(A7),(A5)                      ; $2B5E00
        BSET    D0,(A0)                         ; $2B5E02
        BCLR    D0,(A2)                         ; $2B5E04
        MOVE.W  D4,(A6)                         ; $2B5E06
        ORI.W  #$0011,-(A0)                     ; $2B5E08
        MOVE.W  (A2)+,D6                        ; $2B5E0C
        DC.W    $FFF9,$FFBF,$FAE5   ; $2B5E0E MOVE.W  $FFBFFAE5,<EA:3F>
        BCHG    D0,-$008A(A4)                   ; $2B5E14
        MOVE.W  A6,$01D4(A5)                    ; $2B5E18
        DC.W    $FFC9               ; $2B5E1C MOVE.W  A1,<EA:3F>
        MOVE.W  (A2)+,(A6)                      ; $2B5E1E
        ORI.W  #$FF83,(A7)                      ; $2B5E20
        MOVE.W  -(A4),$01CA(A5)                 ; $2B5E24
        MOVE.W  -$0522(PC),-(A7)                ; $2B5E28
        BSET    D0,-(A3)                        ; $2B5E2C
        MOVE.W  -(A1),$33(A7,A7.L)              ; $2B5E2E
        BCLR    D0,(A5)+                        ; $2B5E32
        DC.W    $FF7F,$FA2A         ; $2B5E34 MOVE.W  <EA:3F>,-$05D6(A7)
        ORI.W  #$FF6C,-(A5)                     ; $2B5E38
        MOVE.W  (A5),#$00AB                     ; $2B5E3C
        MOVE.W  A7,-$12(A7,A7.L)                ; $2B5E40
        BSET    D0,(A5)+                        ; $2B5E44
        MOVE.W  #$F9E5,-(A7)                    ; $2B5E46
        ORI.L  #$FF28F920,-(A3)                 ; $2B5E4A
        DC.W    $FFF9,$FF68,$F933   ; $2B5E50 MOVE.W  $FF68F933,<EA:3F>
        DC.W    $FFC1               ; $2B5E56 MOVE.W  D1,<EA:3F>
        MOVE.W  -$05BD(A0),$001A(A7)            ; $2B5E58
        MOVE.W  -$05DA(A0),$0072(A7)            ; $2B5E5E
        MOVE.W  $0010(A0),$6E00(A7)             ; $2B5E64
        DC.W    $0000,$0010         ; $2B5E6A ORI.B  #$0010,D0
        DC.W    $0020,$0030         ; $2B5E6E ORI.B  #$0030,-(A0)
        ADDI.B  #$6F00,(A0)                     ; $2B5E72
        ORI.W  #$0050,D0                        ; $2B5E76
        SUBI.B  #$7000,(A0)                     ; $2B5E7A
        ORI.W  #$0070,-(A0)                     ; $2B5E7E
        SUBI.B  #$6F00,(A0)                     ; $2B5E82
        DC.W    $0000,$0030         ; $2B5E86 ORI.B  #$0030,D0
        DC.W    $0210,$6D00         ; $2B5E8A ANDI.B  #$6D00,(A0)
        DC.W    $0020,$0050         ; $2B5E8E ORI.B  #$0050,-(A0)
        DC.W    $0010,$6400         ; $2B5E92 ORI.B  #$6400,(A0)
        ORI.L  #$009000A0,D0                    ; $2B5E96
        DC.W    $00B0,$0210,$0400,$00D0; $2B5E9C ORI.L  #$02100400,-$30(A0,D0.W)
        DC.W    $00C0               ; $2B5EA4 DC.W    $00C0
        SUBI.B  #$6500,(A0)                     ; $2B5EA6
        ORI.L  #$00900611,-(A0)                 ; $2B5EAA
        BTST    D3,D1                           ; $2B5EB0
        DC.W    $00B0,$0010,$6A00,$00E0; $2B5EB2 ORI.L  #$00106A00,-$20(A0,D0.W)
        DC.W    $00F0               ; $2B5EBA DC.W    $00F0
        BTST    D0,D0                           ; $2B5EBC
        BTST    D0,(A0)                         ; $2B5EBE
        DC.W    $0210,$6C00         ; $2B5EC0 ANDI.B  #$6C00,(A0)
        BTST    D0,$20(A0,D0.W)                 ; $2B5EC4
        SUBI.B  #$6B00,(A0)                     ; $2B5EC8
        BTST    D0,D0                           ; $2B5ECC
        DC.W    $00F0               ; $2B5ECE DC.W    $00F0
        DC.W    $0211,$6901         ; $2B5ED0 ANDI.B  #$6901,(A1)
        DC.W    $00E0               ; $2B5ED4 DC.W    $00E0
        DC.W    $0010,$6300         ; $2B5ED6 ORI.B  #$6300,(A0)
        BCHG    D0,D0                           ; $2B5EDA
        BCHG    D0,(A0)                         ; $2B5EDC
        BCHG    D0,-(A0)                        ; $2B5EDE
        BCHG    D0,$10(A0,D0.W)                 ; $2B5EE0
        BCS.W  loc_2B6076                       ; $2B5EE4
        BCLR    D0,D0                           ; $2B5EE8
        SUBI.B  #$6400,(A0)                     ; $2B5EEA
        BCHG    D0,-(A0)                        ; $2B5EEE
        BCHG    D0,(A0)                         ; $2B5EF0
        ADDI.B  #$6201,(A1)                     ; $2B5EF2
        BCHG    D0,$10(A0,D0.W)                 ; $2B5EF6
        BPL.W  loc_2B60DC                       ; $2B5EFA
        BSET    D0,$00(A0,D0.W)                 ; $2B5EFE
        DC.W    $0210,$0210         ; $2B5F02 ANDI.B  #$0210,(A0)
        BGE.W  loc_2B6138                       ; $2B5F06
        DC.W    $0220,$0410         ; $2B5F0A ANDI.B  #$0410,-(A0)
        BMI.W  loc_2B6110                       ; $2B5F0E
        BSET    D0,$11(A0,D0.W)                 ; $2B5F12
        BVS.S  loc_2B5F19                       ; $2B5F16
        DC.W    $0210,$0010         ; $2B5F18 ANDI.B  #$0010,(A0)
        BLS.W  loc_2B615E                       ; $2B5F1C
        ANDI.W  #$0260,(A0)                     ; $2B5F20
        ANDI.W  #$0210,$00(A0,D6.W)             ; $2B5F24
        ANDI.L  #$02800410,(A0)                 ; $2B5F2A
        BCC.W  loc_2B6192                       ; $2B5F30
        ANDI.W  #$0211,(A0)                     ; $2B5F34
        BHI.S  loc_2B5F3B                       ; $2B5F38
        ANDI.W  #$0010,D0                       ; $2B5F3A
        BNE.W  loc_2B61E0                       ; $2B5F3E
        DC.W    $02B0,$02C0,$02D0,$0610; $2B5F42 ANDI.L  #$02C002D0,$10(A0,D0.W)
        BEQ.W  $2B622C                          ; $2B5F4A
        DC.W    $02F0               ; $2B5F4E DC.W    $02F0
        SUBI.B  #$6800,(A0)                     ; $2B5F50
        BTST    D1,D0                           ; $2B5F54
        BTST    D1,(A0)                         ; $2B5F56
        SUBI.B  #$6700,(A0)                     ; $2B5F58
        ANDI.L  #$02D00010,-(A0)                ; $2B5F5C
        BTST    D1,D0                           ; $2B5F62
        BTST    D1,-(A0)                        ; $2B5F64
        BTST    D1,$40(A0,D0.W)                 ; $2B5F66
        BCHG    D1,(A0)                         ; $2B5F6A
        DC.W    $0210,$0500         ; $2B5F6C ANDI.B  #$0500,(A0)
        BCHG    D1,$60(A0,D0.W)                 ; $2B5F70
        SUBI.B  #$0400,(A0)                     ; $2B5F74
        BCHG    D1,D0                           ; $2B5F78
        BTST    D1,$10(A0,D0.W)                 ; $2B5F7A
        BCS.W  $2B6300                          ; $2B5F7E
        BCLR    D1,(A0)                         ; $2B5F82
        BCLR    D1,-(A0)                        ; $2B5F84
        BCLR    D1,$10(A0,D0.W)                 ; $2B5F86
        BLS.W  $2B635C                          ; $2B5F8A
        BSET    D1,D0                           ; $2B5F8E
        SUBI.B  #$6400,(A0)                     ; $2B5F90
        BCLR    D1,-(A0)                        ; $2B5F94
        BCLR    D1,(A0)                         ; $2B5F96
        DC.W    $0010,$0300         ; $2B5F98 ORI.B  #$0300,(A0)
        SUBI.B  #$0430,-(A0)                    ; $2B5F9C
        SUBI.W  #$0450,D0                       ; $2B5FA0
        DC.W    $0210,$0500         ; $2B5FA4 ANDI.B  #$0500,(A0)
        SUBI.W  #$0460,$10(A0,D0.W)             ; $2B5FA8
        SUBI.B  #$0440,D0                       ; $2B5FAE
        SUBI.B  #$0010,$00(A0,D6.W)             ; $2B5FB2
        SUBI.L  #$049004A0,D0                   ; $2B5FB8
        DC.W    $04B0,$0210,$6300,$04D0; $2B5FBE SUBI.L  #$02106300,-$30(A0,D0.W)
        DC.W    $04C0               ; $2B5FC6 DC.W    $04C0
        SUBI.B  #$6400,(A0)                     ; $2B5FC8
        SUBI.L  #$04900000,-(A0)                ; $2B5FCC
        BVS.W  loc_2B6174                       ; $2B5FD2
        BCLR    D0,-$40(A0,D0.W)                ; $2B5FD6
        BSET    D0,(A0)                         ; $2B5FDA
loc_2B5FDC:
        DC.W    $0000,$6600         ; $2B5FDC ORI.B  #$6600,D0
        BSET    D1,-(A0)                        ; $2B5FE0
        BSET    D1,$00(A0,D0.W)                 ; $2B5FE2
        SUBI.B  #$0000,(A0)                     ; $2B5FE6
        BNE.W  $2B64CC                          ; $2B5FEA
        DC.W    $04F0               ; $2B5FEE DC.W    $04F0
        BTST    D2,D0                           ; $2B5FF0
        BTST    D2,(A0)                         ; $2B5FF2
        CMPI.B  #$0150,D0                       ; $2B5FF4
        BCHG    D0,(A0)                         ; $2B5FF8
        DC.W    $00DE               ; $2B5FFA DC.W    $00DE
        BTST    D0,$1F(A4,D0.W)                 ; $2B5FFC
        BTST    D0,(A6)                         ; $2B6000
        BTST    D0,-(A1)                        ; $2B6002
        SUBI.L  #$00B80130,-(A1)                ; $2B6004
        BCLR    D3,$00(A6,D0.W)                 ; $2B600A
        BTST    D0,-$4A(A0,D0.W)                ; $2B600E
        MOVE.W  A0,$0130(A7)                    ; $2B6012
        BCLR    D3,-$16(A6,A7.L)                ; $2B6016
        BTST    D0,-(A1)                        ; $2B601A
        SUBI.L  #$FF220134,-(A1)                ; $2B601C
        SUBI.B  #$0298,(A7)+                    ; $2B6022
        ORI.W  #$02FB,D6                        ; $2B6026
        ANDI.L  #$00460497,(A0)+                ; $2B602A
        ANDI.L  #$01100497,(A0)+                ; $2B6030
        ANDI.L  #$013A02FB,(A0)+                ; $2B6036
        MOVE.W  $00F6.W,D7                      ; $2B603C
        DC.W    $04EB               ; $2B6040 DC.W    $04EB
        MOVE.W  $0105(PC),(A7)                  ; $2B6042
        DC.W    $04EB               ; $2B6046 DC.W    $04EB
        MOVE.W  $0046(PC),(A7)                  ; $2B6048
        DC.W    $04EB               ; $2B604C DC.W    $04EB
        MOVE.W  $0046.W,D7                      ; $2B604E
        DC.W    $04EB               ; $2B6052 DC.W    $04EB
        MOVE.W  $013A(A0),$02FB(A6)             ; $2B6054
        MOVE.W  $0110(A0),$0497(A6)             ; $2B605A
        MOVE.W  $0046(A0),$0497(A6)             ; $2B6060
        MOVE.W  $0046(A0),$02FB(A6)             ; $2B6066
        DC.W    $FDE3               ; $2B606C MOVE.W  -(A3),<EA:3E>
        ORI.W  #$FF8B,D6                        ; $2B606E
        MOVE.W  D7,(A7)+                        ; $2B6072
        ORI.W  #$FF37,D6                        ; $2B6074
        MOVE.W  D7,(A7)+                        ; $2B6078
        BCHG    D0,$37(A0,A7.L)                 ; $2B607A
        DC.W    $FDE3               ; $2B607E MOVE.W  -(A3),<EA:3E>
        BCHG    D0,-(A1)                        ; $2B6080
        MOVE.W  A3,$68(A7,A7.L)                 ; $2B6082
        ORI.W  #$0040,D6                        ; $2B6086
        MOVE.W  $0165(A0),$0040(A6)             ; $2B608A
        MOVE.W  (A6),-(A7)                      ; $2B6090
        BCLR    D0,D5                           ; $2B6092
        MOVE.W  A4,$1D(A7,D0.W)                 ; $2B6094
        BCHG    D0,-(A1)                        ; $2B6098
        MOVE.W  A3,$39(A7,D0.W)                 ; $2B609A
        BCHG    D0,$37(A0,A7.L)                 ; $2B609E
        BTST    D0,$0046FF37                    ; $2B60A2
        DC.W    $021D,$0046         ; $2B60A8 ANDI.B  #$0046,(A5)+
        MOVE.W  A3,-$38(A7,D0.W)                ; $2B60AC
        DC.W    $00F6               ; $2B60B0 DC.W    $00F6
        DC.W    $04EB               ; $2B60B2 DC.W    $04EB
        DC.W    $01C8               ; $2B60B4 BSET    D0,A0
        ORI.W  #$04EB,D6                        ; $2B60B6
        DC.W    $00EA               ; $2B60BA DC.W    $00EA
        BCLR    D0,D5                           ; $2B60BC
        MOVE.W  A4,-$68(A7,D0.W)                ; $2B60BE
        BCHG    D0,-(A5)                        ; $2B60C2
        ORI.W  #$0146,D0                        ; $2B60C4
        BTST    D0,D5                           ; $2B60C8
        DC.W    $04EB               ; $2B60CA DC.W    $04EB
        ANDI.L  #$00460040,(A0)+                ; $2B60CC
        BCHG    D0,D6                           ; $2B60D2
        ORI.W  #$04EB,D6                        ; $2B60D4
        DC.W    $0034,$033D,$0018   ; $2B60D8 ORI.B  #$033D,$18(A4,D0.W)
        DC.W    $FFCC               ; $2B60DE MOVE.W  A4,<EA:3F>
        DC.W    $033D               ; $2B60E0 BTST    D1,<EA:3D>
        DC.W    $0018,$FF48         ; $2B60E2 ORI.B  #$FF48,(A0)+
        BSET    D0,(A3)                         ; $2B60E6
        ORI.W  #$00B8,A3                        ; $2B60E8
        BSET    D0,(A3)                         ; $2B60EC
        ORI.W  #$FFD2,A3                        ; $2B60EE
        DC.W    $033D               ; $2B60F2 BTST    D1,<EA:3D>
        BCHG    D0,-(A0)                        ; $2B60F4
        DC.W    $002E,$033D,$0160   ; $2B60F6 ORI.B  #$033D,$0160(A6)
        DC.W    $00BF,$0174,$03AC   ; $2B60FC ORI.L  #$017403AC,<EA:3F>
        MOVE.W  D1,$0174(A7)                    ; $2B6102
        BCLR    D1,$00D9(A4)                    ; $2B6106
        BCHG    D0,$0C(A1,A7.L)                 ; $2B610A
        ORI.L  #$01D3FD49,D5                    ; $2B610E
        MOVE.W  -$2D(PC,D0.W),-$02B7(A7)        ; $2B6114
        MOVE.W  -(A7),-(A7)                     ; $2B611A
        BCHG    D0,$0C(A1,A7.L)                 ; $2B611C
        DC.W    $0000,$0046         ; $2B6120 ORI.B  #$0046,D0
        MOVE.W  A1,$0000(A3)                    ; $2B6124
        BCLR    D0,$0508(A3)                    ; $2B6128
        BTST    D0,-(A7)                        ; $2B612C
        DC.W    $00E0               ; $2B612E DC.W    $00E0
        BCLR    D3,$27(A6,D0.W)                 ; $2B6130
        DC.W    $00FE               ; $2B6134 DC.W    $00FE
        BCLR    D3,-$27(A6,A7.L)                ; $2B6136
        DC.W    $00E0               ; $2B613A DC.W    $00E0
        BCLR    D3,-$27(A6,A7.L)                ; $2B613C
        DC.W    $00FE               ; $2B6140 DC.W    $00FE
        BCLR    D3,-$5E(A6,D0.W)                ; $2B6142
        ORI.W  #$F8C4,D5                        ; $2B6146
        ANDI.L  #$0084F94C,-(A2)                ; $2B614A
        ANDI.L  #$011EF948,-(A2)                ; $2B6150
        ANDI.L  #$004BF755,-(A2)                ; $2B6156
        MOVE.W  (A6)+,$0084(A6)                 ; $2B615C
        MOVE.W  A4,-$02A2(A4)                   ; $2B6160
        ORI.W  #$F8C4,D5                        ; $2B6164
        MOVE.W  (A6)+,$004B(A6)                 ; $2B6168
        MOVE.W  (A5),-$02A2(A3)                 ; $2B616C
        BTST    D0,(A6)+                        ; $2B6170
        MOVE.W  A0,$02A2(A4)                    ; $2B6172
        ORI.W  #$F8C1,D7                        ; $2B6176
        ANDI.L  #$0085F94C,-(A2)                ; $2B617A
        ORI.W  #$005C,-$0D(PC,A7.L)             ; $2B6180
        ORI.W  #$0047,-$3F(A0,A7.L)             ; $2B6186
        MOVE.W  (A0),$47(A7,D0.W)               ; $2B618C
        MOVE.W  D1,(A4)+                        ; $2B6190
loc_2B6192:
        MOVE.W  D5,$5C(A7,D0.W)                 ; $2B6192
        MOVE.W  $5E(A3,A7.L),(A4)+              ; $2B6196
        ORI.L  #$F94CFD5E,D5                    ; $2B619A
        ORI.W  #$F8C1,D7                        ; $2B61A0
        ANDI.L  #$0047F7B8,-(A2)                ; $2B61A4
        ANDI.L  #$005CF8B3,-(A2)                ; $2B61AA
        MOVE.W  (A6)+,$005C(A6)                 ; $2B61B0
        MOVE.W  $5E(A3,A7.L),(A4)               ; $2B61B4
        ORI.W  #$F7B8,D7                        ; $2B61B8
        ORI.W  #$01D3,$29(A0,A7.L)              ; $2B61BC
        ORI.W  #$01D9,$4C(A0,D0.W)              ; $2B61C2
        DC.W    $003C,$029D,$002C   ; $2B61C8 ORI.B  #$029D,#$002C
        DC.W    $003C,$02A4,$FF8C   ; $2B61CE ORI.B  #$02A4,#$FF8C
        DC.W    $FFC4               ; $2B61D4 MOVE.W  D4,<EA:3F>
        ANDI.L  #$002CFFC4,(A5)+                ; $2B61D6
        ANDI.L  #$FF8CFF90,-(A4)                ; $2B61DC
        BSET    D0,(A1)+                        ; $2B61E2
        ORI.W  #$FF90,A4                        ; $2B61E4
        BSET    D0,(A3)                         ; $2B61E8
        MOVE.W  $02F5(A1),-(A7)                 ; $2B61EA
        BCHG    D0,$28(A1,A7.L)                 ; $2B61EE
        DC.W    $02F5               ; $2B61F2 DC.W    $02F5
        BCHG    D0,$3B(A1,A7.L)                 ; $2B61F4
        ORI.L  #$00E9FAAC,A5                    ; $2B61F8
        ORI.L  #$00E9FA99,A3                    ; $2B61FE
