; ============================================================================
; Object Table Clear Loop
; ROM Range: $005926-$00593C (22 bytes)
; ============================================================================
; If D0 has any bits in $0130 set, branches back (to caller's loop).
; Otherwise, loads the object table base at $9700 and calls
; table_lookup ($0059EC) 8 times to process entries.
;
; Memory:
;   $FFFF9700 = object table 2 base (address, loaded into A0)
; Entry: D0 = status flags | Exit: table processed
; Uses: D0, D7, A0
; ============================================================================

fn_4200_039:
        andi.w  #$0130,d0                       ; $005926: $0240 $0130 — mask status bits
        dc.w    $66F8                           ; BNE.S $005924 ; $00592A: — bits set → branch back
        lea     ($FFFF9700).w,a0               ; $00592C: $41F8 $9700 — object table base
        moveq   #$07,d7                         ; $005930: $7E07 — 8 iterations
.loop:
        dc.w    $4EBA,$00B8                     ; JSR table_lookup(PC) ; $005932: → $0059EC
        dbra    d7,.loop                        ; $005936: $51CF $FFF8
        rts                                     ; $00593A: $4E75
