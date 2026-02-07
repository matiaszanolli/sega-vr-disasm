; ============================================================================
; Sh2 Comm Dma Transfer 024 (auto-analyzed)
; ROM Range: $012A72-$012BFA (392 bytes)
; ============================================================================
; Category: sh2
; Purpose: Accesses 32X registers: COMM0
;   RAM: $C87E (game_state)
;   Calls: dma_transfer
;   Object (A0, A1): +$00, +$02 (flags/type), +$04 (speed_index/velocity), +$06 (speed), +$08, +$0A (param_a)
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, D1, D7, A0, A1, A2
; RAM:
;   $C87E: game_state
; Calls:
;   $00E52C: dma_transfer
; Object fields:
;   +$00: [unknown]
;   +$02: flags/type
;   +$04: speed_index/velocity
;   +$06: speed
;   +$08: [unknown]
;   +$0A: param_a
;   +$0C: [unknown]
;   +$0E: param_e
; Confidence: high
; ============================================================================

fn_12200_024:
        CLR.W  D0                               ; $012A72
        DC.W    $6100,$BAB6         ; BSR.W  $00E52C; $012A74
        SUBQ.W  #1,(-24522).W                   ; $012A78
        BCC.W  .loc_0020                        ; $012A7C
        MOVE.W  #$0001,(-24522).W               ; $012A80
        SUBI.W  #$0080,(-24520).W               ; $012A86
        ANDI.W  #$1FFF,(-24520).W               ; $012A8C
.loc_0020:
        LEA     $00FF6E00,A0                    ; $012A92
        LEA     $00892C72,A1                    ; $012A98
        CLR.W  D0                               ; $012A9E
        MOVE.B  (-24551).W,D0                   ; $012AA0
        DC.W    $D040                           ; $012AA4
        DC.W    $D040                           ; $012AA6
        MOVEA.L $00(A1,D0.W),A1                 ; $012AA8
        MOVE.W  #$007F,D0                       ; $012AAC
.loc_003E:
        MOVE.W  (A1)+,(A0)+                     ; $012AB0
        DBRA    D0,.loc_003E                    ; $012AB2
        LEA     $00892C12,A0                    ; $012AB6
        LEA     (-24532).W,A1                   ; $012ABC
        CLR.L  D0                               ; $012AC0
        MOVE.B  (-24551).W,D0                   ; $012AC2
        LSL.W  #4,D0                            ; $012AC6
        ADDA.L  D0,A0                           ; $012AC8
        MOVE.W  #$0004,D1                       ; $012ACA
.loc_005C:
        MOVE.W  (A0)+,(A1)+                     ; $012ACE
        DBRA    D1,.loc_005C                    ; $012AD0
        MOVE.B  #$00,$00FF60D4                  ; $012AD4
        LEA     $00FF6100,A1                    ; $012ADC
        MOVE.W  #$0001,$0000(A1)                ; $012AE2
        MOVE.W  (-24532).W,$0002(A1)            ; $012AE8
        MOVE.W  (-24530).W,$0004(A1)            ; $012AEE
        MOVE.W  (-24528).W,$0006(A1)            ; $012AF4
        MOVE.L  (-24556).W,D0                   ; $012AFA
        MOVE.W  D0,$000A(A1)                    ; $012AFE
        MOVE.W  (-24526).W,$0008(A1)            ; $012B02
        MOVE.W  (-24524).W,$000C(A1)            ; $012B08
        MOVE.W  #$0000,$000E(A1)                ; $012B0E
        LEA     $00892BFA,A0                    ; $012B14
        CLR.W  D1                               ; $012B1A
        MOVE.B  (-24551).W,D1                   ; $012B1C
        CMPI.B  #$05,D1                         ; $012B20
        BNE.S  .loc_00BC                        ; $012B24
        MOVE.B  #$01,$00FF60D4                  ; $012B26
.loc_00BC:
        DC.W    $D241                           ; $012B2E
        DC.W    $D241                           ; $012B30
        MOVE.L  $00(A0,D1.W),$0010(A1)          ; $012B32
        ADDA.L  #$00000014,A1                   ; $012B38
        MOVE.W  #$0000,$0000(A1)                ; $012B3E
        CMPI.B  #$01,(-24551).W                 ; $012B44
        BNE.S  .loc_00F4                        ; $012B4A
        MOVE.W  #$0001,$0000(A1)                ; $012B4C
        MOVE.W  (-24520).W,$000A(A1)            ; $012B52
        MOVE.W  #$0000,$000E(A1)                ; $012B58
        MOVE.L  #$222B90F8,$0010(A1)            ; $012B5E
.loc_00F4:
        MOVE.W  #$0041,$00A15110                ; $012B66
        MOVE.B  #$04,$00A15107                  ; $012B6E
        CLR.B  $00A15123                        ; $012B76
        MOVE.B  #$2B,$00A15121                  ; $012B7C
        MOVE.B  #$01,$00A15120                  ; $012B84
.loc_011A:
        BTST    #1,$00A15123                    ; $012B8C
        BEQ.S  .loc_011A                        ; $012B94
        BCLR    #1,$00A15123                    ; $012B96
        LEA     $00FF60C8,A1                    ; $012B9E
        LEA     $00A15112,A2                    ; $012BA4
        MOVE.W  #$0040,D7                       ; $012BAA
.loc_013C:
        BTST    #7,$00A15107                    ; $012BAE
        BNE.S  .loc_013C                        ; $012BB6
        MOVE.W  (A1)+,(A2)                      ; $012BB8
        DBRA    D7,.loc_013C                    ; $012BBA
        MOVE.L  (-24556).W,D0                   ; $012BBE
        ADDI.L  #$00000080,D0                   ; $012BC2
        ANDI.L  #$0000FFFF,D0                   ; $012BC8
        MOVE.L  D0,(-24556).W                   ; $012BCE
        CLR.L  D0                               ; $012BD2
        ADD.L  (-24540).W,D0                    ; $012BD4
        ADD.L  D0,(-24544).W                    ; $012BD8
        SUBQ.W  #4,(-24536).W                   ; $012BDC
        BCC.W  .loc_017A                        ; $012BE0
        MOVE.L  #$00000000,(-24540).W           ; $012BE4
.loc_017A:
        ADDQ.W  #4,(-14210).W                   ; $012BEC
        MOVE.W  #$0020,$00FF0008                ; $012BF0
        RTS                                     ; $012BF8
