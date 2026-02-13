; ============================================================================
; fn_12200_019 — Digit Tile DMA (Records Screen)
; ROM Range: $0125EC-$01260A (30 bytes)
; ============================================================================
; Same pattern as fn_10200_016 — computes SH2 framebuffer address for digit
; tile D1: offset = D1 × 192, added to base $0601F000. Sends 12×16 tile
; block via sh2_send_cmd.
;
; Entry: D1 = tile/digit index
; Exit: tile data sent to SH2 framebuffer
; Uses: D0, D1, A0
; Calls:
;   $00E35A: sh2_send_cmd
; ============================================================================

fn_12200_019:
        LSL.W  #6,D1                            ; $0125EC
        MOVE.W  D1,D0                           ; $0125EE
        LSL.W  #1,D1                            ; $0125F0
        ADD.W   D0,D1                           ; $0125F2
        MOVEA.L #$0601F000,A0                   ; $0125F4
        ADDA.W  D1,A0                           ; $0125FA
        MOVE.W  #$000C,D0                       ; $0125FC
        MOVE.W  #$0010,D1                       ; $012600
        DC.W    $4EBA,$BD54         ; JSR     $00E35A(PC); $012604
        RTS                                     ; $012608
