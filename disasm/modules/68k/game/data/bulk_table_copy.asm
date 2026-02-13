; ============================================================================
; Bulk Table Copy (Two ROM Blocks to RAM)
; ROM Range: $00A83E-$00A866 (40 bytes)
; ============================================================================
; Copies two ROM data blocks to RAM during initialization:
;   Block 1: 288 bytes from $00937E7E to ($FAD8).W
;   Block 2: 432 bytes from $00937F9E to ($FBF8).W
;
; Uses: D0, A1, A2
; ============================================================================

bulk_table_copy:
        lea     $00937E7E,a1            ; First ROM data block (288 bytes)
        dc.w    $45F8,$FAD8             ; LEA ($FAD8).W,A2 - RAM destination ($FFFAD8)
        move.w  #$0047,d0               ; 72 longwords (288 bytes)
.loop1:
        move.l  (a1)+,(a2)+             ; Copy 4 bytes
        dbf     d0,.loop1
        lea     $00937F9E,a1            ; Second ROM data block (432 bytes)
        dc.w    $45F8,$FBF8             ; LEA ($FBF8).W,A2 - RAM destination ($FFFBF8)
        move.w  #$006B,d0               ; 108 longwords (432 bytes)
.loop2:
        move.l  (a1)+,(a2)+             ; Copy 4 bytes
        dbf     d0,.loop2
        rts
