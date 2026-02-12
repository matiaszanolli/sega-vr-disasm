; ============================================================================
; Scroll Y: Increment by 32
; ROM Range: $01472A-$01473A (16 bytes)
; ============================================================================
; Adds 32 ($20) to the vertical scroll position and copies to SH2.
; Part of a group of 6 scroll adjustment functions (fn_14200_008-015).
;
; Memory:
;   $FFFFC056 = scroll Y position (word)
;   $00FF6106 = scroll Y shared memory mirror (word)
; Entry: none | Exit: scroll Y incremented by 32 | Uses: D0
; ============================================================================

fn_14200_014:
        moveq   #$20,d0                         ; $01472A: $7020 — increment value (32)
        add.w   d0,($FFFFC056).w               ; $01472C: $D178 $C056 — scroll Y += 32
        move.w  ($FFFFC056).w,$00FF6106         ; $014730: $33F8 $C056 $00FF $6106 — copy to SH2
        rts                                     ; $014738: $4E75
