; ============================================================================
; fn_2200_016 — 32X VDP Mode Register Setup
; ROM Range: $002652-$002680 (46 bytes)
; ============================================================================
; Data prefix ($002652-$00266B): 32X VDP mode register initialization values
; (12 bytes: 6 words for bitmap mode, screen shift, auto-fill, etc.).
;
; Code at $00266C: Loads A1 = PC-relative pointer to data at $002680
; (immediately after this function), loads A2 = MARS_VDP_MODE ($A15180),
; copies 6 words from table to VDP mode registers.
;
; Uses: D0, D3, D7, A1, A2
; Hardware:
;   MARS_VDP_MODE ($A15180): 32X VDP control registers (6 words)
; ============================================================================

fn_2200_016:
        ORI.L  #$00000001,D3                    ; $002652
        ORI.B  #$00,D0                          ; $002658
        ORI.B  #$00,D0                          ; $00265C
        ORI.B  #$00,D0                          ; $002660
        ORI.B  #$00,D0                          ; $002664
        ORI.B  #$00,D0                          ; $002668
        DC.W    $43FA,$0012         ; LEA     $002680(PC),A1; $00266C
        LEA     MARS_VDP_MODE,A2                    ; $002670
        MOVEQ   #$05,D7                         ; $002676
.loc_0026:
        MOVE.W  (A1)+,(A2)+                     ; $002678
        DBRA    D7,.loc_0026                    ; $00267A
        RTS                                     ; $00267E
