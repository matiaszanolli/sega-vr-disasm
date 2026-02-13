; ============================================================================
; Scroll X: Increment by 1
; ROM Range: $0146CA-$0146DA (16 bytes)
; ============================================================================
; Adds 1 to the horizontal scroll position and copies to SH2 shared memory.
; Part of a group of 6 scroll adjustment functions (scroll_x_inc_by_1-013).
;
; Memory:
;   $FFFFC054 = scroll X position (word)
;   $00FF6104 = scroll X shared memory mirror (word)
; Entry: none | Exit: scroll X incremented | Uses: D0
; ============================================================================

scroll_x_inc_by_1:
        moveq   #$01,d0                         ; $0146CA: $7001 — increment value
        add.w   d0,($FFFFC054).w               ; $0146CC: $D178 $C054 — scroll X += 1
        move.w  ($FFFFC054).w,$00FF6104         ; $0146D0: $33F8 $C054 $00FF $6104 — copy to SH2
        rts                                     ; $0146D8: $4E75
