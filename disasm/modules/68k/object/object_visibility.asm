; ============================================================================
; Object Visibility Functions ($002EC6 - $002F02)
; ============================================================================
;
; PURPOSE
; -------
; Functions for managing object visibility state. These check various
; flags to determine if an object should be rendered.
;
; OBJECT STRUCTURE OFFSETS
; ------------------------
; | Offset | Name     | Purpose                              |
; |--------|----------|--------------------------------------|
; | $00E5  | OBJ_FLAG | Object flags (bit 3 = visibility)    |
;
; OUTPUT BUFFER OFFSETS (A1)
; --------------------------
; | Offset | Purpose                                        |
; |--------|------------------------------------------------|
; | $0000  | Visibility slot 0                              |
; | $0014  | Visibility slot 1 ($14 = 20 bytes per slot)    |
; | $0028  | Visibility slot 2                              |
; | $003C  | Visibility slot 3                              |
; | $0050  | Visibility slot 4                              |
; | $0064  | Visibility slot 5                              |
;
; WORK RAM
; --------
; | Address    | Name           | Purpose                    |
; |------------|----------------|----------------------------|
; | $FFFFC31C  | VISIBILITY_FLAG| Global visibility control  |
;
; Dependencies: Object system initialization
; Related: obj_render_check, obj_transform_copy
; ============================================================================
; Format: Proper mnemonics with original bytes in comments for verification
; ============================================================================

; Object structure offsets
OBJ_FLAGS       equ     $00E5       ; Object flags byte

; Work RAM (sign-extended)
VISIBILITY_FLAG equ     $FFFFC31C   ; Global visibility control

; Visibility slot spacing
SLOT_SIZE       equ     $0014       ; 20 bytes between slots

; Object flag bits
VIS_BIT         equ     3           ; Visibility bit in OBJ_FLAGS

        org     $002EC6

; ============================================================================
; obj_visibility_check ($002EC6) - Check and Set Object Visibility
; Purpose: Sets visibility flags based on object state
; Called by: Render preparation functions
; Parameters:
;   A0 = Object data pointer
;   A1 = Visibility buffer pointer
; Returns: 6 visibility slots set to 0 or 1
;
; Algorithm:
;   If VISIBILITY_FLAG is set AND object has visibility bit:
;     Clear all 6 slots to 0 (hidden)
;   Else:
;     Set 5 slots to 1 (visible)
; ============================================================================

obj_visibility_check:
        tst.b   VISIBILITY_FLAG.w               ; $002EC6: $4A38 $C31C - Check global flag
        beq.s   .set_visible                    ; $002ECA: $6722       - Branch if not set

        btst    #VIS_BIT,OBJ_FLAGS(a0)          ; $002ECC: $0828 $0003 $00E5 - Check object flag
        beq.s   .set_visible                    ; $002ED2: $671A       - Branch if not set

; Object is hidden - clear all visibility slots
.set_hidden:
        moveq   #0,d0                           ; $002ED4: $7000       - Clear value
        move.w  d0,(a1)                         ; $002ED6: $3280       - Slot 0 = 0
        move.w  d0,SLOT_SIZE*1(a1)              ; $002ED8: $3340 $0014 - Slot 1 = 0
        move.w  d0,SLOT_SIZE*2(a1)              ; $002EDC: $3340 $0028 - Slot 2 = 0
        move.w  d0,SLOT_SIZE*3(a1)              ; $002EE0: $3340 $003C - Slot 3 = 0
        move.w  d0,SLOT_SIZE*4(a1)              ; $002EE4: $3340 $0050 - Slot 4 = 0
        move.w  d0,SLOT_SIZE*5(a1)              ; $002EE8: $3340 $0064 - Slot 5 = 0
        rts                                     ; $002EEC: $4E75

; Object is visible - set visibility slots
.set_visible:
        moveq   #1,d0                           ; $002EEE: $7001       - Visible value
        move.w  d0,(a1)                         ; $002EF0: $3280       - Slot 0 = 1
        move.w  d0,SLOT_SIZE*1(a1)              ; $002EF2: $3340 $0014 - Slot 1 = 1
        move.w  d0,SLOT_SIZE*2(a1)              ; $002EF6: $3340 $0028 - Slot 2 = 1
        move.w  d0,SLOT_SIZE*3(a1)              ; $002EFA: $3340 $003C - Slot 3 = 1
        move.w  d0,SLOT_SIZE*4(a1)              ; $002EFE: $3340 $0050 - Slot 4 = 1
        rts                                     ; $002F02: $4E75

; ============================================================================
; SUMMARY
; ============================================================================
;
; Function             | Address | Size | Purpose
; ---------------------+---------+------+---------------------------
; obj_visibility_check | $002EC6 | 60B  | Set 6 visibility slots
;
; This function manages object visibility for the rendering pipeline.
; Objects can be hidden by:
; 1. Global VISIBILITY_FLAG being set, AND
; 2. Object's visibility bit (bit 3 of OBJ_FLAGS) being set
;
; When hidden: 6 slots cleared to 0
; When visible: 5 slots set to 1 (slot 5 not set in visible path)
;
; Note: The asymmetry (6 slots hidden vs 5 visible) may be intentional
; for different rendering modes or a minor optimization.
;
; ============================================================================
