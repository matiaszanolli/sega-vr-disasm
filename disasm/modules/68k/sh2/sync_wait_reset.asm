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
.wait:  tst.b   COMM0_HI                ; Poll SH2 busy flag
        bne.s   .wait                   ;   (wait loop)
        clr.b   COMM1_LO                ; Clear SH2 status byte
        move.w  #$0000,($FFFFC87E).w   ; Reset state counter
        move.l  #$008926D2,$00FF0002    ; Store function pointer A
        tst.b   ($FFFFA018).w           ; Test flag
        bne.s   .done                   ; If set, keep pointer A
        move.l  #$0088D4B8,$00FF0002    ; Store function pointer B
.done:  rts
