; ============================================================================
; Clear Camera Override
; ROM Range: $008EF4-$008EFC (8 bytes)
; ============================================================================
; Clears camera position override flag.
;
; Entry: none
; Uses: none
; ============================================================================

clear_camera_override:
        move.w  #$0000,($FFFFC0BA).w    ; $31FC $0000 $C0BA
        rts
