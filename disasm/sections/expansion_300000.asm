; ============================================================================
; Expansion ROM Section ($300000-$3FFFFF)
; 1MB of SH2 working space
; ============================================================================
;
; NOTE: This section is executed by SH2 processors, not the 68000.
; It can only contain:
; - SH2 code in dc.w format (raw opcodes)
; - Data literals
; - Padding (0xFF)
;
; ============================================================================

        org     $300000

; Test function 1: NOP then return
expansion_test:
        dc.w    $0009                   ; NOP
        dc.w    $000B                   ; RTS
        dc.w    $0009                   ; NOP (delay slot)

; Test function 2: Increment COMM4 counter (response register)
; Uses two-register protocol to avoid race conditions:
;   - COMM6 ($2000402C): Master→Slave signal (read only from Slave)
;   - COMM4 ($20004028): Slave→Master counter (write only from Slave)
; This avoids hardware undefined behavior from simultaneous writes
expansion_frame_counter:
        dc.w    $D002                   ; MOV.L @(disp,PC),R0 (load COMM4 addr)
        dc.w    $6008                   ; MOV.L @R0,R1 (read current COMM4 value to R1)
        dc.w    $7101                   ; ADD #1,R1 (increment by 1)
        dc.w    $2012                   ; MOV.L R1,@R0 (write R1 back to COMM4)
        dc.w    $000B                   ; RTS
        dc.w    $0009                   ; NOP (delay slot)
        dc.w    $0000                   ; alignment padding
        dc.l    $20004028               ; COMM4 address literal (4 bytes)

        ; Fill remaining space with 0xFF padding
        dcb.b   $100000-18,$FF          ; 1MB - 18 bytes of code/data
