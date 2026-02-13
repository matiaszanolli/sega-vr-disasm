; ============================================================================
; FM Init Channel — key-on with flag checks (fm_init_channel)
; ROM Range: $030C8A-$030CA2 (24 bytes)
; ============================================================================
; Two entry points:
;   $030C8A: Checks bit 4 (sustain) and bit 2 (key-off). If either set,
;     returns without action.
;   $030C96: Checks only bit 2 (key-off). If set, returns.
; If checks pass: writes key-on register $28 with channel number from
; A5+$01. Falls through to fm_write_wrapper ($030CBA).
;
; Entry: A5 = FM channel structure pointer (+$01=channel number)
; Uses: D0, D1, A5
; Confidence: high
; ============================================================================

fn_30200_025:
        BTST    #4,(A5)                         ; $030C8A
        BNE.S  .loc_0016                        ; $030C8E
        BTST    #2,(A5)                         ; $030C90
        BNE.S  .loc_0016                        ; $030C94
        MOVEQ   #$28,D0                         ; $030C96
        MOVE.B  $0001(A5),D1                    ; $030C98
        DC.W    $6000,$001C         ; BRA.W  $030CBA; $030C9C
.loc_0016:
        RTS                                     ; $030CA0
