; ============================================================================
; Logic Pre Dispatch Common 009 (auto-analyzed)
; ROM Range: $004A32-$004C8A (600 bytes)
; ============================================================================
; Category: game
; Purpose: Orchestrator calling 19 subroutines
;   Accesses 32X registers: adapter_ctrl, COMM1, COMM0
;   RAM: $C8A0 (race_state), $C8CC (race_substate), $C8AA (scene_state), $C89C (sh2_comm_state)
;   Calls: SetDisplayParams, scene_transition, game_state_handler, race_state_read
;   Object (A0, A1): +$00
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, D1, A0, A1, A2, A5
; RAM:
;   $C87E: game_state
;   $C89C: sh2_comm_state
;   $C8A0: race_state
;   $C8AA: scene_state
;   $C8C8: vint_state
;   $C8CC: race_substate
; Calls:
;   $002080: pre_dispatch_common
;   $0020C6: sound_flag_handler
;   $004998: WaitForVBlank
;   $0049AA: SetDisplayParams
;   $0058C8: sprite_input_check
;   $005908: sprite_update_check
; Object fields:
;   +$00: [unknown]
; Confidence: high
; ============================================================================

fn_4200_009:
        MOVEQ   #$00,D1                         ; $004A32
        LEA     $00FF7B80,A1                    ; $004A34
        DC.W    $4EFA,$FE02         ; JMP     $00483E(PC); $004A3A
        MOVE    #$2700,SR                       ; $004A3E
        BCLR    #6,(-14219).W                   ; $004A42
        MOVE.W  (-14220).W,(A5)                 ; $004A48
        MOVE.W  #$0083,$00A15100                ; $004A4C
        ANDI.B  #$FC,$00A15181                  ; $004A54
        DC.W    $4EBA,$DCAC         ; JSR     $00270A(PC); $004A5C
        MOVE.B  #$01,(-14323).W                 ; $004A60
        ANDI.B  #$09,(-14322).W                 ; $004A66
        MOVEQ   #$00,D0                         ; $004A6C
        MOVEQ   #$00,D1                         ; $004A6E
        MOVE.B  (-347).W,D0                     ; $004A70
        MOVE.B  (-335).W,D1                     ; $004A74
        BTST    #7,(-600).W                     ; $004A78
        BEQ.S  .loc_0052                        ; $004A7E
        MOVE.B  (-346).W,D0                     ; $004A80
.loc_0052:
        JSR     $0088D19C                       ; $004A84
        MOVE.B  (-14135).W,D0                   ; $004A8A
        ADDQ.B  #1,D0                           ; $004A8E
        MOVE.B  D0,$00A15122                    ; $004A90
        MOVE.W  #$0103,(-14168).W               ; $004A96
        MOVE.B  (-14167).W,$00A15121            ; $004A9C
        MOVE.B  (-14168).W,$00A15120            ; $004AA4
        MOVE.B  #$00,(-14321).W                 ; $004AAC
        MOVE.W  #$0000,(-14148).W               ; $004AB2
        JSR     $0088D1D4                       ; $004AB8
        JSR     $0088D42C                       ; $004ABE
        LEA     $008BA220,A0                    ; $004AC4
        MOVE.W  (-14176).W,D0                   ; $004ACA
        MOVEA.L $00(A0,D0.W),A2                 ; $004ACE
        DC.W    $4EBA,$DD78         ; JSR     $00284C(PC); $004AD2
        LEA     $008BAE38,A0                    ; $004AD6
        MOVE.W  (-14132).W,D0                   ; $004ADC
        MOVEA.L $00(A0,D0.W),A2                 ; $004AE0
        DC.W    $4EBA,$DD7C         ; JSR     $002862(PC); $004AE4
        MOVE.W  #$0010,$00FF0008                ; $004AE8
        MOVE.W  #$0000,(-14166).W               ; $004AF0
        DC.W    $4EBA,$FEB2         ; JSR     $0049AA(PC); $004AF6
        JSR     $0088CD92                       ; $004AFA
        MOVE.B  #$00,(-15596).W                 ; $004B00
        BTST    #0,(-14312).W                   ; $004B06
        BEQ.S  .loc_00E2                        ; $004B0C
        MOVE.B  #$01,(-15596).W                 ; $004B0E
.loc_00E2:
        MOVEQ   #$00,D0                         ; $004B14
        JSR     $0088CC74                       ; $004B16
        DC.W    $4EBA,$7D52         ; JSR     $00C870(PC); $004B1C
        DC.W    $4EBA,$7E94         ; JSR     $00C9B6(PC); $004B20
        TST.B  (-343).W                         ; $004B24
        BEQ.S  .loc_00FC                        ; $004B28
        DC.W    $4EBA,$7F20         ; JSR     $00CA4C(PC); $004B2A
.loc_00FC:
        BTST    #7,(-600).W                     ; $004B2E
        BEQ.S  .loc_010E                        ; $004B34
        MOVE.L  #$0403131C,$00FF69B4            ; $004B36
.loc_010E:
        JSR     $0088D054                       ; $004B40
        JSR     $0088CA9A                       ; $004B46
        MOVE.B  #$05,(-15600).W                 ; $004B4C
        JSR     $0088CC88                       ; $004B52
        MOVEQ   #$18,D0                         ; $004B58
        MOVEQ   #-$01,D1                        ; $004B5A
        TST.W  (-14180).W                       ; $004B5C
        BEQ.S  .loc_0132                        ; $004B60
        MOVEQ   #$00,D1                         ; $004B62
.loc_0132:
        JSR     $0088CDD2                       ; $004B64
        JSR     $0088CD4C                       ; $004B6A
        DC.W    $4EBA,$5C98         ; JSR     $00A80A(PC); $004B70
        DC.W    $4EBA,$55CE         ; JSR     $00A144(PC); $004B74
        LEA     (-28672).W,A0                   ; $004B78
        DC.W    $4EBA,$567E         ; JSR     $00A1FC(PC); $004B7C
        DC.W    $4EBA,$7DF2         ; JSR     $00C974(PC); $004B80
        JSR     $0088CF0C                       ; $004B84
        JSR     $0088CC06                       ; $004B8A
        JSR     $0088CFAE                       ; $004B90
        MOVE.W  #$0000,(-14210).W               ; $004B96
        MOVE.W  #$C9A0,(-14144).W               ; $004B9C
        MOVE.B  #$02,(-14326).W                 ; $004BA2
        BTST    #3,(-14322).W                   ; $004BA8
        BEQ.S  .loc_0184                        ; $004BAE
        JSR     $0088D0F6                       ; $004BB0
.loc_0184:
        DC.W    $4EBA,$0D10         ; JSR     $0058C8(PC); $004BB6
        DC.W    $4EBA,$0D4C         ; JSR     $005908(PC); $004BBA
        DC.W    $4EBA,$0D7C         ; JSR     $00593C(PC); $004BBE
        ANDI.B  #$FC,$00A15181                  ; $004BC2
        ORI.B  #$01,$00A15181                   ; $004BCA
        MOVE.W  #$8083,$00A15100                ; $004BD2
        DC.W    $4EBA,$D46E         ; JSR     $00204A(PC); $004BDA
        DC.W    $4EBA,$D4E6         ; JSR     $0020C6(PC); $004BDE
        BSET    #6,(-14219).W                   ; $004BE2
        MOVE.W  (-14220).W,(A5)                 ; $004BE8
        DC.W    $4EBA,$FDAA         ; JSR     $004998(PC); $004BEC
        MOVE.W  (-14176).W,D0                   ; $004BF0
        LEA     $008BB1C4,A0                    ; $004BF4
        MOVE.L  $00(A0,D0.W),(-13972).W         ; $004BFA
        MOVE.B  #$01,(-14327).W                 ; $004C00
        BSET    #6,(-14322).W                   ; $004C06
        MOVE.B  #$01,(-14334).W                 ; $004C0C
        BTST    #7,(-600).W                     ; $004C12
        BEQ.S  .loc_01F0                        ; $004C18
        MOVE.B  #$01,$00FF60D4                  ; $004C1A
.loc_01F0:
        BTST    #0,$00A15123                    ; $004C22
        BEQ.S  .loc_01F0                        ; $004C2A
        BCLR    #0,$00A15123                    ; $004C2C
        MOVE.W  #$0102,(-14168).W               ; $004C34
        BTST    #3,(-14322).W                   ; $004C3A
        DC.W    $6648               ; BNE.S  $004C8A; $004C40
        MOVE.W  (-14136).W,D0                   ; $004C42
        MOVE.W  #$0000,(-30832).W               ; $004C46
        DC.W    $43FA,$006A         ; LEA     $004CB8(PC),A1; $004C4C
        BTST    #0,(-14325).W                   ; $004C50
        BNE.S  .loc_022C                        ; $004C56
        MOVE.B  $00(A1,D0.W),(-14171).W         ; $004C58
.loc_022C:
        DC.W    $4EBA,$D420         ; JSR     $002080(PC); $004C5E
        DC.W    $4EBA,$FD34         ; JSR     $004998(PC); $004C62
        DC.W    $4EBA,$D586         ; JSR     $0021EE(PC); $004C66
        MOVE.L  #$00884CBC,$00FF0002            ; $004C6A
        MOVE.L  #$00000000,$00FF5FF8            ; $004C74
        MOVE.L  #$00000000,$00FF5FFC            ; $004C7E
        RTS                                     ; $004C88
