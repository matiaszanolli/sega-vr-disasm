; ============================================================================
; HUD Panel Config
; ROM Range: $00B55A-$00B58E (52 bytes)
; ============================================================================
; Conditionally configures a HUD panel structure at $FF69E0.
; If ($C819).W flag is set, exits immediately.
; Otherwise: sets tile reference based on lap comparison,
; and enables/disables panel based on ($C967).W bit 4.
;
; Uses: D0, D1
; RAM:
;   ($C819).W: Guard flag (non-zero = skip)
;   ($902A).W: Current lap value
;   ($9F2A).W: Lap threshold
;   ($C967).W: Config bits (bit 4 checked)
;   $FF69E0+$00: Panel enable (byte)
;   $FF69E0+$04: Tile reference (long)
; ============================================================================

hud_panel_config:
        tst.b    ($FFFFC819).w          ; $4A38 $C819 — check guard flag
        bne.s   .return                 ; If set, skip entirely
        lea     $00FF69E0,a1            ; HUD panel structure
        move.l  #$04027AFC,d0           ; Default tile reference
        move.w  ($FFFF902A).w,d1        ; $3238 $902A — current lap
        cmp.w   ($FFFF9F2A).w,d1        ; $B278 $9F2A — vs threshold
        ble.s   .store                  ; If within threshold, use default
        move.l  #$040382FC,d0           ; Alternate tile reference
.store:
        move.l  d0,$04(a1)              ; Store tile reference
        moveq   #1,d0                   ; Assume enabled
        btst    #4,($FFFFC967).w        ; $0838 $0004 $C967 — check config bit
        bne.s   .set_enable             ; If bit 4 set, keep enabled
        moveq   #0,d0                   ; Disabled
.set_enable:
        move.b  d0,(a1)                 ; Store panel enable flag
.return:
        rts
