; ============================================================================
; Sh2 Comm Palette Load 028 (auto-analyzed)
; ROM Range: $013054-$013292 (574 bytes)
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

fn_12200_028:
        MOVE.B  #$00,(-24551).W                 ; $013054
        BRA.W  .loc_0010                        ; $01305A
        MOVE.B  #$04,(-24551).W                 ; $01305E
.loc_0010:
        MOVE.W  #$002C,$00FF0008                ; $013064
        MOVE.W  #$002C,(-14214).W               ; $01306C
        BCLR    #6,(-14219).W                   ; $013072
        MOVE.W  (-14220).W,(A5)                 ; $013078
        MOVE.W  #$0083,$00A15100                ; $01307C
        ANDI.B  #$FC,$00A15181                  ; $013084
        JSR     $008826C8                       ; $01308C
        MOVE.L  #$000A0907,D0                   ; $013092
        JSR     $008814BE                       ; $013098
        MOVE.B  #$01,(-14323).W                 ; $01309E
        MOVEQ   #$00,D0                         ; $0130A4
        LEA     (-31616).W,A0                   ; $0130A6
        MOVEQ   #$1F,D1                         ; $0130AA
.loc_0058:
        MOVE.L  D0,(A0)+                        ; $0130AC
        DBRA    D1,.loc_0058                    ; $0130AE
        LEA     $00FF7B80,A0                    ; $0130B2
        MOVEQ   #$7F,D1                         ; $0130B8
.loc_0066:
        MOVE.L  D0,(A0)+                        ; $0130BA
        DBRA    D1,.loc_0066                    ; $0130BC
        MOVE.L  #$60000002,(A5)                 ; $0130C0
        MOVE.W  #$17FF,D1                       ; $0130C6
.loc_0076:
        MOVE.L  D0,(A6)                         ; $0130CA
        DBRA    D1,.loc_0076                    ; $0130CC
        JSR     $008849AA                       ; $0130D0
        CLR.W  (-14208).W                       ; $0130D6
        CLR.W  (-14206).W                       ; $0130DA
        CLR.W  (-32768).W                       ; $0130DE
        CLR.W  (-32766).W                       ; $0130E2
        CLR.W  (-24558).W                       ; $0130E6
        CLR.B  (-24552).W                       ; $0130EA
        JSR     $008849AA                       ; $0130EE
        MOVE.L  #$008BB57C,(-13972).W           ; $0130F4
        MOVE.B  #$01,(-14327).W                 ; $0130FC
        MOVE.B  #$01,(-14326).W                 ; $013102
        BSET    #6,(-14322).W                   ; $013108
        MOVE.B  #$01,(-14334).W                 ; $01310E
        MOVE.W  #$0001,(-24536).W               ; $013114
        LEA     $00FF1000,A0                    ; $01311A
        MOVE.W  #$037F,D0                       ; $013120
.loc_00D0:
        CLR.L  (A0)+                            ; $013124
        DBRA    D0,.loc_00D0                    ; $013126
        MOVE.W  #$0001,D0                       ; $01312A
        MOVE.W  #$0001,D1                       ; $01312E
        MOVE.W  #$0001,D2                       ; $013132
        MOVE.W  #$0026,D3                       ; $013136
        MOVE.W  #$001A,D4                       ; $01313A
        LEA     $00FF1000,A0                    ; $01313E
        DC.W    $4EBA,$B0E6         ; JSR     $00E22C(PC); $013144
        LEA     $00FF1000,A0                    ; $013148
        DC.W    $4EBA,$B1A0         ; JSR     $00E2F0(PC); $01314E
        DC.W    $4EBA,$B068         ; JSR     $00E1BC(PC); $013152
        BCLR    #7,$00A15181                    ; $013156
        LEA     $00FF6E00,A0                    ; $01315E
        ADDA.L  #$00000160,A0                   ; $013164
        LEA     $00893292,A1                    ; $01316A
        MOVE.W  #$003F,D0                       ; $013170
.loc_0120:
        MOVE.W  (A1)+,D1                        ; $013174
        BSET    #15,D1                          ; $013176
        MOVE.W  D1,(A0)+                        ; $01317A
        DBRA    D0,.loc_0120                    ; $01317C
        LEA     $00FF6E00,A0                    ; $013180
        ADDA.L  #$00000020,A0                   ; $013186
        MOVE.W  #$0000,(A0)                     ; $01318C
        LEA     $000EEB30,A0                    ; $013190
        MOVEA.L #$06018000,A1                   ; $013196
        DC.W    $4EBA,$B178         ; JSR     $00E316(PC); $01319C
        LEA     $000EEDD0,A0                    ; $0131A0
        MOVEA.L #$0601AD00,A1                   ; $0131A6
        DC.W    $4EBA,$B168         ; JSR     $00E316(PC); $0131AC
        LEA     $000EF210,A0                    ; $0131B0
        MOVEA.L #$0601DA00,A1                   ; $0131B6
        DC.W    $4EBA,$B158         ; JSR     $00E316(PC); $0131BC
        LEA     $000EF780,A0                    ; $0131C0
        MOVEA.L #$0601ED00,A1                   ; $0131C6
        DC.W    $4EBA,$B148         ; JSR     $00E316(PC); $0131CC
        LEA     $000F0C00,A0                    ; $0131D0
        MOVEA.L #$0602B780,A1                   ; $0131D6
        DC.W    $4EBA,$B138         ; JSR     $00E316(PC); $0131DC
        LEA     $000F1570,A0                    ; $0131E0
        MOVEA.L #$06030C00,A1                   ; $0131E6
        DC.W    $4EBA,$B128         ; JSR     $00E316(PC); $0131EC
        LEA     $000EF530,A0                    ; $0131F0
        MOVEA.L #$06036100,A1                   ; $0131F6
        DC.W    $4EBA,$B118         ; JSR     $00E316(PC); $0131FC
        CLR.W  D0                               ; $013200
        MOVE.B  (-599).W,D0                     ; $013202
        MOVE.W  D0,(-24550).W                   ; $013206
        MOVE.W  #$0000,(-24548).W               ; $01320A
        MOVE.W  #$0000,(-24546).W               ; $013210
        MOVE.W  #$0000,(-24544).W               ; $013216
        MOVE.W  #$0000,(-24542).W               ; $01321C
        MOVE.W  #$000F,$00FF2100                ; $013222
        MOVE.W  $00FF2100,(-24540).W            ; $01322A
        MOVE.W  #$0001,(-24538).W               ; $013232
        JSR     $0088204A                       ; $013238
        MOVE.B  #$01,(-14303).W                 ; $01323E
        ANDI.B  #$FC,$00A15181                  ; $013244
        ORI.B  #$01,$00A15181                   ; $01324C
        MOVE.W  #$8083,$00A15100                ; $013254
        JSR     $0088205E                       ; $01325C
        JSR     $00882080                       ; $013262
        BSET    #6,(-14219).W                   ; $013268
        MOVE.W  (-14220).W,(A5)                 ; $01326E
        MOVE.W  #$0018,$00FF0008                ; $013272
        JSR     $00884998                       ; $01327A
        MOVE.W  #$0000,(-14210).W               ; $013280
        MOVE.L  #$00893312,$00FF0002            ; $013286
        RTS                                     ; $013290
