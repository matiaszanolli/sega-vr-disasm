; ============================================================================
; Visibility Flag Set (Sprite Enable)
; ROM Range: $004682-$004696 (20 bytes)
; ============================================================================
; Sets sprite visibility at $FF69E0 based on bit 2 of $C8AB.
; If flag set: hidden (0). If clear: visible (7).
;
; Entry: none
; Uses: D0
; ============================================================================

visibility_flag_set:
        moveq   #0,d0                 ; Default: invisible
        dc.w    $0838,$0002,$C8AB     ; BTST #2,($C8AB).W
        bne.s   .write                ; If set, keep hidden
        moveq   #7,d0                 ; Else: visible (type 7)
.write:
        move.b  d0,$00FF69E0          ; Set sprite enable/type
        rts
