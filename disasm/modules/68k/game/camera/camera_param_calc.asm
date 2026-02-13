; ============================================================================
; camera_param_calc — Camera Parameter Calculation
; ROM Range: $002984-$002A72 (238 bytes)
; ============================================================================
; Computes camera/view parameters from entity state. Reads positions and
; velocities from entity A0 (at $FF9000), computes scaled derivatives
; (ASR #3 = divide by 8), and stores results to camera parameter buffer
; A1 (at $FF6100). Parameters computed:
;   +$04: Lateral offset (from $009C, scaled, minus reference)
;   +$06: Vertical reference (from RAM $C034)
;   +$08/$0C: Height components (from $003A/$003C, with velocity $0044/$0046)
;   +$0A: Roll component (from $003C + $0096)
;   +$16: Speed indicator (from $0030)
;   +$18-$20: Position derivatives and acceleration
;   +$30/$32/$44/$46/$58: Rotation parameters (from $0090/$00BC)
;
; If entity has flag bit 3 at +$E5 and $C3AC is set, clears all primary
; parameters (zero-fill slots $00/$14/$28/$3C/$50/$64).
;
; Entry: Uses fixed addresses A0=$FF9000, A1=$FF6100
; Uses: D0, D1, A0, A1
; ============================================================================

camera_param_calc:
        LEA     (-28672).W,A0                   ; $002984
        LEA     $00FF6100,A1                    ; $002988
        TST.W  (-16308).W                       ; $00298E
        DC.W    $6600,$014A         ; BNE.W  $002ADE; $002992
        MOVE.W  $0030(A0),D0                    ; $002996
        MOVE.W  D0,$0016(A1)                    ; $00299A
        MOVE.W  $009C(A0),D0                    ; $00299E
        ASL.W  #4,D0                            ; $0029A2
        MOVE.W  D0,D1                           ; $0029A4
        SUB.W  (-16300).W,D1                    ; $0029A6
        NEG.W  D1                               ; $0029AA
        MOVE.W  D1,$0004(A1)                    ; $0029AC
        ADD.W  (-16156).W,D0                    ; $0029B0
        ADD.W  $0032(A0),D0                     ; $0029B4
        MOVE.W  D0,$0018(A1)                    ; $0029B8
        MOVE.W  (-16298).W,$0006(A1)            ; $0029BC
        MOVE.W  $0034(A0),D0                    ; $0029C2
        MOVE.W  D0,$001A(A1)                    ; $0029C6
        MOVE.W  $003A(A0),D0                    ; $0029CA
        ASR.W  #3,D0                            ; $0029CE
        MOVE.W  D0,D1                           ; $0029D0
        ADD.W  (-16184).W,D0                    ; $0029D2
        MOVE.W  D0,$0008(A1)                    ; $0029D6
        MOVE.W  $0044(A0),D0                    ; $0029DA
        ASR.W  #3,D0                            ; $0029DE
        ADD.W   D1,D0                           ; $0029E0
        NEG.W  D0                               ; $0029E2
        MOVE.W  D0,$001C(A1)                    ; $0029E4
        MOVE.W  $003C(A0),D0                    ; $0029E8
        ADD.W  $0096(A0),D0                     ; $0029EC
        ASR.W  #3,D0                            ; $0029F0
        MOVE.W  D0,D1                           ; $0029F2
        ADD.W  (-16182).W,D0                    ; $0029F4
        NEG.W  D0                               ; $0029F8
        MOVE.W  D0,$000A(A1)                    ; $0029FA
        MOVE.W  $0046(A0),D0                    ; $0029FE
        ASR.W  #3,D0                            ; $002A02
        SUB.W   D0,D1                           ; $002A04
        MOVE.W  D1,$001E(A1)                    ; $002A06
        MOVE.W  $003E(A0),D0                    ; $002A0A
        ASR.W  #3,D0                            ; $002A0E
        MOVE.W  D0,D1                           ; $002A10
        ADD.W  (-16180).W,D0                    ; $002A12
        MOVE.W  D0,$000C(A1)                    ; $002A16
        MOVE.W  $004A(A0),D0                    ; $002A1A
        ADD.W  $004C(A0),D0                     ; $002A1E
        ASR.W  #5,D0                            ; $002A22
        SUB.W   D1,D0                           ; $002A24
        MOVE.W  D0,$0020(A1)                    ; $002A26
        MOVE.W  $0090(A0),D0                    ; $002A2A
        ASR.W  #3,D0                            ; $002A2E
        MOVE.W  D0,$0032(A1)                    ; $002A30
        MOVE.W  D0,$0046(A1)                    ; $002A34
        MOVE.W  $00BC(A0),D0                    ; $002A38
        ASR.W  #3,D0                            ; $002A3C
        MOVE.W  D0,$0030(A1)                    ; $002A3E
        MOVE.W  D0,$0044(A1)                    ; $002A42
        MOVE.W  D0,$0058(A1)                    ; $002A46
        TST.B  (-15588).W                       ; $002A4A
        DC.W    $6722               ; BEQ.S  $002A72; $002A4E
        BTST    #3,$00E5(A0)                    ; $002A50
        DC.W    $671A               ; BEQ.S  $002A72; $002A56
        MOVEQ   #$00,D0                         ; $002A58
        MOVE.W  D0,(A1)                         ; $002A5A
        MOVE.W  D0,$0014(A1)                    ; $002A5C
        MOVE.W  D0,$0028(A1)                    ; $002A60
        MOVE.W  D0,$003C(A1)                    ; $002A64
        MOVE.W  D0,$0050(A1)                    ; $002A68
        MOVE.W  D0,$0064(A1)                    ; $002A6C
        RTS                                     ; $002A70
