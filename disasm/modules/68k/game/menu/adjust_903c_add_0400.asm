; ============================================================================
; Adjust $903C: Add $0400
; ROM Range: $01480E-$014816 (8 bytes)
; ============================================================================
; Adds $0400 to the word at $903C. One of a group of four related
; adjustment functions (adjust_903c_add_0400 through adjust_903c_add_2000).
;
; Memory: $FFFF903C = adjustable parameter (word)
; Entry: none | Exit: value incremented | Uses: none
; ============================================================================

adjust_903c_add_0400:
        addi.w  #$0400,($FFFF903C).w            ; $01480E: $0678 $0400 $903C — add $0400
        rts                                     ; $014814: $4E75
