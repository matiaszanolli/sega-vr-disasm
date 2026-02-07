; ============================================================================
; Obj Sprite Table Init 014 (auto-analyzed)
; ROM Range: $006C88-$006CDC (84 bytes)
; ============================================================================
; Category: object
; Purpose: Calls: sprite_table_init
;
; Uses: D0, D1
; Calls:
;   $006C46: sprite_table_init
; Confidence: medium
; ============================================================================

fn_6200_014:
        TST.W  $00FF3000                        ; $006C88
        BNE.S  .loc_000C                        ; $006C8E
        DC.W    $4EBA,$FFB4         ; JSR     $006C46(PC); $006C90
.loc_000C:
        MOVE.B  (-14226).W,D1                   ; $006C94
        MOVEQ   #$30,D0                         ; $006C98
        BTST    #6,D1                           ; $006C9A
        BNE.S  .loc_001A                        ; $006C9E
        MOVEQ   #$08,D0                         ; $006CA0
.loc_001A:
        BTST    #2,D1                           ; $006CA2
        DC.W    $6600,$0090         ; BNE.W  $006D38; $006CA6
        BTST    #3,D1                           ; $006CAA
        DC.W    $6600,$008E         ; BNE.W  $006D3E; $006CAE
        BTST    #1,D1                           ; $006CB2
        DC.W    $6600,$008C         ; BNE.W  $006D44; $006CB6
        BTST    #0,D1                           ; $006CBA
        DC.W    $6600,$008A         ; BNE.W  $006D4A; $006CBE
        BTST    #4,D1                           ; $006CC2
        DC.W    $6600,$0088         ; BNE.W  $006D50; $006CC6
        BTST    #5,D1                           ; $006CCA
        DC.W    $6600,$009E         ; BNE.W  $006D6E; $006CCE
        BTST    #7,D1                           ; $006CD2
        DC.W    $6600,$00B4         ; BNE.W  $006D8C; $006CD6
        RTS                                     ; $006CDA
