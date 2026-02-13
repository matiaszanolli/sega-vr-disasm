; ============================================================================
; VDP Table Entry Write (Frame-Indexed)
; ROM Range: $00BF9E-$00BFD4 (54 bytes)
; ============================================================================
; Category: game
; Purpose: Increments frame counter $A0EC, computes row and column:
;   row = ($A0EC × 2) / 28, column = remainder + 2.
;   If row >= 5 → exits (past fn). Otherwise computes table offset:
;   row × 20 + column, writes to VDP table at $FF6900.
;
; Uses: D0, D1, D2, A1
; RAM:
;   $A0EC: frame counter (word, +1 per call)
; ============================================================================

vdp_table_entry_write_00bf9e:
        addq.w  #1,($FFFFA0EC).w               ; $00BF9E  counter++
        moveq   #$00,D0                         ; $00BFA2  clear high word
        move.w  ($FFFFA0EC).w,D0               ; $00BFA4  D0 = counter
        dc.w    $D040                           ; $00BFA8  add.w d0,d0 — D0 × 2
        divu    #$001C,D0                       ; $00BFAA  D0.L / 28 → quot:rem
        cmpi.w  #$0005,D0                       ; $00BFAE  row >= 5?
        dc.w    $6C20                           ; $00BFB2  bge.s $00BFD4 → exit (past fn)
        move.w  D0,D1                           ; $00BFB4  D1 = row (quotient)
        swap    D0                              ; $00BFB6  D0 = remainder (column)
        addq.w  #2,D0                           ; $00BFB8  column += 2
        dc.w    $D241                           ; $00BFBA  add.w d1,d1 — D1 × 2
        dc.w    $D241                           ; $00BFBC  add.w d1,d1 — D1 × 4
        move.w  D1,D2                           ; $00BFBE  D2 = D1 × 4
        dc.w    $D241                           ; $00BFC0  add.w d1,d1 — D1 × 8
        dc.w    $D241                           ; $00BFC2  add.w d1,d1 — D1 × 16
        dc.w    $D242                           ; $00BFC4  add.w d2,d1 — D1 = row × 20
        lea     $00FF6900,A1                    ; $00BFC6  A1 → VDP table base
        lea     $00(A1,D1.W),A1                 ; $00BFCC  A1 += row offset
        move.w  D0,(A1)                         ; $00BFD0  write column value
        rts                                     ; $00BFD2
