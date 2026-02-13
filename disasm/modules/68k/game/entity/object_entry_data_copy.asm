; ============================================================================
; Object Entry Data Copy (with Shared Field Copy Subroutine)
; ROM Range: $00CE22-$00CE56 (52 bytes)
; Source: code_c200
; ============================================================================
;
; PURPOSE
; -------
; Copies field data from a ROM table into a single 256-byte object entry.
; Performs a double-indexed ROM table lookup: first by track ($C8CC), then
; by a caller-provided offset in D0 (combined with game mode from $C8A0).
;
; The field copy subroutine at `copy_entry_fields` is shared across multiple
; object entry loaders (fn_c200_046, fn_c200_047, fn_c200_049).
;
; FIELD COPY SUBROUTINE (copy_entry_fields)
; ------------------------------------------
; Copies 5 words and 1 long from ROM data into an object entry:
;   +$30: word from (A1)+
;   +$32: word from (A1)+
;   +$34: word from (A1)+
;   +$3C: word from (A1)  (no advance — duplicated to $40)
;   +$40: word from (A1)+ (same value as $3C, then advance)
;   +$2C: long from D1    (caller-provided value)
;
;   Entry:  A0 = object entry pointer
;           A1 = ROM data source (advanced by 8 bytes)
;           D1 = value for offset $2C
;   Exit:   A1 advanced past copied data
;   Uses:   A1 (post-incremented)
;
; ROM TABLE
; ---------
;   $009382BA  Table index (array of long pointers, indexed by track then mode)
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC8A0  Game mode × 4 (word, added to D0 for sub-index)
;   $FFFFC8CC  Track × 4 (word, primary table index)
;   $FFFF9000  Object entry base (256 bytes per entry)
;
; Entry: D0 = entry offset selector (combined with game mode)
;        D1 = value for object field $2C
; Exit:  Object entry fields populated
; Uses:  D0, D2, A0, A1
; ============================================================================

object_entry_data_copy:
; --- Set up object entry and resolve ROM data pointer ---
        lea     ($FFFF9000).w,a0                ; $00CE22: $41F8 $9000 — object entry base
        add.w   ($FFFFC8A0).w,d0                ; $00CE26: $D078 $C8A0 — D0 += game mode × 4
        move.w  ($FFFFC8CC).w,d2                ; $00CE2A: $3438 $C8CC — track × 4
        lea     $009382BA,a1                    ; $00CE2E: $43F9 $0093 $82BA — table index base
        movea.l (a1,d2.w),a1                    ; $00CE34: $2271 $2000 — A1 = table[track]
        movea.l (a1,d0.w),a1                    ; $00CE38: $2271 $0000 — A1 = subtable[mode+offset]

; --- Shared field copy subroutine (called by fn_c200_046, 047, 049) ---
copy_entry_fields:
        move.w  (a1)+,$30(a0)                   ; $00CE3C: $3159 $0030 — field $30
        move.w  (a1)+,$32(a0)                   ; $00CE40: $3159 $0032 — field $32
        move.w  (a1)+,$34(a0)                   ; $00CE44: $3159 $0034 — field $34
        move.w  (a1),$3C(a0)                    ; $00CE48: $3151 $003C — field $3C (no advance)
        move.w  (a1)+,$40(a0)                   ; $00CE4C: $3159 $0040 — field $40 (same value, advance)
        move.l  d1,$2C(a0)                      ; $00CE50: $2141 $002C — field $2C from D1
        rts                                     ; $00CE54: $4E75
