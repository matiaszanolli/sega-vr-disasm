; ============================================================================
; AI Timer Decrement + Conditional State Clear
; ROM Range: $00B964-$00B97A (22 bytes)
; ============================================================================
; Calls sub at $00B990, clears AI active flag ($C31C), decrements the
; AI timer at $C303. If timer reaches zero, clears the AI mode at $C064.
;
; Memory:
;   $FFFFC31C = AI active flag (byte, cleared)
;   $FFFFC303 = AI timer (byte, decremented)
;   $FFFFC064 = AI mode (byte, conditionally cleared)
; Entry: none | Exit: timer decremented | Uses: none
; ============================================================================

ai_timer_dec_cond_state_clear:
        dc.w    $612A                           ; BSR.S $00B990 ; $00B964: — call sub
        move.b  #$00,($FFFFC31C).w             ; $00B966: $11FC $0000 $C31C — clear AI active
        subq.b  #1,($FFFFC303).w               ; $00B96C: $5338 $C303 — decrement timer
        bne.s   .done                           ; $00B970: $6606 — not zero → done
        move.b  #$00,($FFFFC064).w             ; $00B972: $11FC $0000 $C064 — timer expired: clear mode
.done:
        rts                                     ; $00B978: $4E75
