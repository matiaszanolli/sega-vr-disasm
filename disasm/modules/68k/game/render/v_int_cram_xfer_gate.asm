; ============================================================================
; V-INT CRAM Transfer Gate
; ROM Range: $002878-$002890 (24 bytes)
; ============================================================================
; Checks the CRAM update flag at $C821. If set, loads the palette source
; (work RAM $FF6E00) and destination (MARS CRAM), then jumps to the
; palette copy routine at $0048D2. If clear, returns immediately.
;
; Memory: $FFFFC821 = CRAM update flag (byte, tested for nonzero)
; Entry: none | Exit: palette copied if flag set
; Uses: A1, A2
; ============================================================================

v_int_cram_xfer_gate:
        tst.b   ($FFFFC821).w                   ; $002878: $4A38 $C821 — CRAM update needed?
        beq.s   .done                           ; $00287C: $6710 — no: skip
        lea     $00FF6E00,a1                    ; $00287E: palette source (work RAM)
        lea     MARS_CRAM,a2                    ; $002884: palette destination (32X CRAM)
        jmp     triple_memory_copy+8(pc); $4EFA $2046
.done:
        rts                                     ; $00288E: $4E75
