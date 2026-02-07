; ============================================================================
; Display Scroll 003 (auto-analyzed)
; ROM Range: $00B094-$00B0DE (74 bytes)
; ============================================================================
; Category: display
; Purpose: RAM: $C050 (scroll_state)
;   Object (A0): +$01, +$02 (flags/type)
;
; Entry: A0 = object/entity pointer
; Uses: D0, A0
; RAM:
;   $C050: scroll_state
; Object fields:
;   +$01: [unknown]
;   +$02: flags/type
; Confidence: medium
; ============================================================================

fn_a200_003:
        LEA     (-14317).W,A0                   ; $00B094
        MOVE.B  (-19218).W,D0                   ; $00B098
        BRA.S  .loc_0012                        ; $00B09C
        LEA     (-14330).W,A0                   ; $00B09E
        MOVE.B  (-15602).W,D0                   ; $00B0A2
.loc_0012:
        BTST    #4,D0                           ; $00B0A6
        BEQ.S  .loc_0048                        ; $00B0AA
        CMPI.B  #$3C,(A0)                       ; $00B0AC
        BGE.S  .loc_0048                        ; $00B0B0
        ADDQ.B  #1,$0002(A0)                    ; $00B0B2
        BNE.S  .loc_0048                        ; $00B0B6
        MOVE.B  #$C4,$0002(A0)                  ; $00B0B8
        ANDI.B  #$23,D0                         ; $00B0BE
        BNE.S  .loc_003A                        ; $00B0C2
        TST.B  (-15603).W                       ; $00B0C4
        BNE.S  .loc_003A                        ; $00B0C8
        SUBQ.W  #1,(-16304).W                   ; $00B0CA
.loc_003A:
        ADDQ.B  #1,$0001(A0)                    ; $00B0CE
        BNE.S  .loc_0048                        ; $00B0D2
        MOVE.B  #$C4,$0001(A0)                  ; $00B0D4
        ADDQ.B  #1,(A0)                         ; $00B0DA
.loc_0048:
        RTS                                     ; $00B0DC
