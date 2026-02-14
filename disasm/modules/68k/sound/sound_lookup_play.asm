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
        move.b  (a1,d0.w),($FFFFC8A5).w ; $11F1 $0000 $C8A5
        move.b  #$00,($FFFFC305).w      ; $11FC $0000 $C305
        rts
