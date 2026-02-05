; ============================================================================
; vasm Helper Macros for 68K Assembly
; ============================================================================
; Workarounds for vasm absolute short addressing limitations
;
; Problem: vasm rejects .W addressing for values outside ±32K range
; Examples: Work RAM ($84A2), I/O registers ($A012)
;
; Solution: Macros that emit correct dc.w sequences while maintaining
; readable source code.
; ============================================================================

; Register constants for macro comparisons
A0 equ 8
A1 equ 9
A2 equ 10
A3 equ 11
A4 equ 12
A5 equ 13
A6 equ 14

D0 equ 0
D1 equ 1
D2 equ 2
D3 equ 3
D4 equ 4
D5 equ 5
D6 equ 6
D7 equ 7

; ----------------------------------------------------------------------------
; LEA_ABS_W - Load Effective Address (Absolute Word)
; Generates: LEA (addr).W,An
; ----------------------------------------------------------------------------
LEA_ABS_W macro addr,reg
    ifeq \2-A0
        dc.w $41F8,\1           ; LEA (addr).W,A0
    endc
    ifeq \2-A1
        dc.w $43F8,\1           ; LEA (addr).W,A1
    endc
    ifeq \2-A2
        dc.w $45F8,\1           ; LEA (addr).W,A2
    endc
    ifeq \2-A3
        dc.w $47F8,\1           ; LEA (addr).W,A3
    endc
    ifeq \2-A4
        dc.w $49F8,\1           ; LEA (addr).W,A4
    endc
    ifeq \2-A5
        dc.w $4BF8,\1           ; LEA (addr).W,A5
    endc
    ifeq \2-A6
        dc.w $4DF8,\1           ; LEA (addr).W,A6
    endc
    endm

; ----------------------------------------------------------------------------
; MOVEW_ABS_TO_D - MOVE.W (addr).W,Dn
; Generates: MOVE.W (addr).W,Dn
; ----------------------------------------------------------------------------
MOVEW_ABS_TO_D macro addr,reg
    ifeq \2-D0
        dc.w $3038,\1           ; MOVE.W (addr).W,D0
    endc
    ifeq \2-D1
        dc.w $3238,\1           ; MOVE.W (addr).W,D1
    endc
    ifeq \2-D2
        dc.w $3438,\1           ; MOVE.W (addr).W,D2
    endc
    ifeq \2-D3
        dc.w $3638,\1           ; MOVE.W (addr).W,D3
    endc
    ifeq \2-D4
        dc.w $3838,\1           ; MOVE.W (addr).W,D4
    endc
    ifeq \2-D5
        dc.w $3A38,\1           ; MOVE.W (addr).W,D5
    endc
    ifeq \2-D6
        dc.w $3C38,\1           ; MOVE.W (addr).W,D6
    endc
    ifeq \2-D7
        dc.w $3E38,\1           ; MOVE.W (addr).W,D7
    endc
    endm

; ----------------------------------------------------------------------------
; MOVEW_D_TO_ABS - MOVE.W Dn,(addr).W
; Generates: MOVE.W Dn,(addr).W
; ----------------------------------------------------------------------------
MOVEW_D_TO_ABS macro reg,addr
    ifeq \1-D0
        dc.w $31C0,\2           ; MOVE.W D0,(addr).W
    endc
    ifeq \1-D1
        dc.w $31C1,\2           ; MOVE.W D1,(addr).W
    endc
    ifeq \1-D2
        dc.w $31C2,\2           ; MOVE.W D2,(addr).W
    endc
    ifeq \1-D3
        dc.w $31C3,\2           ; MOVE.W D3,(addr).W
    endc
    ifeq \1-D4
        dc.w $31C4,\2           ; MOVE.W D4,(addr).W
    endc
    ifeq \1-D5
        dc.w $31C5,\2           ; MOVE.W D5,(addr).W
    endc
    ifeq \1-D6
        dc.w $31C6,\2           ; MOVE.W D6,(addr).W
    endc
    ifeq \1-D7
        dc.w $31C7,\2           ; MOVE.W D7,(addr).W
    endc
    endm

; ============================================================================
; End of vasm_macros.asm
; ============================================================================

