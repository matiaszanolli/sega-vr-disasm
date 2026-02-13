; ============================================================================
; fn_10200_034 — BCD Nibble Splitter C
; ROM Range: $01197E-$01199A (28 bytes)
; ============================================================================
; Same logic as fn_10200_015/031 — splits byte in D3 into high and low
; nibbles, rendering each as a digit tile via fn_10200_035. Advances A1 by
; 8 after each tile (total +16).
;
; Entry: D3 = BCD byte, A1 = destination tile pointer
; Exit: A1 advanced by 16
; Uses: D1, D3, A1
; Calls:
;   fn_10200_035: digit tile blit to framebuffer
; ============================================================================

fn_10200_034:
        MOVE.B  D3,D1                           ; $01197E
        LSR.B  #4,D1                            ; $011980
        ANDI.W  #$000F,D1                       ; $011982
        DC.W    $6100,$0012         ; BSR.W  $01199A; $011986
        ADDQ.L  #8,A1                           ; $01198A
        MOVE.W  D3,D1                           ; $01198C
        ANDI.W  #$000F,D1                       ; $01198E
        DC.W    $6100,$0006         ; BSR.W  $01199A; $011992
        ADDQ.L  #8,A1                           ; $011996
        RTS                                     ; $011998
