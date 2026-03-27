; ============================================================================
; vr60_ai_entity_transfer — DREQ Transfer of 15 AI Entities to SDRAM
; Size: ~60 bytes
; ============================================================================
;
; Phase 4: Transfers 3,840 bytes (15 × 256B) from WRAM staging ($FF6B40)
; to SH2 SDRAM ($06010000) via DREQ FIFO. Uses cmd $3E mode 2.
;
; Protocol:
;   1. Set DREQ_LEN = $0780 (1920 words = 3840 bytes)
;   2. Set DREQ mode = CPU write
;   3. Set COMM3_HI = $02 (AI entities mode)
;   4. Trigger cmd $3E via COMM0 ($01/$3E)
;   5. Wait for SH2 ACK (COMM1_LO bit 1)
;   6. Push 3840 bytes to FIFO from $FF6B40
;   7. DMAC drains FIFO to $06010000 automatically
;
; Called from: state4_epilogue (first frame only, after vr60_ai_entity_stage)
; Preserves: all (pushes/pops D0/A1-A2)
; ============================================================================

; BLOCK_COPY_256 = $008988EC already defined in vr60_entity_transfer.asm

vr60_ai_entity_transfer:
        movem.l d0/a1-a2,-(sp)

; --- Set up DREQ for 3840-byte transfer ---
        move.w  #$0780,MARS_DREQ_LEN            ; 1920 words = 3840 bytes
        move.b  #$04,MARS_DREQ_CTRL+1           ; CPU write mode

; --- Set mode = AI entities (COMM3_HI = $02) ---
        move.b  #$02,COMM3                      ; mode 2

; --- Trigger cmd $3E ---
        move.b  #$3E,COMM0_LO
        move.b  #$01,COMM0_HI                   ; trigger

; --- Wait for SH2 ACK ---
.wait_ack:
        btst    #1,COMM1_LO
        beq.s   .wait_ack
        bclr    #1,COMM1_LO

; --- Push 3840 bytes to FIFO ---
; Use 15 × BLOCK_COPY_256 for fast 256B chunks
        lea     $00FF6B40,a1                    ; staging source
        lea     MARS_FIFO,a2                    ; FIFO register
        moveq   #14,d0                          ; 15 entities - 1
.entity_fifo:
        jsr     BLOCK_COPY_256                  ; 128× MOVE.W = 256B
        dbra    d0,.entity_fifo

        movem.l (sp)+,d0/a1-a2
        rts
