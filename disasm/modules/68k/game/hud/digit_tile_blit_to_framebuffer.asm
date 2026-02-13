; ============================================================================
; digit_tile_blit_to_framebuffer — Digit Tile Blit to Framebuffer
; ROM Range: $01199A-$0119B8 (30 bytes)
; ============================================================================
; Same structure as digit_tile_dma_to_framebuffer_a/032 — computes framebuffer address for digit
; tile D1: offset = D1 × 192, added to base $0601DF00. Sends 12×16 tile block
; via name_entry_check ($011A98) which acts as a strided tile blit function.
;
; Entry: D1 = tile/digit index
; Exit: tile data sent to SH2 framebuffer
; Uses: D0, D1, A0
; Calls:
;   $011A98: name_entry_check (tile blit with stride)
; ============================================================================

digit_tile_blit_to_framebuffer:
        LSL.W  #6,D1                            ; $01199A
        MOVE.W  D1,D0                           ; $01199C
        LSL.W  #1,D1                            ; $01199E
        ADD.W   D0,D1                           ; $0119A0
        MOVEA.L #$0601DF00,A0                   ; $0119A2
        ADDA.W  D1,A0                           ; $0119A8
        MOVE.W  #$000C,D0                       ; $0119AA
        MOVE.W  #$0010,D1                       ; $0119AE
        DC.W    $4EBA,$00E4         ; JSR     $011A98(PC); $0119B2
        RTS                                     ; $0119B6
