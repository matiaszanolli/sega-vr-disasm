; ============================================================================
; Scroll X: Decrement by 1
; ROM Range: $0146DA-$0146EA (16 bytes)
; ============================================================================
; Subtracts 1 from the horizontal scroll position and copies to SH2.
; Part of a group of 6 scroll adjustment functions (scroll_x_inc_by_1-013).
;
; Memory:
;   $FFFFC054 = scroll X position (word)
;   $00FF6104 = scroll X shared memory mirror (word)
; Entry: none | Exit: scroll X decremented | Uses: D0
; ============================================================================

scroll_x_dec_by_1:
        moveq   #$01,d0                         ; $0146DA: $7001 — decrement value
        sub.w   d0,($FFFFC054).w               ; $0146DC: $9178 $C054 — scroll X -= 1
        move.w  ($FFFFC054).w,$00FF6104         ; $0146E0: $33F8 $C054 $00FF $6104 — copy to SH2
        rts                                     ; $0146E8: $4E75
