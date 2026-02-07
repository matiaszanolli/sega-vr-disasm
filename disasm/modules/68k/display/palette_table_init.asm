; ============================================================================
; Palette Table Init
; ROM Range: $00F88C-$00F8F6 (106 bytes)
; ============================================================================
; Initializes palette table regions. Sets up A0=$84A2, A1=$84C2,
; A2=$84E2, clears 8 entries at $2000 offset, selects table by D0,
; reads index from ($A012), copies 8 entries from ROM table, wraps index.
;
; Entry: D0 = table selector (0=A, nonzero=B)
; Uses: D0, D1, D2, A0-A3
; ============================================================================

palette_table_init:
        dc.w    $41F8,$84A2           ; LEA ($84A2).W,A0
        dc.w    $43F8,$84C2           ; LEA ($84C2).W,A1
        dc.w    $45F8,$84E2           ; LEA ($84E2).W,A2
        clr.w   d2
        move.w  #$0007,d1             ; 8 entries
.clear: move.w  #$0000,0(a0,d2.w)     ; Clear entry in table A (indexed by D2)
        move.w  #$0000,0(a1,d2.w)     ; Clear entry in table B (indexed by D2)
        addq.w  #2,d2
        dbra    d1,.clear
        dc.w    $41F8,$84C2           ; LEA ($84C2).W,A0 - default table B
        tst.w   d0
        bne.s   .load                 ; If D0 != 0, use table B
        dc.w    $41F8,$84A2           ; LEA ($84A2).W,A0 - table A
.load:  lea     $0088F8F6,a3          ; ROM data table
        moveq   #0,d1
        dc.w    $3238,$A012           ; MOVE.W ($A012).W,D1 - current index
        add.w   d1,d1                 ; Word index (x2)
        adda.l  d1,a3                 ; Offset into ROM table
        clr.w   d2
        move.w  #$0007,d1             ; 8 entries
.copy:  move.w  (a3),0(a0,d2.w)       ; Copy to table A/B (same word to both)
        move.w  (a3)+,0(a2,d2.w)      ; Copy to table C (then advance A3)
        addq.w  #2,d2
        dbra    d1,.copy
        dc.w    $3238,$A012           ; MOVE.W ($A012).W,D1 - re-read index
        addq.w  #1,d1
        cmpi.w  #$0007,d1             ; Check wrap
        ble.w   .store                ; If <= 7, store
        clr.w   d1                    ; Wrap to 0
.store: dc.w    $31C1,$A012           ; MOVE.W D1,($A012).W - store index
        rts
