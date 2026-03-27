; ============================================================================
; vr60_ai_entity_stage — Stage 15 AI Entities for DREQ Transfer to SDRAM
; Size: ~30 bytes
; ============================================================================
;
; Phase 4: Copies 3,840 bytes (15 × 256B) of AI entities from WRAM $FF9100
; to staging area $FF6B40 for DREQ transfer to SDRAM $06010000.
;
; Uses the existing block copy routine at $008988EC (128× MOVE.W (A1)+,(A2))
; called 15 times (once per 256B entity). Each call copies 256B.
;
; Actually — the staging area $FF6B40 + 3840 = $FF7B40, which is between
; $FF6B00 (globals) and $FF9000 (entity tables). Verify this is free.
; $FF6B40 to $FF7B3F = 4,096B. The display object array starts at $FF6218
; and goes to ~$FF6960. Globals are at $FF6B00-$FF6B3F. So $FF6B40-$FF8FFF
; (~9KB) is free. ✓
;
; HOWEVER: DREQ transfer of 3,840B takes ~15K 68K cycles for FIFO writes.
; This runs ONLY on the first racing frame ($C8D2 = 0). Acceptable.
;
; Called from: state4_epilogue (first frame only, before vr60_entity_transfer)
; Entry: none (uses hardcoded addresses)
; Preserves: all (pushes/pops D0-D7/A0-A1)
; ============================================================================

VR60_AI_STAGE_SRC       equ     $FF9100         ; AI entities WRAM (Table 1)
VR60_AI_STAGE_DST       equ     $FF6B40         ; staging area (after globals)
VR60_AI_STAGE_COUNT     equ     15              ; number of AI entities
VR60_AI_STAGE_SIZE      equ     3840            ; 15 × 256 bytes

vr60_ai_entity_stage:
; --- Copy 3840 bytes: $FF9100 → $FF6B40 ---
; Use the same MOVEM.L pattern as vr60_entity_stage (8 passes per entity)
        movem.l d0-d7/a0-a1,-(sp)
        lea     VR60_AI_STAGE_SRC,a0            ; source: AI entities
        lea     VR60_AI_STAGE_DST,a1            ; dest: staging area
        move.w  #(VR60_AI_STAGE_SIZE/4)-1,d0    ; 960 longwords - 1
.copy_loop:
        move.l  (a0)+,(a1)+                     ; copy 4 bytes
        dbra    d0,.copy_loop                    ; 960 iterations
        movem.l (sp)+,d0-d7/a0-a1
        rts
