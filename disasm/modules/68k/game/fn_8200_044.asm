; ============================================================================
; fn_8200_044 — Depth Sort (Bubble Sort by Priority + Direction Tie-Break)
; ROM Range: $009DD6-$009E5A (132 bytes)
; ============================================================================
; Sorts a 16-element array of 4-byte entries using bubble sort.
; Primary key: word at entry+$00 (ascending = back-to-front).
; Tie-break: when keys are equal, compares x/y positions of the referenced
; objects based on camera direction quadrant (painter's algorithm ordering).
;
; Data prefix: 6 words of priority key pairs used elsewhere as lookup data.
;
; Entry: A0 = sort array (16 entries × 4 bytes: word key + word obj_ptr)
; Uses: D0, D1, D2, D7, A0, A1, A2, A3
; Object fields (via indirect pointers at entry+$02):
;   +$1E: direction (used for quadrant computation)
;   +$30: x_position
;   +$34: y_position
; ============================================================================

fn_8200_044:
; --- data prefix (6 words) ---------------------------------------------------
        dc.w    $B3BB,$B3BC,$CCCD,$CCCE,$CFD0,$CFD1
; --- code starts here --------------------------------------------------------
        moveq   #$0E,D1                         ; $009DE2  outer loop: 15 passes
.outer_loop:
        lea     $0004(A0),A1                    ; $009DE4  A1 = next element
        move.w  D1,D2                           ; $009DE8  inner counter
.inner_loop:
        move.w  (A0),D0                         ; $009DEA  compare primary keys
        cmp.w   (A1),D0                         ; $009DEC
        blt.s   .swap                           ; $009DEE  A0 < A1 → swap
        bgt.s   .no_swap                        ; $009DF0  A0 > A1 → keep
        movea.w $0002(A0),A2                    ; $009DF2  tie → compare positions
        movea.w $0002(A1),A3                    ; $009DF6
        move.w  $001E(A2),D0                    ; $009DFA  direction field
        addi.w  #$2000,D0                       ; $009DFE  rotate by $2000
        rol.w   #3,D0                           ; $009E02  extract quadrant (0-3)
        andi.w  #$0006,D0                       ; $009E04  mask to 0,2,4,6
        jmp     $009E0C(PC,D0.W)                ; $009E08  dispatch
        bra.s   .cmp_y_asc                      ; $009E0C  Q0: Y ascending
        bra.s   .cmp_x_desc                     ; $009E0E  Q1: X descending
        bra.s   .cmp_y_desc                     ; $009E10  Q2: Y descending
        bra.s   .cmp_x_asc                      ; $009E12  Q3: X ascending
.cmp_y_asc:
        move.w  $0034(A2),D0                    ; $009E14
        cmp.w   $0034(A3),D0                    ; $009E18
        blt.s   .swap                           ; $009E1C
        bra.s   .no_swap                        ; $009E1E
.cmp_x_desc:
        move.w  $0030(A2),D0                    ; $009E20
        cmp.w   $0030(A3),D0                    ; $009E24
        bgt.s   .swap                           ; $009E28
        bra.s   .no_swap                        ; $009E2A
.cmp_y_desc:
        move.w  $0034(A2),D0                    ; $009E2C
        cmp.w   $0034(A3),D0                    ; $009E30
        bgt.s   .swap                           ; $009E34
        bra.s   .no_swap                        ; $009E36
.cmp_x_asc:
        move.w  $0030(A2),D0                    ; $009E38
        cmp.w   $0030(A3),D0                    ; $009E3C
        bgt.s   .no_swap                        ; $009E40
.swap:
        move.l  (A0),D0                         ; $009E42  exchange entries
        move.l  (A1),(A0)                       ; $009E44
        move.l  D0,(A1)                         ; $009E46
.no_swap:
        lea     $0004(A1),A1                    ; $009E48  advance inner pointer
        dbra    D2,.inner_loop                  ; $009E4C
        lea     $0004(A0),A0                    ; $009E50  advance outer pointer
        dbra    D1,.outer_loop                  ; $009E54
        rts                                     ; $009E58
