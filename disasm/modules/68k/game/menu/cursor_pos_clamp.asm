; ============================================================================
; cursor_pos_clamp — Cursor Position Clamp [0, 31]
; ROM Range: $011A5C-$011A70 (20 bytes)
; ============================================================================
; Adds D1 offset to D5 then clamps result to [0, 31]. Used for name entry
; cursor position bounds checking — 32 character positions in the alphabet grid.
;
; Entry: D1 = offset to add, D5 = current position
; Exit: D5 = clamped position (0 ≤ D5 ≤ 31)
; Uses: D5
; ============================================================================

cursor_pos_clamp:
        dc.w    $DA41                           ; $011A5C  ADD.W D1,D5
        cmpi.w  #$001F,d5                       ; $011A5E
        ble.s   .check_lower                    ; $011A62
        move.w  #$001F,d5                       ; $011A64  clamp to max 31
.check_lower:
        tst.w   d5                              ; $011A68
        bgt.s   .done                           ; $011A6A
        clr.w   d5                              ; $011A6C  clamp to min 0
.done:
        rts                                     ; $011A6E
