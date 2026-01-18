; Generated assembly for $00E200-$010200
; Branch targets: 212
; Labels: 198
; Format: DC.W with decoded mnemonics as comments

        org     $00E200

        ADDQ.W  #1,D0                           ; $00E200
        ANDI.W  #$0003,D0                       ; $00E202
        DBRA    D3,$00E1CA                      ; $00E206
        RTS                                     ; $00E20A
        BTST    #5,D7                           ; $00E20C
        SUBI.B  #$0201,D3                       ; $00E210
        MOVE.B  (A0),-(A0)                      ; $00E214
        DC.W    $0F0E               ; $00E216 BTST    D7,A6
        DC.W    $0D0C               ; $00E218 BTST    D6,A4
        DC.W    $0B0A               ; $00E21A BTST    D5,A2
        SUBI.B  #$0201,D3                       ; $00E21C
        BTST    #5,D7                           ; $00E220
        DC.W    $0D0C               ; $00E224 BTST    D6,A4
        DC.W    $0B0A               ; $00E226 BTST    D5,A2
        MOVE.B  (A0),-(A0)                      ; $00E228
        DC.W    $0F0E               ; $00E22A BTST    D7,A6
loc_00E22C:
        MOVEA.L A0,A1                           ; $00E22C
        LSL.W  #1,D1                            ; $00E22E
        LSL.W  #7,D2                            ; $00E230
        ADD.W  D2,D1                            ; $00E232
        LEA     $00(A0,D1.W),A0                 ; $00E234
        ANDI.W  #$0003,D0                       ; $00E238
        LSL.W  #8,D0                            ; $00E23C
        LSL.W  #5,D0                            ; $00E23E
        ADDI.W  #$0100,D0                       ; $00E240
        BCLR    #11,D0                          ; $00E244
        BCLR    #12,D0                          ; $00E248
        MOVEQ   #$00,D1                         ; $00E24C
        MOVE.W  #$0006,D2                       ; $00E24E
        ADD.W  D0,D2                            ; $00E252
        MOVE.W  D2,(A0)                         ; $00E254
        ADDA.L  #$00000080,A0                   ; $00E256
        MOVE.W  #$0001,D2                       ; $00E25C
        MOVE.W  D4,D5                           ; $00E260
        SUBQ.W  #3,D5                           ; $00E262
loc_00E264:
        JSR     loc_00E2E4(PC)                  ; $00E264
        MOVE.W  D6,(A0)                         ; $00E268
        ADDA.L  #$00000080,A0                   ; $00E26A
        DBRA    D5,loc_00E264                   ; $00E270
        MOVE.W  #$0007,D2                       ; $00E274
        JSR     loc_00E2E4(PC)                  ; $00E278
        MOVE.W  D6,(A0)+                        ; $00E27C
        MOVE.W  #$0003,D2                       ; $00E27E
        MOVE.W  D3,D5                           ; $00E282
        SUBQ.W  #3,D5                           ; $00E284
loc_00E286:
        JSR     loc_00E2E4(PC)                  ; $00E286
        MOVE.W  D6,(A0)+                        ; $00E28A
        DBRA    D5,loc_00E286                   ; $00E28C
        BSET    #11,D0                          ; $00E290
        BSET    #12,D0                          ; $00E294
        MOVE.W  #$0005,D2                       ; $00E298
        JSR     loc_00E2E4(PC)                  ; $00E29C
        MOVE.W  D6,(A0)                         ; $00E2A0
        SUBA.L  #$00000080,A0                   ; $00E2A2
        MOVE.W  #$0001,D2                       ; $00E2A8
        MOVE.W  D4,D5                           ; $00E2AC
        SUBQ.W  #3,D5                           ; $00E2AE
loc_00E2B0:
        JSR     loc_00E2E4(PC)                  ; $00E2B0
        MOVE.W  D6,(A0)                         ; $00E2B4
        SUBA.L  #$00000080,A0                   ; $00E2B6
        DBRA    D5,loc_00E2B0                   ; $00E2BC
        MOVE.W  #$0007,D2                       ; $00E2C0
        JSR     loc_00E2E4(PC)                  ; $00E2C4
        MOVE.W  D6,(A0)                         ; $00E2C8
        SUBQ.L  #2,A0                           ; $00E2CA
        MOVE.W  #$0003,D2                       ; $00E2CC
        MOVE.W  D3,D5                           ; $00E2D0
        SUBQ.W  #3,D5                           ; $00E2D2
loc_00E2D4:
        JSR     loc_00E2E4(PC)                  ; $00E2D4
        MOVE.W  D6,(A0)                         ; $00E2D8
        SUBQ.L  #2,A0                           ; $00E2DA
        DBRA    D5,loc_00E2D4                   ; $00E2DC
        MOVEA.L A1,A0                           ; $00E2E0
        RTS                                     ; $00E2E2
loc_00E2E4:
        MOVE.W  D2,D6                           ; $00E2E4
        ADD.W  D0,D6                            ; $00E2E6
        ADD.W  D1,D6                            ; $00E2E8
        BCHG    #0,D1                           ; $00E2EA
        RTS                                     ; $00E2EE
loc_00E2F0:
        MOVE.L  #$60000002,(A5)                 ; $00E2F0
        MOVEQ   #$1B,D0                         ; $00E2F6
loc_00E2F8:
        MOVE.W  #$001F,D1                       ; $00E2F8
loc_00E2FC:
        MOVE.L  (A0)+,(A6)                      ; $00E2FC
        DBRA    D1,loc_00E2FC                   ; $00E2FE
        MOVE.W  #$001F,D1                       ; $00E302
loc_00E306:
        MOVE.L  #$00000000,(A6)                 ; $00E306
        DBRA    D1,loc_00E306                   ; $00E30C
        DBRA    D0,loc_00E2F8                   ; $00E310
        RTS                                     ; $00E314
loc_00E316:
        TST.B  $00A15120                        ; $00E316
        BNE.S  loc_00E316                       ; $00E31C
        ADDA.L  #$02000000,A0                   ; $00E31E
        MOVE.L  A0,$00A15128                    ; $00E324
        DC.W    $33FC,$0101,$00A1,$512C; $00E32A MOVE.W  #$0101,$00A1512C
        DC.W    $13FC,$0025,$00A1,$5121; $00E332 MOVE.B  #$0025,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $00E33A MOVE.B  #$0001,$00A15120
loc_00E342:
        TST.B  $00A1512C                        ; $00E342
        BNE.S  loc_00E342                       ; $00E348
        MOVE.L  A1,$00A15128                    ; $00E34A
        DC.W    $33FC,$0101,$00A1,$512C; $00E350 MOVE.W  #$0101,$00A1512C
        RTS                                     ; $00E358
loc_00E35A:
        TST.B  $00A15120                        ; $00E35A
        BNE.S  loc_00E35A                       ; $00E360
        MOVE.L  A1,$00A15128                    ; $00E362
        DC.W    $33FC,$0101,$00A1,$512C; $00E368 MOVE.W  #$0101,$00A1512C
        DC.W    $13FC,$0022,$00A1,$5121; $00E370 MOVE.B  #$0022,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $00E378 MOVE.B  #$0001,$00A15120
loc_00E380:
        TST.B  $00A1512C                        ; $00E380
        BNE.S  loc_00E380                       ; $00E386
        MOVE.W  D0,$00A15128                    ; $00E388
        MOVE.W  D1,$00A1512A                    ; $00E38E
        DC.W    $33FC,$0101,$00A1,$512C; $00E394 MOVE.W  #$0101,$00A1512C
loc_00E39C:
        TST.B  $00A1512C                        ; $00E39C
        BNE.S  loc_00E39C                       ; $00E3A2
        MOVE.L  A0,$00A15128                    ; $00E3A4
        DC.W    $33FC,$0101,$00A1,$512C; $00E3AA MOVE.W  #$0101,$00A1512C
        RTS                                     ; $00E3B2
loc_00E3B4:
        MOVE.L  A0,$00A15128                    ; $00E3B4
        DC.W    $33FC,$0101,$00A1,$512C; $00E3BA MOVE.W  #$0101,$00A1512C
        DC.W    $13FC,$0027,$00A1,$5121; $00E3C2 MOVE.B  #$0027,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $00E3CA MOVE.B  #$0001,$00A15120
loc_00E3D2:
        TST.B  $00A1512C                        ; $00E3D2
        BNE.S  loc_00E3D2                       ; $00E3D8
        MOVE.W  D0,$00A15128                    ; $00E3DA
        MOVE.W  D1,$00A1512A                    ; $00E3E0
        DC.W    $33FC,$0101,$00A1,$512C; $00E3E6 MOVE.W  #$0101,$00A1512C
loc_00E3EE:
        TST.B  $00A1512C                        ; $00E3EE
        BNE.S  loc_00E3EE                       ; $00E3F4
        MOVE.W  D2,$00A15128                    ; $00E3F6
        DC.W    $33FC,$0101,$00A1,$512C; $00E3FC MOVE.W  #$0101,$00A1512C
        RTS                                     ; $00E404
loc_00E406:
        TST.B  $00A15120                        ; $00E406
        BNE.S  loc_00E406                       ; $00E40C
        MOVE.L  A0,$00A15128                    ; $00E40E
        DC.W    $33FC,$0101,$00A1,$512C; $00E414 MOVE.W  #$0101,$00A1512C
        DC.W    $13FC,$002F,$00A1,$5121; $00E41C MOVE.B  #$002F,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $00E424 MOVE.B  #$0001,$00A15120
loc_00E42C:
        TST.B  $00A1512C                        ; $00E42C
        BNE.S  loc_00E42C                       ; $00E432
        MOVE.W  D0,$00A15128                    ; $00E434
        MOVE.W  D1,$00A1512A                    ; $00E43A
        DC.W    $33FC,$0101,$00A1,$512C; $00E440 MOVE.W  #$0101,$00A1512C
loc_00E448:
        TST.B  $00A1512C                        ; $00E448
        BNE.S  loc_00E448                       ; $00E44E
        MOVE.W  D2,$00A15128                    ; $00E450
        MOVE.W  D3,$00A1512A                    ; $00E456
        DC.W    $33FC,$0101,$00A1,$512C; $00E45C MOVE.W  #$0101,$00A1512C
        RTS                                     ; $00E464
        MOVE.B  (A2)+,D1                        ; $00E466
        ANDI.W  #$000F,D1                       ; $00E468
        BSR.W  loc_00E4BC                       ; $00E46C
        ADDQ.L  #8,A1                           ; $00E470
        MOVE.W  #$000A,D1                       ; $00E472
        BSR.W  loc_00E4BC                       ; $00E476
        ADDQ.L  #8,A1                           ; $00E47A
        MOVE.B  (A2)+,D2                        ; $00E47C
        BSR.W  loc_00E4A0                       ; $00E47E
        MOVE.W  #$000B,D1                       ; $00E482
        BSR.W  loc_00E4BC                       ; $00E486
        ADDQ.L  #8,A1                           ; $00E48A
        MOVE.B  (A2)+,D1                        ; $00E48C
        ANDI.W  #$000F,D1                       ; $00E48E
        BSR.W  loc_00E4BC                       ; $00E492
        ADDQ.L  #8,A1                           ; $00E496
        MOVE.B  (A2)+,D2                        ; $00E498
        BSR.W  loc_00E4A0                       ; $00E49A
        RTS                                     ; $00E49E
loc_00E4A0:
        MOVE.B  D2,D1                           ; $00E4A0
        LSR.B  #4,D1                            ; $00E4A2
        ANDI.W  #$000F,D1                       ; $00E4A4
        BSR.W  loc_00E4BC                       ; $00E4A8
        ADDQ.L  #8,A1                           ; $00E4AC
        MOVE.W  D2,D1                           ; $00E4AE
        ANDI.W  #$000F,D1                       ; $00E4B0
        BSR.W  loc_00E4BC                       ; $00E4B4
        ADDQ.L  #8,A1                           ; $00E4B8
        RTS                                     ; $00E4BA
loc_00E4BC:
        LSL.W  #6,D1                            ; $00E4BC
        MOVE.W  D1,D0                           ; $00E4BE
        LSL.W  #1,D1                            ; $00E4C0
        ADD.W  D0,D1                            ; $00E4C2
        MOVEA.L #$0603DA00,A0                   ; $00E4C4
        ADDA.W  D1,A0                           ; $00E4CA
        MOVE.W  #$000C,D0                       ; $00E4CC
        MOVE.W  #$0010,D1                       ; $00E4D0
        JSR     loc_00E35A(PC)                  ; $00E4D4
        RTS                                     ; $00E4D8
        MOVE.L  A1,$00A15128                    ; $00E4DA
        DC.W    $33FC,$0101,$00A1,$512C; $00E4E0 MOVE.W  #$0101,$00A1512C
        DC.W    $13FC,$0021,$00A1,$5121; $00E4E8 MOVE.B  #$0021,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $00E4F0 MOVE.B  #$0001,$00A15120
loc_00E4F8:
        TST.B  $00A1512C                        ; $00E4F8
        BNE.S  loc_00E4F8                       ; $00E4FE
        MOVE.W  D0,$00A15128                    ; $00E500
        MOVE.W  D1,$00A1512A                    ; $00E506
        DC.W    $33FC,$0101,$00A1,$512C; $00E50C MOVE.W  #$0101,$00A1512C
loc_00E514:
        TST.B  $00A1512C                        ; $00E514
        BNE.S  loc_00E514                       ; $00E51A
        MOVE.L  A0,$00A15128                    ; $00E51C
        DC.W    $33FC,$0101,$00A1,$512C; $00E522 MOVE.W  #$0101,$00A1512C
        RTS                                     ; $00E52A
loc_00E52C:
        LEA     $84A2.W,A0                      ; $00E52C
        LEA     $84C2.W,A1                      ; $00E530
        LEA     $84E2.W,A2                      ; $00E534
        CLR.W  D2                               ; $00E538
        MOVE.W  #$0007,D1                       ; $00E53A
loc_00E53E:
        MOVE.W  #$0000,$00(A0,D2.W)             ; $00E53E
        MOVE.W  #$0000,$00(A1,D2.W)             ; $00E544
        MOVE.W  #$0000,$00(A2,D2.W)             ; $00E54A
        ADDQ.W  #2,D2                           ; $00E550
        DBRA    D1,loc_00E53E                   ; $00E552
        TST.W  D0                               ; $00E556
        BNE.S  loc_00E562                       ; $00E558
        LEA     $84A2.W,A0                      ; $00E55A
        BRA.W  loc_00E576                       ; $00E55E
loc_00E562:
        CMPI.W  #$0001,D0                       ; $00E562
        BNE.W  loc_00E572                       ; $00E566
        LEA     $84C2.W,A0                      ; $00E56A
        BRA.W  loc_00E576                       ; $00E56E
loc_00E572:
        LEA     $84E2.W,A0                      ; $00E572
loc_00E576:
        LEA     $0088E5AC,A3                    ; $00E576
        MOVEQ   #$00,D1                         ; $00E57C
        MOVE.W  $A012.W,D1                      ; $00E57E
        ADD.W  D1,D1                            ; $00E582
        ADDA.L  D1,A3                           ; $00E584
        CLR.W  D2                               ; $00E586
        MOVE.W  #$0007,D1                       ; $00E588
loc_00E58C:
        MOVE.W  (A3)+,$00(A0,D2.W)              ; $00E58C
        ADDQ.W  #2,D2                           ; $00E590
        DBRA    D1,loc_00E58C                   ; $00E592
        MOVE.W  $A012.W,D1                      ; $00E596
        ADDQ.W  #1,D1                           ; $00E59A
        CMPI.W  #$0007,D1                       ; $00E59C
        BLE.W  loc_00E5A6                       ; $00E5A0
        CLR.W  D1                               ; $00E5A4
loc_00E5A6:
        MOVE.W  D1,$A012.W                      ; $00E5A6
        RTS                                     ; $00E5AA
        DC.W    $0EEE               ; $00E5AC DC.W    $0EEE
        DC.W    $0EEE               ; $00E5AE DC.W    $0EEE
        DC.W    $0EEE               ; $00E5B0 DC.W    $0EEE
        DC.W    $0EEE               ; $00E5B2 DC.W    $0EEE
        DC.W    $0000,$0000         ; $00E5B4 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00E5B8 ORI.B  #$0000,D0
        DC.W    $0EEE               ; $00E5BC DC.W    $0EEE
        DC.W    $0EEE               ; $00E5BE DC.W    $0EEE
        DC.W    $0EEE               ; $00E5C0 DC.W    $0EEE
        DC.W    $0EEE               ; $00E5C2 DC.W    $0EEE
        DC.W    $0000,$0000         ; $00E5C4 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00E5C8 ORI.B  #$0000,D0
        RTS                                     ; $00E5CC
        CLR.B  $A01F.W                          ; $00E5CE
        MOVE.B  $FEA9.W,$A01D.W                 ; $00E5D2
        MOVE.B  $FEB1.W,$A019.W                 ; $00E5D8
        BCLR    #7,$FDA8.W                      ; $00E5DE
        BRA.S  loc_00E616                       ; $00E5E4
        CLR.B  $A01F.W                          ; $00E5E6
        MOVE.B  $FEA9.W,$A01D.W                 ; $00E5EA
        MOVE.B  $FEB1.W,$A019.W                 ; $00E5F0
        BSET    #7,$FDA8.W                      ; $00E5F6
        BRA.S  loc_00E616                       ; $00E5FC
        MOVE.B  #$0001,$A01F.W                  ; $00E5FE
        MOVE.B  $FEAA.W,$A01D.W                 ; $00E604
        BCLR    #7,$FDA8.W                      ; $00E60A
        MOVE.B  $FEB2.W,$A019.W                 ; $00E610
loc_00E616:
        DC.W    $33FC,$002C,$00FF,$0008; $00E616 MOVE.W  #$002C,$00FF0008
        MOVE.W  #$002C,$C87A.W                  ; $00E61E
        BCLR    #6,$C875.W                      ; $00E624
        MOVE.W  $C874.W,(A5)                    ; $00E62A
        DC.W    $33FC,$0083,$00A1,$5100; $00E62E MOVE.W  #$0083,$00A15100
        DC.W    $0239,$00FC,$00A1,$5181; $00E636 ANDI.B  #$00FC,$00A15181
        JSR     $008826C8                       ; $00E63E
        MOVE.L  #$000A0907,D0                   ; $00E644
        JSR     $008814BE                       ; $00E64A
        MOVE.B  #$0001,$C80D.W                  ; $00E650
        MOVEQ   #$00,D0                         ; $00E656
        LEA     $8480.W,A0                      ; $00E658
        MOVEQ   #$1F,D1                         ; $00E65C
loc_00E65E:
        MOVE.L  D0,(A0)+                        ; $00E65E
        DBRA    D1,loc_00E65E                   ; $00E660
        LEA     $00FF7B80,A0                    ; $00E664
        MOVEQ   #$7F,D1                         ; $00E66A
loc_00E66C:
        MOVE.L  D0,(A0)+                        ; $00E66C
        DBRA    D1,loc_00E66C                   ; $00E66E
        MOVE.L  #$60000002,(A5)                 ; $00E672
        MOVE.W  #$17FF,D1                       ; $00E678
loc_00E67C:
        MOVE.L  D0,(A6)                         ; $00E67C
        DBRA    D1,loc_00E67C                   ; $00E67E
        JSR     $008849AA                       ; $00E682
        CLR.W  $C880.W                          ; $00E688
        CLR.W  $C882.W                          ; $00E68C
        CLR.W  $8000.W                          ; $00E690
        CLR.W  $8002.W                          ; $00E694
        CLR.W  $A012.W                          ; $00E698
        CLR.B  $A018.W                          ; $00E69C
        JSR     $008849AA                       ; $00E6A0
        DC.W    $21FC,$008B,$B4FC,$C96C; $00E6A6 MOVE.L  #$008BB4FC,$C96C.W
        MOVE.B  #$0001,$C809.W                  ; $00E6AE
        MOVE.B  #$0001,$C80A.W                  ; $00E6B4
        BSET    #6,$C80E.W                      ; $00E6BA
        MOVE.B  #$0001,$C802.W                  ; $00E6C0
        MOVE.W  #$0001,$A020.W                  ; $00E6C6
        LEA     $00FF1000,A0                    ; $00E6CC
        MOVE.W  #$037F,D0                       ; $00E6D2
loc_00E6D6:
        CLR.L  (A0)+                            ; $00E6D6
        DBRA    D0,loc_00E6D6                   ; $00E6D8
        MOVE.W  #$0001,D0                       ; $00E6DC
        MOVE.W  #$0001,D1                       ; $00E6E0
        MOVE.W  #$0001,D2                       ; $00E6E4
        MOVE.W  #$0026,D3                       ; $00E6E8
        MOVE.W  #$0014,D4                       ; $00E6EC
        LEA     $00FF1000,A0                    ; $00E6F0
        JSR     loc_00E22C(PC)                  ; $00E6F6
        MOVE.W  #$0002,D0                       ; $00E6FA
        MOVE.W  #$0001,D1                       ; $00E6FE
        MOVE.W  #$0016,D2                       ; $00E702
        MOVE.W  #$0026,D3                       ; $00E706
        MOVE.W  #$0005,D4                       ; $00E70A
        LEA     $00FF1000,A0                    ; $00E70E
        JSR     loc_00E22C(PC)                  ; $00E714
        LEA     $00FF1000,A0                    ; $00E718
        JSR     loc_00E2F0(PC)                  ; $00E71E
        JSR     $00E1BC(PC)                     ; $00E722
        DC.W    $08B9,$0007,$00A1,$5181; $00E726 BCLR    #7,$00A15181
        LEA     $00FF6E00,A0                    ; $00E72E
        LEA     $008BA220,A1                    ; $00E734
        MOVEA.L (A1),A1                         ; $00E73A
        MOVE.W  #$007F,D0                       ; $00E73C
loc_00E740:
        MOVE.W  (A1)+,(A0)+                     ; $00E740
        DBRA    D0,loc_00E740                   ; $00E742
        LEA     $00FF6E00,A0                    ; $00E746
        ADDA.L  #$00000160,A0                   ; $00E74C
        LEA     $0088E88C,A1                    ; $00E752
        MOVE.W  #$003F,D0                       ; $00E758
loc_00E75C:
        MOVE.W  (A1)+,D1                        ; $00E75C
        BSET    #15,D1                          ; $00E75E
        MOVE.W  D1,(A0)+                        ; $00E762
        DBRA    D0,loc_00E75C                   ; $00E764
        LEA     $000E9680,A0                    ; $00E768
        MOVEA.L #$06038000,A1                   ; $00E76E
        JSR     loc_00E316(PC)                  ; $00E774
        LEA     $000E9450,A0                    ; $00E778
        MOVEA.L #$0603B600,A1                   ; $00E77E
        JSR     loc_00E316(PC)                  ; $00E784
        LEA     $000E90A0,A0                    ; $00E788
        MOVEA.L #$0603D100,A1                   ; $00E78E
        JSR     loc_00E316(PC)                  ; $00E794
        LEA     $000E9240,A0                    ; $00E798
        MOVEA.L #$0603D800,A1                   ; $00E79E
        JSR     loc_00E316(PC)                  ; $00E7A4
        MOVE.B  $A019.W,$A01E.W                 ; $00E7A8
        CLR.B  $A01A.W                          ; $00E7AE
        DC.W    $33FC,$0080,$00FF,$2000; $00E7B2 MOVE.W  #$0080,$00FF2000
        DC.W    $33FC,$FF80,$00FF,$2002; $00E7BA MOVE.W  #$FF80,$00FF2002
        DC.W    $33FC,$003C,$00FF,$2004; $00E7C2 MOVE.W  #$003C,$00FF2004
        DC.W    $33FC,$00BC,$00FF,$2006; $00E7CA MOVE.W  #$00BC,$00FF2006
        DC.W    $33FC,$FF60,$00FF,$2008; $00E7D2 MOVE.W  #$FF60,$00FF2008
        DC.W    $33FC,$0044,$00FF,$200A; $00E7DA MOVE.W  #$0044,$00FF200A
        DC.W    $33FC,$0080,$00FF,$200C; $00E7E2 MOVE.W  #$0080,$00FF200C
        DC.W    $33FC,$FF80,$00FF,$200E; $00E7EA MOVE.W  #$FF80,$00FF200E
        DC.W    $33FC,$003C,$00FF,$2010; $00E7F2 MOVE.W  #$003C,$00FF2010
        JSR     $0088204A                       ; $00E7FA
        DC.W    $0239,$00FC,$00A1,$5181; $00E800 ANDI.B  #$00FC,$00A15181
        DC.W    $0039,$0001,$00A1,$5181; $00E808 ORI.B  #$0001,$00A15181
        DC.W    $33FC,$8083,$00A1,$5100; $00E810 MOVE.W  #$8083,$00A15100
        BSET    #6,$C875.W                      ; $00E818
        MOVE.W  $C874.W,(A5)                    ; $00E81E
        DC.W    $33FC,$0020,$00FF,$0008; $00E822 MOVE.W  #$0020,$00FF0008
        JSR     $00884998                       ; $00E82A
        MOVE.W  #$0000,$C87E.W                  ; $00E830
        DC.W    $23FC,$0088,$E90C,$00FF,$0002; $00E836 MOVE.L  #$0088E90C,$00FF0002
        MOVE.B  #$0081,$C8A5.W                  ; $00E840
        DC.W    $13FC,$0000,$00FF,$60D4; $00E846 MOVE.B  #$0000,$00FF60D4
        LEA     $00FF6100,A0                    ; $00E84E
        MOVE.W  #$007F,D0                       ; $00E854
loc_00E858:
        CLR.L  (A0)+                            ; $00E858
        CLR.L  (A0)+                            ; $00E85A
        CLR.L  (A0)+                            ; $00E85C
        CLR.L  (A0)+                            ; $00E85E
        CLR.L  (A0)+                            ; $00E860
        DBRA    D0,loc_00E858                   ; $00E862
loc_00E866:
        TST.B  $00A15120                        ; $00E866
        BNE.S  loc_00E866                       ; $00E86C
        CLR.B  $00A15122                        ; $00E86E
        CLR.B  $00A15123                        ; $00E874
        DC.W    $13FC,$0003,$00A1,$5121; $00E87A MOVE.B  #$0003,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $00E882 MOVE.B  #$0001,$00A15120
        RTS                                     ; $00E88A
        NEG.B  D0                               ; $00E88C
        NEG.L  -(A3)                            ; $00E88E
        DC.W    $4946               ; $00E890 DC.W    $4946
        LEA     $1C00(A1),A6                    ; $00E892
        MOVE.L  -(A3),(A4)                      ; $00E896
        MOVE.W  D6,$41E9(A2)                    ; $00E898
        DC.W    $7FFF               ; $00E89C MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E89E MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E8A0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E8A2 MOVE.W  <EA:3F>,<EA:3F>
        MOVE.B  D0,D6                           ; $00E8A4
        MOVE.L  -(A3),(A4)                      ; $00E8A6
        MOVE.W  D6,$41E9(A2)                    ; $00E8A8
        NEG.B  D0                               ; $00E8AC
        NEG.L  -(A3)                            ; $00E8AE
        DC.W    $4946               ; $00E8B0 DC.W    $4946
        LEA     $7FFF(A1),A6                    ; $00E8B2
        BLS.S  loc_00E8AD                       ; $00E8B6
        DC.W    $7FFF               ; $00E8B8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E8BA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $0010,$14AF         ; $00E8BC ORI.B  #$14AF,(A0)
        MOVE.L  A6,$3DED(A4)                    ; $00E8C0
        DC.W    $7FFF               ; $00E8C4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E8C6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E8C8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E8CA MOVE.W  <EA:3F>,<EA:3F>
        MOVE.W  $7BBC(PC),-$66(A3,D7.W)         ; $00E8CC
        MOVE.W  #$6B36,$37(A3,D6.L)             ; $00E8D2
        BLE.S  loc_00E932                       ; $00E8D8
        BLE.S  loc_00E955                       ; $00E8DA
        MOVE.W  (A2)+,-$18(A1,D6.W)             ; $00E8DC
        DC.W    $7FFF               ; $00E8E0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E8E2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E8E4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E8E6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E8E8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E8EA MOVE.W  <EA:3F>,<EA:3F>
        MOVE.W  #$7F7A,-$22(A7,D7.L)            ; $00E8EC
        MOVE.W  (A3)+,$45(A7,D4.W)              ; $00E8F2
        SUBQ.B  #8,$6212(A3)                    ; $00E8F6
        BGT.S  loc_00E8F4                       ; $00E8FA
        DC.W    $7FFF               ; $00E8FC MOVE.W  <EA:3F>,<EA:3F>
        BTST    D1,(A7)+                        ; $00E8FE
        DC.W    $7FFF               ; $00E900 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E902 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E904 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E906 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E908 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00E90A MOVE.W  <EA:3F>,<EA:3F>
        JSR     $00882080                       ; $00E90C
        MOVE.W  $C87E.W,D0                      ; $00E912
        MOVEA.L $04(PC,D0.W),A1                 ; $00E916
        JMP     (A1)                            ; $00E91A
        ORI.L  #$E93A0088,A0                    ; $00E91C
        ROXL.W  (A2)+                           ; $00E922
        ORI.L  #$EEF24EBA,A0                    ; $00E924
        AND.W  D6,(A2)+                         ; $00E92A
        BTST    #6,$C80E.W                      ; $00E92C
loc_00E932:
        BNE.S  loc_00E938                       ; $00E932
        ADDQ.W  #4,$C87E.W                      ; $00E934
loc_00E938:
        RTS                                     ; $00E938
        MOVEA.L #$06038000,A0                   ; $00E93A
        MOVEA.L #$04012010,A1                   ; $00E940
        MOVE.W  #$0120,D0                       ; $00E946
        MOVE.W  #$0030,D1                       ; $00E94A
        JSR     loc_00E35A(PC)                  ; $00E94E
        MOVEA.L #$0603B600,A0                   ; $00E952
        MOVEA.L #$0401B010,A1                   ; $00E958
        MOVE.W  #$0120,D0                       ; $00E95E
        MOVE.W  #$0018,D1                       ; $00E962
        JSR     loc_00E35A(PC)                  ; $00E966
        MOVEQ   #$00,D0                         ; $00E96A
        TST.B  $A01A.W                          ; $00E96C
        BNE.S  loc_00E978                       ; $00E970
        MOVE.B  $A019.W,D0                      ; $00E972
        BRA.S  loc_00E97C                       ; $00E976
loc_00E978:
        MOVE.B  $A01E.W,D0                      ; $00E978
loc_00E97C:
        MOVE.W  D0,D1                           ; $00E97C
        ADD.W  D1,D1                            ; $00E97E
        ADD.W  D1,D1                            ; $00E980
        LEA     $00FF6E00,A0                    ; $00E982
        LEA     $0088EACE,A1                    ; $00E988
        MOVEA.L $00(A1,D1.W),A1                 ; $00E98E
        MOVE.W  #$007F,D1                       ; $00E992
loc_00E996:
        MOVE.W  (A1)+,(A0)+                     ; $00E996
        DBRA    D1,loc_00E996                   ; $00E998
        LEA     $0088EAC2,A0                    ; $00E99C
        ADD.W  D0,D0                            ; $00E9A2
        ADD.W  D0,D0                            ; $00E9A4
        MOVEA.L $00(A0,D0.W),A0                 ; $00E9A6
        MOVE.L  $A014.W,D0                      ; $00E9AA
        JSR     (A0)                            ; $00E9AE
loc_00E9B0:
        DC.W    $0839,$0001,$00A1,$5123; $00E9B0 BTST    #1,$00A15123
        BEQ.S  loc_00E9B0                       ; $00E9B8
        DC.W    $08B9,$0001,$00A1,$5123; $00E9BA BCLR    #1,$00A15123
        LEA     $00FF60C8,A1                    ; $00E9C2
        LEA     $00A15112,A2                    ; $00E9C8
        MOVE.W  #$0043,D7                       ; $00E9CE
loc_00E9D2:
        DC.W    $0839,$0007,$00A1,$5107; $00E9D2 BTST    #7,$00A15107
        BNE.S  loc_00E9D2                       ; $00E9DA
        MOVE.W  (A1)+,(A2)                      ; $00E9DC
        DBRA    D7,loc_00E9D2                   ; $00E9DE
        MOVE.L  $A014.W,D0                      ; $00E9E2
        ADDI.L  #$00000080,D0                   ; $00E9E6
        ANDI.L  #$0000FFFF,D0                   ; $00E9EC
        MOVE.L  D0,$A014.W                      ; $00E9F2
        CLR.W  D0                               ; $00E9F6
        MOVE.B  $A01A.W,D0                      ; $00E9F8
        BSR.W  loc_00E52C                       ; $00E9FC
        JSR     $0088179E                       ; $00EA00
        TST.W  $A020.W                          ; $00EA06
        BNE.W  loc_00EAB4                       ; $00EA0A
        MOVE.B  $A019.W,D0                      ; $00EA0E
        MOVE.W  $C86C.W,D1                      ; $00EA12
        BTST    #3,D1                           ; $00EA16
        BEQ.S  loc_00EA42                       ; $00EA1A
        MOVE.B  #$00A9,$C8A4.W                  ; $00EA1C
        TST.B  $A01A.W                          ; $00EA22
        BEQ.W  loc_00EA34                       ; $00EA26
        CMPI.B  #$0001,D0                       ; $00EA2A
        BGE.S  loc_00EA3E                       ; $00EA2E
        BRA.W  loc_00EA3A                       ; $00EA30
loc_00EA34:
        CMPI.B  #$0002,D0                       ; $00EA34
        BGE.S  loc_00EA3E                       ; $00EA38
loc_00EA3A:
        ADDQ.B  #1,D0                           ; $00EA3A
        BRA.S  loc_00EAB0                       ; $00EA3C
loc_00EA3E:
        CLR.B  D0                               ; $00EA3E
        BRA.S  loc_00EAB0                       ; $00EA40
loc_00EA42:
        BTST    #2,D1                           ; $00EA42
        BEQ.S  loc_00EA6A                       ; $00EA46
        MOVE.B  #$00A9,$C8A4.W                  ; $00EA48
        TST.B  D0                               ; $00EA4E
        BLE.S  loc_00EA56                       ; $00EA50
        SUBQ.B  #1,D0                           ; $00EA52
        BRA.S  loc_00EAB0                       ; $00EA54
loc_00EA56:
        TST.B  $A01A.W                          ; $00EA56
        BEQ.W  loc_00EA64                       ; $00EA5A
        MOVE.B  #$0001,D0                       ; $00EA5E
        BRA.S  loc_00EAB0                       ; $00EA62
loc_00EA64:
        MOVE.B  #$0002,D0                       ; $00EA64
        BRA.S  loc_00EAB0                       ; $00EA68
loc_00EA6A:
        BTST    #0,D1                           ; $00EA6A
        BEQ.W  loc_00EA8C                       ; $00EA6E
        TST.B  $A01A.W                          ; $00EA72
        BEQ.S  loc_00EAB0                       ; $00EA76
        MOVE.B  #$00A9,$C8A4.W                  ; $00EA78
        CLR.B  $A01A.W                          ; $00EA7E
        MOVE.B  D0,$A01D.W                      ; $00EA82
        MOVE.B  $A01E.W,D0                      ; $00EA86
        BRA.S  loc_00EAB0                       ; $00EA8A
loc_00EA8C:
        BTST    #1,D1                           ; $00EA8C
        BEQ.W  loc_00EAB0                       ; $00EA90
        CMPI.B  #$0001,$A01A.W                  ; $00EA94
        BGE.S  loc_00EAB0                       ; $00EA9A
        MOVE.B  #$00A9,$C8A4.W                  ; $00EA9C
        MOVE.B  #$0001,$A01A.W                  ; $00EAA2
        MOVE.B  D0,$A01E.W                      ; $00EAA8
        MOVE.B  $A01D.W,D0                      ; $00EAAC
loc_00EAB0:
        MOVE.B  D0,$A019.W                      ; $00EAB0
loc_00EAB4:
        ADDQ.W  #4,$C87E.W                      ; $00EAB4
        DC.W    $33FC,$0020,$00FF,$0008; $00EAB8 MOVE.W  #$0020,$00FF0008
        RTS                                     ; $00EAC0
        ORI.L  #$EFC20088,A0                    ; $00EAC2
        MOVEA.W D0,A0                           ; $00EAC8
        ORI.L  #$F0BE0088,A0                    ; $00EACA
        LSR.W  (A2)+                            ; $00EAD0
        ORI.L  #$EBDA0088,A0                    ; $00EAD2
        ROXR.W  (A2)+                           ; $00EAD8
        DC.W    $0000,$8000         ; $00EADA ORI.B  #$8000,D0
        OR.B   -(A1),D2                         ; $00EADE
        OR.W   D2,D4                            ; $00EAE0
        OR.W   -(A3),D6                         ; $00EAE2
        SUB.L  D4,D0                            ; $00EAE4
        SUB.L  -(A5),D2                         ; $00EAE6
        SUBA.W  D6,A4                           ; $00EAE8
        SUBA.W  -(A7),A6                        ; $00EAEA
        MOVE.L  A0,-(A0)                        ; $00EAEC
        MOVE.L  -$56B6(A1),-(A2)                ; $00EAEE
        MOVE.L  -$4E74(A3),-$4A53(A6)           ; $00EAF2
        CMPA.L  A6,A4                           ; $00EAF8
        CMPA.L  -$3DF0(A7),A6                   ; $00EAFA
        AND.B  $52(A1,A4.L),D3                  ; $00EAFE
        AND.W  -$6C(A3,A5.W),D7                 ; $00EB02
        ADD.L  -$2A(A5,A5.L),D3                 ; $00EB06
        ADDA.W  $18(A7,A6.W),A7                 ; $00EB0A
        ROL.B  D3,D1                            ; $00EB0E
        ROL.W  #5,D2                            ; $00EB10
        ROL.W  D7,D3                            ; $00EB12
        MOVE.W  (A4)+,-$43(A1,A7.W)             ; $00EB14
        DC.W    $FBDE               ; $00EB18 MOVE.W  (A6)+,<EA:3D>
        DC.W    $FFFF               ; $00EB1A MOVE.W  <EA:3F>,<EA:3F>
        OR.B   A2,D0                            ; $00EB1C
        OR.B   A3,D0                            ; $00EB1E
        OR.B   A4,D0                            ; $00EB20
        OR.B   A5,D0                            ; $00EB22
        OR.B   A6,D0                            ; $00EB24
        OR.B   A7,D0                            ; $00EB26
        OR.B   (A0),D0                          ; $00EB28
        OR.B   (A1),D0                          ; $00EB2A
        OR.B   (A2),D0                          ; $00EB2C
        OR.B   $73(A2,A0.L),D2                  ; $00EB2E
        SUB.L  (A4),D0                          ; $00EB32
        SUBA.W  (A4),A4                         ; $00EB34
        MOVE.L  $00(A6,A3.L),-(A2)              ; $00EB36
        AND.B  D0,D4                            ; $00EB3A
        ADD.B  D0,D4                            ; $00EB3C
        ASR.B  #8,D0                            ; $00EB3E
        ASR.W  D0,D3                            ; $00EB40
        ASR.L  #2,D4                            ; $00EB42
        ROXR.W  D6                              ; $00EB44
        ROXR.W  -(A7)                           ; $00EB46
        LSL.B  D4,D1                            ; $00EB48
        MOVE.W  $18(A5,A7.W),(A1)               ; $00EB4A
        OR.B   D0,D0                            ; $00EB4E
        OR.B   D0,D0                            ; $00EB50
        OR.B   D0,D0                            ; $00EB52
        OR.B   D0,D0                            ; $00EB54
        OR.B   D0,D0                            ; $00EB56
        OR.B   D0,D0                            ; $00EB58
        OR.B   D0,D0                            ; $00EB5A
        OR.B   D0,D0                            ; $00EB5C
        OR.B   D0,D0                            ; $00EB5E
        OR.B   D0,D0                            ; $00EB60
        OR.B   D0,D0                            ; $00EB62
        OR.B   D0,D0                            ; $00EB64
        SUB.L  -(A0),D2                         ; $00EB66
        OR.W   D0,D4                            ; $00EB68
        OR.B   D0,D0                            ; $00EB6A
        OR.W   D0,D4                            ; $00EB6C
        SUB.L  D0,D0                            ; $00EB6E
        SUBA.W  D1,A4                           ; $00EB70
        MOVE.L  D3,-(A0)                        ; $00EB72
        MOVE.L  D5,$0000(A4)                    ; $00EB74
        DC.W    $0000,$0000         ; $00EB78 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EB7C ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EB80 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EB84 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EB88 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EB8C ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EB90 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EB94 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EB98 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EB9C ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EBA0 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EBA4 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EBA8 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EBAC ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EBB0 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EBB4 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EBB8 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EBBC ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EBC0 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EBC4 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EBC8 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EBCC ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EBD0 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EBD4 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EBD8 ORI.B  #$0000,D0
        OR.B   D0,D0                            ; $00EBDC
        OR.B   -(A1),D2                         ; $00EBDE
        OR.W   D2,D4                            ; $00EBE0
        OR.W   -(A3),D6                         ; $00EBE2
        SUB.L  D4,D0                            ; $00EBE4
        SUB.L  -(A5),D2                         ; $00EBE6
        SUBA.W  D6,A4                           ; $00EBE8
        SUBA.W  -(A7),A6                        ; $00EBEA
        MOVE.L  A0,-(A0)                        ; $00EBEC
        MOVE.L  -$56B6(A1),-(A2)                ; $00EBEE
        MOVE.L  -$4E74(A3),-$4A53(A6)           ; $00EBF2
        CMPA.L  A6,A4                           ; $00EBF8
        CMPA.L  -$3DF0(A7),A6                   ; $00EBFA
        AND.B  $52(A1,A4.L),D3                  ; $00EBFE
        AND.W  -$6C(A3,A5.W),D7                 ; $00EC02
        ADD.L  -$2A(A5,A5.L),D3                 ; $00EC06
        ADDA.W  $18(A7,A6.W),A7                 ; $00EC0A
        ROL.B  D3,D1                            ; $00EC0E
        ROL.W  #5,D2                            ; $00EC10
        ROL.W  D7,D3                            ; $00EC12
        MOVE.W  (A4)+,-$43(A1,A7.W)             ; $00EC14
        DC.W    $FBDE               ; $00EC18 MOVE.W  (A6)+,<EA:3D>
        DC.W    $FFFF               ; $00EC1A MOVE.W  <EA:3F>,<EA:3F>
        SUB.W  -(A0),D0                         ; $00EC1C
        SUB.L  D1,D2                            ; $00EC1E
        SUBA.W  D3,A6                           ; $00EC20
        MOVE.L  -(A4),(A2)+                     ; $00EC22
        MOVE.L  -(A6),-(A6)                     ; $00EC24
        MOVEA.L -(A1),A6                        ; $00EC26
        CMP.L  D2,D0                            ; $00EC28
        CMP.L  -(A3),D2                         ; $00EC2A
        CMPA.W  D4,A4                           ; $00EC2C
        CMPA.W  -(A5),A6                        ; $00EC2E
        AND.B  D0,D6                            ; $00EC30
        OR.B   A2,D0                            ; $00EC32
        OR.B   A4,D0                            ; $00EC34
        OR.B   A6,D0                            ; $00EC36
        OR.B   (A0),D0                          ; $00EC38
        OR.B   $72(A1,A0.L),D2                  ; $00EC3A
        SUB.L  -$0C(A3,A1.L),D2                 ; $00EC3E
        OR.B   D0,D0                            ; $00EC42
        OR.B   D0,D0                            ; $00EC44
        OR.B   D0,D0                            ; $00EC46
        OR.B   D0,D0                            ; $00EC48
        OR.B   D0,D0                            ; $00EC4A
        OR.B   D0,D0                            ; $00EC4C
        OR.B   D0,D0                            ; $00EC4E
        OR.B   D0,D0                            ; $00EC50
        OR.B   D0,D0                            ; $00EC52
        OR.B   D0,D0                            ; $00EC54
        OR.B   D0,D0                            ; $00EC56
        OR.B   D0,D0                            ; $00EC58
        OR.B   D0,D0                            ; $00EC5A
        OR.B   D0,D0                            ; $00EC5C
        OR.B   D0,D0                            ; $00EC5E
        OR.B   D0,D0                            ; $00EC60
        OR.B   D0,D0                            ; $00EC62
        OR.B   D0,D0                            ; $00EC64
        OR.W   -(A0),D6                         ; $00EC66
        OR.W   D0,D4                            ; $00EC68
        OR.B   D0,D0                            ; $00EC6A
        OR.W   D0,D4                            ; $00EC6C
        SUB.L  D0,D0                            ; $00EC6E
        SUBA.W  D1,A4                           ; $00EC70
        MOVE.L  D3,-(A0)                        ; $00EC72
        MOVE.L  D5,$0000(A4)                    ; $00EC74
        DC.W    $0000,$0000         ; $00EC78 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EC7C ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EC80 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EC84 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EC88 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EC8C ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EC90 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EC94 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EC98 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EC9C ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ECA0 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ECA4 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ECA8 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ECAC ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ECB0 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ECB4 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ECB8 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ECBC ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ECC0 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ECC4 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ECC8 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ECCC ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ECD0 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ECD4 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ECD8 ORI.B  #$0000,D0
        OR.B   D0,D0                            ; $00ECDC
        OR.B   -(A1),D2                         ; $00ECDE
        OR.W   D2,D4                            ; $00ECE0
        OR.W   -(A3),D6                         ; $00ECE2
        SUB.L  D4,D0                            ; $00ECE4
        SUB.L  -(A5),D2                         ; $00ECE6
        SUBA.W  D6,A4                           ; $00ECE8
        SUBA.W  -(A7),A6                        ; $00ECEA
        MOVE.L  A0,-(A0)                        ; $00ECEC
        MOVE.L  -$56B6(A1),-(A2)                ; $00ECEE
        MOVE.L  -$4E74(A3),-$4A53(A6)           ; $00ECF2
        CMPA.L  A6,A4                           ; $00ECF8
        CMPA.L  -$3DF0(A7),A6                   ; $00ECFA
        AND.B  $52(A1,A4.L),D3                  ; $00ECFE
        AND.W  -$6C(A3,A5.W),D7                 ; $00ED02
        ADD.L  -$2A(A5,A5.L),D3                 ; $00ED06
        ADDA.W  $18(A7,A6.W),A7                 ; $00ED0A
        ROL.B  D3,D1                            ; $00ED0E
        ROL.W  #5,D2                            ; $00ED10
        ROL.W  D7,D3                            ; $00ED12
        MOVE.W  (A4)+,-$43(A1,A7.W)             ; $00ED14
        DC.W    $FBDE               ; $00ED18 MOVE.W  (A6)+,<EA:3D>
        DC.W    $FFFF               ; $00ED1A MOVE.W  <EA:3F>,<EA:3F>
        SUB.W  -(A0),D0                         ; $00ED1C
        SUB.L  D1,D2                            ; $00ED1E
        SUBA.W  D3,A6                           ; $00ED20
        MOVE.L  -(A4),(A2)+                     ; $00ED22
        MOVE.L  -(A6),-(A6)                     ; $00ED24
        OR.B   A1,D0                            ; $00ED26
        OR.B   A3,D0                            ; $00ED28
        OR.B   A5,D0                            ; $00ED2A
        OR.B   (A0),D0                          ; $00ED2C
        OR.W   (A2),D4                          ; $00ED2E
        OR.W   -$2C(A3,A1.L),D6                 ; $00ED30
        MOVE.L  $00(A5,A3.L),-(A2)              ; $00ED34
        AND.B  D0,D2                            ; $00ED38
        AND.W  D0,D6                            ; $00ED3A
        ADD.L  D2,D2                            ; $00ED3C
        ASR.W  -(A5)                            ; $00ED3E
        ASL.B  D4,D7                            ; $00ED40
        OR.B   D0,D0                            ; $00ED42
        OR.B   D0,D0                            ; $00ED44
        OR.B   D0,D0                            ; $00ED46
        OR.B   D0,D0                            ; $00ED48
        OR.B   D0,D0                            ; $00ED4A
        OR.B   D0,D0                            ; $00ED4C
        OR.B   D0,D0                            ; $00ED4E
        OR.B   D0,D0                            ; $00ED50
        OR.B   D0,D0                            ; $00ED52
        OR.B   D0,D0                            ; $00ED54
        OR.B   D0,D0                            ; $00ED56
        OR.B   D0,D0                            ; $00ED58
        OR.B   D0,D0                            ; $00ED5A
        OR.B   D0,D0                            ; $00ED5C
        OR.B   D0,D0                            ; $00ED5E
        OR.B   D0,D0                            ; $00ED60
        OR.B   D0,D0                            ; $00ED62
        OR.B   D0,D0                            ; $00ED64
        OR.W   -(A0),D6                         ; $00ED66
        OR.W   D0,D4                            ; $00ED68
        OR.B   D0,D0                            ; $00ED6A
        OR.W   D0,D4                            ; $00ED6C
        SUB.L  D0,D0                            ; $00ED6E
        SUBA.W  D1,A4                           ; $00ED70
        MOVE.L  D3,-(A0)                        ; $00ED72
        MOVE.L  D5,$0000(A4)                    ; $00ED74
        DC.W    $0000,$0000         ; $00ED78 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ED7C ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ED80 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ED84 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ED88 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ED8C ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ED90 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ED94 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ED98 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00ED9C ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EDA0 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EDA4 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EDA8 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EDAC ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EDB0 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EDB4 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EDB8 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EDBC ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EDC0 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EDC4 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EDC8 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EDCC ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EDD0 ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00EDD4 ORI.B  #$0000,D0
        DC.W    $0000,$207C         ; $00EDD8 ORI.B  #$207C,D0
        ADDI.B  #$D100,D3                       ; $00EDDC
        MOVEA.L #$04004C68,A1                   ; $00EDE0
        MOVE.W  #$0070,D0                       ; $00EDE6
        MOVE.W  #$0010,D1                       ; $00EDEA
        JSR     loc_00E35A(PC)                  ; $00EDEE
loc_00EDF2:
        TST.B  $00A15120                        ; $00EDF2
        BNE.S  loc_00EDF2                       ; $00EDF8
        BSR.W  loc_00EF32                       ; $00EDFA
        MOVEA.L #$0603D800,A0                   ; $00EDFE
        MOVEA.L #$0401985C,A1                   ; $00EE04
        MOVE.W  #$0088,D0                       ; $00EE0A
        MOVE.W  #$0010,D1                       ; $00EE0E
        JSR     loc_00E35A(PC)                  ; $00EE12
        CLR.W  D0                               ; $00EE16
        MOVE.B  $A01A.W,D0                      ; $00EE18
        BSR.W  loc_00E52C                       ; $00EE1C
        JSR     $00B684(PC)                     ; $00EE20
        JSR     $00B6DA(PC)                     ; $00EE24
        CMPI.W  #$0001,$A020.W                  ; $00EE28
        BEQ.W  loc_00EEBA                       ; $00EE2E
        CMPI.W  #$0002,$A020.W                  ; $00EE32
        BEQ.W  loc_00EECA                       ; $00EE38
        MOVE.W  $C86C.W,D1                      ; $00EE3C
        DC.W    $0201,$00E0         ; $00EE40 ANDI.B  #$00E0,D1
        BNE.S  loc_00EE5C                       ; $00EE44
        MOVE.W  $C86C.W,D1                      ; $00EE46
        DC.W    $0201,$0010         ; $00EE4A ANDI.B  #$0010,D1
        BNE.S  loc_00EE58                       ; $00EE4E
        SUBQ.W  #4,$C87E.W                      ; $00EE50
        BRA.W  loc_00EEE2                       ; $00EE54
loc_00EE58:
        ST      $A018.W                         ; $00EE58
loc_00EE5C:
        MOVE.B  #$00A8,$C8A4.W                  ; $00EE5C
        TST.B  $A01A.W                          ; $00EE62
        BNE.S  loc_00EE72                       ; $00EE66
        MOVE.B  $A019.W,$A01E.W                 ; $00EE68
        BRA.W  loc_00EE78                       ; $00EE6E
loc_00EE72:
        MOVE.B  $A019.W,$A01D.W                 ; $00EE72
loc_00EE78:
        TST.B  $A01F.W                          ; $00EE78
        BNE.S  loc_00EE8C                       ; $00EE7C
        MOVE.B  $A01E.W,$FEB1.W                 ; $00EE7E
        MOVE.B  $A01D.W,$FEA9.W                 ; $00EE84
        BRA.S  loc_00EE98                       ; $00EE8A
loc_00EE8C:
        MOVE.B  $A01E.W,$FEB2.W                 ; $00EE8C
        MOVE.B  $A01D.W,$FEAA.W                 ; $00EE92
loc_00EE98:
        MOVE.B  #$0001,$C809.W                  ; $00EE98
        MOVE.B  #$0001,$C80A.W                  ; $00EE9E
        BSET    #7,$C80E.W                      ; $00EEA4
        MOVE.B  #$0001,$C802.W                  ; $00EEAA
        MOVE.W  #$0002,$A020.W                  ; $00EEB0
        BRA.W  loc_00EEDE                       ; $00EEB6
loc_00EEBA:
        BTST    #6,$C80E.W                      ; $00EEBA
        BNE.S  loc_00EEDE                       ; $00EEC0
        CLR.W  $A020.W                          ; $00EEC2
        BRA.W  loc_00EEDE                       ; $00EEC6
loc_00EECA:
        BTST    #7,$C80E.W                      ; $00EECA
        BNE.S  loc_00EEDE                       ; $00EED0
        CLR.W  $A020.W                          ; $00EED2
        ADDQ.W  #4,$C87E.W                      ; $00EED6
        BRA.W  loc_00EEE2                       ; $00EEDA
loc_00EEDE:
        SUBQ.W  #4,$C87E.W                      ; $00EEDE
loc_00EEE2:
        DC.W    $33FC,$0018,$00FF,$0008; $00EEE2 MOVE.W  #$0018,$00FF0008
        MOVE.B  #$0001,$C821.W                  ; $00EEEA
        RTS                                     ; $00EEF0
loc_00EEF2:
        TST.B  $00A15120                        ; $00EEF2
        BNE.S  loc_00EEF2                       ; $00EEF8
        CLR.B  $00A15123                        ; $00EEFA
        MOVE.W  #$0000,$C87E.W                  ; $00EF00
        DC.W    $23FC,$0089,$26D2,$00FF,$0002; $00EF06 MOVE.L  #$008926D2,$00FF0002
        TST.B  $A018.W                          ; $00EF10
        BNE.S  loc_00EF30                       ; $00EF14
        DC.W    $23FC,$0088,$D4A4,$00FF,$0002; $00EF16 MOVE.L  #$0088D4A4,$00FF0002
        TST.B  $A01F.W                          ; $00EF20
        BNE.S  loc_00EF30                       ; $00EF24
        DC.W    $23FC,$0088,$D48A,$00FF,$0002; $00EF26 MOVE.L  #$0088D48A,$00FF0002
loc_00EF30:
        RTS                                     ; $00EF30
loc_00EF32:
        MOVEQ   #$00,D0                         ; $00EF32
        TST.B  $A01A.W                          ; $00EF34
        BNE.S  loc_00EF40                       ; $00EF38
        MOVE.B  $A019.W,D0                      ; $00EF3A
        BRA.S  loc_00EF44                       ; $00EF3E
loc_00EF40:
        MOVE.B  $A01E.W,D0                      ; $00EF40
loc_00EF44:
        LEA     $0088EFA4,A1                    ; $00EF44
        ADD.W  D0,D0                            ; $00EF4A
        MOVE.W  D0,D1                           ; $00EF4C
        ADD.W  D0,D0                            ; $00EF4E
        ADD.W  D1,D0                            ; $00EF50
        MOVEA.L $00(A1,D0.W),A0                 ; $00EF52
        MOVE.W  $04(A1,D0.W),D0                 ; $00EF56
        MOVE.W  #$0030,D1                       ; $00EF5A
        MOVE.W  #$0010,D2                       ; $00EF5E
        JSR     loc_00E3B4(PC)                  ; $00EF62
        MOVEQ   #$00,D0                         ; $00EF66
        TST.B  $A01A.W                          ; $00EF68
        BEQ.S  loc_00EF74                       ; $00EF6C
        MOVE.B  $A019.W,D0                      ; $00EF6E
        BRA.S  loc_00EF78                       ; $00EF72
loc_00EF74:
        MOVE.B  $A01D.W,D0                      ; $00EF74
loc_00EF78:
        LEA     $0088EFB6,A1                    ; $00EF78
        ADD.W  D0,D0                            ; $00EF7E
        MOVE.W  D0,D1                           ; $00EF80
        ADD.W  D0,D0                            ; $00EF82
        ADD.W  D1,D0                            ; $00EF84
        MOVEA.L $00(A1,D0.W),A0                 ; $00EF86
        MOVE.W  $04(A1,D0.W),D0                 ; $00EF8A
        MOVE.W  #$0018,D1                       ; $00EF8E
        MOVE.W  #$0010,D2                       ; $00EF92
loc_00EF96:
        TST.B  $00A15120                        ; $00EF96
        BNE.S  loc_00EF96                       ; $00EF9C
        JSR     loc_00E3B4(PC)                  ; $00EF9E
        RTS                                     ; $00EFA2
        SUBI.B  #$2010,D1                       ; $00EFA4
        ORI.W  #$0401,-(A0)                     ; $00EFA8
        MOVEA.L $0061(A7),A0                    ; $00EFAC
        SUBI.B  #$20CF,D1                       ; $00EFB0
        ORI.W  #$0401,-(A1)                     ; $00EFB4
        CMP.B  (A0),D0                          ; $00EFB8
        ORI.L  #$0401B0A0,(A1)                  ; $00EFBA
        ORI.L  #$43F900FF,(A0)                  ; $00EFC0
        BSR.W  $012344                          ; $00EFC6
        DC.W    $0001,$0000         ; $00EFCA ORI.B  #$0000,D1
        MOVE.W  #$0000,$0002(A1)                ; $00EFCE
        DC.W    $3379,$00FF,$2002,$0004; $00EFD4 MOVE.W  $00FF2002,$0004(A1)
        DC.W    $3379,$00FF,$2004,$0006; $00EFDC MOVE.W  $00FF2004,$0006(A1)
        DC.W    $3379,$00FF,$2000,$0008; $00EFE4 MOVE.W  $00FF2000,$0008(A1)
        MOVE.W  D0,$000A(A1)                    ; $00EFEC
        MOVE.W  #$0000,$000C(A1)                ; $00EFF0
        MOVE.W  #$0000,$000E(A1)                ; $00EFF6
        DC.W    $237C,$222B,$DAE6,$0010; $00EFFC MOVE.L  #$222BDAE6,$0010(A1)
        ADDA.L  #$00000014,A1                   ; $00F004
        DC.W    $33FC,$0044,$00A1,$5110; $00F00A MOVE.W  #$0044,$00A15110
        DC.W    $13FC,$0004,$00A1,$5107; $00F012 MOVE.B  #$0004,$00A15107
loc_00F01A:
        TST.B  $00A15120                        ; $00F01A
        BNE.S  loc_00F01A                       ; $00F020
        DC.W    $13FC,$002A,$00A1,$5121; $00F022 MOVE.B  #$002A,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $00F02A MOVE.B  #$0001,$00A15120
        RTS                                     ; $00F032
        MOVE.L  $1450(A0),D1                    ; $00F034
        MOVE.L  $155A(A0),D1                    ; $00F038
        MOVE.L  $1664(A0),D1                    ; $00F03C
        LEA     $00FF6100,A1                    ; $00F040
        MOVE.W  #$0001,$0000(A1)                ; $00F046
        MOVE.W  #$0000,$0002(A1)                ; $00F04C
        DC.W    $3379,$00FF,$2008,$0004; $00F052 MOVE.W  $00FF2008,$0004(A1)
        DC.W    $3379,$00FF,$200A,$0006; $00F05A MOVE.W  $00FF200A,$0006(A1)
        DC.W    $3379,$00FF,$2006,$0008; $00F062 MOVE.W  $00FF2006,$0008(A1)
        MOVE.W  D0,$000A(A1)                    ; $00F06A
        MOVE.W  #$0000,$000C(A1)                ; $00F06E
        MOVE.W  #$0000,$000E(A1)                ; $00F074
        DC.W    $237C,$222B,$EA76,$0010; $00F07A MOVE.L  #$222BEA76,$0010(A1)
        ADDA.L  #$00000014,A1                   ; $00F082
        DC.W    $33FC,$0044,$00A1,$5110; $00F088 MOVE.W  #$0044,$00A15110
        DC.W    $13FC,$0004,$00A1,$5107; $00F090 MOVE.B  #$0004,$00A15107
loc_00F098:
        TST.B  $00A15120                        ; $00F098
        BNE.S  loc_00F098                       ; $00F09E
        DC.W    $13FC,$002A,$00A1,$5121; $00F0A0 MOVE.B  #$002A,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $00F0A8 MOVE.B  #$0001,$00A15120
        RTS                                     ; $00F0B0
        MOVE.L  $4FAA(A0),D1                    ; $00F0B2
        MOVE.L  $506C(A0),D1                    ; $00F0B6
        MOVE.L  $512E(A0),D1                    ; $00F0BA
        LEA     $00FF6100,A1                    ; $00F0BE
        MOVE.W  #$0001,$0000(A1)                ; $00F0C4
        MOVE.W  #$0000,$0002(A1)                ; $00F0CA
        DC.W    $3379,$00FF,$200E,$0004; $00F0D0 MOVE.W  $00FF200E,$0004(A1)
        DC.W    $3379,$00FF,$2010,$0006; $00F0D8 MOVE.W  $00FF2010,$0006(A1)
        DC.W    $3379,$00FF,$200C,$0008; $00F0E0 MOVE.W  $00FF200C,$0008(A1)
        MOVE.W  D0,$000A(A1)                    ; $00F0E8
        MOVE.W  #$0000,$000C(A1)                ; $00F0EC
        MOVE.W  #$0000,$000E(A1)                ; $00F0F2
        DC.W    $237C,$222B,$F710,$0010; $00F0F8 MOVE.L  #$222BF710,$0010(A1)
        ADDA.L  #$00000014,A1                   ; $00F100
        DC.W    $33FC,$0044,$00A1,$5110; $00F106 MOVE.W  #$0044,$00A15110
        DC.W    $13FC,$0004,$00A1,$5107; $00F10E MOVE.B  #$0004,$00A15107
loc_00F116:
        TST.B  $00A15120                        ; $00F116
        BNE.S  loc_00F116                       ; $00F11C
        DC.W    $13FC,$002A,$00A1,$5121; $00F11E MOVE.B  #$002A,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $00F126 MOVE.B  #$0001,$00A15120
        RTS                                     ; $00F12E
        MOVE.L  -$7E66(A0),D1                   ; $00F130
        MOVE.L  -$7DA4(A0),D1                   ; $00F134
        MOVE.L  -$7CE2(A0),D1                   ; $00F138
        BCLR    #7,$FDA8.W                      ; $00F13C
        DC.W    $33FC,$002C,$00FF,$0008; $00F142 MOVE.W  #$002C,$00FF0008
        MOVE.W  #$002C,$C87A.W                  ; $00F14A
        BCLR    #6,$C875.W                      ; $00F150
        MOVE.W  $C874.W,(A5)                    ; $00F156
        DC.W    $33FC,$0083,$00A1,$5100; $00F15A MOVE.W  #$0083,$00A15100
        DC.W    $0239,$00FC,$00A1,$5181; $00F162 ANDI.B  #$00FC,$00A15181
        JSR     $008826C8                       ; $00F16A
        MOVE.L  #$000A0907,D0                   ; $00F170
        JSR     $008814BE                       ; $00F176
        MOVE.B  #$0001,$C80D.W                  ; $00F17C
        MOVEQ   #$00,D0                         ; $00F182
        LEA     $8480.W,A0                      ; $00F184
        MOVEQ   #$1F,D1                         ; $00F188
loc_00F18A:
        MOVE.L  D0,(A0)+                        ; $00F18A
        DBRA    D1,loc_00F18A                   ; $00F18C
        LEA     $00FF7B80,A0                    ; $00F190
        MOVEQ   #$7F,D1                         ; $00F196
loc_00F198:
        MOVE.L  D0,(A0)+                        ; $00F198
        DBRA    D1,loc_00F198                   ; $00F19A
        MOVE.L  #$60000002,(A5)                 ; $00F19E
        MOVE.W  #$17FF,D1                       ; $00F1A4
loc_00F1A8:
        MOVE.L  D0,(A6)                         ; $00F1A8
        DBRA    D1,loc_00F1A8                   ; $00F1AA
        JSR     $008849AA                       ; $00F1AE
        CLR.W  $C880.W                          ; $00F1B4
        CLR.W  $C882.W                          ; $00F1B8
        CLR.W  $8000.W                          ; $00F1BC
        CLR.W  $8002.W                          ; $00F1C0
        CLR.W  $A012.W                          ; $00F1C4
        CLR.B  $A018.W                          ; $00F1C8
        JSR     $008849AA                       ; $00F1CC
        DC.W    $21FC,$008B,$B4FC,$C96C; $00F1D2 MOVE.L  #$008BB4FC,$C96C.W
        MOVE.B  #$0001,$C809.W                  ; $00F1DA
        MOVE.B  #$0001,$C80A.W                  ; $00F1E0
        BSET    #6,$C80E.W                      ; $00F1E6
        MOVE.B  #$0001,$C802.W                  ; $00F1EC
        MOVE.W  #$0001,$A024.W                  ; $00F1F2
        LEA     $00FF1000,A0                    ; $00F1F8
        MOVE.W  #$037F,D0                       ; $00F1FE
loc_00F202:
        CLR.L  (A0)+                            ; $00F202
        DBRA    D0,loc_00F202                   ; $00F204
        MOVE.W  #$0001,D0                       ; $00F208
        MOVE.W  #$0001,D1                       ; $00F20C
        MOVE.W  #$0001,D2                       ; $00F210
        MOVE.W  #$0026,D3                       ; $00F214
        MOVE.W  #$0009,D4                       ; $00F218
        LEA     $00FF1000,A0                    ; $00F21C
        JSR     loc_00E22C(PC)                  ; $00F222
        MOVE.W  #$0002,D0                       ; $00F226
        MOVE.W  #$0001,D1                       ; $00F22A
        MOVE.W  #$000B,D2                       ; $00F22E
        MOVE.W  #$0013,D3                       ; $00F232
        MOVE.W  #$0010,D4                       ; $00F236
        LEA     $00FF1000,A0                    ; $00F23A
        JSR     loc_00E22C(PC)                  ; $00F240
        MOVE.W  #$0003,D0                       ; $00F244
        MOVE.W  #$0014,D1                       ; $00F248
        MOVE.W  #$000B,D2                       ; $00F24C
        MOVE.W  #$0013,D3                       ; $00F250
        MOVE.W  #$0010,D4                       ; $00F254
        LEA     $00FF1000,A0                    ; $00F258
        JSR     loc_00E22C(PC)                  ; $00F25E
        LEA     $00FF1000,A0                    ; $00F262
        JSR     loc_00E2F0(PC)                  ; $00F268
        JSR     $00E1BC(PC)                     ; $00F26C
        DC.W    $08B9,$0007,$00A1,$5181; $00F270 BCLR    #7,$00A15181
        LEA     $00FF6E00,A0                    ; $00F278
        ADDA.L  #$00000160,A0                   ; $00F27E
        LEA     $0088F39C,A1                    ; $00F284
        MOVE.W  #$003F,D0                       ; $00F28A
loc_00F28E:
        MOVE.W  (A1)+,D1                        ; $00F28E
        BSET    #15,D1                          ; $00F290
        MOVE.W  D1,(A0)+                        ; $00F294
        DBRA    D0,loc_00F28E                   ; $00F296
        LEA     $000E9680,A0                    ; $00F29A
        MOVEA.L #$06038000,A1                   ; $00F2A0
        JSR     loc_00E316(PC)                  ; $00F2A6
        LEA     $000E9F60,A0                    ; $00F2AA
        MOVEA.L #$0603B600,A1                   ; $00F2B0
        JSR     loc_00E316(PC)                  ; $00F2B6
        LEA     $000EA080,A0                    ; $00F2BA
        MOVEA.L #$0603BC00,A1                   ; $00F2C0
        JSR     loc_00E316(PC)                  ; $00F2C6
        LEA     $000EA240,A0                    ; $00F2CA
        MOVEA.L #$0603C400,A1                   ; $00F2D0
        JSR     loc_00E316(PC)                  ; $00F2D6
        LEA     $000EA340,A0                    ; $00F2DA
        MOVEA.L #$0603C880,A1                   ; $00F2E0
        JSR     loc_00E316(PC)                  ; $00F2E6
        LEA     $000E90A0,A0                    ; $00F2EA
        MOVEA.L #$0603D780,A1                   ; $00F2F0
        JSR     loc_00E316(PC)                  ; $00F2F6
        LEA     $000EA5F0,A0                    ; $00F2FA
        MOVEA.L #$0603DE80,A1                   ; $00F300
        JSR     loc_00E316(PC)                  ; $00F306
        LEA     $000EA710,A0                    ; $00F30A
        MOVEA.L #$0603F200,A1                   ; $00F310
        JSR     loc_00E316(PC)                  ; $00F316
        MOVE.B  $A01F.W,$A019.W                 ; $00F31A
        CLR.B  $A01B.W                          ; $00F320
        MOVE.B  $FEB3.W,$A019.W                 ; $00F324
        MOVE.B  $FEB0.W,$A01A.W                 ; $00F32A
        MOVE.B  #$0001,$A01C.W                  ; $00F330
        MOVE.B  $FEAF.W,$A020.W                 ; $00F336
        MOVE.B  $FEB0.W,$A022.W                 ; $00F33C
        MOVE.B  $FEAD.W,$A021.W                 ; $00F342
        MOVE.B  $FEAE.W,$A023.W                 ; $00F348
        JSR     $0088204A                       ; $00F34E
        DC.W    $0239,$00FC,$00A1,$5181; $00F354 ANDI.B  #$00FC,$00A15181
        DC.W    $0039,$0001,$00A1,$5181; $00F35C ORI.B  #$0001,$00A15181
        DC.W    $33FC,$8083,$00A1,$5100; $00F364 MOVE.W  #$8083,$00A15100
        BSET    #6,$C875.W                      ; $00F36C
        MOVE.W  $C874.W,(A5)                    ; $00F372
        DC.W    $33FC,$0020,$00FF,$0008; $00F376 MOVE.W  #$0020,$00FF0008
        JSR     $00884998                       ; $00F37E
        MOVE.W  #$0000,$C87E.W                  ; $00F384
        DC.W    $23FC,$0088,$F41C,$00FF,$0002; $00F38A MOVE.L  #$0088F41C,$00FF0002
        MOVE.B  #$0081,$C8A5.W                  ; $00F394
        RTS                                     ; $00F39A
        NEG.B  D0                               ; $00F39C
        NEG.L  -(A3)                            ; $00F39E
        DC.W    $4946               ; $00F3A0 DC.W    $4946
        LEA     $1C00(A1),A6                    ; $00F3A2
        MOVE.L  -(A3),(A4)                      ; $00F3A6
        MOVE.W  D6,$41E9(A2)                    ; $00F3A8
        DC.W    $7FFF               ; $00F3AC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F3AE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F3B0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F3B2 MOVE.W  <EA:3F>,<EA:3F>
        MOVE.B  D0,D6                           ; $00F3B4
        MOVE.L  -(A3),(A4)                      ; $00F3B6
        MOVE.W  D6,$41E9(A2)                    ; $00F3B8
        NEG.B  D0                               ; $00F3BC
        NEG.L  -(A3)                            ; $00F3BE
        DC.W    $4946               ; $00F3C0 DC.W    $4946
        LEA     $7FFF(A1),A6                    ; $00F3C2
        BLS.S  loc_00F3BD                       ; $00F3C6
        DC.W    $7FFF               ; $00F3C8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F3CA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $0010,$14AF         ; $00F3CC ORI.B  #$14AF,(A0)
        MOVE.L  A6,$3DED(A4)                    ; $00F3D0
        DC.W    $7FFF               ; $00F3D4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F3D6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F3D8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F3DA MOVE.W  <EA:3F>,<EA:3F>
        MOVE.W  $7BBC(PC),-$66(A3,D7.W)         ; $00F3DC
        MOVE.W  #$6B36,$37(A3,D6.L)             ; $00F3E2
        BLE.S  loc_00F442                       ; $00F3E8
        BLE.S  loc_00F465                       ; $00F3EA
        MOVE.W  (A2)+,-$18(A1,D6.W)             ; $00F3EC
        DC.W    $7FFF               ; $00F3F0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F3F2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F3F4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F3F6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F3F8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F3FA MOVE.W  <EA:3F>,<EA:3F>
        MOVE.W  #$7F7A,-$22(A7,D7.L)            ; $00F3FC
        MOVE.W  (A3)+,$45(A7,D4.W)              ; $00F402
        SUBQ.B  #8,$6212(A3)                    ; $00F406
        BGT.S  loc_00F404                       ; $00F40A
        DC.W    $7FFF               ; $00F40C MOVE.W  <EA:3F>,<EA:3F>
        BTST    D1,(A7)+                        ; $00F40E
        DC.W    $7FFF               ; $00F410 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F412 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F414 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F416 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F418 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00F41A MOVE.W  <EA:3F>,<EA:3F>
        JSR     $00882080                       ; $00F41C
        MOVE.W  $C87E.W,D0                      ; $00F422
        MOVEA.L $04(PC,D0.W),A1                 ; $00F426
        JMP     (A1)                            ; $00F42A
        ORI.L  #$F44C0088,A0                    ; $00F42C
        MOVE.W  -(A2),(A3)+                     ; $00F432
        ORI.L  #$F85C4EBA,A0                    ; $00F434
        AND.W  A2,D1                            ; $00F43A
        BTST    #6,$C80E.W                      ; $00F43C
loc_00F442:
        BNE.S  loc_00F44A                       ; $00F442
        ADDQ.W  #4,$C87E.W                      ; $00F444
        NOP                                     ; $00F448
loc_00F44A:
        RTS                                     ; $00F44A
        CLR.W  D0                               ; $00F44C
        MOVE.B  $A01B.W,D0                      ; $00F44E
        BSR.W  loc_00F88C                       ; $00F452
        JSR     $0088179E                       ; $00F456
        TST.W  $A024.W                          ; $00F45C
        BNE.W  loc_00F642                       ; $00F460
        MOVE.B  $A019.W,D0                      ; $00F464
        MOVE.W  $C86C.W,D1                      ; $00F468
        BTST    #3,D1                           ; $00F46C
        BEQ.S  loc_00F4BA                       ; $00F470
        MOVE.B  #$00A9,$C8A4.W                  ; $00F472
        TST.B  $A01B.W                          ; $00F478
        BEQ.W  loc_00F498                       ; $00F47C
        CMPI.B  #$0001,$A01B.W                  ; $00F480
        BEQ.W  loc_00F4A6                       ; $00F486
        CMPI.B  #$0004,D0                       ; $00F48A
        BLT.W  loc_00F4B4                       ; $00F48E
        CLR.B  D0                               ; $00F492
        BRA.W  loc_00F57A                       ; $00F494
loc_00F498:
        CMPI.B  #$0002,D0                       ; $00F498
        BLT.W  loc_00F4B4                       ; $00F49C
        CLR.B  D0                               ; $00F4A0
        BRA.W  loc_00F57A                       ; $00F4A2
loc_00F4A6:
        CMPI.B  #$0001,D0                       ; $00F4A6
        BLT.W  loc_00F4B4                       ; $00F4AA
        CLR.B  D0                               ; $00F4AE
        BRA.W  loc_00F57A                       ; $00F4B0
loc_00F4B4:
        ADDQ.B  #1,D0                           ; $00F4B4
        BRA.W  loc_00F57A                       ; $00F4B6
loc_00F4BA:
        BTST    #2,D1                           ; $00F4BA
        BEQ.S  loc_00F4FC                       ; $00F4BE
        MOVE.B  #$00A9,$C8A4.W                  ; $00F4C0
        TST.B  D0                               ; $00F4C6
        BLE.W  loc_00F4D2                       ; $00F4C8
        SUBQ.B  #1,D0                           ; $00F4CC
        BRA.W  loc_00F57A                       ; $00F4CE
loc_00F4D2:
        TST.B  $A01B.W                          ; $00F4D2
        BEQ.W  loc_00F4EC                       ; $00F4D6
        CMPI.B  #$0001,$A01B.W                  ; $00F4DA
        BEQ.W  loc_00F4F4                       ; $00F4E0
        MOVE.B  #$0004,D0                       ; $00F4E4
        BRA.W  loc_00F57A                       ; $00F4E8
loc_00F4EC:
        MOVE.B  #$0002,D0                       ; $00F4EC
        BRA.W  loc_00F57A                       ; $00F4F0
loc_00F4F4:
        MOVE.B  #$0001,D0                       ; $00F4F4
        BRA.W  loc_00F57A                       ; $00F4F8
loc_00F4FC:
        BTST    #0,D1                           ; $00F4FC
        BEQ.W  loc_00F53C                       ; $00F500
        TST.B  $A01B.W                          ; $00F504
        BEQ.W  loc_00F57A                       ; $00F508
        MOVE.B  #$00A9,$C8A4.W                  ; $00F50C
        CMPI.B  #$0001,$A01B.W                  ; $00F512
        BEQ.S  loc_00F52C                       ; $00F518
        MOVE.B  #$0001,$A01B.W                  ; $00F51A
        MOVE.B  D0,$A021.W                      ; $00F520
        MOVE.B  $A020.W,D0                      ; $00F524
        BRA.W  loc_00F57A                       ; $00F528
loc_00F52C:
        CLR.B  $A01B.W                          ; $00F52C
        MOVE.B  D0,$A020.W                      ; $00F530
        MOVE.B  $A01F.W,D0                      ; $00F534
        BRA.W  loc_00F57A                       ; $00F538
loc_00F53C:
        BTST    #1,D1                           ; $00F53C
        BEQ.W  loc_00F57A                       ; $00F540
        CMPI.B  #$0002,$A01B.W                  ; $00F544
        BGE.W  loc_00F57A                       ; $00F54A
        MOVE.B  #$00A9,$C8A4.W                  ; $00F54E
        TST.B  $A01B.W                          ; $00F554
        BEQ.S  loc_00F56C                       ; $00F558
        MOVE.B  #$0002,$A01B.W                  ; $00F55A
        MOVE.B  D0,$A020.W                      ; $00F560
        MOVE.B  $A021.W,D0                      ; $00F564
        BRA.W  loc_00F57A                       ; $00F568
loc_00F56C:
        MOVE.B  #$0001,$A01B.W                  ; $00F56C
        MOVE.B  D0,$A01F.W                      ; $00F572
        MOVE.B  $A020.W,D0                      ; $00F576
loc_00F57A:
        MOVE.B  D0,$A019.W                      ; $00F57A
        MOVE.B  $A01A.W,D0                      ; $00F57E
        MOVE.W  $C86E.W,D1                      ; $00F582
        BTST    #3,D1                           ; $00F586
        BEQ.S  loc_00F5BE                       ; $00F58A
        MOVE.B  #$00A9,$C8A4.W                  ; $00F58C
        CMPI.B  #$0001,$A01C.W                  ; $00F592
        BEQ.W  loc_00F5AA                       ; $00F598
        CMPI.B  #$0004,D0                       ; $00F59C
        BLT.W  loc_00F5B8                       ; $00F5A0
        CLR.B  D0                               ; $00F5A4
        BRA.W  loc_00F63E                       ; $00F5A6
loc_00F5AA:
        CMPI.B  #$0001,D0                       ; $00F5AA
        BLT.W  loc_00F5B8                       ; $00F5AE
        CLR.B  D0                               ; $00F5B2
        BRA.W  loc_00F63E                       ; $00F5B4
loc_00F5B8:
        ADDQ.B  #1,D0                           ; $00F5B8
        BRA.W  loc_00F63E                       ; $00F5BA
loc_00F5BE:
        BTST    #2,D1                           ; $00F5BE
        BEQ.S  loc_00F5F0                       ; $00F5C2
        MOVE.B  #$00A9,$C8A4.W                  ; $00F5C4
        TST.B  D0                               ; $00F5CA
        BLE.W  loc_00F5D6                       ; $00F5CC
        SUBQ.B  #1,D0                           ; $00F5D0
        BRA.W  loc_00F63E                       ; $00F5D2
loc_00F5D6:
        CMPI.B  #$0001,$A01C.W                  ; $00F5D6
        BEQ.W  loc_00F5E8                       ; $00F5DC
        MOVE.B  #$0004,D0                       ; $00F5E0
        BRA.W  loc_00F63E                       ; $00F5E4
loc_00F5E8:
        MOVE.B  #$0001,D0                       ; $00F5E8
        BRA.W  loc_00F63E                       ; $00F5EC
loc_00F5F0:
        BTST    #0,D1                           ; $00F5F0
        BEQ.W  loc_00F618                       ; $00F5F4
        CMPI.B  #$0001,$A01C.W                  ; $00F5F8
        BEQ.S  loc_00F63E                       ; $00F5FE
        MOVE.B  #$00A9,$C8A4.W                  ; $00F600
        MOVE.B  #$0001,$A01C.W                  ; $00F606
        MOVE.B  D0,$A023.W                      ; $00F60C
        MOVE.B  $A022.W,D0                      ; $00F610
        BRA.W  loc_00F63E                       ; $00F614
loc_00F618:
        BTST    #1,D1                           ; $00F618
        BEQ.W  loc_00F63E                       ; $00F61C
        CMPI.B  #$0002,$A01C.W                  ; $00F620
        BGE.W  loc_00F63E                       ; $00F626
        MOVE.B  #$00A9,$C8A4.W                  ; $00F62A
        MOVE.B  #$0002,$A01C.W                  ; $00F630
        MOVE.B  D0,$A022.W                      ; $00F636
        MOVE.B  $A023.W,D0                      ; $00F63A
loc_00F63E:
        MOVE.B  D0,$A01A.W                      ; $00F63E
loc_00F642:
        MOVEA.L #$06038000,A0                   ; $00F642
        MOVEA.L #$04007010,A1                   ; $00F648
        MOVE.W  #$0120,D0                       ; $00F64E
        MOVE.W  #$0030,D1                       ; $00F652
        JSR     loc_00E35A(PC)                  ; $00F656
        LEA     $0088F682,A2                    ; $00F65A
        MOVE.W  #$0007,D2                       ; $00F660
loc_00F664:
        MOVEA.L (A2)+,A0                        ; $00F664
        MOVEA.L (A2)+,A1                        ; $00F666
        MOVE.W  (A2)+,D0                        ; $00F668
        MOVE.W  (A2)+,D1                        ; $00F66A
        JSR     loc_00E35A(PC)                  ; $00F66C
        DBRA    D2,loc_00F664                   ; $00F670
        ADDQ.W  #4,$C87E.W                      ; $00F674
        DC.W    $33FC,$0020,$00FF,$0008; $00F678 MOVE.W  #$0020,$00FF0008
        RTS                                     ; $00F680
        ADDI.B  #$B600,D3                       ; $00F682
        SUBI.B  #$2024,D1                       ; $00F686
        ORI.W  #$0010,-(A0)                     ; $00F68A
        ADDI.B  #$BC00,D3                       ; $00F68E
        SUBI.B  #$4014,D1                       ; $00F692
        ORI.L  #$00100603,D0                    ; $00F696
        AND.B  D0,D2                            ; $00F69C
        SUBI.B  #$7030,D1                       ; $00F69E
        ORI.W  #$0010,A0                        ; $00F6A2
        ADDI.B  #$C880,D3                       ; $00F6A6
        SUBI.B  #$9018,D1                       ; $00F6AA
        ORI.W  #$0020,$0603.W                   ; $00F6AE
        CMP.B  D0,D3                            ; $00F6B4
        SUBI.B  #$20BC,D1                       ; $00F6B6
        ORI.W  #$0010,-(A0)                     ; $00F6BA
        ADDI.B  #$BC00,D3                       ; $00F6BE
        SUBI.B  #$40AC,D1                       ; $00F6C2
        ORI.L  #$00100603,D0                    ; $00F6C6
        AND.B  D0,D2                            ; $00F6CC
        SUBI.B  #$70C8,D1                       ; $00F6CE
        ORI.W  #$0010,A0                        ; $00F6D2
        ADDI.B  #$C880,D3                       ; $00F6D6
        SUBI.B  #$90B0,D1                       ; $00F6DA
        ORI.W  #$0020,$4A39.W                   ; $00F6DE
        ORI.L  #$512066F8,-(A1)                 ; $00F6E4
        BSR.W  loc_00F916                       ; $00F6EA
        LEA     $0088F838,A2                    ; $00F6EE
        MOVE.W  #$0002,D2                       ; $00F6F4
loc_00F6F8:
        MOVEA.L (A2)+,A0                        ; $00F6F8
        MOVEA.L (A2)+,A1                        ; $00F6FA
        MOVE.W  (A2)+,D0                        ; $00F6FC
        MOVE.W  (A2)+,D1                        ; $00F6FE
        JSR     loc_00E35A(PC)                  ; $00F700
        DBRA    D2,loc_00F6F8                   ; $00F704
        CLR.W  D0                               ; $00F708
        MOVE.B  $A01B.W,D0                      ; $00F70A
        BSR.W  loc_00F88C                       ; $00F70E
        JSR     $00B684(PC)                     ; $00F712
        JSR     $00B6DA(PC)                     ; $00F716
        CMPI.W  #$0001,$A024.W                  ; $00F71A
        BEQ.W  loc_00F7F8                       ; $00F720
        CMPI.W  #$0002,$A024.W                  ; $00F724
        BEQ.W  loc_00F80C                       ; $00F72A
        MOVE.W  $C86C.W,D1                      ; $00F72E
        DC.W    $0201,$00E0         ; $00F732 ANDI.B  #$00E0,D1
        BNE.S  loc_00F760                       ; $00F736
        MOVE.W  $C86E.W,D1                      ; $00F738
        MOVE.W  D1,D2                           ; $00F73C
        DC.W    $0202,$00E0         ; $00F73E ANDI.B  #$00E0,D2
        BNE.S  loc_00F760                       ; $00F742
        DC.W    $0201,$0010         ; $00F744 ANDI.B  #$0010,D1
        BNE.S  loc_00F75C                       ; $00F748
        MOVE.W  $C86C.W,D1                      ; $00F74A
        DC.W    $0201,$0010         ; $00F74E ANDI.B  #$0010,D1
        BNE.S  loc_00F75C                       ; $00F752
        SUBQ.W  #4,$C87E.W                      ; $00F754
        BRA.W  loc_00F828                       ; $00F758
loc_00F75C:
        ST      $A018.W                         ; $00F75C
loc_00F760:
        MOVE.B  #$00A8,$C8A4.W                  ; $00F760
        TST.B  $A01B.W                          ; $00F766
        BEQ.S  loc_00F78A                       ; $00F76A
        CMPI.B  #$0001,$A01B.W                  ; $00F76C
        BEQ.S  loc_00F79E                       ; $00F772
        MOVE.B  $A01F.W,$FEB3.W                 ; $00F774
        MOVE.B  $A020.W,$FEAF.W                 ; $00F77A
        MOVE.B  $A019.W,$FEAD.W                 ; $00F780
        BRA.W  loc_00F7B0                       ; $00F786
loc_00F78A:
        MOVE.B  $A019.W,$FEB3.W                 ; $00F78A
        MOVE.B  $A020.W,$FEAF.W                 ; $00F790
        MOVE.B  $A021.W,$FEAD.W                 ; $00F796
        BRA.S  loc_00F7B0                       ; $00F79C
loc_00F79E:
        MOVE.B  $A01F.W,$FEB3.W                 ; $00F79E
        MOVE.B  $A019.W,$FEAF.W                 ; $00F7A4
        MOVE.B  $A021.W,$FEAD.W                 ; $00F7AA
loc_00F7B0:
        CMPI.B  #$0001,$A01C.W                  ; $00F7B0
        BEQ.S  loc_00F7C6                       ; $00F7B6
        MOVE.B  $A022.W,$FEB0.W                 ; $00F7B8
        MOVE.B  $A01A.W,$FEAE.W                 ; $00F7BE
        BRA.S  loc_00F7D2                       ; $00F7C4
loc_00F7C6:
        MOVE.B  $A01A.W,$FEB0.W                 ; $00F7C6
        MOVE.B  $A023.W,$FEAE.W                 ; $00F7CC
loc_00F7D2:
        CLR.B  $A01E.W                          ; $00F7D2
        MOVE.B  #$0001,$C809.W                  ; $00F7D6
        MOVE.B  #$0001,$C80A.W                  ; $00F7DC
        BSET    #7,$C80E.W                      ; $00F7E2
        MOVE.B  #$0001,$C802.W                  ; $00F7E8
        MOVE.W  #$0002,$A024.W                  ; $00F7EE
        BRA.W  loc_00F824                       ; $00F7F4
loc_00F7F8:
        BSR.W  loc_00FB36                       ; $00F7F8
        BTST    #6,$C80E.W                      ; $00F7FC
        BNE.S  loc_00F824                       ; $00F802
        CLR.W  $A024.W                          ; $00F804
        BRA.W  loc_00F824                       ; $00F808
loc_00F80C:
        BSR.W  loc_00FB36                       ; $00F80C
        BTST    #7,$C80E.W                      ; $00F810
        BNE.S  loc_00F824                       ; $00F816
        CLR.W  $A024.W                          ; $00F818
        ADDQ.W  #4,$C87E.W                      ; $00F81C
        BRA.W  loc_00F828                       ; $00F820
loc_00F824:
        SUBQ.W  #4,$C87E.W                      ; $00F824
loc_00F828:
        DC.W    $33FC,$0018,$00FF,$0008; $00F828 MOVE.W  #$0018,$00FF0008
        MOVE.B  #$0001,$C821.W                  ; $00F830
        RTS                                     ; $00F836
        ADDI.B  #$D780,D3                       ; $00F838
        SUBI.B  #$4C68,D0                       ; $00F83C
        ORI.W  #$0010,$03(A0,D0.W)              ; $00F840
        ADD.L  D0,D7                            ; $00F846
        SUBI.B  #$EC2C,D0                       ; $00F848
        ORI.W  #$0010,A0                        ; $00F84C
        ADDI.B  #$F200,D3                       ; $00F850
        SUBI.B  #$ECC4,D0                       ; $00F854
        ORI.W  #$0010,A0                        ; $00F858
loc_00F85C:
        TST.B  $00A15120                        ; $00F85C
        BNE.S  loc_00F85C                       ; $00F862
        CLR.B  $00A15123                        ; $00F864
        MOVE.W  #$0000,$C87E.W                  ; $00F86A
        DC.W    $23FC,$0089,$26D2,$00FF,$0002; $00F870 MOVE.L  #$008926D2,$00FF0002
        TST.B  $A018.W                          ; $00F87A
        BNE.S  loc_00F88A                       ; $00F87E
        DC.W    $23FC,$0088,$D4B8,$00FF,$0002; $00F880 MOVE.L  #$0088D4B8,$00FF0002
loc_00F88A:
        RTS                                     ; $00F88A
loc_00F88C:
        LEA     $84A2.W,A0                      ; $00F88C
        LEA     $84C2.W,A1                      ; $00F890
        LEA     $84E2.W,A2                      ; $00F894
        CLR.W  D2                               ; $00F898
        MOVE.W  #$0007,D1                       ; $00F89A
loc_00F89E:
        MOVE.W  #$0000,$00(A0,D2.W)             ; $00F89E
        MOVE.W  #$0000,$00(A1,D2.W)             ; $00F8A4
        ADDQ.W  #2,D2                           ; $00F8AA
        DBRA    D1,loc_00F89E                   ; $00F8AC
        LEA     $84C2.W,A0                      ; $00F8B0
        TST.W  D0                               ; $00F8B4
        BNE.S  loc_00F8BC                       ; $00F8B6
        LEA     $84A2.W,A0                      ; $00F8B8
loc_00F8BC:
        LEA     $0088F8F6,A3                    ; $00F8BC
        MOVEQ   #$00,D1                         ; $00F8C2
        MOVE.W  $A012.W,D1                      ; $00F8C4
        ADD.W  D1,D1                            ; $00F8C8
        ADDA.L  D1,A3                           ; $00F8CA
        CLR.W  D2                               ; $00F8CC
        MOVE.W  #$0007,D1                       ; $00F8CE
loc_00F8D2:
        MOVE.W  (A3),$00(A0,D2.W)               ; $00F8D2
        MOVE.W  (A3)+,$00(A2,D2.W)              ; $00F8D6
        ADDQ.W  #2,D2                           ; $00F8DA
        DBRA    D1,loc_00F8D2                   ; $00F8DC
        MOVE.W  $A012.W,D1                      ; $00F8E0
        ADDQ.W  #1,D1                           ; $00F8E4
        CMPI.W  #$0007,D1                       ; $00F8E6
        BLE.W  loc_00F8F0                       ; $00F8EA
        CLR.W  D1                               ; $00F8EE
loc_00F8F0:
        MOVE.W  D1,$A012.W                      ; $00F8F0
        RTS                                     ; $00F8F4
        DC.W    $0EEE               ; $00F8F6 DC.W    $0EEE
        DC.W    $0EEE               ; $00F8F8 DC.W    $0EEE
        DC.W    $0EEE               ; $00F8FA DC.W    $0EEE
        DC.W    $0EEE               ; $00F8FC DC.W    $0EEE
        DC.W    $0000,$0000         ; $00F8FE ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00F902 ORI.B  #$0000,D0
        DC.W    $0EEE               ; $00F906 DC.W    $0EEE
        DC.W    $0EEE               ; $00F908 DC.W    $0EEE
        DC.W    $0EEE               ; $00F90A DC.W    $0EEE
        DC.W    $0EEE               ; $00F90C DC.W    $0EEE
        DC.W    $0000,$0000         ; $00F90E ORI.B  #$0000,D0
        DC.W    $0000,$0000         ; $00F912 ORI.B  #$0000,D0
loc_00F916:
        MOVEQ   #$00,D0                         ; $00F916
        TST.B  $A01B.W                          ; $00F918
        BNE.S  loc_00F924                       ; $00F91C
        MOVE.B  $A019.W,D0                      ; $00F91E
        BRA.S  loc_00F928                       ; $00F922
loc_00F924:
        MOVE.B  $A01F.W,D0                      ; $00F924
loc_00F928:
        LEA     $0088FB24,A1                    ; $00F928
        ADD.W  D0,D0                            ; $00F92E
        MOVE.W  D0,D1                           ; $00F930
        ADD.W  D0,D0                            ; $00F932
        ADD.W  D1,D0                            ; $00F934
        MOVEA.L $00(A1,D0.W),A0                 ; $00F936
        MOVE.W  $04(A1,D0.W),D0                 ; $00F93A
        MOVE.W  #$0030,D1                       ; $00F93E
        MOVE.W  #$0010,D2                       ; $00F942
        JSR     loc_00E3B4(PC)                  ; $00F946
        MOVEQ   #$00,D0                         ; $00F94A
        CMPI.B  #$0001,$A01B.W                  ; $00F94C
        BNE.S  loc_00F978                       ; $00F952
        MOVEA.L #$04012024,A0                   ; $00F954
        MOVE.W  #$0060,D0                       ; $00F95A
        MOVE.W  #$0010,D1                       ; $00F95E
        MOVE.W  #$0010,D2                       ; $00F962
loc_00F966:
        TST.B  $00A15120                        ; $00F966
        BNE.S  loc_00F966                       ; $00F96C
        JSR     loc_00E3B4(PC)                  ; $00F96E
        MOVE.B  $A019.W,D0                      ; $00F972
        BRA.S  loc_00F97C                       ; $00F976
loc_00F978:
        MOVE.B  $A020.W,D0                      ; $00F978
loc_00F97C:
        MOVEA.L #$04014014,A0                   ; $00F97C
        TST.B  D0                               ; $00F982
        BNE.S  loc_00F98C                       ; $00F984
        MOVE.W  #$0048,D0                       ; $00F986
        BRA.S  loc_00F996                       ; $00F98A
loc_00F98C:
        ADDA.L  #$00000047,A0                   ; $00F98C
        MOVE.W  #$0039,D0                       ; $00F992
loc_00F996:
        MOVE.W  #$0010,D1                       ; $00F996
        MOVE.W  #$0010,D2                       ; $00F99A
loc_00F99E:
        TST.B  $00A15120                        ; $00F99E
        BNE.S  loc_00F99E                       ; $00F9A4
        JSR     loc_00E3B4(PC)                  ; $00F9A6
        MOVEQ   #$00,D0                         ; $00F9AA
        CMPI.B  #$0002,$A01B.W                  ; $00F9AC
        BNE.S  loc_00F9F6                       ; $00F9B2
        MOVEA.L #$04017030,A0                   ; $00F9B4
        MOVE.W  #$0048,D0                       ; $00F9BA
        MOVE.W  #$0010,D1                       ; $00F9BE
        MOVE.W  #$0010,D2                       ; $00F9C2
loc_00F9C6:
        TST.B  $00A15120                        ; $00F9C6
        BNE.S  loc_00F9C6                       ; $00F9CC
        JSR     loc_00E3B4(PC)                  ; $00F9CE
        MOVEA.L #$04019018,A0                   ; $00F9D2
        MOVE.W  #$0078,D0                       ; $00F9D8
        MOVE.W  #$0010,D1                       ; $00F9DC
        MOVE.W  #$0010,D2                       ; $00F9E0
loc_00F9E4:
        TST.B  $00A15120                        ; $00F9E4
        BNE.S  loc_00F9E4                       ; $00F9EA
        JSR     loc_00E3B4(PC)                  ; $00F9EC
        MOVE.B  $A019.W,D0                      ; $00F9F0
        BRA.S  loc_00F9FA                       ; $00F9F4
loc_00F9F6:
        MOVE.B  $A021.W,D0                      ; $00F9F6
loc_00F9FA:
        MOVE.B  D0,D2                           ; $00F9FA
        MOVEA.L #$0401B018,A0                   ; $00F9FC
        ADD.W  D0,D0                            ; $00FA02
        ADD.W  D0,D0                            ; $00FA04
        ADD.W  D0,D0                            ; $00FA06
        MOVE.W  D0,D1                           ; $00FA08
        ADD.W  D0,D0                            ; $00FA0A
        ADD.W  D1,D0                            ; $00FA0C
        LEA     $00(A0,D0.W),A0                 ; $00FA0E
        MOVE.W  #$0018,D0                       ; $00FA12
        TST.B  D2                               ; $00FA16
        BEQ.W  loc_00FA22                       ; $00FA18
        SUBQ.L  #1,A0                           ; $00FA1C
        MOVE.W  #$0019,D0                       ; $00FA1E
loc_00FA22:
        MOVE.W  #$0010,D1                       ; $00FA22
        MOVE.W  #$0010,D2                       ; $00FA26
loc_00FA2A:
        TST.B  $00A15120                        ; $00FA2A
        BNE.S  loc_00FA2A                       ; $00FA30
        JSR     loc_00E3B4(PC)                  ; $00FA32
        MOVEQ   #$00,D0                         ; $00FA36
        CMPI.B  #$0001,$A01C.W                  ; $00FA38
        BNE.S  loc_00FA64                       ; $00FA3E
        MOVEA.L #$040120BC,A0                   ; $00FA40
        MOVE.W  #$0060,D0                       ; $00FA46
        MOVE.W  #$0010,D1                       ; $00FA4A
        MOVE.W  #$0010,D2                       ; $00FA4E
loc_00FA52:
        TST.B  $00A15120                        ; $00FA52
        BNE.S  loc_00FA52                       ; $00FA58
        JSR     loc_00E3B4(PC)                  ; $00FA5A
        MOVE.B  $A01A.W,D0                      ; $00FA5E
        BRA.S  loc_00FA68                       ; $00FA62
loc_00FA64:
        MOVE.B  $A022.W,D0                      ; $00FA64
loc_00FA68:
        MOVEA.L #$040140AC,A0                   ; $00FA68
        TST.B  D0                               ; $00FA6E
        BNE.S  loc_00FA78                       ; $00FA70
        MOVE.W  #$0048,D0                       ; $00FA72
        BRA.S  loc_00FA82                       ; $00FA76
loc_00FA78:
        ADDA.L  #$00000047,A0                   ; $00FA78
        MOVE.W  #$0039,D0                       ; $00FA7E
loc_00FA82:
        MOVE.W  #$0010,D1                       ; $00FA82
        MOVE.W  #$0010,D2                       ; $00FA86
loc_00FA8A:
        TST.B  $00A15120                        ; $00FA8A
        BNE.S  loc_00FA8A                       ; $00FA90
        JSR     loc_00E3B4(PC)                  ; $00FA92
        MOVEQ   #$00,D0                         ; $00FA96
        CMPI.B  #$0002,$A01C.W                  ; $00FA98
        BNE.S  loc_00FAE2                       ; $00FA9E
        MOVEA.L #$040170C8,A0                   ; $00FAA0
        MOVE.W  #$0048,D0                       ; $00FAA6
        MOVE.W  #$0010,D1                       ; $00FAAA
        MOVE.W  #$0010,D2                       ; $00FAAE
loc_00FAB2:
        TST.B  $00A15120                        ; $00FAB2
        BNE.S  loc_00FAB2                       ; $00FAB8
        JSR     loc_00E3B4(PC)                  ; $00FABA
        MOVEA.L #$040190B0,A0                   ; $00FABE
        MOVE.W  #$0078,D0                       ; $00FAC4
        MOVE.W  #$0010,D1                       ; $00FAC8
        MOVE.W  #$0010,D2                       ; $00FACC
loc_00FAD0:
        TST.B  $00A15120                        ; $00FAD0
        BNE.S  loc_00FAD0                       ; $00FAD6
        JSR     loc_00E3B4(PC)                  ; $00FAD8
        MOVE.B  $A01A.W,D0                      ; $00FADC
        BRA.S  loc_00FAE6                       ; $00FAE0
loc_00FAE2:
        MOVE.B  $A023.W,D0                      ; $00FAE2
loc_00FAE6:
        MOVE.B  D0,D2                           ; $00FAE6
        MOVEA.L #$0401B0B0,A0                   ; $00FAE8
        ADD.W  D0,D0                            ; $00FAEE
        ADD.W  D0,D0                            ; $00FAF0
        ADD.W  D0,D0                            ; $00FAF2
        MOVE.W  D0,D1                           ; $00FAF4
        ADD.W  D0,D0                            ; $00FAF6
        ADD.W  D1,D0                            ; $00FAF8
        LEA     $00(A0,D0.W),A0                 ; $00FAFA
        MOVE.W  #$0018,D0                       ; $00FAFE
        TST.B  D2                               ; $00FB02
        BEQ.W  loc_00FB0E                       ; $00FB04
        SUBQ.L  #1,A0                           ; $00FB08
        MOVE.W  #$0019,D0                       ; $00FB0A
loc_00FB0E:
        MOVE.W  #$0010,D1                       ; $00FB0E
        MOVE.W  #$0010,D2                       ; $00FB12
loc_00FB16:
        TST.B  $00A15120                        ; $00FB16
        BNE.S  loc_00FB16                       ; $00FB1C
        JSR     loc_00E3B4(PC)                  ; $00FB1E
        RTS                                     ; $00FB22
        SUBI.B  #$7010,D0                       ; $00FB24
        ORI.W  #$0400,-(A0)                     ; $00FB28
        MOVEQ   #$6F,D0                         ; $00FB2C
        ORI.W  #$0400,-(A1)                     ; $00FB2E
        MOVEQ   #-$31,D0                        ; $00FB32
        ORI.W  #$4A39,-(A1)                     ; $00FB34
        ORI.L  #$512066F8,-(A1)                 ; $00FB38
        DC.W    $33FC,$001C,$00A1,$5110; $00FB3E MOVE.W  #$001C,$00A15110
        DC.W    $13FC,$0004,$00A1,$5107; $00FB46 MOVE.B  #$0004,$00A15107
        CLR.B  $00A15123                        ; $00FB4E
        DC.W    $13FC,$002D,$00A1,$5121; $00FB54 MOVE.B  #$002D,$00A15121
        DC.W    $13FC,$0001,$00A1,$5120; $00FB5C MOVE.B  #$0001,$00A15120
loc_00FB64:
        DC.W    $0839,$0001,$00A1,$5123; $00FB64 BTST    #1,$00A15123
        BEQ.S  loc_00FB64                       ; $00FB6C
        DC.W    $08B9,$0001,$00A1,$5123; $00FB6E BCLR    #1,$00A15123
        LEA     $00FF60C8,A1                    ; $00FB76
        LEA     $00A15112,A2                    ; $00FB7C
        MOVE.W  #$001B,D7                       ; $00FB82
loc_00FB86:
        DC.W    $0839,$0007,$00A1,$5107; $00FB86 BTST    #7,$00A15107
        BNE.S  loc_00FB86                       ; $00FB8E
        MOVE.W  (A1)+,(A2)                      ; $00FB90
        DBRA    D7,loc_00FB86                   ; $00FB92
        RTS                                     ; $00FB96
        DC.W    $33FC,$002C,$00FF,$0008; $00FB98 MOVE.W  #$002C,$00FF0008
        MOVE.W  #$002C,$C87A.W                  ; $00FBA0
        BCLR    #6,$C875.W                      ; $00FBA6
        MOVE.W  $C874.W,(A5)                    ; $00FBAC
        DC.W    $33FC,$0083,$00A1,$5100; $00FBB0 MOVE.W  #$0083,$00A15100
        DC.W    $0239,$00FC,$00A1,$5181; $00FBB8 ANDI.B  #$00FC,$00A15181
        JSR     $008826C8                       ; $00FBC0
        MOVE.L  #$000A0907,D0                   ; $00FBC6
        JSR     $008814BE                       ; $00FBCC
        MOVE.B  #$0001,$C80D.W                  ; $00FBD2
        MOVE.W  #$0000,$A014.W                  ; $00FBD8
        BTST    #4,$C80E.W                      ; $00FBDE
        BNE.W  loc_00FD64                       ; $00FBE4
        BTST    #5,$C80E.W                      ; $00FBE8
        BNE.W  loc_00FD64                       ; $00FBEE
        BTST    #7,$FDA8.W                      ; $00FBF2
        BNE.W  loc_00FD64                       ; $00FBF8
        MOVE.L  $C260.W,D0                      ; $00FBFC
        CMPI.L  #$60000000,D0                   ; $00FC00
        BGE.W  loc_00FCDE                       ; $00FC06
        MOVE.B  #$0000,$A021.W                  ; $00FC0A
        MOVE.W  $C0A2.W,D0                      ; $00FC10
        MOVE.W  $C0A4.W,D1                      ; $00FC14
        CMP.W  D0,D1                            ; $00FC18
        BCS.W  loc_00FC26                       ; $00FC1A
        MOVE.B  #$0001,$A021.W                  ; $00FC1E
        MOVE.W  D1,D0                           ; $00FC24
loc_00FC26:
        MOVE.W  $C0A6.W,D1                      ; $00FC26
        CMP.W  D0,D1                            ; $00FC2A
        BCS.W  loc_00FC38                       ; $00FC2C
        MOVE.B  #$0002,$A021.W                  ; $00FC30
        MOVE.W  D1,D0                           ; $00FC36
loc_00FC38:
        MOVE.W  $C0A8.W,D1                      ; $00FC38
        CMP.W  D0,D1                            ; $00FC3C
        BCS.W  loc_00FC48                       ; $00FC3E
        MOVE.B  #$0003,$A021.W                  ; $00FC42
loc_00FC48:
        MOVEQ   #$00,D0                         ; $00FC48
        MOVEQ   #$00,D1                         ; $00FC4A
        MOVE.B  $FEB1.W,D0                      ; $00FC4C
        BEQ.S  loc_00FC5E                       ; $00FC50
        SUBQ.W  #1,D0                           ; $00FC52
loc_00FC54:
        ADDI.L  #$000003C0,D1                   ; $00FC54
        DBRA    D0,loc_00FC54                   ; $00FC5A
loc_00FC5E:
        LEA     $EF08.W,A0                      ; $00FC5E
        ADDA.L  D1,A0                           ; $00FC62
        MOVEQ   #$00,D0                         ; $00FC64
        MOVE.B  $FEA5.W,D0                      ; $00FC66
        ADD.W  D0,D0                            ; $00FC6A
        ADD.W  D0,D0                            ; $00FC6C
        ADD.W  D0,D0                            ; $00FC6E
        ADD.W  D0,D0                            ; $00FC70
        MOVE.W  D0,D1                           ; $00FC72
        ADD.W  D0,D0                            ; $00FC74
        ADD.W  D0,D0                            ; $00FC76
        ADD.W  D1,D0                            ; $00FC78
        ADD.W  D0,D0                            ; $00FC7A
        ADDA.L  D0,A0                           ; $00FC7C
        MOVE.L  $C260.W,D0                      ; $00FC7E
        CMP.L  $009C(A0),D0                     ; $00FC82
        BHI.W  loc_00FCDE                       ; $00FC86
        MOVEQ   #$00,D1                         ; $00FC8A
        MOVE.W  #$0013,D2                       ; $00FC8C
        MOVE.B  $A021.W,D5                      ; $00FC90
loc_00FC94:
        CMP.L  $04(A0,D1.W),D0                  ; $00FC94
        BCS.W  loc_00FCA6                       ; $00FC98
        ADDQ.W  #8,D1                           ; $00FC9C
        DBRA    D2,loc_00FC94                   ; $00FC9E
        BRA.W  loc_00FCDE                       ; $00FCA2
loc_00FCA6:
        MOVE.B  #$0001,$A014.W                  ; $00FCA6
        MOVE.W  #$0013,D3                       ; $00FCAC
        SUB.W  D2,D3                            ; $00FCB0
        MOVE.W  D3,$A022.W                      ; $00FCB2
        MOVE.L  A0,$A018.W                      ; $00FCB6
        ANDI.L  #$0000FFFF,D1                   ; $00FCBA
        ADD.L  D1,$A018.W                       ; $00FCC0
loc_00FCC4:
        MOVE.L  $00(A0,D1.W),D3                 ; $00FCC4
        MOVE.L  $04(A0,D1.W),D4                 ; $00FCC8
        MOVE.L  D5,$00(A0,D1.W)                 ; $00FCCC
        MOVE.L  D0,$04(A0,D1.W)                 ; $00FCD0
        MOVE.L  D4,D0                           ; $00FCD4
        MOVE.L  D3,D5                           ; $00FCD6
        ADDQ.W  #8,D1                           ; $00FCD8
        DBRA    D2,loc_00FCC4                   ; $00FCDA
loc_00FCDE:
        LEA     $C200.W,A0                      ; $00FCDE
        MOVE.L  #$60000000,D0                   ; $00FCE2
        MOVE.W  #$0013,D3                       ; $00FCE8
loc_00FCEC:
        MOVE.L  (A0)+,D1                        ; $00FCEC
        BEQ.S  loc_00FCF6                       ; $00FCEE
        CMP.L  D1,D0                            ; $00FCF0
        BLE.S  loc_00FCF6                       ; $00FCF2
        MOVE.L  D1,D0                           ; $00FCF4
loc_00FCF6:
        ADDI.L  #$00000D80,D2                   ; $00FCF6
        DBRA    D3,loc_00FCEC                   ; $00FCFC
        MOVE.L  D0,D2                           ; $00FD00
        LEA     $FA48.W,A0                      ; $00FD02
        MOVEQ   #$00,D0                         ; $00FD06
        MOVE.B  $FEB1.W,D0                      ; $00FD08
        ADD.W  D0,D0                            ; $00FD0C
        ADD.W  D0,D0                            ; $00FD0E
        ADD.W  D0,D0                            ; $00FD10
        MOVE.W  D0,D1                           ; $00FD12
        ADD.W  D0,D0                            ; $00FD14
        ADD.W  D1,D0                            ; $00FD16
        ADD.W  D0,D0                            ; $00FD18
        ADDA.L  D0,A0                           ; $00FD1A
        MOVEQ   #$00,D0                         ; $00FD1C
        MOVE.B  $FEA5.W,D0                      ; $00FD1E
        ADD.W  D0,D0                            ; $00FD22
        ADD.W  D0,D0                            ; $00FD24
        ADD.W  D0,D0                            ; $00FD26
        ADDQ.W  #4,D0                           ; $00FD28
        CMP.L  $00(A0,D0.W),D2                  ; $00FD2A
        BHI.W  loc_00FD4C                       ; $00FD2E
        ADDQ.B  #2,$A014.W                      ; $00FD32
        MOVE.L  A0,$A01C.W                      ; $00FD36
        ANDI.L  #$0000FFFF,D0                   ; $00FD3A
        ADD.L  D0,$A01C.W                       ; $00FD40
        SUBQ.L  #4,$A01C.W                      ; $00FD44
        MOVE.L  D2,$00(A0,D0.W)                 ; $00FD48
loc_00FD4C:
        MOVE.L  $C260.W,$A032.W                 ; $00FD4C
        MOVE.L  $C260.W,D0                      ; $00FD52
        CMPI.L  #$60000000,D0                   ; $00FD56
        BGE.W  loc_00FD64                       ; $00FD5C
        BRA.W  loc_00FE04                       ; $00FD60
loc_00FD64:
        LEA     $C200.W,A0                      ; $00FD64
        MOVE.W  #$0013,D0                       ; $00FD68
loc_00FD6C:
        TST.L  (A0)                             ; $00FD6C
        BEQ.W  loc_00FD78                       ; $00FD6E
        ADDQ.L  #4,A0                           ; $00FD72
        DBRA    D0,loc_00FD6C                   ; $00FD74
loc_00FD78:
        CLR.L  $A032.W                          ; $00FD78
        LEA     $A032.W,A0                      ; $00FD7C
        LEA     $C200.W,A1                      ; $00FD80
        MOVE.W  #$0013,D2                       ; $00FD84
loc_00FD88:
        ADDI.B  #$0000,D0                       ; $00FD88
        MOVE.B  $0003(A0),D0                    ; $00FD8C
        MOVE.B  $0003(A1),D1                    ; $00FD90
        AND.B  D0,D1                            ; $00FD94
        MOVE.B  D0,$0003(A0)                    ; $00FD96
        MOVE.B  $0002(A0),D0                    ; $00FD9A
        MOVE.B  $0002(A1),D1                    ; $00FD9E
        AND.B  D0,D1                            ; $00FDA2
        MOVE.B  D0,D1                           ; $00FDA4
        DC.W    $0200,$000F         ; $00FDA6 ANDI.B  #$000F,D0
        MOVE.B  D0,$0002(A0)                    ; $00FDAA
        LSR.B  #4,D1                            ; $00FDAE
        ADDI.B  #$0000,D0                       ; $00FDB0
        MOVE.B  $0001(A0),D0                    ; $00FDB4
        AND.B  D0,D1                            ; $00FDB8
        MOVE.B  $0001(A1),D1                    ; $00FDBA
        AND.B  D0,D1                            ; $00FDBE
        BCC.W  loc_00FDD4                       ; $00FDC0
        ADDI.B  #$0000,D0                       ; $00FDC4
        MOVE.B  #$0040,D1                       ; $00FDC8
        AND.B  D0,D1                            ; $00FDCC
        MOVE.B  #$0001,D1                       ; $00FDCE
        BRA.S  loc_00FDEC                       ; $00FDD2
loc_00FDD4:
        CLR.B  D1                               ; $00FDD4
        CMPI.B  #$0060,D0                       ; $00FDD6
        BCS.W  loc_00FDEC                       ; $00FDDA
        ADDI.B  #$0000,D0                       ; $00FDDE
        MOVE.B  #$0060,D1                       ; $00FDE2
        OR.B   D0,D1                            ; $00FDE6
        MOVE.B  #$0001,D1                       ; $00FDE8
loc_00FDEC:
        MOVE.B  D0,$0001(A0)                    ; $00FDEC
        ADDI.B  #$0000,D0                       ; $00FDF0
        MOVE.B  (A0),D0                         ; $00FDF4
        AND.B  D0,D1                            ; $00FDF6
        MOVE.B  (A1),D1                         ; $00FDF8
        AND.B  D0,D1                            ; $00FDFA
        MOVE.B  D0,(A0)                         ; $00FDFC
        ADDQ.L  #4,A1                           ; $00FDFE
        DBRA    D2,loc_00FD88                   ; $00FE00
loc_00FE04:
        TST.B  $A014.W                          ; $00FE04
        BNE.W  loc_00FE2E                       ; $00FE08
        MOVE.W  #$0000,$C87E.W                  ; $00FE0C
        DC.W    $33FC,$0020,$00FF,$0008; $00FE12 MOVE.W  #$0020,$00FF0008
        DC.W    $23FC,$0089,$09AE,$00FF,$0002; $00FE1A MOVE.L  #$008909AE,$00FF0002
        CLR.B  $00A15123                        ; $00FE24
        BRA.W  loc_010082                       ; $00FE2A
loc_00FE2E:
        MOVEQ   #$00,D0                         ; $00FE2E
        LEA     $8480.W,A0                      ; $00FE30
        MOVEQ   #$1F,D1                         ; $00FE34
loc_00FE36:
        MOVE.L  D0,(A0)+                        ; $00FE36
        DBRA    D1,loc_00FE36                   ; $00FE38
        LEA     $00FF7B80,A0                    ; $00FE3C
        MOVEQ   #$7F,D1                         ; $00FE42
loc_00FE44:
        MOVE.L  D0,(A0)+                        ; $00FE44
        DBRA    D1,loc_00FE44                   ; $00FE46
        MOVE.L  #$60000002,(A5)                 ; $00FE4A
        MOVE.W  #$17FF,D1                       ; $00FE50
loc_00FE54:
        MOVE.L  D0,(A6)                         ; $00FE54
        DBRA    D1,loc_00FE54                   ; $00FE56
        JSR     $008849AA                       ; $00FE5A
        CLR.W  $C880.W                          ; $00FE60
        CLR.W  $C882.W                          ; $00FE64
        CLR.W  $8000.W                          ; $00FE68
        CLR.W  $8002.W                          ; $00FE6C
        CLR.W  $A012.W                          ; $00FE70
        JSR     $008849AA                       ; $00FE74
        DC.W    $21FC,$008B,$B4FC,$C96C; $00FE7A MOVE.L  #$008BB4FC,$C96C.W
        MOVE.B  #$0001,$C809.W                  ; $00FE82
        MOVE.B  #$0001,$C80A.W                  ; $00FE88
        BSET    #6,$C80E.W                      ; $00FE8E
        MOVE.B  #$0001,$C802.W                  ; $00FE94
        MOVE.W  #$0001,$A036.W                  ; $00FE9A
        LEA     $00FF1000,A0                    ; $00FEA0
        MOVE.W  #$037F,D0                       ; $00FEA6
loc_00FEAA:
        CLR.L  (A0)+                            ; $00FEAA
        DBRA    D0,loc_00FEAA                   ; $00FEAC
        MOVE.W  #$0001,D0                       ; $00FEB0
        MOVE.W  #$0001,D1                       ; $00FEB4
        MOVE.W  #$0001,D2                       ; $00FEB8
        MOVE.W  #$0026,D3                       ; $00FEBC
        MOVE.W  #$001A,D4                       ; $00FEC0
        LEA     $00FF1000,A0                    ; $00FEC4
        JSR     loc_00E22C(PC)                  ; $00FECA
        LEA     $00FF1000,A0                    ; $00FECE
        JSR     loc_00E2F0(PC)                  ; $00FED4
        JSR     $00E1BC(PC)                     ; $00FED8
        DC.W    $08B9,$0007,$00A1,$5181; $00FEDC BCLR    #7,$00A15181
        LEA     $00FF6E00,A0                    ; $00FEE4
        ADDA.L  #$00000160,A0                   ; $00FEEA
        LEA     $008900A8,A1                    ; $00FEF0
        MOVE.W  #$003F,D0                       ; $00FEF6
loc_00FEFA:
        MOVE.W  (A1)+,D1                        ; $00FEFA
        BSET    #15,D1                          ; $00FEFC
        MOVE.W  D1,(A0)+                        ; $00FF00
        DBRA    D0,loc_00FEFA                   ; $00FF02
        LEA     $000F3D80,A0                    ; $00FF06
        MOVEA.L #$06014000,A1                   ; $00FF0C
        JSR     loc_00E316(PC)                  ; $00FF12
        LEA     $000ECC90,A0                    ; $00FF16
        MOVEA.L #$06019000,A1                   ; $00FF1C
        JSR     loc_00E316(PC)                  ; $00FF22
        MOVEQ   #$00,D0                         ; $00FF26
        MOVE.B  $FEB1.W,D0                      ; $00FF28
        ADD.L  D0,D0                            ; $00FF2C
        ADD.L  D0,D0                            ; $00FF2E
        LEA     $00890084,A0                    ; $00FF30
        MOVEA.L $00(A0,D0.W),A0                 ; $00FF36
        MOVEA.L #$06019700,A1                   ; $00FF3A
        JSR     loc_00E316(PC)                  ; $00FF40
        MOVEQ   #$00,D0                         ; $00FF44
        MOVE.B  $FEA5.W,D0                      ; $00FF46
        ADD.L  D0,D0                            ; $00FF4A
        ADD.L  D0,D0                            ; $00FF4C
        LEA     $00890090,A0                    ; $00FF4E
        MOVEA.L $00(A0,D0.W),A0                 ; $00FF54
        MOVEA.L #$06019C80,A1                   ; $00FF58
        JSR     loc_00E316(PC)                  ; $00FF5E
        LEA     $000F4620,A0                    ; $00FF62
        MOVEA.L #$0601A200,A1                   ; $00FF68
        JSR     loc_00E316(PC)                  ; $00FF6E
        LEA     $000EBB40,A0                    ; $00FF72
        MOVEA.L #$06020000,A1                   ; $00FF78
        JSR     loc_00E316(PC)                  ; $00FF7E
        LEA     $000EB980,A0                    ; $00FF82
        MOVEA.L #$06023200,A1                   ; $00FF88
        JSR     loc_00E316(PC)                  ; $00FF8E
        LEA     $000F4E40,A0                    ; $00FF92
        MOVEA.L #$06024000,A1                   ; $00FF98
        JSR     loc_00E316(PC)                  ; $00FF9E
        MOVE.B  #$0000,$A020.W                  ; $00FFA2
        MOVE.W  #$0041,$A024.W                  ; $00FFA8
        MOVE.W  #$0000,$A026.W                  ; $00FFAE
        MOVE.W  #$0000,$A028.W                  ; $00FFB4
        MOVE.B  #$00FF,$A02A.W                  ; $00FFBA
        MOVE.B  #$0000,$A02B.W                  ; $00FFC0
        MOVE.B  #$0001,$A02C.W                  ; $00FFC6
        MOVE.B  #$0000,$A02D.W                  ; $00FFCC
        MOVE.W  #$000E,$A02E.W                  ; $00FFD2
        MOVE.W  #$004A,$A030.W                  ; $00FFD8
        BTST    #0,$A014.W                      ; $00FFDE
        BEQ.W  loc_00FFFE                       ; $00FFE4
        MOVEA.L $A018.W,A0                      ; $00FFE8
        MOVE.B  #$0020,$0000(A0)                ; $00FFEC
        MOVE.B  #$0020,$0001(A0)                ; $00FFF2
        MOVE.B  #$0020,$0002(A0)                ; $00FFF8
loc_00FFFE:
        BTST    #1,$A014.W                      ; $00FFFE
        BEQ.W  loc_01001E                       ; $010004
        MOVEA.L $A01C.W,A0                      ; $010008
        MOVE.B  #$0020,$0000(A0)                ; $01000C
        MOVE.B  #$0020,$0001(A0)                ; $010012
        MOVE.B  #$0020,$0002(A0)                ; $010018
loc_01001E:
        MOVE.B  #$0001,$C821.W                  ; $01001E
        JSR     $0088204A                       ; $010024
        DC.W    $0239,$00FC,$00A1,$5181; $01002A ANDI.B  #$00FC,$00A15181
        DC.W    $0039,$0001,$00A1,$5181; $010032 ORI.B  #$0001,$00A15181
        DC.W    $33FC,$8083,$00A1,$5100; $01003A MOVE.W  #$8083,$00A15100
        BSET    #6,$C875.W                      ; $010042
        MOVE.W  $C874.W,(A5)                    ; $010048
        DC.W    $33FC,$0018,$00FF,$0008; $01004C MOVE.W  #$0018,$00FF0008
        JSR     $00884998                       ; $010054
        MOVE.B  #$0092,$C8A5.W                  ; $01005A
        MOVE.W  #$0000,$C87E.W                  ; $010060
        DC.W    $23FC,$0089,$0128,$00FF,$0002; $010066 MOVE.L  #$00890128,$00FF0002
        BTST    #0,$A014.W                      ; $010070
        BNE.S  loc_010082                       ; $010076
        DC.W    $23FC,$0089,$0148,$00FF,$0002; $010078 MOVE.L  #$00890148,$00FF0002
loc_010082:
        RTS                                     ; $010082
        DC.W    $000E,$D310         ; $010084 ORI.B  #$D310,A6
        DC.W    $000E,$D440         ; $010088 ORI.B  #$D440,A6
        DC.W    $000E,$D530         ; $01008C ORI.B  #$D530,A6
        DC.W    $000E,$D670         ; $010090 ORI.B  #$D670,A6
        DC.W    $000E,$D7D0         ; $010094 ORI.B  #$D7D0,A6
        DC.W    $000E,$D930         ; $010098 ORI.B  #$D930,A6
        DC.W    $000E,$DA70         ; $01009C ORI.B  #$DA70,A6
        DC.W    $000E,$DBA0         ; $0100A0 ORI.B  #$DBA0,A6
        DC.W    $000E,$DD10         ; $0100A4 ORI.B  #$DD10,A6
        NEG.B  D0                               ; $0100A8
        NEG.L  -(A3)                            ; $0100AA
        DC.W    $4946               ; $0100AC DC.W    $4946
        LEA     $1C00(A1),A6                    ; $0100AE
        MOVE.L  -(A3),(A4)                      ; $0100B2
        MOVE.W  D6,$41E9(A2)                    ; $0100B4
        DC.W    $7FFF               ; $0100B8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0100BA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0100BC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0100BE MOVE.W  <EA:3F>,<EA:3F>
        MOVE.B  D0,D6                           ; $0100C0
        MOVE.L  -(A3),(A4)                      ; $0100C2
        MOVE.W  D6,$41E9(A2)                    ; $0100C4
        NEG.B  D0                               ; $0100C8
        NEG.L  -(A3)                            ; $0100CA
        DC.W    $4946               ; $0100CC DC.W    $4946
        LEA     $033E(A1),A6                    ; $0100CE
        BLS.L  $1B001BC                         ; $0100D2
        BTST    #21,(A5)                        ; $0100D8
        MOVE.B  (A1),(A4)+                      ; $0100DC
        MOVE.L  $21C2(A5),-(A0)                 ; $0100DE
        MOVEA.L D2,A3                           ; $0100E2
        MOVEA.L -(A2),A5                        ; $0100E4
        MOVE.L  -(A3),(A7)+                     ; $0100E6
        DC.W    $7FFF               ; $0100E8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0100EA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0100EC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $0100EE MOVE.W  <EA:3F>,<EA:3F>
loc_0100F0:
        NEG.W  D5                               ; $0100F0
        SUBQ.B  #8,$6212(A3)                    ; $0100F2
        BGT.S  loc_0100F0                       ; $0100F6
        DC.W    $7FFF               ; $0100F8 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $0E9A               ; $0100FA DC.W    $0E9A
        DC.W    $7FFF               ; $0100FC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $00E1               ; $0100FE DC.W    $00E1
        MOVE.B  D0,-(A0)                        ; $010100
        MOVE.W  D6,$5779.W                      ; $010102
        DC.W    $7FFF               ; $010106 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $0010,$14AF         ; $010108 ORI.B  #$14AF,(A0)
        MOVE.L  A6,$3DED(A4)                    ; $01010C
loc_010110:
        NEG.W  D5                               ; $010110
        SUBQ.B  #8,$6212(A3)                    ; $010112
        BGT.S  loc_010110                       ; $010116
        DC.W    $7FFF               ; $010118 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $0E9A               ; $01011A DC.W    $0E9A
        DC.W    $7FFF               ; $01011C MOVE.W  <EA:3F>,<EA:3F>
        MOVE.W  (A5)+,$02DB(A5)                 ; $01011E
        ANDI.W  #$01B0,-$01(A7,D6.W)            ; $010122
        JSR     $00882080                       ; $010128
        MOVE.W  $C87E.W,D0                      ; $01012E
        MOVEA.L $04(PC,D0.W),A1                 ; $010132
        JMP     (A1)                            ; $010136
        ORI.L  #$017A0089,A1                    ; $010138
        ANDI.W  #$0089,D4                       ; $01013E
        SUBI.L  #$008905DE,-(A2)                ; $010142
        JSR     $00882080                       ; $010148
        MOVE.W  $C87E.W,D0                      ; $01014E
        MOVEA.L $04(PC,D0.W),A1                 ; $010152
        JMP     (A1)                            ; $010156
        ORI.L  #$035C0089,A1                    ; $010158
        BSET    D1,D4                           ; $01015E
        ORI.L  #$04A20089,A1                    ; $010160
        BSET    D2,(A6)+                        ; $010166
        JSR     $00B684(PC)                     ; $010168
        BTST    #6,$C80E.W                      ; $01016C
        BNE.S  loc_010178                       ; $010172
        ADDQ.W  #4,$C87E.W                      ; $010174
loc_010178:
        RTS                                     ; $010178
        CLR.W  D0                               ; $01017A
        BSR.W  loc_00E52C                       ; $01017C
        JSR     $00B684(PC)                     ; $010180
        BSR.W  $01071C                          ; $010184
        MOVEA.L #$0601AA00,A0                   ; $010188
        MOVEA.L #$2400C060,A1                   ; $01018E
        MOVE.W  #$0038,D0                       ; $010194
        MOVE.W  #$0010,D1                       ; $010198
        JSR     loc_00E35A(PC)                  ; $01019C
        LEA     $2402C0A0,A1                    ; $0101A0
        LEA     $A032.W,A2                      ; $0101A6
        BSR.W  $010606                          ; $0101AA
        BTST    #1,$A014.W                      ; $0101AE
        BNE.S  loc_0101D0                       ; $0101B4
        MOVEA.L #$0601AD80,A0                   ; $0101B6
        MOVEA.L #$2400E050,A1                   ; $0101BC
        MOVE.W  #$0048,D0                       ; $0101C2
        MOVE.W  #$0010,D1                       ; $0101C6
        JSR     loc_00E35A(PC)                  ; $0101CA
        BRA.S  loc_0101E8                       ; $0101CE
loc_0101D0:
        MOVEA.L #$0601B200,A0                   ; $0101D0
        MOVEA.L #$2400E038,A1                   ; $0101D6
        MOVE.W  #$0068,D0                       ; $0101DC
        MOVE.W  #$0010,D1                       ; $0101E0
        JSR     loc_00E35A(PC)                  ; $0101E4
loc_0101E8:
        LEA     $2402E0A0,A1                    ; $0101E8
        LEA     $C254.W,A2                      ; $0101EE
        BSR.W  $010606                          ; $0101F2
        MOVEA.L #$0601B880,A0                   ; $0101F6
        MOVEA.L #$24011050,A1                   ; $0101FC
