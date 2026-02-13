; ============================================================================
; Speed Modifier (Conditional Scaling)
; ROM Range: $009B32-$009B54 (34 bytes)
; ============================================================================
; Applies speed modification based on ($C31A).W flag.
; If flag=0: returns 0. If flag>2: extra shift.
;
; Entry: A0 = entity
; Exit: D0 = modified speed value
; Uses: D0, D1 (preserved)
; ============================================================================

speed_modifier:
        move.l  d1,-(a7)              ; Save D1
        moveq   #0,d0
        dc.w    $1238,$C31A           ; MOVE.B ($C31A).W,D1
        beq.s   .zero                 ; If flag=0, clear and return
        move.w  $0004(a0),d0          ; Read speed
        muls.w  d0,d0                 ; Square speed
        lsr.l   #4,d0                 ; Scale down
        cmpi.b  #$02,d1               ; Check flag level
        bgt.s   .done                 ; If > 2, skip halving
        lsr.w   #1,d0                 ; Half the value
        bra.s   .done
.zero:
        moveq   #0,d0                 ; Clear result
.done:
        move.l  (a7)+,d1              ; Restore D1
        rts
