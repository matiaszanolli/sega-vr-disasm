; ============================================================================
; default_palette_color_data — Default Palette Color Data
; ROM Range: $00E5AC-$00E5CE (34 bytes)
; Static palette color data table. Contains 12 CRAM color entries
; ($0EEE = white, $0000 = black) used as default/fallback palette.
; The RTS at end allows this to be called as a no-op initializer.
;
; Confidence: high
; ============================================================================

default_palette_color_data:
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
