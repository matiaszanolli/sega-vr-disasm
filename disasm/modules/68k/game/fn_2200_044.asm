; ============================================================================
; Object Timer Tick + SFX Lookup + Field Clear
; ROM Range: $003204-$003250 (76 bytes)
; ============================================================================
; Category: game
; Purpose: Decrements countdown ($C308); when zero: compares $C08E with
;   $C07A — if different, indexes SFX table at $008989EE by object field
;   +$2C and writes to $C8A5. Reloads countdown from #4 to $C305.
;   If $C04E nonzero: clears object via (A1) pointer from $C258,
;   clears VDP flags at $FF6940/$FF6950, advances $C305 by 4.
;
; Uses: D0, A0, A1
; RAM:
;   $C04E: timer/counter (word)
;   $C07A: bitmask table index (word)
;   $C08E: current param (word, compared with $C07A)
;   $C258: object pointer (long)
;   $C305: sub-counter (byte, reload=4, +4 on clear)
;   $C308: countdown timer (byte, decremented)
;   $C8A5: sound effect (byte)
; ============================================================================

fn_2200_044:
        subq.b  #1,($FFFFC308).w               ; $003204  countdown--
        bne.s   .reload                         ; $003208  not zero → reload
        move.w  ($FFFFC08E).w,D0               ; $00320A  D0 = current param
        cmp.w   ($FFFFC07A).w,D0               ; $00320E  same as table index?
        beq.s   .reload                         ; $003212  yes → skip SFX lookup
        move.w  $002C(A0),D0                   ; $003214  D0 = object field +$2C
        lea     $008989EE,A1                    ; $003218  A1 → SFX table
        move.b  $00(A1,D0.W),($FFFFC8A5).w    ; $00321E  SFX = table[field_2C]
.reload:
        move.b  #$04,($FFFFC305).w             ; $003224  reload sub-counter = 4
        tst.w   ($FFFFC04E).w                  ; $00322A  timer active?
        dc.w    $6720                           ; $00322E  beq.s $003250 → exit (past fn)
        movea.l ($FFFFC258).w,A1               ; $003230  A1 = object pointer
        move.b  #$00,$0000(A1)                 ; $003234  clear object byte 0
        move.b  #$00,$00FF6940                 ; $00323A  clear VDP flag A
        move.b  #$00,$00FF6950                 ; $003242  clear VDP flag B
        addq.b  #4,($FFFFC305).w               ; $00324A  advance sub-counter
        rts                                     ; $00324E
