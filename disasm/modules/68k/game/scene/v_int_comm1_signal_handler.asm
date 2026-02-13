; ============================================================================
; V-INT COMM1 Signal Handler
; ROM Range: $002010-$00203A (42 bytes)
; ============================================================================
; Checks COMM1 bit 0 for an SH2 signal. If set, clears the signal and
; checks if sub-sequence timer ($C8C5) equals $18 — if so, resets the
; main game state machine. Always clears the sub-sequence flag ($C8C4).
;
; Memory:
;   $FFFFC8C5 = sub-sequence timer value (byte, compared to $18)
;   $FFFFC8C4 = sub-sequence state flag (byte, cleared)
;   $FFFFC87E = main game state (word, conditionally cleared)
; Entry: A5 = VDP control port | Exit: D0 = (A5) | Uses: D0, A5
; ============================================================================

v_int_comm1_signal_handler:
        move.w  (A5),d0                         ; $002010: $3015 — read VDP status
        btst    #0,COMM1_LO                    ; $002012: $0838 $0000 $5123 — check SH2 signal
        beq.s   .done                           ; $00201A: $671C — no signal → return
        bclr    #0,COMM1_LO                    ; $00201C: $0878 $0000 $5123 — acknowledge signal
        cmpi.b  #$18,($FFFFC8C5).w             ; $002024: $0C38 $0018 $C8C5 — timer reached $18?
        bne.s   .clear_flag                     ; $00202A: $6606 — no → skip reset
        move.w  #$0000,($FFFFC87E).w           ; $00202C: $31FC $0000 $C87E — reset game state
.clear_flag:
        move.b  #$00,($FFFFC8C4).w             ; $002032: $11FC $0000 $C8C4 — clear sub-sequence flag
.done:
        rts                                     ; $002038: $4E75
