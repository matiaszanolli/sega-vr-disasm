; ============================================================================
; Lap Value Store 2
; ROM Range: $00B646-$00B658 (18 bytes)
; ============================================================================
; If flag ($FEB0).W is set, loads value from ($9F7A).W, adds 1,
; and stores the low byte to $FF691B.
;
; Uses: D0
; RAM:
;   ($FEB0).W: Enable flag (must be non-zero)
;   ($9F7A).W: Input lap value
;   $FF691B: Output (byte)
; ============================================================================

lap_value_store_2:
        dc.w    $4A38,$FEB0             ; TST.B ($FEB0).W - check flag
        beq.s   .return                 ; If zero, skip
        dc.w    $3038,$9F7A             ; MOVE.W ($9F7A).W,D0 - load value
        addq.w  #1,d0                   ; Adjust +1
        move.b  d0,$00FF691B            ; Store result byte
.return:
        rts
