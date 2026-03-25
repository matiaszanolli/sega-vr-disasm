; ============================================================================
; vr60_entity_stage — Stage Player Entity for DREQ Transfer to SDRAM
; Size: 40 bytes
; ============================================================================
;
; Phase 3A: Copies 256 bytes of player entity 0 from $FF9000 (WRAM) to
; $FF6A00 (WRAM staging area, immediately after the 2560B DREQ source).
; When DREQ DMA is extended by 1 block copy call, the entity data
; piggybacks on the existing transfer and arrives at $0600CA00 (SDRAM).
;
; Uses MOVEM.L for fast 64-longword copy (256 bytes). A0 is preserved
; via push/pop since the orchestrator expects A0 = entity pointer.
;
; Staging address $FF6A00 verified free: between display entries ($FF6960)
; and entity tables ($FF9000). No code references this range.
;
; Called from: entity_render_pipeline Variant A (before entity_pos_update)
; Entry: A0 = entity base pointer (must be entity 0 = $FF9000 for staging)
; Preserves: A0, D0-D7 (MOVEM saves/restores)
; Clobbers: A1 (staging destination pointer)
; ============================================================================

VR60_ENTITY_STAGE_SRC    equ     $FF9000         ; player entity 0 (WRAM)
VR60_ENTITY_STAGE_DST    equ     $FF6A00         ; staging area (after DREQ source)
VR60_ENTITY_STAGE_SIZE   equ     256             ; bytes to copy (1 entity record)

vr60_entity_stage:
; --- Copy 256 bytes: $FF9000 → $FF6A00 using MOVEM.L (16 regs × 4B = 64B per pass, 4 passes) ---
        movem.l d0-d7/a0-a1,-(sp)              ; save all used regs (40 bytes on stack)
        lea     VR60_ENTITY_STAGE_SRC,a0        ; source
        lea     VR60_ENTITY_STAGE_DST,a1        ; destination
; --- Pass 1: bytes 0-63 ---
        movem.l (a0)+,d0-d7                    ; load 32 bytes
        movem.l d0-d7,(a1)                     ; store 32 bytes
        lea     32(a1),a1                       ; advance dest
        movem.l (a0)+,d0-d7                    ; load 32 bytes
        movem.l d0-d7,(a1)                     ; store 32 bytes
        lea     32(a1),a1
; --- Pass 2: bytes 64-127 ---
        movem.l (a0)+,d0-d7
        movem.l d0-d7,(a1)
        lea     32(a1),a1
        movem.l (a0)+,d0-d7
        movem.l d0-d7,(a1)
        lea     32(a1),a1
; --- Pass 3: bytes 128-191 ---
        movem.l (a0)+,d0-d7
        movem.l d0-d7,(a1)
        lea     32(a1),a1
        movem.l (a0)+,d0-d7
        movem.l d0-d7,(a1)
        lea     32(a1),a1
; --- Pass 4: bytes 192-255 ---
        movem.l (a0)+,d0-d7
        movem.l d0-d7,(a1)
        lea     32(a1),a1
        movem.l (a0)+,d0-d7
        movem.l d0-d7,(a1)
; --- Restore and return ---
        movem.l (sp)+,d0-d7/a0-a1              ; restore all regs
        rts
