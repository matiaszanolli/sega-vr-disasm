; ============================================================================
; Tire Squeal Check (2-Player)
; ROM Range: $008610-$008672 (98 bytes)
; ============================================================================
; Two-player version of tire squeal check.
; Reads P1 speed from ($9094).W and P2 from ($9F94).W.
;
; Entry: none
; Uses: D0, D2
; ============================================================================

tire_squeal_check_2p:
        tst.b    ($FFFFC8A2).w          ; $4A38 $C8A2 — cooldown
        beq.s   .check_speed
        subq.b  #1,($FFFFC8A2).w        ; $5338 $C8A2
        bne.s   .check_speed
        move.b  #$00,($FFFFC8A6).w      ; $11FC $0000 $C8A6
.check_speed:
        move.w  ($FFFF9094).w,d0        ; $3038 $9094 — P1 lateral speed
        bpl.s   .p1pos
        neg.w   d0
.p1pos:
        move.w  ($FFFF9F94).w,d2        ; $3438 $9F94 — P2 lateral speed
        bpl.s   .p2pos
        neg.w   d2
.p2pos:
        cmpi.w  #$0010,d0
        bgt.s   .p1_above_low
        cmpi.w  #$0010,d2
        ble.s   .restore_sound
.check_p2_high:
        cmpi.w  #$0020,d2
        bgt.s   .trigger
        rts
.p1_above_low:
        cmpi.w  #$0020,d0
        ble.s   .check_p2_high        ; Re-compare P2 high threshold
.trigger:
        cmpi.b  #$BD,($FFFFC8A6).w      ; $0C38 $00BD $C8A6
        beq.s   .done                 ; Already squealing: exit
        move.b  #$BD,($FFFFC8A4).w      ; $11FC $00BD $C8A4 — squeal
        move.b  #$20,($FFFFC8A2).w      ; $11FC $0020 $C8A2 — cooldown
        rts
.restore_sound:
        cmpi.b  #$BD,($FFFFC8A6).w      ; $0C38 $00BD $C8A6
        bne.s   .done
        move.b  #$C8,($FFFFC8A4).w      ; $11FC $00C8 $C8A4
.done:
        rts
