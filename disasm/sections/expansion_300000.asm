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

; Test function 2: Write 0xAB to COMM6 register
; COMM6 is at $20004030 (SH2 address space)
expansion_comm_test:
        dc.w    $E1AB                   ; MOV #0xAB,R1 (load signature into R1)
        dc.w    $D002                   ; MOV.L @(disp,PC),R0 (load COMM6 addr from literal)
        dc.w    $2012                   ; MOV.L R1,@R0 (write R1 to address in R0)
        dc.w    $000B                   ; RTS
        dc.w    $0009                   ; NOP (delay slot)
        dc.w    $0000                   ; alignment padding
        dc.l    $20004030               ; COMM6 address literal (4 bytes)

        ; Fill remaining space with 0xFF padding
        dcb.b   $100000-18,$FF          ; 1MB - 18 bytes of code/data
