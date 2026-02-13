; ============================================================================
; VDP Tile Unpack (12 regions)
; ROM Range: $0024CA-$002594 (202 bytes)
; ============================================================================
; Unpacks tile data to 12 VRAM regions via repeated calls to
; unpack_tiles_vdp. Each call sets a VRAM write address command
; via (A5) and loads A0 with the source tile data pointer.
; Skipped entirely if tile_update_flag ($C80D) is set.
;
; Entry: A5 = VDP control port
; Uses: A0, A5
; RAM:
;   $C80D: tile_update_flag (nonzero = skip)
;   $C880: vscroll_a (set to $FFF8 during unpack)
; Calls:
;   $00247C: unpack_tiles_vdp (JSR PC-relative, called 12 times)
; ============================================================================

vdp_tile_unpack_0024ca:
        tst.b   ($FFFFC80D).w                   ; tile update needed?
        bne.w   .done                            ; no → skip all
        move.w  #$0000,($FFFF8000).w            ; clear hscroll_a
        move.w  #$FFF8,($FFFFC880).w            ; vscroll_a = -8
; --- unpack 12 tile regions ---
        lea     $00FF6116,a0                    ; tile source 1
        move.l  #$62020002,(a5)                 ; VRAM write addr
        dc.w    $4EBA,$FF90                      ; jsr unpack_tiles_vdp(pc) → $00247C
        lea     ($FFFF9032).w,a0                ; tile source 2
        move.l  #$620C0002,(a5)
        dc.w    $4EBA,$FF82                      ; jsr unpack_tiles_vdp(pc) → $00247C
        lea     $00FF611A,a0                    ; tile source 3
        move.l  #$62160002,(a5)
        dc.w    $4EBA,$FF72                      ; jsr unpack_tiles_vdp(pc) → $00247C
        lea     $00FF6108,a0                    ; tile source 4
        move.l  #$63020002,(a5)
        dc.w    $4EBA,$FF62                      ; jsr unpack_tiles_vdp(pc) → $00247C
        lea     $00FF610A,a0                    ; tile source 5
        move.l  #$630C0002,(a5)
        dc.w    $4EBA,$FF52                      ; jsr unpack_tiles_vdp(pc) → $00247C
        lea     $00FF610C,a0                    ; tile source 6
        move.l  #$63160002,(a5)
        dc.w    $4EBA,$FF42                      ; jsr unpack_tiles_vdp(pc) → $00247C
        lea     $00FF6104,a0                    ; tile source 7
        move.l  #$632A0002,(a5)
        dc.w    $4EBA,$FF32                      ; jsr unpack_tiles_vdp(pc) → $00247C
        lea     $00FF6106,a0                    ; tile source 8
        move.l  #$63340002,(a5)
        dc.w    $4EBA,$FF22                      ; jsr unpack_tiles_vdp(pc) → $00247C
        lea     $00FF5FF8,a0                    ; tile source 9
        move.l  #$640C0002,(a5)
        dc.w    $4EBA,$FF12                      ; jsr unpack_tiles_vdp(pc) → $00247C
        move.l  #$64160002,(a5)                 ; tile source 9 continued
        dc.w    $4EBA,$FF08                      ; jsr unpack_tiles_vdp(pc) → $00247C
        move.l  #$64200002,(a5)
        dc.w    $4EBA,$FEFE                      ; jsr unpack_tiles_vdp(pc) → $00247C
        move.l  #$642A0002,(a5)
        dc.w    $4EBA,$FEF4                      ; jsr unpack_tiles_vdp(pc) → $00247C
        move.b  #$00,$00FF5FFF                  ; clear tile buffer flag
.done:
        rts
