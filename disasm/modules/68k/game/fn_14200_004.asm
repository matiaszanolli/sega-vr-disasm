; ============================================================================
; Vdp 004 (auto-analyzed)
; ROM Range: $0145F0-$01462A (58 bytes)
; ============================================================================
; Category: vdp
; Purpose: Accesses VDP registers
;   Object (A1): +$00
;
; Entry: A1 = object/entity pointer
; Uses: D0, D1, D2, D3, D4, A1, A2, A3
; Object fields:
;   +$00: [unknown]
; Confidence: medium
; ============================================================================

fn_14200_004:
        MOVE.W  (A1)+,D2                        ; $0145F0
        MOVE.W  (A1)+,D3                        ; $0145F2
        MOVE.W  (A1)+,D0                        ; $0145F4
        MOVEA.L A1,A2                           ; $0145F6
        LEA     (-24320).W,A3                   ; $0145F8
        MOVE.W  D0,D4                           ; $0145FC
        DC.W    $D844                           ; $0145FE
        SUBQ.W  #1,D4                           ; $014600
.loc_0012:
        MOVE.L  (A2)+,(A3)+                     ; $014602
        DBRA    D4,.loc_0012                    ; $014604
        DC.W    $D040                           ; $014608
        LEA     $00(A1,D0.W),A1                 ; $01460A
        LEA     $00844000,A3                    ; $01460E
        ADDA.L  D1,A3                           ; $014614
.loc_0026:
        LEA     (A3),A2                         ; $014616
        MOVE.W  (A1)+,D4                        ; $014618
.loc_002A:
        MOVE.W  (A1)+,(A2)+                     ; $01461A
        DBRA    D4,.loc_002A                    ; $01461C
        LEA     $0200(A3),A3                    ; $014620
        DBRA    D3,.loc_0026                    ; $014624
        RTS                                     ; $014628
