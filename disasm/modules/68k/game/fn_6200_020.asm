; ============================================================================
; Position Table Lookup (Decrement Counter)
; ROM Range: $006D6E-$006D8C (30 bytes)
; ============================================================================
; Category: game
; Purpose: Decrements object frame counter at +$1C, then uses it as index
;   into position table at ($C700) to update object X/Y position.
;   Counter × 4 gives table offset (entries are 2 × word = 4 bytes).
;   Identical to fn_6200_019 except uses SUBQ (decrement) instead of ADDQ.
;
; Entry: A0 = object pointer
; Uses: D0, A2
; RAM:
;   $C700: position table pointer (long)
; Object fields:
;   +$1C: frame counter (word, decremented)
;   +$30: x_position (word, updated from table)
;   +$34: y_position (word, updated from table)
; ============================================================================

fn_6200_020:
        subq.w  #1,$001C(A0)                    ; $006D6E  decrement frame counter
        move.w  $001C(A0),D0                    ; $006D72  D0 = new counter value
        movea.l ($FFFFC700).w,A2                ; $006D76  A2 = position table base
        dc.w    $D040                           ; $006D7A  add.w d0,d0 — D0 × 2
        dc.w    $D040                           ; $006D7C  add.w d0,d0 — D0 × 4
        move.w  $00(A2,D0.W),$0030(A0)          ; $006D7E  obj x_pos = table[idx].x
        move.w  $02(A2,D0.W),$0034(A0)          ; $006D84  obj y_pos = table[idx].y
        rts                                     ; $006D8A
