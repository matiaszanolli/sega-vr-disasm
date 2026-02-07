; ============================================================================
; Obj Table Lookup 037 (auto-analyzed)
; ROM Range: $0058EA-$005908 (30 bytes)
; ============================================================================
; Category: object
; Purpose: Short helper function
;   RAM: $9100 (obj_table_1)
;   Calls: table_lookup
;
; Uses: D0, D7, A0
; RAM:
;   $9100: obj_table_1
; Calls:
;   $0059EC: table_lookup
; Confidence: medium
; ============================================================================

fn_4200_037:
        ANDI.W  #$0130,D0                       ; $0058EA
        DC.W    $66F8               ; BNE.S  $0058E8; $0058EE
        MOVE.B  #$00,$00FF5FFE                  ; $0058F0
        LEA     (-28416).W,A0                   ; $0058F8
        MOVEQ   #$05,D7                         ; $0058FC
.loc_0014:
        DC.W    $4EBA,$00EC         ; JSR     $0059EC(PC); $0058FE
        DBRA    D7,.loc_0014                    ; $005902
        RTS                                     ; $005906
