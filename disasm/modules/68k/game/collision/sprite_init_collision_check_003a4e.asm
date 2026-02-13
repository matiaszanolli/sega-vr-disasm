; ============================================================================
; Sprite Init + Collision Check (92-Byte Data Prefix)
; ROM Range: $003A4E-$003AB2 (100 bytes)
; ============================================================================
; Category: game
; Purpose: Data prefix: 92 bytes ($3A4E-$3AA9) of sprite/collision
;   configuration records. Code ($3AAA): checks collision_flag ($C80F).
;   If zero → falls through to next function (no RTS). Otherwise returns.
;
; Uses: none (just data + simple test)
; RAM:
;   $C80F: collision_flag (byte, 0 = fall through)
; ============================================================================

sprite_init_collision_check_003a4e:
; --- data prefix: 92 bytes of sprite/collision config ---
        dc.w    $F372, $1E33, $EE67, $F000       ; $003A4E
        dc.w    $0100, $1049, $0FCD, $E5E2       ; $003A56
        dc.w    $F000, $0110, $F0A8, $0DE6       ; $003A5E
        dc.w    $E977, $FCDF, $00F7, $0F89       ; $003A66
        dc.w    $08CD, $E03C, $F800, $0100       ; $003A6E
        dc.w    $1617, $06AC, $F7AE, $F476       ; $003A76
        dc.w    $0100, $1579, $10A8, $F74A       ; $003A7E
        dc.w    $F447, $0000, $222A, $20DE       ; $003A86
        dc.w    $0000, $0000, $FA6A, $0000       ; $003A8E
        dc.w    $0000, $222A, $2272, $F2E1       ; $003A96
        dc.w    $0633, $2A89, $0000, $0100       ; $003A9E
        dc.w    $222A, $2508                     ; $003AA6
; --- code: collision check + conditional fall-through ---
        tst.b   ($FFFFC80F).w                   ; $003AAA  collision detected?
        beq.s   .fall_through                   ; $003AAE  no → fall through
        rts                                     ; $003AB0
.fall_through:
        ; falls through to next function        ; $003AB2
