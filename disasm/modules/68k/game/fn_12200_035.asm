; ============================================================================
; Sh2 Comm Palette Load 035 (auto-analyzed)
; ROM Range: $013864-$013A88 (548 bytes)
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

fn_12200_035:
        MOVE.W  #$002C,$00FF0008                ; $013864
        MOVE.W  #$002C,(-14214).W               ; $01386C
        BCLR    #6,(-14219).W                   ; $013872
        MOVE.W  (-14220).W,(A5)                 ; $013878
        MOVE.W  #$0083,$00A15100                ; $01387C
        ANDI.B  #$FC,$00A15181                  ; $013884
        JSR     $008826C8                       ; $01388C
        MOVE.L  #$000A0907,D0                   ; $013892
        JSR     $008814BE                       ; $013898
        MOVE.B  #$01,(-14323).W                 ; $01389E
        MOVEQ   #$00,D0                         ; $0138A4
        LEA     (-31616).W,A0                   ; $0138A6
        MOVEQ   #$1F,D1                         ; $0138AA
.loc_0048:
        MOVE.L  D0,(A0)+                        ; $0138AC
        DBRA    D1,.loc_0048                    ; $0138AE
        LEA     $00FF7B80,A0                    ; $0138B2
        MOVEQ   #$7F,D1                         ; $0138B8
.loc_0056:
        MOVE.L  D0,(A0)+                        ; $0138BA
        DBRA    D1,.loc_0056                    ; $0138BC
        MOVE.L  #$60000002,(A5)                 ; $0138C0
        MOVE.W  #$17FF,D1                       ; $0138C6
.loc_0066:
        MOVE.L  D0,(A6)                         ; $0138CA
        DBRA    D1,.loc_0066                    ; $0138CC
        JSR     $008849AA                       ; $0138D0
        CLR.W  (-14208).W                       ; $0138D6
        CLR.W  (-14206).W                       ; $0138DA
        CLR.W  (-32768).W                       ; $0138DE
        CLR.W  (-32766).W                       ; $0138E2
        CLR.W  (-24558).W                       ; $0138E6
        CLR.B  (-24552).W                       ; $0138EA
        JSR     $008849AA                       ; $0138EE
        MOVE.L  #$008BB57C,(-13972).W           ; $0138F4
        MOVE.B  #$01,(-14327).W                 ; $0138FC
        MOVE.B  #$01,(-14326).W                 ; $013902
        BSET    #6,(-14322).W                   ; $013908
        MOVE.B  #$01,(-14334).W                 ; $01390E
        MOVE.W  #$0001,(-24540).W               ; $013914
        LEA     $00FF1000,A0                    ; $01391A
        MOVE.W  #$037F,D0                       ; $013920
.loc_00C0:
        CLR.L  (A0)+                            ; $013924
        DBRA    D0,.loc_00C0                    ; $013926
        MOVE.W  #$0001,D0                       ; $01392A
        MOVE.W  #$0001,D1                       ; $01392E
        MOVE.W  #$0001,D2                       ; $013932
        MOVE.W  #$0026,D3                       ; $013936
        MOVE.W  #$001A,D4                       ; $01393A
        LEA     $00FF1000,A0                    ; $01393E
        DC.W    $4EBA,$A8E6         ; JSR     $00E22C(PC); $013944
        LEA     $00FF1000,A0                    ; $013948
        DC.W    $4EBA,$A9A0         ; JSR     $00E2F0(PC); $01394E
        DC.W    $4EBA,$A868         ; JSR     $00E1BC(PC); $013952
        BCLR    #7,$00A15181                    ; $013956
        LEA     $00FF6E00,A0                    ; $01395E
        LEA     $00893A88,A1                    ; $013964
        ADDQ.L  #2,A0                           ; $01396A
        MOVE.W  #$002E,D0                       ; $01396C
.loc_010C:
        MOVE.W  (A1)+,D1                        ; $013970
        BSET    #15,D1                          ; $013972
        MOVE.W  D1,(A0)+                        ; $013976
        DBRA    D0,.loc_010C                    ; $013978
        LEA     $00FF6E00,A0                    ; $01397C
        ADDA.L  #$00000140,A0                   ; $013982
        LEA     $00893B06,A1                    ; $013988
        MOVE.W  #$005F,D0                       ; $01398E
.loc_012E:
        MOVE.W  (A1)+,D1                        ; $013992
        BSET    #15,D1                          ; $013994
        MOVE.W  D1,(A0)+                        ; $013998
        DBRA    D0,.loc_012E                    ; $01399A
        LEA     $00FF6E00,A0                    ; $01399E
        ADDA.L  #$00000080,A0                   ; $0139A4
        MOVE.W  #$0000,(A0)                     ; $0139AA
        LEA     $00FF6E00,A0                    ; $0139AE
        ADDA.L  #$00000078,A0                   ; $0139B4
        MOVE.W  #$0000,(A0)                     ; $0139BA
        LEA     $000F35F0,A0                    ; $0139BE
        MOVEA.L #$06014000,A1                   ; $0139C4
        DC.W    $4EBA,$A94A         ; JSR     $00E316(PC); $0139CA
        LEA     $000F30D0,A0                    ; $0139CE
        BTST    #2,(-14312).W                   ; $0139D4
        BNE.S  .loc_018C                        ; $0139DA
        LEA     $000F1DB0,A0                    ; $0139DC
        BTST    #0,(-14312).W                   ; $0139E2
        BEQ.S  .loc_018C                        ; $0139E8
        LEA     $000F2710,A0                    ; $0139EA
.loc_018C:
        MOVEA.L #$06017CC0,A1                   ; $0139F0
        DC.W    $4EBA,$A91E         ; JSR     $00E316(PC); $0139F6
        LEA     $000F30D0,A0                    ; $0139FA
        BTST    #3,(-14312).W                   ; $013A00
        BNE.S  .loc_01B8                        ; $013A06
        LEA     $000F1DB0,A0                    ; $013A08
        BTST    #1,(-14312).W                   ; $013A0E
        BEQ.S  .loc_01B8                        ; $013A14
        LEA     $000F2710,A0                    ; $013A16
.loc_01B8:
        MOVEA.L #$0601DFC0,A1                   ; $013A1C
        DC.W    $4EBA,$A8F2         ; JSR     $00E316(PC); $013A22
        CLR.B  (-24551).W                       ; $013A26
        CLR.B  (-24550).W                       ; $013A2A
        CLR.W  (-24546).W                       ; $013A2E
        CLR.W  (-24544).W                       ; $013A32
        CLR.W  (-24542).W                       ; $013A36
        JSR     $0088204A                       ; $013A3A
        MOVE.B  #$01,(-14303).W                 ; $013A40
        ANDI.B  #$FC,$00A15181                  ; $013A46
        ORI.B  #$01,$00A15181                   ; $013A4E
        MOVE.W  #$8083,$00A15100                ; $013A56
        BSET    #6,(-14219).W                   ; $013A5E
        MOVE.W  (-14220).W,(A5)                 ; $013A64
        MOVE.W  #$0018,$00FF0008                ; $013A68
        JSR     $00884998                       ; $013A70
        MOVE.W  #$0000,(-14210).W               ; $013A76
        MOVE.L  #$00893BC6,$00FF0002            ; $013A7C
        RTS                                     ; $013A86
