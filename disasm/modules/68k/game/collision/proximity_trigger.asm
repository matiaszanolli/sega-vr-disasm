; ============================================================================
; Proximity Trigger (Cooldown Timer)
; ROM Range: $009E6E-$009EC0 (82 bytes)
; ============================================================================
; Proximity trigger with cooldown. Indexes entity table,
; compares distances, sets 12-frame timer if close.
;
; Entry: A0 = entity
; Uses: D0, D1, A1
; ============================================================================

proximity_trigger:
        tst.w   $00A8(a0)             ; Check cooldown timer
        beq.s   .check
        subq.w  #1,$00A8(a0)          ; Decrement timer
.check:
        move.w  $00A4(a0),d0          ; Entity index
        asl.w   #8,d0                 ; Word index
        dc.w    $43F8,$9000           ; LEA ($9000).W,A1 - entity table
        lea     (a1,d0.w),a1          ; Index into table
        move.w  $0072(a1),d0          ; Target lap position
        sub.w   $0072(a0),d0          ; Difference
        bpl.s   .lap_pos
        neg.w   d0
.lap_pos:
        cmpi.w  #$0030,d0             ; Lap distance threshold
        bgt.s   .done                 ; Too far in lap
        move.w  $0030(a1),d0          ; Target X
        sub.w   $0030(a0),d0
        bpl.s   .xpos
        neg.w   d0
.xpos:
        move.w  $0034(a1),d1          ; Target Z
        sub.w   $0034(a0),d1
        bpl.s   .zpos
        neg.w   d1
.zpos:
        add.w   d1,d0                 ; Combined XZ distance
        cmpi.w  #$0070,d0             ; Proximity threshold
        bgt.s   .done
        move.w  #$000C,$00A8(a0)      ; Set 12-frame timer
.done:
        rts
