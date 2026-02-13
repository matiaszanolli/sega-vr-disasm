; ============================================================================
; State 009 (auto-analyzed)
; ROM Range: $00837A-$00838A (16 bytes)
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

fn_8200_009:
        MOVE.L  (A3),(A4)                       ; $00837A
        MOVE.L  D5,$0004(A4)                    ; $00837C
        DC.W    $4EBA,$30F6         ; JSR     $00B478(PC); $008380
        MOVEQ   #$02,D0                         ; $008384
        MOVEQ   #$0D,D1                         ; $008386
        RTS                                     ; $008388
