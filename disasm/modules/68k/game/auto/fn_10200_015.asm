; ============================================================================
; fn_10200_015 — BCD Nibble Splitter A
; ROM Range: $01063A-$010656 (28 bytes)
; ============================================================================
; Splits byte in D3 into high nibble (shift right 4) and low nibble (AND $0F),
; rendering each as a digit tile via fn_10200_016. Advances A1 by 8 after each
; tile (total +16 for both nibbles).
;
; Entry: D3 = BCD byte, A1 = destination tile pointer
; Exit: A1 advanced by 16
; Uses: D1, D3, A1
; Calls:
;   fn_10200_016: digit tile DMA to framebuffer A
; ============================================================================

fn_10200_015:
        MOVE.B  D3,D1                           ; $01063A
        LSR.B  #4,D1                            ; $01063C
        ANDI.W  #$000F,D1                       ; $01063E
        DC.W    $6100,$0012         ; BSR.W  $010656; $010642
        ADDQ.L  #8,A1                           ; $010646
        MOVE.W  D3,D1                           ; $010648
        ANDI.W  #$000F,D1                       ; $01064A
        DC.W    $6100,$0006         ; BSR.W  $010656; $01064E
        ADDQ.L  #8,A1                           ; $010652
        RTS                                     ; $010654
