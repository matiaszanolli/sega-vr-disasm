; ============================================================================
; Sound Lookup and Play
; ROM Range: $0033EC-$003402 (24 bytes)
; ============================================================================
; Looks up a sound effect by index from entity data and plays it.
; Sound table at $008989EE, index from entity offset $2C.
;
; Entry: A0 = entity
; Uses: D0, A1
; ============================================================================

sound_lookup_play:
        move.w  $002C(a0),d0          ; Get sound index from entity
        lea     $008989EE,a1          ; Sound effect lookup table
        dc.w    $11F1,$0000,$C8A5     ; MOVE.B 0(A1,D0.W),($C8A5).W
        dc.w    $11FC,$0000,$C305     ; MOVE.B #$00,($C305).W
        rts
