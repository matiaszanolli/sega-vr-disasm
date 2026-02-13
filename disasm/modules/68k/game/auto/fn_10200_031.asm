; ============================================================================
; fn_10200_031 — BCD Nibble Splitter B
; ROM Range: $011908-$011924 (28 bytes)
; ============================================================================
; Identical logic to fn_10200_015 — splits byte in D3 into high and low
; nibbles, rendering each as a digit tile via fn_10200_032 (framebuffer B
; at $0601DF00). Advances A1 by 8 after each tile.
;
; Entry: D3 = BCD byte, A1 = destination tile pointer
; Exit: A1 advanced by 16
; Uses: D1, D3, A1
; Calls:
;   fn_10200_032: digit tile DMA to framebuffer B
; ============================================================================

fn_10200_031:
        MOVE.B  D3,D1                           ; $011908
        LSR.B  #4,D1                            ; $01190A
        ANDI.W  #$000F,D1                       ; $01190C
        DC.W    $6100,$0012         ; BSR.W  $011924; $011910
        ADDQ.L  #8,A1                           ; $011914
        MOVE.W  D3,D1                           ; $011916
        ANDI.W  #$000F,D1                       ; $011918
        DC.W    $6100,$0006         ; BSR.W  $011924; $01191C
        ADDQ.L  #8,A1                           ; $011920
        RTS                                     ; $011922
