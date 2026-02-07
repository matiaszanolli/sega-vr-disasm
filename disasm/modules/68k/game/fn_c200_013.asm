; ============================================================================
; Scene Race 013 (auto-analyzed)
; ROM Range: $00CA9A-$00CC06 (364 bytes)
; ============================================================================
; Category: game
; Purpose: RAM: $C8C8 (vint_state), $C8CC (race_substate), $C8A0 (race_state)
;   Object (A1, A2, A3, A4, A6): +$00, +$01, +$02 (flags/type), +$06 (speed), +$0E (param_e), +$10
;
; Entry: A1 = object/entity pointer
; Entry: A2 = object/entity pointer
; Entry: A3 = object/entity pointer
; Entry: A4 = object/entity pointer
; Entry: A6 = object/entity pointer
; Uses: D0, D1, D4, D5, D7, A1, A2, A3
; RAM:
;   $C8A0: race_state
;   $C8C8: vint_state
;   $C8CC: race_substate
; Object fields:
;   +$00: [unknown]
;   +$01: [unknown]
;   +$02: flags/type
;   +$06: speed
;   +$0E: param_e
;   +$10: [unknown]
; Confidence: high
; ============================================================================

fn_c200_013:
        BSR.S  .loc_0036                        ; $00CA9A
        JMP     .loc_0130(PC)                   ; $00CA9C
        BSR.S  .loc_0036                        ; $00CAA0
        MOVE.W  #$004E,$00FF6744                ; $00CAA2
        MOVE.W  (-14136).W,D0                   ; $00CAAA
        BEQ.W  .loc_0130                        ; $00CAAE
        CMPI.W  #$0001,D0                       ; $00CAB2
        BNE.S  .loc_002A                        ; $00CAB6
        MOVE.W  #$0050,$00FF6744                ; $00CAB8
        JMP     .loc_0130(PC)                   ; $00CAC0
.loc_002A:
        MOVE.W  #$0050,$00FF6744                ; $00CAC4
        JMP     .loc_0130(PC)                   ; $00CACC
.loc_0036:
        MOVE.W  (-14132).W,D0                   ; $00CAD0
        LEA     $00898C68,A1                    ; $00CAD4
        MOVE.L  $00(A1,D0.W),$00FF6858          ; $00CADA
        DC.W    $43FA,$0012         ; LEA     $00CAF6(PC),A1; $00CAE2
        MOVEA.L $00(A1,D0.W),A1                 ; $00CAE6
        LEA     $00FF6740,A2                    ; $00CAEA
        JMP     $00884920                       ; $00CAF0
        DC.W    $0088                           ; $00CAF6
        DC.W    $CB02                           ; $00CAF8
        DC.W    $0088                           ; $00CAFA
        AND.B  D5,(A6)                          ; $00CAFC
        DC.W    $0088                           ; $00CAFE
        AND.B  D5,$0001(A2)                     ; $00CB00
        DC.W    $FF6C                           ; $00CB04
        ORI.B  #$00,$00(A6,D0.W)                ; $00CB06
        DC.W    $0000                           ; $00CB0C
        DC.W    $0800                           ; $00CB0E
        ORI.L  #$222959D6,D7                    ; $00CB10
        DC.W    $0001                           ; $00CB16
        DC.W    $FF6C                           ; $00CB18
        ORI.B  #$00,($0000).W                   ; $00CB1A
        DC.W    $0000                           ; $00CB20
        DC.W    $0800                           ; $00CB22
        ORI.L  #$222959D6,D4                    ; $00CB24
        DC.W    $0001                           ; $00CB2A
        DC.W    $FF6F                           ; $00CB2C
        ORI.B  #$00,($0000).W                   ; $00CB2E
        DC.W    $0000                           ; $00CB34
        DC.W    $0800                           ; $00CB36
        ORI.L  #$222959D6,D4                    ; $00CB38
        MOVE.W  (-14132).W,D0                   ; $00CB3E
        LEA     $00898C74,A1                    ; $00CB42
        MOVE.L  $00(A1,D0.W),$00FF6858          ; $00CB48
        MOVE.L  $00(A1,D0.W),$00FF69B8          ; $00CB50
        DC.W    $43FA,$0028         ; LEA     $00CB82(PC),A1; $00CB58
        MOVEA.L $00(A1,D0.W),A1                 ; $00CB5C
        LEA     $00FF631C,A2                    ; $00CB60
        JSR     $00884920                       ; $00CB66
        DC.W    $43FA,$0014         ; LEA     $00CB82(PC),A1; $00CB6C
        MOVEA.L $00(A1,D0.W),A1                 ; $00CB70
        LEA     $00FF654C,A2                    ; $00CB74
        JSR     $00884920                       ; $00CB7A
        BRA.S  .loc_0130                        ; $00CB80
        DC.W    $0088                           ; $00CB82
        DC.W    $CB8E                           ; $00CB84
        DC.W    $0088                           ; $00CB86
        AND.L  D5,-(A2)                         ; $00CB88
        DC.W    $0088                           ; $00CB8A
        AND.L  D5,$01(A6,D0.W)                  ; $00CB8C
        DC.W    $FF72                           ; $00CB90
        ORI.B  #$00,$0000(A3)                   ; $00CB92
        DC.W    $0000                           ; $00CB98
        DC.W    $0800                           ; $00CB9A
        ORI.W  #$2229,$59D6(A4)                 ; $00CB9C
        DC.W    $0001                           ; $00CBA2
        DC.W    $FF6C                           ; $00CBA4
        ORI.B  #$00,$0000(A4)                   ; $00CBA6
        DC.W    $0000                           ; $00CBAC
        DC.W    $0800                           ; $00CBAE
        DC.W    $0072                           ; $00CBB0
        MOVE.L  $59D6(A1),D1                    ; $00CBB2
        DC.W    $0001                           ; $00CBB6
        DC.W    $FF73                           ; $00CBB8
        ORI.B  #$00,$0000(A4)                   ; $00CBBA
        DC.W    $0000                           ; $00CBC0
        DC.W    $0800                           ; $00CBC2
        ORI.W  #$2229,$59D6(A3)                 ; $00CBC4
.loc_0130:
        MOVE.W  (-14176).W,D0                   ; $00CBCA
        LSL.W  #2,D0                            ; $00CBCE
        LEA     $00895668,A1                    ; $00CBD0
        LEA     $00(A1,D0.W),A1                 ; $00CBD6
        LEA     $00FF672C,A2                    ; $00CBDA
        MOVE.W  #$0001,$0000(A2)                ; $00CBE0
        MOVE.L  (A1)+,$0002(A2)                 ; $00CBE6
        MOVE.W  (A1)+,$0006(A2)                 ; $00CBEA
        MOVE.W  (A1)+,$000E(A2)                 ; $00CBEE
        MOVE.L  (A1),$0010(A2)                  ; $00CBF2
        BTST    #7,(-600).W                     ; $00CBF6
        BEQ.S  .loc_016A                        ; $00CBFC
        ADDI.W  #$0020,$0002(A2)                ; $00CBFE
.loc_016A:
        RTS                                     ; $00CC04
