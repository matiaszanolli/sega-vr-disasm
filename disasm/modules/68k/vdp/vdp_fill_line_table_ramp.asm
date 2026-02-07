; ============================================================================
; VDP Fill Line Table (Ramp)
; ROM Range: $0027B6-$0027D8 (36 bytes)
; ============================================================================
; Fills line table with incrementing addresses for linear scanline display.
;
; Entry: none
; Uses: A1, D0, D1, D7
; ============================================================================

vdp_fill_line_table_ramp:
        andi.b  #$40,$00A15181        ; Configure VDP access
        lea     $00840000,a1          ; Line table base
        move.w  #$0100,d0             ; Stride increment
        move.w  #$2000,d1             ; Starting offset
        move.w  #$00DF,d7             ; 224 lines
.loop:
        move.w  d1,(a1)+              ; Write current offset
        add.w   d0,d1                 ; Advance by stride
        dbra    d7,.loop
        rts
