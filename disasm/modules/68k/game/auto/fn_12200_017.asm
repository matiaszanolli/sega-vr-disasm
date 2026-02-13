; ============================================================================
; fn_12200_017 — Lap Time Digit Renderer (Records Screen)
; ROM Range: $01259C-$0125D0 (52 bytes)
; ============================================================================
; Same pattern as fn_10200_014 — renders BCD lap time as digit tiles to SH2
; framebuffer at $0601F000. Reads 4 BCD bytes from (A2)+, rendering 7 digit
; tiles + 2 separators via fn_12200_018 (nibble split) and fn_12200_019
; (tile DMA).
;
; Entry: A1 = destination tile pointer, A2 = BCD time data pointer
; Exit: A1 advanced past tiles, A2 advanced 4 bytes
; Uses: D1, D3, A1, A2
; Calls:
;   fn_12200_018: BCD nibble splitter
;   fn_12200_019: digit tile DMA to $0601F000
; ============================================================================

fn_12200_017:
        MOVE.B  (A2)+,D3                        ; $01259C
        DC.W    $6100,$0030         ; BSR.W  $0125D0; $01259E
        MOVE.W  #$000A,D1                       ; $0125A2
        DC.W    $6100,$0044         ; BSR.W  $0125EC; $0125A6
        ADDQ.L  #8,A1                           ; $0125AA
        MOVE.B  (A2)+,D3                        ; $0125AC
        DC.W    $6100,$0020         ; BSR.W  $0125D0; $0125AE
        MOVE.W  #$000B,D1                       ; $0125B2
        DC.W    $6100,$0034         ; BSR.W  $0125EC; $0125B6
        ADDQ.L  #8,A1                           ; $0125BA
        MOVE.B  (A2)+,D1                        ; $0125BC
        ANDI.W  #$000F,D1                       ; $0125BE
        DC.W    $6100,$0028         ; BSR.W  $0125EC; $0125C2
        ADDQ.L  #8,A1                           ; $0125C6
        MOVE.B  (A2)+,D3                        ; $0125C8
        DC.W    $6100,$0004         ; BSR.W  $0125D0; $0125CA
        RTS                                     ; $0125CE
