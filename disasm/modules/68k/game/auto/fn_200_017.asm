; ============================================================================
; fn_200_017 — Tile Decompressor Inner Loop C
; ROM Range: $0011D8-$0011E4 (12 bytes)
; ============================================================================
; Decompression variant C: XOR-combine and store with post-increment.
; EORs D4 into D2, writes D2 to (A4)+, decrements counter A5, loops
; back to main decompressor body at $001182 if not done.
;
; Entry: D2 = accumulated data, D4 = XOR mask, A4 = VDP_DATA, A5 = counter
; Uses: D2, D4, A4, A5
; ============================================================================

fn_200_017:
        EOR.L   D4,D2                           ; $0011D8
        MOVE.L  D2,(A4)+                        ; $0011DA
        SUBQ.W  #1,A5                           ; $0011DC
        MOVE.W  A5,D4                           ; $0011DE
        DC.W    $66A0               ; BNE.S  $001182; $0011E0
        RTS                                     ; $0011E2
