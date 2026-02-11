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
; RESERVED OPTIMIZATION CODE AREA
; File:  $01C208 - $01E1FF (8,184 bytes)
; 68K:   $89C208 - $89E1FF
;
; Originally unused ($FF padding) in the retail ROM. Reserved for future
; 68K optimization routines. Currently filled with $FF to match original.
;
; Optimization modules are in disasm/modules/68k/optimization/ but NOT
; included here until their hook points are activated.
; ============================================================================

        dcb.b   ($01E200-*),$FF
