; ============================================================================
; Ai 013 (auto-analyzed)
; ROM Range: $00B3CE-$00B40E (64 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A3): +$00
;
; Entry: A3 = object/entity pointer
; Uses: D0, A1, A2, A3
; Object fields:
;   +$00: [unknown]
; Confidence: low
; ============================================================================

fn_a200_013:
        MOVEQ   #$00,D0                         ; $00B3CE
        MOVE.B  (A1)+,D0                        ; $00B3D0
        DC.W    $D040                           ; $00B3D2
        LEA     $00899884,A3                    ; $00B3D4
        MOVE.W  $00(A3,D0.W),D0                 ; $00B3DA
        MOVE.B  D0,(A2)+                        ; $00B3DE
        MOVEQ   #$00,D0                         ; $00B3E0
        MOVE.B  (A1)+,D0                        ; $00B3E2
        SUBI.B  #$C4,D0                         ; $00B3E4
        DC.W    $D040                           ; $00B3E8
        LEA     $00899884,A3                    ; $00B3EA
        MOVE.W  $00(A3,D0.W),D0                 ; $00B3F0
        MOVE.B  D0,(A2)+                        ; $00B3F4
        MOVEQ   #$00,D0                         ; $00B3F6
        MOVE.B  (A1)+,D0                        ; $00B3F8
        SUBI.B  #$C4,D0                         ; $00B3FA
        DC.W    $D040                           ; $00B3FE
        LEA     $0089980C,A3                    ; $00B400
        MOVE.W  $00(A3,D0.W),D0                 ; $00B406
        MOVE.W  D0,(A2)+                        ; $00B40A
        RTS                                     ; $00B40C
