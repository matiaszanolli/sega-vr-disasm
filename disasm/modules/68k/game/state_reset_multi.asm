; ============================================================================
; Comprehensive State Reset
; ROM Range: $0044A6-$0044E8 (66 bytes)
; ============================================================================
; Clears control flags, counters, display params, and sets execution vector.
;
; Entry: none
; Uses: D0
; ============================================================================

state_reset_multi:
        dc.w    $0238,$0077,$C80E     ; ANDI.B #$77,($C80E).W - clear bits 7,3
        dc.w    $31FC,$0000,$C87E     ; MOVE.W #$0000,($C87E).W
        dc.w    $31FC,$0000,$C8A8     ; MOVE.W #$0000,($C8A8).W
        moveq   #0,d0
        dc.w    $31C0,$C880           ; MOVE.W D0,($C880).W
        dc.w    $31C0,$C882           ; MOVE.W D0,($C882).W
        move.w  #$0020,$00FF0008      ; Set display size
        dc.w    $0238,$00C7,$C80E     ; ANDI.B #$C7,($C80E).W - clear bits 5,4,3
        dc.w    $11FC,$0000,$C800     ; MOVE.B #$00,($C800).W
        dc.w    $08B8,$0003,$C80E     ; BCLR #3,($C80E).W
        move.l  #$008909AE,$00FF0002  ; Set jump vector
        rts
