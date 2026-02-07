; ============================================================================
; Tile Decompress Init 022 (auto-analyzed)
; ROM Range: $0014BE-$0014E0 (34 bytes)
; ============================================================================
; Category: boot
; Purpose: Short helper function
;   Calls: tile_decompress_init
;   Object (A0): +$04 (speed_index/velocity), +$08
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, D2, A0, A5
; Calls:
;   $0010F4: tile_decompress_init
; Object fields:
;   +$04: speed_index/velocity
;   +$08: [unknown]
; Confidence: low
; ============================================================================

fn_200_022:
        MOVEQ   #$03,D2                         ; $0014BE
.loc_0002:
        MOVEQ   #$00,D1                         ; $0014C0
        MOVE.B  D0,D1                           ; $0014C2
        BEQ.S  .loc_001A                        ; $0014C4
        LSL.W  #3,D1                            ; $0014C6
        DC.W    $41FA,$0016         ; LEA     $0014E0(PC),A0; $0014C8
        MOVE.L  -$08(A0,D1.W),(A5)              ; $0014CC
        MOVEA.L -$04(A0,D1.W),A0                ; $0014D0
        DC.W    $4EBA,$FC1E         ; JSR     $0010F4(PC); $0014D4
.loc_001A:
        ROR.L  #8,D0                            ; $0014D8
        DBRA    D2,.loc_0002                    ; $0014DA
        RTS                                     ; $0014DE
