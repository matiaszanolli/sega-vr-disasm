; ============================================================================
; Object Position Table Lookup
; ROM Range: $006D50-$006D6E (30 bytes)
; ============================================================================
; Increments object+$1C frame counter, multiplies by 4 (two
; ADD.W D0,D0), then indexes into the position table pointed
; to by $C700 to set object X (+$30) and Y (+$34) positions.
;
; Memory:
;   $FFFFC700 = position table pointer (long, loaded into A2)
; Entry: A0 = object pointer | Exit: position updated | Uses: D0, A0, A2
; ============================================================================

fn_6200_019:
        addq.w  #1,$001C(a0)                    ; $006D50: $5268 $001C — increment frame counter
        move.w  $001C(a0),d0                    ; $006D54: $3028 $001C — load counter
        movea.l ($FFFFC700).w,a2                ; $006D58: $2478 $C700 — load position table ptr
        add.w   d0,d0                           ; $006D5C: $D040 — D0 * 2
        add.w   d0,d0                           ; $006D5E: $D040 — D0 * 4 (4 bytes per entry)
        move.w  $00(a2,d0.w),$0030(a0)          ; $006D60: $3172 $0000 $0030 — X from table
        move.w  $02(a2,d0.w),$0034(a0)          ; $006D66: $3172 $0002 $0034 — Y from table
        rts                                     ; $006D6C: $4E75

