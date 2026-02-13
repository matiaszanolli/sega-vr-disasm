; ============================================================================
; TL Reset + Panning Envelope Setup — reset volumes or init envelope
; ROM Range: $0311E8-$03120C (36 bytes)
; ============================================================================
; Two entry points:
;   $0311E8: Calls TL reset ($030B1C) to silence all operators, then
;     branches to $031418 for further processing.
;   $0311F0: Sets panning state index (A5+$28) from sequence byte. If
;     zero, returns. Otherwise reads 4 envelope parameters from sequence:
;     instrument ($20), position ($21), length ($22), repeat ($23=$24).
;
; Entry: A5 = channel structure pointer, A4 = sequence pointer
; Uses: A4
; Confidence: medium
; ============================================================================

fn_30200_045:
        DC.W    $4EBA,$F932         ; JSR     $030B1C(PC); $0311E8
        DC.W    $6000,$022A         ; BRA.W  $031418; $0311EC
        MOVE.B  (A4)+,$0028(A5)                 ; $0311F0
        DC.W    $6716               ; BEQ.S  $03120C; $0311F4
        MOVE.B  (A4)+,$0020(A5)                 ; $0311F6
        MOVE.B  (A4)+,$0021(A5)                 ; $0311FA
        MOVE.B  (A4)+,$0022(A5)                 ; $0311FE
        MOVE.B  (A4),$0023(A5)                  ; $031202
        MOVE.B  (A4)+,$0024(A5)                 ; $031206
        RTS                                     ; $03120A
