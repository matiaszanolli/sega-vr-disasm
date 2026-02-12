; ============================================================================
; Call Sub + Address Check + Set Race Mode
; ROM Range: $004538-$004556 (30 bytes)
; ============================================================================
; Calls sub at $00B25E, advances input state ($C07C) by 4. If A0
; is not $9000, falls through to next function. Otherwise sets
; race/mode state ($C8A5) to $AA and clears SH2 shared byte.
;
; Memory:
;   $FFFFC07C = input state (word, advanced by 4)
;   $FFFFC8A5 = race/mode state (byte, conditionally set to $AA)
;   $00FF6930 = SH2 shared byte (cleared on match)
; Entry: A0 = address from sub | Exit: conditional return | Uses: A0
; ============================================================================

fn_4200_005:
        dc.w    $4EBA,$6D24                     ; BSR.W $00B25E ; $004538: — call sub
        addq.w  #4,($FFFFC07C).w                ; $00453C: $5878 $C07C — advance input state
        cmpa.w  #$9000,a0                       ; $004540: $B0FC $9000 — check address
        dc.w    $6610                           ; BNE.S fn_4200_005_end ; $004544: — mismatch → fall through
        move.b  #$AA,($FFFFC8A5).w              ; $004546: $11FC $00AA $C8A5 — set race mode = $AA
        move.b  #$00,$00FF6930                  ; $00454C: $13FC $0000 $00FF $6930 — clear SH2 byte
        rts                                     ; $004554: $4E75

