; ============================================================================
; Object Array Initialization from ROM Tables
; ROM Range: $00CC06-$00CC72 (108 bytes)
; Source: code_c200
; ============================================================================
;
; PURPOSE
; -------
; Initializes a 15-element object array in work RAM at $FF6218. Each object
; entry is 60 bytes ($3C). Data comes from two ROM tables, selected by an
; index value at $C8CC, plus a shared state pointer at $C73C.
;
; For each of the 15 objects, the function:
;   1. Writes constant 1 to three status fields (offsets $00, $14, $28)
;   2. Copies 3 longs from the primary ROM table (offsets $10, $24, $38)
;   3. Copies geometry data from the state pointer (offsets $16, $1A, $2A, $2E)
;
; After the main loop, a second loop copies one word per object from a
; secondary ROM table into offset $0E of each 60-byte entry.
;
; OBJECT ENTRY LAYOUT (60 bytes each)
; ------------------------------------
;   +$00  Status word 1 (set to 1)
;   +$0E  Secondary table value (word, from second loop)
;   +$10  Primary table value A (long)
;   +$14  Status word 2 (set to 1)
;   +$16  Geometry data A (long, from state pointer)
;   +$1A  Geometry data B (word, from state pointer)
;   +$24  Primary table value B (long)
;   +$28  Status word 3 (set to 1)
;   +$2A  Geometry data C (long, from state pointer)
;   +$2E  Geometry data D (word, from state pointer)
;   +$38  Primary table value C (long)
;
; ROM TABLES
; ----------
;   $008958B4  Primary table index (array of long pointers, indexed by D1)
;   $0093816C  Secondary table index (array of long pointers, indexed by D1)
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC73C  Geometry state pointer (long, read into A2 each iteration)
;   $FFFFC8CC  Table index selector (word, selects which ROM table entry)
;   $00FF6218  Object array base (15 entries × 60 bytes = 900 bytes)
;   $00FF6226  Secondary value base (offset $0E within object array)
;
; Entry: No register inputs (reads index from $C8CC)
; Exit:  15 objects initialized in $FF6218 area
; Uses:  D0, D1, D7, A1, A2, A3, A4
; ============================================================================

object_array_init_rom_tables:
; --- Look up primary ROM table by index ---
        lea     $008958B4,a4                    ; $00CC06: $49F9 $0089 $58B4 — table index base
        move.w  ($FFFFC8CC).w,d1                ; $00CC0C: $3238 $C8CC — load table selector
        movea.l (a4,d1.w),a4                    ; $00CC10: $2874 $1000 — A4 = table[d1]

; --- Set up loop parameters ---
        moveq   #1,d0                           ; $00CC14: $7001 — constant status value
        lea     $00FF6218,a1                    ; $00CC16: $43F9 $00FF $6218 — object array base
        moveq   #$0E,d7                         ; $00CC1C: $7E0E — 15 iterations (0-14)

; --- Main init loop: fill 15 object entries ---
.init_loop:
        movea.l ($FFFFC73C).w,a2                ; $00CC1E: $2478 $C73C — reload geometry pointer
        movea.l a4,a3                           ; $00CC22: $264C — reset ROM table cursor

; Write status fields (constant 1)
        move.w  d0,0(a1)                        ; $00CC24: $3340 $0000 — status 1 = 1
        move.w  d0,$14(a1)                      ; $00CC28: $3340 $0014 — status 2 = 1
        move.w  d0,$28(a1)                      ; $00CC2C: $3340 $0028 — status 3 = 1

; Copy primary table data (3 longs)
        move.l  (a3)+,$10(a1)                   ; $00CC30: $235B $0010 — table value A
        move.l  (a3)+,$24(a1)                   ; $00CC34: $235B $0024 — table value B
        move.l  (a3),$38(a1)                    ; $00CC38: $2353 $0038 — table value C

; Copy geometry data from state pointer
        move.l  (a2)+,$16(a1)                   ; $00CC3C: $235A $0016 — geometry A (long)
        move.w  (a2)+,$1A(a1)                   ; $00CC40: $335A $001A — geometry B (word)
        move.l  (a2)+,$2A(a1)                   ; $00CC44: $235A $002A — geometry C (long)
        move.w  (a2),$2E(a1)                    ; $00CC48: $3352 $002E — geometry D (word)

; Advance to next 60-byte entry
        lea     $3C(a1),a1                      ; $00CC4C: $43E9 $003C — next object
        dbf     d7,.init_loop                   ; $00CC50: $51CF $FFCC — loop 15 times

; --- Second loop: copy secondary table values ---
        lea     $00FF6226,a1                    ; $00CC54: $43F9 $00FF $6226 — secondary dest base
        lea     $0093816C,a2                    ; $00CC5A: $45F9 $0093 $816C — secondary table index
        movea.l (a2,d1.w),a2                    ; $00CC60: $2472 $1000 — A2 = table[d1]
        moveq   #$0E,d7                         ; $00CC64: $7E0E — 15 iterations
.copy_secondary:
        move.w  (a2)+,(a1)                      ; $00CC66: $329A — copy word from table
        lea     $3C(a1),a1                      ; $00CC68: $43E9 $003C — next object
        dbf     d7,.copy_secondary              ; $00CC6C: $51CF $FFF8 — loop 15 times
        rts                                     ; $00CC70: $4E75
