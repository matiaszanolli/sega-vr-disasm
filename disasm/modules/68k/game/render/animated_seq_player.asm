; ============================================================================
; Animated Sequence Player (Byte Table + Counter)
; ROM Range: $00B6D0-$00B722 (82 bytes)
; ============================================================================
; Category: game
; Purpose: Data prefix: 10-byte descending sequence ($FF..$F8,$F8,$80).
;   If $C80E bit 7 set: decrements countdown ($C80A); when zero reloads
;   from $C809 and indexes sequence table at $00B722 by $C825.
;   Writes byte to $FF60D5 (VDP palette/sprite). Increments $C825;
;   when $C825 reaches $0A: calls $004846 with D1=0/A1=$8480,
;   resets $C825, clears $C80E bit 7 (sequence complete).
;
; Uses: D0, D1, A1
; RAM:
;   $8480: work buffer (long, passed to $004846)
;   $C809: countdown reload value (byte)
;   $C80A: countdown timer (byte, decremented)
;   $C80E: control flags (byte, bit 7 = sequence active)
;   $C825: sequence index (byte, 0-9)
; Calls:
;   $004846: sequence completion handler
; ============================================================================

animated_seq_player:
; --- data prefix: 10-byte descending sequence ---
        dc.w    $FFFE                           ; $00B6D0  bytes: $FF, $FE
        dc.w    $FDFC                           ; $00B6D2  bytes: $FD, $FC
        dc.w    $FBFA                           ; $00B6D4  bytes: $FB, $FA
        dc.w    $F9F8                           ; $00B6D6  bytes: $F9, $F8
        dc.w    $F880                           ; $00B6D8  bytes: $F8, $80
; --- code ---
        btst    #7,($FFFFC80E).w               ; $00B6DA  sequence active?
        beq.s   .done                           ; $00B6E0  no → done
        subq.b  #1,($FFFFC80A).w               ; $00B6E2  countdown--
        bne.s   .done                           ; $00B6E6  not zero → done
        move.b  ($FFFFC809).w,($FFFFC80A).w   ; $00B6E8  reload countdown
        moveq   #$00,D0                         ; $00B6EE  clear high bits
        move.b  ($FFFFC825).w,D0               ; $00B6F0  D0 = sequence index
        move.b  $00B722(PC,D0.W),D1            ; $00B6F4  D1 = sequence[index]
        move.b  D1,$00FF60D5                   ; $00B6F8  write to VDP register
        addq.b  #1,D0                           ; $00B6FE  index++
        move.b  D0,($FFFFC825).w               ; $00B700  store updated index
        cmpi.b  #$0A,D0                         ; $00B704  index == 10?
        bne.s   .done                           ; $00B708  no → done
        moveq   #$00,D1                         ; $00B70A  D1 = 0
        lea     ($FFFF8480).w,A1               ; $00B70C  A1 → work buffer
        dc.w    $4EBA,$9134                     ; $00B710  jsr $004846(pc) — completion handler
        move.b  #$00,($FFFFC825).w             ; $00B714  reset index
        bclr    #7,($FFFFC80E).w               ; $00B71A  clear sequence active flag
.done:
        rts                                     ; $00B720
