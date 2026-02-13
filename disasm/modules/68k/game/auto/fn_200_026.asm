; ============================================================================
; fn_200_026 — VDP Row Copy Dispatcher
; ROM Range: $001610-$00166C (92 bytes)
; ============================================================================
; Data prefix ($001610-$001637): VDP row copy parameter table. Each 12-byte
; entry contains: source ROM address (long), dest VRAM address (long),
; column count (word), row count (word).
;
; Code entry at $001638: Dispatches up to 4 VDP row copy operations
; packed in D0 (one byte per job). Iterates 4 times (D2=3), extracting
; each byte via ROR.L #8. For each non-zero byte: multiplies by 12
; ($000C) as index into parameter table at $00166C, loads parameters,
; then calls vdp_copy_rows at $0010C4.
;
; Entry: D0 = 4 packed job IDs (one per byte)
; Uses: D0, D1, D2, A0
; Calls:
;   $0010C4: vdp_copy_rows (JSR PC-relative)
; ============================================================================

fn_200_026:
        ORI.L  #$3B8E00FF,(A0)                  ; $001610
        MOVE.B  D0,D0                           ; $001616
        ORI.L  #$5A7E00FF,(A0)                  ; $001618
        MOVE.B  D0,D0                           ; $00161E
        ORI.L  #$77CE00FF,(A0)                  ; $001620
        MOVE.B  D0,D0                           ; $001626
        ORI.L  #$992E00FF,(A0)                  ; $001628
        MOVE.B  D0,D0                           ; $00162E
        ORI.L  #$C30E00FF,(A0)                  ; $001630
        MOVE.B  D0,D0                           ; $001636
        MOVE    #$2700,SR                       ; $001638
        MOVEQ   #$03,D2                         ; $00163C
.loc_002E:
        MOVEQ   #$00,D1                         ; $00163E
        MOVE.B  D0,D1                           ; $001640
        BEQ.S  .loc_0050                        ; $001642
        MULU    #$000C,D1                       ; $001644
        MOVEM.L D0/D1/D2,-(A7)                  ; $001648
        LEA     $00166C(PC,D1.W),A0             ; $00164C
        MOVE.W  -(A0),D2                        ; $001650
        MOVE.W  -(A0),D1                        ; $001652
        MOVE.L  -(A0),D0                        ; $001654
        MOVEA.L -(A0),A0                        ; $001656
        DC.W    $4EBA,$FA6A         ; JSR     $0010C4(PC); $001658
        MOVEM.L (A7)+,D0/D1/D2                  ; $00165C
.loc_0050:
        ROR.L  #8,D0                            ; $001660
        DBRA    D2,.loc_002E                    ; $001662
        MOVE    #$2300,SR                       ; $001666
        RTS                                     ; $00166A
