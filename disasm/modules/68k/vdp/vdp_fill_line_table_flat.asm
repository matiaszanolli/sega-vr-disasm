; ============================================================================
; VDP Fill Line Table (Flat)
; ROM Range: $002798-$0027B4 (30 bytes)
; ============================================================================
; Fills VDP line table with constant value for all 224 display lines.
;
; Entry: none
; Uses: A1, D2, D7
; ============================================================================

vdp_fill_line_table_flat:
        andi.b  #$40,$00A15181        ; Configure VDP access
        lea     $00840000,a1          ; Line table base
        move.w  #$1F00,d2             ; Constant line offset
        move.w  #$00DF,d7             ; 224 lines
.loop:
        move.w  d2,(a1)+              ; Write constant
        dbra    d7,.loop
        rts
