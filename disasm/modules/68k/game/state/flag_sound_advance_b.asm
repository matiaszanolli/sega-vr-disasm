; ============================================================================
; Flag Set, Sound Config, Advance — SH2 Gate
; ROM Range: $0047CA-$0047E4 (26 bytes)
; ============================================================================
;
; PURPOSE
; -------
; Sets the process flag at $C048, then checks if the SH2 has completed
; (display bit 7 at $C80E). If display bit 7 is set, SH2 is still busy
; so we return early. Otherwise, writes sound/display config $F3 to
; $C822 and advances the state machine.
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC048  Process flag (word, set to 1)
;   $FFFFC80E  Display control flags (bit 7 tested)
;   $FFFFC822  Sound/display config (byte, set to $F3)
;   $FFFFC07C  State machine counter (word, advanced by 4)
;
; Entry: No register inputs
; Exit:  Process flag set; if SH2 idle: config written, state advanced
; Uses:  (none modified beyond RAM writes)
; ============================================================================

flag_sound_advance_b:
        move.w  #$0001,($FFFFC048).w           ; $0047CA: $31FC $0001 $C048 — set process flag
        btst    #7,($FFFFC80E).w               ; $0047D0: $0838 $0007 $C80E — SH2 busy?
        bne.s   .done                           ; $0047D6: $660A — yes: return early
        move.b  #$F3,($FFFFC822).w              ; $0047D8: $11FC $00F3 $C822 — write config value
        addq.w  #4,($FFFFC07C).w               ; $0047DE: $5878 $C07C — advance state machine
.done:
        rts                                     ; $0047E2: $4E75
