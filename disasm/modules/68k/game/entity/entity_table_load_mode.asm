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
        move.b  ($FFFFFDA9).w,d1        ; $1238 $FDA9 — secondary index
        lea     ($FFFFFAD8).w,a1        ; $43F8 $FAD8 — RAM lookup table base
        move.w  ($FFFFC8C8).w,d0        ; $3038 $C8C8 — mode flag
        muls.w  #$0060,d0               ; Mode offset = mode * 96
        muls.w  #$0020,d1               ; Index offset = index * 32
        add.w   d1,d0                   ; Combined offset
        lea     (a1,d0.w),a1            ; $43F1 $0000 — point to selected entry
        lea     ($FFFF9100).w,a2        ; $45F8 $9100 — entity table base ($FF9100)
        moveq   #14,d0                  ; Loop 15 times
.loop:
        move.w  (a1),$B6(a2)            ; Copy word to entity field +$B6
        move.w  (a1)+,$A(a2)            ; Copy same word to field +$A, advance A1
        lea     $100(a2),a2             ; Next entity (+256 byte stride)
        dbf     d0,.loop
        rts
