; ============================================================================
; Fm 042 (auto-analyzed)
; ROM Range: $031188-$0311A8 (32 bytes)
; ============================================================================
; Category: sound
; Purpose: Short helper function
;   Object (A5, A6): +$10, +$12 (timer_12), +$1E
;
; Entry: A5 = object/entity pointer
; Entry: A6 = object/entity pointer
; Uses: D0, D1, A4, A5, A6
; Object fields:
;   +$10: [unknown]
;   +$12: timer_12
;   +$1E: [unknown]
; Confidence: low
; ============================================================================

fn_30200_042:
        MOVE.B  (A4)+,D0                        ; $031188
        EXT.W   D0                              ; $03118A
        MOVE.B  $10(A6,D0.W),D1                 ; $03118C
        DC.W    $D040                           ; $031190
        TST.B  D1                               ; $031192
        DC.W    $6720               ; BEQ.S  $0311B6; $031194
        DC.W    $6B10               ; BMI.S  $0311A8; $031196
        MOVE.W  $12(A6,D0.W),D1                 ; $031198
        ADD.W  D1,$001E(A5)                     ; $03119C
        MOVEQ   #$00,D1                         ; $0311A0
        MOVE.B  D1,$10(A6,D0.W)                 ; $0311A2
        RTS                                     ; $0311A6
