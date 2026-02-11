; ============================================================================
; Scene Phase Timer — Tick and Data Tables
; ROM Range: $00C56A-$00C592 (40 bytes)
; Source: code_c200
; ============================================================================
;
; PURPOSE
; -------
; Contains two inline data tables used by c200_func_001 (fn_c200_031) for
; phase-based scene timing, followed by the phase tick handler.
;
; The tick handler decrements the phase countdown byte ($C083) each frame.
; When it reaches zero, the timeline sub-counter ($C082) advances by 4,
; causing c200_func_001 to be called again to set up the next phase.
;
; DATA TABLES (accessed by fn_c200_031 via PC-relative indexed addressing)
; -----------------------------------------------------------------------
;   phase_duration_table (10 bytes):
;     Index 0: $28 (40 frames)   Index 5: $50 (80 frames)
;     Index 1: $3C (60 frames)   Index 6: $64 (100 frames)
;     Index 2: $64 (100 frames)  Index 7: $78 (120 frames)
;     Index 3: $64 (100 frames)  Index 8: $50 (80 frames)
;     Index 4: $64 (100 frames)  Index 9: $00 (sentinel)
;
;   control_mode_table (9 words):
;     Modes 1-8 for each phase, then 0 (sentinel)
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC082  Timeline sub-counter (word, advanced by 4 when phase expires)
;   $FFFFC083  Phase countdown byte (decremented each frame)
;
; Entry: No register inputs
; Exit:  Phase counter decremented; timeline advanced if phase expired
; Uses:  (none modified beyond RAM writes)
; ============================================================================

; --- Data tables (accessed by c200_func_001 via PC-relative indexed read) ---
phase_duration_table:
        dc.b    $28,$3C,$64,$64,$64,$50,$64,$78,$50,$00  ; $00C56A: 10 phase durations

control_mode_table:
        dc.w    $0001,$0002,$0003,$0004           ; $00C574: modes 1-4
        dc.w    $0005,$0006,$0007,$0008           ; $00C57C: modes 5-8
        dc.w    $0000                             ; $00C584: sentinel

; --- Phase tick handler ---
c200_func_002:
        subq.b  #1,($FFFFC083).w                ; $00C586: $5338 $C083 — decrement phase counter
        bne.s   .done                            ; $00C58A: $6604 — still counting
        addq.b  #4,($FFFFC082).w                ; $00C58C: $5838 $C082 — phase expired: advance timeline
.done:
        rts                                     ; $00C590: $4E75
