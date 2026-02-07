; ============================================================================
; Trigonometry Lookup Functions ($0070AA - $007148)
; ============================================================================
;
; PURPOSE
; -------
; High-frequency sine/cosine lookup and velocity calculations for objects.
; Called 29 times per frame - the most frequently called function in the game.
;
; TRIG TABLE SYSTEM
; -----------------
; Two 1024-entry tables in ROM:
; - Sine table at $0093A02C (1024 words = 2KB)
; - Cosine table at $0093A42C (1024 words = 2KB)
;
; Each table covers 360 degrees in 1024 steps (0.35 degrees per step).
; Values are signed 16-bit fixed-point.
;
; OBJECT STRUCTURE OFFSETS (for this function)
; --------------------------------------------
; | Offset | Size | Purpose                              |
; |--------|------|--------------------------------------|
; | $0004  | W    | Scaling factor                       |
; | $003A  | W    | Cosine result                        |
; | $003E  | W    | Sine result                          |
; | $0044  | W    | Copied from $009E                    |
; | $0046  | W    | Calculated velocity component        |
; | $004A  | W    | Speed-adjusted value                 |
; | $004C  | W    | Final velocity component             |
; | $005A  | W    | Reference angle                      |
; | $005C  | W    | Y-axis angle                         |
; | $005E  | W    | X-axis angle                         |
; | $006E  | W    | Speed base value                     |
; | $008E  | W    | Rotation speed                       |
; | $0094  | W    | Velocity modifier                    |
; | $009E  | W    | Position offset                      |
; | $00A0  | W    | Mode flag                            |
; | $00A2  | W    | Acceleration factor                  |
;
; ALGORITHM
; ---------
; 1. Calculate angle difference (obj+$5C - obj+$5A)
; 2. Look up sine, store at obj+$3E
; 3. Calculate angle difference (obj+$5E - obj+$5A)
; 4. Look up cosine, store at obj+$3A
; 5. Calculate velocity components using rotation and speed
; 6. Apply scaling and store final values
;
; Dependencies: Sine/cosine ROM tables
; Related: calc_steering, obj_velocity_y/x
; ============================================================================
; Format: Proper mnemonics with original bytes in comments for verification
; ============================================================================

; ROM table addresses
SINE_TABLE      equ     $0093A02C   ; 1024-entry sine table
COSINE_TABLE    equ     $0093A42C   ; 1024-entry cosine table

; Table mask (1024 entries = 10 bits)
TABLE_MASK      equ     $03FF       ; 0-1023 range

; Object structure offsets
OBJ_SCALE       equ     $0004       ; Scaling factor
OBJ_COS_RESULT  equ     $003A       ; Cosine lookup result
OBJ_SIN_RESULT  equ     $003E       ; Sine lookup result
OBJ_POS_COPY    equ     $0044       ; Copied position value
OBJ_VEL_COMP1   equ     $0046       ; Velocity component 1
OBJ_SPEED_ADJ   equ     $004A       ; Speed-adjusted value
OBJ_VEL_COMP2   equ     $004C       ; Velocity component 2
OBJ_REF_ANGLE   equ     $005A       ; Reference angle
OBJ_Y_ANGLE     equ     $005C       ; Y-axis angle
OBJ_X_ANGLE     equ     $005E       ; X-axis angle
OBJ_SPEED_BASE  equ     $006E       ; Speed base
OBJ_ROT_SPEED   equ     $008E       ; Rotation speed
OBJ_VEL_MOD     equ     $0094       ; Velocity modifier
OBJ_POS_OFFSET  equ     $009E       ; Position offset
OBJ_MODE_FLAG   equ     $00A0       ; Mode flag
OBJ_ACCEL       equ     $00A2       ; Acceleration

; ============================================================================
; angle_to_sine ($0070AA) - Trig Lookup and Velocity Calculation
; Called by: 29 locations per frame (highest frequency function)
; Parameters:
;   A0 = Object base pointer
; Returns:
;   Object offsets $3A, $3E, $44, $46, $4A, $4C updated with trig/velocity
; ============================================================================

angle_to_sine:
; Load sine table address
        lea     SINE_TABLE,a1                   ; $0070AA: $43F9 $0093 $A02C - Sine table

; Calculate Y-axis angle difference
        move.w  OBJ_Y_ANGLE(a0),d0              ; $0070B0: $3028 $005C - D0 = Y angle
        sub.w   OBJ_REF_ANGLE(a0),d0            ; $0070B4: $9068 $005A - D0 -= reference
        add.w   d0,d0                           ; $0070B8: $D040       - D0 *= 2 (word index)
        bmi.s   .sin_negative                   ; $0070BA: $6B0A       - Branch if negative

; Positive angle path
        andi.w  #TABLE_MASK,d0                  ; $0070BC: $0240 $03FF - Mask to 10 bits
        move.w  (a1,d0.w),d0                    ; $0070C0: $3031 $0000 - Look up sine
        bra.s   .sin_store                      ; $0070C4: $600C       - Store result

.sin_negative:
; Negative angle: negate, lookup, negate result
        neg.w   d0                              ; $0070C6: $4440       - Negate angle
        andi.w  #TABLE_MASK,d0                  ; $0070C8: $0240 $03FF - Mask
        move.w  (a1,d0.w),d0                    ; $0070CC: $3031 $0000 - Look up
        neg.w   d0                              ; $0070D0: $4440       - Negate result

.sin_store:
        move.w  d0,OBJ_SIN_RESULT(a0)           ; $0070D2: $3140 $003E - Store sine

; Load cosine table address
        lea     COSINE_TABLE,a1                 ; $0070D6: $43F9 $0093 $A42C - Cosine table

; Calculate X-axis angle difference
        move.w  OBJ_X_ANGLE(a0),d0              ; $0070DC: $3028 $005E - D0 = X angle
        sub.w   OBJ_REF_ANGLE(a0),d0            ; $0070E0: $9068 $005A - D0 -= reference
        add.w   d0,d0                           ; $0070E4: $D040       - D0 *= 2
        bmi.s   .cos_negative                   ; $0070E6: $6B0A       - Branch if negative

; Positive angle path
        andi.w  #TABLE_MASK,d0                  ; $0070E8: $0240 $03FF - Mask
        move.w  (a1,d0.w),d0                    ; $0070EC: $3031 $0000 - Look up cosine
        bra.s   .cos_store                      ; $0070F0: $600C       - Store result

.cos_negative:
; Negative angle path
        neg.w   d0                              ; $0070F2: $4440       - Negate angle
        andi.w  #TABLE_MASK,d0                  ; $0070F4: $0240 $03FF - Mask
        move.w  (a1,d0.w),d0                    ; $0070F8: $3031 $0000 - Look up
        neg.w   d0                              ; $0070FC: $4440       - Negate result

.cos_store:
        move.w  d0,OBJ_COS_RESULT(a0)           ; $0070FE: $3140 $003A - Store cosine

; Copy position offset
        move.w  OBJ_ROT_SPEED(a0),d0            ; $007102: $3028 $008E - D0 = rotation speed
        neg.w   d0                              ; $007106: $4440       - Negate
        muls.w  OBJ_SCALE(a0),d0                ; $007108: $C1E8 $0004 - D0 *= scale
        moveq   #15,d1                          ; $00710C: $720F       - D1 = 15 (shift count)
        asr.l   d1,d0                           ; $00710E: $E2A0       - D0 >>= 15 (fixed-point)
        add.w   OBJ_ACCEL(a0),d0                ; $007110: $D068 $00A2 - D0 += acceleration
        move.w  d0,OBJ_SPEED_ADJ(a0)            ; $007114: $3140 $004A - Store speed-adjusted

; Copy position offset to obj+$44
        move.w  OBJ_POS_OFFSET(a0),OBJ_POS_COPY(a0) ; $007118: $3168 $009E $0044 - Copy

; Check mode flag for velocity calculation path
        move.w  OBJ_MODE_FLAG(a0),d0            ; $00711E: $3028 $00A0 - Check mode
        bne.s   .alt_velocity                   ; $007122: $660A       - Alternative if non-zero

; Standard velocity calculation (mode = 0)
        move.w  OBJ_VEL_MOD(a0),d0              ; $007124: $3028 $0094 - D0 = velocity mod
        asl.w   #3,d0                           ; $007128: $E740       - D0 <<= 3
        add.w   OBJ_SPEED_BASE(a0),d0           ; $00712A: $D068 $006E - D0 += speed base
.alt_velocity:
; Common tail (mode != 0 enters here with D0 = mode flag value)
        add.w   OBJ_VEL_COMP2(a0),d0            ; $00712E: $D068 $004C - D0 += vel comp
        move.w  d0,OBJ_VEL_COMP1(a0)            ; $007132: $3140 $0046 - Store

; Final velocity component calculation
        move.w  OBJ_ROT_SPEED(a0),d0            ; $007136: $3028 $008E - D0 = rotation speed
        asr.w   #8,d0                           ; $00713A: $E040       - D0 >>= 8
        neg.w   d0                              ; $00713C: $4440       - Negate
        muls.w  OBJ_SCALE(a0),d0                ; $00713E: $C1E8 $0004 - D0 *= scale
        asr.l   #5,d0                           ; $007142: $EA80       - D0 >>= 5
        move.w  d0,OBJ_VEL_COMP2(a0)            ; $007144: $3140 $004C - Store final velocity
        rts                                     ; $007148: $4E75

; ============================================================================
; SUMMARY
; ============================================================================
;
; angle_to_sine is the most frequently called function (29 calls/frame).
; It performs trigonometric lookups and velocity calculations for objects.
;
; Key operations:
; - Sine lookup from 1024-entry table at $93A02C
; - Cosine lookup from 1024-entry table at $93A42C
; - Handle negative angles by negating result
; - Calculate velocity components with fixed-point math
;
; Performance: ~80 cycles per call × 29 calls = ~2320 cycles/frame
;
; ============================================================================
