; ============================================================================
; Object Timer Tick + SFX Lookup (Variant B — Extra Flag Check)
; ROM Range: $003540-$00359C (92 bytes)
; ============================================================================
; Category: game
; Purpose: Like object_timer_tick_sfx_lookup_field_clear but adds extra checks:
;   Decrements countdown ($C308); when zero and $C08E != $C07A and
;   $C30E bit 5 clear: indexes SFX table at $008989EE by object +$2C,
;   writes to $C8A5. Special case: if $FF6948 == $222E0508 → SFX = $97.
;   Reloads sub-counter $C305 = 4.
;   If $C04E nonzero: clears VDP flags $FF6940/$FF6950, advances $C305.
;
; Uses: D0, A0, A1
; RAM:
;   $C04E: timer/counter (word)
;   $C07A: bitmask table index (word)
;   $C08E: current param (word)
;   $C305: sub-counter (byte, reload=4)
;   $C308: countdown timer (byte, decremented)
;   $C30E: button/control flags (byte, bit 5)
;   $C8A5: sound effect (byte)
; ============================================================================

object_timer_tick_sfx_lookup:
        subq.b  #1,($FFFFC308).w               ; $003540  countdown--
        bne.s   .reload                         ; $003544  not zero → reload
        move.w  ($FFFFC08E).w,D0               ; $003546  D0 = current param
        cmp.w   ($FFFFC07A).w,D0               ; $00354A  same as table index?
        beq.s   .reload                         ; $00354E  yes → skip SFX
        btst    #5,($FFFFC30E).w               ; $003550  control bit 5 set?
        bne.s   .reload                         ; $003556  yes → skip SFX
        move.w  $002C(A0),D0                   ; $003558  D0 = object field +$2C
        lea     $008989EE,A1                    ; $00355C  A1 → SFX table
        move.b  $00(A1,D0.W),($FFFFC8A5).w    ; $003562  SFX = table[field_2C]
        cmpi.l  #$222E0508,$00FF6948           ; $003568  special VDP pattern?
        bne.s   .reload                         ; $003572  no → reload
        move.b  #$97,($FFFFC8A5).w             ; $003574  override SFX = $97
.reload:
        move.b  #$04,($FFFFC305).w             ; $00357A  reload sub-counter = 4
        tst.w   ($FFFFC04E).w                  ; $003580  timer active?
        dc.w    $6716                           ; $003584  beq.s $00359C → exit (past fn)
        move.b  #$00,$00FF6940                 ; $003586  clear VDP flag A
        move.b  #$00,$00FF6950                 ; $00358E  clear VDP flag B
        addq.b  #4,($FFFFC305).w               ; $003596  advance sub-counter
        rts                                     ; $00359A
