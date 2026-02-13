; ============================================================================
; Set Control Flag $C30D
; ROM Range: $0146B4-$0146BC (8 bytes)
; ============================================================================
; Sets the control flag byte at $C30D to 1.
;
; Memory: $FFFFC30D = control flag (byte)
; Entry: none | Exit: flag set | Uses: none
; ============================================================================

set_control_flag_c30d:
        move.b  #$01,($FFFFC30D).w              ; $0146B4: $11FC $0001 $C30D — set flag
        rts                                     ; $0146BA: $4E75
