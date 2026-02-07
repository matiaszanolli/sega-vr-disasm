; ============================================================================
; Sh2 Comm Palette Load 023 (auto-analyzed)
; ROM Range: $00D482-$00D7B2 (816 bytes)
; ============================================================================
; Category: sh2
; Purpose: Orchestrator calling 4 subroutines
;   Accesses 32X registers: adapter_ctrl, COMM0, COMM1
;   RAM: $C87A (vint_dispatch_state), $C87E (game_state)
;   Calls: sh2_palette_load, sh2_send_cmd_wait, sh2_graphics_cmd, sh2_load_data
;
; Uses: D0, D1, D2, D3, D4, A0, A1, A5
; RAM:
;   $C87A: vint_dispatch_state
;   $C87E: game_state
; Calls:
;   $00E1BC: sh2_palette_load
;   $00E22C: sh2_graphics_cmd
;   $00E2F0: sh2_load_data
;   $00E316: sh2_send_cmd_wait
; Confidence: high
; ============================================================================

fn_c200_023:
        DC.W    $0088                           ; $00D482
        DC.W    $0088                           ; $00D484
        DC.W    $00DC                           ; $00D486
        DC.W    $0130                           ; $00D488
        CLR.B  (-24540).W                       ; $00D48A
        MOVE.B  (-347).W,(-24551).W             ; $00D48E
        BTST    #7,(-600).W                     ; $00D494
        BEQ.S  .loc_0048                        ; $00D49A
        MOVE.B  (-346).W,(-24551).W             ; $00D49C
        BRA.S  .loc_0048                        ; $00D4A2
        MOVE.B  #$01,(-24540).W                 ; $00D4A4
        MOVE.B  (-345).W,(-24551).W             ; $00D4AA
        MOVE.B  (-344).W,(-24538).W             ; $00D4B0
        BRA.S  .loc_0048                        ; $00D4B6
        MOVE.B  (-341).W,(-24551).W             ; $00D4B8
        MOVE.B  (-340).W,(-24538).W             ; $00D4BE
        MOVE.B  #$02,(-24540).W                 ; $00D4C4
.loc_0048:
        MOVE.W  #$002C,$00FF0008                ; $00D4CA
        MOVE.W  #$002C,(-14214).W               ; $00D4D2
        BCLR    #6,(-14219).W                   ; $00D4D8
        MOVE.W  (-14220).W,(A5)                 ; $00D4DE
        MOVE.W  #$0083,$00A15100                ; $00D4E2
        ANDI.B  #$FC,$00A15181                  ; $00D4EA
        JSR     $008826C8                       ; $00D4F2
        MOVE.L  #$000A0907,D0                   ; $00D4F8
        JSR     $008814BE                       ; $00D4FE
        MOVE.B  #$01,(-14323).W                 ; $00D504
        LEA     $0088D832,A0                    ; $00D50A
        LEA     $00FF2000,A1                    ; $00D510
        MOVE.W  #$0004,D0                       ; $00D516
.loc_0098:
        MOVE.W  (A0)+,(A1)+                     ; $00D51A
        MOVE.W  (A0)+,(A1)+                     ; $00D51C
        MOVE.W  (A0)+,(A1)+                     ; $00D51E
        MOVE.W  (A0)+,(A1)+                     ; $00D520
        MOVE.W  (A0)+,(A1)+                     ; $00D522
        DBRA    D0,.loc_0098                    ; $00D524
        MOVEQ   #$00,D0                         ; $00D528
        LEA     (-31616).W,A0                   ; $00D52A
        MOVEQ   #$1F,D1                         ; $00D52E
.loc_00AE:
        MOVE.L  D0,(A0)+                        ; $00D530
        DBRA    D1,.loc_00AE                    ; $00D532
        LEA     $00FF7B80,A0                    ; $00D536
        MOVEQ   #$7F,D1                         ; $00D53C
.loc_00BC:
        MOVE.L  D0,(A0)+                        ; $00D53E
        DBRA    D1,.loc_00BC                    ; $00D540
        MOVE.L  #$60000002,(A5)                 ; $00D544
        MOVE.W  #$17FF,D1                       ; $00D54A
.loc_00CC:
        MOVE.L  D0,(A6)                         ; $00D54E
        DBRA    D1,.loc_00CC                    ; $00D550
        JSR     $008849AA                       ; $00D554
        CLR.W  (-14208).W                       ; $00D55A
        CLR.W  (-14206).W                       ; $00D55E
        CLR.W  (-32768).W                       ; $00D562
        CLR.W  (-32766).W                       ; $00D566
        CLR.W  (-24558).W                       ; $00D56A
        CLR.B  (-24552).W                       ; $00D56E
        JSR     $008849AA                       ; $00D572
        MOVE.L  #$008BB4FC,(-13972).W           ; $00D578
        MOVE.B  #$01,(-14327).W                 ; $00D580
        MOVE.B  #$01,(-14326).W                 ; $00D586
        BSET    #6,(-14322).W                   ; $00D58C
        MOVE.B  #$01,(-14334).W                 ; $00D592
        MOVE.W  #$0001,(-24532).W               ; $00D598
        LEA     $00FF1000,A0                    ; $00D59E
        MOVE.W  #$037F,D0                       ; $00D5A4
.loc_0126:
        CLR.L  (A0)+                            ; $00D5A8
        DBRA    D0,.loc_0126                    ; $00D5AA
        DC.W    $4EBA,$0C0C         ; JSR     $00E1BC(PC); $00D5AE
        BCLR    #7,$00A15181                    ; $00D5B2
        LEA     $00FF6E00,A0                    ; $00D5BA
        ADDA.L  #$00000160,A0                   ; $00D5C0
        LEA     $0088D7B2,A1                    ; $00D5C6
        MOVE.W  #$003F,D0                       ; $00D5CC
.loc_014E:
        MOVE.W  (A1)+,D1                        ; $00D5D0
        BSET    #15,D1                          ; $00D5D2
        MOVE.W  D1,(A0)+                        ; $00D5D6
        DBRA    D0,.loc_014E                    ; $00D5D8
        LEA     $000E8000,A0                    ; $00D5DC
        MOVEA.L #$06037000,A1                   ; $00D5E2
        DC.W    $6100,$0D2C         ; BSR.W  $00E316; $00D5E8
        BTST    #7,(-600).W                     ; $00D5EC
        BEQ.S  .loc_018A                        ; $00D5F2
.loc_0172:
        TST.B  $00A15120                        ; $00D5F4
        BNE.S  .loc_0172                        ; $00D5FA
        MOVE.B  #$2E,$00A15121                  ; $00D5FC
        MOVE.B  #$01,$00A15120                  ; $00D604
.loc_018A:
        LEA     $000E8C00,A0                    ; $00D60C
        MOVEA.L #$0603D100,A1                   ; $00D612
        DC.W    $6100,$0CFC         ; BSR.W  $00E316; $00D618
        TST.B  (-24540).W                       ; $00D61C
        BNE.W  .loc_01EE                        ; $00D620
        LEA     $000E8A00,A0                    ; $00D624
        MOVEA.L #$0603B600,A1                   ; $00D62A
        DC.W    $6100,$0CE4         ; BSR.W  $00E316; $00D630
        LEA     $000EB980,A0                    ; $00D634
        MOVEA.L #$0603DA00,A1                   ; $00D63A
        DC.W    $6100,$0CD4         ; BSR.W  $00E316; $00D640
        MOVE.W  #$0001,D0                       ; $00D644
        MOVE.W  #$0001,D1                       ; $00D648
        MOVE.W  #$0001,D2                       ; $00D64C
        MOVE.W  #$0026,D3                       ; $00D650
        MOVE.W  #$001A,D4                       ; $00D654
        LEA     $00FF1000,A0                    ; $00D658
        DC.W    $4EBA,$0BCC         ; JSR     $00E22C(PC); $00D65E
        LEA     $00FF1000,A0                    ; $00D662
        DC.W    $4EBA,$0C86         ; JSR     $00E2F0(PC); $00D668
        BRA.W  .loc_0254                        ; $00D66C
.loc_01EE:
        LEA     $000E8E10,A0                    ; $00D670
        MOVEA.L #$0603B600,A1                   ; $00D676
        DC.W    $6100,$0C98         ; BSR.W  $00E316; $00D67C
        LEA     $000E8FB0,A0                    ; $00D680
        MOVEA.L #$0603DA00,A1                   ; $00D686
        DC.W    $6100,$0C88         ; BSR.W  $00E316; $00D68C
        MOVE.W  #$0001,D0                       ; $00D690
        MOVE.W  #$0001,D1                       ; $00D694
        MOVE.W  #$0001,D2                       ; $00D698
        MOVE.W  #$0026,D3                       ; $00D69C
        MOVE.W  #$0016,D4                       ; $00D6A0
        LEA     $00FF1000,A0                    ; $00D6A4
        DC.W    $4EBA,$0B80         ; JSR     $00E22C(PC); $00D6AA
        MOVE.W  #$0002,D0                       ; $00D6AE
        MOVE.W  #$0001,D1                       ; $00D6B2
        MOVE.W  #$0017,D2                       ; $00D6B6
        MOVE.W  #$0026,D3                       ; $00D6BA
        MOVE.W  #$0004,D4                       ; $00D6BE
        LEA     $00FF1000,A0                    ; $00D6C2
        DC.W    $4EBA,$0B62         ; JSR     $00E22C(PC); $00D6C8
        LEA     $00FF1000,A0                    ; $00D6CC
        DC.W    $4EBA,$0C1C         ; JSR     $00E2F0(PC); $00D6D2
.loc_0254:
        CLR.B  (-24537).W                       ; $00D6D6
        MOVEQ   #$00,D0                         ; $00D6DA
        MOVEQ   #$00,D1                         ; $00D6DC
        MOVE.B  (-335).W,D0                     ; $00D6DE
        BEQ.S  .loc_026E                        ; $00D6E2
        SUBQ.W  #1,D0                           ; $00D6E4
.loc_0264:
        ADDI.L  #$000003C0,D1                   ; $00D6E6
        DBRA    D0,.loc_0264                    ; $00D6EC
.loc_026E:
        ADDQ.L  #4,D1                           ; $00D6F0
        MOVE.L  D1,(-24536).W                   ; $00D6F2
        JSR     $0088204A                       ; $00D6F6
        ANDI.B  #$FC,$00A15181                  ; $00D6FC
        ORI.B  #$01,$00A15181                   ; $00D704
        MOVE.W  #$8083,$00A15100                ; $00D70C
        BSET    #6,(-14219).W                   ; $00D714
        MOVE.W  (-14220).W,(A5)                 ; $00D71A
        MOVE.W  #$0020,$00FF0008                ; $00D71E
        JSR     $00884998                       ; $00D726
        MOVE.W  #$0000,(-14210).W               ; $00D72C
        MOVE.L  #$0088D864,$00FF0002            ; $00D732
        TST.B  (-24540).W                       ; $00D73C
        BEQ.S  .loc_02CA                        ; $00D740
        MOVE.L  #$0088D888,$00FF0002            ; $00D742
.loc_02CA:
        MOVE.B  #$00,$00FF60D4                  ; $00D74C
        BTST    #7,(-600).W                     ; $00D754
        BEQ.W  .loc_02E4                        ; $00D75A
        MOVE.B  #$01,$00FF60D4                  ; $00D75E
.loc_02E4:
        LEA     $00FF6100,A0                    ; $00D766
        MOVE.W  #$007F,D0                       ; $00D76C
.loc_02EE:
        CLR.L  (A0)+                            ; $00D770
        CLR.L  (A0)+                            ; $00D772
        CLR.L  (A0)+                            ; $00D774
        CLR.L  (A0)+                            ; $00D776
        CLR.L  (A0)+                            ; $00D778
        DBRA    D0,.loc_02EE                    ; $00D77A
.loc_02FC:
        TST.B  $00A15120                        ; $00D77E
        BNE.S  .loc_02FC                        ; $00D784
        CLR.B  $00A15122                        ; $00D786
        CLR.B  $00A15123                        ; $00D78C
        MOVE.B  #$03,$00A15121                  ; $00D792
        MOVE.B  #$01,$00A15120                  ; $00D79A
.loc_0320:
        TST.B  $00A15120                        ; $00D7A2
        BNE.S  .loc_0320                        ; $00D7A8
        MOVE.B  #$81,(-14171).W                 ; $00D7AA
        RTS                                     ; $00D7B0
