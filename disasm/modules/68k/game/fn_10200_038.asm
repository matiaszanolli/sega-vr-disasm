; ============================================================================
; Sh2 Comm Palette Load 038 (auto-analyzed)
; ROM Range: $011D0A-$011F38 (558 bytes)
; ============================================================================
; Category: sh2
; Purpose: Orchestrator calling 4 subroutines
;   Accesses 32X registers: adapter_ctrl
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

fn_10200_038:
        MOVE.W  #$002C,$00FF0008                ; $011D0A
        MOVE.W  #$002C,(-14214).W               ; $011D12
        BCLR    #6,(-14219).W                   ; $011D18
        MOVE.W  (-14220).W,(A5)                 ; $011D1E
        MOVE.W  #$0083,$00A15100                ; $011D22
        ANDI.B  #$FC,$00A15181                  ; $011D2A
        JSR     $008826C8                       ; $011D32
        MOVE.L  #$000A0907,D0                   ; $011D38
        JSR     $008814BE                       ; $011D3E
        MOVE.B  #$01,(-14323).W                 ; $011D44
        MOVEQ   #$00,D0                         ; $011D4A
        LEA     (-31616).W,A0                   ; $011D4C
        MOVEQ   #$1F,D1                         ; $011D50
.loc_0048:
        MOVE.L  D0,(A0)+                        ; $011D52
        DBRA    D1,.loc_0048                    ; $011D54
        LEA     $00FF7B80,A0                    ; $011D58
        MOVEQ   #$7F,D1                         ; $011D5E
.loc_0056:
        MOVE.L  D0,(A0)+                        ; $011D60
        DBRA    D1,.loc_0056                    ; $011D62
        MOVE.L  #$60000002,(A5)                 ; $011D66
        MOVE.W  #$17FF,D1                       ; $011D6C
.loc_0066:
        MOVE.L  D0,(A6)                         ; $011D70
        DBRA    D1,.loc_0066                    ; $011D72
        JSR     $008849AA                       ; $011D76
        CLR.W  (-14208).W                       ; $011D7C
        CLR.W  (-14206).W                       ; $011D80
        CLR.W  (-32768).W                       ; $011D84
        CLR.W  (-32766).W                       ; $011D88
        CLR.W  (-24558).W                       ; $011D8C
        CLR.B  (-24552).W                       ; $011D90
        JSR     $008849AA                       ; $011D94
        MOVE.L  #$008BB4FC,(-13972).W           ; $011D9A
        MOVE.B  #$01,(-14327).W                 ; $011DA2
        MOVE.B  #$01,(-14326).W                 ; $011DA8
        BSET    #6,(-14322).W                   ; $011DAE
        MOVE.B  #$01,(-14334).W                 ; $011DB4
        MOVE.W  #$0001,(-24520).W               ; $011DBA
        LEA     $00FF1000,A0                    ; $011DC0
        MOVE.W  #$037F,D0                       ; $011DC6
.loc_00C0:
        CLR.L  (A0)+                            ; $011DCA
        DBRA    D0,.loc_00C0                    ; $011DCC
        MOVE.W  #$0001,D0                       ; $011DD0
        MOVE.W  #$0001,D1                       ; $011DD4
        MOVE.W  #$0001,D2                       ; $011DD8
        MOVE.W  #$0026,D3                       ; $011DDC
        MOVE.W  #$001A,D4                       ; $011DE0
        LEA     $00FF1000,A0                    ; $011DE4
        DC.W    $4EBA,$C440         ; JSR     $00E22C(PC); $011DEA
        LEA     $00FF1000,A0                    ; $011DEE
        DC.W    $4EBA,$C4FA         ; JSR     $00E2F0(PC); $011DF4
        DC.W    $4EBA,$C3C2         ; JSR     $00E1BC(PC); $011DF8
        BCLR    #7,$00A15181                    ; $011DFC
        LEA     $00FF6E00,A0                    ; $011E04
        ADDQ.L  #2,A0                           ; $011E0A
        LEA     $00891F38,A1                    ; $011E0C
        MOVE.W  #$002E,D0                       ; $011E12
.loc_010C:
        MOVE.W  (A1)+,D1                        ; $011E16
        BSET    #15,D1                          ; $011E18
        MOVE.W  D1,(A0)+                        ; $011E1C
        DBRA    D0,.loc_010C                    ; $011E1E
        LEA     $00FF6E00,A0                    ; $011E22
        ADDA.L  #$00000120,A0                   ; $011E28
        LEA     $00891F96,A1                    ; $011E2E
        MOVE.W  #$005F,D0                       ; $011E34
.loc_012E:
        MOVE.W  (A1)+,D1                        ; $011E38
        BSET    #15,D1                          ; $011E3A
        MOVE.W  D1,(A0)+                        ; $011E3E
        DBRA    D0,.loc_012E                    ; $011E40
        LEA     $000EDF70,A0                    ; $011E44
        MOVEA.L #$06018000,A1                   ; $011E4A
        DC.W    $4EBA,$C4C4         ; JSR     $00E316(PC); $011E50
        LEA     $000EE770,A0                    ; $011E54
        MOVEA.L #$0601AD00,A1                   ; $011E5A
        DC.W    $4EBA,$C4B4         ; JSR     $00E316(PC); $011E60
        LEA     $000EBB40,A0                    ; $011E64
        MOVEA.L #$0601BE00,A1                   ; $011E6A
        DC.W    $4EBA,$C4A4         ; JSR     $00E316(PC); $011E70
        LEA     $000EB980,A0                    ; $011E74
        MOVEA.L #$0601F000,A1                   ; $011E7A
        DC.W    $4EBA,$C494         ; JSR     $00E316(PC); $011E80
        LEA     $000EC6F0,A0                    ; $011E84
        MOVEA.L #$0601F9C0,A1                   ; $011E8A
        DC.W    $4EBA,$C484         ; JSR     $00E316(PC); $011E90
        LEA     $000EC150,A0                    ; $011E94
        MOVEA.L #$060207C0,A1                   ; $011E9A
        DC.W    $4EBA,$C474         ; JSR     $00E316(PC); $011EA0
        LEA     $000EEA40,A0                    ; $011EA4
        MOVEA.L #$06030000,A1                   ; $011EAA
        DC.W    $4EBA,$C464         ; JSR     $00E316(PC); $011EB0
        MOVE.B  #$00,(-24551).W                 ; $011EB4
        MOVE.B  #$00,(-24550).W                 ; $011EBA
        MOVE.B  #$00,(-24549).W                 ; $011EC0
        MOVE.B  #$00,(-24548).W                 ; $011EC6
        CLR.L  (-24538).W                       ; $011ECC
        CLR.W  (-24532).W                       ; $011ED0
        MOVE.L  #$0402A060,(-24528).W           ; $011ED4
        MOVE.L  #$0402A020,(-24524).W           ; $011EDC
        JSR     $0088204A                       ; $011EE4
        MOVE.B  #$01,(-14303).W                 ; $011EEA
        ANDI.B  #$FC,$00A15181                  ; $011EF0
        ORI.B  #$01,$00A15181                   ; $011EF8
        MOVE.W  #$8083,$00A15100                ; $011F00
        BSET    #6,(-14219).W                   ; $011F08
        MOVE.W  (-14220).W,(A5)                 ; $011F0E
        MOVE.W  #$0018,$00FF0008                ; $011F12
        JSR     $00884998                       ; $011F1A
        MOVE.W  #$0000,(-14210).W               ; $011F20
        MOVE.L  #$00892056,$00FF0002            ; $011F26
        MOVE.B  #$8F,(-14171).W                 ; $011F30
        RTS                                     ; $011F36
