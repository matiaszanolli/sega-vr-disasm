; ============================================================================
; Fm 057 (auto-analyzed)
; ROM Range: $03150E-$031528 (26 bytes)
; ============================================================================
; Category: sound
; Purpose: Short helper function
;   Object (A5): +$2A
;
; Entry: A5 = object/entity pointer
; Uses: D0, D1, A4, A5
; Object fields:
;   +$2A: [unknown]
; Confidence: low
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
