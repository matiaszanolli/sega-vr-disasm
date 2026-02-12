; ============================================================================
; SH2 Handshake and State Advance
; ROM Range: $00DFEC-$00E00C (32 bytes)
; Source: code_c200
; ============================================================================
;
; PURPOSE
; -------
; Performs a synchronization handshake with the SH2 via 32X communication
; registers, then advances the state machine. If the status byte at $A018
; is already set, skips the handshake and just advances state.
;
; Handshake protocol:
;   1. Write config value $F3 to $C822 (sound/display config)
;   2. Busy-wait on COMM0 high byte ($A15120) until cleared by SH2
;   3. Clear COMM1 low byte ($A15123) to acknowledge
;
; MEMORY VARIABLES
; ----------------
;   $FFFFA018     Status byte (tested; if non-zero, skip handshake)
;   $FFFFC822     Configuration value (byte, set to $F3)
;   $00A15120     32X COMM0 register high byte (polled until zero)
;   $00A15123     32X COMM1 register low byte (cleared after handshake)
;   $FFFFC87E     State machine counter (word, advanced by 4)
;
; Entry: No register inputs
; Exit:  State advanced; SH2 handshake completed if needed
; Uses:  (none modified beyond RAM/register writes)
; ============================================================================

c200_func_024:
        tst.b   ($FFFFA018).w                   ; $00DFEC: $4A38 $A018 — check status byte
        bne.s   .advance                        ; $00DFF0: $6614 — non-zero: skip handshake
        move.b  #$F3,($FFFFC822).w              ; $00DFF2: $11FC $00F3 $C822 — set config value
.wait_sh2:
        tst.b   ($00A15120).l                   ; $00DFF8: $4A39 $00A1 $5120 — poll COMM0 high byte
        bne.s   .wait_sh2                       ; $00DFFE: $66F8 — busy-wait until SH2 clears it
        clr.b   ($00A15123).l                   ; $00E000: $4239 $00A1 $5123 — acknowledge: clear COMM1 low
.advance:
        addq.w  #4,($FFFFC87E).w               ; $00E006: $5878 $C87E — advance state machine
        rts                                     ; $00E00A: $4E75
