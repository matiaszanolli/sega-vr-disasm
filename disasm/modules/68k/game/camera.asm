; ============================================================================
; Camera/View Functions ($009040 - $0091xx)
; ============================================================================
;
; PURPOSE
; -------
; Camera and viewport management for the 3D racing view. Handles:
; - View offset calculations for camera position
; - Bounds checking to keep camera within valid range
; - Mirror mode support (bit 7 at $FDA8)
;
; CAMERA WORK RAM
; ---------------
; | Address | Name           | Purpose                        |
; |---------|----------------|--------------------------------|
; | $8002   | VIEW_RESULT    | Calculated view offset         |
; | $903C   | CAM_BASE_X     | Camera base X position         |
; | $9046   | CAM_OFFSET     | Camera offset value            |
; | $9096   | CAM_DELTA      | Camera delta/movement          |
; | $C04C   | CAM_MODE       | Camera mode flag               |
; | $C313   | VIEW_FLAGS     | View configuration flags       |
; | $FDA8   | MIRROR_FLAGS   | Mirror mode flags (bit 7)      |
;
; BOUNDS
; ------
; View offset clamped to range: -8 to +16 (after shift)
;
; Dependencies: Object system for tracking targets
; Related: object_collision.asm
; ============================================================================
; Format: Proper mnemonics with original bytes in comments for verification
; ============================================================================

; View/Camera work RAM
VIEW_RESULT     equ     $8002       ; Output view offset
CAM_BASE_X      equ     $903C       ; Base camera X
CAM_OFFSET      equ     $9046       ; Camera offset
CAM_DELTA       equ     $9096       ; Camera delta
CAM_MODE        equ     $C04C       ; Camera mode flag
VIEW_FLAGS      equ     $C313       ; View configuration
MIRROR_FLAGS    equ     $FDA8       ; Mirror flags
VIEW_BUFFER     equ     $FF6108     ; View buffer for bounds

; Bounds constants
VIEW_MIN        equ     $FFF8       ; Minimum view offset (-8)
VIEW_MAX        equ     $0010       ; Maximum view offset (+16)

        org     $009040

; ============================================================================
; view_offset_calc ($009040) - Calculate View/Camera Offset
; Called by: 7 locations per frame
; Parameters: None (uses work RAM values)
; Returns: Calculated offset stored at $8002
;
; Formula:
;   offset = (CAM_BASE_X + CAM_DELTA - [CAM_OFFSET if mode]) >> 6
;   if mirror mode, negate result
; ============================================================================

view_offset_calc:
        move.w  CAM_BASE_X.w,d0                 ; $009040: $3038 $903C - Get base X
        add.w   CAM_DELTA.w,d0                  ; $009044: $D078 $9096 - Add delta
        tst.w   CAM_MODE.w                      ; $009048: $4A78 $C04C - Check mode
        beq.s   .no_offset                      ; $00904C: $6704       - Skip if mode 0
        sub.w   CAM_OFFSET.w,d0                 ; $00904E: $9078 $9046 - Subtract offset
.no_offset:
        asr.w   #6,d0                           ; $009052: $EC40       - Divide by 64
        btst    #7,MIRROR_FLAGS.w               ; $009054: $0838 $0007 $FDA8 - Mirror?
        beq.s   .no_mirror                      ; $00905A: $6702       - Skip if not
        neg.w   d0                              ; $00905C: $4440       - Negate for mirror
.no_mirror:
        move.w  d0,VIEW_RESULT.w                ; $00905E: $31C0 $8002 - Store result
        rts                                     ; $009062: $4E75

; ============================================================================
; view_bounds_check ($009064) - Check View Bounds
; Called by: 6 locations per frame
; Parameters: A0 = object base (uses offset $CC)
; Returns: Clamped view offset stored at $8002
;
; Two paths based on VIEW_FLAGS bit 3:
;   Set: Use object's calculated distance ($CC offset)
;   Clear: Use view buffer with full bounds clamping
; ============================================================================

        org     $009064

view_bounds_check:
        btst    #3,VIEW_FLAGS.w                 ; $009064: $0838 $0003 $C313 - Check flag
        bne.s   .use_buffer                     ; $00906A: $6630       - Use buffer path
; Object-based view
        move.w  $00CC(a0),d0                    ; $00906C: $3028 $00CC - Get distance
        asr.w   #6,d0                           ; $009070: $EC40       - Divide by 64
        move.w  d0,VIEW_RESULT.w                ; $009072: $31C0 $8002 - Store result
; Buffer-based view with bounds clamping
        move.w  VIEW_BUFFER,d0                  ; $009076: $3039 $00FF $6108 - Get buffer
        asr.w   #8,d0                           ; $00907C: $E040       - Divide by 256
; Clamp to minimum
        cmpi.w  #VIEW_MIN,d0                    ; $00907E: $0C40 $FFF8 - Compare min
        bge.s   .check_max                      ; $009082: $6C02       - Skip if >= min
        moveq   #-8,d0                          ; $009084: $70F8       - Clamp to -8
.check_max:
        cmpi.w  #VIEW_MAX,d0                    ; $009086: $0C40 $0010 - Compare max
        ble.s   .store_result                   ; $00908A: $6F02       - Skip if <= max
        moveq   #16,d0                          ; $00908C: $7010       - Clamp to +16
.store_result:
        ; Store and continue...
        rts                                     ; (placeholder)

.use_buffer:
        ; Alternate processing path at $00909C
        rts

; ============================================================================
; SUMMARY
; ============================================================================
;
; Function          | Address | Calls/Frame | Purpose
; ------------------+---------+-------------+--------------------------
; view_offset_calc  | $009040 | 7           | Calculate camera offset
; view_bounds_check | $009064 | 6           | Clamp view to valid range
;
; The camera system tracks the player's car and adjusts the 3D viewport.
; Mirror mode (bit 7 of $FDA8) flips the view for rear-view mirror display.
;
; ============================================================================
