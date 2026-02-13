; ============================================================================
; name_entry_background_tile_transfer — Name Entry Background Tile Transfer
; ROM Range: $01071C-$010796 (122 bytes)
; ============================================================================
; Transfers 5 tile data blocks to SH2 framebuffer for the name entry screen
; background and UI elements. Each block is a sh2_send_cmd call with specific
; source (ROM/RAM) and destination (SH2 framebuffer) addresses:
;   1. $24014034 → $06014000 (216×80 — main background)
;   2. $240080A0 → $06019700 (88×16 — UI element)
;   3. $2400A0A0 → $06019C80 (88×16 — UI element)
;   4. $24008060 → $06019000 (56×32 — UI element)
;   5. $24004C60 → $0601A200 (128×16 — UI element)
;
; Uses: D0, D1, A0, A1
; Calls:
;   $00E35A: sh2_send_cmd
; ============================================================================

name_entry_background_tile_transfer:
        MOVEA.L #$06014000,A0                   ; $01071C
        MOVEA.L #$24014034,A1                   ; $010722
        MOVE.W  #$00D8,D0                       ; $010728
        MOVE.W  #$0050,D1                       ; $01072C
        DC.W    $4EBA,$DC28         ; JSR     $00E35A(PC); $010730
        MOVEA.L #$06019700,A0                   ; $010734
        MOVEA.L #$240080A0,A1                   ; $01073A
        MOVE.W  #$0058,D0                       ; $010740
        MOVE.W  #$0010,D1                       ; $010744
        DC.W    $4EBA,$DC10         ; JSR     $00E35A(PC); $010748
        MOVEA.L #$06019C80,A0                   ; $01074C
        MOVEA.L #$2400A0A0,A1                   ; $010752
        MOVE.W  #$0058,D0                       ; $010758
        MOVE.W  #$0010,D1                       ; $01075C
        DC.W    $4EBA,$DBF8         ; JSR     $00E35A(PC); $010760
        MOVEA.L #$06019000,A0                   ; $010764
        MOVEA.L #$24008060,A1                   ; $01076A
        MOVE.W  #$0038,D0                       ; $010770
        MOVE.W  #$0020,D1                       ; $010774
        DC.W    $4EBA,$DBE0         ; JSR     $00E35A(PC); $010778
        MOVEA.L #$0601A200,A0                   ; $01077C
        MOVEA.L #$24004C60,A1                   ; $010782
        MOVE.W  #$0080,D0                       ; $010788
        MOVE.W  #$0010,D1                       ; $01078C
        DC.W    $4EBA,$DBC8         ; JSR     $00E35A(PC); $010790
        RTS                                     ; $010794
