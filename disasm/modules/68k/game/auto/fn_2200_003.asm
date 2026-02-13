; ============================================================================
; fn_2200_003 — Weighted Timer Average A
; ROM Range: $0022AA-$0022D6 (44 bytes)
; ============================================================================
; Computes weighted average for frame timing smoothing:
;   D1 = (D0/16) * ~1.8 + $1A5E, then average with (A1): D1 = (D1 + (A1))/2
; Clamps result to range [$1A5E, $21D0]. Stores result to (A1).
; Used for adaptive V-INT timing (wider range variant).
;
; Entry: D0 = raw timing input, A1 = timer storage pointer
; Exit: D1 = smoothed timing value, (A1) = updated
; Uses: D0, D1, A1
; ============================================================================

fn_2200_003:
        LSR.W  #4,D0                            ; $0022AA
        MOVE.W  D0,D1                           ; $0022AC
        LSR.W  #1,D0                            ; $0022AE
        ADD.W   D0,D1                           ; $0022B0
        LSR.W  #1,D0                            ; $0022B2
        ADD.W   D0,D1                           ; $0022B4
        LSR.W  #2,D0                            ; $0022B6
        ADD.W   D0,D1                           ; $0022B8
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
