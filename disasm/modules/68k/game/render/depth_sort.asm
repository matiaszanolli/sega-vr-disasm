; ============================================================================
; depth_sort — Depth Sort (Insertion Sort, Descending)
; ROM Range: $009DD6+ (132 bytes)
; ============================================================================
; Sorts a 16-element array of 4-byte entries using insertion sort.
; Primary key: word at entry+$00 (descending = largest first).
;
; Insertion sort replaces the previous selection sort (QW-4a) for better
; performance on nearly-sorted frame-to-frame data. Racing entity positions
; change slowly between frames, so most elements are already in order.
; Typical cost: 15 fast-path comparisons + 2-4 element shifts vs the
; previous 2-3 full passes of 15 comparisons each.
;
; Camera-quadrant tie-break removed: equal-key elements maintain their
; relative order from the previous frame (stable sort). The original sort
; reordered equal-key elements by camera direction, but this only affects
; overlapping same-depth entities (rare, cosmetic z-ordering).
;
; D7 BUG FIX: The previous QW-4a optimization clobbered D7 (swap flag),
; but the caller (race_pos_sorting_and_rank_assignment) uses D7 to hold
; old_sort_key_b across the sort calls. Insertion sort does not use D7.
;
; Data prefix: 6 words of priority key pairs used elsewhere as lookup data.
;
; Entry: A0 = sort array (16 entries × 4 bytes: word key + word obj_ptr)
; Uses: D0, D1, D2, A0, A1, A2
; Preserves: D3-D7, A3-A6
; ============================================================================

depth_sort:
; --- data prefix (6 words) ---------------------------------------------------
        dc.w    $B3BB,$B3BC,$CCCD,$CCCE,$CFD0,$CFD1
; --- insertion sort (entry at depth_sort+12) ----------------------------------
        moveq   #$0E,D1                         ; 15 elements to insert
        lea     4(A0),A1                        ; A1 = &array[1] (first to insert)
.outer:
        move.w  (A1),D2                         ; D2 = current element's sort key
        cmp.w   -4(A1),D2                       ; compare with previous element
        ble.s   .advance                        ; current <= previous → in order (descending)
        ; --- out of order: shift previous elements forward, insert current ---
        move.l  (A1),D0                         ; D0 = save current element (key:ptr)
        movea.l A1,A2                           ; A2 = shift scan pointer
.shift:
        move.l  -4(A2),(A2)                     ; shift previous element forward
        subq.l  #4,A2                           ; scan backwards
        cmpa.l  A0,A2                           ; reached start of array?
        beq.s   .insert                         ; yes → insert at position 0
        cmp.w   -4(A2),D2                       ; compare with next previous element
        bgt.s   .shift                          ; current > that one → keep shifting
.insert:
        move.l  D0,(A2)                         ; insert saved element at found position
.advance:
        addq.l  #4,A1                           ; advance to next element
        dbra    D1,.outer                       ; loop for all 15 elements
        rts
; --- NOP padding to maintain 132-byte function size ---------------------------
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop
