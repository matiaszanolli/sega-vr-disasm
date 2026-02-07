; ============================================================================
; Name Entry Send Cmd 009 (auto-analyzed)
; ROM Range: $010200-$010244 (68 bytes)
; ============================================================================
; Category: game
; Purpose: RAM: $C87E (game_state)
;   Calls: sh2_send_cmd
;   Object (A0): +$00
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, A0, A1
; RAM:
;   $C87E: game_state
; Calls:
;   $00E35A: sh2_send_cmd
; Object fields:
;   +$00: [unknown]
; Confidence: medium
; ============================================================================

fn_10200_009:
        DC.W    $1050                           ; $010200
        MOVE.W  #$00A8,D0                       ; $010202
        MOVE.W  #$0010,D1                       ; $010206
        DC.W    $4EBA,$E14E         ; JSR     $00E35A(PC); $01020A
        MOVEA.L #$06020000,A0                   ; $01020E
        MOVE.W  (-24542).W,D0                   ; $010214
        LSL.W  #7,D0                            ; $010218
        MOVE.W  D0,D1                           ; $01021A
        LSL.W  #2,D0                            ; $01021C
        DC.W    $D041                           ; $01021E
        LEA     $00(A0,D0.W),A0                 ; $010220
        MOVEA.L #$240310CC,A1                   ; $010224
        MOVE.W  #$0028,D0                       ; $01022A
        MOVE.W  #$0010,D1                       ; $01022E
        DC.W    $4EBA,$E126         ; JSR     $00E35A(PC); $010232
        ADDQ.W  #4,(-14210).W                   ; $010236
        MOVE.W  #$0020,$00FF0008                ; $01023A
        RTS                                     ; $010242
