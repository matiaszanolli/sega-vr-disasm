; ============================================================================
; Entity Position Init (Table Fill + Compare)
; ROM Range: $009124-$009182 (94 bytes)
; ============================================================================
; Initializes entity position table. If ($EEDC).L != 0, fills with
; $7FFF0000. Then compares entity positions and conditionally copies.
;
; Entry: A0 = entity
; Uses: D0, D1, D7, A1, A2
; ============================================================================

entity_position_init:
        dc.w    $3278,$C8C0           ; MOVEA.W ($C8C0).W,A1 - table pointer
        dc.w    $0CB8,$0000,$0000,$EEDC ; CMPI.L #0,($EEDC).W - init check
        beq.s   .compare              ; If zero, skip fill
        movea.l a1,a2                 ; Save A1
        move.w  #$0253,d7             ; 596 iterations
        move.l  #$7FFF0000,d0         ; Fill value
.fill:
        move.l  d0,(a2)+
        move.l  d0,(a2)+
        move.l  d0,(a2)+
        move.l  d0,(a2)+
        dbra    d7,.fill
.compare:
        move.w  $001C(a0),d0          ; Entity index
        lsl.w   #3,d0                 ; Multiply by 8
        lea     (a1,d0.w),a1          ; Index into table
        move.w  $0004(a1),d0          ; Table value A
        add.w   $0006(a1),d0          ; + Table value B
        bpl.s   .nonneg
        neg.w   d0                    ; |sum|
.nonneg:
        move.w  $0072(a0),d1          ; Entity distance
        add.w   $00E2(a0),d1          ; + offset
        bpl.s   .d1pos
        neg.w   d1
.d1pos:
        cmp.w   d0,d1                 ; Compare distances
        bge.s   .done                 ; If entity >= table, skip
        move.w  $0030(a0),(a1)+       ; Copy X
        move.w  $0034(a0),(a1)+       ; Copy Z
        move.w  $0072(a0),(a1)+       ; Copy distance
        move.w  $0072(a0),(a1)        ; Copy distance (again)
.done: rts
