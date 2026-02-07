; ============================================================================
; Sh2 Comm Game 013 (auto-analyzed)
; ROM Range: $013F80-$013FE0 (96 bytes)
; ============================================================================
; Category: sh2
; Purpose: Accesses 32X registers: COMM0
;   RAM: $C87E (game_state)
;
; Uses: D0, A0, A1
; RAM:
;   $C87E: game_state
; Confidence: high
; ============================================================================

fn_12200_013:
.loc_0000:
        CMPI.B  #$06,(-366).W                   ; $013F80
        BNE.W  .loc_001C                        ; $013F86
        LEA     (-382).W,A0                     ; $013F8A
        LEA     (-364).W,A1                     ; $013F8E
        MOVE.W  #$0007,D0                       ; $013F92
.loc_0016:
        MOVE.B  (A0)+,(A1)+                     ; $013F96
        DBRA    D0,.loc_0016                    ; $013F98
.loc_001C:
        CMPI.B  #$06,(-365).W                   ; $013F9C
        BNE.W  .loc_0038                        ; $013FA2
        LEA     (-374).W,A0                     ; $013FA6
        LEA     (-356).W,A1                     ; $013FAA
        MOVE.W  #$0007,D0                       ; $013FAE
.loc_0032:
        MOVE.B  (A0)+,(A1)+                     ; $013FB2
        DBRA    D0,.loc_0032                    ; $013FB4
.loc_0038:
        TST.B  $00A15120                        ; $013FB8
        BNE.S  .loc_0000                        ; $013FBE
        CLR.B  $00A15123                        ; $013FC0
        MOVE.W  #$0000,(-14210).W               ; $013FC6
        MOVE.W  #$0020,$00FF0008                ; $013FCC
        MOVE.L  #$0089305E,$00FF0002            ; $013FD4
        RTS                                     ; $013FDE
