; ============================================================================
; lap_time_digit_renderer — Lap Time Digit Renderer (Records Screen)
; ROM Range: $01259C-$0125D0 (52 bytes)
; ============================================================================
; Same pattern as lap_time_digit_renderer_a — renders BCD lap time as digit tiles to SH2
; framebuffer at $0601F000. Reads 4 BCD bytes from (A2)+, rendering 7 digit
; tiles + 2 separators via bcd_nibble_splitter (nibble split) and digit_tile_dma
; (tile DMA).
;
; Entry: A1 = destination tile pointer, A2 = BCD time data pointer
; Exit: A1 advanced past tiles, A2 advanced 4 bytes
; Uses: D1, D3, A1, A2
; Calls:
;   bcd_nibble_splitter: BCD nibble splitter
;   digit_tile_dma: digit tile DMA to $0601F000
; ============================================================================

lap_time_digit_renderer:
        MOVE.B  (A2)+,D3                        ; $01259C
        bsr.w   bcd_nibble_splitter     ; $6100 $0030
        MOVE.W  #$000A,D1                       ; $0125A2
        bsr.w   digit_tile_dma          ; $6100 $0044
        ADDQ.L  #8,A1                           ; $0125AA
        MOVE.B  (A2)+,D3                        ; $0125AC
        bsr.w   bcd_nibble_splitter     ; $6100 $0020
        MOVE.W  #$000B,D1                       ; $0125B2
        bsr.w   digit_tile_dma          ; $6100 $0034
        ADDQ.L  #8,A1                           ; $0125BA
        MOVE.B  (A2)+,D1                        ; $0125BC
        ANDI.W  #$000F,D1                       ; $0125BE
        bsr.w   digit_tile_dma          ; $6100 $0028
        ADDQ.L  #8,A1                           ; $0125C6
        MOVE.B  (A2)+,D3                        ; $0125C8
        bsr.w   bcd_nibble_splitter     ; $6100 $0004
        RTS                                     ; $0125CE
