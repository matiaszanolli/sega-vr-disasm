; ============================================================================
; SH2 Sync Wait and State Reset
; ROM Range: $00F85C-$00F88C (48 bytes)
; ============================================================================
; Waits for SH2 to finish (polls $A15120), clears SH2 status, resets
; state counter, and selects function pointer based on ($A018) flag.
;
; Uses: None (modifies memory only)
; ============================================================================

sync_wait_reset:
.wait:  tst.b   $00A15120               ; Poll SH2 busy flag
        bne.s   .wait                   ;   (wait loop)
        clr.b   $00A15123               ; Clear SH2 status byte
        dc.w    $31FC,$0000,$C87E       ; MOVE.W #$0000,($C87E).W - reset state
        move.l  #$008926D2,$00FF0002    ; Store function pointer A
        dc.w    $4A38,$A018             ; TST.B ($A018).W - test flag
        bne.s   .done                   ; If set, keep pointer A
        move.l  #$0088D4B8,$00FF0002    ; Store function pointer B
.done:  rts
