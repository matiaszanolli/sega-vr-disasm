; ============================================================================
; PSG Set Position + Silence — envelope position set and PSG mute
; ROM Range: $030FA2-$030FC8 (38 bytes)
; ============================================================================
; Multiple entry points:
;   $030FA2: Set envelope position from next data byte, resume reading.
;   $030FAA: Clear envelope position to 0, resume reading.
;   $030FB2 (fm_set_volume / PSG silence): Checks key-off (bit 2). If
;     not set, writes PSG max attenuation (channel | $1F) to $C00011.
;
; Entry: A5 = PSG channel structure pointer
; Uses: D0, A0
; Confidence: high
; ============================================================================

fn_30200_037:
        MOVE.B  $01(A0,D0.W),$000C(A5)          ; $030FA2
        DC.W    $6084               ; BRA.S  $030F2E; $030FA8
        CLR.B  $000C(A5)                        ; $030FAA
        DC.W    $6000,$FF7E         ; BRA.W  $030F2E; $030FAE
        BTST    #2,(A5)                         ; $030FB2
        BNE.S  .loc_0024                        ; $030FB6
        MOVE.B  $0001(A5),D0                    ; $030FB8
        ORI.B  #$1F,D0                          ; $030FBC
        MOVE.B  D0,PSG                    ; $030FC0
.loc_0024:
        RTS                                     ; $030FC6
