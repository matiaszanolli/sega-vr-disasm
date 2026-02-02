; func_021 trampoline - redirects to func_021_conditional @ $02300440
; Replaces original 38-byte func_021 with 12-byte jump + padding
;
; ACTIVATION: To enable, change include in code_22200.asm:
;   FROM: include "sh2/generated/func_021_orig.inc"
;   TO:   include "sh2/trampolines/func_021_trampoline.inc"
;
; TO REVERT: change back to func_021_orig.inc
;
        dc.w    $D001           ; $0234C8: MOV.L @(4,PC),R0 - load from $0234D0
        dc.w    $402B           ; $0234CA: JMP @R0
        dc.w    $0009           ; $0234CC: NOP (delay slot)
        dc.w    $0009           ; $0234CE: NOP (padding for 4-byte align)
        dc.l    $02300440       ; $0234D0: literal - func_021_conditional
; Padding to maintain original 38-byte size (38 - 12 = 26 bytes = 13 words)
        dc.w    $0009           ; $0234D4: NOP
        dc.w    $0009           ; $0234D6: NOP
        dc.w    $0009           ; $0234D8: NOP
        dc.w    $0009           ; $0234DA: NOP
        dc.w    $0009           ; $0234DC: NOP
        dc.w    $0009           ; $0234DE: NOP
        dc.w    $0009           ; $0234E0: NOP
        dc.w    $0009           ; $0234E2: NOP
        dc.w    $0009           ; $0234E4: NOP
        dc.w    $0009           ; $0234E6: NOP
        dc.w    $0009           ; $0234E8: NOP
        dc.w    $0009           ; $0234EA: NOP
        dc.w    $0009           ; $0234EC: NOP
