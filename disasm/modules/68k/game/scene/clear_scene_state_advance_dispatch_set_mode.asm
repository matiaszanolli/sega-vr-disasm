; ============================================================================
; Clear Scene State + Advance Dispatch + Set Mode
; ROM Range: $003E64-$003E7E (26 bytes)
; ============================================================================
; Clears scene state ($C8AA), advances dispatch index ($C8AC) by 4,
; sends command $09 to SH2 shared memory ($FF6980), and sets the
; state variable ($C8A4) to $C0.
;
; Memory:
;   $FFFFC8AA = scene state (word, cleared)
;   $FFFFC8AC = state dispatch index (word, advanced by 4)
;   $00FF6980 = SH2 shared command byte (set to $09)
;   $FFFFC8A4 = state variable (byte, set to $C0)
; Entry: none | Exit: state advanced | Uses: none
; ============================================================================

clear_scene_state_advance_dispatch_set_mode:
        move.w  #$0000,($FFFFC8AA).w            ; $003E64: $31FC $0000 $C8AA — clear scene state
        addq.w  #4,($FFFFC8AC).w                ; $003E6A: $5878 $C8AC — advance dispatch index
        move.b  #$09,$00FF6980                  ; $003E6E: $13FC $0009 $00FF $6980 — SH2 command $09
        move.b  #$C0,($FFFFC8A4).w              ; $003E76: $11FC $00C0 $C8A4 — set state = $C0
        rts                                     ; $003E7C: $4E75

