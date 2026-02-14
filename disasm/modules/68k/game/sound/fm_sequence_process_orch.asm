; ============================================================================
; FM Sequence Process Orchestrator — check channel and write frequency
; ROM Range: $03029E-$0302EE (80 bytes)
; ============================================================================
; Checks FM channel status (A5+$0A active, bit 1 not muted, bit 2 not
; key-off). If active, calls fm_sequence_process to read next frequency
; value into D6. Special handling for channel type $02 (A5+$01) when
; A6+$0F is set — branches to panning write at $03038E. Otherwise
; requests Z80 bus, writes frequency high byte to register $A4 and low
; byte to register $A0 via fm_write_conditional.
;
; Entry: A5 = FM channel structure pointer
; Entry: A6 = sound driver state pointer
; Uses: D0, D1, D6, A0, A4, A5, A6
; Calls:
;   $0302EE: fm_sequence_process
;   $030CCC: fm_write_conditional
;   $030D1C: z80_bus_request
; Confidence: high
; ============================================================================

fm_sequence_process_orch:
        TST.B  $000A(A5)                        ; $03029E
        BEQ.W  .loc_004E                        ; $0302A2
        BTST    #1,(A5)                         ; $0302A6
        BNE.W  .loc_004E                        ; $0302AA
        BTST    #2,(A5)                         ; $0302AE
        BNE.W  .loc_004E                        ; $0302B2
        jsr     fm_sequence_data_reader(pc); $4EBA $0036
        TST.B  $000F(A6)                        ; $0302BA
        BEQ.S  .loc_002C                        ; $0302BE
        CMPI.B  #$02,$0001(A5)                  ; $0302C0
        DC.W    $6700,$00C6         ; BEQ.W  $03038E; $0302C6
.loc_002C:
        MOVE.W  D6,D1                           ; $0302CA
        LSR.W  #8,D1                            ; $0302CC
        MOVE.B  #$A4,D0                         ; $0302CE
        jsr     z80_bus_wait(pc)        ; $4EBA $0A48
        jsr     fm_write_cond(pc)       ; $4EBA $09F4
        MOVE.B  D6,D1                           ; $0302DA
        MOVE.B  #$A0,D0                         ; $0302DC
        jsr     fm_write_cond(pc)       ; $4EBA $09EA
        MOVE.W  #$0000,Z80_BUSREQ                ; $0302E4
.loc_004E:
        RTS                                     ; $0302EC
