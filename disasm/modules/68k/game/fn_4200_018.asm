; ============================================================================
; Logic Sound Flag Handler 018 (auto-analyzed)
; ROM Range: $005100-$005308 (520 bytes)
; ============================================================================
; Category: game
; Purpose: Orchestrator calling 21 subroutines
;   Accesses 32X registers: adapter_ctrl, COMM1, COMM0
;   RAM: $C8A0 (race_state), $C8CC (race_substate), $C8AA (scene_state), $C87E (game_state)
;   Calls: SetDisplayParams, scene_transition, game_state_handler, race_state_read
;   Object (A0, A1): +$00
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, D1, A0, A1, A2, A5
; RAM:
;   $C87E: game_state
;   $C8A0: race_state
;   $C8AA: scene_state
;   $C8C8: vint_state
;   $C8CC: race_substate
; Calls:
;   $0020C6: sound_flag_handler
;   $0049AA: SetDisplayParams
;   $00A144: game_state_handler
;   $00A1FC: race_state_read
;   $00C870: scene_transition
; Object fields:
;   +$00: [unknown]
; Confidence: high
; ============================================================================

fn_4200_018:
        MOVE    #$2700,SR                       ; $005100
        BCLR    #6,(-14219).W                   ; $005104
        MOVE.W  (-14220).W,(A5)                 ; $00510A
        MOVE.W  #$0083,$00A15100                ; $00510E
        ANDI.B  #$FC,$00A15181                  ; $005116
        DC.W    $4EBA,$D5EA         ; JSR     $00270A(PC); $00511E
        MOVE.B  #$01,(-14323).W                 ; $005122
        MOVE.B  #$00,(-14322).W                 ; $005128
        ORI.B  #$20,(-14322).W                  ; $00512E
        BCLR    #7,(-600).W                     ; $005134
        MOVEQ   #$00,D0                         ; $00513A
        MOVEQ   #$00,D1                         ; $00513C
        MOVE.B  (-345).W,D0                     ; $00513E
        MOVE.B  (-334).W,D1                     ; $005142
        JSR     $0088D19C                       ; $005146
        MOVE.B  (-14135).W,D0                   ; $00514C
        ADDQ.B  #1,D0                           ; $005150
        MOVE.B  D0,$00A15122                    ; $005152
        MOVE.W  #$0103,(-14168).W               ; $005158
        MOVE.B  (-14167).W,$00A15121            ; $00515E
        MOVE.B  (-14168).W,$00A15120            ; $005166
        MOVE.B  #$00,(-14321).W                 ; $00516E
        MOVE.W  #$0000,(-14148).W               ; $005174
        JSR     $0088D1D4                       ; $00517A
        JSR     $0088D42C                       ; $005180
        LEA     $008BA220,A0                    ; $005186
        MOVE.W  (-14176).W,D0                   ; $00518C
        MOVEA.L $00(A0,D0.W),A2                 ; $005190
        DC.W    $4EBA,$D6B6         ; JSR     $00284C(PC); $005194
        LEA     $008BAE38,A0                    ; $005198
        MOVE.W  (-14132).W,D0                   ; $00519E
        MOVEA.L $00(A0,D0.W),A2                 ; $0051A2
        DC.W    $4EBA,$D6BA         ; JSR     $002862(PC); $0051A6
        MOVE.W  #$0010,$00FF0008                ; $0051AA
        MOVE.W  #$0000,(-14166).W               ; $0051B2
        DC.W    $4EBA,$F7F0         ; JSR     $0049AA(PC); $0051B8
        DC.W    $4EBA,$7BD4         ; JSR     $00CD92(PC); $0051BC
        MOVE.B  #$00,(-15596).W                 ; $0051C0
        BTST    #0,(-14312).W                   ; $0051C6
        BEQ.S  .loc_00D4                        ; $0051CC
        MOVE.B  #$01,(-15596).W                 ; $0051CE
.loc_00D4:
        MOVEQ   #$10,D0                         ; $0051D4
        DC.W    $4EBA,$7A9C         ; JSR     $00CC74(PC); $0051D6
        DC.W    $4EBA,$7694         ; JSR     $00C870(PC); $0051DA
        DC.W    $4EBA,$7820         ; JSR     $00CA00(PC); $0051DE
        DC.W    $4EBA,$7EE8         ; JSR     $00D0CC(PC); $0051E2
        TST.B  (-342).W                         ; $0051E6
        BEQ.S  .loc_00F0                        ; $0051EA
        DC.W    $4EBA,$785E         ; JSR     $00CA4C(PC); $0051EC
.loc_00F0:
        JSR     $0088D450                       ; $0051F0
        JSR     $0088D054                       ; $0051F6
        DC.W    $4EBA,$78A2         ; JSR     $00CAA0(PC); $0051FC
        MOVE.B  (-14310).W,(-15600).W           ; $005200
        DC.W    $4EBA,$7A80         ; JSR     $00CC88(PC); $005206
        MOVEQ   #$18,D0                         ; $00520A
        MOVEQ   #$00,D1                         ; $00520C
        DC.W    $4EBA,$7C12         ; JSR     $00CE22(PC); $00520E
        MOVE.B  (-342).W,(-15601).W             ; $005212
        DC.W    $4EBA,$4F2A         ; JSR     $00A144(PC); $005218
        LEA     (-28672).W,A0                   ; $00521C
        DC.W    $4EBA,$4FDA         ; JSR     $00A1FC(PC); $005220
        DC.W    $4EBA,$774E         ; JSR     $00C974(PC); $005224
        DC.W    $4EBA,$7D84         ; JSR     $00CFAE(PC); $005228
        MOVE.B  #$00,(-14311).W                 ; $00522C
        MOVE.W  #$0000,(-14146).W               ; $005232
        MOVE.W  #$0000,(-14210).W               ; $005238
        DC.W    $4EBA,$1600         ; JSR     $006840(PC); $00523E
        ANDI.B  #$FC,$00A15181                  ; $005242
        ORI.B  #$01,$00A15181                   ; $00524A
        MOVE.W  #$8083,$00A15100                ; $005252
        DC.W    $4EBA,$CDEE         ; JSR     $00204A(PC); $00525A
        DC.W    $4EBA,$CE66         ; JSR     $0020C6(PC); $00525E
        BSET    #6,(-14219).W                   ; $005262
        MOVE.W  (-14220).W,(A5)                 ; $005268
        JSR     $00884998                       ; $00526C
        MOVE.W  (-14136).W,D0                   ; $005272
        DC.W    $43FA,$FA40         ; LEA     $004CB8(PC),A1; $005276
        BTST    #0,(-14325).W                   ; $00527A
        BNE.S  .loc_0188                        ; $005280
        MOVE.B  $00(A1,D0.W),(-14171).W         ; $005282
.loc_0188:
        JSR     $00882080                       ; $005288
        JSR     $00884998                       ; $00528E
        DC.W    $4EBA,$CF58         ; JSR     $0021EE(PC); $005294
        MOVE.W  (-14176).W,D0                   ; $005298
        LEA     $008BB1C4,A0                    ; $00529C
        MOVE.L  $00(A0,D0.W),(-13972).W         ; $0052A2
        MOVE.B  #$01,(-14327).W                 ; $0052A8
        MOVE.B  #$02,(-14326).W                 ; $0052AE
        BSET    #6,(-14322).W                   ; $0052B4
        MOVE.B  #$01,(-14334).W                 ; $0052BA
        BTST    #7,(-600).W                     ; $0052C0
        BEQ.S  .loc_01D0                        ; $0052C6
        MOVE.B  #$01,$00FF60D4                  ; $0052C8
.loc_01D0:
        BTST    #0,$00A15123                    ; $0052D0
        BEQ.S  .loc_01D0                        ; $0052D8
        BCLR    #0,$00A15123                    ; $0052DA
        MOVE.W  #$0102,(-14168).W               ; $0052E2
        MOVE.L  #$00885308,$00FF0002            ; $0052E8
        MOVE.L  #$00000000,$00FF5FF8            ; $0052F2
        MOVE.L  #$00000000,$00FF5FFC            ; $0052FC
        RTS                                     ; $005306
