; ============================================================================
; Screen Coordinate Calculation Functions ($0071A6 - $007246)
; ============================================================================
;
; PURPOSE
; -------
; Calculates screen coordinates for 3D objects, mapping world positions
; to 2D screen locations for rendering. Called 9 times per frame.
;
; OBJECT STRUCTURE OFFSETS
; ------------------------
; | Offset | Size | Name         | Purpose                         |
; |--------|------|--------------|--------------------------------|
; | $001D  | B    | obj_type     | Object type for table lookup    |
; | $0030  | W    | world_y      | World Y position                |
; | $0034  | W    | world_x      | World X position                |
; | $00CA  | W    | screen_idx   | Screen position index           |
; | $00CC  | W    | depth_val    | Depth value for perspective     |
;
; WORK RAM
; --------
; | Address    | Name           | Purpose                        |
; |------------|----------------|--------------------------------|
; | $FFFFC060  | VIEW_MODE      | Current view mode (word)       |
; | $FF6000    | COORD_BUFFER   | Screen coordinate buffer       |
; | $FF610E    | COORD_COUNT    | Number of calculated coords    |
;
; ROM TABLES
; ----------
; | Address    | Name           | Purpose                        |
; |------------|----------------|--------------------------------|
; | $0089A0D4  | DEPTH_TABLE    | Depth-to-index lookup          |
; | $0089A434  | ALT_TABLE      | Alternative depth table        |
; | $007248    | MODE_TABLES    | View mode table pointers       |
;
; Dependencies: Object system, view setup
; Related: sprite_system.asm, object_system.asm
; ============================================================================
; Format: Proper mnemonics with original bytes in comments for verification
; ============================================================================

; Object structure offsets
OBJ_TYPE_B      equ     $001D       ; Object type byte
OBJ_WORLD_Y     equ     $0030       ; World Y position
OBJ_WORLD_X     equ     $0034       ; World X position
OBJ_SCREEN_IDX  equ     $00CA       ; Screen position index
OBJ_DEPTH       equ     $00CC       ; Depth value

; Work RAM
VIEW_MODE       equ     $FFFFC060   ; View mode
COORD_BUFFER    equ     $00FF6000   ; Coordinate buffer
COORD_COUNT     equ     $00FF610E   ; Coordinate count

; ROM tables
DEPTH_TABLE     equ     $0089A0D4   ; Main depth table
ALT_DEPTH_TABLE equ     $0089A434   ; Alternative table

; View modes
VIEW_MODE_4     equ     $0004       ; Special view mode

; Sentinel value for invalid coordinates
INVALID_COORD   equ     $2207FFFE   ; End-of-list marker

        org     $0071A6

; ============================================================================
; obj_screen_coord ($0071A6) - Calculate Object Screen Position
; Called by: 9 locations per frame (render preparation)
; Parameters: A0 = object base pointer
; Returns:
;   Updates object+$CA with screen index
;   Writes visible sprite list to COORD_BUFFER
;   Updates COORD_COUNT
;
; Algorithm:
;   1. Load world Y and X positions
;   2. Calculate screen index from Y/X with perspective
;   3. Look up depth table based on object type
;   4. Select view mode table
;   5. Build sprite list from table entries
; ============================================================================

obj_screen_coord:
        move.l  a4,-(sp)                        ; $0071A6: $2F0C       - Save A4

; Calculate base screen index from world position
        move.w  #$0400,d1                       ; $0071A8: $323C $0400 - Base value (1024)
        move.w  OBJ_WORLD_Y(a0),d2              ; $0071AC: $3428 $0030 - Get Y position
        asr.w   #4,d2                           ; $0071B0: $E842       - D2 /= 16
        add.w   d1,d2                           ; $0071B2: $D441       - D2 += base
        asr.w   #6,d2                           ; $0071B4: $EC42       - D2 /= 64
        move.w  OBJ_WORLD_X(a0),d3              ; $0071B6: $3628 $0034 - Get X position
        asr.w   #4,d3                           ; $0071BA: $E843       - D3 /= 16
        sub.w   d3,d1                           ; $0071BC: $9243       - D1 -= X component
        andi.w  #$FFC0,d1                       ; $0071BE: $0241 $FFC0 - Mask to 64-byte boundary
        asr.w   #1,d1                           ; $0071C2: $E241       - D1 /= 2
        add.w   d2,d1                           ; $0071C4: $D242       - D1 += Y component
        add.w   d1,d1                           ; $0071C6: $D241       - D1 *= 2
        add.w   d1,d1                           ; $0071C8: $D241       - D1 *= 2 (total *4)
        move.w  d1,OBJ_SCREEN_IDX(a0)           ; $0071CA: $3140 $00CA - Store screen index

; Calculate depth table offset
        moveq   #0,d0                           ; $0071CE: $7000       - Clear D0
        move.w  OBJ_DEPTH(a0),d0                ; $0071D0: $3028 $00CC - Get depth
        asl.l   #6,d0                           ; $0071D4: $ED80       - Shift for index
        swap    d0                              ; $0071D6: $4840       - Get high word
        andi.w  #$003C,d0                       ; $0071D8: $0240 $003C - Mask to table offset

; Select depth table based on view mode
        lea     DEPTH_TABLE,a3                  ; $0071DC: $47F9 $0089 $A0D4 - Main table
        move.w  VIEW_MODE.w,d2                  ; $0071E2: $3438 $C060 - Get view mode
        cmpi.w  #VIEW_MODE_4,d2                 ; $0071E6: $0C42 $0004 - Special mode?
        bne.s   .use_main_table                 ; $0071EA: $6616       - Use main if not

; Check object type for alternative table
        cmpi.b  #$88,OBJ_TYPE_B(a0)             ; $0071EC: $0C28 $0088 $001D - Type >= $88?
        blt.s   .use_main_table                 ; $0071F2: $6D0E       - No, use main
        cmpi.b  #$98,OBJ_TYPE_B(a0)             ; $0071F4: $0C28 $0098 $001D - Type <= $98?
        bgt.s   .use_main_table                 ; $0071FA: $6E06       - No, use main
        lea     ALT_DEPTH_TABLE,a3              ; $0071FC: $47F9 $0089 $A434 - Alt table

.use_main_table:
; Look up in depth table
        movea.l (a3,d0.w),a3                    ; $007202: $2673 $0000 - Get table entry

; Select view mode table
        move.l  #INVALID_COORD,d3               ; $007206: $263C $2207 $FFFE - Sentinel
        lea     .mode_tables(pc),a1             ; $00720C: $43FA $003A - Mode table
        movea.l (a1,d2.w),a1                    ; $007210: $2271 $2000 - Get mode table

; Build sprite list
        lea     COORD_BUFFER,a2                 ; $007214: $45F9 $00FF $6000 - Output buffer
        moveq   #0,d4                           ; $00721A: $7800       - Clear counter

; Get first entry
        movea.l (a1,d1.w),a4                    ; $00721C: $2871 $1000 - Get table entry
        cmpa.l  d3,a4                           ; $007220: $B9C3       - Is sentinel?
        beq.s   .next_entry                     ; $007222: $6704       - Skip if invalid
        move.l  a4,(a2)+                        ; $007224: $24CC       - Store sprite
        addq.w  #1,d4                           ; $007226: $5244       - Increment count

.next_entry:
        move.w  (a3)+,d7                        ; $007228: $3E1B       - Get entry count

.sprite_loop:
        move.w  d1,d0                           ; $00722A: $3001       - Copy base index
        add.w   (a3)+,d0                        ; $00722C: $D05B       - Add offset
        movea.l (a1,d0.w),a4                    ; $00722E: $2871 $0000 - Get table entry
        cmpa.l  d3,a4                           ; $007232: $B9C3       - Is sentinel?
        beq.s   .skip_sprite                    ; $007234: $6704       - Skip if invalid
        move.l  a4,(a2)+                        ; $007236: $24CC       - Store sprite
        addq.w  #1,d4                           ; $007238: $5244       - Increment count

.skip_sprite:
        dbra    d7,.sprite_loop                 ; $00723A: $51CF $FFEE - Loop

; Store count and return
        move.w  d4,COORD_COUNT                  ; $00723E: $33C4 $00FF $610E - Store count
        movea.l (sp)+,a4                        ; $007244: $285F       - Restore A4
        rts                                     ; $007246: $4E75

; View mode table pointers (indexed by view mode * 4)
.mode_tables:
        dc.l    $0095C000                       ; $007248: Mode 0 table
        dc.l    $0095D000                       ; $00724C: Mode 1 table
        dc.l    $0095E000                       ; $007250: Mode 2 table
        dc.l    $0095F000                       ; $007254: Mode 3 table
        dc.l    $00960000                       ; $007258: Mode 4 table

; ============================================================================
; SUMMARY
; ============================================================================
;
; obj_screen_coord maps 3D world coordinates to 2D screen positions.
;
; Key calculations:
; - Y/X world position → screen index (with perspective)
; - Depth value → table lookup offset
; - Object type → table selection (standard vs alternative)
; - View mode → visibility table
;
; Called 9 times per frame = ~450 cycles/frame
;
; ============================================================================
