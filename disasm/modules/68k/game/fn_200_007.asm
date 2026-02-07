; ============================================================================
; Input Controller Port Init 007 (auto-analyzed)
; ROM Range: $000C70-$000D68 (248 bytes)
; ============================================================================
; Category: input
; Purpose: Accesses VDP registers
;   Reads controller input
;   Calls: io_port_init, controller_port_init
;
; Uses: D0, D1, D7, A1
; Calls:
;   $00170C: controller_port_init
;   $0018D8: io_port_init
; Confidence: high
; ============================================================================

fn_200_007:
        ORI.B  #$00,D0                          ; $000C70
        ORI.B  #$00,D0                          ; $000C74
        ORI.B  #$00,D0                          ; $000C78
        ORI.B  #$00,D0                          ; $000C7C
        MOVE    SR,-(A7)                        ; $000C80
        MOVE    #$2700,SR                       ; $000C82
        MOVE.W  #$0100,$00A11100                ; $000C86
        MOVE.W  #$0100,$00A11200                ; $000C8E
.loc_0026:
        BTST    #0,$00A11100                    ; $000C96
        BNE.S  .loc_0026                        ; $000C9E
        LEA     $00A00000,A1                    ; $000CA0
        MOVE.B  #$F3,(A1)+                      ; $000CA6
        MOVE.B  #$F3,(A1)+                      ; $000CAA
        MOVE.B  #$C3,(A1)+                      ; $000CAE
        MOVE.B  #$00,(A1)+                      ; $000CB2
        MOVE.B  #$00,(A1)+                      ; $000CB6
        MOVE.W  #$0000,$00A11200                ; $000CBA
        NOP                                     ; $000CC2
        NOP                                     ; $000CC4
        NOP                                     ; $000CC6
        NOP                                     ; $000CC8
        NOP                                     ; $000CCA
        NOP                                     ; $000CCC
        NOP                                     ; $000CCE
        NOP                                     ; $000CD0
        NOP                                     ; $000CD2
        NOP                                     ; $000CD4
        NOP                                     ; $000CD6
        NOP                                     ; $000CD8
        NOP                                     ; $000CDA
        NOP                                     ; $000CDC
        MOVE.W  #$0000,$00A11100                ; $000CDE
        MOVE.W  #$0100,$00A11200                ; $000CE6
        MOVE    (A7)+,SR                        ; $000CEE
        MOVEQ   #-$01,D0                        ; $000CF0
        MOVE.B  D0,$00C00011                    ; $000CF2
        NOP                                     ; $000CF8
        NOP                                     ; $000CFA
        SUBI.B  #$20,D0                         ; $000CFC
        MOVE.B  D0,$00C00011                    ; $000D00
        NOP                                     ; $000D06
        NOP                                     ; $000D08
        SUBI.B  #$20,D0                         ; $000D0A
        MOVE.B  D0,$00C00011                    ; $000D0E
        NOP                                     ; $000D14
        NOP                                     ; $000D16
        SUBI.B  #$20,D0                         ; $000D18
        MOVE.B  D0,$00C00011                    ; $000D1C
        LEA     (-13920).W,A1                   ; $000D22
        MOVEQ   #$00,D1                         ; $000D26
        MOVE.W  #$0D57,D7                       ; $000D28
.loc_00BC:
        MOVE.L  D1,(A1)+                        ; $000D2C
        DBRA    D7,.loc_00BC                    ; $000D2E
        MOVE.B  $00A10001,D0                    ; $000D32
        MOVE.B  D0,(-4348).W                    ; $000D38
        BTST    #7,D0                           ; $000D3C
        SNE     (-4347).W                       ; $000D40
        BTST    #6,D0                           ; $000D44
        SNE     (-4346).W                       ; $000D48
        JSR     $0088C7E8                       ; $000D4C
        DC.W    $4EBA,$0B84         ; JSR     $0018D8(PC); $000D52
        DC.W    $4EBA,$09B4         ; JSR     $00170C(PC); $000D56
        MOVE.B  #$01,(-599).W                   ; $000D5A
        MOVE.B  (-14312).W,(-348).W             ; $000D60
        RTS                                     ; $000D66
