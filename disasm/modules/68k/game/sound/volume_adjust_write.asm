; ============================================================================
; Volume Adjust + Write — add delta and route to channel writer
; ROM Range: $031228-$031240 (24 bytes)
; ============================================================================
; Two entry points:
;   $031228: Reads volume delta from sequence (A4), adds to A5+$09.
;     If DAC channel (A6+$08 negative): calls z80_dac_write ($030DF4).
;     Otherwise calls FM register writer ($03135A).
;   $03123A: Sets sustain flag (bit 4 on A5) and returns.
;
; Entry: A5 = channel structure pointer, A4 = sequence pointer
; Entry: A6 = sound driver state pointer
; Uses: D0, A4
; Confidence: medium
; ============================================================================

volume_adjust_write:
        MOVE.B  (A4)+,D0                        ; $031228
        ADD.B  D0,$0009(A5)                     ; $03122A
        TST.B  $0008(A6)                        ; $03122E
        DC.W    $6B00,$FBC0         ; BMI.W  $030DF4; $031232
        DC.W    $6000,$0122         ; BRA.W  $03135A; $031236
        BSET    #4,(A5)                         ; $03123A
        RTS                                     ; $03123E
