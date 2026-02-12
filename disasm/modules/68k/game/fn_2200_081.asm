; ============================================================================
; Race Completion Check + Lap Bit Tracking
; ROM Range: $00417C-$0041E4 (104 bytes)
; ============================================================================
; Category: game
; Purpose: If scene_state ($C8AA) == $15 (race checkpoint):
;   copies $C096 → $C07A, advances $C07C by 4, clears $FF6754.
;   If $FDA9 nonzero (race active) AND $C30C == 1 AND $FDA8 bit 7 clear:
;     uses $C89C as bit index, sets that bit in $EF07 (lap tracking A).
;     If $FDA9 == 2: also sets bit in $FEB7 (lap tracking B).
;     If $FEB7 reaches $1F: sets bits 6+7 (completion flags).
;     If $EF07 reaches $1F: sets bit 0 of $FDA8 (race complete).
;
; Uses: D0
; RAM:
;   $C07A: bitmask table index (word, set from $C096)
;   $C07C: input_state (word, +4)
;   $C096: source parameter (word)
;   $C30C: race phase (byte, checked == 1)
;   $C89C: SH2 comm state / bit index (word)
;   $C8AA: scene_state (word, checked == $15)
;   $EF07: lap tracking A (byte, bit accumulator)
;   $FDA8: race control (byte, bit 0 = complete, bit 7 = paused)
;   $FDA9: race active flag (byte, 0/1/2)
;   $FEB7: lap tracking B (byte, bit accumulator)
; ============================================================================

fn_2200_081:
        cmpi.w  #$0015,($FFFFC8AA).w          ; $00417C  scene_state == $15?
        bne.s   .done                           ; $004182  no → done
        move.w  ($FFFFC096).w,($FFFFC07A).w   ; $004184  copy param → index
        addq.w  #4,($FFFFC07C).w              ; $00418A  input_state += 4
        move.w  #$0000,$00FF6754               ; $00418E  clear VDP register
        tst.b   ($FFFFFDA9).w                  ; $004196  race active?
        beq.s   .done                           ; $00419A  no → done
        cmpi.b  #$01,($FFFFC30C).w            ; $00419C  race phase == 1?
        bne.s   .done                           ; $0041A2  no → done
        btst    #7,($FFFFFDA8).w               ; $0041A4  paused?
        bne.s   .done                           ; $0041AA  yes → done
        move.w  ($FFFFC89C).w,D0              ; $0041AC  D0 = bit index
        bset    D0,($FFFFEF07).w               ; $0041B0  set bit in lap tracking A
        cmpi.b  #$02,($FFFFFDA9).w            ; $0041B4  2-player race?
        bne.s   .check_a                        ; $0041BA  no → check A only
        bset    D0,($FFFFFEB7).w               ; $0041BC  set bit in lap tracking B
.check_a:
        cmpi.b  #$1F,($FFFFFEB7).w            ; $0041C0  lap B all bits set?
        bne.s   .check_complete                 ; $0041C6  no → check complete
        bset    #6,($FFFFFEB7).w               ; $0041C8  set completion flag 6
        bset    #7,($FFFFFEB7).w               ; $0041CE  set completion flag 7
.check_complete:
        cmpi.b  #$1F,($FFFFEF07).w            ; $0041D4  lap A all bits set?
        bne.s   .done                           ; $0041DA  no → done
        bset    #0,($FFFFFDA8).w               ; $0041DC  set race complete
.done:
        rts                                     ; $0041E2
