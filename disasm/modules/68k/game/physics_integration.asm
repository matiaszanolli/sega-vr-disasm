; ============================================================================
; Physics Integration
; ROM Range: $00A666-$00A6F6 (144 bytes)
; ============================================================================
; Computes distance to target, derives a steering factor, calls ai_steering_calc
; to get a target heading angle, then smoothly interpolates toward it.
; Converts heading to velocity via sine/cosine and updates position.
;
; Entry: A0 = object/entity pointer
;        ($A000).W = target X coordinate (set by collision_avoidance setup)
;        ($A002).W = target Y coordinate (set by collision_avoidance setup)
; Uses: D0, D1, D2, D3, D6
; Calls: ai_steering_calc ($A7A0), sine_lookup ($8F52), cosine_lookup ($8F4E)
; Fields accessed:
;   A0+$06: Speed value (used as divisor)
;   A0+$30: X position (updated)
;   A0+$34: Y position (updated)
;   A0+$3C: Heading mirror (written)
;   A0+$40: Current heading angle (read/written)
;   A0+$54: Steering mode flags (bit 0 selects D6=2)
; ============================================================================

physics_integration:
        ; --- Compute Manhattan distance to target ---
        dc.w    $3038,$A000             ; MOVE.W ($A000).W,D0 - target X
        sub.w   $30(a0),d0              ; DX = target_x - pos_x
        bpl.s   .dx_pos                 ; If positive, skip negate
        neg.w   d0                      ; |DX|
.dx_pos:
        dc.w    $3238,$A002             ; MOVE.W ($A002).W,D1 - target Y
        sub.w   $34(a0),d1              ; DY = target_y - pos_y
        bpl.s   .dy_pos                 ; If positive, skip negate
        neg.w   d1                      ; |DY|
.dy_pos:
        add.w   d1,d0                   ; Distance = |DX| + |DY|
        ext.l   d0                      ; Sign-extend distance to long
        lsl.l   #4,d0                   ; Scale by 16

        ; --- Compute steering factor ---
        move.w  $6(a0),d1               ; Load speed
        addq.w  #1,d1                   ; Speed + 1 (avoid divide by zero)
        divs.w  d1,d0                   ; Frames to reach = distance*16 / speed
        move.w  d0,d6                   ; D6 = frame count
        asr.w   #1,d6                   ; D6 = frames/2
        bgt.s   .check_mode             ; If > 0, check steering mode
        moveq   #1,d6                   ; Minimum steering factor = 1
        bra.s   .setup_coords
.check_mode:
        move.w  $54(a0),d1              ; Load steering mode flags
        andi.w  #$0001,d1               ; Test bit 0
        beq.s   .setup_coords           ; If clear, use D6 as-is
        moveq   #2,d6                   ; Override: steering factor = 2

        ; --- Set up coordinates for steering calc ---
.setup_coords:
        move.w  $34(a0),d0              ; Current Y position
        move.w  $30(a0),d1              ; Current X position
        neg.w   d1                      ; Negate X (coordinate transform)
        dc.w    $3438,$A002             ; MOVE.W ($A002).W,D2 - target Y
        dc.w    $3638,$A000             ; MOVE.W ($A000).W,D3 - target X
        neg.w   d3                      ; Negate target X

        ; --- Compute target heading via steering calc ---
        jsr     ai_steering_calc(pc)    ; Returns heading angle in D0

        ; --- Interpolate heading ---
        sub.w   $40(a0),d0              ; Delta = target_heading - current_heading
        ext.l   d0                      ; Sign-extend for division
        divs.w  d6,d0                   ; Smooth interpolation by steering factor
        add.w   d0,$40(a0)              ; Apply delta to current heading
        move.w  $40(a0),d0              ; Load updated heading
        move.w  d0,$3C(a0)              ; Mirror to heading copy
        neg.w   d0                      ; Negate for sine lookup convention

        ; --- Convert heading to X velocity component ---
        dc.w    $4EBA,$E880             ; BSR.W sine_lookup ($8F52)
        muls.w  $6(a0),d0              ; Velocity = sin(heading) * speed
        asr.l   #8,d0                   ; Scale down (fixed-point >> 8)
        asr.w   #4,d0                   ; Further scale (>> 4)
        add.w   d0,$30(a0)              ; Update X position

        ; --- Convert heading to Y velocity component ---
        move.w  $40(a0),d0              ; Reload heading
        neg.w   d0                      ; Negate for cosine lookup convention
        dc.w    $4EBA,$E866             ; BSR.W cosine_lookup ($8F4E)
        muls.w  $6(a0),d0              ; Velocity = cos(heading) * speed
        asr.l   #8,d0                   ; Scale down (fixed-point >> 8)
        asr.w   #4,d0                   ; Further scale (>> 4)
        add.w   d0,$34(a0)              ; Update Y position
        rts
