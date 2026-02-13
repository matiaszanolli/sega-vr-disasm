; ============================================================================
; Advance State and Clear Timer
; ROM Range: $004384-$004390 (12 bytes)
; ============================================================================
;
; PURPOSE
; -------
; Advances the state machine at $C07C by 4 and resets the frame counter
; at $C8AA to zero. Common state transition helper.
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC07C  State machine counter (word, advanced by 4)
;   $FFFFC8AA  Frame counter (word, cleared to 0)
;
; Entry: No register inputs
; Exit:  State advanced, timer cleared
; Uses:  (none modified beyond RAM writes)
; ============================================================================

advance_clear_timer:
        addq.w  #4,($FFFFC07C).w               ; $004384: $5878 $C07C — advance state machine
        move.w  #$0000,($FFFFC8AA).w            ; $004388: $31FC $0000 $C8AA — reset frame counter
        rts                                     ; $00438E: $4E75
