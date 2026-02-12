; ============================================================================
; Sprite Init + Collision Check (56-Byte Data Prefix)
; ROM Range: $003924-$00397C (88 bytes)
; ============================================================================
; Category: game
; Purpose: Data prefix: 56 bytes ($3924-$395B) of sprite/collision
;   configuration records (4 × 14-byte entries with $222A markers).
;   Code ($395C): loads sprite data from ROM $3A4E into sprite buffer
;   at $FF65B0. Sets sprite pattern $22295A24, loop count D7=3.
;   Calls collision_distance_calc ($0039EC). If collision_flag ($C80F)
;   is zero → falls through to next function (no RTS).
;
; Uses: D0, D1, D2, D7, A1, A2, A3, A6
; RAM:
;   $C80F: collision_flag (byte, 0 = fall through)
; Calls:
;   $0039EC: collision_distance_calc
; ============================================================================

fn_2200_057:
; --- data prefix: 56 bytes of sprite/collision config ---
        dc.w    $F809,$1417,$CF1F,$F07F         ; $003924  record 0 (header)
        dc.w    $0000,$222A,$1498,$0000          ; $00392C  record 0 (position)
        dc.w    $1CB3,$0000,$0000,$0000          ; $003934  record 1 (header)
        dc.w    $222A,$160C,$FDF0,$0A2C          ; $00393C  record 1 (position)
        dc.w    $D161,$1000,$0000,$222A          ; $003944  record 2
        dc.w    $1DBE,$0000,$1A69,$0000          ; $00394C  record 2 (cont)
        dc.w    $0000,$0000,$222A,$1EB8          ; $003954  record 3
; --- code ---
        lea     $00883A4E,A1                    ; $00395C  A1 → sprite data table
        lea     $00FF65B0,A2                    ; $003962  A2 → sprite buffer
        move.l  #$22295A24,D0                   ; $003968  D0 = sprite pattern
        moveq   #$03,D7                         ; $00396E  D7 = loop count (4 sprites)
        dc.w    $4EBA,$007A                     ; $003970  jsr $0039EC(pc) — collision_distance_calc
        tst.b   ($FFFFC80F).w                   ; $003974  collision detected?
        dc.w    $6702                           ; $003978  beq.s $00397C — no → fall through
        rts                                     ; $00397A

