; ============================================================================
; HUD Activate Check
; ROM Range: $00BDA8-$00BDC6 (30 bytes)
; ============================================================================
; Conditionally activates HUD elements:
;   If ($A0F0).W != 0, exit (already active)
;   If bit 1 of ($C8AB).W is clear, exit
;   Otherwise: set $FF60C8 = $FFFF, $FF6850 = $09
;
; Uses: (none modified)
; RAM:
;   ($A0F0).W: Active flag (must be 0)
;   ($C8AB).W: Mode bits (bit 1 checked)
;   $FF60C8: HUD enable flag (set to $FFFF)
;   $FF6850: HUD mode (set to $09)
; ============================================================================

hud_activate_check:
        dc.w    $4A78,$A0F0             ; TST.W ($A0F0).W - check active flag
        bne.s   .return                 ; If non-zero, already active
        dc.w    $0838,$0001,$C8AB       ; BTST #1,($C8AB).W - check mode bit
        beq.s   .return                 ; If clear, skip activation
        move.w  #$FFFF,$00FF60C8        ; Enable HUD
        move.b  #$09,$00FF6850          ; Set HUD mode
.return:
        rts
