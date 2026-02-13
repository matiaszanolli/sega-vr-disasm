; ============================================================================
; AI Steering Angle + Distance Computation
; ROM Range: $008EFC-$008F4E (82 bytes)
; ============================================================================
; Category: game
; Purpose: Computes AI steering angle: loads target position ($C0BA/$C0BE),
;   calls ai_steering_calc ($00A7A0) with object position (A0+$30/$34).
;   Subtracts $4000 (90°) and negates for cosine angle, calls
;   cosine_lookup ($008F4E). Computes forward distance ratio:
;   (Y_diff × 256) / cosine, multiplied by VDP scale ($FF5000),
;   stored to $C0C6.
;
; Uses: D0, D1, D2, D3, A0
; RAM:
;   $C0BA: target_x (word)
;   $C0BE: target_y (word)
;   $C0C6: forward_distance (word)
; Calls:
;   $008F4E: cosine_lookup
;   $00A7A0: ai_steering_calc
; Object (A0):
;   +$30: x_position (word)
;   +$34: y_position (word)
; ============================================================================

ai_steering_angle_distance_calc:
        move.w  ($FFFFC0BA).w,D0                ; $008EFC  D0 = target_x
        move.w  ($FFFFC0BE).w,D1                ; $008F00  D1 = target_y
        move.w  $0030(A0),D2                    ; $008F04  D2 = object X
        move.w  $0034(A0),D3                    ; $008F08  D3 = object Y
        dc.w    $4EBA,$1892                     ; $008F0C  jsr $00A7A0(pc) — ai_steering_calc
        subi.w  #$4000,D0                       ; $008F10  D0 -= 90° (→ cosine)
        neg.w   D0                              ; $008F14  negate
        move.w  D0,D3                           ; $008F16  D3 = angle
        dc.w    $4EBA,$0034                     ; $008F18  jsr $008F4E(pc) — cosine_lookup
        move.w  $0030(A0),D2                    ; $008F1C  D2 = object X
        sub.w   ($FFFFC0BA).w,D2                ; $008F20  D2 -= target_x
        cmpi.w  #$C000,D3                       ; $008F24  angle == $C000?
        bne.s   .check_cos                      ; $008F28  no → check cosine
        neg.w   D2                              ; $008F2A  negate X diff
.check_cos:
        tst.w   D0                              ; $008F2C  cosine zero?
        beq.s   .done                           ; $008F2E  yes → skip divide
        move.w  $0034(A0),D2                    ; $008F30  D2 = object Y
        sub.w   ($FFFFC0BE).w,D2                ; $008F34  D2 -= target_y
        ext.l   D2                              ; $008F38  sign-extend
        asl.l   #8,D2                           ; $008F3A  D2 × 256
        divs    D0,D2                           ; $008F3C  D2 /= cosine
        bmi.s   .done                           ; $008F3E  negative → done
        move.w  $00FF5000,D3                    ; $008F40  D3 = VDP scale
        mulu    D3,D2                           ; $008F46  D2 × scale
        move.w  D2,($FFFFC0C6).w                ; $008F48  store forward_distance
.done:
        rts                                     ; $008F4C

