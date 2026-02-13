; ============================================================================
; Scroll Y: Decrement by 32
; ROM Range: $01473A-$01474A (16 bytes)
; ============================================================================
; Subtracts 32 ($20) from the vertical scroll position and copies to SH2.
; Part of a group of 6 scroll adjustment functions (scroll_x_inc_by_1-015).
;
; Memory:
;   $FFFFC056 = scroll Y position (word)
;   $00FF6106 = scroll Y shared memory mirror (word)
; Entry: none | Exit: scroll Y decremented by 32 | Uses: D0
; ============================================================================

scroll_y_dec_by_32:
        moveq   #$20,d0                         ; $01473A: $7020 — decrement value (32)
        sub.w   d0,($FFFFC056).w               ; $01473C: $9178 $C056 — scroll Y -= 32
        move.w  ($FFFFC056).w,$00FF6106         ; $014740: $33F8 $C056 $00FF $6106 — copy to SH2
        rts                                     ; $014748: $4E75
