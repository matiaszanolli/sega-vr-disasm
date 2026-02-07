; ============================================================================
; Vint Dispatch 065 (auto-analyzed)
; ROM Range: $003C2A-$003CCE (164 bytes)
; ============================================================================
; Category: vint
; Purpose: State dispatcher using jump table
;   RAM: $C8C8 (vint_state), $C8A0 (race_state), $C89E (sh2_comm_sub)
;   Object (A0, A1, A4): +$00, +$02 (flags/type), +$04 (speed_index/velocity), +$06 (speed), +$14 (effect_duration), +$31
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Entry: A4 = object/entity pointer
; Uses: D0, D1, D2, D5, A0, A1, A2, A3
; RAM:
;   $C89E: sh2_comm_sub
;   $C8A0: race_state
;   $C8C8: vint_state
; Object fields:
;   +$00: [unknown]
;   +$02: flags/type
;   +$04: speed_index/velocity
;   +$06: speed
;   +$14: effect_duration
;   +$31: [unknown]
;   +$35: [unknown]
; Confidence: medium
; ============================================================================

fn_2200_065:
        DC.W    $F190                           ; $003C2A
        DC.W    $09FA                           ; $003C2C
        DC.W    $F1F0                           ; $003C2E
        DC.W    $F190                           ; $003C30
        EORI.W  #$F1F0,D0                       ; $003C32
        ROXR.W  D5,D0                           ; $003C36
        DC.W    $03B3                           ; $003C38
        DC.W    $FB50                           ; $003C3A
        ASL.B  #4,D0                            ; $003C3C
        DC.W    $0AF0                           ; $003C3E
        DC.W    $0800                           ; $003C40
        ROXR.W  D5,D0                           ; $003C42
        DC.W    $03B3                           ; $003C44
        DC.W    $FB50                           ; $003C46
        DC.W    $F190                           ; $003C48
        DC.W    $09FA                           ; $003C4A
        DC.W    $F1F0                           ; $003C4C
        ORI.B  #$2B,$31(A0,D0.W)                ; $003C4E
        DC.W    $FFFD                           ; $003C54
        DC.W    $FFD7                           ; $003C56
        DC.W    $002B                           ; $003C58
        DC.W    $FFCE                           ; $003C5A
        DC.W    $FFFD                           ; $003C5C
        ORI.B  #$21,$35(A4,D0.W)                ; $003C5E
        DC.W    $FFF3                           ; $003C64
        DC.W    $FFD3                           ; $003C66
        DC.W    $0021                           ; $003C68
        DC.W    $FFCA                           ; $003C6A
        DC.W    $FFF3                           ; $003C6C
        ORI.B  #$17,$35(A4,D0.W)                ; $003C6E
        DC.W    $FFEE                           ; $003C74
        DC.W    $FFD3                           ; $003C76
        DC.W    $0017                           ; $003C78
        DC.W    $FFCA                           ; $003C7A
        DC.W    $FFEE                           ; $003C7C
        MOVE.W  (-14136).W,D0                   ; $003C7E
        LSL.W  #4,D0                            ; $003C82
        LEA     $003C4E(PC,D0.W),A2             ; $003C84
        MOVE.W  (-14176).W,D0                   ; $003C88
        ADD.W  (-14178).W,D0                    ; $003C8C
        LEA     $003C2A(PC,D0.W),A3             ; $003C90
        LEA     $00FF66DC,A1                    ; $003C94
        MOVEQ   #$01,D1                         ; $003C9A
        MOVEQ   #$03,D2                         ; $003C9C
.loc_0074:
        MOVE.W  D1,$0000(A1)                    ; $003C9E
        MOVE.W  (A3)+,D0                        ; $003CA2
        ADD.W  (A2)+,D0                         ; $003CA4
        MOVE.W  D0,$0002(A1)                    ; $003CA6
        MOVE.W  (A3)+,$0004(A1)                 ; $003CAA
        MOVE.W  (A3)+,D0                        ; $003CAE
        SUB.W  (A2)+,D0                         ; $003CB0
        MOVE.W  D0,$0006(A1)                    ; $003CB2
        LEA     $0014(A1),A1                    ; $003CB6
        SUBQ.W  #6,A3                           ; $003CBA
        DBRA    D2,.loc_0074                    ; $003CBC
        MOVEQ   #$00,D0                         ; $003CC0
        DC.W    $600A               ; BRA.S  $003CCE; $003CC2
        MOVEQ   #$00,D0                         ; $003CC4
        MOVE.W  (-16346).W,D0                   ; $003CC6
        DC.W    $6A02               ; BPL.S  $003CCE; $003CCA
        RTS                                     ; $003CCC
