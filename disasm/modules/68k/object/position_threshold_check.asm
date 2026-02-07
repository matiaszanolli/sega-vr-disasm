; ============================================================================
; Position Threshold Check
; ROM Range: $007F50-$007F63 (20 bytes)
; ============================================================================
; Compares difference of two position fields against threshold 100.
; If difference > 100, decrements counter at A0+$2E and returns.
; Otherwise falls through to next function.
;
; Entry: A0 = object pointer
; Uses: D0
; Fields accessed:
;   A0+$24: Position value A
;   A0+$26: Position value B
;   A0+$2E: Counter (decremented if threshold exceeded)
; ============================================================================

position_threshold_check:
        move.w  $24(a0),d0              ; Load position A
        sub.w   $26(a0),d0              ; D0 = A - B
        cmpi.w  #$0064,d0              ; Compare with threshold 100
        ble.s   .fall_through           ; If <= 100, fall through
        subq.w  #1,$2E(a0)             ; Decrement counter
        rts                             ; Return (threshold exceeded)
.fall_through:
