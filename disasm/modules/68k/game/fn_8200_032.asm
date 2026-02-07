; ============================================================================
; State 032 (auto-analyzed)
; ROM Range: $009064-$00909C (56 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A0): +$CC
;
; Entry: A0 = object/entity pointer
; Uses: D0, A0
; Object fields:
;   +$CC: [unknown]
; Confidence: low
; ============================================================================

fn_8200_032:
        BTST    #3,(-15597).W                   ; $009064
        DC.W    $6630               ; BNE.S  $00909C; $00906A
        MOVE.W  $00CC(A0),D0                    ; $00906C
        ASR.W  #6,D0                            ; $009070
        MOVE.W  D0,(-32766).W                   ; $009072
        MOVE.W  $00FF6108,D0                    ; $009076
        ASR.W  #8,D0                            ; $00907C
        CMPI.W  #$FFF8,D0                       ; $00907E
        BGE.S  .loc_0022                        ; $009082
        MOVEQ   #-$08,D0                        ; $009084
.loc_0022:
        CMPI.W  #$0010,D0                       ; $009086
        BLE.S  .loc_002A                        ; $00908A
        MOVEQ   #$10,D0                         ; $00908C
.loc_002A:
        SUBQ.W  #8,D0                           ; $00908E
        MOVE.W  D0,(-14206).W                   ; $009090
        MOVE.W  #$FEC0,(-32768).W               ; $009094
        RTS                                     ; $00909A
