; ============================================================================
; Exception Handlers & MARS Initialization ($0832-$0FFF)
; ============================================================================
; Contains:
;   $832: DefaultExceptionHandler - 6 bytes (NOP, NOP, BRA.S loop)
;   $838: MARSAdapterInit - ADEN/REN check, security setup
;   $894: RAM_InitCode2 - Alternate init code copied to RAM
;   $8A8: SH2Handshake - Wait for 'VRES' signature
;   And more initialization/utility code...
; ============================================================================

        org     $000832

ExceptionHandlers:

; ============================================================================
; DefaultExceptionHandler - Crash/Fault Handler
; ============================================================================
; All unhandled exceptions (bus error, address error, illegal instruction,
; etc.) jump here. Performs NOP padding then branches back to $82A in
; entry_point section for error handling.
; ============================================================================
DefaultExceptionHandler:
        nop                             ; 00880832: Wait
        nop                             ; 00880834: Wait
        dc.w    $60F2                   ; 00880836: BRA.S $0088082A (error path)

; --- 32X adapter init - ADEN/REN ---
MARSAdapterInit:
        dc.w    $49F9, $00A1, $5100    ; 00880838: LEA $00A15100,A4
        dc.w    $082C, $0000, $0001    ; 0088083E: BTST #0,$0001(A4)
        dc.w    $6720                    ; 00880844: BEQ.S $00880866
        dc.w    $082C, $0001, $0001    ; 00880846: BTST #1,$0001(A4)
        dc.w    $665A                    ; 0088084C: BNE.S $008808A8
        dc.w    $4BF9, $00A1, $0000    ; 0088084E: LEA $00A10000,A5
        dc.w    $287C, $FFFF, $FFC0    ; 00880854: MOVEA.L #$FFFFFFC0,A4
        dc.w    $3E3C                    ; 0088085A: dc.w $3E3C
        dc.w    $0F3C                    ; 0088085C: dc.w $0F3C
        dc.w    $43F9, $0088, $06E4    ; 0088085E: LEA $008806E4,A1
        dc.w    $4ED1                    ; 00880864: JMP (A1)
        dc.w    $23FC, $0000, $0000, $00A1, $5128  ; 00880866: MOVE.L #$00000000,$00A15128
        dc.w    $41F9, $0088, $0894    ; 00880870: LEA $00880894,A0
        dc.w    $43F9, $00FF, $0000    ; 00880876: LEA $00FF0000,A1
        dc.w    $22D8                    ; 0088087C: MOVE.L (A0)+,(A1)+
        dc.w    $22D8                    ; 0088087E: MOVE.L (A0)+,(A1)+
        dc.w    $22D8                    ; 00880880: MOVE.L (A0)+,(A1)+
        dc.w    $22D8                    ; 00880882: MOVE.L (A0)+,(A1)+
        dc.w    $22D8                    ; 00880884: MOVE.L (A0)+,(A1)+
        dc.w    $22D8                    ; 00880886: MOVE.L (A0)+,(A1)+
        dc.w    $22D8                    ; 00880888: MOVE.L (A0)+,(A1)+
        dc.w    $22D8                    ; 0088088A: MOVE.L (A0)+,(A1)+
        dc.w    $41F9, $00FF, $0000    ; 0088088C: LEA $00FF0000,A0
        dc.w    $4ED0                    ; 00880892: JMP (A0)
        dc.w    $197C                    ; 00880894: dc.w $197C
        dc.w    $0001                    ; 00880896: dc.w $0001
        dc.w    $0001                    ; 00880898: dc.w $0001
        dc.w    $41F9, $0088, $084E    ; 0088089A: LEA $0088084E,A0
        dc.w    $D1FC                    ; 008808A0: dc.w $D1FC
        dc.w    $0088                    ; 008808A2: dc.w $0088
        dc.w    $0000                    ; 008808A4: dc.w $0000
        dc.w    $4ED0                    ; 008808A6: JMP (A0)

; --- Wait for VRES/M_OK/S_OK ---
SH2Handshake:
        dc.w    $3E3C                    ; 008808A8: dc.w $3E3C
        dc.w    $1000                    ; 008808AA: dc.w $1000
        dc.w    $0CB9                    ; 008808AC: dc.w $0CB9
        dc.w    $5652                    ; 008808AE: dc.w $5652
        dc.w    $4553                    ; 008808B0: dc.w $4553
        dc.w    $00A1                    ; 008808B2: dc.w $00A1
        dc.w    $512C                    ; 008808B4: dc.w $512C
        dc.w    $57CF                    ; 008808B6: dc.w $57CF
        dc.w    $FFF4                    ; 008808B8: dc.w $FFF4
        dc.w    $6700, $00FA            ; 008808BA: BEQ.W $008809B6
        dc.w    $4EBA                    ; 008808BE: dc.w $4EBA
        dc.w    $1D7E                    ; 008808C0: dc.w $1D7E
        dc.w    $0039                    ; 008808C2: dc.w $0039
        dc.w    $0003                    ; 008808C4: dc.w $0003
        dc.w    $00A1                    ; 008808C6: dc.w $00A1
        dc.w    $5103                    ; 008808C8: dc.w $5103
        dc.w    $41F9, $00A1, $5120    ; 008808CA: LEA $00A15120,A0
        dc.w    $0C90                    ; 008808D0: dc.w $0C90
        dc.w    $4D5F                    ; 008808D2: dc.w $4D5F
        dc.w    $4F4B                    ; 008808D4: dc.w $4F4B
        dc.w    $66F8                    ; 008808D6: BNE.S $008808D0
        dc.w    $0CA8, $535F, $4F4B, $0004  ; 008808D8: CMPI.L #$535F4F4B,$0004(A0)
        dc.w    $66F6                    ; 008808E0: BNE.S $008808D8
        dc.w    $20BC                    ; 008808E2: dc.w $20BC
        dc.w    $0000                    ; 008808E4: dc.w $0000
        dc.w    $0000                    ; 008808E6: dc.w $0000
        dc.w    $40E7                    ; 008808E8: dc.w $40E7
        dc.w    $46FC, $2700            ; 008808EA: MOVE.W #$2700,SR
        dc.w    $33FC                    ; 008808EE: dc.w $33FC
        dc.w    $0100                    ; 008808F0: dc.w $0100
        dc.w    $00A1                    ; 008808F2: dc.w $00A1
        dc.w    $1100                    ; 008808F4: dc.w $1100
        dc.w    $33FC                    ; 008808F6: dc.w $33FC
        dc.w    $0100                    ; 008808F8: dc.w $0100
        dc.w    $00A1                    ; 008808FA: dc.w $00A1
        dc.w    $1200                    ; 008808FC: dc.w $1200
        dc.w    $0839                    ; 008808FE: dc.w $0839
        dc.w    $0000                    ; 00880900: dc.w $0000
        dc.w    $00A1                    ; 00880902: dc.w $00A1
        dc.w    $1100                    ; 00880904: dc.w $1100
        dc.w    $66F6                    ; 00880906: BNE.S $008808FE
        dc.w    $43F9, $00A0, $0000    ; 00880908: LEA $00A00000,A1
        dc.w    $12FC                    ; 0088090E: dc.w $12FC
        dc.w    $00F3                    ; 00880910: dc.w $00F3
        dc.w    $12FC                    ; 00880912: dc.w $12FC
        dc.w    $00F3                    ; 00880914: dc.w $00F3
        dc.w    $12FC                    ; 00880916: dc.w $12FC
        dc.w    $00C3                    ; 00880918: dc.w $00C3
        dc.w    $12FC                    ; 0088091A: dc.w $12FC
        dc.w    $0000                    ; 0088091C: dc.w $0000
        dc.w    $12FC                    ; 0088091E: dc.w $12FC
        dc.w    $0000                    ; 00880920: dc.w $0000
        dc.w    $33FC                    ; 00880922: dc.w $33FC
        dc.w    $0000                    ; 00880924: dc.w $0000
        dc.w    $00A1                    ; 00880926: dc.w $00A1
        dc.w    $1200                    ; 00880928: dc.w $1200
        dc.w    $4E71                    ; 0088092A: NOP
        dc.w    $4E71                    ; 0088092C: NOP
        dc.w    $4E71                    ; 0088092E: NOP
        dc.w    $4E71                    ; 00880930: NOP
        dc.w    $4E71                    ; 00880932: NOP
        dc.w    $4E71                    ; 00880934: NOP
        dc.w    $4E71                    ; 00880936: NOP
        dc.w    $4E71                    ; 00880938: NOP
        dc.w    $4E71                    ; 0088093A: NOP
        dc.w    $4E71                    ; 0088093C: NOP
        dc.w    $4E71                    ; 0088093E: NOP
        dc.w    $4E71                    ; 00880940: NOP
        dc.w    $4E71                    ; 00880942: NOP
        dc.w    $4E71                    ; 00880944: NOP
        dc.w    $33FC                    ; 00880946: dc.w $33FC
        dc.w    $0000                    ; 00880948: dc.w $0000
        dc.w    $00A1                    ; 0088094A: dc.w $00A1
        dc.w    $1100                    ; 0088094C: dc.w $1100
        dc.w    $33FC                    ; 0088094E: dc.w $33FC
        dc.w    $0100                    ; 00880950: dc.w $0100
        dc.w    $00A1                    ; 00880952: dc.w $00A1
        dc.w    $1200                    ; 00880954: dc.w $1200
        dc.w    $46DF                    ; 00880956: dc.w $46DF
        dc.w    $70FF                    ; 00880958: MOVEQ #$FF,D0
        dc.w    $13C0                    ; 0088095A: dc.w $13C0
        dc.w    $00C0                    ; 0088095C: dc.w $00C0
        dc.w    $0011                    ; 0088095E: dc.w $0011
        dc.w    $4E71                    ; 00880960: NOP
        dc.w    $4E71                    ; 00880962: NOP
        dc.w    $0400                    ; 00880964: dc.w $0400
        dc.w    $0020                    ; 00880966: dc.w $0020
        dc.w    $13C0                    ; 00880968: dc.w $13C0
        dc.w    $00C0                    ; 0088096A: dc.w $00C0
        dc.w    $0011                    ; 0088096C: dc.w $0011
        dc.w    $4E71                    ; 0088096E: NOP
        dc.w    $4E71                    ; 00880970: NOP
        dc.w    $0400                    ; 00880972: dc.w $0400
        dc.w    $0020                    ; 00880974: dc.w $0020
        dc.w    $13C0                    ; 00880976: dc.w $13C0
        dc.w    $00C0                    ; 00880978: dc.w $00C0
        dc.w    $0011                    ; 0088097A: dc.w $0011
        dc.w    $4E71                    ; 0088097C: NOP
        dc.w    $4E71                    ; 0088097E: NOP
        dc.w    $0400                    ; 00880980: dc.w $0400
        dc.w    $0020                    ; 00880982: dc.w $0020
        dc.w    $13C0                    ; 00880984: dc.w $13C0
        dc.w    $00C0                    ; 00880986: dc.w $00C0
        dc.w    $0011                    ; 00880988: dc.w $0011
        dc.w    $33FC                    ; 0088098A: dc.w $33FC
        dc.w    $0100                    ; 0088098C: dc.w $0100
        dc.w    $00A1                    ; 0088098E: dc.w $00A1
        dc.w    $1100                    ; 00880990: dc.w $1100
        dc.w    $0839                    ; 00880992: dc.w $0839
        dc.w    $0000                    ; 00880994: dc.w $0000
        dc.w    $00A1                    ; 00880996: dc.w $00A1
        dc.w    $1100                    ; 00880998: dc.w $1100
        dc.w    $66F6                    ; 0088099A: BNE.S $00880992
        dc.w    $43F9, $00A1, $30F1    ; 0088099C: LEA $00A130F1,A1
        dc.w    $4A11                    ; 008809A2: dc.w $4A11
        dc.w    $7000                    ; 008809A4: MOVEQ #$00,D0
        dc.w    $4EB8                    ; 008809A6: dc.w $4EB8
        dc.w    $00C0                    ; 008809A8: dc.w $00C0
        dc.w    $33FC                    ; 008809AA: dc.w $33FC
        dc.w    $0000                    ; 008809AC: dc.w $0000
        dc.w    $00A1                    ; 008809AE: dc.w $00A1
        dc.w    $1100                    ; 008809B0: dc.w $1100
        dc.w    $4EFA                    ; 008809B2: dc.w $4EFA
        dc.w    $01B6                    ; 008809B4: dc.w $01B6
        dc.w    $40E7                    ; 008809B6: dc.w $40E7
        dc.w    $46FC, $2700            ; 008809B8: MOVE.W #$2700,SR
        dc.w    $33FC                    ; 008809BC: dc.w $33FC
        dc.w    $0100                    ; 008809BE: dc.w $0100
        dc.w    $00A1                    ; 008809C0: dc.w $00A1
        dc.w    $1100                    ; 008809C2: dc.w $1100
        dc.w    $33FC                    ; 008809C4: dc.w $33FC
        dc.w    $0100                    ; 008809C6: dc.w $0100
        dc.w    $00A1                    ; 008809C8: dc.w $00A1
        dc.w    $1200                    ; 008809CA: dc.w $1200
        dc.w    $0839                    ; 008809CC: dc.w $0839
        dc.w    $0000                    ; 008809CE: dc.w $0000
        dc.w    $00A1                    ; 008809D0: dc.w $00A1
        dc.w    $1100                    ; 008809D2: dc.w $1100
        dc.w    $66F6                    ; 008809D4: BNE.S $008809CC
        dc.w    $43F9, $00A0, $0000    ; 008809D6: LEA $00A00000,A1
        dc.w    $12FC                    ; 008809DC: dc.w $12FC
        dc.w    $00F3                    ; 008809DE: dc.w $00F3
        dc.w    $12FC                    ; 008809E0: dc.w $12FC
        dc.w    $00F3                    ; 008809E2: dc.w $00F3
        dc.w    $12FC                    ; 008809E4: dc.w $12FC
        dc.w    $00C3                    ; 008809E6: dc.w $00C3
        dc.w    $12FC                    ; 008809E8: dc.w $12FC
        dc.w    $0000                    ; 008809EA: dc.w $0000
        dc.w    $12FC                    ; 008809EC: dc.w $12FC
        dc.w    $0000                    ; 008809EE: dc.w $0000
        dc.w    $33FC                    ; 008809F0: dc.w $33FC
        dc.w    $0000                    ; 008809F2: dc.w $0000
        dc.w    $00A1                    ; 008809F4: dc.w $00A1
        dc.w    $1200                    ; 008809F6: dc.w $1200
        dc.w    $4E71                    ; 008809F8: NOP
        dc.w    $4E71                    ; 008809FA: NOP
        dc.w    $4E71                    ; 008809FC: NOP
        dc.w    $4E71                    ; 008809FE: NOP
        dc.w    $4E71                    ; 00880A00: NOP
        dc.w    $4E71                    ; 00880A02: NOP
        dc.w    $4E71                    ; 00880A04: NOP
        dc.w    $4E71                    ; 00880A06: NOP
        dc.w    $4E71                    ; 00880A08: NOP
        dc.w    $4E71                    ; 00880A0A: NOP
        dc.w    $4E71                    ; 00880A0C: NOP
        dc.w    $4E71                    ; 00880A0E: NOP
        dc.w    $4E71                    ; 00880A10: NOP
        dc.w    $4E71                    ; 00880A12: NOP
        dc.w    $33FC                    ; 00880A14: dc.w $33FC
        dc.w    $0000                    ; 00880A16: dc.w $0000
        dc.w    $00A1                    ; 00880A18: dc.w $00A1
        dc.w    $1100                    ; 00880A1A: dc.w $1100
        dc.w    $33FC                    ; 00880A1C: dc.w $33FC
        dc.w    $0100                    ; 00880A1E: dc.w $0100
        dc.w    $00A1                    ; 00880A20: dc.w $00A1
        dc.w    $1200                    ; 00880A22: dc.w $1200
        dc.w    $46DF                    ; 00880A24: dc.w $46DF
        dc.w    $70FF                    ; 00880A26: MOVEQ #$FF,D0
        dc.w    $13C0                    ; 00880A28: dc.w $13C0
        dc.w    $00C0                    ; 00880A2A: dc.w $00C0
        dc.w    $0011                    ; 00880A2C: dc.w $0011
        dc.w    $4E71                    ; 00880A2E: NOP
        dc.w    $4E71                    ; 00880A30: NOP
        dc.w    $0400                    ; 00880A32: dc.w $0400
        dc.w    $0020                    ; 00880A34: dc.w $0020
        dc.w    $13C0                    ; 00880A36: dc.w $13C0
        dc.w    $00C0                    ; 00880A38: dc.w $00C0
        dc.w    $0011                    ; 00880A3A: dc.w $0011
        dc.w    $4E71                    ; 00880A3C: NOP
        dc.w    $4E71                    ; 00880A3E: NOP
        dc.w    $0400                    ; 00880A40: dc.w $0400
        dc.w    $0020                    ; 00880A42: dc.w $0020
        dc.w    $13C0                    ; 00880A44: dc.w $13C0
        dc.w    $00C0                    ; 00880A46: dc.w $00C0
        dc.w    $0011                    ; 00880A48: dc.w $0011
        dc.w    $4E71                    ; 00880A4A: NOP
        dc.w    $4E71                    ; 00880A4C: NOP
        dc.w    $0400                    ; 00880A4E: dc.w $0400
        dc.w    $0020                    ; 00880A50: dc.w $0020
        dc.w    $13C0                    ; 00880A52: dc.w $13C0
        dc.w    $00C0                    ; 00880A54: dc.w $00C0
        dc.w    $0011                    ; 00880A56: dc.w $0011
        dc.w    $33FC                    ; 00880A58: dc.w $33FC
        dc.w    $0100                    ; 00880A5A: dc.w $0100
        dc.w    $00A1                    ; 00880A5C: dc.w $00A1
        dc.w    $1100                    ; 00880A5E: dc.w $1100
        dc.w    $0839                    ; 00880A60: dc.w $0839
        dc.w    $0000                    ; 00880A62: dc.w $0000
        dc.w    $00A1                    ; 00880A64: dc.w $00A1
        dc.w    $1100                    ; 00880A66: dc.w $1100
        dc.w    $66F6                    ; 00880A68: BNE.S $00880A60
        dc.w    $43F9, $00A1, $30F1    ; 00880A6A: LEA $00A130F1,A1
        dc.w    $4A11                    ; 00880A70: dc.w $4A11
        dc.w    $7000                    ; 00880A72: MOVEQ #$00,D0
        dc.w    $4EB8                    ; 00880A74: dc.w $4EB8
        dc.w    $00C0                    ; 00880A76: dc.w $00C0
        dc.w    $33FC                    ; 00880A78: dc.w $33FC
        dc.w    $0000                    ; 00880A7A: dc.w $0000
        dc.w    $00A1                    ; 00880A7C: dc.w $00A1
        dc.w    $1100                    ; 00880A7E: dc.w $1100
        dc.w    $4EBA                    ; 00880A80: dc.w $4EBA
        dc.w    $1BBC                    ; 00880A82: dc.w $1BBC
        dc.w    $4EFA                    ; 00880A84: dc.w $4EFA
        dc.w    $00E4                    ; 00880A86: dc.w $00E4
        dc.w    $40E7                    ; 00880A88: dc.w $40E7
        dc.w    $46FC, $2700            ; 00880A8A: MOVE.W #$2700,SR
        dc.w    $33FC                    ; 00880A8E: dc.w $33FC
        dc.w    $0100                    ; 00880A90: dc.w $0100
        dc.w    $00A1                    ; 00880A92: dc.w $00A1
        dc.w    $1100                    ; 00880A94: dc.w $1100
        dc.w    $33FC                    ; 00880A96: dc.w $33FC
        dc.w    $0100                    ; 00880A98: dc.w $0100
        dc.w    $00A1                    ; 00880A9A: dc.w $00A1
        dc.w    $1200                    ; 00880A9C: dc.w $1200
        dc.w    $0839                    ; 00880A9E: dc.w $0839
        dc.w    $0000                    ; 00880AA0: dc.w $0000
        dc.w    $00A1                    ; 00880AA2: dc.w $00A1
        dc.w    $1100                    ; 00880AA4: dc.w $1100
        dc.w    $66F6                    ; 00880AA6: BNE.S $00880A9E
        dc.w    $43F9, $00A0, $0000    ; 00880AA8: LEA $00A00000,A1
        dc.w    $12FC                    ; 00880AAE: dc.w $12FC
        dc.w    $00F3                    ; 00880AB0: dc.w $00F3
        dc.w    $12FC                    ; 00880AB2: dc.w $12FC
        dc.w    $00F3                    ; 00880AB4: dc.w $00F3
        dc.w    $12FC                    ; 00880AB6: dc.w $12FC
        dc.w    $00C3                    ; 00880AB8: dc.w $00C3
        dc.w    $12FC                    ; 00880ABA: dc.w $12FC
        dc.w    $0000                    ; 00880ABC: dc.w $0000
        dc.w    $12FC                    ; 00880ABE: dc.w $12FC
        dc.w    $0000                    ; 00880AC0: dc.w $0000
        dc.w    $33FC                    ; 00880AC2: dc.w $33FC
        dc.w    $0000                    ; 00880AC4: dc.w $0000
        dc.w    $00A1                    ; 00880AC6: dc.w $00A1
        dc.w    $1200                    ; 00880AC8: dc.w $1200
        dc.w    $4E71                    ; 00880ACA: NOP
        dc.w    $4E71                    ; 00880ACC: NOP
        dc.w    $4E71                    ; 00880ACE: NOP
        dc.w    $4E71                    ; 00880AD0: NOP
        dc.w    $4E71                    ; 00880AD2: NOP
        dc.w    $4E71                    ; 00880AD4: NOP
        dc.w    $4E71                    ; 00880AD6: NOP
        dc.w    $4E71                    ; 00880AD8: NOP
        dc.w    $4E71                    ; 00880ADA: NOP
        dc.w    $4E71                    ; 00880ADC: NOP
        dc.w    $4E71                    ; 00880ADE: NOP
        dc.w    $4E71                    ; 00880AE0: NOP
        dc.w    $4E71                    ; 00880AE2: NOP
        dc.w    $4E71                    ; 00880AE4: NOP
        dc.w    $33FC                    ; 00880AE6: dc.w $33FC
        dc.w    $0000                    ; 00880AE8: dc.w $0000
        dc.w    $00A1                    ; 00880AEA: dc.w $00A1
        dc.w    $1100                    ; 00880AEC: dc.w $1100
        dc.w    $33FC                    ; 00880AEE: dc.w $33FC
        dc.w    $0100                    ; 00880AF0: dc.w $0100
        dc.w    $00A1                    ; 00880AF2: dc.w $00A1
        dc.w    $1200                    ; 00880AF4: dc.w $1200
        dc.w    $46DF                    ; 00880AF6: dc.w $46DF
        dc.w    $70FF                    ; 00880AF8: MOVEQ #$FF,D0
        dc.w    $13C0                    ; 00880AFA: dc.w $13C0
        dc.w    $00C0                    ; 00880AFC: dc.w $00C0
        dc.w    $0011                    ; 00880AFE: dc.w $0011
        dc.w    $4E71                    ; 00880B00: NOP
        dc.w    $4E71                    ; 00880B02: NOP
        dc.w    $0400                    ; 00880B04: dc.w $0400
        dc.w    $0020                    ; 00880B06: dc.w $0020
        dc.w    $13C0                    ; 00880B08: dc.w $13C0
        dc.w    $00C0                    ; 00880B0A: dc.w $00C0
        dc.w    $0011                    ; 00880B0C: dc.w $0011
        dc.w    $4E71                    ; 00880B0E: NOP
        dc.w    $4E71                    ; 00880B10: NOP
        dc.w    $0400                    ; 00880B12: dc.w $0400
        dc.w    $0020                    ; 00880B14: dc.w $0020
        dc.w    $13C0                    ; 00880B16: dc.w $13C0
        dc.w    $00C0                    ; 00880B18: dc.w $00C0
        dc.w    $0011                    ; 00880B1A: dc.w $0011
        dc.w    $4E71                    ; 00880B1C: NOP
        dc.w    $4E71                    ; 00880B1E: NOP
        dc.w    $0400                    ; 00880B20: dc.w $0400
        dc.w    $0020                    ; 00880B22: dc.w $0020
        dc.w    $13C0                    ; 00880B24: dc.w $13C0
        dc.w    $00C0                    ; 00880B26: dc.w $00C0
        dc.w    $0011                    ; 00880B28: dc.w $0011
        dc.w    $33FC                    ; 00880B2A: dc.w $33FC
        dc.w    $0100                    ; 00880B2C: dc.w $0100
        dc.w    $00A1                    ; 00880B2E: dc.w $00A1
        dc.w    $1100                    ; 00880B30: dc.w $1100
        dc.w    $0839                    ; 00880B32: dc.w $0839
        dc.w    $0000                    ; 00880B34: dc.w $0000
        dc.w    $00A1                    ; 00880B36: dc.w $00A1
        dc.w    $1100                    ; 00880B38: dc.w $1100
        dc.w    $66F6                    ; 00880B3A: BNE.S $00880B32
        dc.w    $43F9, $00A1, $30F1    ; 00880B3C: LEA $00A130F1,A1
        dc.w    $4A11                    ; 00880B42: dc.w $4A11
        dc.w    $7000                    ; 00880B44: MOVEQ #$00,D0
        dc.w    $4EB8                    ; 00880B46: dc.w $4EB8
        dc.w    $00C0                    ; 00880B48: dc.w $00C0
        dc.w    $33FC                    ; 00880B4A: dc.w $33FC
        dc.w    $0000                    ; 00880B4C: dc.w $0000
        dc.w    $00A1                    ; 00880B4E: dc.w $00A1
        dc.w    $1100                    ; 00880B50: dc.w $1100
        dc.w    $33FC                    ; 00880B52: dc.w $33FC
        dc.w    $0001                    ; 00880B54: dc.w $0001
        dc.w    $00A1                    ; 00880B56: dc.w $00A1
        dc.w    $5104                    ; 00880B58: dc.w $5104
        dc.w    $4DF9, $00C0, $0000    ; 00880B5A: LEA $00C00000,A6
        dc.w    $4BF9, $00C0, $0004    ; 00880B60: LEA $00C00004,A5
        dc.w    $4EBA                    ; 00880B66: dc.w $4EBA
        dc.w    $0118                    ; 00880B68: dc.w $0118
        dc.w    $4EBA                    ; 00880B6A: dc.w $4EBA
        dc.w    $00DC                    ; 00880B6C: dc.w $00DC
        dc.w    $4EBA                    ; 00880B6E: dc.w $4EBA
        dc.w    $00EA                    ; 00880B70: dc.w $00EA
        dc.w    $4DF9, $00C0, $0000    ; 00880B72: LEA $00C00000,A6
        dc.w    $4BF9, $00C0, $0004    ; 00880B78: LEA $00C00004,A5
        dc.w    $40E7                    ; 00880B7E: dc.w $40E7
        dc.w    $46FC, $2700            ; 00880B80: MOVE.W #$2700,SR
        dc.w    $33FC                    ; 00880B84: dc.w $33FC
        dc.w    $0100                    ; 00880B86: dc.w $0100
        dc.w    $00A1                    ; 00880B88: dc.w $00A1
        dc.w    $1100                    ; 00880B8A: dc.w $1100
        dc.w    $33FC                    ; 00880B8C: dc.w $33FC
        dc.w    $0100                    ; 00880B8E: dc.w $0100
        dc.w    $00A1                    ; 00880B90: dc.w $00A1
        dc.w    $1200                    ; 00880B92: dc.w $1200
        dc.w    $0839                    ; 00880B94: dc.w $0839
        dc.w    $0000                    ; 00880B96: dc.w $0000
        dc.w    $00A1                    ; 00880B98: dc.w $00A1
        dc.w    $1100                    ; 00880B9A: dc.w $1100
        dc.w    $66F6                    ; 00880B9C: BNE.S $00880B94
        dc.w    $43F9, $00A0, $0000    ; 00880B9E: LEA $00A00000,A1
        dc.w    $12FC                    ; 00880BA4: dc.w $12FC
        dc.w    $00F3                    ; 00880BA6: dc.w $00F3
        dc.w    $12FC                    ; 00880BA8: dc.w $12FC
        dc.w    $00F3                    ; 00880BAA: dc.w $00F3
        dc.w    $12FC                    ; 00880BAC: dc.w $12FC
        dc.w    $00C3                    ; 00880BAE: dc.w $00C3
        dc.w    $12FC                    ; 00880BB0: dc.w $12FC
        dc.w    $0000                    ; 00880BB2: dc.w $0000
        dc.w    $12FC                    ; 00880BB4: dc.w $12FC
        dc.w    $0000                    ; 00880BB6: dc.w $0000
        dc.w    $33FC                    ; 00880BB8: dc.w $33FC
        dc.w    $0000                    ; 00880BBA: dc.w $0000
        dc.w    $00A1                    ; 00880BBC: dc.w $00A1
        dc.w    $1200                    ; 00880BBE: dc.w $1200
        dc.w    $4E71                    ; 00880BC0: NOP
        dc.w    $4E71                    ; 00880BC2: NOP
        dc.w    $4E71                    ; 00880BC4: NOP
        dc.w    $4E71                    ; 00880BC6: NOP
        dc.w    $4E71                    ; 00880BC8: NOP
        dc.w    $4E71                    ; 00880BCA: NOP
        dc.w    $4E71                    ; 00880BCC: NOP
        dc.w    $4E71                    ; 00880BCE: NOP
        dc.w    $4E71                    ; 00880BD0: NOP
        dc.w    $4E71                    ; 00880BD2: NOP
        dc.w    $4E71                    ; 00880BD4: NOP
        dc.w    $4E71                    ; 00880BD6: NOP
        dc.w    $4E71                    ; 00880BD8: NOP
        dc.w    $4E71                    ; 00880BDA: NOP
        dc.w    $33FC                    ; 00880BDC: dc.w $33FC
        dc.w    $0000                    ; 00880BDE: dc.w $0000
        dc.w    $00A1                    ; 00880BE0: dc.w $00A1
        dc.w    $1100                    ; 00880BE2: dc.w $1100
        dc.w    $33FC                    ; 00880BE4: dc.w $33FC
        dc.w    $0100                    ; 00880BE6: dc.w $0100
        dc.w    $00A1                    ; 00880BE8: dc.w $00A1
        dc.w    $1200                    ; 00880BEA: dc.w $1200
        dc.w    $46DF                    ; 00880BEC: dc.w $46DF
        dc.w    $70FF                    ; 00880BEE: MOVEQ #$FF,D0
        dc.w    $13C0                    ; 00880BF0: dc.w $13C0
        dc.w    $00C0                    ; 00880BF2: dc.w $00C0
        dc.w    $0011                    ; 00880BF4: dc.w $0011
        dc.w    $4E71                    ; 00880BF6: NOP
        dc.w    $4E71                    ; 00880BF8: NOP
        dc.w    $0400                    ; 00880BFA: dc.w $0400
        dc.w    $0020                    ; 00880BFC: dc.w $0020
        dc.w    $13C0                    ; 00880BFE: dc.w $13C0
        dc.w    $00C0                    ; 00880C00: dc.w $00C0
        dc.w    $0011                    ; 00880C02: dc.w $0011
        dc.w    $4E71                    ; 00880C04: NOP
        dc.w    $4E71                    ; 00880C06: NOP
        dc.w    $0400                    ; 00880C08: dc.w $0400
        dc.w    $0020                    ; 00880C0A: dc.w $0020
        dc.w    $13C0                    ; 00880C0C: dc.w $13C0
        dc.w    $00C0                    ; 00880C0E: dc.w $00C0
        dc.w    $0011                    ; 00880C10: dc.w $0011
        dc.w    $4E71                    ; 00880C12: NOP
        dc.w    $4E71                    ; 00880C14: NOP
        dc.w    $0400                    ; 00880C16: dc.w $0400
        dc.w    $0020                    ; 00880C18: dc.w $0020
        dc.w    $13C0                    ; 00880C1A: dc.w $13C0
        dc.w    $00C0                    ; 00880C1C: dc.w $00C0
        dc.w    $0011                    ; 00880C1E: dc.w $0011
        dc.w    $4EBA                    ; 00880C20: dc.w $4EBA
        dc.w    $1418                    ; 00880C22: dc.w $1418
        dc.w    $4EBA                    ; 00880C24: dc.w $4EBA
        dc.w    $0142                    ; 00880C26: dc.w $0142
        dc.w    $4EBA                    ; 00880C28: dc.w $4EBA
        dc.w    $019A                    ; 00880C2A: dc.w $019A
        dc.w    $4EB9, $0088, $C85C    ; 00880C2C: JSR $0088C85C
        dc.w    $4EB9, $0088, $0FBE    ; 00880C32: JSR $00880FBE
        dc.w    $23FC, $0089, $4262, $00FF, $0002  ; 00880C38: MOVE.L #$00894262,$00FF0002
        dc.w    $4EF9, $00FF, $0000    ; 00880C42: JMP $00FF0000
        dc.w    $4E71                    ; 00880C48: NOP
        dc.w    $4E71                    ; 00880C4A: NOP
        dc.w    $3039                    ; 00880C4C: dc.w $3039
        dc.w    $00C0                    ; 00880C4E: dc.w $00C0
        dc.w    $0004                    ; 00880C50: dc.w $0004
        dc.w    $0800                    ; 00880C52: dc.w $0800
        dc.w    $0001                    ; 00880C54: dc.w $0001
        dc.w    $66F0                    ; 00880C56: BNE.S $00880C48
        dc.w    $4E75                    ; 00880C58: RTS
        dc.w    $4DFA                    ; 00880C5A: dc.w $4DFA
        dc.w    $0014                    ; 00880C5C: dc.w $0014
        dc.w    $4CD6                    ; 00880C5E: dc.w $4CD6
        dc.w    $000F                    ; 00880C60: dc.w $000F
        dc.w    $4CD6                    ; 00880C62: dc.w $4CD6
        dc.w    $00F0                    ; 00880C64: dc.w $00F0
        dc.w    $4CD6                    ; 00880C66: dc.w $4CD6
        dc.w    $0F00                    ; 00880C68: dc.w $0F00
        dc.w    $4CD6                    ; 00880C6A: dc.w $4CD6
        dc.w    $7000                    ; 00880C6C: MOVEQ #$00,D0
        dc.w    $4E75                    ; 00880C6E: RTS
        dc.w    $0000                    ; 00880C70: dc.w $0000
        dc.w    $0000                    ; 00880C72: dc.w $0000
        dc.w    $0000                    ; 00880C74: dc.w $0000
        dc.w    $0000                    ; 00880C76: dc.w $0000
        dc.w    $0000                    ; 00880C78: dc.w $0000
        dc.w    $0000                    ; 00880C7A: dc.w $0000
        dc.w    $0000                    ; 00880C7C: dc.w $0000
        dc.w    $0000                    ; 00880C7E: dc.w $0000
        dc.w    $40E7                    ; 00880C80: dc.w $40E7
        dc.w    $46FC, $2700            ; 00880C82: MOVE.W #$2700,SR
        dc.w    $33FC                    ; 00880C86: dc.w $33FC
        dc.w    $0100                    ; 00880C88: dc.w $0100
        dc.w    $00A1                    ; 00880C8A: dc.w $00A1
        dc.w    $1100                    ; 00880C8C: dc.w $1100
        dc.w    $33FC                    ; 00880C8E: dc.w $33FC
        dc.w    $0100                    ; 00880C90: dc.w $0100
        dc.w    $00A1                    ; 00880C92: dc.w $00A1
        dc.w    $1200                    ; 00880C94: dc.w $1200
        dc.w    $0839                    ; 00880C96: dc.w $0839
        dc.w    $0000                    ; 00880C98: dc.w $0000
        dc.w    $00A1                    ; 00880C9A: dc.w $00A1
        dc.w    $1100                    ; 00880C9C: dc.w $1100
        dc.w    $66F6                    ; 00880C9E: BNE.S $00880C96
        dc.w    $43F9, $00A0, $0000    ; 00880CA0: LEA $00A00000,A1
        dc.w    $12FC                    ; 00880CA6: dc.w $12FC
        dc.w    $00F3                    ; 00880CA8: dc.w $00F3
        dc.w    $12FC                    ; 00880CAA: dc.w $12FC
        dc.w    $00F3                    ; 00880CAC: dc.w $00F3
        dc.w    $12FC                    ; 00880CAE: dc.w $12FC
        dc.w    $00C3                    ; 00880CB0: dc.w $00C3
        dc.w    $12FC                    ; 00880CB2: dc.w $12FC
        dc.w    $0000                    ; 00880CB4: dc.w $0000
        dc.w    $12FC                    ; 00880CB6: dc.w $12FC
        dc.w    $0000                    ; 00880CB8: dc.w $0000
        dc.w    $33FC                    ; 00880CBA: dc.w $33FC
        dc.w    $0000                    ; 00880CBC: dc.w $0000
        dc.w    $00A1                    ; 00880CBE: dc.w $00A1
        dc.w    $1200                    ; 00880CC0: dc.w $1200
        dc.w    $4E71                    ; 00880CC2: NOP
        dc.w    $4E71                    ; 00880CC4: NOP
        dc.w    $4E71                    ; 00880CC6: NOP
        dc.w    $4E71                    ; 00880CC8: NOP
        dc.w    $4E71                    ; 00880CCA: NOP
        dc.w    $4E71                    ; 00880CCC: NOP
        dc.w    $4E71                    ; 00880CCE: NOP
        dc.w    $4E71                    ; 00880CD0: NOP
        dc.w    $4E71                    ; 00880CD2: NOP
        dc.w    $4E71                    ; 00880CD4: NOP
        dc.w    $4E71                    ; 00880CD6: NOP
        dc.w    $4E71                    ; 00880CD8: NOP
        dc.w    $4E71                    ; 00880CDA: NOP
        dc.w    $4E71                    ; 00880CDC: NOP
        dc.w    $33FC                    ; 00880CDE: dc.w $33FC
        dc.w    $0000                    ; 00880CE0: dc.w $0000
        dc.w    $00A1                    ; 00880CE2: dc.w $00A1
        dc.w    $1100                    ; 00880CE4: dc.w $1100
        dc.w    $33FC                    ; 00880CE6: dc.w $33FC
        dc.w    $0100                    ; 00880CE8: dc.w $0100
        dc.w    $00A1                    ; 00880CEA: dc.w $00A1
        dc.w    $1200                    ; 00880CEC: dc.w $1200
        dc.w    $46DF                    ; 00880CEE: dc.w $46DF
        dc.w    $70FF                    ; 00880CF0: MOVEQ #$FF,D0
        dc.w    $13C0                    ; 00880CF2: dc.w $13C0
        dc.w    $00C0                    ; 00880CF4: dc.w $00C0
        dc.w    $0011                    ; 00880CF6: dc.w $0011
        dc.w    $4E71                    ; 00880CF8: NOP
        dc.w    $4E71                    ; 00880CFA: NOP
        dc.w    $0400                    ; 00880CFC: dc.w $0400
        dc.w    $0020                    ; 00880CFE: dc.w $0020
        dc.w    $13C0                    ; 00880D00: dc.w $13C0
        dc.w    $00C0                    ; 00880D02: dc.w $00C0
        dc.w    $0011                    ; 00880D04: dc.w $0011
        dc.w    $4E71                    ; 00880D06: NOP
        dc.w    $4E71                    ; 00880D08: NOP
        dc.w    $0400                    ; 00880D0A: dc.w $0400
        dc.w    $0020                    ; 00880D0C: dc.w $0020
        dc.w    $13C0                    ; 00880D0E: dc.w $13C0
        dc.w    $00C0                    ; 00880D10: dc.w $00C0
        dc.w    $0011                    ; 00880D12: dc.w $0011
        dc.w    $4E71                    ; 00880D14: NOP
        dc.w    $4E71                    ; 00880D16: NOP
        dc.w    $0400                    ; 00880D18: dc.w $0400
        dc.w    $0020                    ; 00880D1A: dc.w $0020
        dc.w    $13C0                    ; 00880D1C: dc.w $13C0
        dc.w    $00C0                    ; 00880D1E: dc.w $00C0
        dc.w    $0011                    ; 00880D20: dc.w $0011
        dc.w    $43F8                    ; 00880D22: dc.w $43F8
        dc.w    $C9A0                    ; 00880D24: dc.w $C9A0
        dc.w    $7200                    ; 00880D26: MOVEQ #$00,D1
        dc.w    $3E3C                    ; 00880D28: dc.w $3E3C
        dc.w    $0D57                    ; 00880D2A: dc.w $0D57
        dc.w    $22C1                    ; 00880D2C: dc.w $22C1
        dc.w    $51CF, $FFFC            ; 00880D2E: DBRA D7,$00880D2C
        dc.w    $1039                    ; 00880D32: dc.w $1039
        dc.w    $00A1                    ; 00880D34: dc.w $00A1
        dc.w    $0001                    ; 00880D36: dc.w $0001
        dc.w    $11C0                    ; 00880D38: dc.w $11C0
        dc.w    $EF04                    ; 00880D3A: dc.w $EF04
        dc.w    $0800                    ; 00880D3C: dc.w $0800
        dc.w    $0007                    ; 00880D3E: dc.w $0007
        dc.w    $56F8                    ; 00880D40: dc.w $56F8
        dc.w    $EF05                    ; 00880D42: dc.w $EF05
        dc.w    $0800                    ; 00880D44: dc.w $0800
        dc.w    $0006                    ; 00880D46: dc.w $0006
        dc.w    $56F8                    ; 00880D48: dc.w $56F8
        dc.w    $EF06                    ; 00880D4A: dc.w $EF06
        dc.w    $4EB9, $0088, $C7E8    ; 00880D4C: JSR $0088C7E8
        dc.w    $4EBA                    ; 00880D52: dc.w $4EBA
        dc.w    $0B84                    ; 00880D54: dc.w $0B84
        dc.w    $4EBA                    ; 00880D56: dc.w $4EBA
        dc.w    $09B4                    ; 00880D58: dc.w $09B4
        dc.w    $11FC                    ; 00880D5A: dc.w $11FC
        dc.w    $0001                    ; 00880D5C: dc.w $0001
        dc.w    $FDA9                    ; 00880D5E: dc.w $FDA9
        dc.w    $11F8                    ; 00880D60: dc.w $11F8
        dc.w    $C818                    ; 00880D62: dc.w $C818
        dc.w    $FEA4                    ; 00880D64: dc.w $FEA4
        dc.w    $4E75                    ; 00880D66: RTS
        dc.w    $4EBA                    ; 00880D68: dc.w $4EBA
        dc.w    $0046                    ; 00880D6A: dc.w $0046
        dc.w    $4EBA                    ; 00880D6C: dc.w $4EBA
        dc.w    $027C                    ; 00880D6E: dc.w $027C
        dc.w    $1038                    ; 00880D70: dc.w $1038
        dc.w    $FEA4                    ; 00880D72: dc.w $FEA4
        dc.w    $B038                    ; 00880D74: dc.w $B038
        dc.w    $C818                    ; 00880D76: dc.w $C818
        dc.w    $670A                    ; 00880D78: BEQ.S $00880D84
        dc.w    $4EBA                    ; 00880D7A: dc.w $4EBA
        dc.w    $0990                    ; 00880D7C: dc.w $0990
        dc.w    $11F8                    ; 00880D7E: dc.w $11F8
        dc.w    $C818                    ; 00880D80: dc.w $C818
        dc.w    $FEA4                    ; 00880D82: dc.w $FEA4
        dc.w    $4EBA                    ; 00880D84: dc.w $4EBA
        dc.w    $02C2                    ; 00880D86: dc.w $02C2
        dc.w    $33FC                    ; 00880D88: dc.w $33FC
        dc.w    $0083                    ; 00880D8A: dc.w $0083
        dc.w    $00A1                    ; 00880D8C: dc.w $00A1
        dc.w    $5100                    ; 00880D8E: dc.w $5100
        dc.w    $0239                    ; 00880D90: dc.w $0239
        dc.w    $00FC                    ; 00880D92: dc.w $00FC
        dc.w    $00A1                    ; 00880D94: dc.w $00A1
        dc.w    $5181                    ; 00880D96: dc.w $5181
        dc.w    $4EB9, $0088, $266C    ; 00880D98: JSR $0088266C
        dc.w    $4EB9, $0088, $26C8    ; 00880D9E: JSR $008826C8
        dc.w    $45F9, $008B, $A020    ; 00880DA4: LEA $008BA020,A2
        dc.w    $4EF9, $0088, $284C    ; 00880DAA: JMP $0088284C
        dc.w    $43F9, $00FF, $1000    ; 00880DB0: LEA $00FF1000,A1
        dc.w    $7200                    ; 00880DB6: MOVEQ #$00,D1
        dc.w    $3E3C                    ; 00880DB8: dc.w $3E3C
        dc.w    $2E67                    ; 00880DBA: dc.w $2E67
        dc.w    $22C1                    ; 00880DBC: dc.w $22C1
        dc.w    $51CF, $FFFC            ; 00880DBE: DBRA D7,$00880DBC
        dc.w    $4E75                    ; 00880DC2: RTS
        dc.w    $4A38                    ; 00880DC4: dc.w $4A38
        dc.w    $EF05                    ; 00880DC6: dc.w $EF05
        dc.w    $6708                    ; 00880DC8: BEQ.S $00880DD2
        dc.w    $4A38                    ; 00880DCA: dc.w $4A38
        dc.w    $EF06                    ; 00880DCC: dc.w $EF06
        dc.w    $6602                    ; 00880DCE: BNE.S $00880DD2
        dc.w    $4E75                    ; 00880DD0: RTS
        dc.w    $7004                    ; 00880DD2: MOVEQ #$04,D0
        dc.w    $4EB9, $0088, $14BE    ; 00880DD4: JSR $008814BE
        dc.w    $720A                    ; 00880DDA: MOVEQ #$0A,D1
        dc.w    $4EB9, $0088, $155E    ; 00880DDC: JSR $0088155E
        dc.w    $33FC                    ; 00880DE2: dc.w $33FC
        dc.w    $0100                    ; 00880DE4: dc.w $0100
        dc.w    $00A1                    ; 00880DE6: dc.w $00A1
        dc.w    $1100                    ; 00880DE8: dc.w $1100
        dc.w    $0839                    ; 00880DEA: dc.w $0839
        dc.w    $0000                    ; 00880DEC: dc.w $0000
        dc.w    $00A1                    ; 00880DEE: dc.w $00A1
        dc.w    $1100                    ; 00880DF0: dc.w $1100
        dc.w    $66F6                    ; 00880DF2: BNE.S $00880DEA
        dc.w    $3ABC                    ; 00880DF4: dc.w $3ABC
        dc.w    $8C00                    ; 00880DF6: dc.w $8C00
        dc.w    $3ABC                    ; 00880DF8: dc.w $3ABC
        dc.w    $9010                    ; 00880DFA: dc.w $9010
        dc.w    $3838                    ; 00880DFC: dc.w $3838
        dc.w    $C874                    ; 00880DFE: dc.w $C874
        dc.w    $08C4                    ; 00880E00: dc.w $08C4
        dc.w    $0004                    ; 00880E02: dc.w $0004
        dc.w    $3A84                    ; 00880E04: dc.w $3A84
        dc.w    $2ABC                    ; 00880E06: dc.w $2ABC
        dc.w    $9380                    ; 00880E08: dc.w $9380
        dc.w    $9403                    ; 00880E0A: dc.w $9403
        dc.w    $2ABC                    ; 00880E0C: dc.w $2ABC
        dc.w    $9500                    ; 00880E0E: dc.w $9500
        dc.w    $9688                    ; 00880E10: dc.w $9688
        dc.w    $3ABC                    ; 00880E12: dc.w $3ABC
        dc.w    $977F                    ; 00880E14: dc.w $977F
        dc.w    $3ABC                    ; 00880E16: dc.w $3ABC
        dc.w    $4000                    ; 00880E18: dc.w $4000
        dc.w    $31FC                    ; 00880E1A: dc.w $31FC
        dc.w    $0083                    ; 00880E1C: dc.w $0083
        dc.w    $C876                    ; 00880E1E: dc.w $C876
        dc.w    $3AB8                    ; 00880E20: dc.w $3AB8
        dc.w    $C876                    ; 00880E22: dc.w $C876
        dc.w    $3AB8                    ; 00880E24: dc.w $3AB8
        dc.w    $C874                    ; 00880E26: dc.w $C874
        dc.w    $3838                    ; 00880E28: dc.w $3838
        dc.w    $C874                    ; 00880E2A: dc.w $C874
        dc.w    $08C4                    ; 00880E2C: dc.w $08C4
        dc.w    $0004                    ; 00880E2E: dc.w $0004
        dc.w    $3A84                    ; 00880E30: dc.w $3A84
        dc.w    $2ABC                    ; 00880E32: dc.w $2ABC
        dc.w    $9340                    ; 00880E34: dc.w $9340
        dc.w    $9400                    ; 00880E36: dc.w $9400
        dc.w    $2ABC                    ; 00880E38: dc.w $2ABC
        dc.w    $9540                    ; 00880E3A: dc.w $9540
        dc.w    $96C2                    ; 00880E3C: dc.w $96C2
        dc.w    $3ABC                    ; 00880E3E: dc.w $3ABC
        dc.w    $977F                    ; 00880E40: dc.w $977F
        dc.w    $3ABC                    ; 00880E42: dc.w $3ABC
        dc.w    $C000                    ; 00880E44: dc.w $C000
        dc.w    $31FC                    ; 00880E46: dc.w $31FC
        dc.w    $0080                    ; 00880E48: dc.w $0080
        dc.w    $C876                    ; 00880E4A: dc.w $C876
        dc.w    $3AB8                    ; 00880E4C: dc.w $3AB8
        dc.w    $C876                    ; 00880E4E: dc.w $C876
        dc.w    $3AB8                    ; 00880E50: dc.w $3AB8
        dc.w    $C874                    ; 00880E52: dc.w $C874
        dc.w    $08B8                    ; 00880E54: dc.w $08B8
        dc.w    $0006                    ; 00880E56: dc.w $0006
        dc.w    $C80E                    ; 00880E58: dc.w $C80E
        dc.w    $21FC                    ; 00880E5A: dc.w $21FC
        dc.w    $008B                    ; 00880E5C: dc.w $008B
        dc.w    $B4DC                    ; 00880E5E: dc.w $B4DC
        dc.w    $C96C                    ; 00880E60: dc.w $C96C
        dc.w    $11FC                    ; 00880E62: dc.w $11FC
        dc.w    $0001                    ; 00880E64: dc.w $0001
        dc.w    $C809                    ; 00880E66: dc.w $C809
        dc.w    $11FC                    ; 00880E68: dc.w $11FC
        dc.w    $0001                    ; 00880E6A: dc.w $0001
        dc.w    $C80A                    ; 00880E6C: dc.w $C80A
        dc.w    $08F8                    ; 00880E6E: dc.w $08F8
        dc.w    $0006                    ; 00880E70: dc.w $0006
        dc.w    $C80E                    ; 00880E72: dc.w $C80E
        dc.w    $11FC                    ; 00880E74: dc.w $11FC
        dc.w    $0001                    ; 00880E76: dc.w $0001
        dc.w    $C802                    ; 00880E78: dc.w $C802
        dc.w    $08F8                    ; 00880E7A: dc.w $08F8
        dc.w    $0006                    ; 00880E7C: dc.w $0006
        dc.w    $C875                    ; 00880E7E: dc.w $C875
        dc.w    $3AB8                    ; 00880E80: dc.w $3AB8
        dc.w    $C874                    ; 00880E82: dc.w $C874
        dc.w    $4EB9, $0088, $B684    ; 00880E84: JSR $0088B684
        dc.w    $4EB9, $0088, $4998    ; 00880E8A: JSR $00884998
        dc.w    $0838                    ; 00880E90: dc.w $0838
        dc.w    $0006                    ; 00880E92: dc.w $0006
        dc.w    $C80E                    ; 00880E94: dc.w $C80E
        dc.w    $66EC                    ; 00880E96: BNE.S $00880E84
        dc.w    $4E71                    ; 00880E98: NOP
        dc.w    $4E71                    ; 00880E9A: NOP
        dc.w    $4E71                    ; 00880E9C: NOP
        dc.w    $80FC                    ; 00880E9E: dc.w $80FC
        dc.w    $0000                    ; 00880EA0: dc.w $0000
        dc.w    $4E71                    ; 00880EA2: NOP
        dc.w    $4E71                    ; 00880EA4: NOP
        dc.w    $4E71                    ; 00880EA6: NOP
        dc.w    $40E7                    ; 00880EA8: dc.w $40E7
        dc.w    $46FC, $2700            ; 00880EAA: MOVE.W #$2700,SR
        dc.w    $33FC                    ; 00880EAE: dc.w $33FC
        dc.w    $0100                    ; 00880EB0: dc.w $0100
        dc.w    $00A1                    ; 00880EB2: dc.w $00A1
        dc.w    $1100                    ; 00880EB4: dc.w $1100
        dc.w    $33FC                    ; 00880EB6: dc.w $33FC
        dc.w    $0100                    ; 00880EB8: dc.w $0100
        dc.w    $00A1                    ; 00880EBA: dc.w $00A1
        dc.w    $1200                    ; 00880EBC: dc.w $1200
        dc.w    $0839                    ; 00880EBE: dc.w $0839
        dc.w    $0000                    ; 00880EC0: dc.w $0000
        dc.w    $00A1                    ; 00880EC2: dc.w $00A1
        dc.w    $1100                    ; 00880EC4: dc.w $1100
        dc.w    $66F6                    ; 00880EC6: BNE.S $00880EBE
        dc.w    $43F9, $00A0, $0000    ; 00880EC8: LEA $00A00000,A1
        dc.w    $12FC                    ; 00880ECE: dc.w $12FC
        dc.w    $00F3                    ; 00880ED0: dc.w $00F3
        dc.w    $12FC                    ; 00880ED2: dc.w $12FC
        dc.w    $00F3                    ; 00880ED4: dc.w $00F3
        dc.w    $12FC                    ; 00880ED6: dc.w $12FC
        dc.w    $00C3                    ; 00880ED8: dc.w $00C3
        dc.w    $12FC                    ; 00880EDA: dc.w $12FC
        dc.w    $0000                    ; 00880EDC: dc.w $0000
        dc.w    $12FC                    ; 00880EDE: dc.w $12FC
        dc.w    $0000                    ; 00880EE0: dc.w $0000
        dc.w    $33FC                    ; 00880EE2: dc.w $33FC
        dc.w    $0000                    ; 00880EE4: dc.w $0000
        dc.w    $00A1                    ; 00880EE6: dc.w $00A1
        dc.w    $1200                    ; 00880EE8: dc.w $1200
        dc.w    $4E71                    ; 00880EEA: NOP
        dc.w    $4E71                    ; 00880EEC: NOP
        dc.w    $4E71                    ; 00880EEE: NOP
        dc.w    $4E71                    ; 00880EF0: NOP
        dc.w    $4E71                    ; 00880EF2: NOP
        dc.w    $4E71                    ; 00880EF4: NOP
        dc.w    $4E71                    ; 00880EF6: NOP
        dc.w    $4E71                    ; 00880EF8: NOP
        dc.w    $4E71                    ; 00880EFA: NOP
        dc.w    $4E71                    ; 00880EFC: NOP
        dc.w    $4E71                    ; 00880EFE: NOP
        dc.w    $4E71                    ; 00880F00: NOP
        dc.w    $4E71                    ; 00880F02: NOP
        dc.w    $4E71                    ; 00880F04: NOP
        dc.w    $33FC                    ; 00880F06: dc.w $33FC
        dc.w    $0000                    ; 00880F08: dc.w $0000
        dc.w    $00A1                    ; 00880F0A: dc.w $00A1
        dc.w    $1100                    ; 00880F0C: dc.w $1100
        dc.w    $33FC                    ; 00880F0E: dc.w $33FC
        dc.w    $0100                    ; 00880F10: dc.w $0100
        dc.w    $00A1                    ; 00880F12: dc.w $00A1
        dc.w    $1200                    ; 00880F14: dc.w $1200
        dc.w    $46DF                    ; 00880F16: dc.w $46DF
        dc.w    $70FF                    ; 00880F18: MOVEQ #$FF,D0
        dc.w    $13C0                    ; 00880F1A: dc.w $13C0
        dc.w    $00C0                    ; 00880F1C: dc.w $00C0
        dc.w    $0011                    ; 00880F1E: dc.w $0011
        dc.w    $4E71                    ; 00880F20: NOP
        dc.w    $4E71                    ; 00880F22: NOP
        dc.w    $0400                    ; 00880F24: dc.w $0400
        dc.w    $0020                    ; 00880F26: dc.w $0020
        dc.w    $13C0                    ; 00880F28: dc.w $13C0
        dc.w    $00C0                    ; 00880F2A: dc.w $00C0
        dc.w    $0011                    ; 00880F2C: dc.w $0011
        dc.w    $4E71                    ; 00880F2E: NOP
        dc.w    $4E71                    ; 00880F30: NOP
        dc.w    $0400                    ; 00880F32: dc.w $0400
        dc.w    $0020                    ; 00880F34: dc.w $0020
        dc.w    $13C0                    ; 00880F36: dc.w $13C0
        dc.w    $00C0                    ; 00880F38: dc.w $00C0
        dc.w    $0011                    ; 00880F3A: dc.w $0011
        dc.w    $4E71                    ; 00880F3C: NOP
        dc.w    $4E71                    ; 00880F3E: NOP
        dc.w    $0400                    ; 00880F40: dc.w $0400
        dc.w    $0020                    ; 00880F42: dc.w $0020
        dc.w    $13C0                    ; 00880F44: dc.w $13C0
        dc.w    $00C0                    ; 00880F46: dc.w $00C0
        dc.w    $0011                    ; 00880F48: dc.w $0011
        dc.w    $33FC                    ; 00880F4A: dc.w $33FC
        dc.w    $0100                    ; 00880F4C: dc.w $0100
        dc.w    $00A1                    ; 00880F4E: dc.w $00A1
        dc.w    $1100                    ; 00880F50: dc.w $1100
        dc.w    $0839                    ; 00880F52: dc.w $0839
        dc.w    $0000                    ; 00880F54: dc.w $0000
        dc.w    $00A1                    ; 00880F56: dc.w $00A1
        dc.w    $1100                    ; 00880F58: dc.w $1100
        dc.w    $66F6                    ; 00880F5A: BNE.S $00880F52
        dc.w    $2F01                    ; 00880F5C: dc.w $2F01
        dc.w    $4EBA                    ; 00880F5E: dc.w $4EBA
        dc.w    $008A                    ; 00880F60: dc.w $008A
        dc.w    $221F                    ; 00880F62: dc.w $221F
        dc.w    $2ABC                    ; 00880F64: dc.w $2ABC
        dc.w    $C000                    ; 00880F66: dc.w $C000
        dc.w    $0000                    ; 00880F68: dc.w $0000
        dc.w    $7E3F                    ; 00880F6A: MOVEQ #$3F,D7
        dc.w    $7C0E                    ; 00880F6C: MOVEQ #$0E,D6
        dc.w    $33C6                    ; 00880F6E: dc.w $33C6
        dc.w    $00C0                    ; 00880F70: dc.w $00C0
        dc.w    $0000                    ; 00880F72: dc.w $0000
        dc.w    $51CF, $FFF8            ; 00880F74: DBRA D7,$00880F6E
        dc.w    $08F8                    ; 00880F78: dc.w $08F8
        dc.w    $0006                    ; 00880F7A: dc.w $0006
        dc.w    $C875                    ; 00880F7C: dc.w $C875
        dc.w    $3AB8                    ; 00880F7E: dc.w $3AB8
        dc.w    $C874                    ; 00880F80: dc.w $C874
        dc.w    $4E71                    ; 00880F82: NOP
        dc.w    $4E71                    ; 00880F84: NOP
        dc.w    $4E71                    ; 00880F86: NOP
        dc.w    $80FC                    ; 00880F88: dc.w $80FC
        dc.w    $0000                    ; 00880F8A: dc.w $0000
        dc.w    $4E71                    ; 00880F8C: NOP
        dc.w    $4E71                    ; 00880F8E: NOP
        dc.w    $4E71                    ; 00880F90: NOP
        dc.w    $4EB9, $0089, $4262    ; 00880F92: JSR $00894262
        dc.w    $31FC                    ; 00880F98: dc.w $31FC
        dc.w    $0004                    ; 00880F9A: dc.w $0004
        dc.w    $C87A                    ; 00880F9C: dc.w $C87A
        dc.w    $46FC, $2300            ; 00880F9E: MOVE.W #$2300,SR
        dc.w    $4A78                    ; 00880FA2: dc.w $4A78
        dc.w    $C87A                    ; 00880FA4: dc.w $C87A
        dc.w    $66FA                    ; 00880FA6: BNE.S $00880FA2
        dc.w    $60E8                    ; 00880FA8: BRA.S $00880F92
        dc.w    $4EB9, $0088, $4CBC    ; 00880FAA: JSR $00884CBC
        dc.w    $08F8                    ; 00880FB0: dc.w $08F8
        dc.w    $0000                    ; 00880FB2: dc.w $0000
        dc.w    $C805                    ; 00880FB4: dc.w $C805
        dc.w    $4A38                    ; 00880FB6: dc.w $4A38
        dc.w    $C805                    ; 00880FB8: dc.w $C805
        dc.w    $66FA                    ; 00880FBA: BNE.S $00880FB6
        dc.w    $60EC                    ; 00880FBC: BRA.S $00880FAA

; --- Copy to Work RAM + Z80 bus ---
CopyInitCode:
        dc.w    $7E0B                    ; 00880FBE: MOVEQ #$0B,D7
        dc.w    $41FA                    ; 00880FC0: dc.w $41FA
        dc.w    $FFD0                    ; 00880FC2: dc.w $FFD0
        dc.w    $43F9, $00FF, $0000    ; 00880FC4: LEA $00FF0000,A1
        dc.w    $4EFA                    ; 00880FCA: dc.w $4EFA
        dc.w    $000E                    ; 00880FCC: dc.w $000E
        dc.w    $7E09                    ; 00880FCE: MOVEQ #$09,D7
        dc.w    $41FA                    ; 00880FD0: dc.w $41FA
        dc.w    $FFD8                    ; 00880FD2: dc.w $FFD8
        dc.w    $43F9, $00FF, $0000    ; 00880FD4: LEA $00FF0000,A1
        dc.w    $46FC, $2700            ; 00880FDA: MOVE.W #$2700,SR
        dc.w    $32D8                    ; 00880FDE: dc.w $32D8
        dc.w    $51CF, $FFFC            ; 00880FE0: DBRA D7,$00880FDE
        dc.w    $46FC, $2300            ; 00880FE4: MOVE.W #$2300,SR
        dc.w    $4E75                    ; 00880FE8: RTS
        dc.w    $40E7                    ; 00880FEA: dc.w $40E7
        dc.w    $46FC, $2700            ; 00880FEC: MOVE.W #$2700,SR
        dc.w    $33FC                    ; 00880FF0: dc.w $33FC
        dc.w    $0100                    ; 00880FF2: dc.w $0100
        dc.w    $00A1                    ; 00880FF4: dc.w $00A1
        dc.w    $1100                    ; 00880FF6: dc.w $1100
        dc.w    $0839                    ; 00880FF8: dc.w $0839
        dc.w    $0000                    ; 00880FFA: dc.w $0000
        dc.w    $00A1                    ; 00880FFC: dc.w $00A1
        dc.w    $1100                    ; 00880FFE: dc.w $1100

