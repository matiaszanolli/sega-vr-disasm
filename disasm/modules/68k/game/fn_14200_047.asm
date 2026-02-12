; ============================================================================
; Menu State Check + Timer Countdown (Variant B)
; ROM Range: $014518-$014540 (40 bytes)
; ============================================================================
; Loads alternate table address and parameter, calls menu_state_check.
; Decrements timer ($A006). If not expired, returns. Otherwise
; advances menu dispatch ($C082) by 4, sets comm signal ($C822)
; to $F0, and sets $A008 to $0802.
;
; Memory:
;   $FFFFA006 = countdown timer (word, decremented)
;   $FFFFC082 = menu dispatch index (word, advanced by 4)
;   $FFFFC822 = comm signal (byte, set to $F0)
;   $FFFFA008 = player data (word, set to $0802)
; Entry: none | Exit: timer decremented | Uses: D1, A1
; ============================================================================

fn_14200_047:
        lea     $00929CA6,a1                    ; $014518: $43F9 $0092 $9CA6 — table address
        move.l  #$00002000,d1                   ; $01451E: $223C $0000 $2000 — parameter
        dc.w    $4EBA,$00CA                     ; BSR.W $0145F0 ; $014524: — call menu_state_check
        subq.w  #1,($FFFFA006).w               ; $014528: $5378 $A006 — decrement timer
        bgt.s   .done                           ; $01452C: $6E10 — not expired → return
        addq.w  #4,($FFFFC082).w               ; $01452E: $5878 $C082 — advance menu dispatch
        move.b  #$F0,($FFFFC822).w              ; $014532: $11FC $00F0 $C822 — comm signal = $F0
        move.w  #$0802,($FFFFA008).w            ; $014538: $31FC $0802 $A008 — set player data
.done:
        rts                                     ; $01453E: $4E75

