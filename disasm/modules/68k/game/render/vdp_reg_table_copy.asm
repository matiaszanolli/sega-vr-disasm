; ============================================================================
; VDP Register Table Copy (with Shared Block Copy Subroutine)
; ROM Range: $00C9B6-$00C9E0 (42 bytes)
; Source: code_c200
; ============================================================================
;
; PURPOSE
; -------
; Copies a 512-byte VDP register configuration table from ROM to 32X work RAM.
; Selects between two ROM source tables based on the split-screen display flag
; (bit 3 of $C80E). The block copy subroutine at `copy_16b_blocks` is also
; used as a shared entry point by the sibling VDP init module (fn_c200_040).
;
; BLOCK COPY SUBROUTINE (copy_16b_blocks)
; ----------------------------------------
; Copies (D0+1) blocks of 16 bytes from A1 to A2 using four MOVE.L per block.
; This subroutine is shared across multiple VDP table loaders.
;
;   Entry:  A1 = source pointer
;           A2 = destination pointer
;           D0 = block count - 1 (loop counter for DBF)
;   Exit:   A1/A2 advanced past copied data
;   Uses:   D0 (decremented to -1)
;
; ROM SOURCE TABLES
; -----------------
;   $00898C80  Default VDP register table (512 bytes)
;   $00898F00  Alternate table for split-screen mode (512 bytes)
;
; MEMORY VARIABLES
; ----------------
;   $FFFFC80E  Display control flags (bit 3 = split-screen active)
;   $00FF6800  Destination: VDP register work area (512 bytes)
;
; Entry: No register inputs
; Exit:  VDP register table copied to $FF6800
; Uses:  D0, A1, A2
; ============================================================================

vdp_reg_table_copy:
; --- Select source table based on split-screen flag ---
        lea     $00898C80,a1                    ; $00C9B6: $43F9 $0089 $8C80 — default table
        btst    #3,($FFFFC80E).w                ; $00C9BC: $0838 $0003 $C80E — split-screen?
        beq.s   .load_dest                      ; $00C9C2: $6706 — no: use default
        lea     $00898F00,a1                    ; $00C9C4: $43F9 $0089 $8F00 — alternate table
.load_dest:
        lea     $00FF6800,a2                    ; $00C9CA: $45F9 $00FF $6800 — destination
        moveq   #$1F,d0                         ; $00C9D0: $701F — 32 blocks

; --- Shared block copy subroutine: copies (D0+1) × 16 bytes from A1 to A2 ---
; Called directly by BRA/BSR from fn_c200_040 entry points.
copy_16b_blocks:
        move.l  (a1)+,(a2)+                     ; $00C9D2: $24D9 — bytes 0-3
        move.l  (a1)+,(a2)+                     ; $00C9D4: $24D9 — bytes 4-7
        move.l  (a1)+,(a2)+                     ; $00C9D6: $24D9 — bytes 8-11
        move.l  (a1)+,(a2)+                     ; $00C9D8: $24D9 — bytes 12-15
        dbf     d0,copy_16b_blocks              ; $00C9DA: $51C8 $FFF6 — loop D0+1 times
        rts                                     ; $00C9DE: $4E75
