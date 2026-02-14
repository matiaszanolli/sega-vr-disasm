; ============================================================================
; Menu State Check + Conditional Advance (Variant A)
; ROM Range: $0144D0-$0144F2 (34 bytes)
; ============================================================================
; Loads table address and parameter, calls menu_state_check.
; Tests player data ($A008): if non-zero, returns. Otherwise
; advances menu dispatch ($C082) by 4 and sets $A008 to $0801.
;
; Memory:
;   $FFFFA008 = player data (word, tested, conditionally set to $0801)
;   $FFFFC082 = menu dispatch index (word, advanced by 4)
; Entry: none | Exit: menu state checked | Uses: D1, A1
; ============================================================================

menu_state_check_cond_advance_0144d0:
        lea     $009286AE,a1                    ; $0144D0: $43F9 $0092 $86AE — table address
        move.l  #$00009A00,d1                   ; $0144D6: $223C $0000 $9A00 — parameter
        jsr     menu_tile_copy_to_vdp(pc); $4EBA $0112
        tst.w   ($FFFFA008).w                   ; $0144E0: $4A78 $A008 — test player data
        bne.s   .done                           ; $0144E4: $660A — non-zero → return
        addq.w  #4,($FFFFC082).w               ; $0144E6: $5878 $C082 — advance menu dispatch
        move.w  #$0801,($FFFFA008).w            ; $0144EA: $31FC $0801 $A008 — set player data
.done:
        rts                                     ; $0144F0: $4E75

