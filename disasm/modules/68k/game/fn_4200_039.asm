; ============================================================================
; Obj Table Lookup 039 (auto-analyzed)
; ROM Range: $005926-$00593C (22 bytes)
; ============================================================================
; Category: object
; Purpose: Short helper function
;   RAM: $9700 (obj_table_2)
;   Calls: table_lookup
;
; Uses: D0, D7, A0
; RAM:
;   $9700: obj_table_2
; Calls:
;   $0059EC: table_lookup
; Confidence: medium
; ============================================================================

fn_4200_039:
        ANDI.W  #$0130,D0                       ; $005926
        DC.W    $66F8               ; BNE.S  $005924; $00592A
        LEA     (-26880).W,A0                   ; $00592C
        MOVEQ   #$07,D7                         ; $005930
.loc_000C:
        DC.W    $4EBA,$00B8         ; JSR     $0059EC(PC); $005932
        DBRA    D7,.loc_000C                    ; $005936
        RTS                                     ; $00593A
