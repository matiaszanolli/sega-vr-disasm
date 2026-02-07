; ============================================================================
; MARS System Registers Init (13 Words)
; ROM Range: $00263E-$002650 (20 bytes)
; ============================================================================
; Copies 13 words from a data table (following this function) to MARS
; system registers at $A15100-$A15118.
;
; Entry: none (data table at PC+$12)
; Uses: A1, A2, D7
; ============================================================================

mars_regs_init_13:
        dc.w    $43FA,$0012           ; LEA data_table(PC),A1
        lea     $00A15100,a2          ; MARS system registers
        moveq   #12,d7               ; 13 words (0-12)
.copy:
        move.w  (a1)+,(a2)+           ; Copy word
        dbra    d7,.copy
        rts
