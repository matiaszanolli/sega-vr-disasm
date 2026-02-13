; ============================================================================
; FM Key-Off + Volume Zero — key-off all channels and zero volumes
; ROM Range: $030B50-$030B90 (64 bytes)
; ============================================================================
; Requests Z80 bus, writes key-off (register $28) for all 6 FM channels
; (0-2 and 4-6). Then writes Total Level = $7F (silence) to all TL
; registers ($40-$53) using fm_write_port0 with $030CFE helper for
; register auto-increment. 3 groups of 4 operators each. Releases bus.
;
; Uses: D0, D1, D2, D3
; Calls:
;   $030CD8: fm_write_port0
;   $030D1C: z80_bus_request
; Confidence: high
; ============================================================================

fn_30200_022:
        MOVEQ   #$02,D2                         ; $030B50
        MOVEQ   #$28,D0                         ; $030B52
        DC.W    $4EBA,$01C6         ; JSR     $030D1C(PC); $030B54
.loc_0008:
        MOVE.B  D2,D1                           ; $030B58
        DC.W    $4EBA,$017C         ; JSR     $030CD8(PC); $030B5A
        ADDQ.B  #4,D1                           ; $030B5E
        DC.W    $4EBA,$0176         ; JSR     $030CD8(PC); $030B60
        DBRA    D2,.loc_0008                    ; $030B64
        MOVEQ   #$40,D0                         ; $030B68
        MOVEQ   #$7F,D1                         ; $030B6A
        MOVEQ   #$02,D3                         ; $030B6C
.loc_001E:
        MOVEQ   #$03,D2                         ; $030B6E
.loc_0020:
        DC.W    $4EBA,$0166         ; JSR     $030CD8(PC); $030B70
        DC.W    $4EBA,$0188         ; JSR     $030CFE(PC); $030B74
        ADDQ.W  #4,D0                           ; $030B78
        DBRA    D2,.loc_0020                    ; $030B7A
        SUBI.B  #$0F,D0                         ; $030B7E
        DBRA    D3,.loc_001E                    ; $030B82
        MOVE.W  #$0000,Z80_BUSREQ                ; $030B86
        RTS                                     ; $030B8E
