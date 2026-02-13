; ============================================================================
; Adjust $903C: Subtract $0400
; ROM Range: $014816-$01481E (8 bytes)
; ============================================================================
; Subtracts $0400 from the word at $903C. One of a group of four related
; adjustment functions (adjust_903c_add_0400 through adjust_903c_add_2000).
;
; Memory: $FFFF903C = adjustable parameter (word)
; Entry: none | Exit: value decremented | Uses: none
; ============================================================================

adjust_903c_subtract_0400:
        subi.w  #$0400,($FFFF903C).w            ; $014816: $0478 $0400 $903C — subtract $0400
        rts                                     ; $01481C: $4E75
