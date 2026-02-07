; ============================================================================
; Joypad 3-Button Fallback
; ROM Range: $0018C8-$0018D6 (16 bytes)
; ============================================================================
; 3-button controller exit path. Masks result to low 8 bits
; (no ZYXM buttons), resets controller TH line, releases Z80 bus.
;
; Entry: D0 = raw button state, D5 = $00FF mask, D7 = $40 (TH=1)
;        A1 = joypad data port
; Exit: D0 = masked button state (low 8 bits only)
; ============================================================================

joypad_read_3btn:
        not.w   d0                      ; Complement (active low -> high)
        and.w   d5,d0                   ; Mask to 8-bit (3-button only)
        move.b  d7,(a1)                 ; TH=1 (reset controller state)
        move.w  #$0000,$00A11100        ; Release Z80 bus
        rts
