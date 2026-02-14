; ============================================================================
; Set V-INT Dispatch State + VDP Status Read
; ROM Range: $001A64-$001A72 (14 bytes)
; ============================================================================
; Two sub-entries: first sets V-INT dispatch state to $002C and jumps
; to a handler at $0020C6. Second (at $001A6E) reads VDP status.
;
; Memory:
;   $FFFFC87A = V-INT dispatch state (word, set to $002C)
; Entry 1: none | Entry 2: A5 = VDP control port
; Uses: D0, A5
; ============================================================================

set_v_int_dispatch_state_vdp_status_read:
        move.w  #$002C,($FFFFC87A).w           ; $001A64: $31FC $002C $C87A — set dispatch state
        jmp     sound_command_dispatch_sound_driver_call+70(pc); $4EFA $065A
        move.w  (A5),d0                         ; $001A6E: $3015 — read VDP status
        rts                                     ; $001A70: $4E75
