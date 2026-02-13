; ============================================================================
; FM Write Port 0/1 — channel-offset write + direct port 1 write
; ROM Range: $030CF4-$030D1C (40 bytes)
; ============================================================================
; Two entry points:
;   $030CF4 (fm_write_port0): Reads channel byte from A5+$01, clears
;     bit 2, adds offset to register D0 via D2. Falls through to port 1.
;   $030CFE (fm_write_port1): Writes register D0, data D1 to YM2612
;     port 1 at $A04002/$A04003. Busy-waits on bit 7 between writes.
;
; Entry: A5 = FM channel structure pointer (for port 0 entry)
; Entry: D0 = FM register number, D1 = data value
; Uses: D0, D1, D2, A0
; Confidence: high
; ============================================================================

fm_write_port_0_1:
        MOVE.B  $0001(A5),D2                    ; $030CF4
        BCLR    #2,D2                           ; $030CF8
        ADD.B   D2,D0                           ; $030CFC
        LEA     $00A04000,A0                    ; $030CFE
.loc_0010:
        BTST    #7,(A0)                         ; $030D04
        BNE.S  .loc_0010                        ; $030D08
        MOVE.B  D0,$0002(A0)                    ; $030D0A
        NOP                                     ; $030D0E
.loc_001C:
        BTST    #7,(A0)                         ; $030D10
        BNE.S  .loc_001C                        ; $030D14
        MOVE.B  D1,$0003(A0)                    ; $030D16
        RTS                                     ; $030D1A
