; ============================================================================
; fn_200_002 — VDP VRAM Clear via DMA
; ROM Range: $0005CE-$00063E (112 bytes)
; ============================================================================
; Clears VDP VRAM using DMA fill operations. Loads DMA parameters from table
; at $0000063E, then:
;   1. Write 7 VDP register commands + DMA trigger from table
;   2. Wait for DMA completion (poll VDP status bit 1)
;   3. Write 2 more register commands from table
;   4. Fill CRAM ($C0000000) with zeros — 16 iterations × 4 words = 64 colors
;   5. Fill sprite table ($40000010) with zeros — 10 iterations × 4 words
;
; Entry: D1 = initial DMA fill value
; Uses: D0, D1, D7, A0, A1
; ============================================================================

fn_200_002:
        MOVEM.L D0/D7/A0/A1,-(A7)               ; $0005CE
        LEA     $0000063E,A0                    ; $0005D2
        LEA     VDP_CTRL,A1                    ; $0005D8
        MOVE.W  (A0)+,(A1)                      ; $0005DE
        MOVE.W  (A0)+,(A1)                      ; $0005E0
        MOVE.W  (A0)+,(A1)                      ; $0005E2
        MOVE.W  (A0)+,(A1)                      ; $0005E4
        MOVE.W  (A0)+,(A1)                      ; $0005E6
        MOVE.W  (A0)+,(A1)                      ; $0005E8
        MOVE.W  (A0)+,(A1)                      ; $0005EA
        MOVE.L  (A0)+,(A1)                      ; $0005EC
        MOVE.W  D1,-$0004(A1)                   ; $0005EE
.loc_0024:
        MOVE.W  (A1),D0                         ; $0005F2
        BTST    #1,D0                           ; $0005F4
        BNE.S  .loc_0024                        ; $0005F8
        MOVE.W  (A0)+,(A1)                      ; $0005FA
        MOVE.W  (A0)+,(A1)                      ; $0005FC
        MOVEQ   #$00,D0                         ; $0005FE
        MOVE.L  #$C0000000,(A1)                 ; $000600
        MOVEQ   #$0F,D7                         ; $000606
.loc_003A:
        MOVE.W  D0,-$0004(A1)                   ; $000608
        MOVE.W  D0,-$0004(A1)                   ; $00060C
        MOVE.W  D0,-$0004(A1)                   ; $000610
        MOVE.W  D0,-$0004(A1)                   ; $000614
        DBRA    D7,.loc_003A                    ; $000618
        MOVE.L  #$40000010,(A1)                 ; $00061C
        MOVEQ   #$09,D7                         ; $000622
.loc_0056:
        MOVE.W  D0,-$0004(A1)                   ; $000624
        MOVE.W  D0,-$0004(A1)                   ; $000628
        MOVE.W  D0,-$0004(A1)                   ; $00062C
        MOVE.W  D0,-$0004(A1)                   ; $000630
        DBRA    D7,.loc_0056                    ; $000634
        MOVEM.L (A7)+,D0/D7/A0/A1               ; $000638
        RTS                                     ; $00063C
