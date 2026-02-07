; ============================================================================
; Multi-Flag Test
; ROM Range: $007CD8-$007CEF (24 bytes)
; ============================================================================
; ANDs four flag bytes together and tests bit 1 of the result.
; Returns via RTS if bit 1 is set (all flags agree on bit 1).
; Falls through to next function if bit 1 is clear.
;
; Entry: A0 = object pointer
; Uses: D0, D1
; Fields accessed:
;   A0+$56: Flag byte 1
;   A0+$57: Flag byte 2
;   A0+$58: Flag byte 3
;   A0+$59: Flag byte 4
; ============================================================================

multi_flag_test:
        move.b  $57(a0),d0              ; Load flag 2
        and.b   $56(a0),d0              ; AND with flag 1
        and.b   $59(a0),d0              ; AND with flag 4
        and.b   $58(a0),d0              ; AND with flag 3
        btst    #1,d0                   ; Test bit 1 of combined result
        beq.s   .fall_through           ; If clear, fall through
        rts                             ; Return if bit 1 set
.fall_through:
