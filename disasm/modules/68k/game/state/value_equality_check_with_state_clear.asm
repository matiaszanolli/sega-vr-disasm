; ============================================================================
; value_equality_check_with_state_clear — Value Equality Check with State Clear
; ROM Range: $008522-$008532 (16 bytes)
; Compares D4 and D5. If not equal, branches past function to object_state_assignment_008532.
; If equal, clears (A4), returns D0=0/D1=$0E. Paired with object_state_assignment_008532 as
; the not-equal handler.
;
; Entry: D4, D5 = values to compare, A4 = state output pointer
; Uses: D0, D1, D4, D5, A4
; Confidence: high
; ============================================================================

value_equality_check_with_state_clear:
        CMP.L  D4,D5                            ; $008522
        DC.W    $6612               ; BNE.S  $008538; $008524
        MOVE.L  #$00000000,(A4)                 ; $008526
        MOVEQ   #$0E,D1                         ; $00852C
        MOVEQ   #$00,D0                         ; $00852E
        RTS                                     ; $008530
