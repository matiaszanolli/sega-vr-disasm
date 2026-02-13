; ============================================================================
; table_entry_swap_by_index — Table Entry Swap by Index
; ROM Range: $01418E-$0141DC (78 bytes)
; ============================================================================
; Swaps two entries in array (A1) based on lookup indices. Reads index from
; (A3), looks up value in table A0 (selected by D0: $008941DC or $008941E2),
; searches (A1) for matching entry, saves position. Repeats for second index
; from (A4). Then swaps the two found entries in (A1).
;
; Used for reordering standings/rankings by swapping positions.
;
; Entry: A1 = sortable array, A3 = pointer to index 1, A4 = pointer to index 2,
;        D0 = table selector (0 = table A, nonzero = table B)
; Uses: D0, D1, D3, D4, D5, D6, A0, A1
; ============================================================================

table_entry_swap_by_index:
        CLR.W  D3                               ; $01418E
        MOVE.B  (A3),D3                         ; $014190
        LEA     $008941DC,A0                    ; $014192
        TST.W  D0                               ; $014198
        BEQ.S  .loc_0014                        ; $01419A
        LEA     $008941E2,A0                    ; $01419C
.loc_0014:
        MOVE.B  $00(A0,D3.W),D1                 ; $0141A2
        CLR.W  D3                               ; $0141A6
.loc_001A:
        CMP.B  $00(A1,D3.W),D1                  ; $0141A8
        BEQ.W  .loc_0026                        ; $0141AC
        ADDQ.W  #1,D3                           ; $0141B0
        BRA.S  .loc_001A                        ; $0141B2
.loc_0026:
        MOVE.B  $00(A1,D3.W),D5                 ; $0141B4
        CLR.W  D4                               ; $0141B8
        MOVE.B  (A4),D4                         ; $0141BA
        MOVE.B  $00(A0,D4.W),D1                 ; $0141BC
        CLR.W  D4                               ; $0141C0
.loc_0034:
        CMP.B  $00(A1,D4.W),D1                  ; $0141C2
        BEQ.W  .loc_0040                        ; $0141C6
        ADDQ.W  #1,D4                           ; $0141CA
        BRA.S  .loc_0034                        ; $0141CC
.loc_0040:
        MOVE.B  $00(A1,D4.W),D6                 ; $0141CE
        MOVE.B  D5,$00(A1,D4.W)                 ; $0141D2
        MOVE.B  D6,$00(A1,D3.W)                 ; $0141D6
        RTS                                     ; $0141DA
