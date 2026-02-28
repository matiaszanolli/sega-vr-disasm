; ============================================================================
; Code Section ($01C200-$01E1FF)
;
; Original data: 8 bytes at $01C200-$01C207
; Optimization code: $01C208-$01E1FF (8,184 bytes available)
;
; ADDRESSING:
;   File offsets:  $01C208 - $01E1FF
;   68K addresses: $89C208 - $89E1FF  (= $880000 + file_offset)
;
;   Cross-section callers MUST use absolute 68K addresses:
;     jsr $0089C208    ; NOT jsr vrd_opt_start (wrong address space)
;
;   Within this section, use PC-relative (BSR/BRA) for local calls.
; ============================================================================

        org     $01C200

; --- Original data (preserved byte-identical) ---
        dc.w    $0000        ; $01C200
        dc.w    $0000        ; $01C202
        dc.w    $0200        ; $01C204
        dc.w    $0020        ; $01C206

; ============================================================================
; VRD OPTIMIZATION CODE AREA
; File:  $01C208 - $01E1FF (8,184 bytes)
; 68K:   $89C208 - $89E1FF
;
; Originally unused ($FF padding) in the retail ROM. Now repurposed for
; 68K optimization and measurement routines.
;
; Hook points:
;   - V-INT vector ($78) redirected to fps_vint_wrapper at $89C208
;   - code_200 work-path end JMPs to vint_epilogue at $89C208+offset
; ============================================================================

vrd_opt_start:

; --- FPS Counter (MUST be first - address $89C208 hardcoded in V-INT vector) ---
        include "modules/68k/optimization/fps_vint_wrapper.asm"
        include "modules/68k/optimization/fps_render.asm"

vrd_opt_end:

; --- Fill remaining space with $FF ---
        dcb.b   ($01E200-vrd_opt_end),$FF
