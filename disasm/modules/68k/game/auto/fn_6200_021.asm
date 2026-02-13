; ============================================================================
; fn_6200_021 — Steering Calculation Register-Safe Wrapper
; ROM Range: $006D8C-$006D9C (16 bytes)
; Saves all 15 registers (D0-D7/A0-A6) to stack, calls calc_steering
; at $006F98, then restores all registers. Allows steering calculation
; without clobbering caller's register state.
;
; Entry: A0 = entity base pointer (passed through to calc_steering)
; Uses: (all preserved)
; Confidence: high
; ============================================================================

fn_6200_021:
        MOVEM.L D0/D1/D2/D3/D4/D5/D6/D7/A0/A1/A2/A3/A4/A5/A6,-(A7); $006D8C
        JSR     $00886F98                       ; $006D90
        MOVEM.L (A7)+,D0/D1/D2/D3/D4/D5/D6/D7/A0/A1/A2/A3/A4/A5/A6; $006D96
        RTS                                     ; $006D9A
