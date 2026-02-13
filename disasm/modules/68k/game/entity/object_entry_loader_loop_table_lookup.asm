; ============================================================================
; Object Entry Loader — 16-Entry Loop with Table Lookup
; ROM Range: $00CDD2-$00CE02 (48 bytes)
; Source: code_c200
; ============================================================================
;
; PURPOSE
; -------
; Initializes 16 consecutive 256-byte object entries at $FFFF9000 by
; performing a double-indexed ROM table lookup and calling the shared
; copy_entry_fields subroutine (in fn_c200_048) for each entry.
;
; After the loop, clears a control long at $FFFF902C.
;
; ROM TABLE
; ---------
;   $009382BA  Table index (double-indexed: track × 4, then mode × 4 + D0)
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC8A0  Game mode × 4 (word, added to D0)
;   $FFFFC8CC  Track × 4 (word, primary index)
;   $FFFF9000  Object table base (16 entries × 256 bytes)
;   $FFFF902C  Control field (long, cleared after init)
;
; Entry: D0 = base entry offset (added to game mode for sub-index)
; Exit:  16 object entries loaded, control field cleared
; Uses:  D0, D2, D7, A0, A1
; ============================================================================

object_entry_loader_loop_table_lookup:
; --- Set up loop and resolve ROM data pointer ---
        moveq   #$0F,d7                         ; $00CDD2: $7E0F — 16 iterations (0-15)
        add.w   ($FFFFC8A0).w,d0                ; $00CDD4: $D078 $C8A0 — D0 += game mode × 4
        lea     ($FFFF9000).w,a0                ; $00CDD8: $41F8 $9000 — object table base
        move.w  ($FFFFC8CC).w,d2                ; $00CDDC: $3438 $C8CC — track × 4
        lea     $009382BA,a1                    ; $00CDE0: $43F9 $0093 $82BA — table index base
        movea.l (a1,d2.w),a1                    ; $00CDE6: $2271 $2000 — A1 = table[track]
        movea.l (a1,d0.w),a1                    ; $00CDEA: $2271 $0000 — A1 = subtable[mode+offset]

; --- Copy fields to each 256-byte entry ---
.load_loop:
        bsr.s   copy_entry_fields               ; $00CDEE: $614C — copy field data to entry
        lea     $100(a0),a0                     ; $00CDF0: $41E8 $0100 — advance to next entry
        dbf     d7,.load_loop                   ; $00CDF4: $51CF $FFF8 — loop 16 times

; --- Clear control field ---
        move.l  #$00000000,($FFFF902C).w        ; $00CDF8: $21FC $0000 $0000 $902C
        rts                                     ; $00CE00: $4E75
