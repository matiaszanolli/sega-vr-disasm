; ============================================================================
; Ai 021 (auto-analyzed)
; ROM Range: $00B5AE-$00B604 (86 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A0, A1): +$00
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, A0, A1
; Object fields:
;   +$00: [unknown]
; Confidence: low
; ============================================================================

fn_a200_021:
        LEA     $00FF689A,A1                    ; $00B5AE
        MOVE.W  (-28628).W,D0                   ; $00B5B4
        ADDQ.W  #1,D0                           ; $00B5B8
        DC.W    $D040                           ; $00B5BA
        LEA     $00899884,A0                    ; $00B5BC
        MOVE.W  $00(A0,D0.W),D0                 ; $00B5C2
        DC.W    $4EFA,$FF84         ; JMP     $00B54C(PC); $00B5C6
        MOVE.W  (-28628).W,D0                   ; $00B5CA
        CMPI.W  #$0004,D0                       ; $00B5CE
        BLE.S  .loc_002A                        ; $00B5D2
        MOVE.W  #$0004,D0                       ; $00B5D4
.loc_002A:
        LSL.W  #4,D0                            ; $00B5D8
        TST.B  (-15611).W                       ; $00B5DA
        DC.W    $6724               ; BEQ.S  $00B604; $00B5DE
        SUBI.W  #$0010,D0                       ; $00B5E0
        LEA     $00FF68D0,A1                    ; $00B5E4
        LEA     $00(A1,D0.W),A1                 ; $00B5EA
        MOVE.W  #$0201,(A1)                     ; $00B5EE
        CMPA.L  (-13984).W,A1                   ; $00B5F2
        BEQ.S  .loc_004E                        ; $00B5F6
        MOVE.W  #$0200,(A1)                     ; $00B5F8
.loc_004E:
        MOVE.B  #$00,(-15611).W                 ; $00B5FC
        RTS                                     ; $00B602
