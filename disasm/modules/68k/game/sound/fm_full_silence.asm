; ============================================================================
; FM Full Silence — stop all channels and reset tempo
; ROM Range: $030A5C-$030A72 (22 bytes)
; ============================================================================
; Calls channel stop ($03094E) to silence all FM/PSG channels, then calls
; special channel cleanup ($0309F2) for DAC/noise channels. Resets sound
; driver tempo: A6+$06=1 (tick rate), A6+$04=5 (frame divider).
;
; Entry: A6 = sound driver state pointer
; Uses: A6
; Confidence: high
; ============================================================================

fm_full_silence:
        DC.W    $4EBA,$FEF0         ; JSR     $03094E(PC); $030A5C
        DC.W    $4EBA,$FF90         ; JSR     $0309F2(PC); $030A60
        MOVE.B  #$01,$0006(A6)                  ; $030A64
        MOVE.B  #$05,$0004(A6)                  ; $030A6A
        RTS                                     ; $030A70
