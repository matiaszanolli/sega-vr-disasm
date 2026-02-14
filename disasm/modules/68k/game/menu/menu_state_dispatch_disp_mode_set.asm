; ============================================================================
; Menu State Dispatch and Display Mode Set
; ROM Range: $014400-$01440E (14 bytes)
; ============================================================================
; Calls the menu state dispatcher at $01457C, then sets the display
; mode to $0024 via the adapter register at $FF0008.
;
; Memory: $00FF0008 = display mode register (word, set to $0024)
; Entry: none | Exit: menu dispatched, display mode set
; Uses: (per called function)
; ============================================================================

menu_state_dispatch_disp_mode_set:
        jsr     palette_fade_003(pc)    ; $4EBA $017A
        move.w  #$0024,$00FF0008                ; $014404: set display mode $0024
        rts                                     ; $01440C: $4E75
