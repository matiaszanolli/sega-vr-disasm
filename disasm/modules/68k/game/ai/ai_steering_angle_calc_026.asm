; ============================================================================
; AI Steering Angle Calc 026
; ROM Range: $008D62-$008DC0 (94 bytes)
; ============================================================================
; Category: game
; Purpose: Calculates steering angle from position delta + cosine lookup
;   Calls ai_steering_calc, cosine_lookup, then computes final angle
;
; Entry: A0 = object/entity pointer
; Uses: D0, D1, D2, D3, A0
; RAM:
;   $C0BA: waypoint_x
;   $C0BC: waypoint_z
;   $C0BE: waypoint_y
;   $C0C0: steering_angle
;   $C0C2: angle_temp
; Calls:
;   $00A7A0: ai_steering_calc
;   $008F4E: cosine_lookup
;   $00A7A4: ai_angle_finalize
; Object fields (A0):
;   +$30: x_position
;   +$32: z_position
;   +$34: y_position
; Confidence: medium
; ============================================================================

ai_steering_angle_calc_026:
        move.w  ($FFFFC0BA).w,D0                ; $008D62  D0 = waypoint_x
        move.w  ($FFFFC0BE).w,D1                ; $008D66  D1 = waypoint_y
        move.w  $0030(A0),D2                    ; $008D6A  D2 = obj.x_position
        move.w  $0034(A0),D3                    ; $008D6E  D3 = obj.y_position
        dc.w    $4EBA,$1A2C         ; JSR     $00A7A0(PC); $008D72  ai_steering_calc
        subi.w  #$4000,D0                       ; $008D76  D0 -= $4000 (quarter turn)
        neg.w   D0                              ; $008D7A  D0 = -D0
        move.w  D0,($FFFFC0C2).w                ; $008D7C  angle_temp = D0
        dc.w    $4EBA,$01CC         ; JSR     $008F4E(PC); $008D80  cosine_lookup
        move.w  $0030(A0),D2                    ; $008D84  D2 = obj.x_position
        sub.w   ($FFFFC0BA).w,D2                ; $008D88  D2 -= waypoint_x (delta_x)
        cmpi.w  #$C000,($FFFFC0C2).w            ; $008D8C  angle_temp == $C000?
        bne.s   .no_negate                      ; $008D92  no → skip
        neg.w   D2                              ; $008D94  negate delta_x
.no_negate:
        tst.w   D0                              ; $008D96  cosine == 0?
        beq.s   .calc_z                         ; $008D98  yes → skip division
        move.w  $0034(A0),D2                    ; $008D9A  D2 = obj.y_position
        sub.w   ($FFFFC0BE).w,D2                ; $008D9E  D2 -= waypoint_y (delta_y)
        ext.l   D2                              ; $008DA2  sign-extend to long
        asl.l   #8,D2                           ; $008DA4  D2 <<= 8 (fixed-point)
        divs    D0,D2                           ; $008DA6  D2 = delta_y / cosine
.calc_z:
        move.w  $0032(A0),D3                    ; $008DA8  D3 = obj.z_position
        sub.w   ($FFFFC0BC).w,D3                ; $008DAC  D3 -= waypoint_z
        asr.w   #4,D3                           ; $008DB0  D3 >>= 4
        move.w  D2,D2                           ; $008DB2  (no-op, original code)
        dc.w    $4EBA,$19EE         ; JSR     $00A7A4(PC); $008DB4  ai_angle_finalize
        neg.w   D0                              ; $008DB8  D0 = -D0
        move.w  D0,($FFFFC0C0).w                ; $008DBA  steering_angle = D0
        rts                                     ; $008DBE
