; ============================================================================
; Menu State Check + Conditional Advance (Variant B)
; ROM Range: $0144F2-$014518 (38 bytes)
; ============================================================================
; Loads alternate table address and parameter, calls menu_state_check.
; Tests player data ($A008): if non-zero, returns. Otherwise clears
; $A008, advances menu dispatch ($C082) by 4, and sets timer
; ($A006) to $0014.
;
; Memory:
;   $FFFFA008 = player data (word, tested, cleared)
;   $FFFFC082 = menu dispatch index (word, advanced by 4)
;   $FFFFA006 = countdown timer (word, set to $0014)
; Entry: none | Exit: menu state checked | Uses: D1, A1
; ============================================================================

menu_state_check_cond_advance_0144f2:
        lea     $00929CA6,a1                    ; $0144F2: $43F9 $0092 $9CA6 — table address
        move.l  #$00002000,d1                   ; $0144F8: $223C $0000 $2000 — parameter
        dc.w    $4EBA,$00F0                     ; BSR.W $0145F0 ; $0144FE: — call menu_state_check
        tst.w   ($FFFFA008).w                   ; $014502: $4A78 $A008 — test player data
        bne.s   .done                           ; $014506: $660E — non-zero → return
        clr.w   ($FFFFA008).w                   ; $014508: $4278 $A008 — clear player data
        addq.w  #4,($FFFFC082).w               ; $01450C: $5878 $C082 — advance menu dispatch
        move.w  #$0014,($FFFFA006).w            ; $014510: $31FC $0014 $A006 — set timer
.done:
        rts                                     ; $014516: $4E75

