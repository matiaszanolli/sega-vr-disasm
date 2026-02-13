; ============================================================================
; Scene State Dispatcher — Race Initialization Phases
; ROM Range: $00C662-$00C680 (30 bytes)
; Source: code_c200
; ============================================================================
;
; PURPOSE
; -------
; Dispatches to the appropriate race initialization handler based on the
; scene state byte ($C8F4). Uses a PC-relative indexed jump table with
; 68K CPU addresses (ROM base $880000 + file offset).
;
; STATE MACHINE
; -------------
;   State  0 ($C8F4=0):  Idle — returns immediately (no-op)
;   State  4 ($C8F4=4):  race_init_phase_1_flag_setup — race init phase 1 (flag setup)
;   State  8 ($C8F4=8):  race_init_phase_2_vdp_scroll_mode_config — race init phase 2 (VDP config)
;   State 12 ($C8F4=12): fn_c200_010 — race init phase 3 (scene setup)
;
; Each handler advances $C8F4 by 4, progressing through the state machine
; until the race scene is fully initialized.
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC8F4  Scene state byte (0/4/8/12, selects handler)
;
; Entry: No register inputs (A5 may be VDP control port for state 8)
; Exit:  Dispatched to appropriate handler
; Uses:  D0, A1
; ============================================================================

scene_state_disp_race_init_phases:
; --- Load scene state and dispatch ---
        moveq   #0,d0                           ; $00C662: $7000
        move.b  ($FFFFC8F4).w,d0                ; $00C664: $1038 $C8F4 — load scene state (0/4/8/12)
        movea.l .jump_table(pc,d0.w),a1         ; $00C668: $227B $0004 — look up handler address
        jmp     (a1)                            ; $00C66C: $4ED1 — dispatch

; --- Jump table: 68K CPU addresses (ROM base $880000 + file offset) ---
.jump_table:
        dc.l    .state_idle + $00880000         ; $00C66E: state 0 → RTS (no-op)
        dc.l    race_init_phase_1_flag_setup + $00880000       ; $00C672: state 4 → race init phase 1
        dc.l    race_init_phase_2_vdp_scroll_mode_config + $00880000       ; $00C676: state 8 → race init phase 2
        dc.l    fn_c200_010 + $00880000         ; $00C67A: state 12 → race init phase 3

.state_idle:
        rts                                     ; $00C67E: $4E75
