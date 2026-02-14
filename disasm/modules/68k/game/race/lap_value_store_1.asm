; ============================================================================
; Lap Value Store 1
; ROM Range: $00B632-$00B644 (18 bytes)
; ============================================================================
; If flag ($C30F).W is set, loads value from ($907A).W, adds 1,
; and stores the low byte to $FF692B.
;
; Uses: D0
; RAM:
;   ($C30F).W: Enable flag (must be non-zero)
;   ($907A).W: Input lap value
;   $FF692B: Output (byte)
; ============================================================================

lap_value_store_1:
        tst.b    ($FFFFC30F).w          ; $4A38 $C30F — check flag
        beq.s   .return                 ; If zero, skip
        move.w  ($FFFF907A).w,d0        ; $3038 $907A — load value
        addq.w  #1,d0                   ; Adjust +1
        move.b  d0,$00FF692B            ; Store result byte
.return:
        rts
