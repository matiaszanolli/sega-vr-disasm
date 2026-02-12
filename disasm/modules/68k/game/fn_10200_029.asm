; ============================================================================
; Sprite Buffer Clear + SH2 Scene Reset
; ROM Range: $01188A-$0118D4 (74 bytes)
; ============================================================================
; Clears the 512-byte sprite data buffer at $FF6E00, triggers a sprite
; update via JSR to sprite_update ($00B6DA), then conditionally resets
; the SH2 scene handler. If bit 7 of sync flags ($C80E) is set, the
; SH2 reset is skipped (scene transition already in progress).
;
; Memory:
;   $00FF6E00 = sprite data buffer (512 bytes, cleared)
;   $FFFFC821 = sprite update flag (byte, set to 1)
;   $FFFFC80E = sync/transition flags (byte, bit 7 tested)
;   $FFFFC87E = main game state (word, conditionally cleared)
;   $00FF0002 = SH2 scene handler pointer (long, set to $0088D4B8)
;   $00FF0008 = display mode / frame delay (word, set to $0020)
; Entry: none | Exit: sprites cleared, SH2 optionally reset
; Uses: D0, A0
; ============================================================================

fn_10200_029:
        lea     $00FF6E00,a0                    ; $01188A: $41F9 $00FF $6E00 — sprite buffer base
        move.w  #$007F,d0                       ; $011890: $303C $007F — loop counter (128 longs)
.clear_loop:
        clr.l   (a0)+                           ; $011894: $4298 — clear 4 bytes
        dbra    d0,.clear_loop                  ; $011896: $51C8 $FFFC — loop 128 times (512 bytes)
        move.b  #$01,($FFFFC821).w             ; $01189A: $11FC $0001 $C821 — set sprite update flag
        dc.w    $4EBA,$9E38                     ; JSR sprite_update(PC) ; $0118A0: → $00B6DA
        btst    #7,($FFFFC80E).w               ; $0118A4: $0838 $0007 $C80E — scene transition active?
        bne.s   .done                           ; $0118AA: $6626 — yes → skip SH2 reset
.wait_sh2:
        tst.b   COMM0_HI                        ; $0118AC: $4A38 $5120 — wait for SH2 idle
        bne.s   .wait_sh2                       ; $0118B2: $66F8
        clr.b   COMM1_LO                        ; $0118B4: $4238 $5123 — clear COMM1
        move.w  #$0000,($FFFFC87E).w           ; $0118BA: $31FC $0000 $C87E — reset game state
        move.w  #$0020,$00FF0008                ; $0118C0: $33FC $0020 $00FF $0008 — display mode
        move.l  #$0088D4B8,$00FF0002            ; $0118C8: $23FC $0088 $D4B8 $00FF $0002 — scene handler
.done:
        rts                                     ; $0118D2: $4E75
