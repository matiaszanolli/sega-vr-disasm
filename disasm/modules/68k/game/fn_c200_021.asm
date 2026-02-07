; ============================================================================
; Scene Sh2 Comm 021 (auto-analyzed)
; ROM Range: $00D1D4-$00D3FC (552 bytes)
; ============================================================================
; Category: game
; Purpose: RAM: $C8A0 (race_state), $C89C (sh2_comm_state)
;   Object (A0): +$00
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, D2, D4, D7, A0, A1, A2
; RAM:
;   $C89C: sh2_comm_state
;   $C8A0: race_state
; Object fields:
;   +$00: [unknown]
; Confidence: high
; ============================================================================

fn_c200_021:
        MOVE.W  #$0100,$00A11100                ; $00D1D4
.loc_0008:
        BTST    #0,$00A11100                    ; $00D1DC
        BNE.S  .loc_0008                        ; $00D1E4
        MOVE.W  (-14220).W,D4                   ; $00D1E6
        BSET    #4,D4                           ; $00D1EA
        MOVE.W  D4,(A5)                         ; $00D1EE
        MOVE.W  #$8F01,(A5)                     ; $00D1F0
        MOVE.L  #$93FF941F,(A5)                 ; $00D1F4
        MOVE.W  #$9780,(A5)                     ; $00D1FA
        MOVE.L  #$60000082,(A5)                 ; $00D1FE
        MOVE.W  #$0000,(A6)                     ; $00D204
.loc_0034:
        MOVE.W  (A5),D7                         ; $00D208
        ANDI.W  #$0002,D7                       ; $00D20A
        BNE.S  .loc_0034                        ; $00D20E
        MOVE.W  #$8F02,(A5)                     ; $00D210
        MOVE.W  (-14220).W,(A5)                 ; $00D214
        MOVE.W  #$0000,$00A11100                ; $00D218
        MOVEQ   #$07,D0                         ; $00D220
        JSR     $008814BE                       ; $00D222
        MOVE.W  #$0100,$00A11100                ; $00D228
.loc_005C:
        BTST    #0,$00A11100                    ; $00D230
        BNE.S  .loc_005C                        ; $00D238
        MOVE.W  (-14220).W,D4                   ; $00D23A
        BSET    #4,D4                           ; $00D23E
        MOVE.W  D4,(A5)                         ; $00D242
        MOVE.L  #$93409400,(A5)                 ; $00D244
        MOVE.L  #$954096C2,(A5)                 ; $00D24A
        MOVE.W  #$977F,(A5)                     ; $00D250
        MOVE.W  #$C000,(A5)                     ; $00D254
        MOVE.W  #$0080,(-14218).W               ; $00D258
        MOVE.W  (-14218).W,(A5)                 ; $00D25E
        MOVE.W  (-14220).W,(A5)                 ; $00D262
        MOVE.W  #$0000,$00A11100                ; $00D266
        MOVE.W  (-14176).W,D0                   ; $00D26E
        DC.W    $41FA,$0188         ; LEA     $00D3FC(PC),A0; $00D272
        MOVE.L  $00(A0,D0.W),D0                 ; $00D276
        JSR     $008815EA                       ; $00D27A
        MOVE.W  #$0100,$00A11100                ; $00D280
.loc_00B4:
        BTST    #0,$00A11100                    ; $00D288
        BNE.S  .loc_00B4                        ; $00D290
        MOVE.W  (-14220).W,D4                   ; $00D292
        BSET    #4,D4                           ; $00D296
        MOVE.W  D4,(A5)                         ; $00D29A
        MOVE.L  #$93009420,(A5)                 ; $00D29C
        MOVE.L  #$95009688,(A5)                 ; $00D2A2
        MOVE.W  #$977F,(A5)                     ; $00D2A8
        MOVE.W  #$4220,(A5)                     ; $00D2AC
        MOVE.W  #$0080,(-14218).W               ; $00D2B0
        MOVE.W  (-14218).W,(A5)                 ; $00D2B6
        MOVE.W  (-14220).W,(A5)                 ; $00D2BA
        MOVE.W  #$0000,$00A11100                ; $00D2BE
        MOVE.W  (-14180).W,D1                   ; $00D2C6
        LSL.W  #2,D1                            ; $00D2CA
        DC.W    $41FA,$0146         ; LEA     $00D414(PC),A0; $00D2CC
        MOVE.L  $00(A0,D1.W),D1                 ; $00D2D0
        JSR     $0088155E                       ; $00D2D4
        MOVE.W  #$8B00,(A5)                     ; $00D2DA
        MOVEQ   #$00,D0                         ; $00D2DE
        MOVEQ   #-$08,D1                        ; $00D2E0
        TST.B  (-14321).W                       ; $00D2E2
        BEQ.S  .loc_0156                        ; $00D2E6
        MOVEQ   #$00,D0                         ; $00D2E8
        MOVEQ   #$00,D1                         ; $00D2EA
        LEA     $00FF1400,A1                    ; $00D2EC
        LEA     $00FF1000,A2                    ; $00D2F2
        JSR     $008848CA                       ; $00D2F8
        JSR     $008848CE                       ; $00D2FE
        JSR     $008848D2                       ; $00D304
        LEA     $00FF1200,A1                    ; $00D30A
        JSR     $008848CA                       ; $00D310
        JSR     $008848CE                       ; $00D316
        JSR     $008848D2                       ; $00D31C
        MOVE.W  #$8B03,(A5)                     ; $00D322
        DC.W    $6100,$0112         ; BSR.W  $00D43A; $00D326
.loc_0156:
        MOVE.W  #$0100,$00A11100                ; $00D32A
.loc_015E:
        BTST    #0,$00A11100                    ; $00D332
        BNE.S  .loc_015E                        ; $00D33A
        MOVE.W  (-14220).W,D4                   ; $00D33C
        BSET    #4,D4                           ; $00D340
        MOVE.W  D4,(A5)                         ; $00D344
        MOVE.L  #$9300940E,(A5)                 ; $00D346
        MOVE.L  #$95009688,(A5)                 ; $00D34C
        MOVE.W  #$977F,(A5)                     ; $00D352
        MOVE.W  #$4000,(A5)                     ; $00D356
        MOVE.W  #$0083,(-14218).W               ; $00D35A
        MOVE.W  (-14218).W,(A5)                 ; $00D360
        MOVE.W  (-14220).W,(A5)                 ; $00D364
        MOVE.W  #$0000,$00A11100                ; $00D368
        BTST    #3,(-14322).W                   ; $00D370
        BEQ.S  .loc_0206                        ; $00D376
        MOVEQ   #$00,D1                         ; $00D378
        MOVE.L  #$000000B0,D2                   ; $00D37A
        MOVEQ   #$1B,D7                         ; $00D380
        LEA     $00FF1A50,A1                    ; $00D382
.loc_01B4:
        JSR     $0088485E                       ; $00D388
        ADDA.L  D2,A1                           ; $00D38E
        DBRA    D7,.loc_01B4                    ; $00D390
        MOVE.W  #$0100,$00A11100                ; $00D394
.loc_01C8:
        BTST    #0,$00A11100                    ; $00D39C
        BNE.S  .loc_01C8                        ; $00D3A4
        MOVE.W  (-14220).W,D4                   ; $00D3A6
        BSET    #4,D4                           ; $00D3AA
        MOVE.W  D4,(A5)                         ; $00D3AE
        MOVE.L  #$9300940E,(A5)                 ; $00D3B0
        MOVE.L  #$9500968D,(A5)                 ; $00D3B6
        MOVE.W  #$977F,(A5)                     ; $00D3BC
        MOVE.W  #$6000,(A5)                     ; $00D3C0
        MOVE.W  #$0082,(-14218).W               ; $00D3C4
        MOVE.W  (-14218).W,(A5)                 ; $00D3CA
        MOVE.W  (-14220).W,(A5)                 ; $00D3CE
        MOVE.W  #$0000,$00A11100                ; $00D3D2
.loc_0206:
        MOVE.W  #$FFFC,(-14208).W               ; $00D3DA
        MOVE.W  D1,(-14206).W                   ; $00D3E0
        MOVE.W  D0,(-32768).W                   ; $00D3E4
        MOVE.W  D0,(-32766).W                   ; $00D3E8
        MOVE.L  #$40000010,(A5)                 ; $00D3EC
        MOVE.W  (-14208).W,(A6)                 ; $00D3F2
        MOVE.W  (-14206).W,(A6)                 ; $00D3F6
        RTS                                     ; $00D3FA
