; ============================================================================
; Sh2 Comm Palette Load 022 (auto-analyzed)
; ROM Range: $0126D2-$0129E0 (782 bytes)
; ============================================================================
; Category: sh2
; Purpose: Orchestrator calling 5 subroutines
;   Accesses 32X registers: adapter_ctrl, COMM0, COMM1
;   RAM: $C87A (vint_dispatch_state), $C87E (game_state)
;   Calls: sh2_graphics_cmd, sh2_load_data, sh2_palette_load, sh2_send_cmd_wait
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

fn_12200_022:
        MOVE.W  #$002C,$00FF0008                ; $0126D2
        MOVE.W  #$002C,(-14214).W               ; $0126DA
        BCLR    #6,(-14219).W                   ; $0126E0
        MOVE.W  (-14220).W,(A5)                 ; $0126E6
        MOVE.W  #$0083,$00A15100                ; $0126EA
        ANDI.B  #$FC,$00A15181                  ; $0126F2
        JSR     $008826C8                       ; $0126FA
        MOVE.L  #$000A0907,D0                   ; $012700
        JSR     $008814BE                       ; $012706
        MOVE.B  #$01,(-14323).W                 ; $01270C
        LEA     $00FF2000,A0                    ; $012712
        CLR.L  (A0)+                            ; $012718
        CLR.L  (A0)+                            ; $01271A
        CLR.L  (A0)+                            ; $01271C
        CLR.L  (A0)+                            ; $01271E
        CLR.L  (A0)+                            ; $012720
        CLR.L  (A0)+                            ; $012722
        CLR.L  (A0)+                            ; $012724
        CLR.L  (A0)+                            ; $012726
        CLR.L  (A0)+                            ; $012728
        CLR.L  (A0)+                            ; $01272A
        CLR.L  (A0)+                            ; $01272C
        CLR.L  (A0)+                            ; $01272E
        CLR.L  (A0)+                            ; $012730
        MOVEQ   #$00,D0                         ; $012732
        LEA     (-31616).W,A0                   ; $012734
        MOVEQ   #$1F,D1                         ; $012738
.loc_0068:
        MOVE.L  D0,(A0)+                        ; $01273A
        DBRA    D1,.loc_0068                    ; $01273C
        LEA     $00FF7B80,A0                    ; $012740
        MOVEQ   #$7F,D1                         ; $012746
.loc_0076:
        MOVE.L  D0,(A0)+                        ; $012748
        DBRA    D1,.loc_0076                    ; $01274A
        MOVE.L  #$60000002,(A5)                 ; $01274E
        MOVE.W  #$17FF,D1                       ; $012754
.loc_0086:
        MOVE.L  D0,(A6)                         ; $012758
        DBRA    D1,.loc_0086                    ; $01275A
        JSR     $008849AA                       ; $01275E
        CLR.W  (-14208).W                       ; $012764
        CLR.W  (-14206).W                       ; $012768
        CLR.W  (-32768).W                       ; $01276C
        MOVE.W  #$FFFC,(-32766).W               ; $012770
        CLR.W  (-24558).W                       ; $012776
        CLR.B  (-24552).W                       ; $01277A
        MOVE.L  #$00000014,(-24544).W           ; $01277E
        CLR.L  (-24540).W                       ; $012786
        CLR.W  (-24536).W                       ; $01278A
        BTST    #7,(-600).W                     ; $01278E
        BEQ.S  .loc_00DA                        ; $012794
        CMPI.B  #$05,(-14313).W                 ; $012796
        BNE.S  .loc_00DA                        ; $01279C
        MOVE.L  #$FFFFFFFC,(-24540).W           ; $01279E
        MOVE.W  #$0037,(-24536).W               ; $0127A6
.loc_00DA:
        JSR     $008849AA                       ; $0127AC
        MOVE.W  #$0001,(-24518).W               ; $0127B2
        MOVE.L  #$008BB4FC,(-13972).W           ; $0127B8
        MOVE.B  #$01,(-14327).W                 ; $0127C0
        MOVE.B  #$01,(-14326).W                 ; $0127C6
        BSET    #6,(-14322).W                   ; $0127CC
        MOVE.B  #$01,(-14334).W                 ; $0127D2
        LEA     $00FF1000,A0                    ; $0127D8
        MOVE.W  #$037F,D0                       ; $0127DE
.loc_0110:
        CLR.L  (A0)+                            ; $0127E2
        DBRA    D0,.loc_0110                    ; $0127E4
        MOVE.W  #$0001,D0                       ; $0127E8
        MOVE.W  #$0001,D1                       ; $0127EC
        MOVE.W  #$0001,D2                       ; $0127F0
        MOVE.W  #$0026,D3                       ; $0127F4
        MOVE.W  #$001A,D4                       ; $0127F8
        LEA     $00FF1000,A0                    ; $0127FC
        DC.W    $4EBA,$BA28         ; JSR     $00E22C(PC); $012802
        LEA     $00FF1000,A0                    ; $012806
        DC.W    $4EBA,$BAE2         ; JSR     $00E2F0(PC); $01280C
        DC.W    $4EBA,$B9AA         ; JSR     $00E1BC(PC); $012810
        MOVE.L  #$0000D006,D0                   ; $012814
        MOVE.W  #$0022,D1                       ; $01281A
        MOVE.W  #$0008,D2                       ; $01281E
        MOVE.W  #$0000,D3                       ; $012822
        DC.W    $6100,$0798         ; BSR.W  $012FC0; $012826
        BCLR    #7,$00A15181                    ; $01282A
        LEA     $00FF6E00,A0                    ; $012832
        ADDA.L  #$00000120,A0                   ; $012838
        LEA     $008929E0,A1                    ; $01283E
        MOVE.W  #$000F,D0                       ; $012844
.loc_0176:
        MOVE.W  (A1)+,D1                        ; $012848
        MOVE.W  D1,(A0)+                        ; $01284A
        DBRA    D0,.loc_0176                    ; $01284C
        LEA     $00FF6E00,A0                    ; $012850
        ADDA.L  #$000001A0,A0                   ; $012856
        LEA     $00892A00,A1                    ; $01285C
        MOVE.W  #$001F,D0                       ; $012862
.loc_0194:
        MOVE.W  (A1)+,D1                        ; $012866
        MOVE.W  D1,(A0)+                        ; $012868
        DBRA    D0,.loc_0194                    ; $01286A
        LEA     $000EA840,A0                    ; $01286E
        MOVEA.L #$06038000,A1                   ; $012874
        DC.W    $4EBA,$BA9A         ; JSR     $00E316(PC); $01287A
        BTST    #3,(-14312).W                   ; $01287E
        BNE.S  .loc_01BC                        ; $012884
        TST.B  (-14309).W                       ; $012886
        BNE.S  .loc_01E0                        ; $01288A
        BRA.S  .loc_021E                        ; $01288C
.loc_01BC:
        MOVEA.L #$06038000,A0                   ; $01288E
        ADDA.L  #$00000070,A0                   ; $012894
        MOVE.W  #$0037,D0                       ; $01289A
        MOVE.W  #$0048,D1                       ; $01289E
        MOVE.W  #$FFC0,D2                       ; $0128A2
        MOVE.W  #$0150,D3                       ; $0128A6
        JSR     $0088E406                       ; $0128AA
        BRA.S  .loc_021E                        ; $0128B0
.loc_01E0:
        MOVEA.L #$06038000,A0                   ; $0128B2
        MOVE.W  #$006F,D0                       ; $0128B8
        MOVE.W  #$0048,D1                       ; $0128BC
        MOVE.W  #$FFC0,D2                       ; $0128C0
        MOVE.W  #$0150,D3                       ; $0128C4
        JSR     $0088E406                       ; $0128C8
        MOVEA.L #$06038000,A0                   ; $0128CE
        ADDA.L  #$000000A8,A0                   ; $0128D4
        MOVE.W  #$0037,D0                       ; $0128DA
        MOVE.W  #$0048,D1                       ; $0128DE
        MOVE.W  #$FFC0,D2                       ; $0128E2
        MOVE.W  #$0150,D3                       ; $0128E6
        JSR     $0088E406                       ; $0128EA
.loc_021E:
        LEA     $000EB790,A0                    ; $0128F0
        MOVEA.L #$0603DE80,A1                   ; $0128F6
        DC.W    $4EBA,$BA18         ; JSR     $00E316(PC); $0128FC
        MOVE.B  (-14313).W,(-24551).W           ; $012900
        MOVE.W  #$0010,(-24532).W               ; $012906
        MOVE.W  #$0020,(-24530).W               ; $01290C
        MOVE.W  #$00A0,(-24528).W               ; $012912
        MOVE.W  #$0380,(-24526).W               ; $012918
        MOVE.W  #$0000,(-24524).W               ; $01291E
        MOVE.W  #$0013,(-24522).W               ; $012924
        TST.B  (-14309).W                       ; $01292A
        BEQ.W  .loc_0276                        ; $01292E
        CMPI.B  #$02,(-24551).W                 ; $012932
        BEQ.S  .loc_0276                        ; $012938
        CMPI.B  #$04,(-24551).W                 ; $01293A
        BEQ.S  .loc_0276                        ; $012940
        MOVE.B  #$02,(-24551).W                 ; $012942
.loc_0276:
        JSR     $0088204A                       ; $012948
        ANDI.B  #$FC,$00A15181                  ; $01294E
        ORI.B  #$01,$00A15181                   ; $012956
        MOVE.W  #$8083,$00A15100                ; $01295E
        BSET    #6,(-14219).W                   ; $012966
        MOVE.W  (-14220).W,(A5)                 ; $01296C
        MOVE.W  #$0020,$00FF0008                ; $012970
        JSR     $00884998                       ; $012978
        MOVE.W  #$0000,(-14210).W               ; $01297E
        MOVE.L  #$00892A40,$00FF0002            ; $012984
        BCLR    #0,(-14325).W                   ; $01298E
        MOVE.B  #$81,(-14171).W                 ; $012994
        LEA     $00FF6100,A0                    ; $01299A
        MOVE.W  #$007F,D0                       ; $0129A0
.loc_02D2:
        CLR.L  (A0)+                            ; $0129A4
        CLR.L  (A0)+                            ; $0129A6
        CLR.L  (A0)+                            ; $0129A8
        CLR.L  (A0)+                            ; $0129AA
        CLR.L  (A0)+                            ; $0129AC
        DBRA    D0,.loc_02D2                    ; $0129AE
.loc_02E0:
        TST.B  $00A15120                        ; $0129B2
        BNE.S  .loc_02E0                        ; $0129B8
        CLR.B  $00A15122                        ; $0129BA
        CLR.B  $00A15123                        ; $0129C0
        MOVE.B  #$03,$00A15121                  ; $0129C6
        MOVE.B  #$01,$00A15120                  ; $0129CE
.loc_0304:
        TST.B  $00A15120                        ; $0129D6
        BNE.S  .loc_0304                        ; $0129DC
        RTS                                     ; $0129DE
