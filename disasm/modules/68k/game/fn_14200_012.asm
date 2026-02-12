; ============================================================================
; Scroll X: Increment by 32
; ROM Range: $01470A-$01471A (16 bytes)
; ============================================================================
; Adds 32 ($20) to the horizontal scroll position and copies to SH2.
; Part of a group of 6 scroll adjustment functions (fn_14200_008-013).
;
; Memory:
;   $FFFFC054 = scroll X position (word)
;   $00FF6104 = scroll X shared memory mirror (word)
; Entry: none | Exit: scroll X incremented by 32 | Uses: D0
; ============================================================================

fn_14200_012:
        moveq   #$20,d0                         ; $01470A: $7020 — increment value (32)
        add.w   d0,($FFFFC054).w               ; $01470C: $D178 $C054 — scroll X += 32
        move.w  ($FFFFC054).w,$00FF6104         ; $014710: $33F8 $C054 $00FF $6104 — copy to SH2
        rts                                     ; $014718: $4E75
