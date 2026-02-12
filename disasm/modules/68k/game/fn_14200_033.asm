; ============================================================================
; Adjust $903C: Add $2000
; ROM Range: $014826-$01482E (8 bytes)
; ============================================================================
; Adds $2000 to the word at $903C. One of a group of four related
; adjustment functions (fn_14200_030 through fn_14200_033).
;
; Memory: $FFFF903C = adjustable parameter (word)
; Entry: none | Exit: value incremented | Uses: none
; ============================================================================

fn_14200_033:
        addi.w  #$2000,($FFFF903C).w            ; $014826: $0678 $2000 $903C — add $2000
        rts                                     ; $01482C: $4E75
