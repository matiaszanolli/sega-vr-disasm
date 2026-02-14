; ============================================================================
; Flag Check, VDP Init, Clear Display Mode
; ROM Range: $00584A-$005866 (28 bytes)
; ============================================================================
; Waits for SH2 completion, writes VDP register $8B00,
; clears display mode bytes, advances sub-state.
;
; Entry: A5 = VDP control port
; Uses: D0
; ============================================================================

flag_check_clear_init:
        btst    #7,($FFFFC80E).w        ; $0838 $0007 $C80E
        bne.s   .done                 ; If SH2 busy, skip
        move.w  #$8B00,(a5)           ; Write VDP register
        moveq   #0,d0
        move.b  d0,($FFFFC304).w        ; $11C0 $C304
        move.b  d0,($FFFFC30C).w        ; $11C0 $C30C
        addq.b  #4,($FFFFC8C5).w        ; $5838 $C8C5
.done:
        rts
