; ============================================================================
; Input Clear — P2 + P2 Extended
; ROM Range: $0049DE-$0049EE (16 bytes)
; ============================================================================
;
; PURPOSE
; -------
; Clears P2 input word to $FF00 and resets P2 extended input only.
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC86E  P2 input state (word, set to $FF00)
;   $FFFFC974  P2 extended input (long, set to $FFFF0000)
;
; Entry: No register inputs
; Exit:  P2 input + P2 extended cleared
; Uses:  (none modified beyond RAM writes)
; ============================================================================

input_clear_partial_b:
        move.w  #$FF00,($FFFFC86E).w           ; $0049DE: $31FC $FF00 $C86E — clear P2 input
        move.l  #$FFFF0000,($FFFFC974).w       ; $0049E4: $21FC $FFFF $0000 $C974 — clear P2 extended
        rts                                     ; $0049EC: $4E75
