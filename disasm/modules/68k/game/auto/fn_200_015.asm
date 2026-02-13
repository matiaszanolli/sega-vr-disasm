; ============================================================================
; fn_200_015 — Tile Decompressor Inner Loop A
; ROM Range: $0011C2-$0011CE (12 bytes)
; ============================================================================
; Decompression variant A: XOR-combine and store without post-increment.
; EORs D4 into D2, writes D2 to (A4), decrements counter A5, loops
; back to main decompressor body at $001182 if not done.
;
; Entry: D2 = accumulated data, D4 = XOR mask, A4 = VDP_DATA, A5 = counter
; Uses: D2, D4, A4, A5
; ============================================================================

fn_200_015:
        EOR.L   D4,D2                           ; $0011C2
        MOVE.L  D2,(A4)                         ; $0011C4
        SUBQ.W  #1,A5                           ; $0011C6
        MOVE.W  A5,D4                           ; $0011C8
        DC.W    $66B6               ; BNE.S  $001182; $0011CA
        RTS                                     ; $0011CC
