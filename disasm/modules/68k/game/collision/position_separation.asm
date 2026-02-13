; ============================================================================
; Position Separation
; ROM Range: $00AFFE-$00B02A (44 bytes)
; ============================================================================
; Pushes two entities apart by 16 units on both X and Y axes.
; Direction is based on which entity has the larger coordinate.
;
; Entry: A0 = first entity, A1 = second entity
; Uses: D0, D1
; Fields accessed:
;   A0+$30: X position (modified)
;   A0+$34: Y position (modified)
;   A1+$30: X position (modified)
;   A1+$34: Y position (modified)
; ============================================================================

position_separation:
        moveq   #$10,d1                 ; Push distance = 16
        move.w  $30(a0),d0              ; Load X_a
        cmp.w   $30(a1),d0              ; Compare X_a vs X_b
        bgt.s   .x_positive             ; If X_a > X_b, push positive
        neg.w   d1                      ; Reverse direction
.x_positive:
        add.w   d1,$30(a0)              ; Push X_a away
        sub.w   d1,$30(a1)              ; Push X_b opposite
        moveq   #$10,d1                 ; Reset push distance = 16
        move.w  $34(a0),d0              ; Load Y_a
        cmp.w   $34(a1),d0              ; Compare Y_a vs Y_b
        bgt.s   .y_positive             ; If Y_a > Y_b, push positive
        neg.w   d1                      ; Reverse direction
.y_positive:
        add.w   d1,$34(a0)              ; Push Y_a away
        sub.w   d1,$34(a1)              ; Push Y_b opposite
        rts
