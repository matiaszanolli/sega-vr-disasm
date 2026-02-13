; ============================================================================
; Reset Timer and Advance State
; ROM Range: $003D9A-$003DA4 (12 bytes)
; ============================================================================
;
; PURPOSE
; -------
; Resets the frame counter at $C8AA to zero and advances the state
; machine at $C8AC by 4. Inverse order variant of advance_clear_timer.
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC8AA  Frame counter (word, cleared to 0)
;   $FFFFC8AC  State machine counter (word, advanced by 4)
;
; Entry: No register inputs
; Exit:  Timer cleared, state advanced
; Uses:  (none modified beyond RAM writes)
; ============================================================================

reset_timer_advance_state:
        move.w  #$0000,($FFFFC8AA).w            ; $003D9A: $31FC $0000 $C8AA — reset frame counter
        addq.w  #4,($FFFFC8AC).w                ; $003DA0: $5878 $C8AC — advance state machine
        rts                                     ; $003DA4: $4E75
