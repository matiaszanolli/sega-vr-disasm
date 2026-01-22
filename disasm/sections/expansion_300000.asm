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

; Test function 2: Increment COMM6 register every frame (frame counter)
; COMM6 is at $2000402C (SH2 address space) per hardware manual
; Reads current value, increments by 1, writes back
expansion_frame_counter:
        dc.w    $D002                   ; MOV.L @(disp,PC),R0 (load COMM6 addr)
        dc.w    $6008                   ; MOV.L @R0,R1 (read current COMM6 value to R1)
        dc.w    $7101                   ; ADD #1,R1 (increment by 1)
        dc.w    $2012                   ; MOV.L R1,@R0 (write R1 back to COMM6)
        dc.w    $000B                   ; RTS
        dc.w    $0009                   ; NOP (delay slot)
        dc.w    $0000                   ; alignment padding
        dc.l    $2000402C               ; COMM6 address literal (4 bytes)

        ; Fill remaining space with 0xFF padding
        dcb.b   $100000-18,$FF          ; 1MB - 18 bytes of code/data
