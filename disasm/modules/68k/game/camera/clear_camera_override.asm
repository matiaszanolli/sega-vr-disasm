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
        dc.w    $31FC,$0000,$C0BA     ; MOVE.W #0,($C0BA).W
        rts
