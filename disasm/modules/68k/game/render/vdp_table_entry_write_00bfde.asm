; ============================================================================
; VDP Table Entry Write (Frame-Indexed, Variant B — Negated Column)
; ROM Range: $00BFDE-$00C01E (64 bytes)
; ============================================================================
; Category: game
; Purpose: Like vdp_table_entry_write_00bf9e but negates the column value and checks for
;   $FFE4 (column -28). Increments frame counter $A0EC, computes:
;   row = ($A0EC × 2) / 28, column = -(remainder + 2).
;   If row >= 5 → exits (past fn). If column == $FFE4 → column = 0.
;   Computes row × 20 + row offset, writes column to VDP table at $FF6900.
;
; Uses: D0, D1, D2, A1
; RAM:
;   $A0EC: frame counter (word, +1 per call)
; ============================================================================

vdp_table_entry_write_00bfde:
        addq.w  #1,($FFFFA0EC).w               ; $00BFDE  counter++
        moveq   #$00,D0                         ; $00BFE2  clear high word
        move.w  ($FFFFA0EC).w,D0               ; $00BFE4  D0 = counter
        dc.w    $D040                           ; $00BFE8  add.w d0,d0 — D0 × 2
        divu    #$001C,D0                       ; $00BFEA  D0.L / 28 → quot:rem
        cmpi.w  #$0005,D0                       ; $00BFEE  row >= 5?
        dc.w    $6C2A                           ; $00BFF2  bge.s $00C01E → exit (past fn)
        move.w  D0,D1                           ; $00BFF4  D1 = row (quotient)
        swap    D0                              ; $00BFF6  D0 = remainder (column)
        addq.w  #2,D0                           ; $00BFF8  column += 2
        neg.w   D0                              ; $00BFFA  column = -column
        cmpi.w  #$FFE4,D0                       ; $00BFFC  column == -28?
        bne.s   .compute_offset                 ; $00C000  no → compute offset
        moveq   #$00,D0                         ; $00C002  column = 0 (wrap)
.compute_offset:
        dc.w    $D241                           ; $00C004  add.w d1,d1 — D1 × 2
        dc.w    $D241                           ; $00C006  add.w d1,d1 — D1 × 4
        move.w  D1,D2                           ; $00C008  D2 = D1 × 4
        dc.w    $D241                           ; $00C00A  add.w d1,d1 — D1 × 8
        dc.w    $D241                           ; $00C00C  add.w d1,d1 — D1 × 16
        dc.w    $D242                           ; $00C00E  add.w d2,d1 — D1 = row × 20
        lea     $00FF6900,A1                    ; $00C010  A1 → VDP table base
        lea     $00(A1,D1.W),A1                ; $00C016  A1 += row offset
        move.w  D0,(A1)                         ; $00C01A  write column value
        rts                                     ; $00C01C
