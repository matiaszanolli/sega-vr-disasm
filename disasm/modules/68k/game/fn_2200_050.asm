; ============================================================================
; Objs 050 (auto-analyzed)
; ROM Range: $003540-$00359C (92 bytes)
; ============================================================================
; Category: object
; Purpose: RAM: $6950 (obj_flags)
;   Object (A0, A1): +$00, +$2C
;
; Entry: A0 = object/entity pointer
; Entry: A1 = object/entity pointer
; Uses: D0, A0, A1
; RAM:
;   $6950: obj_flags
; Object fields:
;   +$00: [unknown]
;   +$2C: [unknown]
; Confidence: medium
; ============================================================================

fn_2200_050:
        SUBQ.B  #1,(-15608).W                   ; $003540
        BNE.S  .loc_003A                        ; $003544
        MOVE.W  (-16242).W,D0                   ; $003546
        CMP.W  (-16262).W,D0                    ; $00354A
        BEQ.S  .loc_003A                        ; $00354E
        BTST    #5,(-15602).W                   ; $003550
        BNE.S  .loc_003A                        ; $003556
        MOVE.W  $002C(A0),D0                    ; $003558
        LEA     $008989EE,A1                    ; $00355C
        MOVE.B  $00(A1,D0.W),(-14171).W         ; $003562
        CMPI.L  #$222E0508,$00FF6948            ; $003568
        BNE.S  .loc_003A                        ; $003572
        MOVE.B  #$97,(-14171).W                 ; $003574
.loc_003A:
        MOVE.B  #$04,(-15611).W                 ; $00357A
        TST.W  (-16306).W                       ; $003580
        DC.W    $6716               ; BEQ.S  $00359C; $003584
        MOVE.B  #$00,$00FF6940                  ; $003586
        MOVE.B  #$00,$00FF6950                  ; $00358E
        ADDQ.B  #4,(-15611).W                   ; $003596
        RTS                                     ; $00359A
