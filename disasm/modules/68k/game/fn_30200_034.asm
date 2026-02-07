; ============================================================================
; Vdp 034 (auto-analyzed)
; ROM Range: $030F0E-$030F82 (116 bytes)
; ============================================================================
; Category: vdp
; Purpose: Accesses VDP registers
;   Object (A0, A5): +$00, +$01, +$09, +$0B, +$0C
;
; Entry: A0 = object/entity pointer
; Entry: A5 = object/entity pointer
; Uses: D0, D6, A0, A5
; Object fields:
;   +$00: [unknown]
;   +$01: [unknown]
;   +$09: [unknown]
;   +$0B: [unknown]
;   +$0C: [unknown]
; Confidence: medium
; ============================================================================

fn_30200_034:
        TST.B  $000B(A5)                        ; $030F0E
        BEQ.W  .loc_0072                        ; $030F12
        MOVE.B  $0009(A5),D6                    ; $030F16
        MOVEQ   #$00,D0                         ; $030F1A
        MOVE.B  $000B(A5),D0                    ; $030F1C
        BEQ.S  .loc_0052                        ; $030F20
        DC.W    $41FA,$1AD6         ; LEA     $0329FA(PC),A0; $030F22
        SUBQ.W  #1,D0                           ; $030F26
        LSL.W  #2,D0                            ; $030F28
        MOVEA.L $00(A0,D0.W),A0                 ; $030F2A
        MOVEQ   #$00,D0                         ; $030F2E
        MOVE.B  $000C(A5),D0                    ; $030F30
        ADDQ.B  #1,$000C(A5)                    ; $030F34
        MOVE.B  $00(A0,D0.W),D0                 ; $030F38
        BPL.S  .loc_0048                        ; $030F3C
        CMPI.B  #$83,D0                         ; $030F3E
        DC.W    $674C               ; BEQ.S  $030F90; $030F42
        CMPI.B  #$81,D0                         ; $030F44
        DC.W    $6752               ; BEQ.S  $030F9C; $030F48
        CMPI.B  #$82,D0                         ; $030F4A
        DC.W    $6752               ; BEQ.S  $030FA2; $030F4E
        CMPI.B  #$80,D0                         ; $030F50
        DC.W    $6754               ; BEQ.S  $030FAA; $030F54
.loc_0048:
        DC.W    $DC40                           ; $030F56
        CMPI.B  #$10,D6                         ; $030F58
        BCS.S  .loc_0052                        ; $030F5C
        MOVEQ   #$0F,D6                         ; $030F5E
.loc_0052:
        BTST    #1,(A5)                         ; $030F60
        BNE.S  .loc_0072                        ; $030F64
        BTST    #2,(A5)                         ; $030F66
        BNE.S  .loc_0072                        ; $030F6A
        BTST    #4,(A5)                         ; $030F6C
        DC.W    $6610               ; BNE.S  $030F82; $030F70
        OR.B   $0001(A5),D6                     ; $030F72
        ADDI.B  #$10,D6                         ; $030F76
        MOVE.B  D6,$00C00011                    ; $030F7A
.loc_0072:
        RTS                                     ; $030F80
