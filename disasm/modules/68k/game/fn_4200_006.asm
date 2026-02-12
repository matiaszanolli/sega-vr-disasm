; ============================================================================
; Advance Input State
; ROM Range: $004566-$00456C (6 bytes)
; ============================================================================
; Advances the input/controller state machine by one step (4 = one entry).
;
; Memory: $FFFFC07C = input state index (word)
; Entry: none | Exit: state advanced | Uses: none
; ============================================================================

fn_4200_006:
        addq.w  #4,($FFFFC07C).w               ; $004566: $5878 $C07C — advance input state
        rts                                     ; $00456A: $4E75
