; ============================================================================
; State Dispatch 042 (auto-analyzed)
; ROM Range: $009B82-$009C9C (282 bytes)
; ============================================================================
; Category: game
; Purpose: State dispatcher using jump table
;   Object (A0): +$04 (speed_index/velocity), +$80, +$82, +$84, +$86, +$98
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, A0
; Object fields:
;   +$04: speed_index/velocity
;   +$80: [unknown]
;   +$82: [unknown]
;   +$84: [unknown]
;   +$86: [unknown]
;   +$98: [unknown]
;   +$9A: [unknown]
;   +$BE: [unknown]
; Confidence: low
; ============================================================================

fn_8200_042:
        MOVE.W  $0080(A0),D1                    ; $009B82
        CMPI.W  #$0007,D1                       ; $009B86
        BGT.S  .loc_0014                        ; $009B8A
        MOVE.W  $0082(A0),D1                    ; $009B8C
        CMPI.W  #$0007,D1                       ; $009B90
        BLE.S  .loc_001C                        ; $009B94
.loc_0014:
        MOVEQ   #$0F,D0                         ; $009B96
        DC.W    $9041                           ; $009B98
        MOVE.W  D0,(-16372).W                   ; $009B9A
.loc_001C:
        MOVE.W  $0084(A0),D0                    ; $009B9E
        BEQ.S  .loc_0030                        ; $009BA2
        CMPI.W  #$000A,D0                       ; $009BA4
        BGT.S  .loc_0030                        ; $009BA8
        MOVEQ   #$0A,D1                         ; $009BAA
        DC.W    $9240                           ; $009BAC
        MOVE.W  D1,(-16360).W                   ; $009BAE
.loc_0030:
        CMPI.W  #$0014,$0004(A0)                ; $009BB2
        BLE.S  .loc_007A                        ; $009BB8
        MOVE.W  $0098(A0),D0                    ; $009BBA
        BEQ.S  .loc_0056                        ; $009BBE
        ADDQ.W  #1,(-16354).W                   ; $009BC0
        ANDI.W  #$0003,(-16354).W               ; $009BC4
        CMPI.W  #$0078,$0004(A0)                ; $009BCA
        BGT.S  .loc_005C                        ; $009BD0
        ADDQ.W  #4,(-16354).W                   ; $009BD2
        BRA.S  .loc_005C                        ; $009BD6
.loc_0056:
        MOVE.W  #$FFFF,(-16354).W               ; $009BD8
.loc_005C:
        MOVE.W  $009A(A0),D1                    ; $009BDE
        BEQ.S  .loc_0080                        ; $009BE2
        ADDQ.W  #1,(-16348).W                   ; $009BE4
        ANDI.W  #$0003,(-16348).W               ; $009BE8
        CMPI.W  #$0078,$0004(A0)                ; $009BEE
        BGT.S  .loc_0086                        ; $009BF4
        ADDQ.W  #4,(-16348).W                   ; $009BF6
        BRA.S  .loc_0086                        ; $009BFA
.loc_007A:
        MOVE.W  #$FFFF,(-16354).W               ; $009BFC
.loc_0080:
        MOVE.W  #$FFFF,(-16348).W               ; $009C02
.loc_0086:
        CMPI.W  #$0014,$0004(A0)                ; $009C08
        BLE.S  .loc_00D0                        ; $009C0E
        MOVE.W  $00E6(A0),D0                    ; $009C10
        BEQ.S  .loc_00AC                        ; $009C14
        ADDQ.W  #1,(-16370).W                   ; $009C16
        ANDI.W  #$0003,(-16370).W               ; $009C1A
        CMPI.W  #$0078,$0004(A0)                ; $009C20
        BGT.S  .loc_00B2                        ; $009C26
        ADDQ.W  #4,(-16370).W                   ; $009C28
        BRA.S  .loc_00B2                        ; $009C2C
.loc_00AC:
        MOVE.W  #$FFFF,(-16370).W               ; $009C2E
.loc_00B2:
        MOVE.W  $00E8(A0),D1                    ; $009C34
        BEQ.S  .loc_00D6                        ; $009C38
        ADDQ.W  #1,(-16368).W                   ; $009C3A
        ANDI.W  #$0003,(-16368).W               ; $009C3E
        CMPI.W  #$0078,$0004(A0)                ; $009C44
        BGT.S  .loc_00DC                        ; $009C4A
        ADDQ.W  #4,(-16368).W                   ; $009C4C
        BRA.S  .loc_00DC                        ; $009C50
.loc_00D0:
        MOVE.W  #$FFFF,(-16370).W               ; $009C52
.loc_00D6:
        MOVE.W  #$FFFF,(-16368).W               ; $009C58
.loc_00DC:
        MOVE.W  $00BE(A0),D0                    ; $009C5E
        DC.W    $D040                           ; $009C62
        JMP     $009C68(PC,D0.W)                ; $009C64
        BRA.S  .loc_00EA                        ; $009C68
        BRA.S  .loc_0102                        ; $009C6A
.loc_00EA:
        CMPI.W  #$0007,$0086(A0)                ; $009C6C
        BLE.S  .loc_0118                        ; $009C72
        MOVEQ   #$0F,D1                         ; $009C74
        SUB.W  $0086(A0),D1                     ; $009C76
        DC.W    $D241                           ; $009C7A
        MOVE.W  $009C9C(PC,D1.W),(-16366).W     ; $009C7C
        BRA.S  .loc_0118                        ; $009C82
.loc_0102:
        CMPI.W  #$0000,$0086(A0)                ; $009C84
        BLE.S  .loc_0118                        ; $009C8A
        MOVEQ   #$0F,D1                         ; $009C8C
        SUB.W  $0086(A0),D1                     ; $009C8E
        DC.W    $D241                           ; $009C92
        MOVE.W  $009CAE(PC,D1.W),(-16366).W     ; $009C94
.loc_0118:
        RTS                                     ; $009C9A
