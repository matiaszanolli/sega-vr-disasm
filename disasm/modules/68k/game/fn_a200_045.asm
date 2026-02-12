; ============================================================================
; Advance AI State Machine
; ROM Range: $00BFD4-$00BFDE (10 bytes)
; ============================================================================
; Advances the AI state variable at $A0EA by 4 (jump table index step)
; and clears the AI sub-state at $A0EC. Identical to fn_a200_047.
;
; Memory:
;   $FFFFA0EA = AI state variable (word, incremented by 4)
;   $FFFFA0EC = AI sub-state (word, cleared)
; Entry: none | Exit: state advanced | Uses: none
; ============================================================================

fn_a200_045:
        addq.w  #4,($FFFFA0EA).w               ; $00BFD4: $5878 $A0EA — advance AI state
        clr.w   ($FFFFA0EC).w                   ; $00BFD8: $4278 $A0EC — clear sub-state
        rts                                     ; $00BFDC: $4E75
