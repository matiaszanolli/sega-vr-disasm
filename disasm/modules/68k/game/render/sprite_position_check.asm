; ============================================================================
; Sprite Position Check (Player Compare)
; ROM Range: $0045CE-$00461A (76 bytes)
; ============================================================================
; Initializes sprite and checks player score against threshold.
; Sets player-specific attributes. A0=$9000 for player 1.
; Falls through to sprite_clear_alt for alternate path.
;
; Entry: A0 = player base, A2 = sprite struct
; Uses: D0
; ============================================================================

sprite_position_check:
        move.b  #$07,(a2)             ; Set sprite type = 7
        move.w  #$01AE,$0002(a2)      ; Set Y position = 430
        move.l  #$222EDB1A,$0008(a2)  ; Set tile pointer
        move.b  #$03,($FFFFC819).w      ; $11FC $0003 $C819 — step counter
        cmpa.w  #$9000,a0             ; Check player ID
        beq.s   .player1              ; If player 1, branch
        move.l  ($FFFFB180).w,d0        ; $2038 $B180 — P2 score
        cmp.l   ($FFFFC260).w,d0        ; $B0B8 $C260 — threshold
        ble.s   sprite_clear_alt      ; If <=, alternate path (next func)
        bra.s   .set_flag             ; Otherwise set flag
.player1:
        move.l  ($FFFFB580).w,d0        ; $2038 $B580 — P1 score
        cmp.l   ($FFFFC260).w,d0        ; $B0B8 $C260 — threshold
        ble.s   .set_flag             ; If <=, set flag
        bra.s   sprite_clear_alt      ; Otherwise alternate path
.set_flag:
        move.b  #$01,($FFFFC816).w      ; $11FC $0001 $C816 — position flag
        move.l  #$04038000,$0004(a2)  ; Set sprite attributes
        move.w  #$0000,($FFFFB39C).w    ; $31FC $0000 $B39C
        rts
