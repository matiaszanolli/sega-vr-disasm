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

call_sub_address_check_set_race_mode:
        jsr     bcd_scoring_calc(pc)    ; $4EBA $6D24
        addq.w  #4,($FFFFC07C).w                ; $00453C: $5878 $C07C — advance input state
        cmpa.w  #$9000,a0                       ; $004540: $B0FC $9000 — check address
        bne.s   set_flag_clear_sprite           ; $004544: mismatch → fall through to next fn
        move.b  #$AA,($FFFFC8A5).w              ; $004546: $11FC $00AA $C8A5 — set race mode = $AA
        move.b  #$00,$00FF6930                  ; $00454C: $13FC $0000 $00FF $6930 — clear SH2 byte
        rts                                     ; $004554: $4E75

