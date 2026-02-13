; ============================================================================
; Initialize Scroll + Position Registers
; ROM Range: $0147C2-$0147E8 (38 bytes)
; ============================================================================
; Sets initial values for scroll and track position registers.
; Scroll X = $F400, Scroll Y = $3400, segment positions zeroed/set.
;
; Memory:
;   $FFFFC086 = segment 1 position (word, set to $0000)
;   $FFFFC054 = scroll X (word, set to $F400)
;   $FFFFC056 = scroll Y (word, set to $3400)
;   $FFFFC0AE = segment 3 position (word, set to $0000)
;   $FFFFC0B0 = segment 2 position (word, set to $0800)
;   $FFFFC0B2 = segment 4 position (word, set to $0000)
; Entry: none | Exit: scroll/position initialized | Uses: none
; ============================================================================

initialize_scroll_pos_regs:
        move.w  #$0000,($FFFFC086).w            ; $0147C2: $31FC $0000 $C086 — clear segment 1
        move.w  #$F400,($FFFFC054).w            ; $0147C8: $31FC $F400 $C054 — scroll X = $F400
        move.w  #$3400,($FFFFC056).w            ; $0147CE: $31FC $3400 $C056 — scroll Y = $3400
        move.w  #$0000,($FFFFC0AE).w            ; $0147D4: $31FC $0000 $C0AE — clear segment 3
        move.w  #$0800,($FFFFC0B0).w            ; $0147DA: $31FC $0800 $C0B0 — segment 2 = $0800
        move.w  #$0000,($FFFFC0B2).w            ; $0147E0: $31FC $0000 $C0B2 — clear segment 4
        rts                                     ; $0147E6: $4E75

