; ============================================================================
; Sprite Descriptor Table + SH2 Palette Load ($00E19E-$00E1FE)
; ============================================================================
; DATA ($E19E-$E1BA): 5 sprite descriptors (6 bytes each: flags, offset, id)
; CODE ($E1BC-$E1FE): sh2_palette_load — VDP CRAM init with nested loops
;   Sets up VDP palette transfer ($8F02 auto-inc), writes 28 palette entries
;   in an outer loop of 6 rows × inner loop of 8 colors, then fills 80
;   entries with $0000.
; ============================================================================

; --- 5 Sprite Descriptors ($00E19E-$00E1BA, 30 bytes DATA) ---
sprite_descriptor_table:
        dc.w    $0401        ; $00E19E
        dc.w    $4010        ; $00E1A0
        dc.w    $003A        ; $00E1A2
        dc.w    $0401        ; $00E1A4
        dc.w    $4049        ; $00E1A6
        dc.w    $003B        ; $00E1A8
        dc.w    $0401        ; $00E1AA
        dc.w    $4083        ; $00E1AC
        dc.w    $003A        ; $00E1AE
        dc.w    $0401        ; $00E1B0
        dc.w    $40BC        ; $00E1B2
        dc.w    $003A        ; $00E1B4
        dc.w    $0401        ; $00E1B6
        dc.w    $40F5        ; $00E1B8
        dc.w    $003B        ; $00E1BA

; --- sh2_palette_load ($00E1BC-$00E1FE, 68 bytes CODE) ---
sh2_palette_load:
        dc.w    $3ABC        ; $00E1BC
        dc.w    $8F02        ; $00E1BE
        dc.w    $2ABC        ; $00E1C0
        dc.w    $4000        ; $00E1C2
        dc.w    $0003        ; $00E1C4
        dc.w    $4240        ; $00E1C6
        dc.w    $761B        ; $00E1C8
        dc.w    $3200        ; $00E1CA
        dc.w    $E749        ; $00E1CC
        dc.w    $41F9        ; $00E1CE
        dc.w    $0088        ; $00E1D0
        dc.w    $E20C        ; $00E1D2
        dc.w    $41F0        ; $00E1D4
        dc.w    $1000        ; $00E1D6
        dc.w    $383C        ; $00E1D8
        dc.w    $0005        ; $00E1DA
        dc.w    $3A3C        ; $00E1DC
        dc.w    $0007        ; $00E1DE
        dc.w    $7C00        ; $00E1E0
        dc.w    $1C30        ; $00E1E2
        dc.w    $5000        ; $00E1E4
        dc.w    $0646        ; $00E1E6
        dc.w    $02F0        ; $00E1E8
        dc.w    $3C86        ; $00E1EA
        dc.w    $51CD        ; $00E1EC
        dc.w    $FFF2        ; $00E1EE
        dc.w    $51CC        ; $00E1F0
        dc.w    $FFEA        ; $00E1F2
        dc.w    $383C        ; $00E1F4
        dc.w    $004F        ; $00E1F6
        dc.w    $3CBC        ; $00E1F8
        dc.w    $0000        ; $00E1FA
        dc.w    $51CC        ; $00E1FC
        dc.w    $FFFA        ; $00E1FE
