; ============================================================================
; Expansion ROM Section ($300000-$3FFFFF)
; 1MB of SH2 working space
; ============================================================================
;
; NOTE: This section is executed by SH2 processors, not the 68000.
; It can only contain:
; - SH2 code in dc.w format (raw opcodes)
; - Data literals
; - Padding (0xFF)
;
; CRITICAL CONSTRAINT:
; Phase 11 hook calls handler at 0x02300028 (file offset: 0x300000 + 0x28)
; Handler MUST be placed at exactly this offset (EVEN address required for SH2).
;
; COMM6 Signal Values:
;   0x0012 = Frame sync (increment COMM4)
;   0x0016 = Vertex transform (Phase 16)
;
; MEMORY LAYOUT:
;   0x300000-0x300027  Padding (40 bytes)
;   0x300028-0x30003F  Handler entry (even-aligned)
;   0x300040-0x30004F  Reserved
;   0x300050-0x3000FF  Reserved
;   0x300100-0x30015F  func_021_optimized (96 bytes)
;   0x300160-0x3FFFFF  Padding
;
; ============================================================================

        org     $300000

; ============================================================================
; PADDING: 0x300000-0x300027 (40 bytes)
; ============================================================================
        dcb.b   $28, $FF

; ============================================================================
; FRAME SYNC HANDLER: 0x300028 (EVEN-ALIGNED for SH2 instruction fetch)
; ============================================================================
; Simple handler that increments COMM4 and returns.
; NOTE: Phase 16 dispatch will be added later with hook modifications.
;
handler_frame_sync:
; Layout: 0x300028=mov.l, 0x30002A-2E=nops, 0x300030=literal
; EA = (PC & ~3) + 4 + d*4 = 0x300028 + 4 + d*4 = 0x30002C + d*4
; For literal at 0x300030: d = (0x300030 - 0x30002C) / 4 = 1
        dc.w    $D001                   ; MOV.L @(4,PC),R0 - loads COMM4 addr (d=1)
        dc.w    $0009                   ; NOP (padding for alignment)
        dc.w    $0009                   ; NOP
        dc.w    $0009                   ; NOP
        dc.l    $20004028               ; Literal: COMM4 address (4-byte aligned at 0x300030)
        dc.w    $6101                   ; MOV.W @R0,R1 - read COMM4 (16-bit register!)
        dc.w    $7101                   ; ADD #1,R1
        dc.w    $2011                   ; MOV.W R1,@R0 - write COMM4 (16-bit register!)
        dc.w    $000B                   ; RTS
        dc.w    $0009                   ; NOP (delay slot)

; ============================================================================
; PADDING TO func_021_optimized
; ============================================================================
; Current position: approximately 0x30003E (handler ends at 0x28 + 22 bytes)
; Pad to 0x300100 for nice alignment
        dcb.b   ($100 - $3E), $FF

; ============================================================================
; func_021_optimized: Coordinate Transform + Cull (with func_016 inlined)
; Entry point: 0x300100 (SH2 address: 0x02300100) - 4-BYTE ALIGNED
; ============================================================================
func_021_optimized:
        include "sh2/generated/func_021_optimized.inc"

; ============================================================================
; REMAINING EXPANSION ROM SPACE
; ============================================================================
        dcb.b   ($100000 - $160), $FF
