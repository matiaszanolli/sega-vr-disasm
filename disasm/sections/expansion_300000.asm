; ============================================================================
; Expansion ROM Section ($300000-$3FFFFF)
; 1MB of SH2 working space
; ============================================================================
;
; NOTE: This section is executed by SH2 processors, not the 68000.
; It can only contain:
; - SH2 code in dc.w format (raw opcodes)
; - Data literals
; - Padding (0xFF)
;
; ============================================================================

        org     $300000

; Entire expansion section is padding (0xFF)
; Ready for SH2 code injection when needed

        dcb.b   $100000,$FF             ; 1MB of 0xFF padding
