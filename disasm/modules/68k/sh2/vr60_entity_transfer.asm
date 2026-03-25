; ============================================================================
; vr60_entity_transfer — VR60 Phase 3A: DREQ Transfer of Entity+Globals to SDRAM
; Size: 66 bytes
; ============================================================================
;
; Transfers 320 bytes (256B entity + 64B globals) from WRAM staging to
; SH2 SDRAM via DREQ FIFO. Uses cmd $3E on the Master SH2 which
; configures DMAC channel 0. Data lands at:
;   Entity:  $0600F20C (256 bytes)
;   Globals: $0600F30C (64 bytes)
;
; Protocol:
;   1. Set DREQ_LEN = $00A0 (160 words = 320 bytes)
;   2. Set DREQ mode = CPU write
;   3. Trigger cmd $3E via COMM0 ($01/$3E)
;   4. Wait for SH2 ACK (COMM1_LO bit 1)
;   5. Push 320 bytes to FIFO: entity (256B) + globals (64B)
;   6. DMAC drains FIFO to $0600F20C automatically
;
; Called from: state4_epilogue in code_2200.asm (after vr60_globals_stage)
; Entry: none (uses hardcoded addresses)
; Preserves: all (pushes/pops A1-A2)
; Clobbers: COMM0, COMM1 bit 1 (restored by SH2 handler)
; ============================================================================

BLOCK_COPY_256          equ     $008988EC       ; 128× MOVE.W (A1)+,(A2), 256 bytes

vr60_entity_transfer:
; --- Save registers used by block copy + globals loop ---
        movem.l d0/a1-a2,-(sp)                  ; 4B — save D0/A1/A2

; --- Set up DREQ for 320-byte transfer ---
        move.w  #$00A0,MARS_DREQ_LEN            ; 6B — 160 words = 320 bytes
        move.b  #$04,MARS_DREQ_CTRL+1           ; 6B — CPU write mode

; --- Trigger cmd $3E on Master SH2 ---
        move.b  #$3E,COMM0_LO                   ; 6B — dispatch index
        move.b  #$01,COMM0_HI                   ; 6B — trigger

; --- Wait for SH2 ACK (COMM1_LO bit 1) ---
.wait_ack:
        btst    #1,COMM1_LO                     ; 4B — poll ACK
        beq.s   .wait_ack                        ; 2B — spin until set
        bclr    #1,COMM1_LO                     ; 4B — clear ACK

; --- Push 320 bytes from staging area to FIFO ---
; Entity: 256 bytes from $FF6A00
        lea     $00FF6A00,a1                    ; 6B — entity staging source
        lea     MARS_FIFO,a2                    ; 6B — FIFO register
        jsr     BLOCK_COPY_256                  ; 6B — 128× MOVE.W (A1)+,(A2)
; Globals: 64 bytes from $FF6B00 (A1 auto-incremented to $FF6B00 by block_copy)
; block_copy does 128× MOVE.W (A1)+,(A2), so A1 = $FF6A00 + 256 = $FF6B00
; Now push remaining 64 bytes (32 words) manually
        moveq   #31,d0                          ; 2B — 32 words - 1
.globals_fifo:
        move.w  (a1)+,(a2)                      ; 2B — push word to FIFO
        dbra    d0,.globals_fifo                 ; 4B — loop 32 times

; --- Restore and return ---
        movem.l (sp)+,d0/a1-a2                  ; 4B — restore D0/A1/A2
        rts                                     ; 2B
; Total: 70 bytes
