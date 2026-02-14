; ============================================================================
; Speed Scale Simple
; ROM Range: $00B02C-$00B03A (14 bytes)
; ============================================================================
; Loads a value from RAM ($FF907E), scales it via speed_scale_calc,
; and stores the result to $FF674C.
;
; Uses: D0, D1
; RAM:
;   ($907E).W: Input value (sign-extended: $FFFF907E)
;   $FF674C: Output scaled value
; Calls: speed_scale_calc (via BSR.S)
; ============================================================================

speed_scale_simple:
        moveq   #0,d0                   ; Clear D0
        move.w  ($FFFF907E).w,d0        ; $3038 $907E — load raw value
        bsr.s   speed_scale_calc        ; Scale the value
        move.w  d0,$00FF674C            ; Store result
        rts
