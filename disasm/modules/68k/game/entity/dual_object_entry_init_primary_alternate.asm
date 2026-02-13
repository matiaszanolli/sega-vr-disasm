; ============================================================================
; Dual Object Entry Init — Primary and Alternate Entries
; ROM Range: $00CE02-$00CE22 (32 bytes)
; Source: code_c200
; ============================================================================
;
; PURPOSE
; -------
; Initializes two specific object entries: the primary entry at $FFFF9000
; and an alternate entry at $FFFF9F00. Calls object_entry_data_copy (fn_c200_048)
; for the full table lookup + copy on the primary entry, then calls the
; shared copy_entry_fields subroutine directly for the alternate entry
; (reusing the data pointer A1 from the first call).
;
; After each copy, sets counter fields at offsets $A4/$A6:
;   Primary ($9000):  both set to $000F (maximum)
;   Alternate ($9F00): both set to $0000 (zero / D1)
;
; MEMORY VARIABLES
; ----------------
;   $FFFF9000  Primary object entry (256 bytes)
;   $FFFF9F00  Alternate object entry (256 bytes)
;
; Entry: D0 = entry offset selector (passed to object_entry_data_copy)
; Exit:  Both entries initialized with counter fields set
; Uses:  D0, D1, D2, A0, A1
; ============================================================================

dual_object_entry_init_primary_alternate:
; --- Initialize primary entry at $FFFF9000 ---
        moveq   #0,d1                           ; $00CE02: $7200 — D1 = 0 (for field $2C)
        bsr.s   object_entry_data_copy                   ; $00CE04: $611C — full table lookup + field copy

; --- Set primary entry counters to maximum ---
        move.w  #$000F,$A4(a0)                  ; $00CE06: $317C $000F $00A4 — counter A = 15
        move.w  #$000F,$A6(a0)                  ; $00CE0C: $317C $000F $00A6 — counter B = 15

; --- Initialize alternate entry at $FFFF9F00 ---
        lea     ($FFFF9F00).w,a0                ; $00CE12: $41F8 $9F00 — alternate entry base
        bsr.s   copy_entry_fields               ; $00CE16: $6124 — copy next data block

; --- Set alternate entry counters to zero ---
        move.w  d1,$A4(a0)                      ; $00CE18: $3141 $00A4 — counter A = 0
        move.w  d1,$A6(a0)                      ; $00CE1C: $3141 $00A6 — counter B = 0
        rts                                     ; $00CE20: $4E75
