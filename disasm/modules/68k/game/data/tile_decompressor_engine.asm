; ============================================================================
; tile_decompressor_engine — Tile Decompressor Engine
; ROM Range: $0011EE-$0012F4 (262 bytes)
; ============================================================================
; Main tile decompression engine. Reads compressed tile commands from (A0)+
; and decompresses to output buffer via (A1)+. Uses 8-way jump table at
; $0012CC for different decompression modes:
;   0-1: Sequential copy from base A2 (incrementing tile IDs)
;   2-3: Fill from base A4 (constant tile)
;   4: Literal tile (from bit-stream)
;   5: Incrementing tile sequence (from bit-stream)
;   6: Decrementing tile sequence (from bit-stream)
;   7: Individual tiles (each from bit-stream), $0F = end sentinel
;
; Second entry at $001236: Nametable decompressor variant — saves all regs,
; reads compressed nametable format with tile dimensions and bit-stream.
;
; Entry: A0 = compressed data, A1 = output buffer, D0 = initial value
; Entry (alt $001236): A0 = compressed nametable data, D0 = base offset
; Uses: D0-D7, A0-A5
; Calls:
;   $0012F4: tile_bit_stream_unpacker (BSR PC-relative)
;   $0013A4: bit_stream_refill (BSR PC-relative)
; ============================================================================

tile_decompressor_engine:
        MOVE.W  D0,D7                           ; $0011EE
.next_command:
        MOVE.B  (A0)+,D0                        ; $0011F0
        CMPI.B  #$80,D0                         ; $0011F2
        DC.W    $64EE               ; BCC.S  $0011E6; $0011F6
        MOVE.B  D0,D1                           ; $0011F8
        ANDI.W  #$000F,D7                       ; $0011FA
        ANDI.W  #$0070,D1                       ; $0011FE
        OR.W    D1,D7                           ; $001202
        ANDI.W  #$000F,D0                       ; $001204
        MOVE.B  D0,D1                           ; $001208
        LSL.W  #8,D1                            ; $00120A
        OR.W    D1,D7                           ; $00120C
        MOVEQ   #$08,D1                         ; $00120E
        SUB.W   D0,D1                           ; $001210
        BNE.S  .multi_tile_fill                  ; $001212
        MOVE.B  (A0)+,D0                        ; $001214
        ADD.W   D0,D0                           ; $001216
        MOVE.W  D7,$00(A1,D0.W)                 ; $001218
        BRA.S  .next_command                    ; $00121C
.multi_tile_fill:
        MOVE.B  (A0)+,D0                        ; $00121E
        LSL.W  D1,D0                            ; $001220
        ADD.W   D0,D0                           ; $001222
        MOVEQ   #$01,D5                         ; $001224
        LSL.W  D1,D5                            ; $001226
        SUBQ.W  #1,D5                           ; $001228
.fill_loop:
        MOVE.W  D7,$00(A1,D0.W)                 ; $00122A
        ADDQ.W  #2,D0                           ; $00122E
        DBRA    D5,.fill_loop                    ; $001230
        BRA.S  .next_command                    ; $001234
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7/A1/A2/A3/A4/A5,-(A7); $001236
        MOVEA.W D0,A3                           ; $00123A
        MOVE.B  (A0)+,D0                        ; $00123C
        EXT.W   D0                              ; $00123E
        MOVEA.W D0,A5                           ; $001240
        MOVE.B  (A0)+,D4                        ; $001242
        LSL.B  #3,D4                            ; $001244
        MOVEA.W (A0)+,A2                        ; $001246
        ADDA.W  A3,A2                           ; $001248
        MOVEA.W (A0)+,A4                        ; $00124A
        ADDA.W  A3,A4                           ; $00124C
        MOVE.B  (A0)+,D5                        ; $00124E
        ASL.W  #8,D5                            ; $001250
        MOVE.B  (A0)+,D5                        ; $001252
        MOVEQ   #$10,D6                         ; $001254
.decode_next_tile:
        MOVEQ   #$07,D0                         ; $001256
        MOVE.W  D6,D7                           ; $001258
        SUB.W   D0,D7                           ; $00125A
        MOVE.W  D5,D1                           ; $00125C
        LSR.W  D7,D1                            ; $00125E
        ANDI.W  #$007F,D1                       ; $001260
        MOVE.W  D1,D2                           ; $001264
        CMPI.W  #$0040,D1                       ; $001266
        BCC.S  .short_code                      ; $00126A
        MOVEQ   #$06,D0                         ; $00126C
        LSR.W  #1,D2                            ; $00126E
.short_code:
        bsr.w   tile_bit_stream_refill_with_mask_table+54; $6100 $0132
        ANDI.W  #$000F,D2                       ; $001274
        LSR.W  #4,D1                            ; $001278
        ADD.W   D1,D1                           ; $00127A
        JMP     $0012CC(PC,D1.W)                ; $00127C
.mode_seq_copy:
        MOVE.W  A2,(A1)+                        ; $001280
        ADDQ.W  #1,A2                           ; $001282
        DBRA    D2,.mode_seq_copy                    ; $001284
        BRA.S  .decode_next_tile                        ; $001288
.mode_fill:
        MOVE.W  A4,(A1)+                        ; $00128A
        DBRA    D2,.mode_fill                    ; $00128C
        BRA.S  .decode_next_tile                        ; $001290
.mode_literal:
        bsr.w   tile_bit_stream_unpacker; $6100 $0060
.literal_loop:
        MOVE.W  D1,(A1)+                        ; $001296
        DBRA    D2,.literal_loop                    ; $001298
        BRA.S  .decode_next_tile                        ; $00129C
.mode_increment:
        bsr.w   tile_bit_stream_unpacker; $6100 $0054
.increment_loop:
        MOVE.W  D1,(A1)+                        ; $0012A2
        ADDQ.W  #1,D1                           ; $0012A4
        DBRA    D2,.increment_loop                    ; $0012A6
        BRA.S  .decode_next_tile                        ; $0012AA
.mode_decrement:
        bsr.w   tile_bit_stream_unpacker; $6100 $0046
.decrement_loop:
        MOVE.W  D1,(A1)+                        ; $0012B0
        SUBQ.W  #1,D1                           ; $0012B2
        DBRA    D2,.decrement_loop                    ; $0012B4
        BRA.S  .decode_next_tile                        ; $0012B8
.mode_individual:
        CMPI.W  #$000F,D2                       ; $0012BA
        BEQ.S  .end_sentinel                        ; $0012BE
.individual_loop:
        bsr.w   tile_bit_stream_unpacker; $6100 $0032
        MOVE.W  D1,(A1)+                        ; $0012C4
        DBRA    D2,.individual_loop                    ; $0012C6
        BRA.S  .decode_next_tile                        ; $0012CA
        BRA.S  .mode_seq_copy                        ; $0012CC
        BRA.S  .mode_seq_copy                        ; $0012CE
        BRA.S  .mode_fill                        ; $0012D0
        BRA.S  .mode_fill                        ; $0012D2
        BRA.S  .mode_literal                        ; $0012D4
        BRA.S  .mode_increment                        ; $0012D6
        BRA.S  .mode_decrement                        ; $0012D8
        BRA.S  .mode_individual                        ; $0012DA
.end_sentinel:
        SUBQ.W  #1,A0                           ; $0012DC
        CMPI.W  #$0010,D6                       ; $0012DE
        BNE.S  .check_alignment                        ; $0012E2
        SUBQ.W  #1,A0                           ; $0012E4
.check_alignment:
        MOVE.W  A0,D0                           ; $0012E6
        LSR.W  #1,D0                            ; $0012E8
        BCC.S  .restore_and_return                        ; $0012EA
        ADDQ.W  #1,A0                           ; $0012EC
.restore_and_return:
        MOVEM.L (A7)+,D0/D1/D2/D3/D4/D5/D6/D7/A1/A2/A3/A4/A5; $0012EE
        RTS                                     ; $0012F2
