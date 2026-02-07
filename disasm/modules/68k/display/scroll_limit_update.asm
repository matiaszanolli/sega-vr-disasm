; ============================================================================
; Scroll Limit Update (Sprite Y Clamp)
; ROM Range: $00465C-$004682 (38 bytes)
; ============================================================================
; Scrolls sprite upward by 10/frame, clamping at Y=230.
; Advances state when limit reached.
;
; Entry: A0 = entity
; Uses: A2
; ============================================================================

scroll_limit_update:
        move.w  #$0014,$002C(a0)      ; Set timer in entity field
        lea     $00FF69E0,a2          ; Sprite structure
        subi.w  #$000A,$0002(a2)      ; Decrease Y by 10
        cmpi.w  #$00E6,$0002(a2)      ; Check if Y <= 230
        bgt.s   .done                 ; If > 230, skip
        move.w  #$00E6,$0002(a2)      ; Clamp Y to 230
        dc.w    $5878,$C07C           ; ADDQ.W #4,($C07C).W
.done:
        rts
