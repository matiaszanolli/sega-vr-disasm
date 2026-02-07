; ============================================================================
; Ai 004 (auto-analyzed)
; ROM Range: $00B0DE-$00B11A (60 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A0): +$01, +$02 (flags/type)
;
; Entry: A0 = object/entity pointer
; Uses: D0, A0
; Object fields:
;   +$01: [unknown]
;   +$02: flags/type
; Confidence: low
; ============================================================================

fn_a200_004:
        LEA     (-22041).W,A0                   ; $00B0DE
        MOVE.B  (-19218).W,D0                   ; $00B0E2
        DC.W    $4EBA,$000A         ; JSR     $00B0F2(PC); $00B0E6
        LEA     (-22045).W,A0                   ; $00B0EA
        MOVE.B  (-15602).W,D0                   ; $00B0EE
        BTST    #4,D0                           ; $00B0F2
        BEQ.S  .loc_003A                        ; $00B0F6
        CMPI.B  #$3C,(A0)                       ; $00B0F8
        BGE.S  .loc_003A                        ; $00B0FC
        ADDQ.B  #1,$0002(A0)                    ; $00B0FE
        BNE.S  .loc_003A                        ; $00B102
        MOVE.B  #$C4,$0002(A0)                  ; $00B104
        ADDQ.B  #1,$0001(A0)                    ; $00B10A
        BNE.S  .loc_003A                        ; $00B10E
        MOVE.B  #$C4,$0001(A0)                  ; $00B110
        ADDQ.B  #1,(A0)                         ; $00B116
.loc_003A:
        RTS                                     ; $00B118
