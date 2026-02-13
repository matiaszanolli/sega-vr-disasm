; ============================================================================
; Advance AI State Machine (Duplicate)
; ROM Range: $00C01E-$00C028 (10 bytes)
; ============================================================================
; Advances the AI state variable at $A0EA by 4 (jump table index step)
; and clears the AI sub-state at $A0EC. Identical to advance_ai_state_machine_00bfd4.
;
; Memory:
;   $FFFFA0EA = AI state variable (word, incremented by 4)
;   $FFFFA0EC = AI sub-state (word, cleared)
; Entry: none | Exit: state advanced | Uses: none
; ============================================================================

advance_ai_state_machine_00c01e:
        addq.w  #4,($FFFFA0EA).w               ; $00C01E: $5878 $A0EA — advance AI state
        clr.w   ($FFFFA0EC).w                   ; $00C022: $4278 $A0EC — clear sub-state
        rts                                     ; $00C026: $4E75
