; ============================================================================
; Entity Table Load (Mode+Index Combined)
; ROM Range: $00A80A-$00A83C (50 bytes)
; ============================================================================
; Loads entity data from a RAM lookup table into entity entries, using a
; combined mode and secondary index to select the table offset.
; Mode contributes stride of 96, secondary index contributes stride of 32.
;
; Uses: D0, D1, A1, A2
; RAM:
;   ($FDA9).W: Secondary table index (byte)
;   ($FAD8).W: RAM lookup table base
;   ($C8C8).W: Mode flag
;   ($9100).W: Entity table base (stride 256)
; ============================================================================

entity_table_load_mode:
        moveq   #0,d1
        dc.w    $1238,$FDA9             ; MOVE.B ($FDA9).W,D1 - secondary index
        dc.w    $43F8,$FAD8             ; LEA ($FAD8).W,A1 - RAM lookup table base
        dc.w    $3038,$C8C8             ; MOVE.W ($C8C8).W,D0 - mode flag
        muls.w  #$0060,d0               ; Mode offset = mode * 96
        muls.w  #$0020,d1               ; Index offset = index * 32
        add.w   d1,d0                   ; Combined offset
        dc.w    $43F1,$0000             ; LEA 0(A1,D0.W),A1 - point to selected entry
        dc.w    $45F8,$9100             ; LEA ($9100).W,A2 - entity table base ($FF9100)
        moveq   #14,d0                  ; Loop 15 times
.loop:
        move.w  (a1),$B6(a2)            ; Copy word to entity field +$B6
        move.w  (a1)+,$A(a2)            ; Copy same word to field +$A, advance A1
        lea     $100(a2),a2             ; Next entity (+256 byte stride)
        dbf     d0,.loop
        rts
