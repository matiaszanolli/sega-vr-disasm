; ============================================================================
; tile_bit_stream_unpacker — Tile Bit-Stream Unpacker
; ROM Range: $0012F4-$00136E (122 bytes)
; ============================================================================
; Unpacks a tile value from a compressed bit-stream. Builds tile index in D3
; by testing successive carry bits from ADD.B D1,D1 (shift left). For each
; set bit, reads a bit from the D5/D6 bit-stream to determine if the
; corresponding power-of-2 bit ($8000, $4000, $2000, $1000, $0800) is set
; in the output tile value.
;
; After 5 high bits, handles bit-stream boundary crossing: if remaining
; bits (D6) are less than needed (A5), refills from next bytes in (A0)+.
; Uses bitmask table at $001382 (tile_bit_stream_refill_with_mask_table) for variable-width extraction.
;
; Entry: D1 = bit-shift accumulator, D3 = base tile (from A3)
;        D4 = shift control, D5 = bit-stream word, D6 = bits remaining
; Exit: D1 = updated, D3 = unpacked tile value
; Uses: D0, D1, D3, D4, D5, D6, D7, A0
; ============================================================================

tile_bit_stream_unpacker:
        MOVE.W  A3,D3                           ; $0012F4
        MOVE.B  D4,D1                           ; $0012F6
        ADD.B   D1,D1                           ; $0012F8
        BCC.S  .loc_0012                        ; $0012FA
        SUBQ.W  #1,D6                           ; $0012FC
        BTST    D6,D5                           ; $0012FE
        BEQ.S  .loc_0012                        ; $001300
        ORI.W  #$8000,D3                        ; $001302
.loc_0012:
        ADD.B   D1,D1                           ; $001306
        BCC.S  .loc_0020                        ; $001308
        SUBQ.W  #1,D6                           ; $00130A
        BTST    D6,D5                           ; $00130C
        BEQ.S  .loc_0020                        ; $00130E
        ADDI.W  #$4000,D3                       ; $001310
.loc_0020:
        ADD.B   D1,D1                           ; $001314
        BCC.S  .loc_002E                        ; $001316
        SUBQ.W  #1,D6                           ; $001318
        BTST    D6,D5                           ; $00131A
        BEQ.S  .loc_002E                        ; $00131C
        ADDI.W  #$2000,D3                       ; $00131E
.loc_002E:
        ADD.B   D1,D1                           ; $001322
        BCC.S  .loc_003C                        ; $001324
        SUBQ.W  #1,D6                           ; $001326
        BTST    D6,D5                           ; $001328
        BEQ.S  .loc_003C                        ; $00132A
        ORI.W  #$1000,D3                        ; $00132C
.loc_003C:
        ADD.B   D1,D1                           ; $001330
        BCC.S  .loc_004A                        ; $001332
        SUBQ.W  #1,D6                           ; $001334
        BTST    D6,D5                           ; $001336
        BEQ.S  .loc_004A                        ; $001338
        ORI.W  #$0800,D3                        ; $00133A
.loc_004A:
        MOVE.W  D5,D1                           ; $00133E
        MOVE.W  D6,D7                           ; $001340
        SUB.W  A5,D7                            ; $001342
        DC.W    $6428               ; BCC.S  $00136E; $001344
        MOVE.W  D7,D6                           ; $001346
        ADDI.W  #$0010,D6                       ; $001348
        NEG.W  D7                               ; $00134C
        LSL.W  D7,D1                            ; $00134E
        MOVE.B  (A0),D5                         ; $001350
        ROL.B  D7,D5                            ; $001352
        ADD.W   D7,D7                           ; $001354
        AND.W  $001382(PC,D7.W),D5              ; $001356
        ADD.W   D5,D1                           ; $00135A
        MOVE.W  A5,D0                           ; $00135C
        ADD.W   D0,D0                           ; $00135E
        AND.W  $001382(PC,D0.W),D1              ; $001360
        ADD.W   D3,D1                           ; $001364
        MOVE.B  (A0)+,D5                        ; $001366
        LSL.W  #8,D5                            ; $001368
        MOVE.B  (A0)+,D5                        ; $00136A
        RTS                                     ; $00136C
