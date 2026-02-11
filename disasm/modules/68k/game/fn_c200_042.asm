; ============================================================================
; VDP Slot Activation — Configuration B
; ROM Range: $00CA66-$00CA80 (26 bytes)
; Source: code_c200
; ============================================================================
;
; PURPOSE
; -------
; Activates three VDP register slots by writing control bytes to their base
; addresses in the VDP work area ($FF6800). Same pattern as configuration A
; (fn_c200_041) but with different slot selection.
;
; Slot layout:
;   $FF6920 = slot 18 (offset $120): set to 4 (active/priority)
;   $FF6880 = slot  8 (offset $080): set to 1 (enabled)
;   $FF6800 = slot  0 (offset $000): set to 1 (enabled)
;
; Entry: No register inputs
; Exit:  Three VDP slots activated
; Uses:  (none)
; ============================================================================

c200_func_012:
        move.b  #$04,$00FF6920                  ; $00CA66: $13FC $0004 $00FF $6920 — slot 18 = active
        move.b  #$01,$00FF6880                  ; $00CA6E: $13FC $0001 $00FF $6880 — slot 8 = enabled
        move.b  #$01,$00FF6800                  ; $00CA76: $13FC $0001 $00FF $6800 — slot 0 = enabled
        rts                                     ; $00CA7E: $4E75
