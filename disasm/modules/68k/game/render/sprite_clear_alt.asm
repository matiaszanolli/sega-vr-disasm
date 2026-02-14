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
        move.b  #$00,($FFFFC816).w      ; $11FC $0000 $C816
        move.l  #$0402C000,$0004(a2)  ; Set alternate attributes
        move.w  #$0000,($FFFFB79C).w    ; $31FC $0000 $B79C
        rts
