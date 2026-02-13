; ============================================================================
; time_array_entry_comparison — Time Array Entry Comparison
; ROM Range: $0084F4-$00850A (22 bytes)
; Compares indexed longword entries from two arrays (A2, A3). Decrements
; and scales index D1 to access entries. Returns D0=0 if A3 entry is
; nonzero and A2 entry >= A3 entry. Falls through to return_success_flag (D0=1)
; otherwise. Used by the time display orchestrator (dual_time_display_orch).
;
; Entry: D1 = entry count, A2 = array 1 base, A3 = array 2 base
; Uses: D0, D1, D4, D5, A2, A3
; Confidence: high
; ============================================================================

time_array_entry_comparison:
        SUBQ.W  #1,D1                           ; $0084F4
        LSL.W  #2,D1                            ; $0084F6
        MOVE.L  $00(A2,D1.W),D5                 ; $0084F8
        MOVE.L  $00(A3,D1.W),D4                 ; $0084FC
        DC.W    $6708               ; BEQ.S  $00850A; $008500
        CMP.L  D4,D5                            ; $008502
        DC.W    $6D04               ; BLT.S  $00850A; $008504
        MOVEQ   #$00,D0                         ; $008506
        RTS                                     ; $008508
