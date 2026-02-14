; ============================================================================
; VDP Tile Unpack (12× Calls to unpack_tiles_vdp)
; ROM Range: $0025B0-$00263E (142 bytes)
; ============================================================================
; Category: game
; Purpose: If skip_flag ($C80D) is clear: unpacks tile data to two
;   VRAM nametable rows via 12 calls to unpack_tiles_vdp ($00247C).
;   Row A: VDP addresses $6502/$6514/$651E/$6528/$6532 (6 calls).
;   Row B: VDP addresses $6602/$6614/$661E/$6628/$6632 (6 calls).
;   Uses tile_source_ptr ($C888) as source, advancing by 8 between
;   rows and restoring after.
;
; Uses: A0, A5
; RAM:
;   $C80D: skip_flag (byte, nonzero = skip)
;   $C888: tile_source_ptr (longword)
; Calls:
;   $00247C: unpack_tiles_vdp (12×)
; ============================================================================

vdp_tile_unpack_0025b0:
        tst.b   ($FFFFC80D).w                   ; $0025B0  skip flag set?
        bne.w   .done                           ; $0025B4  yes → done
; --- row A: VRAM $6502-$6532 ---
        lea     ($FFFFC888).w,A0                ; $0025B8  A0 → tile_source_ptr
        move.l  #$65020002,(A5)                 ; $0025BC  VDP addr = $6502
        jsr     pixel_unpack_2pairs(pc) ; $4EBA $FEB8
        jsr     pixel_unpack_2pairs(pc) ; $4EBA $FEB4
        movea.l ($FFFFC888).w,A0                ; $0025CA  reload source ptr
        move.l  #$65140002,(A5)                 ; $0025CE  VDP addr = $6514
        jsr     pixel_unpack_2pairs(pc) ; $4EBA $FEA6
        move.l  #$651E0002,(A5)                 ; $0025D8  VDP addr = $651E
        jsr     pixel_unpack_2pairs(pc) ; $4EBA $FE9C
        move.l  #$65280002,(A5)                 ; $0025E2  VDP addr = $6528
        jsr     pixel_unpack_2pairs(pc) ; $4EBA $FE92
        move.l  #$65320002,(A5)                 ; $0025EC  VDP addr = $6532
        jsr     pixel_unpack_2pairs(pc) ; $4EBA $FE88
; --- advance source by 8, start row B ---
        addq.l  #8,($FFFFC888).w                ; $0025F6  source ptr += 8
        lea     ($FFFFC888).w,A0                ; $0025FA  A0 → tile_source_ptr
        move.l  #$66020002,(A5)                 ; $0025FE  VDP addr = $6602
        jsr     pixel_unpack_2pairs(pc) ; $4EBA $FE76
        jsr     pixel_unpack_2pairs(pc) ; $4EBA $FE72
        movea.l ($FFFFC888).w,A0                ; $00260C  reload source ptr
        move.l  #$66140002,(A5)                 ; $002610  VDP addr = $6614
        jsr     pixel_unpack_2pairs(pc) ; $4EBA $FE64
        move.l  #$661E0002,(A5)                 ; $00261A  VDP addr = $661E
        jsr     pixel_unpack_2pairs(pc) ; $4EBA $FE5A
        move.l  #$66280002,(A5)                 ; $002624  VDP addr = $6628
        jsr     pixel_unpack_2pairs(pc) ; $4EBA $FE50
        move.l  #$66320002,(A5)                 ; $00262E  VDP addr = $6632
        jsr     pixel_unpack_2pairs(pc) ; $4EBA $FE46
; --- restore source pointer ---
        subq.l  #8,($FFFFC888).w                ; $002638  source ptr -= 8
.done:
        rts                                     ; $00263C

