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
        dc.w    $0838,$0007,$C80E     ; BTST #7,($C80E).W
        bne.s   .done                 ; If SH2 busy, skip
        move.w  #$8B00,(a5)           ; Write VDP register
        moveq   #0,d0
        dc.w    $11C0,$C304           ; MOVE.B D0,($C304).W
        dc.w    $11C0,$C30C           ; MOVE.B D0,($C30C).W
        dc.w    $5838,$C8C5           ; ADDQ.B #4,($C8C5).W
.done:
        rts
