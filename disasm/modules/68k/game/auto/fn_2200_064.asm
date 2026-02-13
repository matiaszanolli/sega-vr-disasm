; ============================================================================
; Proximity Loop Iterator B — advance and repeat fn_2200_063 inner loop
; ROM Range: $003C1A-$003C2A (16 bytes)
; ============================================================================
; Advances A1 by 10 bytes to next object entry, loops back to fn_2200_063
; inner loop body ($003BCC) via DBRA D7. If loop exhausted without match,
; clears output buffer visibility flag at (A2)+$00.
;
; Entry: A1 = current object pointer (advanced by $0A per iteration)
; Entry: A2 = output buffer pointer
; Entry: D7 = loop counter
; Uses: D7, A1
; Confidence: medium
; ============================================================================

fn_2200_064:
        LEA     $000A(A1),A1                    ; $003C1A
        DC.W    $51CF,$FFAC         ; DBRA    D7,$003BCC; $003C1E
        MOVE.W  #$0000,$0000(A2)                ; $003C22
        RTS                                     ; $003C28
