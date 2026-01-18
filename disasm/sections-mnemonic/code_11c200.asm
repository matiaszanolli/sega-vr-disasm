; Generated assembly for $11C200-$11E200
; Branch targets: 68
; Labels: 68
; Format: DC.W with decoded mnemonics as comments

        org     $11C200

        DC.W    $0019,$0106         ; $11C200 ORI.B  #$0106,(A1)+
        BTST    D1,D5                           ; $11C204
        ADDQ.B  #2,D0                           ; $11C206
        DC.W    $0027,$6A00         ; $11C208 ORI.B  #$6A00,-(A7)
        BTST    D1,D1                           ; $11C20C
        BTST    D0,D2                           ; $11C20E
        BTST    D0,D1                           ; $11C210
        DC.W    $0E00               ; $11C212 DC.W    $0E00
        DC.W    $0002,$0003         ; $11C214 ORI.B  #$0003,D2
        DC.W    $0008,$001B         ; $11C218 ORI.B  #$001B,A0
        DC.W    $001A,$0015         ; $11C21C ORI.B  #$0015,(A2)+
        DC.W    $0216,$0118         ; $11C220 ANDI.B  #$0118,(A6)
        MOVE.B  (A7),D2                         ; $11C224
        DC.W    $0019,$0003         ; $11C226 ORI.B  #$0003,(A1)+
        DC.W    $001E,$001B         ; $11C22A ORI.B  #$001B,(A6)+
        MOVE.B  (A7),D4                         ; $11C22E
        BTST    D0,(A0)+                        ; $11C230
        BTST    D0,(A6)                         ; $11C232
        BTST    D0,(A5)                         ; $11C234
        DC.W    $0014,$001A         ; $11C236 ORI.B  #$001A,(A4)
        DC.W    $0012,$0010         ; $11C23A ORI.B  #$0010,(A2)
        DC.W    $000F,$001C         ; $11C23E ORI.B  #$001C,A7
        DC.W    $000C,$001D         ; $11C242 ORI.B  #$001D,A4
        DC.W    $000A,$0009         ; $11C246 ORI.B  #$0009,A2
        DC.W    $001F,$0019         ; $11C24A ORI.B  #$0019,(A7)+
        DC.W    $0006,$0204         ; $11C24E ORI.B  #$0204,D6
        DC.W    $0203,$0302         ; $11C252 ANDI.B  #$0302,D3
        SUBI.B  #$5E00,D1                       ; $11C256
        DC.W    $003A,$8300,$0002   ; $11C25A ORI.B  #$8300,$0002(PC)
        DC.W    $0003,$0204         ; $11C260 ORI.B  #$0204,D3
        DC.W    $0005,$0006         ; $11C264 ORI.B  #$0006,D5
        DC.W    $0007,$001F         ; $11C268 ORI.B  #$001F,D7
        DC.W    $0009,$001E         ; $11C26C ORI.B  #$001E,A1
        DC.W    $000B,$000C         ; $11C270 ORI.B  #$000C,A3
        DC.W    $000D,$000E         ; $11C274 ORI.B  #$000E,A5
        DC.W    $000F,$001B         ; $11C278 ORI.B  #$001B,A7
        DC.W    $0011,$0012         ; $11C27C ORI.B  #$0012,(A1)
        DC.W    $001A,$0014         ; $11C280 ORI.B  #$0014,(A2)+
        DC.W    $0015,$0016         ; $11C284 ORI.B  #$0016,(A5)
        DC.W    $0018,$0417         ; $11C288 ORI.B  #$0417,(A0)+
        DC.W    $0018,$0019         ; $11C28C ORI.B  #$0019,(A0)+
        BTST    D0,D0                           ; $11C290
        DC.W    $0004,$0008         ; $11C292 ORI.B  #$0008,D4
        DC.W    $001C,$0014         ; $11C296 ORI.B  #$0014,(A4)+
        DC.W    $0018,$0617         ; $11C29A ORI.B  #$0617,(A0)+
        DC.W    $0018,$0016         ; $11C29E ORI.B  #$0016,(A0)+
        DC.W    $0015,$0014         ; $11C2A2 ORI.B  #$0014,(A5)
        DC.W    $001A,$0012         ; $11C2A6 ORI.B  #$0012,(A2)+
        DC.W    $0010,$001B         ; $11C2AA ORI.B  #$001B,(A0)
        DC.W    $000F,$001C         ; $11C2AE ORI.B  #$001C,A7
        DC.W    $000D,$001D         ; $11C2B2 ORI.B  #$001D,A5
        DC.W    $000A,$001E         ; $11C2B6 ORI.B  #$001E,A2
        DC.W    $0008,$001F         ; $11C2BA ORI.B  #$001F,A0
        DC.W    $0019,$0006         ; $11C2BE ORI.B  #$0006,(A1)+
        DC.W    $0204,$0203         ; $11C2C2 ANDI.B  #$0203,D4
        DC.W    $0202,$0201         ; $11C2C6 ANDI.B  #$0201,D2
        DC.W    $0200,$0001         ; $11C2CA ANDI.B  #$0001,D0
        DC.W    $0202,$6900         ; $11C2CE ANDI.B  #$6900,D2
        DC.W    $0011,$8B00         ; $11C2D2 ORI.B  #$8B00,(A1)
        DC.W    $0201,$0302         ; $11C2D6 ANDI.B  #$0302,D1
        BTST    D1,D3                           ; $11C2DA
        SUBI.B  #$0505,D4                       ; $11C2DC
        DC.W    $0003,$0300         ; $11C2E0 ORI.B  #$0300,D3
        DC.W    $0002,$0003         ; $11C2E4 ORI.B  #$0003,D2
        DC.W    $0005,$0006         ; $11C2E8 ORI.B  #$0006,D5
        BTST    D2,D5                           ; $11C2EC
        BTST    D1,D4                           ; $11C2EE
        BTST    D1,D3                           ; $11C2F0
        BTST    D1,D2                           ; $11C2F2
        DC.W    $0201,$7F00         ; $11C2F4 ANDI.B  #$7F00,D1
        DC.W    $0001,$FF00         ; $11C2F8 ORI.B  #$FF00,D1
        MOVE.W  D0,-(A7)                        ; $11C2FC
        ORI.L  #$00390100,-(A7)                 ; $11C2FE
        DC.W    $0000,$0842         ; $11C304 ORI.B  #$0842,D0
        CMPI.W  #$294A,-(A3)                    ; $11C308
        MOVE.W  A4,$6B(A0,D2.L)                 ; $11C30C
        MOVE.L  $2108(A1),-(A2)                 ; $11C310
        SUBI.B  #$1084,-(A1)                    ; $11C314
        MOVE.B  -(A5),(A2)                      ; $11C318
        MOVE.B  D6,(A4)+                        ; $11C31A
        MOVE.W  A6,#$3DEF                       ; $11C31C
        CLR.B  (A0)                             ; $11C320
        NOT.B  $52(A1,D4.L)                     ; $11C322
        RTE                                     ; $11C326
loc_11C328:
        ADDQ.L  #1,(A4)                         ; $11C328
        ADDQ.L  #3,-$2A(A5,D5.L)                ; $11C32A
        SGT     $18(A7,D6.W)                    ; $11C32E
        BEQ.S  loc_11C36D                       ; $11C332
        DC.W    $77BD,$7FFF         ; $11C334 MOVE.W  <EA:3D>,-$01(A3,D7.L)
        MOVE.W  (A4)+,-$53(A1,D3.W)             ; $11C338
        MOVE.B  -(A7),(A6)+                     ; $11C33C
        BMI.S  loc_11C39A                       ; $11C33E
        DC.W    $7BDE               ; $11C340 MOVE.W  (A6)+,<EA:3D>
        BLE.S  loc_11C3BF                       ; $11C342
        DC.W    $7FFC,$76CF         ; $11C344 MOVE.W  #$76CF,<EA:3F>
        MOVEQ   #-$30,D1                        ; $11C348
        MOVEQ   #-$0F,D3                        ; $11C34A
        DC.W    $7FDC               ; $11C34C MOVE.W  (A4)+,<EA:3F>
        MOVE.W  (A1)+,$78(A7,D7.L)              ; $11C34E
        MOVE.W  $76(A7,D7.L),$7F55(A7)          ; $11C352
        MOVE.W  $33(A4,D7.L),-(A7)              ; $11C358
        MOVE.W  $32(A3,D7.L),-(A5)              ; $11C35C
        MOVEQ   #-$0F,D5                        ; $11C360
        MOVEQ   #-$10,D5                        ; $11C362
        MOVEQ   #-$31,D5                        ; $11C364
        MOVEQ   #-$32,D5                        ; $11C366
        MOVEQ   #-$53,D3                        ; $11C368
        MOVEQ   #-$54,D3                        ; $11C36A
        MOVEQ   #-$54,D5                        ; $11C36C
        DC.W    $7FFD               ; $11C36E MOVE.W  <EA:3D>,<EA:3F>
        MOVE.W  (A4),$728C(A7)                  ; $11C370
        BVS.S  loc_11C35A                       ; $11C374
        BVS.S  loc_11C35D                       ; $11C376
        BGT.S  loc_11C328                       ; $11C378
        MOVEQ   #-$51,D1                        ; $11C37A
        MOVE.W  (A5),$7FFE(A5)                  ; $11C37C
        DC.W    $7FDB               ; $11C380 MOVE.W  (A3)+,<EA:3F>
        MOVE.W  $7B35(PC),$14(A7,D7.W)          ; $11C382
        MOVE.W  (A3),-(A3)                      ; $11C388
        MOVEQ   #-$0E,D3                        ; $11C38A
loc_11C38C:
        MOVEQ   #-$2F,D1                        ; $11C38C
        BGT.S  loc_11C31E                       ; $11C38E
loc_11C390:
        BGT.S  loc_11C31F                       ; $11C390
        MOVEQ   #-$73,D1                        ; $11C392
        MOVE.W  $28(A4,D6.L),-(A5)              ; $11C394
        BGT.S  loc_11C3C1                       ; $11C398
loc_11C39A:
        BGT.S  loc_11C3A2                       ; $11C39A
        BGT.S  loc_11C3A3                       ; $11C39C
        BGT.S  loc_11C3A4                       ; $11C39E
        MOVEQ   #$04,D1                         ; $11C3A0
loc_11C3A2:
        MOVEQ   #$05,D3                         ; $11C3A2
loc_11C3A4:
        MOVEQ   #$69,D3                         ; $11C3A4
        MOVE.W  (A0)+,$48(A7,D6.L)              ; $11C3A6
        BCS.S  loc_11C390                       ; $11C3AA
        BGT.S  loc_11C3D7                       ; $11C3AC
        MOVEQ   #-$11,D7                        ; $11C3AE
        MOVEQ   #-$75,D5                        ; $11C3B0
        MOVEQ   #-$75,D3                        ; $11C3B2
        MOVEQ   #-$53,D5                        ; $11C3B4
        MOVEQ   #-$33,D5                        ; $11C3B6
        MOVEQ   #-$75,D1                        ; $11C3B8
        MOVEQ   #$6A,D1                         ; $11C3BA
        BGT.S  loc_11C408                       ; $11C3BC
        BPL.S  loc_11C3E8                       ; $11C3BE
        BPL.S  loc_11C3E9                       ; $11C3C0
        BPL.S  loc_11C3CB                       ; $11C3C2
        BPL.S  loc_11C3CC                       ; $11C3C4
        BCS.S  loc_11C38C                       ; $11C3C6
        BGT.S  loc_11C436                       ; $11C3C8
        MOVE.W  $7F97.W,$32(A7,D7.L)            ; $11C3CA
        MOVEQ   #$68,D3                         ; $11C3D0
        MOVEQ   #$47,D1                         ; $11C3D2
        MOVEQ   #-$52,D3                        ; $11C3D4
        DC.W    $7FDA               ; $11C3D6 MOVE.W  (A2)+,<EA:3F>
        MOVEQ   #-$10,D7                        ; $11C3D8
        MOVEQ   #$47,D3                         ; $11C3DA
        MOVEQ   #$26,D3                         ; $11C3DC
        MOVEQ   #$48,D1                         ; $11C3DE
        MOVEQ   #$26,D1                         ; $11C3E0
        BCS.S  loc_11C3C9                       ; $11C3E2
        MOVEQ   #-$12,D7                        ; $11C3E4
        MOVEQ   #$05,D1                         ; $11C3E6
loc_11C3E8:
        MOVEQ   #-$51,D3                        ; $11C3E8
        MOVEQ   #-$30,D3                        ; $11C3EA
        MOVE.W  #$7249,$69(A7,D7.W)             ; $11C3EC
        MOVEQ   #-$55,D7                        ; $11C3F2
        BNE.S  loc_11C3FD                       ; $11C3F4
        BSR.S  loc_11C3BD                       ; $11C3F6
        MOVE.W  $46(A6,D7.W),-(A3)              ; $11C3F8
        BPL.S  loc_11C427                       ; $11C3FC
        BPL.S  loc_11C449                       ; $11C3FE
        BPL.S  loc_11C44C                       ; $11C400
        BPL.S  loc_11C44F                       ; $11C402
        BPL.S  loc_11C471                       ; $11C404
        DC.W    $7FB9,$7FD9,$7FFB,$768D; $11C406 MOVE.W  $7FD97FFB,-$73(A7,D7.W)
loc_11C40E:
        BGT.S  loc_11C479                       ; $11C40E
        BGT.S  loc_11C47D                       ; $11C410
        DC.W    $7FDE               ; $11C412 MOVE.W  (A6)+,<EA:3F>
        MOVEQ   #$25,D1                         ; $11C414
        MOVEQ   #-$76,D5                        ; $11C416
loc_11C418:
        MOVE.W  (A6),$75(A7,D7.L)               ; $11C418
        MOVE.W  $11(A4,D7.L),$72AC(A7)          ; $11C41C
        MOVEQ   #$68,D1                         ; $11C422
        BLT.S  loc_11C409                       ; $11C424
        BVS.S  loc_11C40B                       ; $11C426
loc_11C428:
        BPL.S  loc_11C42F                       ; $11C428
        BCS.S  loc_11C3EF                       ; $11C42A
        BSR.S  loc_11C3D1                       ; $11C42C
        SUBQ.L  #6,-(A3)                        ; $11C42E
        BSR.S  loc_11C418                       ; $11C430
        MOVEQ   #-$53,D7                        ; $11C432
        DC.W    $7FFA,$7F10         ; $11C434 MOVE.W  $7F10(PC),<EA:3F>
        MOVE.W  $27(A1,D6.W),-(A7)              ; $11C438
loc_11C43C:
        BSR.S  loc_11C421                       ; $11C43C
        BCS.S  loc_11C423                       ; $11C43E
        BVS.S  loc_11C405                       ; $11C440
        MOVE.W  $6E25.W,$7224(A5)               ; $11C442
        MOVEQ   #$46,D1                         ; $11C448
        SUBQ.L  #6,D2                           ; $11C44A
loc_11C44C:
        MOVE.W  (A2),-(A3)                      ; $11C44C
        BSR.S  loc_11C435                       ; $11C44E
        MOVE.W  -(A3),$7756.W                   ; $11C450
        MOVE.W  (A1),-(A5)                      ; $11C454
        MOVEQ   #-$77,D5                        ; $11C456
loc_11C458:
        MOVEQ   #-$55,D5                        ; $11C458
        MOVEQ   #-$52,D1                        ; $11C45A
        MOVEQ   #-$31,D1                        ; $11C45C
        MOVE.W  (A5),$69(A7,D7.L)               ; $11C45E
loc_11C462:
        MOVEQ   #-$0D,D1                        ; $11C462
        BGT.S  loc_11C415                       ; $11C464
        MOVE.W  (A3)+,$0F(A5,D7.L)              ; $11C466
        SLT     D4                              ; $11C46A
        DC.W    $7B79,$7203,$7FB7,$7F52; $11C46C MOVE.W  $72037FB7,$7F52(A5)
        BLT.S  loc_11C458                       ; $11C474
        BVS.S  loc_11C43A                       ; $11C476
        BCS.S  loc_11C43C                       ; $11C478
        BSR.S  loc_11C41E                       ; $11C47A
        SUBQ.L  #6,D1                           ; $11C47C
        MOVE.W  -(A2),$6582.W                   ; $11C47E
        BLT.S  loc_11C446                       ; $11C482
        BVS.S  loc_11C428                       ; $11C484
        BLT.S  loc_11C46D                       ; $11C486
        BCS.S  loc_11C42D                       ; $11C488
        BSR.S  loc_11C40E                       ; $11C48A
        BNE.S  loc_11C496                       ; $11C48C
        MOVEQ   #-$75,D7                        ; $11C48E
        BGT.S  loc_11C499                       ; $11C490
        BVS.S  loc_11C458                       ; $11C492
        MOVEQ   #$49,D3                         ; $11C494
loc_11C496:
        MOVE.W  (A4),-(A1)                      ; $11C496
        BLT.S  loc_11C45D                       ; $11C498
        SUBQ.W  #4,-(A1)                        ; $11C49A
        SUBQ.W  #4,-(A2)                        ; $11C49C
        MOVEQ   #-$2E,D1                        ; $11C49E
        BHI.S  loc_11C4CB                       ; $11C4A0
        MOVE.W  #$6A6C,$57(A5,D7.L)             ; $11C4A2
        SLT     D5                              ; $11C4A8
        SUBQ.W  #2,-(A1)                        ; $11C4AA
        SUBQ.L  #4,-(A4)                        ; $11C4AC
        SUBQ.L  #4,D3                           ; $11C4AE
loc_11C4B0:
        DC.W    $7BDD               ; $11C4B0 MOVE.W  (A5)+,<EA:3D>
        SUBQ.W  #2,-(A2)                        ; $11C4B2
        BPL.S  loc_11C445                       ; $11C4B4
        MOVE.W  (A3),-(A1)                      ; $11C4B6
        BNE.S  loc_11C527                       ; $11C4B8
        BNE.S  loc_11C507                       ; $11C4BA
        SUBQ.W  #4,D0                           ; $11C4BC
        SUBQ.W  #2,-(A0)                        ; $11C4BE
        MOVE.W  $69C1.W,$65A1(A3)               ; $11C4C0
        BSR.S  loc_11C468                       ; $11C4C6
        SUBQ.L  #6,D0                           ; $11C4C8
        SUBQ.L  #4,D0                           ; $11C4CA
        MOVE.W  -$7F(A5,D5.W),-(A1)             ; $11C4CC
        MOVEQ   #-$32,D1                        ; $11C4D0
        SUBQ.L  #6,-(A0)                        ; $11C4D2
        MOVEQ   #-$11,D3                        ; $11C4D4
        BLT.S  loc_11C4B9                       ; $11C4D6
        MOVE.W  (A4),$6E8F(A5)                  ; $11C4D8
        SVS     D4                              ; $11C4DC
        BCS.S  loc_11C461                       ; $11C4DE
        BSR.S  loc_11C462                       ; $11C4E0
        SUBQ.W  #2,D0                           ; $11C4E2
        BVS.S  loc_11C487                       ; $11C4E4
        BSR.S  loc_11C548                       ; $11C4E6
        SUBQ.W  #6,-(A0)                        ; $11C4E8
        BVS.S  loc_11C46D                       ; $11C4EA
        MOVEQ   #-$31,D7                        ; $11C4EC
        BHI.S  loc_11C51A                       ; $11C4EE
        MOVEQ   #-$74,D5                        ; $11C4F0
        MOVEQ   #$6B,D3                         ; $11C4F2
        SUBQ.W  #6,-(A1)                        ; $11C4F4
        MOVEQ   #-$72,D1                        ; $11C4F6
        BGT.S  loc_11C545                       ; $11C4F8
        MOVEQ   #-$74,D3                        ; $11C4FA
        MOVEQ   #$06,D1                         ; $11C4FC
        BGT.S  loc_11C4B0                       ; $11C4FE
        MOVE.W  (A7),$7779(A3)                  ; $11C500
        DC.W    $0001,$FF00         ; $11C504 ORI.B  #$FF00,D1
        MOVE.W  D0,-(A7)                        ; $11C508
        DC.W    $000C,$B500         ; $11C50A ORI.B  #$B500,A4
        BTST    D2,D1                           ; $11C50E
        BTST    D4,D2                           ; $11C510
        BTST    D5,D0                           ; $11C512
        DC.W    $0001,$0002         ; $11C514 ORI.B  #$0002,D1
        DC.W    $0003,$0004         ; $11C518 ORI.B  #$0004,D3
        DC.W    $0005,$0006         ; $11C51C ORI.B  #$0006,D5
        DC.W    $0007,$0108         ; $11C520 ORI.B  #$0108,D7
        BCC.W  loc_11C558                       ; $11C524
        SUB.B  D6,D0                            ; $11C528
        DC.W    $0208,$0001         ; $11C52A ANDI.B  #$0001,A0
        DC.W    $0008,$0400         ; $11C52E ORI.B  #$0400,A0
        DC.W    $0001,$0209         ; $11C532 ORI.B  #$0209,D1
        DC.W    $020A,$000B         ; $11C536 ANDI.B  #$000B,A2
        DC.W    $0007,$0006         ; $11C53A ORI.B  #$0006,D7
        DC.W    $0003,$0005         ; $11C53E ORI.B  #$0005,D3
        DC.W    $0004,$000C         ; $11C542 ORI.B  #$000C,D4
        DC.W    $000D,$000E         ; $11C546 ORI.B  #$000E,A5
        DC.W    $000F,$0010         ; $11C54A ORI.B  #$0010,A7
        DC.W    $0011,$0012         ; $11C54E ORI.B  #$0012,(A1)
        BTST    D0,(A3)                         ; $11C552
        DC.W    $0014,$0015         ; $11C554 ORI.B  #$0015,(A4)
loc_11C558:
        BTST    D0,(A6)                         ; $11C558
        DC.W    $0217,$0011         ; $11C55A ANDI.B  #$0011,(A7)
        DC.W    $0002,$0800         ; $11C55E ORI.B  #$0800,D2
        DC.W    $0002,$0007         ; $11C562 ORI.B  #$0007,D2
        DC.W    $000F,$0011         ; $11C566 ORI.B  #$0011,A7
        DC.W    $0018,$0219         ; $11C56A ORI.B  #$0219,(A0)+
        DC.W    $001A,$000C         ; $11C56E ORI.B  #$000C,(A2)+
        DC.W    $0006,$0009         ; $11C572 ORI.B  #$0009,D6
        DC.W    $0008,$0400         ; $11C576 ORI.B  #$0400,A0
        DC.W    $0012,$0013         ; $11C57A ORI.B  #$0013,(A2)
        DC.W    $0011,$000E         ; $11C57E ORI.B  #$000E,(A1)
        DC.W    $000C,$0004         ; $11C582 ORI.B  #$0004,A4
        DC.W    $0000,$0009         ; $11C586 ORI.B  #$0009,D0
        DC.W    $000A,$5400         ; $11C58A ORI.B  #$5400,A2
        DC.W    $002B,$8C00,$0301   ; $11C58E ORI.B  #$8C00,$0301(A3)
        BTST    D1,D2                           ; $11C594
        DC.W    $0309               ; $11C596 BTST    D1,A1
        DC.W    $010A               ; $11C598 BTST    D0,A2
        DC.W    $000B,$0007         ; $11C59A ORI.B  #$0007,A3
        DC.W    $0003,$0005         ; $11C59E ORI.B  #$0005,D3
        DC.W    $001B,$010C         ; $11C5A2 ORI.B  #$010C,(A3)+
        DC.W    $0009,$0200         ; $11C5A6 ORI.B  #$0200,A1
        DC.W    $0002,$001C         ; $11C5AA ORI.B  #$001C,D2
        DC.W    $000D,$0017         ; $11C5AE ORI.B  #$0017,A5
        DC.W    $0018,$1919         ; $11C5B2 ORI.B  #$1919,(A0)+
        DC.W    $0018,$0009         ; $11C5B6 ORI.B  #$0009,(A0)+
        ADDI.B  #$0002,D0                       ; $11C5BA
        DC.W    $001C,$0013         ; $11C5BE ORI.B  #$0013,(A4)+
        DC.W    $001D,$0719         ; $11C5C2 ORI.B  #$0719,(A5)+
        DC.W    $001E,$0011         ; $11C5C6 ORI.B  #$0011,(A6)+
        DC.W    $0003,$0001         ; $11C5CA ORI.B  #$0001,D3
        DC.W    $0008,$0200         ; $11C5CE ORI.B  #$0200,A0
        DC.W    $001D,$0419         ; $11C5D2 ORI.B  #$0419,(A5)+
        DC.W    $0000,$000C         ; $11C5D6 ORI.B  #$000C,D0
        DC.W    $001A,$000B         ; $11C5DA ORI.B  #$000B,(A2)+
        DC.W    $0000,$0008         ; $11C5DE ORI.B  #$0008,D0
        DC.W    $000E,$001E         ; $11C5E2 ORI.B  #$001E,A6
        DC.W    $4F00               ; $11C5E6 DC.W    $4F00
        ORI.W  #$6400,D2                        ; $11C5E8
        DC.W    $0001,$0002         ; $11C5EC ORI.B  #$0002,D1
        DC.W    $001C,$0303         ; $11C5F0 ORI.B  #$0303,(A4)+
        DC.W    $0006,$0107         ; $11C5F4 ORI.B  #$0107,D6
        BTST    D0,(A4)+                        ; $11C5F8
        DC.W    $020B,$0A0A         ; $11C5FA ANDI.B  #$0A0A,A3
        DC.W    $000B,$0009         ; $11C5FE ORI.B  #$0009,A3
        BTST    D1,D0                           ; $11C602
        DC.W    $0002,$0007         ; $11C604 ORI.B  #$0007,D2
        DC.W    $0003,$0004         ; $11C608 ORI.B  #$0004,D3
        DC.W    $001B,$000C         ; $11C60C ORI.B  #$000C,(A3)+
        DC.W    $000D,$000E         ; $11C610 ORI.B  #$000E,A5
        DC.W    $000F,$0011         ; $11C614 ORI.B  #$0011,A7
        DC.W    $0012,$0013         ; $11C618 ORI.B  #$0013,(A2)
        DC.W    $0014,$0015         ; $11C61C ORI.B  #$0015,(A4)
        DC.W    $0017,$001D         ; $11C620 ORI.B  #$001D,(A7)
        DC.W    $001F,$0018         ; $11C624 ORI.B  #$0018,(A7)+
        BTST    D1,(A6)+                        ; $11C628
        BTST    D2,(A1)+                        ; $11C62A
        DC.W    $0018,$001C         ; $11C62C ORI.B  #$001C,(A0)+
        DC.W    $0000,$0008         ; $11C630 ORI.B  #$0008,D0
        DC.W    $000B,$0010         ; $11C634 ORI.B  #$0010,A3
        DC.W    $001A,$001E         ; $11C638 ORI.B  #$001E,(A2)+
        MOVE.B  (A1)+,-(A5)                     ; $11C63C
        DC.W    $0018,$0009         ; $11C63E ORI.B  #$0009,(A0)+
        BTST    D2,D0                           ; $11C642
        DC.W    $0009,$0011         ; $11C644 ORI.B  #$0011,A1
        DC.W    $001A,$0B19         ; $11C648 ORI.B  #$0B19,(A2)+
        DC.W    $001A,$000D         ; $11C64C ORI.B  #$000D,(A2)+
        DC.W    $000B,$0008         ; $11C650 ORI.B  #$0008,A3
        BTST    D1,D0                           ; $11C654
        DC.W    $000F,$0019         ; $11C656 ORI.B  #$0019,A7
        DC.W    $000B,$0007         ; $11C65A ORI.B  #$0007,A3
        DC.W    $0000,$001B         ; $11C65E ORI.B  #$001B,D0
        DC.W    $001E,$0016         ; $11C662 ORI.B  #$0016,(A6)+
        DC.W    $0009,$0005         ; $11C666 ORI.B  #$0005,A1
        DC.W    $0018,$001E         ; $11C66A ORI.B  #$001E,(A0)+
        DC.W    $4F00               ; $11C66E DC.W    $4F00
        DC.W    $002D,$6200,$0002   ; $11C670 ORI.B  #$6200,$0002(A5)
        DC.W    $001C,$000C         ; $11C676 ORI.B  #$000C,(A4)+
        DC.W    $0013,$0017         ; $11C67A ORI.B  #$0017,(A3)
        MOVE.B  (A1)+,-(A3)                     ; $11C67E
        DC.W    $001B,$0100         ; $11C680 ORI.B  #$0100,(A3)+
        DC.W    $0002,$0004         ; $11C684 ORI.B  #$0004,D2
        DC.W    $0011,$001F         ; $11C688 ORI.B  #$001F,(A1)
        MOVE.B  (A1)+,D5                        ; $11C68C
        DC.W    $001C,$0008         ; $11C68E ORI.B  #$0008,(A4)+
        DC.W    $001B,$001A         ; $11C692 ORI.B  #$001A,(A3)+
        MOVE.B  (A1)+,D7                        ; $11C696
        DC.W    $0018,$0009         ; $11C698 ORI.B  #$0009,(A0)+
        SUBI.B  #$0002,D0                       ; $11C69C
        DC.W    $0010,$0519         ; $11C6A0 ORI.B  #$0519,(A0)
        DC.W    $0020,$0021         ; $11C6A4 ORI.B  #$0021,-(A0)
        BTST    D0,-(A2)                        ; $11C6A8
        DC.W    $0023,$0024         ; $11C6AA ORI.B  #$0024,-(A3)
        DC.W    $0219,$001E         ; $11C6AE ANDI.B  #$001E,(A1)+
        DC.W    $0014,$000B         ; $11C6B2 ORI.B  #$000B,(A4)
        BTST    D1,D0                           ; $11C6B6
        DC.W    $000E,$0019         ; $11C6B8 ORI.B  #$0019,A6
        DC.W    $0200,$001B         ; $11C6BC ANDI.B  #$001B,D0
        DC.W    $001E,$0011         ; $11C6C0 ORI.B  #$0011,(A6)+
        DC.W    $0012,$001A         ; $11C6C4 ORI.B  #$001A,(A2)
        DC.W    $0017,$001E         ; $11C6C8 ORI.B  #$001E,(A7)
        DC.W    $4F00               ; $11C6CC DC.W    $4F00
        DC.W    $003D,$6000         ; $11C6CE ORI.B  #$6000,<EA:3D>
        DC.W    $0002,$0007         ; $11C6D2 ORI.B  #$0007,D2
        DC.W    $0014,$0018         ; $11C6D6 ORI.B  #$0018,(A4)
        MOVE.B  (A1)+,D5                        ; $11C6DA
        DC.W    $000C,$0000         ; $11C6DC ORI.B  #$0000,A4
        DC.W    $0006,$0013         ; $11C6E0 ORI.B  #$0013,D6
        MOVE.B  (A1)+,-(A6)                     ; $11C6E4
        DC.W    $000D,$0004         ; $11C6E6 ORI.B  #$0004,A5
        DC.W    $0018,$0219         ; $11C6EA ORI.B  #$0219,(A0)+
        DC.W    $0025,$0026         ; $11C6EE ORI.B  #$0026,-(A5)
        DC.W    $0027,$0128         ; $11C6F2 ORI.B  #$0128,-(A7)
        DC.W    $0029,$002A,$002B   ; $11C6F6 ORI.B  #$002A,$002B(A1)
        DC.W    $002C,$002D,$002E   ; $11C6FC ORI.B  #$002D,$002E(A4)
        BTST    D0,$0130(A7)                    ; $11C702
        DC.W    $0031,$0132,$0233   ; $11C706 ORI.B  #$0132,$33(A1,D0.W)
        SUBI.B  #$0020,$19(A4,D0.W)             ; $11C70C
        DC.W    $0018,$0009         ; $11C712 ORI.B  #$0009,(A0)+
        BTST    D1,D0                           ; $11C716
        DC.W    $0001,$000F         ; $11C718 ORI.B  #$000F,D1
        BTST    D1,(A1)+                        ; $11C71C
        DC.W    $0035,$0036,$0137   ; $11C71E ORI.B  #$0036,$37(A5,D0.W)
        BTST    D0,$0139.W                      ; $11C724
        DC.W    $003A,$003B,$003C   ; $11C728 ORI.B  #$003B,$003C(PC)
        DC.W    $0219,$0012         ; $11C72E ANDI.B  #$0012,(A1)+
        DC.W    $0009,$0200         ; $11C732 ORI.B  #$0200,A1
        DC.W    $000D,$0019         ; $11C736 ORI.B  #$0019,A5
        DC.W    $0200,$0004         ; $11C73A ANDI.B  #$0004,D0
        DC.W    $001E,$0009         ; $11C73E ORI.B  #$0009,(A6)+
        DC.W    $0015,$001B         ; $11C742 ORI.B  #$001B,(A5)
        DC.W    $000E,$001E         ; $11C746 ORI.B  #$001E,A6
        DC.W    $4F00               ; $11C74A DC.W    $4F00
        ORI.W  #$5E00,D5                        ; $11C74C
        DC.W    $0009,$0003         ; $11C750 ORI.B  #$0003,A1
        DC.W    $0014,$1D19         ; $11C754 ORI.B  #$1D19,(A4)
        DC.W    $000C,$0007         ; $11C758 ORI.B  #$0007,A4
        DC.W    $001F,$0719         ; $11C75C ORI.B  #$0719,(A7)+
        DC.W    $003D,$0035         ; $11C760 ORI.B  #$0035,<EA:3D>
        DC.W    $0024,$003E         ; $11C764 ORI.B  #$003E,-(A4)
        DC.W    $003F,$0025         ; $11C768 ORI.B  #$0025,<EA:3F>
        DC.W    $0026,$0027         ; $11C76C ORI.B  #$0027,-(A6)
        DC.W    $0028,$003C,$0040   ; $11C770 ORI.B  #$003C,$0040(A0)
        ORI.W  #$0042,D1                        ; $11C776
        ORI.W  #$0044,D3                        ; $11C77A
        DC.W    $0022,$003B         ; $11C77E ORI.B  #$003B,-(A2)
        ORI.W  #$0046,D5                        ; $11C782
        ORI.W  #$0619,D7                        ; $11C786
        DC.W    $003F,$0048         ; $11C78A ORI.B  #$0048,<EA:3F>
        DC.W    $0149               ; $11C78E BCHG    D0,A1
        ANDI.W  #$034B,A2                       ; $11C790
        ANDI.W  #$014D,A4                       ; $11C794
        DC.W    $084E,$014F         ; $11C798 BCHG    #15,A6
        ORI.W  #$0020,(A0)                      ; $11C79C
        BTST    D0,(A1)+                        ; $11C7A0
        DC.W    $0018,$0009         ; $11C7A2 ORI.B  #$0009,(A0)+
        BTST    D1,D0                           ; $11C7A6
        DC.W    $0007,$0319         ; $11C7A8 ORI.B  #$0319,D7
        ORI.W  #$0050,(A1)                      ; $11C7AC
        ORI.W  #$004D,(A2)                      ; $11C7B0
        SUBI.B  #$0153,$0054.W                  ; $11C7B4
        ORI.W  #$0219,(A1)                      ; $11C7BA
        DC.W    $000F,$0001         ; $11C7BE ORI.B  #$0001,A7
        BTST    D0,D0                           ; $11C7C2
        DC.W    $000D,$0019         ; $11C7C4 ORI.B  #$0019,A5
        DC.W    $0200,$0004         ; $11C7C8 ANDI.B  #$0004,D0
        DC.W    $001E,$0000         ; $11C7CC ORI.B  #$0000,(A6)+
        DC.W    $000A,$0008         ; $11C7D0 ORI.B  #$0008,A2
        DC.W    $000D,$001E         ; $11C7D4 ORI.B  #$001E,A5
        DC.W    $4F00               ; $11C7D8 DC.W    $4F00
        ORI.W  #$5D00,A2                        ; $11C7DA
        DC.W    $000B,$0012         ; $11C7DE ORI.B  #$0012,A3
        DC.W    $001E,$0419         ; $11C7E2 ORI.B  #$0419,(A6)+
        DC.W    $0020,$003E         ; $11C7E6 ORI.B  #$003E,-(A0)
        ORI.W  #$0056,(A5)                      ; $11C7EA
        ORI.W  #$0434,(A7)                      ; $11C7EE
        BCHG    D1,(A0)+                        ; $11C7F2
        ANDI.W  #$0231,(A1)+                    ; $11C7F4
        ANDI.W  #$0035,(A1)+                    ; $11C7F8
        BTST    D0,(A1)+                        ; $11C7FC
        DC.W    $0013,$001A         ; $11C7FE ORI.B  #$001A,(A3)
        DC.W    $0219,$0035         ; $11C802 ANDI.B  #$0035,(A1)+
        DC.W    $002B,$005A,$015B   ; $11C806 ORI.B  #$005A,$015B(A3)
        BCHG    D0,(A4)+                        ; $11C80C
        ANDI.W  #$0049,(A4)                     ; $11C80E
        ORI.W  #$015E,(A5)+                     ; $11C812
        ORI.W  #$0260,(A7)+                     ; $11C816
        BTST    D0,$01530061                    ; $11C81A
        BCHG    D0,(A3)                         ; $11C820
        ORI.W  #$0419,-(A2)                     ; $11C822
        DC.W    $0024,$0048         ; $11C826 ORI.B  #$0048,-(A4)
        ORI.W  #$005E,(A2)+                     ; $11C82A
        BTST    D2,$074D.W                      ; $11C82E
        DC.W    $084E,$014F         ; $11C832 BCHG    #15,A6
        ORI.W  #$0020,(A0)                      ; $11C836
        BTST    D0,(A1)+                        ; $11C83A
        DC.W    $0018,$0009         ; $11C83C ORI.B  #$0009,(A0)+
        DC.W    $0200,$0001         ; $11C840 ANDI.B  #$0001,D0
        DC.W    $0011,$0219         ; $11C844 ORI.B  #$0219,(A1)
        ORI.W  #$0050,-(A3)                     ; $11C848
        ANDI.W  #$0438,A5                       ; $11C84C
        ORI.W  #$0161,(A3)                      ; $11C850
        ORI.W  #$003F,(A4)+                     ; $11C854
        BTST    D0,(A1)+                        ; $11C858
        DC.W    $001D,$000A         ; $11C85A ORI.B  #$000A,(A5)+
        BTST    D0,D0                           ; $11C85E
        DC.W    $000C,$0019         ; $11C860 ORI.B  #$0019,A4
        DC.W    $0200,$0005         ; $11C864 ANDI.B  #$0005,D0
        DC.W    $001E,$0200         ; $11C868 ORI.B  #$0200,(A6)+
        DC.W    $000C,$001E         ; $11C86C ORI.B  #$001E,A4
        DC.W    $4F00               ; $11C870 DC.W    $4F00
        DC.W    $003E,$5C00         ; $11C872 ORI.B  #$5C00,<EA:3E>
        DC.W    $001C,$0016         ; $11C876 ORI.B  #$0016,(A4)+
        BTST    D1,(A1)+                        ; $11C87A
        ORI.W  #$0028,-(A4)                     ; $11C87C
        ORI.W  #$0150,-(A5)                     ; $11C880
        ORI.W  #$014E,A7                        ; $11C884
        DC.W    $0F4F               ; $11C888 BCHG    D7,A7
        ORI.W  #$0066,A6                        ; $11C88A
        DC.W    $0035,$0419,$003D   ; $11C88E ORI.B  #$0419,$3D(A5,D0.W)
        ORI.W  #$0050,-(A4)                     ; $11C894
        ORI.W  #$034D,-(A7)                     ; $11C898
        BTST    #19,$0161.W                     ; $11C89C
        BCHG    D0,(A3)                         ; $11C8A2
        ORI.W  #$0319,-(A2)                     ; $11C8A4
        DC.W    $0024,$0068         ; $11C8A8 ORI.B  #$0068,-(A4)
        ORI.W  #$0039,-(A0)                     ; $11C8AC
        ADDI.B  #$074D,$084E.W                  ; $11C8B0
        DC.W    $014F               ; $11C8B6 BCHG    D0,A7
        ORI.W  #$0020,(A0)                      ; $11C8B8
        BTST    D0,(A1)+                        ; $11C8BC
        DC.W    $0018,$0009         ; $11C8BE ORI.B  #$0009,(A0)+
        DC.W    $0200,$001C         ; $11C8C2 ANDI.B  #$001C,D0
        DC.W    $0219,$0069         ; $11C8C6 ANDI.B  #$0069,(A1)+
        ORI.W  #$034D,(A7)                      ; $11C8CA
        SUBI.B  #$0053,$0261.W                  ; $11C8CE
        ORI.W  #$003E,-(A2)                     ; $11C8D4
        BTST    D0,(A1)+                        ; $11C8D8
        DC.W    $000E,$0008         ; $11C8DA ORI.B  #$0008,A6
        DC.W    $0000,$0002         ; $11C8DE ORI.B  #$0002,D0
        DC.W    $0007,$0200         ; $11C8E2 ORI.B  #$0200,D7
        DC.W    $000A,$000E         ; $11C8E6 ORI.B  #$000E,A2
        DC.W    $0200,$0003         ; $11C8EA ANDI.B  #$0003,D0
        DC.W    $0016,$4F00         ; $11C8EE ORI.B  #$4F00,(A6)
        DC.W    $0035,$5B00,$0007   ; $11C8F2 ORI.B  #$5B00,$07(A5,D0.W)
        DC.W    $001F,$0219         ; $11C8F8 ORI.B  #$0219,(A7)+
        DC.W    $0028,$006A,$006B   ; $11C8FC ORI.B  #$006A,$006B(A0)
        BCHG    D0,$044E(A4)                    ; $11C902
        DC.W    $0F4F               ; $11C906 BCHG    D7,A7
        ORI.W  #$0066,A6                        ; $11C908
        DC.W    $0035,$0319,$0035   ; $11C90C ORI.B  #$0319,$35(A5,D0.W)
        ORI.W  #$006D,(A0)+                     ; $11C912
        DC.W    $054D               ; $11C916 BCHG    D2,A5
        BTST    #19,$0161.W                     ; $11C918
        BCHG    D0,(A3)                         ; $11C91E
        ORI.W  #$0219,-(A2)                     ; $11C920
        DC.W    $0035,$0068,$0039   ; $11C924 ORI.B  #$0068,$39(A5,D0.W)
        BTST    #13,$084E.W                     ; $11C92A
        DC.W    $014F               ; $11C930 BCHG    D0,A7
        ORI.W  #$0020,(A0)                      ; $11C932
        BTST    D0,(A1)+                        ; $11C936
        DC.W    $0018,$0009         ; $11C938 ORI.B  #$0009,(A0)+
        BTST    D0,D0                           ; $11C93C
        DC.W    $0002,$0013         ; $11C93E ORI.B  #$0013,D2
        DC.W    $0219,$002B         ; $11C942 ANDI.B  #$002B,(A1)+
        ORI.W  #$044D,$0149(A6)                 ; $11C946
        ORI.W  #$0039,A2                        ; $11C94C
        ORI.W  #$0261,(A3)                      ; $11C950
        ORI.W  #$0043,$0119(A7)                 ; $11C954
        DC.W    $0013,$0002         ; $11C95A ORI.B  #$0002,(A3)
        ADDQ.B  #6,D0                           ; $11C95E
        DC.W    $0034,$5A00,$0006   ; $11C960 ORI.B  #$5A00,$06(A4,D0.W)
        DC.W    $001F,$0219         ; $11C966 ORI.B  #$0219,(A7)+
        DC.W    $0036,$006B,$084E   ; $11C96A ORI.B  #$006B,$4E(A6,D0.L)
        DC.W    $0F4F               ; $11C970 BCHG    D7,A7
        ORI.W  #$0066,A6                        ; $11C972
        DC.W    $0035,$0319,$0070   ; $11C976 ORI.B  #$0319,$70(A5,D0.W)
        ORI.W  #$004E,$4D(A1,D0.W)              ; $11C97C
        BTST    #19,$0161.W                     ; $11C982
        BCHG    D0,(A3)                         ; $11C988
        ORI.W  #$0219,-(A2)                     ; $11C98A
        ORI.W  #$0A38,$4D(A2,D0.W)              ; $11C98E
        DC.W    $084E,$014F         ; $11C994 BCHG    #15,A6
        ORI.W  #$0020,(A0)                      ; $11C998
        BTST    D0,(A1)+                        ; $11C99C
        DC.W    $0018,$0009         ; $11C99E ORI.B  #$0009,(A0)+
        BTST    D0,D0                           ; $11C9A2
        DC.W    $0009,$0018         ; $11C9A4 ORI.B  #$0018,A1
        BTST    D0,(A1)+                        ; $11C9A8
        ORI.W  #$0050,$004E(A1)                 ; $11C9AA
        DC.W    $034D               ; $11C9B0 BCHG    D1,A5
        ORI.W  #$0037,(A2)                      ; $11C9B2
        DC.W    $0029,$0073,$0054   ; $11C9B6 ORI.B  #$0073,$0054(A1)
        ORI.W  #$0361,(A3)                      ; $11C9BC
        ORI.W  #$0074,D6                        ; $11C9C0
        DC.W    $0019,$0018         ; $11C9C4 ORI.B  #$0018,(A1)+
        DC.W    $0005,$5C00         ; $11C9C8 ORI.B  #$5C00,D5
        DC.W    $003D,$5900         ; $11C9CC ORI.B  #$5900,<EA:3D>
        DC.W    $000A,$0012         ; $11C9D0 ORI.B  #$0012,A2
        DC.W    $0219,$002B         ; $11C9D4 ANDI.B  #$002B,(A1)+
        ORI.W  #$094E,$104F(A3)                 ; $11C9D8
        ORI.W  #$0035,-(A6)                     ; $11C9DE
        DC.W    $0219,$0035         ; $11C9E2 ANDI.B  #$0035,(A1)+
        ORI.W  #$014E,(A7)                      ; $11C9E6
        ADDI.W  #$0738,A5                       ; $11C9EA
        BCHG    D2,(A3)                         ; $11C9EE
        BCHG    D0,-(A1)                        ; $11C9F0
        BCHG    D0,(A3)                         ; $11C9F2
        ORI.W  #$0119,-(A2)                     ; $11C9F4
        DC.W    $0024,$0062         ; $11C9F8 ORI.B  #$0062,-(A4)
        BTST    D2,$0160.W                      ; $11C9FC
        ANDI.W  #$0049,A2                       ; $11CA00
        BCHG    D0,(A2)                         ; $11CA04
        ORI.W  #$0175,$0076(A5)                 ; $11CA06
        BCHG    D0,(A3)+                        ; $11CA0C
        BCHG    D0,(A0)                         ; $11CA0E
        SUBI.W  #$0234,(A7)                     ; $11CA10
        ORI.W  #$0020,$19(A7,D0.W)              ; $11CA14
        DC.W    $0018,$0009         ; $11CA1A ORI.B  #$0009,(A0)+
        BTST    D0,D0                           ; $11CA1E
        DC.W    $0007,$0219         ; $11CA20 ORI.B  #$0219,D7
        DC.W    $0028,$0067,$004E   ; $11CA24 ORI.B  #$0067,$004E(A0)
        ANDI.W  #$0052,A5                       ; $11CA2A
        DC.W    $0029,$0064,$003F   ; $11CA2E ORI.B  #$0064,$003F(A1)
        ORI.W  #$0028,(A1)                      ; $11CA34
        ORI.W  #$0061,$0279.W                   ; $11CA38
        ORI.W  #$007A,$0119(A7)                 ; $11CA3E
        DC.W    $0011,$0001         ; $11CA44 ORI.B  #$0001,(A1)
        SUBQ.B  #5,D0                           ; $11CA48
        ORI.W  #$5800,A0                        ; $11CA4A
        DC.W    $0002,$000E         ; $11CA4E ORI.B  #$000E,D2
        DC.W    $0219,$002B         ; $11CA52 ANDI.B  #$002B,(A1)+
        ORI.W  #$074E,(A7)                      ; $11CA56
        BCHG    D3,$047B(A3)                    ; $11CA5A
        ADDI.W  #$0050,$0035(A4)                ; $11CA5E
        BTST    D0,(A1)+                        ; $11CA64
        DC.W    $0035,$0056,$024E   ; $11CA66 ORI.B  #$0056,$4E(A5,D0.W)
        DC.W    $014D               ; $11CA6C BCHG    D0,A5
        ORI.W  #$054A,A3                        ; $11CA6E
        ANDI.W  #$005D,A1                       ; $11CA72
        DC.W    $007C,$027D,$037E   ; $11CA76 ORI.W  #$027D,#$037E
        DC.W    $007F,$0180         ; $11CA7C ORI.W  #$0180,<EA:3F>
        ORI.W  #$0047,-(A2)                     ; $11CA80
        BTST    D0,(A1)+                        ; $11CA84
        DC.W    $0023,$0039         ; $11CA86 ORI.B  #$0039,-(A3)
        BTST    D1,$0053.W                      ; $11CA8A
        ORI.W  #$002D,A1                        ; $11CA8E
        BTST    D0,$002A(A4)                    ; $11CA92
        DC.W    $0036,$0129,$0128   ; $11CA96 ORI.B  #$0129,$28(A6,D0.W)
        ORI.W  #$0051,-(A4)                     ; $11CA9C
        ORI.W  #$0181,-(A3)                     ; $11CAA0
        ORI.L  #$01690183,D2                    ; $11CAA4
        BTST    D2,-(A0)                        ; $11CAAA
        DC.W    $0219,$0018         ; $11CAAC ANDI.B  #$0018,(A1)+
        DC.W    $0009,$0000         ; $11CAB0 ORI.B  #$0000,A1
        DC.W    $0009,$0015         ; $11CAB4 ORI.B  #$0015,A1
        BTST    D0,(A1)+                        ; $11CAB8
        DC.W    $0020,$0050         ; $11CABA ORI.B  #$0050,-(A0)
        ORI.W  #$0338,A5                        ; $11CABE
        ORI.W  #$0051,$0084(A5)                 ; $11CAC2
        ORI.L  #$005A0027,D5                    ; $11CAC8
        ORI.L  #$04790062,D6                    ; $11CACE
        ORI.L  #$0019001A,D7                    ; $11CAD4
        DC.W    $0009,$5B00         ; $11CADA ORI.B  #$5B00,A1
        ORI.W  #$5800,(A0)                      ; $11CADE
        DC.W    $000B,$0017         ; $11CAE2 ORI.B  #$0017,A3
        DC.W    $0219,$0056         ; $11CAE6 ANDI.B  #$0056,(A1)+
        ORI.L  #$054E006B,A0                    ; $11CAEA
        ORI.L  #$0036028A,A1                    ; $11CAF0
        DC.W    $0028,$048B,$018C   ; $11CAF6 ORI.B  #$048B,$018C(A0)
        BTST    #25,$36(A6,D0.W)                ; $11CAFC
        ORI.W  #$024E,$4D(A1,D0.W)              ; $11CB02
        ORI.W  #$008D,$0429(A6)                 ; $11CB08
        DC.W    $0228,$0227,$0151   ; $11CB0E ANDI.B  #$0227,$0151(A0)
        BTST    D0,-(A5)                        ; $11CB14
        ORI.L  #$00250051,D1                    ; $11CB16
        BTST    D0,-(A7)                        ; $11CB1C
        DC.W    $0028,$003C,$0028   ; $11CB1E ORI.B  #$003C,$0028(A0)
        DC.W    $0019,$003E         ; $11CB24 ORI.B  #$003E,(A1)+
        ORI.W  #$0453,-(A2)                     ; $11CB28
        ORI.W  #$002A,(A5)+                     ; $11CB2C
        ORI.W  #$0021,(A1)                      ; $11CB30
        BCHG    D0,D7                           ; $11CB34
        ORI.L  #$0037015A,A6                    ; $11CB36
        BCHG    D0,(A3)+                        ; $11CB3C
        BCHG    D0,-$71(A6,D0.W)                ; $11CB3E
        ANDI.W  #$0767,$0089(A5)                ; $11CB42
        DC.W    $0020,$0119         ; $11CB48 ORI.B  #$0119,-(A0)
        DC.W    $0018,$0009         ; $11CB4C ORI.B  #$0009,(A0)+
        DC.W    $0000,$0009         ; $11CB50 ORI.B  #$0009,D0
        DC.W    $001F,$0119         ; $11CB54 ORI.B  #$0119,(A7)+
        ORI.W  #$004B,$0090(A1)                 ; $11CB58
        ANDI.L  #$00920065,(A1)                 ; $11CB5E
        DC.W    $003F,$005F         ; $11CB64 ORI.B  #$005F,<EA:3F>
        ORI.L  #$006F0029,(A3)                  ; $11CB68
        DC.W    $0025,$006F         ; $11CB6E ORI.B  #$006F,-(A5)
        ANDI.L  #$00950096,(A4)                 ; $11CB72
        ORI.W  #$0019,$18(A4,D0.W)              ; $11CB78
        DC.W    $001C,$5B00         ; $11CB7E ORI.B  #$5B00,(A4)+
        ORI.W  #$5700,(A1)                      ; $11CB82
        DC.W    $0002,$0010         ; $11CB86 ORI.B  #$0010,D2
        DC.W    $0219,$0097         ; $11CB8A ANDI.B  #$0097,(A1)+
        ORI.W  #$044E,(A7)                      ; $11CB8E
        ORI.W  #$0034,A7                        ; $11CB92
        DC.W    $002B,$0098,$0020   ; $11CB96 ORI.B  #$0098,$0020(A3)
        BCHG    D0,(A5)                         ; $11CB9C
        BCHG    D0,$0199(A2)                    ; $11CB9E
        SUBI.L  #$009A0565,A5                   ; $11CBA2
        ORI.W  #$0099,$19(A0,D0.W)              ; $11CBA8
        ORI.L  #$034D004C,A5                    ; $11CBAE
        ORI.W  #$0069,$0030(A2)                 ; $11CBB4
        ORI.W  #$005B,(A2)+                     ; $11CBBA
        ORI.W  #$0085,(A4)+                     ; $11CBBE
        ORI.W  #$0052,(A4)                      ; $11CBC2
        ORI.W  #$025E,(A5)+                     ; $11CBC6
        BCLR    D0,(A3)+                        ; $11CBCA
        BCHG    D2,$026F.W                      ; $11CBCC
        ORI.W  #$003D,(A4)+                     ; $11CBD0
        ORI.W  #$006F,A0                        ; $11CBD4
        BCLR    D0,(A4)+                        ; $11CBD8
        ORI.L  #$0093006F,(A5)+                 ; $11CBDA
        DC.W    $002A,$0081,$0037   ; $11CBE0 ORI.B  #$0081,$0037(A2)
        ORI.W  #$0393,(A3)                      ; $11CBE6
        BCLR    D2,(A6)+                        ; $11CBEA
        ANDI.L  #$0890006E,(A1)                 ; $11CBEC
        DC.W    $003E,$0119         ; $11CBF2 ORI.B  #$0119,<EA:3E>
        DC.W    $0018,$0009         ; $11CBF6 ORI.B  #$0009,(A0)+
        DC.W    $0000,$0005         ; $11CBFA ORI.B  #$0005,D0
        DC.W    $001E,$0119         ; $11CBFE ORI.B  #$0119,(A6)+
        DC.W    $002B,$004D,$0090   ; $11CC02 ORI.B  #$004D,$0090(A3)
        ANDI.L  #$006D008B,(A1)                 ; $11CC08
        DC.W    $0032,$0293,$0049   ; $11CC0E ORI.B  #$0293,$49(A2,D0.W)
        DC.W    $0025,$006F         ; $11CC14 ORI.B  #$006F,-(A5)
        ANDI.L  #$00950079,(A4)                 ; $11CC18
        ORI.L  #$01190013,(A7)+                 ; $11CC1E
        DC.W    $0001,$5A00         ; $11CC24 ORI.B  #$5A00,D1
        ORI.W  #$5700,D6                        ; $11CC28
        DC.W    $000B,$0015         ; $11CC2C ORI.B  #$0015,A3
        DC.W    $0219,$0056         ; $11CC30 ANDI.B  #$0056,(A1)+
        SUBI.W  #$00A0,A5                       ; $11CC34
        ORI.L  #$00200098,A5                    ; $11CC38
        ORI.L  #$0066074D,A5                    ; $11CC3E
        ORI.L  #$0888004D,-(A1)                 ; $11CC44
        ORI.L  #$00200019,-(A2)                 ; $11CC4A
        DC.W    $003E,$006D         ; $11CC50 ORI.B  #$006D,<EA:3E>
        ANDI.W  #$0038,A5                       ; $11CC54
        ORI.W  #$0083,(A3)+                     ; $11CC58
        ORI.W  #$0238,$0553(A2)                 ; $11CC5C
        ORI.L  #$00930A94,(A5)+                 ; $11CC62
        ORI.W  #$003D,(A7)+                     ; $11CC68
        ORI.W  #$0061,D2                        ; $11CC6C
        BCLR    D0,(A4)                         ; $11CC70
        BCLR    D0,(A3)                         ; $11CC72
        ORI.W  #$0027,$005A(A7)                 ; $11CC74
        ADDI.L  #$049E0291,(A3)                 ; $11CC7A
        BCLR    #8,(A0)                         ; $11CC80
        DC.W    $003E,$0119         ; $11CC84 ORI.B  #$0119,<EA:3E>
        DC.W    $0018,$0009         ; $11CC88 ORI.B  #$0009,(A0)+
        DC.W    $0002,$0013         ; $11CC8C ORI.B  #$0013,D2
        DC.W    $0219,$0066         ; $11CC90 ANDI.B  #$0066,(A1)+
        BCLR    D0,(A0)                         ; $11CC94
        ANDI.L  #$00320051,(A1)                 ; $11CC96
        ORI.W  #$0293,(A2)                      ; $11CC9C
        ORI.W  #$0025,$005A(A7)                 ; $11CCA0
        ANDI.L  #$009500A3,(A4)                 ; $11CCA6
        DC.W    $007D,$0035         ; $11CCAC ORI.W  #$0035,<EA:3D>
        DC.W    $0019,$001A         ; $11CCB0 ORI.B  #$001A,(A1)+
        DC.W    $0002,$5A00         ; $11CCB4 ORI.B  #$5A00,D2
        ORI.W  #$5600,D4                        ; $11CCB8
        DC.W    $0001,$001B         ; $11CCBC ORI.B  #$001B,D1
        DC.W    $0219,$008C         ; $11CCC0 ANDI.B  #$008C,(A1)+
        ORI.W  #$044D,-(A7)                     ; $11CCC4
        ORI.W  #$0083,(A7)                      ; $11CCC8
        ORI.W  #$0066,-(A5)                     ; $11CCCC
        ORI.W  #$024D,-$70(A1,D1.W)             ; $11CCD0
        ORI.W  #$0083,$19(A1,D0.W)              ; $11CCD6
        ORI.L  #$004C0290,D1                    ; $11CCDC
        ORI.L  #$00750036,(A1)                  ; $11CCE2
        ORI.W  #$029E,A4                        ; $11CCE8
        BCLR    D3,(A3)                         ; $11CCEC
        EORI.L  #$005F003D,(A4)                 ; $11CCEE
        ORI.L  #$00610194,-(A4)                 ; $11CCF4
        BCLR    D0,(A3)                         ; $11CCFA
        ORI.W  #$0027,$0060(A7)                 ; $11CCFC
        ADDI.L  #$049E0291,(A3)                 ; $11CD02
        BCLR    #8,(A0)                         ; $11CD08
        DC.W    $003E,$0119         ; $11CD0C ORI.B  #$0119,<EA:3E>
        DC.W    $0018,$0109         ; $11CD10 ORI.B  #$0109,(A0)+
        DC.W    $0015,$0119         ; $11CD14 ORI.B  #$0119,(A5)
        DC.W    $0035,$004D,$0190   ; $11CD18 ORI.B  #$004D,-$70(A5,D0.W)
        BCLR    D0,(A1)                         ; $11CD1E
        DC.W    $0038,$0030,$008D   ; $11CD20 ORI.B  #$0030,$008D.W
        DC.W    $0038,$0293,$0053   ; $11CD26 ORI.B  #$0293,$0053.W
        DC.W    $002C,$0029,$006F   ; $11CD2C ORI.B  #$0029,$006F(A4)
        BCLR    D0,(A4)                         ; $11CD32
        ORI.L  #$00A300A5,(A5)                  ; $11CD34
        DC.W    $0035,$0019,$001A   ; $11CD3A ORI.B  #$0019,$1A(A5,D0.W)
        DC.W    $001C,$5A00         ; $11CD40 ORI.B  #$5A00,(A4)+
        ORI.W  #$5600,D2                        ; $11CD44
        DC.W    $0001,$0010         ; $11CD48 ORI.B  #$0010,D1
        DC.W    $0219,$0050         ; $11CD4C ANDI.B  #$0050,(A1)+
        ORI.W  #$0390,A5                        ; $11CD50
        ORI.W  #$008A,-$7E(A1,D0.W)             ; $11CD54
        ORI.W  #$0D90,$01A6(A3)                 ; $11CD5A
        BCLR    D2,(A0)                         ; $11CD60
        ORI.W  #$0083,$19(A1,D0.W)              ; $11CD62
        ORI.W  #$004D,-(A3)                     ; $11CD68
        ANDI.L  #$00910075,(A0)                 ; $11CD6C
        DC.W    $002B,$0038,$029E   ; $11CD72 ORI.B  #$0038,$029E(A3)
        BCLR    #20,(A3)                        ; $11CD78
        ORI.W  #$003D,(A7)+                     ; $11CD7C
        ORI.L  #$00610194,-(A4)                 ; $11CD80
        BCLR    D0,(A3)                         ; $11CD86
        ORI.W  #$0064,$0060(A7)                 ; $11CD88
        ADDI.L  #$049E0291,(A3)                 ; $11CD8E
        BCLR    #8,(A0)                         ; $11CD94
        DC.W    $003E,$0119         ; $11CD98 ORI.B  #$0119,<EA:3E>
        DC.W    $0018,$000A         ; $11CD9C ORI.B  #$000A,(A0)+
        DC.W    $001B,$0219         ; $11CDA0 ORI.B  #$0219,(A3)+
        ORI.L  #$02900191,(A1)+                 ; $11CDA4
        ORI.W  #$0064,$0030(A5)                 ; $11CDAA
        DC.W    $0038,$0393,$005D   ; $11CDB0 ORI.B  #$0393,$005D.W
        ORI.W  #$0086,(A1)                      ; $11CDB6
        BCLR    D0,(A4)                         ; $11CDBA
        ORI.L  #$00A30079,(A5)                  ; $11CDBC
        ORI.L  #$01190010,-(A7)                 ; $11CDC2
        DC.W    $0001,$5900         ; $11CDC8 ORI.B  #$5900,D1
        DC.W    $003F,$5600         ; $11CDCC ORI.B  #$5600,<EA:3F>
        DC.W    $0001,$0010         ; $11CDD0 ORI.B  #$0010,D1
        DC.W    $0219,$006B         ; $11CDD4 ANDI.B  #$006B,(A1)+
        SUBI.L  #$00890020,(A0)                 ; $11CDD8
        ORI.W  #$0E90,-$5A(A7,D0.W)             ; $11CDDE
        SUBI.L  #$00710083,(A0)                 ; $11CDE4
        DC.W    $0019,$0063         ; $11CDEA ORI.B  #$0063,(A1)+
        ORI.W  #$0390,A5                        ; $11CDEE
        ORI.W  #$002B,$0038(A5)                 ; $11CDF2
        ANDI.L  #$08930994,(A6)+                ; $11CDF8
        ORI.W  #$003D,(A7)+                     ; $11CDFE
        ORI.L  #$00610194,-(A4)                 ; $11CE02
        BCLR    D0,(A3)                         ; $11CE08
        ORI.W  #$0064,$0060(A7)                 ; $11CE0A
        ADDI.L  #$049E0291,(A3)                 ; $11CE10
        BCLR    #8,(A0)                         ; $11CE16
        DC.W    $003E,$0119         ; $11CE1A ORI.B  #$0119,<EA:3E>
        DC.W    $0018,$000A         ; $11CE1E ORI.B  #$000A,(A0)+
        DC.W    $0010,$0219         ; $11CE22 ORI.B  #$0219,(A0)
        ORI.W  #$0390,$0091(A3)                 ; $11CE26
        ORI.W  #$0064,$75(A6,D0.W)              ; $11CE2C
        ORI.L  #$03930061,(A6)+                 ; $11CE32
        DC.W    $00A8,$0022,$0194,$0095; $11CE38 ORI.L  #$00220194,$0095(A0)
        BCLR    D0,-(A3)                        ; $11CE40
        ORI.W  #$003D,D6                        ; $11CE42
        DC.W    $0019,$0013         ; $11CE46 ORI.B  #$0013,(A1)+
        DC.W    $0001,$5900         ; $11CE4A ORI.B  #$5900,D1
        ORI.W  #$5600,D2                        ; $11CE4E
        DC.W    $0001,$0011         ; $11CE52 ORI.B  #$0011,D1
        DC.W    $0219,$0067         ; $11CE56 ANDI.B  #$0067,(A1)+
        BCLR    D1,(A0)                         ; $11CE5A
        ORI.L  #$00820083,A0                    ; $11CE5C
        ORI.W  #$0D90,$03A6(A6)                 ; $11CE62
        SUBI.L  #$00710083,(A0)                 ; $11CE68
        DC.W    $0019,$0063         ; $11CE6E ORI.B  #$0063,(A1)+
        ORI.W  #$0390,A5                        ; $11CE72
        ORI.W  #$002B,$0038(A5)                 ; $11CE76
        ANDI.L  #$0D930461,(A6)+                ; $11CE7C
        ORI.W  #$003D,(A5)+                     ; $11CE82
        ORI.W  #$0061,D2                        ; $11CE86
        BCLR    D0,(A4)                         ; $11CE8A
        BCLR    D0,(A3)                         ; $11CE8C
        ORI.W  #$0064,$0060(A7)                 ; $11CE8E
        BCLR    D2,(A3)                         ; $11CE94
        ANDI.L  #$014C034B,(A2)                 ; $11CE96
        BCHG    #9,$0020(A6)                    ; $11CE9C
        BTST    D0,(A1)+                        ; $11CEA2
        DC.W    $0018,$001C         ; $11CEA4 ORI.B  #$001C,(A0)+
        DC.W    $0013,$0119         ; $11CEA8 ORI.B  #$0119,(A3)
        DC.W    $003D,$006E         ; $11CEAC ORI.B  #$006E,<EA:3D>
        BCLR    D1,(A0)                         ; $11CEB0
        ORI.L  #$00590036,(A1)                  ; $11CEB2
        DC.W    $0039,$009E,$0393,$0094; $11CEB8 ORI.B  #$009E,$03930094
        ORI.L  #$00230061,D6                    ; $11CEC0
        BCLR    D0,(A4)                         ; $11CEC6
        BCLR    D0,-(A3)                        ; $11CEC8
        DC.W    $007F,$0035         ; $11CECA ORI.W  #$0035,<EA:3F>
        DC.W    $0019,$001D         ; $11CECE ORI.B  #$001D,(A1)+
        DC.W    $001C,$5900         ; $11CED2 ORI.B  #$5900,(A4)+
        ORI.W  #$5600,A7                        ; $11CED6
        DC.W    $0001,$0011         ; $11CEDA ORI.B  #$0011,D1
        DC.W    $0219,$0067         ; $11CEDE ANDI.B  #$0067,(A1)+
        BCLR    D1,(A0)                         ; $11CEE2
        ORI.W  #$0082,$0077(A6)                 ; $11CEE4
        BCLR    D2,(A0)                         ; $11CEEA
        ORI.W  #$00AA,$0034(A6)                 ; $11CEEC
        BCLR    D1,$0156(A2)                    ; $11CEF2
        DC.W    $0034,$02AA,$0456   ; $11CEF6 ORI.B  #$02AA,$56(A4,D0.W)
        ORI.L  #$003D0019,(A7)                  ; $11CEFC
        ORI.W  #$004D,-(A3)                     ; $11CF02
        BCLR    D1,(A0)                         ; $11CF06
        ORI.W  #$002B,$0038(A5)                 ; $11CF08
        ANDI.L  #$00930092,(A6)+                ; $11CF0E
        ORI.W  #$0137,(A2)+                     ; $11CF14
        BCHG    D1,D7                           ; $11CF18
        DC.W    $02AB,$003B,$01AC,$0143; $11CF1A ANDI.L  #$003B01AC,$0143(A3)
        ORI.W  #$002C,D2                        ; $11CF22
        DC.W    $0028,$0019,$0042   ; $11CF26 ORI.B  #$0019,$0042(A0)
        ORI.W  #$0194,-(A1)                     ; $11CF2C
        BCLR    D0,(A3)                         ; $11CF30
        ORI.W  #$0064,$0060(A7)                 ; $11CF32
        SUBI.L  #$004A0151,(A3)                 ; $11CF38
        ORI.W  #$0181,-(A3)                     ; $11CF3E
        ANDI.W  #$0283,$0720(A1)                ; $11CF42
        DC.W    $0219,$001E         ; $11CF48 ANDI.B  #$001E,(A1)+
        DC.W    $000E,$0219         ; $11CF4C ORI.B  #$0219,A6
        ORI.W  #$0490,$4B(A0,D0.W)              ; $11CF50
        ORI.L  #$00360038,D3                    ; $11CF56
        ORI.L  #$03930094,(A6)+                 ; $11CF5C
        ORI.W  #$0025,(A4)+                     ; $11CF62
        DC.W    $007E,$0194         ; $11CF66 ORI.W  #$0194,<EA:3E>
        BCLR    D0,-(A3)                        ; $11CF6A
        ORI.L  #$00A70019,-(A5)                 ; $11CF6C
        DC.W    $001E,$0004         ; $11CF72 ORI.B  #$0004,(A6)+
        SUBQ.B  #4,D0                           ; $11CF76
        ORI.W  #$5600,A0                        ; $11CF78
        DC.W    $0001,$0011         ; $11CF7C ORI.B  #$0011,D1
        DC.W    $0219,$0067         ; $11CF80 ANDI.B  #$0067,(A1)+
        BCLR    D1,(A0)                         ; $11CF84
        ORI.W  #$0069,$008C(A6)                 ; $11CF86
        ORI.W  #$0490,$66(A1,D0.W)              ; $11CF8C
        ORI.L  #$0065042B,(A2)+                 ; $11CF92
        DC.W    $00AD,$0B19,$0063,$004D; $11CF98 ORI.L  #$0B190063,$004D(A5)
        BCLR    D1,(A0)                         ; $11CFA0
        ORI.W  #$002B,$0038(A5)                 ; $11CFA2
        ANDI.L  #$0093004B,(A6)+                ; $11CFA8
        DC.W    $0021,$0073         ; $11CFAE ORI.B  #$0073,-(A1)
        DC.W    $0221,$0068         ; $11CFB2 ANDI.B  #$0068,-(A1)
        BCLR    D0,$0247(A3)                    ; $11CFB6
        DC.W    $0037,$0021,$003D   ; $11CFBA ORI.B  #$0021,$3D(A7,D0.W)
        SUBI.B  #$0042,(A1)+                    ; $11CFC0
        ORI.W  #$0194,-(A1)                     ; $11CFC4
        BCLR    D0,(A3)                         ; $11CFC8
        ORI.W  #$0064,$0060(A7)                 ; $11CFCA
        SUBI.L  #$00490064,(A3)                 ; $11CFD0
        ORI.W  #$064B,$6E(A6,D0.L)              ; $11CFD6
        DC.W    $00AE,$0020,$0119,$001E; $11CFDC ORI.L  #$00200119,$001E(A6)
        DC.W    $0010,$0219         ; $11CFE4 ORI.B  #$0219,(A0)
        ORI.L  #$04900067,(A7)                  ; $11CFE8
        ORI.L  #$006D019E,D1                    ; $11CFEE
        SUBI.L  #$00610023,(A3)                 ; $11CFF4
        ORI.W  #$0194,(A4)+                     ; $11CFFA
        BCLR    D0,-(A3)                        ; $11CFFE
        ORI.L  #$00AF0019,(A5)                  ; $11D000
        DC.W    $001E,$000C         ; $11D006 ORI.B  #$000C,(A6)+
        SUBQ.B  #4,D0                           ; $11D00A
        ORI.W  #$5600,D5                        ; $11D00C
        DC.W    $0001,$0012         ; $11D010 ORI.B  #$0012,D1
        DC.W    $0219,$0067         ; $11D014 ANDI.B  #$0067,(A1)+
        BCLR    D1,(A0)                         ; $11D018
        ORI.W  #$0070,A5                        ; $11D01A
        DC.W    $0020,$00AE         ; $11D01E ORI.B  #$00AE,-(A0)
        BCLR    D2,(A0)                         ; $11D022
        ADDI.W  #$006C,A6                       ; $11D024
        ORI.W  #$009A,$20(A0,D0.W)              ; $11D028
        BTST    #3,(A1)+                        ; $11D02E
        ORI.W  #$0390,A5                        ; $11D032
        ORI.W  #$002B,$0038(A5)                 ; $11D036
        ANDI.L  #$01930053,(A6)+                ; $11D03C
        BCHG    D0,-(A1)                        ; $11D042
        ADDI.L  #$01940078,(A3)                 ; $11D044
        DC.W    $003D,$0419         ; $11D04A ORI.B  #$0419,<EA:3D>
        ORI.W  #$0061,D2                        ; $11D04E
        BCLR    D0,(A4)                         ; $11D052
        BCLR    D0,(A3)                         ; $11D054
        ORI.W  #$0064,$0060(A7)                 ; $11D056
        SUBI.L  #$00490028,(A3)                 ; $11D05C
        ORI.L  #$049E0191,(A2)                  ; $11D062
        BCLR    #8,(A0)                         ; $11D068
        ORI.L  #$02190017,D3                    ; $11D06C
        BTST    D0,(A1)+                        ; $11D072
        ORI.L  #$006B0390,D3                    ; $11D074
        ORI.W  #$0055,A5                        ; $11D07A
        ORI.W  #$004C,-(A3)                     ; $11D07E
        BCLR    D0,(A6)+                        ; $11D082
        BCLR    D2,(A3)                         ; $11D084
        DC.W    $00AC,$0073,$0194,$01A3; $11D086 ORI.L  #$00730194,$01A3(A4)
        ORI.L  #$00B00119,(A5)                  ; $11D08E
        DC.W    $001D,$0009         ; $11D094 ORI.B  #$0009,(A5)+
        ADDQ.B  #4,D0                           ; $11D098
        ORI.W  #$5600,D1                        ; $11D09A
        DC.W    $0001,$000F         ; $11D09E ORI.B  #$000F,D1
        DC.W    $0219,$0067         ; $11D0A2 ANDI.B  #$0067,(A1)+
        SUBI.L  #$006E0020,(A0)                 ; $11D0A6
        ORI.W  #$0088,-(A3)                     ; $11D0AC
        CMPI.L  #$00A6004E,(A0)                 ; $11D0B0
        ORI.W  #$0097,$0719(A3)                 ; $11D0B6
        ORI.L  #$004D0390,D1                    ; $11D0BC
        ORI.W  #$002B,$0038(A5)                 ; $11D0C2
        ANDI.L  #$08930494,(A6)+                ; $11D0C8
        ORI.W  #$003D,$0419(A7)                 ; $11D0CE
        ORI.W  #$0061,D2                        ; $11D0D4
        ANDI.L  #$0093006F,(A4)                 ; $11D0D8
        ORI.W  #$0060,-(A4)                     ; $11D0DE
        SUBI.L  #$00490028,(A3)                 ; $11D0E2
        ORI.L  #$049E0191,(A2)                  ; $11D0E8
        BCLR    #8,(A0)                         ; $11D0EE
        ORI.L  #$05190055,D3                    ; $11D0F2
        ORI.W  #$0390,A5                        ; $11D0F8
        ORI.W  #$003E,A3                        ; $11D0FC
        ORI.W  #$0038,-(A5)                     ; $11D100
        BCLR    D0,(A6)+                        ; $11D104
        SUBI.L  #$00940062,(A3)                 ; $11D106
        DC.W    $0026,$006F         ; $11D10C ORI.B  #$006F,-(A6)
        ORI.L  #$02A30096,(A4)                  ; $11D110
        DC.W    $00B1,$0019,$0018,$000A; $11D116 ORI.L  #$00190018,$0A(A1,D0.W)
        ADDQ.B  #4,D0                           ; $11D11E
        ORI.W  #$5600,D1                        ; $11D120
        DC.W    $0001,$0006         ; $11D124 ORI.B  #$0006,D1
        DC.W    $001F,$0119         ; $11D128 ORI.B  #$0119,(A7)+
        DC.W    $00B2,$004D,$0490,$0077; $11D12C ORI.L  #$004D0490,$77(A2,D0.W)
        ORI.W  #$00AA,$004E(A1)                 ; $11D134
        EORI.L  #$04A60097,(A0)                 ; $11D13A
        DC.W    $0020,$0519         ; $11D140 ORI.B  #$0519,-(A0)
        ORI.L  #$004D0390,D1                    ; $11D144
        ORI.W  #$002B,$0038(A5)                 ; $11D14A
        ANDI.L  #$08930494,(A6)+                ; $11D150
        ORI.W  #$003D,$0419(A7)                 ; $11D156
        ORI.W  #$0061,D2                        ; $11D15C
        ANDI.L  #$0093006F,(A4)                 ; $11D160
        ORI.W  #$0060,-(A4)                     ; $11D166
        SUBI.L  #$00490028,(A3)                 ; $11D16A
        ORI.L  #$049E0191,(A2)                  ; $11D170
        BCLR    #8,(A0)                         ; $11D176
        ORI.L  #$05190058,D3                    ; $11D17A
        SUBI.L  #$006D0083,(A0)                 ; $11D180
        ORI.W  #$029E,$0493(A5)                 ; $11D186
        ORI.L  #$006F0040,(A4)                  ; $11D18C
        ORI.W  #$0094,(A5)+                     ; $11D192
        ANDI.L  #$00B300B4,-(A3)                ; $11D196
        DC.W    $0019,$001E         ; $11D19C ORI.B  #$001E,(A1)+
        DC.W    $000C,$0008         ; $11D1A0 ORI.B  #$0008,A4
        SUBQ.B  #3,D0                           ; $11D1A4
        ORI.W  #$5700,D5                        ; $11D1A6
        DC.W    $0009,$0015         ; $11D1AA ORI.B  #$0015,A1
        BTST    D0,(A1)+                        ; $11D1AE
        DC.W    $003D,$0066         ; $11D1B0 ORI.B  #$0066,<EA:3D>
        SUBI.L  #$006E0064,(A0)                 ; $11D1B4
        ORI.L  #$009A00AE,D2                    ; $11D1BA
        ORI.W  #$0890,-$5A(A1,D0.W)             ; $11D1C0
        DC.W    $00B5,$006B,$0065,$0419; $11D1C6 ORI.L  #$006B0065,$19(A5,D0.W)
        ORI.L  #$004D0390,D1                    ; $11D1CE
        ORI.W  #$002B,$0038(A5)                 ; $11D1D4
        ANDI.L  #$08930494,(A6)+                ; $11D1DA
        ORI.W  #$003D,$0419(A7)                 ; $11D1E0
        ORI.W  #$0061,D2                        ; $11D1E6
        ANDI.L  #$0093006F,(A4)                 ; $11D1EA
        ORI.W  #$0060,-(A4)                     ; $11D1F0
        SUBI.L  #$00490028,(A3)                 ; $11D1F4
        ORI.L  #$049E0191,(A2)                  ; $11D1FA
        BCLR    #8,(A0)                         ; $11D200
        ORI.L  #$04190063,D3                    ; $11D204
        ORI.W  #$0390,$004D(A3)                 ; $11D20A
        DC.W    $002B,$0083,$004B   ; $11D210 ORI.B  #$0083,$004B(A3)
        ANDI.L  #$04930094,(A6)+                ; $11D216
        ORI.W  #$0048,-(A1)                     ; $11D21C
        ORI.W  #$0079,D2                        ; $11D220
        ANDI.L  #$009500B0,-(A3)                ; $11D224
        ORI.L  #$00190017,D7                    ; $11D22A
        DC.W    $0002,$5700         ; $11D230 ORI.B  #$5700,D2
        ORI.W  #$5700,D7                        ; $11D234
        DC.W    $0001,$000F         ; $11D238 ORI.B  #$000F,D1
        DC.W    $0219,$0036         ; $11D23C ANDI.B  #$0036,(A1)+
        ORI.W  #$0490,$66(A1,D0.W)              ; $11D240
        ORI.W  #$00B6,(A5)                      ; $11D246
        ORI.W  #$008B,-(A3)                     ; $11D24A
        DC.W    $00AE,$0688,$004E,$05A6; $11D24E ORI.L  #$0688004E,$05A6(A6)
        ORI.L  #$0088009A,(A0)                  ; $11D256
        BTST    D1,(A1)+                        ; $11D25C
        ORI.L  #$004D0390,D1                    ; $11D25E
        ORI.W  #$0029,$004B(A5)                 ; $11D264
        DC.W    $014C               ; $11D26A BCHG    D0,A4
        ANDI.L  #$0339076F,(A2)                 ; $11D26C
        ORI.W  #$003D,A1                        ; $11D272
        SUBI.B  #$0042,(A1)+                    ; $11D276
        ORI.W  #$0294,-(A1)                     ; $11D27A
        ORI.L  #$006F0064,(A3)                  ; $11D27E
        ORI.W  #$0493,-(A0)                     ; $11D284
        ORI.W  #$0027,A1                        ; $11D288
        ORI.W  #$0092,$004C(A5)                 ; $11D28C
        DC.W    $054B               ; $11D292 BCHG    D2,A3
        BCHG    D0,$0590(A6)                    ; $11D294
        ORI.L  #$00830419,A0                    ; $11D298
        ORI.W  #$004E,-(A5)                     ; $11D29E
        BCLR    D1,(A0)                         ; $11D2A2
        ORI.W  #$0064,A4                        ; $11D2A4
        ORI.W  #$0091,(A5)                      ; $11D2A8
        ANDI.L  #$04930194,(A6)+                ; $11D2AC
        ORI.L  #$00260079,D6                    ; $11D2B2
        BCLR    D1,-(A3)                        ; $11D2B8
        ORI.L  #$00740019,(A6)                  ; $11D2BA
        DC.W    $001F,$000A         ; $11D2C0 ORI.B  #$000A,(A7)+
        SUBQ.B  #3,D0                           ; $11D2C4
        ORI.W  #$5800,A1                        ; $11D2C6
        DC.W    $0007,$0018         ; $11D2CA ORI.B  #$0018,D7
        BTST    D0,(A1)+                        ; $11D2CE
        DC.W    $0035,$0066,$0590   ; $11D2D0 ORI.B  #$0066,-$70(A5,D0.W)
        ORI.W  #$006B,A5                        ; $11D2D6
        ORI.W  #$0083,-$68(A7,D0.W)             ; $11D2DA
        ORI.W  #$0598,$0055(A1)                 ; $11D2E0
        ORI.W  #$006E,-$5A(PC,D0.W)             ; $11D2E6
        ORI.L  #$004E00B7,(A0)                  ; $11D2EC
        DC.W    $0219,$0081         ; $11D2F2 ANDI.B  #$0081,(A1)+
        ORI.W  #$0390,A6                        ; $11D2F6
        ORI.W  #$0035,$0281(A5)                 ; $11D2FA
        ORI.W  #$0751,-(A3)                     ; $11D300
        BTST    D2,-(A7)                        ; $11D304
        ORI.W  #$0519,(A1)                      ; $11D306
        ORI.W  #$0061,D2                        ; $11D30A
        ANDI.L  #$0093006F,(A4)                 ; $11D30E
        ORI.W  #$0060,-(A4)                     ; $11D314
        SUBI.L  #$0049003D,(A3)                 ; $11D318
        BCLR    D1,D1                           ; $11D31E
        BCHG    D2,$0098(A1)                    ; $11D320
        ORI.W  #$04B8,(A0)                      ; $11D324
        ORI.L  #$00830419,A0                    ; $11D328
        ORI.W  #$00B5,(A5)                      ; $11D32E
        BCLR    D1,$006B.W                      ; $11D332
        ORI.W  #$006D,-(A3)                     ; $11D336
        BCLR    D1,$00BA0060                    ; $11D33A
        DC.W    $0038,$01BA,$01BB   ; $11D340 ORI.B  #$01BA,$01BB.W
        ORI.W  #$0051,$005F(A7)                 ; $11D346
        ANDI.L  #$00BC0079,-(A3)                ; $11D34C
        DC.W    $00B1,$0119,$000D,$0008; $11D352 ORI.L  #$0119000D,$08(A1,D0.W)
        ADDQ.B  #3,D0                           ; $11D35A
        ORI.W  #$5800,A4                        ; $11D35C
        DC.W    $0002,$000D         ; $11D360 ORI.B  #$000D,D2
        DC.W    $0219,$008B         ; $11D364 ANDI.B  #$008B,(A1)+
        BCLR    #14,(A0)                        ; $11D368
        ORI.W  #$006B,$00B7(A4)                 ; $11D36C
        ORI.L  #$00830069,(A0)+                 ; $11D372
        ORI.W  #$006C,-$5A(A7,D0.W)             ; $11D378
        BCLR    D0,(A0)                         ; $11D37E
        ORI.W  #$0219,(A6)                      ; $11D380
        ORI.L  #$004E0390,D1                    ; $11D384
        ORI.W  #$008B,$0067(A5)                 ; $11D38A
        DC.W    $034B               ; $11D390 BCHG    D1,A3
        SUBI.W  #$0192,-(A0)                    ; $11D392
        BCHG    D2,$0054(A7)                    ; $11D396
        DC.W    $003D,$0419         ; $11D39A ORI.B  #$0419,<EA:3D>
        ORI.L  #$009302BB,-(A4)                 ; $11D39E
        DC.W    $00BA,$006F,$0064,$0060; $11D3A4 ORI.L  #$006F0064,$0060(PC)
        DC.W    $04BA,$0049,$0064,$0075; $11D3AC SUBI.L  #$00490064,$0075(PC)
        ADDI.W  #$0088,A3                       ; $11D3B4
        ORI.W  #$00B6,-(A6)                     ; $11D3B8
        ORI.W  #$04B8,(A0)                      ; $11D3BC
        ORI.L  #$00830319,-(A1)                 ; $11D3C0
        ORI.W  #$004F,-(A4)                     ; $11D3C6
        BCLR    D1,$0090.W                      ; $11D3CA
        DC.W    $002B,$0083,$006E   ; $11D3CE ORI.B  #$0083,$006E(A3)
        BCLR    D1,$004C003E                    ; $11D3D4
        DC.W    $002E,$0093,$00BA   ; $11D3DA ORI.B  #$0093,$00BA(A6)
        BCLR    D0,$53(PC,D0.W)                 ; $11D3E0
        DC.W    $0026,$00A4         ; $11D3E4 ORI.B  #$00A4,-(A6)
        ORI.L  #$03BC0045,(A4)                  ; $11D3E8
        ORI.L  #$00190010,D7                    ; $11D3EE
        DC.W    $0008,$5600         ; $11D3F4 ORI.B  #$5600,A0
        ORI.W  #$5900,A5                        ; $11D3F8
        DC.W    $000B,$000D         ; $11D3FC ORI.B  #$000D,A3
        BTST    D0,(A1)+                        ; $11D400
        DC.W    $0020,$0097         ; $11D402 ORI.B  #$0097,-(A0)
        DC.W    $00B5,$0EB8,$00B5,$0088; $11D406 ORI.L  #$0EB800B5,-$78(A5,D0.W)
        DC.W    $00AE,$008B,$0082,$00AD; $11D40E ORI.L  #$008B0082,$00AD(A6)
        ORI.L  #$00BD02B8,-(A1)                 ; $11D416
        ORI.W  #$008C,A6                        ; $11D41C
        BTST    D0,(A1)+                        ; $11D420
        ORI.W  #$00B5,-(A3)                     ; $11D422
        BCLR    D1,$006D.W                      ; $11D426
        DC.W    $002B,$0091,$02B9   ; $11D42A ORI.B  #$0091,$02B9(A3)
        BCLR    D3,$00BE(PC)                    ; $11D430
        DC.W    $04BB,$0053,$003D,$0419; $11D434 SUBI.L  #$0053003D,$19(PC,D0.W)
        ORI.L  #$009302BB,-(A4)                 ; $11D43C
        DC.W    $00BE,$0053,$0027   ; $11D442 ORI.L  #$00530027,<EA:3E>
        ORI.L  #$00BE03BA,(A2)                  ; $11D448
        ORI.W  #$0028,A2                        ; $11D44E
        DC.W    $0038,$06B9,$00BF   ; $11D452 ORI.B  #$06B9,$00BF.W
        ORI.W  #$008A,A5                        ; $11D458
        ORI.W  #$04B8,(A0)                      ; $11D45C
        ORI.L  #$00830319,-(A1)                 ; $11D460
        DC.W    $0036,$00A6,$03BF   ; $11D466 ORI.B  #$00A6,-$41(A6,D0.W)
        ORI.W  #$002B,A6                        ; $11D46C
        ORI.L  #$00BF03C0,(A7)                  ; $11D470
        DC.W    $00C1               ; $11D476 DC.W    $00C1
        DC.W    $0019,$002C         ; $11D478 ORI.B  #$002C,(A1)+
        DC.W    $00C2               ; $11D47C DC.W    $00C2
        DC.W    $00BE,$02C3,$0054   ; $11D47E ORI.L  #$02C30054,<EA:3E>
        ORI.W  #$0094,D3                        ; $11D484
        BCLR    D1,#$00C4                       ; $11D488
        DC.W    $00B1,$0019,$0014,$0009; $11D48C ORI.L  #$00190014,$09(A1,D0.W)
        ADDQ.B  #3,D0                           ; $11D494
        ORI.W  #$5A00,A5                        ; $11D496
        DC.W    $001C,$001D         ; $11D49A ORI.B  #$001D,(A4)+
        BTST    D0,(A1)+                        ; $11D49E
        DC.W    $0035,$0077,$0088   ; $11D4A0 ORI.B  #$0077,-$78(A5,D0.W)
        BCLR    D2,$07BF.W                      ; $11D4A6
        BCLR    D0,$00BD.W                      ; $11D4AA
        ORI.W  #$00C5,A6                        ; $11D4AE
        ORI.L  #$00C500BD,D2                    ; $11D4B2
        DC.W    $00B8,$01BF,$00BD,$0089; $11D4B8 ORI.L  #$01BF00BD,$0089.W
        BTST    D0,(A1)+                        ; $11D4C0
        ORI.W  #$0090,-(A3)                     ; $11D4C2
        DC.W    $03BF               ; $11D4C6 BCLR    D1,<EA:3F>
        ORI.W  #$002B,-(A7)                     ; $11D4C8
        ORI.L  #$02B908BE,(A1)                  ; $11D4CC
        DC.W    $04C3               ; $11D4D2 DC.W    $04C3
        ORI.W  #$003D,-(A1)                     ; $11D4D4
        SUBI.B  #$0043,(A1)+                    ; $11D4D8
        DC.W    $00C2               ; $11D4DC DC.W    $00C2
        DC.W    $02C3               ; $11D4DE DC.W    $02C3
        DC.W    $00BE,$0061,$0027   ; $11D4E0 ORI.L  #$00610027,<EA:3E>
        DC.W    $0039,$04BE,$00C6,$0028; $11D4E6 ORI.B  #$04BE,$00C60028
        DC.W    $00C7               ; $11D4EE DC.W    $00C7
        DC.W    $06C0               ; $11D4F0 DC.W    $06C0
        DC.W    $00BF,$004D,$0028   ; $11D4F2 ORI.L  #$004D0028,<EA:3F>
        DC.W    $00C8               ; $11D4F8 DC.W    $00C8
        DC.W    $04BF,$004E,$003E   ; $11D4FA SUBI.L  #$004E003E,<EA:3F>
        BTST    D1,(A1)+                        ; $11D500
        ORI.W  #$00A6,-$41(A0,D0.W)             ; $11D502
        ORI.W  #$0064,-(A6)                     ; $11D508
        ORI.W  #$00B9,(A0)                      ; $11D50C
        BSET    D1,D0                           ; $11D510
        DC.W    $00C6               ; $11D512 DC.W    $00C6
        DC.W    $0019,$002B         ; $11D514 ORI.B  #$002B,(A1)+
        ORI.L  #$00BE02C3,(A3)                  ; $11D518
        ORI.W  #$003C,$0078(A7)                 ; $11D51E
        ORI.L  #$02BC0095,-(A3)                 ; $11D524
        DC.W    $00C9               ; $11D52A DC.W    $00C9
        DC.W    $0019,$0018         ; $11D52C ORI.B  #$0018,(A1)+
        DC.W    $0006,$5600         ; $11D530 ORI.B  #$5600,D6
        ORI.W  #$5A00,A2                        ; $11D534
        DC.W    $0001,$001B         ; $11D538 ORI.B  #$001B,D1
        BTST    D1,(A1)+                        ; $11D53C
        ORI.W  #$00AE,$0EBF(A2)                 ; $11D53E
        DC.W    $01BD               ; $11D544 BCLR    D0,<EA:3D>
        ORI.W  #$008B,A6                        ; $11D546
        ORI.L  #$004E03BF,(A0)+                 ; $11D54A
        ORI.W  #$003E,A6                        ; $11D550
        DC.W    $0019,$0051         ; $11D554 ORI.B  #$0051,(A1)+
        ORI.L  #$03BF0067,(A0)                  ; $11D558
        DC.W    $002B,$009E,$02C0   ; $11D55E ORI.B  #$009E,$02C0(A3)
        DC.W    $08BE,$04C3         ; $11D564 BCLR    #3,<EA:3E>
        ORI.W  #$003D,-(A1)                     ; $11D568
        SUBI.B  #$0043,(A1)+                    ; $11D56C
        DC.W    $00C2               ; $11D570 DC.W    $00C2
        DC.W    $02C3               ; $11D572 DC.W    $02C3
        DC.W    $00BE,$0061,$0027   ; $11D574 ORI.L  #$00610027,<EA:3E>
        DC.W    $0039,$04BE,$00C6,$0028; $11D57A ORI.B  #$04BE,$00C60028
        DC.W    $00C7               ; $11D582 DC.W    $00C7
        DC.W    $06C0               ; $11D584 DC.W    $06C0
        DC.W    $00BF,$004D,$0028   ; $11D586 ORI.L  #$004D0028,<EA:3F>
        DC.W    $00C8               ; $11D58C DC.W    $00C8
        DC.W    $04BF,$004E,$003E   ; $11D58E SUBI.L  #$004E003E,<EA:3F>
        DC.W    $0219,$0082         ; $11D594 ANDI.B  #$0082,(A1)+
        ORI.W  #$03BF,A7                        ; $11D598
        DC.W    $00CA               ; $11D59C DC.W    $00CA
        ORI.W  #$0064,(A5)                      ; $11D59E
        ORI.W  #$00B9,-(A7)                     ; $11D5A2
        DC.W    $02C0               ; $11D5A6 DC.W    $02C0
        ORI.L  #$008D0019,(A6)+                 ; $11D5A8
        DC.W    $003F,$004A         ; $11D5AE ORI.B  #$004A,<EA:3F>
        DC.W    $00BE,$02C3,$0079   ; $11D5B2 ORI.L  #$02C30079,<EA:3E>
        ORI.W  #$0062,D2                        ; $11D5B8
        ORI.L  #$02CB00CC,-(A3)                 ; $11D5BC
        DC.W    $00CD               ; $11D5C2 DC.W    $00CD
        DC.W    $0019,$0018         ; $11D5C4 ORI.B  #$0018,(A1)+
        DC.W    $0005,$5600         ; $11D5C8 ORI.B  #$5600,D5
        ORI.W  #$5700,(A1)                      ; $11D5CC
        DC.W    $0002,$020A         ; $11D5D0 ORI.B  #$020A,D2
        DC.W    $0003,$000C         ; $11D5D4 ORI.B  #$000C,D3
        BTST    D1,(A1)+                        ; $11D5D8
        DC.W    $003D,$00C5         ; $11D5DA ORI.B  #$00C5,<EA:3D>
        ORI.W  #$0CBF,-$43(A1,D0.W)             ; $11D5DE
        ORI.W  #$0083,$00C5(A3)                 ; $11D5E4
        DC.W    $00BD,$02BF,$004E   ; $11D5EA ORI.L  #$02BF004E,<EA:3D>
        DC.W    $003E,$0019         ; $11D5F0 ORI.B  #$0019,<EA:3E>
        ORI.W  #$0090,(A1)                      ; $11D5F4
        DC.W    $02BF,$00B9,$0067   ; $11D5F8 ANDI.L  #$00B90067,<EA:3F>
        DC.W    $002B,$009E,$02C0   ; $11D5FE ORI.B  #$009E,$02C0(A3)
        DC.W    $08BE,$04C3         ; $11D604 BCLR    #3,<EA:3E>
        ORI.W  #$003D,-(A1)                     ; $11D608
        SUBI.B  #$0043,(A1)+                    ; $11D60C
        DC.W    $00C2               ; $11D610 DC.W    $00C2
        BSET    D0,D3                           ; $11D612
        DC.W    $01BE               ; $11D614 BCLR    D0,<EA:3E>
        ORI.W  #$0027,-(A1)                     ; $11D616
        DC.W    $0039,$04BE,$00C6,$0028; $11D61A ORI.B  #$04BE,$00C60028
        DC.W    $00C7               ; $11D622 DC.W    $00C7
        DC.W    $04BE,$01C0,$00B9   ; $11D624 SUBI.L  #$01C000B9,<EA:3E>
        ORI.W  #$0028,A5                        ; $11D62A
        DC.W    $00C8               ; $11D62E DC.W    $00C8
        BCLR    D0,$02BF004E                    ; $11D630
        DC.W    $003E,$0219         ; $11D636 ORI.B  #$0219,<EA:3E>
        ORI.W  #$004E,-(A4)                     ; $11D63A
        DC.W    $02BF,$00B9,$0090   ; $11D63E ANDI.L  #$00B90090,<EA:3F>
        ORI.L  #$006A009E,(A1)+                 ; $11D644
        DC.W    $00C0               ; $11D64A DC.W    $00C0
        DC.W    $02BE,$0038,$0035   ; $11D64C ANDI.L  #$00380035,<EA:3E>
        BTST    D0,(A1)+                        ; $11D652
        DC.W    $0037,$00BB,$00C3   ; $11D654 ORI.B  #$00BB,-$3D(A7,D0.W)
        ANDI.L  #$00620046,-(A3)                ; $11D65A
        DC.W    $00CC               ; $11D660 DC.W    $00CC
        DC.W    $02CB               ; $11D662 DC.W    $02CB
        DC.W    $00CC               ; $11D664 DC.W    $00CC
        DC.W    $00CE               ; $11D666 DC.W    $00CE
        DC.W    $00CF               ; $11D668 DC.W    $00CF
        DC.W    $0019,$0014         ; $11D66A ORI.B  #$0014,(A1)+
        DC.W    $0002,$5500         ; $11D66E ORI.B  #$5500,D2
        ORI.W  #$5600,A4                        ; $11D672
        DC.W    $0001,$0010         ; $11D676 ORI.B  #$0010,D1
        DC.W    $0A19,$0020         ; $11D67A EORI.B  #$0020,(A1)+
        ORI.W  #$0034,(A5)                      ; $11D67E
        ORI.W  #$07A6,$04BF(A4)                 ; $11D682
        ORI.L  #$008B0082,-(A6)                 ; $11D688
        ORI.W  #$02BF,A6                        ; $11D68E
        ORI.W  #$003E,A6                        ; $11D692
        DC.W    $0019,$0051         ; $11D696 ORI.B  #$0051,(A1)+
        ORI.L  #$00BF00B9,(A0)                  ; $11D69A
        BCLR    D0,$0067(PC)                    ; $11D6A0
        DC.W    $002B,$009E,$02BE   ; $11D6A4 ORI.B  #$009E,$02BE(A3)
        BCLR    D4,-$5D(PC,D0.W)                ; $11D6AA
        ORI.W  #$003D,$0419(A7)                 ; $11D6AE
        ORI.W  #$0094,D3                        ; $11D6B4
        ANDI.L  #$00BB0061,-(A3)                ; $11D6B8
        DC.W    $0027,$0039         ; $11D6BE ORI.B  #$0039,-(A7)
        DC.W    $04BB,$005F,$0028,$0061; $11D6C2 SUBI.L  #$005F0028,$61(PC,D0.W)
        DC.W    $00BB,$05BE,$00BA,$0038; $11D6CA ORI.L  #$05BE00BA,$38(PC,D0.W)
        DC.W    $0028,$0075,$04B9   ; $11D6D2 ORI.B  #$0075,$04B9(A0)
        ORI.W  #$003E,A5                        ; $11D6D8
        DC.W    $0219,$0034         ; $11D6DC ANDI.B  #$0034,(A1)+
        DC.W    $00BF,$03B9,$0075   ; $11D6E0 ORI.L  #$03B90075,<EA:3F>
        ORI.L  #$0031009E,D2                    ; $11D6E6
        DC.W    $03BE               ; $11D6EC BCLR    D1,<EA:3E>
        ORI.W  #$0219,A2                        ; $11D6EE
        DC.W    $0021,$00BB         ; $11D6F2 ORI.B  #$00BB,-(A1)
        BCLR    D1,-(A3)                        ; $11D6F6
        DC.W    $00D0               ; $11D6F8 DC.W    $00D0
        DC.W    $00D1               ; $11D6FA DC.W    $00D1
        DC.W    $00D2               ; $11D6FC DC.W    $00D2
        DC.W    $02CB               ; $11D6FE DC.W    $02CB
        DC.W    $00D3               ; $11D700 DC.W    $00D3
        DC.W    $00D4               ; $11D702 DC.W    $00D4
        DC.W    $00B1,$0019,$001A,$0009; $11D704 ORI.L  #$0019001A,$09(A1,D0.W)
        SUBQ.B  #2,D0                           ; $11D70C
        ORI.W  #$5600,(A4)                      ; $11D70E
        DC.W    $0001,$0011         ; $11D712 ORI.B  #$0011,D1
        BTST    D6,(A1)+                        ; $11D716
        ORI.W  #$009A,-(A4)                     ; $11D718
        ORI.L  #$009A0465,A5                    ; $11D71C
        ORI.L  #$04B90067,A1                    ; $11D722
        ORI.L  #$004D02B9,D2                    ; $11D728
        ORI.W  #$003E,A5                        ; $11D72E
        DC.W    $0019,$0051         ; $11D732 ORI.B  #$0051,(A1)+
        ORI.L  #$01B901BA,(A1)                  ; $11D736
        ORI.W  #$002B,A2                        ; $11D73C
        ORI.L  #$02BE00BB,(A3)                  ; $11D740
        DC.W    $0039,$0068,$0121,$02AB; $11D746 ORI.B  #$0068,$012102AB
        ORI.W  #$0146,D7                        ; $11D74E
        ANDI.W  #$00AB,-(A2)                    ; $11D752
        DC.W    $003D,$0419         ; $11D756 ORI.B  #$0419,<EA:3D>
        ORI.W  #$0094,D3                        ; $11D75A
        BCLR    D1,-(A3)                        ; $11D75E
        DC.W    $0079,$0027,$006F,$04BB; $11D760 ORI.W  #$0027,$006F04BB
        ORI.W  #$0027,-(A0)                     ; $11D768
        ORI.W  #$0139,A1                        ; $11D76C
        DC.W    $00BA,$03BE,$00BA,$0038; $11D770 ORI.L  #$03BE00BA,$0038(PC)
        DC.W    $0028,$0075,$04B9   ; $11D778 ORI.B  #$0075,$04B9(A0)
        ORI.W  #$003E,A5                        ; $11D77E
        BTST    D0,(A1)+                        ; $11D782
        DC.W    $0035,$004C,$04B9   ; $11D784 ORI.B  #$004C,-$47(A5,D0.W)
        ORI.W  #$008A,(A7)                      ; $11D78A
        ORI.W  #$00BA,A2                        ; $11D78E
        DC.W    $02BE,$0093,$002A   ; $11D792 ANDI.L  #$0093002A,<EA:3E>
        DC.W    $0219,$003E         ; $11D798 ANDI.B  #$003E,(A1)+
        ORI.W  #$02A3,$00BC(A7)                 ; $11D79C
        DC.W    $0079,$0042,$00D2,$02CB; $11D7A2 ORI.W  #$0042,$00D202CB
        DC.W    $00D3               ; $11D7AA DC.W    $00D3
        DC.W    $00D5               ; $11D7AC DC.W    $00D5
        ORI.W  #$0019,$001A(PC)                 ; $11D7AE
        DC.W    $0006,$0008         ; $11D7B4 ORI.B  #$0008,D6
        ADDQ.B  #2,D0                           ; $11D7B8
        ORI.W  #$5600,(A2)+                     ; $11D7BA
        DC.W    $0001,$0011         ; $11D7BE ORI.B  #$0011,D1
        DC.W    $0219,$002B         ; $11D7C2 ANDI.B  #$002B,(A1)+
        BCHG    D0,$0055(A2)                    ; $11D7C6
        BTST    D0,$31(A0,D0.W)                 ; $11D7CA
        ORI.W  #$0034,(A0)+                     ; $11D7CE
        ADDI.W  #$0050,(A7)                     ; $11D7D2
        ORI.W  #$04B9,$0050(A6)                 ; $11D7D6
        ORI.L  #$004D02B9,D2                    ; $11D7DC
        ORI.W  #$003E,A5                        ; $11D7E2
        DC.W    $0019,$0051         ; $11D7E6 ORI.B  #$0051,(A1)+
        ORI.L  #$01B901BA,(A1)                  ; $11D7EA
        ORI.W  #$002B,A2                        ; $11D7F0
        ORI.L  #$02BE00BB,(A3)                  ; $11D7F4
        ORI.W  #$005C,-(A1)                     ; $11D7FA
        BCLR    D0,D6                           ; $11D7FE
        ANDI.W  #$0246,-(A2)                    ; $11D800
        DC.W    $02AB,$003B,$0023,$0143; $11D804 ANDI.L  #$003B0023,$0143(A3)
        ORI.W  #$0119,A0                        ; $11D80C
        ORI.W  #$0094,D3                        ; $11D810
        BCLR    D1,-(A3)                        ; $11D814
        DC.W    $0079,$0027,$006F,$04BB; $11D816 ORI.W  #$0027,$006F04BB
        ORI.W  #$0064,-(A0)                     ; $11D81E
        BCHG    D0,(A1)                         ; $11D822
        DC.W    $0028,$0049,$03BE   ; $11D824 ORI.B  #$0049,$03BE(A0)
        DC.W    $00BA,$0038,$0028,$0075; $11D82A ORI.L  #$00380028,$0075(PC)
        DC.W    $04B9,$004D,$003E,$0119,$0082; $11D832 SUBI.L  #$004D003E,$01190082
        ORI.W  #$04B9,A5                        ; $11D83C
        ORI.W  #$002B,-$6F(A0,D0.W)             ; $11D840
        DC.W    $00BA,$02BE,$0061,$0028; $11D846 ORI.L  #$02BE0061,$0028(PC)
        DC.W    $0019,$013D         ; $11D84E ORI.B  #$013D,(A1)+
        DC.W    $003F,$006F         ; $11D852 ORI.B  #$006F,<EA:3F>
        ANDI.L  #$00BC0095,-(A3)                ; $11D856
        ORI.W  #$00D0,D4                        ; $11D85C
        DC.W    $00CC               ; $11D860 DC.W    $00CC
        DC.W    $01CB               ; $11D862 BSET    D0,A3
        BSET    D0,(A3)                         ; $11D864
        DC.W    $00C4               ; $11D866 DC.W    $00C4
        DC.W    $00D6               ; $11D868 DC.W    $00D6
        DC.W    $0019,$0012         ; $11D86A ORI.B  #$0012,(A1)+
        DC.W    $0001,$5400         ; $11D86E ORI.B  #$5400,D1
        ORI.W  #$5600,A0                        ; $11D872
        DC.W    $0001,$0011         ; $11D876 ORI.B  #$0011,D1
        DC.W    $0219,$006E         ; $11D87A ANDI.B  #$006E,(A1)+
        DC.W    $17B9,$004D,$0083,$0063; $11D87E MOVE.B  $004D0083,$63(A3,D0.W)
        ORI.W  #$02B9,A5                        ; $11D886
        ORI.W  #$003E,A5                        ; $11D88A
        DC.W    $0019,$0051         ; $11D88E ORI.B  #$0051,(A1)+
        ORI.L  #$01B901BA,(A1)                  ; $11D892
        ORI.W  #$002B,A2                        ; $11D898
        ORI.L  #$02BE0CBB,(A3)                  ; $11D89C
        ANDI.L  #$00950094,-(A3)                ; $11D8A2
        ORI.W  #$003D,$0019(A7)                 ; $11D8A8
        ORI.W  #$0094,D3                        ; $11D8AE
        BCLR    D1,-(A3)                        ; $11D8B2
        DC.W    $0079,$0027,$006F,$05BB; $11D8B4 ORI.W  #$0027,$006F05BB
        BCHG    D1,(A3)                         ; $11D8BC
        DC.W    $00BA,$03BE,$00BA,$0038; $11D8BE ORI.L  #$03BE00BA,$0038(PC)
        DC.W    $0028,$0075,$04B9   ; $11D8C6 ORI.B  #$0075,$04B9(A0)
        ORI.W  #$0069,A5                        ; $11D8CC
        BTST    D0,(A1)+                        ; $11D8D0
        ORI.W  #$04B9,(A0)                      ; $11D8D2
        ORI.W  #$0020,-(A7)                     ; $11D8D6
        ORI.W  #$009E,-(A5)                     ; $11D8DA
        DC.W    $00BA,$03BE,$0053,$006F; $11D8DE ORI.L  #$03BE0053,$006F(PC)
        BCHG    D0,(A3)                         ; $11D8E6
        ORI.W  #$03A3,-(A1)                     ; $11D8E8
        DC.W    $00BC,$00A3,$003A,$009F,$00B3; $11D8EC ORI.L  #$00A3003A,#$009F00B3
        DC.W    $01CB               ; $11D8F6 BSET    D0,A3
        BSET    D0,(A3)                         ; $11D8F8
        DC.W    $00D2               ; $11D8FA DC.W    $00D2
        DC.W    $00CF               ; $11D8FC DC.W    $00CF
        DC.W    $0019,$0015         ; $11D8FE ORI.B  #$0015,(A1)+
        DC.W    $0002,$5400         ; $11D902 ORI.B  #$5400,D2
        ORI.W  #$5600,D0                        ; $11D906
        DC.W    $0001,$0010         ; $11D90A ORI.B  #$0010,D1
        DC.W    $0219,$004B         ; $11D90E ANDI.B  #$004B,(A1)+
        DC.W    $17B9,$0034,$0020,$0066; $11D912 MOVE.B  $00340020,$66(A3,D0.W)
        BCLR    D1,$004D003E                    ; $11D91A
        DC.W    $0019,$0051         ; $11D920 ORI.B  #$0051,(A1)+
        ORI.L  #$01B901BA,(A1)                  ; $11D924
        ORI.W  #$002B,A2                        ; $11D92A
        ORI.L  #$01BE08BB,(A3)                  ; $11D92E
        BCLR    D4,-(A3)                        ; $11D934
        DC.W    $0079,$003D,$0019,$0043; $11D936 ORI.W  #$003D,$00190043
        ORI.L  #$03A30079,(A4)                  ; $11D93E
        DC.W    $0027,$006F         ; $11D944 ORI.B  #$006F,-(A7)
        BCLR    D3,-$42(PC,D0.W)                ; $11D948
        DC.W    $00BA,$0038,$0028,$0075; $11D94C ORI.L  #$00380028,$0075(PC)
        DC.W    $04B9,$004D,$0069,$0019,$0082; $11D954 SUBI.L  #$004D0069,$00190082
        ORI.W  #$04B9,A5                        ; $11D95E
        ORI.W  #$0063,$004B(A5)                 ; $11D962
        BCLR    D0,$03BE(PC)                    ; $11D968
        DC.W    $04BB,$02A3,$01BC,$00CB; $11D96C SUBI.L  #$02A301BC,-$35(PC,D0.W)
        DC.W    $0079,$009F,$00D2,$01CB; $11D974 ORI.W  #$009F,$00D201CB
        BSET    D0,(A3)                         ; $11D97C
        DC.W    $00D5               ; $11D97E DC.W    $00D5
        DC.W    $00C9               ; $11D980 DC.W    $00C9
        ORI.L  #$001F0006,D7                    ; $11D982
        ADDQ.B  #2,D0                           ; $11D988
        ORI.W  #$5600,D3                        ; $11D98A
        DC.W    $0001,$0010         ; $11D98E ORI.B  #$0010,D1
        DC.W    $0219,$004B         ; $11D992 ANDI.B  #$004B,(A1)+
        MOVE.B  $004C008A,(A3)                  ; $11D996
        DC.W    $002B,$0090,$03B9   ; $11D99C ORI.B  #$0090,$03B9(A3)
        ORI.W  #$0020,A4                        ; $11D9A2
        DC.W    $0019,$0051         ; $11D9A6 ORI.B  #$0051,(A1)+
        ORI.L  #$01B901BA,(A1)                  ; $11D9AA
        ORI.W  #$0065,A2                        ; $11D9B0
        ORI.L  #$01BE08BB,(A3)                  ; $11D9B4
        BCLR    D4,-(A3)                        ; $11D9BA
        DC.W    $0079,$003D,$0019,$0043; $11D9BC ORI.W  #$003D,$00190043
        ORI.L  #$02A300BB,(A4)                  ; $11D9C4
        DC.W    $0079,$0027,$006F,$07BB; $11D9CA ORI.W  #$0027,$006F07BB
        DC.W    $06BE,$00BA,$0038   ; $11D9D2 ADDI.L  #$00BA0038,<EA:3E>
        DC.W    $0028,$0075,$04B9   ; $11D9D8 ORI.B  #$0075,$04B9(A0)
        ORI.W  #$0069,A5                        ; $11D9DE
        DC.W    $0019,$0050         ; $11D9E2 ORI.B  #$0050,(A1)+
        DC.W    $04B9,$0091,$008D,$0064,$0038; $11D9E6 SUBI.L  #$0091008D,$00640038
        BCLR    D0,$03BE(PC)                    ; $11D9F0
        DC.W    $04BB,$02A3,$01BC,$00CB; $11D9F4 SUBI.L  #$02A301BC,-$35(PC,D0.W)
        DC.W    $00B3,$009F,$0045,$00CC; $11D9FC ORI.L  #$009F0045,-$34(A3,D0.W)
        DC.W    $00CB               ; $11DA04 DC.W    $00CB
        BSET    D0,(A3)                         ; $11DA06
        DC.W    $00D7               ; $11DA08 DC.W    $00D7
        DC.W    $00D8               ; $11DA0A DC.W    $00D8
        ORI.L  #$001E000D,D7                    ; $11DA0C
        ADDQ.B  #2,D0                           ; $11DA12
        ORI.W  #$5600,D6                        ; $11DA14
        DC.W    $0001,$0010         ; $11DA18 ORI.B  #$0010,D1
        DC.W    $0219,$0067         ; $11DA1C ANDI.B  #$0067,(A1)+
        DC.W    $15B9,$0088,$0099,$0020; $11DA20 MOVE.B  $00880099,$20(A2,D0.W)
        ORI.W  #$04B9,(A0)                      ; $11DA28
        ORI.W  #$0119,(A5)                      ; $11DA2C
        ORI.W  #$0091,(A1)                      ; $11DA30
        BCLR    D0,$01BA0049                    ; $11DA34
        DC.W    $0036,$0038,$01BE   ; $11DA3A ORI.B  #$0038,-$42(A6,D0.W)
        BCLR    #3,$79(PC,D0.W)                 ; $11DA40
        DC.W    $003D,$0019         ; $11DA46 ORI.B  #$0019,<EA:3D>
        ORI.W  #$0094,D3                        ; $11DA4A
        ANDI.L  #$00BB0079,-(A3)                ; $11DA4E
        DC.W    $0027,$006F         ; $11DA54 ORI.B  #$006F,-(A7)
        BCLR    D3,-$42(PC,D0.W)                ; $11DA58
        DC.W    $00BA,$0038,$0028,$0075; $11DA5C ORI.L  #$00380028,$0075(PC)
        DC.W    $04B9,$004D,$0069,$0035,$004C; $11DA64 SUBI.L  #$004D0069,$0035004C
        DC.W    $04B9,$0067,$0020,$0099,$009E; $11DA6E SUBI.L  #$00670020,$0099009E
        BCLR    D0,$01BE(PC)                    ; $11DA78
        ORI.W  #$0049,A2                        ; $11DA7C
        DC.W    $00BE,$03BB,$02A3   ; $11DA80 ORI.L  #$03BB02A3,<EA:3E>
        BCLR    D0,#$00CB                       ; $11DA86
        DC.W    $00CC               ; $11DA8A DC.W    $00CC
        DC.W    $00D0               ; $11DA8C DC.W    $00D0
        DC.W    $00D9               ; $11DA8E DC.W    $00D9
        DC.W    $00B3,$00CB,$01D3,$00D7; $11DA90 ORI.L  #$00CB01D3,-$29(A3,D0.W)
        DC.W    $00DA               ; $11DA98 DC.W    $00DA
        DC.W    $00D6               ; $11DA9A DC.W    $00D6
        DC.W    $0019,$001D         ; $11DA9C ORI.B  #$001D,(A1)+
        DC.W    $0009,$5300         ; $11DAA0 ORI.B  #$5300,A1
        ORI.W  #$5600,A0                        ; $11DAA4
        DC.W    $0001,$000F         ; $11DAA8 ORI.B  #$000F,D1
        DC.W    $0219,$0067         ; $11DAAC ANDI.B  #$0067,(A1)+
        MOVE.B  $004D006E,(A1)                  ; $11DAB0
        ORI.W  #$0035,(A6)                      ; $11DAB6
        DC.W    $0020,$0099         ; $11DABA ORI.B  #$0099,-(A0)
        ORI.L  #$03B9004D,(A0)                  ; $11DABE
        ORI.W  #$0119,-(A4)                     ; $11DAC4
        ORI.W  #$004C,$01B9(A1)                 ; $11DAC8
        BCLR    D0,$0049(PC)                    ; $11DACE
        ORI.L  #$003101BE,D3                    ; $11DAD2
        BCLR    #3,$79(PC,D0.W)                 ; $11DAD8
        DC.W    $003D,$0019         ; $11DADE ORI.B  #$0019,<EA:3D>
        ORI.W  #$0079,A0                        ; $11DAE2
        ANDI.L  #$00BB0079,-(A3)                ; $11DAE6
        DC.W    $0027,$005C         ; $11DAEC ORI.B  #$005C,-(A7)
        BCLR    D3,-$42(PC,D0.W)                ; $11DAF0
        DC.W    $00BA,$0038,$0028,$0075; $11DAF4 ORI.L  #$00380028,$0075(PC)
        DC.W    $04B9,$004D,$0069,$0065,$0090; $11DAFC SUBI.L  #$004D0069,$00650090
        BCLR    D1,$0090002B                    ; $11DB06
        ORI.L  #$004B00B9,D3                    ; $11DB0C
        BCLR    D0,$00BE(PC)                    ; $11DB12
        ORI.L  #$016800BE,(A3)                  ; $11DB16
        BCLR    D1,-$44(PC,D0.W)                ; $11DB1C
        DC.W    $01CB               ; $11DB20 BSET    D0,A3
        DC.W    $00D2               ; $11DB22 DC.W    $00D2
        ORI.L  #$00DB00DC,(A7)+                 ; $11DB24
        DC.W    $02DD               ; $11DB2A DC.W    $02DD
        DC.W    $00D4               ; $11DB2C DC.W    $00D4
        DC.W    $00DE               ; $11DB2E DC.W    $00DE
        DC.W    $0019,$001A         ; $11DB30 ORI.B  #$001A,(A1)+
        DC.W    $000A,$5300         ; $11DB34 ORI.B  #$5300,A2
        ORI.W  #$5600,(A3)                      ; $11DB38
        DC.W    $0001,$000F         ; $11DB3C ORI.B  #$000F,D1
        DC.W    $0219,$00AA         ; $11DB40 ANDI.B  #$00AA,(A1)+
        DC.W    $034C               ; $11DB44 BCHG    D1,A4
        DC.W    $014B               ; $11DB46 BCHG    D0,A3
        ANDI.W  #$016D,-(A7)                    ; $11DB48
        ORI.W  #$0250,$57(A6,D0.W)              ; $11DB4C
        DC.W    $0034,$008B,$0082   ; $11DB52 ORI.B  #$008B,-$7E(A4,D0.W)
        ORI.L  #$0036006E,A2                    ; $11DB58
        DC.W    $00B8,$04DF,$0034,$0219; $11DB5E ORI.L  #$04DF0034,$0219.W
        DC.W    $003D,$0067         ; $11DB66 ORI.B  #$0067,<EA:3D>
        BSET    D0,(A7)+                        ; $11DB6A
        DC.W    $02E0               ; $11DB6C DC.W    $02E0
        DC.W    $0031,$0069,$0032   ; $11DB6E ORI.B  #$0069,$32(A1,D0.W)
        ORI.W  #$0052,(A4)                      ; $11DB74
        ORI.W  #$005E,(A5)+                     ; $11DB78
        ORI.W  #$0078,(A7)+                     ; $11DB7C
        BCHG    D1,$0979(A7)                    ; $11DB80
        ORI.W  #$003D,$0019.W                   ; $11DB84
        DC.W    $003F,$005D         ; $11DB8A ORI.B  #$005D,<EA:3F>
        DC.W    $02BC,$00E1,$0094,$002C,$0081; $11DB8E ANDI.L  #$00E10094,#$002C0081
        ORI.W  #$00BB,(A4)+                     ; $11DB98
        BSET    D2,-(A1)                        ; $11DB9C
        BSET    D3,-(A0)                        ; $11DB9E
        ORI.L  #$00280075,(A1)                  ; $11DBA0
        DC.W    $04DF               ; $11DBA6 DC.W    $04DF
        ORI.W  #$008B,A5                        ; $11DBA8
        ORI.W  #$04DF,(A0)                      ; $11DBAC
        ORI.W  #$0069,A5                        ; $11DBB0
        ORI.W  #$00B9,(A5)                      ; $11DBB4
        DC.W    $00DF               ; $11DBB8 DC.W    $00DF
        DC.W    $02E0               ; $11DBBA DC.W    $02E0
        ORI.W  #$0081,A2                        ; $11DBBC
        DC.W    $002F,$00BE,$03E1   ; $11DBC0 ORI.B  #$00BE,$03E1(A7)
        DC.W    $04E2               ; $11DBC6 DC.W    $04E2
        DC.W    $00E3               ; $11DBC8 DC.W    $00E3
        DC.W    $01CB               ; $11DBCA BSET    D0,A3
        ORI.W  #$003A,D6                        ; $11DBCC
        DC.W    $00CB               ; $11DBD0 DC.W    $00CB
        DC.W    $02DD               ; $11DBD2 DC.W    $02DD
        DC.W    $00D7               ; $11DBD4 DC.W    $00D7
        DC.W    $00E4               ; $11DBD6 DC.W    $00E4
        DC.W    $003D,$0018         ; $11DBD8 ORI.B  #$0018,<EA:3D>
        DC.W    $000C,$0008         ; $11DBDC ORI.B  #$0008,A4
        ADDQ.B  #1,D0                           ; $11DBE0
        ORI.W  #$5600,(A5)+                     ; $11DBE2
        DC.W    $0001,$000E         ; $11DBE6 ORI.B  #$000E,D1
        DC.W    $0219,$0083         ; $11DBEA ANDI.B  #$0083,(A1)+
        ORI.L  #$01630164,D2                    ; $11DBEE
        DC.W    $018A               ; $11DBF4 BCLR    D0,A2
        DC.W    $018B               ; $11DBF6 BCLR    D0,A3
        ORI.L  #$0036022B,A4                    ; $11DBF8
        BCHG    D0,-(A5)                        ; $11DBFE
        ANDI.L  #$00990050,(A2)+                ; $11DC00
        BCLR    D0,(A0)                         ; $11DC06
        BSET    D2,(A7)+                        ; $11DC08
        ORI.L  #$00B60319,A0                    ; $11DC0A
        ORI.W  #$01DF,(A5)                      ; $11DC10
        DC.W    $02E0               ; $11DC14 DC.W    $02E0
        DC.W    $00B9,$0032,$018D,$009A,$0065; $11DC16 ORI.L  #$0032018D,$009A0065
        DC.W    $002D,$012B,$0136   ; $11DC20 ORI.B  #$012B,$0136(A5)
        DC.W    $0029,$008B,$0128   ; $11DC26 ORI.B  #$008B,$0128(A1)
        ORI.W  #$0051,-(A4)                     ; $11DC2C
        ORI.W  #$0164,-(A3)                     ; $11DC30
        DC.W    $0028,$0029,$003C   ; $11DC34 ORI.B  #$0029,$003C(A0)
        DC.W    $0029,$0219,$0086   ; $11DC3A ORI.B  #$0219,$0086(A1)
        DC.W    $00BC,$01E2,$01E1,$006F,$002C; $11DC40 ORI.L  #$01E201E1,#$006F002C
        ORI.W  #$0032,-(A4)                     ; $11DC4A
        ORI.W  #$005C,(A2)+                     ; $11DC4E
        BCLR    D0,D5                           ; $11DC52
        BCHG    D0,(A2)                         ; $11DC54
        DC.W    $014A               ; $11DC56 BCHG    D0,A2
        DC.W    $014B               ; $11DC58 BCHG    D0,A3
        DC.W    $014C               ; $11DC5A BCHG    D0,A4
        DC.W    $0038,$004D,$0067   ; $11DC5C ORI.B  #$004D,$0067.W
        ORI.L  #$008F04DF,A2                    ; $11DC62
        ORI.L  #$00890088,(A0)                  ; $11DC68
        DC.W    $04DF               ; $11DC6E DC.W    $04DF
        ORI.L  #$008200A0,-(A2)                 ; $11DC70
        BSET    D0,(A7)+                        ; $11DC76
        DC.W    $02E0               ; $11DC78 DC.W    $02E0
        ORI.W  #$003D,$0065(A5)                 ; $11DC7A
        ORI.L  #$0453016F,(A2)                  ; $11DC80
        BCHG    D1,$00C4.W                      ; $11DC86
        ORI.W  #$009F,D4                        ; $11DC8A
        ORI.L  #$02DD00E5,(A5)                  ; $11DC8E
        DC.W    $00D0               ; $11DC94 DC.W    $00D0
        DC.W    $00CF               ; $11DC96 DC.W    $00CF
        DC.W    $0019,$0015         ; $11DC98 ORI.B  #$0015,(A1)+
        DC.W    $0001,$5200         ; $11DC9C ORI.B  #$5200,D1
        ORI.W  #$5600,A4                        ; $11DCA0
        DC.W    $0001,$000E         ; $11DCA4 ORI.B  #$000E,D1
        DC.W    $0219,$0057         ; $11DCA8 ANDI.B  #$0057,(A1)+
        BCLR    D1,(A0)                         ; $11DCAC
        DC.W    $04B8,$03B9,$06B8,$07DF; $11DCAE SUBI.L  #$03B906B8,$07DF.W
        ORI.L  #$00B60419,A0                    ; $11DCB6
        ORI.L  #$004D05E0,D3                    ; $11DCBC
        BCLR    D2,$03BB(PC)                    ; $11DCC2
        BCLR    #25,(A4)                        ; $11DCC6
        ORI.W  #$0035,(A5)+                     ; $11DCCA
        BTST    D0,(A1)+                        ; $11DCCE
        DC.W    $00E6               ; $11DCD0 DC.W    $00E6
        DC.W    $00E1               ; $11DCD2 DC.W    $00E1
        DC.W    $00E2               ; $11DCD4 DC.W    $00E2
        DC.W    $00E7               ; $11DCD6 DC.W    $00E7
        DC.W    $02E1               ; $11DCD8 DC.W    $02E1
        ORI.W  #$00E6,(A3)                      ; $11DCDA
        ORI.W  #$00E8,$012F(A0)                 ; $11DCDE
        DC.W    $00A8,$0065,$012B,$0036; $11DCE4 ORI.L  #$0065012B,$0036(A0)
        ORI.L  #$00AD008A,A3                    ; $11DCEC
        BCLR    D0,$63(A6,D0.W)                 ; $11DCF2
        BCLR    D0,D2                           ; $11DCF6
        ORI.W  #$05DF,-(A7)                     ; $11DCF8
        ORI.W  #$00E9,A5                        ; $11DCFC
        BSET    D1,(A7)+                        ; $11DD00
        ORI.L  #$00AD0083,(A0)                  ; $11DD02
        ORI.W  #$01DF,A5                        ; $11DD08
        DC.W    $02E0               ; $11DD0C DC.W    $02E0
        DC.W    $0034,$0019,$0035   ; $11DD0E ORI.B  #$0019,$35(A4,D0.W)
        BCHG    D0,-(A3)                        ; $11DD14
        ORI.W  #$0128,-(A4)                     ; $11DD16
        DC.W    $0029,$00EA,$002C   ; $11DD1A ORI.B  #$00EA,$002C(A1)
        ORI.W  #$00A4,D2                        ; $11DD20
        ORI.W  #$0022,D4                        ; $11DD24
        BCLR    D0,-$15(A0,D0.W)                ; $11DD28
        DC.W    $00CC               ; $11DD2C DC.W    $00CC
        BSET    D1,(A5)+                        ; $11DD2E
        DC.W    $00EC               ; $11DD30 DC.W    $00EC
        DC.W    $00B1,$0019,$0017,$0009; $11DD32 ORI.L  #$00190017,$09(A1,D0.W)
        ADDQ.B  #1,D0                           ; $11DD3A
        DC.W    $0036,$5600,$0001   ; $11DD3C ORI.B  #$5600,$01(A6,D0.W)
        DC.W    $000D,$0219         ; $11DD42 ORI.B  #$0219,A5
        ORI.W  #$1ADF,$0088(A5)                 ; $11DD46
        ORI.L  #$0219000F,A2                    ; $11DD4C
        DC.W    $001A,$0119         ; $11DD52 ORI.B  #$0119,(A2)+
        ORI.W  #$0091,(A7)                      ; $11DD56
        DC.W    $06ED               ; $11DD5A DC.W    $06ED
        BSET    #2,$0094(A6)                    ; $11DD5C
        DC.W    $0035,$0119,$003E   ; $11DD62 ORI.B  #$0119,$3E(A5,D0.W)
        ORI.W  #$00E2,$00E7.W                   ; $11DD68
        DC.W    $04E1               ; $11DD6E DC.W    $04E1
        BCLR    D0,-$46(PC,D0.W)                ; $11DD70
        ORI.L  #$019E0491,(A3)                  ; $11DD74
        ORI.L  #$0CDF0090,(A0)                  ; $11DD7A
        ORI.L  #$00AA02DF,A2                    ; $11DD80
        BSET    D0,-(A0)                        ; $11DD86
        DC.W    $0038,$0020,$0019   ; $11DD88 ORI.B  #$0020,$0019.W
        ORI.L  #$00380293,A5                    ; $11DD8E
        ANDI.L  #$00BB03A3,(A4)                 ; $11DD94
        DC.W    $02CC               ; $11DD9A DC.W    $02CC
        DC.W    $00DC               ; $11DD9C DC.W    $00DC
        BSET    D1,$00D5(A7)                    ; $11DD9E
        DC.W    $00DE               ; $11DDA2 DC.W    $00DE
        DC.W    $003D,$001E         ; $11DDA4 ORI.B  #$001E,<EA:3D>
        DC.W    $001B,$5200         ; $11DDA8 ORI.B  #$5200,(A3)+
        DC.W    $0030,$5600,$0001   ; $11DDAC ORI.B  #$5600,$01(A0,D0.W)
        DC.W    $000C,$0219         ; $11DDB2 ORI.B  #$0219,A4
        ORI.L  #$19F00071,A7                    ; $11DDB6
        ORI.L  #$02190012,A3                    ; $11DDBC
        DC.W    $0001,$0003         ; $11DDC2 ORI.B  #$0003,D1
        BTST    D0,(A1)+                        ; $11DDC6
        DC.W    $0035,$0050,$00F0   ; $11DDC8 ORI.B  #$0050,-$10(A5,D0.W)
        BSET    D2,$06EE(A5)                    ; $11DDCE
        DC.W    $00F1               ; $11DDD2 DC.W    $00F1
        DC.W    $0AF2               ; $11DDD4 DC.W    $0AF2
        ORI.L  #$00350219,(A4)                  ; $11DDD6
        DC.W    $0037,$00EE,$00F2   ; $11DDDC ORI.B  #$00EE,-$0E(A7,D0.W)
        DC.W    $00F1               ; $11DDE2 DC.W    $00F1
        BSET    D4,$08ED(A6)                    ; $11DDE4
        BSET    D0,-$10(A3,D0.L)                ; $11DDE8
        ORI.W  #$0051,-(A6)                     ; $11DDEC
        ORI.W  #$01F0,-(A7)                     ; $11DDF0
        DC.W    $00F3               ; $11DDF4 DC.W    $00F3
        BSET    D0,$004C(A5)                    ; $11DDF6
        BTST    D0,(A1)+                        ; $11DDFA
        DC.W    $0021,$03EE         ; $11DDFC ORI.B  #$03EE,-(A1)
        BSET    D2,-$24(A2,D0.W)                ; $11DE00
        DC.W    $04EF               ; $11DE04 DC.W    $04EF
        DC.W    $00DA               ; $11DE06 DC.W    $00DA
        DC.W    $00D6               ; $11DE08 DC.W    $00D6
        DC.W    $001E,$000D         ; $11DE0A ORI.B  #$000D,(A6)+
        ADDQ.B  #1,D0                           ; $11DE0E
        DC.W    $0035,$5700,$000C   ; $11DE10 ORI.B  #$5700,$0C(A5,D0.W)
        DC.W    $0219,$00C8         ; $11DE16 ANDI.B  #$00C8,(A1)+
        MOVE.B  -$41(A0,D0.W),$71(PC,D0.W)      ; $11DE1A
        ORI.L  #$02190018,A3                    ; $11DE20
        DC.W    $0003,$0000         ; $11DE26 ORI.B  #$0000,D3
        DC.W    $0009,$0016         ; $11DE2A ORI.B  #$0016,A1
        BTST    D0,(A1)+                        ; $11DE2E
        ORI.L  #$005000B9,D3                    ; $11DE30
        DC.W    $04ED               ; $11DE36 DC.W    $04ED
        DC.W    $06EE               ; $11DE38 DC.W    $06EE
        DC.W    $00F1               ; $11DE3A DC.W    $00F1
        DC.W    $0AF2               ; $11DE3C DC.W    $0AF2
        ORI.L  #$00350219,(A4)                  ; $11DE3E
        DC.W    $0024,$0037         ; $11DE44 ORI.B  #$0037,-(A4)
        DC.W    $00C3               ; $11DE48 DC.W    $00C3
        BSET    D0,-$12(A1,D0.L)                ; $11DE4A
        BSET    #19,$0BF0(A5)                   ; $11DE4E
        DC.W    $00BF,$0065,$0064   ; $11DE54 ORI.L  #$00650064,<EA:3F>
        ORI.W  #$01F0,A4                        ; $11DE5A
        DC.W    $00F3               ; $11DE5E DC.W    $00F3
        DC.W    $00ED               ; $11DE60 DC.W    $00ED
        DC.W    $00C0               ; $11DE62 DC.W    $00C0
        DC.W    $00F4               ; $11DE64 DC.W    $00F4
        BTST    D0,(A1)+                        ; $11DE66
        DC.W    $0021,$03EE         ; $11DE68 ORI.B  #$03EE,-(A1)
        BSET    D2,-$24(A2,D0.W)                ; $11DE6C
        DC.W    $04EF               ; $11DE70 DC.W    $04EF
        DC.W    $00F5               ; $11DE72 DC.W    $00F5
        DC.W    $00D6               ; $11DE74 DC.W    $00D6
        DC.W    $001E,$0012         ; $11DE76 ORI.B  #$0012,(A6)+
        DC.W    $0001,$5100         ; $11DE7A ORI.B  #$5100,D1
        DC.W    $0037,$5700,$001B   ; $11DE7E ORI.B  #$5700,$1B(A7,D0.W)
        DC.W    $0219,$0050         ; $11DE84 ANDI.B  #$0050,(A1)+
        DC.W    $13F0,$00BF,$0090,$004D; $11DE88 MOVE.B  -$41(A0,D0.W),$0090004D
        ORI.L  #$00810083,(A7)                  ; $11DE90
        BTST    D1,(A1)+                        ; $11DE96
        DC.W    $0005,$0001         ; $11DE98 ORI.B  #$0001,D5
        BTST    D0,D0                           ; $11DE9C
        DC.W    $001C,$0017         ; $11DE9E ORI.B  #$0017,(A4)+
        BTST    D0,(A1)+                        ; $11DEA2
        DC.W    $0020,$002A         ; $11DEA4 ORI.B  #$002A,-(A0)
        ORI.W  #$009E,A4                        ; $11DEA8
        DC.W    $02ED               ; $11DEAC DC.W    $02ED
        DC.W    $06EE               ; $11DEAE DC.W    $06EE
        DC.W    $00F1               ; $11DEB0 DC.W    $00F1
        DC.W    $0AF2               ; $11DEB2 DC.W    $0AF2
        ORI.L  #$00350319,(A4)                  ; $11DEB4
        DC.W    $003E,$005A         ; $11DEBA ORI.B  #$005A,<EA:3E>
        DC.W    $00BB,$09EE,$08ED,$01F3; $11DEBE ORI.L  #$09EE08ED,-$0D(PC,D0.W)
        BSET    D5,-$70(A0,D0.W)                ; $11DEC6
        DC.W    $002B,$0034,$01F0   ; $11DECA ORI.B  #$0034,$01F0(A3)
        BSET    D0,-$13(A3,D0.W)                ; $11DED0
        ORI.L  #$00200119,(A6)+                 ; $11DED4
        DC.W    $0021,$03EE         ; $11DEDA ORI.B  #$03EE,-(A1)
        DC.W    $04F2               ; $11DEDE DC.W    $04F2
        DC.W    $06DC               ; $11DEE0 DC.W    $06DC
        DC.W    $04EF               ; $11DEE2 DC.W    $04EF
        DC.W    $00D2               ; $11DEE4 DC.W    $00D2
        DC.W    $00DE               ; $11DEE6 DC.W    $00DE
        DC.W    $001E,$001F         ; $11DEE8 ORI.B  #$001F,(A6)+
        DC.W    $0009,$5100         ; $11DEEC ORI.B  #$5100,A1
        DC.W    $003F,$5700         ; $11DEF0 ORI.B  #$5700,<EA:3F>
        DC.W    $0004,$0219         ; $11DEF4 ORI.B  #$0219,D4
        DC.W    $00F6               ; $11DEF8 DC.W    $00F6
        DC.W    $00CA               ; $11DEFA DC.W    $00CA
        DC.W    $00B9,$009E,$06CA,$0190,$064D; $11DEFC ORI.L  #$009E06CA,$0190064D
        ORI.W  #$0036,$0619(A6)                 ; $11DF06
        DC.W    $000E,$000A         ; $11DF0C ORI.B  #$000A,A6
        SUBI.B  #$001C,D0                       ; $11DF10
        DC.W    $001A,$0219         ; $11DF14 ORI.B  #$0219,(A2)+
        DC.W    $0035,$003F,$00F7   ; $11DF18 ORI.B  #$003F,-$09(A5,D0.W)
        ORI.L  #$019302C2,(A6)+                 ; $11DF1E
        DC.W    $00BE,$02BB,$02C3   ; $11DF24 ORI.L  #$02BB02C3,<EA:3E>
        BSET    D0,$01BC(A6)                    ; $11DF2A
        BSET    D0,$01F2.W                      ; $11DF2E
        ORI.L  #$00350419,(A4)                  ; $11DF32
        DC.W    $003E,$0023         ; $11DF38 ORI.B  #$0023,<EA:3E>
        ORI.W  #$00BB,(A7)+                     ; $11DF3C
        DC.W    $00C3               ; $11DF40 DC.W    $00C3
        DC.W    $06EE               ; $11DF42 DC.W    $06EE
        BSET    #19,$0BF0(A5)                   ; $11DF44
        ORI.L  #$00630050,A1                    ; $11DF4A
        BSET    D0,-$0D(A0,D0.W)                ; $11DF50
        BSET    D0,$004B(A5)                    ; $11DF54
        DC.W    $0219,$0021         ; $11DF58 ANDI.B  #$0021,(A1)+
        DC.W    $02EE               ; $11DF5C DC.W    $02EE
        DC.W    $00F1               ; $11DF5E DC.W    $00F1
        DC.W    $04F2               ; $11DF60 DC.W    $04F2
        BSET    D2,(A4)+                        ; $11DF62
        BSET    D2,$00D7(A7)                    ; $11DF64
        DC.W    $00E4               ; $11DF68 DC.W    $00E4
        DC.W    $001E,$001A         ; $11DF6A ORI.B  #$001A,(A6)+
        DC.W    $001C,$5100         ; $11DF6E ORI.B  #$5100,(A4)+
        ORI.W  #$5700,A3                        ; $11DF72
        DC.W    $0004,$0219         ; $11DF76 ORI.B  #$0219,D4
        ORI.L  #$00630081,D3                    ; $11DF7A
        ORI.W  #$0183,$0020(A1)                 ; $11DF80
        DC.W    $0035,$003D,$1119   ; $11DF86 ORI.B  #$003D,$19(A5,D1.W)
        DC.W    $001D,$000E         ; $11DF8C ORI.B  #$000E,(A5)+
        DC.W    $0002,$0600         ; $11DF90 ORI.B  #$0600,D2
        DC.W    $0007,$0017         ; $11DF94 ORI.B  #$0017,D7
        BTST    D2,(A1)+                        ; $11DF98
        DC.W    $003D,$0035         ; $11DF9A ORI.B  #$0035,<EA:3D>
        DC.W    $0020,$003E         ; $11DF9E ORI.B  #$003E,-(A0)
        DC.W    $003F,$0025         ; $11DFA2 ORI.B  #$0025,<EA:3F>
        ORI.W  #$0028,(A1)                      ; $11DFA6
        DC.W    $0029,$0048,$002C   ; $11DFAA ORI.B  #$0048,$002C(A1)
        DC.W    $0023,$0073         ; $11DFB0 ORI.B  #$0073,-(A3)
        DC.W    $003B,$00F9,$0062   ; $11DFB4 ORI.B  #$00F9,$62(PC,D0.W)
        DC.W    $00FA               ; $11DFBA DC.W    $00FA
        DC.W    $007E,$005D         ; $11DFBC ORI.W  #$005D,<EA:3E>
        ORI.W  #$0054,$0035.W                   ; $11DFC0
        ADDI.B  #$0051,(A1)+                    ; $11DFC6
        DC.W    $002C,$0072,$0061   ; $11DFCA ORI.B  #$0072,$0061(A4)
        BCLR    D0,-$42(PC,D0.W)                ; $11DFD0
        DC.W    $00E0               ; $11DFD4 DC.W    $00E0
        BSET    D4,$01F3(A5)                    ; $11DFD6
        DC.W    $0AF0               ; $11DFDA DC.W    $0AF0
        DC.W    $00BF,$00F4,$0036   ; $11DFDC ORI.L  #$00F40036,<EA:3F>
        ORI.W  #$01F0,-$0D(A1,D0.W)             ; $11DFE2
        DC.W    $00ED               ; $11DFE8 DC.W    $00ED
        DC.W    $00C0               ; $11DFEA DC.W    $00C0
        DC.W    $002B,$0219,$0068   ; $11DFEC ORI.B  #$0219,$0068(A3)
        DC.W    $02EE               ; $11DFF2 DC.W    $02EE
        DC.W    $00F1               ; $11DFF4 DC.W    $00F1
        DC.W    $00F2               ; $11DFF6 DC.W    $00F2
        BSET    D2,$01CB.W                      ; $11DFF8
        DC.W    $06CC               ; $11DFFC DC.W    $06CC
        DC.W    $00D5               ; $11DFFE DC.W    $00D5
        DC.W    $00D4               ; $11E000 DC.W    $00D4
        DC.W    $00E4               ; $11E002 DC.W    $00E4
        BTST    D0,(A6)+                        ; $11E004
        DC.W    $0014,$0001         ; $11E006 ORI.B  #$0001,(A4)
        ADDQ.B  #8,D0                           ; $11E00A
        ORI.W  #$5700,D6                        ; $11E00C
        DC.W    $0005,$1B19         ; $11E010 ORI.B  #$1B19,D5
        DC.W    $001D,$000F         ; $11E014 ORI.B  #$000F,(A5)+
        DC.W    $000A,$0001         ; $11E018 ORI.B  #$0001,A2
        BTST    #9,D0                           ; $11E01C
        DC.W    $000D,$001A         ; $11E020 ORI.B  #$001A,A5
        MOVE.B  (A1)+,D3                        ; $11E024
        DC.W    $013D               ; $11E026 BTST    D0,<EA:3D>
        BTST    D1,(A1)+                        ; $11E028
        DC.W    $000D,$001F         ; $11E02A ORI.B  #$001F,A5
        SUBI.B  #$0028,(A1)+                    ; $11E02E
        DC.W    $002C,$002D,$002E   ; $11E032 ORI.B  #$002D,$002E(A4)
        DC.W    $002F,$0021,$0068   ; $11E038 ORI.B  #$0021,$0068(A7)
        DC.W    $0032,$00FB,$005A   ; $11E03E ORI.B  #$00FB,$5A(A2,D0.W)
        ORI.W  #$0075,(A3)+                     ; $11E044
        ORI.W  #$0067,$014B(A5)                 ; $11E048
        DC.W    $00C1               ; $11E04E DC.W    $00C1
        DC.W    $0B4D               ; $11E050 BCHG    D5,A5
        ORI.W  #$008D,-$67(A1,D0.W)             ; $11E052
        ORI.W  #$0190,-$36(A1,D0.W)             ; $11E058
        DC.W    $00C7               ; $11E05E DC.W    $00C7
        DC.W    $00FC               ; $11E060 DC.W    $00FC
        ORI.W  #$0219,$002E(A1)                 ; $11E062
        DC.W    $0039,$006F,$0060,$015F; $11E068 ORI.B  #$006F,$0060015F
        ORI.W  #$007C,(A5)+                     ; $11E070
        DC.W    $007E,$007F         ; $11E074 ORI.W  #$007F,<EA:3E>
        DC.W    $00D0               ; $11E078 DC.W    $00D0
        ORI.W  #$0045,D6                        ; $11E07A
        DC.W    $00B0,$00FD,$0044,$00AF; $11E07E ORI.L  #$00FD0044,-$51(A0,D0.W)
        DC.W    $00C9               ; $11E086 DC.W    $00C9
        DC.W    $00E4               ; $11E088 DC.W    $00E4
        ORI.W  #$00FE,$00FF(PC)                 ; $11E08A
        DC.W    $00B1,$00D6,$011E,$0017; $11E090 ORI.L  #$00D6011E,$17(A1,D0.W)
        DC.W    $0002,$5000         ; $11E098 ORI.B  #$5000,D2
        DC.W    $001B,$5700         ; $11E09C ORI.B  #$5700,(A3)+
        DC.W    $0003,$1819         ; $11E0A0 ORI.B  #$1819,D3
        DC.W    $0016,$000E         ; $11E0A4 ORI.B  #$000E,(A6)
        DC.W    $0004,$001C         ; $11E0A8 ORI.B  #$001C,D4
        DC.W    $0001,$0B00         ; $11E0AC ORI.B  #$0B00,D1
        DC.W    $0002,$0006         ; $11E0B0 ORI.B  #$0006,D2
        DC.W    $000D,$0017         ; $11E0B4 ORI.B  #$0017,A5
        MOVE.B  (A1)+,D5                        ; $11E0B8
        DC.W    $001C,$0003         ; $11E0BA ORI.B  #$0003,(A4)+
        DC.W    $001D,$1E19         ; $11E0BE ORI.B  #$1E19,(A5)+
        DC.W    $013D               ; $11E0C2 BTST    D0,<EA:3D>
        DC.W    $0219,$023D         ; $11E0C4 ANDI.B  #$023D,(A1)+
        BTST    D4,(A1)+                        ; $11E0C8
        DC.W    $0C3D,$0619         ; $11E0CA CMPI.B  #$0619,<EA:3D>
        DC.W    $021E,$001F         ; $11E0CE ANDI.B  #$001F,(A6)+
        DC.W    $0006,$5000         ; $11E0D2 ORI.B  #$5000,D6
        DC.W    $003A,$5700,$001C   ; $11E0D6 ORI.B  #$5700,$001C(PC)
        DC.W    $0015,$0017         ; $11E0DC ORI.B  #$0017,(A5)
        DC.W    $0016,$0015         ; $11E0E0 ORI.B  #$0015,(A6)
        DC.W    $0014,$0013         ; $11E0E4 ORI.B  #$0013,(A4)
        DC.W    $0012,$0011         ; $11E0E8 ORI.B  #$0011,(A2)
        DC.W    $0010,$000F         ; $11E0EC ORI.B  #$000F,(A0)
        DC.W    $010E               ; $11E0F0 BTST    D0,A6
        DC.W    $000D,$000C         ; $11E0F2 ORI.B  #$000C,A5
        DC.W    $001B,$0004         ; $11E0F6 ORI.B  #$0004,(A3)+
        BTST    D0,D5                           ; $11E0FA
        DC.W    $0003,$0106         ; $11E0FC ORI.B  #$0106,D3
        DC.W    $0007,$011C         ; $11E100 ORI.B  #$011C,D7
        DC.W    $000B,$0009         ; $11E104 ORI.B  #$0009,A3
        DC.W    $0002,$1000         ; $11E108 ORI.B  #$1000,D2
        DC.W    $0001,$001C         ; $11E10C ORI.B  #$001C,D1
        DC.W    $0003,$011B         ; $11E110 ORI.B  #$011B,D3
        DC.W    $000C,$000D         ; $11E114 ORI.B  #$000D,A4
        DC.W    $000E,$000F         ; $11E118 ORI.B  #$000F,A6
        DC.W    $0011,$0012         ; $11E11C ORI.B  #$0012,(A1)
        DC.W    $0013,$0014         ; $11E120 ORI.B  #$0014,(A3)
        DC.W    $0015,$0017         ; $11E124 ORI.B  #$0017,(A5)
        DC.W    $001D,$001F         ; $11E128 ORI.B  #$001F,(A5)+
        DC.W    $0018,$031E         ; $11E12C ORI.B  #$031E,(A0)+
        BTST    D2,(A1)+                        ; $11E130
        DC.W    $0018,$001C         ; $11E132 ORI.B  #$001C,(A0)+
        DC.W    $0008,$000A         ; $11E136 ORI.B  #$000A,A0
        DC.W    $000D,$001D         ; $11E13A ORI.B  #$001D,A5
        DC.W    $0018,$3D19         ; $11E13E ORI.B  #$3D19,(A0)+
        BTST    D0,(A6)+                        ; $11E142
        DC.W    $0218,$011A         ; $11E144 ANDI.B  #$011A,(A0)+
        DC.W    $001F,$0004         ; $11E148 ORI.B  #$0004,(A7)+
        ADDQ.B  #8,D0                           ; $11E14C
        DC.W    $0028,$5800,$0202   ; $11E14E ORI.B  #$5800,$0202(A0)
        BTST    D2,D1                           ; $11E154
        MOVE.L  D0,D5                           ; $11E156
        BTST    D1,D1                           ; $11E158
        BTST    D1,D2                           ; $11E15A
        DC.W    $0309               ; $11E15C BTST    D1,A1
        DC.W    $010A               ; $11E15E BTST    D0,A2
        DC.W    $000B,$0007         ; $11E160 ORI.B  #$0007,A3
        DC.W    $0003,$0005         ; $11E164 ORI.B  #$0005,D3
        DC.W    $001B,$010C         ; $11E168 ORI.B  #$010C,(A3)+
        DC.W    $000A,$0100         ; $11E16C ORI.B  #$0100,A2
        DC.W    $0001,$000B         ; $11E170 ORI.B  #$000B,D1
        DC.W    $001B,$0014         ; $11E174 ORI.B  #$0014,(A3)+
        DC.W    $0017,$0018         ; $11E178 ORI.B  #$0018,(A7)
        MOVE.L  (A1)+,-(A7)                     ; $11E17C
        BTST    D0,(A6)+                        ; $11E17E
        BTST    D0,(A0)+                        ; $11E180
        BTST    D0,(A2)+                        ; $11E182
        DC.W    $001F,$0017         ; $11E184 ORI.B  #$0017,(A7)+
        DC.W    $0015,$0014         ; $11E188 ORI.B  #$0014,(A5)
        DC.W    $0012,$0011         ; $11E18C ORI.B  #$0011,(A2)
        DC.W    $000F,$000D         ; $11E190 ORI.B  #$000D,A7
        DC.W    $000C,$0004         ; $11E194 ORI.B  #$0004,A4
        DC.W    $0005,$0006         ; $11E198 ORI.B  #$0006,D5
        DC.W    $001C,$0002         ; $11E19C ORI.B  #$0002,(A4)+
        ADDQ.B  #8,D0                           ; $11E1A0
        DC.W    $002F,$9D00,$0208   ; $11E1A2 ORI.B  #$9D00,$0208(A7)
        DC.W    $0001,$0008         ; $11E1A8 ORI.B  #$0008,D1
        BTST    D1,D0                           ; $11E1AC
        BTST    D0,D1                           ; $11E1AE
        DC.W    $0209,$020A         ; $11E1B0 ANDI.B  #$020A,A1
        DC.W    $000B,$001C         ; $11E1B4 ORI.B  #$001C,A3
        DC.W    $0006,$0003         ; $11E1B8 ORI.B  #$0003,D6
        DC.W    $0005,$0004         ; $11E1BC ORI.B  #$0004,D5
        DC.W    $001B,$000C         ; $11E1C0 ORI.B  #$000C,(A3)+
        DC.W    $000E,$000F         ; $11E1C4 ORI.B  #$000F,A6
        DC.W    $0010,$0011         ; $11E1C8 ORI.B  #$0011,(A0)
        BTST    D0,(A2)                         ; $11E1CC
        DC.W    $0013,$0014         ; $11E1CE ORI.B  #$0014,(A3)
        BTST    D0,(A5)                         ; $11E1D2
        DC.W    $0016,$0817         ; $11E1D4 ORI.B  #$0817,(A6)
        DC.W    $0016,$0015         ; $11E1D8 ORI.B  #$0015,(A6)
        BTST    D0,(A4)                         ; $11E1DC
        DC.W    $0013,$0012         ; $11E1DE ORI.B  #$0012,(A3)
        BTST    D0,(A1)                         ; $11E1E2
        DC.W    $0010,$000E         ; $11E1E4 ORI.B  #$000E,(A0)
        DC.W    $000D,$000C         ; $11E1E8 ORI.B  #$000C,A5
        DC.W    $001B,$0004         ; $11E1EC ORI.B  #$0004,(A3)+
        DC.W    $0005,$0006         ; $11E1F0 ORI.B  #$0006,D5
        DC.W    $0007,$000B         ; $11E1F4 ORI.B  #$000B,D7
        DC.W    $000A,$0309         ; $11E1F8 ORI.B  #$0309,A2
        DC.W    $0202,$0301         ; $11E1FC ANDI.B  #$0301,D2
