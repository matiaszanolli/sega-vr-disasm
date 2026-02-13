; ============================================================================
; PSG All Silence — mute all 4 PSG channels
; ROM Range: $030FC8-$030FE0 (24 bytes)
; ============================================================================
; Writes maximum attenuation to all 4 PSG channels via $C00011:
;   $9F (ch0 vol=F), $BF (ch1 vol=F), $DF (ch2 vol=F), $FF (ch3 vol=F).
; Standard PSG silence pattern used during sound driver reset.
;
; Uses: A0
; Confidence: high
; ============================================================================

psg_all_silence:
        LEA     PSG,A0                    ; $030FC8
        MOVE.B  #$9F,(A0)                       ; $030FCE
        MOVE.B  #$BF,(A0)                       ; $030FD2
        MOVE.B  #$DF,(A0)                       ; $030FD6
        MOVE.B  #$FF,(A0)                       ; $030FDA
        RTS                                     ; $030FDE
