; ============================================================================
; Sequence Loop Counter — decrement loop and skip on exhaust
; ROM Range: $03150E-$031528 (26 bytes)
; ============================================================================
; Reads loop index and initial count from sequence (A4). Manages loop
; counter at A5+$2A+index. If counter is zero, initializes from count.
; Decrements counter each call. If nonzero: branches to $031502 (continue
; loop body). If exhausted (zero): skips 2 bytes in sequence (past loop
; target address) and returns.
;
; Entry: A5 = channel structure pointer, A4 = sequence pointer
; Uses: D0, D1, A4
; Confidence: medium
; ============================================================================

fn_30200_057:
        MOVEQ   #$00,D0                         ; $03150E
        MOVE.B  (A4)+,D0                        ; $031510
        MOVE.B  (A4)+,D1                        ; $031512
        TST.B  $2A(A5,D0.W)                     ; $031514
        BNE.S  .loc_0010                        ; $031518
        MOVE.B  D1,$2A(A5,D0.W)                 ; $03151A
.loc_0010:
        SUBQ.B  #1,$2A(A5,D0.W)                 ; $03151E
        DC.W    $66DE               ; BNE.S  $031502; $031522
        ADDQ.W  #2,A4                           ; $031524
        RTS                                     ; $031526
