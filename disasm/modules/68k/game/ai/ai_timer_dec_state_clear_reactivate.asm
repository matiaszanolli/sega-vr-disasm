; ============================================================================
; AI Timer Decrement + State Clear + Reactivate
; ROM Range: $00B97A-$00B990 (22 bytes)
; ============================================================================
; Calls sub at $00B990, decrements the AI timer at $C303. If timer
; reaches zero, clears AI mode ($C064) and sets AI active flag ($C31C).
;
; Memory:
;   $FFFFC303 = AI timer (byte, decremented)
;   $FFFFC064 = AI mode (byte, conditionally cleared)
;   $FFFFC31C = AI active flag (byte, conditionally set to 1)
; Entry: none | Exit: timer decremented | Uses: none
; ============================================================================

ai_timer_dec_state_clear_reactivate:
        dc.w    $6114                           ; BSR.S $00B990 ; $00B97A: — call sub
        subq.b  #1,($FFFFC303).w               ; $00B97C: $5338 $C303 — decrement timer
        bne.s   .done                           ; $00B980: $660C — not zero → done
        move.b  #$00,($FFFFC064).w             ; $00B982: $11FC $0000 $C064 — timer expired: clear mode
        move.b  #$01,($FFFFC31C).w             ; $00B988: $11FC $0001 $C31C — reactivate AI
.done:
        rts                                     ; $00B98E: $4E75
