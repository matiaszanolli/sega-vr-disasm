; ============================================================================
; entity_speed_guard — Entity Speed Guard
; ROM Range: $007C4A-$007C56 (12 bytes)
; Guard function with data prefix (4 bytes). Tests if entity speed (+$04)
; is zero; if so, returns immediately. Otherwise falls through to continue
; processing. Prevents updates on stationary entities.
;
; Entry: A0 = entity base pointer
; Uses: D0, A0
; Object fields: +$04 speed
; Confidence: high
; ============================================================================

entity_speed_guard:
        DIVU    #$0000,D0                       ; $007C4A
        TST.W  $0004(A0)                        ; $007C4E
        DC.W    $6602               ; BNE.S  $007C56; $007C52
        RTS                                     ; $007C54
