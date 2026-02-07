; ============================================================================
; Fm Dispatch 013 (auto-analyzed)
; ROM Range: $0305BA-$03061C (98 bytes)
; ============================================================================
; Category: sound
; Purpose: State dispatcher using jump table
;   Calls: z80_bus_request
;
; Uses: D7
; Calls:
;   $030D1C: z80_bus_request
; Confidence: medium
; ============================================================================

fn_30200_013:
        SUBI.B  #$F0,D7                         ; $0305BA
        LSL.W  #2,D7                            ; $0305BE
        JMP     $0305C4(PC,D7.W)                ; $0305C0
        DC.W    $6000,$0496         ; BRA.W  $030A5C; $0305C4
        DC.W    $6000,$0384         ; BRA.W  $03094E; $0305C8
        DC.W    $6000,$0424         ; BRA.W  $0309F2; $0305CC
        DC.W    $6000,$05BE         ; BRA.W  $030B90; $0305D0
        DC.W    $6000,$05BA         ; BRA.W  $030B90; $0305D4
        DC.W    $6000,$05B6         ; BRA.W  $030B90; $0305D8
        DC.W    $6000,$05B2         ; BRA.W  $030B90; $0305DC
        DC.W    $6000,$05AE         ; BRA.W  $030B90; $0305E0
        DC.W    $6000,$05AA         ; BRA.W  $030B90; $0305E4
        DC.W    $6000,$05A6         ; BRA.W  $030B90; $0305E8
        DC.W    $6000,$05A2         ; BRA.W  $030B90; $0305EC
        DC.W    $6000,$059E         ; BRA.W  $030B90; $0305F0
        DC.W    $6000,$059A         ; BRA.W  $030B90; $0305F4
        DC.W    $6000,$0596         ; BRA.W  $030B90; $0305F8
        DC.W    $6000,$0592         ; BRA.W  $030B90; $0305FC
        DC.W    $6000,$058E         ; BRA.W  $030B90; $030600
        SUBI.B  #$D7,D7                         ; $030604
        DC.W    $4EBA,$0712         ; JSR     $030D1C(PC); $030608
        MOVE.B  D7,$00A00FFE                    ; $03060C
        MOVE.W  #$0000,$00A11100                ; $030612
        RTS                                     ; $03061A
