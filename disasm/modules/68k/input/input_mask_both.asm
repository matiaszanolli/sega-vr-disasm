; ============================================================================
; Input Mask — Both Players
; ROM Range: $0049EE-$004A0C (30 bytes)
; ============================================================================
;
; PURPOSE
; -------
; Masks both player input words to retain only direction bits (AND with
; $FF80), then clears both extended input longs. Used to filter out
; button presses while preserving directional state.
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC86C  P1 input state (word, masked with $FF80)
;   $FFFFC86E  P2 input state (word, masked with $FF80)
;   $FFFFC970  P1 extended input (long, set to $FFFF0000)
;   $FFFFC974  P2 extended input (long, set to $FFFF0000)
;
; Entry: No register inputs
; Exit:  Both inputs masked, extended cleared
; Uses:  (none modified beyond RAM writes)
; ============================================================================

input_mask_both:
        andi.w  #$FF80,($FFFFC86C).w           ; $0049EE: $0278 $FF80 $C86C — mask P1 direction bits
        andi.w  #$FF80,($FFFFC86E).w           ; $0049F4: $0278 $FF80 $C86E — mask P2 direction bits
        move.l  #$FFFF0000,($FFFFC970).w       ; $0049FA: $21FC $FFFF $0000 $C970 — clear P1 extended
        move.l  #$FFFF0000,($FFFFC974).w       ; $004A02: $21FC $FFFF $0000 $C974 — clear P2 extended
        rts                                     ; $004A0A: $4E75
