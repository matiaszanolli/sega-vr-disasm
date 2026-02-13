; ============================================================================
; fn_10200_033 — Lap Time Digit Renderer C (Register-Saving)
; ROM Range: $011942-$01197E (60 bytes)
; ============================================================================
; Same logic as fn_10200_014/030 but saves/restores D3/D4 on stack via MOVEM.
; Renders BCD lap time as digit tiles to SH2 framebuffer region B ($0601DF00).
; Reads 4 BCD bytes from (A2)+, rendering 7 digit tiles + 2 separators via
; fn_10200_034 (nibble split) and fn_10200_035 (tile blit).
;
; Entry: A1 = destination tile pointer, A2 = BCD time data pointer
; Exit: A1 advanced past tiles, A2 advanced 4 bytes
; Uses: D1, D3, D4, A1, A2
; Calls:
;   fn_10200_034: BCD nibble splitter C
;   fn_10200_035: digit tile blit to framebuffer
; ============================================================================

fn_10200_033:
        MOVEM.L D3/D4,-(A7)                     ; $011942
        MOVE.B  (A2)+,D3                        ; $011946
        DC.W    $6100,$0034         ; BSR.W  $01197E; $011948
        MOVE.W  #$000A,D1                       ; $01194C
        DC.W    $6100,$0048         ; BSR.W  $01199A; $011950
        ADDQ.L  #8,A1                           ; $011954
        MOVE.B  (A2)+,D3                        ; $011956
        DC.W    $6100,$0024         ; BSR.W  $01197E; $011958
        MOVE.W  #$000B,D1                       ; $01195C
        DC.W    $6100,$0038         ; BSR.W  $01199A; $011960
        ADDQ.L  #8,A1                           ; $011964
        MOVE.B  (A2)+,D1                        ; $011966
        ANDI.W  #$000F,D1                       ; $011968
        DC.W    $6100,$002C         ; BSR.W  $01199A; $01196C
        ADDQ.L  #8,A1                           ; $011970
        MOVE.B  (A2)+,D3                        ; $011972
        DC.W    $6100,$0008         ; BSR.W  $01197E; $011974
        MOVEM.L (A7)+,D3/D4                     ; $011978
        RTS                                     ; $01197C
