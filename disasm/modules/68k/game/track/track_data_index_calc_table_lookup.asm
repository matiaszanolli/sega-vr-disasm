; ============================================================================
; Track Data Index Computation + Table Lookup
; ROM Range: $0073E8-$00742C (68 bytes)
; ============================================================================
; Category: game
; Purpose: Computes track segment index from D1/D2 velocity components
;   and D3 base offset. Uses race_state ($C8A0) × 2 as table selector.
;   Selects table base via A0+$E4 flag (normal at $742C or alternate
;   at $745C). Loads segment data pointer from table[race_state],
;   looks up word at segment[D3], then adds secondary table pointer.
;   Returns A1 = computed track data address.
;
; Uses: D0, D1, D2, D3, D4, D5, A0, A1, A2
; RAM:
;   $C8A0: race_state (word)
; Object (A0):
;   +$E4: table select flag (byte, 0=normal)
; ============================================================================

track_data_index_calc_table_lookup:
        move.l  #$00000400,D3                   ; $0073E8  D3 = base offset $400
        move.w  D1,D4                           ; $0073EE  D4 = D1
        asr.w   #4,D4                           ; $0073F0  D4 >>= 4
        dc.w    $D843                           ; $0073F2  add.w d3,d4 — D4 += D3
        asr.w   #5,D4                           ; $0073F4  D4 >>= 5
        move.w  D2,D5                           ; $0073F6  D5 = D2
        asr.w   #4,D5                           ; $0073F8  D5 >>= 4
        dc.w    $D645                           ; $0073FA  add.w d5,d3 — D3 += D5
        andi.w  #$FFE0,D3                       ; $0073FC  align to 32-byte boundary
        asl.w   #1,D3                           ; $007400  D3 × 2
        dc.w    $D644                           ; $007402  add.w d4,d3 — D3 += D4
        dc.w    $D643                           ; $007404  add.w d3,d3 — D3 × 2
        move.w  ($FFFFC8A0).w,D0                ; $007406  D0 = race_state
        dc.w    $D040                           ; $00740A  add.w d0,d0 — D0 × 2
        dc.w    $45FA,$001E                     ; $00740C  lea $00742C(pc),a2 — normal table
        tst.b   $00E4(A0)                       ; $007410  alternate table?
        beq.s   .lookup                         ; $007414  no → use normal
        dc.w    $45FA,$0044                     ; $007416  lea $00745C(pc),a2 — alternate table
.lookup:
        movea.l $00(A2,D0.W),A1                 ; $00741A  A1 = segment ptr
        move.w  $00(A1,D3.W),D3                 ; $00741E  D3 = segment[offset]
        movea.l $04(A2,D0.W),A1                 ; $007422  A1 = base ptr
        dc.w    $D683                           ; $007426  add.l d3,d3 — D3 × 2
        adda.l  D3,A1                           ; $007428  A1 += D3
        rts                                     ; $00742A

