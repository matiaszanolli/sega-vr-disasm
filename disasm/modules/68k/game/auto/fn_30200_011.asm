; ============================================================================
; Fm 011 (auto-analyzed)
; ROM Range: $030536-$03056A (52 bytes)
; ============================================================================
; Category: sound
; Purpose: Object (A0, A6): +$00, +$09, +$0A (param_a)
;
; Entry: A0 = object/entity pointer
; Entry: A6 = object/entity pointer
; Uses: D0, D1, D2, D3, A0, A1, A6
; Object fields:
;   +$00: [unknown]
;   +$09: [unknown]
;   +$0A: param_a
; Confidence: low
; ============================================================================

fn_30200_011:
        DC.W    $41FA,$25F8         ; LEA     $032B30(PC),A0; $030536
        LEA     $000A(A6),A1                    ; $03053A
        MOVE.B  $0000(A6),D3                    ; $03053E
        MOVE.B  (A1),D0                         ; $030542
        MOVE.B  D0,D1                           ; $030544
        CLR.B  (A1)                             ; $030546
        SUBI.B  #$81,D0                         ; $030548
        BCS.S  .loc_002A                        ; $03054C
        ANDI.W  #$007F,D0                       ; $03054E
        MOVE.B  $00(A0,D0.W),D2                 ; $030552
        CMP.B  D3,D2                            ; $030556
        BCS.S  .loc_002A                        ; $030558
        MOVE.B  D2,D3                           ; $03055A
        MOVE.B  D1,$0009(A6)                    ; $03055C
.loc_002A:
        TST.B  D3                               ; $030560
        BMI.S  .loc_0032                        ; $030562
        MOVE.B  D3,$0000(A6)                    ; $030564
.loc_0032:
        RTS                                     ; $030568
