; ============================================================================
; Logic Sound Flag Handler 022 (auto-analyzed)
; ROM Range: $0053B0-$005586 (470 bytes)
; ============================================================================
; Category: game
; Purpose: Orchestrator calling 26 subroutines
;   Accesses 32X registers: adapter_ctrl, COMM1, COMM0
;   RAM: $C8A0 (race_state), $C8CC (race_substate), $C8AA (scene_state), $C87E (game_state)
;   Calls: SetDisplayParams, scene_transition, game_state_handler, race_state_read
;   Object (A0): +$00
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, A0, A2, A5
; RAM:
;   $C87E: game_state
;   $C8A0: race_state
;   $C8AA: scene_state
;   $C8CC: race_substate
; Calls:
;   $0020C6: sound_flag_handler
;   $0049AA: SetDisplayParams
;   $0058C8: sprite_input_check
;   $005908: sprite_update_check
;   $00593C: sprite_state_process
;   $00A144: game_state_handler
; Object fields:
;   +$00: [unknown]
; Confidence: high
; ============================================================================

fn_4200_022:
        MOVE    #$2700,SR                       ; $0053B0
        BCLR    #6,(-14219).W                   ; $0053B4
        MOVE.W  (-14220).W,(A5)                 ; $0053BA
        MOVE.W  #$0083,$00A15100                ; $0053BE
        ANDI.B  #$FC,$00A15181                  ; $0053C6
        DC.W    $4EBA,$D33A         ; JSR     $00270A(PC); $0053CE
        MOVEQ   #$07,D0                         ; $0053D2
        JSR     $008814BE                       ; $0053D4
        MOVEQ   #$00,D1                         ; $0053DA
        MOVE.B  (-330).W,D0                     ; $0053DC
        CMPI.B  #$05,D0                         ; $0053E0
        BCS.S  .loc_0038                        ; $0053E4
        MOVEQ   #$00,D0                         ; $0053E6
.loc_0038:
        MOVE.B  (-331).W,D1                     ; $0053E8
        MOVE.B  #$01,(-14323).W                 ; $0053EC
        DC.W    $4EBA,$7DA8         ; JSR     $00D19C(PC); $0053F2
        MOVE.B  (-14135).W,D0                   ; $0053F6
        ADDQ.B  #1,D0                           ; $0053FA
        MOVE.B  D0,$00A15122                    ; $0053FC
        MOVE.W  #$0103,(-14168).W               ; $005402
        MOVE.B  (-14167).W,$00A15121            ; $005408
        MOVE.B  (-14168).W,$00A15120            ; $005410
        MOVE.B  #$00,(-14321).W                 ; $005418
        MOVE.W  #$0000,(-14148).W               ; $00541E
        JSR     $0088D1D4                       ; $005424
        JSR     $0088D42C                       ; $00542A
        LEA     $008BA220,A0                    ; $005430
        MOVE.W  (-14176).W,D0                   ; $005436
        MOVEA.L $00(A0,D0.W),A2                 ; $00543A
        DC.W    $4EBA,$D40C         ; JSR     $00284C(PC); $00543E
        LEA     $008BAE38,A0                    ; $005442
        MOVE.W  (-14132).W,D0                   ; $005448
        MOVEA.L $00(A0,D0.W),A2                 ; $00544C
        DC.W    $4EBA,$D410         ; JSR     $002862(PC); $005450
        MOVE.W  #$0010,$00FF0008                ; $005454
        MOVE.W  #$0000,(-14166).W               ; $00545C
        MOVE.W  #$0000,(-16256).W               ; $005462
        DC.W    $4EBA,$F540         ; JSR     $0049AA(PC); $005468
        DC.W    $4EBA,$7924         ; JSR     $00CD92(PC); $00546C
        MOVE.B  #$00,(-15596).W                 ; $005470
        BTST    #0,(-14312).W                   ; $005476
        BEQ.S  .loc_00D4                        ; $00547C
        MOVE.B  #$01,(-15596).W                 ; $00547E
.loc_00D4:
        MOVEQ   #$00,D0                         ; $005484
        DC.W    $4EBA,$77EC         ; JSR     $00CC74(PC); $005486
        DC.W    $4EBA,$73E4         ; JSR     $00C870(PC); $00548A
        DC.W    $4EBA,$7580         ; JSR     $00CA10(PC); $00548E
        DC.W    $4EBA,$77F4         ; JSR     $00CC88(PC); $005492
        DC.W    $4EBA,$65C6         ; JSR     $00BA5E(PC); $005496
        MOVEQ   #$00,D0                         ; $00549A
        MOVEQ   #$00,D1                         ; $00549C
        DC.W    $4EBA,$7932         ; JSR     $00CDD2(PC); $00549E
        DC.W    $4EBA,$78A8         ; JSR     $00CD4C(PC); $0054A2
        DC.W    $4EBA,$533A         ; JSR     $00A7E2(PC); $0054A6
        DC.W    $4EBA,$4C98         ; JSR     $00A144(PC); $0054AA
        LEA     (-28672).W,A0                   ; $0054AE
        DC.W    $4EBA,$4D48         ; JSR     $00A1FC(PC); $0054B2
        DC.W    $4EBA,$74BC         ; JSR     $00C974(PC); $0054B6
        DC.W    $4EBA,$7A50         ; JSR     $00CF0C(PC); $0054BA
        DC.W    $4EBA,$7746         ; JSR     $00CC06(PC); $0054BE
        DC.W    $4EBA,$7AEA         ; JSR     $00CFAE(PC); $0054C2
        DC.W    $4EBA,$77AA         ; JSR     $00CC72(PC); $0054C6
        MOVE.W  #$0090,$00FF60CC                ; $0054CA
        MOVE.W  #$0000,(-14210).W               ; $0054D2
        DC.W    $4EBA,$03EE         ; JSR     $0058C8(PC); $0054D8
        DC.W    $4EBA,$042A         ; JSR     $005908(PC); $0054DC
        DC.W    $4EBA,$045A         ; JSR     $00593C(PC); $0054E0
        ANDI.B  #$FC,$00A15181                  ; $0054E4
        ORI.B  #$01,$00A15181                   ; $0054EC
        MOVE.W  #$8083,$00A15100                ; $0054F4
        DC.W    $4EBA,$CB4C         ; JSR     $00204A(PC); $0054FC
        DC.W    $4EBA,$CBC4         ; JSR     $0020C6(PC); $005500
        BSET    #6,(-14219).W                   ; $005504
        MOVE.W  (-14220).W,(A5)                 ; $00550A
        JSR     $00884998                       ; $00550E
        MOVE.W  (-14176).W,D0                   ; $005514
        LEA     $008BB1C4,A0                    ; $005518
        MOVE.L  $00(A0,D0.W),(-13972).W         ; $00551E
        MOVE.B  #$01,(-14327).W                 ; $005524
        MOVE.B  #$02,(-14326).W                 ; $00552A
        BSET    #6,(-14322).W                   ; $005530
        MOVE.B  #$01,(-14334).W                 ; $005536
.loc_018C:
        BTST    #0,$00A15123                    ; $00553C
        BEQ.S  .loc_018C                        ; $005544
        BCLR    #0,$00A15123                    ; $005546
        MOVE.B  #$9B,(-14171).W                 ; $00554E
        JSR     $00882080                       ; $005554
        JSR     $00884998                       ; $00555A
        MOVE.W  #$0105,(-14168).W               ; $005560
        MOVE.L  #$00885586,$00FF0002            ; $005566
        MOVE.L  #$00000000,$00FF5FF8            ; $005570
        MOVE.L  #$00000000,$00FF5FFC            ; $00557A
        RTS                                     ; $005584
