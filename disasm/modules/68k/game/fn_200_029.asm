; ============================================================================
; Clear Input State Flags
; ROM Range: $0017D6-$0017E4 (14 bytes)
; ============================================================================
; Clears both input state flag bytes at $C86C and $C86E to zero.
; Called during initialization or state transitions.
;
; Memory:
;   $FFFFC86C = input state flag A (byte, cleared)
;   $FFFFC86E = input state flag B (byte, cleared)
; Entry: none | Exit: flags cleared | Uses: none
; ============================================================================

fn_200_029:
        move.b  #$00,($FFFFC86C).w              ; $0017D6: $11FC $0000 $C86C — clear flag A
        move.b  #$00,($FFFFC86E).w              ; $0017DC: $11FC $0000 $C86E — clear flag B
        rts                                     ; $0017E2: $4E75
