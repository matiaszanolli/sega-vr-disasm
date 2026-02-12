; ============================================================================
; Input Clear — Both Players
; ROM Range: $0049AA-$0049C8 (30 bytes)
; ============================================================================
;
; PURPOSE
; -------
; Clears input state for both players. Sets P1/P2 input words to $FF00
; (preserving high byte, clearing low byte) and resets both extended
; input longs to $FFFF0000.
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC86C  P1 input state (word, set to $FF00)
;   $FFFFC86E  P2 input state (word, set to $FF00)
;   $FFFFC970  P1 extended input (long, set to $FFFF0000)
;   $FFFFC974  P2 extended input (long, set to $FFFF0000)
;
; Entry: No register inputs
; Exit:  Both player inputs cleared
; Uses:  (none modified beyond RAM writes)
; ============================================================================

input_clear_both:
        move.w  #$FF00,($FFFFC86C).w           ; $0049AA: $31FC $FF00 $C86C — clear P1 input
        move.w  #$FF00,($FFFFC86E).w           ; $0049B0: $31FC $FF00 $C86E — clear P2 input
        move.l  #$FFFF0000,($FFFFC970).w       ; $0049B6: $21FC $FFFF $0000 $C970 — clear P1 extended
        move.l  #$FFFF0000,($FFFFC974).w       ; $0049BE: $21FC $FFFF $0000 $C974 — clear P2 extended
        rts                                     ; $0049C6: $4E75
