; ============================================================================
; Init 004 (auto-analyzed)
; ROM Range: $000694-$0006BC (40 bytes)
; ============================================================================
; Category: boot
; Purpose: Short helper function
;   Object (A0): +$100
;
; Entry: A0 = object/entity pointer
; Uses: D0, D7, A0
; Object fields:
;   +$100: [unknown]
; Confidence: low
; ============================================================================

fn_200_004:
        MOVEM.L D0/D7/A0,-(A7)                  ; $000694
        LEA     $00A15200,A0                    ; $000698
.loc_000A:
        BCLR    #7,-$0100(A0)                   ; $00069E
        BNE.S  .loc_000A                        ; $0006A4
        MOVE.W  #$001F,D7                       ; $0006A6
.loc_0016:
        MOVE.L  D0,(A0)+                        ; $0006AA
        MOVE.L  D0,(A0)+                        ; $0006AC
        MOVE.L  D0,(A0)+                        ; $0006AE
        MOVE.L  D0,(A0)+                        ; $0006B0
        DBRA    D7,.loc_0016                    ; $0006B2
        MOVEM.L (A7)+,D0/D7/A0                  ; $0006B6
        RTS                                     ; $0006BA
