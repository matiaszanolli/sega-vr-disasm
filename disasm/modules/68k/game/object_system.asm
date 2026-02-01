; ============================================================================
; Object System - Position & Velocity Functions ($007xxx-$008xxx)
; ============================================================================
;
; PURPOSE
; -------
; Core physics and motion system for all game objects (cars, AI, projectiles).
; These functions are called 150+ times per frame and represent the primary
; 68K CPU budget consumers. Optimization targets for performance improvement.
;
; OBJECT STRUCTURE
; ----------------
; Each object occupies ~$A4 bytes at base address in A0. Key offsets:
;
; | Offset | Size | Name           | Purpose                        |
; |--------|------|----------------|--------------------------------|
; | $0004  | W    | speed_mult     | Speed multiplier               |
; | $0030  | L    | y_position     | Y world position (16.16 fixed) |
; | $0034  | L    | x_position     | X world position (16.16 fixed) |
; | $003A  | W    | cosine         | Cosine of heading              |
; | $003E  | W    | sine           | Sine of heading                |
; | $0044  | W    | y_velocity     | Y velocity component           |
; | $0046  | W    | x_velocity     | X velocity component           |
; | $004A  | W    | z_velocity     | Z velocity (vertical)          |
; | $004E  | W    | y_accel        | Y acceleration                 |
; | $0050  | W    | x_accel        | X acceleration                 |
; | $005A  | W    | base_angle     | Base heading angle             |
; | $005C  | W    | steer_angle_1  | Steering delta 1               |
; | $005E  | W    | steer_angle_2  | Steering delta 2               |
; | $006E  | W    | angular_vel    | Angular velocity (turn rate)   |
; | $0088  | W    | frame_timer    | Frame countdown timer          |
; | $008E  | W    | damping        | Velocity damping factor        |
; | $0092  | W    | type_flags     | Object type and state flags    |
; | $0094  | W    | turn_rate      | Maximum turn rate              |
; | $009E  | W    | screen_x       | Screen X coordinate            |
; | $00A0  | W    | screen_y       | Screen Y coordinate            |
; | $00A2  | W    | screen_z       | Screen Z (depth)               |
;
; CALL FREQUENCY (per frame)
; --------------------------
; angle_to_sine:      29 calls - Trig lookup
; load_object_params: 27 calls - Table lookup
; object_frame_timer: 22 calls - Timer tick
; calc_steering:      19 calls - Input processing
; obj_position_y/x:   18 calls each - Position update
; obj_velocity_y/x:   18 calls each - Velocity update
;
; TRIG TABLES
; -----------
; Sine table at $0093A02C: 1024 entries × 2 bytes = 2KB
; Cosine table at $0093A42C: 1024 entries × 2 bytes = 2KB
; Resolution: 360°/1024 ≈ 0.35° per entry
;
; Dependencies: Trig tables in ROM, object memory pool
; Related: HIGH_FREQUENCY_FUNCTIONS.md, DATA_STRUCTURES.md
; ============================================================================
; Format: Proper mnemonics with original bytes in comments for verification
; ============================================================================

; Object structure offset constants
OBJ_Y_POS       equ     $0030   ; Y position (long)
OBJ_X_POS       equ     $0034   ; X position (long)
OBJ_COSINE      equ     $003A   ; Cosine result (word)
OBJ_SINE        equ     $003E   ; Sine result (word)
OBJ_Y_VEL       equ     $0044   ; Y velocity (word)
OBJ_X_VEL       equ     $0046   ; X velocity (word)
OBJ_Y_ACCEL     equ     $004E   ; Y acceleration (word)
OBJ_X_ACCEL     equ     $0050   ; X acceleration (word)
OBJ_BASE_ANGLE  equ     $005A   ; Base heading angle (word)
OBJ_STEER1      equ     $005C   ; Steering angle 1 (word)
OBJ_STEER2      equ     $005E   ; Steering angle 2 (word)
OBJ_TIMER       equ     $0088   ; Frame timer (word)
OBJ_TURN_RATE   equ     $0094   ; Max turn rate (word)

; ROM table addresses
SINE_TABLE      equ     $0093A02C
COSINE_TABLE    equ     $0093A42C
PARAM_TABLE     equ     $00930000

; Angle constants
ANGLE_MASK      equ     $03FF   ; 10-bit angle (1024 values)
ANGLE_HALF      equ     $0200   ; 180 degrees
ANGLE_FULL      equ     $0400   ; 360 degrees

        org     $006F98

; ============================================================================
; calc_steering ($006F98) - Calculate Steering Angle
; Called by: 19 locations per frame (all steerable objects)
; Parameters: A0 = object base
; Returns: Updates object angles at $5A, $5C, $5E
; Cycles: ~180 cycles typical
; ============================================================================

calc_steering:
        move.w  OBJ_STEER1(a0),d0               ; $006F98: $3028 $005C - Get target angle
        sub.w   OBJ_BASE_ANGLE(a0),d0           ; $006F9C: $9068 $005A - Delta from base
        andi.w  #ANGLE_MASK,d0                  ; $006FA0: $0240 $03FF - Mask to 10 bits
        move.w  d0,d1                           ; $006FA4: $3200       - Copy for comparison
        cmpi.w  #ANGLE_HALF,d1                  ; $006FA6: $0C41 $0200 - > 180°?
        blt.s   .no_wrap                        ; $006FAA: $6D04       - Skip if < 180
        subi.w  #ANGLE_FULL,d0                  ; $006FAC: $0440 $0400 - Wrap to negative
.no_wrap:
        move.w  OBJ_TURN_RATE(a0),d1            ; $006FB0: $3228 $0094 - Get max turn rate
        cmp.w   d0,d1                           ; $006FB4: $B240       - Compare delta vs max
        blt.s   .limit_pos                      ; $006FB6: $6D06       - Clamp if > max
        neg.w   d1                              ; $006FB8: $4441       - Negate for min check
        cmp.w   d0,d1                           ; $006FBA: $B240       - Compare delta vs -max
        bgt.s   .apply_delta                    ; $006FBC: $6E02       - Skip if within range
.limit_pos:
        move.w  d1,d0                           ; $006FBE: $3001       - Clamp to limit
.apply_delta:
        add.w   d0,OBJ_BASE_ANGLE(a0)           ; $006FC0: $D168 $005A - Apply delta to angle
        move.w  OBJ_STEER2(a0),d0               ; $006FC4: $3028 $005E - Get steer_angle_2
        sub.w   OBJ_BASE_ANGLE(a0),d0           ; $006FC8: $9068 $005A - (unused calculation)
        andi.w  #ANGLE_MASK,d0                  ; $006FCC: $0240 $03FF
        move.w  OBJ_BASE_ANGLE(a0),OBJ_STEER1(a0) ; $006FD0: $3168 $005A $005C - Sync angles
        move.w  OBJ_BASE_ANGLE(a0),OBJ_STEER2(a0) ; $006FD6: $3168 $005A $005E
        rts                                     ; $006FDC: $4E75

; (Gap for other code $006FDE-$0070A9)

; ============================================================================
; angle_to_sine ($0070AA) - Trig Table Lookup
; Called by: 29 locations per frame (highest frequency function)
; Parameters: A0 = object base
; Returns: Updates object+$3A (cosine), object+$3E (sine)
; Cycles: ~120 cycles
;
; Algorithm:
;   1. Calculate angle delta = steer_angle - base_angle
;   2. If negative, negate angle and negate result
;   3. Mask to 10 bits (0-1023 range)
;   4. Look up in table (word index = angle * 2)
;   5. Store result to object structure
; ============================================================================

        org     $0070AA

angle_to_sine:
        lea     SINE_TABLE,a1                   ; $0070AA: $43F9 $0093 $A02C - Point to sine table
        move.w  OBJ_STEER1(a0),d0               ; $0070B0: $3028 $005C - Get steering angle
        sub.w   OBJ_BASE_ANGLE(a0),d0           ; $0070B4: $9068 $005A - Delta from base
        bmi.s   .sine_negative                  ; $0070B8: $6B08       - Handle negative
        andi.w  #ANGLE_MASK,d0                  ; $0070BA: $0240 $03FF - Mask to 10 bits
        add.w   d0,d0                           ; $0070BE: $D040       - *2 for word index
        move.w  (a1,d0.w),d1                    ; $0070C0: $3231 $0000 - Lookup sine value
        bra.s   .store_sine                     ; $0070C4: $6008       - Store result
.sine_negative:
        neg.w   d0                              ; $0070C6: $4440       - Make positive
        andi.w  #ANGLE_MASK,d0                  ; $0070C8: $0240 $03FF - Mask
        add.w   d0,d0                           ; $0070CC: $D040       - *2 for index
        move.w  (a1,d0.w),d1                    ; $0070CE: $3231 $0000 - Lookup
        neg.w   d1                              ; $0070D2: $4441       - Negate result
.store_sine:
        move.w  d1,OBJ_SINE(a0)                 ; $0070D4: $3141 $003E - Store sine

; Cosine lookup (similar pattern)
        lea     COSINE_TABLE,a1                 ; $0070D8: $43F9 $0093 $A42C - Cosine table
        move.w  OBJ_STEER2(a0),d0               ; $0070DE: $3028 $005E - Get angle 2
        sub.w   OBJ_BASE_ANGLE(a0),d0           ; $0070E2: $9068 $005A - Delta from base
        bmi.s   .cos_negative                   ; $0070E6: $6B08       - Handle negative
        andi.w  #ANGLE_MASK,d0                  ; $0070E8: $0240 $03FF - Mask
        add.w   d0,d0                           ; $0070EC: $D040       - *2 for index
        move.w  (a1,d0.w),d1                    ; $0070EE: $3231 $0000 - Lookup
        bra.s   .store_cosine                   ; $0070F2: $6008       - Store result
.cos_negative:
        neg.w   d0                              ; $0070F4: $4440       - Make positive
        andi.w  #ANGLE_MASK,d0                  ; $0070F6: $0240 $03FF - Mask
        add.w   d0,d0                           ; $0070FA: $D040       - *2 for index
        move.w  (a1,d0.w),d1                    ; $0070FC: $3231 $0000 - Lookup
.store_cosine:
        move.w  d1,OBJ_COSINE(a0)               ; $007100: $3141 $003A - Store cosine
        rts                                     ; $007104: $4E75

; ============================================================================
; obj_position_y ($007C4E) - Update Y Position from Velocity
; Called by: 18 locations per frame
; Parameters: A0 = object base
; Returns: Updates object+$30 (y_position)
;
; Formula: y_position += sign_extend(y_velocity)
; Uses 16.16 fixed point: high word = integer, low word = fraction
; ============================================================================

        org     $007C4E

obj_position_y:
        move.l  OBJ_Y_POS(a0),d0                ; $007C4E: $2028 $0030 - Get Y position
        move.w  OBJ_Y_VEL(a0),d1                ; $007C52: $3228 $0044 - Get Y velocity
        ext.l   d1                              ; $007C56: $48C1       - Sign extend to long
        add.l   d1,d0                           ; $007C58: $D081       - Add velocity
        move.l  d0,OBJ_Y_POS(a0)                ; $007C5A: $2140 $0030 - Store new position
        rts                                     ; $007C5E: $4E75

; ============================================================================
; obj_position_x ($007CD8) - Update X Position from Velocity
; Called by: 18 locations per frame
; Parameters: A0 = object base
; Returns: Updates object+$34 (x_position)
; ============================================================================

        org     $007CD8

obj_position_x:
        move.l  OBJ_X_POS(a0),d0                ; $007CD8: $2028 $0034 - Get X position
        move.w  OBJ_X_VEL(a0),d1                ; $007CDC: $3228 $0046 - Get X velocity
        ext.l   d1                              ; $007CE0: $48C1       - Sign extend
        add.l   d1,d0                           ; $007CE2: $D081       - Add velocity
        move.l  d0,OBJ_X_POS(a0)                ; $007CE4: $2140 $0034 - Store position
        rts                                     ; $007CE8: $4E75

; ============================================================================
; obj_velocity_y ($007E7A) - Apply Acceleration to Y Velocity
; Called by: 18 locations per frame
; Parameters: A0 = object base
; Returns: Updates object+$44 (y_velocity)
;
; Formula: y_velocity += y_accel
; ============================================================================

        org     $007E7A

obj_velocity_y:
        move.w  OBJ_Y_VEL(a0),d0                ; $007E7A: $3028 $0044 - Get velocity
        add.w   OBJ_Y_ACCEL(a0),d0              ; $007E7E: $D068 $004E - Add acceleration
        move.w  d0,OBJ_Y_VEL(a0)                ; $007E82: $3140 $0044 - Store result
        rts                                     ; $007E86: $4E75

; ============================================================================
; obj_velocity_x ($007F50) - Apply Acceleration to X Velocity
; Called by: 18 locations per frame
; Parameters: A0 = object base
; Returns: Updates object+$46 (x_velocity)
; ============================================================================

        org     $007F50

obj_velocity_x:
        move.w  OBJ_X_VEL(a0),d0                ; $007F50: $3028 $0046 - Get velocity
        add.w   OBJ_X_ACCEL(a0),d0              ; $007F54: $D068 $0050 - Add acceleration
        move.w  d0,OBJ_X_VEL(a0)                ; $007F58: $3140 $0046 - Store result
        rts                                     ; $007F5C: $4E75

; ============================================================================
; load_object_params ($0080CC) - Load Object Parameters from ROM Table
; Called by: 27 locations per frame (second highest frequency)
; Parameters: A0 = object destination, D0 = object type index
; Returns: Copies 8 words from parameter table to object
;
; Table structure: 256 entries × 4 bytes (pointers) at $00930000
; Each entry points to 16-byte parameter block
; ============================================================================

        org     $0080CC

load_object_params:
        movem.l d2-d3,-(sp)                     ; $0080CC: $48E7 $3000 - Save registers
        lea     PARAM_TABLE,a1                  ; $0080D0: $43F9 $0093 $0000 - Table base
        andi.w  #$00FF,d0                       ; $0080D6: $0240 $00FF - Mask to byte
        asl.w   #2,d0                           ; $0080DA: $E548       - *4 for pointer
        movea.l (a1,d0.w),a1                    ; $0080DC: $2271 $0000 - Get param pointer
        moveq   #7,d7                           ; $0080E0: $7E07       - 8 words to copy
.copy_loop:
        move.w  (a1)+,(a0)+                     ; $0080E2: $30D9       - Copy word
        dbra    d7,.copy_loop                   ; $0080E4: $51CF $FFFC - Loop
        movem.l (sp)+,d2-d3                     ; $0080E8: $4CDF $000C - Restore registers
        rts                                     ; $0080EC: $4E75

; ============================================================================
; object_frame_timer ($008170) - Decrement Frame Countdown Timer
; Called by: 22 locations per frame (third highest frequency)
; Parameters: A0 = object base
; Returns: D0 = 0 if timer expired, nonzero otherwise
;          Updates object+$88 (frame_timer)
;
; Usage: Objects use timers for animations, state transitions, etc.
; Timer decrements each frame until reaching zero.
; ============================================================================

        org     $008170

object_frame_timer:
        move.w  OBJ_TIMER(a0),d0                ; $008170: $3028 $0088 - Get timer
        beq.s   .already_zero                   ; $008174: $6706       - Skip if zero
        subq.w  #1,d0                           ; $008176: $5340       - Decrement
        move.w  d0,OBJ_TIMER(a0)                ; $008178: $3140 $0088 - Store back
        rts                                     ; $00817C: $4E75       - Return (D0 = new value)
.already_zero:
        clr.l   d0                              ; $00817E: $4280       - Return 0
        rts                                     ; $008180: $4E75

; ============================================================================
; timer_countdown_all ($008548) - Decrement 8 Independent Game Timers
; Called by: Game update loop (every object, every frame)
; Parameters: A0 = object base
; Returns: Nothing (timers decremented in place)
;
; Decrements 8 timer slots in the object structure. Each timer counts
; down from its initial value to 0, then stays at 0.
;
; Timer slots:
;   $0098 - Effect timer 1 (collision flash)
;   $009A - Effect timer 2 (collision flash)
;   $0086 - Animation timer
;   $0080 - State timer 1
;   $0082 - State timer 2
;   $0084 - State timer 3
;   $00E6 - Effect timer 3
;   $00E8 - Effect timer 4
;
; Pattern: TST.W timer → BLE skip → SUBQ #1 → skip:
; This handles negative values safely (BLE = signed less-or-equal)
; ============================================================================

; Timer offsets in object structure
OBJ_TIMER1      equ     $0098       ; Effect timer 1
OBJ_TIMER2      equ     $009A       ; Effect timer 2
OBJ_ANIM_TMR    equ     $0086       ; Animation timer
OBJ_STATE_TMR1  equ     $0080       ; State timer 1
OBJ_STATE_TMR2  equ     $0082       ; State timer 2
OBJ_STATE_TMR3  equ     $0084       ; State timer 3
OBJ_TIMER3      equ     $00E6       ; Effect timer 3
OBJ_TIMER4      equ     $00E8       ; Effect timer 4

        org     $008548

timer_countdown_all:
        tst.w   OBJ_TIMER1(a0)                  ; $008548: $4A68 $0098 - Check timer 1
        ble.s   .skip1                          ; $00854C: $6F04       - Skip if <= 0
        subq.w  #1,OBJ_TIMER1(a0)               ; $00854E: $5368 $0098 - Decrement
.skip1:
        tst.w   OBJ_TIMER2(a0)                  ; $008552: $4A68 $009A - Check timer 2
        ble.s   .skip2                          ; $008556: $6F04       - Skip if <= 0
        subq.w  #1,OBJ_TIMER2(a0)               ; $008558: $5368 $009A - Decrement
.skip2:
        tst.w   OBJ_ANIM_TMR(a0)                ; $00855C: $4A68 $0086 - Check anim timer
        ble.s   .skip3                          ; $008560: $6F04       - Skip if <= 0
        subq.w  #1,OBJ_ANIM_TMR(a0)             ; $008562: $5368 $0086 - Decrement
.skip3:
        tst.w   OBJ_STATE_TMR1(a0)              ; $008566: $4A68 $0080 - Check state timer 1
        ble.s   .skip4                          ; $00856A: $6F04       - Skip if <= 0
        subq.w  #1,OBJ_STATE_TMR1(a0)           ; $00856C: $5368 $0080 - Decrement
.skip4:
        tst.w   OBJ_STATE_TMR2(a0)              ; $008570: $4A68 $0082 - Check state timer 2
        ble.s   .skip5                          ; $008574: $6F04       - Skip if <= 0
        subq.w  #1,OBJ_STATE_TMR2(a0)           ; $008576: $5368 $0082 - Decrement
.skip5:
        tst.w   OBJ_STATE_TMR3(a0)              ; $00857A: $4A68 $0084 - Check state timer 3
        ble.s   .skip6                          ; $00857E: $6F04       - Skip if <= 0
        subq.w  #1,OBJ_STATE_TMR3(a0)           ; $008580: $5368 $0084 - Decrement
.skip6:
        tst.w   OBJ_TIMER3(a0)                  ; $008584: $4A68 $00E6 - Check timer 3
        ble.s   .skip7                          ; $008588: $6F04       - Skip if <= 0
        subq.w  #1,OBJ_TIMER3(a0)               ; $00858A: $5368 $00E6 - Decrement
.skip7:
        tst.w   OBJ_TIMER4(a0)                  ; $00858E: $4A68 $00E8 - Check timer 4
        ble.s   .done                           ; $008592: $6F04       - Skip if <= 0
        subq.w  #1,OBJ_TIMER4(a0)               ; $008594: $5368 $00E8 - Decrement
.done:
        rts                                     ; $008598: $4E75

; ============================================================================
; OPTIMIZATION NOTES
; ------------------
; These functions consume ~40% of 68K frame budget (127,987 cycles total).
;
; Potential optimizations:
; 1. Inline angle_to_sine - Called right after calc_steering usually
; 2. Batch position updates - Process multiple objects in single loop
; 3. Precompute trig for AI - AI has predictable steering patterns
; 4. SH2 offload - Move physics to Slave SH2 during render wait
;
; Current bottleneck: Blocking SH2 sync in sh2_send_cmd_wait prevents
; parallel processing. See ARCHITECTURAL_BOTTLENECK_ANALYSIS.md
; ============================================================================
