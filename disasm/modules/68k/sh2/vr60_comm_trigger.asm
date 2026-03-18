; ============================================================================
; vr60_comm_trigger — VR60 Phase 1B: COMM relay trigger
; ROM address: assigned by assembler (included in code_2200.asm)
; Size: 50 bytes
; ============================================================================
;
; Writes game state to COMM3-5, then triggers cmd $3F on Master SH2.
; Master SH2 handler copies COMM3-5 to SDRAM mailbox at $0600BC00.
;
; COMM register usage:
;   COMM0_HI ($A15120) = $01 trigger (written LAST — proven safe pattern)
;   COMM0_LO ($A15121) = $3F dispatch index (written BEFORE trigger)
;   COMM2    ($A15124) = UNTOUCHED (Slave polls COMM2_HI — must stay $00)
;   COMM3    ($A15126) = frame_counter from ($C964).w
;   COMM4    ($A15128) = game_state from ($C87E).w
;   COMM5    ($A1512A) = frame_toggle from ($C80C).w
;   COMM6-7            = UNTOUCHED (COMM7 = Slave doorbell, never write)
;
; Evidence for COMM safety:
;   COMM2_HI must stay $00 — definitions.asm:58 note, COMM_REGISTERS_HARDWARE_ANALYSIS.md
;   COMM7 doorbell only  — KNOWN_ISSUES.md, B-006 crash root cause
;   Params before trigger — B-004 proven pattern (cmd22_single_shot.asm comment)
;
; Evidence for data source addresses:
;   $C964 = FRAME_COUNTER — vint_handler.asm:59 (equ), :95 (addq.l #1)
;   $C87E = game state    — code_2200.asm:171 (addq.w #4), SCENE_HANDLER_ARCHITECTURE.md
;   $C80C = frame toggle  — code_2200.asm:159 (bchg #0)
;
; Called from: state4_epilogue in code_2200.asm via BSR.W
; Clobbers: nothing visible to caller (COMM regs are I/O, not caller state)
;
; Instruction sizes (68K, verified):
;   tst.b (abs.l)           = 2+4         = 6 bytes
;   bne.s                   = 2           = 2 bytes
;   move.w (abs.w),(abs.l)  = 2+2+4       = 8 bytes  (×3)
;   move.b #imm,(abs.l)     = 2+2+4       = 8 bytes  (×2)
;   rts                     = 2           = 2 bytes
;   Total: 6+2+(3×8)+(2×8)+2 = 50 bytes
; ============================================================================

vr60_comm_trigger:
; --- Wait for Master SH2 idle ---
.wait_idle:
        tst.b   COMM0_HI                       ; 6B — Master busy? ($A15120)
        bne.s   .wait_idle                      ; 2B — spin if non-zero

; --- Write game state to COMM3-5 (all params BEFORE trigger) ---
        move.w  ($FFFFC964).w,COMM3             ; 8B — frame counter → $A15126
        move.w  ($FFFFC87E).w,COMM4             ; 8B — game state   → $A15128
        move.w  ($FFFFC80C).w,COMM5             ; 8B — frame toggle → $A1512A

; --- Trigger cmd $3F (COMM0_LO before COMM0_HI, proven pattern) ---
        move.b  #$3F,COMM0_LO                  ; 8B — dispatch index ($A15121)
        move.b  #$01,COMM0_HI                  ; 8B — trigger flag ($A15120, LAST)

        rts                                     ; 2B
; Total: 50 bytes
