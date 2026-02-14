; ============================================================================
; bcd_nibble_splitter — BCD Nibble Splitter (Records Screen)
; ROM Range: $0125D0-$0125EC (28 bytes)
; ============================================================================
; Same pattern as bcd_nibble_splitter_a — splits byte in D3 into high and low nibbles,
; rendering each as a digit tile via digit_tile_dma. Advances A1 by 8 per tile.
;
; Entry: D3 = BCD byte, A1 = destination tile pointer
; Exit: A1 advanced by 16
; Uses: D1, D3, A1
; Calls:
;   digit_tile_dma: digit tile DMA to $0601F000
; ============================================================================

bcd_nibble_splitter:
        MOVE.B  D3,D1                           ; $0125D0
        LSR.B  #4,D1                            ; $0125D2
        ANDI.W  #$000F,D1                       ; $0125D4
        bsr.w   digit_tile_dma          ; $6100 $0012
        ADDQ.L  #8,A1                           ; $0125DC
        MOVE.W  D3,D1                           ; $0125DE
        ANDI.W  #$000F,D1                       ; $0125E0
        bsr.w   digit_tile_dma          ; $6100 $0006
        ADDQ.L  #8,A1                           ; $0125E8
        RTS                                     ; $0125EA
