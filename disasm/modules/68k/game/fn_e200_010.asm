; ============================================================================
; Sh2 Comm Palette Load 010 (auto-analyzed)
; ROM Range: $00FB98-$010084 (1260 bytes)
; ============================================================================
; Category: sh2
; Purpose: Orchestrator calling 4 subroutines
;   Accesses 32X registers: adapter_ctrl
;   RAM: $C87A (vint_dispatch_state), $C0A2 (gfx_mode), $C87E (game_state)
;   Calls: sh2_graphics_cmd, sh2_load_data, sh2_palette_load, sh2_send_cmd_wait
;   Object (A0, A1): +$00, +$01, +$02 (flags/type), +$03, +$04 (speed_index/velocity), +$9C
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, D1, D2, D3, D4, D5, A0, A1
; RAM:
;   $C0A2: gfx_mode
;   $C87A: vint_dispatch_state
;   $C87E: game_state
; Calls:
;   $00E1BC: sh2_palette_load
;   $00E22C: sh2_graphics_cmd
;   $00E2F0: sh2_load_data
;   $00E316: sh2_send_cmd_wait
; Object fields:
;   +$00: [unknown]
;   +$01: [unknown]
;   +$02: flags/type
;   +$03: [unknown]
;   +$04: speed_index/velocity
;   +$9C: [unknown]
; Confidence: high
; ============================================================================

fn_e200_010:
        MOVE.W  #$002C,$00FF0008                ; $00FB98
        MOVE.W  #$002C,(-14214).W               ; $00FBA0
        BCLR    #6,(-14219).W                   ; $00FBA6
        MOVE.W  (-14220).W,(A5)                 ; $00FBAC
        MOVE.W  #$0083,$00A15100                ; $00FBB0
        ANDI.B  #$FC,$00A15181                  ; $00FBB8
        JSR     $008826C8                       ; $00FBC0
        MOVE.L  #$000A0907,D0                   ; $00FBC6
        JSR     $008814BE                       ; $00FBCC
        MOVE.B  #$01,(-14323).W                 ; $00FBD2
        MOVE.W  #$0000,(-24556).W               ; $00FBD8
        BTST    #4,(-14322).W                   ; $00FBDE
        BNE.W  .loc_01CC                        ; $00FBE4
        BTST    #5,(-14322).W                   ; $00FBE8
        BNE.W  .loc_01CC                        ; $00FBEE
        BTST    #7,(-600).W                     ; $00FBF2
        BNE.W  .loc_01CC                        ; $00FBF8
        MOVE.L  (-15776).W,D0                   ; $00FBFC
        CMPI.L  #$60000000,D0                   ; $00FC00
        BGE.W  .loc_0146                        ; $00FC06
        MOVE.B  #$00,(-24543).W                 ; $00FC0A
        MOVE.W  (-16222).W,D0                   ; $00FC10
        MOVE.W  (-16220).W,D1                   ; $00FC14
        CMP.W  D0,D1                            ; $00FC18
        BCS.W  .loc_008E                        ; $00FC1A
        MOVE.B  #$01,(-24543).W                 ; $00FC1E
        MOVE.W  D1,D0                           ; $00FC24
.loc_008E:
        MOVE.W  (-16218).W,D1                   ; $00FC26
        CMP.W  D0,D1                            ; $00FC2A
        BCS.W  .loc_00A0                        ; $00FC2C
        MOVE.B  #$02,(-24543).W                 ; $00FC30
        MOVE.W  D1,D0                           ; $00FC36
.loc_00A0:
        MOVE.W  (-16216).W,D1                   ; $00FC38
        CMP.W  D0,D1                            ; $00FC3C
        BCS.W  .loc_00B0                        ; $00FC3E
        MOVE.B  #$03,(-24543).W                 ; $00FC42
.loc_00B0:
        MOVEQ   #$00,D0                         ; $00FC48
        MOVEQ   #$00,D1                         ; $00FC4A
        MOVE.B  (-335).W,D0                     ; $00FC4C
        BEQ.S  .loc_00C6                        ; $00FC50
        SUBQ.W  #1,D0                           ; $00FC52
.loc_00BC:
        ADDI.L  #$000003C0,D1                   ; $00FC54
        DBRA    D0,.loc_00BC                    ; $00FC5A
.loc_00C6:
        LEA     (-4344).W,A0                    ; $00FC5E
        ADDA.L  D1,A0                           ; $00FC62
        MOVEQ   #$00,D0                         ; $00FC64
        MOVE.B  (-347).W,D0                     ; $00FC66
        DC.W    $D040                           ; $00FC6A
        DC.W    $D040                           ; $00FC6C
        DC.W    $D040                           ; $00FC6E
        DC.W    $D040                           ; $00FC70
        MOVE.W  D0,D1                           ; $00FC72
        DC.W    $D040                           ; $00FC74
        DC.W    $D040                           ; $00FC76
        DC.W    $D041                           ; $00FC78
        DC.W    $D040                           ; $00FC7A
        ADDA.L  D0,A0                           ; $00FC7C
        MOVE.L  (-15776).W,D0                   ; $00FC7E
        CMP.L  $009C(A0),D0                     ; $00FC82
        BHI.W  .loc_0146                        ; $00FC86
        MOVEQ   #$00,D1                         ; $00FC8A
        MOVE.W  #$0013,D2                       ; $00FC8C
        MOVE.B  (-24543).W,D5                   ; $00FC90
.loc_00FC:
        CMP.L  $04(A0,D1.W),D0                  ; $00FC94
        BCS.W  .loc_010E                        ; $00FC98
        ADDQ.W  #8,D1                           ; $00FC9C
        DBRA    D2,.loc_00FC                    ; $00FC9E
        BRA.W  .loc_0146                        ; $00FCA2
.loc_010E:
        MOVE.B  #$01,(-24556).W                 ; $00FCA6
        MOVE.W  #$0013,D3                       ; $00FCAC
        DC.W    $9642                           ; $00FCB0
        MOVE.W  D3,(-24542).W                   ; $00FCB2
        MOVE.L  A0,(-24552).W                   ; $00FCB6
        ANDI.L  #$0000FFFF,D1                   ; $00FCBA
        ADD.L  D1,(-24552).W                    ; $00FCC0
.loc_012C:
        MOVE.L  $00(A0,D1.W),D3                 ; $00FCC4
        MOVE.L  $04(A0,D1.W),D4                 ; $00FCC8
        MOVE.L  D5,$00(A0,D1.W)                 ; $00FCCC
        MOVE.L  D0,$04(A0,D1.W)                 ; $00FCD0
        MOVE.L  D4,D0                           ; $00FCD4
        MOVE.L  D3,D5                           ; $00FCD6
        ADDQ.W  #8,D1                           ; $00FCD8
        DBRA    D2,.loc_012C                    ; $00FCDA
.loc_0146:
        LEA     (-15872).W,A0                   ; $00FCDE
        MOVE.L  #$60000000,D0                   ; $00FCE2
        MOVE.W  #$0013,D3                       ; $00FCE8
.loc_0154:
        MOVE.L  (A0)+,D1                        ; $00FCEC
        BEQ.S  .loc_015E                        ; $00FCEE
        CMP.L  D1,D0                            ; $00FCF0
        BLE.S  .loc_015E                        ; $00FCF2
        MOVE.L  D1,D0                           ; $00FCF4
.loc_015E:
        ADDI.L  #$00000D80,D2                   ; $00FCF6
        DBRA    D3,.loc_0154                    ; $00FCFC
        MOVE.L  D0,D2                           ; $00FD00
        LEA     (-1464).W,A0                    ; $00FD02
        MOVEQ   #$00,D0                         ; $00FD06
        MOVE.B  (-335).W,D0                     ; $00FD08
        DC.W    $D040                           ; $00FD0C
        DC.W    $D040                           ; $00FD0E
        DC.W    $D040                           ; $00FD10
        MOVE.W  D0,D1                           ; $00FD12
        DC.W    $D040                           ; $00FD14
        DC.W    $D041                           ; $00FD16
        DC.W    $D040                           ; $00FD18
        ADDA.L  D0,A0                           ; $00FD1A
        MOVEQ   #$00,D0                         ; $00FD1C
        MOVE.B  (-347).W,D0                     ; $00FD1E
        DC.W    $D040                           ; $00FD22
        DC.W    $D040                           ; $00FD24
        DC.W    $D040                           ; $00FD26
        ADDQ.W  #4,D0                           ; $00FD28
        CMP.L  $00(A0,D0.W),D2                  ; $00FD2A
        BHI.W  .loc_01B4                        ; $00FD2E
        ADDQ.B  #2,(-24556).W                   ; $00FD32
        MOVE.L  A0,(-24548).W                   ; $00FD36
        ANDI.L  #$0000FFFF,D0                   ; $00FD3A
        ADD.L  D0,(-24548).W                    ; $00FD40
        SUBQ.L  #4,(-24548).W                   ; $00FD44
        MOVE.L  D2,$00(A0,D0.W)                 ; $00FD48
.loc_01B4:
        MOVE.L  (-15776).W,(-24526).W           ; $00FD4C
        MOVE.L  (-15776).W,D0                   ; $00FD52
        CMPI.L  #$60000000,D0                   ; $00FD56
        BGE.W  .loc_01CC                        ; $00FD5C
        BRA.W  .loc_026C                        ; $00FD60
.loc_01CC:
        LEA     (-15872).W,A0                   ; $00FD64
        MOVE.W  #$0013,D0                       ; $00FD68
.loc_01D4:
        TST.L  (A0)                             ; $00FD6C
        BEQ.W  .loc_01E0                        ; $00FD6E
        ADDQ.L  #4,A0                           ; $00FD72
        DBRA    D0,.loc_01D4                    ; $00FD74
.loc_01E0:
        CLR.L  (-24526).W                       ; $00FD78
        LEA     (-24526).W,A0                   ; $00FD7C
        LEA     (-15872).W,A1                   ; $00FD80
        MOVE.W  #$0013,D2                       ; $00FD84
.loc_01F0:
        ADDI.B  #$00,D0                         ; $00FD88
        MOVE.B  $0003(A0),D0                    ; $00FD8C
        MOVE.B  $0003(A1),D1                    ; $00FD90
        DC.W    $C101                           ; $00FD94
        MOVE.B  D0,$0003(A0)                    ; $00FD96
        MOVE.B  $0002(A0),D0                    ; $00FD9A
        MOVE.B  $0002(A1),D1                    ; $00FD9E
        DC.W    $C101                           ; $00FDA2
        MOVE.B  D0,D1                           ; $00FDA4
        ANDI.B  #$0F,D0                         ; $00FDA6
        MOVE.B  D0,$0002(A0)                    ; $00FDAA
        LSR.B  #4,D1                            ; $00FDAE
        ADDI.B  #$00,D0                         ; $00FDB0
        MOVE.B  $0001(A0),D0                    ; $00FDB4
        DC.W    $C101                           ; $00FDB8
        MOVE.B  $0001(A1),D1                    ; $00FDBA
        DC.W    $C101                           ; $00FDBE
        BCC.W  .loc_023C                        ; $00FDC0
        ADDI.B  #$00,D0                         ; $00FDC4
        MOVE.B  #$40,D1                         ; $00FDC8
        DC.W    $C101                           ; $00FDCC
        MOVE.B  #$01,D1                         ; $00FDCE
        BRA.S  .loc_0254                        ; $00FDD2
.loc_023C:
        CLR.B  D1                               ; $00FDD4
        CMPI.B  #$60,D0                         ; $00FDD6
        BCS.W  .loc_0254                        ; $00FDDA
        ADDI.B  #$00,D0                         ; $00FDDE
        MOVE.B  #$60,D1                         ; $00FDE2
        DC.W    $8101                           ; $00FDE6
        MOVE.B  #$01,D1                         ; $00FDE8
.loc_0254:
        MOVE.B  D0,$0001(A0)                    ; $00FDEC
        ADDI.B  #$00,D0                         ; $00FDF0
        MOVE.B  (A0),D0                         ; $00FDF4
        DC.W    $C101                           ; $00FDF6
        MOVE.B  (A1),D1                         ; $00FDF8
        DC.W    $C101                           ; $00FDFA
        MOVE.B  D0,(A0)                         ; $00FDFC
        ADDQ.L  #4,A1                           ; $00FDFE
        DBRA    D2,.loc_01F0                    ; $00FE00
.loc_026C:
        TST.B  (-24556).W                       ; $00FE04
        BNE.W  .loc_0296                        ; $00FE08
        MOVE.W  #$0000,(-14210).W               ; $00FE0C
        MOVE.W  #$0020,$00FF0008                ; $00FE12
        MOVE.L  #$008909AE,$00FF0002            ; $00FE1A
        CLR.B  $00A15123                        ; $00FE24
        BRA.W  .loc_04EA                        ; $00FE2A
.loc_0296:
        MOVEQ   #$00,D0                         ; $00FE2E
        LEA     (-31616).W,A0                   ; $00FE30
        MOVEQ   #$1F,D1                         ; $00FE34
.loc_029E:
        MOVE.L  D0,(A0)+                        ; $00FE36
        DBRA    D1,.loc_029E                    ; $00FE38
        LEA     $00FF7B80,A0                    ; $00FE3C
        MOVEQ   #$7F,D1                         ; $00FE42
.loc_02AC:
        MOVE.L  D0,(A0)+                        ; $00FE44
        DBRA    D1,.loc_02AC                    ; $00FE46
        MOVE.L  #$60000002,(A5)                 ; $00FE4A
        MOVE.W  #$17FF,D1                       ; $00FE50
.loc_02BC:
        MOVE.L  D0,(A6)                         ; $00FE54
        DBRA    D1,.loc_02BC                    ; $00FE56
        JSR     $008849AA                       ; $00FE5A
        CLR.W  (-14208).W                       ; $00FE60
        CLR.W  (-14206).W                       ; $00FE64
        CLR.W  (-32768).W                       ; $00FE68
        CLR.W  (-32766).W                       ; $00FE6C
        CLR.W  (-24558).W                       ; $00FE70
        JSR     $008849AA                       ; $00FE74
        MOVE.L  #$008BB4FC,(-13972).W           ; $00FE7A
        MOVE.B  #$01,(-14327).W                 ; $00FE82
        MOVE.B  #$01,(-14326).W                 ; $00FE88
        BSET    #6,(-14322).W                   ; $00FE8E
        MOVE.B  #$01,(-14334).W                 ; $00FE94
        MOVE.W  #$0001,(-24522).W               ; $00FE9A
        LEA     $00FF1000,A0                    ; $00FEA0
        MOVE.W  #$037F,D0                       ; $00FEA6
.loc_0312:
        CLR.L  (A0)+                            ; $00FEAA
        DBRA    D0,.loc_0312                    ; $00FEAC
        MOVE.W  #$0001,D0                       ; $00FEB0
        MOVE.W  #$0001,D1                       ; $00FEB4
        MOVE.W  #$0001,D2                       ; $00FEB8
        MOVE.W  #$0026,D3                       ; $00FEBC
        MOVE.W  #$001A,D4                       ; $00FEC0
        LEA     $00FF1000,A0                    ; $00FEC4
        DC.W    $4EBA,$E360         ; JSR     $00E22C(PC); $00FECA
        LEA     $00FF1000,A0                    ; $00FECE
        DC.W    $4EBA,$E41A         ; JSR     $00E2F0(PC); $00FED4
        DC.W    $4EBA,$E2E2         ; JSR     $00E1BC(PC); $00FED8
        BCLR    #7,$00A15181                    ; $00FEDC
        LEA     $00FF6E00,A0                    ; $00FEE4
        ADDA.L  #$00000160,A0                   ; $00FEEA
        LEA     $008900A8,A1                    ; $00FEF0
        MOVE.W  #$003F,D0                       ; $00FEF6
.loc_0362:
        MOVE.W  (A1)+,D1                        ; $00FEFA
        BSET    #15,D1                          ; $00FEFC
        MOVE.W  D1,(A0)+                        ; $00FF00
        DBRA    D0,.loc_0362                    ; $00FF02
        LEA     $000F3D80,A0                    ; $00FF06
        MOVEA.L #$06014000,A1                   ; $00FF0C
        DC.W    $4EBA,$E402         ; JSR     $00E316(PC); $00FF12
        LEA     $000ECC90,A0                    ; $00FF16
        MOVEA.L #$06019000,A1                   ; $00FF1C
        DC.W    $4EBA,$E3F2         ; JSR     $00E316(PC); $00FF22
        MOVEQ   #$00,D0                         ; $00FF26
        MOVE.B  (-335).W,D0                     ; $00FF28
        DC.W    $D080                           ; $00FF2C
        DC.W    $D080                           ; $00FF2E
        LEA     $00890084,A0                    ; $00FF30
        MOVEA.L $00(A0,D0.W),A0                 ; $00FF36
        MOVEA.L #$06019700,A1                   ; $00FF3A
        DC.W    $4EBA,$E3D4         ; JSR     $00E316(PC); $00FF40
        MOVEQ   #$00,D0                         ; $00FF44
        MOVE.B  (-347).W,D0                     ; $00FF46
        DC.W    $D080                           ; $00FF4A
        DC.W    $D080                           ; $00FF4C
        LEA     $00890090,A0                    ; $00FF4E
        MOVEA.L $00(A0,D0.W),A0                 ; $00FF54
        MOVEA.L #$06019C80,A1                   ; $00FF58
        DC.W    $4EBA,$E3B6         ; JSR     $00E316(PC); $00FF5E
        LEA     $000F4620,A0                    ; $00FF62
        MOVEA.L #$0601A200,A1                   ; $00FF68
        DC.W    $4EBA,$E3A6         ; JSR     $00E316(PC); $00FF6E
        LEA     $000EBB40,A0                    ; $00FF72
        MOVEA.L #$06020000,A1                   ; $00FF78
        DC.W    $4EBA,$E396         ; JSR     $00E316(PC); $00FF7E
        LEA     $000EB980,A0                    ; $00FF82
        MOVEA.L #$06023200,A1                   ; $00FF88
        DC.W    $4EBA,$E386         ; JSR     $00E316(PC); $00FF8E
        LEA     $000F4E40,A0                    ; $00FF92
        MOVEA.L #$06024000,A1                   ; $00FF98
        DC.W    $4EBA,$E376         ; JSR     $00E316(PC); $00FF9E
        MOVE.B  #$00,(-24544).W                 ; $00FFA2
        MOVE.W  #$0041,(-24540).W               ; $00FFA8
        MOVE.W  #$0000,(-24538).W               ; $00FFAE
        MOVE.W  #$0000,(-24536).W               ; $00FFB4
        MOVE.B  #$FF,(-24534).W                 ; $00FFBA
        MOVE.B  #$00,(-24533).W                 ; $00FFC0
        MOVE.B  #$01,(-24532).W                 ; $00FFC6
        MOVE.B  #$00,(-24531).W                 ; $00FFCC
        MOVE.W  #$000E,(-24530).W               ; $00FFD2
        MOVE.W  #$004A,(-24528).W               ; $00FFD8
        BTST    #0,(-24556).W                   ; $00FFDE
        BEQ.W  .loc_0466                        ; $00FFE4
        MOVEA.L (-24552).W,A0                   ; $00FFE8
        MOVE.B  #$20,$0000(A0)                  ; $00FFEC
        MOVE.B  #$20,$0001(A0)                  ; $00FFF2
        MOVE.B  #$20,$0002(A0)                  ; $00FFF8
.loc_0466:
        BTST    #1,(-24556).W                   ; $00FFFE
        BEQ.W  .loc_0486                        ; $010004
        MOVEA.L (-24548).W,A0                   ; $010008
        MOVE.B  #$20,$0000(A0)                  ; $01000C
        MOVE.B  #$20,$0001(A0)                  ; $010012
        MOVE.B  #$20,$0002(A0)                  ; $010018
.loc_0486:
        MOVE.B  #$01,(-14303).W                 ; $01001E
        JSR     $0088204A                       ; $010024
        ANDI.B  #$FC,$00A15181                  ; $01002A
        ORI.B  #$01,$00A15181                   ; $010032
        MOVE.W  #$8083,$00A15100                ; $01003A
        BSET    #6,(-14219).W                   ; $010042
        MOVE.W  (-14220).W,(A5)                 ; $010048
        MOVE.W  #$0018,$00FF0008                ; $01004C
        JSR     $00884998                       ; $010054
        MOVE.B  #$92,(-14171).W                 ; $01005A
        MOVE.W  #$0000,(-14210).W               ; $010060
        MOVE.L  #$00890128,$00FF0002            ; $010066
        BTST    #0,(-24556).W                   ; $010070
        BNE.S  .loc_04EA                        ; $010076
        MOVE.L  #$00890148,$00FF0002            ; $010078
.loc_04EA:
        RTS                                     ; $010082
