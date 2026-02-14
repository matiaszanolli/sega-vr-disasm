; ============================================================================
; tile_decompression_disp_a — Tile Decompression Dispatcher A
; ROM Range: $0014BE-$0014E0 (34 bytes)
; ============================================================================
; Dispatches up to 4 tile decompression jobs packed in D0 (one byte per job).
; Iterates 4 times (D2=3), extracting each byte via ROR.L #8. For each
; non-zero byte: multiplies by 8 as index into parameter table at $0014E0,
; loads VDP command word to (A5) and source pointer to A0, then calls
; tile decompressor setup at $0010F4.
;
; Entry: D0 = 4 packed job IDs (one per byte), A5 = VDP_CTRL
; Uses: D0, D1, D2, A0, A5
; Calls:
;   $0010F4: tile_decompressor_setup (JSR PC-relative)
; ============================================================================

tile_decompression_disp_a:
        MOVEQ   #$03,D2                         ; $0014BE
.loc_0002:
        MOVEQ   #$00,D1                         ; $0014C0
        MOVE.B  D0,D1                           ; $0014C2
        BEQ.S  .loc_001A                        ; $0014C4
        LSL.W  #3,D1                            ; $0014C6
        lea     tile_decompression_disp_b(pc),a0; $41FA $0016
        MOVE.L  -$08(A0,D1.W),(A5)              ; $0014CC
        MOVEA.L -$04(A0,D1.W),A0                ; $0014D0
        jsr     tile_decompressor_setup(pc); $4EBA $FC1E
.loc_001A:
        ROR.L  #8,D0                            ; $0014D8
        DBRA    D2,.loc_0002                    ; $0014DA
        RTS                                     ; $0014DE
