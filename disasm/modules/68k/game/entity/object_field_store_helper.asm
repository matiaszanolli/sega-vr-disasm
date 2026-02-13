; ============================================================================
; Object Field Store Helper
; ROM Range: $00C9AE-$00C9B6 (8 bytes)
; Source: code_c200
; ============================================================================
;
; PURPOSE
; -------
; Stores a word value and a long pointer into an object entry. Used as a
; helper subroutine during object table initialization.
;
;   - Writes D0 (word) to the base of the object entry at (A1)
;   - Copies the next long from the ROM table pointer (A4) into offset $10
;     of the object entry, advancing A4 to the next table value
;
; Entry: D0 = word value to store at object base
;        A1 = object entry pointer
;        A4 = ROM table cursor (advanced by 4 after call)
; Exit:  Object fields written, A4 advanced
; Uses:  A4 (post-incremented)
; ============================================================================

object_field_store_helper:
        move.w  d0,(a1)                         ; $00C9AE: $3280 — store word at object base
        move.l  (a4)+,$10(a1)                   ; $00C9B0: $235C $0010 — copy long from ROM table
        rts                                     ; $00C9B4: $4E75
