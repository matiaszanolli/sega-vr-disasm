; ============================================================================
; Obj Heading 061 (auto-analyzed)
; ROM Range: $007EFC-$007F50 (84 bytes)
; ============================================================================
; Category: game
; Purpose: Object (A0): +$1E, +$3C (heading_mirror)
;
; Entry: A0 = object/entity pointer
; Uses: D0, A0, A2
; Object fields:
;   +$1E: [unknown]
;   +$3C: heading_mirror
; Confidence: low
; ============================================================================

fn_6200_061:
        LEA     $00FF6940,A2                    ; $007EFC
        BRA.S  .loc_000E                        ; $007F02
        LEA     $00FF6930,A2                    ; $007F04
.loc_000E:
        MOVE.W  $003C(A0),D0                    ; $007F0A
        SUB.W  $001E(A0),D0                     ; $007F0E
        EXT.L   D0                              ; $007F12
        BPL.S  .loc_0020                        ; $007F14
        ADDI.L  #$00010000,D0                   ; $007F16
.loc_0020:
        CMPI.L  #$00004000,D0                   ; $007F1C
        BLE.S  .loc_0046                        ; $007F22
        CMPI.L  #$0000C000,D0                   ; $007F24
        BGE.S  .loc_0046                        ; $007F2A
        MOVE.B  #$01,(-15598).W                 ; $007F2C
        CLR.B  (A2)                             ; $007F32
        BTST    #2,(-14165).W                   ; $007F34
        BEQ.S  .loc_0052                        ; $007F3A
        MOVE.B  #$01,(A2)                       ; $007F3C
        BRA.S  .loc_0052                        ; $007F40
.loc_0046:
        TST.B  (-15598).W                       ; $007F42
        BEQ.S  .loc_0052                        ; $007F46
        CLR.B  (A2)                             ; $007F48
        CLR.B  (-15598).W                       ; $007F4A
.loc_0052:
        RTS                                     ; $007F4E
