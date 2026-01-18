; Generated assembly for $17A200-$17C200
; Branch targets: 56
; Labels: 56
; Format: DC.W with decoded mnemonics as comments

        org     $17A200

        DC.W    $0025,$02AF         ; $17A200 ORI.B  #$02AF,-(A5)
        SUBI.B  #$0000,D0                       ; $17A204
        DC.W    $0000,$0000         ; $17A208 ORI.B  #$0000,D0
        MOVE.B  D0,D2                           ; $17A20C
        BTST    D1,D0                           ; $17A20E
        MOVE.W  (A0),D4                         ; $17A210
        MOVE.W  -(A0),-(A4)                     ; $17A212
        ANDI.L  #$0000036A,D0                   ; $17A214
        DC.W    $0000,$02B0         ; $17A21A ORI.B  #$02B0,D0
        DC.W    $0000,$0400         ; $17A21E ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17A222 ORI.B  #$0000,D0
        DC.W    $0000,$1400         ; $17A226 ORI.B  #$1400,D0
        DC.W    $0200,$0011         ; $17A22A ANDI.B  #$0011,D0
        MOVE.W  -(A0),-(A4)                     ; $17A22E
        DC.W    $02B0,$0000,$036A,$0000; $17A230 ANDI.L  #$0000036A,$00(A0,D0.W)
        DC.W    $02F0               ; $17A238 DC.W    $02F0
        DC.W    $0000,$0400         ; $17A23A ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17A23E ORI.B  #$0000,D0
        DC.W    $0000,$1400         ; $17A242 ORI.B  #$1400,D0
        BTST    D1,D0                           ; $17A246
        DC.W    $0011,$0003         ; $17A248 ORI.B  #$0003,(A1)
        MOVE.L  -(A0),-(A0)                     ; $17A24C
        BTST    D0,(A7)+                        ; $17A24E
        DC.W    $0220,$FEE1         ; $17A250 ANDI.B  #$FEE1,-(A0)
        BSET    D1,$0400(A6)                    ; $17A254
        DC.W    $0000,$0400         ; $17A258 ORI.B  #$0400,D0
        DC.W    $0000,$FFFC         ; $17A25C ORI.B  #$FFFC,D0
        DC.W    $FFF8,$1DB1         ; $17A260 MOVE.W  $1DB1.W,<EA:3F>
        BTST    D0,D0                           ; $17A264
        BMI.S  loc_17A2C0                       ; $17A266
        MOVE.L  (A0),-(A4)                      ; $17A268
        BTST    D0,(A7)+                        ; $17A26A
        DC.W    $0220,$0400         ; $17A26C ANDI.B  #$0400,-(A0)
        DC.W    $0000,$0400         ; $17A270 ORI.B  #$0400,D0
        DC.W    $0000,$FEE1         ; $17A274 ORI.B  #$FEE1,D0
        BSET    D1,$0000(A6)                    ; $17A278
        DC.W    $0000,$1CB8         ; $17A27C ORI.B  #$1CB8,D0
        BTST    D0,D0                           ; $17A280
        BMI.S  loc_17A2DD                       ; $17A282
        MOVE.L  (A0),D5                         ; $17A284
        BTST    D0,(A7)+                        ; $17A286
        BSET    D0,$0400(A1)                    ; $17A288
        DC.W    $0000,$011F         ; $17A28C ORI.B  #$011F,D0
        DC.W    $0220,$FEE1         ; $17A290 ANDI.B  #$FEE1,-(A0)
        BSET    D1,$0000(A6)                    ; $17A294
        DC.W    $0000,$1CB8         ; $17A298 ORI.B  #$1CB8,D0
        DC.W    $0200,$6B59         ; $17A29C ANDI.B  #$6B59,D0
        MOVE.L  -(A0),D1                        ; $17A2A0
        BTST    D0,(A7)+                        ; $17A2A2
        BSET    D0,-$011F(A1)                   ; $17A2A4
        BSET    D1,$011F(A6)                    ; $17A2A8
        DC.W    $0220,$0400         ; $17A2AC ANDI.B  #$0400,-(A0)
        DC.W    $0000,$FFFC         ; $17A2B0 ORI.B  #$FFFC,D0
        DC.W    $FFF8,$1DB1         ; $17A2B4 MOVE.W  $1DB1.W,<EA:3F>
        DC.W    $0200,$6B58         ; $17A2B8 ANDI.B  #$6B58,D0
        DC.W    $0006,$A210         ; $17A2BC ORI.B  #$A210,D6
loc_17A2C0:
        BTST    D0,(A7)+                        ; $17A2C0
        MOVE.W  -(A1),D7                        ; $17A2C2
        MOVE.W  -(A1),(A7)+                     ; $17A2C4
        BCLR    D0,$011F(A7)                    ; $17A2C6
        ANDI.W  #$FEE1,$048D(A5)                ; $17A2CA
        DC.W    $FFFC,$FFF8         ; $17A2D0 MOVE.W  #$FFF8,<EA:3F>
        MOVE.B  (A1)+,-(A6)                     ; $17A2D4
        BTST    D0,D0                           ; $17A2D6
        BMI.S  loc_17A332                       ; $17A2D8
        TST.B  (A0)                             ; $17A2DA
        SUBI.B  #$0000,D0                       ; $17A2DC
        SUBI.B  #$0000,D0                       ; $17A2E0
        BTST    D0,(A7)+                        ; $17A2E4
        ANDI.W  #$FEE1,$01AF(A5)                ; $17A2E6
        DC.W    $0000,$0000         ; $17A2EC ORI.B  #$0000,D0
        MOVE.B  $0100(A6),(A6)                  ; $17A2F0
        BMI.S  loc_17A34F                       ; $17A2F4
        CLR.B  -(A0)                            ; $17A2F6
        SUBI.B  #$0000,D0                       ; $17A2F8
        MOVE.W  -(A1),(A7)+                     ; $17A2FC
        SUBI.L  #$011F026D,A5                   ; $17A2FE
        SUBI.B  #$0000,D0                       ; $17A304
        DC.W    $FFF4,$FFEA         ; $17A308 MOVE.W  -$16(A4,A7.L),<EA:3F>
        MOVE.B  A0,-(A7)                        ; $17A30C
        BTST    D0,D0                           ; $17A30E
        BMI.S  loc_17A369                       ; $17A310
        MOVE.L  -(A0),D1                        ; $17A312
        BTST    D0,(A7)+                        ; $17A314
        ANDI.W  #$FEE1,$048D(A5)                ; $17A316
        BTST    D0,(A7)+                        ; $17A31C
        ANDI.L  #$04000000,-(A4)                ; $17A31E
        DC.W    $FFF4,$FFEA         ; $17A324 MOVE.W  -$16(A4,A7.L),<EA:3F>
        MOVE.B  A0,-(A7)                        ; $17A328
        DC.W    $0200,$6B57         ; $17A32A ANDI.B  #$6B57,D0
        MOVE.L  (A0),D5                         ; $17A32E
        BTST    D0,(A7)+                        ; $17A330
loc_17A332:
        ANDI.W  #$0400,$0000(A5)                ; $17A332
        BTST    D0,(A7)+                        ; $17A338
        ANDI.L  #$FEE101AF,-(A4)                ; $17A33A
        DC.W    $0000,$0000         ; $17A340 ORI.B  #$0000,D0
        MOVE.B  $0200(A6),(A6)                  ; $17A344
        BMI.S  loc_17A3A3                       ; $17A348
        MOVE.L  -(A0),D5                        ; $17A34A
        BTST    D0,(A7)+                        ; $17A34C
        DC.W    $FDEA,$0400         ; $17A34E MOVE.W  $0400(A2),<EA:3E>
        DC.W    $0000,$011F         ; $17A352 ORI.B  #$011F,D0
        MOVE.W  -(A1),D7                        ; $17A356
        SUBI.B  #$0000,D0                       ; $17A358
        DC.W    $FFFC,$FFF8         ; $17A35C MOVE.W  #$FFF8,<EA:3F>
        MOVE.B  (A1)+,-(A6)                     ; $17A360
        DC.W    $0200,$6B58         ; $17A362 ANDI.B  #$6B58,D0
        MOVE.L  (A0),D1                         ; $17A366
        BTST    D0,(A7)+                        ; $17A368
        ANDI.W  #$FEE1,$01AF(A5)                ; $17A36A
        BTST    D0,(A7)+                        ; $17A370
        ANDI.L  #$FEE1048D,-(A4)                ; $17A372
        DC.W    $FFFC,$FFF8         ; $17A378 MOVE.W  #$FFF8,<EA:3F>
        MOVE.B  (A1)+,-(A6)                     ; $17A37C
        DC.W    $0200,$6B58         ; $17A37E ANDI.B  #$6B58,D0
        DC.W    $0001,$4A20         ; $17A382 ORI.B  #$4A20,D1
        SUBI.B  #$0000,D0                       ; $17A386
        SUBI.B  #$0000,D0                       ; $17A38A
        BTST    D0,(A7)+                        ; $17A38E
        MOVEA.W $0400(A6),A7                    ; $17A390
        DC.W    $0000,$FFF4         ; $17A394 ORI.B  #$FFF4,D0
        DC.W    $FFEA,$1D7B         ; $17A398 MOVE.W  $1D7B(A2),<EA:3F>
        BTST    D0,D0                           ; $17A39C
        BMI.S  loc_17A3F7                       ; $17A39E
        MOVE.L  -(A0),D5                        ; $17A3A0
        BTST    D0,(A7)+                        ; $17A3A2
        MOVEA.W $0400(A6),A7                    ; $17A3A4
        DC.W    $0000,$011F         ; $17A3A8 ORI.B  #$011F,D0
        MOVE.W  -(A5),(A7)                      ; $17A3AC
        SUBI.B  #$0000,D0                       ; $17A3AE
        DC.W    $FFF4,$FFEA         ; $17A3B2 MOVE.W  -$16(A4,A7.L),<EA:3F>
        MOVE.B  $00(PC,D0.W),$6B57(A6)          ; $17A3B6
        DC.W    $0005,$7920         ; $17A3BC ORI.B  #$7920,D5
        DC.W    $02C0               ; $17A3C0 DC.W    $02C0
        DC.W    $0000,$01EA         ; $17A3C2 ORI.B  #$01EA,D0
        DC.W    $0000,$0400         ; $17A3C6 ORI.B  #$0400,D0
        DC.W    $0000,$0400         ; $17A3CA ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17A3CE ORI.B  #$0000,D0
        DC.W    $0003,$13C9         ; $17A3D2 ORI.B  #$13C9,D3
        BTST    D0,D0                           ; $17A3D6
        DC.W    $0012,$6970         ; $17A3D8 ORI.B  #$6970,(A2)
        DC.W    $02C0               ; $17A3DC DC.W    $02C0
        DC.W    $0000,$0400         ; $17A3DE ORI.B  #$0400,D0
        DC.W    $0000,$0400         ; $17A3E2 ORI.B  #$0400,D0
        DC.W    $0000,$01EA         ; $17A3E6 ORI.B  #$01EA,D0
        DC.W    $0000,$0000         ; $17A3EA ORI.B  #$0000,D0
        DC.W    $0000,$1400         ; $17A3EE ORI.B  #$1400,D0
        BTST    D0,D0                           ; $17A3F2
        DC.W    $0011,$7920         ; $17A3F4 ORI.B  #$7920,(A1)
        ANDI.L  #$000001EA,(A0)                 ; $17A3F8
        DC.W    $0000,$02C0         ; $17A3FE ORI.B  #$02C0,D0
        DC.W    $0000,$0400         ; $17A402 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17A406 ORI.B  #$0000,D0
        DC.W    $0003,$13C9         ; $17A40A ORI.B  #$13C9,D3
        DC.W    $0200,$0012         ; $17A40E ANDI.B  #$0012,D0
        BVS.S  loc_17A484                       ; $17A412
        ANDI.L  #$00000400,(A0)                 ; $17A414
        DC.W    $0000,$02C0         ; $17A41A ORI.B  #$02C0,D0
        DC.W    $0000,$01EA         ; $17A41E ORI.B  #$01EA,D0
        DC.W    $0000,$0000         ; $17A422 ORI.B  #$0000,D0
        DC.W    $0000,$1400         ; $17A426 ORI.B  #$1400,D0
        DC.W    $0200,$0011         ; $17A42A ANDI.B  #$0011,D0
        MOVE.W  -(A0),-(A4)                     ; $17A42E
        ANDI.W  #$0000,(A0)                     ; $17A430
        BSET    D0,$0000(A2)                    ; $17A434
        ANDI.L  #$00000400,(A0)                 ; $17A438
        DC.W    $0000,$0000         ; $17A43E ORI.B  #$0000,D0
        DC.W    $0003,$13C9         ; $17A442 ORI.B  #$13C9,D3
        BTST    D1,D0                           ; $17A446
        DC.W    $0012,$6970         ; $17A448 ORI.B  #$6970,(A2)
        ANDI.W  #$0000,(A0)                     ; $17A44C
        SUBI.B  #$0000,D0                       ; $17A450
        ANDI.L  #$000001EA,(A0)                 ; $17A454
        DC.W    $0000,$0000         ; $17A45A ORI.B  #$0000,D0
        DC.W    $0000,$1400         ; $17A45E ORI.B  #$1400,D0
        BTST    D1,D0                           ; $17A462
        DC.W    $0011,$0005         ; $17A464 ORI.B  #$0005,(A1)
        SUBQ.B  #4,-(A0)                        ; $17A468
        SUBI.B  #$0000,D0                       ; $17A46A
        BSET    D0,$0000(A2)                    ; $17A46E
        ANDI.L  #$00000400,D0                   ; $17A472
        DC.W    $0000,$0000         ; $17A478 ORI.B  #$0000,D0
        DC.W    $0003,$13C9         ; $17A47C ORI.B  #$13C9,D3
        BTST    D0,D0                           ; $17A480
        DC.W    $0012,$4970         ; $17A482 ORI.B  #$4970,(A2)
        SUBI.B  #$0000,D0                       ; $17A486
        SUBI.B  #$0000,D0                       ; $17A48A
        ANDI.L  #$000001EA,D0                   ; $17A48E
        DC.W    $0000,$0000         ; $17A494 ORI.B  #$0000,D0
        DC.W    $0000,$1400         ; $17A498 ORI.B  #$1400,D0
        BTST    D0,D0                           ; $17A49C
        DC.W    $0011,$7920         ; $17A49E ORI.B  #$7920,(A1)
        ANDI.L  #$000001EA,D0                   ; $17A4A2
        DC.W    $0000,$02B0         ; $17A4A8 ORI.B  #$02B0,D0
        DC.W    $0000,$0400         ; $17A4AC ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17A4B0 ORI.B  #$0000,D0
        DC.W    $0003,$13C9         ; $17A4B4 ORI.B  #$13C9,D3
        DC.W    $0200,$0012         ; $17A4B8 ANDI.B  #$0012,D0
        BVS.S  loc_17A52E                       ; $17A4BC
        ANDI.L  #$00000400,D0                   ; $17A4BE
        DC.W    $0000,$02B0         ; $17A4C4 ORI.B  #$02B0,D0
        DC.W    $0000,$01EA         ; $17A4C8 ORI.B  #$01EA,D0
        DC.W    $0000,$0000         ; $17A4CC ORI.B  #$0000,D0
        DC.W    $0000,$1400         ; $17A4D0 ORI.B  #$1400,D0
        DC.W    $0200,$0011         ; $17A4D4 ANDI.B  #$0011,D0
        MOVE.W  -(A0),-(A4)                     ; $17A4D8
        DC.W    $02B0,$0000,$01EA,$0000; $17A4DA ANDI.L  #$000001EA,$00(A0,D0.W)
        DC.W    $02F0               ; $17A4E2 DC.W    $02F0
        DC.W    $0000,$0400         ; $17A4E4 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17A4E8 ORI.B  #$0000,D0
        DC.W    $0003,$13C9         ; $17A4EC ORI.B  #$13C9,D3
        BTST    D1,D0                           ; $17A4F0
        DC.W    $0012,$6970         ; $17A4F2 ORI.B  #$6970,(A2)
        DC.W    $02B0,$0000,$0400,$0000; $17A4F6 ANDI.L  #$00000400,$00(A0,D0.W)
        DC.W    $02F0               ; $17A4FE DC.W    $02F0
        DC.W    $0000,$01EA         ; $17A500 ORI.B  #$01EA,D0
        DC.W    $0000,$0000         ; $17A504 ORI.B  #$0000,D0
        DC.W    $0000,$1400         ; $17A508 ORI.B  #$1400,D0
        BTST    D1,D0                           ; $17A50C
        DC.W    $0011,$0005         ; $17A50E ORI.B  #$0005,(A1)
        MOVE.L  -(A0),-(A0)                     ; $17A512
        BTST    D0,(A7)+                        ; $17A514
        ORI.W  #$FEE1,(A7)+                     ; $17A516
        BCHG    D1,$0400(A3)                    ; $17A51A
        DC.W    $0000,$0400         ; $17A51E ORI.B  #$0400,D0
        DC.W    $0000,$FFF5         ; $17A522 ORI.B  #$FFF5,D0
        DC.W    $FFEC,$1C0E         ; $17A526 MOVE.W  $1C0E(A4),<EA:3F>
        BTST    D0,D0                           ; $17A52A
        BMI.S  loc_17A584                       ; $17A52C
loc_17A52E:
        MOVE.L  (A0),-(A4)                      ; $17A52E
        BTST    D0,(A7)+                        ; $17A530
        ORI.W  #$0400,(A7)+                     ; $17A532
        DC.W    $0000,$0400         ; $17A536 ORI.B  #$0400,D0
        DC.W    $0000,$FEE1         ; $17A53A ORI.B  #$FEE1,D0
        ORI.L  #$FFFCFFF8,A5                    ; $17A53E
        MOVE.B  A1,D6                           ; $17A544
        BTST    D0,D0                           ; $17A546
        BMI.S  loc_17A5A2                       ; $17A548
        MOVE.L  (A0),-(A0)                      ; $17A54A
        BTST    D0,(A7)+                        ; $17A54C
        ORI.W  #$FEE1,(A7)+                     ; $17A54E
        ORI.L  #$04000000,A5                    ; $17A552
        MOVE.W  -(A1),(A7)+                     ; $17A558
        BCHG    D1,-$000C(A3)                   ; $17A55A
        DC.W    $FFEA,$1C45         ; $17A55E MOVE.W  $1C45(A2),<EA:3F>
        BTST    D0,D0                           ; $17A562
        BMI.S  loc_17A5BD                       ; $17A564
        MOVE.L  (A0),D5                         ; $17A566
        BTST    D0,(A7)+                        ; $17A568
        DC.W    $0028,$0400,$0000   ; $17A56A ORI.B  #$0400,$0000(A0)
        BTST    D0,(A7)+                        ; $17A570
        ORI.W  #$FEE1,(A7)+                     ; $17A572
        ORI.L  #$FFFCFFF8,A5                    ; $17A576
        MOVE.B  A1,D6                           ; $17A57C
        DC.W    $0200,$6B58         ; $17A57E ANDI.B  #$6B58,D0
        MOVE.L  (A0),D1                         ; $17A582
loc_17A584:
        BTST    D0,(A7)+                        ; $17A584
        DC.W    $0028,$FEE1,$008D   ; $17A586 ORI.B  #$FEE1,$008D(A0)
        BTST    D0,(A7)+                        ; $17A58C
        ORI.W  #$FEE1,(A7)+                     ; $17A58E
        BCHG    D1,-$000C(A3)                   ; $17A592
        DC.W    $FFEA,$1C45         ; $17A596 MOVE.W  $1C45(A2),<EA:3F>
        DC.W    $0200,$6B57         ; $17A59A ANDI.B  #$6B57,D0
        MOVE.L  -(A0),D1                        ; $17A59E
        BTST    D0,(A7)+                        ; $17A5A0
loc_17A5A2:
        DC.W    $0028,$FEE1,$036B   ; $17A5A2 ORI.B  #$FEE1,$036B(A0)
        BTST    D0,(A7)+                        ; $17A5A8
        ORI.W  #$0400,(A7)+                     ; $17A5AA
        DC.W    $0000,$FFF5         ; $17A5AE ORI.B  #$FFF5,D0
        DC.W    $FFEC,$1C0E         ; $17A5B2 MOVE.W  $1C0E(A4),<EA:3F>
        DC.W    $0200,$6B56         ; $17A5B6 ANDI.B  #$6B56,D0
        DC.W    $0005,$4210         ; $17A5BA ORI.B  #$4210,D5
        SUBI.B  #$0000,D0                       ; $17A5BE
        MOVE.W  -(A1),(A7)+                     ; $17A5C2
        BTST    D0,$011F(A4)                    ; $17A5C4
        DC.W    $00AC,$FEE1,$040A,$FFF5; $17A5C8 ORI.L  #$FEE1040A,-$000B(A4)
        DC.W    $FFEC,$1AA6         ; $17A5D0 MOVE.W  $1AA6(A4),<EA:3F>
        BTST    D0,D0                           ; $17A5D4
        BMI.S  loc_17A62E                       ; $17A5D6
        CLR.B  -(A0)                            ; $17A5D8
        SUBI.B  #$0000,D0                       ; $17A5DA
        MOVE.W  -(A1),(A7)+                     ; $17A5DE
        SUBI.B  #$011F,A2                       ; $17A5E0
        DC.W    $00AC,$0400,$0000,$FFF5; $17A5E4 ORI.L  #$04000000,-$000B(A4)
        DC.W    $FFED,$1AA1         ; $17A5EC MOVE.W  $1AA1(A5),<EA:3F>
        BTST    D0,D0                           ; $17A5F0
        BMI.S  loc_17A649                       ; $17A5F2
        TST.B  (A0)                             ; $17A5F4
        SUBI.B  #$0000,D0                       ; $17A5F6
        SUBI.B  #$0000,D0                       ; $17A5FA
        BTST    D0,(A7)+                        ; $17A5FE
        DC.W    $00AC,$FEE1,$012C,$FFF4; $17A600 ORI.L  #$FEE1012C,-$000C(A4)
        DC.W    $FFEA,$1AB8         ; $17A608 MOVE.W  $1AB8(A2),<EA:3F>
        BTST    D0,D0                           ; $17A60C
        BMI.S  loc_17A667                       ; $17A60E
        MOVE.L  (A0),D5                         ; $17A610
        BTST    D0,(A7)+                        ; $17A612
        DC.W    $00AC,$0400,$0000,$011F; $17A614 ORI.L  #$04000000,$011F(A4)
        DC.W    $00E4               ; $17A61C DC.W    $00E4
        MOVE.W  -(A1),(A7)+                     ; $17A61E
        BTST    D0,-$000C(A4)                   ; $17A620
        DC.W    $FFEA,$1AB8         ; $17A624 MOVE.W  $1AB8(A2),<EA:3F>
        DC.W    $0200,$6B57         ; $17A628 ANDI.B  #$6B57,D0
        MOVE.L  -(A0),D1                        ; $17A62C
loc_17A62E:
        BTST    D0,(A7)+                        ; $17A62E
        DC.W    $00AC,$FEE1,$040A,$011F; $17A630 ORI.L  #$FEE1040A,$011F(A4)
        DC.W    $00E4               ; $17A638 DC.W    $00E4
        SUBI.B  #$0000,D0                       ; $17A63A
        DC.W    $FFF5,$FFED         ; $17A63E MOVE.W  -$13(A5,A7.L),<EA:3F>
        MOVE.B  -(A1),(A5)                      ; $17A642
        DC.W    $0200,$6B55         ; $17A644 ANDI.B  #$6B55,D0
        MOVE.L  (A0),D1                         ; $17A648
        BTST    D0,(A7)+                        ; $17A64A
        DC.W    $00AC,$FEE1,$012C,$011F; $17A64C ORI.L  #$FEE1012C,$011F(A4)
        DC.W    $00E4               ; $17A654 DC.W    $00E4
        MOVE.W  -(A1),(A7)+                     ; $17A656
        SUBI.B  #$FFF5,A2                       ; $17A658
        DC.W    $FFEC,$1AA6         ; $17A65C MOVE.W  $1AA6(A4),<EA:3F>
        DC.W    $0200,$6B56         ; $17A660 ANDI.B  #$6B56,D0
        DC.W    $0008,$7920         ; $17A664 ORI.B  #$7920,A0
        DC.W    $02C0               ; $17A668 DC.W    $02C0
        DC.W    $0000,$02EA         ; $17A66A ORI.B  #$02EA,D0
        DC.W    $0000,$0400         ; $17A66E ORI.B  #$0400,D0
        DC.W    $0000,$0400         ; $17A672 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17A676 ORI.B  #$0000,D0
        DC.W    $0018,$138D         ; $17A67A ORI.B  #$138D,(A0)+
        BTST    D0,D0                           ; $17A67E
        DC.W    $0014,$7970         ; $17A680 ORI.B  #$7970,(A4)
        DC.W    $02C0               ; $17A684 DC.W    $02C0
        DC.W    $0000,$006A         ; $17A686 ORI.B  #$006A,D0
        DC.W    $0000,$0400         ; $17A68A ORI.B  #$0400,D0
        DC.W    $0000,$02EA         ; $17A68E ORI.B  #$02EA,D0
        DC.W    $0000,$0000         ; $17A692 ORI.B  #$0000,D0
        DC.W    $0013,$1404         ; $17A696 ORI.B  #$1404,(A3)
        BTST    D0,D0                           ; $17A69A
        DC.W    $0013,$6970         ; $17A69C ORI.B  #$6970,(A3)
        DC.W    $02C0               ; $17A6A0 DC.W    $02C0
        DC.W    $0000,$0400         ; $17A6A2 ORI.B  #$0400,D0
        DC.W    $0000,$0400         ; $17A6A6 ORI.B  #$0400,D0
        DC.W    $0000,$006A         ; $17A6AA ORI.B  #$006A,D0
        DC.W    $0000,$0000         ; $17A6AE ORI.B  #$0000,D0
        DC.W    $0003,$143A         ; $17A6B2 ORI.B  #$143A,D3
        BTST    D0,D0                           ; $17A6B6
        DC.W    $0012,$7920         ; $17A6B8 ORI.B  #$7920,(A2)
        ANDI.L  #$000002EA,(A0)                 ; $17A6BC
        DC.W    $0000,$02C0         ; $17A6C2 ORI.B  #$02C0,D0
        DC.W    $0000,$0400         ; $17A6C6 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17A6CA ORI.B  #$0000,D0
        DC.W    $0018,$138D         ; $17A6CE ORI.B  #$138D,(A0)+
        DC.W    $0200,$0014         ; $17A6D2 ANDI.B  #$0014,D0
        MOVE.W  -$70(A0,D0.W),$0000(A4)         ; $17A6D6
        ORI.W  #$0000,$02C0(A2)                 ; $17A6DC
        DC.W    $0000,$02EA         ; $17A6E2 ORI.B  #$02EA,D0
        DC.W    $0000,$0000         ; $17A6E6 ORI.B  #$0000,D0
        DC.W    $0013,$1404         ; $17A6EA ORI.B  #$1404,(A3)
        DC.W    $0200,$0013         ; $17A6EE ANDI.B  #$0013,D0
        BVS.S  loc_17A764                       ; $17A6F2
        ANDI.L  #$00000400,(A0)                 ; $17A6F4
        DC.W    $0000,$02C0         ; $17A6FA ORI.B  #$02C0,D0
        DC.W    $0000,$006A         ; $17A6FE ORI.B  #$006A,D0
        DC.W    $0000,$0000         ; $17A702 ORI.B  #$0000,D0
        DC.W    $0003,$143A         ; $17A706 ORI.B  #$143A,D3
        DC.W    $0200,$0012         ; $17A70A ANDI.B  #$0012,D0
        BVS.S  loc_17A780                       ; $17A70E
        ANDI.W  #$0000,(A0)                     ; $17A710
        SUBI.B  #$0000,D0                       ; $17A714
        ANDI.L  #$0000006A,(A0)                 ; $17A718
        DC.W    $0000,$0000         ; $17A71E ORI.B  #$0000,D0
        DC.W    $0003,$143A         ; $17A722 ORI.B  #$143A,D3
        BTST    D1,D0                           ; $17A726
        DC.W    $0012,$7920         ; $17A728 ORI.B  #$7920,(A2)
        ANDI.W  #$0000,(A0)                     ; $17A72C
        DC.W    $02EA               ; $17A730 DC.W    $02EA
        DC.W    $0000,$0290         ; $17A732 ORI.B  #$0290,D0
        DC.W    $0000,$0400         ; $17A736 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17A73A ORI.B  #$0000,D0
        DC.W    $0018,$138D         ; $17A73E ORI.B  #$138D,(A0)+
        BTST    D1,D0                           ; $17A742
        DC.W    $0014,$7970         ; $17A744 ORI.B  #$7970,(A4)
        ANDI.W  #$0000,(A0)                     ; $17A748
        ORI.W  #$0000,$0290(A2)                 ; $17A74C
        DC.W    $0000,$02EA         ; $17A752 ORI.B  #$02EA,D0
        DC.W    $0000,$0000         ; $17A756 ORI.B  #$0000,D0
        DC.W    $0013,$1404         ; $17A75A ORI.B  #$1404,(A3)
        BTST    D1,D0                           ; $17A75E
        DC.W    $0013,$0008         ; $17A760 ORI.B  #$0008,(A3)
loc_17A764:
        SUBQ.B  #4,-(A0)                        ; $17A764
        SUBI.B  #$0000,D0                       ; $17A766
        DC.W    $02EA               ; $17A76A DC.W    $02EA
        DC.W    $0000,$0280         ; $17A76C ORI.B  #$0280,D0
        DC.W    $0000,$0400         ; $17A770 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17A774 ORI.B  #$0000,D0
        DC.W    $0018,$138D         ; $17A778 ORI.B  #$138D,(A0)+
        BTST    D0,D0                           ; $17A77C
        DC.W    $0014,$5970         ; $17A77E ORI.B  #$5970,(A4)
        SUBI.B  #$0000,D0                       ; $17A782
        ORI.W  #$0000,$0280(A2)                 ; $17A786
        DC.W    $0000,$02EA         ; $17A78C ORI.B  #$02EA,D0
        DC.W    $0000,$0000         ; $17A790 ORI.B  #$0000,D0
        DC.W    $0013,$1404         ; $17A794 ORI.B  #$1404,(A3)
        BTST    D0,D0                           ; $17A798
        DC.W    $0013,$4970         ; $17A79A ORI.B  #$4970,(A3)
        SUBI.B  #$0000,D0                       ; $17A79E
        SUBI.B  #$0000,D0                       ; $17A7A2
        ANDI.L  #$0000006A,D0                   ; $17A7A6
        DC.W    $0000,$0000         ; $17A7AC ORI.B  #$0000,D0
        DC.W    $0003,$143A         ; $17A7B0 ORI.B  #$143A,D3
        BTST    D0,D0                           ; $17A7B4
        DC.W    $0012,$7920         ; $17A7B6 ORI.B  #$7920,(A2)
        ANDI.L  #$000002EA,D0                   ; $17A7BA
        DC.W    $0000,$02B0         ; $17A7C0 ORI.B  #$02B0,D0
        DC.W    $0000,$0400         ; $17A7C4 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17A7C8 ORI.B  #$0000,D0
        DC.W    $0018,$138D         ; $17A7CC ORI.B  #$138D,(A0)+
        DC.W    $0200,$0014         ; $17A7D0 ANDI.B  #$0014,D0
        MOVE.W  -$80(A0,D0.W),$0000(A4)         ; $17A7D4
        ORI.W  #$0000,$02B0(A2)                 ; $17A7DA
        DC.W    $0000,$02EA         ; $17A7E0 ORI.B  #$02EA,D0
        DC.W    $0000,$0000         ; $17A7E4 ORI.B  #$0000,D0
        DC.W    $0013,$1404         ; $17A7E8 ORI.B  #$1404,(A3)
        DC.W    $0200,$0013         ; $17A7EC ANDI.B  #$0013,D0
        BVS.S  loc_17A862                       ; $17A7F0
        ANDI.L  #$00000400,D0                   ; $17A7F2
        DC.W    $0000,$02B0         ; $17A7F8 ORI.B  #$02B0,D0
        DC.W    $0000,$006A         ; $17A7FC ORI.B  #$006A,D0
        DC.W    $0000,$0000         ; $17A800 ORI.B  #$0000,D0
        DC.W    $0003,$143A         ; $17A804 ORI.B  #$143A,D3
        DC.W    $0200,$0012         ; $17A808 ANDI.B  #$0012,D0
        MOVE.W  -(A0),-(A4)                     ; $17A80C
        DC.W    $02B0,$0000,$02EA,$0000; $17A80E ANDI.L  #$000002EA,$00(A0,D0.W)
        DC.W    $02F0               ; $17A816 DC.W    $02F0
        DC.W    $0000,$0400         ; $17A818 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17A81C ORI.B  #$0000,D0
        DC.W    $0018,$138D         ; $17A820 ORI.B  #$138D,(A0)+
        BTST    D1,D0                           ; $17A824
        DC.W    $0014,$7970         ; $17A826 ORI.B  #$7970,(A4)
        DC.W    $02B0,$0000,$006A,$0000; $17A82A ANDI.L  #$0000006A,$00(A0,D0.W)
        DC.W    $02F0               ; $17A832 DC.W    $02F0
        DC.W    $0000,$02EA         ; $17A834 ORI.B  #$02EA,D0
        DC.W    $0000,$0000         ; $17A838 ORI.B  #$0000,D0
        DC.W    $0013,$1404         ; $17A83C ORI.B  #$1404,(A3)
        BTST    D1,D0                           ; $17A840
        DC.W    $0013,$6970         ; $17A842 ORI.B  #$6970,(A3)
        DC.W    $02B0,$0000,$0400,$0000; $17A846 ANDI.L  #$00000400,$00(A0,D0.W)
        DC.W    $02F0               ; $17A84E DC.W    $02F0
        DC.W    $0000,$006A         ; $17A850 ORI.B  #$006A,D0
        DC.W    $0000,$0000         ; $17A854 ORI.B  #$0000,D0
        DC.W    $0003,$143A         ; $17A858 ORI.B  #$143A,D3
        BTST    D1,D0                           ; $17A85C
        DC.W    $0012,$0003         ; $17A85E ORI.B  #$0003,(A2)
loc_17A862:
        MOVE.L  (A0),-(A4)                      ; $17A862
        BTST    D0,(A7)+                        ; $17A864
        ANDI.L  #$04000000,(A7)+                ; $17A866
        SUBI.B  #$0000,D0                       ; $17A86C
        MOVE.W  -(A1),(A7)+                     ; $17A870
        ANDI.W  #$FFF5,A1                       ; $17A872
        DC.W    $FFEC,$198C         ; $17A876 MOVE.W  $198C(A4),<EA:3F>
        BTST    D0,D0                           ; $17A87A
        BMI.S  loc_17A8D4                       ; $17A87C
        MOVE.L  -(A0),-(A0)                     ; $17A87E
        BTST    D0,(A7)+                        ; $17A880
        ANDI.L  #$FEE10249,(A7)+                ; $17A882
        SUBI.B  #$0000,D0                       ; $17A888
        SUBI.B  #$0000,D0                       ; $17A88C
        DC.W    $FFF5,$FFED         ; $17A890 MOVE.W  -$13(A5,A7.L),<EA:3F>
        MOVE.B  A2,$00(A4,D0.W)                 ; $17A894
        BMI.S  loc_17A8EF                       ; $17A898
        MOVE.L  -(A0),D1                        ; $17A89A
        BTST    D0,(A7)+                        ; $17A89C
        ANDI.W  #$FEE1,$0249(A0)                ; $17A89E
        BTST    D0,(A7)+                        ; $17A8A4
        ANDI.L  #$04000000,(A7)+                ; $17A8A6
        DC.W    $FFF5,$FFED         ; $17A8AC MOVE.W  -$13(A5,A7.L),<EA:3F>
        MOVE.B  A2,$00(A4,D0.W)                 ; $17A8B0
        BMI.S  loc_17A90B                       ; $17A8B4
        MOVE.L  (A0),D5                         ; $17A8B6
        BTST    D0,(A7)+                        ; $17A8B8
        ANDI.W  #$0400,$0000(A0)                ; $17A8BA
        BTST    D0,(A7)+                        ; $17A8C0
        ANDI.L  #$FEE10249,(A7)+                ; $17A8C2
        DC.W    $FFF5,$FFEC         ; $17A8C8 MOVE.W  -$14(A5,A7.L),<EA:3F>
        MOVE.B  A4,$00(A4,D0.W)                 ; $17A8CC
        BMI.S  loc_17A928                       ; $17A8D0
        DC.W    $0007,$4910         ; $17A8D2 ORI.B  #$4910,D7
        SUBI.B  #$0000,D0                       ; $17A8D6
        SUBI.B  #$0000,D0                       ; $17A8DA
        SUBI.B  #$0000,D0                       ; $17A8DE
        MOVE.W  -(A1),(A7)+                     ; $17A8E2
        DC.W    $000A,$FFF5         ; $17A8E4 ORI.B  #$FFF5,A2
        DC.W    $FFEC,$1824         ; $17A8E8 MOVE.W  $1824(A4),<EA:3F>
        BTST    D0,D0                           ; $17A8EC
        BMI.S  loc_17A946                       ; $17A8EE
        MOVE.L  (A0),D1                         ; $17A8F0
        BTST    D0,(A7)+                        ; $17A8F2
        MOVE.W  -(A0),(A7)                      ; $17A8F4
        MOVE.W  -(A1),(A7)+                     ; $17A8F6
        DC.W    $000A,$011F         ; $17A8F8 ORI.B  #$011F,A2
        DC.W    $02EC               ; $17A8FC DC.W    $02EC
        MOVE.W  -(A1),(A7)+                     ; $17A8FE
        DC.W    $02E8               ; $17A900 DC.W    $02E8
        DC.W    $FFF5,$FFED         ; $17A902 MOVE.W  -$13(A5,A7.L),<EA:3F>
        MOVE.B  -(A4),D4                        ; $17A906
        BTST    D0,D0                           ; $17A908
        BMI.S  loc_17A961                       ; $17A90A
        MOVE.L  (A0),D1                         ; $17A90C
        BTST    D0,(A7)+                        ; $17A90E
        MOVE.W  -(A0),(A7)                      ; $17A910
        MOVE.W  -(A1),(A7)+                     ; $17A912
        DC.W    $02E8               ; $17A914 DC.W    $02E8
        BTST    D0,(A7)+                        ; $17A916
        DC.W    $02EC               ; $17A918 DC.W    $02EC
        MOVE.W  -(A2),(A7)+                     ; $17A91A
        BSET    D2,D1                           ; $17A91C
        DC.W    $FFF8,$FFF1         ; $17A91E MOVE.W  $FFF1.W,<EA:3F>
        MOVE.B  $00(A3,D0.W),$54(A3,D6.L)       ; $17A922
loc_17A928:
        DC.W    $4120               ; $17A928 DC.W    $4120
        SUBI.B  #$0000,D0                       ; $17A92A
        MOVE.W  -(A2),(A7)+                     ; $17A92E
        BSET    D2,D1                           ; $17A930
        SUBI.B  #$0000,D0                       ; $17A932
        SUBI.B  #$0000,D0                       ; $17A936
        DC.W    $FFFC,$FFF8         ; $17A93A MOVE.W  #$FFF8,<EA:3F>
        MOVE.B  D2,(A3)                         ; $17A93E
        BTST    D0,D0                           ; $17A940
        BMI.S  loc_17A997                       ; $17A942
        MOVE.L  (A0),D5                         ; $17A944
loc_17A946:
        BTST    D0,(A7)+                        ; $17A946
        MOVEA.W $0400(A1),A7                    ; $17A948
        DC.W    $0000,$011F         ; $17A94C ORI.B  #$011F,D0
        MOVE.W  -(A0),(A7)                      ; $17A950
        MOVE.W  -(A1),(A7)+                     ; $17A952
        DC.W    $02E8               ; $17A954 DC.W    $02E8
        DC.W    $FFF5,$FFED         ; $17A956 MOVE.W  -$13(A5,A7.L),<EA:3F>
        MOVE.B  -(A4),D4                        ; $17A95A
        DC.W    $0200,$6B55         ; $17A95C ANDI.B  #$6B55,D0
        MOVE.L  -(A0),D1                        ; $17A960
        BTST    D0,(A7)+                        ; $17A962
        MOVEA.W -$011F(A1),A7                   ; $17A964
        DC.W    $02E8               ; $17A968 DC.W    $02E8
        BTST    D0,(A7)+                        ; $17A96A
        MOVE.W  -(A0),(A7)                      ; $17A96C
        SUBI.B  #$0000,D0                       ; $17A96E
        DC.W    $FFF8,$FFF1         ; $17A972 MOVE.W  $FFF1.W,<EA:3F>
        MOVE.B  $00(A4,D0.W),$54(A3,D6.L)       ; $17A976
        MOVE.L  -(A0),D1                        ; $17A97C
        BTST    D0,(A7)+                        ; $17A97E
        DC.W    $02EC               ; $17A980 DC.W    $02EC
        MOVE.W  -(A1),(A7)+                     ; $17A982
        DC.W    $02E8               ; $17A984 DC.W    $02E8
        BTST    D0,(A7)+                        ; $17A986
        BTST    D1,-(A3)                        ; $17A988
        SUBI.B  #$0000,D0                       ; $17A98A
        DC.W    $FFF8,$FFF1         ; $17A98E MOVE.W  $FFF1.W,<EA:3F>
        MOVE.B  $00(A2,D0.W),$54(A3,D6.L)       ; $17A992
        MOVE.L  (A0),D5                         ; $17A998
        BTST    D0,(A7)+                        ; $17A99A
        DC.W    $02EC               ; $17A99C DC.W    $02EC
        SUBI.B  #$0000,D0                       ; $17A99E
        BTST    D0,(A7)+                        ; $17A9A2
        BTST    D1,-(A3)                        ; $17A9A4
        MOVE.W  -(A1),(A7)+                     ; $17A9A6
        DC.W    $02E8               ; $17A9A8 DC.W    $02E8
        DC.W    $FFF5,$FFED         ; $17A9AA MOVE.W  -$13(A5,A7.L),<EA:3F>
        MOVE.B  -(A4),D4                        ; $17A9AE
        DC.W    $0200,$6B55         ; $17A9B0 ANDI.B  #$6B55,D0
        DC.W    $0003,$4A10         ; $17A9B4 ORI.B  #$4A10,D3
        SUBI.B  #$0000,D0                       ; $17A9B8
        SUBI.B  #$0000,D0                       ; $17A9BC
        BTST    D0,(A7)+                        ; $17A9C0
        MOVE.W  -$011E(A5),(A7)+                ; $17A9C2
        BCLR    D1,D4                           ; $17A9C6
        DC.W    $FFF8,$FFF1         ; $17A9C8 MOVE.W  $FFF1.W,<EA:3F>
        MOVE.B  -(A4),(A3)                      ; $17A9CC
        BTST    D0,D0                           ; $17A9CE
        BMI.S  loc_17AA26                       ; $17A9D0
        CLR.B  -(A0)                            ; $17A9D2
        SUBI.B  #$0000,D0                       ; $17A9D4
        MOVE.W  -(A2),(A7)+                     ; $17A9D8
        BCLR    D1,D4                           ; $17A9DA
        BTST    D0,(A7)+                        ; $17A9DC
        MOVE.W  $0400(A5),(A7)+                 ; $17A9DE
        DC.W    $0000,$FFFC         ; $17A9E2 ORI.B  #$FFFC,D0
        DC.W    $FFF8,$15ED         ; $17A9E6 MOVE.W  $15ED.W,<EA:3F>
        BTST    D0,D0                           ; $17A9EA
        BMI.S  loc_17AA41                       ; $17A9EC
        MOVE.L  (A0),D5                         ; $17A9EE
        BTST    D0,(A7)+                        ; $17A9F0
        MOVE.W  $0400(A5),(A7)+                 ; $17A9F2
        DC.W    $0000,$011F         ; $17A9F6 ORI.B  #$011F,D0
        MOVE.W  -(A4),-(A7)                     ; $17A9FA
        MOVE.W  -(A2),(A7)+                     ; $17A9FC
        BCLR    D1,D4                           ; $17A9FE
        DC.W    $FFF8,$FFF1         ; $17AA00 MOVE.W  $FFF1.W,<EA:3F>
        MOVE.B  -(A4),(A3)                      ; $17AA04
        DC.W    $0200,$6B54         ; $17AA06 ANDI.B  #$6B54,D0
        MOVE.L  -(A0),D1                        ; $17AA0A
        BTST    D0,(A7)+                        ; $17AA0C
        MOVE.W  -$011E(A5),(A7)+                ; $17AA0E
        BCLR    D1,D4                           ; $17AA12
        BTST    D0,(A7)+                        ; $17AA14
        MOVE.W  -(A4),-(A7)                     ; $17AA16
        SUBI.B  #$0000,D0                       ; $17AA18
        DC.W    $FFFC,$FFF8         ; $17AA1C MOVE.W  #$FFF8,<EA:3F>
        MOVE.B  -(A7),$0200(PC)                 ; $17AA20
        BMI.S  loc_17AA79                       ; $17AA24
loc_17AA26:
        DC.W    $0008,$7920         ; $17AA26 ORI.B  #$7920,A0
        DC.W    $02C0               ; $17AA2A DC.W    $02C0
        DC.W    $0000,$03EA         ; $17AA2C ORI.B  #$03EA,D0
        DC.W    $0000,$0400         ; $17AA30 ORI.B  #$0400,D0
        DC.W    $0000,$0400         ; $17AA34 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17AA38 ORI.B  #$0000,D0
        DC.W    $0018,$16A8         ; $17AA3C ORI.B  #$16A8,(A0)+
        BTST    D0,D0                           ; $17AA40
        DC.W    $0016,$7970         ; $17AA42 ORI.B  #$7970,(A6)
        DC.W    $02C0               ; $17AA46 DC.W    $02C0
        DC.W    $0000,$016A         ; $17AA48 ORI.B  #$016A,D0
        DC.W    $0000,$0400         ; $17AA4C ORI.B  #$0400,D0
        DC.W    $0000,$03EA         ; $17AA50 ORI.B  #$03EA,D0
        DC.W    $0000,$0000         ; $17AA54 ORI.B  #$0000,D0
        DC.W    $0018,$16A8         ; $17AA58 ORI.B  #$16A8,(A0)+
        BTST    D0,D0                           ; $17AA5C
        DC.W    $0015,$6970         ; $17AA5E ORI.B  #$6970,(A5)
        DC.W    $02C0               ; $17AA62 DC.W    $02C0
        DC.W    $0000,$0400         ; $17AA64 ORI.B  #$0400,D0
        DC.W    $0000,$0400         ; $17AA68 ORI.B  #$0400,D0
        DC.W    $0000,$016A         ; $17AA6C ORI.B  #$016A,D0
        DC.W    $0000,$0000         ; $17AA70 ORI.B  #$0000,D0
        DC.W    $0018,$16A8         ; $17AA74 ORI.B  #$16A8,(A0)+
        BTST    D0,D0                           ; $17AA78
        DC.W    $0014,$7920         ; $17AA7A ORI.B  #$7920,(A4)
        ANDI.L  #$000003EA,(A0)                 ; $17AA7E
        DC.W    $0000,$02C0         ; $17AA84 ORI.B  #$02C0,D0
        DC.W    $0000,$0400         ; $17AA88 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17AA8C ORI.B  #$0000,D0
        DC.W    $0018,$16A8         ; $17AA90 ORI.B  #$16A8,(A0)+
        DC.W    $0200,$0016         ; $17AA94 ANDI.B  #$0016,D0
        MOVE.W  -$70(A0,D0.W),$0000(A4)         ; $17AA98
        BCHG    D0,$0000(A2)                    ; $17AA9E
        DC.W    $02C0               ; $17AAA2 DC.W    $02C0
        DC.W    $0000,$03EA         ; $17AAA4 ORI.B  #$03EA,D0
        DC.W    $0000,$0000         ; $17AAA8 ORI.B  #$0000,D0
        DC.W    $0018,$16A8         ; $17AAAC ORI.B  #$16A8,(A0)+
        DC.W    $0200,$0015         ; $17AAB0 ANDI.B  #$0015,D0
        BVS.S  loc_17AB26                       ; $17AAB4
        ANDI.L  #$00000400,(A0)                 ; $17AAB6
        DC.W    $0000,$02C0         ; $17AABC ORI.B  #$02C0,D0
        DC.W    $0000,$016A         ; $17AAC0 ORI.B  #$016A,D0
        DC.W    $0000,$0000         ; $17AAC4 ORI.B  #$0000,D0
        DC.W    $0018,$16A8         ; $17AAC8 ORI.B  #$16A8,(A0)+
        DC.W    $0200,$0014         ; $17AACC ANDI.B  #$0014,D0
        MOVE.W  -(A0),-(A4)                     ; $17AAD0
        ANDI.W  #$0000,(A0)                     ; $17AAD2
        BSET    D1,$0000(A2)                    ; $17AAD6
        ANDI.L  #$00000400,(A0)                 ; $17AADA
        DC.W    $0000,$0000         ; $17AAE0 ORI.B  #$0000,D0
        DC.W    $0018,$16A8         ; $17AAE4 ORI.B  #$16A8,(A0)+
        BTST    D1,D0                           ; $17AAE8
        DC.W    $0016,$7970         ; $17AAEA ORI.B  #$7970,(A6)
        ANDI.W  #$0000,(A0)                     ; $17AAEE
        BCHG    D0,$0000(A2)                    ; $17AAF2
        ANDI.L  #$000003EA,(A0)                 ; $17AAF6
        DC.W    $0000,$0000         ; $17AAFC ORI.B  #$0000,D0
        DC.W    $0018,$16A8         ; $17AB00 ORI.B  #$16A8,(A0)+
        BTST    D1,D0                           ; $17AB04
        DC.W    $0015,$6970         ; $17AB06 ORI.B  #$6970,(A5)
        ANDI.W  #$0000,(A0)                     ; $17AB0A
        SUBI.B  #$0000,D0                       ; $17AB0E
        ANDI.L  #$0000016A,(A0)                 ; $17AB12
        DC.W    $0000,$0000         ; $17AB18 ORI.B  #$0000,D0
        DC.W    $0018,$16A8         ; $17AB1C ORI.B  #$16A8,(A0)+
        BTST    D1,D0                           ; $17AB20
        DC.W    $0014,$0008         ; $17AB22 ORI.B  #$0008,(A4)
loc_17AB26:
        SUBQ.B  #4,-(A0)                        ; $17AB26
        SUBI.B  #$0000,D0                       ; $17AB28
        BSET    D1,$0000(A2)                    ; $17AB2C
        ANDI.L  #$00000400,D0                   ; $17AB30
        DC.W    $0000,$0000         ; $17AB36 ORI.B  #$0000,D0
        DC.W    $0018,$16A8         ; $17AB3A ORI.B  #$16A8,(A0)+
        BTST    D0,D0                           ; $17AB3E
        DC.W    $0016,$5970         ; $17AB40 ORI.B  #$5970,(A6)
        SUBI.B  #$0000,D0                       ; $17AB44
        BCHG    D0,$0000(A2)                    ; $17AB48
        ANDI.L  #$000003EA,D0                   ; $17AB4C
        DC.W    $0000,$0000         ; $17AB52 ORI.B  #$0000,D0
        DC.W    $0018,$16A8         ; $17AB56 ORI.B  #$16A8,(A0)+
        BTST    D0,D0                           ; $17AB5A
        DC.W    $0015,$4970         ; $17AB5C ORI.B  #$4970,(A5)
        SUBI.B  #$0000,D0                       ; $17AB60
        SUBI.B  #$0000,D0                       ; $17AB64
        ANDI.L  #$0000016A,D0                   ; $17AB68
        DC.W    $0000,$0000         ; $17AB6E ORI.B  #$0000,D0
        DC.W    $0018,$16A8         ; $17AB72 ORI.B  #$16A8,(A0)+
        BTST    D0,D0                           ; $17AB76
        DC.W    $0014,$7920         ; $17AB78 ORI.B  #$7920,(A4)
        ANDI.L  #$000003EA,D0                   ; $17AB7C
        DC.W    $0000,$02B0         ; $17AB82 ORI.B  #$02B0,D0
        DC.W    $0000,$0400         ; $17AB86 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17AB8A ORI.B  #$0000,D0
        DC.W    $0018,$16A8         ; $17AB8E ORI.B  #$16A8,(A0)+
        DC.W    $0200,$0016         ; $17AB92 ANDI.B  #$0016,D0
        MOVE.W  -$80(A0,D0.W),$0000(A4)         ; $17AB96
        BCHG    D0,$0000(A2)                    ; $17AB9C
        DC.W    $02B0,$0000,$03EA,$0000; $17ABA0 ANDI.L  #$000003EA,$00(A0,D0.W)
        DC.W    $0000,$0018         ; $17ABA8 ORI.B  #$0018,D0
        MOVE.B  $0200(A0),(A3)                  ; $17ABAC
        DC.W    $0015,$6970         ; $17ABB0 ORI.B  #$6970,(A5)
        ANDI.L  #$00000400,D0                   ; $17ABB4
        DC.W    $0000,$02B0         ; $17ABBA ORI.B  #$02B0,D0
        DC.W    $0000,$016A         ; $17ABBE ORI.B  #$016A,D0
        DC.W    $0000,$0000         ; $17ABC2 ORI.B  #$0000,D0
        DC.W    $0018,$16A8         ; $17ABC6 ORI.B  #$16A8,(A0)+
        DC.W    $0200,$0014         ; $17ABCA ANDI.B  #$0014,D0
        MOVE.W  -(A0),-(A4)                     ; $17ABCE
        DC.W    $02B0,$0000,$03EA,$0000; $17ABD0 ANDI.L  #$000003EA,$00(A0,D0.W)
        DC.W    $02F0               ; $17ABD8 DC.W    $02F0
        DC.W    $0000,$0400         ; $17ABDA ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17ABDE ORI.B  #$0000,D0
        DC.W    $0018,$16A8         ; $17ABE2 ORI.B  #$16A8,(A0)+
        BTST    D1,D0                           ; $17ABE6
        DC.W    $0016,$7970         ; $17ABE8 ORI.B  #$7970,(A6)
        DC.W    $02B0,$0000,$016A,$0000; $17ABEC ANDI.L  #$0000016A,$00(A0,D0.W)
        DC.W    $02F0               ; $17ABF4 DC.W    $02F0
        DC.W    $0000,$03EA         ; $17ABF6 ORI.B  #$03EA,D0
        DC.W    $0000,$0000         ; $17ABFA ORI.B  #$0000,D0
        DC.W    $0018,$16A8         ; $17ABFE ORI.B  #$16A8,(A0)+
        BTST    D1,D0                           ; $17AC02
        DC.W    $0015,$6970         ; $17AC04 ORI.B  #$6970,(A5)
        DC.W    $02B0,$0000,$0400,$0000; $17AC08 ANDI.L  #$00000400,$00(A0,D0.W)
        DC.W    $02F0               ; $17AC10 DC.W    $02F0
        DC.W    $0000,$016A         ; $17AC12 ORI.B  #$016A,D0
        DC.W    $0000,$0000         ; $17AC16 ORI.B  #$0000,D0
        DC.W    $0018,$16A8         ; $17AC1A ORI.B  #$16A8,(A0)+
        BTST    D1,D0                           ; $17AC1E
        DC.W    $0014,$0005         ; $17AC20 ORI.B  #$0005,(A4)
        MOVE.L  (A0),-(A4)                      ; $17AC24
        BTST    D0,(A7)+                        ; $17AC26
        DC.W    $00DE               ; $17AC28 DC.W    $00DE
        SUBI.B  #$0000,D0                       ; $17AC2A
        SUBI.B  #$0000,D0                       ; $17AC2E
        MOVE.W  -(A2),(A7)+                     ; $17AC32
        BSET    D0,D1                           ; $17AC34
        DC.W    $FFF8,$FFF1         ; $17AC36 MOVE.W  $FFF1.W,<EA:3F>
        MOVE.B  (A0),$0100(PC)                  ; $17AC3A
        BMI.S  loc_17AC94                       ; $17AC3E
        MOVE.L  (A0),-(A0)                      ; $17AC40
        BTST    D0,-(A0)                        ; $17AC42
        DC.W    $00DE               ; $17AC44 DC.W    $00DE
        MOVE.W  -(A2),(A7)+                     ; $17AC46
        BSET    D0,D1                           ; $17AC48
        SUBI.B  #$0000,D0                       ; $17AC4A
        MOVE.W  $50(A1,D0.W),(A7)+              ; $17AC4E
        DC.W    $FFFC,$FFF8         ; $17AC52 MOVE.W  #$FFF8,<EA:3F>
        MOVE.B  $00(A1,D0.W),$6B53(A2)          ; $17AC56
        MOVE.L  -(A0),-(A0)                     ; $17AC5C
        BTST    D0,(A5)                         ; $17AC5E
        DC.W    $00EE               ; $17AC60 DC.W    $00EE
        MOVE.W  $50(A1,D0.W),(A7)+              ; $17AC62
        SUBI.B  #$0000,D0                       ; $17AC66
        SUBI.B  #$0000,D0                       ; $17AC6A
        DC.W    $FFFE               ; $17AC6E MOVE.W  <EA:3E>,<EA:3F>
        DC.W    $FFFD               ; $17AC70 MOVE.W  <EA:3D>,<EA:3F>
        MOVE.B  A4,(A2)+                        ; $17AC72
        BTST    D0,D0                           ; $17AC74
        BMI.S  loc_17ACCA                       ; $17AC76
        MOVE.L  (A0),D1                         ; $17AC78
        BTST    D0,-(A0)                        ; $17AC7A
        ORI.L  #$FEE201C1,-(A7)                 ; $17AC7C
        BTST    D0,-(A0)                        ; $17AC82
        DC.W    $00DE               ; $17AC84 DC.W    $00DE
        MOVE.W  $50(A1,D0.W),(A7)+              ; $17AC86
        DC.W    $FFFC,$FFF8         ; $17AC8A MOVE.W  #$FFF8,<EA:3F>
        MOVE.B  $00(A5,D0.W),$6B53(A2)          ; $17AC8E
loc_17AC94:
        MOVE.L  -(A0),D1                        ; $17AC94
        BTST    D0,(A5)                         ; $17AC96
        DC.W    $00B8,$FEF1,$0450,$0115; $17AC98 ORI.L  #$FEF10450,$0115.W
        DC.W    $00EE               ; $17ACA0 DC.W    $00EE
        SUBI.B  #$0000,D0                       ; $17ACA2
        DC.W    $FFFE               ; $17ACA6 MOVE.W  <EA:3E>,<EA:3F>
        DC.W    $FFFC,$14D4         ; $17ACA8 MOVE.W  #$14D4,<EA:3F>
        DC.W    $0200,$6B52         ; $17ACAC ANDI.B  #$6B52,D0
        MOVE.L  (A0),D5                         ; $17ACB0
        BTST    D0,(A7)+                        ; $17ACB2
        ORI.L  #$04000000,-(A7)                 ; $17ACB4
        BTST    D0,(A7)+                        ; $17ACBA
        DC.W    $00DE               ; $17ACBC DC.W    $00DE
        MOVE.W  -(A2),(A7)+                     ; $17ACBE
        BSET    D0,D1                           ; $17ACC0
        DC.W    $FFF8,$FFF1         ; $17ACC2 MOVE.W  $FFF1.W,<EA:3F>
        MOVE.B  (A0),$0200(PC)                  ; $17ACC6
loc_17ACCA:
        BMI.S  loc_17AD20                       ; $17ACCA
        DC.W    $0005,$4220         ; $17ACCC ORI.B  #$4220,D5
        SUBI.B  #$0000,D0                       ; $17ACD0
        MOVE.W  A6,-(A7)                        ; $17ACD4
        SUBI.W  #$00DA,D0                       ; $17ACD6
        BCLR    D0,D6                           ; $17ACDA
        SUBI.B  #$0000,D0                       ; $17ACDC
        DC.W    $0000,$0000         ; $17ACE0 ORI.B  #$0000,D0
        MOVE.B  A4,D2                           ; $17ACE4
        BTST    D0,D0                           ; $17ACE6
        BLE.S  loc_17AD3B                       ; $17ACE8
        TST.B  (A0)                             ; $17ACEA
        SUBI.B  #$0000,D0                       ; $17ACEC
        SUBI.B  #$0000,D0                       ; $17ACF0
        BTST    D0,(A7)+                        ; $17ACF4
        BTST    D0,-$010F(A3)                   ; $17ACF6
        DC.W    $0232,$FFFC,$FFF8   ; $17ACFA ANDI.B  #$FFFC,-$08(A2,A7.L)
        MOVE.B  (A4)+,(A2)+                     ; $17AD00
        BTST    D0,D0                           ; $17AD02
        BMI.S  loc_17AD59                       ; $17AD04
        CLR.B  (A0)                             ; $17AD06
        SUBI.B  #$0000,D0                       ; $17AD08
        MOVE.W  $32(A1,D0.W),(A7)+              ; $17AD0C
        BTST    D0,(A2)                         ; $17AD10
        BTST    D0,$0E(A3,A7.L)                 ; $17AD12
        SUBI.W  #$FFFE,D0                       ; $17AD16
        DC.W    $FFFD               ; $17AD1A MOVE.W  <EA:3D>,<EA:3F>
        MOVE.B  A4,(A2)                         ; $17AD1C
        BTST    D0,D0                           ; $17AD1E
loc_17AD20:
        BMI.S  loc_17AD74                       ; $17AD20
        MOVE.L  (A0),D1                         ; $17AD22
        BTST    D0,(A2)                         ; $17AD24
        BTST    D0,-$0F(A3,A7.L)                ; $17AD26
        DC.W    $0232,$0112,$016A   ; $17AD2A ANDI.B  #$0112,$6A(A2,D0.W)
        MOVE.W  A6,-(A7)                        ; $17AD30
        DC.W    $043F,$FFFF         ; $17AD32 SUBI.B  #$FFFF,<EA:3F>
        DC.W    $FFFD               ; $17AD36 MOVE.W  <EA:3D>,<EA:3F>
        MOVE.B  D7,(A2)                         ; $17AD38
        DC.W    $0200,$6B52         ; $17AD3A ANDI.B  #$6B52,D0
        MOVE.L  -(A0),D1                        ; $17AD3E
        DC.W    $00DA               ; $17AD40 DC.W    $00DA
        BCLR    D0,D6                           ; $17AD42
        MOVE.W  A6,-(A7)                        ; $17AD44
        DC.W    $043F,$00D9         ; $17AD46 SUBI.B  #$00D9,<EA:3F>
        BCLR    D0,$00(PC,D0.W)                 ; $17AD4A
        DC.W    $0000,$0000         ; $17AD4E ORI.B  #$0000,D0
        DC.W    $0000,$140B         ; $17AD52 ORI.B  #$140B,D0
        DC.W    $0200,$6F51         ; $17AD56 ANDI.B  #$6F51,D0
        MOVE.L  (A0),D5                         ; $17AD5A
        BTST    D0,(A7)+                        ; $17AD5C
        BTST    D0,$0400(A3)                    ; $17AD5E
        DC.W    $0000,$011F         ; $17AD62 ORI.B  #$011F,D0
        BCHG    D0,-(A2)                        ; $17AD66
        MOVE.W  $32(A1,D0.W),(A7)+              ; $17AD68
        DC.W    $FFFC,$FFF8         ; $17AD6C MOVE.W  #$FFF8,<EA:3F>
        MOVE.B  (A3)+,(A2)+                     ; $17AD70
        DC.W    $0200,$6B53         ; $17AD72 ANDI.B  #$6B53,D0
        DC.W    $0005,$7920         ; $17AD76 ORI.B  #$7920,D5
        DC.W    $02C0               ; $17AD7A DC.W    $02C0
        DC.W    $0000,$026A         ; $17AD7C ORI.B  #$026A,D0
        DC.W    $0000,$0400         ; $17AD80 ORI.B  #$0400,D0
        DC.W    $0000,$0400         ; $17AD84 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17AD88 ORI.B  #$0000,D0
        DC.W    $0018,$19C2         ; $17AD8C ORI.B  #$19C2,(A0)+
        BTST    D0,D0                           ; $17AD90
        DC.W    $0017,$6970         ; $17AD92 ORI.B  #$6970,(A7)
        DC.W    $02C0               ; $17AD96 DC.W    $02C0
        DC.W    $0000,$0400         ; $17AD98 ORI.B  #$0400,D0
        DC.W    $0000,$0400         ; $17AD9C ORI.B  #$0400,D0
        DC.W    $0000,$026A         ; $17ADA0 ORI.B  #$026A,D0
        DC.W    $0000,$0000         ; $17ADA4 ORI.B  #$0000,D0
        DC.W    $0018,$19C2         ; $17ADA8 ORI.B  #$19C2,(A0)+
        BTST    D0,D0                           ; $17ADAC
        DC.W    $0016,$7920         ; $17ADAE ORI.B  #$7920,(A6)
        ANDI.L  #$0000026A,(A0)                 ; $17ADB2
        DC.W    $0000,$02C0         ; $17ADB8 ORI.B  #$02C0,D0
        DC.W    $0000,$0400         ; $17ADBC ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17ADC0 ORI.B  #$0000,D0
        DC.W    $0018,$19C2         ; $17ADC4 ORI.B  #$19C2,(A0)+
        DC.W    $0200,$0017         ; $17ADC8 ANDI.B  #$0017,D0
        BVS.S  loc_17AE3E                       ; $17ADCC
        ANDI.L  #$00000400,(A0)                 ; $17ADCE
        DC.W    $0000,$02C0         ; $17ADD4 ORI.B  #$02C0,D0
        DC.W    $0000,$026A         ; $17ADD8 ORI.B  #$026A,D0
        DC.W    $0000,$0000         ; $17ADDC ORI.B  #$0000,D0
        DC.W    $0018,$19C2         ; $17ADE0 ORI.B  #$19C2,(A0)+
        DC.W    $0200,$0016         ; $17ADE4 ANDI.B  #$0016,D0
        BVS.S  loc_17AE5A                       ; $17ADE8
        ANDI.W  #$0000,(A0)                     ; $17ADEA
        SUBI.B  #$0000,D0                       ; $17ADEE
        ANDI.L  #$0000026A,(A0)                 ; $17ADF2
        DC.W    $0000,$0000         ; $17ADF8 ORI.B  #$0000,D0
        DC.W    $0018,$19C2         ; $17ADFC ORI.B  #$19C2,(A0)+
        BTST    D1,D0                           ; $17AE00
        DC.W    $0016,$7920         ; $17AE02 ORI.B  #$7920,(A6)
        ANDI.W  #$0000,(A0)                     ; $17AE06
        ANDI.W  #$0000,$0290(A2)                ; $17AE0A
        DC.W    $0000,$0400         ; $17AE10 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17AE14 ORI.B  #$0000,D0
        DC.W    $0018,$19C2         ; $17AE18 ORI.B  #$19C2,(A0)+
        BTST    D1,D0                           ; $17AE1C
        DC.W    $0017,$0005         ; $17AE1E ORI.B  #$0005,(A7)
        SUBQ.B  #4,-(A0)                        ; $17AE22
        SUBI.B  #$0000,D0                       ; $17AE24
        ANDI.W  #$0000,$0280(A2)                ; $17AE28
        DC.W    $0000,$0400         ; $17AE2E ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17AE32 ORI.B  #$0000,D0
        DC.W    $0018,$19C2         ; $17AE36 ORI.B  #$19C2,(A0)+
        BTST    D0,D0                           ; $17AE3A
        DC.W    $0017,$4970         ; $17AE3C ORI.B  #$4970,(A7)
        SUBI.B  #$0000,D0                       ; $17AE40
        SUBI.B  #$0000,D0                       ; $17AE44
        ANDI.L  #$0000026A,D0                   ; $17AE48
        DC.W    $0000,$0000         ; $17AE4E ORI.B  #$0000,D0
        DC.W    $0018,$19C2         ; $17AE52 ORI.B  #$19C2,(A0)+
        BTST    D0,D0                           ; $17AE56
        DC.W    $0016,$7920         ; $17AE58 ORI.B  #$7920,(A6)
        ANDI.L  #$0000026A,D0                   ; $17AE5C
        DC.W    $0000,$02B0         ; $17AE62 ORI.B  #$02B0,D0
        DC.W    $0000,$0400         ; $17AE66 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17AE6A ORI.B  #$0000,D0
        DC.W    $0018,$19C2         ; $17AE6E ORI.B  #$19C2,(A0)+
        DC.W    $0200,$0017         ; $17AE72 ANDI.B  #$0017,D0
        BVS.S  loc_17AEE8                       ; $17AE76
        ANDI.L  #$00000400,D0                   ; $17AE78
        DC.W    $0000,$02B0         ; $17AE7E ORI.B  #$02B0,D0
        DC.W    $0000,$026A         ; $17AE82 ORI.B  #$026A,D0
        DC.W    $0000,$0000         ; $17AE86 ORI.B  #$0000,D0
        DC.W    $0018,$19C2         ; $17AE8A ORI.B  #$19C2,(A0)+
        DC.W    $0200,$0016         ; $17AE8E ANDI.B  #$0016,D0
        MOVE.W  -(A0),-(A4)                     ; $17AE92
        DC.W    $02B0,$0000,$026A,$0000; $17AE94 ANDI.L  #$0000026A,$00(A0,D0.W)
        DC.W    $02F0               ; $17AE9C DC.W    $02F0
        DC.W    $0000,$0400         ; $17AE9E ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17AEA2 ORI.B  #$0000,D0
        DC.W    $0018,$19C2         ; $17AEA6 ORI.B  #$19C2,(A0)+
        BTST    D1,D0                           ; $17AEAA
        DC.W    $0017,$6970         ; $17AEAC ORI.B  #$6970,(A7)
        DC.W    $02B0,$0000,$0400,$0000; $17AEB0 ANDI.L  #$00000400,$00(A0,D0.W)
        DC.W    $02F0               ; $17AEB8 DC.W    $02F0
        DC.W    $0000,$026A         ; $17AEBA ORI.B  #$026A,D0
        DC.W    $0000,$0000         ; $17AEBE ORI.B  #$0000,D0
        DC.W    $0018,$19C2         ; $17AEC2 ORI.B  #$19C2,(A0)+
        BTST    D1,D0                           ; $17AEC6
        DC.W    $0016,$0005         ; $17AEC8 ORI.B  #$0005,(A6)
        MOVE.L  -(A0),-(A0)                     ; $17AECC
        ORI.L  #$0371FF4B,A6                    ; $17AECE
        BTST    D1,$0400(A3)                    ; $17AED4
        DC.W    $0000,$0400         ; $17AED8 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17AEDC ORI.B  #$0000,D0
        DC.W    $0000,$1400         ; $17AEE0 ORI.B  #$1400,D0
        BTST    D0,D0                           ; $17AEE4
        MOVE.W  (A0),-$5EF0(A2)                 ; $17AEE6
        DC.W    $00E3               ; $17AEEA DC.W    $00E3
        BTST    D1,-(A6)                        ; $17AEEC
        MOVE.W  A6,-(A7)                        ; $17AEEE
        DC.W    $0225,$0400         ; $17AEF0 ANDI.B  #$0400,-(A5)
        DC.W    $0000,$FF4B         ; $17AEF4 ORI.B  #$FF4B,D0
        BTST    D1,$0000(A3)                    ; $17AEF8
        DC.W    $0000,$1407         ; $17AEFC ORI.B  #$1407,D0
        BTST    D0,D0                           ; $17AF00
        BLE.S  loc_17AF55                       ; $17AF02
        MOVE.L  (A0),-(A4)                      ; $17AF04
        BTST    D0,(A5)                         ; $17AF06
        BTST    D1,(A1)+                        ; $17AF08
        SUBI.B  #$0000,D0                       ; $17AF0A
        SUBI.B  #$0000,D0                       ; $17AF0E
        MOVE.W  A6,-(A7)                        ; $17AF12
        DC.W    $0225,$FFFE         ; $17AF14 ANDI.B  #$FFFE,-(A5)
        DC.W    $FFFD               ; $17AF18 MOVE.W  <EA:3D>,<EA:3F>
        MOVEA.B A4,A2                           ; $17AF1A
        BTST    D0,D0                           ; $17AF1C
        BMI.S  loc_17AF72                       ; $17AF1E
        MOVE.L  (A0),D5                         ; $17AF20
        BTST    D0,(A5)                         ; $17AF22
        DC.W    $02E2               ; $17AF24 DC.W    $02E2
        SUBI.B  #$0000,D0                       ; $17AF26
        BTST    D0,(A5)                         ; $17AF2A
        BTST    D1,(A1)+                        ; $17AF2C
        MOVE.W  A6,-(A7)                        ; $17AF2E
        DC.W    $0225,$FFFE         ; $17AF30 ANDI.B  #$FFFE,-(A5)
        DC.W    $FFFC,$144E         ; $17AF34 MOVE.W  #$144E,<EA:3F>
        DC.W    $0200,$6B52         ; $17AF38 ANDI.B  #$6B52,D0
        MOVE.L  (A0),D1                         ; $17AF3C
        DC.W    $00E4               ; $17AF3E DC.W    $00E4
        DC.W    $02F2               ; $17AF40 DC.W    $02F2
        MOVE.W  A6,-(A7)                        ; $17AF42
        DC.W    $0225,$00E3         ; $17AF44 ANDI.B  #$00E3,-(A5)
        BTST    D1,-(A6)                        ; $17AF48
        MOVE.W  A3,$032A(A7)                    ; $17AF4A
        DC.W    $0000,$0000         ; $17AF4E ORI.B  #$0000,D0
        MOVE.B  A0,D2                           ; $17AF52
        DC.W    $0200,$6E51         ; $17AF54 ANDI.B  #$6E51,D0
        MOVE.L  -(A0),D1                        ; $17AF58
        ORI.L  #$033FFF4B,A7                    ; $17AF5A
        BTST    D1,$008E(A2)                    ; $17AF60
        BCHG    D1,$00(A1,D0.W)                 ; $17AF64
        DC.W    $0000,$0000         ; $17AF68 ORI.B  #$0000,D0
        DC.W    $0000,$1400         ; $17AF6C ORI.B  #$1400,D0
        DC.W    $0200,$7450         ; $17AF70 ANDI.B  #$7450,D0
        DC.W    $0008,$A210         ; $17AF74 ORI.B  #$A210,A0
        ORI.L  #$FF72FF4B,A6                    ; $17AF78
        DC.W    $01BF               ; $17AF7E BCLR    D0,<EA:3F>
        ORI.L  #$0351FFB5,D3                    ; $17AF80
        DC.W    $0309               ; $17AF86 BTST    D1,A1
        DC.W    $0000,$0000         ; $17AF88 ORI.B  #$0000,D0
        MOVE.B  D0,D2                           ; $17AF8C
        BTST    D0,D0                           ; $17AF8E
        MOVE.W  (A0),$4210(A2)                  ; $17AF90
        SUBI.B  #$0000,D0                       ; $17AF94
        MOVE.W  A6,-(A7)                        ; $17AF98
        ORI.W  #$00DA,D0                        ; $17AF9A
        BTST    D1,$4B(PC,A7.L)                 ; $17AF9E
        DC.W    $01BF               ; $17AFA2 BCLR    D0,<EA:3F>
        DC.W    $0000,$0000         ; $17AFA4 ORI.B  #$0000,D0
        MOVE.B  D4,D2                           ; $17AFA8
        BTST    D0,D0                           ; $17AFAA
        BLE.S  loc_17AFFF                       ; $17AFAC
        MOVE.L  -(A0),D1                        ; $17AFAE
        DC.W    $0022,$0013         ; $17AFB0 ORI.B  #$0013,-(A2)
        MOVE.W  $09(A5,D0.W),$25(A7,D0.W)       ; $17AFB4
        BSET    D1,D5                           ; $17AFBA
        SUBI.B  #$0000,D0                       ; $17AFBC
        DC.W    $0000,$0000         ; $17AFC0 ORI.B  #$0000,D0
        DC.W    $13FF,$0100,$7D4F   ; $17AFC4 MOVE.B  <EA:3F>,$01007D4F
        DC.W    $4910               ; $17AFCA DC.W    $4910
        SUBI.B  #$0000,D0                       ; $17AFCC
        SUBI.B  #$0000,D0                       ; $17AFD0
        SUBI.B  #$0000,D0                       ; $17AFD4
        MOVE.W  A6,-(A7)                        ; $17AFD8
        ORI.W  #$FFFE,D0                        ; $17AFDA
        DC.W    $FFFD               ; $17AFDE MOVE.W  <EA:3D>,<EA:3F>
        MOVE.B  A4,D2                           ; $17AFE0
        BTST    D0,D0                           ; $17AFE2
        BMI.S  loc_17B038                       ; $17AFE4
        MOVE.L  (A0),D5                         ; $17AFE6
        ORI.L  #$FF400400,A7                    ; $17AFE8
        DC.W    $0000,$008E         ; $17AFEE ORI.B  #$008E,D0
        MOVE.W  -$4B(A2,A7.L),$0309(A7)         ; $17AFF2
        DC.W    $0000,$0000         ; $17AFF8 ORI.B  #$0000,D0
        MOVE.B  D0,D2                           ; $17AFFC
        DC.W    $0200,$7450         ; $17AFFE ANDI.B  #$7450,D0
        MOVE.L  -(A0),D1                        ; $17B002
        DC.W    $0022,$FFE5         ; $17B004 ORI.B  #$FFE5,-(A2)
        MOVE.W  $09(A5,D0.W),$22(A7,D0.W)       ; $17B008
        DC.W    $0013,$0400         ; $17B00E ORI.B  #$0400,(A3)
        DC.W    $0000,$0000         ; $17B012 ORI.B  #$0000,D0
        DC.W    $0000,$13FE         ; $17B016 ORI.B  #$13FE,D0
        DC.W    $0200,$7D4F         ; $17B01A ANDI.B  #$7D4F,D0
        MOVE.L  (A0),D1                         ; $17B01E
        ORI.L  #$0351FF4B,D3                    ; $17B020
        DC.W    $01BF               ; $17B026 BCLR    D0,<EA:3F>
        ORI.L  #$0382FFB5,D3                    ; $17B028
        DC.W    $0309               ; $17B02E BTST    D1,A1
        DC.W    $0000,$0000         ; $17B030 ORI.B  #$0000,D0
        MOVE.B  D0,D2                           ; $17B034
        DC.W    $0200,$7550         ; $17B036 ANDI.B  #$7550,D0
        MOVE.L  -(A0),-(A0)                     ; $17B03A
        DC.W    $0025,$03C5         ; $17B03C ORI.B  #$03C5,-(A5)
        MOVE.W  $09(A5,D0.W),$00(A7,D0.W)       ; $17B040
        DC.W    $0000,$0400         ; $17B046 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17B04A ORI.B  #$0000,D0
        DC.W    $0000,$13FF         ; $17B04E ORI.B  #$13FF,D0
        DC.W    $0200,$7D4F         ; $17B052 ANDI.B  #$7D4F,D0
        MOVE.L  (A0),D5                         ; $17B056
        DC.W    $00DA               ; $17B058 DC.W    $00DA
        BTST    D1,$00(PC,D0.W)                 ; $17B05A
        DC.W    $0000,$00D9         ; $17B05E ORI.B  #$00D9,D0
        BCHG    D1,-$00B5(A7)                   ; $17B062
        DC.W    $01BF               ; $17B066 BCLR    D0,<EA:3F>
        DC.W    $0000,$0000         ; $17B068 ORI.B  #$0000,D0
        MOVE.B  D3,D2                           ; $17B06C
        DC.W    $0200,$6F51         ; $17B06E ANDI.B  #$6F51,D0
        DC.W    $0002,$4A20         ; $17B072 ORI.B  #$4A20,D2
        SUBI.B  #$0000,D0                       ; $17B076
        SUBI.B  #$0000,D0                       ; $17B07A
        DC.W    $0025,$FFC6         ; $17B07E ORI.B  #$FFC6,-(A5)
        SUBI.B  #$0000,D0                       ; $17B082
        DC.W    $0000,$0000         ; $17B086 ORI.B  #$0000,D0
        DC.W    $13FF,$0100,$7D4F   ; $17B08A MOVE.B  <EA:3F>,$01007D4F
        TST.B  (A0)                             ; $17B090
        SUBI.B  #$0000,D0                       ; $17B092
        SUBI.B  #$0000,D0                       ; $17B096
        ORI.L  #$FF83FFB5,D3                    ; $17B09A
        ANDI.W  #$0000,$00(A2,D0.W)             ; $17B0A0
        MOVE.B  D0,D2                           ; $17B0A6
        DC.W    $0200,$7550         ; $17B0A8 ANDI.B  #$7550,D0
        MOVE.L  -(A0),D1                        ; $17B0AC
        DC.W    $0025,$FFC6         ; $17B0AE ORI.B  #$FFC6,-(A5)
        MOVE.W  $72(A5,D0.W),$25(A7,D0.W)       ; $17B0B2
        DC.W    $FFF6,$0400         ; $17B0B8 MOVE.W  $00(A6,D0.W),<EA:3F>
        DC.W    $0000,$0000         ; $17B0BC ORI.B  #$0000,D0
        DC.W    $0000,$13FF         ; $17B0C0 ORI.B  #$13FF,D0
        DC.W    $0200,$7D4F         ; $17B0C4 ANDI.B  #$7D4F,D0
        DC.W    $0008,$7920         ; $17B0C8 ORI.B  #$7920,A0
        DC.W    $02C0               ; $17B0CC DC.W    $02C0
        DC.W    $0000,$036A         ; $17B0CE ORI.B  #$036A,D0
        DC.W    $0000,$0400         ; $17B0D2 ORI.B  #$0400,D0
        DC.W    $0000,$0400         ; $17B0D6 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17B0DA ORI.B  #$0000,D0
        DC.W    $0009,$1E52         ; $17B0DE ORI.B  #$1E52,A1
        BTST    D0,D0                           ; $17B0E2
        DC.W    $0019,$7970         ; $17B0E4 ORI.B  #$7970,(A1)+
        DC.W    $02C0               ; $17B0E8 DC.W    $02C0
        DC.W    $0000,$00EA         ; $17B0EA ORI.B  #$00EA,D0
        DC.W    $0000,$0400         ; $17B0EE ORI.B  #$0400,D0
        DC.W    $0000,$036A         ; $17B0F2 ORI.B  #$036A,D0
        DC.W    $0000,$0000         ; $17B0F6 ORI.B  #$0000,D0
        DC.W    $0017,$1CE9         ; $17B0FA ORI.B  #$1CE9,(A7)
        BTST    D0,D0                           ; $17B0FE
        DC.W    $0018,$6970         ; $17B100 ORI.B  #$6970,(A0)+
        DC.W    $02C0               ; $17B104 DC.W    $02C0
        DC.W    $0000,$0400         ; $17B106 ORI.B  #$0400,D0
        DC.W    $0000,$0400         ; $17B10A ORI.B  #$0400,D0
        DC.W    $0000,$00EA         ; $17B10E ORI.B  #$00EA,D0
        DC.W    $0000,$0000         ; $17B112 ORI.B  #$0000,D0
        DC.W    $0018,$1CDD         ; $17B116 ORI.B  #$1CDD,(A0)+
        BTST    D0,D0                           ; $17B11A
        DC.W    $0017,$7920         ; $17B11C ORI.B  #$7920,(A7)
        ANDI.L  #$0000036A,(A0)                 ; $17B120
        DC.W    $0000,$02C0         ; $17B126 ORI.B  #$02C0,D0
        DC.W    $0000,$0400         ; $17B12A ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17B12E ORI.B  #$0000,D0
        DC.W    $0009,$1E52         ; $17B132 ORI.B  #$1E52,A1
        DC.W    $0200,$0019         ; $17B136 ANDI.B  #$0019,D0
        MOVE.W  -$70(A0,D0.W),$0000(A4)         ; $17B13A
        DC.W    $00EA               ; $17B140 DC.W    $00EA
        DC.W    $0000,$02C0         ; $17B142 ORI.B  #$02C0,D0
        DC.W    $0000,$036A         ; $17B146 ORI.B  #$036A,D0
        DC.W    $0000,$0000         ; $17B14A ORI.B  #$0000,D0
        DC.W    $0017,$1CE9         ; $17B14E ORI.B  #$1CE9,(A7)
        DC.W    $0200,$0018         ; $17B152 ANDI.B  #$0018,D0
        BVS.S  loc_17B1C8                       ; $17B156
        ANDI.L  #$00000400,(A0)                 ; $17B158
        DC.W    $0000,$02C0         ; $17B15E ORI.B  #$02C0,D0
        DC.W    $0000,$00EA         ; $17B162 ORI.B  #$00EA,D0
        DC.W    $0000,$0000         ; $17B166 ORI.B  #$0000,D0
        DC.W    $0018,$1CDD         ; $17B16A ORI.B  #$1CDD,(A0)+
        DC.W    $0200,$0017         ; $17B16E ANDI.B  #$0017,D0
        MOVE.W  -(A0),-(A4)                     ; $17B172
        ANDI.W  #$0000,(A0)                     ; $17B174
        BCHG    D1,$0000(A2)                    ; $17B178
        ANDI.L  #$00000400,(A0)                 ; $17B17C
        DC.W    $0000,$0000         ; $17B182 ORI.B  #$0000,D0
        DC.W    $0009,$1E52         ; $17B186 ORI.B  #$1E52,A1
        BTST    D1,D0                           ; $17B18A
        DC.W    $0019,$7970         ; $17B18C ORI.B  #$7970,(A1)+
        ANDI.W  #$0000,(A0)                     ; $17B190
        DC.W    $00EA               ; $17B194 DC.W    $00EA
        DC.W    $0000,$0290         ; $17B196 ORI.B  #$0290,D0
        DC.W    $0000,$036A         ; $17B19A ORI.B  #$036A,D0
        DC.W    $0000,$0000         ; $17B19E ORI.B  #$0000,D0
        DC.W    $0017,$1CE9         ; $17B1A2 ORI.B  #$1CE9,(A7)
        BTST    D1,D0                           ; $17B1A6
        DC.W    $0018,$6970         ; $17B1A8 ORI.B  #$6970,(A0)+
        ANDI.W  #$0000,(A0)                     ; $17B1AC
        SUBI.B  #$0000,D0                       ; $17B1B0
        ANDI.L  #$000000EA,(A0)                 ; $17B1B4
        DC.W    $0000,$0000         ; $17B1BA ORI.B  #$0000,D0
        DC.W    $0018,$1CDD         ; $17B1BE ORI.B  #$1CDD,(A0)+
        BTST    D1,D0                           ; $17B1C2
        DC.W    $0017,$0008         ; $17B1C4 ORI.B  #$0008,(A7)
loc_17B1C8:
        SUBQ.B  #4,-(A0)                        ; $17B1C8
        SUBI.B  #$0000,D0                       ; $17B1CA
        BCHG    D1,$0000(A2)                    ; $17B1CE
        ANDI.L  #$00000400,D0                   ; $17B1D2
        DC.W    $0000,$0000         ; $17B1D8 ORI.B  #$0000,D0
        DC.W    $0009,$1E52         ; $17B1DC ORI.B  #$1E52,A1
        BTST    D0,D0                           ; $17B1E0
        DC.W    $0019,$5970         ; $17B1E2 ORI.B  #$5970,(A1)+
        SUBI.B  #$0000,D0                       ; $17B1E6
        DC.W    $00EA               ; $17B1EA DC.W    $00EA
        DC.W    $0000,$0280         ; $17B1EC ORI.B  #$0280,D0
        DC.W    $0000,$036A         ; $17B1F0 ORI.B  #$036A,D0
        DC.W    $0000,$0000         ; $17B1F4 ORI.B  #$0000,D0
        DC.W    $0017,$1CE9         ; $17B1F8 ORI.B  #$1CE9,(A7)
        BTST    D0,D0                           ; $17B1FC
        DC.W    $0018,$4970         ; $17B1FE ORI.B  #$4970,(A0)+
        SUBI.B  #$0000,D0                       ; $17B202
        SUBI.B  #$0000,D0                       ; $17B206
        ANDI.L  #$000000EA,D0                   ; $17B20A
        DC.W    $0000,$0000         ; $17B210 ORI.B  #$0000,D0
        DC.W    $0018,$1CDD         ; $17B214 ORI.B  #$1CDD,(A0)+
        BTST    D0,D0                           ; $17B218
        DC.W    $0017,$7920         ; $17B21A ORI.B  #$7920,(A7)
        ANDI.L  #$0000036A,D0                   ; $17B21E
        DC.W    $0000,$02B0         ; $17B224 ORI.B  #$02B0,D0
        DC.W    $0000,$0400         ; $17B228 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17B22C ORI.B  #$0000,D0
        DC.W    $0009,$1E52         ; $17B230 ORI.B  #$1E52,A1
        DC.W    $0200,$0019         ; $17B234 ANDI.B  #$0019,D0
        MOVE.W  -$80(A0,D0.W),$0000(A4)         ; $17B238
        DC.W    $00EA               ; $17B23E DC.W    $00EA
        DC.W    $0000,$02B0         ; $17B240 ORI.B  #$02B0,D0
        DC.W    $0000,$036A         ; $17B244 ORI.B  #$036A,D0
        DC.W    $0000,$0000         ; $17B248 ORI.B  #$0000,D0
        DC.W    $0017,$1CE9         ; $17B24C ORI.B  #$1CE9,(A7)
        DC.W    $0200,$0018         ; $17B250 ANDI.B  #$0018,D0
        BVS.S  loc_17B2C6                       ; $17B254
        ANDI.L  #$00000400,D0                   ; $17B256
        DC.W    $0000,$02B0         ; $17B25C ORI.B  #$02B0,D0
        DC.W    $0000,$00EA         ; $17B260 ORI.B  #$00EA,D0
        DC.W    $0000,$0000         ; $17B264 ORI.B  #$0000,D0
        DC.W    $0018,$1CDD         ; $17B268 ORI.B  #$1CDD,(A0)+
        DC.W    $0200,$0017         ; $17B26C ANDI.B  #$0017,D0
        MOVE.W  -(A0),-(A4)                     ; $17B270
        DC.W    $02B0,$0000,$036A,$0000; $17B272 ANDI.L  #$0000036A,$00(A0,D0.W)
        DC.W    $02F0               ; $17B27A DC.W    $02F0
        DC.W    $0000,$0400         ; $17B27C ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17B280 ORI.B  #$0000,D0
        DC.W    $0009,$1E52         ; $17B284 ORI.B  #$1E52,A1
        BTST    D1,D0                           ; $17B288
        DC.W    $0019,$7970         ; $17B28A ORI.B  #$7970,(A1)+
        DC.W    $02B0,$0000,$00EA,$0000; $17B28E ANDI.L  #$000000EA,$00(A0,D0.W)
        DC.W    $02F0               ; $17B296 DC.W    $02F0
        DC.W    $0000,$036A         ; $17B298 ORI.B  #$036A,D0
        DC.W    $0000,$0000         ; $17B29C ORI.B  #$0000,D0
        DC.W    $0017,$1CE9         ; $17B2A0 ORI.B  #$1CE9,(A7)
        BTST    D1,D0                           ; $17B2A4
        DC.W    $0018,$6970         ; $17B2A6 ORI.B  #$6970,(A0)+
        DC.W    $02B0,$0000,$0400,$0000; $17B2AA ANDI.L  #$00000400,$00(A0,D0.W)
        DC.W    $02F0               ; $17B2B2 DC.W    $02F0
        DC.W    $0000,$00EA         ; $17B2B4 ORI.B  #$00EA,D0
        DC.W    $0000,$0000         ; $17B2B8 ORI.B  #$0000,D0
        DC.W    $0018,$1CDD         ; $17B2BC ORI.B  #$1CDD,(A0)+
        BTST    D1,D0                           ; $17B2C0
        DC.W    $0017,$0003         ; $17B2C2 ORI.B  #$0003,(A7)
loc_17B2C6:
        MOVE.L  (A0),-(A4)                      ; $17B2C6
        MOVE.W  -(A4),-$7B(A7,D0.W)             ; $17B2C8
        SUBI.B  #$0000,D0                       ; $17B2CC
        SUBI.B  #$0000,D0                       ; $17B2D0
        ORI.W  #$0313,(A6)                      ; $17B2D4
        DC.W    $FFFF               ; $17B2D8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $000A,$13DA         ; $17B2DA ORI.B  #$13DA,A2
        BTST    D0,D0                           ; $17B2DE
        OR.W   D3,A5                            ; $17B2E0
        MOVE.L  -(A0),-(A0)                     ; $17B2E2
        MOVE.W  -(A6),-$80(A7,D0.W)             ; $17B2E4
        ORI.W  #$0313,(A6)                      ; $17B2E8
        SUBI.B  #$0000,D0                       ; $17B2EC
        SUBI.B  #$0000,D0                       ; $17B2F0
        DC.W    $0000,$0005         ; $17B2F4 ORI.B  #$0005,D0
        MOVEA.B $0100(A2),A2                    ; $17B2F8
        OR.W   D3,A4                            ; $17B2FC
        MOVE.L  (A0),D5                         ; $17B2FE
        MOVE.W  -(A4),$54(A7,D0.W)              ; $17B300
        SUBI.B  #$0000,D0                       ; $17B304
        MOVE.W  -(A4),-$7B(A7,D0.W)             ; $17B308
        ORI.W  #$0313,(A6)                      ; $17B30C
        DC.W    $FFFF               ; $17B310 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $000A,$13D4         ; $17B312 ORI.B  #$13D4,A2
        DC.W    $0200,$874D         ; $17B316 ANDI.B  #$874D,D0
        MOVE.L  -(A0),D1                        ; $17B31A
        MOVE.W  -(A6),$50(A7,D0.W)              ; $17B31C
        ORI.W  #$0313,(A6)                      ; $17B320
        MOVE.W  -(A6),-$80(A7,D0.W)             ; $17B324
        SUBI.B  #$0000,D0                       ; $17B328
        DC.W    $0000,$0005         ; $17B32C ORI.B  #$0005,D0
        MOVEA.B $0200(A1),A2                    ; $17B330
        OR.W   D3,A4                            ; $17B334
        DC.W    $0008,$A210         ; $17B336 ORI.B  #$A210,A0
        DC.W    $FFC3               ; $17B33A MOVE.W  D3,<EA:3F>
        ORI.W  #$0018,$004F(A0)                 ; $17B33C
        DC.W    $FFC9               ; $17B342 MOVE.W  A1,<EA:3F>
        SUBI.B  #$0046,-(A7)                    ; $17B344
        BSET    D0,(A2)                         ; $17B348
        DC.W    $0000,$0004         ; $17B34A ORI.B  #$0004,D0
        DC.W    $13F8,$0100,$844E,$A210; $17B34E MOVE.B  $0100.W,$844EA210
        MOVE.W  -(A4),-$7B(A7,D0.W)             ; $17B356
        ORI.W  #$01D2,D6                        ; $17B35A
        MOVE.W  -(A5),$51(A7,D0.W)              ; $17B35E
        ORI.W  #$03C0,(A6)                      ; $17B362
        DC.W    $FFFF               ; $17B366 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $000A,$13A6         ; $17B368 ORI.B  #$13A6,A2
        BTST    D0,D0                           ; $17B36C
        OR.W   D3,A5                            ; $17B36E
        DC.W    $4120               ; $17B370 DC.W    $4120
        SUBI.B  #$0000,D0                       ; $17B372
        ORI.W  #$03C0,(A6)                      ; $17B376
        SUBI.B  #$0000,D0                       ; $17B37A
        SUBI.B  #$0000,D0                       ; $17B37E
        DC.W    $0000,$0005         ; $17B382 ORI.B  #$0005,D0
        MOVEA.B A6,A2                           ; $17B386
        BTST    D0,D0                           ; $17B388
        OR.W   D3,A4                            ; $17B38A
        MOVE.L  (A0),-(A4)                      ; $17B38C
        DC.W    $0022,$0059         ; $17B38E ORI.B  #$0059,-(A2)
        SUBI.B  #$0000,D0                       ; $17B392
        SUBI.B  #$0000,D0                       ; $17B396
        DC.W    $0018,$004F         ; $17B39A ORI.B  #$004F,(A0)+
        DC.W    $0000,$0000         ; $17B39E ORI.B  #$0000,D0
        MOVE.B  D0,D2                           ; $17B3A2
        BTST    D0,D0                           ; $17B3A4
        MOVE.W  A7,-$55F0(A6)                   ; $17B3A6
        DC.W    $0022,$0029         ; $17B3AA ORI.B  #$0029,-(A2)
        SUBI.B  #$0000,D0                       ; $17B3AE
        DC.W    $0022,$0059         ; $17B3B2 ORI.B  #$0059,-(A2)
        DC.W    $0019,$004F         ; $17B3B6 ORI.B  #$004F,(A1)+
        DC.W    $0000,$0000         ; $17B3BA ORI.B  #$0000,D0
        MOVE.B  D0,D2                           ; $17B3BE
        DC.W    $0200,$7D4F         ; $17B3C0 ANDI.B  #$7D4F,D0
        MOVE.L  -(A0),D1                        ; $17B3C4
        MOVE.W  -(A5),$51(A7,D0.W)              ; $17B3C6
        ORI.W  #$01D2,D6                        ; $17B3CA
        MOVE.W  -(A5),-$7E(A7,D0.W)             ; $17B3CE
        SUBI.B  #$0000,D0                       ; $17B3D2
        DC.W    $FFFF               ; $17B3D6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $000A,$13AE         ; $17B3D8 ORI.B  #$13AE,A2
        DC.W    $0200,$874D         ; $17B3DC ANDI.B  #$874D,D0
        MOVE.L  (A0),-(A4)                      ; $17B3E0
        DC.W    $FFC9               ; $17B3E2 MOVE.W  A1,<EA:3F>
        SUBI.B  #$0400,-(A7)                    ; $17B3E4
        DC.W    $0000,$0400         ; $17B3E8 ORI.B  #$0400,D0
        DC.W    $0000,$0046         ; $17B3EC ORI.B  #$0046,D0
        BSET    D0,(A2)                         ; $17B3F0
        DC.W    $0000,$0004         ; $17B3F2 ORI.B  #$0004,D0
        DC.W    $13FC,$0200,$844E,$A210; $17B3F6 MOVE.B  #$0200,$844EA210
        DC.W    $FFC2               ; $17B3FE MOVE.W  D2,<EA:3F>
        DC.W    $0039,$0019,$004F,$FFC3; $17B400 ORI.B  #$0019,$004FFFC3
        ORI.W  #$0046,$01D2(A0)                 ; $17B408
        DC.W    $0000,$0005         ; $17B40E ORI.B  #$0005,D0
        DC.W    $13F4,$0200,$844E,$A220; $17B412 MOVE.B  $00(A4,D0.W),$844EA220
        MOVE.W  -(A4),$54(A7,D0.W)              ; $17B41A
        ORI.W  #$01D2,D6                        ; $17B41E
        MOVE.W  -(A4),-$7B(A7,D0.W)             ; $17B422
        SUBI.B  #$0000,D0                       ; $17B426
        DC.W    $FFFF               ; $17B42A MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $000A,$139F         ; $17B42C ORI.B  #$139F,A2
        DC.W    $0200,$874D         ; $17B430 ANDI.B  #$874D,D0
        DC.W    $0004,$4220         ; $17B434 ORI.B  #$4220,D4
        SUBI.B  #$0000,D0                       ; $17B438
        DC.W    $0018,$0080         ; $17B43C ORI.B  #$0080,(A0)+
        DC.W    $FFC9               ; $17B440 MOVE.W  A1,<EA:3F>
        DC.W    $0027,$0400         ; $17B442 ORI.B  #$0400,-(A7)
        DC.W    $0000,$0000         ; $17B446 ORI.B  #$0000,D0
        DC.W    $0004,$13EB         ; $17B44A ORI.B  #$13EB,D4
        BTST    D0,D0                           ; $17B44E
        OR.W   A6,D2                            ; $17B450
        TST.B  (A0)                             ; $17B452
        SUBI.B  #$0000,D0                       ; $17B454
        SUBI.B  #$0000,D0                       ; $17B458
        DC.W    $0025,$0010         ; $17B45C ORI.B  #$0010,-(A5)
        DC.W    $0018,$0080         ; $17B460 ORI.B  #$0080,(A0)+
        DC.W    $0000,$0000         ; $17B464 ORI.B  #$0000,D0
        MOVE.B  D0,D2                           ; $17B468
        BTST    D0,D0                           ; $17B46A
        MOVE.W  A7,$4220(A6)                    ; $17B46C
        SUBI.B  #$0000,D0                       ; $17B470
        ORI.W  #$025E,D6                        ; $17B474
        MOVE.W  -(A5),-$7E(A7,D0.W)             ; $17B478
        SUBI.B  #$0000,D0                       ; $17B47C
        DC.W    $FFFF               ; $17B480 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $000A,$137C         ; $17B482 ORI.B  #$137C,A2
        DC.W    $0200,$874D         ; $17B486 ANDI.B  #$874D,D0
        MOVE.L  (A0),D1                         ; $17B48A
        DC.W    $FFC9               ; $17B48C MOVE.W  A1,<EA:3F>
        DC.W    $0027,$0019         ; $17B48E ORI.B  #$0019,-(A7)
        ORI.L  #$FFC90057,D0                    ; $17B492
        ORI.W  #$025E,D6                        ; $17B498
        DC.W    $0000,$0004         ; $17B49C ORI.B  #$0004,D0
        DC.W    $13F0,$0200,$844E,$AA10; $17B4A0 MOVE.B  $00(A0,D0.W),$844EAA10
        DC.W    $0025,$0010         ; $17B4A8 ORI.B  #$0010,-(A5)
        SUBI.B  #$0000,D0                       ; $17B4AC
        DC.W    $0025,$003F         ; $17B4B0 ORI.B  #$003F,-(A5)
        DC.W    $0019,$0080         ; $17B4B4 ORI.B  #$0080,(A1)+
        DC.W    $0000,$0000         ; $17B4B8 ORI.B  #$0000,D0
        MOVE.B  D0,D2                           ; $17B4BC
        DC.W    $0200,$7D4F         ; $17B4BE ANDI.B  #$7D4F,D0
        DC.W    $0005,$7920         ; $17B4C2 ORI.B  #$7920,D5
        DC.W    $02C0               ; $17B4C6 DC.W    $02C0
        DC.W    $0000,$01EA         ; $17B4C8 ORI.B  #$01EA,D0
        DC.W    $0000,$0400         ; $17B4CC ORI.B  #$0400,D0
        DC.W    $0000,$0400         ; $17B4D0 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17B4D4 ORI.B  #$0000,D0
        DC.W    $0001,$2019         ; $17B4D8 ORI.B  #$2019,D1
        BTST    D0,D0                           ; $17B4DC
        DC.W    $001A,$6970         ; $17B4DE ORI.B  #$6970,(A2)+
        DC.W    $02C0               ; $17B4E2 DC.W    $02C0
        DC.W    $0000,$0400         ; $17B4E4 ORI.B  #$0400,D0
        DC.W    $0000,$0400         ; $17B4E8 ORI.B  #$0400,D0
        DC.W    $0000,$01EA         ; $17B4EC ORI.B  #$01EA,D0
        DC.W    $0000,$0000         ; $17B4F0 ORI.B  #$0000,D0
        DC.W    $0009,$1F92         ; $17B4F4 ORI.B  #$1F92,A1
        BTST    D0,D0                           ; $17B4F8
        DC.W    $0019,$7920         ; $17B4FA ORI.B  #$7920,(A1)+
        ANDI.L  #$000001EA,(A0)                 ; $17B4FE
        DC.W    $0000,$02C0         ; $17B504 ORI.B  #$02C0,D0
        DC.W    $0000,$0400         ; $17B508 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17B50C ORI.B  #$0000,D0
        DC.W    $0001,$2019         ; $17B510 ORI.B  #$2019,D1
        DC.W    $0200,$001A         ; $17B514 ANDI.B  #$001A,D0
        BVS.S  loc_17B58A                       ; $17B518
        ANDI.L  #$00000400,(A0)                 ; $17B51A
        DC.W    $0000,$02C0         ; $17B520 ORI.B  #$02C0,D0
        DC.W    $0000,$01EA         ; $17B524 ORI.B  #$01EA,D0
        DC.W    $0000,$0000         ; $17B528 ORI.B  #$0000,D0
        DC.W    $0009,$1F92         ; $17B52C ORI.B  #$1F92,A1
        DC.W    $0200,$0019         ; $17B530 ANDI.B  #$0019,D0
        MOVE.W  -(A0),-(A4)                     ; $17B534
        ANDI.W  #$0000,(A0)                     ; $17B536
        BSET    D0,$0000(A2)                    ; $17B53A
        ANDI.L  #$00000400,(A0)                 ; $17B53E
        DC.W    $0000,$0000         ; $17B544 ORI.B  #$0000,D0
        DC.W    $0001,$2019         ; $17B548 ORI.B  #$2019,D1
        BTST    D1,D0                           ; $17B54C
        DC.W    $001A,$6970         ; $17B54E ORI.B  #$6970,(A2)+
        ANDI.W  #$0000,(A0)                     ; $17B552
        SUBI.B  #$0000,D0                       ; $17B556
        ANDI.L  #$000001EA,(A0)                 ; $17B55A
        DC.W    $0000,$0000         ; $17B560 ORI.B  #$0000,D0
        DC.W    $0009,$1F92         ; $17B564 ORI.B  #$1F92,A1
        BTST    D1,D0                           ; $17B568
        DC.W    $0019,$0005         ; $17B56A ORI.B  #$0005,(A1)+
        SUBQ.B  #4,-(A0)                        ; $17B56E
        SUBI.B  #$0000,D0                       ; $17B570
        BSET    D0,$0000(A2)                    ; $17B574
        ANDI.L  #$00000400,D0                   ; $17B578
        DC.W    $0000,$0000         ; $17B57E ORI.B  #$0000,D0
        DC.W    $0001,$2019         ; $17B582 ORI.B  #$2019,D1
        BTST    D0,D0                           ; $17B586
        DC.W    $001A,$4970         ; $17B588 ORI.B  #$4970,(A2)+
        SUBI.B  #$0000,D0                       ; $17B58C
        SUBI.B  #$0000,D0                       ; $17B590
        ANDI.L  #$000001EA,D0                   ; $17B594
        DC.W    $0000,$0000         ; $17B59A ORI.B  #$0000,D0
        DC.W    $0009,$1F92         ; $17B59E ORI.B  #$1F92,A1
        BTST    D0,D0                           ; $17B5A2
        DC.W    $0019,$7920         ; $17B5A4 ORI.B  #$7920,(A1)+
        ANDI.L  #$000001EA,D0                   ; $17B5A8
        DC.W    $0000,$02B0         ; $17B5AE ORI.B  #$02B0,D0
        DC.W    $0000,$0400         ; $17B5B2 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17B5B6 ORI.B  #$0000,D0
        DC.W    $0001,$2019         ; $17B5BA ORI.B  #$2019,D1
        DC.W    $0200,$001A         ; $17B5BE ANDI.B  #$001A,D0
        BVS.S  loc_17B634                       ; $17B5C2
        ANDI.L  #$00000400,D0                   ; $17B5C4
        DC.W    $0000,$02B0         ; $17B5CA ORI.B  #$02B0,D0
        DC.W    $0000,$01EA         ; $17B5CE ORI.B  #$01EA,D0
        DC.W    $0000,$0000         ; $17B5D2 ORI.B  #$0000,D0
        DC.W    $0009,$1F92         ; $17B5D6 ORI.B  #$1F92,A1
        DC.W    $0200,$0019         ; $17B5DA ANDI.B  #$0019,D0
        MOVE.W  -(A0),-(A4)                     ; $17B5DE
        DC.W    $02B0,$0000,$01EA,$0000; $17B5E0 ANDI.L  #$000001EA,$00(A0,D0.W)
        DC.W    $02F0               ; $17B5E8 DC.W    $02F0
        DC.W    $0000,$0400         ; $17B5EA ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17B5EE ORI.B  #$0000,D0
        DC.W    $0001,$2019         ; $17B5F2 ORI.B  #$2019,D1
        BTST    D1,D0                           ; $17B5F6
        DC.W    $001A,$6970         ; $17B5F8 ORI.B  #$6970,(A2)+
        DC.W    $02B0,$0000,$0400,$0000; $17B5FC ANDI.L  #$00000400,$00(A0,D0.W)
        DC.W    $02F0               ; $17B604 DC.W    $02F0
        DC.W    $0000,$01EA         ; $17B606 ORI.B  #$01EA,D0
        DC.W    $0000,$0000         ; $17B60A ORI.B  #$0000,D0
        DC.W    $0009,$1F92         ; $17B60E ORI.B  #$1F92,A1
        BTST    D1,D0                           ; $17B612
        DC.W    $0019,$0003         ; $17B614 ORI.B  #$0003,(A1)+
        MOVE.L  (A0),-(A4)                      ; $17B618
        MOVE.W  -(A6),-$34(A7,D0.W)             ; $17B61A
        SUBI.B  #$0000,D0                       ; $17B61E
        SUBI.B  #$0000,D0                       ; $17B622
        ORI.W  #$017A,(A0)+                     ; $17B626
        DC.W    $0000,$0005         ; $17B62A ORI.B  #$0005,D0
        MOVE.B  A3,-(A2)                        ; $17B62E
        BTST    D0,D0                           ; $17B630
        OR.W   D3,A4                            ; $17B632
loc_17B634:
        MOVE.L  -(A0),-(A0)                     ; $17B634
        MOVE.W  $03CB(A0),$58(A7,D0.W)          ; $17B636
        BCHG    D0,$0400(PC)                    ; $17B63C
        DC.W    $0000,$0400         ; $17B640 ORI.B  #$0400,D0
        DC.W    $0000,$FFFE         ; $17B644 ORI.B  #$FFFE,D0
        DC.W    $000F,$148C         ; $17B648 ORI.B  #$148C,A7
        BTST    D0,D0                           ; $17B64C
        OR.W   D3,A3                            ; $17B64E
        MOVE.L  -(A0),D1                        ; $17B650
        MOVE.W  $039A(A0),$58(A7,D0.W)          ; $17B652
        BCHG    D0,-$0058(PC)                   ; $17B658
        DC.W    $03CB               ; $17B65C BSET    D1,A3
        SUBI.B  #$0000,D0                       ; $17B65E
        DC.W    $FFFE               ; $17B662 MOVE.W  <EA:3E>,<EA:3F>
        DC.W    $000F,$148C         ; $17B664 ORI.B  #$148C,A7
        DC.W    $0200,$874B         ; $17B668 ANDI.B  #$874B,D0
        MOVE.L  (A0),D5                         ; $17B66C
        MOVE.W  -(A6),-$65(A7,D0.W)             ; $17B66E
        SUBI.B  #$0000,D0                       ; $17B672
        MOVE.W  -(A6),-$34(A7,D0.W)             ; $17B676
        ORI.W  #$017A,(A0)+                     ; $17B67A
        DC.W    $0000,$0005         ; $17B67E ORI.B  #$0005,D0
        MOVE.B  A3,-(A2)                        ; $17B682
        DC.W    $0200,$874C         ; $17B684 ANDI.B  #$874C,D0
        DC.W    $0005,$4A10         ; $17B688 ORI.B  #$4A10,D5
        SUBI.B  #$0000,D0                       ; $17B68C
        SUBI.B  #$0000,D0                       ; $17B690
        MOVE.W  -(A5),-$65(A7,D0.W)             ; $17B694
        ORI.W  #$FFC1,(A6)                      ; $17B698
        DC.W    $FFFF               ; $17B69C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $000A,$14F8         ; $17B69E ORI.B  #$14F8,A2
        BTST    D0,D0                           ; $17B6A2
        OR.W   D3,A5                            ; $17B6A4
        CLR.B  (A0)                             ; $17B6A6
        SUBI.B  #$0000,D0                       ; $17B6A8
        ORI.W  #$FFC1,(A6)                      ; $17B6AC
        MOVE.W  -(A6),-$65(A7,D0.W)             ; $17B6B0
        ORI.W  #$022C,(A0)+                     ; $17B6B4
        DC.W    $0000,$0005         ; $17B6B8 ORI.B  #$0005,D0
        MOVE.B  $0100(A7),(A2)+                 ; $17B6BC
        OR.W   D3,A4                            ; $17B6C0
        CLR.B  -(A0)                            ; $17B6C2
        SUBI.B  #$0000,D0                       ; $17B6C4
        ORI.W  #$022C,(A0)+                     ; $17B6C8
        MOVE.W  $0399(A0),$00(A7,D0.W)          ; $17B6CC
        DC.W    $0000,$FFFE         ; $17B6D2 ORI.B  #$FFFE,D0
        DC.W    $000F,$1435         ; $17B6D6 ORI.B  #$1435,A7
        BTST    D0,D0                           ; $17B6DA
        OR.W   D3,A3                            ; $17B6DC
        MOVE.L  (A0),D5                         ; $17B6DE
        MOVE.W  -(A5),-$65(A7,D0.W)             ; $17B6E0
        SUBI.B  #$0000,D0                       ; $17B6E4
        MOVE.W  -(A5),-$34(A7,D0.W)             ; $17B6E8
        ORI.W  #$FFC1,(A6)                      ; $17B6EC
        DC.W    $FFFF               ; $17B6F0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $000A,$14F5         ; $17B6F2 ORI.B  #$14F5,A2
        DC.W    $0200,$874D         ; $17B6F6 ANDI.B  #$874D,D0
        MOVE.L  -(A0),D1                        ; $17B6FA
        MOVE.W  $0399(A0),$59(A7,D0.W)          ; $17B6FC
        DC.W    $022C,$FFA8,$03CA   ; $17B702 ANDI.B  #$FFA8,$03CA(A4)
        SUBI.B  #$0000,D0                       ; $17B708
        DC.W    $FFFE               ; $17B70C MOVE.W  <EA:3E>,<EA:3F>
        DC.W    $000F,$1434         ; $17B70E ORI.B  #$1434,A7
        DC.W    $0200,$874B         ; $17B712 ANDI.B  #$874B,D0
        MOVE.L  (A0),D1                         ; $17B716
        MOVE.W  -(A6),-$65(A7,D0.W)             ; $17B718
        ORI.W  #$FFC1,(A6)                      ; $17B71C
        MOVE.W  -(A6),-$35(A7,D0.W)             ; $17B720
        ORI.W  #$022C,(A1)+                     ; $17B724
        DC.W    $0000,$0005         ; $17B728 ORI.B  #$0005,D0
        MOVE.B  $0200(A7),(A2)+                 ; $17B72C
        OR.W   D3,A4                            ; $17B730
        DC.W    $0008,$7920         ; $17B732 ORI.B  #$7920,A0
        DC.W    $02C0               ; $17B736 DC.W    $02C0
        DC.W    $0000,$02EA         ; $17B738 ORI.B  #$02EA,D0
        DC.W    $0000,$0400         ; $17B73C ORI.B  #$0400,D0
        DC.W    $0000,$0400         ; $17B740 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17B744 ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17B748 ORI.B  #$2044,D0
        BTST    D0,D0                           ; $17B74C
        DC.W    $001C,$7970         ; $17B74E ORI.B  #$7970,(A4)+
        DC.W    $02C0               ; $17B752 DC.W    $02C0
        DC.W    $0000,$006A         ; $17B754 ORI.B  #$006A,D0
        DC.W    $0000,$0400         ; $17B758 ORI.B  #$0400,D0
        DC.W    $0000,$02EA         ; $17B75C ORI.B  #$02EA,D0
        DC.W    $0000,$0000         ; $17B760 ORI.B  #$0000,D0
        DC.W    $0000,$2043         ; $17B764 ORI.B  #$2043,D0
        BTST    D0,D0                           ; $17B768
        DC.W    $001B,$6970         ; $17B76A ORI.B  #$6970,(A3)+
        DC.W    $02C0               ; $17B76E DC.W    $02C0
        DC.W    $0000,$0400         ; $17B770 ORI.B  #$0400,D0
        DC.W    $0000,$0400         ; $17B774 ORI.B  #$0400,D0
        DC.W    $0000,$006A         ; $17B778 ORI.B  #$006A,D0
        DC.W    $0000,$0000         ; $17B77C ORI.B  #$0000,D0
        DC.W    $0001,$203F         ; $17B780 ORI.B  #$203F,D1
        BTST    D0,D0                           ; $17B784
        DC.W    $001A,$7920         ; $17B786 ORI.B  #$7920,(A2)+
        ANDI.L  #$000002EA,(A0)                 ; $17B78A
        DC.W    $0000,$02C0         ; $17B790 ORI.B  #$02C0,D0
        DC.W    $0000,$0400         ; $17B794 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17B798 ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17B79C ORI.B  #$2044,D0
        DC.W    $0200,$001C         ; $17B7A0 ANDI.B  #$001C,D0
        MOVE.W  -$70(A0,D0.W),$0000(A4)         ; $17B7A4
        ORI.W  #$0000,$02C0(A2)                 ; $17B7AA
        DC.W    $0000,$02EA         ; $17B7B0 ORI.B  #$02EA,D0
        DC.W    $0000,$0000         ; $17B7B4 ORI.B  #$0000,D0
        DC.W    $0000,$2043         ; $17B7B8 ORI.B  #$2043,D0
        DC.W    $0200,$001B         ; $17B7BC ANDI.B  #$001B,D0
        BVS.S  loc_17B832                       ; $17B7C0
        ANDI.L  #$00000400,(A0)                 ; $17B7C2
        DC.W    $0000,$02C0         ; $17B7C8 ORI.B  #$02C0,D0
        DC.W    $0000,$006A         ; $17B7CC ORI.B  #$006A,D0
        DC.W    $0000,$0000         ; $17B7D0 ORI.B  #$0000,D0
        DC.W    $0001,$203F         ; $17B7D4 ORI.B  #$203F,D1
        DC.W    $0200,$001A         ; $17B7D8 ANDI.B  #$001A,D0
        BVS.S  loc_17B84E                       ; $17B7DC
        ANDI.W  #$0000,(A0)                     ; $17B7DE
        SUBI.B  #$0000,D0                       ; $17B7E2
        ANDI.L  #$0000006A,(A0)                 ; $17B7E6
        DC.W    $0000,$0000         ; $17B7EC ORI.B  #$0000,D0
        DC.W    $0001,$203F         ; $17B7F0 ORI.B  #$203F,D1
        BTST    D1,D0                           ; $17B7F4
        DC.W    $001A,$7920         ; $17B7F6 ORI.B  #$7920,(A2)+
        ANDI.W  #$0000,(A0)                     ; $17B7FA
        DC.W    $02EA               ; $17B7FE DC.W    $02EA
        DC.W    $0000,$0290         ; $17B800 ORI.B  #$0290,D0
        DC.W    $0000,$0400         ; $17B804 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17B808 ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17B80C ORI.B  #$2044,D0
        BTST    D1,D0                           ; $17B810
        DC.W    $001C,$7970         ; $17B812 ORI.B  #$7970,(A4)+
        ANDI.W  #$0000,(A0)                     ; $17B816
        ORI.W  #$0000,$0290(A2)                 ; $17B81A
        DC.W    $0000,$02EA         ; $17B820 ORI.B  #$02EA,D0
        DC.W    $0000,$0000         ; $17B824 ORI.B  #$0000,D0
        DC.W    $0000,$2043         ; $17B828 ORI.B  #$2043,D0
        BTST    D1,D0                           ; $17B82C
        DC.W    $001B,$0008         ; $17B82E ORI.B  #$0008,(A3)+
loc_17B832:
        SUBQ.B  #4,-(A0)                        ; $17B832
        SUBI.B  #$0000,D0                       ; $17B834
        DC.W    $02EA               ; $17B838 DC.W    $02EA
        DC.W    $0000,$0280         ; $17B83A ORI.B  #$0280,D0
        DC.W    $0000,$0400         ; $17B83E ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17B842 ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17B846 ORI.B  #$2044,D0
        BTST    D0,D0                           ; $17B84A
        DC.W    $001C,$5970         ; $17B84C ORI.B  #$5970,(A4)+
        SUBI.B  #$0000,D0                       ; $17B850
        ORI.W  #$0000,$0280(A2)                 ; $17B854
        DC.W    $0000,$02EA         ; $17B85A ORI.B  #$02EA,D0
        DC.W    $0000,$0000         ; $17B85E ORI.B  #$0000,D0
        DC.W    $0000,$2043         ; $17B862 ORI.B  #$2043,D0
        BTST    D0,D0                           ; $17B866
        DC.W    $001B,$4970         ; $17B868 ORI.B  #$4970,(A3)+
        SUBI.B  #$0000,D0                       ; $17B86C
        SUBI.B  #$0000,D0                       ; $17B870
        ANDI.L  #$0000006A,D0                   ; $17B874
        DC.W    $0000,$0000         ; $17B87A ORI.B  #$0000,D0
        DC.W    $0001,$203F         ; $17B87E ORI.B  #$203F,D1
        BTST    D0,D0                           ; $17B882
        DC.W    $001A,$7920         ; $17B884 ORI.B  #$7920,(A2)+
        ANDI.L  #$000002EA,D0                   ; $17B888
        DC.W    $0000,$02B0         ; $17B88E ORI.B  #$02B0,D0
        DC.W    $0000,$0400         ; $17B892 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17B896 ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17B89A ORI.B  #$2044,D0
        DC.W    $0200,$001C         ; $17B89E ANDI.B  #$001C,D0
        MOVE.W  -$80(A0,D0.W),$0000(A4)         ; $17B8A2
        ORI.W  #$0000,$02B0(A2)                 ; $17B8A8
        DC.W    $0000,$02EA         ; $17B8AE ORI.B  #$02EA,D0
        DC.W    $0000,$0000         ; $17B8B2 ORI.B  #$0000,D0
        DC.W    $0000,$2043         ; $17B8B6 ORI.B  #$2043,D0
        DC.W    $0200,$001B         ; $17B8BA ANDI.B  #$001B,D0
        BVS.S  loc_17B930                       ; $17B8BE
        ANDI.L  #$00000400,D0                   ; $17B8C0
        DC.W    $0000,$02B0         ; $17B8C6 ORI.B  #$02B0,D0
        DC.W    $0000,$006A         ; $17B8CA ORI.B  #$006A,D0
        DC.W    $0000,$0000         ; $17B8CE ORI.B  #$0000,D0
        DC.W    $0001,$203F         ; $17B8D2 ORI.B  #$203F,D1
        DC.W    $0200,$001A         ; $17B8D6 ANDI.B  #$001A,D0
        MOVE.W  -(A0),-(A4)                     ; $17B8DA
        DC.W    $02B0,$0000,$02EA,$0000; $17B8DC ANDI.L  #$000002EA,$00(A0,D0.W)
        DC.W    $02F0               ; $17B8E4 DC.W    $02F0
        DC.W    $0000,$0400         ; $17B8E6 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17B8EA ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17B8EE ORI.B  #$2044,D0
        BTST    D1,D0                           ; $17B8F2
        DC.W    $001C,$7970         ; $17B8F4 ORI.B  #$7970,(A4)+
        DC.W    $02B0,$0000,$006A,$0000; $17B8F8 ANDI.L  #$0000006A,$00(A0,D0.W)
        DC.W    $02F0               ; $17B900 DC.W    $02F0
        DC.W    $0000,$02EA         ; $17B902 ORI.B  #$02EA,D0
        DC.W    $0000,$0000         ; $17B906 ORI.B  #$0000,D0
        DC.W    $0000,$2043         ; $17B90A ORI.B  #$2043,D0
        BTST    D1,D0                           ; $17B90E
        DC.W    $001B,$6970         ; $17B910 ORI.B  #$6970,(A3)+
        DC.W    $02B0,$0000,$0400,$0000; $17B914 ANDI.L  #$00000400,$00(A0,D0.W)
        DC.W    $02F0               ; $17B91C DC.W    $02F0
        DC.W    $0000,$006A         ; $17B91E ORI.B  #$006A,D0
        DC.W    $0000,$0000         ; $17B922 ORI.B  #$0000,D0
        DC.W    $0001,$203F         ; $17B926 ORI.B  #$203F,D1
        BTST    D1,D0                           ; $17B92A
        DC.W    $001A,$0005         ; $17B92C ORI.B  #$0005,(A2)+
loc_17B930:
        MOVE.L  -(A0),-(A0)                     ; $17B930
        MOVE.W  $0319(A0),$58(A7,D0.W)          ; $17B932
        ANDI.L  #$04000000,A5                   ; $17B938
        SUBI.B  #$0000,D0                       ; $17B93E
        DC.W    $FFFC,$0019         ; $17B942 MOVE.W  #$0019,<EA:3F>
        MOVE.B  -(A0),(A3)                      ; $17B946
        BTST    D0,D0                           ; $17B948
        OR.W   D3,A1                            ; $17B94A
        MOVE.L  (A0),-(A4)                      ; $17B94C
        MOVE.W  $0319(A0),$00(A7,D0.W)          ; $17B94E
        DC.W    $0000,$0400         ; $17B954 ORI.B  #$0400,D0
        DC.W    $0000,$0058         ; $17B958 ORI.B  #$0058,D0
        DC.W    $0004,$FFFE         ; $17B95C ORI.B  #$FFFE,D4
        DC.W    $000F,$1685         ; $17B960 ORI.B  #$1685,A7
        BTST    D0,D0                           ; $17B964
        OR.W   D3,A3                            ; $17B966
        MOVE.L  (A0),-(A0)                      ; $17B968
        MOVE.W  $0319(A0),$58(A7,D0.W)          ; $17B96A
        DC.W    $0004,$0400         ; $17B970 ORI.B  #$0400,D4
        DC.W    $0000,$0058         ; $17B974 ORI.B  #$0058,D0
        ANDI.L  #$FFFC001A,A5                   ; $17B978
        MOVE.B  D3,(A3)                         ; $17B97E
        BTST    D0,D0                           ; $17B980
        OR.W   D3,A2                            ; $17B982
        MOVE.L  -(A0),D1                        ; $17B984
        MOVE.W  $02E8(A0),$59(A7,D0.W)          ; $17B986
        ANDI.L  #$FFA80319,A5                   ; $17B98C
        SUBI.B  #$0000,D0                       ; $17B992
        DC.W    $FFFC,$0019         ; $17B996 MOVE.W  #$0019,<EA:3F>
        MOVE.B  -(A0),(A3)                      ; $17B99A
        DC.W    $0200,$8749         ; $17B99C ANDI.B  #$8749,D0
        MOVE.L  (A0),D1                         ; $17B9A0
        MOVE.W  $02E8(A0),$59(A7,D0.W)          ; $17B9A2
        DC.W    $0003,$FFA8         ; $17B9A8 ORI.B  #$FFA8,D3
        BTST    D1,(A1)+                        ; $17B9AC
        ORI.W  #$028D,(A1)+                     ; $17B9AE
        DC.W    $FFFC,$001A         ; $17B9B2 MOVE.W  #$001A,<EA:3F>
        MOVE.B  D3,(A3)                         ; $17B9B6
        DC.W    $0200,$874A         ; $17B9B8 ANDI.B  #$874A,D0
        MOVE.L  (A0),D5                         ; $17B9BC
        MOVE.W  $02E8(A0),$00(A7,D0.W)          ; $17B9BE
        DC.W    $0000,$FFA8         ; $17B9C4 ORI.B  #$FFA8,D0
        BTST    D1,(A1)+                        ; $17B9C8
        ORI.W  #$0003,(A1)+                     ; $17B9CA
        DC.W    $FFFE               ; $17B9CE MOVE.W  <EA:3E>,<EA:3F>
        DC.W    $000F,$1685         ; $17B9D0 ORI.B  #$1685,A7
        DC.W    $0200,$874B         ; $17B9D4 ANDI.B  #$874B,D0
        DC.W    $0005,$4220         ; $17B9D8 ORI.B  #$4220,D5
        SUBI.B  #$0000,D0                       ; $17B9DC
        ORI.W  #$033F,(A0)+                     ; $17B9E0
        MOVE.W  $02E7(A0),$00(A7,D0.W)          ; $17B9E4
        DC.W    $0000,$FFFC         ; $17B9EA ORI.B  #$FFFC,D0
        DC.W    $0019,$1613         ; $17B9EE ORI.B  #$1613,(A1)+
        BTST    D0,D0                           ; $17B9F2
        OR.W   D3,A1                            ; $17B9F4
        TST.B  (A0)                             ; $17B9F6
        SUBI.B  #$0000,D0                       ; $17B9F8
        SUBI.B  #$0000,D0                       ; $17B9FC
        MOVE.W  $02E7(A0),$58(A7,D0.W)          ; $17BA00
        DC.W    $00B6,$FFFE,$000F,$162D; $17BA06 ORI.L  #$FFFE000F,$2D(A6,D1.W)
        BTST    D0,D0                           ; $17BA0E
        OR.W   D3,A3                            ; $17BA10
        CLR.B  (A0)                             ; $17BA12
        SUBI.B  #$0000,D0                       ; $17BA14
        ORI.W  #$00B6,(A0)+                     ; $17BA18
        MOVE.W  $02E7(A0),$58(A7,D0.W)          ; $17BA1C
        DC.W    $033F               ; $17BA22 BTST    D1,<EA:3F>
        DC.W    $FFFC,$001A         ; $17BA24 MOVE.W  #$001A,<EA:3F>
        MOVE.B  $0100(A7),-$78B6(PC)            ; $17BA28
        MOVE.L  -(A0),D1                        ; $17BA2E
        MOVE.W  $02E7(A0),$58(A7,D0.W)          ; $17BA30
        DC.W    $033F               ; $17BA36 BTST    D1,<EA:3F>
        MOVE.W  $0318(A0),$00(A7,D0.W)          ; $17BA38
        DC.W    $0000,$FFFC         ; $17BA3E ORI.B  #$FFFC,D0
        DC.W    $0019,$1613         ; $17BA42 ORI.B  #$1613,(A1)+
        DC.W    $0200,$8749         ; $17BA46 ANDI.B  #$8749,D0
        MOVE.L  (A0),D1                         ; $17BA4A
        MOVE.W  $02E7(A0),$58(A7,D0.W)          ; $17BA4C
        DC.W    $00B6,$FFA8,$0318,$0058; $17BA52 ORI.L  #$FFA80318,$58(A6,D0.W)
        DC.W    $033F               ; $17BA5A BTST    D1,<EA:3F>
        DC.W    $FFFC,$001A         ; $17BA5C MOVE.W  #$001A,<EA:3F>
        MOVE.B  $0200(A7),-$78B6(PC)            ; $17BA60
        MOVE.L  (A0),D5                         ; $17BA66
        MOVE.W  $02E7(A0),$00(A7,D0.W)          ; $17BA68
        DC.W    $0000,$FFA8         ; $17BA6E ORI.B  #$FFA8,D0
        BTST    D1,(A0)+                        ; $17BA72
        ORI.W  #$00B6,(A0)+                     ; $17BA74
        DC.W    $FFFE               ; $17BA78 MOVE.W  <EA:3E>,<EA:3F>
        DC.W    $000F,$162D         ; $17BA7A ORI.B  #$162D,A7
        DC.W    $0200,$874B         ; $17BA7E ANDI.B  #$874B,D0
        DC.W    $0008,$7970         ; $17BA82 ORI.B  #$7970,A0
        DC.W    $02C0               ; $17BA86 DC.W    $02C0
        DC.W    $0000,$016A         ; $17BA88 ORI.B  #$016A,D0
        DC.W    $0000,$0400         ; $17BA8C ORI.B  #$0400,D0
        DC.W    $0000,$03EA         ; $17BA90 ORI.B  #$03EA,D0
        DC.W    $0000,$0000         ; $17BA94 ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17BA98 ORI.B  #$2044,D0
        BTST    D0,D0                           ; $17BA9C
        DC.W    $001D,$6970         ; $17BA9E ORI.B  #$6970,(A5)+
        DC.W    $02C0               ; $17BAA2 DC.W    $02C0
        DC.W    $0000,$0400         ; $17BAA4 ORI.B  #$0400,D0
        DC.W    $0000,$0400         ; $17BAA8 ORI.B  #$0400,D0
        DC.W    $0000,$016A         ; $17BAAC ORI.B  #$016A,D0
        DC.W    $0000,$0000         ; $17BAB0 ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17BAB4 ORI.B  #$2044,D0
        BTST    D0,D0                           ; $17BAB8
        DC.W    $001C,$7920         ; $17BABA ORI.B  #$7920,(A4)+
        ANDI.L  #$000003EA,(A0)                 ; $17BABE
        DC.W    $0000,$02C0         ; $17BAC4 ORI.B  #$02C0,D0
        DC.W    $0000,$0400         ; $17BAC8 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17BACC ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17BAD0 ORI.B  #$2044,D0
        DC.W    $0200,$001E         ; $17BAD4 ANDI.B  #$001E,D0
        MOVE.W  -$70(A0,D0.W),$0000(A4)         ; $17BAD8
        BCHG    D0,$0000(A2)                    ; $17BADE
        DC.W    $02C0               ; $17BAE2 DC.W    $02C0
        DC.W    $0000,$03EA         ; $17BAE4 ORI.B  #$03EA,D0
        DC.W    $0000,$0000         ; $17BAE8 ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17BAEC ORI.B  #$2044,D0
        DC.W    $0200,$001D         ; $17BAF0 ANDI.B  #$001D,D0
        BVS.S  loc_17BB66                       ; $17BAF4
        ANDI.L  #$00000400,(A0)                 ; $17BAF6
        DC.W    $0000,$02C0         ; $17BAFC ORI.B  #$02C0,D0
        DC.W    $0000,$016A         ; $17BB00 ORI.B  #$016A,D0
        DC.W    $0000,$0000         ; $17BB04 ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17BB08 ORI.B  #$2044,D0
        DC.W    $0200,$001C         ; $17BB0C ANDI.B  #$001C,D0
        MOVE.W  -(A0),-(A4)                     ; $17BB10
        DC.W    $02C0               ; $17BB12 DC.W    $02C0
        DC.W    $0000,$03EA         ; $17BB14 ORI.B  #$03EA,D0
        DC.W    $0000,$0400         ; $17BB18 ORI.B  #$0400,D0
        DC.W    $0000,$0400         ; $17BB1C ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17BB20 ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17BB24 ORI.B  #$2044,D0
        SUBI.B  #$001E,D0                       ; $17BB28
        MOVE.W  -(A0),-(A4)                     ; $17BB2C
        ANDI.W  #$0000,(A0)                     ; $17BB2E
        BSET    D1,$0000(A2)                    ; $17BB32
        ANDI.L  #$00000400,(A0)                 ; $17BB36
        DC.W    $0000,$0000         ; $17BB3C ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17BB40 ORI.B  #$2044,D0
        BTST    D1,D0                           ; $17BB44
        DC.W    $001E,$7970         ; $17BB46 ORI.B  #$7970,(A6)+
        ANDI.W  #$0000,(A0)                     ; $17BB4A
        BCHG    D0,$0000(A2)                    ; $17BB4E
        ANDI.L  #$000003EA,(A0)                 ; $17BB52
        DC.W    $0000,$0000         ; $17BB58 ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17BB5C ORI.B  #$2044,D0
        BTST    D1,D0                           ; $17BB60
        DC.W    $001D,$6970         ; $17BB62 ORI.B  #$6970,(A5)+
loc_17BB66:
        ANDI.W  #$0000,(A0)                     ; $17BB66
        SUBI.B  #$0000,D0                       ; $17BB6A
        ANDI.L  #$0000016A,(A0)                 ; $17BB6E
        DC.W    $0000,$0000         ; $17BB74 ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17BB78 ORI.B  #$2044,D0
        BTST    D1,D0                           ; $17BB7C
        DC.W    $001C,$0008         ; $17BB7E ORI.B  #$0008,(A4)+
        SUBQ.W  #4,$00(A0,D0.W)                 ; $17BB82
        DC.W    $0000,$016A         ; $17BB86 ORI.B  #$016A,D0
        DC.W    $0000,$0280         ; $17BB8A ORI.B  #$0280,D0
        DC.W    $0000,$03EA         ; $17BB8E ORI.B  #$03EA,D0
        DC.W    $0000,$0000         ; $17BB92 ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17BB96 ORI.B  #$2044,D0
        BTST    D0,D0                           ; $17BB9A
        DC.W    $001D,$4970         ; $17BB9C ORI.B  #$4970,(A5)+
        SUBI.B  #$0000,D0                       ; $17BBA0
        SUBI.B  #$0000,D0                       ; $17BBA4
        ANDI.L  #$0000016A,D0                   ; $17BBA8
        DC.W    $0000,$0000         ; $17BBAE ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17BBB2 ORI.B  #$2044,D0
        BTST    D0,D0                           ; $17BBB6
        DC.W    $001C,$5920         ; $17BBB8 ORI.B  #$5920,(A4)+
        SUBI.B  #$0000,D0                       ; $17BBBC
        BSET    D1,$0000(A2)                    ; $17BBC0
        ANDI.L  #$00000400,D0                   ; $17BBC4
        DC.W    $0000,$0000         ; $17BBCA ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17BBCE ORI.B  #$2044,D0
        SUBI.B  #$001E,D0                       ; $17BBD2
        MOVE.W  -(A0),-(A4)                     ; $17BBD6
        ANDI.L  #$000003EA,D0                   ; $17BBD8
        DC.W    $0000,$02B0         ; $17BBDE ORI.B  #$02B0,D0
        DC.W    $0000,$0400         ; $17BBE2 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17BBE6 ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17BBEA ORI.B  #$2044,D0
        DC.W    $0200,$001E         ; $17BBEE ANDI.B  #$001E,D0
        MOVE.W  -$80(A0,D0.W),$0000(A4)         ; $17BBF2
        BCHG    D0,$0000(A2)                    ; $17BBF8
        DC.W    $02B0,$0000,$03EA,$0000; $17BBFC ANDI.L  #$000003EA,$00(A0,D0.W)
        DC.W    $0000,$0000         ; $17BC04 ORI.B  #$0000,D0
        MOVEA.L D4,A0                           ; $17BC08
        DC.W    $0200,$001D         ; $17BC0A ANDI.B  #$001D,D0
        BVS.S  loc_17BC80                       ; $17BC0E
        ANDI.L  #$00000400,D0                   ; $17BC10
        DC.W    $0000,$02B0         ; $17BC16 ORI.B  #$02B0,D0
        DC.W    $0000,$016A         ; $17BC1A ORI.B  #$016A,D0
        DC.W    $0000,$0000         ; $17BC1E ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17BC22 ORI.B  #$2044,D0
        DC.W    $0200,$001C         ; $17BC26 ANDI.B  #$001C,D0
        MOVE.W  -(A0),-(A4)                     ; $17BC2A
        DC.W    $02B0,$0000,$03EA,$0000; $17BC2C ANDI.L  #$000003EA,$00(A0,D0.W)
        DC.W    $02F0               ; $17BC34 DC.W    $02F0
        DC.W    $0000,$0400         ; $17BC36 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17BC3A ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17BC3E ORI.B  #$2044,D0
        BTST    D1,D0                           ; $17BC42
        DC.W    $001E,$7970         ; $17BC44 ORI.B  #$7970,(A6)+
        DC.W    $02B0,$0000,$016A,$0000; $17BC48 ANDI.L  #$0000016A,$00(A0,D0.W)
        DC.W    $02F0               ; $17BC50 DC.W    $02F0
        DC.W    $0000,$03EA         ; $17BC52 ORI.B  #$03EA,D0
        DC.W    $0000,$0000         ; $17BC56 ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17BC5A ORI.B  #$2044,D0
        BTST    D1,D0                           ; $17BC5E
        DC.W    $001D,$6970         ; $17BC60 ORI.B  #$6970,(A5)+
        DC.W    $02B0,$0000,$0400,$0000; $17BC64 ANDI.L  #$00000400,$00(A0,D0.W)
        DC.W    $02F0               ; $17BC6C DC.W    $02F0
        DC.W    $0000,$016A         ; $17BC6E ORI.B  #$016A,D0
        DC.W    $0000,$0000         ; $17BC72 ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17BC76 ORI.B  #$2044,D0
        BTST    D1,D0                           ; $17BC7A
        DC.W    $001C,$0005         ; $17BC7C ORI.B  #$0005,(A4)+
loc_17BC80:
        MOVE.L  (A0),-(A0)                      ; $17BC80
        MOVE.W  $0267(A0),$58(A7,D0.W)          ; $17BC82
        BTST    D0,(A7)                         ; $17BC88
        SUBI.B  #$0000,D0                       ; $17BC8A
        ORI.W  #$03A0,(A0)+                     ; $17BC8E
        DC.W    $FFFE               ; $17BC92 MOVE.W  <EA:3E>,<EA:3F>
        DC.W    $000D,$1A33         ; $17BC94 ORI.B  #$1A33,A5
        BTST    D0,D0                           ; $17BC98
        OR.W   D3,A0                            ; $17BC9A
        MOVE.L  (A0),-(A4)                      ; $17BC9C
        MOVE.W  $0267(A0),$00(A7,D0.W)          ; $17BC9E
        DC.W    $0000,$0400         ; $17BCA4 ORI.B  #$0400,D0
        DC.W    $0000,$0058         ; $17BCA8 ORI.B  #$0058,D0
        BTST    D0,(A7)                         ; $17BCAC
        DC.W    $FFFC,$0019         ; $17BCAE MOVE.W  #$0019,<EA:3F>
        MOVE.B  A0,#$0100                       ; $17BCB2
        OR.W   D3,A1                            ; $17BCB6
        MOVE.L  -(A0),-(A0)                     ; $17BCB8
        MOVE.W  $0267(A0),$58(A7,D0.W)          ; $17BCBA
        BCLR    D1,-(A0)                        ; $17BCC0
        SUBI.B  #$0000,D0                       ; $17BCC2
        SUBI.B  #$0000,D0                       ; $17BCC6
        DC.W    $0000,$0002         ; $17BCCA ORI.B  #$0002,D0
        MOVE.B  (A4)+,$0100(A5)                 ; $17BCCE
        OR.W   D3,D7                            ; $17BCD2
        MOVE.L  -(A0),D1                        ; $17BCD4
        MOVE.W  $0236(A0),$59(A7,D0.W)          ; $17BCD6
        BCLR    D1,-(A0)                        ; $17BCDC
        MOVE.W  $0267(A0),$00(A7,D0.W)          ; $17BCDE
        DC.W    $0000,$0000         ; $17BCE4 ORI.B  #$0000,D0
        DC.W    $0002,$1B5C         ; $17BCE8 ORI.B  #$1B5C,D2
        DC.W    $0200,$8747         ; $17BCEC ANDI.B  #$8747,D0
        MOVE.L  (A0),D5                         ; $17BCF0
        MOVE.W  $0236(A0),$00(A7,D0.W)          ; $17BCF2
        DC.W    $0000,$FFA8         ; $17BCF8 ORI.B  #$FFA8,D0
        ANDI.W  #$0059,-(A7)                    ; $17BCFC
        BTST    D0,(A7)                         ; $17BD00
        DC.W    $FFFC,$0019         ; $17BD02 MOVE.W  #$0019,<EA:3F>
        MOVE.B  A0,#$0200                       ; $17BD06
        OR.W   D3,A1                            ; $17BD0A
        MOVE.L  (A0),D1                         ; $17BD0C
        MOVE.W  $0236(A0),$59(A7,D0.W)          ; $17BD0E
        BTST    D0,(A7)                         ; $17BD14
        MOVE.W  $0267(A0),$59(A7,D0.W)          ; $17BD16
        BCLR    D1,-(A0)                        ; $17BD1C
        DC.W    $FFFE               ; $17BD1E MOVE.W  <EA:3E>,<EA:3F>
        DC.W    $000D,$1A33         ; $17BD20 ORI.B  #$1A33,A5
        DC.W    $0200,$8748         ; $17BD24 ANDI.B  #$8748,D0
        DC.W    $0003,$4220         ; $17BD28 ORI.B  #$4220,D3
        SUBI.B  #$0000,D0                       ; $17BD2C
        ORI.W  #$01C9,(A0)+                     ; $17BD30
        MOVE.W  $0235(A0),$00(A7,D0.W)          ; $17BD34
        DC.W    $0000,$FFFE         ; $17BD3A ORI.B  #$FFFE,D0
        DC.W    $000D,$19EB         ; $17BD3E ORI.B  #$19EB,A5
        BTST    D0,D0                           ; $17BD42
        OR.W   D3,A0                            ; $17BD44
        TST.B  (A0)                             ; $17BD46
        SUBI.B  #$0000,D0                       ; $17BD48
        SUBI.B  #$0000,D0                       ; $17BD4C
        MOVE.W  $0235(A0),$58(A7,D0.W)          ; $17BD50
        DC.W    $01C9               ; $17BD56 BSET    D0,A1
        DC.W    $FFFC,$0019         ; $17BD58 MOVE.W  #$0019,<EA:3F>
        MOVE.B  #$0100,-(A4)                    ; $17BD5C
        OR.W   D3,A1                            ; $17BD60
        MOVE.L  -(A0),D1                        ; $17BD62
        MOVE.W  $0235(A0),$59(A7,D0.W)          ; $17BD64
        DC.W    $01C9               ; $17BD6A BSET    D0,A1
        MOVE.W  $0266(A0),$00(A7,D0.W)          ; $17BD6C
        DC.W    $0000,$FFFE         ; $17BD72 ORI.B  #$FFFE,D0
        DC.W    $000D,$19EB         ; $17BD76 ORI.B  #$19EB,A5
        DC.W    $0200,$8748         ; $17BD7A ANDI.B  #$8748,D0
        MOVE.L  (A0),D5                         ; $17BD7E
        MOVE.W  $0235(A0),$00(A7,D0.W)          ; $17BD80
        DC.W    $0000,$FFA8         ; $17BD86 ORI.B  #$FFA8,D0
        ANDI.W  #$0059,-(A6)                    ; $17BD8A
        DC.W    $01C9               ; $17BD8E BSET    D0,A1
        DC.W    $FFFC,$0019         ; $17BD90 MOVE.W  #$0019,<EA:3F>
        MOVE.B  #$0200,-(A4)                    ; $17BD94
        OR.W   D3,A1                            ; $17BD98
        DC.W    $0005,$7920         ; $17BD9A ORI.B  #$7920,D5
        DC.W    $02C0               ; $17BD9E DC.W    $02C0
        DC.W    $0000,$026A         ; $17BDA0 ORI.B  #$026A,D0
        DC.W    $0000,$0400         ; $17BDA4 ORI.B  #$0400,D0
        DC.W    $0000,$0400         ; $17BDA8 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17BDAC ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17BDB0 ORI.B  #$2044,D0
        BTST    D0,D0                           ; $17BDB4
        DC.W    $001F,$7920         ; $17BDB6 ORI.B  #$7920,(A7)+
        ANDI.L  #$0000026A,(A0)                 ; $17BDBA
        DC.W    $0000,$02C0         ; $17BDC0 ORI.B  #$02C0,D0
        DC.W    $0000,$0400         ; $17BDC4 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17BDC8 ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17BDCC ORI.B  #$2044,D0
        DC.W    $0200,$001F         ; $17BDD0 ANDI.B  #$001F,D0
        BVS.S  loc_17BE46                       ; $17BDD4
        ANDI.L  #$00000400,(A0)                 ; $17BDD6
        DC.W    $0000,$02C0         ; $17BDDC ORI.B  #$02C0,D0
        DC.W    $0000,$026A         ; $17BDE0 ORI.B  #$026A,D0
        DC.W    $0000,$0000         ; $17BDE4 ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17BDE8 ORI.B  #$2044,D0
        DC.W    $0200,$001E         ; $17BDEC ANDI.B  #$001E,D0
        BVS.S  loc_17BE62                       ; $17BDF0
        DC.W    $02C0               ; $17BDF2 DC.W    $02C0
        DC.W    $0000,$0400         ; $17BDF4 ORI.B  #$0400,D0
        DC.W    $0000,$0400         ; $17BDF8 ORI.B  #$0400,D0
        DC.W    $0000,$026A         ; $17BDFC ORI.B  #$026A,D0
        DC.W    $0000,$0000         ; $17BE00 ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17BE04 ORI.B  #$2044,D0
        SUBI.B  #$001E,D0                       ; $17BE08
        BVS.S  loc_17BE7E                       ; $17BE0C
        ANDI.W  #$0000,(A0)                     ; $17BE0E
        SUBI.B  #$0000,D0                       ; $17BE12
        ANDI.L  #$0000026A,(A0)                 ; $17BE16
        DC.W    $0000,$0000         ; $17BE1C ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17BE20 ORI.B  #$2044,D0
        BTST    D1,D0                           ; $17BE24
        DC.W    $001E,$7920         ; $17BE26 ORI.B  #$7920,(A6)+
        ANDI.W  #$0000,(A0)                     ; $17BE2A
        ANDI.W  #$0000,$0290(A2)                ; $17BE2E
        DC.W    $0000,$0400         ; $17BE34 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17BE38 ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17BE3C ORI.B  #$2044,D0
        BTST    D1,D0                           ; $17BE40
        DC.W    $001F,$0005         ; $17BE42 ORI.B  #$0005,(A7)+
loc_17BE46:
        SUBQ.B  #4,-(A0)                        ; $17BE46
        SUBI.B  #$0000,D0                       ; $17BE48
        ANDI.W  #$0000,$0280(A2)                ; $17BE4C
        DC.W    $0000,$0400         ; $17BE52 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17BE56 ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17BE5A ORI.B  #$2044,D0
        BTST    D0,D0                           ; $17BE5E
        DC.W    $001F,$4970         ; $17BE60 ORI.B  #$4970,(A7)+
        SUBI.B  #$0000,D0                       ; $17BE64
        SUBI.B  #$0000,D0                       ; $17BE68
        ANDI.L  #$0000026A,D0                   ; $17BE6C
        DC.W    $0000,$0000         ; $17BE72 ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17BE76 ORI.B  #$2044,D0
        SUBI.B  #$001E,D0                       ; $17BE7A
loc_17BE7E:
        MOVE.W  -(A0),-(A4)                     ; $17BE7E
        ANDI.L  #$0000026A,D0                   ; $17BE80
        DC.W    $0000,$02B0         ; $17BE86 ORI.B  #$02B0,D0
        DC.W    $0000,$0400         ; $17BE8A ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17BE8E ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17BE92 ORI.B  #$2044,D0
        DC.W    $0200,$001F         ; $17BE96 ANDI.B  #$001F,D0
        BVS.S  loc_17BF0C                       ; $17BE9A
        ANDI.L  #$00000400,D0                   ; $17BE9C
        DC.W    $0000,$02B0         ; $17BEA2 ORI.B  #$02B0,D0
        DC.W    $0000,$026A         ; $17BEA6 ORI.B  #$026A,D0
        DC.W    $0000,$0000         ; $17BEAA ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17BEAE ORI.B  #$2044,D0
        DC.W    $0200,$001E         ; $17BEB2 ANDI.B  #$001E,D0
        MOVE.W  -(A0),-(A4)                     ; $17BEB6
        DC.W    $02B0,$0000,$026A,$0000; $17BEB8 ANDI.L  #$0000026A,$00(A0,D0.W)
        DC.W    $02F0               ; $17BEC0 DC.W    $02F0
        DC.W    $0000,$0400         ; $17BEC2 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17BEC6 ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17BECA ORI.B  #$2044,D0
        BTST    D1,D0                           ; $17BECE
        DC.W    $001F,$6970         ; $17BED0 ORI.B  #$6970,(A7)+
        DC.W    $02B0,$0000,$0400,$0000; $17BED4 ANDI.L  #$00000400,$00(A0,D0.W)
        DC.W    $02F0               ; $17BEDC DC.W    $02F0
        DC.W    $0000,$026A         ; $17BEDE ORI.B  #$026A,D0
        DC.W    $0000,$0000         ; $17BEE2 ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17BEE6 ORI.B  #$2044,D0
        BTST    D1,D0                           ; $17BEEA
        DC.W    $001E,$0004         ; $17BEEC ORI.B  #$0004,(A6)+
        DC.W    $4910               ; $17BEF0 DC.W    $4910
        SUBI.B  #$0000,D0                       ; $17BEF2
        SUBI.B  #$0000,D0                       ; $17BEF6
        SUBI.B  #$0000,D0                       ; $17BEFA
        ORI.W  #$FFA1,(A0)+                     ; $17BEFE
        DC.W    $FFFE               ; $17BF02 MOVE.W  <EA:3E>,<EA:3F>
        DC.W    $000D,$1BD4         ; $17BF04 ORI.B  #$1BD4,A5
        BTST    D0,D0                           ; $17BF08
        OR.W   D3,A0                            ; $17BF0A
loc_17BF0C:
        MOVE.L  (A0),-(A0)                      ; $17BF0C
        MOVE.W  $01B5(A0),$58(A7,D0.W)          ; $17BF0E
        MOVE.W  -(A1),$00(A7,D0.W)              ; $17BF14
        DC.W    $0000,$0058         ; $17BF18 ORI.B  #$0058,D0
        DC.W    $022A,$0000,$0002   ; $17BF1C ANDI.B  #$0000,$0002(A2)
        MOVE.B  $00(A6,D0.W),$47(A5,A0.W)       ; $17BF22
        MOVE.L  -(A0),-(A0)                     ; $17BF28
        MOVE.W  $01B5(A0),$58(A7,D0.W)          ; $17BF2A
        DC.W    $022A,$0400,$0000   ; $17BF30 ANDI.B  #$0400,$0000(A2)
        SUBI.B  #$0000,D0                       ; $17BF36
        DC.W    $0000,$FFFD         ; $17BF3A ORI.B  #$FFFD,D0
        MOVE.B  (A4)+,D6                        ; $17BF3E
        BTST    D0,D0                           ; $17BF40
        OR.W   D3,D6                            ; $17BF42
        MOVE.L  (A0),D5                         ; $17BF44
        MOVE.W  $0184(A0),$00(A7,D0.W)          ; $17BF46
        DC.W    $0000,$FFA8         ; $17BF4C ORI.B  #$FFA8,D0
        BCLR    D0,$59(A5,D0.W)                 ; $17BF50
        DC.W    $022A,$0000,$0002   ; $17BF54 ANDI.B  #$0000,$0002(A2)
        MOVE.B  $00(A6,D0.W),$47(A5,A0.W)       ; $17BF5A
        MOVE.L  -(A0),D1                        ; $17BF60
        MOVE.W  $0184(A0),$59(A7,D0.W)          ; $17BF62
        DC.W    $022A,$FFA8,$01B5   ; $17BF68 ANDI.B  #$FFA8,$01B5(A2)
        SUBI.B  #$0000,D0                       ; $17BF6E
        DC.W    $0000,$FFFD         ; $17BF72 ORI.B  #$FFFD,D0
        MOVE.B  (A4)+,D6                        ; $17BF76
        DC.W    $0200,$8746         ; $17BF78 ANDI.B  #$8746,D0
        DC.W    $0005,$4A10         ; $17BF7C ORI.B  #$4A10,D5
        SUBI.B  #$0000,D0                       ; $17BF80
        SUBI.B  #$0000,D0                       ; $17BF84
        MOVE.W  $0183(A0),$58(A7,D0.W)          ; $17BF88
        ORI.W  #$FFFE,(A2)                      ; $17BF8E
        DC.W    $000D,$1B8C         ; $17BF92 ORI.B  #$1B8C,A5
        BTST    D0,D0                           ; $17BF96
        OR.W   D3,A0                            ; $17BF98
        CLR.B  (A0)                             ; $17BF9A
        SUBI.B  #$0000,D0                       ; $17BF9C
        ORI.W  #$0052,(A0)+                     ; $17BFA0
        MOVE.W  $0183(A0),$58(A7,D0.W)          ; $17BFA4
        DC.W    $02DC               ; $17BFAA DC.W    $02DC
        DC.W    $0000,$0002         ; $17BFAC ORI.B  #$0002,D0
        MOVE.B  -(A6),$00(A5,D0.W)              ; $17BFB0
        OR.W   D3,D7                            ; $17BFB4
        CLR.B  -(A0)                            ; $17BFB6
        SUBI.B  #$0000,D0                       ; $17BFB8
        ORI.W  #$02DC,(A0)+                     ; $17BFBC
        MOVE.W  $0183(A0),$00(A7,D0.W)          ; $17BFC0
        DC.W    $0000,$0000         ; $17BFC6 ORI.B  #$0000,D0
        DC.W    $FFFD               ; $17BFCA MOVE.W  <EA:3D>,<EA:3F>
        MOVE.B  $0100(A5),D6                    ; $17BFCC
        OR.W   D3,D6                            ; $17BFD0
        MOVE.L  (A0),D5                         ; $17BFD2
        MOVE.W  $0183(A0),$00(A7,D0.W)          ; $17BFD4
        DC.W    $0000,$FFA8         ; $17BFDA ORI.B  #$FFA8,D0
        BCLR    D0,$59(A4,D0.W)                 ; $17BFDE
        ORI.W  #$FFFE,(A2)                      ; $17BFE2
        DC.W    $000D,$1B8C         ; $17BFE6 ORI.B  #$1B8C,A5
        DC.W    $0200,$8748         ; $17BFEA ANDI.B  #$8748,D0
        MOVE.L  (A0),D1                         ; $17BFEE
        MOVE.W  $0183(A0),$59(A7,D0.W)          ; $17BFF0
        ORI.W  #$FFA8,(A2)                      ; $17BFF6
        BCLR    D0,$59(A4,D0.W)                 ; $17BFFA
        DC.W    $02DC               ; $17BFFE DC.W    $02DC
        DC.W    $0000,$0002         ; $17C000 ORI.B  #$0002,D0
        MOVE.B  -(A6),$00(A5,D0.W)              ; $17C004
        OR.W   D3,D7                            ; $17C008
        MOVE.L  -(A0),D1                        ; $17C00A
        MOVE.W  $0183(A0),$59(A7,D0.W)          ; $17C00C
        DC.W    $02DC               ; $17C012 DC.W    $02DC
        MOVE.W  $01B4(A0),$00(A7,D0.W)          ; $17C014
        DC.W    $0000,$0000         ; $17C01A ORI.B  #$0000,D0
        DC.W    $FFFD               ; $17C01E MOVE.W  <EA:3D>,<EA:3F>
        MOVE.B  $0200(A5),D6                    ; $17C020
        OR.W   D3,D6                            ; $17C024
        DC.W    $0009,$5DE0         ; $17C026 ORI.B  #$5DE0,A1
        SUBI.B  #$0000,D0                       ; $17C02A
        BCHG    D1,$0000(A2)                    ; $17C02E
        DC.W    $02C0               ; $17C032 DC.W    $02C0
        DC.W    $0000,$00EA         ; $17C034 ORI.B  #$00EA,D0
        DC.W    $0000,$0000         ; $17C038 ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17C03C ORI.B  #$2044,D0
        BTST    D0,D0                           ; $17C040
        DC.W    $0020,$6970         ; $17C042 ORI.B  #$6970,-(A0)
        DC.W    $02C0               ; $17C046 DC.W    $02C0
        DC.W    $0000,$0400         ; $17C048 ORI.B  #$0400,D0
        DC.W    $0000,$0400         ; $17C04C ORI.B  #$0400,D0
        DC.W    $0000,$00EA         ; $17C050 ORI.B  #$00EA,D0
        DC.W    $0000,$0000         ; $17C054 ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17C058 ORI.B  #$2044,D0
        BTST    D0,D0                           ; $17C05C
        DC.W    $001F,$5620         ; $17C05E ORI.B  #$5620,(A7)+
        SUBI.B  #$0000,D0                       ; $17C062
        DC.W    $0035,$0266,$01A5   ; $17C066 ORI.B  #$0266,-$5B(A5,D0.W)
        DC.W    $FFF1,$0400         ; $17C06C MOVE.W  $00(A1,D0.W),<EA:3F>
        DC.W    $0000,$0000         ; $17C070 ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17C074 ORI.B  #$2044,D0
        BTST    D0,D0                           ; $17C078
        MOVE.W  -(A1),-(A5)                     ; $17C07A
        SUBQ.B  #3,-(A0)                        ; $17C07C
        SUBI.B  #$0000,D0                       ; $17C07E
        BCLR    D0,-(A5)                        ; $17C082
        DC.W    $FFF1,$036A         ; $17C084 MOVE.W  $6A(A1,D0.W),<EA:3F>
        DC.W    $0000,$0400         ; $17C088 ORI.B  #$0400,D0
        DC.W    $0000,$0000         ; $17C08C ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17C090 ORI.B  #$2044,D0
        BTST    D0,D0                           ; $17C094
        CMPI.B  #$BA20,-(A1)                    ; $17C096
        DC.W    $0035,$0236,$036A   ; $17C09A ORI.B  #$0236,$6A(A5,D0.W)
        DC.W    $0000,$0035         ; $17C0A0 ORI.B  #$0035,D0
        ANDI.W  #$0400,-(A6)                    ; $17C0A4
        DC.W    $0000,$0000         ; $17C0A8 ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17C0AC ORI.B  #$2044,D0
        DC.W    $0200,$FB21         ; $17C0B0 ANDI.B  #$FB21,D0
        MOVE.W  -$70(A0,D0.W),$0000(A4)         ; $17C0B4
        DC.W    $00EA               ; $17C0BA DC.W    $00EA
        DC.W    $0000,$02C0         ; $17C0BC ORI.B  #$02C0,D0
        DC.W    $0000,$036A         ; $17C0C0 ORI.B  #$036A,D0
        DC.W    $0000,$0000         ; $17C0C4 ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17C0C8 ORI.B  #$2044,D0
        DC.W    $0200,$0020         ; $17C0CC ANDI.B  #$0020,D0
        BVS.S  loc_17C142                       ; $17C0D0
        ANDI.L  #$00000400,(A0)                 ; $17C0D2
        DC.W    $0000,$02C0         ; $17C0D8 ORI.B  #$02C0,D0
        DC.W    $0000,$00EA         ; $17C0DC ORI.B  #$00EA,D0
        DC.W    $0000,$0000         ; $17C0E0 ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17C0E4 ORI.B  #$2044,D0
        DC.W    $0200,$001F         ; $17C0E8 ANDI.B  #$001F,D0
        CMP.B  -(A0),D5                         ; $17C0EC
        DC.W    $0000,$0250         ; $17C0EE ORI.B  #$0250,D0
        BCHG    D1,$0000(A2)                    ; $17C0F2
        DC.W    $0035,$0236,$0400   ; $17C0F6 ORI.B  #$0236,$00(A5,D0.W)
        DC.W    $0000,$0000         ; $17C0FC ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17C100 ORI.B  #$2044,D0
        BTST    D1,D0                           ; $17C104
        MOVE.W  -(A1),-(A6)                     ; $17C106
        MOVE.W  $50(A0,D0.W),$0000(A4)          ; $17C108
        DC.W    $00EA               ; $17C10E DC.W    $00EA
        DC.W    $0000,$0290         ; $17C110 ORI.B  #$0290,D0
        DC.W    $0000,$036A         ; $17C114 ORI.B  #$036A,D0
        DC.W    $0000,$0000         ; $17C118 ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17C11C ORI.B  #$2044,D0
        BTST    D1,D0                           ; $17C120
        DC.W    $0020,$6970         ; $17C122 ORI.B  #$6970,-(A0)
        ANDI.W  #$0000,(A0)                     ; $17C126
        SUBI.B  #$0000,D0                       ; $17C12A
        ANDI.L  #$000000EA,(A0)                 ; $17C12E
        DC.W    $0000,$0000         ; $17C134 ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17C138 ORI.B  #$2044,D0
        BTST    D1,D0                           ; $17C13C
        DC.W    $001F,$000A         ; $17C13E ORI.B  #$000A,(A7)+
loc_17C142:
        SUBQ.W  #6,-(A0)                        ; $17C142
        ANDI.L  #$0000036A,D0                   ; $17C144
        DC.W    $0000,$0400         ; $17C14A ORI.B  #$0400,D0
        DC.W    $0000,$00EA         ; $17C14E ORI.B  #$00EA,D0
        DC.W    $0000,$0000         ; $17C152 ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17C156 ORI.B  #$2044,D0
        BTST    D0,D0                           ; $17C15A
        DC.W    $0020,$4970         ; $17C15C ORI.B  #$4970,-(A0)
        SUBI.B  #$0000,D0                       ; $17C160
        SUBI.B  #$0000,D0                       ; $17C164
        ANDI.L  #$000000EA,D0                   ; $17C168
        DC.W    $0000,$0000         ; $17C16E ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17C172 ORI.B  #$2044,D0
        BTST    D0,D0                           ; $17C176
        DC.W    $001F,$4B10         ; $17C178 ORI.B  #$4B10,(A7)+
        SUBI.B  #$0000,D0                       ; $17C17C
        SUBI.B  #$0000,D0                       ; $17C180
        BCHG    D1,$0000(A2)                    ; $17C184
        MOVE.W  -(A1),(A7)                      ; $17C188
        BTST    D2,-(A2)                        ; $17C18A
        DC.W    $0000,$0000         ; $17C18C ORI.B  #$0000,D0
        MOVEA.L D4,A0                           ; $17C190
        BTST    D0,D0                           ; $17C192
        CMPI.B  #$8AA0,-(A1)                    ; $17C194
        DC.W    $FFF8,$028F         ; $17C198 MOVE.W  $028F.W,<EA:3F>
        SUBI.B  #$0000,D0                       ; $17C19C
        MOVE.W  A0,(A7)                         ; $17C1A0
        BTST    D2,D4                           ; $17C1A2
        SUBI.B  #$0000,D0                       ; $17C1A4
        DC.W    $0000,$0000         ; $17C1A8 ORI.B  #$0000,D0
        MOVEA.L D4,A0                           ; $17C1AC
        BTST    D0,D0                           ; $17C1AE
        MOVE.W  -(A1),-(A5)                     ; $17C1B0
        OR.B   -(A0),D4                         ; $17C1B2
        MOVE.W  A0,(A7)                         ; $17C1B4
        BTST    D2,D4                           ; $17C1B6
        SUBI.B  #$0000,D0                       ; $17C1B8
        MOVE.W  -(A1),(A7)                      ; $17C1BC
        BTST    D2,-(A2)                        ; $17C1BE
        SUBI.B  #$0000,D0                       ; $17C1C0
        DC.W    $0000,$0000         ; $17C1C4 ORI.B  #$0000,D0
        MOVEA.L D4,A0                           ; $17C1C8
        BTST    D0,D0                           ; $17C1CA
        MOVE.W  -(A1),-(A5)                     ; $17C1CC
        CMP.B  -(A0),D5                         ; $17C1CE
        DC.W    $FFF8,$028F         ; $17C1D0 MOVE.W  $028F.W,<EA:3F>
        BCHG    D1,$0000(A2)                    ; $17C1D4
        DC.W    $FFF8,$02BF         ; $17C1D8 MOVE.W  $02BF.W,<EA:3F>
        SUBI.B  #$0000,D0                       ; $17C1DC
        DC.W    $0000,$0000         ; $17C1E0 ORI.B  #$0000,D0
        MOVEA.L D4,A0                           ; $17C1E4
        DC.W    $0200,$0021         ; $17C1E6 ANDI.B  #$0021,D0
        MOVE.W  -$80(A0,D0.W),$0000(A4)         ; $17C1EA
        DC.W    $00EA               ; $17C1F0 DC.W    $00EA
        DC.W    $0000,$02B0         ; $17C1F2 ORI.B  #$02B0,D0
        DC.W    $0000,$036A         ; $17C1F6 ORI.B  #$036A,D0
        DC.W    $0000,$0000         ; $17C1FA ORI.B  #$0000,D0
        DC.W    $0000,$2044         ; $17C1FE ORI.B  #$2044,D0
