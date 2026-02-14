; ============================================================================
; bcd_nibble_splitter_a — BCD Nibble Splitter A
; ROM Range: $01063A-$010656 (28 bytes)
; ============================================================================
; Splits byte in D3 into high nibble (shift right 4) and low nibble (AND $0F),
; rendering each as a digit tile via digit_tile_dma_to_framebuffer_a. Advances A1 by 8 after each
; tile (total +16 for both nibbles).
;
; Entry: D3 = BCD byte, A1 = destination tile pointer
; Exit: A1 advanced by 16
; Uses: D1, D3, A1
; Calls:
;   digit_tile_dma_to_framebuffer_a: digit tile DMA to framebuffer A
; ============================================================================

bcd_nibble_splitter_a:
        MOVE.B  D3,D1                           ; $01063A
        LSR.B  #4,D1                            ; $01063C
        ANDI.W  #$000F,D1                       ; $01063E
        bsr.w   digit_tile_dma_to_framebuffer_a; $6100 $0012
        ADDQ.L  #8,A1                           ; $010646
        MOVE.W  D3,D1                           ; $010648
        ANDI.W  #$000F,D1                       ; $01064A
        bsr.w   digit_tile_dma_to_framebuffer_a; $6100 $0006
        ADDQ.L  #8,A1                           ; $010652
        RTS                                     ; $010654
