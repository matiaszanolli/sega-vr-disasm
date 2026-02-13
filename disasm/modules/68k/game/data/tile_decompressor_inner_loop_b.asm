; ============================================================================
; tile_decompressor_inner_loop_b — Tile Decompressor Inner Loop B
; ROM Range: $0011CE-$0011D8 (10 bytes)
; ============================================================================
; Decompression variant B: Store with post-increment, no XOR.
; Writes D4 to (A4)+, decrements counter A5, loops back to main
; decompressor body at $001182 if not done.
;
; Entry: D4 = tile data, A4 = VDP_DATA, A5 = counter
; Uses: D4, A4, A5
; ============================================================================

tile_decompressor_inner_loop_b:
        MOVE.L  D4,(A4)+                        ; $0011CE
        SUBQ.W  #1,A5                           ; $0011D0
        MOVE.W  A5,D4                           ; $0011D2
        DC.W    $66AC               ; BNE.S  $001182; $0011D4
        RTS                                     ; $0011D6
