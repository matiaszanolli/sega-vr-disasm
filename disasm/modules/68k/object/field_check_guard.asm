; ============================================================================
; Field Check Guard
; ROM Range: $0080CC-$0080D5 (10 bytes)
; ============================================================================
; Loads A0+$8C into D2. If non-zero, falls through to next function.
; If zero, returns immediately.
;
; Entry: A0 = object pointer
; Returns: D2 = field value (non-zero if falls through)
; Uses: D2
; Fields accessed:
;   A0+$8C: Guard field (word)
; ============================================================================

field_check_guard:
        moveq   #0,d2                   ; Clear D2
        move.w  $8C(a0),d2             ; Load guard field
        bne.s   .fall_through           ; If non-zero, continue
        rts                             ; Return if zero
.fall_through:
