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
        cmpi.w  #$003C,($FFFFC8AA).w    ; $0C78 $003C $C8AA
        bne.s   .done                 ; If not 60, skip
        addq.w  #4,($FFFFC07C).w        ; $5878 $C07C
        move.w  #$0000,($FFFFC8AA).w    ; $31FC $0000 $C8AA
        move.w  #$0000,$00FF6754      ; Disable sprite
.done:
        rts
