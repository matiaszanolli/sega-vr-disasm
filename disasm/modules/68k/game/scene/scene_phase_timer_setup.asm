; ============================================================================
; Scene Phase Timer — Setup
; ROM Range: $00C544-$00C56A (38 bytes)
; Source: code_c200
; ============================================================================
;
; PURPOSE
; -------
; Initializes a phase-based timer system that drives scene transitions. Reads
; the current state transition flag ($C8F5), computes an index, and looks up
; both a phase duration and a control mode from inline data tables located at
; the start of fn_c200_032.
;
; The phase system works as follows:
;   1. This function sets up the phase: duration counter in $C083, mode in $C0FC
;   2. c200_func_002 (fn_c200_032) counts down the phase each frame
;   3. When the phase counter reaches zero, the timeline sub-counter advances
;
; DATA TABLES (defined in fn_c200_032, accessed via PC-relative indexing)
; -----------------------------------------------------------------------
;   scene_phase_timer_tick_data_tables  10 bytes at $C56A — frame counts per phase
;   control_mode_table     9 words at $C574 — mode values (1-8, then 0)
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC082  Timeline sub-counter (word, incremented by 4 each phase start)
;   $FFFFC083  Phase countdown byte (loaded from duration table)
;   $FFFFC8F5  State transition flag (byte, read for phase index)
;   $FFFFC0FC  Control mode (word, loaded from mode table)
;   $00FF0008  Display control timer (word, set to $0034)
;
; Entry: No register inputs
; Exit:  Phase timer configured from state flag
; Uses:  D0
; ============================================================================

scene_phase_timer_setup:
; --- Advance timeline and compute phase index ---
        addq.b  #4,($FFFFC082).w                ; $00C544: $5838 $C082 — advance timeline sub-counter
        moveq   #0,d0                           ; $00C548: $7000
        move.b  ($FFFFC8F5).w,d0                ; $00C54A: $1038 $C8F5 — load state transition flag
        lsr.w   #1,d0                           ; $00C54E: $E248 — divide by 2
        subq.w  #1,d0                           ; $00C550: $5340 — zero-based index

; --- Look up phase duration and control mode from tables ---
        move.b  scene_phase_timer_tick_data_tables(pc,d0.w),($FFFFC083).w  ; $00C552: $11FB $0016 $C083 — set phase counter
        add.w   d0,d0                           ; $00C558: $D040 — word index (×2)
        move.w  control_mode_table(pc,d0.w),($FFFFC0FC).w    ; $00C55A: $31FB $0018 $C0FC — set control mode

; --- Set display control timer ---
        move.w  #$0034,$00FF0008                ; $00C560: $33FC $0034 $00FF $0008
        rts                                     ; $00C568: $4E75
