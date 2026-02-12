; ============================================================================
; Input Mask — Both Players + P1 Extended Clear
; ROM Range: $004A0C-$004A22 (22 bytes)
; ============================================================================
;
; PURPOSE
; -------
; Masks P1/P2 input words to direction bits ($FF80) and clears P1
; extended input only.
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC86C  P1 input state (word, masked with $FF80)
;   $FFFFC86E  P2 input state (word, masked with $FF80)
;   $FFFFC970  P1 extended input (long, set to $FFFF0000)
;
; Entry: No register inputs
; Exit:  Both inputs masked, P1 extended cleared
; Uses:  (none modified beyond RAM writes)
; ============================================================================

input_mask_partial_a:
        andi.w  #$FF80,($FFFFC86C).w           ; $004A0C: $0278 $FF80 $C86C — mask P1 direction bits
        andi.w  #$FF80,($FFFFC86E).w           ; $004A12: $0278 $FF80 $C86E — mask P2 direction bits
        move.l  #$FFFF0000,($FFFFC970).w       ; $004A18: $21FC $FFFF $0000 $C970 — clear P1 extended
        rts                                     ; $004A20: $4E75
