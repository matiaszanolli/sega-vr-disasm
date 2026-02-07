; ============================================================================
; Gfx Camera 026 (auto-analyzed)
; ROM Range: $00B770-$00B7E6 (118 bytes)
; ============================================================================
; Category: graphics
; Purpose: RAM: $C048 (camera_state), $C0A2 (gfx_mode), $C972 (anim_state)
;   Object (A1): +$00
;
; Entry: A1 = object/entity pointer
; Uses: D0, A0, A1, A2
; RAM:
;   $C048: camera_state
;   $C0A2: gfx_mode
;   $C972: anim_state
; Object fields:
;   +$00: [unknown]
; Confidence: high
; ============================================================================

fn_a200_026:
        LEA     $00FF6344,A2                    ; $00B770
        CMPA.W  #$9000,A0                       ; $00B776
        BNE.S  .loc_0012                        ; $00B77A
        LEA     $00FF6114,A2                    ; $00B77C
.loc_0012:
        MOVE.W  (-16312).W,D0                   ; $00B782
        DC.W    $D040                           ; $00B786
        LEA     (-16222).W,A1                   ; $00B788
        ADDQ.W  #1,$00(A1,D0.W)                 ; $00B78C
        TST.B  (-16284).W                       ; $00B790
        DC.W    $6658               ; BNE.S  $00B7EE; $00B794
        MOVE.W  (-16312).W,D0                   ; $00B796
        DC.W    $D040                           ; $00B79A
        DC.W    $D040                           ; $00B79C
        CMP.B  (-15614).W,D0                    ; $00B79E
        DC.W    $6656               ; BNE.S  $00B7FA; $00B7A2
        MOVE.W  (-13966).W,D0                   ; $00B7A4
        TST.B  (-15596).W                       ; $00B7A8
        DC.W    $6738               ; BEQ.S  $00B7E6; $00B7AC
        BTST    #10,D0                          ; $00B7AE
        BEQ.S  .loc_004C                        ; $00B7B2
        MOVE.W  #$0001,(-16312).W               ; $00B7B4
        BRA.S  .loc_0074                        ; $00B7BA
.loc_004C:
        BTST    #9,D0                           ; $00B7BC
        BEQ.S  .loc_005A                        ; $00B7C0
        MOVE.W  #$0002,(-16312).W               ; $00B7C2
        BRA.S  .loc_0074                        ; $00B7C8
.loc_005A:
        BTST    #8,D0                           ; $00B7CA
        BEQ.S  .loc_0068                        ; $00B7CE
        MOVE.W  #$0003,(-16312).W               ; $00B7D0
        BRA.S  .loc_0074                        ; $00B7D6
.loc_0068:
        BTST    #5,D0                           ; $00B7D8
        BEQ.S  .loc_0074                        ; $00B7DC
        MOVE.W  #$0000,(-16312).W               ; $00B7DE
.loc_0074:
        RTS                                     ; $00B7E4
