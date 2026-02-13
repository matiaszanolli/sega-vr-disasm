; ============================================================================
; Clear Communication and State Variables
; ROM Range: $00204A-$00205E (20 bytes)
; ============================================================================
; Clears five state/communication variables to zero: $C8A4, $C822
; (comm ready flag), $C823, and $C8A2.
;
; Memory:
;   $FFFFC8A4 = state variable (word, cleared)
;   $FFFFC822 = comm/input ready flag (byte, cleared)
;   $FFFFC823 = comm flag extension (byte, cleared)
;   $FFFFC8A2 = state variable (word, cleared)
; Entry: none | Exit: variables cleared | Uses: D0
; ============================================================================

clear_communication_state_variables:
        moveq   #$00,d0                         ; $00204A: $7000 — zero
        move.w  d0,($FFFFC8A4).w               ; $00204C: $31C0 $C8A4 — clear state var
        move.b  d0,($FFFFC822).w               ; $002050: $11C0 $C822 — clear comm ready flag
        move.b  d0,($FFFFC823).w               ; $002054: $11C0 $C823 — clear comm flag ext
        move.w  d0,($FFFFC8A2).w               ; $002058: $31C0 $C8A2 — clear state var
        rts                                     ; $00205C: $4E75
