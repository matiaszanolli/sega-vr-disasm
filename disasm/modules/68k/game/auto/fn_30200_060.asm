; ============================================================================
; Fm Conditional Write 060 (auto-analyzed)
; ROM Range: $031574-$031590 (28 bytes)
; ============================================================================
; Category: sound
; Purpose: Short helper function
;   Calls: fm_conditional_write
;
; Uses: D0, D1, D3, A1, A4
; Calls:
;   $030CA2: fm_conditional_write
; Confidence: medium
; ============================================================================

fn_30200_060:
        DC.W    $43FA,$001A         ; LEA     $031590(PC),A1; $031574
        MOVEQ   #$03,D3                         ; $031578
.loc_0006:
        MOVE.B  (A1)+,D0                        ; $03157A
        MOVE.B  (A4)+,D1                        ; $03157C
        DC.W    $4EBA,$F722         ; JSR     $030CA2(PC); $03157E
        MOVE.B  (A1)+,D0                        ; $031582
        MOVEQ   #$1F,D1                         ; $031584
        DC.W    $4EBA,$F71A         ; JSR     $030CA2(PC); $031586
        DBRA    D3,.loc_0006                    ; $03158A
        RTS                                     ; $03158E
