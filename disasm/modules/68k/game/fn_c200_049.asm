; ============================================================================
; Object Entries Reset — 16-Entry Init from Fixed Table
; ROM Range: $00CE56-$00CE76 (32 bytes)
; Source: code_c200
; ============================================================================
;
; PURPOSE
; -------
; Initializes 16 consecutive 256-byte object entries at $FFFF9000 using
; data from a fixed ROM table at $00938EAE. Unlike fn_c200_046 which does
; a double-indexed lookup by track and mode, this function always uses the
; same source data (a default/reset configuration).
;
; Calls the shared copy_entry_fields subroutine (in fn_c200_048) for each
; entry, then clears the control long at $FFFF902C.
;
; ROM TABLE
; ---------
;   $00938EAE  Fixed field data source (sequential read by copy_entry_fields)
;
; MEMORY VARIABLES
; ----------------
;   $FFFF9000  Object table base (16 entries × 256 bytes)
;   $FFFF902C  Control field (long, cleared after init)
;
; Entry: No register inputs
; Exit:  16 object entries reset, control field cleared
; Uses:  D7, A0, A1
; ============================================================================

c200_func_019:
; --- Set up loop ---
        moveq   #$0F,d7                         ; $00CE56: $7E0F — 16 iterations (0-15)
        lea     ($FFFF9000).w,a0                ; $00CE58: $41F8 $9000 — object table base
        lea     $00938EAE,a1                    ; $00CE5C: $43F9 $0093 $8EAE — fixed ROM data

; --- Copy fields to each entry ---
.reset_loop:
        bsr.s   copy_entry_fields               ; $00CE62: $61D8 — copy field data to entry
        lea     $100(a0),a0                     ; $00CE64: $41E8 $0100 — advance to next entry
        dbf     d7,.reset_loop                  ; $00CE68: $51CF $FFF8 — loop 16 times

; --- Clear control field ---
        move.l  #$00000000,($FFFF902C).w        ; $00CE6C: $21FC $0000 $0000 $902C
        rts                                     ; $00CE74: $4E75
