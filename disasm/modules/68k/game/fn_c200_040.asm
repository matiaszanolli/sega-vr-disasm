; ============================================================================
; VDP Register Table Init — Multi-Entry Loader
; ROM Range: $00C9E0-$00CA4C (108 bytes)
; Source: code_c200
; ============================================================================
;
; PURPOSE
; -------
; Provides five entry points that each load a different VDP configuration
; table from ROM into the 32X VDP work area at $FF6800. Each entry sets
; up source address (A1), destination (A2), and block count (D0), then
; jumps to the shared copy routine `copy_16b_blocks` (defined in
; fn_c200_039, immediately preceding this module).
;
; Entry points 1-4 tail-jump to the copy routine (BRA.S) and return from
; there. Entry point 5 calls it as a subroutine (BSR.S), then zeroes out
; a control byte in each of the 24 VDP register slots and clears two
; status words before returning.
;
; ENTRY POINTS
; ------------
;   c200_func_010:       A1=$00899500, 32 blocks (512 bytes) — table A
;   vdp_load_table_b:    A1=$00899100, 32 blocks (512 bytes) — table B
;   vdp_load_table_c:    A1=$00899300, 32 blocks (512 bytes) — table C
;   vdp_load_table_d:    A1=$00899700,  8 blocks (128 bytes) — table D (short)
;   vdp_load_and_clear:  A1=$00898E80,  8 blocks (128 bytes) — table E + cleanup
;
; Cleanup (entry 5 only):
;   - Zeroes byte at base of each 16-byte VDP slot (24 slots)
;   - Clears $FF6740 and $FF672C (VDP control words)
;
; DEPENDENCIES
; ------------
;   copy_16b_blocks  (fn_c200_039) — shared 16-byte block copy subroutine
;
; MEMORY VARIABLES
; ----------------
;   $00FF6800  VDP register work area (destination for all entries)
;   $00FF6740  VDP control word 1 (cleared by entry 5)
;   $00FF672C  VDP control word 2 (cleared by entry 5)
;
; Entry: None (each entry point is self-contained)
; Exit:  VDP work area loaded; control words cleared (entry 5 only)
; Uses:  D0, D1, A1, A2
; ============================================================================

; --- Entry 1: Load VDP table A (32 × 16 = 512 bytes) ---
c200_func_010:
        lea     $00899500,a1                    ; $00C9E0: $43F9 $0089 $9500 — table A
        lea     $00FF6800,a2                    ; $00C9E6: $45F9 $00FF $6800
        moveq   #$1F,d0                         ; $00C9EC: $701F — 32 blocks
        bra.s   copy_16b_blocks                 ; $00C9EE: $60E2 — tail-call shared copy

; --- Entry 2: Load VDP table B (32 × 16 = 512 bytes) ---
vdp_load_table_b:
        lea     $00899100,a1                    ; $00C9F0: $43F9 $0089 $9100 — table B
        lea     $00FF6800,a2                    ; $00C9F6: $45F9 $00FF $6800
        moveq   #$1F,d0                         ; $00C9FC: $701F — 32 blocks
        bra.s   copy_16b_blocks                 ; $00C9FE: $60D2 — tail-call shared copy

; --- Entry 3: Load VDP table C (32 × 16 = 512 bytes) ---
vdp_load_table_c:
        lea     $00899300,a1                    ; $00CA00: $43F9 $0089 $9300 — table C
        lea     $00FF6800,a2                    ; $00CA06: $45F9 $00FF $6800
        moveq   #$1F,d0                         ; $00CA0C: $701F — 32 blocks
        bra.s   copy_16b_blocks                 ; $00CA0E: $60C2 — tail-call shared copy

; --- Entry 4: Load VDP table D (8 × 16 = 128 bytes) ---
vdp_load_table_d:
        lea     $00899700,a1                    ; $00CA10: $43F9 $0089 $9700 — table D (short)
        lea     $00FF6800,a2                    ; $00CA16: $45F9 $00FF $6800
        moveq   #$07,d0                         ; $00CA1C: $7007 — 8 blocks
        bra.s   copy_16b_blocks                 ; $00CA1E: $60B2 — tail-call shared copy

; --- Entry 5: Load VDP table E (128 bytes) + zero control bytes ---
vdp_load_and_clear:
        lea     $00898E80,a1                    ; $00CA20: $43F9 $0089 $8E80 — table E
        lea     $00FF6800,a2                    ; $00CA26: $45F9 $00FF $6800
        moveq   #$07,d0                         ; $00CA2C: $7007 — 8 blocks
        bsr.s   copy_16b_blocks                 ; $00CA2E: $61A2 — call shared copy, return here

; --- Clear control byte at base of each 16-byte VDP slot ---
; A2 now points past the copied data; we reuse it to walk 24 slots
        moveq   #0,d1                           ; $00CA30: $7200 — zero value
        moveq   #$17,d0                         ; $00CA32: $7017 — 24 iterations (0-23)
.clear_loop:
        move.b  d1,(a2)                         ; $00CA34: $1481 — zero control byte
        lea     16(a2),a2                       ; $00CA36: $45EA $0010 — advance to next slot
        dbf     d0,.clear_loop                  ; $00CA3A: $51C8 $FFF8

; --- Clear VDP control words ---
        move.w  d1,$00FF6740                    ; $00CA3E: $33C1 $00FF $6740 — clear control 1
        move.w  d1,$00FF672C                    ; $00CA44: $33C1 $00FF $672C — clear control 2
        rts                                     ; $00CA4A: $4E75
