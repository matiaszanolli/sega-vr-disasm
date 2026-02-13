; ============================================================================
; digit_extraction_via_division — Digit Extraction via Division
; ROM Range: $0082E8-$0082FA (18 bytes)
; Data prefix (2 bytes) followed by a division chain. Performs three
; successive DIVU operations to extract digits from D1, writing each
; remainder byte to the output buffer via OR.B D1,(A0)+.
;
; Entry: D1 = value to extract digits from, A0 = output buffer pointer
; Uses: D1, A0
; Confidence: medium
; ============================================================================

digit_extraction_via_division:
        DC.W    $0088                           ; $0082E8
        DIVU    ($0088).W,D1                    ; $0082EA
        DIVU    ($0088).W,D1                    ; $0082EE
        DC.W    $82FA,$0088         ; DIVU    $00837C(PC),D1; $0082F2
        OR.B   D1,(A0)+                         ; $0082F6
        RTS                                     ; $0082F8
