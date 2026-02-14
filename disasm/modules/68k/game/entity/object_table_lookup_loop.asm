; ============================================================================
; Object Table Lookup Loop (6 Iterations)
; ROM Range: $0058EA-$005908 (30 bytes)
; ============================================================================
; Masks D0 with $0130 — if non-zero, branches back to previous
; function. Otherwise clears $FF5FFE, loads object table base
; ($9100) into A0, and calls table_lookup ($0059EC) 6 times.
;
; Memory:
;   $00FF5FFE = SH2 shared byte (cleared)
;   $FFFF9100 = object table base (address loaded into A0)
; Entry: D0 = status bits | Exit: table processed | Uses: D0, D7, A0
; ============================================================================

object_table_lookup_loop:
        andi.w  #$0130,d0                       ; $0058EA: $0240 $0130 — mask status bits
        dc.w    $66F8                           ; BNE.S $0058E8 ; $0058EE: — non-zero → branch to prev fn
        move.b  #$00,$00FF5FFE                  ; $0058F0: $13FC $0000 $00FF $5FFE — clear SH2 byte
        lea     ($FFFF9100).w,a0                ; $0058F8: $41F8 $9100 — object table base
        moveq   #$05,d7                         ; $0058FC: $7E05 — loop count = 6
.loop:
        jsr     race_entity_update_loop+176(pc); $4EBA $00EC
        dbra    d7,.loop                        ; $005902: $51CF $FFFA — loop 6 times
        rts                                     ; $005906: $4E75

