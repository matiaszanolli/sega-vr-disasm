; ============================================================================
; Camera Offset Clamping (Y + X Limits)
; ROM Range: $0030C6-$003116 (80 bytes)
; ============================================================================
; Category: game
; Purpose: If $C30E bit 5 set (race active):
;   Y clamping: loads VDP field $FF610A, subtracts camera_offset_y ($C0B0).
;   If diff > $F000 → adds $0040 to $C0B0, clamps to diff.
;   Writes clamped value to $FF610A.
;   X clamping: loads camera_offset_x ($C056).
;   Limit = $0280 (normal) or $0350 (if boost_flag $C8C8 nonzero).
;   If $C056 > limit → subtracts $0010 from $C056, clamps.
;
; Uses: D0, D1, A1
; RAM:
;   $C056: camera_offset_x (word)
;   $C0B0: camera_offset_y (word)
;   $C30E: race_flags (byte, bit 5)
;   $C8C8: boost_flag (word)
; ============================================================================

fn_2200_040:
        btst    #5,($FFFFC30E).w                ; $0030C6  race active?
        beq.s   .done                           ; $0030CC  no → done
        lea     $00FF6100,A1                    ; $0030CE  A1 → VDP block
        move.w  $000A(A1),D0                    ; $0030D4  D0 = VDP field +$0A
        sub.w   ($FFFFC0B0).w,D0                ; $0030D8  D0 -= camera_offset_y
        move.w  #$F000,D1                       ; $0030DC  D1 = Y limit
        cmp.w   D1,D0                           ; $0030E0  diff > limit?
        ble.s   .write_y                        ; $0030E2  no → write Y
        addi.w  #$0040,($FFFFC0B0).w            ; $0030E4  adjust camera_offset_y
        move.w  D0,D1                           ; $0030EA  use diff as value
.write_y:
        move.w  D1,$000A(A1)                    ; $0030EC  write to VDP +$0A
        move.w  ($FFFFC056).w,D0                ; $0030F0  D0 = camera_offset_x
        move.w  #$0280,D1                       ; $0030F4  D1 = X limit (normal)
        tst.w   ($FFFFC8C8).w                   ; $0030F8  boost active?
        beq.s   .check_x                        ; $0030FC  no → use $0280
        move.w  #$0350,D1                       ; $0030FE  D1 = X limit (boosted)
.check_x:
        cmp.w   D1,D0                           ; $003102  offset > limit?
        ble.s   .write_x                        ; $003104  no → write X
        subi.w  #$0010,($FFFFC056).w            ; $003106  reduce offset
        move.w  ($FFFFC056).w,D1                ; $00310C  use new value
.write_x:
        move.w  D1,($FFFFC056).w                ; $003110  write camera_offset_x
.done:
        rts                                     ; $003114

