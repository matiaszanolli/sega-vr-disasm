; ============================================================================
; fn_a200_013 — Sequence Data Word Decoder
; ROM Range: $00B3CE-$00B40E (64 bytes)
; Decodes 3 bytes from sequence stream (A1) into word-sized output (A2).
; Same lookup tables as fn_a200_006 ($00899884 and $0089980C). Reads
; encoded bytes, translates via table, writes decoded words to output.
; Third byte produces a full word instead of split nibbles.
;
; Entry: A1 = source stream, A2 = output buffer
; Uses: D0, A1, A2, A3
; Confidence: high
; ============================================================================

fn_a200_013:
        MOVEQ   #$00,D0                         ; $00B3CE
        MOVE.B  (A1)+,D0                        ; $00B3D0
        ADD.W   D0,D0                           ; $00B3D2
        LEA     $00899884,A3                    ; $00B3D4
        MOVE.W  $00(A3,D0.W),D0                 ; $00B3DA
        MOVE.B  D0,(A2)+                        ; $00B3DE
        MOVEQ   #$00,D0                         ; $00B3E0
        MOVE.B  (A1)+,D0                        ; $00B3E2
        SUBI.B  #$C4,D0                         ; $00B3E4
        ADD.W   D0,D0                           ; $00B3E8
        LEA     $00899884,A3                    ; $00B3EA
        MOVE.W  $00(A3,D0.W),D0                 ; $00B3F0
        MOVE.B  D0,(A2)+                        ; $00B3F4
        MOVEQ   #$00,D0                         ; $00B3F6
        MOVE.B  (A1)+,D0                        ; $00B3F8
        SUBI.B  #$C4,D0                         ; $00B3FA
        ADD.W   D0,D0                           ; $00B3FE
        LEA     $0089980C,A3                    ; $00B400
        MOVE.W  $00(A3,D0.W),D0                 ; $00B406
        MOVE.W  D0,(A2)+                        ; $00B40A
        RTS                                     ; $00B40C
