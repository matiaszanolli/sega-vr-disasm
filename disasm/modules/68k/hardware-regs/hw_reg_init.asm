; Generated assembly for $008B9C-$00A200
; Branch targets: 208
; Labels: 205
; Format: DC.W with decoded mnemonics as comments

        org     $008B9C

        move.w  #$0000,($FFFFC0BA).w    ; $31FC $0000 $C0BA
        move.w  #$0080,($FFFFC0B0).w    ; $31FC $0080 $C0B0
        move.w  ($FFFFC8DC).w,d0        ; $3038 $C8DC
        move.w  d0,($FFFFC054).w        ; $31C0 $C054
        move.w  d0,($FFFFC892).w        ; $31C0 $C892
        move.w  ($FFFFC8DE).w,d0        ; $3038 $C8DE
        move.w  d0,($FFFFC056).w        ; $31C0 $C056
        move.w  d0,($FFFFC894).w        ; $31C0 $C894
        rts                             ; $4E75
        move.w  #$0000,($FFFFC0BA).w    ; $31FC $0000 $C0BA
        lea     ($FFFFC0C0).w,a1        ; $43F8 $C0C0
        move.w  (a1)+,($FFFFC0AE).w     ; $31D9 $C0AE
        move.w  (a1)+,($FFFFC0B0).w     ; $31D9 $C0B0
        move.w  (a1),($FFFFC0B2).w      ; $31D1 $C0B2
        move.w  ($FFFFC8DC).w,d0        ; $3038 $C8DC
        move.w  d0,($FFFFC054).w        ; $31C0 $C054
        move.w  d0,($FFFFC892).w        ; $31C0 $C892
        move.w  #$0800,d0               ; $303C $0800
        move.w  d0,($FFFFC056).w        ; $31C0 $C056
        move.w  d0,($FFFFC894).w        ; $31C0 $C894
        rts                             ; $4E75
        move.w  #$0000,($FFFFC0BA).w    ; $31FC $0000 $C0BA
        lea     ($FFFFC0C0).w,a1        ; $43F8 $C0C0
        move.w  (a1)+,d0                ; $3019
        move.w  d0,($FFFFC054).w        ; $31C0 $C054
        move.w  d0,($FFFFC892).w        ; $31C0 $C892
        move.w  (a1)+,($FFFFC0B0).w     ; $31D9 $C0B0
        move.w  (a1),d0                 ; $3011
        move.w  d0,($FFFFC056).w        ; $31C0 $C056
        move.w  d0,($FFFFC894).w        ; $31C0 $C894
        rts                             ; $4E75
        move.w  #$0000,($FFFFC0BA).w    ; $31FC $0000 $C0BA
        lea     ($FFFFC0C0).w,a1        ; $43F8 $C0C0
        move.w  (a1)+,d0                ; $3019
        move.w  d0,($FFFFC054).w        ; $31C0 $C054
        move.w  d0,($FFFFC892).w        ; $31C0 $C892
        move.w  (a1)+,($FFFFC0AE).w     ; $31D9 $C0AE
        move.w  ($FFFFC0BC).w,($FFFFC0B0).w; $31F8 $C0BC $C0B0
        move.w  (a1),d0                 ; $3011
        move.w  d0,($FFFFC056).w        ; $31C0 $C056
        move.w  d0,($FFFFC894).w        ; $31C0 $C894
        rts                             ; $4E75
        moveq   #$00,d0                 ; $7000
        move.w  d0,($FFFFC0BA).w        ; $31C0 $C0BA
        move.b  ($FFFFC896).w,d0        ; $1038 $C896
        DC.W    $303B,$0006         ; $008C4A MOVE.W  $06(PC,D0.W),D0
        DC.W    $4EFB,$0002         ; $008C4E JMP     $02(PC,D0.W)
        ori.b  #$5E,d6                  ; $0006 $005E
        DC.W    $007A,$31FC,$00C0   ; $008C56 ORI.W  #$31FC,$00C0(PC)
        DC.W    $C0C8               ; $008C5C MULU    A0,D0
        move.w  #$0100,$00FF60CC        ; $33FC $0100 $00FF $60CC
        move.w  ($FFFFC8DA).w,($FFFFC0AE).w; $31F8 $C8DA $C0AE
        moveq   #$00,d0                 ; $7000
        move.w  d0,($FFFFC0C6).w        ; $31C0 $C0C6
        move.w  d0,($FFFFC0AE).w        ; $31C0 $C0AE
        move.w  d0,($FFFFC0B0).w        ; $31C0 $C0B0
        move.w  d0,($FFFFC0B2).w        ; $31C0 $C0B2
        move.w  d0,($FFFFC086).w        ; $31C0 $C086
        move.w  d0,($FFFFC88C).w        ; $31C0 $C88C
        move.w  d0,($FFFFC88E).w        ; $31C0 $C88E
        move.w  d0,($FFFFC890).w        ; $31C0 $C890
        move.w  d0,($FFFFC8F6).w        ; $31C0 $C8F6
        move.w  ($FFFFC8DC).w,d0        ; $3038 $C8DC
        move.w  d0,($FFFFC054).w        ; $31C0 $C054
        move.w  d0,($FFFFC892).w        ; $31C0 $C892
        move.w  ($FFFFC8DE).w,d0        ; $3038 $C8DE
        move.w  d0,($FFFFC056).w        ; $31C0 $C056
        move.w  d0,($FFFFC894).w        ; $31C0 $C894
        addq.b  #2,($FFFFC896).w        ; $5438 $C896
        rts                             ; $4E75
        addq.w  #8,($FFFFC892).w        ; $5078 $C892
        addq.w  #8,($FFFFC894).w        ; $5078 $C894
        move.w  ($FFFFC892).w,($FFFFC054).w; $31F8 $C892 $C054
        move.w  ($FFFFC894).w,($FFFFC056).w; $31F8 $C894 $C056
        move.w  ($FFFFC8F6).w,($FFFFC0C6).w; $31F8 $C8F6 $C0C6
        rts                             ; $4E75
        rts                             ; $4E75
        move.b  ($FFFFC896).w,d0        ; $1038 $C896
        DC.W    $303B,$000C         ; $008CD2 MOVE.W  $0C(PC,D0.W),D0
        DC.W    $4EBB,$0008         ; $008CD6 JSR     $08(PC,D0.W)
        jmp     $00888DC0               ; $4EF9 $0088 $8DC0
        DC.W    $0008,$0026         ; $008CE0 ORI.B  #$0026,A0
        ori.b  #$72,(-8,a2,d3.w)        ; $0032 $0072 $31F8
        DC.W    $C0BA,$C8F8         ; $008CEA AND.L  -$3708(PC),D0
        move.w  ($FFFFC0BC).w,($FFFFC892).w; $31F8 $C0BC $C892
        move.w  ($FFFFC0BE).w,($FFFFC894).w; $31F8 $C0BE $C894
        move.b  #$05,($FFFFC8F6).w      ; $11FC $0005 $C8F6
        addq.b  #2,($FFFFC896).w        ; $5438 $C896
        rts                             ; $4E75
        subq.b  #1,($FFFFC8F6).w        ; $5338 $C8F6
        DC.W    $6604               ; $008D0A BNE.S  loc_008D10
        addq.b  #2,($FFFFC896).w        ; $5438 $C896
loc_008D10:
        rts                             ; $4E75
        cmpi.w  #$EC0A,($FFFFC894).w    ; $0C78 $EC0A $C894
        DC.W    $6E1E               ; $008D18 BGT.S  loc_008D38
        addi.w  #$0050,($FFFFC894).w    ; $0678 $0050 $C894
        move.w  ($FFFFC894).w,($FFFFC0BE).w; $31F8 $C894 $C0BE
        cmpi.w  #$E8E8,($FFFFC894).w    ; $0C78 $E8E8 $C894
        DC.W    $6F08               ; $008D2C BLE.S  loc_008D36
        move.w  ($FFFFC894).w,$00FF3028 ; $33F8 $C894 $00FF $3028
loc_008D36:
        rts                             ; $4E75
loc_008D38:
        move.w  #$EC0A,($FFFFC894).w    ; $31FC $EC0A $C894
        move.w  ($FFFFC894).w,($FFFFC0BE).w; $31F8 $C894 $C0BE
        move.w  ($FFFFC894).w,$00FF3028 ; $33F8 $C894 $00FF $3028
        addq.b  #2,($FFFFC896).w        ; $5438 $C896
        rts                             ; $4E75
        move.w  ($FFFFC894).w,($FFFFC0BE).w; $31F8 $C894 $C0BE
        move.w  ($FFFFC894).w,$00FF3028 ; $33F8 $C894 $00FF $3028
        rts                             ; $4E75
        move.w  ($FFFFC0BA).w,d0        ; $3038 $C0BA
        move.w  ($FFFFC0BE).w,d1        ; $3238 $C0BE
        move.w  $0030(a0),d2            ; $3428 $0030
        move.w  $0034(a0),d3            ; $3628 $0034
        jsr     ai_steering_calc(pc)    ; $4EBA $1A2C
        subi.w  #$4000,d0               ; $0440 $4000
        neg.w    d0                     ; $4440
        move.w  d0,($FFFFC0C2).w        ; $31C0 $C0C2
        jsr     sine_cosine_quadrant_lookup(pc); $4EBA $01CC
        move.w  $0030(a0),d2            ; $3428 $0030
        sub.w   ($FFFFC0BA).w,d2        ; $9478 $C0BA
        cmpi.w  #$C000,($FFFFC0C2).w    ; $0C78 $C000 $C0C2
        DC.W    $6602               ; $008D92 BNE.S  loc_008D96
        neg.w    d2                     ; $4442
loc_008D96:
        tst.w    d0                     ; $4A40
        DC.W    $670E               ; $008D98 BEQ.S  loc_008DA8
        move.w  $0034(a0),d2            ; $3428 $0034
        sub.w   ($FFFFC0BE).w,d2        ; $9478 $C0BE
        ext.l   d2                      ; $48C2
        asl.l   #8,d2                   ; $E182
        divs.w  d0,d2                   ; $85C0
loc_008DA8:
        move.w  $0032(a0),d3            ; $3628 $0032
        sub.w   ($FFFFC0BC).w,d3        ; $9678 $C0BC
        asr.w   #4,d3                   ; $E843
        move.w  d2,d2                   ; $3402
        jsr     ai_steering_calc+4(pc)  ; $4EBA $19EE
        neg.w    d0                     ; $4440
        move.w  d0,($FFFFC0C0).w        ; $31C0 $C0C0
        rts                             ; $4E75
        move.w  ($FFFFC0BA).w,d0        ; $3038 $C0BA
        move.w  ($FFFFC0BE).w,d1        ; $3238 $C0BE
        move.w  $0030(a0),d2            ; $3428 $0030
        move.w  $0034(a0),d3            ; $3628 $0034
        jsr     ai_steering_calc(pc)    ; $4EBA $19CE
        subi.w  #$4000,d0               ; $0440 $4000
        neg.w    d0                     ; $4440
        tst.w    ($FFFFC102).w          ; $4A78 $C102
        DC.W    $672E               ; $008DDE BEQ.S  loc_008E0E
        moveq   #$00,d3                 ; $7600
        tst.w    d0                     ; $4A40
        DC.W    $6B18               ; $008DE4 BMI.S  loc_008DFE
        move.w  ($FFFFC102).w,d3        ; $3638 $C102
        DC.W    $6A18               ; $008DEA BPL.S  loc_008E04
loc_008DEC:
        cmpi.w  #$C000,d0               ; $0C40 $C000
        DC.W    $6406               ; $008DF0 BCC.S  loc_008DF8
        cmpi.w  #$4000,d0               ; $0C40 $4000
        DC.W    $640C               ; $008DF6 BCC.S  loc_008E04
loc_008DF8:
        add.w   d3,d0                   ; $D043
        asr.w   #1,d0                   ; $E240
        DC.W    $6010               ; $008DFC BRA.S  loc_008E0E
loc_008DFE:
        move.w  ($FFFFC102).w,d3        ; $3638 $C102
        DC.W    $6AE8               ; $008E02 BPL.S  loc_008DEC
loc_008E04:
        andi.l  #$0000FFFF,d0           ; $0280 $0000 $FFFF
        add.l   d3,d0                   ; $D083
        asr.l   #1,d0                   ; $E280
loc_008E0E:
        move.w  d0,($FFFFC0C2).w        ; $31C0 $C0C2
        move.w  d0,($FFFFC102).w        ; $31C0 $C102
        cmpi.w  #$1000,d0               ; $0C40 $1000
        DC.W    $6512               ; $008E1A BCS.S  loc_008E2E
        cmpi.w  #$F000,d0               ; $0C40 $F000
        DC.W    $640C               ; $008E20 BCC.S  loc_008E2E
        cmpi.w  #$9000,d0               ; $0C40 $9000
        DC.W    $6420               ; $008E26 BCC.S  loc_008E48
        cmpi.w  #$7000,d0               ; $0C40 $7000
        DC.W    $651A               ; $008E2C BCS.S  loc_008E48
loc_008E2E:
        jsr     sine_cosine_quadrant_lookup(pc); $4EBA $011E
        move.w  $0030(a0),d2            ; $3428 $0030
        sub.w   ($FFFFC0BA).w,d2        ; $9478 $C0BA
        tst.w    d0                     ; $4A40
        DC.W    $6728               ; $008E3C BEQ.S  loc_008E66
        move.w  $0034(a0),d2            ; $3428 $0034
        sub.w   ($FFFFC0BE).w,d2        ; $9478 $C0BE
        DC.W    $6018               ; $008E46 BRA.S  loc_008E60
loc_008E48:
        jsr     sine_cosine_quadrant_lookup+4(pc); $4EBA $0108
        move.w  $0034(a0),d2            ; $3428 $0034
        sub.w   ($FFFFC0BE).w,d2        ; $9478 $C0BE
        tst.w    d0                     ; $4A40
        DC.W    $670E               ; $008E56 BEQ.S  loc_008E66
        move.w  $0030(a0),d2            ; $3428 $0030
        sub.w   ($FFFFC0BA).w,d2        ; $9478 $C0BA
loc_008E60:
        ext.l   d2                      ; $48C2
        asl.l   #8,d2                   ; $E182
        divs.w  d0,d2                   ; $85C0
loc_008E66:
        move.w  $0032(a0),d3            ; $3628 $0032
        sub.w   ($FFFFC0BC).w,d3        ; $9678 $C0BC
        asr.w   #4,d3                   ; $E843
        move.w  d2,d2                   ; $3402
        jsr     ai_steering_calc+4(pc)  ; $4EBA $1930
        neg.w    d0                     ; $4440
        tst.w    ($FFFFC100).w          ; $4A78 $C100
        DC.W    $672E               ; $008E7C BEQ.S  loc_008EAC
        moveq   #$00,d3                 ; $7600
        tst.w    d0                     ; $4A40
        DC.W    $6B18               ; $008E82 BMI.S  loc_008E9C
        move.w  ($FFFFC100).w,d3        ; $3638 $C100
        DC.W    $6A18               ; $008E88 BPL.S  loc_008EA2
loc_008E8A:
        cmpi.w  #$C000,d0               ; $0C40 $C000
        DC.W    $6406               ; $008E8E BCC.S  loc_008E96
        cmpi.w  #$4000,d0               ; $0C40 $4000
        DC.W    $640C               ; $008E94 BCC.S  loc_008EA2
loc_008E96:
        add.w   d3,d0                   ; $D043
        asr.w   #1,d0                   ; $E240
        DC.W    $6010               ; $008E9A BRA.S  loc_008EAC
loc_008E9C:
        move.w  ($FFFFC100).w,d3        ; $3638 $C100
        DC.W    $6AE8               ; $008EA0 BPL.S  loc_008E8A
loc_008EA2:
        andi.l  #$0000FFFF,d0           ; $0280 $0000 $FFFF
        add.l   d3,d0                   ; $D083
        asr.l   #1,d0                   ; $E280
loc_008EAC:
        move.w  d0,($FFFFC0C0).w        ; $31C0 $C0C0
        move.w  d0,($FFFFC100).w        ; $31C0 $C100
        rts                             ; $4E75
        move.w  ($FFFFC0BA).w,d0        ; $3038 $C0BA
        move.w  ($FFFFC0BE).w,d1        ; $3238 $C0BE
        move.w  $0030(a0),d2            ; $3428 $0030
        move.w  $0034(a0),d3            ; $3628 $0034
        jsr     ai_steering_calc(pc)    ; $4EBA $18D8
        subi.w  #$4000,d0               ; $0440 $4000
        neg.w    d0                     ; $4440
        move.w  d0,($FFFFC0C2).w        ; $31C0 $C0C2
        rts                             ; $4E75
        move.w  $0032(a0),d3            ; $3628 $0032
        sub.w   ($FFFFC0BC).w,d3        ; $9678 $C0BC
        asr.w   #4,d3                   ; $E843
        move.w  $0034(a0),d2            ; $3428 $0034
        sub.w   ($FFFFC0BE).w,d2        ; $9478 $C0BE
        jsr     ai_steering_calc+4(pc)  ; $4EBA $18BA
        neg.w    d0                     ; $4440
        move.w  d0,($FFFFC0C0).w        ; $31C0 $C0C0
        rts                             ; $4E75
        move.w  #$0000,($FFFFC0BA).w    ; $31FC $0000 $C0BA
        rts                             ; $4E75
        move.w  ($FFFFC0BA).w,d0        ; $3038 $C0BA
        move.w  ($FFFFC0BE).w,d1        ; $3238 $C0BE
        move.w  $0030(a0),d2            ; $3428 $0030
        move.w  $0034(a0),d3            ; $3628 $0034
        jsr     ai_steering_calc(pc)    ; $4EBA $1892
        subi.w  #$4000,d0               ; $0440 $4000
        neg.w    d0                     ; $4440
        move.w  d0,d3                   ; $3600
        jsr     sine_cosine_quadrant_lookup(pc); $4EBA $0034
        move.w  $0030(a0),d2            ; $3428 $0030
        sub.w   ($FFFFC0BA).w,d2        ; $9478 $C0BA
        cmpi.w  #$C000,d3               ; $0C43 $C000
        DC.W    $6602               ; $008F28 BNE.S  loc_008F2C
        neg.w    d2                     ; $4442
loc_008F2C:
        tst.w    d0                     ; $4A40
        DC.W    $671C               ; $008F2E BEQ.S  loc_008F4C
        move.w  $0034(a0),d2            ; $3428 $0034
        sub.w   ($FFFFC0BE).w,d2        ; $9478 $C0BE
        ext.l   d2                      ; $48C2
        asl.l   #8,d2                   ; $E182
        divs.w  d0,d2                   ; $85C0
        DC.W    $6B0C               ; $008F3E BMI.S  loc_008F4C
        move.w  $00FF5000,d3            ; $3639 $00FF $5000
        mulu.w  d3,d2                   ; $C4C3
        move.w  d2,($FFFFC0C6).w        ; $31C2 $C0C6
loc_008F4C:
        rts                             ; $4E75
loc_008F4E:
        addi.w  #$4000,d0               ; $0640 $4000
loc_008F52:
        moveq   #$00,d1                 ; $7200
        move.w  d0,d1                   ; $3200
        lsr.w   #6,d0                   ; $EC48
        lsl.l   #2,d1                   ; $E589
        DC.W    $4841               ; $008F5A SWAP    D1
        add.w   d1,d1                   ; $D241
        add.w   d1,d1                   ; $D241
        DC.W    $227B,$1004         ; $008F60 MOVEA.L $04(PC,D1.W),A1
        jmp     (a1)                    ; $4ED1
        DC.W    $0088,$8F7A,$0088   ; $008F66 ORI.L  #$8F7A0088,A0
        DC.W    $8F88               ; $008F6C OR.L   D7,A0
        DC.W    $0088,$8F9C,$0088   ; $008F6E ORI.L  #$8F9C0088,A0
        or.l    d7,(-120,a0,d0.w)       ; $8FB0 $0088
        divs.w  d6,d7                   ; $8FC6
        lea     $00930000,a1            ; $43F9 $0093 $0000
        add.w   d0,d0                   ; $D040
        move.w  (a1,d0.w),d0            ; $3031 $0000
        rts                             ; $4E75
        lea     $00930000,a1            ; $43F9 $0093 $0000
        subi.w  #$0200,d0               ; $0440 $0200
        neg.w    d0                     ; $4440
        add.w   d0,d0                   ; $D040
        move.w  (a1,d0.w),d0            ; $3031 $0000
        rts                             ; $4E75
        lea     $00930000,a1            ; $43F9 $0093 $0000
        subi.w  #$0200,d0               ; $0440 $0200
        add.w   d0,d0                   ; $D040
        move.w  (a1,d0.w),d0            ; $3031 $0000
        neg.w    d0                     ; $4440
        rts                             ; $4E75
        lea     $00930000,a1            ; $43F9 $0093 $0000
        subi.w  #$0400,d0               ; $0440 $0400
        neg.w    d0                     ; $4440
        add.w   d0,d0                   ; $D040
        move.w  (a1,d0.w),d0            ; $3031 $0000
        neg.w    d0                     ; $4440
        rts                             ; $4E75
        rts                             ; $4E75
        move.l  d0,d1                   ; $2200
        DC.W    $6A02               ; $008FCA BPL.S  loc_008FCE
        neg.l    d1                     ; $4481
loc_008FCE:
        cmpi.l  #$00000400,d1           ; $0C81 $0000 $0400
        DC.W    $6C14               ; $008FD4 BGE.S  loc_008FEA
        andi.b  #$FC,d1                 ; $0201 $00FC
        asr.l   #1,d1                   ; $E281
        lea     $00930202,a1            ; $43F9 $0093 $0202
        move.w  (a1,d1.l),d1            ; $3231 $1800
        ext.l   d1                      ; $48C1
        DC.W    $604A               ; $008FE8 BRA.S  loc_009034
loc_008FEA:
        cmpi.l  #$00000D8F,d1           ; $0C81 $0000 $0D8F
        DC.W    $6C1A               ; $008FF0 BGE.S  loc_00900C
        subi.l  #$00000400,d1           ; $0481 $0000 $0400
        andi.b  #$F0,d1                 ; $0201 $00F0
        asr.l   #3,d1                   ; $E681
        lea     $00930402,a1            ; $43F9 $0093 $0402
        move.w  (a1,d1.l),d1            ; $3231 $1800
        ext.l   d1                      ; $48C1
        DC.W    $6028               ; $00900A BRA.S  loc_009034
loc_00900C:
        cmpi.l  #$0000517C,d1           ; $0C81 $0000 $517C
        DC.W    $6C0C               ; $009012 BGE.S  loc_009020
        moveq   #$0B,d2                 ; $740B
        asr.l   d2,d1                   ; $E4A1
        addi.l  #$000000F4,d1           ; $0681 $0000 $00F4
        DC.W    $6014               ; $00901E BRA.S  loc_009034
loc_009020:
        move.l  #$000000FE,d1           ; $223C $0000 $00FE
        cmpi.l  #$0000A2F8,d1           ; $0C81 $0000 $A2F8
        DC.W    $6D06               ; $00902C BLT.S  loc_009034
        move.l  #$00000100,d1           ; $223C $0000 $0100
loc_009034:
        tst.l    d0                     ; $4A80
        DC.W    $6A02               ; $009036 BPL.S  loc_00903A
        neg.l    d1                     ; $4481
loc_00903A:
        asl.l   #6,d1                   ; $ED81
        move.w  d1,d0                   ; $3001
        rts                             ; $4E75
        move.w  ($FFFF903C).w,d0        ; $3038 $903C
        add.w   ($FFFF9096).w,d0        ; $D078 $9096
        tst.w    ($FFFFC04C).w          ; $4A78 $C04C
        DC.W    $6704               ; $00904C BEQ.S  loc_009052
        sub.w   ($FFFF9046).w,d0        ; $9078 $9046
loc_009052:
        asr.w   #6,d0                   ; $EC40
        btst    #7,($FFFFFDA8).w        ; $0838 $0007 $FDA8
        DC.W    $6702               ; $00905A BEQ.S  loc_00905E
        neg.w    d0                     ; $4440
loc_00905E:
        move.w  d0,($FFFF8002).w        ; $31C0 $8002
        rts                             ; $4E75
        btst    #3,($FFFFC313).w        ; $0838 $0003 $C313
        DC.W    $6630               ; $00906A BNE.S  loc_00909C
        move.w  $00CC(a0),d0            ; $3028 $00CC
        asr.w   #6,d0                   ; $EC40
        move.w  d0,($FFFF8002).w        ; $31C0 $8002
        move.w  $00FF6108,d0            ; $3039 $00FF $6108
        asr.w   #8,d0                   ; $E040
        cmpi.w  #$FFF8,d0               ; $0C40 $FFF8
        DC.W    $6C02               ; $009082 BGE.S  loc_009086
        moveq   #$F8,d0                 ; $70F8
loc_009086:
        cmpi.w  #$0010,d0               ; $0C40 $0010
        DC.W    $6F02               ; $00908A BLE.S  loc_00908E
        moveq   #$10,d0                 ; $7010
loc_00908E:
        subq.w  #8,d0                   ; $5140
        move.w  d0,($FFFFC882).w        ; $31C0 $C882
        move.w  #$FEC0,($FFFF8000).w    ; $31FC $FEC0 $8000
        rts                             ; $4E75
loc_00909C:
        move.w  #$0000,($FFFF8000).w    ; $31FC $0000 $8000
        rts                             ; $4E75
        move.w  ($FFFFC0B0).w,d0        ; $3038 $C0B0
        asl.w   #3,d0                   ; $E740
        add.w   ($FFFF903C).w,d0        ; $D078 $903C
        add.w   ($FFFF9096).w,d0        ; $D078 $9096
        tst.w    ($FFFFC04C).w          ; $4A78 $C04C
        DC.W    $6704               ; $0090B6 BEQ.S  loc_0090BC
        sub.w   ($FFFF9046).w,d0        ; $9078 $9046
loc_0090BC:
        asr.w   #6,d0                   ; $EC40
        btst    #7,($FFFFFDA8).w        ; $0838 $0007 $FDA8
        DC.W    $6702               ; $0090C4 BEQ.S  loc_0090C8
        neg.w    d0                     ; $4440
loc_0090C8:
        move.w  d0,($FFFF8002).w        ; $31C0 $8002
        rts                             ; $4E75
        moveq   #$00,d0                 ; $7000
        move.w  $003C(a0),d0            ; $3028 $003C
        add.w   $0096(a0),d0            ; $D068 $0096
        tst.w    ($FFFFC04C).w          ; $4A78 $C04C
        DC.W    $6704               ; $0090DC BEQ.S  loc_0090E2
        sub.w   $0046(a0),d0            ; $9068 $0046
loc_0090E2:
        asr.w   #6,d0                   ; $EC40
        move.l  d0,d1                   ; $2200
        move.l  d0,d2                   ; $2400
        move.l  d0,d3                   ; $2600
        move.l  d0,d4                   ; $2800
        move.l  d0,d5                   ; $2A00
        move.l  d0,d6                   ; $2C00
        move.l  d0,d7                   ; $2E00
        movem.l d0-d7,(a1)              ; $48D1 $00FF
        movem.l d0-d7,-(a1)             ; $48E1 $FF00
        movem.l d0-d7,-(a1)             ; $48E1 $FF00
        movem.l d0-d7,-(a1)             ; $48E1 $FF00
        movem.l d0-d7,-(a1)             ; $48E1 $FF00
        movem.l d0-d7,-(a1)             ; $48E1 $FF00
        movem.l d0-d7,-(a1)             ; $48E1 $FF00
        movem.l d0-d7,-(a1)             ; $48E1 $FF00
        movem.l d0-d7,-(a1)             ; $48E1 $FF00
        movem.l d0-d7,-(a1)             ; $48E1 $FF00
        movem.l d0-d7,-(a1)             ; $48E1 $FF00
        movem.l d0-d7,-(a1)             ; $48E1 $FF00
        rts                             ; $4E75
        movea.w ($FFFFC8C0).w,a1        ; $3278 $C8C0
        cmpi.l  #$00000000,($FFFFEEDC).w; $0CB8 $0000 $0000 $EEDC
        DC.W    $6718               ; $009130 BEQ.S  loc_00914A
        movea.l a1,a2                   ; $2449
        move.w  #$0253,d7               ; $3E3C $0253
        move.l  #$7FFF0000,d0           ; $203C $7FFF $0000
loc_00913E:
        move.l  d0,(a2)+                ; $24C0
        move.l  d0,(a2)+                ; $24C0
        move.l  d0,(a2)+                ; $24C0
        move.l  d0,(a2)+                ; $24C0
        DC.W    $51CF,$FFF6         ; $009146 DBRA    D7,loc_00913E
loc_00914A:
        move.w  $001C(a0),d0            ; $3028 $001C
        lsl.w   #3,d0                   ; $E748
        lea     (a1,d0.w),a1            ; $43F1 $0000
        move.w  $0004(a1),d0            ; $3029 $0004
        add.w   $0006(a1),d0            ; $D069 $0006
        DC.W    $6A02               ; $00915C BPL.S  loc_009160
        neg.w    d0                     ; $4440
loc_009160:
        move.w  $0072(a0),d1            ; $3228 $0072
        add.w   $00E2(a0),d1            ; $D268 $00E2
        DC.W    $6A02               ; $009168 BPL.S  loc_00916C
        neg.w    d1                     ; $4441
loc_00916C:
        cmp.w   d0,d1                   ; $B240
        DC.W    $6C10               ; $00916E BGE.S  loc_009180
        move.w  $0030(a0),(a1)+         ; $32E8 $0030
        move.w  $0034(a0),(a1)+         ; $32E8 $0034
        move.w  $0072(a0),(a1)+         ; $32E8 $0072
        move.w  $0072(a0),(a1)          ; $32A8 $0072
loc_009180:
        rts                             ; $4E75
        move.w  $008C(a0),d1            ; $3228 $008C
        add.w   $006A(a0),d1            ; $D268 $006A
        DC.W    $6600,$0174         ; $00918A BNE.W  loc_009300
        tst.b    ($FFFFC30F).w          ; $4A38 $C30F
        DC.W    $6700,$00C0         ; $009192 BEQ.W  loc_009254
        move.w  $00AE(a0),d0            ; $3028 $00AE
        add.w   d0,d0                   ; $D040
        lea     ($FFFFC05C).w,a1        ; $43F8 $C05C
        cmpi.w  #$0001,(a1,d0.w)        ; $0C71 $0001 $0000
        DC.W    $6700,$00AC         ; $0091A6 BEQ.W  loc_009254
        btst    #1,($FFFFC973).w        ; $0838 $0001 $C973
        DC.W    $674C               ; $0091B0 BEQ.S  loc_0091FE
        move.w  $007A(a0),d2            ; $3428 $007A
        cmpi.w  #$0006,d2               ; $0C42 $0006
        DC.W    $6C00,$0122         ; $0091BA BGE.W  loc_0092DE
        move.w  $0074(a0),d1            ; $3228 $0074
        lea     $0088A1F0,a1            ; $43F9 $0088 $A1F0
        add.w   d2,d2                   ; $D442
        muls.w  (a1,d2.w),d1            ; $C3F1 $2000
        lsr.l   #8,d1                   ; $E089
        move.w  d1,$0074(a0)            ; $3141 $0074
        addq.w  #1,$007A(a0)            ; $5268 $007A
        cmpi.w  #$1F40,$0074(a0)        ; $0C68 $1F40 $0074
        DC.W    $6D1A               ; $0091DE BLT.S  loc_0091FA
        cmpi.w  #$0004,$007A(a0)        ; $0C68 $0004 $007A
        DC.W    $6C12               ; $0091E6 BGE.S  loc_0091FA
        tst.w    $0082(a0)              ; $4A68 $0082
        DC.W    $660C               ; $0091EC BNE.S  loc_0091FA
        move.w  #$000F,$0082(a0)        ; $317C $000F $0082
        move.b  #$B4,($FFFFC8A4).w      ; $11FC $00B4 $C8A4
loc_0091FA:
        DC.W    $6000,$00E2         ; $0091FA BRA.W  loc_0092DE
loc_0091FE:
        btst    #0,($FFFFC973).w        ; $0838 $0000 $C973
        DC.W    $6700,$00D8         ; $009204 BEQ.W  loc_0092DE
        tst.w    $007A(a0)              ; $4A68 $007A
        DC.W    $6F00,$00D0         ; $00920C BLE.W  loc_0092DE
        subq.w  #1,$007A(a0)            ; $5368 $007A
        move.w  $0074(a0),d1            ; $3228 $0074
        ext.l   d1                      ; $48C1
        lsl.l   #8,d1                   ; $E189
        lea     $0088A1F0,a1            ; $43F9 $0088 $A1F0
        move.w  $007A(a0),d2            ; $3428 $007A
        add.w   d2,d2                   ; $D442
        divu.w  (a1,d2.w),d1            ; $82F1 $2000
        move.w  d1,$0074(a0)            ; $3141 $0074
        cmpi.w  #$4268,d1               ; $0C41 $4268
        DC.W    $6F00,$00A8         ; $009234 BLE.W  loc_0092DE
        move.w  #$4268,$0074(a0)        ; $317C $4268 $0074
        tst.w    $0084(a0)              ; $4A68 $0084
        DC.W    $6606               ; $009242 BNE.S  loc_00924A
        move.w  #$000A,$0084(a0)        ; $317C $000A $0084
loc_00924A:
        move.w  #$00FF,$0010(a0)        ; $317C $00FF $0010
        DC.W    $6000,$008C         ; $009250 BRA.W  loc_0092DE
loc_009254:
        move.w  $0074(a0),d2            ; $3428 $0074
        move.w  $007A(a0),d1            ; $3228 $007A
        add.w   d1,d1                   ; $D241
        tst.w    $0004(a0)              ; $4A68 $0004
        DC.W    $6700,$004A         ; $009262 BEQ.W  loc_0092AE
        lea     $0088A1E2,a1            ; $43F9 $0088 $A1E2
        cmp.w   (a1,d1.w),d2            ; $B471 $1000
        DC.W    $6F00,$003C         ; $009270 BLE.W  loc_0092AE
        lea     $0088A1F0,a1            ; $43F9 $0088 $A1F0
        muls.w  (a1,d1.w),d2            ; $C5F1 $1000
        lsr.l   #8,d2                   ; $E08A
        move.w  d2,$0074(a0)            ; $3142 $0074
        addq.w  #1,$007A(a0)            ; $5268 $007A
        cmpi.w  #$1F40,$0074(a0)        ; $0C68 $1F40 $0074
        DC.W    $6D1A               ; $00928E BLT.S  loc_0092AA
        cmpi.w  #$0004,$007A(a0)        ; $0C68 $0004 $007A
        DC.W    $6C12               ; $009296 BGE.S  loc_0092AA
        tst.w    $0082(a0)              ; $4A68 $0082
        DC.W    $660C               ; $00929C BNE.S  loc_0092AA
        move.w  #$000F,$0082(a0)        ; $317C $000F $0082
        move.b  #$B4,($FFFFC8A4).w      ; $11FC $00B4 $C8A4
loc_0092AA:
        DC.W    $6000,$0032         ; $0092AA BRA.W  loc_0092DE
loc_0092AE:
        lea     $00939EDE,a1            ; $43F9 $0093 $9EDE
        cmp.w   (a1,d1.w),d2            ; $B471 $1000
        DC.W    $6C00,$0024         ; $0092B8 BGE.W  loc_0092DE
        subq.w  #1,$007A(a0)            ; $5368 $007A
        ext.l   d2                      ; $48C2
        lsl.l   #8,d2                   ; $E18A
        lea     $0088A1F0,a1            ; $43F9 $0088 $A1F0
        divs.w  (-2,a1,d1.w),d2         ; $85F1 $10FE
        move.w  d2,$0074(a0)            ; $3142 $0074
        tst.w    $0084(a0)              ; $4A68 $0084
        DC.W    $6606               ; $0092D6 BNE.S  loc_0092DE
        move.w  #$000A,$0084(a0)        ; $317C $000A $0084
loc_0092DE:
        move.w  $0074(a0),d1            ; $3228 $0074
        sub.w   $007E(a0),d1            ; $9268 $007E
        cmpi.w  #$0400,d1               ; $0C41 $0400
        DC.W    $6F04               ; $0092EA BLE.S  loc_0092F0
        move.w  #$0400,d1               ; $323C $0400
loc_0092F0:
        cmpi.w  #$FC00,d1               ; $0C41 $FC00
        DC.W    $6C04               ; $0092F4 BGE.S  loc_0092FA
        move.w  #$FC00,d1               ; $323C $FC00
loc_0092FA:
        add.w   d1,$007E(a0)            ; $D368 $007E
        rts                             ; $4E75
loc_009300:
        move.w  #$FFCD,$000E(a0)        ; $317C $FFCD $000E
        move.w  $0074(a0),d2            ; $3428 $0074
        move.w  $007A(a0),d1            ; $3228 $007A
        add.w   d1,d1                   ; $D241
        DC.W    $609C               ; $009310 BRA.S  loc_0092AE
        move.w  $0074(a0),d1            ; $3228 $0074
        DC.W    $6C04               ; $009316 BGE.S  loc_00931C
        moveq   #$00,d1                 ; $7200
        DC.W    $600A               ; $00931A BRA.S  loc_009326
loc_00931C:
        cmpi.w  #$4268,d1               ; $0C41 $4268
        DC.W    $6F04               ; $009320 BLE.S  loc_009326
        move.w  #$4268,d1               ; $323C $4268
loc_009326:
        asr.w   #7,d1                   ; $EE41
        lea     $0093910E,a1            ; $43F9 $0093 $910E
        tst.b    ($FFFFC30F).w          ; $4A38 $C30F
        DC.W    $6606               ; $009332 BNE.S  loc_00933A
        lea     $00938FCE,a1            ; $43F9 $0093 $8FCE
loc_00933A:
        add.w   d1,d1                   ; $D241
        move.w  (a1,d1.w),d2            ; $3431 $1000
        movea.l ($FFFFC278).w,a2        ; $2478 $C278
        move.w  $007A(a0),d3            ; $3628 $007A
        add.w   d3,d3                   ; $D643
        mulu.w  (a2,d3.w),d2            ; $C4F2 $3000
        lsr.l   #5,d2                   ; $EA8A
        muls.w  $000E(a0),d2            ; $C5E8 $000E
        asr.l   #7,d2                   ; $EE82
        DC.W    $6E0C               ; $009356 BGT.S  loc_009364
        move.l  #$FFFFFE00,d0           ; $203C $FFFF $FE00
        cmp.l   d0,d2                   ; $B480
        DC.W    $6D02               ; $009360 BLT.S  loc_009364
        move.l  d0,d2                   ; $2400
loc_009364:
        jsr     speed_calc_multiplier_chain(pc); $4EBA $00F2
        move.w  $0016(a0),d1            ; $3228 $0016
        ext.l   d1                      ; $48C1
        lsl.l   #4,d1                   ; $E989
        sub.l   d1,d2                   ; $9481
        move.w  $0010(a0),d1            ; $3228 $0010
        DC.W    $C3FC,$71C0         ; $009376 MULS    #$71C0,D1
        asr.l   #7,d1                   ; $EE81
        sub.l   d1,d2                   ; $9481
        DC.W    $6A02               ; $00937E BPL.S  loc_009382
        add.l   d2,d2                   ; $D482
loc_009382:
        move.w  #$0100,$0078(a0)        ; $317C $0100 $0078
        move.w  ($FFFFC0EC).w,d0        ; $3038 $C0EC
        neg.w    d0                     ; $4440
        ext.l   d0                      ; $48C0
        cmp.l   d0,d2                   ; $B480
        DC.W    $6E2C               ; $009392 BGT.S  loc_0093C0
        move.l  d0,d1                   ; $2200
        add.l   d1,d1                   ; $D281
        cmp.l   d1,d2                   ; $B481
        DC.W    $6E20               ; $00939A BGT.S  loc_0093BC
        move.w  $0080(a0),d1            ; $3228 $0080
        or.w    $008C(a0),d1            ; $8268 $008C
        DC.W    $6616               ; $0093A4 BNE.S  loc_0093BC
        cmpi.w  #$0014,$0004(a0)        ; $0C68 $0014 $0004
        DC.W    $6F00,$000E         ; $0093AC BLE.W  loc_0093BC
        move.w  #$000F,$0080(a0)        ; $317C $000F $0080
        move.b  #$B1,($FFFFC8A4).w      ; $11FC $00B1 $C8A4
loc_0093BC:
        move.l  d0,d2                   ; $2400
        DC.W    $603C               ; $0093BE BRA.S  loc_0093FC
loc_0093C0:
        moveq   #$00,d0                 ; $7000
        move.w  ($FFFFC0EA).w,d0        ; $3038 $C0EA
        cmp.l   d0,d2                   ; $B480
        DC.W    $6F00,$0032         ; $0093C8 BLE.W  loc_0093FC
        move.l  d2,d1                   ; $2202
        sub.l   d0,d1                   ; $9280
        asl.l   #8,d1                   ; $E181
        divs.w  d0,d1                   ; $83C0
        sub.w   d1,$0078(a0)            ; $9368 $0078
        cmpi.w  #$0080,d1               ; $0C41 $0080
        DC.W    $6F06               ; $0093DC BLE.S  loc_0093E4
        move.w  #$0080,$0078(a0)        ; $317C $0080 $0078
loc_0093E4:
        tst.w    $007A(a0)              ; $4A68 $007A
        DC.W    $6612               ; $0093E8 BNE.S  loc_0093FC
        tst.w    $0082(a0)              ; $4A68 $0082
        DC.W    $660C               ; $0093EE BNE.S  loc_0093FC
        move.w  #$000F,$0082(a0)        ; $317C $000F $0082
        move.b  #$B4,($FFFFC8A4).w      ; $11FC $00B4 $C8A4
loc_0093FC:
        asr.l   #1,d2                   ; $E282
        muls.w  $0078(a0),d2            ; $C5E8 $0078
        asr.l   #7,d2                   ; $EE82
        move.w  d2,d1                   ; $3202
        asr.w   #2,d1                   ; $E441
        ext.l   d1                      ; $48C1
        DC.W    $83FC,$0190         ; $00940A DIVS    #$0190,D1
        move.w  d1,$000C(a0)            ; $3141 $000C
        add.w   d1,$0006(a0)            ; $D368 $0006
        DC.W    $6A04               ; $009416 BPL.S  loc_00941C
        clr.w    $0006(a0)              ; $4268 $0006
loc_00941C:
        movea.l ($FFFFC278).w,a1        ; $2278 $C278
        move.w  $007A(a0),d1            ; $3228 $007A
        add.w   d1,d1                   ; $D241
        move.w  (a1,d1.w),d3            ; $3631 $1000
        muls.w  $0006(a0),d3            ; $C7E8 $0006
        asl.l   #2,d3                   ; $E583
        move.l  d3,d1                   ; $2203
        asl.l   #2,d3                   ; $E583
        add.l   d3,d1                   ; $D283
        asl.l   #2,d3                   ; $E583
        add.l   d3,d1                   ; $D283
        asl.l   #3,d3                   ; $E783
        add.l   d1,d3                   ; $D681
        moveq   #$0C,d1                 ; $720C
        lsr.l   d1,d3                   ; $E2AB
        DC.W    $6C02               ; $009442 BGE.S  loc_009446
        moveq   #$00,d3                 ; $7600
loc_009446:
        cmpi.l  #$00004268,d3           ; $0C83 $0000 $4268
        DC.W    $6F04               ; $00944C BLE.S  loc_009452
        move.w  #$4268,d3               ; $363C $4268
loc_009452:
        move.w  d3,$0074(a0)            ; $3143 $0074
        rts                             ; $4E75
loc_009458:
        movem.l d0/a1,-(a7)             ; $48E7 $8040
        movea.l ($FFFFC27C).w,a1        ; $2278 $C27C
        move.w  $0004(a0),d0            ; $3028 $0004
        add.w   d0,d0                   ; $D040
        move.w  (a1,d0.w),d0            ; $3031 $0000
        muls.w  ($FFFFC0E6).w,d0        ; $C1F8 $C0E6
        asr.l   #8,d0                   ; $E080
        move.w  d0,$0016(a0)            ; $3140 $0016
        tst.b    ($FFFFC826).w          ; $4A38 $C826
        DC.W    $6710               ; $009478 BEQ.S  loc_00948A
        moveq   #$10,d0                 ; $7010
        add.w   $008A(a0),d0            ; $D068 $008A
        muls.w  $0016(a0),d0            ; $C1E8 $0016
        asr.l   #4,d0                   ; $E880
        move.w  d0,$0016(a0)            ; $3140 $0016
loc_00948A:
        move.w  $0016(a0),d0            ; $3028 $0016
        cmpi.w  #$0004,$00A8(a0)        ; $0C68 $0004 $00A8
        DC.W    $6F10               ; $009494 BLE.S  loc_0094A6
        move.w  d0,d1                   ; $3200
        add.w   d0,d0                   ; $D040
        add.w   d0,d0                   ; $D040
        add.w   d1,d0                   ; $D041
        add.w   d0,d0                   ; $D040
        add.w   d1,d0                   ; $D041
        asr.w   #4,d0                   ; $E840
        DC.W    $6016               ; $0094A4 BRA.S  loc_0094BC
loc_0094A6:
        tst.w    $00A8(a0)              ; $4A68 $00A8
        DC.W    $6710               ; $0094AA BEQ.S  loc_0094BC
        move.w  $0006(a0),d1            ; $3228 $0006
        cmp.w   $000A(a0),d1            ; $B268 $000A
        DC.W    $6F06               ; $0094B4 BLE.S  loc_0094BC
        move.w  d0,d1                   ; $3200
        asr.w   #1,d1                   ; $E241
        add.w   d1,d0                   ; $D041
loc_0094BC:
        move.w  d0,$0016(a0)            ; $3140 $0016
        jsr     speed_modifier(pc)      ; $4EBA $0670
        add.w   d0,$0016(a0)            ; $D168 $0016
        tst.b    ($FFFFC31B).w          ; $4A38 $C31B
        DC.W    $6710               ; $0094CC BEQ.S  loc_0094DE
        move.w  $0016(a0),d0            ; $3028 $0016
        asr.w   #1,d0                   ; $E240
        move.w  d0,d1                   ; $3200
        asr.w   #1,d1                   ; $E241
        add.w   d1,d0                   ; $D041
        add.w   d0,$0016(a0)            ; $D168 $0016
loc_0094DE:
        tst.w    $0014(a0)              ; $4A68 $0014
        DC.W    $6F0A               ; $0094E2 BLE.S  loc_0094EE
        subq.w  #1,$0014(a0)            ; $5368 $0014
        addi.w  #$0738,$0016(a0)        ; $0668 $0738 $0016
loc_0094EE:
        movem.l (a7)+,d0/a1             ; $4CDF $0201
        rts                             ; $4E75
        DC.W    $FFE8,$0000         ; $0094F4 MOVE.W  $0000(A0),<EA:3F>
        DC.W    $0018,$11F8         ; $0094F8 ORI.B  #$11F8,(A0)+
        DC.W    $C300               ; $0094FC AND.B  D1,D0
        DC.W    $C301               ; $0094FE AND.B  D1,D1
        move.b  ($FFFFC971).w,($FFFFC300).w; $11F8 $C971 $C300
        moveq   #$02,d2                 ; $7402
        moveq   #$03,d3                 ; $7603
        btst    #7,($FFFFFDA8).w        ; $0838 $0007 $FDA8
        DC.W    $6702               ; $009510 BEQ.S  loc_009514
        exg     d2,d3                   ; $C543
loc_009514:
        lea     ($FFFFC300).w,a1        ; $43F8 $C300
        moveq   #$00,d0                 ; $7000
        moveq   #$00,d1                 ; $7200
        btst    d2,$0001(a1)            ; $0529 $0001
        DC.W    $6702               ; $009520 BEQ.S  loc_009524
        moveq   #$01,d0                 ; $7001
loc_009524:
        btst    d3,$0001(a1)            ; $0729 $0001
        DC.W    $6702               ; $009528 BEQ.S  loc_00952C
        subq.w  #1,d0                   ; $5340
loc_00952C:
        btst    d2,(a1)                 ; $0511
        DC.W    $6702               ; $00952E BEQ.S  loc_009532
        moveq   #$01,d1                 ; $7201
loc_009532:
        btst    d3,(a1)                 ; $0711
        DC.W    $6702               ; $009534 BEQ.S  loc_009538
        subq.w  #1,d1                   ; $5341
loc_009538:
        lea     steering_input_processing_and_velocity_update+2(pc),a1; $43FA $FFBC
        cmp.w   ($FFFFC006).w,d1        ; $B278 $C006
        DC.W    $6718               ; $009540 BEQ.S  loc_00955A
        move.w  d1,($FFFFC006).w        ; $31C1 $C006
        move.w  d1,d2                   ; $3401
        add.w   d2,d2                   ; $D442
        move.w  (a1,d2.w),d2            ; $3431 $2000
        move.w  d2,($FFFFC000).w        ; $31C2 $C000
        lsl.w   #8,d2                   ; $E14A
        move.w  d2,$008E(a0)            ; $3142 $008E
        DC.W    $6046               ; $009558 BRA.S  loc_0095A0
loc_00955A:
        tst.w    d1                     ; $4A41
        DC.W    $6618               ; $00955C BNE.S  loc_009576
        move.w  ($FFFFC000).w,d2        ; $3438 $C000
        DC.W    $6708               ; $009562 BEQ.S  loc_00956C
        DC.W    $6A04               ; $009564 BPL.S  loc_00956A
        moveq   #$FE,d2                 ; $74FE
        DC.W    $6002               ; $009568 BRA.S  loc_00956C
loc_00956A:
        moveq   #$02,d2                 ; $7402
loc_00956C:
        move.w  (a1,d2.w),d2            ; $3431 $2000
        sub.w   d2,($FFFFC000).w        ; $9578 $C000
        DC.W    $602A               ; $009574 BRA.S  loc_0095A0
loc_009576:
        move.w  d1,($FFFFC006).w        ; $31C1 $C006
        move.w  d1,d2                   ; $3401
        add.w   d2,d2                   ; $D442
        move.w  (a1,d2.w),d2            ; $3431 $2000
        tst.w    ($FFFFC8C8).w          ; $4A78 $C8C8
        DC.W    $6714               ; $009586 BEQ.S  loc_00959C
        move.w  $0094(a0),d0            ; $3028 $0094
        DC.W    $B540               ; $00958C EOR.W  D2,D0
        DC.W    $6B0C               ; $00958E BMI.S  loc_00959C
        asr.w   #1,d2                   ; $E242
        move.w  $0094(a0),d0            ; $3028 $0094
        asr.w   #3,d0                   ; $E640
        sub.w   d0,$0094(a0)            ; $9168 $0094
loc_00959C:
        add.w   d2,($FFFFC000).w        ; $D578 $C000
loc_0095A0:
        cmpi.w  #$007F,($FFFFC000).w    ; $0C78 $007F $C000
        DC.W    $6F06               ; $0095A6 BLE.S  loc_0095AE
        move.w  #$007F,($FFFFC000).w    ; $31FC $007F $C000
loc_0095AE:
        cmpi.w  #$FF81,($FFFFC000).w    ; $0C78 $FF81 $C000
        DC.W    $6C06               ; $0095B4 BGE.S  loc_0095BC
        move.w  #$FF81,($FFFFC000).w    ; $31FC $FF81 $C000
loc_0095BC:
        move.w  ($FFFFC000).w,d2        ; $3438 $C000
        move.w  d2,d0                   ; $3002
        DC.W    $6A04               ; $0095C2 BPL.S  loc_0095C8
        neg.w    d0                     ; $4440
        DC.W    $680A               ; $0095C6 BVC.S  loc_0095D2
loc_0095C8:
        cmpi.w  #$0018,d0               ; $0C40 $0018
        DC.W    $6C04               ; $0095CC BGE.S  loc_0095D2
        clr.w    ($FFFFC000).w          ; $4278 $C000
loc_0095D2:
        ext.l   d2                      ; $48C2
        lsl.l   #8,d2                   ; $E18A
        move.w  $008E(a0),d1            ; $3228 $008E
        ext.l   d1                      ; $48C1
        add.l   d1,d2                   ; $D481
        asr.l   #1,d2                   ; $E282
        move.l  d2,d3                   ; $2602
        sub.l   d1,d3                   ; $9681
        tst.w    d3                     ; $4A43
        DC.W    $6A02               ; $0095E6 BPL.S  loc_0095EA
        neg.w    d3                     ; $4443
loc_0095EA:
        asr.w   #8,d3                   ; $E043
        add.w   $00AA(a0),d3            ; $D668 $00AA
        cmpi.w  #$00C8,d3               ; $0C43 $00C8
        DC.W    $6F04               ; $0095F4 BLE.S  loc_0095FA
        move.w  #$00C8,d3               ; $363C $00C8
loc_0095FA:
        cmpi.w  #$0000,d3               ; $0C43 $0000
        DC.W    $6C04               ; $0095FE BGE.S  loc_009604
        move.w  #$0000,d3               ; $363C $0000
loc_009604:
        move.w  d3,$00AA(a0)            ; $3143 $00AA
        move.w  d2,d1                   ; $3202
        DC.W    $6A04               ; $00960A BPL.S  loc_009610
        neg.w    d1                     ; $4441
        DC.W    $6908               ; $00960E BVS.S  loc_009618
loc_009610:
        cmpi.w  #$0018,d1               ; $0C41 $0018
        DC.W    $6C02               ; $009614 BGE.S  loc_009618
        moveq   #$00,d2                 ; $7400
loc_009618:
        move.w  d2,$008E(a0)            ; $3142 $008E
        rts                             ; $4E75
        move.w  $006A(a0),d0            ; $3028 $006A
        or.w    $008C(a0),d0            ; $8068 $008C
        DC.W    $665E               ; $009626 BNE.S  loc_009686
        moveq   #$30,d0                 ; $7030
        move.w  ($FFFFC0AC).w,d1        ; $3238 $C0AC
        cmp.w   $0092(a0),d1            ; $B268 $0092
        DC.W    $6D08               ; $009632 BLT.S  loc_00963C
        btst    #4,($FFFFC971).w        ; $0838 $0004 $C971
        DC.W    $6602               ; $00963A BNE.S  loc_00963E
loc_00963C:
        neg.w    d0                     ; $4440
loc_00963E:
        move.w  $000E(a0),d1            ; $3228 $000E
        add.w   d0,d1                   ; $D240
        cmpi.w  #$00FF,d1               ; $0C41 $00FF
        DC.W    $6F04               ; $009648 BLE.S  loc_00964E
        move.w  #$00FF,d1               ; $323C $00FF
loc_00964E:
        cmpi.w  #$FFCD,d1               ; $0C41 $FFCD
        DC.W    $6C04               ; $009652 BGE.S  loc_009658
        move.w  #$FFCD,d1               ; $323C $FFCD
loc_009658:
        move.w  d1,$000E(a0)            ; $3141 $000E
        moveq   #$30,d0                 ; $7030
        btst    #6,($FFFFC971).w        ; $0838 $0006 $C971
        DC.W    $6602               ; $009664 BNE.S  loc_009668
        neg.w    d0                     ; $4440
loc_009668:
        move.w  $0010(a0),d1            ; $3228 $0010
        add.w   d0,d1                   ; $D240
        cmpi.w  #$00FF,d1               ; $0C41 $00FF
        DC.W    $6F04               ; $009672 BLE.S  loc_009678
        move.w  #$00FF,d1               ; $323C $00FF
loc_009678:
        cmpi.w  #$0000,d1               ; $0C41 $0000
        DC.W    $6C04               ; $00967C BGE.S  loc_009682
        move.w  #$0000,d1               ; $323C $0000
loc_009682:
        move.w  d1,$0010(a0)            ; $3141 $0010
loc_009686:
        rts                             ; $4E75
        move.w  $008E(a0),d0            ; $3028 $008E
        asr.w   #4,d0                   ; $E840
        move.w  #$0497,d1               ; $323C $0497
        sub.w   $0006(a0),d1            ; $9268 $0006
        muls.w  d0,d1                   ; $C3C0
        DC.W    $83FC,$0497         ; $009698 DIVS    #$0497,D1
        add.w   d1,d0                   ; $D041
        move.w  d0,$0090(a0)            ; $3140 $0090
        cmpi.w  #$0080,$0004(a0)        ; $0C68 $0080 $0004
        DC.W    $6C1C               ; $0096A8 BGE.S  loc_0096C6
        move.w  d0,d2                   ; $3400
        move.w  $0004(a0),d0            ; $3028 $0004
        lsl.w   #7,d0                   ; $EF48
        addi.w  #$8000,d0               ; $0640 $8000
        jsr     sine_cosine_quadrant_lookup+4(pc); $4EBA $F89A
        addi.w  #$0100,d0               ; $0640 $0100
        muls.w  $0090(a0),d0            ; $C1E8 $0090
        asr.l   #6,d0                   ; $EC80
        add.w   d2,d0                   ; $D042
loc_0096C6:
        muls.w  $0004(a0),d0            ; $C1E8 $0004
        moveq   #$0A,d2                 ; $740A
        asr.l   d2,d0                   ; $E4A0
        move.w  $0076(a0),d2            ; $3428 $0076
        move.w  $000C(a0),d3            ; $3628 $000C
        DC.W    $6A04               ; $0096D6 BPL.S  loc_0096DC
        add.w   d3,d3                   ; $D643
        sub.w   d3,d2                   ; $9443
loc_0096DC:
        muls.w  d2,d0                   ; $C1C2
        asr.l   #8,d0                   ; $E080
        tst.w    $0092(a0)              ; $4A68 $0092
        DC.W    $6F0C               ; $0096E4 BLE.S  loc_0096F2
        move.w  #$0028,d1               ; $323C $0028
        sub.w   $0092(a0),d1            ; $9268 $0092
        muls.w  d1,d0                   ; $C1C1
        asr.l   #5,d0                   ; $EA80
loc_0096F2:
        move.w  d0,d2                   ; $3400
        move.w  d0,d1                   ; $3200
        asr.w   #1,d1                   ; $E241
        add.w   d1,d0                   ; $D041
        tst.b    ($FFFFC31B).w          ; $4A38 $C31B
        DC.W    $6704               ; $0096FE BEQ.S  loc_009704
        asr.w   #1,d2                   ; $E242
        add.w   d2,d0                   ; $D042
loc_009704:
        add.w   d0,$003C(a0)            ; $D168 $003C
        move.w  $003C(a0),d0            ; $3028 $003C
        sub.w   $001E(a0),d0            ; $9068 $001E
        DC.W    $6A02               ; $009710 BPL.S  loc_009714
        neg.w    d0                     ; $4440
loc_009714:
        cmpi.w  #$0222,d0               ; $0C40 $0222
        DC.W    $6C2E               ; $009718 BGE.S  loc_009748
        addq.w  #1,($FFFFC002).w        ; $5278 $C002
        cmpi.w  #$0004,($FFFFC002).w    ; $0C78 $0004 $C002
        DC.W    $6D26               ; $009724 BLT.S  loc_00974C
        move.w  $001E(a0),d0            ; $3028 $001E
        sub.w   $0040(a0),d0            ; $9068 $0040
        cmpi.w  #$0012,d0               ; $0C40 $0012
        DC.W    $6F04               ; $009732 BLE.S  loc_009738
        move.w  #$0012,d0               ; $303C $0012
loc_009738:
        cmpi.w  #$FFEE,d0               ; $0C40 $FFEE
        DC.W    $6C04               ; $00973C BGE.S  loc_009742
        move.w  #$FFEE,d0               ; $303C $FFEE
loc_009742:
        add.w   d0,$003C(a0)            ; $D168 $003C
        DC.W    $6004               ; $009746 BRA.S  loc_00974C
loc_009748:
        clr.w    ($FFFFC002).w          ; $4278 $C002
loc_00974C:
        move.w  $005C(a0),d0            ; $3028 $005C
        sub.w   $005A(a0),d0            ; $9068 $005A
        move.w  $0090(a0),d1            ; $3228 $0090
        DC.W    $6A04               ; $009758 BPL.S  loc_00975E
        neg.w    d0                     ; $4440
        neg.w    d1                     ; $4441
loc_00975E:
        cmpi.w  #$0190,d0               ; $0C40 $0190
        DC.W    $6F04               ; $009762 BLE.S  loc_009768
        move.w  #$0190,d0               ; $303C $0190
loc_009768:
        cmpi.w  #$FFCE,d0               ; $0C40 $FFCE
        DC.W    $6C04               ; $00976C BGE.S  loc_009772
        move.w  #$FFCE,d0               ; $303C $FFCE
loc_009772:
        lsl.w   #4,d0                   ; $E948
        move.w  d0,d2                   ; $3400
        add.w   d0,d0                   ; $D040
        add.w   d0,d0                   ; $D040
        add.w   d2,d0                   ; $D042
        asr.w   #8,d0                   ; $E040
        move.w  $0006(a0),d2            ; $3428 $0006
        add.w   d2,d2                   ; $D442
        add.w   d2,d2                   ; $D442
        move.w  d2,d3                   ; $3602
        add.w   d3,d3                   ; $D643
        add.w   d3,d3                   ; $D643
        add.w   d3,d2                   ; $D443
        muls.w  d2,d2                   ; $C5C2
        DC.W    $4842               ; $009790 SWAP    D2
        muls.w  d1,d2                   ; $C5C1
        moveq   #$0D,d1                 ; $720D
        asr.l   d1,d2                   ; $E2A2
        asr.w   #3,d2                   ; $E642
        move.w  d2,d1                   ; $3202
        asr.w   #1,d1                   ; $E241
        add.w   d1,d2                   ; $D441
        addi.w  #$0188,d0               ; $0640 $0188
        sub.w   d2,d0                   ; $9042
        move.w  $000C(a0),d1            ; $3228 $000C
        neg.w    d1                     ; $4441
        lsl.w   #4,d1                   ; $E949
        cmpi.w  #$0040,d1               ; $0C41 $0040
        DC.W    $6F04               ; $0097B2 BLE.S  loc_0097B8
        move.w  #$0040,d1               ; $323C $0040
loc_0097B8:
        cmpi.w  #$FFF0,d1               ; $0C41 $FFF0
        DC.W    $6C04               ; $0097BC BGE.S  loc_0097C2
        move.w  #$FFF0,d1               ; $323C $FFF0
loc_0097C2:
        add.w   d1,d0                   ; $D041
        cmpi.w  #$0040,d0               ; $0C40 $0040
        DC.W    $6C02               ; $0097C8 BGE.S  loc_0097CC
        moveq   #$40,d0                 ; $7040
loc_0097CC:
        cmp.w   ($FFFFC0E8).w,d0        ; $B078 $C0E8
        DC.W    $6F04               ; $0097D0 BLE.S  loc_0097D6
        move.w  ($FFFFC0E8).w,d0        ; $3038 $C0E8
loc_0097D6:
        tst.w    $00AA(a0)              ; $4A68 $00AA
        DC.W    $6F04               ; $0097DA BLE.S  loc_0097E0
        subq.w  #8,$00AA(a0)            ; $5168 $00AA
loc_0097E0:
        cmpi.w  #$0050,$00AA(a0)        ; $0C68 $0050 $00AA
        DC.W    $6E14               ; $0097E6 BGT.S  loc_0097FC
        move.w  $0076(a0),d1            ; $3228 $0076
        sub.w   d0,d1                   ; $9240
        cmpi.w  #$000C,d1               ; $0C41 $000C
        DC.W    $6F08               ; $0097F2 BLE.S  loc_0097FC
        subi.w  #$000C,$0076(a0)        ; $0468 $000C $0076
        DC.W    $6004               ; $0097FA BRA.S  loc_009800
loc_0097FC:
        move.w  d0,$0076(a0)            ; $3140 $0076
loc_009800:
        rts                             ; $4E75
        move.w  ($FFFFC8CC).w,d0        ; $3038 $C8CC
        DC.W    $227B,$0004         ; $009806 MOVEA.L $04(PC,D0.W),A1
        jmp     (a1)                    ; $4ED1
        DC.W    $0088,$9818,$0088   ; $00980C ORI.L  #$98180088,A0
        sub.l   d4,$0088(a2)            ; $99AA $0088
        DC.W    $987E               ; $009816 SUB.W  <EA:3E>,D4
        move.w  $0092(a0),d0            ; $3028 $0092
        or.w    $0062(a0),d0            ; $8068 $0062
        DC.W    $662C               ; $009820 BNE.S  loc_00984E
        move.w  $004C(a0),d0            ; $3028 $004C
        DC.W    $6A02               ; $009826 BPL.S  loc_00982A
        neg.w    d0                     ; $4440
loc_00982A:
        cmpi.w  #$0037,d0               ; $0C40 $0037
        DC.W    $6F1E               ; $00982E BLE.S  loc_00984E
        move.w  $004C(a0),d0            ; $3028 $004C
        asr.w   #7,d0                   ; $EE40
        move.w  d0,d1                   ; $3200
        asr.w   #1,d0                   ; $E240
        add.w   d1,d0                   ; $D041
        add.w   d0,$0094(a0)            ; $D168 $0094
        move.w  $0094(a0),d0            ; $3028 $0094
        asr.w   #1,d0                   ; $E240
        move.w  d0,$0096(a0)            ; $3140 $0096
        DC.W    $6000,$0030         ; $00984A BRA.W  loc_00987C
loc_00984E:
        move.w  $0094(a0),d0            ; $3028 $0094
        move.w  d0,d1                   ; $3200
        asr.w   #2,d0                   ; $E440
        sub.w   d0,$0094(a0)            ; $9168 $0094
        move.w  $0094(a0),d0            ; $3028 $0094
        move.w  d0,$0096(a0)            ; $3140 $0096
        tst.w    d1                     ; $4A41
        DC.W    $6C04               ; $009864 BGE.S  loc_00986A
        neg.w    d0                     ; $4440
        neg.w    d1                     ; $4441
loc_00986A:
        cmp.w   d0,d1                   ; $B240
        DC.W    $6D0E               ; $00986C BLT.S  loc_00987C
        tst.w    d0                     ; $4A40
        DC.W    $6D0A               ; $009870 BLT.S  loc_00987C
        cmpi.w  #$000F,d0               ; $0C40 $000F
        DC.W    $6E04               ; $009876 BGT.S  loc_00987C
        clr.w    $0094(a0)              ; $4268 $0094
loc_00987C:
        rts                             ; $4E75
        move.w  ($FFFFC000).w,d0        ; $3038 $C000
        DC.W    $6A02               ; $009882 BPL.S  loc_009886
        neg.w    d0                     ; $4440
loc_009886:
        muls.w  $0010(a0),d0            ; $C1E8 $0010
        asr.w   #8,d0                   ; $E040
        move.w  $0078(a0),d1            ; $3228 $0078
        sub.w   d0,d1                   ; $9240
        cmpi.w  #$007F,d1               ; $0C41 $007F
        DC.W    $6C02               ; $009896 BGE.S  loc_00989A
        moveq   #$7F,d1                 ; $727F
loc_00989A:
        move.w  d1,$0078(a0)            ; $3141 $0078
        clr.b    ($FFFFC31B).w          ; $4238 $C31B
        move.w  $0092(a0),d0            ; $3028 $0092
        add.w   $0062(a0),d0            ; $D068 $0062
        DC.W    $6600,$00A4         ; $0098AA BNE.W  loc_009950
        move.w  $004C(a0),d0            ; $3028 $004C
        move.w  d0,d1                   ; $3200
        DC.W    $6A02               ; $0098B4 BPL.S  loc_0098B8
        neg.w    d1                     ; $4441
loc_0098B8:
        cmpi.w  #$0037,d1               ; $0C41 $0037
        DC.W    $6F00,$0092         ; $0098BC BLE.W  loc_009950
        move.w  $0094(a0),d1            ; $3228 $0094
        DC.W    $6A02               ; $0098C4 BPL.S  loc_0098C8
        neg.w    d1                     ; $4441
loc_0098C8:
        ext.l   d0                      ; $48C0
        divs.w  ($FFFFC0EE).w,d0        ; $81F8 $C0EE
        cmp.w   ($FFFFC0F0).w,d1        ; $B278 $C0F0
        DC.W    $6E1E               ; $0098D2 BGT.S  loc_0098F2
        move.w  #$0200,d2               ; $343C $0200
        sub.w   $0078(a0),d2            ; $9468 $0078
        muls.w  d2,d0                   ; $C1C2
        asr.l   #8,d0                   ; $E080
        add.w   d0,$0094(a0)            ; $D168 $0094
        move.w  $0094(a0),d0            ; $3028 $0094
        asr.w   #1,d0                   ; $E240
        move.w  d0,$0096(a0)            ; $3140 $0096
        DC.W    $6000,$00B8         ; $0098EE BRA.W  loc_0099A8
loc_0098F2:
        move.b  #$01,($FFFFC31B).w      ; $11FC $0001 $C31B
        asr.w   #2,d0                   ; $E440
        move.w  d0,d1                   ; $3200
        asr.w   #1,d1                   ; $E241
        add.w   d1,d0                   ; $D041
        add.w   d0,$0094(a0)            ; $D168 $0094
        move.w  $0094(a0),d0            ; $3028 $0094
        move.w  d0,d1                   ; $3200
        DC.W    $6A02               ; $00990A BPL.S  loc_00990E
        neg.w    d1                     ; $4441
loc_00990E:
        move.w  d0,$0096(a0)            ; $3140 $0096
        muls.w  ($FFFFC0F6).w,d0        ; $C1F8 $C0F6
        asr.l   #8,d0                   ; $E080
        sub.w   d0,$003C(a0)            ; $9168 $003C
        cmp.w   ($FFFFC0F2).w,d1        ; $B278 $C0F2
        DC.W    $6D00,$0086         ; $009920 BLT.W  loc_0099A8
        move.w  $006A(a0),d2            ; $3428 $006A
        add.w   $008C(a0),d2            ; $D468 $008C
        DC.W    $6600,$007A         ; $00992C BNE.W  loc_0099A8
        move.w  #$2000,d2               ; $343C $2000
        tst.w    $0094(a0)              ; $4A68 $0094
        DC.W    $6B04               ; $009938 BMI.S  loc_00993E
        move.w  #$1000,d2               ; $343C $1000
loc_00993E:
        move.b  #$B2,($FFFFC8A4).w      ; $11FC $00B2 $C8A4
        or.w    d2,$0002(a0)            ; $8568 $0002
        clr.b    ($FFFFC31B).w          ; $4238 $C31B
        DC.W    $6000,$005A         ; $00994C BRA.W  loc_0099A8
loc_009950:
        move.w  $0094(a0),d0            ; $3028 $0094
        move.w  d0,d1                   ; $3200
        DC.W    $6B0C               ; $009956 BMI.S  loc_009964
        cmpi.w  #$0100,d0               ; $0C40 $0100
        DC.W    $6E10               ; $00995C BGT.S  loc_00996E
        move.w  #$0100,d0               ; $303C $0100
        DC.W    $600A               ; $009962 BRA.S  loc_00996E
loc_009964:
        cmpi.w  #$FF00,d0               ; $0C40 $FF00
        DC.W    $6D04               ; $009968 BLT.S  loc_00996E
        move.w  #$FF00,d0               ; $303C $FF00
loc_00996E:
        move.w  d0,d1                   ; $3200
        muls.w  ($FFFFC0F4).w,d0        ; $C1F8 $C0F4
        asr.l   #8,d0                   ; $E080
        sub.w   d0,$0094(a0)            ; $9168 $0094
        move.w  $0094(a0),d2            ; $3428 $0094
        DC.W    $B540               ; $00997E EOR.W  D2,D0
        DC.W    $6A04               ; $009980 BPL.S  loc_009986
        clr.w    $0094(a0)              ; $4268 $0094
loc_009986:
        move.w  $0094(a0),d0            ; $3028 $0094
        move.w  d0,$0096(a0)            ; $3140 $0096
        tst.w    d1                     ; $4A41
        DC.W    $6C04               ; $009990 BGE.S  loc_009996
        neg.w    d0                     ; $4440
        neg.w    d1                     ; $4441
loc_009996:
        cmp.w   d0,d1                   ; $B240
        DC.W    $6D0E               ; $009998 BLT.S  loc_0099A8
        tst.w    d0                     ; $4A40
        DC.W    $6D0A               ; $00999C BLT.S  loc_0099A8
        cmpi.w  #$000F,d0               ; $0C40 $000F
        DC.W    $6E04               ; $0099A2 BGT.S  loc_0099A8
        clr.w    $0094(a0)              ; $4268 $0094
loc_0099A8:
        rts                             ; $4E75
        move.w  #$00B5,d6               ; $3C3C $00B5
        move.w  d6,d7                   ; $3E06
        move.w  ($FFFFC000).w,d0        ; $3038 $C000
        DC.W    $6A02               ; $0099B4 BPL.S  loc_0099B8
        neg.w    d0                     ; $4440
loc_0099B8:
        muls.w  $0010(a0),d0            ; $C1E8 $0010
        asr.l   #7,d0                   ; $EE80
        moveq   #$00,d1                 ; $7200
        cmpi.w  #$00C8,$0004(a0)        ; $0C68 $00C8 $0004
        DC.W    $6F12               ; $0099C6 BLE.S  loc_0099DA
        btst    #4,($FFFFC971).w        ; $0838 $0004 $C971
        DC.W    $670A               ; $0099CE BEQ.S  loc_0099DA
        move.w  #$00FF,d1               ; $323C $00FF
        sub.w   $000E(a0),d1            ; $9268 $000E
        asl.w   #3,d1                   ; $E741
loc_0099DA:
        add.w   d1,d0                   ; $D041
        move.w  $0078(a0),d1            ; $3228 $0078
        sub.w   d0,d1                   ; $9240
        cmpi.w  #$00FF,d1               ; $0C41 $00FF
        DC.W    $6F04               ; $0099E6 BLE.S  loc_0099EC
        move.w  #$00FF,d1               ; $323C $00FF
loc_0099EC:
        cmpi.w  #$0040,d1               ; $0C41 $0040
        DC.W    $6C04               ; $0099F0 BGE.S  loc_0099F6
        move.w  #$0040,d1               ; $323C $0040
loc_0099F6:
        move.w  d1,$0078(a0)            ; $3141 $0078
        move.w  $0092(a0),d0            ; $3028 $0092
        add.w   $0062(a0),d0            ; $D068 $0062
        DC.W    $6600,$00A2         ; $009A02 BNE.W  loc_009AA6
        move.w  $004C(a0),d0            ; $3028 $004C
        move.w  d0,d1                   ; $3200
        DC.W    $6A02               ; $009A0C BPL.S  loc_009A10
        neg.w    d1                     ; $4441
loc_009A10:
        cmpi.w  #$0037,d1               ; $0C41 $0037
        DC.W    $6F00,$0090         ; $009A14 BLE.W  loc_009AA6
        move.w  $0094(a0),d1            ; $3228 $0094
        DC.W    $6A02               ; $009A1C BPL.S  loc_009A20
        neg.w    d1                     ; $4441
loc_009A20:
        move.w  #$0200,d2               ; $343C $0200
        sub.w   $0078(a0),d2            ; $9468 $0078
        muls.w  d2,d0                   ; $C1C2
        asr.l   #8,d0                   ; $E080
        divs.w  ($FFFFC0EE).w,d0        ; $81F8 $C0EE
        cmp.w   ($FFFFC0F0).w,d1        ; $B278 $C0F0
        DC.W    $6F02               ; $009A34 BLE.S  loc_009A38
        asr.w   #1,d0                   ; $E240
loc_009A38:
        add.w   d0,$0094(a0)            ; $D168 $0094
        move.w  $0094(a0),d0            ; $3028 $0094
        move.w  d0,d2                   ; $3400
        add.w   d2,d2                   ; $D442
        move.w  d2,$0096(a0)            ; $3142 $0096
        move.w  d0,d1                   ; $3200
        DC.W    $6A02               ; $009A4A BPL.S  loc_009A4E
        neg.w    d1                     ; $4441
loc_009A4E:
        cmpi.w  #$0100,d1               ; $0C41 $0100
        DC.W    $6D18               ; $009A52 BLT.S  loc_009A6C
        moveq   #$7F,d2                 ; $747F
        tst.w    d0                     ; $4A40
        DC.W    $6B02               ; $009A58 BMI.S  loc_009A5C
        neg.w    d2                     ; $4442
loc_009A5C:
        add.w   d2,d6                   ; $DC42
        sub.w   d2,d7                   ; $9E42
        cmpi.w  #$000B,$0080(a0)        ; $0C68 $000B $0080
        DC.W    $6C04               ; $009A66 BGE.S  loc_009A6C
        addq.w  #4,$0080(a0)            ; $5868 $0080
loc_009A6C:
        muls.w  ($FFFFC0F6).w,d0        ; $C1F8 $C0F6
        asr.l   #8,d0                   ; $E080
        sub.w   d0,$003C(a0)            ; $9168 $003C
        cmp.w   ($FFFFC0F2).w,d1        ; $B278 $C0F2
        DC.W    $6D00,$0088         ; $009A7A BLT.W  loc_009B04
        move.w  $006A(a0),d2            ; $3428 $006A
        add.w   $008C(a0),d2            ; $D468 $008C
        DC.W    $6600,$007C         ; $009A86 BNE.W  loc_009B04
        move.w  #$2000,d2               ; $343C $2000
        tst.w    $0094(a0)              ; $4A68 $0094
        DC.W    $6B04               ; $009A92 BMI.S  loc_009A98
        move.w  #$1000,d2               ; $343C $1000
loc_009A98:
        move.b  #$B2,($FFFFC8A4).w      ; $11FC $00B2 $C8A4
        or.w    d2,$0002(a0)            ; $8568 $0002
        DC.W    $6000,$0060         ; $009AA2 BRA.W  loc_009B04
loc_009AA6:
        move.w  $0094(a0),d0            ; $3028 $0094
        move.w  d0,d1                   ; $3200
        DC.W    $6B0C               ; $009AAC BMI.S  loc_009ABA
        cmpi.w  #$0200,d0               ; $0C40 $0200
        DC.W    $6E10               ; $009AB2 BGT.S  loc_009AC4
        move.w  #$0200,d0               ; $303C $0200
        DC.W    $600A               ; $009AB8 BRA.S  loc_009AC4
loc_009ABA:
        cmpi.w  #$FE00,d0               ; $0C40 $FE00
        DC.W    $6D04               ; $009ABE BLT.S  loc_009AC4
        move.w  #$FE00,d0               ; $303C $FE00
loc_009AC4:
        move.w  d0,d1                   ; $3200
        muls.w  ($FFFFC0F4).w,d0        ; $C1F8 $C0F4
        asr.l   #8,d0                   ; $E080
        sub.w   d0,$0094(a0)            ; $9168 $0094
        move.w  $0094(a0),d2            ; $3428 $0094
        DC.W    $B540               ; $009AD4 EOR.W  D2,D0
        DC.W    $6A04               ; $009AD6 BPL.S  loc_009ADC
        clr.w    $0094(a0)              ; $4268 $0094
loc_009ADC:
        move.w  $0094(a0),d0            ; $3028 $0094
        move.w  d0,d2                   ; $3400
        asr.w   #1,d2                   ; $E242
        add.w   d0,d2                   ; $D440
        move.w  d2,$0096(a0)            ; $3142 $0096
        tst.w    d1                     ; $4A41
        DC.W    $6C04               ; $009AEC BGE.S  loc_009AF2
        neg.w    d0                     ; $4440
        neg.w    d1                     ; $4441
loc_009AF2:
        cmp.w   d0,d1                   ; $B240
        DC.W    $6D0E               ; $009AF4 BLT.S  loc_009B04
        tst.w    d0                     ; $4A40
        DC.W    $6D0A               ; $009AF8 BLT.S  loc_009B04
        cmpi.w  #$000F,d0               ; $0C40 $000F
        DC.W    $6E04               ; $009AFE BGT.S  loc_009B04
        clr.w    $0094(a0)              ; $4268 $0094
loc_009B04:
        move.w  d6,$00FF617A            ; $33C6 $00FF $617A
        move.w  d7,$00FF618E            ; $33C7 $00FF $618E
        rts                             ; $4E75
        move.w  $0006(a0),d0            ; $3028 $0006
        tst.w    $00A8(a0)              ; $4A68 $00A8
        DC.W    $660A               ; $009B1A BNE.S  loc_009B26
        cmp.w   $000A(a0),d0            ; $B068 $000A
        DC.W    $6F04               ; $009B20 BLE.S  loc_009B26
        move.w  $000A(a0),d0            ; $3028 $000A
loc_009B26:
        DC.W    $C1FC,$0048         ; $009B26 MULS    #$0048,D0
        asr.l   #8,d0                   ; $E080
        move.w  d0,$0004(a0)            ; $3140 $0004
        rts                             ; $4E75
loc_009B32:
        move.l  d1,-(a7)                ; $2F01
        moveq   #$00,d0                 ; $7000
        move.b  ($FFFFC31A).w,d1        ; $1238 $C31A
        DC.W    $6712               ; $009B3A BEQ.S  loc_009B4E
        move.w  $0004(a0),d0            ; $3028 $0004
        muls.w  d0,d0                   ; $C1C0
        lsr.l   #4,d0                   ; $E888
        cmpi.b  #$02,d1                 ; $0C01 $0002
        DC.W    $6E06               ; $009B48 BGT.S  loc_009B50
        lsr.w   #1,d0                   ; $E248
        DC.W    $6002               ; $009B4C BRA.S  loc_009B50
loc_009B4E:
        moveq   #$00,d0                 ; $7000
loc_009B50:
        move.l  (a7)+,d1                ; $221F
        rts                             ; $4E75
        moveq   #$FF,d0                 ; $70FF
        move.w  d0,($FFFFC00C).w        ; $31C0 $C00C
        move.w  d0,($FFFFC018).w        ; $31C0 $C018
        move.w  d0,($FFFFC012).w        ; $31C0 $C012
        tst.w    $00FF6114              ; $4A79 $00FF $6114
        DC.W    $6706               ; $009B68 BEQ.S  loc_009B70
        tst.w    ($FFFFC048).w          ; $4A78 $C048
        DC.W    $6612               ; $009B6E BNE.S  loc_009B82
loc_009B70:
        move.w  d0,($FFFFC01E).w        ; $31C0 $C01E
        move.w  d0,($FFFFC024).w        ; $31C0 $C024
        move.w  d0,($FFFFC00E).w        ; $31C0 $C00E
        move.w  d0,($FFFFC010).w        ; $31C0 $C010
        rts                             ; $4E75
loc_009B82:
        move.w  $0080(a0),d1            ; $3228 $0080
        cmpi.w  #$0007,d1               ; $0C41 $0007
        DC.W    $6E0A               ; $009B8A BGT.S  loc_009B96
        move.w  $0082(a0),d1            ; $3228 $0082
        cmpi.w  #$0007,d1               ; $0C41 $0007
        DC.W    $6F08               ; $009B94 BLE.S  loc_009B9E
loc_009B96:
        moveq   #$0F,d0                 ; $700F
        sub.w   d1,d0                   ; $9041
        move.w  d0,($FFFFC00C).w        ; $31C0 $C00C
loc_009B9E:
        move.w  $0084(a0),d0            ; $3028 $0084
        DC.W    $670E               ; $009BA2 BEQ.S  loc_009BB2
        cmpi.w  #$000A,d0               ; $0C40 $000A
        DC.W    $6E08               ; $009BA8 BGT.S  loc_009BB2
        moveq   #$0A,d1                 ; $720A
        sub.w   d0,d1                   ; $9240
        move.w  d1,($FFFFC018).w        ; $31C1 $C018
loc_009BB2:
        cmpi.w  #$0014,$0004(a0)        ; $0C68 $0014 $0004
        DC.W    $6F42               ; $009BB8 BLE.S  loc_009BFC
        move.w  $0098(a0),d0            ; $3028 $0098
        DC.W    $6718               ; $009BBE BEQ.S  loc_009BD8
        addq.w  #1,($FFFFC01E).w        ; $5278 $C01E
        andi.w  #$0003,($FFFFC01E).w    ; $0278 $0003 $C01E
        cmpi.w  #$0078,$0004(a0)        ; $0C68 $0078 $0004
        DC.W    $6E0C               ; $009BD0 BGT.S  loc_009BDE
        addq.w  #4,($FFFFC01E).w        ; $5878 $C01E
        DC.W    $6006               ; $009BD6 BRA.S  loc_009BDE
loc_009BD8:
        move.w  #$FFFF,($FFFFC01E).w    ; $31FC $FFFF $C01E
loc_009BDE:
        move.w  $009A(a0),d1            ; $3228 $009A
        DC.W    $671E               ; $009BE2 BEQ.S  loc_009C02
        addq.w  #1,($FFFFC024).w        ; $5278 $C024
        andi.w  #$0003,($FFFFC024).w    ; $0278 $0003 $C024
        cmpi.w  #$0078,$0004(a0)        ; $0C68 $0078 $0004
        DC.W    $6E12               ; $009BF4 BGT.S  loc_009C08
        addq.w  #4,($FFFFC024).w        ; $5878 $C024
        DC.W    $600C               ; $009BFA BRA.S  loc_009C08
loc_009BFC:
        move.w  #$FFFF,($FFFFC01E).w    ; $31FC $FFFF $C01E
loc_009C02:
        move.w  #$FFFF,($FFFFC024).w    ; $31FC $FFFF $C024
loc_009C08:
        cmpi.w  #$0014,$0004(a0)        ; $0C68 $0014 $0004
        DC.W    $6F42               ; $009C0E BLE.S  loc_009C52
        move.w  $00E6(a0),d0            ; $3028 $00E6
        DC.W    $6718               ; $009C14 BEQ.S  loc_009C2E
        addq.w  #1,($FFFFC00E).w        ; $5278 $C00E
        andi.w  #$0003,($FFFFC00E).w    ; $0278 $0003 $C00E
        cmpi.w  #$0078,$0004(a0)        ; $0C68 $0078 $0004
        DC.W    $6E0C               ; $009C26 BGT.S  loc_009C34
        addq.w  #4,($FFFFC00E).w        ; $5878 $C00E
        DC.W    $6006               ; $009C2C BRA.S  loc_009C34
loc_009C2E:
        move.w  #$FFFF,($FFFFC00E).w    ; $31FC $FFFF $C00E
loc_009C34:
        move.w  $00E8(a0),d1            ; $3228 $00E8
        DC.W    $671E               ; $009C38 BEQ.S  loc_009C58
        addq.w  #1,($FFFFC010).w        ; $5278 $C010
        andi.w  #$0003,($FFFFC010).w    ; $0278 $0003 $C010
        cmpi.w  #$0078,$0004(a0)        ; $0C68 $0078 $0004
        DC.W    $6E12               ; $009C4A BGT.S  loc_009C5E
        addq.w  #4,($FFFFC010).w        ; $5878 $C010
        DC.W    $600C               ; $009C50 BRA.S  loc_009C5E
loc_009C52:
        move.w  #$FFFF,($FFFFC00E).w    ; $31FC $FFFF $C00E
loc_009C58:
        move.w  #$FFFF,($FFFFC010).w    ; $31FC $FFFF $C010
loc_009C5E:
        move.w  $00BE(a0),d0            ; $3028 $00BE
        add.w   d0,d0                   ; $D040
        DC.W    $4EFB,$0002         ; $009C64 JMP     $02(PC,D0.W)
        DC.W    $6002               ; $009C68 BRA.S  loc_009C6C
        DC.W    $6018               ; $009C6A BRA.S  loc_009C84
loc_009C6C:
        cmpi.w  #$0007,$0086(a0)        ; $0C68 $0007 $0086
        DC.W    $6F26               ; $009C72 BLE.S  loc_009C9A
        moveq   #$0F,d1                 ; $720F
        sub.w   $0086(a0),d1            ; $9268 $0086
        add.w   d1,d1                   ; $D241
        DC.W    $31FB,$101E,$C012   ; $009C7C MOVE.W  $1E(PC,D1.W),$C012.W
        DC.W    $6016               ; $009C82 BRA.S  loc_009C9A
loc_009C84:
        cmpi.w  #$0000,$0086(a0)        ; $0C68 $0000 $0086
        DC.W    $6F0E               ; $009C8A BLE.S  loc_009C9A
        moveq   #$0F,d1                 ; $720F
        sub.w   $0086(a0),d1            ; $9268 $0086
        add.w   d1,d1                   ; $D241
        DC.W    $31FB,$1018,$C012   ; $009C94 MOVE.W  $18(PC,D1.W),$C012.W
loc_009C9A:
        rts                             ; $4E75
        ori.b  #$01,d0                  ; $0000 $0001
        ori.b  #$03,d2                  ; $0002 $0003
        ori.b  #$06,d4                  ; $0004 $0006
        DC.W    $0008,$0009         ; $009CA8 ORI.B  #$0009,A0
        DC.W    $000A,$0000         ; $009CAC ORI.B  #$0000,A2
        ori.b  #$01,d1                  ; $0001 $0001
        ori.b  #$03,d2                  ; $0002 $0003
        ori.b  #$04,d3                  ; $0003 $0004
        ori.b  #$05,d5                  ; $0005 $0005
        ori.b  #$07,d6                  ; $0006 $0007
        ori.b  #$08,d7                  ; $0007 $0008
        DC.W    $0009,$0009         ; $009CC8 ORI.B  #$0009,A1
        DC.W    $000A,$2F08         ; $009CCC ORI.B  #$2F08,A2
        move.w  $00A4(a0),d6            ; $3C28 $00A4
        move.w  $00A6(a0),d7            ; $3E28 $00A6
        lea     (a0),a1                 ; $43D0
        lea     ($FFFFA044).w,a2        ; $45F8 $A044
        lea     ($FFFFA000).w,a3        ; $47F8 $A000
        move.w  $0024(a1),(a2)+         ; $34E9 $0024
        move.w  a1,(a2)+                ; $34C9
        move.w  $002E(a1),d0            ; $3029 $002E
        lsl.w   #8,d0                   ; $E148
        add.w   $0024(a1),d0            ; $D069 $0024
        move.w  d0,(a3)+                ; $36C0
        move.w  a1,(a3)+                ; $36C9
        lea     $0100(a1),a1            ; $43E9 $0100
        moveq   #$0E,d2                 ; $740E
loc_009CFC:
        move.w  $0024(a1),(a2)+         ; $34E9 $0024
        move.w  a1,(a2)+                ; $34C9
        move.w  $002C(a1),d0            ; $3029 $002C
        lsl.w   #8,d0                   ; $E148
        add.w   $0024(a1),d0            ; $D069 $0024
        move.w  d0,(a3)+                ; $36C0
        move.w  a1,(a3)+                ; $36C9
        lea     $0100(a1),a1            ; $43E9 $0100
        DC.W    $51CA,$FFE6         ; $009D14 DBRA    D2,loc_009CFC
        lea     ($FFFFA044).w,a0        ; $41F8 $A044
        jsr     depth_sort+12(pc)       ; $4EBA $00C4
        lea     ($FFFFA000).w,a0        ; $41F8 $A000
        jsr     depth_sort+12(pc)       ; $4EBA $00BC
        lea     ($FFFFA044).w,a0        ; $41F8 $A044
        move.l  $003C(a0),(-$4)(a0)     ; $2168 $003C $FFFC
        move.l  (a0),$0040(a0)          ; $2150 $0040
        moveq   #$0F,d2                 ; $740F
loc_009D38:
        movea.w $0002(a0),a3            ; $3668 $0002
        move.w  (-$2)(a0),d0            ; $3028 $FFFE
        lsr.w   #8,d0                   ; $E048
        andi.w  #$000F,d0               ; $0240 $000F
        move.w  d0,$00A4(a3)            ; $3740 $00A4
        move.w  $0006(a0),d0            ; $3028 $0006
        lsr.w   #8,d0                   ; $E048
        andi.w  #$000F,d0               ; $0240 $000F
        move.w  d0,$00A6(a3)            ; $3740 $00A6
        lea     $0004(a0),a0            ; $41E8 $0004
        DC.W    $51CA,$FFDA         ; $009D5C DBRA    D2,loc_009D38
        lea     ($FFFFA000).w,a0        ; $41F8 $A000
        moveq   #$01,d1                 ; $7201
        moveq   #$0F,d2                 ; $740F
loc_009D68:
        movea.w $0002(a0),a2            ; $3468 $0002
        move.w  d1,$002A(a2)            ; $3541 $002A
        lea     $0004(a0),a0            ; $41E8 $0004
        addq.w  #1,d1                   ; $5241
        DC.W    $51CA,$FFF0         ; $009D76 DBRA    D2,loc_009D68
        lea     ($FFFF9000).w,a0        ; $41F8 $9000
        move.b  $002B(a0),($FFFFC304).w ; $11E8 $002B $C304
        cmp.w   $00A6(a0),d6            ; $BC68 $00A6
        DC.W    $6708               ; $009D88 BEQ.S  loc_009D92
        cmp.w   $00A4(a0),d7            ; $BE68 $00A4
        DC.W    $6642               ; $009D8E BNE.S  loc_009DD2
        move.w  d7,d6                   ; $3C07
loc_009D92:
        move.w  $0004(a0),d1            ; $3228 $0004
        move.b  $00E5(a0),d2            ; $1428 $00E5
        lsl.w   #8,d6                   ; $E14E
        lea     (a0,d6.w),a0            ; $41F0 $6000
        sub.w   $0004(a0),d1            ; $9268 $0004
        DC.W    $6A02               ; $009DA4 BPL.S  loc_009DA8
        neg.w    d1                     ; $4441
loc_009DA8:
        cmpi.w  #$0014,d1               ; $0C41 $0014
        DC.W    $6F24               ; $009DAC BLE.S  loc_009DD2
        cmpi.w  #$0004,($FFFFC89C).w    ; $0C78 $0004 $C89C
        DC.W    $660C               ; $009DB4 BNE.S  loc_009DC2
        move.b  $00E5(a0),d1            ; $1228 $00E5
        DC.W    $B302               ; $009DBA EOR.B  D1,D2
        andi.b  #$06,d2                 ; $0202 $0006
        DC.W    $6610               ; $009DC0 BNE.S  loc_009DD2
loc_009DC2:
        move.w  $00C2(a0),d0            ; $3028 $00C2
        lsr.w   #4,d0                   ; $E848
        add.w   ($FFFFC8CC).w,d0        ; $D078 $C8CC
        DC.W    $11FB,$0008,$C8A4   ; $009DCC MOVE.B  $08(PC,D0.W),$C8A4.W
loc_009DD2:
        movea.l (a7)+,a0                ; $205F
        rts                             ; $4E75
        DC.W    $B3BB,$B3BC         ; $009DD6 EOR.L  D1,-$44(PC,A3.W)
        DC.W    $CCCD               ; $009DDA MULU    A5,D6
        DC.W    $CCCE               ; $009DDC MULU    A6,D6
        muls.w  (a0),d7                 ; $CFD0
        muls.w  (a1),d7                 ; $CFD1
loc_009DE2:
        moveq   #$0E,d1                 ; $720E
loc_009DE4:
        lea     $0004(a0),a1            ; $43E8 $0004
        move.w  d1,d2                   ; $3401
loc_009DEA:
        move.w  (a0),d0                 ; $3010
        cmp.w   (a1),d0                 ; $B051
        DC.W    $6D52               ; $009DEE BLT.S  loc_009E42
        DC.W    $6E56               ; $009DF0 BGT.S  loc_009E48
        movea.w $0002(a0),a2            ; $3468 $0002
        movea.w $0002(a1),a3            ; $3669 $0002
        move.w  $001E(a2),d0            ; $302A $001E
        addi.w  #$2000,d0               ; $0640 $2000
        rol.w   #3,d0                   ; $E758
        andi.w  #$0006,d0               ; $0240 $0006
        DC.W    $4EFB,$0002         ; $009E08 JMP     $02(PC,D0.W)
        DC.W    $6006               ; $009E0C BRA.S  loc_009E14
        DC.W    $6010               ; $009E0E BRA.S  loc_009E20
        DC.W    $601A               ; $009E10 BRA.S  loc_009E2C
        DC.W    $6024               ; $009E12 BRA.S  loc_009E38
loc_009E14:
        move.w  $0034(a2),d0            ; $302A $0034
        cmp.w   $0034(a3),d0            ; $B06B $0034
        DC.W    $6D24               ; $009E1C BLT.S  loc_009E42
        DC.W    $6028               ; $009E1E BRA.S  loc_009E48
loc_009E20:
        move.w  $0030(a2),d0            ; $302A $0030
        cmp.w   $0030(a3),d0            ; $B06B $0030
        DC.W    $6E18               ; $009E28 BGT.S  loc_009E42
        DC.W    $601C               ; $009E2A BRA.S  loc_009E48
loc_009E2C:
        move.w  $0034(a2),d0            ; $302A $0034
        cmp.w   $0034(a3),d0            ; $B06B $0034
        DC.W    $6E0C               ; $009E34 BGT.S  loc_009E42
        DC.W    $6010               ; $009E36 BRA.S  loc_009E48
loc_009E38:
        move.w  $0030(a2),d0            ; $302A $0030
        cmp.w   $0030(a3),d0            ; $B06B $0030
        DC.W    $6E06               ; $009E40 BGT.S  loc_009E48
loc_009E42:
        move.l  (a0),d0                 ; $2010
        move.l  (a1),(a0)               ; $2091
        move.l  d0,(a1)                 ; $2280
loc_009E48:
        lea     $0004(a1),a1            ; $43E9 $0004
        DC.W    $51CA,$FF9C         ; $009E4C DBRA    D2,loc_009DEA
        lea     $0004(a0),a0            ; $41E8 $0004
        DC.W    $51C9,$FF8E         ; $009E54 DBRA    D1,loc_009DE4
        rts                             ; $4E75
        tst.w    $00A8(a0)              ; $4A68 $00A8
        DC.W    $6704               ; $009E5E BEQ.S  loc_009E64
        subq.w  #1,$00A8(a0)            ; $5368 $00A8
loc_009E64:
        cmpi.w  #$0002,$002A(a0)        ; $0C68 $0002 $002A
        DC.W    $670C               ; $009E6A BEQ.S  loc_009E78
        rts                             ; $4E75
        tst.w    $00A8(a0)              ; $4A68 $00A8
        DC.W    $6704               ; $009E72 BEQ.S  loc_009E78
        subq.w  #1,$00A8(a0)            ; $5368 $00A8
loc_009E78:
        move.w  $00A4(a0),d0            ; $3028 $00A4
        asl.w   #8,d0                   ; $E140
        lea     ($FFFF9000).w,a1        ; $43F8 $9000
        lea     (a1,d0.w),a1            ; $43F1 $0000
        move.w  $0072(a1),d0            ; $3029 $0072
        sub.w   $0072(a0),d0            ; $9068 $0072
        DC.W    $6A02               ; $009E8E BPL.S  loc_009E92
        neg.w    d0                     ; $4440
loc_009E92:
        cmpi.w  #$0030,d0               ; $0C40 $0030
        DC.W    $6E26               ; $009E96 BGT.S  loc_009EBE
        move.w  $0030(a1),d0            ; $3029 $0030
        sub.w   $0030(a0),d0            ; $9068 $0030
        DC.W    $6A02               ; $009EA0 BPL.S  loc_009EA4
        neg.w    d0                     ; $4440
loc_009EA4:
        move.w  $0034(a1),d1            ; $3229 $0034
        sub.w   $0034(a0),d1            ; $9268 $0034
        DC.W    $6A02               ; $009EAC BPL.S  loc_009EB0
        neg.w    d1                     ; $4441
loc_009EB0:
        add.w   d1,d0                   ; $D041
        cmpi.w  #$0070,d0               ; $0C40 $0070
loc_009EB6:
        DC.W    $6E06               ; $009EB6 BGT.S  loc_009EBE
        move.w  #$000C,$00A8(a0)        ; $317C $000C $00A8
loc_009EBE:
        rts                             ; $4E75
        move.w  ($FFFFC8AC).w,d0        ; $3038 $C8AC
        DC.W    $227B,$0004         ; $009EC4 MOVEA.L $04(PC,D0.W),A1
        jmp     (a1)                    ; $4ED1
        DC.W    $0088,$A04E,$0088   ; $009ECA ORI.L  #$A04E0088,A0
        sub.b   d7,(a6)                 ; $9F16
        DC.W    $0088,$9F2A,$0088   ; $009ED2 ORI.L  #$9F2A0088,A0
        subx.w  -(a2),-(a7)             ; $9F4A
        DC.W    $0088,$9F6C,$0088   ; $009EDA ORI.L  #$9F6C0088,A0
        subx.l  -(a6),-(a7)             ; $9F8E
        DC.W    $0088,$9FBC,$0088   ; $009EE2 ORI.L  #$9FBC0088,A0
        DC.W    $A04E               ; $009EE8 MOVEA.L A6,A0
        DC.W    $0088,$3D9A,$0088   ; $009EEA ORI.L  #$3D9A0088,A0
        move.w  -(a6),(-120,a6,d0.w)    ; $3DA6 $0088
        DC.W    $3DD4               ; $009EF4 MOVE.W  (A4),<EA:3E>
        DC.W    $0088,$3E08,$0088   ; $009EF6 ORI.L  #$3E080088,A0
        movea.w (a0)+,a7                ; $3E58
        DC.W    $0088,$3E64,$0088   ; $009EFE ORI.L  #$3E640088,A0
        DC.W    $3E7E               ; $009F04 MOVEA.W <EA:3E>,A7
        DC.W    $0088,$3EA2,$0088   ; $009F06 ORI.L  #$3EA20088,A0
        move.w  d6,(a7)+                ; $3EC6
        DC.W    $0088,$3EF6,$0088   ; $009F0E ORI.L  #$3EF60088,A0
        move.w  $4278(a4),-(a7)         ; $3F2C $4278
        sub.l   (120,a0,d4.w),d0        ; $90B0 $4278
        and.l   $13FC(a2),d4            ; $C8AA $13FC
        ori.b  #$FF,d1                  ; $0001 $00FF
        DC.W    $6990               ; $009F24 BVS.S  loc_009EB6
        addq.w  #4,($FFFFC8AC).w        ; $5878 $C8AC
        cmpi.w  #$003C,($FFFFC8AA).w    ; $0C78 $003C $C8AA
        DC.W    $6D00,$00F0         ; $009F30 BLT.W  loc_00A022
        addq.w  #4,($FFFFC8AC).w        ; $5878 $C8AC
        clr.w    ($FFFFC8AA).w          ; $4278 $C8AA
        move.b  #$09,$00FF6980          ; $13FC $0009 $00FF $6980
        move.b  #$C0,($FFFFC8A4).w      ; $11FC $00C0 $C8A4
        cmpi.w  #$0014,($FFFFC8AA).w    ; $0C78 $0014 $C8AA
        DC.W    $6D00,$00D0         ; $009F50 BLT.W  loc_00A022
        addq.w  #4,($FFFFC8AC).w        ; $5878 $C8AC
        clr.w    ($FFFFC8AA).w          ; $4278 $C8AA
        move.l  #$222F038A,$00FF6988    ; $23FC $222F $038A $00FF $6988
        move.b  #$C1,($FFFFC8A4).w      ; $11FC $00C1 $C8A4
        cmpi.w  #$0014,($FFFFC8AA).w    ; $0C78 $0014 $C8AA
        DC.W    $6D00,$00AE         ; $009F72 BLT.W  loc_00A022
        addq.w  #4,($FFFFC8AC).w        ; $5878 $C8AC
        clr.w    ($FFFFC8AA).w          ; $4278 $C8AA
        move.l  #$222F002C,$00FF6988    ; $23FC $222F $002C $00FF $6988
        move.b  #$C2,($FFFFC8A4).w      ; $11FC $00C2 $C8A4
        cmpi.w  #$0014,($FFFFC8AA).w    ; $0C78 $0014 $C8AA
        DC.W    $6D00,$008C         ; $009F94 BLT.W  loc_00A022
        addq.w  #4,($FFFFC8AC).w        ; $5878 $C8AC
        clr.w    ($FFFFC8AA).w          ; $4278 $C8AA
        clr.b    $00FF6990              ; $4239 $00FF $6990
        move.l  #$222EEF3A,$00FF6988    ; $23FC $222E $EF3A $00FF $6988
        bset    #4,($FFFFC30E).w        ; $08F8 $0004 $C30E
        move.b  #$C3,($FFFFC8A4).w      ; $11FC $00C3 $C8A4
        cmpi.w  #$0005,($FFFFC8AA).w    ; $0C78 $0005 $C8AA
        DC.W    $6614               ; $009FC2 BNE.S  loc_009FD8
        move.b  #$82,($FFFFC8A5).w      ; $11FC $0082 $C8A5
        btst    #5,($FFFFC80E).w        ; $0838 $0005 $C80E
        DC.W    $6706               ; $009FD0 BEQ.S  loc_009FD8
        move.b  #$93,($FFFFC8A5).w      ; $11FC $0093 $C8A5
loc_009FD8:
        clr.w    ($FFFFC026).w          ; $4278 $C026
        tst.b    ($FFFFC312).w          ; $4A38 $C312
        DC.W    $661A               ; $009FE0 BNE.S  loc_009FFC
        moveq   #$00,d0                 ; $7000
        btst    #2,($FFFFC8AB).w        ; $0838 $0002 $C8AB
        DC.W    $6602               ; $009FEA BNE.S  loc_009FEE
        moveq   #$09,d0                 ; $7009
loc_009FEE:
        move.b  d0,$00FF6980            ; $13C0 $00FF $6980
        cmpi.w  #$003C,($FFFFC8AA).w    ; $0C78 $003C $C8AA
        DC.W    $6D38               ; $009FFA BLT.S  loc_00A034
loc_009FFC:
        addq.w  #4,($FFFFC8AC).w        ; $5878 $C8AC
        lea     $00FF66DC,a1            ; $43F9 $00FF $66DC
        clr.w    (a1)                   ; $4251
        clr.w    $0014(a1)              ; $4269 $0014
        clr.w    $0028(a1)              ; $4269 $0028
        clr.w    $003C(a1)              ; $4269 $003C
        move.w  #$FFFF,($FFFFC026).w    ; $31FC $FFFF $C026
        clr.b    $00FF6980              ; $4239 $00FF $6980
        DC.W    $602C               ; $00A020 BRA.S  loc_00A04E
loc_00A022:
        moveq   #$00,d0                 ; $7000
        btst    #2,($FFFFC8AB).w        ; $0838 $0002 $C8AB
        DC.W    $6702               ; $00A02A BEQ.S  loc_00A02E
        moveq   #$01,d0                 ; $7001
loc_00A02E:
        move.b  d0,$00FF6990            ; $13C0 $00FF $6990
loc_00A034:
        move.w  ($FFFF90B0).w,d0        ; $3038 $90B0
        addq.w  #1,($FFFF90B0).w        ; $5278 $90B0
        mulu.w  #$3BBB,d0               ; $C0FC $3BBB
        DC.W    $4840               ; $00A040 SWAP    D0
        cmpi.w  #$001B,d0               ; $0C40 $001B
        DC.W    $6F02               ; $00A046 BLE.S  loc_00A04A
        moveq   #$1B,d0                 ; $701B
loc_00A04A:
        move.w  d0,($FFFFC026).w        ; $31C0 $C026
loc_00A04E:
        rts                             ; $4E75
        lea     $00898824,a1            ; $43F9 $0089 $8824
        move.l  (a1)+,($FFFFC278).w     ; $21D9 $C278
        move.w  (a1)+,($FFFFC0E6).w     ; $31D9 $C0E6
        move.w  (a1)+,($FFFFC0E8).w     ; $31D9 $C0E8
        move.w  (a1)+,($FFFFC0EA).w     ; $31D9 $C0EA
        move.w  (a1)+,($FFFFC0EC).w     ; $31D9 $C0EC
        move.w  (a1)+,($FFFFC0EE).w     ; $31D9 $C0EE
        move.w  (a1)+,($FFFFC0F0).w     ; $31D9 $C0F0
        move.w  (a1)+,($FFFFC0F2).w     ; $31D9 $C0F2
        move.w  (a1)+,($FFFFC0F4).w     ; $31D9 $C0F4
        move.w  (a1)+,($FFFFC0F6).w     ; $31D9 $C0F6
        move.w  (a1)+,($FFFFC8CE).w     ; $31D9 $C8CE
        move.w  (a1)+,($FFFFC8D0).w     ; $31D9 $C8D0
        move.w  (a1)+,($FFFFC8D2).w     ; $31D9 $C8D2
        move.w  (a1)+,($FFFFC0F8).w     ; $31D9 $C0F8
        move.w  (a1)+,($FFFFC0FA).w     ; $31D9 $C0FA
        move.l  #$0093925E,($FFFFC27C).w; $21FC $0093 $925E $C27C
        move.w  ($FFFFC8A0).w,d1        ; $3238 $C8A0
        add.w   d1,d1                   ; $D241
        move.w  ($FFFFC8C8).w,d0        ; $3038 $C8C8
        DC.W    $C1FC,$0030         ; $00A0A4 MULS    #$0030,D0
        add.w   d0,d1                   ; $D240
        DC.W    $43FB,$1008         ; $00A0AA LEA     $08(PC,D1.W),A1
        move.l  a1,($FFFFC280).w        ; $21C9 $C280
        rts                             ; $4E75
        ori.w  #$0088,(a0)              ; $0050 $0088
        ori.l  #$00980040,(a0)          ; $0090 $0098 $0040
        ori.w  #$0080,(112,a0,d0.w)     ; $0070 $0080 $0070
        ori.w  #$0058,(a0)              ; $0050 $0058
        ori.l  #$00980080,(a0)          ; $0090 $0098 $0080
        ori.l  #$00C000C0,d0            ; $0080 $00C0 $00C0
        ori.w  #$0068,(a0)              ; $0050 $0068
        ori.l  #$00880050,d0            ; $0080 $0088 $0050
        ori.w  #$0080,$0088(a0)         ; $0068 $0080 $0088
        ori.w  #$0088,-(a0)             ; $0060 $0088
        ori.l  #$00980098,(a0)          ; $0090 $0098 $0098
        ori.l  #$00E000F0,-(a0)         ; $00A0 $00E0 $00F0
        ori.w  #$0088,(a0)              ; $0050 $0088
        ori.l  #$00980050,(a0)          ; $0090 $0098 $0050
        ori.w  #$0080,$0088(a0)         ; $0068 $0080 $0088
        ori.w  #$0068,(a0)              ; $0050 $0068
        ori.l  #$00880050,d0            ; $0080 $0088 $0050
        ori.w  #$0080,$0088(a0)         ; $0068 $0080 $0088
        ori.w  #$0088,-(a0)             ; $0060 $0088
        ori.l  #$009800B0,(a0)          ; $0090 $0098 $00B0
        ori.l  #$00C000C0,(80,a0,d0.w)  ; $00B0 $00C0 $00C0 $0050
        DC.W    $0088,$0090,$0098   ; $00A126 ORI.L  #$00900098,A0
        ori.w  #$0060,-(a0)             ; $0060 $0060
        ori.l  #$00C00050,-(a0)         ; $00A0 $00C0 $0050
        ori.w  #$0080,$0088(a0)         ; $0068 $0080 $0088
        ori.w  #$0068,(a0)              ; $0050 $0068
        ori.l  #$008843F9,d0            ; $0080 $0088 $43F9
        DC.W    $0089,$8818,$3038   ; $00A146 ORI.L  #$88183038,A1
        DC.W    $C8CC               ; $00A14C MULU    A4,D4
        movea.l (a1,d0.w),a1            ; $2271 $0000
        move.l  (a1)+,($FFFFC278).w     ; $21D9 $C278
        move.w  (a1)+,($FFFFC0E6).w     ; $31D9 $C0E6
        move.w  (a1)+,($FFFFC0E8).w     ; $31D9 $C0E8
        move.w  (a1)+,($FFFFC0EA).w     ; $31D9 $C0EA
        move.w  (a1)+,($FFFFC0EC).w     ; $31D9 $C0EC
        move.w  (a1)+,($FFFFC0EE).w     ; $31D9 $C0EE
        move.w  (a1)+,($FFFFC0F0).w     ; $31D9 $C0F0
        move.w  (a1)+,($FFFFC0F2).w     ; $31D9 $C0F2
        move.w  (a1)+,($FFFFC0F4).w     ; $31D9 $C0F4
        move.w  (a1)+,($FFFFC0F6).w     ; $31D9 $C0F6
        move.w  (a1)+,($FFFFC8CE).w     ; $31D9 $C8CE
        move.w  (a1)+,($FFFFC8D0).w     ; $31D9 $C8D0
        move.w  (a1)+,($FFFFC8D2).w     ; $31D9 $C8D2
        move.w  (a1)+,($FFFFC0F8).w     ; $31D9 $C0F8
        move.w  (a1)+,($FFFFC0FA).w     ; $31D9 $C0FA
        DC.W    $43FA,$003A         ; $00A18E LEA     $003A(PC),A1
        add.w   d0,d0                   ; $D040
        tst.b    ($FFFFC30F).w          ; $4A38 $C30F
        DC.W    $6702               ; $00A198 BEQ.S  loc_00A19C
        addq.w  #4,d0                   ; $5840
loc_00A19C:
        move.l  (a1,d0.w),($FFFFC27C).w ; $21F1 $0000 $C27C
        lea     ($FFFFFBF8).w,a1        ; $43F8 $FBF8
        move.w  ($FFFFC8C8).w,d1        ; $3238 $C8C8
        DC.W    $C3FC,$0090         ; $00A1AA MULS    #$0090,D1
        adda.w  d1,a1                   ; $D2C1
        move.w  ($FFFFC89C).w,d1        ; $3238 $C89C
        asl.w   #3,d1                   ; $E741
        adda.w  d1,a1                   ; $D2C1
        moveq   #$00,d1                 ; $7200
        move.b  ($FFFFFDA9).w,d1        ; $1238 $FDA9
        DC.W    $C3FC,$0030         ; $00A1BE MULS    #$0030,D1
        adda.w  d1,a1                   ; $D2C1
        move.l  a1,($FFFFC280).w        ; $21C9 $C280
        rts                             ; $4E75
        ori.l  #$925E0093,(a3)          ; $0093 $925E $0093
        DC.W    $957E               ; $00A1D0 SUB.W  D2,<EA:3E>
        ori.l  #$989E0093,(a3)          ; $0093 $989E $0093
        DC.W    $9BBE               ; $00A1D8 SUB.L  D5,<EA:3E>
        ori.l  #$989E0093,(a3)          ; $0093 $989E $0093
        DC.W    $9BBE               ; $00A1E0 SUB.L  D5,<EA:3E>
        move.w  (a0)+,(a5)              ; $3A98
        move.w  (a0)+,(a5)              ; $3A98
        move.w  (a0)+,(a5)              ; $3A98
        move.w  (a0)+,(a5)              ; $3A98
        move.w  (a0)+,(a5)              ; $3A98
        move.w  a0,-(a4)                ; $3908
        DC.W    $7D00               ; $00A1EE MOVE.W  D0,-(A6)
        ori.l  #$00C000CD,$00D5(a3)     ; $00AB $00C0 $00CD $00D5
        DC.W    $00DB               ; $00A1F8 DC.W    $00DB
        DC.W    $00E0               ; $00A1FA DC.W    $00E0
        move.w  ($FFFFC8CA).w,d0        ; $3038 $C8CA
