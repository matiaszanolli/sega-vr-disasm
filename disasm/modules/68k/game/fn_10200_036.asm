; ============================================================================
; Sh2 Comm Send Cmd 036 (auto-analyzed)
; ROM Range: $011B08-$011B6A (98 bytes)
; ============================================================================
; Category: sh2
; Purpose: Calls: sh2_send_cmd
;
; Uses: D0, D1, A0, A1
; Calls:
;   $00E35A: sh2_send_cmd
; Confidence: medium
; ============================================================================

fn_10200_036:
        MOVEA.L #$06018000,A0                   ; $011B08
        MOVEA.L #$04004C78,A1                   ; $011B0E
        MOVE.W  #$0050,D0                       ; $011B14
        MOVE.W  #$0010,D1                       ; $011B18
        DC.W    $4EBA,$C83C         ; JSR     $00E35A(PC); $011B1C
        MOVEA.L #$0601E8C0,A0                   ; $011B20
        MOVEA.L #$04008090,A1                   ; $011B26
        MOVE.W  #$0058,D0                       ; $011B2C
        MOVE.W  #$0010,D1                       ; $011B30
        DC.W    $4EBA,$C824         ; JSR     $00E35A(PC); $011B34
        MOVEA.L #$0601EE40,A0                   ; $011B38
        MOVEA.L #$0400A090,A1                   ; $011B3E
        MOVE.W  #$0058,D0                       ; $011B44
        MOVE.W  #$0010,D1                       ; $011B48
        DC.W    $4EBA,$C80C         ; JSR     $00E35A(PC); $011B4C
        MOVEA.L #$06018500,A0                   ; $011B50
        MOVEA.L #$04008048,A1                   ; $011B56
        MOVE.W  #$0038,D0                       ; $011B5C
        MOVE.W  #$0020,D1                       ; $011B60
        DC.W    $4EBA,$C7F4         ; JSR     $00E35A(PC); $011B64
        RTS                                     ; $011B68
