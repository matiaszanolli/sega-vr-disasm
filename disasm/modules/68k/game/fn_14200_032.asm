; ============================================================================
; Adjust $903C: Add $1000
; ROM Range: $01481E-$014826 (8 bytes)
; ============================================================================
; Adds $1000 to the word at $903C. One of a group of four related
; adjustment functions (fn_14200_030 through fn_14200_033).
;
; Memory: $FFFF903C = adjustable parameter (word)
; Entry: none | Exit: value incremented | Uses: none
; ============================================================================

fn_14200_032:
        addi.w  #$1000,($FFFF903C).w            ; $01481E: $0678 $1000 $903C — add $1000
        rts                                     ; $014824: $4E75
