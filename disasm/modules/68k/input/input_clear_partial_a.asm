; ============================================================================
; Input Clear — Both Players + P1 Extended
; ROM Range: $0049C8-$0049DE (22 bytes)
; ============================================================================
;
; PURPOSE
; -------
; Clears P1/P2 input words to $FF00 and resets P1 extended input only.
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC86C  P1 input state (word, set to $FF00)
;   $FFFFC86E  P2 input state (word, set to $FF00)
;   $FFFFC970  P1 extended input (long, set to $FFFF0000)
;
; Entry: No register inputs
; Exit:  P1/P2 inputs + P1 extended cleared
; Uses:  (none modified beyond RAM writes)
; ============================================================================

input_clear_partial_a:
        move.w  #$FF00,($FFFFC86C).w           ; $0049C8: $31FC $FF00 $C86C — clear P1 input
        move.w  #$FF00,($FFFFC86E).w           ; $0049CE: $31FC $FF00 $C86E — clear P2 input
        move.l  #$FFFF0000,($FFFFC970).w       ; $0049D4: $21FC $FFFF $0000 $C970 — clear P1 extended
        rts                                     ; $0049DC: $4E75
