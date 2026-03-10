; ============================================================================
; FM Write Conditional — write port 0 with channel offset (fm_write_conditional)
; ROM Range: $030CCC-$030CF4 (40 bytes)
; ============================================================================
; Checks bit 2 in A5+$01 (channel flags). If set, skips write entirely.
; Otherwise adds channel offset (A5+$01) to register number D0, then
; writes register D0, data D1 to YM2612 port 0 at $A04000/$A04001.
; Busy-waits on bit 7 (busy flag) between register select and data write.
;
; Entry: A5 = FM channel structure pointer (+$01=channel/flags)
; Entry: D0 = FM register number, D1 = data value
; Uses: D0, D1, A0
; Confidence: high
; ============================================================================

fm_write_cond:
        BTST    #2,$0001(A5)                    ; $030CCC
        DC.W    $6620               ; BNE.S  $030CF4; $030CD2
        ADD.B  $0001(A5),D0                     ; $030CD4
        LEA     $00A04000,A0                    ; $030CD8
.wait_busy_reg:
        BTST    #7,(A0)                         ; $030CDE
        BNE.S  .wait_busy_reg                        ; $030CE2
        MOVE.B  D0,(A0)                         ; $030CE4
        NOP                                     ; $030CE6
.wait_busy_data:
        BTST    #7,(A0)                         ; $030CE8
        BNE.S  .wait_busy_data                        ; $030CEC
        MOVE.B  D1,$0001(A0)                    ; $030CEE
        RTS                                     ; $030CF2
