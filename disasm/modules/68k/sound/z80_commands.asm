; Generated assembly for $00D1D4-$00E200
; Branch targets: 151
; Labels: 126
; Format: DC.W with decoded mnemonics as comments

        org     $00D1D4

        move.w  #$0100,$00A11100        ; $33FC $0100 $00A1 $1100
loc_00D1DC:
        btst    #0,$00A11100            ; $0839 $0000 $00A1 $1100
        DC.W    $66F6               ; $00D1E4 BNE.S  loc_00D1DC
        move.w  ($FFFFC874).w,d4        ; $3838 $C874
        bset    #4,d4                   ; $08C4 $0004
        move.w  d4,(a5)                 ; $3A84
        move.w  #$8F01,(a5)             ; $3ABC $8F01
        move.l  #$93FF941F,(a5)         ; $2ABC $93FF $941F
        move.w  #$9780,(a5)             ; $3ABC $9780
        move.l  #$60000082,(a5)         ; $2ABC $6000 $0082
        move.w  #$0000,(a6)             ; $3CBC $0000
loc_00D208:
        move.w  (a5),d7                 ; $3E15
        andi.w  #$0002,d7               ; $0247 $0002
        DC.W    $66F8               ; $00D20E BNE.S  loc_00D208
        move.w  #$8F02,(a5)             ; $3ABC $8F02
        move.w  ($FFFFC874).w,(a5)      ; $3AB8 $C874
        move.w  #$0000,$00A11100        ; $33FC $0000 $00A1 $1100
        moveq   #$07,d0                 ; $7007
        jsr     $008814BE               ; $4EB9 $0088 $14BE
        move.w  #$0100,$00A11100        ; $33FC $0100 $00A1 $1100
loc_00D230:
        btst    #0,$00A11100            ; $0839 $0000 $00A1 $1100
        DC.W    $66F6               ; $00D238 BNE.S  loc_00D230
        move.w  ($FFFFC874).w,d4        ; $3838 $C874
        bset    #4,d4                   ; $08C4 $0004
        move.w  d4,(a5)                 ; $3A84
        move.l  #$93409400,(a5)         ; $2ABC $9340 $9400
        move.l  #$954096C2,(a5)         ; $2ABC $9540 $96C2
        move.w  #$977F,(a5)             ; $3ABC $977F
        move.w  #$C000,(a5)             ; $3ABC $C000
        move.w  #$0080,($FFFFC876).w    ; $31FC $0080 $C876
        move.w  ($FFFFC876).w,(a5)      ; $3AB8 $C876
        move.w  ($FFFFC874).w,(a5)      ; $3AB8 $C874
        move.w  #$0000,$00A11100        ; $33FC $0000 $00A1 $1100
        move.w  ($FFFFC8A0).w,d0        ; $3038 $C8A0
        lea     scene_init_vdp_dma_setup_track_param_load(pc),a0; $41FA $0188
        move.l  (a0,d0.w),d0            ; $2030 $0000
        jsr     $008815EA               ; $4EB9 $0088 $15EA
        move.w  #$0100,$00A11100        ; $33FC $0100 $00A1 $1100
loc_00D288:
        btst    #0,$00A11100            ; $0839 $0000 $00A1 $1100
        DC.W    $66F6               ; $00D290 BNE.S  loc_00D288
        move.w  ($FFFFC874).w,d4        ; $3838 $C874
        bset    #4,d4                   ; $08C4 $0004
        move.w  d4,(a5)                 ; $3A84
        move.l  #$93009420,(a5)         ; $2ABC $9300 $9420
        move.l  #$95009688,(a5)         ; $2ABC $9500 $9688
        move.w  #$977F,(a5)             ; $3ABC $977F
        move.w  #$4220,(a5)             ; $3ABC $4220
        move.w  #$0080,($FFFFC876).w    ; $31FC $0080 $C876
        move.w  ($FFFFC876).w,(a5)      ; $3AB8 $C876
        move.w  ($FFFFC874).w,(a5)      ; $3AB8 $C874
        move.w  #$0000,$00A11100        ; $33FC $0000 $00A1 $1100
        move.w  ($FFFFC89C).w,d1        ; $3238 $C89C
        lsl.w   #2,d1                   ; $E549
        lea     scene_init_vdp_dma_setup_track_param_load+24(pc),a0; $41FA $0146
        move.l  (a0,d1.w),d1            ; $2230 $1000
        jsr     $0088155E               ; $4EB9 $0088 $155E
        move.w  #$8B00,(a5)             ; $3ABC $8B00
        moveq   #$00,d0                 ; $7000
        moveq   #$F8,d1                 ; $72F8
        tst.b    ($FFFFC80F).w          ; $4A38 $C80F
        DC.W    $6742               ; $00D2E6 BEQ.S  loc_00D32A
        moveq   #$00,d0                 ; $7000
        moveq   #$00,d1                 ; $7200
        lea     $00FF1400,a1            ; $43F9 $00FF $1400
        lea     $00FF1000,a2            ; $45F9 $00FF $1000
        jsr     $008848CA               ; $4EB9 $0088 $48CA
        jsr     $008848CE               ; $4EB9 $0088 $48CE
        jsr     $008848D2               ; $4EB9 $0088 $48D2
        lea     $00FF1200,a1            ; $43F9 $00FF $1200
        jsr     $008848CA               ; $4EB9 $0088 $48CA
        jsr     $008848CE               ; $4EB9 $0088 $48CE
        jsr     $008848D2               ; $4EB9 $0088 $48D2
        move.w  #$8B03,(a5)             ; $3ABC $8B03
        bsr.w   scene_init_vdp_dma_setup_track_param_load+62; $6100 $0112
loc_00D32A:
        move.w  #$0100,$00A11100        ; $33FC $0100 $00A1 $1100
loc_00D332:
        btst    #0,$00A11100            ; $0839 $0000 $00A1 $1100
        DC.W    $66F6               ; $00D33A BNE.S  loc_00D332
        move.w  ($FFFFC874).w,d4        ; $3838 $C874
        bset    #4,d4                   ; $08C4 $0004
        move.w  d4,(a5)                 ; $3A84
        move.l  #$9300940E,(a5)         ; $2ABC $9300 $940E
        move.l  #$95009688,(a5)         ; $2ABC $9500 $9688
        move.w  #$977F,(a5)             ; $3ABC $977F
        move.w  #$4000,(a5)             ; $3ABC $4000
        move.w  #$0083,($FFFFC876).w    ; $31FC $0083 $C876
        move.w  ($FFFFC876).w,(a5)      ; $3AB8 $C876
        move.w  ($FFFFC874).w,(a5)      ; $3AB8 $C874
        move.w  #$0000,$00A11100        ; $33FC $0000 $00A1 $1100
        btst    #3,($FFFFC80E).w        ; $0838 $0003 $C80E
        DC.W    $6762               ; $00D376 BEQ.S  loc_00D3DA
        moveq   #$00,d1                 ; $7200
        move.l  #$000000B0,d2           ; $243C $0000 $00B0
        moveq   #$1B,d7                 ; $7E1B
        lea     $00FF1A50,a1            ; $43F9 $00FF $1A50
loc_00D388:
        jsr     $0088485E               ; $4EB9 $0088 $485E
        adda.l  d2,a1                   ; $D3C2
        DC.W    $51CF,$FFF6         ; $00D390 DBRA    D7,loc_00D388
        move.w  #$0100,$00A11100        ; $33FC $0100 $00A1 $1100
loc_00D39C:
        btst    #0,$00A11100            ; $0839 $0000 $00A1 $1100
        DC.W    $66F6               ; $00D3A4 BNE.S  loc_00D39C
        move.w  ($FFFFC874).w,d4        ; $3838 $C874
        bset    #4,d4                   ; $08C4 $0004
        move.w  d4,(a5)                 ; $3A84
        move.l  #$9300940E,(a5)         ; $2ABC $9300 $940E
        move.l  #$9500968D,(a5)         ; $2ABC $9500 $968D
        move.w  #$977F,(a5)             ; $3ABC $977F
        move.w  #$6000,(a5)             ; $3ABC $6000
        move.w  #$0082,($FFFFC876).w    ; $31FC $0082 $C876
        move.w  ($FFFFC876).w,(a5)      ; $3AB8 $C876
        move.w  ($FFFFC874).w,(a5)      ; $3AB8 $C874
        move.w  #$0000,$00A11100        ; $33FC $0000 $00A1 $1100
loc_00D3DA:
        move.w  #$FFFC,($FFFFC880).w    ; $31FC $FFFC $C880
        move.w  d1,($FFFFC882).w        ; $31C1 $C882
        move.w  d0,($FFFF8000).w        ; $31C0 $8000
        move.w  d0,($FFFF8002).w        ; $31C0 $8002
        move.l  #$40000010,(a5)         ; $2ABC $4000 $0010
        move.w  ($FFFFC880).w,(a6)      ; $3CB8 $C880
        move.w  ($FFFFC882).w,(a6)      ; $3CB8 $C882
        rts                             ; $4E75
        ori.b  #$01,d0                  ; $0000 $0001
        ori.b  #$02,d0                  ; $0000 $0002
        ori.b  #$03,d0                  ; $0000 $0003
        ori.b  #$05,d0                  ; $0000 $0005
        ori.b  #$04,d0                  ; $0000 $0004
        ori.b  #$04,d0                  ; $0000 $0004
        ori.b  #$01,d0                  ; $0000 $0001
        ori.b  #$05,d0                  ; $0000 $0005
        ori.b  #$06,d0                  ; $0000 $0006
        ori.b  #$04,d0                  ; $0000 $0004
        ori.b  #$07,d0                  ; $0000 $0007
        ori.b  #$07,d0                  ; $0000 $0007
        move.l  #$40000000,(a5)         ; $2ABC $4000 $0000
        moveq   #$00,d1                 ; $7200
        jmp     $008848B8               ; $4EF9 $0088 $48B8
loc_00D43A:
        lea     ($FFFF8000).w,a1        ; $43F8 $8000
        moveq   #$00,d1                 ; $7200
        jsr     $0088483E               ; $4EB9 $0088 $483E
        jmp     $00884842               ; $4EF9 $0088 $4842
        DC.W    $050A               ; $00D44C BTST    D2,A2
        btst    d7,(a4)                 ; $0F14
        moveq   #$00,d0                 ; $7000
        move.b  ($FFFFFEA8).w,d0        ; $1038 $FEA8
        move.b  ($FFFFC80F).w,d1        ; $1238 $C80F
        DC.W    $6704               ; $00D45A BEQ.S  loc_00D460
        move.b  ($FFFFFEAC).w,d0        ; $1038 $FEAC
loc_00D460:
        DC.W    $11FB,$00EA,$C81A   ; $00D460 MOVE.B  -$16(PC,D0.W),$C81A.W
        lea     $00898BFC,a0            ; $41F9 $0089 $8BFC
        lsl.w   #2,d0                   ; $E548
        adda.l  d0,a0                   ; $D1C0
        move.l  (a0),$00FF6828          ; $23D0 $00FF $6828
        tst.b    d1                     ; $4A01
        DC.W    $6706               ; $00D478 BEQ.S  loc_00D480
        move.l  (a0),$00FF68B8          ; $23D0 $00FF $68B8
loc_00D480:
        rts                             ; $4E75
        DC.W    $0088,$0088,$00DC   ; $00D482 ORI.L  #$008800DC,A0
        btst    d0,(56,a0,d4.w)         ; $0130 $4238
        DC.W    $A024               ; $00D48C MOVE.L  -(A4),D0
        move.b  ($FFFFFEA5).w,($FFFFA019).w; $11F8 $FEA5 $A019
        btst    #7,($FFFFFDA8).w        ; $0838 $0007 $FDA8
        DC.W    $672E               ; $00D49A BEQ.S  loc_00D4CA
        move.b  ($FFFFFEA6).w,($FFFFA019).w; $11F8 $FEA6 $A019
        DC.W    $6026               ; $00D4A2 BRA.S  loc_00D4CA
        move.b  #$01,($FFFFA024).w      ; $11FC $0001 $A024
        move.b  ($FFFFFEA7).w,($FFFFA019).w; $11F8 $FEA7 $A019
        move.b  ($FFFFFEA8).w,($FFFFA026).w; $11F8 $FEA8 $A026
        DC.W    $6012               ; $00D4B6 BRA.S  loc_00D4CA
        move.b  ($FFFFFEAB).w,($FFFFA019).w; $11F8 $FEAB $A019
        move.b  ($FFFFFEAC).w,($FFFFA026).w; $11F8 $FEAC $A026
        move.b  #$02,($FFFFA024).w      ; $11FC $0002 $A024
loc_00D4CA:
        move.w  #$002C,$00FF0008        ; $33FC $002C $00FF $0008
        move.w  #$002C,($FFFFC87A).w    ; $31FC $002C $C87A
        bclr    #6,($FFFFC875).w        ; $08B8 $0006 $C875
        move.w  ($FFFFC874).w,(a5)      ; $3AB8 $C874
        move.w  #$0083,$00A15100        ; $33FC $0083 $00A1 $5100
        andi.b  #$FC,$00A15181          ; $0239 $00FC $00A1 $5181
        jsr     $008826C8               ; $4EB9 $0088 $26C8
        move.l  #$000A0907,d0           ; $203C $000A $0907
        jsr     $008814BE               ; $4EB9 $0088 $14BE
        move.b  #$01,($FFFFC80D).w      ; $11FC $0001 $C80D
        lea     $0088D832,a0            ; $41F9 $0088 $D832
        lea     $00FF2000,a1            ; $43F9 $00FF $2000
        move.w  #$0004,d0               ; $303C $0004
loc_00D51A:
        move.w  (a0)+,(a1)+             ; $32D8
        move.w  (a0)+,(a1)+             ; $32D8
        move.w  (a0)+,(a1)+             ; $32D8
        move.w  (a0)+,(a1)+             ; $32D8
        move.w  (a0)+,(a1)+             ; $32D8
        DC.W    $51C8,$FFF4         ; $00D524 DBRA    D0,loc_00D51A
        moveq   #$00,d0                 ; $7000
        lea     ($FFFF8480).w,a0        ; $41F8 $8480
        moveq   #$1F,d1                 ; $721F
loc_00D530:
        move.l  d0,(a0)+                ; $20C0
        DC.W    $51C9,$FFFC         ; $00D532 DBRA    D1,loc_00D530
        lea     $00FF7B80,a0            ; $41F9 $00FF $7B80
        moveq   #$7F,d1                 ; $727F
loc_00D53E:
        move.l  d0,(a0)+                ; $20C0
        DC.W    $51C9,$FFFC         ; $00D540 DBRA    D1,loc_00D53E
        move.l  #$60000002,(a5)         ; $2ABC $6000 $0002
        move.w  #$17FF,d1               ; $323C $17FF
loc_00D54E:
        move.l  d0,(a6)                 ; $2C80
        DC.W    $51C9,$FFFC         ; $00D550 DBRA    D1,loc_00D54E
        jsr     $008849AA               ; $4EB9 $0088 $49AA
        clr.w    ($FFFFC880).w          ; $4278 $C880
        clr.w    ($FFFFC882).w          ; $4278 $C882
        clr.w    ($FFFF8000).w          ; $4278 $8000
        clr.w    ($FFFF8002).w          ; $4278 $8002
        clr.w    ($FFFFA012).w          ; $4278 $A012
        clr.b    ($FFFFA018).w          ; $4238 $A018
        jsr     $008849AA               ; $4EB9 $0088 $49AA
        move.l  #$008BB4FC,($FFFFC96C).w; $21FC $008B $B4FC $C96C
        move.b  #$01,($FFFFC809).w      ; $11FC $0001 $C809
        move.b  #$01,($FFFFC80A).w      ; $11FC $0001 $C80A
        bset    #6,($FFFFC80E).w        ; $08F8 $0006 $C80E
        move.b  #$01,($FFFFC802).w      ; $11FC $0001 $C802
        move.w  #$0001,($FFFFA02C).w    ; $31FC $0001 $A02C
        lea     $00FF1000,a0            ; $41F9 $00FF $1000
        move.w  #$037F,d0               ; $303C $037F
loc_00D5A8:
        clr.l    (a0)+                  ; $4298
        DC.W    $51C8,$FFFC         ; $00D5AA DBRA    D0,loc_00D5A8
        DC.W    $4EBA,$0C0C         ; $00D5AE JSR     loc_00E1BC(PC)
        bclr    #7,$00A15181            ; $08B9 $0007 $00A1 $5181
        lea     $00FF6E00,a0            ; $41F9 $00FF $6E00
        adda.l  #$00000160,a0           ; $D1FC $0000 $0160
        lea     $0088D7B2,a1            ; $43F9 $0088 $D7B2
        move.w  #$003F,d0               ; $303C $003F
loc_00D5D0:
        move.w  (a1)+,d1                ; $3219
        bset    #15,d1                  ; $08C1 $000F
        move.w  d1,(a0)+                ; $30C1
        DC.W    $51C8,$FFF6         ; $00D5D8 DBRA    D0,loc_00D5D0
        lea     $000E8000,a0            ; $41F9 $000E $8000
        movea.l #$06037000,a1           ; $227C $0603 $7000
        DC.W    $6100,$0D2C         ; $00D5E8 BSR.W  $00E316
        btst    #7,($FFFFFDA8).w        ; $0838 $0007 $FDA8
        DC.W    $6718               ; $00D5F2 BEQ.S  loc_00D60C
loc_00D5F4:
        tst.b    $00A15120              ; $4A39 $00A1 $5120
        DC.W    $66F8               ; $00D5FA BNE.S  loc_00D5F4
        move.b  #$2E,$00A15121          ; $13FC $002E $00A1 $5121
        move.b  #$01,$00A15120          ; $13FC $0001 $00A1 $5120
loc_00D60C:
        lea     $000E8C00,a0            ; $41F9 $000E $8C00
        movea.l #$0603D100,a1           ; $227C $0603 $D100
        DC.W    $6100,$0CFC         ; $00D618 BSR.W  $00E316
        tst.b    ($FFFFA024).w          ; $4A38 $A024
        DC.W    $6600,$004E         ; $00D620 BNE.W  loc_00D670
        lea     $000E8A00,a0            ; $41F9 $000E $8A00
        movea.l #$0603B600,a1           ; $227C $0603 $B600
        DC.W    $6100,$0CE4         ; $00D630 BSR.W  $00E316
        lea     $000EB980,a0            ; $41F9 $000E $B980
        movea.l #$0603DA00,a1           ; $227C $0603 $DA00
        DC.W    $6100,$0CD4         ; $00D640 BSR.W  $00E316
        move.w  #$0001,d0               ; $303C $0001
        move.w  #$0001,d1               ; $323C $0001
        move.w  #$0001,d2               ; $343C $0001
        move.w  #$0026,d3               ; $363C $0026
        move.w  #$001A,d4               ; $383C $001A
        lea     $00FF1000,a0            ; $41F9 $00FF $1000
        jsr     sh2_graphics_cmd(pc)    ; $4EBA $0BCC
        lea     $00FF1000,a0            ; $41F9 $00FF $1000
        jsr     sh2_load_data(pc)       ; $4EBA $0C86
        DC.W    $6000,$0068         ; $00D66C BRA.W  loc_00D6D6
loc_00D670:
        lea     $000E8E10,a0            ; $41F9 $000E $8E10
        movea.l #$0603B600,a1           ; $227C $0603 $B600
        DC.W    $6100,$0C98         ; $00D67C BSR.W  $00E316
        lea     $000E8FB0,a0            ; $41F9 $000E $8FB0
        movea.l #$0603DA00,a1           ; $227C $0603 $DA00
        DC.W    $6100,$0C88         ; $00D68C BSR.W  $00E316
        move.w  #$0001,d0               ; $303C $0001
        move.w  #$0001,d1               ; $323C $0001
        move.w  #$0001,d2               ; $343C $0001
        move.w  #$0026,d3               ; $363C $0026
        move.w  #$0016,d4               ; $383C $0016
        lea     $00FF1000,a0            ; $41F9 $00FF $1000
        jsr     sh2_graphics_cmd(pc)    ; $4EBA $0B80
        move.w  #$0002,d0               ; $303C $0002
        move.w  #$0001,d1               ; $323C $0001
        move.w  #$0017,d2               ; $343C $0017
        move.w  #$0026,d3               ; $363C $0026
        move.w  #$0004,d4               ; $383C $0004
        lea     $00FF1000,a0            ; $41F9 $00FF $1000
        jsr     sh2_graphics_cmd(pc)    ; $4EBA $0B62
        lea     $00FF1000,a0            ; $41F9 $00FF $1000
        jsr     sh2_load_data(pc)       ; $4EBA $0C1C
loc_00D6D6:
        clr.b    ($FFFFA027).w          ; $4238 $A027
        moveq   #$00,d0                 ; $7000
        moveq   #$00,d1                 ; $7200
        move.b  ($FFFFFEB1).w,d0        ; $1038 $FEB1
        DC.W    $670C               ; $00D6E2 BEQ.S  loc_00D6F0
        subq.w  #1,d0                   ; $5340
loc_00D6E6:
        addi.l  #$000003C0,d1           ; $0681 $0000 $03C0
        DC.W    $51C8,$FFF8         ; $00D6EC DBRA    D0,loc_00D6E6
loc_00D6F0:
        addq.l  #4,d1                   ; $5881
        move.l  d1,($FFFFA028).w        ; $21C1 $A028
        jsr     $0088204A               ; $4EB9 $0088 $204A
        andi.b  #$FC,$00A15181          ; $0239 $00FC $00A1 $5181
        ori.b  #$01,$00A15181           ; $0039 $0001 $00A1 $5181
        move.w  #$8083,$00A15100        ; $33FC $8083 $00A1 $5100
        bset    #6,($FFFFC875).w        ; $08F8 $0006 $C875
        move.w  ($FFFFC874).w,(a5)      ; $3AB8 $C874
        move.w  #$0020,$00FF0008        ; $33FC $0020 $00FF $0008
        jsr     $00884998               ; $4EB9 $0088 $4998
        move.w  #$0000,($FFFFC87E).w    ; $31FC $0000 $C87E
        move.l  #$0088D864,$00FF0002    ; $23FC $0088 $D864 $00FF $0002
        tst.b    ($FFFFA024).w          ; $4A38 $A024
        DC.W    $670A               ; $00D740 BEQ.S  loc_00D74C
        move.l  #$0088D888,$00FF0002    ; $23FC $0088 $D888 $00FF $0002
loc_00D74C:
        move.b  #$00,$00FF60D4          ; $13FC $0000 $00FF $60D4
        btst    #7,($FFFFFDA8).w        ; $0838 $0007 $FDA8
        DC.W    $6700,$000A         ; $00D75A BEQ.W  loc_00D766
        move.b  #$01,$00FF60D4          ; $13FC $0001 $00FF $60D4
loc_00D766:
        lea     $00FF6100,a0            ; $41F9 $00FF $6100
        move.w  #$007F,d0               ; $303C $007F
loc_00D770:
        clr.l    (a0)+                  ; $4298
        clr.l    (a0)+                  ; $4298
        clr.l    (a0)+                  ; $4298
        clr.l    (a0)+                  ; $4298
        clr.l    (a0)+                  ; $4298
        DC.W    $51C8,$FFF4         ; $00D77A DBRA    D0,loc_00D770
loc_00D77E:
        tst.b    $00A15120              ; $4A39 $00A1 $5120
        DC.W    $66F8               ; $00D784 BNE.S  loc_00D77E
        clr.b    $00A15122              ; $4239 $00A1 $5122
        clr.b    $00A15123              ; $4239 $00A1 $5123
        move.b  #$03,$00A15121          ; $13FC $0003 $00A1 $5121
        move.b  #$01,$00A15120          ; $13FC $0001 $00A1 $5120
loc_00D7A2:
        tst.b    $00A15120              ; $4A39 $00A1 $5120
        DC.W    $66F8               ; $00D7A8 BNE.S  loc_00D7A2
        move.b  #$81,($FFFFC8A5).w      ; $11FC $0081 $C8A5
        rts                             ; $4E75
        neg.b    d0                     ; $4400
        neg.l    -(a3)                  ; $44A3
        DC.W    $4946               ; $00D7B6 DC.W    $4946
        lea     $1C00(a1),a6            ; $4DE9 $1C00
        move.l  -(a3),(a4)              ; $28A3
        move.w  d6,$41E9(a2)            ; $3546 $41E9
        DC.W    $7FFF               ; $00D7C2 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00D7C4 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00D7C6 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00D7C8 MOVE.W  <EA:3F>,<EA:3F>
        move.b  d0,d6                   ; $1C00
        move.l  -(a3),(a4)              ; $28A3
        move.w  d6,$41E9(a2)            ; $3546 $41E9
        neg.b    d0                     ; $4400
        neg.l    -(a3)                  ; $44A3
        DC.W    $4946               ; $00D7D6 DC.W    $4946
        lea     $7FFF(a1),a6            ; $4DE9 $7FFF
        DC.W    $63F5               ; $00D7DC BLS.S  loc_00D7D3
        DC.W    $7FFF               ; $00D7DE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00D7E0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $0010,$14AF         ; $00D7E2 ORI.B  #$14AF,(A0)
        move.l  a6,$3DED(a4)            ; $294E $3DED
        DC.W    $7FFF               ; $00D7EA MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00D7EC MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00D7EE MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $7FFF               ; $00D7F0 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $6337               ; $00D7F2 BLS.S  loc_00D82B
        DC.W    $6737               ; $00D7F4 BEQ.S  loc_00D82D
        DC.W    $6B58               ; $00D7F6 BMI.S  loc_00D850
        DC.W    $6F79               ; $00D7F8 BLE.S  loc_00D873
        DC.W    $6B36               ; $00D7FA BMI.S  loc_00D832
        DC.W    $6B37               ; $00D7FC BMI.S  loc_00D835
        DC.W    $6F58               ; $00D7FE BLE.S  loc_00D858
        DC.W    $6F79               ; $00D800 BLE.S  loc_00D87B
        DC.W    $739A,$61E8         ; $00D802 MOVE.W  (A2)+,-$18(A1,D6.W)
        DC.W    $7FFF               ; $00D806 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $1D4A,$4B3A         ; $00D808 MOVE.B  A2,$4B3A(A6)
        DC.W    $67FF,$3AB6,$25CE   ; $00D80C BEQ.L  $3AB6FDDC
        move.b  -(a1),(a0)+             ; $10E1
        move.l  $4670(a0),(55,a4,d6.w)  ; $29A8 $4670 $6337
loc_00D81A:
        neg.w    d5                     ; $4445
        subq.b  #8,$6212(a3)            ; $512B $6212
        DC.W    $6EF8               ; $00D820 BGT.S  loc_00D81A
        DC.W    $7FFF               ; $00D822 MOVE.W  <EA:3F>,<EA:3F>
        btst    d1,(a7)+                ; $031F
        DC.W    $7FFF               ; $00D826 MOVE.W  <EA:3F>,<EA:3F>
        DC.W    $0000,$033E         ; $00D828 ORI.B  #$033E,D0
        DC.W    $63FF,$01AF,$0086   ; $00D82C BLS.L  $1AFD8B4
loc_00D832:
        ori.b  #$70,d0                  ; $0000 $0070
        btst    d0,(a0)                 ; $0110
        btst    d1,d0                   ; $0300
        ori.b  #$00,d0                  ; $0000 $0000
        btst    d0,(a0)                 ; $0110
        btst    d0,(-64,a0,d0.w)        ; $0130 $02C0
        ori.b  #$00,d0                  ; $0000 $0000
        btst    d0,-(a0)                ; $0120
        bchg    d0,(-64,a0,d0.w)        ; $0170 $02C0
        ori.b  #$00,d0                  ; $0000 $0000
        DC.W    $0000,$0150         ; $00D852 ORI.B  #$0150,D0
        DC.W    $02C0               ; $00D856 DC.W    $02C0
loc_00D858:
        ori.b  #$00,d0                  ; $0000 $0000
        DC.W    $0000,$0180         ; $00D85C ORI.B  #$0180,D0
        DC.W    $02C0               ; $00D860 DC.W    $02C0
        DC.W    $0000,$4EB9         ; $00D862 ORI.B  #$4EB9,D0
        DC.W    $0088,$2080,$3038   ; $00D866 ORI.L  #$20803038,A0
        DC.W    $C87E               ; $00D86C AND.W  <EA:3E>,D4
        DC.W    $227B,$0004         ; $00D86E MOVEA.L $04(PC,D0.W),A1
        jmp     (a1)                    ; $4ED1
        DC.W    $0088,$D8CC,$0088   ; $00D874 ORI.L  #$D8CC0088,A0
        adda.w  d0,a5                   ; $DAC0
        DC.W    $0088,$DCD0,$0088   ; $00D87C ORI.L  #$DCD00088,A0
        adda.l  $0088(a4),a7            ; $DFEC $0088
        lsr.b   #8,d4                   ; $E00C
        jsr     $00882080               ; $4EB9 $0088 $2080
        move.w  ($FFFFC87E).w,d0        ; $3038 $C87E
        DC.W    $227B,$0004         ; $00D892 MOVEA.L $04(PC,D0.W),A1
        jmp     (a1)                    ; $4ED1
        DC.W    $0088,$D8CC,$0088   ; $00D898 ORI.L  #$D8CC0088,A0
        adda.w  d0,a5                   ; $DAC0
        DC.W    $0088,$DECE,$0088   ; $00D8A0 ORI.L  #$DECE0088,A0
        adda.l  $0088(a4),a7            ; $DFEC $0088
        lsr.b   #8,d4                   ; $E00C
        move.b  #$81,($FFFFC8A5).w      ; $11FC $0081 $C8A5
        addq.w  #4,($FFFFC87E).w        ; $5878 $C87E
        rts                             ; $4E75
        jsr     object_update(pc)       ; $4EBA $DDCA
        btst    #6,($FFFFC80E).w        ; $0838 $0006 $C80E
        DC.W    $6606               ; $00D8C2 BNE.S  loc_00D8CA
        addq.w  #4,($FFFFC87E).w        ; $5878 $C87E
        nop                             ; $4E71
loc_00D8CA:
        rts                             ; $4E75
        lea     $00FF6E00,a0            ; $41F9 $00FF $6E00
        lea     $0088DAA8,a1            ; $43F9 $0088 $DAA8
        clr.w    d0                     ; $4240
        move.b  ($FFFFA019).w,d0        ; $1038 $A019
        tst.b    ($FFFFA027).w          ; $4A38 $A027
        DC.W    $6700,$0006         ; $00D8E2 BEQ.W  loc_00D8EA
        move.b  ($FFFFA025).w,d0        ; $1038 $A025
loc_00D8EA:
        add.w   d0,d0                   ; $D040
        add.w   d0,d0                   ; $D040
        movea.l (a1,d0.w),a1            ; $2271 $0000
        move.w  #$007F,d0               ; $303C $007F
loc_00D8F6:
        move.w  (a1)+,(a0)+             ; $30D9
        DC.W    $51C8,$FFFC         ; $00D8F8 DBRA    D0,loc_00D8F6
        lea     $00FF6100,a1            ; $43F9 $00FF $6100
        move.w  #$0001,(a1)             ; $337C $0001 $0000
        move.w  ($FFFFA01A).w,$0002(a1) ; $3378 $A01A $0002
        move.w  ($FFFFA01C).w,$0004(a1) ; $3378 $A01C $0004
        move.w  ($FFFFA01E).w,$0006(a1) ; $3378 $A01E $0006
        move.l  ($FFFFA014).w,d0        ; $2038 $A014
        move.w  d0,$000A(a1)            ; $3340 $000A
        move.w  ($FFFFA020).w,$0008(a1) ; $3378 $A020 $0008
        move.w  ($FFFFA022).w,$000C(a1) ; $3378 $A022 $000C
        move.w  #$0000,$000E(a1)        ; $337C $0000 $000E
        lea     $0088DA90,a0            ; $41F9 $0088 $DA90
        clr.w    d1                     ; $4241
        move.b  ($FFFFA019).w,d1        ; $1238 $A019
        tst.b    ($FFFFA027).w          ; $4A38 $A027
        DC.W    $6704               ; $00D944 BEQ.S  loc_00D94A
        move.b  ($FFFFA025).w,d1        ; $1238 $A025
loc_00D94A:
        add.w   d1,d1                   ; $D241
        add.w   d1,d1                   ; $D241
        move.l  (a0,d1.w),$0010(a1)     ; $2370 $1000 $0010
        move.w  #$0044,$00A15110        ; $33FC $0044 $00A1 $5110
        move.b  #$04,$00A15107          ; $13FC $0004 $00A1 $5107
        clr.b    $00A15123              ; $4239 $00A1 $5123
        move.b  #$2B,$00A15121          ; $13FC $002B $00A1 $5121
        move.b  #$01,$00A15120          ; $13FC $0001 $00A1 $5120
loc_00D97A:
        btst    #1,$00A15123            ; $0839 $0001 $00A1 $5123
        DC.W    $67F6               ; $00D982 BEQ.S  loc_00D97A
        bclr    #1,$00A15123            ; $08B9 $0001 $00A1 $5123
        lea     $00FF60C8,a1            ; $43F9 $00FF $60C8
        lea     $00A15112,a2            ; $45F9 $00A1 $5112
        move.w  #$0043,d7               ; $3E3C $0043
loc_00D99C:
        btst    #7,$00A15107            ; $0839 $0007 $00A1 $5107
        DC.W    $66F6               ; $00D9A4 BNE.S  loc_00D99C
        move.w  (a1)+,(a2)              ; $3499
        DC.W    $51CF,$FFF2         ; $00D9A8 DBRA    D7,loc_00D99C
        move.l  ($FFFFA014).w,d0        ; $2038 $A014
        addi.l  #$00000080,d0           ; $0680 $0000 $0080
        andi.l  #$0000FFFF,d0           ; $0280 $0000 $FFFF
        move.l  d0,($FFFFA014).w        ; $21C0 $A014
        jsr     $0088179E               ; $4EB9 $0088 $179E
        tst.w    ($FFFFA02C).w          ; $4A78 $A02C
        DC.W    $6600,$00B6         ; $00D9CA BNE.W  loc_00DA82
        clr.w    d0                     ; $4240
        move.b  ($FFFFA027).w,d0        ; $1038 $A027
        bsr.w   MemoryInit              ; $6100 $0B56
        move.b  ($FFFFA019).w,d0        ; $1038 $A019
        move.w  ($FFFFC86C).w,d1        ; $3238 $C86C
        btst    #3,d1                   ; $0801 $0003
        DC.W    $6724               ; $00D9E4 BEQ.S  loc_00DA0A
        move.b  #$A9,($FFFFC8A4).w      ; $11FC $00A9 $C8A4
        tst.b    ($FFFFA027).w          ; $4A38 $A027
        DC.W    $6600,$000A         ; $00D9F0 BNE.W  loc_00D9FC
        cmpi.b  #$04,d0                 ; $0C00 $0004
        DC.W    $6C0C               ; $00D9F8 BGE.S  loc_00DA06
        DC.W    $6006               ; $00D9FA BRA.S  loc_00DA02
loc_00D9FC:
        cmpi.b  #$03,d0                 ; $0C00 $0003
        DC.W    $6C04               ; $00DA00 BGE.S  loc_00DA06
loc_00DA02:
        addq.b  #1,d0                   ; $5200
        DC.W    $6078               ; $00DA04 BRA.S  loc_00DA7E
loc_00DA06:
        clr.b    d0                     ; $4200
        DC.W    $6074               ; $00DA08 BRA.S  loc_00DA7E
loc_00DA0A:
        btst    #2,d1                   ; $0801 $0002
        DC.W    $6722               ; $00DA0E BEQ.S  loc_00DA32
        move.b  #$A9,($FFFFC8A4).w      ; $11FC $00A9 $C8A4
        tst.b    d0                     ; $4A00
        DC.W    $6F04               ; $00DA18 BLE.S  loc_00DA1E
        subq.b  #1,d0                   ; $5300
        DC.W    $6060               ; $00DA1C BRA.S  loc_00DA7E
loc_00DA1E:
        tst.b    ($FFFFA027).w          ; $4A38 $A027
        DC.W    $6600,$0008         ; $00DA22 BNE.W  loc_00DA2C
        move.b  #$04,d0                 ; $103C $0004
        DC.W    $6052               ; $00DA2A BRA.S  loc_00DA7E
loc_00DA2C:
        move.b  #$03,d0                 ; $103C $0003
        DC.W    $604C               ; $00DA30 BRA.S  loc_00DA7E
loc_00DA32:
        tst.b    ($FFFFA024).w          ; $4A38 $A024
        DC.W    $6746               ; $00DA36 BEQ.S  loc_00DA7E
        btst    #0,d1                   ; $0801 $0000
        DC.W    $6700,$001C         ; $00DA3C BEQ.W  loc_00DA5A
        tst.b    ($FFFFA027).w          ; $4A38 $A027
        DC.W    $6738               ; $00DA44 BEQ.S  loc_00DA7E
        move.b  #$A9,($FFFFC8A4).w      ; $11FC $00A9 $C8A4
        clr.b    ($FFFFA027).w          ; $4238 $A027
        move.b  d0,($FFFFA026).w        ; $11C0 $A026
        move.b  ($FFFFA025).w,d0        ; $1038 $A025
        DC.W    $6024               ; $00DA58 BRA.S  loc_00DA7E
loc_00DA5A:
        btst    #1,d1                   ; $0801 $0001
        DC.W    $6700,$001E         ; $00DA5E BEQ.W  loc_00DA7E
        cmpi.b  #$01,($FFFFA027).w      ; $0C38 $0001 $A027
        DC.W    $6C14               ; $00DA68 BGE.S  loc_00DA7E
        move.b  #$A9,($FFFFC8A4).w      ; $11FC $00A9 $C8A4
        move.b  #$01,($FFFFA027).w      ; $11FC $0001 $A027
        move.b  d0,($FFFFA025).w        ; $11C0 $A025
        move.b  ($FFFFA026).w,d0        ; $1038 $A026
loc_00DA7E:
        move.b  d0,($FFFFA019).w        ; $11C0 $A019
loc_00DA82:
        addq.w  #4,($FFFFC87E).w        ; $5878 $C87E
        move.w  #$0020,$00FF0008        ; $33FC $0020 $00FF $0008
        rts                             ; $4E75
        move.l  $6AE2(a1),d1            ; $2229 $6AE2
        move.l  (-$7BF4)(a1),d1         ; $2229 $840C
        move.l  (-$5D12)(a1),d1         ; $2229 $A2EE
        move.l  (-$4608)(a1),d1         ; $2229 $B9F8
        move.l  (-$2CD4)(a1),d1         ; $2229 $D32C
        move.l  $6AE2(a1),d1            ; $2229 $6AE2
        DC.W    $008B,$B65C,$008B   ; $00DAA8 ORI.L  #$B65C008B,A3
        eor.w   d3,(a4)+                ; $B75C
        DC.W    $008B,$B85C,$008B   ; $00DAB0 ORI.L  #$B85C008B,A3
        eor.w   d4,(a4)+                ; $B95C
        DC.W    $008B,$BA5C,$008B   ; $00DAB8 ORI.L  #$BA5C008B,A3
        cmp.w   (a4)+,d3                ; $B65C
        clr.w    d0                     ; $4240
        move.b  ($FFFFA027).w,d0        ; $1038 $A027
        jsr     MemoryInit(pc)          ; $4EBA $0A64
        movea.l #$0603D100,a0           ; $207C $0603 $D100
        movea.l #$24004C58,a1           ; $227C $2400 $4C58
        move.w  #$0090,d0               ; $303C $0090
        move.w  #$0010,d1               ; $323C $0010
        DC.W    $6100,$087A         ; $00DADE BSR.W  $00E35A
        clr.w    d0                     ; $4240
        move.b  ($FFFFA019).w,d0        ; $1038 $A019
        tst.b    ($FFFFA027).w          ; $4A38 $A027
        DC.W    $6700,$0006         ; $00DAEC BEQ.W  loc_00DAF4
        move.b  ($FFFFA025).w,d0        ; $1038 $A025
loc_00DAF4:
        add.w   d0,d0                   ; $D040
        move.w  d0,d1                   ; $3200
        add.w   d0,d0                   ; $D040
        add.w   d0,d0                   ; $D040
        add.w   d1,d0                   ; $D041
        lea     $00FF2000,a0            ; $41F9 $00FF $2000
        move.w  (a0,d0.w),($FFFFA01A).w ; $31F0 $0000 $A01A
        move.w  (2,a0,d0.w),($FFFFA01C).w; $31F0 $0002 $A01C
        move.w  (4,a0,d0.w),($FFFFA01E).w; $31F0 $0004 $A01E
        move.w  (6,a0,d0.w),($FFFFA020).w; $31F0 $0006 $A020
        move.w  (8,a0,d0.w),($FFFFA022).w; $31F0 $0008 $A022
        move.w  ($FFFFC86E).w,d1        ; $3238 $C86E
        lsr.l   #8,d1                   ; $E089
        btst    #7,d1                   ; $0801 $0007
        DC.W    $6700,$0130         ; $00DB2C BEQ.W  loc_00DC5E
        btst    #5,d1                   ; $0801 $0005
        DC.W    $6600,$00CE         ; $00DB34 BNE.W  loc_00DC04
        btst    #0,d1                   ; $0801 $0000
        DC.W    $671C               ; $00DB3C BEQ.S  loc_00DB5A
        move.w  ($FFFFA01C).w,d0        ; $3038 $A01C
        bsr.w   positive_velocity_step_small_inc; $6100 $0168
        cmpi.w  #$02F0,d0               ; $0C40 $02F0
        DC.W    $6D00,$0006         ; $00DB4A BLT.W  loc_00DB52
        move.w  #$02F0,d0               ; $303C $02F0
loc_00DB52:
        move.w  d0,($FFFFA01C).w        ; $31C0 $A01C
        DC.W    $6000,$0106         ; $00DB56 BRA.W  loc_00DC5E
loc_00DB5A:
        btst    #1,d1                   ; $0801 $0001
        DC.W    $671C               ; $00DB5E BEQ.S  loc_00DB7C
        move.w  ($FFFFA01C).w,d0        ; $3038 $A01C
        bsr.w   negative_velocity_step_small_dec; $6100 $0158
        cmpi.w  #$FBFE,d0               ; $0C40 $FBFE
        DC.W    $6E00,$0006         ; $00DB6C BGT.W  loc_00DB74
        move.w  #$FBFE,d0               ; $303C $FBFE
loc_00DB74:
        move.w  d0,($FFFFA01C).w        ; $31C0 $A01C
        DC.W    $6000,$00E4         ; $00DB78 BRA.W  loc_00DC5E
loc_00DB7C:
        btst    #3,d1                   ; $0801 $0003
        DC.W    $671C               ; $00DB80 BEQ.S  loc_00DB9E
        move.w  ($FFFFA01A).w,d0        ; $3038 $A01A
        bsr.w   positive_velocity_step_small_inc; $6100 $0124
        cmpi.w  #$0120,d0               ; $0C40 $0120
        DC.W    $6D00,$0006         ; $00DB8E BLT.W  loc_00DB96
        move.w  #$0120,d0               ; $303C $0120
loc_00DB96:
        move.w  d0,($FFFFA01A).w        ; $31C0 $A01A
        DC.W    $6000,$00C2         ; $00DB9A BRA.W  loc_00DC5E
loc_00DB9E:
        btst    #2,d1                   ; $0801 $0002
        DC.W    $671C               ; $00DBA2 BEQ.S  loc_00DBC0
        move.w  ($FFFFA01A).w,d0        ; $3038 $A01A
        bsr.w   negative_velocity_step_small_dec; $6100 $0114
        cmpi.w  #$FEE0,d0               ; $0C40 $FEE0
        DC.W    $6E00,$0006         ; $00DBB0 BGT.W  loc_00DBB8
        move.w  #$FEE0,d0               ; $303C $FEE0
loc_00DBB8:
        move.w  d0,($FFFFA01A).w        ; $31C0 $A01A
        DC.W    $6000,$00A0         ; $00DBBC BRA.W  loc_00DC5E
loc_00DBC0:
        btst    #6,d1                   ; $0801 $0006
        DC.W    $671C               ; $00DBC4 BEQ.S  loc_00DBE2
        move.w  ($FFFFA01E).w,d0        ; $3038 $A01E
        bsr.w   positive_velocity_step_small_inc; $6100 $00E0
        cmpi.w  #$0460,d0               ; $0C40 $0460
        DC.W    $6D00,$0006         ; $00DBD2 BLT.W  loc_00DBDA
        move.w  #$0460,d0               ; $303C $0460
loc_00DBDA:
        move.w  d0,($FFFFA01E).w        ; $31C0 $A01E
        DC.W    $6000,$007E         ; $00DBDE BRA.W  loc_00DC5E
loc_00DBE2:
        btst    #4,d1                   ; $0801 $0004
        DC.W    $6776               ; $00DBE6 BEQ.S  loc_00DC5E
        move.w  ($FFFFA01E).w,d0        ; $3038 $A01E
        bsr.w   negative_velocity_step_small_dec; $6100 $00D0
        cmpi.w  #$0050,d0               ; $0C40 $0050
        DC.W    $6E00,$0006         ; $00DBF4 BGT.W  loc_00DBFC
        move.w  #$0050,d0               ; $303C $0050
loc_00DBFC:
        move.w  d0,($FFFFA01E).w        ; $31C0 $A01E
        DC.W    $6000,$005C         ; $00DC00 BRA.W  loc_00DC5E
loc_00DC04:
        btst    #0,d1                   ; $0801 $0000
        DC.W    $6710               ; $00DC08 BEQ.S  loc_00DC1A
        move.w  ($FFFFA020).w,d0        ; $3038 $A020
        bsr.w   positive_velocity_step_small_inc+12; $6100 $00A8
        move.w  d0,($FFFFA020).w        ; $31C0 $A020
        DC.W    $6000,$0046         ; $00DC16 BRA.W  loc_00DC5E
loc_00DC1A:
        btst    #1,d1                   ; $0801 $0001
        DC.W    $6710               ; $00DC1E BEQ.S  loc_00DC30
        move.w  ($FFFFA020).w,d0        ; $3038 $A020
        bsr.w   negative_velocity_step_small_dec+12; $6100 $00A4
        move.w  d0,($FFFFA020).w        ; $31C0 $A020
        DC.W    $6000,$0030         ; $00DC2C BRA.W  loc_00DC5E
loc_00DC30:
        btst    #3,d1                   ; $0801 $0003
        DC.W    $6710               ; $00DC34 BEQ.S  loc_00DC46
        move.w  ($FFFFA022).w,d0        ; $3038 $A022
        bsr.w   positive_velocity_step_small_inc+12; $6100 $007C
        move.w  d0,($FFFFA022).w        ; $31C0 $A022
        DC.W    $6000,$001A         ; $00DC42 BRA.W  loc_00DC5E
loc_00DC46:
        btst    #2,d1                   ; $0801 $0002
        DC.W    $6712               ; $00DC4A BEQ.S  loc_00DC5E
        move.w  ($FFFFA022).w,d0        ; $3038 $A022
        bsr.w   negative_velocity_step_small_dec+12; $6100 $0078
        move.w  d0,($FFFFA022).w        ; $31C0 $A022
        DC.W    $6000,$0004         ; $00DC58 BRA.W  loc_00DC5E
        nop                             ; $4E71
loc_00DC5E:
        clr.w    d0                     ; $4240
        move.b  ($FFFFA019).w,d0        ; $1038 $A019
        tst.b    ($FFFFA027).w          ; $4A38 $A027
        DC.W    $6700,$0006         ; $00DC68 BEQ.W  loc_00DC70
        move.b  ($FFFFA025).w,d0        ; $1038 $A025
loc_00DC70:
        add.w   d0,d0                   ; $D040
        move.w  d0,d1                   ; $3200
        add.w   d0,d0                   ; $D040
        add.w   d0,d0                   ; $D040
        add.w   d1,d0                   ; $D041
        lea     $00FF2000,a0            ; $41F9 $00FF $2000
        move.w  ($FFFFA01A).w,(a0,d0.w) ; $31B8 $A01A $0000
        move.w  ($FFFFA01C).w,(2,a0,d0.w); $31B8 $A01C $0002
        move.w  ($FFFFA01E).w,(4,a0,d0.w); $31B8 $A01E $0004
        move.w  ($FFFFA020).w,(6,a0,d0.w); $31B8 $A020 $0006
        move.w  ($FFFFA022).w,(8,a0,d0.w); $31B8 $A022 $0008
        move.w  #$0020,$00FF0008        ; $33FC $0020 $00FF $0008
        addq.w  #4,($FFFFC87E).w        ; $5878 $C87E
        rts                             ; $4E75
loc_00DCAC:
        cmpi.w  #$4000,d0               ; $0C40 $4000
        DC.W    $6E0A               ; $00DCB0 BGT.S  loc_00DCBC
        addi.w  #$0010,d0               ; $0640 $0010
        DC.W    $6004               ; $00DCB6 BRA.S  loc_00DCBC
loc_00DCB8:
        addi.w  #$0040,d0               ; $0640 $0040
loc_00DCBC:
        rts                             ; $4E75
loc_00DCBE:
        cmpi.w  #$C000,d0               ; $0C40 $C000
        DC.W    $6D0A               ; $00DCC2 BLT.S  loc_00DCCE
        subi.w  #$0010,d0               ; $0440 $0010
        DC.W    $6004               ; $00DCC8 BRA.S  loc_00DCCE
loc_00DCCA:
        subi.w  #$0040,d0               ; $0440 $0040
loc_00DCCE:
        rts                             ; $4E75
        clr.w    d0                     ; $4240
        jsr     MemoryInit(pc)          ; $4EBA $0858
        jsr     object_update(pc)       ; $4EBA $D9AC
        jsr     animated_seq_player+10(pc); $4EBA $D9FE
loc_00DCDE:
        tst.b    $00A15120              ; $4A39 $00A1 $5120
        DC.W    $66F8               ; $00DCE4 BNE.S  loc_00DCDE
        movea.l #$06037000,a0           ; $207C $0603 $7000
        movea.l #$24018010,a1           ; $227C $2401 $8010
        move.w  #$0120,d0               ; $303C $0120
        move.w  #$0030,d1               ; $323C $0030
        DC.W    $6100,$065E         ; $00DCFA BSR.W  $00E35A
        btst    #7,($FFFFFDA8).w        ; $0838 $0007 $FDA8
        DC.W    $6600,$0036         ; $00DD04 BNE.W  loc_00DD3C
        movea.l #$0603A600,a0           ; $207C $0603 $A600
        moveq   #$00,d3                 ; $7600
        move.w  #$0004,d4               ; $383C $0004
loc_00DD14:
        btst    d3,($FFFFEF07).w        ; $0738 $EF07
        DC.W    $671C               ; $00DD18 BEQ.S  loc_00DD36
        lea     $0088DEB6,a1            ; $43F9 $0088 $DEB6
        move.w  d3,d0                   ; $3003
        add.w   d0,d0                   ; $D040
        add.w   d0,d0                   ; $D040
        movea.l (a1,d0.w),a1            ; $2271 $0000
        move.w  #$0010,d0               ; $303C $0010
        move.w  #$0010,d1               ; $323C $0010
        DC.W    $6100,$0626         ; $00DD32 BSR.W  $00E35A
loc_00DD36:
        addq.w  #1,d3                   ; $5243
        DC.W    $51CC,$FFDA         ; $00DD38 DBRA    D4,loc_00DD14
loc_00DD3C:
        movea.l #$0603B600,a0           ; $207C $0603 $B600
        movea.l #$24014010,a1           ; $227C $2401 $4010
        move.w  #$0120,d0               ; $303C $0120
        move.w  #$0018,d1               ; $323C $0018
        DC.W    $6100,$0608         ; $00DD50 BSR.W  $00E35A
        lea     $24034850,a1            ; $43F9 $2403 $4850
        lea     ($FFFFEF08).w,a2        ; $45F8 $EF08
        adda.l  ($FFFFA028).w,a2        ; $D5F8 $A028
        moveq   #$00,d0                 ; $7000
        move.b  ($FFFFA019).w,d0        ; $1038 $A019
        add.w   d0,d0                   ; $D040
        add.w   d0,d0                   ; $D040
        add.w   d0,d0                   ; $D040
        add.w   d0,d0                   ; $D040
        move.w  d0,d1                   ; $3200
        add.w   d0,d0                   ; $D040
        add.w   d0,d0                   ; $D040
        add.w   d1,d0                   ; $D041
        add.w   d0,d0                   ; $D040
        adda.l  d0,a2                   ; $D5C0
        btst    #7,($FFFFFDA8).w        ; $0838 $0007 $FDA8
        DC.W    $6700,$0008         ; $00DD82 BEQ.W  loc_00DD8C
        lea     $0088DECA,a2            ; $45F9 $0088 $DECA
loc_00DD8C:
        jsr     ByteProcessLoop(pc)     ; $4EBA $06D8
        lea     $240348E8,a1            ; $43F9 $2403 $48E8
        lea     ($FFFFFA48).w,a2        ; $45F8 $FA48
        moveq   #$00,d0                 ; $7000
        move.b  ($FFFFFEB1).w,d0        ; $1038 $FEB1
        add.w   d0,d0                   ; $D040
        add.w   d0,d0                   ; $D040
        add.w   d0,d0                   ; $D040
        move.w  d0,d1                   ; $3200
        add.w   d0,d0                   ; $D040
        add.w   d1,d0                   ; $D041
        add.w   d0,d0                   ; $D040
        adda.l  d0,a2                   ; $D5C0
        moveq   #$00,d0                 ; $7000
        move.b  ($FFFFA019).w,d0        ; $1038 $A019
        add.w   d0,d0                   ; $D040
        add.w   d0,d0                   ; $D040
        add.w   d0,d0                   ; $D040
        addq.w  #4,d0                   ; $5840
        adda.l  d0,a2                   ; $D5C0
        btst    #7,($FFFFFDA8).w        ; $0838 $0007 $FDA8
        DC.W    $6700,$0008         ; $00DDC6 BEQ.W  loc_00DDD0
        lea     $0088DECA,a2            ; $45F9 $0088 $DECA
loc_00DDD0:
        jsr     ByteProcessLoop(pc)     ; $4EBA $0694
        moveq   #$00,d0                 ; $7000
        move.b  ($FFFFA019).w,d0        ; $1038 $A019
        lea     $0088DE98,a1            ; $43F9 $0088 $DE98
        add.w   d0,d0                   ; $D040
        move.w  d0,d1                   ; $3200
        add.w   d0,d0                   ; $D040
        add.w   d1,d0                   ; $D041
        movea.l (a1,d0.w),a0            ; $2071 $0000
        move.w  (4,a1,d0.w),d0          ; $3031 $0004
        move.w  #$0030,d1               ; $323C $0030
        move.w  #$0010,d2               ; $343C $0010
loc_00DDF8:
        tst.b    $00A15120              ; $4A39 $00A1 $5120
        DC.W    $66F8               ; $00DDFE BNE.S  loc_00DDF8
        bsr.w   sh2_cmd_27              ; $6100 $05B2
        move.w  #$0018,$00FF0008        ; $33FC $0018 $00FF $0008
        cmpi.w  #$0001,($FFFFA02C).w    ; $0C78 $0001 $A02C
        DC.W    $6700,$0054         ; $00DE12 BEQ.W  loc_00DE68
        cmpi.w  #$0002,($FFFFA02C).w    ; $0C78 $0002 $A02C
        DC.W    $6700,$005A         ; $00DE1C BEQ.W  loc_00DE78
        move.w  ($FFFFC86C).w,d1        ; $3238 $C86C
        andi.b  #$E0,d1                 ; $0201 $00E0
        DC.W    $6616               ; $00DE28 BNE.S  loc_00DE40
        move.w  ($FFFFC86C).w,d1        ; $3238 $C86C
        andi.b  #$10,d1                 ; $0201 $0010
        DC.W    $6608               ; $00DE32 BNE.S  loc_00DE3C
        subq.w  #8,($FFFFC87E).w        ; $5178 $C87E
        DC.W    $6000,$0056         ; $00DE38 BRA.W  loc_00DE90
loc_00DE3C:
        st      ($FFFFA018).w           ; $50F8 $A018
loc_00DE40:
        move.b  #$A8,($FFFFC8A4).w      ; $11FC $00A8 $C8A4
        move.b  #$01,($FFFFC809).w      ; $11FC $0001 $C809
        move.b  #$01,($FFFFC80A).w      ; $11FC $0001 $C80A
        bset    #7,($FFFFC80E).w        ; $08F8 $0007 $C80E
        move.b  #$01,($FFFFC802).w      ; $11FC $0001 $C802
        move.w  #$0002,($FFFFA02C).w    ; $31FC $0002 $A02C
        DC.W    $6000,$0026         ; $00DE64 BRA.W  loc_00DE8C
loc_00DE68:
        btst    #6,($FFFFC80E).w        ; $0838 $0006 $C80E
        DC.W    $661C               ; $00DE6E BNE.S  loc_00DE8C
        clr.w    ($FFFFA02C).w          ; $4278 $A02C
        DC.W    $6000,$0016         ; $00DE74 BRA.W  loc_00DE8C
loc_00DE78:
        btst    #7,($FFFFC80E).w        ; $0838 $0007 $C80E
        DC.W    $660C               ; $00DE7E BNE.S  loc_00DE8C
        clr.w    ($FFFFA02C).w          ; $4278 $A02C
        addq.w  #4,($FFFFC87E).w        ; $5878 $C87E
        DC.W    $6000,$0006         ; $00DE88 BRA.W  loc_00DE90
loc_00DE8C:
        subq.w  #8,($FFFFC87E).w        ; $5178 $C87E
loc_00DE90:
        move.b  #$01,($FFFFC821).w      ; $11FC $0001 $C821
        rts                             ; $4E75
        move.l  d1,d2                   ; $2401
        or.b    (a0),d0                 ; $8010
        DC.W    $003A,$2401,$8049   ; $00DE9C ORI.B  #$2401,-$7FB7(PC)
        DC.W    $003B,$2401,$8083   ; $00DEA2 ORI.B  #$2401,-$7D(PC,A0.W)
        DC.W    $003A,$2401,$80BC   ; $00DEA8 ORI.B  #$2401,-$7F44(PC)
        DC.W    $003A,$2401,$80F5   ; $00DEAE ORI.B  #$2401,-$7F0B(PC)
        DC.W    $003B,$2403,$8412   ; $00DEB4 ORI.B  #$2403,$12(PC,A0.W)
        move.l  d3,d2                   ; $2403
        DC.W    $844C               ; $00DEBC OR.W   A4,D2
        move.l  d3,d2                   ; $2403
        or.l    d6,d2                   ; $8486
        move.l  d3,d2                   ; $2403
        DC.W    $84BE               ; $00DEC4 OR.L   <EA:3E>,D2
        move.l  d3,d2                   ; $2403
        divu.w  ($FFFFCCCC).w,d2        ; $84F8 $CCCC
        DC.W    $0CCC               ; $00DECC DC.W    $0CCC
        clr.w    d0                     ; $4240
        move.b  ($FFFFA027).w,d0        ; $1038 $A027
        jsr     MemoryInit(pc)          ; $4EBA $0656
        jsr     object_update(pc)       ; $4EBA $D7AA
        jsr     animated_seq_player+10(pc); $4EBA $D7FC
loc_00DEE0:
        tst.b    $00A15120              ; $4A39 $00A1 $5120
        DC.W    $66F8               ; $00DEE6 BNE.S  loc_00DEE0
        movea.l #$06037000,a0           ; $207C $0603 $7000
        movea.l #$24014010,a1           ; $227C $2401 $4010
        move.w  #$0120,d0               ; $303C $0120
        move.w  #$0030,d1               ; $323C $0030
        DC.W    $6100,$045C         ; $00DEFC BSR.W  $00E35A
        movea.l #$0603B600,a0           ; $207C $0603 $B600
        movea.l #$2401C010,a1           ; $227C $2401 $C010
        move.w  #$0120,d0               ; $303C $0120
        move.w  #$0010,d1               ; $323C $0010
        DC.W    $6100,$0444         ; $00DF14 BSR.W  $00E35A
loc_00DF18:
        tst.b    $00A15120              ; $4A39 $00A1 $5120
        DC.W    $66F8               ; $00DF1E BNE.S  loc_00DF18
        bsr.w   sh2_cmd_27_sprite_render; $6100 $01F6
        movea.l #$0603DA00,a0           ; $207C $0603 $DA00
        movea.l #$2401AC88,a1           ; $227C $2401 $AC88
        move.w  #$0038,d0               ; $303C $0038
        move.w  #$0010,d1               ; $323C $0010
        DC.W    $6100,$0420         ; $00DF38 BSR.W  $00E35A
        move.w  #$0018,$00FF0008        ; $33FC $0018 $00FF $0008
        cmpi.w  #$0001,($FFFFA02C).w    ; $0C78 $0001 $A02C
        DC.W    $6700,$0070         ; $00DF4A BEQ.W  loc_00DFBC
        cmpi.w  #$0002,($FFFFA02C).w    ; $0C78 $0002 $A02C
        DC.W    $6700,$0076         ; $00DF54 BEQ.W  loc_00DFCC
        move.w  ($FFFFC86C).w,d1        ; $3238 $C86C
        andi.b  #$E0,d1                 ; $0201 $00E0
        DC.W    $6632               ; $00DF60 BNE.S  loc_00DF94
        cmpi.b  #$02,($FFFFA024).w      ; $0C38 $0002 $A024
        DC.W    $6600,$0014         ; $00DF68 BNE.W  loc_00DF7E
        move.w  ($FFFFC86E).w,d1        ; $3238 $C86E
        move.w  d1,d2                   ; $3401
        andi.b  #$E0,d2                 ; $0202 $00E0
        DC.W    $661C               ; $00DF76 BNE.S  loc_00DF94
        andi.b  #$10,d1                 ; $0201 $0010
        DC.W    $6612               ; $00DF7C BNE.S  loc_00DF90
loc_00DF7E:
        move.w  ($FFFFC86C).w,d1        ; $3238 $C86C
        andi.b  #$10,d1                 ; $0201 $0010
        DC.W    $6608               ; $00DF86 BNE.S  loc_00DF90
        subq.w  #8,($FFFFC87E).w        ; $5178 $C87E
        DC.W    $6000,$0056         ; $00DF8C BRA.W  loc_00DFE4
loc_00DF90:
        st      ($FFFFA018).w           ; $50F8 $A018
loc_00DF94:
        move.b  #$A8,($FFFFC8A4).w      ; $11FC $00A8 $C8A4
        move.b  #$01,($FFFFC809).w      ; $11FC $0001 $C809
        move.b  #$01,($FFFFC80A).w      ; $11FC $0001 $C80A
        bset    #7,($FFFFC80E).w        ; $08F8 $0007 $C80E
        move.b  #$01,($FFFFC802).w      ; $11FC $0001 $C802
        move.w  #$0002,($FFFFA02C).w    ; $31FC $0002 $A02C
        DC.W    $6000,$0026         ; $00DFB8 BRA.W  loc_00DFE0
loc_00DFBC:
        btst    #6,($FFFFC80E).w        ; $0838 $0006 $C80E
        DC.W    $661C               ; $00DFC2 BNE.S  loc_00DFE0
        clr.w    ($FFFFA02C).w          ; $4278 $A02C
        DC.W    $6000,$0016         ; $00DFC8 BRA.W  loc_00DFE0
loc_00DFCC:
        btst    #7,($FFFFC80E).w        ; $0838 $0007 $C80E
        DC.W    $660C               ; $00DFD2 BNE.S  loc_00DFE0
        clr.w    ($FFFFA02C).w          ; $4278 $A02C
        addq.w  #4,($FFFFC87E).w        ; $5878 $C87E
        DC.W    $6000,$0006         ; $00DFDC BRA.W  loc_00DFE4
loc_00DFE0:
        subq.w  #8,($FFFFC87E).w        ; $5178 $C87E
loc_00DFE4:
        move.b  #$01,($FFFFC821).w      ; $11FC $0001 $C821
        rts                             ; $4E75
        tst.b    ($FFFFA018).w          ; $4A38 $A018
        DC.W    $6614               ; $00DFF0 BNE.S  loc_00E006
        move.b  #$F3,($FFFFC822).w      ; $11FC $00F3 $C822
loc_00DFF8:
        tst.b    $00A15120              ; $4A39 $00A1 $5120
        DC.W    $66F8               ; $00DFFE BNE.S  loc_00DFF8
        clr.b    $00A15123              ; $4239 $00A1 $5123
loc_00E006:
        addq.w  #4,($FFFFC87E).w        ; $5878 $C87E
        rts                             ; $4E75
        tst.b    ($FFFFA027).w          ; $4A38 $A027
        DC.W    $6600,$000A         ; $00E010 BNE.W  loc_00E01C
        move.b  ($FFFFA019).w,($FFFFA025).w; $11F8 $A019 $A025
        DC.W    $6006               ; $00E01A BRA.S  loc_00E022
loc_00E01C:
        move.b  ($FFFFA019).w,($FFFFA026).w; $11F8 $A019 $A026
loc_00E022:
        tst.b    ($FFFFA024).w          ; $4A38 $A024
        DC.W    $6718               ; $00E026 BEQ.S  loc_00E040
        cmpi.b  #$01,($FFFFA024).w      ; $0C38 $0001 $A024
        DC.W    $672A               ; $00E02E BEQ.S  loc_00E05A
        move.b  ($FFFFA025).w,($FFFFFEAB).w; $11F8 $A025 $FEAB
        move.b  ($FFFFA026).w,($FFFFFEAC).w; $11F8 $A026 $FEAC
        DC.W    $6000,$0028         ; $00E03C BRA.W  loc_00E066
loc_00E040:
        move.b  ($FFFFA019).w,($FFFFFEA5).w; $11F8 $A019 $FEA5
        btst    #7,($FFFFFDA8).w        ; $0838 $0007 $FDA8
        DC.W    $6700,$0018         ; $00E04C BEQ.W  loc_00E066
        move.b  ($FFFFA019).w,($FFFFFEA6).w; $11F8 $A019 $FEA6
        DC.W    $6000,$000E         ; $00E056 BRA.W  loc_00E066
loc_00E05A:
        move.b  ($FFFFA025).w,($FFFFFEA7).w; $11F8 $A025 $FEA7
        move.b  ($FFFFA026).w,($FFFFFEA8).w; $11F8 $A026 $FEA8
loc_00E066:
        move.w  #$0000,($FFFFC87E).w    ; $31FC $0000 $C87E
        move.l  #$0088E5CE,$00FF0002    ; $23FC $0088 $E5CE $00FF $0002
        cmpi.b  #$01,($FFFFA024).w      ; $0C38 $0001 $A024
        DC.W    $671C               ; $00E07C BEQ.S  loc_00E09A
        cmpi.b  #$02,($FFFFA024).w      ; $0C38 $0002 $A024
        DC.W    $6720               ; $00E084 BEQ.S  loc_00E0A6
        btst    #7,($FFFFFDA8).w        ; $0838 $0007 $FDA8
        DC.W    $6722               ; $00E08C BEQ.S  loc_00E0B0
        move.l  #$0088E5E6,$00FF0002    ; $23FC $0088 $E5E6 $00FF $0002
        DC.W    $6016               ; $00E098 BRA.S  loc_00E0B0
loc_00E09A:
        move.l  #$0088E5FE,$00FF0002    ; $23FC $0088 $E5FE $00FF $0002
        DC.W    $600A               ; $00E0A4 BRA.S  loc_00E0B0
loc_00E0A6:
        move.l  #$0088F13C,$00FF0002    ; $23FC $0088 $F13C $00FF $0002
loc_00E0B0:
        tst.b    ($FFFFA018).w          ; $4A38 $A018
        DC.W    $6660               ; $00E0B4 BNE.S  loc_00E116
        move.l  #$00884D98,$00FF0002    ; $23FC $0088 $4D98 $00FF $0002
        cmpi.b  #$01,($FFFFA024).w      ; $0C38 $0001 $A024
        DC.W    $6700,$001A         ; $00E0C6 BEQ.W  loc_00E0E2
        cmpi.b  #$02,($FFFFA024).w      ; $0C38 $0002 $A024
        DC.W    $6700,$002A         ; $00E0D0 BEQ.W  loc_00E0FC
        move.l  #$00884A3E,$00FF0002    ; $23FC $0088 $4A3E $00FF $0002
        DC.W    $6000,$0036         ; $00E0DE BRA.W  loc_00E116
loc_00E0E2:
        bset    #5,($FFFFC80E).w        ; $08F8 $0005 $C80E
        bclr    #4,($FFFFC80E).w        ; $08B8 $0004 $C80E
        move.l  #$00885100,$00FF0002    ; $23FC $0088 $5100 $00FF $0002
        DC.W    $6000,$001C         ; $00E0F8 BRA.W  loc_00E116
loc_00E0FC:
        bset    #4,($FFFFC80E).w        ; $08F8 $0004 $C80E
        bclr    #5,($FFFFC80E).w        ; $08B8 $0005 $C80E
        move.l  #$00884D98,$00FF0002    ; $23FC $0088 $4D98 $00FF $0002
        DC.W    $6000,$0002         ; $00E112 BRA.W  loc_00E116
loc_00E116:
        rts                             ; $4E75
loc_00E118:
        moveq   #$00,d0                 ; $7000
        tst.b    ($FFFFA027).w          ; $4A38 $A027
        DC.W    $6606               ; $00E11E BNE.S  loc_00E126
        move.b  ($FFFFA019).w,d0        ; $1038 $A019
        DC.W    $6004               ; $00E124 BRA.S  loc_00E12A
loc_00E126:
        move.b  ($FFFFA025).w,d0        ; $1038 $A025
loc_00E12A:
        lea     $0088E19E,a1            ; $43F9 $0088 $E19E
        add.w   d0,d0                   ; $D040
        move.w  d0,d1                   ; $3200
        add.w   d0,d0                   ; $D040
        add.w   d1,d0                   ; $D041
        movea.l (a1,d0.w),a0            ; $2071 $0000
        move.w  (4,a1,d0.w),d0          ; $3031 $0004
        move.w  #$0030,d1               ; $323C $0030
        move.w  #$0010,d2               ; $343C $0010
        jsr     sh2_cmd_27(pc)          ; $4EBA $026A
        moveq   #$00,d0                 ; $7000
        tst.b    ($FFFFA027).w          ; $4A38 $A027
        DC.W    $6706               ; $00E152 BEQ.S  loc_00E15A
        move.b  ($FFFFA019).w,d0        ; $1038 $A019
        DC.W    $6004               ; $00E158 BRA.S  loc_00E15E
loc_00E15A:
        move.b  ($FFFFA026).w,d0        ; $1038 $A026
loc_00E15E:
        move.b  d0,d3                   ; $1600
        movea.l #$0401C010,a0           ; $207C $0401 $C010
        add.w   d0,d0                   ; $D040
        add.w   d0,d0                   ; $D040
        add.w   d0,d0                   ; $D040
        move.w  d0,d1                   ; $3200
        add.w   d0,d0                   ; $D040
        add.w   d0,d0                   ; $D040
        add.w   d0,d0                   ; $D040
        add.w   d1,d0                   ; $D041
        lea     (a0,d0.w),a0            ; $41F0 $0000
        move.w  #$0049,d0               ; $303C $0049
        move.w  #$0010,d1               ; $323C $0010
        move.w  #$0010,d2               ; $343C $0010
        tst.b    d3                     ; $4A03
        DC.W    $6706               ; $00E188 BEQ.S  loc_00E190
        move.w  #$0048,d0               ; $303C $0048
        subq.l  #1,a0                   ; $5388
loc_00E190:
        tst.b    $00A15120              ; $4A39 $00A1 $5120
        DC.W    $66F8               ; $00E196 BNE.S  loc_00E190
        jsr     sh2_cmd_27(pc)          ; $4EBA $021A
        rts                             ; $4E75
        DC.W    $0401,$4010         ; $00E19E SUBI.B  #$4010,D1
        DC.W    $003A,$0401,$4049   ; $00E1A2 ORI.B  #$0401,$4049(PC)
        DC.W    $003B,$0401,$4083   ; $00E1A8 ORI.B  #$0401,-$7D(PC,D4.W)
        DC.W    $003A,$0401,$40BC   ; $00E1AE ORI.B  #$0401,$40BC(PC)
        DC.W    $003A,$0401,$40F5   ; $00E1B4 ORI.B  #$0401,$40F5(PC)
        DC.W    $003B,$3ABC,$8F02   ; $00E1BA ORI.B  #$3ABC,$02(PC,A0.L)
        move.l  #$40000003,(a5)         ; $2ABC $4000 $0003
        clr.w    d0                     ; $4240
        moveq   #$1B,d3                 ; $761B
        move.w  d0,d1                   ; $3200
        lsl.w   #3,d1                   ; $E749
        lea     $0088E20C,a0            ; $41F9 $0088 $E20C
        lea     (a0,d1.w),a0            ; $41F0 $1000
        move.w  #$0005,d4               ; $383C $0005
loc_00E1DC:
        move.w  #$0007,d5               ; $3A3C $0007
loc_00E1E0:
        moveq   #$00,d6                 ; $7C00
        move.b  (a0,d5.w),d6            ; $1C30 $5000
        addi.w  #$02F0,d6               ; $0646 $02F0
        move.w  d6,(a6)                 ; $3C86
        DC.W    $51CD,$FFF2         ; $00E1EC DBRA    D5,loc_00E1E0
        DC.W    $51CC,$FFEA         ; $00E1F0 DBRA    D4,loc_00E1DC
        move.w  #$004F,d4               ; $383C $004F
loc_00E1F8:
        move.w  #$0000,(a6)             ; $3CBC $0000
        DC.W    $51CC,$FFFA         ; $00E1FC DBRA    D4,loc_00E1F8
