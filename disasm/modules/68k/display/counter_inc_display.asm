; ============================================================================
; Counter Increment and Set Display Size
; ROM Range: $005772-$005780 (14 bytes)
; ============================================================================
; Advances sub-state counter by 4 and sets display viewport size.
;
; Entry: none
; Uses: none
; ============================================================================

counter_inc_display:
        dc.w    $5838,$C8C4           ; ADDQ.B #4,($C8C4).W
        move.w  #$0020,$00FF0008      ; Set display size = $20
        rts
