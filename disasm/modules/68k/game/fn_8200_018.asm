; ============================================================================
; State 018 (auto-analyzed)
; ROM Range: $008532-$008548 (22 bytes)
; ============================================================================
; Category: game
; Purpose: Short helper function
;   Object (A4): +$04 (speed_index/velocity)
;
; Entry: A4 = object/entity pointer
; Uses: D0, D1, D4, D5, A4
; Object fields:
;   +$04: speed_index/velocity
; Confidence: low
; ============================================================================

fn_8200_018:
        CMPI.L  #$003C0000,D0                   ; $008532
        MOVE.L  D5,(A4)                         ; $008538
        MOVE.L  D4,$0004(A4)                    ; $00853A
        DC.W    $4EBA,$2F38         ; JSR     $00B478(PC); $00853E
        MOVEQ   #$01,D0                         ; $008542
        MOVEQ   #$0C,D1                         ; $008544
        RTS                                     ; $008546
