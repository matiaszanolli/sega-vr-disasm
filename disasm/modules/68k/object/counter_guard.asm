; ============================================================================
; Counter Guard
; ROM Range: $006FFA-$007006 (14 bytes)
; ============================================================================
; Decrements a counter at A0+$92, tests object type field at A0+$06.
; If type is non-zero, branches to external handler at $A470.
; Otherwise returns.
;
; Entry: A0 = object pointer
; Uses: none (only modifies A0+$92)
; Fields accessed:
;   A0+$06: Object type field (tested)
;   A0+$92: Counter (decremented)
; ============================================================================

counter_guard:
        subq.w  #1,$92(a0)              ; Decrement counter
        tst.w   $06(a0)                 ; Test object type field
        dc.w    $6600,$346C             ; BNE.W $A470 (external handler)
        rts
