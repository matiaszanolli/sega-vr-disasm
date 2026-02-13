; ============================================================================
; Clear Object Flags + Reset State
; ROM Range: $007FDA-$007FEE (20 bytes)
; ============================================================================
; Clears bit 14 of the object flags at A0+$02, then zeroes out
; state variable $C04E and flag byte $C305.
;
; Memory:
;   $FFFFC04E = state variable (word, cleared)
;   $FFFFC305 = flag byte (byte, cleared)
; Entry: A0 = object pointer | Exit: flags/state reset | Uses: A0
; ============================================================================

clear_object_flags_reset_state:
        andi.w  #$BFFF,$0002(a0)                ; $007FDA: $0268 $BFFF $0002 — clear bit 14 of flags
        move.w  #$0000,($FFFFC04E).w           ; $007FE0: $31FC $0000 $C04E — clear state
        move.b  #$00,($FFFFC305).w             ; $007FE6: $11FC $0000 $C305 — clear flag
        rts                                     ; $007FEC: $4E75
