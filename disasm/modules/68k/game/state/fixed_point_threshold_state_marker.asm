; ============================================================================
; fixed_point_threshold_state_marker — Fixed-Point Threshold State Marker
; ROM Range: $00850E-$008522 (20 bytes)
; Compares D5 against fixed-point threshold $60000000. If below, falls
; through (no action). If at or above, writes sentinel $DDDD0DDD to (A4)
; and returns D0=1/D1=0. Marks object as exceeding the threshold.
;
; Entry: D5 = fixed-point value, A4 = object pointer
; Uses: D0, D1, D5, A4
; Confidence: high
; ============================================================================

fixed_point_threshold_state_marker:
        CMPI.L  #$60000000,D5                   ; $00850E
        DC.W    $6D0C               ; BLT.S  $008522; $008514
        MOVE.L  #$DDDD0DDD,(A4)                 ; $008516
        MOVEQ   #$01,D0                         ; $00851C
        MOVEQ   #$00,D1                         ; $00851E
        RTS                                     ; $008520
