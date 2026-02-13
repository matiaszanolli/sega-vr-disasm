; ============================================================================
; fn_10200_032 — Digit Tile DMA to Framebuffer B
; ROM Range: $011924-$011942 (30 bytes)
; ============================================================================
; Identical logic to fn_10200_016 — computes SH2 framebuffer address for digit
; tile D1: offset = D1 × 192, added to base $0601DF00 (framebuffer region B
; for 2-player mode). Sends 12×16 tile block via sh2_send_cmd.
;
; Entry: D1 = tile/digit index
; Exit: tile data sent to SH2 framebuffer
; Uses: D0, D1, A0
; Calls:
;   $00E35A: sh2_send_cmd
; ============================================================================

fn_10200_032:
        LSL.W  #6,D1                            ; $011924
        MOVE.W  D1,D0                           ; $011926
        LSL.W  #1,D1                            ; $011928
        ADD.W   D0,D1                           ; $01192A
        MOVEA.L #$0601DF00,A0                   ; $01192C
        ADDA.W  D1,A0                           ; $011932
        MOVE.W  #$000C,D0                       ; $011934
        MOVE.W  #$0010,D1                       ; $011938
        DC.W    $4EBA,$CA1C         ; JSR     $00E35A(PC); $01193C
        RTS                                     ; $011940
