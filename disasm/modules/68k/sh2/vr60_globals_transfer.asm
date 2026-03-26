; ============================================================================
; vr60_globals_transfer — VR60 Phase 3B: DREQ Transfer of Globals-Only to SDRAM
; Size: ~56 bytes
; ============================================================================
;
; Transfers 64 bytes of globals from WRAM staging ($FF6B00) to SH2 SDRAM
; ($0600F30C) via DREQ FIFO. Uses cmd $3E mode 1 (COMM3_HI = $01).
;
; Protocol:
;   1. Set DREQ_LEN = $0020 (32 words = 64 bytes)
;   2. Set DREQ mode = CPU write
;   3. Set COMM3_HI = $01 (globals-only mode)
;   4. Trigger cmd $3E via COMM0 ($01/$3E)
;   5. Wait for SH2 ACK (COMM1_LO bit 1)
;   6. Push 64 bytes to FIFO from $FF6B00
;   7. DMAC drains FIFO to $0600F30C automatically
;
; Called from: state4_epilogue (subsequent frames, after vr60_globals_stage)
; Preserves: all (pushes/pops D0/A1-A2)
; Clobbers: COMM0, COMM3_HI, COMM1 bit 1 (restored by SH2 handler)
; ============================================================================

vr60_globals_transfer:
; --- Save registers used by FIFO loop ---
        movem.l d0/a1-a2,-(sp)                 ; 4B — save D0/A1/A2

; --- Set up DREQ for 64-byte transfer ---
        move.w  #$0020,MARS_DREQ_LEN            ; 6B — 32 words = 64 bytes
        move.b  #$04,MARS_DREQ_CTRL+1           ; 6B — CPU write mode

; --- Set mode = globals-only (COMM3_HI = $01) ---
        move.b  #$01,COMM3                      ; 6B — mode 1

; --- Trigger cmd $3E on Master SH2 ---
        move.b  #$3E,COMM0_LO                   ; 6B — dispatch index
        move.b  #$01,COMM0_HI                   ; 6B — trigger

; --- Wait for SH2 ACK (COMM1_LO bit 1) ---
.wait_ack:
        btst    #1,COMM1_LO                     ; 4B — poll ACK
        beq.s   .wait_ack                        ; 2B — spin until set
        bclr    #1,COMM1_LO                     ; 4B — clear ACK

; --- Push 64 bytes from globals staging to FIFO ---
        lea     $00FF6B00,a1                    ; 6B — globals staging source
        lea     MARS_FIFO,a2                    ; 6B — FIFO register
        moveq   #31,d0                          ; 2B — 32 words - 1
.globals_fifo:
        move.w  (a1)+,(a2)                      ; 2B — push word to FIFO
        dbra    d0,.globals_fifo                 ; 4B — loop 32 times

; --- Restore and return ---
        movem.l (sp)+,d0/a1-a2                  ; 4B — restore D0/A1/A2
        rts                                     ; 2B
; Total: ~64 bytes
