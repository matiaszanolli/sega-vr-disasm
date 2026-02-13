; ============================================================================
; sine_cosine_quadrant_lookup — Sine/Cosine Quadrant Lookup
; ROM Range: $008F4E-$008F88 (58 bytes)
; Shared sine/cosine lookup with two entry points:
;   $008F4E = cosine (adds 90° phase shift, falls through to sine)
;   $008F52 = sine
; Normalizes angle D0, extracts quadrant via shift, dispatches through
; jump table at $008F66 to load value from trig table at $00930000.
;
; Entry: D0 = angle (0-$FFFF = 0-360°)
; Exit: D0 = sine or cosine value (16-bit signed)
; Uses: D0, D1, A1
; Confidence: high
; ============================================================================

sine_cosine_quadrant_lookup:
        ADDI.W  #$4000,D0                       ; $008F4E
        MOVEQ   #$00,D1                         ; $008F52
        MOVE.W  D0,D1                           ; $008F54
        LSR.W  #6,D0                            ; $008F56
        LSL.L  #2,D1                            ; $008F58
        SWAP    D1                              ; $008F5A
        ADD.W   D1,D1                           ; $008F5C
        ADD.W   D1,D1                           ; $008F5E
        MOVEA.L $008F66(PC,D1.W),A1             ; $008F60
        JMP     (A1)                            ; $008F64
        DC.W    $0088                           ; $008F66
        DC.W    $8F7A                           ; $008F68
        DC.W    $0088                           ; $008F6A
        DC.W    $8F88                           ; $008F6C
        DC.W    $0088                           ; $008F6E
        OR.L   D7,(A4)+                         ; $008F70
        DC.W    $0088                           ; $008F72
        OR.L   D7,-$78(A0,D0.W)                 ; $008F74
        DIVS    D6,D7                           ; $008F78
        LEA     $00930000,A1                    ; $008F7A
        ADD.W   D0,D0                           ; $008F80
        MOVE.W  $00(A1,D0.W),D0                 ; $008F82
        RTS                                     ; $008F86
