; ============================================================================
; Entity Table Load (Mode-Based)
; ROM Range: $00A7E2-$00A808 (38 bytes)
; ============================================================================
; Loads entity data from a ROM speed/attribute table into RAM entity entries.
; Table entry is selected by mode index at ($C89C), 32 bytes per entry.
; Copies one word per entity into two fields (+$B6 and +$A) for 15 entities.
;
; Uses: D0, A1, A2
; RAM:
;   ($C89C).W: Mode/table index
;   ($9100).W: Entity table base (stride 256 bytes per entity)
; ============================================================================

entity_table_load:
        lea     $00938F2E,a1            ; ROM speed/attribute table
        dc.w    $3038,$C89C             ; MOVE.W ($C89C).W,D0 - load mode index
        asl.w   #5,d0                   ; index * 32 (entry size)
        dc.w    $43F1,$0000             ; LEA 0(A1,D0.W),A1 - point to selected entry
        dc.w    $45F8,$9100             ; LEA ($9100).W,A2 - entity table base ($FF9100)
        moveq   #14,d0                  ; Loop 15 times (entities 0-14)
.loop:
        move.w  (a1),$B6(a2)            ; Copy word to entity field +$B6
        move.w  (a1)+,$A(a2)            ; Copy same word to field +$A, advance A1
        lea     $100(a2),a2             ; Next entity (+256 byte stride)
        dbf     d0,.loop
        rts
