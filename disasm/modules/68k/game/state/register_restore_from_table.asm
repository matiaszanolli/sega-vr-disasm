; ============================================================================
; register_restore_from_table — Register Restore from Table
; ROM Range: $000C5A-$000C70 (22 bytes)
; ============================================================================
; Loads all 68K registers (D0-D7, A0-A6) from a PC-relative data table
; at $000C70 (the start of hardware_init, whose first 16 bytes are register
; init values). Uses four MOVEM.L loads from the same base address A6.
;
; Entry: None (standalone initialization helper)
; Exit: D0-D7, A0-A6 loaded from table at $000C70
; Uses: D0-D7, A0-A6
; ============================================================================

register_restore_from_table:
        lea     hardware_init(pc),a6    ; $4DFA $0014
        MOVEM.L (A6),D0/D1/D2/D3                ; $000C5E
        MOVEM.L (A6),D4/D5/D6/D7                ; $000C62
        MOVEM.L (A6),A0/A1/A2/A3                ; $000C66
        MOVEM.L (A6),A4/A5/A6                   ; $000C6A
        RTS                                     ; $000C6E
