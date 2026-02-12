; ============================================================================
; Menu State Check + Timer Countdown (Variant A)
; ROM Range: $0144A8-$0144D0 (40 bytes)
; ============================================================================
; Loads table address and parameter, calls menu_state_check.
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

fn_14200_044:
        lea     $009286AE,a1                    ; $0144A8: $43F9 $0092 $86AE — table address
        move.l  #$00009A00,d1                   ; $0144AE: $223C $0000 $9A00 — parameter
        dc.w    $4EBA,$013A                     ; BSR.W $0145F0 ; $0144B4: — call menu_state_check
        subq.w  #1,($FFFFA006).w               ; $0144B8: $5378 $A006 — decrement timer
        bgt.s   .done                           ; $0144BC: $6E10 — not expired → return
        addq.w  #4,($FFFFC082).w               ; $0144BE: $5878 $C082 — advance menu dispatch
        move.b  #$F0,($FFFFC822).w              ; $0144C2: $11FC $00F0 $C822 — comm signal = $F0
        move.w  #$0802,($FFFFA008).w            ; $0144C8: $31FC $0802 $A008 — set player data
.done:
        rts                                     ; $0144CE: $4E75

