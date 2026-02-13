; ============================================================================
; sequence_data_byte_decoder — Sequence Data Byte Decoder
; ROM Range: $00B15E-$00B1B8 (90 bytes)
; Decodes 3 bytes from sequence stream (A2) into display/sound format.
; Uses lookup tables at $00899884 and $0089980C to translate encoded
; byte values. Splits decoded bytes into high/low nibbles and writes
; to output buffer (A1). Shared subroutine at .loc_004C handles the
; nibble split.
;
; Entry: D3 = output offset, A1 = output buffer, A2 = source stream
; Uses: D0, D1, D3, A0, A1, A2
; Confidence: high
; ============================================================================

sequence_data_byte_decoder:
        LSL.W  #4,D3                            ; $00B15E
        LEA     $00(A1,D3.W),A1                 ; $00B160
        MOVE.B  #$02,-$0009(A1)                 ; $00B164
        MOVEQ   #$00,D0                         ; $00B16A
        MOVE.B  (A2)+,D0                        ; $00B16C
        ADD.W   D0,D0                           ; $00B16E
        LEA     $00899884,A0                    ; $00B170
        MOVE.W  $00(A0,D0.W),D0                 ; $00B176
        BSR.S  .loc_004C                        ; $00B17A
        MOVEQ   #$00,D0                         ; $00B17C
        MOVE.B  (A2)+,D0                        ; $00B17E
        SUBI.B  #$C4,D0                         ; $00B180
        ADD.W   D0,D0                           ; $00B184
        LEA     $00899884,A0                    ; $00B186
        MOVE.W  $00(A0,D0.W),D0                 ; $00B18C
        BSR.S  .loc_004C                        ; $00B190
        MOVEQ   #$00,D0                         ; $00B192
        MOVE.B  (A2)+,D0                        ; $00B194
        SUBI.B  #$C4,D0                         ; $00B196
        ADD.W   D0,D0                           ; $00B19A
        LEA     $0089980C,A0                    ; $00B19C
        MOVE.B  $00(A0,D0.W),(A1)+              ; $00B1A2
        MOVE.B  $01(A0,D0.W),D0                 ; $00B1A6
.loc_004C:
        MOVE.B  D0,D1                           ; $00B1AA
        LSR.B  #4,D1                            ; $00B1AC
        MOVE.B  D1,(A1)+                        ; $00B1AE
        ANDI.B  #$0F,D0                         ; $00B1B0
        MOVE.B  D0,(A1)+                        ; $00B1B4
        RTS                                     ; $00B1B6
