; ============================================================================
; VDP Slot Activation — Configuration C
; ROM Range: $00CA80-$00CA9A (26 bytes)
; Source: code_c200
; ============================================================================
;
; PURPOSE
; -------
; Activates three VDP register slots by writing control bytes to their base
; addresses in the VDP work area ($FF6800). Same pattern as configurations
; A and B but targeting a different set of slots.
;
; Slot layout:
;   $FF6910 = slot 17 (offset $110): set to 4 (active/priority)
;   $FF6870 = slot  7 (offset $070): set to 1 (enabled)
;   $FF69D0 = slot 29 (offset $1D0): set to 1 (enabled)
;
; Entry: No register inputs
; Exit:  Three VDP slots activated
; Uses:  (none)
; ============================================================================

vdp_slot_activation_config_c:
        move.b  #$04,$00FF6910                  ; $00CA80: $13FC $0004 $00FF $6910 — slot 17 = active
        move.b  #$01,$00FF6870                  ; $00CA88: $13FC $0001 $00FF $6870 — slot 7 = enabled
        move.b  #$01,$00FF69D0                  ; $00CA90: $13FC $0001 $00FF $69D0 — slot 29 = enabled
        rts                                     ; $00CA98: $4E75
