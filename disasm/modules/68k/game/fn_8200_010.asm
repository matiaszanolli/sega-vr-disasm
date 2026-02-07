; ============================================================================
; State 010 (auto-analyzed)
; ROM Range: $00838A-$00839A (16 bytes)
; ============================================================================
; Category: game
; Purpose: Short helper function
;   Object (A4): +$04 (speed_index/velocity)
;
; Entry: A4 = object/entity pointer
; Uses: D0, D1, D5, A3, A4
; Object fields:
;   +$04: speed_index/velocity
; Confidence: low
; ============================================================================

fn_8200_010:
        MOVE.L  D5,(A4)                         ; $00838A
        MOVE.L  (A3),$0004(A4)                  ; $00838C
        DC.W    $4EBA,$30E6         ; JSR     $00B478(PC); $008390
        MOVEQ   #$01,D0                         ; $008394
        MOVEQ   #$0C,D1                         ; $008396
        RTS                                     ; $008398
