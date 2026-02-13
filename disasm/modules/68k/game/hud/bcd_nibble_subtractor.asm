; ============================================================================
; bcd_nibble_subtractor — BCD Nibble Subtractor
; ROM Range: $00B478-$00B4CA (82 bytes)
; Performs BCD subtraction on nibble pairs stored at (A4).
; Clears extend flag, then subtracts source nibbles (+$04-$07) from
; destination nibbles (+$00-$03) using SBCD. Handles carry propagation
; with ORI.B #$10,CCR to set extend. Clamps result at $59 (max 59
; minutes/seconds). Paired with word_to_nibble_unpacker (nibble unpacker).
;
; Entry: A4 = nibble buffer pointer
; Uses: D0, D1, A4
; Confidence: high
; ============================================================================

bcd_nibble_subtractor:
        ANDI.B  #$EF,CCR                        ; $00B478
        MOVE.B  $0003(A4),D1                    ; $00B47C
        MOVE.B  $0007(A4),D0                    ; $00B480
        SBCD    D0,D1                           ; $00B484
        MOVE.B  D1,$0003(A4)                    ; $00B486
        MOVE.B  $0002(A4),D1                    ; $00B48A
        MOVE.B  $0006(A4),D0                    ; $00B48E
        SBCD    D0,D1                           ; $00B492
        ANDI.B  #$0F,D1                         ; $00B494
        MOVE.B  D1,$0002(A4)                    ; $00B498
        MOVE.B  $0001(A4),D1                    ; $00B49C
        MOVE.B  $0005(A4),D0                    ; $00B4A0
        SBCD    D0,D1                           ; $00B4A4
        BCC.S  .loc_0038                        ; $00B4A6
        SUBI.B  #$40,D1                         ; $00B4A8
        ORI.B   #$10,CCR                        ; $00B4AC
.loc_0038:
        MOVE.B  D1,$0001(A4)                    ; $00B4B0
        MOVE.B  (A4),D1                         ; $00B4B4
        MOVE.B  $0004(A4),D0                    ; $00B4B6
        SBCD    D0,D1                           ; $00B4BA
        CMPI.B  #$59,D1                         ; $00B4BC
        BLE.S  .loc_004E                        ; $00B4C0
        MOVE.B  #$59,D1                         ; $00B4C2
.loc_004E:
        MOVE.B  D1,(A4)                         ; $00B4C6
        RTS                                     ; $00B4C8
