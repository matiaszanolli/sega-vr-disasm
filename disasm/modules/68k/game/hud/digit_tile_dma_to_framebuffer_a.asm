; ============================================================================
; digit_tile_dma_to_framebuffer_a — Digit Tile DMA to Framebuffer A
; ROM Range: $010656-$010674 (30 bytes)
; ============================================================================
; Computes SH2 framebuffer address for digit tile D1: offset = D1 × 192
; (D1<<6 + D1<<7), added to base $06023200. Sends a 12×16 tile block via
; sh2_send_cmd (D0=$0C width, D1=$10 height).
;
; Entry: D1 = tile/digit index
; Exit: tile data sent to SH2 framebuffer
; Uses: D0, D1, A0
; Calls:
;   $00E35A: sh2_send_cmd
; ============================================================================

digit_tile_dma_to_framebuffer_a:
        LSL.W  #6,D1                            ; $010656
        MOVE.W  D1,D0                           ; $010658
        LSL.W  #1,D1                            ; $01065A
        ADD.W   D0,D1                           ; $01065C
        MOVEA.L #$06023200,A0                   ; $01065E
        ADDA.W  D1,A0                           ; $010664
        MOVE.W  #$000C,D0                       ; $010666
        MOVE.W  #$0010,D1                       ; $01066A
        DC.W    $4EBA,$DCEA         ; JSR     $00E35A(PC); $01066E
        RTS                                     ; $010672
