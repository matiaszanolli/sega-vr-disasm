; ============================================================================
; Heading Broadcast (Bulk Entity Fill)
; ROM Range: $0090CE-$009124 (86 bytes)
; ============================================================================
; Computes heading and writes to entity table via MOVEM bulk fill.
; 1 initial + 11 predecrement MOVEM.L writes = ~96 longs.
;
; Entry: A0 = entity, A1 = entity table destination
; Uses: D0-D7
; ============================================================================

heading_broadcast:
        moveq   #0,d0
        move.w  $003C(a0),d0          ; Base heading
        add.w   $0096(a0),d0          ; Add offset
        dc.w    $4A78,$C04C           ; TST.W ($C04C).W - camera flag
        beq.s   .no_cam
        sub.w   $0046(a0),d0          ; Camera correction
.no_cam:
        asr.w   #6,d0                 ; Scale
        move.l  d0,d1                 ; Broadcast to D1-D7
        move.l  d0,d2
        move.l  d0,d3
        move.l  d0,d4
        move.l  d0,d5
        move.l  d0,d6
        move.l  d0,d7
        movem.l d0-d7,(a1)            ; Write 32 bytes
        movem.l d0-d7,-(a1)           ; Write 32 bytes (predecrement)
        movem.l d0-d7,-(a1)           ; Write 32 bytes (predecrement)
        movem.l d0-d7,-(a1)           ; Write 32 bytes (predecrement)
        movem.l d0-d7,-(a1)           ; Write 32 bytes (predecrement)
        movem.l d0-d7,-(a1)           ; Write 32 bytes (predecrement)
        movem.l d0-d7,-(a1)           ; Write 32 bytes (predecrement)
        movem.l d0-d7,-(a1)           ; Write 32 bytes (predecrement)
        movem.l d0-d7,-(a1)           ; Write 32 bytes (predecrement)
        movem.l d0-d7,-(a1)           ; Write 32 bytes (predecrement)
        movem.l d0-d7,-(a1)           ; Write 32 bytes (predecrement)
        movem.l d0-d7,-(a1)           ; Write 32 bytes (predecrement)
        rts
