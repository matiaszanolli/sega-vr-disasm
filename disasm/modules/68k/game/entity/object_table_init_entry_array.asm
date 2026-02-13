; ============================================================================
; Object Table Init — 256-Byte Entry Array
; ROM Range: $00CD4C-$00CD92 (70 bytes)
; Source: code_c200
; ============================================================================
;
; PURPOSE
; -------
; Initializes a 15-element object table at $FFFF9100, with each entry being
; 256 ($100) bytes. Data comes from two ROM sources selected by the current
; game mode ($C8A0).
;
; For each of the 15 entries, the function:
;   1. Loads a pointer from the primary ROM table into offset $18
;   2. Copies a word from the secondary ROM table into offset $C2
;   3. Writes sequential counters (wrapping 0-15) into offsets $A4 and $A6
;
; The counters D0 and D1 start at 0 and 2 respectively, incrementing with
; wrap-around at 16 (AND #$000F), providing staggered phase indices.
;
; ROM TABLES
; ----------
;   $00898A7C  Primary table index (array of long pointers, indexed by game mode)
;   $0093814E  Secondary table (flat word array, sequential read)
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC8A0  Game mode × 4 (word, used as long-pointer table index)
;   $FFFF9100  Object table base (15 entries × 256 bytes = 3840 bytes)
;
; Entry: No register inputs
; Exit:  15 object entries initialized at $FFFF9100
; Uses:  D0, D1, D7, A0, A1, A2, A3
; ============================================================================

object_table_init_entry_array:
; --- Look up primary ROM table by game mode ---
        lea     $00898A7C,a1                    ; $00CD4C: $43F9 $0089 $8A7C — primary table index
        move.w  ($FFFFC8A0).w,d7                ; $00CD52: $3E38 $C8A0 — game mode × 4
        movea.l (a1,d7.w),a1                    ; $00CD56: $2271 $7000 — A1 = table[mode]

; --- Set up loop parameters ---
        moveq   #$0E,d7                         ; $00CD5A: $7E0E — 15 iterations (0-14)
        lea     ($FFFF9100).w,a0                ; $00CD5C: $41F8 $9100 — object table base
        lea     $0093814E,a3                    ; $00CD60: $47F9 $0093 $814E — secondary table
        moveq   #0,d0                           ; $00CD66: $7000 — counter A (starts at 0)
        moveq   #2,d1                           ; $00CD68: $7202 — counter B (starts at 2)

; --- Main init loop ---
.init_loop:
        movea.l (a1)+,a2                        ; $00CD6A: $2459 — load pointer from primary table
        move.l  a2,$18(a0)                      ; $00CD6C: $214A $0018 — store pointer at offset $18
        move.w  (a3)+,$C2(a0)                   ; $00CD70: $315B $00C2 — copy secondary table word
        move.w  d0,$A4(a0)                      ; $00CD74: $3140 $00A4 — write counter A
        move.w  d1,$A6(a0)                      ; $00CD78: $3141 $00A6 — write counter B

; --- Advance counters with wrap-around ---
        addq.w  #1,d0                           ; $00CD7C: $5240
        addq.w  #1,d1                           ; $00CD7E: $5241
        andi.w  #$000F,d0                       ; $00CD80: $0240 $000F — wrap at 16
        andi.w  #$000F,d1                       ; $00CD84: $0241 $000F — wrap at 16

; --- Advance to next 256-byte entry ---
        lea     $100(a0),a0                     ; $00CD88: $41E8 $0100 — next entry
        dbf     d7,.init_loop                   ; $00CD8C: $51CF $FFDC — loop 15 times
        rts                                     ; $00CD90: $4E75
