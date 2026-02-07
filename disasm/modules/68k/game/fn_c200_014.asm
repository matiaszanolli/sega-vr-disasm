; ============================================================================
; Scene Camera 014 (auto-analyzed)
; ROM Range: $00CC74-$00CD4C (216 bytes)
; ============================================================================
; Category: game
; Purpose: RAM: $C048 (camera_state), $C89C (sh2_comm_state), $C8CC (race_substate), $C8C8 (vint_state)
;   Object (A0, A1): +$00, +$18, +$2A, +$76, +$78, +$A4
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, A0, A1, A2
; RAM:
;   $C048: camera_state
;   $C89C: sh2_comm_state
;   $C8C8: vint_state
;   $C8CC: race_substate
; Object fields:
;   +$00: [unknown]
;   +$18: [unknown]
;   +$2A: [unknown]
;   +$76: [unknown]
;   +$78: [unknown]
;   +$A4: [unknown]
;   +$A6: [unknown]
;   +$AC: [unknown]
; Confidence: medium
; ============================================================================

fn_c200_014:
        LEA     $008997EC,A1                    ; $00CC74
        LEA     $00(A1,D0.W),A1                 ; $00CC7A
        LEA     (-16244).W,A2                   ; $00CC7E
        JMP     $00884922                       ; $00CC82
        MOVE.B  (-343).W,(-15601).W             ; $00CC88
        LEA     (-28672).W,A0                   ; $00CC8E
        MOVE.B  #$00,(-14311).W                 ; $00CC92
        MOVE.W  (-16236).W,(-16262).W           ; $00CC98
        MOVE.B  #$00,(-15599).W                 ; $00CC9E
        MOVE.W  #$0001,(-16312).W               ; $00CCA4
        MOVE.B  #$04,(-15614).W                 ; $00CCAA
        MOVE.W  #$0000,(-16250).W               ; $00CCB0
        MOVE.W  #$0040,(-16156).W               ; $00CCB6
        LEA     $00898A04,A1                    ; $00CCBC
        MOVE.W  (-14180).W,D0                   ; $00CCC2
        MULU    #$0014,D0                       ; $00CCC6
        ADDA.L  D0,A1                           ; $00CCCA
        LEA     (-14592).W,A2                   ; $00CCCC
        JSR     $00884922                       ; $00CCD0
        MOVE.L  (A1),$0018(A0)                  ; $00CCD6
        MOVE.L  (A1),$00B2(A0)                  ; $00CCDA
        LEA     $00930612,A1                    ; $00CCDE
        MOVE.W  (-14132).W,D0                   ; $00CCE4
        MOVEA.L $00(A1,D0.W),A1                 ; $00CCE8
        MOVE.L  A1,(-15768).W                   ; $00CCEC
        LEA     $009305D6,A1                    ; $00CCF0
        MOVEA.L $00(A1,D0.W),A1                 ; $00CCF6
        LEA     (-14108).W,A2                   ; $00CCFA
        JSR     $00884922                       ; $00CCFE
        MOVE.W  #$0001,$002A(A0)                ; $00CD04
        MOVE.W  #$0001,$00A6(A0)                ; $00CD0A
        MOVE.W  #$000F,$00A4(A0)                ; $00CD10
        MOVE.W  #$0003,$00AC(A0)                ; $00CD16
        MOVE.W  #$0100,$0076(A0)                ; $00CD1C
        MOVE.W  #$0100,$0078(A0)                ; $00CD22
        MOVEQ   #$00,D0                         ; $00CD28
        MOVE.W  #$001E,(-16212).W               ; $00CD2A
        MOVE.B  #$14,(-14300).W                 ; $00CD30
        CMPI.W  #$0001,(-14136).W               ; $00CD36
        BNE.S  .loc_00D0                        ; $00CD3C
        MOVE.B  #$1E,(-14300).W                 ; $00CD3E
.loc_00D0:
        MOVE.W  #$FFFF,(-16294).W               ; $00CD44
        RTS                                     ; $00CD4A
