; ============================================================================
; Tire Squeal Check (1-Player)
; ROM Range: $0085C4-$008610 (76 bytes)
; ============================================================================
; Checks lateral speed and triggers tire squeal sound effect.
; Manages cooldown timer, two threshold levels.
;
; Entry: A0 = entity
; Uses: D0
; ============================================================================

tire_squeal_check:
        tst.b    ($FFFFC8A2).w          ; $4A38 $C8A2 — cooldown timer
        beq.s   .check_speed          ; If zero, check speed
        subq.b  #1,($FFFFC8A2).w        ; $5338 $C8A2 — decrement
        bne.s   .check_speed          ; If still nonzero, check speed
        move.b  #$00,($FFFFC8A6).w      ; $11FC $0000 $C8A6 — clear sound ID
.check_speed:
        move.w  $0094(a0),d0          ; Read lateral speed
        bpl.s   .pos
        neg.w   d0                    ; Absolute value
.pos:
        cmpi.w  #$0010,d0             ; Low threshold
        ble.s   .restore_sound        ; Too slow: restore sound
        cmpi.w  #$0020,d0             ; High threshold
        ble.s   .done                 ; Medium: just exit
        cmpi.b  #$BD,($FFFFC8A6).w      ; $0C38 $00BD $C8A6
        beq.s   .done                 ; Already squealing: exit
        move.b  #$BD,($FFFFC8A4).w      ; $11FC $00BD $C8A4 — squeal sound
        move.b  #$20,($FFFFC8A2).w      ; $11FC $0020 $C8A2 — 32 frame cooldown
        rts
.restore_sound:
        cmpi.b  #$BD,($FFFFC8A6).w      ; $0C38 $00BD $C8A6
        bne.s   .done
        move.b  #$C8,($FFFFC8A4).w      ; $11FC $00C8 $C8A4 — restore sound
.done:
        rts
