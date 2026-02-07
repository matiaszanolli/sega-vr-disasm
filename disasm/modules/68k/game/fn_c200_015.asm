; ============================================================================
; Fn C200 015
; ROM Range: $00CD92-$00CDD2 (64 bytes)
; Source: code_c200
; ============================================================================

fn_c200_015:
        MOVE.L  (-15776).W,-(A7)                ; $00CD92
        LEA     (-16384).W,A1                   ; $00CD96
        MOVEQ   #$00,D1                         ; $00CD9A
        JSR     $0088483A                       ; $00CD9C
        MOVE.L  (A7)+,(-15776).W                ; $00CDA2
        LEA     (-28672).W,A1                   ; $00CDA6
        MOVEQ   #$00,D1                         ; $00CDAA
        MOVEQ   #$0F,D7                         ; $00CDAC
.loc_001C:
        JSR     $00884842                       ; $00CDAE
        DBRA    D7,.loc_001C                    ; $00CDB4
        MOVEQ   #$00,D1                         ; $00CDB8
        MOVE.B  D1,(-15602).W                   ; $00CDBA
        MOVE.W  D1,(-14166).W                   ; $00CDBE
        MOVE.W  D1,(-14164).W                   ; $00CDC2
        MOVE.W  D1,(-14162).W                   ; $00CDC6
        MOVE.W  #$FFFF,(-16346).W               ; $00CDCA
        RTS                                     ; $00CDD0
