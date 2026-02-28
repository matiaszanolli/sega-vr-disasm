; ============================================================================
; Object Spawn Counter + Table Setup
; ROM Range: $0083C6-$0083E4 (30 bytes)
; ============================================================================
; Loads and increments spawn counter ($A9E0), sets up table base
; addresses ($A9E3 → A1, $A800 → A2), then branches forward
; past this module to continue setup. The tail (BTST/BNE/RTS) is
; an alternate entry: tests object bit 6, falls through if set.
;
; Memory:
;   $FFFFA9E0 = spawn counter (byte, loaded then incremented)
;   $FFFFA9E3 = table base offset (address loaded into A1)
;   $FFFFA800 = object table base (address loaded into A2)
; Entry: A0 = object pointer | Exit: setup or guard | Uses: D0, A0-A2
; ============================================================================

object_spawn_counter_table_setup:
        moveq   #$00,d0                         ; $0083C6: $7000 — zero D0
        move.b  ($FFFFA9E0).w,d0                ; $0083C8: $1038 $A9E0 — load spawn counter
        addq.b  #1,($FFFFA9E0).w                ; $0083CC: $5238 $A9E0 — increment counter
        lea     ($FFFFA9E3).w,a1                ; $0083D0: $43F8 $A9E3 — table base offset
        lea     ($FFFFA800).w,a2                ; $0083D4: $45F8 $A800 — object table base
        bra.s   dual_time_display_orch+18       ; $0083D8: → setup continuation (past dispatch)
        btst    #6,$0002(a0)                    ; $0083DA: $0828 $0006 $0002 — test object flag bit 6
        bne.s   dual_time_display_orch          ; $0083E0: set → fall through to next fn
        rts                                     ; $0083E2: $4E75 — clear → return

