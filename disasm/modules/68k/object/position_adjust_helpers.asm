; ============================================================================
; Position Adjust Helpers
; ROM Range: $006D30-$006D4E (32 bytes)
; ============================================================================
; Six tiny leaf functions for return values and position adjustment.
; Contiguous cluster used by object/entity processing.
;
; Uses: D0, D1 (position helpers use D0 on A0 entity)
; Fields accessed:
;   A0+$30: Position X
;   A0+$34: Position Y
; ============================================================================

return_zero_d1:
        moveq   #0,d1                   ; Return D1 = 0
        rts

return_one_d1:
        moveq   #1,d1                   ; Return D1 = 1
        rts

sub_x_position:
        sub.w   d0,$30(a0)              ; Position X -= D0
        rts

add_x_position:
        add.w   d0,$30(a0)              ; Position X += D0
        rts

sub_y_position:
        sub.w   d0,$34(a0)              ; Position Y -= D0
        rts

add_y_position:
        add.w   d0,$34(a0)              ; Position Y += D0
        rts
