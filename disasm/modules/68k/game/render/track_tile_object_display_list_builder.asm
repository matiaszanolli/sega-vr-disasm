; ============================================================================
; track_tile_object_display_list_builder — Track Tile Object Display List Builder
; ROM Range: $007280-$00734E (206 bytes)
; Builds display list of visible track objects. Converts entity X/Y position
; to tile grid coordinates, looks up road segment data from ROM tables at
; $89A932, iterates 12 neighboring tiles checking for visible objects,
; and writes their addresses to the display list buffer (A2). Returns
; object count in D4.
;
; Entry: A0 = entity pointer, A2 = display list write pointer
; Uses: D0, D1, D2, D3, D4, D6, D7, A0, A1, A3, A4
; Object fields: +$30 x_position, +$34 y_position, +$CA tile_x, +$CC tile_y
; Confidence: high
; ============================================================================

track_tile_object_display_list_builder:
        MOVE.L  A4,-(A7)                        ; $007280
        MOVE.W  #$0400,D1                       ; $007282
        MOVE.W  $0030(A0),D2                    ; $007286
        ASR.W  #4,D2                            ; $00728A
        ADD.W   D1,D2                           ; $00728C
        MOVE.W  D2,D3                           ; $00728E
        MOVEQ   #$00,D6                         ; $007290
        ANDI.W  #$0020,D3                       ; $007292
        BNE.S  .x_half_tile_done                 ; $007296
        MOVEQ   #$01,D6                         ; $007298
.x_half_tile_done:
        ASR.W  #6,D2                            ; $00729A
        MOVE.W  $0034(A0),D3                    ; $00729C
        ASR.W  #4,D3                            ; $0072A0
        SUB.W   D3,D1                           ; $0072A2
        MOVE.W  D1,D3                           ; $0072A4
        ANDI.W  #$0020,D3                       ; $0072A6
        BEQ.S  .y_half_tile_done                 ; $0072AA
        ADDQ.B  #2,D6                           ; $0072AC
.y_half_tile_done:
        ANDI.W  #$FFC0,D1                       ; $0072AE
        ASR.W  #1,D1                            ; $0072B2
        ADD.W   D2,D1                           ; $0072B4
        ADD.W   D1,D1                           ; $0072B6
        ADD.W   D1,D1                           ; $0072B8
        MOVE.W  D1,$00CA(A0)                    ; $0072BA
        MOVEQ   #$00,D0                         ; $0072BE
        MOVE.W  $00CC(A0),D0                    ; $0072C0
        ADDI.W  #$1000,D0                       ; $0072C4
        ASL.L  #5,D0                            ; $0072C8
        SWAP    D0                              ; $0072CA
        ANDI.W  #$001C,D0                       ; $0072CC
        LEA     $0089A932,A3                    ; $0072D0
        MOVEA.L $00(A3,D0.W),A3                 ; $0072D6
        BTST    #2,D0                           ; $0072DA
        BNE.S  .segment_type_hi                  ; $0072DE
        ANDI.B  #$08,D0                         ; $0072E0
        BNE.S  .adjust_x_negative               ; $0072E4
        ANDI.B  #$02,D6                         ; $0072E6
        BEQ.S  .tile_offset_ready               ; $0072EA
        ADDI.W  #$0080,D1                       ; $0072EC
        BRA.S  .tile_offset_ready                ; $0072F0
.adjust_x_negative:
        ANDI.B  #$01,D6                         ; $0072F2
        BEQ.S  .tile_offset_ready               ; $0072F6
        SUBQ.W  #4,D1                           ; $0072F8
        BRA.S  .tile_offset_ready                ; $0072FA
.segment_type_hi:
        ANDI.B  #$10,D0                         ; $0072FC
        BEQ.S  .adjust_x_positive               ; $007300
        ANDI.B  #$01,D6                         ; $007302
        BEQ.S  .tile_offset_ready               ; $007306
        SUBQ.W  #4,D1                           ; $007308
        BRA.S  .tile_offset_ready                ; $00730A
.adjust_x_positive:
        ANDI.B  #$01,D6                         ; $00730C
        BNE.S  .tile_offset_ready               ; $007310
        ADDQ.W  #4,D1                           ; $007312
.tile_offset_ready:
        MOVE.L  #$2207FFFE,D3                   ; $007314
        MOVE.W  (-14176).W,D0                   ; $00731A
        lea     vdp_nametable_setup_display_list_build(pc),a1; $43FA $FF28
        MOVEA.L $00(A1,D0.W),A1                 ; $007322
        MOVEQ   #$00,D4                         ; $007326
        MOVEA.L $00(A1,D1.W),A4                 ; $007328
        CMPA.L  D3,A4                           ; $00732C
        BEQ.S  .center_tile_empty                ; $00732E
        MOVE.L  A4,(A2)+                        ; $007330
        ADDQ.W  #1,D4                           ; $007332
.center_tile_empty:
        MOVEQ   #$0B,D7                         ; $007334
.neighbor_loop:
        MOVE.W  D1,D0                           ; $007336
        ADD.W  (A3)+,D0                         ; $007338
        MOVEA.L $00(A1,D0.W),A4                 ; $00733A
        CMPA.L  D3,A4                           ; $00733E
        BEQ.S  .neighbor_empty                   ; $007340
        MOVE.L  A4,(A2)+                        ; $007342
        ADDQ.W  #1,D4                           ; $007344
.neighbor_empty:
        DBRA    D7,.neighbor_loop               ; $007346
        MOVEA.L (A7)+,A4                        ; $00734A
        RTS                                     ; $00734C
