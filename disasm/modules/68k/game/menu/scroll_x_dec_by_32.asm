; ============================================================================
; Scroll X: Decrement by 32
; ROM Range: $01471A-$01472A (16 bytes)
; ============================================================================
; Subtracts 32 ($20) from the horizontal scroll position and copies to SH2.
; Part of a group of 6 scroll adjustment functions (scroll_x_inc_by_1-013).
;
; Memory:
;   $FFFFC054 = scroll X position (word)
;   $00FF6104 = scroll X shared memory mirror (word)
; Entry: none | Exit: scroll X decremented by 32 | Uses: D0
; ============================================================================

scroll_x_dec_by_32:
        moveq   #$20,d0                         ; $01471A: $7020 — decrement value (32)
        sub.w   d0,($FFFFC054).w               ; $01471C: $9178 $C054 — scroll X -= 32
        move.w  ($FFFFC054).w,$00FF6104         ; $014720: $33F8 $C054 $00FF $6104 — copy to SH2
        rts                                     ; $014728: $4E75
