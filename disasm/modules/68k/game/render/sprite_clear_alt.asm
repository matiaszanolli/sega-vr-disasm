; ============================================================================
; Sprite Clear (Alternate Path)
; ROM Range: $00461A-$004630 (22 bytes)
; ============================================================================
; Clears position flag and sets alternate sprite attributes.
;
; Entry: A2 = sprite struct
; Uses: none
; ============================================================================

sprite_clear_alt:
        dc.w    $11FC,$0000,$C816     ; MOVE.B #$00,($C816).W
        move.l  #$0402C000,$0004(a2)  ; Set alternate attributes
        dc.w    $31FC,$0000,$B79C     ; MOVE.W #$0000,($B79C).W
        rts
