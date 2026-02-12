; ============================================================================
; Camera Tile Render (3D Array Index)
; ROM Range: $012534-$01259C (104 bytes)
; ============================================================================
; Category: game
; Purpose: Calculates 3D array offset into tile data at $EF08:
;   section (D0) × $3C0 + row (D1) × 160 + column (D2) × 8.
;   Then renders 6 tile strips, each calling 3 subroutines per strip.
;   Strips are spaced $2000 apart in destination, 8 bytes apart in source.
;
; Entry: D0 = section index, D1 = row index, D2 = column index, A1 = dest base
; Uses: D0, D1, D2, D3, D4, D5, A1, A2, A3, A4
; RAM:
;   $EF08: tile data base (long)
; Calls:
;   $01259C: tile_render_sub_A (A1=dest, A2=source)
;   $01260A: tile_render_sub_B (A1=dest, A2=source)
;   $0126A6: tile_render_sub_C (A1=dest, A2=source)
; ============================================================================

fn_12200_016:
        lea     ($FFFFEF08).w,A2                ; $012534  A2 = tile data base
        moveq   #$00,D3                         ; $012538  clear offset
        tst.b   D0                              ; $01253A  section == 0?
        beq.s   .calc_row                       ; $01253C  yes → skip section calc
        subq.w  #1,D0                           ; $01253E  D0 = section - 1
.section_loop:
        addi.l  #$000003C0,D3                   ; $012540  D3 += $3C0 (960) per section
        dbra    D0,.section_loop                ; $012546
.calc_row:
        adda.l  D3,A2                           ; $01254A  A2 += section offset
        dc.w    $D241                           ; $01254C  add.w d1,d1 — D1 × 2
        dc.w    $D241                           ; $01254E  add.w d1,d1 — D1 × 4
        dc.w    $D241                           ; $012550  add.w d1,d1 — D1 × 8
        dc.w    $D241                           ; $012552  add.w d1,d1 — D1 × 16
        move.w  D1,D3                           ; $012554  D3 = D1 × 16
        dc.w    $D241                           ; $012556  add.w d1,d1 — D1 × 32
        dc.w    $D241                           ; $012558  add.w d1,d1 — D1 × 64
        dc.w    $D243                           ; $01255A  add.w d3,d1 — D1 × 80
        dc.w    $D241                           ; $01255C  add.w d1,d1 — D1 × 160
        adda.l  D1,A2                           ; $01255E  A2 += row × 160
        dc.w    $D442                           ; $012560  add.w d2,d2 — D2 × 2
        dc.w    $D442                           ; $012562  add.w d2,d2 — D2 × 4
        dc.w    $D442                           ; $012564  add.w d2,d2 — D2 × 8
        adda.l  D2,A2                           ; $012566  A2 += column × 8
        move.w  #$0005,D4                       ; $012568  render 6 strips
        movea.l A1,A3                           ; $01256C  A3 = dest base (save)
        movea.l A2,A4                           ; $01256E  A4 = source base (save)
.render_strip:
        movea.l A3,A1                           ; $012570  A1 = current dest
        movea.l A4,A2                           ; $012572  A2 = current source
        dc.w    $6100,$0094                     ; $012574  bsr.w tile_render_sub_B ($01260A)
        adda.l  #$00000010,A1                   ; $012578  dest += $10
        move.b  (A2)+,D5                        ; $01257E  D5 = source byte
        dc.w    $6100,$001A                     ; $012580  bsr.w tile_render_sub_A ($01259C)
        adda.l  #$00000020,A1                   ; $012584  dest += $20
        dc.w    $6100,$011A                     ; $01258A  bsr.w tile_render_sub_C ($0126A6)
        adda.l  #$00002000,A3                   ; $01258E  dest base += $2000 (next strip)
        addq.l  #8,A4                           ; $012594  source base += 8
        dbra    D4,.render_strip                ; $012596
        rts                                     ; $01259A
