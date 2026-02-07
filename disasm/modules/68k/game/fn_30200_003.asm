; ============================================================================
; Fm Sequence Process 003 (auto-analyzed)
; ROM Range: $03029E-$0302EE (80 bytes)
; ============================================================================
; Category: sound
; Purpose: Orchestrator calling 3 subroutines
;   Calls: fm_sequence_process, z80_bus_request, fm_write_conditional
;   Object (A5, A6): +$01, +$0A (param_a), +$0F
;
; Entry: A5 = object/entity pointer
; Entry: A6 = object/entity pointer
; Uses: D0, D1, D6, A0, A4, A5, A6
; Calls:
;   $0302EE: fm_sequence_process
;   $030CCC: fm_write_conditional
;   $030D1C: z80_bus_request
; Object fields:
;   +$01: [unknown]
;   +$0A: param_a
;   +$0F: [unknown]
; Confidence: high
; ============================================================================

fn_30200_003:
        TST.B  $000A(A5)                        ; $03029E
        BEQ.W  .loc_004E                        ; $0302A2
        BTST    #1,(A5)                         ; $0302A6
        BNE.W  .loc_004E                        ; $0302AA
        BTST    #2,(A5)                         ; $0302AE
        BNE.W  .loc_004E                        ; $0302B2
        DC.W    $4EBA,$0036         ; JSR     $0302EE(PC); $0302B6
        TST.B  $000F(A6)                        ; $0302BA
        BEQ.S  .loc_002C                        ; $0302BE
        CMPI.B  #$02,$0001(A5)                  ; $0302C0
        DC.W    $6700,$00C6         ; BEQ.W  $03038E; $0302C6
.loc_002C:
        MOVE.W  D6,D1                           ; $0302CA
        LSR.W  #8,D1                            ; $0302CC
        MOVE.B  #$A4,D0                         ; $0302CE
        DC.W    $4EBA,$0A48         ; JSR     $030D1C(PC); $0302D2
        DC.W    $4EBA,$09F4         ; JSR     $030CCC(PC); $0302D6
        MOVE.B  D6,D1                           ; $0302DA
        MOVE.B  #$A0,D0                         ; $0302DC
        DC.W    $4EBA,$09EA         ; JSR     $030CCC(PC); $0302E0
        MOVE.W  #$0000,$00A11100                ; $0302E4
.loc_004E:
        RTS                                     ; $0302EC
