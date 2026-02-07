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
        dc.w    $11FC,$0003,$C819     ; MOVE.B #$03,($C819).W - step counter
        cmpa.w  #$9000,a0             ; Check player ID
        beq.s   .player1              ; If player 1, branch
        dc.w    $2038,$B180           ; MOVE.L ($B180).W,D0 - P2 score
        dc.w    $B0B8,$C260           ; CMP.L ($C260).W,D0 - threshold
        ble.s   sprite_clear_alt      ; If <=, alternate path (next func)
        bra.s   .set_flag             ; Otherwise set flag
.player1:
        dc.w    $2038,$B580           ; MOVE.L ($B580).W,D0 - P1 score
        dc.w    $B0B8,$C260           ; CMP.L ($C260).W,D0 - threshold
        ble.s   .set_flag             ; If <=, set flag
        bra.s   sprite_clear_alt      ; Otherwise alternate path
.set_flag:
        dc.w    $11FC,$0001,$C816     ; MOVE.B #$01,($C816).W - position flag
        move.l  #$04038000,$0004(a2)  ; Set sprite attributes
        dc.w    $31FC,$0000,$B39C     ; MOVE.W #$0000,($B39C).W
        rts
