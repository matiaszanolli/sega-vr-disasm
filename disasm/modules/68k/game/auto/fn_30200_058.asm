; ============================================================================
; Fm 058 (auto-analyzed)
; ROM Range: $031528-$03154E (38 bytes)
; ============================================================================
; Category: sound
; Purpose: Short helper function
;   Object (A5): +$00, +$0D
;
; Entry: A5 = object/entity pointer
; Uses: D0, A4, A5
; Object fields:
;   +$00: [unknown]
;   +$0D: [unknown]
; Confidence: low
; ============================================================================

fn_30200_058:
        MOVEQ   #$00,D0                         ; $031528
        MOVE.B  $000D(A5),D0                    ; $03152A
        SUBQ.B  #4,D0                           ; $03152E
        MOVE.L  A4,$00(A5,D0.W)                 ; $031530
        MOVE.B  D0,$000D(A5)                    ; $031534
        DC.W    $60C8               ; BRA.S  $031502; $031538
        MOVEQ   #$00,D0                         ; $03153A
        MOVE.B  $000D(A5),D0                    ; $03153C
        MOVEA.L $00(A5,D0.W),A4                 ; $031540
        ADDQ.W  #2,A4                           ; $031544
        ADDQ.B  #4,D0                           ; $031546
        MOVE.B  D0,$000D(A5)                    ; $031548
        RTS                                     ; $03154C
