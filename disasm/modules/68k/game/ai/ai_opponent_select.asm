; ============================================================================
; AI Opponent Select
; ROM Range: $00A434-$00A46E (60 bytes)
; ============================================================================
; Conditionally activates AI opponent targeting based on game mode, entity
; speed class, game state, and cooldown timer. Sets a category flag based
; on whether the entity's speed index exceeds a high-speed threshold.
;
; Entry: A0 = object/entity pointer
; Uses: D0
; Fields accessed:
;   A0+$04: Speed table index
;   A0+$86: AI cooldown timer (set to 15 when triggered)
;   A0+$BE: Opponent category flag (0=normal, 1=high-speed)
; RAM:
;   ($C8C8).W: Mode flag (skip if == 1)
;   ($C319).W: Game state byte (require == 4)
;   ($C8A4).W: AI behavior trigger (set to $B7)
; ============================================================================

ai_opponent_select:
        dc.w    $0C78,$0001,$C8C8       ; CMPI.W #$0001,($C8C8).W - check mode
        beq.s   .return                 ; If mode == 1, skip AI targeting
        cmpi.w  #$0059,$4(a0)           ; Speed index >= 89?
        blt.s   .return                 ; If below threshold, skip
        dc.w    $0C38,$0004,$C319       ; CMPI.B #$04,($C319).W - check game state
        bne.s   .return                 ; If state != 4, skip
        tst.w   $86(a0)                 ; Cooldown timer active?
        bne.s   .return                 ; If nonzero, still cooling down
        move.w  #$000F,$86(a0)          ; Set cooldown = 15 frames
        dc.w    $11FC,$00B7,$C8A4       ; MOVE.B #$B7,($C8A4).W - trigger AI behavior
        moveq   #0,d0                   ; Default: normal category
        cmpi.w  #$00C8,$4(a0)           ; Speed index >= 200?
        blt.s   .store_category         ; If below, keep normal
        moveq   #1,d0                   ; High-speed category
.store_category:
        move.w  d0,$BE(a0)              ; Store opponent category flag
.return:
        rts
