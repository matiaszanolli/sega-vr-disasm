; ============================================================================
; Sh2 Comm Send Cmd 037 (auto-analyzed)
; ROM Range: $013C30-$013CBA (138 bytes)
; ============================================================================
; Category: sh2
; Purpose: Accesses 32X registers: COMM0, COMM6, COMM4
;   RAM: $C87E (game_state)
;   Calls: dma_transfer, sh2_send_cmd
;
; Uses: D0, D1, A0, A1
; RAM:
;   $C87E: game_state
; Calls:
;   $00E35A: sh2_send_cmd
;   $00E52C: dma_transfer
; Confidence: high
; ============================================================================

fn_12200_037:
        JSR     $0088205E                       ; $013C30
        CLR.W  D0                               ; $013C36
        DC.W    $4EBA,$A8F2         ; JSR     $00E52C(PC); $013C38
.loc_000C:
        TST.B  $00A15120                        ; $013C3C
        BNE.S  .loc_000C                        ; $013C42
        MOVE.W  #$0101,$00A1512C                ; $013C44
        MOVE.W  #$4000,$00A15128                ; $013C4C
        MOVE.B  #$2C,$00A15121                  ; $013C54
        MOVE.B  #$01,$00A15120                  ; $013C5C
.loc_0034:
        TST.B  $00A1512C                        ; $013C64
        BNE.S  .loc_0034                        ; $013C6A
        MOVE.W  #$00B8,$00A15128                ; $013C6C
        MOVE.W  #$0101,$00A1512C                ; $013C74
        MOVEA.L #$06017CC0,A0                   ; $013C7C
        MOVEA.L #$04007010,A1                   ; $013C82
        MOVE.W  #$0120,D0                       ; $013C88
        MOVE.W  #$0058,D1                       ; $013C8C
        DC.W    $4EBA,$A6C8         ; JSR     $00E35A(PC); $013C90
        MOVEA.L #$0601DFC0,A0                   ; $013C94
        MOVEA.L #$04013010,A1                   ; $013C9A
        MOVE.W  #$0120,D0                       ; $013CA0
        MOVE.W  #$0058,D1                       ; $013CA4
        DC.W    $4EBA,$A6B0         ; JSR     $00E35A(PC); $013CA8
        ADDQ.W  #4,(-14210).W                   ; $013CAC
        MOVE.W  #$0020,$00FF0008                ; $013CB0
        RTS                                     ; $013CB8
