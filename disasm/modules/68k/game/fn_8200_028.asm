; ============================================================================
; AI Steering Calculation + Negate
; ROM Range: $008EB6-$008ED6 (32 bytes)
; ============================================================================
; Category: game
; Purpose: Calculates relative angle between viewport and object position,
;   subtracts quarter turn ($4000), negates result → stores as heading in $C0C2.
;   Similar to fn_8200_029 but uses $C0BA/$C0BE viewport instead of direct obj fields.
;
; Entry: A0 = object pointer
; Uses: D0, D1, D2, D3
; Calls:
;   $00A7A0: ai_steering_calc (D0=refX, D1=refY, D2=objX, D3=objY → D0=angle)
; RAM:
;   $C0BA: viewport X reference (word)
;   $C0BE: viewport Y reference (word)
;   $C0C2: calculated heading result (word)
; Object fields:
;   +$30: x_position (word)
;   +$34: y_position (word)
; ============================================================================

fn_8200_028:
        move.w  ($FFFFC0BA).w,D0                ; $008EB6  D0 = viewport X
        move.w  ($FFFFC0BE).w,D1                ; $008EBA  D1 = viewport Y
        move.w  $0030(A0),D2                    ; $008EBE  D2 = object X
        move.w  $0034(A0),D3                    ; $008EC2  D3 = object Y
        dc.w    $4EBA,$18D8                     ; $008EC6  bsr.w ai_steering_calc ($00A7A0)
        subi.w  #$4000,D0                       ; $008ECA  subtract quarter turn
        neg.w   D0                              ; $008ECE  negate angle
        move.w  D0,($FFFFC0C2).w                ; $008ED0  store heading result
        rts                                     ; $008ED4
