; ============================================================================
; Fn E200 001
; ROM Range: $00E5AC-$00E5CE (34 bytes)
; Source: code_e200
; ============================================================================

fn_e200_001:
        DC.W    $0EEE                           ; $00E5AC
        DC.W    $0EEE                           ; $00E5AE
        DC.W    $0EEE                           ; $00E5B0
        DC.W    $0EEE                           ; $00E5B2
        ORI.B  #$00,D0                          ; $00E5B4
        ORI.B  #$00,D0                          ; $00E5B8
        DC.W    $0EEE                           ; $00E5BC
        DC.W    $0EEE                           ; $00E5BE
        DC.W    $0EEE                           ; $00E5C0
        DC.W    $0EEE                           ; $00E5C2
        ORI.B  #$00,D0                          ; $00E5C4
        ORI.B  #$00,D0                          ; $00E5C8
        RTS                                     ; $00E5CC
