; ============================================================================
; Fm Write Conditional 021 (auto-analyzed)
; ROM Range: $030B1C-$030B50 (52 bytes)
; ============================================================================
; Category: sound
; Purpose: Calls: z80_bus_request, fm_write_conditional
;
; Uses: D0, D1, D3, D4
; Calls:
;   $030CCC: fm_write_conditional
;   $030D1C: z80_bus_request
; Confidence: high
; ============================================================================

fn_30200_021:
        DC.W    $4EBA,$01FE         ; JSR     $030D1C(PC); $030B1C
        MOVEQ   #$03,D4                         ; $030B20
        MOVEQ   #$40,D3                         ; $030B22
        MOVEQ   #$7F,D1                         ; $030B24
.loc_000A:
        MOVE.B  D3,D0                           ; $030B26
        DC.W    $4EBA,$01A2         ; JSR     $030CCC(PC); $030B28
        ADDQ.B  #4,D3                           ; $030B2C
        DBRA    D4,.loc_000A                    ; $030B2E
        MOVEQ   #$03,D4                         ; $030B32
        MOVE.B  #$80,D3                         ; $030B34
        MOVEQ   #$0F,D1                         ; $030B38
.loc_001E:
        MOVE.B  D3,D0                           ; $030B3A
        DC.W    $4EBA,$018E         ; JSR     $030CCC(PC); $030B3C
        ADDQ.B  #4,D3                           ; $030B40
        DBRA    D4,.loc_001E                    ; $030B42
        MOVE.W  #$0000,$00A11100                ; $030B46
        RTS                                     ; $030B4E
