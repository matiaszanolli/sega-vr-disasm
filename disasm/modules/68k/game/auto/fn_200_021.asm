; ============================================================================
; fn_200_021 — Tile Bit-Stream Refill with Mask Table
; ROM Range: $00136E-$0013B4 (70 bytes)
; ============================================================================
; Continuation of tile bit-stream unpacker. Contains:
;   1. Alternate refill path ($00136E): handles case where bit-stream
;      crosses byte boundary — shifts, masks, and adds partial bits
;   2. Bitmask lookup table ($001382): 16 entries for variable-width
;      bit extraction: $0001, $0003, $000F, $003F, $007F, $00FF,
;      $01FF, $03FF, $07FF, $0FFF, $1FFF, $3FFF, $7FFF, $FFFF
;   3. Bit-stream refill subroutine ($0013A4): decrements D6 by D0,
;      if D6 < 9, reads next byte from (A0)+ into D5 and adds 8 to D6
;
; Entry: D0 = bits needed, D5 = bit-stream, D6 = bits remaining, A0 = data
; Uses: D0, D1, D5, D6, D7, A0, A5
; ============================================================================

fn_200_021:
        BEQ.S  .loc_0012                        ; $00136E
        LSR.W  D7,D1                            ; $001370
        MOVE.W  A5,D0                           ; $001372
        ADD.W   D0,D0                           ; $001374
        AND.W  $001382(PC,D0.W),D1              ; $001376
        ADD.W   D3,D1                           ; $00137A
        MOVE.W  A5,D0                           ; $00137C
        BRA.S  .loc_0036                        ; $00137E
.loc_0012:
        MOVEQ   #$10,D6                         ; $001380
        DC.W    $60D8               ; BRA.S  $00135C; $001382
        ORI.B  #$03,D1                          ; $001384
        ORI.B  #$0F,D7                          ; $001388
        ORI.B  #$3F,(A7)+                       ; $00138C
        DC.W    $007F                           ; $001390
        DC.W    $00FF                           ; $001392
        DC.W    $01FF                           ; $001394
        DC.W    $03FF                           ; $001396
        DC.W    $07FF                           ; $001398
        DC.W    $0FFF                           ; $00139A
        DC.W    $1FFF                           ; $00139C
        DC.W    $3FFF                           ; $00139E
        DC.W    $7FFF                           ; $0013A0
        DC.W    $FFFF                           ; $0013A2
.loc_0036:
        SUB.W   D0,D6                           ; $0013A4
        CMPI.W  #$0009,D6                       ; $0013A6
        BCC.S  .loc_0044                        ; $0013AA
        ADDQ.W  #8,D6                           ; $0013AC
        ASL.W  #8,D5                            ; $0013AE
        MOVE.B  (A0)+,D5                        ; $0013B0
.loc_0044:
        RTS                                     ; $0013B2
