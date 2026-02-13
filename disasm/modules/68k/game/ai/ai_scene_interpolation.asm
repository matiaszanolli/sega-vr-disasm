; ============================================================================
; AI Scene Interpolation (6 Components)
; ROM Range: $00BD2A-$00BD9E (116 bytes)
; ============================================================================
; Interpolates 6 component values between two keyframes using
; scene_state as the interpolation factor. Source keyframe is at
; (A0)+2, target keyframe is found by scanning backwards through
; -$10 offsets skipping entries with type byte $0C. Each component
; is computed as: result = start + (end - start) × frame / total.
;
; Entry: A0 = keyframe data pointer (+$01 = total frames, +$02 = end values)
; Uses: D0, D1, D2, A0, A1, A2
; RAM:
;   $C054: interp_result_1
;   $C056: interp_result_2
;   $C086: interp_result_0
;   $C0AE: interp_result_3
;   $C0B0: interp_result_4
;   $C0B2: interp_result_5
;   $C8AA: scene_state (interpolation frame counter)
; ============================================================================

ai_scene_interpolation:
        moveq   #$00,d2
        move.b  $0001(a0),d2                    ; total frames for interpolation
        addq.w  #1,d2                           ; +1 (denominator)
        move.w  ($FFFFC8AA).w,d0                ; scene_state (current frame)
        lea     $0002(a0),a2                    ; end values pointer
        lea     (a2),a1                         ; copy for scan start
; --- find start keyframe (scan backwards, skip type $0C) ---
.scan_prev:
        lea     -$0010(a1),a1                   ; step back $10 bytes
        cmpi.b  #$0C,-$0002(a1)                 ; type byte = $0C?
        beq.s   .scan_prev                       ; yes → skip, continue scan
; --- interpolate 6 components ---
        move.w  (a2)+,d1                        ; end value 0
        sub.w   (a1),d1                         ; delta = end - start
        muls    d0,d1                           ; delta × current frame
        divs    d2,d1                           ; ÷ total frames
        add.w   (a1)+,d1                        ; + start value
        move.w  d1,($FFFFC086).w                ; store interp_result_0

        move.w  (a2)+,d1                        ; end value 1
        sub.w   (a1),d1
        muls    d0,d1
        divs    d2,d1
        add.w   (a1)+,d1
        move.w  d1,($FFFFC054).w                ; store interp_result_1

        move.w  (a2)+,d1                        ; end value 2
        sub.w   (a1),d1
        muls    d0,d1
        divs    d2,d1
        add.w   (a1)+,d1
        move.w  d1,($FFFFC056).w                ; store interp_result_2

        move.w  (a2)+,d1                        ; end value 3
        sub.w   (a1),d1
        muls    d0,d1
        divs    d2,d1
        add.w   (a1)+,d1
        move.w  d1,($FFFFC0AE).w                ; store interp_result_3

        move.w  (a2)+,d1                        ; end value 4
        sub.w   (a1),d1
        muls    d0,d1
        divs    d2,d1
        add.w   (a1)+,d1
        move.w  d1,($FFFFC0B0).w                ; store interp_result_4

        move.w  (a2)+,d1                        ; end value 5
        sub.w   (a1),d1
        muls    d0,d1
        divs    d2,d1
        add.w   (a1)+,d1
        move.w  d1,($FFFFC0B2).w                ; store interp_result_5
        rts
