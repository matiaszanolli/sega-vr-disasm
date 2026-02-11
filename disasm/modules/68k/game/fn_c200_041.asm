; ============================================================================
; VDP Slot Activation — Configuration A
; ROM Range: $00CA4C-$00CA66 (26 bytes)
; Source: code_c200
; ============================================================================
;
; PURPOSE
; -------
; Activates three VDP register slots by writing control bytes to their base
; addresses in the VDP work area ($FF6800). Each 16-byte slot's first byte
; is a control/enable flag.
;
; Slot layout (VDP work area at $FF6800, 16 bytes per slot):
;   $FF6920 = slot 18 (offset $120): set to 4 (active/priority)
;   $FF6880 = slot  8 (offset $080): set to 1 (enabled)
;   $FF69A0 = slot 26 (offset $1A0): set to 1 (enabled)
;
; Entry: No register inputs
; Exit:  Three VDP slots activated
; Uses:  (none)
; ============================================================================

c200_func_011:
        move.b  #$04,$00FF6920                  ; $00CA4C: $13FC $0004 $00FF $6920 — slot 18 = active
        move.b  #$01,$00FF6880                  ; $00CA54: $13FC $0001 $00FF $6880 — slot 8 = enabled
        move.b  #$01,$00FF69A0                  ; $00CA5C: $13FC $0001 $00FF $69A0 — slot 26 = enabled
        rts                                     ; $00CA64: $4E75
