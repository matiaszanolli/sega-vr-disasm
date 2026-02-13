; ============================================================================
; Display State Timer + Flag Update
; ROM Range: $008200-$008246 (70 bytes)
; ============================================================================
; Category: game
; Purpose: ANDs -(A4) with D4 (flag check); if result nonzero writes $BF
;   to $C8A4 (SFX). Decrements timer ($C04E); when zero or $C8AB bit 2
;   set: writes D0 (0 or 1) to VDP display flag ($FF6960).
;   If $C305 nonzero or $C04E != $3C: exits early (past fn).
;   Otherwise checks object (A0) field +$02 bit 1: if set, clears bit 9
;   of field +$02 (ANDI #$FDFF).
;
; Uses: D0, D4, A0, A4
; RAM:
;   $C04E: display timer (word, decremented)
;   $C305: sub-counter (byte, checked nonzero)
;   $C8A4: SFX/sound command (byte)
;   $C8AB: scene flags (byte, bit 2)
; ============================================================================

display_state_timer_flag_update:
        and.l   -(A4),D4                       ; $008200  D4 &= -(A4) (flag check)
        beq.s   .check_timer                    ; $008202  zero → skip SFX
        move.b  #$BF,($FFFFC8A4).w             ; $008204  SFX = $BF
.check_timer:
        tst.w   ($FFFFC04E).w                  ; $00820A  timer active?
        dc.w    $6744                           ; $00820E  beq.s $008254 → exit (past fn, timer=0)
        moveq   #$00,D0                         ; $008210  D0 = 0 (default)
        subq.w  #1,($FFFFC04E).w               ; $008212  timer--
        beq.s   .write_flag                     ; $008216  zero → write flag (D0=0)
        btst    #2,($FFFFC8AB).w               ; $008218  scene bit 2 set?
        bne.s   .write_flag                     ; $00821E  yes → write flag (D0=0)
        moveq   #$01,D0                         ; $008220  D0 = 1
.write_flag:
        move.b  D0,$00FF6960                   ; $008222  write VDP display flag
        tst.b   ($FFFFC305).w                  ; $008228  sub-counter active?
        dc.w    $6626                           ; $00822C  bne.s $008254 → exit (past fn)
        cmpi.w  #$003C,($FFFFC04E).w          ; $00822E  timer == $3C?
        dc.w    $661E                           ; $008234  bne.s $008254 → exit (past fn)
        btst    #1,$0002(A0)                   ; $008236  object bit 1 set?
        dc.w    $6708                           ; $00823C  beq.s $008246 → exit (past fn)
        andi.w  #$FDFF,$0002(A0)               ; $00823E  clear bit 9 of field +$02
        rts                                     ; $008244
