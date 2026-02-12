; ============================================================================
; Input Mask — P2 + P2 Extended Clear
; ROM Range: $004A22-$004A32 (16 bytes)
; ============================================================================
;
; PURPOSE
; -------
; Masks P2 input word to direction bits ($FF80) and clears P2 extended
; input only.
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC86E  P2 input state (word, masked with $FF80)
;   $FFFFC974  P2 extended input (long, set to $FFFF0000)
;
; Entry: No register inputs
; Exit:  P2 input masked, P2 extended cleared
; Uses:  (none modified beyond RAM writes)
; ============================================================================

input_mask_partial_b:
        andi.w  #$FF80,($FFFFC86E).w           ; $004A22: $0278 $FF80 $C86E — mask P2 direction bits
        move.l  #$FFFF0000,($FFFFC974).w       ; $004A28: $21FC $FFFF $0000 $C974 — clear P2 extended
        rts                                     ; $004A30: $4E75
