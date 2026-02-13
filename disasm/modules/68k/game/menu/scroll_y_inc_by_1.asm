; ============================================================================
; Scroll Y: Increment by 1
; ROM Range: $0146EA-$0146FA (16 bytes)
; ============================================================================
; Adds 1 to the vertical scroll position and copies to SH2 shared memory.
; Part of a group of 6 scroll adjustment functions (scroll_x_inc_by_1-013).
;
; Memory:
;   $FFFFC056 = scroll Y position (word)
;   $00FF6106 = scroll Y shared memory mirror (word)
; Entry: none | Exit: scroll Y incremented | Uses: D0
; ============================================================================

scroll_y_inc_by_1:
        moveq   #$01,d0                         ; $0146EA: $7001 — increment value
        add.w   d0,($FFFFC056).w               ; $0146EC: $D178 $C056 — scroll Y += 1
        move.w  ($FFFFC056).w,$00FF6106         ; $0146F0: $33F8 $C056 $00FF $6106 — copy to SH2
        rts                                     ; $0146F8: $4E75
