; ============================================================================
; Scroll Y: Decrement by 1
; ROM Range: $0146FA-$01470A (16 bytes)
; ============================================================================
; Subtracts 1 from the vertical scroll position and copies to SH2.
; Part of a group of 6 scroll adjustment functions (fn_14200_008-013).
;
; Memory:
;   $FFFFC056 = scroll Y position (word)
;   $00FF6106 = scroll Y shared memory mirror (word)
; Entry: none | Exit: scroll Y decremented | Uses: D0
; ============================================================================

fn_14200_011:
        moveq   #$01,d0                         ; $0146FA: $7001 — decrement value
        sub.w   d0,($FFFFC056).w               ; $0146FC: $9178 $C056 — scroll Y -= 1
        move.w  ($FFFFC056).w,$00FF6106         ; $014700: $33F8 $C056 $00FF $6106 — copy to SH2
        rts                                     ; $014708: $4E75
