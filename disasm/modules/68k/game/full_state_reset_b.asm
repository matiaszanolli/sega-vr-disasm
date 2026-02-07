; ============================================================================
; Full State Reset (Race Mode)
; ROM Range: $0047E4-$00482A (70 bytes)
; ============================================================================
; Full state reset for race mode. Conditionally initializes lap value,
; clears all state counters/flags, sets display params and execution vector.
;
; Entry: none
; Uses: D0
; ============================================================================

full_state_reset_b:
        dc.w    $0838,$0005,$C30E     ; BTST #5,($C30E).W - mode flag
        bne.s   .skip_lap             ; If set, skip lap init
        dc.w    $21FC,$6000,$0000,$C260 ; MOVE.L #$60000000,($C260).W
.skip_lap:
        dc.w    $0238,$007F,$C80E     ; ANDI.B #$7F,($C80E).W - clear bit 7
        dc.w    $31FC,$0000,$C87E     ; MOVE.W #$0000,($C87E).W
        moveq   #0,d0
        dc.w    $31C0,$C880           ; MOVE.W D0,($C880).W
        dc.w    $31C0,$C882           ; MOVE.W D0,($C882).W
        dc.w    $31FC,$0000,$C8A8     ; MOVE.W #$0000,($C8A8).W
        move.w  #$0020,$00FF0008      ; Set display size
        dc.w    $11FC,$0000,$C800     ; MOVE.B #$00,($C800).W
        move.l  #$0088FB98,$00FF0002  ; Set execution vector
        rts
