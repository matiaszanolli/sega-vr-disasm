; ============================================================================
; FM Total Level Reset — set all operator volumes to maximum attenuation
; ROM Range: $030B1C-$030B50 (52 bytes)
; ============================================================================
; Requests Z80 bus, then writes all FM Total Level registers ($40-$53)
; with $7F (maximum attenuation = silence) via fm_write_conditional.
; Then writes all Sustain/Release registers ($80-$93) with $0F (fastest
; release rate). Covers 4 operators across all FM channels. Releases bus.
;
; Uses: D0, D1, D3, D4
; Calls:
;   $030CCC: fm_write_conditional
;   $030D1C: z80_bus_request
; Confidence: high
; ============================================================================

fm_total_level_reset:
        jsr     z80_bus_wait(pc)        ; $4EBA $01FE
        MOVEQ   #$03,D4                         ; $030B20
        MOVEQ   #$40,D3                         ; $030B22
        MOVEQ   #$7F,D1                         ; $030B24
.loc_000A:
        MOVE.B  D3,D0                           ; $030B26
        jsr     fm_write_cond(pc)       ; $4EBA $01A2
        ADDQ.B  #4,D3                           ; $030B2C
        DBRA    D4,.loc_000A                    ; $030B2E
        MOVEQ   #$03,D4                         ; $030B32
        MOVE.B  #$80,D3                         ; $030B34
        MOVEQ   #$0F,D1                         ; $030B38
.loc_001E:
        MOVE.B  D3,D0                           ; $030B3A
        jsr     fm_write_cond(pc)       ; $4EBA $018E
        ADDQ.B  #4,D3                           ; $030B40
        DBRA    D4,.loc_001E                    ; $030B42
        MOVE.W  #$0000,Z80_BUSREQ                ; $030B46
        RTS                                     ; $030B4E
