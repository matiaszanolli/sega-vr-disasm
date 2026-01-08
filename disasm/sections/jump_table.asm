; ============================================================================
; 32X Jump Table ($000200 - $0003EF)
; ============================================================================
; This is the 32X runtime jump table. The MARS BIOS uses this to dispatch
; exceptions. Each entry is a JMP absolute long instruction.
;
; Key entries:
;   Entry 0:  JMP $00880838 - MARSAdapterInit (main init routine)
;   Entry 27: JMP $0088170A - H-INT Handler
;   Entry 29: JMP $00881684 - V-INT Handler
;   Others:   JMP $00880832 - DefaultExceptionHandler (infinite loop)
; ============================================================================

        org     $000200

JumpTable:
    JMP     $00880838  ; MARSAdapterInit
    ; Entries 1-26: Default handler
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $0088170A  ; H_INT_Handler
    JMP     $00880832  ; DefaultExceptionHandler
    JMP     $00881684  ; V_INT_Handler
    ; Entries 30-62: Default handler
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832
    JMP     $00880832

; NOP padding to align MARS header at $3C0
    REPT    35
    NOP
    ENDR

; ============================================================================
; MARS Security Header ($0003C0 - $0003EF)
; ============================================================================
; Required signature for 32X hardware validation
; ============================================================================

MARSCheckMode:
    dc.b    "MARS CHECK MODE "

; MARS security module descriptor
    dc.l    $00000000    ; Offset/reserved
    dc.l    $00020000    ; Module size ($20000 = 128KB)
    dc.l    $00000000    ; Reserved
    dc.w    $0000        ; Reserved
    dc.l    $C0000600    ; VDP config 1
    dc.l    $02800600    ; VDP config 2
    dc.l    $02880600    ; VDP config 3
    dc.l    $00000600    ; Reserved
    dc.w    $0140        ; Flags

; ============================================================================
; End of Jump Table and Security Header
; Entry Point code begins at $3F0
; ============================================================================
