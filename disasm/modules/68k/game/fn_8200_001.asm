; ============================================================================
; Display 001 (auto-analyzed)
; ROM Range: $008200-$008246 (70 bytes)
; ============================================================================
; Category: display
; Purpose: RAM: $6960 (display_state_flag)
;   Object (A0): +$02 (flags/type)
;
; Entry: A0 = object/entity pointer
; Uses: D0, D4, A0, A4
; RAM:
;   $6960: display_state_flag
; Object fields:
;   +$02: flags/type
; Confidence: medium
; ============================================================================

fn_8200_001:
        AND.L  -(A4),D4                         ; $008200
        BEQ.S  .loc_000A                        ; $008202
        MOVE.B  #$BF,(-14172).W                 ; $008204
.loc_000A:
        TST.W  (-16306).W                       ; $00820A
        DC.W    $6744               ; BEQ.S  $008254; $00820E
        MOVEQ   #$00,D0                         ; $008210
        SUBQ.W  #1,(-16306).W                   ; $008212
        BEQ.S  .loc_0022                        ; $008216
        BTST    #2,(-14165).W                   ; $008218
        BNE.S  .loc_0022                        ; $00821E
        MOVEQ   #$01,D0                         ; $008220
.loc_0022:
        MOVE.B  D0,$00FF6960                    ; $008222
        TST.B  (-15611).W                       ; $008228
        DC.W    $6626               ; BNE.S  $008254; $00822C
        CMPI.W  #$003C,(-16306).W               ; $00822E
        DC.W    $661E               ; BNE.S  $008254; $008234
        BTST    #1,$0002(A0)                    ; $008236
        DC.W    $6708               ; BEQ.S  $008246; $00823C
        ANDI.W  #$FDFF,$0002(A0)                ; $00823E
        RTS                                     ; $008244
