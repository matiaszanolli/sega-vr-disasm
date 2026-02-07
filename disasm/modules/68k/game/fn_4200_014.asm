; ============================================================================
; Logic Sound Flag Handler 014 (auto-analyzed)
; ROM Range: $004D98-$005020 (648 bytes)
; ============================================================================
; Category: game
; Purpose: Orchestrator calling 21 subroutines
;   Accesses 32X registers: adapter_ctrl, COMM1, COMM0
;   RAM: $C8A0 (race_state), $C8CC (race_substate), $C8AA (scene_state), $9F00 (obj_table_3)
;   Calls: SetDisplayParams, scene_transition, game_state_handler, race_state_read
;   Object (A0, A1): +$00
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, D1, D2, D3, D4, D5, D6, D7
; RAM:
;   $9F00: obj_table_3
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

fn_4200_014:
        MOVE    #$2700,SR                       ; $004D98
        BCLR    #6,(-14219).W                   ; $004D9C
        MOVE.W  (-14220).W,(A5)                 ; $004DA2
        MOVE.W  #$0083,$00A15100                ; $004DA6
        ANDI.B  #$FC,$00A15181                  ; $004DAE
        DC.W    $4EBA,$D952         ; JSR     $00270A(PC); $004DB6
        MOVE.B  #$01,(-14323).W                 ; $004DBA
        MOVE.B  #$00,(-14322).W                 ; $004DC0
        ORI.B  #$10,(-14322).W                  ; $004DC6
        BCLR    #7,(-600).W                     ; $004DCC
        MOVEQ   #$00,D0                         ; $004DD2
        MOVEQ   #$00,D1                         ; $004DD4
        MOVE.B  (-341).W,D0                     ; $004DD6
        MOVE.B  (-333).W,D1                     ; $004DDA
        JSR     $0088D19C                       ; $004DDE
        MOVE.B  #$04,$00A15122                  ; $004DE4
        MOVE.W  #$0103,(-14168).W               ; $004DEC
        MOVE.B  (-14167).W,$00A15121            ; $004DF2
        MOVE.B  (-14168).W,$00A15120            ; $004DFA
        MOVE.B  #$01,(-14321).W                 ; $004E02
        MOVE.W  #$0040,(-14148).W               ; $004E08
        JSR     $0088D1D4                       ; $004E0E
        JSR     $0088D42C                       ; $004E14
        LEA     $008BA220,A0                    ; $004E1A
        MOVE.W  (-14176).W,D0                   ; $004E20
        MOVEA.L $00(A0,D0.W),A2                 ; $004E24
        DC.W    $4EBA,$DA22         ; JSR     $00284C(PC); $004E28
        LEA     $008BAE38,A0                    ; $004E2C
        MOVE.W  (-14132).W,D0                   ; $004E32
        MOVEA.L $00(A0,D0.W),A2                 ; $004E36
        DC.W    $4EBA,$DA26         ; JSR     $002862(PC); $004E3A
        MOVE.W  #$0010,$00FF0008                ; $004E3E
        MOVE.W  #$0000,(-14166).W               ; $004E46
        DC.W    $4EBA,$FB5C         ; JSR     $0049AA(PC); $004E4C
        DC.W    $4EBA,$7F40         ; JSR     $00CD92(PC); $004E50
        MOVEQ   #$10,D0                         ; $004E54
        DC.W    $4EBA,$7E1C         ; JSR     $00CC74(PC); $004E56
        DC.W    $4EBA,$7A14         ; JSR     $00C870(PC); $004E5A
        DC.W    $4EBA,$7B80         ; JSR     $00C9E0(PC); $004E5E
        TST.B  (-337).W                         ; $004E62
        BEQ.S  .loc_00D4                        ; $004E66
        DC.W    $4EBA,$7BFC         ; JSR     $00CA66(PC); $004E68
.loc_00D4:
        TST.B  (-336).W                         ; $004E6C
        BEQ.S  .loc_00DE                        ; $004E70
        DC.W    $4EBA,$7C0C         ; JSR     $00CA80(PC); $004E72
.loc_00DE:
        JSR     $0088D450                       ; $004E76
        JSR     $0088D08A                       ; $004E7C
        DC.W    $4EBA,$7CBA         ; JSR     $00CB3E(PC); $004E82
        DC.W    $4EBA,$7E00         ; JSR     $00CC88(PC); $004E86
        LEA     (-24832).W,A0                   ; $004E8A
        DC.W    $4EBA,$7E02         ; JSR     $00CC92(PC); $004E8E
        MOVEQ   #$30,D0                         ; $004E92
        JSR     $0088CE02                       ; $004E94
        MOVE.B  (-336).W,(-15601).W             ; $004E9A
        DC.W    $4EBA,$52A2         ; JSR     $00A144(PC); $004EA0
        LEA     (-24832).W,A0                   ; $004EA4
        DC.W    $4EBA,$5352         ; JSR     $00A1FC(PC); $004EA8
        DC.W    $4EBA,$7A44         ; JSR     $00C8F2(PC); $004EAC
        JSR     $0088CFD6                       ; $004EB0
        JSR     $0088CE76                       ; $004EB6
        JSR     $0088CECC                       ; $004EBC
        MOVE.B  #$00,(-15596).W                 ; $004EC2
        BTST    #1,(-14312).W                   ; $004EC8
        BEQ.S  .loc_013E                        ; $004ECE
        MOVE.B  #$01,(-15596).W                 ; $004ED0
.loc_013E:
        LEA     (-16384).W,A2                   ; $004ED6
        LEA     (-18432).W,A1                   ; $004EDA
        MOVEQ   #$1F,D7                         ; $004EDE
.loc_0148:
        MOVEM.L (A2)+,D0/D1/D2/D3/D4/D5/D6/A3   ; $004EE0
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/A3,-(A1)   ; $004EE4
        DBRA    D7,.loc_0148                    ; $004EE8
        MOVE.B  #$00,(-15596).W                 ; $004EEC
        BTST    #0,(-14312).W                   ; $004EF2
        BEQ.S  .loc_0168                        ; $004EF8
        MOVE.B  #$01,(-15596).W                 ; $004EFA
.loc_0168:
        MOVE.B  (-337).W,(-15601).W             ; $004F00
        DC.W    $4EBA,$523C         ; JSR     $00A144(PC); $004F06
        LEA     (-28672).W,A0                   ; $004F0A
        DC.W    $4EBA,$52EC         ; JSR     $00A1FC(PC); $004F0E
        JSR     $0088CEC2                       ; $004F12
        MOVE.W  #$0000,(-14210).W               ; $004F18
        BSET    #4,(-14322).W                   ; $004F1E
        DC.W    $4EBA,$14E8         ; JSR     $00640E(PC); $004F24
        DC.W    $4EBA,$156C         ; JSR     $006496(PC); $004F28
        ANDI.B  #$FC,$00A15181                  ; $004F2C
        ORI.B  #$01,$00A15181                   ; $004F34
        MOVE.W  #$8083,$00A15100                ; $004F3C
        DC.W    $4EBA,$D104         ; JSR     $00204A(PC); $004F44
        DC.W    $4EBA,$D17C         ; JSR     $0020C6(PC); $004F48
        BSET    #6,(-14219).W                   ; $004F4C
        MOVE.W  (-14220).W,(A5)                 ; $004F52
        JSR     $00884998                       ; $004F56
        MOVE.W  (-14136).W,D0                   ; $004F5C
        MOVE.W  #$0000,(-30832).W               ; $004F60
        DC.W    $43FA,$FD50         ; LEA     $004CB8(PC),A1; $004F66
        BTST    #0,(-14325).W                   ; $004F6A
        BNE.S  .loc_01E0                        ; $004F70
        MOVE.B  $00(A1,D0.W),(-14171).W         ; $004F72
.loc_01E0:
        JSR     $00882080                       ; $004F78
        JSR     $00884998                       ; $004F7E
        MOVE.W  (-14136).W,D0                   ; $004F84
        MOVE.W  #$0000,(-30880).W               ; $004F88
        DC.W    $43FA,$0090         ; LEA     $005020(PC),A1; $004F8E
        BTST    #0,(-14325).W                   ; $004F92
        BNE.S  .loc_0208                        ; $004F98
        MOVE.B  $00(A1,D0.W),(-14171).W         ; $004F9A
.loc_0208:
        JSR     $00882080                       ; $004FA0
        JSR     $00884998                       ; $004FA6
        DC.W    $4EBA,$D240         ; JSR     $0021EE(PC); $004FAC
        MOVE.W  (-14176).W,D0                   ; $004FB0
        LEA     $008BB1C4,A0                    ; $004FB4
        MOVE.L  $00(A0,D0.W),(-13972).W         ; $004FBA
        MOVE.B  #$01,(-14327).W                 ; $004FC0
        MOVE.B  #$02,(-14326).W                 ; $004FC6
        BSET    #6,(-14322).W                   ; $004FCC
        MOVE.B  #$01,(-14334).W                 ; $004FD2
        BTST    #7,(-600).W                     ; $004FD8
        BEQ.S  .loc_0250                        ; $004FDE
        MOVE.B  #$01,$00FF60D4                  ; $004FE0
.loc_0250:
        BTST    #0,$00A15123                    ; $004FE8
        BEQ.S  .loc_0250                        ; $004FF0
        BCLR    #0,$00A15123                    ; $004FF2
        MOVE.W  #$0104,(-14168).W               ; $004FFA
        MOVE.L  #$00885024,$00FF0002            ; $005000
        MOVE.L  #$00000000,$00FF5FF8            ; $00500A
        MOVE.L  #$00000000,$00FF5FFC            ; $005014
        RTS                                     ; $00501E
