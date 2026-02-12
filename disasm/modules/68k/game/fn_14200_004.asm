; ============================================================================
; Menu Tile Copy to VDP (Block Transfer)
; ROM Range: $0145F0-$01462A (58 bytes)
; ============================================================================
; Category: game
; Purpose: Copies tile data from (A1) to VDP nametable at $00844000 + D1.
;   First reads 3 header words: D2 = row count, D3 = column count,
;   D0 = data longword count. Copies D0 longwords from (A2) to
;   work buffer at $A100. Then doubles D0 (word count) and advances
;   A1 past the longword data. For each row: reads word count from
;   (A1)+, copies that many words to VDP base, advances base by $200.
;
; Uses: D0, D1, D2, D3, D4, A1, A2, A3
; RAM:
;   $A100: VDP tile work buffer
; ============================================================================

fn_14200_004:
        move.w  (A1)+,D2                       ; $0145F0  D2 = row count
        move.w  (A1)+,D3                       ; $0145F2  D3 = column count (unused in loop header)
        move.w  (A1)+,D0                       ; $0145F4  D0 = longword count
        movea.l A1,A2                           ; $0145F6  A2 = data source
        lea     ($FFFFA100).w,A3               ; $0145F8  A3 → work buffer
        move.w  D0,D4                           ; $0145FC  D4 = longword count
        dc.w    $D844                           ; $0145FE  add.w d4,d4 — D4 × 2 (word count)
        subq.w  #1,D4                           ; $014600  D4-- (DBRA loop count)
.copy_data:
        move.l  (A2)+,(A3)+                    ; $014602  copy longword to work buffer
        dbra    D4,.copy_data                   ; $014604  loop
        dc.w    $D040                           ; $014608  add.w d0,d0 — D0 × 2 (byte offset)
        lea     $00(A1,D0.W),A1                ; $01460A  A1 += data size (skip past data)
        lea     $00844000,A3                    ; $01460E  A3 → VDP nametable base
        adda.l  D1,A3                           ; $014614  A3 += offset
.row_loop:
        lea     (A3),A2                         ; $014616  A2 = current row start
        move.w  (A1)+,D4                       ; $014618  D4 = words in this row
.col_loop:
        move.w  (A1)+,(A2)+                    ; $01461A  copy word to VDP
        dbra    D4,.col_loop                    ; $01461C  column loop
        lea     $0200(A3),A3                   ; $014620  A3 += $200 (next row)
        dbra    D3,.row_loop                    ; $014624  row loop
        rts                                     ; $014628
