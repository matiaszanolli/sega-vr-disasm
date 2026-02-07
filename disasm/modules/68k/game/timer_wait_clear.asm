; ============================================================================
; Timer Wait and Clear Sprite
; ROM Range: $00432E-$00434A (28 bytes)
; ============================================================================
; Waits 60 frames, then advances state, resets counter, disables sprite.
;
; Entry: none
; Uses: none (modifies memory only)
; ============================================================================

timer_wait_clear:
        dc.w    $0C78,$003C,$C8AA     ; CMPI.W #$003C,($C8AA).W
        bne.s   .done                 ; If not 60, skip
        dc.w    $5878,$C07C           ; ADDQ.W #4,($C07C).W
        dc.w    $31FC,$0000,$C8AA     ; MOVE.W #$0000,($C8AA).W
        move.w  #$0000,$00FF6754      ; Disable sprite
.done:
        rts
