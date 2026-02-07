; ============================================================================
; Sh2 Comm Palette Load 002 (auto-analyzed)
; ROM Range: $00E5CE-$00E88C (702 bytes)
; ============================================================================
; Category: sh2
; Purpose: Orchestrator calling 4 subroutines
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

fn_e200_002:
        CLR.B  (-24545).W                       ; $00E5CE
        MOVE.B  (-343).W,(-24547).W             ; $00E5D2
        MOVE.B  (-335).W,(-24551).W             ; $00E5D8
        BCLR    #7,(-600).W                     ; $00E5DE
        BRA.S  .loc_0048                        ; $00E5E4
        CLR.B  (-24545).W                       ; $00E5E6
        MOVE.B  (-343).W,(-24547).W             ; $00E5EA
        MOVE.B  (-335).W,(-24551).W             ; $00E5F0
        BSET    #7,(-600).W                     ; $00E5F6
        BRA.S  .loc_0048                        ; $00E5FC
        MOVE.B  #$01,(-24545).W                 ; $00E5FE
        MOVE.B  (-342).W,(-24547).W             ; $00E604
        BCLR    #7,(-600).W                     ; $00E60A
        MOVE.B  (-334).W,(-24551).W             ; $00E610
.loc_0048:
        MOVE.W  #$002C,$00FF0008                ; $00E616
        MOVE.W  #$002C,(-14214).W               ; $00E61E
        BCLR    #6,(-14219).W                   ; $00E624
        MOVE.W  (-14220).W,(A5)                 ; $00E62A
        MOVE.W  #$0083,$00A15100                ; $00E62E
        ANDI.B  #$FC,$00A15181                  ; $00E636
        JSR     $008826C8                       ; $00E63E
        MOVE.L  #$000A0907,D0                   ; $00E644
        JSR     $008814BE                       ; $00E64A
        MOVE.B  #$01,(-14323).W                 ; $00E650
        MOVEQ   #$00,D0                         ; $00E656
        LEA     (-31616).W,A0                   ; $00E658
        MOVEQ   #$1F,D1                         ; $00E65C
.loc_0090:
        MOVE.L  D0,(A0)+                        ; $00E65E
        DBRA    D1,.loc_0090                    ; $00E660
        LEA     $00FF7B80,A0                    ; $00E664
        MOVEQ   #$7F,D1                         ; $00E66A
.loc_009E:
        MOVE.L  D0,(A0)+                        ; $00E66C
        DBRA    D1,.loc_009E                    ; $00E66E
        MOVE.L  #$60000002,(A5)                 ; $00E672
        MOVE.W  #$17FF,D1                       ; $00E678
.loc_00AE:
        MOVE.L  D0,(A6)                         ; $00E67C
        DBRA    D1,.loc_00AE                    ; $00E67E
        JSR     $008849AA                       ; $00E682
        CLR.W  (-14208).W                       ; $00E688
        CLR.W  (-14206).W                       ; $00E68C
        CLR.W  (-32768).W                       ; $00E690
        CLR.W  (-32766).W                       ; $00E694
        CLR.W  (-24558).W                       ; $00E698
        CLR.B  (-24552).W                       ; $00E69C
        JSR     $008849AA                       ; $00E6A0
        MOVE.L  #$008BB4FC,(-13972).W           ; $00E6A6
        MOVE.B  #$01,(-14327).W                 ; $00E6AE
        MOVE.B  #$01,(-14326).W                 ; $00E6B4
        BSET    #6,(-14322).W                   ; $00E6BA
        MOVE.B  #$01,(-14334).W                 ; $00E6C0
        MOVE.W  #$0001,(-24544).W               ; $00E6C6
        LEA     $00FF1000,A0                    ; $00E6CC
        MOVE.W  #$037F,D0                       ; $00E6D2
.loc_0108:
        CLR.L  (A0)+                            ; $00E6D6
        DBRA    D0,.loc_0108                    ; $00E6D8
        MOVE.W  #$0001,D0                       ; $00E6DC
        MOVE.W  #$0001,D1                       ; $00E6E0
        MOVE.W  #$0001,D2                       ; $00E6E4
        MOVE.W  #$0026,D3                       ; $00E6E8
        MOVE.W  #$0014,D4                       ; $00E6EC
        LEA     $00FF1000,A0                    ; $00E6F0
        DC.W    $4EBA,$FB34         ; JSR     $00E22C(PC); $00E6F6
        MOVE.W  #$0002,D0                       ; $00E6FA
        MOVE.W  #$0001,D1                       ; $00E6FE
        MOVE.W  #$0016,D2                       ; $00E702
        MOVE.W  #$0026,D3                       ; $00E706
        MOVE.W  #$0005,D4                       ; $00E70A
        LEA     $00FF1000,A0                    ; $00E70E
        DC.W    $4EBA,$FB16         ; JSR     $00E22C(PC); $00E714
        LEA     $00FF1000,A0                    ; $00E718
        DC.W    $4EBA,$FBD0         ; JSR     $00E2F0(PC); $00E71E
        DC.W    $4EBA,$FA98         ; JSR     $00E1BC(PC); $00E722
        BCLR    #7,$00A15181                    ; $00E726
        LEA     $00FF6E00,A0                    ; $00E72E
        LEA     $008BA220,A1                    ; $00E734
        MOVEA.L (A1),A1                         ; $00E73A
        MOVE.W  #$007F,D0                       ; $00E73C
.loc_0172:
        MOVE.W  (A1)+,(A0)+                     ; $00E740
        DBRA    D0,.loc_0172                    ; $00E742
        LEA     $00FF6E00,A0                    ; $00E746
        ADDA.L  #$00000160,A0                   ; $00E74C
        LEA     $0088E88C,A1                    ; $00E752
        MOVE.W  #$003F,D0                       ; $00E758
.loc_018E:
        MOVE.W  (A1)+,D1                        ; $00E75C
        BSET    #15,D1                          ; $00E75E
        MOVE.W  D1,(A0)+                        ; $00E762
        DBRA    D0,.loc_018E                    ; $00E764
        LEA     $000E9680,A0                    ; $00E768
        MOVEA.L #$06038000,A1                   ; $00E76E
        DC.W    $4EBA,$FBA0         ; JSR     $00E316(PC); $00E774
        LEA     $000E9450,A0                    ; $00E778
        MOVEA.L #$0603B600,A1                   ; $00E77E
        DC.W    $4EBA,$FB90         ; JSR     $00E316(PC); $00E784
        LEA     $000E90A0,A0                    ; $00E788
        MOVEA.L #$0603D100,A1                   ; $00E78E
        DC.W    $4EBA,$FB80         ; JSR     $00E316(PC); $00E794
        LEA     $000E9240,A0                    ; $00E798
        MOVEA.L #$0603D800,A1                   ; $00E79E
        DC.W    $4EBA,$FB70         ; JSR     $00E316(PC); $00E7A4
        MOVE.B  (-24551).W,(-24546).W           ; $00E7A8
        CLR.B  (-24550).W                       ; $00E7AE
        MOVE.W  #$0080,$00FF2000                ; $00E7B2
        MOVE.W  #$FF80,$00FF2002                ; $00E7BA
        MOVE.W  #$003C,$00FF2004                ; $00E7C2
        MOVE.W  #$00BC,$00FF2006                ; $00E7CA
        MOVE.W  #$FF60,$00FF2008                ; $00E7D2
        MOVE.W  #$0044,$00FF200A                ; $00E7DA
        MOVE.W  #$0080,$00FF200C                ; $00E7E2
        MOVE.W  #$FF80,$00FF200E                ; $00E7EA
        MOVE.W  #$003C,$00FF2010                ; $00E7F2
        JSR     $0088204A                       ; $00E7FA
        ANDI.B  #$FC,$00A15181                  ; $00E800
        ORI.B  #$01,$00A15181                   ; $00E808
        MOVE.W  #$8083,$00A15100                ; $00E810
        BSET    #6,(-14219).W                   ; $00E818
        MOVE.W  (-14220).W,(A5)                 ; $00E81E
        MOVE.W  #$0020,$00FF0008                ; $00E822
        JSR     $00884998                       ; $00E82A
        MOVE.W  #$0000,(-14210).W               ; $00E830
        MOVE.L  #$0088E90C,$00FF0002            ; $00E836
        MOVE.B  #$81,(-14171).W                 ; $00E840
        MOVE.B  #$00,$00FF60D4                  ; $00E846
        LEA     $00FF6100,A0                    ; $00E84E
        MOVE.W  #$007F,D0                       ; $00E854
.loc_028A:
        CLR.L  (A0)+                            ; $00E858
        CLR.L  (A0)+                            ; $00E85A
        CLR.L  (A0)+                            ; $00E85C
        CLR.L  (A0)+                            ; $00E85E
        CLR.L  (A0)+                            ; $00E860
        DBRA    D0,.loc_028A                    ; $00E862
.loc_0298:
        TST.B  $00A15120                        ; $00E866
        BNE.S  .loc_0298                        ; $00E86C
        CLR.B  $00A15122                        ; $00E86E
        CLR.B  $00A15123                        ; $00E874
        MOVE.B  #$03,$00A15121                  ; $00E87A
        MOVE.B  #$01,$00A15120                  ; $00E882
        RTS                                     ; $00E88A
