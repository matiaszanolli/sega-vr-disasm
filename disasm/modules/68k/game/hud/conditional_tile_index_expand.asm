; ============================================================================
; Conditional Tile Index Expand
; ROM Range: $002594-$0025B0 (28 bytes)
; ============================================================================
; Tests VDP update flag ($C80D). If non-zero, returns immediately.
; Otherwise loads frame counter address ($C886) into A0, writes
; VDP command $622A0002 to VDP port (A5), calls tile_index_expand
; at $0024AE, then clears the frame counter.
;
; Memory:
;   $FFFFC80D = VDP update flag (byte, tested)
;   $FFFFC886 = frame counter (byte/source addr for tile expand, cleared)
; Entry: A5 = VDP port | Exit: tiles updated or skipped | Uses: A0, A5
; ============================================================================

conditional_tile_index_expand:
        tst.b   ($FFFFC80D).w                   ; $002594: $4A38 $C80D — test VDP update flag
        bne.s   .done                           ; $002598: $6614 — non-zero → skip
        lea     ($FFFFC886).w,a0                ; $00259A: $41F8 $C886 — frame counter address
        move.l  #$622A0002,(a5)                 ; $00259E: $2ABC $622A $0002 — VDP command
        jsr     pixel_unpack_1pair(pc)  ; $4EBA $FF08
        move.b  #$00,($FFFFC886).w              ; $0025A8: $11FC $0000 $C886 — clear frame counter
.done:
        rts                                     ; $0025AE: $4E75

