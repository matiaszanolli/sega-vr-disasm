; ============================================================================
; lap_time_digit_renderer_b — Lap Time Digit Renderer B
; ROM Range: $0118D4-$011908 (52 bytes)
; ============================================================================
; Identical logic to lap_time_digit_renderer_a but renders to SH2 framebuffer region B
; ($0601DF00) for the second display area (2-player mode). Reads 4 BCD bytes
; from (A2)+, rendering 7 digit tiles + 2 separator tiles via bcd_nibble_splitter_b
; (nibble split) and digit_tile_dma_to_framebuffer_b (tile DMA).
;
; Entry: A1 = destination tile pointer, A2 = BCD time data pointer
; Exit: A1 advanced past tiles, A2 advanced 4 bytes
; Uses: D1, D3, A1, A2
; Calls:
;   bcd_nibble_splitter_b: BCD nibble splitter B
;   digit_tile_dma_to_framebuffer_b: digit tile DMA to framebuffer B
; ============================================================================

lap_time_digit_renderer_b:
        MOVE.B  (A2)+,D3                        ; $0118D4
        DC.W    $6100,$0030         ; BSR.W  $011908; $0118D6
        MOVE.W  #$000A,D1                       ; $0118DA
        DC.W    $6100,$0044         ; BSR.W  $011924; $0118DE
        ADDQ.L  #8,A1                           ; $0118E2
        MOVE.B  (A2)+,D3                        ; $0118E4
        DC.W    $6100,$0020         ; BSR.W  $011908; $0118E6
        MOVE.W  #$000B,D1                       ; $0118EA
        DC.W    $6100,$0034         ; BSR.W  $011924; $0118EE
        ADDQ.L  #8,A1                           ; $0118F2
        MOVE.B  (A2)+,D1                        ; $0118F4
        ANDI.W  #$000F,D1                       ; $0118F6
        DC.W    $6100,$0028         ; BSR.W  $011924; $0118FA
        ADDQ.L  #8,A1                           ; $0118FE
        MOVE.B  (A2)+,D3                        ; $011900
        DC.W    $6100,$0004         ; BSR.W  $011908; $011902
        RTS                                     ; $011906
