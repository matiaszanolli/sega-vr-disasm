; ============================================================================
; Name Entry Object Update 028 (auto-analyzed)
; ROM Range: $011630-$0117F4 (452 bytes)
; ============================================================================
; Category: game
; Purpose: Orchestrator calling 4 subroutines
;   RAM: $C87E (game_state)
;   Calls: dma_transfer, object_update, sprite_update, sh2_send_cmd
;
; Uses: D0, D1, D2, A0, A1
; RAM:
;   $C87E: game_state
; Calls:
;   $00B684: object_update
;   $00B6DA: sprite_update
;   $00E35A: sh2_send_cmd
;   $00E52C: dma_transfer
; Confidence: high
; ============================================================================

fn_10200_028:
        CLR.W  D0                               ; $011630
        DC.W    $4EBA,$CEF8         ; JSR     $00E52C(PC); $011632
        DC.W    $4EBA,$A04C         ; JSR     $00B684(PC); $011636
        DC.W    $4EBA,$A09E         ; JSR     $00B6DA(PC); $01163A
        MOVEA.L #$26032000,A0                   ; $01163E
        MOVE.L  (-24526).W,D0                   ; $011644
        ADDA.L  D0,A0                           ; $011648
        MOVEA.L #$240100A0,A1                   ; $01164A
        MOVE.W  #$0080,D0                       ; $011650
        MOVE.W  #$0050,D1                       ; $011654
        DC.W    $4EBA,$CD00         ; JSR     $00E35A(PC); $011658
        TST.L  (-24538).W                       ; $01165C
        BEQ.W  .loc_004E                        ; $011660
        MOVE.L  (-24542).W,D0                   ; $011664
        MOVE.L  (-24538).W,D1                   ; $011668
        DC.W    $D081                           ; $01166C
        MOVE.L  D0,(-24542).W                   ; $01166E
        SUBQ.B  #1,(-24530).W                   ; $011672
        BCC.W  .loc_00E4                        ; $011676
        CLR.L  (-24538).W                       ; $01167A
.loc_004E:
        CMPI.W  #$0001,(-24484).W               ; $01167E
        BEQ.W  .loc_0186                        ; $011684
        CMPI.W  #$0002,(-24484).W               ; $011688
        BEQ.W  .loc_019C                        ; $01168E
        JSR     $0088179E                       ; $011692
        MOVE.W  (-14228).W,D1                   ; $011698
        MOVE.W  D1,D2                           ; $01169C
        ANDI.B  #$F0,D2                         ; $01169E
        BEQ.S  .loc_00A2                        ; $0116A2
        MOVE.B  #$A8,(-14172).W                 ; $0116A4
        MOVE.W  #$0002,(-24484).W               ; $0116AA
        MOVE.B  #$01,(-14327).W                 ; $0116B0
        MOVE.B  #$01,(-14326).W                 ; $0116B6
        BSET    #7,(-14322).W                   ; $0116BC
        MOVE.B  #$01,(-14334).W                 ; $0116C2
        JSR     $0088205E                       ; $0116C8
        BRA.W  .loc_01B6                        ; $0116CE
.loc_00A2:
        LSR.W  #8,D1                            ; $0116D2
        BTST    #0,D1                           ; $0116D4
        BEQ.S  .loc_00C4                        ; $0116D8
        TST.L  (-24542).W                       ; $0116DA
        BLE.W  .loc_00E4                        ; $0116DE
        MOVE.L  #$FFFFFE00,(-24538).W           ; $0116E2
        MOVE.B  #$03,(-24530).W                 ; $0116EA
        BRA.W  .loc_00E4                        ; $0116F0
.loc_00C4:
        BTST    #1,D1                           ; $0116F4
        BEQ.S  .loc_00E4                        ; $0116F8
        MOVE.L  (-24542).W,D0                   ; $0116FA
        CMP.L  (-24534).W,D0                    ; $0116FE
        BGE.W  .loc_00E4                        ; $011702
        MOVE.L  #$00000200,(-24538).W           ; $011706
        MOVE.B  #$03,(-24530).W                 ; $01170E
.loc_00E4:
        TST.L  (-24522).W                       ; $011714
        BEQ.W  .loc_0106                        ; $011718
        MOVE.L  (-24526).W,D0                   ; $01171C
        MOVE.L  (-24522).W,D1                   ; $011720
        DC.W    $D081                           ; $011724
        MOVE.L  D0,(-24526).W                   ; $011726
        SUBQ.B  #1,(-24514).W                   ; $01172A
        BCC.W  .loc_01B6                        ; $01172E
        CLR.L  (-24522).W                       ; $011732
.loc_0106:
        MOVE.W  (-14226).W,D1                   ; $011736
        MOVE.W  D1,D2                           ; $01173A
        ANDI.B  #$F0,D2                         ; $01173C
        BEQ.S  .loc_0140                        ; $011740
        MOVE.B  #$A8,(-14172).W                 ; $011742
        MOVE.W  #$0002,(-24484).W               ; $011748
        MOVE.B  #$01,(-14327).W                 ; $01174E
        MOVE.B  #$01,(-14326).W                 ; $011754
        BSET    #7,(-14322).W                   ; $01175A
        MOVE.B  #$01,(-14334).W                 ; $011760
        JSR     $0088205E                       ; $011766
        BRA.W  .loc_01B6                        ; $01176C
.loc_0140:
        LSR.W  #8,D1                            ; $011770
        BTST    #0,D1                           ; $011772
        BEQ.S  .loc_0162                        ; $011776
        TST.L  (-24526).W                       ; $011778
        BLE.W  .loc_01B6                        ; $01177C
        MOVE.L  #$FFFFFE00,(-24522).W           ; $011780
        MOVE.B  #$03,(-24514).W                 ; $011788
        BRA.W  .loc_01B6                        ; $01178E
.loc_0162:
        BTST    #1,D1                           ; $011792
        BEQ.S  .loc_01B6                        ; $011796
        MOVE.L  (-24526).W,D0                   ; $011798
        CMP.L  (-24518).W,D0                    ; $01179C
        BGE.W  .loc_01B6                        ; $0117A0
        MOVE.L  #$00000200,(-24522).W           ; $0117A4
        MOVE.B  #$03,(-24514).W                 ; $0117AC
        BRA.W  .loc_01B6                        ; $0117B2
.loc_0186:
        JSR     $0088FB36                       ; $0117B6
        BTST    #6,(-14322).W                   ; $0117BC
        BNE.S  .loc_01B6                        ; $0117C2
        CLR.W  (-24484).W                       ; $0117C4
        BRA.W  .loc_01B6                        ; $0117C8
.loc_019C:
        JSR     $0088FB36                       ; $0117CC
        BTST    #7,(-14322).W                   ; $0117D2
        BNE.S  .loc_01B6                        ; $0117D8
        CLR.W  (-24484).W                       ; $0117DA
        ADDQ.W  #4,(-14210).W                   ; $0117DE
        BRA.W  .loc_01BA                        ; $0117E2
.loc_01B6:
        SUBQ.W  #4,(-14210).W                   ; $0117E6
.loc_01BA:
        MOVE.W  #$0018,$00FF0008                ; $0117EA
        RTS                                     ; $0117F2
