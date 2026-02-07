; ============================================================================
; Set Effect Flag and Clear Sprite
; ROM Range: $004556-$004566 (16 bytes)
; ============================================================================
; Sets effect code $AB and disables sprite at $FF6940.
;
; Entry: none
; Uses: none
; ============================================================================

set_flag_clear_sprite:
        dc.w    $11FC,$00AB,$C8A5     ; MOVE.B #$AB,($C8A5).W
        move.b  #$00,$00FF6940        ; Clear sprite enable
        rts
