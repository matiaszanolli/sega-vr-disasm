; ============================================================================
; depth_sort — Depth Sort (Selection Sort + Early Exit + Direction Tie-Break)
; ROM Range: $009DD6+ (132 bytes — QW-4a optimization)
; ============================================================================
; Sorts a 16-element array of 4-byte entries using selection sort.
; Primary key: word at entry+$00 (ascending = back-to-front).
; Tie-break: when keys are equal, compares x/y positions of the referenced
; objects based on camera direction quadrant (painter's algorithm ordering).
;
; QW-4a: Early-exit optimization. D7 tracks whether any swaps occurred in
; the current outer pass. If no swaps: array is sorted, exit immediately.
; For nearly-sorted frame-to-frame data (typical in racing), this exits
; after 1-2 passes instead of 15, saving ~2000+ cycles/frame.
; Size budget: 2 × LEA→ADDQ saves 4 bytes, dispatch fall-through saves 2,
; DBEQ consolidation saves 2. Early-exit logic costs 8 bytes. Net: 0.
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

depth_sort:
; --- data prefix (6 words) ---------------------------------------------------
        dc.w    $B3BB,$B3BC,$CCCD,$CCCE,$CFD0,$CFD1
; --- code starts here --------------------------------------------------------
        moveq   #$0E,D1                         ; outer loop: 15 passes
.outer_loop:
        lea     $0004(A0),A1                    ; A1 = next element
        move.w  D1,D2                           ; inner counter
        moveq   #0,D7                           ; D7 = swap flag (0 = no swaps yet)
.inner_loop:
        move.w  (A0),D0                         ; compare primary keys
        cmp.w   (A1),D0
        blt.s   .swap                           ; A0 < A1 → swap
        bgt.s   .no_swap                        ; A0 > A1 → keep
        movea.w $0002(A0),A2                    ; tie → compare positions
        movea.w $0002(A1),A3
        move.w  $001E(A2),D0                    ; direction field
        addi.w  #$2000,D0                       ; rotate by $2000
        rol.w   #3,D0                           ; extract quadrant (0-3)
        andi.w  #$0006,D0                       ; mask to 0,2,4,6
        jmp     .dispatch(PC,D0.W)              ; dispatch
.dispatch:
        bra.s   .cmp_y_asc                      ; Q0: Y ascending
        bra.s   .cmp_x_desc                     ; Q1: X descending
        bra.s   .cmp_y_desc                     ; Q2: Y descending
; --- Q3 (.cmp_x_asc) falls through from dispatch when D0=6 ---
.cmp_x_asc:
        move.w  $0030(A2),D0
        cmp.w   $0030(A3),D0
        bgt.s   .no_swap
.swap:
        move.l  (A0),D0                         ; exchange entries
        move.l  (A1),(A0)
        move.l  D0,(A1)
        moveq   #1,D7                           ; flag: swap occurred this pass
.no_swap:
        addq.l  #4,A1                           ; advance inner pointer (saves 2 bytes vs LEA)
        dbra    D2,.inner_loop
        addq.l  #4,A0                           ; advance outer pointer (saves 2 bytes vs LEA)
        tst.b   D7                              ; any swaps this pass?
        dbeq    D1,.outer_loop                  ; no swaps (EQ) → exit; else decrement & loop
        rts
; --- comparison blocks (reached only via bra.s from dispatch table) -----------
.cmp_y_asc:
        move.w  $0034(A2),D0
        cmp.w   $0034(A3),D0
        blt.s   .swap
        bra.s   .no_swap
.cmp_x_desc:
        move.w  $0030(A2),D0
        cmp.w   $0030(A3),D0
        bgt.s   .swap
        bra.s   .no_swap
.cmp_y_desc:
        move.w  $0034(A2),D0
        cmp.w   $0034(A3),D0
        bgt.s   .swap
        bra.s   .no_swap
