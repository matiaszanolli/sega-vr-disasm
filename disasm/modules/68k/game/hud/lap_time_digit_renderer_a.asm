; ============================================================================
; lap_time_digit_renderer_a — Lap Time Digit Renderer A
; ROM Range: $010606-$01063A (52 bytes)
; ============================================================================
; Renders a BCD-encoded lap time as digit tiles to SH2 framebuffer region A
; ($06023200). Reads 4 bytes from (A2)+: byte 1 → 2 digit tiles + separator
; (tile 10), byte 2 → 2 digits + separator (tile 11), byte 3 → 1 digit (low
; nibble only), byte 4 → 2 digits. Total: 7 digit tiles + 2 separators.
;
; Entry: A1 = destination tile pointer, A2 = BCD time data pointer
; Exit: A1 advanced past tiles, A2 advanced 4 bytes
; Uses: D1, D3, A1, A2
; Calls:
;   bcd_nibble_splitter_a: BCD nibble splitter (high + low digit tiles)
;   digit_tile_dma_to_framebuffer_a: single digit tile DMA to framebuffer A
; ============================================================================

lap_time_digit_renderer_a:
        MOVE.B  (A2)+,D3                        ; $010606
        DC.W    $6100,$0030         ; BSR.W  $01063A; $010608
        MOVE.W  #$000A,D1                       ; $01060C
        DC.W    $6100,$0044         ; BSR.W  $010656; $010610
        ADDQ.L  #8,A1                           ; $010614
        MOVE.B  (A2)+,D3                        ; $010616
        DC.W    $6100,$0020         ; BSR.W  $01063A; $010618
        MOVE.W  #$000B,D1                       ; $01061C
        DC.W    $6100,$0034         ; BSR.W  $010656; $010620
        ADDQ.L  #8,A1                           ; $010624
        MOVE.B  (A2)+,D1                        ; $010626
        ANDI.W  #$000F,D1                       ; $010628
        DC.W    $6100,$0028         ; BSR.W  $010656; $01062C
        ADDQ.L  #8,A1                           ; $010630
        MOVE.B  (A2)+,D3                        ; $010632
        DC.W    $6100,$0004         ; BSR.W  $01063A; $010634
        RTS                                     ; $010638
