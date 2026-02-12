; ============================================================================
; Object Update + Conditional Game State Advance
; ROM Range: $00D8B8-$00D8CC (20 bytes)
; ============================================================================
; Calls object_update ($00B684), then checks sync flag bit 6.
; If clear, advances the main game state by 4. If set, skips.
;
; Memory:
;   $FFFFC80E = sync/transition flags (byte, bit 6 tested)
;   $FFFFC87E = main game state (word, conditionally incremented by 4)
; Entry: none | Exit: state optionally advanced | Uses: none
; ============================================================================

fn_c200_025:
        dc.w    $4EBA,$DDCA                     ; JSR object_update(PC) ; $00D8B8: → $00B684
        btst    #6,($FFFFC80E).w               ; $00D8BC: $0838 $0006 $C80E — sync flag set?
        bne.s   .done                           ; $00D8C2: $6606 — yes → skip advance
        addq.w  #4,($FFFFC87E).w               ; $00D8C4: $5878 $C87E — advance game state
        nop                                     ; $00D8C8: $4E71
.done:
        rts                                     ; $00D8CA: $4E75
