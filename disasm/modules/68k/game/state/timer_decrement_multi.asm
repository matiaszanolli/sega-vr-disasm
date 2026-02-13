; ============================================================================
; Timer Decrement Multi (8 Entity Timers)
; ROM Range: $008548-$00859A (82 bytes)
; ============================================================================
; Decrements 8 timer fields in entity (A0) if positive.
; Offsets: $98, $9A, $86, $80, $82, $84, $E6, $E8.
;
; Entry: A0 = entity
; Uses: none (modifies entity fields)
; ============================================================================

timer_decrement_multi:
        tst.w   $0098(a0)
        ble.s   .t1
        subq.w  #1,$0098(a0)
.t1:    tst.w   $009A(a0)
        ble.s   .t2
        subq.w  #1,$009A(a0)
.t2:    tst.w   $0086(a0)
        ble.s   .t3
        subq.w  #1,$0086(a0)
.t3:    tst.w   $0080(a0)
        ble.s   .t4
        subq.w  #1,$0080(a0)
.t4:    tst.w   $0082(a0)
        ble.s   .t5
        subq.w  #1,$0082(a0)
.t5:    tst.w   $0084(a0)
        ble.s   .t6
        subq.w  #1,$0084(a0)
.t6:    tst.w   $00E6(a0)
        ble.s   .t7
        subq.w  #1,$00E6(a0)
.t7:    tst.w   $00E8(a0)
        ble.s   .done
        subq.w  #1,$00E8(a0)
.done:  rts
