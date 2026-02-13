; ============================================================================
; three_way_value_comparison_router — Three-Way Value Comparison Router
; ROM Range: $008368-$00837A (18 bytes)
; Compares D5 with longword at (A3). If equal: clears (A4), returns
; D0=0/D1=$0E. If less: falls through to object_state_assignment_00837a. If greater:
; branches to object_state_assignment_00838a. Routes to different state handlers based on
; comparison result.
;
; Entry: D5 = value to compare, A3 = reference pointer, A4 = state output
; Uses: D0, D1, D5, A3, A4
; Confidence: high
; ============================================================================

three_way_value_comparison_router:
        CMP.L  (A3),D5                          ; $008368
        DC.W    $6D0E               ; BLT.S  $00837A; $00836A
        DC.W    $6E1C               ; BGT.S  $00838A; $00836C
        MOVE.L  #$00000000,(A4)                 ; $00836E
        MOVEQ   #$0E,D1                         ; $008374
        MOVEQ   #$00,D0                         ; $008376
        RTS                                     ; $008378
