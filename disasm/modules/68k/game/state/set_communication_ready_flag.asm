; ============================================================================
; Set Communication Ready Flag
; ROM Range: $00205E-$002066 (8 bytes)
; ============================================================================
; Sets the communication flag at $C822 to $F0, signalling that the 68K
; is ready for SH2 communication. Called during frame sync and init.
;
; Memory: $FFFFC822 = comm/input state flag (byte, set to $F0)
; Entry: none | Exit: flag set | Uses: none
; ============================================================================

set_communication_ready_flag:
        move.b  #$F0,($FFFFC822).w              ; $00205E: $11FC $00F0 $C822 — set comm ready
        rts                                     ; $002064: $4E75
