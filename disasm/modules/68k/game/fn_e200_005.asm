; ============================================================================
; Sh2 Comm Palette Load 005 (auto-analyzed)
; ROM Range: $00F130-$00F39C (620 bytes)
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

fn_e200_005:
        MOVE.L  -$7E66(A0),D1                   ; $00F130
        MOVE.L  -$7DA4(A0),D1                   ; $00F134
        MOVE.L  -$7CE2(A0),D1                   ; $00F138
        BCLR    #7,(-600).W                     ; $00F13C
        MOVE.W  #$002C,$00FF0008                ; $00F142
        MOVE.W  #$002C,(-14214).W               ; $00F14A
        BCLR    #6,(-14219).W                   ; $00F150
        MOVE.W  (-14220).W,(A5)                 ; $00F156
        MOVE.W  #$0083,$00A15100                ; $00F15A
        ANDI.B  #$FC,$00A15181                  ; $00F162
        JSR     $008826C8                       ; $00F16A
        MOVE.L  #$000A0907,D0                   ; $00F170
        JSR     $008814BE                       ; $00F176
        MOVE.B  #$01,(-14323).W                 ; $00F17C
        MOVEQ   #$00,D0                         ; $00F182
        LEA     (-31616).W,A0                   ; $00F184
        MOVEQ   #$1F,D1                         ; $00F188
.loc_005A:
        MOVE.L  D0,(A0)+                        ; $00F18A
        DBRA    D1,.loc_005A                    ; $00F18C
        LEA     $00FF7B80,A0                    ; $00F190
        MOVEQ   #$7F,D1                         ; $00F196
.loc_0068:
        MOVE.L  D0,(A0)+                        ; $00F198
        DBRA    D1,.loc_0068                    ; $00F19A
        MOVE.L  #$60000002,(A5)                 ; $00F19E
        MOVE.W  #$17FF,D1                       ; $00F1A4
.loc_0078:
        MOVE.L  D0,(A6)                         ; $00F1A8
        DBRA    D1,.loc_0078                    ; $00F1AA
        JSR     $008849AA                       ; $00F1AE
        CLR.W  (-14208).W                       ; $00F1B4
        CLR.W  (-14206).W                       ; $00F1B8
        CLR.W  (-32768).W                       ; $00F1BC
        CLR.W  (-32766).W                       ; $00F1C0
        CLR.W  (-24558).W                       ; $00F1C4
        CLR.B  (-24552).W                       ; $00F1C8
        JSR     $008849AA                       ; $00F1CC
        MOVE.L  #$008BB4FC,(-13972).W           ; $00F1D2
        MOVE.B  #$01,(-14327).W                 ; $00F1DA
        MOVE.B  #$01,(-14326).W                 ; $00F1E0
        BSET    #6,(-14322).W                   ; $00F1E6
        MOVE.B  #$01,(-14334).W                 ; $00F1EC
        MOVE.W  #$0001,(-24540).W               ; $00F1F2
        LEA     $00FF1000,A0                    ; $00F1F8
        MOVE.W  #$037F,D0                       ; $00F1FE
.loc_00D2:
        CLR.L  (A0)+                            ; $00F202
        DBRA    D0,.loc_00D2                    ; $00F204
        MOVE.W  #$0001,D0                       ; $00F208
        MOVE.W  #$0001,D1                       ; $00F20C
        MOVE.W  #$0001,D2                       ; $00F210
        MOVE.W  #$0026,D3                       ; $00F214
        MOVE.W  #$0009,D4                       ; $00F218
        LEA     $00FF1000,A0                    ; $00F21C
        DC.W    $4EBA,$F008         ; JSR     $00E22C(PC); $00F222
        MOVE.W  #$0002,D0                       ; $00F226
        MOVE.W  #$0001,D1                       ; $00F22A
        MOVE.W  #$000B,D2                       ; $00F22E
        MOVE.W  #$0013,D3                       ; $00F232
        MOVE.W  #$0010,D4                       ; $00F236
        LEA     $00FF1000,A0                    ; $00F23A
        DC.W    $4EBA,$EFEA         ; JSR     $00E22C(PC); $00F240
        MOVE.W  #$0003,D0                       ; $00F244
        MOVE.W  #$0014,D1                       ; $00F248
        MOVE.W  #$000B,D2                       ; $00F24C
        MOVE.W  #$0013,D3                       ; $00F250
        MOVE.W  #$0010,D4                       ; $00F254
        LEA     $00FF1000,A0                    ; $00F258
        DC.W    $4EBA,$EFCC         ; JSR     $00E22C(PC); $00F25E
        LEA     $00FF1000,A0                    ; $00F262
        DC.W    $4EBA,$F086         ; JSR     $00E2F0(PC); $00F268
        DC.W    $4EBA,$EF4E         ; JSR     $00E1BC(PC); $00F26C
        BCLR    #7,$00A15181                    ; $00F270
        LEA     $00FF6E00,A0                    ; $00F278
        ADDA.L  #$00000160,A0                   ; $00F27E
        LEA     $0088F39C,A1                    ; $00F284
        MOVE.W  #$003F,D0                       ; $00F28A
.loc_015E:
        MOVE.W  (A1)+,D1                        ; $00F28E
        BSET    #15,D1                          ; $00F290
        MOVE.W  D1,(A0)+                        ; $00F294
        DBRA    D0,.loc_015E                    ; $00F296
        LEA     $000E9680,A0                    ; $00F29A
        MOVEA.L #$06038000,A1                   ; $00F2A0
        DC.W    $4EBA,$F06E         ; JSR     $00E316(PC); $00F2A6
        LEA     $000E9F60,A0                    ; $00F2AA
        MOVEA.L #$0603B600,A1                   ; $00F2B0
        DC.W    $4EBA,$F05E         ; JSR     $00E316(PC); $00F2B6
        LEA     $000EA080,A0                    ; $00F2BA
        MOVEA.L #$0603BC00,A1                   ; $00F2C0
        DC.W    $4EBA,$F04E         ; JSR     $00E316(PC); $00F2C6
        LEA     $000EA240,A0                    ; $00F2CA
        MOVEA.L #$0603C400,A1                   ; $00F2D0
        DC.W    $4EBA,$F03E         ; JSR     $00E316(PC); $00F2D6
        LEA     $000EA340,A0                    ; $00F2DA
        MOVEA.L #$0603C880,A1                   ; $00F2E0
        DC.W    $4EBA,$F02E         ; JSR     $00E316(PC); $00F2E6
        LEA     $000E90A0,A0                    ; $00F2EA
        MOVEA.L #$0603D780,A1                   ; $00F2F0
        DC.W    $4EBA,$F01E         ; JSR     $00E316(PC); $00F2F6
        LEA     $000EA5F0,A0                    ; $00F2FA
        MOVEA.L #$0603DE80,A1                   ; $00F300
        DC.W    $4EBA,$F00E         ; JSR     $00E316(PC); $00F306
        LEA     $000EA710,A0                    ; $00F30A
        MOVEA.L #$0603F200,A1                   ; $00F310
        DC.W    $4EBA,$EFFE         ; JSR     $00E316(PC); $00F316
        MOVE.B  (-24545).W,(-24551).W           ; $00F31A
        CLR.B  (-24549).W                       ; $00F320
        MOVE.B  (-333).W,(-24551).W             ; $00F324
        MOVE.B  (-336).W,(-24550).W             ; $00F32A
        MOVE.B  #$01,(-24548).W                 ; $00F330
        MOVE.B  (-337).W,(-24544).W             ; $00F336
        MOVE.B  (-336).W,(-24542).W             ; $00F33C
        MOVE.B  (-339).W,(-24543).W             ; $00F342
        MOVE.B  (-338).W,(-24541).W             ; $00F348
        JSR     $0088204A                       ; $00F34E
        ANDI.B  #$FC,$00A15181                  ; $00F354
        ORI.B  #$01,$00A15181                   ; $00F35C
        MOVE.W  #$8083,$00A15100                ; $00F364
        BSET    #6,(-14219).W                   ; $00F36C
        MOVE.W  (-14220).W,(A5)                 ; $00F372
        MOVE.W  #$0020,$00FF0008                ; $00F376
        JSR     $00884998                       ; $00F37E
        MOVE.W  #$0000,(-14210).W               ; $00F384
        MOVE.L  #$0088F41C,$00FF0002            ; $00F38A
        MOVE.B  #$81,(-14171).W                 ; $00F394
        RTS                                     ; $00F39A
