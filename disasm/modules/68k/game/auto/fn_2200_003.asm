; ============================================================================
; Vint 003 (auto-analyzed)
; ROM Range: $0022AA-$0022D6 (44 bytes)
; ============================================================================
; Category: vint
; Purpose: Function in 2200 section (44 bytes)
;
; Uses: D0, D1, A1
; Confidence: low
; ============================================================================

fn_2200_003:
        LSR.W  #4,D0                            ; $0022AA
        MOVE.W  D0,D1                           ; $0022AC
        LSR.W  #1,D0                            ; $0022AE
        DC.W    $D240                           ; $0022B0
        LSR.W  #1,D0                            ; $0022B2
        DC.W    $D240                           ; $0022B4
        LSR.W  #2,D0                            ; $0022B6
        DC.W    $D240                           ; $0022B8
        ADDI.W  #$1A5E,D1                       ; $0022BA
        ADD.W  (A1),D1                          ; $0022BE
        LSR.W  #1,D1                            ; $0022C0
        CMPI.W  #$21D0,D1                       ; $0022C2
        DC.W    $6E0E               ; BGT.S  $0022D6; $0022C6
        CMPI.W  #$1A5E,D1                       ; $0022C8
        DC.W    $6E0C               ; BGT.S  $0022DA; $0022CC
        MOVE.W  #$1A5E,D1                       ; $0022CE
        MOVE.W  D1,(A1)                         ; $0022D2
        RTS                                     ; $0022D4
